Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D1359ECF5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 21:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbiHWT7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 15:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiHWT6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 15:58:47 -0400
Received: from crane.ash.relay.mailchannels.net (crane.ash.relay.mailchannels.net [23.83.222.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15EA890186
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 12:09:55 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 477BA8C1801;
        Tue, 23 Aug 2022 19:09:51 +0000 (UTC)
Received: from pdx1-sub0-mail-a212.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 94A0E8C101F;
        Tue, 23 Aug 2022 19:09:49 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1661281790; a=rsa-sha256;
        cv=none;
        b=lmG9Tw8EGSeZND4joDeu48YZlxokQLqgCdI/O69HSbnFT1r2gscGYe5cYlSfYkDBdnaY4T
        /aniTS4+Vhif4/Zui9jw9izH8sLa8fNr2teY5LiCBsmXiwRLhks1o/hjRnZqemFHNPRps3
        XQ73+PcFQfd9C1j9pPou5z49IcOEE3nT5CWTEgGCbp0oTEiqKQgSPxdNn/57rCXuUKhOMN
        0oBSkGU+HKekLrOPiAtu56O9OLnxg8VW1vbqUwwl5sGengqi5b2EnfTw9ZzjQb/JN+u2Xk
        Q7g+De2wPPXcSH2+ONjJXH+27xFOFcg51jXTLJKVL0251l5vdL/KdzSxg8W36g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1661281790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=RePCAjRmxTgvfrJFiJji/FcnlgED11O0Jsa0IkQPkag=;
        b=ANDq04V3Vf6p3HoHJoL43e+DFX/UqcEwdNLwcUIIAlG/xV70/6bT5lGN3Z/xkd743bwJrh
        mZufmqMNA/n7ubu+Rd0/7OG1h9KJ2SIBMGZluUyYJ/7Up9tTvOsATI8qDz96tSEyXIGift
        K1SL5GSXG2u9k0VKLTWHA+UxP23gcwG+CoL7gxfenIBxSCz+e0pgNMKOvwN05YFx0WFBkC
        qFZMRZDev9/s1ZEsFPO8Xi/mcVP13ekUOjsWbUos6QAnIbcA1fm8czcSFQl9JI8oudp+x/
        Y65tn+XEGBJZC9Xb5sFddV+5m5SraNzg0S6MoNINEEdH1MhuKRU+g9WAjdDtmg==
ARC-Authentication-Results: i=1;
        rspamd-76867cc9c5-7stgk;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Keen-Whimsical: 0a7423aa152d839e_1661281791062_1936149744
X-MC-Loop-Signature: 1661281791062:710606637
X-MC-Ingress-Time: 1661281791062
Received: from pdx1-sub0-mail-a212.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.109.219.74 (trex/6.7.1);
        Tue, 23 Aug 2022 19:09:51 +0000
Received: from offworld (unknown [104.36.31.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a212.dreamhost.com (Postfix) with ESMTPSA id 4MBzLh3YyHz1q;
        Tue, 23 Aug 2022 12:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1661281789;
        bh=RePCAjRmxTgvfrJFiJji/FcnlgED11O0Jsa0IkQPkag=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=oyrod9XrrZW1qVmOHoBb7nCLmVdL6ECR601aRxtb75J2Lw7pGsqoTA5Y9khNa2FAB
         nRIMzMh2+2sfD7jNV/m0KBJFO3INR44wQ+CVyo9LKkiqZuHX3riQxg2QC7VHxdSUiB
         bj2TCfyTxqrRpaAKaDdJSBksGsTQpFh8CVksV71vFgl5ymy/Tof/jrKdR1fVqMhbr2
         rTIaSGWoVbI5QL8LlzHNhRXu2hUkaeg9921b+Up5v83JQwXVIaScspoJOW33eipK8A
         +8rwm3Llg04bDUtjhi+jF7UkU+tQxub4eBL56F/38MTwU60nmx0nhcsLD0OJ39FDHN
         ZM7omNRfzy/Tg==
Date:   Tue, 23 Aug 2022 11:51:45 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v13 33/70] powerpc: remove mmap linked list walks
Message-ID: <20220823185145.gjvb3xmzebewi6os@offworld>
Mail-Followup-To: Liam Howlett <liam.howlett@oracle.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Vlastimil Babka <vbabka@suse.cz>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
 <20220822150128.1562046-34-Liam.Howlett@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220822150128.1562046-34-Liam.Howlett@oracle.com>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Aug 2022, Liam Howlett wrote:

>From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
>
>Use the VMA iterator instead.
>
>Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
>Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

>---
> arch/powerpc/kernel/vdso.c              |  6 +++---
> arch/powerpc/mm/book3s32/tlb.c          | 11 ++++++-----
> arch/powerpc/mm/book3s64/subpage_prot.c | 13 ++-----------
> 3 files changed, 11 insertions(+), 19 deletions(-)
>
>diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
>index 0da287544054..94a8fa5017c3 100644
>--- a/arch/powerpc/kernel/vdso.c
>+++ b/arch/powerpc/kernel/vdso.c
>@@ -113,18 +113,18 @@ struct vdso_data *arch_get_vdso_data(void *vvar_page)
> int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
> {
>	struct mm_struct *mm = task->mm;
>+	VMA_ITERATOR(vmi, mm, 0);
>	struct vm_area_struct *vma;
>
>	mmap_read_lock(mm);
>-
>-	for (vma = mm->mmap; vma; vma = vma->vm_next) {
>+	for_each_vma(vmi, vma) {
>		unsigned long size = vma->vm_end - vma->vm_start;

Unrelated, but maybe worth abstracting?

$> grep "vma->vm_end - vma->vm_start" |wc -l
216

Thanks,
Davidlohr
