Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9108D59954F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 08:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345998AbiHSGZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 02:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235053AbiHSGZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 02:25:03 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E137CD53D
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 23:25:02 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id j6so2687092qkl.10
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 23:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=26nmAnlydKQkjVDkHJYBHNaK8DPuUkAbtkOG5CxbqH8=;
        b=GdFtsRG9Ii8GEzVlpuOeu5L9aBxu2YlnICTASsx//tAFa4vYfZgzhBj29SnGf6aYZf
         zzvxI73IomIJgY2KABmp0gW/XaeTNvsRBjrJyRtzacNPXjqWREBC/YVJANZss/AFH3m1
         PUiGfdG8Pofd2KQYvrIciRb02TJgAMAIfwHTQ5qjM53dh/Cl5ymMwt0QfIn/PmecM4Js
         Vk76GMwcWh/5GRzspkB4PmU5SGM7S67JK/bZCtPq97BpCxh4egLe6FQGUQaWsgJF5cWc
         r78Z2Tdf1mR5SjZ93dA9sW00hOMZfSNld+huTcX2ib5mU7PDmEDjASVUiiBq8kmVsVsf
         aQkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=26nmAnlydKQkjVDkHJYBHNaK8DPuUkAbtkOG5CxbqH8=;
        b=6OZGcAHcPh0Mloda+qkKgbsfvVw3uRrWKpHlRluRF+sWNU+fzhrdTj3Wi6LE1fqsm6
         9kTSb1UmNkuKSowCWTcs4FC2y9y1/u6lvX6rtSTAxBMfeMUR98ur3rflEDCBg3iGnYwN
         yoEo9wUGkNNFN0VdeQLbP1mI7f5GKQ3g5Tz1Nm9pnJhRWu6tq1yKc9KEQAIGwAYHtDKm
         +va3ltZn7m7BFON6cWFpyzWqPTKQOSGA3VSuzQYE8rbR3XgWBNS2zwhWLdehoZZPfSLX
         iT46q/4iq2yUX3gvRim/JsF3jlsoPmpYejghdFFKFLThzGXks1d31mPVkNadoYXFS/E1
         AldA==
X-Gm-Message-State: ACgBeo2vbqN7/XMuzAIx03JQhu+i0uPgR6K/eALjFp5REQUB6Ht+CT3m
        QhOZVlK5pO/lpNZkc6QlNz0=
X-Google-Smtp-Source: AA6agR4N6B7UwaIbnp9EgbmsiHwp42MfFxNvur+XdJefVPTlBUY6O1nvwBihKvDMjR85oZGbQM4hvw==
X-Received: by 2002:a05:620a:3729:b0:6bb:6412:f905 with SMTP id de41-20020a05620a372900b006bb6412f905mr4431193qkb.144.1660890300878;
        Thu, 18 Aug 2022 23:25:00 -0700 (PDT)
Received: from sophie ([89.46.62.64])
        by smtp.gmail.com with ESMTPSA id s11-20020a05620a0bcb00b006bb9125363fsm3345651qki.121.2022.08.18.23.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 23:25:00 -0700 (PDT)
Date:   Thu, 18 Aug 2022 23:22:47 -0700
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     "Huang, Shaoqin" <shaoqin.huang@intel.com>
Cc:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 6/8] memblock tests: update alloc_nid_api to test
 memblock_alloc_try_nid_raw
Message-ID: <20220819062247.GC3930@sophie>
References: <cover.1660454730.git.remckee0@gmail.com>
 <4c9b416480a5070f18c3933a1a03296f32c2091b.1660454730.git.remckee0@gmail.com>
 <b9bf1263-5862-5bb5-eaf1-399904717c49@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9bf1263-5862-5bb5-eaf1-399904717c49@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 09:24:53AM +0800, Huang, Shaoqin wrote:
