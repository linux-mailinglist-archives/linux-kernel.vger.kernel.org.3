Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EABDC5B222B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 17:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbiIHPZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 11:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbiIHPZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 11:25:18 -0400
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90081.outbound.protection.outlook.com [40.107.9.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17CED82F90
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 08:25:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AOM9b9EVxw9EphTMtEnZkQJCfKrNILiFu6vHpx29ysz/9YhK+n1pA4q853U5iI2x2PxaEKBIPIzhdYp+Hqa/imsWUhEmqjx1v3j1Vryi4QaBYzxtIP5fyv1Jc1UA5BD2mskXDneYM1w8bG1ptFYIqnX71kT6ScnCC/+kOACUxrQOnntY+GnwrrNywSCuK4ZHnI5OxOnaQaj1Skcr2wP011SBsfkI57zIZRdfRx6zBg5FcFYI6+dIjBDtTdhrfEyIbdmgqJswsi+kJOHkqBASSOfDXnI6sE45byaWxCoVYSet+AdD12BNugKxbTfJ2sULRRqKP3M2sKU4bxMiVJq6OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=80KKzFhPCIKfZdn3CP44fmshs60OJSQQbS4jX1YP/Pw=;
 b=Uyb0vmDgDTPMWJUyPo3tOOXNLjwQapW8ZVfbLpYmo8PlVIwieHfQH2/OaKuVxnOdaUGp6m3F/Ap+Zd5+K8Vn6X47V25ETBWdJv3nGRWbionau/QsvDfAoQp27aI0JhYAtJOxQxxJSLNDqZll2ol5UhnEc1HOMByugAqcPqA2TZsE3RpKbDghorm6ivMGS+lOirMoE2q3EfZHq9+YCJnLvIUrsk5IpYOb2N4Vnfqvlijjfpc83g17MBPwJb3PdDVrKK9S0BFE0DcLujxNmR2TP+eleOVoaTuDYK10cE5XeyWGPKG26TnkuhGk6SGdcc1mayOpuKNiKcNR+gcsnjRjRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=80KKzFhPCIKfZdn3CP44fmshs60OJSQQbS4jX1YP/Pw=;
 b=arxwqhFv0wggQ7TUFP7hllXjp1a9DCq4mvzQJgTWSbVEQSO9Ms7dGG+kSCFMtkCpisoIS2ciJlT5ezbNf+HkeNWC1E2wFLqaz4TRL+kETyu2zetl9Zb9vllhZLIku5NPNyq6bpKRvUN+aq47ihmcZs844vuCB4o5AwGrEMnvR4mmDsxMCyJAUslJuG/PfBL5Q0oPOI/XzCd+HUnyiGTWGr2upnA7bilkxKtuZ61igBXrqH1bJQS8akt23KOVY7Up1O93YptAmHUDFqpMf9OY+mbHASLT29r0aY71UocxGBHDd8EAvkBMWXrjf7r8jvhzdtzqvnBkC1rgtvRBsAmKcw==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR1P264MB2222.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1b7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Thu, 8 Sep
 2022 15:25:14 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::382a:ed3b:83d6:e5d8]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::382a:ed3b:83d6:e5d8%4]) with mapi id 15.20.5588.018; Thu, 8 Sep 2022
 15:25:14 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     =?utf-8?B?UGFsaSBSb2jDoXI=?= <pali@kernel.org>
CC:     Ash Logan <ash@heyquark.com>,
        "paulus@samba.org" <paulus@samba.org>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "j.ne@posteo.net" <j.ne@posteo.net>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 11/12] powerpc: wiiu: don't enforce flat memory
