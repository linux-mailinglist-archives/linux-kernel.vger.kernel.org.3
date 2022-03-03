Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7DEA4CBD7B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 13:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233135AbiCCMR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 07:17:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233126AbiCCMRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 07:17:23 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E6D15F087
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 04:16:34 -0800 (PST)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220303121627epoutp027d4e13a8d55a12fb998c31728ead2055~Y3geVsPfR2806828068epoutp02E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 12:16:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220303121627epoutp027d4e13a8d55a12fb998c31728ead2055~Y3geVsPfR2806828068epoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1646309788;
        bh=abFjtJPmEoNg2ozi6aQR10wX7+g3Ea4YNi0vgPlcFMA=;
        h=From:To:Cc:Subject:Date:References:From;
        b=BnAyYPLkLQPBA8d6bngGpO/2KFxUJ0MvXtau2S/l6dpMTcs5Zry3ATEircssFjk7h
         EXqm9ZZXGCcLbi92bIqLhIEmcln1N/eKftpjfTXHCbxKPge2Gdp0Pyj83h//bN4CG2
         t/4owBHjX5WttKrqMhSSkcs5YoTZBP8gFw8x93Gs=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220303121627epcas1p197895b85371cf654c64b695047453d23~Y3gd2XTS70702807028epcas1p1M;
        Thu,  3 Mar 2022 12:16:27 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.38.241]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4K8VMZ0Gxjz4x9Q2; Thu,  3 Mar
        2022 12:16:26 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        80.2A.08277.991B0226; Thu,  3 Mar 2022 21:16:25 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20220303121624epcas1p3781f58f2f04b0a26c35311aa0f4defcf~Y3gbZajmP0976309763epcas1p3T;
        Thu,  3 Mar 2022 12:16:24 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220303121624epsmtrp1e909b922805652a98179a2635067cee0~Y3gbYdir71144211442epsmtrp1t;
        Thu,  3 Mar 2022 12:16:24 +0000 (GMT)
X-AuditID: b6c32a36-203ff70000002055-5f-6220b199474b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5E.28.29871.891B0226; Thu,  3 Mar 2022 21:16:24 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.98.193]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220303121624epsmtip2117f5f63874145e0e41c807665ac1538~Y3gbKDcA30633506335epsmtip2J;
        Thu,  3 Mar 2022 12:16:24 +0000 (GMT)
From:   Huijin Park <huijin.park@samsung.com>
To:     "H . Nikolaus Schaller" <hns@goldelico.com>,
        Jean Rene Dawin <jdawin@math.uni-bielefeld.de>
Cc:     linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-mmc@vger.kernel.org, letux-kernel@openphoenux.org,
        Ulf Hansson <ulf.hansson@linaro.org>, tony@atomide.com,
        huijin.park@samsung.com, bbanghj.park@gmail.com
