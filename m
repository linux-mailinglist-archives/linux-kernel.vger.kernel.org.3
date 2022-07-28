Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 389FA583801
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 06:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbiG1Ej6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 00:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbiG1Ejz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 00:39:55 -0400
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9BD51409;
        Wed, 27 Jul 2022 21:39:54 -0700 (PDT)
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
        by mx0a-002c1b01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26RJkBSb024220;
        Wed, 27 Jul 2022 21:39:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=proofpoint20171006; bh=9e6RM5dqI627zdgXBF/kBZc5p6DjgELE2u2+V7eeZHE=;
 b=0K47IrGdffiqYVscCAedyOgP3xYXFYQuQ2lvf6+HHS/f70hhvzVIiAr+wHkbTJ4IvPeA
 dNVpGKRZ8Unbe2P4mq6YPPf14qNrbGMoAoIbnQKSMfJo68uIVxR7lc3DHH4WRBOw2VN3
 DBk0+kySdLWbfaCQ77gjRDSwkYMg9u9D0DaL4BitzMvoJ3NGQ4HmXbB3ra9aI+Z1Ghjq
 NuOwo9/1gpRz6C6A915lo2k8W+n9G10xPTowdXhjbm8kIoNWWW9CFylYkmaG4+RHNXpS
 46xmI7uCkAk2LU7tV0lnqDJMjkjwDfj9wPRkmOjJ5Y9MGxitglwIgaz06rtfd69h/eap pA== 
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2043.outbound.protection.outlook.com [104.47.74.43])
        by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3hgghy32bb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Jul 2022 21:39:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XJ9q2gOprviI5ZKWiPLh//fvGdQQ7dFLSn2dvdrgxiNqaiL04iycWP4YlYcdFPMwFTVeUerxk/TQ/Vf8ywLNOh1kTv8sBSsx3neLOqPR08GwzEHiZxrYpVNM7uoL1yKoI5pTgMCrw0QYzKeWSUpQ15FqcIeOlyPAa5r7+wSfaTOdOmUbenqIjlaN3Y7eXwrEMyWQc5AVv/m/MZumD7EHEQ8gdx9fEk1wqIBWttsw9BeJTaX1RhPa0lfPhj4eKLvyS5wlfUzn/vjmCX5bAjPLmkBF0YocRRIJ451/4J1mU10xgeazabtNccEotU9mhS+aYD09QWeVKQzdXVh+/z761g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9e6RM5dqI627zdgXBF/kBZc5p6DjgELE2u2+V7eeZHE=;
 b=ViNkFuynymrKqxU52gB12RVsXF8txv4gh3LCFDXaFKvF4arZ0PCR/vM8bmw0/7XOBUuBylIAyR81qd4OzbHNM0IEtHKaNkMTHJv0Utw8Ho8CeYAd9GGtcrbw4uVQ9nVyWVM5fh1/qXYAmgmW9f0lYmcOAjpFKjhFkkzhgApO+rg/kbaVFcuD4n0OsK3ta6U7e692uzG8XsYcwGBbvDKgt/vi1IHkz/Ou2C6rro6c+h3BukehGBArXxir6nMxYH1ZmSxXeLLQG2yXd01qn8m/8rmBe/ht6r6pEbQqLdLrCXt9KCQNm7oO9s83DGdWVtTWrxMtxOp/BTK6aukWP223Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from CH0PR02MB8041.namprd02.prod.outlook.com (2603:10b6:610:106::10)
 by BN6PR02MB2755.namprd02.prod.outlook.com (2603:10b6:404:fb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.6; Thu, 28 Jul
 2022 04:39:35 +0000
Received: from CH0PR02MB8041.namprd02.prod.outlook.com
 ([fe80::b044:2472:ac8e:6acb]) by CH0PR02MB8041.namprd02.prod.outlook.com
 ([fe80::b044:2472:ac8e:6acb%9]) with mapi id 15.20.5458.025; Thu, 28 Jul 2022
 04:39:35 +0000
From:   Eiichi Tsukata <eiichi.tsukata@nutanix.com>
To:     corbet@lwn.net, bp@suse.de, paulmck@kernel.org,
        keescook@chromium.org, akpm@linux-foundation.org,
        peterz@infradead.org, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Eiichi Tsukata <eiichi.tsukata@nutanix.com>
Subject: [PATCH] docs/kernel-parameters: Update retbleed descriptions for "mitigations=" param
Date:   Thu, 28 Jul 2022 04:39:07 +0000
Message-Id: <20220728043907.165688-1-eiichi.tsukata@nutanix.com>
X-Mailer: git-send-email 2.9.3
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0131.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::16) To CH0PR02MB8041.namprd02.prod.outlook.com
 (2603:10b6:610:106::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7c15973-78c1-48ae-ed26-08da70532c13
X-MS-TrafficTypeDiagnostic: BN6PR02MB2755:EE_
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EEKzoPh5DP2z1V71Jeq47X0NG5cwGo0Bts2jiFgM0FEB+0OnDYAtFfNaC+Zq9jvmeeV6GAB/TsszZWuUKTwgsEWA3K4qbGazmTIiyUMNjPn6sVmGj4QkaVl9tRHwsIWKI4Jmn1Q2Z/RAx54oqWl0+ite+aFRLipV3vIegxKdDZ/QYVLa/cILF3dAz9ZE2KgHRDTzKAxci9Cq+QtNev+KldeQ/RV2C2jyAGSC/P65NsCorFDACavqzVRDXMIICJ4mBdd12Bc38tBmRkjfiwSL0Dp+VfQr4toDzetM/r0lYrEvNYD9NBJQsIfMJvvDODV5YK5kZbNUlJT3tGM/l6zDMYvc5x0aYK6RwXdOmxMl7FRuX8X1i70KRpJI/QO4tG7JDXKZpCqKu0o8Rbt6MUE/edcqvcMX0vVQwrZv0qVWHX6mwooqjYiyCuoveMBG+Nf+/+OQbYAcQ0uJvEKAGONtnHunhynzjFAqf+BawJUO9399NJ27a7hxAYu4M2POGMo4gkmU8KaFy0WFntPDijdWHO5NWAc1oJCpQSNanhRD60PsGfbM1+Zz6FcmZrtGS7Do0sXzeCjJAHVbvs8zcoUwntQ5VeINfIl3/aHPMSN6MVIuw/oF4YoMz0BQWJwB1/B+97SKTcuNV0o+BRPpSnWZvFfg1rQ+3q3ggW4OXG1Yh5O4BUtapiCqvLz0dGOUHdCaXdejwk+Mj3Bu7RXdJNUCFy0oW084iJ+6WaX78sFMR8Us+NiZJOEoen60++Q3taD66l8VEgWb5lb5gunSBOrpohtUunMoXzbdXrRK5a+cOlXNF6oIoSOA+6IwooRl+Hph
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR02MB8041.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(346002)(376002)(366004)(39860400002)(136003)(921005)(7416002)(44832011)(4744005)(38100700002)(15650500001)(6666004)(38350700002)(41300700001)(2906002)(1076003)(86362001)(186003)(2616005)(107886003)(83380400001)(26005)(6512007)(6506007)(52116002)(66556008)(66946007)(66476007)(4326008)(8676002)(316002)(36756003)(5660300002)(8936002)(478600001)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OF+RNn/IF46oXOFnpzOhk0eAe7a0/VYyGr3FR/du7//r23jomyrdlqT90Nb9?=
 =?us-ascii?Q?1bwbP9jBP+RA6vlOhtCL3iuyDAXoBZQHdMrl2VwPsgdC73oqRmDKCO7W3UFG?=
 =?us-ascii?Q?Gqp8fZaJyt7nLj4ESzvAkpwzl5FiPNjsPqI9K0tMCffRHCu5Z8opXgtI6A0U?=
 =?us-ascii?Q?IWOMEm8Pwq1Se5FAXZ98+ZO5mAtOEIH3/4YHA4dijpaYeDfoXnhpNj2JkmcR?=
 =?us-ascii?Q?GlmzC90TUTfSi80HnUIP0W9AkANIXyq2XPMwwYIxo5+FURSAd3fLXEa1KrcT?=
 =?us-ascii?Q?0+RL7IdikHnEImKCqCi6vddrbVji9vfOBDZiZevjhZNTn9aBLy4tRMlillu0?=
 =?us-ascii?Q?EqZreOqVeXy6e2gARYua0b21BIZ5LhCXSccJxVKzDwm5g/3lo1ds//+m8diI?=
 =?us-ascii?Q?tbU25bn+JbTkc1vDH8B8/moj7vbQE1PvXN3caSdauMSL9KGat9HcJ7r8vW6p?=
 =?us-ascii?Q?Fhe10+x2kzb0EpfXZYhztSdzEjrrgXo7+Gg4Vnb4PByeO9HvBIugsfx8Zf91?=
 =?us-ascii?Q?gYVK8u96nyEmPYhEhvrWNCz8AdGdW8TQ73C9ohHQgkrKGGpDLU8ZBWNbThvW?=
 =?us-ascii?Q?B0eSgA2JbyoZkp89UcCBZmq2i84s/E6yXPQcAVDbqxWz/kwVE8V0/CkQGSKL?=
 =?us-ascii?Q?DYn6/7TxtZfuv1YISxX0AcAVVbXB3uJi2x5xTbOVvxtKqPwhI0O9ss1aQh3v?=
 =?us-ascii?Q?qQsJl9jmmupdCT67oNAHZewEqLke1BubqhkS0Rc4R7QVv/ze2+YS/5r7Nn16?=
 =?us-ascii?Q?jWUb8ntaWy897FTfyXM8wyHxyoKINovBrgBm2LFBWUlicu8ekerkVu2S5ZFF?=
 =?us-ascii?Q?kXyBTbXRz3iwLKsQxnWjiQAmPZMOeDj+QITGgtuJBjLwraoOV6pSmLw3FOBa?=
 =?us-ascii?Q?S78CRuR4N90D+e/UErNIg411W52yEYtCnKylq1MDLqMneyCjldHHmFxJMe9E?=
 =?us-ascii?Q?aHLgYJ/3a53Dce4dMvWkLWyKOX0RnXsvGBm90cT8FWUzmY4tBH9ASQLSr78p?=
 =?us-ascii?Q?j9hGHcnZ7n2rziMMnMk+pfMVxdqO2TjxQA/RPQoTHlfOp137QBHIY1Vlc96C?=
 =?us-ascii?Q?6zeH3Wv5AnFMRC62OhgG1cOK5biSCKEEGjhvYJRrt0mCuMEOONuUV9V8bmsX?=
 =?us-ascii?Q?w9WBLRHRMEFF4joadp8qTCc8YqcTc9+bo3bWREnUZuxxHO34blSLQTaBlmCs?=
 =?us-ascii?Q?jb69T6Q4gqfgt6sf8yrJJ+tmfzsV4HjxwiRIPxqdY6JiNUWsscn6lvdjLLtk?=
 =?us-ascii?Q?QKYHkzLTKVPuEEeP9DCLuTnVsSXZ7EGSpeqUmVE0oGdr1t+L7PIrdvaixF/i?=
 =?us-ascii?Q?glUihGXzyjGlMb7+MH1FFMxjPGBxxcmR90DNs+XraKpqHnFQ+olbHVEuXgsV?=
 =?us-ascii?Q?GNEThSIH+VOErw14sbvRVj/Rfpfd8gcj03gVBf+IAtJbiVvbea55ibcICGqb?=
 =?us-ascii?Q?ghJ+YcbEV+TsxB+k8XKcRCSrPhye5EOYDsB+kqdkmmrKFdfgKoQrPiNGIKQb?=
 =?us-ascii?Q?P6BsmXOf+vQ091jLLbORXxTFagT4JptEojSOYhlV4cVPGI8LEWg7THn+8h8l?=
 =?us-ascii?Q?1nCeotobjsTq9Zo93DByY/d+Nko6+jhFF85gQ20wTo4XeasCbQAL5P2GtSNc?=
 =?us-ascii?Q?fA=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7c15973-78c1-48ae-ed26-08da70532c13
X-MS-Exchange-CrossTenant-AuthSource: CH0PR02MB8041.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2022 04:39:35.2334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rmFAdoOb7xYYQ6sG6b1PgT1tzM5BKhg7Lnkh4JNiSgSngIGUBA6U6c4tNI1dlBe7re0Iz34/weAu4Uddi//e7YlMnFPrBfdJYlh3/KWLI/I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2755
X-Proofpoint-GUID: hRFUdm6X3IuluInRwy5fEYfDhWEUnA76
X-Proofpoint-ORIG-GUID: hRFUdm6X3IuluInRwy5fEYfDhWEUnA76
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-27_08,2022-07-27_01,2022-06-22_01
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Updates descriptions for "mitigations=off" and "mitigations=auto,nosmt".

Signed-off-by: Eiichi Tsukata <eiichi.tsukata@nutanix.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index c0fdb04a0435..cc3ea8febc62 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3176,6 +3176,7 @@
 					       no_entry_flush [PPC]
 					       no_uaccess_flush [PPC]
 					       mmio_stale_data=off [X86]
+					       retbleed=off [X86]
 
 				Exceptions:
 					       This does not have any effect on
@@ -3198,6 +3199,7 @@
 					       mds=full,nosmt [X86]
 					       tsx_async_abort=full,nosmt [X86]
 					       mmio_stale_data=full,nosmt [X86]
+					       retbleed=auto,nosmt [X86]
 
 	mminit_loglevel=
 			[KNL] When CONFIG_DEBUG_MEMORY_INIT is set, this
-- 
2.37.1

