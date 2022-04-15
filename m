Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C587502F6B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 21:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349083AbiDOTyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 15:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235878AbiDOTyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 15:54:37 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E63606FE;
        Fri, 15 Apr 2022 12:52:07 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-d39f741ba0so8827918fac.13;
        Fri, 15 Apr 2022 12:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ABdsEHFBVFytMQQqom9Dq43qRmto9saZ7i+2oM3Eku0=;
        b=ZGmZOBcY/dum/HWURvtRCvnWPOUxnrUeSYhZgHFLtNGWIWV6xBsJ+eQCUBAFtqxc+6
         RX2qMrOOXbtgKRof8PuQjOaDgyue+4xnPKsWyqloiY877RDQVTgIXuEDKkaNinoJGYvT
         quuSym8jsN84P1pm4Gtdj72/yzvL4YY0RRPohYT1kX5y63sr6/zGuk9BTmtIl97awcNE
         OtZQ64T+7/WL6zY9yKrOB5O7Hkc2WWUgnBBkps9pFBQ+J6Um+79KcjCBV/SEKHa6ZRBB
         IqqktfpNCN4lD3lgbXDCHgVhA6bkUwtjRC68YIdN5hpNkvFZ6+o8BGbqOkBKJn2M5fGo
         Wdww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ABdsEHFBVFytMQQqom9Dq43qRmto9saZ7i+2oM3Eku0=;
        b=GUCUbdpF87vNEdA9GNmBHC9lO6A2sI87wxIXbufc5qOdB7N1V0QPDMux7RY5W6JxP8
         pUGoy+ihmiAASEFEPBixEDS/TQG8mL51X+jKJiuxI6htDu5T6GmmhVzswaZZy5DmOu2T
         kDh6WSWUro+qAX6lrURZ3H1AiSjcTDrXR1ZSvL4duob3H69i6G3Ngug1rovbzqlLba8+
         LQSP8gbLB34ze7f8+UtySOsgpPw0TQg/9NgJB0Ukhu5/I2b+Kf4Abjb8gt3zQ8uU4zjj
         vdAUuDH7WlMN4fA65H5SQagDY+1s7jdpGaNReK6zqUjvM78w2PPSFQSGmKbyx+BtmM2K
         dKcw==
X-Gm-Message-State: AOAM531th8rRt2qFSbBshlus806tJvnm+lLLbX2y4ECC3680keAYEP9u
        Oh49lUu/1kwT9BYxs8TrjLE=
X-Google-Smtp-Source: ABdhPJx3nwNYb48HFRzO6VjBy6Z8M7a9mKfeurhvlRtcYBZf5WQPQGnHCmScGHPj/L9SUh4ng5I0Rg==
X-Received: by 2002:a05:6870:4708:b0:e2:c9d6:2be7 with SMTP id b8-20020a056870470800b000e2c9d62be7mr1997842oaq.195.1650052327143;
        Fri, 15 Apr 2022 12:52:07 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:4c2:8a9b:dcc3:45ee:2581:b4cb])
        by smtp.gmail.com with ESMTPSA id c20-20020a4a2854000000b00329d3f076aasm1436532oof.24.2022.04.15.12.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 12:52:06 -0700 (PDT)
From:   Tales Lelo da Aparecida <tales.aparecida@gmail.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jonathan Corbet <corbet@lwn.net>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        andrealmeid@riseup.net
Cc:     Tales Lelo da Aparecida <tales.aparecida@gmail.com>
Subject: [PATCH 0/2] Update AMDGPU glossary and MAINTAINERS
Date:   Fri, 15 Apr 2022 16:50:25 -0300
Message-Id: <20220415195027.305019-1-tales.aparecida@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I was handling the request from [0] and then I noticed that some AMD
developers were missing from get_maintainers output due to the lack of a
reference to their documentation in the MAINTAINERS file.

[0] https://gitlab.freedesktop.org/drm/amd/-/issues/1939#note_1309737

Tales Lelo da Aparecida (2):
  Documentation/gpu: Add entries to amdgpu glossary
  MAINTAINERS: add docs entry to AMDGPU

 Documentation/gpu/amdgpu/amdgpu-glossary.rst | 13 +++++++++++++
 MAINTAINERS                                  |  1 +
 2 files changed, 14 insertions(+)

-- 
2.35.1

