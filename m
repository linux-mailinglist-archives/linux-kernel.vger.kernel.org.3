Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A02A583796
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 05:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238082AbiG1Dea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 23:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234588AbiG1DeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 23:34:24 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719B35A2F7;
        Wed, 27 Jul 2022 20:34:22 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id iw1so689977plb.6;
        Wed, 27 Jul 2022 20:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=v5iO3DJsdBPM2eAKiUQEswEd2u5joVshDOWMCkBSEWI=;
        b=WopjFI8tRQsKj7xA9eC0fUlEFtVpR2QGFKPdVL1gXuQFz/suaXcXYnPrqJhZyD/MgM
         xPzRiKv2v6pruqFlUGtoK/cL3gvLBxtKYOupZ8Hrp0fjirRR1Kxb6diOiS4CwhdCl36x
         hXl7jt3dOgauNq9ttRk/Pn2iJJ/gJ/7M/6uj4HKWYUwv/29yFPgeXIDCGeBQCerpJegW
         TlbRGpXiokQGKtPRQQX2ZH6VUz9uW3j5VQ3b35UNwQIBvCUIGTKbkzmmXFC+HJoQt3IY
         WKFQnNsLkQlJBU9i6/kRoPfhvR5PAJ0DyJOj33iB+6DYmkQ+m7//Ik9S+FeEXisYJe9J
         OkZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=v5iO3DJsdBPM2eAKiUQEswEd2u5joVshDOWMCkBSEWI=;
        b=GeS0joJLabDNBx+6P5iH+X8iX9s0Ustogl7FFLdnSrL5wStz7eN/sUMq9TlXuBfZoT
         tMeDDQXAP6b7l43JoEPTbb0n81zucTC4mGSkYy2/ax8dJU4c7nekRR9a++uZg3IJcSUD
         QfplXdYr1YVLAsa+eUgNSM8XMw64MCkvz/LfmBNqgOcgDoF/lqeJfwd9U/Z66L52zISD
         U5zis4L/XLOt4U07bqjLAmZ8eNWZrkwtA+I7mTIofy38BIMXvMbu/f5NV/NFOUy1o/Su
         w5CiCC1T//6U03E0qHDVvR8bYz/MPhKqpKsl1QL9ExzH91JGZ5bAgrPeZUPxOb1+iRa/
         76AA==
X-Gm-Message-State: AJIora+DopQd3v5RnJNncH3l7RaT6jdFcFM9rXnstS0KdKtsXInQKMnH
        CsNalCv1iscctC52cB8LnUU=
X-Google-Smtp-Source: AGRyM1vrkYDWEh+Q5CKXwHq6PQq+SAM34S/j5zh3ymhk2nd7NrnqZNL26drZbsS7S6b+1oQNZRzfMQ==
X-Received: by 2002:a17:902:ef46:b0:168:bac3:2fd4 with SMTP id e6-20020a170902ef4600b00168bac32fd4mr24230479plx.132.1658979261953;
        Wed, 27 Jul 2022 20:34:21 -0700 (PDT)
Received: from debian.me (subs28-116-206-12-54.three.co.id. [116.206.12.54])
        by smtp.gmail.com with ESMTPSA id d8-20020a17090a7bc800b001f2ef3c7956sm2598035pjl.25.2022.07.27.20.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 20:34:21 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id E106D104A91; Thu, 28 Jul 2022 10:34:16 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-doc@vger.kernel.org, linux-next@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-doc-tw-discuss@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Nicholas Piggin <npiggin@gmail.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 0/3] Documentation: powerpc: documentation fixes for Documentation/powerpc/elf_hwcaps.rst
Date:   Thu, 28 Jul 2022 10:33:30 +0700
Message-Id: <20220728033332.27836-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220727220050.549db613@canb.auug.org.au>
References: <20220727220050.549db613@canb.auug.org.au>
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

After merging powerpc tree for linux-next integration testing, Stephen
Rothwell reported htmldocs warnings at [1]. Fix these with self-explanatory
fixes in the shortlog below.

[1]: https://lore.kernel.org/linuxppc-dev/20220727220050.549db613@canb.auug.org.au/

Bagas Sanjaya (3):
  Documentation: powerpc: fix indentation warnings
  Documentation: use different label names for each arch's
    elf_hwcaps.rst
  Documentation: powerpc: add elf_hwcaps to table of contents

 Documentation/arm64/elf_hwcaps.rst              |  2 +-
 Documentation/powerpc/elf_hwcaps.rst            | 17 +++++++----------
 Documentation/powerpc/index.rst                 |  1 +
 .../translations/zh_CN/arm64/elf_hwcaps.rst     |  2 +-
 .../translations/zh_TW/arm64/elf_hwcaps.rst     |  2 +-
 5 files changed, 11 insertions(+), 13 deletions(-)


base-commit: d6b551b8f90cc92c7d3c09cf38c748efe305ecb4
-- 
An old man doll... just what I always wanted! - Clara

