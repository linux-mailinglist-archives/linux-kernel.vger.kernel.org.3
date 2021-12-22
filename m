Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD7347D070
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 12:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244360AbhLVLAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 06:00:51 -0500
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:48512 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244359AbhLVLAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 06:00:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1640170833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=0DE/r1I8Mf8rCM6/bHNCXRZbOSXxyrRUceSZ+ZeXcpM=;
        b=MdUUpX7vNirMjxfMUkdrernUa6AuKC60lOeNO1tjsLw/PCSDqcw1G3HoSr7kWSO12qClhr
        aM64UxUpKC2MBjaAx6rZVRNmo/A8cB5CAnWSnveQM3TWXX/SH3eM/A6aPvz6doyYlUJ40r
        PFYOzflHq5Cumw0F9JIQF22spMCATdg=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2054.outbound.protection.outlook.com [104.47.14.54]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-26-Nm1RfO4MOTOYGLMxXZm2hA-1; Wed, 22 Dec 2021 12:00:29 +0100
X-MC-Unique: Nm1RfO4MOTOYGLMxXZm2hA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b+GdTgocPgN2mJfuSo3v2YQUwdpw68pF4h8QPAHmj04TtuoGw4rs/uKtpxwfjpsLYN/L4DGTR/vFerkxtL74qivDNfy9hQ3E9D6DO1DfI+0RraJ2C5vvgJZZegezf0NKl4rZmfsGyUWuC7JVKLUqQUk5u86go89048J0RJ4CSf8kC7HLpHFNmnnjCxYqfxUX1pAd4+LrGM5xnzd93Toj+aNuohsk/F7gVaPaUeXGzk94702xbSc0NVfINQL0ptD6/kj61cZC3I8a5TVl4p/E9Ua2wpUnq+uwvVXdxmitrkw+GOZeH/rp7zVkJYlHFT2NTv8JqqqDYubxe4HUskDZCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dRFecMjSMPVBQNWJYQCKSAdm+y3Dz0ZBNDq6ISy8Si8=;
 b=Ack24VTe3czC+O8oI+rWV4RAvIcN0n6QrUACDl6lxzk45bwBMPLW+45NvjiVxcN3g21KYLlUdf2rauvIW3kEWLuxTaCWFt2hUw4oGgHlvwNQEfB116lJQIomneGWngoJcqv9RtsYa55Od+YsW8TqxJsa3BVeHNqNvRTPAjs4OevkoO0gnBXy925tww/JD4MuLEn0YvE0JY+LPl4XfpugUuWcIj6MtpSTaAKiE8didCMbm8ro7xi+11CM9XL17FYZQwRg0MmhTL1lV5ny6AzddrvjGGlMt5DMlq8J/ed+xEm/B0LS+f85fe9XJ+7nxGc0YHbKbcKq8efyBW0f+KMSLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0402MB3402.eurprd04.prod.outlook.com (2603:10a6:7:88::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.18; Wed, 22 Dec
 2021 11:00:27 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::59a0:4185:3e03:7366]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::59a0:4185:3e03:7366%7]) with mapi id 15.20.4823.018; Wed, 22 Dec 2021
 11:00:26 +0000
