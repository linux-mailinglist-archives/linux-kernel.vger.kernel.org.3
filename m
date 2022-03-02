Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3A64CB032
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 21:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244360AbiCBUsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 15:48:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244354AbiCBUss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 15:48:48 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52743FBC7
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 12:48:03 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id ge19-20020a17090b0e1300b001bcca16e2e7so5847406pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 12:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eoKQqCbI8PxL6l9piEDwf9eS8EFbrh6cCOCe/ltlwc4=;
        b=ASeGJrfLRf/uRKaUvdh8TJg8raWbVzeyEUkn4pekIqzqxSAXb/GNo5doCQv013EQiA
         Wd3ZjFZ5fKmPdd5sr8m8IUU3yWd2ci13b9omZL6ugqsdjz97AHAD+lEp/UQeddhywZmp
         yR1CPpQXKzLYxO6zdAag+spSYMLJvZg8ecQtTUqk2/3ceIwdIwkkL2EBY1WePGmd37hP
         KxKM/wxUY80ySGPxgYxPDoadheG92qG0iunt/EUR3oUNpQHFTJBVksuj0XgmxkuAuOYA
         Gi91nHAtBmtvVOgR+j/zFsmoRcQcEsou4GfrSSytvOY6/N3d1Pz4Vy940W9bCYc7lI0x
         yeBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eoKQqCbI8PxL6l9piEDwf9eS8EFbrh6cCOCe/ltlwc4=;
        b=czZC8Lq2MykcSm057VcpUkrSV1WVnB/f9upvR1MzfSVj6Wx2NjHioBgw7TdVDraOlx
         WmhPoFVJdDlp0YUDbg4gEvh7NIBpWygUZL1B/ff7kbv+/oiZs6ghvlgXI1LUNiNOOVSM
         3Q5WmWYYEcma/+94Fy1uhKg7+lm1qQRMFYBjPblC0ESc3y52Q4iWR7ZpHOsDIJrIq/JC
         daYDlXvb8kvo4pJ6A6PazU9wu4LRh5nZhml/IV5uuRQOTx5ymf2qMVfmDswZMhvShvkw
         leyB7nifB3WmpLiCla3KOxuCGsZQDNU9eOt7gqhjN4q5eGlHwVdE8iUCQky0jWhOvvtE
         O7Dw==
X-Gm-Message-State: AOAM533OSaEbGd6+hW8ICzR/Hwjz2KNw2J964jNjduzd3+lVQE3ItnYc
        qK7HEdtoR3s0Hd4z8+/7Ntc=
X-Google-Smtp-Source: ABdhPJwc8llIZdxMOho86N5zl7n2dsqX/toWP1I4HBVNCQHLPvrwfS5Xz8R4VJlL5puQky/fDmxwMg==
X-Received: by 2002:a17:903:2284:b0:151:9670:9012 with SMTP id b4-20020a170903228400b0015196709012mr5002543plh.110.1646254083196;
        Wed, 02 Mar 2022 12:48:03 -0800 (PST)
Received: from localhost.localdomain ([103.161.98.179])
        by smtp.gmail.com with ESMTPSA id bh11-20020a056a00308b00b004f40144cf76sm50905pfb.142.2022.03.02.12.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 12:48:02 -0800 (PST)
From:   Vihas Makwana <makvihas@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Vihas Makwana <makvihas@gmail.com>
Subject: [PATCH 00/16] staging: r8188eu: convert functions to return bool
Date:   Thu,  3 Mar 2022 02:17:21 +0530
Message-Id: <20220302204737.49056-1-makvihas@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are many functions which return true/false but are marked as int, 
uint, s32 etc. Mark them as bool.

Vihas Makwana (16):
  staging: r8188eu: mark rtw_is_cckrates_included as bool
  staging: r8188eu: mark rtw_is_cckratesonly_included as bool
  staging: r8188eu: mark rtw_is_desired_network as bool
  staging: r8188eu: mark PS_RDY_CHECK as bool
  staging: r8188eu: mark check_indicate_seq as bool
  staging: r8188eu: mark enqueue_reorder_recvframe as bool
  staging: r8188eu: mark recv_indicatepkts_in_order as bool
  staging: r8188eu: mark cckrates_included as bool
  staging: r8188eu: mark cckratesonly_included as bool
  staging: r8188eu: mark is_basicrate as bool
  staging: r8188eu: mark is_ap_in_tkip as bool
  staging: r8188eu: mark rtl8188eu_xmitframe_complete as bool
  staging: r8188eu: mark check_fwstate as bool
  staging: r8188eu: mark IS_MCAST as bool
  staging: r8188eu: mark IsFrameTypeCtrl as bool
  staging: r8188eu: mark rtw_endofpktfile as bool

 drivers/staging/r8188eu/core/rtw_ieee80211.c    | 4 ++--
 drivers/staging/r8188eu/core/rtw_mlme.c         | 2 +-
 drivers/staging/r8188eu/core/rtw_pwrctrl.c      | 2 +-
 drivers/staging/r8188eu/core/rtw_recv.c         | 7 +++----
 drivers/staging/r8188eu/core/rtw_wlan_util.c    | 8 ++++----
 drivers/staging/r8188eu/hal/rtl8188eu_xmit.c    | 2 +-
 drivers/staging/r8188eu/include/ieee80211.h     | 4 ++--
 drivers/staging/r8188eu/include/rtl8188e_xmit.h | 2 +-
 drivers/staging/r8188eu/include/rtw_mlme.h      | 2 +-
 drivers/staging/r8188eu/include/rtw_mlme_ext.h  | 6 +++---
 drivers/staging/r8188eu/include/wifi.h          | 4 ++--
 drivers/staging/r8188eu/include/xmit_osdep.h    | 2 +-
 drivers/staging/r8188eu/os_dep/xmit_linux.c     | 2 +-
 13 files changed, 23 insertions(+), 24 deletions(-)

-- 
2.30.2

