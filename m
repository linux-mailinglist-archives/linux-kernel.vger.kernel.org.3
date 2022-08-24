Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8511F59FF39
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 18:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238996AbiHXQOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 12:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238860AbiHXQNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 12:13:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF1B9834E
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 09:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661357623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=oSUiGfUcaLftnhFHbJ63fBQreSrudDWQdJ97QjeIClY=;
        b=Os5q9zJX/Un0RzHtRrdC+rniqT/bY3gTF4qsojXXKvS4sz5R0tWiE5GbRXqg5ohUZ2Hu2V
        hKSPJslhI1B98uMengPDkbwDlw1Z/Sexh0aGMZQSyw0j+EVl1TU7iaP3q2G7pvDV5Iky2E
        gMLRtY5pDDZmKQupeZTD6sozXmpK76E=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-426-YKKhV7X1NMaOsBqSfGzeeQ-1; Wed, 24 Aug 2022 12:13:35 -0400
X-MC-Unique: YKKhV7X1NMaOsBqSfGzeeQ-1
Received: by mail-ed1-f70.google.com with SMTP id s3-20020a056402520300b00446f5068565so4754911edd.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 09:13:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=oSUiGfUcaLftnhFHbJ63fBQreSrudDWQdJ97QjeIClY=;
        b=y49XEKpg9UWhSWqlqw6EQzzos2lQ1O+VdYLEvzL+ndz19HmQEXU/MGpbmlv7ajwlB/
         UqlkTXua2ICUj8Iwnivy5oIPBqmFKvBuLTLhGJsfVLyJG339ofuyN54IpgBCWbtF4l1l
         cwD/Is5A2o31ckYjdxP3KTXzDpEv38RcixcozXCrC2C9kFSXjoitxxk2w8ismzl+hEhY
         E0clJCe3C2KRZVzKrrMElLATCembMbttWgrBQ6aOp0lsLjH79M6UHr94ys97Mqn0lTol
         4e/KVf+gQHUuzOC3u29eJQ9b6/3N4KPhayZWNGC6RaiyPIEnr/ImiXWEEnWiZK/3BxEX
         4ALA==
X-Gm-Message-State: ACgBeo3TzKcojppBxxjMQ1Y13fXqsmTR7edkZfv7AH7ohXphP5fhXsTW
        zIz5K/dyp6qz5e8X0HV90Rf6pIxWWG2cZNZ58kaTDB3qbYevqeJSQQ/h8mYVdDWIGVrQyhPqWUv
        haqVYdd3bQToTPCb8QdguQD6o
X-Received: by 2002:a17:907:7615:b0:730:e1ad:b132 with SMTP id jx21-20020a170907761500b00730e1adb132mr3363040ejc.744.1661357614006;
        Wed, 24 Aug 2022 09:13:34 -0700 (PDT)
X-Google-Smtp-Source: AA6agR69EPCk9q905SAjfACG4R3hCH9I2FLwlrZOUitIQbz2LPC/YyVVwrrbmVQexaMoItcz8M5Kqg==
X-Received: by 2002:a17:907:7615:b0:730:e1ad:b132 with SMTP id jx21-20020a170907761500b00730e1adb132mr3363030ejc.744.1661357613817;
        Wed, 24 Aug 2022 09:13:33 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id da12-20020a056402176c00b004478fdbe190sm791536edb.10.2022.08.24.09.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 09:13:32 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next v3 0/4] Fixes for vc4 hotplug rework
Date:   Wed, 24 Aug 2022 18:13:23 +0200
Message-Id: <20220824161327.330627-1-dakr@redhat.com>
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

Changes in v3:
  - vc4_plane: Actually protect entire functions to increase readability (Maxime)

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


base-commit: 4d07b0bc403403438d9cf88450506240c5faf92f
-- 
2.37.2

