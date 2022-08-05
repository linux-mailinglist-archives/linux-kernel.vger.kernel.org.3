Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDEB158A650
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 09:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240132AbiHEHFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 03:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240120AbiHEHF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 03:05:27 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B12CB120A2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 00:05:22 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id q9-20020a17090a2dc900b001f58bcaca95so657659pjm.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 00:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=DM71lYIMNmkmIZ4kdJS0Wn785NNMBrggQC7YERDLEXQ=;
        b=YCJdpj3MO1drwIfB+kFTcsYuM1oGimHtTupkC80mTaXQQLtlCVSHN7XtlNC1uBANYJ
         B395iqe40n46mH5H+I67idZJMIrHZDp1XZSe2X/2DkS+1eFg9/wNHWwHUqx1m79SnR6E
         HWhtC8tUg8WQeC3Af7marcBBExvzGiv/+Ti/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=DM71lYIMNmkmIZ4kdJS0Wn785NNMBrggQC7YERDLEXQ=;
        b=jmeU1wHWa7HbWroYKS9DbnGYtOb+7Vj/BilRZZatibjEfRQZRNuGAiMnedly0x2rfY
         61vQKwj9AIqD20GaBrchvjwmtakSiPl5ISmuhzECsZ5ciAvVUc+T3Ih7FrvYYGoYd/nK
         wRJwbr/VGrfiK2wrqD+WYGIS1DuF/tQWh/xzZ9/+FP/0jq2QFNPQt77s1QU8rqqiGF1A
         ygNg3ZFaTJBHRr/8KDKRGOMkENL1Oo0Wi0Jf6sQ0tkGZDeQz0jPUqqjM/qeCVYf86mYr
         AGf2fchZ71neuCy82BcRzoXoOVwW/omakm8lRYEYo/xhIkqeBF1Ncxq4SRA7M5sDu2L5
         DhNA==
X-Gm-Message-State: ACgBeo0j+SZxiy6RWyg4KSGKXW9hP9W2JYify7/mcV8cJDD5wsJZdkMl
        jEkvTGjbDduVlcha8hjAcke42g==
X-Google-Smtp-Source: AA6agR6ko+gOuQEbz49PBFNkB7iIGfxPu+6tx8iwC79mo1laX/6dp+Kji6F4iB9oWBk4UQNihZOesg==
X-Received: by 2002:a17:902:e543:b0:16f:8fed:ee1e with SMTP id n3-20020a170902e54300b0016f8fedee1emr1997954plf.74.1659683121791;
        Fri, 05 Aug 2022 00:05:21 -0700 (PDT)
Received: from localhost.localdomain ([183.83.136.224])
        by smtp.gmail.com with ESMTPSA id e60-20020a17090a6fc200b001f262f6f717sm4877484pjk.3.2022.08.05.00.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 00:05:21 -0700 (PDT)
From:   Suniel Mahesh <sunil@amarulasolutions.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Zachary Holland <Zachary.Holland@biamp.com>,
        Daniel McLean <Daniel.McLean@biamp.com>,
        Rene Samson Ambrose <renesamson.ambrose@biamp.com>,
        David Sands <David.Sands@biamp.com>
Cc:     linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com,
        USB list <linux-usb@vger.kernel.org>
Subject: [RFC v3 0/2] Extend functionality for GET_REPORT
Date:   Fri,  5 Aug 2022 12:35:05 +0530
Message-Id: <20220805070507.123151-1-sunil@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series does the following:

patch 1/2 extends functionality for GET_REPORT.

The current kernel implementation for GET_REPORT is that the kernel
sends back a zero filled report (of length == report_length), when
the Host request's a particular report from the device/gadget.

This changeset extends functionality for GET_REPORT by sending a
particular report based on report type and report number.

patch 2/2 adds a test application to test the extended
functionality.

please review and share your thoughts.

version 2 patches:
https://lore.kernel.org/lkml/20220802201556.1510069-1-sunil@amarulasolutions.com/

version 1 patches:
https://lore.kernel.org/lkml/20220801123010.2984864-1-sunil@amarulasolutions.com/

Suniel Mahesh (2):
  usb: gadget: f_hid: Extend functionality for GET_REPORT mode
  HID: ghid: add example program for GET_REPORT
---
Changes for v3:
- patch 2/2 got changed, the mapping of report type. 

Changes for v2:
- patch 2/2 got changed. 

 drivers/usb/gadget/function/f_hid.c  | 184 ++++++++++++++++++++++++++-
 include/{ => uapi}/linux/usb/g_hid.h |  10 ++
 samples/Kconfig                      |  10 ++
 samples/Makefile                     |   1 +
 samples/ghid/Makefile                |   4 +
 samples/ghid/test-hid.c              | 134 +++++++++++++++++++
 6 files changed, 341 insertions(+), 2 deletions(-)
 rename include/{ => uapi}/linux/usb/g_hid.h (72%)
 create mode 100644 samples/ghid/Makefile
 create mode 100644 samples/ghid/test-hid.c

-- 
2.25.1

