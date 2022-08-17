Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD7C59740B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 18:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240931AbiHQQUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 12:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240348AbiHQQUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 12:20:08 -0400
Received: from smtpout30.security-mail.net (smtpout30.security-mail.net [85.31.212.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB94393511
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 09:20:05 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by fx301.security-mail.net (Postfix) with ESMTP id 83A9B24BD056
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 18:15:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalray.eu;
        s=sec-sig-email; t=1660752914;
        bh=I3NdarSARdEaYH+3yOIA8fd/l3gXfM/bO3avvR+IPSM=;
        h=From:To:Cc:Subject:Date;
        b=gW1YKd0G70DiRNMLQ86YtHEdS6N0/Mg2vOMwhoEU2wTG6jZqwwhdpzglrNkJqCjvN
         EAKBuZ6mA+/5kAduzedyxyfZfmAt2y913X5XQsOmIb9MBl2TyxtMQmJwWXfxYSeE34
         A1MLEhebwGAmfteBTGNLdVun2srq50aUmmYqVhWQ=
Received: from fx301 (localhost [127.0.0.1]) by fx301.security-mail.net
 (Postfix) with ESMTP id 344EE24BD028; Wed, 17 Aug 2022 18:15:14 +0200 (CEST)
Received: from zimbra2.kalray.eu (unknown [217.181.231.53]) by
 fx301.security-mail.net (Postfix) with ESMTPS id A54C124BD053; Wed, 17 Aug
 2022 18:15:13 +0200 (CEST)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1]) by
 zimbra2.kalray.eu (Postfix) with ESMTPS id 85B4727E031E; Wed, 17 Aug 2022
 18:15:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1]) by zimbra2.kalray.eu
 (Postfix) with ESMTP id 6DA1B27E0341; Wed, 17 Aug 2022 18:15:13 +0200 (CEST)
Received: from zimbra2.kalray.eu ([127.0.0.1]) by localhost
 (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026) with ESMTP id
 47XJFJD3NbWo; Wed, 17 Aug 2022 18:15:13 +0200 (CEST)
Received: from junon.lin.mbt.kalray.eu (unknown [192.168.37.161]) by
 zimbra2.kalray.eu (Postfix) with ESMTPSA id 5108B27E031E; Wed, 17 Aug 2022
 18:15:13 +0200 (CEST)
X-Virus-Scanned: E-securemail, by Secumail
Secumail-id: <1093d.62fd1411.a4114.0>
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 6DA1B27E0341
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
 s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1660752913;
 bh=/CivWy6aMuZQau/3YW9QKd8vbxzFaENH04ZJlJSz8Mo=;
 h=From:To:Date:Message-Id:MIME-Version;
 b=JukimiJXuskndE4ug2i0zS5kqQFRgPJJb1fC5S8j3Q1AXEKmwQwqlVXMuUJApj+Lh
 hZ39oMWytAnN944peSMF6kiXzw3RgWNe/lG/PSlvYNoVu94i//U1eGLWTqkQhnEujz
 pdCXc/kJkl/sBMdK0F2MMaTS7rrTv6+TjXcu+k3k=
From:   Yann Sionneau <ysionneau@kalray.eu>
To:     linux-kernel@vger.kernel.org
Cc:     Nicolas Schier <nicolas@fjasle.eu>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Jules Maselbas <jmaselbas@kalray.eu>,
        Julian Vetter <jvetter@kalray.eu>,
        Yann Sionneau <ysionneau@kalray.eu>
Subject: [RFC PATCH 0/1] Fix __kcrctab+* sections alignment
Date:   Wed, 17 Aug 2022 18:14:37 +0200
Message-ID: <20220817161438.32039-1-ysionneau@kalray.eu>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 
At Kalray we have our (non-upstreamed-yet) kvx Linux port (https://github.com/kalray/linux_coolidge).

When I did the rebase on 5.19 I noticed the kernel module would not load anymore and would say

[   10.071771] Found checksum 0 vs module B4E7D8E
[   10.071824] libphy: disagrees about version of symbol module_layout

The CRC of module_layout in libphy.ko seems fine, but surprisingly, the CRC of module_layout in vmlinux is 0.

I dig a little bit to try and understand why.

.vmlinux.export.c contains:
SYMBOL_CRC(module_layout, 0x0b4e7d8e, "");

Dumping the section '___kcrctab+module_layout' of .vmlinux.export.o I get:
Hex dump of section '___kcrctab+module_layout':
  0x00000000 8e7d4e0b                            .}N.

Dumping __kcrctab section of vmlinux:
Hex dump of section '__kcrctab':
  0xffffff80055b7090 572828d0 00000000 b96e414c 00000000 W((......nAL....
  0xffffff80055b70a0 b0179638 00000000 e3eb8db7 00000000 ...8............
  0xffffff80055b70b0 7a10c1c7 00000000 3d04478a 00000000 z.......=.G.....
  0xffffff80055b70c0 a5d7be15 00000000 d188008b 00000000 ................
  0xffffff80055b70d0 6214323b 00000000 bba48601 00000000 b.2;............
  0xffffff80055b70e0 6bfbba55 00000000 251fa090 00000000 k..U....%.......
  0xffffff80055b70f0 2861bde8 00000000 81c8241d 00000000 (a........$.....
etc

You can see that in fact there is some kind of 4-bytes padding in-between each CRC32.

And indeed by looking at ___kcrctab+module_layout section alignment in .vmlinux.export.o I can see:
  Section Headers:
  [Nr] Name              Type            Address          Off    Size   ES Flg Lk Inf Al
  [...snip snip...]
  [6189] ___kcrctab+module_layout PROGBITS        0000000000000000 00c188 000004 00  WA  0   0  8

So somehow, the section really contains 4 bytes of the CRC32 but even though the section contains a u32, the toolchain creates an 8-bytes aligned section.
This ends up creating 4-bytes padding with 0s once the linker collects all those ___kcrctab+* into __kcrctab for vmlinux ELF.

Do you think this is an issue in Linux kernel generic code? (See attached patch that makes our module probe again)
Or is this an issue with our toolchain?

On 5.16.20 our modules were loading fine and the __kcrctab did not contain any 4-bytes 00000000 gaps.
I think it is related to this change: https://lore.kernel.org/linux-kbuild/20220528224745.GA2501857@roeck-us.net/T/
In the change, we can see that the previous version was using assembly to create the sections and there was the presence of a ".balign KCRC_ALIGN" which was defined to whatever is the arch-specific way to encode a "4 bytes" alignement (be it 2 for "2^2" for m68k or directly 4 for others) for the assembler.

How to reproduce:
1/ generate the toolchain
$ git clone https://github.com/kalray/build-scripts
$ cd build-scripts
$ source last.refs
$ ./build-kvx-xgcc.sh output

2/ fetch and build our v5.19 kernel
$ git clone -b kalray-linux-v5.19 https://github.com/kalray/linux_coolidge
$ cd linux_coolidge
$ make ARCH=kvx O=build_kvx CROSS_COMPILE=kvx-elf- default_defconfig
$ make ARCH=kvx O=build_kvx CROSS_COMPILE=kvx-elf- -j$(($(nproc) + 1))

You won't have a rootfs but you will be able to observe the content of __kcrctab section of vmlinux
PS: the kalray-linux-v5.19 branch already contains the attached-patch to add __aligned(4) requirement.
PPS: Please CC me, I am not subscribed to the mailing list

Yann Sionneau (1):
  Fix __kcrctab+* sections alignment

 include/linux/export-internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.37.2





