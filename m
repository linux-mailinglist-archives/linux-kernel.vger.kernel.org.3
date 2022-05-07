Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ACB251E4F0
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 08:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445907AbiEGG6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 02:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237303AbiEGG6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 02:58:07 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2B55DBF0
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 23:54:21 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id v10so7816308pgl.11
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 23:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=62kD9X+wL8139kA2shJKwkd5nwt7B2MfA24KVxjQ6GE=;
        b=yYwSN/rBCBxYKUC5+BZW3ZdX1BdUO30eoUNLLvr1vyYb6mRvrlQJAmafcQAS9Zjc3w
         Ptu95yc/4Ss3KvmfvUOAsR5GaWQlmUpy8OnHpD+cfGea6BYeWT5t355syowJA4D4YApt
         imvb449UbIs1MITdPVwjzGCsjJmBoWZbFSms8cuADs8W+D+t+aIVbH/8KGtOW8IKkGXj
         9ZZnlcNL8yLaEg9H2E6AdGJI/BUAardM2g+IIIBIMJf7axZ7AaMvoDtFAGrIOBfeRVtM
         EryRcpk1/fh/UpJGWV1F5v5RjT8OKlN1F+LWF0zghXG0B/QT8V2VwS27q+BZkanHLYaP
         K5Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=62kD9X+wL8139kA2shJKwkd5nwt7B2MfA24KVxjQ6GE=;
        b=AQxt/5RMDRLinXjHamsrIm2hZdbkL34bHI3/bNW0hBLsdEpkof8VS1eOygWJNbyTER
         NxpRV3p2tzEhg1ee1s1Zd8KE+9eVi952yt+U9WM/CObhoLjygKU3pCRQGxvcz+zIB3NG
         ER7bYIWLcD/bw21qbzZnW5KMAJ5+lgEWAWIEiU9d08wHD+qLSrqKqC85m5KBLJ4bQs75
         1X0Qmip4AZoVw0183h/7B7Y3fs/H1ItSsQmHTk4kalqom+7Syvqyu5zKnLLtESmrRzP0
         um0Q/fHeXUL8BbiAFVHe9NFMY+GoFUHthDWl573gvgJKtwsQCqoyahSyC/GGlqo98nsy
         o6Hw==
X-Gm-Message-State: AOAM530TOqK2LEixZPVfMIqz50++KNFzVQ93Enos59cGSYB5JX+s9Rh3
        /EZl8AJEqLt8hDGdbltKbqVxgdnJ6ybFKA==
X-Google-Smtp-Source: ABdhPJyYgBXudzKFPcNA5z1FRe7VgLannZcSb2m+r5ktk2pWyLDxleafB+myINFBbbzr4LelJU39XQ==
X-Received: by 2002:a63:e108:0:b0:3c6:6833:9192 with SMTP id z8-20020a63e108000000b003c668339192mr2868252pgh.616.1651906461486;
        Fri, 06 May 2022 23:54:21 -0700 (PDT)
Received: from always-x1.www.tendawifi.com ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id y20-20020a1709027c9400b0015e8d4eb1ebsm2905162pll.53.2022.05.06.23.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 23:54:20 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     kbusch@kernel.org, hch@lst.de
Cc:     sagi@grimberg.me, axboe@fb.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH 0/3] nvme: enable smart AEN
Date:   Sat,  7 May 2022 14:50:23 +0800
Message-Id: <20220507065026.260306-1-pizhenwei@bytedance.com>
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

Hi,

There are several changes in this series:
- Add missing NVME_SMART_CRIT_PMR_UNRELIABLE enum type.
- Add missing NVME_AEN_CFG_SMART_CRIT_* enum types.
- Enable smart AEN.

zhenwei pi (3):
  nvme: introduce bit 5 of smart critical warning
  nvme: introduce smart bits of aen cfg
  nvme: enable smart AEN

 drivers/nvme/host/core.c |  6 +++++-
 include/linux/nvme.h     | 20 ++++++++++++++++----
 2 files changed, 21 insertions(+), 5 deletions(-)

-- 
2.20.1

