Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEA4846C7C1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 23:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242379AbhLGWxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 17:53:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240577AbhLGWxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 17:53:21 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6861FC061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 14:49:50 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id np3so559528pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 14:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fcpFLlNA7kr4r9PDNWxPQY6v7y59YAmGkgOxvfSVSu4=;
        b=a1gXSUHskUVC6UlA3hZNc/uhju6GRUtKS9UGVtPv/csKuv54fkz6vaiOhc68qL9M2z
         yoWVYnifUOcwAuie8ZfPQlrorz1ghIRtQPWBo+5nCmmLZLaB9B8QKst2cXOs0z5KMokm
         +5By13xnKf6ODiiBPsPVRMkROcK0cjzk+Z/wVaimnulfu21wYXg36LRhuwg4H7kP9QOP
         P4t5ArfcvjjjrR3mOxHm5yF48znp7qHZH3rKI2+lnaX4jZdSQRItZitW8WMBrhelXSJA
         QK2QbF4dRy0E9S4xANUSrlRcY2S5XrTYpBBjvevyxKYGg9S+lNNLcWpEgqA5RSooPSZO
         vSOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fcpFLlNA7kr4r9PDNWxPQY6v7y59YAmGkgOxvfSVSu4=;
        b=1VNHKvHl4yNt1XnUaAVcS9re/2pd1O37UAlaPYeMc6o/M4C30oy/pNHKsbRvo1EtZO
         P+oMOA1K/H12ZfyH84BKNAat+PpGstaVYyUo5Xa9priVJwsZ3PqmBQiVsE45bBbFCAYD
         Hhc88EXBLq/N/6PPqFz05539f46ZqXwJ2nehrrxCKEfaKrm68NngTqy4I6POyptpzysj
         3FVt5uGEU8OF1SmBacY73DtKyH2bsArPLcKVaulDu9DOCnLmTCX3g1UzxluCrUwMJLKL
         pfZkX7wolQUI3IEFto/Sr9F2p5Bm10wXWfzDbmGQZijT5BxlzcG7AVlwze6DjVpVE3Ay
         qllA==
X-Gm-Message-State: AOAM530SEMsepZ98HTnuF6ZxsBwjs7054TfWRaOgLmMFTU8102w2qvhq
        8uXmZ8zsyZ8Xmi48Bjw0joDyHYfwgySfTIpGZQNt3g==
X-Google-Smtp-Source: ABdhPJwNxQ8H+AEsmYUGzdanLJ8i66IHUyHe+/68iDuugPpkHLEssuLty1MbQb1T59bx3pDc+Wt20ghrlXuw7DubacA=
X-Received: by 2002:a17:90b:230c:: with SMTP id mt12mr2547128pjb.63.1638917389709;
 Tue, 07 Dec 2021 14:49:49 -0800 (PST)
MIME-Version: 1.0
References: <20211119232316.2246034-1-dlatypov@google.com>
In-Reply-To: <20211119232316.2246034-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 7 Dec 2021 17:49:38 -0500
Message-ID: <CAFd5g44KBS-+0CawwRw6sfpzvX8k7zN3wKkCPH-LUiDawMfeLw@mail.gmail.com>
Subject: Re: [PATCH v2] kunit: tool: reconfigure when the used kunitconfig changes
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2021 at 6:23 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> Problem: currently, if you remove something from your kunitconfig,
> kunit.py will not regenerate the .config file.
> The same thing happens if you did --kunitconfig_add=CONFIG_KASAN=y [1]
> and then ran again without it. Your new run will still have KASAN.
>
> The reason is that kunit.py won't regenerate the .config file if it's a
> superset of the kunitconfig. This speeds it up a bit for iterating.
>
> This patch adds an additional check that forces kunit.py to regenerate
> the .config file if the current kunitconfig doesn't match the previous
> one.
>
> What this means:
> * deleting entries from .kunitconfig works as one would expect
> * dropping  a --kunitconfig_add also triggers a rebuild
> * you can still edit .config directly to turn on new options
>
> We implement this by creating a `last_used_kunitconfig` file in the
> build directory (so .kunit, by default) after we generate the .config.
> When comparing the kconfigs, we compare python sets, so duplicates and
> permutations don't trip us up.
>
> The majority of this patch is adding unit tests for the existing logic
> and for the new case where `last_used_kunitconfig` differs.
>
> [1] https://lore.kernel.org/linux-kselftest/20211106013058.2621799-2-dlatypov@google.com/
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

When you first presented this, I wasn't a huge fan, but you convinced
me. I think the only reason I didn't initially like this is because of
how used-to kunit_tool's eccentricities I have gotten.

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
