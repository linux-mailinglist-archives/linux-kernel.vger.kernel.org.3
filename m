Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE5C55969A2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 08:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238698AbiHQGgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 02:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiHQGga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 02:36:30 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9CB478214
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 23:36:28 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id q190so12283704vsb.7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 23:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Gane40RURngVQLoDoqCg9UTbqZ8wEfrOMwLndEi9q3A=;
        b=HRvqcFqQHF8F6Z4/H7vkuBarGMAVTqsDaZ3xXmIaaCfOacRKG28WtFDw8QHPFW2Au7
         Q19lHUFoEgmiar02s8s9O7mk11YOE5/gqEBT84T1gMOujbh2ENQ7xcqi2R8Mb4uWrEs2
         RyFiiNIMScIqH6lG8bu9koJIiEwt0EOqA+QckoKJqOVBh2wTtRqnNjGNhHghfqwaJsJR
         C/dQHmYPJ3lyu5jR1hA/y0BMxuvdkLn+udBFSSTBHlDqfa+gat9PVJgr5HzoD27NJkOC
         6MFUZP4gP/23bNxIMTk1UpabM2H2CELH8uqci5wiUl7V+XRmSVuIrGQ8BUN0IXdITdV+
         394w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Gane40RURngVQLoDoqCg9UTbqZ8wEfrOMwLndEi9q3A=;
        b=3rVY2UrkxA1+4xX4trv/0RKBGBubufs7nqxftNpteIiOJgTbSKncYXRoYapjsRkEa8
         C4AiujdgU+qZyVWBtt6GjgYjPsFYK3youzov48CC7xctj494YwtsQz3t4jnYZIAgDmRR
         QvTiy9ymt7zlMcsrNIPSlW09tagm9LoSTW8sk/lzZ5S0TWlx9Qtda243tprTUdiat8hK
         GGd8b809oKPzO8M7Bk1xFZS/l3Mi1+5Ci+lbO0oqSHGYa6py+jxEyquW7s4cOskdUHpg
         NlL219N98DU6JvMTo3eqi1fR3NzIV4evKpBu+SG7jotStsTjiTk2EXTG4gAHmHqcCiOx
         FzzQ==
X-Gm-Message-State: ACgBeo2yhkjnojehPRmO168Xaw33DvsYkgSKV+BYTKb2wHZ4c1dLsOZj
        ShdWAmrT3KbV6uMbXKJHfnJ1n3CXNWmcj1V77ns5YQ==
X-Google-Smtp-Source: AA6agR57ZdVtvUBcTZYAHL8yC/KjSc6fYGOGOVdjx63Fkz00KeVDo7dAOzSZpILgl8z03Ra9Wfcca6pvsRYP4l4tVe8=
X-Received: by 2002:a67:fdce:0:b0:388:485c:889c with SMTP id
 l14-20020a67fdce000000b00388485c889cmr9421404vsq.38.1660718187865; Tue, 16
 Aug 2022 23:36:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220816102903.276879-1-jose.exposito89@gmail.com> <20220816102903.276879-3-jose.exposito89@gmail.com>
In-Reply-To: <20220816102903.276879-3-jose.exposito89@gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Wed, 17 Aug 2022 14:36:15 +0800
Message-ID: <CABVgOSnx+RdWWeoNGJE8ReN5HcHpWqN7jU0Oqa9JxWcyLES37A@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/format-helper: Add KUnit tests for drm_fb_xrgb8888_to_xrgb2101010()
To:     =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Latypov <dlatypov@google.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        =?UTF-8?B?TWHDrXJhIENhbmFs?= <maira.canal@usp.br>,
        Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        Tales Aparecida <tales.aparecida@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        dri-devel@lists.freedesktop.org,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000aded9a05e66a15e9"
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

