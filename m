Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6E449E823
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 17:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244196AbiA0Qyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 11:54:45 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:19452 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244171AbiA0Qyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 11:54:43 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20RG8wgp016336;
        Thu, 27 Jan 2022 16:54:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=saBVHaAWVEdDm6Hc8kzcCIemYtj2RbWR/YnBo//OV9w=;
 b=Ku1DD/eapofo+Swvkx5AWiQNsZZbgvcW9wpwHgPgOn4C8kVunruHSZlJAV0nSQuI91OJ
 rPLXpKNhbzu7eUMtAXRVo9LInDtFZJcWshShV/nWl7Fx2UMYnv/hJpZo64iUKhlYO2ns
 4tDovkALf9mD67gvlKvz0xzgeP4v4tyn5tQQhoxQLD8HC5J9mv+qI1Tjz5DXGCOkji66
 E8Z86Rfjt3T1c1pUTjdb7Vo+7wPyEDqJxEUY6f/Dz1MmPph9pOwqsOej9L7PIxJle4es
 yP5KZFq7IU+E4uxsBFCz6S5gSs/MRqO1ZrmN6cEIjgKgypkM2QdqdQG+T+JnniKKvq0V IQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3duxnp07wp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jan 2022 16:54:22 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20RGV70h177621;
        Thu, 27 Jan 2022 16:54:20 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by userp3030.oracle.com with ESMTP id 3dr723v4pd-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jan 2022 16:54:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Skg9qVyDfOzMsxQBhG7M2SthUnasRFdv2L3OEpm5xyO+6lpXC5XdbW+CMUOD5gOJKx89JOy+4ImyonFerk3VkmzgxhK2pnZeoKgDHOMFb3IprDr/cU/p7sdr6KqLgGCxO3XTJwyiPfaRr120SGhPdwrlky54lJNWwAgVTzu2Bc228CFAk0nSDJE0u5Bo1xZsANnjrt/uDy2y6I/HUl4rN2RbdYZwAK6pbZEf9vONO5v7CKdBSOIqnEXKAmTOfZRNfOGvracY0qDhHdfA5GnFHarEybsmSKgVT/ruHIwKg2feZYuvOI79Rm2yDFRhYRWmSbCJHBr8U6tnNWf+gDyYdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=saBVHaAWVEdDm6Hc8kzcCIemYtj2RbWR/YnBo//OV9w=;
 b=VR4NqY+0C4Wj1yzfADYjdw7wPyVXQSSI+zZvKIJil12nRfjGjDwMlO54enneA8OlsX5Ta9R8K/Rh0J/Px059UIoNAT8b2PspP4wOX0vj5o5ehCRtKG90fKXRwgfjXwhmucuijdEOSt/1fEQMsM96/P1BVPuJjqeWF/+E5D/ZRZDFDa+vrjlYkqnrVDL54Y13IFfc1WCZ+ApMC6L/KcoK4SBZ5t5cvashuBWixtdWtTeBtHOF+1IZgY9gJ248/TC3yKYVku5Uapuj1WC62Rx2E0JmXtYVq5ec7Hd6IX/fZxNEdjoBgysv0g+BFPBm+iQZHfirlk4hXW+bZPx4bFMkcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=saBVHaAWVEdDm6Hc8kzcCIemYtj2RbWR/YnBo//OV9w=;
 b=K6XhLtgFQrsxX1HkM8VoqT8zYoj4yrcraxfiiVG4paTLxVShlOEeFrIDMif1WnmRXJmCkQ8FID5Wxch3tcqcOx2eMC2VhsKwKS3sdxNFUR8ocWheJ3wyYDeZDX5vT9pQtx8btnehvZYs6P82q/qEbHlS+tPTp+z2fZR+GRldCGU=
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by BY5PR10MB4370.namprd10.prod.outlook.com (2603:10b6:a03:20b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Thu, 27 Jan
 2022 16:54:18 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::398e:10a4:6887:4e18]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::398e:10a4:6887:4e18%5]) with mapi id 15.20.4930.015; Thu, 27 Jan 2022
 16:54:18 +0000
From:   Ross Philipson <ross.philipson@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     ross.philipson@oracle.com, daniel.kiper@oracle.com,
        dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, luto@amacapital.net,
        kanth.ghatraju@oracle.com, trenchboot-devel@googlegroups.com
