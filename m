Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D7457443A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 07:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235691AbiGNFIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 01:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbiGNFHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 01:07:19 -0400
Received: from conuserg-07.nifty.com (conuserg-07.nifty.com [210.131.2.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9CEF1A390;
        Wed, 13 Jul 2022 22:03:58 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 26E52j5D024585;
        Thu, 14 Jul 2022 14:02:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 26E52j5D024585
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1657774966;
        bh=Jr7tDxJGBjHD4R2T6y2BGZyaLDORK8ue4Iw5NULwlPw=;
        h=From:To:Cc:Subject:Date:From;
        b=KD4/RiZBeLgrfUJnF4tmVDZ7vhdwFi4kzqb838JEmg77VoHeijXW3pOK+9+U8r3JC
         05elbRclIpZuBE/OKG6M3hC12hHI2b2Uhn7iqWQF09u57299NhdR8Su8hcuFILDWO9
         lZ/daEKJJPssyU+W1ens3ERZ16LwwENlDNMw0piUc/R5V1rCo+rbbVavwSAbxDYLcB
         iryf7Qejyzc6K/3K2EZpu6F/mwGDIP8Nac1bJVA1j90PSUBUCtH6Cxe7IkHWkuxw6r
         dvEKNmMs9/grc5RQcD85BU1PNDSepbmlvzWtC5M/wq1RzBJgXJDN5Z4O1DDDA2bW1M
         p/MdB1GpqUF5w==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Jason Self <jason@bluehome.net>, Guo Ren <guoren@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-csky@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] kbuild: rpm-pkg: fix build error when _arch is undefined
Date:   Thu, 14 Jul 2022 14:02:40 +0900
Message-Id: <20220714050243.16411-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cross-building (bin)rpm-pkg fails on several architectures.

For example, 'make ARCH=arm binrpm-pkg' fails like follows:

  sh ./scripts/package/mkspec prebuilt > ./binkernel.spec
  rpmbuild  --define "_builddir ." --target \
          arm -bb ./binkernel.spec
  Building target platforms: arm
  Building for target arm
  warning: line 19: It's not recommended to have unversioned Obsoletes: Obsoletes: kernel-headers
  Executing(%install): /bin/sh -e /var/tmp/rpm-tmp.0S8t2F
  + umask 022
  + cd .
  + mkdir -p /home/masahiro/rpmbuild/BUILDROOT/kernel-5.19.0_rc6-19.%{_arch}/boot
  + make -f ./Makefile image_name
  + cp arch/arm/boot/zImage /home/masahiro/rpmbuild/BUILDROOT/kernel-5.19.0_rc6-19.%{_arch}/boot/vmlinuz-5.19.0-rc6
  + make -f ./Makefile INSTALL_MOD_PATH=/home/masahiro/rpmbuild/BUILDROOT/kernel-5.19.0_rc6-19.%{_arch} modules_install
  make[3]: *** No rule to make target '/home/masahiro/rpmbuild/BUILDROOT/kernel-5.19.0_rc6-19.arch/arm/crypto/aes-arm-bs.ko{_arch}/lib/modules/5.19.0-rc6/kernel/%', needed by '__modinst'.  Stop.
  make[2]: *** [Makefile:1768: modules_install] Error 2
  error: Bad exit status from /var/tmp/rpm-tmp.0S8t2F (%install)

By default, 'buildroot' contains %{_arch} (see /usr/lib/rpm/macros).

_arch is generally defined in /usr/lib/rpm/platforms/*/macros, where
the platform sub-directory is specified by --target= option for cross
builds.

If the given arch does not exist, %{_arch} is not expanded.
In the example above, --target=arm is passed to rpmbuild, but
/usr/lib/rpm/platforms/arm-linux/ does not exist.

The '%' character in the path confuses GNU make and rpmbuild.

The same occurs for such architectures as csky, microblaze, nios2, etc.

Define _arch if it has not been defined.

Reported-by: Jason Self <jason@bluehome.net>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/package/mkspec | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/package/mkspec b/scripts/package/mkspec
index 7c477ca7dc98..8fa7c5b8a1a1 100755
--- a/scripts/package/mkspec
+++ b/scripts/package/mkspec
@@ -49,6 +49,9 @@ sed -e '/^DEL/d' -e 's/^\t*//' <<EOF
 	URL: https://www.kernel.org
 $S	Source: kernel-$__KERNELRELEASE.tar.gz
 	Provides: $PROVIDES
+	# $UTS_MACHINE as a fallback of _arch in case
+	# /usr/lib/rpm/platform/*/macros was not included.
+	%define _arch %{?_arch:$UTS_MACHINE}
 	%define __spec_install_post /usr/lib/rpm/brp-compress || :
 	%define debug_package %{nil}
 
-- 
2.34.1

