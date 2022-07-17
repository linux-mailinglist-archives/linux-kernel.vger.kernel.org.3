Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E860B57775C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 18:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbiGQQzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 12:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiGQQzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 12:55:21 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D782513FA6
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 09:55:19 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id b26so13908405wrc.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 09:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=rHz/yX33hBr28DvhbK2Rjba4pMbylNZZMP1KncHmyko=;
        b=kuy5CFAAs/zfaIVFOcE9F84/iBcmgqy6qCDLhYWGQ1NF2LE7ka3sWqNreRV24Lbyzt
         LQxOaadClKY5d+AUM0J/2QBN3Wpg3sXjP0ECwGNEGIKcl5r0IHX8wZBOuBIXE5N0WBKQ
         704NCe9svNnTSzuxEkUEijdxd/9d9kz/dPk1tF7RnT3xUkjA2GvaIut3Et++qak1Jg8p
         V5kHpg2DlHAHyNfP/lBhUKlqgKu2bVgtYYBDm1rYfGVDJnddmnHhwWYGp7DDAOJ8GFIw
         aG9+y9xLx/eST2tbxKOJQNeUBCy2FFJRn63EfdYe4T2kGJmj9oYTIMCPHYCRMK8+PkXj
         ASjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=rHz/yX33hBr28DvhbK2Rjba4pMbylNZZMP1KncHmyko=;
        b=iRKrTn30RpRGYpVScM+AsA94LN3/i3HGu1NRd2ObrGjTo1Y3kx/jhpF2pSgrX5Xz+7
         tJNXSoe8QWEN+gIvHikahyivn09OTrmgFihwH8yn/xKj7Zl6h6F+69rVL0gZ3ZGkVtl0
         fMKOQm+r20j0VsHovRJsgQOE001Ef3AAvT+4CupXk1Zlchgn3u6faaoPHktc4b2yMnj4
         VADeYUMfJOFiR/2LPv9sGlH29KVAt5ALITgh+HJOSC9mx5u3F++q33w7vSX9tFHXGhFT
         4PLVX7S8w00OCM03z/5eBzCm+ZdlrF09b0+Ek/b0/AZHO8bS+dLs3DUyPigmG5MN5Z4d
         cG7Q==
X-Gm-Message-State: AJIora/O8qcVwGZVIMFqLM6BsxNIWrxout36h095xfCy7aTYqZ0ChdSZ
        KeJ+A/BEmtzW4YI3asDfeAo=
X-Google-Smtp-Source: AGRyM1txVfMkEM9piuxMJyZ5yGB8IVmtO2YCfJweXGxuVJEViL8z6mfTaF5CO8fnE87Q0auS5MbhBw==
X-Received: by 2002:a05:6000:144f:b0:21d:a3cc:a6fa with SMTP id v15-20020a056000144f00b0021da3cca6famr20018070wrx.191.1658076918367;
        Sun, 17 Jul 2022 09:55:18 -0700 (PDT)
Received: from elementary ([94.73.36.185])
        by smtp.gmail.com with ESMTPSA id g1-20020a5d5541000000b0021d728d687asm10127430wrw.36.2022.07.17.09.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jul 2022 09:55:17 -0700 (PDT)
Date:   Sun, 17 Jul 2022 18:55:14 +0200
From:   =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To:     David Gow <davidgow@google.com>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Latypov <dlatypov@google.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        maarten.lankhorst@linux.intel.com,
        Jani Nikula <jani.nikula@linux.intel.com>,
        =?iso-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>,
        Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        tales.aparecida@gmail.com, dri-devel@lists.freedesktop.org,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] drm/format-helper: Add KUnit tests for
 drm_fb_xrgb8888_to_rgb565()
Message-ID: <20220717165514.GA979649@elementary>
References: <20220709115837.560877-1-jose.exposito89@gmail.com>
 <20220709115837.560877-5-jose.exposito89@gmail.com>
 <CABVgOSmhOBdXPH_=B_WRcUjMGC-wVPTLBwCdbgZLb0o3-O8pKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABVgOSmhOBdXPH_=B_WRcUjMGC-wVPTLBwCdbgZLb0o3-O8pKw@mail.gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Sat, Jul 16, 2022 at 05:32:51PM +0800, David Gow wrote:
> On Sat, Jul 9, 2022 at 7:58 PM José Expósito <jose.exposito89@gmail.com> wrote:
> >
> > Extend the existing test cases to test the conversion from XRGB8888 to
> > RGB565.
> >
> > The documentation and the color picker available on [1] are useful
> > resources to understand this patch and validate the values returned by
> > the conversion function.
> >
> > Tested-by: Tales L. Aparecida <tales.aparecida@gmail.com>
> > Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
> > Signed-off-by: José Expósito <jose.exposito89@gmail.com>
> > Link: http://www.barth-dev.de/online/rgb565-color-picker/ # [1]
> > ---
> 
> Looks good and passes here.
> 
> Reviewed-by: David Gow <davidgow@google.com>
> 
> Thanks,
> -- David

