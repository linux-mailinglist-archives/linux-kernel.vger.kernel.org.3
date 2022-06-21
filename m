Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB0E552E92
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 11:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349195AbiFUJiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 05:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349141AbiFUJim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 05:38:42 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752442B8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 02:38:41 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id n1so17832419wrg.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 02:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wVV1kgkOYc9WD2BZGRnaDHVlgrSB3okEof8wTqZkR1Y=;
        b=rZwkqty8+yl9OrZL9JlyoCfL7zooS2eY/Dh9sqhZoaOQ3VqdUlrScC9JTtlQZhcCO8
         zddqt/E9pwIqysQ7Gcf/vRJ22yviQAA5F0wrki5+2RigggW3wmF5PnmXGM60elD59Aoz
         A1EJ64hATwMB2glD75lqdnP4wA1glmHnMRYBgK/wTmUhz4v59Xw4HGqcathzNBMVeNgY
         yiwkXx+Yyt5xzuYPmsczjE8J7YrChPqTPxfGwqg8/wqF+cUVBjjhr0Aiam1+P3c8tS97
         I8n0V2z/T6DXPGb7gE1irDe31c4UmEZPFH0mcPs7cSAc1LxHYnTDCDsdaG2dGZ+tHF3w
         DCWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wVV1kgkOYc9WD2BZGRnaDHVlgrSB3okEof8wTqZkR1Y=;
        b=GNXMOR2aEkcxu8xwUPSErbNPzGUQZFiY+7jMWLcO+BSUbXMgWbvfCMPAqBNdz5flyr
         CFRGFeEPKct7eHuK1K/0t0L2U5PmZr9RsuieUiRsxl4F1pngpP7EIwfcbJYJdBGwlK5k
         Cg4S8fimpF+LEzjNHCDu4ErrMc/TkwWzbJJlHMZX5wZ6fbD0FBJmSEOtFSYa74YsSM/N
         C8d6dTtODMLh9N5XTU/u9QHgCbMCnAHz8NPOGInUfs7LThSw692QT+OmMui+0w+p3xjh
         RYMLa/z0zagQiWn4xUt59fWk/6eFFdLHiA4Z5tsX6ItZarN6QfqJLA1Q3AdGiDij24Il
         7hYA==
X-Gm-Message-State: AJIora+fqaFTF+fsWHnbVSx84bNHFfF5JCUq4MGZNxFWuVtUtH3job5k
        VD6YRfmP2OZ0Lawu2wmUoVXj8Aipl773E6U3EiJWbg==
X-Google-Smtp-Source: AGRyM1tzhdoZDAzCVUfX8+RYfDzDgZ71KrhAad4YF+JMh5eFqeqZ2h6qbjnT+0eTSSpfS7NKk0J89gvdq3GRE7T9TSU=
X-Received: by 2002:a5d:570e:0:b0:21b:9610:2dd7 with SMTP id
 a14-20020a5d570e000000b0021b96102dd7mr3422861wrv.337.1655804319725; Tue, 21
 Jun 2022 02:38:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220620160640.3790-1-jose.exposito89@gmail.com> <20220620160640.3790-2-jose.exposito89@gmail.com>
In-Reply-To: <20220620160640.3790-2-jose.exposito89@gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 21 Jun 2022 17:38:28 +0800
Message-ID: <CABVgOSmPfxdcxuU6xtuT2sN75ivs+Atgmt=2PNcdWqnMcrnbEQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] drm/rect: Add DRM_RECT_INIT() macro
To:     =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Latypov <dlatypov@google.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        maarten.lankhorst@linux.intel.com,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        =?UTF-8?B?TWHDrXJhIENhbmFs?= <maira.canal@usp.br>,
        Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        tales.aparecida@gmail.com, dri-devel@lists.freedesktop.org,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jani Nikula <jani.nikula@intel.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000005335b705e1f1fcad"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000005335b705e1f1fcad
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 21, 2022 at 12:06 AM Jos=C3=A9 Exp=C3=B3sito
<jose.exposito89@gmail.com> wrote:
>
> Add a helper macro to initialize a rectangle from x, y, width and
> height information.
>
> Reviewed-by: Jani Nikula <jani.nikula@intel.com>
> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
> Signed-off-by: Jos=C3=A9 Exp=C3=B3sito <jose.exposito89@gmail.com>
> ---

