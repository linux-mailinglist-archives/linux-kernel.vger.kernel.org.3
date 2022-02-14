Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 238B04B506C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 13:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237827AbiBNMlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 07:41:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353352AbiBNMlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 07:41:42 -0500
X-Greylist: delayed 4462 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 14 Feb 2022 04:41:31 PST
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2CC74AE3A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 04:41:31 -0800 (PST)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 287FF2FB; Mon, 14 Feb 2022 13:41:29 +0100 (CET)
Date:   Mon, 14 Feb 2022 13:41:27 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, will@kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: Re: [PATCH] iommu/ipmmu-vmsa: Check for error num after setting mask
Message-ID: <YgpN9zvNFohAESii@8bytes.org>
References: <20220106024302.2574180-1-jiasheng@iscas.ac.cn>
 <YgpAfVVhkNljJhJY@8bytes.org>
 <c95e5d3a-d2b4-dcc1-b6ba-2e4e9ebc5bb0@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c95e5d3a-d2b4-dcc1-b6ba-2e4e9ebc5bb0@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 12:32:21PM +0000, Robin Murphy wrote:
> In this particular case it cannot fail on any system the driver actually
> runs on - it's a platform device so the dma_mask pointer is always
> initialised, then dma_direct_supported() on arm64 will always return true
> for any mask wider than 32 bits, while arm_dma_supported() will also always
> pass since a 32-bit system cannot have memory above 40 bits either.
> 
> There's no great harm in adding the check for the sake of consistency, I
> guess, but it's purely cosmetic and not fixing anything.

Okay, thanks Robin and Nikita for looking to quickly into this. I will
apply it for 5.18 just to be on the safe side if the above assumptions
change.

Regards,

	Joerg
