Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAAA5589135
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 19:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238001AbiHCRWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 13:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237884AbiHCRWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 13:22:35 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E7E52FD9;
        Wed,  3 Aug 2022 10:22:34 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id p14-20020a17090a74ce00b001f4d04492faso2806458pjl.4;
        Wed, 03 Aug 2022 10:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=9lYXINAlxxMxWSbvsI8AJB5wGlCbPGWBgmb6qoY0xm4=;
        b=icUeEm2PKM5WXTxzKJFNcPkN/1w9jNcDpqXthRNOePTbuqlNuwmsHAHZh0UYrco2uV
         lXR+rVyNGmoAWv2aWAhcNwvpmQzwtQesbe+v/Vzh/lmNO5VFrkMlvjCx1WaQz+PFah+h
         nTS71/uWhVJcrBUL5v0Rh5eVesXhkBSiPFXfVDPdFjGvxOeSPA5xtcsNWf4+Ub3z+cMc
         6Fz98feK5mr4tkjugDJfIg1LD6KD2ldbfQ8BeLTqMnNiCsbCvMoO1loqoZA2xHNycKDK
         jv5vbUFjaZiD8X/ER6DfsPMdoKir8DziTFI6T8paN+D6pEsBOjegHkOKpkn2FYbpFvzC
         IXBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=9lYXINAlxxMxWSbvsI8AJB5wGlCbPGWBgmb6qoY0xm4=;
        b=SBt7pKBe9ERS+2WV7MswMCIz56NMoJjsGkJIyf0sgzyJhUARZtxE5JI5h/XUobItuq
         Ui6kpdNJWMGZs3Ji0hwAp9rq/wGDvi6d5IOgoKLd51pKTo21OAHimc6dxawroy71b1if
         gsylA1nk9dW4w9apt2P2hJm7PwjFVvOFwgYBt66g6M8QduZDRIXNJ9JIR6we+jR8VvCm
         BSxyLhworNkWiLVebzctdwRsZKnmQ280OCLQO25PKbEctFYvgjpR1fo6ZYVISMtkKD20
         4ThfFOGTpLyaS5TPbmkOj2GsOXniHlnw388QWHYBFJ8Get/Jag5G14qHQSk8gQ6g4Azs
         O/0w==
X-Gm-Message-State: ACgBeo0qqd6DUU6OKUGMx3fHKZLZOsHNCBYYhcMxhJjenqeCSBeMvow9
        Nsm+eInU5N+FSqUh3LSV/X2EeeBx9ZQ=
X-Google-Smtp-Source: AA6agR4anjaSlbUEFkuNTyBJBYjx1Dfme76YDiiwhXa3CuIz6Y3YjdykMMx8iwP5lYQ+74B54uQZXg==
X-Received: by 2002:a17:90b:1c8e:b0:1f1:b5a8:330f with SMTP id oo14-20020a17090b1c8e00b001f1b5a8330fmr5815071pjb.179.1659547353432;
        Wed, 03 Aug 2022 10:22:33 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id j12-20020a170903024c00b0016d01c133e1sm2226044plh.248.2022.08.03.10.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 10:22:31 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] drm/msm/rd: Fix FIFO-full deadlock
Date:   Wed,  3 Aug 2022 10:23:02 -0700
Message-Id: <20220803172302.1976981-2-robdclark@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220803172302.1976981-1-robdclark@gmail.com>
References: <20220803172302.1976981-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

If the previous thing cat'ing $debugfs/rd left the FIFO full, then
subsequent open could deadlock in rd_write() (because open is blocked,
not giving a chance for read() to consume any data in the FIFO).  Also
it is generally a good idea to clear out old data from the FIFO.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_rd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_rd.c b/drivers/gpu/drm/msm/msm_rd.c
index a92ffde53f0b..db2f847c8535 100644
--- a/drivers/gpu/drm/msm/msm_rd.c
+++ b/drivers/gpu/drm/msm/msm_rd.c
@@ -196,6 +196,9 @@ static int rd_open(struct inode *inode, struct file *file)
 	file->private_data = rd;
 	rd->open = true;
 
+	/* Reset fifo to clear any previously unread data: */
+	rd->fifo.head = rd->fifo.tail = 0;
+
 	/* the parsing tools need to know gpu-id to know which
 	 * register database to load.
 	 *
-- 
2.36.1

