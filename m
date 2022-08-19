Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AFF45995A1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 09:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346903AbiHSHBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 03:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346889AbiHSHBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 03:01:10 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D8EE0FE9
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 00:00:59 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220819070057epoutp0490c7b95270df3681a935d4dc22f8583f~MrOPlSRb80448404484epoutp04I
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 07:00:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220819070057epoutp0490c7b95270df3681a935d4dc22f8583f~MrOPlSRb80448404484epoutp04I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1660892457;
        bh=7k3ZxzxB6crH2mIdm+4xsxZYtcaYa2jA+zI29yT4jrQ=;
        h=From:To:Cc:Subject:Date:References:From;
        b=e4nCcHYyTEAuKSJ6S3Z+0G9Gx+julB9teyeMxDcKqYVwpYY7RcEvwGIyE3/MLnRUr
         m0Chhlwnv6eGFFVCOLTPJYlJbi9QrYA15lLS2C3wWuxdiF2ooPJMp87wsYn65hyrfg
         EbFGXUXjlBVnJGMkdIIohVkbzknOVRurbhVTWndk=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220819070057epcas5p4b08b53c9cfeac499d19f8d2f5eb8540e~MrOPUhDy_2224922249epcas5p4i;
        Fri, 19 Aug 2022 07:00:57 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4M8CMV2JzQz4x9Q0; Fri, 19 Aug
        2022 07:00:54 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E0.5E.09494.4253FF26; Fri, 19 Aug 2022 16:00:52 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220819044619epcas5p27ba774aacaa5d2a0056bba376b9dae54~MpYsYfUBp2185421854epcas5p2E;
        Fri, 19 Aug 2022 04:46:19 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220819044619epsmtrp1034d84e576cbf839db1228d4ce97cd35~MpYsXpImQ3048930489epsmtrp1i;
        Fri, 19 Aug 2022 04:46:19 +0000 (GMT)
X-AuditID: b6c32a4a-201ff70000012516-c4-62ff352468f1
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        5E.FC.08802.B951FF26; Fri, 19 Aug 2022 13:46:19 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.109.115.6]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220819044618epsmtip22d59b8ce2b18633b66ad201616bc4cd1~MpYrIUNuD1162911629epsmtip2N;
        Fri, 19 Aug 2022 04:46:17 +0000 (GMT)