Subject: RE: [BUG] mmc: core: adjust polling interval for CMD1 
Date:   Thu,  3 Mar 2022 21:16:16 +0900
Message-Id: <20220303121616.2285-1-huijin.park@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFJsWRmVeSWpSXmKPExsWy7bCmvu7MjQpJBlvuW1q83HuI2eLHtq9M
        Fh0XXSwe3LvEarH1zyU2i8u75rBZHPnfz2gxe0k/i8X+K14Wx9eGO3B5fPs6icVj56y77B5r
        3p9i9rhzbQ+bx79j7B4tk3axe/RtWcXo8XmTXABHVLZNRmpiSmqRQmpecn5KZl66rZJ3cLxz
        vKmZgaGuoaWFuZJCXmJuqq2Si0+ArltmDtCBSgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJb
        pdSClJwCswK94sTc4tK8dL281BIrQwMDI1OgwoTsjK3THzEW3NWpOLLrDnMD4wrlLkZODgkB
        E4nX3/4ydTFycQgJ7GCU2HRlJjuE84lR4u6c08wQzjdGifnHfzDBtFy/eQKqai+jxM+zBxnh
        Wo72nmIGqWIT0Ja4vnYrI4gtIpAosbepnw2kiFngCaNE+5MNrCAJYQF7iS2Td4GNZRFQlXi1
        9w0LiM0rYC2xpukcC8Q6eYmZl76zQ8QFJU7OfAIWZwaKN2+dzQxR85Nd4tY+aQjbRWLd2ylQ
        vcISr45vYYewpSRe9rdB2ekSGyYfhaopkFgxdw0bhG0s8e7tWqCZHEDzNSXW79KHCCtK7Pw9
        lxFiLZ/Eu689rCAlEgK8Eh1tQhAlqhKLr35khbClJQ49uMsIYXtI3N0EcbGQQKxEy4P3TBMY
        5WcheWYWkmdmISxewMi8ilEstaA4Nz212LDACB6ryfm5mxjBiVTLbAfjpLcf9A4xMnEwHmKU
        4GBWEuG11FRIEuJNSaysSi3Kjy8qzUktPsRoCgzeicxSosn5wFSeVxJvaGJpYGJmZGJhbGls
        piTOu2ra6UQhgfTEktTs1NSC1CKYPiYOTqkGJnMWJWXOU6uCQud/29p3TDLD/snN4kL7jXtb
        pguqPS3879w28cy6cOnDP49WvPBz9Cvm23BlReQb+zeLLh18tLSzc39q7d3bR+JUg7ovfZ0Q
        sGOv4u3Iummrfby3P294LMIWazlrlmL4OddDW35Epa40nWCfsLiOS6pgQmhj6PKrdgLfLCMD
        5JTnPFsZ65DheODuzNzLIcvUpN93FhzXZ3q7WXLuoQdqTLnHHjXwH9DdyrOiSGhWlt1aqXvW
        cX5fNkd/U10X8PfXh4DGQ2KZCyus7e9E5jGeKk7cmmMtoR6gxa5+93Xx1AUF3KsbWuzXdaY1
        LuUub/q1RG3jkv2bb2ksnpzleV7i5b9J2+Q9pyqxFGckGmoxFxUnAgCT8vt/LQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOLMWRmVeSWpSXmKPExsWy7bCSvO6MjQpJBr+eqlu83HuI2eLHtq9M
        Fh0XXSwe3LvEarH1zyU2i8u75rBZHPnfz2gxe0k/i8X+K14Wx9eGO3B5fPs6icVj56y77B5r
        3p9i9rhzbQ+bx79j7B4tk3axe/RtWcXo8XmTXABHFJdNSmpOZllqkb5dAlfG1umPGAvu6lQc
        2XWHuYFxhXIXIyeHhICJxPWbJ9hBbCGB3YwSLesMIeLSEu92XmftYuQAsoUlDh8uhij5wChx
        4p00iM0moC1xfe1WRhBbRCBRouviNaYuRi4OZoE3jBLTL00DSwgL2EtsmbyLCcRmEVCVeLX3
        DQuIzStgLbGm6RwLxC55iZmXvrNDxAUlTs58AhZnBoo3b53NPIGRbxaS1CwkqQWMTKsYJVML
        inPTc4sNCwzzUsv1ihNzi0vz0vWS83M3MYLDWktzB+P2VR/0DjEycTAeYpTgYFYS4bXUVEgS
        4k1JrKxKLcqPLyrNSS0+xCjNwaIkznuh62S8kEB6YklqdmpqQWoRTJaJg1Oqgela055pn/h4
        JsTrm19okfl49ENIovf5+BkCAZYlN+YE/d+3JNIw2vmWw3ZWl+RMWd64SwyaE5hmc/itzXjV
        EMKwPdPv0LYbxhNSFQ91Pntk/s/ih4X1dSXHkK2eohJrZC/nyK6brZlvcPSJvxnLQ+ZXka7n
        L62sndmr1pBjcnXJc0d/kxm+s36Vn+n1/HVL74jih9kfPd69sRKffi9Oo0Zt3+LTT5mnv9LK
        Xqn6uvfi7YdFc0IsWTx5P0vH3fj1j/Pd7doXzse4n2h8cNha9lbos9OcVezPH7w5KZb+Z4nQ
        GesLfnN4RRewe9Y0rj6mG35OU4p7s4kEn65/bfSsNROD3jz/yK3V8/6EB/My1adKLMUZiYZa
        zEXFiQCvnwGk2gIAAA==
