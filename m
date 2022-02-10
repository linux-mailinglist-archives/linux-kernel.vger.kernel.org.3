Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0757F4B04A1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 05:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233606AbiBJEuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 23:50:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbiBJEuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 23:50:00 -0500
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C211AF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 20:50:02 -0800 (PST)
Received: by mail-oo1-xc34.google.com with SMTP id o192-20020a4a2cc9000000b00300af40d795so4985509ooo.13
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 20:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=4Jobq+qDCn0DLQoMGzu/G3IUm/o1eD+lCYxdsTeODFA=;
        b=eMQ6xiBu0oXza2qERH659vL16F0VUyIma1jeN615rGln+fqxBmCvgJJMDQMpXj3Htz
         fqLKpO5zBluZw2dRoGTBPQtmBFe4gZnJVBAnVVpAfqJopBJNTvEyFCzXz+IvT8WtBEb/
         TOIZCormeBiQNpmgjl+n2DuK73sIO21Fn1TzPbb7A8ret3wM0uhdcemHRSLVjgW5TmUm
         I3i/LGF4q+4DjouvSdpz7/mdm7wsBA7dS0fQv3FN+x/XV225OQ+B+F6VK6PbZ+tCLEkI
         03w/SzLpNEUp8GilFe8L/bbelpC6iLr+fX2fUhUUFwPdwm3rtP76uBmUWBA852LybRZt
         aG9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=4Jobq+qDCn0DLQoMGzu/G3IUm/o1eD+lCYxdsTeODFA=;
        b=28985lihz/mFbjr/3MCL1VYQhZ1AIFrslMkG9FWo6Sss2QMMoUoY+UBiRMYbL/ifeT
         mx44qgb75KnDjWssDmJNkOieGvDpm7N2J/ekVTeDqkF5A7wUgFeF7FVwx10QNGMM1nfm
         Q5Mfhpnm1ADZOXvNOMiPVQLkbqDClQQLFmjc+UbQOkA/1ro7ohsuP/i/5Xy50b2+ZSOm
         BMeSpzUjTt9teXuyqNqZv8r8HynFsmGl5A0ogOsRPJO5BzsEwnu2lL1ahOG5Ec3Itv+8
         L/WKsbeoaq7gQr0MeUKSLE7Q5W7gC0LsrS6a8LFsrEHaVjIKZzj6benD/uPvYIppBvLi
         OS2w==
X-Gm-Message-State: AOAM533Dry0QjbLi9f5GoOj+e7Rx6YIoWFBtFSeyddJFXxPFYd3VPN6e
        4dzaVVmxT7dXm6YEzHw1LdErJw==
X-Google-Smtp-Source: ABdhPJwwSZhmnjDZ7pgSMs76EZBfUaAKepRAPpZCVge1mXkMwftDxRWUj7/PT0YJkxPBtJj+Gy2HCw==
X-Received: by 2002:a05:6871:583:: with SMTP id u3mr254881oan.189.1644468600735;
        Wed, 09 Feb 2022 20:50:00 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id f21sm7364939otq.4.2022.02.09.20.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 20:49:59 -0800 (PST)
Date:   Wed, 9 Feb 2022 20:49:57 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
cc:     open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        regressions@lists.linux.dev, lkft-triage@lists.linaro.org,
        Hugh Dickins <hughd@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        Greg Thelen <gthelen@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Shakeel Butt <shakeelb@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: mm/munlock: mlock_page() munlock_page() batch by pagevec
In-Reply-To: <CA+G9fYv_ssRhvYi4mM1ZeGCL2meFwRsakpADp_Cz3bNDZz2zSA@mail.gmail.com>
Message-ID: <5d63a397-96e-7e9a-eb9f-289904f9998@google.com>
References: <CA+G9fYv_ssRhvYi4mM1ZeGCL2meFwRsakpADp_Cz3bNDZz2zSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Feb 2022, Naresh Kamboju wrote:
> The following build regression noticed while building Linux next 20220209
> arm/riscv/sh of allnoconfig and tinyconfig builds failed with gcc-10,
> gcc-11 and clang-13.
> 
> clang: warning: argument unused during compilation: '-march=armv7-m'
> [-Wunused-command-line-argument]
> mm/swap.c:637:2: error: implicit declaration of function
> 'mlock_page_drain' [-Werror,-Wimplicit-function-declaration]
>         mlock_page_drain(cpu);
>         ^
> 1 error generated.
> make[2]: *** [scripts/Makefile.build:289: mm/swap.o] Error 1
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Thanks Naresh, Geert had already reported, and SeongJae sent a fix in

https://lore.kernel.org/lkml/20220209094158.21941-2-sj@kernel.org/

Turns out that a !CONFIG_MMU CONFIG_SMP config will need one more stub,
I just sent a v2 update to SJ's patch in that thread.

Hugh
