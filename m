Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A02454EFD65
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 02:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353376AbiDBAXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 20:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351761AbiDBAXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 20:23:16 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1761AC42D
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 17:21:25 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id j7so907590pjw.4
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 17:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:cc:from:to:message-id;
        bh=jE+qQRnH9EKgrMoxHiPjgfT81dDNV9zU2JaW9VDF4bM=;
        b=kcVdaV9kFD1mzfOI66TNwyrUp9m0UrekXboMtXebEuUsbYN0sTNU7raS2Q0myNwDA5
         wDrn3vK7oYKx5sH1rEvvYvw9s5dZxrXo3rrdp7tlRv4M6q8seNVMH3poSWqIiVFrO7xW
         e0CLAGyHQDuyFOIDi6cgX4S6jTNaoi/rc5BCgiGe7FMC8lliortw/7EMC3tenxFO6NTk
         cuOSSc5CL/CnbXmE1iHVx0Oe0mPUjTe9fHZlQyL5NjAjWODtlt5JiS2naF+4bXkUdtYt
         ZNCP41fjCvDU4qDcGaiteArhNo67MSK9gqrgNwbcP3mzBjp8DAkuvLznEBCiH5VrSGjj
         1Q1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:cc:from:to:message-id;
        bh=jE+qQRnH9EKgrMoxHiPjgfT81dDNV9zU2JaW9VDF4bM=;
        b=UCx3Hf8szfu8gg6VorqYVBIPMWX2OupWe/6YW2jxwAixibf7bO7yvPiOzpwP5/8R3o
         QYCybBWe4VrXZNwl8OdeCESAIX+sO5JFyiZ3fFIRHdOuaup2tLNkiyB05G0J9VTwCYP2
         pvGkgIc6+5VCoCDkxqPcmqym4jJsrb2L6rNuxyBsaEPNEhgDCmWzBekedsIQ6MnlEyco
         B5e7iksKEormwBFYgwjSNb8qOzsSqB2bSXyAMe5WSa3JbO4/D0Hbn+L0+yUn6+no1nF+
         b30pzClLvIeU+SYR6oTJOaobqUodF5JX4cVD6QtMYvk5N/HDUyFJiP2RFWuGHu8f1fwi
         A6wQ==
X-Gm-Message-State: AOAM5319+xtt933927L1VZME3Q1GCow6buKjkBFZ4Ctfyzr6fT38j/am
        h/VZ6UKMLXct+OhqvRuh42eqFqrANWqGlyM6
X-Google-Smtp-Source: ABdhPJy8cCGJ5zbFQT6QaGO/PVGAMAt0Cw6l3K0ZwAdLtAtTVjI51pCipkPdILkC3Zn0LszLzXUxqA==
X-Received: by 2002:a17:902:74cc:b0:155:e153:6273 with SMTP id f12-20020a17090274cc00b00155e1536273mr38412627plt.55.1648858885359;
        Fri, 01 Apr 2022 17:21:25 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id k18-20020a056a00135200b004fb18fc6c78sm4374471pfu.31.2022.04.01.17.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 17:21:25 -0700 (PDT)
Date:   Fri, 01 Apr 2022 17:21:25 -0700 (PDT)
X-Google-Original-Date: Fri, 01 Apr 2022 17:19:22 PDT (-0700)
Subject: [GIT PULL] A single RISC-V fix, ideally for 5.18-rc1
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
            robh@kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-e799956e-2858-4ab4-9795-1255abc93c39@palmer-mbp2014>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

merged tag 'riscv-for-linus-5.18-mw1'
The following changes since commit a3dfc532b8731843c12bdc45e804eacc47e51e50:

  Merge tag 'riscv-for-linus-5.18-mw1' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux (2022-04-01 13:31:57 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.18-mw2

for you to fetch changes up to 2524257bce43610f5ec14feccbacf7a103cae94a:

  dt-bindings: Fix phandle-array issues in the idle-states bindings (2022-04-01 15:09:50 -0700)

----------------------------------------------------------------
A single RISC-V fix, ideally for 5.18-rc1

* Fix the RISC-V section of the generic CPU idle bindings to comply with
  the recently tightened DT schema.

----------------------------------------------------------------
This is a very recently written, reviewed, and committed patch.  I usually
don't like doing that, as it means it won't round trip through linux-next (and
the automatic builds), but I think this is a good candidate for breaking the
rules: we know this breaks the generic DT schema checks, it's been pretty
extensively reviewed (thanks to Rob for the help), and it's very late already.

We have a handful of other DT schema related failures on RISC-V, but it looks
like those have been around for a while now.  I've got the test running locally
and will chase those around, but this one breaks the generic schema checks so I
figured it's best not to delay.

The caveats about that allyesconfig driver build breakages apply, as they did
this morning.  Otherwise this is still clean.

Sorry for the headaches!

----------------------------------------------------------------
Palmer Dabbelt (1):
      dt-bindings: Fix phandle-array issues in the idle-states bindings

 Documentation/devicetree/bindings/cpu/idle-states.yaml | 16 ++++++++--------
 Documentation/devicetree/bindings/riscv/cpus.yaml      |  2 ++
 2 files changed, 10 insertions(+), 8 deletions(-)
