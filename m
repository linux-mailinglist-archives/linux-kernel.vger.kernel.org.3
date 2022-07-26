Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1897C581422
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 15:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238722AbiGZN1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 09:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232851AbiGZN1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 09:27:50 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F323A6;
        Tue, 26 Jul 2022 06:27:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YQSFhzAvLBVv7eY4v10hbtdCjukcGCeRmxu5n7y9UvIpXv6wpExsZMBwCiDDgcQaLORUWZ3L6GnQ5SMyWlNbMzxxOl37tG8zDXxj8APksXTr6w3K5oH2EjPOu3RWtHEmDVXxokzv3wxZcSsahL1QAhjPebbdfh+0Jsfmv8UYIAWL9QQrtz3f4oSltXge6oI/uU1nPInHYNHWfKKlJNI2EtNsyptmismsCRMF/ort4szfzAi2cmUZI85RYNnwxyogjEYlnS3jxTJBfHA75JqTdZSzk5LaVAgo3TPxX7E3pYLGeM+Zj2rFRm2uoPPxxmAU0LZg4N7P/AxvEPTd/wYeUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s3AqI4YTDmJ0qkbGcngCn5xI8o3RjYMaynxdL65rpXw=;
 b=W2rOexNpLcurrapkyah5rytHTuLQI1OOvuF1QKC27yEmq0wXYKbBFc546cEB2zClyg7HobtTlDCvL6xMWppGCfKGLN+OP89nARRKB0QVgMHeOvl57E4DocEWSVGxsif5E69WwGzizv6Y2X7Ha0nTbn3u6Vm9C7E8IWqUN3IWhQlwnafYXOYZmFqzq6jlTljWNToWoNFnT1k4BsxyJbMJFKV+t6qshzH31VoT8HLsb1SRmw6UYZOgrn5h4MAwj3tw9oaayjafKFQUIMfPPGhP0Oi/Nb4ubd4KixY5EcEo5PCaDR7rMskw+9sbg3/cvZUobAfJzq0cRO0hIdXXaCbbNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s3AqI4YTDmJ0qkbGcngCn5xI8o3RjYMaynxdL65rpXw=;
 b=WuVM+uKbB84rndFI/kfEU/XUCIngzWpU653ScLjHxJbg1Yn7+5i/oPFyig4t9iy49fE4wHg5+iHzCADPZhaQDLbU80llQaHC087UcLZG/NMpQKizz6m9FP+nNTN5yAuP4drfkS3I9DFz4+sccLaaiFYTR02jYxBni0n4SWLkdcU=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BL0PR12MB4900.namprd12.prod.outlook.com (2603:10b6:208:1c1::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Tue, 26 Jul
 2022 13:27:47 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::1143:10a5:987a:7598]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::1143:10a5:987a:7598%6]) with mapi id 15.20.5438.023; Tue, 26 Jul 2022
 13:27:47 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     "Natikar, Basavaraj" <Basavaraj.Natikar@amd.com>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] pinctrl: amd: Use unicode for debugfs output
Thread-Topic: [PATCH 2/2] pinctrl: amd: Use unicode for debugfs output
Thread-Index: AQHYnheNnLM2p0Ne0UyBNhyW3WiS3K2QT+IAgABaKBA=
Date:   Tue, 26 Jul 2022 13:27:47 +0000
Message-ID: <MN0PR12MB6101B99C602809ACD6AB8839E2949@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20220722220810.28894-1-mario.limonciello@amd.com>
 <20220722220810.28894-2-mario.limonciello@amd.com>
 <CACRpkdZ+2XCSJo336+=k_fxmPxu=M3KZJofKfY5JqPXGoKmnYw@mail.gmail.com>
