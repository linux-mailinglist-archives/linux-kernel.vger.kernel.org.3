Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDCBC581040
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 11:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238486AbiGZJqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 05:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238400AbiGZJqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 05:46:36 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39EBB3135F;
        Tue, 26 Jul 2022 02:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1658828794; x=1690364794;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6j0DKf1mBiWhU/v+Xql/UW+xhvY6D+UNwsghA5DY8jk=;
  b=E1B4A3FYNlOvfZ0xxtbyxKesV9AsodyU+5tr/T0fWNfO+tCFam/nGSlm
   4qORsPnQbh02QZ+u6+//ijM63JWa1b5BHlcZkALyj9cfFEmrojk6JQQh/
   tf79JG3yfBTbmi2hkQ8wTv4TBpe78pqWN6VuR21bhl0Spw4/Th261qOFB
   A61/yGd632gXfwdZ5IgTd4N2r3SKFdE7uMSBu+1FbS/dqdirKvzhe5tLx
   Dv9+YW3WuBDYdNWxdUYbT1wfVCEgHEohBVe3cP+l7JjzsUqNmaPjZkm0N
   KBUZTcT+hHT+vrd8HYG8USawxuKT4IgEI/FVGK630wiA5kwdQGkn9SysN
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,193,1654531200"; 
   d="scan'208";a="206915766"
Received: from mail-sn1anam02lp2041.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.41])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jul 2022 17:46:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GZ4rZTiX+JjpjlN/6CPS6b672Ph+1cRIsb+jWlQX0EfLTkeDE4GqE3lBIM3KabmMkeawCUVFj4q88H2uqLU+rOmzARnb98RyzsYVa8ZB9gxBJvVkTnrqgv5NloMZG/n6CZ3DDzyuizz860cbgb00gDHL2W1b2aS7sEa9a4pIziBnlvby48LynFhCfc6fYrJmQQtvAJv2kW+QEnB2njvSu/2h9wScjE4kuyrEjLaqRDCrA5wBbRJQzJxK2joVe7hm0f+8q2bJ4kBvOF83oK5hAyNrx8A6Wsm3aPUCu7KDLQ8ZdFz9lciVfeYvGZk0iq1dwUoSk8DaC46J6BGIoJF9tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6j0DKf1mBiWhU/v+Xql/UW+xhvY6D+UNwsghA5DY8jk=;
 b=jl8RZY1nbL7oLkz7YVzbTDKOq4WUObVqm21o1O6HqqYP6nqA9y28FFLRDOnVWUAg2sbQFPqgqHF/PKjSxGi4LpkkN0y7cFc2sbYL/AH20U6N/r+0K95T271978E41w/q7Utn5VQWx/hDlwLeHe5gKbnLXQK4H38p9N2XDvMZ6F13COde7iaXf4Ji5s3w8U+VTgmJ7Ro0dgzPH6ky2UwayJG0Zz/Otrr2OtUsIoP0gdhKrVsUl6Tn5cH0xA/GYDRabYEOqLVaF67TQCrdqfCrzwZgkWv9DTfgh6yht+8fyUK8AAhqMBJ5JaIzzMaIwmy+a07ZAWCnOx+3JhqThjS9aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6j0DKf1mBiWhU/v+Xql/UW+xhvY6D+UNwsghA5DY8jk=;
 b=t7AzYCRhNWqgLZHPXmjwL8n7yhBlzvxjm9zkdvZU8fX7R7KOZaP2Qzo7+pjviv4+qBPiqJ5f1sBZULbOUaNGrbrwMdp+ii4AupUUPCVN6Q2opIEZz+crTsdDrW0uHoM/UyMIHHL0Z89IOII/nXm9ZgyLuKGJwnfbi07hCoHj7wo=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 BN8PR04MB6419.namprd04.prod.outlook.com (2603:10b6:408:d5::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5458.18; Tue, 26 Jul 2022 09:46:31 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5d26:82d8:6c89:9e31]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5d26:82d8:6c89:9e31%8]) with mapi id 15.20.5458.025; Tue, 26 Jul 2022
 09:46:31 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Can Guo <quic_cang@quicinc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "quic_asutoshd@quicinc.com" <quic_asutoshd@quicinc.com>,
        "quic_nguyenb@quicinc.com" <quic_nguyenb@quicinc.com>,
        "quic_ziqichen@quicinc.com" <quic_ziqichen@quicinc.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "kernel-team@android.com" <kernel-team@android.com>
