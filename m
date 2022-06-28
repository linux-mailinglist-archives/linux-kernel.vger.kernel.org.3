Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D89055F205
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 01:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbiF1Xkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 19:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiF1Xkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 19:40:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E877B33A0C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 16:40:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7736461B76
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 23:40:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28B65C341C8;
        Tue, 28 Jun 2022 23:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656459649;
        bh=7nIWwuteCtLL/7qZso59iVjJhUGGVyjf9VgBjFYUDkI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Psow3Oswi0EHugLEe52mJmeGzxbU7wKaNhIE/6NdJpD0FUh7Exs465CiQSgU3daYV
         REznHzpYhzehwyHMeQdqzVROVOKrRCqAZIJqVLhZziCCteHo7ZjmyVOakNa8EuC8Gk
         NamG9aqmvRYk+Qm5YBNgPBP6slb2rLniG2I3O1JPxXgsnzDvPid8Z4Yzs4t9j8ArFT
         dRur1a7xhVR5KYMfbfsWK9GC0sGagaLLqeigIHP3hB7qo1sBn6Fx/MxghBnJH++XI7
         cXUrxKu0ZIR+Dbi685UnKUmLI7GNngfzbrnL0utdC5Y7L7ZXhhU8js8+WzwW/WCev1
         kxqa1LfzWFw7w==
Message-ID: <53d41f54-28ad-023c-537f-281cc2c40ae9@kernel.org>
Date:   Tue, 28 Jun 2022 16:40:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCHv3 5/8] x86/uaccess: Provide untagged_addr() and remove
 tags before address check
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220610143527.22974-1-kirill.shutemov@linux.intel.com>
 <20220610143527.22974-6-kirill.shutemov@linux.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
In-Reply-To: <20220610143527.22974-6-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/10/22 07:35, Kirill A. Shutemov wrote:
> untagged_addr() is a helper used by the core-mm to strip tag bits and
> get the address to the canonical shape. In only handles userspace
> addresses. The untagging mask is stored in mmu_context and will be set
> on enabling LAM for the process.
> 
> The tags must not be included into check whether it's okay to access the
> userspace address.
> 
> Strip tags in access_ok().

What is the intended behavior for an access that spans a tag boundary?

Also, at the risk of a potentially silly question, why do we need to 
strip the tag before access_ok()?  With LAM, every valid tagged user 
address is also a valid untagged address, right?  (There is no 
particular need to enforce the actual value of TASK_SIZE_MAX on 
*access*, just on mmap.)

IOW, wouldn't it be sufficient, and probably better than what we have 
now, to just check that the entire range has the high bit clear?

--Andy
