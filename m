Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38DDF57B1FC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 09:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbiGTHpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 03:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbiGTHpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 03:45:41 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA4021E3C;
        Wed, 20 Jul 2022 00:45:39 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id o7so28874173lfq.9;
        Wed, 20 Jul 2022 00:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tVPIkcHFbrIBqwWvbgKoMairnWOWXDJLFc+/HEF3fRk=;
        b=TvwRSCVDrRciTpOnKLMfyHifAJeyTe5WXyx5ysgT2EPtGU05SCryU9kIUgyHW4kqR9
         EBaLbVU/27CKoVZLHD4EI4UbEJKJuU02+DzFI3TSmKuXYkVRl+soRhLc4NQMyQ4eZa9D
         Zr2M1A6XuTHZSPLLhQYBdSC9rIgXAcxpYM9YVlXXoMj2HNJs0lqrUyFzfcNe2jKsnOE/
         RJKNLUgBLZ1Iaza/7BOUpvblYMIj1thXugwy+f81/8tsODb2glK69wBixB3SnotUfGzL
         Vah626GD6k40pZjo6zpYRoH9/S2sKqMPE7FyvN/hDDPav2Qwc+VwpXP/aBxhmlHCAjJg
         /Z8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tVPIkcHFbrIBqwWvbgKoMairnWOWXDJLFc+/HEF3fRk=;
        b=WuCmJjwzZdD9gqtQl5EQF45cVp1zIWdcpQKLlyoK5w11OD0cwqrOImD12PGet4rfyU
         Um3M/Bs0wiTi36/UqPeeSDGgNwsQgVE8wtyij7s/PYA72t0HfP4WJoycWQDqwEz8Aeg2
         C4BeDHLf/T0m3jvnLnJXc72kHsMejtkDQOiDh0LOda2on5ykBHsIcCxMTcCTN3ICJTl2
         PDCzRCQV1yruEcEwrj4H7Yq4QVUCvonImNzXbchii0cWtbhI8/qo5j1XvLy7LjwVugYB
         JvYYik41R6QsfM7gRQ2p7hmKC2024mralpsXuutnoVOjr1naTcvWLmFdcZsu7e6N8wVV
         m+Kw==
X-Gm-Message-State: AJIora+GdF2li8uXb/QH5mpWyarSNOH1JhqPNwmCqHl6ClbM/bEVF2tG
        RxkIR0P3sjPhluW6FG+hhuY/XU8EMz2XsGVf/iY=
X-Google-Smtp-Source: AGRyM1vVIrLVpzkiPr5QbQtV3lohS4xPfbNPKVz8ES1xANkNSPGUrstUkzAZwc68FHS3SJPGuxGCEjBl1ND2WEO5BNo=
X-Received: by 2002:a05:6512:23a0:b0:489:d19c:602d with SMTP id
 c32-20020a05651223a000b00489d19c602dmr19783960lfv.89.1658303138187; Wed, 20
 Jul 2022 00:45:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220705123705.764-1-xuewen.yan@unisoc.com> <20220711174629.uehfmqegcwn2lqzu@wubuntu>
 <YsyO9GM9mCydaybo@slm.duckdns.org> <c1426573-92a7-9f0d-a6b8-aa612248b9a9@redhat.com>
 <Ys41ZF5TmSnLLNRB@slm.duckdns.org>
In-Reply-To: <Ys41ZF5TmSnLLNRB@slm.duckdns.org>
From:   Xuewen Yan <xuewen.yan94@gmail.com>
Date:   Wed, 20 Jul 2022 15:45:27 +0800
Message-ID: <CAB8ipk-8cbur-m733py-cw4bXCt7gkd8gAOXtKO+-fV1B2EeZw@mail.gmail.com>
Subject: Re: [PATCH] sched/schedutil: Fix deadlock between cpuset and cpu
 hotplug when using schedutil
To:     Tejun Heo <tj@kernel.org>
Cc:     Waiman Long <longman@redhat.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Xuewen Yan <xuewen.yan@unisoc.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        ke.wang@unisoc.com, xuewyan@foxmail.com, linux-pm@vger.kernel.org,
        Lukasz Luba <Lukasz.Luba@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all

On Wed, Jul 13, 2022 at 11:20 AM Tejun Heo <tj@kernel.org> wrote:
>
> On Tue, Jul 12, 2022 at 10:49:57PM -0400, Waiman Long wrote:
> > > Well, the only thing I can think of is always grabbing cpus_read_lock()
> > > before grabbing threadgroup_rwsem. Waiman, what do you think?
> >
> > That is a possible solution as cpus_read_lock() is rather lightweight. It is
> > a good practice to acquire it first.
>
> On a similar note, I think we probably should re-enable percpu operations on
> threadgroup_rwsem too by default and allow users who are affected by slower
> write path operations to opt-in. After the new CLONE_INTO_CGROUP which
> doesn't need the rwsem, we have far fewer write lockers after all.
>

 If there's any patch for me to try? I would be very grateful.

Thanks!

---
xw.yan
