Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA7E532374
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 08:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234095AbiEXGoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 02:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiEXGoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 02:44:19 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2075.outbound.protection.outlook.com [40.107.114.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4B97CB16
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 23:44:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fXsNTYb8F27wohOtQAPw0fQgzdEWUpdgSdxFJdmwEhteJjO+PiqQrnweYgb+EAGrlih5Rxibcdf7gEm8lVhvN+fDX51+eRE9Zru+8L+EuDAVdW0ehUgp5cIjeVFypOL78HTGD1lWM/9TUXX24MayJ4ZHMnKbRhnMSZ/IJg3ah4MTz7+TeadeFTRCPxIiDM13fj/kZp91kVqxo0i87KzB9GToKbvj34LgLxDmz3fiTSWCphNvCFwnfMJkYsljRFQ/OcV3cWXbk8T65Anc2ZWx5UR6BhXbsIkHGAd8pdMa6ABXBgVA66/6BElf4M8JYPuXutH+vgFjX8RVr91J+pqrnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TNJV9193TaE2LQIgszaPry1f0mfL5aEj9S13YHlWPXc=;
 b=jgcXQrioiQVhr9UNcR9Xa2TFPFsA4KWIcd34hw1+SIG9SeZSdtbb2MTvr8UGSc0VDlo3tMF+/4pjzAX4k7NqjeMY66vnqxB7Qu8WetjeAUrAhMNdSFtIpaErU8Jyh9E4v949n1sK7s8Guk/d+xRDzvAz3obD/5H4S+eRGfv4qf1hjW4hLgN38WjyQV2Kdh4RVxK8uRAjoxwUFm79wfiwYGrCBpWLQ/xedAPkBKT//irRNNJJ49YvrA43jh2BmRc1fYq3XsWVUcmWkdX+SEg1WFk1xb/kzIUw1CeI+MO0deolk2ib2agSVSwlhvfCujNS5UkPLX5h4VqsebTYU1cEMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TNJV9193TaE2LQIgszaPry1f0mfL5aEj9S13YHlWPXc=;
 b=TbsJ+ksS5gS6FgKodh//alm+0DGUVpcdcrqXv0CC/9fHUuIFE8qZa8acnNiRPCGTufZ7WN+yQP2215vFxSkfiep3tfQACAA0eSenGgPRNb9FPzd1Idb8+qvJaMwG3w6tBkHGNBPBi9FbV8Rzq7O+zTbC0ddi2aCbzMGyc4vpl6Q=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by OS3PR01MB5864.jpnprd01.prod.outlook.com (2603:1096:604:c5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16; Tue, 24 May
 2022 06:44:16 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::246b:9355:73ad:b995]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::246b:9355:73ad:b995%2]) with mapi id 15.20.5273.023; Tue, 24 May 2022
 06:44:16 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hughd@google.com" <hughd@google.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "neilb@suse.de" <neilb@suse.de>,
        "apopple@nvidia.com" <apopple@nvidia.com>,
        "david@redhat.com" <david@redhat.com>,
        "surenb@google.com" <surenb@google.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "rcampbell@nvidia.com" <rcampbell@nvidia.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 4/5] mm/shmem: fix infinite loop when swap in shmem
 error at swapoff time
Thread-Topic: [PATCH v4 4/5] mm/shmem: fix infinite loop when swap in shmem
 error at swapoff time
Thread-Index: AQHYa38Hnv+yD7ocokSyVBX8dxzd660nUFeAgAAc1YCABCoXAIAAwQT5gAFEGgA=
Date:   Tue, 24 May 2022 06:44:16 +0000
Message-ID: <20220524064416.GB774480@hori.linux.bs1.fc.nec.co.jp>
References: <20220519125030.21486-1-linmiaohe@huawei.com>
 <20220519125030.21486-5-linmiaohe@huawei.com>
 <20220520063433.GA584983@hori.linux.bs1.fc.nec.co.jp>
 <970aee34-c377-2b8c-c6bb-45e2a96e84b9@huawei.com>
 <20220522235326.GA713751@hori.linux.bs1.fc.nec.co.jp>
 <7269c0c4-7648-a9dc-10fa-3645da5be441@huawei.com>
 <139b521b-f477-d108-79ed-4ea2bd76bdf3@huawei.com>
