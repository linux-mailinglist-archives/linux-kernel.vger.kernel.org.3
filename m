Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9274556AF28
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 01:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236926AbiGGXuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 19:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236867AbiGGXux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 19:50:53 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D9360690
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 16:50:52 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id d16so22047052wrv.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 16:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=glYe1llh4n+rbmi4V6B2Mqs1aDtdgNFAYvpdpFFTObI=;
        b=hL30sFUur8jowhJ/PnVIbYIsyLpopzsMOvsJBK3DhwljDzNEAfLiR9YMt8eNiqru2W
         Y54TBRmud0yAxOtxKrcLM/lBEmBTPFfhqpTZIFKKQM1mRmnc9nsZZVBzUhRCxcINaNT7
         v/8K/xSA+GDMsuACrJfO52FIrnJ1U2utcwxAVwLQWCENk4GZMuFJGqBrBRYPF8PgwQWT
         flcbzln7ESjK/rGyUkAlbD7LrEZadmIibFx0/HZLekMcDHZA2hxa+bUoNCwkIJKzoja1
         SgSe8DD7E+tCYNP+18qYpSoTQd4xfrxRPPyfnGhE8Fyao6HYyWvtmC5+z4G6wjzAC9+k
         TBng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=glYe1llh4n+rbmi4V6B2Mqs1aDtdgNFAYvpdpFFTObI=;
        b=b8iaT4Q+OE1m83Ve4YvddQYbpyKULWHOSKiPuXVeCuYTUr8PJ6DBIquaOJZZewYuKR
         QiA3BaZEG41kpboS334aQNqtwku03JpQYmiZbtXiSnyzmijfEzGCxtNTiI7jrGlfTcKf
         DI85yIlpkknbuS1RTfUTUhSBRjabEsONooEaMRny91GyV3Lo6WVnJAhq0JAhWYcLsYx+
         K8VhnHbXQlh+TQZ7I22Ea7DChkQFhV7roDQGP4lfGwolhsxidnFNbV9al3iH2OgIDgxU
         AdwLXGYakbfc9P3uthAYDwXftg2om2qQHLHBCHMeeT+cyGVq/1SRN8TSvWntnXpVogxF
         /SUw==
X-Gm-Message-State: AJIora/B7WAzZ+KpxKEsRgbisTNXrBCk4BtA/6oCwVMRFi2TLAYnps2Q
        B44uU1k0NAvkjMNEE496ptw=
X-Google-Smtp-Source: AGRyM1sSdCcr35K5RyBzPf0V7hYBTlp5T0J5GxBVERguvefZ4eTGHoDCDnyXkLYFdwWiw6ZIHut4+w==
X-Received: by 2002:a5d:48cf:0:b0:210:1229:2e7 with SMTP id p15-20020a5d48cf000000b00210122902e7mr370752wrs.567.1657237850487;
        Thu, 07 Jul 2022 16:50:50 -0700 (PDT)
Received: from opensuse.localnet (host-79-53-109-127.retail.telecomitalia.it. [79.53.109.127])
        by smtp.gmail.com with ESMTPSA id p10-20020a05600c23ca00b003a2c67aa6c0sm348158wmb.23.2022.07.07.16.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 16:50:49 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH] kexec: Replace kmap() with kmap_local_page()
Date:   Fri, 08 Jul 2022 01:50:35 +0200
Message-ID: <3183776.44csPzL39Z@opensuse>
In-Reply-To: <20220707231412.1404-1-fmdefrancesco@gmail.com>
References: <20220707231412.1404-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On venerd=C3=AC 8 luglio 2022 01:14:12 CEST Fabio M. De Francesco wrote:
> The use of kmap() and kmap_atomic() are being deprecated in favor of
> kmap_local_page().
>=20
> With kmap_local_page(), the mappings are per thread, CPU local and not
> globally visible. Furthermore, the mappings can be acquired from any
> context (including interrupts).
>=20
> Therefore, use kmap_local_page() in kexec_core.c because these mappings=20
are
> per thread, CPU local, and not globally visible.
>=20
> Tested on a QEMU + KVM 32-bits VM booting a kernel with HIGHMEM64GB
> enabled.
>=20
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>=20
> v1->v2: A sentence of the commit message contained an error due to a
> mistake in copy-pasting from a previous patch. Replace "aio.c" with
> "kexec_core.c".
>=20
>  kernel/kexec_core.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
Sorry, another error... Please discard this patch because the version=20
number is missing in the subject.

The second version, hopefully final and correct, is at
https://lore.kernel.org/lkml/20220707231550.1484-1-fmdefrancesco@gmail.com/

Thank you,

=46abio



