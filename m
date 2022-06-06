Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1FB53E678
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235862AbiFFLzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 07:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235852AbiFFLzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 07:55:49 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1545D737BE
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 04:55:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 47C18CE1A1F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 11:55:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 546C7C385A9;
        Mon,  6 Jun 2022 11:55:43 +0000 (UTC)
Date:   Mon, 6 Jun 2022 12:55:39 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Patrick Wang <patrick.wang.shcn@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yee.lee@mediatek.com
Subject: Re: [PATCH v2 1/4] mm: kmemleak: add OBJECT_PHYS flag for objects
 allocated with physical address
Message-ID: <Yp3rO4WpLzxLA6+7@arm.com>
References: <20220603035415.1243913-1-patrick.wang.shcn@gmail.com>
 <20220603035415.1243913-2-patrick.wang.shcn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603035415.1243913-2-patrick.wang.shcn@gmail.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2022 at 11:54:12AM +0800, Patrick Wang wrote:
> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> index a182f5ddaf68..1e9e0aa93ae5 100644
> --- a/mm/kmemleak.c
> +++ b/mm/kmemleak.c
> @@ -172,6 +172,8 @@ struct kmemleak_object {
>  #define OBJECT_NO_SCAN		(1 << 2)
>  /* flag set to fully scan the object when scan_area allocation failed */
>  #define OBJECT_FULL_SCAN	(1 << 3)
> +/* flag set for object allocated with physical address */
> +#define OBJECT_PHYS		(1 << 4)
>  
>  #define HEX_PREFIX		"    "
>  /* number of bytes to print per line; must be 16 or 32 */
> @@ -575,7 +577,8 @@ static int __save_stack_trace(unsigned long *trace)
>   * memory block and add it to the object_list and object_tree_root.
>   */
>  static struct kmemleak_object *create_object(unsigned long ptr, size_t size,
> -					     int min_count, gfp_t gfp)
> +					     int min_count, gfp_t gfp,
> +					     bool is_phys)

The patch looks fine but I wonder whether we should have different
functions for is_phys true/false, we may end up fewer changes overall
since most places simply pass is_phys == false:

static struct kmemleak_object *__create_object(unsigned long ptr, size_t size,
					       int min_count, gfp_t gfp,
					       bool is_phys);

static struct kmemleak_object *create_object(unsigned long ptr, size_t size,
					     int min_count, gfp_t gfp)
{
	return __create_object(ptr, size, min_count, gfp, false);
}

static struct kmemleak_object *create_object_phys(unsigned long ptr, size_t size,
						  int min_count, gfp_t gfp)
{
	return __create_object(ptr, size, min_count, gfp, true);
}

Same for the other patches that change a few more functions.

-- 
Catalin
