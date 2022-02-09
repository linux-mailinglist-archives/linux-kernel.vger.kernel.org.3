Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04D894AFC2C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 19:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241354AbiBIS5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 13:57:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241662AbiBIS4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 13:56:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84BEDC003677;
        Wed,  9 Feb 2022 10:53:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3920DB82378;
        Wed,  9 Feb 2022 18:53:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2C4EC340E7;
        Wed,  9 Feb 2022 18:53:00 +0000 (UTC)
Date:   Wed, 9 Feb 2022 18:52:57 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Cc:     Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Marc Zyngier <maz@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        gregkh <gregkh@linuxfoundation.org>, quic_psodagud@quicinc.com,
        Trilok Soni <quic_tsoni@quicinc.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCHv9 1/5] arm64: io: Use asm-generic high level MMIO
 accessors
Message-ID: <YgQNiXsh4hC+5+O5@arm.com>
References: <cover.1642482334.git.quic_saipraka@quicinc.com>
 <87926437f2f9e72dd94f0b30c8784c2da5508644.1642482334.git.quic_saipraka@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87926437f2f9e72dd94f0b30c8784c2da5508644.1642482334.git.quic_saipraka@quicinc.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 12:03:30PM +0530, Sai Prakash Ranjan wrote:
> Remove custom arm64 MMIO accessors read{b,w,l,q} and their relaxed
> versions in support to use asm-generic defined accessors. Also define
> one set of IO barriers (ar/bw version) used by asm-generic code to
> override the arm64 specific variants.
> 
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>

I'm fine with this patch:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

> diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
> index 7fd836bea7eb..1b436810d779 100644
> --- a/arch/arm64/include/asm/io.h
> +++ b/arch/arm64/include/asm/io.h
[...]
> +/* arm64-specific, don't use in portable drivers */
> +#define __iormb(v)		__io_ar(v)
> +#define __iowmb()		__io_bw()
> +#define __iomb()		dma_mb()

However, I'd like to see a few subsequent patches that get rid of the
__io*mb() uses in drivers/ (there don't seem to be that many).

-- 
Catalin
