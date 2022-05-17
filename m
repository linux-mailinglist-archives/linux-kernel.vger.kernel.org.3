Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93BFC529648
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 02:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241355AbiEQA4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 20:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240239AbiEQAz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 20:55:57 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6DC1FCF3
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 17:55:56 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d25so15515140pfo.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 17:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g7Q4DIyBFdkOfQfLesIacT6b2x85qOReA4ewSFpfUcU=;
        b=AnNSio8MU8aUblNXEC6S4jK102eG0to3VFxQn44aaTWb7YYxMIy3IC2pxI6oGsCEv/
         prVQiRYxTAXz5CWqYRWwLD1UyzwbeLyMA7k41CMiUytHJxV1vWIcIU9OXoisq+xIYtEz
         ZZ40h5vhDJDee6DUxobLBTpJ40faCf6VkijDsL7m6n4jJrLw/fqrbkX1FWCAYg6/3nql
         /9s/Ev0caf5hUMN6GxE272facYSz/9WECpBRJQgDWCZWuiSgOXhs2hCTUmZmWf76Wmo/
         /VLXww8BL3cFQ/LZ+g5aKO8dSFs1vz7zpjLPeEpD2DOXHfcCfKIkv9LM42wt0mNc99/7
         BYoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g7Q4DIyBFdkOfQfLesIacT6b2x85qOReA4ewSFpfUcU=;
        b=tKUlD5HyDS8yb/RBF5fUF+z2D/kWRsnop1PZUQvK3TET3YcaiN3kshoQgUQMb16uIB
         df4xXqYrkmNIBxfZ8mGt3RA1xtRyHiogsD2FzA3Y5fmhFz8UCjQPNFXwGD2vCb3v/TqT
         NdQ3upn3JeOEakuoMRyuxewE20V14kYIkQ1bjFjG706+4K/J05oq9F3/J3YzYjddTXZh
         lssXywLjRM9x25Kz3HZAuuT8o6lWhzWqZDwqj96qQKHaaPW+BrTvy9SEHt3aYxtCXRao
         ImlrtHQHgAdtfHOA+upjXpzTWQ0ID6p+c1Z1zrgyobjoTcpzC+jGkxbMUVokumqU9tFT
         ZMdQ==
X-Gm-Message-State: AOAM530j291NXdk65tvc6UjMwzw2ZK7jJtX3AkzZJgNFdmawgnwT7c/c
        ahoXO8JOqISTIl0rnN+LECO4psKO8dmn9A==
X-Google-Smtp-Source: ABdhPJwXcbp6DdwNTKzzohdiQOrQn3fCObLXri0C6XjchRPG/DsjUK2H3PNGpGQM9dNxEwAkvo+dkw==
X-Received: by 2002:a63:2321:0:b0:3da:f4b9:90e with SMTP id j33-20020a632321000000b003daf4b9090emr17804892pgj.31.1652748955611;
        Mon, 16 May 2022 17:55:55 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id gd8-20020a17090b0fc800b001d9780b7779sm293643pjb.15.2022.05.16.17.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 17:55:54 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Openrisc <openrisc@lists.librecores.org>,
        Stafford Horne <shorne@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v2 09/13] openrisc/traps: Declare unhandled_exception for asmlinkage
Date:   Tue, 17 May 2022 09:55:06 +0900
Message-Id: <20220517005510.3500105-10-shorne@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220517005510.3500105-1-shorne@gmail.com>
References: <20220517005510.3500105-1-shorne@gmail.com>
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

Noticed this when workin on warnings.  As unhandled_exception is used in
entry.S we should attribute it with asmlinkage.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/kernel/traps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/openrisc/kernel/traps.c b/arch/openrisc/kernel/traps.c
index 99cd2e6f8873..fd9a0f2b66c4 100644
--- a/arch/openrisc/kernel/traps.c
+++ b/arch/openrisc/kernel/traps.c
@@ -235,7 +235,7 @@ void __noreturn die(const char *str, struct pt_regs *regs, long err)
 	make_task_dead(SIGSEGV);
 }
 
-void unhandled_exception(struct pt_regs *regs, int ea, int vector)
+asmlinkage void unhandled_exception(struct pt_regs *regs, int ea, int vector)
 {
 	printk("Unable to handle exception at EA =0x%x, vector 0x%x",
 	       ea, vector);
-- 
2.31.1

