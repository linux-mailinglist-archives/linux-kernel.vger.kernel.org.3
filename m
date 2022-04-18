Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D597B505F15
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 23:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347852AbiDRVED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 17:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiDRVEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 17:04:00 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B7529CAD
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 14:01:20 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id c23so13362686plo.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 14:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g9SlBxAEXYzwjMJu7o40O+pCRbCnTB4bqjasZkmIBA0=;
        b=ByXT3wNKAzy3pU4dREgQ1/iR1Ngw3Bz9HOtrRq/dTlBl3k4nFzga6Tec5mPOBaFhxy
         d/54ItH6YXWdMSmy0QZNk1HGHgamliJQUT7H+DtnjNSfxNxsLZjNq93ASUyvLfU4ZQfa
         nNLtwRXtjagwpFitkrywwMGHAgAldsx942WeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g9SlBxAEXYzwjMJu7o40O+pCRbCnTB4bqjasZkmIBA0=;
        b=z0fTCNTK/THHYYdVLLdUdvoJ5q92Cg8zIqv3hwa20fks2tCIdGsjybNGyHyx44DDTH
         Dum99WN68yScEoqchNnSySNfNBzO3TGOh/wSSaw+C/5KZJX39TINJLo5fiKNpAK5VmST
         eCBD2kmm3SZy6BOkzopw/cizrceBS2qK7SQSEBQyrdKVwkShYzgRtnFOXEV1Nvl6WRdR
         bcY9Ae5+/6eG6fFRTVSY2zDl1Xba0iIMYVeCwShYVovdFxYOaG6nxoUdONhT4hNHi/r0
         IKLbvOp4/nD5gz1xGkG6FlPalGMl4LTSA20LuZXB0tNrPRJMz9ULI3UwDL/DUtBj1F7s
         y8Dw==
X-Gm-Message-State: AOAM530Cbpdu4hWAWV5ws3au1u4SQzGjF0h1VbQQsPAgwIc+2c9N5z0A
        Rn8V/ZfKMp4BPt7nqSGz6KalMA==
X-Google-Smtp-Source: ABdhPJyTk+256wVTv5JKwXa8bLCDE564IyAH4Nof8tBOM3DOv5axJP7gLoG52I8CiMe57tjHle/w2A==
X-Received: by 2002:a17:902:7fc5:b0:158:1de9:4646 with SMTP id t5-20020a1709027fc500b001581de94646mr12368232plb.91.1650315680061;
        Mon, 18 Apr 2022 14:01:20 -0700 (PDT)
Received: from evgreen-glaptop.lan ([98.47.98.87])
        by smtp.gmail.com with ESMTPSA id y15-20020a17090a1f4f00b001c7ecaf9e13sm14047973pjy.35.2022.04.18.14.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 14:01:18 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rajat Jain <rajatja@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Razvan Heghedus <heghedus.razvan@gmail.com>,
        Wei Ming Chen <jj251510319013@gmail.com>,
        Youngjin Jang <yj84.jang@samsung.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH v2 0/2] USB: Quiesce interrupts across pm freeze
Date:   Mon, 18 Apr 2022 14:00:44 -0700
Message-Id: <20220418210046.2060937-1-evgreen@chromium.org>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

Changes in v2:
 - Added the patch modifying the remote wakeup state
 - Removed the change to freeze_noirq/thaw_noirq

Evan Green (2):
  USB: core: Disable remote wakeup for freeze/quiesce
  USB: hcd-pci: Fully suspend across freeze/thaw cycle

 drivers/usb/core/driver.c  | 20 +++++++++-----------
 drivers/usb/core/hcd-pci.c |  4 ++--
 2 files changed, 11 insertions(+), 13 deletions(-)

-- 
2.31.0

