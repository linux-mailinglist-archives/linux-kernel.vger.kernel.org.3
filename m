Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 957E8595942
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 13:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235104AbiHPLDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 07:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235084AbiHPLDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 07:03:01 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A3571BED
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 03:29:13 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id j26so2787043wms.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 03:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=KFNiCUdXTrEiAGiz+4FQbAw1rF3AEPapoVwJtLEaQ9g=;
        b=pLl9wgCJPBpAaPBgmBmy0+7N5b3VHGocJ9PLCcmKSttmVZMVQMA5WEaSWLumu+44oQ
         mIaFuoENpibdoIIOWFTJEvv3PHvNH7ng5VyzcEOQwCKZhBmVAi/dl/jk4KDnnOhKxB+5
         1AXE6MpJlQCPXESMuDi62G56fRHhixGcGytm+pfQ9pgKtn3uMNUS/SPP8zWvOe3uZxEW
         6QfssBudlzVoxaGqyDMDtDgy10rr7/x5bbf7/KelB9YqpRCrAdCxFPzLSEedDw04gv+r
         fNA77mgsIn+V630dzHDimwD7rbNsa0J2GO8gFyImcLba2r/Y9w9hZZotQGtIPu9Ojvh9
         Dniw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=KFNiCUdXTrEiAGiz+4FQbAw1rF3AEPapoVwJtLEaQ9g=;
        b=wswLSno7MGz5xcXq93m2FqAPGIODIsy1rWx2lWkaEAgx0PruIBMw0A3Ia1mdEaNNNk
         KKObC5lc21+z7uWPieP0DDJDkY3pXsSQ3pNWOgy7svJ2lOrGX18pzjO4ezya3EissHAz
         L2ytRWFTDkhHavxru1s6v40r+/x/I5OvEdeDuADhmaLtKRafvENSPoza179y5ICFbKgv
         SqO1uaaY8ksdI7Wjunix99eFsnt9iLgCwYYhXR3QXlsw8/axaPwMPa1NSN+WuGNIGyhs
         WllttwMoJu7/hGOEXO+B5Zf9NeLVeZ/CIAaVQibV0EcQl27J9fLQQ63X/Af9a3l6vefz
         L+ug==
X-Gm-Message-State: ACgBeo1ex3a1ywuGeW4Yf0vjtGvXc6x2SPMA2c0DWfoqNt3XNrR3YkXm
        AFcmBWsg7EyHtS1EdE8MC0E=
X-Google-Smtp-Source: AA6agR6qUGwb4CpPib/vdpS1BwS6mngZO3z+s86OwgGv9ciLUEA6YtJkII4a18RqRQ/RwCj9Z4CMhQ==
X-Received: by 2002:a05:600c:4f02:b0:3a5:fc0f:9566 with SMTP id l2-20020a05600c4f0200b003a5fc0f9566mr4261092wmq.107.1660645751897;
        Tue, 16 Aug 2022 03:29:11 -0700 (PDT)
Received: from localhost.localdomain ([94.73.32.249])
        by smtp.gmail.com with ESMTPSA id m9-20020adffe49000000b002251639bfd0sm1668407wrs.59.2022.08.16.03.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 03:29:11 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     javierm@redhat.com
Cc:     davidgow@google.com, dlatypov@google.com, tzimmermann@suse.de,
        mripard@kernel.org, daniel@ffwll.ch, airlied@linux.ie,
        maarten.lankhorst@linux.intel.com, jani.nikula@linux.intel.com,
        maira.canal@usp.br, isabbasso@riseup.net, magalilemes00@gmail.com,
        tales.aparecida@gmail.com, geert@linux-m68k.org,
        dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH 0/3] KUnit tests for RGB888, XRGB2101010 and grayscale
Date:   Tue, 16 Aug 2022 12:29:00 +0200
Message-Id: <20220816102903.276879-1-jose.exposito89@gmail.com>
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

This series is a follow up on my work adding KUnit test to the XRGB8888
conversion functions. This time RGB888, XRGB2101010 and gray8 are added.

Best wishes,
Jose

José Expósito (3):
  drm/format-helper: Add KUnit tests for drm_fb_xrgb8888_to_rgb888()
  drm/format-helper: Add KUnit tests for
    drm_fb_xrgb8888_to_xrgb2101010()
  drm/format-helper: Add KUnit tests for drm_fb_xrgb8888_to_gray8()

 .../gpu/drm/tests/drm_format_helper_test.c    | 190 ++++++++++++++++++
 1 file changed, 190 insertions(+)

-- 
2.25.1

