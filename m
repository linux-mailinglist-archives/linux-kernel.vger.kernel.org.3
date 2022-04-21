Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFAE95098CC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385626AbiDUHO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 03:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385621AbiDUHO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 03:14:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6AAF617079
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 00:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650525127;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BlhjlslVFi77Wl+CHcuoCUnkjOxb+lqiVmEFLuwRx6E=;
        b=QGYXMS9TXVC8Lx2N2Xuk0h6fmltrzIJWE1hU+8jrtW3KIYq2a4m5PySmSPnASgQSrUKlgi
        A7tazBgP7fFLSbH4Oe4P3kBimKsMSKm7sP3IKcZqiSFRA6I9QS73VyPlcQZjbXHIRvYcd7
        cMqdBS4l+vL5D4eo6ECNV99B9RStMoU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-197-I7366-w3PIak0IUBQam9Xg-1; Thu, 21 Apr 2022 03:12:06 -0400
X-MC-Unique: I7366-w3PIak0IUBQam9Xg-1
Received: by mail-wm1-f72.google.com with SMTP id r204-20020a1c44d5000000b0038eaca2b8c9so4102810wma.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 00:12:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=BlhjlslVFi77Wl+CHcuoCUnkjOxb+lqiVmEFLuwRx6E=;
        b=Bj51f0kCn5bdHtbUcTG9sFyG82+fCj7UWz+5kmsHqeTvCmNPKLK4kFEydbMyS9hE5Z
         1VQukojNwxq7Ljzpn0gVTm8osKr8OQhjxDemn5a6C5XUqvqOLrZeMdVc8enandzLNEiJ
         ZJO7TmcbeteUqonrs9Bx67PwXdy5HTdULspf60VhjuWT2TZ98DPxIC6oH/mrhiuPJvYS
         VLZMlFimGpQPxTw6y4fRtCKsR5oIQzbx034XX43lCyOHYmo+exGFe28DmcjWYaI7/dGz
         o0TaztyeD0u0m2Pr0uQgbVDsnFUTp/PfTJpt0u95+EB2rmrdUuWzvfWIzKe9fhAFbu3U
         PBLw==
X-Gm-Message-State: AOAM533LfDzISRt1YvQI6m9SGCNJxV4e8Ka0mlk/iqcHluhASVMhxA7s
        PEiur74YdehZIm1N7G882UHEiyANwyEsCuEE7QZlgvU/tHXRww/Dact7oVJQF04VkOn4VbhgOH8
        wMbp6xW6nkXMZwCbkinV6lH4H
X-Received: by 2002:a7b:c844:0:b0:38e:7c92:a9e3 with SMTP id c4-20020a7bc844000000b0038e7c92a9e3mr6989435wml.140.1650525124645;
        Thu, 21 Apr 2022 00:12:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzVz/JO9dKqLMzH3gy16bSB1ht5ndgDDU51K5hj3E+i5/NAaixgHvKDLeexRrqvs7GX3Odxog==
X-Received: by 2002:a7b:c844:0:b0:38e:7c92:a9e3 with SMTP id c4-20020a7bc844000000b0038e7c92a9e3mr6989397wml.140.1650525124310;
        Thu, 21 Apr 2022 00:12:04 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:de00:711b:76af:b335:9b70? (p200300cbc702de00711b76afb3359b70.dip0.t-ipconnect.de. [2003:cb:c702:de00:711b:76af:b335:9b70])
        by smtp.gmail.com with ESMTPSA id o10-20020a5d47ca000000b0020a992ce36esm1710046wrc.1.2022.04.21.00.12.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 00:12:03 -0700 (PDT)
Message-ID: <436b1fd0-16a6-0f77-7ff4-a68252d6b117@redhat.com>
Date:   Thu, 21 Apr 2022 09:12:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 1/3] memblock tests: update style of comments for
 memblock_add_*() functions
Content-Language: en-US
To:     Rebecca Mckeever <remckee0@gmail.com>, outreachy@lists.linux.dev
Cc:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <cover.1650452552.git.remckee0@gmail.com>
 <0004a1a720c5c15ba16cb9f2fb226f57276de2c0.1650452552.git.remckee0@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <0004a1a720c5c15ba16cb9f2fb226f57276de2c0.1650452552.git.remckee0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.04.22 13:19, Rebecca Mckeever wrote:
