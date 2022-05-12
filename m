Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D074A524E0E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 15:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354264AbiELNST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 09:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353446AbiELNSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 09:18:16 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589E12469D9
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 06:18:15 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id k2so4263903qtp.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 06:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=cTkGwPerGEuuefQRyIQ0C0XC2b11aBGuK5X4ENeMGuU=;
        b=MD1s+3cy4Ph7S6Istxggt/fum+J6xKJdI4OlN64yZTuxpLiC+LwdAry8NCO5Tj0wNr
         gHZCg+hbSfWU7vbeLZpHI4SLsmpdro7VzSiis/HV4bfFI8l/aeXTUkJNu88JxEO4EcuS
         5ZBQ31mrUTfaM1Z5Sfb4L0jX7gfhmDM4/jTwXpRQvOlsZPV/FntftA21xaU4jArSLA1E
         EhstExel8X8v+Ppc5G/TsHfVUfg92larRjQ/785XagGlAzz3HYcmvhadsy5jZSe/IE6C
         0OTKdivOoTqglL8KcLGZ7i6xuOtEw7AVMxbbreUQ+KYXrtEsojxCEkx64dsCLrEdNX/g
         Cn/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=cTkGwPerGEuuefQRyIQ0C0XC2b11aBGuK5X4ENeMGuU=;
        b=avwkuMPZa2iSMNDzSl+wxyC2xETMKPUxWeKtGL6O3LEPX/DsDPMicTjBweuV26tnQS
         kgdtp/uVJg5UlNJJg7hd28ZzLLaCDYhVm6LiULsKsYmYJuUugipnGV3Wl13UUkYSd2gu
         ym82BPa6ZZUY+WMY57ystlDK2G74LlxgVAhYR6GvhrP8L2UzGBry3gT1OUQXE8UwIu2T
         gjeZ9rNPTDoGJoSjoZPU/DlEHeq6KbFiP7dTFaRLhArXsPRDR7s9FxTSztwSC/d3CwWz
         N9kOKhqGuLL3gZnJxB4Z4/nsf5xGqC7QewI7O2BNyQGPoctxR2oOF3fvKdgN/4CofN/e
         yA8Q==
X-Gm-Message-State: AOAM532DF6Zi9p646Sawfp8XwR52c0oRrXzUDXI55eZNeAX5LigqrkED
        MDLYUo1FERUfs2BDxromZR+RzQ==
X-Google-Smtp-Source: ABdhPJyVI6QPETI9Ycy3zyEscN13LinUz5LpVyQNYJo6d1+/MZP6zee0O4s9N6TPbRbDvNMccvmbBQ==
X-Received: by 2002:ac8:7f0a:0:b0:2f3:ec89:ee23 with SMTP id f10-20020ac87f0a000000b002f3ec89ee23mr9704610qtk.448.1652361494481;
        Thu, 12 May 2022 06:18:14 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (173-246-12-168.qc.cable.ebox.net. [173.246.12.168])
        by smtp.gmail.com with ESMTPSA id h7-20020a05620a10a700b0069fc13ce23csm2850213qkk.109.2022.05.12.06.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 06:18:14 -0700 (PDT)
Message-ID: <81383d8cc351bdd1556ef674afe7f787f8a768ff.camel@ndufresne.ca>
Subject: Re: [PATCH v1 4/5] media: Add HEXTILE compressed format
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Marvin Lin <milkfafa@gmail.com>, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     openbmc@lists.ozlabs.org, avifishman70@gmail.com,
        tmaimon77@gmail.com, tali.perry1@gmail.com, kwliu@nuvoton.com,
        kflin@nuvoton.com
Date:   Thu, 12 May 2022 09:18:12 -0400
In-Reply-To: <20220512072722.25005-5-kflin@nuvoton.com>
References: <20220512072722.25005-1-kflin@nuvoton.com>
         <20220512072722.25005-5-kflin@nuvoton.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.0 (3.44.0-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Marvin,

Le jeudi 12 mai 2022 =C3=A0 15:27 +0800, Marvin Lin a =C3=A9crit=C2=A0:
> Add HEXTILE compressed format. This format is defined in Remote
> Framebuffer Protocol (RFC 6143) and is used by VNC features.
>=20
> Signed-off-by: Marvin Lin <kflin@nuvoton.com>
> ---
>  drivers/media/v4l2-core/v4l2-ioctl.c | 1 +
>  include/uapi/linux/videodev2.h       | 1 +
>  2 files changed, 2 insertions(+)
>=20
> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-co=
re/v4l2-ioctl.c
> index 96e307fe3aab..9365519d65bb 100644
> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> @@ -1441,6 +1441,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *f=
mt)
>  		case V4L2_PIX_FMT_SE401:	descr =3D "GSPCA SE401"; break;
>  		case V4L2_PIX_FMT_S5C_UYVY_JPG:	descr =3D "S5C73MX interleaved UYVY/JP=
EG"; break;
>  		case V4L2_PIX_FMT_MT21C:	descr =3D "Mediatek Compressed Format"; break=
;
> +		case V4L2_PIX_FMT_HEXTILE:	descr =3D "Hextile Compressed Format"; brea=
k;
>  		default:
>  			if (fmt->description[0])
>  				return;
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev=
2.h
> index 3768a0a80830..e0e69f71d700 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -710,6 +710,7 @@ struct v4l2_pix_format {
>  #define V4L2_PIX_FMT_FWHT     v4l2_fourcc('F', 'W', 'H', 'T') /* Fast Wa=
lsh Hadamard Transform (vicodec) */
>  #define V4L2_PIX_FMT_FWHT_STATELESS     v4l2_fourcc('S', 'F', 'W', 'H') =
/* Stateless FWHT (vicodec) */
>  #define V4L2_PIX_FMT_H264_SLICE v4l2_fourcc('S', '2', '6', '4') /* H264 =
parsed slices */
> +#define V4L2_PIX_FMT_HEXTILE  v4l2_fourcc('H', 'X', 'T', 'L') /* Hextile=
 */

New formats also need to be documented in one of=20
Documentation/userspace-api/media/v4l/pixfmt*.rst file. Consider that forma=
ts,
specially vendor formats disappears over time, so documentation should be
written as if you are to read that in 10+ years.

I'm also wondering if that should be better located with the "vendor" forma=
ts.=20
Specially that this does not look like a open standard like the other in th=
is
section. A quick search of that format simply gives no results for me. It s=
eems
pretty clear that this is unique to this HW vendor and unlikely to grow wit=
hing
other HW or even ever get a software implementation.
> =20
>  /*  Vendor-specific formats   */
>  #define V4L2_PIX_FMT_CPIA1    v4l2_fourcc('C', 'P', 'I', 'A') /* cpia1 Y=
UV */

