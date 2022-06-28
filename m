Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA9555D0D1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241848AbiF1AEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 20:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiF1AEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 20:04:32 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A165B5590
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 17:04:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lXD2DAYk7xlBXSmrViKZ8PNT1zt52w9K2LQ2zuANBw7h9Y8MlfTUvYMDwCmQf1CwuT5gOvhIgPyBxgBxmZZV5hVAeWIt4B7X6WblLUsdKU9z8qbMW40fjse7qQeGQNTUtH7benvcvmiE+6DOo+KJdvXdt6mTK5JOYese1+JnJnv7yNrtNk9mvuOc+TPUoeNLgaW/bOHYEx4n0IzMkZX67cQ20grORSanc8UCbZPbp6nw0kmkheSWkePnQI4eyhFyjf/N3sq1QDBlddzWY/4TRo49jItwyqErwKuRwkZtbC2q15Du5uVEav84j5cZ9gUEZ9bLkssI7wnGXJ+hslSb5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IaIcc4+68lt1QQJG0Tpluk1227VU5RyKAWIfAGO35D0=;
 b=eO6FZJjZIBB1bcWH2pBHvMqyNVvjVF5+2LkFLz4RUN8LKcRsCFTYryhUWiG6gGUUggWHmi0BAg392Pl7UrjQ8QROypr9TEeoE8X37XIIRuF5fC+XPQJjzG2LtWLPkTAWEzTck6wUPRvrfmBF5bEtF7yKqt07lZbUCLwrqIEe6U2w3sRV3d672uj6E9f5isTXTW98l10Uqkf524GkipmiXEBYIf/wACi83xchXxF0CapJshgplJ74b+5Sax4x/ZLcLrfFYQFzYwmITipRyvbFwtlQXyeOcajIE5lA0r6dVujK6u67x8NGJapWQrr4DGyc7lVcdUdKvEMZ2nGPa9PB7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IaIcc4+68lt1QQJG0Tpluk1227VU5RyKAWIfAGO35D0=;
 b=r6C6m9QkFllADIUh6oMFRMCvLpqtdJcxNGJ0ezjX5bC9XB35H5VGTI390h1EOnM3P2yBD3zIFym6W2rdxJPHQzjgm3qsHDIQ5ejWhkuPoMpq3Id2vrG1+Z+K1UFjUaEu1mcQCem4U2fO9ukajzKETZ4a9QLnmA2x2ofljsEq57A=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by DM6PR05MB6076.namprd05.prod.outlook.com (2603:10b6:5:3e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.11; Tue, 28 Jun
 2022 00:04:29 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::a4f8:718a:b2a0:977f]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::a4f8:718a:b2a0:977f%5]) with mapi id 15.20.5395.012; Tue, 28 Jun 2022
 00:04:29 +0000
From:   Nadav Amit <namit@vmware.com>
To:     James Houghton <jthoughton@google.com>
CC:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Jue Wang <juew@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 00/26] hugetlb: Introduce HugeTLB high-granularity
 mapping
Thread-Topic: [RFC PATCH 00/26] hugetlb: Introduce HugeTLB high-granularity
 mapping
Thread-Index: AQHYimT61BRthM8NmkW237FWHUoNOq1j8HoA
Date:   Tue, 28 Jun 2022 00:04:28 +0000
Message-ID: <0125BDEB-0848-41DF-A9D4-CDCAC2893972@vmware.com>
References: <20220624173656.2033256-1-jthoughton@google.com>
 <YrYCeYy0rjfGhT/W@casper.infradead.org>
 <CADrL8HUtdd=yEtY=bhHRYVjA30O1CAd6XEj+oTNjviWkSmzowQ@mail.gmail.com>
 <YrnvORvPKbzgxLCu@work-vm>
 <CADrL8HX4eNREyiuDPSoQpZPObTe7Kto3UurMHYeeO-3TdTo87w@mail.gmail.com>
