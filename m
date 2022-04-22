Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F1250B120
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 09:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444684AbiDVHMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 03:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444645AbiDVHM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 03:12:27 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B92E50E2D
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 00:09:35 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id e17so5410276qvj.11
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 00:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4PRaKTBX4zvfcCO3PcJSGqznsgOYRUdUYPYGgxvNGJk=;
        b=FmgD3YMH5ZAMxK3tKRqndWwIOcSRlgtPcYd/RgB7m0Z5OTwJturd4h6xZlFkUE6jPv
         mJDZjZZtObdX1gM1PGgZWYpO2csnDbG8c30Lp1U0BAZjWLwPBXUv33hAOFFM1lUyvo69
         3oeZ0wYMpTwD882qFKzoSgdlj2FXo7MH93YR1uNywTX5RdoFMS3FUPO3GKPNsTwuFnlM
         dbByzkaYdkh1ylxsDPfcSxDpW1pJaWDFt1bgYRzMoZrEHkHGv6fBDNBdXGk5HTxi4mKz
         n4P6HsPeb50PiMjbQrY5+GhqRUlgkMF7z7/AGMYnGIhq+J6NLGPguV/nkwea06QXxxDF
         cwoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4PRaKTBX4zvfcCO3PcJSGqznsgOYRUdUYPYGgxvNGJk=;
        b=UpmdCMXjxuK4FQT9rWrxJKgzAAmctlddDAlBKD3WsJ/lnuJ2ZwhJS6sswMwU5YWkbk
         W78HpMGiE/A6LJCPztk5b9RDTea5Tgx9E1ykZ16jz6aVLQCLJwYUrLTSv9CZITrO53cO
         +M94PwTaT+/eSHFqnZ0Q2IsbKeV8mHZhIJe55FZ0Hhg2u1mFVo2wIKnQZgRaJ1w2bSHn
         9FIj8zbqIi78AUm1CGCmnvjCJGIU5NPK/yBdCo1UpEZ0n2egUiBR2kjRpC7gVqgo//06
         TFhcl9ZDZPJzw0J55YnN/pkjd2oWRVWhcHk+BOoEDj1S0UsmeWcPtcP42ld9Kq1DGbTJ
         JjBg==
X-Gm-Message-State: AOAM532ww/EwolGBTFMye7PCrrnPB717C9xPJnX4vjJNb3oGKrYE5I+F
        rD1s2PLw88Sjz91bhj/gmEg=
X-Google-Smtp-Source: ABdhPJwty+79omghdZU2CmjLKE0ZISzktFgDQQWpWvf4Y5KNPRnfdIqNfqjFi5e9qoTNzRPu3AaY9Q==
X-Received: by 2002:a05:6214:21a5:b0:446:6477:30b9 with SMTP id t5-20020a05621421a500b00446647730b9mr2220318qvc.103.1650611374245;
        Fri, 22 Apr 2022 00:09:34 -0700 (PDT)
Received: from localhost.localdomain ([192.159.178.174])
        by smtp.gmail.com with ESMTPSA id y7-20020a05620a0e0700b00699a30d6d10sm532950qkm.111.2022.04.22.00.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 00:09:33 -0700 (PDT)
From:   ashamedbit <muralianiruddhan@gmail.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Cc:     ashamedbit <muralianiruddhan@gmail.com>
Subject: [PATCH] Subject: x86/vdso/vdso2c: Memory Leak fix, Fix leak of variable name in vdso2c.c
Date:   Fri, 22 Apr 2022 03:09:22 -0400
Message-Id: <20220422070922.14765-1-muralianiruddhan@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The file vdso2c.c contains a memory leak of variable 'name'.
This leak was detected by ASAN(AddressSanitizer) on local  builds.
A tool called AddressWatcher automatically attempts to fix memory
leaks suggested by ASAN. The fix has been inserted to stop the
memory leak in the file vdso2c.c.

Signed-off-by: ashamedbit <muralianiruddhan@gmail.com>
---
 arch/x86/entry/vdso/vdso2c.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/entry/vdso/vdso2c.c b/arch/x86/entry/vdso/vdso2c.c
index edfe9780f6d1..b3decd59c98e 100644
--- a/arch/x86/entry/vdso/vdso2c.c
+++ b/arch/x86/entry/vdso/vdso2c.c
@@ -246,6 +246,7 @@ int main(int argc, char **argv)
 
 	go(raw_addr, raw_len, stripped_addr, stripped_len, outfile, name);
 
+	free(name);
 	munmap(raw_addr, raw_len);
 	munmap(stripped_addr, stripped_len);
 	fclose(outfile);
-- 
2.25.1