> 
> 
> On 8/14/2022 1:53 PM, Rebecca Mckeever wrote:
> > Update memblock_alloc_try_nid() tests so that they test either
> > memblock_alloc_try_nid() or memblock_alloc_try_nid_raw() depending on the
> > value of alloc_nid_test_flags. Run through all the existing tests in
> > alloc_nid_api twice: once for memblock_alloc_try_nid() and once for
> > memblock_alloc_try_nid_raw().
> > 
> > When the tests run memblock_alloc_try_nid(), they test that the entire
> > memory region is zero. When the tests run memblock_alloc_try_nid_raw(),
> > they test that the entire memory region is nonzero.
> > 
> > Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
> > ---
> >   tools/testing/memblock/tests/alloc_nid_api.c | 196 ++++++++++++-------
> >   1 file changed, 127 insertions(+), 69 deletions(-)
> > 
> > diff --git a/tools/testing/memblock/tests/alloc_nid_api.c b/tools/testing/memblock/tests/alloc_nid_api.c
> > index 82fa8ea36320..e16106d8446b 100644
> > --- a/tools/testing/memblock/tests/alloc_nid_api.c
> > +++ b/tools/testing/memblock/tests/alloc_nid_api.c
> > @@ -1,6 +1,42 @@
> >   // SPDX-License-Identifier: GPL-2.0-or-later
> >   #include "alloc_nid_api.h"
> > +static const char * const func_testing[] = {
> > +	"memblock_alloc_try_nid",
> > +	"memblock_alloc_try_nid_raw"
> > +};
> > +
> > +static int alloc_nid_test_flags = TEST_ZEROED;
> > +
> > +static inline const char * const get_func_testing(int flags)
> > +{
> > +	if (flags & TEST_RAW)
> > +		return func_testing[1];
> > +	else
> > +		return func_testing[0];
> > +}
> > +
> > +static inline void *run_memblock_alloc_try_nid(phys_addr_t size,
> > +					       phys_addr_t align,
> > +					       phys_addr_t min_addr,
> > +					       phys_addr_t max_addr, int nid)
> > +{
> > +	if (alloc_nid_test_flags & TEST_RAW)
> > +		return memblock_alloc_try_nid_raw(size, align, min_addr,
> > +						  max_addr, nid);
> > +	else
> > +		return memblock_alloc_try_nid(size, align, min_addr,
> > +					      max_addr, nid);
> > +}
> > +
> > +static inline void verify_mem_content(void *mem, int size)
> > +{
> > +	if (alloc_nid_test_flags & TEST_RAW)
> > +		ASSERT_MEM_NE((char *)mem, 0, size);
> > +	else
> > +		ASSERT_MEM_EQ((char *)mem, 0, size);
> > +}
> > +
> 
> These static functions seems the same with the PATCH5 did, have you
> considered to keep only one common function?
> 
I considered it. The function will need to have a flags parameter added
to it if the definition is moved to common.h. I will make this change.

