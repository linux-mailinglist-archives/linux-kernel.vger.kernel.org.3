Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8350A5367E0
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 22:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350809AbiE0UGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 16:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350757AbiE0UF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 16:05:56 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A133E473AD
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 13:05:53 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id j14so4803623qvo.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 13:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=g+pQqkTih63Ty7gF/Ucw70pNIC+bNdQYXn1gaDTT7SA=;
        b=WlnE80aTu92PLPbZ8osuq8WBerY2I3HSbhRn+z867J97rIIA85Ry4iA5BpjdmP00ex
         wxzSChNoikfGwEZ1dj67BEwk8h7YmPKgmOw5XbozDe9A07ZOUzv/MZkfkNmxsbWG+CA0
         QyTVH8LCridQvqfaQcmLtlO55WfXw7Tv6lpe3S4/0IGxKnZrKLFHSE/5KG3EXT3uGiLx
         8/UZFkE+xtpFJnSO/d44ROEE9E5VRl/GSgJofucWRmxZ7/SDt6WipmFuFNss+EtaW2LP
         Q9IN7CMbhA+MCr+dqBoOh4O+xFe9mNhR3y+J7ISHF1sxajfMZu8awUL8CvsQKrIHgrzZ
         SjdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=g+pQqkTih63Ty7gF/Ucw70pNIC+bNdQYXn1gaDTT7SA=;
        b=S7UdauTPafmbGf0nYlHEKnxxTQy4gkOxiCiznp5VCG4kwH7mdv7RXoioUnw1DwKTkA
         4CX/xKQ8UPmCptxsSfnwXuOqVXAQTfMAk8tLYoh9zaC+EJ6qGgH8UWch/aTYXBAXpdRm
         YL9YM7SNb6Ic51J9gDGIE6qW22JuPcbovxk2Oh+8V3Bx0czcHezxHbvNX6aoZwRX0Hl7
         5nv3KkW4s5dp3l2GmeBjfZHz6rnjWzg/5I1Jh0qq1uksgszbyKIGBWDVhiHyW/cuBTsN
         cKFCLYuQkK1bfy1oDBufmlYRR/8h4gVe4gXKXshCdLkOhH3ZIvtNtkUpKId07ow3rJad
         2bDg==
X-Gm-Message-State: AOAM532zCAlKC4kINHxqH3srr6Ngfyus7TA1EnAjB6L6MmuTUov0QdYf
        SIJw9JvFXwoJHlh9zSRyTfxWyQ==
X-Google-Smtp-Source: ABdhPJypfwKyW9QIJgtPwkcsv3L6wbUSugzXr5toVyTpByWMXC9eJMXmJf8swe/WfITuwBOtB1P+8A==
X-Received: by 2002:ad4:5944:0:b0:462:310a:b54c with SMTP id eo4-20020ad45944000000b00462310ab54cmr24814360qvb.41.1653681952811;
        Fri, 27 May 2022 13:05:52 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net. [192.222.136.102])
        by smtp.gmail.com with ESMTPSA id k25-20020ac84759000000b002fcb0d95f65sm2425544qtp.90.2022.05.27.13.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 13:05:52 -0700 (PDT)
Message-ID: <fd8c9ef48b48e014c468fe8cf61cd44062d14b1d.camel@ndufresne.ca>
Subject: Re: [PATCH v2] media: Hantro: Correct G2 init qp field
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Date:   Fri, 27 May 2022 16:05:51 -0400
In-Reply-To: <20220524115945.2294015-1-benjamin.gaignard@collabora.com>
References: <20220524115945.2294015-1-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 (3.44.1-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 24 mai 2022 =C3=A0 13:59 +0200, Benjamin Gaignard a =C3=A9crit=C2=
=A0:
> Documentation said that g2 init_qp field use bits 24 to 30 of
> the 8th register.
> Change the field mask to be able to set 7 bits and not only 6 of them.
>=20
> Conformance test INITQP_B_Main10_Sony_1 decoding is OK with this
> patch.
>=20
> Fixes: cb5dd5a0fa518 ("media: hantro: Introduce G2/HEVC decoder")
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

> ---
> With this patch and the patches needed for 10-bit support
> Fluster HEVC score is 137/147
>=20
> version 2:
> - Add Fixes tag
>=20
>  drivers/staging/media/hantro/hantro_g2_regs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/staging/media/hantro/hantro_g2_regs.h b/drivers/stag=
ing/media/hantro/hantro_g2_regs.h
> index 877d663a8181..82606783591a 100644
> --- a/drivers/staging/media/hantro/hantro_g2_regs.h
> +++ b/drivers/staging/media/hantro/hantro_g2_regs.h
> @@ -107,7 +107,7 @@
> =20
>  #define g2_start_code_e		G2_DEC_REG(10, 31, 0x1)
>  #define g2_init_qp_old		G2_DEC_REG(10, 25, 0x3f)
> -#define g2_init_qp		G2_DEC_REG(10, 24, 0x3f)
> +#define g2_init_qp		G2_DEC_REG(10, 24, 0x7f)
>  #define g2_num_tile_cols_old	G2_DEC_REG(10, 20, 0x1f)
>  #define g2_num_tile_cols	G2_DEC_REG(10, 19, 0x1f)
>  #define g2_num_tile_rows_old	G2_DEC_REG(10, 15, 0x1f)

