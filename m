Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E5A4C8567
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 08:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbiCAHpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 02:45:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiCAHpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 02:45:09 -0500
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90078.outbound.protection.outlook.com [40.107.9.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE9F49FB3;
        Mon, 28 Feb 2022 23:44:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dAtVW7wczmWMgHaJuuPQSFuBWUOFKqcstripbnXhN5TS81ihaadM8rYNgb0PNtXou/EKmBYxVTz5NT+mf/7MMQtBty4yYzWWT2PjTEBGedXupX8T2PyM+lp8Ydw8aYET70ksdH3JB6H3EHwLaa7L56i3iMaCdlIEq4YsZlsMv43z1L/F/3KkTcK+LInqFKqN7atpfl5B4rc9H5wVUtm5SC1Q3pkxP8Ymup5U9pHDvEmkdU7IJJPDRQxbUsDyk1yQGgl4x3APZT8OZfVk10X7atKKX3Tq+XFEBuXg4gFtNOJjlMG8iu2BjNjWXyRsI9wog1aEfFzcqMhT6ieK9W1W+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=409zPxi3TzTdHOPOoTdWZz2lHBEL7US+kuOO5szRqmk=;
 b=OFZXVvkpOvwwkUdQ2wtGNbBXz4i68Gkz6YdFVn/GPYHneSjUxNHPdh12XMCVUne5eoAEAuFLHoaQsjmb2bxxR2NtAYDKxtlxYOq7ppTaAAhztoDgBD+ftAa8y4WZsvIoRBj+xLQkPhTSfAGwb0iIG4p0xgWFdQ3vN5TqRQTSqmlmdY1R4yoWgHdcUe/BGBSQDtf8hzEPKt+GQOcbWQuPWM6YGMW5Oc1mHYTPqFh0lg+e8ZEus0z0hmea657x6eUvZXur6mOfgePkFU4NqjcvZbxcNkakkcyBvTUEBV+CGv2Onoa+tMtLCb08D5VhJ7Xl923p1VWscfKZUohKSOh95Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
Received: from MR1P264MB2980.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:3d::7) by
 PAYP264MB4287.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:115::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5017.22; Tue, 1 Mar 2022 07:44:26 +0000
Received: from MR1P264MB2980.FRAP264.PROD.OUTLOOK.COM
 ([fe80::b4e1:6a58:710c:54f3]) by MR1P264MB2980.FRAP264.PROD.OUTLOOK.COM
 ([fe80::b4e1:6a58:710c:54f3%6]) with mapi id 15.20.5017.027; Tue, 1 Mar 2022
 07:44:26 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     "pmladek@suse.com" <pmladek@suse.com>,
        "cl@linux.com" <cl@linux.com>, "mbenes@suse.cz" <mbenes@suse.cz>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "void@manifault.com" <void@manifault.com>,
        "atomlin@atomlin.com" <atomlin@atomlin.com>,
        "allen.lkml@gmail.com" <allen.lkml@gmail.com>,
        "joe@perches.com" <joe@perches.com>,
        "msuchanek@suse.de" <msuchanek@suse.de>,
        "oleksandr@natalenko.name" <oleksandr@natalenko.name>,
        "jason.wessel@windriver.com" <jason.wessel@windriver.com>,
        "daniel.thompson@linaro.org" <daniel.thompson@linaro.org>,
        Aaron Tomlin <atomlin@redhat.com>
Subject: Re: [PATCH v9 00/14] module: core code clean up
Thread-Topic: [PATCH v9 00/14] module: core code clean up
Thread-Index: AQHYLPz9dCjYVwicx0iy9EhVniO5RaypqrEAgAB7rYA=
Date:   Tue, 1 Mar 2022 07:44:26 +0000
Message-ID: <2e2860d7-23e8-63f3-f7d3-bce0aa57a3d0@csgroup.eu>
References: <20220228234322.2073104-1-atomlin@redhat.com>
 <Yh1nGtM7MCMOI++l@bombadil.infradead.org>
