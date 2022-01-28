Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B49EB49F82D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 12:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244316AbiA1LVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 06:21:12 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:36610 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229919AbiA1LVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 06:21:10 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20SAmY8o015087;
        Fri, 28 Jan 2022 11:20:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=/KVq8F7H2YHWnnebdvpkhaAac+zupkwZpGAJOQ7+xo0=;
 b=qPpn/CN86q83kqLPs9Tuqe9pDYkQ8jdXGHC8fe2T4RfUv8xnny6LGPvjnPRtbxl5RrtJ
 xmJN24iD57CO5w7Frn98tY6cgcgSY6LsjqxpkScoO44ejXR4fSz6FGTHayAAe3kFeNDE
 JYQYwuFkgHObDLosP5fJ73uvEAZLuy0ZalNF21k36lNAbWce+p+1py75KWepnqoDT4+I
 OsxBGn1sgkPkbT9BsjYHrGEG2yWCYUqXuI51YMmdnYRhhbfM4tCIvw4hV8MrhYuTSIXL
 nBcbHmjlE7KMva5K3bnTyWT/nCp646V9eMQSLSyGN0OcpNO+qwxVfKQANMK8Fm39Mkp0 tg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3duvsj2xwy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jan 2022 11:20:24 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20SBHBbZ013265;
        Fri, 28 Jan 2022 11:20:23 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2168.outbound.protection.outlook.com [104.47.73.168])
        by userp3030.oracle.com with ESMTP id 3dr725dakx-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jan 2022 11:20:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bvNaxUeLZITv3+vALurWDcbqZC0TY7S077HLcPvyG34fYi6qFFuYma2Z4Mo6tHTMO/ZuJgTEA/lQMfTd6J27hMDwkZer5cwJvOO+uboN96vAmZZp6zVTfhXfBXO+jhp9+/tcMuk79+w5c1uIOEj8QB6VPReBX6njFDsHq8roH0G9ylEXG6wi8nxiBdRPGbIf+6tNZmV4falr3ICEekpKo6VqS6BcCYP4l0plbQzHtlLLqJxO04ApOPsu1S3HedcetvDU4uXeYQoFqqZ9FR+qJEuL7fACZCYnhg2X1gsnPxuMFSkV708xvXpiQFqysA8hcCP09DejOr+tsqlU9bjmhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/KVq8F7H2YHWnnebdvpkhaAac+zupkwZpGAJOQ7+xo0=;
 b=PRtZE/tvsXLKGwrm10KWIRomFZSnFnG27f4Xc1GTgv7FQ405TtfIdOO+t3jK+5VKyqYXN0dT7eOFMcsaz0Db2+PnfVWlV32vZuXZrK6GGTtaUsiG1RqAldD9cHTEe8CCYVkscVYPWkvhlgRw+opbdpNIKaNUWzTlZgKqnjw9H3pni0HXU5S22m5vPmWesFijDeqZ33zcAONLaz+mEu6Z12pQ02qEaOBH5bEJ+8IA5Z47QjI3379cRyFIy/qFFfI+Ea59I4GRRZxqit7ZbPZO0dZ+Cywiabs5yq1tYi+hADLJgDBorFBPjhwTNHTDXytPfkTut2wk6HRcfRiP2FR5rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/KVq8F7H2YHWnnebdvpkhaAac+zupkwZpGAJOQ7+xo0=;
 b=LXxDsGjSUzeEsIWejmhI/0wCK+6+6NpXzVXatScDwWIXH/Os8Bm1obttapUdjWwISDK9jTvJKLEg0ihCLHEraJsNxwlRXtjvFv42Ai7/KI5s+T3y8MX1QPeaQBJp9/1a/L14MiyH1PS34l6bO+OGV0t7gfFtsaw36Q80ai6paqI=
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32) by BN6PR1001MB2097.namprd10.prod.outlook.com
 (2603:10b6:405:30::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Fri, 28 Jan
 2022 11:20:19 +0000
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::cdcc:584:3514:f052]) by CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::cdcc:584:3514:f052%5]) with mapi id 15.20.4909.017; Fri, 28 Jan 2022
 11:20:19 +0000
