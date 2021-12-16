Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC35477C73
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 20:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241009AbhLPTX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 14:23:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236592AbhLPTXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 14:23:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C2DC061574;
        Thu, 16 Dec 2021 11:23:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12E4661F43;
        Thu, 16 Dec 2021 19:23:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76116C36AF4;
        Thu, 16 Dec 2021 19:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639682604;
        bh=746Wi8lFtidph6UMKrEtyiAFIb26Qk6Tck1tpYVSdjU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oI34vlPyaxjtCzkI1Jnls8zB1kHFU5TJnskClnjB/u/aNdKpKP78S9XCmYBLFTFSY
         0VOAUJB4DWZa7zI3STiMKHi3kYAMOlRkZDkizc1KKZJg6HNF4paqyH5fIdjXztuYSt
         E7bvpNJbxxVoWMvzDn75Mx77MCub+jKOJXN3+aSeL1sSzN5sRrQMtqdzsWCcWXN3/g
         LxTIGFQNrSv2l5K2tpjsKOrt4RR7l2dKJIH7jrkqZVLD59kcdQtVGMQirs4aB5p27q
         GKj/lk4N3BYl7ertmaXAfyYLPV8kI1AEsMEitL968Fk6pnzcby/T41+QBoGMjIYPVb
         Beu8gdYAlxvsg==
Received: by mail-yb1-f171.google.com with SMTP id d10so164005ybn.0;
        Thu, 16 Dec 2021 11:23:24 -0800 (PST)
X-Gm-Message-State: AOAM532W8FCuwIKwLDV6BWSvZYR4PydhhINeDHi3T8Gb3B7ErQG5ZCYL
        sUsn/hOiufJRiPrK4EwpihnyOBuOPB3O5u64TDY=
X-Google-Smtp-Source: ABdhPJypGUtC+ndQMzUVObdGSvjIUmgmJspTnK8KsPEkqp/UD8uwtSyl1/CnNN8i8gw/xiZ4R89H069PR4Fy70l/8Uk=
X-Received: by 2002:a25:bf8f:: with SMTP id l15mr15062085ybk.670.1639682603551;
 Thu, 16 Dec 2021 11:23:23 -0800 (PST)
MIME-Version: 1.0
References: <20211216092651.18878-1-yajun.deng@linux.dev>
In-Reply-To: <20211216092651.18878-1-yajun.deng@linux.dev>
From:   Song Liu <song@kernel.org>
Date:   Thu, 16 Dec 2021 11:23:12 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5+sb7S14zaSJQ8FwgGL0F2O_RSuBMXgq_VE68Rnsow4w@mail.gmail.com>
Message-ID: <CAPhsuW5+sb7S14zaSJQ8FwgGL0F2O_RSuBMXgq_VE68Rnsow4w@mail.gmail.com>
Subject: Re: [PATCH v2] lib/raid6: Reduce high latency by using migrate
 instead of preempt
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>, williams@redhat.com,
        masahiroy@kernel.org, open list <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 1:27 AM Yajun Deng <yajun.deng@linux.dev> wrote:
>
> We found an abnormally high latency when executing modprobe raid6_pq, the
> latency is greater than 1.2s when CONFIG_PREEMPT_VOLUNTARY=y, greater than
> 67ms when CONFIG_PREEMPT=y, and greater than 16ms when CONFIG_PREEMPT_RT=y.
>
> This is caused by ksoftirqd fail to scheduled due to disable preemption,
> this time is too long and unreasonable.
>
> Reduce high latency by using migrate_disabl()/emigrate_enable() instead of
> preempt_disable()/preempt_enable().
>
> How to reproduce:
>  - Install cyclictest
>      sudo apt install rt-tests
>  - Run cyclictest example in one terminal
>      sudo cyclictest -S -p 95 -d 0 -i 1000 -D 24h -m
>  - Modprobe raid6_pq in another terminal
>       sudo modprobe raid6_pq
>
> This patch beneficial for CONFIG_PREEMPT=y and CONFIG_PREEMPT_RT=y, but
> no effect for CONFIG_PREEMPT_VOLUNTARY=y.
>
> Fixes: fe5cbc6e06c7 ("md/raid6 algorithms: delta syndrome functions")
> Fixes: cc4589ebfae6 ("Rename raid6 files now they're in a 'raid6' directory.")
> Link: https://lore.kernel.org/linux-raid/b06c5e3ef3413f12a2c2b2a241005af9@linux.dev/T/#t
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>

Updated the patch and CC'ed stable. It should make to LTS kernels.

Thanks,
Song
