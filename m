Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24BE8474B9E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 20:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237343AbhLNTLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 14:11:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbhLNTLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 14:11:37 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB71EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 11:11:37 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id t19so28529281oij.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 11:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9lcMaL71azwy/gh8eaJYAGrYAxsoa/MJIiNMV7gvXWg=;
        b=NpT9S1paC+ds2Y2/UNFd3Hgq+csOrGK5MIUWqLVImmw9YpW7sSdH5yooc/8n71ytlV
         UiZoMLuMdpvHq5DhvGrR19ea9cbQzCqNKH8Ap2IJbJ5eqt02W1SUltgZFI49Zt2vx10D
         8W9ekUPA+MfhXapGwhzBtu6TnHl6FIdaXPQfHh/2P1FHMIfk93NhzZK3RKI0ROWSBiHr
         6wEC03A39BLTR2Mj88M0a81eyzEYw422p/1coF6+glnEhKnsUCnEIunQ0juvWh4mqeXU
         cjbxBDu5rjoIGtzkZve2kUs9qadHM5oueD+E23l8a8ZGyzqXV8IBDpt9VmgvgOTb544T
         UNhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9lcMaL71azwy/gh8eaJYAGrYAxsoa/MJIiNMV7gvXWg=;
        b=hFYPVMjeDpBl96Ifrf+2cFTBz2uEAOW4sFSADlgL3lPBJwZ/TyJtwxvKD4NVll12N7
         v7fuhWZoGRD1ZMS2H16msD218nKZDI9GOulRGxeciRuaN1154p1vOHUJPHmjAsy+CA/I
         uQg5ZPqJEc+DC0p2fSm5N6sES8EOIM77Y69rdxWuX2L55O9bGYKAEJo4oxmuVcKTu+iw
         Yp3VBoSLhdxq6TRd0mjcbvxLGFxiin7dKsDjdNfsw9XLuG1UsSP/PNIUXmCSnG2d+ein
         Doe/p64bp6wEtfDjjTSfsgeyrWBaV8pRTlEwEFLCKg9X+AhhyKKVGwkkQfK3T4XEyIrf
         t83Q==
X-Gm-Message-State: AOAM531DMhKbGrjlro22stysZ7qh4jU3ln9Ner5E6NVkLlVm8QHdtdnB
        e2PbNJUPgRJ1yGq7Co7Q8Yryeid5OM1jeKrKmBf7bw==
X-Google-Smtp-Source: ABdhPJyUyVqVnO18ScUmqo58JFcpGFMqCZNO1Z+dd3I9NuhM3/iV0ciz/FRq712bCn/IG8cTLWkcHNB5yx85UKKjQYY=
X-Received: by 2002:a05:6808:118c:: with SMTP id j12mr5908484oil.65.1639509096871;
 Tue, 14 Dec 2021 11:11:36 -0800 (PST)
MIME-Version: 1.0
References: <20211211131734.126874-1-wangkefeng.wang@huawei.com> <YbjhUaEP4Sqk7qRP@FVFF77S0Q05N>
In-Reply-To: <YbjhUaEP4Sqk7qRP@FVFF77S0Q05N>
From:   Marco Elver <elver@google.com>
Date:   Tue, 14 Dec 2021 20:11:24 +0100
Message-ID: <CANpmjNP_M2R9XD8GnCJVTmN17GPOR_5Y3jX8r5AAKcaDRUWJ4A@mail.gmail.com>
Subject: Re: [PATCH v4] arm64: Enable KCSAN
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Joey Gouly <joey.gouly@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Dec 2021 at 19:24, Mark Rutland <mark.rutland@arm.com> wrote:
[...]
>
>   Reviewed-by: Mark Rutland <mark.rutland@arm.com>
>   Tested-by: Mark Rutland <mark.rutland@arm.com>

Thanks for taking a look and testing! Thought I'd update you re status
of some of the reports below. :-)

[...]
> * BUG: KCSAN: data-race in mutex_spin_on_owner+0xcc/0x150
> * BUG: KCSAN: data-race in rwsem_spin_on_owner+0xa8/0x13c

These are going away, fixes are already in -tip/-next.

> * UBSAN: object-size-mismatch in net/unix/af_unix.c:977:14

The UBSAN object-size-mismatch warnings are going away, as
fsanitize=object-size is broken/incomplete as it turns out --
UBSAN_OBJECT_SIZE will be removed from 5.17:
https://bugzilla.kernel.org/show_bug.cgi?id=214861#c4
... because all its warnings can also be covered by -Warray-bounds,
which Kees is working on enabling.

Thanks,
-- Marco
