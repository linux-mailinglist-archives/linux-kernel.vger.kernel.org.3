Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A3F59A93A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 01:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243569AbiHSXLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 19:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236190AbiHSXLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 19:11:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B049CB8A42
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 16:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660950664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=AtnN6jebhmIGGhubsNu0FAYV6P8gfd744zQ5EQW7o6I=;
        b=J+0tox3YlEcrkg26Y+vcKSJUzIXWOW7gsyNmV9V6P5WJehg6ab9V8/2mZWhTPrl16CPRIV
        mFC/1sa3ZeJJlmyVFIAUsvrHrZHkJdNdml0vsocsHJkwlw6Rl2gKvZZ/3oXyDLwf6CFW9g
        MV9jstLlKWnziXZXM2LsqtWcf4RR58U=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-503-YAFtoQF7MAWTnezogrDNPQ-1; Fri, 19 Aug 2022 19:11:03 -0400
X-MC-Unique: YAFtoQF7MAWTnezogrDNPQ-1
Received: by mail-ej1-f72.google.com with SMTP id hs4-20020a1709073e8400b0073d66965277so42588ejc.6
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 16:11:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=AtnN6jebhmIGGhubsNu0FAYV6P8gfd744zQ5EQW7o6I=;
        b=o/Y8c2fe5XsdjrJCbJi2lUq+i2miqNbALbelZevfWVidTKbM1Kg8KbmhqzU4uHKGDi
         og/AVKWpZGf8nYa0x4gD8Y6yRpiJeL5RPUGrtuNxz7Fi5Gp+ZCVuGRHFmknOvt/O0f2O
         uv4KPfLKnNHNQXJ3kcKIpY7w9VsYkWL++cpcQQtjqi/iQu5jiLfeg3paI/EL2CDsJKO0
         booeKJqQ5ixSS1LTzKxX0O61Z1j8rJZOl7PwEiTkgCjAW1928PKig6Dwh6IL4oUpZS6L
         Bqt2+EbVR2d2sWoJeQ6/o0F4bwKV+5eZgq4MuQMYugz/l2J4OBSn8ttfiWDcBHtSqWex
         DOEA==
X-Gm-Message-State: ACgBeo3RJ8s7r12LQhQ7aGR6qAqfFEcPe12PqIQ6n304UslvZ33dC2cf
        9TYSx/y84p3kreIaPJwjyP965NHGMv4rZaeYVwX15u3/Q96PImpyv9FHRs+xfvkZLCnncizA9Pv
        CFs0Gn6PgZ5Fwkgjyx3Q5gpTd
X-Received: by 2002:a17:906:8a73:b0:730:9af8:b335 with SMTP id hy19-20020a1709068a7300b007309af8b335mr6434589ejc.14.1660950662118;
        Fri, 19 Aug 2022 16:11:02 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7NBEOsuPoam3rZcTPy0EjMDMllWg/Gb0657kWfoZyVC8nmly7FDaP4Aw8yt3ZTCCA2Q0I9QA==
X-Received: by 2002:a17:906:8a73:b0:730:9af8:b335 with SMTP id hy19-20020a1709068a7300b007309af8b335mr6434581ejc.14.1660950661899;
        Fri, 19 Aug 2022 16:11:01 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id ss28-20020a170907c01c00b00730a18a8b68sm2887088ejc.130.2022.08.19.16.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 16:11:01 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, liviu.dudau@arm.com, brian.starkey@arm.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next 0/7] drm/arm/hdlcd: use drm managed resources
Date:   Sat, 20 Aug 2022 01:10:51 +0200
Message-Id: <20220819231058.647658-1-dakr@redhat.com>
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

This patch series converts the driver to use drm managed resources to prevent
potential use-after-free issues on driver unbind/rebind and to get rid of the
usage of deprecated APIs.

Danilo Krummrich (7):
  drm/arm/hdlcd: use drmm_* to allocate driver structures
  drm/arm/hdlcd: replace drm->dev_private with drm_to_hdlcd_priv()
  drm/arm/hdlcd: crtc: use drmm_crtc_init_with_planes()
  drm/arm/hdlcd: plane: use drm managed resources
  drm/arm/hdlcd: use drm_dev_unplug()
  drm/arm/hdlcd: crtc: protect device resources after removal
  drm/arm/hdlcd: debugfs: protect device resources after removal

 drivers/gpu/drm/arm/hdlcd_crtc.c | 78 ++++++++++++++++++++++++--------
 drivers/gpu/drm/arm/hdlcd_drv.c  | 36 ++++++++-------
 drivers/gpu/drm/arm/hdlcd_drv.h  |  2 +
 3 files changed, 79 insertions(+), 37 deletions(-)


base-commit: 8869fa666a9e6782c3c896c1fa57d65adca23249
-- 
2.37.2

