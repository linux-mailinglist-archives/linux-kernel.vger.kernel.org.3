Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 394094974DA
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 20:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235115AbiAWTBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 14:01:43 -0500
Received: from mail-mw2nam10on2077.outbound.protection.outlook.com ([40.107.94.77]:1921
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234780AbiAWTBk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 14:01:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gSQXs1A4pcwIPLwJAJGD/sHyjOqaPFCIJ8rEIDvWLtIkDJvr1nawFdtSqnH+s/lltSKhEI6z9U4OB0uzj2PPlkfp1YXLccS/InMk3MVjiQ6KOiJJZIE/EKc4wyVXqdUnRufrSD+iWRbyLWMRSuJnpndQriN9Mqzc6B+Z1quf7K1xSPjac8DVMgLXwq5/JcK0whgqxh/9i3ZO7tz+D1n1945UH2Ezm9cJrOV5efP+L0lKpcb0oyjaWKonEo0YJzN0FWui2y+PBQpVLzTsHmDx+ZYIwft3I8wRh56fFapnBAfNDABa7fZHJHCJf4Shm2+ZFTtatP+n94OEGlolX6zizw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3RvWxwBFSxDCf+h2X8MQgBSoMWwO2wHog6Bbg5wUndg=;
 b=J6jyfHA8srUPJ1E/EKjW0lfaKHiI8vr7rcrgNt5ph2VyK11q8DCN9jqQT8/km9+UJNsSTJWitK1NDMV5skuWg9xQSzr7KqiCUvTxefhnE3Pxi+cVHOcHpwHFvXoh+TDSwljATqdlPkNsfH3ZWXhFV9+6fT1kWB2xY+24Cl8/MwvV/SPoMh67GVqaQUh+m7bjSK8Y77zaXlHi7KzFVRv9pQaH4wWBvcH7kjrqOT+pQXWBYsp3X0qejw2zuj0iovLFdBz2PKc9IZxGyQCmD5dHHY58vUHV5NcBgu0tNX1N4c/AgsN3qi2qmHmegdnufxPkSMwWH3XQ2TmbL6y4bcT08w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3RvWxwBFSxDCf+h2X8MQgBSoMWwO2wHog6Bbg5wUndg=;
 b=I/zTBZzWjUW1OB6Oir2N4b29cm1+UcJYOSL5uk1U5OSv0fNd9IVyl+/rbSCy/TtRgDSHW9F5n+KmERhSDki9+tL6fDFYq7h8OmnVGuAoQmFPgInyu6yEI9XOiUuXg4ZABhlON6E8vVhRTbFx/4bKM12DjwA4NTqCtlhU4XDkPbE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SJ0PR08MB6544.namprd08.prod.outlook.com (2603:10b6:a03:2d3::16)
 by DM5PR08MB2651.namprd08.prod.outlook.com (2603:10b6:3:c6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Sun, 23 Jan
 2022 19:01:35 +0000
Received: from SJ0PR08MB6544.namprd08.prod.outlook.com
 ([fe80::e8be:49c5:397e:d3ba]) by SJ0PR08MB6544.namprd08.prod.outlook.com
 ([fe80::e8be:49c5:397e:d3ba%5]) with mapi id 15.20.4909.017; Sun, 23 Jan 2022
 19:01:35 +0000
From:   Jeff LaBundy <jeff@labundy.com>
To:     lee.jones@linaro.org, jic23@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Jeff LaBundy <jeff@labundy.com>
Subject: [PATCH 0/2] Add support for Azoteq IQS620A(T) V3
Date:   Sun, 23 Jan 2022 13:01:04 -0600
Message-Id: <20220123190106.80591-1-jeff@labundy.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR11CA0004.namprd11.prod.outlook.com
 (2603:10b6:806:6e::9) To SJ0PR08MB6544.namprd08.prod.outlook.com
 (2603:10b6:a03:2d3::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6efc8d6-57ab-426d-13b5-08d9dea2c69d
X-MS-TrafficTypeDiagnostic: DM5PR08MB2651:EE_
X-Microsoft-Antispam-PRVS: <DM5PR08MB265151814591D8838F3D3CF3D35D9@DM5PR08MB2651.namprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a2/tK5FZjMblg1m4vcnMOaSdZZvgsOqp7vxV7nPNBwIog69bDEiP3OuLEH2/m3R2OPfjoWSCh6OibRqFTP1C11q9z69HXTgWy3YU5mfzJkSnU3E6nhAzJcnoETgX1r5lYH7K0tPY8PeReKX4x6qB+m4CJ1tg+d03senxXAJwrQDH7WXR4d4GUU9tQ4Iic4EXW4AGqhTVOOJn6+tNCcVE0j6m7a8QNeoE1FFkMXKLzfk4ZkCeFZ6kLUI0mJbUv7BahdUktdSGzcBhyzR9kXJNT9TXEzjvOaAUYapZnw3nBRm9Ydykgs7feIMbe0YrIZmP8c9M7pIeMga00QSnB7W9+8cRZ03XvRoyl4sLqpNyMVH/b7EEC0zU0a8EaCUlUV9H3m7SsRuXbdqcC5UWirhfp2zIky9PMARQqaahmfyo3W8MEGE3rVKhwCuZcTjVtTDo4eXiH811BZHJOrdinMUCUZkFgIcf2u5JolmoAROURf59VOwlgMRHrJGbsRAJdHaq6E74N38+oNkEifwPpRw0uyASRALwVGhmFfI9Mvzc+kHKyKUKH/ynUxnMigVuRl1/JDr3ps4aHwz9fORC6yJg7PPdgnJdeT6EpU0w0MjvYXDCvkRsP9hM3TKCjDMJ2SAnMMWN7A3R5o77DuWvMhNCxOJiX+03oXGKCfAx6WvvoRdPnTr5g3loitaSUFYwmaPoDHZC59N5hcfcVEaxBYO10pxI5J232+VgMOr+fDZyXDFpELg+v5blzKTQPC4SNrAsG9vV95tRY8pOJm4JoS15Wg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR08MB6544.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(39830400003)(396003)(366004)(136003)(107886003)(8936002)(1076003)(52116002)(8676002)(83380400001)(966005)(508600001)(38100700002)(316002)(38350700002)(186003)(6506007)(86362001)(36756003)(66476007)(5660300002)(6512007)(66946007)(2616005)(4326008)(2906002)(6486002)(26005)(66556008)(6666004)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y1nPWr+OndQsSIX6yM4ymZRObJTPWOnC0bym9s4NhM+rXjQGrLKDBuwdsPJH?=
 =?us-ascii?Q?riYv/7Vgd+D0d2GmDa9XnZn3Wa9/okiMGLHl/HTxWtXNTFPXr4HuyKZqsjl5?=
 =?us-ascii?Q?ZIAXjJNhaoaAjAMOWTu7xLNMNBrjuUJJwNSsGXDDyGX5yTGsBiGU24G9lsZN?=
 =?us-ascii?Q?mL07fCaddwV7ygXb/rLVdb1OXvwgDEOJmAKIAapqOaN7x0zak5ZZWDBPqsqT?=
 =?us-ascii?Q?1SMzehYQ/xB1lG03B68YJdITqPOD2/13j1d+OBE4l7SSDv2ccnvQ10KPqV6l?=
 =?us-ascii?Q?OoERaeSbHDsCaNb+/mjD8rOWqm7XuYCs4zMkVWsM6n5dU/yzx9xSrUsQJja3?=
 =?us-ascii?Q?8eCYn7MBv8nv1mKO/Ex3VkJrmSZX9HIfoLPxy7+tktI+SeK8THyGnuH/hIxi?=
 =?us-ascii?Q?WoaGJiVJpro4AGDC4+Kjny/NpC1KZSD4uSe9jC+Ll93/epO8GnFy8Zo+/3ub?=
 =?us-ascii?Q?VZTBTbcYsqYv8LiTYwkNw394huOPKgp0tL5yrZw+dNuemXpLb4egbczw8ydm?=
 =?us-ascii?Q?fxMErZk77Abxaiij7oI23rOcC5kPHIxa21suTUwLirOavpyAzRZQe0aQ7n9W?=
 =?us-ascii?Q?GroQ4BEzZWj4QMuz7DbQaU7KRNOchlRrnGbggS52U6cfBS3TmZWKDjpV2FNo?=
 =?us-ascii?Q?VbK30VQdvNFMHMpYcrUUn7puLBupwr2ybPlcLpbozZjTBSehvFZlxP86Mqz9?=
 =?us-ascii?Q?6OmAIFjPNRkFPKSEW5KQ+O8Kj3eVNCBanVIlgb1Srj3rdOtlW2vPbminArdZ?=
 =?us-ascii?Q?lOufF7Ca877y31J8eIrIC0Lc9oNhkQnetcjkg5OkwSJ90QD0IqaO5UFM89kB?=
 =?us-ascii?Q?UStCqtSCc/FD5Kkm6Py77OHXf5O7/eSY0+tmymcMUS6n3d7E7X5dWCNcB4LY?=
 =?us-ascii?Q?mCZi0m1u+QwQtisDde7z19wtBDjG6OA6dpQJf8QLK5OtPb6eqzF/4kcXnNZS?=
 =?us-ascii?Q?CrYa35qaA7MSIvdn+PdlxcWVvN1Nef1Fej7VMZKSZSPD+DFRYhJ+AAMCogVD?=
 =?us-ascii?Q?CaCLGrS5m6aVLmqwmhAiFdHNO2hJ+9grz0vVP/1fp1HvR+Z88J279+h/CjSk?=
 =?us-ascii?Q?bbZhvtV9FoBwYCynw3g1g7awo0XVrbW3HQNFY54eUtIdydqrqs0ZUVC3TG9v?=
 =?us-ascii?Q?TfEiqJKMVNvhesNwIvcZqJLXmOE1e/LkAzQ3rDHYGg4xNcaYQpNFC92pmGIe?=
 =?us-ascii?Q?KzWfaA49D8dX5EFhPHH1Uluiu8T/OSqAakifKiseMKhZ4R37OfKucAoNja5F?=
 =?us-ascii?Q?VCaxSYUPCiXE3OzgSO2OS9tVmx9d1PZcKZare2nnL7mJmfsFFGwdSlHxYu35?=
 =?us-ascii?Q?yhDLoKNrefoCVGQlvh+Pblmo3sKKOgJCX1TxM6UxuqiMhADRlry7LyrMcFzE?=
 =?us-ascii?Q?HWDnfx/4UtakgTDpKOd83EmT5FWqu1PqHAYjqRkv/Ojg1kDdwYpc2/4y5zJ3?=
 =?us-ascii?Q?Srh9e7xYCufjb1Y91Aju2IOWsz2GokwTIVTuzp0lTUg2MsGZzu88ozrD7Og5?=
 =?us-ascii?Q?ziS10/YbV9dBxE74fuzwFVU4gUYLnjqWNFa7NiIziZdQXupSwsTI98l7p0xG?=
 =?us-ascii?Q?6czWQq888mUv/GuBC1g1BnaR/49DNd2o9w16geyANTKiXKtGlz9wzvEE5xrQ?=
 =?us-ascii?Q?shXn/1gV3eoFm0Ail2AOZpo=3D?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6efc8d6-57ab-426d-13b5-08d9dea2c69d
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR08MB6544.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2022 19:01:34.9774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R7ztWPt8HElwETtfXPAokMV8C3qozUlt6PDKoIsTsaCzQpWKkGD2uBBjV2t5w/PVZlHa4TccHqlwtU9xXySoFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR08MB2651
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a tiny series that adds support for an updated revision of
IQS620A(T) silicon, which calls for a change to the offset reported
by the IIO temperature driver.

The product change notice is shown in [1]. The updated IIO driver
selects the correct offset based on revision, and a small change to
the MFD driver allows it to share the revision with its children.

In the absence of any objection, I would like to propose that Lee
takes the series through his tree, provided Jonathan approves the
IIO change.

[1] https://www.azoteq.com/images/stories/pdf/WT-02_PCN%20_IQS620A.pdf

Jeff LaBundy (2):
  mfd: iqs62x: Provide device revision to sub-devices
  iio: temperature: iqs620at-temp: Add support for V3 silicon

 drivers/iio/temperature/iqs620at-temp.c | 4 +++-
 drivers/mfd/iqs62x.c                    | 6 +++---
 include/linux/mfd/iqs62x.h              | 7 +++++++
 3 files changed, 13 insertions(+), 4 deletions(-)

-- 
2.25.1

