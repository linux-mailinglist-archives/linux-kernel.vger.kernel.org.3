Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFDFD508747
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 13:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350130AbiDTLsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 07:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236926AbiDTLsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 07:48:21 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1A83FBD3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 04:45:35 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id bv16so1868874wrb.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 04:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/QL7YZ3qS3dDL6elW1m3EUQ1/zKIu/qSDBiWvoRLGXc=;
        b=lfqAS9kAemetWxb1ZkjqPeO7rTkHusUYZmrWo08jYNb5avWHChjNLpJbJwsEQIYHlo
         ZrjozpYmWfXVEH6IokgOkIuLRAQMymd0tIW+kP33tcdpc2eVR945IZfOnfg0SLDbTImj
         E56fBCN6/7iYr4IfdtBLwTc7a4cQXMXOY1ZRDr0d75MjHYc115nQfjjMUdqlHsjsz0ao
         I2xTkEpGVcGck9fQXkTtyYoG0Eqa2Qrdi921CXH2SujFEu+p6H4kiNCUNo5i3daajMvk
         bt92WTffZMGxCw2wFxadIyE+XevhKEkVn2nxjSz5zCdAl2XnqGD/ey7PztdQODwbUibs
         lMkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/QL7YZ3qS3dDL6elW1m3EUQ1/zKIu/qSDBiWvoRLGXc=;
        b=sNt4OpPVkGCqpEXIjlUGqP0kUz4D3ChtgRZVQp3LBOZN3xO4k6VJLK8/9jzHkB/tJX
         X/xw8lQL8mC83pZCHs+UGJleKJmBrQYW9f3I8RZPG8xmJ5YmyGcGdq52ZbiFSHtoaLGP
         WyZ4o5leQNrRmzBHWZfwpMANEyusxxAhPKMPvlQdGppvhIFaSAhK/c33WePp97P7PRWY
         Hkt/EEaoVzUKej758kXu1yul99q2qHRS+3VtZILAwiYDXStlshb9uda2hnnloVvJ+lQX
         nf2DtMztHjXJ1DoZ3FRe6HGCPx1yRUzvvc/xJFwgoEkwNy5L5aZs/BJiUur9e5ZrFpR7
         P1OA==
X-Gm-Message-State: AOAM530XeqgkUeHvkKwIDkFoXUqqlmCbyB8scaCWkBZ/s3KsjUqVQ/XD
        W5Pgkxhi2pO0J1S9r10g8WE=
X-Google-Smtp-Source: ABdhPJyKwKxl4PoPz8cPDlCO04lSXWS3fheRSE5AnvMWzBwX7KwT1r+BfmumjuVz6vzfAEiBuPK6EQ==
X-Received: by 2002:a05:6000:2c5:b0:20a:9675:d26c with SMTP id o5-20020a05600002c500b0020a9675d26cmr11024560wry.185.1650455133639;
        Wed, 20 Apr 2022 04:45:33 -0700 (PDT)
Received: from localhost.localdomain ([94.73.37.128])
        by smtp.gmail.com with ESMTPSA id i74-20020adf90d0000000b0020373ba7beesm17798204wri.0.2022.04.20.04.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 04:45:33 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     emma@anholt.net
Cc:     mripard@kernel.org, laurent.pinchart@ideasonboard.com,
        airlied@linux.ie, daniel@ffwll.ch, p.zabel@pengutronix.de,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v3 0/2] drm/vc4: hdmi: Replace drm_detect_hdmi_monitor() with drm_display_info.is_hdmi
Date:   Wed, 20 Apr 2022 13:44:58 +0200
Message-Id: <20220420114500.187664-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

These patches replace the calls to drm_detect_hdmi_monitor() with the
more efficient drm_display_info.is_hdmi in the VC4 driver and, since
this makes the vc4_hdmi_encoder struct redundant, also removes it.

Thanks,
José Expósito

v1: https://lore.kernel.org/dri-devel/20220406165514.6106-1-jose.exposito89@gmail.com/

v2: https://lore.kernel.org/dri-devel/20220415154745.170597-1-jose.exposito89@gmail.com/T/
    Add the ftrace command used in the first patch
    Remove vc4_hdmi_encoder.hdmi_monitor
    (Thanks to Maxime for suggesting these changes)

v3: Squash the patches present in v2
    Remove vc4_hdmi_encoder
    (Thanks to Maxime for suggesting these changes)

José Expósito (2):
  drm/vc4: hdmi: Replace drm_detect_hdmi_monitor() with is_hdmi
  drm/vc4: hdmi: Remove vc4_hdmi_encoder

 drivers/gpu/drm/vc4/vc4_hdmi.c | 41 +++++++++++++++-------------------
 drivers/gpu/drm/vc4/vc4_hdmi.h | 17 ++------------
 2 files changed, 20 insertions(+), 38 deletions(-)

-- 
2.25.1

