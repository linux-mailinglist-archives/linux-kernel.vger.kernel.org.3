Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92FA35ADFB2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 08:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232912AbiIFGWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 02:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbiIFGWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 02:22:13 -0400
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90051.outbound.protection.outlook.com [40.107.9.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAED429807
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 23:22:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uj/yRpMunJH7bn7GpUufQf6XFB/d0W30gpV85zPNXAsjdP9U7QHXzYPpkT6Rtz2dfEnaSkTdRUhxdHpSdA3Y1e0+rUeTN1gQMVnJtlyE7sWZyX0p6o3HuGktkBfpC0lJw0ywOjSxZXbm+dm29Bu1mrK+w0tYiQhs/wQUgxIoNyE83sXDYQ8/HrLilbuE8NZSjyCNQgCj11PTIQVJOdcN8lVZNUM3uJpcIKCQ5IzHhQZcVMCQagito03kSmxBwPryeYdxMPHoWoTfzhbVTahp8E+8IbGH54y9TydchNg+UGObasdEmyAoNLRPHiSmPAKfVsAa/NKve6Q6EAeGU27B2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sK7CbAPPEQRKhTO1laiS8J01pMpB7wi6qBLE2sfxjgo=;
 b=MdFvGL2plVEpLCwajAaZZvchbRL9rkGXPxA67RqyaS+/7cMkVJNuKOjjPHPxc2DdvXl4nUeTohgu1AK2KRDQRXPLemGW6EOlzg2YwnjhFp4Oq178qzbTL7qK4za6kSYSBslhiCCFxAYGQySfI1pnUFNIBsQO7sSWMHAIsIlBPdyqc5oxAsXiRDdPyR5s4aapfBQGdNMm5XRrH8hbN984hq/ayihxFb0xgodwCp8ZUiQCgQurOWORMiGBb3AWfNVJyo5Y4EGpzVNwANHSXWE1oEhpXMfA3QXLqTE3L+Mb0ZlUjaJAHBCWXlVScefTlAh89UQAqBMkJ0tABIiS0CrTZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sK7CbAPPEQRKhTO1laiS8J01pMpB7wi6qBLE2sfxjgo=;
 b=IMo+TqIXu3erXRU42dQgISECz/kwWiyBqAbuHQVZ2aA6mycR2nUOiaQQ68d/ACsWyTG3kgz+vp5dKz/fW3y9YlvyWCXL0Uq2/B+p27doZjiK/7Wx35JY6ed4I3HFD1rFiwv6AhexaswPbijXt3VCb4UDeT2BWC9NOtKRBdjM4c/HvcNzRrMGY1a4xx8pGfxGa8bKITnBCOIPmKpOn9I95BjhKA1VG9lQ59OYhijinmN2dZZvbkJ5nTo2/PnHytXqxIYL5j9YCl9+fAGp/81NhxrgCFhq9USqQUXF6IBq/uTtJxgpdaI0cRreCasmrnQ4Jn1KHfLZ2T/7BZL8goRf5g==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MRZP264MB1862.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.11; Tue, 6 Sep
 2022 06:22:09 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::382a:ed3b:83d6:e5d8]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::382a:ed3b:83d6:e5d8%4]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 06:22:09 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Segher Boessenkool <segher@kernel.crashing.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
CC:     "aik@ozlabs.ru" <aik@ozlabs.ru>,
        "chenzhongjin@huawei.com" <chenzhongjin@huawei.com>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "mbenes@suse.cz" <mbenes@suse.cz>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        Sathvika Vasireddy <sv@linux.ibm.com>
Subject: Re: [PATCH v2 16/16] objtool/powerpc: Add --mcount specific
 implementation
Thread-Topic: [PATCH v2 16/16] objtool/powerpc: Add --mcount specific
 implementation
Thread-Index: AQHYu2u+4hgBmN2D8EicOSqvXi2Bhq3I+YuAgABUEwCAB2SqgIAApwwAgAChzwA=
Date:   Tue, 6 Sep 2022 06:22:09 +0000
Message-ID: <d815be50-93bd-8cdb-bc12-b1103345aa1e@csgroup.eu>
References: <20220829055223.24767-1-sv@linux.ibm.com>
 <20220829055223.24767-17-sv@linux.ibm.com>
 <5da86617-53f1-d899-336a-53fe691e76ae@csgroup.eu>
 <20220831175100.GS25951@gate.crashing.org>
 <1662374555.7eoowv9twf.naveen@linux.ibm.com>
 <20220905204300.GC25951@gate.crashing.org>