Date:   Fri, 28 Jan 2022 14:20:07 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Liam Girdwood <lgirdwood@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH 1/2] ASoC: ops: fix signedness bug in snd_soc_put_volsw()
Message-ID: <20220128112007.GA24806@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0021.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::8) To CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c738eeb5-8601-45b2-c6e7-08d9e2502a86
X-MS-TrafficTypeDiagnostic: BN6PR1001MB2097:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1001MB20975A4EB2C2E003877BABD98E229@BN6PR1001MB2097.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AZYJXfn6FH4IygNQXRQiENYqwLUtGSPGk3Oke2N2iZyoLvxyWCwN1WZhyea7zTJmaRPje6+DveUNy4/B20QIXiCdiqXPYnMirM2122UIwQP4uZZ3BS07pYpDauB3eHJXb5YRynTTPEgbWruq5n6T4aYfi8VfMEmXwx7Sxxl8Kjsd/gS7xE6NNi5634gLzvLQnJepc4DHl+wA+xLIUtzoRJ2BUS115cuKJV+X3n3lFGAURL7DbsiuMY0ER1fCfrazasMzpCFRYvj8mv6/eYdhjQlQZ8KJiAU4FcE1fbKfuH34MmPG7Kz//O1V1Kntm/3jx4MfNueQhoAXwr8IBXGjs4BzbqvlSryK9Hf9RfIP9xXjEN4UDZPHSUvqszujD4fxEgg0UvMx7foFe3V++oQaecEcHnEsAMl1ThV+68blv2dkhLlvJ8gEgjhNfa4pb1Be/ry/SqVtrodnQI6TLN82ciyNzwlGc+NqGihqIuPfiD4Lb6OyK6a31q9jyopCGcLI44E1nf5H1g11LbqUONmOeA3U3lIYoUKRZQUfTuf5L0hhXpXpR6iJNfJwh7eNHWg0hdW82EvaQM6yqaq7w+r1boV35xTLbSpO373jOkGgM1U+f0j2AWoP6OL5ia1SqpBf1S/hsFsYjqKetQXWf83jE1YHnTZLiTQD3/QfiobG69Ow8lTbsHzy3MlFDFvCV8ThMW2W6PWgReTQeHHqmB6swQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2358.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6486002)(6666004)(4326008)(8676002)(508600001)(8936002)(316002)(6916009)(33656002)(54906003)(66946007)(66476007)(66556008)(1076003)(86362001)(83380400001)(44832011)(38100700002)(4744005)(26005)(5660300002)(38350700002)(2906002)(186003)(9686003)(6512007)(52116002)(6506007)(33716001)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6PnzJE2wwQCSlMwfqaYY3XI0pk5I5rIWG/2Qk6PwPOzdRALM5QE9YvGw91Bj?=
 =?us-ascii?Q?oxWn8fHi041nsHaOJ8gRb1iGD4X+O52o+BJ2b99Wi1pEaA00gwUraDx9sI5I?=
 =?us-ascii?Q?hBOucJMsTJMVwPbAQ4DPtSpeus4DIWavfkZS21bODfpjtwFrdWUegitjoC28?=
 =?us-ascii?Q?glOtg3+3Q04WDF7HLcXvzB9pEVvq22eYlP1uOItrx4zOBxhmKu9dpLD3uPi3?=
 =?us-ascii?Q?yP2zy/SyloMOO99HBeTUxyta2npppY54gtFShfouDae00Q3nnKlD5G697mUs?=
 =?us-ascii?Q?O+0DCS43hReoBmhTwkL5kKIyNYWpXcrwLDmbN3aa7g4Lo64dulKP9F6szWwL?=
 =?us-ascii?Q?xWJFm+ubMjNb0yRlxM/Gnv3nuskaV9Lueoa4bWPReZeniNQPYSIBlETZJi1W?=
 =?us-ascii?Q?hlm0R5TyK1NP/DEOUiI9+N7c4N8ptnrTwsceRq2pg3CHAHZXIfB1YYqf1S9Z?=
 =?us-ascii?Q?ZlweS9tD3mlIDeLyuPhMSFpXbcExq5443Bx2QMlpol6JusbSEMay98sOSIIO?=
 =?us-ascii?Q?dm+kn0VeoLsqWtLAdz+DFyAA25h2R19W9gh2JGOiOaJvaYC6kCb48QQzSqao?=
 =?us-ascii?Q?sxmoiVreeQtbeEUwGC4kZybJviJbbDLRfuzS3qxRHFpM3Ksoka9fzU0gRSmg?=
 =?us-ascii?Q?tQ9JfiLLeknMeDIjdi9uAWaLqSrowbN/A9yZtbhqUny0+f/j2M9mm/q12wym?=
 =?us-ascii?Q?KAS2aCQdDjjYMKnAB4M5AY8KT4emfnmmezDWI9ZqZ+osOmnTsC70OJ0VFHIL?=
 =?us-ascii?Q?CZ3dqMvYjVKHAbIh2D1sPb9dbkR1ZT1NBLkED7XqPuHMBBl8f4rueCQmRrWH?=
 =?us-ascii?Q?EwVPb+OVlA0dogEUOIhL6vZV228kVLsBTpnRDErc1AHBweObMBzaSHFI73+X?=
 =?us-ascii?Q?v/1EVYQ3tHYIcxGhcSYdVPOLnHy0Enu/8orWrnObLdqGy2e3xNJoGBWUYRp8?=
 =?us-ascii?Q?DVKxwp3RioQ2Vyh9bu9S1k01wsZzcXVV+viY5DlxJ8H0dOI8SP4CDhocgzoj?=
 =?us-ascii?Q?50HTXliGBM3EyCnfSTy1Fh7S/+dyugwPWkNWfaDFpcrR8Hyg7bPH8qwxWh5P?=
 =?us-ascii?Q?SlnP4/D+2CC2078eca02lgwnzokKgVpL+uvBiRD+tw1j8UkU2iyY7f2PMU0T?=
 =?us-ascii?Q?do1JXkRqXAT4DI+Xw0YCnAQ7wMlZK3bqSxkuT40Txwgb2MP2ZSnwQCv0QHRA?=
 =?us-ascii?Q?xYYDo5vgvU4wzP98KzE40rqQ8Yo3kCQ/rN3DULTPqP54t9KbHx+7kzoISwNr?=
 =?us-ascii?Q?bNUMeg9qbWnV1ggFqtDvhTy349J+BXnRgqG4Q/8J/i65Wpkt8DfpyLfnN69r?=
 =?us-ascii?Q?amUFZfhEmcEMkUFv6kkJAQemZe6Lu7wJEK0ZplwAFAwPZkxmB25q7j4ZZCYs?=
 =?us-ascii?Q?q+X8AvgKWCjd5vr1Z7YwdKgqt/MvQGmosaqVZ57OrgOf5eirI96x0/5g7pps?=
 =?us-ascii?Q?rKk1Wpl2SZF1u8mVR5ibvSxSQoPRPz66GnyS9g8FUroAEsvWkUA+v+yqkpR5?=
 =?us-ascii?Q?+jgzH5PGSXzvL7AfMh0Usw4pl9DLF2cD4kEbNbe6OQAgI4uwZgToLgbyIG/A?=
 =?us-ascii?Q?XBozsXk8vFTbQEgSHCfQZTf+cbMhH7a4uMQr/5F8RUKOa1IDp9F82tvK5sFI?=
 =?us-ascii?Q?/jT1GYnIhlqVZonfTlvVWJCLG5HEz304rVBXbJx45seuyumPmS1gY9y34CW4?=
 =?us-ascii?Q?SuFJthTPfFNWEBf5LkO3TuLU458=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c738eeb5-8601-45b2-c6e7-08d9e2502a86
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2358.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 11:20:18.9935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ae9rLlyqiQJqwcx/YOL8Qpkfqkg7acYdrIIO+kcV6WcfOmLcdM+QIoaPeiNLc1eSlzaFtYRVC5zcCOgw56BjlwpA5I7TCMDa4G2qj5B6Jaw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1001MB2097
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10240 signatures=669575
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 spamscore=0 bulkscore=0 mlxscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201280071
X-Proofpoint-ORIG-GUID: 4mxksvCo6O9nVJp_HBUcSLFpZpy0yV9S
X-Proofpoint-GUID: 4mxksvCo6O9nVJp_HBUcSLFpZpy0yV9S
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "val" and "val2" variables need to signed for the checking to work
as intended.

Fixes: 817f7c9335ec ("ASoC: ops: Reject out of bounds values in snd_soc_put_volsw()")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 sound/soc/soc-ops.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-ops.c b/sound/soc/soc-ops.c
index dc0e7c8d31f3..0091fa96eb48 100644
--- a/sound/soc/soc-ops.c
+++ b/sound/soc/soc-ops.c
@@ -310,8 +310,9 @@ int snd_soc_put_volsw(struct snd_kcontrol *kcontrol,
 	unsigned int invert = mc->invert;
 	int err;
 	bool type_2r = false;
-	unsigned int val2 = 0;
-	unsigned int val, val_mask;
+	unsigned int val_mask;
+	int val2 = 0;
+	int val;
 
 	if (sign_bit)
 		mask = BIT(sign_bit + 1) - 1;
-- 
2.20.1

