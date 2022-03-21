Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8824E2CE2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 16:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348122AbiCUPyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 11:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348079AbiCUPx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 11:53:58 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC2017FD0D
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 08:52:33 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id bx24-20020a17090af49800b001c6872a9e4eso10709490pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 08:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=DaACnoSLUW1MEkWetb56IgER/rRzMuJtTLxjf/saIVs=;
        b=c6kF2DNwYyle0HR5Rp4cCjyoTtk3B2H6QSr0L3FYCv3OhgvMifvXTUS7HplZw+ZAes
         LQiGkUyu1zVOFDCiKkvCHkJFxLLmW6XmMuxCJczfWRbSBC5ZJlizxODncZhjaYkALvN/
         yoNH+ffBzfX/FE/GnMs5c30ReaHsp4ldPHBMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=DaACnoSLUW1MEkWetb56IgER/rRzMuJtTLxjf/saIVs=;
        b=LEXdqTtSlyTrIiE7EisAXeNS6UOMLCgfrY6hd5ACIPy1B+hyLDBmmganC5gD2jYIAh
         5L+mSDPf1TM/12XOcnom1sli8QFtoqkO6lBBSlH92jM3c6uKBU/IrT8OsKigxjojw1Q5
         bcRNNExrHtR87LLcnKnae6kNCQlKxcCNCTGmNosz3Vp2ddUcKd5/gqWp2bh5YX+Gb3j2
         Ef03dcivZMN5MfFLsboWynuDaLofIvLd4fw8twPMpdZoQ4L3npbgZWgNVUueTV7Z1vX5
         i3eZNAD3ay0l+qQx3nB/Q7z2prEDyA8vAiWEIFgzi630OktDZLNbT2DdqIxNtdo/avgz
         xhyA==
X-Gm-Message-State: AOAM531KOLHRhtjA84maisT0pm3S9kH4T8e/ftZag1tNrj/HNybDAdfY
        cvadQfAN37aQtCsC9PyH0dvYQA==
X-Google-Smtp-Source: ABdhPJzGKDUullg/SFTHvFDoDWDdj53aZEyITEB9xMKJb1jAx+oFNBfpvswsopjNfWUGURf+g2KuBg==
X-Received: by 2002:a17:90b:3881:b0:1bf:86ea:a5e5 with SMTP id mu1-20020a17090b388100b001bf86eaa5e5mr26651633pjb.11.1647877952902;
        Mon, 21 Mar 2022 08:52:32 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p128-20020a622986000000b004e1366dd88esm19591624pfp.160.2022.03.21.08.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 08:52:32 -0700 (PDT)
Date:   Mon, 21 Mar 2022 08:52:31 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kees Cook <keescook@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matt Turner <mattst88@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Richard Henderson <rth@twiddle.net>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [GIT PULL] bounds fixes for v5.18-rc1
Message-ID: <202203210843.0E70F58@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these scattered buffer and array bounds fixes for v5.18-rc1.
These are a handful of fixes that I've been carrying in -next in
preparation for the coming memcpy improvements and the enabling of
-Warray-bounds globally. There are additional similar fixes in other
maintainer's trees, but these ended up getting carried by me. :)

Thanks!

-Kees

The following changes since commit dfd42facf1e4ada021b939b4e19c935dcdd55566:

  Linux 5.17-rc3 (2022-02-06 12:20:50 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/bounds-fixes-v5.18-rc1

for you to fetch changes up to fad278388e01e3658a356118bed8ee2c2408d280:

  media: omap3isp: Use struct_group() for memcpy() region (2022-02-27 10:58:04 -0800)

----------------------------------------------------------------
bounds-fixes updates for v5.18-rc1

- Various buffer and array bounds related fixes

----------------------------------------------------------------
Kees Cook (5):
      intel_th: msu: Use memset_startat() for clearing hw header
      m68k: cmpxchg: Dereference matching size
      alpha: Silence -Warray-bounds warnings
      tpm: vtpm_proxy: Check length to avoid compiler warning
      media: omap3isp: Use struct_group() for memcpy() region

Sean Christopherson (1):
      KVM: x86: Replace memset() "optimization" with normal per-field writes

 arch/alpha/mm/init.c                      |  6 +++---
 arch/m68k/include/asm/cmpxchg.h           |  9 ++++-----
 arch/x86/kvm/emulate.c                    |  9 +++++++--
 arch/x86/kvm/kvm_emulate.h                |  6 +-----
 drivers/char/tpm/tpm_vtpm_proxy.c         |  2 +-
 drivers/hwtracing/intel_th/msu.c          |  4 +---
 drivers/media/platform/omap3isp/ispstat.c |  5 +++--
 include/uapi/linux/omap3isp.h             | 21 +++++++++++++--------
 8 files changed, 33 insertions(+), 29 deletions(-)

-- 
Kees Cook
