Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82E214FB8BA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 11:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344917AbiDKJ7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 05:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235994AbiDKJ6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 05:58:53 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E1B4132F;
        Mon, 11 Apr 2022 02:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1649670999;
  x=1681206999;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=c+CrCB3jSesuxm+UkvkLWNLlRUO9xSMBS+b8dMwF3PA=;
  b=QyIe7OCRSMcAsqUbaa8O58WhCvigFyiSxb67W0PHbg9MReXk3MltTnMB
   oIyDZT0L2KITsd89dpLFqLsOW4oeE3gkEDdK8IP7yEmaTWxt8rUqyu93g
   wVYljRI3oJFIU7BEQ+vSoscnrPiBiIelb75ojvahPvQx5rMcMejDrkXtp
   q10aR7gHplbAykMo2PX9iJHI65QkCgK+rcuU7HkKJhzruYD3UNKu92pDi
   OHsT8mlJ55HNi1Og6yAjra2nsR91jdcvucDm1mOUNf17KlFIqetUIIqI6
   XZqKDHNYTXxx8gpEtubVt2TP/5aoX5Q4cTfNPB1J6k/uML3cQLTPO8ct0
   Q==;
From:   Camel Guo <camel.guo@axis.com>
To:     <inux@roeck-us.net>, <jdelvare@suse.com>, <robh+dt@kernel.org>,
        <krzk+dt@kernel.org>
CC:     <kernel@axis.com>, Camel Guo <camel.guo@axis.com>,
        <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] hwmon/tmp401: add support of three advanced features
Date:   Mon, 11 Apr 2022 11:56:32 +0200
Message-ID: <20220411095634.1782732-1-camel.guo@axis.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According the their datasheets:
- TMP401, TMP411 and TMP43x support extended temperature range;
- TMP411 and TMP43x support n-factor correction;
- TMP43x support beta compensation.

In order to make it possible for users to enable these features and set up them
based on their needs, this patch series adds the following devicetree bindings:
- ti,extended-range-enable;
- ti,n-factor;
- ti,beta-compensation.
In the meanwhile, tmp401 driver reads them and configures the coressponding
registers accordingly.

Cc: linux-hwmon@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Camel Guo (2):
  dt-bindings: hwmon: Add TMP401, TMP411 and TMP43x
  hwmon: (tmp401) Add support of three advanced features

 .../devicetree/bindings/hwmon/ti,tmp401.yaml  | 111 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 drivers/hwmon/tmp401.c                        |  43 ++++++-
 3 files changed, 154 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/ti,tmp401.yaml


base-commit: ce522ba9ef7e2d9fb22a39eb3371c0c64e2a433e
-- 
2.30.2

