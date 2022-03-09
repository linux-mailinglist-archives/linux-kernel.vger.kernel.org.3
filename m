Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0B754D3230
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 16:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234039AbiCIPwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 10:52:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbiCIPwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 10:52:04 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3D817EDB5
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 07:51:05 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4KDGrR56SRz9sSh;
        Wed,  9 Mar 2022 16:51:03 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5wOzM6i21biS; Wed,  9 Mar 2022 16:51:03 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4KDGrR4KLJz9sSX;
        Wed,  9 Mar 2022 16:51:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7D4AE8B780;
        Wed,  9 Mar 2022 16:51:03 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id XFeK_aR_i2t3; Wed,  9 Mar 2022 16:51:03 +0100 (CET)
Received: from [192.168.202.27] (unknown [192.168.202.27])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CBD838B763;
        Wed,  9 Mar 2022 16:51:02 +0100 (CET)
Message-ID: <375b927b-fa93-28cd-23b8-8afe264adb0c@csgroup.eu>
Date:   Wed, 9 Mar 2022 16:51:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] powerpc/vdso: Fix VDSO unmap check
Content-Language: fr-FR
To:     Laurent Dufour <ldufour@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
References: <20201103171336.98883-1-ldufour@linux.ibm.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20201103171336.98883-1-ldufour@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 03/11/2020 à 18:13, Laurent Dufour a écrit :
> The check introduced by the commit 83d3f0e90c6c ("powerpc/mm: tracking vDSO
> remap") is wrong and is missing some partial unmaps of the VDSO.
> 
> To be complete the check needs the base and end address of the
> VDSO. Currently only the base is available in the mm_context of a task, but
> the end address can easily be computed because the size of VDSO is
> constant. However, there are 2 sizes for 32 or 64 bits task and they are
> stored in static variables in arch/powerpc/kernel/vdso.c.
> 
> Exporting a new function called vdso_pages() to get the number of pages of
> the VDSO based on the static variables from arch/powerpc/kernel/vdso.c.
> 
> Fixes: 83d3f0e90c6c ("powerpc/mm: tracking vDSO remap")
> 
> Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
> Reported-by: Thomas Gleixner <tglx@linutronix.de>
> Suggested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> ---
>   arch/powerpc/include/asm/mmu_context.h | 18 ++++++++++++++++--
>   arch/powerpc/kernel/vdso.c             | 14 ++++++++++++++
>   2 files changed, 30 insertions(+), 2 deletions(-)

This patch doesn't apply anymore.

In the meantime there's a pending series from Dmitry, so I'm wondering 
if it is worth rebasing this series or not.

Christophe
