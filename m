Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5192351FB05
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 13:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbiEILOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 07:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbiEILOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 07:14:11 -0400
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30068.outbound.protection.outlook.com [40.107.3.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999261A35AE;
        Mon,  9 May 2022 04:10:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YgH9GYlBCt31VHDtNFtKJAoGkvFjwhRKlI1857ckzjxgnU1gLSDF2dsYK5u2EX6cht5i8yhpLr5yX52JfrCjPeRFiHAn4h/6dWB1X2VrAYRrWugMvXZGzrL4l3iEFN1PqsgW+pNQk/QSw7c6dlmSSVmqMO7vIL8OIBFLjl1B6ytSOPkoQ3HgB6hvFEsvRPp3PUP3SdEGc7tMAMW3/mPzZxbAn6/EuMlC1j433rJ9IWcEuYS4yCm0ExGaBZSelkwTntJzcVlmz+XwAIni42/IRFYiK0qZepHLujUQnPzcXdMu9qHeiBsP8j44w8KALhzDGWgtWWmLfB8iQhp7neodmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vP1LCeTDlFK/Atv8qjbroPED65y0TDP6ThRA/ZUHGXs=;
 b=MygsgRlMoAKngJgD6vF4Eud1q2sIGW9Ah94vdYnLHgQoejVo+K5SAVR3OBRGTfoZ5dtDPpOLOaHgD9VodnuJumMhRIXciSxCzYh7YMGnPtUiemrKB5jyuZacjj00JC/pqu6fhP8RPQR6iVzGCQhz/II96lU/lkhACis+HGxqYVoNVzvK2tHW6x7pxl6z+PibDYcqlCMcp5f7YyrOiOPwSKrz/8uc2tNw/+we0QrZTilPDBDqfoZ7MiMbpl1VJ8JIbGad3PdqhDFDGab5RHKWwjgPmVWKqomNr+JTTDG1v7mCEdelgZcEf4noiL1ju0257W11w3xYkA3SJoXQL1r/jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vP1LCeTDlFK/Atv8qjbroPED65y0TDP6ThRA/ZUHGXs=;
 b=AauisdzOcyBmYXubmWn4tba0fj4exRwY15IYruaSzcFZm8HV4BgW2uTyVCcSXHBAUVE8PfvkQJnvI1fCGHdh0j+Y5yM42bKqfoI75KqFUK9VBaGepGngEahFg0UowOSz9sXpI7Uhrn5z7ymOEbyAtAQbnStXgifCIUQCVfMSX76bdyQw0uRbMXruUxY3PCP3Mp9+cmuSwcXtap4z/eVDKFiC9sD7wWsglWmT6I4SPe7nGlm1DVp6uriZDUtsoISiwouJuXFwxwR/s+vtuc73GZkOBn0sfBEFMKt9FrYMIrnXAn8D3VKUGFUFejM3xBmtaVqmv56+xlp4ePKIhKf4fw==
Received: from DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:395::21)
 by AM6PR10MB2391.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4d::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Mon, 9 May
 2022 11:10:15 +0000
