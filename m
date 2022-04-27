Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21BB051121B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 09:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358648AbiD0HOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 03:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350489AbiD0HOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 03:14:43 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D953AA55
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 00:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1651043493; x=1682579493;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=KmvKo+F4mMPzonJJHO2HRNnJTTjFrOLIXaiW32/xVDw=;
  b=L3298Z+xrKDhW6vZbVgaZk61bSZB2QiFFZKtH5L3pY0Z7rwElT7QIA0y
   z4loUt5bmEZDZnWC4Ry9pI+kum1Mde5IZ1eg+Q6TLW1gL78GtRuQGPswr
   w7A0bSCpFkG4MdBQyt9tZsRK1NCq7LiE40iheIfSN2itF6OT9Xucc4JaG
   PExueL4SSP4FKmJx8fogg1JDEhPjvEFPTcfe47qovkm/O72xamLU1p5By
   aGY+OmTTL1j5hbehWQySM8kusYec/szQvnjCLelX/f88Gd9t/Oy+zALQq
   XX/6GdY9N6aiY0ARg00hjjwbBQ9yqnpH13lpVeXoF5SGmwMTwiH2pzHs7
   A==;
X-IronPort-AV: E=Sophos;i="5.90,292,1643698800"; 
   d="scan'208";a="156935531"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Apr 2022 00:11:32 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 27 Apr 2022 00:11:32 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Wed, 27 Apr 2022 00:11:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gYdmH8syslnU2goojhykMGOsD/bt6LBPTfShi3Xj2CLN5ypEHSXwrWJGUcjIpAgnZCAjQzVmoKwTexhFIvwF/jdL0w5LJ5a/XPPNEr05mD/FqUOy/i5EF78HxAtLEHJsm6kEQv/skPcYJfCyFvSPBM7gk6FskqEy0Ks4mm2OYuMOu95YGiDkPBzPAyVUtsI5x/Ctl36UT81h1M1wYZtHnIMd4RuLQi4Mc8Cs1GpWaJpiC22u0fuuPdSPQ69S+j+AoXo613WmvbLrXSc8e6eRELybFCnGe9phLHai3Gp2X7+EKhtQCj/g0+5C2p/Sdvrt0CX4AO5O3BAk5lP/5rbpfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KmvKo+F4mMPzonJJHO2HRNnJTTjFrOLIXaiW32/xVDw=;
 b=GZiYwljMRRzVfL3qcGp7sRFIG6wZLpRAIbM0XdwjdsRZPS4DbF35JJmgfkbbnxLi2Ksctt79usq/AiXSHv87/VMMbW1IImE11rzRUAIPImWbMJzB8E91gs5ktaQygCfuSLanBmxEfcZKk+62Kh5fqron7i+HajljdpGwi0xxI+LkmTCQjhjeH4TpNn1ovlRg79Xe2I2pZshxGbnfIDfLj/UO8bTtpieKjrTjz40fn7mGSJ6EI4qd59N4ZG2WOJIEFK3nfWn1zS2FfKl2AjuR529nUQtHmWr8xx0a/2wvoH29DYqoL5xIxUN+YZTqjaYtiRT6UaXaz55Oi/1+GR8Gsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KmvKo+F4mMPzonJJHO2HRNnJTTjFrOLIXaiW32/xVDw=;
 b=iUCctvBq2H/MPhm/WAN8rjuTQRIjKYj4YGfAd1zhnOnxns/kIwSd3m8V0E52/nOXYvs0gFdxXMPn490i8rbVUUafaRdJqmxLFjet9iyNLHNxV4zwDAKH/mr893C20ub5WBSLo18xYrWq/3r+9BvvUXsv3WnpWu6pwsxuPm/OerA=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by CY4PR11MB2056.namprd11.prod.outlook.com (2603:10b6:903:30::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Wed, 27 Apr
 2022 07:11:18 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::2447:4025:79e6:7c08]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::2447:4025:79e6:7c08%5]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 07:11:18 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <p.yadav@ti.com>, <chentsung@chromium.org>
CC:     <michael@walle.cc>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>
Subject: Re: [RESEND PATCH] mtd: spi-nor: core: Check written SR value in
 spi_nor_write_16bit_sr_and_check()
Thread-Topic: [RESEND PATCH] mtd: spi-nor: core: Check written SR value in
 spi_nor_write_16bit_sr_and_check()
