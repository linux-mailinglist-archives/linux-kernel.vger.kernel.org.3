Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D1750A76C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 19:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390974AbiDURzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 13:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348173AbiDURzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 13:55:24 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753C34A901;
        Thu, 21 Apr 2022 10:52:33 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id c190-20020a1c35c7000000b0038e37907b5bso6401750wma.0;
        Thu, 21 Apr 2022 10:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=7S1HS8zqtDyWf8mUL+p+GGCoIBRPIF5unnXiHhwzozc=;
        b=i0Qr1q9/gP1NrfI1K+c89R8JePSpH4attbPjr54V2XO0crTDa1URKKECloWEthvAA3
         n8bBS1lcbDBuIbVc0RNoFlpkaFqHwgxxSJfSnauspFBTtYxUNAGuwj0uKA0b42FeSqty
         fBN+STTSR2An+5dxbarlfB30S65gtU78gQNrZOX3NqOu3RlUgMEhAWyy3lVpFkuZ29qB
         rBCeHq7zq2uICjVHJTDioSwdox1mZAYBvXlYQO3MnTi5PdZ61tyQihJYMlMqpJqrhlTy
         dNYlekhMr3WTSzHhjgnIFIG3pqRb4NjDk/OFZwlFIQJF7l8zfyHY/ErW73+IXNNsjkXs
         pSwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7S1HS8zqtDyWf8mUL+p+GGCoIBRPIF5unnXiHhwzozc=;
        b=XuuUvsi8bTQPlZAaT1+GLgjBwDf7wMn8grrVBhA1nH6V4v7UMMjLRJHkfCGsSBSdWa
         SeSMfitcK5YiLENIc5oKA7CXL/SBL+hlNVqrgLYowpKxTJ42jGqR5WAQ2ie76FTz1q4W
         LVEwKU06rvJDuO6tGspTLaf6jfjR+p+dJs+DlrIXNhNRIm7OxVybV/CBcN1WclsfLF9R
         3Ai8M2McccPfaBlzfp47mlaQEnrCouFO1BgryGAGOgiLvgIBiOsjuueUdrR+d8knw99Z
         /GR5o2whnW+A1COvF7XBrGzcSGQfcbT+thEZDIN586PDr7amkRWlgIfxIsyN2nKCw+UA
         tVUw==
X-Gm-Message-State: AOAM532gByNouKJVFEinCyfAf+nhU3LpVL+484pcqgDw+VU5JBDB4w9C
        D6jb/j0G4iGXpHv7dNjcveuDWMND8EU=
X-Google-Smtp-Source: ABdhPJxDOKGfEizTR3nTzgt4lViILYZF+pvyG4PygXgfeih6hNIDAYOtIQsB32LFFFHZDBuEKPwRRw==
X-Received: by 2002:a05:600c:6d3:b0:38e:c692:d50a with SMTP id b19-20020a05600c06d300b0038ec692d50amr9704777wmn.30.1650563552001;
        Thu, 21 Apr 2022 10:52:32 -0700 (PDT)
Received: from leap.localnet (host-79-50-86-254.retail.telecomitalia.it. [79.50.86.254])
        by smtp.gmail.com with ESMTPSA id 100-20020adf806d000000b00205ba671b25sm2790717wrk.56.2022.04.21.10.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 10:52:30 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        SeongJae Park <sj@kernel.org>,
        Jiajian Ye <yejiajian2018@email.szu.edu.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ira Weiny <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        outreachy@lists.linux.dev, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation/vm: Include kernel-doc from highmem-internal.h
Date:   Thu, 21 Apr 2022 19:52:29 +0200
Message-ID: <1755877.Zkmt1EvEu4@leap>
In-Reply-To: <20220418081740.21001-1-fmdefrancesco@gmail.com>
References: <20220418081740.21001-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On luned=C3=AC 18 aprile 2022 10:17:40 CEST Fabio M. De Francesco wrote:
> In Documentation/vm/highmem.rst the kernel-doc comments are missing,
> therefore kunmap_local() and kunmap_atomic() are yet undocumented.
>=20
> Add a kernel-doc directive to include the above-mentioned kernel-doc
> comments in highmem.rst.
>=20
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>=20
> This patch must be applied and built on top of=20
> "[PATCH v3 2/2] Documentation/vm: Include kernel-doc to highmem.rst"
> https://lore.kernel.org/lkml/20220415231917.25962-3-fmdefrancesco@gmail.c=
om/
>=20
>  Documentation/vm/highmem.rst | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/vm/highmem.rst b/Documentation/vm/highmem.rst
> index 5dcee6233cd5..1a3e6a8f5d3e 100644
> --- a/Documentation/vm/highmem.rst
> +++ b/Documentation/vm/highmem.rst
> @@ -161,3 +161,4 @@ Functions
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
>  .. kernel-doc:: include/linux/highmem.h
> +.. kernel-doc:: include/linux/highmem-internal.h
> --=20
> 2.34.1
>=20
Dear Maintainers,

Please drop this patch because it has been reworked and inserted as part of=
=20
a new series whose subject is "Extend and reorganize Highmem's=20
documentation" and which is about to be submitted.

Thanks,

=46abio M. De Francesco



