Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0C852104D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 11:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238238AbiEJJJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 05:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiEJJJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 05:09:50 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2128.outbound.protection.outlook.com [40.107.215.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31254134E1D;
        Tue, 10 May 2022 02:05:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E0sOWwxjurtJGcobvF04yhstpBg6Ho1vQEOB93mDjvQz8jRz0x0ds4VdoA+d2HICxS0Uj72PQQATW3QE/BJlU7XD5wTaNxlQlNj74disB0b1S2JN/3ySouctrJSF0BGF65/tl/T6AbwjBL83G5oC1laxDJigTsAaLtEuU12RIBXqBncAjW+/aXvWtT3cTejps/GV24LJ0N/TbGXTn4qM0imtDRejjfOooXRBJm+LWUm9VhQo8UxkC8QZMv6sNnslrxImB0fGqkUDYq37EjnPTe13OGx78xsQGBE9trdP7HW/AHxlt9OkanKP/RYkSze2erTmPGHcBGTysH26zYI3mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UmUC5R1tirUXlP2zRfo+4hhr0QDc4+w7x5drh9r2ht0=;
 b=DPzXnLfWBRqAdu5UFT6/e/gHkVdMG8uU1uAWg+vig8643djh7XTWtFo74ayRyU3E2Bx5/cMr0awipL0uuVz7M4anQ2foQrIBszPvHzJPt721UidACgNuetwl+L451qL58IeGtA70vC4hfvanFmRO26smtDeaig1KTHc+tT6FlgAHpoTHAVPDG8sfya68J3qMQtxwVFqo1h8eapOMlzGZLK+tiTjcvDA1syeUKovU5fM+Nl11UJeZfvtu5J3veAKC5PAZ3EtCGI/UAzTFlj8/NAmC1w5xL8CFUZ8sj5jlqV/iZYJy2FaIoFagwT58Zb7FSLcJ6KeEYSuNffNAnFRwsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UmUC5R1tirUXlP2zRfo+4hhr0QDc4+w7x5drh9r2ht0=;
 b=o1nMKyDJmTNKdtek3P16BjnMldfWjiuobWitnip0MwynRLA+z7EiH5TZEaPFAmPzZjeA0HOA+dacM5Ka/M9HNmrlNblv7JbsUCfAyxq625S+hFozk1mpTQoGUT0Pis9CgM+4mlm3WE04u7QL+e9EDOoVljK++sMMOXK2W6XX2xY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19) by
 PS2PR06MB3446.apcprd06.prod.outlook.com (2603:1096:300:6e::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.18; Tue, 10 May 2022 09:05:49 +0000
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::4591:4f3e:f951:6c8c]) by SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::4591:4f3e:f951:6c8c%7]) with mapi id 15.20.5227.022; Tue, 10 May 2022
 09:05:48 +0000
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jia-Wei Chang <jia-wei.chang@mediatek.com>,
        "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH v2] cpufreq: mediatek: Fix potential deadlock problem in mtk_cpufreq_set_target
