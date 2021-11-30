Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29039462FAA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 10:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240231AbhK3JeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 04:34:10 -0500
Received: from mail-eopbgr1300135.outbound.protection.outlook.com ([40.107.130.135]:6069
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234664AbhK3JeI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 04:34:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MOgw03sxN8NJGrwruqXkl+Y1DGWsx9kAaFKWvEKcnw2nPlH2VDQXZ6q8sWtX3iP2qwSBojhng+IB1smMb2LWMYwwmcvTWJwncVUxNjaFhhocGjLsqmDyxt+pigvhGyYqNDxzpienaQWcQvqgImUXFp1YqlmrfDtRjCkm7/hQ9zy3ptkC/3YNf5ynmeizs5rOvSiRz1xe6TQLnI8h4zj5h0HKg6gZ8wrw8YWhqJXFX6cYv5DfGHIt1pM4m7JgewQX494nIK2tXWieerN2XlGSOsP2kPXGdbRizB9vJ/DCgOnILYXNID2Cba1hK1l6/WZkXzy8cLE5FnLFAUTy6VD2QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HOBKqWoUSLUnlrCBdXEpfvinsbfQwEEA1BE9s9KoDhI=;
 b=Ehmy2QyDWbYe53G3jlKYmwWb8XRRpZPdLakxhnnkzpAPPM2vC0XPuc1gyt1YjGqintnE2BvHHApwOLhdk3+nYcYrl4tktZ+BkFslOuW86jv2dSG0pw3K4fX7aQrAYw55y3bNvmvpg+njq9/7VdBmkVleq2XLEbHf6J9tHuesOzsTqMdrHfA233rxfqUXtvQ3sFCIV9MAlb/U81xma5dlNJTrSHScUp1h+P7ikVX/0RUVt8W8VipTWOR2IOjrcsbNQKQh3tYiwWfMrepQwOkwMKxWIYiKePpCnOYn0xz8KX/OSmVoP6JXlUl9oVlp8DqkAROIH/yiaY12AP7sQuErnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HOBKqWoUSLUnlrCBdXEpfvinsbfQwEEA1BE9s9KoDhI=;
 b=vNgcz5KcwAwGtVApP2QOYBlAMR2yfzfrJ9wrYojDUqOCLWb6ZBMO9GGoSHpN5va3E4SuCp8VX68UOPDHK5Vl09WuGzb2MZqh5AL8eHkhytmG0KUdIVVCsx8AgtLuW6+hl2c6ZUYqUOoNHdfyhPtcXiSpu8HQDNyPi+an42tfULQHAaMrLYv1tFcKZztjwOYJhS5flCxmerVZAU3Nd2moBllRE5fpNhkXA8J7EMI+Jij+46/XaLiINOjWpnnQkCsEkBKjcSQ2N1qIHM32S/byUUsqcXOyma7IskZNGVDuGOz4lozNIoi7nePRnsF8zeYpdwN6KBtacEBQvmrDED+0xg==
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com (2603:1096:203:87::17)
 by HK0PR06MB2914.apcprd06.prod.outlook.com (2603:1096:203:70::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.24; Tue, 30 Nov
 2021 09:30:48 +0000
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::70c4:b471:2d05:1209]) by HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::70c4:b471:2d05:1209%6]) with mapi id 15.20.4734.024; Tue, 30 Nov 2021
 09:30:48 +0000
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Cai Huoqing <caihuoqing@baidu.com>,
        Tao Ren <rentao.bupt@gmail.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        kernel test robot <lkp@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>
Subject: RE: [PATCH 1/3] usb: aspeed-vhub: add qualifier descriptor
Thread-Topic: [PATCH 1/3] usb: aspeed-vhub: add qualifier descriptor
Thread-Index: AQHX4rYtVtYRjExejkSTRdDE/PKfgKwbL7OAgACkBOA=
Date:   Tue, 30 Nov 2021 09:30:48 +0000
Message-ID: <HK0PR06MB32028A343BDCF1C719918B8280679@HK0PR06MB3202.apcprd06.prod.outlook.com>
References: <20211126110954.2677627-1-neal_liu@aspeedtech.com>
         <20211126110954.2677627-2-neal_liu@aspeedtech.com>
 <84b2d2c6b530d0a3a9b86b0ffcbfa70935bdb0a9.camel@kernel.crashing.org>
