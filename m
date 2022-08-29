Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3D05A498F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 13:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbiH2L0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 07:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbiH2LYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 07:24:21 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B448C140DB;
        Mon, 29 Aug 2022 04:15:17 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id x19so5970931pfr.1;
        Mon, 29 Aug 2022 04:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=70BdUBaRMY4+ZzbbYisrz3wEPDHj6PbHPboxTvEf+98=;
        b=noRuPDId5yIrB9WFaOhym7BrFZzBEEobY4y2Ub8GRr3OGUpeKmPRuyv3HKSpvos9OG
         lKMHeKWVjU63FNgYQHfaWAgV5vg8slRDghqWpQeOXOfymC7B1ubkLtZrgafVEoLsgDb7
         NQI98kWQj7zvrLGEH991dzf8uy40mFGuzQoayaK8bHCDroXWZ5NaPtgTU3V9KzHMWWeG
         XB9SF76ycrQplsXIjH6vLDynPPKDZiX7v+kcdLvnYpRSaLB2sc0e11SRcKLFcTf/cDQ8
         W/ZEgj82vDPN1dkB74plN1wLx+lyPHPYRm0UoWzRJL5JExBJuLyJNma9HUD/zEUQUfmP
         sA6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=70BdUBaRMY4+ZzbbYisrz3wEPDHj6PbHPboxTvEf+98=;
        b=C9i11QY0isP0ggKxtBg+6E6BZrqvwpwCSs0fFIlbXtx2NfG0+JCYcSXbUS2PL77h3t
         0HjBqFgyklXbTLh8lPHy0FdzRnuImsoKZox2rulsvRMrEthqhN70bkGUcWVjIrefSbzV
         1UWWj7Clun+3mEPunus/Dp60FQ9TBSjkEHHMzCPpvyochS4vRsbtiQcvu+kEbYNLjDLK
         uymY6QIQRLwRBIMzeLGk951+5QLTwGNrAaW9dC5jR3QwyxF5XOWGw68ixQznoFXhi7au
         O0AKTeU2bIceES+G+Dcx5FV7cBRUaon1Pp7rbay4xI5M1NRAJxXJgPEaTAHb4YK6mV1r
         /lpA==
X-Gm-Message-State: ACgBeo1r+EdX8RPO0rhNowDUEzPC+wZmsHmuhnbbWjjcdGrsBO8aUrSY
        z/xuPF1jzM0rPnzE6mn/Lpg=
X-Google-Smtp-Source: AA6agR4ohOEwnRNkGN7cKiAAV/DQb4k+uG60fgVBOZ648GaOWeRUIKYFzNiUyRNiwtCdhk2gX3wJ1g==
X-Received: by 2002:a63:ff5a:0:b0:42c:61f:b81 with SMTP id s26-20020a63ff5a000000b0042c061f0b81mr4267479pgk.254.1661771636374;
        Mon, 29 Aug 2022 04:13:56 -0700 (PDT)
Received: from sw.. (220-128-98-63.hinet-ip.hinet.net. [220.128.98.63])
        by smtp.gmail.com with ESMTPSA id h9-20020a170902680900b0015e8d4eb26esm7177973plk.184.2022.08.29.04.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 04:13:55 -0700 (PDT)
From:   Szuying Chen <chensiying21@gmail.com>
To:     gregkh@linuxfoundation.org, mario.limonciello@amd.com,
        mika.westerberg@linux.intel.com, andreas.noever@gmail.com,
        michael.jamet@intel.com, YehezkelShB@gmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yd_Tseng@asmedia.com.tw, Chloe_Chen@asmedia.com.tw,
        Richard_Hsu@asmedia.com.tw
Subject: [PATCH v7 0/3] thunderbolt: add vendor's NVM formats
Date:   Mon, 29 Aug 2022 19:10:56 +0800
Message-Id: <20220829111059.665305-1-chensiying21@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Szuying Chen <Chloe_Chen@asmedia.com.tw>

The patch series for vendors to extend their NVM format.

Szuying Chen (3):
  thunderbolt: Add vendor's specific operations of NVM
  thunderbolt: Modify tb_nvm major and minor size.
  thunderbolt: To extend ASMedia NVM formats.

 drivers/thunderbolt/nvm.c    | 274 +++++++++++++++++++++++++++++++++++
 drivers/thunderbolt/switch.c | 105 +++-----------
 drivers/thunderbolt/tb.h     |  11 +-
 3 files changed, 303 insertions(+), 87 deletions(-)

--
2.34.1

