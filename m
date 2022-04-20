Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA06508093
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 07:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359405AbiDTF22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 01:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243249AbiDTF20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 01:28:26 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FDC435276
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 22:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1650432340; x=1681968340;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=WBDaXT4KWauhXwCk2CoD6iJITEvi2gJVFzk61KIUGgk=;
  b=UeqaFaxkqAIlVVK7YCdcahcAClx96K5p6ANM6pGjbHCL3KwTuqXGs5c8
   DiBdkXQCtkd9W/iePjH9v6ryewJ2fw3KjCyNh5P8T+aUJQflBvkETPzuh
   5LE2lDBVoTgHXXO45qyWphvXtvq0lZ91bFxZbDI65n/FRzAqlfrgYiCID
   HzkQRDLYFhTCRgqDtAbT1UHDISIZLF0o1M2VIBeBGRBU3AmFgz0+jED8f
   ZewerEChY5bCWeTojqG2AN55pi/hujSK+nznyJaAJHtdJVLGcTP9q1ue8
   mX/QgV8gz5T4Y0+t7Wg2YBsSU1dwpD1Xm7IMGuR5n2pXRR1CASkNCoySf
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,274,1643698800"; 
   d="scan'208";a="170211571"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Apr 2022 22:25:39 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 19 Apr 2022 22:25:39 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Tue, 19 Apr 2022 22:25:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GZcM7g7Oj+r/N63s2a5utFTRutgiFbtakhbwCv8h9Cg9FE2ocwuBXUfpZwf1gvq6nHbSaHDpd0WOV3Jj5QTdY38O4CswPQoB25nfph6Gope24pM7X/oM6DYX4FQd2vlTc1BC1GbNHgWIOJLEiwzH2MUM+KdQH2W2fv6hG7Q1p/j3V7gE7wluatJ7U5IdBninfFbcGS8fX0URbdtkzieC7H9Ybh1bvuwbllb9lY7/h22iUOdd54amPaON5ej77teRwjE2o7srNjtOEq3LmKz18l4Td1B064HRHq7kMMRbH4Ixf/AEFcpXwQYVph+m0tVsVqMiaa436O9QwBWa1gKViA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WBDaXT4KWauhXwCk2CoD6iJITEvi2gJVFzk61KIUGgk=;
 b=JdVJUQfok9SYjzXQVyLKFmjWbVReFDwxgy6hSilLKsxXG9E5uGsrYXpVXnYodxHqriMTpurRiqonfTErqcHKO1JkmlP9RhoDEDWsCbf/amhPMJKksfJrhCc+Pvcys23g3MrvokVpC0pMLbiM2c+dODAZ7DA8HuGK0Cejk3DCZjwGUAXTQCdceuKul+9gWTyiNwGsp0AOmJvP7EF3xio/LWR6R+Cv8oY1S7VkfMqZg16b88kU9aJNeW2kRrTmIgY3rzoaMLvuCKMhYwnNT3yCht5+QFzdrRTJN2IWr5Mv74SbS40MeUihah+DhK4AgwAZwLKiLuohig+OSxl0RTDykA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WBDaXT4KWauhXwCk2CoD6iJITEvi2gJVFzk61KIUGgk=;
 b=UtR5kQDz8nzSLKaWG8WwTFUZx4MPRmNbuqJXsj9cLXcS26DMGbhQkx3lIhhNiVP9TndZ15AG+Tu7YtJ/7WMr/6aHHxXYHysm7Tv3icjLoLaK3IZcUJ7vn6GIg/ULunzqRxApzBUxasuRrvclPGA/yWtn3wG4DNpE3PkyRnlvqN0=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 05:25:37 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::3414:43b2:d8a:bc00]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::3414:43b2:d8a:bc00%7]) with mapi id 15.20.5186.013; Wed, 20 Apr 2022
 05:25:36 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <p.yadav@ti.com>
CC:     <michael@walle.cc>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Nicolas.Ferre@microchip.com>,
        <Takahiro.Kuwano@infineon.com>
Subject: Re: [PATCH v3 6/9] mtd: spi-nor: core: Add helpers to read/write any
 register
Thread-Topic: [PATCH v3 6/9] mtd: spi-nor: core: Add helpers to read/write any
 register
