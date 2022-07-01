Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B3E563947
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 20:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbiGASkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 14:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbiGASkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 14:40:11 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A0223152;
        Fri,  1 Jul 2022 11:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656700803;
        bh=LQhKkVh7ERzHyd0XFztdkI4wYKz/OTZWu0gTeX+kc9k=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=ko5EUt6drjtBLxn8lnaa94mVfh3+4mSBNr/LUgwpUM+B2O+6IKrNQL8eXH1iqYe9l
         2Md92OUhe8EeS5oZuBpn6GJcirljPxi7e0MXw5wIcUxTugrO0pXhElfMpqvjr3wMUR
         c83MbRGQXDH8NgYYCqSxSYgrcOUxu/ouICxPrsas=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from p100 ([92.116.182.192]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MDywu-1nxPPT2KrE-009xA4; Fri, 01
 Jul 2022 20:40:03 +0200
Date:   Fri, 1 Jul 2022 20:40:02 +0200
From:   Helge Deller <deller@gmx.de>
To:     mcgrof@kernel.org, jeyu@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org
Subject: [PATCH v2] modules: Ensure natural alignment for .altinstructions
 and __bug_table sections
Message-ID: <Yr8/gr8e8I7tVX4d@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:V5gOQb0rPPCFwBpCuwfiHq/tFNJjfharij+9vL3FdnDAm2wBBWI
 96O1pYHAyF7lCJE0O7tIdCP1OaKt85C7BcGhvPA6EKK11BRaxx4b1iFA2ETGkzSVFNH/yaF
 zdh3MMWwKgzlRY6Izzk6bXdtTXgUpN9FzUoH9iN9l7MKn+l8SxSMZh2lBQQb7aDzaYKg0bB
 4NU+S7zkdJvhMeKF7adrw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cylAGrI9jeY=:5FFRWh/zKj+pba37xv/oVO
 Tw+LQcfrmUWKF/l8f10i6zuTgxvnsKB0rK37i5rjJ+vZYpdz3HUwlywvKps/WI8vTuSvfdFfY
 Ivfjn9e9/ibOLgbWOmsNTThRfv1F8T6e8q8L/szeWlOM7djtf7DAcy04cpo/VVIKJwPCghA1U
 hdf+nAVSioCf9fq48tQSWG6ak4sqZekK3lNh5N8rHgVhcFsS4wVvuELN0lE7dvxXjkF+m1O0n
 c56a5m0svh+riJtLUytaxe+rqEhnUsxI3u2YqDhMVTG2ybBYu9aAdVTmZyhmVfp1MB+j2DkNw
 QZ1wHRx0a4Q0twAgsQt4jA6zwfj0XONMUEh3dhP8Sd+CuvP2PPqq3/18ZcjHfFFJhT5o8EVYR
 vXCtVFLmGMNF6b6o7wbIN842iP40DrmRQizjy6XFweJTQ/L1KypHPlzmme8PMQ4QFottRaTJ+
 092/UDxfFrSxv4ovXHNJMcIDagFopT1EpfvG5mrWYeTgLAR+n5YynL8MtkZgNQUv/Iz4FATCY
 W3qPEqrH8s73ncqJwrHtYgn0Im17pus484pfj4mOzKRs6LsP917vcw/mOpi5nokYvZeocj8VF
 cT5Po02kAmPFUIhA8vbjl2xMVzi/fbGP2RU8T+M16EKYbniHT8zoF1VgT1PaDiGYw9i5G4yWd
 wdratacGg2/hNICzbAU44+zkJsjevRtl8PAAOjJG11TIVcfzvjQiY/H4arDfhOYW0urREOS0y
 M6GBc5Q1s4tLoZh3n5JRS+c1DAFkB0YGCeChCSnz+2+bGyGKYTWE9hhBOUqvj7tixrLu+d229
 28IPjBQhwC7UE7ffrfKOcJAKaHWe30/5Npl1UkwWlK3LDmN6XUNkKiWbEl6RKyNL2+oxQZme1
 Qom1pFuaGEf7bR3rdNJc8+36KhQZ/BBzIt3Jg32IOR/SvW+cEwNm3Ay2JUrL+gHZe2g8ry5ZU
 WZflRotB6m3rfqW2CRtvhJMrmWAF0zF02cfEKb2HzPTOntdiY19NdyTglwPVAtEbFZCdzVuYE
 1h5jUzPIV7HCXqAwuxeDbFCohKPIx2Mz0lIWVr42DWkhh8mZxLLexAbNp3KIXR9mqQsBYVFBT
 o/16XP4gvtgvP3zKtA0sMlsgIY0MBNXsXi//o5z7VbACrfver+DCRBthw==
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
and __bug_table sections are 32- or 64-bit aligned because they hold 32-
and/or 64-bit values.

But for modules the module.lds.S linker script doesn't define a default
alignment yet, so the linker chooses the default byte alignment, which
then leads to unnecessary unaligned memory accesses at runtime.

Usually such unaligned accesses are unnoticed, because either the
hardware (as on x86 CPUs) or in-kernel exception handlers (e.g. on hppa
or sparc) emulate and fix them up at runtime.

On hppa the 32-bit unalignment exception handler was temporarily broken
due another bad commit, and as such wrong values were returned on
unaligned accesses to the altinstructions table. This then led to
undefined behaviour because wrong kernel addresses were patched and we
suddenly faced lots of unrelated bugs, as can be seen in this mail
thread:
https://lore.kernel.org/all/07d91863-dacc-a503-aa2b-05c3b92a1e39@bell.net/T/#mab602dfa32be5e229d5e192ab012af196d04d75d

This patch adds the missing natural alignment for kernel modules to
avoid unnecessary (hard- or software-based) fixups.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 scripts/module.lds.S | 2 ++
 1 file changed, 2 insertions(+)

--
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
