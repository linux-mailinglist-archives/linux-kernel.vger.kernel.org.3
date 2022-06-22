Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00CFF553FB9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 02:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355351AbiFVAyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 20:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232486AbiFVAya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 20:54:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE5130555
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 17:54:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A911361779
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 00:54:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75AF1C3411C;
        Wed, 22 Jun 2022 00:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1655859268;
        bh=zLsY+cejV+MgclUFmOF+mIQDLT4L2Ve05RVVgccPDrA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XNrLpe2+ivTPocj4W6ZZu2HHIhSZO6AnpOUGLFm51EjN735JLsBaPIJRohI7IJMBw
         i+U2Hkp7Pch29MsPOaiW6Lll4BwC1xAv2fL2qILdtQKqUnVzIz6ZUqDfu4RUPuaby8
         3XfL5ZLlvtNlmzVCUP4YRCupF++kOQ2a07ZGN/wI=
Date:   Tue, 21 Jun 2022 17:54:12 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Zach O'Keefe" <zokeefe@google.com>
Cc:     Yang Shi <shy828301@gmail.com>, vbabka@suse.cz,
        kirill.shutemov@linux.intel.com, willy@infradead.org,
        linmiaohe@huawei.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v5 PATCH 4/7] mm: thp: kill transparent_hugepage_active()
Message-Id: <20220621175412.02d90df5f381de0cd676adf8@linux-foundation.org>
In-Reply-To: <YrIU2iP0H5LQbV7R@google.com>
References: <20220616174840.1202070-1-shy828301@gmail.com>
        <20220616174840.1202070-5-shy828301@gmail.com>
        <YrIU2iP0H5LQbV7R@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_RED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jun 2022 11:58:34 -0700 "Zach O'Keefe" <zokeefe@google.com> wrote:

> > -bool transparent_hugepage_active(struct vm_area_struct *vma)
> > +bool hugepage_vma_check(struct vm_area_struct *vma,
> > +			unsigned long vm_flags,
> > +			bool smaps)
> >  {
> > -	/* The addr is used to check if the vma size fits */
> > -	unsigned long addr = (vma->vm_end & HPAGE_PMD_MASK) - HPAGE_PMD_SIZE;
> > +	if (!transhuge_vma_enabled(vma, vm_flags))
> > +		return false;
> > +
> 
> During testing my work on top this patch, I found a small bug here.
> 
> Namely, transhuge_vma_enabled() will check vma->vm_mm->flags (to see if
> MMF_DISABLE_THP is set); however, for vDSO vmas, vma->vm_mm is NULL.
> 
> Previously, transparent_hugepage_active() in smaps path would check
> transhuge_vma_suitable() before checking these flags, which would fail for vDSO
> vma since we'd take the !vma_is_anonymous() branch and find the vma (most
> likely) wasn't suitably aligned (by chance ?).
> 
> Anyways, I think we need to check vma->vm_mm.

Like this?

--- a/mm/huge_memory.c~mm-thp-kill-transparent_hugepage_active-fix
+++ a/mm/huge_memory.c
@@ -73,6 +73,9 @@ bool hugepage_vma_check(struct vm_area_s
 			unsigned long vm_flags,
 			bool smaps)
 {
+	if (!vma->vm_mm)
+		return false;
+
 	if (!transhuge_vma_enabled(vma, vm_flags))
 		return false;
 
_

