Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 750FE525B62
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 08:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377254AbiEMGQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 02:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377286AbiEMGQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 02:16:37 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70054.outbound.protection.outlook.com [40.107.7.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C9C63BEC;
        Thu, 12 May 2022 23:16:20 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=Bq1706wbmW2Osa3no/bzS1Hr520B/7DkMzC3WnJfomo3WVi+zrFa5m+74Xa+vfQFTYQBGfrBpOEkCJkkZUV/FG+u93TLnDf3vlafWuwNpBSm951v7p0G98eEVH7za1D4LwGLYsVh+xM6+SNiwxoaEnZSM2cZXEN6RSs7Dp2oeBqkht1QAAn1E4yKh7D8yOpjE5pzhH7bKmir6BkEUQmEA4hams5UZLFelWLKqnkHT/NYDOqm3nwhIdBQWZwaazb1tzzVDNZjFc59W8IIlOtzR+NridMm1u/lHHKkxKbOSbxYt86CHH3E4DhDzKOvAOd+fRUg2NfUFsXi2+W7asQxqw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HTkObPw5wL6ftrPIks7BMuiK+p+gT+89X6z8XuKL3I0=;
 b=TYbyHb2k5qP1Cs3nNNaVvUrwo3UK85bbt714y3pJtEEt84mRl6dIR+ax6zSlsD1L1QwMjdr+0YydXmxSh8YsEDK4H27q+AmLcWpUY/NPuRQzeTs4iW9ZSwJLQ+ulXjQHfcCxCuYzkSmDVl6MAAoO8tulcAv7o9cmTJN/9WI+xgWuCmlSqA6VLAZ+5MxsS5oZyvdS5hBD2UAFCfacXZwiP4JJkXExHNvvPXV6JA9ZiUgBHTmPxL3ZOEoyai2s0eY/qnefLJ4O8bhMVKFxlbu/F4WumMrkaj6U1B0AhgH93HzIyksosLrCXrMZIijlbzhiDy9XD+HMEEuJNO1EiiAYiw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HTkObPw5wL6ftrPIks7BMuiK+p+gT+89X6z8XuKL3I0=;
 b=KUstzwBqHoogIdIIQAZanXowkotB/D7Lzv59bpYahdDnPP6il7cK5iGnaeqv2orQtBGSsIHALNC7JD5B70WBVf3Ql29hUgMxY1+to6gqjrxpGrOYQ241gZ5Bsvv0tjNLfe4KRF+yaPkWwj0MFgDqACBzX1LY5KtrzUeMAOmAZ0M=
Received: from AM6P194CA0005.EURP194.PROD.OUTLOOK.COM (2603:10a6:209:90::18)
 by AM0PR08MB3716.eurprd08.prod.outlook.com (2603:10a6:208:106::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Fri, 13 May
 2022 06:16:17 +0000
Received: from VE1EUR03FT007.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:90:cafe::72) by AM6P194CA0005.outlook.office365.com
 (2603:10a6:209:90::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13 via Frontend
 Transport; Fri, 13 May 2022 06:16:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT007.mail.protection.outlook.com (10.152.18.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.13 via Frontend Transport; Fri, 13 May 2022 06:16:16 +0000
Received: ("Tessian outbound 42cead292588:v119"); Fri, 13 May 2022 06:16:16 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 9434bb43274a9bb6
X-CR-MTA-TID: 64aa7808
Received: from 163e7d56271c.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id D33DE015-69CC-408B-89CE-63F478F149DB.1;
        Fri, 13 May 2022 06:16:09 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 163e7d56271c.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 13 May 2022 06:16:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hXYmM5wo/l5JgtQXdsCfmLE/vSk72tcPy1bSke9RIMmqEKQDaXC4camyxOnqUsQfrMZx2/VEUcX1OKfe1W+Q+vGMRFJHLvjill6ECol0bIxMhs9QgM8hKrdshI1QaivvSn0qf6ocC3goLsCGUmSO74DCbDv6rtCdjStcJ6RzcHHrp76GdXzxzCmh22C3/qLeFtwmM7lkmAPigA50lCKPqYWef3viyjw1d4scB6g95RcR3nqzr2Mb+M2Mtar+3awQBrRj9uCtGv+FdypiCkb2/SjWfJgRRaxrQaQrbCnSqj1GRcZQwZi5VUQ3GU2eY2LGDbq2cjuuCpxd1Fs4zYUH4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HTkObPw5wL6ftrPIks7BMuiK+p+gT+89X6z8XuKL3I0=;
 b=HLVLzGFo/iomdnl6p7okYt+gUPieq88W5e0iRVZsP15DpmFYz+2y9FvBKxSeNjehKdVvk4bHHTdXdjBZUGVLsI7oNjNwUELIUP8jYMnkAYb412hQb97IPr+PtvHiE6TKtX3dcuQuPAfBuxcQY5kcJ+psGhUJ5Evivlkz7okl86ZsynrQPVku+zwO+NodbLFrnmi1b3hgeZ8Vy3CDovg+JLGy2aRF8KpxjvLJJ7lYrkOjbZTcWXlA9ZbsldTZpLRNGT3V+zvkEnjXNcKm1pXK4Cb4MlowR1BAgOIBZ8s8/alHu0NemTrD2ZwMvqP9CXVmdCjNfi5GywYtTHnLoFMkKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HTkObPw5wL6ftrPIks7BMuiK+p+gT+89X6z8XuKL3I0=;
 b=KUstzwBqHoogIdIIQAZanXowkotB/D7Lzv59bpYahdDnPP6il7cK5iGnaeqv2orQtBGSsIHALNC7JD5B70WBVf3Ql29hUgMxY1+to6gqjrxpGrOYQ241gZ5Bsvv0tjNLfe4KRF+yaPkWwj0MFgDqACBzX1LY5KtrzUeMAOmAZ0M=
Received: from PAXPR08MB6622.eurprd08.prod.outlook.com (2603:10a6:102:153::19)
 by AM8PR08MB6577.eurprd08.prod.outlook.com (2603:10a6:20b:355::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Fri, 13 May
 2022 06:16:06 +0000
Received: from PAXPR08MB6622.eurprd08.prod.outlook.com
 ([fe80::35bc:7f46:b74d:1379]) by PAXPR08MB6622.eurprd08.prod.outlook.com
 ([fe80::35bc:7f46:b74d:1379%2]) with mapi id 15.20.5250.014; Fri, 13 May 2022
 06:16:06 +0000
From:   Thanu Rangarajan <Thanu.Rangarajan@arm.com>
To:     Robin Murphy <Robin.Murphy@arm.com>,
        Besar Wicaksono <bwicaksono@nvidia.com>,
        Sudeep Holla <Sudeep.Holla@arm.com>
CC:     Suzuki Poulose <Suzuki.Poulose@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "Michael Williams (ATG)" <Michael.Williams@arm.com>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Vikram Sethi <vsethi@nvidia.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH 0/2] perf: ARM CoreSight PMU support
Thread-Topic: [PATCH 0/2] perf: ARM CoreSight PMU support
Thread-Index: AQHYYzvGDBbh7ynXkEKV8r6emdnQx60WR+MAgAAJZoCAAaSVAIAAAZKAgAB864CAAHJTAIAAu+AAgAMHV4A=
Date:   Fri, 13 May 2022 06:16:06 +0000
Message-ID: <0EFAD9D7-42C1-487F-9D62-44BE08F6CF1F@arm.com>
References: <20220509002810.12412-1-bwicaksono@nvidia.com>
 <20220509092843.GB26264@willie-the-truck>
 <2e5e09f9-b71b-d936-e291-db8f94554b18@arm.com>
 <20220510110742.ievkihggndpms3fn@bogus>
 <20220510111318.GD27557@willie-the-truck>
 <20220510184025.iwgknfqe5ygz4jwn@bogus>
 <SJ0PR12MB5676E68453A977F1220FF7AFA0C89@SJ0PR12MB5676.namprd12.prod.outlook.com>
 <b0b92bdd-9ebe-8ce9-abe3-1f4d05a838dc@arm.com>
In-Reply-To: <b0b92bdd-9ebe-8ce9-abe3-1f4d05a838dc@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.60.22041000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-MS-Office365-Filtering-Correlation-Id: 73704ec2-f314-4152-ff35-08da34a816b8
x-ms-traffictypediagnostic: AM8PR08MB6577:EE_|VE1EUR03FT007:EE_|AM0PR08MB3716:EE_
X-Microsoft-Antispam-PRVS: <AM0PR08MB37167BFA11F9269610B97AC18ECA9@AM0PR08MB3716.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 2gURAKtDFj0VsW0z7SvxuNX8pUl91kZ1oE5GM6Z5icqBpcc+ZPC6AUKfnDXv2xsmbx0ot/V4lPthXDtS+fXonVkO3jxQGOQoFyKPHn3ssLY61fZwphjW6aoZStcNFh0pAIAIkkJS1021CeJP+ZZMVyoFaYnWB/5nyHGHnBrsief4qbY9Y4hjCZsEGq+JYgOLZiQB2vGKKJuNR3H/vUpX2Vpk/bACD5hz4QJDDssxVKsSk/Rs1wnP85W1BvCn7hAQPOxwj/UBhJIORTrBVbuPl/BSSlch83bBMrFzvqvvAUkqJ5sqBpwcW46eURj6WvYynfLGIuyQM1Bk2qwC2lbwI3cCRNm9fdGPHM/szCpVVxS7xAAZh+JNxOpkel9S9v2qF21F1LcugasvQvuulhSIW3DkLpufM1xTe7YFGNwHpI9zxKqPGpxFTAjz95YmH/SEcJIvpJ7RyX1yiOQjzo/6LJSgHR2b98SwY52oHkjSL5bJvXZtwCchsGIcnadb7u5IafICyKAlw+/90Qsk6s7cj3G8hWhgFJ28DoyNqMyltt4NsBnblxEKdeuy+SvzLlccCVGPUrxs1O460G/TZ6ieo0ZIkAL2pmrErBvSbexlNJH3a7dd6QJe//B8lErR58CvafhrdgF2QH6eCyHh39B0Qqjmo18VTtcA2UYZc5ezd7bqo60PkAt0gdkRlDDO6GlPuUUVgtJpCdx9wMqYvqe+M0q6jE9zzp2ofONXNS7cumM=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6622.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(66476007)(66556008)(64756008)(110136005)(8676002)(316002)(66946007)(4326008)(91956017)(66446008)(6486002)(76116006)(54906003)(38070700005)(508600001)(38100700002)(6636002)(122000001)(71200400001)(83380400001)(33656002)(6512007)(2616005)(6506007)(53546011)(26005)(36756003)(5660300002)(2906002)(8936002)(186003)(45980500001);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <EAAFB44C04CF5545999FCBDAF22271D1@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6577
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT007.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 765227f7-565b-4f3b-bcd0-08da34a810c4
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DQJLUhmuigQND1+tFANoYeHU3ibS9c49Op3zNLXoXyBM+QNx+NEhPBy/TT3sq5lHvLkW5P60Z7x+RH1jgjgRXX479RgIzVt2X92nw7EUgZ7YVGj/hjC5Fo+MmWGGShVbrqKVxeAk4ONkv+p0etzHC5Ig+Ejh7tN6bEPCFp6avK88DBv74cwng1iZdg24u+5tJ3MQuXlFIodv1Vn/fg3Z0gMvuH4nGfSsg94MtAec2cl2xLxY6O0w5VNpYzXMrH74eVSnW/Mr3GeXuDW86LTGPOeQz8kqdPh8YPHsfEn/WNECX5YCqoYe01CbzK7vQMSobo5kMVLi6QCkgIiygNdozAYLBqGRsI6TGc0oBylHiq6rcDhFvZJ7BCWQlzhvY07x5BcxSscJPzSqJuZi3TlDck1+sa83d8yJ2JlrPmsfzlvnugdmUBPlz1Q8qhAkMTHbVBbkWuZNKYHFGFnzmKvMD8opokNF9zAaenv8Q2wH13PKOvCYXr5SIcEB+aAHZvcrrfGuzgcEiGxLmuztJoz3pikmHrsBvUbbQQuUVkI0HNLF7JKltxBZwrLojy6UJEwb15qrWGutWvWZ3JUKWa1x0xcRxc9WlNfYQH2fMCBNfZyN91qOd6+Bn/t/4gp9zX8egc24d9nceVcCSspfumd99kVapby+Ymfp0GmsuEMg8YgOG2tBLAZ1fqaVXGBPkN8O
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(4326008)(6506007)(6636002)(356005)(110136005)(8676002)(2906002)(5660300002)(53546011)(81166007)(54906003)(8936002)(316002)(186003)(82310400005)(40460700003)(36860700001)(2616005)(6512007)(26005)(47076005)(33656002)(70206006)(6486002)(336012)(86362001)(70586007)(83380400001)(107886003)(36756003)(450100002)(508600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2022 06:16:16.4844
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73704ec2-f314-4152-ff35-08da34a816b8
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT007.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3716
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCu+7v09uIDExLzA1LzIwMjIsIDE4OjEyLCAiUm9iaW4gTXVycGh5IiA8cm9iaW4ubXVycGh5
QGFybS5jb20+IHdyb3RlOg0KDQogICAgT24gMjAyMi0wNS0xMSAwMjoyOSwgQmVzYXIgV2ljYWtz
b25vIHdyb3RlOg0KICAgID4gDQogICAgPiANCiAgICA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KICAgID4+IEZyb206IFN1ZGVlcCBIb2xsYSA8c3VkZWVwLmhvbGxhQGFybS5jb20+DQog
ICAgPj4gU2VudDogVHVlc2RheSwgTWF5IDEwLCAyMDIyIDE6NDAgUE0NCiAgICA+PiBUbzogQmVz
YXIgV2ljYWtzb25vIDxid2ljYWtzb25vQG52aWRpYS5jb20+DQogICAgPj4gQ2M6IFN1enVraSBL
IFBvdWxvc2UgPHN1enVraS5wb3Vsb3NlQGFybS5jb20+OyBXaWxsIERlYWNvbg0KICAgID4+IDx3
aWxsQGtlcm5lbC5vcmc+OyBTdWRlZXAgSG9sbGEgPHN1ZGVlcC5ob2xsYUBhcm0uY29tPjsNCiAg
ICA+PiBjYXRhbGluLm1hcmluYXNAYXJtLmNvbTsgbWFyay5ydXRsYW5kQGFybS5jb207IGxpbnV4
LWFybS0NCiAgICA+PiBrZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZzsgbGludXgtDQogICAgPj4gdGVncmFAdmdlci5rZXJuZWwub3JnOyB0aGFu
dS5yYW5nYXJhamFuQGFybS5jb207DQogICAgPj4gTWljaGFlbC5XaWxsaWFtc0Bhcm0uY29tOyBU
aGllcnJ5IFJlZGluZyA8dHJlZGluZ0BudmlkaWEuY29tPjsgSm9uYXRoYW4NCiAgICA+PiBIdW50
ZXIgPGpvbmF0aGFuaEBudmlkaWEuY29tPjsgVmlrcmFtIFNldGhpIDx2c2V0aGlAbnZpZGlhLmNv
bT47DQogICAgPj4gTWF0aGlldSBQb2lyaWVyIDxtYXRoaWV1LnBvaXJpZXJAbGluYXJvLm9yZz4N
CiAgICA+PiBTdWJqZWN0OiBSZTogW1BBVENIIDAvMl0gcGVyZjogQVJNIENvcmVTaWdodCBQTVUg
c3VwcG9ydA0KICAgID4+DQogICAgPj4gRXh0ZXJuYWwgZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5p
bmcgbGlua3Mgb3IgYXR0YWNobWVudHMNCiAgICA+Pg0KICAgID4+DQogICAgPj4gT24gVHVlLCBN
YXkgMTAsIDIwMjIgYXQgMTI6MTM6MTlQTSArMDEwMCwgV2lsbCBEZWFjb24gd3JvdGU6DQogICAg
Pj4+IE9uIFR1ZSwgTWF5IDEwLCAyMDIyIGF0IDEyOjA3OjQyUE0gKzAxMDAsIFN1ZGVlcCBIb2xs
YSB3cm90ZToNCiAgICA+Pj4+IE9uIE1vbiwgTWF5IDA5LCAyMDIyIGF0IDExOjAyOjIzQU0gKzAx
MDAsIFN1enVraSBLIFBvdWxvc2Ugd3JvdGU6DQogICAgPj4+Pj4gQ2M6IE1pa2UgV2lsbGlhbXMs
IE1hdGhpZXUgUG9pcmllcg0KICAgID4+Pj4+IE9uIDA5LzA1LzIwMjIgMTA6MjgsIFdpbGwgRGVh
Y29uIHdyb3RlOg0KICAgID4+Pj4+PiBPbiBTdW4sIE1heSAwOCwgMjAyMiBhdCAwNzoyODowOFBN
IC0wNTAwLCBCZXNhciBXaWNha3Nvbm8gd3JvdGU6DQogICAgPj4+Pj4+PiAgICBhcmNoL2FybTY0
L2NvbmZpZ3MvZGVmY29uZmlnICAgICAgICAgICAgICAgICAgfCAgICAxICsNCiAgICA+Pj4+Pj4+
ICAgIGRyaXZlcnMvcGVyZi9LY29uZmlnICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgIDIg
Kw0KICAgID4+Pj4+Pj4gICAgZHJpdmVycy9wZXJmL01ha2VmaWxlICAgICAgICAgICAgICAgICAg
ICAgICAgIHwgICAgMSArDQogICAgPj4+Pj4+PiAgICBkcml2ZXJzL3BlcmYvY29yZXNpZ2h0X3Bt
dS9LY29uZmlnICAgICAgICAgICAgfCAgIDEwICsNCiAgICA+Pj4+Pj4+ICAgIGRyaXZlcnMvcGVy
Zi9jb3Jlc2lnaHRfcG11L01ha2VmaWxlICAgICAgICAgICB8ICAgIDcgKw0KICAgID4+Pj4+Pj4g
ICAgLi4uL3BlcmYvY29yZXNpZ2h0X3BtdS9hcm1fY29yZXNpZ2h0X3BtdS5jICAgIHwgMTMxNw0K
ICAgID4+ICsrKysrKysrKysrKysrKysrDQogICAgPj4+Pj4+PiAgICAuLi4vcGVyZi9jb3Jlc2ln
aHRfcG11L2FybV9jb3Jlc2lnaHRfcG11LmggICAgfCAgMTQ3ICsrDQogICAgPj4+Pj4+PiAgICAu
Li4vY29yZXNpZ2h0X3BtdS9hcm1fY29yZXNpZ2h0X3BtdV9udmlkaWEuYyAgfCAgMzAwICsrKysN
CiAgICA+Pj4+Pj4+ICAgIC4uLi9jb3Jlc2lnaHRfcG11L2FybV9jb3Jlc2lnaHRfcG11X252aWRp
YS5oICB8ICAgMTcgKw0KICAgID4+Pj4+Pj4gICAgOSBmaWxlcyBjaGFuZ2VkLCAxODAyIGluc2Vy
dGlvbnMoKykNCiAgICA+Pj4+Pj4NCiAgICA+Pj4+Pj4gSG93IGRvZXMgdGhpcyBpbnRlcmFjdCB3
aXRoIGFsbCB0aGUgc3R1ZmYgd2UgaGF2ZSB1bmRlcg0KICAgID4+Pj4+PiBkcml2ZXJzL2h3dHJh
Y2luZy9jb3Jlc2lnaHQvPw0KICAgID4+Pj4+DQogICAgPj4+Pj4gQWJzb2x1dGVseSB6ZXJvLCBl
eGNlcHQgZm9yIHRoZSBuYW1lLiBUaGUgc3RhbmRhcmQNCiAgICA+Pj4+PiBpcyBuYW1lZCAiQ29y
ZVNpZ2h0IFBNVSIgd2hpY2ggaXMgYSBiaXQgdW5mb3J0dW5hdGUsDQogICAgPj4+Pj4gZ2l2ZW4g
dGhlIG9ubHkgbGluaywgQUZBSVUsIHdpdGggdGhlICJDb3JlU2lnaHQiIGFyY2hpdGVjdHVyZQ0K
ICAgID4+Pj4+IGlzIHRoZSBMb2NrIEFjY2VzcyBSZWdpc3RlcihMQVIpLiBGb3IgcmVmZXJlbmNl
LCB0aGUNCiAgICA+Pj4+PiBkcml2ZXJzL2h3dHJhY2luZy9jb3Jlc2lnaHQvIGlzIHB1cmVseSAi
Q29yZVNpZ2h0IiBzZWxmLWhvc3RlZA0KICAgID4+Pj4+IHRyYWNpbmcgYW5kIHRoZSBQTVUgaXMg
Y2FsbGVkICJjc19ldG0iIChleHBhbmRzIHRvIGNvcmVzaWdodCBldG0pLg0KICAgID4+Pj4+IE90
aGVyd2lzZSB0aGUgc3RhbmRhcmQgZG9lc24ndCBoYXZlIGFueXRoaW5nIHRvIGRvIHdpdGggd2hh
dA0KICAgID4+Pj4+IGV4aXN0cyBhbHJlYWR5IGluIHRoZSBrZXJuZWwuDQogICAgPj4+DQogICAg
Pj4+IFRoYXQncy4uLiBhIHBvb3IgbmFtaW5nIGNob2ljZSEgQnV0IGdvb2QsIGlmIGl0J3MgZW50
aXJlbHkgc2VwYXJhdGUgdGhlbiBJDQogICAgPj4+IGRvbid0IGhhdmUgdG8gd29ycnkgYWJvdXQg
dGhhdC4gSnVzdCB3YW50ZWQgdG8gbWFrZSBzdXJlIHdlJ3JlIG5vdCBnb2luZw0KICAgID4+IHRv
DQogICAgPj4+IGdldCB0YW5nbGVkIHVwIGluIHRoaW5ncyBsaWtlIFJPTSB0YWJsZXMgYW5kIENv
cmVzaWdodCBwb3dlciBkb21haW5zIGZvcg0KICAgID4+PiB0aGVzZSB0aGluZ3MuDQogICAgPj4+
DQogICAgPj4NCiAgICA+PiBPSywgbm93IHRoYXQgdHJpZ2dlcmVkIGFub3RoZXIgcXVlc3Rpb24v
dGhvdWdodC4NCiAgICA+Pg0KICAgID4+IDEuIERvIHlvdSBuZWVkIHRvIGRvIGFjdGl2ZSBwb3dl
ciBtYW5hZ2VtZW50IGZvciB0aGVzZSBQTVVzID8gT3IgbGlrZQ0KICAgID4+ICAgICBDUFUgUE1V
cywgZG8geW91IHJlamVjdCBlbnRlcmluZyBsb3cgcG93ZXIgc3RhdGVzIGlmIHRoZXJlIGlzIGFj
dGl2ZQ0KICAgID4+ICAgICBzZXNzaW9uIGluIHByb2dyZXNzLiBJZiB0aGVyZSBpcyBhY3RpdmUg
c2Vzc2lvbiwgcnVudGltZSBQTSB3b24ndCBnZXQNCiAgICA+PiAgICAgdHJpZ2dlcmVkIGJ1dCBp
ZiB0aGVyZSBpcyBzeXN0ZW0gd2lkZSBzdXNwZW5kLCBob3cgaXMgdGhhdCBkZWFsdCB3aXRoID8N
CiAgICA+Pg0KICAgID4gDQogICAgPiBMb29raW5nIGF0IHRoZSBvdGhlciB1bmNvcmUvc3lzdGVt
IFBNVXMsIG5vbmUgb2YgdGhlIGRyaXZlcnMgc3VwcG9ydCBQTSBvcHMuDQogICAgPiBOVklESUEg
c3lzdGVtIFBNVSBhbHNvIGRvZXMgbm90IGdldCBwb3dlciBnYXRlZCBhbmQgc3lzdGVtIHN1c3Bl
bmQgaXMgbm90DQogICAgPiBzdXBwb3J0ZWQuIEJ1dCBqdXN0IGxpa2Ugb3RoZXIgdW5jb3JlIFBN
VSBkcml2ZXIsIHRoaXMgZHJpdmVyIHN1cHBvcnRzIENQVSBob3RwbHVnLg0KICAgID4gSWYgUE0g
aXMgbmVlZGVkLCB0aGUgcmVxdWlyZWQgaW5mbyBzaG91bGQgaGF2ZSBiZWVuIGV4cHJlc3NlZCBp
biBBQ1BJLg0KICAgID4gDQogICAgPj4gMi4gQXNzdW1pbmcgeW91IG5lZWQgc29tZSBzb3J0IG9m
IFBNLCBhbmQgc2luY2UgdGhpcyBpcyBzdGF0aWMgdGFibGUod2hpY2gNCiAgICA+PiAgICAgSSBy
ZWFsbHkgZG9uJ3QgbGlrZS9wcmVmZXIgYnV0IGl0IGlzIG91dCB0aGVyZSDwn5mBKSwgaG93IGRv
IHlvdSBwbGFuIHRvDQogICAgPj4gICAgIGdldCB0aGUgcG93ZXIgZG9tYWluIHJlbGF0ZWQgaW5m
b3JtYXRpb24uDQogICAgPj4NCiAgICA+IA0KICAgID4gSSBndWVzcyB0aGUgQVBNVCBzcGVjIGlu
IHNlY3Rpb24gMi4yIG1heSBjb3ZlciB0aGlzLiBJZiBhIFBNVSBpbXBsZW1lbnRhdGlvbiBoYXMN
CiAgICA+IHByb3BlcnRpZXMgYmV5b25kIHdoYXQgaXMgZGVmaW5lZCBpbiB0aGUgc3BlYywgdGhl
c2UgcHJvcGVydGllcyBjYW4gYmUgZGVzY3JpYmVkIGluIERTRFQuDQogICAgPiBUaGUgZHJpdmVy
IGRvZXNu4oCZdCB0YWtlIGNhcmUgb2YgdGhpcyBjdXJyZW50bHksIHNvIHRoaXMgaXMgYSByb29t
IGZvciBmdXR1cmUgaW1wcm92ZW1lbnQuDQoNCiAgICBZZXMsIEkgYXNzdW1lIGl0J3MgZXNzZW50
aWFsbHkgdGhlIHNhbWUgc3RvcnkgYXMgZm9yIE1QQU0gTVNDcyBpbiB0aGlzIA0KICAgIHJlc3Bl
Y3QuIFBsdXMgaXQgbWVhbnMgdGhhdCBNU0kgc3VwcG9ydCB3aWxsIGJlIHNpbWlsYXJseSBmdW4s
IHdoZXJlIA0KICAgIHdlJ2xsIG5lZWQgdG8gaGF2ZSBhIGNvcnJlc3BvbmRpbmcgRFNEVCBkZXZp
Y2UgdmlhIHdoaWNoIHdlIGNhbiByZXF1ZXN0IA0KICAgIHRoZSBpbnRlcnJ1cHQsIGJlY2F1c2Ug
dGhhdCBuZWVkcyB0byBmdXJ0aGVyIGNvcnJlbGF0ZSB0byBhbiBJT1JUIE5hbWVkIA0KICAgIENv
bXBvbmVudCBub2RlIGRlc2NyaWJpbmcgdGhlIElUUyBtYXBwaW5nLiBIb3BlZnVsbHkgd2UgY2Fu
IGFic3RyYWN0IA0KICAgIHNvbWUgb2YgdGhhdCBpbiB0aGUgQVBNVCBjb2RlIHJhdGhlciB0aGFu
IGV4cG9zZSBpdCBhbGwgdG8gdGhlIFBNVSANCiAgICBkcml2ZXIuLi4NCg0KW3RyXSBJbmRlZWQu
IFRoZSBQTSBwcm9wZXJ0aWVzIGFyZSBvcHRpb25hbCBhbmQgb25seSByZXF1aXJlZCBpZiB0aGUg
cGFyZW50IElQIGJsb2NrIGNhbm5vdCBhdXRvbm9tb3VzbHkgbWFuYWdlIHRoZSBQTVUgY29udGV4
dCBvbiBwb3dlciBzdGF0ZSB0cmFuc2l0aW9ucy4gQXMgc3VjaCwgUG93ZXIgbWFuYWdlbWVudCBp
cyBhIGR5bmFtaWMgcHJvcGVydHkuIFN0YXRpYyBwcm9wZXJ0aWVzIGFyZSBiZXN0IGRlc2NyaWJl
ZCBpbiBhIHN0YXRpYyB0YWJsZSwgYW5kIGR5bmFtaWMgcHJvcGVydGllcyBpbiBEU0RULiBNb3Jl
b3ZlciwgdGhlIHN0YXRpYyB0YWJsZSBpcyB1c2VmdWwgZm9yIG1pc2NlbGxhbmVvdXMgcHJvcGVy
dGllcyB0aGF0IGNhbm5vdCBiZSByZWFkaWx5IGRlc2NyaWJlZCBpbiBEU0RULCB1bmxlc3Mgd2Ug
cmVzb3J0IHRvIGtsdWRnZXMgbGlrZSBfRFNELiBUaGUgc3RhdGljIHRhYmxlIGlzIGEgc2ltcGxl
IGRhdGEgc3RydWN0dXJlIGluIG1lbW9yeSwgd2UgZG9u4oCZdCBuZWVkIGFuIGludGVycHJldGVy
IHRvIGFjY2VzcyBpdHMgY29udGVudHMuDQoNCldlIGRvIHNpbWlsYXJseSBmb3IgcHJvY2Vzc29y
cy4gVGhlIE1BRFQgZGVzY3JpYmVzIHN0YXRpYyBwcm9wZXJ0aWVzLiBQb3dlciBtYW5hZ2VtZW50
IGlzIGRlc2NyaWJlZCBpbiBEU0RUIChfTFBJKS4NCg0KQ29taW5nIHRvIE1TSXMsIHRoZSBuYW1l
ZCBjb21wb25lbnQgdG8gZGVzY3JpYmUgdGhlIE1TSSBpcyBpbiB0aGUgSU9SVCwgYSBfc3RhdGlj
IHRhYmxlXyB3aGljaCBpbiB0dXJuIHBvaW50cyB0byBhIGRldmljZSBpbiBEU0RULg0KDQpSZWdh
cmRzLA0KVGhhbnUNCg0KICAgIFJvYmluLg0KDQo=
