Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05FE4CD1E0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 11:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239232AbiCDKDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 05:03:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234745AbiCDKDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 05:03:00 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2107.outbound.protection.outlook.com [40.107.215.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF4D19D60C;
        Fri,  4 Mar 2022 02:02:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I9IdyCZf9SB2pRyBwIz9uXHrvey206FF6Yg/PKNMLpOchGSKsLCggC2KPpe3uLgWOlOLh8UjR/lIHIc25c1+w2uDN+ggM8+uOUPehDtsajB11AmXsFf9Z7mKO2XEezUUwvJhFjsi9JXlmYKQ2gSTcrUDAEwpmpXIbyTYlqRYtn5BLvBVULm5kOe+lpq6xk2IkLv7n6CPkRkhp/t/zMfO6sG+pzcCDBDrCAy1jRyxfOU5LQHIA43ZNn7rVIM3tei5kHDluWnbC9SX44tBkgGpmKb4pK3RzAQJDSshmBgLQ4rI5C3XsfkW7QjHdFoysEHTAHOQxukGmNOaJyL3CNI+Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oetpaxtHWOP5+0DCn7mDMNfhCXcZqaMiwpnRFmsFF+U=;
 b=WOSBoWq2ZUbXDrbDr+gufU9EktfYm8NEHjJf9nAPwHqpNvM8y0wkUPs6yCuXCNsOzGCuz9AZ36CK5yNh+r677DO4pCp7znua7aUGdJ+usTIR6eATKQ0VXqw1ldkw/RqF/okOnZJIoZnCRits9arcxQPbYjfWAgXFiVK4TwlEn291uKjoGSF71U4v4AN9ebB75bp/KhDcJS9gJS0W1OZcfIUQ1fDCdZWNIRbwuP8raMAlprhNRUT+M+QJrCbUv6uSkFUGCmWxrwRmGHnE2uUFt54M+qlMZNtn3M0YNnLk5RDp53d5dhTqyqjWr75CibcLPOZTI5Y1A6iopCio7dYHqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oetpaxtHWOP5+0DCn7mDMNfhCXcZqaMiwpnRFmsFF+U=;
 b=n6a62M7XioI5QJbz1U6EHBQQ2fYQb9u3SwkXQ76SUbTPZI+AVyB8oc5XPSP3i1IWbamg5mXS9SO6/hnsN845fHDkmorkURyV7O5kGBA2jxKSQs+bwHwAjI8cypDgXpoKf0BfUIQI99YHCV6R3/vSVeTJZT7GFMuIkZXTjfA9vBU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19) by
 KL1PR0601MB3783.apcprd06.prod.outlook.com (2603:1096:820:18::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Fri, 4 Mar
 2022 10:02:07 +0000
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::9d3f:ff3b:1948:d732]) by SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::9d3f:ff3b:1948:d732%4]) with mapi id 15.20.5017.026; Fri, 4 Mar 2022
 10:02:07 +0000
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Alex Shi <alexs@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Wan Jiabing <wanjiabing@vivo.com>,
        Yanteng Si <siyanteng01@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kael_w@qq.com
