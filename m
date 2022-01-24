Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3E0497D88
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 12:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234207AbiAXLBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 06:01:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23769 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229610AbiAXLBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 06:01:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643022074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9pIWysbK7uAS4zY0QBr87aHP0XtUU5Z92lI6LszdCnk=;
        b=IQQSF4jZnC0Obg2De39ACNa27CbB4TEawkUXrjjbthOVW9yS4PVx1Eon36iIajoGXs5AnI
        V/oQfRN/TzmYwSGW4OgXePJSOQLzVJ4v50/kNEKCRkCxnnthrYO2ff65RaxzxgZ9RiwKGe
        w9hDaXQ9reu+S5AhWjqDLDH1yuQ8oko=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-2-K0m9C0AfMd2wdQNhaniV1A-1; Mon, 24 Jan 2022 06:01:12 -0500
X-MC-Unique: K0m9C0AfMd2wdQNhaniV1A-1
Received: by mail-pj1-f72.google.com with SMTP id e7-20020a17090ac20700b001b586e65885so2249047pjt.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 03:01:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9pIWysbK7uAS4zY0QBr87aHP0XtUU5Z92lI6LszdCnk=;
        b=YhnuvIPih9VkJpkkkXWEuN/NjjVD6dMEr95KM54QIt9tm1QZRAQNzaKuRT90TfHgdR
         8PCztG5wxQJqc7FgwH0Q8ZwkTbaNfvCEsRUNuhMmaA+H1TgKp+6XSHmagK7VOzQiN/NJ
         F5oIHGE0iepmUMl4R7Lvm3+ET3CKItVnXgS2NJRrMaAuXCgvo4FS/gv7rLrPPm2J/xPB
         akbm1JmePle4PF51mivpmdSAJ/4ZJpWiahlM0kmWtaHYFfL5Xe2aReh9aJsY7tbSP/Ri
         oh91u/1Q55njQfefheeQiusYUAbUnYp5vaRmHEM+nr/830EsLYN8OAaqKk6YcaoqR7FV
         gxCQ==
X-Gm-Message-State: AOAM533egkOifpIKOEuSN7KNFqXdwoVd5XFUaXfa2DtFxtN6OW/l7fwW
        r4fPnyLMfLu8w+PPGkIbI9b0gM+ASp6+oEJjmM35lHsHhc/+E022Vv/OAE83d+pC6aHpYpNU+sl
        i7Ry1yIBb3d82l5XpEKaGnrzn
X-Received: by 2002:a17:902:ec8d:b0:14b:12aa:dc6b with SMTP id x13-20020a170902ec8d00b0014b12aadc6bmr13959020plg.110.1643022071643;
        Mon, 24 Jan 2022 03:01:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyZYHhviLUCVWev5Ra3LhgWopKWizHfMu72oNVWNnslOg4Cv35SXQF8v3cr3YdtXOFT90jpSw==
X-Received: by 2002:a17:902:ec8d:b0:14b:12aa:dc6b with SMTP id x13-20020a170902ec8d00b0014b12aadc6bmr13958995plg.110.1643022071335;
        Mon, 24 Jan 2022 03:01:11 -0800 (PST)
Received: from xz-m1.local ([94.177.118.73])
        by smtp.gmail.com with ESMTPSA id gt19sm12681405pjb.50.2022.01.24.03.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 03:01:10 -0800 (PST)
Date:   Mon, 24 Jan 2022 19:01:04 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alistair Popple <apopple@nvidia.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH RFC v2 1/2] mm: Don't skip swap entry even if zap_details
 specified
Message-ID: <Ye6G8F0VOQRGwcXe@xz-m1.local>
References: <20211115134951.85286-1-peterx@redhat.com>
 <20211115134951.85286-2-peterx@redhat.com>
 <9937aaa-d9ab-2839-b0b7-691d85c9141@google.com>
 <Yd7VEXI+/Lu8MVOo@xz-m1.local>
 <Yd7W6ndSPkXQjurY@xz-m1.local>
 <391aa58d-ce84-9d4-d68d-d98a9c533255@google.com>
 <Yek6PaW8fAXY4Bft@xz-m1.local>
 <93dd745c-5e8b-a50-4ec5-b3f3728ad8b@google.com>
 <Ye5pRQNRv53HWmSZ@xz-m1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Ye5pRQNRv53HWmSZ@xz-m1.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 04:54:29PM +0800, Peter Xu wrote:
> I have a quick idea on reproducer now (perhaps file size shrinking on private
> pages being swapped out), I'll try to write a real reproducer and update later.

Here's the reproducer..

===8<===
#define _GNU_SOURCE         /* See feature_test_macros(7) */
#include <stdio.h>
#include <assert.h>
#include <unistd.h>
#include <sys/mman.h>
#include <sys/types.h>

int page_size;
int shmem_fd;
char *buffer;

void main(void)
{
	int ret;
	char val;

	page_size = getpagesize();
	shmem_fd = memfd_create("test", 0);
	assert(shmem_fd >= 0);

	ret = ftruncate(shmem_fd, page_size * 2);
	assert(ret == 0);

	buffer = mmap(NULL, page_size * 2, PROT_READ | PROT_WRITE,
			MAP_PRIVATE, shmem_fd, 0);
	assert(buffer != MAP_FAILED);

	/* Write private page, swap it out */
	buffer[page_size] = 1;
	madvise(buffer, page_size * 2, MADV_PAGEOUT);

	/* This should drop private buffer[page_size] already */
	ret = ftruncate(shmem_fd, page_size);
	assert(ret == 0);
	/* Recover the size */
	ret = ftruncate(shmem_fd, page_size * 2);
	assert(ret == 0);

	/* Re-read the data, it should be all zero */
	val = buffer[page_size];
	if (val == 0)
		printf("Good\n");
	else
		printf("BUG\n");
}
===8<===

I'm looking for a correct Fixes for the 1st patch, but afaict it seems not
right even in the initial git commit, which traces back to the "history" git
repo of your commit:

dd9fd0e03de6 ("[PATCH] rmap: nonlinear truncation", 2004-04-17)

Where we have:

		/*
		 * If details->check_mapping, we leave swap entries;
		 * if details->nonlinear_vma, we leave file entries.
		 */
		if (unlikely(details))
			continue;
		if (!pte_file(ptent))
			free_swap_and_cache(pte_to_swp_entry(ptent));

As I don't know how it could be right if the user only specified
details->nonlinear_vma but keeping details->check_mapping==NULL.. there, and
there're definitely callers for that, e.g.:

static long madvise_dontneed(struct vm_area_struct * vma,
			     unsigned long start, unsigned long end)
{
	if ((vma->vm_flags & VM_LOCKED) || is_vm_hugetlb_page(vma))
		return -EINVAL;

	if (unlikely(vma->vm_flags & VM_NONLINEAR)) {
		struct zap_details details = {
			.nonlinear_vma = vma,
			.last_index = ULONG_MAX,
		};
		zap_page_range(vma, start, end - start, &details);
	} else
		zap_page_range(vma, start, end - start, NULL);
	return 0;
}

So I plan to add the Fixes to the initial git commit, 1da177e4c3f4
("Linux-2.6.12-rc2", 2005-04-16).

Does it sound right to you?

Thanks,

--
Peter Xu

