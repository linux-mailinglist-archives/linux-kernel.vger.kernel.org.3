Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDD04F4117
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 23:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350501AbiDEUPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 16:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457229AbiDEQC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:02:58 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2066.outbound.protection.outlook.com [40.107.212.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B84DA65BE
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 08:34:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I1X2DRQNLFAwp06e8GqAa5/bCfQNXytJ8YIuWk1NXSzOkGS4aXkUfOw/gu25IItN0mS838mXZRhmDljt3Hi435HdBfU84aXmwd98kGpeygdwsQ766ysD4w3UKF0XwwjWFCr1rBwRjVi2uNKQLqsEZEb6j8iGZ2Dhevtq8F8vgxfIxIK18jqfDGV1uGUlKRq/xFy0to4R7IPv7GL9klwXvvTfC148+PHvL8q9FhDXvFvh56WNH4G7dJdG/MgAKEKDizb8KnTGcnnvf+11qb3Dmh/vlleMAm38lsHumqwbzsCrf97zrc/ZILZlqIuTGl3ui0Y/NA0an/KBkxt0EesVBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sz202/I4YtLsA/d25bMBcuv3Cfdj4ekNOlXUsK8PAwI=;
 b=jR4awIGVP9yS6euiczU8rkmOMYpUUZaqFRTY6H0cGX6m61wi1hEqtW4jmNchD2vJ3W+JlBSiGK0c9HuFTbnmo4jzoZ5e7bhpsr1i3LS9jogCzb3FWh8QbAi9O/5tj3N2M7MM/erzI4HW6l7EjA9lJK2by5p4LG2lfndhL7d4hQIiBbPs1GInvQ9a3QlHo8ozxdMVZ3OYBmNYqEeUMP1vVxKf1U0xt5XamG66FHCLM4mPUA7LUigvM8A6aGbC1yvbYT/pxgbqf1RGv4vjSUXUFtlFkbZZF5RaqCrpHz0KvnYrIVTkobrb+8tdkjQGnuIgns9bRyNzt3ZysmBlJ3hRbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sz202/I4YtLsA/d25bMBcuv3Cfdj4ekNOlXUsK8PAwI=;
 b=UG6QTmpkE1tN4pO6a0vGn+jv2jNeVFf/yFExnx+R5YV2mkEjYXz8w/MQdY1Y5/5C3+9Eb2RBmCONjJHofbbzHrY7uVoyl5IM8D00oVj9bXalFocZ7xjrohvT7RISLXOVwSAd/iKQrHYVhkOhth9aS9626SKYDWjAKo4GYTbwlKE=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by BL0PR12MB2580.namprd12.prod.outlook.com (2603:10b6:207:3e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Tue, 5 Apr
 2022 15:34:23 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::70d6:f6dd:3e14:3c2d]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::70d6:f6dd:3e14:3c2d%5]) with mapi id 15.20.5123.031; Tue, 5 Apr 2022
 15:34:23 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Karny, Wyes" <Wyes.Karny@amd.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Carroll, Lewis" <Lewis.Carroll@amd.com>,
        "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
        "Narayan, Ananth" <Ananth.Narayan@amd.com>,
        "Rao, Bharata Bhasker" <bharata@amd.com>,
        "len.brown@intel.com" <len.brown@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "chang.seok.bae@intel.com" <chang.seok.bae@intel.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "metze@samba.org" <metze@samba.org>,
        "zhengqi.arch@bytedance.com" <zhengqi.arch@bytedance.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
Subject: RE: [PATCH] x86: Prefer MWAIT over HALT on AMD processors
Thread-Topic: [PATCH] x86: Prefer MWAIT over HALT on AMD processors
Thread-Index: AQHYSO0si5fvSUiei0GnFDYbI7mXuKzhWxKAgAARiYCAAAWWwA==
Date:   Tue, 5 Apr 2022 15:34:23 +0000
Message-ID: <BL1PR12MB515745615F4C92627033CD5BE2E49@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <20220405130021.557880-1-wyes.karny@amd.com>
 <YkxNFyXqC12nXyfM@hirez.programming.kicks-ass.net>
 <7cdc2103-c6d4-e1b6-9804-6739112eee4d@intel.com>
