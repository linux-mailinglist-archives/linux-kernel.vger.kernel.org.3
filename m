Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEFA453F168
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 23:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235151AbiFFVJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 17:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234976AbiFFVIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 17:08:46 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466866449
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 14:06:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RCXfhecw0b7eLjM84/EdAYoGlUJ/VG7wwT0YfAi8necpgoNvs41gZns+tAbzHuqvb0kA7vC/N4qsAu90XFnR6hpBFqvEBpbru4roxbD7yvhQiHUULXb0wR5ChAQ6iwCULxMC258L+GmZ1lroizi670m6nkBg06ayz5nQj+9c6VtMvwH8UMFUmvTkMt/Ih/fraum0tU5X67Qs1ukX3GbyI77aV6R9ZMwYQ2WEB2X5bpnE12GpG5yOruLhTGXXlgaJ16oYJJoGoQ/KuzSKWPNuXt9DtGAa9d2NPqqYjITxAKpmKPCfhesW6r7d0LLmI0Syj8rcpycSP9cX2g0ehVU3aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Avc286933AE4PxcLf7JwtwBxye0Rx2VC5zOgB4RA+Y8=;
 b=FhB/GMNGUO8OT15PWj8gTL6Tj4XF0xKiWIHAfvBJ0aRffVf58N5JRQ+hJnth/2CBuGWztG0tbWrf0ECuyPD+qwojLpVxqoBGkohljmDJDfqKQ7iQvVh+44BbzjwnbATmUZngjNsCOkZbb+ZBG4q/eeCclZqOY3hl+WWxZBEJCYluvX+JkfY2KSAvdJzBz0OaTqimrjS1flmfGo9mc+ZFK3kpt5fkwPUgInsAGMVC3l3OSBTpV4/2cVUA1Vg0QkIJODzvrMCFrbfJ78hwnpgnSEfBaw8t36vd4Z/zF6EmkvENGjAaNEclpgEk4Fae99J1ob3xKUcq7gp2tJEUFMsx/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Avc286933AE4PxcLf7JwtwBxye0Rx2VC5zOgB4RA+Y8=;
 b=Fb9MptdA8GpuYeCO3yA75Mmmm6WK/uVV7qnlzuXTKQnTkkjTYVEPCM9bYL2Wal/ZEtruMNNsE8RNW+CjolMum0UlkmvUrV4koFPf2usz3POeM33CmpYIumJUWFkmrf6dNBzrbOHgcHOgKcSYyvQ1OUcYuAs09rZRdHWN0FbTsS4=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by MN2PR05MB6848.namprd05.prod.outlook.com (2603:10b6:208:1b8::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.9; Mon, 6 Jun
 2022 21:06:47 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::a4f8:718a:b2a0:977f]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::a4f8:718a:b2a0:977f%7]) with mapi id 15.20.5332.010; Mon, 6 Jun 2022
 21:06:47 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Andy Lutomirski <luto@kernel.org>
CC:     Dave Hansen <dave.hansen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: Re: [PATCH v2] x86/mm/tlb: avoid reading mm_tlb_gen when possible
Thread-Topic: [PATCH v2] x86/mm/tlb: avoid reading mm_tlb_gen when possible
Thread-Index: AQHYec9uAfeIW9W+8EGZiduiI0Vqa61C2csAgAAFQIA=
Date:   Mon, 6 Jun 2022 21:06:47 +0000
Message-ID: <A0D7A6ED-4B5C-4CA5-95B0-580F1F0EC364@vmware.com>
References: <20220606180123.2485171-1-namit@vmware.com>
 <234e853b-0c35-45de-b40d-2058976e49e0@www.fastmail.com>
