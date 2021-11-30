Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1BE463E21
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 19:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245600AbhK3Szm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 13:55:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245636AbhK3Sze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 13:55:34 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4B2C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 10:52:15 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id d2-20020a656202000000b00325603f7d0bso5321117pgv.12
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 10:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7A9065iuR2ss1lxFZ95G+12fYKknTJy/yo/FOQYVLbs=;
        b=A59CQGMcicMZfytm0hkVWaDDFBdJLEYnRpnE6eBtakQNyUbCLFzb74biCDIdkX2jCN
         SUjWMYVFU2LK7sZ7S0UudaMdxnhHdSaY6zS2Y29kEbuPwya3WZaHRlal+SvjZAiwiiQ4
         S/RsUZVWrW2o9hxGUratT73jBGVOVcbGtqa2WuhH3mUW/02Tn0goId4nZLEbLsPs/QGp
         95wyx7p2KMCASjRbhV9JSLgm0tI+PpHjOhEqpiL1xOiT3Xo1A7kRJ4Ubejb0z4LtY/rq
         /vQpt6MbwFmgKRRS4W/F5hKjw2q572Hmh2rwRk9on5Ijt+NvbORVpDbL2qvfa/2lH/Qk
         mN0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7A9065iuR2ss1lxFZ95G+12fYKknTJy/yo/FOQYVLbs=;
        b=yquNuTgzp4zubJAVQBnSlCGiCmOOUPBei67CD1ut7BxSDeb2b88/2vJksLpB8VT7mQ
         m/PT6pmO3sfWmVilobfcreSk7/apU0xzPNT2UwzEl0CiEQ/9GfrQ3YrPDBNneQvKj9li
         uvGvIwKbNPCLTbSwf+bwDqzviQGMuZtvn89I8S54OymBRvJlAs3Ueyx9W7u0rH6yAMut
         JSpOK7BUCN7MBgpU2BS6IMWT7jh6UbfkmHJTRfvcgnM03LVc6UHD6CyZr7/KlTvbkaOh
         BtZBChp4QuJKJTthqwsmnyxKlpbLBzA021zBSeVYLNMJeero8Z8BYcMLL2G8j07fI35l
         O4CQ==
X-Gm-Message-State: AOAM532M1ISGSoGm9pLQbnLgP0+0afylz7nAtK5TbjsmNopftTSmI9kn
        Pb7Vg77O9/83IyoNvosJUXGNsPzspg==
X-Google-Smtp-Source: ABdhPJwzxIwv2D5T5Bk3CoSZE6+ciPrBfIzNl6uc/DTYdn6OQk6YdgCk5CrcYybJO6aGTCVxsQVn1M+ovA==
X-Received: from tkjos-desktop.mtv.corp.google.com ([2620:15c:211:200:2355:b4ef:3d57:5d7d])
 (user=tkjos job=sendgmr) by 2002:a17:90b:33cf:: with SMTP id
 lk15mr929698pjb.85.1638298334923; Tue, 30 Nov 2021 10:52:14 -0800 (PST)
Date:   Tue, 30 Nov 2021 10:51:49 -0800
In-Reply-To: <20211130185152.437403-1-tkjos@google.com>
Message-Id: <20211130185152.437403-2-tkjos@google.com>
Mime-Version: 1.0
References: <20211130185152.437403-1-tkjos@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v2 1/4] binder: fix handling of error during copy
From:   Todd Kjos <tkjos@google.com>
To:     tkjos@google.com, gregkh@linuxfoundation.org, christian@brauner.io,
        arve@android.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, maco@google.com
Cc:     joel@joelfernandes.org, kernel-team@android.com, avakj45@gmail.com,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a memory copy function fails to copy the whole buffer,
a positive integar with the remaining bytes is returned.
In binder_translate_fd_array() this can result in an fd being
skipped due to the failed copy, but the loop continues
processing fds since the early return condition expects a
negative integer on error.

Fix by returning "ret > 0 ? -EINVAL : ret" to handle this case.

Fixes: bb4a2e48d510 ("binder: return errors from buffer copy functions")
Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Todd Kjos <tkjos@google.com>
---
v2: Added this patch to fix bug noticed by Dan Carpenter

 drivers/android/binder.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 49fb74196d02..984e6263dcc7 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -2269,8 +2269,8 @@ static int binder_translate_fd_array(struct binder_fd_array_object *fda,
 		if (!ret)
 			ret = binder_translate_fd(fd, offset, t, thread,
 						  in_reply_to);
-		if (ret < 0)
-			return ret;
+		if (ret)
+			return ret > 0 ? -EINVAL : ret;
 	}
 	return 0;
 }
-- 
2.34.0.rc2.393.gf8c9666880-goog

