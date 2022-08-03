Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F8B588FB6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 17:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236289AbiHCPvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 11:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238298AbiHCPu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 11:50:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88CE1DFB3;
        Wed,  3 Aug 2022 08:50:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F1768616EC;
        Wed,  3 Aug 2022 15:50:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07BB7C433D6;
        Wed,  3 Aug 2022 15:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659541846;
        bh=CQlWCz5t+ycatYOBjr5Kk6EwNwSmzl5rVsLrkUCwrkQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fLwDHlhv9XmBlCnQBJvie+dGhSlFusJcEr3U0Mhd7dLsqCP6/kJlzCf6AXb9VDhnj
         SAPwlnxA5uZ/ImPauj+uirOrkwITas7qemumOLqySP14BT+Wj2s2M/oIixKlfVfy66
         XESLndslcxpuO6v6x7q4+ACag50e7jnhQkavbp3A=
Date:   Wed, 3 Aug 2022 17:50:43 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Andrey Strachuk <strochuk@ispras.ru>
Subject: Re: [GIT PULL] USB / Thunderbolt driver changes for 6.0-rc1
Message-ID: <YuqZU/JJyMQJxva0@kroah.com>
References: <YuqB0tl2hjT3x7a4@kroah.com>
 <YuqXtcaUPflINBd6@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuqXtcaUPflINBd6@dev-arch.thelio-3990X>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2022 at 08:43:49AM -0700, Nathan Chancellor wrote:
> On Wed, Aug 03, 2022 at 04:10:26PM +0200, Greg KH wrote:
> > Andrey Strachuk (1):
> >       usb: cdns3: change place of 'priv_ep' assignment in cdns3_gadget_ep_dequeue(), cdns3_gadget_ep_enable()
> 
> For the record, this breaks allmodconfig with clang (I haven't seen a
> formal report on it anywhere and this missed -next coverage because
> Stephen is on vacation):
> 
>     drivers/usb/cdns3/cdns3-gadget.c:2290:11: error: variable 'priv_dev' is uninitialized when used here [-Werror,-Wuninitialized]
>                     dev_dbg(priv_dev->dev, "usbss: invalid parameters\n");
>                             ^~~~~~~~
>     include/linux/dev_printk.h:155:18: note: expanded from macro 'dev_dbg'
>             dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
>                             ^~~
>     include/linux/dynamic_debug.h:167:7: note: expanded from macro 'dynamic_dev_dbg'
>                             dev, fmt, ##__VA_ARGS__)
>                             ^~~
>     include/linux/dynamic_debug.h:152:56: note: expanded from macro '_dynamic_func_call'
>             __dynamic_func_call(__UNIQUE_ID(ddebug), fmt, func, ##__VA_ARGS__)
>                                                                 ^~~~~~~~~~~
>     include/linux/dynamic_debug.h:134:15: note: expanded from macro '__dynamic_func_call'
>                     func(&id, ##__VA_ARGS__);               \
>                                 ^~~~~~~~~~~
>     drivers/usb/cdns3/cdns3-gadget.c:2278:31: note: initialize the variable 'priv_dev' to silence this warning
>             struct cdns3_device *priv_dev;
>                                         ^
>                                         = NULL
>     1 error generated.
> 
> I know you don't take patches during the merge window, so I guess we'll
> just have to have x86_64 allmodconfig be broken with clang for -rc1? :/

I can send fix-up patches that break the build before -rc1 if you have
it.  Also you can send it and Linus can pick it up directly if it breaks
his workflow.

Odd that this was never reported, 0-day didn't even say anything?

thanks,

greg k-h
