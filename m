Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD85D46D9C7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 18:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237940AbhLHRhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 12:37:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235097AbhLHRhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 12:37:00 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C83C0617A1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 09:33:28 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id x10so3598401ioj.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 09:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zxdzBmou0nMLZSQ2PL0SgOvX3HihWUA9tdvfGZKATKc=;
        b=oGDjeNeX/ROucVuS1Pi3hZRldbTmAltKAYC+CcJD4Kcw5Mbxx/EOtfpOHG7bzx08R7
         1efeuZ50iJ3WKMirDadM/dpavNJBDC8CXIUQ1k63dNtyIuVNoZoYGYRkYQhxdlx7MZQd
         uyU70jRnMsvAnsCS4rsw3x/pQ7eHx/2fDJK0ZxH5nT74u0RkJoYfAwZCWSC4B10p1oNV
         oQRFyRomW8GM3tH7Iq0oFFo5N2uojb3dW1tbbPLfj+UdWjNCqA/dxmC7nGioHTmWLGpm
         gBXdNHwdDb3sNaMRl+NQR1V3p2OW2y2ivta4aUzJX+7E8pxuCp4lWMSup6eX0o6WdPRR
         SWtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zxdzBmou0nMLZSQ2PL0SgOvX3HihWUA9tdvfGZKATKc=;
        b=R0QH7N3u614TpsPpqbRv7mRq4FuFUG2RLF3i8rcBgKdPyxGbajC/ludt+ITYuFs5Q2
         EoUzPuXCDmUm20U+BrUukK7D4w2oBmkR0eCbf5e3ssSdADNUl/D+MjAtxgj6Q1idzOqk
         HBu1QaqGrrW9ihZGVRWqVbHwnSx/bgo0mWVJP9bNLaBEhqdHDBVTFDNIXkYVhflDIx+O
         nDlgP4QTnckedcYpxCVEKS7aI2J9YzQBo3/40q3tXt7FHLhJCFGrney8naqDNKlvXv0M
         U9oWZ/RjJTbdw78znKllOA8z/OcMPok/ee/ju/mRwcUONrMWhad2YqbUfaka6r6Q9J/P
         Gm3Q==
X-Gm-Message-State: AOAM531zjYcUqANsntb/OkXa62LCUia1kjB5jIzWFvOVYQkqkMmAMJ1B
        Mw0DgZNDyFp9y90XJcf37l4WWRiD44fY4bt0SevifA==
X-Google-Smtp-Source: ABdhPJwe0qsnrzEWY99rw92Dl247nO1g2aRfUQwFhLyufv0QQue7HHBTiLV5eGIadgi8buDTppvdOQnr73G4QW/kQOE=
X-Received: by 2002:a6b:b886:: with SMTP id i128mr8802035iof.151.1638984807851;
 Wed, 08 Dec 2021 09:33:27 -0800 (PST)
MIME-Version: 1.0
References: <20211208171113.22089-1-jose.exposito89@gmail.com>
In-Reply-To: <20211208171113.22089-1-jose.exposito89@gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 8 Dec 2021 09:33:14 -0800
Message-ID: <CAP-5=fUAR9uSAQGkukqafkoX+jz1fE8f-ziU5WeG59XT53jMWw@mail.gmail.com>
Subject: Re: [PATCH] perf util: Fix use after free in metric__new
To:     =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, ak@linux.intel.com,
        john.garry@huawei.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 8, 2021 at 9:11 AM Jos=C3=A9 Exp=C3=B3sito <jose.exposito89@gma=
il.com> wrote:
>
> Addresses-Coverity-ID: 1494000
> Signed-off-by: Jos=C3=A9 Exp=C3=B3sito <jose.exposito89@gmail.com>

Acked-by: Ian Rogers <irogers@google,com>

This can only happen in the ENOMEM case, but it is a good fix.

Fixes: b85a4d61d302 (perf metric: Allow modifiers on metrics)

Thanks,
Ian

> ---
>  tools/perf/util/metricgroup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.=
c
> index fffe02aae3ed..4d2fed3aefd1 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -209,8 +209,8 @@ static struct metric *metric__new(const struct pmu_ev=
ent *pe,
>         m->metric_name =3D pe->metric_name;
>         m->modifier =3D modifier ? strdup(modifier) : NULL;
>         if (modifier && !m->modifier) {
> -               free(m);
>                 expr__ctx_free(m->pctx);
> +               free(m);
>                 return NULL;
>         }
>         m->metric_expr =3D pe->metric_expr;
> --
> 2.25.1
>
