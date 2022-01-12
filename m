Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0625848C210
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 11:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352428AbiALKPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 05:15:24 -0500
Received: from mx1.tq-group.com ([93.104.207.81]:33579 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346644AbiALKPS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 05:15:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1641982517; x=1673518517;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=S28EQ0bz6EdA2cdSn1eDNre2DjKlCl/zzHLMreOcAZU=;
  b=mmWxZ4qkBUiReOGtDD6Eka56/VoG2YWOESt22hRF7GbmHK9V77U/kz8g
   Q4NjYanlEpKj++SlwrG3uS8CmqVefSuesehNReorNnt7Iw006xhBqoi7l
   nbc0yjQsCPaCt/hJ3UWpdR8JuWlfuniVlUy33Lt4BWaFGHnWMK0ahsR2j
   waPfysVsnAeTDcRc6/B9YveteVlI5OFbw5w5VPrcWVLKK6A3M46YZRNRo
   n4K43/xfyVynA/nmDOb0+9I07qUeo4tqrDjXvBAQtBAm6MgipuvC/GYfV
   hgzkuEzNDSMaGstlPeEeKHGMoIANxF1hGKgwcl2wOW+qPp85E7eZrWd3Z
   g==;
X-IronPort-AV: E=Sophos;i="5.88,282,1635199200"; 
   d="scan'208";a="21453023"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 12 Jan 2022 11:15:16 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 12 Jan 2022 11:15:16 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 12 Jan 2022 11:15:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1641982516; x=1673518516;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=S28EQ0bz6EdA2cdSn1eDNre2DjKlCl/zzHLMreOcAZU=;
  b=WQM+p6vjynfe6mmEHDzsij/XBDE1aCBntc1UqemG4C0t74Qp74XeKlrf
   g8a7XFwycicqaky9klz+XLkUnShtz3XMN8gV/JFFoin2PXteHtGRvvHT9
   ad6QHkMaaYJ2vqR2jAFG+d2grlAE9JviHbX+4ThHqoZ5HefibynNd/ndf
   Cg4MpikBHJ6wykgFpaRghn6ms5UGzY/h7vY6dABo3LG9Qp/ncr/HjUDJZ
   nmCtx3iA3t3O0ZdX4Q0KGr2MG5reJHAj1gzcqk1GUlBnpIf+B5COBza0Y
   oR1hUo0tHBGurkKmrr6ei1lLGqD/xhFXkhT/AzY0+MzPsUCH8QOXgcc12
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,282,1635199200"; 
   d="scan'208";a="21453022"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 12 Jan 2022 11:15:16 +0100
Received: from localhost.localdomain (SCHIFFERM-M2.tq-net.de [10.121.201.138])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id EA5FD280065;
        Wed, 12 Jan 2022 11:15:15 +0100 (CET)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH] scripts/dtc: dtx_diff: fix documentation for redirect workaround
Date:   Wed, 12 Jan 2022 11:14:41 +0100
Message-Id: <20220112101441.23088-1-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dtx_diff suggests to use <(...) syntax to pipe two inputs into it, but
this has never worked: The /proc/self/fds/... paths passed by the shell
will fail the `[ -f "${dtx}" ] && [ -r "${dtx}" ]` check in compile_to_dts,
but even with this check removed, the function cannot work: hexdump will
eat up the DTB magic, making the subsequent dtc call fail, as a pipe
cannot be rewound.

Change the example to use `diff -u` directly.

Fixes: 10eadc253ddf ("dtc: create tool to diff device trees")
Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 scripts/dtc/dtx_diff | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/dtc/dtx_diff b/scripts/dtc/dtx_diff
index d3422ee15e30..f97eb83420a4 100755
--- a/scripts/dtc/dtx_diff
+++ b/scripts/dtc/dtx_diff
@@ -62,7 +62,7 @@ Otherwise DTx is treated as a dts source file (aka .dts).
    may not work since \${ARCH} is part of the include path.  Two possible
    workarounds:
 
-      `basename $0` \\
+      diff -u \\
           <(ARCH=arch_of_dtx_1 `basename $0` DTx_1) \\
           <(ARCH=arch_of_dtx_2 `basename $0` DTx_2)
 
-- 
2.25.1

