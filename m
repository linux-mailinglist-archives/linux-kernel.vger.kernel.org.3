Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5D05AA91D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 09:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235343AbiIBHw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 03:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233557AbiIBHw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 03:52:27 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605B8B6D2A
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 00:52:24 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id i67so624330vkb.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 00:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=pqlsslotLMD/btH53knPgAVkKUlxlnVr4A921sVHYas=;
        b=aEgk6pJz59lujSkyYSWCJK38qiDqla2V1GaTw1ZiLAAzZBMFy+iMH78dvKX532Il/b
         neBsF8OM8Uwfo+ZhTQJzvOEQ9zficHhsJ+JWQIWdajXJQZGA6HpIe1pjdzNlrfKwQP4A
         QpOh9IfpKil7/RrALgHtLnrcaqq5KRb0UXzCgT/qQyCCmmo1pvtN9jppi0U4fkR7gnTi
         x9lTEemzelgldZetXv1t6DjN80g5hwWChyGwQ1mRmBsmWNTFgG5ZY4JLLcxRhGqGO8QW
         UPGOPjmtDnt09eo9EGGrcsYLePi1mgSAc0osgIbceruzdg9veBw2MeBLZ4cibfc3JKHP
         0xKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=pqlsslotLMD/btH53knPgAVkKUlxlnVr4A921sVHYas=;
        b=0NNQrbsahakoR2jIEykYdUTLXfox+pyWxoLqNNTZjPUTeetYDt2XR1wvUViaOv8GEe
         vSC03xrR/fl+baIeMTtOs5RQDXMzTRXXd9B80df66w5/keN5OXpzhEt5Hq/lx7R3b1Zn
         wV20R6n38MvYrJvmznbUrzrVp9Ii54SD3xJeuTIhA7I1sXmtmSulIlPYfp8AnlXrQqVJ
         FNH23RjpE89OKJDzCPE5Z/9qEm31xGG44Tz3fpynrPKKAo3yA8nQHyDMCJP66vNEu/kE
         RVMeH1BpHaba89jV+rXxsd7MCjPAGZ5LTUkUHwlzhDgQ82pFNy6pYAQLRi2d/VAXaIC8
         OzPA==
X-Gm-Message-State: ACgBeo27fZrEGg362ACCylytSgahHcPV04g8dlUqru+p1EijK+Ti4GvZ
        kpU2rzeWvn+hnUMjIt346Gr9i1unVLWyICifIpooMQ==
X-Google-Smtp-Source: AA6agR4nZ0EQZlnyggzdXbc7DyTCbse9fU0U75lWI+RJR+KF4HIVoTQ+PgRGaDZgBJTeRM90lDwoRABzUu5vyfcZ3qc=
X-Received: by 2002:a1f:b248:0:b0:377:aa0c:941 with SMTP id
 b69-20020a1fb248000000b00377aa0c0941mr10401933vkf.37.1662105143265; Fri, 02
 Sep 2022 00:52:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220901124210.591994-1-mairacanal@riseup.net>
In-Reply-To: <20220901124210.591994-1-mairacanal@riseup.net>
From:   David Gow <davidgow@google.com>
Date:   Fri, 2 Sep 2022 15:52:11 +0800
Message-ID: <CABVgOSn+03ACbVUQgRPZxLSB5ujU7qVCReP-UsGXrZC+i0C_UQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm/tests: Split drm_framebuffer_create_test into
 parameterized tests
To:     =?UTF-8?B?TWHDrXJhIENhbmFs?= <mairacanal@riseup.net>
Cc:     Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        Tales Aparecida <tales.aparecida@gmail.com>, mwen@igalia.com,
        andrealmeid@riseup.net, siqueirajordao@riseup.net,
        Trevor Woerner <twoerner@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Arthur Grillo <arthur.grillo@usp.br>,
        michal.winiarski@intel.com,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        dri-devel@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Sep 1, 2022 at 8:44 PM Ma=C3=ADra Canal <mairacanal@riseup.net> wro=
te:
>
> The igt_check_drm_framebuffer_create is based on a loop that executes
> tests for all createbuffer_tests test cases. This could be better
> represented by parameterized tests, provided by KUnit.
>
> So, convert the igt_check_drm_framebuffer_create into parameterized tests=
.
>
> Signed-off-by: Ma=C3=ADra Canal <mairacanal@riseup.net>
> Reviewed-by: Micha=C5=82 Winiarski <michal.winiarski@intel.com>
> ---
> v1 -> v2: https://lore.kernel.org/dri-devel/20220830211603.191734-1-maira=
canal@riseup.net/
> - Use .init for mock_drm_device instead of a global variable. (Micha=C5=
=82 Winiarski)
> ---

