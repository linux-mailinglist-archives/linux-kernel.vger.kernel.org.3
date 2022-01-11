Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D570F48BA91
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 23:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346041AbiAKWMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 17:12:51 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:45074 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345948AbiAKWMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 17:12:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4B988B81978;
        Tue, 11 Jan 2022 22:12:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3495C36AEF;
        Tue, 11 Jan 2022 22:12:46 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="IRNf5sZz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1641939164;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QilzNfGDRmDRCERQo32DMBDU3r8FZl3v461Jrz/2Jck=;
        b=IRNf5sZzo2CMy2qSK6pcwaL569f55KkjgHR9zV4ZVsxjA+UNlSiYmOvyrSjuYPA2QSk7CK
        NTFxLvPBKGV/WjnmmedcIqZJjFuQKrrtWoF6X9Y+W/NLxvx1LPkLmGTwG3zEvxD4OEhF36
        tIMf59jB7A76raXRmEUliELGtY4mnMQ=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ade38ccb (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 11 Jan 2022 22:12:44 +0000 (UTC)
Received: by mail-yb1-f180.google.com with SMTP id c10so1089315ybb.2;
        Tue, 11 Jan 2022 14:12:43 -0800 (PST)
X-Gm-Message-State: AOAM531YBBi9PrNxgSzZPjjChw6ToSD1/kD3t5WoZucOUnMBbTKxAdJ9
        nzniL/DtZXzdT1nUDOJs+b3j5RUYtoa7c/GuBeM=
X-Google-Smtp-Source: ABdhPJxSIJYbHPUrE8FxmkUFXvSYrpz9YEklHrphkd5FreYmyM3Az1bFANppzBGeGTslgwQOyDDC3fS6Au5kVXxKQSY=
X-Received: by 2002:a5b:10:: with SMTP id a16mr9213316ybp.115.1641939163116;
 Tue, 11 Jan 2022 14:12:43 -0800 (PST)
MIME-Version: 1.0
References: <20220111195309.634965-1-jforbes@fedoraproject.org>
In-Reply-To: <20220111195309.634965-1-jforbes@fedoraproject.org>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 11 Jan 2022 23:12:32 +0100
X-Gmail-Original-Message-ID: <CAHmME9pi1Y7urg1VQeCi7L6MxHRUk5g4wc6VKDywo4yPh9h_6w@mail.gmail.com>
Message-ID: <CAHmME9pi1Y7urg1VQeCi7L6MxHRUk5g4wc6VKDywo4yPh9h_6w@mail.gmail.com>
Subject: Re: [PATCH] lib/crypto: add prompts back to crypto libraries
To:     "Justin M. Forbes" <jforbes@fedoraproject.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, jmforbes@linuxtx.org,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Justin,

These are library variables, which means they really have no sense in
being user selectable. Internal things to the kernel depend on them,
or they don't. They're always only dependencies.

It sounds like CONFIG_BIG_KEYS might be declaring its dependencies
wrong, and that's actually where the bug is? CC'ing David Howells just
in case. Maybe things should be changed to:

diff --git a/security/keys/Kconfig b/security/keys/Kconfig
index 64b81abd087e..2f1624c9eed9 100644
--- a/security/keys/Kconfig
+++ b/security/keys/Kconfig
@@ -60,7 +60,7 @@ config BIG_KEYS
  bool "Large payload keys"
  depends on KEYS
  depends on TMPFS
- depends on CRYPTO_LIB_CHACHA20POLY1305 = y
+ select CRYPTO_LIB_CHACHA20POLY1305
  help
    This option provides support for holding large keys within the kernel
    (for example Kerberos ticket caches).  The data may be stored out to


Jason
