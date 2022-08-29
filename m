Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4336C5A531D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 19:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbiH2R1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 13:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiH2R1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 13:27:18 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F59910B0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 10:27:17 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id u6so11016760eda.12
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 10:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=gXzsOE1CShzICjrF5qGy2ierXGFwu1QBu0gbN37zalE=;
        b=Ut/Yn1l3ZfKq3kllusnwCW49U1+1e9wmphOxJZL9GkGYiMI92RHLiKlBhN3oEZvanI
         7JYgCGOtlhsspYwQS7VYStSwZpo7WvkVcklDEeY8RpOVreWefdxEoXKv29L7rmxzpHKR
         /hWDL1eQgn7kgPaex1M/knUHaYiw/VvWxr2uY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=gXzsOE1CShzICjrF5qGy2ierXGFwu1QBu0gbN37zalE=;
        b=Yb0wPY9PeESp9XCNtrx+m1KwumOlWYZNM/+DzgZ4VSIueg2Igm0nL0wcoRt8SocoTv
         CDzynexlN1P+BZ5u7mejwyUOR0RtlSpe4BuegY0I+zm8aWgotkuscnDQiZWObyHXNGNU
         MswMa0sZdd4U7Uz02pnoUW//aCuDc/BXZbM1K9yYURrl5apA7z6FpHC7fW7YW05BsNS2
         PKznclbab3086g49ygzZINSogMFhnqtBvGKDdDmA9/T54h8JigShfNVZ87wKxW2a4Apo
         xAGLxGryyLejwOrUnjz9g/aucIFKjiELHTtdpuw4E9hxl1xA+ud5FK4O3opBKgVRTiVL
         k8ww==
X-Gm-Message-State: ACgBeo36S3VBXGe13stGrIaBM3PN6eti6ZRx/wCoqj1ceoeDa9gWXM9U
        WYINhOOGV6sVVE8fLB9cmnoumZvWp6O+D0x8
X-Google-Smtp-Source: AA6agR7CvGwLGGhWqCkjjZ6UGbKWWmygPl8QCPqZSUh4Pmv1F4pPgBPFXS1yYiJaAlR8NEKFNJ1oVg==
X-Received: by 2002:a05:6402:1290:b0:448:181c:37ec with SMTP id w16-20020a056402129000b00448181c37ecmr10055644edv.191.1661794035541;
        Mon, 29 Aug 2022 10:27:15 -0700 (PDT)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id b2-20020a1709063ca200b007413360a48fsm4287679ejh.50.2022.08.29.10.27.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 10:27:15 -0700 (PDT)
Received: by mail-wm1-f54.google.com with SMTP id bd26-20020a05600c1f1a00b003a5e82a6474so4790683wmb.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 10:27:15 -0700 (PDT)
X-Received: by 2002:a05:600c:657:b0:3a5:e4e6:ee24 with SMTP id
 p23-20020a05600c065700b003a5e4e6ee24mr7189742wmm.68.1661793592665; Mon, 29
 Aug 2022 10:19:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220824163100.224449-1-david@redhat.com> <20220824163100.224449-2-david@redhat.com>
 <0db131cf-013e-6f0e-c90b-5c1e840d869c@nvidia.com> <ea380cf0-acda-aaba-fb63-2834da91b66b@redhat.com>
 <CALu+AoThhou7z+JCyv44AxGWDLDt2b7h0W6wcKRsJyLvSR1iQA@mail.gmail.com>
 <fe7aee66-d9f7-e472-a13f-e4c5aa176cca@redhat.com> <CALu+AoRwVfr=9KabOLUQigWwCtP5RLQ1YaKbG75ZVM9E-bW2ZQ@mail.gmail.com>
 <CAHk-=wit-DmhMfQErY29JSPjFgebx_Ld+pnerc4J2Ag990WwAA@mail.gmail.com> <29fb251b-4622-4eb6-538d-bab6ac6a76f6@nvidia.com>
In-Reply-To: <29fb251b-4622-4eb6-538d-bab6ac6a76f6@nvidia.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 29 Aug 2022 10:19:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=whScqgJaP71QBBS9ik0kUrZBDLw+ZvzF4AxEo7eviGwaw@mail.gmail.com>
Message-ID: <CAHk-=whScqgJaP71QBBS9ik0kUrZBDLw+ZvzF4AxEo7eviGwaw@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] coding-style.rst: document BUG() and WARN() rules
 ("do not crash the kernel")
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Dave Young <dyoung@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, kexec@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Stephen Johnston <sjohnsto@redhat.com>,
        Prarit Bhargava <prarit@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 28, 2022 at 9:49 PM John Hubbard <jhubbard@nvidia.com> wrote:
>
> ...here. I count ~1000 calls to panic() in today's kernel, to a
> function in kernel/panic.c that shows no hint of being removed, nor
> even deprecated.

Heh. I guess we never finished the panic() removal.

It's been decades, I suspect we ended up deciding that the bootup
failures might as well continue to panic.

Anyway, please don't use it. It's one of those things that should
never ever trigger, and mainly for something like "oops, I ran out of
memory during boot" etc.

Oh, I'm sure it's crept into other places too, but that doesn't make it ok.

                 Linus
