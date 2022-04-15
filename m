Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6379502970
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 14:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353104AbiDOMNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 08:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244633AbiDOMNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 08:13:04 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4C5BE9DF
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 05:10:36 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id b15so9723815edn.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 05:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6MMojV7I0m+iCYpeKkdRw9htRoG2xcIHZ+vtIiBqUTM=;
        b=oDrQo8EmtG21PYVImTfxmTgfMWQRJRiVSw1174+Y/StjDcUs6DPn4xOAT+eNYwjpU7
         HuHbZfcqC+mS+N2TGR4hIkexa4FZ7R65ZMfBtbp7bszUPzprBHXH7Hr+qxyRVa4TaV/9
         KC95wDaDx8tDa/iY/2YS4UrgTWGEwFnu3cfQEfq8wVXhgQS0SJuGPEyW4HAcG2WCBlME
         Uc/Qbkao15z//E8XarpJC3nYl647GzIHm3SOBpruYCw80lLqjInYs5X8eDfS+3HyC9p5
         y8TDEGyTuy2jmamCHP5+kjv8Husv9v9ZoD//riqj7gd0RsIvjBCVXuB+kIjNHg+Ecqsl
         K/xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6MMojV7I0m+iCYpeKkdRw9htRoG2xcIHZ+vtIiBqUTM=;
        b=x8EnVSPbTcuOLFXL6S+1lBD9HfauhP4HgVqKfgTIrc4O8BFPHDf5SX2JdFXe1NZ0lq
         9Mmz8ZUNgaR/djIYIqwh3PU7thmABPaLdEpgOBtc4Croie+u6m/FT0WAlZY8ZMVKQ/ZO
         tpb0vwea4E+rGg33r01U7kTXEGd517fBqk0eCYx3k1jQfaba6o+1+qe05UdCLURdL0/U
         ediORo/1Xu110cEv02aHKhKW0BFjitlfLfQCGVPjY25lPxtCtGLzXKza+zUTMFw/YQh2
         r1C7sUpC6rtPLpoW/HyRNftIZRj2a/ziEfQUSTQ4rnkvYP1BvStAQBDMuTqDEOdc4SK2
         g4dA==
X-Gm-Message-State: AOAM5315qMW4wvWpXJw74sJq381kc8ww02UwhmGVC4ZqlLglVNGyOOOi
        YdmxN/5T8l6fMl+qrgaD7GE=
X-Google-Smtp-Source: ABdhPJytc1rjKlyqIrY1JgqT03Uzf9p61vob+8Mdub+Lggywy/hqzWtBxndQJRTr/042IMUKwN9fmg==
X-Received: by 2002:a05:6402:e99:b0:41d:11f2:85e0 with SMTP id h25-20020a0564020e9900b0041d11f285e0mr7857729eda.339.1650024634853;
        Fri, 15 Apr 2022 05:10:34 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abba5.dynamic.kabel-deutschland.de. [95.90.187.165])
        by smtp.gmail.com with ESMTPSA id z22-20020a1709063ad600b006e8867caa5dsm1626114ejd.72.2022.04.15.05.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 05:10:34 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v3 0/8] staging: r8188eu: fix and clean up some firmware code
Date:   Fri, 15 Apr 2022 14:10:15 +0200
Message-Id: <20220415121023.11564-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
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

This series fixes wrong size of struct rt_firmware_hdr in the first
patch and does some cleanups in rtl8188e_firmware_download() in the
other patches.

Tested on x86_64 with Inter-Tech DMG-02.

v3:
- Splitted the first patch into two separate patches.
- Added back logging the firmware version only once.
- Included the compile time check for size of rt_firmware from
  patch 8/8 of v2 in the patch that replaces the hardcoded size.

v2:
- Added a patch to check size of struct rt_firmware_hdr at compile time.

Michael Straube (8):
  staging: r8188eu: fix struct rt_firmware_hdr
  staging: r8188eu: convert u32 fields of rt_firmware_hdr to __le32
  staging: r8188eu: clean up comments in struct rt_firmware_hdr
  staging: r8188eu: rename fields of struct rt_firmware_hdr
  staging: r8188eu: use sizeof instead of hardcoded firmware header size
  staging: r8188eu: remove variables from rtl8188e_firmware_download()
  staging: r8188eu: use pr_info_once() to log the firmware version
  staging: r8188eu: check firmware header existence before access

 drivers/staging/r8188eu/core/rtw_fw.c | 79 ++++++++++-----------------
 1 file changed, 29 insertions(+), 50 deletions(-)

-- 
2.35.1

