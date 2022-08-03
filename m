Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 290A3588F97
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 17:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238171AbiHCPoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 11:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236130AbiHCPn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 11:43:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C20248D1;
        Wed,  3 Aug 2022 08:43:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C9EC2B82302;
        Wed,  3 Aug 2022 15:43:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F6E2C433D7;
        Wed,  3 Aug 2022 15:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659541431;
        bh=610rd7phPOsJB++JpUuxq7zM9r37A/R+mBNaQBl8QAI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BFgGxf5Hq+EBXH5WooBr4OTDZWcRCmDoWtUHclSiletxQoLaYfvnU7njkdYXu5lIs
         9o52isazSFwo5dU3dO5KBK9uIPUPFcD1upFclz5a2mVCV+Iir9PPLKZPS/KdCygyD8
         h9yJiYiRQb4xjs+rat9o333wdADeaFXG2Am2S81pDFlwJvdn2LzjD3r/nMM6HGg+ER
         9+8hORfBBUvVPvp+b3m79JMQcYzU+w58JFa1PK2/yH4DdNkcm2/149qNTTIzjL1/kz
         nNwA9r+nIOdfLhjuquiqq5cCHwzYkghT3GY2M426H2bTUmflXvwdHlQ9p3PXM94he7
         TVCv6qBxNVwKg==
Date:   Wed, 3 Aug 2022 08:43:49 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Andrey Strachuk <strochuk@ispras.ru>
Subject: Re: [GIT PULL] USB / Thunderbolt driver changes for 6.0-rc1
Message-ID: <YuqXtcaUPflINBd6@dev-arch.thelio-3990X>
References: <YuqB0tl2hjT3x7a4@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuqB0tl2hjT3x7a4@kroah.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2022 at 04:10:26PM +0200, Greg KH wrote:
> Andrey Strachuk (1):
>       usb: cdns3: change place of 'priv_ep' assignment in cdns3_gadget_ep_dequeue(), cdns3_gadget_ep_enable()

For the record, this breaks allmodconfig with clang (I haven't seen a
formal report on it anywhere and this missed -next coverage because
Stephen is on vacation):

    drivers/usb/cdns3/cdns3-gadget.c:2290:11: error: variable 'priv_dev' is uninitialized when used here [-Werror,-Wuninitialized]
                    dev_dbg(priv_dev->dev, "usbss: invalid parameters\n");
                            ^~~~~~~~
    include/linux/dev_printk.h:155:18: note: expanded from macro 'dev_dbg'
            dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
                            ^~~
    include/linux/dynamic_debug.h:167:7: note: expanded from macro 'dynamic_dev_dbg'
                            dev, fmt, ##__VA_ARGS__)
                            ^~~
    include/linux/dynamic_debug.h:152:56: note: expanded from macro '_dynamic_func_call'
            __dynamic_func_call(__UNIQUE_ID(ddebug), fmt, func, ##__VA_ARGS__)
                                                                ^~~~~~~~~~~
    include/linux/dynamic_debug.h:134:15: note: expanded from macro '__dynamic_func_call'
                    func(&id, ##__VA_ARGS__);               \
                                ^~~~~~~~~~~
    drivers/usb/cdns3/cdns3-gadget.c:2278:31: note: initialize the variable 'priv_dev' to silence this warning
            struct cdns3_device *priv_dev;
                                        ^
                                        = NULL
    1 error generated.

I know you don't take patches during the merge window, so I guess we'll
just have to have x86_64 allmodconfig be broken with clang for -rc1? :/

Cheers,
Nathan
