Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C34204B77F3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242938AbiBOSO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 13:14:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235191AbiBOSOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 13:14:22 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98B111987F;
        Tue, 15 Feb 2022 10:14:11 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id d10so46023384eje.10;
        Tue, 15 Feb 2022 10:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=apxf8RnDTER51NejxBNcsmrp9/WJHvi6B/qWgwFGF6E=;
        b=BGpEPkh0qc5saHIOHTAOQ8O/nQJGfQ0h/pR2SwgilnsiHHC9eYbAPnWoQmzaenQAl7
         hL0DNtqvUMAD1ZxURJlgs2fsFeVm/Dw2iXwbipnA8b5FV3C8sQRCgQxBzPZa9b10xSux
         MOKMRMJqFgyx/KIlZk0A+QZt3a+28Dcy1xMQS08EkV3Rz8FnXiMu2nYmFA/7Nah59igK
         0hvFk6Ed6hQEsyJIMn6PZYp7o9vsSD/Gt0phYPYvbeDD+7mh3J+OdxLMPEAD86ct94JN
         CuDfLItjkmSUUTP/uLt3e5nxzJkS0dwXBgej1CipklkxwIVhLhrS2YPY5Uxt6RxPzZhw
         zoyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=apxf8RnDTER51NejxBNcsmrp9/WJHvi6B/qWgwFGF6E=;
        b=wjXIB8jpJ/2oyQQIpNxe3lmxACppJbGMwbAZcLt1miRnzZTD5lRXkBavmGws+ym8aE
         NbevqxQXm+c/wKM3eaBD2jZ9gvHxHqn5MJt4SB5yngDrb2fwjGr2FJdn4jxRHDTUo8Tp
         LphW9u3STtU39XR/eJ60TJINaizIM5IvalyjCkA/4W+T/FPCY9g/TBaP5W4ImMgaY1Hq
         yApvsqV8h70sCTNfl/uY3ZhcapA0IvbCTiMTCCFhvg4s9vQ/I6oFdDDVZ0CF1Ng+Qzcs
         Wutq12U5FyHjCN9Ow9D9fttQhYZB7rDM4LWqCdsuCa9r+TxC4SOXXWqtPHSEBhWJ7h7b
         P8CQ==
X-Gm-Message-State: AOAM533XbMt0X1giniYPgpnHvUTrfjazSfwixJfIrKNzd/rwpmDvePow
        YwyU6M5SnCM8HO3v04VIYpO05FGEMKE=
X-Google-Smtp-Source: ABdhPJzX/MqNSJfeUZpSZhgxDxuKeQrg52llpIeMg51kDWLMFPOz62Gy4NFUVq5bnRa82KEyEux49w==
X-Received: by 2002:a17:906:31cc:: with SMTP id f12mr262423ejf.115.1644948850025;
        Tue, 15 Feb 2022 10:14:10 -0800 (PST)
Received: from X1C7EK5.wind3.hub ([151.40.80.193])
        by smtp.gmail.com with ESMTPSA id i5sm1950497ejo.188.2022.02.15.10.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 10:14:09 -0800 (PST)
From:   ektor5 <ek5.chimenti@gmail.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ettore Chimenti <ek5.chimenti@gmail.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linuxfancy@googlegroups.com
Subject: [PATCH v2 0/2] Add SECO CEC driver for MEC Based boards
Date:   Tue, 15 Feb 2022 19:13:11 +0100
Message-Id: <20220215181313.264698-1-ek5.chimenti@gmail.com>
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

From: Ettore Chimenti <ek5.chimenti@gmail.com>

Hi all,

Changes in v2:
 * Fixed a missing counter increment in the probe function.

Here's the patch for the SECO CEC driver for MAC-based Boards. The
boards have a Microchip MEC microcontroller as a general-purpose
Embedded Controller, and they communicate through a mailbox interface.

The EC used is more powerful and enables management of several CEC lines
at once (up to 4). The focus is on Intel-based SBC-D61 board and UDOO
Vision (SBC-D02) in this version, as the UDOO BOLT firmware
implementation is still ongoing. Moreover, there is no CEC Notifier
functionality inside amdgpu yet.

Similarly to the previous implementation, there are several commands
that can be issued, like WRITE and READ commands for sending and
receiving CEC messages. The retrieval and send confirmation are
triggered by a single GPIO interrupt connected directly to the SoC.

After every STATUS command, the MEC returns a data struct with all the
channels status, and it automatically clears the interrupt state afterwards.

In this implementation, the driver sends also the physical address to
the EC. This way it is possible to wake up the board upon receiving an
SET_STREAM_PATH with the matching physical address when the CPU is in S3
or S5 (depending on BIOS settings). The only time that it seems to be
already set is in the LA assignment (in the .enable callback it is not
set yet).

Best Regards,
	Ettore

Ettore Chimenti (2):
  media: cec: add SECO MEC-based cec driver
  media: cec: seco: add newlines in debug messages

 MAINTAINERS                                   |   2 +
 drivers/media/cec/platform/Kconfig            |  22 +-
 drivers/media/cec/platform/seco/Makefile      |   3 +-
 drivers/media/cec/platform/seco/seco-cec.c    |  54 +-
 drivers/media/cec/platform/seco/seco-meccec.c | 824 ++++++++++++++++++
 drivers/media/cec/platform/seco/seco-meccec.h | 130 +++
 6 files changed, 1005 insertions(+), 30 deletions(-)
 create mode 100644 drivers/media/cec/platform/seco/seco-meccec.c
 create mode 100644 drivers/media/cec/platform/seco/seco-meccec.h

-- 
2.17.1

