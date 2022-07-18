Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B252578603
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 17:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235046AbiGRPEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 11:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235041AbiGRPEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 11:04:30 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33622DCB;
        Mon, 18 Jul 2022 08:04:28 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-31e4c3b1977so7988077b3.6;
        Mon, 18 Jul 2022 08:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rakaPpsPKgr9AgFMH3FHQ8xHpUEGCDbjnvgcfF2K4JQ=;
        b=fBsqow0znUWojma1Lsk0S+PJx+5XL0wfUd0UPlymTCrv3bfRh7NPXytp2ROtibNxN0
         HytHpYDYPy9ulEnHjZY+Mwt1Wfs6JLbsQVOkzOMNeNkKcmeENegS8uns5et4DqIWuzej
         hS/KQpw8627eD434QYT3ECi+qsMWO1A7k906k4sbK3CzhKePLp6koh2kFto429GYnUfs
         fbeU5/QBYesXHv7DlcwL7wftxjEWqweJcVy/fDtO4qgfk1ZVpaUXuSzeuOVJl7QukpCe
         AE1jCFhY0/P/H0yF4Nm3FdJX2yb2vsTFIkOe+TcbnqSzjKhX9FElu29jpggBvWcrdEqu
         q3cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rakaPpsPKgr9AgFMH3FHQ8xHpUEGCDbjnvgcfF2K4JQ=;
        b=6dZKUwgL52rWpkShsD1BlEnEzwIId5ZXZ6TLkLX2eqKhSZgDnQWs4+Uys0+hrAhhmf
         jpejnErWhXL77VtrDY1JjgIua1n0aPJugo3oYycxslhLEvk7ErOeO7G14UjV5gYrWUhs
         lVNTjPyqys6cz17ZyDb4J57p/Q/GHwlvYKyN0WlFnS5v8PuTwXTbMuuFgnElVlAXJ5Yw
         LdoCAJablAFWP/0SwgcUGnYMVeSu2z9+gUV0nSmWT4IzJ2XhgTDi0SYR7pydNFNJyvUR
         giLuXmVKiLgvb++3BEOq1uu0e/spaSkbejz/Uzb5kGc3pWU+zNz6xr9R7Y6Bgpa4zMsm
         q7ww==
X-Gm-Message-State: AJIora+MaWNm0grnSsTLpShSshHGCwen62G3C+DGi1wBq0ePocNZ+fqS
        CLoBUX+OIvqEgMkQWLqUvn8+SkjvBGVmRWPDOBYyy2UG5TU=
X-Google-Smtp-Source: AGRyM1uGK3eLFjBPcF0mu+w72ff/Z7ywlzrtunWw4TZDrDrxILLteA+JNelu9+dTfiK70sbdMZFhgW72cYBfe/mJHjw=
X-Received: by 2002:a81:158a:0:b0:31c:a84a:d772 with SMTP id
 132-20020a81158a000000b0031ca84ad772mr30375657ywv.233.1658156667940; Mon, 18
 Jul 2022 08:04:27 -0700 (PDT)
MIME-Version: 1.0
References: <87cze3docs.fsf@mpe.ellerman.id.au> <20220718134418.354114-1-mpe@ellerman.id.au>
In-Reply-To: <20220718134418.354114-1-mpe@ellerman.id.au>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Mon, 18 Jul 2022 16:03:51 +0100
Message-ID: <CADVatmMSKT6yYU5bBa48DWffOBysnONRPXvoiVZnxQGj+bVQaA@mail.gmail.com>
Subject: Re: [PATCH] powerpc/64s: Disable stack variable initialisation for prom_init
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 2:44 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> With GCC 12 allmodconfig prom_init fails to build:
>
>   Error: External symbol 'memset' referenced from prom_init.c
>   make[2]: *** [arch/powerpc/kernel/Makefile:204: arch/powerpc/kernel/prom_init_check] Error 1
>

<snip>

>
> Reported-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

And, this has fixed the build failure.
Thanks Michael.


-- 
Regards
Sudip
