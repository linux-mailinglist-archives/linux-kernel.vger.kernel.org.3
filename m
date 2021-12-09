Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABE6B46E197
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 05:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbhLIEoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 23:44:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbhLIEoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 23:44:01 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981CEC061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 20:40:28 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id x131so4272851pfc.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 20:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x2ZJmq55zw7iMT2C8aZJP0B/un1vIlG/Zr8TJ6mBokY=;
        b=AldFpIbeuaYnnTYhALwX8NZO9NLCcIazdxyYDkV3zu16+ydBlSAyb99E+5dH30ghpR
         fq2QOBHmBuoIbbWe6JoyKsx1n9PnbpwPoHDSMpxo6i0dLQI0NgHd5yIGD3wUAhGkHOxK
         LRcmHYftWxsGB2zau3ZjC9hWrSGjv0I/SU4CD8Rqw5pNScLaHx7nrnDE0H2a2M48V6N8
         jG3/ekUPWOePjUu3CJSWA7NnAt43lvs0AcvjD38BCsLsQvx+2B4hApM9y6vMiYMkMUY5
         3xOiFn9AJyT2dYCYEHtSlrdif46KMlzUZRBoD6HG85UiVVGIrW4KNES7y4DA4yDCEzZs
         lJ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x2ZJmq55zw7iMT2C8aZJP0B/un1vIlG/Zr8TJ6mBokY=;
        b=lZmt+5xL9+3PGeBvlq7gcqJyuvnlN6ALYYMKLdZZMb7TU7PPQmWUOdxk+NmBg61GJe
         RXMz6mSAXqwpnxTUW3ngY6Dibrm7GyslXdgQeCQBIeoBRnofW9rXyqZVzWed2j+Wbohk
         6XSZmExLjXnpqKvkE6DWbKqCeO2llXbZsb/fyJ/D6YA2IwYwQ2Ln+7nM6VxE05tkuxxM
         lbO/k5Ripnk+FBX4BzgoUP2/Vc2ddujqFCHO2fU9BUC3qKxwHdymRwOSj8JbNEuis++M
         xVPY0dK1HGH9ElWIbETOPVW86XpPYdd9udmZvjALYZtnvwjBbF0tYNMAXkO+Vewfsl9s
         RTkw==
X-Gm-Message-State: AOAM532ld33+0z7oTKMumyWiMyD8uh6xcEbvaDOC/WdsTb8iUepau4LA
        FYkz32U0EiOYvuQFdHq0LCxCupe5N3IugSRl5K0d9Q==
X-Google-Smtp-Source: ABdhPJwdKvRPtHPJEjGq9zSob49lOW19xlZcoHLYxDl98/qvQnZqjFTxFi4RHLqUt1eyiErqfXv/gosJgS5PweTwLHI=
X-Received: by 2002:a63:6a03:: with SMTP id f3mr32741915pgc.618.1639024827705;
 Wed, 08 Dec 2021 20:40:27 -0800 (PST)
MIME-Version: 1.0
References: <20211130074221.93635-1-likexu@tencent.com> <20211130074221.93635-7-likexu@tencent.com>
In-Reply-To: <20211130074221.93635-7-likexu@tencent.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 8 Dec 2021 20:40:16 -0800
Message-ID: <CALMp9eS1PCWw9f472=vibMp39-Xers+9bthOu2vxfRvZR+5JtA@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] KVM: x86: Update vPMCs when retiring branch instructions
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2021 at 11:42 PM Like Xu <like.xu.linux@gmail.com> wrote:
>
> From: Jim Mattson <jmattson@google.com>
>
> When KVM retires a guest branch instruction through emulation,
> increment any vPMCs that are configured to monitor "branch
> instructions retired," and update the sample period of those counters
> so that they will overflow at the right time.
>
> Signed-off-by: Eric Hankland <ehankland@google.com>
> [jmattson:
>   - Split the code to increment "branch instructions retired" into a
>     separate commit.
>   - Moved/consolidated the calls to kvm_pmu_trigger_event() in the
>     emulation of VMLAUNCH/VMRESUME to accommodate the evolution of
>     that code.
> ]
> Fixes: f5132b01386b ("KVM: Expose a version 2 architectural PMU to a guests")
> Signed-off-by: Jim Mattson <jmattson@google.com>

I'm not sure if this is appropriate, but...

Reviewed-by: Jim Mattson <jmattson@google.com>