Thanks a lot for reviewing the series and for pointing out the Sparse
warning. 

I already fixed the warning and added the reviewed by tags, however, I
noticed that rebasing the series on the latest drm-misc-next show this
error:

    [18:49:32] ============================================================
    [18:49:33] =========== drm_format_helper_test (2 subtests) ============
    [18:49:33] ================= xrgb8888_to_rgb332_test ==================
    [18:49:33] [ERROR] Test: xrgb8888_to_rgb332_test: missing subtest result line!
    [18:49:33] [ERROR] Test: xrgb8888_to_rgb332_test: 0 tests run!
    [18:49:33] ========== [NO TESTS RUN] xrgb8888_to_rgb332_test ==========
    [18:49:33] [ERROR] Test: drm_format_helper_test: missing expected subtest!
    [18:49:33] [CRASHED] 
    [18:49:33] [ERROR] Test: drm_format_helper_test: missing subtest result line!
    [18:49:33] # Subtest: drm_format_helper_test
    [18:49:33] 1..2
    [18:49:33] ============= [CRASHED] drm_format_helper_test =============
    [18:49:33] [ERROR] Test: main: missing expected subtest!
    [18:49:33] [CRASHED] 
    [18:49:33] [ERROR] Test: main: missing expected subtest!
    [18:49:33] [CRASHED] 
    [18:49:33] [ERROR] Test: main: missing expected subtest!
    [18:49:33] [CRASHED] 
    [18:49:33] [ERROR] Test: main: missing expected subtest!
    [18:49:33] [CRASHED] 
    [18:49:33] [ERROR] Test: main: missing expected subtest!
    [18:49:33] [CRASHED] 
    [18:49:33] [ERROR] Test: main: missing expected subtest!
    [18:49:33] [CRASHED] 
    [18:49:33] [ERROR] Test: main: missing expected subtest!
    [18:49:33] [CRASHED] 
    [18:49:33] [ERROR] Test: main: missing expected subtest!
    [18:49:33] [CRASHED] 
    [18:49:33] [ERROR] Test: main: missing expected subtest!
    [18:49:33] [CRASHED] 
    [18:49:33] ============================================================
    [18:49:33] Testing complete. Ran 10 tests: crashed: 10, errors: 13

I bisected drm-misc-next to find out that the first bad commit is:
e23a5e14aa278858c2e3d81ec34e83aa9a4177c5

Not very usefull, because that commit merges v5.19-rc6 into misc.

I tested on the latest kselftest-master branch and the error is not
present.

Are you aware of any change that could cause this issue?

