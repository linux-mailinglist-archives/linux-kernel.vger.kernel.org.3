Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3CFA4B6718
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 10:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235690AbiBOJMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 04:12:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235689AbiBOJMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 04:12:05 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA511C92A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 01:11:56 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id bs32so16773184qkb.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 01:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YBQscFyooYL0WHuST9zmiXq7toDSTo9x20y433njXvY=;
        b=CUvbeESCjAqhXzzfxF/YYa6U3SM4LMGYKlC7SDkDR1uhzWCLBoEldyNjHc/MwM+Jqt
         4pPfqpLePsZCSFx+7tpIPqSBGnq4Hjeg6k1HyrJZukjNbYEQuobWYo41naoqODynPPZo
         f4PX12XFozrF2o7h/ScjfH+qvIh6UT068hiTttGh0P4ulZuLI4lN0Rv0S3ewaEoYQ6H4
         D8C69zV9DlfMSDeJ6mK8HrE+xx2GzFkpH79qQaz+FiWQVwyzsvhMl8DaNIWLVrAG9iol
         d5IUK6aoMjRZQB2RfR0jEzeIYr6EChVWSe3awOtMZy1hiEkWLE7zO2rmxvsnq2gZT6PF
         7Bnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YBQscFyooYL0WHuST9zmiXq7toDSTo9x20y433njXvY=;
        b=w/muaDcgjYX+SsrpweDDyAkmquoPcJXSjlZFzr0D3KmxIOCIDEQzK/grQJrh7xWyl1
         vgDO3ou1++xe1kuxgmWsLJJ7whz6aHt5dXW+Q7w6BYSMPPyO/BrR6Pr5x8jYXu5Egygc
         QhykrZrOhhzqUnbi+jFiXKmm1ro/PjzODseAgwrVzwtu014xB2+UHiXqivA1EE6Ubg9W
         H093R1JCzFhC/0XPgMgo/qNbVlXrDzW2j7smx+BhqA8kILwlNQlATDd948onX5TBnqi0
         +LzAlvSckeZ2HdpWfeO3HGG38trzKocMxRsK3pI3kOqRfCgP+gEFHwIibGICt9sqbyIz
         5shw==
X-Gm-Message-State: AOAM531aQDJrl/bK+1xadi4+V/vIWPrK/8Q9Lnj+Ayf7+pm+zVJG3xEN
        e6dMIHEuqIp8wPzB84Y6cb6xlvsccD0=
X-Google-Smtp-Source: ABdhPJzt2l3x8XeZpyli8EcdnuyjGHmBO9r/EPioUdHk5iFiWxXUFc2BA0D+lX3UAgQSkHxG7KiAfw==
X-Received: by 2002:a05:620a:2589:: with SMTP id x9mr1457241qko.335.1644916315265;
        Tue, 15 Feb 2022 01:11:55 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id r3sm16683371qkm.56.2022.02.15.01.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 01:11:54 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: deng.changcheng@zte.com.cn
To:     Felix.Kuehling@amd.com
Cc:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] drm/amdkfd: Replace zero-length array with flexible-array member
Date:   Tue, 15 Feb 2022 09:11:42 +0000
Message-Id: <20220215091142.1775600-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changcheng Deng <deng.changcheng@zte.com.cn>

There is a regular need in the kernel to provide a way to declare having
a dynamically sized set of trailing elements in a structure. Kernel code
should always use "flexible array members" for these cases. The older
style of one-element or zero-length arrays should no longer be used.
Reference:
https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index e54a52785690..7d39191d13f6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1084,7 +1084,7 @@ struct kfd_criu_svm_range_priv_data {
 	uint64_t start_addr;
 	uint64_t size;
 	/* Variable length array of attributes */
-	struct kfd_ioctl_svm_attribute attrs[0];
+	struct kfd_ioctl_svm_attribute attrs[];
 };
 
 struct kfd_criu_queue_priv_data {
-- 
2.25.1

