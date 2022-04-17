Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29CE7504997
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 23:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbiDQVP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 17:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbiDQVP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 17:15:27 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0EADF87
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 14:12:50 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id a11so9030736qtb.12
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 14:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=qlWQU1wc+ycXAXdYl+UTLFvX0C5kqftRvoDnhhithWo=;
        b=d1mMRZPX8GYKQTsf8xBxnjSR8g5cFMdSrjJol/kB5oVPEo27LhL/fa/pxEW4fKRaqn
         UyGWgJryPFb2VXyx/g3YL7wF1TdlymX7g0OD17EZiQLf0ELCbsQtWGPwefByVUheSRvP
         JUhdiMnQBQAJ1VOqeAGsghLp3Q6tjeBVjrLWdF0YzDFuyH2Xz7KitGP15rdVdetMoowh
         y1ouTExAEku9xynmpWGKep6+OPPWXUkFH86G4LgrnRNOwoxdnMWAAhRj9cvZ/WU6k+/1
         dx/+13kdIhulIwrXMOAz0SXSiTMrot6vA+vWDvllvuffzE3tqiI5PFU9p0gXsho0Z55P
         N2kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=qlWQU1wc+ycXAXdYl+UTLFvX0C5kqftRvoDnhhithWo=;
        b=wrOvApXbfYmpmTsKRf6m1VtmAFVDfAGh7j0r9yyY8sRRmEB4k68lXMNuPa0qImUBGo
         eKfBvn3g678ZLJl+JdCrDwkZzSYHJoGbDMWy8NLq/tXC/YBYHxvuDm8dwB4rrSabg/Ml
         lLe2yN5zc0mL199y/d0T1t678LdjJBrowRT4++llo/RniU9riYx0QJ4PlX6Qxjq90sXW
         Ul1u3i8E4JUm5zZRcQaaGDBNWLe4zRwMZvyrLik0vRSN+b9m5BWIIakmvbwtIbNq2xmT
         XN26iSGK2Z+q0YSz3HKabmq/AmHYr6X6sbB4FKaQ7y3OzwRsV5ZMyB28aaHKflNsgID0
         JUMA==
X-Gm-Message-State: AOAM533jHdAde4BUS7YpWQsmXo2wCrpbWdtC7kbEdfeCCjPCeiLEMGMp
        AK3jaZl1Zg8x3o1hVm7sWeI=
X-Google-Smtp-Source: ABdhPJwrUCgB4TlyCGqXuaupK+xSLcATAOe8OTzPmzFdBtVTU8mv/a6/sgbU5GcKwYpAxYZ+5IOdtQ==
X-Received: by 2002:ac8:4e46:0:b0:2e1:b933:ec06 with SMTP id e6-20020ac84e46000000b002e1b933ec06mr5423936qtw.684.1650229969685;
        Sun, 17 Apr 2022 14:12:49 -0700 (PDT)
Received: from localhost ([98.242.64.156])
        by smtp.gmail.com with ESMTPSA id y85-20020a376458000000b0069e64801b7dsm3363187qkb.62.2022.04.17.14.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Apr 2022 14:12:49 -0700 (PDT)
Date:   Sun, 17 Apr 2022 14:12:47 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Alexey Klimov <aklimov@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        David Laight <David.Laight@aculab.com>,
        Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: Pull request for bitmap branch
Message-ID: <YlyCz0Hu+aiycuIp@yury-laptop>
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

Hi Stephen,

Please pull the bitmap branch for the next tree. This branch is based on top
of 5.18-rc2. Tested by 0-day and TCWG. By myself, built for arm64, x86_64,
mips, ss90, sparc, arm and sh; boot-tested for arm64 and x86_64.

Repo: https://github.com/norov/linux.git
Branch: bitmap-for-next

Thanks,
Yury
