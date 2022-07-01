Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B0D5635F9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 16:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233713AbiGAOlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 10:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233331AbiGAOlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 10:41:00 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484ECF581
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 07:40:25 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id k16-20020a7bc310000000b0038e6cf00439so1523800wmj.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 07:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=f72vaIwdDRJKKgyhDAvpG/wPqltF4guZxd93ZnednlM=;
        b=QLXtZCx/2BbsgwC4Iwx2bMs9DxdMYumaCezysgylc6xoafelXZYU007Fclwu0SIEGI
         l5+OABExGosSAAecd+z9tOXKqGGP53DrN5coZCueSL/Cu61Bq+OtPFU+IU1s6+Kmqm39
         vBvsCh3t8l7b/kbIf4t21twfda35PFO8cM4s1QL0tcAIZHy85B3zeHmUzrSV9615Acxi
         /4zkV5UA49UCDMYzWcYX1W1IV5BfOr+Zd9vMldAwA4D/p351CL3/FHIJUDStNMIA/5I0
         8wpJrKszpXlXdlPBfZhAVjr90d7WuffTnu4Ay1rzfAUP5Y41xMaMxWgQ6CraDN5Pr3uT
         f5Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=f72vaIwdDRJKKgyhDAvpG/wPqltF4guZxd93ZnednlM=;
        b=oMRLSTFF96ekDEl8gFwptZHwvtHAK0c3OsEesxvQAGk4G1yMeZZXwXPpX0Jln6TaK9
         JDxWwN9s6nbjC5oQuUHVDbLBqSqVTigwaPwvVkYTEgaA0hPT+9GoELnyp1rQY4Sp5nsN
         aCtyH7xvAxHcB+3fkELYuIUSc51bmeF6JlMbbpl1ZYzN2UTod6foi+7SgLxa49mILtL5
         DxDglpe324a02cD/k5L9CQd3REp9O67cRqC/f0vh5/MTK+kxhwgxcYJadV6b3BZkZ2Fw
         YuSxNN5fL8SsuMZRsmSAE5EKcmFIcRMjJLul/lPa5QwSei1FZOTR/2jdG1ZnPviEfw/V
         /Tkw==
X-Gm-Message-State: AJIora+9/QBtrERvtjLXaUnCMZLUb9er+7bfoyQOcgMQcEcwdK/7h3Nf
        hHXE5kODNK5UqqT5QFAYO4Xkd4jHr++M5BJyRZw=
X-Google-Smtp-Source: AGRyM1v0CB6Lm1qUdcISaT4k+g3l4Ch6gd3BTqkg3Vk6J71cTw8twfp91PHSeg20JGl30t2EQPslUnGSWIcP+40GHtw=
X-Received: from sene.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:27c4])
 (user=sebastianene job=sendgmr) by 2002:a05:600c:1f19:b0:3a1:8d3b:91ad with
 SMTP id bd25-20020a05600c1f1900b003a18d3b91admr3953960wmb.111.1656686423837;
 Fri, 01 Jul 2022 07:40:23 -0700 (PDT)
Date:   Fri,  1 Jul 2022 14:40:12 +0000
Message-Id: <20220701144013.1085272-1-sebastianene@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v9 0/2] Detect stalls on guest vCPUS
From:   Sebastian Ene <sebastianene@google.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        maz@kernel.org, will@kernel.org, vdonnefort@google.com,
        Guenter Roeck <linux@roeck-us.net>,
        Sebastian Ene <sebastianene@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a mechanism to detect stalls on the guest vCPUS by creating a
per CPU hrtimer which periodically 'pets' the host backend driver.
On a conventional watchdog-core driver, the userspace is responsible for
delivering the 'pet' events by writing to the particular /dev/watchdogN node.
In this case we require a strong thread affinity to be able to
account for lost time on a per vCPU basis.

This device driver acts as a soft lockup detector by relying on the host
backend driver to measure the elapesed time between subsequent 'pet' events.
If the elapsed time doesn't match an expected value, the backend driver
decides that the guest vCPU is locked and resets the guest. The host
backend driver takes into account the time that the guest is not
running. The communication with the backend driver is done through MMIO
and the register layout of the virtual watchdog is described as part of
the backend driver changes.

The host backend driver is implemented as part of:
https://chromium-review.googlesource.com/c/chromiumos/platform/crosvm/+/3548817

Changelog v9:
 - make the driver depend on CONFIG_OF
 - remove the platform_(set|get)_drvdata calls and keep a per-cpu static
   variable `vm_stall_detect` as suggested by Guenter on the (v8) series
 - improve commit description and fix styling

Changelog v8:
 - fix the yamlint dtschema warning caused by the missing 'reg' property 

Changelog v7:
 - fix the dtschema warnings for 'timeout-sec' property
 - rename vcpu_stall_detector.yaml to qemu,vcpu_stall_detector.yaml and
   place the file under misc
 - improve the Kconfig description for the driver by making it KVM
   specific

Changelog v6:
 - fix issues reported by lkp@intel robot:
     building for ARCH=h8300 incorrect type in assignment
     (different address spaces)

Sebastian Ene (2):
  dt-bindings: vcpu_stall_detector: Add qemu,vcpu-stall-detector
    compatible
  misc: Add a mechanism to detect stalls on guest vCPUs

 .../misc/qemu,vcpu-stall-detector.yaml        |  51 +++++
 drivers/misc/Kconfig                          |  13 ++
 drivers/misc/Makefile                         |   1 +
 drivers/misc/vcpu_stall_detector.c            | 212 ++++++++++++++++++
 4 files changed, 277 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/qemu,vcpu-stall-detector.yaml
 create mode 100644 drivers/misc/vcpu_stall_detector.c

-- 
2.37.0.rc0.161.g10f37bed90-goog

