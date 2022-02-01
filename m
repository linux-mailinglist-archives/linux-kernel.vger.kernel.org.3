Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7EEE4A6357
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 19:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241903AbiBASPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 13:15:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241851AbiBASNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 13:13:17 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CD8C06173E;
        Tue,  1 Feb 2022 10:13:17 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id my12-20020a17090b4c8c00b001b528ba1cd7so3369771pjb.1;
        Tue, 01 Feb 2022 10:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2/U58rvQAs/QwkU2l3I276W7JRQbFublV13vTPJozZ0=;
        b=oNYwzc4jelzove4NuL1AK76Nno/Gl7qqIumKDknNJtg+TkynYjIiBjHrYqXPYVp8J6
         3BqjmFLOQIwjt9bduahoqDtHyrJYv4jqwIvRBXpF1DGsX64qW9K37ej6OmwIS0CDAoKc
         q01V4ZlOUtia4yFQ8EgP+cwLlIvh362MI0C4XpkmxnsHtgCVl184/m9MUKwi0gtxmge0
         +ZHMdhgEhjEswhEWohiSMYfOOJnhiXoKXXY2BMoIGTrgh13w1LaICo2Q0NGh3Vp7MtrW
         1xI9j4FJuHELs4dS+JFqP/QRId7K93gynswLwCFFh+oEb5Ws/9yds16s/qXWN5ZRyZEo
         4B8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=2/U58rvQAs/QwkU2l3I276W7JRQbFublV13vTPJozZ0=;
        b=mSyvu76uUBlhnXDASSg4ufVqzxd8l3zUZaqwu+RP/3zvrzFFNn116FrzaWWavN3XaN
         gW6jUovmlDcZcYNezZSx+CuspGjSVWVTlNVIDjx8kh/UacyFG584lYmHsoJD7ts+0kHf
         DeH5QmcTDMuA6psRHcko+k178KmGZmW39pfMXx8/yJ3JsZB4f244P+XYPh1o9PRmioYP
         avWgNumm6bRN4bznC6ihUX0e1Tj34m8dDmRhJq6Gn0BFOTDwTGDfq1gAsH/zzr4OhGAj
         1DqjH9Yg8/adYwiCYc2NLU7QxL/gbATd/A+pfPjjPUFwgNmArgW/ykR/5Suw0p3pqnT7
         w70Q==
X-Gm-Message-State: AOAM532Fs8DUvs34HXFRnHK/3SDNBKYIrUVBFT+2D3qR2zQZDPSV66aQ
        u5EkcV75FwdPqdgY1ii5sMwAsYVwR0U=
X-Google-Smtp-Source: ABdhPJwhdWbFCq/8bYQw+kyvytfpvWaaw6zjZQi0j13S4WBZsnHKrU003F3HAixus3BehQg0f9Zm2Q==
X-Received: by 2002:a17:90b:4109:: with SMTP id io9mr3724619pjb.244.1643739196656;
        Tue, 01 Feb 2022 10:13:16 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id ms14sm3405230pjb.15.2022.02.01.10.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 10:13:16 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 1 Feb 2022 08:13:14 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Igor Pylypiv <ipylypiv@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Changyuan Lyu <changyuanl@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] Revert "module, async: async_synchronize_full() on
 module init iff async is used"
Message-ID: <Yfl4Othg/8VWpd3u@slm.duckdns.org>
References: <20220127233953.2185045-1-ipylypiv@google.com>
 <CAHk-=whM5sHbOboEnPSfBZPQrLB-KCtzE+JXFxFRNgT95i37bw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whM5sHbOboEnPSfBZPQrLB-KCtzE+JXFxFRNgT95i37bw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Jan 28, 2022 at 09:39:12AM +0200, Linus Torvalds wrote:
> However, we've done this for *so* long that I wonder if there might be
> situations that have ended up depending on the lack of synchronization
> for pure performance reasons.
> 
> If *this* module loading process started the async work, then we'd
> wait for it, but what if there's other async work that was started by
> others? This revert would now make us wait for that async work too,
> and that might be a big deal slowing things down at boot time.
> 
> Looking at it, this is all under the 'module_mutex', so I guess we are
> already single-threaded at least wrt loading other modules, so the
> amount of unrelated async work going on is presumably fairly low and
> that isn't an issue.

Looks like we're multi-threaded while running the mod inits which launch the
async jobs and single-threaded while waiting for them to finish. Greg should
know a lot better than me but according to my hazy memory and cursory code
reading udev is multi-processed when loading modules, which makes it a lot
less likely that this will impact boot time in most cases.

> Anyway, I think this patch is the right thing to do, but just the fact
> that we've avoided that async wait for so long makes me a bit nervous
> about fallout from the revert.
> 
> Comments? Maybe this is a "just apply it, see if somebody screams" situation?

So, yeah, I think the risk is pretty low and even in the unlikely case that
someone is affected, the workaround is pretty straight-forward - not waiting
for the module loading to finish if appropriate.

Thanks.

-- 
tejun
