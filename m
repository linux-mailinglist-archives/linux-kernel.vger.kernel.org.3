Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C62EA4AC8D9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 19:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233156AbiBGSts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 13:49:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233351AbiBGSql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 13:46:41 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D340C0401E2
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 10:46:40 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id i5so18068737oih.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 10:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=+wPgud2Zc9iDtR4LrtVArCP3c0J7sHpVkjRO1rtdEVU=;
        b=rxWhrueR31kHGt5dQf3osmpofGeWeGByme6ZPm8EUcT3J4f6Tt7sZFDjp3K3NWw5xH
         8Q1bqeu5wxsLEaOnMXoYGsN18mPQPBVEdebmXxcTrmHR4vjG9GvvLPipaLPDmOKzH7aj
         Cdzf/bIYd4a5aj3X4T3ka4qzRYjIcrTUAB+esqdC0HX2K/9qN1hY4zdajr+McQK9lZyy
         l1g+gbV4gNJFdGxMHJdQlzQ1xSm/xy9VcYiN/7FRNQu5KB2Qao/Sm3jLVITIvrAJE0Uh
         +9o31+ivZbFMykFT9pylTUVqpND/2S6NCCWPd7wd6ZtmMsl3h/NikAsa1aNMGAWcA2Sh
         ZAOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=+wPgud2Zc9iDtR4LrtVArCP3c0J7sHpVkjRO1rtdEVU=;
        b=YelXH+d7sA2F43be+ftGtT2Ze4UavLGztgKC/+RJIoRIpqcw9++u8KUSuBzWRX6Tzj
         iW0Iw/ytLd4Pml6z3hNOI9lIC/20GzB3uooLv0MPN8GgjjGcugCXhj+b61L9vxlReH0v
         ENgDiEDKDoirTXZP3QQAqWCLpu6nXST3b2znLyV7Gx7pn2KapCjMForSkBzQ5nE/wGH+
         b34QUCnqLBbKa6K9fyCxBhRzddIkaa57ZZ2u4adS8D7+lCdhLovEzCIzW7Xbp6Pqd6H8
         3SBYfl7eiqEPLOH5NyV98K4CTGQ/sDXKfXkKN3l+aE4ojCRRf1V5wjLCkcmpNofc0U7z
         39vQ==
X-Gm-Message-State: AOAM533wkvopbbwGRReQywEh9NoKaz/9N2/Qlhp+zvnFgoIQa3zPnPlc
        ZM0IkQnhHFJR8dWSnO3cj6IsQg==
X-Google-Smtp-Source: ABdhPJw+Tl5CzTDCc96VpocDvJbBxdd6ZINurZIdPIxVJUtMyioGW9CzMnzgbCq3WPYRTDAhM0mHJg==
X-Received: by 2002:a05:6808:1b26:: with SMTP id bx38mr134447oib.267.1644259599649;
        Mon, 07 Feb 2022 10:46:39 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id l38sm4414090otl.45.2022.02.07.10.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 10:46:38 -0800 (PST)
Date:   Mon, 7 Feb 2022 10:46:36 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Hillf Danton <hdanton@sina.com>
cc:     Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 07/13] mm/munlock: mlock_pte_range() when mlocking or
 munlocking
In-Reply-To: <20220207033518.2602-1-hdanton@sina.com>
Message-ID: <203c549d-ad8-948d-1a3a-13be026864e@google.com>
References: <8e4356d-9622-a7f0-b2c-f116b5f2efea@google.com> <20220207033518.2602-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Feb 2022, Hillf Danton wrote:
> On Sun, 6 Feb 2022 13:42:09 -0800 (PST) Hugh Dickins wrote:
> > +static void mlock_vma_pages_range(struct vm_area_struct *vma,
> > +	unsigned long start, unsigned long end, vm_flags_t newflags)
> >  {
> > -	/* Reimplementation to follow in later commit */
> > +	static const struct mm_walk_ops mlock_walk_ops = {
> > +		.pmd_entry = mlock_pte_range,
> > +	};
> > +
> > +	/*
> > +	 * There is a slight chance that concurrent page migration,
> > +	 * or page reclaim finding a page of this now-VM_LOCKED vma,
> > +	 * will call mlock_vma_page() and raise page's mlock_count:
> > +	 * double counting, leaving the page unevictable indefinitely.
> > +	 * Communicate this danger to mlock_vma_page() with VM_IO,
> > +	 * which is a VM_SPECIAL flag not allowed on VM_LOCKED vmas.
> > +	 * mmap_lock is held in write mode here, so this weird
> > +	 * combination should not be visible to others.
> > +	 */
> > +	if (newflags & VM_LOCKED)
> > +		newflags |= VM_IO;
> > +	WRITE_ONCE(vma->vm_flags, newflags);
> 
> Nit
> 
> The WRITE_ONCE is not needed, given the certainty of invisibility to
> others - it will quiesce syzbot reporting the case of visibility.

Ah, maybe I can rewrite that comment better: when I said "visible to
others", I meant visible to "the outside world", those participating in
the usual mmap_lock'ed access, syscalls and /proc/pid/maps and smaps etc.

The point here is that some kernel low-level internals (page migration
and page reclaim) peek at vma->vm_flags without mmap_lock (but with
anon_vma lock or i_mmap_rwsem).

Originally I had VM_LOCKED set in vma->vm_flags before calling
mlock_vma_pages_range(), no need for a newflags parameter.  Then
realized that left a tiny window in which VM_LOCKED was visible to
migration and reclaim without the safening VM_IO, so changed it to pass
in newflags, then "newflags |= VM_IO", then "vma->vm_flags = newflags"
there.   Then realized that perhaps an uncooperative compiler might be
inspired to mutate that into "vma->vm_flags = newflags" followed by
"vma->vm_flags |= VM_IO".  I hope it would not, but can I be sure
that it would not?  That's why I ended up with WRITE_ONCE() there.

Maybe all rather overkill: but trying to ensure that we undercount
mmap_locked rather than risk overcounting it.

Hugh
