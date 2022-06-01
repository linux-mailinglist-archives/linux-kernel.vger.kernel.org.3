Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8950539BC0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 05:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348876AbiFADjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 23:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbiFADjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 23:39:45 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5574D56228
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 20:39:44 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 3-20020a17090a174300b001e426a02ac5so1716279pjm.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 20:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BPt4dtaBXbbIz680GXjnifuabCoTnOqD29Zad6avBJU=;
        b=nw+3kMrrmiyzaKACHZawVtj2we71BB5rDBesnCh9NO42UAU718xHv+4OYahFJFuudK
         XcOIvtvKkfOQRmKQbxLr3rpnJupgBTVZVE0UORaYwSPeVqlZq9GYTT6Q/lX/oz9rHd2o
         /DESQ/UO2QFTUZm6469k5wjrjP+S2uB6joXn+Zls/op8LrYiLuOjwbsT2uOyRunC+A+2
         52j7OHCnkYe+FzrnjQvhkTSrJv7cPASgbNAdiLyczJegw1in7RVxFRV+7BwE9A4KT6gp
         FDR0Ucl3BNIj+Flg8wlS4WzhO678o9gmW8MJqi41oB3mIz5HW8/B0peaR4pBwmmuHE4R
         yyLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BPt4dtaBXbbIz680GXjnifuabCoTnOqD29Zad6avBJU=;
        b=YM7nxv7wARfn4td6t+7objKvxyJqa4iswDNQ+JqmPXuRKaxMczguygyopq/HprJAuC
         rhgxUMnx/BiKbt6cwL034QvJU96ko2XmvNsWVBI5bsP+ghu7/+pZ1uyRFpiblOPvTYuE
         tez7/BBOKg39nBa8O5fbj0bo7VuYAYhIG9ttc/aHf/afNe70a3B/MlLawJ79Bm+bUG/O
         Y+FtyityU+0UBaer0ahBINRDdqbXJVXU7eXe/2THAgOsaowX5EoqV625zz10/Iu0NKEQ
         Biz6TilSAJTlNsl1RaoTm8dkgnoKH7XBtl5h0SkSE44tyuZM+efmnHtEp1lqiAkN1daW
         3HYg==
X-Gm-Message-State: AOAM533vLDqugFU/E4ULUhq7UYNShDIX+niT6ilmCOEvLtevI3uDEJwP
        5PQJKSpHtzorwxY/k+o/xp8=
X-Google-Smtp-Source: ABdhPJxer3AeLgoZLp4VQP+/nNyqbXOlRUDTKhy9HqMSwV7nbJJY3xIQCZ34bWrRjeUsoLJRduE3bg==
X-Received: by 2002:a17:90a:ab90:b0:1da:375f:2f44 with SMTP id n16-20020a17090aab9000b001da375f2f44mr31928040pjq.33.1654054783864;
        Tue, 31 May 2022 20:39:43 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id dw15-20020a17090b094f00b001e0b971196csm2732415pjb.57.2022.05.31.20.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 20:39:43 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Miaoqian Lin <linmq006@gmail.com>
Subject: [PATCH v2 0/2] drm/meson: Fix refcount leak
Date:   Wed,  1 Jun 2022 07:39:25 +0400
Message-Id: <20220601033927.47814-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following patchset fix two refcount leak bugs.
The cause of the bugs are missing of_node_put() 
after of_graph_get_remote_node().

changes in v2:
- patch#2:Fixed patch in meson_encoder_hdmi_init, call of_node_put() 
  after of_find_device_by_node() and error paths before that. 
  noted by Martin Blumenstingl <martin.blumenstingl@googlemail.com>

(patch#1: no changes since v1)

v1 link:
patch#1: https://lore.kernel.org/r/20220531144818.26943-1-linmq006@gmail.com/ 
patch#2: https://lore.kernel.org/r/20220531144818.26943-2-linmq006@gmail.com/


Miaoqian Lin (2):
  drm/meson: encoder_cvbs: Fix refcount leak in meson_encoder_cvbs_init
  drm/meson: encoder_hdmi: Fix refcount leak in meson_encoder_hdmi_init

 drivers/gpu/drm/meson/meson_encoder_cvbs.c |  1 +
 drivers/gpu/drm/meson/meson_encoder_hdmi.c | 15 +++++++++++----
 2 files changed, 12 insertions(+), 4 deletions(-)

-- 
2.25.1