In-Reply-To: <84b2d2c6b530d0a3a9b86b0ffcbfa70935bdb0a9.camel@kernel.crashing.org>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0167d7fe-a884-4afb-8e14-08d9b3e417c3
x-ms-traffictypediagnostic: HK0PR06MB2914:
x-microsoft-antispam-prvs: <HK0PR06MB2914BEC1CB4D7F54FF56D53580679@HK0PR06MB2914.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1751;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TyTOkw2nJeo/QC0HtvTsaoZqJJEa4vZV6QOe+NovmZpqhV5vjlNTw4+SNG/JR7k6p87qn0JS6CBBcIh7MjMYlvkFLjXU0rmR1ry2cMkmh5Iq5f/rgm5uYNhY375MuVpucboTk4BXW2LV2NOIepUMrjOUsa9JzLBSjzqQm0TSDYLEuUWZ0cDQVg+1XvZw8Sz+TKZf/sRwV/kCOFy4CcvDMcPQZP0hkDo5gVa5kCo/0wBR3hLW6Poqeb1Ga0JJqFa+vJczli0xZqNMjlJSIKZp1s0HiC5r9VVedZ++L8rswLvSwq0UxmhSvGr7trwFBBSQQGvhHs3VH7a8gPCGlnsjteInmGUKQcE8kFvjRzFwb2JDVz9F6QHx3fM0DTIbtIGHtIFDLhp+2Z4rm6+peg+A9Rz0+VS51JtA3RdJGZyfuDZymzR+NN6YlVCkZ+ZVcVwm9K76ol1zeRcgEA4agL5+lecKXK8WCy6A2oFHK2eDsk634+kTS6cCuQWnckGQCDr8Wd9ScMAlfsK0slR7ETUUp7PcciPH5+8WwxjOmGVKKel5iSy/He+pQF/vH7cEvS6A0cDqZoY9S/fc2r37KpVr+g8c8DNxtsHr3OipIZZxisil1HPZF6xrVjE/QIHR3STiypW4QO3bRkTThjkikhYlcTAaQklAaqgeV7SAgfczBuTK0i6UCcE9ZBi/1+wz89tLivKLZsJ3euvLurR+s7nz2eHc08SheOSI3wedzJyqB5Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3202.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(366004)(376002)(39850400004)(346002)(186003)(66476007)(66556008)(316002)(66446008)(5660300002)(66946007)(8936002)(64756008)(9686003)(86362001)(4001150100001)(53546011)(7696005)(52536014)(110136005)(55016003)(26005)(508600001)(33656002)(7416002)(38070700005)(8676002)(38100700002)(921005)(76116006)(122000001)(6506007)(83380400001)(71200400001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RkFZL1F2ZzRuR3BRbTduUi9HeUw0NUd0akxOc0Q0c2cyYlo2YkVPNENTRG9H?=
 =?utf-8?B?UDNtRDdXWjRRNFNqZmtaN2wydS9NQnppRllQNlNTMytabUtvYi9oZS9GYTdt?=
 =?utf-8?B?OUc1MzIzMUppWDZFQTdzVDRPc3VtbTMxTy8wc0Zvck0xRTZIZVJoL3RVMWVH?=
 =?utf-8?B?dkxHTm5zZE03QkRVZmx4MDRkWGxiVktmRVVxQUk1L2hMaGMrWFJzUk9YQ0tF?=
 =?utf-8?B?ejZSaGV3dGlaK1VNeHRRV0xla2hiYS9iVUNLZGQzbTZyRE9tUTltenlRMXNE?=
 =?utf-8?B?T3dMRUIwQ25QZk9vRXc5Nmhla0p1RTVjQnFSalNVVzdEM2w0SUxpbXV5bzNF?=
 =?utf-8?B?V1haVnZwZThvRC9yMU5EMnhlYkliS0p3WWh0cTJjaHB6TmZoUWpuRVVuSGl2?=
 =?utf-8?B?YWZSTTNsNWw0blNYUll5TW1QUU4wRFZOWFpHRXhiQTRndEV1L3QvbEFNUFVH?=
 =?utf-8?B?TjNSNlJsV3l6emVJUVJwLzdKTFhLRHE4T2t0bGFuTkcvTExwaE9CakU1c2tv?=
 =?utf-8?B?SGQ4cHdua0hTdnF5bnNqZ0hHTTI3S2t0b0dGaGtpTE5NUmNPL0pBMEV4VFZl?=
 =?utf-8?B?RUZ3d2dYQ0ZGcFZKbExNZFdPRUUzV21LdXJ1UVUyRzZZaFFZYzRDQUZSZ1lU?=
 =?utf-8?B?RHk5NFd1WkVnZ3Uzd2lYaStzVHhjaDZIcWNyVlpxUGRCb0t6WUpQWmxNcWlC?=
 =?utf-8?B?c25NV2NmWnJicVEvT0xIZ1l6V1ppTVdjWDJTcmsreUF0OVA3MFFsNHJ1L2cr?=
 =?utf-8?B?c2RaaGtTOUN2cVNVZG1zQXYzMk9UM2lCUHdrNzhKWDl1Uko1eC84MGdHV1NO?=
 =?utf-8?B?Uk1oemJwSzhPVjJCd0tXUk1tRlcrU21WRkFpblZubWtDbjJrRWNxUjNrVnU3?=
 =?utf-8?B?UEprTTlDL3AvMkxtL2ttM2w4YVMwcHArWDZ2ckhXdStWd3ZnSXQ0aDA3Wmt6?=
 =?utf-8?B?SmhGTEpQN0lhU3YrYjh1OU1MRVJrWC9DZVBrWUx5bS93eXJLbi9XQWJxbzY5?=
 =?utf-8?B?SW5pVk1kaGxEWTlZVGoyZUdrZUxPWDEwVkpINFVlYVI2cnVJMjF4KzlYeThv?=
 =?utf-8?B?Ukh6NEFqdFl5VDcwYTlJYlhvbkxRc1pzdCtMWHpSL2lsUUt2M2UyZlpDVFFD?=
 =?utf-8?B?cVlPbTlXMitYanNvL2w5Zm0yME9KQmo4S05lNUYya3I1MGJvUzZ4akkyU0g1?=
 =?utf-8?B?T1ZpR1lpM0tVcUxkZ09lWWtWTlQvMlcyMVloWFpIdDEwSjJjUFovRlZERHEw?=
 =?utf-8?B?TFcxa1V2Ui9mTk5haGdvNHJCbmkyaGJDL0Z1WFZyeUkwNE1DdFF6WjN1RkJx?=
 =?utf-8?B?SGJoQ2lrdHVCczdHYWhJeGdhZmVGanQ4ZlNpWU1OeitySmRERms4WERUYTlC?=
 =?utf-8?B?SThaNUpQbzdGWUZvd3FaSmFHcXdLdGt4VDl6aGozeGRvSVNEbmk5cVQxNkJ5?=
 =?utf-8?B?WllBWjJtUnQ3YUdOWUV4OGp0T0lBemdCMXIrMmZMSGgwZDlXcHFUTE9OUTNL?=
 =?utf-8?B?OXpObjZkdExOL2EyNC9UbkpmZ2ZsT0JLanRybHZ2TlZhV2xCY2tMR1QxS1cw?=
 =?utf-8?B?NHlNd2dFeTEyOHluRTNTdjVoMVBPN0F4a0ZNU2ZOYmF4RWRjYURkNkVhdlhN?=
 =?utf-8?B?TWFpU21uMlJteVpoK2pxWVNmNGQyazJ2Uk9yZktPMElaWTBvOTJRTURoUi9h?=
 =?utf-8?B?SXdkYmY3T0Q2SmYranpiN2tkeUVyRnRJZlhJVGtrWmk3UjZmTkdyZkdtaTRC?=
 =?utf-8?B?QUFWdm8zYytkMWFnMUVHclBXTmUwZjkzdzY1ZVNZdTNjUUs4b3dHb0FHNE9a?=
 =?utf-8?B?aWt2V3l1d1FhNGNxTFVVdTJUemtxZUN4eW9aZGNFMzRoOE4wYkJmTUdSVEJP?=
 =?utf-8?B?NEhxSysydi9iQjloRGFUNW4vV0lLZzUzNWRPbElYaVM1alpZK1lTNUd1eE5J?=
 =?utf-8?B?amtqSlhINUtqQ0ZFS0JqNmRLWnZSNjVDYVllUUozeGpjT1ZUd2xYaGZFcFlS?=
 =?utf-8?B?aW1KbFVIalV6NUo2ZmlWZEZyd3AwejU4emQwc2RPZVlkMDllUzcwQjg1aFpo?=
 =?utf-8?B?K2lBS1hESDFEQ0M1UzNybFJKdmhITjN2TlZHZXkzVGwxWFhEOEZlditaaTNP?=
 =?utf-8?B?V3lVWk5TVitSdmNab1NZSjZheEhRemd6ekdPTzRtSEpoblpIdTEvYmNWck5m?=
 =?utf-8?Q?p7+H11syIJEvNIw7iLrurp4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3202.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0167d7fe-a884-4afb-8e14-08d9b3e417c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2021 09:30:48.1443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: US4QRo+xHNdFm+D5ptlLng3/GYEZaw8unicZCVSzEwqPX92SgI63Kz/v+2NqcupH+DNZciL8qC8p5FcFCU64GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB2914
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCZW5qYW1pbiBIZXJyZW5zY2ht
aWR0IDxiZW5oQGtlcm5lbC5jcmFzaGluZy5vcmc+DQo+IFNlbnQ6IFR1ZXNkYXksIE5vdmVtYmVy
IDMwLCAyMDIxIDc6NDEgQU0NCj4gVG86IE5lYWwgTGl1IDxuZWFsX2xpdUBhc3BlZWR0ZWNoLmNv
bT47IEZlbGlwZSBCYWxiaSA8YmFsYmlAa2VybmVsLm9yZz47DQo+IEdyZWcgS3JvYWgtSGFydG1h
biA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+OyBKb2VsIFN0YW5sZXkNCj4gPGpvZWxAam1z
LmlkLmF1PjsgQW5kcmV3IEplZmZlcnkgPGFuZHJld0Bhai5pZC5hdT47IENhaSBIdW9xaW5nDQo+
IDxjYWlodW9xaW5nQGJhaWR1LmNvbT47IFRhbyBSZW4gPHJlbnRhby5idXB0QGdtYWlsLmNvbT47
IEp1bGlhIExhd2FsbA0KPiA8anVsaWEubGF3YWxsQGlucmlhLmZyPjsga2VybmVsIHRlc3Qgcm9i
b3QgPGxrcEBpbnRlbC5jb20+OyBTYXNoYSBMZXZpbg0KPiA8c2FzaGFsQGtlcm5lbC5vcmc+OyBs
aW51eC11c2JAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0K
PiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWFzcGVlZEBsaXN0
cy5vemxhYnMub3JnDQo+IENjOiBCTUMtU1cgPEJNQy1TV0Bhc3BlZWR0ZWNoLmNvbT4NCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCAxLzNdIHVzYjogYXNwZWVkLXZodWI6IGFkZCBxdWFsaWZpZXIgZGVz
Y3JpcHRvcg0KPiANCj4gT24gRnJpLCAyMDIxLTExLTI2IGF0IDE5OjA5ICswODAwLCBOZWFsIExp
dSB3cm90ZToNCj4gPg0KPiA+IEBAIC00MTcsMTAgKzQzNSw5IEBAIGVudW0gc3RkX3JlcV9yYyBh
c3Rfdmh1Yl9zdGRfaHViX3JlcXVlc3Qoc3RydWN0DQo+ID4gYXN0X3ZodWJfZXAgKmVwLA0KPiA+
DQo+ID4gIAkJLyogR0VUL1NFVF9DT05GSUdVUkFUSU9OICovDQo+ID4gIAljYXNlIERldmljZVJl
cXVlc3QgfCBVU0JfUkVRX0dFVF9DT05GSUdVUkFUSU9OOg0KPiA+IC0JCXJldHVybiBhc3Rfdmh1
Yl9zaW1wbGVfcmVwbHkoZXAsIDEpOw0KPiA+ICsJCXJldHVybiBhc3Rfdmh1Yl9zaW1wbGVfcmVw
bHkoZXAsIHZodWItPmN1cnJlbnRfY29uZmlnKTsNCj4gPiAgCWNhc2UgRGV2aWNlT3V0UmVxdWVz
dCB8IFVTQl9SRVFfU0VUX0NPTkZJR1VSQVRJT046DQo+ID4gLQkJaWYgKHdWYWx1ZSAhPSAxKQ0K
PiA+IC0JCQlyZXR1cm4gc3RkX3JlcV9zdGFsbDsNCj4gPiArCQl2aHViLT5jdXJyZW50X2NvbmZp
ZyA9IHdWYWx1ZTsNCj4gPiAgCQlyZXR1cm4gc3RkX3JlcV9jb21wbGV0ZTsNCj4gDQo+IFRoaXMg
aXMgb2RkLi4gd2h5IHNob3VsZCB3ZSBzdXBwb3J0IGFyYml0cmFyeSBTRVRfQ09ORklHVVJBVElP
TiBmb3IgY29uZmlncw0KPiB3ZSBkb24ndCBzdXBwb3J0ID8NCj4gDQo+IE90aGVyd2lzZSBsb29r
cyBnb29kLg0KPiANCj4gQ2hlZXJzLA0KPiBCZW4uDQo+IA0KVGhpcyBpcyB1bm5lY2Vzc2FyeS4u
Lg0KSSdsbCByZW1vdmUgaXQgaW4gbmV4dCBwYXRjaC4NClRoYW5rcw0KDQotTmVhbA0KDQo=
