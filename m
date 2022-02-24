Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D5C4C295B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 11:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233405AbiBXK2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 05:28:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233353AbiBXK2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 05:28:40 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5951B8FE8;
        Thu, 24 Feb 2022 02:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1645698491; x=1677234491;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=oB6aD4logKgd8smP86L9cajChkgH3rgSDNRDovqdzFM=;
  b=RyuuJo9FHiORL9rZAEb60wdNzGZ4cSSlogVPCnT8SgG96cHcsuqOYp3R
   vjMImVDsGB+KCXTnrnR1UgT8Vf5o+HHMZLssZH46/IS1hl5FQ9r+3j2U5
   MOU1b2awrkpmeCzJgBANzP1KdgWDtu0p78bYwTVZsIuE5anb7x2/L5Mwt
   reVoup/hWC1BVGUI7LeglIojV4KTb0BK9hF3kogLAcHi47mUhAWnp9ymZ
   XZEsH6VRziB6LVoPly+c/pyVA/hiKws+Uz8myI2FKDkM7n/xw5Pc1fHwX
   m8lv6IkKfl2aLPZJdQgJFuT7qKCoeQJhpIMYreo6EKusic88mEDoRY4bI
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,393,1635231600"; 
   d="scan'208";a="154241541"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Feb 2022 03:28:11 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 24 Feb 2022 03:28:09 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Thu, 24 Feb 2022 03:28:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=obh8qdMU6W1ns5OS7W4S3kIlKvlMbCCLlXHxtwWSk/wNzYxVHevfntlWPLTVrYPBcVUGK5oQeUW2xDsBjToQr4jaZY3I3RCclDMTvssYLZMISkD6OEpZvPBEjsoSE3D83vfdrsdR8S008R1aKptREHl5MvJnaiEmq0x6hgjF6A6yu3++uxUAr07kPvgX+8Nky7tDfYwgFWzDRW9i/y2s6auR6vd9vLv0UAIJSUXC6ZiOwf1MFD1XXXLalHPECvVS1KCrhp1C43+TFz5gkhsQewo6UkAvFHJ3lUltu+N0fcXaubJ8MhgO4sfdXaEFyVM2jPEL3MFppWIqVUSFaRwsAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oB6aD4logKgd8smP86L9cajChkgH3rgSDNRDovqdzFM=;
 b=DWgKq/4Sk6oQLOLDzOeXeczyxF9bX4pOa3Pkp1dnJPV8YwsuNX6RoAumnDI1Wc2Hvzh8fdM1W2HQ2+NF02R51ayCwYwpU96e4r54nYWIlrZhmLqKG/fqvWH8ZS5/4k+lCL/X+3Y7/3bRnX+skwrVgItBX9A3p/3FGcZ9TngEoe08YTBMV2e7Qh8HpV9axO3J2DHY2umSq6m4M9drcOpgYHoZJwVst104tJNdbvc7X8sgC3zOWfZCKtp/3mMlFW70dgU0aurngxwABhLYIQ/TE6OpVLeld0lbGfRUScspsHr6ENx7kXbQElBN1MD4Mk4XUK4dI/TEDM5XpJkAc89JfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oB6aD4logKgd8smP86L9cajChkgH3rgSDNRDovqdzFM=;
 b=lqVahFq0w+BoKD+2Ex3SSW/9iJsQTfywN6KobwX0tsXhNyoIqXLJr3LI+xks0R0YVuefJf6+Tyb88dDQmc4QetGw+L2xwxwtEXukq53rteijulGLwRjt4h/SmWDEyJspQiX1m7EtOCKK1ejBbsKsXeezEe3z7VtGNIfzgIBN55s=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by DM6PR11MB2873.namprd11.prod.outlook.com (2603:10b6:5:bd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Thu, 24 Feb
 2022 10:27:58 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::dc94:3c7c:8ef8:21b9]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::dc94:3c7c:8ef8:21b9%5]) with mapi id 15.20.5017.025; Thu, 24 Feb 2022
 10:27:57 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>, <p.yadav@ti.com>
CC:     <p.yadav@ti.com>, <broonie@kernel.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <Nicolas.Ferre@microchip.com>,
        <zhengxunli@mxic.com.tw>, <jaimeliao@mxic.com.tw>
