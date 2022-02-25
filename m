Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 962594C493F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 16:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242234AbiBYPjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 10:39:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241322AbiBYPjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 10:39:06 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7497D54BFB
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 07:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1645803512; x=1677339512;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=u7Yw6dLJNHcuD2tnE4UUwQGTg2AoI+n8dyJ7un9Jdt4=;
  b=2sNyGkChJw5KL/tyMe9PLXuD8a1QWfXAGpKKoSYDxH6KWVhOB1d6Dxz3
   gdJOYBtMrl15dV6ELn9463eDYFLyZXOxci2AYaOYjm0hiBRDkpZBmKQq/
   EpXepjgKVrJcBXndSqz96th0NStM8Ace8SysfpGd4boRo5ny0ZL4HbEoX
   YeVOvSsFGKVXNKxLc+gQSEoIaSPnLxwsUzOIfFVhXP3/1Fbhxsa4ApVr9
   VuZpn44lakhysX7WewirN3iECSqfxXXYdW0iGyUKBBZ+v7dOQTGutFbXl
   5bwhoqIyhQIhjzzQdHlLxzxzO0QHN36PsnHd1zalHR7eYvgN0SB8+MBFV
   g==;
X-IronPort-AV: E=Sophos;i="5.90,136,1643698800"; 
   d="scan'208";a="150026786"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Feb 2022 08:38:31 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 25 Feb 2022 08:38:31 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Fri, 25 Feb 2022 08:38:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eFsAp8TJ23Rz4dhP0ZVRbMyBGm+15XoTSrUTSjAdOW2e2pbrQlVeKjEnrtaonbSrYk8POoC518JOfnREaRdo3RLNbZKC/pdJaHzoFN5LdGnP+x4dkhlEGXgBIkxNPssLw2pSPFpdjC+d8bQ+jf/qENQViSmQapUTsFhyUSVE9aSeUyCQ8hWQuoNNf1orF0P9m4JieUto31QYQ7gfW/Z8nCk/y4POyaOfmD7A9TARNIR8Mve+fhG97OsJSswZ5KWJGke4yGoOF12l0SVrxWRUVHMRU8swG2cEKDzFUBl6P2s+Lr4aH9Yi5HU08Cw56744QTqOVp2ew+fPWFti/U4ycw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u7Yw6dLJNHcuD2tnE4UUwQGTg2AoI+n8dyJ7un9Jdt4=;
 b=iD3M9N+rjkpFrUuMGikOyZpUoG21JmgTxRQF9VUXRIkMND4idj5n373DargkisF01tc3sT/3FFCrHDT+qBgJEoFf4kZ0OyLZCWN0CRayUiIZRcPWOGWJG97ueJbt9sYIwbLCfQbM/aw6YXFY91YmToQRBSqgWPNtmJ6kcXyPHlr0vWYOX4eP7yZTlBuQMbdPN/QdySIXoHNaGpQicZNYtLUyDlaRzt5kkKYM8oeirSj2EtRdhPmXlDKBiGIricFNS4BtqyhPZP2jLuyae8YKBDUXzTMY6o4RkeWE7slNd28l3bakOY6v43aYrcptNPA0haIYxef//2gbSi1FY04N1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u7Yw6dLJNHcuD2tnE4UUwQGTg2AoI+n8dyJ7un9Jdt4=;
 b=rjzsPh1hDmWvAzjAmnu/krXzjxp6Cs2yAigr84XPQgkWaNEIope89wImkOjSNPukuN+XTrcfrtKtfdJgqwTCnQY00fKZNutGc1d66KRTqROAR/HZSwuP+ojCfWJySN2JPY9GSw0Jbd8ag+TgslvCtZFoiLnLFGEaKGteR85K3f4=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by BY5PR11MB4212.namprd11.prod.outlook.com (2603:10b6:a03:1cb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Fri, 25 Feb
 2022 15:38:26 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::dc94:3c7c:8ef8:21b9]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::dc94:3c7c:8ef8:21b9%5]) with mapi id 15.20.5017.026; Fri, 25 Feb 2022
 15:38:26 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <p.yadav@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <yaliang.wang@windriver.com>
Subject: Re: [PATCH v5 26/32] mtd: spi-nor: micron-st: rename vendor specific
 functions and defines
Thread-Topic: [PATCH v5 26/32] mtd: spi-nor: micron-st: rename vendor specific
 functions and defines
Thread-Index: AQHYKlBqRJ8KViEGekaFpWEnk7/QxA==
Date:   Fri, 25 Feb 2022 15:38:26 +0000
Message-ID: <1c615470-8c89-6e41-0e19-51186e20cf3a@microchip.com>
References: <20220223134358.1914798-1-michael@walle.cc>
 <20220223134358.1914798-27-michael@walle.cc>
 <3bd0bfad-7f04-a972-0f65-21dea2173dd7@microchip.com>
 <7f3ab0cc9115f15f1cfa85e7da13d56d@walle.cc>
