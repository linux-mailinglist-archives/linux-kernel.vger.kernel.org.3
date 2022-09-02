Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 468BC5AAB9E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 11:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235450AbiIBJka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 05:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235505AbiIBJk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 05:40:28 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2548032ABC;
        Fri,  2 Sep 2022 02:40:27 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id 199so1371782pfz.2;
        Fri, 02 Sep 2022 02:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=36yM+c0itGs1Ctc0yud6YxUq+RbAYF44TxAUEUxLkqM=;
        b=oO1tgJcFfKO7KQBpzIDGdwdIY/qEqA6wDMdcUG+MSdSrD3pNshMilYceyNAfHfuO0t
         DrcaW8kR+v4SnR9MQsI4mrueohbISW6nKf/A8wMcM34OJe47wnzd1w7RL0jCr8Cm359R
         e9w9nFOEGNonCGb583gyYdbEzk8M5X/UhvkHiiBv/FcmSreltMeemYIkGyCBVpCie3Fn
         5l7sOLO3vNiN/1X/iqSFFm8U9N+2c3MiD+m7AEtcw6QTMsbVeDr2IlB7kLLVGyFWHvbZ
         midbXaWrpFQuTuUkPhsEAmZS4iIn110a11qUxJvVv3sgzAhVxi9z64HFqnQkK1/nM6Ph
         4fyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=36yM+c0itGs1Ctc0yud6YxUq+RbAYF44TxAUEUxLkqM=;
        b=dqYEfb9TlNo52ho+AUV1x4JAnaJs8qdbA1VyqPAG1S66SDPAI1Eb+njJvuv/TxM4gX
         Z5uC7htcah1kcvQDeHF/vpHB/nKKpvzx6IHJub0/r4NMmkh5gHpi9YGagFRIYC2EGrbG
         vOzdsWjYbUmu3HOnsAB2tdiSCBf76oZsapjEFGIlvErONX6H7V7N4uVawBw/9Xgrr2h2
         1pOb5S2bQNaEv0VLdw4LaAzV899NAOfcrNgMfqU2OtoCDzQ4j5pIkz3SmTJyNChijO6D
         IocKy7/BT0LdV4xG0QOhNw3BX+jyQGPJUB3OrESqDwud+LZt0h4YyD25IlTitIgimQ6c
         xT1w==
X-Gm-Message-State: ACgBeo2f+w4baNqYweZFZnfQNXzCIbWHhuOHfkF9DDJwSGqdU/11xxvb
        IN8GDDbHcN19tJzhKgLVi4GxJ4ZWlvkkMQ==
X-Google-Smtp-Source: AA6agR5+2at4W5LBkrLSq3lVQ26nPtSRcIKF1fGzwKfeS2AM8ksmDckUkZza4DSeCH/AKWMcWQvb0g==
X-Received: by 2002:a63:d448:0:b0:41d:d4e9:b4aa with SMTP id i8-20020a63d448000000b0041dd4e9b4aamr28601036pgj.123.1662111626579;
        Fri, 02 Sep 2022 02:40:26 -0700 (PDT)
Received: from sw.. (220-128-98-63.hinet-ip.hinet.net. [220.128.98.63])
        by smtp.gmail.com with ESMTPSA id z14-20020a655a4e000000b0041d9e78de05sm971855pgs.73.2022.09.02.02.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 02:40:26 -0700 (PDT)
From:   Szuying Chen <chensiying21@gmail.com>
To:     gregkh@linuxfoundation.org, mario.limonciello@amd.com,
        mika.westerberg@linux.intel.com, andreas.noever@gmail.com,
        michael.jamet@intel.com, YehezkelShB@gmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yd_Tseng@asmedia.com.tw, Chloe_Chen@asmedia.com.tw,
        Richard_Hsu@asmedia.com.tw
Subject: [PATCH v8 0/3] thunderbolt: add vendor's NVM formats
Date:   Fri,  2 Sep 2022 17:40:07 +0800
Message-Id: <20220902094010.2170-1-chensiying21@gmail.com>
X-Mailer: git-send-email 2.34.1
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

From: Szuying Chen <Chloe_Chen@asmedia.com.tw>

The patch series for vendors to extend their NVM format.

v7->v8: The nvm_read() defined in tb.h. Modify
tb_switch_nvm_validate() return value and no_nvm_upgrade bit setting.

Szuying Chen (3):
  thunderbolt: Add vendor's specific operations of NVM
  thunderbolt: Modify tb_nvm major and minor size.
  thunderbolt: To extend ASMedia NVM formats.

 drivers/thunderbolt/nvm.c    | 234 +++++++++++++++++++++++++++++++++++
 drivers/thunderbolt/switch.c | 104 +++-------------
 drivers/thunderbolt/tb.c     |   2 +-
 drivers/thunderbolt/tb.h     |  12 +-
 4 files changed, 263 insertions(+), 89 deletions(-)

--
2.34.1

