Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 629F051F847
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 11:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233493AbiEIJeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 05:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232093AbiEIJPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 05:15:13 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2921D3D62
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 02:11:19 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id k29-20020adfb35d000000b0020adc94662dso5513120wrd.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 02:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=lywA1vt51kZck6PXzExT18cr3ZKuMyPEg8s9HmYYUI0=;
        b=EFgQknN9kz0vNqF7IeQoUwRJZqgbytppSycHiqpb1+5jMewc1YNqZG83lLllsx66wi
         hPWbTH5433R+3JdGpDwSUGgKg8RcTEclTZ1/DVxfUbuDR4hkAua6YTGmN1W9UdXaeBRb
         JpFvmzH0GXHyi6sJK6D9BWsHIwwu6l0TYLLbmovQW+zC/8kec43+NsvCl95IMKXUfriq
         XbS7eJaaxkzWsXuh1f0JSc4m/GymScAuYOUvm+IzOFWmKqQ/VoaAm4EI5sBtK4Soh7En
         80vEz99Zl8vhpI3l+ldV+l+ScQXjgKuCd0ofKBObgcFFJx9t1vTPrj/XLSb+pUKEOAV6
         hJog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=lywA1vt51kZck6PXzExT18cr3ZKuMyPEg8s9HmYYUI0=;
        b=8GlQbY0/Af5KWZ+6YoeG+Igtb8zYNmwz0/a73rTahzO0yapcMl86DbFU0U+3piYB5r
         gHdFS1HD8r+hK5RKKJOeWqNES3WGLGziwp5crmX4xGwsxSJav0siKHnqCyKcj9Hq0T5S
         gQtu41j99/jBpTfkklAwfRyJtvaVlbMYqsBph3UZWqEdivEolh3o1psTxsz2F/sOa+1+
         10ZfyIWs2dRzB1hqCiCh1QTz6NXwYmxaGH/+BEmFwCguseMuPk7NEF6enMcSxw1eMXJY
         lIDUtkBd4fA0lBoGHb1UtAgOeyigc3KM2CTJ65j3TMDwXdZmU4ixBl4xBLYZ4SHdbO2k
         syuw==
X-Gm-Message-State: AOAM533btRbhcTBmB2eIykGO2ZX1X6DDE7uqzYXIYpIcDKJyFfa8VXPm
        pkGvZ6dlR5J0bS2mZByTQ+jehqejl3cflVawGYY=
X-Google-Smtp-Source: ABdhPJwyZyyTcfhhEG5pFC5DO7mxarCBjChnI+cUNHBn5uZE7gpwtutADdy7LeFG44BngRzvvpGkp2ZI1Q9fRSrFcYo=
X-Received: from sene.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:27c4])
 (user=sebastianene job=sendgmr) by 2002:a7b:c446:0:b0:394:3293:a88f with SMTP
 id l6-20020a7bc446000000b003943293a88fmr15090980wmi.22.1652087477500; Mon, 09
 May 2022 02:11:17 -0700 (PDT)
Date:   Mon,  9 May 2022 09:11:02 +0000
Message-Id: <20220509091103.2220604-1-sebastianene@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.512.ge40c2bad7a-goog
Subject: [PATCH v5 0/2] Detect stalls on guest vCPUS
From:   Sebastian Ene <sebastianene@google.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        maz@kernel.org, will@kernel.org, qperret@google.com,
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

 .../bindings/misc/vcpu_stall_detector.yaml    |  47 ++++
 drivers/misc/Kconfig                          |  12 +
 drivers/misc/Makefile                         |   1 +
 drivers/misc/vcpu_stall_detector.c            | 218 ++++++++++++++++++
 4 files changed, 278 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/vcpu_stall_detector.yaml
 create mode 100644 drivers/misc/vcpu_stall_detector.c

-- 
2.36.0.512.ge40c2bad7a-goog

