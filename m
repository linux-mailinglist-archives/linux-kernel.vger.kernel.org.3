Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7C34D9439
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 06:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236625AbiCOF5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 01:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344615AbiCOF5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 01:57:04 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D203A5C9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 22:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1647323753; x=1678859753;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PoyOeTN26iNCCuW+0k1U76mY3TKsoTpNDAsXa28wsxQ=;
  b=Nfz3t4NmzaPA8Ggvaq2q++5H8wqboyhoz7sOAIpf/Z+nsSEcWti3N6ln
   p818mEWBUQSDIGMwHC9yAvYcK4QcZpbAq5oq8vqI8nkXAc+3GQph58Kxi
   bZ2EeyA1HjYNq9J2Rlt3pMijyL8c/9zvqNDrQKb8gTIoDWEFEieMuEfVc
   Qwh0hQZB3G/DvqUj2oWJ+JE4AyYmOG/bVGVYEYc9z7RYFvFbKgSr/xDFV
   jo1id/eI8mtXoyUujNgwDFjsrEgSv/DjTEKPb2DLzIb/QHhwVf+znmiTP
   qNX1aDwQnp4wW8e4UdlEx1zwLbzkMJkw4qD2kwfuY6YRgatsRbVt5rWjM
   A==;
X-IronPort-AV: E=Sophos;i="5.90,182,1643698800"; 
   d="scan'208";a="156906486"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Mar 2022 22:55:52 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 14 Mar 2022 22:55:51 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Mon, 14 Mar 2022 22:55:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wzg5qNuoN5l1G+rqMwtQY7V9k24NVSiUyxCtJE/1fOoZXUfEtwHZS3+/dMpOcDZhWaJc5rJAO3e07B7nkSZpttxVd8Yh8lxEZ9CjUrxZ/puhPgGe2mBV6n6kZuqIaYDLL++F2ohBCCzGGSy2Mkrqwl4maWRFM+vUVV1TOjM/oAlUlFKxH8kFhOmbIcTR4fFDSoTY8BAWWd6n0n+7jn/b11hY5fugIw9NIVBnHm5tcG+rRpe5PoRE2bhQBqo6vqfmRB2iTUK9HUgaKzPjIyHQjQh4tLg/CxK1GwZ9c5PD2FeRRR/vv8bRFXois9kWfiJetBQUKWKc6A+HSM2MYMXYYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PoyOeTN26iNCCuW+0k1U76mY3TKsoTpNDAsXa28wsxQ=;
 b=aU2rzHc1qyuCkYx1SVHJmFAaL+qHdermzcOAKxGY+5GxC4pqAmarSTxFFwl5aTPwEanejqRnAhslWyVldmr+nzMKB6yFIp/Qkk7cyDYTxDVyLbudMajwyfnVvt6fKNXl2n0K3YnxwLYTbdI4tbSai43s3fYoY7xgFBnixDYsRjZZvxq5QhKGESMM2WGt7+6k5oAKmKvAa7EbaCxVRLzEEWM0JhmubLbX2RnWK8DtXEDBjpp2lijewofgYQRpDpzYn3v8bW1JMI+KMMZWfUoiSJSIVyY8ZzyfyVh2karTiEUP6nulsA06aXCa0UT+IY6BojD3Fc1/odt27X8jwY8qvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PoyOeTN26iNCCuW+0k1U76mY3TKsoTpNDAsXa28wsxQ=;
 b=Cf3tt0FhJrm02E8cQRbOoyrRMpySK3F9JvMHoMb4WGlPjxJLeo5Fnm9miFR8xd6l+lVxN0iQLnOaRyp88X7ty65j6fftrfrqu8Q96xCz65bseYlb2XoGr+WjzGqsUUb/dkDFhb/yZHppicp92Spf0vJ/ylWk3dnBVHu4XIbdG6o=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Tue, 15 Mar
 2022 05:55:49 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::dc94:3c7c:8ef8:21b9]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::dc94:3c7c:8ef8:21b9%5]) with mapi id 15.20.5061.028; Tue, 15 Mar 2022
 05:55:49 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>
CC:     <p.yadav@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <heiko.thiery@gmail.com>
Subject: Re: [PATCH v1] mtd: spi-nor: unset quad_enable if SFDP doesn't
 specify it
