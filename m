Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5A34DB59F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 17:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355026AbiCPQJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 12:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344655AbiCPQI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 12:08:58 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014705FF07
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 09:07:43 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id qt6so5161971ejb.11
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 09:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sfyn51iMEtZOW1VvGz9/zKro/mJL/U+AGtoyS/q05lk=;
        b=IxJzMGVBQ3dqOjwnT0kNvGBM1q4ToNrQ8MnPmSDiP9yfNiOStXUVcBRVnxaULD6+qQ
         iDehTRiYAMHSCxlwKAHGVWuwY43EtSG7VmF2E+DrfhETaC+kwkg1Zw7nn0Mt77iaYVPS
         eI5jjYFFkS7OLX94NFKpBzVwOSR3Cj742b3BY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sfyn51iMEtZOW1VvGz9/zKro/mJL/U+AGtoyS/q05lk=;
        b=AHBxPXIRZFN93kFMtw0wtL37Ujzguv8aTe3otnxx0L5dboWxE7g5M4r8k6XnRcckWW
         GWFkcIeQXPEhiH1MeGPrvCYOzx6m5DDOyLT7yZY5pa38Nk/6NOpDgAks5XBCkB0/rzh7
         oxiEUV6VI1rl8ENfsSPW5Z3CNhaJ0EtTuPe1nCqhZI0+hOv9cL/er6+oNeY7gA9A3jlX
         +blBBu23PqspU+PtnkkQ4hZRl10jL6g1bHNziYV0xV2lA9g3cox61sKGk7zCdqucsiWA
         3aEYzqgwBNFaaNEGHL1Yrjdf+s9uWpzeTKdGp4WxFZAfln6k5Qdafv+E5Pc4KvhSJuX0
         sTng==
X-Gm-Message-State: AOAM533CZ0/Nn4fxQovh9EfBiDUtJup7YaF9cwyA4Mbf+fsxZhoq9i/O
        x3Qh7WgtL+LPDj6TuZDJ44j3dr5WegMJsxOLIYw=
X-Google-Smtp-Source: ABdhPJx8UhA0vDw6KSYRlO1VUJ+Qn3FuTeeNGV0wc/atfNqjoqnF7OHic9hdJAj6ZMfvEawmLH679g==
X-Received: by 2002:a17:906:7948:b0:6da:64ed:178e with SMTP id l8-20020a170906794800b006da64ed178emr562072ejo.523.1647446858301;
        Wed, 16 Mar 2022 09:07:38 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id l2-20020a1709060cc200b006d3d91e88c7sm1053754ejh.214.2022.03.16.09.07.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Mar 2022 09:07:36 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id qa43so5145185ejc.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 09:07:35 -0700 (PDT)
X-Received: by 2002:ac2:4f92:0:b0:448:7eab:c004 with SMTP id
 z18-20020ac24f92000000b004487eabc004mr184326lfs.27.1647446495212; Wed, 16 Mar
 2022 09:01:35 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000009e7a1905b8295829@google.com> <00000000000003887a05da3e872c@google.com>
 <CAHk-=wj4HBk7o8_dbpk=YiTOFxvE9LTiH8Gk=1kgVxOq1jaH7g@mail.gmail.com> <CACT4Y+atgbwmYmiYqhFQT9_oHw5cD5oyp5bNyCJNz34wSaMgmg@mail.gmail.com>
In-Reply-To: <CACT4Y+atgbwmYmiYqhFQT9_oHw5cD5oyp5bNyCJNz34wSaMgmg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 16 Mar 2022 09:01:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj270g1sHyvvMz99d5x5A_2BXJExzKGNhF1Ch8Y2Mi0pA@mail.gmail.com>
Message-ID: <CAHk-=wj270g1sHyvvMz99d5x5A_2BXJExzKGNhF1Ch8Y2Mi0pA@mail.gmail.com>
Subject: Re: [syzbot] KASAN: out-of-bounds Read in ath9k_hif_usb_rx_cb (3)
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+3f1ca6a6fec34d601788@syzkaller.appspotmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        ath9k-devel@qca.qualcomm.com, chouhan.shreyansh630@gmail.com,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:USB GADGET/PERIPHERAL SUBSYSTEM" 
        <linux-usb@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Zekun Shen <bruceshenzk@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 12:45 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> But the bug looks to be fixed by something anyway. git log on the file
> pretty clearly points to:
>
> #syz fix: ath9k: Fix out-of-bound memcpy in ath9k_hif_usb_rx_stream

Yeah, that commit 6ce708f54cc8 looks a lot more likely to have any
effect on this than my version bump that the syzbot bisection pointed
to.

But kernels containing that commit still have that

  run #0: crashed: KASAN: use-after-free Read in ath9k_hif_usb_rx_cb

so apparently it isn't actually fully fixed. ;(

                 Linus
