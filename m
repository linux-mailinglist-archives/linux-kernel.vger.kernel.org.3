Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C254485ED8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 03:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344867AbiAFChd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 21:37:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344796AbiAFCh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 21:37:27 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5027EC061245
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 18:37:27 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id rj2-20020a17090b3e8200b001b1944bad25so1662081pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 18:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5UkAZUrjfzO4AUWpPfb+4/H/UxI1o2rcJZ/LQS4Gka4=;
        b=U3odGgTYfDp8i9eXDQWhKt2tSA+vlyRD5/v8HS1uSEpeEcYjziNJC+8w47+i7aHbzC
         tXsUDE3+YCPvLYpbar45hAiRkqyhZ2Ikse0HHKoX57tggnNCFUYj58naRAon65yfH8fY
         16m/TZosMBIWkBk6VTOqXE8DZqTIultBDFCJM0phAzB92zUe+B46NdFVih/l/dJ4QVfw
         khyEwkEmMUZKBIkzqmXOem5qfbS/uFlbtnnxrKUdM3mws7FchEKHzsDYcuB5BC+uS1YR
         B4nmQrkeXw5c1JRNWwrhbc61rgxW6aE1dW3D3ePZpXi+AQggwA1Yv4sBgS80C0dJeluu
         je9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5UkAZUrjfzO4AUWpPfb+4/H/UxI1o2rcJZ/LQS4Gka4=;
        b=XSg3+FQUshr+2lERlNEQRXSz0k24NQ/5G6kqVkVoBz5sXl9BhtU4COhpu9Qp0DhWVM
         QnyZK+jOK7J0csYaWFh88hQqH3RtYYrAiUIP+eW0xB2yddXMX/lC79kUibGCn2T2ps6Y
         m6PjORLgNHZM9FvSpyT8ZI2t7pVY/8NRj7NGlFlK0lCzjeIziAm7dLPJVJqkzeWzJX5x
         jzBjwRId+mLJ54eodoJVg2vwOZzQtvIVhRYz3/XXwiHC2nWwMlZMsmHFDnKg94zJzXYs
         lZ4MgYhlvUDX8F5Zr4I8nAQrMclh07aTZFKCzcymsvhLDpmOiqfgu2dn1DZ35KYn3fRH
         a3sw==
X-Gm-Message-State: AOAM5320VoUDUmnXP62bal6daL3BVJYpmMODNXw9U0MykbUjXrEiA8rh
        OB/z91u7yjTH8qCaxflWHes=
X-Google-Smtp-Source: ABdhPJwNXV+7RyU1tNgvQKaEQk7hh+bAM1Hixv28+JceWHH2ePKxy0GkTgZb5QpiUNYef9nBwSj9rA==
X-Received: by 2002:a17:902:be15:b0:149:a608:7098 with SMTP id r21-20020a170902be1500b00149a6087098mr28357291pls.63.1641436646767;
        Wed, 05 Jan 2022 18:37:26 -0800 (PST)
Received: from szeter.. ([2001:8004:44e0:acae:b2b7:5ce1:129d:48de])
        by smtp.gmail.com with ESMTPSA id ot7sm4575514pjb.12.2022.01.05.18.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 18:37:26 -0800 (PST)
From:   Samuel Zeter <samuelzeter@gmail.com>
Cc:     samuelzeter@gmail.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH 0/2] *** Fix reformat_objdump.awk ***
Date:   Thu,  6 Jan 2022 13:36:03 +1100
Message-Id: <20220106023606.283953-1-samuelzeter@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are two small patches which originally dealt with
the problem found at:

https://github.com/ClangBuiltLinux/linux/issues/1364

The original steps to reproduce were:
$ make -skj"$(nproc)" LLVM=1 LLVM_IAS=1 defconfig
$ scripts/config -e X86_DECODER_SELFTEST
$ make -skj"$(nproc)" LLVM=1 LLVM_IAS=1 olddefconfig bzImage

Which resulted in the error:
arch/x86/tools/insn_decoder_test: warning: objdump says 0 bytes, but
insn_get_length() says 2

Upon inspection it turned out llvm-objdump was formatting its
output differently, which caused objdump_reformat.awk to incorrectly
output its values.

After fixing that bug, a second one was seen where the instruction
"wait" was incorrectly matched with "fwait", which again caused
insn_decoder_test to fail.

Samuel Zeter (2):
  arch/x86/tools/objdump_reformat.awk: Ensure regex matches fwait
  arch/x86/tools/objdump_reformat.awk: Allow for spaces

 arch/x86/tools/objdump_reformat.awk | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.32.0

