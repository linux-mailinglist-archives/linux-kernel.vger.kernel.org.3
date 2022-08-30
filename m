Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 511D35A63F3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 14:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbiH3MwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 08:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiH3MwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 08:52:11 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17CEC132864;
        Tue, 30 Aug 2022 05:52:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1870DCE1B34;
        Tue, 30 Aug 2022 12:51:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0593EC433D6;
        Tue, 30 Aug 2022 12:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661863917;
        bh=uQwsjOEEvKxUtN5MGCda/ZtMmO941N6I7Hy3e+MegMs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LGLfRsRANz+s3vvjGZfhqJI5QTM5lGUQOE2d93wko531Qlf9kY6diihD0vLELQ3op
         igHWYSR/PR9HOyQf/o7Jg1RwEIWfePRHi/ppUkLGjQa1/fQA8MBEn/5EgwKeGd44FP
         8IutILw5rzuYEYVRQTVL5L9aIGYU8rxpCs1nMB4Q=
Date:   Tue, 30 Aug 2022 14:51:54 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Linyu Yuan <quic_linyyuan@quicinc.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Takashi Iwai <tiwai@suse.de>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION 5.19] NULL dereference by ucsi_acpi driver
Message-ID: <Yw4H6rbVcu7Aaaa/@kroah.com>
References: <87r11cmbx0.wl-tiwai@suse.de>
 <YwEqtGB2WldUeiEN@kroah.com>
 <09f1204c-1256-e737-b769-be899870c946@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <09f1204c-1256-e737-b769-be899870c946@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 10:44:26AM +0800, Linyu Yuan wrote:
> 
> On 8/21/2022 2:40 AM, Greg Kroah-Hartman wrote:
> > On Fri, Aug 19, 2022 at 06:32:43PM +0200, Takashi Iwai wrote:
> > > Hi,
> > > 
> > > we've got multiple reports about 5.19 kernel starting crashing after
> > > some time, and this turned out to be triggered by ucsi_acpi driver.
> > > The details are found in:
> > >    https://bugzilla.suse.com/show_bug.cgi?id=1202386
> > > 
> > > The culprit seems to be the commit 87d0e2f41b8c
> > >      usb: typec: ucsi: add a common function ucsi_unregister_connectors()
> > Adding Heikki to the thread...
> > 
> > > This commit looks as if it were a harmless cleanup, but this failed in
> > > a subtle way.  Namely, in the error scenario, the driver gets an error
> > > at ucsi_register_altmodes(), and goes to the error handling to release
> > > the resources.  Through this refactoring, the release part was unified
> > > to a funciton ucsi_unregister_connectors().  And there, it has a NULL
> > > check of con->wq, and it bails out the loop if it's NULL.
> > > Meanwhile, ucsi_register_port() itself still calls destroy_workqueue()
> > > and clear con->wq at its error path.  This ended up in the leftover
> > > power supply device with the uninitialized / cleared device.
> > > 
> > > It was confirmed that the problem could be avoided by a simple
> > > revert.
> > I'll be glad to revert this now, unless Heikki thinks:
> > 
> > > I guess another fix could be removing the part clearing con->wq, i.e.
> > > 
> > > --- a/drivers/usb/typec/ucsi/ucsi.c
> > > +++ b/drivers/usb/typec/ucsi/ucsi.c
> > > @@ -1192,11 +1192,6 @@ static int ucsi_register_port(struct ucsi *ucsi, int index)
> > >   out_unlock:
> > >   	mutex_unlock(&con->lock);
> > > -	if (ret && con->wq) {
> > > -		destroy_workqueue(con->wq);
> > > -		con->wq = NULL;
> > > -	}
> > > -
> > >   	return ret;
> > >   }
> > > 
> > > ... but it's totally untested and I'm not entirely sure whether it's
> > > better.
> 
> this part is original code, yes, but when I make the change you mentioned,
> 
> as in the function ucsi_unregister_connectors(),  just use con->wq to
> represent which connector initialized previous,
> 
> indeed if we clear it in ucsi_register_port(), something will left unclear.
> 
> please send a patch to fix it.
> 
> I think your change is good.

Ok, can someone send me a patch to apply to the tree for this?

thanks,

greg k-h
