Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B36A5469568
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 13:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242896AbhLFMJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 07:09:24 -0500
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:53566 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237534AbhLFMJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 07:09:23 -0500
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1B6BpD0K029050;
        Mon, 6 Dec 2021 12:05:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=PPS06212021;
 bh=YEuidmRKvKp3Yns1z3C1Fm2BuIxgYYaUlIzR/CMaT/E=;
 b=eUSUc5jeoF8WCpZjaf7Hhvw6k3jF9xn//EVtzWsyFLszR+IRxZYg83wMDcCnvXUreouH
 zfSGKHku35i9/uT3Nvv8M3WW76yiNX/AN5I0zC53R/LGaDUYow9kF9AIOvSXIp8dM77/
 DCVcjMQUPZwFh6gfbIT1lW+XPpCXGU+288+rE9hugBv1k4TViyHgrFsQ8DulTX9QdYT1
 rWCkSTv2qoynFkZjC2aSAltAOjAME+yDxoH1fKl0n+8AX2f1VbjgFG5XnyNjW2v4x7y7
 DSYARicI7sx7QLQ5zEum6tOiVTUY73V4t/8d+HkEHy6iYPbJZvjYg6ehEJA6GCYaTF3R Rw== 
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2177.outbound.protection.outlook.com [104.47.73.177])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3cs9fq89vv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Dec 2021 12:05:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cjqriSj7TgnEiqqSF1nGWnhOxzBJJeKObPKshTMX5G2IA2DDCBD4X1pTVwJSzqxyFKpRmNdFzF3Oq86fEuGIi4kAZDliNWgj+/7+dLOCiMsFdhw8iQOnJDonj09gJDp27ztfvBr3PPU4WSbpE9DWDXTm//OfBN/XTJUszmXYJ4fkazHCGKxhdI3FZgXaC0rik7vu4fLuzgprK8LmMOfvxQS3m2SlMazFBzUOmk2UZjBpWhj8M9Xx52dcuEWEQYBraMSV26tOvnkVPfv7IHVgbpF1QipTD2s/Rt5LHPxt/0xQ4MH1rCW3oYSuMlCIMfF3JqbpFBlpL2qh/9ge3aEAOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YEuidmRKvKp3Yns1z3C1Fm2BuIxgYYaUlIzR/CMaT/E=;
 b=HEd1S+PlxNvAGmDy4yWowHLi6T4Q6Cdm330sy/6Qw6lrNbN/9VMo1uEVF9sQfiUZ7HF2itwxonERQEMHiQh4V2ZpmhVGKmCF4GHszZ/wiJ/85LTePcBUDVIS5IyhD5zzw3bMuwEhPKr+bfQNsPCML/X45H/EdHxU+dvXhuvA1jh98uoTByjHIWAYrzJ8uIsXHOSl4IEeXhBhYgCvMurQHiB5pHlH0loIBlho0YUB5/Ujc63C0d2nfXF0T4PyJnAJw7aM0szSEnvfzN9AJ0W6seQ051xuyIxON3cEgXA6H46lz8/YgmR3OPOgcYQ9RgxLInnahdQG95gIGXv6NwSmVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB5077.namprd11.prod.outlook.com (2603:10b6:510:3b::17)
 by PH0PR11MB5189.namprd11.prod.outlook.com (2603:10b6:510:3d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Mon, 6 Dec
 2021 12:05:50 +0000
Received: from PH0PR11MB5077.namprd11.prod.outlook.com
 ([fe80::5d3f:f38f:ee6d:b7f6]) by PH0PR11MB5077.namprd11.prod.outlook.com
 ([fe80::5d3f:f38f:ee6d:b7f6%9]) with mapi id 15.20.4755.022; Mon, 6 Dec 2021
 12:05:50 +0000
From:   Xiaolei Wang <xiaolei.wang@windriver.com>
To:     jens.wiklander@linaro.org
Cc:     sumit.garg@linaro.org, op-tee@lists.trustedfirmware.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] optee: Suppress false positive kmemleak report in optee_handle_rpc()
Date:   Mon,  6 Dec 2021 20:05:33 +0800
Message-Id: <20211206120533.602062-1-xiaolei.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0401CA0009.apcprd04.prod.outlook.com
 (2603:1096:202:2::19) To PH0PR11MB5077.namprd11.prod.outlook.com
 (2603:10b6:510:3b::17)