Thread-Topic: [PATCH 11/12] powerpc: wiiu: don't enforce flat memory
Thread-Index: AQHYLfBPgVzA0P7gY0+HKTq6SVYdAK0d2faAgAnBBgCAAEm2AIAALHkAgAAdmwCAIBSsAIBeDV0AgDCBsYA=
Date:   Thu, 8 Sep 2022 15:25:14 +0000
Message-ID: <219cda7b-da4b-7a5a-9809-0878e0fc02ba@csgroup.eu>
References: <20220302044406.63401-1-ash@heyquark.com>
 <20220302044406.63401-12-ash@heyquark.com>
 <20220513224353.n56qg5fhstbaqhfz@pali>
 <d84e4d24-f350-80fc-6c31-b7e7f8d429f4@heyquark.com>
 <20220520080454.c3cqodsdbfbkmg56@pali>
 <935b426a-6c64-beb0-907f-8c3f0a089ab7@heyquark.com>
 <20220520123002.rd46p5ty6wumi7cc@pali> <20220609222420.ponpoodiqmaqtwht@pali>
 <20220808184034.lskqrk6z3gb5q76r@pali>
In-Reply-To: <20220808184034.lskqrk6z3gb5q76r@pali>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eb1a5116-ab1a-40c9-3dc1-08da91ae53c4
x-ms-traffictypediagnostic: PR1P264MB2222:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X5Es+A8HBVbkcZLv0X9cOsMRE1zvxsRw/FMj2PX1NFPIyoSkO3FMLscU5OT3uWQAhOhX6cQmgVRsEqIGnvVAMePkTqb4zOJUM8LF+FVzQ4VmVVhWTIhRqt1ZOrzpUh3oL1GgkrtrQFpphi82D+uV3f024gr7bi9F11CByoRTutTPq+/qQ5I1tOH7AI2p70ve1VC2k0EQs8AJysBUDpJemUblE5udY9sDCx6rQCD540PddyQTMPvMazwgrWAUzQEd4/hYDbCa+GnJFWOFmjEGVmIv6X45svmAyaLWK+lsiqZhtnsq1wMtg1VOux39UmnyrU87zyVCDGLr2Rd1F2iPxuDnZYTiGeZcvysgyA4uqRNL3PKfybsw4P1Zy+ZQm/h5pVuo7ccxrfQMkmJNpkd45+xpjW2TyP3VphMJSa9dbvy2mZa7vDC0HCnc2IyOrlGRADDZryP/tsNMUItLJO6qX+KPkDexQUZleESeg731rNS0jR3H0rXidXc41vg9w1dNWU6H8oLPW+FYvTYm+jep5aHtCUC0Lm+uFRpFRbzGfPSFP2f+IfCZbtguTKKd4hP7vOEgw1h3bX2N9o91UbALvBvab/mMxuiHcLWlwy849el+57nNoTsGDzlbIW73vMoOuqQKnyL9C50RX69Btjj6XWPz0K3O95FORP46kO7yb7CUI2jgyjnpiH0/lj/I0fmTm5maYliFShD5o7nTAcWSD44914p13gYoNlk9ejK0J8QspApUPuAZOq22d8zc87GkrQBoCoAU3WOKLP13jj1tfJF4EQhOQtgKaRpSPq1llm75E3sSKsTF7DITs945YTh5HPrvQ780Vm8rz+Fd2wDDqA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(366004)(39860400002)(376002)(346002)(6506007)(86362001)(6486002)(4744005)(4326008)(76116006)(64756008)(8676002)(66946007)(186003)(31696002)(66476007)(66556008)(91956017)(478600001)(66446008)(44832011)(2616005)(8936002)(7416002)(5660300002)(31686004)(2906002)(71200400001)(36756003)(41300700001)(6916009)(316002)(6512007)(38070700005)(122000001)(26005)(54906003)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L2R3SU42aEVmR0wvOWNCeUJKNGttdCtqNGh4R1FrUHN6Vyt5YnVGbnFHS2Iv?=
 =?utf-8?B?THk3VWx5cmZORE1GL3dEZ0MxbGpJaWRpTVA4YmlQOUFyNmVqM25VSGwwdUhL?=
 =?utf-8?B?OTVCY1RqTnIrSmZuOWdlWFhBZmxSRGRYSW5HYkcyeWxwV3RTbWJMS1dtdjRj?=
 =?utf-8?B?ZGVJTGZ2ckVSak9xMmQxRkVDblc3UmNLUlhuaTQyZGd2cDlqNDNrRFRkMStY?=
 =?utf-8?B?emRlek1haWxyWWM3Zmw4T1M5YURKa0pZTjVuelBZKzkyMFF2NHhOd29wdlYv?=
 =?utf-8?B?dVd6VmM2cjZLZGtJMGlHSHV4NkcrTUp3VUdyY1pHazlDNHpYR3h0ZTRNcmN2?=
 =?utf-8?B?eEVqd2h5QjBkMlZhemRvQ1Rzc3h4bm9SZVhmUm9LTmVXNkJFWHp2K1VWS1NE?=
 =?utf-8?B?bWVVa0h1elFMeUpNWmpsbVpkTGtqajVuMVUxdXkxeWJYaXBneHR5ZVBDbUhP?=
 =?utf-8?B?Z2pKMG1oeXN5elVoam1LemRHY0pDZGNkQlBMZ2RacVAvWVI2WEJ2UHBMM2ZP?=
 =?utf-8?B?bnl5YUdpeGU2VUVnbVNYNzcvU09ld2hnem1HSDdkWi9IQWtxV0hFS3pxWHln?=
 =?utf-8?B?d1lzamZMOCtPMmg2a05Rcmxyb3U4Y0FBa3FyVjMvR0xuaWRmM081QUJUN2ha?=
 =?utf-8?B?aGxObHhlQnFEVnBwTEN3QnJZbnBPYUt2R2UvKzJNd0l0dmV1Q1BVa04xaDZu?=
 =?utf-8?B?THhBSkRtejAwdTdhclNQWng2ZFBnUE5TMzE0SnhZTHhtZHlLMU11M002ZVNC?=
 =?utf-8?B?dDdSU3YrNzR4ZDZaN243UWtOamNrc2l3aXdObU5waUNFMVhDLzdGc2ZNKzFx?=
 =?utf-8?B?VFprcm1xckM4RkFES2drTXhlYXpqWWZuWjNpNHBmYkFTMkcvM1pKQWg5Rys5?=
 =?utf-8?B?K0ErNWNxZTlmU25ZOEh6WlEyKzVSQnZEV1FKdEhvODdZV2tVOUtNMktLa1Nh?=
 =?utf-8?B?U1NydE1uWXdMajBEM095Y0NNNFBSQlgwSm9JRS9QWHFiNXJaZG9NSDgxa0cv?=
 =?utf-8?B?Q3RYaGFoZXE3dmcwTDYvNTlsb3ArdUdBbHdCbDUxRFQ5eFoxQUtVL0tlQmR2?=
 =?utf-8?B?cDErOTVTdk94TnhpK2VIS0hqbGwxNzVKYm1kU1NhTVlEK3BSUmJBeUxIU2JW?=
 =?utf-8?B?WHJnZ01jdUNPSHlOQ3pQMHJlTmczSWpYalllNDJrYXJsWkRveHRUOXNtVzFX?=
 =?utf-8?B?RUFjTWVxOTNlTWRwdEt6b0xvaFFLUW0zektmeTkrQkpqeUx1ZktlUGVRT2kx?=
 =?utf-8?B?Qy9Mek9HczQxTmdCclY4WWdRTFRCakJFRFhCMHoyZjJEeXRGTDJ2dEVpQ2tQ?=
 =?utf-8?B?aGthWkZRZEFlWkxoVEI0SkI0dGQ4U3l3eVBKQ0kyM1NaeEpKQllzNThrMVlU?=
 =?utf-8?B?czdENHFOeUhGR0tFZGtMaDZacmt5aFJaWC80cHp2SStGbjBEN0Vra1BIREJu?=
 =?utf-8?B?UjFUQXl6VUFnZ3h3aENaL0M3UGdPVHdGTUZzeFhqOGZKRFB3bmVlNjFjN1ZX?=
 =?utf-8?B?b0loWHBJU0RqOGpMMjlyYVJ1a0RSOXFrdXFpNm5oNzdVREYvdkhxY3FORFR4?=
 =?utf-8?B?ay8vampvd1RkaTNSQTJzREM3ZkpFZElvNlJtSDVNWktxVDczUmFyME5vT1Ju?=
 =?utf-8?B?cHNBcWY5S3lYOStJN1Ywbms3akp1WmY5dGlwNzhMbkNDQzgyLzRIQkhpanVH?=
 =?utf-8?B?UFJVVlZ0UTAzQ2VzdDlQbE1SS3orRTdzRmE0ejZPK2REbG5aM1RqQzRQc05n?=
 =?utf-8?B?TlkrSTdIeVdHcG5uK21qeUY3N3JCcTdObnA2ZTVBRlJ4dE5qZ0ZmVklRK08w?=
 =?utf-8?B?ZFlNakJ4RDJqSWpRZWxoRUF3MnhoOXlQQUp6SnZhS0ZrTXdlT2RVUm82c0dn?=
 =?utf-8?B?V0J6QXBYakY4VXlyVXE5U0x1NXczekhtTnQ5WW5MUFNzMjlyZXcwNTRBNFR3?=
 =?utf-8?B?cEtzTEpwQmg5REl6a3JYT0EreGNMczZXUUJXY1RRclk0RjlOcWpPaTgwRy9m?=
 =?utf-8?B?b2Q4ZHFFTWM3NjV2NFYwMjhreXZKSGFNV2tZd1B3aGo0b0h3N2hRM2JFc21R?=
 =?utf-8?B?Tm1maGtPNi9sb2JxcmlwYk00elgwNVE2YXFXS3dNVnJ5ZHBTNk04L2xHaXVI?=
 =?utf-8?B?MUFEK2JHZGZzT0ZDOWtXU0swTjlkazFYeHNpTkVIY2RoV050NS9SQjRPTktS?=
 =?utf-8?Q?KPf30bHNOhuX7MXn82/FaHk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <64F2AAF1D5A84C45A15A4CCDF5C9BAD2@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: eb1a5116-ab1a-40c9-3dc1-08da91ae53c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 15:25:14.1417
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nrM+FD6GuSAKkE6MbZOSdrKUXfEv4rzhjOOXMYdNY4NKSnvzGtTprkuP1jqlbfY6cj5AzCi8p9V3plTypntFj6xrjm0RvQVnVQdK22A4oP8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB2222
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDA4LzA4LzIwMjIgw6AgMjA6NDAsIFBhbGkgUm9ow6FyIGEgw6ljcml0wqA6DQo+IE9u
IEZyaWRheSAxMCBKdW5lIDIwMjIgMDA6MjQ6MjAgUGFsaSBSb2jDoXIgd3JvdGU6DQo+PiBPbiBG
cmlkYXkgMjAgTWF5IDIwMjIgMTQ6MzA6MDIgUGFsaSBSb2jDoXIgd3JvdGU6DQo+Pj4gKyBsaW51
eC1tbQ0KPj4+DQo+Pj4gRG8geW91IGtub3cgd2hhdCBhcmUgcmVxdWlyZW1lbnRzIGZvciBrZXJu
ZWwgdG8gc3VwcG9ydCBub24tY29udGlndW91cw0KPj4+IG1lbW9yeSBzdXBwb3J0IGFuZCB3aGF0
IGlzIG5lZWRlZCB0byBlbmFibGUgaXQgZm9yIDMyLWJpdCBwb3dlcnBjPw0KPj4NCj4+IEFueSBo
aW50cz8NCj4gDQo+IFBJTkc/DQo+IA0KDQpUaGUgdHJlZSBmb2xsb3dpbmcgcGF0Y2hlcyBsYW5k
ZWQgaW4gcG93ZXJwYy9uZXh0IGJyYW5jaCwgc28gdGhleSBzaG91bGQgDQpzb29uIGJlIHZpc2li
bGUgaW4gbGludXgtbmV4dCB0b286DQoNCmZjMDY3NTVlMjU2MiAoInBvd2VycGMvMzI6IERyb3Ag
YSBzdGFsZSBjb21tZW50IGFib3V0IHJlc2VydmF0aW9uIG9mIA0KZ2lnYW50aWMgcGFnZXMiKQ0K
YjBlMGQ2OGIxYzUyICgicG93ZXJwYy8zMjogQWxsb3cgZnJhZ21lbnRlZCBwaHlzaWNhbCBtZW1v
cnkiKQ0KMDExNTk1M2RjZWJlICgicG93ZXJwYy8zMjogUmVtb3ZlIHdpaV9tZW1vcnlfZml4dXBz
KCkiKQ0K
