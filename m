Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7031E465401
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 18:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351920AbhLARgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 12:36:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351889AbhLARgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 12:36:04 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA13FC061758
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 09:32:42 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id nh10-20020a17090b364a00b001a69adad5ebso2243762pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 09:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VDFng/HdHr1z5en3DZh+RIhvqJzKbtsFFlHQpWJVHps=;
        b=PFbBnO4QcqiOnDyKLMv8qME2XvouVSAqMxxG3Be+nyokOph72Oo9J3ZajgDmRuExPz
         Dn5RdJoX0jAUjmfLBvltEkFSxz07kOnztJ3V7VA8B6EGAO2EXHm+I8Cwo40CYBeoYBk5
         rpTQs+r8ZUQFp/Rn3RPrvb6Tv4lp1KQ5bbEXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VDFng/HdHr1z5en3DZh+RIhvqJzKbtsFFlHQpWJVHps=;
        b=wPndTP4sJFmnFfb+O8hGSWriyroRhoBC8MmykR3CRwwtheMBWMqUrjifIAcmOWW8JN
         JBi0OYk5wjYqQtZTS+zAOgbdbVXkCzNMIqKu2vFMBhLWZP1f5SKhpdmlhsHs8k/EBGW0
         /cJLZZGthgp5YIbX18VOp72rjCqMsRtXbFHKnzxzIhZqhWZiND+BWZcCxkRsUI6NPb3v
         a3CrUK+kyejRP2ZRmgTSXkBBZnUoG23X4dXE5clfJHeil7Eb8dTF3YPnX2f2mlQYM2jN
         hIMYtgZX9pGflwXxqoWUdU7TMqqumhZ2fEusBHttZBLiK+bJYO28GYGDMAgLmBv7U9Hy
         NJFQ==
X-Gm-Message-State: AOAM532rskhW6Tz1uBUqBUyel2ESE2H3MMdk69n9xfLKMd5LF+6jOYRC
        d1x+cBf0yzjPpayDhlrCyVYmDA==
X-Google-Smtp-Source: ABdhPJxbCZOLVkbSi8hSb8aaT9HL/poHl09z8+W5KXqp0xjeO6WgjDUDlHuOBseaXUocTBzQ/OOf2g==
X-Received: by 2002:a17:902:8645:b0:142:8c0d:3f4a with SMTP id y5-20020a170902864500b001428c0d3f4amr9084371plt.3.1638379962062;
        Wed, 01 Dec 2021 09:32:42 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o9sm293481pgu.12.2021.12.01.09.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 09:32:41 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Kees Cook <keescook@chromium.org>,
        kernel test robot <lkp@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Wan Jiabing <wanjiabing@vivo.com>,
        "John W. Linville" <linville@tuxdriver.com>,
        Luis Carlos Cobo <luisca@cozybit.com>,
        linux-kernel@vger.kernel.org, libertas-dev@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH 1/2] libertas: Add missing __packed annotation with struct_group()
Date:   Wed,  1 Dec 2021 09:32:33 -0800
Message-Id: <20211201173234.578124-2-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211201173234.578124-1-keescook@chromium.org>
References: <20211201173234.578124-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1155; h=from:subject; bh=UHcWUjjchMfnBh6ACbi53yKeEOrVQYslm/sSokOlE+M=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhp7Gx/RgHNdsPLmzjDYuEiI9vMdoO8j78eyHwZ2rs IlEbUlSJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYaexsQAKCRCJcvTf3G3AJrphD/ 95/0le+jMZxsKtI9YiFhTKDT13uBt5ykYHVuufhXiYOgLEZGOEs/DggHAW/krcqe6o4Rj1DvtOAQ/z KqL1FFThrORl6RPJSvwKhvp8iYUClSzGzR7A05Him9mWzuNAnJiMUb0SOz21wkJfjcGunHUpGpsGLo kh0JZ32GbPNdEUQd5+Pe3jqNjEGhtUMslNSTMoeBbd4gOuX40342pCZPrl/J8Ks7xieEJ0NhiFzOWB qbfH1h4qHqLI0/d48KzJq9oWzZkC+crx0/77bPI0GCTL7/EUZIJ8jwo7pdQMS9zp+iTVeb+hyfQ/p1 4q8u7vZ1fOm4t27MGFULoSb0k/+zOl67P8+Z0IF0GCTOPqdHUGFUtu7MqxDuXBqoNh1rEvc1tNB94Z V+z96IUZmnbrAmwMSKOPebFjGA/tjeOTbrj7X2omLrl72MRCucteYt87ikxvwI2XvMsO1gDjXylk1F 4hyXvgE+5op4uov0SzQPxYMKHMx1/HbaF0kkSrMrM2jDKGhSruZDwe1Te6vA1/8hgzJRcSeTC4vmS6 oWcglWNo2PiXWm0fjQxOr4XDSAtfQ5i8Iz1eK6jnnWg4us7bSmZ2p6y9C+JILBSQRW4KMvp6CLvibf x3cgwIDZMABSV/mhU69wM2hohHYZoBoCV6AOKw+aa2a1vAZZEoWYSUP0IqYw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Build testing of the newly added struct_group() usage missed smaller
architecture width tests for changes to pahole output. Add the missed
__packed annotation with struct_group() usage in a __packed struct.

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/linux-mm/202111302102.apaePz2J-lkp@intel.com
Fixes: 5fd32ae0433a ("libertas: Use struct_group() for memcpy() region")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/wireless/marvell/libertas/host.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/libertas/host.h b/drivers/net/wireless/marvell/libertas/host.h
index af96bdba3b2b..ceff4b92e7a1 100644
--- a/drivers/net/wireless/marvell/libertas/host.h
+++ b/drivers/net/wireless/marvell/libertas/host.h
@@ -308,7 +308,7 @@ struct txpd {
 	__le32 tx_packet_location;
 	/* Tx packet length */
 	__le16 tx_packet_length;
-	struct_group(tx_dest_addr,
+	struct_group_attr(tx_dest_addr, __packed,
 		/* First 2 byte of destination MAC address */
 		u8 tx_dest_addr_high[2];
 		/* Last 4 byte of destination MAC address */
-- 
2.30.2

