Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA89569D38
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 10:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235276AbiGGIUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 04:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235261AbiGGITj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 04:19:39 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C32250715
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 01:18:49 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id o25so31099725ejm.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 01:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D/RvvGHcCHFo/5jSRy9Ox2PI6Zkn3y7KAtfIwVEzPIQ=;
        b=SP+ZldLI9wlqq8InQInFS5medRPnbVLRnil97By+qHy5GrdrSr0sGdZNEjsnuN5VLU
         PPGw2QBwoxsyzxYr4CkK0seEzBuLjhxFSfxjK04ccUbaZS1uhH4lD7MK2By1xjxwG4HI
         DsicMDx6UH/GzZv582z3Gu11nSWqk63lpXbdZFEAZ0XbILq8zvR6qdBAxyV7A89nu9Kb
         w26D6hoALGgHdgqLiAJF70IRDeiL7UAgpuwJCI1uJy/CIbRFCVG3vcZWzndOHZg1pRpH
         F7ZBExFUxP8qFVmJz3NzxwGWvKbKHQdAr9Ja9A9U7syiU+S+IMa+JdTJ4gWLuXhTmYfr
         ibsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D/RvvGHcCHFo/5jSRy9Ox2PI6Zkn3y7KAtfIwVEzPIQ=;
        b=1tWFcxgeLAlQHZVebhW9o1rS3JkpySwH9V7rz6LdjNyJ4uYxdYqodAK3y/idDeuoZd
         d+r4JTHPRckTEdJJLef7bzHCf12UGFWODUnEeTw8mv7rnujeSj/Wgc9V8q39bt1X92E0
         kSGpgoMcuigP5iCOQB7MlmC4uNE6PvVniVxqZZHeny0RRfuQgdBmwagRSEWvnKDgTEiU
         xDCmqO2Rh5hHk61Bf9OdzG9ijCLRTTHoK5fIlBmxvVGowm2rOz89wq/07a9kpyD+7Rct
         qeeZL1b02BuuCRZl3teb9QtuHC4tcE+u+PLib8A9XU1Wyz8DwE0F7Q6le62Q4u8NkHst
         Oaiw==
X-Gm-Message-State: AJIora+b7UWDWGQ4gwy1Nt9sA2++TUXctMF9SIlcZoXhT7mw5z9sFrKI
        xxFgc3oBEWVGeMkDsCWXpBClrs+1o6TD2A==
X-Google-Smtp-Source: AGRyM1uMkMKkQTpfN/nz+zuw+yJXYmMmx1mZxb2Tgt3sul1gOpUTnkmaPhNiZesRdx1PZB30u9kFYw==
X-Received: by 2002:a17:907:94c5:b0:726:b8a9:f9b9 with SMTP id dn5-20020a17090794c500b00726b8a9f9b9mr43819148ejc.123.1657181927324;
        Thu, 07 Jul 2022 01:18:47 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id f13-20020a170906824d00b00726e108b566sm12871779ejx.173.2022.07.07.01.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 01:18:46 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     linux-kernel@vger.kernel.org
Cc:     Naresh Solanki <Naresh.Solanki@9elements.com>
Subject: [PATCH v4 0/4] regulator: output-supply DT support
Date:   Thu,  7 Jul 2022 10:18:22 +0200
Message-Id: <20220707081826.953449-1-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v4:
 - Add 9elements as vendor.
 - Update dt binding.

Add devicetree support of the output-supply driver.
The supply names for this driver is provided through DT
regulator-names & regulator handle can be acquired.
Driver events can be received from sysfs.

Laxman Dewangan (1):
  regulator: output-supply: Add devicetree support

Naresh Solanki (2):
  dt-bindings: vendor-prefixes: add 9elements
  dt-bindings: regulator: add bindings for output-supply

Patrick Rudolph (1):
  regulator: output-supply: Add Notification support

 .../regulator/9elements,output-supply.yaml    | 63 ++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 drivers/regulator/userspace-consumer.c        | 97 ++++++++++++++++++-
 3 files changed, 160 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/9elements,output-supply.yaml


base-commit: 9f09069cde34dcd86f5ecf3a3139fd752020812f
prerequisite-patch-id: 0000000000000000000000000000000000000000
-- 
2.35.3

