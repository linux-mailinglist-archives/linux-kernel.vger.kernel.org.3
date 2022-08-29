Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30BAA5A5643
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 23:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiH2VgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 17:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiH2VgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 17:36:16 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45887AC2F
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 14:36:13 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-3321c2a8d4cso228750857b3.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 14:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=vpffA/2S0lCQZw66EqBoxIo3Ki9fW37f7ma72RIaoVo=;
        b=fPOWJgin7A9WJPjvyh9KPuTG1cGCJk7IRkmGyozbbf3odnMP/FbwsuqtSI40BqYj0J
         zdjIu/MhD+m+LFigVMkwK9DTv0foMYbzwbEJI1GLT94m3lnmfLfNXlzL5d4JBQvYrMTG
         mRM31FoU3WyTq8t0qawC/+sDk+T4Ok5g466c+XnZ7K00aSTa7P1fWxm5ZVCoDeDzLVZo
         DKHJQW64bNa30w1WEiIkJyLFOI4+xoZ74zVFw5MDGwJqUNoF+orW1lqJ7Cp4VIeE7C9a
         UnmbTpE19YdWHno6Xyv0AZXl0cn+iIORtpZoppTedziFPPA8SpxgSAG/BqJXCb0/t3nS
         iq0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=vpffA/2S0lCQZw66EqBoxIo3Ki9fW37f7ma72RIaoVo=;
        b=OvxXJlyEbZU6cVvfGzmU+GdAZM+5uM1IIdOBP0DBbcvN5Os1MUQHqNbtLX8+tJVrtO
         o4bpFS2Doi2JpsXGsNC2fCmyunPlMzUFMcMkfcvnYa/N18+cB/IcJV/NupwL0mw3+woz
         PlqKqubhxBsI4TezKGhbax3y5d0B3NJUXQbDuFuN0dJHsXg4KcpfLnIiHK8fhiV/KUye
         mLqL3Mr7s6d3CiMciPnotOYBytHzFMy6xLagk1W8cTSGOmrV4N9XHNr6UlGDh89dXn0B
         Ixid9EwHXSRe8eZJ/GM8CzNeccUFsOV5bkhx/wwrx95Qi0+uxjkkeGXZs2Dl5doYsXoe
         09/w==
X-Gm-Message-State: ACgBeo0FKeUt94kSr1deqoz26UNH9S6RT45cJ+LpOuqnjmqlODY4Iv80
        SdQl6zUo+THZxYYK2/SobX04LVQ0lfXTvRrbg/ViiQ==
X-Google-Smtp-Source: AA6agR6KiVAPo56RwAYqMbS0k4dcCSNfKfh8YkQ+rSQc7JpUMkx11m9a9cDwzeWiscF1REUu2fH50aLLNSBpETtwewc=
X-Received: by 2002:a81:4e8e:0:b0:340:b324:8920 with SMTP id
 c136-20020a814e8e000000b00340b3248920mr10338324ywb.218.1661808972683; Mon, 29
 Aug 2022 14:36:12 -0700 (PDT)
MIME-Version: 1.0
References: <29a5c3e3-a590-01dd-1a2b-8415cae4a292@leemhuis.info>
 <9d431289-085b-5619-00f8-95d692183e28@foss.st.com> <99355482-960a-4669-19b5-926a7cd76c65@foss.st.com>
In-Reply-To: <99355482-960a-4669-19b5-926a7cd76c65@foss.st.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 29 Aug 2022 14:35:36 -0700
Message-ID: <CAGETcx9YvpYFf1mxHi1iA--sE5G2MZLS1x8vHnTu6Wj30ScaOA@mail.gmail.com>
Subject: Re: [Regression] Bug 216420 - Unable to handle kernel NULL pointer
 dereference at virtual address 00000008
To:     Yann Gautier <yann.gautier@foss.st.com>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Russell King <linux@armlinux.org.uk>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        frc.gabriel@gmail.com
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