In-Reply-To: <CADrL8HX4eNREyiuDPSoQpZPObTe7Kto3UurMHYeeO-3TdTo87w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d6f0303f-405d-4030-d0e4-08da5899c54d
x-ms-traffictypediagnostic: DM6PR05MB6076:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Nhm/b7vJZXgVLxEJNBCsAfIe4GDCtf/I0agCqOV3o1VIYK5o+54BPcSppdqtCT3csyXUjDoZ5XNRQE19MJVTqu+msvA3ElDbG4siI29N/fRxamTxJknqyYBz1kpfY6SeQ7PgDUITuZoEZRNfvkXQ5Uiw6colViPvEjc0pOQgUguQBr0hVP7wFQpjarm0okN498/E17ebzMzkUlTKuBN6pc4uFm+LmDznRhOLbJhN4GzPY3djlClihYLpYTISpek/PPPpSVj6VBnxDFK+6qVZzl7ZEkEyetTZl9XHhHsF86SidBvJ395iBWBg+sI5xfswP3v6kK0AHb7kK9/ZfUVErE5cAPvAkaYLJum9v4+qOVGmH54Gl2pigTJN6LK+pCQuutZZPlsVGcIU9QCyf1G5TIhixN9B9cZWMyfvvaqGaLHAzM2ao4TICjY/orU2xIEh0RbExYOat4wcMdbL1qyUmZ1O33VsuXT2hqVKylBpizHEKPKWkJgqrSnYHzG0azvCpafXZZQwzQd1n34anlb0dcrI/iHmCbrRWOdvso78IP0AEmCUK/pWeacIV3/8IkKxNnO2gIlNRdnmGEUMripBofmXZeRfkm43C/+HfiKf6uZzFKPByR1cEPL6bpK1byazqYPl0S6R+X/WI4Q/N1+H7F7upCTbS4kuNDLjPFkwzfeMWzr99P0050eOqZhmeyZEy29/6yc+AZIgWmtPo/Y6dsg3/QpX9f8BHUQq1vZurwOVLL+P1u3sb58c7uQP/8QKoxomkhlOhwEi/qcRJ/yLW4/r/C+fnfCuJ8K8RkInteMkr2+7zAf+0TKFbc3B8426EJSiHxnQ9Byd5RfeLbB9MA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(376002)(346002)(39860400002)(136003)(54906003)(7416002)(41300700001)(76116006)(316002)(66946007)(4326008)(6506007)(66476007)(66556008)(86362001)(71200400001)(33656002)(64756008)(36756003)(6916009)(38070700005)(53546011)(6512007)(26005)(5660300002)(83380400001)(66446008)(122000001)(8676002)(6486002)(478600001)(2616005)(38100700002)(2906002)(186003)(8936002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VEp3elFXbUxaamE1WldYMzRKWlNTV3FZZjNIMDFpZUpoRFppL1FXbjhpQWpq?=
 =?utf-8?B?R2xJRVlabXdXSXhWNSszaGxLYnlrOTBxZVdvR2o3WUEwTTdXMkJEQS9RdFhn?=
 =?utf-8?B?VU5qT1ZMODRxbndVTGlmazRlL0IxNlBJcHhFMHlJSUhuZzF2NVUyaUltU0JF?=
 =?utf-8?B?N3hFZ05lS1Q5WlFDYTJ4UDlad2NtYS9VSzVDRlhuS0V4TXpnWUdyeWdaUERY?=
 =?utf-8?B?dnRvOTgzUngxekhXRy8vUk5yZFQ2Nyt6VXJ4QVBHeUhKdHp2VHp5a3RSdXpH?=
 =?utf-8?B?RHNnQTE4aS96djYwb2JPc21wQXZuWXZoeGx4Y3hUQ0F6dStENFR6T3FMTDJm?=
 =?utf-8?B?TVYra3ZpeENuZXFXTTB2MDdIN3hkKzVndXdJRUp5VmtxN3E5ak0yMGRCcFd0?=
 =?utf-8?B?bGV2NVpvc01YMkllYnRNNGc0UEtzQzNjTDBUVm83RWdlcU9Jcll4ZXRyUkR1?=
 =?utf-8?B?akgwamI3MGtRZER3ZHRsMVVidEFEOEV4eXcwa1laV1dVY1RGSFJRYW9QeCsw?=
 =?utf-8?B?dkI5dEdvSkpTUk9LeE9nUUlENkJtSVpxZEFJaEVac2JIOEp0VjJteUQvN0xl?=
 =?utf-8?B?NHF4RThPTXgyMjdEWFl3U0FEMkpTWXFVQW5OTFhDTEttczFxZG5CMjNYTjZE?=
 =?utf-8?B?bFd4bk5iUlJja0Q5L2RFZXR0NTFXVCsrK2VwOTZoS1B4WlgvZjZKekdMOG9G?=
 =?utf-8?B?NEZnYjhOVmJWbUtNRStobXR6QzFDZldwd0F0R25OVllqNmZWK2JYdHlSZzh4?=
 =?utf-8?B?RDlyYkxyMnRuYy9OVDFvZHVWWmFEKzNZZUFzZWZJZDY5RHhZRWloK1VoSVkw?=
 =?utf-8?B?YWJlNTN0bDQ4RlBtbzNvNkoyRVZGQUU0Q0FCL3U2NUtQbk1hTGRxUDNtQ253?=
 =?utf-8?B?U041Z3pKRlErQXVOMGpoQnk0a0t4aTd4Zk1GMHpRUzRDR1J2VW5Za0haTlVl?=
 =?utf-8?B?anNqTHlXcUxxamQ3WWtibm9BdjNSMTlpYlAyWENXUzJQVjRSVG5XWkdHUUN5?=
 =?utf-8?B?MzNoMUxxdVo3eEJZK3V2dU45cUdRQXR2bjlTQWJiaC9yTS91V0VmWHB5dm9K?=
 =?utf-8?B?L0hTMG53WWFkb0ZJMFpKQW5IZ0Q4MVVzK2NiYmZFQjRrWGtQYm1NdnNHdFZG?=
 =?utf-8?B?RmE3MFhBRkJXYndjcFdKV3JWWUhESGtuR3JYbmM4Z2pvZ3FqKys4UktpTjZM?=
 =?utf-8?B?TVNhaHM5NE9hSS9TT2E3SWhXbjg5QzBRdld0ajY1eVdoWkFqRVdmUjBOdEpm?=
 =?utf-8?B?L2dsT3JWRFNwbmNHbTlVN1htU21renVVOUU3emk0TFhXRmQvemhnSzRvTUY1?=
 =?utf-8?B?aWpZUXZKQ3dQRGF6UWVZUmZyWE1GTldTLysxMUV2TTRJbm1VR3NQVjFXMHdQ?=
 =?utf-8?B?OUFUQ3ZPRWRaRVN4OHBGbGkxRU16ZitobWJkSjZYZ1dOYzhQNkR6UTJ4bXpz?=
 =?utf-8?B?Wm5TQUZGdEhoNDFTTmpKZXovQi95R1pvTVZZaWNyY2kxYUthdEE2WitXcGtn?=
 =?utf-8?B?RlhSSmxCQStBcXZ0SmIrQkdkYVZMRnBGRXlteVJyY1Nnd0JuQTkxczlWRzlI?=
 =?utf-8?B?VXZtT25kZXlySHQ1d3ZlZzQyMjlpdTk1UGlXcTFRY3Z0VURiSmIrVE5nY056?=
 =?utf-8?B?S3R1TWU3T2ZYY1ErOVZZYkZUS1ZrYWNDeXZrd2tpTjB4ZWJDOHc4QlhuL0RX?=
 =?utf-8?B?ZjA5RUtHRHVhT1ZsVmU3d1FSbGhQZ0pySGY0VnZjcEUvTkFaemZRZWxQV0Vj?=
 =?utf-8?B?bkhxS1BKdHdyWVJqN2w4d0FRSEIzenNnemN6WldQKzMyWFNSajlEZllUcWM2?=
 =?utf-8?B?VTV6K2dueElyZnJLeUZvMEY3R1dLbmJJMXExbWcxd3BCakxqSmp3eEhCSjMw?=
 =?utf-8?B?eUNnYXRkMzRVZ28vajVCVlpkYW9WQzFxVmpxdStCOGp2eWNhL2Z1c09jQ0cv?=
 =?utf-8?B?MVgxaUtZWThjVXN5MnZXNzIvcU83Q3FtcFhscGsrQm9Qay93Y2FEcjdPZ3lT?=
 =?utf-8?B?YnVWeVpSZm4zMnk1UzVOSTgrbndwWGlqZnl4WmU1ZlZrUHhMRTR6TUl6S3Z2?=
 =?utf-8?B?SDBwSG4yL2ZsQVFpL2FhOGlzQklCRGZZNnMwbThqSXpCRWh2ZVZNeHV4bDRW?=
 =?utf-8?Q?x2F/7CHEgF4vVh/wx+aCxYLFY?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <92517781EB11B04C9CBEE5F8963D2929@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6f0303f-405d-4030-d0e4-08da5899c54d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2022 00:04:28.9485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KRph7ycCg7dguHpTxmbiDJmNp2T4RFD6zCRCb7+Az3xN8DE7qDcMjoiN86dJves8qdpG+taFuoNsiACiyqkWMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR05MB6076
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gSnVuIDI3LCAyMDIyLCBhdCAxOjMxIFBNLCBKYW1lcyBIb3VnaHRvbiA8anRob3Vn
aHRvbkBnb29nbGUuY29tPiB3cm90ZToNCj4gDQo+IOKaoCBFeHRlcm5hbCBFbWFpbA0KPiANCj4g
T24gTW9uLCBKdW4gMjcsIDIwMjIgYXQgMTA6NTYgQU0gRHIuIERhdmlkIEFsYW4gR2lsYmVydA0K
PiA8ZGdpbGJlcnRAcmVkaGF0LmNvbT4gd3JvdGU6DQo+PiANCj4+ICogSmFtZXMgSG91Z2h0b24g
KGp0aG91Z2h0b25AZ29vZ2xlLmNvbSkgd3JvdGU6DQo+Pj4gT24gRnJpLCBKdW4gMjQsIDIwMjIg
YXQgMTE6MjkgQU0gTWF0dGhldyBXaWxjb3ggPHdpbGx5QGluZnJhZGVhZC5vcmc+IHdyb3RlOg0K
Pj4+PiANCj4+Pj4gT24gRnJpLCBKdW4gMjQsIDIwMjIgYXQgMDU6MzY6MzBQTSArMDAwMCwgSmFt
ZXMgSG91Z2h0b24gd3JvdGU6DQo+Pj4+PiBbMV0gVGhpcyB1c2VkIHRvIGJlIGNhbGxlZCBIdWdl
VExCIGRvdWJsZSBtYXBwaW5nLCBhIGJhZCBhbmQgY29uZnVzaW5nDQo+Pj4+PiBuYW1lLiAiSGln
aC1ncmFudWxhcml0eSBtYXBwaW5nIiBpcyBub3QgYSBncmVhdCBuYW1lIGVpdGhlci4gSSBhbSBv
cGVuDQo+Pj4+PiB0byBiZXR0ZXIgbmFtZXMuDQo+Pj4+IA0KPj4+PiBPaCBnb29kLCBJIHdhcyBn
cmluZGluZyBteSB0ZWV0aCBldmVyeSB0aW1lIEkgcmVhZCBpdCA7LSkNCj4+Pj4gDQo+Pj4+IEhv
dyBkb2VzICJGaW5lIGdyYW51bGFyaXR5IiB3b3JrIGZvciB5b3U/DQo+Pj4+ICJzdWItcGFnZSBt
YXBwaW5nIiBtaWdodCB3b3JrIHRvby4NCj4+PiANCj4+PiAiR3JhbnVsYXJpdHkiLCBhcyBJJ3Zl
IGNvbWUgdG8gcmVhbGl6ZSwgaXMgaGFyZCB0byBzYXksIHNvIEkgdGhpbmsgSQ0KPj4+IHByZWZl
ciBzdWItcGFnZSBtYXBwaW5nLiA6KSBTbyB0byByZWNhcCB0aGUgc3VnZ2VzdGlvbnMgSSBoYXZl
IHNvIGZhcjoNCj4+PiANCj4+PiAxLiBTdWItcGFnZSBtYXBwaW5nDQo+Pj4gMi4gR3JhbnVsYXIg
bWFwcGluZw0KPj4+IDMuIEZsZXhpYmxlIG1hcHBpbmcNCj4+PiANCj4+PiBJJ2xsIHBpY2sgb25l
IG9mIHRoZXNlIChvciBtYXliZSBzb21lIG90aGVyIG9uZSB0aGF0IHdvcmtzIGJldHRlcikgZm9y
DQo+Pj4gdGhlIG5leHQgdmVyc2lvbiBvZiB0aGlzIHNlcmllcy4NCj4+IA0KPj4gPHNocnVnPiBK
dXN0IGEgbmFtZTsgU1BNIG1pZ2h0IHdvcmsgKGFsdGhvdWdoIG1heSBjb25mdXNlIHRob3NlDQo+
PiBhcmNoaXRlY3R1cmVzIHdoaWNoIGhhZCBzdWJwcm90ZWN0aW9uIGZvciBub3JtYWwgcGFnZXMp
LCBhbmQgYXQgbGVhc3QNCj4+IHdlIGNhbiBtaXNwcm9ub3VuY2UgaXQuDQo+PiANCj4+IEluIDE0
LzI2IHlvdXIgY29tbWl0IG1lc3NhZ2Ugc2F5czoNCj4+IA0KPj4gMS4gRmF1bHRzIGNhbiBiZSBw
YXNzZWQgdG8gaGFuZGxlX3VzZXJmYXVsdC4gKFVzZXJzcGFjZSB3aWxsIHdhbnQgdG8NCj4+IHVz
ZSBVRkZEX0ZFQVRVUkVfUkVBTF9BRERSRVNTIHRvIGdldCB0aGUgcmVhbCBhZGRyZXNzIHRvIGtu
b3cgd2hpY2gNCj4+IHJlZ2lvbiB0aGV5IHNob3VsZCBiZSBjYWxsIFVGRkRJT19DT05USU5VRSBv
biBsYXRlci4pDQo+PiANCj4+IGNhbiB5b3UgZXhwbGFpbiB3aGF0IHRoYXQgbmV3IFVGRkRfRkVB
VFVSRSBkb2VzPw0KPiANCj4gK2NjIE5hZGF2IEFtaXQgPG5hbWl0QHZtd2FyZS5jb20+IHRvIGNo
ZWNrIG1lIGhlcmUuDQo+IA0KPiBTb3JyeSwgdGhpcyBzaG91bGQgYmUgVUZGRF9GRUFUVVJFX0VY
QUNUX0FERFJFU1MuIEl0IGlzbid0IGEgbmV3DQo+IGZlYXR1cmUsIGFuZCBpdCBhY3R1YWxseSBp
c24ndCBuZWVkZWQgKEkgd2lsbCBjb3JyZWN0IHRoZSBjb21taXQNCj4gbWVzc2FnZSkuIFdoeSBp
dCBpc24ndCBuZWVkZWQgaXMgYSBsaXR0bGUgYml0IGNvbXBsaWNhdGVkLCB0aG91Z2guIExldA0K
PiBtZSBleHBsYWluOg0KPiANCj4gQmVmb3JlIFVGRkRfRkVBVFVSRV9FWEFDVF9BRERSRVNTIHdh
cyBpbnRyb2R1Y2VkLCB0aGUgYWRkcmVzcyB0aGF0DQo+IHVzZXJmYXVsdGZkIGdhdmUgdXNlcnNw
YWNlIGZvciBIdWdlVExCIHBhZ2VzIHdhcyByb3VuZGVkIGRvd24gdG8gYmUNCj4gaHN0YXRlLXNp
emUtYWxpZ25lZC4gVGhpcyB3b3VsZCBoYXZlIGhhZCB0byBjaGFuZ2UsIGJlY2F1c2UgdXNlcnNw
YWNlLA0KPiB0byB0YWtlIGFkdmFudGFnZSBvZiBIR00sIG5lZWRzIHRvIGtub3cgd2hpY2ggNEsg
cGllY2UgdG8gaW5zdGFsbC4NCj4gDQo+IEhvd2V2ZXIsIGFmdGVyIFVGRkRfRkVBVFVSRV9FWEFD
VF9BRERSRVNTIHdhcyBpbnRyb2R1Y2VkWzFdLCB0aGUNCj4gYWRkcmVzcyB3YXMgcm91bmRlZCBk
b3duIHRvIGJlIFBBR0VfU0laRS1hbGlnbmVkIGluc3RlYWQsIGV2ZW4gaWYgdGhlDQo+IGZsYWcg
d2Fzbid0IHVzZWQuIEkgdGhpbmsgdGhpcyB3YXMgYW4gdW5pbnRlbmRlZCBjaGFuZ2UuIElmIHRo
ZSBmbGFnDQo+IGlzIHVzZWQsIHRoZW4gdGhlIGFkZHJlc3MgaXNuJ3Qgcm91bmRlZCBhdCBhbGwg
LS0gdGhhdCB3YXMgdGhlDQo+IGludGVuZGVkIHB1cnBvc2Ugb2YgdGhpcyBmbGFnLiBIb3BlIHRo
YXQgbWFrZXMgc2Vuc2UuDQo+IA0KPiBUaGUgbmV3IHVzZXJmYXVsdGZkIGZlYXR1cmUsIFVGRkRf
RkVBVFVSRV9NSU5PUl9IVUdFVExCRlNfSEdNLCBpbmZvcm1zDQo+IHVzZXJzcGFjZSB0aGF0IGhp
Z2gtZ3JhbnVsYXJpdHkgQ09OVElOVUVzIGFyZSBhdmFpbGFibGUuDQo+IA0KPiBbMV0gY29tbWl0
IDgyNGRkYzYwMWFkYyAoInVzZXJmYXVsdGZkOiBwcm92aWRlIHVubWFza2VkIGFkZHJlc3Mgb24g
cGFnZS1mYXVsdCIpDQoNCkluZGVlZCB0aGlzIGNoYW5nZSBvZiBiZWhhdmlvciAobm90IGFsaWdu
aW5nIHRvIGh1Z2UtcGFnZXMgd2hlbiBmbGFncyBpcw0Kbm90IHNldCkgd2FzIHVuaW50ZW50aW9u
YWwuIElmIHlvdSB3YW50IHRvIGZpeCBpdCBpbiBhIHNlcGFyYXRlIHBhdGNoIHNvDQppdCB3b3Vs
ZCBiZSBiYWNrcG9ydGVkLCB0aGF0IG1heSBiZSBhIGdvb2QgaWRlYS4NCg0KRm9yIHRoZSByZWNv
cmQsIHRoZXJlIHdhcyBhIHNob3J0IHBlcmlvZCBvZiB0aW1lIGluIDIwMTYgd2hlbiB0aGUgZXhh
Y3QNCmZhdWx0IGFkZHJlc3Mgd2FzIGRlbGl2ZXJlZCBldmVuIHdoZW4gVUZGRF9GRUFUVVJFX0VY
QUNUX0FERFJFU1Mgd2FzIG5vdA0KcHJvdmlkZWQuIFdlIGhhZCBzb21lIGFyZ3VtZW50cyB3aGV0
aGVyIHRoaXMgd2FzIGEgcmVncmVzc2lvbi4uLg0KDQpCVFc6IEkgc2hvdWxkIGhhdmUgdGhvdWdo
dCBvbiB0aGUgdXNlLWNhc2Ugb2Yga25vd2luZyB0aGUgZXhhY3QgYWRkcmVzcw0KaW4gaHVnZS1w
YWdlcy4gSXQgd291bGQgaGF2ZSBzaG9ydGVuIG15IGRpc2N1c3Npb25zIHdpdGggQW5kcmVhIG9u
IHdoZXRoZXINCnRoaXMgZmVhdHVyZSAoVUZGRF9GRUFUVVJFX0VYQUNUX0FERFJFU1MpIGlzIG5l
ZWRlZC4gOikNCg0K
