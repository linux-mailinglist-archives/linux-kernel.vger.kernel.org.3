Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104B051674C
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 21:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350746AbiEATP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 15:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbiEATPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 15:15:53 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2909C3B282
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 12:12:21 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id g23so14503193edy.13
        for <linux-kernel@vger.kernel.org>; Sun, 01 May 2022 12:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=bu36tlVzH2TzQVlLJMW7gM0JgO8yhlXPH5ve+Eml/9U=;
        b=hmYvXCw0SPn2D5pLbRsmDBrttlEMEi3SyjZe51wsnm3Gx8MYMhiq0mXwWzm4+9mXY5
         cWqQnP5fFpsE+fKvZ2bL2OrS+6NOsIslMll7vPefhQc8W3UtB/AyboUDjm77WGTaqUvN
         I01c/VZNroCUv8/junbHfHmQWhBHQzJE/G4qzCxOWs9d8gWXSU9oi/6smvtLz3FNsbsw
         keoZa8LXjEIynemMVlpLVcg6vS9o8J/e1+tGowFv0PHHR6Obik3oK0Yif1H1kxKzyISn
         rYdBmleBKGSRjR6/+tWZuxDAIp9tcJKgMGRMiV4d6KLg4iEhx64cavEqS5kVa9iavVYb
         dwWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=bu36tlVzH2TzQVlLJMW7gM0JgO8yhlXPH5ve+Eml/9U=;
        b=ECVVtDivCmf/S4OHcknUv883cULowXeTxWiSVo83qweQJZXXMpAQbXkAkpIlTygsYz
         qQ0lipzQYql5V0wWOKG7nunMMqQ6Sp6Bc4JEUCHP65PqeA9+YSQK7blHq6T4ogBQKW9x
         IwFU44aTMdzJ7Jc3amUCL49piuJIukVyKcreTodmlcxktBD833PmmHjzEQqQ6J+xPBxo
         Wo4ip9hIKSrHxKDk6SOOJlXScoDP+24KR2l+pynZxZ5nUWYz584Kg7zeiLlJgb1a1e9h
         H+2znFZK9/ukXmNUU+WG7HctkJhIaxS3VJ+ZfmltKX2I7d8TZQM0GM9opizbRjtWiL51
         6E9Q==
X-Gm-Message-State: AOAM533M+ADrGbXkg7dQ4z8aTYWuMFwAvZgbYd32RimkAF27m6e216uZ
        UMxSpYHovVKtPKxna+tPFTUjZEYRZkDpFQ==
X-Google-Smtp-Source: ABdhPJxt2AONBLjn4RBEEiYGSXxfpWEW4Kqt75rIEjmMDyOyywhy6NhiYFtTaIGkYemOHbIkHxORlA==
X-Received: by 2002:a05:6402:154:b0:423:dba8:c7fc with SMTP id s20-20020a056402015400b00423dba8c7fcmr10080821edu.346.1651432339643;
        Sun, 01 May 2022 12:12:19 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a074e9.dip0.t-ipconnect.de. [84.160.116.233])
        by smtp.gmail.com with ESMTPSA id e16-20020a50fb90000000b0042617ba63d7sm5626288edq.97.2022.05.01.12.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 May 2022 12:12:19 -0700 (PDT)
Date:   Sun, 1 May 2022 21:12:17 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <David.Laight@ACULAB.COM>
Subject: [PATCH v5 0/2] staging: vt6655: Replace macro VNSvInPortD with
 ioread32()
Message-ID: <cover.1651431640.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace macro VNSvInPortD with ioread32.
Avoid cast of the return value as much as possible.
The name of macro and the arguments use CamelCase which
is not accepted by checkpatch.pl

Added missing big-endian support in CARDbGetCurrentTSF.

Tested with vt6655 on mini PCI Module
Transferred this patch over wlan connection of vt6655

V1 -> V2: Removed patch "staging: vt6655: Replace VNSvInPortW with ioread16"
          as it was already accepted.
          Joint patch "Replace two VNSvInPortD with ioread64_lo_hi" with 
          patch "Replace VNSvInPortD with ioread32" and changed ioread64 to 
          two ioread32 as ioread64 does not work with 32 Bit computers.
          Shorted and simplified patch descriptions.          
V2 -> V3: Added missing version in subject lines
          Added change history in cover letter
          Removed remark in cover letter "This patch series is new.."
          as it is obsolet.
V3 -> V4: Added patch: "Added missing BE support in CARDbGetCurrentTSF"
          Removed testing example from cover letter and placed it to the
          patches.
V4 -> V5: Corrected patch: "Added missing BE support in CARDbGetCurrentTSF"
          from #ifdef __BIG_ENDIAN to le64_to_cpu()

Philipp Hortmann (2):
  staging: vt6655: Replace VNSvInPortD with ioread32
  staging: vt6655: Added missing BE support in CARDbGetCurrentTSF

 drivers/staging/vt6655/card.c        |  6 ++++--
 drivers/staging/vt6655/device_main.c |  6 +++---
 drivers/staging/vt6655/mac.h         | 18 +++++++++---------
 drivers/staging/vt6655/rf.c          |  2 +-
 drivers/staging/vt6655/upc.h         |  3 ---
 5 files changed, 17 insertions(+), 18 deletions(-)

-- 
2.25.1

