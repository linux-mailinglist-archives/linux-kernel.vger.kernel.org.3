Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C2955D391
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239060AbiF0QNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 12:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239062AbiF0QNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 12:13:07 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64331186E5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 09:13:06 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id v14so13772568wra.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 09:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a1MrvTqvIfFE1DLoz9CdoV+in2eBMF3sxgIBKiM8yW0=;
        b=X0jT9IRbNuMsEB2h6kzvXBPWXj3PZPi9jw4O/kxTUHEEbnWqpIwWAXp/uzrWWwJokF
         1a+xWXnWj9BpwJVTioz9vlBTfgCV0OaZa3A4mB3OkYIoTiA3gq1D+/3Ls1XMbx8qqxh+
         sCBPnzXK840axQpy5puDpRQwb9A76eWEFs2gx50Ij9UNxcaxF4S9/UCLB/Fg/4q5q5Fu
         wzGtafHvH3ij0sF6lVpY5pkOBNjMacJFbwSe2ciodINrT3FBQE50fJYOU++k1a6NQrMf
         C81ozLGk5IP1/Km49RYUB2+zLRdF8KYwHATagfovqaL5s3h0zMS3NJ/0y3/ESYczS8iR
         MyCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a1MrvTqvIfFE1DLoz9CdoV+in2eBMF3sxgIBKiM8yW0=;
        b=MsXTjuUPw3eB9Z/f0xbBqPBcvyG6zpH0k7Z2yESl5fTowd+t1rrCid2HdUxniNKtYA
         C68+sYsjiHBCJRZmrKiHUo3SuQpn3/lckBjGQyiYEE1dN1D6kNNRc3J1Qwr8oCpYvjKP
         JlefHy9O0I8n8R0m8XxNKNQ7pr3hzDaSGtA7g1HcUsGk16uOBPexiI0lOpJS5nawslHv
         WrKtxPpTMCPP3cbPrvPzFApDYgvg0X8l5JlHiFBziHUotYhh+CCLfkROxDJP00wMqcBv
         Nc7RZ2saI/OWgN0/qKqChyj3cP9am/Hf/Z5C9E1RyTD3334/W/s5eHGp8gtFehFytsnp
         SpGA==
X-Gm-Message-State: AJIora8qZqRHAx3hCMUPRy/B8cC8Lb2oXZKGXHqe+15b5RMiXjRkpdEL
        o0GHsQm8KStWcg+AdJANaCg=
X-Google-Smtp-Source: AGRyM1tsz/6f8R32H0yygTzWN6cFTNY3UxpMEIk0ImSTAxspk5+RlVigYHyWlWlVC6VPVcTLxE1oSQ==
X-Received: by 2002:a5d:6c6b:0:b0:1ea:77ea:dde8 with SMTP id r11-20020a5d6c6b000000b001ea77eadde8mr13474056wrz.690.1656346384844;
        Mon, 27 Jun 2022 09:13:04 -0700 (PDT)
Received: from localhost.localdomain ([94.73.36.128])
        by smtp.gmail.com with ESMTPSA id c7-20020adffb47000000b0021b9504cc83sm10883600wrs.31.2022.06.27.09.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 09:13:04 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     javierm@redhat.com
Cc:     davidgow@google.com, dlatypov@google.com, tzimmermann@suse.de,
        mripard@kernel.org, daniel@ffwll.ch, airlied@linux.ie,
        maarten.lankhorst@linux.intel.com, jani.nikula@linux.intel.com,
        maira.canal@usp.br, isabbasso@riseup.net, magalilemes00@gmail.com,
        tales.aparecida@gmail.com, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH 0/4] KUnit tests for RGB565 conversion
Date:   Mon, 27 Jun 2022 18:11:28 +0200
Message-Id: <20220627161132.33256-1-jose.exposito89@gmail.com>
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

This series is a follow up of the XRGB8888 to RGB332 conversion KUnit tests.

The first 3 patches refactor the existing test to make them agnostic of the target format and add support for "swab".

The last patch adds the RGB565 conversion values, and shows how more formats will be easily added in the future.

Thank you very much in advance for your feedback,
José Expósito

José Expósito (4):
  drm/format-helper: Rename test cases to make them more generic
  drm/format-helper: Transform tests to be agnostic of target format
  drm/format-helper: Add support for conversion functions with swab
  drm/format-helper: Add KUnit tests for drm_fb_xrgb8888_to_rgb565()

 .../gpu/drm/tests/drm_format_helper_test.c    | 231 +++++++++++++++---
 1 file changed, 196 insertions(+), 35 deletions(-)


base-commit: 6fde8eec71796f3534f0c274066862829813b21f
prerequisite-patch-id: 8a16f4c8004d6161035eaea275c8eafaa0ac927e
prerequisite-patch-id: 53fded2a49e6212b546db76ec52563a683752e65
prerequisite-patch-id: 294b0ca27a6ee57096c8f097c0572336b8a2d583
prerequisite-patch-id: 5e05bfc5287d16c207bfc616b2776ad72eb4ab29
prerequisite-patch-id: e94560be85dffb62a5b3cf58d1f0fc3d278ad806
prerequisite-patch-id: a471df39c7b32c69dd2b138a7d0af015ea42e00a
-- 
2.25.1

