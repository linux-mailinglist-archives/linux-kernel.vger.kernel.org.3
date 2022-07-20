Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8678157BCD0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 19:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiGTRiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 13:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241378AbiGTRh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 13:37:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E3365D45;
        Wed, 20 Jul 2022 10:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=+dUyhHjNHJl5BjEQXYv49khHANmDjFISbEfSv6FSuX8=; b=YqDXNIPJzymgte1+SiIixcuN5U
        hAj4GrJuQv2CcXHveuoe/TWoKpfY13RpA6kpsKVhKM+S+opF9VsVDLWF12knB5s2LXeODuaFWky7M
        OFSvcSPw15Xvlx/4rpPf0OAF9wOcorICF+nR2nLNHXehkFtDS2iK8LaaVeZtT4erlp8N2nUmabq+L
        7TZKupSHbyqKRKhEjjyDM34VVFFiL1HTle0E8Q2g3JEnWpNkH2ur4P5+asMJV22D0Ity9ggJDP6RJ
        w5FS5LIfp+hIkflyDuO1EM0ghM/XsMuhSFKSJGwBvBe+1rXhyEMs8+wSuy5iS809J/MHZ+FbCrR/Q
        lw5wN9vA==;
Received: from [2601:1c0:6280:3f0::a6b3] (helo=casper.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oEDdy-00Eebx-Km; Wed, 20 Jul 2022 17:37:55 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Subject: [PATCH] kconfig: Qt5: tell the user which packages are required
Date:   Wed, 20 Jul 2022 10:37:49 -0700
Message-Id: <20220720173749.7487-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Along with saying "Please install Qt5 ...", tell exactly which
parts of Qt5 are needed. This is useful when parts of Qt5 are
installed but some of the required pieces are missing, and it
eliminates the need for the user to find the shell script and
the line in it that provide that information.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org
---
 scripts/kconfig/qconf-cfg.sh |    1 +
 1 file changed, 1 insertion(+)

--- a/scripts/kconfig/qconf-cfg.sh
+++ b/scripts/kconfig/qconf-cfg.sh
@@ -20,5 +20,6 @@ fi
 echo >&2 "*"
 echo >&2 "* Could not find Qt5 via ${HOSTPKG_CONFIG}."
 echo >&2 "* Please install Qt5 and make sure it's in PKG_CONFIG_PATH"
+echo >&2 "* You need $PKG"
 echo >&2 "*"
 exit 1
