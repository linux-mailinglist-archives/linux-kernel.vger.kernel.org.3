Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47A164D5D3F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 09:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbiCKI1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 03:27:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbiCKI1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 03:27:01 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4784A1B8FDA
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 00:25:58 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id 25so11084652ljv.10
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 00:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jUJjiaE7A8Un8ALMYCIkfz/RnLwdAy9+LTkyo23eMhI=;
        b=nHkq9ojGh+UlJYurhLlNnnF0AXQ3iwaVSq7IOiFYV4u4YWNyfPuy2fmNPFPX6L3RaT
         VTPhUUaIe5oZOxFo1vK139x7hoQVrtpxUNsMngK3vq+UYx9bkHpyIzlSCxmDGWRweJcR
         uOjtjCCZVYhYmoJAnLVDfZF3Zp0jVjQ7mZxqK+aeMAXNeiMMGGj9Y5gES6WwzgmoBXyp
         h0bU380nh/BqtEJ+f5KJQ8GwtYQO1Dbp/u8HZvqbtTHYZYYdtEWFcOsSivrzDNybtQeM
         olh2gCKQY6cJ+gSep7Cy+CMd9PeeiIZ16RmPprqkrUpGWy/Eo8QqOhx41E1Ip3lUuKQ0
         ryug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jUJjiaE7A8Un8ALMYCIkfz/RnLwdAy9+LTkyo23eMhI=;
        b=6GLArGBuk6d2cbXGKhBErm4hiXiauuFVG17PSOv9XHnJAkhopb7DJOdrNRJLmPNdWd
         fiqoe5N3F5PvN9Gy5LcnNtyfcikswMYVxE+3HOUv78WlyAcWODQze3AplOjpC0yYH+VD
         Cj31fwKsRm3Vmxt7vOxEtUaZHs2Ty3Gn/kzOVBkQT46Z6W047Ylo1Dn1wKf5Vm700Dzz
         xB53xRRcuzf52ZS4cJHc3sPNKabN6ryzpyb5cvexPcfAWdxHmc2EU2y11X74/W/dVhrV
         eVdOaB/Zfs2Skv1rTTDhDnOrhrN04eSBRgDyEjQQmmCsOrnEeOneQbOjC6130llFe8AO
         xeyw==
X-Gm-Message-State: AOAM533+frSowBy5MFqPFBLtMENUvdwuaTZ1ySPKzTNpwVO0EFtatkgg
        A5KAc1E7cZTxkkIJsHEcXIind7KCfT6NAggpQob8vA==
X-Google-Smtp-Source: ABdhPJyw/TTwkPo3uERkAcniLuodDqHJZwWnf1mZS4KZ64rZoaOypik2p6ZHo+Pa1rh6EsmGbMb9VYmcdmaSpvN+rkU=
X-Received: by 2002:a2e:a905:0:b0:246:609b:881e with SMTP id
 j5-20020a2ea905000000b00246609b881emr5316200ljq.383.1646987156572; Fri, 11
 Mar 2022 00:25:56 -0800 (PST)
MIME-Version: 1.0
References: <1646917125-20038-1-git-send-email-wangqing@vivo.com>
 <CAKfTPtAvbpUUaOqP3gmOT7fLk8-7v70LzBUiQ-vgDvc7ZZujag@mail.gmail.com>
 <SL2PR06MB30828CF9FF2879AFC9DC53D2BD0C9@SL2PR06MB3082.apcprd06.prod.outlook.com>
 <CAKfTPtBM9WBEgP_PpRHNaATvp9FrBeV2NXhg_EAp4xYtBZYCWQ@mail.gmail.com> <SL2PR06MB30826C314139509EC4778C1BBD0C9@SL2PR06MB3082.apcprd06.prod.outlook.com>
In-Reply-To: <SL2PR06MB30826C314139509EC4778C1BBD0C9@SL2PR06MB3082.apcprd06.prod.outlook.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 11 Mar 2022 09:25:45 +0100
Message-ID: <CAKfTPtA=dy4M2OK+GqvPDo9D8YBZAHbEpM-YPVZEyEUjEJKU5g@mail.gmail.com>
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

On Fri, 11 Mar 2022 at 09:18, =E7=8E=8B=E6=93=8E <wangqing@vivo.com> wrote:
>
>
> >>
> >>
> >> >On Thu, 10 Mar 2022 at 13:59, Qing Wang <wangqing@vivo.com> wrote:
> >> >>
> >> >> From: Wang Qing <wangqing@vivo.com>
> >> >>
> >> >> Some architectures(e.g. ARM64), caches are implemented below:
> >> >> cluster:                     ****** cluster 0 *****      ****** clu=
ster 1 *****
> >> >> core:                         0      1          2      3          4=
      5           6      7
> >> (add cache level 1)        c0    c1        c2    c3         c4    c5  =
       c6    c7
> >> >> cache(Leveln):         **cache0**  **cache1**  **cache2**  **cache3=
**
> >> (add cache level 3)        *************share level 3 cache **********=
*****
> >> >> sd_llc_id(current):     0      0          0      0          4      =
4           4      4
> >> >> sd_llc_id(should be): 0      0          2      2          4      4 =
          6      6
> >> >>
> >> Here, n always be 2 in ARM64, but others are also possible.
> >> core[0,1] form a complex(ARMV9),  which share L2 cache, core[2,3] is t=
he same.
> >>
> >> >> Caches and cpus have different topology, this causes cpus_share_cac=
he()
> >> >> return the wrong value, which will affect the CPU load balance.
> >> >>
> >> >What does your current scheduler topology  look like?
> >> >
> >> >For CPU 0 to 3, do you have the below ?
> >> >DIE [0     -     3] [4-7]
> >> >MC  [0] [1] [2] [3]
> >>
> >> The current scheduler topology consistent with CPU topology:
> >> DIE  [0-7]
> >> MC  [0-3] [4-7]  (SD_SHARE_PKG_RESOURCES)
> >> Most Android phones have this topology.
> >> >
> >> >But you would like something like below for cpu 0-1 instead ?
> >> >DIE [0     -     3] [4-7]
> >> >CLS [0 - 1] [2 - 3]
> >> >MC  [0] [1]
> >> >
> >> >with SD_SHARE_PKG_RESOURCES only set to MC level ?
> >>
> >> We don't change the current scheduler topology, but the
> >> cache topology should be separated like below:
> >
> >The scheduler topology is not only cpu topology but a mixed of cpu and
> >cache/memory cache topology
> >
> >> [0-7]                          (shared level 3 cache )
> >> [0-1] [2-3][4-5][6-7]   (shared level 2 cache )
> >
> >So you don't  bother the intermediate cluster level which is even simple=
r.
> >you have to modify generic arch topology so that cpu_coregroup_mask
> >returns the correct cpu mask directly.
> >
> >You will notice a llc_sibling field that is currently used by acpi but
> >not DT to return llc cpu mask
> >
> cpu_topology[].llc_sibling describe the last level cache of whole system,
> not in the sched_domain.
>
> in the above cache topology, llc_sibling is 0xff([0-7]) , it describes

If llc_sibling was 0xff([0-7] on your system, you would have only one level=
:
MC[0-7]

> the L3 cache sibling, but sd_llc_id describes the maximum shared cache
> in sd, which should be [0-1] instead of [0-3].

sd_llc_id describes the last sched_domain with SD_SHARE_PKG_RESOURCES.
If you want llc to be [0-3] make sure that the
sched_domain_topology_level array returns the correct cpumask with
this flag


>
> Thanks,
> Wang
