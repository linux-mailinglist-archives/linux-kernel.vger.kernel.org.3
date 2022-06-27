Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB27B55D70E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239720AbiF0Qx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 12:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235032AbiF0Qxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 12:53:55 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28663186F2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 09:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1656348833; x=1687884833;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=YZL+i0FscpTctDWtfzk96mwAYi+dMSFVa6aonVCsBUQ=;
  b=JxlKi3NSnYQrS3Ata+AjTnnDE0LdFKsIiHQfjoY7cCHK4koTbxJgvOx/
   Zk9RNHBj5O45QBSCe/u86GMpRe+hr+IutE98MeOx/DeZubwwAhwdhHdCg
   0xxe4KyHhhwGSuFJqhbnuEPdR7h0WFjCRc3Lw4qxzNsNAZd6nuISVzc17
   mn9sjk2lz9uQCZ3tj7XbbHXeFpnhe7qUVELrXbT+qNPSTaoysvh6M+LcG
   39TRjzeSJ5l7exM3DliFLCODb6whK3ZXMhojxU4TsXQoYUaABznVLVM2o
   fpcM0YtkE6tJXuwUjg8Iu6fJH/EAuAVvd+bdzeuGx+yfuY6Lqsh29z50W
   w==;
X-IronPort-AV: E=Sophos;i="5.92,226,1650956400"; 
   d="scan'208";a="170067105"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Jun 2022 09:53:53 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 27 Jun 2022 09:53:53 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Mon, 27 Jun 2022 09:53:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KcsV+NRxEG4YVZVO33VUyuz0FkIL56/HkDgIWMl9gjF2HKxMpP9MRJNzJff2dMNJhYOx0lTY6cNWlipUItYtmHzVvdc9qq69CaY6or77nVbtGr6y+1Fb+4hgBxFiah9GPV4kkvVT3q5XEb8Clu0+IjF+zH4adQwp+C7WJObV3gayFLLn265z9kEbrveQPi2/RTomJU0tt47ZcxdN4Nt+nQnYVdw5AH7PGrzEs/Mwpx7BgLbmCmvYwwiLCdCxY4UhewWYO405AIsl2IQdoA2YttPJCc+xURTqa8iUnNdUd8lKtWtA/ofGDQTJ65B0qSxekEpepW9yP4XRFdJkPAmkMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YZL+i0FscpTctDWtfzk96mwAYi+dMSFVa6aonVCsBUQ=;
 b=HoWm3OOPc6oJFDB6GxAjqGi8CPj+h7PT8wB691ggBLxlmFfsmfZvHqjHDdYL7AW5xZJrC6hVwK4BPwj7Y67S6nj9NzrhBSxOtmhuBroqdQAsdMZoUj78rYaw+Zfn00XJ6pEQj47iylbekeU9BgqXJzDZWN0lFmraXaPf1R7m13atQmgW5rp9ionWyIX9uk79XLQXSzvoS0t3BGA3iZ5tOZS7bA4EgUe1DA87hnmSSqONiYJ9mMH2fjwxh6QnONOhcR8zn3uF0wS7lCdK8TDCT5PxQRqIe0XaPlhgfsx3ic2Uq6bcPiQht4PdG/tF0k6/1v92L6z6X1/HWkeSB1tsRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZL+i0FscpTctDWtfzk96mwAYi+dMSFVa6aonVCsBUQ=;
 b=q0GN3oxzHAIqassiys0ZeJwHAtSoYbc9Tn7CAR7itU7eekXhYdLhB6OvfBZwCj8CGPY6JYaXhf3YyTGP4c4Z9aGawT/SpGyzQyDzRp2WhuypH2Y5g7ZmktRjsLGuwmhCcC3XR4TAJjZ8OUgqAvRnM6smzRpPhFIrdX7uvURGhxo=
