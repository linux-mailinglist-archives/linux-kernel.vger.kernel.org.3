Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFA434646DB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 06:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234165AbhLAFxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 00:53:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbhLAFxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 00:53:50 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1FFC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 21:50:29 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id n26so23232556pff.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 21:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=vavIU7v4nh3h8E8EeKh3yjxEGQz2m3BEESyFJDC6e4M=;
        b=WM7Cf9O2FTrq6VF6fbFaVcE8S1MaCyfjJTqDeK5n+8XWTBGqd5bY1CKnCZNzZ1Chn7
         5hJbADlAsmqVxSxqP4p4QqTCT4ZwAPbgdJhod8sWJsuldb8KlHJr1FQv2FkDgUvOnvwe
         6s3Lwu6/2WNHBLZdPfCtbLXn2Cx1rmba2irWJI29NnXNlUBnrYytyjTUwZYzGzM/zQKu
         Yc2Ks667KsxHwuzqOcM+Vur8lECYMqkoPS56+pk1Hd8W9QCGnyiy3SyJXSlt5K24hjZT
         /32/oFQhRij0a9WBTmHR9zfoG/Ydw7Lc4T/xAoVDrW/JdsLBxYw6szVN6coMfw/Uce2a
         2/5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=vavIU7v4nh3h8E8EeKh3yjxEGQz2m3BEESyFJDC6e4M=;
        b=GFzQWiP5wOcEM00iAFIhRHgaBUAoeAtdacxDNI/Toa4/i5UlvMK8mhF0fQtLfC5FJf
         x8MLxVZZ59A3JJl5g9MSdxywiCNHf5OrVhyeciwvlHZryJz/XLw/0RSFozORghOJcrVE
         06uzhz9xTlExfEoiSML0bvWdyD/6CfHyiT0/0pciAnfdHyo0wiGJ9bmZ4RmhITg7Y3ZE
         V8KweMETsakDD1+3m9dVTG6sLnFK4oXFz9wmbne+i9pPcp6J8ZnMcjVGPi4JugQRYJBq
         BUzShDxfjBfBZB2vn4769WZW0j7H84nMFt46Z1gpMTenp5UEcGeP7cRW7w5pWx2cZcfx
         17uw==
X-Gm-Message-State: AOAM532ZgjXGE9eQj75OCl8XMlXXZasMWIegFnSyRhyYOFCeEWE9tUNr
        BH+/t9+/q5TJ4PLZrTlae2jSn4j4qdo=
X-Google-Smtp-Source: ABdhPJzpDuCyHsdum2WW1Qj7ykGJ5ES/Nu7CuVlGwuXPWDj9NgCTBq4mjlzjjlE8+bkdqGNXs7kgXQ==
X-Received: by 2002:a63:7c03:: with SMTP id x3mr3163305pgc.394.1638337829479;
        Tue, 30 Nov 2021 21:50:29 -0800 (PST)
Received: from localhost (115-64-213-93.static.tpgi.com.au. [115.64.213.93])
        by smtp.gmail.com with ESMTPSA id p43sm21757902pfw.4.2021.11.30.21.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 21:50:29 -0800 (PST)
Date:   Wed, 01 Dec 2021 15:50:24 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 rebased 3/9] powerpc/mm: Remove CONFIG_PPC_MM_SLICES
To:     alex@ghiti.fr, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org
References: <cover.1637862579.git.christophe.leroy@csgroup.eu>
        <103550e29fc95a6f93ec8848f9ebf9054ca024a3.1637862579.git.christophe.leroy@csgroup.eu>
In-Reply-To: <103550e29fc95a6f93ec8848f9ebf9054ca024a3.1637862579.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1638337392.ccyk5edcqo.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Christophe Leroy's message of November 26, 2021 3:52 am:
> CONFIG_PPC_MM_SLICES is always selected by hash book3s/64.
> CONFIG_PPC_MM_SLICES is never selected by other platforms.
>=20
> Remove it.

I guess there is some remnants of code/data to build 64s hash without=20
slices. Maybe without any huge page support? I guess it's probably
broken if it never =3Dn, and not worth maintaining anyway?

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

>=20
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/include/asm/book3s/64/hash.h |  4 ++--
>  arch/powerpc/include/asm/hugetlb.h        |  2 +-
>  arch/powerpc/include/asm/paca.h           |  7 -------
>  arch/powerpc/include/asm/slice.h          | 13 ++-----------
>  arch/powerpc/kernel/paca.c                |  5 -----
>  arch/powerpc/mm/book3s64/Makefile         |  3 +--
>  arch/powerpc/mm/book3s64/hash_utils.c     | 14 --------------
>  arch/powerpc/platforms/Kconfig.cputype    |  4 ----
>  8 files changed, 6 insertions(+), 46 deletions(-)
