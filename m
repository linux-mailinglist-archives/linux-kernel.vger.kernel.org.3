Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD880540FDC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 21:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355064AbiFGTN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 15:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352117AbiFGSZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 14:25:33 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 277C3ED8C6
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 10:54:42 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id k16so25205963wrg.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 10:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Fs5Pkdkai/JakHce+tINbl9lf3yL2fRy39u51J4iMis=;
        b=q2K9v9i7dSo52w+PW8xOZb3iPomW0IhGhw1oG9cyxsMhSdb83IeSks/qUCeMpF2YDb
         ZW8Pe/R5ctUz6bhwRgaSbo4GaJ8KLGeNzqBDMA7LpHtPNAVn40d9Ahlwz/D3x/kx4gYu
         7AMIWOMXFItNwS4JmGOpk6TMLr6fzgSUf5hzfl3kZ9lJwnED+vGtDhb1ukGFVuPrHZm3
         VQBlMBGbA5fk7mt/2bpZuleafWyvpo+K36/9SglrTiVO3B0+gwLPTjaZaUYSQYsoF0YN
         0JF/HLXuojKtfUopc8H7SugvI575/EoH6gkgs4ZIFgmn787Mzw0tU+36HHDZ5D1NYO6T
         H1Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Fs5Pkdkai/JakHce+tINbl9lf3yL2fRy39u51J4iMis=;
        b=1KLJnv8r7CmLarSUXbvLc/loXyd1gkscFcwPS05suGzgPVnXnzkIfuhdbGhNJarXlc
         2o9xq+NkQy80QsYgKA/lCM47hH/RzSiRLYw5sajDPkPT5J3H367As4C++rIdNKQYlVFX
         f34sYGcAgSOOaw6wOC6KNOSEqqcC3m3DZ+nBH1Xv7lb8XBkTyYPNA0+S0aUIT4dSVb5f
         2woOV7XICx8+YHnqcEXo06fAgxrCOKas3ukWrz4UA31xh+D6CM052c23vtb4cbausqY/
         86mfIT+5Hb8MmFTC6UPID4VyyFgBxawGBFOki16+vxml3vPFeAhTsnU48mbLg3aFzhfG
         /VMQ==
X-Gm-Message-State: AOAM533R70U3lj7Xe/2mLa0S4QmWwGuZXzNyLBI+cTuG04Glfvwsryd+
        Q2WaE8QMSMSqunIrk1oMDbI=
X-Google-Smtp-Source: ABdhPJxK65eLkDG/ct+9I9jD0tOdzaGGiai6mRB/hMviyg7drHh8+/bjRV5COfYJE3/i5Ti8K3o6VA==
X-Received: by 2002:adf:f706:0:b0:20e:6788:c2b6 with SMTP id r6-20020adff706000000b0020e6788c2b6mr29430537wrp.633.1654624479935;
        Tue, 07 Jun 2022 10:54:39 -0700 (PDT)
Received: from elementary ([94.73.36.128])
        by smtp.gmail.com with ESMTPSA id n6-20020a05600c4f8600b0039b006bd6d9sm27751411wmq.6.2022.06.07.10.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 10:54:39 -0700 (PDT)
Date:   Tue, 7 Jun 2022 19:54:32 +0200
From:   =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     javierm@redhat.com, davidgow@google.com, dlatypov@google.com,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] drm/format-helper: Add KUnit tests for
 drm_fb_xrgb8888_to_rgb332()
Message-ID: <20220607175432.GA143212@elementary>
References: <20220606095516.938934-1-jose.exposito89@gmail.com>
 <20220606095516.938934-2-jose.exposito89@gmail.com>
 <0f1984c3-7dc0-0592-47ee-7ba421914c8b@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0f1984c3-7dc0-0592-47ee-7ba421914c8b@suse.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Thanks a lot for your review.

