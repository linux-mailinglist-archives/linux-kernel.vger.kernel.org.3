Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF7855C952
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235996AbiF0Nk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 09:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbiF0NkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 09:40:24 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70085.outbound.protection.outlook.com [40.107.7.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273F6B71;
        Mon, 27 Jun 2022 06:40:23 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=n/C8PFhBWBA4pXpmb5euQXrXb8UuST4vrltuITLfYE1H4FeLMPqefxLswvDAEJ618bUp/sQgz3KXVUj9MPhJAfNOpFVgkccbIegP+qKBMBH+BxlTw4GjSR2+mqpfQTmJ9+wyvvLvwIlY6AXJNKpMtGh4phTuBnvzMCTO41IFBtKaprRWOAhbCt79209DbMgJAqCqE4OxQEJ8PtV0nc4zOEuhh6or54OSpjdAYmWZAqRZNze8aa7kRU6N1QYpNyGx9zW58R6BTKQSsLQ3uOApni7HGNDrHPI6w/tW5bseFzfHpr0rPIdaa/OH9AcNGbKXNScyuJMW/aDVTPKF5wkLyQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7fgD72nPynBaZgSkwk+NmjJm16cT13glVDdoluryPNU=;
 b=g0uSdfPB0VU0Uyv4v6qowUoqqqI1/3gjSwzDrOg6ls2OixJAUGD0iJRNE2T7Fd/YYWuiJ3gpavMXm0SVtIuyiyVCeA5J0jKfBj/IECjQHQmw/QbN4ZvYDxrNAXBQkHV6dWHwpZM/dnuZylgo4PorrcIlkqmMJkwisyN3D2cvPRzmbixFQfBC934HARbQATUdYeboIJx1QKQPGYs2uv0Ovysr5NJPYfTg95cfS4hbEGNpLnll6wNaLRHdHrT5iYiW502atQT+7tifZ9MY9MQSjQuVdeR9QbUXNIPWZJV6a5u3ln2gmVuOAyvvMZ6uM3+NdLtNsmbOLWhO1cWWvC5Ppw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7fgD72nPynBaZgSkwk+NmjJm16cT13glVDdoluryPNU=;
 b=JYLHTBLn4C/FPv0ulgAXLobMkGCvAMs2dSL1L26xmHM4J8sIOA+gIU9eUSDzLW/k9HqgjLTJp15Qc2jUXOx+Mm0Mfwoy8n3bPrdSwnZQug3Pjt1N5UGo69GBBnhBJDXmF60Y5j1PdZnJK3nMClbAnk28+h7+XQiAedhjzpCGqfY=
Received: from DB8PR04CA0025.eurprd04.prod.outlook.com (2603:10a6:10:110::35)
 by HE1PR0801MB2059.eurprd08.prod.outlook.com (2603:10a6:3:53::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Mon, 27 Jun
 2022 13:40:18 +0000
Received: from DBAEUR03FT037.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:110:cafe::60) by DB8PR04CA0025.outlook.office365.com
 (2603:10a6:10:110::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.21 via Frontend
 Transport; Mon, 27 Jun 2022 13:40:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DBAEUR03FT037.mail.protection.outlook.com (100.127.142.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5373.15 via Frontend Transport; Mon, 27 Jun 2022 13:40:18 +0000
Received: ("Tessian outbound d3318d0cda7b:v120"); Mon, 27 Jun 2022 13:40:17 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: efbec8c0c858ce25
X-CR-MTA-TID: 64aa7808
Received: from b5fb964353be.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 78B3BBED-E5DD-4EFB-886D-1C49644C2B34.1;
        Mon, 27 Jun 2022 13:40:07 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id b5fb964353be.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 27 Jun 2022 13:40:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KuUsvcH4ow2S739glGOEkWAacHrsahS0dZHgrpCncbJ+WLr2dw7T8uPwNRiqZbJofS1vOYRyL6mPpkPBsptnpNzMeKpvsoNbZjJNckKpABaS1Lxe5rIOwWL5PbRDVcMq3hsjdbOQo/oNTDgLV8aDchviDrSvuB41H9ELy06U54FoBwgX7pucqHIvhc+Pz0c7VtESMUcVPIc83qhecd22ImuhVaqS8oOjgdVvL0n/xYeR1OBS2Wz3ha7qqWE7fQ9IbtwtejBLQiiFz2nh9trP/cARoZEPkaA/pQVBDiaJ8C1U4rLRLVibGtB6mrBJ+UgJlmBrsHkreSNBo/3gesQlxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7fgD72nPynBaZgSkwk+NmjJm16cT13glVDdoluryPNU=;
 b=NRJ3aZnnlwZCVB5ef/JKemU/uN9twY04fB03svLIWetdypzZ1XhNxy1OHa8k/g3MYg/QKTYQ6IQthgGmuTJYsAfMM9vyJZGn2r8ThWl+BhfGSkIovvbyt3dhA0yiVH6hRHwg4OB4Eku152kTjP7Yr6pZXQO6pMnVj8xKZ25nRR6H/eCzwbk0Kv6+ORsgUAVYfSjIOszAAUyb8cAyKs7afUeH0tbQQ/iMCtg5IobU5SNNctq1lxzwk8m+QA/PjRPdaTphfFreg/ZiDcCtqAhaD15LnGH/yXURMrtkEwnbkxW9tHE6TiVQ3X2zkIuqyy6dAkJo8OMpsFaUd9lLk56+gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7fgD72nPynBaZgSkwk+NmjJm16cT13glVDdoluryPNU=;
 b=JYLHTBLn4C/FPv0ulgAXLobMkGCvAMs2dSL1L26xmHM4J8sIOA+gIU9eUSDzLW/k9HqgjLTJp15Qc2jUXOx+Mm0Mfwoy8n3bPrdSwnZQug3Pjt1N5UGo69GBBnhBJDXmF60Y5j1PdZnJK3nMClbAnk28+h7+XQiAedhjzpCGqfY=
Received: from AS8PR08MB8111.eurprd08.prod.outlook.com (2603:10a6:20b:54d::22)
 by VI1PR08MB3471.eurprd08.prod.outlook.com (2603:10a6:803:7d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Mon, 27 Jun
 2022 13:40:04 +0000
Received: from AS8PR08MB8111.eurprd08.prod.outlook.com
 ([fe80::1050:2cea:6ae5:160f]) by AS8PR08MB8111.eurprd08.prod.outlook.com
 ([fe80::1050:2cea:6ae5:160f%7]) with mapi id 15.20.5373.018; Mon, 27 Jun 2022
 13:40:04 +0000
From:   Dennis Tsiang <Dennis.Tsiang@arm.com>
To:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "mripard@kernel.org" <mripard@kernel.org>,
        "tzimmermann@suse.de" <tzimmermann@suse.de>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Lisa Wu <lisa.wu@arm.com>,
        Normunds Rieksts <Normunds.Rieksts@arm.com>,
        Dennis Tsiang <Dennis.Tsiang@arm.com>, nd <nd@arm.com>
Subject: [PATCH 0/1] [RFC] drm/fourcc: Add new unsigned R16_UINT/RG1616_UINT
 formats
Thread-Topic: [PATCH 0/1] [RFC] drm/fourcc: Add new unsigned
 R16_UINT/RG1616_UINT formats
Thread-Index: AQHYihAY2HJVH06gQ0+xJdAfJgLkRA==
Date:   Mon, 27 Jun 2022 13:40:04 +0000
Message-ID: <AS8PR08MB81117652E417826E741154B8F8B99@AS8PR08MB8111.eurprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 141b311f-f6fb-01fd-7544-7beaa4875e55
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-MS-Office365-Filtering-Correlation-Id: e6fec664-87da-46e2-1d9a-08da584292d5
x-ms-traffictypediagnostic: VI1PR08MB3471:EE_|DBAEUR03FT037:EE_|HE1PR0801MB2059:EE_
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: QL0lFaEznQIm1Hdu29RLSYTFtYcVSgaLU/AmWwvBMSWa/3rPYCGCAbKJWWtw04a6Lfo35tOkxztTH2y6EMbhJAWETJvl821ZcGhxIijClySti+opeZjE3XyXY25RrfaQHnXHOffPo0hBKl6jEmpuj9QjlqMjDw5sfj1h94fjb8a3clKxL2CZsrzRYjX8VCgrNvHw0hFM009jNzG7FrOg/qukebTBYE3cfAifU3bkDPHwN9xn1GSD4Uypm5tPxGI0XuzsOHjZzzQ0jxGrXOuoNX3aOq47UVXcJnu0tWPas8PWsVxNZC3jIMl8IDxIKQ+nlxSTmUY4/5je4s0WGDKSo0X890CJjScaPFaRpa+0yvqw/VkZAUfiBwzOoVIwFyHoaN4duwts7hDMJQO5Qc+swVp3D7WNOgB2EW9bi+K+3Sv7bdSc2dYM/QLcK710x/Ph0RcIUxZNelPVALurGT038QeCozN7mvGb/kql5/VVzZrT4WkMBegtB88ROsk3OiFS9gFksTgSi4KWi0X5qafgD2xWJa1cqJM3GcJWCeKageHZAQrmtVSrOxCkH73oQVm6m4qB3Ht1PFT82zsP8uRy+39ELqsVOdjw2NmIU0wbzWcIJenhAAQ1Eyv8w607MptJ3LtJVu/vZeGqzDNZrglgbaQmcOPXeEb7mYilx2FuT57neQ/zzqCf4rCWDQcZkjyzNYyIFtC+TmyYzI3zDXLmXRZtaD6TKtJwZNL/CLmtEic8JC4heCxNoMuaqskQK3QUkSWThmNgQw+gr7bgoji+UysJbcaAtTzmbpzj65IGwKE=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR08MB8111.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(346002)(376002)(136003)(39860400002)(8676002)(4326008)(66476007)(66556008)(91956017)(66446008)(66946007)(186003)(83380400001)(76116006)(5660300002)(7416002)(38100700002)(52536014)(64756008)(316002)(55016003)(8936002)(6506007)(9686003)(7696005)(41300700001)(122000001)(38070700005)(6916009)(54906003)(2906002)(71200400001)(26005)(478600001)(33656002)(86362001);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3471
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DBAEUR03FT037.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 56fc4a55-8aab-4b07-0eef-08da58428a94
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qtqr7DVBCoraUDffJjUavo06Anw3Zry6A2uoDeaKoe4Q8YThGqXD8xsGZN36817hBnQ34+YNVxvEUmhuI4tbbYG9OYvDSp91MtqUtxC1pbKcbGSmXr8tlMFtWRXaSLUW4lekuBGb2e536yga0XI/nq9W/8Lt6HyXVF6KZ7N8xYxciILjob5VHQuRwaKfnX1z7jJ0H+Yu7XKp0TSNFmChtNvrJRAZYW19igM0GTHBW18Xqh2fGEV3stBuBpvneM0t1z2spr9GcyvoFfjud/cDh7bn8X/c6xTa7rPB5r/SF1CYflk8ApshA+MrnQ0UGWmFNoeGIQO0Sh1FIDO1NznBFOpOT5p+LsfBFwozZK6dsuS63ApqvBOyfXJgstgtUJWAuwZ9KFvgSNj1Bfm4zZEqC1sR+yKT3AEHx9XUPT44ScHrlSU+sTElHMw5XvHtLyth06rzS9oJpTX7zb1EUkm/1zgwF77WTQSwe6xcSlYOrIR2ATE7wVXB+Ak+LUiJp5MI21EjSIrvlSOr1I7Wdz2iNkru8SMKvqftzVrsGBNYtQ9k1LBJAbyhIO4tJUpMEf3kVQOBGmXyQsnobN8gcpyRtHm8OBWKqKQjXz93gUP/Nz/0Py+/jfswN/vpobSR0Q1YMkONwxCHOwDnvNVczgQv62kx96uCSR+aMbTe7kPS7uphrvL7Gz2qE9orTQQRBs1Om8GqkMPRlrnMyD47edEGESYmdxquXSi3RUn0yAaBZGMpb2v6gC4TE+wAvcin6Xzavae14H7xYo39hzuxIvptPvIb/+R1uVKhUbgUhmpmQk5Ay1P5Zit+LyX3pdyXTTt/
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(376002)(136003)(39860400002)(46966006)(40470700004)(36840700001)(5660300002)(54906003)(336012)(40480700001)(81166007)(33656002)(7696005)(82310400005)(83380400001)(6506007)(6862004)(8936002)(82740400003)(55016003)(47076005)(70206006)(36860700001)(86362001)(26005)(356005)(450100002)(316002)(478600001)(2906002)(41300700001)(70586007)(9686003)(186003)(8676002)(52536014)(40460700003)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2022 13:40:18.0716
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6fec664-87da-46e2-1d9a-08da584292d5
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT037.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB2059
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is an early RFC to discuss the viable options and
alternatives for inclusion of unsigned integer formats for the DRM API.

This patch adds a new single component 16-bit and a two component 32-bit
DRM fourcc=92s that represent unsigned integer formats. The use case for
needing UINT formats, in our case, would be to support using raw buffers
for camera ISPs.

For images imported with DRM fourcc + modifier combination, the GPU
driver needs a way to determine the datatype of the format which
currently the DRM API does not provide explicitly with a notable
exception of the floating-point fourccs such as DRM_FORMAT_XRGB16161616F
as an example. As the DRM fourccs do not currently define the
interpretation of the data, should the information be made explicit in
the DRM API similarly to how it is already done in Vulkan?

The reason for introducing datatype to the DRM fourcc's is that the
alternative, for any API (e.g., EGL) that lacks the format datatype
information for fourcc/modifier combination for dma_buf interop would be
to introduce explicit additional metadata/attributes that encode this
information which then would be passed to the GPU driver but the
drawback of this is that it would require extending multiple graphics
APIs to support every single platform.

By having the DRM API expose the datatype information for formats saves
a lot of integration/verification work for all of the different graphics
APIs and platforms as this information could be determined by the DRM
triple alone for dma_buf interop.

It would be good to gather some opinions on what others think about
introducing datatypes to the DRM API.

Any feedback and suggestions are highly appreciated.

Dennis Tsiang (1):
  [RFC] drm/fourcc: Add new unsigned R16_UINT/RG1616_UINT formats

 include/uapi/drm/drm_fourcc.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--
2.36.1

IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
