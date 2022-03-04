Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD004CCD0C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 06:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238162AbiCDFYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 00:24:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236824AbiCDFYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 00:24:04 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2131.outbound.protection.outlook.com [40.107.244.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D6A186426;
        Thu,  3 Mar 2022 21:23:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EGuESXKZL+aVq32LOp3PlUQ4h/RRDnitujj9YMFF4eYP15uXw/rqMmvoswzsY+rSdMyn3E/iHHCaciEgcwt2lnSn34aJrdzbTrT10F5lGZiWLfKlJ9l/x9nOJiFPwG9jz/ujrkoDHxV+IGg/tmjFR6iy5fL1HsY8gd6vLS4RfMGq4kdwsNBHq/FM1nfSXJeiszhjARiwjY/+514VTGzt778hrbA5CUn+V1kg7buR4UZePgYZEDGg/Wp3Pu9DTp1gdVrnAsVTTWkAyNdDErKUOZx4T1mKsSnvzo3n9OgkAaNjmfgUpOhnQGHnuuvn7g4bztYSRQiqNOngVVvhVKo6OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O/pNR25m76J3ou5e/I866l8x3mpHuJyr6k15clz2jZE=;
 b=ZDCrUPYKLbZbuKpHIDidLMbvhT5JNhHcHblj7tiNI9PHpIJ8X9LWnOQBTDbsvyKxYpDRw6m4Z2rEuSP286bp4yMwuIL+uZJ5fxooePNgROtbpA/Eb8vNR3D9bxW8uSjjP4o0AYyvbnqXijPhtuJoGVIcd4s2SllCQn9nwMSnYqfLnlZo0PmQCZUahuRBWq4dog5tzypgyeUnhtefO4MWeNI8xGHiOnYEfSYvqZZ/y+15QNtU9AapQ4HRr4g9ao0UVx3nhQepA1a7n4CrUGB8F/boaQYvV8rJ/Ol2JWfGNFCrBzRCiyWhfVknOghIT45CJsMz51/z5hYob5xboAFedA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/pNR25m76J3ou5e/I866l8x3mpHuJyr6k15clz2jZE=;
 b=RauxtSHoKAg3VweYtSzdWZYTGPZbgdscyj+lcBD27VLyp8dU9oPeiF+DOQ8DGqbhl10iBXV5XvttOP5bDF388HUiXhikgVjgSYt4bjP2K8r/KEy2VcTG4DBt0pUjAO8a0QkYOj2oEHVUDMkLK1dBnCVd5PrklWv4f8Huv+C3qbg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 CH2PR01MB5896.prod.exchangelabs.com (2603:10b6:610:39::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5017.22; Fri, 4 Mar 2022 05:23:10 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::181b:1522:26bc:c243]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::181b:1522:26bc:c243%4]) with mapi id 15.20.5017.026; Fri, 4 Mar 2022
 05:23:10 +0000
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com, rafael@kernel.org, linux@armlinux.org.uk
Cc:     lenb@kernel.org, robert.moore@intel.com, james.morse@arm.com,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, patches@amperecomputing.com,
        scott@os.amperecomputing.com, darren@os.amperecomputing.com
Subject: [PATCH v5 RESEND 1/2] ACPI: tables: Add AGDI to the list of known table signatures
Date:   Thu,  3 Mar 2022 21:22:40 -0800
Message-Id: <20220304052241.151946-2-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220304052241.151946-1-ilkka@os.amperecomputing.com>
References: <20220304052241.151946-1-ilkka@os.amperecomputing.com>
Content-Type: text/plain
X-ClientProxiedBy: CH2PR12CA0006.namprd12.prod.outlook.com
 (2603:10b6:610:57::16) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70cf158b-9e99-44b0-3b52-08d9fd9f1230