From:   Tamseel Shams <m.shams@samsung.com>
To:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        lee.jones@linaro.org
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        alim.akhtar@samsung.com, Tamseel Shams <m.shams@samsung.com>
Subject: [PATCH v2] pwm: Fixes dpm_run_callback() error in pwm_apply_state()
Date:   Fri, 19 Aug 2022 10:04:59 +0530
Message-Id: <20220819043459.32584-1-m.shams@samsung.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkk+LIzCtJLcpLzFFi42LZdlhTQ1fF9H+SwckZ7BYP5m1js7j/9Sij
        xeVdc9gs7t5dxWhxt3Uxu8XPXfNYLG5PnMzowO6xc9Zddo871/awefT/NfDo27KK0ePzJrkA
        1qhsm4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23zBygK5QU
        yhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUltkqpBSk5BSYFesWJucWleel6eaklVoYGBkamQIUJ
        2RmbfjazFszgqpj/fhVbA+NKji5GTg4JAROJTRvvMHYxcnEICexmlLi/9B4LhPOJUWLtzwvs
        IFVCAp8ZJa7dtoPp2LbvDBNE0S6gjtMNUO3NTBL9W1qBHA4ONgFNiePnuUEaRARCJBZ27mUD
        sZkFqiUW/foOZgsL+EisOncebAGLgKrEmj+HWUFsXgELiWXzD7FCLJOXWL3hADNEXFDi5Mwn
        LBBz5CWat85mBtkrIXCPXeLZ/3csEA0uEnt/7WCCsIUlXh3fwg5hS0m87G+DstMl5j7shaop
        kFi26ztU3F7iwJU5LCD3MwPdv36XPkRYVmLqqXVMEHv5JHp/P4Fq5ZXYMQ/GVpT4v7sfaoy4
        xLsVU6Du95C41HOQDRKIsRL/2+eyTGCUn4XknVlI3pmFsHkBI/MqRsnUguLc9NRi0wKjvNRy
        eLwm5+duYgSnRS2vHYwPH3zQO8TIxMF4iFGCg1lJhPfGnT9JQrwpiZVVqUX58UWlOanFhxhN
        gWE8kVlKNDkfmJjzSuINTSwNTMzMzEwsjc0MlcR5va5uShISSE8sSc1OTS1ILYLpY+LglGpg
        mvBW1WFTsSH7l599Lnc1BT5mZyfFP11RpFZz+oaS9olavtmBzUeZ1Uot+A46yV9ScenWMOte
        N0/h7XmpnVOO1de7ih75uMZP/sqS0wYsV2rrdLfsvrW+a9+zZ4e4vj+K/yi+wtpst0p22I3A
        Jacan7ovvZXNKr53aeWbfeV/L1wtYrSuOZ7qzut0QWiPrmrw2Szbuil3tx9Qd/9R99qp58b3
        1Nwu4XR1kfpTbEJxMvrGm9SaY2Y88NnxadPVWEmX3sJNlk3b1zD/VJjxTDIy+/Uube0Xe75Z
        LLvwX6pCq/XwI0lertdOCwqLM9Y8tPlwev/MXTdnd6i5f1YMbvtz2Uj7jqjO2hD9XrfaMgVT
        JZbijERDLeai4kQAfZUhOhQEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrELMWRmVeSWpSXmKPExsWy7bCSvO5s0f9JBrc3ilo8mLeNzeL+16OM
        Fpd3zWGzuHt3FaPF3dbF7BY/d81jsbg9cTKjA7vHzll32T3uXNvD5tH/18Cjb8sqRo/Pm+QC
        WKO4bFJSczLLUov07RK4Mjb9bGYtmMFVMf/9KrYGxpUcXYycHBICJhLb9p1h6mLk4hAS2MEo
        cXHfPnaIhLjEtF/7GSFsYYmV/56zQxQ1Mkn8XnWetYuRg4NNQFPi+HlukBoRgTCJ5hkbmEHC
        zAL1Eou28oGEhQV8JFadOw82kkVAVWLNn8OsIDavgIXEsvmHWCHGy0us3nCAGSIuKHFy5hMW
        iDHqEuvnCYGEmYFKmrfOZp7AyD8LSdUshKpZSKoWMDKvYpRMLSjOTc8tNiwwykst1ytOzC0u
        zUvXS87P3cQIDmYtrR2Me1Z90DvEyMTBeIhRgoNZSYT3xp0/SUK8KYmVValF+fFFpTmpxYcY
        pTlYlMR5L3SdjBcSSE8sSc1OTS1ILYLJMnFwSjUwRUpdPDRhWfIWk/pJ5VNVtQ4841EOzX1V
        WSirkjDZao7blIfKQc4X7/nY/Z5peXBqsnlpb1iAiYWSzMlpu4S3Vdyds28tw0EPzTr/t/xO
        L75767gX8vlcs9k62aG1cPo9BeP6b1+SNjEKlf6S1FH/Pzl01YSWx1WHzUx6r4mdPdafnLwk
        Zct302t/DWWOzCrNbY5s0Uux+upyneXsTvmz5w/LKGddYVW61rD8W2Jnm+O9D6o/3N/c3fCF
        0XKx2G0tt0tp9nOYnR//2XdqVy4ff/Ghaw4Vqm3Fyz9OXv71/4ejm/akHpSeYlbFKTiF98CH
        j109Z/8eFFKvnsB3Kkdbyr3h7LdJfWUfZrfYL0hYpsRSnJFoqMVcVJwIAGK/0X7VAgAA
X-CMS-MailID: 20220819044619epcas5p27ba774aacaa5d2a0056bba376b9dae54
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220819044619epcas5p27ba774aacaa5d2a0056bba376b9dae54
References: <CGME20220819044619epcas5p27ba774aacaa5d2a0056bba376b9dae54@epcas5p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return invalid argument error from pwm_apply_state()
call when 'period is not set' or 'duty_cycle is greater
than period' only when PWM is enabled, so as to fix the
dpm_run_callback() error seen on exynos SoC during
Suspend

There may be situation when PWM is exported using sysfs,
but at that point period is not set for PWM. At this
point if we do suspend, then during pwm_apply_state
function call from pwm_class_suspend, it checks whether
period is set or not. It is not set now, so it returns
an invalid argument error which issues dpm_run_callback()
error

Suggested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Tamseel Shams <m.shams@samsung.com>
---
 drivers/pwm/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index c7552df32082..10b4e39aaac0 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -634,8 +634,8 @@ int pwm_apply_state(struct pwm_device *pwm, const struct pwm_state *state)
 	 */
 	might_sleep();
 
-	if (!pwm || !state || !state->period ||
-	    state->duty_cycle > state->period)
+	if (!pwm || !state || (state->enabled && (!state->period ||
+	    state->duty_cycle > state->period)))
 		return -EINVAL;
 
 	chip = pwm->chip;
-- 
2.17.1

