Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECF0453F2CC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 01:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235357AbiFFXwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 19:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235334AbiFFXv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 19:51:58 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DEF1ADA9
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 16:51:57 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id k5-20020a17090a404500b001e8875e6242so3169334pjg.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 16:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1RFyXYoYG1d/O/MId2w1B4qXmXmbYcy40FEdfUxvDQ0=;
        b=Cn3xLCJxxjoTsVuwqp4QaegknKudM2FH3/d/+nJkjzf4H1AvVDp/IgClVKDfHZJ2A2
         jACgpuyFCU00hBNTwxrs1EueGiz3NjE//n6nfUgIMPTiqfYvnQeyna7MqsO6S5qHtI+V
         tF8lvzR57RWx+SLLgvn+Qqgw7S+zESJVXQYn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1RFyXYoYG1d/O/MId2w1B4qXmXmbYcy40FEdfUxvDQ0=;
        b=vo6/7O8ReUqX9JrHXdxlK3wsDFEEZsEychaLkvvhxHA8XcauFsTxYbRKp0bx+cV0uK
         LWX++hcA2jyaKj7+dQvQLwetvN24XmfGjv5slga4dIyZD1kPE40oiJk63T0/UPoEflIa
         ADUtBJPmYm2cvMxtb5Rw0M4F4PWC4RWEsGgoUgX8rnDycQpZqCSqQra94XDb8lS0aVwA
         3xB6nrwvlu9igTVCSv393AL1o+KXoiTCvgLnf4cDcObT+Re1hZWtDC48FDp9puaaAsBQ
         CMHRKI8Ckn1N89Brw6yg5ZgrP03gmIs3+Gh3fxplvaIupCnl8T3gE1HlMDg0dZ6rseDr
         2bzA==
X-Gm-Message-State: AOAM5331hovQ9FKdydspJwQ9TxdBRS+2Eib0RyIIwUPurh80YPexSKGO
        a/SKthOUjTqoBlmBUTOvQntwgCJ2I1hFMQ==
X-Google-Smtp-Source: ABdhPJzmrGgJHv3Bva+srWmCfwk6Cq0f7P99pevSkJYxd09EjqAPoGwRWZ7+0eiFwXeNjYxkmOiYlw==
X-Received: by 2002:a17:902:d4ca:b0:164:1971:1504 with SMTP id o10-20020a170902d4ca00b0016419711504mr26181185plg.138.1654559517315;
        Mon, 06 Jun 2022 16:51:57 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:7100:486c:d20:242a])
        by smtp.gmail.com with ESMTPSA id 66-20020a621445000000b0050dc762816dsm11005789pfu.71.2022.06.06.16.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 16:51:57 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Alex Elder <elder@linaro.org>,
        Georgi Djakov <djakov@kernel.org>
Subject: [PATCH 5.15 0/2] Fix suspend on qcom sc7180 SoCs
Date:   Mon,  6 Jun 2022 16:51:53 -0700
Message-Id: <20220606235155.2437168-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two patches fix suspend on sc7180 boards, i.e. Trogdor, on 5.15
stable kernels. Without these two patches the IP0 interconnect is kept
on forever, and suspend fails because XO shutdown can't be achieved.

Mike Tipton (1):
  interconnect: qcom: icc-rpmh: Add BCMs to commit list in pre_aggregate

Stephen Boyd (1):
  interconnect: qcom: sc7180: Drop IP0 interconnects

 drivers/interconnect/qcom/icc-rpmh.c | 10 +++++-----
 drivers/interconnect/qcom/sc7180.c   | 21 ---------------------
 drivers/interconnect/qcom/sm8150.c   |  1 -
 drivers/interconnect/qcom/sm8250.c   |  1 -
 drivers/interconnect/qcom/sm8350.c   |  1 -
 5 files changed, 5 insertions(+), 29 deletions(-)

-- 
https://chromeos.dev

