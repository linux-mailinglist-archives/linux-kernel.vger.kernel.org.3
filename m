Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA0685A7367
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 03:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbiHaBfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 21:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbiHaBfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 21:35:13 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B195193F7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 18:35:04 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id n65-20020a17090a5ac700b001fbb4fad865so13596018pji.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 18:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=JVftubc6KuRp3jMxakTu7sb8RAmy7skK2pVT1PxM25o=;
        b=cMy3guYSxEFyWIHVXlr8oksM36Y3sMAwvAgvJHSo7Wc1VgjW0Tayprba0syLeZ/G5J
         5oRhiSiUwE047aaS8BCbsZBML6KkQCztALGvE4m+VrIP0kx78DRCzZMeMowoqChwJTpc
         2KqR7aDDTZO5uEd94b0SJVXgH5E8ZeYAyiKLXVZRdKQyBicUHmESRsubf5/ff7VAi20A
         DCsIZxfaUZej7nnN1WAsjJ0psocbT+vG4E+b7IqkHAzF2/C691SDO9AeN0KEWozeW0og
         yfegvHcRl1LRDdWAo9Vg8mtwwF3GlQcs3Kl4LwNH/3ukRlP4Q1KT16Rzq3dxNJYKQjEH
         hIeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=JVftubc6KuRp3jMxakTu7sb8RAmy7skK2pVT1PxM25o=;
        b=uwZe6aeq+ueurQF7LrnP4P5HPGsYeIKjMQtYbkbigVe5SvBMbqyE+iGd6Rie4oTO+V
         HwVMDpsgnwCXG0kVf4CI9leQ3MOYoUGtLhn+ysZEcpmAdnmMLabYPIrZ7xv4bLbjlpIm
         sq1XkHjiTxQAeQmRBTGNbyjxK8X1sjqdD8I9jnSWRdH3N0R5cnJqbWgIjo1r3tR63b9J
         bXPNaxI71MjtZabRjok6aKjAzKeB9brcjDO7qm7pFwi+oGMiBO2MG7nSzqX38r5Yxkqo
         m7bwkX48sjIQBg3hNdNJ3yZUoI2rpKBu6+o+iJuyBww7uQU6kWCe8DH2gsbMOESgyhRt
         +IGw==
X-Gm-Message-State: ACgBeo0EVpJOZBi5JncolNEr6G0P4sqqbIQs0OJFMtgDuN5S7u92jCOW
        XhrmwGyEIxH6QlV/7kFSBLLO6RzIncRDyw==
X-Google-Smtp-Source: AA6agR4MBVEJ8wrauAtQ76q7SlsBGMsjHuUkXJsmX0qQMM4J+5MZoeAks2bsWSO2lUtOPY5tNWbySA==
X-Received: by 2002:a17:902:b603:b0:174:8a6b:8e0d with SMTP id b3-20020a170902b60300b001748a6b8e0dmr16461501pls.105.1661909680224;
        Tue, 30 Aug 2022 18:34:40 -0700 (PDT)
Received: from always-x1.bytedance.net ([61.120.150.74])
        by smtp.gmail.com with ESMTPSA id r36-20020a17090a43a700b001f50e4c43c4sm202891pjg.22.2022.08.30.18.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 18:34:39 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     hch@lst.de, sagi@grimberg.me
Cc:     kch@nvidia.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH v2 0/1] nvmet-tcp: Fix NULL pointer dereference during release
Date:   Wed, 31 Aug 2022 09:34:01 +0800
Message-Id: <20220831013402.514055-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1 -> v2:
- Seperate nvmet_tcp_uninit_data_in_cmds() into nvmet_tcp_uninit_req()
  & nvmet_tcp_uninit_data_in_cmds()(free buffers only).

v1:
- Move nvmet_tcp_uninit_data_in_cmds() after nvmet_sq_destroy()

zhenwei pi (1):
  nvmet-tcp: Fix NULL pointer dereference during release

 drivers/nvme/target/tcp.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

-- 
2.20.1

