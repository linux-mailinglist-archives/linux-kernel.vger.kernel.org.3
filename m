Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2683452665C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 17:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234835AbiEMPmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 11:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234776AbiEMPmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 11:42:05 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3456BE21
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 08:42:02 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id y21so10474746edo.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 08:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0jWGnYLEOk89JafvWxo6D1kM2erWRnT7G0Vcy9GTq3A=;
        b=HpqS9gFkTjrWtg3APSVnSpcFvdLsAvhXFrMHchP5dOwOPur4/MHCSpD+1jgS/THOBb
         twUYDkbdG3yEyeKd5xyWKSAVp8SOujvPMmth9JuJkFICzgoaBc4pIc6O1Q/Dzahkniyr
         ZAKTS7qJXuOEmVFADkUMYE8kGVYmFDZqme1eQGok0tJa74rjOFlLMwlaSiNCKF5ijVd6
         QsL4C1e/QGwTjtv5fp/pz9DfuRFy0cdIsS/OL67TkjOdb/O3tZb+IZDIRvUmdZ1qQHjj
         q20wr6VMebenCmCYJppMUV/YXCIbaWtxdCaesmr7dNL4oCZaA8BlGqg1GmmG2OTCTJLB
         QXnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0jWGnYLEOk89JafvWxo6D1kM2erWRnT7G0Vcy9GTq3A=;
        b=QPukNrO3uvSQFeXOotlBKHtptoYzfXGM5CGFgl9qHQWH2gBu3Q6n8q3Bf7FL7SOgPv
         4BGR7qF/gBwAP/N+dtiwiEI6IlF83HtqG0lYGeu0X5Ax9tz5The9Ney8s5DYodA3J/cf
         gUtpdfqujsdHHTRf9g/ORe9pf2fSVZy5N9gcsK3EveimVmF6xlofPhI9WmURbSF3hfOw
         htjq8bAI4RBwpxC2CIYfijIOPlrhgopbClOXAbXzebMBJqMSGM76UEnMrCDkAZcXOvPT
         ZMaI431fCY7X297LlR0+Yga08757ESUJ7KdZVxeTSV+Yi799aqTosdtiiqaFiAPgVEhK
         dC7g==
X-Gm-Message-State: AOAM532UThGKAkqS/Is703gadhhtp2/pPJxZ0IC6KYe4J3sR7M0M6uiT
        AhrWPfxtWFM2QZ3ECbbKVJ4=
X-Google-Smtp-Source: ABdhPJxOa75BH+/+JPmOTBUZbs3k+AeCsB4DKCB2oBBkrfQxny3JuwaOsVv56C14GSrtfHNHepILnw==
X-Received: by 2002:a05:6402:2741:b0:41f:69dc:9bcd with SMTP id z1-20020a056402274100b0041f69dc9bcdmr41052576edd.239.1652456521092;
        Fri, 13 May 2022 08:42:01 -0700 (PDT)
Received: from octofox.metropolis ([178.134.103.46])
        by smtp.gmail.com with ESMTPSA id h16-20020a1709066d9000b006f3ef214e73sm848313ejt.217.2022.05.13.08.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 08:42:00 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 0/2] xtensa: add division by zero exception handler
Date:   Fri, 13 May 2022 08:41:49 -0700
Message-Id: <20220513154151.4135905-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this series adds handlers for hardware and artificial division by zero
exceptions.

Max Filippov (2):
  xtensa: add trap handler for division by zero
  xtensa: support artificial division by 0 exception

 arch/xtensa/include/asm/thread_info.h |  4 ++
 arch/xtensa/kernel/asm-offsets.c      |  3 ++
 arch/xtensa/kernel/entry.S            |  5 +++
 arch/xtensa/kernel/traps.c            | 53 ++++++++++++++++++++++++++-
 4 files changed, 64 insertions(+), 1 deletion(-)

-- 
2.30.2

