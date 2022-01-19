Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5B4493853
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 11:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346812AbiASKXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 05:23:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345318AbiASKXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 05:23:41 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D304C061574;
        Wed, 19 Jan 2022 02:23:41 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id cx27so9060791edb.1;
        Wed, 19 Jan 2022 02:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=3V1hkQQ8p02w19W2KJ4UIkOLnzPRTwmn+qldd2MXUPQ=;
        b=UTo4S6CngQrJK8inLCfGWdWffEF0VzWr1c/MOQ1tFDrsrVrZ2mAB2ipU4q8se7EDgP
         DxrG+gFyvjHymumc0w0C//05G17T8pZn00KF0kHUFN3nScd5YTzTsp0NRNrs3heL5Bvi
         y9yUHhEmCCkO4RvvhAe2HcFBhB746ja7VQVbcwmtCU/SOFj97PFDVCmtw36MYYcibD2l
         veksT8cLoWJVeyInIBAHfIt+ZBYyAP36ijhiDIIFVLjpaiw8DvoQSB9SNqZoAcnTYyok
         0SVy87GQx60xuhIfksZdK6fDIhjU1RPGsKzP6rU4hFH3Msz9Vu8056eqeSAmLWw2S+qj
         92gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3V1hkQQ8p02w19W2KJ4UIkOLnzPRTwmn+qldd2MXUPQ=;
        b=Dj3BZZTLaGLRYohW0D+FJuCAxM5aNmYGHan7W5+n8V4wFj8GxcrpRT8pVo0HmUBZUt
         HzIyBQIwWz+QDZe5sGhBTGtDrTtlKAD6ifptcS9NjgRunjbbNkg6qpDqgS+7duhoLSdX
         Ga3PX7YiHaOMCxIpHqqgDiRPj12sCrEH4E6S0HEkb8ky6VGGCw2LYW1JsEODbU87i8Bl
         IoB61oQ6TfSUtL6SK9no9S3VnilFOJu2ORvOrUwmVbtJT4+uftq5By6RIkXMZNlrT7CQ
         a+edvTvAnN5XwY5f/Yb48eRrblMkDjtQOSdPVQQ3Zyfc+WGGkW4pRpSdRbFUDSRzgKpy
         pQ4g==
X-Gm-Message-State: AOAM5326ekMhJlozU9/wiBTO0HRFgG5uWYrdtICw0e1GP40ivVJowxb3
        hEbsRVQHn3uER9Ppw5vQop/FXpkvYV0=
X-Google-Smtp-Source: ABdhPJy2oLLsHT/am6MhkOkALSn5DKiBobM4zLi8a2dn9ReGunq9jvnFMb84OTVkOzMwU3NwADfz7g==
X-Received: by 2002:a17:906:4fd6:: with SMTP id i22mr23777188ejw.484.1642587819967;
        Wed, 19 Jan 2022 02:23:39 -0800 (PST)
Received: from localhost.localdomain ([46.249.74.23])
        by smtp.gmail.com with ESMTPSA id b4sm3456546ejb.131.2022.01.19.02.23.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jan 2022 02:23:39 -0800 (PST)
From:   Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To:     tomba@kernel.org, airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, merlijn@wizzup.org, tony@atomide.com,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH 0/3] drm: omapdrm: Fix excessive GEM buffers DMM/CMA usage
Date:   Wed, 19 Jan 2022 12:23:08 +0200
Message-Id: <1642587791-13222-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series fixes excessive DMM or CMA usage of GEM buffers leading to
various runtime allocation failures. The series enables daily usage of devices
without exausting limited resources like CMA or DMM space if GPU rendering is
needed.

The first patch doesn't bring any functional changes, it just moves some
TILER/DMM related code to a separate function, to simplify the review of the
next two patches.

The second patch allows off-CPU rendering to non-scanout buffers. Without that
patch, it is basically impossible to use the driver allocated GEM buffers on
OMAP3 for anything else but a basic CPU rendered examples as if we want GPU
rendering, we must allocate buffers as scanout buffers, which are CMA allocated.
CMA soon gets fragmented and we start seeing allocation failures. Such failres
in Xorg cannot be handeled gracefully, so the system is basically unusable.

Third patch fixes similar issue on OMAP4/5, where DMM/TILER spaces get
fragmented with time, leading to allocation failures.

Series were tested on Motolola Droid4 and Nokia N900, with OMAP DDX and
PVR EXA from https://github.com/maemo-leste/xf86-video-omap

Ivaylo Dimitrov (3):
  drm: omapdrm: simplify omap_gem_pin
  drm: omapdrm: Support exporting of non-contiguous GEM BOs
  drm: omapdrm: Do no allocate non-scanout GEMs through DMM/TILER

 drivers/gpu/drm/omapdrm/omap_gem.c        | 198 +++++++++++++++++-------------
 drivers/gpu/drm/omapdrm/omap_gem.h        |   3 +-
 drivers/gpu/drm/omapdrm/omap_gem_dmabuf.c |   5 +-
 3 files changed, 116 insertions(+), 90 deletions(-)

-- 
1.9.1

