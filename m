Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D86D4469800
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 15:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245670AbhLFOKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 09:10:33 -0500
Received: from mail-dm6nam08on2070.outbound.protection.outlook.com ([40.107.102.70]:37308
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S245598AbhLFOKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 09:10:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ygj/CO8C4MZTpBpdXhmzj0YWNue0uNsYTUMp9bh987LIbbRL8cD0MdkurBypiGxUIU/b7kog8w8/lvZkrrHn4ZPsG70YoXmrCL7OVfcnQbyln2hkN3t9XbOLAX+59fRBw6BXz88/IHCQtKzp7gTXXRg514O37v9Z7kyT9+FHEw3Q6QsWSMQS3VJhESVlGTyPC2ElMdNrwK0F3euyX1IPzpwJlKxxBhWVdnHn7orZPJIKFF2CCQmeHQUWaww4Cm9cmfrwwZKqTqjr3JzyjcH+/KLjhUc/MxHTcHpr2psBM1lFhN0O5Q2W0ihLehPs68fYJrnChVtLjZEkauH2t7zJ1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bUwhfwsxtOJNa1ae3LMSii+KCEw60M3OhMXM2HVWQJM=;
 b=ThbB8S+IGdYGjIPEzjrNvAA29kpDt61ZAbZYCfJnaWjB4xypN7rMPY9Gv0/Zkh8zAWMzmYNjbPeyFI/Tr/2iDyhRoHTrukeFPQKmicTpmTvVoVaMUbUhZjyhOOrQN1lPZCqZukJCauFNAyT/ThIQvBvyZi5yqFm5HMyVe/mccf0uVcKdfGg5722gPJK9DlHwXmE+tbnNSug6ytuciamiG4xCF+2twGQ7M1RkDvAmJPXY61xhDA7JQv3i6eeM1f5LmOpmo5Ts2KiWYRVo9MeOutx4AT5rFIV3txeMC1wk8mO16kAbUDwBQzbs4dc292+OtNo1ODg5uZVNU2dr+50OEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bUwhfwsxtOJNa1ae3LMSii+KCEw60M3OhMXM2HVWQJM=;
 b=EkWV9+Yn843gQzQGgXlUCz0A6JvK9S0UHzJnDcQtUX23kJNcpeLKJsft+DKNd5ksUBpVsyb6qJzxVxmon7k3a9WRSKjgqzHgRVZVmhtY4d+zXHSZCkdAO/36yGY2GbVCXdnAJ0PwN75Alh3TwnyO1EACZkP3QgFT0FY7lOBdkN36E+FQw5WBx3aMhobcJBBRnWmng4MzHA3QKtjWWsAWrDkrP7xi14hjPpNwA9gZEUWLfTmxomRUY+o0KnpQnz2MOjL7l3iF9xODm3H1dXm0QQo5MMlJZcU3LPKgpSF7a1CqrFfeB1fTdF5ve4X8x3fvfRB25MOldRuYm3zoTx9dbQ==
Received: from DM5PR12MB2406.namprd12.prod.outlook.com (2603:10b6:4:b7::23) by
 DM6PR12MB4106.namprd12.prod.outlook.com (2603:10b6:5:221::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.21; Mon, 6 Dec 2021 14:06:33 +0000
Received: from DM5PR12MB2406.namprd12.prod.outlook.com
 ([fe80::5926:d2bb:5b4b:1b99]) by DM5PR12MB2406.namprd12.prod.outlook.com
 ([fe80::5926:d2bb:5b4b:1b99%6]) with mapi id 15.20.4713.031; Mon, 6 Dec 2021
 14:06:33 +0000
From:   Prathamesh Shete <pshete@nvidia.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Aniruddha Tvs Rao <anrao@nvidia.com>,
        Suresh Mangipudi <smangipudi@nvidia.com>
Subject: RE: [PATCH v2] mmc: sdhci-tegra: Fix switch to HS400ES mode
Thread-Topic: [PATCH v2] mmc: sdhci-tegra: Fix switch to HS400ES mode
Thread-Index: AQHX54N9NcX7kZCj8UGkcwuX7RZCaawfRIsAgAZAROA=
Date:   Mon, 6 Dec 2021 14:06:33 +0000
Message-ID: <DM5PR12MB24060A90DC0DBB154FD75123B76D9@DM5PR12MB2406.namprd12.prod.outlook.com>
References: <0a8368f9-8ca2-f01b-2f9e-0c91e3b946f5@intel.com>
 <20211202134948.18448-1-pshete@nvidia.com>
 <bf629e1b-c61d-37e7-8802-b6d778f89c21@intel.com>
In-Reply-To: <bf629e1b-c61d-37e7-8802-b6d778f89c21@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5aff401c-d3b3-4ff8-9ca2-08d9b8c19c0a
x-ms-traffictypediagnostic: DM6PR12MB4106:EE_
x-microsoft-antispam-prvs: <DM6PR12MB4106ECAF5C20998D629825F8B76D9@DM6PR12MB4106.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lm6kBcPenwoKtO6kaB53wIhNLrlnJvqsJHWdmo+1k6VXXlZSZaPfefQfxMwCQnj8J3/PXsASWQ00PdWTx5m/pKLfa61SjaDIsX0yNdC1nDniOGEFomXF3O0nDTfFYBY5zPwruNT+SxTS9ucHD4WVh06uXMUoVJLnybpRuf19LpwlTNmGzC2CBvuqDjSgEmwEtorep5J+Z/E6WDCPS8zc0RlA+ddVyNZtThRa+gJ66HdUAqp/QcDXH1Pt+KllFFSYubZcDmg/oa3OR8SrkCImtxhzmiG5NgBQ1e4zg5p77tSkwJ3ApR64YEspb2Rl8EMRGYl6weyxaZ342ue3CJVxy5RwbOmNVqcngMI98xQrTxVyqfPOMBlwHzgTseeQ5MGi6vK6lM1jCriE5LvCwXwiRnEX23hs55H9n0qhoayeGouio30XpuoSh1OFYAI2gJnmKfvrIQRruNwrqACK77pT6XUshDJfmOy0nK6ySjjwyw8YsONnlK+7pndQ1K4evZSa+oJx9TtiJQHkag13ErGJOB0gSKe3MOp09hgJmfZEx2jdoQOSLT3cLCWAr+oTfBJrSjl1MGRfMvf7SqepoiyZ2SmrEuKz5ub5ene5jxrYNcEev3MgrxswqlTmoJU/0Ol9k2pAsM1M3soqyTMvK5OaJYmIrJ5F9RDi+CjaxedOmfIZ4s3wAukSOhc82mryQ8C0yPKFw8Ox/NcTR3SyYIbM+A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2406.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(83380400001)(66446008)(8936002)(4326008)(53546011)(55016003)(2906002)(122000001)(38100700002)(66556008)(86362001)(316002)(64756008)(66476007)(38070700005)(66946007)(7696005)(9686003)(110136005)(26005)(54906003)(52536014)(186003)(5660300002)(107886003)(71200400001)(508600001)(33656002)(8676002)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VGNRNzhQd3Y0SXJvUjJSNGtFeWIyUWRRR0tML0pURnYyK3VVK2VGWW9iTDdD?=
 =?utf-8?B?MHZYTi9wVWdicS9jOXlqSmFoR09kWHN2M3NNSjAwQjR1bmJHbDFBT01iV3NO?=
 =?utf-8?B?MVg5dHBoK2d4dTBTSU9lSFVJS3ZTRFZSdjhURXVFTDRyalZFQXVHblp1bWxx?=
 =?utf-8?B?UTl1Z2svNmJHTjlrZ1VFRlVUckM4cFE4SmJuS1pwdTU4RXI2bVNIYy9JaVBq?=
 =?utf-8?B?bjVFaVUxT20zcHBMSGYxUUU4UDl2akJaTm9XVU9CRjFNbG50OFlRSkhONEZJ?=
 =?utf-8?B?MFhiQkZQSmNZaFYwWWFQR1NYdzY2L1Q1RXlQdVFrYzhJbEpGZ2FTZkJmS3lW?=
 =?utf-8?B?eDFET3djc2ZseEVmbS91NTNCVk04eFNPdE9EYkZVUDlmd3ZJalplWkJ1Skhx?=
 =?utf-8?B?WTdOR3RFbitzQ2JjVjc2anp2UThEQXVJWno1aUtiVlMzYnZiTGJKaEJ5aG5M?=
 =?utf-8?B?NXp6TUwyck84UW5OcFcxYkhSWE1ROTBxYkc1S2h5ZjJhNERBOWRFeWNzQWhw?=
 =?utf-8?B?MzNvZ3hnSGRBcFV5cFRIc3BYa1kvNVlDc2duL3FtY0NyZUNXemgzL0sveGF3?=
 =?utf-8?B?TkpJaGVIeTdEdjFROVcyQlc2OW1LUlVNdXBkMEQxeEtqWDFySkoreWk5M2hy?=
 =?utf-8?B?QjA4ZUpmMlV6NGJ6b0kvM0pyUm1zYU5MK0x0elBYTkd0NzdNVVZHck5JY1dE?=
 =?utf-8?B?RmIyR01aRDhydU9OMmFMNDhhUEVJNWFFN25BZXd6MDRLTS9VdThSVy9GVDU0?=
 =?utf-8?B?S2N5aFl1bE90U3hsM0w0amJzUTk1RUtTWWFsYmxqRlNha1RGNks0SEpHdytD?=
 =?utf-8?B?Zm1aanRkZkFITUhRMmgxNmNkcnJMUkdESUZKTXNOTUYybjVmQ1o5UnZGNERD?=
 =?utf-8?B?VWdCS2NZejQ3UWpHSDNPSG5mZWZFVWR6WHI3VmczeU1IZzZEdHppVXZvTTFV?=
 =?utf-8?B?VnZweWhOUmVxQkpiVmNiZGtLSEhkRFFvdzVDZnBURk82RUd2OS9jV2xCVC96?=
 =?utf-8?B?eVo5bzFHZTFSYVRTelc4UlFXVjJwQnBPeWIwWGk2K3FRc2ZTVnRFUnRCRWNq?=
 =?utf-8?B?M29WenN6QnpXNjVwVm16NXh3TkQ4YlNYaTVRRVZLUmhiRFZZTDFSc0c5Szdz?=
 =?utf-8?B?MnRKb3lCMHp5Q29Uc3NrNTZPcjVZRUVKdHhYSW8xTnhLeGNLU1ZGNmVWRTBx?=
 =?utf-8?B?cnlzZVZjMnh2SGQ4RFcybUFjNkVIaEVkVXNQS0Z4elV5Rm1mS1R3aGVGVGQ1?=
 =?utf-8?B?eDdlM1NaL09CUDNlTzN4a29ZM1krYXJtbXhnRVk5dUJicURPNytxYUZDNU90?=
 =?utf-8?B?ZGovSTBxU2VzYnpBK29XQ3ZhdnRGVjAyZnVnUHA4T0N6Zy9IYWo4MUpMeWph?=
 =?utf-8?B?RW80d0tqTDFGTUN0K2ZjMHpYbW54RG1DbGdKVFU4aDVyUVpoTGpHQ2ZlU3dT?=
 =?utf-8?B?NjF6VHlRQ0RWcDN6MjE3T2U1WDdHN2thSnJhb0RMSGtOL2YvSWNubU53ZUhx?=
 =?utf-8?B?ZzF2Z3lwNzVZSFJyNDlZSjRsSThIcmhVaEE3RXpUalNhVVRqVTVEV1ljWEwz?=
 =?utf-8?B?TEh4Wmc2cFVFV01rZVo0TlhHK05PU2pRdEplMmxGZXl6SHNqa1N3aWdHazcy?=
 =?utf-8?B?Q3NhYXBCUEk2UHVQRGQ5ZkM4VzhzektjQmdUVHI0R2dGUUlEaUlVS0RxZGw1?=
 =?utf-8?B?dGFQNDdFSXNDRHhZYjJGYk9od28vY29BWVRkbjNJcTJvRjd6ZnVGd2NYU0xG?=
 =?utf-8?B?ZzZ2M1dTc2VBYlExNUZFTG12dnlxT0lQM1Ewc2VnS3NFRzd3R0Y5R3pnNDU1?=
 =?utf-8?B?UFZNcVB2Ui9xcjBKbGdwSEI0dU12NlFZMDNCRU5xWDc0bjFLSWdHZHZsS1Nl?=
 =?utf-8?B?NmNmRHR2enlicHg5bS82Vmw1blB1ckxkbWRESUttdGE5ZDUwT2RjMGtNTmJj?=
 =?utf-8?B?NGNPNllNUEFucFVKSmxFQ3F2VmlER2k4T2czZWpBM2ttU3RWYWxweEVRUUlo?=
 =?utf-8?B?bldUZEE3ZmR4T0FIME95bVRiemZHMWtMM25OSU9GZDJxK0hzNmNja1ZUTTEx?=
 =?utf-8?B?V1htbFdycmc5amwrNUxYTDlvYkxiWXVqTXl5ZjFmQ2RFTGFFa3lzbUsxT1Rm?=
 =?utf-8?B?MGhRQ0RXWU9VMmR1YlF6VWZHY21aL1JkTDRyczVIR1lrVE5xU3JwUmxaTGhm?=
 =?utf-8?B?cGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2406.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aff401c-d3b3-4ff8-9ca2-08d9b8c19c0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2021 14:06:33.4106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TtvOeaP1Da44gOmKcPIDbHd9skxoW8bQSDyxM5EKIG0WlNKxDb6gxwm+Gk0bX4XqOH+TalowNDY9NpIAbk7YgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4106
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmtzIGZvciByZXZpZXchDQpVcGRhdGVkIHRoZSBwcm9ncmFtbWluZyBzZXF1ZW5jZSBhbmQg
UHVzaGVkIHZlcnNpb24gdjMuDQoNClRoYW5rcw0KUHJhdGhhbWVzaC4NCg0KPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBZHJpYW4gSHVudGVyIDxhZHJpYW4uaHVudGVyQGlu
dGVsLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIERlY2VtYmVyIDIsIDIwMjEgODowNSBQTQ0KPiBU
bzogUHJhdGhhbWVzaCBTaGV0ZSA8cHNoZXRlQG52aWRpYS5jb20+OyB1bGYuaGFuc3NvbkBsaW5h
cm8ub3JnOw0KPiB0aGllcnJ5LnJlZGluZ0BnbWFpbC5jb207IEpvbmF0aGFuIEh1bnRlciA8am9u
YXRoYW5oQG52aWRpYS5jb20+Ow0KPiBwLnphYmVsQHBlbmd1dHJvbml4LmRlOyBsaW51eC1tbWNA
dmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gdGVncmFAdmdlci5rZXJuZWwub3JnOyBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IENjOiBBbmlydWRkaGEgVHZzIFJhbyA8YW5yYW9AbnZp
ZGlhLmNvbT47IFN1cmVzaCBNYW5naXB1ZGkNCj4gPHNtYW5naXB1ZGlAbnZpZGlhLmNvbT4NCj4g
U3ViamVjdDogUmU6IFtQQVRDSCB2Ml0gbW1jOiBzZGhjaS10ZWdyYTogRml4IHN3aXRjaCB0byBI
UzQwMEVTIG1vZGUNCj4gDQo+IEV4dGVybmFsIGVtYWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxp
bmtzIG9yIGF0dGFjaG1lbnRzDQo+IA0KPiANCj4gT24gMDIvMTIvMjAyMSAxNTo0OSwgUHJhdGhh
bWVzaCBTaGV0ZSB3cm90ZToNCj4gPiBXaGVuIENNRDEzIGlzIHNlbnQgYWZ0ZXIgc3dpdGNoaW5n
IHRvIEhTNDAwRVMgbW9kZSwgdGhlIGJ1cyBpcw0KPiA+IG9wZXJhdGluZyBhdCBlaXRoZXIgTU1D
X0hJR0hfMjZfTUFYX0RUUiBvciBNTUNfSElHSF81Ml9NQVhfRFRSLg0KPiA+IFRvIG1lZXQgVGVn
cmEgU0RIQ0kgcmVxdWlyZW1lbnQgYXQgSFM0MDBFUyBtb2RlLCBmb3JjZSBTREhDSSBpbnRlcmZh
Y2UNCj4gPiBjbG9jayB0byBNTUNfSFMyMDBfTUFYX0RUUiAoMjAwIE1Ieikgc28gdGhhdCBob3N0
IGNvbnRyb2xsZXIgQ0FSIGNsb2NrDQo+ID4gYW5kIHRoZSBpbnRlcmZhY2UgY2xvY2sgYXJlIHJh
dGUgbWF0Y2hlZC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFByYXRoYW1lc2ggU2hldGUgPHBz
aGV0ZUBudmlkaWEuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL21tYy9ob3N0L3NkaGNpLXRl
Z3JhLmMgfCA0Mw0KPiA+ICsrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0NCj4gPiAg
MSBmaWxlIGNoYW5nZWQsIDI2IGluc2VydGlvbnMoKyksIDE3IGRlbGV0aW9ucygtKQ0KPiA+DQo+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktdGVncmEuYw0KPiA+IGIvZHJp
dmVycy9tbWMvaG9zdC9zZGhjaS10ZWdyYS5jIGluZGV4IDM4N2NlOWNkYmQ3Yy4uY2EyNjFjY2U5
YjM3DQo+ID4gMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS10ZWdyYS5j
DQo+ID4gKysrIGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS10ZWdyYS5jDQo+ID4gQEAgLTM1NCwy
MyArMzU0LDYgQEAgc3RhdGljIHZvaWQgdGVncmFfc2RoY2lfc2V0X3RhcChzdHJ1Y3Qgc2RoY2lf
aG9zdA0KPiAqaG9zdCwgdW5zaWduZWQgaW50IHRhcCkNCj4gPiAgICAgICB9DQo+ID4gIH0NCj4g
Pg0KPiA+IC1zdGF0aWMgdm9pZCB0ZWdyYV9zZGhjaV9oczQwMF9lbmhhbmNlZF9zdHJvYmUoc3Ry
dWN0IG1tY19ob3N0ICptbWMsDQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBzdHJ1Y3QgbW1jX2lvcyAqaW9zKQ0KPiA+IC17DQo+ID4gLSAgICAgc3RydWN0
IHNkaGNpX2hvc3QgKmhvc3QgPSBtbWNfcHJpdihtbWMpOw0KPiA+IC0gICAgIHUzMiB2YWw7DQo+
ID4gLQ0KPiA+IC0gICAgIHZhbCA9IHNkaGNpX3JlYWRsKGhvc3QsIFNESENJX1RFR1JBX1ZFTkRP
Ul9TWVNfU1dfQ1RSTCk7DQo+ID4gLQ0KPiA+IC0gICAgIGlmIChpb3MtPmVuaGFuY2VkX3N0cm9i
ZSkNCj4gPiAtICAgICAgICAgICAgIHZhbCB8PSBTREhDSV9URUdSQV9TWVNfU1dfQ1RSTF9FTkhB
TkNFRF9TVFJPQkU7DQo+ID4gLSAgICAgZWxzZQ0KPiA+IC0gICAgICAgICAgICAgdmFsICY9IH5T
REhDSV9URUdSQV9TWVNfU1dfQ1RSTF9FTkhBTkNFRF9TVFJPQkU7DQo+ID4gLQ0KPiA+IC0gICAg
IHNkaGNpX3dyaXRlbChob3N0LCB2YWwsIFNESENJX1RFR1JBX1ZFTkRPUl9TWVNfU1dfQ1RSTCk7
DQo+ID4gLQ0KPiA+IC19DQo+ID4gLQ0KPiA+ICBzdGF0aWMgdm9pZCB0ZWdyYV9zZGhjaV9yZXNl
dChzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCwgdTggbWFzaykgIHsNCj4gPiAgICAgICBzdHJ1Y3Qg
c2RoY2lfcGx0Zm1faG9zdCAqcGx0Zm1faG9zdCA9IHNkaGNpX3ByaXYoaG9zdCk7IEBADQo+ID4g
LTc5MSw2ICs3NzQsMzIgQEAgc3RhdGljIHZvaWQgdGVncmFfc2RoY2lfc2V0X2Nsb2NrKHN0cnVj
dCBzZGhjaV9ob3N0ICpob3N0LA0KPiB1bnNpZ25lZCBpbnQgY2xvY2spDQo+ID4gICAgICAgfQ0K
PiA+ICB9DQo+ID4NCj4gPiArc3RhdGljIHZvaWQgdGVncmFfc2RoY2lfaHM0MDBfZW5oYW5jZWRf
c3Ryb2JlKHN0cnVjdCBtbWNfaG9zdCAqbW1jLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgc3RydWN0IG1tY19pb3MgKmlvcykgew0KPiA+ICsgICAgIHN0
cnVjdCBzZGhjaV9ob3N0ICpob3N0ID0gbW1jX3ByaXYobW1jKTsNCj4gPiArICAgICB1MzIgdmFs
Ow0KPiA+ICsNCj4gPiArICAgICB2YWwgPSBzZGhjaV9yZWFkbChob3N0LCBTREhDSV9URUdSQV9W
RU5ET1JfU1lTX1NXX0NUUkwpOw0KPiA+ICsNCj4gPiArICAgICBpZiAoaW9zLT5lbmhhbmNlZF9z
dHJvYmUpDQo+ID4gKyAgICAgICAgICAgICB2YWwgfD0gU0RIQ0lfVEVHUkFfU1lTX1NXX0NUUkxf
RU5IQU5DRURfU1RST0JFOw0KPiA+ICsgICAgIGVsc2UNCj4gPiArICAgICAgICAgICAgIHZhbCAm
PSB+U0RIQ0lfVEVHUkFfU1lTX1NXX0NUUkxfRU5IQU5DRURfU1RST0JFOw0KPiA+ICsNCj4gPiAr
ICAgICBzZGhjaV93cml0ZWwoaG9zdCwgdmFsLCBTREhDSV9URUdSQV9WRU5ET1JfU1lTX1NXX0NU
UkwpOw0KPiA+ICsNCj4gPiArICAgICAvKg0KPiA+ICsgICAgICAqIFdoZW4gQ01EMTMgaXMgc2Vu
dCBmcm9tIG1tY19zZWxlY3RfaHM0MDBlcygpIGFmdGVyDQo+ID4gKyAgICAgICogc3dpdGNoaW5n
IHRvIEhTNDAwRVMgbW9kZSwgdGhlIGJ1cyBpcyBvcGVyYXRpbmcgYXQNCj4gPiArICAgICAgKiBl
aXRoZXIgTU1DX0hJR0hfMjZfTUFYX0RUUiBvciBNTUNfSElHSF81Ml9NQVhfRFRSLg0KPiA+ICsg
ICAgICAqIFRvIG1lZXQgVGVncmEgU0RIQ0kgcmVxdWlyZW1lbnQgYXQgSFM0MDBFUyBtb2RlLCBm
b3JjZSBTREhDSQ0KPiA+ICsgICAgICAqIGludGVyZmFjZSBjbG9jayB0byBNTUNfSFMyMDBfTUFY
X0RUUiAoMjAwIE1Ieikgc28gdGhhdCBob3N0DQo+ID4gKyAgICAgICogY29udHJvbGxlciBDQVIg
Y2xvY2sgYW5kIHRoZSBpbnRlcmZhY2UgY2xvY2sgYXJlIHJhdGUgbWF0Y2hlZC4NCj4gDQo+IFN0
aWxsIGRvZXNuJ3QgZXhwbGFpbiB3aHkgeW91IHdhbnQgdG8gc2V0IE1NQ19IUzIwMF9NQVhfRFRS
IHdoZW4NCj4gaW9zLT5lbmhhbmNlZF9zdHJvYmUgaXMgZmFsc2UgZS5nLiBtbWNfc2V0X2luaXRp
YWxfc3RhdGUoKQ0KVGhhdOKAmXMgYSBnb29kIGNhdGNoLiBVcGRhdGVkIHRoZSBjb2RlIHNlcXVl
bmNlIGFuZCBwdXNoZWQgdjMuDQoNCg0KPiA+ICsgICAgICAqLw0KPiA+ICsgICAgIHRlZ3JhX3Nk
aGNpX3NldF9jbG9jayhob3N0LCBNTUNfSFMyMDBfTUFYX0RUUik7IH0NCj4gPiArDQo+ID4gIHN0
YXRpYyB1bnNpZ25lZCBpbnQgdGVncmFfc2RoY2lfZ2V0X21heF9jbG9jayhzdHJ1Y3Qgc2RoY2lf
aG9zdA0KPiA+ICpob3N0KSAgew0KPiA+ICAgICAgIHN0cnVjdCBzZGhjaV9wbHRmbV9ob3N0ICpw
bHRmbV9ob3N0ID0gc2RoY2lfcHJpdihob3N0KTsNCj4gPg0KDQo=
