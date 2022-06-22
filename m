Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7EE555145
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 18:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359433AbiFVQYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 12:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376574AbiFVQYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 12:24:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CB0F5A4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 09:24:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE44061A53
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 16:24:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0E04C34114;
        Wed, 22 Jun 2022 16:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655915058;
        bh=wBXOy6rLkI4srMgL1RTEKHuG4ToxdOlMrxGQy9/s+EI=;
        h=Date:From:To:Cc:Subject:From;
        b=JFPHEJKGa1nD/NWHoeg7lzBhttJc+2CpEDswF6eMUBNCz0afYle4AAfdj5BKZ1z6J
         GQk7equq9Nu88zOPISpFp4200lDTUlAuMXiMfvKWWjHMSYtcSxX6ZCfwAVxStQs0T+
         h+RZO0VOr0+zlGGuJ6Uu+GNXCV7Ap2Ne08W3wpDYl7msP72izxs5jIoz4s2BSK95P5
         88IZvhTtK5hFHMRiQHUI11dvJSQpzJmbjiCPH9waQLw/PnVS4USHrorVk58lTCWwCp
         1ifCz2of++P/wOCP/nxujyT5c+dN0LaWezmHob4uDPo5Uvv8wcI+wxbeasvcRtHwF2
         xbtKa4VdyMrGQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3618F4096F; Wed, 22 Jun 2022 13:24:15 -0300 (-03)
Date:   Wed, 22 Jun 2022 13:24:15 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Ian Rogers <irogers@google.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1 FYI] perf trace beauty: Fix generation of errno id->str
 table on ALT Linux
Message-ID: <YrNCLzNGsvizMhdW@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fyi, I'm carrying this on my perf tools tree to keep building on:

[perfbuilder@five sisyphus]$ podman pull alt:sisyphus
Trying to pull docker.io/library/alt:sisyphus...
Getting image source signatures
Copying blob 2b39ef1520dd skipped: already exists
Copying blob 12717fd4baa0 skipped: already exists
Copying config 6d48f46445 done
Writing manifest to image destination
Storing signatures
6d48f4644518cd96ffe1de6cd0333d2abc8312c0e4449e03b58b1d480f0f5905
[perfbuilder@five sisyphus]$ dsh .
sh-4.4# bash
[root@b8318c77142b /]# cat /etc/os-release
NAME="starter kit"
VERSION="p10 (Hypericum)"
ID=altlinux
VERSION_ID=p10
PRETTY_NAME="ALT Starterkit (Hypericum)"
ANSI_COLOR="1;33"
CPE_NAME="cpe:/o:alt:starterkit:p10"
HOME_URL="http://en.altlinux.org/starterkits"
BUG_REPORT_URL="https://bugs.altlinux.org/"
[root@b8318c77142b /]# rpm -qi bash
Name        : bash
Version     : 4.4.23
Release     : alt1
DistTag     : sisyphus+221902.500.4.1
Architecture: noarch
Install Date: Fri Jun  3 23:03:32 2022
Group       : Shells
Size        : 0
License     : None
Signature   : DSA/SHA1, Tue Feb 19 14:40:44 2019, Key ID 95c584d5ae4ae412
Source RPM  : bash-defaults-4.4.23-alt1.src.rpm
Build Date  : Tue Feb 19 14:40:42 2019
Build Host  : ldv-sisyphus.hasher.altlinux.org
Relocations : (not relocatable)
Packager    : Dmitry V. Levin <ldv@altlinux.org>
Vendor      : ALT Linux Team
Summary     : The GNU Bourne Again SHell (/bin/bash)
Description :
This package provides default setup for the GNU Bourne Again SHell (/bin/bash).
[root@b8318c77142b /]#

Perf uses that script to generate an id->str errno table for all arches,
implemented in:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0337cf74ccf2a43437bff2e23b278e4f2dc4c6e2

But it is failing on:

  10    62.99 alt:p8                        : Ok   x86_64-alt-linux-gcc (GCC) 5.3.1 20151207 (ALT p8 5.3.1-alt3.M80P.1) , clang version 3.8.0 (tags/RELEASE_380/final)
  11    91.50 alt:p9                        : Ok   x86_64-alt-linux-gcc (GCC) 8.4.1 20200305 (ALT p9 8.4.1-alt0.p9.1) , clang version 10.0.0
  12    89.80 alt:p10                       : Ok   x86_64-alt-linux-gcc (GCC) 10.3.1 20210703 (ALT Sisyphus 10.3.1-alt2) , clang version 11.0.1
  13     8.99 alt:sisyphus                  : FAIL gcc version 12.1.1 20220518 (ALT Sisyphus 12.1.1-alt1) (GCC)
        |         ^~~~
    442 |         case 47: return "EL3RST";
        |         ^~~~
    443 |         case 48: return "ELNRNG";

The generated file lacks the function start/end due to some strange
glitch:

http://vger.kernel.org/~acme/perf/generated-altlinux-sisyphus-arch_errno_name_array.c

So I'm adding this workaround, can you please check why this is
happening?

- Arnaldo

---

For some reason using:

         cat <<EoFuncBegin
  static const char *errno_to_name__$arch(int err)
  {
         switch (err) {
  EoFuncBegin

In tools/perf/trace/beauty/arch_errno_names.sh isn't working on ALT
Linux sisyphus (development version), which could be some distro
specific glitch, so just get this done in an alternative way that works
everywhere while giving notice to the people working on that distro to
try and figure our what really took place.

Cc: Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>
Cc: Dmitry V. Levin <ldv@altlinux.org>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
Cc: Ian Rogers <irogers@google.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/arch_errno_names.sh | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/tools/perf/trace/beauty/arch_errno_names.sh b/tools/perf/trace/beauty/arch_errno_names.sh
index 2c5f72fa81087956..37c53bac5f56ef7b 100755
--- a/tools/perf/trace/beauty/arch_errno_names.sh
+++ b/tools/perf/trace/beauty/arch_errno_names.sh
@@ -33,23 +33,13 @@ create_errno_lookup_func()
 	local arch=$(arch_string "$1")
 	local nr name
 
-	cat <<EoFuncBegin
-static const char *errno_to_name__$arch(int err)
-{
-	switch (err) {
-EoFuncBegin
+	printf "static const char *errno_to_name__%s(int err)\n{\n\tswitch (err) {\n" $arch
 
 	while read name nr; do
 		printf '\tcase %d: return "%s";\n' $nr $name
 	done
 
-	cat <<EoFuncEnd
-	default:
-		return "(unknown)";
-	}
-}
-
-EoFuncEnd
+	printf '\tdefault: return "(unknown)";\n\t}\n}\n'
 }
 
 process_arch()
-- 
2.36.1

