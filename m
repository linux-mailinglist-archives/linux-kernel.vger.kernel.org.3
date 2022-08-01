Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3CA8586B18
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 14:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbiHAMpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 08:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234683AbiHAMoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 08:44:22 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB206447
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 05:30:23 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id o5-20020a17090a3d4500b001ef76490983so11832539pjf.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 05:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=f5hr8DusGVxBeJGY0y8l2bn+77knSqmGq5nzEyayFUc=;
        b=Si6hwKKHotiDXWEPSsYwMgk/KFiJfrzc38UB/qZ6MqMQGt5+VKlak46pOg2kZ2hRGM
         oV2jMaevL9jBc8PAVqByAC0yvDcvnC6RBttmk4uua0a98YIv9oiTKRqENUk6cfdTPn2X
         4jfL8Y1iZcL0ncvinSj0VbSk2BNfZH3VuXGYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=f5hr8DusGVxBeJGY0y8l2bn+77knSqmGq5nzEyayFUc=;
        b=kEZ1IMDG0w/0PkLXGKtko9if2y7HvICLO4js1tptuMcyi/3LmDQ9RUPUAL8syDkZSr
         5rMsEakj/n4tzz1Q06YYLG8x1k8xmubZfn/vEKHnQJZX4dER8EAdOFXCazCU0VOSfoJg
         76plXzGAoDLbuoUjkl4uF8qmK4CKWbn6bwjEZd5oab4viq2ahnUsEAzoQFr/EP9JlzM2
         ehtb7BxKU7aPv49+DTbbnnW3q5DWpxLKP+XkKhfSroPz1bJgsodCpithNrO8zpKGNxjw
         gqqWazELdZY7GOjl8RHcQqHzR8cBB+cgGXG4Lz+lCsjG054GEiSoQEu2BBz8d0ZrlmB1
         YAGg==
X-Gm-Message-State: ACgBeo31qocAbWMiC8G2YeTfQjYgs2Dk+5puzK+MjQt7vfmAzmTBh0IJ
        +z71mvalN0YWSxIUahBDpRUYDg==
X-Google-Smtp-Source: AA6agR5kTG6zu/5x4IHSjb7wmvfYG052w5/+WzdbLKyf7++lIHj64cfuE/MeieOT309VIraIxS47vg==
X-Received: by 2002:a17:902:c406:b0:16e:df76:5267 with SMTP id k6-20020a170902c40600b0016edf765267mr7423088plk.8.1659357023035;
        Mon, 01 Aug 2022 05:30:23 -0700 (PDT)
Received: from localhost.localdomain ([183.83.136.224])
        by smtp.gmail.com with ESMTPSA id a14-20020a1709027e4e00b0015e8d4eb219sm3473230pln.99.2022.08.01.05.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 05:30:22 -0700 (PDT)
From:   Suniel Mahesh <sunil@amarulasolutions.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Cc:     linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com,
        USB list <linux-usb@vger.kernel.org>
Subject: [RFC 0/2] Extend functionality for GET_REPORT
Date:   Mon,  1 Aug 2022 18:00:08 +0530
Message-Id: <20220801123010.2984864-1-sunil@amarulasolutions.com>
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

Suniel Mahesh (2):
  usb: gadget: f_hid: Extend functionality for GET_REPORT mode
  HID: ghid: add example program for GET_REPORT

 drivers/usb/gadget/function/f_hid.c  | 166 ++++++++++++++++++++++++++-
 include/{ => uapi}/linux/usb/g_hid.h |  10 ++
 samples/Kconfig                      |  10 ++
 samples/Makefile                     |   1 +
 samples/ghid/Makefile                |   4 +
 samples/ghid/test-hid.c              | 134 +++++++++++++++++++++
 6 files changed, 323 insertions(+), 2 deletions(-)
 rename include/{ => uapi}/linux/usb/g_hid.h (72%)
 create mode 100644 samples/ghid/Makefile
 create mode 100644 samples/ghid/test-hid.c

-- 
2.25.1

