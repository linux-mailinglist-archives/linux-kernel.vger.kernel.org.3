Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91E6D4646BB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 06:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346749AbhLAFgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 00:36:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbhLAFgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 00:36:02 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C4FC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 21:32:42 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id gb13-20020a17090b060d00b001a674e2c4a8so397591pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 21:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=tpCmJo2bsWQVn4TP4a2fQaGlZVVq+NNHeKbbKn9xcpA=;
        b=bPVd8zdWsvzjOqgWGQB0PVAjBejhbhh79/C/nMasyj9BionVO/JCOrXNGmH+F4hRyv
         DS2bIxXNJXplnNb5A7PDgh7OkK/mryXwFi+6Ief32l9LfYpAs3aaWrW399PIi95FjKpP
         8Pt9GSCNgzU6M+VYXUN7WtKYaFYSm2W7mWPi3VxeFHYPWwvMH2mJJ9cajgqnIUPVS/rm
         tO01sEqtp9HKQDi+EB0hJNPnGW9sUB0aTedx7ERb4bzOLKqhNYc9L9Juy6FuUW3fWZal
         D84XAmhqT55Q06oclCPKUZSpI0+TDxnInlsOQ6mhQXGYWlK/VErC498KxQSnuT9qnDTm
         ShbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=tpCmJo2bsWQVn4TP4a2fQaGlZVVq+NNHeKbbKn9xcpA=;
        b=Zk/8Jv8wyFAjVMWFBAmO3nSX398gYYuKP55+26v3My/caGS5fjGSbq0VeaLMjCnTY6
         NO5NLCzXklQ71aYlN8fqGiwdtsOwkI5bYl6fMIwJeY4YS1EjVKXG8fc/QUVmt0aZ6OSu
         9qd6GCL75npq7ZqvNbng8R6ruj5lalcWAYQXxJIaXMRf2TrtXaDA0qQN1JSu5uPDr5EL
         FQYw/qzqWgeiIqmNxGwj5jRIT/1/OuDNwVpjvYkIoDc+CF+aCxYArFC8NHyhOCL6S0px
         7YAXzCkLi85fGcuPh4EgKkuhNsG6lo2TlD4sXQLG6ukcpg4+t0pwJgi3igjU6wbJenoR
         pg1Q==
X-Gm-Message-State: AOAM533/Usu0xDSvShjQnooMK+lgma2rQz8snDjH0zCS/kcC2dC0fxO3
        I365HpNcY4RD+jSZp2ucDdZmMSCFya8=
X-Google-Smtp-Source: ABdhPJwkUfMA8MEjorWlPEzCCFykGlpgXNVi2Vmq3F81C1ZDdbpy5pVUrqMm5tPG9dEOFphR0gjPYA==
X-Received: by 2002:a17:90b:4a4d:: with SMTP id lb13mr4705223pjb.97.1638336762038;
        Tue, 30 Nov 2021 21:32:42 -0800 (PST)
Received: from localhost (115-64-213-93.static.tpgi.com.au. [115.64.213.93])
        by smtp.gmail.com with ESMTPSA id i5sm17203794pgo.36.2021.11.30.21.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 21:32:41 -0800 (PST)
Date:   Wed, 01 Dec 2021 15:32:36 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 rebased 1/9] powerpc/mm: Make slice specific to
 book3s/64
To:     alex@ghiti.fr, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org
References: <cover.1637862579.git.christophe.leroy@csgroup.eu>
        <2d9668bd46805c9fcfef804e125aa4fbad2e87a7.1637862579.git.christophe.leroy@csgroup.eu>
In-Reply-To: <2d9668bd46805c9fcfef804e125aa4fbad2e87a7.1637862579.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1638336646.izi2xwmepk.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Christophe Leroy's message of November 26, 2021 3:52 am:
> Since commit 555904d07eef ("powerpc/8xx: MM_SLICE is not needed
> anymore") only book3s/64 selects CONFIG_PPC_MM_SLICES.
>=20
> Move slice.c into mm/book3s64/
>=20
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> ---
> v2: Remove now unnecessary #ifdef CONFIG_PPC_BOOK3S_64 in slice.c
> ---
>  arch/powerpc/mm/Makefile               | 1 -
>  arch/powerpc/mm/book3s64/Makefile      | 1 +
>  arch/powerpc/mm/{ =3D> book3s64}/slice.c | 2 --
>  arch/powerpc/mm/nohash/mmu_context.c   | 9 ---------
>  arch/powerpc/mm/nohash/tlb.c           | 4 ----
>  5 files changed, 1 insertion(+), 16 deletions(-)
>  rename arch/powerpc/mm/{ =3D> book3s64}/slice.c (99%)
>=20