Subject: Re: [PATCH 0/4] spi-mem: Allow specifying the byte order in DTR mode
Thread-Topic: [PATCH 0/4] spi-mem: Allow specifying the byte order in DTR mode
Thread-Index: AQHYJ/PF9hATniilJUe3fAFeGB3/Dw==
Date:   Thu, 24 Feb 2022 10:27:57 +0000
Message-ID: <12107fcd-eb74-4c71-25c9-1acaeaf45ea8@microchip.com>
References: <20220218145900.1440045-1-tudor.ambarus@microchip.com>
 <44f655d027b49b87065915f6ba2744d2@walle.cc>
 <81d7c569-d6c2-9167-e007-eda72f34842b@microchip.com>
 <23fbbf2dde387e3832b4ca23d46816c0@walle.cc>
 <7cd74ef3-5a7d-4e65-3436-ee3399ca56a3@microchip.com>
 <e39d06684b8f3a63103f40f0e99e030e@walle.cc>
 <3cd510ad-a6ab-d4a0-92e3-9156a0c7ddbf@microchip.com>
 <20220223183849.xcwciv2ybnkdnauk@ti.com>
 <6eb179ec-0b12-de30-829e-83ec6b964f21@microchip.com>
 <779069a1-7389-ab70-9f03-81090d0600ba@microchip.com>
 <a85e2d1862cfff477e97c39509b2b74d@walle.cc>
