Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CAE24FF443
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 11:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234778AbiDMJ7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 05:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiDMJ7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:59:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA8056418
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 02:57:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39D59B82161
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 09:57:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5853BC385A4;
        Wed, 13 Apr 2022 09:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649843826;
        bh=Gvg7LRw/xZeBOxZ+ML/w+hzH8H2F8QR6fA7vJj6buX4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UtLOsXFywpemB7ZRATqgftGYZ2fEWxqCgcGuxcXQw4snvYCkDAhuUINIOxLb9b4aU
         tqRfgkDGx/y7+jlGaHviy/A6MwxssuD+JFltbSeGrnGLtrDF1TQnzeDhePU/W4xRAq
         Zd6NLWviWanUiFhp80yq14A1rRthHvVqjkaEcWIMUXH6Mr7mQxBg+MtNDYJFq7AwVw
         XYAcy5Mq3i23R6aGWno+L9/mmAeOtD9QPwHZWQBLBsGnyxHMnYJeHi2VbpvgyEqVrC
         ySu5hAoxch9aSVNu3NqrOMLwUbyj/JzryEan+0+XEPIyI+ZrIhXBp6njMIJuWFvzcY
         +5vDvtXeBm5vw==
Date:   Wed, 13 Apr 2022 15:27:03 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Swapnil Jakhade <sjakhade@cadence.com>
Cc:     kishon@ti.com, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, mparab@cadence.com,
        a-govindraju@ti.com
Subject: Re: [PATCH] phy: cadence: Sierra: Add TI J721E specific PCIe
 multilink lane configuration
Message-ID: <Ylaeb1169qh/Nx5D@matsya>
References: <20220303055026.24899-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220303055026.24899-1-sjakhade@cadence.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-03-22, 06:50, Swapnil Jakhade wrote:
> This patch adds workaround for TI J721E errata i2183
> (https://www.ti.com/lit/er/sprz455a/sprz455a.pdf).
> PCIe fails to link up if SERDES lanes not used by PCIe are assigned to
> another protocol. For example, link training fails if lanes 2 and 3 are
> assigned to another protocol while lanes 0 and 1 are used for PCIe to
> form a two lane link. This failure is due to an incorrect tie-off on an
> internal status signal indicating electrical idle.
> 
> Status signals going from SERDES to PCIe Controller are tied-off when a
> lane is not assigned to PCIe. Signal indicating electrical idle is
> incorrectly tied-off to a state that indicates non-idle. As a result,
> PCIe sees unused lanes to be out of electrical idle and this causes
> LTSSM to exit Detect.Quiet state without waiting for 12ms timeout to
> occur. If a receiver is not detected on the first receiver detection
> attempt in Detect.Active state, LTSSM goes back to Detect.Quiet and
> again moves forward to Detect.Active state without waiting for 12ms as
> required by PCIe base specification. Since wait time in Detect.Quiet is
> skipped, multiple receiver detect operations are performed back-to-back
> without allowing time for capacitance on the transmit lines to
> discharge. This causes subsequent receiver detection to always fail even
> if a receiver gets connected eventually.
> 
> The workaround only works for 1-lane PCIe configuration. This workaround
> involves enabling receiver detect override by setting TX_RCVDET_OVRD_PREG_j
> register of the lane running PCIe to 0x2. This causes SERDES to indicate
> successful receiver detect when LTSSM is in Detect.Active state, whether a
> receiver is actually present or not. If the receiver is present, LTSSM
> proceeds to link up as expected. However if receiver is not present, LTSSM
> will time out in Polling.Configuration substate since the expected training
> sequence packets will not be received.

Applied, thanks

-- 
~Vinod