Jose

 
> >  .../gpu/drm/tests/drm_format_helper_test.c    | 76 ++++++++++++++++++-
> >  1 file changed, 75 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/tests/drm_format_helper_test.c b/drivers/gpu/drm/tests/drm_format_helper_test.c
> > index 0a490ad4fd32..c0592c1235cf 100644
> > --- a/drivers/gpu/drm/tests/drm_format_helper_test.c
> > +++ b/drivers/gpu/drm/tests/drm_format_helper_test.c
> > @@ -21,12 +21,19 @@ struct convert_to_rgb332_result {
> >         const u8 expected[TEST_BUF_SIZE];
> >  };
> >
> > +struct convert_to_rgb565_result {
> > +       unsigned int dst_pitch;
> > +       const u16 expected[TEST_BUF_SIZE];
> > +       const u16 expected_swab[TEST_BUF_SIZE];
> > +};
> > +
> >  struct convert_xrgb8888_case {
> >         const char *name;
> >         unsigned int pitch;
> >         struct drm_rect clip;
> >         const u32 xrgb8888[TEST_BUF_SIZE];
> >         struct convert_to_rgb332_result rgb332_result;
> > +       struct convert_to_rgb565_result rgb565_result;
> >  };
> >
> >  static struct convert_xrgb8888_case convert_xrgb8888_cases[] = {
> > @@ -39,6 +46,11 @@ static struct convert_xrgb8888_case convert_xrgb8888_cases[] = {
> >                         .dst_pitch = 0,
> >                         .expected = { 0xE0 },
> >                 },
> > +               .rgb565_result = {
> > +                       .dst_pitch = 0,
> > +                       .expected = { 0xF800 },
> > +                       .expected_swab = { 0x00F8 },
> > +               },
> >         },
> >         {
> >                 .name = "single_pixel_clip_rectangle",
> > @@ -52,6 +64,11 @@ static struct convert_xrgb8888_case convert_xrgb8888_cases[] = {
> >                         .dst_pitch = 0,
> >                         .expected = { 0xE0 },
> >                 },
> > +               .rgb565_result = {
> > +                       .dst_pitch = 0,
> > +                       .expected = { 0xF800 },
> > +                       .expected_swab = { 0x00F8 },
> > +               },
> >         },
> >         {
> >                 /* Well known colors: White, black, red, green, blue, magenta,
> > @@ -77,6 +94,21 @@ static struct convert_xrgb8888_case convert_xrgb8888_cases[] = {
> >                                 0xFC, 0x1F,
> >                         },
> >                 },
> > +               .rgb565_result = {
> > +                       .dst_pitch = 0,
> > +                       .expected = {
> > +                               0xFFFF, 0x0000,
> > +                               0xF800, 0x07E0,
> > +                               0x001F, 0xF81F,
> > +                               0xFFE0, 0x07FF,
> > +                       },
> > +                       .expected_swab = {
> > +                               0xFFFF, 0x0000,
> > +                               0x00F8, 0xE007,
> > +                               0x1F00, 0x1FF8,
> > +                               0xE0FF, 0xFF07,
> > +                       },
> > +               },
> >         },
> >         {
> >                 /* Randomly picked colors. Full buffer within the clip area. */
> > @@ -96,6 +128,19 @@ static struct convert_xrgb8888_case convert_xrgb8888_cases[] = {
> >                                 0xA0, 0x6D, 0x0A, 0x00, 0x00,
> >                         },
> >                 },
> > +               .rgb565_result = {
> > +                       .dst_pitch = 10,
> > +                       .expected = {
> > +                               0x0A33, 0x1260, 0xA800, 0x0000, 0x0000,
> > +                               0x6B8E, 0x0A33, 0x1260, 0x0000, 0x0000,
> > +                               0xA800, 0x6B8E, 0x0A33, 0x0000, 0x0000,
> > +                       },
> > +                       .expected_swab = {
> > +                               0x330A, 0x6012, 0x00A8, 0x0000, 0x0000,
> > +                               0x8E6B, 0x330A, 0x6012, 0x0000, 0x0000,
> > +                               0x00A8, 0x8E6B, 0x330A, 0x0000, 0x0000,
> > +                       },
> > +               },
> >         },
> >  };
> >
> > @@ -120,7 +165,7 @@ static size_t conversion_buf_size(u32 dst_format, unsigned int dst_pitch,
> >         if (!dst_pitch)
> >                 dst_pitch = drm_rect_width(clip) * dst_fi->cpp[0];
> >
> > -       return dst_pitch * drm_rect_height(clip);
> > +       return (dst_pitch * drm_rect_height(clip)) / (dst_fi->depth / 8);
> >  }
> >
> >  static u32 *le32buf_to_cpu(struct kunit *test, const u32 *buf, size_t buf_size)
> > @@ -175,8 +220,37 @@ static void xrgb8888_to_rgb332_test(struct kunit *test)
> >         KUNIT_EXPECT_EQ(test, memcmp(dst, result->expected, dst_size), 0);
> >  }
> >
> > +static void xrgb8888_to_rgb565_test(struct kunit *test)
> > +{
> > +       const struct convert_xrgb8888_case *params = test->param_value;
> > +       const struct convert_to_rgb565_result *result = &params->rgb565_result;
> > +       size_t dst_size;
> > +       __u16 *dst = NULL;
> > +
> > +       struct drm_framebuffer fb = {
> > +               .format = drm_format_info(DRM_FORMAT_XRGB8888),
> > +               .pitches = { params->pitch, 0, 0 },
> > +       };
> > +
> > +       dst_size = conversion_buf_size(DRM_FORMAT_RGB565, result->dst_pitch,
> > +                                      &params->clip);
> > +       KUNIT_ASSERT_GT(test, dst_size, 0);
> > +
> > +       dst = kunit_kzalloc(test, dst_size, GFP_KERNEL);
> > +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dst);
> > +
> > +       drm_fb_xrgb8888_to_rgb565(dst, result->dst_pitch, params->xrgb8888, &fb,
> > +                                 &params->clip, false);
> > +       KUNIT_EXPECT_EQ(test, memcmp(dst, result->expected, dst_size), 0);
> > +
> > +       drm_fb_xrgb8888_to_rgb565(dst, result->dst_pitch, params->xrgb8888, &fb,
> > +                                 &params->clip, true);
> > +       KUNIT_EXPECT_EQ(test, memcmp(dst, result->expected_swab, dst_size), 0);
> > +}
> > +
> >  static struct kunit_case drm_format_helper_test_cases[] = {
> >         KUNIT_CASE_PARAM(xrgb8888_to_rgb332_test, convert_xrgb8888_gen_params),
> > +       KUNIT_CASE_PARAM(xrgb8888_to_rgb565_test, convert_xrgb8888_gen_params),
> >         {}
> >  };
> >
> > --
> > 2.25.1
> >


