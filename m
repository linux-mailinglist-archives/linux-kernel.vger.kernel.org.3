Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21BFB47A43B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 06:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbhLTFPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 00:15:46 -0500
Received: from mail-cusazlp17010000.outbound.protection.outlook.com ([40.93.13.0]:14409
        "EHLO na01-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229437AbhLTFPn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 00:15:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MTIe5ojaYfvxyRTkcuo/7sfGFm6alqOhT4wKGwOjLk9PYMWJxb+bcvSj2V4rPXvLZ6/JOjuNujkD3FF+IgLyxrHSqdGhw3R6j7QOhFxDyLGdgT5Yakm88hTE/W613p6CtMNRNJUjRwKfzNPp+wDQ5jboNPGZazoBc5X7xutXIbkpjuqpq3mh6A2Isfl3+9hFB8rdWVeVdnt8jLjabLI/m8utUBqtpvyTorkUQjIZYaodyj5DVnB5cKvS6a/Z4dLVy9AatLqRPkqeS2Lc7CVHmBEyj04WI76UbvmTI8xfsEvDMBvfZ9Bv4CJlhaRqrKqPvooj1T088CWOFJRQpWJ2GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eBo4+IqyIP3/QKBbyJQETQBm23WbbDNhXnlTfanXgYI=;
 b=LYy9G1GgoQMqx0F3mP4DpLw4ZDlSDzjbKIbWRlCeZBStO6H8FKkBW2TUXH6aiK+taaUDjkhA0P2L7uAvv2bf3lnfvS/g2aUBgAVP6Fj723nJLmyf17NJrMiBtf7m9GiZJC2GuxPGOCIm8lWHPPyOdDO8isUBhsJVrzX9iiue6HAN71dV5nKehwCVBoRgovKWchercY41Ziuy08OC9fSx1eCGM1QrycDGcBrdZwXOcwppUNYjBlObPZwfa99AG/K918dg5AeTuhnze8Ss/cXQfIZsgt9M82e87Z4g1jn4ULwZ3uAt1Ap1ANavkOuWLVAq8jRyBqsyyk5TzKwNY5YVZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBo4+IqyIP3/QKBbyJQETQBm23WbbDNhXnlTfanXgYI=;
 b=a4ux3Wayk8NhAXUhjLlbkal7EJILsdqyCBTNHAmqg5tzo92yxWZjRmIQl4QaNj30MK6jfgmNxSF8t5xfioksX7t4irbEMxu8iFpqZFIeKyIY1pAOsaZIekvlmpPgfusLj4bwYc6+QGO0SiGLCk/DUAYd1q9w9BpjvJ7JCkDzM1Y=
Received: from BYAPR21MB1270.namprd21.prod.outlook.com (2603:10b6:a03:105::15)
 by BYAPR21MB1366.namprd21.prod.outlook.com (2603:10b6:a03:110::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.3; Mon, 20 Dec
 2021 05:15:40 +0000
Received: from BYAPR21MB1270.namprd21.prod.outlook.com
 ([fe80::9904:180b:e610:fd83]) by BYAPR21MB1270.namprd21.prod.outlook.com
 ([fe80::9904:180b:e610:fd83%4]) with mapi id 15.20.4755.004; Mon, 20 Dec 2021
 05:15:39 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Jens Axboe <axboe@kernel.dk>,
        "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "hch@lst.de" <hch@lst.de>, Long Li <longli@microsoft.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: very low IOPS due to "block: reduce kblockd_mod_delayed_work_on()
 CPU consumption"
Thread-Topic: very low IOPS due to "block: reduce
 kblockd_mod_delayed_work_on() CPU consumption"
Thread-Index: AQHX9OjnI2iGAQwSWUqnCtF9yw5sM6w58EYAgADmHHA=
Date:   Mon, 20 Dec 2021 05:15:39 +0000
Message-ID: <BYAPR21MB127067C16809209C019BC83BBF7B9@BYAPR21MB1270.namprd21.prod.outlook.com>
References: <1639853092.524jxfaem2.none.ref@localhost>
 <1639853092.524jxfaem2.none@localhost>
 <7d1e4bb8-1a73-9529-3191-66df4ff2d5fe@kernel.dk>
 <12f43a71-713b-a74f-a169-b6ac3d804e50@kernel.dk>
 <237bd7d8-9e75-01b5-ebe7-8b1eb747474b@kernel.dk>
In-Reply-To: <237bd7d8-9e75-01b5-ebe7-8b1eb747474b@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=6c721139-468d-4776-a06a-c0be155fe172;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-12-20T05:11:53Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a87a238b-3db9-4e4d-7410-08d9c377c34e
x-ms-traffictypediagnostic: BYAPR21MB1366:EE_
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <BYAPR21MB1366F5BCBE117356AE0704A1BF7B9@BYAPR21MB1366.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gqbfOFzHeqLc6YHUxpnwQwoUGt1tn0/f584iUy7F5jRPqtvdZeDPjKeDJ1y7dkKX0tyBFkvm8dNfMOqobY0sZzR9aUzjSs4f+mKd9iizWZwdVMVi0URwsrPpx7Pt66I5g1vz9JibHm9S1yjzl4M81sk7ZMnlDpGKZASW5gu7I+fv2yS3g449c4/JLqDNQ6uW/Or0IGYLhGBbpaiB94ys0+HZotKafhuulLlkE2SmoDQRx5uBvlJHwhU/sDHGM+8KuAHjYah3laZjLIiwjhhs8ToZlvEcxrnLfS1eYCZDlLCypzF3ECJr5Nr2rkf+PqjQUCF+yajdMeMCCJJBLpEg8/toeMWdSvuqFBDQCAzQPjHgLV+GJLSKAiHPI1HSbT/wZD2a2vv/kvrat1SBqFjOG1cblRF3oCiuztph4efB24loV94FyvKFIYLwFu3tb6P/iUeMPXNj4D7QguDpXDTgday0sIKA22oeEzJ3LsY87+2lhYztNg488yybXdbg4QzwPvS7JTpGz4Wi99c93+I98givbDbpXnBJLqbbnp84C/O+uMH1WwZ/okLP1xHZNOpHz2LJR4RtYsyOamNnjvpmBox/KVCWuviAoR1JB71V/n2Y9mcOyR8vuAHg1dV1v/yjBZYtPtVlXc706ULyA3Dxc2akP+jBVQqgWdeTU689lXIG5a0L0hyCs5cUg+vmz0Ex3Jt6TCHE/GPiz/RFgiWUka5cTVdvy2VsqEH4G5qSFlSjRryxBDCrhGM3jGa5V+VH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1270.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8990500004)(26005)(4744005)(2906002)(186003)(9686003)(33656002)(5660300002)(55016003)(6506007)(508600001)(7696005)(86362001)(10290500003)(71200400001)(38070700005)(122000001)(38100700002)(66446008)(64756008)(66476007)(66556008)(52536014)(316002)(8676002)(66946007)(110136005)(8936002)(76116006)(82950400001)(82960400001)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OWIyWUNOSGNqVncwN3R6UTVjeUlOYi8wRGpEK1BqM0RPcmExMU5RT3NKY0xu?=
 =?utf-8?B?SDZDRkh3K3NoSUUyTm5oci9KUFRQRitPVXNRcUt0eVBSRDZwVUtqVHNJTzF1?=
 =?utf-8?B?TUs5dmo2T2lldVJoRTkzMkJmdHZrM1Jmdlg1eE5vblR4R255czJHbEhoazZv?=
 =?utf-8?B?MHF4QkpuV283a2Rab2ErcDBiM3NHYWFFRWdZeEtMWTlRUFVHYzFoc1lDN1VO?=
 =?utf-8?B?ZE1seDlyU3huN2VIRlRCTEJ4ZFI3ajdOdWljTTFFcUdrbGFFVHdaWndMWFRT?=
 =?utf-8?B?NUQrcTVMTkFVQTU2TmtiTUoyNmJreGRwUGdpdzRTaitlYWJ3U2ZGZS9SY2k2?=
 =?utf-8?B?a01tYWRER3BSKzhiVldTMXlnSWtpNW5EV2pHbVkxNXlnQ09ObTlINUg4ZlRP?=
 =?utf-8?B?QksrTmg3RnlmUHpiL1ZXaEpEV3lGKzRMaEJvRjI4TlB6NERpZHdIbmF2SXF5?=
 =?utf-8?B?dDJlQkNSMkE0dzNvQnFORkZ4TkY2WU9vc0sxWHMxRS9BSnJ6czJTVUhzbDlC?=
 =?utf-8?B?bEpmSXN4WG5SQ09RQ090UDU5Sm9SeC9TMDBrUDVhcXhaeFNhcFVYVEV3L09I?=
 =?utf-8?B?cUVNT1lNQi81UG9MOHVPaGZiRzk5bytzbmdzT2N5Q3dmMFplYkdZVVh5ZHRU?=
 =?utf-8?B?N2dXZzI5cU8xWnVaUWpQb3JsYVZFbGNUK1l4d0lJOWRocWNtUEZadUkxc0VT?=
 =?utf-8?B?dlU1dXhxM2FCQ3A0MnJzYkJJZG5HRmNwT2hObEMwMEo2aG5qbEpESGptOFNZ?=
 =?utf-8?B?aDA5K3NTYXRwYXdaRzQyYnQ5YytRbW9vVUFuMG5MVUQxYm5yVWIzLzVuMitP?=
 =?utf-8?B?N3lXVSs5cmNFaGF2V2F4cFkwTzVWN2JLYWtCbmEyZmxUQ0o2QmxLbzE3dmU0?=
 =?utf-8?B?KzdjN20yZmpQWGJ5TmJvY09nNEpNdUlZOXM1RndGczNJSkVVY0RoaUZJRlpS?=
 =?utf-8?B?OGR5NVhNQ1lTeHRuY3MxRyt1Q2swNlBhR0wxWDRydTIzSUR0TU0zckQ3aEwz?=
 =?utf-8?B?Y3liVUovK0lNd1B3ZEttT21jVWxHcHpjd3J4VmpuaGpUOEdWYVhHYzY0ZFpj?=
 =?utf-8?B?ZUIrcWdvaXN2ZW5IbEZKWEZaME02L1c0UFI4bEM5NVR3N0trOHlsYXBZUjVX?=
 =?utf-8?B?TjAwRUZOMVhoNndUd3dRUWxCYmRtTGcxRjg4UU5wS0pqTTFualRidDEwTFQv?=
 =?utf-8?B?VDlhUlo1UmpDK1NIM25uZXpWUEZ3R29Iam1XT3FIN1EraUhuUjRVMXhDTHlR?=
 =?utf-8?B?U0xrS29mczVZVlMyREJLRHZVTitLcnBYeVJ5ak1JTFU0amNYUmtDNTc0UDlp?=
 =?utf-8?B?RnFxVFJnVUFkSW9BL0xuaFNxNkE3Vndub092QVpoOHNhU3Myb3kvd1ppcks4?=
 =?utf-8?B?RkpVZjRVc01pNlovZHBtemJrK0Y3a1dYMXVkM3hFODJESEUvNVdnaUU0S2xq?=
 =?utf-8?B?cUtGNURBdmhGQlBmclRoRXNCRzhiU3RBNURwT3VPc3JLbndCNk9tWWJtRUdM?=
 =?utf-8?B?SVViUVF2dS9xYTV6MXRScG0vdFFjaTJTbVV3c1dnT3BpOHg2UjdNWFhQamtU?=
 =?utf-8?B?OTNNam1jalRDbVQwMklabVBmaGtEamxuWkZLaERNclV1cEJrVHlZS2NpS2g1?=
 =?utf-8?B?NFVuSWkxWVdLbGF1NG9uMkYzWFpoQWs5UWtHbjduVUtYaGVBRjhtOC93WFA5?=
 =?utf-8?B?SHplT3l5andBdzIwZVpOcnFBYzlpRW5FV2o0SXAyZ3U1bHlWZXpWUWs3a1Iz?=
 =?utf-8?B?VEFKRkhFOXM1WFY3ZC9neCtlVElQSlFDZmtlTEdwSEtQNnc2aE5VaFh0TXFR?=
 =?utf-8?B?bEdNSHZlbDdTVEx2WFB4d3ZPWDUweG40eFovWHBGN1lkQmZLbHBneWhOVFZQ?=
 =?utf-8?B?ZHZxT01jZDFwUnFUbVB0Q0pveWJxdWgwaTlSNHB5RDJxMU1nSEJqWHNQNmVs?=
 =?utf-8?B?MFdxSFFrT2lucDFqMW9oYjZBajBpZWkxeVdtTVBQbW1YV1hCZ21ITHVoMldi?=
 =?utf-8?B?VW9PeFIvYklxRHgvL1ErL1AwaW03N2h1VEF4b29oMXQ1TzA3U2VZcldmdzgv?=
 =?utf-8?B?NU4rUHM3YkN2SU9uWU5zdXl4UjNTa2kwc3VzT0p3ZDRWQ0hZQlR2aU5tRUNa?=
 =?utf-8?B?aHNFRUtMR0xVQkdjbmJ2OUcxY3NkYzYyUTZRNmxoSm5KdUcrMFFDazZvcEhh?=
 =?utf-8?Q?dGoMt41weD7bJOe9ellXT0o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1270.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a87a238b-3db9-4e4d-7410-08d9c377c34e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2021 05:15:39.3459
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fe31Ih7h42Bd8CMuHZ5tgA9LV8/ZetVP+iuq2k9eZVKhqwiBGFELTqNpRCGDYIa5pVlbzXtpxGFOs0jKqz0qAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR21MB1366
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+DQo+IFNlbnQ6IFN1bmRheSwgRGVj
ZW1iZXIgMTksIDIwMjEgNzoyOCBBTQ0KPiA+IC4uLg0KPiA+IERleHVhbiwgY2FuIHlvdSB0ZXN0
IHRoaXMgZm9yIHlvdXIgdGVzdCBjYXNlIHRvbz8gSSdtIGdvaW5nIHRvIHF1ZXVlDQo+ID4gdXAg
YSByZXZlcnQgZm9yIC1yYzYganVzdCBpbiBjYXNlLg0KPiANCj4gVGhpcyBvbmUgc2hvdWxkIGJl
IGJldHRlci4uLg0KPiAuLi4NCj4gSmVucyBBeGJvZQ0KDQpIaSBKZW5zLCBzb3JyeSAtLSB1bmx1
Y2tpbHkgSSBsb3N0IHRoZSB0ZXN0IGVudmlyb25tZW50Li4gOi0oDQpJIHBpbmdlZCB0aGUgdXNl
ciB0byBzZXQgdXAgdGhlIHRlc3QgZW52aXJvbm1lbnQgYWdhaW4sIGJ1dCBoZSdzDQpvbiB2YWNh
dGlvbiB0aWxsIHRoZSBiZWdpbm5pbmcgb2YgSmFudWFyeS4NCg==
