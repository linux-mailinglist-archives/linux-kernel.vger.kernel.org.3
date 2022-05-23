Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 249855311F4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237630AbiEWPHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 11:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237603AbiEWPHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 11:07:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB5F35C351
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 08:06:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE80161259
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 15:06:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88391C385A9;
        Mon, 23 May 2022 15:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653318417;
        bh=qiEZQ8DWEMoinQqoOyjtgxX3eAxznhmWe20hPy5hWDo=;
        h=From:To:Cc:Subject:Date:From;
        b=WX8r3XCacUsEACEbsEXvabZzEiI6ikeNhJdubv5QbwatsnStxS7Bwa0mKXtEDMP6l
         sqS2ZDMZIZey4KB9n2ugYkJg8JoKBOgA0uqb2OnI7ozeZeKXCd7nVfaktwaviaSXet
         zniWrTycVuR5sB54ZPi5QBiBWwqaRCKdFXXYekAggiRkTCXv3kAhzXRcPnMsQHCld7
         4cjiL2Xd+m75YH4bo7l27rCDTJ6M37+giIs7INi6aLEshmUrTEemlal5jiyI3ofWNf
         s7GLxGivwij3RgDDGh+PO2PUBxP/rqbjjtSnwXfLC804ckIJxt5tlNVdc2WOUu/HTE
         I/uLpu0Rwii4g==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        patches@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        kernel test robot <lkp@intel.com>, Tom Rix <trix@redhat.com>,
        Ricky WU <ricky_wu@realtek.com>
Subject: [PATCH] misc: rtsx: Fix clang -Wsometimes-uninitialized in rts5261_init_from_hw()
Date:   Mon, 23 May 2022 08:05:22 -0700
Message-Id: <20220523150521.2947108-1-nathan@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

  drivers/misc/cardreader/rts5261.c:406:13: error: variable 'setting_reg2' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
          } else if (efuse_valid == 0) {
                     ^~~~~~~~~~~~~~~~
  drivers/misc/cardreader/rts5261.c:412:30: note: uninitialized use occurs here
          pci_read_config_dword(pdev, setting_reg2, &lval2);
                                      ^~~~~~~~~~~~

efuse_valid == 1 is not a valid value so just return early from the
function to avoid using setting_reg2 uninitialized.

Fixes: b1c5f3085149 ("misc: rtsx: add rts5261 efuse function")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Tom Rix <trix@redhat.com>
Suggested-by: Ricky WU <ricky_wu@realtek.com>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---

This is basically a v2 of https://lore.kernel.org/20220516130047.3887590-1-trix@redhat.com/.

 drivers/misc/cardreader/rts5261.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/misc/cardreader/rts5261.c b/drivers/misc/cardreader/rts5261.c
index 749cc5a46d13..b1e76030cafd 100644
--- a/drivers/misc/cardreader/rts5261.c
+++ b/drivers/misc/cardreader/rts5261.c
@@ -407,6 +407,8 @@ static void rts5261_init_from_hw(struct rtsx_pcr *pcr)
 		// default
 		setting_reg1 = PCR_SETTING_REG1;
 		setting_reg2 = PCR_SETTING_REG2;
+	} else {
+		return;
 	}
 
 	pci_read_config_dword(pdev, setting_reg2, &lval2);

base-commit: 90de6805267f8c79cd2b1a36805071e257c39b5c
-- 
2.36.1

