Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3E1546E5B5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 10:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbhLIJoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 04:44:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbhLIJn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 04:43:59 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F61EC061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 01:40:26 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id j5-20020a17090a318500b001a6c749e697so5771771pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 01:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=EAgzyfuzJrF4vc8wP6iAI5ht/czof/vV71b1T0UUKYM=;
        b=RvQazjWcfA1CTLQXBKyS6zhLE6thZvJI6iEsOMs0oL+88is+AkWnRLRnks9kAvpct1
         RcUnXFWjRa73QTiIvzBhxuCaBV3apHjXFNXNBSQ6Pi4SSfJRRT0VtPUtpxBISGpkTk4k
         j4kEi7GUwmu9E+hBsWMiYCPPC60v47yHAr0IC1pOcTFmQgrVpAcq55VBGhouNMTOzCbU
         Q0XCIqkeaBWEyC0+H8giMLSISSeBrBjan0wpuxFufC2RzCgRi+pm26/gpPG4rE9AEPhy
         S3ZYHBjvX6P0yjhv+V/Y7My8aWlT5jwgDQlgGOGSw0WXU+aKE4cyinVxxkgMv0bh3c4M
         sk9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=EAgzyfuzJrF4vc8wP6iAI5ht/czof/vV71b1T0UUKYM=;
        b=RjPljfmnHcYQm/78ltOWsdUD3MoBCz7x86o38gCfmV86wnVILX5YT5zbcsfW+Sy+YU
         AjugCgy5ii44sZgNGEEfyzFZFigP6z10d4BNNzs9730jJ3OrGs//6wjBXK9fZciGwGzV
         EeZD7IuUFLyHYBfPY6/3QKwf60BTesae9hGTXPyFP8Tu1p4s8TxhN+1I2HiBWGKzcqUS
         lKGWCU7NsN1+kgZ7ab3mIq3SYYFbWTsjxgnda/Zn5VVu9uRVCz48KfiwAnTPcQ9NOXXp
         6Tbo0KO+GX/HbaPxfzhOWVR7xSxiE3UXvxCN6498Le69nxgGpIOtgqyA4cPC+2SDzA0W
         8Pyw==
X-Gm-Message-State: AOAM531SP/wFXV9ra8lUqtThj3kN6+IIqxDn2EaO19kwTqaYPT2nhxCL
        hd6u0hr5uHWFYAeaO1l4bWs=
X-Google-Smtp-Source: ABdhPJylsOgw7VCYRk99dEOJAsH+db9WnMPyzpHrN0JonjFuRepRjCcVVEudR1y+gG6e4nK/u4EbKQ==
X-Received: by 2002:a17:902:e804:b0:142:1c0b:c2a6 with SMTP id u4-20020a170902e80400b001421c0bc2a6mr64878506plg.23.1639042826217;
        Thu, 09 Dec 2021 01:40:26 -0800 (PST)
Received: from localhost (203-219-139-206.static.tpgi.com.au. [203.219.139.206])
        by smtp.gmail.com with ESMTPSA id ne7sm9080112pjb.36.2021.12.09.01.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 01:40:25 -0800 (PST)
Date:   Thu, 09 Dec 2021 19:40:20 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v4 02/10] mm, hugetlbfs: Allow an arch to always use
 generic versions of get_unmapped_area functions
To:     "alex@ghiti.fr" <alex@ghiti.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
References: <cover.1638976228.git.christophe.leroy@csgroup.eu>
        <52eb6d66c41f1165c88a0b0da08ae190c0b95a59.1638976229.git.christophe.leroy@csgroup.eu>
In-Reply-To: <52eb6d66c41f1165c88a0b0da08ae190c0b95a59.1638976229.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1639042788.z08wljpdx8.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Christophe Leroy's message of December 9, 2021 3:18 am:
> Unlike most architectures, powerpc can only define at runtime
> if it is going to use the generic arch_get_unmapped_area() or not.
>=20
> Today, powerpc has a copy of the generic arch_get_unmapped_area()
> because when selection HAVE_ARCH_UNMAPPED_AREA the generic
> arch_get_unmapped_area() is not available.
>=20
> Rename it generic_get_unmapped_area() and make it independent of
> HAVE_ARCH_UNMAPPED_AREA.
>=20
> Do the same for arch_get_unmapped_area_topdown() versus
> HAVE_ARCH_UNMAPPED_AREA_TOPDOWN.
>=20
> Do the same for hugetlb_get_unmapped_area() versus
> HAVE_ARCH_HUGETLB_UNMAPPED_AREA.
>=20

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  fs/hugetlbfs/inode.c     | 17 +++++++++++++----
>  include/linux/hugetlb.h  |  5 +++++
>  include/linux/sched/mm.h |  9 +++++++++
>  mm/mmap.c                | 31 ++++++++++++++++++++++++-------
>  4 files changed, 51 insertions(+), 11 deletions(-)
>=20
