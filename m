Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7A446E859
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 13:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237323AbhLIMZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 07:25:13 -0500
Received: from mail-sgaapc01on2091.outbound.protection.outlook.com ([40.107.215.91]:8353
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231833AbhLIMZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 07:25:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LYDh6c3pwwufVYsZJr9s9FBarPg6V0I/lGK6rQRFnsta9z9jHtqpqvm3KtZgZsBfRfSvgxeoCqu9JrppnMNi2x9lesFBoxjjkDEcgZDg/HmkQPMCnd4m4SUgllgTK5BhSCaJu4YO3Qf4CWymYijwpcUYmNaTNK9TtgWFu5oDq3QxYJNqy1P1RvhWJ/Rk8Uoira+/lmcQQ9yenjKOlUNfiZ44ArgGeei/Byq0NWOb7yJVEIlxfy1vMRq7dNbZW92s74OZSWrP4IfeF4VNgFQKCaCsOuj2eCzKGYUp+QwQm7jVNtgEQvV+D0e7U5CC7/AxMY45/53vahSPykOrw4tCWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=59GP2WHQ8BxU7YSSYYCBFKIN0oDj9Og0UxaceOAvRpk=;
 b=Gc4HXTOJ6V9G2F5S5zBcUXKEIZUJb8oUSCq+/CC2UJL6exsuUYGBfrhL0lFXKKfd6OrssrizfRGyOtTYdFKdKWr80zJambmolUiyLQX7TJVokuJB6VfEeBs4wtGWt6lUTFPpAgNCfdQXtzvc9a4K3bYZ168dVcAmoIYR06Wg6+kmqPRrju2hoYe/K3Ap/c1QX0KFHZjM2T5u8FaQYQmeFg8iWUwfYFkkp/AXIN7L009DfNeDnVc31TSsvu9TBsOMPJXzclAIPnA+H32/kZsLSYaTVB1IrUvN8MgLhY0csvJmmjPIDQwAvouJE79uuZATIxmL/h/luNXL9EMiH8N0pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=59GP2WHQ8BxU7YSSYYCBFKIN0oDj9Og0UxaceOAvRpk=;
 b=hdUO7cDf31xkXNBsT2Pcx9oaeaMkuhZhFzHDfTAhjgsYYP/+z73OER9bMEHX1iMav31AWAryqsdHnv16lrMA3RVdNKKDRhKYgCj9WPd5693u5lv6X4YW5nK1N71a+J2N96lvG7tXyz1moKgDTiZbZ1na+ug9EgOyAUYx5hnPG1Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SL2PR06MB3180.apcprd06.prod.outlook.com (2603:1096:100:34::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Thu, 9 Dec
 2021 12:21:36 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::a0cf:a0e2:ee48:a396]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::a0cf:a0e2:ee48:a396%4]) with mapi id 15.20.4755.023; Thu, 9 Dec 2021
 12:21:36 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] cpuidle: qcom-spm: add missing put_device() call in spm_cpuidle_register()
Date:   Thu,  9 Dec 2021 04:21:24 -0800
Message-Id: <1639052485-23414-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0054.apcprd03.prod.outlook.com
 (2603:1096:202:17::24) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
