Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7338F59E9D9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 19:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiHWRj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 13:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiHWRi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:38:59 -0400
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120085.outbound.protection.outlook.com [40.107.12.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69FBBA4052
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 08:26:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wf6vmpnVy6QzQX8p/q5ilPBipg6evNKG791baTofiZwHyi6UTZd9U6xh+4KJvcQq+LyZJEcnqBmrILrOrMChS+PLkwHg3z424sa8F5PRg9PopkJXDQeXaevLIO+Vc5yJCDfJWE7+xzDTEBBFLNxwClz/0os+CeNdaZnYybyg31/MOkG67KhKGGv891mnAvnzdqE74b99nraZWeWnuXbi2axiJfNF0NMb2hiG/ptN6vsqpuyZJvPSnB3STgJIwM3vMUshIO5o48bkFr2INw1Cvmod5EXTmJZOOuHa8IkpSFJYQwHQbcTiFWaQuA9vQDpJ8d6l2hAT8LiIi92nSDHjSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BHL8tJpfz24ONh8HcgGi/AHgcFTsks4Or+PmDSXJXuU=;
 b=CvSu4uaof7FWPg5rx3mRxu1JtiDdtblqbW7vFRhBQZ0uEdVp8hgjhWWcPnG7X37Y3BGuCWlUOCknFVfHExlcIAomXPJBbZFbtI8pYuAlXbd+6nxHP3OD7n3iYAqmcIs+Gy5thLd8bmfX4aucrg+99F3ghZKFi2uKbY11gtQ2o/0R7nVhasuQS5iXvRSD0oJB88jwYdStyYPjlqdwb8vecrs+aFAzsD1yHf4aXNPt6Vp2ACLtXB2W3WrCSDvCklAVRyaFlMlp+ZruDsNhi0vdwerS2qRaG6fIlaJMi8x5/esLR3RFKkKqgBkHdhRhFg7qtyKx6OrI2Fot6dMAHmw3Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BHL8tJpfz24ONh8HcgGi/AHgcFTsks4Or+PmDSXJXuU=;
 b=hYs6cHTTCNev1z1Zrp5oVWiSWd8x2Iq4ojlItAfKinmy4PbIGMSfzN02ESbQXZn9YdTNlQy+F92hMFoL9/cOybLGP7EgwOwuyXIsfhKXDqNphS7y4YoOlVr2FvM5VM7XBj+tYihWsg21Tk80FV/hbQqcXyplkf6dFUELF/cbXXajN0f9dil+k0F+TgAMpuATQ23pnmxqV8iNqj4msdjPTfP0Eu5UeDX8ZBmeMxDDuVXHaeCoy6Ib8OyZx+Dq4ygtVpBUVu7cFka/652bY/9Ee5tGNnFbn5aQhhttRY+bMsDTHnTkQ8XBTtzunc2izAC/JYv0lYETDUp0xeGT56kqCA==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB2709.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1d0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.18; Tue, 23 Aug
 2022 15:26:07 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::888e:a92e:a4ee:ce9e]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::888e:a92e:a4ee:ce9e%5]) with mapi id 15.20.5546.024; Tue, 23 Aug 2022
 15:26:07 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Baoquan He <bhe@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "agordeev@linux.ibm.com" <agordeev@linux.ibm.com>,
        "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 01/11] mm/ioremap: change the return value of
 io[re|un]map_allowed and rename
Thread-Topic: [PATCH v2 01/11] mm/ioremap: change the return value of
 io[re|un]map_allowed and rename
Thread-Index: AQHYtCxluEXLt15y9kSkQpSsai/RVK26d60AgAEsPgCAAFTlgIAApOwAgAADPgA=
Date:   Tue, 23 Aug 2022 15:26:07 +0000
Message-ID: <429cb367-923f-bb3d-ccf0-57dce0c7f35b@csgroup.eu>
References: <20220820003125.353570-1-bhe@redhat.com>
 <20220820003125.353570-2-bhe@redhat.com>
 <d5272f42-f3e3-b2a8-428e-bd7815cf7518@csgroup.eu>
 <YwQdRg/IS0+3tbNu@MiWiFi-R3L-srv>
 <a4a9ba6f-9891-cc4c-e512-d221141d998f@csgroup.eu>
 <YwTu1kzcIUxsTL4j@MiWiFi-R3L-srv>
