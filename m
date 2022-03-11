Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B93E4D606D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 12:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348164AbiCKLQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 06:16:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbiCKLQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 06:16:06 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761771B65DA
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 03:15:03 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id q5so11573319ljb.11
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 03:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Rw+hMbOrSt8hvgxttpe8QoEP60QwILMoc5OZJNW6qJw=;
        b=pnmcHmzBY+xi3kUlxgjue9/t7NkJcSBDZoe8W3KAxtbDuyMAyTu8SweKl4XxBdVedp
         upbWUb7D/wtvbMxIcy2+FVsjUD3/SjbaW0ZlzNDJ1e4jq89t4rF2DVGkDJQhSjbfGarQ
         yn9L7Of1jk0q4q+9TtIxcYbjqE551i7mAevQcCMh1YQhM036r2QHlQ7H58RbrHUoJHOX
         2WengU+7CNOkroaWNVweA5qjWPxCyhPyuhn7EiJCZ+HDkHZytNVRNmBHvslOE1auNj5T
         G3CgDDMzGqkOkqzk+3IiRMClCrcMT0XNXGGrCTnkQaib+y0rhGxiFyB3jqEB5EZ/c53E
         LWOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Rw+hMbOrSt8hvgxttpe8QoEP60QwILMoc5OZJNW6qJw=;
        b=GOm7XLvom7iF2qhhv5GPOh0f3VKKYHZJGzHg+cwbz5ggTVBtdGrYYqdYYX7cHD4mdB
         45DqwUTDn7orUopny9Cvx4ZmStPjsxwuxGJzhiJtLj6gNtZtnnchGbXWzp2sYz687cgC
         +SJfxMPci8vFr1FM1G7dRI7zCKret5O1XpDFlGwy8xyB1ctAl1nlBgNfRsYkDDOVnFmW
         ArBRAoqJqxdxLwwg+Z2MW7pvmUWBhhWsfDtWEQciEwnzIJAeF3wto4EtdiAhrf1NDVgN
         YYEQkdxrtzbqBRIqaKrJs6RgdJFIFeg/roDDWRK1pd4QGMAleinT7RTWBGGs4insoqNw
         2S9Q==
X-Gm-Message-State: AOAM531p28ycFVLFDdtjCWxzfe8+PYWRrxAPKYkXkHgeLDrwA6pstrF2
        Q2QaiWCZ2SxvRR4Al+cFXv7qwC5mejFXhSmf6sMYMw==
X-Google-Smtp-Source: ABdhPJzTDPi6HK0XRJr+S7TcDG256d1oXIzeRtTIxRmyM4AKGWYcoWfM9F1ENq475XBz908icuPFYKYAOfTojS5GYVU=
X-Received: by 2002:a2e:6e0b:0:b0:247:f07d:ed69 with SMTP id
 j11-20020a2e6e0b000000b00247f07ded69mr5781721ljc.381.1646997301636; Fri, 11
 Mar 2022 03:15:01 -0800 (PST)
MIME-Version: 1.0
References: <1646917125-20038-1-git-send-email-wangqing@vivo.com>
 <CAKfTPtAvbpUUaOqP3gmOT7fLk8-7v70LzBUiQ-vgDvc7ZZujag@mail.gmail.com>
 <SL2PR06MB30828CF9FF2879AFC9DC53D2BD0C9@SL2PR06MB3082.apcprd06.prod.outlook.com>
 <CAKfTPtBM9WBEgP_PpRHNaATvp9FrBeV2NXhg_EAp4xYtBZYCWQ@mail.gmail.com>
 <SL2PR06MB30826C314139509EC4778C1BBD0C9@SL2PR06MB3082.apcprd06.prod.outlook.com>
 <CAKfTPtA=dy4M2OK+GqvPDo9D8YBZAHbEpM-YPVZEyEUjEJKU5g@mail.gmail.com> <SL2PR06MB308268BDF646BFA0FC9A4590BD0C9@SL2PR06MB3082.apcprd06.prod.outlook.com>
In-Reply-To: <SL2PR06MB308268BDF646BFA0FC9A4590BD0C9@SL2PR06MB3082.apcprd06.prod.outlook.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 11 Mar 2022 12:14:49 +0100
Message-ID: <CAKfTPtCVV_cpBty7xH8Gea8HdjNzfiE3Kd882i7Pffvrv3p1zw@mail.gmail.com>
Subject: Re: [PATCH] sched: topology: make cache topology separate from cpu topology
To:     =?UTF-8?B?546L5pOO?= <wangqing@vivo.com>
Cc:     Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Mar 2022 at 10:30, =E7=8E=8B=E6=93=8E <wangqing@vivo.com> wrote:
>
>
> >>
> >>
> >> >>
> >> >>
> >> >> >On Thu, 10 Mar 2022 at 13:59, Qing Wang <wangqing@vivo.com> wrote:
> >> >> >>
> >> >> >> From: Wang Qing <wangqing@vivo.com>
> >> >> >>
> >> >> >> Some architectures(e.g. ARM64), caches are implemented below:
> >> >> >> cluster:                     ****** cluster 0 *****      ****** =
cluster 1 *****
> >> >> >> core:                         0      1          2      3        =
  4      5           6      7
