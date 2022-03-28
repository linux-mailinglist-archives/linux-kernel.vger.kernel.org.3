Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2AB4E9F48
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 20:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245375AbiC1S7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 14:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245371AbiC1S7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 14:59:51 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3835F66
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 11:58:09 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id v35so27677059ybi.10
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 11:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8612p/69znHIDRySiH+8dA+VUWRJM0II/moWC9PgDh0=;
        b=R0RSG/eD45vxAB8C5huZwsNn3GSeO3CeFOpFkhEwACU4cYjU/qDHeJ9dRU/s8iPWkR
         MkZHry9neauW9HYX8gXxgzjaqkX2mpcav9D0nXygYspjw6/qDToneyjZcOTBPNrq53yY
         nkBuN1SaZSzlXWjtN+gOY40RVYATiLKCRctlk5ci0unOxkcEx6JuTvZCItXjBp8QYbB3
         cXCQ0phWilxKLZc1KrUHJB7xFLYl9pFmrgGZwLiW3wfmofX2/LAFA74UEDDkPcl4f/BO
         MBQq7nWEcsK7zH3LuUO/lIgSlBmR5GgZAgOjW8+GlMDjlS4XRGDFjKBSgPib3uyzEw80
         dCcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8612p/69znHIDRySiH+8dA+VUWRJM0II/moWC9PgDh0=;
        b=K5NZ9081QDlBse/lLT8xuGN+95Zg7/dpdE5ciBJKenVtT/d5g2lFiL9wDHrlYvHVjr
         ARqFZecBZH+ZwYQTfvhkqH/60TXeEwlUQB2pqkjyM8byDIUHNp2f4cNzc+zZSMiJIwF8
         R+4JegXEoNxQFGyc8ZenuylNcKzSoyun3jpck0belJRvgGS2xF5CzrZHz9b9XM7l5guY
         1pvrGSW9t0R586h7x3SP4lOl4pDozmkqge8wu6omPeNjj2rrtYtkayklJX4e9wiF9M5y
         yLtDH9y5nPgb84+mWySL+vN+Z7WWeCpd+96RddoNbmSIkBJhv8GZm9Nfz+B03oL4tEsw
         fjWw==
X-Gm-Message-State: AOAM531948slqgocnnOd8a56B3Y6m54c89Uqd2xmP/GJ7r9d9VjBwH0L
        P9io3uu9IDlMjH6Jd7oK/BTkiuQ1lGqyPwpszcV1JQ==
X-Google-Smtp-Source: ABdhPJwt+RoOnL37cR1r2A91NZ3Rlf28H9zAzoMDrsg1szQFpW4MvObpLTmFzcIGyJ6XEm4sTQgFMRKRui/r76+UYwE=
X-Received: by 2002:a05:6902:241:b0:633:d3e1:ff5e with SMTP id
 k1-20020a056902024100b00633d3e1ff5emr24158708ybs.625.1648493888782; Mon, 28
 Mar 2022 11:58:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220328132843.16624-1-songmuchun@bytedance.com>
 <CANpmjNO=vMYhL_Uf3ewXvfWoan3q+cYjWV0jEze7toKSh2HRjg@mail.gmail.com>
 <CAMZfGtWfudKnm71uNQtS-=+3_m25nsfPDo8-vZYzrktQbxHUMA@mail.gmail.com> <CAMZfGtVkp+xCM3kgLHRNRFUs_fus0f3Ry_jFv8QaSWLfnkXREg@mail.gmail.com>
In-Reply-To: <CAMZfGtVkp+xCM3kgLHRNRFUs_fus0f3Ry_jFv8QaSWLfnkXREg@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 28 Mar 2022 20:57:32 +0200
Message-ID: <CANpmjNMszqqOF6TA1RmE93=xRU9pA5oc4RBoAtS+sBWwvS5y4w@mail.gmail.com>
Subject: Re: [PATCH v2] mm: kfence: fix objcgs vector allocation
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Mar 2022 at 17:54, Muchun Song <songmuchun@bytedance.com> wrote:
[...]
> > >
> > > Btw, how did you test this?
> > >
>
> I have tested it with syzkaller with the following configs.
> And I didn't find any issues.
>
> CONFIG_KFENCE=y
> CONFIG_KFENCE_SAMPLE_INTERVAL=10
> CONFIG_KFENCE_NUM_OBJECTS=2550
> CONFIG_KFENCE_DEFERRABLE=n
> CONFIG_KFENCE_STATIC_KEYS=y
> CONFIG_KFENCE_STRESS_TEST_FAULTS=0

Hmm, I would have expected that you have some definitive test case
that shows the issue, and with the patch the issue is gone. Were there
issues triggered by syzkaller w/o this patch?

Thanks,
-- Marco
