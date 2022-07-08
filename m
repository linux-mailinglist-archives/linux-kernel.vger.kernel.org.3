Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 592B356B5EF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 11:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237678AbiGHJpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 05:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237533AbiGHJpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 05:45:03 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE8F7B36B;
        Fri,  8 Jul 2022 02:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1657273496;
        bh=bYx4iLT2+ds595MZ/RgQpapL+sI1v2/qdy+2mnOoejI=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=fl5i/kXWL2d8amI6IcaTHVHEt2SD8FcTQ4CeayzrGQw78g+ZacI7aJGL2e9bO0e2k
         1zmi130GmS8ro7erbbMvAFYI+HmssU9fghoZoZ5r0ELNovbFSze+K/vMpb5x4+sluk
         mYCGx5Z9S9t44PjJA0gI19fSQm8opqPXdleW2mww=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from p100 ([92.116.171.120]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mw9UK-1nHdsx3JZM-00s581; Fri, 08
 Jul 2022 11:44:55 +0200
Date:   Fri, 8 Jul 2022 11:44:54 +0200
From:   Helge Deller <deller@gmx.de>
To:     mcgrof@kernel.org, jeyu@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org
Subject: [PATCH v3] modules: Ensure natural alignment for .altinstructions
 and __bug_table sections
Message-ID: <Ysf8lojv8UMZsvBM@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:3cVGiRXOX4mAe/DFDRgXP7qMYZvWpKJm3OwwLkEoz0F63K6wYKD
 LdtPzv9lLfUTA1vwkcJEW2UNn7DVd2t23MUGZ2jDwxb6iGQOfbHRmcsSLp4lsm2dyJ8HvaM
 BtSYWOQKd7EdbVuVuAN7KN2bi+SVNqnV/L6p0TPGSeMwKG42O+oRzwypmtGDFn4N4Sah+WT
 B8ySHv7scaGq+8wS9T4Mw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LfMUMTxEuwA=:hWQaqpScGsQGXdy/bEBrkc
 OI+wMS5aMY48/brHD1YMGvn3JlYIRl7NGkgRhe6Yus11p3IQ5CkLjXgDbWW4Nxq8Rjo5kGQst
 0DhLhCHHTVX6stvlHMmeMYaAtD20FqCuw7bqsxi37wu/AQqx+Dka7a/5us/KYpKNuw7RsBUJE
 9iaqrCThBVTKezgzTncwyN//H847i4RDKvZoCHx55V2D+iq6JYSl8koCK9smB1jLa06TiLWNo
 NibByh2erZq8i1aXKK5YyGoKgHg6KaNkmTpPprliAXogjnQ0yoqCq+j6A6Dcq+HvlxYrgYGwp
 Aa81xoB4wrr/m9LTp5oTJHivHgJieIg1lfdiyot06zOj0mfR6wFZ07z9KEfP0ljls/40K+KUO
 TgF4Gzdwj5PmEakWGUqohK2kmk6uLDobTjlOZLrv9ILmLOdbzJ1BmdGJ6QOD2oE/VQRkVezRs
 p7j7Sgzavmxq7LppmiYUyGZzjDAaq5ADo64RAWLM+Vioj+pHzTWGPWfQ1V2JRtKU1hd8rBi3v
 LPdmSOk/BR+i6tPGXnE/R8LELCpy72huorlgKDXH2L02SxMKMBkDyHt4kncuISyAjnIGnffgj
 3FngTbsCFv3N88AY6OapIkjYxlStA5kxkvbGAXbKiwXk24YxHKC5PVNONldXVxfFsw9daq16d
 fDXIIU98DXijGQ25riVrU2rJi/4ulHhZsyBEEHZG/i8a+/BxAkIPFF7O53OCab3dmOaYJV2Rb
 qWalxBdarS3K519vkrJwO1mf4xqTSC8O41pfZ4t8AmsHLFPVCXr4XbkHFcV3YsgOA06Tr74mH
 9ieDe2UHAfKLpoBXF2LWepyLAyUhSeJkGWoCeJoqSTcYSDYzISdXXppegIfolNos4eJ8wh2tp
 ny4p+mVf0PpTKt+5Z8FBW6j/5oxPhgM30PJcZVyUQZYzDDCPmX+yWkrHETZBCMNa0jPxOZDsh
 BGTnqj3YryXLPC/HbfMLcFLbyDASzApISrYQ4Ho3x2RZ590Z4hJSk4vm90dgxTW83AD4C/Og2
 TEpPNTxh5X8wEnGuQpF2F0PMa5pteA2fvN58VDzyB9U5EGd7HK6MLvJ2Qo4nvYuwxIH4qvt4O
 yq7nY93WSVO2f9yEcIlQwBJz01SjYpCRNqiDt023+2KMlKvXlCsb0eW8g==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the kernel image vmlinux.lds.S linker scripts the .altinstructions
and __bug_table sections are 4- or 8-byte aligned because they hold 32-
and/or 64-bit values.

Most architectures use altinstructions and BUG() or WARN() in modules as
well, but in the module linker script (module.lds.S) those sections are
currently missing. As consequence the linker will store their content
byte-aligned by default, which then can lead to unnecessary unaligned
memory accesses by the CPU when those tables are processed at runtime.

Usually unaligned memory accesses are unnoticed, because either the
hardware (as on x86 CPUs) or in-kernel exception handlers (e.g. on
parisc or sparc) emulate and fix them up at runtime. Nevertheless, such
unaligned accesses introduce a performance penalty and can even crash
the kernel if there is a bug in the unalignment exception handlers
(which happened once to me on the parisc architecture and which is why I
noticed that issue at all).

This patch fixes a non-critical issue and might be backported at any time.
It's trivial and shouldn't introduce any regression because it simply
tells the linker to use a different (8-byte alignment) for those
sections by default.

Signed-off-by: Helge Deller <deller@gmx.de>
Link: https://lore.kernel.org/all/Yr8%2Fgr8e8I7tVX4d@p100/
---
 scripts/module.lds.S | 2 ++
 1 file changed, 2 insertions(+)

--
Changes:
v3: updated commit message
v2: updated commit message

diff --git a/scripts/module.lds.S b/scripts/module.lds.S
index 1d0e1e4dc3d2..3a3aa2354ed8 100644
--- a/scripts/module.lds.S
+++ b/scripts/module.lds.S
@@ -27,6 +27,8 @@ SECTIONS {
 	.ctors			0 : ALIGN(8) { *(SORT(.ctors.*)) *(.ctors) }
 	.init_array		0 : ALIGN(8) { *(SORT(.init_array.*)) *(.init_array) }

+	.altinstructions	0 : ALIGN(8) { KEEP(*(.altinstructions)) }
+	__bug_table		0 : ALIGN(8) { KEEP(*(__bug_table)) }
 	__jump_table		0 : ALIGN(8) { KEEP(*(__jump_table)) }

 	__patchable_function_entries : { *(__patchable_function_entries) }


