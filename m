Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 856644718FC
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 08:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbhLLHFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 02:05:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbhLLHFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 02:05:07 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC53C061714
        for <linux-kernel@vger.kernel.org>; Sat, 11 Dec 2021 23:05:07 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id l7so19451139lja.2
        for <linux-kernel@vger.kernel.org>; Sat, 11 Dec 2021 23:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=6LU/tly/OnmzSqVoqxRgCanCx1K/OauRFfDCzPG0MrI=;
        b=QuJbf7XOx9o58FqDkSxA3xaFsMj7fF96cCL6OfsKL9mCsDoMPLIAlVqxzypdv8k0Lr
         6H+oaPg8DZOTC75EjoBI1aF3CZFtrkkItwst+rzKdDLe2x8sgyoZUIAV8ofWPbE0qxrL
         URsQQ4yiK2g6avCwp5LqjTinWFYBvaYn5bq/1MJYdPilwL/jgxhVk2XnGfVmp2UItqdl
         MV3qeyHaHtYvv2DerSzkfmgcTDclqUtFWmYFGtkt7WPslP9o6PSd/X8fbpzYqxHu6hBC
         cHyDljCC4Zqv78dA8I9m9JNCBeuEGh5SLNTUOExsO8uvAGnp8MAWT3thRb8msgkswnDT
         gx5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=6LU/tly/OnmzSqVoqxRgCanCx1K/OauRFfDCzPG0MrI=;
        b=Ei5Z5JMlje/y7VrL+QA1hineOeZblgZPt4kqDtcch6w/vqlM0gq2ePlg7R7rCeH1/l
         wAF3bdSwG7D/OGJzNBT/cYk15JzrLctRG3COwl+8AWnEzd5c5dK8FDS4bwr+y1e2u9g0
         VWs7gRtGEjv8paO4A0qwt0lQZN0vxIUvmUpG/uQfwOznuy8jd6zjP7SeSIwbKMLmtb9U
         /DCp9bScTAzERILxCGa1jUw80n6m4ZQu8tWLUIB5cDPGuht58xehU+Zsn2iGwFjoHrQk
         qzaU6LRcG9maejiV53oifs9p6598IsNBo2Ec5CifTJE2R42EwUts20wdoFgU/oVFGX9w
         szLg==
X-Gm-Message-State: AOAM5307+m3ZQ6sGWV+k6A8psiuBlURevrRW6uVNSeyrHgKpIizSP8I5
        p2PomFLUYijDWpDs3MgQdhYdI7nzfqezwKKyE3c=
X-Google-Smtp-Source: ABdhPJxCr3b2+y420uyprVImekYlRzuPpiy7L7llL80HTibem20C0vxIbebcd8SdQPGIgkDsL/l1BBB3iHJfpVdHuKs=
X-Received: by 2002:a2e:995a:: with SMTP id r26mr22470527ljj.378.1639292705600;
 Sat, 11 Dec 2021 23:05:05 -0800 (PST)
MIME-Version: 1.0
From:   Muni Sekhar <munisekharrms@gmail.com>
Date:   Sun, 12 Dec 2021 12:34:54 +0530
Message-ID: <CAHhAz+iKepmJGRKzLe+B_XFOax4CzVzeeAB_T5YtZrPgeX8o6g@mail.gmail.com>
Subject: X86 : system call
To:     kernelnewbies <kernelnewbies@kernelnewbies.org>,
        tglx@linutronix.de, Ingo Molnar <mingo@redhat.com>, hpa@zytor.com,
        x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

32-bit system call numbers and entry vectors are defined in the format
"<number> <abi> <name> <entry point> <compat entry point>". What is
the difference between <entry point> and <compat entry point>?

The abi is always "i386" for arch/x86/entry/syscalls/syscall_32.tbl,
whereas for 64-bit(arch/x86/entry/syscalls/syscall_64.tbl) it is used
as "common" and "64", "x32". What is the difference between "common"
and "64", "x32"?

While adding a new system call(for example: mlock) to kernel,
/kernel/sys_ni.c file modified as mentioned below:
+cond_syscall(sys_mlock2);

Why do we pass <entry point> to cond_syscall()?

Also, could someone please point me to a document which explains about
"how to add a new system call" and the "system call flow from user
space to kernel space" in X86 ARCHITECTURE (32-BIT AND 64-BIT).


-- 
Thanks,
Sekhar
