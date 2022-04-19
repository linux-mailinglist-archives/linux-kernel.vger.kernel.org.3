Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D3B506CDF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 14:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350503AbiDSM7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 08:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350475AbiDSM7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 08:59:15 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673B52B198
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 05:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1650372990; x=1681908990;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=BH/w9KppB9Uzon19W5CIrt/ODjH+Gvv1bu4s0gBKYsI=;
  b=itIvgEFGXr2fsvX2bd9Pqd64KaXw7gbWD5ZMrVcc042b04ALW4QFfHoG
   asM35a5b4+UO7DnroHM2lcjcWEo0enVP0Qn5xtKwK3WpHmrb8uruivOVH
   MgAtRvxBTZNTDh2MIDJSoeC7D+VwMWKTcpLIU0acqByvZi5NfkbYRSOzM
   E2H4UALHkQCA4Mf8m2rdmOpjPL42Es3L70pDBKQIgDHgMo3B4ZPZ2z8Ic
   bMKSzxSjRaaqcU+dKNx6ewFbc2JsKz+SUegQrUZITdCls8DQSJp2PeEUs
   uazk0fd8ax6Smj/LbUC0pv1joBT/GCm0B458dytcwXu1fJoZeBDqWDKYQ
   w==;
X-IronPort-AV: E=Sophos;i="5.90,272,1643698800"; 
   d="scan'208";a="155994397"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Apr 2022 05:56:29 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 19 Apr 2022 05:56:28 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Tue, 19 Apr 2022 05:56:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BcZOB77TjfEUrjxrZJL7aoYahCYjfHVYngK2gENAAPz2QthD36zl9dsgPyqN6gxkDuMTopHttUw3Mgn5hIK3X1xU6UrmPk23M9E0cjSJpkHFFjdN25aiA+K1FgANX7zvqEI1ny80plz2gpDM8HvnZVYiui6I5iKHJ2JOe9DAsqaOuK2C7wVVN3IPW0WNn+5F7g0ekPgbwRxgnwOwLVz+MLB6buuQevUwifzP9anWraVrZkCUbqSmHwABGF+rcghtuKtuCGQsCRefb/GqSqHCaIyfsvf1jWlQFunMUbrWOJKDDUgVzHDq4fcA4aft0ahQI9nazCWJl1iBNKgGu8Bz3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BH/w9KppB9Uzon19W5CIrt/ODjH+Gvv1bu4s0gBKYsI=;
 b=Z5G1tKZyY/5NnDCn2Y+8stwbG1sytwl3wi5aZH3DRchZzE01Jf40K6/e+s1eQIoraKHAjmhlNkuHX8bOOXW6b19KrG12ZjS0V5OaS0uOXBzUK76dXCjzaxJpUFaz9SYN47qIHCRNoxa/LPUZvIRGcG1uuorZua3umehSQDOmCJ42c8/63V84e+/tMKMeQRUecNllr4QA0wWnkVl539me5XFMtLBdKXyh6jhF4ZOX7hoNPCsWaGr1a5/iwCOzNN7tBcCN5ifOI3TQFCIb8Ij5yZ8RHRAFoidGQQXZRQQI3ErinohU9qNfn+731P4aXFOhQ1sSp+Qg1+QIHvu0/vJebg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BH/w9KppB9Uzon19W5CIrt/ODjH+Gvv1bu4s0gBKYsI=;
 b=ZhRPK05eaCpbyFBV61aSXegFMi4MIZ7S8IWNWLbzKQqQnsb6XTtvkrkRfZ3eYJPIJWLih9oefIaHATaaGRD4Pj8zjcssDLV+X+NbuwL6MA6MyFEmasIp/aeHo1TLe7+2SIgB7mxiPBhBATrGRt60er2t8pfXCH5G22K1Na0m51s=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by DM5PR11MB1932.namprd11.prod.outlook.com (2603:10b6:3:114::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Tue, 19 Apr
 2022 12:56:24 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::3414:43b2:d8a:bc00]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::3414:43b2:d8a:bc00%7]) with mapi id 15.20.5186.013; Tue, 19 Apr 2022
 12:56:24 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>, <p.yadav@ti.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <Nicolas.Ferre@microchip.com>, <Takahiro.Kuwano@infineon.com>
