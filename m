Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C18548420
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 12:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240099AbiFMKHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 06:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234679AbiFMKHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 06:07:03 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1AFF25FC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 03:07:00 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id z7so6363767edm.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 03:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=388rVfLziXGbjQS21Tul2j/I7M6Zt1K95tN24K1AmoM=;
        b=hNPIvBFiRMJ6rB/VHNwmWvua/nH8QKLJWyeJkrEUtfgSTBNVuaQxhkbVVpGMdFbjRr
         8LEM6GKxwsaJ+IGRBEPZ5cL3V68XTQWq3Aw//53cWUmdeBb7cFfKiCxoD0TWWiptbIL/
         jWGZvp3CsaRaRaogyBL+TKOexYVfbxexw4ssqWWiTXn9DSWXN45SchBd44isMpwxWuSa
         OnzxtDc82Fea/jlWVAQzdMCGB/l4fNmhfWMyphWpbwg0FJvwAlZ600AO9HPDhaOHb9By
         Wy8Olozr1Xjub65R8YtZPR4+ZrGIj271V6fcw7137YbsyDzvqpYLPlcHJhqZVzrdXEuS
         bsgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=388rVfLziXGbjQS21Tul2j/I7M6Zt1K95tN24K1AmoM=;
        b=MKgm5TQatjp3/i4RHcCtp+t2ZmE/ZRjnNVXcSBv9oPPUlJtHSsc3gD4o1TLgtsjkrK
         uPpEndfL7M6r3iQhuRShtMmcj0Q1FXZNxCTw1QZxmye2ww1OYtilPUNxEWQVPB1GHiv5
         Nbq6xJmVvOs7ccMJ0Pg+KYErXaXRsgnCSKgz+3MpusrtAFGW1L8ft3ZBuH6p70N0wSBf
         sv9QdZKGLcXwNH5CXQpX9l8n2tubMe/Y3BwPK3n4f7pB2fy8YDQikt2OqJw4fSSFmKpO
         xBXBD+7W01zOunrWj+lWVAIaWsoMxbBR8lqghy3bQqXCoD6nJljAHi7/KA0cRNr6Um2R
         hXzQ==
X-Gm-Message-State: AOAM531FdGvGIY+vbrAi6DLvksXKsT87rlIVL41cbc6b1gxhU/UwwCAl
        xZGRCLsDSS/qYgaKHy6lLRIYB9lvlqmyug==
X-Google-Smtp-Source: ABdhPJyLVR6mKaSnfeAjdGkfvs4pku53sb5gAxMEnTrk6uCc+t28wi5xWYywt1WZ8NQMLmTOvRKS7Q==
X-Received: by 2002:a05:6402:5252:b0:42f:b566:c189 with SMTP id t18-20020a056402525200b0042fb566c189mr52169148edd.398.1655114819283;
        Mon, 13 Jun 2022 03:06:59 -0700 (PDT)
Received: from krzk-bin.monzoon.net (80-254-69-65.dynamic.monzoon.net. [80.254.69.65])
        by smtp.gmail.com with ESMTPSA id v2-20020a170906858200b006fe921fcb2dsm3639911ejx.49.2022.06.13.03.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 03:06:58 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Doug Gilbert <dgilbert@interlog.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 0/3] scsi: ufs: minor cleanups
Date:   Mon, 13 Jun 2022 12:06:52 +0200
Message-Id: <20220613100655.105301-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Changes since v2
================
1. More whitespace cleanups.

Changes since v1
================
1. Drop patch 1 (needs further work).
2. Rebase on current linux-next (including Bart Van Assche's work).

v1: https://lore.kernel.org/all/20220408103027.311624-1-krzysztof.kozlowski@linaro.org/

Best regards,
Krzysztof

Krzysztof Kozlowski (3):
  scsi: core: fix white-spaces
  scsi: ufs: ufshcd-pltfrm: constify pointed data
  scsi: ufs: ufshcd: constify pointed data

 drivers/scsi/scsi_debug.c         |  2 +-
 drivers/scsi/scsi_priv.h          |  4 +--
 drivers/scsi/scsi_proc.c          | 14 ++++-----
 drivers/scsi/scsi_scan.c          | 10 +++----
 drivers/scsi/scsi_sysfs.c         |  4 +--
 drivers/scsi/scsi_transport_spi.c | 49 +++++++++++++++----------------
 drivers/scsi/scsicam.c            |  6 ++--
 drivers/scsi/sr.c                 |  8 ++---
 drivers/ufs/core/ufshcd-priv.h    |  6 ++--
 drivers/ufs/core/ufshcd.c         | 42 +++++++++++++-------------
 drivers/ufs/host/ufshcd-pltfrm.c  | 10 +++----
 drivers/ufs/host/ufshcd-pltfrm.h  |  4 +--
 include/linux/libata.h            |  6 ++--
 include/scsi/scsi_cmnd.h          |  2 +-
 include/scsi/scsi_device.h        | 10 +++----
 include/scsi/scsi_host.h          | 13 ++++----
 include/scsi/scsi_ioctl.h         |  2 +-
 include/scsi/scsi_transport.h     |  2 +-
 include/scsi/scsi_transport_spi.h |  2 +-
 include/scsi/scsicam.h            |  2 +-
 include/scsi/sg.h                 |  2 +-
 include/ufs/ufshcd.h              |  6 ++--
 22 files changed, 103 insertions(+), 103 deletions(-)

-- 
2.34.1

