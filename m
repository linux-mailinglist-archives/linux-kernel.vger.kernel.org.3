Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE332471307
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 09:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbhLKI5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 03:57:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbhLKI5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 03:57:14 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4810C061714;
        Sat, 11 Dec 2021 00:57:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6A8A5CE2F4D;
        Sat, 11 Dec 2021 08:57:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61FF3C341C8;
        Sat, 11 Dec 2021 08:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639213029;
        bh=dLzcRmAEkVb+B0B4cQJFADSqZiQ2YMJeyf3dP0Q8itc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QHELYpSKCZkJkhhbi89iIWSgYBeOjGvXgoR+MlZjJUm7NO9oet69ZK3fKBRRvq6L0
         8jH3EuF629PbMNszigo0oHSB1K6KccQwBDDUVYZUWpJB7zmThgC48IcgsHOmqHdErO
         xOe4DuuU1h3dQvI3VGL9iRF8uRumzYciHzC4kPyJV9ZiBNt304MimYFKt7noroHBtW
         d+9d6W1WBXE2fH9vArTdOZ7ZyBr0BRG9Dmr4Jj/ZA3sFwTIN1HV/8u0cv9gnEwvZ/P
         G4ueoFxQeSrBFTpy/XALfL+BsHa/BKPd0U0/5mexe3jguW6/eaU/4YUMMqeZ//GZcS
         hgyXxNKmX78nA==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mvyBj-000MlL-Ii; Sat, 11 Dec 2021 09:57:03 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] docs: Makefile: use the right path for DOCS_CSS
Date:   Sat, 11 Dec 2021 09:56:59 +0100
Message-Id: <cea4ff1237ae9a99bc6509ab1bf9c70acd97e265.1639212812.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1639212812.git.mchehab+huawei@kernel.org>
References: <cover.1639212812.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When make is used with O=<dir>, the location of the css file
won't be get right:

	$ make DOCS_THEME=nature DOCS_CSS=my_css.css    O=DOCS SPHINXDIRS=x86 -j9 htmldocs
	make[1]: Entering directory '/work/lnx/next/next-2021-1210/DOCS'
	...
	cp: cannot stat 'my_css.css': No such file or directory

Fix it in a way that both relative and absolute paths will be
handled.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

See [PATCH 0/2] at: https://lore.kernel.org/all/cover.1639212812.git.mchehab+huawei@kernel.org/

 Documentation/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 9f0f53db2f10..c9543b63dc6a 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -88,7 +88,7 @@ quiet_cmd_sphinx = SPHINX  $@ --> file://$(abspath $(BUILDDIR)/$3/$4)
 	$(abspath $(srctree)/$(src)/$5) \
 	$(abspath $(BUILDDIR)/$3/$4) && \
 	if [ "x$(DOCS_CSS)" != "x" ]; then \
-		cp $(DOCS_CSS) $(BUILDDIR)/$3/_static/; \
+		cp $(if $(patsubst /%,,$(DOCS_CSS)),$(abspath $(srctree)/$(DOCS_CSS)),$(DOCS_CSS)) $(BUILDDIR)/$3/_static/; \
 	fi
 
 htmldocs:
-- 
2.33.1

