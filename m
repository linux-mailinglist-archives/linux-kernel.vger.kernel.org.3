Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFB64AA8B0
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 13:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379059AbiBEMQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 07:16:57 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:18840 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237036AbiBEMQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 07:16:56 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2158iPGh026188;
        Sat, 5 Feb 2022 12:15:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=nTs44FTYkHhqLKnWYyQAExY+HpRaaIJNHuZripqKBI4=;
 b=Y68BVgltxeruqHfIyASNN/JVN23AJw7CGyZbvGagP7Izk4hqcucUojYbqgGoCUKvJiar
 JruRMUM/wVqEitXw4HnEQ4gPVaAzRKw48FsOsqYdAyXeEjzY5TnjA64K8kcVHN7ssTrf
 VnX+lUhtIsVK3gamR6FElrXiugMgTzc4MfVO/34cQKIuLTokwl7duVxO5v8LRP8TiGHA
 glf/1oQVzMYeorW3ecgZ3YrOuY9oitSfze+Nf0whXdnkKt14Z5lhAwoL+CS3C7nCgPFY
 iOxphHuQCTAx7+4+ntgv5fxyNGru7/70gN6LnAg0jmm9k1NMJTucHoDtjsioOxhxMnDn 9g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e1h4b0tw0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 05 Feb 2022 12:15:25 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 215CFNkO130741;
        Sat, 5 Feb 2022 12:15:24 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by aserp3020.oracle.com with ESMTP id 3e1h21qhcf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 05 Feb 2022 12:15:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fEcs4FmXBIZL39hAVUT2WsPc9bS8ugPnhw8e4qM26td52TjiaB+W6dCyApf290A71X+pYltz5YGygED/GE9bJ+5vJ4KHkGwmSnTezpkDV/eif+i8T5OaUVq5lIWoWuAmPfWmtH3dyYw3rJCCeJTqR6mqJuvTvv9jNXqy7xyKIDKAcUtAymvUCA7nbJuOt2hfExCe0byiC3zoBVjWHWhSgwqLAtEC72bBytQ5B/4+JutgxAIxYjE68rTQId7hEblbpkNtrEaQKekgW4tQu2aIiZvhWMWLFHUecZ7E0I2YgYJlpR/ZENykWSLX6zJ/7LN8AWpAlTSD//hawI6Uh1DjfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nTs44FTYkHhqLKnWYyQAExY+HpRaaIJNHuZripqKBI4=;
 b=d9mzlYxEIp2FVqpHxS4CXiMOAYmVnbmUb9GzpHvBflLVLpBcQox59EFlVeorKTNCXkbBas1m1TIEmzpawOrC6gPbRPOWmV5rtCmg2BTQO7xqL1SC/11c/kiNwA9WFpdxONIc1DGZnRWA8PyMPwXK6EdgbU8wTL2y4zRGUe6pB3JEmbKcJ27pS8VfRvtXiiJENV9Lm4I6n6NVLKjlnF1WYgc01VYCtynE0uSGekHY/HPhaT+m244SYfDBW9JErbiMnprpgipUEnhk3adLIr7ZXEfFq2Go1KM2BXuZbJPHhaX0KkeTyNUtxVjKu+JxLA7689AwEuHRwFCwGLCpfU6rSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nTs44FTYkHhqLKnWYyQAExY+HpRaaIJNHuZripqKBI4=;
 b=wgHrQhL8hxLgf6f8YHagI8Rh/a33Kf6j9hCUlW9qNes6xzHhP8/yzy/jDpXh9UxJsEEevXUyM/Ct6zkMDpHrzu2Ea/l62SxTEapR51GCmzG1liOwRKSHWcH+QwKRUs6syoUMmpOXMw/a+Zno0GX3ykC8JBB8Ib1AzPk/f1k6Bvk=