Subject: [PATCH] docs/zh_CN: fix a reference file name in free_page_reporting.rst
Date:   Fri,  4 Mar 2022 18:01:39 +0800
Message-Id: <20220304100145.6356-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: HK2PR06CA0008.apcprd06.prod.outlook.com
 (2603:1096:202:2e::20) To SG2PR06MB3367.apcprd06.prod.outlook.com
 (2603:1096:4:78::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 814eb10b-78b5-443b-75da-08d9fdc60ab2
X-MS-TrafficTypeDiagnostic: KL1PR0601MB3783:EE_
X-Microsoft-Antispam-PRVS: <KL1PR0601MB3783D96F19A46923CEE9F7F2AB059@KL1PR0601MB3783.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YWuqRGDlRlYPMrLet0wKKY1EKLi3sKBWaprHlV9WT/x+sQ2SX3fpX3N0IZ0cWCERJLGk+dEGaa5SpTd23As215K4GoXTTceUTCZxHqWrSHo8YoOoJ/2/ACoXARuEuR7m0Sp2ypKbpyRVftHJrdZ4/FPlxsj9ieLPW8KEkXOjjBngjietZgIUcnphamANT6BwcvTEIU1+7Wpamg9qMNhYUALv8WEjHQiIFFarErKwrwUq5dGCzSb5rsBoyx4S9m4p1MpHGQVRkIANuD7UreSgaSHJY3cDJuCJmZx+HZMY0aMLMUkzn31znO6hBLbru0lrNqPnK/ujb7Vk9tsESyehx6rez5eaBq4sIluXvQ6t5Abs0pDDoMTCOTRazl2Yp7Uhj8+PSBoFykGEvVMlGPe/M1WPSST7U4qqNOpjLBk7Ev/5xDZnZ5lAUb8zTrXM4lAtpiyNePSr9S2pSCGFnJTIpHE7K1qDTJnTaZjwKkNPUt5MQOTzUjxpne/YsDMcIHZTZV6rQHonq4jg7NJxP2NxvuxBJskdixqYw0n5xOO4Ig5iR1E259nOf6tC2AePeV5kz1U7xRnzrFY3omAlGPGKxRvQM/0gfNcDvrJPmXv4x7++66co4IXGMa7B0wL0osK8BiQZhai7jfg5rRqseNaNE+Um27XNclee4FFnfZOA4GvZVOntyaUKIhoVJfiSNQZ4R2pqyC1N06KNxkMV/QSfvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3367.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(66556008)(66476007)(66946007)(1076003)(38350700002)(316002)(38100700002)(508600001)(6512007)(5660300002)(2906002)(8676002)(2616005)(4326008)(86362001)(6486002)(36756003)(6666004)(186003)(26005)(110136005)(6506007)(52116002)(83380400001)(4744005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnZVd0pnSGJWUTVqbkRDSXpZSklMZFV1UlErSXIydlBkc2N2ZDdwZ0JtaitW?=
 =?utf-8?B?TytLcEM3YVdoTWkwVTI4NXNJZmo4OEI3Umg3dHcxRUVmU0dzQUJZMVZRc2w1?=
 =?utf-8?B?dEJWakpqa3Z2VFpyNGtjclRCNXRVbjFJM3BsZzBIbFFDeTNTY2FwWjgzRGRJ?=
 =?utf-8?B?by9RYk5QRXEyd1VjV2IyUFZCdHFnOU4zM3NyUkFPV2trdXhnSENXT3FoZnVW?=
 =?utf-8?B?Zng3cVBZQk5QY3J3U0dUb3FNa3JnSEMwRzZETnJnVmJHNDZMRzBqQndqSXkx?=
 =?utf-8?B?RmlidkFHTEROSzNvNHNXbit6V1VBNlNSSS9jTlFYOWh5d2cxdmplKzJ3UmRy?=
 =?utf-8?B?cU1pSzRpM0wrd2VPWHhXekFqck1pOG9uWmR0Z2RIc29jZjQ5bDRaK254QzhU?=
 =?utf-8?B?QjFXU3lrdEl1R25CaGgyOWsyaHl0UDFZeUQ0OUtwZW82UjBjZ0ZSU0VtZnd2?=
 =?utf-8?B?YU9zdnhCbTNYejFQc3ZEOVdXM3RDb2t1ZXhGOEVVS3d3eUEwT3J6UHB2eEF6?=
 =?utf-8?B?aUtPbFdxRmNtek5uTThJN2ZjQU9pbWM0bmUrbTNBMngyM2FJTlFBUFdyV3NR?=
 =?utf-8?B?Z2w5cTJRdFl5RE82dkNaOU1QN3lGSnlrdUpEOFRHVXFYZWhrNjhSNm5JdUQ0?=
 =?utf-8?B?UDV6NWhKOVdZTm5QeWtDd2lnQUdVQ3l4d0pBTFBYZGViV2FPc2Nqc1lvY0hj?=
 =?utf-8?B?ei9BWEhHQjlPY3NpUGRIMm5nTkxScVcyaUkxV0RyMER2NXBvd0ZZemsvdGdR?=
 =?utf-8?B?cUFwU2U3OFdhMlk2OFZDS0V0TERQNmVXazdGYi90a0M0M0JrTXlKMHV2K1NF?=
 =?utf-8?B?a3JLY1BNbENxVkdHL0tYT1ZVUnNGV05oRTdOS0Z4NXg1K0IwUThzQ3ZhLzla?=
 =?utf-8?B?ZFA3T0lXRjVEelVIZFdMa05CcmViNGNhUEdmVjJ6OUVmYW9CaG5MZ2pzREFY?=
 =?utf-8?B?anJ4UVdlcVg3ZDBKSjBxQWNadXp0aElyNmZnZVFIT2F1Q09Oc1R3bmhxUkJ1?=
 =?utf-8?B?SFJVQ1hNK2hJaVU1NUJkNTA5Z2g4cERveE5ySWVlTVBNWVlHRHh1WC8vRUVR?=
 =?utf-8?B?Z01PcStJN1NrZnhqeXdFMDF5bGZPSHl5N2tSUkN1cTZBK0dGaTUvK2k5L25T?=
 =?utf-8?B?aUhleEVMTkhmSlRManY5ODFmeEdPZ3kxM2pLMTdwclFINE1qcDlBSlNJYkxS?=
 =?utf-8?B?WlVCWU9oQnpoM20zT2FEUGVjZ0V2czdsdmxRZ0xMdUhyZXpKMm1LKy83eGRS?=
 =?utf-8?B?SWdoR0piNjZWWk9JWDNYRncra09aSmZaNmtYc21YWTZzZDFwTHlJQ3hKalN1?=
 =?utf-8?B?anZyU1ZZcW5BTmNNZWUwWVdaL2ZraU85bThDeFZBVjBFZWJ0b2pLT3A2VXpN?=
 =?utf-8?B?eWVpWEdDVVBjRVE0VDg2NzJEZGdkRE9BVzhkZHdEZmtkczF1M3NWQW44MFdD?=
 =?utf-8?B?OW5teVExUUhnL0NyYWxFd3VXNEZYazdNZEcwaE53UDdRTWhRTXpEd09rK1Vj?=
 =?utf-8?B?WmFhMHlMSHVaeXNJOUI4WmhiVHJwLzRLZUpKQmxvSXlobk1YN2VsaXBtRDd6?=
 =?utf-8?B?U2xSKzBaUDNpTzc4a29YVVFGVldUc2pEQTdSdTUwKzBnZlVadkc4Sk9VRE9w?=
 =?utf-8?B?bHRwUy9QYzh6d0lZTHVHYktwK3BPOTRLYmp3OVhobG9FTkF5S0pTa01ESGZi?=
 =?utf-8?B?UHQvVTRkWEpXUDg4bWk5RmlFWnR2RWpFTGYxZ2tRcVZmZlg3ZEJUOHgvOStn?=
 =?utf-8?B?ampGc1daNVoybnZ5U2FKL29mQ0NRTVFTejNxVmphdHJuR2FGTWVxS3FzMFJ4?=
 =?utf-8?B?QUIxcjJzNTU5MnFJNlJrM3dLRGZXb0dMeDhoMzhQS3BORW5EQ01mc0k5V1JJ?=
 =?utf-8?B?MnlKcFB2ZUZvWFRpak14UjhvOFR2WS9JLzF3V2NUWEYvR1VmcVdXM0dXR3RD?=
 =?utf-8?B?VllrUDRIbTY4ck5QUi9GNmxIQ2xrWDRrUzZObkx1QVBGWk5FbXNXa0Rqbnc4?=
 =?utf-8?B?TkI1aGJub2pVV1RvVzlyZ0xQd1Q4MU1JaDYyR004U2Vmc2NCcWJrcnJxVi9X?=
 =?utf-8?B?TzFaSXdiRUNZcnYzQWZmbkhqVUdjRjB1a3JUYVVIbU8yV1NtR1lxZTdWRm41?=
 =?utf-8?B?YVZRSDcyY08xZ0Nkc2ZuVlF5ZnZidkUzVjVBY1hRQjlPa29nQ28zQXpyN0dN?=
 =?utf-8?Q?tQ8UoZhyT/bdEFrhr3VW5+E=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 814eb10b-78b5-443b-75da-08d9fdc60ab2
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3367.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 10:02:07.6486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uahs8vfP7W41G5GZnaRVLi1LPWUF3Og/MPsh15T2cIfcFUFACGU+vGEVVjVTl97JDkb38rGDtPaUsvV46aQ72Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB3783
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following 'make refcheckdocs' warning:
Warning: Documentation/translations/zh_CN/vm/free_page_reporting.rst
references a file that doesn't exist: Documentation/vm/_free_page_reporting.rst

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 Documentation/translations/zh_CN/vm/free_page_reporting.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/translations/zh_CN/vm/free_page_reporting.rst b/Documentation/translations/zh_CN/vm/free_page_reporting.rst
index 31d6c34b956b..14336a3aa5f4 100644
--- a/Documentation/translations/zh_CN/vm/free_page_reporting.rst
+++ b/Documentation/translations/zh_CN/vm/free_page_reporting.rst
@@ -1,6 +1,6 @@
 .. include:: ../disclaimer-zh_CN.rst
 
-:Original: Documentation/vm/_free_page_reporting.rst
+:Original: Documentation/vm/free_page_reporting.rst
 
 :翻译:
 
-- 
2.35.1

