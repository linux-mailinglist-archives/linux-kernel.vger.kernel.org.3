Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D12259531D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 08:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbiHPG4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 02:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbiHPGzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 02:55:41 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5371D1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 19:15:25 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id l8so6967718qvr.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 19:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=gB3Bz5AjtMc1DQ28Gy11iyEZdEFjWI/WxGTjW9sxTk4=;
        b=kDpyqKy8UaICjCOfptA2Vxv2ycuXszlDZH6qt9rTGwwmjFFMw0as2C/jXQRMjXjaF0
         QTfJg/qpsP1LtMhzd0UQdzAodu30VegCI1Er6f/wwJvIqXkhdKiyQHufvHyHDGnVRLdo
         WIg5v/KmBK2z6rBfvGZ5DG2BO94oNDow7ZMs7LCYm3l3EwoaOytdL1zaUOW9HYIzVEBd
         LVuDSSRcGxqDjGrBdW/m8Qo9rWAQAjCo3ej2fXpIjyxUPfG8PHYZZ58BRu/V/8JueCu4
         mEzJcoLanv9hXQvTqh6wft8m3kJVsrGDBgkCg9jUqlxqMQqDpio6Euy3BehDX8RFDTvm
         +Okw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=gB3Bz5AjtMc1DQ28Gy11iyEZdEFjWI/WxGTjW9sxTk4=;
        b=i7hr+5zHXHOaIfwPRHgIwQZbyIEVELIk3plKZnKglazleOHfhYyDdE7+l2krKZRd36
         l4gJcYg7LX1IVdZiAQtms7Lye48g8PL6aoKCcHeCg1SkALPn1PT+EnuJ1HdwJNdHyHWf
         UWIRg808+tls8U+b23/wjMrYmOG5nnMiZLG4+ItFL9XXubJ//WmreeVugA1yywrUsfVb
         CEGTrShHo/c12yLG80vN4YDwNavaddTXckMZn4skunaUh8COXUMw+rPtMAGAqyvJlV0N
         J7CWRcnw8ETaczaaL9aVex8Y8XgR+2J7umRCZNepOsZtE9U5V3+1IDg4Fn2445Ntp83g
         gqZA==
X-Gm-Message-State: ACgBeo28tHipt7tUhgv1t9DQb12/xaFIfGpvrdd1KZDpusJXfSthcvp9
        Knx8wM7asLPbbI6xteKz1sGnNU2TfJ7b5Q==
X-Google-Smtp-Source: AA6agR45rSHkYcQeehtkvWA9pSrdBHzeEoYrm7SlmlHjE205JkOiNLcJ4sXer3fnZSKH6KRAClWpAQ==
X-Received: by 2002:ad4:5cc9:0:b0:475:5b35:3b03 with SMTP id iu9-20020ad45cc9000000b004755b353b03mr15928484qvb.42.1660616124808;
        Mon, 15 Aug 2022 19:15:24 -0700 (PDT)
Received: from sophie ([185.156.46.184])
        by smtp.gmail.com with ESMTPSA id ay36-20020a05620a17a400b006baf3ffba23sm7266045qkb.38.2022.08.15.19.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 19:15:24 -0700 (PDT)
Date:   Mon, 15 Aug 2022 21:15:22 -0500
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     "Huang, Shaoqin" <shaoqin.huang@intel.com>
Cc:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 1/8] memblock tests: update tests to check if
 memblock_alloc zeroed memory
Message-ID: <20220816021522.GA3590@sophie>
References: <cover.1660454730.git.remckee0@gmail.com>
 <02d514d86f212c79e52792b8ecd919156d7a9c20.1660454730.git.remckee0@gmail.com>
 <5dde66a7-2236-a890-aaeb-a45876057bec@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5dde66a7-2236-a890-aaeb-a45876057bec@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 04:50:51PM +0800, Huang, Shaoqin wrote:
