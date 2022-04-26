Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5957250FD81
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 14:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241520AbiDZMta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 08:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbiDZMt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 08:49:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF77116E852;
        Tue, 26 Apr 2022 05:46:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4BE446191D;
        Tue, 26 Apr 2022 12:46:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C915C385AA;
        Tue, 26 Apr 2022 12:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650977180;
        bh=LzTZF7bfozk4lHwG9l0c5q4GlvxB81IoFKbp6ejgylo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=CutA1h0W+bRHcor5gFj7LOGk/wAI7QQs/9seUcK4kWPBNV4TZRFhX8Jmq1cjydUuh
         lIKyXQHWUOUNcsBEWOTGh5aPPtYrgAWYI6qL3ALMXAyHVxAhaB6Tvc29rOzvhhVxCG
         ZPMc2ya7Bbty80JbE/VHYvtoWUi2HHEowAJ4mTpqgnG/hBOU57TAaZZO+6ZvxhWPd8
         iGBFkPtHR0nhPyYNjSLnqB+5oI2cDEyhbNTj0KZZai9U/IbuxLpAFEJy+o1PV4jrfN
         2RLgBVxaHy9VsgiVvd8MaGJ4wmr4O0oArenSBe279AGpGZvo6dA5Yi5hUvub059EQ0
         mIqV4iGeoHSAw==
Message-ID: <3ce5f3b8-3c6b-1e83-94c2-84f4ad8aa9dc@kernel.org>
Date:   Tue, 26 Apr 2022 14:46:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 0/5] add xhci-exynos driver
Content-Language: en-US
To:     Daehwan Jung <dh10.jung@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Howard Yen <howardyen@google.com>,
        Jack Pham <jackp@codeaurora.org>,
        Puma Hsu <pumahsu@google.com>,
        "J . Avila" <elavila@google.com>, sc.suh@samsung.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
References: <CGME20220426092019epcas2p2ef5dfde273edaaadc2ff74414f1b2c7a@epcas2p2.samsung.com>
 <1650964728-175347-1-git-send-email-dh10.jung@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <1650964728-175347-1-git-send-email-dh10.jung@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/04/2022 11:18, Daehwan Jung wrote:
> This patchset is for Samsung Exynos xhci host conroller. It uses xhci-plat
> driver mainly and extends some functions by xhci hooks and overrides.
> 
> This driver supports USB offload which makes Co-processor to use
> some memories of xhci. Especially it's useful for USB Audio scenario.
> Audio stream would get shortcut because Co-processor directly write/read
> data in xhci memories. It could get speed-up using faster memory like SRAM.
> That's why this gives vendors flexibilty of memory management. This feature
> is done with xhci hooks and overrides.
> 
> Changes in v2 :
> - Fix commit message by adding Signed-off-by in each patch.
> - Fix conflict on latest.
> 
> Changes in v3 :
> - Remove export symbols and xhci hooks which xhci-exynos don't need.
> - Modify commit message to clarify why it needs to export symbols.
> - Check compiling of xhci-exynos.
> 
> Changes in v4 :
> - Modify commit message to clarify why it needs to export symbols.
> - Add a function for override of hc driver in xhci-plat.
> - Make xhci-exynos extending xhci-plat by xhci hooks and overrides.
>   (vendor_init / vendor_cleanup hooks are useful from here v4)
> - Change the term (USB offload -> xhci-exynos) on subject of patches.
> 

You received comments already that you need to base your work on recent
Linux kernel and use scripts/get_maintainers.pl to notify necessary
parties. This is the fourth patchset and still you did not do it.

Maybe there is some misunderstanding or trouble using
scripts/get_maintainers.pl, so could you clarify:

1. What is this based on? Output of: git describe

2. What does the scripts/get_maintainers.pl print when you run on this
patchset?


Best regards,
Krzysztof
