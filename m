Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6F974E1C7F
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 17:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245439AbiCTQLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 12:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235541AbiCTQLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 12:11:45 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC6C105055
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 09:10:22 -0700 (PDT)
Received: from [192.168.12.80] (unknown [182.2.69.4])
        by gnuweeb.org (Postfix) with ESMTPSA id 9458B7E2BC;
        Sun, 20 Mar 2022 16:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1647792621;
        bh=Fh0VdrTyVcmuu1fbFnCw09xbY33ut+5KdzItGns9LLA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=UDWH2yTXo+mP6hTbBLiTND9+j95EqtRwZnOu4V8Qm3EraDZCBxZ8oJrK/8uD3IbEF
         kXkU6hVvch4eAzmWXrkuQpwe8cagEDlD9TeDyH/dYZwIqHNRhNv4UhuPWvCeL0e0s5
         URXml42WYi5SblRqcOA9lY1vEdl93EImerFDctzSBSpBGpzLbDi1Kblum25AhbCh/z
         lldwTKr+JqmXcZPj4d2O6Dh6xY5jjBceaX4qWLN12DFfeH2bjirdobs1kEVTSuMskg
         EJ9598aeSPIlQXsylicBn4gAvSYkz7hAKQpGoi9uaITwdXVO80h8NHw0HXWuU21l1z
         PuSGM7xr3YqBg==
Message-ID: <efd0f1d3-4442-0559-73f1-20185e0ba33d@gnuweeb.org>
Date:   Sun, 20 Mar 2022 23:10:14 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PATCH v1 5/6] tools/nolibc/stdlib: Implement `malloc()`,
 `calloc()`, `realloc()` and `free()`
Content-Language: en-US
To:     Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>
Cc:     Willy Tarreau <w@1wt.eu>, "Paul E. McKenney" <paulmck@kernel.org>,
        Nugraha <richiisei@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>
References: <20220320093750.159991-1-ammarfaizi2@gnuweeb.org>
 <20220320093750.159991-6-ammarfaizi2@gnuweeb.org>
 <CAOG64qMoDjLer_OgRn2edGLMLMVfA5Lv3CZSU2VeOkgzPWNVUA@mail.gmail.com>
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
In-Reply-To: <CAOG64qMoDjLer_OgRn2edGLMLMVfA5Lv3CZSU2VeOkgzPWNVUA@mail.gmail.com>
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

On 3/20/22 10:50 PM, Alviro Iskandar Setiawan wrote:
> This better be simplified like this, so only have 1 malloc() call that
> applies to both branches.
> 
>    void *realloc(void *old_ptr, size_t new_size)
>    {
>           struct nolibc_heap *heap;
>           void *ret;
> 
>           ret = malloc(new_size);
>           if (__builtin_expect(!ret, 0))
>                   return NULL;
> 
>           if (!old_ptr)
>                   return ret;
> 
>           heap = container_of(old_ptr, struct nolibc_heap, user_p);
>           memcpy(ret, heap->user_p, heap->len);
>           munmap(heap, heap->len);
>           return ret;
>    }

That looks better, will take this for the v2. Thanks!

-- 
Ammar Faizi