From:   Geliang Tang <geliang.tang@suse.com>
To:     "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>
CC:     Geliang Tang <geliang.tang@suse.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] tracing: fix mismatched comment in __string_len
Date:   Wed, 22 Dec 2021 19:00:25 +0800
Message-ID: <5c012db463392d0e6d4f0636203d778962ad060a.1640170494.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0169.apcprd02.prod.outlook.com
 (2603:1096:201:1f::29) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4391ddf-1c5d-4c17-958c-08d9c53a42a9
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3402:EE_
X-Microsoft-Antispam-PRVS: <HE1PR0402MB34020711712B83985548BED8F87D9@HE1PR0402MB3402.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ziR6aer/KJByzL9R8blAkCs5gN1Yl6zq//7PK3G22d1WQWQLztuyVMbsCTVOcMoa6yjU1Rv/vV/ZnznMCkf/ggVZy0EbSm0sGVZ0APTr9B4fMIl43DghXmTpuS10Rq7VKC7nAnxB+gi5L5L35Bvp2fkr0MX/MWc0vMFVnmobPjxaGqViZ4eL2E/hljYBD4Oe9qydvKfXq5rMLL6YAKjwmSuTbxg71GAaFkm6ID9TkfUcuc9B4i600wlgEKHhO2txrrhF7JA+jX777TtyJfQbqgtrcTRVorgqddQd3B9Gw/NP0LwKG8JzN9+NoCSAmHWz2oJu04PKChf3DM/i6wsjxBWLEZcl5t+iVquKLtinsenRYq20zMPfJuDNg7fufuO4s41jBrj5FziFEu2TRm+2idgX6y2bNE3ZN39USb2gAYX+wZZ1iQ1ZFSOQ9KlH/+TZvSE8CTjI9gDrWs1AYWgljij8iQ4cYNmTNNdjkz3JWKC093fwEn4/Dqmx/VDtH+/LqGVFBHl44GnAYh211ONnbJooPEbxe2B4ZWt7IEC9ljnVNP3Q8sLVGqRc4ScEZ/njjkBiPQa+J2cBJSrfuyG1NjVRe7+aoyYmW/DhGLIk/8bbxwVapLpJWHNeDDpfzLFjXCdcYl3TvwvQKBdAz1DHMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6506007)(2906002)(186003)(66476007)(36756003)(6486002)(8676002)(66556008)(86362001)(110136005)(8936002)(508600001)(83380400001)(4326008)(55236004)(44832011)(38100700002)(2616005)(66946007)(316002)(4744005)(6512007)(26005)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+6Ss0hYf19RuF+XA9RsUERBbSpFKqNy23JBJTFFGhvbGShG1WqS0JL4kq5/7?=
 =?us-ascii?Q?ccUqm20q7IGrLOtT/q8AB2oDjzWm7qCI3ZSQgKLswQ5ntiv3O2yJzHBmmNTj?=
 =?us-ascii?Q?gmPwRla1sIcL0+D8MoPbzoVJFJwzM3Tn57u0vpBMxn+kotK+vUv1omV2QOev?=
 =?us-ascii?Q?1aa3rPVIz0zj5nyJz/Kib3EUHJcEHxjaBv/aDnwD/Ll5kImZt/U/Cewl2a2+?=
 =?us-ascii?Q?UnlvIEMrmzgdHiQrrrB+ne3bNab7+twBkREaM8NAAsrKQcQPrmQYiG6hGDcc?=
 =?us-ascii?Q?o8idChJxEkmdOjaGNHOe/jaQcUU9GOypmqFV735WGs4MuLGPTJiTucHC7cLK?=
 =?us-ascii?Q?VOyf4gREqTkLnd3d/6zrhNlH+GSSNILqT2sdApRtmHqkp6kFTFeqZJsp1+nF?=
 =?us-ascii?Q?u8LEkOazYfLFKjF5rDOdeWmBr/RnvLXneBtUQT7qIxzv1WIgD/qsiCRHZBFj?=
 =?us-ascii?Q?dnxY5MB32DY0CGGWfvgXX8dlDIGc801VUVS/hSsqp/WNim++s2w3t9rju/4Y?=
 =?us-ascii?Q?C9TVkVvWoCanwaoG60NY4H4VI0GKx4/mJ0ewkWW390QJvTqBPzMnlc7v8VTS?=
 =?us-ascii?Q?vEWwcCo9DpquP1WnSENyvBragSYH6anUeLMX6hw1mFWa75yrjbI4Q7tncOVv?=
 =?us-ascii?Q?PVtsPPZ2ukf/TiXp+3FHBsqFDLY/a1GqLYN6rIUCCDKuhkOwR0qjcdUrmZmT?=
 =?us-ascii?Q?iMA1BSj+hd5s/8UXkbQ4DCBJROb4O4miHqftms9WV3FjWOuKhQEEjxYmaXBF?=
 =?us-ascii?Q?AxYaCbN7wITMALfnK4VV25Y3fbu/3npTJb9dh2n/rsxiB+4vVRQYKa+gNMaB?=
 =?us-ascii?Q?tgAzkhTnMoh8whBq4QzuKuqOA/aCcWJ0xUBy41huGL/R177sCGrtWszQ+bfI?=
 =?us-ascii?Q?sIUpeSHvTpMCKCwL5C8YC7aCT3vVL0rhE6AKaIm8OrJvs4lAtCJMNqGK+31C?=
 =?us-ascii?Q?MZCsaAkMtjr4t5dtT1CwcZLY5+m4gbr9idyyxiPU3S0q/SK7w1j1ZFvcaNI0?=
 =?us-ascii?Q?rtiWnUz61OwfFvTzEpF+8bsap7tsHJ1DdYBcoa1KDz1k6j4tr8nBi4bGhU3f?=
 =?us-ascii?Q?BUZ69iOxsxuMGZUvNUe23Ml3FMLEtGKX9CWv6zQqIST5Fyp2Cv8BjnaqaLVg?=
 =?us-ascii?Q?CBMSMSkINj6yVicmZ3D4MiNfSDk0lfjLZagpPRMDIAlWzZ6b3OQBoDbnLBGK?=
 =?us-ascii?Q?AWD6nU/3waxchkoVgqsbZQQHSmdJPfbuOB6/6SLRhTlR93ZBVqWzRhaPSGeo?=
 =?us-ascii?Q?CFz2DzjguAOQ3h8W9apoeVLvuvDXAplqJcS79I607CpNZ7eLDzRv56vG0b7h?=
 =?us-ascii?Q?2sR0RK2BCbQB55ytw1OAhZdTl1bJcLafmxhTIR5QJ8lc3+G6sl9uRDfXfaY1?=
 =?us-ascii?Q?BA6TCtwB7Q37nYcriRPH6wL62hsAIRZHPeZjO9m0kmU9slsYTD6Y0ntAYkGD?=
 =?us-ascii?Q?X3Qxl272ZvbU5cwZi+6CfC5sYuOMrAbvMF3tVB8n5zOQIKecGAMOLw8k2cV1?=
 =?us-ascii?Q?dL6S89hNGYuwtYdJIVl90q4eJJmsYfmqugcd6PFyR4xFFcpAiYaqZUCO86zu?=
 =?us-ascii?Q?zDXm/O6e0bdv/UXCqjAmHbsB1O/wyN65kdwLMzLl4SKZP2f//4tjlH1ltdGB?=
 =?us-ascii?Q?zmFV89pR6OHvAkze1u9PgMc=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4391ddf-1c5d-4c17-958c-08d9c53a42a9
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2021 11:00:26.8360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TAb9G9ag3lJ75oSas9MNbC3CY3xhBlvx3Dv/KsronKm1R3F5YqLz16rQVQkc4Wcqvo7Y5swVoYD3ffypdLJ2uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3402
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here __assign_str_len() should be used for the __string_len type, instead
of __assign_str().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 samples/trace_events/trace-events-sample.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/trace_events/trace-events-sample.h b/samples/trace_eve=
nts/trace-events-sample.h
index 5ab74fc9a2df..cbbbb83beced 100644
--- a/samples/trace_events/trace-events-sample.h
+++ b/samples/trace_events/trace-events-sample.h
@@ -155,7 +155,7 @@
  *
  *         To assign this string, use the helper macro __assign_str_len().
  *
- *         __assign_str(foo, bar, len);
+ *         __assign_str_len(foo, bar, len);
  *
  *         Then len + 1 is allocated to the ring buffer, and a nul termina=
ting
  *         byte is added. This is similar to:
--=20
2.31.1