Received: from ubuntu.localdomain (103.220.76.181) by HK2PR03CA0054.apcprd03.prod.outlook.com (2603:1096:202:17::24) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Thu, 9 Dec 2021 12:21:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17cfd057-924a-4b2f-e2a2-08d9bb0e71af
X-MS-TrafficTypeDiagnostic: SL2PR06MB3180:EE_
X-Microsoft-Antispam-PRVS: <SL2PR06MB3180FE63E2032E1D57C0073DBD709@SL2PR06MB3180.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C22IWv2ZbdoLgCevmNwzbPCCudmHp3M82VEV7JxtwfNcB40ZOAmHI/3qTrRJvLlO4C0Ej1qov46ASiDxo8RGgLQNK4M/JjbgcVhNkVlpCV9rHA+znxQ6xUoU4uFeStJhvIQAmOdeOd0Pz+82oevCfQxchr61lbXD3F5RKex7utPDnvN4kzugNHOH9iVRdmqn8pVhKTOXxX0GEQyRS3EHCMc4EOlyfxgyPyzh4xw6lt0EORy6rkcDi6ZWFV5dgfymB7fn9ga4zHPFk1Ha6xS9i1m5swBPb+AouSCMmxgr94g51HsB+mSJP+5MiP7zQU2wMJa25alf0slHGh19cU1EPDOQ91hv5VqOqrfAhH3gq8d0yz17Q3ZcIIbZDRoySHbepzWVqFBuXKVuvHWG0Xa1Bzjh3o3Bax7wNjoQf92NLE+mXGvJmxboNhFDAdMgbgAX6rAyDvuEjL/l10Qfsw0VUNZ25G7+qUQZgWGdHIe+kJM3zAakf0EtYsAJeHlM+EJUFtVsR2+NfbkFlS38riRyljOnPEizlWW6o1tuKehy0QmH1xuTEvloM7sRVvyF8B/mP1TLqIjgq36PanQZD0fjxa9004cALAtywtaxeL+Qa4rq+08eK8Xd5SJMIYGlgab/uc45j/1KZPfpPPP+pxe9VHz44JxN307ju5OBrAML8qSfJsheLKtCYaTv43/Vkx45ns/Qw3Gw9n26VctnDxEamQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(956004)(107886003)(6666004)(83380400001)(4744005)(110136005)(36756003)(66946007)(6486002)(316002)(2616005)(4326008)(52116002)(6506007)(8936002)(26005)(186003)(508600001)(6512007)(38100700002)(5660300002)(38350700002)(86362001)(2906002)(66476007)(66556008)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wsFk6Zy0GgSZqU66BS6kX39q94Eox3e549UWtie0l2CcecuQS1ygARc7eoDL?=
 =?us-ascii?Q?4NlfpifDiuynsUDmIsvuh+ba4mvMGsN0sqCqA9k2+tSAhHPplpmxlgk4QwoM?=
 =?us-ascii?Q?EDhewcVD64tOhGzYWufnIi2xjsoYCuBE8ZVvslQYW7j/vr9EVvcePVk2qxsU?=
 =?us-ascii?Q?yJQyKdjOkWFqREwiKdohAWvE+n1ZI3Sg8yO+QQitBrnc/zoEdFhB5tql8rAG?=
 =?us-ascii?Q?qqwZ6nB2jm8Ze4jvu92YGNty2BiutEpQ5F4ISXDgHo6f369WBgGrMpPWF7tS?=
 =?us-ascii?Q?xhOtruqE9JXVIv/cjuF/BFxOP0pwx6CNtdQV22qHB8lWDqnvNlejo10bkqHG?=
 =?us-ascii?Q?PNBJFQA74wtC5KyvVWFCAQegwf77JeiYueC3qhO6dla6LQ2M682iokQP8WHT?=
 =?us-ascii?Q?4kYtx+5UXNXjOgW5b3Ygi4CSK9A23AF51MKClwNJcnZOmskZ3fIU+aKy4GJI?=
 =?us-ascii?Q?n0k+xbdXeqH8UrqL3rlSAei/CqN/ISfdbxkt8LvnRVyHDx6LECeJnIlT98//?=
 =?us-ascii?Q?bpaaWteBa9Yz//ZjynsI528r8YbCPgMaZsvf6TELvMSuF6OFHDgudcjryHKN?=
 =?us-ascii?Q?rCcdB1sOj59ISrgttaYdjRG+XPuWngK6RhKY7uwR/2OUZ3WuGgZ8L/Wfk0wR?=
 =?us-ascii?Q?fyN+CxIxKgrcDrxdLY3R4hv/OTYzzFMsQQUZbqjzEaVq+Wig6ClopMgiU6AB?=
 =?us-ascii?Q?0QmeUzTLp2i3TsM0HXPDogH8GbUy0HjxXbd684pJyM81Oaoi7LFKlXSY08E9?=
 =?us-ascii?Q?+8PpLWlAG11w2NFg202yYZR+olghePNXLZ49dPQRlrm/hKc3EKYv9pac/VKs?=
 =?us-ascii?Q?8uMSy7v+57ZXZs8Owes7dkubxjv/+sy+S9YuuIP4cokeYdfWGAz8wTmgg4BF?=
 =?us-ascii?Q?jq0tda4EetQ9WpW4mgsMg9S9LIUWvRwdNy3tDvmZymLQPj51s1XOxSf0EWrW?=
 =?us-ascii?Q?TdmbYDWPkdNj+dwP4/z+mFlT1Kv8gnPAzRK/rqfcwjkpJHhiqnr89HgLu6vH?=
 =?us-ascii?Q?TxlTd+/XPU4q5EqV94WzGyon7ZgpfS5lz/sy19/XVtms9O0xDghBjvQMLoMC?=
 =?us-ascii?Q?2whKYU/TdYTxSWOLDGFI15uDmPLauMSIvohZ2Jd+dsRu0VmZ8FfwmvnQYG4x?=
 =?us-ascii?Q?RbuG/rLaAeX9k5hkB8tjwV9+vAwyFZIb4HFm/mOT4XFcYjHbSf9P+dZLqG3V?=
 =?us-ascii?Q?TU9hZI5VOMdhzNkDINxDfGwVd1Y3aRUr64QJkM12HRNJZ4ZUB4/+fh3GvKFO?=
 =?us-ascii?Q?AVzg++ZDoVaoLKd+AaFoNvSFdImaTZBJ/0UXT0VuYeJiKtPY8Z/ub2aPLljU?=
 =?us-ascii?Q?BRRHNEGFDvba1CQ7CBCiI9KXjPk7lZ6KrF04aKvmEZaOnfuGI0EJozTak01H?=
 =?us-ascii?Q?DNJmOiPcSyzaVFR2BftMkUGfG4NpQOFChnWYjcNQaRhwhQsz8DegvIcgDve7?=
 =?us-ascii?Q?tGGZ5hsxSkQXuz1HB5XpqMcoOm18F4g55tyrTZZYwRQmHci7OnrirTqjR6Cv?=
 =?us-ascii?Q?B4TJLVJF6uxfVRF7uO2T2y2h4UdfLtNbIOglF7s0F5Nubqr+1HO48k+Xh69S?=
 =?us-ascii?Q?CVd9LaGQScN+/lDgbx3mHAT1xCwRINda6v36k4QOpGSbsANXBOUV4QDENAhS?=
 =?us-ascii?Q?P6F3g34weFr0t89guplLIe8=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17cfd057-924a-4b2f-e2a2-08d9bb0e71af
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 12:21:36.2701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JXjyhdHzk7SWBuIUqvOjg3qR3fa3tg+FnhawpJIx2oSCoI6Nh8C1rfnCxhj0FWVqA6UOGtqCud5Slu/nlQ932g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR06MB3180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Qing <wangqing@vivo.com>

of_find_device_by_node() takes a reference to the embedded struct device 
which needs to be dropped when error return.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/cpuidle/cpuidle-qcom-spm.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-qcom-spm.c b/drivers/cpuidle/cpuidle-qcom-spm.c
index 01e7791..6638c1d
--- a/drivers/cpuidle/cpuidle-qcom-spm.c
+++ b/drivers/cpuidle/cpuidle-qcom-spm.c
@@ -107,12 +107,16 @@ static int spm_cpuidle_register(struct device *cpuidle_dev, int cpu)
 		return -ENODEV;
 
 	data = devm_kzalloc(cpuidle_dev, sizeof(*data), GFP_KERNEL);
-	if (!data)
+	if (!data) {
+		put_device(&pdev->dev);
 		return -ENOMEM;
+	}
 
 	data->spm = dev_get_drvdata(&pdev->dev);
-	if (!data->spm)
+	if (!data->spm) {
+		put_device(&pdev->dev);
 		return -EINVAL;
+	}
 
 	data->cpuidle_driver = qcom_spm_idle_driver;
 	data->cpuidle_driver.cpumask = (struct cpumask *)cpumask_of(cpu);
-- 
2.7.4

