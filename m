Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EAAB58FDB8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 15:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234541AbiHKNux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 09:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234338AbiHKNuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 09:50:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B78B248F3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 06:50:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BBD31B82109
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 13:50:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC4A1C433D6;
        Thu, 11 Aug 2022 13:50:45 +0000 (UTC)
Date:   Thu, 11 Aug 2022 09:50:46 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        Ohad Sharabi <osharabi@habana.ai>
Subject: Re: [PATCH 2/3] habanalabs: trace MMU map/unmap page
Message-ID: <20220811095046.0f303eac@gandalf.local.home>
In-Reply-To: <20220811113953.1963412-3-ogabbay@kernel.org>
References: <20220811113953.1963412-1-ogabbay@kernel.org>
        <20220811113953.1963412-3-ogabbay@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Aug 2022 14:39:52 +0300
Oded Gabbay <ogabbay@kernel.org> wrote:

> @@ -259,7 +261,12 @@ int hl_mmu_unmap_page(struct hl_ctx *ctx, u64 virt_addr, u32 page_size, bool flu
>  	if (flush_pte)
>  		mmu_funcs->flush(ctx);
>  
> -	return rc;
> +	if (rc)
> +		return rc;

If you want to avoid the condition if tracing is disabled (for a
micro-optimization) you can instead do:

	if (trace_habanalabs_mmu_unmap_enabled() && !rc)
		trace_habanalabs_mmu_unmap(hdev->dev, virt_addr, 0, page_size, flush_pte);

	return rc;

This way the above trace_habanalabs_mmu_unmap_enabled() is a static_branch,
and will become a nop falling into the "return rc", and when the tracepoint
is enabled, it will jump to a compare of "!rc".

-- Steve


> +
> +	trace_habanalabs_mmu_unmap(hdev->dev, virt_addr, 0, page_size, flush_pte);
> +
> +	return 0;
>  }
>  
