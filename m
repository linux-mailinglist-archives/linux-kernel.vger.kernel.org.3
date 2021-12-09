Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A79546E161
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 04:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbhLIECH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 23:02:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbhLIECG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 23:02:06 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20EB4C061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 19:58:34 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id w6-20020a9d77c6000000b0055e804fa524so4939325otl.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 19:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8tvXiGUbonTXMLd7dwLCyjDtviUh4aDdQ3AlcH92si4=;
        b=I1kNb7JDf7LNF19H8Slw117YdE1jT76nPqL8JsPtk0+48YngcRGIb2+OUBIMtmHZiS
         gbg1qLH/jHFdKd/F9/vAwvFRDhRSTwhF/QrX6wkVT4+hm8jqRcRsBXEx5ofzfasjVknI
         VVNKoNfznkKsFX9DGTgNG4Uw+fjjGN18ig4BsP1yBbqbFQYUzQmGTK+L5rKIiDmSJTXf
         fYdzDtjCjN8Gsr19tLIYajTBzuCUjukwAtJ7T6URXdKUO7NugL66zDq0zkrVg57FK5sg
         kNA1bmRMcit1KCOvtMJVxJdbf2Z21KTa5mxwKY3swRKW5E9ACTlRSV7IvAP+ZpMAOLZ/
         8MMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8tvXiGUbonTXMLd7dwLCyjDtviUh4aDdQ3AlcH92si4=;
        b=g3Pq32U+VEWMqMgpPIyYafr/mALjSjCZNfz/YoSm0qq05ZxkS3e4TSURToOUovHFvy
         T/xqBvhU8Nba+nVIkZl+FC4Z48bHAs3XpO862Ly/h+CpoHyNqbursZiLrZHui8FPtQRv
         p/9frx9gYhq9yc5AWmKgrkWxeUCl0Ve/p5F7J2k/skyoBHulanKUc1HbUuZSMocDMpzI
         bFB/tsH0ha7dBredOK6b9l6DzytTfSqfS/NTOhj+ZJVhR7UaE6Eg4RA6JREsCpkNHbUc
         F3rjHJ5mm9EhtNYJUWp9aVGYMYIIbmaXp/6m1WwobwCGOGlv3mpBPNRjGhxl5SzVNnOs
         sLuQ==
X-Gm-Message-State: AOAM532Id0OpX/xfxz1pvw13RTvTUJscka9QLSnqzlGeVmYSHG1VMJ9+
        vmdWmmySIZd4rIkHYniJ0JEqJAxGtTSPC4tK+lQ3hg==
X-Google-Smtp-Source: ABdhPJyISiApG0v0Ke96ie/0bS7BeobChDq85K6P8OxK2EgJdyFXuC/VvNVhccR8pis6EuNRIwkHRuJib9TVYa97McU=
X-Received: by 2002:a05:6830:1417:: with SMTP id v23mr3319180otp.367.1639022313128;
 Wed, 08 Dec 2021 19:58:33 -0800 (PST)
MIME-Version: 1.0
References: <20211130074221.93635-1-likexu@tencent.com> <20211130074221.93635-4-likexu@tencent.com>
In-Reply-To: <20211130074221.93635-4-likexu@tencent.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 8 Dec 2021 19:58:22 -0800
Message-ID: <CALMp9eSwZ69nZF2q4Xki_X25-8yBc1y_7iXRdPh6F89j8rym2w@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] KVM: x86/pmu: Reuse pmc_perf_hw_id() and drop find_fixed_event()
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Like Xu <likexu@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2021 at 11:42 PM Like Xu <like.xu.linux@gmail.com> wrote:
>
> From: Like Xu <likexu@tencent.com>
>
> Since we set the same semantic event value for the fixed counter in
> pmc->eventsel, returning the perf_hw_id for the fixed counter via
> find_fixed_event() can be painlessly replaced by pmc_perf_hw_id()
> with the help of pmc_is_fixed() check.
>
> Signed-off-by: Like Xu <likexu@tencent.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
