Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377DF525238
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 18:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356336AbiELQMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 12:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356317AbiELQLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 12:11:47 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CC249666AD;
        Thu, 12 May 2022 09:11:42 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1npBPg-0001Vm-00; Thu, 12 May 2022 18:11:40 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 001AAC01DC; Thu, 12 May 2022 18:11:27 +0200 (CEST)
Date:   Thu, 12 May 2022 18:11:27 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Mao Bibo <maobibo@loongson.cn>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: smp: optimization for flush_tlb_mm when exiting
Message-ID: <20220512161127.GF14475@alpha.franken.de>
References: <20220510114441.2959886-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220510114441.2959886-1-maobibo@loongson.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 07:44:41PM +0800, Mao Bibo wrote:
> When process exits or execute new binary, it will call function
> exit_mmap with old mm, there is such function call trace:
>   exit_mmap(struct mm_struct *mm)
>       --> tlb_finish_mmu(&tlb, 0, -1)
>          --> arch_tlb_finish_mmu(tlb, start, end, force)
> 	    --> tlb_flush_mmu(tlb);
>                --> tlb_flush(struct mmu_gather *tlb)
>                   --> flush_tlb_mm(tlb->mm)
> 
> It is not necessary to flush tlb since oldmm is not used anymore
> by the process, there is similar operations on IA64/ARM64 etc,
> this patch adds such optimization on MIPS.
> 
> Signed-off-by: Mao Bibo <maobibo@loongson.cn>
> ---
>  arch/mips/kernel/smp.c | 6 ++++++
>  1 file changed, 6 insertions(+)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
