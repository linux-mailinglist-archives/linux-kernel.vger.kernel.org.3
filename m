Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A5A4A8A31
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 18:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352891AbiBCReF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 12:34:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240552AbiBCReD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 12:34:03 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9375FC061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 09:34:02 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id m14so6386426wrg.12
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 09:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c53te4gb4gbQ2BA9zEe7ibUShf/XoqZxMo0RjmKCsS4=;
        b=PR/a8+x78qbvbyaHDAU3p5hE/7/RoI+gQzvv1o2U09FLV+kWLGCNNZ2fVy4y4j+qnX
         Q+y8lLK3rZxA3bMRX+y/XjfwazG4/ulNOMg/rZqoNRJV2UAfn7K1skGS4YVhXrIaBUdJ
         zaCBmsbQARI910hgblR2GJkNV6y/yimrKnjp+pAZuzkXx9J9JsF15eFxGjzIHvSJ5k4G
         WZ9U2Hhtvz7mgodvtg1ir5vdp7jt7pinWUDqN+RpCiaKCwMSVjqIBYLUKXK4r+KXKoFB
         8enYxo0LoQr+p3anbqvtABuh9EydkrwzM/lB6fuwd326H3xgiaKnTfomOAdYrUI6OK5q
         jaAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c53te4gb4gbQ2BA9zEe7ibUShf/XoqZxMo0RjmKCsS4=;
        b=oor8LXIhf4eZQqHte1i9max34iCiSyJwU0vlArNkcUyML2RmLkhETetLp5pUT0Zhc2
         zR4Fh/jzsbifDXzzUiUpiWRe9sKhTKc6A0amEXhtJCFKUV3zA65vqYfhDDlxdnedo9N5
         YYT/yTL/GkMmJ7rE1XFJtrDxaKgAlNlkafTLxotzZIP42/qz5blR2J+9KhPQDf04YBQr
         U2U+UPIN1BXoL7m/GuYk8Kj5PYpQkVNn86EaprirLqnnh38o6D5CIbrFM7gx6+Ii2v8A
         H7anc313lUD/mySKPboYx+l6Db52ZC1SHePgEk+rZKSTn2RsLSSHzm7nx9mw/444Ir+H
         Yaaw==
X-Gm-Message-State: AOAM531+rN/GC5gjcIanFVh1mP6YBjsvJhQA1Wm3uH0yE5mteNZtngq9
        v0VHFgy522mGk295ErvE0XGtUFKYrc+IhP6vuU5h2Q==
X-Google-Smtp-Source: ABdhPJwGA56QJvpioobn/jD2H7dobA3RBTnANrtOSRHF6t4f20TsPoSgNhxAwWkp2B5F9XVj9iHWYdx5ogNKVw2WGhk=
X-Received: by 2002:a5d:550f:: with SMTP id b15mr19836625wrv.384.1643909641056;
 Thu, 03 Feb 2022 09:34:01 -0800 (PST)
MIME-Version: 1.0
References: <20220117085307.93030-1-likexu@tencent.com> <20220117085307.93030-3-likexu@tencent.com>
 <20220202144308.GB20638@worktop.programming.kicks-ass.net> <CALMp9eRBOmwz=mspp0m5Q093K3rMUeAsF3vEL39MGV5Br9wEQQ@mail.gmail.com>
In-Reply-To: <CALMp9eRBOmwz=mspp0m5Q093K3rMUeAsF3vEL39MGV5Br9wEQQ@mail.gmail.com>
From:   David Dunn <daviddunn@google.com>
Date:   Thu, 3 Feb 2022 09:33:49 -0800
Message-ID: <CABOYuvZJrBkcr5MCosVtq0+om5=kwcXWcFRNGxDyX_JPwpKubw@mail.gmail.com>
Subject: Re: [PATCH kvm/queue v2 2/3] perf: x86/core: Add interface to query
 perfmon_event_map[] directly
To:     Jim Mattson <jmattson@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Like Xu <like.xu.linux@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Like Xu <likexu@tencent.com>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jim,

I agree.

It seems inevitable that the demands on the vPMU will continue to
grow.  On the current path, we will keep adding complexity to perf
until it essentially has a raw MSR interface used by KVM.

Your proposal gives a clean separation where KVM notifies perf when
the PMC will stop counting.  That handles both vPMU and TDX.  And it
allows KVM to provide the full expressiveness to guests.

Dave Dunn

On Wed, Feb 2, 2022 at 2:35 PM Jim Mattson <jmattson@google.com> wrote:

> Given what's coming with TDX, I wonder if we should just bite the
> bullet and cede the PMU to the guest while it's running, even for
> non-TDX guests. That would solve (1) and (2) as well.
