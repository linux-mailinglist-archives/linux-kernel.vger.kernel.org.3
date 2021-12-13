Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEABC47346F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 19:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242018AbhLMS4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 13:56:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233160AbhLMS43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 13:56:29 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB31C061574;
        Mon, 13 Dec 2021 10:56:28 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id u1so28618483wru.13;
        Mon, 13 Dec 2021 10:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SlRUCNZA27tVMMcwdRpt49s0tEWpr4zRWRRepQCcdFA=;
        b=TZDTJVpd4mh00xWC2z0z5mHYHH2o9JjzG2pmnMngm1ScOQb4vMwt1hw3bQHfVaD+be
         vlyvZG0lOATSHAG8/TAKUkYzZUryX2/bKeOm+0MpkG1wAJMsVV+GLsxJDuQ8zdi/GFHX
         89YHco+p1YsDIWksqhSotC0WUL4R6iBR7p3ofHtc7h7AQYzMUajOz/z8vFyuJKarzCYe
         D8cxIcpLGSU30Cl624XVZouBkXIoUek2nJgcsRYzuNk8dSvataBej7Nbul9pXXqZTqOi
         q9xdulk4/wzNQ5Z0zos8gEgVxkdQNScmLo5FxkpV+2NXLcsa0ZKRWy0ZG+WV44WVchtG
         ymdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SlRUCNZA27tVMMcwdRpt49s0tEWpr4zRWRRepQCcdFA=;
        b=mggzpcllawWq3XKE3ECGginq1wC7Y/Uom3lu4PRRILtIzTNUVesrkd5Yh2gNZRD7BF
         wlP6AZU7aaLjhDMXWe9zOfnu0FV8esgQcIkm6cPSW4SqEQSB/O3D7XGjdXS0n2CNCMTQ
         tddrNu3C9zOXq8RNPOuZpHarysKzK9a97WP2xluf/zVEmQjnrinr3q/22lJPAvnDObL1
         ghdAZEADUIk2aqynaZNWoScS7V29dqLg31zxNL1LsiuweJ+pl+S/UC9bGHP5JCqdyOEJ
         j2IZ81JTTDN48FXBglr9/wmpiO6dCfZt3F7YwXEUXINTbOUri2edQ7BoSs7IKlrqygrr
         jTSg==
X-Gm-Message-State: AOAM530LXyTBK0G1UpGI3mLhp+82dp/pvh5atoPDx0gzrOf3FrzoV2rR
        vBnwn4dRZvsofiJlUrbL6O4=
X-Google-Smtp-Source: ABdhPJw24lKF33uNsYPUjdoHiUoD27t9zwBAzTBlU549U7TdTtZQz1aZGZQZk7jnGsNdwoJuhAz1bg==
X-Received: by 2002:a5d:6c67:: with SMTP id r7mr369009wrz.286.1639421787485;
        Mon, 13 Dec 2021 10:56:27 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id e7sm14944804wrg.31.2021.12.13.10.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 10:56:26 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        linux-alpha@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] alpha: osf_sys: reduce kernel log spamming on invalid osf_mount call typenr
Date:   Mon, 13 Dec 2021 18:56:25 +0000
Message-Id: <20211213185625.546358-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calling the osf_mount system call with an invalid typenr value will
spam the kernel log with error messages. Reduce the spamming by making
it a ratelimited printk.  Issue found when exercising with the stress-ng
enosys system call stressor.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 arch/alpha/kernel/osf_sys.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/alpha/kernel/osf_sys.c b/arch/alpha/kernel/osf_sys.c
index 8bbeebb73cf0..2367a385d726 100644
--- a/arch/alpha/kernel/osf_sys.c
+++ b/arch/alpha/kernel/osf_sys.c
@@ -521,7 +521,7 @@ SYSCALL_DEFINE4(osf_mount, unsigned long, typenr, const char __user *, path,
 		break;
 	default:
 		retval = -EINVAL;
-		printk("osf_mount(%ld, %x)\n", typenr, flag);
+		printk_ratelimited("osf_mount(%ld, %x)\n", typenr, flag);
 	}
 
 	return retval;
-- 
2.33.1