X-CMS-MailID: 20220303121624epcas1p3781f58f2f04b0a26c35311aa0f4defcf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220303121624epcas1p3781f58f2f04b0a26c35311aa0f4defcf
References: <CGME20220303121624epcas1p3781f58f2f04b0a26c35311aa0f4defcf@epcas1p3.samsung.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, sorry for the late reply.
I guess the problem occurs depending on the eMMC model.
Because I tested again and there was no problem.
The eMMC model used for the test are as follows.
(THGBMJG6C1LBAIL, KLM8G1GETF-B041)
Anyway I guess the cause is interval time.
I wrote a debug patch assuming that the reason was that some mmc models
could not process CMD1 delivered at short intervals.
I copied the polling function and adds interval minimum time parameter.
I set the minimum time to 1ms. You can adjust it.
Please test if there is no problem with the debug patch.

>Hi,
>
>> Am 02.03.2022 um 09:20 schrieb Jean Rene Dawin <jdawin@math.uni-bielefeld.de>:
>> 
>> Ulf Hansson wrote on Tue  1/03/22 14:38:
>>> On Thu, 17 Feb 2022 at 21:12, H. Nikolaus Schaller <hns@goldelico.com> wrote:
>>>> 
>>> 
>>> From: Ulf Hansson <ulf.hansson@linaro.org>
>>> Date: Tue, 1 Mar 2022 14:24:21 +0100
>>> Subject: [PATCH] mmc: core: Extend timeout to 2s for MMC_SEND_OP_COND
>>> 
>>> It looks like the timeout for the MMC_SEND_OP_COND (CMD1) might have become
>>> a bit too small due to recent changes. Therefore, let's extend it to 2s,
>>> which is probably more inline with its previous value, to fix the reported
>>> timeout problems.
>>> 
>>> While at it, let's add a define for the timeout value, rather than using
>>> a hard-coded value for it.
>>> 
>>> Reported-by: Jean Rene Dawin <jdawin@math.uni-bielefeld.de>
>>> Reported-by: H. Nikolaus Schaller <hns@goldelico.com>
>>> Cc: Huijin Park <huijin.park@samsung.com>
>>> Fixes: 76bfc7ccc2fa ("mmc: core: adjust polling interval for CMD1")
>>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>> ---
>>> drivers/mmc/core/mmc_ops.c | 4 +++-
>>> 1 file changed, 3 insertions(+), 1 deletion(-)
>>> 
>>> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
>>> index d63d1c735335..1f57174b3cf3 100644
>>> --- a/drivers/mmc/core/mmc_ops.c
>>> +++ b/drivers/mmc/core/mmc_ops.c
>>> @@ -21,6 +21,7 @@
>>> 
>>> #define MMC_BKOPS_TIMEOUT_MS           (120 * 1000) /* 120s */
>>> #define MMC_SANITIZE_TIMEOUT_MS                (240 * 1000) /* 240s */
>>> +#define MMC_OP_COND_TIMEOUT_MS         2000 /* 2s */
>>> 
>>> static const u8 tuning_blk_pattern_4bit[] = {
>>>        0xff, 0x0f, 0xff, 0x00, 0xff, 0xcc, 0xc3, 0xcc,
>>> @@ -232,7 +233,8 @@ int mmc_send_op_cond(struct mmc_host *host, u32
>>> ocr, u32 *rocr)
>>>        cmd.arg = mmc_host_is_spi(host) ? 0 : ocr;
>>>        cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R3 | MMC_CMD_BCR;
>>> 
>>> -       err = __mmc_poll_for_busy(host, 1000, &__mmc_send_op_cond_cb, &cb_data);
>>> +       err = __mmc_poll_for_busy(host, MMC_OP_COND_TIMEOUT_MS,
>>> +                                 &__mmc_send_op_cond_cb, &cb_data);
>>>        if (err)
>>>                return err;
>>> 
>>> -- 
>>> 2.25.1
>> 
>> Hi,
>> 
>> thanks. But testing with this patch still gives the same errors:
>> 
>> [   52.259940] mmc1: Card stuck being busy! __mmc_poll_for_busy
>> [   52.273380] mmc1: error -110 doing runtime resume
>> 
>> and the system gets stuck eventually.
>
>Same result from my tests.
>
>BR and thanks,
>Nikolaus


From c2458cb998dd8e275fefba52dd2532beb153c82d Mon Sep 17 00:00:00 2001
From: Huijin Park <huijin.park@samsung.com>
Date: Thu, 3 Mar 2022 20:43:22 +0900
Subject: [PATCH] mmc: core: extend timeout and set min time for op_cond

This patch extends timeout to 2s and sets minimal interval time for
checking op_cond stuck problem.

Signed-off-by: Huijin Park <huijin.park@samsung.com>

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index d63d1c735335..ccad6379d183 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -21,6 +21,7 @@
 
 #define MMC_BKOPS_TIMEOUT_MS		(120 * 1000) /* 120s */
 #define MMC_SANITIZE_TIMEOUT_MS		(240 * 1000) /* 240s */
+#define MMC_OP_COND_TIMEOUT_MS		(  2 * 1000) /*   2s */
 
 static const u8 tuning_blk_pattern_4bit[] = {
 	0xff, 0x0f, 0xff, 0x00, 0xff, 0xcc, 0xc3, 0xcc,
@@ -179,6 +180,47 @@ int mmc_go_idle(struct mmc_host *host)
 	return err;
 }
 
+static int ____mmc_poll_for_busy(struct mmc_host *host, unsigned int udelay_min,
+				 unsigned int timeout_ms,
+				 int (*busy_cb)(void *cb_data, bool *busy),
+				 void *cb_data)
+{
+	int err;
+	unsigned long timeout;
+	unsigned int udelay = udelay_min, udelay_max = 32768;
+	bool expired = false;
+	bool busy = false;
+
+	timeout = jiffies + msecs_to_jiffies(timeout_ms) + 1;
+	do {
+		/*
+		 * Due to the possibility of being preempted while polling,
+		 * check the expiration time first.
+		 */
+		expired = time_after(jiffies, timeout);
+
+		err = (*busy_cb)(cb_data, &busy);
+		if (err)
+			return err;
+
+		/* Timeout if the device still remains busy. */
+		if (expired && busy) {
+			pr_err("%s: Card stuck being busy! %s\n",
+				mmc_hostname(host), __func__);
+			return -ETIMEDOUT;
+		}
+
+		/* Throttle the polling rate to avoid hogging the CPU. */
+		if (busy) {
+			usleep_range(udelay, udelay * 2);
+			if (udelay < udelay_max)
+				udelay *= 2;
+		}
+	} while (busy);
+
+	return 0;
+}
+
 static int __mmc_send_op_cond_cb(void *cb_data, bool *busy)
 {
 	struct mmc_op_cond_busy_data *data = cb_data;
@@ -232,7 +274,8 @@ int mmc_send_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr)
 	cmd.arg = mmc_host_is_spi(host) ? 0 : ocr;
 	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R3 | MMC_CMD_BCR;
 
-	err = __mmc_poll_for_busy(host, 1000, &__mmc_send_op_cond_cb, &cb_data);
+	err = ____mmc_poll_for_busy(host, 1000, MMC_OP_COND_TIMEOUT_MS,
+				    &__mmc_send_op_cond_cb, &cb_data);
 	if (err)
 		return err;
 
-- 
2.17.1

