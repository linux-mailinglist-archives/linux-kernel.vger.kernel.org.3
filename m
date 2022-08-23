Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEF2F59D6E0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 11:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349701AbiHWJ1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 05:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349465AbiHWJYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 05:24:15 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01155901A0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 01:35:49 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id b5so11803943wrr.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 01:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc;
        bh=kCvkiarFiXJ9jD4jJ8Afsozfi7HxwB9THrkLcggctw4=;
        b=AJwK8PvK7cqqRaWVCBGh4TIKUuauSmmPTOr3P5eR8YQjakHWqRgiSygCMNRjpeLNWD
         zcv+csKSgVzWW1shfKi5tSLPpSKeFhviuKZJFawMVznW+xYeJ9EqeZ7IaBqfjNbwPYZK
         1su/P5RC0CMJ2FatHA7E+qfliwabhOmq+TD6b7MtmvbBfQFXmjp2VBAwDvESEpK40v1G
         FTHC1V8/3kJjR0p0vc71aKg6tCSka3DOK08d8gYhw3Teeu9M++3a8StGOm+We1s5CcVl
         qJJJP9WeckPZ/+xczr9g/A+XbY3EYVL9HwTGf8KSo/0t3nMtKnDuAgW38PQnLf01yj27
         9NwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=kCvkiarFiXJ9jD4jJ8Afsozfi7HxwB9THrkLcggctw4=;
        b=ywaLm7/H0s1aHwRsLrNuS2FvYBWm11Hs4SP6Ec67s81CnVA9GnLiUR5a934ANqvojc
         sIu0djikAeaiL6rmN7PwnMDYvLAUYgQbsy/4BvB+9oDr9JMUeQGOVd4gxliK5uOuMcZ6
         E6lKtempe3qfYGIRnIhxH34O4M9wizE2bcM8+eMq2zaA+208rfWjrk1HGVCHuAXU0P6+
         vn8fMzTCcGhWXY/S67ROsjGC12F9ySTmHACrjWdcBmuq/X0tBaa2dWXtQWpUGW+GSrxn
         5rHrG2kVUq4rfACxRcZCBPC14GP/z9ktiIOmU63q38XEFIckcI6+mciNLM57f39/3Km+
         EQCw==
X-Gm-Message-State: ACgBeo0FXKnV+tf8d9fDePt6qPg/r3ytPJdfTJGcO19pBRepH3ady8pP
        5vrBfBqf8nNzjUnuW3lils8=
X-Google-Smtp-Source: AA6agR6vwLwj+I7j2yf59mXO9TKSSxRcoAHHO+NJPd7nraHZKpg3XBjAEEjv6P756ndUX1js76Pnrg==
X-Received: by 2002:a05:6000:716:b0:225:3f1a:a9a3 with SMTP id bs22-20020a056000071600b002253f1aa9a3mr9478491wrb.526.1661243673768;
        Tue, 23 Aug 2022 01:34:33 -0700 (PDT)
Received: from debian (host-78-150-37-98.as13285.net. [78.150.37.98])
        by smtp.gmail.com with ESMTPSA id d7-20020a05600c3ac700b003a5ad7f6de2sm16355305wms.15.2022.08.23.01.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 01:34:33 -0700 (PDT)
Date:   Tue, 23 Aug 2022 09:34:31 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        torvalds@linux-foundation.org, loongarch@lists.linux.dev
Subject: mainline build failure for loongarch allmodconfig with gcc-12
Message-ID: <YwSRFzQQKAXP2ncp@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I have been trying to build loongarch as part of my nightly builds, and
I can build loongson3_defconfig without any error. But allmodconfig fails
with the error:

In function '__cmpxchg',
    inlined from 'ssh_seq_next' at drivers/platform/surface/aggregator/controller.c:61:9,
    inlined from 'ssam_request_write_data' at drivers/platform/surface/aggregator/controller.c:1483:8,
    inlined from 'ssam_request_sync_with_buffer' at drivers/platform/surface/aggregator/controller.c:1761:8:
././include/linux/compiler_types.h:354:45: error: call to '__compiletime_assert_9' declared with attribute error: BUILD_BUG failed
  354 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
      |                                             ^
././include/linux/compiler_types.h:335:25: note: in definition of macro '__compiletime_assert'
  335 |                         prefix ## suffix();                             \
      |                         ^~~~~~
././include/linux/compiler_types.h:354:9: note: in expansion of macro '_compiletime_assert'
  354 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
      |         ^~~~~~~~~~~~~~~~~~~
./include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
      |                                     ^~~~~~~~~~~~~~~~~~
./include/linux/build_bug.h:59:21: note: in expansion of macro 'BUILD_BUG_ON_MSG'
   59 | #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
      |                     ^~~~~~~~~~~~~~~~
./arch/loongarch/include/asm/cmpxchg.h:83:17: note: in expansion of macro 'BUILD_BUG'
   83 |                 BUILD_BUG();
      |                 ^~~~~~~~~

I will be happy to test any patch or provide any extra log if needed.


-- 
Regards
Sudip