In-Reply-To: <7f3ab0cc9115f15f1cfa85e7da13d56d@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d9852cd-8950-4d38-4025-08d9f874dd7b
x-ms-traffictypediagnostic: BY5PR11MB4212:EE_
x-microsoft-antispam-prvs: <BY5PR11MB421262D2C0FF8507FA754DE3F03E9@BY5PR11MB4212.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MGQO+rEaPm9PjySDoeAHCD1lPMjsUybaP9lMeohd0B6s1oops4UH7YqU43G9lW6xCz5Pym6NIjm8Ms89dc+9I2s4WMYrNy8HKcOhm1++Szqq802CA2bvve5lk6Wp64Z7OyWeamNlvdGTVM6E3ZgU9EK+MjyHQhW2igjtyTyXT3L7dk4hjZlWY9GMHy4AJOlXXUcJ2O0N32pxmbb5XWryMSjwSy0UBho/go6wVoF5A5S3YHymMeVrG7cv9TCs9+GI6TISWzLSzeXrMd4I7r5gw1c4l/6mpGGm9UGr8azjP6Yfzz8RGZVPa37XliFym8lSxZr0Uukhxb/hO6NtcCwFi/PVZWEzMrTGP7q7F9KWg3lzvTpTy40Zi51HgzC11ikPnU9os6KCWkaf1KSdsk63owSUz+BzVcIwiO+0SgqyA7gXM6XD3P53ulRIfViVMGfQKnP+GaTXyhI2vvq78pTLTpOqouS3sP+6pbMdJaJKVzi4dSlynLfIrMkjRrU9VjwOzhUfF/a3nBWJX3H50A/o+YkqZyp36t56oH9Xi2vHxCVqSN2OUEczc3yt6Ecurb4br1kiYLTPkIZOW9ITcnasML89r855urIz4zThk/3StU84TqgyMUWRMxCiDYRz4gymQDG3wUSNYiOuzYsfdZe5qgf/Th0hDcSAuqF+iFy9FZqjomfGSFGbltveVfOMK8xgtz216QDy7M3Wjr/bIpWjaJnJbudfPD14pKO6v6FVNhLRkqYSH6jzbAdQjijmYPWXYwZV/yKZKspB3pFlB7jeQA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(8936002)(91956017)(54906003)(6916009)(86362001)(38070700005)(5660300002)(76116006)(122000001)(66476007)(8676002)(64756008)(66446008)(38100700002)(2906002)(66556008)(4326008)(66946007)(6506007)(186003)(6512007)(71200400001)(31686004)(36756003)(83380400001)(53546011)(6486002)(31696002)(26005)(2616005)(508600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bXhzOEEzcWxHendQenB6VWpnZzRyR1Voa21hZHNpZitLL0ozdmZybGtJSzVx?=
 =?utf-8?B?WTErYmlQRlF6YmRqNG9mT1ptWE5YK3d0Y3RaNVV1Wm1TWUlnak5reit3ZjVi?=
 =?utf-8?B?L29kMk83WWQyZzVTeFNkS3NWTTFXdncyd24rcTNZbFpnU1FTdDZTWDJyTmJF?=
 =?utf-8?B?ZUlGcnJqOTdCZXU1TmM1SDhVdjFYZEdaT0pmM2wwU0N4SGdYOXh5cW9PS0du?=
 =?utf-8?B?ZjJXMmM3NkV4S1RPbzBhaHJUaFdEWnFjNXVva2pmTExWaDE0cTZZdXBmek9I?=
 =?utf-8?B?RDJvYTRNdXRJZDZmTGoxdFdWb2N0QUNrRnRKSW8rY04remNmV1RVSUxlMzZR?=
 =?utf-8?B?czQwUCs3c3dreHVJbGl3RUk0U2RiRTBxOUxTNTFycWNWRi9kR0RHN202V2hj?=
 =?utf-8?B?TFYzbVFsL2U3bEc4OUxhYW1WbVlxRFkwVUFMVWJPV25tN1RyT1NkYkFUSHYv?=
 =?utf-8?B?UGw5eTZzbFNBZVdvZHk3N2JrNjg2dHljc0xnQWxDZnBpYkN3NE0vcGd3UFpL?=
 =?utf-8?B?V0wreGcwQ3pjVWhyY1UzRkVPSUZMMnhOR1h1U3l5bHZMaW1ZWkU1eXZPcEZo?=
 =?utf-8?B?eVA5OUtNV3FyKzh2OFdsM2dDL1lCWnV5WS9GUmZLSFFGKzNyWnlpNHhucHEr?=
 =?utf-8?B?VzVWV2J4Q3RPTWg0aHNuT3pJZjUvakhFM00vclNpS3dOUmdMblhHY2NLdC9B?=
 =?utf-8?B?dGlGclB1MWNoWEp0MnFtNUgvYnRhRU8wMGRIby9YY0s4VGdKckl0WlV0enUx?=
 =?utf-8?B?bFZVVTdIODdvMWZkWlVHeU9hUllYam9KbXN0MlBWSzE3WDJscWtMMVpWZUFo?=
 =?utf-8?B?NWJYYVl1NmV2WlA2R3JpaHMrRi9RMzV3TkljMlcwRzNNV2JxTEcxSUQvNXNO?=
 =?utf-8?B?VFZUOVBUSEUzbnlwVnhaR0c4VkIwZSs1WmlHN1ZXZHl1ZmxKVS9hTU54Y014?=
 =?utf-8?B?WXB4b2k1Y1ZhZ3lTNmU4dktwVExMdkdQMmY4QUdpTm9oMWt5Qm9sTkl6Nkth?=
 =?utf-8?B?ZTdqdUtEdmx1ZGc3djRQMUpQSzRYMi9HeFJNMW5DaW9KK3VQSFZ4WHBORGs2?=
 =?utf-8?B?cFNwWUlLczJaNDdIczU1UE9XUTBFWFVWT3dTaWxWQkRCeTVWRWR0Y0E0SzA3?=
 =?utf-8?B?Y293dnNjWlhPZ3hQcHlNaGlWOWF2SWo0UEk1ZlpJZzM5L1h1d0owck9POVFJ?=
 =?utf-8?B?Zld6T3BiUTdTdDR2YVduczZyVEwvWFJ5a2pjUWFxM1BscTJ3SWVoTjFLNC84?=
 =?utf-8?B?NkxSY2JWc2NXVmNIWkNWZndITzV5eHBkZ2FSaklsdjRySi85MkUwOWJmTnQz?=
 =?utf-8?B?NWNpWEpvdFVuQUtieXVtZ2J2c2M3WE1Nam0yRitISlAxMENhbDJxcGhsQThl?=
 =?utf-8?B?RzZIZEpOM2licnc5T1FhdTRjU2hVWnJXT0VBL2I2dWRWMU9FcGpqMHJjQVNs?=
 =?utf-8?B?MFhyU0pjYnprVWMycWk4b1J0dEl5VDQzN2lVWXAzc2tBN3pWQ1JNcDhveEFH?=
 =?utf-8?B?TUxkRHA5bERVbFM5c0QwL1Q5NjZHYXVIN1VCTndURDV5RjFPbFl4TElvbTZu?=
 =?utf-8?B?ZTR0aFdzbndWUmRySHBNck5Zd3MyMTJzaVVnYUZnYjJKWHhIdjhESllLTXRD?=
 =?utf-8?B?RkNCRC9ua3VnZmxZK1JLbUhLRXpQeHU4Qy9BQjFFOXBIOTZNa0MrYVlPeGx6?=
 =?utf-8?B?cUF2NmJuK0xRcEZTczB4Szg3L1pzNWpZOVlxVStyMmtFRTVlQndDcW9PajZi?=
 =?utf-8?B?Z0RRNkZWUWZPcUMwZjdLL0VNUWVFWHlDZnFsM09VUS9BSGhJYndHV1FLYW9j?=
 =?utf-8?B?Uk1UN0J3NjR1SG9DdVV5VnRDOGFKNFZkLzZ4end3TVFZdWRjVmhhN2U2NzYx?=
 =?utf-8?B?L3AzeTVVWGZBMUxmWVZ4NHJVcERuMXV4S1VzMlZRbEJiYm9GZjNLSnBjVm9I?=
 =?utf-8?B?dGZzbzVVWThLdzBPaEdHM1NpMGdTejlpUlI4Ty9YSVRWRlVxRlBlMEh4QzZL?=
 =?utf-8?B?ZjZYOG12TkEwUDF2L20zTTNjU25jZlRIbHIzU3c4N1I0bkpVVC8wbDRsV2Fx?=
 =?utf-8?B?TDJqbllST3hVd3MrV0pSZjl2cEJsSkIzUXNTTnZtOHZDY21sc1kzRnUvbXVt?=
 =?utf-8?B?RjIveUhoYnpIU1JNL204K21obUxOVGQ5bkRvb2dBVkQxM1VGMWdtZnV6dGly?=
 =?utf-8?B?SldGTmFDdnB0MHpGc2FwaUE0L2U1MWdYclU2K1BvV1dma0FwdTNhdTMwZkR1?=
 =?utf-8?B?OC9UMUxMaXdhME92YUdLUFo0bXZ3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <53C7375D0787B54C92111C5DA5DB72BE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d9852cd-8950-4d38-4025-08d9f874dd7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2022 15:38:26.4279
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bAP8j3O5WCnVe5c71DqkFy3s7Ov53MkB2XuMUE66kvp8IiouL5peGIu0WrtiQJz21ZadBfYaJtMnE+i4+rdIjwiA0IvBwi2J2ad0JzSs6yk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4212
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMi8yNS8yMiAxNzozNiwgTWljaGFlbCBXYWxsZSB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6
IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0
aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBBbSAyMDIyLTAyLTI1IDE1OjAzLCBzY2hyaWViIFR1
ZG9yLkFtYmFydXNAbWljcm9jaGlwLmNvbToNCj4+IE9uIDIvMjMvMjIgMTU6NDMsIE1pY2hhZWwg
V2FsbGUgd3JvdGU6DQo+Pj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBv
cGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdw0KPj4+IHRoZSBjb250ZW50IGlzIHNhZmUN
Cj4+Pg0KPj4+IERyb3AgdGhlIGdlbmVyaWMgc3BpX25vciBwcmVmaXggZm9yIGFsbCB0aGUgbWlj
cm9uLXN0IGZ1bmN0aW9ucy4NCj4+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgV2FsbGUg
PG1pY2hhZWxAd2FsbGUuY2M+DQo+Pj4gVGVzdGVkLWJ5OiBQcmF0eXVzaCBZYWRhdiA8cC55YWRh
dkB0aS5jb20+ICMgb24gbXQzNXh1NTEyYWJhLA0KPj4+IHMyOGhzNTEydA0KPj4+IC0tLQ0KPj4+
IMKgZHJpdmVycy9tdGQvc3BpLW5vci9taWNyb24tc3QuYyB8IDE4ICsrKysrKysrKy0tLS0tLS0t
LQ0KPj4+IMKgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkN
Cj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9zcGktbm9yL21pY3Jvbi1zdC5jDQo+
Pj4gYi9kcml2ZXJzL210ZC9zcGktbm9yL21pY3Jvbi1zdC5jDQo+Pj4gaW5kZXggMWE3MjI3NTk0
YmYwLi44YTIwNDc1Y2U3N2EgMTAwNjQ0DQo+Pj4gLS0tIGEvZHJpdmVycy9tdGQvc3BpLW5vci9t
aWNyb24tc3QuYw0KPj4+ICsrKyBiL2RyaXZlcnMvbXRkL3NwaS1ub3IvbWljcm9uLXN0LmMNCj4+
DQo+PiB5b3UgZm9yZ290IHRvIHJlbmFtZSB0aGUgbWFjcm9zLCBhcyB5b3UgZGlkIGZvciB4aWxp
bnguDQo+IA0KPiBTaWdoLiBBY3R1YWxseSwgSSBkaWRuJ3QgcmVuYW1lIHRoZSBtYWNyb3MgYXQg
YWxsIChleGNlcHQgZm9yIHhpbGlueCwNCj4gYnV0IHRoYXQgd2FzIGFscmVhZHkgd2F5IGJlZm9y
ZSB0aGUgbmFtaW5nIGRpc2N1c3Npb24pLiBJIGNvdWxkbid0DQo+IGNvbWUgdXAgd2l0aCBhIGdv
b2QgbmFtZSwgc28gSSBqdXN0IGxlZnQgaXQgYXMgdGhleSB3ZXJlLg0KPiANCj4gVEJILCB3aGF0
IHdhcyBqdXN0IGEgY2xlYW4tdXAgZm9yIHRoZSByZWFkeSBmdW5jdGlvbiB0dXJuZWQNCj4gaW50
byBhIGdpZ2FudGljIHBhdGNoIHNlcmllcyBhbmQgaXQgaXMgdmVyeSB0aW1lIGNvbnN1bWluZw0K
PiAoYW5kIGZydXN0cmF0aW5nKSB0byByZXNwaW4gaXQganVzdCBmb3IgcmVuYW1pbmcuIFdlIHNo
b3VsZG4ndA0KPiBhaW0gYXQgcGVyZmVjdGlvbiBmb3IgcGF0Y2hlcy4gTWlub3IgZGV0YWlscyBj
YW4gYWx3YXlzIGJlDQo+IGZpeGVkIGxhdGVyLg0KPiANCg0KT2suIEknbGwgcXVldWUgdGhlIHBh
dGNoIHNldCBhbmQgZml4IHRoZW0gYWxsIGluIGEgc2luZ2xlIHBhdGNoLg0KDQo=
