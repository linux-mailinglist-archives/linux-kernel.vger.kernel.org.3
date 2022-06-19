Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F20550AD1
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 15:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236126AbiFSNRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 09:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234547AbiFSNRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 09:17:35 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45120C09;
        Sun, 19 Jun 2022 06:17:34 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id r1so7558615plo.10;
        Sun, 19 Jun 2022 06:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=72YRetErMVq0kvDA2KE1B9pju9IZugf9+086L2vK3oI=;
        b=h9cCwKmF2GuNrw1nmTzlZbSz8hytmm2T9SAqWua4iq0HmYKUixR+Cuv6C+jDg9eK0s
         My12cMEFUb6jTlMi7T9E/yMp5RTWjOaQ3s1BIAdZWJQE9xw+8HZ7+SoGPs5j8rJYAt9D
         1eDd5P/rDqQkog5+/k6xCgHas8kEE8l50TgWBSOtPbMJqcBAqr4fiuBwDnI+XPGb8hLD
         lT2xZ8sBevfZ3KjkAP9P+kiKCP4H48xp8dGsB4TDy3ohgj5+fAyVDkRsEVzWHCFJ4AUC
         OALJpn/w6Z+w1EIfhoBniMxd9UA7KuYX+mXEvuf3KgsPEeC62m+oowkBzSz6PBMS3NN2
         G5LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=72YRetErMVq0kvDA2KE1B9pju9IZugf9+086L2vK3oI=;
        b=IJrOpx6ZetSTUnMxiGJ9FMoOukjUPglJMpCtKT2oLoxxJZKOLDC7gTNF6RiTUlbbag
         i3zyxFYQnmwBeK2DrnVXf8/SMjt/qAgZfADL9k+kmPmwdL7Ds+9hfZ8ocUKmQnZ0cDnA
         5WCKbnOjOUjHv0dKnpa3SgRvc2I4PfuXokxVsL15MKVUTxcDuPtFS9GqixAbBV5v6IVN
         DD/pd1tE9OtFn+KBlGhWFL02h7Lp4KwM0H35A/MSvkLepQdLHcGFqhCXrK2En7HhdtUh
         vgfeauqui4Iv3D/mCmcjMrQU6rxJjSA/CMMio+GCaEDdr2Eet3AJ05+YkU8urPcICegl
         n9ZA==
X-Gm-Message-State: AJIora+243g9ZYDMKRcfAGt8juENfw9x7kJdQCiH9lKQQftTQ5THp1OT
        8ez1OM3iWPTAASp3COV6soZM/lL6HjfqvA==
X-Google-Smtp-Source: AGRyM1u+G9GJnaABrP9aoC3keXQVm+Px4CGuoNC52xMnyhW6Z7sJuYiOY5LztO24tpAW5cu1XvGQPQ==
X-Received: by 2002:a17:902:b681:b0:16a:f81:6b02 with SMTP id c1-20020a170902b68100b0016a0f816b02mr8607213pls.28.1655644653300;
        Sun, 19 Jun 2022 06:17:33 -0700 (PDT)
Received: from guoguo-omen.lan ([2401:c080:1400:4da2:b701:47d5:9291:4cf9])
        by smtp.gmail.com with ESMTPSA id g1-20020a1709026b4100b001635f7a54e8sm6771857plt.1.2022.06.19.06.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 06:17:32 -0700 (PDT)
From:   Chuanhong Guo <gch981213@gmail.com>
To:     linux-acpi@vger.kernel.org
Cc:     Chuanhong Guo <gch981213@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 0/2] Skip IRQ1 override for two laptops
Date:   Sun, 19 Jun 2022 21:16:55 +0800
Message-Id: <20220619131657.37067-1-gch981213@gmail.com>
X-Mailer: git-send-email 2.36.1
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

The IRQ1 of these two laptops with Ryzen 6000 and Insyde UEFI
are active low, as described in ACPI DSDT. The kernel override
made their keyboard non-functional.
This patchset skips override for them.

Changes since v1:
 Match DMI DMI_PRODUCT_NAME for ThinkBook because the board name
 is used for other completely different Lenovo laptops.
 Add a patch for RedmiBook

Chuanhong Guo (1):
  ACPI: skip IRQ1 override on Lenovo ThinkBook 14G4+ ARA

Tighe Donnelly (1):
  ACPI: skip IRQ1 override on Redmi Book Pro 15 2022

 drivers/acpi/resource.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

-- 
2.36.1

