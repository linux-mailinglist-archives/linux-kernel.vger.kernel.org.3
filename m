Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37D0150B9F9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 16:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448601AbiDVOXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 10:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448639AbiDVOXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 10:23:08 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F641CFCE
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 07:20:14 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id h65-20020a1c2144000000b0038e9ce3b29cso6121922wmh.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 07:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=qTPY8gsQL078ALRM1/DUvRQZcjcPJuXqtsaikh+Vw30=;
        b=L3B5Y+liB8VVKkJJHHvrQvb/R9nucIkBWsj6vsIcqz1xjEDK5XIpgwNUGOLfz6TXyY
         bQwxqGhS9DMn198tnr3lEg5u9VkTaUxk3fHXCtNp30lDLxKkbsDYQrjI/2VoiX0ZSi/S
         EWaPfp1rD+ZC4p7k8jhUfa4AJF5Y9/ujvjuh38jpBiJQQM+7qzXYSoe9q6g/RaoKOoS4
         pBDwdOsNvulef6K7EMpGEqW+1hV+NibKDaQDicRZEhsUCrq5EMqz/buwg1Tb3Iq7CCCS
         8IpfmtrAu2oUFQ+OG+tLUWs4gmHtylwjWbp5TQO/MeOxoessO7IWzzoRKHGhUWyZjlfc
         sYxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=qTPY8gsQL078ALRM1/DUvRQZcjcPJuXqtsaikh+Vw30=;
        b=NeXsk7BsxyLphmioklefgRaInOR6hpOi1kGKdo1jiVKTU1TtNK6CCRWBmYPkjsbpmo
         51lSozAs5Mm4bnM9pmbcJV30NcJufcCdUvYxYqb6yJSldU1HRUcpxlxXKefVPH8crwmU
         by5BeQHXhdFblAtJ9DbzPoKkVyU+p50B2U96jrlv0b0Q+dixLRt2tw6Csa12e7qLMO9E
         VzxxcA52swA4yIMYiM7mjESwcAPl3I4FtkBaAtMtp+kdiDxz1Gs2qV/f/4bgWiyBBszI
         npCrlAA3XexduYa4S0PLQwBhq1OxlQQrS6dCsL3LiEP/dvwKVEWDX9EqBR0XwwNgFmif
         nzEA==
X-Gm-Message-State: AOAM530RZKuNlnusAxFAZ4zWV9Sna/yMCqQQVMgJyPi3petVIwNe4mwO
        GHRJnCWSS8iu8lW5YBJ6kupwshsugZddzv2+ydc=
X-Google-Smtp-Source: ABdhPJxOmW6xjRv6wOZDZ6fgSX3jJtCqxtsgg4EO5EtCm1YfQ9jw+7H4yUgjlJwjrAi2BLQ9znUa9D7nxe2/IQ1nGJ8=
X-Received: from sene.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:27c4])
 (user=sebastianene job=sendgmr) by 2002:a05:600c:5112:b0:392:8a00:cf16 with
 SMTP id o18-20020a05600c511200b003928a00cf16mr13414205wms.169.1650637212457;
 Fri, 22 Apr 2022 07:20:12 -0700 (PDT)
Date:   Fri, 22 Apr 2022 14:19:48 +0000
Message-Id: <20220422141949.3456505-1-sebastianene@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH  v2 0/2] Detect stalls on guest vCPUS
From:   Sebastian Ene <sebastianene@google.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        maz@kernel.org, will@kernel.org, qperret@google.com,
        Sebastian Ene <sebastianene@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a mechanism to detect stalls on the guest vCPUS by creating a
per CPU hrtimer which periodically 'pets' the host backend driver.

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

Changelog v2:
 - move the driver to misc as this does not cope with watchdog core
   subsystem
 - fix the dt-bindings warnings

Sebastian Ene (2):
  dt-bindings: vm-wdt: Add qemu,vm-watchdog compatible
  misc: Add a mechanism to detect stalls on guest vCPUs

 .../devicetree/bindings/misc/vm-wdt.yaml      |  44 ++++
 drivers/misc/Kconfig                          |   8 +
 drivers/misc/Makefile                         |   1 +
 drivers/misc/vm-wdt.c                         | 215 ++++++++++++++++++
 4 files changed, 268 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/vm-wdt.yaml
 create mode 100644 drivers/misc/vm-wdt.c

-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

