Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E56513865
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 17:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349212AbiD1PeC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 28 Apr 2022 11:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349217AbiD1Pdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 11:33:42 -0400
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077F3562FD;
        Thu, 28 Apr 2022 08:30:27 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id f38so9704059ybi.3;
        Thu, 28 Apr 2022 08:30:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=z68eCpwlSny4KKgVzvMDlrW0IKmP+18VYo0BJNQ1LLo=;
        b=anHMc+zORSF8M+S7y2hLVWiqKpyjBbeCk9LbRDHy7McXpU4iiGMjH2PlEzx9hOpjm4
         tb24VZO3TjHCZ+dwyev7OtSk+Eg4A4I3SEP1xczFkxxBS2d3S2wOfW1Kn2/R/feKeL+s
         +5F6JPiv5CbHddg/a1kUbSWDLgf+QmX1zZ8RFp7Zy7C2xKS/MmXNNbnon3+buAt40wZO
         VlW831GKculFsNwFkc1xN+TM/ZmWdTYgJDWrRWC3Ljsdz5gJaTC1t3ZOWY8m8TO9mMrG
         9xIQRX56At7oshPlDRY3Al6Wws4qI0X0SdHwKtB6LaBV6H0jEiXH55sKbKjTupWCn2LJ
         fvqw==
X-Gm-Message-State: AOAM532N0/dohbG6OiCt8lOLEgbXo+/I4hl/q/CMDD3AgCxfK6VuuMIX
        NGgcigg5Sr3Lqql2dHQrw7Qwzg0vyV7aJUMTERnsZkhTcF8=
X-Google-Smtp-Source: ABdhPJzPMZfx4UPXN2INNyIs2eu1P0Zn17ZqR9UnELv2FZ7paKTTdO1Ce3ipLPPTSPO5es6A/L8qJehbrQl/P/N5u04=
X-Received: by 2002:a25:e792:0:b0:645:7ddb:b5eb with SMTP id
 e140-20020a25e792000000b006457ddbb5ebmr31483894ybh.482.1651159826109; Thu, 28
 Apr 2022 08:30:26 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 28 Apr 2022 17:30:15 +0200
Message-ID: <CAJZ5v0hHYRsWkRsJj+_Wa=jTS5cHasajYeh14yxEDvxu7gWWRQ@mail.gmail.com>
Subject: [GIT PULL] ACPI fixes for v5.18-rc5
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-5.18-rc5

with top-most commit 20e582e16af24b074e583f9551fad557882a3c9d

 Revert "ACPI: processor: idle: fix lockup regression on 32-bit ThinkPad T40"

on top of commit b2d229d4ddb17db541098b83524d901257e93845

 Linux 5.18-rc3

to receive ACPI fixes for 5.18-rc5.

These fix up the ACPI processor driver after a change made during
the 5.16 cycle that inadvertently broke falling back to shallower
C-states when C3 cannot be used.

Specifics:

 - Make the ACPI processor driver avoid falling back to C3 type of
   C-states when C3 cannot be requested (Ville Syrjälä).

 - Revert a quirk that is not necessary any more after fixing the
   underlying issue properly (Ville Syrjälä).

Thanks!


---------------

Ville Syrjälä (2):
      ACPI: processor: idle: Avoid falling back to C3 type C-states
      Revert "ACPI: processor: idle: fix lockup regression on 32-bit
ThinkPad T40"

---------------

 drivers/acpi/processor_idle.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)
