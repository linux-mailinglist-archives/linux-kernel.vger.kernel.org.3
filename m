Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02A094B6074
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 02:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233312AbiBOB5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 20:57:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233301AbiBOB5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 20:57:08 -0500
Received: from APC01-HK2-obe.outbound.protection.outlook.com (mail-eopbgr1300134.outbound.protection.outlook.com [40.107.130.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E27DD449;
        Mon, 14 Feb 2022 17:56:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e6UQWV4bqEDJDGfdCFd6Pkg7SdRTh6+CSZJpFaA7F4MRkZi7s8vXECdwYSpLY0Q8sHcLhE98L3nSKrkcTW2sHh0T0cM9BJLECcsSaYeBxuXVZthTml4peUxptH3hnStvK0c62nO4R+w6ur8cvNT1pqRlqne2gHo9PBPq1ZojJaDhwxf4Lr3eHx8Vtw89h8VDDFMyFc0rBZQkrmJZKjmYEXCGS++fuvUyL5HIWUcYKD7TNmXuMMUphXNUKAZ0aZRcjpdBMGofxNX3Zl5hV88pYaWKRlhZrYZNnZW0XCuNawPYAyhm8dB38dJx9BBJWCL4o6qUC1WEacZnA5x3I+bR8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yrGpKWbmRp/53st+CREaW7lUNhmT8V/Jkoa0ucLI3So=;
 b=A9ZNuTRG6C9jWDrPfbPeHSv+G2PAf1WG+1xfeiIBJfYVGLTFJEsQBxVKQVFbVZaq8S8riNedShGZqhXQ4rVweXJOEgEhWoAxaD6VZP8ujchjC46fooRSwbXesKUjAhM3j7y9Y6sN9uJ5dF03QUvCGHYY0m546Mmn3SGbXX2ZRNj9E1pdGWhH6usstRJdqPxrGpP2a8N2tGebRihfVPK4zUZbso0iFbgApzDyhdg6JsHLruUdA/SQ+w5EKzJPwxeLdaxDKKPAENlOt0YKHmXojkvyrRQYB9pDM4mv9T6DaOh4JM00HJCQBWGeeyoG+tPDF3MJu469ZgVRuuJGXBFhDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yrGpKWbmRp/53st+CREaW7lUNhmT8V/Jkoa0ucLI3So=;
 b=RsEPiHO8X6r80bTwPLzwXmsIYsMUKr/BMrD5n1U5+KWQIxEKEm0skCqdtifp9wL6Y0WvIsWI7G19VuSaS5rUQQYWrNHX0/ml4ZFjN0vwKlscJk4VyH7rqMlk2lrjFZqIL5/Vd52BNVXYbdOkqttynGb+VzoZieJGLttFlIKU+Nc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by PS1PR0601MB1866.apcprd06.prod.outlook.com (2603:1096:803:6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Tue, 15 Feb
 2022 01:56:37 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::80b4:e787:47a9:41bb]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::80b4:e787:47a9:41bb%4]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 01:56:37 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Jens Axboe <axboe@kernel.dk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-input@vger.kernel.org,
        linux-media@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH V3 5/13] hid: use time_is_after_jiffies() instead of open coding it
Date:   Mon, 14 Feb 2022 17:55:42 -0800
Message-Id: <1644890154-64915-6-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1644890154-64915-1-git-send-email-wangqing@vivo.com>
References: <1644890154-64915-1-git-send-email-wangqing@vivo.com>
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0012.apcprd06.prod.outlook.com
 (2603:1096:202:2e::24) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eadfbac3-950b-4e51-be2f-08d9f0266665
