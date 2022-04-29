Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F78514CC5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 16:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377259AbiD2O30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 10:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356195AbiD2O3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 10:29:25 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48864A146B
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 07:26:05 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id x52so5491372pfu.11
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 07:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W9EYM4DanU599/6DhoxnfVlMdFd4Yp2vCUF2lwLPebg=;
        b=LPfeV0sekUj8J1IqkRQzjV4+X9Levg2m9HlJg5da+XeVY7Enm83LUWiSIYIyS68YVe
         FG0BAQXRqilE7iLq6hpEjyhAjDxS/mHtmOlH2BaHCNii29ioU0v0fA41o5fIF4yOlFl1
         K+GQsnONo9xKflci818l1lVjgSfPZnZ0qpLdBycO9F2muUIJM0sPICOEGbmXazrc9AUa
         vIniOT74ff9mAnk1G3KIRRFUPaYsLNjjdCTpq/JcuBweF4KM0Sv+4Gea7e0Vq/KzEfKy
         O+PRWTwK0VtJSV0otshvXQcxPH0SzLR9j6TlHyZD3sokFtEktwL3uBhyWB60pZJGdd8E
         nt7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W9EYM4DanU599/6DhoxnfVlMdFd4Yp2vCUF2lwLPebg=;
        b=fcoZTAI+cn+F43IALyX+y4qssUd6a/Crl1Vr5Ievs/mypqZmtTY1Zi96ZJjfL1lXav
         XZz4WJnfFG+9B2FfRmVGPzb4XDSh1N+FhAjrippUh2k7BmZgvu7sfHqzVNQbqMUl9wmH
         Z685kc7XS2oR1ZCdgforZM61gBQaOCyRTkZOIInVaInVxN2OwMt6vJulmkM3uHOPnLkv
         d1JWSKmXgE9lswYAGNMXUzHCCGEHRwmdH8ZoT6fCoRGMNXNpbU5RH43GolJ+hLXw8QM0
         7LaYqtJfjRdj/VCwpHUPIkDMB65UNM+nCizysGqWMoudtjoY/42KEM1KRq+x0jDE0rZj
         xzKw==
X-Gm-Message-State: AOAM533cdxd9/hSPTAdd+x1MHI2RHVm7qWSnTXZvFzaD+Ze0E5xPfzf1
        CY+bKb3BL740SFX7F+WFh39Y3brYB/1Rpw==
X-Google-Smtp-Source: ABdhPJwpzK+go6RxRAFwpSWV0ghI6SdQRfe5KnOYDp2ojZwNACF5G0gkF83XU4PxMyTi1lPpa62ZJg==
X-Received: by 2002:a63:5355:0:b0:3aa:2752:1553 with SMTP id t21-20020a635355000000b003aa27521553mr32890006pgl.254.1651242364840;
        Fri, 29 Apr 2022 07:26:04 -0700 (PDT)
Received: from always-x1.www.tendawifi.com ([139.177.225.247])
        by smtp.gmail.com with ESMTPSA id a38-20020a056a001d2600b004fae885424dsm3494734pfx.72.2022.04.29.07.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 07:26:03 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     akpm@linux-foundation.org, naoya.horiguchi@nec.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH 0/4] memory-failure: fix hwpoison_filter
Date:   Fri, 29 Apr 2022 22:22:02 +0800
Message-Id: <20220429142206.294714-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
There are two parts in this series:
"move clear_hwpoisoned_pages" and "simplify num_poisoned_pages_dec"
do not fix bugs, just make memory failure easy to maintain.

"optimize hwpoison_filter" and "add hwpoison_filter for soft offline"
try to fix hwpoison_filter.

zhenwei pi (4):
  mm/memory-failure.c: move clear_hwpoisoned_pages
  mm/memofy-failure.c:: simplify num_poisoned_pages_dec
  mm/memofy-failure.c: optimize hwpoison_filter
  mm/memofy-failure.c: add hwpoison_filter for soft offline

 mm/internal.h       | 11 ++++++
 mm/memory-failure.c | 81 ++++++++++++++++++++++++---------------------
 mm/page_alloc.c     |  1 -
 mm/sparse.c         | 27 ---------------
 4 files changed, 54 insertions(+), 66 deletions(-)

-- 
2.20.1

