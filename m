Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A95F358FDBF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 15:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235125AbiHKNxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 09:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234453AbiHKNxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 09:53:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B030C5C96C
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 06:53:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B304611F3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 13:53:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26CC8C433C1;
        Thu, 11 Aug 2022 13:53:04 +0000 (UTC)
Date:   Thu, 11 Aug 2022 09:53:04 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        Ohad Sharabi <osharabi@habana.ai>
Subject: Re: [PATCH 3/3] habanalabs: trace DMA allocations
Message-ID: <20220811095304.3e97888a@gandalf.local.home>
In-Reply-To: <20220811113953.1963412-4-ogabbay@kernel.org>
References: <20220811113953.1963412-1-ogabbay@kernel.org>
        <20220811113953.1963412-4-ogabbay@kernel.org>
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

On Thu, 11 Aug 2022 14:39:53 +0300
Oded Gabbay <ogabbay@kernel.org> wrote:

> @@ -113,11 +116,16 @@ static void *hl_dma_alloc_common(struct hl_device *hdev, size_t size, dma_addr_t
>  		break;
>  	}
>  
> +	if (!ZERO_OR_NULL_PTR(ptr))

If you change the above to:

	if (trace_habanalabs_dma_alloc_enabled() && !ZERO_OR_NULL_PTR(ptr))

The conditional check will be skipped when this tracepoint is disabled.

-- Steve


> +		trace_habanalabs_dma_alloc(hdev->dev, (u64) (uintptr_t) ptr, *dma_handle, size,
> +						caller);
> +
>  	return ptr;
>  }
>  