In-Reply-To: <CACRpkdZ+2XCSJo336+=k_fxmPxu=M3KZJofKfY5JqPXGoKmnYw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-07-26T13:25:05Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=3eb7fcfa-21ea-4348-876c-c79d69ce00d5;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-07-26T13:27:50Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 9601a779-fd1b-4bfc-870c-70f9b00836be
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 390d59c5-d905-43d8-83a1-08da6f0aa148
x-ms-traffictypediagnostic: BL0PR12MB4900:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iqGkYxm9e4SlF1ask8uual817Owy+iowCaMRFRvOl+wzCaMlVVAkno/emwbWhSNWc20aykWwwrNiV35TEeB+vJPXAEKtcTeT8tUY33wyicPtpNswfYLef0/nCD4Xa+m5BJOatOQUcHnSKQbXh9c+fKgvoG9WGrzbWKiQdPLoXJc3kzvsDVKFuMWcte481/aVRCMwU2bPgpfUXM6jQvn1PiumdCEoFRW5KUyltDgrr4aIY6yEkTfem1YRWO428seDy9Tx2tqSrUkR2mT8kEX49CEbHq+JLIS0ysRzeEYHgOsuDGK5crsFJ6mIoUXJaLPJiAsDlAa9oWyl3DzvNdhSWQY1CHW2nXvvgECZMraNL1Mpb1pktcoS7ZrSCBcTcieAJW00Mo2RjSDIkGLJrgBMX809qRngrH0pff6iOz2g47jQPO6uF71ue+t9XGQ30Yu/ww6V5Wgt5krlTRsAV6GxEO9tLCnJf9OONnrC5/4BDvTMLwZ6GiqQG7Jk+526ADbdL/cjhUy+hnqRl1r0C4EhE2nq9caVUoBNLNQ1Tj7czelQRfK+LTsfi/iNQofy4BiQ6mK2Qcb3mhhMkR/tTeGJ1Ln75vePnYVLh4qgcwsYXuVwpJvqAGsK/Fzh/ZLAO/2UST4TKCuwdpl5COnn8iePVpElFXBLhdpetN8AMTzSBjF6eaVEzFn1btoE5/y6i8Bl/Tbn6+655Y6LJMuCrqmVJM3bflY6PKqaRy4nsGLH6EJO87VWfSUfdUk71qyOyNyctmEpyF4xY7ZzKsNcx20Nk4Z9mOgSLYQ9O+5CjnpxOK5bbdcDD/XQtiTncFgMBdT1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(396003)(366004)(346002)(39860400002)(122000001)(33656002)(38100700002)(86362001)(52536014)(478600001)(8936002)(5660300002)(38070700005)(9686003)(316002)(66946007)(64756008)(66476007)(4326008)(76116006)(6916009)(8676002)(71200400001)(66556008)(66446008)(186003)(54906003)(83380400001)(55016003)(41300700001)(2906002)(26005)(7696005)(6506007)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z0Noek9XWGZjc3JrWmR5TGF6bkJ6cTlwbGVyRStNSjFYSFhrak90NGttN2Np?=
 =?utf-8?B?clhKLzFrV1FNQ2xGUXdPYkJ4d3ZrSXRuTU83Z3FsZEZ6WlVxSEdqLzRuTGUz?=
 =?utf-8?B?WUU2T0Ezb0dVSGsveWlFSnc2aS8ybmdTaGUrUE0yOFcyd2Y2MFUzVTArZGFL?=
 =?utf-8?B?MzlLdG5SdzQxcmVINDRqTGtkTUdaLzhvM3FQc1hBU1p2QTk4K3dzNkZtdjhl?=
 =?utf-8?B?ejJQa2prR2xVZDgvQ3lPTGxIYVZOR1NaL0F2WndSMXpvelRIQVpBb0FmNjJE?=
 =?utf-8?B?REhrSU0vZkd6cnNZYkNqaFBCaEZ2aXlmemU3QzZ5eWJ3MldERWR4UExtMCtL?=
 =?utf-8?B?TStiYmtCZ1ZNUncrQlZNU0hjbHhRUXc5dGdDeFV5WTQ1SWhTSTkrcnoybjRa?=
 =?utf-8?B?MGFtS3dkVEROcit6QVJ2TnZ0b1BaOE1jRFA0RWd6UFZZcVFKTG5QOG1hK3FJ?=
 =?utf-8?B?Q2IvUW5mdXlhZmxudUo2SWVlRzJ3MnZBVkZHV29vclRrVnNmTFVBNDllZnhD?=
 =?utf-8?B?R2xndTh4bXcwUGVnUE9icUVRTDZyT2hyd2tHMXRzOFJaS0hHWEVWeHFoVUM5?=
 =?utf-8?B?WUU3Nms1V08vZUF0UXVtOEhINnJnb25rL2xHekM0d0xkSDd0YWVmYWhrS0pl?=
 =?utf-8?B?NGxWY05qYnhOVjdrNlU1Ukw0cE1DMVpTT0h1WjNjQ1VLNjFzMzBQR0ZWVlNk?=
 =?utf-8?B?MUVlK2hhaEhxZllhRFVVeDBGNmRHUHRmRXIrb1RMSis5dE4zeExiM0VWNFdo?=
 =?utf-8?B?YUY2VVpXbU5HOFVFS1dCT2FLSnVrYlVBaVZJM1dDaHQ1THJPYTNOUGlCNUZE?=
 =?utf-8?B?WjRkeUJGSEtJWmtuSTd1OTZwODlqUjlIV2tPajRFOW1HWTVmWjkzdWZ5RTRH?=
 =?utf-8?B?OE5aNDM3SlgzSmp2cjVrRFQzS0I2eXpaUlpsR254OG1vRkJMblJmQ3QrVUxo?=
 =?utf-8?B?d0psMFpvZEJyUkhvbS92VnlmSnhWc3dWYmZkMS9EUjlQZDZjdjd1Mnlsd28x?=
 =?utf-8?B?L2ROT1ROWldqbkpUWDV6YllBOEpyTTZ6bi9PNW5MSUxIZEhEcE1aTmt5SU5h?=
 =?utf-8?B?SUhmS3FKT0J0WkZTSE8zK3JnSHJ1RG91aXRXTWRmNTgzQ2t1Qi9aUjkzbXpH?=
 =?utf-8?B?Ly9UV0x3eFprNUlkNElqeE9kWkMyUG1nM0FJRDd4TzdjTmRQVHNSY3ZnWDhw?=
 =?utf-8?B?bVlDM2h4V2xOVGZwdkxpbzZITGJrQ0RxRUNTZy81ZDZxSitueW9tRkkwVmVh?=
 =?utf-8?B?dUtISTZXWHNML2dXVGpKbEQwTXR3bmQ5VmFPZVNDS3lyY252SVdFdGJMWHpp?=
 =?utf-8?B?ZjFLK3JhbmxIcy9yVURtbzh6YnNYWGpiUnd6ZnZJZFN4ME44TDEvcWUxNTRU?=
 =?utf-8?B?dGdVbmIrVnk1bDlzSUdUakZzRm5MRDR1cEVtWW02ckZNYStmSWRZQVpaOHNK?=
 =?utf-8?B?OHVOVEcwSEpBMmg0UVFqTnZ0cTdLaGlGRG8zYkt1MGFhd2p6S0lEd3FJckF5?=
 =?utf-8?B?UjM2N2VubEtacWtuckdibU9SOVJyaDEvNUJURWR6OW9BWHFlK1lJSThudWha?=
 =?utf-8?B?Rk1ac3R0Rm9uRko3SCtENW5ZeDNCNEUyZHRiSzVFYWxrTlpuVWd2UW5GOHNm?=
 =?utf-8?B?bEszMU5YT1RqNndjMHNtbkQ2UU85dXJTT2VadVA4NU1KUGZxRGpnTFlaOU9H?=
 =?utf-8?B?WUdXWHBJcXR6QWpyUVhSUnd3cUljVXF5VDJGb0NaLzV2QTBDTUtzNVhOM1lm?=
 =?utf-8?B?TXBOMXVIaktJUHMwNUE3cHhpUGZpUGV4Mk1MbEVaRXNHQWxPVkp0WUpNaGU0?=
 =?utf-8?B?TFArNnU4Q1hUNGppaHk3eURWZnhjYjFtbi9LRVdwaFhoNWZlcUdOdVVwbUlH?=
 =?utf-8?B?ZTlDRzNoL3k1WEdjNGxTWGxXM01Ub0M4TFVvOVNWQTBSaEl3cVJMcXVQTlN1?=
 =?utf-8?B?b2k4SXJmUjJjNWxaQjFpbU9uZUE4VzBkME9RTDVKRUNLeHd0WDF5VHAzaWRU?=
 =?utf-8?B?MFB1NzRiYWJwdkw4VC85N2ZXT21PWmFRMmVkaitETjIzZlVmNEVMQ2NBV0xs?=
 =?utf-8?B?M3RzT1Nzd3k1Z3RITk1QcE43Q1lJdC9PMlp6L2R4VUV5cmZrMjJMem42bHpn?=
 =?utf-8?Q?XFH0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 390d59c5-d905-43d8-83a1-08da6f0aa148
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2022 13:27:47.2118
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U4ye0hWwl26FjOGfJPuRSCZGjP3zC704Cpdnt1NEjULUZjdzm8IKHm7akOlkSOxHr/F3UI+c2szuF7JPIv05/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4900
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMaW51cyBX
YWxsZWlqIDxsaW51cy53YWxsZWlqQGxpbmFyby5vcmc+DQo+IFNlbnQ6IFR1ZXNkYXksIEp1bHkg
MjYsIDIwMjIgMDM6MDINCj4gVG86IExpbW9uY2llbGxvLCBNYXJpbyA8TWFyaW8uTGltb25jaWVs
bG9AYW1kLmNvbT4NCj4gQ2M6IE5hdGlrYXIsIEJhc2F2YXJhaiA8QmFzYXZhcmFqLk5hdGlrYXJA
YW1kLmNvbT47IFMtaywgU2h5YW0tc3VuZGFyDQo+IDxTaHlhbS1zdW5kYXIuUy1rQGFtZC5jb20+
OyBsaW51eC1ncGlvQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAyLzJdIHBpbmN0cmw6IGFtZDogVXNlIHVuaWNv
ZGUgZm9yIGRlYnVnZnMgb3V0cHV0DQo+IA0KPiBPbiBTYXQsIEp1bCAyMywgMjAyMiBhdCAxMjow
OCBBTSBNYXJpbyBMaW1vbmNpZWxsbw0KPiA8bWFyaW8ubGltb25jaWVsbG9AYW1kLmNvbT4gd3Jv
dGU6DQo+IA0KPiA+IFRoZSBvdXRwdXQgaXMgY3VycmVudGx5IHNwbGl0IGFjcm9zcyB0d28gbGlu
ZXMgbWFraW5nIGl0IG1vcmUNCj4gPiBkaWZmaWN1bHQgdG8gcGFyc2UgdW5sZXNzIHRoZSBuZXds
aW5lcyBhcmUgcmVtb3ZlZCBiZXR3ZWVuIHBpbnMNCj4gPiBvciBpdCdzIHJlYWQgaW4gYnkgYSBw
YXJzZXIgbGlrZSBMaWJyZW9mZmljZSBDYWxjIG9yIEdvb2dsZSBkb2NzLg0KPiA+DQo+ID4gVG8g
bWFrZSBpdCBlYXNpZXIgdG8gZm9sbG93IHRvIHRoZSBuYWtlZCBleWUgaW4gYSB0ZXJtaW5hbCB3
aW5kb3c6DQo+ID4gKiBkcm9wIHRoZSBuZXdsaW5lIGluIHRoZSBtaWRkbGUgb2YgcGluIGRlZmlu
aXRpb25zDQo+ID4gKiBzaG9ydGVuIGFsbCBvdXRwdXQgdXNpbmcgdW5pY29kZSBjaGFyYWN0ZXJz
DQo+ID4gKiBhbGlnbiBhbGwgcGlwZSBkZWxpbWl0dGVycw0KPiA+ICogb3V0cHV0IHRoZSBzYW1l
IHBocmFzZSBldmVuIGZvciBkaXNhYmxlZCBmdW5jdGlvbnMNCj4gPiAgIChidXQgd2l0aCBhIOKI
hSBjaGFyYWN0ZXIpDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBNYXJpbyBMaW1vbmNpZWxsbyA8
bWFyaW8ubGltb25jaWVsbG9AYW1kLmNvbT4NCj4gDQo+IFRoYXQncyBhIGJpdCB1bm9ydGhvZG94
LCB3aGF0IGhhcHBlbnMgd2hlbiBzb21lb25lIHVzZXMgdGhlaXINCj4gb2xkIFZUMTAwIHRlcm1p
bmFsIHRvIGxvb2sgYXQgdGhpcyBmaWxlPw0KDQpJIGd1ZXNzIGl0IHdvdWxkIGxvb2sgcHJldHR5
IHRlcnJpYmxlLCBidXQgZ2l2ZW4gaXQncyBkZWJ1Z2ZzIHZlcnkNCnVubGlrZWx5Lg0KDQo+IA0K
PiBCSVVUISBJdCBpcyBhIGRlYnVnZnMgZmlsZSwgYW5kIHlvdSBmb2xrcyBhdCBBTUQgYXJlIGdv
aW5nIHRvIGJlDQo+IHVzaW5nIHRoaXMgYW5kIEkganVzdCBhc3N1bWUgdGhhdCB5b3UgZm9sa3Mg
aGF2ZSBhbGlnbmVkIGludGVybmFsbHkNCj4gdGhhdCB0aGlzIGlzIGhvdyB5b3Ugd2FudCB0aGlu
Z3Mgc28gSSBqdXN0IGFwcGxpZWQgdGhpcy4NCj4gDQo+IFdlIG5lZWQgdGVzdGluZyBpbiBsaW51
eC1uZXh0IGZvciB0aGlzIGFueXdheSwgdGhlIG1lcmdlIHdpbmRvdw0KPiBpcyBjbG9zZS4gSWYg
dGhlIG90aGVyIEFNRCBwZW9wbGUgZG9uJ3QgbGlrZSBpdCBmb3Igc29tZSByZWFzb24NCj4gSSBj
YW4gYWx3YXlzIHB1bGwgaXQgb3V0Lg0KPiANCg0KSSBkaWRuJ3QgcHJlLWFsaWduIHRoaXMgd2l0
aCB0aGUgb3RoZXIgQU1EIGd1eXMuICBJdCB3YXMganVzdCBzb21ldGhpbmcNCkkgbm90aWNlZCB0
aGF0IGhhcyBhbm5veWVkIG1lIGFzIEkgbG9vayBhdCBidWdzIHRoYXQgSSdtIGxvb2tpbmcgYXQg
YW5kDQpzaW5jZSBpdCdzIG5vdCBzZW5zaXRpdmUgY29udGVudCBmaWd1cmVkIHB1YmxpYyByZXZp
ZXcgaXMgZmluZSBmb3IgaXQuDQoNClRoYXQncyB3aHkgSSBsZWZ0IHRoZW0gb24gVG86IGxpbmUu
ICBCdXQgeWVzIGFzIHlvdSBzYXkgaWYgb3RoZXJzIGRvbid0IGxpa2UNCml0IHJldmVydHMgYXJl
IGNoZWFwIGFuZCBpdCdzIGJldHRlciB0byBoYXZlIGVub3VnaCB0aW1lIGZvciBnb29kIHRlc3Rp
bmcNCmNvdmVyYWdlLg0KDQpUaGFua3MhDQo=
