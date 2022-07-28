Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C939E583787
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 05:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237967AbiG1D3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 23:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237735AbiG1D2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 23:28:54 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515ED5A17B
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 20:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658978933; x=1690514933;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=UXvU8QuIFEe2WwVQdMOnB0M9WeX6mfxKLAqP1sv8h+o=;
  b=js/G0cT05YGRhvoteC4u2lBKD4k5Kqq40RvDjKthvVNCir0RdkHXmCUS
   +V8nvw0rab0d/VQtdsfsSnPWnAIf1BzSZXAf82CCpVI9dKBGZoCFDQ+PC
   j8k3f3PBW7XaaQxlt8T8EjffZWmA7uCoKBpygTVMrF5niLPENFYfUiJrC
   ZUiBuea+9eRQqriuWyIOi17yWPbt3QZTCerR3MfXsH2UXvejydFl67LZy
   QBP9cX8jUZ9DHFbtc3W6NX9wSCVMGB4SqBa1KvuelPb+NAMtOgqCopEbG
   pUNVMsdQl2xV9mHliV5n9H/SVgwHpW2axHS158Z2tRh5+8EaGJ0D/0UqM
   A==;
X-IronPort-AV: E=Sophos;i="5.93,196,1654585200"; 
   d="scan'208";a="184067207"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Jul 2022 20:28:52 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 27 Jul 2022 20:28:52 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Wed, 27 Jul 2022 20:28:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EQqAyK3DUOWhkdxUAfek0ayjpyrbj/IGHTSc8C2ZoNhkLFsR9VUvJMqvvhNq/xtl0wz9FJNcO9DtluCpjFx3q6BHx1LF4wLX4fY/5g2bcIYi1lrvpMnhCFPOvZGnMOo1VGA1UxmuTWvMg/EBR3sii4wTb9yk0LTQFlM0JU1pX+0gBAS7IiKOd1PXPl5+GHZIN9luu/6CP5lHLUhqILUNBxUP6ovj31lj9xkja/r7pwh7J5eSgR7FVONnA6M+eTSzvGZTjeJdm9FRBqoYM6SJv1iFy25TuGViEa+rNLFoqejeVnqf4A51CjdtdCbRhhwidBR8NYNtGzATxsc05ifdGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UXvU8QuIFEe2WwVQdMOnB0M9WeX6mfxKLAqP1sv8h+o=;
 b=kk5HZ/fspi6CsU3Khnx032P4clpggNztbXQwcunm5WH8xdlR7dznDaCqeOJGupVjGAiXtjfAG1BuJl6n+VzdLkZbFUE2LIvp1eP1pwVisdyXuRwSWFsCeHThrA1SvpKgQ1C9WMBIlRXgPdI1/hpYlpFBlEJvqtqmnczD/3CrB/9sj1t9ZY5jQ9Z4ky7pMR8HjzXM/BhwAvv/X/wq0H6ChiKMZZRY/bDoFXcvykLc+5QaAcS107SXYLlEIZog4SBZXdhFj2RHbA14X6BgHtdwUk8qbSZdzYwblpFjrvkiEirYYs2R008i/oiPeDQiFtSjI5LEPUGIKmoKH4M5s+mVQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UXvU8QuIFEe2WwVQdMOnB0M9WeX6mfxKLAqP1sv8h+o=;
 b=HBP7cSjXCUBZeD1jg5qcMviqwXN9/d1RTSM7USFVxR7bP3tcwGEFm8uLdtiWc6Qkau7ZWisE2RoGgL6/MTCj7XmfjnPwyol6OEx+g0YYtG8C/3y1gVTb9yoPn2Wxqqudg+18Gb+CyPMUYaZKcdbRqEfJAgw47PAQ37DZB7DoAqw=
Received: from DM4PR11MB6479.namprd11.prod.outlook.com (2603:10b6:8:8c::19) by
 BN6PR11MB1841.namprd11.prod.outlook.com (2603:10b6:404:102::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.6; Thu, 28 Jul
 2022 03:28:47 +0000
Received: from DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::7549:c58c:5e93:7c35]) by DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::7549:c58c:5e93:7c35%5]) with mapi id 15.20.5458.023; Thu, 28 Jul 2022
 03:28:46 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>, <p.yadav@ti.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH 5/6] mtd: spi-nor: add generic flash driver
