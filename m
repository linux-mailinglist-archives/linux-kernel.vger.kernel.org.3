Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADF85A75C1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 07:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiHaFgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 01:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiHaFgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 01:36:54 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7A0A8327
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 22:36:52 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id w2so1397529edc.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 22:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=Zdl+bHnrlDuNezApLP0OPztrvL1DKjzc69eOvMJqVL4=;
        b=ndCngMFNIpxhdsEVpoO+0vUeZhV4e6LWjVdHnwZfH6wvgK6P1IhD4AJ7jBNyzyZT+F
         9N79bADXa44ZSs+q2FRKJBfy1lF1K9T4pfKgEiO2XfXZ+U6fhy2Sr9mL1jWWb8kvZYjc
         kderaYpg78OYZvvPl4SsIPJ4HNYjJzC6Jl4zYMUClwmaXs8g1fnI1iL7D8Ov7HCKOcHL
         NmZkfsm8Q/m3UZxPTGn+dfjlliLaXY3/LR34nrzjKG4g6NHbt/1NlX8bc16xSyYP6Di0
         XowG6n17R8yukTGmoWGtRInN/lSWqBQHuXpMh12YFVrEXX4wJJX0LcGoeh+H4I7tCDvX
         Zx9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=Zdl+bHnrlDuNezApLP0OPztrvL1DKjzc69eOvMJqVL4=;
        b=pvOln5r/qHGIfy/dOnKo51brictC00eYuZrIhbSvEwlaVwXhkOMZMaf/iaiFwmbb4D
         wrKDewDEjh1vJH5hPebMqaxcseVbIYCC/HrZb9maHduG5OnwbHE32z0vLcqPcs+3ZPXU
         6GQrYp6JOyUdEO37jI19MGx7jAqMVcqCQ8BfWRu9YOITBX3z+BAW8Q1ZlldSeib1rI5b
         NsWnPirRMkxu3PQYv4fkjEXjhEvZkKze6L72R9KBgQA4OVrqrkFv8jRYcA+fyVq6PYrw
         4m9H6+42lsuSreu0G8o3K2ZPfq/XGdK8K9XIYKI/32WYiFZocfyaEKv4+SaZ0TJvM+nJ
         mDjw==
X-Gm-Message-State: ACgBeo1jgKuUAEqSoEM7poxXR46Py7D0+XsJUCBkhWoIjbCwaL7juFjJ
        cgDw17vNXlUHYAvjZgAcjgo=
X-Google-Smtp-Source: AA6agR55WyoIOKGhR3LLdGBYjzoKHVFs+EezhwoOJ60vpzjasByoGDk1BhzcGBQRcNzuMYgg3UfL5A==
X-Received: by 2002:a05:6402:1d4e:b0:43d:9822:b4d1 with SMTP id dz14-20020a0564021d4e00b0043d9822b4d1mr23260330edb.212.1661924211190;
        Tue, 30 Aug 2022 22:36:51 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb89.dynamic.kabel-deutschland.de. [95.90.187.137])
        by smtp.gmail.com with ESMTPSA id gh21-20020a1709073c1500b0073a644ef803sm6610135ejc.101.2022.08.30.22.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 22:36:50 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/2] staging: r8188eu: migrate os_dep/mlme_linux.c
Date:   Wed, 31 Aug 2022 07:36:37 +0200
Message-Id: <20220831053639.8559-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.37.2
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

This series moves the functions from os_dep/mlme_linux.c to
core/rtw_mlme.c and removes os_dep/mlme_linux.c.

Tested on x86_64 with Inter-Tech DMG-02.

Michael Straube (2):
  staging: r8188eu: make two functions static
  staging: r8188eu: remove os_dep/mlme_linux.c

 drivers/staging/r8188eu/Makefile             |  1 -
 drivers/staging/r8188eu/core/rtw_mlme.c      | 31 ++++++++++++++++
 drivers/staging/r8188eu/include/mlme_osdep.h |  2 -
 drivers/staging/r8188eu/include/rtw_mlme.h   |  2 -
 drivers/staging/r8188eu/os_dep/mlme_linux.c  | 39 --------------------
 5 files changed, 31 insertions(+), 44 deletions(-)
 delete mode 100644 drivers/staging/r8188eu/os_dep/mlme_linux.c

-- 
2.37.2

