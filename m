Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3C3348036D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 19:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbhL0Sdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 13:33:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbhL0Sdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 13:33:51 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB71C061401
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 10:33:50 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id j3-20020a056830014300b0058f4f1ef3c2so17641772otp.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 10:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/ZPLneOgWxjVFWk6RqPAOGbtxrpi2B383af81OM9nLo=;
        b=RYzqvVinREjuZKy26MOcu562md6FSDWkNifEyTHSlfRlOSW+YZQWp6ocrJkU+5L6UO
         C3KKFrD6tNRm10043La7q1MPjC1Fh+6OD//554BZQxTuchlP+nztI03TvHhxl71qLXcl
         vMGfTTGZ27q3vZipVQ2WNDcy9R8guMlHSXa7VzGu2HJNyjhgrI1RDBFYFlKhy8ALDwBM
         i9SRI9GAisOAQ9kQMlZM9iK/cOKAhV0jvrPPZEtLo2RRT7N0bnx0xVQCSBpNXICaxZ6H
         fl6MeZMiS51f6GNdwqG00e1NoibDtllKGLB+EXV0DovGY58keI/KuYeYTb+NRYvU15t4
         L5NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/ZPLneOgWxjVFWk6RqPAOGbtxrpi2B383af81OM9nLo=;
        b=Yc6RM62PdHqMqMOM2+Kw+uthO8b9abAZvHT64HUWY1u9R+0QxFavfmQ4OoQ3101GKk
         T5+yvefowyx16xxwIdmDLu/Aetm8BLnorz6g/jkRMVB5nkM4VDa7Bie/oBR2AzX2pmhs
         QAjYQehzZdQPuYrkIh/CG5AgyrgKWt495BYpokCJe2n9ajxQWlkT3if2Yrst0brzR6H+
         Y67AxhPCuojNRYPh+aV2agDhHnJ6n+kU7cZhIXcftPZXkg5/YCcDXDFqXQTR2EBskmgk
         vvf69JQmuwc8uUTyXrDCT58WgyRHenrfUOIK96FPEOH6Uist/6ejX27Ref5PlwgRSjC5
         uNzw==
X-Gm-Message-State: AOAM533syfBT8F0vOLnEnqapNgxHYdnTBwpHJWfbH5XFv35zujeXZ762
        Ya3pFDFJI/9VZ1OthHUlCjCUhvhG5lm/KwaB/F/MuQ==
X-Google-Smtp-Source: ABdhPJy/ONpip27iGSTlu2tXnpVqVrh2Czqg+M0eFyEx+CHyq8coylSbUJjwzVNmOf03K97F2ID1GXvpAYpp0Kxevq8=
X-Received: by 2002:a05:6830:4a9:: with SMTP id l9mr10308821otd.75.1640630029610;
 Mon, 27 Dec 2021 10:33:49 -0800 (PST)
MIME-Version: 1.0
References: <20211222133428.59977-1-likexu@tencent.com>
In-Reply-To: <20211222133428.59977-1-likexu@tencent.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Mon, 27 Dec 2021 10:33:38 -0800
Message-ID: <CALMp9eRNsKMB6onhc-nhW-aMb14gK1PCtQ_CxOoyZ5RvLHfvEQ@mail.gmail.com>
Subject: Re: [PATCH v2] KVM: X86: Emulate APERF/MPERF to report actual vCPU frequency
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Like Xu <likexu@tencent.com>,
        Dongli Cao <caodongli@kingsoft.com>,
        Li RongQing <lirongqing@baidu.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 5:34 AM Like Xu <like.xu.linux@gmail.com> wrote:
>
> From: Like Xu <likexu@tencent.com>
>
> The aperf/mperf are used to report current CPU frequency after 7d5905dc14a.
> But guest kernel always reports a fixed vCPU frequency in the /proc/cpuinfo,
> which may confuse users especially when turbo is enabled on the host or
> when the vCPU has a noisy high power consumption neighbour task.
>
> Most guests such as Linux will only read accesses to AMPERF msrs, where
> we can passthrough registers to the vcpu as the fast-path (a performance win)
> and once any write accesses are trapped, the emulation will be switched to
> slow-path, which emulates guest APERF/MPERF values based on host values.
> In emulation mode, the returned MPERF msr value will be scaled according
> to the TSCRatio value.
>
> As a minimum effort, KVM exposes the AMPERF feature when the host TSC
> has CONSTANT and NONSTOP features, to avoid the need for more code
> to cover various coner cases coming from host power throttling transitions.
>
> The slow path code reveals an opportunity to refactor update_vcpu_amperf()
> and get_host_amperf() to be more flexible and generic, to cover more
> power-related msrs.
>
> Requested-by: Dongli Cao <caodongli@kingsoft.com>
> Requested-by: Li RongQing <lirongqing@baidu.com>
> Signed-off-by: Like Xu <likexu@tencent.com>

I am not sure that it is necessary for kvm to get involved in the
virtualization of APERF and MPERF at all, and I am highly skeptical of
the need for passing through the hardware MSRs to a guest. Due to
concerns over potential side-channel exploits a la Platypus
(https://platypusattack.com/), we are planning to provide only low
fidelity APERF/MPERF virtualization from userspace, using the
userspace MSR exiting mechanism. Of course, we should be able to do
that whether or not this change goes in, but I was wondering if you
could provide some more details regarding your use case(s).
