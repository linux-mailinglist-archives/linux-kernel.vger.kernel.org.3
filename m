Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B32B54DE26
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 11:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbiFPJ1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 05:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbiFPJ1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 05:27:47 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F202E02A
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 02:27:46 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id p24-20020a05600c1d9800b0039c51c2da19so2600620wms.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 02:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=+H/wSPyu5uczonE1k1L2bhSkK66QAXKBlpMSPoCTbK0=;
        b=Q5tv5KmfFvwqkF5kUXEudbXagRp6WdZbDbUMIk/kUF29mSf7TOoaX0sF94KSFWmh29
         VrQnbNmduhtScCE2UtAul+nkWce7Hy/m9Ayt9eHxIdIpkPNW9MhS8Egl8kXjqPQp0Fbh
         Sso3A4Q8uwJ60cBfDrxKAlxgnlecNcrowBH50mmz+Q6/txV6IMs9aJjcvqkwaINyoubc
         z9YVVrk4UEyB3ZEF1CY+6SS8qz8izORX8bxymoSZxOV4cB1P53ktlmITZIKjJNwPswaQ
         6WYDMSVjjzPx3pynb0UnY3edpA3Tic9mpszHKuctlZVuxBnVIlRZzjZVK87mvS/bEKDA
         rOAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=+H/wSPyu5uczonE1k1L2bhSkK66QAXKBlpMSPoCTbK0=;
        b=Eve015q+x2UFzuPvaH+x/goJt+8z3LKXQrrmnDb/L3gdworgOoM58h6zWBeqm5HMXS
         CJ6eJvGTeswdo1GmHjsAT3E6Omqn8r7O2hVc7uK9YxyjOgnkhIClaJkK5cx2w7N2emhr
         CyzB764whLC3crJ0khuKMnwCXJCzdjKbDy3D9yTr4FGDrgz6Wm7jFtyzd4nnNd6TinEG
         +gVfMV9jyoUVwkT5vD3PMSE076TXUAwPOvtjoq4hdCyzJE+VT1OGj109SRqN8zU22vY+
         Ckqp02nn9qdFELZdEOakrIyrGOORd/y0v1DXE9Yc8pn1Rmx16u0xNA8LmCsqjyUc2Zxl
         YHnQ==
X-Gm-Message-State: AOAM531UiKTwu9SUKyRFG1jhemVBqlsohvAl0CRHxrzwV9dIbG2YUdZB
        zhlEDVBukIzRYKA2VL6f/fxbZx7RxnaYoGw4MIw=
X-Google-Smtp-Source: ABdhPJwUrDJJtSWT8abdH4WhUDqQF6uWj02J4NIfOp2vqhK17Ccu//uO65P5TPb8qJsVMteGQmf4taif3bFghHShOPM=
X-Received: from sene.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:27c4])
 (user=sebastianene job=sendgmr) by 2002:a05:600c:3052:b0:39c:6540:c280 with
 SMTP id n18-20020a05600c305200b0039c6540c280mr790770wmh.1.1655371663864; Thu,
 16 Jun 2022 02:27:43 -0700 (PDT)
Date:   Thu, 16 Jun 2022 09:27:36 +0000
Message-Id: <20220616092737.1713667-1-sebastianene@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [PATCH v6 0/2] Detect stalls on guest vCPUS
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

Changelog v6:
 - fix issues reported by lkp@intel robot

Changelog v5:
 - fix dt warnings
 - rename %s/watchdog/stall_detector/g
 - rename the config from Kconfig VM_WATCHDOG -> VCPU_STALL_DETECTOR

Changelog v4:
 - rename the source from vm-wdt.c -> vm-watchdog.c
 - convert all the error logging calls from pr_* to dev_* calls
 - rename the DTS node "clock" to "clock-frequency"

Changelog v3:
 - cosmetic fixes, remove pr_info and version information
 - improve description in the commit messag
 - improve description in the Kconfig help section

Sebastian Ene (2):
  dt-bindings: vcpu_stall_detector: Add qemu,vcpu-stall-detector
    compatible
  misc: Add a mechanism to detect stalls on guest vCPUs

 .../bindings/misc/vcpu_stall_detector.yaml    |  49 ++++
 drivers/misc/Kconfig                          |  12 +
 drivers/misc/Makefile                         |   1 +
 drivers/misc/vcpu_stall_detector.c            | 222 ++++++++++++++++++
 4 files changed, 284 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/vcpu_stall_detector.yaml
 create mode 100644 drivers/misc/vcpu_stall_detector.c

-- 
2.36.1.476.g0c4daa206d-goog