On Tue, Jun 07, 2022 at 09:22:38AM +0200, Thomas Zimmermann wrote:
> Hi,
> 
> ading Kunit tests for the conversion helpers is pretty cool. Thanks for
> doing that.
> 
> Am 06.06.22 um 11:55 schrieb José Expósito:
> > Test the conversion from XRGB8888 to RGB332.
> > 
> > What is tested?
> > 
> >   - Different values for the X in XRGB8888 to make sure it is ignored
> >   - Different clip values: Single pixel and full and partial buffer
> >   - Well known colors: White, black, red, green, blue, magenta, yellow
> >     and cyan
> >   - Other colors: Randomly picked
> >   - Destination pitch
> > 
> > How to run the tests?
> > 
> >   $ ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/gpu/drm \
> >           --kconfig_add CONFIG_VIRTIO_UML=y \
> >           --kconfig_add CONFIG_UML_PCI_OVER_VIRTIO=y
> > 
> > Suggested-by: Javier Martinez Canillas <javierm@redhat.com>
> > Signed-off-by: José Expósito <jose.exposito89@gmail.com>
> > 
> > ---
> > 
> > RFC -> v1: https://lore.kernel.org/dri-devel/20220530102017.471865-1-jose.exposito89@gmail.com/T/
> > 
> >   - Add .kunitconfig (Maxime Ripard)
> >   - Fix memory leak (Daniel Latypov)
> >   - Make config option generic (Javier Martinez Canillas):
> >     DRM_FORMAR_HELPER_TEST -> DRM_KUNIT_TEST
> >   - Remove DISABLE_STRUCTLEAK_PLUGIN (Daniel Latypov)
> > ---
> >   drivers/gpu/drm/.kunitconfig             |   3 +
> >   drivers/gpu/drm/Kconfig                  |  16 +++
> >   drivers/gpu/drm/Makefile                 |   2 +
> >   drivers/gpu/drm/drm_format_helper_test.c | 166 +++++++++++++++++++++++
> >   4 files changed, 187 insertions(+)
> >   create mode 100644 drivers/gpu/drm/.kunitconfig
> >   create mode 100644 drivers/gpu/drm/drm_format_helper_test.c
> > 
> > diff --git a/drivers/gpu/drm/.kunitconfig b/drivers/gpu/drm/.kunitconfig
> > new file mode 100644
> > index 000000000000..6ec04b4c979d
> > --- /dev/null
> > +++ b/drivers/gpu/drm/.kunitconfig
> > @@ -0,0 +1,3 @@
> > +CONFIG_KUNIT=y
> > +CONFIG_DRM=y
> > +CONFIG_DRM_KUNIT_TEST=y
> > diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> > index e88c497fa010..3c0b1faba439 100644
> > --- a/drivers/gpu/drm/Kconfig
> > +++ b/drivers/gpu/drm/Kconfig
> > @@ -70,6 +70,22 @@ config DRM_DEBUG_SELFTEST
> >   	  If in doubt, say "N".
> > +config DRM_KUNIT_TEST
> > +	tristate "KUnit tests for DRM" if !KUNIT_ALL_TESTS
> > +	depends on DRM && KUNIT=y
> > +	select DRM_KMS_HELPER
> > +	default KUNIT_ALL_TESTS
> > +	help
> > +	  This builds unit tests for DRM. This option is not useful for
> > +	  distributions or general kernels, but only for kernel
> > +	  developers working on DRM and associated drivers.
> > +
> > +	  For more information on KUnit and unit tests in general,
> > +	  please refer to the KUnit documentation in
> > +	  Documentation/dev-tools/kunit/.
> > +
> > +	  If in doubt, say "N".
> > +
> >   config DRM_KMS_HELPER
> >   	tristate
> >   	depends on DRM
> > diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
> > index 15fe3163f822..6549471f09c7 100644
> > --- a/drivers/gpu/drm/Makefile
> > +++ b/drivers/gpu/drm/Makefile
> > @@ -76,6 +76,8 @@ obj-$(CONFIG_DRM_KMS_HELPER) += drm_kms_helper.o
> >   #
> >   obj-$(CONFIG_DRM_DEBUG_SELFTEST) += selftests/
> > +obj-$(CONFIG_DRM_KUNIT_TEST) += drm_kms_helper.o \
> 
> You already selected DRM_KMS_HELPER in Kconfig. Why do you need to list the
> module here?

Actually, it is not required. I'll remove it in v2.

> > +		drm_format_helper_test.o
> 
> One comment about source-code organization:
> 
> There is potentially a long list of test files that will contain unit tests.
> I would prefer to put the unit tests into their own subdirectory (e.g.,
> kunit).

It makes sense, and it'd also be more consistent with selftest tests.

