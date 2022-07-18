Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87034578907
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 19:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233519AbiGRR6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 13:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234628AbiGRR56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 13:57:58 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43CA52E9E7;
        Mon, 18 Jul 2022 10:57:54 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id b11so22672342eju.10;
        Mon, 18 Jul 2022 10:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7pbvqadJLQpegf3D+q21OLRSwQXILX31lmjWX8Hj/GY=;
        b=b5g1vKxnKuvfgRtkVJm2ZXoQeRwcrMtRwhAUX6uZINrXGcu1pchJpyVw/M+Hd96mMW
         hBnhrH90clc05gcS5xguvYuXAGGVTRgb2MtagArPyUBzQMXRRTF3+UeTrgm5aQtc7WH0
         gpM0cb86dwOJgcVLHBYBFb3coPCCRYdQMlM1aTMCSDyWF/nXhz45jInNoMz6EDG3RACh
         /JvFVFUV/xzYNrwmkgRUVSv84j7TfdAn2jVQLe+Y47YxLRDolNTtKYG/JXv4pVdxudRt
         ogFPFLbj7UZm55bLbrKLKcXoWIwCYWfPAYISmktzpu6AHpzo/yhByLrn7csRxF7QmJhE
         5qEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7pbvqadJLQpegf3D+q21OLRSwQXILX31lmjWX8Hj/GY=;
        b=Bishnu8rAerLYbCNlIVnBef3jiqxCVLi84qq+0sd+nXejaBUqf5h2ru0CYyqAWcJd4
         u/mAG0MBQ1rjADVOI39ABVYoDx+xxHi8z08xyhRU1CToZUy73I5z2sJOkqMXDSzya32L
         V3PQQEwkVuHOKtGjdJjSTVRow+1e1d+v/CTS/q6mWSW/yCVRUh2wBV/qyiOJz/Cw1h6e
         XZfTsLbsfOrFRd8jVLjw+7tk6SvblvlhBxPFEgaq7tefSauJucRJVf385J5nNNx7jhDV
         cIr/2QdXwcCKfwdwbOsMiucRWcPi9GVDuJGOGzn07um35JIoqxyTadpPFWObrC0osGf7
         0RXA==
X-Gm-Message-State: AJIora/WcbPuAt/Wo5b9G9WuSSDJWHrq/UaZZFGtsEbZurKo8ZVGkHyS
        9+iDgvPXQKwZExH5YDY5nHE=
X-Google-Smtp-Source: AGRyM1s2xe9DqszGwO+egWgTy28gEFT166qISo4hJQn4LN8S+JzN/Y/mXSMgNsQz/8KSTLeTxLt8gw==
X-Received: by 2002:a17:906:58c9:b0:72f:4646:1f6f with SMTP id e9-20020a17090658c900b0072f46461f6fmr2253952ejs.181.1658167072750;
        Mon, 18 Jul 2022 10:57:52 -0700 (PDT)
Received: from kista.localnet (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id eg52-20020a05640228b400b0043a6fde6e7bsm8823482edb.19.2022.07.18.10.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 10:57:51 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, paul.kocialkowski@bootlin.com,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc:     mchehab@kernel.org, gregkh@linuxfoundation.org, wens@csie.org,
        samuel@sholland.org, hverkuil-cisco@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] media: cedrus: hevc: Add check for invalid timestamp
Date:   Mon, 18 Jul 2022 19:57:49 +0200
Message-ID: <4725382.GXAFRqVoOG@kista>
In-Reply-To: <d58e8624e9703e5dbbc54908aa142d10ef7f5a22.camel@collabora.com>
References: <20220718165649.16407-1-jernej.skrabec@gmail.com> <d58e8624e9703e5dbbc54908aa142d10ef7f5a22.camel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne ponedeljek, 18. julij 2022 ob 19:41:48 CEST je Nicolas Dufresne=20
napisal(a):
> Le lundi 18 juillet 2022 =E0 18:56 +0200, Jernej Skrabec a =E9crit :
> > Not all DPB entries will be used most of the time. Unused entries will
> > thus have invalid timestamps. They will produce negative buffer index
> > which is not specifically handled. This works just by chance in current
> > code. It will even produce bogus pointer, but since it's not used, it
> > won't do any harm.
> >=20
> > Let's fix that brittle design by skipping writing DPB entry altogether
> > if timestamp is invalid.
> >=20
> > Fixes: 86caab29da78 ("media: cedrus: Add HEVC/H.265 decoding support")
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> > ---
> >=20
> >  drivers/staging/media/sunxi/cedrus/cedrus_h265.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >=20
> > diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
> > b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c index
> > 1afc6797d806..687f87598f78 100644
> > --- a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
> > +++ b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
> > @@ -147,6 +147,9 @@ static void cedrus_h265_frame_info_write_dpb(struct
> > cedrus_ctx *ctx,>=20
> >  			dpb[i].pic_order_cnt_val
> >  	=09
> >  		};
> >=20
> > +		if (buffer_index < 0)
> > +			continue;
>=20
> When I compare to other codecs, when the buffer_index does not exist, the
> addr 0 is being programmed into the HW. With this implementation is is le=
ft
> to whatever it was set for the previous decode operation. I think its is
> nicer done the other way.

It's done the same way as it's done in vendor lib. As I stated in commit=20
message, actual values don't matter for unused entries. If it is used by=20
accident, HW reaction on all zero pointers can only be worse than using old=
,=20
but valid entry.

Due to no real documentation and Allwinner unwillingness to share details,=
=20
we'll probably never know what's best response for each error. Some things =
can=20
be deduced from vendor code, but not all.

I would rather not complicate this fix, especially since it's candidate for=
=20
backporting.

Best regards,
Jernej

>=20
> > +
> >=20
> >  		cedrus_h265_frame_info_write_single(ctx, i,=20
dpb[i].field_pic,
> >  	=09
> >  						   =20
pic_order_cnt,
> >  						   =20
buffer_index);


