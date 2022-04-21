Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC3F50A7AE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 20:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391035AbiDUSFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 14:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390799AbiDUSE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 14:04:59 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB9C4A914;
        Thu, 21 Apr 2022 11:02:08 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id v15so7488731edb.12;
        Thu, 21 Apr 2022 11:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lOywcq043Yv+FklAUr4QgDF+CZZ8Fm9pvDhYVpjnqBA=;
        b=eecx/nbIl/qVmAavXVH1QtBMm/WUTeluckxs1qc4tw1Y6vxZ86/xB7ozu/zgCvduHh
         1h6sr+60PV4OZotP1IkXl6PiEAO6jIBaH8I+wCyUWAVuROGFmk+qqIdqW4LbPAlpZDOd
         dwTlvsztPjkIOdF+CghH88DMzlav2RgUCJNJstXASPY5+WZjEyPHowy8F3Z0AZjYZA8j
         eGdVGE4cgYTPUAQ76zyWm/ThY828nVJNDGv6iAnDc19k8syiC7u1OGaCwnbT9ToLVW3V
         cZS1A8gsXDxltmFaNc7s9AG8ikNO/UkB9u+jaaBX3cCvL4co8zlPFmKAsYp71ZX99+vJ
         JMwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lOywcq043Yv+FklAUr4QgDF+CZZ8Fm9pvDhYVpjnqBA=;
        b=zWconP0bdBlcJGlO2f3rvyALrj6mdWKQEzUGNcd0mvyHUDYzcp67y+Uu9SJX0Sr5Jm
         nokuIKoGMf0eNDmVZIccpByF96m2GCknNSTQzZxv0wF6bv6ErFxG9RXB1Oy+yF+xj1BT
         Zz8K2jl1PpViLwarX+YRyXT+3bTIxnEIqFKYvQZf8+onM0IXNVXddYa/pHILyzaASCLE
         TYknclYc1QPmvVNQs1J7xQyWtIkqAc4kwgfeSdSgMLOuICtxdFjhkglLTxZzyoc4T08Q
         eMa3AaUF925+9Z7tFqf48yTEKP/8D4V11B7Wc9qvsK90MAdUsWcKOstWXRuPlMT7Nkj5
         hnjQ==
X-Gm-Message-State: AOAM530thjBv8ZeVAHsGAIlsneJ1f0KIDZAfFU82hEkiU1ltl6z9qiij
        48/ppwIO7JC+2cegE+unEYs=
X-Google-Smtp-Source: ABdhPJwauNZg58tpQBk9hzxL0id6LFCJ4zvxpDL6xTFyXaXnoMUP7JB6yC/Zn52v1XcuKBIHi2gK8w==
X-Received: by 2002:a05:6402:3548:b0:424:2245:8d45 with SMTP id f8-20020a056402354800b0042422458d45mr815045edd.286.1650564127154;
        Thu, 21 Apr 2022 11:02:07 -0700 (PDT)
Received: from localhost.localdomain (host-79-50-86-254.retail.telecomitalia.it. [79.50.86.254])
        by smtp.gmail.com with ESMTPSA id l17-20020a056402231100b0041d98ed7ad8sm11836204eda.46.2022.04.21.11.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 11:02:05 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Will Deacon <will@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, outreachy@lists.linux.dev
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH 0/4] Extend and reorganize Highmem's documentation
Date:   Thu, 21 Apr 2022 20:01:56 +0200
Message-Id: <20220421180200.16901-1-fmdefrancesco@gmail.com>
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

This series has the purpose to extend and reorganize Highmem's
documentation.

This is still a work in progress, because some information should still be
moved from highmem.rst to highmem.h and highmem-internal.h. Specifically 
I'm talking about moving the "how to" information to the relevant headers, 
as it as been suggested by Ira Weiny (Intel).

This series is composed by four patches gathered from a previous series
made of two, plus two more single patches. The subject of this cover has
changed and the layout of the changes across the four patches has
changed too. For this reason it is very hard to show a valid versions'
log. Therefore, I decided to start over and drop versions (Maintainers
of the previous patch have been told to drop them).

Fabio M. De Francesco (4):
  mm/highmem: Fix kernel-doc warnings in highmem*.h
  Documentation/vm: Include kdocs from highmem*.h into highmem.rst
  Documentation/vm: Remove "Using kmap-atomic" from highmem.rst.
  Documentation/vm: Rework "Temporary Virtual Mappings" section

 Documentation/vm/highmem.rst     | 101 +++++++++++++++++++------------
 include/linux/highmem-internal.h |  14 ++++-
 include/linux/highmem.h          |  15 +----
 3 files changed, 75 insertions(+), 55 deletions(-)

-- 
2.34.1