In-Reply-To: <234e853b-0c35-45de-b40d-2058976e49e0@www.fastmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b99e9312-4000-43cb-9c62-08da48007817
x-ms-traffictypediagnostic: MN2PR05MB6848:EE_
x-microsoft-antispam-prvs: <MN2PR05MB684815CDFCB14F9F7B1A9669D0A29@MN2PR05MB6848.namprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v6qk55K3x0bMqfsJNtmBcDwsnC2NPX0YFb/asLoXN3jI0QNawQuFIpCU30gWfpbFh6qCO3LJejaCIOGadmAb3Re7+60RqZ3bioWZuEMEe8fBfNtATqJUQINzRXIR7JbR2vkfx224+EV0NEzZPpaYj5lOGplB2kIJc56M2kphV4w7VzQ7p64LXPZAjdNJSY1Qmix7U8R21vTYEalbtn+e8dvGqUSvqzQJavBF1uyJYZoAVWnryHXLKGuERaOUSgwI8/3XTH6gVqCT5qpdvWlycD1soDQasPaBvTkAcLYc6Q/d3XvNMBoZLcRV/4EvllvbRPuBGvb6Dx4rVNq394fbYsbtHdiWkE+jsYW4O/EZjHnppM9lIJgmAIhizj27eP6DFjm/ea0utv4xI6pBqCqYjjJaxM24ukLjsZyHLp5hZokv9JYr+8cN/9+p0Zfelk6a9kH1y4coD3JBXQagFz3xPhwY2JYRTH8NGLPkuJkNqABpuK9y/eKzRZ7mfH5qrJ7HN753EPkHPBw4vKQA5/VnkNbZKjopRNqmdW1BcjCZr7xodLYXwXnqMKNfRb28Z4/bN7Wa1EU5xUnOCS5M2WMy7nVRRfmE4AXrgnRkHeYP44Kno5YALq+W3c6FUuEqilcnKKTSiarrBUlM50+3U/oLtnSkNjNbBhoYExFkS+PiEdoyuCMiZ0ZTeDoYojkQUurSJfc/1hlkpEgSyPmjpsKBdtw97hzM2owqEOhEpTBOXUE/bEwpVjGUIG600ECOpRw1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(54906003)(4326008)(8676002)(6916009)(33656002)(6486002)(64756008)(66476007)(2906002)(86362001)(71200400001)(53546011)(76116006)(36756003)(8936002)(66446008)(6506007)(83380400001)(26005)(6512007)(2616005)(5660300002)(38070700005)(38100700002)(186003)(122000001)(508600001)(66946007)(66556008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S01LSWNnd3k0R0E0QkpkcGR3V0c0emdURDhPKzY5ZTNhMTkwMk92cmwxWTRY?=
 =?utf-8?B?YWlZemxWSnZzQkhVMUFrTzZVRmpnMnVSNGNEdGJic2NBZ3gyVnFyLyt0aWhF?=
 =?utf-8?B?NkRMZGJOT2d1TjE1NCtsUXZiVjNwMEo4eHdoVGhzOHlkb0VtRnU1dGMvWklS?=
 =?utf-8?B?OTliNGdxdTJPZlR4VnYrQ2kwVW0rQWtlTC9tcUJoaEhFREsvYllrcS83cnJF?=
 =?utf-8?B?QzZSck5PV20vZW9SMnQyWm5Ma0YwVnJKMHA0YnBrdmRQMWsxdS9RdTdPL0pk?=
 =?utf-8?B?YlRwdlBZTTFKaFFkY2J4My9PUEw3TXFQZ1dUd053bkhLZ0F5UGdGczMyRjIw?=
 =?utf-8?B?ZVRPcFRjdTZEaER4SWMraGlMQTV1YlhCekFLVFFpZVVjNHJzM0FVTDE2aVZW?=
 =?utf-8?B?R2FuTFl1V002dkJLVmQ5WHRiT29YN1U2d0hncG1GR1RzVDRUYnRtTkkrMVhQ?=
 =?utf-8?B?R2R6KzdRUUJBWGYzSG1PMWtFOGoyREkwTFdoSnYrd01iMldRVzN4TUJNdDlE?=
 =?utf-8?B?Qm5ieDkrQzd5ckhOVWl2MmxZb3NtcUMxMFJZUjRCYkQ4em1MSElHeVVVbG84?=
 =?utf-8?B?MTIxWmwyMlhCTXN4T01DeDNDTUpDQ0pFNGcwNXViM291WTV3dUcvS3l0ZUpz?=
 =?utf-8?B?UXpEWW52V1o1OW4wanpKb0l0UXppUnlPczFueE9tVWJjMHFXeCtMeWdsTFY4?=
 =?utf-8?B?VXhYaVJnV2J1MlIzWTFzTU9ZaXFqY0dCc1pMVVhUZXZoQlBsR1JiMThmanps?=
 =?utf-8?B?eTkzV25PMzZBMmpGcUVkRHJ6a2Uyb0l0c09pYy9Gbi8zT0xjeHp2Rlk4YkZZ?=
 =?utf-8?B?SWRqOE05bW9tYjJjTU9BOEJ2bUhlbmZKMWlSa1R2elI5YVRJQ0lRVHdGL1Ir?=
 =?utf-8?B?VnY2N1hPQUhpTHRyZ3RybUFrVXRkWGZteTdQdW1wSk5OT0hhM09vNVJKYldL?=
 =?utf-8?B?V1AvNXVJVGJYZHhhV1JMRUQzbUI0ZE1VUVNqWEhLZm04YXpULzJ2VG82VVVL?=
 =?utf-8?B?TUNoQmM5M3p4U21yWVUwd2xXbWVmQnhlVnpvekN6KzIxS2JqQkJKN1BuemRj?=
 =?utf-8?B?K3lqQnJwNXdqVUFHajFQY2VYb3I5SjdyUk8yeXpMU29RWWpyNUFqQVlFL2hr?=
 =?utf-8?B?Nzc2Y092akQ4US9qcTZXWFR5N2hlbXg5Q2ZqWCt6a0dnL3M4SXh4d253bmdk?=
 =?utf-8?B?R1c3VXdsRExQMnR4eUFLZVg4RXlsd1dpWEJ2QnFwb2dZMGMyZnoySHQ1TUhp?=
 =?utf-8?B?T211emRrYTJRUTFDUkRxQTV5cGZKaTdTS0lQanNaay9rV0lKM3lxekVUdHBG?=
 =?utf-8?B?NWhDRzE0WGdjOU0yeXpreDRsdmc2UmtIcnRBVjhaSGhaeWYyYTBrejVjeTMv?=
 =?utf-8?B?YkZIVHNXQmU5Zm1Ca2w5cG11RVluc1Q4Q2F1ckIwaktvcXFBbzFwOVFvdnlV?=
 =?utf-8?B?MFFtcTIrNmFYT1NPWUx4Nk9PWWtuMjZUR0RnUGRCTnNpWlJOQmVkMG9YeUha?=
 =?utf-8?B?cW1UazAvK0I2SzBBOG9hL25FeExEblVjWWcxL3ltWm1BUXpUY2Mra00ydHBI?=
 =?utf-8?B?UWNRYkp6RUhNTjdtQ2JiZ0gyZFdMN3hXNlpTRmtWaUhIL2E0bHBkQVVsSzhl?=
 =?utf-8?B?TFE5Rm9sVHFjcFdRY0RnR2VZNE5naUkyNHlrVVhlUlJHWHBISjFwQnJKOXE4?=
 =?utf-8?B?MlFEU0dQSCt3TU9SL0J3SWRsMVVlc3FWZXJRZFNtTzZkZmJ0b3c1UkpjbW1J?=
 =?utf-8?B?OGdoNkJYUEpBSS83STJPc3QrT2FKK0lGNWFJckphSU16YlNoSFlpM2RnVWIy?=
 =?utf-8?B?VkJMYkcvZ2ZMZ0U4MitCM1ZwWUVvOEh1em55L3RQMUxZVy9kQXhqZ3E3cEZU?=
 =?utf-8?B?ZkNQb2ViYlVjMGdhSUFSNmYvcHBWNlNOdFdWVmxaL0dCNnQ5WlNuTUNyZ0pW?=
 =?utf-8?B?aEhTdG1ROG56KzVPd0xLSE1HOFJDSmVMOVd5V2QxUThFdWJkN1NsbmpFckJ2?=
 =?utf-8?B?Qk1tdzB5VDdFYmZSV0xlZE95Z2lwRjV3TVpTajNXbXBUY1FtZldmeGF3eG1k?=
 =?utf-8?B?VHVJSFo4MWQ5Z3VsQzlWWDUvNFE1RFFpYktFazRtdnhsMTVzdTJ4SHVTZ2o0?=
 =?utf-8?B?STBtUmJvalNxVCtWSDBYYW1JeC9YWGt1SGd2MGNtdXUrMW10WmFtbUExQTJD?=
 =?utf-8?B?WFB1eGU3K2RPbmxEcTk4WDhpNFJxdUJSTW9JdXUyUEZNUS9SNVByL00xWk81?=
 =?utf-8?B?UEtEZVJtdlVYUUdiY1lmQjBGdVhpUVVnRU9WMkZBS2luc3YwdkhSUEo2aURM?=
 =?utf-8?B?NmZrNEFiaWFWcmFkVFZxcmhUWDgzV0IzUk5MeU4vV01vNEY4VGs3dz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6E34C773BAC84944833F96B0551A404B@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b99e9312-4000-43cb-9c62-08da48007817
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2022 21:06:47.8203
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: naZkgKHHvGFV4TQeyM1wA9d2q1uRkLkRI4b6Qyyf9lWZ2RdJBslKneMm6uItWLBtmLL3P2CtJi1pGphNzgAwpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR05MB6848
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gSnVuIDYsIDIwMjIsIGF0IDE6NDggUE0sIEFuZHkgTHV0b21pcnNraSA8bHV0b0BrZXJuZWwu
b3JnPiB3cm90ZToNCg0KPiDimqAgRXh0ZXJuYWwgRW1haWwNCj4gDQo+IE9uIE1vbiwgSnVuIDYs
IDIwMjIsIGF0IDExOjAxIEFNLCBOYWRhdiBBbWl0IHdyb3RlOg0KPj4gRnJvbTogTmFkYXYgQW1p
dCA8bmFtaXRAdm13YXJlLmNvbT4NCj4+IA0KPj4gT24gZXh0cmVtZSBUTEIgc2hvb3Rkb3duIHN0
b3JtcywgdGhlIG1tJ3MgdGxiX2dlbiBjYWNoZWxpbmUgaXMgaGlnaGx5DQo+PiBjb250ZW5kZWQg
YW5kIHJlYWRpbmcgaXQgc2hvdWxkIChhcmd1YWJseSkgYmUgYXZvaWRlZCBhcyBtdWNoIGFzDQo+
PiBwb3NzaWJsZS4NCj4+IA0KPj4gQ3VycmVudGx5LCBmbHVzaF90bGJfZnVuYygpIHJlYWRzIHRo
ZSBtbSdzIHRsYl9nZW4gdW5jb25kaXRpb25hbGx5LA0KPj4gZXZlbiB3aGVuIGl0IGlzIG5vdCBu
ZWNlc3NhcnkgKGUuZy4sIHRoZSBtbSB3YXMgYWxyZWFkeSBzd2l0Y2hlZCkuDQo+PiBUaGlzIGlz
IHdhc3RlZnVsLg0KPj4gDQo+PiBNb3Jlb3Zlciwgb25lIG9mIHRoZSBleGlzdGluZyBvcHRpbWl6
YXRpb25zIGlzIHRvIHJlYWQgbW0ncyB0bGJfZ2VuIHRvDQo+PiBzZWUgaWYgdGhlcmUgYXJlIGFk
ZGl0aW9uYWwgaW4tZmxpZ2h0IFRMQiBpbnZhbGlkYXRpb25zIGFuZCBmbHVzaCB0aGUNCj4+IGVu
dGlyZSBUTEIgaW4gc3VjaCBhIGNhc2UuIEhvd2V2ZXIsIGlmIHRoZSByZXF1ZXN0J3MgdGxiX2dl
biB3YXMgYWxyZWFkeQ0KPj4gZmx1c2hlZCwgdGhlIGJlbmVmaXQgb2YgY2hlY2tpbmcgdGhlIG1t
J3MgdGxiX2dlbiBpcyBsaWtlbHkgdG8gYmUgb2Zmc2V0DQo+PiBieSB0aGUgb3ZlcmhlYWQgb2Yg
dGhlIGNoZWNrIGl0c2VsZi4NCj4+IA0KPj4gUnVubmluZyB3aWxsLWl0LXNjYWxlIHdpdGggdGxi
X2ZsdXNoMV90aHJlYWRzIHNob3cgYSBjb25zaWRlcmFibGUNCj4+IGJlbmVmaXQgb24gNTYtY29y
ZSBTa3lsYWtlICh1cCB0byArMjQlKToNCj4gDQo+IEFja2VkLWJ5OiBBbmR5IEx1dG9taXJza2kg
PGx1dG9Aa2VybmVsLm9yZz4NCj4gDQo+IEJ1dC4uLg0KPiANCj4gSSdtIHN1c3BpY2lvdXMgdGhh
dCB0aGUgYW5hbHlzaXMgaXMgbWlzc2luZyBzb21ldGhpbmcuIFVuZGVyIHRoaXMga2luZCBvZiB3
b3JrbG9hZCwgdGhlcmUgYXJlIGEgd2hvbGUgYnVuY2ggb2YgZmx1c2hlcyBiZWluZyBpbml0aWF0
ZWQsIHByZXN1bWFibHkgaW4gcGFyYWxsZWwuIEVhY2ggZmx1c2ggZG9lcyBhbiBSTVcgb24gbW1f
dGxiX2dlbiAod2hpY2ggd2lsbCBtYWtlIHRoZSBjYWNoZWxpbmUgZXhjbHVzaXZlIG9uIHRoZSBp
bml0aWF0aW5nIENQVSkuIEFuZCBlYWNoIGZsdXNoIHNlbmRzIG91dCBhbiBJUEksIGFuZCB0aGUg
SVBJIGhhbmRsZXIgcmVhZHMgbW1fdGxiX2dlbiAod2hpY2ggbWFrZXMgdGhlIGNhY2hlbGluZSBz
aGFyZWQpIHdoZW4gaXQgdXBkYXRlcyB0aGUgbG9jYWwgdGxiX2dlbi4gU28geW91J3JlIGRvaW5n
IChhdCBsZWFzdCEpIGFuIEUtPlMgYW5kIFMtPkUgdHJhbnNpdGlvbiBwZXIgZmx1c2guIFlvdXIg
cGF0Y2ggZG9lc24ndCBjaGFuZ2UgdGhpcy4NCj4gDQo+IEJ1dCB5b3VyIHBhdGNoIGRvZXMgYWRk
IGEgd2hvbGUgbmV3IGNhc2UgaW4gd2hpY2ggdGhlIElQSSBoYW5kbGVyIHNpbXBseSBkb2Vzbid0
IGZsdXNoISBJIHRoaW5rIGl0IHRha2VzIGVpdGhlciBxdWl0ZSBhIGJpdCBvZiByYWNpbmcgb3Ig
YSB3ZWxsLXRpbWVkIGNvbnRleHQgc3dpdGNoIHRvIGhpdCB0aGF0IGNhc2UsIGJ1dCwgaWYgeW91
IGhpdCBpdCwgdGhlbiB5b3Ugc2tpcCBhIGZsdXNoIGFuZCB5b3Ugc2tpcCB0aGUgcmVhZCBvZiBt
bV90bGJfZ2VuLg0KPiANCj4gSGF2ZSB5b3UgdGVzdGVkIHdoYXQgaGFwcGVucyBpZiB5b3UgZG8g
c29tZXRoaW5nIGxpa2UgeW91ciBwYXRjaCBidXQgeW91IGFsc28gbWFrZSB0aGUgbW1fdGxiX2dl
biByZWFkIHVuY29uZGl0aW9uYWw/IEknbSBjdXJpb3VzIGlmIHRoZXJlJ3MgbW9yZSB0byB0aGUg
c3RvcnkgdGhhbiB5b3UncmUgc2VlaW5nLg0KPiANCj4gWW91IGNvdWxkIGFsc28gY29udGVtcGxh
dGUgYSBzb21ld2hhdCBldmlsIGhhY2sgaW4gd2hpY2ggeW91IGRvbid0IHJlYWQgbW1fdGxiX2dl
biBldmVuIGlmIHlvdSAqZG8qIGZsdXNoIGFuZCBpbnN0ZWFkIHVzZSBmLT5uZXdfdGxiX2dlbi4g
VGhhdCB3b3VsZCBwb3RlbnRpYWxseSBkbyBhIGJpdCBvZiBleHRyYSBmbHVzaGluZyBidXQgd291
bGQgYXZvaWQgdGhlIGZsdXNoIHBhdGggY2F1c2luZyB0aGUgRS0+UyB0cmFuc2l0aW9uLiAoV2hp
Y2ggbWF5IGJlIG9mIGR1YmlvdXMgdmFsdWUgZm9yIHJlYWwgd29ya2xvYWRzLCBzaW5jZSBJIGRv
bid0IHRoaW5rIHRoZXJlJ3MgYSBjcmVkaWJsZSB3YXkgdG8gYXZvaWQgaGF2aW5nIGNvbnRleHQg
c3dpdGNoZXMgcmVhZCBtbV90bGJfZ2VuLikNCg0KVGhhbmtzIEFuZHkuIEkgc3RpbGwgdGhpbmsg
dGhhdCB0aGUgcGVyZm9ybWFuY2UgY29tZXMgZnJvbSBzYXZpbmcgY2FjaGUNCmFjY2Vzc2VzLCB3
aGljaCBhcmUgc2tpcHBlZCBpbiBjZXJ0YWluIGNhc2VzIGluIHRoaXMgd29ya2xvYWQuIEkgd291
bGQgbm90ZQ0KdGhhdCB0aGlzIHBhdGNoIGNvbWVzIGZyb20gbWUgcHJvZmlsaW5nIHdpbGwtaXQt
c2NhbGUsIGFmdGVyIERhdmUgY29tcGxhaW5lZA0KdGhhdCBJIHJ1aW5lZCB0aGUgcGVyZm9ybWFu
Y2UgaW4gc29tZSBvdGhlciBwYXRjaC4gU28gdGhpcyBpcyBub3QgYSByYW5kb20NCuKAnEkgdHJp
ZWQgc29tZXRoaW5nIGFuZCBpdOKAmXMgYmV0dGVy4oCdLg0KDQpJIHZhZ3VlbHkgcmVtZW1iZXIg
cHJvZmlsaW5nIHRoZSBudW1iZXIgb2YgY2FjaGUtW3NvbWV0aGluZ10gYW5kIHNlZWluZyBhbg0K
ZWZmZWN0LCBhbmQgSSBjYW5ub3QgZXhwbGFpbiBzdWNoIHBlcmZvcm1hbmNlIGltcHJvdmVtZW50
IGJ5IGp1c3Qgc2tpcHBpbmcgYQ0KZmx1c2guIEJ1dC4uLg0KDQpIYXZpbmcgc2FpZCBhbGwgb2Yg
dGhhdCwgSSB3aWxsIHJ1biBhdCBsZWFzdCB0aGUgZmlyc3QgZXhwZXJpbWVudCB0aGF0IHlvdQ0K
YXNrZWQgZm9yLiBJIHdhcyBjb25zaWRlcmluZyBza2lwcGluZyByZWFkaW5nIG1tX3RsYl9nZW4g
Y29tcGxldGVseSwgYnV0IGZvcg0KdGhlIHJlYXNvbnMgdGhhdCB5b3UgbWVudGlvbmVkIGNvbnNp
ZGVyZWQgaXQgYXMgc29tZXRoaW5nIHRoYXQgbWlnaHQNCmludHJvZHVjZSBwZXJmb3JtYW5jZSBy
ZWdyZXNzaW9uIGZvciB3b3JrbG9hZHMgdGhhdCBhcmUgbW9yZSBpbXBvcnRhbnQgdGhhbg0Kd2ls
bC1pdC1zY2FsZS4NCg0KSSB3b3VsZCBhbHNvIGFkbWl0IHRoYXQgSSBhbSBub3Qgc3VyZSBob3cg
dG8gY29tcGxldGVseSBwcmV2ZW50IHNwZWN1bGF0aXZlDQpyZWFkIG9mIG1tLT50bGJfZ2VuLiBJ
IGd1ZXNzIGEgc2VyaWFsaXppbmcgaW5zdHJ1Y3Rpb24gaXMgb3V0IG9mIHRoZQ0KcXVlc3Rpb24s
IHNvIHRoaXMgb3B0aW1pemF0aW9uIGlzIGEgYmVzdC1lZmZvcnQuDQoNCg==
