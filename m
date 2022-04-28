Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BDCC512B83
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 08:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243895AbiD1G2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 02:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243805AbiD1G21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 02:28:27 -0400
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C69972FC;
        Wed, 27 Apr 2022 23:25:12 -0700 (PDT)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23S6HAJh019758;
        Wed, 27 Apr 2022 23:25:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=PPS06212021;
 bh=DapDWoSM5Bklo+s++Jx3eGyTV1DIWXW30/bxdef9jIU=;
 b=WEnX9YSggplBReYE9XEt9KOoa/qJ/NkxeYJKo2j1CPLWaSidYJ6lE1gJ4vtzBWUEmBR+
 CGlIbGxC7t7JKBAU16usqk/cUT4fS1fh8voptMz2459HSt6vcl+afvuQMm+ni6l0CGZ2
 PHTFdslB+0BVPeqJW9oVl6R1sfafljkVzxPGhzZOBbwydYEPLd0alR7txLobVq6TrcE/
 HwxbPRpIIB5EgYrzGvofV2ZqhaBte28LPOYXFwkyOvN7sfd9P2gk2fNL8Ii+Aihtgk6V
 7Qmiucnny4pP6EoLLUpxEvVEucpsybYp3QmwNz8/ILwyAIXZhlVTcBLHW0r1AN7JHd8l BQ== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3fps57s3ua-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Apr 2022 23:25:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hhuDGdrjnEyZ7XUkGSi0sAUE2RvKXqEaVDZORbuS4JaJwIZT+/A09CRkQo7BJFoB5fXGZ+24Z5x2aUcklc1SV4jF8MnGL94oLTLtCmnwqNyA9hsmnP+3xasOnqLHAOX4uRIX3k1dXFAIV3NDRSZvdVIiOm+qoPlwfkK6AxR+/qUzAKceyoP6daOFf4nokyVkNmP3AFoNnO3k9SqaoPt163JAiz4RBY7gme2K2Oke8l1I021ztQRIvZX9Mgzhhx4qalsg8k8uQQfq4EZ0gEHE+nGqyfwLvekzeApcXf/t7LX0sNcPjTA70zJeXWXoe5W+MLWxqUOSbq9A91NhGNQGTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DapDWoSM5Bklo+s++Jx3eGyTV1DIWXW30/bxdef9jIU=;
 b=AE4oX/S41XPhFpyOL/uLVWR35JZwfXf60rxQQLzGbaS6CMLF7Q4WJ6cmNu6/w0OFZz1qb8CpDZynQqqDfb23URh9SVOGlGim3wlrg3m+QijGsRhwDGgbhl2A+2FVO6kzP1uO1s2/ySNrxqxzzD+v6gHg+HtTKFcFnPOrAmvccfdkFMlTOqQ7veHAcT+8NPYJIREceVt4D2dP7hnLZ2hhOIZ/9owZHP+kL2fQ5rtmb/ZfNuzwJGg8d3nU/dStpeNKnwiE7wKBobQBOWgMJdvvYr6zi8riTjTo5gTJThFzPB/3ASa3BvFPqGHlvdmE14wQ6iiWInALvSQa5ztF5ar7MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by SA2PR11MB4921.namprd11.prod.outlook.com (2603:10b6:806:115::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 28 Apr
 2022 06:24:50 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::89e0:ae63:8b71:4a0f]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::89e0:ae63:8b71:4a0f%5]) with mapi id 15.20.5186.021; Thu, 28 Apr 2022
 06:24:50 +0000
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
Subject: [PATCH 4/4] platform/x86: pmc_atom: make the PMC driver actually unselectable
Date:   Thu, 28 Apr 2022 02:24:30 -0400
Message-Id: <20220428062430.31010-5-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220428062430.31010-1-paul.gortmaker@windriver.com>
References: <20220428062430.31010-1-paul.gortmaker@windriver.com>
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0005.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::25) To DM6PR11MB4545.namprd11.prod.outlook.com
 (2603:10b6:5:2ae::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2cfa4685-ca95-415d-243b-08da28dfccb2
X-MS-TrafficTypeDiagnostic: SA2PR11MB4921:EE_
X-Microsoft-Antispam-PRVS: <SA2PR11MB4921841A9002A4E23090082B83FD9@SA2PR11MB4921.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MFElWaAer6O1U58Uxa9gc5E6wOv2IbAP6tFnWJp56hPp0UbTpx7DgW4U1HlNNYH2YySMJOIHJzVuc8QBIjOTzyCfKPa46h5Y1H+FPgGrMjotBoz9Vvx3VuZ9ZGQhdSAzHek4DIsJV61LfgTdc8u0p2QxFwbME0fo3agUnPWDIPzxYdcr+8+IgLqL9VGTlBAH8Y9H2FCOQqv0CfFGzWmdGWrbtJVTGHmaGf6O+QzLF4hLLiL/kFpub6Usf4dbutqyK0LjYxevXOOcfjBl8ZOiEcsYRhSJ5ajgIr5tsgG668ZEKQlbDHitvpm1BNIsAhAHlPFuyuBz/eRK1gntpGWQqCXFBg4qoxxkjCbrvdEH37V2hReg+rvNzfP3+HJPscj/3z9IJzpWMwYUxbEB/PfbNiZRl8FL7x7q0R0LsFomHv6nXUiziotbvehDW4tW8KoyUBNd3yYtLyv8leyxnWuGavPw8pK5+FJvPw9mroP+Qm/fImo83UelhXe9RauW446TMYfu6Lxalgv3lZshuBxgTIt34Z/J3ft8by6gaJX3B5bE3JM/A6wkrZYrTGLlaG0ELujvvRd4GNyblvf6LHbg2Y8EECJwkvn1JPUvKQdaidqTiaE8PiCxgvsyoylCSpooS43st2Av8FoMY88QTWG630fVpZYqwzzOvV51Q/7wMrG0+zCzqrXayrxSAM/ppnQZ19wKrh+l7QbUZmRtfC83bw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(107886003)(2906002)(44832011)(508600001)(5660300002)(38350700002)(38100700002)(6486002)(8936002)(54906003)(6916009)(1076003)(66556008)(8676002)(4326008)(36756003)(316002)(2616005)(186003)(66476007)(52116002)(86362001)(6666004)(6506007)(26005)(83380400001)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lvUreOB5YZ8AC9MhMIG3o6S/XQJ/SslJr4zCkW6l+VXa362njxA1jxtfKBY9?=
 =?us-ascii?Q?ce1ar/pnhlB8skIVlRXZ2VAre2+C40672q/UFgIWRIVYmJpuKvfFU/9uBdhr?=
 =?us-ascii?Q?qTGaqpIyHwMhRDcQGqBaybtjGcha9MgQEGEAj1SC0XHPdYJva1G9VWoQt8XL?=
 =?us-ascii?Q?ZmglhhWwGkbimWmY+MdFEVPh1TtI6fiIPy6dkgK/IKGfqC28Q46snhLzQRnj?=
 =?us-ascii?Q?3iYwmkVyL9brjI1Bpam8/0mnBQ++vcMbZ+BT8KpcWUFIevqAd/b6t6L1ah0J?=
 =?us-ascii?Q?OjcUxVvb4520LDPxBFByKETd+qqzEVVCExC5ig4QHbho9IOuAIJrCoZuYiSW?=
 =?us-ascii?Q?LPQH4zyjSvN0sbK48gHP2QBNB7hOfnBi+5rae7n1Fn4HboEsa+5S1hqnNbsX?=
 =?us-ascii?Q?JewcDqDRtuJv2+ChTkL2FDI12O9Ls8/FeNs18BzT3/d2diQP0eC+/6xespE8?=
 =?us-ascii?Q?DsGFDMYiMEQx56hWLTbxhOZxNpuFf5v2IMdkLDZBdgw1b1Qkt0m/GyNPO/TU?=
 =?us-ascii?Q?5NSC6monpyA7FvV9NqX3b5HuW1k+LyigmaDH6bFieCtcbqi8PEJFd85MQBEd?=
 =?us-ascii?Q?3zEgUn8eE0I60BVcbXfD7Wetxt9147fR8JTpJ0m4mJ3qAPTcfY5gXNvDrP96?=
 =?us-ascii?Q?zT+H6JXUg4AvvTLfjArO3B2UkkikctDDzzsOU6GHylpZ8siOxrhpJt64wpbe?=
 =?us-ascii?Q?yyRfIm7eY82os8/J2RIiI1wLaSxoiBIUimHbTCInRBAXquX7LXQ5LvFt5wLW?=
 =?us-ascii?Q?YlTZjmdgyj+PjL6YFQ2hzkm1tAsTgZI8bOwC5smjE8fRpNZAjCQ/nE1+8dkS?=
 =?us-ascii?Q?RlCdZFSbdd8vJxyb9osuPI6GSFmPaTA+XBqTiVdDASCD57B+2SULyToDWRAM?=
 =?us-ascii?Q?EwoPvb5Kgnzf3Qen/rL9jRA0sVwtaYmplBZXdqAP+n8CyBLlKEhW1s0y27Z5?=
 =?us-ascii?Q?qD5Srx2jZPSljjeGyDa8WVvzFCnsYDKXNCv69L3vrQ64CVBl55Gj2q63N9jf?=
 =?us-ascii?Q?LcP+t9KfOWKe2YoR+zjn5BA/snEvf63V+75jbr+Koy42Y0NNIXyP71aJL0Ds?=
 =?us-ascii?Q?UXFWxBIPHD57AWudwcgRMHhFq4Voflp3vEXYg95h7d7AdicxzUpjS2+5eOdo?=
 =?us-ascii?Q?Emv50OHXTj96x8B4JGukjNXceZCR6/ypby/9Qzi0Hedukywui5H2sB2yN7zH?=
 =?us-ascii?Q?lZo+4gPnfHvwVsv6Dp40xMMjlL2Z7EkQYkZsSfqtbpQrCxterGDUeHy0FYL4?=
 =?us-ascii?Q?MeSbkK/s6gEN5AZwVRWMCDpc+dk1triptECfRKd90ZT6IgjHQE7rgYxyvd+c?=
 =?us-ascii?Q?BMXhAVAB2qw9DLyl0E9CU8fXnnGBlerHi/LUcPRtbT1KVV0AbFX8mRKcjS5v?=
 =?us-ascii?Q?NUOr4ZQwhIECxuSkiXCRGA3YvTP/80/8qMUk/8/qW0Kmhph7CD1H47tGYBcY?=
 =?us-ascii?Q?iHrYDaOf5jqhfQ3MPRvBAJaQkvOaN5x9uvzXFY8XRAT9oOyvLLwKZ5AHsAzy?=
 =?us-ascii?Q?ozmdFd7cdRzhRo2CGBPpahposXVqTxopn6uyKn3+e6/QnJir/0ykn3RcY21c?=
 =?us-ascii?Q?e+HwKWfhY9bGW+89W00uVhPR+EFuVG1TklA2NUA6h/8ah+yZbtQWEx2Lys1+?=
 =?us-ascii?Q?sD55n9NLoJU68dyeQIxw5RroOd55Eh8+5f/nqXRgfX8cN5ILcdoBcLInnzaV?=
 =?us-ascii?Q?FqAdBQVaIRspzLRn3jhLOGX+qnS3h8wffGy77l4VxVBvsbfJTE2j9X/jWiO2?=
 =?us-ascii?Q?If/H6ygZR1rtUA+NRoSe1QQap3tpBUU=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cfa4685-ca95-415d-243b-08da28dfccb2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 06:24:50.4328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qbupXlzWtQVA9ufug5k/xiiQ7oocjySYJErQs05nxOTHbkdi39OE4z43qdba+YtYHv+jpBWzs/SpAPGkDF8JsM/PLd5Gqt3zUS+i1br4L/A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4921
X-Proofpoint-GUID: Ht-H5As48OOpJMxmyqvRlmbO51TLGpmM
X-Proofpoint-ORIG-GUID: Ht-H5As48OOpJMxmyqvRlmbO51TLGpmM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-27_04,2022-04-27_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 phishscore=0
 mlxlogscore=910 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0
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

This caught my eye when I saw it was def_bool and hence largely
pointless to have a Kconfig for it at all.

Yet there is no reason why you shouldn't be able to opt out of Atom
platform support if you only care about desktop and server class CPUs.

It was introduced as def_bool, but there is no obvious reason as to why
it was forcibly built-in for everyone, other than LPSS implicitly
relying on it (which is now fixed).  So here we fix up the Kconfig and
open the door for people to opt out.

Since putting "default y" on anything that isn't absolutely essential is
generally frowned upon, I made the default be CONFIG_MATOM.  People who
use "make oldconfig" or similar won't notice any difference.

The two "unchanged" lines for PCI and COMMON_CLK appear in the diff from
fixing a whitespace issue that somehow managed to live on despite being
moved between two different Kconfig files since its introduction.

Cc: Aubrey Li <aubrey.li@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Mark Gross <markgross@kernel.org>
Cc: platform-driver-x86@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/platform/x86/Kconfig | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index f08ad85683cb..86459e99d831 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1163,6 +1163,11 @@ config WINMATE_FM07_KEYS
 endif # X86_PLATFORM_DEVICES
 
 config PMC_ATOM
-       def_bool y
-       depends on PCI
-       select COMMON_CLK
+	bool "Intel Atom SOC Power Management Controller driver"
+	default MATOM
+	depends on PCI
+	select COMMON_CLK
+	help
+	  This enables support for the Atom SOC Power Management Controller
+	  driver, and associated platform clocks.  If you intend to boot this
+	  kernel on platforms with an intel Atom CPU, say Y here.
-- 
2.17.1

