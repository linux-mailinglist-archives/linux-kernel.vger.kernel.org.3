Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBFA54A82F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 06:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234317AbiFNEgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 00:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbiFNEgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 00:36:14 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96662E6BE
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 21:36:11 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id f9so6837177plg.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 21:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4Z/iX7YmEjnq0jimjHRt+ZujFMeKDetwMwYzfGE9+NY=;
        b=YSlYb9TatwP2UlZQse3MD8Il8/Pgb3coeypckKX1qPfQJoOcGcvYSj+wXlncKXgMtM
         ouqQGeH92ZtMBgKX9OILHNDFOWylwvdw34530hRGFugqkqNraCJM6ctts0Lb40ykjihH
         FrX90lswufIi9NI0HLn3v2THKEFjyx1WJ2SI3O6YsHbV6Pa4+FeUqbKuMh41AK9DdIn0
         wdfOXTgL/tzVJ5yPEqiAYyycJz3ejqyVmpWWtmGbdhzFHUIEB8BfPw6WehvcFeDPT7Pm
         aEhAfArAd9zmNJpu2yJz9RKT0wyoxnVM1GHX+eeeiZ3H/yuboD7t8oMiATsmRjH7dZsQ
         PcSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4Z/iX7YmEjnq0jimjHRt+ZujFMeKDetwMwYzfGE9+NY=;
        b=hwiw4KA+UG2FXdqyahyy4irWtY9uX+2HTboXTsW6G2CiMxww10J/j0jBbfeDXnFJOi
         W+oyehYexP78xZVbraK49YHTRxB1X81IyTfqXLYT1cbJRWbBp2uvs3XTv7bLBncytsLl
         /wbBgpTK5t8nkFgWXAQse6TZ5w1N2/2ky1J9kFeUe9VYKDf9QZAeyn3hKwgpMMsvJ6JM
         jJlFfjNFpwHgIFc0Dw9OynwMTtduJnJnCWIS94fZvKAQxL0nQO3MxEqcoM7gyFOS2pFx
         PKcq73V+XG32u/bCCvYAWbTkGxZjOpd1n1+rr60JscpfS/A6ZiOvlBKDDqJwoLsEi1ge
         UenQ==
X-Gm-Message-State: AJIora8HqdVtpYuWObSIyRpCd+F3ODug/nNPGo4asiK/ObcjcQ6z8o9s
        viEM4cAEA1k09ceAMvpPBAHPWa+V6AQ/QZFO
X-Google-Smtp-Source: AGRyM1va1jqvBf8dDeUVKETPWbztgIbzr149+sIqRmctYccjw/m7vk1xmNK7H9j6yUzSHyF/i4ir2w==
X-Received: by 2002:a17:903:234e:b0:164:1668:3bc with SMTP id c14-20020a170903234e00b00164166803bcmr2750463plh.106.1655181371330;
        Mon, 13 Jun 2022 21:36:11 -0700 (PDT)
Received: from always-T480.www.tendawifi.com ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id t16-20020a63b250000000b00401a7b4f137sm6469120pgo.41.2022.06.13.21.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 21:36:10 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     akpm@linux-foundation.org, naoya.horiguchi@nec.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, david@redhat.com,
        linmiaohe@huawei.com, zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH v4 0/2] mm/memory-failure: don't allow to unpoison hw corrupted page
Date:   Tue, 14 Jun 2022 12:38:28 +0800
Message-Id: <20220614043830.99607-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3 -> v4:
- Add debug entry "hwpoisoned-pages" to show the number of hwpoisoned
  pages.
- Disable unpoison when a read HW memory failure occurs.

v2 -> v3:
- David pointed out that virt_to_kpte() is broken(no pmd_large() test
  on a PMD), so drop this API in this patch, walk kmap instead.

v1 -> v2:
- this change gets protected by mf_mutex
- use -EOPNOTSUPP instead of -EPERM 

v1:
- check KPTE to avoid to unpoison hardware corrupted page

zhenwei pi (2):
  mm/memory-failure: introduce "hwpoisoned-pages" entry
  mm/memory-failure: disable unpoison once hw error happens

 Documentation/vm/hwpoison.rst |  7 ++++++-
 mm/hwpoison-inject.c          | 25 ++++++++++++++++++++++++-
 mm/memory-failure.c           |  1 +
 3 files changed, 31 insertions(+), 2 deletions(-)

-- 
2.20.1

