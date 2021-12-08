Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE2946D1FE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 12:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbhLHLW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 06:22:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbhLHLW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 06:22:27 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CAF7C061746;
        Wed,  8 Dec 2021 03:18:55 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id j2so5082748ybg.9;
        Wed, 08 Dec 2021 03:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GC0fr99bcvuQY6pcX4afH0OJVk0b7ZSfeDz9Tp0MJ7A=;
        b=HV4aUd4OtWhCTD0v69ViKmPQjSHo2q2v1GcWKGP+yXa7QZ4JaxXPL5HkRYZpg0GFXu
         pi0I87GfVK+7c2qyRAeYMtdp6A4ieeLQwiV4YdeZYfAk92vycg63TXqQ6EuPyF1T4JZk
         lPTt7shAfaJi4/O25jt60Ug9Hf7F/258BFjYwmM0T+v6urnIQLt468nSimtPy8bUQeAR
         IO5Tvj0dg4FotkrulS6yXvHB8F7gXgEi9hjcVecDEf6C884BMgAoGDXgOb1U4y4P/Dkd
         wUHFPWQrMzuxNaW27h8UPUuBGfLzfmfVZEJqELuurbExLP5PiWCBen5d9SEL3L2ZwRyB
         zknA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GC0fr99bcvuQY6pcX4afH0OJVk0b7ZSfeDz9Tp0MJ7A=;
        b=Hpf5y1oGvUvUQnbXJS3w1tIHtbFGvcnF2Xg3UPv1v5G59Fo0rpHIikukoVQToFh3JV
         8aLJaqlp2sQca34/E3aqxes+SgA5Xn17EI0McwxWisXwUUqH7X2yRl4Br/sEx+/wCOGp
         8nWaVDwUZQq+LDGgLQuV/90OW6FbV0oY8hpXvPbWspKCUmmOGFGqwgYne/dpoNosV2mn
         I5GZXn4VEt6V3Q8r00nkTM+aNd6E9Qvtv4ZT//LgE2VlAyRpcR2V033tholSB/CYmmDW
         byJQW+dRG+d9wPzAJG5qgs56r+O8CtRIxZSyVaWg2REALutU1wiLYsqXHZuH64xrsRUI
         +puw==
X-Gm-Message-State: AOAM533artS1Ixg55lNjQf+ZKIu2oPMcVMZvZu0idgKcEufhfxLx+y79
        trI0tbnHER8zo16tSHK/0o50ipB9FbJISTl3I1ZRwUPg/GY=
X-Google-Smtp-Source: ABdhPJzIlZfc8/y6ERPpCC7+glbhkE2tUOv0EVPvBBQnbyLZsOpZKMe9MYO0UrMYZB8HWDnbE3eSqMNylWyznm6nxtI=
X-Received: by 2002:a25:2257:: with SMTP id i84mr54879639ybi.157.1638962334203;
 Wed, 08 Dec 2021 03:18:54 -0800 (PST)
MIME-Version: 1.0
References: <20211207064019.61444-1-marcan@marcan.st> <5723f5bc-f721-9976-d63d-2738233f62bd@marcan.st>
 <CACT4zj9Oy_Le8KzPS9WfH+Zx9Re7h0SOwkWFN+G5X1pCF3s3ZA@mail.gmail.com> <04d8b420-d957-edea-bdae-7f939b108b60@marcan.st>
In-Reply-To: <04d8b420-d957-edea-bdae-7f939b108b60@marcan.st>
From:   Ben Chuang <benchuanggli@gmail.com>
Date:   Wed, 8 Dec 2021 19:18:43 +0800
Message-ID: <CACT4zj8rp12SqAvw-9Po_R3eyaeJqUp6CVZbKkAdK92Y2SmMTA@mail.gmail.com>
Subject: Re: [PATCH 0/2] mmc: sdhci-pci-gli: GL9755: Quirks for Apple ARM platforms
To:     Hector Martin <marcan@marcan.st>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sven Peter <sven@svenpeter.dev>, Marc Zyngier <maz@kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hector,

On Tue, Dec 7, 2021 at 10:10 PM Hector Martin <marcan@marcan.st> wrote:
>
> Hi Ben,
>
> On 07/12/2021 21.25, Ben Chuang wrote:
> > Hi Hector,
> >
> > I got your two patches so you don't need to resend them.
> > About the 8/16-bits MMIO read patch as the second patch, it is necessary.
> > I don't know some vendor-specific knobs, sorry.
>
> Is this only required on these Apple platforms? I'm very curious about
> what's different about them. I assume these chips don't need the
> workaround on x86 laptops, right?

I'm not sure if it only happens on these Apple platforms.
Right, the workaround is not needed on x86.

>
> > ps. Do you make Asahi Linux now?  It's a cool project. :)
>
> Along with a lot of other talented folks, yes :)
>
> -Hector
>
> --
> Hector Martin (marcan@marcan.st)
> Public Key: https://mrcn.st/pub

Best regards,
Ben
