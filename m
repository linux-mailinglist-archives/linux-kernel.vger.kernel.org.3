Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B62874D2539
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 02:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiCIBGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 20:06:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbiCIBGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 20:06:38 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C44DA861
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 16:45:40 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id 25so911451ljv.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 16:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BlWs9Oc0zj9F2EHZcLB2J8SiaLs42pAAB4ehhmuarrk=;
        b=VyN7JMo6vbO64BMsSBYP06buMY3DUlc/4kwNjhwQem2ii3W8SmgZmDvZRuhzbXEPVp
         /HoQ4b8wz2JqhUyXHzdsaMB1bfpsVDrJMOU4BtjIHOBsfN/2ug+NMcbeUV6LMBlcCDB2
         sa7IwL82CQNufZu/wr3AhCP+cQFqC3WMqIC/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BlWs9Oc0zj9F2EHZcLB2J8SiaLs42pAAB4ehhmuarrk=;
        b=tK4Fh03gZ9V9khXKitFVXpvwfDnayu/95Mtnz9Fvsgzt8F8dmlUPZfNQUaV/lbaB2c
         pmS3U7k8O6M+a046Nmiq0YpowC75KIa+khuDSxIcNhcx3Iq0ya1X+jEzdtldIYw0Gq4K
         /0pmkS+ertoSTL9SN92sVdNJ4Lm6LAUw36gelG2rg5JjDcseEv0g0WHbU69Z3l/8p5Mx
         V3gcSCB+/8LnLvBKBJ1RG6Mdl4htrXBHZhhy6HEpzV2d02Bil9fkaEyJcywTXRShyWTz
         uITg6ku8gSci47fI7tkOXTHYDxPmYg2LQTHUG9Xd2I86Gdfd5KoPSv+57WUfUOpzcO35
         u8dw==
X-Gm-Message-State: AOAM530twlxWoZTYN190XYhYT2fHza3Cv2JLw/P3bcMUo1qoRzk7nKzW
        eBvrdKb9rRHWIcR7l+DX0buYQnZk+AMQrZZ5QnA=
X-Google-Smtp-Source: ABdhPJzBnWD/OUXOpfZznUpiki2C/6tu/cGo+cD+aHWuyYqCqPtLy7zkVNKbMdcjJBCrcEGXlFIhug==
X-Received: by 2002:a17:906:6a81:b0:6da:d7e5:4fa with SMTP id p1-20020a1709066a8100b006dad7e504famr15146643ejr.223.1646784671703;
        Tue, 08 Mar 2022 16:11:11 -0800 (PST)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a4-20020a170906274400b006da9456e802sm91883ejd.102.2022.03.08.16.11.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 16:11:11 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id dr20so1411852ejc.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 16:11:11 -0800 (PST)
X-Received: by 2002:a05:6512:3049:b0:447:d55d:4798 with SMTP id
 b9-20020a056512304900b00447d55d4798mr12247526lfb.531.1646784166111; Tue, 08
 Mar 2022 16:02:46 -0800 (PST)
MIME-Version: 1.0
References: <20220308234723.3834941-1-yuzhao@google.com> <20220308234723.3834941-7-yuzhao@google.com>
In-Reply-To: <20220308234723.3834941-7-yuzhao@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 8 Mar 2022 16:02:29 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiW0riV3Di3r8s-z0VNyn71q8cHfZqbSM3-9LvwjNjJOg@mail.gmail.com>
Message-ID: <CAHk-=wiW0riV3Di3r8s-z0VNyn71q8cHfZqbSM3-9LvwjNjJOg@mail.gmail.com>
Subject: Re: [PATCH v8 06/14] mm: multi-gen LRU: minimal implementation
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, page-reclaim@google.com,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Brian Geffon <bgeffon@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Donald Carr <d@chaos-reins.com>,
        =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>,
        Vaibhav Jain <vaibhav@linux.ibm.com>
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

On Tue, Mar 8, 2022 at 3:48 PM Yu Zhao <yuzhao@google.com> wrote:
> +
> +config TIERS_PER_GEN
> +       int "Number of tiers per generation"
> +       depends on LRU_GEN
> +       range 2 4
> +       default 4
> +       help
> +         Do not decrease this value unless you run out of spare bits in page
> +         flags, i.e., you see the "Not enough bits in page flags" build error.
> +
> +         This option uses N-2 bits in page flags.

Exact same issue as with the previous patch. Don't ask things like
this. Most *definitely* don't ask things like this if they can cause
build errors.

Just set the tiers to 4, and make sure that the number of generations
is small enough that the "Not enough bits in page flags" build error
just cannot happen.

This kind of "ask people questions they cannot sanely answer" is not acceptable.

And build errors that depend on configuration also aren't acceptable.

End result: DO NOT DO THIS.

The whole "ask user a question that you can't answer yourself" is an
actively wrong cop-out.

If you can't answer it, then the user sure as hell can't either, and
the question is pure garbage and only results in more problems and
less coherent testing.

                      Linus
