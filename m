Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC09D58871E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 08:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235103AbiHCGIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 02:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbiHCGIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 02:08:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7551A3A5
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 23:08:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5D43AB8217F
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 06:08:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7247C433C1;
        Wed,  3 Aug 2022 06:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659506914;
        bh=kfuk+0aXynx06c3o3pjaVWnK/rbUgbtj8vWQB25K0h4=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=msIDcyFyyQTgdnwORVlVDKoZzClCZT4T7BgWa4BJukdoknUguA/1elFnmNMVKmb9u
         Bwd73X2uFBEvzefFQUlhf4cec64iCh2hIer2UqlUnBhAhwwovGYhi6ZU3n7CbHmugo
         t9XKL1KwaiPKRgXO2RgioVF2pGCbSAh/NcMwQOXM=
Date:   Wed, 3 Aug 2022 08:08:31 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Grzegorz Szymaszek <gszymaszek@short.pl>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: r8188eu: add firmware dependency
Message-ID: <YuoQ37PIKzWO1zIY@kroah.com>
References: <YukkBu3TNODO3or9@nx64de-df6d00>
 <YukvnVWuhUeOgRyZ@kroah.com>
 <Yukx8KEEOhKTJ7HQ@nx64de-df6d00>
 <c82114b6-1003-bfb5-0550-98dcbf1a3761@lwfinger.net>
 <YulcdKfhA8dPQ78s@nx64de-df6d00>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YulcdKfhA8dPQ78s@nx64de-df6d00>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2022 at 07:18:44PM +0200, Grzegorz Szymaszek wrote:
> The old rtl8188eu module, removed in commit 55dfa29b43d2 ("staging:
> rtl8188eu: remove rtl8188eu driver from staging dir") (Linux kernel
> v5.15-rc1), required (through a MODULE_FIRMWARE call()) the
> rtlwifi/rtl8188eufw.bin firmware file, which the new r8188eu driver no
> longer requires.
> 
> I have tested a few RTL8188EUS-based Wi-Fi cards and, while supported by
> both drivers, they do not work when using the new one and the firmware
> wasn't manually loaded. According to Larry Finger, the module
> maintainer, all such cards need the firmware and the driver should
> depend on it (see the linked mails).
> 
> Add a proper MODULE_FIRMWARE() call, like it was done in the old driver.
> 
> Thanks to Greg Kroah-Hartman and Larry Finger for quick responses to my
> questions.
> 
> Link: https://answers.launchpad.net/ubuntu/+source/linux-meta-hwe-5.15/+question/702611
> Link: https://lore.kernel.org/lkml/YukkBu3TNODO3or9@nx64de-df6d00/
> Signed-off-by: Grzegorz Szymaszek <gszymaszek@short.pl>
> ---
>  drivers/staging/r8188eu/os_dep/os_intfs.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
> index 891c85b088ca..5bd3022e4b40 100644
> --- a/drivers/staging/r8188eu/os_dep/os_intfs.c
> +++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
> @@ -18,6 +18,7 @@ MODULE_LICENSE("GPL");
>  MODULE_DESCRIPTION("Realtek Wireless Lan Driver");
>  MODULE_AUTHOR("Realtek Semiconductor Corp.");
>  MODULE_VERSION(DRIVERVERSION);
> +MODULE_FIRMWARE("rtlwifi/rtl8188eufw.bin");

This looks good, and I'll apply it after 5.20-rc1 is out, but you might
want to send a follow-on patch that removes the hard-coded string in 2
places in the driver, and just puts it into a single define somewhere,
to make it a bit easier over time.  Most other drivers do this as well,
so there are examples to look at.

thanks,

greg k-h
