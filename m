Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA895AA6D3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 06:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234947AbiIBEVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 00:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiIBEV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 00:21:27 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7763C67145;
        Thu,  1 Sep 2022 21:21:25 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id t5so936172pjs.0;
        Thu, 01 Sep 2022 21:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=kkVoah+Kt1f00+c7U5NLPu9XabBa7X+D/IK+W2hYO48=;
        b=fT5cGEFvgQSmfw0Vg6OBjepfR6dgZcG4jAfHbTEcBVFhucx95zaucRKWjOImTjxYeu
         zRtLZ6Y0Zar2jsx9E7Dgw463u+KqZaPo/MF/4Aq1s+52GrmONtbV/cGfS72RQgQmKuGL
         lJyQJMzlhgTpqlbUp9nnwBJuLF3JJJWgDhiMxZ0Bm+8FQskyTUuBnI/dfgo4JdKtjn7a
         gYsvfCVKAFWhbyOFJdymjc6MDxRWOgjQiQGVBbklmrInAJqcTObwlvmh+tsCZwbNz+zt
         QkByrnmr9/LoXSBRtiNQuSObzdgL58zgVa5OFNAFyUcv7JTPfOUOdM6O3zRohfNnegtA
         u3pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=kkVoah+Kt1f00+c7U5NLPu9XabBa7X+D/IK+W2hYO48=;
        b=vhCAYNMsYne6FQlXqCBG3P1e6ZlZtBfwUyCLnstV/lqCzIjUSUBHuQTNIDfqZXVi0s
         bFC4LKxQNYEYjnKwlFj+j/gORHlv31GD0AKnSd8dHsQoD9fUWDSY6tYLsdrAnhYdkxHP
         rqaYVfDZcyL5mX1B9z4eE8De9MOcgFxH7MKCr1t7igl4wbE0EcgeHXvL21svBrKgM6wM
         346Xl0OBgFF3c0fRqeunJ3Hqjgxs7Q9iRPPdNMRCeqlmLjtt+vm3oFUtnyIbBcxmmEB/
         3fUVUNG2GyB3pWVYGisKn33uqQCfq1k4Sq7GaUbT+BHnKOAsaJ+dOjWbvlKL7O1qQJGo
         k+HQ==
X-Gm-Message-State: ACgBeo1GrPYGrt1Q79XaJ+mb2PXff6cJJDbbNIKxTIFLQpLN71CubiDJ
        WBKi1of3WDwfxLzS5aAkr8A=
X-Google-Smtp-Source: AA6agR5rqlKFWLqQhU/h5s3uRwQGy4k7zlANz5c9Vx/6oOmHSP3OESV6k/mn42Ei2WbNc71UN2bC5A==
X-Received: by 2002:a17:90a:181:b0:1fb:824:d33f with SMTP id 1-20020a17090a018100b001fb0824d33fmr2611819pjc.225.1662092484971;
        Thu, 01 Sep 2022 21:21:24 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-89.three.co.id. [180.214.232.89])
        by smtp.gmail.com with ESMTPSA id k1-20020a654641000000b0042b890d8b82sm386081pgr.24.2022.09.01.21.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 21:21:24 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 4F21B104010; Fri,  2 Sep 2022 11:21:21 +0700 (WIB)
Date:   Fri, 2 Sep 2022 11:21:21 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Len Baker <len.baker@gmx.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Francis Laniel <laniel_francis@privacyrequired.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] string: Introduce strtomem() and strtomem_pad()
Message-ID: <YxGEwdc69waEXhnV@debian.me>
References: <20220901190952.2229696-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cBiPWK8Ew+srt+QB"
Content-Disposition: inline
In-Reply-To: <20220901190952.2229696-1-keescook@chromium.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cBiPWK8Ew+srt+QB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 01, 2022 at 12:09:52PM -0700, Kees Cook wrote:
> + * Do not use this function. While FORTIFY_SOURCE tries to avoid
> + * over-reads of @q, it cannot defend against writing unterminated
> + * results to @p. Using strncpy() remains ambiguous and fragile.
> + * Instead, please choose an alternative, so that the expectation
> + * of @p's contents is unambiguous:
> + *
> + * @p needs to be:     | padded to @size | not padded
> + * --------------------+-----------------+------------+
> + *      NUL-terminated | strscpy_pad()   | strscpy()  |
> + * --------------------+-----------------+------------+
> + *  not NUL-terminated | strtomem_pad()  | strtomem() |
> + * --------------------+-----------------+------------+
> + *

My htmldocs build doesn't catch any new warnings, but I think the table
above can be fixed up:

---- >8 ----

diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index eed2119b23c523..3413a8e561fc62 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -95,12 +95,13 @@ extern char *__underlying_strncpy(char *p, const char *=
q, __kernel_size_t size)
  * Instead, please choose an alternative, so that the expectation
  * of @p's contents is unambiguous:
  *
- * @p needs to be:     | padded to @size | not padded
- * --------------------+-----------------+------------+
- *      NUL-terminated | strscpy_pad()   | strscpy()  |
- * --------------------+-----------------+------------+
- *  not NUL-terminated | strtomem_pad()  | strtomem() |
- * --------------------+-----------------+------------+
+ * +--------------------+-----------------+------------+
+ * |@p needs to be:     | padded to @size | not padded |
+ * +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D+
+ * |     NUL-terminated | strscpy_pad()   | strscpy()  |
+ * +--------------------+-----------------+------------+
+ * | not NUL-terminated | strtomem_pad()  | strtomem() |
+ * +--------------------+-----------------+------------+
  *
  * Note strscpy*()'s differing return values for detecting truncation,
  * and strtomem*()'s expectation that the destination is marked with

> + * Note strscpy*()'s differing return values for detecting truncation,
> + * and strtomem*()'s expectation that the destination is marked with
> + * __nonstring when it is a character array.
> + *

Regardless, I don't see these new table above in the output (am I missing
something?).

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--cBiPWK8Ew+srt+QB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCYxGEuwAKCRD2uYlJVVFO
o7dyAQCuf34QoZiPdFSC5RcNjrE7qXsLbk3bV5THirROShZnNgEA3ZKwneqmos4v
2LjcY1sxWbdLIrq4Y810093uQL8PgQ8=
=x7CB
-----END PGP SIGNATURE-----

--cBiPWK8Ew+srt+QB--
