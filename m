Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 172BE5378EB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 12:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235171AbiE3KUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 06:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbiE3KU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 06:20:28 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D877C14F
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 03:20:27 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id u3so13990523wrg.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 03:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iSDSkDwe5TVDF25IfuixvEtNIij4LrLrDKNo2ck2+3w=;
        b=KZPCK9eNNHJsCvUGVAtIz3ORepDzJHXdkPg3xydNMF4ak6Cam+1ABcf688evH7UulR
         K1R94B2FaMN1IEJ/OxaYHEJ60I0T5oiaT23E44sC4oaVcIgMPUJ9J+JCFcBtXUPHgErv
         wKL7fMlm82j1h379IHL+PEPp3ggUNr2l38uWMxpCfCbYkmvTpEP/9PGIzvnOs4WhMW5c
         0jFwYZ6HuOmTo4YcwDBCF5Z1yEKED7hwILlxW/Lr3qUlPp4vnhMFwjXDNT7mQkshL1GY
         6TcwNesFg3i2hDq3GZjpxkgNkmZIRvkAaQtqe1kBA7RFOENjX3sKriy8MlvKDjV3viaa
         ZU+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iSDSkDwe5TVDF25IfuixvEtNIij4LrLrDKNo2ck2+3w=;
        b=ir4dPwUwU9p+Di+BSQViTlxBdw3178vVc4Vm9xLK8f7pg5/P1er+pELZ7V2kJobmg+
         MTmrv6XyZ/7MeOCXIm8pHRjT+gzMnBdmwaoonMa6P5yC4ByqMqBgKVv8CAylbKAdxLmh
         sjKhhORUCiUCfBHaS3v0lnK6zavZpflpC+4DA0G1fc8Ent6Rr5P3VdhVaRoiC3O/AhBt
         wk1WwIjIHKs/dKxpTl73kWq8MNqijKPsFyzGij/RlA1I/i/LfEcX0HvhXmeHKw94tbUy
         Y2jI0/ofXiwxkRwKN/oDV/m5PVG7d6W73ltOX+HyHhcIcaIJ7bDq+GWpU4CGPMQrEs/G
         LEYw==
X-Gm-Message-State: AOAM531z0RQspwK9iTvr21b5Bg7ENehsvTDWDdAL1t+AeAYl5e/Bg2rr
        q9e4SCacA265OXeMnCInwWvGTdISFJIgDg==
X-Google-Smtp-Source: ABdhPJzmUtFAycXckGNqB9yrdwEMjtpJlJ4mQy+eMo3MH1HyO3jFcsLNoOBmWOoMwKDZ8PGsDmjl0w==
X-Received: by 2002:a05:6000:168a:b0:20f:d6e8:a5b with SMTP id y10-20020a056000168a00b0020fd6e80a5bmr31669045wrd.41.1653906025599;
        Mon, 30 May 2022 03:20:25 -0700 (PDT)
Received: from localhost.localdomain ([94.73.36.128])
        by smtp.gmail.com with ESMTPSA id p12-20020a05600c358c00b003973ea7e725sm12986293wmq.0.2022.05.30.03.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 03:20:24 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     javierm@redhat.com
Cc:     tzimmermann@suse.de, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [RFC PATCH 0/1] KUnit tests for drm_format_helper
Date:   Mon, 30 May 2022 12:20:16 +0200
Message-Id: <20220530102017.471865-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

Recently Javier added a new task in the ToDo list [1] to create KUnit
tests for the functions present in "drm_format_helper".

This patch, marked as RFC to start the conversation, includes tests for
"drm_fb_xrgb8888_to_rgb332".

Since the conversion functions present in "drm_format_helper" convert
from XRGB8888 to another format, my plan is to create a set of XRGB8888
data to test all the available conversions.

To illustrate it with an example, the code present in this patch:

	{
		.name = "Single pixel source",
		.pitch = 1 * 4,
		.dst_pitch = 0,
		.clip = CLIP(0, 0, 1, 1),
		.xrgb8888 = { 0x01FF0000 },
		.expected = { 0xE0 },
	}

In a follow up patch, should look like:

	{
		.name = "Single pixel source",
		.pitch = 1 * 4,
		.clip = CLIP(0, 0, 1, 1),
		.xrgb8888 = { 0x01FF0000 },
		.expected = {
			{
				.dst_format = DRM_FORMAT_RGB332,
				.dst_pitch = 0,
				.conv_func = drm_fb_xrgb8888_to_rgb332,
				.result = { 0xE0 },
			},
			{ ... },
		},
	}

What is tested?

 - Different values for the X in XRGB8888 to make sure it is ignored
 - Different clip values: Single pixel and full and partial buffer
 - Well know colors: White, black, red, green, blue, magenta, yellow
   and cyan
 - Other colors: Randomly picked
 - Destination pitch

What is NOT tested?

 - NULL destination buffer: Because there is not validation in place
 - Out of bounds destination buffer: The size of the buffer is not
   checked. The conversion function could cause out of bound errors
 - Out of bounds source buffer: Similary to the destination buffer, the
   source buffer is read without checking its size
 - Invalid clip values: Because there is no clip validation.
   Example: clip out of or bigger than the source buffer
 - Invalid destination pitch: A dst_pitch < (clip->width * dst_pixsize)
   could cause issues.
 - "Big" source buffers. I don't know if this kind of tests could be of
   interest

How to run the tests?

 My .kunitconfig:

 	CONFIG_KUNIT=y
 	CONFIG_DRM=y
 	CONFIG_DRM_FORMAR_HELPER_TEST=y

 $ ./tools/testing/kunit/kunit.py run --arch=x86_64

Feedback?

 It'd be great to know your ideas about what else we could test, if you
 think that we should make the functions safer by checking the buffers
 and clip sizes or anything else.

Thanks a lot,
José Expósito

[1] https://cgit.freedesktop.org/drm/drm-misc/commit/?id=596c35b1440e

José Expósito (1):
  drm/format-helper: Add KUnit tests for drm_fb_xrgb8888_to_rgb332()

 drivers/gpu/drm/Kconfig                  |  12 ++
 drivers/gpu/drm/Makefile                 |   3 +
 drivers/gpu/drm/drm_format_helper_test.c | 166 +++++++++++++++++++++++
 3 files changed, 181 insertions(+)
 create mode 100644 drivers/gpu/drm/drm_format_helper_test.c

-- 
2.25.1

