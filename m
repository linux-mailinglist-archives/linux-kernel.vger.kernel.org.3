Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA8CA58C901
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 15:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243140AbiHHNHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 09:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243119AbiHHNHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 09:07:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252886161;
        Mon,  8 Aug 2022 06:07:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D3F3DB80DDB;
        Mon,  8 Aug 2022 13:07:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1739EC433C1;
        Mon,  8 Aug 2022 13:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659964023;
        bh=p2X0cwZgl+YlAJpq+psX9m/WwU/2a7JZIBgsy1xBAjM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yF8gouLsD4cDV0/1Y9HjbFYTYvbIU91B6IohV5ZazxLQUGZso04d8dr6E7zcQKNTt
         rJyhNNuWy1ZIXgKdXB6p5S0wUl5pVEJXQiYFkQvytXpQEqGO0GmvbVHL6rijhdEyDZ
         95bW41h7kRGrAzZ4h7hrPMS9kVK53JM9zj4mAlJw=
Date:   Mon, 8 Aug 2022 15:07:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Andrey Strachuk <strochuk@ispras.ru>
Subject: Re: [GIT PULL] USB / Thunderbolt driver changes for 6.0-rc1
Message-ID: <YvEKdIRlBvSYe34C@kroah.com>
References: <YuqB0tl2hjT3x7a4@kroah.com>
 <YuqXtcaUPflINBd6@dev-arch.thelio-3990X>
 <YuqZU/JJyMQJxva0@kroah.com>
 <d0f1c9ae-91aa-2c52-b86a-f111908d6b22@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d0f1c9ae-91aa-2c52-b86a-f111908d6b22@quicinc.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2022 at 09:26:55PM +0530, Krishna Kurapati PSSNV wrote:
> 
> On 8/3/2022 9:20 PM, Greg KH wrote:
> > On Wed, Aug 03, 2022 at 08:43:49AM -0700, Nathan Chancellor wrote:
> > > On Wed, Aug 03, 2022 at 04:10:26PM +0200, Greg KH wrote:
> > > > Andrey Strachuk (1):
> > > >        usb: cdns3: change place of 'priv_ep' assignment in cdns3_gadget_ep_dequeue(), cdns3_gadget_ep_enable()
> > > For the record, this breaks allmodconfig with clang (I haven't seen a
> > > formal report on it anywhere and this missed -next coverage because
> > > Stephen is on vacation):
> > > 
> > >      drivers/usb/cdns3/cdns3-gadget.c:2290:11: error: variable 'priv_dev' is uninitialized when used here [-Werror,-Wuninitialized]
> > >                      dev_dbg(priv_dev->dev, "usbss: invalid parameters\n");
> > >                              ^~~~~~~~
> > >      include/linux/dev_printk.h:155:18: note: expanded from macro 'dev_dbg'
> > >              dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
> > >                              ^~~
> > >      include/linux/dynamic_debug.h:167:7: note: expanded from macro 'dynamic_dev_dbg'
> > >                              dev, fmt, ##__VA_ARGS__)
> > >                              ^~~
> > >      include/linux/dynamic_debug.h:152:56: note: expanded from macro '_dynamic_func_call'
> > >              __dynamic_func_call(__UNIQUE_ID(ddebug), fmt, func, ##__VA_ARGS__)
> > >                                                                  ^~~~~~~~~~~
> > >      include/linux/dynamic_debug.h:134:15: note: expanded from macro '__dynamic_func_call'
> > >                      func(&id, ##__VA_ARGS__);               \
> > >                                  ^~~~~~~~~~~
> > >      drivers/usb/cdns3/cdns3-gadget.c:2278:31: note: initialize the variable 'priv_dev' to silence this warning
> > >              struct cdns3_device *priv_dev;
> > >                                          ^
> > >                                          = NULL
> > >      1 error generated.
> > > 
> > > I know you don't take patches during the merge window, so I guess we'll
> > > just have to have x86_64 allmodconfig be broken with clang for -rc1? :/
> > I can send fix-up patches that break the build before -rc1 if you have
> > it.  Also you can send it and Linus can pick it up directly if it breaks
> > his workflow.
> > 
> > Odd that this was never reported, 0-day didn't even say anything?
> > 
> > thanks,
> > 
> > greg k-h
> Hi Greg,
>   On a similar note. There was another issue reported in which randconfig
> for i386 build breaks as usb_hub_find_child API is not present as usbcore
> isn't compiled in that config (CONFIG_USB isn't set).
> Patch to fix has been pushed recently and is in review:
> https://lore.kernel.org/linux-usb/1659337215-20421-1-git-send-email-quic_kriskura@quicinc.com/
> 
> Would it be possible to pick it up in rc1 to make sure nothing breaks
> further because of it.
> I can respin patch if something is off in it.

See my comments to that patch, and Johan's attempt at it.  Something
larger is broken here, let's not paper over the issue right now with a
#ifdef in the .c file.  Fix it properly for 6.0-final.  Builds without
CONFIG_USB and gadget-only mode enabled are rare but this can be fixed
up after -rc1 is out, no rush right now.

thanks,

greg k-h
