Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE3B359D16C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 08:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240442AbiHWGjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 02:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240718AbiHWGjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 02:39:09 -0400
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120049.outbound.protection.outlook.com [40.107.12.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5868358B67
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 23:39:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K9S9WZ3LfQbC9KdNsJ4ejAlSTBjLG08LJZCoYQreqLMUtKgJqPYqO2eWdWnnHnp2p+jObORyQymOv2C4eNeByNuBquDHPvAgxxKzRsUqwjOWZm55pIunnJCsBafX7WB0Z0lUJYcyXIudzDVhCzC2TYKMY/sQLNsiPTE0JSLjn1T/z1fBAiRR+cNBeVQsPtAx/iUyikp7Io+qd8Map5s+1RFzRIPk4whgmRD7q10qRzUBbTYP78ZDR+QzhYp/NRrpFsUgIHLYMLbEkBIiZv/oGgaIS4BhRuOMfnY9Q8A+tz+CTGuU1VqvAInr1oerWcR9rYtQ/r8V0GqIvUQ9MmJBNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EdbhIe6yFi64wM12AL/gkBgGEHyqFxnRSVerQjw5B6s=;
 b=dlnfmGgYOWSRZxOpyeqINXklfvY8c0lBsAGclXploFjb0CTdPDylxWXX6eLBPlkf8VV1kTj6/Q+eRuNRy+o8tP8+rMCERQUF5FG1oH9yIJEVEW9pX+IkBi7IgwmB64GEd7JRcIq2MWWq94uKzjgeC/tAu/rWTx8U5B0gT0pTfyGq9/Tx1+YG7L34/N8wvuMo4/sflph/c02FuQ3Q/FVJWtHuz5hEqUMYQUbS8A+FooSkGz5mhQRoX7ipQTxbKSzcK8OHSsCvycdvw+P7vAT4X+q5rOb7iPLsmLX9zGJKBj5xcBwqG0qE/bCjsyz4SlcuBSWSEMlS+LXXDJP4blxnhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EdbhIe6yFi64wM12AL/gkBgGEHyqFxnRSVerQjw5B6s=;
 b=0MwieenQ/gAOzCaSkcdmueHlgcJ9wncRzMY80jrJO/d7j0Six2ap/owqXLdVis0lJVjGnbsoEiUmuVbDLTI7CoVo400gMCZA5WZ4SDjAN9YhQXhuI0ZJk5/OvqpEuYjO+1RjIwp1L54zlPIhhGB9z7J/TO1JTyIKe1V7aPEWPj8tz0wQVflyNR7FmlvC8Q4qpJorqJOWWdOfStzmSP1yjUXsIzQOLCKqXby1sqCR5+j+VGznV1/dJV49LCuTUFU2RRlz8cZgyLbXsBbVnGfuyNaPrBaxdTwCynzAlUSvJ3VHFKBHH4KJYP+YUHfnytHl6C/5ySJshTKsKGODYZsrig==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PAZP264MB2941.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1e6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.19; Tue, 23 Aug
 2022 06:39:05 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::888e:a92e:a4ee:ce9e]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::888e:a92e:a4ee:ce9e%5]) with mapi id 15.20.5546.024; Tue, 23 Aug 2022
 06:39:05 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Peter Zijlstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>
CC:     Linux-MM <linux-mm@kvack.org>, lkml <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        X86 ML <x86@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Kernel Team <Kernel-team@fb.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>, Song Liu <song@kernel.org>
Subject: Re: [RFC 0/5] vmalloc_exec for modules and BPF programs
Thread-Topic: [RFC 0/5] vmalloc_exec for modules and BPF programs
Thread-Index: AQHYs1UbNlqFOrS7VECW4bGmljGVQq27FhAAgAANe4CAAAYfgIAA1hOAgAAPqwA=
Date:   Tue, 23 Aug 2022 06:39:05 +0000
Message-ID: <651923c7-8cd3-b3a9-a86f-909107104925@csgroup.eu>
References: <20220818224218.2399791-1-song@kernel.org>
 <4D089469-B32B-4347-A811-B1E5EE011307@fb.com>
 <YwOwLYUXuSn5acIG@worktop.programming.kicks-ass.net>
 <7621DE6E-D71D-45D1-BAFA-46E882451DD9@fb.com>
 <YwRo43EBIWh7++Qn@worktop.programming.kicks-ass.net>