This looks good to me, and worked well here.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  drivers/gpu/drm/tests/drm_framebuffer_test.c | 45 ++++++++++++--------
>  1 file changed, 27 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/gpu/drm/tests/drm_framebuffer_test.c b/drivers/gpu/d=
rm/tests/drm_framebuffer_test.c
> index ec7a08ba4056..564794917784 100644
> --- a/drivers/gpu/drm/tests/drm_framebuffer_test.c
> +++ b/drivers/gpu/drm/tests/drm_framebuffer_test.c
> @@ -25,7 +25,7 @@ struct drm_framebuffer_test {
>         const char *name;
>  };
>
> -static struct drm_framebuffer_test createbuffer_tests[] =3D {
> +static const struct drm_framebuffer_test drm_framebuffer_create_cases[] =
=3D {

FYI: It shouldn't be _necessary_ to namespace this, though I quite
like it personally. I definitely approve of the const, though.

>  { .buffer_created =3D 1, .name =3D "ABGR8888 normal sizes",
>         .cmd =3D { .width =3D 600, .height =3D 600, .pixel_format =3D DRM=
_FORMAT_ABGR8888,
>                  .handles =3D { 1, 0, 0 }, .pitches =3D { 4 * 600, 0, 0 }=
,
> @@ -330,43 +330,52 @@ static struct drm_mode_config_funcs mock_config_fun=
cs =3D {
>         .fb_create =3D fb_create_mock,
>  };
>
> -static struct drm_device mock_drm_device =3D {
> -       .mode_config =3D {
> +static int drm_framebuffer_test_init(struct kunit *test)
> +{
> +       struct drm_device *mock;
> +
> +       mock =3D kunit_kzalloc(test, sizeof(*mock), GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, mock);
> +
> +       mock->mode_config =3D (struct drm_mode_config) {
>                 .min_width =3D MIN_WIDTH,
>                 .max_width =3D MAX_WIDTH,
>                 .min_height =3D MIN_HEIGHT,
>                 .max_height =3D MAX_HEIGHT,
>                 .funcs =3D &mock_config_funcs,
> -       },
> -};
> +       };
>
> -static int execute_drm_mode_fb_cmd2(struct drm_mode_fb_cmd2 *r)
> +       test->priv =3D mock;
> +       return 0;
> +}
> +
> +static void test_drm_framebuffer_create(struct kunit *test)
>  {
> +       const struct drm_framebuffer_test *params =3D test->param_value;
> +       struct drm_device *mock =3D test->priv;
>         int buffer_created =3D 0;
>
> -       mock_drm_device.dev_private =3D &buffer_created;
> -       drm_internal_framebuffer_create(&mock_drm_device, r, NULL);
> -       return buffer_created;
> +       mock->dev_private =3D &buffer_created;
> +       drm_internal_framebuffer_create(mock, &params->cmd, NULL);
> +       KUNIT_EXPECT_EQ(test, params->buffer_created, buffer_created);
>  }
>
> -static void igt_check_drm_framebuffer_create(struct kunit *test)
> +static void drm_framebuffer_test_to_desc(const struct drm_framebuffer_te=
st *t, char *desc)
>  {
> -       int i =3D 0;
> -
> -       for (i =3D 0; i < ARRAY_SIZE(createbuffer_tests); i++) {
> -               KUNIT_EXPECT_EQ_MSG(test, createbuffer_tests[i].buffer_cr=
eated,
> -                                   execute_drm_mode_fb_cmd2(&createbuffe=
r_tests[i].cmd),
> -                    "Test %d: \"%s\" failed\n", i, createbuffer_tests[i]=
.name);
> -       }
> +       strcpy(desc, t->name);
>  }
>
> +KUNIT_ARRAY_PARAM(drm_framebuffer_create, drm_framebuffer_create_cases,
> +                 drm_framebuffer_test_to_desc);
> +
>  static struct kunit_case drm_framebuffer_tests[] =3D {
> -       KUNIT_CASE(igt_check_drm_framebuffer_create),
> +       KUNIT_CASE_PARAM(test_drm_framebuffer_create, drm_framebuffer_cre=
ate_gen_params),
>         { }
>  };
>
>  static struct kunit_suite drm_framebuffer_test_suite =3D {
>         .name =3D "drm_framebuffer",
> +       .init =3D drm_framebuffer_test_init,
>         .test_cases =3D drm_framebuffer_tests,
>  };
>
> --
> 2.37.2
>
> --
> You received this message because you are subscribed to the Google Groups=
 "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/kunit-dev/20220901124210.591994-1-mairacanal%40riseup.net.
