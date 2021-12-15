Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1157475188
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 04:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239660AbhLOD7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 22:59:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235424AbhLOD7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 22:59:17 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30749C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 19:59:17 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id 207so31303718ljf.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 19:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0tjE/40QVq1O5nmoJ1f6NdfWomQGy4kZlQAecDcJBAY=;
        b=lMukVHCCCrsBCkWUUA9h8abns1sXvGs2ZJHKiinYOvQYdFNeGuUp8oHFjQN+HNWJat
         MDG2wX/8wbhMg3aEKTaOWAer2dTwIdKaVnvDxTN8eH6yZ/SMTLT6t/kwD/E7yZIYZ4iF
         WBNLWMd/yvSTlanK4sCl2Dbk888/pFJnJbiLdAQYcrbEvLPSiz/f6xoj9jeN/+WHtxHD
         9fh2cBimdj63hJdEfLc2JdCD6p+XQhN4QF2mnhMs74pu9hxHxW84jxy8ww99NDN2oW0u
         dQpAAEnEeeUR0nb+ElfaACPB6LbOXwOLyQzQI6tSq+A2oORrD0u+8O/BuvacvLoHp1Dm
         sA6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0tjE/40QVq1O5nmoJ1f6NdfWomQGy4kZlQAecDcJBAY=;
        b=4C7uUJ88kKEA4oxQRBFrYTk1oYJa6JcpJ20ka/z8YFLieV2MLRTUIggLJ0jn5zxutI
         GH3jDvEvdHqCEhQVEQWehf88a8N26eGo/AoLkqeKCBC2xoV2nsUJJomOfAJZxSYl2fMN
         ducFs1Jp/sTwplU7oeynEq7Puyp3lM1HNeppufUTjJYnN0UVkCLuldokqtnEHpEVBDxU
         UBVSUwa1hPQuh+42LTGxxsP1N1hN8Z6eGoJNjAp4sZpKGLs/qGnBO9IECqhprkfsEWS8
         Yecd+pFOKXZ17h7zt6DQQ0pVgsO8kvdA9TxivotgOHefAEVWnm4COUQfBLIOgRYqxN0c
         Zl8A==
X-Gm-Message-State: AOAM532R/uRlbeBt7UGZWjMeCy95Xonl4k5MA48Efg/KW+SyZ3PFGOKc
        RzMMn5RK67YEvrIHCNUOx/u9+96DFu8GQt/8tat4bw==
X-Google-Smtp-Source: ABdhPJwQADB+Z5LoN6xoV02kzdHV72/9d8qqf3kqL6tB/YVGP/Y2TPgGWz4/q6/qmdLqzz/Rgx0Suo/MD99/j8Z1goQ=
X-Received: by 2002:a2e:83cc:: with SMTP id s12mr8308376ljh.508.1639540755235;
 Tue, 14 Dec 2021 19:59:15 -0800 (PST)
MIME-Version: 1.0
References: <20211214050708.4040200-1-vipinsh@google.com> <YbjRb0XR7neyX/Gy@google.com>
In-Reply-To: <YbjRb0XR7neyX/Gy@google.com>
From:   Vipin Sharma <vipinsh@google.com>
Date:   Tue, 14 Dec 2021 19:58:39 -0800
Message-ID: <CAHVum0ec420f4dMseNRCJqzfLV+5V6NpmaBibPZDzsc15S_3oA@mail.gmail.com>
Subject: Re: [PATCH] KVM: Move VM's worker kthreads back to the original
 cgroups before exiting.
To:     Sean Christopherson <seanjc@google.com>
Cc:     pbonzini@redhat.com, dmatlack@google.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 9:16 AM Sean Christopherson <seanjc@google.com> wrote:
>
> On Tue, Dec 14, 2021, Vipin Sharma wrote:
> > +     WARN_ON(cgroup_attach_task_all(kthreadd_task, current));
>
> As the build bot noted, kthreadd_task isn't exported, and I doubt you'll convince
> folks to let you export it.
>
> Why is it problematic for the kthread to linger in the cgroup?  Conceptually, it's
> not really wrong.

Issue comes when a process tries to clear up the resources when a VM
shutdown/dies. The process sometimes get an EBUSY error when it tries
to delete the cgroup directories which were created for that VM. It is
also difficult to know how many times to retry or how much time to
wait before the cgroup is empty. This issue is not always happening.