X-MS-TrafficTypeDiagnostic: CH2PR01MB5896:EE_
X-Microsoft-Antispam-PRVS: <CH2PR01MB58962BCA415697BB5D628CE29D059@CH2PR01MB5896.prod.exchangelabs.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cV4QvqCJ0gVe9CcNQv1hfepK2P/BsAtQ1Zr7nBAivu684eM2zDeRuUFTqidzB5rzpNd6nIZlC4JUVUUITJ7HIkpfBdcQeMl6CP+zuRKh+O7syVh6IM4dh+b652bZ/wUX7i4/qe5YY09G64IO673AH6SY9NsPUjObRCQaPKYox8ujGdH47aLfN+I+68l//+mCQtphpWNK2WrJCNCZi8V/N5lARHiplZRiOMm2azDMWr5HnRycgH6LEF/u6SzXYmcxk5dvtda5wD83PNk856XHayxDddolM8hpdeLpq5YvfQgtOkR0KPo8xpE/XaFIsy2yhNnccB9H5pKHBqIN22qYfY5zbY60v8/AKh8JUs+q4UBzDwc2Te312NadyPrZ0BSxgxK7eUmYMeKf4aMHqYbx47duTs764guGP7SEJQ75Gqh74B+ovUSGeQ/bIGipSdqNwDHPzbSNcxf/mvgbPJSqqXcO8WJI1JhOfWKhmi/+AOD+5Eq3hzj6QoX+5LCYZT1V7Nz8Z6xd78OhlixgGgysgA0uHtuaeB+g+Fj8viyAqhLIaJ7zKPdQe1IbJ3a3HXXjTwsMZiykTr67t9QeDCnyvJ3pLsFdyevyC8fN2n/6SsJzyPEjjPYKFTvIdLswinJtSp7B9c0Xyip2febTgRbsyC5fTfbpQDydJP4s2LFTxeOWS1fC334RJHqHqY6TV3u0cfALH+4GjEnbH4glWv/35w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(1076003)(5660300002)(6512007)(7416002)(26005)(8936002)(107886003)(2906002)(4744005)(186003)(2616005)(6486002)(83380400001)(38350700002)(38100700002)(508600001)(6506007)(316002)(52116002)(66556008)(6666004)(4326008)(8676002)(66476007)(66946007)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t34lJF1wKFeEZBVUdOI44APpbV7vh3lgNHf7v0SCfzT1DWAtODQ4kd0iUOY0?=
 =?us-ascii?Q?eGKO+9ONbU6qwhC6zJr197QN4wY1JoSUhXC9mVeRxHnfPcbrLYrtUBEMiCzE?=
 =?us-ascii?Q?SGD02wgChEBhoc6yiqvjmoUjzaoIx3lH1Agq7eUBTElJUsesujkpmjzUp4qW?=
 =?us-ascii?Q?W8QT8m9apT9Axala5Qmr+ohDEu2GT2XRAvPJcHA0iWcbk0k8H3goOi17K6UJ?=
 =?us-ascii?Q?FPMAlHVkZRLS8zfQnzkex1EHolIVbimgqYsKHcy59lAcM42rGWh99Zc1EHfr?=
 =?us-ascii?Q?ruBxt+4XXBYIuCuMLexN5Z/MkT0I8fqjTPbQWT7/pmkC0P7rQ1Sqpostn661?=
 =?us-ascii?Q?3I0DN/bBVdpUXSe/GPTV34qq272LQ9z6+mF6+eQg8vycy2AUz64A0PkGVTmm?=
 =?us-ascii?Q?uGGqm3NlKkdEQylazCM6aOny5HWLj64ctfiyN0EBGlmawLbEiNLe7tmQa2vf?=
 =?us-ascii?Q?5K/XjIVADlNbN7f4TUEO7NJFbKKeLaICVThIs7b6ei3aSn23mnkxbsjQxstZ?=
 =?us-ascii?Q?dIZKq6RlL8KRxDff1mmAHHBznEEpugVdF+CS4turFqBWpxYe1uKf5Y8TfX45?=
 =?us-ascii?Q?usuBAz8z+U6aWKpd8fjCDRhFdY3GiXdUjYZ3tNg7m9tRLygwcyXEQvurnZMW?=
 =?us-ascii?Q?TVw9+uKK/c+JwI2PS4qVrxi20mG7RqfwQkY3DS7rQ3fwnhYG8LaO+SFozQjJ?=
 =?us-ascii?Q?3tHRwC2tzq9LArR2gaJoURpkTLdrY0dhkLyHnZXAH9XtGn2i5jftL0/b5Jci?=
 =?us-ascii?Q?A4FF0wiW0ZA9Qfs1TT3SN4DYy+l7OE2NyUzjikdvltiwXHdy3XultAlTO6ny?=
 =?us-ascii?Q?qmG2x7fIrqHmKt9Ra1KpSdS6vqsbpfyfHMGtHgaK0JWG2Fl2UJIb3SMKUBDD?=
 =?us-ascii?Q?o171HyI7z2dX56x9w2xPx+d6fCL01LW1hkFV5jmcyHng+PJa3EH8EjBgQk5P?=
 =?us-ascii?Q?eUR5IggzwlxoIsFI/LefPk9masHnCkroiW03nZvush1l59fDiAh8WCoQXive?=
 =?us-ascii?Q?7myMcikSbYSXuBgzlAWcS2BOHr4lrLxp3SQLfejreP4jAiEHZ8cspc37fULW?=
 =?us-ascii?Q?80iLoMFfy/uVURAuNbABnyHejqhsvSZOINxbcg5M2xR/OzxDTDSEcvpJ/FMw?=
 =?us-ascii?Q?tnR/3DEJReLPGqDH1G51U7WScFCLbe/c8Q3aUXZDr6C9u+t6WjeSgrkV6NXB?=
 =?us-ascii?Q?BoyfY2rAsoqSzI1Un09gzdZFrvhAioSTkocxTpT/tVbduEaGLAoQXVQPx57y?=
 =?us-ascii?Q?7/Le1rsZvPH9J84BV92qIb70QpLXOhXz8SHuyvrdDsNtgzk1i20eUAffh5TY?=
 =?us-ascii?Q?T6n71I0Jf6sogUs2K89m6AJyjFWFvDHQUM7DqZs5drsO0DofhBQ1CCsROOg1?=
 =?us-ascii?Q?kOh5yFvA3oyVJ6ZH+qz5PoR7Xdud9EeLBRIzEALAEEqCu0n+yd7IA9ssWykC?=
 =?us-ascii?Q?+Q/pIcw2Lj5Rb7zxNgkT7X6jDgBHx4NBzzzwA1JnpHvP6f/Cp5P4EohnQKw1?=
 =?us-ascii?Q?V2fT8NP3/YH4JwAaDiVY/RiZksZJxhhicTElGIrYTyJV9L32mVIIvICJV0O/?=
 =?us-ascii?Q?L2BwJzNEWiA1jHH4RyFcdKEa/9QcRTzYtrk4THJNmLgNQdvK8FPkMw7OpmQY?=
 =?us-ascii?Q?lpYhh8Hja/qITkTTJl/RwLadHSqxgdmewGrqiDWOXJNLKEFMS3v+5O3CUe5n?=
 =?us-ascii?Q?JCUgkQ0f5b1x/qj17xBeZ+DnxQxDS7NKhqlvAb6qWDy6kdKIdhBhT54HsphN?=
 =?us-ascii?Q?ajOWiP20vg=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70cf158b-9e99-44b0-3b52-08d9fd9f1230
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 05:23:10.1101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V5OMJSjg+fxnTil7d28S7am0TiMTPfuM9gfsBmQokO2BwPky1x/8op+VyJ5X9K3SM0vnpfAd4IMH3FwlkGeO/YmXVB4F+dRo8qoqd0yAF524bIEzHffi7Qdi9EmDqK27
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR01MB5896
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add AGDI to the list of known ACPI table signatures to allow the
kernel to recognize it when upgrading tables via initrd.

Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/acpi/tables.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 369eb998c3d1..ceee808f7f2a 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -545,7 +545,7 @@ static const char table_sigs[][ACPI_NAMESEG_SIZE] __initconst = {
 	ACPI_SIG_WDDT, ACPI_SIG_WDRT, ACPI_SIG_DSDT, ACPI_SIG_FADT,
 	ACPI_SIG_PSDT, ACPI_SIG_RSDT, ACPI_SIG_XSDT, ACPI_SIG_SSDT,
 	ACPI_SIG_IORT, ACPI_SIG_NFIT, ACPI_SIG_HMAT, ACPI_SIG_PPTT,
-	ACPI_SIG_NHLT, ACPI_SIG_AEST, ACPI_SIG_CEDT };
+	ACPI_SIG_NHLT, ACPI_SIG_AEST, ACPI_SIG_CEDT, ACPI_SIG_AGDI };
 
 #define ACPI_HEADER_SIZE sizeof(struct acpi_table_header)
 
-- 
2.17.1