Date:   Tue, 10 May 2022 17:05:31 +0800
Message-Id: <20220510090531.12438-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2P15301CA0017.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::27) To SG2PR06MB3367.apcprd06.prod.outlook.com
 (2603:1096:4:78::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b9d3bf69-9364-4ad7-f164-08da326445f8
X-MS-TrafficTypeDiagnostic: PS2PR06MB3446:EE_
X-Microsoft-Antispam-PRVS: <PS2PR06MB344637EC25D93AE641191117ABC99@PS2PR06MB3446.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f6SAScIBQfJoXQ8Z6H3rIfTZrGDarWp0r1Ny636F4QJQiN3W2OOu+4AVZV3zbPb5f9HI42ywskLewCAHcFTd0KNnDHZxMrtxwSFylXSOhIt5Fivu96yUM0cComXvmsdY6Gfrw0GlXsmcRZU955qmV1RJix1AJw8TIXU1VU11PV873ESkiq87c+g+Eb58j1X03WF3VdYCCn74prX4dp2FQXvPxlSNq4BIFin7rSRq/IcOi0V58LB2+V2YE30CrlEFZSSi476uD6lv0l9k7fqN0jJE7yaei0bFGkTLWji1MJEFLPkUAbiiJnha2uwAuNm1ztLz0kTG8usqHFuLL0JuliNRth04CK7gn5vPwDkydtFc8YO8/rvWVBO/LxHFyVgnbr5BK0ppnAFEWVtM+o8kfrnH7a69IMk5VDz2tXsObIjGVy1j2yCqrH78yGXAeT38lWW6Bz3VYFodS+ACXNsB2kgiLRQMlfBjqwK5idDlwhWAD46/P7RssogLCa52rirklxnhmJ0eJ7CJanLCT1cwFAEbCggx1yDVdfV8RrfQW8Ctb8XQcP5bsPaTcxE1b99FXlWPflIPP0WfgQGrmQA0ewvtsA2xubAb+RJFwi6x2dQaQ/jfy65CosNicIZbMJDf366LUodt8vX9K6SYXxJ4PpRbo4BU5lCExXYCiHqwGKsmQN0JSsPYx/csehSgojHiNNkIC/lpOoqwlLgOXfzIiCoZiRA2AdiCYAZePbcyf7Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3367.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38350700002)(38100700002)(83380400001)(6486002)(2906002)(186003)(5660300002)(7416002)(36756003)(1076003)(8936002)(316002)(107886003)(4326008)(8676002)(86362001)(110136005)(2616005)(66476007)(66946007)(66556008)(6506007)(26005)(52116002)(508600001)(6666004)(6512007)(921005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R4EiN7VwgNBwZCjuH/sWz0n6SDKzRNjtIls4T2FAu/z9jSz8HWysEOhTC+hu?=
 =?us-ascii?Q?QssL5KDnyr9AUACMG2/JAdB/E5ErC3RWomGIE4fvk9NeG7DBxRWFI0LQiYNl?=
 =?us-ascii?Q?8RY9xW3ihHBi0K2DUfwJIyD313MHKoqvOwiBjtLM0iHE1yjxgoNDiMwYehjy?=
 =?us-ascii?Q?hlpmN+24mwiKAb2MX1VVwCdU7wLzzwx9a120BVXU7NXGuH0Cvo/a4MoL6MYI?=
 =?us-ascii?Q?GWDrmOkRwtQpybUw9vg9xnsonyLFIP22LjXnm6BpV/M/29HnYHlvQFqgrH+7?=
 =?us-ascii?Q?WSwA66gKZP4cadm0sVd+gLuVRKP8FWLo5mGEaVm/PZxhZ6rouEdQHKhc297R?=
 =?us-ascii?Q?GsYlPrir93e/oz2rwld2nf0W2E661WvVrrnJiHAOuSCI8PphcXvwjKFGQLv7?=
 =?us-ascii?Q?cWwrSuns5Fcz5w9nRTStVC0n12o34y1NWl62n0FcurYs3u6YHJhrq5yAL+23?=
 =?us-ascii?Q?clrM10E5UOLrVNNLRQ6Z3U9CsOQk2os6GekKZ2GDJuU1W/Ue6TJklWM1JwwO?=
 =?us-ascii?Q?rx13pkvOYZUWnQWmKJLwoXIpBktYwBKhfMf9D4n1lhETR4+GQqQ6nAOudOxQ?=
 =?us-ascii?Q?BPDFr03d5frqpLrQHfXSlxpZlIKsVRmkYDppgM/Q9E7s8ed+EhxylxSIVYJU?=
 =?us-ascii?Q?ymbJfu3wWXVnkFcHCj3MspCWIuw67iR3WN4HbfW3VdZnK9+ZH6+xccmsTeOV?=
 =?us-ascii?Q?opam9jkJZPCNUYIA1r/DKs7h1++V8FJOBFkDoNGtzirbhDjcVxzs9JpErSoQ?=
 =?us-ascii?Q?U6sEfPYB1MBilErgRksZziO5hzD8upjaOO4GybPUazHWi7KE5l4RG8GkPI/K?=
 =?us-ascii?Q?IXNmXgEP3Q8h/5H7dZRPYBbJdZU/cBXv81+933I+uRpohIfNLmoSUn5lbOyf?=
 =?us-ascii?Q?L66qRtAC3CAJvTohX+mLjVeG7BghsruQ9v16RanqBdAO87j3n7d0ku2rBTbY?=
 =?us-ascii?Q?klyp6VQg5r6JWbVMjw0QbF381FxjnYlQqxJtJNiLMiDJh9V1GKBVYScWyV9O?=
 =?us-ascii?Q?AvKIRdwtqmeR8ph67ywTOku9t2AuFNcyo95AHWz1epb0lCL6669BNVof7Lz7?=
 =?us-ascii?Q?bkQUelcXuBG/su6TXNXHJAeByzTbdgigSuiPdVDiIqghjrhXFa+P1TUbGLn0?=
 =?us-ascii?Q?iXbiaIa8quIsab/In5UilIo1cS3RVEUYDSfUs8+/xEeUajzFNekrZrs8sz2X?=
 =?us-ascii?Q?H9csTRjR9rb3eoYSMmaX76FqyFNHN0KtyZpQMWdCH6Y91qmNtO8/FZ4Kr7df?=
 =?us-ascii?Q?8SwT2emvlrNcF2KusGoJCmh/MdGAWsQGfYuBaEnaPjyL25w/3Cb2TMebIN0t?=
 =?us-ascii?Q?1F2sZQGFWrxSWN1Y+N9InVVY4iPKB7TvDUIVmCYQcGgUbBax89qYCY0aiMzU?=
 =?us-ascii?Q?4AEiHBt3F8m4Rfq0dSs63E3St8ky+kKUUAWtWDrCOBCrrZwD6vPXr9OkTjaU?=
 =?us-ascii?Q?0Csw/1L8mLzrl/Ouarhro/qP0ygdEne4kNlkkS9NQScWdIaUTd0GEbswLByK?=
 =?us-ascii?Q?cbt5dC/+cUzHJB1kaNpATARfupGSWNFnoh14fWcOhyXmPMkpxIMPNXMfUsSM?=
 =?us-ascii?Q?u+3toLFRduWJrvP29xX/P04WVdNH6rdPehc/PLeWyk+pEFXhMxeRVhUVkDcr?=
 =?us-ascii?Q?J/GD9Mi3hlc+Ddc3O6nuYpfyndnaaKwjmRPgbh7ctFjjm8Z1hgsQieE9aptg?=
 =?us-ascii?Q?191xEiipGhB0Zuy4mmKVlY98jeu1OA07q2g2ejmGb0ySTevyyZE6N9nMMwfB?=
 =?us-ascii?Q?W75PRcxpPw=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9d3bf69-9364-4ad7-f164-08da326445f8
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3367.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 09:05:48.4657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3K+AgikgQPr0rRFqH/2CwbxNU7T2VOqpxDZz+HmbPMgVFvihy5JcAPEFFll8GNQm9kJbRBnPs+BepBI5r7HxLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS2PR06MB3446
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix following coccichek error:
./drivers/cpufreq/mediatek-cpufreq.c:199:2-8: preceding lock on line
./drivers/cpufreq/mediatek-cpufreq.c:208:2-8: preceding lock on line

mutex_lock is acquired but not released before return.
Use 'goto out' to help releasing the mutex_lock.

Fixes: c210063b40ac ("cpufreq: mediatek: Add opp notification support")
Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
Changelog:
v2:
- Fix a typo in 'Fixes' tag.
---
 drivers/cpufreq/mediatek-cpufreq.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
index 75bf21ddf61f..4c6d53c99d79 100644
--- a/drivers/cpufreq/mediatek-cpufreq.c
+++ b/drivers/cpufreq/mediatek-cpufreq.c
@@ -196,7 +196,8 @@ static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
 
 	if (pre_vproc < 0) {
 		dev_err(cpu_dev, "invalid Vproc value: %d\n", pre_vproc);
-		return pre_vproc;
+		ret = pre_vproc;
+		goto out;
 	}
 
 	freq_hz = freq_table[index].frequency * 1000;
@@ -205,7 +206,8 @@ static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
 	if (IS_ERR(opp)) {
 		dev_err(cpu_dev, "cpu%d: failed to find OPP for %ld\n",
 			policy->cpu, freq_hz);
-		return PTR_ERR(opp);
+		ret = PTR_ERR(opp);
+		goto out;
 	}
 	vproc = dev_pm_opp_get_voltage(opp);
 	dev_pm_opp_put(opp);
-- 
2.35.1

