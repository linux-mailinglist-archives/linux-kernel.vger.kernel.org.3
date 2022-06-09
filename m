Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32BBA544E58
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 16:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243253AbiFIOFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 10:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236262AbiFIOFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 10:05:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 97932139015
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 07:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654783537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=xhgrKuwsMFGqD7N/R0k/QMWuYyV386FPUEYFwR1ivao=;
        b=D1QxoBcsnUhVK4ugBecQ+BTuwFApx3Xc4ti3UM+OGySL0o44u3BZmv3+HIDlkVpXa6JN6D
        Nm2i+MawWfKv6NBl04byAo5loAbQGoyaY8L0d8vHS2DAHny/vIvBE9a9C8A05MMb7xkuSZ
        wQ+XNmIDwqAqdz9VjSbAJVkb+qb8Xqo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-323-Za7Nwr2LMRKHKNm3_7i6pQ-1; Thu, 09 Jun 2022 10:05:34 -0400
X-MC-Unique: Za7Nwr2LMRKHKNm3_7i6pQ-1
Received: by mail-ej1-f72.google.com with SMTP id x2-20020a1709065ac200b006d9b316257fso11089660ejs.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 07:05:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xhgrKuwsMFGqD7N/R0k/QMWuYyV386FPUEYFwR1ivao=;
        b=tNEsXQMH6CdGQ9H7Lg9OvHRDVQukGYhOwrS75yDWkQuDyEwyVHXvybdPK+a4JjpDmp
         5nWp40k6aieajbRL/gvOj321tH6Zfv4ZiZ/h5sOxIWV5vz5ifmO5Gh5zIQ/JtfhA3Bpr
         zaFab3jiIlgprVLZrFDb2Hcsngp/uPZEWP5o6/W17mkWIUAz8QwirqILz8aycikDmzI9
         NxlunY0UVbqJ1N8eXZG4YHqozoGQE8W93/8iUx3KSnE4PTvQjfn/BDF1cNt18q79amMV
         +5h98dOmF8Htl/oj3S/QX7UZ35uMQR5di6T4uU8M4y/TOD7jLg+n6Olg3kVt8hnFXexZ
         iq1w==
X-Gm-Message-State: AOAM530yb8XwcObSk3YB75zFE0dfnAeZ7PnrJqmtIUAJ4w/wn0M4hKVK
        iDP7mYIF3undxPPJ1iDkv9/OHhN4CY7t6UvyF5Uq3Pc62V/LrEaMK7Jyag0/nlucfzCM4exV+40
        8bXSUtO84yjhiMvETzIF1oOw=
X-Received: by 2002:a05:6402:160b:b0:431:35df:63c0 with SMTP id f11-20020a056402160b00b0043135df63c0mr30958620edv.124.1654783533598;
        Thu, 09 Jun 2022 07:05:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyat2k8+xqz5HSlqoTKaB+b/XqaUBP/0sro/fhR+EAmjl++CgbKpOl7FWRGYDLChRrJ8P//iw==
X-Received: by 2002:a05:6402:160b:b0:431:35df:63c0 with SMTP id f11-20020a056402160b00b0043135df63c0mr30958587edv.124.1654783533372;
        Thu, 09 Jun 2022 07:05:33 -0700 (PDT)
Received: from auir.station (net-188-216-46-176.cust.vodafonedsl.it. [188.216.46.176])
        by smtp.gmail.com with ESMTPSA id o2-20020aa7dd42000000b0042dc460bda6sm14371070edw.18.2022.06.09.07.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 07:05:32 -0700 (PDT)
From:   Marco Pagani <marpagan@redhat.com>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Alan Tull <atull@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] fpga: altera-pr-ip: fix unsigned comparison with less than zero
Date:   Thu,  9 Jun 2022 16:05:19 +0200
Message-Id: <20220609140520.42662-1-marpagan@redhat.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the "comparison with less than zero" warning reported by
cppcheck for the unsigned (size_t) parameter count of the
alt_pr_fpga_write() function.

Fixes: d201cc17a8a3 ("fpga pr ip: Core driver support for Altera Partial Reconfiguration IP")
Reviewed-by: Tom Rix <trix@redhat.com>
Acked-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Marco Pagani <marpagan@redhat.com>
---
Changes v1 -> v2:
- Coding style fix
Changes v2 -> v3:
- Added Fixes tag
---
 drivers/fpga/altera-pr-ip-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/altera-pr-ip-core.c b/drivers/fpga/altera-pr-ip-core.c
index be0667968d33..df8671af4a92 100644
--- a/drivers/fpga/altera-pr-ip-core.c
+++ b/drivers/fpga/altera-pr-ip-core.c
@@ -108,7 +108,7 @@ static int alt_pr_fpga_write(struct fpga_manager *mgr, const char *buf,
 	u32 *buffer_32 = (u32 *)buf;
 	size_t i = 0;
 
-	if (count <= 0)
+	if (!count)
 		return -EINVAL;
 
 	/* Write out the complete 32-bit chunks */
-- 
2.35.3

