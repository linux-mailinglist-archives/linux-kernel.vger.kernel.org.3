Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF035843D9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 18:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbiG1QMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 12:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbiG1QMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 12:12:18 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 726484505D
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 09:12:17 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id q3so1739600qvp.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 09:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BevssIEixB8bWfQySBHmZ4Jr0wRcQugiruyrYaaCWJ8=;
        b=aqCxrokHPzJf/bvyCgVsYDOmal6oumiqBBhE8LXg+LXcDB3wZ8pVqTIxHezMIrHblX
         mU3opnlsYpTKfi6wbXPxddV52RZ7Nj/5Us0B6PVYHqROQD1SLBzw0Q4QppFPFyClN/Ss
         2lu6wT6NgOiUwMdaTCna1KAvD0FmAy1sBIpMT0+v1NSDK/4TaBLTRF+awv4QmkJhhlvp
         RBiOHVKW4RaYv/dsXyvdjR5RPFWWMFB7bBpkqTJTCLEKONfzNBtWtKbMBjEJ/zLXhySY
         EIaD8QjOpGQBt7aWDtrioPSqpAa7p/gwiKKzuKJOSuBgTdbPCcLdg0DfMWXuRW7I5lfw
         NWwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BevssIEixB8bWfQySBHmZ4Jr0wRcQugiruyrYaaCWJ8=;
        b=TLuX6ZpSkO8shTVhWH4JFzK5aUQtCskMZiokGfh6slpTsMgrasmya1UzVhNbFZ1nHq
         OaSY0vheE7qrz0/7+nHk1q+Alrd2xtgHPKkXxuK3lHi3MGzO1xW48wMZw3tYnPQIjQzF
         HZ8fqooCuHQ6fvWkU3CLWpr+TP4VeZ4fEzLo+l31+nX2x4VZie2zDSsb6O3NZ+fo8O7c
         79/iLrYagot2o/Jg3UBaySiB1NbarRJac8yrZGE1rQy6YDtuy8uwkop7QSSMkgpDtVQS
         9qGTktuhuyOKMB0WSl9lx6BmF+3cb4w+gNChhag4vXA2EJVuw1gPEMohgeO6s5xfN5uM
         +X1A==
X-Gm-Message-State: AJIora81eDJp+etFqlaSwtI3KkV0ie5j55ZKwLc8nYPPoQzY12S1Cy6J
        SqYpM3uZUwKgfzRFXOhUkr9xVo4Q2XQ=
X-Google-Smtp-Source: AGRyM1uUdPTZi343IiPW1iPumrhWdEfIibVUWCoheq11I99V3X31FRTWuGSzlD5xoRrUH1zcWlD+oA==
X-Received: by 2002:a05:6214:1c4f:b0:473:7909:85e2 with SMTP id if15-20020a0562141c4f00b00473790985e2mr25147548qvb.69.1659024736342;
        Thu, 28 Jul 2022 09:12:16 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:1230:b984:ba52:c3cf:cb5e])
        by smtp.gmail.com with ESMTPSA id t22-20020ac87396000000b0031ec44aa37bsm629225qtp.93.2022.07.28.09.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 09:12:15 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Dennis Zhou <dennis@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexey Klimov <aklimov@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 0/5] lib/find: optimize find_bit() functions
Date:   Thu, 28 Jul 2022 09:12:03 -0700
Message-Id: <20220728161208.865420-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.34.1
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

In the recent discussion [1], it was noticed that find_next_bit()
functions may be improved by adding wrappers around common
__find_next_bit(). 

I tried that trick; and although it doesn't affect performance
significantly, as reported by find_bit_benchmark, there's ~2.5K
decrease in image size.

find_first_bit() is reworked accordingly.

[1] https://lkml.org/lkml/2022/7/25/830

Yury Norov (5):
  lib/find_bit: rename le to need_swab in __find_next_bit()
  lib/find_bit: optimize find_next_bit() functions
  lib/find_bit: unify _find_first_{,and,zero}_bit implementations
  lib/find_bit: create find_first_zero_bit_le()
  lib/find_bit: re-use __find_first_bit() in __find_next_bit()

 include/linux/find.h |  45 +++++++++----
 lib/find_bit.c       | 155 +++++++++++++++++++++++++++++--------------
 2 files changed, 138 insertions(+), 62 deletions(-)

-- 
2.34.1