Thread-Index: AQHYWgX8ewfNtQDrSE2YBtaW8mA4Jg==
Date:   Wed, 27 Apr 2022 07:11:18 +0000
Message-ID: <0e02112a-317c-e95b-e0d3-7ed2c74c3509@microchip.com>
References: <20220126073227.3401275-1-chentsung@chromium.org>
 <20220131171929.uk3z5sr453c3eefp@ti.com>
In-Reply-To: <20220131171929.uk3z5sr453c3eefp@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1f4db88e-4ecf-4298-3883-08da281d2007
x-ms-traffictypediagnostic: CY4PR11MB2056:EE_
x-microsoft-antispam-prvs: <CY4PR11MB2056C61453196F3191469BD1F0FA9@CY4PR11MB2056.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: av08BLUuOFEk6HFx8YiZ79bQqp0giuJ7Vvl++O1LAjymHCRoGsAkXqjtgRvMFR3bv6tUbDkGGf/9HHVJl4PaYbBD1CgirsX7TiY6iFiCrFSnm5P3lLBPhlNvsXADfzrhPJb5DOlwtZfDgmYtuxwcl0sNVaBmTzQmKOdeHeIjnwg8/ucbf0SnWjpOOELfVMUd8FbpmK3zehFUWXgu5eFcPcftqfHBHGiGZq0v7nGUcQ25Dc1qJfzHsV2Bt+kK0hMnaoDJhRos3/cPvamnh/RBshmpVR7/rjleYXpCLxp7i2NMoecGKtZqhTZDSkJZ2TStR/XJsP0x49wF78eVAEQ+4fAbbJM7GJrmnDIjPmKPvnfWCq066eQTTmxzhcX9OvYfwm0dClD14XqwEGwDTUP+ZPRSDm4bNkLddDfQGnQYORCoGVjW9s0zTGXWbdobM+alDSihrYDN18bFdLabDNy4fB8mlGfXt5jfBYH3ya0iXhDjLUeVNtV3pZJJjUlEOIb9kSaMUkA96bhhptRux3CmU4N92MhoGnKzo90eFXlHypt8r7deGkvTnYIV+jfX/A5P9UJMNlXAe2aq/O6FQ4P4VhEjcKJ6pbokjXH6v0xbFauMd3g8N27GO7c/3ereRXpSPerRqkzjVKoeaKU/UAmiP7hIZF6GSyZukgXKt5ARTUN/SEIZUIMk9JkgEmXHdCHFrIEFPP6setz+OyS6j0RLrYFFGgPJZ5MIw3ZI7EXKn7iBaCPxvu2ierNHiBt9fmL5AVuybfnAuIQkXAGzPlM2jw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(66946007)(5660300002)(6512007)(91956017)(122000001)(8936002)(66446008)(66556008)(4326008)(76116006)(316002)(26005)(4744005)(38100700002)(86362001)(31696002)(38070700005)(2906002)(508600001)(6486002)(71200400001)(64756008)(8676002)(66476007)(83380400001)(186003)(53546011)(110136005)(6506007)(31686004)(36756003)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YzVwRjlyUytoYkZDZHpJazNtdExMdWdSNk04dUJjSkVPTjhseCtwcC9ESkh3?=
 =?utf-8?B?cjBkVUFIeEh2cUdYOFNadGpEZTVUWjBCK3VQcDViRnVKMGFubmJIOFpzcHds?=
 =?utf-8?B?M2NPNjlPNkw5dEh2ZjMyeTl0MFRQajQ1NG00RVBBeEZjV1g4VVp4VXN1eU5Y?=
 =?utf-8?B?RldNRzh3cWpKMGNCY2Zyclo0eWRnczJ5cHRjRkw4a2M1MGNSaVZBaFVIb0hR?=
 =?utf-8?B?MjlyUWo1eDB5b05UV0V0MlpSTzdqdWJybFI5bk1xNGw4N0NpUEQweWFjQm94?=
 =?utf-8?B?YU50UFBSaXZoSUNpdFNlMEVrV0ZEODI1Y1VTd05iQkdzZHJ3dmVvaitISWpp?=
 =?utf-8?B?YldET21MZnZQNDEzcGVlMngrdDZaSWxCbzhwczAwbUhhOFBEL0xEditwK0g0?=
 =?utf-8?B?czNiL2EwcmJ1Vnk5bzUzOFBWbTRRV1Q2Znc4S1E4ZU8vbm5JM1V3NmZBaCtT?=
 =?utf-8?B?WXpjbnBnWUpXRDYrMmJBak1TWGU3c2pGeENEQ0Y2YVVxMDRuZXFhLzFJTWZE?=
 =?utf-8?B?RjZza0R0VXcrOU0wUExtRWd6T1hNRWZuV3pRbXdRUVh5aVc1dkdQN1hRMURw?=
 =?utf-8?B?RHoyN3IxZGNhdFptd1NMNUxuMmY5WEZ3SFBqUkNYRlNiaE8yK3BGOG5vd0ph?=
 =?utf-8?B?NlpJTHd5bEVwa2VCQ1pRQmJLUHdrSXNxNWtTL0RwRGdiTGRKajVJTG9MRDMx?=
 =?utf-8?B?Uk1adFNJZ2lhSC9LYm52S3JTeGVxZlZFSUtqRThNWVk5VlFhNk52VjBkL0lL?=
 =?utf-8?B?T05rdEdJK2diRlBERXEwTGk2L3Bsa2F4NmdJdVUyU1lkTTBWdkNuUVMwM05p?=
 =?utf-8?B?RUZtcEtIQ0N4OUUvNmxncVM5bnlZb0Rya2VHVTlNQlM1VlpLaXBNL0dzYnNO?=
 =?utf-8?B?NWFZdmJHOS84eW4zd1pPYy9JVDlmeCtmRGx0ZmZWbG9jc2VxNmRJOXJyajM3?=
 =?utf-8?B?dldnNXZueDFCUXlUWm1BVTNRVlhLZVphSWx2VWdwanZVelJPQitKVFdDZkxu?=
 =?utf-8?B?c2hod3JCRGQrUXJIWnFlaXY0SGxWUm81RFhSN2d6QjJUSGo5OGRWTHpoZFRK?=
 =?utf-8?B?UE9jZGxXOWJTTmU3QnJncE5VTHg4UmhUZkNvWmpiVEVMS0tiL2ptNW8yYktj?=
 =?utf-8?B?NUV2L2hMQVJPaTRWVXFlWExUU3kyallwaDNuTWdkUmY4OUR3TDh6VkZWbnRy?=
 =?utf-8?B?S1duTVJab3haenkxajVVcXVXT1dNNUw1Q0ZKRUVQaTZZUzk5NHpmYWNmZ2N4?=
 =?utf-8?B?WFN3NkxXUnllM2FQUWdGdm5VUGlDbE1YSmFmcG4vWXplZGh3MXpsbEY1K3J2?=
 =?utf-8?B?alo3NVNpMnlqZG0zbC9pZFJVaE9rclVDUU5TTmQwRS9lRjRtQm1ZRjBMcDIw?=
 =?utf-8?B?SUtsWkZUWXBkTVpMMk5DMDVvbXd0MHRzV0lUcnpVOFU0cmxlNzIrTzRWeXJR?=
 =?utf-8?B?dFZkVW1vTHhZVXR2bU9UNzhzTTFOVDJpWGUvZC9hSmx5elpjNTZKYXcyb1JU?=
 =?utf-8?B?QjhGOWhteThqTmVBWkl5Z2RZWWJueTNES1VsTmduZGoyRXRUMEx4aFNTbG03?=
 =?utf-8?B?cVFnRXV6V1ZIbnRESUtFVTBDcWY5WEhMenZCaDVXNW0vNjZXRG04S3FSVEJH?=
 =?utf-8?B?cTJNdFZCSTVRbmo3aFQyVlI4TEJuOVlRQ2FUcFFKZU90ZitFcGVRRHBYQy9N?=
 =?utf-8?B?c29ORHFQZHcwTFpEUDR4b3FxaytkR3ZwRlg3R1pDb3JXYXdyTVBzd2ZLcFVy?=
 =?utf-8?B?Nms5bXV0MWNMRUhpbTJlZHBLTFB5eDU4Y3VscUFzWm9pZ1VCOGpVWFZVRm5k?=
 =?utf-8?B?aTFkVlliR3lFU0Nhb1ZpR005U0NQaWdFNWtUcUtEeXFJNElYZ1E4U1UwTm9K?=
 =?utf-8?B?cncweDdFTmc4eVF4T3dlemZRZDFNU0RheldkOXJreXNFOW9yMTV1VTE2amNQ?=
 =?utf-8?B?UWs5b3ZBTFNxVGlUSTdJaGlBM1VmelRobDN3eWxJZlEvTFBvbVNNaHM1OVFu?=
 =?utf-8?B?ZDZhaDhiVWlwTTVjTHdUV0wya0cwSWh2dXEvWUd6VVI5c3lsZVN4TlJyRElt?=
 =?utf-8?B?STNjL2hVS1NuaERlaXFXRXFHdXBrN3ROZE5pM251RytzVmI1NzVZUzVOMEUx?=
 =?utf-8?B?UkdzbmJXNGFPTkJtUEtvQXlMN0NWeWhQQXZKK2Y1M0hRbENXS05HVnNQdnE0?=
 =?utf-8?B?dW1aeERlMlpMUWlYRDJrQkNDWmtMMHFrM2dLYW9VWEhWUUFpc0lQaWNFVFZl?=
 =?utf-8?B?VWV2VWF3ZlpObThKK1JERWQrRmZwaVkvc1IxNVlDSU9jU3NlTlIybU5tbEIw?=
 =?utf-8?B?cXBpRFJZaUV0ZkwwbE9ZYkxFS0xScXBXOW1QOVU4V3R6TCtEQ2p3bWI3R1Bi?=
 =?utf-8?Q?zUjtIZuU6i/luKuw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <716906425AB4A04CAF7F9928260FA1B9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f4db88e-4ecf-4298-3883-08da281d2007
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2022 07:11:18.2227
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iqerdtLHbKhPsF2QBDcmHNmIlAPp4l9UhanVSWl4zA1Xs1EjAjPT9XbTPu/xOym/4YvDy0WlmS3gf8x07qe1qS/txCa1xGRfP4JCPez+j0M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB2056
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMS8zMS8yMiAxOToxOSwgUHJhdHl1c2ggWWFkYXYgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlM
OiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cg
dGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gMjYvMDEvMjIgMDM6MzJQTSwgQ2hlbi1Uc3Vu
ZyBIc2llaCB3cm90ZToNCj4+IFJlYWQgYmFjayBTdGF0dXMgUmVnaXN0ZXIgMSB0byBlbnN1cmUg
dGhhdCB0aGUgd3JpdHRlbiBieXRlIG1hdGNoIHRoZQ0KPj4gcmVjZWl2ZWQgdmFsdWUgYW5kIHJl
dHVybiAtRUlPIGlmIHJlYWQgYmFjayB0ZXN0IGZhaWxlZC4NCj4+DQo+PiBXaXRob3V0IHRoaXMg
cGF0Y2gsIHNwaV9ub3Jfd3JpdGVfMTZiaXRfc3JfYW5kX2NoZWNrKCkgb25seSBjaGVjayB0aGUN
Cj4+IHNlY29uZCBoYWxmIG9mIHRoZSAxNmJpdC4gSXQgY2F1c2VzIGVycm9ycyBsaWtlIHNwaV9u
b3Jfc3JfdW5sb2NrKCkNCj4+IHJldHVybiBzdWNjZXNzIGluY29ycmVjdGx5IHdoZW4gc3BpX25v
cl93cml0ZV8xNmJpdF9zcl9hbmRfY2hlY2soKQ0KPj4gZG9lc24ndCB3cml0ZSBTUiBzdWNjZXNz
ZnVsbHkuDQo+Pg0KPj4gRml4ZXM6IDM5ZDFlMzM0MGM3MyAoIm10ZDogc3BpLW5vcjogRml4IGNs
ZWFyaW5nIG9mIFFFIGJpdCBvbiBsb2NrKCkvdW5sb2NrKCkiKQ0KPj4gU2lnbmVkLW9mZi1ieTog
Q2hlbi1Uc3VuZyBIc2llaCA8Y2hlbnRzdW5nQGNocm9taXVtLm9yZz4NCj4gDQo+IEkgZG9uJ3Qg
a25vdyBtdWNoIGFib3V0IHRoaXMgYml0IG9mIGNvZGUgYnV0IHRoaXMgcGF0Y2ggbG9va3MgZmlu
ZSB0byBtZQ0KPiBmcm9tIHRoZSBzdXJmYWNlLiBXb3VsZCBiZSBuaWNlIHRvIGhlYXIgZnJvbSBU
dWRvciBhYm91dCB0aGlzIHRvbyBzaW5jZQ0KPiBoZSBhZGRlZCB0aGUgZnVuY3Rpb24uDQoNClJl
dmlld2VkLWJ5OiBUdWRvciBBbWJhcnVzIDx0dWRvci5hbWJhcnVzQG1pY3JvY2hpcC5jb20+DQo+
IA0KPiBBY2tlZC1ieTogUHJhdHl1c2ggWWFkYXYgPHAueWFkYXZAdGkuY29tPg0K
