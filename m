Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49B7F5453C0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 20:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238013AbiFISK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 14:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344647AbiFISK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 14:10:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074953AD8B1
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 11:10:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 501F461D0D
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 18:10:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B0F9C34114;
        Thu,  9 Jun 2022 18:10:24 +0000 (UTC)
Date:   Thu, 9 Jun 2022 19:10:20 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Patrick Wang <patrick.wang.shcn@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yee.lee@mediatek.com
Subject: Re: [PATCH v3 2/3] mm: kmemleak: add rbtree and store physical
 address for objects allocated with PA
Message-ID: <YqI3jE/4ndkmPVMc@arm.com>
References: <20220609124950.1694394-1-patrick.wang.shcn@gmail.com>
 <20220609124950.1694394-3-patrick.wang.shcn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220609124950.1694394-3-patrick.wang.shcn@gmail.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2022 at 08:49:49PM +0800, Patrick Wang wrote:
> Add object_phys_tree_root to store the objects allocated with
> physical address. Distinguish it from object_tree_root by
> OBJECT_PHYS flag or function argument. The physical address
> is stored directly in those objects. And remove the unused
> kmemleak_not_leak_phys() function.
> 
> Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Patrick Wang <patrick.wang.shcn@gmail.com>
> ---
>  Documentation/dev-tools/kmemleak.rst |   1 -
>  include/linux/kmemleak.h             |   4 -
>  mm/kmemleak.c                        | 145 +++++++++++++++++----------
>  3 files changed, 91 insertions(+), 59 deletions(-)
> 
> diff --git a/Documentation/dev-tools/kmemleak.rst b/Documentation/dev-tools/kmemleak.rst
> index 1c935f41cd3a..5483fd39ef29 100644
> --- a/Documentation/dev-tools/kmemleak.rst
> +++ b/Documentation/dev-tools/kmemleak.rst
> @@ -174,7 +174,6 @@ mapping:
>  
>  - ``kmemleak_alloc_phys``
>  - ``kmemleak_free_part_phys``
> -- ``kmemleak_not_leak_phys``
>  - ``kmemleak_ignore_phys``

Same comment - only if you respin, move the kmemleak_not_leak_phys()
removal to a separate patch. Otherwise:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