> >   obj-$(CONFIG_DRM_MIPI_DBI) += drm_mipi_dbi.o
> >   obj-$(CONFIG_DRM_MIPI_DSI) += drm_mipi_dsi.o
> > diff --git a/drivers/gpu/drm/drm_format_helper_test.c b/drivers/gpu/drm/drm_format_helper_test.c
> > new file mode 100644
> > index 000000000000..e9302219f3f9
> > --- /dev/null
> > +++ b/drivers/gpu/drm/drm_format_helper_test.c
> > @@ -0,0 +1,166 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +
> > +#include <kunit/test.h>
> > +
> > +#include <drm/drm_device.h>
> > +#include <drm/drm_file.h>
> > +#include <drm/drm_format_helper.h>
> > +#include <drm/drm_fourcc.h>
> > +#include <drm/drm_framebuffer.h>
> > +#include <drm/drm_gem_framebuffer_helper.h>
> > +#include <drm/drm_mode.h>
> > +#include <drm/drm_print.h>
> > +#include <drm/drm_rect.h>
> > +
> > +#include "drm_crtc_internal.h"
> > +
> > +#define TEST_BUF_SIZE 50
> > +#define CLIP(x, y, w, h) { (x), (y), (x) + (w), (y) + (h) }
> 
> I have long wished for an initializer macro for drm_rect.
> Please rename that CLIP macro to DRM_RECT_INIT and put it into
> <drm/drm_rect.h> with docs.

I'll include an extra patch for it on v2.
 
