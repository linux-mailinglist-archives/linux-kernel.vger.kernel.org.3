Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1EED59D168
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 08:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240738AbiHWGlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 02:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240289AbiHWGlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 02:41:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC315D0FB;
        Mon, 22 Aug 2022 23:41:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53C116135D;
        Tue, 23 Aug 2022 06:41:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F31FC433D6;
        Tue, 23 Aug 2022 06:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661236863;
        bh=TEjHqoJRQKqBs1CvoLk/jyZqKWxhtZ0i7TW4trVkfvY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UKRvsF5ascVy+JoHw6y8j5goWpPeewzmsoqYwVzTpLohn1YgRwARIXLpY2Na+hLyV
         tQ53QafwdafWUx8TbBVBE7DJNCaSPKXbTAmeevnkCcc/ueTHqxxjSSh68OIVmlobyg
         ZghJWtINH3xA9qGc26kZvwaX+28bvMlSy8FhCOR8=
Date:   Tue, 23 Aug 2022 08:41:00 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Linyu Yuan <quic_linyyuan@quicinc.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Takashi Iwai <tiwai@suse.de>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION 5.19] NULL dereference by ucsi_acpi driver
Message-ID: <YwR2fNA4s0rWX2sL@kroah.com>
References: <87r11cmbx0.wl-tiwai@suse.de>
 <YwEqtGB2WldUeiEN@kroah.com>
 <YwODjnYQD/KjxXdw@kuha.fi.intel.com>
 <5e17fc89-6056-076c-0c4e-dac7f312792c@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e17fc89-6056-076c-0c4e-dac7f312792c@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 10:26:59AM +0800, Linyu Yuan wrote:
> 
> On 8/22/2022 9:24 PM, Heikki Krogerus wrote:
> > Hi,
> > 
> > On Sat, Aug 20, 2022 at 08:40:52PM +0200, Greg Kroah-Hartman wrote:
> > > On Fri, Aug 19, 2022 at 06:32:43PM +0200, Takashi Iwai wrote:
> > > > Hi,
> > > > 
> > > > we've got multiple reports about 5.19 kernel starting crashing after
> > > > some time, and this turned out to be triggered by ucsi_acpi driver.
> > > > The details are found in:
> > > >    https://bugzilla.suse.com/show_bug.cgi?id=1202386
> > > > 
> > > > The culprit seems to be the commit 87d0e2f41b8c
> > > >      usb: typec: ucsi: add a common function ucsi_unregister_connectors()
> > > Adding Heikki to the thread...
> > > 
> > > > This commit looks as if it were a harmless cleanup, but this failed in
> > > > a subtle way.  Namely, in the error scenario, the driver gets an error
> > > > at ucsi_register_altmodes(), and goes to the error handling to release
> > > > the resources.  Through this refactoring, the release part was unified
> > > > to a funciton ucsi_unregister_connectors().  And there, it has a NULL
> > > > check of con->wq, and it bails out the loop if it's NULL.
> > > > Meanwhile, ucsi_register_port() itself still calls destroy_workqueue()
> > > > and clear con->wq at its error path.  This ended up in the leftover
> > > > power supply device with the uninitialized / cleared device.
> > > > 
> > > > It was confirmed that the problem could be avoided by a simple
> > > > revert.
> > > I'll be glad to revert this now, unless Heikki thinks:
> > > 
> > > > I guess another fix could be removing the part clearing con->wq, i.e.
> > > > 
> > > > --- a/drivers/usb/typec/ucsi/ucsi.c
> > > > +++ b/drivers/usb/typec/ucsi/ucsi.c
> > > > @@ -1192,11 +1192,6 @@ static int ucsi_register_port(struct ucsi *ucsi, int index)
> > > >   out_unlock:
> > > >   	mutex_unlock(&con->lock);
> > > > -	if (ret && con->wq) {
> > > > -		destroy_workqueue(con->wq);
> > > > -		con->wq = NULL;
> > > > -	}
> > > > -
> > > >   	return ret;
> > > >   }
> > > > 
> > > > ... but it's totally untested and I'm not entirely sure whether it's
> > > > better.
> > > that is any better?
> > No, I don't think that's better. Right now I would prefer that we play
> > it safe and revert.
> > 
> > The conditions are different in the two places where the ports are
> > unregistered in this driver. Therefore I don't think it makes sense
> > to use a function like ucsi_unregister_connectors() that tries to
> > cover both cases. It will always be a little bit fragile.
> > 
> > Instead we could introduce a function that can be used to remove a
> > single port. That would leave the handling of the conditions to the
> > callers of the function, but it would still remove the boilerplate.
> > That would be much safer IMO.
> > 
> > But to fix this problem, I think we should revert.
> 
> but revert will happen on several stable branch, right ?

If someone sends it to me, yes :)

{hint}