Thread-Index: AQHYU+YijgcwOSWAuEOiQaxrAfyzHw==
Date:   Wed, 20 Apr 2022 05:25:36 +0000
Message-ID: <1b77e02a-2dfe-3a41-6a28-c415f42e5fd7@microchip.com>
References: <20220411091033.98754-1-tudor.ambarus@microchip.com>
 <20220411091033.98754-7-tudor.ambarus@microchip.com>
 <0e4ec58c21490dcd9cf82ab89bd8c34c@walle.cc>
 <e21b0d76bf778f78f432ba27a673222d@walle.cc>
 <f318dbd9-d4bf-301a-b5c9-556d04d5bfe6@microchip.com>
 <20220419123245.zu4hypebz77ckygn@ti.com>
 <996f36b1303d191e472f56393aa6398e@walle.cc>
 <89083a31-b862-de50-fdca-d427fb908a08@microchip.com>
 <20220420043425.l77hmc4zm7cwfwdn@ti.com>
In-Reply-To: <20220420043425.l77hmc4zm7cwfwdn@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e7fdf42d-2985-46fe-6886-08da228e335f
x-ms-traffictypediagnostic: PH0PR11MB5832:EE_
x-microsoft-antispam-prvs: <PH0PR11MB5832A77CB0EF76BC70D89494F0F59@PH0PR11MB5832.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2micQ7zV/nt78FE63gMsWwIgVE6cX2RQKTDicXVD2Wj1h6GhqiIz0RH7UsAVAQpwhe/m4rUjtlB+9Inrd1WoPLgN0ENQLIylFTRqd/6taeHDYNo83j51PA5BPey5xeYgEsZKdYKCLjBnQBATJrl6CASd8NYrgonloNIedqx9eeqxvGfOylUA/JflJ3h+bj3BAegX/ifY36mBcSwCzx9vW1add9ENfoOd/zA11uOjkphF8ATCYL58xFdp4X/KT+y0WG4DvKZOKSTDuyvMUZlSbnGXcbiioY0a7bKhPqbOTC1eUwEjGpOHn6ruci/m+V1z4pP309Glzd6h3xZW4xShOOH8CauhOXyQHmuBzOyGoZ+wIQnGRHo75I7x/D1fZUX8SIvMej9NgTqfJOHh6oRLV5niToI4U1gWpjMZehBJX/12UN+voTxhmLB5XhVhnMryX7eKjjhY+mQZK2Dg1YdBVIGOHtErzCelfvinKETSKm68HpVxUzhzWhMVFWt0bbdT1MgChongpP/oWyZLz2kM0PcBR2vrzXStlNKO+fSr6m6J3QOM/z0YicgdW3xwxp7jvXbqh1C+vxagh5lawgnKGHQSKFAqo8MVUY2fZDDuGb54vVOqSVL++fKUjJ8rWxoHK7gLA5TIWIlgKLximJHqtHZ8WHvKiHkG6FVMse16x3BPzCeNkEzNjnt0XKkmHniFNBt3NF9brwRtBHUzrmI13Q+RBgXOdoa1D4j10a5j3CluSaTIY3n2ErW49ejFom8vBayor4nwXUYZ9LW8uCXWHw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(31686004)(508600001)(76116006)(66946007)(66476007)(66556008)(8676002)(26005)(83380400001)(8936002)(38070700005)(86362001)(5660300002)(66446008)(38100700002)(54906003)(6916009)(91956017)(31696002)(64756008)(122000001)(6486002)(71200400001)(6512007)(6506007)(186003)(2616005)(2906002)(36756003)(316002)(53546011)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VFlFUkxNZEpxMGV1Zlc2L0U5RGNRZFBXRGlYVmt4NnYwamdDWHZjUUxwY1B1?=
 =?utf-8?B?dXhoL3JobTQwNnhJMEYrQlNZSDZjMzh2QnhRaTlOUEJmaGxEVUJwN3Qyb25j?=
 =?utf-8?B?UWZka2pnbDVQN1lOa1JQMThzVGhaZ0VlcFc1aUJVZjhkM1ljdzc2MmRDbVJ4?=
 =?utf-8?B?TkUrR3M5aXptY1pvQjY3V1pxK0Y5cWcxOWcrbndwaytIUTFESlg1cG5MdVc0?=
 =?utf-8?B?ZlpmS05VOGhnbEM4YUY4T0l0aFpHNTdSY1VoTnhXMUovRVh0TmtFRFlwM2Z0?=
 =?utf-8?B?RnRTenFSMnpsUGE2QkZ6M3JQcnIxNDdSd2k2L3JMRzc3aXJVMHU4T3RDZENs?=
 =?utf-8?B?OVZVUXFPTStCS3B6aEhmbjBWUXdzQlAxa3JWMXBQRHNRTnB1Nkt1aWVUeE11?=
 =?utf-8?B?VmozUXN6czZKOVpJOWYrTmR0cU9OOXJQSytZQmZVWEN1U0VVTzRXaUtqcndL?=
 =?utf-8?B?TEZlM0pCd1hpbElsODFNSUtXOHdNYUMydFpKUVI4a3g1bnF2K0kwVnd0TEU3?=
 =?utf-8?B?QXY5YW9ldWFwcWxhWGptSXlkT2hKRS9VaDN1bXRuMEVxRzJNUDVRUjdKTlFz?=
 =?utf-8?B?aWY5Y0xFQXNvMUZ4Rkt1Y2Z1d1BZL1ZNZGxvMjNxdnBHelhGQ1kwMzJrbXJJ?=
 =?utf-8?B?aW9Ma1hUTFRBaEU5V1Z5bWsxM1NPS0dvdmlqZ2FqREllYWQ0ODJMcDV3Y0ZG?=
 =?utf-8?B?K3orOUVtUHdTRWhzb2lJcS9tOXFFUzhaS3NGSnR6dittbW55ZW5MUlluZjJv?=
 =?utf-8?B?RFpic21XRWdoU1N3bm8yWkRUYWpMYnREbzdnVDFHSnM4b21WTHUwTHpYZkRR?=
 =?utf-8?B?ZnhyVDhVTm5senlnU3F0UVgxV1dPc3BqTTNXYXA2SzZmMU44QXc1aWNGOVBx?=
 =?utf-8?B?dXY5V0JJNFl2NEdKcTZ3L0hkRjAwODNuQ0ZEODFyL3BQYlcrWUkxTkNnandp?=
 =?utf-8?B?bHpLREErVy93M3dsdlZHb2N4UU02c1hPUEloTklPYzg2TnpUMU5tU29majIx?=
 =?utf-8?B?bE9CdGozN2E4eTd3ajZ6Q2VGT1FHQXYranNoUXdZcjQzdEFBWWw3VGF4N2dS?=
 =?utf-8?B?RWZxZ2dGVnAzR0VUT0ZDeE12dW9rUm85blJRandqS1dBd1J1em14R2RmS3pP?=
 =?utf-8?B?Y3l6NDI1VTFUdkZjdmRGZXhoRjgzUmN4R21vYVJxa0RSakZqeFRjakdOM25i?=
 =?utf-8?B?NEVwNUx3U1RGbWwzU2cwNm5UV0tVSzhwREVCckp5c25QR256VTRvUHMyVmpX?=
 =?utf-8?B?NVBuTFNOWitHWTlJQmYwYzhsSGM0TFZBMDNzSng3MEJsYUtQM2RvREVGcThT?=
 =?utf-8?B?MHdQVk4yWldPM2dkSk1CNTdkWkVGVUJtNE9ld1hTWGEwRk10REtNYjJKbm5P?=
 =?utf-8?B?aFo4V3lPZytnUzdkWGtjaHdPb2UyNVNmQmpJaWVpalJOcy9kdzZCQ1UwZDhs?=
 =?utf-8?B?c2JxcEVoaTRkT2N2bGtybnJXMG5NNzhMekVHSHlTVkxRSVlnNnQ4c2IrK0to?=
 =?utf-8?B?NFg3WFRtUDNyOG9iRk4xQ3NtM0xrTTNhaEVjOWs4VVVteGFVVWlGZk5USWhv?=
 =?utf-8?B?ZzQzeWlGUWJQekI4MWJhYW9ES3FUazVpOE1CYmIzM1pwZVlsd3NFNTRuUEhN?=
 =?utf-8?B?bVgxTjJ4YjZvaktMMW9VT3ljNUtRM3ZWbkZXT3EybitmcUtsS3FaRThLSnMx?=
 =?utf-8?B?RCtxTHdOWkNuTXVYbmtEc0tVRzI0dzFyeDZuM1FWeEd2NDB4V2pPMDM3b1hO?=
 =?utf-8?B?dUhLUUoyaHNnZm53ajFadHNuY292NWNSKzE3bjEvZDY5dWYyaXVETkpSNzZt?=
 =?utf-8?B?K2J2RFVPM2t6dGtnb0ZkOHlrS0ZkODhMUWN5MXlEbkQrUnViY0pMbGJpaEQ4?=
 =?utf-8?B?MUNLbmlqekZBM3IzazEzSVZRSE5pMnY3a0VaU3o1b3IwZXU5b08yVVZndmRt?=
 =?utf-8?B?SGtwUW5mYU53YUpPNE1XM1owVVFOY3RrSmp0NExSb2RSelp5QVZQQmRvYWxY?=
 =?utf-8?B?RFMxZmx0NlJFQkVtZVZybDhUMHYvV05WZFd0WkJLU3ptSGdNby9JVFlBbGVy?=
 =?utf-8?B?Q1kvNTdTSEphZTlnbW4vOTd6U0JxZEh3cGNTSHFyeHlMMGxpenhPQUlrczZH?=
 =?utf-8?B?K3FoRUpDQjlDWWpsbk91bDBJb1RkSVBzTW0wSkhOSTg3eHJIcVBqYUJZUThN?=
 =?utf-8?B?UzFTOXVFMjRORm9WZ0ZZVzZLaG5XTS9zeklQSGZaYUVFdXIyQ2FsakxVc3NG?=
 =?utf-8?B?UCtiNHpsL1lCaCtCdWNVMlJqUzhlbWN1ZUhGWm1QaE9LYnl6bkYzNVloWXg1?=
 =?utf-8?B?NFhISHovZjAwWEExaEJPNXZlVDBlMVRhUVBlUzdJaU5SbGw1dTVWVktkSDZE?=
 =?utf-8?Q?HX+yKAI5I+MeNZi4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <55EEF8CB09A6C244802B8C2BA5CC67E6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7fdf42d-2985-46fe-6886-08da228e335f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2022 05:25:36.8781
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q0k9iBCXHGAkc0A8Bpsn9sWaA4pTbGIFJn+g+BUxATCZ7mRkUrH9CM4ridR2llUlGauSBBQU7PQT8VRrgATk4wlFjajizYtIYO2Jtqtr0DI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5832
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC8yMC8yMiAwNzozNCwgUHJhdHl1c2ggWWFkYXYgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlM
OiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cg
dGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gMTkvMDQvMjIgMTI6NTZQTSwgVHVkb3IuQW1i
YXJ1c0BtaWNyb2NoaXAuY29tIHdyb3RlOg0KPj4gT24gNC8xOS8yMiAxNTo0NiwgTWljaGFlbCBX
YWxsZSB3cm90ZToNCj4+PiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9w
ZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4+Pg0K
Pj4+IEFtIDIwMjItMDQtMTkgMTQ6MzIsIHNjaHJpZWIgUHJhdHl1c2ggWWFkYXY6DQo+Pj4+IE9u
IDE5LzA0LzIyIDEyOjA4UE0sIFR1ZG9yLkFtYmFydXNAbWljcm9jaGlwLmNvbSB3cm90ZToNCj4+
Pj4+IE9uIDQvMTkvMjIgMTQ6NDYsIE1pY2hhZWwgV2FsbGUgd3JvdGU6DQo+Pj4+Pj4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+Pj4+Pj4NCj4+Pj4+PiBBbSAyMDIyLTA0LTE5
IDEzOjE5LCBzY2hyaWViIE1pY2hhZWwgV2FsbGU6DQo+Pj4+Pj4+IEFtIDIwMjItMDQtMTEgMTE6
MTAsIHNjaHJpZWIgVHVkb3IgQW1iYXJ1czoNCj4+Pj4+Pj4+IFRoZXJlIGFyZSBtYW51ZmFjdHVy
ZXJzIHRoYXQgdXNlIHJlZ2lzdGVycyBpbmRleGVkIGJ5IGFkZHJlc3MuIFNvbWUgb2YNCj4+Pj4+
Pj4+IHRoZW0gc3VwcG9ydCAicmVhZC93cml0ZSBhbnkgcmVnaXN0ZXIiIG9wY29kZXMuIFByb3Zp
ZGUgY29yZSBtZXRob2RzDQo+Pj4+Pj4+PiB0aGF0DQo+Pj4+Pj4+PiBjYW4gYmUgdXNlZCBieSBh
bGwgbWFudWZhY3R1cmVycy4gU1BJIE5PUiBjb250cm9sbGVyIG9wcyBhcmUNCj4+Pj4+Pj4+IGlu
dGVudGlvbmFsbHkNCj4+Pj4+Pj4+IG5vdCBzdXBwb3J0ZWQgYXMgd2UgaW50ZW5kIHRvIG1vdmUg
YWxsIHRoZSBTUEkgTk9SIGNvbnRyb2xsZXIgZHJpdmVycw0KPj4+Pj4+Pj4gdW5kZXIgdGhlIFNQ
SSBzdWJzeXN0ZW0uDQo+Pj4+Pj4+Pg0KPj4+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogVHVkb3IgQW1i
YXJ1cyA8dHVkb3IuYW1iYXJ1c0BtaWNyb2NoaXAuY29tPg0KPj4+Pj4+Pj4gVGVzdGVkLWJ5OiBU
YWthaGlybyBLdXdhbm8gPFRha2FoaXJvLkt1d2Fub0BpbmZpbmVvbi5jb20+DQo+Pj4+Pj4+PiBS
ZXZpZXdlZC1ieTogUHJhdHl1c2ggWWFkYXYgPHAueWFkYXZAdGkuY29tPg0KPj4+Pj4+Pg0KPj4+
Pj4+PiBJIHN0aWxsIGRvbid0IGxpa2UgaXQgYmVjYXVzZSB0aGUgZnVuY3Rpb24gZG9lc24ndCBk
bw0KPj4+Pj4+PiBhbnl0aGluZyB3aGF0IHRoZSBmdW5jdGlvbiBuYW1lIG1pZ2h0IHN1Z2dlc3Qu
IFRoZSByZWFkDQo+Pj4+Pj4+IGp1c3QgZXhlY3V0ZXMgYW4gb3AsIHRoZSB3cml0ZSBleGVjdXRl
cyBhbiBvcCB3aXRoIGENCj4+Pj4+Pj4gd3JpdGUgZW5hYmxlIGJlZm9yZS4gQWxsIHRoZSBiZWhh
dmlvciBpcyBkZXRlcm1pbmVkIGJ5IHRoZQ0KPj4+Pj4+PiAnb3AnIGFyZ3VtZW50Lg0KPj4+Pj4+
Pg0KPj4+Pj4+PiBBbnl3YXksDQo+Pj4+Pj4+IFJldmlld2VkLWJ5OiBNaWNoYWVsIFdhbGxlIDxt
aWNoYWVsQHdhbGxlLmNjPg0KPj4+Pj4+Pg0KPj4+Pj4+Pj4gLS0tDQo+Pj4+Pj4+PiB2Mzogbm8g
Y2hhbmdlcw0KPj4+Pj4+Pj4NCj4+Pj4+Pj4+IMKgIGRyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5j
IHwgNDENCj4+Pj4+Pj4+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+
Pj4+Pj4+PiDCoCBkcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuaCB8wqAgNCArKysrDQo+Pj4+Pj4+
PiDCoCAyIGZpbGVzIGNoYW5nZWQsIDQ1IGluc2VydGlvbnMoKykNCj4+Pj4+Pj4+DQo+Pj4+Pj4+
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmMgYi9kcml2ZXJzL210ZC9z
cGktbm9yL2NvcmUuYw0KPj4+Pj4+Pj4gaW5kZXggNjE2NWRjN2JmZDE3Li40Mjc5NDMyOGQzYjYg
MTAwNjQ0DQo+Pj4+Pj4+PiAtLS0gYS9kcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuYw0KPj4+Pj4+
Pj4gKysrIGIvZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmMNCj4+Pj4+Pj4+IEBAIC0zMDcsNiAr
MzA3LDQ3IEBAIHNzaXplX3Qgc3BpX25vcl93cml0ZV9kYXRhKHN0cnVjdCBzcGlfbm9yICpub3Is
DQo+Pj4+Pj4+PiBsb2ZmX3QgdG8sIHNpemVfdCBsZW4sDQo+Pj4+Pj4+PiDCoMKgwqDCoMKgIHJl
dHVybiBub3ItPmNvbnRyb2xsZXJfb3BzLT53cml0ZShub3IsIHRvLCBsZW4sIGJ1Zik7DQo+Pj4+
Pj4+PiDCoCB9DQo+Pj4+Pj4+Pg0KPj4+Pj4+Pj4gKy8qKg0KPj4+Pj4+Pj4gKyAqIHNwaV9ub3Jf
cmVhZF9yZWcoKSAtIHJlYWQgcmVnaXN0ZXIgdG8gZmxhc2ggbWVtb3J5DQo+Pj4+Pj4+PiArICog
QG5vcjogICAgICAgIHBvaW50ZXIgdG8gJ3N0cnVjdCBzcGlfbm9yJy4NCj4+Pj4+Pj4+ICsgKiBA
b3A6ICAgICAgICAgICAgIFNQSSBtZW1vcnkgb3BlcmF0aW9uLiBvcC0+ZGF0YS5idWYgbXVzdCBi
ZSBETUEtYWJsZS4NCj4+Pj4+Pj4+ICsgKiBAcHJvdG86ICBTUEkgcHJvdG9jb2wgdG8gdXNlIGZv
ciB0aGUgcmVnaXN0ZXIgb3BlcmF0aW9uLg0KPj4+Pj4+Pj4gKyAqDQo+Pj4+Pj4+PiArICogUmV0
dXJuOiB6ZXJvIG9uIHN1Y2Nlc3MsIC1lcnJubyBvdGhlcndpc2UNCj4+Pj4+Pj4+ICsgKi8NCj4+
Pj4+Pj4+ICtpbnQgc3BpX25vcl9yZWFkX3JlZyhzdHJ1Y3Qgc3BpX25vciAqbm9yLCBzdHJ1Y3Qg
c3BpX21lbV9vcCAqb3AsDQo+Pj4+Pj4+PiArICAgICAgICAgICAgICAgICBlbnVtIHNwaV9ub3Jf
cHJvdG9jb2wgcHJvdG8pDQo+Pj4+Pj4+PiArew0KPj4+Pj4+Pj4gKyAgICBpZiAoIW5vci0+c3Bp
bWVtKQ0KPj4+Pj4+Pj4gKyAgICAgICAgICAgIHJldHVybiAtRU9QTk9UU1VQUDsNCj4+Pj4+Pj4+
ICsNCj4+Pj4+Pj4+ICsgICAgc3BpX25vcl9zcGltZW1fc2V0dXBfb3Aobm9yLCBvcCwgcHJvdG8p
Ow0KPj4+Pj4+Pj4gKyAgICByZXR1cm4gc3BpX25vcl9zcGltZW1fZXhlY19vcChub3IsIG9wKTsN
Cj4+Pj4+Pj4+ICt9DQo+Pj4+Pj4+PiArDQo+Pj4+Pj4+PiArLyoqDQo+Pj4+Pj4+PiArICogc3Bp
X25vcl93cml0ZV9yZWcoKSAtIHdyaXRlIHJlZ2lzdGVyIHRvIGZsYXNoIG1lbW9yeQ0KPj4+Pj4+
Pj4gKyAqIEBub3I6ICAgICAgICBwb2ludGVyIHRvICdzdHJ1Y3Qgc3BpX25vcicNCj4+Pj4+Pj4+
ICsgKiBAb3A6ICAgICAgICAgICAgIFNQSSBtZW1vcnkgb3BlcmF0aW9uLiBvcC0+ZGF0YS5idWYg
bXVzdCBiZSBETUEtYWJsZS4NCj4+Pj4+Pj4+ICsgKiBAcHJvdG86ICBTUEkgcHJvdG9jb2wgdG8g
dXNlIGZvciB0aGUgcmVnaXN0ZXIgb3BlcmF0aW9uLg0KPj4+Pj4+Pj4gKyAqDQo+Pj4+Pj4+PiAr
ICogUmV0dXJuOiB6ZXJvIG9uIHN1Y2Nlc3MsIC1lcnJubyBvdGhlcndpc2UNCj4+Pj4+Pj4+ICsg
Ki8NCj4+Pj4+Pj4+ICtpbnQgc3BpX25vcl93cml0ZV9yZWcoc3RydWN0IHNwaV9ub3IgKm5vciwg
c3RydWN0IHNwaV9tZW1fb3AgKm9wLA0KPj4+Pj4+Pj4gKyAgICAgICAgICAgICAgICAgIGVudW0g
c3BpX25vcl9wcm90b2NvbCBwcm90bykNCj4+Pj4+Pj4+ICt7DQo+Pj4+Pj4+PiArICAgIGludCBy
ZXQ7DQo+Pj4+Pj4+PiArDQo+Pj4+Pj4+PiArICAgIGlmICghbm9yLT5zcGltZW0pDQo+Pj4+Pj4+
PiArICAgICAgICAgICAgcmV0dXJuIC1FT1BOT1RTVVBQOw0KPj4+Pj4+Pj4gKw0KPj4+Pj4+Pj4g
KyAgICByZXQgPSBzcGlfbm9yX3dyaXRlX2VuYWJsZShub3IpOw0KPj4+Pj4+Pj4gKyAgICBpZiAo
cmV0KQ0KPj4+Pj4+Pj4gKyAgICAgICAgICAgIHJldHVybiByZXQ7DQo+Pj4+Pj4+PiArICAgIHNw
aV9ub3Jfc3BpbWVtX3NldHVwX29wKG5vciwgb3AsIHByb3RvKTsNCj4+Pj4+Pj4+ICsgICAgcmV0
dXJuIHNwaV9ub3Jfc3BpbWVtX2V4ZWNfb3Aobm9yLCBvcCk7DQo+Pj4+Pj4NCj4+Pj4+PiBBZnRl
ciBzZWVpbmcgeW91ciBuZXh0IHR3byBwYXRjaGVzLiBTaG91bGRuJ3QgdGhlDQo+Pj4+Pj4gc3Bp
X25vcl93YWl0X3VudGlsX3JlYWR5KCkgY2FsbCBiZSBoZXJlIHRvbz8NCj4+Pj4+Pg0KPj4+Pj4N
Cj4+Pj4+IEkgdGhvdWdodCBvZiB0aGlzIHRvbywgYnV0IHNlZW1zIHRoYXQgZm9yIGEgcmVhc29u
IHRoYXQgSSBkb24ndA0KPj4+Pj4gcmVtZW1iZXIsIHdlIGRvbid0IGNhbGwgZm9yIHNwaV9ub3Jf
d2FpdF91bnRpbF9yZWFkeSBhZnRlciB3ZQ0KPj4+Pj4gd3JpdGUgdGhlIG9jdGFsIERUUiBiaXQu
IFByYXR5dXNoLCBkbyB5b3UgcmVtZW1iZXIgd2h5Pw0KPj4+Pg0KPj4+PiBXZSBhcmUgbm90IHN1
cmUgdGhlIHByb3RvY29sIGNoYW5nZWQgY29ycmVjdGx5IHNvIHdlIGNhbid0IHJlbHkgb24NCj4+
Pj4gc3BpX25vcl93YWl0X3VudGlsX3JlYWR5KCkuIFdlIHJlYWQgdGhlIElEIGluc3RlYWQgdG8g
YmUgc3VyZS4NCj4+Pg0KPj4+IFNvIGJlc2lkZXMgdGhlIGZhY3QgdGhhdCB0aGUgd3JpdGVfcmVn
IG9ubHkgd29ya3Mgd2l0aCB0aGUgJ2NvcnJlY3QnDQo+Pj4gb3AgcGFyYW1ldGVyLCBpdCBpcyBh
bHNvIHRhaWxvcmVkIHRvIHRoZSBzcGVjaWFsIHVzZSBjYXNlLiBGb3IgcmVhbA0KPj4+IHdyaXRl
X3JlZygpLCB0aGUgdXNlciB3b3VsZCBhY3R1YWxseSBoYXMgdG8gcG9sbCB0aGUgc3RhdHVzIGJp
dA0KPj4+IGFmdGVyd2FyZHM/IDooDQo+Pj4NCj4+IERvbid0IGJlIHNhZCA6RC4gQXJlIHRoZSBv
Y3RhbCBEVFIgbWV0aG9kcyBhbiBleGNlcHRpb24/DQo+PiBJZiB5ZXMsIGxldCdzIGFkZCB0aGUg
Y2FsbCB0byBzcGlfbm9yX3dhaXRfdW50aWxfcmVhZHkoKSBpbiB0aGUNCj4+IHJlYWQvd3JpdGVf
YW55X3JlZygpIG1ldGhvZHMsIGFuZCBsZXQgdGhlIG9jdGFsIG1ldGhvZHMgaGFuZGxlDQo+PiB0
aGUgc3BlY2lmaWMgd3JpdGUgdGhlbXNlbHZlcywgd2l0aG91dCBjYWxsaW5nIGZvciByZWFkeSgp
DQo+IA0KPiBJdCBoYXMgYmVlbiBhIHdoaWxlLCBidXQgSUlSQyBJIGFza2VkIEN5cHJlc3MgYWJv
dXQgdGhpcywgYmVjYXVzZSBJIHdhcw0KPiB3b3JyaWVkIGFib3V0IHJlYWRpbmcgSUQgd2hpbGUg
dGhlIHN3aXRjaCB0byA4RCBtb2RlIHdhcyBzdGlsbCBpbg0KPiBwcm9ncmVzcy4gVGhleSBzYWlk
IHRoYXQgdm9sYXRpbGUgcmVnaXN0ZXIgd3JpdGVzIGFyZSBpbnN0YW50IGFuZCBkbyBub3QNCj4g
bmVlZCBhbnkgc3RhdHVzIHBvbGxpbmcuIFNvIHRoZSBzd2l0Y2ggdG8gOEQtOEQtOEQgbW9kZSB3
b3VsZCBiZSBpbnN0YW50DQo+IGFuZCB0aGVyZSBpcyBubyBuZWVkIHRvIHdhaXQgZm9yIGFueXRo
aW5nLg0KPiANCj4gVGhlIEN5cHJlc3MgUzI4IGZsYXNoIGRhdGFzaGVldCBkb2VzIG5vdCBzYXkg
dGhpcyBleHBsaWNpdGx5LiBJdCBkb2VzDQo+IHNheSB0aGF0IHdyaXRpbmcgdG8gbm9uLXZvbGF0
aWxlIHJlZ2lzdGVycyB0YWtlcyB0aW1lIGFuZCB5b3UgbmVlZCB0bw0KPiB3YWl0IGZvciByZWFk
eSBmb3IgdGhvc2UsIGJ1dCBtYWtlcyBubyBtZW50aW9uIG9mIHZvbGF0aWxlIHJlZ2lzdGVycy4g
V2UNCj4gZG9uJ3QgZXZlciB3YW50IHRvIHdyaXRlIG5vbi12b2xhdGlsZSByZWdpc3RlcnMgc28g
d2UgY2FuIGlnbm9yZSB0aGF0DQo+IHByb2JsZW0uDQo+IA0KPiBJIHNlZSB0aGUgTWljcm9uIE1U
MzUgZGF0YXNoZWV0IHNheSB0aGlzIGV4cGxpY2l0bHksIHRoYXQgY2hhbmdlcyB0bw0KPiB2b2xh
dGlsZSByZWdpc3RlcnMgYXJlIGluc3RhbnQuDQo+IA0KPiBTbyBJIHdvdWxkIHNheSB0aGF0IGJh
c2VkIG9uIG15IGxpbWl0ZWQgc2FtcGxlIHNpemUsIHZvbGF0aWxlIHJlZ2lzdGVyDQo+IHdyaXRl
cyBmb3IgQ3lwcmVzcyBhbmQgTWljcm9uIGZsYXNoZXMgZG8gX25vdF8gbmVlZA0KPiBzcGlfbm9y
X3dhaXRfdW50aWxfcmVhZHkoKS4NCg0KVGhhbmtzLCBQcmF0eXVzaCEgSSdsbCBhZGQgYSBjb21t
ZW50IGFuZC9vciB1cGRhdGUgdGhlIGNvbW1pdCBtZXNzYWdlLA0KdGhpcyBpcyB1c2VmdWwgaW5m
by4NCg0KQ2hlZXJzLA0KdGENCg0K
