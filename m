Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0346B514446
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 10:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355606AbiD2IeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 04:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355648AbiD2IeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 04:34:07 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188702DABA
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 01:30:49 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id l7-20020adfbd87000000b0020ac0a4d23dso2807734wrh.17
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 01:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Rk2iiGqfUOFpCBmrs7zJdywSY+FPn3ERCMZZoVxLcPE=;
        b=GpMOzAkFJqRf4FLHBMv6LpR75/N9HNi3lX+DoG9LqOtewHwTgxGylO05gVwXdhv3cd
         BsNj5PZF6HDVgBs2EFHwf+xrWaMalACP0HKOO2gPcwWGAHVqd4lErEAhDmgahZwzYYGz
         fsEQNNqhW3cAd1OLA9z5UsuRkRHySmQySEQXY/dtp3rEVotqRVygMLz1KK7oGkRssmCq
         g+XnIs5Jf1w58jHvb34VUT1YZso+bw31Xn7y+bsLV5A0WVMh/p8m6EZDMjGEHXTvBTGp
         TF6LXmLaUBKci0rGMpLu+1ggwRw8pzeu1PkYM9g09dQCj0veku0CzdpblCRfQ2+fdOor
         qibQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Rk2iiGqfUOFpCBmrs7zJdywSY+FPn3ERCMZZoVxLcPE=;
        b=TBJvcAx2pdb3ArlIEFcZSHg+fRNLeIi/2+djykk0+8w2B5Hw2IwLCvNhqAhLNdr2T1
         2QsWbLlpMDXZb75KbA6aFm32ztR+Idb74Bi4ilQyZLSvBGYpsZVY/ZR5NdxPaEXATlSw
         5X75/CqWZ3/+vCcW4wG9FBie94ewwAHLx2rq6OiAC7LMMED5YEGLR7huVjbiouEvqvzr
         Gh9kgBmJGn/geDIvvi3A/yAs4/BF/mo0K0LEgZNBpp6hzj2MsfEhHY8HDd5vjcE4VEIs
         cfPHOjlGdfp5PoWdGq3MdXDIxdBsXPCSc7/KZP9nBGKk1ziRb/1bxAfWXWtErsCvD6KU
         bgAw==
X-Gm-Message-State: AOAM531hjMLTl6CoeeLCp4samc/mj4SYQWxtzZ01SDSaStkiw9xBzEFp
        hyvblV9k0JuGvJLznEELvKFirobLAT5jl8ECXUY=
X-Google-Smtp-Source: ABdhPJxx0pMSMn7MJly4lWRl1/NGHzIjNSTXQ19Ch6yh9mbjcM2+Vxl1ntguE4TbscdUKjpPEuEyjlMPUauvrxMD77Y=
X-Received: from sene.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:27c4])
 (user=sebastianene job=sendgmr) by 2002:a1c:7414:0:b0:394:1d5d:27f2 with SMTP
 id p20-20020a1c7414000000b003941d5d27f2mr2163995wmc.37.1651221047576; Fri, 29
 Apr 2022 01:30:47 -0700 (PDT)
Date:   Fri, 29 Apr 2022 08:30:29 +0000
Message-Id: <20220429083030.3241640-1-sebastianene@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH v4 0/2] Detect stalls on guest vCPUS
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
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

Changelog v4:
 - rename the source from vm-wdt.c -> vm-watchdog.c
 - convert all the error logging calls from pr_* to dev_* calls
 - rename the DTS node "clock" to "clock-frequency"

Changelog v3:
 - cosmetic fixes, remove pr_info and version information
 - improve description in the commit messag
 - improve description in the Kconfig help section

Sebastian Ene (2):
  dt-bindings: vm-wdt: Add qemu,vm-watchdog compatible
  misc: Add a mechanism to detect stalls on guest vCPUs

 .../devicetree/bindings/misc/vm-watchdog.yaml |  45 ++++
 drivers/misc/Kconfig                          |  12 +
 drivers/misc/Makefile                         |   1 +
 drivers/misc/vm-watchdog.c                    | 206 ++++++++++++++++++
 4 files changed, 264 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/vm-watchdog.yaml
 create mode 100644 drivers/misc/vm-watchdog.c

-- 
2.36.0.464.gb9c8b46e94-goog