In-Reply-To: <YwRo43EBIWh7++Qn@worktop.programming.kicks-ass.net>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 49866209-45cc-4f67-46af-08da84d22cf5
x-ms-traffictypediagnostic: PAZP264MB2941:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: umjmxZAjJMh00pL2ig1//kiOkuyQ+ICmQFHaF79/vDNkUOjAk1MhiBjwnFNdvtiGznqHWmjSg0QSCSS97y9l44x6m8aZzNOWgPzJ97DIL6LLWj3SNrl0QoIl0W5R1zlEnt9w/qFkBFJGMID043sMDMqEb8GOASzYkk8rONZIo/tN4mQ5DWml5P5CqdFS2e/P30Twerbo+cYBc3HMKD8hIQqKnhUp2gvp5qunZkdQpG6wd9eBsqCeTLCN+aOAQSBR8mbEEJx1x2odKJTKVBydmCbWYayTOsCn13z38oDf7qFvdlo5DOYA2lvpTWEQcwT7cFx0pMX5IVAV9CjULYtp6Tbpm8g50ouQhGgfFfoU0/2cHh4xsrHWXS+ZD4NaeI9PoKDcfTHsuoH3JEYK74bPVUxXWfvan/lOOUWSVcZTg8QjO1AwYsVdUt44AvtBxxJHyi+pQ+HtJ9i5yCmnQTVSeZ5v19CkUT5u90x006rabHTCc5kW3CLTbU4cqYSRAde3UtCuj6wO+XLFnoTmmaI0pMxChkXx0R5JT23oA+/gzBMQVnAqNPyL5rCfs0kuqIz5FV8RbGZ80vzKtiLJipsJHIFKay9aLM+a/8byiP3sXGEK6bXdXoLOczlY7AbKfd1OwgrX6WLhchOkSwHbTIgp6j57j9Ei5al6ZXAlabtD68Lj9Ec42M55Y/KI7jd+/t6VJufnGsw1Awxu5bMQUvJLi9AZY5MlAakBLMCsm0PT2xlT+1nXSyDCH2oTBhpqPJWLjvuOjOfpMlKMW0EqAEsLdXpX7Y7bJXBb/srzhFcnoRMNMis9rgMO5cCM1fqimFJFjZ7vrnMVvJDuZs/4a1kdIg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(396003)(39850400004)(376002)(136003)(86362001)(31696002)(38070700005)(38100700002)(8936002)(122000001)(5660300002)(41300700001)(31686004)(44832011)(7416002)(66574015)(64756008)(54906003)(478600001)(71200400001)(76116006)(66476007)(66556008)(316002)(66946007)(8676002)(4326008)(110136005)(91956017)(66446008)(2616005)(186003)(36756003)(26005)(83380400001)(53546011)(2906002)(6512007)(6486002)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S0pnZDZoeWxQSWdLYTJiSzhrT3Y2TnJzUXBXSDF3cGt3K0RUTXBqMnRoSTVz?=
 =?utf-8?B?K2dGQnJLajlCQWpQYzlGM0JiaUZ3NmhTUnNleFJiazNqdWlwajF4b2pPNXJP?=
 =?utf-8?B?ejlVWUZJQ0s4ckpKVVNCTlBlZDRlQzhIOG5GVFkzUGc2SmlFMEYyVGJqTjVH?=
 =?utf-8?B?QWpGNXZ6cXJ4QnArVm5tT1RWRGpFaG56c3c2WnREc1ZUeUtIQTRVNDZkSTYz?=
 =?utf-8?B?eEJxd1NWR0FUdjl2N0dsK1lnaTJna3ZidkVqRjdINWlLQmZWSTV5Q3kzb2Ev?=
 =?utf-8?B?OFJFYzVMUzJnWE9RaVBsbkcwOGp2SmJ3dlZiYWxCWnBNN0FIS0VKNWovS0cv?=
 =?utf-8?B?NlA4NmluVHBsS245UnNjWGJqSEovSmdPL2VwUWtUbWdLcnZuSEg4NCs2VUp2?=
 =?utf-8?B?c3lndm5Sb3VWUnhiN2hCYzZVTWV2a0xXUmRCMFBNRXR6bmh2UlJlcTVCM25p?=
 =?utf-8?B?RU1vaGdBSWwvU1R5RmVzaVo0SGNwSmxqaHIyWWsycU1lMGdpZDdKSWF3ZlpD?=
 =?utf-8?B?SmtrVDJPK1RNcjJoZnpSdy9adjkvMEJDenlYRUZwanRIbU9EUXptWW1qNkJP?=
 =?utf-8?B?c1BvaW1OZU5LVmhhZDZtQTFNaWdlVTFFUGFWR3RDWkxpL0ptczRsTGtHODBt?=
 =?utf-8?B?S0tOT3pwZWN0Uk44NXJKc2xWbHRoOHllTXVyNkNLQ3psaFhxQ2h4aHFJaWND?=
 =?utf-8?B?cVNnbGlwSGE0K2V6ZUtncW9ySENqZncxVzl0NVpnMjEvVmtvanIzYmw1ZE52?=
 =?utf-8?B?dWNndHU3emRhY2dKS1lpYkdkYTJ5dmRVZUJUak9wRjNjdnMxUEZQY1ZjK05V?=
 =?utf-8?B?S0RReVVhejBZbXZISUdjNWpGbEVRcXlKMm1Ud0RRd1k3WkdiWldpaVBLVyty?=
 =?utf-8?B?anpwWUhuSzhHL2JHY2NoaU0rT3pkeWNPOGtMZjkvR2lVcTh2VFIvU2ZzZnhy?=
 =?utf-8?B?TFZaQkRKcFh0YW84TmprVElKTW1rL3pvMG95eDJpU3F6UWV4WERPUEdTOHBv?=
 =?utf-8?B?QU1qOW9OaW8vU1B4d2dXaXpTK1NpOXJ6b1Y5MFFjM0xMSitYc0FHemhuWmx0?=
 =?utf-8?B?VmsrZ2lmeGxCNnZqRm80NGh3NXRJdFlOVUorYzZvNzlkTkpuM3N0Um42a2hx?=
 =?utf-8?B?a3ZucThhclFVdFpDVFYybDlzMklmUCtQSzhJRkY1TzBDaTYzWENUazRFc2FF?=
 =?utf-8?B?OFFkUExISjZJZC9qbit0ZXB4N1drSlJFL1FydGJLTE16SGQ3UXFSRHVtSlpK?=
 =?utf-8?B?aDdVdmMrOWtFOUNGSGtTK0hicDQwNXRoYjVMRTBoaStnZVpUeFowUWJLUTlV?=
 =?utf-8?B?bitvTXlZbzFiRHFwV1ZxWXRybnhRZlI0YUhWU0dEdUdOci94QktsaHJXWFNw?=
 =?utf-8?B?ZHRFNTJsMlQvQnlCNEtGVTY3alNuTy9HZUVrRzR2Vk5WMXY3Y2FhbXBCZDlM?=
 =?utf-8?B?K2pPMFo5SGlvMDllZEN5M2UzV0Z6dm1PdldjL0xVcE95MUFVcmxkSU80L0do?=
 =?utf-8?B?cFpHOC81Q09NckZNTHZRb1NuUEI3NGFSMm1sblZ4dGM5T0hUajRBTjVrYVpV?=
 =?utf-8?B?b2U4eWoya2tYYm1kdld2bHVxY1dTbWdmcENSSXpua2UwNVRtcjltRk1zYm1h?=
 =?utf-8?B?dndiNXErODU5dlNUZTlZd1RVMnlXZytaK25WRm9XUnNCME85OVIyR1RhaTJB?=
 =?utf-8?B?eXFOTmhaTCtkakVma2RjdlplQjJpRW1rVnNETnFaNGp3N1hyMlYvVkVGWjA5?=
 =?utf-8?B?RnJmYjBXMFpueHZ1eUJ2Qjl0eG56SzhEeUZNMW5idFBjYlMvWjJ3MktuUHBS?=
 =?utf-8?B?ZHRXTGZXTExFcGRNUktjcFZJQ1QzeWlDZ1RZS0VRWHVTZUZkcEtTNEZkQUZp?=
 =?utf-8?B?K1MyM01WNHpxejVqZkZna3V3YnNGTmdhV2Y5dkZnUENteWxjNUI5NUtCcDlY?=
 =?utf-8?B?Z0tHeUVpSmVhUi9jVDk4UEdXQzdHaHFHT25nSjNXYVRvOGhNQ2VKS0t1cHNp?=
 =?utf-8?B?WUVBL2xWeTNUZ2k0ZHBweXFDUHI3N2NUT3pGZVl5RXA5VEhGVW1YZHRCcFNG?=
 =?utf-8?B?KzB1RUR5US9YcURrUVBwdWJKbWNNZytSQk1JSVpaT0l2UGgvRE5kRkVBN2o0?=
 =?utf-8?B?NGRyTnBVaUhnNjh2cm84ZE56L1ZNdzI4c3RVOVpqVVBVVEhMbGJmTSt6SFdX?=
 =?utf-8?Q?Dh6bhP6GM68c+wc0wOzYeik=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B6DDA98A383541448D02E8513B9F50DB@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 49866209-45cc-4f67-46af-08da84d22cf5
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2022 06:39:05.8304
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TbHIZL7HpvVLSq+JUvjMHZEuRQ1E1plQuizu4T3CvWApfou1COWMydfqjS1oCxIx5JBn4ym8Zs8GDBQdzGVYLvQR1lekEVbIrcPORfuv5yU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAZP264MB2941
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDIzLzA4LzIwMjIgw6AgMDc6NDIsIFBldGVyIFppamxzdHJhIGEgw6ljcml0wqA6DQo+
IE9uIE1vbiwgQXVnIDIyLCAyMDIyIGF0IDA0OjU2OjQ3UE0gKzAwMDAsIFNvbmcgTGl1IHdyb3Rl
Og0KPj4NCj4+DQo+Pj4gT24gQXVnIDIyLCAyMDIyLCBhdCA5OjM0IEFNLCBQZXRlciBaaWpsc3Ry
YSA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+IHdyb3RlOg0KPj4+DQo+Pj4gT24gTW9uLCBBdWcgMjIs
IDIwMjIgYXQgMDM6NDY6MzhQTSArMDAwMCwgU29uZyBMaXUgd3JvdGU6DQo+Pj4+IENvdWxkIHlv
dSBwbGVhc2Ugc2hhcmUgeW91ciBmZWVkYmFjayBvbiB0aGlzPw0KPj4+DQo+Pj4gSSd2ZSBsb29r
ZWQgYXQgaXQgYWxsIG9mIDUgbWludXRlcywgc28gcGVyaGFwcyBJJ3ZlIG1pc3NlZCBzb21ldGhp
bmcuDQo+Pj4NCj4+PiBIb3dldmVyLCBJJ20gYSBsaXR0bGUgc3VycHJpc2VkIHlvdSB3ZW50IHdp
dGggYSBzZWNvbmQgdHJlZSBpbnN0ZWFkIG9mDQo+Pj4gZG9pbmcgdGhlIHRvcC1kb3duIHRoaW5n
IGZvciBkYXRhLiBUaGUgd2F5IHlvdSBkaWQgaXQgbWFrZXMgaXQgaGFyZCB0bw0KPj4+IGhhdmUg
Z3VhcmQgcGFnZXMgYmV0d2VlbiB0ZXh0IGFuZCBkYXRhLg0KPj4NCj4+IEkgZGlkbid0IHJlYWxp
emUgdGhlIGltcG9ydGFuY2Ugb2YgdGhlIGd1YXJkIHBhZ2VzLiBCdXQgaXQgaXMgbm90IHRvbw0K
PiANCj4gSSdtIG5vdCBzdXJlIGhvdyBpbXBvcnRhbnQgaXQgaXMsIGp1c3Qgc2VlbXMgbGlrZSBh
IGdvb2QgaWRlYSB0byB0cmFwDQo+IGFueWJvZHkgdHJ5aW5nIHRvIGNyb3NzIHRoYXQgZGl2aWRl
LiBBbHNvLCB0byBtZSBpdCBzZWVtcyBsaWtlIGEgZ29vZA0KPiBpZGVhIHRvIGhhdmUgYSBzaW5n
bGUgbGFyZ2UgY29udGlndW91cyB0ZXh0IHJlZ2lvbiBpbnN0ZWFkIG9mIHNwbGludGVyZWQNCj4g
Mk0gcGFnZXMuDQo+IA0KPj4gaGFyZCB0byBkbyBpdCB3aXRoIHRoaXMgYXBwcm9hY2guIEZvciBl
YWNoIDJNQiB0ZXh0IHBhZ2UsIHdlIGNhbiByZXNlcnZlDQo+PiA0a0Igb24gdGhlIGJlZ2lubmlu
ZyBhbmQgZW5kIG9mIGl0LiBXb3VsZCB0aGlzIHdvcms/DQo+IA0KPiBUeXBpY2FsbHkgYSBndWFy
ZCBwYWdlIGhhcyBkaWZmZXJlbnQgcHJvdGVjdGlvbnMgKGFzIGluIG5vbmUgd2hhdCBzbw0KPiBl
dmVyKSBzbyB0aGF0IGV2ZXJ5IGFjY2VzcyBnb2VzICpzcGxhdCouID4NCg0KVGV4dCBpcyBSTy1Y
LCBvbiBzb21lIGFyY2hpdGVjdHVyZXMgZXZlbiBvbmx5IFguIFNvIHRoZSBvbmx5IHJlYWwgdGhp
bmcgDQp0byBwcm90ZWN0IGFnYWluc3QgaXMgYmFkIGV4ZWN1dGlvbiwgaXNuJ3QgaXQgPy4gU28g
SSBndWVzcyBoYXZpbmcgc29tZSANCmFyZWFzIHdpdGggaW52YWxpZCBvciB0cmFwIGluc3RydWN0
aW9ucyB3b3VsZCBiZSBlbm91Z2ggPw==
