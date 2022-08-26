Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0745A2C2D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 18:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344310AbiHZQV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 12:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbiHZQV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 12:21:26 -0400
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9BEDD777
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 09:21:26 -0700 (PDT)
Received: by mail-pl1-f176.google.com with SMTP id w2so2023966pld.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 09:21:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=1cEt2poTN4qOGMHPFDK/Oj861cV9YushYBHMhtks4yU=;
        b=lDiVdn1BymgoDPBQ57UJ0b48Trfj9dYvHEh8qQK2oFB+MAHfy8D/Kjum8kw7rAVRBU
         h+bTZpdfT/jC1jTMupY+JCDa8lCzwglRBtr1IQ43PSBcED4Xt2FQEzIIupRa19YWkrb4
         9JxPrVIQSnTy3EgDT5CFbaMpiWzqwHEF995kjeFWIQhZHER9oZxfIIrJTxltHla6eXAW
         MpM8gcilcZnaBZWkKUfUzwbsiKLMIJcGx3Lu77DkMj23r1WlhTdLwGOIZfmu9A3T3gNs
         6NRyg259qluD68JT1TD3MF0ANleBCIzvGazfjHI2qEpnqZoR/RpsSTLq5gTyS0EcC1lU
         Gxjg==
X-Gm-Message-State: ACgBeo3I1LUfxw94i6hRI2vFgw05tPcyhFD5MilcDN4JJCFwKcan1W4Z
        45QmkFvpiDbJoxoEIdwYKlU=
X-Google-Smtp-Source: AA6agR7rxeWmsFMxOmODEGwajT5IGpRZ+UtqakVClFzeEfscUbW8nZ9jRNIgZhoYCvuJwv+lp3eE/g==
X-Received: by 2002:a17:90b:1d0b:b0:1f5:72f:652c with SMTP id on11-20020a17090b1d0b00b001f5072f652cmr5098728pjb.38.1661530885643;
        Fri, 26 Aug 2022 09:21:25 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:a12:b4b9:f1b3:ec63])
        by smtp.gmail.com with ESMTPSA id cp7-20020a170902e78700b0016ee328fd61sm1790077plb.198.2022.08.26.09.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 09:21:24 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 0/2] Define is_signed_type() once
Date:   Fri, 26 Aug 2022 09:21:14 -0700
Message-Id: <20220826162116.1050972-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

The changes in this patch series are as follows:
- Add a unit test for the is_signed_type() macro.
- Define the is_signed_type() macro once.

Please consider these patches for the next merge window.

Thanks,

Bart.

Bart Van Assche (2):
  testing/selftests: Add tests for the is_signed_type() macro
  overflow, tracing: Define the is_signed_type() macro once

 include/linux/compiler.h     |  6 +++++
 include/linux/overflow.h     |  1 -
 include/linux/trace_events.h |  2 --
 lib/Kconfig.debug            | 12 +++++++++
 lib/Makefile                 |  1 +
 lib/is_signed_type_test.c    | 48 ++++++++++++++++++++++++++++++++++++
 6 files changed, 67 insertions(+), 3 deletions(-)
 create mode 100644 lib/is_signed_type_test.c

