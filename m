Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89BE351DDB0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 18:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443831AbiEFQko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 12:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358520AbiEFQkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 12:40:35 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C99606C4
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 09:36:52 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id p12so6713977pfn.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 09:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:cc:from:to:message-id;
        bh=qEVz08vvf0VIHBcvKAlc53ZhzOaZzAfXKDFQQpcAtv4=;
        b=lgRamTQd2O9lDl1x9NNyFEsZ6+OhPg0g9CVw4BrS31nsXQ1KXBn03r/1OzbZ//upQO
         gSakyor/ca1sM+pP/i4SiUfiZ/7aNp+aE5vrwr1NUBH8J004nMjdUIFOATKmEQtR2QCh
         Qr6eKKKliygkzmswa+mwDUQh4lHDgkri9QHRmcoNGgSodIPRbDDlTwZ9ykROh0fF1sPQ
         HJhtsW8YCDjEpBh5eDw72l6FrpmsBn+veC3LaHcv/u2RxAK+JqPC6z1vphiCChQK368n
         aFINi3jv4V8LFKZsMuHQQUhh9IXHj/oxSkRo/UjEwB/8jXPDxnFIORK7V4UlaS6eJrQs
         wApw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:cc:from:to:message-id;
        bh=qEVz08vvf0VIHBcvKAlc53ZhzOaZzAfXKDFQQpcAtv4=;
        b=HrdGioPpgRScXWI3CPC9gfI+K1HtuGpi15Cs7w1bO1V4dKud3OqfYfsk6sr1cYT9h9
         QSu5TImaciFTTtmlJd3dodyhKlVK4/UDrEoo579LyFsfCTWQ9yA6HiLi9iEt+gl4kPJb
         7P3JHaujPdSrHv2lkMShVLOYuHqzK2jj5zuMwCgR8hFbqKFfbv9sbIwVabQ0DinRBgvB
         OL1+VWABM3UYUVX96Dx1nt1AmmiaxVFo/3SsvRcv5efkDNktDDIjmrMcijH69gHGVR+E
         JEDphFJaVmnyS9RrlrSwY5F2eOBjBdhXVs3gbPgruPm6pQJfgj6zGJI3v7ULhzDMmSPs
         HpIw==
X-Gm-Message-State: AOAM530ndzkBT58HcxbsSxKbTEJhyoIF0LO0s4ZqS8zQyxo03JcH1LqD
        KbwNGmTr3aui1kwC88YiOdMnPLD/QQ5PCQ==
X-Google-Smtp-Source: ABdhPJzjEu3WfJZwCDhm62TWNxO8ndiU3Gx+YKY2ev0GNpx4ajYDUw+tIOLYoQQPMOL+3rFk1tMcuQ==
X-Received: by 2002:a63:6cca:0:b0:3ab:892e:bfa4 with SMTP id h193-20020a636cca000000b003ab892ebfa4mr3444656pgc.494.1651855012002;
        Fri, 06 May 2022 09:36:52 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id b3-20020a1709027e0300b0015e8d4eb1d3sm1968731plm.29.2022.05.06.09.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 09:36:51 -0700 (PDT)
Date:   Fri, 06 May 2022 09:36:51 -0700 (PDT)
X-Google-Original-Date: Fri, 06 May 2022 09:36:06 PDT (-0700)
Subject: [GIT PULL] RISC-V Fix for 5.18-rc6
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-93e651e7-8975-4f60-8fab-31f695d9af2b@palmer-mbp2014>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit ac0280a9ca106c5501257e79d165f968712b5899:

  RISC-V: configs: Configs that had RPMSG_CHAR now get RPMSG_CTRL (2022-04-26 08:19:53 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.18-rc6

for you to fetch changes up to c6fe81191bd74f7e6ae9ce96a4837df9485f3ab8:

  RISC-V: relocate DTB if it's outside memory region (2022-04-29 07:59:18 -0700)

----------------------------------------------------------------
RISC-V Fix for 5.18-rc6

* A fix to relocate the DTB early in boot, in cases where the bootloader
  doesn't put the DTB in a region that will end up mapped by the kernel.
  This manifests as a crash early in boot on a handful of
  configurations.

----------------------------------------------------------------
Nick Kossifidis (1):
      RISC-V: relocate DTB if it's outside memory region

 arch/riscv/mm/init.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)
