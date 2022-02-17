Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6224E4B95B9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 02:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbiBQBzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 20:55:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbiBQBzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 20:55:19 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4FD23D5E7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 17:55:06 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id h9so5620877qvm.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 17:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KjR4NQCIfFXb9/kGE26/SqOFAIpzLehICNt3yPxXea0=;
        b=EAVhIWnqalEWB7rrz+MuEWM5AtBjMegbJ78U5w/yJv1lGrwCPvFbvSctaRxjG/dEZU
         1MEsdCiT50HuzSQ0YySfkxZXdDffT+nhhdFN7V9SzAdilCFkBfCcBrajpxyaf7qSPTOa
         grePbfCl3a8/OX/SyBojTbsK5w1GoFuKNfgWxgd7StnQUaJH2xZXmyhUrF2whl0Bml5u
         8NgcjpIQZpYf/OmBwjrtnRkig+Fgb0sRjHV6FC1AF3SKLUf4xyFV+YTEQXGETAOY6ujF
         stkltdahAdNZBfpSu1pMb+h5uoXTiFFGqu3nq3zwgX/aHhg5S//uDZLb/oeBwOA8wcJn
         7JCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KjR4NQCIfFXb9/kGE26/SqOFAIpzLehICNt3yPxXea0=;
        b=hkLvySOL1U59wOJIwJ6lMmKTU54b6/2z2T1lxSZ4Fhvj0b12CL2fjoQFNRwSaoR6EO
         WpxqWZoiEFaaX3wAAhg7xvj/pTOl4xPWz0J/dAIC7uJw4WtGuLEAwP7aKn1rh1T184qz
         WYGrmOjp68EOJqOj+H7vOWwOKlzyz+ISqe47n9VlbmUWT4bedsUJYpN2caoixZH9zYmc
         22HjlkQif0961LVbAyQwETkLVRoS5UZplyawLNABgChua5iXZW2gndq72mMYmZfyUMWp
         8degtnpAXehrKrtNTXPV6KKN5qHDno+WXqFzEa7LdLc6mYsn+77LfXGm4rbxE9L1CD9e
         D6dA==
X-Gm-Message-State: AOAM533ksrsDEFxMzKDhqZvBGenKf/Vb5fP+G+gGK5xtwLWqZTOxEbRt
        uAoSs3ZkYMkwmAjEb8Q4ebU=
X-Google-Smtp-Source: ABdhPJwmSHAZCgcnrdn3G2x7V+sT0U4MAkDXJR5Z8oNM/mU72MSaGUw5AR+UzljInxKdtBfUW1jHxQ==
X-Received: by 2002:ac8:7f12:0:b0:2d2:24e5:95de with SMTP id f18-20020ac87f12000000b002d224e595demr619026qtk.625.1645062905512;
        Wed, 16 Feb 2022 17:55:05 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id 17sm1294084qka.119.2022.02.16.17.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 17:55:05 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: deng.changcheng@zte.com.cn
To:     ebiederm@xmission.com
Cc:     akpm@linux-foundation.org, axboe@kernel.dk, legion@kernel.org,
        fenghua.yu@intel.com, david@redhat.com, eb@emlix.com,
        linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] fork: remove duplicate include in 'fork.c'
Date:   Thu, 17 Feb 2022 01:53:48 +0000
Message-Id: <20220217015348.1900270-1-deng.changcheng@zte.com.cn>
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

'linux/sched/mm.h' included in 'fork.c' is duplicated.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
---
 kernel/fork.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 64dbfb9426fd..2bfc74c2d2e3 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -97,7 +97,6 @@
 #include <linux/scs.h>
 #include <linux/io_uring.h>
 #include <linux/bpf.h>
-#include <linux/sched/mm.h>
 
 #include <asm/pgalloc.h>
 #include <linux/uaccess.h>
-- 
2.25.1

