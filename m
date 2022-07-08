Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95A2256B859
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 13:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237638AbiGHLX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 07:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237946AbiGHLX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 07:23:57 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7942688F24
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 04:23:56 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id r17-20020adfa151000000b0021d6c4743b0so2934417wrr.10
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 04:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=mnKejCdshNN0Dmo2YAvyT6ckd8FDauFN2fL/+9frCl8=;
        b=pekMrts+wxArWkuFEhjVDCEEOdk4vNDgqo9QHF6jbPYoSC5M8/7R8GrquZehUGjL0B
         MNZApvAsBXa0QtmW7m9cHpWpKem4rQo2MOHSZlmI9ftd7QrGMuih4VedwtgUskAgF2xL
         3NWeFpNzci3LS8GpH6gLtz0dtcAbgXGhOFZXNH6rFsvGTtY6K3HYWmCDJKGP9uX7iiAo
         Z5JsANO8GE5BDfXL5CBP4/Q0I8oUQJT2IZgCWjGovadNSyDnFbnQtT9bBrMmzrqHd0o3
         wp0N+SUcU2bXyi0TEdijdTd0ELqgZ8AXIGTWaRPIZt5m8AKcKNSVO0GIWFgofzR58zCW
         KPdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=mnKejCdshNN0Dmo2YAvyT6ckd8FDauFN2fL/+9frCl8=;
        b=d7SwzQzNWaH2wfn3VI2QjIqdeal6ujhyuCY6b97eIoRaClVUb7Ybvi6YjSZN0aD5CM
         QA08LqiHYFQloiLFUGRgwJtcL9vhuGdfS6ijiWybceyj9tWOqmuvIpVpg2x+8sqfeUYg
         P+m4vPj7ROFQpOXm3m+Rlk6OdxkKmu1Htd8tq8ao/yH3kJ1U18HVelUNNVkJAH0IHcHs
         4btoVlhY8Cnq43vGRxU3bRzCgYZ9KWPIjw5Ir8/LUqrA60Ns8T+5QmWw9adaqKa5SATC
         mNwm8sxIGbrAov1INd1XHWcASyOz9zGlYq4ysUxFHo6gamwbOWJeDxJjDN5u/twRRDJT
         owHQ==
X-Gm-Message-State: AJIora/Br+m0OzJRYUp6yHppltukqE2ccHb4oqe8BlK1cP4drcLCbNFq
        RjTq+ejF1ydJAtV3aun2cKjT7dKtg2WlUYvCUsM=
X-Google-Smtp-Source: AGRyM1s/RnDXpum5oZRKKJm7fZvKMQqsLhRlQ8Xqp0r/cLrSv28xBMnvn1W9wG9KVTJI+iRVHLSHRi+gxLnvCZ92cjw=
X-Received: from seb.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:31bd])
 (user=sebastianene job=sendgmr) by 2002:a05:600c:3ac6:b0:3a1:95b6:3fc3 with
 SMTP id d6-20020a05600c3ac600b003a195b63fc3mr10249273wms.57.1657279434940;
 Fri, 08 Jul 2022 04:23:54 -0700 (PDT)
Date:   Fri,  8 Jul 2022 11:23:43 +0000
Message-Id: <20220708112344.1965947-1-sebastianene@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v11 0/2] Detect stalls on guest vCPUS
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Minor changes from v10 with some cosmetic fixes and DT values
validation.

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
 drivers/misc/Kconfig                          |  14 ++
 drivers/misc/Makefile                         |   1 +
 drivers/misc/vcpu_stall_detector.c            | 223 ++++++++++++++++++
 4 files changed, 289 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/qemu,vcpu-stall-detector.yaml
 create mode 100644 drivers/misc/vcpu_stall_detector.c

-- 
2.37.0.rc0.161.g10f37bed90-goog

