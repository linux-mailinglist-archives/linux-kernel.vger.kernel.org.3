Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68CCC5AB680
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 18:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236246AbiIBQ2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 12:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235705AbiIBQ2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 12:28:10 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252D2D83D7
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 09:28:06 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id o4so2506844pjp.4
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 09:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=wNIc8ao3Yt5CIdYavjbANH3T4X5dkUReDekaysXGDSo=;
        b=QhH2Cm4lO6x1voUd1Dembk6oOd9z5VY5TRrL41iWRFmmpp8cdizG8V+OUu0UJk4T41
         aBRwqxgqtgljwySCPWHW60HmpaQYfdGXRRn9TMfCgOZOrcLIYDmjjtbOslwy29nx+HB6
         /3W7hEuGXsIJnNCIe2Zgw7XYDjOwT1N0H1P2AY4jkvJNMPcvwyHdV8NmdAEMgkPCaxFJ
         2YOewm0AxPEacPvzTN5gOid4Eqo7tbyICfOHq715O4rt8jVMgZmaCTjZxCgWwYqIXacd
         TqSNDW+DbtXv484tEbqq+CuR4VMQFe7e/Zcvn9YWgp63KbN3gk41EGKm2NVZOZjgLss2
         Ej5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=wNIc8ao3Yt5CIdYavjbANH3T4X5dkUReDekaysXGDSo=;
        b=BecuGsmUVoDuiRrBAaiYMlT0vNgda4K+3Vjnv3H2dxh+3B2rBG3xNqhtc2cyt4j9/r
         mrBBjD5cEw/WnOCx+GQMHUyvBFxuvBIFYGnY1TUIvxkyJbdNl7pYPnmrM/UKNWXPAW5m
         Ur/YX/MATUbiPk3U2VXo1hKoNpJmSb4d4ahbQoIvN/Yi5yaWRAYZt7bBdcWSESW1SnUR
         Qd+kGpJdFZowKoxuxwh+zI5HOjGpj3gutDPq5fjqYv7+6HlvszfcuMo85UGXTVZCaqas
         BdR6LfCHqBtMuMr4CR5VDmH/SGc94bPh7qFX6uu1Pzuknus4lH8m5MEJmxmoI4niiV9h
         e1Lg==
X-Gm-Message-State: ACgBeo0ALf8FQxJ4N0zJ+3RitskXM6JhdoNchulfdnd/UHpGZaeTs+Gf
        1gxuaPbL49RlP/JV9/xiObFd2orrETRUmbFqEE6hfA==
X-Google-Smtp-Source: AA6agR5I57h1hhqBtwWvwWZ0317cT8zJVXYKMBQ5KfKg0bf77TfLd7MEyW9C3p5B1iCemxF/BozAyIVMm1z0nMDn7Vk=
X-Received: by 2002:a17:902:b410:b0:172:c9d1:7501 with SMTP id
 x16-20020a170902b41000b00172c9d17501mr36380746plr.106.1662136085602; Fri, 02
 Sep 2022 09:28:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220902152243.479592-1-jiebin.sun@intel.com>
In-Reply-To: <20220902152243.479592-1-jiebin.sun@intel.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 2 Sep 2022 09:27:54 -0700
Message-ID: <CALvZod44uUFnwfF4StC24t+d1s_XE10hkmSCgb04FjtTATo6xQ@mail.gmail.com>
Subject: Re: [PATCH] ipc/msg.c: mitigate the lock contention with percpu counter
To:     Jiebin Sun <jiebin.sun@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, vasily.averin@linux.dev,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>,
        Manfred Spraul <manfred@colorfullife.com>,
        alexander.mikhalitsyn@virtuozzo.com, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Chen, Tim C" <tim.c.chen@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Huang Ying <ying.huang@intel.com>, tianyou.li@intel.com,
        wangyang.guo@intel.com
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

On Fri, Sep 2, 2022 at 12:04 AM Jiebin Sun <jiebin.sun@intel.com> wrote:
>
> The msg_bytes and msg_hdrs atomic counters are frequently
> updated when IPC msg queue is in heavy use, causing heavy
> cache bounce and overhead. Change them to percpu_counters
> greatly improve the performance. Since there is one unique
> ipc namespace, additional memory cost is minimal. Reading
> of the count done in msgctl call, which is infrequent. So
> the need to sum up the counts in each CPU is infrequent.
>
> Apply the patch and test the pts/stress-ng-1.4.0
> -- system v message passing (160 threads).
>
> Score gain: 3.38x
>
> CPU: ICX 8380 x 2 sockets
> Core number: 40 x 2 physical cores
> Benchmark: pts/stress-ng-1.4.0
> -- system v message passing (160 threads)
>
> Signed-off-by: Jiebin Sun <jiebin.sun@intel.com>
[...]
>
> +void percpu_counter_add_local(struct percpu_counter *fbc, s64 amount)
> +{
> +       this_cpu_add(*fbc->counters, amount);
> +}
> +EXPORT_SYMBOL(percpu_counter_add_local);

Why not percpu_counter_add()? This may drift the fbc->count more than
batch*nr_cpus. I am assuming that is not the issue for you as you
always do an expensive sum in the slow path. As Andrew asked, this
should be a separate patch.
