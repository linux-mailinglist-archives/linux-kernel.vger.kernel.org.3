Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02FCE510D12
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 02:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356342AbiD0APu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 20:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356353AbiD0APq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 20:15:46 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FA267D0F
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 17:12:31 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id iq10so82877pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 17:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LrY29zoH0JBtqVaH425QnOYLXccFTmhwFII9Fu+0HQc=;
        b=Nptqp+TlA73Mu1+UbvfBpJP/xL2A5YFZbWR/9azHiX7v62jVA4hu7QEXCq0IHyKL3f
         ipCCOk1JvkZvL4Oag6VDOfmKCyn9GYxGoghG2WykPwZJ+Vww+j2HcJk43fdhb8OLjzTM
         SMYV2/uahV9zmIYnJ7lLbWjByz2sCZmvJQhxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LrY29zoH0JBtqVaH425QnOYLXccFTmhwFII9Fu+0HQc=;
        b=mJBYB9OwNO34ofz+uF6I9Ou5tb1XLSbgYrUavlaNT2KAHmppHd0HjhTT/RGlJtojak
         ns7VyRVG2R+6p5QMJNSqv8zHeQL17MXMCNSBxL21t9kjDGDBk1MpCZ+gZ0rX/OtUpsGV
         2WlU6XF1iOZXmiRA1Ftxs2usV1ZWMlEDQrhPltx8FgLpCEqrwe1o/RgtRUBczeeNWNiE
         m6FZlpYIoM9jpJM4/xjraqfJ3qmeqZakcMoeusDWeG8AUhnwL89r4aq/M6yMR26EvFdz
         GS7vAsqhoA12/gBbRh7q94kXktXK3NtbybytZOAfD0+SmNawHt7TyaA0P3voDx9LQXfV
         /yew==
X-Gm-Message-State: AOAM532kyNsb8nFP53nJ25k2TRqlZSrQrNo8RB3l9z9OvPQCQ2HCCHqZ
        bj2DjnQgDAKd0zclC7+iElpR+pVekI3SVw==
X-Google-Smtp-Source: ABdhPJzh2GNfUelh/E8seyDpUBAxJPMlUIErWm87QFNyGWa4pxdnuFXvFmZSXuQ6SBj5obZCBj1u0g==
X-Received: by 2002:a17:90a:d715:b0:1d9:b55b:9a16 with SMTP id y21-20020a17090ad71500b001d9b55b9a16mr5635541pju.93.1651018350579;
        Tue, 26 Apr 2022 17:12:30 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y2-20020a056a00190200b004fa865d1fd3sm17090582pfi.86.2022.04.26.17.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 17:12:30 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        kernel test robot <lkp@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Li <ashimida@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] lkdtm: cfi: Fix type width for masking PAC bits
Date:   Tue, 26 Apr 2022 17:12:26 -0700
Message-Id: <20220427001226.1224704-1-keescook@chromium.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1119; h=from:subject; bh=qmOzXnXd3i6tUyczr+mAshjhtKMYt8Tj7/F36+UT8Og=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBiaIpqzyhZlG6iHvnfZ3eDFRKG+BvbhbLggZSr7CKc yvUBTu2JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYmiKagAKCRCJcvTf3G3AJsA2EA CAcU3cjo9QBKKr5AIrPuSxrQutvqiTa3JVSpLL2zzwZFaBGjnEpu4zrkGyuZdJqxPRbb7nhqp9R06O iQwl5w4/qW/bU87rq5L+M3ai/+bUHTk5b5GLolkYVsjyJRvyxZE5lZd9o24nuEP5REWEjBalrMjpZw h/BPZMY9yBqTz/4Y3a0G+PDCm8zZmwSQk7IZ2t4qfIANRwFJ0wrAB0kyxVV20xqNYSe6p4guNY1ZCP XsqvE25Rgcq1Kz3AOgHxwdb+7O1mWN0ZTTZeQpYFy1imAF8HwvFJMmm/MHZiOjcrihPcgtma6b46Ux AE2Rsa+dnFSlSLzyG29iIlZVm4kmOcItC/Qd95h/MUWEobeUeFL7oCd9sqd7iSTPd9D3Qid3elnuNN IicRmyE2zi7I/573A2c3na3azD4DohO5oVYeRqOB9ebuSBIc3EpXsuys1UnGRO8w2PM7bBOoXcLefb G/N+ar3qd59SBHFdZWu+BwpUBkkAlPiXuk2chZaf1hADhiTPrQ80Y7MTYP9bwmEKz4xqFIsqtGh67u ngHLE7CXIdSg8HISCVSoyNufromZvax5VdDoLIkUxsk4KRBGb2LaZzecI+kCQK0QGTEWuu9AoPMPX6 bouXEFAH0gjWbgQNtN0oQNGUQtiGTluvx/o8ZhZt/AkHS9TJAY9AgYKnSDUw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The masking for PAC bits wasn't handling 32-bit architectures correctly.
Replace the u64 cast with uintptr_t.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Link: https://lore.kernel.org/lkml/CAMuHMdVz-J-1ZQ08u0bsQihDkcRmEPrtX5B_oRJ+Ns5jrasnUw@mail.gmail.com
Fixes: 2e53b877dc12 ("lkdtm: Add CFI_BACKWARD to test ROP mitigations")
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/misc/lkdtm/cfi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/lkdtm/cfi.c b/drivers/misc/lkdtm/cfi.c
index 804965a480b7..666a7f4bc137 100644
--- a/drivers/misc/lkdtm/cfi.c
+++ b/drivers/misc/lkdtm/cfi.c
@@ -59,7 +59,7 @@ static void lkdtm_CFI_FORWARD_PROTO(void)
 #endif
 
 #define no_pac_addr(addr)      \
-	((__force __typeof__(addr))((__force u64)(addr) | PAGE_OFFSET))
+	((__force __typeof__(addr))((uintptr_t)(addr) | PAGE_OFFSET))
 
 /* The ultimate ROP gadget. */
 static noinline __no_ret_protection
-- 
2.32.0

