Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDF359B27C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 09:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiHUHB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 03:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiHUHBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 03:01:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45C92AC49;
        Sun, 21 Aug 2022 00:01:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ECC64B80BA8;
        Sun, 21 Aug 2022 07:01:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D1A8C433D6;
        Sun, 21 Aug 2022 07:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661065293;
        bh=IkBhuQ4Ga0ENimbZcXbIIWSwXIVkLhO73dH4+EuA5qk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gaRiIVD//Qr759lieITGg0VK5y8wZHNrbBrROJxrwx7M8f0yQz3U3PklMmRWCJ2ac
         A/2TxsYoxPbDbFCMPf2cNq41YOSAOVZhklFeCGAZb/qHkk5y7eyqU93AD1oIStI8uV
         YjlV4MWCK0hySxeUQOkFco/U5bjU9gBtUYvMYTNo=
Date:   Sat, 20 Aug 2022 20:40:52 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Takashi Iwai <tiwai@suse.de>
Cc:     Linyu Yuan <quic_linyyuan@quicinc.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION 5.19] NULL dereference by ucsi_acpi driver
Message-ID: <YwEqtGB2WldUeiEN@kroah.com>
References: <87r11cmbx0.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r11cmbx0.wl-tiwai@suse.de>
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2022 at 06:32:43PM +0200, Takashi Iwai wrote:
> Hi,
> 
> we've got multiple reports about 5.19 kernel starting crashing after
> some time, and this turned out to be triggered by ucsi_acpi driver.
> The details are found in:
>   https://bugzilla.suse.com/show_bug.cgi?id=1202386
> 
> The culprit seems to be the commit 87d0e2f41b8c
>     usb: typec: ucsi: add a common function ucsi_unregister_connectors()

Adding Heikki to the thread...

>     
> This commit looks as if it were a harmless cleanup, but this failed in
> a subtle way.  Namely, in the error scenario, the driver gets an error
> at ucsi_register_altmodes(), and goes to the error handling to release
> the resources.  Through this refactoring, the release part was unified
> to a funciton ucsi_unregister_connectors().  And there, it has a NULL
> check of con->wq, and it bails out the loop if it's NULL. 
> Meanwhile, ucsi_register_port() itself still calls destroy_workqueue()
> and clear con->wq at its error path.  This ended up in the leftover
> power supply device with the uninitialized / cleared device.
> 
> It was confirmed that the problem could be avoided by a simple
> revert.

I'll be glad to revert this now, unless Heikki thinks:

> 
> I guess another fix could be removing the part clearing con->wq, i.e.
> 
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -1192,11 +1192,6 @@ static int ucsi_register_port(struct ucsi *ucsi, int index)
>  out_unlock:
>  	mutex_unlock(&con->lock);
>  
> -	if (ret && con->wq) {
> -		destroy_workqueue(con->wq);
> -		con->wq = NULL;
> -	}
> -
>  	return ret;
>  }
>  
> 
> ... but it's totally untested and I'm not entirely sure whether it's
> better.

that is any better?

thanks,

greg k-h
