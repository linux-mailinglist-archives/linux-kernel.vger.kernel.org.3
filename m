Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0725507962
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 20:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352819AbiDSStc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 14:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233057AbiDSSt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 14:49:29 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36B82898D
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 11:46:45 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id a186so11523132qkc.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 11:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Bv5IZFxxycj4VF9FAHiGL9YNhUERdck5XbK5n8+IdIs=;
        b=bnX3/vIz1XDgHxx0IH8H6MmEN6xrCRGbplySBz2ObO5yuuHCOln2dH3v1bvlBAWjxj
         ewK4BB9rObmaEOfnXdxrW/RbUnbLQsTsKMRF672HDZ848QjMdKA35HksGdKs7IoCBXcR
         HqYT3Vh/zXrj/WZuC+fwqSPJYaaQHOSYHBcn78+DQA3KoYz75NYyhJMpFShN++PuDdlK
         O4BDcS5WEhwg4/eu47gx7ws2jZt2EO8n3H5v+UUVqwG7cA7G1vgWPViM2shgLH+i8DZh
         S2qjmU46Kla5OisiZaGHTgPBi3k5wYyP4/8CmB6M2aqqbzdmRkeCDVzfoTTl/ikEpk7X
         f+GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Bv5IZFxxycj4VF9FAHiGL9YNhUERdck5XbK5n8+IdIs=;
        b=oal5axbUo5bYth6gvG6ztDT89EbCqWnQuAZqKBixZUu3xxacxRtEvAcyHKVzo4DX6V
         mSjUsYeU7pp6Tqh0w8Kg1YISiDEF0hyxBWGFQwO21wT1dqU99Wh7dWchicD3Ubr+gQSc
         2gVu43TCzFL37bWCum2JpE/y+ap/FFZqSdywXHseXQwuBW/k34bcJFhOf0xjkJJNoEeW
         BZLy0k3lqrQYwx4ApDETmSH7jcGKt2Jceo783w2qfqKEVS3y3BvWW8Mm28Gw8V/8N0fn
         K7QLYB+Oh4jx9rdRdq2zjclzCALKBPUU2X+RNwu+2zNED9ZkI1RNUmqBGUB5K4rpYBtz
         gfHg==
X-Gm-Message-State: AOAM532OldQcbGYGc5mqY2Ny9VyxCJAW1S69x0H29rJjUXWHHfIEdwGZ
        YGB0p1oX/55HsS0DX3z+k1GvCg==
X-Google-Smtp-Source: ABdhPJyvmV/AcmqMuj3TZiiT4bhBUz+woYja1eJmuuglieCujllahRMw2zgZZ72XgOkwu8uNXl27Vw==
X-Received: by 2002:a05:620a:2902:b0:69e:b906:7078 with SMTP id m2-20020a05620a290200b0069eb9067078mr4659211qkp.717.1650394004432;
        Tue, 19 Apr 2022 11:46:44 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id b13-20020ac85bcd000000b002e06856b04fsm502592qtb.51.2022.04.19.11.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 11:46:43 -0700 (PDT)
Date:   Tue, 19 Apr 2022 14:46:43 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Nico Pache <npache@redhat.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, aquini@redhat.com,
        shakeelb@google.com, llong@redhat.com, mhocko@suse.com,
        hakavlad@inbox.lv
Subject: Re: [PATCH v3] vm_swappiness=0 should still try to avoid swapping
 anon memory
Message-ID: <Yl8Dk+a1YDwupLMv@cmpxchg.org>
References: <20210809223740.59009-1-npache@redhat.com>
 <b5575449-08a2-2901-e7e1-a97150e4878c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5575449-08a2-2901-e7e1-a97150e4878c@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nico,

On Tue, Apr 19, 2022 at 02:11:53PM -0400, Nico Pache wrote:
> I think its is important to note the issue we are seeing has greatly improved
> since the initial posting. However we have noticed that the issue is still
> present (and significantly worse) when cgroupV1 is set.
> 
> We were initially testing with CgroupV1 and later found that the issue was not
> as bad in CgroupV2 (but was still an noticeable issue). This is also resulting
> in the splitting of THPs in the host kernel.

When swappiness is 0, cgroup limit reclaim has a fixed SCAN_FILE
branch, so it shouldn't ever look at anon. I'm assuming you're getting
global reclaim mixed in. Indeed, I think we can try harder not to swap
for global reclaim if the user asks for that.

Can you try the below patch?

diff --git a/mm/vmscan.c b/mm/vmscan.c
index ba19edbc2452..0aa929151386 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2729,11 +2729,9 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
 	}
 
 	/*
-	 * Global reclaim will swap to prevent OOM even with no
-	 * swappiness, but memcg users want to use this knob to
-	 * disable swapping for individual groups completely when
-	 * using the memory controller's swap limit feature would be
-	 * too expensive.
+	 * For cgroups, swappiness=0 means never swap. Historically,
+	 * cgroup users have relied on this as it was cheaper than
+	 * setting a swap limit of 0.
 	 */
 	if (cgroup_reclaim(sc) && !swappiness) {
 		scan_balance = SCAN_FILE;
@@ -2754,7 +2752,7 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
 	 * If the system is almost out of file pages, force-scan anon.
 	 */
 	if (sc->file_is_tiny) {
-		scan_balance = SCAN_ANON;
+		scan_balance = SCAN_EQUAL;
 		goto out;
 	}
 
@@ -2767,6 +2765,12 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
 		goto out;
 	}
 
+	/* swappiness=0 means no swap until OOM is imminent */
+	if (!swappiness && sc->priority) {
+		scan_balance = SCAN_FILE;
+		goto out;
+	}
+
 	scan_balance = SCAN_FRACT;
 	/*
 	 * Calculate the pressure balance between anon and file pages.
