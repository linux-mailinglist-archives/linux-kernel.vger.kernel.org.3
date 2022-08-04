Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27ADF5896DD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 06:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237885AbiHDEXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 00:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232713AbiHDEXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 00:23:43 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B4C2B187
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 21:23:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RCk4voRfuuRmi0wd1E66rPCIXc4JjEQvWWJBblSVXmun0doN7dcLcYsBSnpXwe7ww31UYTHgqTog+ULmwnqzTkgf8H36/yNGb1K7j1Zr4TuGGgNhR1b43wjxi2Z1tWOCqD2ufx1p/V5YOT4M2YrYogKAaipJ+9Zvzeuzp5q2VWiTmsJrZh8ooMLQrBKc1TZNZ2cnrKrPDzHr2tzhrpHajCjeicdtmR2kYby90yxKgveFnfAWPGcnXxsKRi+A1ipcI72pIrY0CdZAU3OJVyp9XXcebRMRh1/bUn52DLHDR8V43fmM6ZSlddu9v7sZ+UBcXMlgXyAs4xKvkS/nPHlldA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZNyjtnzhrHM9621Bhoe45V/EfafG6RNwN1qHgYW9cdQ=;
 b=DYNNSEyRHPz9x1c48aHIdk5wPAQnV09ZoLLZX0CSEGp/ax2bKHAer4yAcCQSBnF8YaLpVMTro3R/q8VNTi9Nazg1oGrexmACdjekLbgTxAqUmrHMIAlCsyJJe01DryCMKgg3+uaaPOos9OqgompuLXx0Tpmov2ylNcjwn2YNbmsUmSKq2m4+YHHlDgpcVWiyRscxQ/+QAOBC83Rlk8MjpVyTr57NYQt1GmClPx8qIg4oivEmF9DBvvxQ6tvHfQigOk+dBTIZjhhiFyTqM9IMqUPZmhLHUHOix/L0/fHhDd4pKZa10XaJDTQAZf+2vvMpRUXO2ECPPNTqgLwQs/K3sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZNyjtnzhrHM9621Bhoe45V/EfafG6RNwN1qHgYW9cdQ=;
 b=XWNnNij3Z2N9SCWY07qJFMIH0HcrinDf8qyjBUsakMg5/vzZ/njCvQsInvN1cd7+lENKzeSFJem+Oh3wpjoqhansW5Q47O19Z0FRYHodJ0vubxjT5M9RnPgOr0I5TH1tMHkwl3kVsyn/RmuhpB4g/mdo/a6aTmXkYnSh5off9yY=