In-Reply-To: <7cdc2103-c6d4-e1b6-9804-6739112eee4d@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-04-05T15:30:08Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=f9680184-2489-4864-9275-30f5cd696cae;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-04-05T15:34:22Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 43b51e09-3227-43ca-add0-37d253aa9f0c
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3b1e9afb-e364-46b7-06cb-08da1719c2d2
x-ms-traffictypediagnostic: BL0PR12MB2580:EE_
x-microsoft-antispam-prvs: <BL0PR12MB258027366C7E5677D69424DEE2E49@BL0PR12MB2580.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dyAv1mNX4Bi483YvJzAXP3t5K8NqDvyEqe5TRTdoZ291oD3T9ZhNEVltnAXQ2rY5AdL7VNrDMK4aTppR7Vm8+4LV4+ynjw7uwAE9iWas8Km1Df4EAxgfYoPl5+2VuXTz76tgF51e7MNzEp4d9zuY6JwImeAPwQ7V86dIt2MVX7wP34S/nYgNwVeiE9E4Q5J8TXAFgK2DBo6UdYOHKPxPn/dRXKTkjb6s6Ajo4jW0XD9u01k+Y40uHnmNkeorqed17B+p6n4Z1b+RHAuLvFx9GZlGZFHumvbRRJXsK6biO/ATNFUCagg1Ja0cpwDOpVFeF6eBM+5KF7JCmVwz2p7UstM0hyxBPLt6HJ8DAfklJkwerW1e2GAFLqHGg9rO0BUZyjPYbkEoGeNsMlDUCvg8G+kfGey22fT6Z+CGBwvL2Ij38P0NoheTTrXfcSBtE/TF47WQhMEn/oIUxfFGcTfeKmMG9MSQf5+wOpWPCiTe0Aqs7cRQ8yZYoMkvy6M2LYebuCMvfdTxmSwaSu9IqHaq5v+TJHbiYmXqa+ppkXqXG1xhIbXrS0S/AmtqxqousyNBMIDdxtb7C24Kt86hSWxW06KyCw3iYKcXnimWFjIskk01z+9253omc7GMc1hFSRSVgXE4AjRvdT8Y8bVxuFdYuOAE9hgpBuiiUEY5oerMYomUKsVp+MpCNgVQoKjKt7za/SgrIHbjKwSmDGMgL9gK0A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(8936002)(71200400001)(5660300002)(7416002)(9686003)(66446008)(66556008)(64756008)(76116006)(66946007)(66476007)(55016003)(33656002)(508600001)(7696005)(53546011)(6506007)(52536014)(122000001)(6636002)(2906002)(38070700005)(83380400001)(316002)(8676002)(54906003)(110136005)(186003)(38100700002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ejVXSXhROGtGbzcvciswRXRRc2RETW9xMlFvZE5WZDJ1eFRzNFhOOXRPZXF5?=
 =?utf-8?B?alVEUjQrYjA3c0dRemhtOWNZWGwzZ2JUdkxNc2tkU3hvZ1hRQm5HRExubVR0?=
 =?utf-8?B?VkJ4VGg3ZS82dUpEMmliUEkyN09wSGZ1OStvaVhucEtwTGpkRWlmWDRweFl0?=
 =?utf-8?B?SElybG5HZFFNLzVtd3lNN1hVVlYvNkVudExPbDhsNWZCcEpoNFRJVzR5Zytl?=
 =?utf-8?B?cUs5SjNaK1JvTGM1bFVRbDNrSWRUYXg5WG03YnNEUjBDd2dSSEZBYXhUQXlX?=
 =?utf-8?B?Q0RldXpXSmNmM09CMHpQa1pGSktudEhIUkNPTkV1SXNxZVBmNWdMU21EMzhm?=
 =?utf-8?B?RFEzb2Eyc2FPWlkwSkkwWnRHS3JBTUFKd0NRQ21iWXlMdGdROWNFMkpQanJm?=
 =?utf-8?B?VGNKb2JZSW9wbDh2N0wrN0dBNUpnUytLOFg5ajREWE1uNEg5ZkFQdDUwdTA0?=
 =?utf-8?B?RVFIWWpJZDhGL21SdWV4NFBDQ2VJUkE0VTFGQXdnZXNpc2t5bU50UnJVMnIx?=
 =?utf-8?B?c2FleE1VRVl3MVNXY01uNDB2aVhpbGd5V1p2SmNveGpjQUgwUUFFT0R5OW1K?=
 =?utf-8?B?YnIyMkQxanZqVy9TcUtjeTQweTNMMHNsd1ZCbGd2MWVyQzJETUhlMWlpcmxW?=
 =?utf-8?B?Q3dnQWdqZU1TcVhmakJKcElXaU51NWxIbmpSQlg0ME1NdXp2Z0JPZHJQRlBL?=
 =?utf-8?B?YVBpNjJzY2tJUExZVFZDcnU5Mk9iVFZTZWhPU0o1b2NSVzVPUkZHZGRkNy9Q?=
 =?utf-8?B?RUFTYUhUZTBwS3VpWmMxcWRab2t3WTRZOGFNZStyY2cxdjJKUmwzTGtHWDly?=
 =?utf-8?B?ME5iRWllNDZXb3RCL29kRWYxYWVmYUQ0UmU1WlFFMzNwZWtYVnVGNmtYVkxX?=
 =?utf-8?B?ZHVMaVhZbmpwTVJvWUFOU1MyVlFCRGhGT3FrcTRSNnFpZXFYYXFyNzVUVzRq?=
 =?utf-8?B?MGtucFMzVm55VXJCaGZTWTl3ZC92WExLaWZDODRuSmpKYnluMDZTbkpDS1Bi?=
 =?utf-8?B?TEhxc3JFeUNhcVJORGVwZTY5K3M0dlg0ekQ2ZUdpSmF0T1F3Wk95SGNGQXdL?=
 =?utf-8?B?bnVBZUpFMmxSaTc2dnB3V2V2Q3llOUF5ZTFhdTNqZWhuSFg0eUtmMisxWnhi?=
 =?utf-8?B?MWZQT3dnTEVnU1pyV2p0bXU4SHRYeFM4WExTY3FzM29BbjZ3ZDZBY2tpbENj?=
 =?utf-8?B?NjR5VGt1SjArWHpkVmc2MkdDNmpUelY0Vm5WQW9XWHh5QmNwUHgxeTd3UXVa?=
 =?utf-8?B?cEIzdzVNQ2JWcWNIRzVJZWhtanp6WWVMYXRvanZGc0VyRGl1Q1E3VXN4bHB3?=
 =?utf-8?B?SDNEZ3pHZFFsMzczWkJEclgyQkJxSkNicExYUzBrb2NnNVR5d0UrbEwyTG4v?=
 =?utf-8?B?KytsSGFLVWwrUHNBSHlwUEYyNDhoT1FjV2xYM0VqdTVZYlN3cllPb3Rubklq?=
 =?utf-8?B?WWU5NnNIbEZBcEcvcmczMUFmNjdOMmxlTWpMVWF3aVRTbkNwSit1WUx2VVNM?=
 =?utf-8?B?R2FsUlI0Rmd1cG8reG53UVJjUnNVUkNUazBIQkticW11Ui9SMzA5QjJMbGpi?=
 =?utf-8?B?ZFFTdkdHMEY0aFdyS056SHNVT1h3c2FmYm9kZjRGaUE1ZTZERkJFdE94OC9v?=
 =?utf-8?B?aW5JM2hFT3lmNkh1RDExOWZJcEY0VkQ5KzVNRTNPWDNxV0ZRblRlOS9FYnd4?=
 =?utf-8?B?NEFmL1EzS09hcmhTRGdndGdHNDFXN3FKWU9xRmFxRkJjQ1pqS3NwcDhhNnV4?=
 =?utf-8?B?Y0luS0s3UjhGazV1QzlHNFVPYkRnRTJBenhhTnBobGcvdm1qNHRDNU9xT2hB?=
 =?utf-8?B?bThoRndWQXVRWGd2RWszOFFiY3JNblJxKzZQRDA5K1pFUnNCajdHSWhNTk1B?=
 =?utf-8?B?dXg3NzFNQzcvek1FeXEzK3p4ZnpqS2RkNFpYZ0xUSElpZW03UTdvVDR1SUI3?=
 =?utf-8?B?Q3RmK1dnelNkTWRNUEM1d3A4SkhHK0E3cVp4Rk5pMjVnSE5pdjRHM3VrMUVQ?=
 =?utf-8?B?NDVLcmRiSEhGb1JqQXhLSjdIb0JtNTdnRUsrcUNYS2ZVaTRzclF3M0dhazNz?=
 =?utf-8?B?M1I0WVV3dzhoK0xSamVGSlNsOUtSOXV5a0pveUIzbGxXbWdVZVp4M01DK2pN?=
 =?utf-8?B?ejAxam1Nb1ZsTFBseXZZek1vS0FZbW9lZzd6NFdVWVh2QlNsMGE5ZmRoQ05q?=
 =?utf-8?B?RG1xelREb3Z3cHFDQ3ExU3ZjbTZmakI4VnR5MDNmdzNiOHdtcVZHU2kxWmdF?=
 =?utf-8?B?UTgxbHYyZDBWd2VEdUFHSVlYM3R3WE9IQzdqR3FrTmdJTHY4eStPMjBzaFhY?=
 =?utf-8?B?aTVWeTh2dWhEU2J3TCtTT3h6YTc3Nm5HczEyV1d5cTE1d1hqRnlhV041V3Vw?=
 =?utf-8?Q?abTvuQ69PhDWpw1Abyj1NFcir/sDB/comeMCtBvLO6Lws?=
x-ms-exchange-antispam-messagedata-1: LXNHuNSJaFKeIA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b1e9afb-e364-46b7-06cb-08da1719c2d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2022 15:34:23.6043
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2tLEadiSeT/3rhPT5iTBKuUba2XyIu1zbe+dmBeuauFJyDw61zT22bmfMBS1IddcloMdCrueCi0OncJWYOWy4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2580
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W1B1YmxpY10NCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGF2
ZSBIYW5zZW4gPGRhdmUuaGFuc2VuQGludGVsLmNvbT4NCj4gU2VudDogVHVlc2RheSwgQXByaWwg
NSwgMjAyMiAxMDoxMA0KPiBUbzogUGV0ZXIgWmlqbHN0cmEgPHBldGVyekBpbmZyYWRlYWQub3Jn
PjsgS2FybnksIFd5ZXMNCj4gPFd5ZXMuS2FybnlAYW1kLmNvbT4NCj4gQ2M6IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc7IENhcnJvbGwsIExld2lzIDxMZXdpcy5DYXJyb2xsQGFtZC5jb20+
Ow0KPiBMaW1vbmNpZWxsbywgTWFyaW8gPE1hcmlvLkxpbW9uY2llbGxvQGFtZC5jb20+OyBTaGVu
b3ksIEdhdXRoYW0gUmFuamFsDQo+IDxnYXV0aGFtLnNoZW5veUBhbWQuY29tPjsgTmFyYXlhbiwg
QW5hbnRoDQo+IDxBbmFudGguTmFyYXlhbkBhbWQuY29tPjsgUmFvLCBCaGFyYXRhIEJoYXNrZXIg
PGJoYXJhdGFAYW1kLmNvbT47DQo+IGxlbi5icm93bkBpbnRlbC5jb207IHg4NkBrZXJuZWwub3Jn
OyB0Z2x4QGxpbnV0cm9uaXguZGU7DQo+IG1pbmdvQHJlZGhhdC5jb207IGJwQGFsaWVuOC5kZTsg
ZGF2ZS5oYW5zZW5AbGludXguaW50ZWwuY29tOw0KPiBocGFAenl0b3IuY29tOyBjaGFuZy5zZW9r
LmJhZUBpbnRlbC5jb207IGtlZXNjb29rQGNocm9taXVtLm9yZzsNCj4gbWV0emVAc2FtYmEub3Jn
OyB6aGVuZ3FpLmFyY2hAYnl0ZWRhbmNlLmNvbTsgbWFyay5ydXRsYW5kQGFybS5jb20NCj4gU3Vi
amVjdDogUmU6IFtQQVRDSF0geDg2OiBQcmVmZXIgTVdBSVQgb3ZlciBIQUxUIG9uIEFNRCBwcm9j
ZXNzb3JzDQo+IA0KPiBPbiA0LzUvMjIgMDc6MDcsIFBldGVyIFppamxzdHJhIHdyb3RlOg0KPiA+
IE9uIFR1ZSwgQXByIDA1LCAyMDIyIGF0IDA2OjMwOjIxUE0gKzA1MzAsIFd5ZXMgS2Fybnkgd3Jv
dGU6DQo+ID4+ICtzdGF0aWMgaW5saW5lIGJvb2wgZWFybHlfbXdhaXRfc3VwcG9ydGVkKGNvbnN0
IHN0cnVjdCBjcHVpbmZvX3g4NiAqYykNCj4gPj4gK3sNCj4gPj4gKwlpZiAoYy0+eDg2X3ZlbmRv
ciA9PSBYODZfVkVORE9SX0lOVEVMKQ0KPiA+PiArCQlyZXR1cm4gdHJ1ZTsNCj4gPj4gKw0KPiA+
PiArCWlmIChjLT54ODZfdmVuZG9yID09IFg4Nl9WRU5ET1JfQU1EICYmIGNwdV9oYXMoYywNCj4g
WDg2X0ZFQVRVUkVfWkVOKSkNCj4gPiBXaGF0IGFib3V0IEh5Z29uPyBGb3Igc29tZSByZWFzb24g
eW91IGd1eXMgZG9uJ3QgY28tb3JkaW5hdGUgYW5kIHdlDQo+IGVuZA0KPiA+IHVwIGdldHRpbmcg
ZW5kbGVzcyAnbWFrZS1zYW1lJyBwYXRjaGVzLCBzb21ldGltZXMgc2VwYXJhdGVkIGJ5IHllYXJz
IDovDQo+IA0KPiBCZWxpZXZlIGl0IG9yIG5vdCBIeWdvbiBzZWVtcyB0byB3b3JrIE9LIHdpdGgg
dGhpcyBiZWNhdXNlOg0KPiANCj4gPiBzdGF0aWMgdm9pZCBpbml0X2h5Z29uKHN0cnVjdCBjcHVp
bmZvX3g4NiAqYykNCj4gPiB7DQo+IC4uLg0KPiA+ICAgICAgICAgc2V0X2NwdV9jYXAoYywgWDg2
X0ZFQVRVUkVfWkVOKTsNCj4gDQo+IEkgZG8gd29ycnkgYSBiaXQgdGhvdWdoIHRoYXQgdXNpbmcg
WDg2X0ZFQVRVUkVfWkVOIGlzIGdvaW5nIHRvIGJpdGUgdXMNCj4gbG9uZy10ZXJtLiAgSXQgY3Vy
cmVudGx5IGNsYWltcyB0byBiZSBzZXQgZm9yICJmYW1pbHkgMHgxNyBvciBhYm92ZSI6DQo+IA0K
PiA+ICNkZWZpbmUgWDg2X0ZFQVRVUkVfWkVOICAgICAgICAgICAgICAgICAoIDcqMzIrMjgpIC8q
ICIiIENQVSBpcyBBTUQgZmFtaWx5DQo+IDB4MTcgb3IgYWJvdmUgKFplbikgKi8NCj4gDQo+IEJ1
dCB0aGVuIGl0IGdvZXMgYW5kIGdldHMgdXNlZCBpbiBzaWRlLWNoYW5uZWwgZGVmZW5zZToNCj4g
DQo+ID4gICAgICAgICBpZiAoIXN0YXRpY19jcHVfaGFzKFg4Nl9GRUFUVVJFX1pFTikpIHsNCj4g
PiAgICAgICAgICAgICAgICAgbXNyIHw9IHNzYmRfdGlmX3RvX2FtZF9sc19jZmcodGlmbik7DQo+
ID4gICAgICAgICAgICAgICAgIHdybXNybChNU1JfQU1ENjRfTFNfQ0ZHLCBtc3IpOw0KPiA+ICAg
ICAgICAgICAgICAgICByZXR1cm47DQo+ID4gICAgICAgICB9DQo+IA0KPiBUaGlzIHNlZW0gX2Jp
dF8gYXQgb2RkcyB3aXRoIHRoZSBjb21taXQgbWVzc2FnZSAoYW5kIHRoZSBBTUQgU1NCRA0KPiB3
aGl0ZXBhcGVyKToNCj4gDQo+ID4gICAgIEFkZCB0aGUgbmVjZXNzYXJ5IHN5bmNocm9uaXphdGlv
biBsb2dpYyBmb3IgQU1EIGZhbWlseSAxN0guDQo+IA0KPiBTbywgaXMgWDg2X0ZFQVRVUkVfWkVO
IGZvciBmYW1pbHk9PTB4MTcsIG9yIGZhbWlseT49MHgxNz8NCg0KVGhlcmUgYXJlIFplbiBmYW1p
bHkgQ1BVcyBhbmQgQVBVcyBmcm9tIGZhbWlseSAweDE5LiAgUGVyaGFwcyBhdCB0aGUNCnRpbWUg
b2YgdGhlIHdoaXRlcGFwZXIgdGhlcmUgd2VyZW4ndCB5ZXQgdGhvdWdoLg0K