Subject: [PATCH 2/2] x86/boot: Add setup_indirect support in early_memremap_is_setup_data
Date:   Thu, 27 Jan 2022 12:04:16 -0500
Message-Id: <1643303056-22272-3-git-send-email-ross.philipson@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1643303056-22272-1-git-send-email-ross.philipson@oracle.com>
References: <1643303056-22272-1-git-send-email-ross.philipson@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SA9P223CA0025.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::30) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36ce748c-0256-45e4-b525-08d9e1b5a8ac
X-MS-TrafficTypeDiagnostic: BY5PR10MB4370:EE_
X-Microsoft-Antispam-PRVS: <BY5PR10MB4370E55C84FC957E26FF102EE6219@BY5PR10MB4370.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LhfIhDLUz+W+86xkzlI85eaO0k2yzkdETloNbp+JgGqqIYedGnrRxDwLxAWV3d7YMw8W/VCuLWgcDdVZgtiNtE4IpdvAh+yRDPJTJs4PzI0RE8WpTjbbLar8ZkWMrOKbFZp3ppb5CVxKtHTlHgUQObDNJwyVlGPCmzkw5wmiYrKG2RIQn2YBjPQXRxaH0q+Mq1eLfITHtOu457rL4JkBG6aml7XYHjdPuo0wjbFKTs9K/FO/Q/C7Vhz2zV0Sms9fTR1a0cHBLF77pxK9XpT5JAodAjNsdbzLxuZlRB4PrBKxPxKBfQP7DHQOu8q9QCF0maZUcKAvu24ex4IgMoI00/uezwceS/uiAh6UYoVdblqLRMQBsGe4JkrBJ7G86q1wkOqd2lkMKJNbRyPWYq5hPkzVbgf3zEdnRpixwPKX76OVhzOneARm+9n4PNPDXcvCdLVK96B3jt5/eQJK79KQonUcy6SYhIj13lcKxoQ06DeTO82M56+Sn6uXvWnnlRaN9QQ6GbLutFFsdzj9ZXnnFfCpCZg0Z2JTlQXQpXCQXy3iJ/U6rIh1xkmQ8fEufRDGBVhcirvTc3f/UJ4Ql+IKk0L8AH9PYzAdJtkmWuxOiyZC1UK2ah72O9eIRHGEb8H9sVzpKnrKbXpcbkM8MRrb2gCbmAsxOvHsWXZF1g4vBcA1WkpjXaPe/hTvafvTaz3ZG2WGJMfplMACbDkzkQceLQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(38100700002)(5660300002)(38350700002)(86362001)(8676002)(44832011)(4326008)(8936002)(66946007)(66556008)(66476007)(52116002)(36756003)(186003)(2616005)(26005)(83380400001)(6486002)(508600001)(2906002)(6506007)(6512007)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uqHajLF682F5UbwJwUSpA7pqapADC3Bh1HxtZ2qIpTwDOhMMhX3Pq9ycQGnM?=
 =?us-ascii?Q?AhvvqrssW3yHokthmp0BFt5Eaj/fFStTvrpRY8eUTNKDl9dSajDT82umXXUu?=
 =?us-ascii?Q?LkyyfC1K9JuxLseU2NK6xwMfeJybAe5UAk3dyDHc7QcnSZEcc7wRvOY7dbzj?=
 =?us-ascii?Q?xf3oxNMLAm4alKoSQfZpV3d/W1HitkI6z6zjdhBto/50y6AVumUGMdZ+ZjXc?=
 =?us-ascii?Q?1OfQtSP5X1ZCD1EufZBvo3cTADWas/hx4EwyD85HFFQIOhEtyaw2a9VjhHWL?=
 =?us-ascii?Q?v8AvmCBEiGAY7DWjt0T9Ni0RLhp9zLrL/Pm+HSPSiqm2vjd0VFJqF0gujjTg?=
 =?us-ascii?Q?iKHOLQ8Q0S77wK7Der2qm8YgLFJaQya9vju2mbC3pBHQtPAFOzJerMYVszZD?=
 =?us-ascii?Q?wCItRl4XmEKDGb78bGtmaTAIdpvvo70/DoYQV50YrAJcB33wbFVSgE411XkQ?=
 =?us-ascii?Q?in4PT629igfX2dl7TDdylMj/mm+iP3na3K0CTVFSxWowbFmKm0w7HpGtdxdA?=
 =?us-ascii?Q?1f+E6nln5tpnPuj+NymOoaBDRidnrY5Dg6Vu91YsukmI/1leP1S1RNtFDNlE?=
 =?us-ascii?Q?3NEe+Z52hiVPE4OMPUov4NR/58vwhjXrfdshLWuFzfOY5sgzn5vgQyF9QnxD?=
 =?us-ascii?Q?BILmvzAJzpbZ05J8Bdcx3FYglc9hjzgnhKUUSwYjMk7k0/k+phgjO8JnNGGo?=
 =?us-ascii?Q?u1+MCmTmfaFH+gbAgS4u054hU34o3A4PSEG9maN9lCyoquESdXLbtpPb392N?=
 =?us-ascii?Q?gn96RXnZWBLAWMJsfLKHLEZoV5EGiJ62k1TF6UCh04xCZERQTohmhFzdlFqs?=
 =?us-ascii?Q?PX/HPh7bgThH2F4WMh3kDfnWgoB2WUVWbOtnd5EUMAJ0FQi9h/4XgpQ0Eest?=
 =?us-ascii?Q?t+eWy+j47ktomKqsf06VnKCinXWD2LQsfvmZ00d11/4QV14co+eLdPvwIf8T?=
 =?us-ascii?Q?HNYfvtVZ+T6Qebej8RBeZXXb7GMfQ+YfyduVmx5rzlqmUp0miJkGVoUM1XPr?=
 =?us-ascii?Q?5NoL43w50LsFfy7QnQqVKB0hTjUTrBtlof1FnRMkQ1gMrrXwE1RiWNvrRDar?=
 =?us-ascii?Q?wYq7Ev01IHqrD55fWZomKo6Lu4ImvvJ9nWhU04fwe4dDVMo6wfj728oKMf+r?=
 =?us-ascii?Q?Ab8aKdD/Dl8NHj0vFNtiBk/xC6wGoYdsUistBySU4CZu+nhSRETkq9526bvz?=
 =?us-ascii?Q?O49IgRFxIm4S/auEoPpVlJ8kJvXw6PtP/sV1lnIfRzV+Ok9ipoh/+FN2jGH4?=
 =?us-ascii?Q?HxdgzR/COrdZ629Y/JUmSg4q3ElWs81a26i/l0I2s/+2GcZFf47kpa2pL2sW?=
 =?us-ascii?Q?tM6MgLnyy5BcvyIy9kBFjQLGodAvgzftP9gEy41Kb6oo9EplGqQkpqSqDSyd?=
 =?us-ascii?Q?TI6Ivc9fDwsubeYfN2hgA0pIYw+iJ041jzGXRPf0b3AoI6NOainXYm1Xp2Hq?=
 =?us-ascii?Q?Nd/5TfV0h+hKPhOzJ32A/Vx3OwD1VkVV6IVxu4ydbxm3y7qp5yVJxtI/ev2D?=
 =?us-ascii?Q?6TRmAcmBFvtwZxvCy59taNsvfbPQzFIJ1eK55Z3M2Vf/LORSRsWfKh9bQRS3?=
 =?us-ascii?Q?/L4AcJ54eTFDko1qxLlr0UwvLlsEsC2/oaYen+uQTO6XgUHB1Li4Q+n6CanX?=
 =?us-ascii?Q?UKpjp7KFg/jMCPL0bLlOIGeGrtm6DBWQuOsfTZIjneEPaxhHCbc/FR12TZf4?=
 =?us-ascii?Q?bviC2w=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36ce748c-0256-45e4-b525-08d9e1b5a8ac
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 16:54:18.6262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s30l60tguHwH2zbpOhtjJgLDS2hZn87qyen3WV4MYjAPsp776Uah8qbqzbhEolXwY/DMmVaf8UOtgXiAFFuLe7wqsFhAp9Nj8bxyk6P84Zg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4370
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10239 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 spamscore=0 bulkscore=0 mlxscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201270100
X-Proofpoint-GUID: Nygd_stf76UStTfp7JPmeXfP-vA0r3mG
X-Proofpoint-ORIG-GUID: Nygd_stf76UStTfp7JPmeXfP-vA0r3mG
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The x86 boot documentation describes the setup_indirect structures and
how they are used. Only one of the two functions in ioremap.c that needed
to be modified to be aware of the introduction of setup_indirect
functionality was updated. This adds comparable support to the other
function where it was missing.

