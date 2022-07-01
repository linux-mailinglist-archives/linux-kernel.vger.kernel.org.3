Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B0D563854
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 18:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbiGAQx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 12:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231435AbiGAQxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 12:53:55 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9CF33A39
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 09:53:54 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id l24so2785309ion.13
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 09:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LaW3j8hbP/ddoj0KXcLD6b4OP7Z2ovMHOo40fbigHv4=;
        b=PsqDLXORcCNMMYdjv5CKT1lXfaZSa0sNyo4oqq3T65XGk20Vo3gdC+C7wgIs1Ovei/
         ZTMUckHuxfwlZqj/T0yAgGPiZaETEc9EajK17CUUZhlp0Go6KUZ2kYv0ZQ8mUzh/I7JL
         0OJ3Q59n6ZUsL+zPpBwwmmcAHRv3K4j04Tm/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LaW3j8hbP/ddoj0KXcLD6b4OP7Z2ovMHOo40fbigHv4=;
        b=nblnxfZlL+0KUr91GG3DA7S0idNGzOmYEx9HCHCvY0Ya+DgoR/p8Anuwu4hQL6rl+V
         upNOYDns/5Ygek7RcysfxrJ1PxuGFtPOLDkaHwHXAP4b50Oux3J9PpwwbEUxJQCtB5sA
         6FdOTHPVL/bkJqnax8tOipiKajUAgAxnNHzI0zjZaowwZG8swK1isFQfuIHAtwQiouy1
         S9EDiFR4/WfCNudWNY/cLgmj0iIRzitEYqT7dj6XFdq5Oaw3LU+EQtYMtNfdA9S0Wt9C
         s6DswKuwPDdbkSDc/9h1g+1SYODc6lOhrl5PIBAUxAVYcxkz7weoXum5DcDJd9Fru3wm
         vUzw==
X-Gm-Message-State: AJIora9Nh6g7JnQMX9WrQNYmWWCUJSvEEHK53DjdWkgYjcH9oTiqjrRb
        lr5AZnZVofiXDUCjeEj1PkZGEw==
X-Google-Smtp-Source: AGRyM1sEzipgi8TeJgTU049tz0zehytYTwsNREtfcixFnphoS0pcPQKjcnhOKBN70gnFZyLjjC6M8g==
X-Received: by 2002:a05:6638:3727:b0:33c:98a9:9 with SMTP id k39-20020a056638372700b0033c98a90009mr9260911jav.84.1656694434285;
        Fri, 01 Jul 2022 09:53:54 -0700 (PDT)
Received: from shuah-tx13.internal ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id r6-20020a924406000000b002dab4765893sm3911800ila.66.2022.07.01.09.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 09:53:53 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: [RESEND PATCH] misc: rtsx_usb: set return value in rsp_buf alloc err path
Date:   Fri,  1 Jul 2022 10:53:52 -0600
Message-Id: <20220701165352.15687-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set return value in rsp_buf alloc error path before going to
error handling.

drivers/misc/cardreader/rtsx_usb.c:639:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
           if (!ucr->rsp_buf)
               ^~~~~~~~~~~~~
   drivers/misc/cardreader/rtsx_usb.c:678:9: note: uninitialized use occurs here
           return ret;
                  ^~~
   drivers/misc/cardreader/rtsx_usb.c:639:2: note: remove the 'if' if its condition is always false
           if (!ucr->rsp_buf)
           ^~~~~~~~~~~~~~~~~~
   drivers/misc/cardreader/rtsx_usb.c:622:9: note: initialize the variable 'ret' to silence this warning
           int ret;
                  ^
                   = 0

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 3776c7855985 ("misc: rtsx_usb: use separate command and response buffers")
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
Sorry the first attempt had typo in the to list

 drivers/misc/cardreader/rtsx_usb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/cardreader/rtsx_usb.c b/drivers/misc/cardreader/rtsx_usb.c
index 4e2108052509..f150d8769f19 100644
--- a/drivers/misc/cardreader/rtsx_usb.c
+++ b/drivers/misc/cardreader/rtsx_usb.c
@@ -636,8 +636,10 @@ static int rtsx_usb_probe(struct usb_interface *intf,
 		return -ENOMEM;
 
 	ucr->rsp_buf = kmalloc(IOBUF_SIZE, GFP_KERNEL);
-	if (!ucr->rsp_buf)
+	if (!ucr->rsp_buf) {
+		ret = -ENOMEM;
 		goto out_free_cmd_buf;
+	}
 
 	usb_set_intfdata(intf, ucr);
 
-- 
2.34.1

