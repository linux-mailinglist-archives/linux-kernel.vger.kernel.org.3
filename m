Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5615858BBCC
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 18:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234675AbiHGQId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 12:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234574AbiHGQIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 12:08:31 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8F531A;
        Sun,  7 Aug 2022 09:08:30 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id 130so6179247pfv.13;
        Sun, 07 Aug 2022 09:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=9lYXINAlxxMxWSbvsI8AJB5wGlCbPGWBgmb6qoY0xm4=;
        b=IH48HU+yBYTwc9qdZzvzUxgNlNeks30xd71AMuY3ez+dGWeGXnBepsiQpvwtEH5rSW
         lDYUOwdbEzdASRdPaLs2kUMdmKtWIdgjUAtr2W00kYAXlndCaFvef9O2DYYqAJwUE+Rv
         XOJJbQHJdWSn+/uV6CD8rlRSKVLruFZCD8ounOaJPF+lEeL9t0B1G7vCu1zCQ5FI6aC8
         RCsve2l7jsFutTZaFqrR8KqLjfhp83QYl+hZq68Tn9TyMSLvo5lOGJCxcZWTs9Pfc1UU
         iCNgeXquOLsLkcv9e/ciGDBH6JF7yDGsmdwK1IK5HieLrSPy12u2WKJ4vLr5vfO+fmx9
         SB3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=9lYXINAlxxMxWSbvsI8AJB5wGlCbPGWBgmb6qoY0xm4=;
        b=HRQZwyfE4rhI4dyZ7YxO61XDDalfW5qMNP4DcM/fb0KvyaiSUT1ZKUQiqNrk/BzmKh
         ACU34efP+ypBL+eN+zsaGcnKXrfMouydVe1zwKUhvtWb8O0ffeqr1svZgh65m/JhJ4uA
         9H1gVssfhIyhcFymQXS3XsBDYeVuJRk3o/HiEhXZK12DR889frWMf3BCI2fXmnXXgLu9
         lS7WBissS1i68QaRSPMjxyiDUvX92qLg7KfyK67hMTHAtqYmQBiprdI/H6vYT9o2YWvr
         BDR+/WLfQRj9Kn5b1mn4H1kcKzyhvnqwxOZqKij8LZ7426sBiCxeJKTYACeSUrr/a3XS
         Id8w==
X-Gm-Message-State: ACgBeo110errbWEgkMG4Ee9xriw0hG+bP92Zh0Ori/y0QotwAFgzDnzG
        2tJal0F86gUibzVO1osztcPZ2km8BW4=
X-Google-Smtp-Source: AA6agR56DsDoQD7dIlG0cvuCFwpuPtU4SPqqFkEziNS2V0+r1vJoPi5RRMirTbA0oKKqpwuk/ACe0A==
X-Received: by 2002:a63:6e81:0:b0:419:f7b1:4b12 with SMTP id j123-20020a636e81000000b00419f7b14b12mr12551127pgc.406.1659888510120;
        Sun, 07 Aug 2022 09:08:30 -0700 (PDT)
Received: from localhost ([2601:1c0:5200:a6:307:a401:7b76:c6e5])
        by smtp.gmail.com with ESMTPSA id g2-20020a1709026b4200b0016db51ca7dfsm6881539plt.15.2022.08.07.09.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Aug 2022 09:08:29 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/2] drm/msm/rd: Fix FIFO-full deadlock
Date:   Sun,  7 Aug 2022 09:09:01 -0700
Message-Id: <20220807160901.2353471-2-robdclark@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220807160901.2353471-1-robdclark@gmail.com>
References: <20220807160901.2353471-1-robdclark@gmail.com>
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