In-Reply-To: <20220905204300.GC25951@gate.crashing.org>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7e3c535c-db23-4e24-8efa-08da8fd020b7
x-ms-traffictypediagnostic: MRZP264MB1862:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V87NgdWwzedZBC6flCydpDrS8AgiYPiKLmOdLGImTW65x5/4mcLkQ59dBP+vU/+FcsNfRSf2hfNkXz/2Uicf7Kj28ouRhFcYj7rn9RhM6bvHTy2MFiQAdzqLkUy4WXuqVCinlmyeTkmrSQRzs0NCwVekBuRSPkvF7xksSZutm7hpFlBVlrOFhbs8Dwt1e2MHkrBcrBlxLpSE07GZ7b6QUl9Ju9VcQJB0aGMUR6Ph6Q+f2cF578+Foqg3WbkTsXkSgLMKwuZe0ocJ7gtEVSfyL1jaXI/YYL6F9Saek8hxVVzaA+9+mfv3qq7pqSDPS192QZ+wdGlNUwhSx1ObF+7DqiZitfdiua132OnBWEfWmCarXYol/mu3njsPyYp19O3rG8YSbXp/OkP5+SaVHt0LS9NXl6veq38oe37848K2KXSEzH+m05IJxnxs7iVfAO6xvcVhWQMLkjTz54msancla8wzIrKu7qnHUaeH0tbFxTo96Lgm/bqLR7ECteetnrNmjzDFmTLApmuXxZGFBoCUHlTrRaMHp809jBYMpFJtbosadrx8wpe7fWL8YKri6PEwdCYuG3vEw2g81KDZ3Y6sFs6UcBhw/f8phwn7GxCIV/g2s1re5ol31F6bJokXSeMMZP4JqL9WKl+TtLqyZweusi5G/c4HQZ0GPmRNHYRKxR4RNlOwdz5qsVEGZYTEDeU6lq6JS4BbqqzHiHiCq7INDnIAPZIEgmsze2UppaZddAW0CQn7vMHlv+h/bMVQbGvBU4obFyP1UwKodMrucy0gOCx4sy+u4CQ1Of269QNWks+du5iGsZRh+b9zX0J5SUZNSAl9zTn89f6qNnr15Kz1SuEb2Pm+Cs1OXB1zXJpW/J4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(31686004)(44832011)(36756003)(54906003)(86362001)(316002)(110136005)(31696002)(2906002)(38070700005)(122000001)(38100700002)(66556008)(5660300002)(8936002)(7416002)(76116006)(64756008)(8676002)(66476007)(4326008)(66446008)(91956017)(66946007)(71200400001)(6486002)(41300700001)(2616005)(6512007)(966005)(186003)(6506007)(26005)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dUxrcmJ0QkhMREZjbVRnWjF0SE5ORXlsakd4cUdUVG9idUljNjdLYWZmeGlF?=
 =?utf-8?B?RmhDT0c2T1BsMmJOcEcvOVl3Z0xqWlZzajFidDVKa0ZQTm9OZXNsS3hyQm9h?=
 =?utf-8?B?ZzJZS0FGL29LaUl4Ymh2NGxIZmdaa1ZtQXFQN3lNTDFsQ2RLN1JWMGRYTEhN?=
 =?utf-8?B?SmtiQWNaTDJKczc0QW1GYnhRWnNlbWtTTGxDSkl2ZXNucUp4NWlKNUdRSk5W?=
 =?utf-8?B?N1pBRVhSdmQ0aW8zMVhINFNyeFdXelYwKzc4V2hyZHFjcS9nSFA3amptK0hu?=
 =?utf-8?B?OS9GVkVDR1oxaTdNaEd0anZVbXZTTmVlVXptQktMZ29GNVd4MWRPTzJDa3o4?=
 =?utf-8?B?dWVteC90UDlZUzJGOXcrdmhFZzhCZ3hPRFFrYmZ2VU15QU52TU1PWkFYVmFN?=
 =?utf-8?B?WnlxSUpUUmJpbkYwYXhNL3k0bnUySFRvREMxUkdXQStwNlRGTW93RCtXZjdH?=
 =?utf-8?B?clJ4VnZXS3M3Qm52VGI3blpybFdid0ZEOVBrN3FKNnJ1R3N1MXdtUkpTZWNm?=
 =?utf-8?B?cWllV2x3eDJJT3h6S3cvMmp2aXY2VUNFVmI0ZC82Vkl4Ry9yZmZFVkk1WU02?=
 =?utf-8?B?UjVMWlp2NUpZOUJGRmRwSmk0ZEo3TEYweTdVNXB4ZmQ4SHJERzNET1ZSaTQ0?=
 =?utf-8?B?cnhOYm1JMnRaOHN5bklsSEVJQkpqSUE5M282SVlNNzR5T2FyUHRtNEVWQTZJ?=
 =?utf-8?B?K0FyWG9tR2dxNW9jSU4xSWQ2RnlzQ29tOUJhZklYOFppWFlLa1ZWcDlUSHZn?=
 =?utf-8?B?WTdUTDlqL0NMVG5kRVJZRndlOTBkT1B6YmRYaG5KNHc0M0VSYzNTWm1DSDQy?=
 =?utf-8?B?emJlZERiQ20yb2JyWG9ubjJEOURxMWtNcnlNdFVXejNqZ2djUnNCcjMwNWt0?=
 =?utf-8?B?Q3dWQlltd1U1Zkg4MWhKRW9yU2RYODIvaXJZZFJPUlg1eGhXMEFCOVl2OFVu?=
 =?utf-8?B?bXdXVVd2YVhFT3k0R2ZINDllZXg1RlhkdlBNdS9Ndi9PWlJ1WVdsMWM5cTYv?=
 =?utf-8?B?azk2Lzl5bmFBeDdxUUUraGFuVEJ3TmpDUU5nZjZ0WmI5YUdCREhlbnRmYzJa?=
 =?utf-8?B?YzdrYjUyeFBrMjhiZkxScEtpVkJiZU8yMXFtOHBWOE54T2xDYWFBZFc0NVJ4?=
 =?utf-8?B?QktNUHBpSk56M3Fjd2pVTXFMbkpUV3VjWStiME1sWnJBSUdHQVhhaGNnYmhL?=
 =?utf-8?B?QWo3Y2VUNkN1MDVhRi9ZdmFUMDRFUlYyejJBL0dUY1B6dkdnR3BySUZpOWtk?=
 =?utf-8?B?T0RncTBSNTN2anArTFdHTmoyS0c5M2YvQStZSFdmQ1hKTmNkVDFNYU03R3JM?=
 =?utf-8?B?Si94c3VLQ0VyOUdHaUNmeElxNG5OZ3dnZHRNcmdqNHBZeStpUE1EUGN3a21m?=
 =?utf-8?B?TFpSNm56K0o4ZlVVVGpPTE1YWGRMMWo4VGFGL3lQcVJPQTBvZUNqcVlzVHRj?=
 =?utf-8?B?aXRId0hUUGUzWURBMmVKTFNaNHVWdEV6aUlDYUtVQ3BpU2FQVjBSVDV0NGFz?=
 =?utf-8?B?VHMwNHlpQitmWm5CRmlNL0srZkl1OEliMzZ1OER5aFBlWUYrMEdjNERzQXJF?=
 =?utf-8?B?TjBQNmYwNU9BdTJwN2p5ZG5zcityYkMxZjdxVk1qSXRtdmsxWk5wRHQrTUZX?=
 =?utf-8?B?SGJCYVdERHpybE1QdHFrOFp3elRIM3ZLbVN4NjRyd0lEUDZvRjV1dnZMUDJS?=
 =?utf-8?B?Wk5aRThORFZ2YXVpQmNFUG53aGxxYWxBTU51M0djREl0dVVoNGFlM0VTR25U?=
 =?utf-8?B?SldSOU5RZklDRzIwelZSWWFxcU5YL2x2MHl2SkFJblN5cHhkM2h0UEY3Mk1u?=
 =?utf-8?B?WjFrVlVMOVhnQVpOMTVybzZsd3ptSjFkaStzOW0rdTkzek91bmVTMmw5ZWFE?=
 =?utf-8?B?Z3dRT3h1eEJrRVRrNnpBWjRSYXB0M2prMUliRTZreldDY0QrYVMxaUNWbkx4?=
 =?utf-8?B?ZTJPNE5OOW1DeWljeDJvRmVsdG5SK1pRVG1TTW5JdnduZ2VKb0tybW1JYnNR?=
 =?utf-8?B?SndSY3p3bTk3UmpPRFk1YTVhbjM2eWpwaWl6S0U0cFFtbks2QjRNNnJWaVpz?=
 =?utf-8?B?MUJRbU80TVJzTWNYakdVdk1MMHZyOTRmYU1yQnVMb05nRnZ3VXV0VEg4dHpy?=
 =?utf-8?B?TWhZZGFpQ2tVNmJZMDUyMndTZk1zOU5hb3o3bmlDVjNqSFpqZlViV3hnUzVa?=
 =?utf-8?Q?SmAo9ZM+uP24O07s+l8hSEc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <33AA0A206A472146B308CA23ABEE9E03@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e3c535c-db23-4e24-8efa-08da8fd020b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 06:22:09.0747
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LgG3ln4gyDSIu3TD8exh3bfXxYHDoYLI1SSZaNkQIstYK0y7X8Gg/zDilVe7XQLZJfjlZglOd94VzLqFFS6+8psDik7G1C0fHhdbjmButCU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB1862
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDA1LzA5LzIwMjIgw6AgMjI6NDMsIFNlZ2hlciBCb2Vzc2Vua29vbCBhIMOpY3JpdMKg
Og0KPiBIaSENCj4gDQo+IE9uIE1vbiwgU2VwIDA1LCAyMDIyIGF0IDA0OjE1OjA3UE0gKzA1MzAs
IE5hdmVlbiBOLiBSYW8gd3JvdGU6DQo+PiBTZWdoZXIgQm9lc3Nlbmtvb2wgd3JvdGU6DQo+Pj4+
PiArCQlpZiAoKGluc24gJiAzKSA9PSAxKSB7DQo+Pj4+PiArCQkJKnR5cGUgPSBJTlNOX0NBTEw7
DQo+Pj4+PiArCQkJKmltbWVkaWF0ZSA9IGluc24gJiAweDNmZmZmZmM7DQo+Pj4+PiArCQkJaWYg
KCppbW1lZGlhdGUgJiAweDIwMDAwMDApDQo+Pj4+PiArCQkJCSppbW1lZGlhdGUgLT0gMHg0MDAw
MDAwOw0KPj4+Pj4gKwkJfQ0KPj4+Pj4gKwkJYnJlYWs7DQo+Pj4+PiArCX0NCj4+Pg0KPj4+IERv
ZXMgdGhpcyBoYW5kbGUgQUE9MSBjb3JyZWN0bHkgYXQgYWxsPyAgVGhhdCBpcyB2YWxpZCBib3Ro
IHdpdGggYW5kDQo+Pj4gd2l0aG91dCByZWxvY2F0aW9ucywganVzdCBsaWtlIEFBPTAuICBTYW1l
IGZvciBBQT0xIExLPTAgYnR3Lg0KPj4+DQo+Pj4gSWYgeW91IG9ubHkgaGFuZGxlIEFBPTAsIHRo
ZSBjb2RlIHNob3VsZCBleHBsaWNpdGx5IHRlc3QgZm9yIHRoYXQuDQo+Pg0KPj4gVGhlIGNvZGUg
ZG9lcyB0ZXN0IGZvciBBQT0wIExLPTEgd2l0aCB0aGUgaWYgc3RhdGVtZW50IHRoZXJlPw0KPiAN
Cj4gWWVzLCBidXQgdGhhdCBpcyBub3Qgd2hhdCBJIHNhaWQgOi0pDQo+IA0KPiBJdCBtYXkgYmUg
ZmluZSB0byBub3QgKmhhbmRsZSogQUE9MSBhdCBhbGwsIGJ1dCB0aGUgY29kZSBzaG91bGQgYXQg
bGVhc3QNCj4gc2NyZWFtIGJsb29keSBtdXJkZXIgd2hlbiBpdCBlbmNvdW50ZXJzIGl0IGFueXdh
eSA6LSkNCj4gDQoNCg0KQnkgdGhlIHdheSwgSSBwcm9wb3NlZCBhIGNsZWFudXAgcGF0Y2ggdGhh
dCBoYW5kbGVzIGl0LCBzZWUgDQpodHRwczovL3BhdGNod29yay5vemxhYnMub3JnL3Byb2plY3Qv
bGludXhwcGMtZGV2L3BhdGNoL2ViZTExYjczZDEwMTVhMTcwMzRhMmM0YmVkZjA5M2ZhNTdmNWQy
OWYuMTY2MjAzMjYzMS5naXQuY2hyaXN0b3BoZS5sZXJveUBjc2dyb3VwLmV1Lw0KDQpDaHJpc3Rv
cGhl