> > +
> > +struct xrgb8888_to_rgb332_case {
> > +	const char *name;
> > +	unsigned int pitch;
> > +	unsigned int dst_pitch;
> > +	struct drm_rect clip;
> > +	const u32 xrgb8888[TEST_BUF_SIZE];
> > +	const u8 expected[4 * TEST_BUF_SIZE];
> > +};
> > +
> > +static struct xrgb8888_to_rgb332_case xrgb8888_to_rgb332_cases[] = {
> 
> The names of these tests are only mildly descriptive. Maybe add a
> single-line comment before each test case to describe what it does. Your
> commit description has a nice list of tests, which you can copy here almost
> as-is.

Ok, written down for v2.
 
> > +	{
> > +		.name = "Single pixel source",
> > +		.pitch = 1 * 4,
> > +		.dst_pitch = 0,
> > +		.clip = CLIP(0, 0, 1, 1),
> > +		.xrgb8888 = { 0x01FF0000 },
> > +		.expected = { 0xE0 },
> > +	},
> > +	{
> > +		.name = "Single pixel clip",
> > +		.pitch = 2 * 4,
> > +		.dst_pitch = 0,
> > +		.clip = CLIP(1, 1, 1, 1),
> > +		.xrgb8888 = {
> > +			0x00000000, 0x00000000,
> > +			0x00000000, 0x10FF0000,
> > +		},
> > +		.expected = { 0xE0 },
> > +	},
> > +	{
> > +		.name = "White, black, red, green, blue, magenta, yellow, cyan",
> > +		.pitch = 4 * 4,
> > +		.dst_pitch = 0,
> > +		.clip = CLIP(1, 1, 2, 4),
> > +		.xrgb8888 = {
> > +			0x00000000, 0x00000000, 0x00000000, 0x00000000,
> > +			0x00000000, 0x11FFFFFF, 0x22000000, 0x00000000,
> > +			0x00000000, 0x33FF0000, 0x4400FF00, 0x00000000,
> > +			0x00000000, 0x550000FF, 0x66FF00FF, 0x00000000,
> > +			0x00000000, 0x77FFFF00, 0x8800FFFF, 0x00000000,
> > +		},
> > +		.expected = {
> > +			0xFF, 0x00,
> > +			0xE0, 0x1C,
> > +			0x03, 0xE3,
> > +			0xFC, 0x1F,
> > +		},
> > +	},
> > +	{
> > +		.name = "Destination pitch",
> > +		.pitch = 3 * 4,
> > +		.dst_pitch = 5,
> > +		.clip = CLIP(0, 0, 3, 3),
> > +		.xrgb8888 = {
> > +			0xA10E449C, 0xB1114D05, 0xC1A80303,
> > +			0xD16C7073, 0xA20E449C, 0xB2114D05,
> > +			0xC2A80303, 0xD26C7073, 0xA30E449C,
> > +		},
> > +		.expected = {
> > +			0x0A, 0x08, 0xA0, 0x00, 0x00,
> > +			0x6D, 0x0A, 0x08, 0x00, 0x00,
> > +			0xA0, 0x6D, 0x0A, 0x00, 0x00,
> > +		},
> > +	},
> > +};
> > +
> > +/**
> > + * conversion_buf_size - Return the destination buffer size required to convert
> > + * between formats.
> > + * @src_format: source buffer pixel format (DRM_FORMAT_*)
> > + * @dst_format: destination buffer pixel format (DRM_FORMAT_*)
> > + * @dst_pitch: Number of bytes between two consecutive scanlines within dst
> > + * @clip: Clip rectangle area to convert
> > + *
> > + * Returns:
> > + * The size of the destination buffer or negative value on error.
> > + */
> 
> You don't need to document internal functions with formatted comments. It
> will only confuse readers of the generated documentation. If you don't want
> to outright remove the comment, at least remove the /** at the top.

Cool, I'll remove the extra * on v2.

Speaking about documentation, I sent a patch explaining how to run
the tests:

https://lore.kernel.org/dri-devel/20220606180940.43371-1-jose.exposito89@gmail.com/T/

I'll send it as part of the v2 of this series.

Best wishes,
Jose


> Best regards
> Thomas
> 
> > +static size_t conversion_buf_size(u32 src_format, u32 dst_format,
> > +				  unsigned int dst_pitch,
> > +				  const struct drm_rect *clip)
> > +{
> > +	const struct drm_format_info *src_fi = drm_format_info(src_format);
> > +	const struct drm_format_info *dst_fi = drm_format_info(dst_format);
> > +	size_t width = drm_rect_width(clip);
> > +	size_t src_nbytes;
> > +
> > +	if (!src_fi || !dst_fi)
> > +		return -EINVAL;
> > +
> > +	if (dst_pitch)
> > +		width = dst_pitch;
> > +
> > +	src_nbytes = width * drm_rect_height(clip) * src_fi->cpp[0];
> > +	if (!src_nbytes)
> > +		return 0;
> > +
> > +	return (src_nbytes * dst_fi->cpp[0]) / src_fi->cpp[0];
> > +}
> > +
> > +static void xrgb8888_to_rgb332_case_desc(struct xrgb8888_to_rgb332_case *t,
> > +					 char *desc)
> > +{
> > +	strscpy(desc, t->name, KUNIT_PARAM_DESC_SIZE);
> > +}
> > +
> > +KUNIT_ARRAY_PARAM(xrgb8888_to_rgb332, xrgb8888_to_rgb332_cases,
> > +		  xrgb8888_to_rgb332_case_desc);
> > +
> > +static void xrgb8888_to_rgb332_test(struct kunit *test)
> > +{
> > +	const struct xrgb8888_to_rgb332_case *params = test->param_value;
> > +	size_t dst_size;
> > +	__u8 *dst = NULL;
> > +
> > +	struct drm_framebuffer fb = {
> > +		.format = drm_format_info(DRM_FORMAT_XRGB8888),
> > +		.pitches = { params->pitch, 0, 0 },
> > +	};
> > +
> > +	dst_size = conversion_buf_size(DRM_FORMAT_XRGB8888, DRM_FORMAT_RGB332,
> > +				       params->dst_pitch, &params->clip);
> > +	KUNIT_ASSERT_GT(test, dst_size, 0);
> > +
> > +	dst = kunit_kzalloc(test, dst_size, GFP_KERNEL);
> > +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dst);
> > +
> > +	drm_fb_xrgb8888_to_rgb332(dst, params->dst_pitch, params->xrgb8888,
> > +				  &fb, &params->clip);
> > +	KUNIT_EXPECT_EQ(test, memcmp(dst, params->expected, dst_size), 0);
> > +}
> > +
> > +static struct kunit_case drm_format_helper_test_cases[] = {
> > +	KUNIT_CASE_PARAM(xrgb8888_to_rgb332_test,
> > +			 xrgb8888_to_rgb332_gen_params),
> > +	{}
> > +};
> > +
> > +static struct kunit_suite drm_format_helper_test_suite = {
> > +	.name = "drm-format-helper-test",
> > +	.test_cases = drm_format_helper_test_cases,
> > +};
> > +
> > +kunit_test_suite(drm_format_helper_test_suite);
> > +
> > +MODULE_DESCRIPTION("KUnit tests for the drm_format_helper APIs");
> > +MODULE_LICENSE("GPL");
> > +MODULE_AUTHOR("José Expósito <jose.exposito89@gmail.com>");
> 
> -- 
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Maxfeldstr. 5, 90409 Nürnberg, Germany
> (HRB 36809, AG Nürnberg)
> Geschäftsführer: Ivo Totev



