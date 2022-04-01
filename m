Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2665D4EE9C5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 10:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243763AbiDAIbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 04:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbiDAIbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 04:31:40 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86EF950065;
        Fri,  1 Apr 2022 01:29:51 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id w8so1862963pll.10;
        Fri, 01 Apr 2022 01:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qWznsXprF/OnvSyk1yhTzagarC839b5Xx3swcVECpVU=;
        b=fwWpqRWYWLwLpj6BMB9fUCU5TvaDmvE4G0DJ++JX6xjrYi0gu8B5JDw0KmqipSp4pY
         3nyw7Wfv1ZEOZv1eB851TbNJYJOrGQtAAS99zcKF5MmcC35vc4LvVdTMsz8LjQ907cYg
         1V1JKqMR5+EE4rbf9qi+SRp7LQhoUkvGSGZwFwMJLvKXb5usK/txKokjM+L8Xz5SgI21
         WD1Qjy6ImjV/rODg416U1IINRanR6xt9uvtxoWV9yJQmBqwerbG1vlzD5ykgCcQUmyFQ
         zhK23r+yah0sV+HHULj+MDxA5XNIqJNweLdvTHQljAX0JCGpG7/LagMtI4B9Iic/VpBO
         fHQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qWznsXprF/OnvSyk1yhTzagarC839b5Xx3swcVECpVU=;
        b=kqq11UdZm+u7AmP5rLfxse1+41NALGaWcj4KAofQ6S6yR5rLU+myu39CORFfkeCCaI
         h3rkt74MG1Gats6aiWrcscAGx49JBswDaiwYio59Pqnro5pm0acvMSh0QFExjZuwQz4u
         JXCBjgeoDVCZHJCDLrVfwOt1blskjmmYKQNkeZLR3WK9qtRfmqmo1eHxmzcWEi/AGPhB
         TDRoxEDkqv462zQEW3yNWJkjADkoCevevqowL1Kp8UsP8VDCD7zvjVoFVa+gOFvSaDuj
         +MIkI5tD9kxJj53aQ1PY0AuXm+yrkw1VC2D6Oss3iBMnzOY9y1VPdRuA6jTiqw/MuYDp
         XPGg==
X-Gm-Message-State: AOAM5300xt6hbkvfa7o3ts4ABehGec4d2ZZUZ+ogQNC5iJP1doQ0QX03
        KFAsJmVpaI9YmyAMhbwxpwg=
X-Google-Smtp-Source: ABdhPJyhlxVVBVlxI7UMs0Zly2MStHA2jWmvRYRSZ8uosfIhLVSm6mn3gkw0c0lj6u5v4/TLJOLDPQ==
X-Received: by 2002:a17:902:d3d3:b0:154:8f89:7815 with SMTP id w19-20020a170902d3d300b001548f897815mr9043312plb.122.1648801790966;
        Fri, 01 Apr 2022 01:29:50 -0700 (PDT)
Received: from localhost.localdomain ([103.149.162.115])
        by smtp.gmail.com with ESMTPSA id p10-20020a056a0026ca00b004fb266fb186sm2118108pfw.73.2022.04.01.01.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 01:29:50 -0700 (PDT)
From:   Dongli Si <kvmx86@gmail.com>
X-Google-Original-From: Dongli Si <sidongli1997@gmail.com>
To:     peterz@infradead.org
Cc:     acme@kernel.org, alexander.shishkin@linux.intel.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, jolsa@kernel.org,
        joro@8bytes.org, kim.phillips@amd.com, kvmx86@gmail.com,
        liam.merwick@oracle.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
        mingo@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
        x86@kernel.org
Subject: Re: [PATCH v4] perf/x86/amd: Don't touch the Host-only bit inside the guest hypervisor
Date:   Fri,  1 Apr 2022 16:29:11 +0800
Message-Id: <20220401082911.2527878-1-sidongli1997@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220328140358.GF8939@worktop.programming.kicks-ass.net>
References: <20220328140358.GF8939@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/03/2022 14:03, Peter Zijlstra wrote:
> Better I suppose, but I think the comments can be improved by covering
> the 'why' of things. We can all read the code to see the what of it.

I will add comments to the code to explain 'why'.

> Anyway, doesn't this also affect behaviour? I'm guessing this HO bit is
> only set by perf-record for events it wants to record on the host. But
> by not setting it, we'll also record the activity of the guest.

I think the HO/GO bit can only be set on the host, and should only be set
if SVM is enabled.

When the SVM is disabled, set the HO/GO bit will cause the performance
counters to not work.

Set the HO/GO bit inside the guest will cause the guest emitted
"unchecked MSR access error" warning, can be triggered by running
"perf stat -e instructions:G ls" in the guest, because this will set
the GO bit in the guest, and perf_ctr_virt_mask just mask the HO bit.

My patch does not affect the host, it just fixes the bug in the guest.

> So suppose we create a CPU wide HO event, then it will only count L0
> activity, right? Any L1 (or higher) activite will be invisible.

I don't quite understand your question.

> But with this change on, the L1 HV doesn't provide these same semantics,
> it's guest will be included in that host counter.

I don't think applying this patch will cause L2 guests to be included in
the host counter.

> Or is there additional counter {dis,en}abling on virt enter,exit (resp.)
> to achieve these semantics?

I don't think there is such a counter.

Also, I found that the L1 HV will emitted "unchecked MSR access error"
warning when "perf record" is executed on L2,
because the GO bit of L1 HV is set.

I wrote a new patch to mask the HO/GO bit in the guest, I will send it later.

Regards,
Dongli

