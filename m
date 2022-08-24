Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2B459F1E8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 05:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbiHXDSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 23:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiHXDSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 23:18:13 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D85080B65
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 20:18:12 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id y15so11274919pfr.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 20:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=r/Iq1H6m/C2yL0fNrluazrrCDTlyKaFFMtLoSCNrNGg=;
        b=vzL3rr0kGodNUcoOfC/mX7XDjB+/DvHaVBxMBIsUVpWthu/fTy4ws2dq9PEPZsuNcV
         7jQI8ROW64nU7Aub1jlNRo+B2681onaLy63o32OSqebQgZAMn/UjHqiV0c97FWhGvayP
         pgROkiJ2hFI9fnALDipXBPg8xZrCU7iZwcyfMMy2EhF3aBViv9VIHDggkXef1jccxD4Y
         9M6rTggjJxExm3ed2wmbQz4WFXkoUoQOCTxofDCeZHiM78jizmqPu01+//XRTK8EHGDv
         3s7IP4kGl6sbyUe1Am2kT4PKLL1UcBVfKIvnbfUBExaeJoaFoRztu4Vf9omrIz8Fv1DO
         Orhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=r/Iq1H6m/C2yL0fNrluazrrCDTlyKaFFMtLoSCNrNGg=;
        b=1piHdFpB3RLb9sPYvBPugB/FYPlLyJH9ZuI6z0xbsWhJvFCOxdrADQk2R9pXKiLOMT
         uc5oTfvbY1P/e5y62PwdUyvG37W3vns25mVS3+srrMwEwCT/wmKgEYcg0+9TKwbOLkoA
         6PLLgnjw373x+/PtsP4F9BInqHZLE7F5H/hX4nD4DX9/8yRrdDVCVwsDqN9D+s8UK4BV
         LEhqh7DtzW3hDkc6NY7BxpsDGkjDGfTa++i9LG7OeFiEOc5TNpL9of5niPL+lGVlYem0
         PNOvvMySH9B0jpUWS30yOOSbZcEddptQzJwO56crn8wUTO++Gx38fktd7VOTCTYLEsCN
         6B2Q==
X-Gm-Message-State: ACgBeo1yeTQf+XZvZd2z/wUfQHXkPTnaTxoqB95711qkxqMYo9t9t8N3
        X7SGMYYkUwNpl9Jn7GSgR4oSfg==
X-Google-Smtp-Source: AA6agR4AOBIsvTAu2hTmlJsAKVgdHZ8nmL42wKkElJYuOfxm/RVcE21M/j2CHdmtSDgjv7JCs2eVng==
X-Received: by 2002:a63:b246:0:b0:42a:3d57:7d5d with SMTP id t6-20020a63b246000000b0042a3d577d5dmr19549228pgo.294.1661311091737;
        Tue, 23 Aug 2022 20:18:11 -0700 (PDT)
Received: from MacBook-Pro.local.bytedance.net ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id x24-20020aa79418000000b0052d50e14f1dsm11500868pfo.78.2022.08.23.20.18.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Aug 2022 20:18:11 -0700 (PDT)
From:   lizhe.67@bytedance.com
To:     mhocko@suse.com
Cc:     Jason@zx2c4.com, akpm@linux-foundation.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        lizefan.x@bytedance.com, lizhe.67@bytedance.com,
        mark-pk.tsai@mediatek.com, mhiramat@kernel.org,
        rostedt@goodmis.org, vbabka@suse.cz, yuanzhu@bytedance.com
Subject: Re: [PATCH] page_ext: move up page_ext_init() to catch early page allocation if DEFERRED_STRUCT_PAGE_INIT is n
Date:   Wed, 24 Aug 2022 11:17:59 +0800
Message-Id: <20220824031759.75875-1-lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <YwMresZeGmEA6qZP@dhcp22.suse.cz>
References: <YwMresZeGmEA6qZP@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-08-22  7:08 UTC, mhocko@suse.com wrote:
>On Sat 20-08-22 09:02:57, lizhe.67@bytedance.com wrote:
>> On 2022-08-18 7:36 UTC, mhocko@suse.com wrote:
>> >> From: Li Zhe <lizhe.67@bytedance.com>
>> >> 
>> >> In 'commit 2f1ee0913ce5 ("Revert "mm: use early_pfn_to_nid in page_ext_init"")',
>> >> we call page_ext_init() after page_alloc_init_late() to avoid some panic
>> >> problem. It seems that we cannot track early page allocations in current
>> >> kernel even if page structure has been initialized early.
>> >> 
>> >> This patch move up page_ext_init() to catch early page allocations when
>> >> DEFERRED_STRUCT_PAGE_INIT is n. After this patch, we only need to turn
>> >> DEFERRED_STRUCT_PAGE_INIT to n then we are able to analyze the early page
>> >> allocations. This is useful especially when we find that the free memory
>> >> value is not the same right after different kernel booting.
>> >
>> >is this actually useful in practice? I mean who is going to disable
>> >DEFERRED_STRUCT_PAGE_INIT and recompile the kernel for debugging early
>> >allocations?
>> 
>> Yes it is useful. We use this method to catch the difference of early
>> page allocations between two kernel.
>
>I was not questioning the functionality itself but the way how it is
>achieved. Recompiling the kernel to achieve debuggability has proven to
>be really a bad approach historically. Most people are using
>pre-compiled kernels these days.
>
>> > I do see how debugging those early allocations might be useful but that
>> > would require a boot time option to be practical IMHO. Would it make
>> > sense to add a early_page_ext parameter which would essentially disable
>> > the deferred ipage initialization. That should be quite trivial to
>> > achieve (just hook into defer_init AFAICS).
>> 
>> It is a good idea. A cmdline parameter is a flexible and dynamic method for
>> us to decide whether to defer page's and page_ext's initilization. For
>> comparison, this patch provides a static method to decide whether to defer
>> page's and page_ext's initilization. They are not conflicting. My next
>> work is trying to achieve your idea.
>
>They are not conflicting but this patch adds ifdefs and additional code
>that needs compile time testing with different options set. I.e. it adds
>maintenance burden for something that can be achieved by better means.
>So if you are ok to work on the runtime knob then I would propose to
>drop this patch from the mm tree and replace it by a trivial patch to
>allow early boot debugging by a cmd line parameter.

Yes you are right. Recompiling the kernel is not a clever method. I will send
another patch with a cmd line parameter 'early_page_ext' to achieve this idea.
Thanks for your advice.
