Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19070487748
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 13:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237988AbiAGMCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 07:02:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbiAGMCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 07:02:21 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55068C061245
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 04:02:21 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id v6so10619706wra.8
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 04:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=4lKpXfW8u2t2lg00lQjLftdL1lClE/hxK/A0UViPuRM=;
        b=ZCyNiyrXgMrXB6mdUgFZKzCXEUCxS4AT9izEeclEz/ZoWZ40Lywi2zo1aFj0oQS0cm
         aC7c34QmkOi5YMVR+6Bapf4m+czgz1brD7NScc9jKAtjx0izV1bZDiqD9O9+jTktM5qD
         Ld8dutL+gqTbIB2TOim5DhWyz2+sA8B4xXy2dK2j+XUqbGGjB45kGIP3V3AeEDupa3TJ
         3oyQ3uk96xTPDbTNEE1TP8EsvdcrGyJtx+3VsR0vNdHnbvS4LNhapGQD16NbwKFlZYlT
         v8UilwrBsxnM2Ybi6dxnRSmfWtnEhwVn+jh+H61uNNG+DYY8Rm6gUCkImKdtP+MTllBw
         up8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=4lKpXfW8u2t2lg00lQjLftdL1lClE/hxK/A0UViPuRM=;
        b=v30bweCXU84yOp7S21Qv2fBcqHgqrpmHBIZLDwBv9qzogteVEI6usedKaAUqf4MO/M
         XCEh8ozcmOKg7uTuNpTIhusoTijlpUcKp1Mq8/bdyIzyZ8emqQmKr7cTuOcnZz45t10Y
         Vd3J7wpdvONgebNFIXtHO9KxEPKPuUCOTBES37MMeXCCUB5+4AeWXdar5LH08p9qNPyh
         Vk84giX6eIvHn3HBfhSBKpKiliFYOrlI0YXb/Fb70ugyWy1V7QjDwZYQAIhXrkrGSACO
         ALD4A7v9RAVPNS/HxIyhTU5uKahNRyhNCuBCoAvtZh7qSlpWe5/YKSlR43wQAEhJVkZ0
         /gNQ==
X-Gm-Message-State: AOAM532849lgWYpmVP8lmUr15attOpqGRAEzrMSMW4b0LJi9SGmcYLD7
        Y0aT7nxPswBbV6f2vSDik2hJDQ==
X-Google-Smtp-Source: ABdhPJyR820EZgEhlLXN+odU78BaJV3nQGTN3ducR36DluoJg8WDU1sj5d7ozmqRh3ErU0zcsa+kyw==
X-Received: by 2002:adf:e4d1:: with SMTP id v17mr10638015wrm.188.1641556939925;
        Fri, 07 Jan 2022 04:02:19 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
        by smtp.gmail.com with ESMTPSA id ba18sm4577110wrb.40.2022.01.07.04.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 04:02:18 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
        by zen.linaroharston (Postfix) with ESMTP id 494721FFB7;
        Fri,  7 Jan 2022 12:02:18 +0000 (GMT)
References: <9405dfb2-01ea-d11c-5e8a-f0db5db73204@gmx.com>
User-agent: mu4e 1.7.5; emacs 28.0.90
From:   Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     qemu-arm@nongnu.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: How to get the supported page sizes of aarch64? (and possible
 other architectures)
Date:   Fri, 07 Jan 2022 11:46:58 +0000
In-reply-to: <9405dfb2-01ea-d11c-5e8a-f0db5db73204@gmx.com>
Message-ID: <87tuefhhyt.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Qu Wenruo <quwenruo.btrfs@gmx.com> writes:

> Hi,
>
> Recently I'm trying to boot a kernel with 16K page size, but edk2
> firmware failed to load the kernel on my CM4, with unsupported message:
>
>  Failed to execute Archlinux ARM (\Image-custom): Unsupported
>
> While 4K and 64K page sized kernels are fine to boot.
>
> A quick search shows that Cortex A processors support 4K and 64K page
> size, and 16K page size is not a mandatory requirement.
>
> On the other hand, other aarch64 processors, like Apple M1 only supports
> 4K and 16K page size, no 64K page size support.
>
>
> Although ARM documents show ID_AA64MMFR0_EL1 would report such info, is
> there any user space tool or kernel messages to show an
> end-user-friendly output about what page sizes are support?

Not that I'm aware of but a chunk of the ID registers are exposed to
user space to read (although some bits are masked). I think the kernel
hides the translation granules support and I think only exposes the page
size the kernel has booted into.

I guess you could hack the kernel to dump the real ID register value in
dmesg or something like that?

>
> Thanks,
> Qu


--=20
Alex Benn=C3=A9e