In-Reply-To: <a85e2d1862cfff477e97c39509b2b74d@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9ed1474d-0e31-4c04-8064-08d9f780538d
x-ms-traffictypediagnostic: DM6PR11MB2873:EE_
x-microsoft-antispam-prvs: <DM6PR11MB2873279DFCC9CF042F931DABF03D9@DM6PR11MB2873.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2hiucZyi2/CAH3fgfB2zLaFw5/zucQwVlbPrOVFhvl7WxfYhNdVPRJ/y7kJm6ZJwSqH2EgHKmfzM+izS854NhyzlvNu8RuR/yQBgRLY02MZkPoV6kWxinL4JGqjhEcrQcmXF6xNQqgqPM8aqWYxA9E2Bi/lUyXkF/gH3HLo2JC7WhQzYIesrnmA0zqvkCWn+P2JO5kTskQdl4wl0U4GkRq3QfryGbTnLGvsdsTTwr/aDQ/C21TFgvLnL7WnfaSkU9QpmqgYeeNq3LoMOm+q8rUMxOG8NxaVuwA7jqyQjuTdJli1n5ZXdqnSV0dx9mYARe0zBPxdo3gWThiAq8Jf8KXCsZOjOHjTsnUnDrQavqryDm6oMktgxZPpJmqhHPWI14UtqzKb8x3DbGENKzXs3utTH9uHtwXj4YlitJDozTHALYpFXlkVZUdoX7BU8v51uKd83hVBay2yqP3ViYKBzZutC451TvWHPzLhsgREqbN6ARlG8kfMSpvpTH7XMiHiMhPC0rC1QIrSGvOK4Eec57NAiZhi/GfgCDxMFAFub22dQXwHcXd4fq8rHHvIuqYs49DAiDBJZKiiW71X7Bo1a63jqzbz89oRQY8P0a4s3OAmSMRWxUfNv4+u2ppm6pKsa+w7ZBp/rrkhHMrsIc9+b7FJwMzRQGwhiwPNNHe0CydLg7MAp9Lu7BPuUamq6ZSd1wDUlFu1vbqvyJkiHIz8EBSHXa1/Vbfy11hI6m4YchPN5SXpWbdnZ3IJufnZksa5UtB4Of7KaAu8HXPqh8+8yBw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(71200400001)(38070700005)(5660300002)(2906002)(26005)(7416002)(86362001)(186003)(6486002)(36756003)(31696002)(508600001)(83380400001)(38100700002)(4326008)(91956017)(66946007)(8676002)(76116006)(66556008)(31686004)(66476007)(66446008)(64756008)(6512007)(2616005)(8936002)(54906003)(53546011)(122000001)(316002)(6506007)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YnFwZTNGMFMvTUd4TkIvK2lELzIvR2N3c1B4TExDdkFQZEJJT3RlZFNHMzhM?=
 =?utf-8?B?V1N5V1ByZjU1cGhzWWlRNFB4ZzVJNGpSYlRpUXhSMUk3Nm0xMFQ2THFHUi95?=
 =?utf-8?B?NkF2bkUyMmJ1c3B3a0ZoTFRrQjhzY3ROQ2RINGIrNWxPYnNzYm5wWnc3amd3?=
 =?utf-8?B?MW45a2NqODZOdzQybGZySTZBOCs4NnFFVk5NbEk2Y3gyZTR0Yzl0cmlOWjR4?=
 =?utf-8?B?UzBDUnN0bnI3ZWE1eWhDbVl5akhEMEpRdktlRkgyM1BXOFdqWmtKbVhWT1FT?=
 =?utf-8?B?WXZ5UEN2UlE5cU5pV2tTVG5UaE92cC9NRnR2MmROSWpKd0QxUlkydjBpeUFK?=
 =?utf-8?B?VktLVklLRXlWMGFDYnhJSSt0a2kxR0hvWTRJZUd2UmZqSnBhZGNFQ1hrMkNk?=
 =?utf-8?B?R01HTkV2QmQySTIwb2FlQTc4RkJyaGxQdlA1ZEhUbElXMmR6Umt0cXpoMHRV?=
 =?utf-8?B?L3pZcFhQZitsZ0RTV3JFQTlzUHRwMTFjR2hpM3ZDUkxLMUNJamVMeGRTZERX?=
 =?utf-8?B?VTFlMUlUallwZURJQ1Y3aFpYZnNZZWhhbzZQTVpVWjYzN3k3YUFtUUxhdW50?=
 =?utf-8?B?VFhNQWdHYTkzazJhTWx2d2FkdUIzV1lJK2UwUDZ1QnJ6Y2lRTy9salRqOUYw?=
 =?utf-8?B?MGZHSFpWRlZGNzJDaXhxRUtUTTBBd3VaV2V4MTZ3azVWYXVBYzNXdEJST0tM?=
 =?utf-8?B?dHE0dUJQUmJKZUc2R29JYUt2UGgzZkRGN0wzTWdobmV1cEl0U3ZybUxRclhl?=
 =?utf-8?B?Y0tBdlM0WFVJQVBLY0ZLKzRqa3FrS1BkYUkyRDNGV2dHNnppemhnVkpHRnZo?=
 =?utf-8?B?bkpqY0haR0NVOWxRQTY0OEE3RnVKVzFLVDhmK0thMkthNGJscnR6b0ZmQ0lF?=
 =?utf-8?B?M0NzSTV4QWdvUnlaMDhSVlhuMEFTb04ybVdXN0FJU0FpM2xWM0lDVU1UUjMy?=
 =?utf-8?B?S09yN0dQcnV2ZWlCWFFnQkgyam1EbFVxMys2M0ZYMkZJNU52SThKbmtZNkN2?=
 =?utf-8?B?dlAxZFBFMWdvQUpPM2dZOWU0VVE5c2JBZmtYdTZzd29CYVZSb3FzN2JRZlhH?=
 =?utf-8?B?RklPQ294OWFjWlBiS1I4eU1PMjdPS0xWUmpRWHFQUkpBdWhzdWw2YWZsY283?=
 =?utf-8?B?WnVMcTd4T0t4ZTJkYWtkK3RqbUtKS2JHNnV0MlJZaUtPekczRlJQNW5PNmxD?=
 =?utf-8?B?Zklha2JZWXRBVUZUYjVIcWRhZGhQU3NxWmdUNmZRbCtLb2NTMCtzUmw1ZmxV?=
 =?utf-8?B?OWJwdWFqeU5sS1FRd2xPb0g1bjFKQmU4eVl0c0k1TytqS0xzYnQ3aVBYb2J5?=
 =?utf-8?B?ekRFNjFmaE5seDEzSDNEQlVBdGNLbStBME9XbDZqaDFva0k0bkJXOVhyN1dt?=
 =?utf-8?B?a3h0emErY0FHTVhMM3FQMmVCbmJNWm9FdWJUdTl6RSt6TXQrZHVZVXVDV0s5?=
 =?utf-8?B?Rm9VdCtSRkVUVHExZFpMTlFVbXF5b2FmOUJjRm1QQ0lrdDVrTytJODZCVllT?=
 =?utf-8?B?VU5Tc0F5TitjaW04NG9SQUZHeTB1Z2pLUEJ5OUR1ZmdiWFFTU1ExdjVjdGww?=
 =?utf-8?B?N29sbEdrZ0dxbVV5YWRTekNOVzZRc2M1Nk13RWVXbmVHcG5pc2ZHS2tFd2x2?=
 =?utf-8?B?N2VrelZMa0RUNGtpZHcxVDY0KzdwaWhrVkViVExka1FndjlUV20yTzgxR3Ey?=
 =?utf-8?B?UXZMM0dndkVwYmcvbVUyNWpwTVNHc0tIZ2R0Z0VNeG4yc1VtckJaV1pPelVY?=
 =?utf-8?B?clRLbmg4V1NtL3FPYktlY2xSYVl6YmFwNmczb0ZTQUc4alY1WFNsL3lpaSt3?=
 =?utf-8?B?QW94R3A1Sk5YbGZoSFEyTjhFY0d0UTVhZ2NtZ2VLSkFkM0oxeEN2UlRqYUx3?=
 =?utf-8?B?SkZ6c3h6RnA0RHFsVmN5RlQwUGNOczZZV2VqSWdORDJqdUYvOTRjRWF2UFg5?=
 =?utf-8?B?S1VuWUI5bEh4dU9hVVFKVzNUOGQ0cUhKOUQwRnk4MU9VYmlaSUwyY0o2dXVx?=
 =?utf-8?B?VEFSdTVLVXhZT1pOZS9TM1htRHdCMEJHUTI2TTlVUC85d25ld2ZSUzZWMkhP?=
 =?utf-8?B?Tk5ici9HZ0FEMUQxYk5wSC9aSFIzaEVNL0duTk5OVUt2bjkzbGpVajBhK1VE?=
 =?utf-8?B?SmcvSk0rbnM0dm8wbmZrekNKcC9RWGZNZUkwRThRUkRTS0ZjSlBob2QwY0RW?=
 =?utf-8?B?a2x4eXFqeW5kQ1FQU3p0SGNKY3J1VEd3dUNMNDZ4ZUt4Y2pUYVk2akhzYTl6?=
 =?utf-8?B?dVdSZmo0T2k2dkdyc1d3S3ZZNWJBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B68AC4464DBCDE42A8F61609897804C9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ed1474d-0e31-4c04-8064-08d9f780538d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2022 10:27:57.8043
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R5diOscLoqnBPmhYI8J4LhbIMCz9OEvDk+Xnb3ULmDcdmPxohUxBdVEu1sbvkxQUKSYLf94La9m6y88TTEcsLWidYC+4qFRKtrTGbKD4jWY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2873
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMi8yNC8yMiAxMTozNywgTWljaGFlbCBXYWxsZSB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6
IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0
aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBBbSAyMDIyLTAyLTI0IDA3OjM3LCBzY2hyaWViIFR1
ZG9yLkFtYmFydXNAbWljcm9jaGlwLmNvbToNCj4+IE9uIDIvMjQvMjIgMDg6MDgsIFR1ZG9yLkFt
YmFydXNAbWljcm9jaGlwLmNvbSB3cm90ZToNCj4+PiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNs
aWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93DQo+Pj4gdGhlIGNv
bnRlbnQgaXMgc2FmZQ0KPj4+DQo+Pj4gT24gMi8yMy8yMiAyMDozOCwgUHJhdHl1c2ggWWFkYXYg
d3JvdGU6DQo+Pj4+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBh
dHRhY2htZW50cyB1bmxlc3MgeW91DQo+Pj4+IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPj4+
Pg0KPj4+PiBIaSBUdWRvciwNCj4+Pj4NCj4+Pj4gT24gMjIvMDIvMjIgMDI6NDNQTSwgVHVkb3Iu
QW1iYXJ1c0BtaWNyb2NoaXAuY29tIHdyb3RlOg0KPj4+Pj4gT24gMi8yMi8yMiAxNjoyNywgTWlj
aGFlbCBXYWxsZSB3cm90ZToNCj4+Pj4+PiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxp
bmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdQ0KPj4+Pj4+IGtub3cgdGhlIGNvbnRl
bnQgaXMgc2FmZQ0KPj4+Pj4+DQo+Pj4+Pj4gQW0gMjAyMi0wMi0yMiAxNToyMywgc2NocmllYiBU
dWRvci5BbWJhcnVzQG1pY3JvY2hpcC5jb206DQo+Pj4+Pj4+IE9uIDIvMjIvMjIgMTY6MTMsIE1p
Y2hhZWwgV2FsbGUgd3JvdGU6DQo+Pj4+Pj4+PiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNr
IGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdQ0KPj4+Pj4+Pj4ga25vdw0KPj4+
Pj4+Pj4gdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPj4+Pj4+Pj4NCj4+Pj4+Pj4+IEFtIDIwMjItMDIt
MjIgMTQ6NTQsIHNjaHJpZWIgVHVkb3IuQW1iYXJ1c0BtaWNyb2NoaXAuY29tOg0KPj4+Pj4+Pj4+
IE9uIDIvMjEvMjIgMDk6NDQsIE1pY2hhZWwgV2FsbGUgd3JvdGU6DQo+Pj4+Pj4+Pj4+IEVYVEVS
TkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MN
Cj4+Pj4+Pj4+Pj4geW91DQo+Pj4+Pj4+Pj4+IGtub3cNCj4+Pj4+Pj4+Pj4gdGhlIGNvbnRlbnQg
aXMgc2FmZQ0KPj4+Pj4+Pj4+Pg0KPj4+Pj4+Pj4+PiBBbSAyMDIyLTAyLTE4IDE1OjU4LCBzY2hy
aWViIFR1ZG9yIEFtYmFydXM6DQo+Pj4+Pj4+Pj4+PiBGb3J0dW5hdGVseSB0aGVyZSBhcmUgY29u
dHJvbGxlcnMNCj4+Pj4+Pj4+Pj4+IHRoYXQgY2FuIHN3YXAgYmFjayB0aGUgYnl0ZXMgYXQgcnVu
dGltZSwgZml4aW5nIHRoZQ0KPj4+Pj4+Pj4+Pj4gZW5kaWFubmVzc2VzLg0KPj4+Pj4+Pj4+Pj4g
UHJvdmlkZQ0KPj4+Pj4+Pj4+Pj4gYSB3YXkgZm9yIHRoZSB1cHBlciBsYXllcnMgdG8gc3BlY2lm
eSB0aGUgYnl0ZSBvcmRlciBpbiBEVFINCj4+Pj4+Pj4+Pj4+IG1vZGUuDQo+Pj4+Pj4+Pj4+DQo+
Pj4+Pj4+Pj4+IEFyZSB0aGVyZSBhbnkgcGF0Y2hlcyBmb3IgdGhlIGF0bWVsLXF1YWRzcGkgeWV0
PyBXaGF0IGhhcHBlbnMNCj4+Pj4+Pj4+Pj4gaWYNCj4+Pj4+Pj4+Pg0KPj4+Pj4+Pj4+IG5vdCBw
dWJsaWMsIGJ1dCB3aWxsIHB1Ymxpc2ggdGhlbSB0aGVzZSBkYXlzLg0KPj4+Pj4+Pj4+DQo+Pj4+
Pj4+Pj4+IHRoZSBjb250cm9sbGVyIGRvZXNuJ3Qgc3VwcG9ydCBpdD8gV2lsbCB0aGVyZSBiZSBh
IHNvZnR3YXJlDQo+Pj4+Pj4+Pj4+IGZhbGxiYWNrPw0KPj4+Pj4+Pj4+DQo+Pj4+Pj4+Pj4gbm8g
bmVlZCBmb3IgYSBmYWxsYmFjaywgdGhlIGNvbnRyb2xsZXIgY2FuIGlnbm9yZQ0KPj4+Pj4+Pj4+
IG9wLT5kYXRhLmR0cl9ic3dhcDE2DQo+Pj4+Pj4+Pj4gaWYNCj4+Pj4+Pj4+PiBpdCBjYW4ndCBz
d2FwIGJ5dGVzLg0KPj4+Pj4+Pj4NCj4+Pj4+Pj4+IEkgZG9uJ3QgdW5kZXJzdGFuZC4gSWYgdGhl
IGNvbnRyb2xsZXIgZG9lc24ndCBzd2FwIHRoZSAxNmJpdA0KPj4+Pj4+Pj4gdmFsdWVzLA0KPj4+
Pj4+Pj4geW91IHdpbGwgcmVhZCB0aGUgd3JvbmcgY29udGVudCwgbm8/DQo+Pj4+Pj4+Pg0KPj4+
Pj4+Pg0KPj4+Pj4+PiBJbiBsaW51eCBubywgYmVjYXVzZSBtYWNyb25peCBzd2FwcyBieXRlcyBv
biBhIDIgYnl0ZSBib3VuZGFyeQ0KPj4+Pj4+PiBib3RoIG9uDQo+Pj4+Pj4+IHJlYWRzIGFuZCBv
biBwYWdlIHByb2dyYW0uIFRoZSBwcm9ibGVtIGlzIHdoZW4geW91IG1peCA4RC04RC04RA0KPj4+
Pj4+PiBtb2RlDQo+Pj4+Pj4+IGFuZA0KPj4+Pj4+PiAxLTEtMSBtb2RlIGFsb25nIHRoZSBib290
IHN0YWdlcy4gTGV0J3MgYXNzdW1lIHlvdSB3cml0ZSBhbGwgYm9vdA0KPj4+Pj4+PiBiaW5hcmll
cw0KPj4+Pj4+PiBpbiAxLTEtMSBtb2RlLiBXaGVuIHJlYWNoaW5nIHUtYm9vdCBpZiB5b3UgZW5h
YmxlIDhELThELThEIG1vZGUsDQo+Pj4+Pj4+IHdoZW4NCj4+Pj4+Pj4gdS1ib290DQo+Pj4+Pj4+
IHdpbGwgdHJ5IHRvIGdldCB0aGUga2VybmVsIGl0IHdpbGwgZmFpbCwgYXMgdGhlIGZsYXNoIHN3
YXBzIHRoZQ0KPj4+Pj4+PiBieXRlcw0KPj4+Pj4+PiBjb21wYXJlZA0KPj4+Pj4+PiB0byB3aGF0
IHdhcyB3cml0dGVuIHdpdGggMS0xLTEgbW9kZS4gWW91IHdyaXRlIEQwIEQxIEQyIEQzIGluDQo+
Pj4+Pj4+IDEtMS0xDQo+Pj4+Pj4+IG1vZGUgYW5kDQo+Pj4+Pj4+IHdoZW4gcmVhY2hpbmcgdS1i
b290IHlvdSB3aWxsIHJlYWQgRDEgRDAgRDMgRDIgYW5kIGl0IHdpbGwgbWVzcw0KPj4+Pj4+PiB0
aGUNCj4+Pj4+Pj4ga2VybmVsIGltYWdlLg0KPj4+Pj4+DQo+Pj4+Pj4gQnV0IHlvdSBoYXZlIHRv
IGNvbnNpZGVyIGFsc28gM3JkIHBhcnRpZXMsIGxpa2UgYW4gZXh0ZXJuYWwNCj4+Pj4+PiBwcm9n
cmFtbWVyDQo+Pj4+Pj4gb3INCj4+Pj4+DQo+Pj4+PiBXaHk/IElmIHlvdSB1c2UgdGhlIHNhbWUg
bW9kZSB3aGVuIHJlYWRpbmcgYW5kIHdyaXRpbmcsIGV2ZXJ5dGhpbmcNCj4+Pj4+IGlzIGZpbmUu
DQo+Pj4+PiBJJ20gbm90IHN1cmUgd2hhdCdzIHlvdXIgc3VnZ2VzdGlvbiBoZXJlLg0KPj4+Pg0K
Pj4+PiBTbyBvdXIgc3RhbmNlIGhlcmUgaXMgdGhhdCB3ZSBkb24ndCBjYXJlIGFib3V0IGV4dGVy
bmFsIHByb2dyYW1zPz4NCj4+Pj4gSWYgdGhhdCBpcyB0aGUgY2FzZSB0aGVuIHdoeSBib3RoZXIg
d2l0aCBhbGwgdGhpcyBhbnl3YXk/IFNpbmNlIHRoZQ0KPj4+PiBzd2FwDQo+Pj4+IGhhcHBlbnMg
YXQgYm90aCBwYWdlIHByb2dyYW0gYW5kIHJlYWQsIHdoYXQgeW91IHdyaXRlIGlzIHdoYXQgeW91
DQo+Pj4+IHJlYWQNCj4+Pj4gYmFjay4gV2hvIGNhcmVzIHRoZSBvcmRlciBzdG9yZWQgaW4gdGhl
IGFjdHVhbCBmbGFzaCBtZW1vcnkgYXMgbG9uZw0KPj4+PiBhcw0KPj4+PiB0aGUgZGF0YSByZWFk
IGlzIGNvcnJlY3Q/DQo+Pj4+DQo+Pj4+IElmIHdlIGRvIGNhcmUgYWJvdXQgZXh0ZXJuYWwgcHJv
Z3JhbXMsIHRoZW4gd2hhdCB3b3VsZCBoYXBwZW4gaWYgdGhlDQo+Pj4+IGV4dGVybmFsIHByb2dy
YW0gd3JpdGVzIGRhdGEgaW4gOEQtOEQtOEQgbW9kZSBfd2l0aG91dF8gc3dhcHBpbmcgdGhlDQo+
Pj4+IGJ5dGVzPyBUaGlzIHdvdWxkIGFsc28gY2F1c2UgZGF0YSBjb3JydXB0aW9uLiBZb3UgY2Fu
J3QgY29udHJvbCB3aGF0DQo+Pj4+IHRoZXkgbW9kZSB0aGV5IHVzZSwgYW5kIHlvdSBjYW4ndCBk
ZXRlY3QgaXQgbGF0ZXIgZWl0aGVyLg0KPj4+Pg0KPj4+PiBJIHRoaW5rIHRoZXJlIGlzIG5vIHdp
bm5pbmcgaGVyZS4gWW91IGp1c3QgaGF2ZSB0byBzYXkgdGhhdCBleHRlcm5hbA0KPj4+PiBwcm9n
cmFtcyBzaG91bGQgd3JpdGUgaW4gOEQtOEQtOEQgbW9kZSBvciBpdCB3b24ndCBib290Lg0KPiAN
Cj4gSU1ITyBpdCBzaG91bGQganVzdCB3b3JrIHRoYXQgeW91IGNhbiB1c2UgMVMtMVMtMVMgbW9k
ZSBhbmQgOEQtOEQtOEQgb24NCj4gdGhlDQo+IHNhbWUgZmxhc2guIEFmdGVyIGFsbCwgdGhhdCBp
cyBUdWRvcidzIHVzZSBjYXNlLiBUaGUgUk9NIGFjY2VzcyB0aGUNCj4gZmxhc2gNCj4gaW4gc2lu
Z2xlIGJpdCBtb2RlIGFuZCBsaW51eCBpbiA4RC04RC04RCBtb2RlLiBNYXliZSB1LWJvb3Qgd2ls
bCB1c2UNCj4gcXVhZA0KPiBtb2RlIGluIGJldHdlZW4uIEFsbCBvZiB0aGVzZSBhY2Nlc3NlcyBz
aG91bGQgcmV0dXJuIHRoZSBzYW1lIGZsYXNoDQo+IGNvbnRlbnQuDQo+IA0KPj4+IEhvdyBhYm91
dCBzd2FwcGluZyB0aGUgYnl0ZXMganVzdCBhdCB1c2VyIHJlcXVlc3Q/IE1heWJlIHdpdGggYQ0K
Pj4+IEtjb25maWcNCj4+PiBvcHRpb24uDQo+Pg0KPj4gTWljaGFlbCBoYXMgc3VnZ2VzdGVkIG9u
ICNpcmMgdG8gYWx3YXlzIHN3YXAgdGhlIGJ5dGVzOiBpZiB0aGUgU1BJDQo+PiBjb250cm9sbGVy
DQo+PiBjYW4ndCBkbyBpdCwgdG8gZG8gaXQgaW4gc29mdHdhcmUgYXQgU1BJIE5PUiBsZXZlbC4g
SSBkb24ndCBrbm93IHdoYXQNCj4+IHRvIHNheQ0KPj4gYWJvdXQgdGhpcywgYmVjYXVzZSBKRURF
QzIxNiBqdXN0IGluZm9ybXMgdGhlIHJlYWRlciBJIGd1ZXNzOg0KPj4gIkJ5dGUgb3JkZXIgb2Yg
MTYtYml0IHdvcmRzIGlzIHN3YXBwZWQgd2hlbiByZWFkIGluIDhELThELThEIG1vZGUNCj4+IGNv
bXBhcmVkIHRvDQo+PiAxLTEtMSBtb2RlLiIsIHRoaXMgZG9lc24ndCBsb29rIGxpa2UgYSBoYXJk
IHJlcXVlc3QuIFRoZSBkb3duc2lkZSB0bw0KPj4gZG9pbmcNCj4+IHRoZSBzd2FwcGluZyBpbiBz
b2Z0d2FyZSBpcyBwZXJmb3JtYW5jZSBwZW5hbHR5IHdoaWNoIHdpbGwgbWFrZQ0KPj4gbWFjcm9u
aXgNCj4+IHVzZXJzIGhhdmUgc2Vjb25kIHRob3VnaHRzLiBJIGRvbid0IGhhdmUgYSBzdHJvbmcg
b3BpbmlvbiwgYnV0IEkgbGVhbg0KPj4gdG93YXJkcw0KPj4gZG9pbmcgdGhlIHN3YXAganVzdCBh
dCB1c2VyIHJlcXVlc3QsIHJlZ2FyZGxlc3MgaWYgSSBkbyBpdCB2aWEgdGhlIFNQSQ0KPj4gY29u
dHJvbGxlcg0KPj4gb3IgaW4gc29mdHdhcmUuDQo+IA0KPiBKdXN0IGhhdmluZyBhbmQgb3B0LWlu
IHdpbGwgYmUgYSBtZXNzIGluIHRoZSBmdXR1cmUgd2l0aCBmbGFzaGVzDQo+IGNvbnRhaW5pbmcN
Cj4gYnl0ZSBzd2FwcGVkIGNvbnRlbnQgYW5kIHdlIGNhbid0IGV2ZW4gZml4IGl0IGFuZCB3ZSB3
aWxsIGhhdmUgdG8gbGl2ZQ0KPiB3aXRoDQo+IHRoYXQgZm9yZXZlci4gSU1ITyByaWdodCBub3cg
aXMgdGhlIGJlc3QgdGltZSB0byBjaXJjdW12ZW50IHRoYXQNCj4gc2NlbmFyaW8uDQo+IEkgZG9u
J3QgaGF2ZSBhbnl0aGluZyBhZ2FpbnN0IG1ha2UgaXQgdXNlciBjb25maWd1cmFibGUsIGJ1dCBp
dCBzaG91bGQNCj4gYmUNCj4gYW4gb3B0LW91dC4NCj4gDQoNCnNvdW5kcyBnb29kIHRvIG1lDQoN
Cj4gSSBoYXZlbid0IGxvb2tlZCBhdCBhbnkgY29udHJvbGxlcnMgd2hvIGNhbiBkbyA4RC04RC04
RCBhY2Nlc3NlcywgbWF5YmUNCj4gbW9zdA0KPiBvZiB0aGVtIGNhbiBkbyB0aGUgc3dhcHBpbmcg
b24gdGhlaXIgb3duPyBTbyBpZiB5b3UgZG9uJ3Qgd2FudCB0bw0KPiBzdXBwb3J0IGENCj4gc29m
dHdhcmUgZmFsbGJhY2ssIHRoZW4gd2Ugc2hvdWxkIGp1c3Qgc2F5IHRoaXMgbW9kZSBpc24ndCBz
dXBwb3J0ZWQgaWYNCj4gdGhlIGNvbnRyb2xsZXIgY2FuJ3QgZG8gdGhlIGJ5dGUgc3dhcHBpbmcg
YW5kIHdlIGZhbGwgYmFjayB0byBhIHNsb3dlcg0KPiBtb2RlLg0KDQpTb2Z0d2FyZSBmYWxsYmFj
ayBvciBtb2RlIGRvd25ncmFkZSAtIGJvdGggYXJlIGdvb2QgaWRlYXMuDQpQcmF0eXVzaCwgY2Fu
IHlvdXIgT2N0YWwgU1BJIGNvbnRyb2xsZXIgc3dhcCBieXRlcyBvbiBhIDE2IGJpdCBib3VuZGFy
eT8NCg0KVGhlIG9ubHkgZGViYXRlIHRoYXQgd2UgaGF2ZSBpcyB3aGV0aGVyIHRvIGFsd2F5cyBz
d2FwIChvciBkb3duZ3JhZGUpLA0KdGh1cyB0byBoYXZlIHRoZSBzYW1lIGJ5dGUgb3JkZXIgYXMg
aW4gMS0xLTEsIG9yIHRvIGludHJvZHVjZSBhIEtjb25maWcgb3B0aW9uDQp0aGF0IHdpbGwgb3B0
LW91dCB0aGUgc3dhcCwgaXNuJ3QgaXQ/IEtjb25maWcgaXMgYSBiaXQgdWdsaWVyLCBidXQgbW9y
ZSBmbGV4aWJsZSwNCmFuZCB3ZSBzdGlsbCBkb24ndCBrbm93IGZvciBzdXJlIGlmIHRoZSBzd2Fw
IGlzIG1hbmRhdG9yeSBvciBub3QuIENhbiBzb21lb25lIGZyb20NCm1hY3Jvbml4IHNoZWQgc29t
ZSBsaWdodCBvbiB0aGlzIHRvcGljPw0KDQpDaGVlcnMsDQp0YQ0K
