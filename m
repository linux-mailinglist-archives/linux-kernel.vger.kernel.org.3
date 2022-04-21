Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C887D50A0D7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 15:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384993AbiDUNcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 09:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbiDUNcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 09:32:12 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC72D37A2C
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 06:29:22 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-2ebf3746f87so52017857b3.6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 06:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MqWLSGF5u7HAvIurWy83H/sqpyLwV1ABomzO+8j+TCM=;
        b=U513sTPiMRZGRNSKdjt3QeSvdzbpEHjYq6j9R437lt5/43iCCCTpCQAk5EbfstVV5A
         5BJbtKNEKJWzj54bLT2lXzlFAXHgQjXfuI3yrKsh898fIve/BMcP10DAgtcvz3wvRSLA
         IgKvp7AhyAiVCQSzVdptv40cL65JwQUpw0S3jR5ifQiqkttiCeQlyTyr5ZxQcMzmCy+c
         QSzf08co3+vu0treKetig1m1Ulmct+CNkECdBoei+kYwVM39D8XRXD2nGGOctdgFOYFP
         PRIp24rs0EYKLlbrfF+3cO7OoNNSOwrPVJPYwCF/FPFqqaJPsruS8MA/RBQRJE/HVuFI
         MnWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MqWLSGF5u7HAvIurWy83H/sqpyLwV1ABomzO+8j+TCM=;
        b=IqO4e9tgumfyrPRem6wx3vqkaoGWrpCAFazQb4cr9zHqu3r1AHdmT/ETvRtqYxxLgL
         Bp+rlKYa6scir/zZfn/AVpSx/Ev8GYOcV51luoKGq96fpOQA+Qd9YNHnX9V2Fyc2hgM6
         SpRkUlsEgol+S9y03JwlkUGLC9LaHL996BZpg9YIqUSDJk4oL/AM9dm4M+l9bXDbW7VY
         I1UB3po1ee3TwapZdwFRZSYZuWo7OH7ts1LkWaQVmLBsel2qwAajhq3biu1G7tD41TJ3
         vFrYrBrJivzSpb3FPv6zOmA4t1FGkgGpdBrdT9rcwTzKBihoi3HRP0/rbo/aKn7UUrxJ
         pFBA==
X-Gm-Message-State: AOAM5320HpOsPYPBTWyymJ4CV1InCcm6jWQ5X0om9f3Lk/IiqCjmBiHp
        S0bBN+y4+fu1IBUHDaz0L/v4E7tQ/ozQ+f2CXwOs6A==
X-Google-Smtp-Source: ABdhPJy4N7/P+KHHPG82N6SmhOd/ruIRZ3Gy9NyR1BKf8pZ91u2lynhMt6bjMV3rw2eJ7ostei6X7SL+wdf3ZdVND/A=
X-Received: by 2002:a81:f211:0:b0:2eb:9ac6:4dda with SMTP id
 i17-20020a81f211000000b002eb9ac64ddamr26303415ywm.362.1650547761401; Thu, 21
 Apr 2022 06:29:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAG_fn=Xs-OqpVCW5KyQLYKXNmQ4aH-KDjY0BrWpqMfPKcu-dug@mail.gmail.com>
 <20220421121018.60860-1-huangshaobo6@huawei.com> <CAG_fn=UxSwgO8D2dCkM3vWPwcz0-rjvFdwr37cxYUt4awT3crA@mail.gmail.com>
In-Reply-To: <CAG_fn=UxSwgO8D2dCkM3vWPwcz0-rjvFdwr37cxYUt4awT3crA@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 21 Apr 2022 15:28:45 +0200
Message-ID: <CANpmjNM0qeKraYviOXFO4znVE3hUdG8-0VbFbzXzWH8twtQM9w@mail.gmail.com>
Subject: Re: [PATCH] kfence: check kfence canary in panic and reboot
To:     Alexander Potapenko <glider@google.com>
Cc:     Shaobo Huang <huangshaobo6@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        chenzefeng2@huawei.com, Dmitriy Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        nixiaoming@huawei.com, wangbing6@huawei.com,
        wangfangpeng1@huawei.com, young.liuyang@huawei.com,
        zengweilin@huawei.com, zhongjubin@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Apr 2022 at 15:06, Alexander Potapenko <glider@google.com> wrote:
[...]
> This report will denote that in a system that could have been running for days a particular skbuff was corrupted by some unknown task at some unknown point in time.
> How do we figure out what exactly caused this corruption?
>
> When we deploy KFENCE at scale, it is rarely possible for the kernel developer to get access to the host that reported the bug and try to reproduce it.
> With that in mind, the report (plus the kernel source) must contain all the necessary information to address the bug, otherwise reporting it will result in wasting the developer's time.
> Moreover, if we report such bugs too often, our tool loses the credit, which is hard to regain.

I second this - in particular we'll want this off in fuzzers etc.,
because it'll just generate reports that nobody can use to debug an
issue. I do see the value in this in potentially narrowing the cause
of a panic, but that information is likely not enough to fully
diagnose the root cause of the panic - it might however prompt to
re-run with KASAN, or check if memory DIMMs are faulty etc.

We can still have this feature, but I suggest to make it
off-by-default, and only enable via a boot param. I'd call it
'kfence.check_on_panic'. For your setup, you can then use it to enable
where you see fit.

Thanks,
-- Marco
