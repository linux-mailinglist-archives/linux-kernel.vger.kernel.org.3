Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98BB44FF5E4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 13:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235202AbiDMLmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 07:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiDMLmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 07:42:43 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C9F13EA8;
        Wed, 13 Apr 2022 04:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1649850022;
  x=1681386022;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=R1v3bqRBIlw84WGtOns3QKyfgPJLZ0JRNyvr6sqnmqY=;
  b=fs9xA9X+8E1N4aMyYxVkAaW6z8U5NwU4vX+I0UKu5Pn0wfq0ecsE0aW6
   7YpckDzq/7otC0vRXLs4rp/vHtaZmVL8IekqIzOL84bFWjp+UfzMsQqGf
   sa4Cwn/NXvmTksCLyObB2CIzTeg9jdpdRor3hq2NRLeoCVRAZ0Gouoxyh
   v9gHSBewQHD3XmwfGHKI0ppyUXk8PNWzbutX12SCV0ws93YLSdIGdB/sV
   e3ZcjpvOMPhqP4BDc7nKhnhsNwnMAXyxrCgbYdGZA/+gnX5SdzbKHmOnc
   Wn5PHiJBqK9t/KO0PgmrQxYGdSizaMrmH6AOI7qy6P2Sd8LCGozMkV5HK
   A==;
From:   Camel Guo <camel.guo@axis.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
CC:     Camel Guo <camel.guo@axis.com>, <linux-hwmon@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>
Subject: [PATCH v3 0/2] hwmon/tmp401: add support of three advanced features
Date:   Wed, 13 Apr 2022 13:40:11 +0200
Message-ID: <20220413114014.2204623-1-camel.guo@axis.com>
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

v3:
- dt-bindings: remove unused [address|size]_cells and ti,beta-compensation.items
  from ti,tmp401.yaml;
- dt-bindings: change ti,n-factor range to [-128, 127];
- tmp401.c: instead of u32, use s32 for ti,n-factor.

v2:
- dt-bindings: fix format and describe hardware properties instead of
  programming models in ti,tmp401.yaml.

Cc: linux-hwmon@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Camel Guo (2):
  dt-bindings: hwmon: Add TMP401, TMP411 and TMP43x
  hwmon: (tmp401) Add support of three advanced features

 .../devicetree/bindings/hwmon/ti,tmp401.yaml  | 105 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 drivers/hwmon/tmp401.c                        |  44 +++++++-
 3 files changed, 149 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/ti,tmp401.yaml


base-commit: ce522ba9ef7e2d9fb22a39eb3371c0c64e2a433e
-- 
2.30.2

