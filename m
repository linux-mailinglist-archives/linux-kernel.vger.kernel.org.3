Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C053B5991C0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 02:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240173AbiHSA3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 20:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243261AbiHSA3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 20:29:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132B17B289
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 17:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660868961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=QjKDaOf5VrUR9aSan2WIUuQM3BhgteOS+VRIFGCRBQA=;
        b=dYHCzmkXiQttu03DI6qIY05+CEGx+7kBI533Dxpe2QjmPpyzCDVEU+ct6ZWkyHuEibqgBs
        /XIrOtpmJM4ACL8n7o5FDIYCQo3RsPQ2n/OMI+OWk48FSuCJhtNuS3wC5CNkgBtiyNxdIk
        de8CIZtllAdmegXvCYAoTxiz7eb9Z3w=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-639-rYWBLkzzPzyuag8J59Y72Q-1; Thu, 18 Aug 2022 20:29:11 -0400
X-MC-Unique: rYWBLkzzPzyuag8J59Y72Q-1
Received: by mail-ed1-f70.google.com with SMTP id t13-20020a056402524d00b0043db1fbefdeso1843535edd.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 17:29:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=QjKDaOf5VrUR9aSan2WIUuQM3BhgteOS+VRIFGCRBQA=;
        b=HZYOUDJMqmxrcJ8aSA0+Z8GtUrSPffd8mSWcqSeLnIBGhZVNysW9K2D9hJkUohfPCJ
         otFm6XwT0BchzlsY2CtxbKlsZrgII9htl7OObiGy5vz9tnowcJvhGP26gx6Tl+ISrOzb
         6vhzf0z3+8AHOMACUCw7msbG3liUp79SHMoBsJSMFUQqPaeQd4PUhkhIbmQ60ZqO/JVw
         Nj60oTGAHT/bxyiultHAx8Yx77mAx+IJLelHPiuTYkX/wEwixjhuSpZyJrMTBkR9rQDJ
         ZRim+PPduSDnpl9Lbm/81T1bP/P+mevqoP2mC1D2rZRZlSsR8RXS4erS8/gV9/FZGBIO
         aUgg==
X-Gm-Message-State: ACgBeo2Q8uJPx87fFQScmpkHFg6ElxyhpC2VtL8LgopYRUkHk0dQI4SJ
        6dT/V69RJKtAEcXaRc2guAYhUsHKvfh4lQJKuPY9bIakBzogqDSmYclJ+Cjd7FB9aK/wNsB47Zp
        z/sh03zMuo738f24pOg6RV3i5
X-Received: by 2002:a17:907:b19:b0:730:b0d8:750 with SMTP id h25-20020a1709070b1900b00730b0d80750mr3251511ejl.46.1660868950481;
        Thu, 18 Aug 2022 17:29:10 -0700 (PDT)
X-Google-Smtp-Source: AA6agR41UEbU7E96B5pVjIewvKNNPfANaqzwVo+RAQVp2oV943hHXtlWHyB65FWfFjj1qjf2AX2dHA==
X-Received: by 2002:a17:907:b19:b0:730:b0d8:750 with SMTP id h25-20020a1709070b1900b00730b0d80750mr3251501ejl.46.1660868950316;
        Thu, 18 Aug 2022 17:29:10 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id b26-20020aa7cd1a000000b004460b020ffdsm2027913edw.83.2022.08.18.17.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 17:29:09 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next 0/3] Fixes for vc4 hotplug rework
Date:   Fri, 19 Aug 2022 02:29:02 +0200
Message-Id: <20220819002905.82095-1-dakr@redhat.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
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

Danilo Krummrich (3):
  drm/vc4: hdmi: unlock mutex when device is unplugged
  drm/vc4: plane: protect device resources after removal
  drm/vc4: crtc: protect device resources after removal

 drivers/gpu/drm/vc4/vc4_crtc.c  | 41 ++++++++++++++++++++++++++++++++-
 drivers/gpu/drm/vc4/vc4_drv.h   |  1 +
 drivers/gpu/drm/vc4/vc4_hdmi.c  |  7 ++++--
 drivers/gpu/drm/vc4/vc4_plane.c | 25 ++++++++++++++++++++
 4 files changed, 71 insertions(+), 3 deletions(-)


base-commit: 8ba9249396bef37cb68be9e8dee7847f1737db9d
-- 
2.37.2

