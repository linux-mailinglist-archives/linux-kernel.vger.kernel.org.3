Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBEC563847
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 18:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbiGAQtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 12:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiGAQtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 12:49:41 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D7A2A41D
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 09:49:39 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id k15so2811348iok.5
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 09:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mty5me6ttD4hyNm+ObIqVF8504n78lHkOkvX07KswbI=;
        b=APAgpxiMHpOH07dyaKBPZJJvZsHU+HAs7siNihWvOzQ8g7N2h0GtoNLaPc1sxgHbU5
         2lptTWDRtJ0Y1zqZwQ94ksL8yiGYPKCd3DKEs19dWavHuS0Ol7lJvI4qBc1MMvzkmMUq
         +FT/iZVAHO44b0ZGCbjArT3BoNJQji0fO16Ww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mty5me6ttD4hyNm+ObIqVF8504n78lHkOkvX07KswbI=;
        b=RFRgRUBaZLJfHmOMxpgORMTVV5RLXuRTPlPbHljw28JR6NdDsOYtwFDZQuGCVythCS
         4HPU45OviBAj9e8YDjJOQ2Es7AjCnOGcV3/nu/9ljBP2sw3VrVsYCtI0gY7z/QF+bRkn
         KRbVGDAhp3CygNtJlS05rxyrwNLUREWVMTHF2SOmzpEhuVLc/zzg/crMWeL7CWHPFBwh
         WWQYxdr+wyiWpl836jMdhPDo0AN/yJ1qNHBJoGBYJcYL1OnJd8JGfFrMzJw7HtvRwnEh
         CiDYCZ0uhVHUtNgYpQykE1fjiqCvrJL5v+aq/wBoILMT+VPFwXmpa8tHvCLJuTdVsj5l
         CLwA==
X-Gm-Message-State: AJIora/0W8IXqXM1P5T1AufQUt90lapYxkXPgGYiQBXcgvHjgIDvMw9f
        M+ONlcmGX8V7oP2j0GKsX1NuVCYDfumqkg==
X-Google-Smtp-Source: AGRyM1tvAadTvI9x3rpQIByjApzbEDintWHCWM3Z/OurOIL41jmvjdGhR0dZnaxWIbMrTkfpUDzCxw==
X-Received: by 2002:a6b:8b42:0:b0:675:1e6d:9386 with SMTP id n63-20020a6b8b42000000b006751e6d9386mr8192474iod.153.1656694179105;
        Fri, 01 Jul 2022 09:49:39 -0700 (PDT)
Received: from shuah-tx13.internal ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id u2-20020a02b1c2000000b00339df77c491sm9830281jah.114.2022.07.01.09.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 09:49:38 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     --to=arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: [PATCH] misc: rtsx_usb: set return value in rsp_buf alloc err path
Date:   Fri,  1 Jul 2022 10:49:29 -0600
Message-Id: <20220701164929.15296-1-skhan@linuxfoundation.org>
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

