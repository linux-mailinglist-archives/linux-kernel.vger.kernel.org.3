Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62D2B46BB01
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 13:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236372AbhLGM2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 07:28:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236021AbhLGM2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 07:28:30 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58676C061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 04:25:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5F7E5CE1AA2
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 12:24:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAE5CC341C3;
        Tue,  7 Dec 2021 12:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638879896;
        bh=Y2shfXEwL/UCPPKsv0Oa3tA9lIynCe1L61hYiqi9XeI=;
        h=From:To:Cc:Subject:Date:From;
        b=W559fWo1fWpckmtZrwlLgXqUZHgqZUif16pdSlVwo1cuzrxYUkuy0NWY9gq1VmSVA
         iH3jZRVaJ2Clg9mS7id1l05XqTXeQG/a5njD+gyHyXoGmCJqhcEHrBnc9Gya4HT43c
         0LzXNn2wdGrKb7vMkztVpxlCEwJrN07IpekH/JMN1ekrxn9opHbcU8OwAcCOrLfC7y
         mYWRswwsW08rT6+3bleh9OKW28FvTfn8MGWt3TPvKYK9c0RExdRw9y5JiqFCimbuqy
         J/Xzx85i69QtYieflARWddvcI9dUhJa4DjN2IqkqdUjVg0rk3DZp8Sh3IGc8m7GHao
         Jd8YpxDU9sNfw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Li Li <dualli@google.com>,
        Marco Ballesio <balejs@google.com>,
        Hang Lu <hangl@codeaurora.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] binder: fix pointer cast warning
Date:   Tue,  7 Dec 2021 13:24:42 +0100
Message-Id: <20211207122448.1185769-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

binder_uintptr_t is not the same as uintptr_t, so converting it into a
pointer requires a second cast:

drivers/android/binder.c: In function 'binder_translate_fd_array':
drivers/android/binder.c:2511:28: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
 2511 |         sender_ufda_base = (void __user *)sender_uparent->buffer + fda->parent_offset;
      |                            ^

Fixes: 656e01f3ab54 ("binder: read pre-translated fds from sender buffer")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/android/binder.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 5497797ab258..182bb4221b06 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -2508,7 +2508,8 @@ static int binder_translate_fd_array(struct list_head *pf_head,
 	 */
 	fda_offset = (parent->buffer - (uintptr_t)t->buffer->user_data) +
 		fda->parent_offset;
-	sender_ufda_base = (void __user *)sender_uparent->buffer + fda->parent_offset;
+	sender_ufda_base = (void __user *)(uintptr_t)sender_uparent->buffer +
+				fda->parent_offset;
 
 	if (!IS_ALIGNED((unsigned long)fda_offset, sizeof(u32)) ||
 	    !IS_ALIGNED((unsigned long)sender_ufda_base, sizeof(u32))) {
-- 
2.29.2