Received: from DM6PR12MB3082.namprd12.prod.outlook.com (2603:10b6:5:11b::12)
 by BL1PR12MB5032.namprd12.prod.outlook.com (2603:10b6:208:30a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.15; Thu, 4 Aug
 2022 04:23:38 +0000
Received: from DM6PR12MB3082.namprd12.prod.outlook.com
 ([fe80::a166:9cab:a5c2:aeec]) by DM6PR12MB3082.namprd12.prod.outlook.com
 ([fe80::a166:9cab:a5c2:aeec%6]) with mapi id 15.20.5482.016; Thu, 4 Aug 2022
 04:23:38 +0000
From:   "Gupta, Nipun" <Nipun.Gupta@amd.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "maz@kernel.org" <maz@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>
CC:     "okaya@kernel.org" <okaya@kernel.org>,
        "Anand, Harpreet" <harpreet.anand@amd.com>,
        "Simek, Michal" <michal.simek@amd.com>,
        "Agarwal, Nikhil" <nikhil.agarwal@amd.com>
Subject: RE: [RFC PATCH 0/2] add support for CDX bus MSI domain
Thread-Topic: [RFC PATCH 0/2] add support for CDX bus MSI domain
Thread-Index: AQHYpzRdLG2bJxxHpkeffhpkvC40JK2dOMGAgADsa8A=
Date:   Thu, 4 Aug 2022 04:23:38 +0000
Message-ID: <DM6PR12MB30824B2FBB5C2FA685EB8707E89F9@DM6PR12MB3082.namprd12.prod.outlook.com>
References: <20220803122655.100254-1-nipun.gupta@amd.com>
 <846c663a-5999-977b-8a69-89c8ca522cea@arm.com>
In-Reply-To: <846c663a-5999-977b-8a69-89c8ca522cea@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-08-04T04:24:51Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=58de2edf-a1da-4032-bf6f-c9642d757b44;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1c5f2531-099e-42c3-82b8-08da75d11ad4
x-ms-traffictypediagnostic: BL1PR12MB5032:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1IzCU6iwXj4fDAZqEmo+OUYE5mV2Pz2fXg1GiqHavLCcy+d/4ejlBTMCX3UJAQRdJfu8eioyWtPsYAW6t4jSs1aZgqpH2HwRqgBuZAuhrVrnw6J5m+vTSLHETddDAaXJXaWbBgxOsb+sFszcJKYdiiWPr03wWS6fV8VfR7VgeT/BnRI2WBOgajf8VClrDO8fwsi8ZGNocgGoCJnDjeIvsPSmNtkM+Mf5pcWDvlVpEdKGXbLfVf9qpltwcHu6tDIlZlkQTsHpkjd95cQUpKYCBBFsRkjpZcpwfMwys7RI/3co1PY/7kQJ7ALKmMZstEvpAu9tZ8DSP1kkURhY57ZSeUkP4JPnr8ZmiNAQit8maBKsnH0a1kOC2c/mxRCyfooXUwEp/P4Azl5Gw6ZGSaENdaJPYbvAJbVgfRUvS8QsNI1/dVdi9fiNTMoAiej7JgMlYlqVy06gG0V2xwyiE/9CqStbpA+SQimNaR9kZ8zSRZy5f23O3wik+8Wz13UsXsPiAYEmFMlg5pXvR30qTwpQfyYTxDmSHVRiQ8rUqZMOgZACPMe28H4Zll1YjOIOqcM0yVBXJa1XkpWkQOA3dOzxhaCZGo7PPsvdCPdNxGrRXoAtwV0htJbaYVLF2eSRY6H6N8qrkXvrZlQ8OIs2VIBeJjNg9PPS46Zxr0KWZWyly5H78m5KFtWDA9lQ7zB8Uc97nL+yLFoZaDKwl7hCXeDnT7Qsi2n/vI4LTt7LkkAtfy29Tk6fLRAmS5er1y3IDkOCyCjdme3V9sydSe6arGGtQXxJ9LYIQuXm//xPj29ix30/f7Vqa6BppYnCZTAMp9Qq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3082.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(346002)(39860400002)(366004)(396003)(186003)(122000001)(38100700002)(38070700005)(83380400001)(8936002)(52536014)(64756008)(8676002)(4326008)(66446008)(66476007)(66556008)(76116006)(66946007)(55016003)(5660300002)(2906002)(41300700001)(478600001)(9686003)(26005)(7696005)(6506007)(53546011)(110136005)(54906003)(316002)(71200400001)(86362001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZWUxZGNvd09GaDJnbTF1UmJVd2IxWlJTU3UzcVREVForOU9YUWRYY1JXZnlu?=
 =?utf-8?B?cXlrNGJQbUYydFhBL3YwbnBBU1NqU0NUR1FJcnRRRlBaUEZHT3UrZEtaU0x5?=
 =?utf-8?B?ODI1Z0pGWDJyd1hGRmVVUG9jTGZ0NTNLK0tUS05QaXIyUnVrenFMbWZmaGpT?=
 =?utf-8?B?MUk1bXBiTHh3eW9CYkZ1UnpLc2JFa1hlWkhpc0JObnpCbVJuVXhvVlFaTit3?=
 =?utf-8?B?WkIzTldwMTZOTjQxNWRyU3E0MWhQRE5FUzRicDNiUjNxSStFaFhyTmRobklQ?=
 =?utf-8?B?ZXROUW5rby9IMk9PL21HcWRkNUpycVdiaHlpOXhxRHV3eWNEdXpNUTJGT3VM?=
 =?utf-8?B?STdJeFJFd0taQktScm9aaWo2bzcyRGtQMW1aTWl0QVdJc3o2RlVYSWRRQUpv?=
 =?utf-8?B?aHcrbGdkVjBxaFlnVjh2NGU3aEZoRml5NkkyanVWL2xTejFkT0pBeGZxVjYw?=
 =?utf-8?B?VWdiL2lxVnhMSTF6Mk5SY2lXYVlPRGl3enRUWHhlRS9PVS9yaEhWNkhTYjRy?=
 =?utf-8?B?TG9OSktPMXYxOSs4ZGdtOVpCNk5paXlUY041MWlZTGg5NlljMVJGOTdaY0RP?=
 =?utf-8?B?K3FYU3FyZ1ZSaVFnRDNRRkwxQ1JOR1V6TXNnelBUNHV6eG9GSzhvQVIyVTli?=
 =?utf-8?B?dFltc0tZRExxdXo4cHpTTThMSFQvVm9ta0ZONk5aZzVINlQzdVNoYlJBNlpR?=
 =?utf-8?B?a0lFWTBGTzlZaFNEdGMzSlJvNmxiSWNWMFlKRDhmWjBNYmF5YWh1Smh2ZWNp?=
 =?utf-8?B?eTlIRWliSmhkOVRGdG1lcTVRY2M5K1o4QjFhcmVZaEVTUnc3K3hVbExpbHJG?=
 =?utf-8?B?RzVUcVgwdTlXNnBlYjFmU01MMHpoMktoOEc2a2FqbTVtWUVXVzdDUkhERlhm?=
 =?utf-8?B?bFpkUDcvMmxPdWNnWG44TVZRanREL0VMY0svQzRMYjF2WGZUOXZRSmhNaXJ0?=
 =?utf-8?B?U2dVaGZ1Q0VyRHlDczMwRnVRTi9NV0hTM3Z3NFltbmwwY1dWWFIxanBqWDZU?=
 =?utf-8?B?dVJXd1E1c0h4bk9hK2ZKQi9hMWwvYnVNWE5UNHNZODh1amJrakU5UkszZ3lS?=
 =?utf-8?B?OEhFQ3lOVHVnWUJObkVSS25hTTM0cXczRmxUelk3Y3JoL0grU3N1Y0xha0Fa?=
 =?utf-8?B?VWpLZElPVG50dXVxVjlKUUh1TXR3ZXlCNUk3TlUyRXovcDVvZDFzRUR6N3Jj?=
 =?utf-8?B?b2tyWXlGWjk4cXcyR3hIcGloUFY2ZEFLdmNSWFIxMWlSc0t3M1F5ZEZ6TUJ2?=
 =?utf-8?B?eG4zckVWSXhleEM1cFNPYjRlYWdZQmhQZ2ttWGNJZjlKeGp6ZDdnQXoxNVNT?=
 =?utf-8?B?ckl3MGxxMVB6Qk5lc21LV29lUW5CR291RW0rR3ZmTG5CNkVLUjd6cVpHZjZJ?=
 =?utf-8?B?b3NZM0lDci9oeGVjQVdGdG1jdzBVNElRMVFVYzlqNkhFRHJyUU9rVEpYUmUx?=
 =?utf-8?B?WkNHbUM3MnpFZzFrN1pYOExCQjIvTU9Jam13M2pxOTM4QnRJV3pxTHBnV0or?=
 =?utf-8?B?U2ZNeDBscGJFTVdReUdReFBqT0NhMWRRUlNFcSsvbGt6OGJjT0FkVXpoaDNM?=
 =?utf-8?B?K2o2S3lPRVRvbHZZUUR4dlBBQ2ZKcW4vQXFoQkhpdHUzSHdEZmswN0FZaXI2?=
 =?utf-8?B?RHJIRGlINWxqaDdtQys0ZllJTTZTeWlPeHVrblhPL0dsTFF6NlFvQ0d5T3RM?=
 =?utf-8?B?U01kRVVncnZwQmNudms2cE9oUjNpN0ZrWVh5NkR4ODdocFZnay9jQlFGdnJm?=
 =?utf-8?B?cTJKWldSMGJhRDRsYXIyYlRScGc4ek1pOWYyUnFkQzkyRkh1alZGNlVic0Nl?=
 =?utf-8?B?N2VicllOVzV4TG05VTRWbmtxOGxwN2JGQXo3MEpVdk5WUUI2bjA3WitaOFBq?=
 =?utf-8?B?eHBwTVlaNHlaTzliY2R5RCthci9UNXZIL0U0eit0Q1J6MXZmL2lnS1lPbVIv?=
 =?utf-8?B?dUdxbktuRTB6R2FPRmUvNW40K0lZWUZxSVZFdlM5OEM1T01HYWszWUszcWt4?=
 =?utf-8?B?Rm9KUkhTSmhCOHFqb1hSdFhVcHJ6c2JBUDliejNoNGdHSXlwZmxIU2JleHpK?=
 =?utf-8?B?TXFBYkpvODMzNEZBYjliMXczQ21wcDc2WDFPZVE2bHplNlNwbkJRUzE1eVNH?=
 =?utf-8?Q?CNfA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3082.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c5f2531-099e-42c3-82b8-08da75d11ad4
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2022 04:23:38.4627
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qQaPVQ1RrGc+n3qSNNkDxHEnCKJ/VIgg3WGq6Iz4F/Enqt1viNqKZVOJN5lNc6E9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5032
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IFJvYmluIE11cnBoeSA8cm9iaW4ubXVycGh5QGFybS5jb20+
DQo+IFNlbnQ6IFdlZG5lc2RheSwgQXVndXN0IDMsIDIwMjIgNzo0NiBQTQ0KPiBUbzogR3VwdGEs
IE5pcHVuIDxOaXB1bi5HdXB0YUBhbWQuY29tPjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
ZzsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBncmVna2hAbGludXhm
b3VuZGF0aW9uLm9yZzsNCj4gcmFmYWVsQGtlcm5lbC5vcmc7IG1hekBrZXJuZWwub3JnOyB0Z2x4
QGxpbnV0cm9uaXguZGUNCj4gQ2M6IG9rYXlhQGtlcm5lbC5vcmc7IEFuYW5kLCBIYXJwcmVldCA8
aGFycHJlZXQuYW5hbmRAYW1kLmNvbT47DQo+IFNpbWVrLCBNaWNoYWwgPG1pY2hhbC5zaW1la0Bh
bWQuY29tPjsgQWdhcndhbCwgTmlraGlsDQo+IDxuaWtoaWwuYWdhcndhbEBhbWQuY29tPg0KPiBT
dWJqZWN0OiBSZTogW1JGQyBQQVRDSCAwLzJdIGFkZCBzdXBwb3J0IGZvciBDRFggYnVzIE1TSSBk
b21haW4NCj4gDQo+IFtDQVVUSU9OOiBFeHRlcm5hbCBFbWFpbF0NCj4gDQo+IE9uIDIwMjItMDgt
MDMgMTM6MjYsIE5pcHVuIEd1cHRhIHdyb3RlOg0KPiA+IERldmljZXMgaW4gRlBHQSBjYW4gYmUg
YWRkZWQvbW9kaWZpZWQgZHluYW1pY2FsbHkgb24gcnVuLXRpbWUuDQo+ID4gVGhlc2UgZGV2aWNl
cyBhcmUgZXhwb3NlZCBvbiBzeXN0ZW0gYnVzIHRvIGVtYmVkZGVkIENQVXMuDQo+ID4NCj4gPiBD
RFggaXMgYW4gdXBjb21pbmcgYnVzLCB0aGF0IGNhdGVycyB0byB0aGUgcmVxdWlyZW1lbnQgZm9y
DQo+ID4gZHluYW1pY2FsbHkgZGlzY292ZXJlZCBGUEdBIGRldmljZXMuIFRoZXNlIGRldmljZXMg
YXJlIGFkZGVkDQo+ID4gYXMgcGxhdGZvcm0gZGV2aWNlcyB3aGVyZSBmd25vZGUgaXMgY3JlYXRl
ZCB1c2luZyAnc29mdHdhcmUNCj4gPiBub2RlcycgaW4gTGludXggZnJhbWV3b3JrLg0KPiA+DQo+
ID4gVGhpcyBSRkMgdGFyZ2V0cyB0byBzb2x2ZXMgMiBpc3N1ZXMgd2hlbiBhZGRpbmcgZGV2aWNl
cw0KPiA+IGR5bmFtaWNhbGx5IHVzaW5nIHBsYXRmb3JtX2RldmljZV9yZWdpc3RlciBBUEkuDQo+
ID4NCj4gPiAxLiBJdCBjcmVhdGVzIGEgTVNJIGRvbWFpbiBmb3IgQ0RYIGJ1cyBkZXZpY2VzLCB3
aGljaCBjYW4NCj4gPiAgICAgZGlzY292ZXIgZGV2aWNlIElEIHVzZWQgYnkgR0lDIElUUyB3aXRo
b3V0IGRlcGVuZGluZw0KPiA+ICAgICBvbiBvZl9ub2RlLg0KPiA+IDIuIFNpbmNlIHRoZXNlIGRl
dmljZXMgYXJlIG5vdCBwcmVzZW50IGluIGRldmljZSB0cmVlLCBpdA0KPiA+ICAgICBjcmVhdGVz
IGEgc3lzZnMgZW50cnkgdG8gZXhwb3NlIHRoZSBjb21wYXRpYmxlIHN0cmluZy4NCj4gDQo+IElz
bid0IHRoaXMgcHJldHR5IG11Y2ggd2hhdCBDT05GSUdfT0ZfRFlOQU1JQyBpcyBmb3I/IEZyb20g
dGhlIGxvb2sgb2YNCj4gdGhlc2UgcGF0Y2hlcyB0aGlzIHRoaW5nIGlzIHN0aWxsIGNvbXBsZXRl
bHkgdGllZCB0byBkZXZpY2V0cmVlLCBzbyB3aHkNCj4gcmVpbnZlbnQgdGhhdCB3aGVlbD8NCg0K
QWNjb3JkaW5nIHRvIG91ciBhbmFseXNpcywgZGV2aWNlIHRyZWUgbW9kaWZpY2F0aW9uIHZpYSBP
Rl9EWU5BTUlDIGlzDQptb3N0bHkgZGVzaWduZWQgYXMgYSBib290IHRpbWUgcGF0Y2hpbmcgbWVj
aGFuaXNtIGJ1dCBpdCB3YXMgbmV2ZXINCmRlc2lnbmVkIHRvIGJlIHJ1bnRpbWUgdXNlZCBhcyBh
ICJidXMiIG1lY2hhbmlzbS4NCg0KTW9zdCBmaXJtd2FyZSBwYXRjaGVzIEFDUEkvRFQgZHVyaW5n
IGJvb3QgYnV0IHdlIHdhbnQgdG8gZ28gYmV5b25kDQpib290IHRpbWUgY29uZmlndXJhdGlvbiBh
bmQgd291bGQgbGlrZSB0byBiZSBhYmxlIHRvIGR5bmFtaWNhbGx5DQpyZW1vdmUvaW5zZXJ0IG9i
amVjdHMgZHVyaW5nIEZQR0Egc2VydmljaW5nLiBBcyBhbiBleGFtcGxlLCBhIG5ldyBGUEdBDQpj
YW4gYmUgcHJvZ3JhbW1lZCB0byB0aGUgc3lzdGVtIHdoZXJlIGVpdGhlciB0aGUgYXR0cmlidXRl
cyBhcmUNCmNoYW5nZWQgb3IgbmV3IGRldmljZXMgYXJlIGludHJvZHVjZWQuDQoNCkFub3RoZXIg
Y29uY2VybiBhYm91dCBPRl9EWU5BTUlDIGlzIGFib3V0IHNlY3VyaXR5Lg0KV2UnZCBsaWtlIHRv
IGtlZXAgZGV2aWNlLXRyZWUgY29udGVudHMgaW50YWN0IGF0IGJvb3QgYW5kIG5ldmVyDQp0b3Vj
aCBhZ2FpbiBhcyBhIGdvb2Qgc2VjdXJpdHkgcHJpbmNpcGxlLg0KDQo+IA0KPiBSb2Jpbi4NCj4g
DQo+ID4gTmlwdW4gR3VwdGEgKDIpOg0KPiA+ICAgIGlycWNoaXA6IGNkeC1idXM6IGFkZCBjZHgt
TVNJIGRvbWFpbiB3aXRoIGdpYy1pdHMgZG9tYWluIGFzIHBhcmVudA0KPiA+ICAgIGRyaXZlciBj
b3JlOiBhZGQgY29tcGF0aWJsZSBzdHJpbmcgaW4gc3lzZnMgZm9yIHBsYXRmb3JtIGRldmljZXMN
Cj4gPg0KPiA+ICAgZHJpdmVycy9iYXNlL3BsYXRmb3JtLmMgICAgICAgICAgICAgICAgICB8ICAx
NSArKysNCj4gPiAgIGRyaXZlcnMvaXJxY2hpcC9NYWtlZmlsZSAgICAgICAgICAgICAgICAgfCAg
IDEgKw0KPiA+ICAgZHJpdmVycy9pcnFjaGlwL2lycS1naWMtdjMtaXRzLWNkeC1tc2kuYyB8IDEx
NCArKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAgaW5jbHVkZS9saW51eC9jZHgvY2R4Lmgg
ICAgICAgICAgICAgICAgICB8ICAxNSArKysNCj4gPiAgIDQgZmlsZXMgY2hhbmdlZCwgMTQ1IGlu
c2VydGlvbnMoKykNCj4gPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2lycWNoaXAvaXJx
LWdpYy12My1pdHMtY2R4LW1zaS5jDQo+ID4gICBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9s
aW51eC9jZHgvY2R4LmgNCj4gPg0K