MIME-Version: 1.0
Received: from pek-lpggp7.wrs.com (60.247.85.82) by HK2PR0401CA0009.apcprd04.prod.outlook.com (2603:1096:202:2::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.19 via Frontend Transport; Mon, 6 Dec 2021 12:05:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36ff22d8-0817-44cd-e097-08d9b8b0be7d
X-MS-TrafficTypeDiagnostic: PH0PR11MB5189:EE_
X-Microsoft-Antispam-PRVS: <PH0PR11MB518902BD97CD90354451BB58956D9@PH0PR11MB5189.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AwQVdIi034E6+bYkNIF2vXP4zKPc5//Zm0w6tqRxksm0pS8VN2RKlVhy9EqwaVS8K7iNRXGrK+g1fs6WXawto1mcNOgEt1W1JghnTByIBCH4EtGUUDx+P72K68Oz/Yq+e8m4KQ9DyfZZc+dnQ0IaSio/znh+NQLuWbw8p6TYu4EYZR5AgHRojn4oJ/yDyKlZbLf5sNryXUHvO9fuK7g57ZLKoYWiOcRir31lKBRr+uKC8+Jqbw3c3//6gZCmnuAX38YmyCTSxLjC3/Z3UPUh2ZfG+RZgFUOyZfzsC335udsg3TX+hHTDusijiLBocwq//xp7AYmQrqPxV1elYvkh6FOwukaMBISetrRKe+ycpKnO7wgIYawFQRl5uKiSz1/+S0m9S9wdJa6RFOvLkERYNe2HP7HVH1k/hsJXLD9EONvrtjGSr6/z/fAZ/zhBJVL2GxDW/0VOHKGeWF62PAtq5lxxM4hhNv/dAzQLgokgF9d5wh/ASPCRShadl8SXC/UTqywf7SQ9/ZMPIzfRZwT2aHJO2OHUI7vNQMx3LTI39vgnUaWMEgawQwROAGJM8KrZ4VuNg3H2U5dDYA4wnRrBG3+SFgUm2+1Ir6pcKeVmDoVfdYdCuFto17x9v5kP0RXwsq8C1rq6dekzyCFNP24OAT3cvMfDg2yn7sXZVbLDF285SjN4/DhFQG9B9lTUrlIjf4Y7c74w8kq5FpIcHYkaSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5077.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38350700002)(38100700002)(956004)(2616005)(316002)(8676002)(44832011)(52116002)(6486002)(508600001)(6666004)(6916009)(26005)(86362001)(1076003)(66556008)(66476007)(36756003)(66946007)(6506007)(186003)(5660300002)(8936002)(2906002)(4326008)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HTRUTX5xgupsw8NTGy8yG7ySwWq2opkErPVzAQNmQvG1l44uj9jFRl4gNyBt?=
 =?us-ascii?Q?efWs87vc/lbhWQyCDpgjFn9DvA6yuGtnklwFAkPJK+zeNftUjbUKezRLwi5X?=
 =?us-ascii?Q?Sk5Q+9uOf6ceCCsx9l3t8fKaYXkTZZcWIp7c8sTfSpOEljDRhdqDZJHt0tMF?=
 =?us-ascii?Q?L4QvYD20vKt7ZmYT2YLjq1nTYJYKh2/rNTmXUF1delstJ9SyXjiGMMQGq2aJ?=
 =?us-ascii?Q?PsuH4O6KbHyztw46WX/wljOvESEoLqEwIBrXdONsP9aGaoQx03KYmpJmX1QK?=
 =?us-ascii?Q?EVMg7F+FKPS4dbAn4a3C43kBG9GLwxcvmPXXmAMjFBTn0EJA5C+zNx1G/76k?=
 =?us-ascii?Q?J4O/R+5OlRps0ZyThqCF/AIf49ojL16vc6oxIv7hj0Q7jiT65+dwIJQoPdIG?=
 =?us-ascii?Q?bmxaVRqv8s0KyoEHwrBmXgxTFKlkzlWVtvwzdPPjCGzd9WwgBnHqHp7tqpI0?=
 =?us-ascii?Q?Ic48VLtCIENotsWxzIoJNXh6DIee79OoqqdAUdAbRsNxxFYArqH8GQtychYK?=
 =?us-ascii?Q?qUX1lHxpFCpQcRx++GuktaDdNwVFfAENOoxQAZTV9qsjyCxRylCgs9uqm2VJ?=
 =?us-ascii?Q?X8EggX3/I1QxlSR0nsIP4EdD8TDEZv1R7PM+ijuxoSEFXQK2WUKhdaccUBtG?=
 =?us-ascii?Q?+PlM+OFRWD540PkYrv09sAhtn/VG+6l8SsmQ3KKFrAl+Q9h1A2O0kf9QiTvU?=
 =?us-ascii?Q?ZSFKSjM6uX9g+LzBy7/kkTEzPatYgTuiB0dkSMu23xOW9hteqWoL7mvUZrjB?=
 =?us-ascii?Q?MLXn9UdES6YX+7pwkXnlYkrbVgL01S3UkGwQjL6hjZlH1HRe1hNnW5DupJbV?=
 =?us-ascii?Q?fg/w9TnMuJv6s/vmPxEJB9x0wCiia/o9fj971Nr7HaIJqsBp5NCSmUV5KG9T?=
 =?us-ascii?Q?5UH51Gd7S5UmNmzco5uegWbutW0jTMEePbb0pnW7t8h3M2JwrR+dsKoJbwCE?=
 =?us-ascii?Q?A6lT95602Qt+Yr6zi6JJKsbAnnrB9AqCBw0YISC4c5P43/eqGgshq6z5uFoq?=
 =?us-ascii?Q?1IX8joH7XqJL1J4GGXRSjAl5wRmtmPIcvwypwFWCDl8RjAn/G7jn2HXVzXM7?=
 =?us-ascii?Q?MPBcm7V6Qy3YAbRx7DqLZvF6ZpTG4kBEyMryM7qA8v/3AVYr5wIe+mBuRSc1?=
 =?us-ascii?Q?+/M2hUb33QzqSCOi08uHCTlJC0/NBA5USOYN3y4dOW+BE14kE2kR/d23AiTL?=
 =?us-ascii?Q?xJGlVFQL97OLkNqWVbr93jlkUpdkDZ5F4jVrrdO9wVFaU4EfnhoLLHf4hF0i?=
 =?us-ascii?Q?AB7E4Q3Y7KHeqzKMLAyigLULyI6dsdBokD4namAc6tibCwwOWE60gBxVF/8M?=
 =?us-ascii?Q?poI1QPhS71WyYTF099iDQwiDsyCAlbnbWfMXg7XORW5GQyf46eBwuQPkLrng?=
 =?us-ascii?Q?me9igBR4dW4yIRsveJyp79OB+mEfgv9zMEO74Rd3K2W9bl2ST799cT4woSGd?=
 =?us-ascii?Q?QrAFwi7nrLwJD8/v6Ke30HW4dcH5Qq1cDPwAUi4N2GKvYxDrj6UJQYlhbdPG?=
 =?us-ascii?Q?RSRHpozoCRDmRwpqjBIl3fUSpJxf+bKFdbOuYeL0TewB4HEphabqO6wXRUHO?=
 =?us-ascii?Q?+pKRoJI4JMY6N2eGUuxLIuDWZhIuRZ5XOQfh5S+PaFvqQCENB3zQFpiR5zyd?=
 =?us-ascii?Q?Rsv8lNNSxeFkNNHNZzB/4UVPJ8n9Tb7ygcGnaposU1yKlqnzXqBhlEegdAVI?=
 =?us-ascii?Q?YzUctA=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36ff22d8-0817-44cd-e097-08d9b8b0be7d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5077.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 12:05:50.1660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: weyfmvQZUy6pNPkKowDFjwcT/Lp5PBuln44ACWicrDzZXGxGYEGPU5++55lSOgfjKVXJLVacp12JF/dDPlxY7taARkQEXHFs89oFIM3ZdHM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5189
X-Proofpoint-GUID: RUur_AOHbCnbItIP0VoHJ6bQGEn81ktk
X-Proofpoint-ORIG-GUID: RUur_AOHbCnbItIP0VoHJ6bQGEn81ktk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-06_04,2021-12-06_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1011 impostorscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 priorityscore=1501 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112060073
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We observed the following kmemleak report:
unreferenced object 0xffff000007904500 (size 128):
  comm "swapper/0", pid 1, jiffies 4294892671 (age 44.036s)
  hex dump (first 32 bytes):
    00 47 90 07 00 00 ff ff 60 00 c0 ff 00 00 00 00  .G......`.......
    60 00 80 13 00 80 ff ff a0 00 00 00 00 00 00 00  `...............
  backtrace:
    [<000000004c12b1c7>] kmem_cache_alloc+0x1ac/0x2f4
    [<000000005d23eb4f>] tee_shm_alloc+0x78/0x230
    [<00000000794dd22c>] optee_handle_rpc+0x60/0x6f0
    [<00000000d9f7c52d>] optee_do_call_with_arg+0x17c/0x1dc
    [<00000000c35884da>] optee_open_session+0x128/0x1ec
    [<000000001748f2ff>] tee_client_open_session+0x28/0x40
    [<00000000aecb5389>] optee_enumerate_devices+0x84/0x2a0
    [<000000003df18bf1>] optee_probe+0x674/0x6cc
    [<000000003a4a534a>] platform_drv_probe+0x54/0xb0
    [<000000000c51ce7d>] really_probe+0xe4/0x4d0
    [<000000002f04c865>] driver_probe_device+0x58/0xc0
    [<00000000b485397d>] device_driver_attach+0xc0/0xd0
    [<00000000c835f0df>] __driver_attach+0x84/0x124
    [<000000008e5a429c>] bus_for_each_dev+0x70/0xc0
    [<000000001735e8a8>] driver_attach+0x24/0x30
    [<000000006d94b04f>] bus_add_driver+0x104/0x1ec

This is not a memory leak because we pass the share memory pointer
to secure world and would get it from secure world before releasing it.

Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
---
 drivers/tee/optee/smc_abi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index 6196d7c3888f..cf2e3293567d 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -23,6 +23,7 @@
 #include "optee_private.h"
 #include "optee_smc.h"
 #include "optee_rpc_cmd.h"
+#include <linux/kmemleak.h>
 #define CREATE_TRACE_POINTS
 #include "optee_trace.h"
 
@@ -783,6 +784,7 @@ static void optee_handle_rpc(struct tee_context *ctx,
 			param->a4 = 0;
 			param->a5 = 0;
 		}
+		kmemleak_not_leak(shm);
 		break;
 	case OPTEE_SMC_RPC_FUNC_FREE:
 		shm = reg_pair_to_ptr(param->a1, param->a2);
-- 
2.25.1

