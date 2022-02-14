Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00134B5D55
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 22:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbiBNVzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 16:55:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiBNVzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 16:55:18 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7891AC004
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 13:55:09 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id j26so18174148wrb.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 13:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nbiLttF2koEHdia0Muc3aXcTveQFaK2OVXM8QEZv9wo=;
        b=malCESbecL6V85D3giKBvxwwWOI+KaZPF6O7OM8b5yufxhNJGykHOMJfy5/UGAhSCm
         KVP50/UdmtI4cB0gAHDphFAffYRhvYdqWnCfM9antJnI/Q8ocr+JGY55HHO4njdmjuFu
         ZfQZ6Abfu9l8cT6Kgdr6z+D2Qa6TdSrH4HAxZScU8PqMQJ6QjiENG3xl2k8wrEOP1Eo1
         L517rgZ0ZXacZwmWcdHrqOmjBSS/ffeBJV9+0iMWVMw8Hpuvi4iJZ5+yCAtpuSPX1AFQ
         9OsE80QCDOQM1PtcRwwZlYSC/Kj6lMZBjPEeG7yi14MggSHY1+QKkLqsaW7kwCZEiqvx
         nTbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nbiLttF2koEHdia0Muc3aXcTveQFaK2OVXM8QEZv9wo=;
        b=lLza5IIQCLqYME1fBvwXggWF6keq3af/JODDl53s3G7qiR0I9bsdrn2tdpCedXj/Xi
         5Rr4hvtcLS7u7QLD0EPI1Roh8zQokVg0fD5rLKSeWd9WcURrbmn1RjMeM6mhiobnhByy
         xKcOuVJZD+pbxN46Ws/lZtjFNSVtO5iqYQOPC+4T5iIOjxpV7lk2MgOE7p2syYHARCtF
         m2wFpKQyp1nifjx/4+somN37rX268NCuuY+vU7oOBXNX7yj8LyENZGdtL4Lo2/V7uZrC
         VdyALHHO3OoiCTt7qe8VO3jqTpyKQlawogZs81nB75gXlCCFiee6HyRVQt2Cz5rNOvu5
         ogiA==
X-Gm-Message-State: AOAM533BqFWzabJniUVoUjaxzCgKR27v/PwAZEWunPsbDr6O4TAdAp/C
        MX0p0+tkVF8m32ukl6htHVnY8EXudDF1IKiWngiryw==
X-Google-Smtp-Source: ABdhPJyvhIo3T8N6fTgUd1M/pEkvV0YDsl5jhb1hpiKI+wuP6iow4AQoZiQ9Dn/Yc3hyI5SNCUaLjj29aeruRas9n5A=
X-Received: by 2002:a05:6000:184e:: with SMTP id c14mr751860wri.577.1644875708093;
 Mon, 14 Feb 2022 13:55:08 -0800 (PST)
MIME-Version: 1.0
References: <20220210224220.4076151-1-kaleshsingh@google.com> <87mtit4qw5.wl-maz@kernel.org>
In-Reply-To: <87mtit4qw5.wl-maz@kernel.org>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Mon, 14 Feb 2022 13:54:57 -0800
Message-ID: <CAC_TJvfgXSW9tQDHZ_1i31oBLKtGH6ymEDmoSemTa2ATwYkVMg@mail.gmail.com>
Subject: Re: [PATCH 0/7] KVM: arm64: Hypervisor stack enhancements
To:     Marc Zyngier <maz@kernel.org>
Cc:     Will Deacon <will@kernel.org>, Quentin Perret <qperret@google.com>,
        Fuad Tabba <tabba@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Andrew Walbran <qwandor@google.com>,
        Andrew Scull <ascull@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, kvmarm@lists.cs.columbia.edu
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

On Mon, Feb 14, 2022 at 3:41 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On Thu, 10 Feb 2022 22:41:41 +0000,
> Kalesh Singh <kaleshsingh@google.com> wrote:
> >
> > This series is based on v5.17-rc3 and adds the following stack features to
> > the KVM nVHE hypervisor:
> >
> > == Hyp Stack Guard Pages ==
> >
> > Based on the technique used by arm64 VMAP_STACK to detect overflow.
> > i.e. the stack is aligned to twice its size which ensure that the
> > 'stack shift' bit of any valid SP is 0. The 'stack shift' bit can be
> > tested in the exception entry to detect overflow without corrupting GPRs.
>
> Having quickly parsed the code, this seems to only be effective for
> pKVM and the EL2-allocated stack. Is there any technical reason not to
> implement this for the much more common case of 'classic' KVM in nVHE
> mode?

Hi Marc,

No technical reason. We hadn't thought of it from that perspective.
It's a good idea, I'll look into this and repost  a new version.

Thanks,
Kalesh

>
> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