In-Reply-To: <YwTu1kzcIUxsTL4j@MiWiFi-R3L-srv>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e59502ee-e52a-4dad-ee25-08da851bccf4
x-ms-traffictypediagnostic: PR0P264MB2709:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oMp0TZtQG6U24nIrY6ou0nCb3m7rL9/97wazCTrkYO2/vbfWmV6VKR8s/4R/H82VzTlv7FxVFXo3VVoqFPbspArCBi1YCnEAL2NwAVhMBbO8//oSWx+Y9R0U/1NK/FMbtq2NeNRqGys3tAx8TYLdMJPOwUazpIlePtu5H5veA3mK2GjAEBLYzX4d2n5ZwinJ7EsDb6bknildGrotXnWSm+XaHIZIJ5ev6aeIIXvOhIu4TrJJ2zNpFQqIV4qWFV/+TLIYuuYcYHRJ0JjFOCVUVI2hvo625k6fJDQJLq0mJLUkDEYGNzZlvJPCMXkzXLK4C83J7hz05FW/HvjmG8ifpQed6sMASJi+YuBp8rz4jRkLby5Vrnzv0pAKiplhUUXGz8++QKaS/VR6ZWoD88iyeG60XzB3em/yOczzqbZGHvSYckS9Uvl/wdZ9EXBiwfzP6m2lQ4Xu/Fxh9ywr3Nb/5vOwHoB+1o3jzPyhgvk85woIOutrOiE2HJ3ukk5pPY4QeQzgD7OqMHDX7mbUe9NPhiFokq9/WO8d/sTFyqFz4KfYb7Hah19mlJLOM2g/Etra9oYues7knPi6Lk3HFCPCmITySFl4SMMml9A7tMxhvS06558a0ZA58E16y9tVt6Mk6BrSCXwkM2tFGyONA1u1U+MUi5g38IDr1ZBWslKSSUJPfbregLRiuqwbumnRjq8NBEiD4YyeM1D26F+Ai+wv4hB7hT/+v9Rlupcxyk3bTHluLvfXawUY0CxF7cQ/LBpMNV9UU6LJ5svxUHl1kYpcrVWf+zZ39cLuHQEYVNMPfEauzGR0kkkbM/TolECc6659uHyBFJEdP4pFnQ024yqTyQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39850400004)(376002)(346002)(366004)(396003)(8936002)(66556008)(4326008)(8676002)(64756008)(66446008)(91956017)(6916009)(54906003)(66476007)(36756003)(38100700002)(31686004)(76116006)(66946007)(38070700005)(86362001)(31696002)(122000001)(66574015)(83380400001)(186003)(26005)(6512007)(6486002)(41300700001)(478600001)(71200400001)(316002)(6506007)(2616005)(2906002)(5660300002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UFZrMDNPblhYT2o0c2FXSWc0UW5CUEh4NUdGUHlna2dwclNtR3ROcVdhOHZz?=
 =?utf-8?B?RzBTRGp5UElWcThBRDFtajJBKzd3VkdMVVBXUDZyUm1NVlF6cWJiTGx1TGdh?=
 =?utf-8?B?OGZuV05SdjljZEdYcDh4ZGtkRjBIOEIxcDRTU1ZpeTVpZzlmMGlESnE1NnNL?=
 =?utf-8?B?d3c1Y3RDWEgwMmlWU25DNGFlZ0FVS1ZpR09VUndEb1o1L2dIMVlIaEFqYVJE?=
 =?utf-8?B?WkxQWUFJYWREQVd0MUVhR1kvVGowb0xFT1FRVk45WW81eXZoTFhLano0dTJ0?=
 =?utf-8?B?L09Cb0VMVHBDK0JJTWdPSzJYM0Y1cGt1SnpnNU1NcjdrZWVORkh0UDhTb3JJ?=
 =?utf-8?B?OE1MSXQrN3JTWVk0UUt1MmdYNk9aY1RKemIvbGo4Y0VqWFZsLzhZVGxpdXNk?=
 =?utf-8?B?Zm9oWXZ2aDhiZkYrcXJ2QjBaeU85QmR4UUFGK2tnNHJSK0ExWFlKK3Q3dXpk?=
 =?utf-8?B?cnJVQkFEYlByb0l4cUpsSEdHZG9GVUFkT1pwSVBJSnNpNmpNN0YvYlBRUk9M?=
 =?utf-8?B?R1NYT0V4ZDRGZERYTUpoM2JNQmh6YU9HWDZ6K3Bxa1dnRTdoaWJ0ajRpU3ZJ?=
 =?utf-8?B?V2hkNGlDTU9SN2h6RlVLdnZsMWtSZC9EZkludmJMcDlRVjFhY1pLSlluaEll?=
 =?utf-8?B?emdZTmNBNi9jUTlpMWpFQmFhV05OZ2FqS2ZudDJoSzNEa1I5bXdGWW51Nnda?=
 =?utf-8?B?Q3R6RzZITVRqK28wTDY2am1MNjlBY3dnbGVDY0JUdThCb0h6dkg5aUFWVkNy?=
 =?utf-8?B?ZUp6VndUTjN1U3ZJeE1lS0tMODduREVGZ2tqeCtpdVdpbVBrMzZSS1k2LzNM?=
 =?utf-8?B?clh5RkRZM2hTd0RBMEVKWFp6Wjlnd2tvamR2a1VTaktjMVFzRXZPbjMxLzFH?=
 =?utf-8?B?Vy94SHNEN2VMZzYrT3UydEFpaU9YdTdRYmN2N3Nndlp3THJjUUpVSnRQVEZZ?=
 =?utf-8?B?NjV2ZUU1blU2a1RrL1UxRFdvK0Rxa0ZPK3lnNzB5Q2xQTzFYbHRlUzUxeEVU?=
 =?utf-8?B?cmtTcGU4bFlFazdGMGx3Slh2cHVHWlhXeDdMcXhaYXlZMWxDVnFGVmM0MUFZ?=
 =?utf-8?B?LzZCZk0zaUdjcFRTSXo2eEczaVh6SUk2a0FDZUlHV1hhOHFWUjNUbzZRYnln?=
 =?utf-8?B?TXNUZjVIczh3Q1hpTVV1QkJOYXdwenRZTUV3R3QrSC9tdGtjM0krMkZSWHZW?=
 =?utf-8?B?MndpQjZmUGJXaHNxbnpGeXB5OVdLL3ZrRHpDbjJoRmt1Z1l2U2VmSHJ5VjJm?=
 =?utf-8?B?TlNIZWh4S0c0bHRLNTF3NXpucW5EK2ZrT2t1K3RSZXhxUEdkOHdxVFFsWHhl?=
 =?utf-8?B?L1JreExMZGFQMGwvZW1PcFN1ZkVyMUs4ZW5JTXpxRWk2QmxLNVVKTkxJazNL?=
 =?utf-8?B?ZmJicFRtQS9XS1pMUFpYNnBaaWRVUmtUS3FNM0RXL2lLU1VodG1yeW5UclVq?=
 =?utf-8?B?ZWhwVU9nbGsweENpeHp2MjhrVlk0bHpwQlV2SGlmaEJ5N29mQlFHV3lrTFpI?=
 =?utf-8?B?V3NOa1ltMUM4NlNKN0dWM3Zxc09zczNJbjh0UEVmN1lKVFpzcFlibWczSWdK?=
 =?utf-8?B?QnBVZ1dCcENSK3RqZi9pdzhWc3BNb05seWlCYzNTZy9VVDNDN1NyRFByNTlL?=
 =?utf-8?B?STJ1MnFtSXM4VEJXSVUvVlBQWlNNTktTYmluN3pKZEFaUXhISDZsQ1YrUlFx?=
 =?utf-8?B?ZzNreG51NC80ZUdsYnlZbDFpZGFRbkI0MUVjOXVhQWYvR2h3dWFEcnArcWFk?=
 =?utf-8?B?VE96TU5WZGhDYVFNaldSWThzT2p1YkIxenI0aWJJV3V5dEcyVkFWbVNSZ20w?=
 =?utf-8?B?Q2huanJheEpJdzRnQnJCTzZuOS9tanR0cDdXc3ZzQ0pUTEIyMlhRT25oMnJn?=
 =?utf-8?B?OTdqTXBpM0RWcUd6a0JHa3RWRGJKMHBxVjVuVHh6a042ZnhUQnhTNHRuN1pN?=
 =?utf-8?B?TG9NclhzdzB5a2c5QkFtTlRpcjY1dy9NVjAzcWs5c1MvLzNtQjhMZ3BpN3FK?=
 =?utf-8?B?VG9oY3NuRzBYZ3hmRjA0Mm02anR1SHFXcElFV3NOT0xhUXdNSnRTTTJCZFZt?=
 =?utf-8?B?V2ZQRmFiQzZwZXhSYXhrVGVYMWYrLzg2TjFYaDhydTJBcGcyVGpobUU5V3lV?=
 =?utf-8?B?ZWNGZDZkem1mUUtYOTIxSkhaaFNucVc1dnJwSW4rcisxWnorbXRpN1l4aldw?=
 =?utf-8?Q?TZpHbeUUwWuChIEIYWh95c8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9C4D9DE6EEAF1E45B4A120ABAF22F1FF@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e59502ee-e52a-4dad-ee25-08da851bccf4
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2022 15:26:07.5249
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9y65eWyfBrLsSu20oTOG5+7FrXzMVBbNzdE3A9XQ0AjFnqLif6dGRBdq6BHM7kAk42AESdcI4q+iDE8RN3p2tEJrQBQSOUOkgssgSUIzejs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2709
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDIzLzA4LzIwMjIgw6AgMTc6MTQsIEJhb3F1YW4gSGUgYSDDqWNyaXTCoDoNCj4gT24g
MDgvMjMvMjIgYXQgMDU6MjRhbSwgQ2hyaXN0b3BoZSBMZXJveSB3cm90ZToNCj4+DQo+Pg0KPj4g
TGUgMjMvMDgvMjAyMiDDoCAwMjoyMCwgQmFvcXVhbiBIZSBhIMOpY3JpdMKgOg0KPj4+IE9uIDA4
LzIyLzIyIGF0IDA2OjI1YW0sIENocmlzdG9waGUgTGVyb3kgd3JvdGU6DQo+Pj4+DQo+Pj4+DQo+
Pj4+IExlIDIwLzA4LzIwMjIgw6AgMDI6MzEsIEJhb3F1YW4gSGUgYSDDqWNyaXTCoDoNCj4+Pj4+
IEluIHNvbWUgYXJjaGl0ZWN0dXJlcywgdGhlcmUgYXJlIEFSQ0ggc3BlY2lmaWNpIGlvIGFkZHJl
c3MgbWFwcGluZw0KPj4+Pj4gaGFuZGxpbmcgd2hlbiBjYWxsaW5nIGlvcmVtYXAoKSBvciBpb3Jl
bWFwX3Byb3QoKSwgZS5nLCBhcmMsIGlhNjQsDQo+Pj4+PiBvcGVucmlzYywgczM5MCwgc2guDQo+
Pj4+Pg0KPj4+Pj4gSW4gb2RlciB0byBjb252ZXJ0IHRoZW0gdG8gdGFrZSBHRU5FUklDX0lPUkVN
QVAgbWV0aG9kLCB3ZSBuZWVkIGNoYW5nZQ0KPj4+Pj4gdGhlIHJldHVybiB2YWx1ZSBvZiBob29r
IGlvcmVtYXBfYWxsb3dlZCgpIGFuZCBpb3VubWFwX2FsbG93ZWQoKS4NCj4+Pj4+IE1lYW53aGls
ZSwgcmVuYW1lIHRoZW0gdG8gYXJjaF9pb3JlbWFwKCkgYW5kIGFyY2hfaW91bm1hcCgpIHRvIHJl
ZmxlY3QNCj4+Pj4+IHRoZWlyIGN1cnJlbnQgYmVoYXZpb3VyLg0KPj4+DQo+Pj4gVGhhbmtzIGZv
ciByZXZpZXdpbmcuDQo+Pj4NCj4+Pj4NCj4+Pj4gUGxlYXNlIGRvbid0IGp1c3Qgc2F5IHlvdSBu
ZWVkIHRvIGNoYW5nZSB0aGUgcmV0dXJuIHZhbHVlLiBFeHBsYWluIHdoeS4NCj4+Pg0KPj4+IFRo
ZSAxc3QgcGFyYWdyYXBoIGFuZCB0aGUgc2VudGVuY2UgJ0luIG9kZXIgdG8gY29udmVydCB0aGVt
IHRvIHRha2UNCj4+PiBHRU5FUklDX0lPUkVNQVAgbWV0aG9kJyB0ZWxsIHRoZSByZWFzb24sIG5v
Pw0KPj4NCj4+IFdoYXQgSSB3b3VsZCBsaWtlIHRvIHJlYWQgaXMgX3doeV8geW91IG5lZWQgdG8g
Y2hhbmdlIHRoZSByZXR1cm4gdmFsdWUNCj4+IGluIG9yZGVyIHRvIGNvbnZlcnQgdG8gR0VORVJJ
Q19JT1JFTUFQDQo+IA0KPiBJIHJlcGhyYXNlIHRoZSBsb2cgYXMgYmVsb3csIGl0J3MgT0sgdG8g
eW91PyBPciBwbGVhc2UgaGVscCBjaGVjayBhbmQNCj4gdGVsbCB3aGF0IEkgbmVlZCB0byBpbXBy
b3ZlIHRvIGJldHRlciBleHBsYWluIHRoZSByZWFzb24uDQo+IA0KPiA9PT09DQo+IFRoZSBjdXJy
ZW50IGlvW3JlfHVuXW1hcF9hbGxvd2VkKCkgaG9va3MgYXJlIHVzZWQgdG8gY2hlY2sgaWYgdGhl
DQo+IGlvW3JlfHVuXW1hcCgpIGFjdGlvbnMgYXJlIHF1YWxpZmllZCB0byBwcm9jZWVkIHdoZW4g
dGFraW5nDQo+IEdFTkVSSUNfSU9SRU1BUCB3YXkgdG8gZG8gaW9yZW1hcCgpL2lvdW5tYXAoKS4g
T3RoZXJ3aXNlIGlvW3JlfHVuXW1hcCgpDQo+IHdpbGwgcmV0dXJuIE5VTEwuDQo+IA0KPiBPbiBz
b21lIGFyY2hpdGVjdHVyZXMgbGlrZSBhcmMsIGlhNjQsIG9wZW5yaXMsIHMzOTAsIHNoLCB0aGVy
ZSBhcmUNCj4gQVJDSCBzcGVjaWZpYyBpbyBhZGRyZXNzIG1hcHBpbmcgdG8gdHJhbnNsYXRlIHRo
ZSBwYXNzZWQgaW4gcGh5c2ljYWwNCj4gYWRkcmVzcyB0byBpbyBhZGRyZXNzIHdoZW4gY2FsbGlu
ZyBpb3JlbWFwKCkuIEluIG9yZGVyIHRvIGNvbnZlcnQNCj4gdGhlc2UgYXJjaGl0ZWN0dXJlcyB0
byB0YWtlIEdFTkVSSUNfSU9SRU1BUCB3YXkgdG8gaW9yZW1hcCgpLCB3ZSBuZWVkDQo+IGNoYW5n
ZSB0aGUgcmV0dXJuIHZhbHVlIG9mIGhvb2sgaW9yZW1hcF9hbGxvd2VkKCkgYW5kIGlvdW5tYXBf
YWxsb3dlZCgpLg0KPiBXaXRoIHRoZSBjaGFuZ2UsIHdlIGNhbiBtb3ZlIHRoZSBhcmNoaXRlY3R1
cmUgc3BlY2lmaWMgaW8gYWRkcmVzcw0KPiBtYXBwaW5nIGludG8gaW9yZW1hcF9hbGxvd2VkKCkg
aG9vaywgYW5kIGdpdmUgdGhlIG1hcHBlZCBpbyBhZGRyZXNzDQo+IG91dCB0byBsZXQgaW9yZW1h
cF9wcm90KCkgcmV0dXJuIGl0LiBXaGlsZSBhdCBpdCwgcmVuYW1lIHRoZSBob29rcyB0bw0KPiBh
cmNoX2lvcmVtYXAoKSBhbmQgYXJjaF9pb3VubWFwKCkgdG8gcmVmbGVjdCB0aGVpciBuZXcgYmVo
YXZpb3VyLg0KPiA9PT09DQo+IA0KDQpUaGF0IGxvb2tzIG1vcmUgaW4gbGluZSB3aXRoIHRoZSB0
eXBlIG9mIGV4cGxhbmF0aW9uIEkgZm9yZXNlZSBpbiB0aGUgDQpjb21taXQgbWVzc2FnZSwgdGhh
bmtzLg0KDQoNCkNocmlzdG9waGU=