In-Reply-To: <139b521b-f477-d108-79ed-4ea2bd76bdf3@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 700942b9-74c2-435b-7c6e-08da3d50d281
x-ms-traffictypediagnostic: OS3PR01MB5864:EE_
x-microsoft-antispam-prvs: <OS3PR01MB58649E4F347F7F277194E592E7D79@OS3PR01MB5864.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FDyZW+3b3UR6zEL0WuMNQNAaOXy3vXyV4j7HboSAP0piy7bgdLTQZsFbwmPxnOCYNsJzOuBI5S4Lqo4+PwLFEU4vxvM2YVYDV9JJceCDKARSkKllk3iy0+ZnNQS/5LFL5qXhiP4muyIjRtWNXLWjKsVJJmHL1adIpRfeMHkp4LDeQ1QOn63SLh9zru0eNvtjzkdlTyC8kUw4AzrY254gGOS68LVBGKH6RQWWhiX6PgwoGhu+CGZd9HQeyqjU6EmEBBuQDnq7TiZR5p+iGRATAdPP3EXQAG+6P+ZTBklnGnWTY5t1/uJ66vYyBCYpEJM+8U8eMOHWMpX2Wlnv9SkFiteGUhZEDZ1VWTAIg9OrfliV/CcCYkwfEgLBxjJ7CxnB4Z8iDk/R395mJFWl8uhZ0C5BUDE5VRgAZXqGc3FBe7BhonZefJR4pRUTDBzev/3paszJPeh/kDPqYFB9w2W/T0b6oTKLebZv5IuvYpxq9wt37NCNJCOk+AQ+kZf4kEsXOKLuyVzZYU3y3e2UINE7GfqX42esp+owjGfy7EL6OuGVim73WMpjeDvIreayIMdaI0jtQtofgQhl9oeUq0vsIAmM28tAz0Ce7LBuAO0TkIL6NVSHWTTIhLnXJk6suOAnHFwJwbGynQyn32KfWIj3Oy28rg31k4JMgMX1krvdJ/SIVpql1i0v2w7HhxSxZkAMSJ6eFhnTjMFt3fOzgZdLgdH9S9DsOc36ofUmUzJYImggR5EJHOTP7M6sPorXSfvn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66446008)(8676002)(9686003)(4326008)(55236004)(71200400001)(186003)(122000001)(1076003)(66476007)(64756008)(66946007)(6916009)(85182001)(66556008)(76116006)(316002)(54906003)(86362001)(6486002)(508600001)(82960400001)(8936002)(7416002)(26005)(2906002)(6512007)(38070700005)(38100700002)(5660300002)(6506007)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZVlKQmJRZmhzRlJpZEI1YXRSWTZ5dUI3R3p2V2txS0dLb0w3Y1E3anFvdktk?=
 =?utf-8?B?ckRKamFycjlqU1VobjFsYk1lWHRleTYvZng5ZlhLU1R4NFpKREsxSU9CK2dH?=
 =?utf-8?B?bVdVQlBwNTVkWUtMTGxVc2ZYVm5jSm5yb0Y4bTdpYmVrRlRHU0VmUWNUSVM5?=
 =?utf-8?B?SmNYZXlSOGR5eGJlNW9zbnJaMUJTdEttRTF6dWhPTDRPYWJXY1ZxbGk3M0lW?=
 =?utf-8?B?dG1UNlR4QlBDTFROWFlEK2lWU3R2ejNSM1JrRmg5eGNxMzQwcWRjbUUxdy85?=
 =?utf-8?B?Z1RNa0lEQlNWVHQ0KzVwZTUrZTh1aGd5aDhvV0tqSFVuUDRTSFk2dmcraFRD?=
 =?utf-8?B?b3VpZlJ4TkVxTElBbjVjR0tkeHQrV0tnSzc1TU1TYWs3aDNmL0g2MzZUQ3FH?=
 =?utf-8?B?L1pmYTRmNzlpT2hvMWVaWUhvNlFBSTBxQUZKbUhkMXZ3eUNhNkhxMVRXSGti?=
 =?utf-8?B?UGFrU3dRUUsvNzBOenpRTHBPeU0yMWV4eUVuSmhCYTZUTytKdzlVeEtRemFY?=
 =?utf-8?B?Ynl1YVpFVUhPL0RWMFBoSHBHMWZSd2JrWWNOOXVQN21NSVZ2bHZ0WkpQRldV?=
 =?utf-8?B?bnZ3TnZVYyt3OVVtb20vOE1jbmFGVXdjT1g5K0poLzZkVmhoV0NEQkliOWZI?=
 =?utf-8?B?VFVYclZKdk1aN21JdDBsd1UwR01RNm9PeDdUd3N2UzdMMkVTb1NoSjVhYU1t?=
 =?utf-8?B?QnFXUENXOStzeWNxWjl4ZjFqS3lYbDcrNUQyLzZIejdwZ1BFVTdQdEJlbFFi?=
 =?utf-8?B?OHJhMzBlelRNcFU2TS84MmxjMWRKTmdQdE1scWZtUFRCV3ZlN3ZQNzFPWktP?=
 =?utf-8?B?dkRJdGlDYk1RSU1CUXdiVXBpNSt2aFgzNDFBWjJoUVc3ZUYyUUJhTVdjLzZi?=
 =?utf-8?B?dDVCUW9uL0hUTzI4NFJXRGowUjhnRFE4NnZDSmRhRzB1OEtITXdLemlYRkg1?=
 =?utf-8?B?NXBaY0c4eCtWY1hybHlYKzBmUU9YcmJBK3E5TXBlZ2NoQW1vOGFnOWVkQ1VL?=
 =?utf-8?B?d1dVb1dYdklabWRiV0dkZkZabjcvMndjYlRDM25aTnREM1dqTDlYdEtKWUJv?=
 =?utf-8?B?TTRVVkVTSTNMZi9iK1cyNmFGeGhVWVhBSUJPNUdiNFhlRFRuWUNhNjZIY2RE?=
 =?utf-8?B?U3NVLzNyQzNBbXBEYUNsUGNMa2xyTjQ2WkZKeVQ5eGpTcy84S25CN1BXQkpB?=
 =?utf-8?B?YzJQWXJpdEJwTlRvRFVITkR2LzVpNXdaaEVYdEtyUTRSSmhqYVc2WnFucDEr?=
 =?utf-8?B?WHJqeGgvOW4yM0w3ci9YVVExUUpSRThKQndEZ091RGJDOXhhMGE0b25rTXN3?=
 =?utf-8?B?bGNxSE93MGFlTktMamp0bTVnN0JMOGY2V1VHTUNvOUVSOFBGRTI3bDFETzM5?=
 =?utf-8?B?UHV5VHpCU01NSEU3anBCMXBHczAyeHVoWS9rbittTWptbFRnYzlUZGFEZ2ZF?=
 =?utf-8?B?SFRwQkNSUUhEamVsbTAybUo1Y0xYK2JoTXJ3SExIQU9UbHNVTlNkMStnRnhC?=
 =?utf-8?B?R2ZhVUIrdloxb1JCUDh3cHFFWHdBQ3NXa1NWRGhpQTVYN1hpQkhSRldZeDQy?=
 =?utf-8?B?eVZTaE9LbFI3YjNMZnlyZzlpZkc3ejVnK1I2c0E0RWRxZWlOclh1bWRpM0cy?=
 =?utf-8?B?MmJPY01tNXNXWVZkZVNPblV3NTJEbit3UkJFNjJmNmVJWnl6OGlxN3NXUnZZ?=
 =?utf-8?B?amMvc01QaXkxb2RoN1RWUXc4Vmtpdm1Rakh1YzN6cERhOFRubkhza3pjMFFW?=
 =?utf-8?B?R0Nic2k4eHkyL1dGZFpvWHhRUnBWMDVFY01US1VIZ2ZZdzlCNlQvRmJJbTRj?=
 =?utf-8?B?S2VackZqdm82OXNOLy8wOHlPNHF1YXNKcHRia2ZLQXc1NWFwRUZpaWExczB0?=
 =?utf-8?B?QnZBMERDL1g4RUlIVkttZUJSejFxYkdKWXd1R3BNKzBwOVN3Yytrc1IreHlv?=
 =?utf-8?B?QlNMYzhNUUhaaStKYnFMZldZMTg2R1o5QUhCdUpVaVJGdEE0ZlNoZ29Dc3NG?=
 =?utf-8?B?bUZvMXpGNno4cGQwVGFJUHh1VEM1K1d6TTI5M0JCTUliQXZsc1crVTd5bXZR?=
 =?utf-8?B?ZmJyRU0wbzNjaXF0QklPMUFJZXYzNTh3Zzc2MStYZGRlM3doWGxjSWF0WEta?=
 =?utf-8?B?VS8xQ2lQSElkeVh5MklQbCtDMWZQSk5HbDVjNStQY3lBMjlycC9mbVdrd0xJ?=
 =?utf-8?B?TjI4a0tFYmszK0tSNVRTbEZpWHA2ODhyTUZYZlJrUDUwbEpEbnJTQ2h0U2tD?=
 =?utf-8?B?MDI1QVhPa3daZkhWTmNpQWR3TUgvM0R1MVlTUm5qS1pxK3o0WmpKNHJ0Z0tv?=
 =?utf-8?B?ci9yUGtZWGc1NWo5am8xUXpoVStWbW1wRnlKSDJ5M1B2OURwdFVHdjRreFor?=
 =?utf-8?Q?r3+YWnceEZH4+vtc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1822A1DD3CF1A749BAA355ADC395C5FB@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 700942b9-74c2-435b-7c6e-08da3d50d281
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2022 06:44:16.4569
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J3S7GrZudXCSAcUM6Epk/ftw1wl314BDSmcBuIEF0en399doRGBxVyEcLMIUSXqEU68VPjHasXXJ/K6nc6WIhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5864
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBNYXkgMjMsIDIwMjIgYXQgMDc6MjM6NTNQTSArMDgwMCwgTWlhb2hlIExpbiB3cm90
ZToNCi4uLg0KPiA+IA0KPiA+IEkgcmVwcm9kdWNlZCB0aGUgZGVhZGxvb3AgaXNzdWVzIHdoZW4g
c3dhcGluIGVycm9yIG9jY3VycyBhdCBzd2Fwb2ZmIHRpbWUgaW4gbXkgbGludXgtbmV4dC1uZXh0
LTIwMjIwNTIwIGVudiwNCj4gPiBhbmQgSSBmb3VuZCB0aGlzIHBhdGNoIGNvdWxkIHNvbHZlIHRo
ZSBpc3N1ZSBub3cgd2l0aCB0aGUgZml4IGluIG15IGFub3RoZXIgZW1haWwuDQo+ID4gDQo+ID4g
QlRXOiBXaGVuIEkgdXNlIGRtLWR1c3QgdG8gaW5qZWN0IHRoZSBzd2FwaW4gSU8gZXJyb3IsIEkg
ZG9uJ3Qgc2VlIG5vbi11cHRvZGF0ZSBmb2xpbyB3aGVuIHNobWVtX3N3YXBpbl9mb2xpbw0KPiA+
IGFuZCBzd2Fwb2ZmIHN1Y2NlZWRzLiBUaGVyZSBtaWdodCBiZSBzb21lIGlzc3VlcyBhcm91bmQg
dGhhdCBtb2R1bGUgKHNvIEkgcmVzb3J0IHRvIHRoZSBhbm90aGVyIHdheSB0byBpbmplY3QNCj4g
PiB0aGUgc3dhcGluIGVycm9yKSwgYnV0IHRoZSBwYXRjaCBpdHNlbGYgd29ya3MgYW55d2F5LiA7
KQ0KPiANCj4gU29ycnksIHRoZSByZWFzb24gSSBkb24ndCBzZWUgbm9uLXVwdG9kYXRlIGZvbGlv
IHdoZW4gc2htZW1fc3dhcGluX2ZvbGlvIGlzIHRoYXQgYWxsIHRoZSBzaG1lbSBwYWdlcyBhcmUg
c3RpbGwNCj4gaW4gdGhlIHN3YXBjYWNoZS4gVGhleSdyZSBub3QgcmVhZCBmcm9tIGRpc2sgc28g
dGhlcmUgaXMgbm8gcmVhbGx5IElPIGVycm9yLiA6KSBXaGVuIHRoZXkncmUgaW5kZWVkIGZyZWVk
LCB0aGUNCj4gZGVhZGxvb3AgaXNzdWUgb2NjdXJzLg0KPiANCj4gSSBhbSB0aGlua2luZyBhYm91
dCBleHRlbmRpbmcgdGhlIGZ1bmN0aW9uIG9mIE1BRFZfUEFHRU9VVCB0byBmcmVlIHRoZSBzd2Fw
Y2FjaGUgcGFnZS4gVGhlIHBhZ2UgcmVzaWRlcyBpbiB0aGUNCj4gc3dhcGNhY2hlIGRvZXMgbm90
IHNhdmUgdGhlIHN5c3RlbSBtZW1vcnkgYW55d2F5LiBBbmQgdGhpcyBjb3VsZCBoZWxwIHRlc3Qg
dGhlIHN3YXBpbiBiZWhhdmlvci4gQnV0IEknbSBub3QNCj4gc3VyZSB3aGV0aGVyIGl0J3MgbmVl
ZGVkLg0KDQpUaGUgZXh0ZW5zaW9uIG1ha2UgTUFEVl9QQUdFT1VUIGZyZWUgc3dhcGNhY2hlcyBt
YWtlcyBzZW5zZSB0byBtZSwNCnNvIEknbGwgc3VwcG9ydCBpdCBpZiB0aGUgb3JpZ2luYWwgaW1w
bGVtZW50ZXIgYWdyZWVzIHRoZSBjaGFuZ2UuDQoNClRoYW5rcywNCk5hb3lhIEhvcmlndWNoaQ==