> Hi, Rebecca.
> 
> On 8/14/2022 1:53 PM, Rebecca Mckeever wrote:
> > Add an assert in memblock_alloc() tests where allocation is expected to
> > occur. The assert checks whether the entire chunk of allocated memory is
> > cleared.
> > 
> > The current memblock_alloc() tests do not check whether the allocated
> > memory was zeroed. memblock_alloc() should zero the allocated memory since
> > it is a wrapper for memblock_alloc_try_nid().
> > 
> > Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
> > ---
> >   tools/testing/memblock/tests/alloc_api.c | 24 ++++++++++++++++++++++++
> >   tools/testing/memblock/tests/common.c    |  7 +++++++
> >   tools/testing/memblock/tests/common.h    | 13 +++++++++++++
> >   3 files changed, 44 insertions(+)
> > 
> > diff --git a/tools/testing/memblock/tests/alloc_api.c b/tools/testing/memblock/tests/alloc_api.c
> > index a14f38eb8a89..71c89cb9b2a8 100644
> > --- a/tools/testing/memblock/tests/alloc_api.c
> > +++ b/tools/testing/memblock/tests/alloc_api.c
> > @@ -22,6 +22,8 @@ static int alloc_top_down_simple_check(void)
> >   	allocated_ptr = memblock_alloc(size, SMP_CACHE_BYTES);
> >   	ASSERT_NE(allocated_ptr, NULL);
> > +	ASSERT_MEM_EQ((char *)allocated_ptr, 0, size);
> > +
> >   	ASSERT_EQ(rgn->size, size);
> >   	ASSERT_EQ(rgn->base, expected_start);
> > @@ -80,6 +82,8 @@ static int alloc_top_down_disjoint_check(void)
> >   	allocated_ptr = memblock_alloc(r2_size, alignment);
> >   	ASSERT_NE(allocated_ptr, NULL);
> > +	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r2_size);
> > +
> >   	ASSERT_EQ(rgn1->size, r1.size);
> >   	ASSERT_EQ(rgn1->base, r1.base);
> > @@ -125,6 +129,8 @@ static int alloc_top_down_before_check(void)
> >   	allocated_ptr = memblock_alloc(r2_size, SMP_CACHE_BYTES);
> >   	ASSERT_NE(allocated_ptr, NULL);
> > +	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r2_size);
> > +
> >   	ASSERT_EQ(rgn->size, total_size);
> >   	ASSERT_EQ(rgn->base, memblock_end_of_DRAM() - total_size);
> > @@ -173,6 +179,8 @@ static int alloc_top_down_after_check(void)
> >   	allocated_ptr = memblock_alloc(r2_size, SMP_CACHE_BYTES);
> >   	ASSERT_NE(allocated_ptr, NULL);
> > +	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r2_size);
> > +
> >   	ASSERT_EQ(rgn->size, total_size);
> >   	ASSERT_EQ(rgn->base, r1.base - r2_size);
> > @@ -223,6 +231,8 @@ static int alloc_top_down_second_fit_check(void)
> >   	allocated_ptr = memblock_alloc(r3_size, SMP_CACHE_BYTES);
> >   	ASSERT_NE(allocated_ptr, NULL);
> > +	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r3_size);
> > +
> >   	ASSERT_EQ(rgn->size, r2.size + r3_size);
> >   	ASSERT_EQ(rgn->base, r2.base - r3_size);
> > @@ -277,6 +287,8 @@ static int alloc_in_between_generic_check(void)
> >   	allocated_ptr = memblock_alloc(r3_size, SMP_CACHE_BYTES);
> >   	ASSERT_NE(allocated_ptr, NULL);
> > +	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r3_size);
> > +
> >   	ASSERT_EQ(rgn->size, total_size);
> >   	ASSERT_EQ(rgn->base, r1.base - r2.size - r3_size);
> > @@ -418,6 +430,8 @@ static int alloc_limited_space_generic_check(void)
> >   	allocated_ptr = memblock_alloc(available_size, SMP_CACHE_BYTES);
> >   	ASSERT_NE(allocated_ptr, NULL);
> > +	ASSERT_MEM_EQ((char *)allocated_ptr, 0, available_size);
> > +
> >   	ASSERT_EQ(rgn->size, MEM_SIZE);
> >   	ASSERT_EQ(rgn->base, memblock_start_of_DRAM());
> > @@ -442,6 +456,7 @@ static int alloc_no_memory_generic_check(void)
> >   	PREFIX_PUSH();
> >   	reset_memblock_regions();
> > +	fill_memblock();
> 
> Maybe we don't need this line, it has no effect at here. Anyway, Others
> Looks Good to me.
> 
Do you mean that it's not necessary since the test doesn't run
verify_mem_content()? 

