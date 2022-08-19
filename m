Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05BEB599A95
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 13:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348606AbiHSLJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 07:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348311AbiHSLI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 07:08:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28BDC0E6C
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 04:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660907335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZqI5vZLpia5ct5t7JuYb11QdDPq9USkS4MLCaMGWylI=;
        b=JGzRGqQQzn8zUru0GyL1TwK9KNOAgRKewTzqGMxVF8jN6gFGMOpfLdFBHhwCgx1jLY2pWV
        VSS5DqECOd6NNQCXXVJzUQ2Vuyx91pQqnuB+zXHzuRdBpPKvLGsK1oxtbZmxKKe2tdDjx4
        wUs7FSGUrgDsOoA2zHWJdUuYy0nIAGc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-54-lit0Wj7tNIudK1bwzHrKAA-1; Fri, 19 Aug 2022 07:08:54 -0400
X-MC-Unique: lit0Wj7tNIudK1bwzHrKAA-1
Received: by mail-ej1-f70.google.com with SMTP id ho13-20020a1709070e8d00b00730a655e173so1381692ejc.8
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 04:08:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=ZqI5vZLpia5ct5t7JuYb11QdDPq9USkS4MLCaMGWylI=;
        b=K9fHM/5SfgYFAGcawEaljAT+H0JyWM6O9E4/gLIRMPR265R1cCmwcbE/ld+J5B0OFd
         WyUUhNj6cFeedGAHzWuglURoYZhp8c8lYBYwK3DJtOEp8rSySr2QQnsBqTXG9t69R0/T
         eMb9mUzMAc+cCGiddOqbKQl5dXeY9OpOMIdpJF+0nQnJeyg5l1GRYnODB46kh7vRUcmF
         v2QTFJaiTBLN2btb3frRCKtloQ/RqViC3ainDG5tAm3w3X8dNHbjU8PdsKxTtRAjTg1E
         yfs/DYjTNLTjPptduXFecCD+xC5W3grjQ9Ss5INen0QlynfEy+6Hou/N6jqtxzRWDp4R
         PTGQ==
X-Gm-Message-State: ACgBeo2732yASGPYYHAlXXiQC2OYWigAkrrcWVGuLTpbYowOTDpNMdUb
        N9Gh5pqmLM33KWpnNw7x/699lGyJas6loPoXPgMKabaaI+wJSCVOA39bGDHNl2BHAAB2NSTo5nK
        4TIBvc7Q9/GSGX+lBtZ0d/doG
X-Received: by 2002:a17:907:7214:b0:731:465d:a77c with SMTP id dr20-20020a170907721400b00731465da77cmr4444777ejc.308.1660907333303;
        Fri, 19 Aug 2022 04:08:53 -0700 (PDT)
X-Google-Smtp-Source: AA6agR73kb35vu9cHeWsEco9u/k6H/Hyebp7jx52dcbEuWBWpQkfXhPntXEIALCybwbQfWKXG12SEg==
X-Received: by 2002:a17:907:7214:b0:731:465d:a77c with SMTP id dr20-20020a170907721400b00731465da77cmr4444764ejc.308.1660907333157;
        Fri, 19 Aug 2022 04:08:53 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id l17-20020a1709060cd100b007308fab3eb7sm2167827ejh.195.2022.08.19.04.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 04:08:52 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next v2 0/4] Fixes for vc4 hotplug rework
Date:   Fri, 19 Aug 2022 13:08:45 +0200
Message-Id: <20220819110849.192037-1-dakr@redhat.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've found a few potential issues left after the hotplug rework.

In vc4_hdmi.c we're missing two mutex_unlock() calls when the device is
unplugged.

vc4_crtc and vc4_plane seem to miss some drm_dev_enter()/drm_dev_exit() calls
to protect against resource access after the device/driver is unbound, but the
DRM potentially isn't freed yet and userspace can still call into the driver.

Changes in v2:
  - Use drm_device pointer from struct drm_plane (Maxime)
  - Protect entire functions to increase readability (Maxime)
  - Add another patch to fix an uncovered MMIO access in vc4_hvs.c

Danilo Krummrich (4):
  drm/vc4: hdmi: unlock mutex when device is unplugged
  drm/vc4: plane: protect device resources after removal
  drm/vc4: crtc: protect device resources after removal
  drm/vc4: hvs: protect drm_print_regset32()

 drivers/gpu/drm/vc4/vc4_crtc.c  | 41 ++++++++++++++++++++++++++++++++-
 drivers/gpu/drm/vc4/vc4_hdmi.c  |  7 ++++--
 drivers/gpu/drm/vc4/vc4_hvs.c   |  4 ++--
 drivers/gpu/drm/vc4/vc4_plane.c | 20 ++++++++++++++++
 4 files changed, 67 insertions(+), 5 deletions(-)


base-commit: 8ba9249396bef37cb68be9e8dee7847f1737db9d
-- 
2.37.2

