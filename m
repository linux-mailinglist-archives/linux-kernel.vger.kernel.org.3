Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2722058ED99
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 15:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbiHJNuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 09:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232836AbiHJNuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 09:50:19 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57BEB1F5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 06:50:18 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id o5-20020a17090a3d4500b001ef76490983so2174894pjf.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 06:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=eDHehK2dT1EAEXS+z232qVuqC1dsyPdCC8aOihNHjpI=;
        b=WyeKjiizW06I7/Wn6uNcAXOEm+otebFXGH1bMuw60y2l1PwicyVIfgwvVc4rAzG3zL
         nTpO3ag9QcuJ3zsDWPh4x35I4/1juj8Ce5VJeE4od7PS+ztnFGtWB9giIFUlVe4AKSTV
         lhRiPcDuoYtCyMMBbygKEnzLnzrmtRVZ/PFFW/Xgwq/Lcka/S8BwseJyyyMROVR0WZYo
         7ebV7Dp5C2EM4qi3k2e0dfhlKtuqgP3jem7GBz/YhH3IOAmPNmbBa6Mue8BXAGzuYzpC
         k8izK1YgCzm4r9OOkIGAJqSmx6lBxaoC6S56z1aLJRl4gnrhca//ZddeU5LKm3rlM6xa
         RVUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=eDHehK2dT1EAEXS+z232qVuqC1dsyPdCC8aOihNHjpI=;
        b=z9kXgSNqOZVIZApGSEY1IAoDM7omxfZc66yHadix++mVNwDQMFlXGT/q5TrMQo1/11
         4yrN91vDmyJoXwaE5EK5RSJo/517MkEXzFVKJoS2JHoi8HkbtcKVNJv57PnAJdvqQtAL
         e6ICwfg9+RU5wrPtT25MGVZZcDfQnHfpacRtMlRgdWdVHteI6bEld1vTj0wdwRC6m8Tv
         K8arA+LfxOcjZMx3g38jXodsvVtzOWKhazqyM0tqnTA3vcROHe8sIGzlXEr4oULz9gmB
         Wq4Wp43zVRZjp3Tkrdacr7+7kt5HIMLpMPAmTGJGgyKwM1AFJVvCv9ijH4YTUdJi5reg
         orjQ==
X-Gm-Message-State: ACgBeo1PNRP+tLxZoBcMcNNF50UStA786OYJPhKg/kLjsuRyRMTIiOQq
        g980zN7+oF+nEBwucVjJyQVcrlEgInyvFLR8x2ZvmH5wBQY=
X-Google-Smtp-Source: AA6agR7z1Tl/FgN8Gf9i412hFHQM0Q9Hk9vVEfuUiU8R1pUNnIcqyWZtllI28j52JaL3RIjjszmPexHEEZAYVUvPyv0=
X-Received: by 2002:a17:902:8502:b0:16c:c5c5:a198 with SMTP id
 bj2-20020a170902850200b0016cc5c5a198mr27576448plb.88.1660139418343; Wed, 10
 Aug 2022 06:50:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220712082036.5130-1-wuyun.abel@bytedance.com> <20220712082036.5130-2-wuyun.abel@bytedance.com>
In-Reply-To: <20220712082036.5130-2-wuyun.abel@bytedance.com>
From:   Chen Yu <yu.chen.surf@gmail.com>
Date:   Wed, 10 Aug 2022 21:50:06 +0800
Message-ID: <CADjb_WRdvKm=uJGe2zE+D6fHkuCX4i+WkrWqz1A3VXmtdKN_Tg@mail.gmail.com>
Subject: Re: [PATCH 1/5] sched/fair: ignore SIS_UTIL when has idle core
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Josh Don <joshdon@google.com>, Chen Yu <yu.c.chen@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 4:45 PM Abel Wu <wuyun.abel@bytedance.com> wrote:
>
> When SIS_UTIL is enabled, SIS domain scan will be skipped if
> the LLC is overloaded. Since the overloaded status is checked
> in the load balancing at LLC level, the interval is llc_size
> miliseconds. The duration might be long enough to affect the
> overall system throughput if idle cores are out of reach in
> SIS domain scan.
>
> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
> ---
>
Tested schbench and netperf on latest 5.19 vanilla, it seems that there
is latency performance improvement when the load is low in schbench,
and no performance difference on netperf.

 ./report.py -b 5.19.0+ -c 5.19.0-skip-sis-util+ -t schbench

schbench
========
case            load    baseline(std%) compare%( std%)
normal          mthread-1 1.00 (  0.00) +7.69 (  0.00)
normal          mthread-2 1.00 (  0.00) +13.24 (  0.00)
normal          mthread-4 1.00 (  0.00) -5.88 (  0.00)
normal          mthread-8 1.00 (  0.00) -0.25 (  0.00)


./report.py -b 5.19.0+ -c 5.19.0-skip-sis-util+ -t netperf
netperf
=======
case            load    baseline(std%) compare%( std%)
TCP_RR          thread-28 1.00 (  0.62) +0.15 (  0.55)
TCP_RR          thread-56 1.00 (  0.42) -0.26 (  0.40)
TCP_RR          thread-84 1.00 (  0.29) +0.39 (  0.29)
TCP_RR          thread-112 1.00 (  0.22) +0.44 (  0.23)
TCP_RR          thread-140 1.00 (  0.17) +0.33 (  0.18)
TCP_RR          thread-168 1.00 (  0.17) +0.19 (  0.16)
TCP_RR          thread-196 1.00 ( 13.65) -0.62 ( 14.83)
TCP_RR          thread-224 1.00 (  9.80) -0.65 (  9.67)
UDP_RR          thread-28 1.00 (  0.89) +0.92 (  0.81)
UDP_RR          thread-56 1.00 (  0.78) +0.38 (  0.73)
UDP_RR          thread-84 1.00 ( 14.03) +0.78 ( 16.85)
UDP_RR          thread-112 1.00 ( 12.26) -0.42 ( 11.95)
UDP_RR          thread-140 1.00 (  9.86) -0.89 (  6.93)
UDP_RR          thread-168 1.00 ( 11.62) -0.82 (  8.80)
UDP_RR          thread-196 1.00 ( 19.47) +0.42 ( 16.50)
UDP_RR          thread-224 1.00 ( 18.68) +0.72 ( 18.50)


Tested-by: Chen Yu <yu.c.chen@intel.com>

-- 
Thanks,
Chenyu
