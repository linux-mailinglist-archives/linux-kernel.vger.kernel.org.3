Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2FC14847B2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 19:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236300AbiADSVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 13:21:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236248AbiADSVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 13:21:05 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200A9C06179C
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 10:21:05 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id i11so49548599ljm.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 10:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w+EWql6pvLIn2T8wbRx9hDhh1qw1Cb0Ehxzhh770d7Q=;
        b=DvZPEcA3qvISGQ69XubnYTyoOEhrVMfSNbTzzX/n9vh9ihABNUDpLirG8uHkL7hqz1
         sz1ZLNEGeLEfdNnDkYbpCf0l7JfTq/W4afQL3AT9o7WGXBOpccLWUgjFC2rC20AVlgoj
         ZYzMoYRNQc3k4XihlOh3hZ9hP0yjKLa0FgoWYHz1lOI6hIp1OVn4/joEjqbDWGymE1Iz
         P64l0s98jRAYyMtEaFx1SdVFqMyXD+2lAFflobXo95LLGvx638KyiRm9qv5awFMSv5Ro
         otxcGAwud5op3XQSJUjZvsgtOfUv1GGo/SQs/orfpPDY/YP4xyAxO/lqaD65GZJm/Hf4
         SIcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w+EWql6pvLIn2T8wbRx9hDhh1qw1Cb0Ehxzhh770d7Q=;
        b=MGzlu5Xtwz9242SpmGK/hF8WAfV8Fn72hrnRDSE43oMMG2xf3bJ3FD9LnGuL8y5RgH
         QHp0tThfnOwK1sH/pMg2WB7lK9UST2g6AuH67ELmeFSaKmidgTWmVg3fJZQBr+5p2NYr
         4ni2NBpwIPyPu4P0vVZviX56APuxhB6nbhcCDdv2xb07hW/1d22LFp066bmZ+PhbBWij
         XMfwS4HoNhx5U6aBh9FGFR7GG0uzfpTKjMuM9N7+/R2k0GGndE0yQRshCs1d7zrs+87X
         5LFyiDjmzsLyP7rTNMb2yA220QwiCIgRJMSCHhax1wHhu/tzVYfLRiAbe7VWtUTNK97s
         PfSw==
X-Gm-Message-State: AOAM530bcnnHSBsrF7LiHyluV/C8kf3VrywSo3T5ogXYqnpDCecOfJBK
        NjJ36PrUgUVvvvLlgyMkZPdgY2W7K4oYt4DpxNB/TQ==
X-Google-Smtp-Source: ABdhPJzZ5TkVNdJCHAm6KtH3e5wu5oegS6QU1R8TROvocFjxhc0rECxH61wepebnKuwiWxfG71HRKOm/4/yFHRF/6Ec=
X-Received: by 2002:a05:651c:1789:: with SMTP id bn9mr6656332ljb.475.1641320463159;
 Tue, 04 Jan 2022 10:21:03 -0800 (PST)
MIME-Version: 1.0
References: <63840bf3-2199-3240-bdfa-abb55518b5f9@colorfullife.com> <20211223031207.556189-1-chi.minghao@zte.com.cn>
In-Reply-To: <20211223031207.556189-1-chi.minghao@zte.com.cn>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 4 Jan 2022 10:20:51 -0800
Message-ID: <CALvZod7pTO6D5Lx62-eVWORSj4Q=Px2iu=qUgqA_9AZwQOKsUg@mail.gmail.com>
Subject: Re: [PATCH v2] ipc/sem: do not sleep with a spin lock held
To:     cgel.zte@gmail.com
Cc:     Manfred Spraul <manfred@colorfullife.com>,
        stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, chi.minghao@zte.com.cn,
        Davidlohr Bueso <dbueso@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>, unixbhaskar@gmail.com,
        Vasily Averin <vvs@virtuozzo.com>, zealci@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 7:12 PM <cgel.zte@gmail.com> wrote:
>
> From: Minghao Chi <chi.minghao@zte.com.cn>
>
> We can't call kvfree() with a spin lock held, so defer it.
> Fixes: fc37a3b8b438 ("[PATCH] ipc sem: use kvmalloc for sem_undo
> allocation")
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
