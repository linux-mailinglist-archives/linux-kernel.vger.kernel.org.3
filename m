Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28292512B85
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 08:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243954AbiD1G3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 02:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244321AbiD1G3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 02:29:22 -0400
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6BE38BF2;
        Wed, 27 Apr 2022 23:26:08 -0700 (PDT)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23S6HAJd019758;
        Wed, 27 Apr 2022 23:24:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=PPS06212021;
 bh=0jQtq33KfQX1v/IaxLPVsRa4+qmo6hzUgfj9a6njTsw=;
 b=lcndo2FGg66q4dgWlKgy26CTGEBLPdL06myB4iI0OBhVuNR53uZbBtb29m+9kTt09MWw
 3glueByJ5yJvccr+WgFTFYkabkv5fVAsEIrLZMisqPxVyfcabEgdhsDgnh9kiKiZ8h8D
 n9DpYPJ9xt7DM6FMFMnMPNagczuPSFjdYcTEPkxxmnmIlSqOFRcnj+GTal76xxdiva1S
 kMdBeZQ6TPhuaa0LyFfFBTATNh+xH8g/YnSVmWM7wM7mw+m+GtSR8nDBFNTCyZ85VXkq
 7FriE7c+rmUoGO5koyrV3HblxgnxcCophFMRPF37sftJylHaKfEC8qKa2FCrZ3Shtx/3 Cw== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3fps57s3ua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Apr 2022 23:24:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i4HribPAVUkcxg7PA57rplFQ48iBMF83bos3LwwYahFCLokghIGDQ6ZSOtBU/dYme6/HILEUs96ChyecXivDWhWV5IJdxdNHAH1LRCKRDvsVBDyhkzIn8fb3mHdHT9lkfHv3vRbhVhPDEIyfdf6bqB5uuJP0DORW0gm8HnvISR3v8YuRJxjgtlY9LfRtvfdu+OjSBVaxO5hBodc0QJZD8VDtS/i7OqUWowA3A/FTu6UrKhNWORJJmAXT72tanVIEtZRPx8TA4+TppxFOaaT1FWeBmWxTBkeqec58sD4v9ln5bzB1UDXPN8H6AP07jwogS/QuhngGfE2Np1q3GkGoWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0jQtq33KfQX1v/IaxLPVsRa4+qmo6hzUgfj9a6njTsw=;
 b=kPQQbtycD83xpuF4wGAn7AwTZWE+FclC5/5T4D2SsopJAUZhVLK4RSVOYUXC3p1C4/7gZEq5p3DPtSW6rjdOwgfDvo5gywnbAcrN37oBuehal9IKwzjn7OIWIN8e/jXiE8Tr6EFpfq5+eMpi1kMem9JyIkl1nP6TwPRc/QlKIMq/B7M2NO2l495VjgCZbxUar201ubHJRvMoj/C7c3oTbwag1mVCnAWul7pYQugttmmNoeBBNAF6hgdFjjM1lDIM15dXotQF6mzQ9TPinhnUcuftZX/VK1kG1VG8h2HHunXAfHCJ+5O5wq35ED6FuScwfadKVdrVY+nRfm0E36WLBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by SA2PR11MB4921.namprd11.prod.outlook.com (2603:10b6:806:115::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 28 Apr
 2022 06:24:49 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::89e0:ae63:8b71:4a0f]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::89e0:ae63:8b71:4a0f%5]) with mapi id 15.20.5186.021; Thu, 28 Apr 2022
 06:24:49 +0000
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 2/4] ACPI: LPSS: make the Kconfig dependency on PMC_ATOM explicit
Date:   Thu, 28 Apr 2022 02:24:28 -0400
Message-Id: <20220428062430.31010-3-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220428062430.31010-1-paul.gortmaker@windriver.com>
References: <20220428062430.31010-1-paul.gortmaker@windriver.com>
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0005.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::25) To DM6PR11MB4545.namprd11.prod.outlook.com
 (2603:10b6:5:2ae::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94edcd59-b85e-4e59-8dad-08da28dfcbe2
X-MS-TrafficTypeDiagnostic: SA2PR11MB4921:EE_
X-Microsoft-Antispam-PRVS: <SA2PR11MB49213CB181D42423393BB2BF83FD9@SA2PR11MB4921.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mv8RWBwQScJO0IW5ZRpZFp6CXf/sXBaFcy3Sb7XZLUWWiWW0TXpR4tFvLKeG7WkBiRF8lHX/qavJuv4cA/I+YTqf1Y8eEA6QiBdNfMomaRkbZ8WusrO/t3VYXBhy5AQAN/EVdOEPCrfp6/vc0yuW9pR8XxPAvSQbN96yTMWiwFLmDloMR5TaPz7Ky6Bc+WHnV+jyfsGtremT6I2fRY5ETCwRpH9F7ba4qsHelaW5RrfmRsIaUE/HUnDfRumujltCgGwBr2fK3GUkh7Sc18XeSjz7/ylUGo2XD3dQ9E7AB6FT7b9Pz7FxUNbdqBLTttWyZ+lO9QxN92sGFjlthj9sWscswPgAM0LVZQojTp0g1JITnGzQW8OPQIfZGIGy2ZdGROmzUn6nyfbQZrxAGMplxLiTdsar1KdijAK7/Gt6YHkHCICPXJMIfsqPsizj8X2uMJwIMhLIhpybqa/o0r4J6TH4C9/RWHZ/yO03pHRqEWfEHoqP5/mYiu3l81YAHVQ0oGKQUdWyLuX6J6XZ/kEYIN9D4aK65qyiXkUtCOwanJu75HSOapAk+AEcwRiGO++0KeaazukqVvbN+/q8SBXXUiV+v5W7EMywFoD55HwiythHT84Sy9C/eQ+dIaepP2EKT+f/a/faER/t81f500NBm5LLtXiuJlzPcaZt7vhB/5c6TLMDO5SoMZtO/Ov7l8kISu2Ldx/oSBxhmsvfu9QvFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(107886003)(2906002)(44832011)(508600001)(5660300002)(38350700002)(38100700002)(6486002)(8936002)(54906003)(6916009)(1076003)(66556008)(8676002)(4326008)(36756003)(316002)(2616005)(186003)(66476007)(52116002)(86362001)(6666004)(6506007)(26005)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4yc6wk7pUPvpUYbMSFQq6wZWCXHEA+2+O6RWMEXPc6eC1LP5jpy58S0+Lbna?=
 =?us-ascii?Q?lCu0ny3l4VF8kfO8fqA9TzQSgxMiWDHKKqQ2fpTo02R2Mu/8jFBgX60CeXBk?=
 =?us-ascii?Q?wx7UMEHqeYxGUugpPqT8VnSdRkGVFCm0EvpLuFgNG+xBNqs9hTsVpeK5wEnS?=
 =?us-ascii?Q?PxxSP5XVBRIkHgwa70szCbPY7U3VSnu2fyaCmhEkT9Xddl1YFZ2laH/cOawG?=
 =?us-ascii?Q?bWVDt7PKqIRofIgQQnlS7fmoqinCyqKkYrk21engEjdSe+EOLkexkxqwS0PY?=
 =?us-ascii?Q?3fq8mFl3cxyR49qe1B3DykvO96EII0ecbW+cVUZBfCEoPg4hYKP/t5ziQ3wj?=
 =?us-ascii?Q?QCjNRGDpwzYGzCRl98BE1qXkSaPWZHFMZ7zviCGb0nxnYG0D+FuWP8VFOSaR?=
 =?us-ascii?Q?gE7hfoiglSHX3+8tNrbnKLBrZ9mEmlSrE0/Myk5wxlwDeiknx3IhkEkUmlAp?=
 =?us-ascii?Q?IqhY1JWdPLhiVWVgcOlXbp3xZWuMBqp+1N2DmkPyurxc3KjnWKa3U6xSn7GJ?=
 =?us-ascii?Q?fLc2mh3QrHFGdMZ/DcLQtKP2k4yONaup0cKM55q/QHhyuGuLXWyIfY9rop+0?=
 =?us-ascii?Q?HlYW3AZKZQrCLJ/Liasy4yUdRG8fpDwwkK+r9/s/rp61nXSNN90RM0GeggrP?=
 =?us-ascii?Q?aIJp3Fbo4zKYZ91T29bAZd95+2zjSLJ7xFiy+URW8q9nbYld6XemPN8wXv4Y?=
 =?us-ascii?Q?gcXPWwnC7ysgl8nfStZRa0iLj15Y6ozQXgtUAtb00fWVN9e9p5p9Asm7mwSf?=
 =?us-ascii?Q?Z8bjAvCnfpaBPDp1T4Oc5YDbBRDq95hG17W5+kTpx77YhTqTiwHkkGrKhmPJ?=
 =?us-ascii?Q?hdu5K1w5u7+6cfuMjhAu3aNOCzuna+FqEstos/J1AQDOZzujGjIho0K5lxOZ?=
 =?us-ascii?Q?Qt7fTRgO9rmnP+sMhIBcRgD7QvCT+x6BKlk6O9qjng3kxAOW7s7+SqHlaB0k?=
 =?us-ascii?Q?DlLt2hiBBJfRCgZC5dpDcEKY5/DOLEo5K1lOSKF6yISha6dg06JJW2RFETqr?=
 =?us-ascii?Q?7QmArG1zI4KZodBS5NuP5GMHN1PParErlLK0CO3haveoXw6jrli6xDg5EU8e?=
 =?us-ascii?Q?UXnFTNLeZolY+sYInwImCs04/0KikpV+8MYNbrfHB53BZhLOserzsqxDH5Jx?=
 =?us-ascii?Q?MGNd8Xzm6LZLxOuiuuQDq+tf+oR7gvzr6XDIJSj3E9Vgvfan6Tj6yptIt3jj?=
 =?us-ascii?Q?1R1m1vsFWbZFNhMVRLPALIHLvnVFBVD1GKoKspSyaEje2nmilVGEcWgslWXS?=
 =?us-ascii?Q?fsaX90I5UQCOnrFAY6zAgJ9zhIyfjqTJ0J+Q+My69p/S1o14j8bY7judshDe?=
 =?us-ascii?Q?5RvZk5Dd01azm/e319myrJz+cuyScheCmv0RMREMtEHVpyY28W59NyWkt7zD?=
 =?us-ascii?Q?8jf2AlEkX+/crfHMhEXvqAGEegbMTg6Cgk7LIr1+4oIczeVSGM/qKGOY7PZd?=
 =?us-ascii?Q?nlb/VWDZgA+2uRSMBdqTOWeCEYIQYNXnG1FSTS7AIBv8z1xFvWnltD18sfW0?=
 =?us-ascii?Q?W0jx2xKdly7lcJlMen2PjuknEGcMduw8ce/eeyiOekz+OHfS1vNV5c6PplmT?=
 =?us-ascii?Q?7mI9E1kO+cd4bXMJJlhj9FYEop5JOx11anLylVXof0LV72wZ0OIjYVWCM7/U?=
 =?us-ascii?Q?Q8g/CJAs9gfyM+mc2cvI0NbcTK7lofycoI5HNEplYWgqO6sj0FtnD1vgb/t/?=
 =?us-ascii?Q?9WbxYZp6ZDJTk24RRKKTDMdpsk3EqptJ7Gj/bbxd8g23c4l8ablFMcDM+a22?=
 =?us-ascii?Q?VGPnUL2B8i30kLAqcaejv0pu4QWRgnQ=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94edcd59-b85e-4e59-8dad-08da28dfcbe2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 06:24:49.1349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r5e+KxOA8lPRHG/o5WFItU0oVWSP/cAR2zs8oKbLxfmb4sKEyjVUHZBrunKKKZirqZmBs3MFpfwhKQR5rDAJJ9ecketPf0xFMI50xSqryhs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4921
X-Proofpoint-GUID: bXDakq_r0g8Z9eZLrfCxi6qAToJcqhbW
X-Proofpoint-ORIG-GUID: bXDakq_r0g8Z9eZLrfCxi6qAToJcqhbW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-27_04,2022-04-27_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 phishscore=0
 mlxlogscore=607 malwarescore=0 clxscore=1011 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204280037
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code in acpi_lpss.c has been unconditionally using pmc_atom_read()
for about the past six years.  This hasn't been a problem since you
currently can't disable PMC_ATOM short of disabling PCI entirely.

But it doesn't need to be that way, and so that we can change Kconfigs
in a subsequent commit, we make sure LPSS selects PMC_ATOM in advance,
so that existing .config files can live on with "make oldconfig".

In theory, one could make LPSS build w/o PMC_ATOM, similar to what it
did six years ago, but I doubt there is any demand for that now.

Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Aubrey Li <aubrey.li@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 2ee26f10a814..163c198ec8ec 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -654,6 +654,7 @@ config X86_INTEL_LPSS
 	select COMMON_CLK
 	select PINCTRL
 	select IOSF_MBI
+	select PMC_ATOM
 	help
 	  Select to build support for Intel Low Power Subsystem such as
 	  found on Intel Lynxpoint PCH. Selecting this option enables
-- 
2.17.1