Thread-Topic: [PATCH 5/6] mtd: spi-nor: add generic flash driver
Thread-Index: AQHYojIlmUAzZx0qsk2fc1Qh0W6Kkw==
Date:   Thu, 28 Jul 2022 03:28:46 +0000
Message-ID: <dec63921-be59-1845-78cf-2780cba8f7b5@microchip.com>
References: <20220513133520.3945820-1-michael@walle.cc>
 <20220513133520.3945820-6-michael@walle.cc>
In-Reply-To: <20220513133520.3945820-6-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eb8dbc10-e0e0-483d-5ad3-08da704947bc
x-ms-traffictypediagnostic: BN6PR11MB1841:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QdU5aexQW2PFyhULwTzrVNGyc7GcT1TCYwZMqnSgSoGttWoDnJTzQfjjzrAzpacNu+7Z7Biucq7UoahsHtCYp51PJOj5Asa8fR4Nmt8OZjyrplAqEH5bJ+0CoXcEZIdF2dJIccZFXmle/FmImsyUKgzXuP3zZULXvahQLMKrTovKaci50UT0CTSEYfIHbgmcEpLTfprj9bP6HYhQ5A7V7+sH7NxFKfom3eL+oZiGBafae+rlifKsrcPh8pewwa20XI+dC1Q/EaVJnuDR8C28zSi6wzXAFmYXiKIqwEk1fZ7eKRaLNSUIgUvzOfkcrikhSk0JYwjLth+evsfcEDdiuQpcxFR449MrKfDRf1HjzRVI/IjEYlbvp1DONe8Pv8gt+AFXUqUAzPy9yLAjqeuBGid7p+hZY82Ut5FVmeFqIkn5zdmV4OHg78QoRBcDwtAiO2pe6HXOPh2KL6yskXeTqYj9z8QGDochczQAElRW6RAThY+AOMWZhsqoPrtrXoS2MRkrGkLh9X9ZDuXkOPQOf1EH8EEFgpUnFIlz0v0x5YpG3DwovuiUqIHZLyqmfDDRrkzE7fAqt7axRLY+MtQ332wBeMIeZ5aCbHVPBhnMk/aiZfqwAVzSMQrAjPkUew7lTnhb66MlYGv5glel9mRSt4METdWycESM2MEsPeg9AwWWG26sCWzI0LThj/FhuB6iuz7cT3MIYcJCUBgAa30kWXNW0HcxqeJO/K7CyWjZPWfc9CzSn6RY/b+tOUeDNNSS60Msg5tKcEte3OsyYWc7GvjmlmqUegHFDpy4iB+5hvwugcG+gVrgHqP+HNG4Su0yvg+9ACIYprIPdUb2FZkWm8xD+IlQ1ItNp2WeOikBY7brR/pMtBiw+fdqiIcQRHMtf1JMay+1sxVVBaTb6xaNzA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6479.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(136003)(346002)(376002)(366004)(4326008)(316002)(6486002)(86362001)(31696002)(71200400001)(36756003)(122000001)(110136005)(478600001)(53546011)(31686004)(6506007)(54906003)(6512007)(26005)(2616005)(38100700002)(66946007)(64756008)(8676002)(186003)(66556008)(76116006)(8936002)(5660300002)(91956017)(66476007)(66446008)(4744005)(38070700005)(2906002)(41300700001)(41533002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WGhlUFE3V21HM2l2dTVLMkFuL1VidmtCWHRDaHA4aW9INmg5OWRCQUF5MVBs?=
 =?utf-8?B?NjFIdjVSS01VT3RpUHNpK1ZWWEhia0lNNzk1NVFURnJwaDZTSlBXZVVjNktw?=
 =?utf-8?B?LzVSUkNSaGt1eXg3Ymw2WmJHaEpobDVybmdoKzJhMDBhdU40M2JoN08rcUIv?=
 =?utf-8?B?SEYwT3h1dWVmTDVRbjFNblpmdSsxa050ekgzMUlqTVVMVEhYaHpKL3N5VTUz?=
 =?utf-8?B?bEZBTnMzSGw5ZWl1ZnFXamgxUWpFaXVxcnJuYTJyZG5DMW5mU2JabUNXMXd3?=
 =?utf-8?B?WlYyLzNRSmJ6cWhOMFNaMW9RQm13ZWhPUEhRbk1XU3BYSDcxV093OENnT1k0?=
 =?utf-8?B?bTJiZUVqZjFFaEdpT2VQdUJNMmFydGxXbHhKSHhEcjRsbjdaWXNwQzJiUDNy?=
 =?utf-8?B?eWR0LzZhT0VGSUhHOExFK2hzMFBtMTU5VEJpWmNsYnAwUzJmSHE2MmExaFBp?=
 =?utf-8?B?aXJXTW5RUS93emlVdXlibmVET1dJanNtaWlrZXc1OFhDWDI5OHI5UVpCaWR4?=
 =?utf-8?B?WHEzY0FkcmozbTdyTXphd0lSMFVqL0o2OFVveXhvWDl2MnY2SzFWRks4eDlt?=
 =?utf-8?B?YldTM2VvdUhDbERNdDk0dVFIMTAxOFdYaStVVEFPOCtvd1BPUTZHL05ZRFhF?=
 =?utf-8?B?TzFFNGZnU3pXeGxQUWdYeUNyakdDTU96U3AyUEFyMU1xQi8rNWc3OXZ5ZTBB?=
 =?utf-8?B?c0JZSFEzOWR5NVhKUmJpVzdYWGQrR1RqUzBUSlhuRThIOThlUnRRNTVsaXRC?=
 =?utf-8?B?NFdFWjdENkVZWXJQNHNpdU5PcGtCTnh3am9ialh1UmgrU2t4TmF0YzNwa1ZJ?=
 =?utf-8?B?M3RlR2NsRzNwRDgxSTlzR2Y5ZUdYZTB3OFYyb0huRWcrUWZWY1FjaU5UQ2Jm?=
 =?utf-8?B?a2ZxamlWSmEwSWpnd0lES3VNN2VXbEJmUzdzcW0zd0s1cXdSMmltUVdZazB1?=
 =?utf-8?B?Tk9aMlBDdHlkdEVHVXJnUWhseUJlN3daeDdqRTNKd3NTVXppNUxmWHcvWmZ5?=
 =?utf-8?B?MmUrN24zNlF4Y0swUjhQZEVPSWVSWHUxU1FiY2RMeDF2Y01UM25XdENleGs3?=
 =?utf-8?B?VGlWZ0Q1aDFUM0F4cTl3cHp0NFVUd3JpUVFuRURHZlZDWUtOVFY1RGNaS0dk?=
 =?utf-8?B?VmRnMGExWlQ3SEVXUVJQWWxuRmdQcnJKRWpVZ0RnUklNMkhCenhCVUVsTFF4?=
 =?utf-8?B?Qk00MWlqN0xtaEd3bTVXdUd6YTN6blNhV1BFZXEzSk44T0UvZjdvNmpHUE1I?=
 =?utf-8?B?aTdpOU5rK1lQbGlVQ3dSWlp1M251bGppZi8vY0NoTTY2YlBZQldVamtKaE52?=
 =?utf-8?B?bFRJQjZMZTE3Q09tYVlzTTlHK2grcFVGTTh5aklURFVocWVtRTVKYkp2a08z?=
 =?utf-8?B?K1E4aXFORzljZmdoVnNGV044amlTcU1jOW42bitWdi9zWFFqUGZVMURNNUNy?=
 =?utf-8?B?TlJaMzVKc0crOVY4M29iYVkyM2xWWlJTa3hkM3dSQTdBTzRxeDNRclRtR1Bs?=
 =?utf-8?B?M2FJcmR5WEE3TUVIbU85dElqNk84OFg1ZWZ6MDFublhpL3lBcGw3TDRKaW5P?=
 =?utf-8?B?ZU04cGFSSDVubVJYejhGR0VqSFIyU0NoQko1eFZTQ2JKcmp1c0VYZGZkSElt?=
 =?utf-8?B?TnZJOU10RU9xN3RReURlTzdreXBOeFRCNmp6OHl2ZmJKenE3OE5teDdLUVZM?=
 =?utf-8?B?OGxzWFIxY2JaR1llU2M2MTZTd3hVQTIwdm40TnVuMmpmNXM3OEkxeGxmNTFQ?=
 =?utf-8?B?YzhlS2JvSjM0a28wdFRkYnUraFgzKzY4VGJuRWFtZkRJckJjTDNFWVNCTUhV?=
 =?utf-8?B?NUo2OEhvMVZsQVMwOUFvYlRoQ3hmTjVPVy9URG9TYTFQM000Z1FZYXB2SGls?=
 =?utf-8?B?bFBlUWJKejEzZzNWdFdkMC9YNkt4UHltNUFWTnBBYmJmQXZiaGY0K0t3Vk82?=
 =?utf-8?B?TnhrSVhjRnFYZ2JLMVBmZG1BRDgzQUZNYjhMN28rRVAzOHNpZXRPS2F6ditz?=
 =?utf-8?B?ZXlPZzRnNWdMQ1FrdFlXUnFXbTJpcDhnWDMvMjBLaGlqdUNBWGlLNFlya0VG?=
 =?utf-8?B?RWVodkQxWTNITEVlY3A1WDk3V1o5NkpZS0JPZ1dRZktUbjJQaS9EYnA2cFVG?=
 =?utf-8?Q?SK6v6bCV/voClTqK6FGjF8d6M?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <70F17755097CD04EA06553FC335F4A34@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6479.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb8dbc10-e0e0-483d-5ad3-08da704947bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2022 03:28:46.4327
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kQhXOnGjAKSSme+ZTjzoGTdmJxugPqmScQbqiNJkkJmnP9vFgEKeMPTBTfd3Nn+N3SqJSWDmeMjDAVJBVkDOki8t2faNLqEgoLnuXIkMYbs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1841
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNS8xMy8yMiAxNjozNSwgTWljaGFlbCBXYWxsZSB3cm90ZToNCj4gSXQgaXMgc3RpbGwgcmVj
b21tZW5kZWQgdG8gYWRkIHRoZSBmbGFzaCB0byB0aGUgaW4ta2VybmVsIGRhdGFiYXNlLg0KPiBG
aXJzdCwgd2UgZ2V0IGEgcHJvcGVyIHBhcnRuYW1lIGFuZCBzZWNvbmRseSwgZm9yIGFsbCBmZWF0
dXJlcyBub3QNCg0KSSB3b3VsZG4ndCBhZHZlcnRpc2UgdG8gYWRkIGFuIGVudHJ5IGluIHRoZSBm
bGFzaF9pbmZvIGFycmF5IGp1c3QgZm9yDQp0aGUgc2FrZSBvZiBhIHByb3BlciBuYW1lLiBUaGUg
bmFtZSBzaG91bGRuJ3QgbWF0dGVyLiBJZiBhbGwgdGhlIGZsYXNoDQpjYXBzIGNhbiBiZSBkaXNj
b3ZlcmVkIHdoZW4gcGFyc2luZyBTRkRQIGxldCdzIG5vdCBhZGQgYW4gZW50cnkgYXQgYWxsLg0K
DQo+IGRlc2NyaWJlZCBieSB0aGUgU0ZEUCBsaWtlIE9UUCB3ZSBuZWVkIHRoZSBlbnRyeSBhbnl3
YXkuDQoNClllYWgsIGNhcHMgbGlrZSBPVFAgYXJlIG5vdCBTRkRQIGRpc2NvdmVyYWJsZSwgd2Ug
c2hvdWxkIGFkZCBhIGZsYXNoX2VudHJ5DQp3aGVuIHRoaW5ncyBjYW4gbm90IGJlIGRpc2NvdmVy
ZWQgc29sZWx5IGJ5IHBhcnNpbmcgU0ZEUC4NCg0KLS0gDQpDaGVlcnMsDQp0YQ0K