X-MS-TrafficTypeDiagnostic: PS1PR0601MB1866:EE_
X-Microsoft-Antispam-PRVS: <PS1PR0601MB18668268A528DD80828EFBA2BD349@PS1PR0601MB1866.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sIoEfQemArsyulB5SoveymUgtCUx2xxzYy8UevUrqedCT7AVUtfGLKgvtMBl0B/j0EFZtGoiarNcH0PsWYj2P+d8+4QAJNKvHrhdlYWVdbc4ixPwQ1jgMreZmSC46pFJccm8h+uCIABXQnQjBDyEod3T9odut8IXpDteejFmeIShKCNcxGrOBoiUa2lyIk7HdzLaQFOoryvMWaKvIzf9sgCVpk/wduHsDQztJD/vhbPWtmuw1UAkiO+6V4gmhZhrjcizlPcNipi/GK4cmFP126zxjn+M3c3Td+PVzFZxS3uec3CDqfVXn4k10jQKHIqrFpnVit1cY6ilZYbqopl9t2P0lz8q4iNK1cPdle6dEHVWChAkoukdmkqW7VnBBXlMe5fT2CCyUQGbMCyXMOtquTaVZfXthJFjT69L5ImDDcsqx6xx1lJ/t8H+HRsDojEe1rsmL0iTwWmMqW83OWJUQuV4DP5tEgAg6J7XFG89MDCuTXKw1sw6EPJ0cTNrxaRjJuPQ+cbh9J5drX4jIP6kDFycWDx3Zwq7XDlA6bNoph+ddqV5CPk0RLIvPfFpRDDiTtVOqnV0mai7+5iyBHerM+utD9M02oxH3OccGhwNLYXoNELDpNuWLwse00MdUTJtpQR71T3cE5Gk2zvu8oQ7U18+4zXsAw6tj4XZzm5mvtOe/R2xGYBtEDsvZXHItmfxXZclirnMiuGLBAXQsW1mh7tJ5Ye0VfTD0GZ3MTqn8C0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(2906002)(921005)(38350700002)(38100700002)(8936002)(7416002)(7406005)(4744005)(5660300002)(52116002)(6506007)(6666004)(86362001)(66476007)(66556008)(66946007)(8676002)(4326008)(6512007)(107886003)(26005)(110136005)(316002)(186003)(6486002)(2616005)(83380400001)(508600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nuOoN1v5NxJXTwYzMrN0x3sqYLMRiw/LDRy6bOyD0Xsr4hYf8pMsWd+inzLm?=
 =?us-ascii?Q?tvk7emt5UWTwEK1BYfBu657jBKYwT3hnG7o24Rw5CGrlDae2canOwzEsfMs2?=
 =?us-ascii?Q?OLn1tVQR9ETMgGZINxuV+11W7xj5S+Uj4PDDvtQgeXePr+wuXBK7RgzFIdSr?=
 =?us-ascii?Q?JFdgolr7HdX9GSam0zA5nqM13feALzh2IOdiOgULRVFcGsVphYLKfFcu57L4?=
 =?us-ascii?Q?T3PuTvvZe8BXGBozZVPEf6j9Fyz2O0FteBASssgec2qwRmD2EuHxjFPCdcsr?=
 =?us-ascii?Q?zFQTAjFJLvX74qJPfOr0yq0x8ili8Yxt2vDqr+g2LTDQDoK6ClrVm63xxmrK?=
 =?us-ascii?Q?6GpP0PWLfZ+1+CVgGn9eIlRrbxWpOMsY0Bcd/Q8k0phlll+OG8ExcSrUSoAt?=
 =?us-ascii?Q?v4XAK95RND+V+n8sAM61bXuWa1MBIoiB8MPPN6v1NceIYCOqmVhXki8V4han?=
 =?us-ascii?Q?k0w+5PfiCR+q0gbTtzYl46sHlmjyOR2TCNwiExb/YgufOuq4vPnsSop8oJIC?=
 =?us-ascii?Q?0LgZ1RPqqKEDPqEyuQ45zCZB7eYAm+XuR2NxCjCx/rMfR0UkFaIbUXo7mRXn?=
 =?us-ascii?Q?PTtiGmQ9ANpqv2aGpCx3TXQGxNG5uvgYCPJ9Lr7LgFW8tyBqA3VZNjOICK8O?=
 =?us-ascii?Q?6oWfxJlp+E9vMdpPmQk768BLNoaeHP98r40/+U7H0YJu1/0abQrPzgFQuZaO?=
 =?us-ascii?Q?loc4gPoOS6h23+tRLoCmGwtnj6ucRCKeFdIdc+i+KPpzGNCALStkRFiOC8wO?=
 =?us-ascii?Q?klQ7z4/VCNeNGO0zdlywx6Ebq7IUVCCpCP248MxBk2rIuVf05MrM8BCyN1Ze?=
 =?us-ascii?Q?AoL7g+Ts5PFs5TehO/5I92XP+DYEwBMu1ZYsBpOLpa0HxVv69kZld9gyICcc?=
 =?us-ascii?Q?7oLAfv7YdTSIl/gr6u+VBEpqBNNX6q/p5p0U/+KvC3U4/QgCR5/uuRBQ66nJ?=
 =?us-ascii?Q?XMz1PNmarEmtqkkGw22G5OwNeP8v7361cY82qfQDQn5F+ZqQ3u8skqg9+16P?=
 =?us-ascii?Q?Q8Zo1aVdKUkEyySe51etV+ROMLe3bbNx3VWvfMdDoXpsmTHgvHX3/wuAOPdm?=
 =?us-ascii?Q?g/6q6CbmkfT7EP85+nqYZsCiMJMBOKztJByzJWBZy5iI9Sh2q0tDEhoow9bj?=
 =?us-ascii?Q?PplkxGUyMZMyXCRGpMWexmIo2Nom4pUSe8NcMEK9naPbj7KtM20i6J6Hlz9N?=
 =?us-ascii?Q?z0ZxR5E0HD05Es2SL4oO3+Y5au8zBAATmfsAqIB5hCumnRWlDri53SeakIjf?=
 =?us-ascii?Q?qThLforE339HXCtiXDuiLtQZBuoQjG8KEJjZgMchct6s0jchxTiVWKFm6D9U?=
 =?us-ascii?Q?jdXgFQPmUr8bZ47cdbxrvqmLjpo7etnZf23c0PWmOUuEp+8sOy7/L+oI5Uoo?=
 =?us-ascii?Q?VgqcBpkT7PSKX/XNXHknyb/dSnQCiSmcHeKm21MbplM8ivg0IRYGxcECiPUg?=
 =?us-ascii?Q?Y1GzzRYkWWjbaw6XinqqZpbvNMtYIoqTs63d6yTq6RTzRODnYlkvTUs/MA4y?=
 =?us-ascii?Q?eUM2fyH9I3kE+2JWxMmL3xVZ9z4JbJwIMThYHxS+NbOcpW8wBMfam7y1Ze16?=
 =?us-ascii?Q?Gi4aDemijDKIF1eyGtYcCIDe3WPSESgmdpxzQ2vuAMmhcG5srwt+MMqnI9Dc?=
 =?us-ascii?Q?+n0kvf3Zho0xCPx5La9Ka1s=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eadfbac3-950b-4e51-be2f-08d9f0266665
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 01:56:36.8565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iBSGzwX/ZNVxWcftvmwAeS99h7MtCcwLH0F2V0ZE6zOpA7y9IDcAuvx1RaxR1CS0yG68ht/dIJrg6qqRZNiB4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PR0601MB1866
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Qing <wangqing@vivo.com>

Use the helper function time_is_{before,after}_jiffies() to improve
code readability.

Signed-off-by: Wang Qing <wangqing@vivo.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/hid/intel-ish-hid/ipc/ipc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/intel-ish-hid/ipc/ipc.c b/drivers/hid/intel-ish-hid/ipc/ipc.c
index 8ccb246..15e1423
--- a/drivers/hid/intel-ish-hid/ipc/ipc.c
+++ b/drivers/hid/intel-ish-hid/ipc/ipc.c
@@ -578,7 +578,7 @@ static void _ish_sync_fw_clock(struct ishtp_device *dev)
 	static unsigned long	prev_sync;
 	uint64_t	usec;
 
-	if (prev_sync && jiffies - prev_sync < 20 * HZ)
+	if (prev_sync && time_is_after_jiffies(prev_sync + 20 * HZ))
 		return;
 
 	prev_sync = jiffies;
-- 
2.7.4