CC:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Daejun Park <daejun7.park@samsung.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] scsi: ufs: Add Multi-Circular Queue support
Thread-Topic: [PATCH 1/2] scsi: ufs: Add Multi-Circular Queue support
Thread-Index: AQHYmz2OvInxSH8TlUq8qOHvad4nHq2M7bBwgANPhwCAADVS4A==
Date:   Tue, 26 Jul 2022 09:46:31 +0000
Message-ID: <DM6PR04MB65758994ED83A9271BB24D5DFC949@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <1658214120-22772-1-git-send-email-quic_cang@quicinc.com>
 <1658214120-22772-2-git-send-email-quic_cang@quicinc.com>
 <DM6PR04MB65757CEC7F66AB732EF5FC48FC929@DM6PR04MB6575.namprd04.prod.outlook.com>
 <35eb780d-93cf-be2c-deb5-239fad5f3abf@quicinc.com>
In-Reply-To: <35eb780d-93cf-be2c-deb5-239fad5f3abf@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d321316f-201c-4150-4a8e-08da6eebb81b
x-ms-traffictypediagnostic: BN8PR04MB6419:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +pjyr6BrhW3Ms1b1gWc13s1mXR8SYXCdO47bUJPRnEWe/v39jeLjwg8faZjG22EoD3cWGIQH071riNHk8yAdTYNYOaipiknww7Su3d2PiXOPR78CrLDgUIAz7iYEUzT8Nfwgtj0TwOIKK/iB+kh4gvu41mH2th/S2OgMP3cEuLIBzwD6kITVQ+lOPQzjFhsjiGYJn8xEdZyKyQD+mKgKXVqHZGOXlxnR4AilNMOLyu5+YeCUO0TeL/g0AGWqfob2z4eqYTgyzssq2Pcb+/tt8OcrRIKVukvM7VK2Jj3DyY4/V1hic4x6MmV+b65zIOFa1uYles9UnFLo6/hT9ciZvXAKdd3BAoHskEP1kv1KD0lwtSOtXNZdIQyzPNiIW5VsyTqnU/sU1BJz6jTFOgUt7F5Z93fwHGjBR/ADxOxL8Xpr8iSczeMwCvGjoksHMkzpAcAqpC7TTykgEVeSvSjbOitRhirzBRgn/ikmvV+tF5VzoSBZb9AKbhCApgXEiTePEoz+hc83vmHRzaqgfibW5dSrCM3T3bIT1J7Wp+jscmCUlEntYBSBPA8SiWmgo2jZe/2h1W7v/bX+nLa69WfhZydr6mbGbj7RnWlz2gspesNVKVXg5ZzE4Ypm3UO9uX1idSQ67FlL92xBY+K5wkwxPcfFY7/lQyVW9Vl4QvfV5uCd+wTjbLeF2P4aIDBPn6F9bITK2l+nn/LLRoufzpNL8WtPY0zqbWqYQmu1/ll4K/Nmy577iorDPUqEUz9IRERB3K+usBuq6hoYBkE9zUFUJ01n06FSz6o2w+JSyzlooXntXHzu2HAoNpM0cn7ruDT2m0LItfOH3UtaTbgKoNgQOw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(39860400002)(376002)(136003)(346002)(4326008)(76116006)(66556008)(54906003)(66446008)(64756008)(8936002)(66476007)(66946007)(38100700002)(7696005)(8676002)(52536014)(6506007)(4744005)(7416002)(5660300002)(316002)(9686003)(26005)(186003)(71200400001)(122000001)(53546011)(110136005)(82960400001)(83380400001)(38070700005)(41300700001)(478600001)(55016003)(2906002)(86362001)(33656002)(921005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ampjelk5OFNKcE5rOUhOTk5GM0VVeWo4enFNZkNoelpzMTNYTkJ1a1RDamdR?=
 =?utf-8?B?TDlYNmxxdW1pM0JTQU1xRDd5WnZiSEZLYUxORHhLS3Q3bzJJTUZCRDRQRDBj?=
 =?utf-8?B?cnlxWkdiS2lEL2JlcnJ3MFJ5c1BpY3JwTmliU2VYR3FmdDJUNEtQUklrOWVq?=
 =?utf-8?B?Yk81UWdKWHZ2YVU0eXZGUU02bnhMUVprZnBzL0ErZUN5YlJRSFFia0IzWnY3?=
 =?utf-8?B?MDFvRUx4TnFQSXgxTWNKQXMya0d3clhzZ2JJTk14VHN6amdvZnpQN2hzT3dU?=
 =?utf-8?B?bW1XblVORHlhaFpUdFQ4RUw2TTM5RXlSTWNOZjJZUUUybVNQQ2FUKy9tRSs5?=
 =?utf-8?B?eEVDN3pWMkR4OE1zTy9ERVJqSUFNR1pycXNoT0NCT00zSEdReTVlSUdrTEQv?=
 =?utf-8?B?N3VJVCtXc2Y0WmI2VmljM2Y3M1lNSGtDV20vSnc3Y1RENndZS3JqSloyanVJ?=
 =?utf-8?B?WVdEZTdWY2d5UXM0anlDVmdGZUtKSlN6VjViUVhXMXhuWE5MNmN0a1ZHay9x?=
 =?utf-8?B?RTNKL250R01lTDhHZEVOSFZZaWlOcXVVZDNTR1VtS2F0cys2U3JvbGNWdUgr?=
 =?utf-8?B?eDduazhUb3hIVjBmUGhWcXUybnpUNmdjZnV1aCtyRkRlK2JiL1VKMThpNHQ2?=
 =?utf-8?B?bi96Y05TSGU2blBsWmVtMnpna2pGQzFFdmQ3UEp2bVBxbEw1b3RvZzZjNFdp?=
 =?utf-8?B?MzhyRUd1S0EzOEhnNFRKWGlUSlJYMTVaUkVoT2thNnRBTVNjQ21vS3U0Vm9m?=
 =?utf-8?B?SkFEdDNZSGlhcjMyRDlucE5mblIySkFaOXFrcjZkanFiZUJNMGE1QTJDVWw4?=
 =?utf-8?B?OEhoMVpIUUZ0Wmk3Z1hJYThWQXBSOWQreEdFeFpETG9zWTFTckVnbm1aOFE5?=
 =?utf-8?B?dXZGSWlpaHJoYkkrWXBVRjNIV3ZZV2ZOU3FjR0d6cVFpcmxJaVNQN2VVOWdR?=
 =?utf-8?B?VktvZkd4T0hPTU5aWklZanRFaVlLaklOdmIvWmV1WmxBeXU1bHBFWFJNRkt3?=
 =?utf-8?B?Y1F3L1o4WVRyRHBMdzJ2V1htRHdEQ2FUMExDL2NtUU5nZHVTUWRnTSswTVcz?=
 =?utf-8?B?cHp4K2dndk1WSjgwTjVWbWtYcVdWclZqWFZ2VE5vV1VNUFVib2F5clJvTyt4?=
 =?utf-8?B?YUpqVnVsYlFxU2RwQStQSWRnRzArU0lGNmIyaDkzN3doWUJQN2Y5UVJvTERP?=
 =?utf-8?B?Z0RqY2V4NVZFU2tVaVJrczZBUGJpVWhRNGNRdTRaR2M2eTlpWGdZTm1pVmd3?=
 =?utf-8?B?WVBsOXE0eDErM2NFUlNVTUZYQm0wRGRxTUhsQktCWGh6V3pRZGJQTGcwVU43?=
 =?utf-8?B?RnEyeS9ZT2hPZEZJMXJZcWlDVXRoVFFFZVJGTE9qZVNPVTEvdWQ1QVNUdHla?=
 =?utf-8?B?UzZ2bkxOMW5ZNFUwVldTVW13TElEcXowQnRvbVNxeUVuL0RGUUMzbWR0WmNV?=
 =?utf-8?B?NTJSSmRneDYrL3F0RGZuUzZ1UnRDenE0Wk1RUHBQTDJpbHJ2N09od2d3WEMv?=
 =?utf-8?B?bmk4RlpYR3BWT29OMHg4d05CMGdKSmlQNXVJMTNlbTNacURNZWxIa3dpZlZr?=
 =?utf-8?B?Q3NUZTVFQTBraFlYbGY1RnkrVW1jSkprdEUrMVk3cXU1Zkg4US9NYkxobUpp?=
 =?utf-8?B?TjEzeS8zSHdUWHRoMHNlb1VVcXBLU1phK2hIOW5YV05MemVQaE40YW1PdGE4?=
 =?utf-8?B?T2Fyd09VRmdLTUZHVkZRYWJNQUJCMmVKTTVZZUNUWlcrU0JxaTBQRmVObGpW?=
 =?utf-8?B?TGI3TVA5M0RJeTkveFJoLzA0R2ltcXNsN1dQUzRoeDV0WG9hSzJhL21JN3ND?=
 =?utf-8?B?aloyM1loWXhwZlVqMkNEc0NoNjRsdGNVb2dVUnZUYWVUL21mZTRJWkRxMWdn?=
 =?utf-8?B?SEJ6V0tqUG1EOTVDRU9uVC9mdVhLUU5TL1BHbWdkenRqdTNnUFNjY1ZiNFpH?=
 =?utf-8?B?VmFUN1BZdkhTQUtwcGhnLyt0S0x4YjQ2aENBL2dkZUV1dkdzTkw0RHFtaSt3?=
 =?utf-8?B?Zm5oYmtkcHB4RjNJYXZPdENsU2xRMmVneURQVG5ZRE5VK2lRdGg5T1FXbzJD?=
 =?utf-8?B?RldKbkpMMWdOWVdJTVltUVh1dVlaVkdNR0JxSmYzMU8xWDFhZVY5emdGdXpD?=
 =?utf-8?Q?sJfDi99FCZts92JN41dDQ/Amb?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d321316f-201c-4150-4a8e-08da6eebb81b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2022 09:46:31.1043
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CVX6A/aiCbDd/Jdk+RvLQTxT5fU4Kq5qLy/MWb5qYJdfzHE9tqCm6kYdTq2GCqoUrhfEVOc/pvcx5MbFcDaFWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6419
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBIaSBBdnJpLA0KPiANCj4gT24gNy8yNC8yMDIyIDEyOjA3IFBNLCBBdnJpIEFsdG1hbiB3cm90
ZToNCj4gPj4gQEAgLTI1NTgsNyArMjU4Nyw4IEBAIHZvaWQgdWZzaGNkX3ByZXBhcmVfdXRwX3Nj
c2lfY21kX3VwaXUoc3RydWN0DQo+ID4+IHVmc2hjZF9scmIgKmxyYnAsIHU4IHVwaXVfZmxhZ3Mp
DQo+ID4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFVQSVVfVFJBTlNBQ1RJT05f
Q09NTUFORCwgdXBpdV9mbGFncywNCj4gPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgbHJicC0+bHVuLCBscmJwLT50YXNrX3RhZyk7DQo+ID4+ICAgICAgICAgIHVjZF9yZXFfcHRy
LT5oZWFkZXIuZHdvcmRfMSA9IFVQSVVfSEVBREVSX0RXT1JEKA0KPiA+PiAtICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIFVQSVVfQ09NTUFORF9TRVRfVFlQRV9TQ1NJLCAwLCAwLCAwKTsN
Cj4gPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBVUElVX0NPTU1BTkRfU0VUX1RZ
UEVfU0NTSSB8DQo+ID4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKGxyYnAtPmh3
X3F1ZXVlX2lkIDw8IDQpLCAwLCAwLCAwKTsNCj4gPiBUaGlzIGlzIGZpbmUsIGFzIGxvbmcgYXMg
d2UgaGF2ZSAxNiBxdWV1ZXMgb3IgbGVzcy4NCj4gPiBPdGhlcndpc2UsIHdlIG5lZWQgdG8gZmls
bCB0aGUgRVhUX0lJRCBhcyB3ZWxsIChvbmx5IGlmIGJFWFRJSURFbiA9IDEpLg0KPiA+DQo+ID4g
QWxzbywgZG9uJ3Qgd2UgbmVlZCB0byBkbyB0aGlzIGZvciBxdWVyeSBjb21tYW5kcyBhcyB3ZWxs
Pw0KPiA+IE9yIGF0IGxlYXN0IGFkZCBhIGNvbW1lbnQgdGhhdCB0aGUgcXVldWUgaWQgZm9yIHF1
ZXJ5IGNvbW1hbmQgaXMgMC4NCj4gDQo+IEFzIHBlciBVRlM0LjAgSkVERUMgZHJhZnQsIEVYVF9J
SUQgb3IgSUlEIGlzIG5vdCByZXF1aXJlZCBpbiBRVUVSWQ0KPiBSRVFVRVNUL1JFU1BPTlNFIFVQ
SVUsDQpDb3JyZWN0Lg0KDQpUaGFua3MsDQpBdnJpDQoNCj4gDQo+IHVubGVzcyBteSBkb2MgaXMg
b3V0IGRhdGVkLCBwbGVhc2UgbGV0IG1lIGtub3cuDQo+IA0KPiANCj4gVGhhbmtzLA0KPiANCj4g
Q2FuIEd1by4NCj4gDQo+ID4NCj4gPiBUaGFua3MsDQo+ID4gQXZyaQ0K
