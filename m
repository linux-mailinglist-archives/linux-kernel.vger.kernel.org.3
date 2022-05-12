Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3A60524DA9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 15:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352739AbiELNBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 09:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354052AbiELNA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 09:00:56 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6494435259
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 06:00:54 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id m15-20020a9d608f000000b00606a788887aso2615617otj.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 06:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hM4gINRD/8H6twDujxcRG1iWBhWngcTIcPKwJ3NWeHI=;
        b=Uq5jA42dpUf4a4d5oDdhSJ+SaH7fCfy9R3XlKetI/YPan/b+0P6SB+M9z4oAYi0Unk
         oZXRpWs/0/bDBDZlq8Jp1UPXEE59KKHDw+2Ff5hvz2bVQFqBN1Wz5Zlx3sWknzExtIrr
         4Bds7eK/4IrFCS59a+nb5WC2abCrw+yssLWRsjEUihM/vqvPZjBt4l7b35j7yDjB/WOL
         jOERw0aWBFIlvxeAjwrTFlVHwfJhIQB/BvZ5L1j/xDWQL2gr5MqH1h7/BKvPTkrgR9Wr
         JPKFNsa/eo/rvXNSJqECdgOQsDZlWX3WnguFNOdwS3M593bp0wYwgr0KjCfhFXnwJjOE
         7AZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hM4gINRD/8H6twDujxcRG1iWBhWngcTIcPKwJ3NWeHI=;
        b=CY1aU1OgTTS+66CqbwXUNbHtAgDtx2uqFCb2TXB5+lSieZfzd5YemZEYh2zfw88aTm
         9z6pJ7ojQIvHczTUjCeve5oT5sGKxTXszYA73ieoSpOvy2tVFpByBbIVr/poXhWbFNOH
         Gxltj2KoLKmEFgDTXG5F33i/ap0272hkzvAK+LhBp1ObUJF+llxjATbezvHbDxNuggd8
         NlMjG8KLvjw8ZnvMH5qLBSm72o2eAuHSkP+J+jPhByQOEhGCaFsGceun11jgbCmRsE+/
         IVsvJ8RVSeENK2a0kVWLLRsKOckBEImpbedNbXp5OERDgqo6im8nhEUSgDlPhJ7syeE5
         XKdg==
X-Gm-Message-State: AOAM532BnqxD9xDJuTbTDETQfBUlBzZ+b9lcucp6vK/ILV9Z5VqAbc/4
        90diyWuehqtHVo/vNlL7JaHmLg2/Qpk7NouT7jHeYw==
X-Google-Smtp-Source: ABdhPJw8n+NNtzZmKnOes7rLaGEeWOocf2jp4qdn5SoHXN2sCMymaj+NGll0BsnYoJNnSXpCjOvY7VGAfOTdY18oX1o=
X-Received: by 2002:a05:6830:23a6:b0:606:1bc8:b0d3 with SMTP id
 m6-20020a05683023a600b006061bc8b0d3mr11819475ots.196.1652360453085; Thu, 12
 May 2022 06:00:53 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000d4f30d05d3aa4f09@google.com> <00000000000004ac9505da46ba30@google.com>
In-Reply-To: <00000000000004ac9505da46ba30@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 12 May 2022 15:00:41 +0200
Message-ID: <CACT4Y+Yqd_a6Mqb4uGSw=Vtx1ppqGxRRURGi1+RCnjYhXnko9w@mail.gmail.com>
Subject: Re: [syzbot] general protection fault in reweight_entity
To:     syzbot <syzbot+8d9571494fc49db5aca1@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, brauner@kernel.org, ccross@google.com,
        christian.brauner@ubuntu.com, david@redhat.com,
        dietmar.eggemann@arm.com, ebiederm@xmission.com, legion@kernel.org,
        linux-kernel@vger.kernel.org, pcc@google.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tadeusz.struk@linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-15.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Mar 2022 at 20:23, syzbot
<syzbot+8d9571494fc49db5aca1@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit 13765de8148f71fa795e0a6607de37c49ea5915a
> Author: Tadeusz Struk <tadeusz.struk@linaro.org>
> Date:   Thu Feb 3 16:18:46 2022 +0000
>
>     sched/fair: Fix fault in reweight_entity
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1230bdd9700000
> start commit:   b81b1829e7e3 Merge tag 'scsi-fixes' of git://git.kernel.or..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=266de9da75c71a45
> dashboard link: https://syzkaller.appspot.com/bug?extid=8d9571494fc49db5aca1
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10209674700000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1645552c700000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: sched/fair: Fix fault in reweight_entity

Yes, it is:

#syz fix: sched/fair: Fix fault in reweight_entity