On Mon, Aug 29, 2022 at 6:54 AM Yann Gautier <yann.gautier@foss.st.com> wrote:
>
> On 8/29/22 13:50, Yann Gautier wrote:
> > On 8/28/22 13:44, Thorsten Leemhuis wrote:
> >> Hi, this is your Linux kernel regression tracker speaking.
> >>
> >> I noticed a regression report in bugzilla.kernel.org. As many (most?)
> >> kernel developer don't keep an eye on it, I decided to forward it (I
> >> hope I picked the right recipients for this mail):
> >>
> >>>   frc.gabriel@gmail.com 2022-08-27 09:36:06 UTC
> >>>
> >>> Created attachment 301682 [details]
> >>> full dmesg output
> >>>
> >>> Hi, good morning!
> >>>
> >>> my device is currently crashing during boot with kernel 6.0.0-rc2. I
> >>> also tried next-20220826 and the outcome is the same.
> >>>
> >>> The full dmesg log can be found attached on crash-boot.txt file.
> >>>
> >>> Thank you and have a good day,
> >>> Gabriel Francisco
> >>
> >>  From that dmesg:
> >>
> >>> [    2.279556] 8<--- cut here ---
> >>> [    2.279734] s4: Bringing 0uV into 815000-815000uV
> >>> [    2.284139] Unable to handle kernel NULL pointer dereference at
> >>> virtual address 00000008
> >>> [    2.288082] s1: Bringing 0uV into 1300000-1300000uV
> >>> [    2.292017] [00000008] *pgd=00000000
> >>> [    2.300784] s2: Bringing 0uV into 2150000-2150000uV
> >>> [    2.304801] Internal error: Oops: 5 [#1] SMP ARM
> >>> [    2.309033] s3: Bringing 0uV into 1800000-1800000uV
> >>> [    2.313196] Modules linked in:
> >>> [    2.313208] CPU: 2 PID: 7 Comm: kworker/u8:0 Not tainted 6.0.0-rc2
> >>> #325
> >>> [    2.313221] Hardware name: Generic DT based system
> >>> [    2.318516] l1: Bringing 0uV into 1225000-1225000uV
> >>> [    2.322655] Workqueue: events_unbound deferred_probe_work_func
> >>> [    2.326162] l2: Bringing 0uV into 1200000-1200000uV
> >>> [    2.332290] PC is at mmci_probe+0x10/0x9b0
> >>> [    2.332308] LR is at amba_probe+0xf0/0x174
> >>> [    2.337399] l3: Bringing 0uV into 1225000-1225000uV
> >>> [    2.341927] pc : [<c0b14e10>]    lr : [<c089036c>]    psr: 80000013
> >>> [    2.348097] l4: Bringing 0uV into 1225000-1225000uV
> >>> [    2.352601] sp : f0839dd0  ip : fffffff8  fp : c1903248
> >>> [    2.352609] r10: c1448b9c  r9 : fffffdfb  r8 : 00000000
> >>> [    2.352616] r7 : c1903000  r6 : eefe45bc  r5 : 00000000  r4 :
> >>> c1903100
> >>> [    2.357020] l5: Bringing 0uV into 1800000-1800000uV
> >>> [    2.360849] r3 : c0b14e00  r2 : 00000000  r1 : 00000000  r0 :
> >>> c1903000
> >>> [    2.365896] l6: Bringing 0uV into 1800000-1800000uV
> >>> [    2.371873] Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM
> >>> Segment none
> >>> [    2.377217] l7: Bringing 0uV into 1800000-1800000uV
> >>> [    2.381944] Control: 10c5787d  Table: 0020406a  DAC: 00000051
> >>> [    2.387543] l8: Bringing 0uV into 1800000-1800000uV
> >>> [    2.393749] Register r0 information: slab kmalloc-1k start
> >>> c1903000 pointer offset 0 size 1024
> >>> [    2.398766] l9: Bringing 0uV into 1800000-1800000uV
> >>> [    2.405119]
> >>> [    2.405124] Register r1 information: NULL pointer
> >>> [    2.405137] Register r2 information:
> >>> [    2.410141] l10: Bringing 0uV into 1800000-1800000uV
> >>> [    2.417186]  NULL pointer
> >>> [    2.417193] Register r3 information: non-slab/vmalloc memory
> >>> [    2.417205] Register r4 information:
> >>> [    2.422124] l11: Bringing 0uV into 1300000-1300000uV
> >>> [    2.427776]  slab kmalloc-1k start c1903000 pointer offset 256
> >>> size 1024
> >>> [    2.432756] l12: Bringing 0uV into 1800000-1800000uV
> >>> [    2.441145]
> >>> [    2.446335] l13: Bringing 0uV into 1800000-1800000uV
> >>> [    2.447655] Register r5 information:
> >>> [    2.452735] l14: Bringing 0uV into 1800000-1800000uV
> >>> [    2.455902]  NULL pointer
> >>> [    2.461123] l15: Bringing 0uV into 2050000-2050000uV
> >>> [    2.463368] Register r6 information: non-slab/vmalloc memory
> >>> [    2.463380] Register r7 information: slab kmalloc-1k start c1903000
> >>> [    2.469373] l16: Bringing 0uV into 2700000-2700000uV
> >>> [    2.472656]  pointer offset 0 size 1024
> >>> [    2.472671] Register r8 information:
> >>> [    2.477868] l17: Bringing 0uV into 2850000-2850000uV
> >>> [    2.484288]  NULL pointer
> >>> [    2.484294] Register r9 information: non-paged memory
> >>> [    2.484305] Register r10 information:
> >>> [    2.489490] l18: Bringing 0uV into 2850000-2850000uV
> >>> [    2.490712]  non-slab/vmalloc memory
> >>> [    2.495937] l19: Bringing 0uV into 3000000-3000000uV
> >>> [    2.499217] Register r11 information:
> >>> [    2.504461] l20: Bringing 0uV into 2950000-2950000uV
> >>> [    2.506683]  slab kmalloc-1k
> >>> [    2.512149] l21: Bringing 0uV into 2950000-2950000uV
> >>> [    2.517361]  start c1903000 pointer offset 584 size 1024
> >>> [    2.517382] Register r12 information:
> >>> [    2.523805] l22: Bringing 0uV into 3000000-3000000uV
> >>> [    2.528556]  non-paged memory
> >>> [    2.532414] l23: Bringing 0uV into 3000000-3000000uV
> >>> [    2.535937] Process kworker/u8:0 (pid: 7, stack limit = 0x(ptrval))
> >>> [    2.541160] l24: Bringing 0uV into 3075000-3075000uV
> >>> [    2.543402] Stack: (0xf0839dd0 to 0xf083a000)
> >>> [    2.543413] 9dc0:                                     c1903000
> >>> c1903000 00000000 7ff15a00
> >>> [    2.543425] 9de0: 60172703 00000000 c1903000 c1903000 20000013
> >>> c1903084 c1903000 c1903100
> >>> [    2.627929] 9e00: 00000000 eefe45bc c1903000 00000000 fffffdfb
> >>> c1448b9c c1903248 c089036c
> >>> [    2.635613] 9e20: c089027c 00000000 c1903000 c1448b9c c147a260
> >>> 00000000 c14672a0 c180f00d
> >>> [    2.643773] 9e40: c18db480 c0940584 c1903000 00000000 c1903000
> >>> c147a260 c1448b9c 0000000d
> >>> [    2.651933] 9e60: 00000000 c0940950 c29b4380 c33d7380 c14c1fe4
> >>> c1448b9c c1903000 00000000
> >>> [    2.660092] 9e80: c14672a0 c180f00d c18db480 c0940ae4 fffffdfb
> >>> c1448b9c f0839ee4 c1903000
> >>> [    2.668252] 9ea0: 00000000 c0941190 00000000 f0839ee4 c09410ec
> >>> c147a260 00000000 c093e658
> >>> [    2.676412] 9ec0: c14672a0 c19dab6c c1b44fb8 cb719486 c1903000
> >>> c1903044 00000001 c0940d9c
> >>> [    2.684572] 9ee0: c147a260 c1903000 00000001 cb719486 c1903000
> >>> c1903000 c13f37dc c093f7a0
> >>> [    2.692731] 9f00: c1903000 c142aeec c142af00 c093fc94 c142af1c
> >>> c1803780 c1806800 c180f000
> >>> [    2.700890] 9f20: 00000000 c033dc60 c1803780 c18db480 c1806800
> >>> c1806800 c180681c c1803780
> >>> [    2.709050] 9f40: c1806800 c1803798 c180681c c1303d40 c18db480
> >>> 00000088 c1806800 c033e148
> >>> [    2.717211] 9f60: c1803780 c1303d40 f0821ea0 c18b7040 c18db480
> >>> c033df2c c1803780 c18b7400
> >>> [    2.725369] 9f80: f0821ea0 00000000 00000000 c03458ac c18b7040
> >>> c03457dc 00000000 00000000
> >>> [    2.733529] 9fa0: 00000000 00000000 00000000 c0300148 00000000
> >>> 00000000 00000000 00000000
> >>> [    2.741688] 9fc0: 00000000 00000000 00000000 00000000 00000000
> >>> 00000000 00000000 00000000
> >>> [    2.749850] 9fe0: 00000000 00000000 00000000 00000000 00000013
> >>> 00000000 00000000 00000000
> >>> [    2.758012]  mmci_probe from amba_probe+0xf0/0x174
> >>> [    2.766161]  amba_probe from really_probe+0xe0/0x40c
> >>> [    2.770847]  really_probe from __driver_probe_device+0xa0/0x204
> >>> [    2.775971]  __driver_probe_device from driver_probe_device+0x30/0xc0
> >>> [    2.781612]  driver_probe_device from
> >>> __device_attach_driver+0xa4/0x11c
> >>> [    2.788209]  __device_attach_driver from bus_for_each_drv+0x80/0xcc
> >>> [    2.794633]  bus_for_each_drv from __device_attach+0xa8/0x1f0
> >>> [    2.800881]  __device_attach from bus_probe_device+0x84/0x8c
> >>> [    2.806784]  bus_probe_device from deferred_probe_work_func+0x8c/0xd4
> >>> [    2.812515]  deferred_probe_work_func from
> >>> process_one_work+0x1fc/0x4c8
> >>> [    2.818854]  process_one_work from worker_thread+0x21c/0x540
> >>> [    2.825275]  worker_thread from kthread+0xd0/0xec
> >>> [    2.831177]  kthread from ret_from_fork+0x14/0x2c
> >>> [    2.835775] Exception stack(0xf0839fb0 to 0xf0839ff8)
> >>> [    2.840465] 9fa0:                                     00000000
> >>> 00000000 00000000 00000000
> >>> [    2.845509] 9fc0: 00000000 00000000 00000000 00000000 00000000
> >>> 00000000 00000000 00000000
> >>> [    2.853668] 9fe0: 00000000 00000000 00000000 00000000 00000013
> >>> 00000000
> >>> [    2.861826] Code: e92d4ff0 e590803c e24dd02c e59061a0 (e5917008)
> >>> [    2.868280] ---[ end trace 0000000000000000 ]---
> >>
> >> See the ticket for more details.
> >>
> >> I'd also like to add the report to the list of tracked regressions to
> >> ensure it's doesn't fall through the cracks in the end:
> >>
> >> #regzbot introduced: v5.19..v6.0-rc2
> >> https://bugzilla.kernel.org/show_bug.cgi?id=216420
> >> #regzbot ignore-activity
> >>
> >> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> >>
> >> P.S.: As the Linux kernel's regression tracker I deal with a lot of
> >> reports and sometimes miss something important when writing mails like
> >> this. If that's the case here, don't hesitate to tell me in a public
> >> reply, it's in everyone's interest to set the public record straight.
> >
> > Hi,
> >
> > If I'm not wrong, the mmci driver shouldn't be probed for this platform.
> > So either there is something wrong with the device tree, or with the
> > AMBA bus driver.
> >
> >
> > Best regards,
> > Yann
>
> Maybe this is related (corrected?) with this patch:
> https://lkml.org/lkml/2022/8/27/164

This fix is probably this one:
https://lore.kernel.org/lkml/20220818172852.3548-1-isaacmanjarres@google.com/

-Saravana