> Update comments in memblock_add_*() functions to match the style used
> in tests/alloc_*.c by rewording to make the expected outcome more apparent
> and, if more than one memblock is involved, adding a visual of the
> memory blocks.
> 
> Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
> ---
>  tools/testing/memblock/tests/basic_api.c | 75 +++++++++++++++++-------
>  1 file changed, 54 insertions(+), 21 deletions(-)
> 
> diff --git a/tools/testing/memblock/tests/basic_api.c b/tools/testing/memblock/tests/basic_api.c
> index fbc1ce160303..cdf112d25343 100644
> --- a/tools/testing/memblock/tests/basic_api.c
> +++ b/tools/testing/memblock/tests/basic_api.c
> @@ -26,8 +26,8 @@ static int memblock_initialization_check(void)
>  /*
>   * A simple test that adds a memory block of a specified base address
>   * and size to the collection of available memory regions (memblock.memory).
> - * It checks if a new entry was created and if region counter and total memory
> - * were correctly updated.
> + * Expect to create a new entry. The region counter and total memory get
> + * updated.
>   */
>  static int memblock_add_simple_check(void)
>  {
> @@ -55,8 +55,8 @@ static int memblock_add_simple_check(void)
>  /*
>   * A simple test that adds a memory block of a specified base address, size
>   * NUMA node and memory flags to the collection of available memory regions.
> - * It checks if the new entry, region counter and total memory size have
> - * expected values.
> + * Expect to create a new entry. The region counter and total memory get
> + * updated.
>   */
>  static int memblock_add_node_simple_check(void)
>  {
> @@ -87,9 +87,15 @@ static int memblock_add_node_simple_check(void)
>  
>  /*
>   * A test that tries to add two memory blocks that don't overlap with one
> - * another. It checks if two correctly initialized entries were added to the
> - * collection of available memory regions (memblock.memory) and if this
> - * change was reflected in memblock.memory's total size and region counter.
> + * another:
> + *
> + *  |        +--------+        +--------+  |
> + *  |        |   r1   |        |   r2   |  |
> + *  +--------+--------+--------+--------+--+
> + *
> + * Expect to add two correctly initialized entries to the collection of
> + * available memory regions (memblock.memory). The total size and
> + * region counter fields get updated.
>   */
>  static int memblock_add_disjoint_check(void)
>  {
> @@ -125,10 +131,20 @@ static int memblock_add_disjoint_check(void)
>  
>  /*
>   * A test that tries to add two memory blocks, where the second one overlaps
> - * with the beginning of the first entry (that is r1.base < r2.base + r2.size).
> - * After this, it checks if two entries are merged into one region that starts
> - * at r2.base and has size of two regions minus their intersection. It also
> - * verifies the reported total size of the available memory and region counter.
> + * with the beginning of the first entry (that is r1.base < r2.base + r2.size):
> + *
> + *  |    +----+----+------------+          |
> + *  |    |   r|2   |   r1       |          |
> + *  +----+----+----+------------+----------+
> + *       ^    ^
> + *       |    |
> + *       |    r1.base
> + *       |
> + *       r2.base
> + *
> + * Expect to merge the two entries into one region that starts at r2.base
> + * and has size of two regions minus their intersection. The total size of
> + * the available memory is updated, and the region counter stays the same.
>   */
>  static int memblock_add_overlap_top_check(void)
>  {
> @@ -163,11 +179,20 @@ static int memblock_add_overlap_top_check(void)
>  
>  /*
>   * A test that tries to add two memory blocks, where the second one overlaps
> - * with the end of the first entry (that is r2.base < r1.base + r1.size).
> - * After this, it checks if two entries are merged into one region that starts
> - * at r1.base and has size of two regions minus their intersection. It verifies
> - * that memblock can still see only one entry and has a correct total size of
> - * the available memory.
> + * with the end of the first entry (that is r2.base < r1.base + r1.size):
> + *
> + *  |  +--+------+----------+              |
> + *  |  |  | r1   | r2       |              |
> + *  +--+--+------+----------+--------------+
> + *     ^  ^
> + *     |  |
> + *     |  r2.base
> + *     |
> + *     r1.base
> + *
> + * Expect to merge the two entries into one region that starts at r1.base
> + * and has size of two regions minus their intersection. The total size of
> + * the available memory is updated, and the region counter stays the same.
>   */
>  static int memblock_add_overlap_bottom_check(void)
>  {
> @@ -203,9 +228,17 @@ static int memblock_add_overlap_bottom_check(void)
>  /*
>   * A test that tries to add two memory blocks, where the second one is
>   * within the range of the first entry (that is r1.base < r2.base &&
> - * r2.base + r2.size < r1.base + r1.size). It checks if two entries are merged
> - * into one region that stays the same. The counter and total size of available
> - * memory are expected to not be updated.
> + * r2.base + r2.size < r1.base + r1.size).
> + *
> + *  |   +-------+--+-----------------------+
> + *  |   |       |r2|      r1               |
> + *  +---+-------+--+-----------------------+
> + *      ^
> + *      |
> + *      r1.base
> + *
> + * Expect to merge two entries into one region that stays the same.
> + * The counter and total size of available memory are not updated.
>   */
>  static int memblock_add_within_check(void)
>  {
> @@ -236,8 +269,8 @@ static int memblock_add_within_check(void)
>  }
>  
>  /*
> - * A simple test that tries to add the same memory block twice. The counter
> - * and total size of available memory are expected to not be updated.
> + * A simple test that tries to add the same memory block twice. Expect
> + * the counter and total size of available memory to not be updated.
>   */
>  static int memblock_add_twice_check(void)
>  {

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

