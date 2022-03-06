Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 844444CEED2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 00:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233226AbiCFXyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 18:54:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbiCFXyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 18:54:18 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28833FDA9
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 15:53:25 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id u61so27728084ybi.11
        for <linux-kernel@vger.kernel.org>; Sun, 06 Mar 2022 15:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MABB9jbYy82t2uep+ZIaOcEDc6tX3sRenZED6Ge1JDM=;
        b=IHktzUDVKrKIVxQ4HDD3Rv7QGA73LmXaavAstRHiRzhkmC0G0hmVe+D6q49aG2U6EC
         Kd5YkkAIhToulRkgOuCXjoOTt5z59ECY0LYLH/tBHTgB6rbuK+uwu4oKbYuW08ZgFk+E
         gI7kMvaaOKx+HHuAMnsWu1hbhqI7VVyoXnx6Sb35SDMVzIidLE/1APJKUBuWZ1kDgEd/
         hDBo25nu4RtmPBLaohIaOSJH1je7x+Fx2qtycn0jYimcaTqR/slb6UbQcPykMqtCJVFt
         XvxxXUVLXqsdJR7rfQObC4iGpJ2xAK9Va3MJpeRaxPbq9V9EGc3RhCvJevnWRPhf5nBe
         FBkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MABB9jbYy82t2uep+ZIaOcEDc6tX3sRenZED6Ge1JDM=;
        b=znsD6Nzn6+b/ZNaU+Oaz8rP5UQ+lDs5nVfJ0Uk28rxj4zGrlHggDtqk7FagWqaPDbd
         tQISYQUEeJNjKY0BN4Yf7kimW/T5GWX4is1kmKci1xgkd+kLNuwAHfvv5z10BKP5Qsf/
         Yvkur+UzKTGB8YCqvSzPpIwk2hKTHn9YAuBwMLfy2PfBiHxR80JLnWxiF8tlzIqg9+Yn
         VRWsyFOsyUdt4o6z4v4h3NbnvREuXOu+vdRnI0Rv/MhAzo2sJX1jDYDOPO9Iz8Vx0Eu0
         9Qb5F5uM5UFBtCGhK6wZouZUa8Pmy+Py0gNNFFXgBewgpro8YpRYoEJgI/RkMJCog0Ic
         PVrA==
X-Gm-Message-State: AOAM5327fXs2JL2ndhk2gWTtJITFckJGt/IrHb9iT6SG81hPaQAKzcSA
        gmCF9v6sVwTnhv0l13grOOoUvZeI41TRcqit8YGzTA==
X-Google-Smtp-Source: ABdhPJygx1A2AusLyn9WPUOBSFcm7WnRpGHbgCIPuNrCg0pqSirO8cVnfajx0dHKvgz+KV/y14mXXxsh8J4kwjsSlYI=
X-Received: by 2002:a25:6994:0:b0:629:1e05:b110 with SMTP id
 e142-20020a256994000000b006291e05b110mr4736034ybc.425.1646610804997; Sun, 06
 Mar 2022 15:53:24 -0800 (PST)
MIME-Version: 1.0
References: <20220305144858.17040-1-dtcccc@linux.alibaba.com> <20220305144858.17040-3-dtcccc@linux.alibaba.com>
In-Reply-To: <20220305144858.17040-3-dtcccc@linux.alibaba.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 7 Mar 2022 00:52:48 +0100
Message-ID: <CANpmjNM+47dfjLyyuQwUWZyJgsr1Uxd72VPe9Vva3Qr2oiXRHA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] kfence: Alloc kfence_pool after system startup
To:     Tianchen Ding <dtcccc@linux.alibaba.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Mar 2022 at 15:49, Tianchen Ding <dtcccc@linux.alibaba.com> wrote=
:
[...]
> +static int kfence_init_late(void)
> +{
> +       const unsigned long nr_pages =3D KFENCE_POOL_SIZE / PAGE_SIZE;
> +       struct page *pages;
> +
> +       pages =3D alloc_contig_pages(nr_pages, GFP_KERNEL, first_online_n=
ode, NULL);

> mm/kfence/core.c:836:17: error: implicit declaration of function =E2=80=
=98alloc_contig_pages=E2=80=99 [-Werror=3Dimplicit-function-declaration]

This doesn't build without CMA. See ifdef CONFIG_CONTIG_ALLOC in
gfp.h, which declares alloc_contig_pages.

Will alloc_pages() work as you expect? If so, perhaps only use
alloc_contig_pages() #ifdef CONFIG_CONTIG_ALLOC.

Thanks,
-- Marco
