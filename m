Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5BF58FDA5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 15:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235082AbiHKNpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 09:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235024AbiHKNpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 09:45:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3159E89919
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 06:45:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DCC92B82106
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 13:44:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19276C433C1;
        Thu, 11 Aug 2022 13:44:57 +0000 (UTC)
Date:   Thu, 11 Aug 2022 09:44:58 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        Ohad Sharabi <osharabi@habana.ai>
Subject: Re: [PATCH 1/3] habanalabs: define trace events
Message-ID: <20220811094458.17dc1a6e@gandalf.local.home>
In-Reply-To: <20220811113953.1963412-2-ogabbay@kernel.org>
References: <20220811113953.1963412-1-ogabbay@kernel.org>
        <20220811113953.1963412-2-ogabbay@kernel.org>
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

On Thu, 11 Aug 2022 14:39:51 +0300
Oded Gabbay <ogabbay@kernel.org> wrote:

> +DECLARE_EVENT_CLASS(habanalabs_mmu_template,
> +	TP_PROTO(struct device *dev, u64 virt_addr, u64 phys_addr, u32 page_size, bool flush_pte),
> +
> +	TP_ARGS(dev, virt_addr, phys_addr, page_size, flush_pte),
> +
> +	TP_STRUCT__entry(
> +		__string(dname, dev_name(dev))
> +		__field(u64, virt_addr)
> +		__field(u64, phys_addr)
> +		__field(u32, page_size)
> +		__field(u8, flush_pte)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(dname, dev_name(dev));
> +		__entry->virt_addr = virt_addr;
> +		__entry->phys_addr = phys_addr;
> +		__entry->page_size = page_size;
> +		__entry->flush_pte = flush_pte ? 1 : 0;

I think you can just have:

		__entry->flush_pte = flush_pte;

as I believe the C standard states that bool is saved as an integer '1' for
'true' and '0' for 'false'.

> +	),
> +

> +	TP_printk("%s: vaddr: %#llx, paddr: %#llx, psize: %#x, flush: %u",

If you want this to be a bit nicer looking, you could have "flush: %s",

> +		__get_str(dname),
> +		__entry->virt_addr,
> +		__entry->phys_addr,
> +		__entry->page_size,
> +		__entry->flush_pte)

And here: __entry->flush_pte ? "true" : "false")

Other than this, from a tracing point of view:

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve


> +);
> +

