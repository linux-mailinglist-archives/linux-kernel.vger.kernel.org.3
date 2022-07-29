Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF10585421
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 19:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238142AbiG2RF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 13:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236850AbiG2RFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 13:05:24 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991D913DEE
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 10:05:23 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id w63-20020a17090a6bc500b001f3160a6011so7065242pjj.5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 10:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:to:from:cc:subject:date:from:to:cc;
        bh=/3BdWYttn03VGR4fwCuRJmzCnEYtlhjvSmUfc+xUaAg=;
        b=AbfEDD9zPqfj25/856E5WxuTS6BHzNWjlH65DEm/Wf49Pog1AlvEwqlH/JQQsJARnn
         7wbbku7SuNgR6/VJRMDDzHyNxkO/oqA0KaVG7NM3T9IuPQKlARjFhEukX39wDY84mqkL
         xkcNF7NDiwLGQci48SdCnk5nLN8etTD/tIKiX8Jza7ONVSyyMkuo8cOR9RaNZqF1qZ1K
         KhNsSqNMiCjji8q6tS6H8Tzy4it+WxBtZmAVwhETPtyMQi+AkzrnKxJhqpc/Bv1LUbvK
         pEi+bVoRPggLJYEkZePtbpSnUbvPF2AKcx/Wvnzx6Ml4RP/NlPoWQ9YY0VwGUTlyRWi/
         Bjww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:to:from:cc:subject:date:x-gm-message-state:from:to:cc;
        bh=/3BdWYttn03VGR4fwCuRJmzCnEYtlhjvSmUfc+xUaAg=;
        b=y6GCFoPbrLvyz8EruAqyYO7dbrp+W2+jnwYqfUqXyzuJf3SdZWI4ydjZlglliwSA3i
         N6g9+7dtcq+g2l137snCU9ql1c8Foz/LWoO+QtMLhDkMA3saCnUIzkvRo78yQ+FjjSt+
         aliAsiTJvcz97a7QmWGK5DsFldQuV8g8VlL+8EwDaiCY1kGNGSLvVYvo6e6xQMlerdWt
         knqq8B3dbR6k2+Ql7fhyZ/LjB5RBoyyDd5D0RJW5sAGuGWHDO8P6R78K7NDaXfc9Ht5/
         DXb9UYAbFvbxwJyYdnt/iKPoeFK2AGCclyeYJzflmpRVMbpA6xA253ie6t6hJZWY9c4l
         J4DQ==
X-Gm-Message-State: ACgBeo0C74mOujFqCMlli5bacCuY+b9qg/E7AGdoZkzbUtYz+YBjcEXH
        Ow1XbOlPTPSJyDk/4gjjCaUwjA==
X-Google-Smtp-Source: AA6agR5BxLWeIzE9fX8MvX4co5THji4842WgX+WlF6UbFnHK7wEbUrrPvOfdDsgaSArpV6mX9k+K7w==
X-Received: by 2002:a17:90a:9315:b0:1f1:fea7:5899 with SMTP id p21-20020a17090a931500b001f1fea75899mr5646182pjo.123.1659114323013;
        Fri, 29 Jul 2022 10:05:23 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id h4-20020a170902f7c400b0016a6cd546d6sm3777919plw.251.2022.07.29.10.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 10:05:21 -0700 (PDT)
Date:   Fri, 29 Jul 2022 10:05:21 -0700 (PDT)
X-Google-Original-Date: Fri, 29 Jul 2022 10:05:10 PDT (-0700)
Subject: [GIT PULL] A Single RISC-V Fix for 5.19
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-b20f34d5-a1cb-4254-8cc5-d3c7752b3908@palmer-mbp2014>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit c1f6eff304e4dfa4558b6a8c6b2d26a91db6c998:

  riscv: add as-options for modules with assembly compontents (2022-07-21 12:09:29 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.19-rc9

for you to fetch changes up to 88bd24d73d5bfa1b7b97a9221ff320fc44ef401a:

  riscv: compat: vdso: Fix vdso_install target (2022-07-22 12:23:14 -0700)

----------------------------------------------------------------
A Single RISC-V Fix for 5.19

* A build fix for "make vdso_install" that avoids an issue trying to
  install the compat VDSO.

----------------------------------------------------------------
Emil Renner Berthing (1):
      riscv: compat: vdso: Fix vdso_install target

 arch/riscv/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
