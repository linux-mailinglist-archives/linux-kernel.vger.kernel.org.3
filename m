Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93EB549835C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 16:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240735AbiAXPPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 10:15:01 -0500
Received: from m15113.mail.126.com ([220.181.15.113]:1176 "EHLO
        m15113.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240713AbiAXPPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 10:15:00 -0500
X-Greylist: delayed 1891 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 Jan 2022 10:14:59 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=MUBBQ
        58hKYSQ3ZzR/De1jQkk/sAxXI77CBURZOFvWwE=; b=BGP7zS40IPKTEgKwW+BVr
        Hq5rSydSbgmpKRr3qTiXDmJNK7KZXu3/ARnwJ75verv7E/OyXRVxDc+2TD2NWCnH
        b/4KiHOqaKCp9jcI6AOy79UP9zdPZqSwo26se2L7luGmi9TbTRXp6uY5MHJHTKG9
        yBd0nMY5Wz0lHLSZjRExaE=
Received: from localhost.localdomain (unknown [49.76.221.145])
        by smtp3 (Coremail) with SMTP id DcmowADn4Mjquu5hqn_PAg--.53689S2;
        Mon, 24 Jan 2022 22:42:50 +0800 (CST)
From:   wonder_rock@126.com
To:     keescook@chromium.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com
Cc:     linux-kernel@vger.kernel.org, Deyan Wang <wonder_rock@126.com>
Subject: [PATCH] pstore/ram: Use reminder directly
Date:   Mon, 24 Jan 2022 22:42:47 +0800
Message-Id: <20220124144247.34525-1-wonder_rock@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DcmowADn4Mjquu5hqn_PAg--.53689S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruF1rZrWftr4UAF1DKr4kJFb_yoW3urb_Ja
        4v9rZ5u3WrtF1Y934YyFyakrWv939IvFWIgFs2qFWUtrykJw13AryDZryDZ34DZ3Wqya98
        Ga93JrWFvw15ujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjqYLJUUUUU==
X-Originating-IP: [49.76.221.145]
X-CM-SenderInfo: xzrqvv5ubu0ubn6rjloofrz/1tbiuQqSgVpD7nNfWQAAsi
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Deyan Wang <wonder_rock@126.com>

The remainder is more efficient, we directly use the remainder.

Signed-off-by: Deyan Wang <wonder_rock@126.com>
---
 fs/pstore/ram_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/pstore/ram_core.c b/fs/pstore/ram_core.c
index fe5305028c6e..69928a59e28b 100644
--- a/fs/pstore/ram_core.c
+++ b/fs/pstore/ram_core.c
@@ -61,8 +61,8 @@ static size_t buffer_start_add(struct persistent_ram_zone *prz, size_t a)
 
 	old = atomic_read(&prz->buffer->start);
 	new = old + a;
-	while (unlikely(new >= prz->buffer_size))
-		new -= prz->buffer_size;
+	if (unlikely(new >= prz->buffer_size))
+		new %= prz->buffer_size;
 	atomic_set(&prz->buffer->start, new);
 
 	if (!(prz->flags & PRZ_FLAG_NO_LOCK))
-- 
2.25.1

