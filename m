Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B477655757D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 10:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbiFWIbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 04:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbiFWIbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 04:31:11 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE62B48E42;
        Thu, 23 Jun 2022 01:31:10 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 6F41B1FD47;
        Thu, 23 Jun 2022 08:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655973069; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=gQ4RQ7LTu4RYrV3jjSWiI0pgHZgdIzD8SzSGAVAuCHQ=;
        b=KGnGiU7y5xaCruxzrYwo0gPHXE1j14oeYaVdH9v1q0xpZHfD0wwkKsmZUMTe8Xw5i5o42E
        UqBnlE9vR0ErrZ0JrH4JiaXpOMQsdlxz+IvN58xiaCuE650whNEjeGj8n0Mf9uZaaq6Ajd
        oMRndjaV5osVFpqG+QTKG9r61bjx+kg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655973069;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=gQ4RQ7LTu4RYrV3jjSWiI0pgHZgdIzD8SzSGAVAuCHQ=;
        b=36PBULC7cnA0c6jm6gafHRKOqBjDUY80zQxUZCHbQpq6ybf07piz9UyOvCPuKYNyQautyt
        W3qk2/IA4CiHUwCg==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 47E132C142;
        Thu, 23 Jun 2022 08:31:03 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     masahiroy@kernel.org
Cc:     linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH] kbuild, link-vmlinux: Don't delete output files with make -i
Date:   Thu, 23 Jun 2022 10:31:05 +0200
Message-Id: <20220623083105.26354-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <andi@firstfloor.org>

make -i is useful to see output files which normally get deleted on an
error.  Make this work with link-vmlinux.sh too. Don't delete the output
files on error when make -i is used.

Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: linux-kbuild@vger.kernel.org
Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 scripts/link-vmlinux.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index eecc1863e556..d21759aad4f3 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -193,6 +193,11 @@ sorttable()
 # Delete output files in case of error
 cleanup()
 {
+	# don't delete for make -i
+	case "$MFLAGS" in
+	*-i*) return ;;
+	esac
+
 	rm -f .btf.*
 	rm -f System.map
 	rm -f vmlinux
-- 
2.36.1