> Reviewed-by: Shaoqin Huang <shaoqin.huang@intel.com>
> 
> >   	allocated_ptr = memblock_alloc(SZ_1K, SMP_CACHE_BYTES);
> > @@ -472,6 +487,8 @@ static int alloc_bottom_up_simple_check(void)
> >   	allocated_ptr = memblock_alloc(SZ_2, SMP_CACHE_BYTES);
> >   	ASSERT_NE(allocated_ptr, NULL);
> > +	ASSERT_MEM_EQ((char *)allocated_ptr, 0, SZ_2);
> > +
> >   	ASSERT_EQ(rgn->size, SZ_2);
> >   	ASSERT_EQ(rgn->base, memblock_start_of_DRAM());
> > @@ -528,6 +545,7 @@ static int alloc_bottom_up_disjoint_check(void)
> >   	allocated_ptr = memblock_alloc(r2_size, alignment);
> >   	ASSERT_NE(allocated_ptr, NULL);
> > +	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r2_size);
> >   	ASSERT_EQ(rgn1->size, r1.size);
> >   	ASSERT_EQ(rgn1->base, r1.base);
> > @@ -571,6 +589,8 @@ static int alloc_bottom_up_before_check(void)
> >   	allocated_ptr = memblock_alloc(r1_size, SMP_CACHE_BYTES);
> >   	ASSERT_NE(allocated_ptr, NULL);
> > +	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r1_size);
> > +
> >   	ASSERT_EQ(rgn->size, total_size);
> >   	ASSERT_EQ(rgn->base, memblock_start_of_DRAM());
> > @@ -618,6 +638,8 @@ static int alloc_bottom_up_after_check(void)
> >   	allocated_ptr = memblock_alloc(r2_size, SMP_CACHE_BYTES);
> >   	ASSERT_NE(allocated_ptr, NULL);
> > +	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r2_size);
> > +
> >   	ASSERT_EQ(rgn->size, total_size);
> >   	ASSERT_EQ(rgn->base, r1.base);
> > @@ -669,6 +691,8 @@ static int alloc_bottom_up_second_fit_check(void)
> >   	allocated_ptr = memblock_alloc(r3_size, SMP_CACHE_BYTES);
> >   	ASSERT_NE(allocated_ptr, NULL);
> > +	ASSERT_MEM_EQ((char *)allocated_ptr, 0, r3_size);
> > +
> >   	ASSERT_EQ(rgn->size, r2.size + r3_size);
> >   	ASSERT_EQ(rgn->base, r2.base);
> > diff --git a/tools/testing/memblock/tests/common.c b/tools/testing/memblock/tests/common.c
> > index 76a8ad818f3a..0ca26fe12c38 100644
> > --- a/tools/testing/memblock/tests/common.c
> > +++ b/tools/testing/memblock/tests/common.c
> > @@ -60,16 +60,23 @@ void reset_memblock_attributes(void)
> >   	memblock.current_limit	= MEMBLOCK_ALLOC_ANYWHERE;
> >   }
> > +void fill_memblock(void)
> > +{
> > +	memset(memory_block.base, 1, MEM_SIZE);
> > +}
> > +
> >   void setup_memblock(void)
> >   {
> >   	reset_memblock_regions();
> >   	memblock_add((phys_addr_t)memory_block.base, MEM_SIZE);
> > +	fill_memblock();
> >   }
> >   void dummy_physical_memory_init(void)
> >   {
> >   	memory_block.base = malloc(MEM_SIZE);
> >   	assert(memory_block.base);
> > +	fill_memblock();
> >   }
> >   void dummy_physical_memory_cleanup(void)
> > diff --git a/tools/testing/memblock/tests/common.h b/tools/testing/memblock/tests/common.h
> > index d396e5423a8e..7a16a7dc8f2c 100644
> > --- a/tools/testing/memblock/tests/common.h
> > +++ b/tools/testing/memblock/tests/common.h
> > @@ -51,6 +51,18 @@
> >   	assert((_expected) < (_seen)); \
> >   } while (0)
> > +/**
> > + * ASSERT_MEM_EQ():
> > + * Check that the first @_size bytes of @_seen are all equal to @_expected.
> > + * If false, print failed test message (if running with --verbose) and then
> > + * assert.
> > + */
> > +#define ASSERT_MEM_EQ(_seen, _expected, _size) do { \
> > +	for (int _i = 0; _i < (_size); _i++) { \
> > +		ASSERT_EQ((_seen)[_i], (_expected)); \
> > +	} \
> > +} while (0)
> > +
> >   #define PREFIX_PUSH() prefix_push(__func__)
> >   /*
> > @@ -70,6 +82,7 @@ struct region {
> >   void reset_memblock_regions(void);
> >   void reset_memblock_attributes(void);
> > +void fill_memblock(void);
> >   void setup_memblock(void);
> >   void dummy_physical_memory_init(void);
> >   void dummy_physical_memory_cleanup(void);