> >> >> (add cache level 1)        c0    c1        c2    c3         c4    c=
5         c6    c7
> >> >> >> cache(Leveln):         **cache0**  **cache1**  **cache2**  **cac=
he3**
> >> >> (add cache level 3)        *************share level 3 cache *******=
********
> >> >> >> sd_llc_id(current):     0      0          0      0          4   =
   4           4      4
> >> >> >> sd_llc_id(should be): 0      0          2      2          4     =
 4           6      6
> >> >> >>
> >> >> Here, n always be 2 in ARM64, but others are also possible.
> >> >> core[0,1] form a complex(ARMV9),  which share L2 cache, core[2,3] i=
s the same.
> >> >>
> >> >> >> Caches and cpus have different topology, this causes cpus_share_=
cache()
> >> >> >> return the wrong value, which will affect the CPU load balance.
> >> >> >>
> >> >> >What does your current scheduler topology  look like?
> >> >> >
> >> >> >For CPU 0 to 3, do you have the below ?
> >> >> >DIE [0     -     3] [4-7]
> >> >> >MC  [0] [1] [2] [3]
> >> >>
> >> >> The current scheduler topology consistent with CPU topology:
> >> >> DIE  [0-7]
> >> >> MC  [0-3] [4-7]  (SD_SHARE_PKG_RESOURCES)
> >> >> Most Android phones have this topology.
> >> >> >
> >> >> >But you would like something like below for cpu 0-1 instead ?
> >> >> >DIE [0     -     3] [4-7]
> >> >> >CLS [0 - 1] [2 - 3]
> >> >> >MC  [0] [1]
> >> >> >
> >> >> >with SD_SHARE_PKG_RESOURCES only set to MC level ?
> >> >>
> >> >> We don't change the current scheduler topology, but the
> >> >> cache topology should be separated like below:
> >> >
> >> >The scheduler topology is not only cpu topology but a mixed of cpu an=
d
> >> >cache/memory cache topology
> >> >
> >> >> [0-7]                          (shared level 3 cache )
> >> >> [0-1] [2-3][4-5][6-7]   (shared level 2 cache )
> >> >
> >> >So you don't  bother the intermediate cluster level which is even sim=
pler.
> >> >you have to modify generic arch topology so that cpu_coregroup_mask
> >> >returns the correct cpu mask directly.
> >> >
> >> >You will notice a llc_sibling field that is currently used by acpi bu=
t
> >> >not DT to return llc cpu mask
> >> >
> >> cpu_topology[].llc_sibling describe the last level cache of whole syst=
em,
> >> not in the sched_domain.
> >>
> >> in the above cache topology, llc_sibling is 0xff([0-7]) , it describes
> >
> >If llc_sibling was 0xff([0-7] on your system, you would have only one le=
vel:
> >MC[0-7]
>
> Sorry, but I don't get it, why llc_sibling was 0xff([0-7] means MC[0-7]?
> In our system(Android), llc_sibling is indeed 0xff([0-7]) , because they
> shared the llc(L3), but we also have two level:
> DIE [0-7]
> MC [0-3][4-6]
> It makes sense, [0-3] are little cores, [4-7] are bit cores, se only up m=
igrate
> when misfit. We won't change it.
>
> >
> >> the L3 cache sibling, but sd_llc_id describes the maximum shared cache
> >> in sd, which should be [0-1] instead of [0-3].
> >
> >sd_llc_id describes the last sched_domain with SD_SHARE_PKG_RESOURCES.
> >If you want llc to be [0-3] make sure that the
> >sched_domain_topology_level array returns the correct cpumask with
> >this flag
>
> Acturely, we want sd_llc to be [0-1] [2-3], but if the MC domain don't ha=
ve

sd_llc_id refers to a scheduler domain but your patch breaks this so
if you want a llc that reflects this topo:  [0-1] [2-3] you must
provide a sched_domain level with this topo

side question, why don't you want llc to be the L3 one ?

> SD_SHARE_PKG_RESOURCES flag, the sd_llc will be [0][1][2][3]. It's not tr=
ue.

The only entry point for describing the scheduler domain is the
sched_domain_topology_level array which provides some cpumask and some
associated flags. By default, SD_SHARE_PKG_RESOURCES is set for
scheduler MC level which implies that the cpus shared their cache. If
this is not the case for your system, you should either remove this
flag or update the cpumask to reflect which CPUs really share their
caches.

>
> So we must separate sd_llc from sd topology, or the demand cannot be
> met in any case under the existing mechanism.

There is a default array with DIE, MC, CLS and SMT levels with
SD_SHARE_PKG_RESOURCES set up to MC which is considered to be the LLC
but a different array than the default one can be provided with
set_sched_topology()

Thanks
Vincent

>
> Thanks,
> Wang
>
