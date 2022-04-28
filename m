Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43B60512B82
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 08:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243951AbiD1G25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 02:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238993AbiD1G21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 02:28:27 -0400
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B30972F0;
        Wed, 27 Apr 2022 23:25:11 -0700 (PDT)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23S6HAJe019758;
        Wed, 27 Apr 2022 23:24:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version; s=PPS06212021;
 bh=pqcuga7Shj31XMaNfqbNIMbYFhJenzekBiImLog8jDo=;
 b=Ff3L62LN6X+tNRz6medL8Dck6TCU2yXY8w3g+bG3NKGZG83IHIEarXKQjZwedKalkNOc
 bFe8tlWuz+BNrn7RUd2YIfah3z3h2cHPp9hwNfIIv+oVpDu7PCqFeNQH/lXnpWaccgf2
 2lH9qhBReUs0CeJqaSmOJPehqWJBh3uEt7Z0gYeqSxhaFdodtG4FBj+oVEaw3LQ7jNxI
 HzB3IW/5kU2gw2PEwEzVZsx//GPX78puoGMojne7A/pW6JQoU7Hudv/t9AsK1zw2W9aq
 zGLe94Pvcc4JcanWzJDJNwf+n1kUPh+N+bwVgqRYaAeyWG6InWE8pqTA3UfFFfJjhM6g jw== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3fps57s3ua-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Apr 2022 23:24:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N33Ui69JFMjVvaDd2Hm5w5JaqAFz7f7xXuKiM42L9ByI0ddJlQXOOj/7p+IVhz9ezxs4KFaUR00Mje7mZCXb4VnLhJq0fCJe3TASM/kE3/WN5c7bA47hV2uNV0g+uIzozHxREEIGdYittdubAor13HFa6ZZYFS3Hf5TX59sfJGYyfQ0sAzFe8in/7C6WSWI9iwOC6I4zCgj185N5VKKxcAnQ8tUDQAT6YdsPshgQlj+rabIDaRraW5XE4NHGxgFODb42MwcGwEjTYOmLvdgkwXr5q5spdJXUIe4a+25LDqr9AuwIkgEp9jvI7XIYLtg1eFxXnZYzjRMR3CLvgJV3mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pqcuga7Shj31XMaNfqbNIMbYFhJenzekBiImLog8jDo=;
 b=XkVkQFA772vWoVeCO3Mhy3+fvacthp215S1e+i1eE7+35Vo6rHf2YG95nUI3y7s8sIKwuoMUIu1g5IHLXVdGtbgNxKDfOAPltg2g1KnPicx7SM0lMGcZAkfjnDEijkzKhnPoiPBTGWXju5+9iSQ7mNXmQ5wqlUnWX9bRXxkeBsHGhbGUWcsBHumhNBGEepjdGGZ+Aa1MtuSoIHU4PKMLboTpiNETR5RCc9ylMQxIaF2XoWAwfeC3ZhGWBtL4w286Nze7wbav5OLsApYCsJar6VQJT43Q/CofPX9Koj7zENGyWJuYCViGTv5ZCevQPHfwFAlCqpiC73bqGZ7pVE+DRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by SA2PR11MB4921.namprd11.prod.outlook.com (2603:10b6:806:115::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 28 Apr
 2022 06:24:47 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::89e0:ae63:8b71:4a0f]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::89e0:ae63:8b71:4a0f%5]) with mapi id 15.20.5186.021; Thu, 28 Apr 2022
 06:24:47 +0000
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
Subject: [PATCH 0/4] platform: allow ATOM PMC code to be optional
Date:   Thu, 28 Apr 2022 02:24:26 -0400
Message-Id: <20220428062430.31010-1-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0005.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::25) To DM6PR11MB4545.namprd11.prod.outlook.com
 (2603:10b6:5:2ae::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cde7c2fd-9f3d-4211-5820-08da28dfcad2
X-MS-TrafficTypeDiagnostic: SA2PR11MB4921:EE_
X-Microsoft-Antispam-PRVS: <SA2PR11MB4921E4204F11FF1ABA2D3AEC83FD9@SA2PR11MB4921.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xL0DaJTV1CY3WvP46yxbG6AVuNpKFNfnSCGX0zJAA1/z4c7Gssdp98LWrqhvzhcFF3CIQ70JrYZe49D791w6H1t/m8Pe51MqCr1JcUuQyXZmc6Mx+X8jqtcfGNQBr9Ya6/Jh0X4MEHsG4j/YhvNDhYAlfq9nAzmADm+Y/D2gudH1iOqN3wPV6TsgmhxH4fIiI4zh4534uTh9NmXqMhUjnVwzlGFcQj0kRHtbZ27TRAi2BN7seXC6yJwxgVLuuqN4ureGGTB2ob8DQXcD1iloovauEieCApRbC7tn+/Tlca9JsY7CAHwnBS/XviMzdiwik4ewV4WdZPpzFT2QSi5qwCQXyxDdEjVY2Sy55SrihD+Dk0A9kp2g7jbkeixs95sl7+7AYk3cPwenhkCgLTJK6+Oyl2cJ6bDQcP6vnMAD5wZinUCHAZpxVtl7XOBr744gVrNctQHpsolakRS3x3SQOBIRGFMssHejQKdx10mS501sI1mjWQFIhEQ5VD0KzvUpHJcwYgfoRjNRkfgzaNlxLnWyv/acWZfz9W6sYJTp5mNP8jVYBu6qbeUGZEdODG5pyjsMZ0WUK/ROojGA8MsVLFkyh/inVzZzM1NZXw5WgiYx8ZGbn2j8LPP6I73gpk/VIwgdi0iuu80AoaECc+eBkui+w0QhKgRvldHoegvXAhvv5YBYIjZECmhKlKmWVtS4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(107886003)(2906002)(44832011)(508600001)(5660300002)(38350700002)(38100700002)(6486002)(8936002)(54906003)(6916009)(1076003)(66556008)(8676002)(4326008)(36756003)(316002)(2616005)(186003)(66476007)(52116002)(86362001)(6666004)(6506007)(26005)(83380400001)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?glZWhnyLNDVrIFNfdmSHna/YPmTtc0+Ffo5b1NblEqYTwTdzK3o4L0nk6tcU?=
 =?us-ascii?Q?tIjfXLicchPdIqsa/HPpJ8n0g2giPjVcW0mV9jpOs3I5D5J0pGTyAnIKENZ5?=
 =?us-ascii?Q?ivEU/to96rdATn2rzBE+3HAKzTsEvggcExZdmffPv14xPT6VUAnoNL7ykHwz?=
 =?us-ascii?Q?dss2qfSlR8AEjpMkDVLQZ/IxFrxPhtFGprsaGEWHZhFdV7iZdry6crrDl+Mi?=
 =?us-ascii?Q?1vDnwp93UhlquKpBM6N3FhIDU79cESkqWolD8knC+KreSnpnHCR+QvAypyjK?=
 =?us-ascii?Q?yoXtSJwQm25cPa5R4DTNTxv3wwfc6Zrtco9qen2Wrv/u8hhzw0LQ1jKENbnQ?=
 =?us-ascii?Q?nI1DbxlGioPIxJsBwqv16ePJhZidbn8XR7hcS5KJF6k9WEMXpQJSUgOFozBj?=
 =?us-ascii?Q?nb/80en2WTwWkdht5mN+uo7BPyyOOgagBwfdF1vKlgI7j68NFxDfDyETwpkN?=
 =?us-ascii?Q?ldYTSwiN0utNcmQw7lSznmLRmYn2i13s8Pd4Pk+JbrJR0QUAvUFR3y7aCFW4?=
 =?us-ascii?Q?gtfLlRDNLcKXs6Rq3+LYmOnjsCG7oV1MucgHPgf1hfs8wm5m3DRvfKjtEt1L?=
 =?us-ascii?Q?yQTgKodhLh+KVddxSnhKEx7n9lzGs+xJTxjeJ5CJwjD/5VqKWDxsoeLkJglu?=
 =?us-ascii?Q?QoiRHyrddIEtAKTyo/HKGD1+oDAKo2Tl8tapaWo6j/hNzdJhTUaLKH6jmYGD?=
 =?us-ascii?Q?eJVR80EC+Stz2U1lOZj9HoKQZ3atcbb41h6R0nziMSsaz42+v9qEjiTlsGfs?=
 =?us-ascii?Q?WuoR+hmtQPP35Xlt9oamyiawvY13lAkyob1O8NqymwOESkZFPK83sOO8rHux?=
 =?us-ascii?Q?LOZUPHJR6rwgZGWK9EoY4dJTo67JixBMYStVyE+vDpXGx5PrLNN64O8huzq8?=
 =?us-ascii?Q?iudzoA2vZt921Dqig5cZLt0KE+Z2iRTgnynsbrH5zfx98yFEzf4BfscDJbOY?=
 =?us-ascii?Q?jAnXYJe5bojORdzcwkcUfQpup8zv+v4QNhAU/loGvc62EtfF9bca3DuIBGjm?=
 =?us-ascii?Q?E6vGImkvY1yxJVwV6bg/GEP1ZR44zdcjgqHeNcqH7zN7rwCEfRIE0dvb3zDG?=
 =?us-ascii?Q?qODWo+LoHvJhDLoiNf5d4wgAFgh5t3nrzhtWD3ISJdbBti9yTGnuAvLtFCD2?=
 =?us-ascii?Q?wU52tPSycPd9IrEC9sWJNnqrAlBIAnNVGQ/3nWYlVWByMx+qgLR6ObXiCuJw?=
 =?us-ascii?Q?cUfiXf2497L6O03cFeAtVQCYM6n/xgvwQvXuJXgKl7FxYIvJ7VWKeKVJfLf8?=
 =?us-ascii?Q?RNGvWu/iz3oqcOjNssdLV1DTX79fNJyEFvjB9mfn+Ims0K7PAyF9jNIpKnsk?=
 =?us-ascii?Q?irCeva3Gvo+5RDDE/Wdh4fAZV5vdZjYU8b0rHMGBY4yhTP8A1Bk0u8Tvhs9n?=
 =?us-ascii?Q?Bk2ZMUF2d6Q5HLhS00TyxUldMDPUSaKsf8r3ZPBPkn1v/Ns0ZYpCv/HvZZ4g?=
 =?us-ascii?Q?txBYx5lN6f+Oe3b1X7lH2vqEAlBRwo6cd7WHccambGLzIhduDUSZCVlgss9M?=
 =?us-ascii?Q?cjBkqR1hXfhiSNV9dKcNmlRt1gNtzHJAHdnh7uPtqrIdBwhy8b/7EOepCzrq?=
 =?us-ascii?Q?y5sfpD/9CeityIyASh8kmXh0pX+ncrqsoHKplx3eYCJRCXMWHYEqxK5kjRmK?=
 =?us-ascii?Q?dfJxA3GwnriNEJhXEeG0DIyQNgkRRk4VZodDm7hP5UDyEBJp3F6PadfItroj?=
 =?us-ascii?Q?6Gg8DzY7ijHQb3FoAWyNNoXZldNwbFpdDR5MjCkZ+tRTxDpvApP5x60GEHSN?=
 =?us-ascii?Q?VufqJtXAVPEKPIwf1bnmYPuSpRhS7wk=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cde7c2fd-9f3d-4211-5820-08da28dfcad2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 06:24:47.6477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oKcxZzVYduYKLkxFNhUFMjSJNrWJUDgznhJhIHUo/8GrA0LpBWblG7ZARucGL1uVLlTDhWutJOIuGXlOjOh0Z4uW/XhoLkkw/CwJMrKda/Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4921
X-Proofpoint-GUID: Ldl7JBRs2VlXkQpVXdjtQ-F_slI3JAoP
X-Proofpoint-ORIG-GUID: Ldl7JBRs2VlXkQpVXdjtQ-F_slI3JAoP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-27_04,2022-04-27_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 phishscore=0
 mlxlogscore=720 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0
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

A few months back I was doing a test build for "defconfig-like" COTS
hardware and happened to notice some pmc-atom stuff being built.  Fine,
I thought - the defconfig isn't minimal - we all know that - what Kconfig
do I use to turn that off?  Well, imagine my surprise when I found out
you couldn't turn it [Atom Power Management Controller] code off!

Normally we all agree to not use "default y" unless unavoidable, but
somehow this was added as "def_bool y" which is even worse ; you can
see the Kconfig setting but there is *no* way you can turn it off.

After investigating, I found no reason why the atom code couldn't be
opt-out with just minor changes that the original addition overlooked.

And so this series addreses that.  I tried to be sensitive to not
break any existing configs in the process, but the defconfig will
now intentionally be different and exclude this atom specific code.

Using a defconfig on today's linux-next, here is the delta summary:

$ ./scripts/bloat-o-meter -c ../pmc-atom-pre/vmlinux ../pmc-atom-post/vmlinux|grep add/remove
add/remove: 0/410 grow/shrink: 0/7 up/down: 0/-47659 (-47659)
add/remove: 0/105 grow/shrink: 0/1 up/down: 0/-6848 (-6848)
add/remove: 0/56 grow/shrink: 0/1 up/down: 0/-10155 (-10155)

$ ./scripts/bloat-o-meter -c ../pmc-atom-pre/vmlinux ../pmc-atom-post/vmlinux|grep Total
Total: Before=13626994, After=13579335, chg -0.35%
Total: Before=3572137, After=3565289, chg -0.19%
Total: Before=1235335, After=1225180, chg -0.82%

It is hard to reclaim anything against the inevitable growth in
footprint, so I'd say we should be glad to take whatever we can.

Boot tested defconfig on today's linux-next on older non-atom COTS.

Paul.

Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Aubrey Li <aubrey.li@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org
Cc: Mark Gross <markgross@kernel.org>
Cc: platform-driver-x86@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>

---

Paul Gortmaker (4):
  platform/x86: pmc_atom: remove unused pmc_atom_write()
  ACPI: LPSS: make the Kconfig dependency on PMC_ATOM explicit
  platform/x86: pmc_atom: dont export pmc_atom_read - no modular users
  platform/x86: pmc_atom: make the PMC driver actually unselectable

 arch/x86/Kconfig                           |  1 +
 drivers/platform/x86/Kconfig               | 11 ++++++++---
 drivers/platform/x86/pmc_atom.c            | 13 -------------
 include/linux/platform_data/x86/pmc_atom.h |  1 -
 4 files changed, 9 insertions(+), 17 deletions(-)

-- 
2.17.1

