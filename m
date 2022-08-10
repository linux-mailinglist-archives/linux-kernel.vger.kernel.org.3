Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB0558ECD0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 15:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbiHJNM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 09:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbiHJNMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 09:12:22 -0400
X-Greylist: delayed 5927 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 10 Aug 2022 06:12:21 PDT
Received: from mx0b-0039f301.pphosted.com (mx0b-0039f301.pphosted.com [148.163.137.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C23FD03;
        Wed, 10 Aug 2022 06:12:20 -0700 (PDT)
Received: from pps.filterd (m0174681.ppops.net [127.0.0.1])
        by mx0b-0039f301.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27AAxIkf014036;
        Wed, 10 Aug 2022 11:32:32 GMT
Received: from eur04-vi1-obe.outbound.protection.outlook.com (mail-vi1eur04lp2057.outbound.protection.outlook.com [104.47.14.57])
        by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3huwq8t6j2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Aug 2022 11:32:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D506oHzK3eSdt5ypcaRz1a46mpQwDqfYVJQ0Kloxffyq0biFMPntykAJAejn2CPSjbNVuzPeN0NaVii+GwVy8vZ+7WgAz8AoERAncgOfNZ4BrTeowteDjgaeB+m8bpXRWhK5Z1npG28/6qtMj7YE/DFgjJy7MWKEdJQ4GMotXsRUyreYdNQ6qNl88GeT3wK40FGO4ZiadjHZZUD5UXFlIGFo1BnbG6WZgUacVcqOci3LDRv+rrOVDlDAmnCpt44r3MDNBt7wqdm+Y1flOaEnPyqXjXAUIhvGYl8a8vBZSXdAFSBamKmx3Ek3DSEnsURwE2I2cmT+ecks5aG6ZvrKEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c9+hatWRbvsl4UX9qNd0GKihD3i2LitosVsKeBtTRIg=;
 b=nOWJG14amAvpRBxHNItKGpsVRoARMHQZMoCoavsILghwnWxTvP884E+eyRAcCjlLQmZIhbJIlK1/o/c2RPwoTsbcwU9J6adv2q4783PgghQfqNvkr5axn/fWaDQIsozWGODOErfuQpMZrpWj7abMHpfwUwe2qcDpyiX04k6aBdF1j2FkdSYCilrFuqhSCYHTMdi1m0qdaEXzDEOxmItE2SL4791E82dmoeMsx3dcR6Ho/BfcYrx2G9mwoQJeDv/GR54EEo1Jvy8i0RBSjpYvdGs7jshSRrr4MOhjEmInBDBe2hSpXYFP20SQPRmcq5gXJka+biyksp7To3wY+d943A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c9+hatWRbvsl4UX9qNd0GKihD3i2LitosVsKeBtTRIg=;
 b=g6LTn4q8zo/6RDxUXumFgGKHPfOcvxJz088uxoAqu4Sg+QA2hoiYuXdaPztqqr1Yr8oGQs0Y0U6MnS4jym9ISRD+ioJiQXuBGaTXYLj5FF2XoqBuU6LSjE1QNKJTvOcMIsv/aKKZvZf41852CKLa93cvUfWWRkeiH7azD1AzDpCrykDfdZ4L/vMG4faOg/0WY8jXUQcz+wOmRY9W4zKcftoZngJm9NO4okkQzhr8vrXWRNKWcN3ccpmbU/iazqdC9BGsxHOQQrnEsWA2+8Rjrp+htpcDfGyRTGfUO78QT1mrrJM5w1y62vOs/d4FWPjjKPtJBbn2vrjrQjyL1aOGDQ==
Received: from DB8PR03MB6108.eurprd03.prod.outlook.com (2603:10a6:10:ed::15)
 by VI1PR03MB4270.eurprd03.prod.outlook.com (2603:10a6:803:5d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Wed, 10 Aug
 2022 11:32:29 +0000
Received: from DB8PR03MB6108.eurprd03.prod.outlook.com
 ([fe80::f575:76e9:4a40:7387]) by DB8PR03MB6108.eurprd03.prod.outlook.com
 ([fe80::f575:76e9:4a40:7387%2]) with mapi id 15.20.5525.011; Wed, 10 Aug 2022
 11:32:28 +0000
From:   Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] xen: move XEN_BALLOON_MEMORY_HOTPLUG to generic
 config
Thread-Topic: [PATCH 3/4] xen: move XEN_BALLOON_MEMORY_HOTPLUG to generic
 config
Thread-Index: AQHYrHcjLoZ+Ck4yj0aYNvWHl5MnO62oAMgA
Date:   Wed, 10 Aug 2022 11:32:28 +0000
Message-ID: <081fa42d-8587-a69e-5e1c-672152ac8c3e@epam.com>
References: <20220810050712.9539-1-lukas.bulwahn@gmail.com>
 <20220810050712.9539-4-lukas.bulwahn@gmail.com>
In-Reply-To: <20220810050712.9539-4-lukas.bulwahn@gmail.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 84b0eb87-d1fe-4f28-98bd-08da7ac401c2
x-ms-traffictypediagnostic: VI1PR03MB4270:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yfaiNY6J50Mg5WvzyaHDZJ6xCN014YDakrsV+Lc8zhFOiNQQWpkou6O4df0ddg2aEvH83uzbpg/GtzISgANCRsL0XTYEyAJKYUHeJpv/0/xhGRABDSi2gmDIaxQTOHNpZqIq3wp5cbhZenquxcyshEh5PoT9KkFxTqnaJdYcacB20iU5OsnU2DLG094J3WI5m2QlA6yVh/HGGQ4Ty/M+yeV9TeB6DX2pJKaYKu/kqgpPRHHJu+RNR1ynA61ori/EIGrqZI3PK5iAPRKiV/3qE9VO6oMz+Z0MWlaFGXIkWjH5Xti8RyMXAUjRyCEgIX3JlR1XWd7AVF83RI5VzgvP/4nrJmDC0ALAp3pIg+zbjrKvv5HPTy6PnrDVxr0GY+8H3Ja/Xv+rt6TEharmj8gs94rpLiv9t1mePiMQLmHYyz8sbKkYor7x3eHLuPGmbj1jtUFr05iVG/D5fH0noAHZPcjIhO/AWKxPV0WHOgswlPxKm/U2FONB+SSEFMjJcAZZOy84grqQV7K9jx6emggFewAyWtTLoGXmDvjfEL/pOwx6LldoJvxaMdBs4Gb52UIZ2TdhKoRuakUbn22pmT9yzlFVdH4cilOvUAfkwk6fuTsRQ76szak6/mLo5TjWzf15SA+V/JLtm4Z59KLoAEvHwqFU5PfgkQSZDSXk0ee9LNiEUVRBOdhBjORW2ZHwLO/4U6jd4C64MVncSoac9kFIUdB8E3MklQn0tEXhwE/0YwuRQExOdXVsG7UGSoux73ECTi/TrcB3en08Wr+p/bcERHnOKuIcxF9KWtCY1FVFW5QRCAIWJVuzJX2PCnDBPCh2AnofT8j7fCHIu2uizBTaMj8sxsivKoONWO50nTXX/bI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR03MB6108.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(136003)(376002)(346002)(366004)(6512007)(186003)(2616005)(83380400001)(316002)(110136005)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(8676002)(4326008)(91956017)(36756003)(41300700001)(54906003)(31686004)(2906002)(478600001)(26005)(6506007)(53546011)(55236004)(31696002)(86362001)(38100700002)(38070700005)(6486002)(8936002)(7416002)(5660300002)(71200400001)(122000001)(41533002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VERveTQrUXIxWHFCbFdnWjBnY3cwYnc5U3BWVDZEcUpIRkVuQWt1bnVNbmJ2?=
 =?utf-8?B?OTBZdHdpaWtJbVd4Y3MvSG5sUVQ3YzhIRXI5RzFJWDdwMkUvck96bHorNkJi?=
 =?utf-8?B?a2pCN2d6OFB2L1hhY2l1OTRpOU0xRTRRT2cyVDU3bDZFU0lIbXVFTXVRNFZY?=
 =?utf-8?B?TGpqelkzVENnbUwyR0RFSmxyYVhNL2FxOTZJY0tTNGlFSCs3VlFJeU9iWDUr?=
 =?utf-8?B?RHJEOUZMZDNSTVp6WFdpRlJwTkhOYlA1cjVVTWVoMG5uMXl0ZW9uZjFtZHJE?=
 =?utf-8?B?aThIcnEyNnpWc0l6bkhHZkFaNWZRK3g5RXJaVEtSVUNHd21uRFBoajkzSy9o?=
 =?utf-8?B?OW9RZ2p4OS82VGVkZUg5TjZ3ZFZjbVpNNXZCT3orQk5hQ016SzVaOXJjMG9x?=
 =?utf-8?B?bGdOTjU2dVVmL25UVlkyZUVnUTZJQXRSeFV0bkJhNmQ5TjVTREVYY1N4d2JL?=
 =?utf-8?B?Z2J6UklEQTN2UFB4cmg0cXdzTVI3R0I4UHRFejRHa0F1WGVRZnNZMEpkVlBQ?=
 =?utf-8?B?K2RuYWFVeEExZ2UvazBQVXdUbW9uYit4Zk5CaEZncVZRbk9lTGhKSkdJYzZo?=
 =?utf-8?B?SGFuZVB1a1RUSnpkQTJIOVRmdldZaGFFWG81em1rYzdncHlXb0kyQ25KaTRS?=
 =?utf-8?B?K2ZVekJmTDVRRFY2STh4QmNXcUdMcHBvcnF0WnIzUmlZWjcrZDA5QmQ2M1BB?=
 =?utf-8?B?U3JxSFdFQ1AyUlJBVWgvdTlINnIyRFRHSmNaNFAramxPaXpBTitkbDZVVFBY?=
 =?utf-8?B?NWk2S05ISkExdjloVXRYZjJ4dFBvalBZdHZycDM5QXFNc3Axak1XNlovMGdV?=
 =?utf-8?B?NXJMZDNMSjV5R1M5VlYwM1Y2Qys0R3kwOUlrY1JDc1ZRSFA3SEFVck16S2Vh?=
 =?utf-8?B?TGFJVEh0SFM4aU9HejYvNFNPbXhTQ0plNWt4YnNVWElIM0V6SS9aRVM1dVhl?=
 =?utf-8?B?NGkrN1VwTGxQN3FPNTQ2VDJldGJJbitMTE9uOGE3Uy9xUDVPSlVkQXVzTkpD?=
 =?utf-8?B?K1dBY1pSUVpOMTFxd3hwcXBjbExEWnpWVFRpeEl5emtFc3lwbTVxZlpaWTBH?=
 =?utf-8?B?VEJhM0xycWdtTnBxajRYbXRCWFpMNmtsVjErdGljdVJiYmNlblN1SnBsUU9B?=
 =?utf-8?B?VVJsdUZsYk5xVng0S08wOWRQZWpwR3hYN1NGOGdTUUZCaUZBMzRGQ3o2bGdw?=
 =?utf-8?B?d3dWbEw2azY4RG5IQ0NsaHZFdHkwbVh2TzU1MzBhLzF2TVNjd3VGR0tFZmx4?=
 =?utf-8?B?Nk40bmRzdng4eHo2bzhVd0VabWVlSmZHRWJZeXR5OG1XN3ZlNEdsdFB6Uk1w?=
 =?utf-8?B?clI3TmV5dSsyWk0xc0VLUi82YjBYZmVpQWNqWFVMOWxMUmN6VU1mdVdjYkNG?=
 =?utf-8?B?L29JMjRRdm95RHcvakhLbFJJUnFFRW9sMFFISDA0YzVzZUIyZWJxZ3FvaGtP?=
 =?utf-8?B?YUN6RGlkRGozcmdZTVY0R1V6OGQ1MzhQUGxkZzZrYndsZUp2RU13Ry8vSGdi?=
 =?utf-8?B?eFpOejdIWU5xYkNTa1lSR3FYNVc5OGNFK2VHMXBadkdtN3ltaFFETFZXdUNR?=
 =?utf-8?B?K1N5eVp0Y1VxeXVPNUE1RFhERG5qNW43OEEvR0xzb3JRZzNBUlM4N29hM29H?=
 =?utf-8?B?VGk1TTNIdDZTdzUySm1iWXQxWkhHRlgvUXJ3Rkd5cE5zT0pzdkpaTTJ2WjV4?=
 =?utf-8?B?YXZvQ2U0UUxKSWxacXRybXpTS1AySFN3TU5CcGhlbExtTUhrN1hzQzdpWW1O?=
 =?utf-8?B?aTBhNUN1N0E1M2p1WjczYWgzR2F4dXdPbHRlR3JlNjBoZ0czc3Zsb1BBUkVZ?=
 =?utf-8?B?ZnZjS0YzOTVZTzVudEVGTkZLVDRRdU5KWENlRlFrN0luZUtIdnBzbERKbDZU?=
 =?utf-8?B?ODlTbGxyTnB6ZzFtS2FjbGJXZStNMktHbFFTNEpZVURvOVRwOGQwR2wyOEVR?=
 =?utf-8?B?R3dZWE5TcDd1SE5jaUdWUm5SdFl1MWJsSWYranBzVGR5eHV0OHl0VXNWdVdv?=
 =?utf-8?B?R3dMTFZWVHk2QkRsSHdXMFpyczdYUSs2UFY4WWpVZk95MmV0bDJxQU9IdXJH?=
 =?utf-8?B?ZEpwRUprUWVXeVZqYnhOUEJIblRJREljNWl3V1A3cmJwTUo1dDE1aHJNaXZX?=
 =?utf-8?B?Uzd3bjEydXU1am5qOFluNzkrQjNHaFhKM1lBYVBRNmhOeHpGQmsyTW9uLzY5?=
 =?utf-8?Q?wGyG9EoSOsbmUiFQCtCAaJU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F7D4908D884DAD4C84158EA82BFDE4E0@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR03MB6108.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84b0eb87-d1fe-4f28-98bd-08da7ac401c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2022 11:32:28.7430
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2v2hXzeQ9TWw+QCrG78GljzThiB9tZ5JgpysCyXOqlzlwj+t6tpWLAVFUJ/gQvppSGHEfQXcd2jHDksGMdqyv1xGkWoq1AIx+y2/P33knPE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB4270
X-Proofpoint-GUID: xQzGMxYRUBimrdVP_s6iMkh69dLGxnH1
X-Proofpoint-ORIG-GUID: xQzGMxYRUBimrdVP_s6iMkh69dLGxnH1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-10_06,2022-08-10_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 mlxscore=0 suspectscore=0 clxscore=1011 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208100035
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAxMC4wOC4yMiAwODowNywgTHVrYXMgQnVsd2FobiB3cm90ZToNCg0KSGVsbG8gTHVrYXMs
IGFsbA0KDQo+IFdoaWxlIHJldmlld2luZyBhcmNoL3g4Ni9jb25maWdzL3hlbi5jb25maWcsIEkg
bm90aWNlZCB0aGUgZm9sbG93aW5nDQo+IG5vdGUgaW4gdGhpcyBmaWxlOg0KPg0KPiAgICAnIyBk
ZXBlbmRzIG9uIE1FTU9SWV9IT1RQTFVHLCBhcm02NCBkb2Vzbid0IGVuYWJsZSB0aGlzIHlldCwN
Cj4gICAgJyMgbW92ZSB0byBnZW5lcmljIGNvbmZpZyBpZiBpdCBldmVyIGRvZXMuDQo+ICAgIENP
TkZJR19YRU5fQkFMTE9PTl9NRU1PUllfSE9UUExVRz15DQo+DQo+IENvbW1pdCA2YzY2ODUwNTVh
MjggKCJrY29uZmlnOiBhZGQgeGVuY29uZmlnIGRlZmNvbmZpZyBoZWxwZXIiKSBpbiBKdW5lDQo+
IDIwMTUgYWRkcyB0aGlzIG5vdGUuIEZvcnR1bmF0ZWx5LCBjb21taXQgNGFiMjE1MDYxNTU0ICgi
YXJtNjQ6IEFkZCBtZW1vcnkNCj4gaG90cGx1ZyBzdXBwb3J0IikgZnJvbSBEZWNlbWJlciAyMDE4
IGFkZHMgdGhlIG1lbW9yeSBob3RwbHVnIGluIGFybTY0LCBzbw0KPiB0aGUgcHJlY29uZGl0aW9u
IG9mIHRoaXMgbm90ZSBhYm92ZSBpcyBub3cgbWV0Lg0KPg0KPiBNb3ZlIHNldHRpbmcgdGhlIGNv
bmZpZyBYRU5fQkFMTE9PTl9NRU1PUllfSE9UUExVRyBpbnRvIHRoZSBnZW5lcmljDQo+IHhlbi5j
b25maWcgbm93Lg0KDQoNCkkgbWlnaHQgaGF2ZSBtaXNzZWQgc29tZXRoaW5nIGJ1dCBJIGhhdmUg
bmV2ZXIgaGVhcmQgb2YgYW55b25lIHVzaW5nIA0KWEVOX0JBTExPT05fTUVNT1JZX0hPVFBMVUcg
b24gQXJtLg0KDQpMb29raW5nIGludG8gdGhlIGNvZGUsIEkgYW0gYWZyYWlkLCBDT05GSUdfWEVO
X0JBTExPT05fTUVNT1JZX0hPVFBMVUcgDQp3b24ndCBiZSBmdW5jdGlvbmFsIG9uIEFybSB3aXRo
b3V0IHJld29ya2luZyByZXNvdXJjZSBhbGxvY2F0aW9uIGxvZ2ljIA0KaW4gZHJpdmVycy94ZW4v
YmFsbG9uLmMgYXQgbGVhc3QsIHNpbmNlIHN5c3RlbSAiaW9tZW1fcmVzb3VyY2UiIGNhbm5vdCAN
CmJlIHVzZWQgb24gQXJtIHRvIGFsbG9jYXRlIHVudXNlZCBtZW1vcnkgcmVnaW9uKHMpLCBwbGVh
c2Ugc2VlIA0KYWRkaXRpb25hbF9tZW1vcnlfcmVzb3VyY2UoKS4gSSBtaWdodCBiZSB3cm9uZywg
YnV0IGl0IGZlZWxzIHRvIG1lIHRoYXQgDQpoZXJlIHdlIHdvdWxkIG5lZWQgYSBzaW1pbGFyIGxv
Z2ljIGxpa2UgaW4gDQpkcml2ZXJzL3hlbi91bnBvcHVsYXRlZC1hbGxvYy5jIHdoaWNoIGlzIGZ1
bmN0aW9uYWwgb24gQXJtIHNpbmNlIGl0IHVzZXMgDQpzcGVjaWZpYyBYZW4gcmVzb3VyY2UgKG9u
IHg4NiBpdCBpcyBqdXN0IGFuIGlvbWVtX3Jlc291cmNlLCBidXQgb24gQXJtIA0KaXQgY29udGFp
bnMgcHJvdmlkZWQgYnkgdGhlIGh5cGVydmlzb3IgZXh0ZW5kZWQgcmVnaW9ucykuDQoNCkkgYW0g
bm90IGF3YXJlIG9mIGFueW9uZSB3b3JraW5nIG9uIGl0LCBzbyBJIHdvdWxkbid0IGVuYWJsZSB0
aGF0IA0Kc3VwcG9ydCBvbiBBcm0gYnkgZGVmYXVsdCB1bnRpbCB0aGUgY29kZSBpcyB1cGRhdGVk
Lg0KDQoNCg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBMdWthcyBCdWx3YWhuIDxsdWthcy5idWx3YWhu
QGdtYWlsLmNvbT4NCj4gLS0tDQo+ICAgYXJjaC94ODYvY29uZmlncy94ZW4uY29uZmlnIHwgMyAt
LS0NCj4gICBrZXJuZWwvY29uZmlncy94ZW4uY29uZmlnICAgfCAxICsNCj4gICAyIGZpbGVzIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAzIGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEv
YXJjaC94ODYvY29uZmlncy94ZW4uY29uZmlnIGIvYXJjaC94ODYvY29uZmlncy94ZW4uY29uZmln
DQo+IGluZGV4IDhhNmM4OGY0OGU3NS4uMDI0ODE3YmM0ZjBlIDEwMDY0NA0KPiAtLS0gYS9hcmNo
L3g4Ni9jb25maWdzL3hlbi5jb25maWcNCj4gKysrIGIvYXJjaC94ODYvY29uZmlncy94ZW4uY29u
ZmlnDQo+IEBAIC0yMyw2ICsyMywzIEBAIENPTkZJR19YRU5fQUNQSV9QUk9DRVNTT1I9bQ0KPiAg
IENPTkZJR19YRU5fUENJREVWX0JBQ0tFTkQ9bQ0KPiAgICMgeDg2IHNwZWNpZmljIGZyb250ZW5k
IGRyaXZlcnMNCj4gICBDT05GSUdfWEVOX1BDSURFVl9GUk9OVEVORD1tDQo+IC0jIGRlcGVuZHMg
b24gTUVNT1JZX0hPVFBMVUcsIGFybTY0IGRvZXNuJ3QgZW5hYmxlIHRoaXMgeWV0LA0KPiAtIyBt
b3ZlIHRvIGdlbmVyaWMgY29uZmlnIGlmIGl0IGV2ZXIgZG9lcy4NCj4gLUNPTkZJR19YRU5fQkFM
TE9PTl9NRU1PUllfSE9UUExVRz15DQo+IGRpZmYgLS1naXQgYS9rZXJuZWwvY29uZmlncy94ZW4u
Y29uZmlnIGIva2VybmVsL2NvbmZpZ3MveGVuLmNvbmZpZw0KPiBpbmRleCA0MzZmODA2YWExZWQu
LmVhODRkNWIzMTIyZCAxMDA2NDQNCj4gLS0tIGEva2VybmVsL2NvbmZpZ3MveGVuLmNvbmZpZw0K
PiArKysgYi9rZXJuZWwvY29uZmlncy94ZW4uY29uZmlnDQo+IEBAIC0zNCw2ICszNCw3IEBAIENP
TkZJR19JTlBVVF9YRU5fS0JEREVWX0ZST05URU5EPW0NCj4gICBDT05GSUdfWEVOX1NDU0lfRlJP
TlRFTkQ9bQ0KPiAgICMgb3RoZXJzDQo+ICAgQ09ORklHX1hFTl9CQUxMT09OPXkNCj4gK0NPTkZJ
R19YRU5fQkFMTE9PTl9NRU1PUllfSE9UUExVRz15DQo+ICAgQ09ORklHX1hFTl9ERVZfRVZUQ0hO
PW0NCj4gICBDT05GSUdfWEVOX0JMS0RFVl9GUk9OVEVORD1tDQo+ICAgQ09ORklHX1hFTl9ORVRE
RVZfRlJPTlRFTkQ9bQ0KDQotLSANClJlZ2FyZHMsDQoNCk9sZWtzYW5kciBUeXNoY2hlbmtvDQo=
