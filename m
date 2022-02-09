Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B32E4AFEF5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 22:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232828AbiBIVFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 16:05:12 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:56540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbiBIVFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 16:05:10 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540FEC0DE7F8;
        Wed,  9 Feb 2022 13:05:13 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id o5so2896277qvm.3;
        Wed, 09 Feb 2022 13:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=ac1mMycr6TtXOk3H7uuzPcsuDtpgesWeY4zn/Orjm6k=;
        b=AjKI75/R1jH5ydz2pCB/liWUcVbLcrO0FSCITzpud+/+zRW4g3zJhXXXyutPeVN9Sh
         +3ZZjPCe1jTB2iELArMj0vsWlPP60zqNpNU+9oRG4A/X0FsK+hFqiHcZlFYwHOt5eYyk
         ZT8zlgWt6BZ64v3ua/1Cb60Q91Qp4BpYPUxAeVdcvSW6yaJ0N/iOSQNm4JRqsmPuk7bu
         g2cbcx8MhvZsSExbkVnA0RZD5VyoW1QYrdp0uPzPJEqww3rYr5u3obNF5fr96t81a/gu
         exJelT0boFFhL1IHOMAPHaFLVyCCkS1QNMyLy2WNKnyODQblH5l3yK6GBn7Djq5fVfas
         thEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=ac1mMycr6TtXOk3H7uuzPcsuDtpgesWeY4zn/Orjm6k=;
        b=cmwAkQOO2X5m3gh1vxpNxrk4PT0JA+Xne5KmK3gyozOJVrjKXglXSpWaRjKtMEpjdO
         RsRs3aBZjmc5AdNWO3ttUoFInDbFTGeKmMk0rDQecB/UFQYoQlBmq82YhnJB55JgkcjY
         2I29gyh0KKWm4AQagSDw/zGq34i4KGj1qQLTXdf/irhoRwLq5m2CZd4WuPfb83OCj7Ak
         pkjkQY24bS0t7ew2+dASCELeQbHVAkcyErGVDfPb3T4B1vxf8YiKEExPzVpm1uTIrlBB
         TpMNkHBXQvlosEPfm/oAEWMkBNl+MDCiU3GUBPS+hXhLjS4W4NrBsGOZRdFRPSVXH6PY
         dQ/w==
X-Gm-Message-State: AOAM5301cQ0dzjdPkvb7iqnH3tavbensd5Emntw2CtozyzS4+K+9zU3X
        APwJT3t286vzxpHlF3qWlg4=
X-Google-Smtp-Source: ABdhPJyn0A+6yUuYEqSwzNY19jd10m0+ChZ9Yxs+ZBCojfgDiSXvo6Nm285EbLGMmt7G7blrhpS8MQ==
X-Received: by 2002:ad4:5c6d:: with SMTP id i13mr1651202qvh.120.1644440712507;
        Wed, 09 Feb 2022 13:05:12 -0800 (PST)
Received: from [120.7.1.38] (198-84-206-107.cpe.teksavvy.com. [198.84.206.107])
        by smtp.gmail.com with ESMTPSA id b184sm9198490qkf.87.2022.02.09.13.05.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 13:05:11 -0800 (PST)
To:     linux-pm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
From:   Woody Suwalski <wsuwalski@gmail.com>
Subject: [PATCH] fix linux 5.16 freeze regression on 32-bit ThinkPad T40
Message-ID: <80742062-8629-3978-e78d-92ffc9bb2e0b@gmail.com>
Date:   Wed, 9 Feb 2022 16:05:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101 Firefox/68.0
 SeaMonkey/2.53.10.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
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

From: Woody Suwalski <wsuwalski@gmail.com>

Add and ACPI idle power level limit for 32-bit ThinkPad T40.

There is a regression on T40 introduced by commit d6b88ce2, starting 
with kernel 5.16:

commit d6b88ce2eb9d2698eb24451eb92c0a1649b17bb1
Author: Richard Gong <richard.gong@amd.com>
Date:   Wed Sep 22 08:31:16 2021 -0500

     ACPI: processor idle: Allow playing dead in C3 state

The above patch is trying to enter C3 state during init, what is causing 
a T40 system freeze. I have not found a similar issue on any other of my 
32-bit machines.

The fix is to add another exception to the processor_power_dmi_table[] list.
As a result the dmesg shows as expected:

     2.155398] ACPI: IBM ThinkPad T40 detected - limiting to C2 
max_cstate. Override with "processor.max_cstate=9"
[    2.155404] ACPI: processor limited to max C-state 2

The fix is trivial and affects only vintage T40 systems.

Signed-off-by: Woody Suwalski <wsuwalski@gmail.com>
---
--- a/drivers/acpi/processor_idle.c    2022-02-04 09:09:54.515906362 -0500
+++ b/drivers/acpi/processor_idle.c    2022-02-04 14:21:08.264911271 -0500
@@ -96,6 +96,11 @@ static const struct dmi_system_id proces
        DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK Computer Inc."),
        DMI_MATCH(DMI_PRODUCT_NAME,"L8400B series Notebook PC")},
       (void *)1},
+    /* T40 can not handle C3 idle state */
+    { set_max_cstate, "IBM ThinkPad T40", {
+      DMI_MATCH(DMI_SYS_VENDOR, "IBM"),
+      DMI_MATCH(DMI_PRODUCT_NAME, "23737CU")},
+     (void *)2},
      {},
  };


