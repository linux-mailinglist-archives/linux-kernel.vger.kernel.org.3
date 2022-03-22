Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2499B4E3E50
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 13:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234782AbiCVMUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 08:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234801AbiCVMUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 08:20:04 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEFD724BE0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 05:18:36 -0700 (PDT)
Received: from [192.168.12.80] (unknown [182.2.69.158])
        by gnuweeb.org (Postfix) with ESMTPSA id 288207E2BC;
        Tue, 22 Mar 2022 12:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1647951516;
        bh=GZx4Yhj9nYeH4z7Cx5vXhFSfLR6PHlYM6rxj2udKq30=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=XPg76URAPeLNc753ubnLQ3wh9lq2RNCp6dJ3LUHnDO8XPEAsN3WRTs2/qrhaLFqJv
         jfrwim0rtwAQ89Yzv2j/8MsFF0ohpS1/rB8fA4q5zhEdEOoImLpXScCRObkwWkdJuG
         Tonf+zdXTh2Mn7g8wei9DtJ7Yl/J4jXsrYBZaNgls++J0VByQ9Bx8rZk/gm849iqU/
         2DoXfOj3U1JVn7QLtQx7Jfkno65R7NL9P1LOMpbmrmMYUkrgIZ18aKlqUoP3y0caQO
         e0pWbYv+fTd2P+yBLhZ3iX+9jEZ0zlM3jr6qV7S4xHIktn1F8kxb94era0R83Hd9C8
         vMtoOZ2jRnqMw==
Message-ID: <28dd5f67-0c59-8ea0-8798-55757a6b05f6@gnuweeb.org>
Date:   Tue, 22 Mar 2022 19:18:31 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     David Laight <David.Laight@ACULAB.COM>, Willy Tarreau <w@1wt.eu>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Nugraha <richiisei@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>
References: <20220322102115.186179-1-ammarfaizi2@gnuweeb.org>
 <20220322102115.186179-7-ammarfaizi2@gnuweeb.org>
 <56935393241242adab6f32c50dd74c23@AcuMS.aculab.com>
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: Re: [RFC PATCH v2 6/8] tools/nolibc/stdlib: Implement `malloc()`,
 `calloc()`, `realloc()` and `free()`
In-Reply-To: <56935393241242adab6f32c50dd74c23@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/22 6:52 PM, David Laight wrote:

[...]
>> +struct nolibc_heap {
>> +	size_t	len;
>> +	char	user_p[] __attribute__((__aligned__));
> 
> Doesn't that need (number) in the attribute?

The number is not mandatory.

Specifying no alignment argument implies the maximum alignment for
the target, which is often, but by no means always, 8 or 16 bytes.

This has been discussed in the RFC v1, see the full message here:

   https://lore.kernel.org/lkml/c7129520-5e9a-f9d1-cc12-5af9456c917f@gnuweeb.org/


>> +static __attribute__((unused))
>> +void *malloc(size_t len)
>> +{
>> +	struct nolibc_heap *heap;
> 
> If you do (say):
> 	len = ROUNDUP(len + sizeof *heap, 4096)
> you can optimise a lot of the realloc() calls.
> 
> I actually wonder if compiling a mini-libc.a
> and then linking the programs against it might
> be better than all these static functions?
> -ffunction-sections can help a bit (where supported).

Rounding up is not useful here, because we don't have any free list to keep
track the unused block of memory. I mean, even if it's rounded up, the extra
space after rounded up cannot be utilized with this design. There is no
book-keeping that tracks it.

Though, the kernel still allocates the size in multiple page size.

-- 
Ammar Faizi
