Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4DA59ECA2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 21:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbiHWTnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 15:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231487AbiHWTnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 15:43:12 -0400
X-Greylist: delayed 17816 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 23 Aug 2022 11:44:02 PDT
Received: from mx0b-0039f301.pphosted.com (mx0b-0039f301.pphosted.com [148.163.137.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7786278;
        Tue, 23 Aug 2022 11:43:57 -0700 (PDT)
Received: from pps.filterd (m0174683.ppops.net [127.0.0.1])
        by mx0b-0039f301.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27NAtohs023549;
        Tue, 23 Aug 2022 13:46:46 GMT
Received: from eur05-vi1-obe.outbound.protection.outlook.com (mail-vi1eur05lp2169.outbound.protection.outlook.com [104.47.17.169])
        by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3j4wjugv5j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Aug 2022 13:46:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NyVnRNOAjLX08sLgjNs33GL+vBAiBIOTMhHLszs0iUotGmTZ6Qvf1lrkIcd1k9DK+oSFLvFG0plEWlIT26b8vD8AI4QNHxFIfLeOFNcolsxe/z+ZwQjaUTPW0vegjN7iaXB+BSE5xXG9PmSd0vlLrrIBAgUaWrWVD6++Z2nwHq7MKfDMBaAPVVJTg7LM15Hw0YN03H5mKPvdUaEKP1pDeniV1mayq/82doXtH/y7SQ1faD2C9aRjQiv1X2YQcmKCUvai1SlaNtkG+2Z/1XlCB4SupCAOTgTMauoluyHpgeB9+6jIZ2NVbgt2XDLICBETOEO1/TLCEQ3Rf9jnqcVf6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xqKv9OaBqIzvDzwgXp6l2VxsxfpHuEmvYLwBnCC0pT4=;
 b=iBja2gRhuTCvNEVRLY9InrDpfSMfkwLUbPO5RV52LQyvoXsiW+k9Hbv8YmqqXdhVhBUEW9aGdza289MaVjKLkd5yB62Y8bdMT2YxG68DS9lWSLJgqw/yp35oGGYiGxcBSNYiigLbrXRJUeoqAoL/sBmqxagR8yFcopAl2cOb1/6ZtWpQfHv4uWmquHlbLEZHoRjnAR+4AUD9JbmIhDN3hBkQUQSdOwGVO7IFIyGJohN2F4D+KqirSSmOev3lvH313ISt/M2pi2fToEM5kU6lj56FmJ196PNxP4POl2FtWgNy+KSSo3KAURwFRhG1xYdcWh9aFR/IAV5eFgLepMSiRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xqKv9OaBqIzvDzwgXp6l2VxsxfpHuEmvYLwBnCC0pT4=;
 b=p4B2w656u5i8ilLhm374yrmp8X4kVfKlDn7kLJmpGlZJnssRB7Xe0w6INt0yNIBrOHr4xBRN7DwvuJYs/NVDKkvR7lrClGcgEqjtXAyQL66KVlZO3GGNcQmTT89Od2uUZFTCAKVcPAIdgCZD2Q1Zg3s6cJRGBhI//3vMFLVqWq1fovW68pQdXcaPfcrUc68HQRx4py32tCNWVIVqm+IadO6haqRIFWDs3J9mYfueIHt4GkRq5CSWAtvATIQy25RjyGvnU0UgKAe6r+SuVfmW28QFwfc3xC7tZU8x3AnB57QTMylT6BLeUHuYrRDphNfPd4di65SctohHcARm6uMutA==
Received: from DB8PR03MB6108.eurprd03.prod.outlook.com (2603:10a6:10:ed::15)
 by VI1PR03MB6365.eurprd03.prod.outlook.com (2603:10a6:800:195::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.24; Tue, 23 Aug
 2022 13:46:43 +0000
Received: from DB8PR03MB6108.eurprd03.prod.outlook.com
 ([fe80::f575:76e9:4a40:7387]) by DB8PR03MB6108.eurprd03.prod.outlook.com
 ([fe80::f575:76e9:4a40:7387%2]) with mapi id 15.20.5546.022; Tue, 23 Aug 2022
 13:46:43 +0000
From:   Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH] xen: move from strlcpy with unused retval to strscpy
Thread-Topic: [PATCH] xen: move from strlcpy with unused retval to strscpy
Thread-Index: AQHYs0YFHPDOI0n17UKUZScrX/PwVK28hvoA
Date:   Tue, 23 Aug 2022 13:46:43 +0000
Message-ID: <bec94594-1a7b-14ff-ad91-f2e781b12be5@epam.com>
References: <20220818210122.7613-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20220818210122.7613-1-wsa+renesas@sang-engineering.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3d2eb1ea-308d-4c6b-ed81-08da850dea04
x-ms-traffictypediagnostic: VI1PR03MB6365:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5FsprJaSo9YGIubgiDtTKR740XxaGquXgASgIZKhwBTbMeYK8ynota89yWoBaBkrryFY7uzj7/pN6WuxNTNiINisb9UJ6pwO8qSo/kkIUhZmNbXKiqAEmBUydLF+ColJWFmQvjbMhN/KrBup2xA/qNig16NICMqlx+Graoeg+Bp7iDBFYP5kS+VSM6KGsRmC3e1rB93ZpKojNGspxsLqco7i43Fcil54OHRIM/VV25nM//mzMliCYiGJB49mHYlzmqIj9FULmcv1dcEx5n9HkrZ+Wy7D3UlVZ/UI9kxxMKwApD5ESbWxIg47ti0sLOs+iI6d9+SSnbK5Qh1U+EpH04gb3SadjCAxdBXv2YaI27id/lOq26OsaxiV3EY2VfEIlhtb8nAO4BDUSLZBT6rBlBEXu4nRrPeYdw1LnfvjXs0qm9m0qwv5hqIp3tQpAZZYp5o0IVAIiFzYikA6m+Jf0K191GbpjiADhgwccGLn+Dt05ApIlvgj5wVcw9GXTtkBPLeEqk6J17iuhiB8vbyNEJJqXfbvLxxghlAdDqIg8DCK1hxDKfnJ680rYWkHgRa/zp+LQGcUgGpt24heihU+cbPTJXnSMOlBcQhtu7DgFknRXOJW647HcRvxQhb/cMDKBzgobVWP3ie1Vdn4zjvWlpuwKtIN6BgPRaMwgG3eDOXieXUXCF5/XY66c4ONv8X4lTGA3G3YA7ieZBd/QofyCuU8lx2eR5hXfQxZAMc+qTxRGBm3gujdqpizLaAo/UBNIK5S98lRr7QCzufCvL6LhrsVe8dejcrRg9Jeip0uZP8KlS4FYw2mNN97ndPaaUk13vqVJVAvyd9TnU+Fe9ymersoWCdYQBI97s09kLXpmTY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR03MB6108.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(2906002)(2616005)(6512007)(186003)(38070700005)(83380400001)(26005)(66556008)(4326008)(8676002)(64756008)(66446008)(5660300002)(91956017)(66476007)(76116006)(66946007)(36756003)(8936002)(31686004)(110136005)(86362001)(478600001)(71200400001)(53546011)(316002)(41300700001)(55236004)(54906003)(6506007)(122000001)(966005)(6486002)(31696002)(38100700002)(156123004)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RjNDdVoxdndYa1lGT0VQUkFQaTRtUVJ0d0pnYitZVUtOUHNtR3l6SDE0T2VP?=
 =?utf-8?B?a2hkczNTUVVWbFlsanhkbUxVTGk5YXdGZEd5QXJ1MkRmeDExWFNrWitQZnpz?=
 =?utf-8?B?ZG9rV1RmbGJaZ1dkY1FzVnR6SWgxeEtaRlNyK3B4enlaYzhWTlRiTTFhbXcx?=
 =?utf-8?B?T3RxWHg1R09UV1hpbG5WMlVaZFJaWmFYQ3pFekQ2OWdvN3hpd05IQ3lsY282?=
 =?utf-8?B?U21kS3d5VTJYY1hJek9JdlVnMG9zRUh5Ynczc0k3TENwaGZCcy92dDRRU2o4?=
 =?utf-8?B?ZU4yTW9GWFdpV0s5ZzNuMlZ4S2laMXlKSEwyYnlqdW1HUXJHTU5kcnNIUDEv?=
 =?utf-8?B?UThUbm1HdHBHR1F2WDR1NFY0OUQ0aUhBV25jVS9YV1ZRTTNXcXJSQXd0MTdh?=
 =?utf-8?B?bUc4SlhJd3p5SGdManZhUnBSa1l4eUdGN2Y5MEtaTjA1bFM2aS9zbHJDUWJJ?=
 =?utf-8?B?RlUvNy9OVzdDUE5mTkp5bXFlOXZVUWI4RTZySndsQThWeWJPRXNzOVkxQ1lX?=
 =?utf-8?B?Q1d5cmUxR3crT2JWTENta09CNVFMYXlyalZrdk9wb2txSzZTUHpCalV5b204?=
 =?utf-8?B?QTNObm5OeEVSekZHeHFMSmRONFlSakluNWk1NDVKbkFqa3ZyWU96dFVmRzQ0?=
 =?utf-8?B?Z1VDOGdGMTJnSzFCYzFzWGlrNzVxaTJNL0tJdHhycFdQWktPWU50bGNZR3Jj?=
 =?utf-8?B?VitKZUc3eTVCTzBMQUYwVGRLbEVhb0thRkRSSFpJVmYrMFhPSGFZRW8yR1Jy?=
 =?utf-8?B?YTRhMXNRa1AybllDeFFGRzk2cVRVeFJ4NFZyN3I3Ui9sZHdQVkVOZmUrUGtV?=
 =?utf-8?B?MENTQXd5YmhER2daSkE5UWQ0aUlZVERGQSs0WTBKTmxCeTNPQ2Z3aktYNTFP?=
 =?utf-8?B?TTZNVUhZd0E2SktDY3NpWThNVEh4R0llZXFkdnk3QzcrYm10NTdOaStDc0Np?=
 =?utf-8?B?NEV6QnIzNFd5OUxSV0ZnWXFTYlZ2dEtjRFEzcEhhYm1hOGt2ZjgvVnpJcCs0?=
 =?utf-8?B?a29qNG91a2hjbnpWSGFhN2xPMzZwMWVRWHNIbjMwai84SWJ3YmxNUWVTc0hN?=
 =?utf-8?B?OElWOHdMai9YcVF1QjN0Ym10M1djUUg5Qk9hZ2M4L3c2S3ZlRjdCWUtGUnBL?=
 =?utf-8?B?bXQ4RTVGc2xROFdwaHpTckNPZk1wRlhraGFRSTZUNXRETGtIVWZHUHV0RFh6?=
 =?utf-8?B?TUExRlRxcU94QnprbXhIMGFZVzZiKzNyUmRZSkxEMnF4bnZ5eFh2TTZYQ2N2?=
 =?utf-8?B?MytSRnIxdWEwQ0xkTkNiZ1ZZcWhIbThWbUs3Y3VOQXd4bnU0OEJhRWhTWmJ3?=
 =?utf-8?B?SlQ1eXRqQVh6b1gyY0l5UE5BVkRNN2E3bmVPSTdoZG9md0VCTlpwa043bmhW?=
 =?utf-8?B?b2E5bFM2Z0lSa3g5ckhDZjFQWkFZcjlBNnRCc3N4M2VtbTlTR2xDVC9XbHlI?=
 =?utf-8?B?dFRFVk81K3ZlRGRRUG9sYWxpYTZkL08yNGk3SGNEeWdWZDU5YkZNbFZRNlox?=
 =?utf-8?B?U1VqUmlYTkkvRmZLRDVMME9hUiszNGt3V0loUU05djJ0ZUUyTVhST2E5bit5?=
 =?utf-8?B?Z0hoNnMxak1HYU9icmlZSUM5TVI2YUwzR3daRkZjZ1hiall6VkZKYVZNTTVk?=
 =?utf-8?B?L0VpR1p6OS9aZ3hIK2hFZDlQTlZTZ1B5cG1MQjU0Y1RRUGxHdFMzZElud21o?=
 =?utf-8?B?S0RKVXVCc2ZoMWxTSEdrZzIvdTJrRGxMazF4eENSVmRlU200aDBNZ1Fya085?=
 =?utf-8?B?dlROOWd6dFBLdW1kZnhUY3R0UDA3ZVdsbThtZmd2UXBDUXhYWVRXV2g4NHZT?=
 =?utf-8?B?R0VEaUFxUXpDbSttNzk4WG16ZFkwVEZHMXpXTWpwa3J5dHZXekpYbzl0VjAw?=
 =?utf-8?B?NHM1QmVIc3BIcGhETHhTMzdmakpHb0RjWUF2M3R3aHlzMUFyVFdONTFJREpU?=
 =?utf-8?B?azlhYlRTOEhBeWJUNUlxeE9Oa014eURYSzhwRXRvN2grMFVHaWpYZXVBcUNq?=
 =?utf-8?B?anRFQjlmSitCdHVuZEwvZDVvNm1GRkdmRXZXSFYvRmU0Yi8vQnlmalhWcnFT?=
 =?utf-8?B?bU05SW1VMFpFdCt4UnlYcEVsN2pCM3lCUTZzUXJNa21UeU9LRVB6cXZvdC9U?=
 =?utf-8?B?L25PUEN0T241WUFGLzAwaXpzVU1UVGNiR3FMcnZNT1VKYTAxUGs5VEpobnhB?=
 =?utf-8?Q?pZrl5i2tFJyjDc1lklcLVCI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A72ACA5280DF4A4FA705383EC39C87CF@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR03MB6108.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d2eb1ea-308d-4c6b-ed81-08da850dea04
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2022 13:46:43.3138
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pXFfW83aWUCAHR/VqEUPcIpIxLxZXh4bxsi+2SL/dNVYPlluRFBYpXlbyfCfhVbKkD4GwMvW55W8OPTF2X58j6O3ezKQyTZAylGjTkuTYR8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB6365
X-Proofpoint-GUID: EYFioTrI64vTo-epccuuiVJCbwrt23lD
X-Proofpoint-ORIG-GUID: EYFioTrI64vTo-epccuuiVJCbwrt23lD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-23_05,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 clxscore=1011 adultscore=0 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208230055
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAxOS4wOC4yMiAwMDowMSwgV29sZnJhbSBTYW5nIHdyb3RlOg0KDQoNCkhlbGxvIFdvbGZy
YW0NCg0KPiBGb2xsb3cgdGhlIGFkdmljZSBvZiB0aGUgYmVsb3cgbGluayBhbmQgcHJlZmVyICdz
dHJzY3B5JyBpbiB0aGlzDQo+IHN1YnN5c3RlbS4gQ29udmVyc2lvbiBpcyAxOjEgYmVjYXVzZSB0
aGUgcmV0dXJuIHZhbHVlIGlzIG5vdCB1c2VkLg0KPiBHZW5lcmF0ZWQgYnkgYSBjb2NjaW5lbGxl
IHNjcmlwdC4NCj4NCj4gTGluazogaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL3IvQ0FIay09d2dmUm5YejBXM0QzN2QwMXEzSkZrcl9pX3VUTD1WNkE2
RzFvVVpjcHJta253QG1haWwuZ21haWwuY29tL19fOyEhR0ZfMjlkYmNRSVVCUEEheDh0WFJYVGR6
YlNtYVdBM0dILUFqLVpGMkhyTUlBVk9yX3Flck82YXZnMDVBS2hUMFJJN01ucVY2NER5a0ZGSGZ1
RHdvRFl0VC1pNWJ3N25HWVNwbmVEcXp6R2ZoWUZIY203TEJRJCAgW2xvcmVbLl1rZXJuZWxbLl1v
cmddDQo+IFNpZ25lZC1vZmYtYnk6IFdvbGZyYW0gU2FuZyA8d3NhK3JlbmVzYXNAc2FuZy1lbmdp
bmVlcmluZy5jb20+DQoNCg0KTG9va3MgY29ycmVjdDoNCg0KUmV2aWV3ZWQtYnk6IE9sZWtzYW5k
ciBUeXNoY2hlbmtvIDxvbGVrc2FuZHJfdHlzaGNoZW5rb0BlcGFtLmNvbT4NCg0KDQo+IC0tLQ0K
PiAgIGRyaXZlcnMveGVuL3hlbi1zY3NpYmFjay5jICAgICAgICAgICAgICAgICB8IDIgKy0NCj4g
ICBkcml2ZXJzL3hlbi94ZW5idXMveGVuYnVzX3Byb2JlX2Zyb250ZW5kLmMgfCAyICstDQo+ICAg
MiBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+DQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3hlbi94ZW4tc2NzaWJhY2suYyBiL2RyaXZlcnMveGVuL3hlbi1z
Y3NpYmFjay5jDQo+IGluZGV4IDdhMGM5M2FjYzJjNS4uZDNkY2RhMzQ0OTg5IDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL3hlbi94ZW4tc2NzaWJhY2suYw0KPiArKysgYi9kcml2ZXJzL3hlbi94ZW4t
c2NzaWJhY2suYw0KPiBAQCAtMTEyMSw3ICsxMTIxLDcgQEAgc3RhdGljIHZvaWQgc2NzaWJhY2tf
ZG9fMWx1bl9ob3RwbHVnKHN0cnVjdCB2c2NzaWJrX2luZm8gKmluZm8sIGludCBvcCwNCj4gICAJ
CQkJIiVzOiB3cml0aW5nICVzIiwgX19mdW5jX18sIHN0YXRlKTsNCj4gICAJCXJldHVybjsNCj4g
ICAJfQ0KPiAtCXN0cmxjcHkocGh5LCB2YWwsIFZTQ1NJX05BTUVMRU4pOw0KPiArCXN0cnNjcHko
cGh5LCB2YWwsIFZTQ1NJX05BTUVMRU4pOw0KPiAgIAlrZnJlZSh2YWwpOw0KPiAgIA0KPiAgIAkv
KiB2aXJ0dWFsIFNDU0kgZGV2aWNlICovDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3hlbi94ZW5i
dXMveGVuYnVzX3Byb2JlX2Zyb250ZW5kLmMgYi9kcml2ZXJzL3hlbi94ZW5idXMveGVuYnVzX3By
b2JlX2Zyb250ZW5kLmMNCj4gaW5kZXggMDdiMDEwYTY4ZmNmLi5mNDRkNWE2NDM1MWUgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMveGVuL3hlbmJ1cy94ZW5idXNfcHJvYmVfZnJvbnRlbmQuYw0KPiAr
KysgYi9kcml2ZXJzL3hlbi94ZW5idXMveGVuYnVzX3Byb2JlX2Zyb250ZW5kLmMNCj4gQEAgLTQw
LDcgKzQwLDcgQEAgc3RhdGljIGludCBmcm9udGVuZF9idXNfaWQoY2hhciBidXNfaWRbWEVOX0JV
U19JRF9TSVpFXSwgY29uc3QgY2hhciAqbm9kZW5hbWUpDQo+ICAgCQlyZXR1cm4gLUVJTlZBTDsN
Cj4gICAJfQ0KPiAgIA0KPiAtCXN0cmxjcHkoYnVzX2lkLCBub2RlbmFtZSArIDEsIFhFTl9CVVNf
SURfU0laRSk7DQo+ICsJc3Ryc2NweShidXNfaWQsIG5vZGVuYW1lICsgMSwgWEVOX0JVU19JRF9T
SVpFKTsNCj4gICAJaWYgKCFzdHJjaHIoYnVzX2lkLCAnLycpKSB7DQo+ICAgCQlwcl93YXJuKCJi
dXNfaWQgJXMgbm8gc2xhc2hcbiIsIGJ1c19pZCk7DQo+ICAgCQlyZXR1cm4gLUVJTlZBTDsNCg0K
LS0gDQpSZWdhcmRzLA0KDQpPbGVrc2FuZHIgVHlzaGNoZW5rbw0K
