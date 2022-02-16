Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 392F74B8894
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 14:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233718AbiBPNN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 08:13:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233551AbiBPNN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 08:13:27 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DC026A2D2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 05:13:14 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id x5so3802203edd.11
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 05:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=C2p4IUdETvsJDn4La4k2PCI07l5Bxa5zsybCeAbirFE=;
        b=cgTmNT+lR7bIEtc+0RAP+11VPLYqnh/5AYxJB7yMRpBjQ4E7jT1GDIbYfOvueK0OGj
         ezlXhWvCIyOfOIoK9wPgSJW5Qvz/Tq6u5h2BHhHxA3/M9FjYgCtvpraidt0TcJvapxBP
         PSGEHjx8CPFzhxjV/xFtu0YKK3FRIyafADQKj33KP8ehSq3QyLbQ80nv3lfGkGZy9f/e
         8kQ7cTK1XsTlQXalf/x5+5L17ozGIHBzyLvlGsemDJy2T8DzllilABCyKj6Q53kFjDb3
         RQSuQSmRXKPAT2IGMBr2NO6prlzGpfdzqmcWk3/hpqV03GHQ07FnrM1zwgr+L9AvVUxb
         x2+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C2p4IUdETvsJDn4La4k2PCI07l5Bxa5zsybCeAbirFE=;
        b=QSCxPikc5qYf0MQDzQrffwlg+WSuMiUBp6IxSDS4Tyf+aHBsXbQcTrOflpjwyiKDC/
         SVTCHP5K3B8rn7oK5oprxDm7Nx8hqEDF57TEjrQgCYbQg58jNLTqAOjr3nTQnD7zhW5y
         xTzSWbtSzB3bq1ZclR0APeqFcwP/dF4GS4d6JP7CUTo89a7d82mhv/lsj8D4ht2usyZ5
         I/IrgnufHEkMUDh5tzDMGdXzCwBKZv/VIgy7oDfkxM44JU9JjyhU/Ni96n3pUUs1r5dd
         QSkD4YwaqMofknZ66D4RgJ3R/kRhCrpcbjjWU2UoJK/MJrV5AmZ0a82NqJRBKYkhCdeM
         XDGw==
X-Gm-Message-State: AOAM532Nql+rJRyPO0n2gmZoNn/+23e64XXVFb6z1hbYoZnc/3ne/4pr
        rYoZzXvlCr3o4sL4pmsUfPRgUA==
X-Google-Smtp-Source: ABdhPJytGpaXpnUA2XqnoVWtsq4DkTHuirdUMy5k13A5Kf2GGU7VKMXxrZ1WP9LXlvA/21mEfeqgSA==
X-Received: by 2002:a05:6402:742:b0:410:a427:3634 with SMTP id p2-20020a056402074200b00410a4273634mr2941621edy.304.1645017193316;
        Wed, 16 Feb 2022 05:13:13 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([104.245.96.223])
        by smtp.gmail.com with ESMTPSA id h5sm4817787ejo.124.2022.02.16.05.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 05:13:12 -0800 (PST)
Date:   Wed, 16 Feb 2022 21:13:06 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     John Garry <john.garry@huawei.com>, Will Deacon <will@kernel.org>,
        Marco Elver <elver@google.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, svens@linux.ibm.com, gor@linux.ibm.com,
        sumanthk@linux.ibm.com, hca@linux.ibm.com,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: Test 73 Sig_trap fails on arm64 (was Re: [PATCH] perf test: Test
 73 Sig_trap fails on s390)
Message-ID: <20220216131306.GA56419@leoy-ThinkPad-X240s>
References: <CANpmjNNMWtjcKa961SjEvRbbPXyw5M5SkrXbb3tnyL3_XyniCw@mail.gmail.com>
 <90efb5a9-612a-919e-cf2f-c528692d61e2@huawei.com>
 <20220118091827.GA98966@leoy-ThinkPad-X240s>
 <CANpmjNMPoU+1b1fKFuYDYwisW2YfjQHxGt5hgLp1tioG7C2jmg@mail.gmail.com>
 <20220118124343.GC98966@leoy-ThinkPad-X240s>
 <bfa0af18-04ac-857d-d3d8-ad9290f912c8@huawei.com>
 <06412caf-42e4-5c4b-c9b3-9691075405bd@huawei.com>
 <20220215143459.GB7592@willie-the-truck>
 <8c582e45-0954-a2ea-764a-4dd78a464988@huawei.com>
 <CACT4Y+Z8pKXw=8nwVtdo2W=hu_rBk1ws-Q=7-tBkLGTcD85NaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+Z8pKXw=8nwVtdo2W=hu_rBk1ws-Q=7-tBkLGTcD85NaA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 12:54:16PM +0100, Dmitry Vyukov wrote:
> On Wed, 16 Feb 2022 at 12:47, John Garry <john.garry@huawei.com> wrote:

[...]

> > > Signals make this messy, as the step logic will step_into_  the signal
> > > handler -- we have to do this, otherwise we would miss break/watchpoints
> > > triggered by the signal handler if we had disabled them for the step.
> > > However, it means that when we return back from the signal handler we will
> > > run back into the break/watchpoint which we initially stepped over. When
> > > perf uses SIGTRAP to notify userspace that we hit a break/watchpoint,
> > > then we'll get stuck because we'll step into the handler every time.
> > >
> > > Hopefully that clears things up a bit. Ideally, the kernel wouldn't
> > > pretend to handle this stepping at all for arm64 as it adds a bunch of
> > > complexity, overhead to our context-switch and I don't think the current
> > > behaviour is particularly useful.
> > >
> >
> > Right, so what I am hearing altogether is that for now we should just
> > skip this test.
> >
> > And since the kernel does not seem to advertise this capability we need
> > to disable for specific architectures.
> 
> It does and fwiw I am just trying to use it. Things work only on x86 so far.

So here we have agreement to disable the cases for Arm64/Arm.

John, since you put much efforts to follow up the issue, I'd like to
leave decision to you if you want to proceed for patches?  Otherwise,
I will send patches to disable cases in perf.

Thanks,
Leo