Thread-Topic: [PATCH v1] mtd: spi-nor: unset quad_enable if SFDP doesn't
 specify it
Thread-Index: AQHYMfKsE2aD0LVQO0KmbZoSG1RT0g==
Date:   Tue, 15 Mar 2022 05:55:49 +0000
Message-ID: <33464af7-b445-6229-a02d-703a5ce6b5ef@microchip.com>
References: <20220304185137.3376011-1-michael@walle.cc>
 <7f339d0c-5ca9-261c-a545-d4ebf3bda140@microchip.com>
 <92cde38c-d398-44f4-26f8-ef4919f5944e@microchip.com>
 <7f947928e7189f98eb950828990b3920@walle.cc>
 <91393780-1521-09b7-8dea-14c65e18b37e@microchip.com>
 <0cf8dbbf4ad005abd3db825fb257dedd@walle.cc>
In-Reply-To: <0cf8dbbf4ad005abd3db825fb257dedd@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 00031e87-aa33-4494-bbc1-08da064874bf
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_
x-microsoft-antispam-prvs: <BL1PR11MB5978C5FF95ED0157E6EC6536F0109@BL1PR11MB5978.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eiXw8UBkg876T8+9+zvl1ZMU7tzOSzmHPtRpHGUSmkZXeEEGHNp6FTvEq979ktc2ehGAlNE0dQEjoA1rhK7Zqx+xJSUvQlxTXXkjeJUEOtU7mJKDG/xp1+31hVpCmg6HnbliRz1wMQMimW2MaCa1W+l6rZmLwQhNbfrOnTPHttJN7lVzmoGcGw0Wxx9JznbvydsE0sR8cmWW+nGUGl9C/w8dLQ0oQ7CuIoXDYRE+t8ORm8oHehcDELLGxG+w9CZ/uwXjp6RsA+uwRVq0y+llgdJeWrvwdx2aSvnlIbyHX+4I/Y2mqzcHWBTzhrpojRg286Uh23i3u29JU2qWK94AMCR4rND8QejV71lcbXhxxrPSdesA33N4FcoXZfYtCkrgDHu/tjc5ORRcpDrY/wa+e7daGqOBzDW4X5GgD3ty7z/HoXIkV7RyhSceh6Nh/jNuX7jyGJjTD0Ql+uX6JdMvUOfQ1E7B4UjKv18miobG6jl1m1+eJI/INqdh5vL+MQHR4+P1QazJlXwxvY2T3krT2LmeNz9FLHGmvUDgoTsIwiTDxGO7VHwkHmazJtqo5+wC5PK24QFI+Mo9jDykarm91LuFedB5f6DPycl3/YxLLwrTfAsMKI3eyFrEi9onELJPJzInsMuxUvXYkMMaw/g8wCKmw+OpDmLigMZgXqIg4wW5wELqVbs6tJvuho1k/OG8XKOtA1BI2r+PYuDGjo9LYSJh9bHBJE9pz56Hxh4lT8zfA/92LEMtgkggXzbi9ubiZsF6DZS8aCIGOPtnXDjvpg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(31686004)(36756003)(66476007)(76116006)(66946007)(64756008)(66446008)(4326008)(8676002)(91956017)(5660300002)(66556008)(54906003)(6916009)(83380400001)(316002)(8936002)(2616005)(6512007)(86362001)(26005)(71200400001)(186003)(122000001)(38070700005)(508600001)(53546011)(6486002)(6506007)(31696002)(2906002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U3JqZkwwRmUrS0dFaUpNblArMTFjUmFvbmJQaDJKSHRPdHVNbzhlYVB1VmpD?=
 =?utf-8?B?RXVGRFF5RUJsNlIvcS9tSXlzLzh3R1luaUZYVHdzdi9DVjhYeUducGNvYXg0?=
 =?utf-8?B?Q3Jack5PS3o4U1o3cG9xbnZPVlpqTHZlZGNpWWlPWXBsdmV4SlpBN1JiaTg1?=
 =?utf-8?B?TjFIc2tmS3lOMVlOQzJuZnA5b1lGMVBqZHdrVEVOd09aY1VlbThKdW5kMi92?=
 =?utf-8?B?N2NhTUNHY1pTeUpPVkYySTRualY2R3gwNjg4NFRFYWVycFlUSmlwaFZJOXI0?=
 =?utf-8?B?aGhTeTNUdUoyUnpvaTA4bFQxdmNTdHM4WjVteHI0d2JSKzJBeW9HSUI0ano2?=
 =?utf-8?B?QkdjclNJVDdOVkFkMko3TGpaUmNEbEhjQjhHL056cDhFTDdvVEtMZjF1Q2RE?=
 =?utf-8?B?RHNmazVQbUJyZWY5c2pBdlRYaDZjU0VmS1o4M2M1bFVadTlGcjNhSGduNmxX?=
 =?utf-8?B?czdMbXBXOFVuWjlBbFo0aWl1TndjZXc1TG5HdXJPdG9nUXFITyswNVMrUTR3?=
 =?utf-8?B?WGJrNTNaMlhJTGFCQkFGaUNBQmU3bmgxNUwxRGZkcDJ3Z0dwdXZkUmJHbUxF?=
 =?utf-8?B?emJRdUprMFZERlFuNy9uNy8zSzU4WkZoR0lKaHJydi81UTkxcGNvcW9DSHNn?=
 =?utf-8?B?OWFOWTBFOGtJM1VoVFMxS1NFUTJnRFZnZmRwVE1iUzJNenRidWpKcEZDQWhy?=
 =?utf-8?B?Ukl1V0UydDRWa01HODhsMjZ1LzdLM0libVVnMGx3Q1BMdXZyZXdhYlA3SXBy?=
 =?utf-8?B?eWpOeDBBTkZDb3B2U3JnRW1LYldwbFh1elhhNDZWNnNYeHpuaGNmZStKVEg1?=
 =?utf-8?B?QjAwKzM2STVIOERIa3c0d01HRG1sWHBHVWppR0tmbFJIa3RRY01BSmdtTXI2?=
 =?utf-8?B?RHhmRGRWS1V4M2xpa2t2czNVcVo4aDQ4RnFkTmtxbGJFMU9DcGMyOFhmYUph?=
 =?utf-8?B?blAyNER2ZEVXLytVMnJHdk9tckJkemZkQXAyeW1MMEpDTElyOHJkVWpqUGRO?=
 =?utf-8?B?YUgzeWE4S0xYVllCdDhqWmtxSnFiQ3JxRUk1MUVvZVZJVTJxZ1MrYXRGNmhp?=
 =?utf-8?B?R2ZsZHhreDVOS0xQU3FkbFI1clMrV0QrbzRzSUtiQlkwRGplcTRLSkJoR2pX?=
 =?utf-8?B?UGs0a2ZXakNiMkZJNWZvZHY4Zm9wMkhDZmtrL2pmeVBJOWt6Z05TejJ6enhX?=
 =?utf-8?B?RDFLa09LcUpTTnFMaE5nYXpGWXZjeUFLSlBXbzF4b2R0bThwQlBKZWJMOVRt?=
 =?utf-8?B?MWt6enFpTmZPc1hySEoxU3Rpckc0WVhJSXFDanhFTTdkOEZURTlMcFdXaUpj?=
 =?utf-8?B?bVRaQXUxakJKam16eGQ3UXNpWVA0OTd1Q2JCTU1leS9KMUxjRE1RYnl5RC8y?=
 =?utf-8?B?QkFVeGE0eW9rR20yMUVWeHEra1NYSnVkNXZsOXg1dlNhcGVxQXFqSlF1Z0lS?=
 =?utf-8?B?VDV2bzFYcGd2dGovS0xIQ1BRSFI1bUtTVnR3SGxTbnhtWWphai94bzRnZm5o?=
 =?utf-8?B?Z0ZPYnBFYUQwVm1CTGw2aElVMjc1NjFmQ2Z6cnBETjJucjhuUXhxOU9Od3Nj?=
 =?utf-8?B?bHNaYmdPcFd2MTNxK1BrTlorUHFWVGY2blE1bll5OWhUOTNTYzlUZkJ0ZHpH?=
 =?utf-8?B?SW04MkZ0TEpQTjJ2VDNMdVp4SS9YV3hCYzZHR1RieVZVYys3ZlVqOEppNExH?=
 =?utf-8?B?VFJmb3BtZmRVU2pqV3kxU3E4dFZvUmhvcVV6MW1XTVFvSkR4czRlWEpWcG5r?=
 =?utf-8?B?RTM4U3ZXMC9OZ29kSmk0MWR5WmpiQVFHYjRIZnZSZkNMd1pQUElkRkdJbUdk?=
 =?utf-8?B?VWx4MHBBT0JpcWdFTVlva2tKQzU1MUtuaFpId0lLYjBBdDRveXI1R3FmaWh6?=
 =?utf-8?B?SGV0WVR6ZElrSEtKcTUwSjhCZCt5TnFkUWJoRThxUGNYa3ltTTRJbzF6WnUw?=
 =?utf-8?B?MXhvK0puNXlRTlNNN0l6L2lTbmNkZ3JEdWVFWnpRYWtnYjRxMzFMUGlCeGR5?=
 =?utf-8?B?UUorU3R0Z3lRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C6AFE88970899A48B3F9BF06F3EEBD4A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00031e87-aa33-4494-bbc1-08da064874bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2022 05:55:49.1856
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qaQIuovAG+HtYpAqbmWInAfKHiFk6WNCVqG34ZwYj2TYDZR5uUi1fCv0WDS7Bknbhb6Hk1TXzt0fFZQ/bgoyS+oNbjRp+loh/0okZKrqyME=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5978
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy8xNC8yMiAyMjo0MiwgTWljaGFlbCBXYWxsZSB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6
IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0
aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBBbSAyMDIyLTAzLTA5IDA1OjQ5LCBzY2hyaWViIFR1
ZG9yLkFtYmFydXNAbWljcm9jaGlwLmNvbToNCj4+IE9uIDMvNy8yMiAyMDo1NiwgTWljaGFlbCBX
YWxsZSB3cm90ZToNCj4+PiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9w
ZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93DQo+Pj4gdGhlIGNvbnRlbnQgaXMgc2FmZQ0K
Pj4+DQo+Pj4gQW0gMjAyMi0wMy0wNyAxMDoyMywgc2NocmllYiBUdWRvci5BbWJhcnVzQG1pY3Jv
Y2hpcC5jb206DQo+Pj4+IE9uIDMvNy8yMiAwOToxMiwgVHVkb3IuQW1iYXJ1c0BtaWNyb2NoaXAu
Y29tIHdyb3RlOg0KPj4+Pj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBv
cGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UNCj4+Pj4+IGtub3cNCj4+Pj4+IHRoZSBjb250ZW50
IGlzIHNhZmUNCj4+Pj4+DQo+Pj4+PiBPbiAzLzQvMjIgMjA6NTEsIE1pY2hhZWwgV2FsbGUgd3Jv
dGU6DQo+Pj4+Pj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0
dGFjaG1lbnRzIHVubGVzcyB5b3UNCj4+Pj4+PiBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4+
Pj4+Pg0KPj4+Pj4+IFdoaWxlIHRoZSBmaXJzdCB2ZXJzaW9uIG9mIEpFU0QyMTYgc3BlY2lmeSB0
aGUgb3Bjb2RlIGZvciA0IGJpdCBJL08NCj4+Pj4+PiBhY2Nlc3NlcywgaXQgbGFja3MgaW5mb3Jt
YXRpb24gb24gaG93IHRvIGFjdHVhbGx5IGVuYWJsZSB0aGlzIG1vZGUuDQo+Pj4+Pj4NCj4+Pj4+
PiBGb3Igbm93LCB0aGUgb25lIHNldCBpbiBzcGlfbm9yX2luaXRfZGVmYXVsdF9wYXJhbXMoKSB3
aWxsIGJlIHVzZWQuDQo+Pj4+Pj4gQnV0IHRoaXMgb25lIGlzIGxpa2VseSB3cm9uZyBmb3Igc29t
ZSBmbGFzaGVzLCBpbiBwYXJ0aWN1bGFyIHRoZQ0KPj4+Pj4+IE1hY3Jvbml4IE1YMjVMMTI4MzVG
LiBUaHVzIHdlIG5lZWQgdG8gY2xlYXIgdGhlIGVuYWJsZSBtZXRob2Qgd2hlbg0KPj4+Pj4+IHBh
cnNpbmcgdGhlIFNGRFAuIEZsYXNoZXMgd2l0aCBzdWNoIGFuIFNGRFAgcmV2aXNpb24gd2lsbCBo
YXZlIHRvDQo+Pj4+Pj4gdXNlDQo+Pj4+Pj4gYQ0KPj4+Pj4+IGZsYXNoIChhbmQgU0ZEUCByZXZp
c2lvbikgc3BlY2lmaWMgZml4dXAuDQo+Pj4+Pj4NCj4+Pj4+PiBUaGlzIG1pZ2h0IGJyZWFrIHF1
YWQgSS9PIGZvciBzb21lIGZsYXNoZXMgd2hpY2ggcmVsaWVkIG9uIHRoZQ0KPj4+Pj4+IHNwaV9u
b3Jfc3IyX2JpdDFfcXVhZF9lbmFibGUoKSB0aGF0IHdhcyBmb3JtZXJseSBzZXQuIElmIHlvdXIN
Cj4+Pj4+PiBiaXNlY3QNCj4+Pj4+PiB0dXJucyB1cCB0aGlzIGNvbW1pdCwgeW91J2xsIHByb2Jh
Ymx5IGhhdmUgdG8gc2V0IHRoZSBwcm9wZXINCj4+Pj4+PiBxdWFkX2VuYWJsZSBtZXRob2QgaW4g
YSBwb3N0X2JmcHQoKSBmaXh1cCBmb3IgeW91ciBmbGFzaC4NCj4+Pj4+Pg0KPj4+Pj4NCj4+Pj4+
IFJpZ2h0LCBJIG1lYW50IGFkZGluZyBhIHBhcmFncmFwaCBzdWNoIGFzIHRoZSBvbmUgZnJvbSBh
Ym92ZS4NCj4+Pj4+DQo+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogTWljaGFlbCBXYWxsZSA8bWljaGFl
bEB3YWxsZS5jYz4NCj4+Pj4+PiBUZXN0ZWQtYnk6IEhlaWtvIFRoaWVyeSA8aGVpa28udGhpZXJ5
QGdtYWlsLmNvbT4NCj4+Pj4+PiAtLS0NCj4+Pj4+PiBjaGFuZ2VzIHNpbmNlIFJGQzoNCj4+Pj4+
PiDCoC0gcmV3b3JkZWQgY29tbWl0IG1lc3NhZ2UNCj4+Pj4+PiDCoC0gYWRkZWQgY29tbWVudCBh
Ym91dCBwb3N0X2JmcHQgaG9vaw0KPj4+Pj4+DQo+Pj4+Pj4gVHVkb3IsIEknbSBub3Qgc3VyZSB3
aGF0IHlvdSBtZWFudCB3aXRoDQo+Pj4+Pj4gwqAgTWF5YmUgeW91IGNhbiB1cGRhdGUgdGhlIGNv
bW1pdCBtZXNzYWdlIGFuZCBleHBsYWluIHdoeSB3b3VsZA0KPj4+Pj4+IHNvbWUNCj4+Pj4+PiDC
oCBmbGFzaGVzIGZhaWwgdG8gZW5hYmxlIHF1YWQgbW9kZSwgc2ltaWxhciB0byB3aGF0IEkgZGlk
Lg0KPj4+Pj4+DQo+Pj4+Pj4gSXQgZG9lc24ndCB3b3JrIGJlY2F1c2UgdGhlIHdyb25nIG1ldGhv
ZCBpcyBjaG9zZW4/IDspDQo+Pj4+Pj4NCj4+Pj4+PiDCoGRyaXZlcnMvbXRkL3NwaS1ub3Ivc2Zk
cC5jIHwgMTEgKysrKysrKysrKy0NCj4+Pj4+PiDCoDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRp
b25zKCspLCAxIGRlbGV0aW9uKC0pDQo+Pj4+Pj4NCj4+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9tdGQvc3BpLW5vci9zZmRwLmMNCj4+Pj4+PiBiL2RyaXZlcnMvbXRkL3NwaS1ub3Ivc2ZkcC5j
DQo+Pj4+Pj4gaW5kZXggYTUyMTE1NDNkMzBkLi42YmJhOWI2MDE4NDYgMTAwNjQ0DQo+Pj4+Pj4g
LS0tIGEvZHJpdmVycy9tdGQvc3BpLW5vci9zZmRwLmMNCj4+Pj4+PiArKysgYi9kcml2ZXJzL210
ZC9zcGktbm9yL3NmZHAuYw0KPj4+Pj4+IEBAIC01NDksNiArNTQ5LDE2IEBAIHN0YXRpYyBpbnQg
c3BpX25vcl9wYXJzZV9iZnB0KHN0cnVjdCBzcGlfbm9yDQo+Pj4+Pj4gKm5vciwNCj4+Pj4+PiDC
oMKgwqDCoMKgwqDCoCBtYXAtPnVuaWZvcm1fZXJhc2VfdHlwZSA9IG1hcC0+dW5pZm9ybV9yZWdp
b24ub2Zmc2V0ICYNCj4+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgU05PUl9FUkFTRV9UWVBFX01BU0s7DQo+Pj4+
Pj4NCj4+Pj4+PiArwqDCoMKgwqDCoMKgIC8qDQo+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgICogVGhl
IGZpcnN0IEpFU0QyMTYgcmV2aXNpb24gZG9lc24ndCBzcGVjaWZ5IGEgbWV0aG9kIHRvDQo+Pj4+
Pj4gZW5hYmxlDQo+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgICogcXVhZCBtb2RlLiBzcGlfbm9yX2lu
aXRfZGVmYXVsdF9wYXJhbXMoKSB3aWxsIHNldCBhDQo+Pj4+Pj4gbGVnYWN5DQo+Pj4+Pj4gK8Kg
wqDCoMKgwqDCoMKgICogZGVmYXVsdCBtZXRob2QgdG8gZW5hYmxlIHF1YWQgbW9kZS4gV2UgaGF2
ZSB0byBkaXNhYmxlDQo+Pj4+Pj4gaXQNCj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAgKiBhZ2Fpbi4N
Cj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAgKiBGbGFzaGVzIHdpdGggdGhpcyBKRVNEMjE2IHJldmlz
aW9uIG5lZWQgdG8gc2V0IHRoZQ0KPj4+Pj4+IHF1YWRfZW5hYmxlDQo+Pj4+Pj4gK8KgwqDCoMKg
wqDCoMKgICogbWV0aG9kIGluIHRoZWlyIHBvc3RfYmZwdCgpIGZpeHVwIGlmIHRoZXkgd2FudCB0
byB1c2UNCj4+Pj4+PiBxdWFkDQo+Pj4+Pj4gSS9PLg0KPj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCAq
Lw0KPj4+Pj4NCj4+Pj4+IEdyZWF0LiBMb29rcyBnb29kIHRvIG1lLiBJJ2xsIGNoYW5nZSB0aGUg
c3ViamVjdCB0byAibXRkOiBzcGktbm9yOg0KPj4+Pj4gc2ZkcDoiDQo+Pj4+PiB3aGVuIGFwcGx5
aW5nLg0KPj4+Pg0KPj4+PiBBcyB3ZSB0YWxrZWQgb24gdGhlIG1lZXRpbmcsIHdlIGNhbiBpbnN0
ZWFkIG1vdmUgdGhlIGRlZmF1bHQgcXVhZA0KPj4+PiBtb2RlDQo+Pj4+IGluaXQNCj4+Pj4gdG8g
dGhlIGRlcHJlY2F0ZWQgd2F5IG9mIGluaXRpYWxpemluZyB0aGUgcGFyYW1zLCBvci9hbmQgdG8g
d2hlcmUNCj4+Pj4gU0tJUF9TRkRQDQo+Pj4+IGlzIHVzZWQuIFRoaXMgd2F5IHlvdSdsbCBubyBs
b25nZXIgbmVlZCB0byBjbGVhciBpdCBoZXJlLg0KPj4+DQo+Pj4gTWgsIEkganVzdCBoYWQgYSBs
b29rIGFuZCBJJ20gbm90IHN1cmUgaXQgd2lsbCB3b3JrIHRoZXJlLA0KPj4+IGJlY2F1c2UgaW4g
dGhlIGRlcHJlY2F0ZWQgd2F5LCB0aGUgU0ZEUCBpcyBzdGlsbCBwYXJzZWQgYW5kDQo+Pj4gdGh1
cyB3ZSBtaWdodCBzdGlsbCBoYXZlIHRoZSB3cm9uZyBlbmFibGUgbWV0aG9kIGZvciBmbGFzaGVz
DQo+Pj4gd2hpY2ggZG9uJ3QgaGF2ZSBQQVJTRV9TRkRQIHNldC4NCj4+DQo+PiBNb3ZpbmcgdGhl
IGRlZmF1bHQgcXVhZF9lbmFibGUgbWV0aG9kIHRvIHNwaV9ub3Jfbm9fc2ZkcF9pbml0X3BhcmFt
cygpLA0KPj4gdGh1cyBhbHNvIGZvciBzcGlfbm9yX2luaXRfcGFyYW1zX2RlcHJlY2F0ZWQoKSBi
ZWNhdXNlIGl0IGNhbGxzDQo+PiBzcGlfbm9yX25vX3NmZHBfaW5pdF9wYXJhbXMoKSwgd2lsbCBu
b3QgY2hhbmdlIHRoZSBiZWhhdmlvciBmb3IgdGhlDQo+PiBkZXByZWNhdGVkIHdheSBvZiBpbml0
aWFsaXppbmcgdGhlIHBhcmFtcywgaXNuJ3QgaXQ/DQo+IA0KPiBXaGF0IGRvIHlvdSBtZWFuPyBU
aGUgYmVoYXZpb3IgaXMgbm90IGNoYW5nZWQgYW5kIHRoZSBidWcgaXMgbm90DQo+IGZpeGVkIGZv
ciB0aGUgZmxhc2hlcyB3aGljaCB1c2UgdGhlIGRlcHJlY2F0ZWQgd2F5LiBJdCB3aWxsIGdldA0K
PiBvdmVyd3JpdHRlbiBieSB0aGUgc3BpX25vcl9wYXJzZV9zZmRwIGNhbGwgaW4NCj4gc3BpX25v
cl9zZmRwX2luaXRfcGFyYW1zX2RlcHJlY2F0ZWQoKS4NCg0KcmlnaHQsIGl0IHdpbGwgbm90IGNo
YW5nZSB0aGUgbG9naWMgZm9yIHRoZSBkZXByZWNhdGVkIHdheSBvZiBpbml0aWFsaXppbmcNCnRo
ZSBwYXJhbXMuDQoNCj4gDQo+PiBBIG1vcmUgcmVhc29uDQo+PiB0byB1c2UgUEFSU0VfU0ZEUC9T
S0lQX1NGRFAsIHdlJ2xsIGdldCByaWQgb2YgdGhlIGRlcHJlY2F0ZWQgcGFyYW1zDQo+PiBpbml0
IGF0IHNvbWUgcG9pbnQuDQo+Pg0KPj4gTm8gbmV3IGZpeGVzIGZvciBzcGlfbm9yX2luaXRfcGFy
YW1zX2RlcHJlY2F0ZWQoKS4NCj4gDQo+IEhtLCBzbyB3ZSBkZWxpYmVyYXRlbHkgd29uJ3QgZml4
IGtub3duIGJ1Z3MgdGhlcmU/IEknbSBub3Qgc3VyZQ0KPiBJJ2QgYWdyZWUgaGVyZS4gRXNwLiBi
ZWNhdXNlIGl0IGlzIGhhcmQgdG8gZGVidWcgYW5kIG1pZ2h0IGV2ZW4NCj4gZGVwZW5kIG9uIG5v
bi12b2xhdGlsZSBzdGF0ZSBvZiB0aGUgZmxhc2guDQo+IA0KDQpldmVuIG1vcmUgYSByZWFzb24g
dG8gc3dpdGNoIHRvIHRoZSByZWNvbW1lbmRlZCB3YXkgb2YgaW5pdGlhbGl6aW5nDQp0aGUgZmxh
c2guIFdlJ2xsIGdldCByaWQgb2YgdGhlIGRlcHJlY2F0ZWQgY29kZSBhbnl3YXksIG5vPw0KDQo=
