Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C24058AD22
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 17:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240564AbiHEPkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 11:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbiHEPkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 11:40:20 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2F3F40
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 08:40:16 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220805154012epoutp016919660f3507da8a50d4e58ede93e2cf~IfRnRCv1f2765427654epoutp01L
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 15:40:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220805154012epoutp016919660f3507da8a50d4e58ede93e2cf~IfRnRCv1f2765427654epoutp01L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1659714012;
        bh=1KRJArCAT+ep/ZqI946ziMenS9TXxF6qtdKNWy2fqEI=;
        h=From:To:Cc:Subject:Date:References:From;
        b=KH2+yc7v/IeRjdkvWwZxZzGRUoPzmeB29FO8VtOwMRZ3vcbaqOE9pd8lKwqTOLsfo
         cXipTRmv1PoMMEaSdMqBddDPGKSCDuY6MhXFyP7oCqmqSUovpRO5MbrMPiAbflNuMU
         kiClHY5chRpR59FnWuD4iMa+0xvRaIe1O0cAgIcA=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220805154010epcas5p1070c746338851e012a8cbfe25f643ad6~IfRl0lb6O3137931379epcas5p1B;
        Fri,  5 Aug 2022 15:40:10 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4LzqY50Ldzz4x9Pp; Fri,  5 Aug
        2022 15:40:09 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D8.44.09639.8D93DE26; Sat,  6 Aug 2022 00:40:08 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220805102056epcas5p29f22d42c854bebe6d0301b56094cf3ea~Ia62-LEvj2537125371epcas5p2R;
        Fri,  5 Aug 2022 10:20:56 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220805102056epsmtrp2865cfe1989a42c16949630c802df6564~Ia62_ZtX72278622786epsmtrp2Y;
        Fri,  5 Aug 2022 10:20:56 +0000 (GMT)
X-AuditID: b6c32a4b-e6dff700000025a7-6e-62ed39d88104
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        46.93.08802.80FECE26; Fri,  5 Aug 2022 19:20:56 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220805102055epsmtip2d9f2564b6d8ac27eb117db43b8e85c09~Ia618ENVF1465614656epsmtip2S;
        Fri,  5 Aug 2022 10:20:55 +0000 (GMT)
