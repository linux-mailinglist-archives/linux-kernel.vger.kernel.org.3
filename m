Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2619509B2D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 10:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386948AbiDUIxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 04:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386942AbiDUIxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 04:53:36 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3197EDF4C
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 01:50:47 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-2f18982c255so44811787b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 01:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2+Tn3N0Fvpk4WLUjDImpMjWVuIM4JomwqBL2Nlcl6w4=;
        b=srOPHl+SSSvyJraiIGtZa7k+iOztdGyUCFCJmPMMSJOZggJM7tjjlh4UaBCTB0/cA+
         mOkgqWO28/EAatrwxpRMuBM3U3BMcuwpuqg0jSF3sn+mp+yGKe5zQWJMgeDjIXYmFSjQ
         pFPeSvRz9NpABzixQiucjfpy2lgUEVcs63hUDZHaPxV4HiDO2eZHaqSLRsVZXs6usSYR
         DBn1gZQTkx7T4civ95Eo/H2O+80fnqPEoNiX/DNzIt2SMvLmOrMYs+cOnKNRZYodOd87
         xxwD62K/uXhikpPdPjz4Ayg/lpswOPh7umBjR5XWVeTJNTCjtIaUlLaKJT2l65CD0/pa
         s+tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2+Tn3N0Fvpk4WLUjDImpMjWVuIM4JomwqBL2Nlcl6w4=;
        b=VMiuElPUWFKKefvG2NBbBnz66RhoS9AnZP11lLOXlHEvgGf4cfHbWtfv+tau3nbj/d
         yNcgfr7giy7YAGba+R8Hu6IDFrkhWVnBFnZvyEDgN9BMaSKZ3HIyPayGohbeczHxRVLU
         F8F6sB0YNUiW0DfwfthMPHcVCbEh6SNqBN+ho7eqFtoZRxIvh/gmVuCBocg2zIOoc5KV
         8Ztyx9gbyHfVm5yo+hG10aW5FaK9bzfyymPA4zYeQwqs7q0kAKR4KODdZK+j7jkEFYaa
         9+J3pCvVXJptnyYp5r14sS5j4XgHn/67BAFpqa1bdYgtVjoSi3urrwmI9llINk/Xuxgi
         STeQ==
X-Gm-Message-State: AOAM531ib3OHUA/FAUp06etTz8yfOnWVLTX5MJkisK4lDEPl5EuKN4rN
        jz6+0WcrEHC3FCLz0+jh62SpvWn7RWerHRmRLucyeQ==
X-Google-Smtp-Source: ABdhPJwMCN2O6NIGJNgyINLQmSXqBTAYpvAJSbIulpsUYVehSD6z2L8Y9p2tisjuw/yuEMupVdJ725E+y3uWH5bFubc=
X-Received: by 2002:a81:6c89:0:b0:2f1:c84a:55d with SMTP id
 h131-20020a816c89000000b002f1c84a055dmr12785051ywc.333.1650531046192; Thu, 21
 Apr 2022 01:50:46 -0700 (PDT)
MIME-Version: 1.0
References: <Yl/qa2w3q9kyXcQl@elver.google.com> <20220421083715.45380-1-huangshaobo6@huawei.com>
In-Reply-To: <20220421083715.45380-1-huangshaobo6@huawei.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 21 Apr 2022 10:50:10 +0200
Message-ID: <CANpmjNMAT_DaiOoz=k6Z13nVR_2A_5fck12h0JKQSmNQRSKwGg@mail.gmail.com>
Subject: Re: [PATCH] kfence: check kfence canary in panic and reboot
To:     Shaobo Huang <huangshaobo6@huawei.com>
Cc:     akpm@linux-foundation.org, chenzefeng2@huawei.com,
        dvyukov@google.com, glider@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
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

On Thu, 21 Apr 2022 at 10:37, Shaobo Huang <huangshaobo6@huawei.com> wrote:
[...]
> > >  static int __init kfence_debugfs_init(void)
> > >  {
> > >     struct dentry *kfence_dir = debugfs_create_dir("kfence", NULL);
> > > @@ -806,6 +832,8 @@ static void kfence_init_enable(void)
> > >
> > >     WRITE_ONCE(kfence_enabled, true);
> > >     queue_delayed_work(system_unbound_wq, &kfence_timer, 0);
> > > +   register_reboot_notifier(&kfence_check_canary_notifier);
> > > +   atomic_notifier_chain_register(&panic_notifier_list, &kfence_check_canary_notifier);
> >
> > Executing this on panic is reasonable. However,
> > register_reboot_notifier() tells me this is being executed on *every*
> > reboot (not just panic). I think that's not what we want, because that
> > may increase reboot latency depending on how many KFENCE objects we
> > have. Is it possible to *only* do the check on panic?
>
> if oob occurs before reboot, reboot can also detect it, if not, the detection will be missing in this scenario.
> reboot and panic are two scenarios of system reset, so I think both scenarios need to be added.

That doesn't quite answer my question, why do you want to run the
check during normal reboot? As I understand it right now it will run
on any normal reboot, and also on panics. I have concerns adding these
checks to normal reboots because it may increase normal reboot
latency, which we do not want.
