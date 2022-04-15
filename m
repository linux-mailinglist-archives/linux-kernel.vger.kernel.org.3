Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60DED503405
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 07:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356428AbiDOXVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 19:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiDOXVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 19:21:53 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B75CDBD;
        Fri, 15 Apr 2022 16:19:23 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id u18so11395031eda.3;
        Fri, 15 Apr 2022 16:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fl9P1fWtDG1OkEFRgKvC5cv/qOT4nNS4Bnbk2bWR2ig=;
        b=h7bCcyCHzPUdMc3cqCmJVCpip0m9mEriH57X2uK1h2CIT0ztP2mIOkfZKDsT+RZ4qI
         R6QEmRlCJM5dWthhj9SlXtNKt8uTebpCH3dEZ0hD8uuweodmUemvMx8jxXArnks3jI/r
         +nr8PbizLanf6PqqH5QT8y59QAFfkYMdm2YAgg37qXWqxlCsZYatqZ8gBrinz4nrmnBb
         bdYNszabX0efNz6ZvBKL2P4BvkKJW1cCfIwww1w/FWl8rZYKKDS0LEE9o+L1I9wjxpvg
         PbUNxHHCDtaXtDp1weA46itjesOlyGiyxxlqgsNAPVBQKxYhMFbCmwZ7769gBoQIATq9
         NLZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fl9P1fWtDG1OkEFRgKvC5cv/qOT4nNS4Bnbk2bWR2ig=;
        b=f9G3lsChfxoLlVmRfVN0e0am3PJXedl6XWwe0yBi8FWn+JN43NntO8pOm2mNa3C18I
         NrJE0NKQeuOcS4Y8eLM6pMd+W/lYShTyRDZuqcsbgJ/TnsVvYAaQ5eh8hhcTyYDRU83d
         924O8ivqjmpxjDR4uzFV+A42tndGLl0DrvQmHZV/MMR5mh8y6PZ3BdhkTCdB1O/C4OCB
         I/CQbyn8PVJrEtxRB3p5rj/J8M7id4CB3G0I5/N50DUAFcKBXDkOauo2P+9h3oH831PP
         EZpFHJeI9KZpC3nNRXmyqH7ZyvRTNhhFf0VFzuWRKxAv06AZj1ubEZ2ozImclmioLhhk
         ujjA==
X-Gm-Message-State: AOAM533FbLFt+51CYrGJ9viL1KoA94GwPaYJsbrdz755sV1dtY1BhkF0
        VE/8oMP4EaPl0/a8Sab+wmo=
X-Google-Smtp-Source: ABdhPJyknTqHTS2CfeoyYUK//y5tO12vqFUmVcMOOduSoVfRfsH+WIw2JJl8xyFEHKCvgRhrnqtPaw==
X-Received: by 2002:a05:6402:238d:b0:41d:7630:2300 with SMTP id j13-20020a056402238d00b0041d76302300mr1329883eda.363.1650064761638;
        Fri, 15 Apr 2022 16:19:21 -0700 (PDT)
Received: from localhost.localdomain (host-79-43-11-75.retail.telecomitalia.it. [79.43.11.75])
        by smtp.gmail.com with ESMTPSA id o15-20020a50fd8f000000b0041f95b8a90dsm3203394edt.69.2022.04.15.16.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 16:19:20 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        SeongJae Park <sj@kernel.org>,
        Jiajian Ye <yejiajian2018@email.szu.edu.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ira Weiny <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        outreachy@lists.linux.dev, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v3 0/2] Documentation/vm: Rework and extend highmem.rst 
Date:   Sat, 16 Apr 2022 01:19:15 +0200
Message-Id: <20220415231917.25962-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Extend and rework the "Temporary Virtual Mappings" section of the highmem.rst
documentation.

Do a partial rework of the paragraph related to kmap() and add a new paragraph
in order to document the set of kmap_local_*() functions. Re-order paragraphs
in decreasing order of preference of usage.

Include kerneldoc comments from include/linux/highmem.h and remove
redundant and obsolete section about kmap_atomic().

v1-v2:
	1/2 - According to comments on v1 by Matthew Wilcox and Ira Weiny,
	      correct a mistake in text, format paragraphs to stay within 
	      the 75 characters limit, re-order the flow of the same 
	      paragraphs in decreasing order of preference of usage.
	2/2 - No patch.

v2->v3:
	1/2 - No changes.
	2/2 - Added patch to include kernel-doc to highmem.rst and
	      remove the now redundant section about kmap_atomic().

Fabio M. De Francesco (2):
  Documentation/vm: Extend "Temporary Virtual Mappings" section in
    highmem.rst
  Documentation/vm: Include kernel-doc to highmem.rst

 Documentation/vm/highmem.rst | 96 +++++++++++++++++++++---------------
 1 file changed, 56 insertions(+), 40 deletions(-)

-- 
2.34.1