In-Reply-To: <Yh1nGtM7MCMOI++l@bombadil.infradead.org>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4aec3250-2e3a-4419-4757-08d9fb574f96
x-ms-traffictypediagnostic: PAYP264MB4287:EE_
x-microsoft-antispam-prvs: <PAYP264MB428754C1A44A1E15BD6CE4DBED029@PAYP264MB4287.FRAP264.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I5MYMHMUkgtdeEgKmamGPfvSlTLxIQeGtc0bgIxtohz0MHNqWd0/hnE/6YnocgaoKt0obGKxJRHtVv7VzSmw8APgavn4KJinis55HR1VImokYQglwek3DRr5Lm4GDA65NCe1+d+mHZj9q98fF/JS2owN7GfPMAZfVss6jBU2eIqnxfU+YKilMG1AWApW6t4bKmuMUbtBrgaJ1+txicyftbDTwxA+fLteZw7lv1sAA7bXtfHcO+66P3SoIEO6n07bzyMofqH3dECCyFM/EfUgNU+EPb0nf/E7wYwhsPAM5gNQZJ75dlJmzkW1v1fEDp5GN3ey4PqGKhOG8zeOfsTAhJE5vD9W20ZdgXCc5Qfy5JoCPUpDF2wfnOTZ8kZY2uo84+eTneO0JwoYT5BlK9ms2n3ifzjjZH4320oP23CbfwNZG6ssyasMc06xFJgpCBNHOiltIBMfTcswv6UcUEAMQ+/0wQSpGHY7e0k8J31MDnzrE3AbEdClp6jThuixZvtZYQqV6O687nQtrdKcSQTjEwIQneMqKk2clRewqGYaS8QJ2Q1QvvM6rHLB5GH1GiidtxdAo9Sifwl3200MpOVUVLfWC/B1kRQzCxi2msRjoYUxyupYDGv0hUxQPfra5iRivgRDj/4q/Mb/4m+DUNHh6K9gMb4UGik8bpc64iJu7aWMvEUUkY6W+XxJp/fwnCp3ANDswdNU1Z3egJbDJpDpKz5unVQYaJAYwJIu+p9RI3jGiXecYeKq1i8AUuBzqRIzPTeNZaNS283tOiwdOsNDhA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MR1P264MB2980.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(91956017)(44832011)(36756003)(66946007)(76116006)(66556008)(7416002)(2906002)(38070700005)(26005)(2616005)(66446008)(64756008)(8676002)(508600001)(66476007)(4326008)(6486002)(5660300002)(31696002)(8936002)(4744005)(71200400001)(31686004)(186003)(316002)(38100700002)(6916009)(86362001)(6506007)(6512007)(122000001)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OFFsTTVkZHR1ZjREMGJNeWRmM2szWm5waUhwNGpmaW9LckNYWnVLeUs0RGpM?=
 =?utf-8?B?cnIveWMzcm9NdFBYdWlnVC8wU0pBdUN4Y2JNNWpod3daSlF4eW9sRkREVXJX?=
 =?utf-8?B?Y3VVeVcvclFYUGVReUt2cjBBUE8zamovL21zeUVUSDArS3BSK0lWNisxVnFl?=
 =?utf-8?B?MGwxZHZvM0dBeXA1NGFuVlpKQWl1SlpNTWhONmxVdnN6dFBsdlpFWFdtSFM1?=
 =?utf-8?B?d2RSbW1FQVhuVGtkVUNZSjJKdUpIT0NaOEUrSDFTQnZDV1ZrbzBreEVBa2Rj?=
 =?utf-8?B?NXFsMHAyQUE2dkh0NFFRYlRhRU1yT0pHbUJrUGtoL0IwcmlRb3ZMZmJIdTNH?=
 =?utf-8?B?MGNNajBabFUvZzYvYUtVd2pTbmsvaGEydUlVcDdXUVZGakx1YkFJN1EwVU5F?=
 =?utf-8?B?bzRsckdpeElLa0ZVZ284enloQ3U0a0U5OXVzMlpVdkg3OFRFVmMyaDFCRkth?=
 =?utf-8?B?NVUzbmtuV2ttYXVzUzRvR3ZTWGpVengzR1EzQUVKbVppWDJIakxGV3hpUFVT?=
 =?utf-8?B?eGNuZUVPaHBpZnZNek9VOVV3TUJoeE1rRm9LcVVPQk9SOTFaTFA1OFIxQVhN?=
 =?utf-8?B?UUhwOXBXVE9wa3E5Vk9UVTVPZzNUOHRubjFQYXB6aW1mcy95TjJKTWxwR2tM?=
 =?utf-8?B?NlpvaWdVTlo5YzVVbmRCaHYzeTloTVM3SUJTclM5N2lMRDgyS3NZYWt4SFNW?=
 =?utf-8?B?R25qNHNDTzNIeWlMc04vMWpybi93UWx2Ryt3WldnYWxQTFJFZy81dVFHL0ls?=
 =?utf-8?B?MnFEMjJOM0c3ZHlDT1VXOHY1NklxTmFSWmQ4T0pFWHhoVlU2REFXSHZWaDE4?=
 =?utf-8?B?aVNMZUFWM0tlcXgvYkxkdFNmVWZQc1RJVDh1dTBZNmI1Z1RGME9TWG1FRm4x?=
 =?utf-8?B?VWh0RTQ2NmF6UjBlYkQwcEZmdlNkNUxEdWxHb0xlZTFucnhraVlRMVRlRDQx?=
 =?utf-8?B?a2lYU2xzb2lvNUcySW02SXVCT251MlM1WkZ1Q3V1em5Fd1BwQ3dyNU04ck5t?=
 =?utf-8?B?T0N1NmcveGs4V0R5azA5cWFiZW9MalI2UTg2d0puY1pDVjhENGJ2bDE4Mmg0?=
 =?utf-8?B?SjloR3ViU3Q4WHIyZndwRm93MzFoK1pBV092WExVV1FyMHFvaVEwNVlmOUpm?=
 =?utf-8?B?VlFPa01uNThaVWVrZG80aUVOcDZxQ25Xb2d3UVVyNG1mOER2bWZLRHJIZ0M3?=
 =?utf-8?B?VVBYeFYxU3RFeHVrKzg0MXRRUkxsUVg3eDB2elA4ZU15OHZYREFlclRiME82?=
 =?utf-8?B?em5iZjAvYm9FVnFWL3VUVSszdHJYWVM5MWdNK1R0REVXTlJ0MERmaForSFVp?=
 =?utf-8?B?c01FRWJlM0JTbFU0ZUJ3STNwLzBRS21ZbEJEczNqOEcvRk9ZcGdEZWthai9o?=
 =?utf-8?B?OWhveHhZSUgxcmRFZUFOM0RVVktzNkdlRlh0Z0E5MVZmQzh3QURlcjBaZnRT?=
 =?utf-8?B?bjB6a3RUZklFN2FHcDFOK1V4NXVxa0RoQkFmWjY4bklBdEtkTlBNaTBEcy9S?=
 =?utf-8?B?VytnVVowS2g4RlRUUTZMN2JQd2Z5emlhdlVJM0NQeFY0K05iT1orLzEyRFl6?=
 =?utf-8?B?MEVUSGRyekpXbVZnUnFrYktDUnFrM2pabyt0NlRVQnVnZ1NGbzEwc3ZZUGly?=
 =?utf-8?B?Z1YxNW9EMEErb0M3TWgzMGY1ODM1NmFEUHVrOUREcVl4ZlhmQjRRS1NoVFhh?=
 =?utf-8?B?Y0dVcUswKzZnRXpLMjNONEhPMU51VGVEVGM2ZG81S0FuZDBVUm83VG9BNzJF?=
 =?utf-8?B?MDdNbkN1TnlMZFk1cENXMFFxZTZhVmhLMXFEWEhSTGNTZjcyWlBkemN5VVAz?=
 =?utf-8?B?SnZmZFBrZWp5aTl5Y29rczRTek5qSE1UTjk5bk5wYkxhWlN0S3crZ3Ztamow?=
 =?utf-8?B?RWY5Ukd3ZUkxTC9Td01HTEFLQmk1WTBkM1dsUnpPN05uTjMxeXdzV0JhdkJi?=
 =?utf-8?B?ZWU2NkxSNXk3THBFaXRxYmpNRG9PdDBVSk5pL1k3a2ZIMWpzWnVJclJmUUd2?=
 =?utf-8?B?MmxLbkJGOXUrQm1aaEpyUWpwM2NDYnhDUjN3ZGVHdzZ5SDBzSW9Uc2dXRDZz?=
 =?utf-8?B?NURWb2VQWENCTXY1YjdjWmhsblBsODdIa1l2V2pNYTFzK2JFNTFMWmJERkt4?=
 =?utf-8?B?aE1QNzdQSzdxK2xEeDloYmlHOVprb1FKVkhNNHdXMjN5MlN1THVwWUlXcmdT?=
 =?utf-8?B?YXp0aVhvS2RxeXhyT2h4TUQyR2h3bGwyWCtIR1lsN3ZjTWJpNENuWTNmSGxv?=
 =?utf-8?Q?9xrJv5rW092JL/eHuDcac+2KLppprZBP3RyAMFcx5U=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A7BEB7433D70BD48820893603A4D4A48@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MR1P264MB2980.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aec3250-2e3a-4419-4757-08d9fb574f96
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2022 07:44:26.4673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sarcbzykjnq03QWd1TAINWK4PCnyuoIIUq6+GScL7XQ+7wMe8YGAvbHercncGCjpX8FpuDe013l4SejC9HJ739EEnTdcQjTBk32ts0RTUQg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAYP264MB4287
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDAxLzAzLzIwMjIgw6AgMDE6MjEsIEx1aXMgQ2hhbWJlcmxhaW4gYSDDqWNyaXTCoDoN
Cj4gDQo+IFdlIHNob3VsZCBydW4ga21vZCB0ZXN0cyBhcyB3ZWxsLg0KPiANCg0KSSB0cmllZCB0
byBidWlsZCBrbW9kIHRlc3RzLCBidXQgSSBnZXQgYSBjcmF6eSByZXN1bHQ6DQoNCg0KJCAuL2Nv
bmZpZ3VyZSAtLWhvc3Q9cHBjLWxpbnV4IC0tcHJlZml4PS91c3IvbG9jYWwNCg0KJCBtYWtlDQoN
CiQgY2QgdGVzdHN1aXRlDQoNCiQgbWFrZQ0KDQokIGZpbGUgdGVzdC1saXN0DQp0ZXN0LWxpc3Q6
IEVMRiAzMi1iaXQgTVNCIGV4ZWN1dGFibGUsIFBvd2VyUEMgb3IgY2lzY28gNDUwMCwgdmVyc2lv
biAxIA0KKFNZU1YpLCBkeW5hbWljYWxseSBsaW5rZWQsIGludGVycHJldGVyIC9saWIvbGQuc28u
MSwgZm9yIEdOVS9MaW51eCANCjMuMi4wLCB3aXRoIGRlYnVnX2luZm8sIG5vdCBzdHJpcHBlZA0K
DQokIGZpbGUgbW9kdWxlLXBsYXlncm91bmQvbW9kLWxvb3AtYS5rbw0KbW9kdWxlLXBsYXlncm91
bmQvbW9kLWxvb3AtYS5rbzogRUxGIDY0LWJpdCBMU0IgcmVsb2NhdGFibGUsIHg4Ni02NCwgDQp2
ZXJzaW9uIDEgKFNZU1YpLCANCkJ1aWxkSURbc2hhMV09ZDQ2OTU2YTRmZDM2ZDhkMzQ2NzgwNmMz
MTgzMWM4MTIxN2E1NzNmNSwgd2l0aCBkZWJ1Z19pbmZvLCANCm5vdCBzdHJpcHBlZA0KDQoNCg0K
SG93IGRvIEkgZ2V0IGl0IHRvIGNyb3NzYnVpbGQgcHJvcGVyIFBvd2VyUEMgbW9kdWxlID8NCg0K
VGhhbmtzDQpDaHJpc3RvcGhl
