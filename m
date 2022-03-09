Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1AEC4D28C8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 07:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbiCIGNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 01:13:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiCIGNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 01:13:44 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB665C84D
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 22:12:46 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id g26so2207084ybj.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 22:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=//61snb4FzOH8xBVPrGQSTEOIUqrxrg6uRM2aNBozZM=;
        b=aPuBcekGsi9P0Kiu8PsroQfxh8B7CEY6shdyL04CVPdMJL6Vm6jfWWpHEHG1Fy0XCI
         GicYeww/yzqyXCzvC5YdjEZFIExYDrgeI/8dY4G6cnKzSNAeD1htsJz3jwdB7ZezvpcI
         ylPESixpZyteiQ/IQRd2ehwVVjzir7EsJKcOixe1Z3QO8g8FDQoJfrNU45RyKvdfTHHu
         P+FpBA+pNBsiQs8uFtzHz3kyaBobyaGwOMezcQjGxCeeFEOdfYGCAySUaS22L1nwRdd1
         13S+33dJMoLs+nUmw8i2TilPRzHjdU82xpE2FGuCH9WG3bb3N5YFi01j1KSS7Oa2fDfu
         9U6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=//61snb4FzOH8xBVPrGQSTEOIUqrxrg6uRM2aNBozZM=;
        b=RKMJRecGjWQSFX3atD5Zd6wR5A41+s01avOyM9BZjTN/e52Ijn5ufOVaLssNgWEZc7
         i37FWP1weTlPm5sfH9ouQoksgejYDLWmn1S6nQxZEin5LD/M4dZu5m23pfsE8fL8AS6v
         u6utPk67epRQW43/fPZR8w4i6qSXsF2WTV6wNXXmpwktvrhGQxWs8zGIpL2G+vqD35eO
         hHnVLzxqNxGfcRqCBKDUO8Zj03rMU9FNRpXzzkLdftF3AEZ4AR/MAJKxYAVb6X4hXcFG
         GcnVuFB4bgqB0n3WlzeTKdY7B+CYQtAXoJJvi/qmcvqa94v0K6Qz58uxwlkd7jDeD9tB
         y80w==
X-Gm-Message-State: AOAM530BBvcsquF+BF8WDBSnfTrOdTwv2tLeKDcR2hLmen6PcR1NRgHT
        x2+zd8b9nnFqIGGDA4oP1t7m6kHO3NuScwEZzDsKKg==
X-Google-Smtp-Source: ABdhPJzBuek4ThwGw7LKMg2H3OQNOMTaq1RqGtFnxwre1s0xPWyQLGExZZ0bojDIycqhpJghZtJJ7rUAhAaGkCHK27w=
X-Received: by 2002:a05:6902:203:b0:628:7b6f:2845 with SMTP id
 j3-20020a056902020300b006287b6f2845mr15356927ybs.533.1646806365542; Tue, 08
 Mar 2022 22:12:45 -0800 (PST)
MIME-Version: 1.0
References: <20220309014705.1265861-1-liupeng256@huawei.com>
In-Reply-To: <20220309014705.1265861-1-liupeng256@huawei.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 9 Mar 2022 07:12:08 +0100
Message-ID: <CANpmjNMfkUSUEihTc2u_v6fOhHiyNOAOs2QROjCMEROMTbaxLQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] kunit: fix a UAF bug and do some optimization
To:     Peng Liu <liupeng256@huawei.com>
Cc:     brendanhiggins@google.com, glider@google.com, dvyukov@google.com,
        akpm@linux-foundation.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        wangkefeng.wang@huawei.com
Content-Type: text/plain; charset="UTF-8"
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

On Wed, 9 Mar 2022 at 02:29, 'Peng Liu' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> This series is to fix UAF when running kfence test case test_gfpzero,
> which is time costly. This UAF bug can be easily triggered by setting
> CONFIG_KFENCE_DYNAMIC_OBJECTS = 65535. Furthermore, some optimization
> for kunit tests has been done.

Yeah, I've observed this problem before, so thanks for fixing.

It's CONFIG_KFENCE_NUM_OBJECTS (not "DYNAMIC") - please fix in all patches.


> Peng Liu (3):
>   kunit: fix UAF when run kfence test case test_gfpzero
>   kunit: make kunit_test_timeout compatible with comment
>   kfence: test: try to avoid test_gfpzero trigger rcu_stall
>
>  lib/kunit/try-catch.c   | 3 ++-
>  mm/kfence/kfence_test.c | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> --
> 2.18.0.huawei.25
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20220309014705.1265861-1-liupeng256%40huawei.com.