Received: from DM4PR11MB6479.namprd11.prod.outlook.com (2603:10b6:8:8c::19) by
 CY4PR11MB2024.namprd11.prod.outlook.com (2603:10b6:903:29::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5373.17; Mon, 27 Jun 2022 16:53:46 +0000
Received: from DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::1954:e4ab:eafd:9cb4]) by DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::1954:e4ab:eafd:9cb4%5]) with mapi id 15.20.5373.018; Mon, 27 Jun 2022
 16:53:45 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <peda@axentia.se>, <regressions@leemhuis.info>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>
CC:     <du@axentia.se>, <Patrice.Vilchez@microchip.com>,
        <Cristian.Birsan@microchip.com>, <Ludovic.Desroches@microchip.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <gregkh@linuxfoundation.org>, <saravanak@google.com>
Subject: Re: Regression: memory corruption on Atmel SAMA5D31
Thread-Topic: Regression: memory corruption on Atmel SAMA5D31
Thread-Index: AQHYL7i/by/02n1wA0qavxdAEojSf61kLXgA
Date:   Mon, 27 Jun 2022 16:53:45 +0000
Message-ID: <dc500595-7328-999e-6fa7-7e818378bb0d@microchip.com>
References: <13c6c9a2-6db5-c3bf-349b-4c127ad3496a@axentia.se>
 <a024180a-493c-af20-0910-da30dd5fe364@axentia.se>
 <6d9561a4-39e4-3dbe-5fe2-c6f88ee2a4c6@axentia.se>
 <ed24a281-1790-8e24-5f5a-25b66527044b@microchip.com>
 <d563c7ba-6431-2639-9f2a-2e2c6788e625@axentia.se>
 <e5a715c5-ad9f-6fd4-071e-084ab950603e@microchip.com>
 <220ddbef-5592-47b7-5150-4291f9532c6d@axentia.se>
 <6ad73fa2-0ebb-1e96-a45a-b70faca623dd@axentia.se>
 <0879d887-6558-bb9f-a1b9-9220be984380@leemhuis.info>
 <4a1e8827-1ff0-4034-d96e-f561508df432@microchip.com>
 <1a398441-c901-2dae-679e-f0b5b1c43b18@axentia.se>
 <14e5ccbe-8275-c316-e3e1-f77461309249@microchip.com>
 <c5928610-4902-27f3-7312-e8c85eefad39@axentia.se>
 <bfb4cb27-e2e1-e709-1c27-d938e4d30eab@leemhuis.info>
 <6b1bae01-d8fb-1676-3dee-9d5d376e37f1@microchip.com>
 <0d8b2d9c-af85-7148-ff13-aa968a7f51ad@microchip.com>
 <AM0PR02MB4436C535FDD72EFE422D8B10BCB39@AM0PR02MB4436.eurprd02.prod.outlook.com>
 <272fb9f0-ad33-d956-4d0f-3524c553689c@microchip.com>
