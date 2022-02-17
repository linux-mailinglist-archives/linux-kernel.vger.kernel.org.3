Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFD724B9C33
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 10:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236149AbiBQJkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 04:40:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiBQJkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 04:40:08 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C47D4297207
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 01:39:53 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id d84so4162339qke.8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 01:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6IJLc/Cn0GXkokHZ0Xfyjxmui3w38PrdplyvDRcFb2Q=;
        b=Cm+mgef46rtj8F0XGP798Jxzy/TyXcYYlstMycJtlB/KEQ10tRy3Qf6BAQFXDMiiIm
         9Mlvc6CvURY6/mAPrStS/6SIWx6O5TxJhPFt/jYunYGpjLZfjVV7O9jp6/e4Q7D84fpJ
         wm8+TxCop1691hsrENYYs45gXKn7+W8THiG+Dkp/5VbcFyqwWSqvbEnuknExSncRnelb
         oHmYJDRs/3ueoWcqtUeps+E/68VjP2YqZBmYhxWuc84WFk86OtwZvMiPnaLjyN4S/zqo
         snIAOnxnJWIUCszYePfkUnzN4mbNc8EwvK57pVUXTaOJUraiKXFbT4ieMJq+MyAmdFK/
         o/qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6IJLc/Cn0GXkokHZ0Xfyjxmui3w38PrdplyvDRcFb2Q=;
        b=CtyzXFfbTohnWvD480DZ4BApJMh9YKTZtjDe6PK+/cy1Z97uXzIoZ7ztWzNXKq6N5V
         4sDF8Xn8VHETCeCUBxLOpWAsjnUe8Q9vTCjE/jFgHne614ai4+96prUclhDNj8R72JrJ
         lV6Aul4D8QoH67F09vE73ZwwqHVefBVPysUfmiZF0ua0W9GTTWVSB7ecFSFAY+fkGuhL
         OchLPjNjCzr3nzXpp3CEzsF8Qce3hhPvhJ6hk68E6sz3z5wRQMvK2M3EUImTsfA0+g+R
         q/+5GjAwl8Hyw4FM5gwq9pGBDc2VAd4IvwDhafcT4hScr9tiEK+7B5V19LNfO3IxB7h3
         1sJg==
X-Gm-Message-State: AOAM531husYIqnDpkU8ROWjfgji/hysQ6GTYRofkZa1I815lXlFmzyml
        o3W/io6mFkIrJzfnb5h7/oY=
X-Google-Smtp-Source: ABdhPJwU+wXgnW9fBPti0lqKXzuhEmf9k/VyX5Kl8Fpchn5MpS1pRR43jVt/0z8l/exyaS3A593fFA==
X-Received: by 2002:ae9:efce:0:b0:4e1:33bb:a4fc with SMTP id d197-20020ae9efce000000b004e133bba4fcmr973999qkg.123.1645090792990;
        Thu, 17 Feb 2022 01:39:52 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id o1sm1943070qkf.40.2022.02.17.01.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 01:39:52 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: xu.xin16@zte.com.cn
To:     bsingharora@gmail.com
Cc:     linux-kernel@vger.kernel.org, xu xin <xu.xin16@zte.com.cn>,
        Changcheng Deng <deng.changcheng@zte.com.cn>
Subject: [PATCH linux-next] kernel: Make taskstats available via genetlink per namespace
Date:   Thu, 17 Feb 2022 09:39:45 +0000
Message-Id: <20220217093945.1904085-1-xu.xin16@zte.com.cn>
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

From: xu xin <xu.xin16@zte.com.cn>

Currently, the application getdelays cannot get taskstats in a net
namespace. The returned error is just like the following:
-sh-4.4# ps -ef | tail -5
root       186     2  0 09:23 ?        00:00:00 [kworker/2:1H]
root       187     2  0 09:23 ?        00:00:00 [kworker/0:2-eve]
root       190   183  0 09:23 ?        00:00:00 -sh
root       198   190  0 09:25 ?        00:00:00 ps -ef
root       199   190  0 09:25 ?        00:00:00 tail -5
-sh-4.4#
-sh-4.4# ./getdelays -d -p 186 -v
print delayacct stats ON
debug on
Error getting family id, errno 0

As more and more applications are deployed in containers like Docker,
it is necessary to supoort getdelays to be used in net namespace.
Taskstats is safe for use per namespace as genetlink checks the
capability of namespace message by netlink_ns_capable().

Make taskstats available via genetlink per namespace.

Reported-by: Changcheng Deng <deng.changcheng@zte.com.cn>
Signed-off-by: xu xin <xu.xin16@zte.com.cn>
---
 kernel/taskstats.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/taskstats.c b/kernel/taskstats.c
index 2b4898b4752e..4d6bcaaf52a0 100644
--- a/kernel/taskstats.c
+++ b/kernel/taskstats.c
@@ -664,6 +664,7 @@ static struct genl_family family __ro_after_init = {
 	.module		= THIS_MODULE,
 	.ops		= taskstats_ops,
 	.n_ops		= ARRAY_SIZE(taskstats_ops),
+	.netnsok	= true,
 };
 
 /* Needed early in initialization */
-- 
2.25.1

