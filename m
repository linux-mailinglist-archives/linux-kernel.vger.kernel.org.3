Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF2FA570D8B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 00:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiGKWua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 18:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGKWu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 18:50:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C760E48EB9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 15:50:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 776ADB815F3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 22:50:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D0FDC34115;
        Mon, 11 Jul 2022 22:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657579825;
        bh=2Gu+t/Fulb4KZh2OM3NDzpYPsvdLLj3c4PEsBwp7qxg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lc3WlFtsehEk/R/e6sfX0z7Izzgsycg7DmRqJGiPEr/ohSe9cslxuKc69opAXEhOG
         INAhfEguVDmg6C1T02LTglJungdVskKIYManfQWUkaTgLmKxcvu42m7ral/GETDG4K
         lcSy/AN9WoHog2dOTv/weYIYqAJNoAkwvmd/ER9dyeiAIUQ+49mot0vMdqhG2/IU8f
         /iJTjT0mar4UBStbUpOtIqKF4HUFCxgB3nTcuZV/Bz5fEBnCkD1W66CaaU5cixBC3T
         cz6ziocAKl18kFFYj6PJ098j1k+14tjk6E3V/NUtC2Ko3T3pQ8N+pIrSQmfWqz6/yP
         YfbiBxx7+zAqQ==
Message-ID: <1c58c7e1-2c21-e0d2-34c7-252074ecc70d@kernel.org>
Date:   Mon, 11 Jul 2022 15:50:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] x86/mm/tlb: Skip tracing when flush is not done
Content-Language: en-US
To:     Nadav Amit <nadav.amit@gmail.com>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Linux MM <linux-mm@kvack.org>,
        Nadav Amit <namit@vmware.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <20220710233355.4066-1-namit@vmware.com>
From:   Andy Lutomirski <luto@kernel.org>
In-Reply-To: <20220710233355.4066-1-namit@vmware.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/22 16:33, Nadav Amit wrote:
> From: Nadav Amit <namit@vmware.com>
> 
> Currently, if flush_tlb_func() does not flush for some reason, the
> tracing of the flush will be done only in certain cases, depending on
> the reason of the flush. Be consistent and just do not trace in all
> cases when the flush was eventually not done.
> 
> Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Nadav Amit <namit@vmware.com>


Can you remove this comment, too?

>   	/* Tracing is done in a unified manner to reduce the code size */

> -done:
>   	trace_tlb_flush(!local ? TLB_REMOTE_SHOOTDOWN :
>   				(f->mm == NULL) ? TLB_LOCAL_SHOOTDOWN :
>   						  TLB_LOCAL_MM_SHOOTDOWN,