From:   Tamseel Shams <m.shams@samsung.com>
To:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        lee.jones@linaro.org
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        alim.akhtar@samsung.com, Tamseel Shams <m.shams@samsung.com>
Subject: [PATCH] pwm: removes period check from pwm_apply_state()
Date:   Fri,  5 Aug 2022 15:41:25 +0530
Message-Id: <20220805101125.47955-1-m.shams@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIKsWRmVeSWpSXmKPExsWy7bCmpu4Ny7dJBrc32Fg8mLeNzeL+16OM
        Fpd3zWGzuHt3FaPF3dbF7BY/d81jsbg9cTKjA7vHzll32T3uXNvD5tH/18Cjb8sqRo/Pm+QC
        WKOybTJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOArlBS
        KEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTkFJgU6BUn5haX5qXr5aWWWBkaGBiZAhUm
        ZGdM27yNsaCZo+Lw+R+sDYyH2LoYOTkkBEwktvdMALK5OIQEdjNKzD3/mxXC+cQo0f5oBTuE
        85lR4uitPnaYloYNE5khErsYJT71t0FVtTBJPF92j7GLkYODTUBT4vh5bpAGEYEQiYWde8H2
        MQtUSyz69R3MFhZwlJh97CULiM0ioCqx+eJEsAW8AhYSGzc/ZIJYJi+xesMBZgh7HbvErGsO
        ELaLRNPUy6wQtrDEq+NboI6Tkvj8bi/Ub+kScx/2Qs0pkFi26ztUjb3EgStzWEDOZAY6c/0u
        fYiwrMTUU+uYIM7kk+j9/QSqlVdixzwYW1Hi/+5+qDHiEu9WTIE6wUOi/c4zMFtIIFbic/NJ
        pgmMsrMQNixgZFzFKJlaUJybnlpsWmCcl1oOj6fk/NxNjOC0peW9g/HRgw96hxiZOBgPMUpw
        MCuJ8P7c8TpJiDclsbIqtSg/vqg0J7X4EKMpMMgmMkuJJucDE2deSbyhiaWBiZmZmYmlsZmh
        kjiv19VNSUIC6YklqdmpqQWpRTB9TBycUg1M210tjX48jDhl9XdOUdbB57oXVsRNP7yBMcrD
        9RkDp/x+y2eBXn+W/bY8qWgn5TErwY07T+eRvKZUzh6R2QfdPLhltN52idVV3phktTRF15WH
        l2FvvEZF/5sj2V7Xn607GXfA7MTPd4J6+2zYSkNqFcxi9/ScKj32kOnb16zDZ3b5ZBYvLKq6
        ldHVN0fw2NFNl6MZ2Ob47tK1TnVbav+qJpzJsfx9wpkswcRCl7CkT6KGG6TUtNqzLlq3fUvT
        /ZEjGqUsP3/aRB5zw9CtWZPdFW6m1r/b2Sf4asFl1tKP/f6SNo/dnl+t1xOLvNj8xjZzRWmQ
        cNjUs7XLHq7lyv/sl5153mzvqgBHAWu1b0osxRmJhlrMRcWJALFpDorkAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDJMWRmVeSWpSXmKPExsWy7bCSvC7H+zdJBhteq1g8mLeNzeL+16OM
        Fpd3zWGzuHt3FaPF3dbF7BY/d81jsbg9cTKjA7vHzll32T3uXNvD5tH/18Cjb8sqRo/Pm+QC
        WKO4bFJSczLLUov07RK4MqZt3sZY0MxRcfj8D9YGxkNsXYycHBICJhINGyYydzFycQgJ7GCU
        6N07iwUiIS4x7dd+RghbWGLlv+fsEEVNTBJvJv5m6mLk4GAT0JQ4fp4bpEZEIEyiecYGZpAw
        s0C9xKKtfCBhYQFHidnHXoKNZBFQldh8cSI7iM0rYCGxcfNDJojx8hKrNxxgnsDIs4CRYRWj
        ZGpBcW56brFhgVFearlecWJucWleul5yfu4mRnAAaWntYNyz6oPeIUYmDsZDjBIczEoivD93
        vE4S4k1JrKxKLcqPLyrNSS0+xCjNwaIkznuh62S8kEB6YklqdmpqQWoRTJaJg1OqgSmcsfUL
        e9eyzx+ChSrchb3fKoqUFx0RD2MWOSc2o7RNd//1cMWqbTI1r17GybJetpXfpsm0L3SHb0KA
        y/mb7X1lNf63bAI53W//PvZ4XsbSPgNfdzuxyuevOC67n326dkqwgnzS1gdf/kfI29ewXXfe
        Fv6moO/K6ioJbeuPrpeiJMpcDV9HnkhPCiidISu6QPNUokJL373AraU+KXWHmkUK2exmMf2b
        FLhYYx7bwfpgeaElPTz6ibFVk48ZsPS0ZERen/hOkrs52vRp77keZ+PfWk/2i8tN3RN4qHGC
        w7J9d/Z80guzceiLK3hRFN4xMcpnwqkNtzwOf1RO+L7q1L/5BbN7njVvPLbxab2SEktxRqKh
        FnNRcSIAZ7N2948CAAA=
X-CMS-MailID: 20220805102056epcas5p29f22d42c854bebe6d0301b56094cf3ea
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220805102056epcas5p29f22d42c854bebe6d0301b56094cf3ea
References: <CGME20220805102056epcas5p29f22d42c854bebe6d0301b56094cf3ea@epcas5p2.samsung.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There may be situation when PWM is exported using sysfs,
but at that point PWM period is not set. At this situation
if we issue a system suspend, it calls pwm_class_suspend
which in turn calls pwm_apply_state, where PWM period value is
checked which returns an invalid argument error casuing Kernel
to panic. So, check for PWM period value is removed so as to
fix the kernel panic observed during suspend.

Signed-off-by: Tamseel Shams <m.shams@samsung.com>
---
 drivers/pwm/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index c7552df32082..69bca7f82398 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -634,8 +634,7 @@ int pwm_apply_state(struct pwm_device *pwm, const struct pwm_state *state)
 	 */
 	might_sleep();
 
-	if (!pwm || !state || !state->period ||
-	    state->duty_cycle > state->period)
+	if (!pwm || !state || state->duty_cycle > state->period)
 		return -EINVAL;
 
 	chip = pwm->chip;
-- 
2.17.1

