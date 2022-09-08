Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9E985B1EF7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 15:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbiIHN3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 09:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbiIHN3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 09:29:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEBF3127542
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 06:29:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE25561CE6
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 13:29:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CCA9C433D6;
        Thu,  8 Sep 2022 13:28:58 +0000 (UTC)
Date:   Thu, 8 Sep 2022 14:28:55 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Zenghui Yu <yuzenghui@huawei.com>
Cc:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, maz@kernel.org, james.morse@arm.com,
        alexandru.elisei@arm.com, suzuki.poulose@arm.com,
        oliver.upton@linux.dev, will@kernel.org, wanghaibin.wang@huawei.com
Subject: Re: [PATCH] KVM: arm64: Use kmemleak_free_part_phys() to unregister
 hyp_mem_base
Message-ID: <YxnuFzxDpFwEYLxF@arm.com>
References: <20220908130659.2021-1-yuzenghui@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908130659.2021-1-yuzenghui@huawei.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2022 at 09:06:59PM +0800, Zenghui Yu wrote:
> With commit 0c24e061196c ("mm: kmemleak: add rbtree and store physical
> address for objects allocated with PA"), kmemleak started to put the
> objects allocated with physical address onto object_phys_tree_root tree.
> The kmemleak_free_part() therefore no longer worked as expected on
> physically allocated objects (hyp_mem_base in this case) as it attempted to
> search and remove things in object_tree_root tree.
> 
> Fix it by using kmemleak_free_part_phys() to unregister hyp_mem_base. This
> fixes an immediate crash when booting a KVM host in protected mode with
> kmemleak enabled.
> 
> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
