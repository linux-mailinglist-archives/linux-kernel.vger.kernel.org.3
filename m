Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDD54CCC3C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 04:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237843AbiCDDX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 22:23:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232353AbiCDDXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 22:23:55 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26D73BA5F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 19:23:08 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id u2so6119973ioc.11
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 19:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=jRsQTn4wCzaZWlo654y/O+Q/GT31fRr+BuSdOnqZR1Y=;
        b=fvR7piB7DZnzOqqEYJxB8wUul9orDCFdnSskryfHkY9iKX+zek1+kF14XqR/0huQds
         6O/QovSQXZ2x93e4bID4nSKW9FpMbJJ5F+aPY5raEkvF+A5NkPAC9R+SSjAIQo3pn/ut
         jwLfzh4XrvM1yX83aI8UbSyQgs/N4cLShG3coEukqtnI7O+SyUzVsAGjpiH4zdXPOkkh
         RA7nOZHsbtJy6DsN20093328KZlbMFqwKJHsr77SmxgW+A+k70tiogRN910AoaESmZ7J
         hzOfktD0beL3xtlyOq3eXoGiuK3eM9BzACI0QB8KX65+rce/0KmgwoJhjObToxGAywSX
         Ajzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jRsQTn4wCzaZWlo654y/O+Q/GT31fRr+BuSdOnqZR1Y=;
        b=J2cq/mxFqpREb+yz3LzGIiwlbpI0RSZa4roI5s4JfXftgLVg+3YgNOZqaN/jB1QFGQ
         iAnySp7hhq7sFFM/wIgc74ztu6J0OQrEPbk8ZzcH6mSOckjYAiYWxKTbeMKMvgmGhW5m
         dePv5+EI4uj9+Xi40CJFu91iWNch24QLQ51zNv/B/OwJIBYieYQsGjLTQC65/eDej0Oe
         hjy9IovhWec4imnewl4PHUaGTLAz8iuLp279PLGcJeTi7rkAJlnC4TFL/ucrasDP0ytS
         9UUofnW7BLCM2n7gDxrgF40uejfIg0eNQhS3nzF1bNjEtsAIbqsaMJLZ6uSU9/zxyuJD
         c99Q==
X-Gm-Message-State: AOAM532J/YCaM06KbLEPi0EVF7qwXdH/4X0zEaslzazOafuwtjN5qD8B
        Gvwj7okz8v+zXuRVyrrx+KA=
X-Google-Smtp-Source: ABdhPJzBuxIH+6Sm/YdwRiul6bTlvL+N3IPEgoVoC6l7BDY9imdraQNZYs3AJB8ldE1OX/R3UBuclg==
X-Received: by 2002:a5d:9da2:0:b0:645:6c2f:bebf with SMTP id ay34-20020a5d9da2000000b006456c2fbebfmr4594026iob.91.1646364188123;
        Thu, 03 Mar 2022 19:23:08 -0800 (PST)
Received: from localhost.localdomain (118-208-215-36.tpgi.com.au. [118.208.215.36])
        by smtp.gmail.com with ESMTPSA id a13-20020a056e02180d00b002c25b51d5ecsm4114751ilv.55.2022.03.03.19.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 19:23:07 -0800 (PST)
From:   Sam Zeter <samuelzeter@gmail.com>
To:     mhiramat@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Samuel Zeter <samuelzeter@gmail.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH v2 0/2] *** Fix reformat_objdump.awk ***
Date:   Fri,  4 Mar 2022 14:16:09 +1100
Message-Id: <20220304031611.5763-1-samuelzeter@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <YdeGWyzvsXxntcAT@archlinux-ax161>
References: <YdeGWyzvsXxntcAT@archlinux-ax161>
MIME-Version: 1.0
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

v1 -> v2
 - coding style commit message amendments.

Samuel Zeter (2):
  arch/x86/tools/objdump_reformat.awk: Ensure regex matches fwait
  arch/x86/tools/objdump_reformat.awk: Allow for spaces

 arch/x86/tools/objdump_reformat.awk | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.35.1

