Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42D7A56AA57
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 20:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236128AbiGGSTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 14:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235764AbiGGSTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 14:19:19 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2692431DC6;
        Thu,  7 Jul 2022 11:19:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IRzoWWQI12yd3dSqIgaeboMSUJFTJb0M6TyOoOUbuWcCCXz1au1qfnn1n4QEcKKbjwoL9TrxRPg0WF8PqxUD9l/jF7B4/ugoG4bzivfaWRGX5vA+YBKZNyLs5gDq4sTIr53p6LgYaERpKYMeAUXG05ncxSqEDXevJ1A9fhhkzZ2MQGN0JCNjjE8j+Yd09YK2U9hD+0H+ZvOd2H2jPQ/bkRb75KsNUKTGNVZ8hE8evQj0CwOyHD05vzC9QxlxikvnnfDXm21p29cgCHwN7FwpAVr0z7mbgABE3v7H+vbzPWbrqSVqbjHnnlNa46IVAHypLKLGzj4ipxMipVlsHEe/AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gWdFS7XxdyLuzcW88LsJ/n1vhK/BltWQ3f15lgmI8yQ=;
 b=fem1M6ORvpO2YR4JJHuCxi2CUtydqZdXNleU0p3NJ2gKQJhumedmqEQtJY+E8JyJj4gKsn7Ks+/kgn2TpdH+HqTwO2USZBKIAlgctxjvnI053UnxoC9DBkoPh2ABuaduJim+ord9TWvoP3OdQLr4RS2kZQUL2blGHlhh0ymeCFgsP/+oG8cPAQ2MpzIPeLs1nUjgOfNgosoa7jeq7nmtwB/kz7h/9ColxdyxugSDTvOFYLi2VePWjP8e34N8S6HYTbtYZSNE2/fsFncfbxhMgdp4m2B+aieRpqEp4eoOBzsBvIOIiMWMnESC6fSQcApDpDp87fRiPX6gtprBFpFmYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gWdFS7XxdyLuzcW88LsJ/n1vhK/BltWQ3f15lgmI8yQ=;
 b=j3TFbU5cqM/2MpwuhTuKg0mwwSht+7dBa7LUYB+5p9keIiN0+BeIRlL4T2i3zB/kTcGvLUcZstM7e4oROqkx8ICe96fd+tPDabGBrsK6sFHo4uAZExTPYDiYfmNkF0kGdvrqkTG9y6nwR4REet/HhFKVujC1D2GQB5THlCDuwps=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM6PR12MB3452.namprd12.prod.outlook.com (2603:10b6:5:115::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Thu, 7 Jul
 2022 18:19:15 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::1143:10a5:987a:7598]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::1143:10a5:987a:7598%5]) with mapi id 15.20.5395.021; Thu, 7 Jul 2022
 18:19:14 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Akihiko Odaki <akihiko.odaki@gmail.com>
CC:     "Natikar, Basavaraj" <Basavaraj.Natikar@amd.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] HID: amd_sfh: Ignore uninitialized device
Thread-Topic: [PATCH] HID: amd_sfh: Ignore uninitialized device
Thread-Index: AQHYiv1DsnHpzczkE0qou6j14nomcq1k7MkAgAAAvgCAAAHvgIAOVUvA
Date:   Thu, 7 Jul 2022 18:19:14 +0000
Message-ID: <MN0PR12MB61016F1A31FBFABF44DE1211E2839@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20220626081339.7243-1-akihiko.odaki@gmail.com>
 <b17f4e85-8a35-65ab-34de-0978bdc4cfea@amd.com>
 <8c95e3d7-cff6-c56e-e197-fdd0911d81aa@gmail.com>
 <3ff059d8-2d89-6ea1-209b-3c8855561acb@amd.com>
 <d0559a60-a4c1-19a9-39c5-18a5e2e460ca@gmail.com>