This looks good to me, though I have one minor concern about the macro
name. (But if it's okay with the DRM folks, which it seems to be, I
won't object.)

Either way,
Reviewed-by: David Gow <davidgow@google.com>

>  include/drm/drm_rect.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/include/drm/drm_rect.h b/include/drm/drm_rect.h
> index 6f6e19bd4dac..e8d94fca2703 100644
> --- a/include/drm/drm_rect.h
> +++ b/include/drm/drm_rect.h
> @@ -47,6 +47,22 @@ struct drm_rect {
>         int x1, y1, x2, y2;
>  };
>
> +/**
> + * DRM_RECT_INIT - initialize a rectangle from x/y/w/h
> + * @x: x coordinate
> + * @y: y coordinate
> + * @w: width
> + * @h: height
> + *
> + * RETURNS:
> + * A new rectangle of the specified size.
> + */
> +#define DRM_RECT_INIT(x, y, w, h) ((struct drm_rect){ \
> +               .x1 =3D (x), \
> +               .y1 =3D (y), \
> +               .x2 =3D (x) + (w), \
> +               .y2 =3D (y) + (h) })
> +

My only slight concern here is that it might be a little bit confusing
that a macro called DRM_RECT_INIT() accepts x/y/w/h, whereas the
actual struct drm_rect is x1/y1/x2/y2. If the macro were called
something like DRM_RECT_INIT_FROM_XYWH() or similar.


>  /**
>   * DRM_RECT_FMT - printf string for &struct drm_rect
>   */
> --
> 2.25.1
>

--0000000000005335b705e1f1fcad
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPnwYJKoZIhvcNAQcCoIIPkDCCD4wCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggz5MIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
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
z/tQRXr3iPeVmZCr7nttMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQAx+EQjLATc/sze
VoZkH7OLz+/no1+y31x4BQ3wjW7lKfay9DAAVym896b7ECttSo95GEvS7pYMikzud57WypK7Bjpi
ep8YLarLRDrvyyvBuYtyDrIewkuASHtV1oy5E6QZZe2VOxMm6e2oJnFFjbflot4A08D3SwqDwV0i
OOYwT0BUtHYR/3903Dmdx5Alq+NDvUHDjozgo0f6oIkwDXT3yBV36utQ/jFisd36C8RD5mM+NFpu
3aqLXARRbKtxw29ErCwulof2dcAonG7cd5j+gmS84sLhKU+BhL1OQVXnJ5tj7xZ5Ri5I23brcwk0
lk/gWqfgs3ppT9Xk7zVit9q8MYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABh9LgIPnlfMFHR0Die8n7MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCB6
zf1rxXavYyPOZWnreseoyzAN7QOC+ObHzKsASfcEQTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjA2MjEwOTM4NDBaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAf/FzvCRC9xepfeZj+Anu
nJUoStIaZ1MtUTGwQXDyjcySHC3TPXwnWDGME2dHHQ56jpyxI7ZIr8tJXORJGYDN3BLnk3S+aKs2
6VGOdpUbHYfQa+gfFzDTbLBJFrHfWQc7xUl5TxP20bOnU5cpPVwQkkCYwmxwr34tLDaMKboRn7tY
QQcNGcuo01+yGXH7Jl1BiyIpYw4MxY6v4/DguPvqEkqiGBUwP5zyjhlP5Pq8MAfZhr4FDieUd9Gy
5HkjmDmQjbQrC3B8/zGNCkh3x3r6l98THHqj6h9cKrTstMuHf8faGIxDjqcvwPvVHe7bs9cC+9Nn
6FlgfeXYqpRQE/tlcQ==
--0000000000005335b705e1f1fcad--
