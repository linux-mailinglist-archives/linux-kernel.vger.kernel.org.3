Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFCF5A37F6
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 15:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbiH0Nm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 09:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbiH0NmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 09:42:24 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0572E2408C;
        Sat, 27 Aug 2022 06:42:24 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-333a4a5d495so97420747b3.10;
        Sat, 27 Aug 2022 06:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=9gJkjTGEZU9ZOB2WMExjMNuesjVOq7C3vZk82DKgQyc=;
        b=H+w0fc4C56QDdlnsH91zVlHNRbjHy31CNaHSo3+UDHRf+N/dj2dUvWjSZzyTZ+IXuR
         /7eEAZNZzeLIejACewXx3J6vBuWmNU/7Ce65Gk88S1SGy6Sc6TpwyTzrxOnlDcxQgU4G
         RxzpM2xXb2Yv/CoswV71GJrGFnnN4Qwwxp0MSF9zM+YFbv8xG/kUKk2oTHVrOAfBNVsa
         QBEPsi2dgJ7SjBHF7jzHYO6k5AX/yrZslKnxoERHxrrH0xL2EuxKM9/pcu61gnAvguet
         tnKu3UFgcEZSTzPvBonfsPalGcXPG5pnyMSLBKGRc3YdXFthPyllRjLJA4/FmEOjKRn5
         kbbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=9gJkjTGEZU9ZOB2WMExjMNuesjVOq7C3vZk82DKgQyc=;
        b=oFO3T5V5gHE2yMThJU5VgAcUlV2ff8KRT3VE10SdkzibBrkJV/fFtEGq+eSaZqbzZ1
         g1A+NM1v/F9KeoY/v8UVfUDxWeSGscAOz5FhznkiQAi2O6agh4FgmGaSXJVQCVmtP2ib
         fO0HarlwGnp1up2IIOqk9yBAP/KfwsSaSJGEgYUyvtnZy8bxsNTkf33joTK9/aQYXh7R
         ZFmqtJa4H5olTIR6+K20E/iBnL9TOcrEa5hOiBJyCaMKiSs0cEBphbbagY4fQ0eGmLGh
         BlhkL/yCHEM5y5UDCUzwCk7It3UPyUhbPYwtViHgFDbmzAsTk8C6tEx3iuyUYfEl7kEP
         ZbrA==
X-Gm-Message-State: ACgBeo3k9NvQ4s/hpO8iwW9HxzJn7gIVgE1s5rWXWtk1Oio8gAf5NIa1
        U6nViZhmK4IropXVEfS6uBMsUUiHzGri6UUl0vFs1qbhYqM=
X-Google-Smtp-Source: AA6agR7Z7R3cfNn0+9UD8Fiu4StynBTli+vD60DP0II7NPIOsS4na+4kpey2JW0vNEyNapbrHtN8/Y+44jr8/1GHr4Q=
X-Received: by 2002:a25:ec0c:0:b0:690:d092:2d56 with SMTP id
 j12-20020a25ec0c000000b00690d0922d56mr3076972ybh.622.1661607743294; Sat, 27
 Aug 2022 06:42:23 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?Q?Rafa=C5=82_Wysocki?= <rjwysocki@gmail.com>
Date:   Sat, 27 Aug 2022 15:42:12 +0200
Message-ID: <CAJZ5v0gzTEAf6NGQAsrG=AiWEXgBtD40gvGEp7BDzQxyXhC9BQ@mail.gmail.com>
Subject: [GIT PULL] Thermal control fixes for v6.0-rc3
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-6.0-rc3

with top-most commit 3bf1b1571224e713f1a186de21b2204c06f1cb5e

 Merge branch 'thermal-core'

on top of commit 1c23f9e627a7b412978b4e852793c5e3c3efc555

 Linux 6.0-rc2

to receive thermal control fixes for 6.0-rc3.

They fix two issues introduced recently and one driver problem leading
to a NULL pointer dereference in some cases.

Specifics:

 - Add missing EXPORT_SYMBOL_GPL in the thermal core and add back the
   required 'trips' property to the thermal zone DT bindings (Daniel
   Lezcano).

 - Prevent the int340x_thermal driver from crashing when a package
   with a buffer of 0 length is returned by an ACPI control method
   evaluated by it (Lee, Chun-Yi).

Thanks!


---------------

Daniel Lezcano (2):
      thermal/core: Add missing EXPORT_SYMBOL_GPL
      dt-bindings: thermal: Fix missing required property

Lee, Chun-Yi (1):
      thermal/int340x_thermal: handle data_vault when the value is ZERO_SIZE_PTR

---------------

 Documentation/devicetree/bindings/thermal/thermal-zones.yaml | 1 +
 drivers/thermal/intel/int340x_thermal/int3400_thermal.c      | 9 +++++----
 drivers/thermal/thermal_core.c                               | 1 +
 3 files changed, 7 insertions(+), 4 deletions(-)