Fixes: b3c72fc9a78e ("x86/boot: Introduce setup_indirect")

Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
Reviewed-by: Daniel Kiper <daniel.kiper@oracle.com>
---
 arch/x86/mm/ioremap.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index b45e86e..9129b29 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -670,17 +670,34 @@ static bool __init early_memremap_is_setup_data(resource_size_t phys_addr,
 
 	paddr = boot_params.hdr.setup_data;
 	while (paddr) {
-		unsigned int len;
+		unsigned int len, size;
 
 		if (phys_addr == paddr)
 			return true;
 
 		data = early_memremap_decrypted(paddr, sizeof(*data));
+		size = sizeof(*data);
 
 		paddr_next = data->next;
 		len = data->len;
 
-		early_memunmap(data, sizeof(*data));
+		if ((phys_addr > paddr) && (phys_addr < (paddr + len))) {
+			early_memunmap(data, sizeof(*data));
+			return true;
+		}
+
+		if (data->type == SETUP_INDIRECT) {
+			size += len;
+			early_memunmap(data, sizeof(*data));
+			data = early_memremap_decrypted(paddr, size);
+
+			if (((struct setup_indirect *)data->data)->type != SETUP_INDIRECT) {
+				paddr = ((struct setup_indirect *)data->data)->addr;
+				len = ((struct setup_indirect *)data->data)->len;
+			}
+		}
+
+		early_memunmap(data, size);
 
 		if ((phys_addr > paddr) && (phys_addr < (paddr + len)))
 			return true;
-- 
1.8.3.1

