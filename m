Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC6258B6C6
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 18:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbiHFQZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 12:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbiHFQZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 12:25:25 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F30AEE32
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 09:25:23 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id c24so230164pgg.11
        for <linux-kernel@vger.kernel.org>; Sat, 06 Aug 2022 09:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=NXmKWiY+YgrhRIy35M4F409DidYR+3CB8lakrMwmXBI=;
        b=mGD/ODJWQvXXqlpXKHFKDwZkEPAqNTY099s5n9ZUOsESRXw1Fnj/9C+mfE/I+/rlR/
         +L8PUiWH/OpOsWwAGaK+y8Ek8LrqhbsW72N9XZZvcbRJG6HX41/Yx8EcDPPt/sUjO3YI
         Wma2VK7FmIBlKzwIPg5q8yYO0zlcGussljWN7ondhP4bdGZBUwKGBErUgkaAgJldHt1b
         YnfYDuTgry+JGMQoNRbW1o/wX72oil2XyDwV+Oh1v0yhjRe0vkGbNKGgTIPP+dJ6n9iu
         NpaJUKGRbAs1TGN0/z+LBP+nTqx/2jXq4M2Er7wGGk2GJWhkv+jHWgBW4TGXIX2egokI
         OBCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=NXmKWiY+YgrhRIy35M4F409DidYR+3CB8lakrMwmXBI=;
        b=K/2kAEHBERLU5QNGXWJ/5xKHpAAmR1puRkkbm9eN5nXwN/bVPCVtyh3+CPD1lfwCFO
         gv0Qh1/jjk4mH3zkZdCTdf/eAvTQvgWUSBAzvgwe9bEGo9d7AptwSrc7+Eil2Tbwr++N
         X2hLbFNAH4QeiQPeOezuRZeiOdNl0xZO1rjusYkz0bcCDZRDunj8YIIIimH2KrRvlKiQ
         pPcu2DUhIlPYsfjS5oXt8q2uAf65qE+isyf1EmKm8ky9V3tmK2Ukq/8Db+BT0gSYwLpj
         fre1D3PoKYWO4Z/JJxk/9tfFkg2MeihLBrzzmA5yuVhqWH2gHVDj5/i9RT8l9sfBxS/Y
         OXLQ==
X-Gm-Message-State: ACgBeo3EcmQf5e4AXV/Mf40B008O7btRBxx2DK8svVPhXPIUs9hndwSJ
        BNaMrvWKXTMm1SOXiu1RyY4=
X-Google-Smtp-Source: AA6agR4BcLuJbwh+wnWLkEQef2143483xnsFNHlUU1Vjz0dPAN8FBCpG5KpFKIXsq45KndWAcmY6ew==
X-Received: by 2002:a63:1648:0:b0:41a:49f9:77ae with SMTP id 8-20020a631648000000b0041a49f977aemr9745848pgw.377.1659803122846;
        Sat, 06 Aug 2022 09:25:22 -0700 (PDT)
Received: from localhost.localdomain (ec2-13-113-80-70.ap-northeast-1.compute.amazonaws.com. [13.113.80.70])
        by smtp.gmail.com with ESMTPSA id s1-20020a17090a2f0100b001f04479017fsm4990927pjd.29.2022.08.06.09.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 09:25:22 -0700 (PDT)
From:   Zhang Boyang <zhangboyang.id@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH RESEND v3 0/6] rslib: Several improvements
Date:   Sun,  7 Aug 2022 00:25:04 +0800
Message-Id: <20220806162510.157196-1-zhangboyang.id@gmail.com>
X-Mailer: git-send-email 2.30.2
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

Hello,

I made several improvements to reed-solomon library.
Please have a look. :)

Thanks!

Best Regards,
Zhang Boyang

===

Changes in [PATCH v3]:
Fixed kernel-doc style. Thanks to Randy Dunlap :)
(But I decide to keep "a*b" instead of "a * b" because I think it's more
readable)
Reordered some patches to group similar things together.
Link: https://lore.kernel.org/all/20220620062015.15612-1-zhangboyang.id@gmail.com/

Changes in [PATCH v2]:
Added more patches. Removed init_rs16(), since init_rs_non_canonical()
can do the same job.
Link: https://lore.kernel.org/all/20220617144624.158973-1-zhangboyang.id@gmail.com/

Changes in [PATCH v1]:
Added init_rs16().
Link: https://lore.kernel.org/all/20220606101901.83538-1-zhangboyang.id@gmail.com/

[RFC PATCH]:
Link: https://lore.kernel.org/all/20220605073857.126497-1-zhangboyang.id@gmail.com/