Subject: Re: [PATCH v3 6/9] mtd: spi-nor: core: Add helpers to read/write any
 register
Thread-Topic: [PATCH v3 6/9] mtd: spi-nor: core: Add helpers to read/write any
 register
Thread-Index: AQHYU+YijgcwOSWAuEOiQaxrAfyzHw==
Date:   Tue, 19 Apr 2022 12:56:24 +0000
Message-ID: <89083a31-b862-de50-fdca-d427fb908a08@microchip.com>
References: <20220411091033.98754-1-tudor.ambarus@microchip.com>
 <20220411091033.98754-7-tudor.ambarus@microchip.com>
 <0e4ec58c21490dcd9cf82ab89bd8c34c@walle.cc>
 <e21b0d76bf778f78f432ba27a673222d@walle.cc>
 <f318dbd9-d4bf-301a-b5c9-556d04d5bfe6@microchip.com>
 <20220419123245.zu4hypebz77ckygn@ti.com>
 <996f36b1303d191e472f56393aa6398e@walle.cc>
In-Reply-To: <996f36b1303d191e472f56393aa6398e@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d049d4fe-4592-4c71-b325-08da22040268
x-ms-traffictypediagnostic: DM5PR11MB1932:EE_
x-microsoft-antispam-prvs: <DM5PR11MB19329EC71FB5D5A5FA5A031DF0F29@DM5PR11MB1932.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yO0/cCtbrx0jbMZyDKj6WIBqSN8yVfDsqjtWtnjZfX4r/xgTQLfqJyrCNEcfsZSupnF+O+ixracgVUEawjIdvs42PrNOM92lel5xsDSUE20ANnIW4Fs/+iI+S0+Ie8MVNqb9YwrNogL1U0JMVQRpuwcdYvWDZgXSEd0EVlIAJxjz3fKTmGVz1E6IGCWaT34O/CwjDjApq3eyn/f576kaIRADARugT/1A2U9ahu0XWVWcrIUj655biC9zkFNgLNo44YDWAQ3yrnO+suWOfKlnM+yhOUn1HHYLBFHVOkDelXkVn1CF/5eUf/UVyxRJcVSYdbmgzr2eHx95KfyPwseBEHA0J4zCy1wClbMco0hRyDoSZcN89rCvEvWpneg9TUiQ55UX5gHMIIVk6K8fT5a191iUCYtZGuCSmfMZKEJIXzA8kna6wGxe4hBKjDbY7YTldN7aLNwqIMefjhevjU8vq406Ze0ktOX2vu5XuDBoEAhOExv+8XgcZd4oJwPxFWxnn9xNOXMT1iEiu+Gmax0wdND+wz6GTh/ds9z6PlVP9wFWgFtLGm3eJRKK0vg2GUZZTGRhc8d0Qt8qtYz71QAG6sSjBnY36q6PiOU11dymCtgVYg/1fjUkxbqi/W/ad4RDNYFFpYwP5/nT8hJ5GZa3lJJWyHsB5aAC311tfZOuUPPvFKJNWfnUvVprtZ4N2OLMcuGOw4D7YmVcL7xnxePRJwcLzaBCd7tW4p1ddi78iCv/YSIzbHatJ232LSjcEjbg1fVUcaXFvIAcc9QAw4ebSg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(31696002)(508600001)(110136005)(86362001)(5660300002)(2616005)(4326008)(8676002)(38100700002)(64756008)(66446008)(8936002)(71200400001)(91956017)(66556008)(76116006)(66476007)(66946007)(6486002)(54906003)(36756003)(38070700005)(122000001)(6512007)(2906002)(53546011)(26005)(6506007)(186003)(31686004)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T05Lbzl6V0k1RSsrR2NHY3pJQjNVQ1pvcG5EQUtJYkF0U1lwZ0g2Mldzb1Jw?=
 =?utf-8?B?anhteFlVd3lkK2tmWTNORVhDQ1FEQnFWcTJvaWxRdU1iSEd5UU8zNmVWSS9u?=
 =?utf-8?B?L0JMcTllRXBZdzVaVHcyckt6cXFQSnZMalc4RU1xeU1RTVRyRGxEVlZSM2ZO?=
 =?utf-8?B?NGtKWkVxbTVwbmxhSG81Umo0ZUF0VStIZDdEMEZXQXhST0N2QXlobFFJTFhu?=
 =?utf-8?B?TDhCOWJKbVBUQzBzaUlCUU9jbUhVTWwrT205UWJKQ2Q5b2RkcmxsNHlKZHht?=
 =?utf-8?B?U2o0SDB2aWFIMXlmNDl0V2Uya2tNUE5NRWlQbkV3bU9CZnFOYUU1S3U2OFlX?=
 =?utf-8?B?d0dEa2FmZlI1N3hMNDFkQjNYSFcrTHV3SVVVNDA0NkkvTGFmOUlZVURUbzdV?=
 =?utf-8?B?djlqSkZyZldPaFgrcWpYMGw5UFhibHp3Ym1XdFJWR1JZdTVqUVlnY2YvZ0tj?=
 =?utf-8?B?d3BuZ0kvcCs2aWtuVXMvNVJuL1B3MTR1ZVFvbFVLODlyTmFCd1dVVElBWGZK?=
 =?utf-8?B?T2FOKytIa1pndkxoVFRwQ3pQT2xlMkhpc0lVRnoySW1NK29DTk0xanp1WkVO?=
 =?utf-8?B?VjZ2YUVackkyYWF1UTZFamZhd1hxQUIvWFBHY0ZaZjU4M01VcVl1L3ZYcWdC?=
 =?utf-8?B?UnAzQzdYRUQyQkRhd2NlOXE1bUhsR0hsK2xJTTcxVGowdEJSK1VrK2NxOTRv?=
 =?utf-8?B?RkIvc1lQOTR5ZWpIMUJ0VGhwOEFjNTB6ZFFNUi9Zbjk4TjVDNE9HWlZqWElR?=
 =?utf-8?B?dDU5clAwLy9vVW9UR0pEek1FWUdydjRZeWdYcjhkcUFjYS95R2pYeng3Zjhu?=
 =?utf-8?B?ZEdHNEtNdnlJYWRIdDRkeStLeVR5a3luUHJYbjFDd2tPYWV6ZU03QVJDWGlF?=
 =?utf-8?B?Ylc3Mm1CWHlSa2JicFo0Y3g1VERha085MlVES3k5WmxPdmFPN2NHR3hWUFpE?=
 =?utf-8?B?TVNXZVh1bWh6SnkxSG13b2t4QlpwR2Zqa05VR3VtSk9OTVc5RmxTMWNDVnJr?=
 =?utf-8?B?MU9rOTVHMkJqVnpzc01JQko1ZVRYU1JXWGpRODdTTGZWeHJrUG9BU3kwcDZu?=
 =?utf-8?B?WVkwTmRaYlJYR2tyK0d3RmkxVVJUb2l4dFcxKzRXRzRRaElWeTdnd2RkMUZL?=
 =?utf-8?B?ZTBxWlk5ZEhrbk1xcUFiL2hlZERwU0llZGJyZGd5b29ZTkt5ZHhiUmRpTWFs?=
 =?utf-8?B?VzdxU3NSRDIyc0hMaFFtV3VtWVFoSFU5MyswVGR5Ny9KY1BJc1JKZGpabTJy?=
 =?utf-8?B?Z3RZMjc4OC9KQUN5aWJpY3FDNjRVaXcvOExkT2dYa05NQ09zY1hpU2V4V1V2?=
 =?utf-8?B?UjJudXM0cGU4V3lOQWN6UzdPdmpYUzhza1QwTGhoaTVYMVByR1NabU4rMXQ1?=
 =?utf-8?B?bFFScDUzd2VESjBLaUFoSC9UUXdIeWUwaFAra0dwL2o2MEN2U0tYdWU5ejVD?=
 =?utf-8?B?bGdLekNwaHM2MmhQNU83WHZ3eDQ4dFdzRzFIbkVXK0daV3g4L0JNMVFoT1ZN?=
 =?utf-8?B?WllKRVY4aG9QU3NTVFYwdEN1NnRQUFZCZll5WmJYeHVMV3M4b3RvOHhjSC9I?=
 =?utf-8?B?QmM4NlpvT2JoZUR1RkVXK1AwaFMrR3djZzFYSWoyV1VkWm1icXhHa3VWODJv?=
 =?utf-8?B?UFEwOWtxWE56SEpkSUhrMzA1L0dKUGhoYWlueThPSHM3WjdxUEY0TWVnRjRi?=
 =?utf-8?B?L2hKMnc4RGtld3IrODFNOXBsdGRKeUNLYUExOUEyTmhRM1RCVWlwRHJoTkxy?=
 =?utf-8?B?SXc0dEZnWVAyTC9kRENkKzhyOUF1MkJkU3BUZnV0ejlhcE9oYlZMUnQzNEc4?=
 =?utf-8?B?cWdWTmxTQTFOU2h2SEc4ZkdkRjNUSjdvQ2x4cWFmZ3NoU1N3NUV4UWljZ1Jm?=
 =?utf-8?B?azBmMmYrWHZxWDBPWHFFM0lpTFg2bzFVdVIreFhVMUJkZkc0RXZlLzdDc1d2?=
 =?utf-8?B?RzQ1clV2Zk5zZHRJU0MvUFgyZXVsb0Q3UFNuVjJyVXZxdXczTjNjQTM4TGtX?=
 =?utf-8?B?NXF1aFRwOUlKbzJzeHN6ZFZabC9PaXI4NzdJcTNaZ0twSW9MLzlIVWlERk9H?=
 =?utf-8?B?WC9JQm1IeWdaUFpzdWJlRWtIZFRlNEtMZ1FydFpUMUdSVlhkVlhrNERMTG1u?=
 =?utf-8?B?THBSRzRWMEVUU1FEc1NoZTZEemVoZFhXcS9yM21aRzhDYVNWVDM0c0RueFV1?=
 =?utf-8?B?Ulh5SGlMU3FvUnFFT0VsV0RUeDlaSFd2RDFKNldlNGo3YUVOdE1YOWl1aXpn?=
 =?utf-8?B?Z054SFRqcFEwZ01MT2FVNzhOWHdRclNrd1pEYzRNa1BrUWpKZlRSSG5rYnJi?=
 =?utf-8?B?Q2R5MkE2djVFZXhSU0ZhaXd3NmlHUFp1eXVjNzgzV2RiUjJuQ1JickZtcHJ3?=
 =?utf-8?Q?7WM0BQkZVqxlRmEM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <53903D1109FB0540841E0B036BF4D787@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d049d4fe-4592-4c71-b325-08da22040268
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2022 12:56:24.1507
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: msQ5OSvRjZEcDpNGr3dmlxLBbw627H21Goi+b7J7/ka9hNoVHPXCqYaT1aghIEP8eyJ3xb94ldjvpoJkeSkSzZYOtqKmHpB/vRLdPPzF3tU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1932
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC8xOS8yMiAxNTo0NiwgTWljaGFlbCBXYWxsZSB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6
IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0
aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBBbSAyMDIyLTA0LTE5IDE0OjMyLCBzY2hyaWViIFBy
YXR5dXNoIFlhZGF2Og0KPj4gT24gMTkvMDQvMjIgMTI6MDhQTSwgVHVkb3IuQW1iYXJ1c0BtaWNy
b2NoaXAuY29tIHdyb3RlOg0KPj4+IE9uIDQvMTkvMjIgMTQ6NDYsIE1pY2hhZWwgV2FsbGUgd3Jv
dGU6DQo+Pj4gPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0
YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4+PiA+DQo+Pj4g
PiBBbSAyMDIyLTA0LTE5IDEzOjE5LCBzY2hyaWViIE1pY2hhZWwgV2FsbGU6DQo+Pj4gPj4gQW0g
MjAyMi0wNC0xMSAxMToxMCwgc2NocmllYiBUdWRvciBBbWJhcnVzOg0KPj4+ID4+PiBUaGVyZSBh
cmUgbWFudWZhY3R1cmVycyB0aGF0IHVzZSByZWdpc3RlcnMgaW5kZXhlZCBieSBhZGRyZXNzLiBT
b21lIG9mDQo+Pj4gPj4+IHRoZW0gc3VwcG9ydCAicmVhZC93cml0ZSBhbnkgcmVnaXN0ZXIiIG9w
Y29kZXMuIFByb3ZpZGUgY29yZSBtZXRob2RzDQo+Pj4gPj4+IHRoYXQNCj4+PiA+Pj4gY2FuIGJl
IHVzZWQgYnkgYWxsIG1hbnVmYWN0dXJlcnMuIFNQSSBOT1IgY29udHJvbGxlciBvcHMgYXJlDQo+
Pj4gPj4+IGludGVudGlvbmFsbHkNCj4+PiA+Pj4gbm90IHN1cHBvcnRlZCBhcyB3ZSBpbnRlbmQg
dG8gbW92ZSBhbGwgdGhlIFNQSSBOT1IgY29udHJvbGxlciBkcml2ZXJzDQo+Pj4gPj4+IHVuZGVy
IHRoZSBTUEkgc3Vic3lzdGVtLg0KPj4+ID4+Pg0KPj4+ID4+PiBTaWduZWQtb2ZmLWJ5OiBUdWRv
ciBBbWJhcnVzIDx0dWRvci5hbWJhcnVzQG1pY3JvY2hpcC5jb20+DQo+Pj4gPj4+IFRlc3RlZC1i
eTogVGFrYWhpcm8gS3V3YW5vIDxUYWthaGlyby5LdXdhbm9AaW5maW5lb24uY29tPg0KPj4+ID4+
PiBSZXZpZXdlZC1ieTogUHJhdHl1c2ggWWFkYXYgPHAueWFkYXZAdGkuY29tPg0KPj4+ID4+DQo+
Pj4gPj4gSSBzdGlsbCBkb24ndCBsaWtlIGl0IGJlY2F1c2UgdGhlIGZ1bmN0aW9uIGRvZXNuJ3Qg
ZG8NCj4+PiA+PiBhbnl0aGluZyB3aGF0IHRoZSBmdW5jdGlvbiBuYW1lIG1pZ2h0IHN1Z2dlc3Qu
IFRoZSByZWFkDQo+Pj4gPj4ganVzdCBleGVjdXRlcyBhbiBvcCwgdGhlIHdyaXRlIGV4ZWN1dGVz
IGFuIG9wIHdpdGggYQ0KPj4+ID4+IHdyaXRlIGVuYWJsZSBiZWZvcmUuIEFsbCB0aGUgYmVoYXZp
b3IgaXMgZGV0ZXJtaW5lZCBieSB0aGUNCj4+PiA+PiAnb3AnIGFyZ3VtZW50Lg0KPj4+ID4+DQo+
Pj4gPj4gQW55d2F5LA0KPj4+ID4+IFJldmlld2VkLWJ5OiBNaWNoYWVsIFdhbGxlIDxtaWNoYWVs
QHdhbGxlLmNjPg0KPj4+ID4+DQo+Pj4gPj4+IC0tLQ0KPj4+ID4+PiB2Mzogbm8gY2hhbmdlcw0K
Pj4+ID4+Pg0KPj4+ID4+PsKgIGRyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5jIHwgNDENCj4+PiA+
Pj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4+PiA+Pj7CoCBkcml2
ZXJzL210ZC9zcGktbm9yL2NvcmUuaCB8wqAgNCArKysrDQo+Pj4gPj4+wqAgMiBmaWxlcyBjaGFu
Z2VkLCA0NSBpbnNlcnRpb25zKCspDQo+Pj4gPj4+DQo+Pj4gPj4+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL210ZC9zcGktbm9yL2NvcmUuYyBiL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5jDQo+Pj4g
Pj4+IGluZGV4IDYxNjVkYzdiZmQxNy4uNDI3OTQzMjhkM2I2IDEwMDY0NA0KPj4+ID4+PiAtLS0g
YS9kcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuYw0KPj4+ID4+PiArKysgYi9kcml2ZXJzL210ZC9z
cGktbm9yL2NvcmUuYw0KPj4+ID4+PiBAQCAtMzA3LDYgKzMwNyw0NyBAQCBzc2l6ZV90IHNwaV9u
b3Jfd3JpdGVfZGF0YShzdHJ1Y3Qgc3BpX25vciAqbm9yLA0KPj4+ID4+PiBsb2ZmX3QgdG8sIHNp
emVfdCBsZW4sDQo+Pj4gPj4+wqDCoMKgwqDCoCByZXR1cm4gbm9yLT5jb250cm9sbGVyX29wcy0+
d3JpdGUobm9yLCB0bywgbGVuLCBidWYpOw0KPj4+ID4+PsKgIH0NCj4+PiA+Pj4NCj4+PiA+Pj4g
Ky8qKg0KPj4+ID4+PiArICogc3BpX25vcl9yZWFkX3JlZygpIC0gcmVhZCByZWdpc3RlciB0byBm
bGFzaCBtZW1vcnkNCj4+PiA+Pj4gKyAqIEBub3I6wqDCoMKgwqDCoMKgwqAgcG9pbnRlciB0byAn
c3RydWN0IHNwaV9ub3InLg0KPj4+ID4+PiArICogQG9wOsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBTUEkgbWVtb3J5IG9wZXJhdGlvbi4gb3AtPmRhdGEuYnVmIG11c3QgYmUgRE1BLWFibGUuDQo+
Pj4gPj4+ICsgKiBAcHJvdG86wqAgU1BJIHByb3RvY29sIHRvIHVzZSBmb3IgdGhlIHJlZ2lzdGVy
IG9wZXJhdGlvbi4NCj4+PiA+Pj4gKyAqDQo+Pj4gPj4+ICsgKiBSZXR1cm46IHplcm8gb24gc3Vj
Y2VzcywgLWVycm5vIG90aGVyd2lzZQ0KPj4+ID4+PiArICovDQo+Pj4gPj4+ICtpbnQgc3BpX25v
cl9yZWFkX3JlZyhzdHJ1Y3Qgc3BpX25vciAqbm9yLCBzdHJ1Y3Qgc3BpX21lbV9vcCAqb3AsDQo+
Pj4gPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBlbnVtIHNwaV9ub3JfcHJv
dG9jb2wgcHJvdG8pDQo+Pj4gPj4+ICt7DQo+Pj4gPj4+ICvCoMKgwqAgaWYgKCFub3ItPnNwaW1l
bSkNCj4+PiA+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FT1BOT1RTVVBQOw0K
Pj4+ID4+PiArDQo+Pj4gPj4+ICvCoMKgwqAgc3BpX25vcl9zcGltZW1fc2V0dXBfb3Aobm9yLCBv
cCwgcHJvdG8pOw0KPj4+ID4+PiArwqDCoMKgIHJldHVybiBzcGlfbm9yX3NwaW1lbV9leGVjX29w
KG5vciwgb3ApOw0KPj4+ID4+PiArfQ0KPj4+ID4+PiArDQo+Pj4gPj4+ICsvKioNCj4+PiA+Pj4g
KyAqIHNwaV9ub3Jfd3JpdGVfcmVnKCkgLSB3cml0ZSByZWdpc3RlciB0byBmbGFzaCBtZW1vcnkN
Cj4+PiA+Pj4gKyAqIEBub3I6wqDCoMKgwqDCoMKgwqAgcG9pbnRlciB0byAnc3RydWN0IHNwaV9u
b3InDQo+Pj4gPj4+ICsgKiBAb3A6wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFNQSSBtZW1vcnkg
b3BlcmF0aW9uLiBvcC0+ZGF0YS5idWYgbXVzdCBiZSBETUEtYWJsZS4NCj4+PiA+Pj4gKyAqIEBw
cm90bzrCoCBTUEkgcHJvdG9jb2wgdG8gdXNlIGZvciB0aGUgcmVnaXN0ZXIgb3BlcmF0aW9uLg0K
Pj4+ID4+PiArICoNCj4+PiA+Pj4gKyAqIFJldHVybjogemVybyBvbiBzdWNjZXNzLCAtZXJybm8g
b3RoZXJ3aXNlDQo+Pj4gPj4+ICsgKi8NCj4+PiA+Pj4gK2ludCBzcGlfbm9yX3dyaXRlX3JlZyhz
dHJ1Y3Qgc3BpX25vciAqbm9yLCBzdHJ1Y3Qgc3BpX21lbV9vcCAqb3AsDQo+Pj4gPj4+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVudW0gc3BpX25vcl9wcm90b2NvbCBwcm90
bykNCj4+PiA+Pj4gK3sNCj4+PiA+Pj4gK8KgwqDCoCBpbnQgcmV0Ow0KPj4+ID4+PiArDQo+Pj4g
Pj4+ICvCoMKgwqAgaWYgKCFub3ItPnNwaW1lbSkNCj4+PiA+Pj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgcmV0dXJuIC1FT1BOT1RTVVBQOw0KPj4+ID4+PiArDQo+Pj4gPj4+ICvCoMKgwqAgcmV0
ID0gc3BpX25vcl93cml0ZV9lbmFibGUobm9yKTsNCj4+PiA+Pj4gK8KgwqDCoCBpZiAocmV0KQ0K
Pj4+ID4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gcmV0Ow0KPj4+ID4+PiArwqDC
oMKgIHNwaV9ub3Jfc3BpbWVtX3NldHVwX29wKG5vciwgb3AsIHByb3RvKTsNCj4+PiA+Pj4gK8Kg
wqDCoCByZXR1cm4gc3BpX25vcl9zcGltZW1fZXhlY19vcChub3IsIG9wKTsNCj4+PiA+DQo+Pj4g
PiBBZnRlciBzZWVpbmcgeW91ciBuZXh0IHR3byBwYXRjaGVzLiBTaG91bGRuJ3QgdGhlDQo+Pj4g
PiBzcGlfbm9yX3dhaXRfdW50aWxfcmVhZHkoKSBjYWxsIGJlIGhlcmUgdG9vPw0KPj4+ID4NCj4+
Pg0KPj4+IEkgdGhvdWdodCBvZiB0aGlzIHRvbywgYnV0IHNlZW1zIHRoYXQgZm9yIGEgcmVhc29u
IHRoYXQgSSBkb24ndA0KPj4+IHJlbWVtYmVyLCB3ZSBkb24ndCBjYWxsIGZvciBzcGlfbm9yX3dh
aXRfdW50aWxfcmVhZHkgYWZ0ZXIgd2UNCj4+PiB3cml0ZSB0aGUgb2N0YWwgRFRSIGJpdC4gUHJh
dHl1c2gsIGRvIHlvdSByZW1lbWJlciB3aHk/DQo+Pg0KPj4gV2UgYXJlIG5vdCBzdXJlIHRoZSBw
cm90b2NvbCBjaGFuZ2VkIGNvcnJlY3RseSBzbyB3ZSBjYW4ndCByZWx5IG9uDQo+PiBzcGlfbm9y
X3dhaXRfdW50aWxfcmVhZHkoKS4gV2UgcmVhZCB0aGUgSUQgaW5zdGVhZCB0byBiZSBzdXJlLg0K
PiANCj4gU28gYmVzaWRlcyB0aGUgZmFjdCB0aGF0IHRoZSB3cml0ZV9yZWcgb25seSB3b3JrcyB3
aXRoIHRoZSAnY29ycmVjdCcNCj4gb3AgcGFyYW1ldGVyLCBpdCBpcyBhbHNvIHRhaWxvcmVkIHRv
IHRoZSBzcGVjaWFsIHVzZSBjYXNlLiBGb3IgcmVhbA0KPiB3cml0ZV9yZWcoKSwgdGhlIHVzZXIg
d291bGQgYWN0dWFsbHkgaGFzIHRvIHBvbGwgdGhlIHN0YXR1cyBiaXQNCj4gYWZ0ZXJ3YXJkcz8g
OigNCj4gDQpEb24ndCBiZSBzYWQgOkQuIEFyZSB0aGUgb2N0YWwgRFRSIG1ldGhvZHMgYW4gZXhj
ZXB0aW9uPw0KSWYgeWVzLCBsZXQncyBhZGQgdGhlIGNhbGwgdG8gc3BpX25vcl93YWl0X3VudGls
X3JlYWR5KCkgaW4gdGhlDQpyZWFkL3dyaXRlX2FueV9yZWcoKSBtZXRob2RzLCBhbmQgbGV0IHRo
ZSBvY3RhbCBtZXRob2RzIGhhbmRsZQ0KdGhlIHNwZWNpZmljIHdyaXRlIHRoZW1zZWx2ZXMsIHdp
dGhvdXQgY2FsbGluZyBmb3IgcmVhZHkoKQ0KDQpDaGVlcnMsDQp0YQ0K
