Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81795512B78
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 08:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242003AbiD1G2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 02:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbiD1G21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 02:28:27 -0400
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CC35A5A9;
        Wed, 27 Apr 2022 23:25:10 -0700 (PDT)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23S6HAJg019758;
        Wed, 27 Apr 2022 23:24:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=PPS06212021;
 bh=aItVUOEpLYfdRTYrg5TGczriMieIcIkd1VOooKonveQ=;
 b=FRtgA50NY+5CPyfpNu0itrLH11xWSHwIClOfWKvIIqsrT4E7hcKwELwtWM8VJOWTmn2o
 SaZqgHM3n0Lj03awgGJSzhQioFWWPCth0qNLkNzZZnp1uhcyNtTU4qDY8V85qlbvwGA4
 AuzlO6K1Mh7KkIS6++ITfWaO0PUkEhV8ELECUIYhoG4stlKO5czGtyws2lZEgNgKnFWr
 Lk/mC+HMLflm+UHYHOve9CvOZa76n1sSDz4pOaNUf9apAEg0XztL4eWNDruZzetou3R2
 t9MZTV5D3diwCBU7Y/YTJFcOitbFA1GDZ55JIiscmjAmq3aZn+nambKHViINtHtZW4ui 2Q== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3fps57s3ua-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Apr 2022 23:24:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ddzFnKq2DJMStjsx4Cj76bSpuaOVLbYNpyYe3pqm70eyNgUkAmxVhEGvlGXyDPlFyhPW1eFLIadHrORUnIyy0sprUUbDBqCl4q3NKNEjvuvyLCl8234nK5i/dkG5Niw9MNNJkFgY7ImRXYzjjW+RgFfe0RjfM3irQikupe3ifIBNIb9PAoKS3NM9zns7eHHnlmf7gvOKykWY+2atHRE+Mxer4UkCXZ4UovuUvViI3jNwYvY+35c7Mwwgr6qJ8X8ei1sbYTu3d+witLEFmUaZ8IYP9obKK7YSRY0lBiLZ8LthdWpALBnG0uvRgCtVgHH+yeQOQ6dg+uUgOhDqq2QvaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aItVUOEpLYfdRTYrg5TGczriMieIcIkd1VOooKonveQ=;
 b=NcOAF6SW9zvU1XhSkY9LXaLaoolWMdq2l2vXA2/UOJ+YkOZE9qPJpky4vVPXE/qDzyGt7iSUfiqTQ+ybMRdLTXoOntzJwsRzlADtqONpxlbgpjxShFKUgZRTtDiYBb4fmgxB9YrSKwYobw0tCByhK2BHkHM56nn3o5q+tBykZVuXoDcmC9Ncn2Nb4Ou8AeWTmB0fgPk+PKnPGkrAdlKOp0Zd0jebLpfV0mZd7Z65TNhKk6lDBhyLYkm74qby3+1QZNRYma9PWq764kdScUsaW9+fVkxizNvNOC+/JI4Vv6bRPbMvGDjygOSDjsb1Qvv+Q5OA+KmWJ+9aKPri/A2PPA==
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
Subject: [PATCH 3/4] platform/x86: pmc_atom: dont export pmc_atom_read - no modular users
Date:   Thu, 28 Apr 2022 02:24:29 -0400
Message-Id: <20220428062430.31010-4-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220428062430.31010-1-paul.gortmaker@windriver.com>
References: <20220428062430.31010-1-paul.gortmaker@windriver.com>
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0005.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::25) To DM6PR11MB4545.namprd11.prod.outlook.com
 (2603:10b6:5:2ae::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75e55010-e3d0-45d5-d463-08da28dfcc4d
X-MS-TrafficTypeDiagnostic: SA2PR11MB4921:EE_
X-Microsoft-Antispam-PRVS: <SA2PR11MB4921B03648D50479C60A293783FD9@SA2PR11MB4921.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eMKJ9yFA0X+dVxBQB7wF9JfuSHBTvwdAnBG40Z/5INMql3k+zpJOGpwatFG2VjX5QwK1m2umZKcPJsxfhpY6YFs5jQ+8f4BFdK51GtBFZWHzwYptma7RNjvJPIDY/EPD040XWrL6cRS+9/Ez9yQ/Z2/E6qoubzvDD+3PVa8CW9nH8mZfIRWso1S19KgUvSkwhj9WBloOyUpZ0RUezpd7Xe7KFdC/yMMY1znFQSRvBuEzMG63kj4YhEASia7Ed07WByqZDQn3Jf/++/Uyg1xPYfuuBk0bNVTSYt6JcJ15QKGEEWk7cdK9kQvgkR4/XboYnYwgjRX2+5BOnFM8lbARhlsYdb4+MFFfqauAEiFwGmWWTFfZttKZ8M+ZkRHUR7V3lMvQTzeiCfpLOpJWmspCxtDSIFr4kDeOSSADWaq3wBAcyWngAKfDQ99ZHx0vg8rdsk0z4XIhxS8U2YW4yvPCPPixIqzbOerF2DmoN1tqoSKWXreNieI5GhE0CeJUO116uzIjT2OveGAW6qa0Ql1AAn65fjpqbcP7Pr1qtrZOVAPhtfG+M3J7O6zN9b3Un0n8X35Oy85XpjGoBX4l80/IMClA4c6iRSP4HolVo/SxSu6e2dqSKnuNq1IYple8BK/d89tIsHhhqf0x6jjhlYIJksimIy290HUINVVn1iF3/szyxbG9cJp/XM+YHq3191zmpaxRYSz+E+Fb1UbIGuXLAgs+uIU5ZsVCWlyWXaFMm6cbRqJcyo8dj+5EgId/ln2qSRdMboWR5SkEc7gdca0Awnbv+Sk/f7i917aVeZxwZss=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(107886003)(2906002)(44832011)(508600001)(5660300002)(38350700002)(38100700002)(6486002)(8936002)(54906003)(6916009)(1076003)(66556008)(8676002)(4326008)(36756003)(316002)(2616005)(186003)(66476007)(52116002)(86362001)(6666004)(6506007)(26005)(83380400001)(6512007)(26730200005)(192303002)(19860200003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QiG3JxDusXg4WiMLneKWb373/FpDxzHutcuhpvOPaRIB+TofqMweAkQ4t60t?=
 =?us-ascii?Q?2pRM+3qlKeUhB8WCwWztdXKspwbM+JTAW3Zm+4s/51tMlxd7mYKJUyT9suBk?=
 =?us-ascii?Q?ZHq11J466QWPeGCq6AXS9kFebXFw77G8csegpGcHGbGKKpkduHkn8cWs5WV5?=
 =?us-ascii?Q?wUyAudHGF1dCX+mWqIV/g9fifctHcaCX8s+hUMWTk24lb0JcGO2nBSCTIhaS?=
 =?us-ascii?Q?ip7WdlAmG0iA3p45EcPnycj4RSF8wpdX4K+VMqNIrAuDOWpX5alWJ7hqyy5l?=
 =?us-ascii?Q?sy6NEOsjP6eTW6gsgMKkdYJUzHV2nf9ANJmjwNmNHyPL3wE+auG/CFhXNGDD?=
 =?us-ascii?Q?IhsjP3jM5+ZpwCFNAmDJdDuIp/n6ySpSI+K5c1u81fisZj9gkmAsJPLOLJmL?=
 =?us-ascii?Q?I4uikAq6WZWj8JYHRCyw2HL6QJFUg8DGOeb+v+47lUfdD1m2xjB4pyONQBwr?=
 =?us-ascii?Q?+fotW5AetIa16K5b/jqJRnLkSLTXGL5AC+xykUHMTMcB+OdYf0Lg4QgCGbKP?=
 =?us-ascii?Q?DnMCXzmey0OjfQDGAZCm2akwRpMHbD92VVFkZxTCEXMC9xbvNP1QuhMxfMg7?=
 =?us-ascii?Q?4xyT7qBOzSXlilih/BxrRNwnHSKpLIeuzd3dSUEDqdiGfO8h9JJD/L/jiQHj?=
 =?us-ascii?Q?dr3zgAG7eljOwncboQYcKR+SI/OpjFRrZwJzi9U9i0S10HIm4twLfGbEj9lr?=
 =?us-ascii?Q?BUgngcKc1UMJmlsSo3n59Wsm/zSyjuuT3ulbpXiE3s0w2WvlhNSF5HV29y6X?=
 =?us-ascii?Q?SlA2II2Y2JSgsyO7R2G0TXcqeWtVHz02j7pLreb2YLsyoZfbsyJ/lDRQH02Z?=
 =?us-ascii?Q?IDYb5gZG19wNcWvAlU6A6yHu6Zg6tRZx1wdo2nLuQFQWm86Bej1ENyYjejuW?=
 =?us-ascii?Q?uvFph9/odyzTswle7YuhGZB7R13oFS744kCL6nhsWnzDwhjTWLrRPcJ0vczF?=
 =?us-ascii?Q?FsHdpldactldqSKrZ1fis0MhJ7a75FLHda1s1EpxvURhUqvgDThozTc1JteU?=
 =?us-ascii?Q?5xTyi9ytW8/CJr87ToBkGMs68I0TECStE+LRkoU2qR+ZYWCZdURCWVHC2zwU?=
 =?us-ascii?Q?2z8RXnScdU4pGl2dYfZRPzovaxAikzf3GJNboy/5GVbayywwUHWEc3V9DxFk?=
 =?us-ascii?Q?EOIOG9BP7AyKOfD9y90C6td8q1tCJytWY8251kxT99gYbSM4oWGFAx0Y9KGy?=
 =?us-ascii?Q?LFwcGvBC/YnZorqZq2AaRNMFjVazQ731PaGhLJdKo6lonuBJx785N+3t3stz?=
 =?us-ascii?Q?FWXWFiQ1AE8sRC444yzGA6vNISfkHlIL74k+jwBAd3ap5UHY9l74HuO+317R?=
 =?us-ascii?Q?lt5iID9M4QzlalL/+EiRxYgv/QCRNpBtJgmnPZNNxGuBWGgkmDDUlxtF4nOs?=
 =?us-ascii?Q?8t8Kf2XXJw6aMon65HN4sVrCxgZciTd2SV0fmnEnauJM6qQCl1o+L6mmMOfp?=
 =?us-ascii?Q?Ilk8NJsIKBW5mjOVtfbE3GjcWKdHV8tGeMx+Qs7GEfRYv4TEG5nrbRw7ztf8?=
 =?us-ascii?Q?eiR7CKkDZDFrNaceANq5NbYxO76xInZWaKJtrzfOo/L9kIGaji4CvGIDrY1E?=
 =?us-ascii?Q?9wlIxxTJoVf6hwb9NqmJafsjRBppQl4xsCr9yxqOurEaHOcHO2r0bKWL9udy?=
 =?us-ascii?Q?e+AmE/fFSGIr0E1Xaua+nWcFdNT1MNTRvpR/k82pG792P6kWURancC/ozA4d?=
 =?us-ascii?Q?fHvmpi1dvBu1MRulrBG6oa8N/F/4xtE54eYaD8MEsdQZ3O0oR1vhGIWOtNwi?=
 =?us-ascii?Q?eKo8PTD5sDGyG+C/UwIytfokCXNh4EY=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75e55010-e3d0-45d5-d463-08da28dfcc4d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 06:24:49.8379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LDcOVaLfdLMkb6YhKbHrT1a+kwUObx9ne5MNtOn9mxGeE7JffWGjl4rAvdS6pi7Lq49mZ8Ddciqu4qi2Z/MHysWwK1dMliJscF8GksLfF+E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4921
X-Proofpoint-GUID: 0MOVjOVB6A44zMixY2dTCeuo-h0MGrNU
X-Proofpoint-ORIG-GUID: 0MOVjOVB6A44zMixY2dTCeuo-h0MGrNU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-27_04,2022-04-27_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 phishscore=0
 mlxlogscore=703 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0
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

There is only one user of pmc_atom_read in tree, and that is in
drivers/acpi/acpi_lpss.c -- which can't be anything but built-in.

As such there is no point in adding this function to the global symbol
list exported to modules.

Note that there is no <linux/export.h> include removal since the code
was getting that header implicitly.

Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Aubrey Li <aubrey.li@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Mark Gross <markgross@kernel.org>
Cc: platform-driver-x86@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/platform/x86/pmc_atom.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/platform/x86/pmc_atom.c b/drivers/platform/x86/pmc_atom.c
index 31cf25d25d66..b8b1ed1406de 100644
--- a/drivers/platform/x86/pmc_atom.c
+++ b/drivers/platform/x86/pmc_atom.c
@@ -221,7 +221,6 @@ int pmc_atom_read(int offset, u32 *value)
 	*value = pmc_reg_read(pmc, offset);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(pmc_atom_read);
 
 static void pmc_power_off(void)
 {
-- 
2.17.1