--000000000000aded9a05e66a15e9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 16, 2022 at 6:29 PM Jos=C3=A9 Exp=C3=B3sito <jose.exposito89@gm=
ail.com> wrote:
>
> Extend the existing test cases to test the conversion from XRGB8888 to
> XRGB2101010.
>
> Signed-off-by: Jos=C3=A9 Exp=C3=B3sito <jose.exposito89@gmail.com>
> ---

This looks good.

Again, it'd be nice to use KUNIT_EXPECT_MEMEQ() when it's available,
but if you don't want to add a dependency on that patchset now,
keeping it as-is in this patch and fixing it later is also fine.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  .../gpu/drm/tests/drm_format_helper_test.c    | 63 +++++++++++++++++++
>  1 file changed, 63 insertions(+)
>
> diff --git a/drivers/gpu/drm/tests/drm_format_helper_test.c b/drivers/gpu=
/drm/tests/drm_format_helper_test.c
> index 08d08e7ab19a..d8536db4de1e 100644
> --- a/drivers/gpu/drm/tests/drm_format_helper_test.c
> +++ b/drivers/gpu/drm/tests/drm_format_helper_test.c
> @@ -32,6 +32,11 @@ struct convert_to_rgb888_result {
>         const u8 expected[TEST_BUF_SIZE];
>  };
>
> +struct convert_to_xrgb2101010_result {
> +       unsigned int dst_pitch;
> +       const u32 expected[TEST_BUF_SIZE];
> +};
> +
>  struct convert_xrgb8888_case {
>         const char *name;
>         unsigned int pitch;
> @@ -40,6 +45,7 @@ struct convert_xrgb8888_case {
>         struct convert_to_rgb332_result rgb332_result;
>         struct convert_to_rgb565_result rgb565_result;
>         struct convert_to_rgb888_result rgb888_result;
> +       struct convert_to_xrgb2101010_result xrgb2101010_result;
>  };
>
>  static struct convert_xrgb8888_case convert_xrgb8888_cases[] =3D {
> @@ -61,6 +67,10 @@ static struct convert_xrgb8888_case convert_xrgb8888_c=
ases[] =3D {
>                         .dst_pitch =3D 0,
>                         .expected =3D { 0x00, 0x00, 0xFF },
>                 },
> +               .xrgb2101010_result =3D {
> +                       .dst_pitch =3D 0,
> +                       .expected =3D { 0x3FF00000 },
> +               },
>         },
>         {
>                 .name =3D "single_pixel_clip_rectangle",
> @@ -83,6 +93,10 @@ static struct convert_xrgb8888_case convert_xrgb8888_c=
ases[] =3D {
>                         .dst_pitch =3D 0,
>                         .expected =3D { 0x00, 0x00, 0xFF },
>                 },
> +               .xrgb2101010_result =3D {
> +                       .dst_pitch =3D 0,
> +                       .expected =3D { 0x3FF00000 },
> +               },
>         },
>         {
>                 /* Well known colors: White, black, red, green, blue, mag=
enta,
> @@ -132,6 +146,15 @@ static struct convert_xrgb8888_case convert_xrgb8888=
_cases[] =3D {
>                                 0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0x00,
>                         },
>                 },
> +               .xrgb2101010_result =3D {
> +                       .dst_pitch =3D 0,
> +                       .expected =3D {
> +                               0x3FFFFFFF, 0x00000000,
> +                               0x3FF00000, 0x000FFC00,
> +                               0x000003FF, 0x3FF003FF,
> +                               0x3FFFFC00, 0x000FFFFF,
> +                       },
> +               },
>         },
>         {
>                 /* Randomly picked colors. Full buffer within the clip ar=
ea. */
> @@ -175,6 +198,14 @@ static struct convert_xrgb8888_case convert_xrgb8888=
_cases[] =3D {
>                                 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>                         },
>                 },
> +               .xrgb2101010_result =3D {
> +                       .dst_pitch =3D 20,
> +                       .expected =3D {
> +                               0x03844672, 0x0444D414, 0x2A20300C, 0x000=
00000, 0x00000000,
> +                               0x1B1705CD, 0x03844672, 0x0444D414, 0x000=
00000, 0x00000000,
> +                               0x2A20300C, 0x1B1705CD, 0x03844672, 0x000=
00000, 0x00000000,
> +                       },
> +               },
>         },
>  };
>
> @@ -319,10 +350,42 @@ static void xrgb8888_to_rgb888_test(struct kunit *t=
est)
>         KUNIT_EXPECT_EQ(test, memcmp(buf, result->expected, dst_size), 0)=
;
>  }
>
> +static void xrgb8888_to_xrgb2101010_test(struct kunit *test)
> +{
> +       const struct convert_xrgb8888_case *params =3D test->param_value;
> +       const struct convert_to_xrgb2101010_result *result =3D &params->x=
rgb2101010_result;
> +       size_t dst_size;
> +       __u32 *buf =3D NULL;
> +       __u32 *xrgb8888 =3D NULL;
> +       struct iosys_map dst, src;
> +
> +       struct drm_framebuffer fb =3D {
> +               .format =3D drm_format_info(DRM_FORMAT_XRGB8888),
> +               .pitches =3D { params->pitch, 0, 0 },
> +       };
> +
> +       dst_size =3D conversion_buf_size(DRM_FORMAT_XRGB2101010,
> +                                      result->dst_pitch, &params->clip);
> +       KUNIT_ASSERT_GT(test, dst_size, 0);
> +
> +       buf =3D kunit_kzalloc(test, dst_size, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
> +       iosys_map_set_vaddr(&dst, buf);
> +
> +       xrgb8888 =3D le32buf_to_cpu(test, params->xrgb8888, TEST_BUF_SIZE=
);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, xrgb8888);
> +       iosys_map_set_vaddr(&src, xrgb8888);
> +
> +       drm_fb_xrgb8888_to_xrgb2101010(&dst, &result->dst_pitch, &src, &f=
b, &params->clip);
> +       buf =3D le32buf_to_cpu(test, buf, TEST_BUF_SIZE);
> +       KUNIT_EXPECT_EQ(test, memcmp(buf, result->expected, dst_size), 0)=
;
> +}
> +
>  static struct kunit_case drm_format_helper_test_cases[] =3D {
>         KUNIT_CASE_PARAM(xrgb8888_to_rgb332_test, convert_xrgb8888_gen_pa=
rams),
>         KUNIT_CASE_PARAM(xrgb8888_to_rgb565_test, convert_xrgb8888_gen_pa=
rams),
>         KUNIT_CASE_PARAM(xrgb8888_to_rgb888_test, convert_xrgb8888_gen_pa=
rams),
> +       KUNIT_CASE_PARAM(xrgb8888_to_xrgb2101010_test, convert_xrgb8888_g=
en_params),
>         {}
>  };
>
> --
> 2.25.1
>

--000000000000aded9a05e66a15e9
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
MDIwAhABh9LgIPnlfMFHR0Die8n7MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCC6
0hl3jw3RH5/oFYVM7y3WnlqfW0QCzGOP/eDp1zpnBjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjA4MTcwNjM2MjhaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAcHSCQqzlYB6Wx9bhc4+Q
bTVrdS12m4RIRDngw6/plh95GDx3vYFZwj7tHWjzWN177E04X1uDdB0uLWqJK3ryVu9A/y51vY4W
JHJT6NoiIiqSkL4Z/p53nLLfxB5sB1II1V8z5HEgkcgcuQ08FdPPphIT6+uP87ChXTaWvN+ElwUH
Qv11ab0cxRYaJA2bspKxRc1h4n/jJ+u67mFzfMJEsj8pYIcn7bchIpeoA+hghR/zft4rdx9NOuLy
kScPbVkNofPrr+z5ly816mA/wrDIpVDrpjya2WHKPSqq1vE5HK4ZNsA9v1SoE08HsO6wju3Vo1Gd
uDudXsI8JksEc6w+mg==
--000000000000aded9a05e66a15e9--
