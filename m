Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4E8C55CED6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236165AbiF0NmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 09:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235234AbiF0Nl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 09:41:58 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00073.outbound.protection.outlook.com [40.107.0.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84382AFA;
        Mon, 27 Jun 2022 06:41:56 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=Pzm0+ibdEB/ush7XCc1T5/a39T4supxTZrsqOIJL1y1/miAIu3d8i3+71zjWiXKmc1p+CphekfyYnKN9/DKNCHnfCvUxmNG48LX0r0VJ0nbUUo571j5txUacL6BdARcbTRUB3vXIAPAWfsPVvRNvt+SbN9FyW0BecHZ/ipXGpEAlDNNwf2ucHqbIJZrqFVl1uDlVAwmGAEH/6Kb6fXWOBemGZLV7yb6GvW51hd0zg1RS09rtzsRfND2VS0qikRkxWkiceV4qMaA5HR/WRckilBSKNn/ZYtuxgyj7qU6C7+4QkENr1QLrsoMvdQNRlsdKsgDrA8kAzk6xeROzY78f2Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6A/jsnnDAy3MIcCKZHVPer0knJRNuaEswqZGUYjinqM=;
 b=ewxtmaugPC6bUPOt1hyVWds+Eockij6RL1GCS9zwWtyC3d+8J3H2PhhKEuHVlORhASHCN+ZMjH3bXfJy5c6XYrmL18LdnUGJqU/EU5oy+uKYDaUhtbsmBcDAxmG405Y9dMdJncT8zNeVP7eYiiKe0dwzgNXD0PxaGv/lk/tJ44IapnelDjLVOUfKmy5myn4A7OvofSXa8XyZ9JT3aaRtFh4Gphr4FNThc5N+PAlkpsjMMCpRwNnOk4V6tyhBWv0dg4dRAjj73FnAXf5aGiNaj9Wr2rew7AhcxHlGbTrelh5mB5gi3i8ahBUXqfQ5kgmVwLDdQ2BPybr4fZc9AkMphg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6A/jsnnDAy3MIcCKZHVPer0knJRNuaEswqZGUYjinqM=;
 b=dA6wWAE4pCcnqp+L5VCy5DMFLPCT0/qZWk8n8VQYK4mTMWEE4hRXohp1VbnaAl4xLoPWSaegivSutc+U6T8CEvgi3Hmw2waxBsMJVb+e2s9CYoUSgB1QkQXBLHGPxr6pKSPnMyiIC3V1OWhJ3D9g6QzMxa77T0u+p4bFATismxY=
Received: from DB6PR0301CA0088.eurprd03.prod.outlook.com (2603:10a6:6:30::35)
 by AM6PR08MB3512.eurprd08.prod.outlook.com (2603:10a6:20b:4f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Mon, 27 Jun
 2022 13:41:53 +0000
Received: from DBAEUR03FT007.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:6:30:cafe::a5) by DB6PR0301CA0088.outlook.office365.com
 (2603:10a6:6:30::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.21 via Frontend
 Transport; Mon, 27 Jun 2022 13:41:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DBAEUR03FT007.mail.protection.outlook.com (100.127.142.161) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5373.15 via Frontend Transport; Mon, 27 Jun 2022 13:41:53 +0000
Received: ("Tessian outbound e40990bc24d7:v120"); Mon, 27 Jun 2022 13:41:53 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 35f1cae9cb91e2d6
X-CR-MTA-TID: 64aa7808
Received: from 87e66a722269.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 59D621F2-3339-459F-BD38-D148D18CEF64.1;
        Mon, 27 Jun 2022 13:41:43 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 87e66a722269.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 27 Jun 2022 13:41:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kKbdBBwHfRJJnDYOYIsUtY7MQEm1HxIOltMWR4vTaiI7PMwYlmR4tBMtIIKcWKkTraUZrWNikDD49QabNbWiW2eRi9P77qMuYaPQdJdKqFXADn4KdkrNCZ8wQiqzBsGPvJubjsL/11U6h79eN6x/3RM6iAcy2ZZMy1+bWSCi7sqVImRK5HVdPQzrz+oUgCYFKlCZREkfbCpw2MJATT8Fbc7s1UXr01WG2C3M9Wu1WRH3L6oAiKD7XMYppXlPWj07xiOBQ2JwmAPlxSD7V+oH/s7A6rovb75ETijDpgnY+ivMSEsBm1OBRiWHzvouetDaWvyIwFoeZO27Myci89v80w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6A/jsnnDAy3MIcCKZHVPer0knJRNuaEswqZGUYjinqM=;
 b=Xoc/WUAtz60VjxykzdJBcIUqosNMgWDo1dH11xT6+2Ki4KmI4DjRF694ftLe/uXTc8cjTcJ6MUEL6z/UAk8uCP38+zVgcskE5WkFWmTyMuOFZNCgRed989O8e8F1R9+/GqvEnH6fE8gaPUPLS39LnK1osLMTDCHexS4Ivuev9zPo+Ik27wQCnZyeZTo0AVHpZ2u/IDI0BmAioyDXwUeanasPobMQ9ggG/ZK/4Dch8PXryN82VFxrO7woIgrl6fWDS18hTaRj5j+/TlPpDlFS6K1D4XA2SOhWFjoYi9w60aswzuPaEPmGVZDjomJ4iS/B091tpgQ9QzbNVfi4FBHFbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6A/jsnnDAy3MIcCKZHVPer0knJRNuaEswqZGUYjinqM=;
 b=dA6wWAE4pCcnqp+L5VCy5DMFLPCT0/qZWk8n8VQYK4mTMWEE4hRXohp1VbnaAl4xLoPWSaegivSutc+U6T8CEvgi3Hmw2waxBsMJVb+e2s9CYoUSgB1QkQXBLHGPxr6pKSPnMyiIC3V1OWhJ3D9g6QzMxa77T0u+p4bFATismxY=
Received: from AS8PR08MB8111.eurprd08.prod.outlook.com (2603:10a6:20b:54d::22)
 by PAXPR08MB7247.eurprd08.prod.outlook.com (2603:10a6:102:212::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Mon, 27 Jun
 2022 13:41:40 +0000
Received: from AS8PR08MB8111.eurprd08.prod.outlook.com
 ([fe80::1050:2cea:6ae5:160f]) by AS8PR08MB8111.eurprd08.prod.outlook.com
 ([fe80::1050:2cea:6ae5:160f%7]) with mapi id 15.20.5373.018; Mon, 27 Jun 2022
 13:41:40 +0000
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
        Normunds Rieksts <Normunds.Rieksts@arm.com>, nd <nd@arm.com>
Subject: [PATCH 1/1] [RFC] drm/fourcc: Add new unsigned R16_UINT/RG1616_UINT
 formats
Thread-Topic: [PATCH 1/1] [RFC] drm/fourcc: Add new unsigned
 R16_UINT/RG1616_UINT formats
Thread-Index: AQHYiiuhzWQ6qVyNMUCCgXIluRaSKg==
Date:   Mon, 27 Jun 2022 13:41:40 +0000
Message-ID: <AS8PR08MB8111253493F5F36AA20E75D3F8B99@AS8PR08MB8111.eurprd08.prod.outlook.com>
References: <AS8PR08MB81117652E417826E741154B8F8B99@AS8PR08MB8111.eurprd08.prod.outlook.com>
In-Reply-To: <AS8PR08MB81117652E417826E741154B8F8B99@AS8PR08MB8111.eurprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: f95b30b6-4709-e20d-7121-8452f5afedeb
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-MS-Office365-Filtering-Correlation-Id: b54e089e-3e57-488e-e87f-08da5842cbe5
x-ms-traffictypediagnostic: PAXPR08MB7247:EE_|DBAEUR03FT007:EE_|AM6PR08MB3512:EE_
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: N5zPr97vGzoz8G7iZW2tqBPLqczzY83ig9eibILn8FxzzbgWx7VLQVCsGzZKmisWNsaoxpXiCU2X9dGNQXkhlEGDRYyYDtNhETVlyidY8e1ih+92lND5nMdCfCauFneB9qMUc3UA8wyddrsd8VrwWfigLSxPGfZDjxrcCARNPE5qbyp+0KrDZdJB8U67QotcdyVyflWFvpVpCNlXBiMr0uqjWCBPGc9GL4eXWV/V/PD6AUogpzbQvwcSY7ebN8+OkTMcVxFpuz905uUFTb6m1Xz3xIkBCPGHUWD8mFUm38knnFubpMujR5bVOZ4b0p6/vf7EzKSM3iAxbYgaNC67prOSkvWvXnJhSkK305hh4C4/+ZNKwRv7GBwvpiBdijHcdyejiYHh9KZ8OdxRH41VoGrzeiq5zcKl55NkvZ3UF46LwvpZrkDZ7g+EPjterg39rkyJvihI7j0RZPEr8zm/UeAra8rEH6HOZSBlzv5TnN6Md+q3vcaz6CxAzNIJivDjSisEbvSrWAi+3/ET7JGy3nfa61v2YFWpPeaYYfFbzgVLK4zIyG/N5KWuzLjOA7TSaC9n2Mdl1HRNSTYczv2NazjBz9PG/59GWpfpTL8mF2XSAsYMwhJEP/qmUSo8fI/h21qldBp00MlCi5HEuw6Z8DnDlUWrk0XzekdxdGLt6NMhHQSrWX69Wv7MWKottkmxcDXBmXUhvZ3PFkenHKESblixbZy8ug7Poa5Uawnn7/zcw6xI2tJlhmLwnTte95FD8D6bB8srMAiNL+TctkBD/NeM6q1zMIa8vEEInVL52Lo=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR08MB8111.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(346002)(39860400002)(376002)(136003)(52536014)(33656002)(4326008)(8936002)(8676002)(7416002)(55016003)(54906003)(66476007)(66556008)(76116006)(66446008)(2906002)(316002)(64756008)(66946007)(71200400001)(2940100002)(41300700001)(26005)(86362001)(6916009)(5660300002)(53546011)(7696005)(186003)(478600001)(38100700002)(122000001)(38070700005)(83380400001)(6506007)(91956017)(9686003);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB7247
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DBAEUR03FT007.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 955cfa80-0e25-409d-55a4-08da5842c410
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OpHbzss5vY3+7AmiztIKRKEHyikEiOX8azjYExhDBuPIZGwv6srKEb0j1j3ZZXbGPGje1nmU66ArZZh1sSPeppnaw8ok3F/qELX72CofSMmIMh+xaDQe/yamB1XvxZ1B2X/gk2Ar2WIZuzP4YOwkahtGiwsqVoqEdI3e+mXzSjSoZt1hK/hTCtbAp6B1aUFfWlpb3nw1MeLmXCuGVPZtEehYcylPugnQCpj5rTmPnwh3AsZsq1gP1tJc6I2V9S3G/XbEazREEjiipwh6aBZWEwwzHWnFTJWNlcjWgBCXhxSbQyBwBLNWodDzUzd7QvnmNre+08YMYLsfC6s08QGiLktmB1aMVts4LIADsb7MvTDbjqMjLGR8HQyC7mR/3OQjHyg0ON00mMHe8XAZD8dVkAW7WfspZQEOQukhIFWH4CmRgcoFHmVG8j0LZ4klv4Au5Qk4Jy77aM8Gbdtne0xRjkdH+kJTchLIrtnC+GI7oiRE5tAJPAvXZxcd9B4K0ytdY0MtGtcorzUohHwYMLC8QOaAgN+GktBWZM2W1G3cjP4yU4LKogTTyJIJ1en3hc8W1QpTf4pk2DFJ6a7wwSbkGugEMipTEyAExVnnrugAm5+tbumLw+U+WjkxDGgtupYPN4sT+JPT+vY0iyXy4YpH6e74Td69tYkTtYAprlwGDmduyhxF/6K0ApxFQxkNphrLNAplrB63gwKAg+nA/V3qdH8oBlxEqeWPbcxzaHtDw2O8sMazVyqgkbvfEdqpn/bT7XpOLBsKF1GIsfM728bzuuI3FtT5SIVmcdtUrPEbnkMzRxgRACy6qzBYRNN8J9gO
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(376002)(396003)(39860400002)(46966006)(36840700001)(40470700004)(7696005)(356005)(82740400003)(54906003)(26005)(82310400005)(52536014)(81166007)(53546011)(33656002)(6862004)(6506007)(336012)(316002)(2940100002)(9686003)(40480700001)(478600001)(5660300002)(450100002)(186003)(86362001)(70206006)(70586007)(41300700001)(83380400001)(40460700003)(47076005)(8676002)(55016003)(4326008)(8936002)(2906002)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2022 13:41:53.8118
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b54e089e-3e57-488e-e87f-08da5842cbe5
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT007.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3512
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds R16_UINT and RG1616_UINT DRM formats that represent unsigned
integer formats.

Although these formats are not used at this moment, they would need to
be exposed in the future for applications that need to use raw formats
suitable for camera ISPs

Signed-off-by: Dennis Tsiang <dennis.tsiang@arm.com>
Signed-off-by: Normunds Rieksts <normunds.rieksts@arm.com>
---
 include/uapi/drm/drm_fourcc.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index f1972154a594..fdb7d2a76507 100644
--- a/include/uapi/drm/drm_fourcc.h
+++ b/include/uapi/drm/drm_fourcc.h
@@ -112,14 +112,16 @@ extern "C" {

 /* 16 bpp Red */
 #define DRM_FORMAT_R16         fourcc_code('R', '1', '6', ' ') /* [15:0] R=
 little endian */
+#define DRM_FORMAT_R16_UINT    fourcc_code('R', '1', '6', 'U') /* [15:0] R=
 little endian, unsigned */

 /* 16 bpp RG */
 #define DRM_FORMAT_RG88                fourcc_code('R', 'G', '8', '8') /* =
[15:0] R:G 8:8 little endian */
 #define DRM_FORMAT_GR88                fourcc_code('G', 'R', '8', '8') /* =
[15:0] G:R 8:8 little endian */

 /* 32 bpp RG */
-#define DRM_FORMAT_RG1616      fourcc_code('R', 'G', '3', '2') /* [31:0] R=
:G 16:16 little endian */
-#define DRM_FORMAT_GR1616      fourcc_code('G', 'R', '3', '2') /* [31:0] G=
:R 16:16 little endian */
+#define DRM_FORMAT_RG1616              fourcc_code('R', 'G', '3', '2') /* =
[31:0] R:G 16:16 little endian */
+#define DRM_FORMAT_RG1616_UINT         fourcc_code('R', 'G', '3', 'U') /* =
[31:0] R:G 16:16 little endian, unsigned */
+#define DRM_FORMAT_GR1616              fourcc_code('G', 'R', '3', '2') /* =
[31:0] G:R 16:16 little endian */

 /* 8 bpp RGB */
 #define DRM_FORMAT_RGB332      fourcc_code('R', 'G', 'B', '8') /* [7:0] R:=
G:B 3:3:2 */
--
2.36.1




From: Dennis Tsiang
Sent: Monday, June 27, 2022 2:40 PM
To: dri-devel@lists.freedesktop.org <dri-devel@lists.freedesktop.org>
Cc: maarten.lankhorst@linux.intel.com <maarten.lankhorst@linux.intel.com>; =
mripard@kernel.org <mripard@kernel.org>; tzimmermann@suse.de <tzimmermann@s=
use.de>; airlied@linux.ie <airlied@linux.ie>; daniel@ffwll.ch <daniel@ffwll=
.ch>; sumit.semwal@linaro.org <sumit.semwal@linaro.org>; christian.koenig@a=
md.com <christian.koenig@amd.com>; linux-kernel@vger.kernel.org <linux-kern=
el@vger.kernel.org>; linux-media@vger.kernel.org <linux-media@vger.kernel.o=
rg>; linaro-mm-sig@lists.linaro.org <linaro-mm-sig@lists.linaro.org>; Liviu=
 Dudau <Liviu.Dudau@arm.com>; Brian Starkey <Brian.Starkey@arm.com>; Lisa W=
u <lisa.wu@arm.com>; Normunds Rieksts <Normunds.Rieksts@arm.com>; Dennis Ts=
iang <Dennis.Tsiang@arm.com>; nd <nd@arm.com>
Subject: [PATCH 0/1] [RFC] drm/fourcc: Add new unsigned R16_UINT/RG1616_UIN=
T formats

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