Received: from DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::99a1:b485:c2b1:7ee0]) by DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::99a1:b485:c2b1:7ee0%3]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 11:10:15 +0000
From:   "Starke, Daniel" <daniel.starke@siemens.com>
To:     Jiri Slaby <jirislaby@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/3] tty: n_gsm: fix invalid gsmtty_write_room() result
Thread-Topic: [PATCH 3/3] tty: n_gsm: fix invalid gsmtty_write_room() result
Thread-Index: AdhjlRMIVmb4Tg5CTCSzps6ed3Fctg==
Date:   Mon, 9 May 2022 11:10:15 +0000
Message-ID: <DB9PR10MB58815BA44641534DAA6646B6E0C69@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Enabled=true;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_SetDate=2022-05-09T11:10:13Z;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Method=Privileged;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Name=restricted-default;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_ActionId=8f3bda23-a8ee-4697-8ad7-7297d3490242;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_ContentBits=0
document_confidentiality: Restricted
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dc1ac8a6-ed75-4a03-1da3-08da31ac7e6f
x-ms-traffictypediagnostic: AM6PR10MB2391:EE_
x-microsoft-antispam-prvs: <AM6PR10MB239144BCBACF45F04AE1F7E1E0C69@AM6PR10MB2391.EURPRD10.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xvfm6HwiVRZZzVG+X+8Yhb1AOFX0BrvM3ZxkiBXFb4B6AE3L397/yaq+zCcCnelpbNzYx7gD0ShLQd+21LlhTFz/Mdm4p9aF9bm4pcw3tNZm+C00An4DetYVkybdAVP2lf2yJdPorx6tjgEPIjt390XA17I9NKTplI088q0YYb+4FL2NMHGXntSY95kcenw5rFAWCrbo8mfYvdmOjYQN8oN9c8Ujd3ZuXzZ5NpNXfF/Yd/PYCjc2jgqvxgmdiVDA1h+oRpD+P4VFhhhUywOsQom9AjOMY5PdbI8VcYc+Jo8BCcpsTpf8siJ+GDQdUD3k2wBfYgT/TISRcAamy+1VdhTQ+TvepNkO623bqHu7oNGywvEhbI2ICUVtFN4JnVjCSoK5UlgsARWU6dS3j8vcI7NytOOCx5dV88de4fHISi6oG6D6SVmsK2hJltdX7OBLNdn8baZRgTPXPezG+y7zgTmIUZP1ROtoUmnjUhJBbPSzBYG6TsBE+CJCrB3sd/tnuCN+wPRuu9xJ2oFv1i2+B21ydfd3HxNDbgGmSpuzju6doxv+M+CWpCyK+4Xq4o7tNea7g6oXx+91HWKxF+CjGufV1p5/QGN2ZqfNQDXaEfKXHMSEbTVbHnrAPcv5BQHCKitQfqzV32ODEGpzlQAkQlJLPMgfi2i+nYOcgRB+U6xteNIMwkV/sZjgF3e9h15LBUZD6ZuCabX701jnaK7Fvg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(33656002)(316002)(26005)(9686003)(7696005)(186003)(55236004)(110136005)(6506007)(86362001)(4744005)(55016003)(52536014)(508600001)(38070700005)(38100700002)(71200400001)(82960400001)(122000001)(66476007)(64756008)(76116006)(66556008)(66446008)(8676002)(66946007)(4326008)(8936002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZC9PZzFZZXVpaWhSSU92Umd6UkNGdG5aWjB1VFg2ZHJ5KzV6MVFJbHg4NEVi?=
 =?utf-8?B?RjZHWnJFaFlqSG9KTGc0UjRuaFpYc3EvdDhKQTBYZHRSUDlZYWwydVVLbU90?=
 =?utf-8?B?cjJHN0o0dllVcFZUUWMrWi81OTVsMmRXYVVmdTlOR3Q0MkRCSEEvUHRiWGhM?=
 =?utf-8?B?a2pWUWFCdWhZRzYrWkVaaGZvUDZqbVJobHFCSzlJVFQzMkxBOVFFem5NYmkz?=
 =?utf-8?B?RTRRNUlSS2JrVlhBT2Y0R0M2L2p6NHpGYjcxVXp4aUo4Z2xwVEpHSWE2bHBu?=
 =?utf-8?B?TG10S3JKMEk3VXNVWkl2Tmd2VFhycHFTSE54ODJPcUh2V0lteXFpa0tjY3Nz?=
 =?utf-8?B?MXlrTGlWbTVPSk92d3hBK2lwMFNadGNOcDlLZVQyV2Q3dEd1SWpIYXVUM01n?=
 =?utf-8?B?MG1VY1BtM3FNeXNTMmZMRDlvemlmTDVyMThpNWlVbWhVSThKSXFDNTdjampF?=
 =?utf-8?B?ejVFdzZSaUNoNW1XMkEzZ0VHdHFlL1hPTVV2ZndPcnNZWklUUmE5OW85bjZn?=
 =?utf-8?B?eFZOQllrdVBhV2dLaVFHNzZkN0F4dndHZmFNYitEUTBKY2RiNVB2U0JmdnhC?=
 =?utf-8?B?OTl6WDBwc0VyemdpVEVXTmN1ZmJVNzBlcE9NanI5bTFZenlFUWVpWnFQTW0z?=
 =?utf-8?B?bXpwbU9CQzZJem1IK1BkQ2I5cTN5QmZXdHRUdWRhT25hUnZ4eXVOZXduL0FQ?=
 =?utf-8?B?dmFTMjhrUE41aUlVVXN6MGxuQmZUdnZldnQwSktTZTk2dm02TU9RUVpUcjk0?=
 =?utf-8?B?bG4vRTQvWk93UHZmbkJJU1RRbkNGT1FHKzdoWHl2Rk16cHhRYncxZWdXQ0x5?=
 =?utf-8?B?V0Fub3hySEtiQy93WXpDZkM1cDhOOTI0cnlQZHJEOXFQR2pDVWxZdk9yZms3?=
 =?utf-8?B?c21GRXljUlJqYTVYUEhnNGt0ajBJbm1mTytqVlJURFNMaElCYVlxN29PVVJN?=
 =?utf-8?B?ZHM4bi9vQTJXQmZYMHBmaHJOU0haOXhJVDkzRGhSVVcvR3k1dS8waU03TDhE?=
 =?utf-8?B?eFZNdmh3VTZPQXI2am5FaU1rMmtXelpoVENSQ1g5WHZIc210WjlsS1ExR0NS?=
 =?utf-8?B?aHJDS29PS3I4YUxlQ3g2WHRqWHV4dGVXMmxEOFZGelVqZis0YnhiYnVnY2xT?=
 =?utf-8?B?Y2JzMWtBbUQvcXVURGdmaE5hVWljMkI1dlpIc0hSUU5OVklCSyt1Z2RsRnh3?=
 =?utf-8?B?bDR1Si9vT2YrdjRlVEtUU2MvbFJ5aElVZjd5UnhwczV1cnVFZU9vMU9vQ082?=
 =?utf-8?B?dVE0UnJLeC9uTy8wcFpsZ1ErVmpGN3FvNzFHemRMVERDMGZJQktFbFhEYkt2?=
 =?utf-8?B?QUZyNS9lMmp3bTJOempFL3I0aHRZb3IzMXQ3L2VkRCtlcjZQUlpuWHB1YVhD?=
 =?utf-8?B?aW9pc3dqL0dNbkw2OHluZFJkM1k2SkVCMHF3RUppTzdVODllK3ZUdzNxbDF5?=
 =?utf-8?B?cS9VcHh0WG91ZkRuZENLaFR1K3BZUHlJOU1ReHhTWlhmNGkraTVKTVg1Kzlk?=
 =?utf-8?B?QUNQcjZsMWtIMW1tSFFTOGN0K2RDZ2h5dmhaUlNXOHpEVGFyVUE3YnJjTkRz?=
 =?utf-8?B?aFRmTDZTbUQ0NTdlZVhYOGNyVUN5L3l3Qk9OS2psVXBvYVgrWXF4SG0vbHFo?=
 =?utf-8?B?VTdYNDRJMW1UNkhIU3ZqQ0JQRXMyaTQzQTNmL3N3VlVJSUlheDVPNFRSTUJG?=
 =?utf-8?B?VGczcXFVNDYzOFR3WHBsTHNJbkVIUmtBZHlwcHl4YW55dk1kU2ZSeE1NQmY1?=
 =?utf-8?B?aUJLQjUxUGdsU3ZZOGw1RnpGbDZuaW5vcTZkV2NDVVV0aHZ0RGNmVkVJcnp3?=
 =?utf-8?B?Y2NpUWNsTk1nS05Fb2VXdXg5cjNGbHRqUmduYmYyVDJKb2JSYXR1MklGZXJS?=
 =?utf-8?B?bVNYNHNNckhVT1BkbW53SzU0bGFmV0p0dXRpdFdQc0tOZzBWRzRJTFlhekhr?=
 =?utf-8?B?TW5BZjJkZjkydDlnVFFmaVo4cVNBZ2IzeVFnOFQrQm9Ta2Y5VDl6VndFVnZm?=
 =?utf-8?B?ME5KMWdXY1VWOTR3NGRkNThhemhIdnIrbWQwTGJTdCtWdU1MYS83cVpHd0Nz?=
 =?utf-8?B?aHBRMnA0OHlIdjhzbFMvRFgwRms3czZXQlRoS3A1em0xN2daa1ZUbDBpeW4x?=
 =?utf-8?B?TWN2ZHo4bkdjL1VhQzBSajdwaldQSjBicEYzWHZuQUQzeG5iUkZXUWxITnlm?=
 =?utf-8?B?MW9XdHBzdGxUK08rakhyVk5hdFREMkRvd1RFT3V5UEhyallEaHpWNkZIa1Nl?=
 =?utf-8?B?WlRUN0Nvekl5eWRiL2FaamRjZS83YlBYSk9aTnJzTjNac2dETG5TN3ViR1lW?=
 =?utf-8?B?QzRKVDdlOWhwSTFXRVRDYUhoQzdneCtKK2xQejBLWTZFb3FwcEdTU0cwZnRu?=
 =?utf-8?Q?7kPl8SQnSoEGgfH0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: dc1ac8a6-ed75-4a03-1da3-08da31ac7e6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2022 11:10:15.1225
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ixU5kqDwEl9h/hul883/vqJCX8cqWTQEUk78qdtmiW0Rm0k19Ugpxgeng/6EDe88z5WfeJSJAkQYWGcEG8f6CQzs76UTIoEcqrq6nfB2s1g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB2391
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+ICsjZGVmaW5lIFRYX1NJWkUJCTQwOTYgICAgLyogTXVzdCBiZSBwb3dlciBvZiAyLiAqLw0K
PiANCj4gT25seSB0aGF0IEknZCBub3QgcHV0IHRoZSBtYWNybyBkZWZpbml0aW9uIGhlcmUuIEJ1
dCBvdXRzaWRlIHRoZSBzdHJ1Y3R1cmUuDQo+IA0KPiA+ICAgCXN0cnVjdCBrZmlmbyBmaWZvOwkv
KiBRdWV1ZSBmaWZvIGZvciB0aGUgRExDSSAqLw0KDQpJIGhhdmUgcGxhY2VkIGl0IGF0IHRoZSBm
aWVsZCB3aGljaCBpdCBhZmZlY3RzIHRoZSBzYW1lIHdheSBhcyB0aGUgb3JpZ2luYWwNCmF1dGhv
ciBwbGFjZWQgVFhfVEhSRVNIX0hJIGFuZCBUWF9USFJFU0hfTE8gYXQgdHhfbGlzdCB3aXRoaW4g
c3RydWN0IGdzbV9tdXguDQpJIGNhbiByZXN1Ym1pdCB0aGlzIHBhdGNoLCBidXQgaXQgd2FzIGFs
cmVhZHkgaW5jbHVkZWQgaW4gdGhlIHR0eS1saW51eA0KYnJhbmNoLiBQbGVhc2UgbGV0IG1lIGtu
b3cgeW91ciBvcGluaW9uIG9uIHRoaXMuDQoNCkJlc3QgcmVnYXJkcywNCkRhbmllbCBTdGFya2UN
Cg==