> >   /*
> >    * A simple test that tries to allocate a memory region within min_addr and
> >    * max_addr range:
> > @@ -32,12 +68,13 @@ static int alloc_try_nid_top_down_simple_check(void)
> >   	min_addr = memblock_start_of_DRAM() + SMP_CACHE_BYTES * 2;
> >   	max_addr = min_addr + SZ_512;
> > -	allocated_ptr = memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
> > -					       min_addr, max_addr, NUMA_NO_NODE);
> > +	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
> > +						   min_addr, max_addr,
> > +						   NUMA_NO_NODE);
> >   	rgn_end = rgn->base + rgn->size;
> >   	ASSERT_NE(allocated_ptr, NULL);
> > -	ASSERT_MEM_EQ((char *)allocated_ptr, 0, size);
> > +	verify_mem_content(allocated_ptr, size);
> >   	ASSERT_EQ(rgn->size, size);
> >   	ASSERT_EQ(rgn->base, max_addr - size);
> > @@ -86,12 +123,13 @@ static int alloc_try_nid_top_down_end_misaligned_check(void)
> >   	min_addr = memblock_start_of_DRAM() + SMP_CACHE_BYTES * 2;
> >   	max_addr = min_addr + SZ_512 + misalign;
> > -	allocated_ptr = memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
> > -					       min_addr, max_addr, NUMA_NO_NODE);
> > +	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
> > +						   min_addr, max_addr,
> > +						   NUMA_NO_NODE);
> >   	rgn_end = rgn->base + rgn->size;
> >   	ASSERT_NE(allocated_ptr, NULL);
> > -	ASSERT_MEM_EQ((char *)allocated_ptr, 0, size);
> > +	verify_mem_content(allocated_ptr, size);
> >   	ASSERT_EQ(rgn->size, size);
> >   	ASSERT_EQ(rgn->base, max_addr - size - misalign);
> > @@ -137,12 +175,13 @@ static int alloc_try_nid_exact_address_generic_check(void)
> >   	min_addr = memblock_start_of_DRAM() + SMP_CACHE_BYTES;
> >   	max_addr = min_addr + size;
> > -	allocated_ptr = memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
> > -					       min_addr, max_addr, NUMA_NO_NODE);
> > +	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
> > +						   min_addr, max_addr,
> > +						   NUMA_NO_NODE);
> >   	rgn_end = rgn->base + rgn->size;
> >   	ASSERT_NE(allocated_ptr, NULL);
> > -	ASSERT_MEM_EQ((char *)allocated_ptr, 0, size);
> > +	verify_mem_content(allocated_ptr, size);
> >   	ASSERT_EQ(rgn->size, size);
> >   	ASSERT_EQ(rgn->base, min_addr);
> > @@ -189,11 +228,12 @@ static int alloc_try_nid_top_down_narrow_range_check(void)
> >   	min_addr = memblock_start_of_DRAM() + SZ_512;
> >   	max_addr = min_addr + SMP_CACHE_BYTES;
> > -	allocated_ptr = memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
> > -					       min_addr, max_addr, NUMA_NO_NODE);
> > +	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
> > +						   min_addr, max_addr,
> > +						   NUMA_NO_NODE);
> >   	ASSERT_NE(allocated_ptr, NULL);
> > -	ASSERT_MEM_EQ((char *)allocated_ptr, 0, size);
> > +	verify_mem_content(allocated_ptr, size);
> >   	ASSERT_EQ(rgn->size, size);
> >   	ASSERT_EQ(rgn->base, max_addr - size);
> > @@ -241,8 +281,9 @@ static int alloc_try_nid_low_max_generic_check(void)
> >   	min_addr = memblock_start_of_DRAM();
> >   	max_addr = min_addr + SMP_CACHE_BYTES;
> > -	allocated_ptr = memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
> > -					       min_addr, max_addr, NUMA_NO_NODE);
> > +	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
> > +						   min_addr, max_addr,
> > +						   NUMA_NO_NODE);
> >   	ASSERT_EQ(allocated_ptr, NULL);
> > @@ -287,11 +328,12 @@ static int alloc_try_nid_min_reserved_generic_check(void)
> >   	memblock_reserve(reserved_base, r1_size);
> > -	allocated_ptr = memblock_alloc_try_nid(r2_size, SMP_CACHE_BYTES,
> > -					       min_addr, max_addr, NUMA_NO_NODE);
> > +	allocated_ptr = run_memblock_alloc_try_nid(r2_size, SMP_CACHE_BYTES,
> > +						   min_addr, max_addr,
> > +						   NUMA_NO_NODE);
> >   	ASSERT_NE(allocated_ptr, NULL);
> > -	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r2_size);
> > +	verify_mem_content(allocated_ptr, r2_size);
> >   	ASSERT_EQ(rgn->size, total_size);
> >   	ASSERT_EQ(rgn->base, reserved_base);
> > @@ -338,11 +380,12 @@ static int alloc_try_nid_max_reserved_generic_check(void)
> >   	memblock_reserve(max_addr, r1_size);
> > -	allocated_ptr = memblock_alloc_try_nid(r2_size, SMP_CACHE_BYTES,
> > -					       min_addr, max_addr, NUMA_NO_NODE);
> > +	allocated_ptr = run_memblock_alloc_try_nid(r2_size, SMP_CACHE_BYTES,
> > +						   min_addr, max_addr,
> > +						   NUMA_NO_NODE);
> >   	ASSERT_NE(allocated_ptr, NULL);
> > -	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r2_size);
> > +	verify_mem_content(allocated_ptr, r2_size);
> >   	ASSERT_EQ(rgn->size, total_size);
> >   	ASSERT_EQ(rgn->base, min_addr);
> > @@ -402,11 +445,12 @@ static int alloc_try_nid_top_down_reserved_with_space_check(void)
> >   	memblock_reserve(r1.base, r1.size);
> >   	memblock_reserve(r2.base, r2.size);
> > -	allocated_ptr = memblock_alloc_try_nid(r3_size, SMP_CACHE_BYTES,
> > -					       min_addr, max_addr, NUMA_NO_NODE);
> > +	allocated_ptr = run_memblock_alloc_try_nid(r3_size, SMP_CACHE_BYTES,
> > +						   min_addr, max_addr,
> > +						   NUMA_NO_NODE);
> >   	ASSERT_NE(allocated_ptr, NULL);
> > -	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r3_size);
> > +	verify_mem_content(allocated_ptr, r3_size);
> >   	ASSERT_EQ(rgn1->size, r1.size + r3_size);
> >   	ASSERT_EQ(rgn1->base, max_addr - r3_size);
> > @@ -466,11 +510,12 @@ static int alloc_try_nid_reserved_full_merge_generic_check(void)
> >   	memblock_reserve(r1.base, r1.size);
> >   	memblock_reserve(r2.base, r2.size);
> > -	allocated_ptr = memblock_alloc_try_nid(r3_size, SMP_CACHE_BYTES,
> > -					       min_addr, max_addr, NUMA_NO_NODE);
> > +	allocated_ptr = run_memblock_alloc_try_nid(r3_size, SMP_CACHE_BYTES,
> > +						   min_addr, max_addr,
> > +						   NUMA_NO_NODE);
> >   	ASSERT_NE(allocated_ptr, NULL);
> > -	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r3_size);
> > +	verify_mem_content(allocated_ptr, r3_size);
> >   	ASSERT_EQ(rgn->size, total_size);
> >   	ASSERT_EQ(rgn->base, r2.base);
> > @@ -531,11 +576,12 @@ static int alloc_try_nid_top_down_reserved_no_space_check(void)
> >   	memblock_reserve(r1.base, r1.size);
> >   	memblock_reserve(r2.base, r2.size);
> > -	allocated_ptr = memblock_alloc_try_nid(r3_size, SMP_CACHE_BYTES,
> > -					       min_addr, max_addr, NUMA_NO_NODE);
> > +	allocated_ptr = run_memblock_alloc_try_nid(r3_size, SMP_CACHE_BYTES,
> > +						   min_addr, max_addr,
> > +						   NUMA_NO_NODE);
> >   	ASSERT_NE(allocated_ptr, NULL);
> > -	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r3_size);
> > +	verify_mem_content(allocated_ptr, r3_size);
> >   	ASSERT_EQ(rgn1->size, r1.size);
> >   	ASSERT_EQ(rgn1->base, r1.base);
> > @@ -597,8 +643,9 @@ static int alloc_try_nid_reserved_all_generic_check(void)
> >   	memblock_reserve(r1.base, r1.size);
> >   	memblock_reserve(r2.base, r2.size);
> > -	allocated_ptr = memblock_alloc_try_nid(r3_size, SMP_CACHE_BYTES,
> > -					       min_addr, max_addr, NUMA_NO_NODE);
> > +	allocated_ptr = run_memblock_alloc_try_nid(r3_size, SMP_CACHE_BYTES,
> > +						   min_addr, max_addr,
> > +						   NUMA_NO_NODE);
> >   	ASSERT_EQ(allocated_ptr, NULL);
> > @@ -628,11 +675,12 @@ static int alloc_try_nid_top_down_cap_max_check(void)
> >   	min_addr = memblock_end_of_DRAM() - SZ_1K;
> >   	max_addr = memblock_end_of_DRAM() + SZ_256;
> > -	allocated_ptr = memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
> > -					       min_addr, max_addr, NUMA_NO_NODE);
> > +	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
> > +						   min_addr, max_addr,
> > +						   NUMA_NO_NODE);
> >   	ASSERT_NE(allocated_ptr, NULL);
> > -	ASSERT_MEM_EQ((char *)allocated_ptr, 0, size);
> > +	verify_mem_content(allocated_ptr, size);
> >   	ASSERT_EQ(rgn->size, size);
> >   	ASSERT_EQ(rgn->base, memblock_end_of_DRAM() - size);
> > @@ -666,11 +714,12 @@ static int alloc_try_nid_top_down_cap_min_check(void)
> >   	min_addr = memblock_start_of_DRAM() - SZ_256;
> >   	max_addr = memblock_end_of_DRAM();
> > -	allocated_ptr = memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
> > -					       min_addr, max_addr, NUMA_NO_NODE);
> > +	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
> > +						   min_addr, max_addr,
> > +						   NUMA_NO_NODE);
> >   	ASSERT_NE(allocated_ptr, NULL);
> > -	ASSERT_MEM_EQ((char *)allocated_ptr, 0, size);
> > +	verify_mem_content(allocated_ptr, size);
> >   	ASSERT_EQ(rgn->size, size);
> >   	ASSERT_EQ(rgn->base, memblock_end_of_DRAM() - size);
> > @@ -714,13 +763,13 @@ static int alloc_try_nid_bottom_up_simple_check(void)
> >   	min_addr = memblock_start_of_DRAM() + SMP_CACHE_BYTES * 2;
> >   	max_addr = min_addr + SZ_512;
> > -	allocated_ptr = memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
> > -					       min_addr, max_addr,
> > -					       NUMA_NO_NODE);
> > +	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
> > +						   min_addr, max_addr,
> > +						   NUMA_NO_NODE);
> >   	rgn_end = rgn->base + rgn->size;
> >   	ASSERT_NE(allocated_ptr, NULL);
> > -	ASSERT_MEM_EQ((char *)allocated_ptr, 0, size);
> > +	verify_mem_content(allocated_ptr, size);
> >   	ASSERT_EQ(rgn->size, size);
> >   	ASSERT_EQ(rgn->base, min_addr);
> > @@ -769,13 +818,13 @@ static int alloc_try_nid_bottom_up_start_misaligned_check(void)
> >   	min_addr = memblock_start_of_DRAM() + misalign;
> >   	max_addr = min_addr + SZ_512;
> > -	allocated_ptr = memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
> > -					       min_addr, max_addr,
> > -					       NUMA_NO_NODE);
> > +	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
> > +						   min_addr, max_addr,
> > +						   NUMA_NO_NODE);
> >   	rgn_end = rgn->base + rgn->size;
> >   	ASSERT_NE(allocated_ptr, NULL);
> > -	ASSERT_MEM_EQ((char *)allocated_ptr, 0, size);
> > +	verify_mem_content(allocated_ptr, size);
> >   	ASSERT_EQ(rgn->size, size);
> >   	ASSERT_EQ(rgn->base, min_addr + (SMP_CACHE_BYTES - misalign));
> > @@ -822,12 +871,12 @@ static int alloc_try_nid_bottom_up_narrow_range_check(void)
> >   	min_addr = memblock_start_of_DRAM() + SZ_512;
> >   	max_addr = min_addr + SMP_CACHE_BYTES;
> > -	allocated_ptr = memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
> > -					       min_addr, max_addr,
> > -					       NUMA_NO_NODE);
> > +	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
> > +						   min_addr, max_addr,
> > +						   NUMA_NO_NODE);
> >   	ASSERT_NE(allocated_ptr, NULL);
> > -	ASSERT_MEM_EQ((char *)allocated_ptr, 0, size);
> > +	verify_mem_content(allocated_ptr, size);
> >   	ASSERT_EQ(rgn->size, size);
> >   	ASSERT_EQ(rgn->base, memblock_start_of_DRAM());
> > @@ -887,12 +936,12 @@ static int alloc_try_nid_bottom_up_reserved_with_space_check(void)
> >   	memblock_reserve(r1.base, r1.size);
> >   	memblock_reserve(r2.base, r2.size);
> > -	allocated_ptr = memblock_alloc_try_nid(r3_size, SMP_CACHE_BYTES,
> > -					       min_addr, max_addr,
> > -					       NUMA_NO_NODE);
> > +	allocated_ptr = run_memblock_alloc_try_nid(r3_size, SMP_CACHE_BYTES,
> > +						   min_addr, max_addr,
> > +						   NUMA_NO_NODE);
> >   	ASSERT_NE(allocated_ptr, NULL);
> > -	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r3_size);
> > +	verify_mem_content(allocated_ptr, r3_size);
> >   	ASSERT_EQ(rgn1->size, r1.size);
> >   	ASSERT_EQ(rgn1->base, max_addr);
> > @@ -959,12 +1008,12 @@ static int alloc_try_nid_bottom_up_reserved_no_space_check(void)
> >   	memblock_reserve(r1.base, r1.size);
> >   	memblock_reserve(r2.base, r2.size);
> > -	allocated_ptr = memblock_alloc_try_nid(r3_size, SMP_CACHE_BYTES,
> > -					       min_addr, max_addr,
> > -					       NUMA_NO_NODE);
> > +	allocated_ptr = run_memblock_alloc_try_nid(r3_size, SMP_CACHE_BYTES,
> > +						   min_addr, max_addr,
> > +						   NUMA_NO_NODE);
> >   	ASSERT_NE(allocated_ptr, NULL);
> > -	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r3_size);
> > +	verify_mem_content(allocated_ptr, r3_size);
> >   	ASSERT_EQ(rgn3->size, r3_size);
> >   	ASSERT_EQ(rgn3->base, memblock_start_of_DRAM());
> > @@ -1004,12 +1053,12 @@ static int alloc_try_nid_bottom_up_cap_max_check(void)
> >   	min_addr = memblock_start_of_DRAM() + SZ_1K;
> >   	max_addr = memblock_end_of_DRAM() + SZ_256;
> > -	allocated_ptr = memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
> > -					       min_addr, max_addr,
> > -					       NUMA_NO_NODE);
> > +	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
> > +						   min_addr, max_addr,
> > +						   NUMA_NO_NODE);
> >   	ASSERT_NE(allocated_ptr, NULL);
> > -	ASSERT_MEM_EQ((char *)allocated_ptr, 0, size);
> > +	verify_mem_content(allocated_ptr, size);
> >   	ASSERT_EQ(rgn->size, size);
> >   	ASSERT_EQ(rgn->base, min_addr);
> > @@ -1043,12 +1092,12 @@ static int alloc_try_nid_bottom_up_cap_min_check(void)
> >   	min_addr = memblock_start_of_DRAM();
> >   	max_addr = memblock_end_of_DRAM() - SZ_256;
> > -	allocated_ptr = memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
> > -					       min_addr, max_addr,
> > -					       NUMA_NO_NODE);
> > +	allocated_ptr = run_memblock_alloc_try_nid(size, SMP_CACHE_BYTES,
> > +						   min_addr, max_addr,
> > +						   NUMA_NO_NODE);
> >   	ASSERT_NE(allocated_ptr, NULL);
> > -	ASSERT_MEM_EQ((char *)allocated_ptr, 0, size);
> > +	verify_mem_content(allocated_ptr, size);
> >   	ASSERT_EQ(rgn->size, size);
> >   	ASSERT_EQ(rgn->base, memblock_start_of_DRAM());
> > @@ -1193,13 +1242,14 @@ static int alloc_try_nid_low_max_check(void)
> >   	return 0;
> >   }
> > -int memblock_alloc_nid_checks(void)
> > +static int memblock_alloc_nid_checks_internal(int flags)
> >   {
> > -	const char *func_testing = "memblock_alloc_try_nid";
> > +	const char *func = get_func_testing(flags);
> > +	alloc_nid_test_flags = flags;
> >   	prefix_reset();
> > -	prefix_push(func_testing);
> > -	test_print("Running %s tests...\n", func_testing);
> > +	prefix_push(func);
> > +	test_print("Running %s tests...\n", func);
> >   	reset_memblock_attributes();
> >   	dummy_physical_memory_init();
> > @@ -1225,3 +1275,11 @@ int memblock_alloc_nid_checks(void)
> >   	return 0;
> >   }
> > +
> > +int memblock_alloc_nid_checks(void)
> > +{
> > +	memblock_alloc_nid_checks_internal(TEST_ZEROED);
> > +	memblock_alloc_nid_checks_internal(TEST_RAW);
> > +
> > +	return 0;
> > +}

Thanks,
Rebecca