Received: from SN4PR10MB5559.namprd10.prod.outlook.com (2603:10b6:806:202::16)
 by BY5PR10MB4164.namprd10.prod.outlook.com (2603:10b6:a03:210::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Sat, 5 Feb
 2022 12:15:16 +0000
Received: from SN4PR10MB5559.namprd10.prod.outlook.com
 ([fe80::c0e7:aa7a:a36d:2146]) by SN4PR10MB5559.namprd10.prod.outlook.com
 ([fe80::c0e7:aa7a:a36d:2146%6]) with mapi id 15.20.4951.017; Sat, 5 Feb 2022
 12:15:16 +0000
From:   William Kucharski <william.kucharski@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH] Correct documentation comments for x86 csum_and_copy_...user()
Date:   Sat,  5 Feb 2022 05:14:56 -0700
Message-Id: <20220205121456.478180-1-william.kucharski@oracle.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0142.namprd03.prod.outlook.com
 (2603:10b6:208:32e::27) To SN4PR10MB5559.namprd10.prod.outlook.com
 (2603:10b6:806:202::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa8c03a3-a8b6-431b-c4d8-08d9e8a12b43
X-MS-TrafficTypeDiagnostic: BY5PR10MB4164:EE_
X-Microsoft-Antispam-PRVS: <BY5PR10MB416416BB74AF5D02A1890327812A9@BY5PR10MB4164.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KFstGqsEPuz8edRvPvrPd+Yv3gSTmlBtqOAzr3ObJ9THuq7e5sLvGoTMqMhiLOqE0HM8hPZCUmERTGymAb8Q1DP3vGhGNakOOVX5L5RQQBTJO6cRy64Ah/qhqXP8i+1sfTp48Z4qum61j+BeaPqSOPbwsEi+TIvury09u3J0SD0K4qWetcnXEk9KRgLp+RInvTKGp4c8HGWv700h1HqaJrn5kFaa0IpQ37yGF306ASv3jcAyn253g0SPUfnK2bdUWT9gVtzebCpQedY82tv4P73F+2VeqyKHbcQdylek450wUlj8PAaaSMECMhdOHgijHGtgyWJqOd4zbpmsQ64B4PErfU8X/gCryj9bhiyMZJ9jdkKr3exJvrvh8Ac7Tih88eoj/93OJjMitNnwDYy0jiA8MnXHit9EBkpnLzJZiG+PUMe9NBWh8p6bfuuI8k1/MP23a6/l0U3vraxoBt+dwMUHlluCkx2EcI7IyNpdRAeXKEeh+Vo6wXsQHuCv+zGEzn9t9LLRNHYFHjPOzJIEmS8s5qes1fWNCSN8gVYVY6eZbhTYx5J33Y+YEYbynTfW3JHwXbjGrMrshgGyl5TVF93ZxI5y8uudhvYLrcWoEatWrU+QZ/xykXOIkT40kNTXTiiZ/bEkJsxDIjxrp3fHuA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR10MB5559.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(2616005)(6512007)(38100700002)(6486002)(5660300002)(83380400001)(66556008)(66476007)(107886003)(66946007)(8936002)(8676002)(4326008)(36756003)(6916009)(54906003)(86362001)(316002)(52116002)(6506007)(2906002)(6666004)(44832011)(1076003)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?drfdgT5QGCd7k17aYAI93dbBlP4B5pPMxcdF37GM3xTKXOb6lZ41T6spftJA?=
 =?us-ascii?Q?/B63RIVemNCf+genLOdAF5Za2bVwMz8hy6Cp0+6pFQ+sTN+QLkAhqbhJUmFj?=
 =?us-ascii?Q?JJRSzoJf3vniKTbkHV7+Zxrwjy4TRy/CqQH9EzW3zz0icUyKv6E/ubddYuO5?=
 =?us-ascii?Q?Wjry2U6ZqFp6xgVSK6CtuEhFe1/MKyG0qfijJ6/NqSEFTHXiiDt65jbb41Tw?=
 =?us-ascii?Q?7QW+f65+LWdGqeSO0h0zh+7Ge0ynjexG1zSpSQotUgR/6r0oDx8196yMXJ/B?=
 =?us-ascii?Q?0Snh9I5Yque+3yAPcHsZpRhCie42oRohqx7eoFKfWK/mBlKJnvlkVI2K+dbl?=
 =?us-ascii?Q?SQTnzeLCWE4l3XhU3im905ikgg5SlUuSkVT/RfZ9mQN5UTgCsmfmfkxFhMr4?=
 =?us-ascii?Q?hFB3tUSi55860KPM5B+2qPrgcduScjOZ/Jhv2+CgtmbM3D4uJ1QVeByBMSjw?=
 =?us-ascii?Q?1x7dQD9vQY08edaKuW/yhhFNXkxlDBehTM4Q3thM5+jy/J9gA3Ct5DmGxcQS?=
 =?us-ascii?Q?eoqtFjas153tSH4EZn0L/ZbxuHM6zcupovmL9jFtLHmf7Kawqj97L4ArfVCc?=
 =?us-ascii?Q?us5xrSTcfOWR/2PGx4q7RTB5e2l1mTg6tYI63uPwFxMuaEK1G6uAJEEE1A+b?=
 =?us-ascii?Q?3wE6dTBNH9DH41m/BdRXs86Dl37VXYHoP5iIgGRXeGTbkjE8p/xFwMqUiZSt?=
 =?us-ascii?Q?Vzd5RpexDwMIRDolk5rjrLOhJjCMm9AX9FEl9MQh4OMZA0VQaPspnF7x+ecc?=
 =?us-ascii?Q?tfhJvZp/XteySXMldzT3lQHPUOjU6q9HAkNWZGhcZ2rnFgemHql7oXprhuYT?=
 =?us-ascii?Q?490D+SZmLbpyW8WuR9Yi/YeZVLJpYiZrnLNTb/pV+Hr3CKjcZJAIc5cBgWR2?=
 =?us-ascii?Q?JTkBvEBNz8uX9rszLxLA3Y9qIPm9+aYYkj5YWdGkyoHyMkxiznrvGv12hxuc?=
 =?us-ascii?Q?oa8YqJdVREq1qzl4h/dN2HklfEs49Rxpn9XYfimP37BIyi2LoRmG9F3dEb4E?=
 =?us-ascii?Q?h3eXhkn/gdh6UsPW3nPxlCXcQZmKgbOsv+k5qamnTnYU099h6LezsiL/dDAX?=
 =?us-ascii?Q?CHFdeJQXLuC3fWe9JBFaex8HCQZeD+MVVwxWWVouBLy8XCR3EkY8UvSQgF2I?=
 =?us-ascii?Q?I1d5alDJ5sUlEaMVJgWWKfXGnBQ+I2kNoVNJ9f0Uey5f5aHn97UYie8MM6eW?=
 =?us-ascii?Q?/2ivuV67Az5f65w7/UDo49s2F0/olzS2pRJktHebqB6FIlf28LZmKlStzGjZ?=
 =?us-ascii?Q?YxNIKPVduldWO0jagP29PAyYP8XCpypVT62DqYIpWTlxznFipU/WDttoxS6t?=
 =?us-ascii?Q?zwuEAvlYOs3+/Kc2AjljPeZ6PfItu6zRSw9a6Vsr7QU3H/wyFtXokSba6qcu?=
 =?us-ascii?Q?YRESUNXKNGp/+YBiUiNx1eo1OFreUsm38/8kBZYIZGVubF4dIcZQ6DiCY6Ga?=
 =?us-ascii?Q?GS7V1noo8Dk5KcxUJGoRMPUGSVK3sjUuIIwrt38wC92Fox61ZdQ6GxHGlNb8?=
 =?us-ascii?Q?4a0iBQoK1zIRWD9jkWQHe5KlE8zOX2T7YPc/l09XO2nuwXZVFCfHErx5knDP?=
 =?us-ascii?Q?QnokXuEA7WLw1olpxE1LHGsqFZLt/HPdixpIz/m8UjfE/Y6MSl68AMUHk5U9?=
 =?us-ascii?Q?VUr/dWnyRsRdY6Acrm0hZeTpiKI/1KAf1Cp3j035MDPEYmxXPFKqELl5lRCf?=
 =?us-ascii?Q?MZTzaz8WyvJ5FX6gSo9J7GmA/57cIQLVRNLqKxQXRHiN9Bl5PVv30Tj5iC/I?=
 =?us-ascii?Q?nRnnat2lnQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa8c03a3-a8b6-431b-c4d8-08d9e8a12b43
X-MS-Exchange-CrossTenant-AuthSource: SN4PR10MB5559.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2022 12:15:16.4607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5RsM+bGKRF2EP/zhqB1+edfPH5VreYczkKz727COJgaMTKxe4hW1vr38dS1vpobRHCS8CY+r7mc0cNbTdBx39+farUUR9xPQzg11odXip8Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4164
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10248 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 bulkscore=0
 phishscore=0 malwarescore=0 mlxlogscore=967 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202050083
X-Proofpoint-GUID: 7dsGb-ywPmoMgNe84QKS-APzNS2MlWEK
X-Proofpoint-ORIG-GUID: 7dsGb-ywPmoMgNe84QKS-APzNS2MlWEK
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up of calling conventions for csum_and_copy_..._user() did not update
associated documentation comments to account for the removal of additional
parameters.

Fixes: c693cc4676a0 ("saner calling conventions for csum_and_copy_..._user()")
Signed-off-by: William Kucharski <william.kucharski@oracle.com>
---
 arch/x86/lib/csum-wrappers_64.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/x86/lib/csum-wrappers_64.c b/arch/x86/lib/csum-wrappers_64.c
index 189344924a2b..25d533502693 100644
--- a/arch/x86/lib/csum-wrappers_64.c
+++ b/arch/x86/lib/csum-wrappers_64.c
@@ -14,8 +14,6 @@
  * @src: source address (user space)
  * @dst: destination address
  * @len: number of bytes to be copied.
- * @isum: initial sum that is added into the result (32bit unfolded)
- * @errp: set to -EFAULT for an bad source address.
  *
  * Returns an 32bit unfolded checksum of the buffer.
  * src and dst are best aligned to 64bits.
@@ -39,8 +37,6 @@ EXPORT_SYMBOL(csum_and_copy_from_user);
  * @src: source address
  * @dst: destination address (user space)
  * @len: number of bytes to be copied.
- * @isum: initial sum that is added into the result (32bit unfolded)
- * @errp: set to -EFAULT for an bad destination address.
  *
  * Returns an 32bit unfolded checksum of the buffer.
  * src and dst are best aligned to 64bits.
@@ -64,7 +60,6 @@ EXPORT_SYMBOL(csum_and_copy_to_user);
  * @src: source address
  * @dst: destination address
  * @len: number of bytes to be copied.
- * @sum: initial sum that is added into the result (32bit unfolded)
  *
  * Returns an 32bit unfolded checksum of the buffer.
  */
-- 
2.34.1

