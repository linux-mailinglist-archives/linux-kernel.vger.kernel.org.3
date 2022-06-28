Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBED55F207
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 01:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbiF1Xmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 19:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbiF1Xmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 19:42:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB7433E24
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 16:42:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 932D1B81E0A
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 23:42:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AA4DC341C8;
        Tue, 28 Jun 2022 23:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656459762;
        bh=ZXEgiKdFj904q2Qs5SYcsF0x6Q/LuLJtPywfGr8yB4A=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=RYAZHRn3GAgv5+2JiJAS7wrZ1C9zj0e37sYid++Tw9kVuQCwhYrNUwH7zCe438tBt
         CVYNZi+xk8ufEsoRiCHlINgk/TG1NQj7GFhHJQGs+5KglAcXilUI4MzTsDp6DgxYh5
         MK828g1PI6UeLpwlWOSsc5lXWDi3g0auxOn7VitPF5LZMCX4wjTFQqbS8UfzpJtxdx
         OKP7L+qaSC/7d5w1dhvETH+ydpbsEIANJtyb8ERs8ALRGqseMbNq0dmNYwUpu4uX66
         3QKhSup2q31+bA5JSJ07TCf4EZit8mq0g6ZBv/ckKYnQNpMjLzMHAEy4gqZijEMNFI
         P/HXF8LfTYB/g==
Message-ID: <6cb17661-9436-afbf-38eb-58565bba1a56@kernel.org>
Date:   Tue, 28 Jun 2022 16:42:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCHv3 6/8] x86/mm: Provide ARCH_GET_UNTAG_MASK and
 ARCH_ENABLE_TAGGED_ADDR
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
 <20220610143527.22974-7-kirill.shutemov@linux.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
In-Reply-To: <20220610143527.22974-7-kirill.shutemov@linux.intel.com>
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

> +	/* Update CR3 to get LAM active */
> +	switch_mm(current->mm, current->mm, current);

Can you at least justify this oddity?  When changing an LDT, we use a 
dedicated mechanism.  Is there a significant benefit to abusing 
switch_mm for this?

Also, why can't we enable LAM on a multithreaded process?  We can change 
an LDT, and the code isn't even particularly complicated.
