Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6CB349A112
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 00:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1849750AbiAXX0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 18:26:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1835942AbiAXWhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 17:37:50 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027F8C0D9433
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 12:59:58 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id o30-20020a05600c511e00b0034f4c3186f4so203691wms.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 12:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=LelPLFVyiMTpw5yA1vIPFMWw4VOWdiJSPS8F5u+bLEc=;
        b=qRZb3pM+5b2VNWc/AzABp2OqhydpmI2RSTdUgZsB+pKt3vGNMqDrBgXP/MKGbxYyHg
         wWnY5BfxqqcbIUq6wPMF9Wrl3cFRKva373rvxCvgG/CE3dvo9GQkBwHGCDK8CsN8vWpD
         7ThNJfRa6Vr+Tbjs2BXWAheDIeoqp5RiCRk8u1cD2qULgAiilowza9Apg/0qECxnejBa
         Fad6dKu/8fVBAYJjbuNnYB1rOP9vDJdi1naj3nqGx/sHOem74ASUXGbfnLBjY2QkTYNc
         WTA2kK8IEaUhDo+ifHdp9FaYSgg8bYW1d5pV0BY6wa5HAyUByZbm4iPldXhv8wz416yY
         ASyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=LelPLFVyiMTpw5yA1vIPFMWw4VOWdiJSPS8F5u+bLEc=;
        b=s8pnbCkmJTmIDl10x6S11XwTzn07EJDDch4+1tYbmJR0CEmd5qImFB+4r+j4A1Hfny
         xZvRrm+Fc+ADC4jsYzi63M+bZ68hspWIHcc8JAz1KGz1uagXRNmrBXcRd/Y6Ke0GRGsE
         f2nYi1mVDS/FHxnvhRsw47dXHE/waFGn6My+keDBcoJ+ZlLn4+lSpmXekipOHiN8qyuo
         HhEyh2nz4HBBMkLlz7vNkl0XdE3mUR59fLtBnX0ZjUfmbm4vJpv8x8yqAtL3cDK4gTo7
         yxorD5NbA//x39L/EI/oU3x6atRrffXVSSRvM1Ii/vnhxaXc58t7vBeZsFsm/iqAHBXk
         h1jg==
X-Gm-Message-State: AOAM532ODqQmmkSHMNg9/CQbGSimrQ/iYJClIFF/zP3WarywNUNp0pCU
        AZ63nbwXh0VWUhQbDxd0CuuBj0krwnRw9BzPftQ0lA==
X-Google-Smtp-Source: ABdhPJzQ2EdezBI/cadxJvyRuRdpwrqFMtyGwYYsP71DbnBy25EekbaOkxmdTf3MKawF+mMAoyzlm2azpJ+IBoCSdG0=
X-Received: by 2002:a05:600c:3503:: with SMTP id h3mr110888wmq.164.1643057996298;
 Mon, 24 Jan 2022 12:59:56 -0800 (PST)
MIME-Version: 1.0
From:   Hao Luo <haoluo@google.com>
Date:   Mon, 24 Jan 2022 12:59:44 -0800
Message-ID: <CA+khW7gh=vO8m-_SVnwWwj7kv+EDeUPcuWFqebf2Zmi9T_oEAQ@mail.gmail.com>
Subject: [Question] How to reliably get BuildIDs from bpf prog
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Martin KaFai Lau <kafai@fb.com>,
        KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Blake Jones <blakejones@google.com>,
        Alexey Alexandrov <aalexand@google.com>,
        Namhyung Kim <namhyung@google.com>,
        Ian Rogers <irogers@google.com>,
        "pasha.tatashin@soleen.com" <pasha.tatashin@soleen.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear BPF experts,

I'm working on collecting some kernel performance data using BPF
tracing prog. Our performance profiling team wants to associate the
data with user stack information. One of the requirements is to
reliably get BuildIDs from bpf_get_stackid() and other similar helpers
[1].

As part of an early investigation, we found that there are a couple
issues that make bpf_get_stackid() much less reliable than we'd like
for our use:

1. The first page of many binaries (which contains the ELF headers and
thus the BuildID that we need) is often not in memory. The failure of
find_get_page() (called from build_id_parse()) is higher than we would
want.

2. When anonymous huge pages are used to hold some regions of process
text, build_id_parse() also fails to get a BuildID because
vma->vm_file is NULL.

These two issues are critical blockers for us to use BPF in
production. Can we do better? What do other users do to reliably get
build ids?

Thanks very much,
Hao

[1] https://man7.org/linux/man-pages/man7/bpf-helpers.7.html