In-Reply-To: <d0559a60-a4c1-19a9-39c5-18a5e2e460ca@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-07-07T18:14:23Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=577a157a-0fb6-4cee-bda0-96e0804f9103;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-07-07T18:19:13Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 01e50e94-f619-44b4-b34f-991b7bb4018b
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a09cde29-e474-401b-ee02-08da604532e2
x-ms-traffictypediagnostic: DM6PR12MB3452:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JfbFr22WJjYkQtsvTO5zJzxQcFVBvaz4MUpfvX4giVO3ai3bQrWwg1zXUiC1SPzS+aNDaBgtcsKhUeob7AJJugzDNixSB2i8G3HghyYioQXDGfBlYytgVG9dDo1rN0pXSNKJDgH723iSzmut7+bj4Sqi3Q138mPuVfIDACKphQyLJGUjrUBQUd30ycqPOrI/SIAtqW1+tpbxaxfHtabSw6ejGH4sB5Sa35Cwdx1sGUs9FMDc3G3gvTMo/Kt4X00rdIZ4BE51/4R+x7O2247uMfO2od9oAoJmp/0pMR82UVIcIHRgC9TIVroKGWYFXctxo9+59dz4cuETCCT4Kl1ITlFlWr2A5Y9GAHh3c82OflVNGYtCJpUIqLpHnjO5nN9ynNFlukEjIQWs/NSELkBQtFOtSfmT1Aw96K+gsVjNoM3h/8HvJucO7YWjUKQaXh89YO1SwwOUslTU0CLFllD0w0WOuNXyG8DSCfFwXqqGU+XuP4oXC/1XFtJv3W6q38vgLm9kCrLrCCpi+i3oj7NlG3TBCVcYhOynANFEYnmvIUl5I14grjqOJk59u7KCqlJRSqtXeUVU9wSSiXdrmH+3LU6MUCX15hDnH8Bevr0nxuBjxZxCxIJJmT0FEzEtJ1kcK8r6O03C5RrQTeJNToYKJidQ330J+xjkQ7AlQRr0LS4jm6OBYJOEladdqTLb34PDzah2uItUjBS2sHi926Ao5slRlg9IL4725Uth/hnKHKZVNBIDIMUm/pelcPPytTtLaqcxdsHkXYBHWExQ5XLdfsPvxFDCmETa1ueLkUNqD8JDdfNH8YHRdsPsumB2bpaZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(136003)(346002)(366004)(396003)(478600001)(26005)(2906002)(38100700002)(9686003)(186003)(122000001)(33656002)(64756008)(86362001)(8936002)(53546011)(55016003)(8676002)(5660300002)(54906003)(71200400001)(66446008)(83380400001)(6506007)(41300700001)(7696005)(66476007)(66946007)(38070700005)(76116006)(6916009)(4326008)(66556008)(316002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R1ZqbE9mZDJINEhQeXBjV3l1MWdMQmQ2SVpBRGN3MDRheXE0aTRXZi80eEFH?=
 =?utf-8?B?MGlQbkpEQ0t6S1pmRnhsa09MT1MvRjdGOGluY0c3cjVpazNLR1VlUm4xTUE4?=
 =?utf-8?B?Zi9sSEZ3bWdPMGEwTG9SaVczc1RrZ3E3eCtXN0puQzlTaHFnTkkzdmw4aHJ5?=
 =?utf-8?B?QkUwWFhNMHczSG9LWHNkb3FQOXhVTHpoMnMzMVMvYVhPR3RkYXlLd1g2UXVw?=
 =?utf-8?B?amgrYk1FZDhDM3ozL2VDTVphOTZUUWZObFZ0VW0xTDhsREJlbVovSTdYSGYx?=
 =?utf-8?B?b2srbllnM3llQ2dZRmhNVlJuMFgyL1dQWGE4M3hBajE0bFY4UkdveENheWkx?=
 =?utf-8?B?YjM5cXltSkFoWk1VMnlWY25KTU1DVlo1a3ZiZHNuWVR1b2pQSGVoTlFaYXVn?=
 =?utf-8?B?YWpLTStQNjNab2lMTUluZ3p4MlEvVUY4cGRUS1g4ODJFV1VqM0JEakxrMDlq?=
 =?utf-8?B?OFkwZXZiOU1rMFRxREQzaFNzbUI4a3RBaTA0RHphWm8xYnhEMG9Xak82eW5j?=
 =?utf-8?B?MnZuRnZvdTAzakhSako5cXN3NHN1ZzJNNGR4RTRNRFpLN1RCb1NicjJUVGU3?=
 =?utf-8?B?VUNYVGNoOTZMdzIwWWM1cUdEZ0JaTG4yM016ZWpVVmtBcnQ0VHhWK29JM1ZU?=
 =?utf-8?B?L3dRSFJVS2FpRGpMb3I3eVZIa1Fray91bFBYajNSb2tsc1A3VStrTXdOOVhy?=
 =?utf-8?B?YjgyaVNDZVVWNTlPeVNiQW5MK0VyNmNEa0V3YzFzWDVJQU5NQWhaUFJoanQw?=
 =?utf-8?B?c29Hb3k1Y2JGYVJ5Q3FBRzZXM3hKSVFuRFVZMDZJdzRLRlZmSEtrZll3eXVG?=
 =?utf-8?B?VE9pd1hPZTIySmY4WTIwcnczNUVnU1ZCUVpiYmtSQ3RyZHN4VzVPYitCUUFp?=
 =?utf-8?B?d0E3dVBCMHZGV2Jmbk0xall1aGZEaE1aaStMYkN1QjUwUzhKWUliUDNKQXBD?=
 =?utf-8?B?Sy94cXdpeFJwTXpwZXFlaDN2ODVCQUVPcitTV2kxRjdNWC9QTDZHaUttbk1N?=
 =?utf-8?B?WGYrQ0VpeGhMdHYyUjBWR1ExRUE0K01sYS9tR2pHWEVoWnIzR0xKNlUzTXA4?=
 =?utf-8?B?cWs2RmQzblh3OFVMemVUcGtVUTNIdzBPREpuV0UxRUw3Mm9kTSsvbjc3Y0dn?=
 =?utf-8?B?dG1nQktNWnk5VWQ1TkY0ZHprMVFUVHRnNzNwV3pHSTdyUXVtQTFsK3FtQllk?=
 =?utf-8?B?ZW1idzZlQ2dwRm84TVBpNEFwRkhiME1KQStZUHFvQUNBS0xjQjJSRHlmMVhT?=
 =?utf-8?B?NTBpT2wyWXo4eWlOcmNvU016Ti8xaVZ5WTU2MEtFN0tPSjNIRklacitBNFg5?=
 =?utf-8?B?b0ZSY0dnTGl2S1VCdGZiOGRQM0xBUzUrK0FkQXN5b2tjTWxsSnRGejU5eU0w?=
 =?utf-8?B?VjNpVVdPWVErOGo5V1JxVWwza2JuZXBRLzI5ajJFZTlUZXMyWCtIcThZUitU?=
 =?utf-8?B?WlVmMzdnTjVxQUtZRjNheWtjQStoOFB3MW9BTUlGMzhmQ1lmMk15NXZkbWpD?=
 =?utf-8?B?WVR1djVwd3FJcURncHU3cDRuTzRTTXV6eEtBbjMzOWtaTEdhVmpqSG9WWTdt?=
 =?utf-8?B?TkhZQ0pFSEFzSUVaR01UV08vWXdOZXRpSmlFdXJvSkh0Vy96NkNhMExjYU8v?=
 =?utf-8?B?THNtRVd3K1Y0TGVob2NWTzUyK1JEK3diaXV0TWdYcHQ2YlBrNjNqa3ZjVEk0?=
 =?utf-8?B?VjJuMlEzNlNXemxJR2FvMVJzTTUvUzFmU05TNjRQUXBmWldMNm1nL0tZUERR?=
 =?utf-8?B?U3duQXpDRkJGZWt4TmhTamwya2tnV0k0bkhqd1Y0Rk9BM3plQ3lPS2hLNXpr?=
 =?utf-8?B?U2piMnFmT2IveWZ0T2J6OWtKcE4rVFNubFdzMVB3VGtnQSszU2c3clFFWEZS?=
 =?utf-8?B?cUJnZ09SeGhmRExhOW4reDFuUktVcTZERUd0bkZqdVV1dzIyQmhlRnp2WFlu?=
 =?utf-8?B?TFRNM3RlblU4NmpBOXJUeTRMOGJxa0F0YlNleVZjQjM2d3c5L083dWk3aUgy?=
 =?utf-8?B?VGx5YUVzZEw5WlJJZ09UTi9XSXNyeElmRDlUZ1kwRVo2aExPZll5cWRmVitj?=
 =?utf-8?B?M0hJbFVSRTl3RWdDangyVVl5dGJUeXdBTi9zcTRDMFEvOVZtUnpROVc5VVlX?=
 =?utf-8?Q?KvlA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a09cde29-e474-401b-ee02-08da604532e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2022 18:19:14.8776
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2quWhFU48x+4igh0KIpvpMXar+ZIOIusSGtQGYm7fUiv7c5/wQhGvQLlXkboMQoQq7dtpEJzP2t0hsU/J2muZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3452
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W1B1YmxpY10NCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWtp
aGlrbyBPZGFraSA8YWtpaGlrby5vZGFraUBnbWFpbC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIEp1
bmUgMjgsIDIwMjIgMTA6MjENCj4gVG86IExpbW9uY2llbGxvLCBNYXJpbyA8TWFyaW8uTGltb25j
aWVsbG9AYW1kLmNvbT4NCj4gQ2M6IE5hdGlrYXIsIEJhc2F2YXJhaiA8QmFzYXZhcmFqLk5hdGlr
YXJAYW1kLmNvbT47IEppcmkgS29zaW5hDQo+IDxqaWtvc0BrZXJuZWwub3JnPjsgQmVuamFtaW4g
VGlzc29pcmVzIDxiZW5qYW1pbi50aXNzb2lyZXNAcmVkaGF0LmNvbT47DQo+IGxpbnV4LWlucHV0
QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0
OiBSZTogW1BBVENIXSBISUQ6IGFtZF9zZmg6IElnbm9yZSB1bmluaXRpYWxpemVkIGRldmljZQ0K
PiANCj4gT24gMjAyMi8wNi8yOSAwOjE0LCBMaW1vbmNpZWxsbywgTWFyaW8gd3JvdGU6DQo+ID4g
T24gNi8yOC8yMDIyIDEwOjExLCBBa2loaWtvIE9kYWtpIHdyb3RlOg0KPiA+PiBPbiAyMDIyLzA2
LzI4IDIzOjQyLCBMaW1vbmNpZWxsbywgTWFyaW8gd3JvdGU6DQo+ID4+PiBPbiA2LzI2LzIwMjIg
MDM6MTMsIEFraWhpa28gT2Rha2kgd3JvdGU6DQo+ID4+Pj4gTGVub3ZvIFRoaW5rUGFkIEMxMyBZ
b2dhIGhhcyBBTUQgU2Vuc29yIEZ1c2lvbiBIdWIsIGJ1dCBpdCBpcyBub3QgdXNlZA0KPiA+Pj4+
IGJlY2F1c2UgQ2hyb21lIE9TIEVDIFNlbnNvciBIdWIgaXMgdXNlZCBpbnN0ZWFkLiBUaGUgc3lz
dGVtIHRoZXJlZm9yZQ0KPiA+Pj4+IG5ldmVyIGxvYWRzIHRoZSBmaXJtd2FyZSBmb3IgTVAyIGFu
ZCBNUDIgZG9lcyBub3Qgd29yay4gSXQgcmVzdWx0cyBpbg0KPiA+Pj4+IEFNRF9QMkNfTVNHMyBy
ZWdpc3RlciB0byBoYXZlIC0xIGFzIGl0cyB2YWx1ZS4NCj4gPj4+Pg0KPiA+Pj4+IFdpdGhvdXQg
dGhpcyBjaGFuZ2UsIHRoZSBkcml2ZXIgaW50ZXJwcmV0cyB0aGUgdmFsdWUgYXMgaXQgc3VwcG9y
dHMgYWxsDQo+ID4+Pj4gc2Vuc29yIHR5cGVzIGFuZCBleHBvc2VzIHRoZW0sIHdoaWNoIGNvbmZ1
c2VzIGEgdXNlcnNwYWNlIHByb2dyYW0sDQo+ID4+Pj4gaWlvLXNlbnNvci1wcm94eSwgYW5kIG1h
a2VzIGl0IHRvIHVzZSB0aGUgbm9uLWZ1bmN0aW9uaW5nIHNlbnNvcnMNCj4gPj4+PiBpbnN0ZWFk
IG9mIGZ1bmN0aW9uaW5nIHNlbnNvcnMgZXhwb3NlZCB2aWEgQ2hyb21lIE9TIEVDIFNlbnNvciBI
dWIuDQo+ID4+Pj4NCj4gPj4+PiBDaGVjayB0aGUgdmVyc2lvbiBiaXRzIGluY2x1ZGVkIGluIEFN
RF9QMkNfTVNHMyByZWdpc3RlciBhbmQgaWdub3JlIHRoZQ0KPiA+Pj4+IGRldmljZSBpZiBhbGwg
b2YgdGhlIGJpdHMgYXJlIHNldC4NCj4gPj4+Pg0KPiA+Pj4NCj4gPj4+IEhhdmUgeW91IGFscmVh
ZHkgY29uZmlybWVkIHRoaXMgZmFpbHVyZSBoYXBwZW5zIGluIDUuMTktcmMxIG9yIGxhdGVyDQo+
ID4+PiBhcyB3ZWxsP8KgIEkgd291bGQgdGhpbmsgdGhhdCBiNWQ3ZjQzZTk3ZGFiZmEwNGE0YmU1
ZmYwMjdjZTdkYTExOTMzMmJlDQo+ID4+PiBzaG91bGQgaGF2ZSBmaXhlZCBpdC4NCj4gPj4NCj4g
Pj4gWWVzLiBJIGNvbmZpcm1lZCBpdCB3aXRoIDc4Y2E1NTg4OWE1NDlhOWExOTRjNmVjNjY2ODM2
MzI5Yjc3NGFiNmQuDQo+ID4+DQo+ID4NCj4gPiBUaGFua3MgZm9yIGNvbmZpcm1pbmcuDQo+ID4N
Cj4gPj4gYjVkN2Y0M2U5N2RhYmZhMDRhNGJlNWZmMDI3Y2U3ZGExMTkzMzJiZSBkZWFscyB3aXRo
IHRoZSBjYXNlIHdoZXJlIGl0DQo+ID4+IGFkdmVydGlzZXMgdjIgYnV0IGl0IGRvZXNuJ3QgaW4g
bXkgY2FzZS4NCj4gPg0KPiA+IEluIHlvdXIgY2FzZSBpdCBhY3R1YWxseSBnb2VzIGRvd24gdGhl
IHYxIG9wcyBwYXRoIHRoZW4gcmlnaHQ/DQo+IA0KPiBZZXMsIGJ1dCBJIGRvdWJ0IGV2ZW4gdGhh
dCBpcyBjb3JyZWN0IGluIHRoaXMgY2FzZS4gSSBndWVzcyB0aGUgdjENCj4gcHJvdG9jb2wgd291
bGQgaGF2ZSBhIHZhbHVlIDEgZm9yIGFjcyBpbiBtcDJfc2VsZWN0X29wcygpLCBidXQgaXQgaXMg
MTUNCj4gaW4gdGhpcyBjYXNlLiBJdCB3b3VsZCBiZSBuaWNlIGlmIHlvdSBjb25maXJtIHRoYXQg
aHlwb3RoZXNpcy4NCg0KSSBoYWQgc29tZSBvZmZsaW5lIGNvbnZlcnNhdGlvbiBhYm91dCB0aGlz
LCBhbmQgaXQncyBwcm9iYWJseSBiZXN0IHRvIGluY2x1ZGUgYSB3YXkgdG8NCmJsb2NrIGFtZF9z
ZmggZnJvbSBsb2FkaW5nIG9uIHRoZSBETUkgb2YgQ2hyb21lYm9va3MuDQoNCldoYXQgeW91J3Jl
IGZpbmRpbmcgaW4gdGhlc2UgcmVnaXN0ZXJzIGlzIGdhcmJhZ2Ugd2l0aG91dCBmaXJtd2FyZSBs
b2FkZWQgYW5kIGlzbid0DQpkZXRlcm1pbmlzdGljLg0KDQpDb3VsZCB5b3UgY29tZSB1cCB3aXRo
IGEgcGF0Y2ggdGhhdCBibG9ja3MgZnJvbSB0aGUgRE1JIGRhdGE/ICBJIGRvbid0IHRoaW5rIGl0
IHNob3VsZA0KYmUganVzdCB5b3VyIHNwZWNpZmljIGNocm9tZWJvb2ssIGJ1dCBtYXliZSBvbmUg
b2YgdGhlIHN0cmluZ3MgdGhhdCBpbmRpY2F0ZXMgImFueQ0KY2hyb21lYm9vayIgYW5kIGhhcyBh
ICJHb29nbGUgSW5jIiBvciBzb21ldGhpbmcgaW4gaXQuDQoNCj4gDQo+IFJlZ2FyZHMsDQo+IEFr
aWhpa28gT2Rha2kNCj4gDQo+ID4NCj4gPiBCYXNhdmFyYWogLSBpcyBkaXNjb3ZlcnkgdW5pcXVl
IHRvIHYyP8KgIE9yIGRvZXMgaXQgYWxzbyBleGlzdCBmb3IgdjE/DQo+ID4gSWYgaXQgYWxzbyBl
eGlzdHMgZm9yIHYxIEkgdGhpbmsgdGhhdCdzIGEgY2xlYW5lciBzb2x1dGlvbi4NCj4gPg0KPiA+
Pg0KPiA+PiBSZWdhcmRzLA0KPiA+PiBBa2loaWtvIE9kYWtpDQo+ID4+DQo+ID4+Pg0KPiA+Pj4+
IFNpZ25lZC1vZmYtYnk6IEFraWhpa28gT2Rha2kgPGFraWhpa28ub2Rha2lAZ21haWwuY29tPg0K
PiA+Pj4+IC0tLQ0KPiA+Pj4+IMKgIGRyaXZlcnMvaGlkL2FtZC1zZmgtaGlkL2FtZF9zZmhfcGNp
ZS5jIHwgNCArKysrDQo+ID4+Pj4gwqAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQ0K
PiA+Pj4+DQo+ID4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaGlkL2FtZC1zZmgtaGlkL2FtZF9z
ZmhfcGNpZS5jDQo+ID4+Pj4gYi9kcml2ZXJzL2hpZC9hbWQtc2ZoLWhpZC9hbWRfc2ZoX3BjaWUu
Yw0KPiA+Pj4+IGluZGV4IGRhZGM0OTFiYmY2Yi4uNDEzN2U1ZGE3N2FkIDEwMDY0NA0KPiA+Pj4+
IC0tLSBhL2RyaXZlcnMvaGlkL2FtZC1zZmgtaGlkL2FtZF9zZmhfcGNpZS5jDQo+ID4+Pj4gKysr
IGIvZHJpdmVycy9oaWQvYW1kLXNmaC1oaWQvYW1kX3NmaF9wY2llLmMNCj4gPj4+PiBAQCAtMjcx
LDYgKzI3MSw4IEBAIHN0YXRpYyB2b2lkIG1wMl9zZWxlY3Rfb3BzKHN0cnVjdCBhbWRfbXAyX2Rl
dg0KPiA+Pj4+ICpwcml2ZGF0YSkNCj4gPj4+PiDCoMKgwqDCoMKgIGNhc2UgVjJfU1RBVFVTOg0K
PiA+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBwcml2ZGF0YS0+bXAyX29wcyA9ICZhbWRfc2ZoX29w
c192MjsNCj4gPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgYnJlYWs7DQo+ID4+Pj4gK8KgwqDCoCBj
YXNlIDE1Og0KPiA+Pj4+ICvCoMKgwqDCoMKgwqDCoCBicmVhazsNCj4gPj4+PiDCoMKgwqDCoMKg
IGRlZmF1bHQ6DQo+ID4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIHByaXZkYXRhLT5tcDJfb3BzID0g
JmFtZF9zZmhfb3BzOw0KPiA+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBicmVhazsNCj4gPj4+PiBA
QCAtMzE3LDYgKzMxOSw4IEBAIHN0YXRpYyBpbnQgYW1kX21wMl9wY2lfcHJvYmUoc3RydWN0IHBj
aV9kZXYNCj4gPj4+PiAqcGRldiwgY29uc3Qgc3RydWN0IHBjaV9kZXZpY2VfaWQgKmkNCj4gPj4+
PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FTk9NRU07DQo+ID4+Pj4gwqDCoMKgwqDCoCBt
cDJfc2VsZWN0X29wcyhwcml2ZGF0YSk7DQo+ID4+Pj4gK8KgwqDCoCBpZiAoIXByaXZkYXRhLT5t
cDJfb3BzKQ0KPiA+Pj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVOT0RFVjsNCj4gPj4+PiDC
oMKgwqDCoMKgIHJjID0gYW1kX3NmaF9pcnFfaW5pdChwcml2ZGF0YSk7DQo+ID4+Pj4gwqDCoMKg
wqDCoCBpZiAocmMpIHsNCj4gPj4+DQo+ID4+DQo+ID4NCg==
