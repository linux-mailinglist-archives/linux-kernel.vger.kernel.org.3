Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 050C155CFEB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbiF0HRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 03:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232558AbiF0HRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 03:17:15 -0400
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB8E5FE6;
        Mon, 27 Jun 2022 00:17:13 -0700 (PDT)
Received: by mail-qv1-f47.google.com with SMTP id y14so13529784qvs.10;
        Mon, 27 Jun 2022 00:17:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e/zqkQPFTUj9N5yUlKAt6CBYdzhsrN+6ZcFTDaIiaZY=;
        b=yKlbCeeWoczArlS08sJa8qkBDxpUuSNgLCYucSj9Pj0yIPSMsOtt+GcBFXvt//HGsU
         WrN6KtzGDIVMEN3DmgsReyaQow5y6V1oVGLlnwzasW6BaZr47A4iR8AB/A0i/HYoWouv
         GkBwJEb/XZbeIIckKDx7tCicFpkkqWhSIXdd9DDcwfoXPp3qqlrnZUUrJwhpoFhE0EzY
         h3CldsH3cCCkT37cZ2mGKFPO8XQG4hvUhZcNJwSZ2QjnNqwbdOA2LO4pPwBDEeX5Mq/3
         /PQUmml6QF0UKvu4MhffwfSc7jKpZE20hBdDiOaGXSSCfSatByzuT0FRaqh9JFMFmC+k
         FGRQ==
X-Gm-Message-State: AJIora+YHohVoY5h9kfjHt8qw8u1NfEiVGih3fLIe0c1XX/VlW/10QIe
        Uw3z7n9LASoE7aanlcHkCdRZfG3SVecI5g==
X-Google-Smtp-Source: AGRyM1t6D0kJxzhDzKgLa9OikDBLTIlLI87jQEeKacvqoyjuqewB8LkiTwHryMozHnbbl4pg23hEcw==
X-Received: by 2002:ac8:5749:0:b0:305:1ea5:4a7 with SMTP id 9-20020ac85749000000b003051ea504a7mr7816225qtx.291.1656314232362;
        Mon, 27 Jun 2022 00:17:12 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id w20-20020a05620a445400b006af37b005bdsm664399qkp.128.2022.06.27.00.17.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 00:17:11 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id o19so8675891ybg.2;
        Mon, 27 Jun 2022 00:17:11 -0700 (PDT)
X-Received: by 2002:a05:6902:120e:b0:634:6f29:6b84 with SMTP id
 s14-20020a056902120e00b006346f296b84mr12087179ybu.604.1656314231501; Mon, 27
 Jun 2022 00:17:11 -0700 (PDT)
MIME-Version: 1.0
References: <165515741424.1554877.9363755381201121213.stgit@warthog.procyon.org.uk>
 <165515742832.1554877.2073456606206090838.stgit@warthog.procyon.org.uk>
In-Reply-To: <165515742832.1554877.2073456606206090838.stgit@warthog.procyon.org.uk>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 27 Jun 2022 09:16:59 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWWtdoAwWo_qitV+s-3amxKzbVSDJ3f51E9fKT3MQwLAw@mail.gmail.com>
Message-ID: <CAMuHMdWWtdoAwWo_qitV+s-3amxKzbVSDJ3f51E9fKT3MQwLAw@mail.gmail.com>
Subject: Re: [PATCH 2/2] certs: Add FIPS selftests
To:     David Howells <dhowells@redhat.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Simo Sorce <simo@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Tue, Jun 14, 2022 at 12:29 AM David Howells <dhowells@redhat.com> wrote:
> Add some selftests for signature checking when FIPS mode is enabled.  These
> need to be done before we start actually using the signature checking for
> things and must panic the kernel upon failure.
>
> Note that the tests must not check the blacklist lest this provide a way to
> prevent a kernel from booting by installing a hash of a test key in the
> appropriate UEFI table.
>
> Reported-by: Simo Sorce <simo@redhat.com>
> Signed-off-by: David Howells <dhowells@redhat.com>

Thanks for your patch, which is now commit 3cde3174eb910513 ("certs:
Add FIPS selftests") in v5.19-rc4.

> --- a/crypto/asymmetric_keys/Kconfig
> +++ b/crypto/asymmetric_keys/Kconfig
> @@ -75,4 +75,14 @@ config SIGNED_PE_FILE_VERIFICATION
>           This option provides support for verifying the signature(s) on a
>           signed PE binary.
>
> +config FIPS_SIGNATURE_SELFTEST
> +       bool "Run FIPS selftests on the X.509+PKCS7 signature verification"

Is there any reason this cannot be tristate, so I can always enable
this as a module, and run the test by loading the module whenever
I want?

> +       help
> +         This option causes some selftests to be run on the signature
> +         verification code, using some built in data.  This is required
> +         for FIPS.
> +       depends on KEYS
> +       depends on ASYMMETRIC_KEY_TYPE
> +       depends on PKCS7_MESSAGE_PARSER
> +

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
