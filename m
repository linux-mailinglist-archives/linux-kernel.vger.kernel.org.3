Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5FA1581CE9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 03:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233135AbiG0BDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 21:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233245AbiG0BDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 21:03:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93F525EBD
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 18:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=GwxOLjxLRrQqASCK4Od2SYV8dQa0nMmOi0A7PX9TkRU=; b=wPAKpK71JFaXfa75QNiT09CanL
        72fq6O+TF0NKwCvGuugBLdZVke0BZh6YU8Ojib+ejRozHujPvA0e9vfE1e6FIzgfWrK9Y6WyaNbpU
        eRR+lcXLdx1gtxLgySTAdVxmfrQNNVx8nsQQdYBbYhC49wivy4+UFSNcqyEilbN6ChYy6fMutSnJj
        CghSmIqxCE3hEWGNHIqBRRd3tnjFLzNb/2UXAuXPyZbxuoVeiOsXR5EJ8nUj4e32LOdb8r+EjYTP6
        L2ObdavR6EVoUVSuCgXWWNxENNYN9AviLg7O0qw743zKn4X+8CVw5wxm/y/dCMDP8HUPE+PE1J+FM
        TxtKoHxw==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oGVSZ-006z3V-T8; Wed, 27 Jul 2022 01:03:35 +0000
Message-ID: <26b099a0-2ace-8023-7b09-f6b015f26be9@infradead.org>
Date:   Tue, 26 Jul 2022 18:03:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] memblock tests: compiling error
Content-Language: en-US
To:     Souptick Joarder <jrdr.linux@gmail.com>,
        Liu Xinpeng <liuxp11@chinatelecom.cn>
Cc:     Mike Rapoport <rppt@kernel.org>, Linux-MM <linux-mm@kvack.org>,
        David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org
References: <1658804705-16996-1-git-send-email-liuxp11@chinatelecom.cn>
 <CAFqt6zabgY6DgCQBe0HCsMYScNEnKbm-0nH4ghhALZpF14rm4g@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAFqt6zabgY6DgCQBe0HCsMYScNEnKbm-0nH4ghhALZpF14rm4g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/26/22 18:01, Souptick Joarder wrote:
> On Tue, Jul 26, 2022 at 8:35 AM Liu Xinpeng <liuxp11@chinatelecom.cn> wrote:
>>
>> memblock.o: In function `memblock_find_in_range.constprop.9':
>> memblock.c:(.text+0x4651): undefined reference to `pr_warn_ratelimited'
>> memblock.o: In function `memblock_mark_mirror':
>> memblock.c:(.text+0x7171): undefined reference to `mirrored_kernelcore'
>>
> 
> what is the steps to hit this compile error ?

or what kernel .config file?

> 
>> Fixs: 902c2d91582 ("memblock: Disable mirror feature if kernelcore is not
>> specified")
>> Fixs: 14d9a675fd0 ("mm: Ratelimited mirrored memory related warning")
>>
>> Signed-off-by: Liu Xinpeng <liuxp11@chinatelecom.cn>
>> ---
>>  tools/testing/memblock/internal.h | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/tools/testing/memblock/internal.h b/tools/testing/memblock/internal.h
>> index c2a492c..cf67e6e 100644
>> --- a/tools/testing/memblock/internal.h
>> +++ b/tools/testing/memblock/internal.h
>> @@ -9,6 +9,9 @@
>>  static int memblock_debug = 1;
>>  #endif
>>
>> +#define pr_warn_ratelimited(fmt, ...)    printf(fmt, ##__VA_ARGS__);
>> +
>> +bool mirrored_kernelcore = false;
>>  struct page {};
>>
>>  void memblock_free_pages(struct page *page, unsigned long pfn,
>> --
>> 1.8.3.1
>>
>>

-- 
~Randy
