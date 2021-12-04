Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F112468444
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 11:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384731AbhLDK7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 05:59:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233089AbhLDK7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 05:59:02 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC83C061751
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 02:55:36 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id z7so12769879lfi.11
        for <linux-kernel@vger.kernel.org>; Sat, 04 Dec 2021 02:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FCkCzyCkQsr6lD8NR06VdRlHwx59JsbS+9tz0//jskM=;
        b=J8+qxK9EdGdyapFivPTb/MszsVmYUxohS5F9uvi1Ju40hDEsymJubYkiJcww+/2mXJ
         dFk4d52mcpjL8ZkkJQCOBnupJ8E3CUIVUtR3g8DLhn4mM0CnI1QA9CIvrxVbVbhEQ8X/
         URSzKnSKgbpl0bishq9Sz8qvcRDFeAsbgFZTjZygcoAxicVI5Tq1Vzch1OqbrDr7JwUO
         yKgcd7QVmtiZBsqFQGAv+YxYLAVyufoPz9Dw3+OwMndCcwdTjxXoJklJEm3kh+ZdNi3O
         xFQCFHwiSapg1zeKL8wPTCEzuXnD9N74jQlqfvqyVJaNIv8q0dB5NcMkHsq54OUo0N+1
         vavQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FCkCzyCkQsr6lD8NR06VdRlHwx59JsbS+9tz0//jskM=;
        b=sLt9/d3vHuv+5wI2cAj4aoFWUiSbYCN9bMS0zrbZVRJJs6H327yWA0YTqvvolMCgB5
         exH9UmLvSJPsTbMel3QA4v/MK+y6zFCZs3zgaedsi3xO7T/f6BpqqJ+a7+zxPVnN2IcF
         gKQhdRmWMXzzXrYjj0hUfJcQvawk5bT/9NEU5kp9BOsMr7eqDwY/4s4WyH+a2NDdVhkq
         bzXqFW9SN6GMhJ1dovmVNLmBipMKKBll3U2wzmR9F+g+LsgzRM58KvHj/FhUlduR1aSS
         J+LdyJFyq3Iep4Z4g8ypvoONP2S9fUqfRlAUlhhVIYaHzqJYxMakPVP6tdt/KEBfu4Bn
         43Ug==
X-Gm-Message-State: AOAM530wy3h8Jc3Ah6lsnyhmoiod6pC+tYzw4aQGkz1rPJ5xWF4ZrBLZ
        QNE83waS8/X7wAdtWq4h//g=
X-Google-Smtp-Source: ABdhPJwnAJQyUH//9HfN3vFABTOSGXTkJU5rsHVw8lsbp9mJMIIesfzVjE0MCDKbHa3t2bmmeND6Wg==
X-Received: by 2002:ac2:4e61:: with SMTP id y1mr24147055lfs.459.1638615334878;
        Sat, 04 Dec 2021 02:55:34 -0800 (PST)
Received: from localhost.localdomain (h-155-4-221-129.NA.cust.bahnhof.se. [155.4.221.129])
        by smtp.gmail.com with ESMTPSA id d23sm723918lfm.107.2021.12.04.02.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 02:55:34 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 0/9] drm/i915/gvt: Constify static structs
Date:   Sat,  4 Dec 2021 11:55:18 +0100
Message-Id: <20211204105527.15741-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Constify a number of static structs that are never modified to allow the
compiler to put them in read-only memory. In order to do this, constify a
number of local variables and pointers in structs.

This is most important for structs that contain function pointers, and
the patches for those structs are placed first in the series.

Rikard Falkeborn (9):
  drm/i915/gvt: Constify intel_gvt_gtt_pte_ops
  drm/i915/gvt: Constify intel_gvt_gtt_pte_ops
  drm/i915/gvt: Constify intel_gvt_irq_ops
  drm/i915/gvt: Constify intel_gvt_sched_policy_ops
  drm/i915/gvt: Constify gvt_mmio_block
  drm/i915/gvt: Constify cmd_interrupt_events
  drm/i915/gvt: Constify formats
  drm/i915/gvt: Constify gtt_type_table_entry
  drm/i915/gvt: Constify vgpu_types

 drivers/gpu/drm/i915/gvt/cmd_parser.c   |  2 +-
 drivers/gpu/drm/i915/gvt/fb_decoder.c   | 24 ++++-----
 drivers/gpu/drm/i915/gvt/gtt.c          | 68 ++++++++++++-------------
 drivers/gpu/drm/i915/gvt/gtt.h          |  4 +-
 drivers/gpu/drm/i915/gvt/gvt.h          |  2 +-
 drivers/gpu/drm/i915/gvt/handlers.c     | 12 ++---
 drivers/gpu/drm/i915/gvt/interrupt.c    | 10 ++--
 drivers/gpu/drm/i915/gvt/interrupt.h    |  2 +-
 drivers/gpu/drm/i915/gvt/sched_policy.c |  2 +-
 drivers/gpu/drm/i915/gvt/scheduler.h    |  2 +-
 drivers/gpu/drm/i915/gvt/vgpu.c         |  4 +-
 11 files changed, 66 insertions(+), 66 deletions(-)

-- 
2.34.1

