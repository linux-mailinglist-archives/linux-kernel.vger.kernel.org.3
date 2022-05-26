Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F00BA534F49
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 14:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244556AbiEZMgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 08:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233899AbiEZMgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 08:36:35 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A523ABF5D
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 05:36:33 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id z11so1632510pjc.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 05:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pY4qCEMlcn8sdqN9o7uAGxAaJ9tUnjQmk4ekV4UO6HQ=;
        b=Mp58j2c3jmkkxJNgqE3o4QdMeh3n+3IYER8c353fYHVyncmUeM5QT3iUsu2EOUiM1G
         H5HzysDPjuHmtv2FQ2GSUNp269c0czabAAPu3qmLLkNiefIcRs9WbWk+13XaNKa9p1IA
         0+oFXBusMsGOtLMKEjeS1cg1t9SxqL3hi1uVdere7PO27GuJo36aJ3juXg96Zlmy3MAw
         4oRVrFd4NI54P/ogZcnUALv8uBRzMfAmVPdIKisf4XTr9avfcIcCxfQcn/XRj4QJOf//
         4bW4T0zWbeMD9Ani7/kBTIrXYFaEtr+yTqUsOSCCQ5VdYy5b2eNF/BLNQqkYAV2TTC/N
         tlHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pY4qCEMlcn8sdqN9o7uAGxAaJ9tUnjQmk4ekV4UO6HQ=;
        b=g3wElpW2OPd89dNY28q1wkNjTNZj6KpIPyY1pM1frGIu40I250+y7eqlr8+acxq0YS
         I5Xcu8Dk/IZmBNSoAZt609pgEnm2TKlKCSUzQ/V/B1xvX2ftxrJ4tzL5Rb2CfIoUi0hV
         ioCaTlYEEwxNGvDjaY64A76/EzCzYWjYE8pY4tRqXLI3B7UK8iSfoNBSF21OkJ0GAC8m
         reMGQAdbBPluQdUocEsBozA11zUrghZa0l+cPzxEZiW8nn9zTKSfa7coeTgcP1i++E8U
         S0+B8pIS0FYFbn48ixLfTyV97RLROVxszwqtxYoqy2l3+eIR4B4iNf/Op+pkMLpxE9jW
         srLQ==
X-Gm-Message-State: AOAM533ltD077MeYogFVzznwoabS9fwIXzI2EbSgMCAF7ev3CIjjzzAn
        NoJa7yBbDSnmECGahCi/fZhUVTVlv08MuMO4TckFwg==
X-Google-Smtp-Source: ABdhPJymrGdw71TCK2V0oz538Ig3kuxGWcKjmEvRjXWfvWUPmHiJY5Qg+JAM+o5WEKaPJP8+2ZyQ777+dyl1Dqzn6ks=
X-Received: by 2002:a17:902:8f81:b0:161:f4a7:f2fc with SMTP id
 z1-20020a1709028f8100b00161f4a7f2fcmr30779133plo.117.1653568593119; Thu, 26
 May 2022 05:36:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220522162802.208275-1-luca@z3ntu.xyz> <20220522162802.208275-4-luca@z3ntu.xyz>
In-Reply-To: <20220522162802.208275-4-luca@z3ntu.xyz>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Thu, 26 May 2022 14:36:21 +0200
Message-ID: <CAG3jFysz_BisbjDgyVBmfAbKUukvG4H8GpxJF1fOw2ZqQ5HQ=w@mail.gmail.com>
Subject: Re: [RFC PATCH 03/14] media: camss: vfe: Add support for 8x74
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Loic Poulain <loic.poulain@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Todor Tomov <todor.too@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        matti.lehtimaki@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 May 2022 at 18:28, Luca Weiss <luca@z3ntu.xyz> wrote:
>
> From: Matti Lehtim=C3=A4ki <matti.lehtimaki@gmail.com>
>
> VFE hardware modules on 8x74 and 8x16 are similar.
>
> Signed-off-by: Matti Lehtim=C3=A4ki <matti.lehtimaki@gmail.com>
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
>  drivers/media/platform/qcom/camss/camss-vfe.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c b/drivers/medi=
a/platform/qcom/camss/camss-vfe.c
> index 5b148e9f8134..ace53ed24884 100644
> --- a/drivers/media/platform/qcom/camss/camss-vfe.c
> +++ b/drivers/media/platform/qcom/camss/camss-vfe.c
> @@ -170,7 +170,8 @@ static u32 vfe_src_pad_code(struct vfe_line *line, u3=
2 sink_code,
>  {
>         struct vfe_device *vfe =3D to_vfe(line);
>
> -       if (vfe->camss->version =3D=3D CAMSS_8x16)
> +       if (vfe->camss->version =3D=3D CAMSS_8x16 ||
> +               vfe->camss->version =3D=3D CAMSS_8x74)

Match indentation of previous line.

CHECK: Alignment should match open parenthesis
#27: FILE: drivers/media/platform/qcom/camss/camss-vfe.c:174:
+    if (vfe->camss->version =3D=3D CAMSS_8x16 ||
+        vfe->camss->version =3D=3D CAMSS_8x74)

>                 switch (sink_code) {
>                 case MEDIA_BUS_FMT_YUYV8_2X8:
>                 {
> @@ -1286,6 +1287,7 @@ int msm_vfe_subdev_init(struct camss *camss, struct=
 vfe_device *vfe,
>
>         switch (camss->version) {
>         case CAMSS_8x16:
> +       case CAMSS_8x74:
>                 vfe->ops =3D &vfe_ops_4_1;
>                 break;
>         case CAMSS_8x96:
> @@ -1390,7 +1392,8 @@ int msm_vfe_subdev_init(struct camss *camss, struct=
 vfe_device *vfe,
>                 init_completion(&l->output.sof);
>                 init_completion(&l->output.reg_update);
>
> -               if (camss->version =3D=3D CAMSS_8x16) {
> +               if (camss->version =3D=3D CAMSS_8x16 ||
> +                       camss->version =3D=3D CAMSS_8x74) {

Same

>                         if (i =3D=3D VFE_LINE_PIX) {
>                                 l->formats =3D formats_pix_8x16;
>                                 l->nformats =3D ARRAY_SIZE(formats_pix_8x=
16);
> --
> 2.36.0
>

With that fixed:
Reviewed-by: Robert Foss <robert.foss@linaro.org>
