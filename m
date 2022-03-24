Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0C74E643B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 14:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350521AbiCXNmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 09:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242339AbiCXNmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 09:42:09 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CECBA7777
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 06:40:38 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id a12-20020a25938c000000b0063467614126so3588950ybm.13
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 06:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=C/BnJKMJEeV8BFoBzBXZm96RIax/W1fb5Ij7o/AsFUY=;
        b=I5r3XueZuY2fFEJBQooGi7gGjzI2M6XTWZJbSSqpBHqZEDBRjs23ELQv+MaLam20gS
         HOUvaKIvKTzfDuxnGlhWHV1awOQClZC13qC5dYMPd6LdPodeULLxGTuIykA4wXX8DKPT
         t5CDgvB3VSiLzr4FTuibjgE3YNSQ9WeikcXR1mD1GBmZI8JqNdFBG/wyO9AFpvG2qv6e
         EjiewN5jQCS4w6yTZRu0uFg29AprjobE7MxGZLR5e3f11tpuOXDqu4LFZ1TQR0wPtoMV
         Nhf+WkQSCcPhfzmx91IPOQedBHGJhzcnFoJ3RoAKIygBAplidLdh8VikpiAYWZYVIhBN
         swAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=C/BnJKMJEeV8BFoBzBXZm96RIax/W1fb5Ij7o/AsFUY=;
        b=3VEa90S44kYnCX0xYgcSqBmOSs+tNkS0+JU1X0hXKjrm2FDY9DIKBOT1XIOTGJh6LF
         +C/7bMsTdgZZYlCRojxd8MF5UWsZh66gKce2jgcTwJtTmlYZO98ecDH+nhW0hAv97Ira
         Nv4T/hr/MqUYldmdw8LyWjZV6WBbTRREACArhsMjDiTO02MhItuXDvPrfKo1Zi5UDm5q
         fg+dQ5mdJ+UGfJ4mNajSJpqH+JFPIQ0g31pa/+M7PWouLNm4hDlvbWddyfbMNY3MrZyj
         6PNyIUeZwkOMZMcZakdL6SM88L3JPalvH1hI+b2g36sAAmA+UWMPyWcauATGYgUAdwHL
         Xn+g==
X-Gm-Message-State: AOAM530JTZAY8O4LwzmMeIA9YKbCxOfsS+7AuAbEWF5r4h3V7AxFKsJv
        eKJre5VWn6wKxwCjAnlRsgpYNqGbS3zO
X-Google-Smtp-Source: ABdhPJweQHmVV0UUx5aJF4XSf3mwT0CfS9APEo0gOtx/klTIZrZS7Nmxl9l15vxPFIn60fKz0VjEENXw93jx
X-Received: from ezekiel.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:108e])
 (user=shraash job=sendgmr) by 2002:a81:144a:0:b0:2e6:c2bd:b724 with SMTP id
 71-20020a81144a000000b002e6c2bdb724mr2226691ywu.270.1648129237510; Thu, 24
 Mar 2022 06:40:37 -0700 (PDT)
Date:   Thu, 24 Mar 2022 19:10:31 +0530
Message-Id: <20220324134031.2648315-1-shraash@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
Subject: [PATCH v2] drm/amd/display: Fix unused-but-set-variable warning
From:   Aashish Sharma <shraash@google.com>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Pan Xinhui <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>,
        Jake Wang <haonan.wang2@amd.com>,
        Anson Jacob <Anson.Jacob@amd.com>,
        Guenter Roeck <groeck@chromium.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>, Anthony Koo <Anthony.Koo@amd.com>,
        Wayne Lin <wayne.lin@amd.com>, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Aashish Sharma <shraash@google.com>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the kernel test robot warning below:

drivers/gpu/drm/amd/amdgpu/../display/dmub/inc/dmub_cmd.h:2893:12:
warning: variable 'temp' set but not used [-Wunused-but-set-variable]

Replaced the assignment to the unused temp variable with READ_ONCE()
macro to flush the writes. READ_ONCE() helps avoid the use of
volatile and makes it obvious from the code that the read here is
intentional. Also verified on x86 that the generated code is exactly the
same as before.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Aashish Sharma <shraash@google.com>
---
v2: Removed unnecessary volatile qualifier in the typecast and an unnecessary comment. Also reworded the commit message.
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 873ecd04e01d..a58f460f431d 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -2913,13 +2913,11 @@ static inline void dmub_rb_flush_pending(const struct dmub_rb *rb)
 	uint32_t wptr = rb->wrpt;
 
 	while (rptr != wptr) {
-		uint64_t volatile *data = (uint64_t volatile *)((uint8_t *)(rb->base_address) + rptr);
-		//uint64_t volatile *p = (uint64_t volatile *)data;
-		uint64_t temp;
+		uint64_t *data = (uint64_t *)((uint8_t *)(rb->base_address) + rptr);
 		uint8_t i;
 
 		for (i = 0; i < DMUB_RB_CMD_SIZE / sizeof(uint64_t); i++)
-			temp = *data++;
+			(void)READ_ONCE(*data++);
 
 		rptr += DMUB_RB_CMD_SIZE;
 		if (rptr >= rb->capacity)
-- 
2.35.1.894.gb6a874cedc-goog