In-Reply-To: <272fb9f0-ad33-d956-4d0f-3524c553689c@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c6eac106-b6e3-420d-b599-08da585d9998
x-ms-traffictypediagnostic: CY4PR11MB2024:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d5cbkm8roJPN6X/BLiroxh+3QORG5r3Ibz0DmPRZjprhBA+AFFC5AFy+AtHNX/rSdQSqkz/41dkTzXKbA2CcAXj/+2wzRlri75Q447or6Pcs3itoaavPX/KUK8UfU0e2Fm1vjuN7WVmmpj2tO0XMRV0sbs3TFaih3NXgFsoWoKc3I8xLoKv4TsgYszj+7rNo1xnC8wha+0ZPRhyPRRGFA8ljBOtAs8TTHhkTJuurKlL7HKMMBbbJFUPzyf9DG743Np0Df/lgwcL7pG+dqB55d7fHhGeyG5SbcB+76R2RhJNAi9zqYfJ3S4fib+RCUHIeFz15pAqldDhFVsEJYM1SHzS9HlBdiEz3Vb2mrrUOapRiYNfgCopzrDBgXuAVqQa3mPV3WeQyYcRWJlXcn9MEx7PtmkLwJ4j28oOAjRqU5q+zViR2QXchCRwiWv9nX4ad2v8fHXsRDsOwRimH2IITha8rWTNztMWi5BUzK4Wx3LxbL/bCQDP7Yt3j6QS7QwG9GDFDWVYf8nc8gR97Gw2rXQUyFJ0Dq9POjSAZVpAA/J72FvEVduYQF3fZqtpv/dLBgm+MiVb1JZg+IUSxKP+81iQRrDb28YIiIgB60Tx9MQBy9A8gRkUhTNB15rRvfvozjbG8PEuOEojuqq2+lA1nxxt1qCKQVQWCktjtsBj/9Y7ul1ZHHU/ssxEAdqfYlwGr4fCxpG4i00qPgL7MwscH5EOxltMQqQdJxrMrynZUbNjGMb3BopAeAVTyppnE2vDSxdvWUAF6HG0ygikAQcCgOIMok2gq4ArM0V04DUk8bULuTvqnnm2qKuM6iDLzldk36K59WZo8pURbVDWLuKWmR5eqb5DqxTYF4TM71fnjh4s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6479.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(366004)(346002)(136003)(396003)(376002)(5660300002)(76116006)(478600001)(66476007)(4326008)(64756008)(8676002)(66446008)(66556008)(66946007)(91956017)(38070700005)(110136005)(8936002)(71200400001)(6512007)(2616005)(26005)(54906003)(316002)(31696002)(41300700001)(38100700002)(6506007)(53546011)(31686004)(122000001)(86362001)(83380400001)(36756003)(6486002)(186003)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y2JmTjJDeE9MVGdwQmpBU3E5RFBOa0VzMENsb3BEN0I4cGJRYVl0SCtMSFNy?=
 =?utf-8?B?aXRtMjdoVGl3aXZ1WkR5MFRla0dLQ0ovdllxMkR4NGxkcUZ1bkkwbmhwRnVy?=
 =?utf-8?B?ZkZJV1BVQWlnQVpKcG8rcXM5VklZU2E1SHRhcEtmMzRIckFhV0gxeXRXcW0w?=
 =?utf-8?B?QkxBeEF6NnlBYTlkQjJpNEFoQWFnejFHbFprOHNrbEt1MENFQ1BML0JabHI1?=
 =?utf-8?B?Rlo0YitmbXpZaU9jRjdjdE94QmJLY3F4OE1vTVV2UFphRUZjNTNKdUUyMUJF?=
 =?utf-8?B?N0V4M2d5RGRxc21SVVNQZ1pTMERMeGJvMnVPY21yRlR2QlNRdE9PVmRjeTd5?=
 =?utf-8?B?MURmSGFNUi9sQS9mamNmZHdObEl2WU1yTnFrc0tXRmNBS3I1ekhmdkh5U0Ry?=
 =?utf-8?B?Wk1lMWRmb3BWNmhzT1ppbUZpcEhETGRLVjI2UC9BQ2VIRHgwU1A4aEllTFU4?=
 =?utf-8?B?SXBNekU1M0xJM2FKcHNPdUllYU9yQkt6NkZsTDRBTWJ0STdwOWFRUHRRUmJa?=
 =?utf-8?B?cWlBN2tQMkdWOHgwcHlTeHNCRUtmb05vRGxiZ0M4dm04WHBmTHAzaXlZNmlH?=
 =?utf-8?B?Q3VzbmtGTmF0SkszNHdmUEtxY1dhVGJaNGJiWWJ0TUtYMUJkblBJMG1ObFNS?=
 =?utf-8?B?aFc4T1JsR0VXSnVUWk1mejEyZldYaTZRV1oyYVZKY05GdVRWNWl0ZTd3ODdC?=
 =?utf-8?B?NDRMRXVQUkNIRVZ0MnRCRGhjSmdLamRxdHZYVzF1SUVLNHJLaVhHbHEvOGYr?=
 =?utf-8?B?UEd1U3paaU9FZktIUnAxelVwa2JNWjk4K2ttUjhweFl3dFdlWk9sZnVKYjR5?=
 =?utf-8?B?dm1WRXRFK2VjUGdDOHZBY2hZQUxZcXhLbWQ2OEJOc0lJeUdjT3pTL0VYNXlp?=
 =?utf-8?B?MHptN1FSNFd2NmZvWUFLbGFzN0RIQTJTcjM1dmcvTHEyVy9PcE1HWWdtRHpQ?=
 =?utf-8?B?cktjMEQzMWJBaHBraEVkTUcxYXRQZzBPQmNCNlNkUjVJMkdRMTVNMzZLVGhU?=
 =?utf-8?B?R1hCMERXYWd3OVNKNHI2RG00Tm9UcllPYTByOFcrTkV0TEoxZkhsRnVtT2xp?=
 =?utf-8?B?bHBmM0IvaTQzZGdzeGtoMHd0b1NxRDBiRmN2RmR1QUVkTWpqSjY0Tlg0MjVu?=
 =?utf-8?B?THpzNWtJalVlV3BVWDdXSXRNdFNYUUdiN1dqemd4K3VCRGxmakpRcXlaZ0ZO?=
 =?utf-8?B?ejhZR2VNQnY2NWdMcjBOUm5pc2tKYWk0OEJ5bnVkaWI2RDFkOEFoeHBuUlha?=
 =?utf-8?B?RjNOVllvUXBjZVNoYjNWVHJFWVBtN2ZDYjJlbVFsaHd0LzdRZENxVVNLS25K?=
 =?utf-8?B?aVd6d29oQzkrdkZ5ajhOeXQxY0tXeWpSVVNrNTYrVm54c3c2N29JR1J4ZmRP?=
 =?utf-8?B?WSthVkVSWFpFYXRjYmlaNHNlQ3daRFptbmlnTUdHZXQxZnNaUS9FOU9ocHha?=
 =?utf-8?B?YjJDeHllZGZpTGs1S0JvdE5DR0RZRW02TW9IWUJ0dDV2cDdEVzc1dmk5RE45?=
 =?utf-8?B?ZTA2UDdORVoxTXVzdk9nOG95WXl3VHp5clNSNTdZL2dZV3BjMEExVFRHNkc0?=
 =?utf-8?B?dHNYcGZUcktHd3drdlFTSkQxVStqaExuK25WMTVFY2owZ2pQVDQ1K0M0dHpJ?=
 =?utf-8?B?ZEliblpxS1ppYTdBOU1UWDJEcWVseVY3MFR1ck56OStRMGFvb09sRXk1Ny95?=
 =?utf-8?B?a3BIdkFMSVcxSG9pM3hBRzRmbHdUdzk3TjhudWpjb2JxQ01XakNJR1pqVXds?=
 =?utf-8?B?SFdqU0JicDREL2lWWVR2TlZNV00wZkhGTGtpZ3FpbVlSYk4vY3EvbDNRL2pq?=
 =?utf-8?B?QTlSMFFHMG1yNFVjTW9nOWRQMXZyemJ2NW0wS21mN3prOVRncTFHSldqWGkv?=
 =?utf-8?B?UE5lM3pwd2pPaDcxdzNWdDNobHNVcEJXNy9tOVRMSWhINEpWREFnbEVBNEV4?=
 =?utf-8?B?WXBqTmhKdnBQT1BWb3lLb2FaWEQvbzg5bjA1MWZPUkExU3Yyd1hxTHR0THBP?=
 =?utf-8?B?TEhDYVhtTFNTNXVpazNnRC83UUlnM3Jrdm9BcWZZSFRva1BJOEhKZ25ubkFj?=
 =?utf-8?B?aHhyYmNpU2FMSTZiM3pMVncwa0h3eU04WExSQ3d2V3hGUHZPWXk1eDQ1THpR?=
 =?utf-8?B?NWNmS1NBRjk0OHJUaFZSK041QXBodmNNRGhNcGViWHNybEN3VFlELzBvNkNZ?=
 =?utf-8?B?U0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <059BEC2372B6A54F9412D942B2FE2D5F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6479.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6eac106-b6e3-420d-b599-08da585d9998
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2022 16:53:45.8315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q/SFTHws0ktAGWXdtP7QSdiqszLFk7T86fHMIfSvAPWAMFRQlKIHQTK5BQHcb84EvvqBRtBylFi68SVv7VqbsnKRJcL5LJznyDDVXoENTaE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB2024
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNi8yNy8yMiAxNToyNiwgVHVkb3IuQW1iYXJ1c0BtaWNyb2NoaXAuY29tIHdyb3RlOg0KPiBF
WFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5s
ZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIDYvMjEvMjIgMTM6NDYs
IFBldGVyIFJvc2luIHdyb3RlOg0KPj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5r
cyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZl
DQo+Pg0KPj4gMjAyMi0wNi0yMCBhdCAxNjoyMiwgVHVkb3IuQW1iYXJ1c0BtaWNyb2NoaXAuY29t
IHdyb3RlOg0KPj4+DQo+Pj4+DQo+Pj4+IGdpdEBnaXRodWIuY29tOmFtYmFydXMvbGludXgtMGRh
eS5naXQsIGJyYW5jaCBkbWEtcmVncmVzc2lvbi1oZG1hYy12NS4xOC1yYzctNHRoLWF0dGVtcHQN
Cj4+Pj4NCj4+Pg0KPj4+IEhpLCBQZXRlciwNCj4+Pg0KPj4+IEkndmUganVzdCBmb3JjZWQgcHVz
aGVkIG9uIHRoaXMgYnJhbmNoLCBJIGhhZCBhIHR5cG8gc29tZXdoZXJlIGFuZCB3aXRoIHRoYXQg
Zml4ZWQgSSBjb3VsZA0KPj4+IG5vIGxvbmdlciByZXByb2R1Y2UgdGhlIGJ1Zy4gVGVzdGVkIGZv
ciB+MjAgbWludXRlcy4gV291bGQgeW91IHBsZWFzZSB0ZXN0IGxhc3QgMyBwYXRjaGVzDQo+Pj4g
YW5kIHRlbGwgbWUgaWYgeW91IGNhbiBzdGlsbCByZXByb2R1Y2UgdGhlIGJ1Zz8NCj4+DQo+PiBI
aSENCj4+DQo+PiBJIHJlYmFzZWQgeW91ciBwYXRjaGVzIG9udG8gbXkgY3VycmVudCBicmFuY2gg
d2hpY2ggaXMgdjUuMTguMiBwbHVzIGEgZmV3IHVucmVsYXRlZA0KPj4gY2hhbmdlcyAoYXQgbGVh
c3QgdGhleSBhcmUgdW5yZWxhdGVkIGFmdGVyIHJlbW92aW5nIHRoZSBwcmV2aW91cyB3b3JrYXJv
dW5kIHRvIGRpc2FibGUNCj4+IG5hbmQtZG1hIGVudGlyZWx5KS4NCj4+DQo+PiBUaGUgdW5yZWxh
dGVkIHBhdGNoZXMgYXJlIHR3byBiYWNrcG9ydHMgc28gdGhhdCBkcml2ZXJzIHJlY29nbml6ZSBu
ZXcgY29tcGF0aWJsZXMgWzFdWzJdLA0KPj4gd2hpY2ggc2hvdWxkIGJlIGNvbXBsZXRlbHkgaGFy
bWxlc3MsIHBsdXMgYSBjb3VwbGUgb2YgcHJvcG9zZWQgZml4ZXMgdGhhdCBoYXBwZW5zIHRvIGZp
eA0KPj4gZWVwcm9tIGlzc3VlcyB3aXRoIHRoZSBhdDkxIEkyQyBkcml2ZXIgZnJvbSBDb2RyaW4g
Q2l1Ym90YXJpdSBbM10uDQo+Pg0KPj4gT24gdGhhdCBrZXJuZWwsIEkgY2FuIHN0aWxsIHJlcHJv
ZHVjZS4gSXQgc2VlbXMgYSBiaXQgaGFyZGVyIHRvIHJlcHJvZHVjZSB0aGUgcHJvYmxlbSBub3cN
Cj4+IHRob3VnaC4gSWYgdGhlIHN5c3RlbSBpcyBvdGhlcndpc2UgaWRsZSwgdGhlIHNoYTI1NnN1
bSB0ZXN0IGRpZCBub3QgcmVwcm9kdWNlIGluIGEgcnVuIG9mDQo+PiAxNTArIGF0dGVtcHRzLCBi
dXQgaWYgSSBsZXQgdGhlICJyZWFsIiBhcHBsaWNhdGlvbiBydW4gd2hpbGUgSSBkbyB0aGUgdGVz
dCwgSSBnZXQgYSBmYWlsdXJlIHJhdGUNCj4+IG9mIGFib3V0IDEwJSwgc2VlIGJlbG93LiBUaGUg
cmVhbCBhcHBsaWNhdGlvbiBidXJucyBzb21lIENQVSAoYnV0IG5vdCBhbGwgb2YgaXQpIGFuZA0K
Pj4gY29tbXVuaWNhdGVzIHdpdGggSFcgdXNpbmcgSTJDLCBuYXRpdmUgVUFSVHMgYW5kIHR3byBv
ZiB0aGUgZm91ciBVU0Itc2VyaWFsIHBvcnRzDQo+PiAoRlRESSwgd2l0aCB0aGUgbGF0ZW5jeSBz
ZXQgdG8gMW1zIGFzIG1lbnRpb25lZCBlYXJsaWVyKSwgc28gSSBndWVzcyB0aGVyZSBpcyBtb3Jl
IERNQQ0KPj4gcHJlc3N1cmUgb3Igc29tZXRoaW5nPyBUaGVyZSBpcyBhIDEwMG1icHMgbmV0d29y
ayBjb25uZWN0aW9uLCBidXQgaXQgd2FzIGxlZnQgImlkbGUiDQo+PiBkdXJpbmcgdGhpcyB0ZXN0
Lg0KPj4NCj4gDQo+IFRoYW5rcywgUGV0ZXIuDQo+IEkgZ290IGJhY2sgdG8gdGhlIG9mZmljZSwg
SSdtIHJlY2hlY2tpbmcgd2hhdCBjb3VsZCBnbyB3cm9uZy4NCj4gDQoNCkhpLCBQZXRlciwNCg0K
V291bGQgeW91IHBsZWFzZSBoZWxwIG1lIHdpdGggYW5vdGhlciByb3VuZCBvZiB0ZXN0aW5nPyBJ
IGhhdmUgZGlmZmljdWx0aWVzDQppbiByZXByb2R1Y2luZyB0aGUgYnVnIGFuZCBtYXliZSB5b3Ug
Y2FuIHNwZWVkIHVwIHRoZSBwcm9jZXNzIHdoaWxlIEkgY29weQ0KeW91ciB0ZXN0aW5nIHNldHVw
LiBJIG1hZGUgdHdvIG1vcmUgcGF0Y2hlcyBvbiB0b3Agb2YgdGhlIHNhbWUgYnJhbmNoIFsxXS4g
DQpNeSBhc3N1bXB0aW9uIGlzIHRoYXQgdGhlIGxhc3QgcHJvYmxlbSB0aGF0IHlvdSBzYXcgaXMg
dGhhdCBhIHRyYW5zZmVyDQpjb3VsZCBiZSBzdGFydGVkIG11bHRpcGxlIHRpbWVzLiBJIHRoaW5r
IHRoZXNlIGFyZSB0aGUgbGFzdCBsZXNzIGludmFzaXZlDQpjaGFuZ2VzIHRoYXQgSSB0cnksIEkn
bGwgaGF2ZSB0byByZXdyaXRlIHRoZSBsb2dpYyBhbnl3YXkuDQoNClRoYW5rcyENCg0KWzFdIFRv
IGdpdGh1Yi5jb206YW1iYXJ1cy9saW51eC0wZGF5LmdpdA0KICAgY2JiMmRkY2E0NjE4Li43OWM3
Nzg0ZGJjZjIgIGRtYS1yZWdyZXNzaW9uLWhkbWFjLXY1LjE4LXJjNy00dGgtYXR0ZW1wdCAtPiBk
bWEtcmVncmVzc2lvbi1oZG1hYy12NS4xOC1yYzctNHRoLWF0dGVtcHQNCg==
