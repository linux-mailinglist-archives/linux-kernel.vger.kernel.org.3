Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2666F4BB5BE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 10:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233655AbiBRJj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 04:39:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232871AbiBRJjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 04:39:24 -0500
Received: from imap2.colo.codethink.co.uk (imap2.colo.codethink.co.uk [78.40.148.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8AC236685
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 01:39:07 -0800 (PST)
Received: from [167.98.27.226] (helo=rainbowdash)
        by imap2.colo.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1nKzjA-0005DK-49; Fri, 18 Feb 2022 09:39:00 +0000
Received: from ben by rainbowdash with local (Exim 4.95)
        (envelope-from <ben@rainbowdash>)
        id 1nKzj9-005E3m-R8;
        Fri, 18 Feb 2022 09:38:59 +0000
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     linux-kernel@lists.codethink.co.uk,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Neill Whillans <neill.whillans@codethink.co.uk>
Subject: [PATCH] rfkill: define rfill_soft_blocked() if \!RFKILL
Date:   Fri, 18 Feb 2022 09:38:58 +0000
Message-Id: <20220218093858.1245677-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_RFKILL is not set, the Intel WiFi driver will not build
the iw_mvm driver part due to the missing rfill_soft_blocked()
call. Adding a inline declaration of rfill_soft_blocked() if
CONFIG_RFKILL=n fixes the following error:

drivers/net/wireless/intel/iwlwifi/mvm/mvm.h: In function 'iwl_mvm_mei_set_sw_rfkill_state':
drivers/net/wireless/intel/iwlwifi/mvm/mvm.h:2215:38: error: implicit declaration of function 'rfkill_soft_blocked'; did you mean 'rfkill_blocked'? [-Werror=implicit-function-declaration]
 2215 |                 mvm->hw_registered ? rfkill_soft_blocked(mvm->hw->wiphy->rfkill) : false;
      |                                      ^~~~~~~~~~~~~~~~~~~
      |                                      rfkill_blocked

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
Reported-by: Neill Whillans <neill.whillans@codethink.co.uk>
Fixes: 7cf800f46e07e6b75a43036c4389d6ca717fd017 ("iwlwifi: mvm: don't feed the hardware RFKILL into iwlmei
")
---
 include/linux/rfkill.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/rfkill.h b/include/linux/rfkill.h
index c35f3962dc4f..373003ace639 100644
--- a/include/linux/rfkill.h
+++ b/include/linux/rfkill.h
@@ -308,6 +308,11 @@ static inline bool rfkill_blocked(struct rfkill *rfkill)
 	return false;
 }
 
+static inline bool rfkill_soft_blocked(struct rfkill *rfkill)
+{
+	return false;
+}
+
 static inline enum rfkill_type rfkill_find_type(const char *name)
 {
 	return RFKILL_TYPE_ALL;
-- 
2.34.1

