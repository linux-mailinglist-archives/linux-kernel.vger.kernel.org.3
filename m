Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A00950A612
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 18:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbiDUQqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 12:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232057AbiDUQp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 12:45:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9CF4048E4D
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 09:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650559385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=+Bjh4A2xgvA65XgQNDvQgstLNivQfww0GqMpHMFLzMk=;
        b=XxcHHESF1ktRllaZMJAEpFTvcbaapMSnHTNSJ80pLmtGyXUsbHsBmK+Ngw3xhtoTPvkaiF
        gtF8PU1WVhfoOK6B37BMiLGzp5jtukqckKn2pWBLm7fBrKtI7sYms6aNz+je28dKmJGo0Q
        cQeFehS13Y8ZdjMqzFEQHSEbWzNfF+E=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-252-AjLldHWMOA6Qhdw_KxfUmw-1; Thu, 21 Apr 2022 12:43:04 -0400
X-MC-Unique: AjLldHWMOA6Qhdw_KxfUmw-1
Received: by mail-qk1-f199.google.com with SMTP id k15-20020a05620a07ef00b0069eab7275d5so3712654qkk.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 09:43:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+Bjh4A2xgvA65XgQNDvQgstLNivQfww0GqMpHMFLzMk=;
        b=vRmc4f9bNfv77B03dSjKsHOfBWMiyD+rZczVaRcy1ks71SeIh4jiSEGjlE3Xowls2Q
         //3AJukBPXo7dNkNjpQLEw48TY+/+bQcwKa4ZAsi7568GOVed5/zqZSbsxMwq1oW7tgW
         766XXMsDxuHBuA05JJWoJt/e5YDDmrKxxHr5k/mdGixFUKDROvYzAwCdT5B6x2d9nAQn
         eWotpKlBty77JwXmKASsXemnNCQ+zkjew6Wq9GfQB997tpQazYXJBexqLdP+ifDcT9J+
         dgsN/Hnjoc57L+ll3CS3Vbqw4ImFzUNJ6pS+1c1WDo6iZv1YsmIQjf9IHRQddmSWhHbd
         /2Zw==
X-Gm-Message-State: AOAM5336NCwxVdBXqa/xftI00i7MY+Ygebl7P63UitkZ7TjedFYJE/6T
        ksr3pMybiZ51jcU3IVgDroM1c0nEDVb9ADToXSRSHT91emWEbjBKfqp0a+mWlIgSHciZkHiL8F4
        Q1d5pDjNwjevA32HjYXw5AfuG
X-Received: by 2002:a37:65ca:0:b0:69e:d32a:91ff with SMTP id z193-20020a3765ca000000b0069ed32a91ffmr213239qkb.766.1650559383964;
        Thu, 21 Apr 2022 09:43:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwNg8tV2VAaDIcr+Juw0PHofmf5dHfJBDMtp/TlbLkvBCvx+GsRyiFAk7MK5zPhP5ECQJbrTw==
X-Received: by 2002:a37:65ca:0:b0:69e:d32a:91ff with SMTP id z193-20020a3765ca000000b0069ed32a91ffmr213227qkb.766.1650559383776;
        Thu, 21 Apr 2022 09:43:03 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id z8-20020ac87f88000000b002e1cecad0e4sm3631641qtj.33.2022.04.21.09.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 09:43:03 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     rafael@kernel.org, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] ACPI: bgrt: use static for BGRT_SHOW kobj_attribute defines
Date:   Thu, 21 Apr 2022 12:42:54 -0400
Message-Id: <20220421164254.859162-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch reports this repesentative issue
bgrt.c:26:1: warning: symbol 'bgrt_attr_version' was not declared. Should it be static?
Similar for *status,type,xoffset,yoffset

These variables are defined with the BGRT_SHOW macro.
For the definition of bgrt_attr_##_name,
the storage-class specifier should be static

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/acpi/bgrt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/bgrt.c b/drivers/acpi/bgrt.c
index 02d208732f9a..e4fb9e225ddf 100644
--- a/drivers/acpi/bgrt.c
+++ b/drivers/acpi/bgrt.c
@@ -21,7 +21,7 @@ static struct kobject *bgrt_kobj;
 	{									\
 		return sysfs_emit(buf, "%d\n", bgrt_tab._member);		\
 	}									\
-	struct kobj_attribute bgrt_attr_##_name = __ATTR_RO(_name)
+	static struct kobj_attribute bgrt_attr_##_name = __ATTR_RO(_name)
 
 BGRT_SHOW(version, version);
 BGRT_SHOW(status, status);
-- 
2.27.0

