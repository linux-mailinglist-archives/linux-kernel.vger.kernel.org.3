Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83CD256D7A6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 10:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiGKIRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 04:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiGKIRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 04:17:31 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E6E1E3CA
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 01:17:30 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id w15-20020a25ac0f000000b0066e50e4a553so3261545ybi.16
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 01:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Ib4Fc/3Cp1X70LkZddSTB/wondVVSYZ1tVTiXK6eAog=;
        b=qNo9KUnAkAKMTTzv8JoUpYu6tWKvRhkg/2yalMse5/m6hAt0ZHORTgCvtrr0irxesH
         /txUHaWx5lsNjJ9fgVUDYsKU2YOVFoFP+wAqM/QuiyDTIjIWp/UCOqixrdU82mztdv26
         sWYLmWwU98NgwZeKXxQqIMuHgVhhfIYLBFsdiOTIQRULtykAvMdwcYJ7O/5GO2KUNwja
         PqpgO0K+p9xNlGKUaEV3a000ZiKsd3fXiXWtVufIggQqhuWZMhQv4hVEx30zIqCPTIZ4
         PaCxsMH0+DPR7Tg4qkZtRWMzNlXFhuRZKVTK3AEng4kO/emRr+EIDivdngbK0HYfrD2r
         OZpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Ib4Fc/3Cp1X70LkZddSTB/wondVVSYZ1tVTiXK6eAog=;
        b=KhFV+A0PNzyL52zeX7wDxX071Rzq4+hbkBkdQb9lQArgSWzriykMU+WIYBiQ+vey1c
         fiLqWCZ1cx1OKtlRgdqw08CDrA40fddEmUyeOdsUGq4IPKEZ3+uLOhi/1EZReK7OnsVA
         SlBWeUkGQhGLDP9OxQHZ0IMwc26XQjkZdLWHYc5CY5woeUL7V6XA++RQ6fi/wk56XA8u
         WziNB7v3mWC+LgW5dmLBG/QTc2JsjiOFQnXAmRapcW2rn9qbq+11WF8jV4kSgPzwx3lm
         vgtci4b1kwjvjnJEk0TJmmzcrQax41okYGexSIzyK5nGSQb772R6P/YPLkXdTvt2Puri
         zJKA==
X-Gm-Message-State: AJIora/9wu7fxLg/hJCLKi7i6iNByvppXbr5LisK2BXUcGKiT8hPn3fO
        8Gg3BOaGSJ6yPNhgu7pKmQF576setx6z1tsD03U=
X-Google-Smtp-Source: AGRyM1sPuK1D3F7139c1oxwWf2edgCisJWZCIDCzQdc4xbCg9WpXWs79pJDMVjX4DnbGNoYw9RNSqdvJiCObFXgCVk4=
X-Received: from seb.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:31bd])
 (user=sebastianene job=sendgmr) by 2002:a81:f8f:0:b0:31c:bd9f:31ce with SMTP
 id 137-20020a810f8f000000b0031cbd9f31cemr17951152ywp.347.1657527450192; Mon,
 11 Jul 2022 01:17:30 -0700 (PDT)
Date:   Mon, 11 Jul 2022 08:17:18 +0000
Message-Id: <20220711081720.2870509-1-sebastianene@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v12 0/2] Detect stalls on guest vCPUS
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

Minor change from v11 which cleans up the Kconfig option selection.

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

Changelog v12:
 - don't select LOCKUP_DETECTOR from Kconfig when VCPU_STALL_DETECTOR is
   compiled in as suggested by Greg
 - add the review-by tag received from Guenter

Changelog v11:
 - verify the values from DT if they are in an expected range and
   fallback to default values in case they are not.
 - added Will's review-by tag

Changelog v10:
 - keep only the hrtimer and a flag in the per_cpu structure and move
   the other fields in a separate config structure
 - fix a potential race condition as pointed out by Will: the
   driver remove(..) can race with the hotplug cpu notifiers
 - replace alloc_percpu with devm_alloc_percpu and remove the free_percpu
 - unregister the hotplug notifiers
 - improve the Kconfig description and fix the license in the header
   file
 - add the review-by tag from Rob as the DT has not changed since v9
 
Changelog v9:
 - make the driver depend on CONFIG_OF
 - remove the platform_(set|get)_drvdata calls and keep a per-cpu static
   variable `vm_stall_detect` as suggested by Guenter on the (v8) series
 - improve commit description and fix styling

Sebastian Ene (2):
  dt-bindings: vcpu_stall_detector: Add qemu,vcpu-stall-detector
    compatible
  misc: Add a mechanism to detect stalls on guest vCPUs

 .../misc/qemu,vcpu-stall-detector.yaml        |  51 ++++
 drivers/misc/Kconfig                          |  13 +
 drivers/misc/Makefile                         |   1 +
 drivers/misc/vcpu_stall_detector.c            | 223 ++++++++++++++++++
 4 files changed, 288 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/qemu,vcpu-stall-detector.yaml
 create mode 100644 drivers/misc/vcpu_stall_detector.c

-- 
2.37.0.rc0.161.g10f37bed90-goog

