Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB15957D358
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 20:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbiGUSd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 14:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbiGUSdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 14:33:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 089408C8F5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 11:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658428427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=quhFz4gGH0xfvarNeNysI11WJviAvfVFHvmam3NVT50=;
        b=XOiSyaus3mjTZZhbjEoiucgMNCByYrNsu0gwYhHpZGE/g5WWfAHOWjr1urt3rntWrZqFmc
        cU0zzwMdWHy4MWFXX3fCqJ5jUVQzIfiXkFeiHFjM4syhRJpBwhCLyS9bZla5O4yuGbF8p+
        g2XUyZzEeYzvf73UjdD63RkHKkIfToQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-414-HErC080NOXyMN0HrxbdcdA-1; Thu, 21 Jul 2022 14:33:46 -0400
X-MC-Unique: HErC080NOXyMN0HrxbdcdA-1
Received: by mail-qv1-f71.google.com with SMTP id kf2-20020a056214524200b0047415dda691so858701qvb.22
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 11:33:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=quhFz4gGH0xfvarNeNysI11WJviAvfVFHvmam3NVT50=;
        b=u1KtaRH0QOxiYWKkPp9sYZsrXDJlxNgOGCTKzHpvA0VDFcfeYvCKX07KRayTCzd7lx
         YrspXvVF380pmMzaF7Qrao10ECQ2OfEtez1ptg+xA4SOzLxdQfzS+SoxSufsVBW4y2YZ
         ElgLZ706RMcR5Z2eUVbX669sp7c0knlhRUbn7/5Wv0vVfrtkYpt6klR9hDmbfUJqh2MV
         n3k4WXntMLwFogpnwXP9ZY1atsMWLPeMhvC6TMOlroFzarZWcnRan4A6HgfL5l4gsLXp
         pKgJljr+FTXbn9hyXav7ODo4ESlAH5eCJyccX1OttLxy8a+1VQca1z4uPTFAChxJ6HQx
         OMEQ==
X-Gm-Message-State: AJIora//Mbnr0covr1tI+U7xcYuesipidgiHn8HwmiKh3WyZvLi+/Aam
        wB2luXw6ewnlLPF5bNRkn6OCLUtbTWxUvPxzs9rCbBqungak3rxaWytdrOAQ325lBMHfVyjbJsC
        C8MXRIbToOJlCouYAbJvYFwH6q2h/MmvKYZzit0B3t/0tXF5tRtrlrAXdSx0JLzVEG8jD114AUw
        ==
X-Received: by 2002:a05:6214:f05:b0:473:7b68:9260 with SMTP id gw5-20020a0562140f0500b004737b689260mr34525349qvb.124.1658428425489;
        Thu, 21 Jul 2022 11:33:45 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tvb8TUeowvOxwU8I5sXozry1HgFCrP+vE/vSto9el3jflZahaStoUgfz1OjskwtsB9cHZe4Q==
X-Received: by 2002:a05:6214:f05:b0:473:7b68:9260 with SMTP id gw5-20020a0562140f0500b004737b689260mr34525326qvb.124.1658428425228;
        Thu, 21 Jul 2022 11:33:45 -0700 (PDT)
Received: from localhost.localdomain (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id bj9-20020a05620a190900b006a6a7b4e7besm1878519qkb.109.2022.07.21.11.33.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 21 Jul 2022 11:33:44 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Nadav Amit <nadav.amit@gmail.com>, peterx@redhat.com,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: [PATCH v3 3/3] selftests: Add soft-dirty into run_vmtests.sh
Date:   Thu, 21 Jul 2022 14:33:38 -0400
Message-Id: <20220721183338.27871-4-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220721183338.27871-1-peterx@redhat.com>
References: <20220721183338.27871-1-peterx@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/vm/run_vmtests.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/vm/run_vmtests.sh b/tools/testing/selftests/vm/run_vmtests.sh
index 2af563a9652e..de86983b8a0f 100755
--- a/tools/testing/selftests/vm/run_vmtests.sh
+++ b/tools/testing/selftests/vm/run_vmtests.sh
@@ -190,4 +190,6 @@ then
 	run_test ./protection_keys_64
 fi
 
+run_test ./soft-dirty
+
 exit $exitcode
-- 
2.32.0

