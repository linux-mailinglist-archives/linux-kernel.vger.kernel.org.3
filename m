Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 793765AF254
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 19:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237290AbiIFRWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 13:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234270AbiIFRVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 13:21:48 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80CFFDEAE
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 10:10:33 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 988E04C3F37;
        Tue,  6 Sep 2022 17:10:25 +0000 (UTC)
Received: from pdx1-sub0-mail-a211 (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id C5BB24C3C6C;
        Tue,  6 Sep 2022 17:10:24 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1662484224; a=rsa-sha256;
        cv=none;
        b=zgAHNbYC5FrdP4VVP2MorpEO+ZIPdsUeR5GDpNTmiYBBNjbWXaSi1FJn4Fea/8SBYhAALo
        s3XfvfoK36cAswBRR6jPCocWVV6QpHZSj5jJArYExjKBMYRKBZG3cEtk/8n7ST/uyFdzkN
        A0BErhGlk57wgl+B9pMouzD6T94enefvgNdDMOKxMt9ew3LHTSQAyXvNNMLs062oDDvdBu
        yA75kww9U0LSL/6RzCtV8dFRcLCAcrOtUJThuMC8Q2QsnjBC2zKyXuoXJH7lpBRrUwk/U9
        Nz+1Ep6Q6hmL87lttfHSWQ5sScTx0zKh74nC6JRee4J19WhVpv7rihk2bngP3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1662484224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=lGvdrXQWsfc/OsusfvanHUHGYlpiTvqUNzHfFJSSOVA=;
        b=Oy1+1qrWpegx52bHWzXZGdKdqwfkWQ8zufOOSJYPWjkf7YxCFIR9fJR7odEoEjPrAjV4Ap
        W4Zy9dYem2bfRzVxyqART/XJppRnrhJWtGS2oJehTY19uyvoNHLYoHzOXrUN4jcXZKdHVt
        tnGZSGvRCZDPxVu1zricmW/7j6SCjbFAYjvuXVbFqqHnXqsrUkdlQaPVPTmrtt0vS9v/ft
        Ch8J3Bc7n3Vvi6einUd8f6XxApdats6/QFQM9lWlLZPglOKD/xDTU5lqw1X1lsd9enkk6K
        8GlgO4Nkz29D76iJTGJkANwRroWvZy9JXbotDY+3zTrxEriKoJs8AqajKF4FuQ==
ARC-Authentication-Results: i=1;
        rspamd-686945db84-dxs52;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Exultant-Befitting: 0b92a02e7ea825cf_1662484225163_2280857564
X-MC-Loop-Signature: 1662484225163:2261953375
X-MC-Ingress-Time: 1662484225163
Received: from pdx1-sub0-mail-a211 (pop.dreamhost.com [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.126.240.197 (trex/6.7.1);
        Tue, 06 Sep 2022 17:10:25 +0000
Received: from offworld (unknown [104.36.31.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a211 (Postfix) with ESMTPSA id 4MMX2R4kskz90;
        Tue,  6 Sep 2022 10:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1662484224;
        bh=lGvdrXQWsfc/OsusfvanHUHGYlpiTvqUNzHfFJSSOVA=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=kMikivsUxbzpvh9f4LHgHoXliUnVV74+xEfbwSs6189+ZQvH3G8YVrt0oxgU0UWms
         5iSIhbyIvIUz/PPiFGGewfe6LlWU/xpphUWjoFbl9Jd39+torUPAhE5eqltYRA5hn2
         DfILM5zuRi4RGDRPb7Idt27T8YovMDNYHC29RgFXXuW4BFgk9gIS3Kvbe0z/ycegKK
         0rpf/TjWHt/0OdGoB+a5bng2kYqMOr970mAawOXqgQe9D1BTFKGQ9IlQrVvYBeNhht
         u2bmYsc50POUSieJN3/fxZdb9z5PO4JlVwmyBn3OdiMxHf8DbUTOPdtSeZHIZgzIrM
         oIAWeUCExNp2w==
Date:   Tue, 6 Sep 2022 09:51:32 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: Re: [PATCH v13 52/70] mm/khugepaged: stop using vma linked list
Message-ID: <20220906165132.jv6y6if6t576wdjl@offworld>
Mail-Followup-To: Liam Howlett <liam.howlett@oracle.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
 <20220822150128.1562046-53-Liam.Howlett@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220822150128.1562046-53-Liam.Howlett@oracle.com>
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
>Use vma iterator & find_vma() instead of vma linked list.
>
>Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

>---
> mm/huge_memory.c |  4 ++--
> mm/khugepaged.c  | 11 ++++++++---
> 2 files changed, 10 insertions(+), 5 deletions(-)
>
>diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>index 83c47a989260..6c5c23ef658a 100644
>--- a/mm/huge_memory.c
>+++ b/mm/huge_memory.c
>@@ -2339,11 +2339,11 @@ void vma_adjust_trans_huge(struct vm_area_struct *vma,
>	split_huge_pmd_if_needed(vma, end);
>
>	/*
>-	 * If we're also updating the vma->vm_next->vm_start,
>+	 * If we're also updating the next vma vm_start,
>	 * check if we need to split it.
>	 */
>	if (adjust_next > 0) {
>-		struct vm_area_struct *next = vma->vm_next;
>+		struct vm_area_struct *next = find_vma(vma->vm_mm, vma->vm_end);
>		unsigned long nstart = next->vm_start;
>		nstart += adjust_next;
>		split_huge_pmd_if_needed(next, nstart);
>diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>index d3313b7a8fe5..d8e388106322 100644
>--- a/mm/khugepaged.c
>+++ b/mm/khugepaged.c
>@@ -2053,10 +2053,12 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
>	__releases(&khugepaged_mm_lock)
>	__acquires(&khugepaged_mm_lock)
> {
>+	struct vma_iterator vmi;
>	struct mm_slot *mm_slot;
>	struct mm_struct *mm;
>	struct vm_area_struct *vma;
>	int progress = 0;
>+	unsigned long address;

Nit: just use khugepaged_scan.address.

>
>	VM_BUG_ON(!pages);
>	lockdep_assert_held(&khugepaged_mm_lock);
>@@ -2081,11 +2083,14 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
>	vma = NULL;
>	if (unlikely(!mmap_read_trylock(mm)))
>		goto breakouterloop_mmap_lock;
>-	if (likely(!hpage_collapse_test_exit(mm)))
>-		vma = find_vma(mm, khugepaged_scan.address);
>
>	progress++;
>-	for (; vma; vma = vma->vm_next) {
>+	if (unlikely(hpage_collapse_test_exit(mm)))
>+		goto breakouterloop;
>+
>+	address = khugepaged_scan.address;
>+	vma_iter_init(&vmi, mm, address);
>+	for_each_vma(vmi, vma) {
>		unsigned long hstart, hend;
>
>		cond_resched();
>
>--
>2.35.1
>
