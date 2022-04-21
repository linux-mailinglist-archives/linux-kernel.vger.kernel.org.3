Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4EA550A744
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 19:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390849AbiDURm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 13:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390843AbiDURm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 13:42:26 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048F64A3E3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 10:39:36 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id h1so5627375pfv.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 10:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2W86hA+LROK4jXyAwIAee+7wV7n8SY+P+C85vkOxOkk=;
        b=PwqFrdQW45IykVUIooF0BHYuznkhoonDtQsAl5/TMeoUb65Eu9dQrRZCWddA1SAaSS
         K0JML/y1/XmlT0u/KJadtZo/uBP8L0BxkcfmoUIZMyWEyPI/+R8JNi+T4tvM5gf5mF+5
         w6A0ULi40eLs4YzsA61rZhS1RVfnNgDekzewQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2W86hA+LROK4jXyAwIAee+7wV7n8SY+P+C85vkOxOkk=;
        b=tWa34XAA3Fbwqnk2OwAkbZqC/6kv35xPgAyZopoycEv8Mzm2DdfqIiP+0ZCxpgOSZB
         J8SgY2KjAulEQlFi3EM0m4GPerytPJhtQv0cMH+uhEwE1zM7o0NNYvb9ymun5cLpsD8i
         I0PzsaWZUUUD/5DPNSGL/XZ/ZqCTWmfhHLXLZwJteImRKKPQJXzqoDGxL6GCP9mj5ouG
         3iMkOIL6III0vYFAxqDRgZ2ApUgD/RQKdWkZ2RdaNe7tZyOehlx5uwAJo6vtogr7Ipr6
         2yWtSbveL8zHK1UUzjzz8XCyonhgF8VeIvUC2xYr3U54Gw8rZKUzghJgcUpWqkMd4Pvo
         w/9w==
X-Gm-Message-State: AOAM530kGQLQzRGT8sX7m8wNE+Xj7pADW+HANfeO7MOIqnNd4m6/TT8d
        gaPf4qGj/Z250j4Xuj7oGA8Mwg==
X-Google-Smtp-Source: ABdhPJySBSTp91/OgeIOGpK8fn81MoLnBA0bonLyz1T2bDEio80I8jMyu6TA4zf3a5ISBGmWaE751Q==
X-Received: by 2002:a05:6a00:c8d:b0:50a:62e5:6d30 with SMTP id a13-20020a056a000c8d00b0050a62e56d30mr579533pfv.47.1650562775534;
        Thu, 21 Apr 2022 10:39:35 -0700 (PDT)
Received: from evgreen-glaptop.lan ([98.47.98.87])
        by smtp.gmail.com with ESMTPSA id j6-20020a63b606000000b003808b0ea96fsm23237023pgf.66.2022.04.21.10.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 10:39:35 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rajat Jain <rajatja@chromium.org>,
        Oliver Neukum <oneukum@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Evan Green <evgreen@chromium.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Razvan Heghedus <heghedus.razvan@gmail.com>,
        Wei Ming Chen <jj251510319013@gmail.com>,
        Youngjin Jang <yj84.jang@samsung.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH v3 0/2] USB: Quiesce interrupts across pm freeze
Date:   Thu, 21 Apr 2022 10:39:25 -0700
Message-Id: <20220421173927.2845967-1-evgreen@chromium.org>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The documentation for the freeze() method says that it "should quiesce
the device so that it doesn't generate IRQs or DMA". The unspoken
consequence of not doing this is that MSIs aimed at non-boot CPUs may
get fully lost if they're sent during the period where the target CPU is
offline.

The current behavior of the USB subsystem still allows interrupts to
come in after freeze, both in terms of remote wakeups and HC events
related to things like root plug port activity. This can get controllers
like XHCI, which is very sensitive to lost interrupts, in a wedged
state. This series attempts to fully quiesce interrupts coming from USB
across in a freeze or quiescent state.

These patches are grouped together because they serve a united purpose,
but are actually independent. They could be merged or reverted
individually.

You may be able to reproduce this issue on your own machine via the
following:
1. Disable runtime PM on your XHCI controller
2. Aim your XHCI IRQ at a non-boot CPU (replace 174): echo 2 >
   /proc/irq/174/smp_affinity
3. Attempt to hibernate (no need to actually go all the way down).

I run 2 and 3 in a loop, and can usually hit a hang or dead XHCI
controller within 1-2 iterations. I happened to notice this on an
Alderlake system where runtime PM is accidentally disabled for one of
the XHCI controllers. Some more discussion and debugging can be found at
[1].

[1] https://lore.kernel.org/linux-pci/CAE=gft4a-QL82iFJE_xRQ3JrMmz-KZKWREtz=MghhjFbJeK=8A@mail.gmail.com/T/#u

Changes in v3:
 - Fix comment formatting and line wrap

Changes in v2:
 - Introduced the patch to always disable remote wakeups
 - Removed the change to freeze_noirq/thaw_noirq

Evan Green (2):
  USB: core: Disable remote wakeup for freeze/quiesce
  USB: hcd-pci: Fully suspend across freeze/thaw cycle

 drivers/usb/core/driver.c  | 25 +++++++++++++------------
 drivers/usb/core/hcd-pci.c |  4 ++--
 2 files changed, 15 insertions(+), 14 deletions(-)

-- 
2.31.0

