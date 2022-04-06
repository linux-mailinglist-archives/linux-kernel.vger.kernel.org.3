Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC544F65E4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 18:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238090AbiDFQv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 12:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238252AbiDFQvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 12:51:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C52B9192353
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 07:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649254519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B/9v7EvyeQVdxL6+ycCK8oWp79yiagX56JF400xUvCc=;
        b=LXUjjDGJtTmqMt0GJLI5Q43ethg/b/Gj75Put7hvykFZSk2lKuXVWvDoRjR6gJKwB5JYNK
        2jZtdgXGoWwBgwK3TU23AqK1QGNrhn7Su3YrE62ce7xosp1CIkgivM8G1rlBLljk0q5Pfq
        cvL9Iabeg40WURbSh46NKqz3tK9/xM4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-115-Grn5-yD9OJCGvla4H8h2fA-1; Wed, 06 Apr 2022 10:15:18 -0400
X-MC-Unique: Grn5-yD9OJCGvla4H8h2fA-1
Received: by mail-wm1-f70.google.com with SMTP id c19-20020a05600c4a1300b0038e6b4a104cso3017837wmp.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 07:15:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B/9v7EvyeQVdxL6+ycCK8oWp79yiagX56JF400xUvCc=;
        b=jTMOtipfSHcq3nXFbvgUVkeikeGePIYg4X6vXup0YaMUmf4tUIp26PSomgOblzFG6B
         +gDMaI0/ZZ8GGQSN6M+tnSfBDyEMkBx8+m793QmpaKrfU3Pbv2165uDZKzxZVdi+zR6t
         uw/6a2RUoNI5vTEWFkrpIVZ7CIMEtc+GYht9qpJcluvwJQ+wMkfTfVis64LiC7KAUlq2
         4/+WpUyTJfvEZcA5cLiRWEPpRrbqKi5rW7qcm/4CO3R0Z8m8/uy4TWdnaFXkVo+tmwhh
         yX1hyxNrpSJVMVE2TLJq6UmZBO4FJdqiY8VAr5ilvIkz0bYkcQzSmcQq7L9juFBDas/R
         3tag==
X-Gm-Message-State: AOAM531IpdK6wmlwrivOb1L8XQpVDd3QZueo9WEpA22XfblzriRYkx1g
        BxN97YmzAVX7hzNUpI7fUMTW5U7xFWR4fr0++MbmRASQqVYqfw9EOsvpOg8+uQs92AarzECBrij
        Rl5KFgwvr4VggodTDnNG+GIcCIdVwi2FIA5+WYoTj7DOBqZgVvToZg3LaFkDJVImMKPu/aNt0gf
        8c
X-Received: by 2002:a5d:60c9:0:b0:204:aca5:8379 with SMTP id x9-20020a5d60c9000000b00204aca58379mr6681792wrt.341.1649254517485;
        Wed, 06 Apr 2022 07:15:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy4kY6R9V8y3Ut31Z5CfSKmgCaI1oXgfkZiXihzO3ODREQOnSj1JAAnC8f7AmJ1BEaSKmYijg==
X-Received: by 2002:a5d:60c9:0:b0:204:aca5:8379 with SMTP id x9-20020a5d60c9000000b00204aca58379mr6681763wrt.341.1649254517237;
        Wed, 06 Apr 2022 07:15:17 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id p15-20020a05600c358f00b0038cc046cb2esm7708788wmq.32.2022.04.06.07.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 07:15:16 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Beata Michalska <beata.michalska@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH 2/2] mailmap: Update my email address to @redhat.com
Date:   Wed,  6 Apr 2022 15:13:15 +0100
Message-Id: <20220406141315.732473-3-vschneid@redhat.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220406141315.732473-1-vschneid@redhat.com>
References: <20220406141315.732473-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've brok^D contributed to a few different files in my time at Arm, so
get_maintainer.pl spits out my name from time to time when it's using the
git stats. Make that show an email address that's actually in use.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index b9d358217586..b76882fcc14a 100644
--- a/.mailmap
+++ b/.mailmap
@@ -391,6 +391,7 @@ Uwe Kleine-König <ukleinek@strlen.de>
 Uwe Kleine-König <ukl@pengutronix.de>
 Uwe Kleine-König <Uwe.Kleine-Koenig@digi.com>
 Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
+Valentin Schneider <vschneid@redhat.com> <valentin.schneider@arm.com>
 Vinod Koul <vkoul@kernel.org> <vinod.koul@intel.com>
 Vinod Koul <vkoul@kernel.org> <vinod.koul@linux.intel.com>
 Vinod Koul <vkoul@kernel.org> <vkoul@infradead.org>
-- 
2.27.0

