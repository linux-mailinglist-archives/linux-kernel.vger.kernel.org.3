Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D61CD4E9D15
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 19:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244197AbiC1RMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 13:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236364AbiC1RMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 13:12:01 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BEE47ADF;
        Mon, 28 Mar 2022 10:10:19 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a8so29980740ejc.8;
        Mon, 28 Mar 2022 10:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ofjd2BLbf/d57rh07u4nbPhNk5X3kqpA9oKVtxjKxc4=;
        b=RdJbBdxYbiTOUg5lxR0R+3/uOKZOUPBBpsyEkMPR8HHH3Wj7UmqQ0sxQA+kkEx92pP
         oce38WRh3IhgxR9b2W6uMT1D9+r/0P1SpUwYPi2tFx6GrEQmLX1anrY3S/AYbj7Tggei
         urziVxnW+ZtH9/qhxaj1Xfafl9l2o7GoXkfPeIu/Xrxf/85l/uuFuYCTIk25IxrCOnSl
         73TkmiNmg2xjWech/yEn3BCp7ycy20cfnr3ShHoF3LTMke99AY6KPD7ZeD84aEj8RaRE
         XlDOqkH9+eq5M3h4qYxL3A8KBiJfQ8dLHcCju/ft3Ymfl0LgwqHkDqEOpV+2ZzuUzFS3
         xZvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ofjd2BLbf/d57rh07u4nbPhNk5X3kqpA9oKVtxjKxc4=;
        b=5XtOtslrWyPCmnO/56yaLtlEO5nE3OFj6FjG+/h9RwCCxqo79VN52Mv2vK9IHdgifs
         8I1YSLKLo6EjgV6nZa72XwM8ZlhPkdQrKDpdbKk0FK/wSdxi2odlHHKSrYm8igM+VdBg
         l0L9yI+hadDTQ2G1v272Q/7sTBVeY/eet98YeX9A7vhUT4WhI/d7RlwdL0lzG2R0pEd5
         AuBd58OJMBRnMAzzqbjvDmlc84mZz2Ryd6uAA6PsHmccfpRzAQanKG2pd6cnimc+6VzL
         0pR7a62DlD1oljSPOQcLNOGbhPLXXmvfiaYkB/JvhZkhqMMpBN6EUMYN1+Pbsi02/WAT
         Tzxg==
X-Gm-Message-State: AOAM5333XHO5oNfl3hkthq1bW5T2aBwPhSUtxTbZN7xNYwInsHvE9MS2
        gRDNfyvihzvBievxyOCO9G7xIFAsWpQ=
X-Google-Smtp-Source: ABdhPJyqg4BdnBj4b8BiPKRMBVJOYfgoYQTkh+JHfQmfe8ltITzE2pv4VlnjsBwMAjCa2rMFVr44bw==
X-Received: by 2002:a17:907:728b:b0:6df:8f3b:28ae with SMTP id dt11-20020a170907728b00b006df8f3b28aemr28825891ejc.336.1648487417609;
        Mon, 28 Mar 2022 10:10:17 -0700 (PDT)
Received: from jernej-laptop.localnet (cpe-86-58-32-107.static.triera.net. [86.58.32.107])
        by smtp.gmail.com with ESMTPSA id j9-20020a170906534900b006df9b29eaf1sm6174022ejo.8.2022.03.28.10.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 10:10:16 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     linux-media@vger.kernel.org,
        Sebastian Fricke <sebastian.fricke@collabora.com>
Cc:     acourbot@chromium.org, tfiga@chromium.org,
        hverkuil-cisco@xs4all.nl,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chen-Yu Tsai <wens@csie.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Allwinner sunXi SoC support" 
        <linux-sunxi@lists.linux.dev>
Subject: Re: [RFC PATCH v3 1/2] media: docs-rst: Append HEVC specific term
Date:   Mon, 28 Mar 2022 19:10:15 +0200
Message-ID: <2095465.irdbgypaU6@jernej-laptop>
In-Reply-To: <20220327084308.9053-2-sebastian.fricke@collabora.com>
References: <20220327084308.9053-1-sebastian.fricke@collabora.com> <20220327084308.9053-2-sebastian.fricke@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne nedelja, 27. marec 2022 ob 10:43:08 CEST je Sebastian Fricke napisal(a):
> Describe the coding tree unit as replacement for the macroblock in the
> HEVC codec. Highlight a key difference of the HEVC codec to predecessors
> like AVC(H.264) to give a better overview of the differences between the
> coding standards.
>=20

Looks good to me.

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
> ---
>  Documentation/userspace-api/media/v4l/dev-decoder.rst | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/userspace-api/media/v4l/dev-decoder.rst
> b/Documentation/userspace-api/media/v4l/dev-decoder.rst index
> 3cf2b496f2d0..eb5b1b1e3a51 100644
> --- a/Documentation/userspace-api/media/v4l/dev-decoder.rst
> +++ b/Documentation/userspace-api/media/v4l/dev-decoder.rst
> @@ -72,6 +72,11 @@ coded resolution
>  coded width
>     width for given coded resolution.
>=20
> +coding tree unit
> +   processing unit of the HEVC codec (=E2=89=98 macroblock units in H.26=
4, VP8,
> VP9); +   can use block structures of up to 64=C3=9764 pixels;
> +   Good at sub-partitioning the picture into variable sized structures.
> +
>  decode order
>     the order in which frames are decoded; may differ from display order =
if
> the coded format includes a feature of frame reordering; for decoders, @@
> -104,7 +109,8 @@ keyframe
>  macroblock
>     a processing unit in image and video compression formats based on lin=
ear
> block transforms (e.g. H.264, VP8, VP9); codec-specific, but for most of =
=2D=20
>  popular codecs the size is 16x16 samples (pixels).
> +   popular codecs the size is 16x16 samples (pixels). The HEVC codec use=
s a
> +   slightly more flexible processing unit called coding tree unit (CTU).
>=20
>  OUTPUT
>     the source buffer queue; for decoders, the queue of buffers containing




