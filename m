Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C821448C596
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 15:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353996AbiALOFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 09:05:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353943AbiALOFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 09:05:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2150BC061748;
        Wed, 12 Jan 2022 06:05:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DB091B81EF6;
        Wed, 12 Jan 2022 14:05:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51AF9C36AEF;
        Wed, 12 Jan 2022 14:05:09 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="caioy3LT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1641996306;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yeqrs8v3/DYTIkWozjlwuXDXXoy/2Ww8WnjaBFkw+ss=;
        b=caioy3LTVYOSCnVU2ZMHE8LBFZoGBSFRK31SChRkPbMrS5oiyowLMP8vzYYyW7teh+eqFY
        P+z+cX6c2pVvXxc04r4caXPFkAnC6EulCj1PE61bYitTio18oQhTWjDxdRBexqWHYgxFdd
        VD89gisAOgqVuiLlGDYJJLYGskwx11Y=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id f5f6edc1 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 12 Jan 2022 14:05:06 +0000 (UTC)
Received: by mail-yb1-f173.google.com with SMTP id p187so6807102ybc.0;
        Wed, 12 Jan 2022 06:05:06 -0800 (PST)
X-Gm-Message-State: AOAM533csq2s6D7afAT8gsfPXfDBVgbKq7T7VfdAzPtvuEYvJCx06/qs
        HaLojTDNSqHBxixDp/DTcUu9NHoqTrt8pDgwEOg=
X-Google-Smtp-Source: ABdhPJyXCQpyw1eHvot1kcJXnSSnxqoLIdJzUee/HnnoyKxBgUP2kxPlxfka5sW7alITBQW+MiFw+KwILjdYdmXgzYI=
X-Received: by 2002:a25:a0c4:: with SMTP id i4mr13085139ybm.457.1641996305161;
 Wed, 12 Jan 2022 06:05:05 -0800 (PST)
MIME-Version: 1.0
References: <20220112140137.728162-1-jforbes@fedoraproject.org>
In-Reply-To: <20220112140137.728162-1-jforbes@fedoraproject.org>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 12 Jan 2022 15:04:54 +0100
X-Gmail-Original-Message-ID: <CAHmME9rJFVeWL=SFTkM8=+2te_GnH4n-THH+F3p5mnHfCkhZ4w@mail.gmail.com>
Message-ID: <CAHmME9rJFVeWL=SFTkM8=+2te_GnH4n-THH+F3p5mnHfCkhZ4w@mail.gmail.com>
Subject: Re: [PATCH v2] lib/crypto: add prompts back to crypto libraries
To:     "Justin M. Forbes" <jforbes@fedoraproject.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Justin Forbes <jmforbes@linuxtx.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit also needs this snippet:

diff --git a/crypto/Kconfig b/crypto/Kconfig
index 94bfa32cc6a1..442765219c37 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -1928,5 +1928,3 @@ source "crypto/asymmetric_keys/Kconfig"
 source "certs/Kconfig"

 endif # if CRYPTO
-
-source "lib/crypto/Kconfig"
diff --git a/lib/Kconfig b/lib/Kconfig
index 655b0e43f260..c20b68ad2bc3 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -122,6 +122,8 @@ config INDIRECT_IOMEM_FALLBACK
    mmio accesses when the IO memory address is not a registered
    emulated region.

+source "lib/crypto/Kconfig"
+
 config CRC_CCITT
  tristate "CRC-CCITT functions"
  help
