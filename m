Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B60C58B167
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 23:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241586AbiHEVvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 17:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241511AbiHEVu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 17:50:58 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94087CB7E;
        Fri,  5 Aug 2022 14:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1659736167; x=1691272167;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Fp1gRB1Q95h6Riu4D4cJgPt6bM8LyPRJhor+LI1pedM=;
  b=Vj+Abw5EaE9kSncEIY2x6phbyjTFfsXdgGicMO3NzBk6cks/cDk28gcU
   4aayZu7d7pUzqx0OAqSnLVPKjEWM5fAaugdbggmZLFPEDlYrkz8hvp8vL
   ezdPBcPv2bZMauxXfnbKYJaiTolkXpTY+WSYms+hG79PYKtFXGE7tHb/F
   9Cy5UkFjBVTuiuJRy01huqgtWHc0qfZJVNKXDa3G/S6vhmsXkCZuO/yfV
   V3B2mvrMQq6Xr6kc4omPc+pC0bIdle9t9Y2I089A0wlOqJPHbakL67aLg
   j/bMb60vLuRtwiFWOH/mhjOv8W1kr5ZJhPghGjX0r2c4KfXFB4SXTjrNZ
   A==;
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="107816751"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Aug 2022 14:49:25 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 5 Aug 2022 14:49:24 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Fri, 5 Aug 2022 14:49:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HVrn5iGZGo0yPrqdB3eZ7ug5BRAKw3W90o3y2u9VXl8Ine1Y1We3kmIEUm+dODQRK05nK1ZXkmF+1eusV/jPzeAMGSQxZAb1dJtC6lNb5rH2aY67rZ1shJkHoLu7L1Tea97yKHqdA0HW4FnwO+y59VEeVOQ6sSVDsP9QQfiP6PyIms/0A6A6Y3cOQb3CSb5awJou7+MrNKZDR+wNit0t0sR67JE3gplZadnmUAFNCwJocHHob8JpT/lJONXzMRquVmqFv7oU83yPK9pnNm0+hJ+I8EElrHqI/++XbGSXuxDv90c0p5WrFHPpXvIRe6Ivzz0vGzHfhx3ehQGNWaHgqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fp1gRB1Q95h6Riu4D4cJgPt6bM8LyPRJhor+LI1pedM=;
 b=CwN9KfecL4qamtg6Ldw0MpcdJkfu+ZVEc/1rlGSEJ2N7DlNwmW4upfLdv9BUw4dyKqm++kMvAytNyEqsDA9pmRqIhpqdEy5yCeYj9RoGy6oMFdL3bi3csH/8NDuEi6P18LZ7j8cqfNlQ74XAnPRJgH6suXehYa0fM1daUayh3F14Kdt9kR6sRe5pSfn19axAW3GDsSJK4/soMJqk0V7S/BkQxYDJD+HYWqS2AeGCjZpwTRhNP3wUySyXbA25X75i9QxsrV030ZrK7wga0nzWmgcYisDXO5HDfcMuB4WKDptQNPyHIjImV5UBFK/RyvayNiR/zaKc34lCnN1V/1PLDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fp1gRB1Q95h6Riu4D4cJgPt6bM8LyPRJhor+LI1pedM=;
 b=lkVW/otHtzKuGSDAr1eWgaeEpiVdD0TrxUzecqND7mdE2MOrz0f2ti96mW3jObm2ynKu3IVR4HwxtRhwnuoH19sKWwqIUeijPhKmtwAuJOqbYNRt/Prh0asZfCn8dz+IMdFs9+pHyf9f6kYrZtzEImjobozSfmm94eIdlrK/1mI=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DM6PR11MB3098.namprd11.prod.outlook.com (2603:10b6:5:70::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.15; Fri, 5 Aug
 2022 21:49:22 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%8]) with mapi id 15.20.5504.016; Fri, 5 Aug 2022
 21:49:22 +0000
From:   <Conor.Dooley@microchip.com>
To:     <christophe.jaillet@wanadoo.fr>, <Conor.Dooley@microchip.com>,
        <Daire.McNamara@microchip.com>, <broonie@kernel.org>,
        <yangyingliang@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-spi@vger.kernel.org>
Subject: Re: [PATCH] spi: microchip-core: Simplify some error message
Thread-Topic: [PATCH] spi: microchip-core: Simplify some error message
Thread-Index: AQHYqRMTVToPNxWA0EWoMyaK4pw8ia2g2EqA
Date:   Fri, 5 Aug 2022 21:49:22 +0000
Message-ID: <e2450741-af74-2cdd-58aa-6483a639306b@microchip.com>
References: <fb894ecec68e03fb7fc9353027c8b1a2610833d7.1659735153.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <fb894ecec68e03fb7fc9353027c8b1a2610833d7.1659735153.git.christophe.jaillet@wanadoo.fr>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a7803986-9653-415d-d249-08da772c5b8d
x-ms-traffictypediagnostic: DM6PR11MB3098:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hVUxZJDhtWzoVXa2gZd/Vo2TaWls1ZvD1yeyI/BLGZXjerNLHiYwxkDDpQp3KaAm2cRj5PSpBwQKK2qGG/qcdGyA9RooLGheoD50kWcSp9Xanzrx2UXqzHdDgXg3NVxaeauu8wQXaC2XiizZZZzMSVkrIgp51hthLFYUJ4sW5Op2CZdggzdecbi66GSP7ZKge0qV7/4Rlb4RtL30Y1aCKebvDbrPt54GZJwv6zz6u/VKNsqSAGLN9G1Nn4OKp2f5rb10+hYUoFd0CBoapNXvhngHKviJQTawRi0/VUKp/oBR13XLcWZ2fIEubSHl2EcN9cNILygTE5BdH1Ax7BeZQJNGaZfKvVIVCEECFGzqzJvo4TXysb15Qlb/gEQSAL/0zJwLtvGHDKdQD2+4ZHy0vCJX6BCewfIx98EyPTUosT3Htogb8hp+jPGPw1PwA7jZJjxAHBjLn6F0jt7dL9lpMKTQzI0XfIJh7FxvjC4s/oDi+hJxp3vZ1AHdP8sQcj6Ek4vfzG0rHjAPR39NqUGCB1lmtpWOEdgA5sZVCTcyPGeskjNRGz57O8FfA//EVQPRWHtiWIgdg6tTlnwV6lfKQGKUoYw8whTeMZp5nkXHxzUCE9a8IXuW7cVX5Jmcvk1DD1oZQZUz9njrxHBbqHoM2ZXNq/Xx4PKT9FSLLt0gXsSNm7UE3sTc6eLY0SFjR/UVltZIxctgDHWdkAgojAwtcW49KhI6/KFPNZCl9kfJm9oN5w1D7MM44M8kGQVBnbYVq+G5ZRN+Pve5b3RdS9foqpfKSZV1hT1NF3wo/gWrWitu+AN9Yuk7bqdNl7odZM1rrYJQDaRj9A4YjY5dbG7yVr4vWwl6SbXDSf34ePdBTIdZ3mpEvpXgm6d+sl58USdI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(346002)(366004)(39860400002)(136003)(376002)(8676002)(5660300002)(478600001)(4326008)(76116006)(8936002)(2616005)(6486002)(66946007)(53546011)(26005)(6506007)(66476007)(66446008)(64756008)(15650500001)(86362001)(31696002)(91956017)(71200400001)(66556008)(6512007)(41300700001)(2906002)(110136005)(38070700005)(31686004)(54906003)(38100700002)(186003)(83380400001)(122000001)(316002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eWlPZEo3TGR6akhZdUtCZklFOExpSnBTY1d4eTF3YTdQVDJuYVVOZDVFSDBs?=
 =?utf-8?B?U0JTK2IvY2M4VUwvQ2lvK3NOcGRiUXg5RDhmbGloQVBWelk1bCtqWGNrSkhF?=
 =?utf-8?B?YjRBUG9YQWNQNUtsQm9XYjFmUXZXelY3REc2S1FaUGQ3MTBIU05LRDJUYXVR?=
 =?utf-8?B?TG16cjlXeUUyYk82MnJFS0R5VHM4Qk5UdEx1ejlCU2xkVVcyYXBERmhRZXhL?=
 =?utf-8?B?eE5zK1FVNVFMTkRQT1RyVUViQVkrQjVBWTJzOE4vY2E5Zml4eFhycDJCcnR4?=
 =?utf-8?B?aE5SVEtSNTZtVEx6Q1oreDZmZlVoMzlhOGV3aHpYMnVCK0c1TG5kbjEzZytF?=
 =?utf-8?B?ejlzbUNaTDQzQ2RlNmFkV0dNNWFoN1A0RXYyRHZrU09ubHJXZFZaOGp1dWYz?=
 =?utf-8?B?RTFsa0xOUzhqcExjcG5JaFNpMkFQakxuejgrODlQRFh0TmVKZDQ2bnVJa3d5?=
 =?utf-8?B?aHFGaExuUjI1Ty9jQnQxZFh0bFlRM0tIVUdKOFRQbDd4QVFVT0lQTXRkc0Iz?=
 =?utf-8?B?ajU2R2dNY0ZLY21kQm5Mc0QyWndvZ0dvaGpLYWFFbmgrOHNBM1RQUFQ1RnRK?=
 =?utf-8?B?cnNiV2tQTVFXdkVKUlNKZldlSEZUeFJYcVE0cUNUdE5pMkxUNTUwRnFDamVy?=
 =?utf-8?B?Njc5bDNYeEZidmk1aXNOcjF4MElPeURoUFRZdG5IT05sNVJuY0U1aFdmWno5?=
 =?utf-8?B?Z2VjdkcxV1dFNnZJWVlDYUJzM25ESi94QTBFSHdYblhiK21wUGc1ME05MFNK?=
 =?utf-8?B?SU1FNnVGOVlDRDlnaUl3eCtZSWs5ZXVzaGxtZ2pBd0NBZUZ3M2NYU2Ftd05Z?=
 =?utf-8?B?eGU0QlUwaU9RNG1Oc1l6N2ZpSW9TS25FanZYdTVnaGN6V1daZThBOTdhakJx?=
 =?utf-8?B?ZXZFRDlrc1hMTUswZ0l4UVl3QTlLZjIyVWprWVFIRjlnZm85TDNUbHFGdjY3?=
 =?utf-8?B?RGY1d0p1VXpJYStBU2FncmxsM3BhUEdLcjZJQXBYYTlNKzFBYld4ODZxOXdn?=
 =?utf-8?B?cW9RYjlUOVBqaXlPbjA1d1M4K2gzRFhpOHF1MTRYd0ZieDhOdjU3amVlNGVw?=
 =?utf-8?B?NTVHSjhuS21UQUF4UkNwcHEvSlA1MTRsb3IrUG1Sb3V0TDMwS3VCQllxOE9y?=
 =?utf-8?B?YnRDdGQ2c1Y2cDUrRSs2Y1lsNUtXVWYyaENIVlJOUEMzWGVsL2NCT2RJa0l4?=
 =?utf-8?B?cEVzaTcyalVvU1dNbXd0YnJzbkdKWVJiRERHdUd6WjJ4YkN6aDFnSy9DK1Rm?=
 =?utf-8?B?S1daNXNCVjZsODZMNTJEbFZJMlpsT2lIenRIUkQvVDFzWUZOelhSWlFkN2x5?=
 =?utf-8?B?Z2o5QW5JUVIrazV0RGRBLzYveUVINFJuOVIrVWdRVkkydHk0aXlaSTBKL1lE?=
 =?utf-8?B?czlYSHk4cVUwajdwU1BwQkpyYWt2b0ZuV284dDBjMCtVN3FSL2hrK1hUUzZR?=
 =?utf-8?B?N2tWSlNtc1dGb0oxRjN1QkFXVUJrRjZSQlE5Z3RlbUUwVlhHSnZyUk84Sk9K?=
 =?utf-8?B?emxjUmYyaWlKQ0lLT2VMUTZpQlFXNkxtdnVMZTFpZUZTeE1WWUpnRnU1RzY2?=
 =?utf-8?B?MWxwRG4yb21tUm5WbzhkTHNJNUdhWVJxMUcycGRWNi9Fak9POFN1ZmtIazNp?=
 =?utf-8?B?Y3AxQXh0bG9TWXI4NmxIeWpHbXI1UllmdkxPbHJZTjN1R1gwVFZyRzk3Qzdr?=
 =?utf-8?B?OXgvM1g2SlNkUThENENjRUhVOGp2bVVMR2FiRUFUb2hEQmZ4K0Z4R1FhWjNt?=
 =?utf-8?B?UDdONjMwMXE2V1dsanlqYTNPckR0a2k1R01CZ0VTQ0hLanczTi9haWdyK3lp?=
 =?utf-8?B?R2tCL0xobjJyZVlqTmx4d094allTWmVYOGNnQ0hyZ1hibWQwbFBVeUQwRzcw?=
 =?utf-8?B?U1I3c1RnWVp4NDF0UHB5WC90YllGRVE1NThWQjhOa0x4R0Jram9aMGN4Wm1u?=
 =?utf-8?B?S3J6VVRJQVMvVFJ2bHdKeXMrUE9hbUtlN1NMcTNTczFHRXdlTHJMdWJGRXdM?=
 =?utf-8?B?WXEwOUszNHREZDJ4TG1YMHZ5ZmhBOUdsMHNnVlpsTzZrRjBJeWNXNFNhdDZP?=
 =?utf-8?B?dEZqWHY5RWtxMStKbWtoUFg0NW5MSjlrcWsyd2tvTjFuSGN4aGwzcTJVaGJv?=
 =?utf-8?B?OFNKaXhMa29mSk5kMGpGMldvQUJMNW10V3ZuZ1grcjBzZks2WFJISHNUYTNi?=
 =?utf-8?B?Zmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7856B630579C0342BCE3686F4C932A10@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7803986-9653-415d-d249-08da772c5b8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2022 21:49:22.4009
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CF0898YxB0B4JfvLuAvZiSecscb6qExYp8gTIoXB6el1PB8qzzwCTC/tqg8M9q5J/Bwy5kNjwHRwVQgsTCokF8wXsGgSEDC3BGzcrYTUWuY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3098
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDUvMDgvMjAyMiAyMjozMywgQ2hyaXN0b3BoZSBKQUlMTEVUIHdyb3RlOg0KPiBkZXZfZXJy
X3Byb2JlKCkgYWxyZWFkeSBwcmludHMgdGhlIGVycm9yIGNvZGUgaW4gYSBodW1hbiByZWFkYWJs
ZSB3YXksIHNvDQo+IHRoZXJlIGlzIG5vIG5lZWQgdG8gZHVwbGljYXRlIGl0IGFzIGEgbnVtZXJp
Y2FsIHZhbHVlIGF0IHRoZSBlbmQgb2YgdGhlDQo+IG1lc3NhZ2UuDQo+IA0KPiBNb3Jlb3Zlciwg
aW4gdGhlIGNhc2Ugb2YgZGV2bV9jbGtfZ2V0KCkgaXQgd291bGQgb25seSBkaXNwbGF5ICcwJyBi
ZWNhdXNlDQo+ICdyZXQnIGlzIGtub3cgdG8gYmUgMCBhdCB0aGlzIHBvaW50Lg0KPiANCj4gRml4
ZXM6IGNkZWFmM2E5OWEwMiAoInNwaTogbWljcm9jaGlwLWNvcmU6IHN3aXRjaCB0byB1c2UgZGV2
X2Vycl9wcm9iZSgpIikNCj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoZSBKQUlMTEVUIDxjaHJp
c3RvcGhlLmphaWxsZXRAd2FuYWRvby5mcj4NCg0KYmFoLCBzaG91bGQgaGF2ZSBub3RpY2VkIHRo
YXQgd2hlbiBJIHJldmlld2VkIHRoZSBzd2l0Y2ggb3Zlci4uLg0KUmV2aWV3ZWQtYnk6IENvbm9y
IERvb2xleSA8Y29ub3IuZG9vbGV5QG1pY3JvY2hpcC5jb20+DQpUaGFua3MhDQoNCj4gLS0tDQo+
ICBkcml2ZXJzL3NwaS9zcGktbWljcm9jaGlwLWNvcmUuYyB8IDQgKystLQ0KPiAgMSBmaWxlIGNo
YW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3NwaS9zcGktbWljcm9jaGlwLWNvcmUuYyBiL2RyaXZlcnMvc3BpL3NwaS1taWNy
b2NoaXAtY29yZS5jDQo+IGluZGV4IGNlNDM4NTMzMGIxOS4uZDM1Mjg0NGM3OThjIDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL3NwaS9zcGktbWljcm9jaGlwLWNvcmUuYw0KPiArKysgYi9kcml2ZXJz
L3NwaS9zcGktbWljcm9jaGlwLWNvcmUuYw0KPiBAQCAtNTQ4LDEyICs1NDgsMTIgQEAgc3RhdGlj
IGludCBtY2hwX2NvcmVzcGlfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4g
IAkJCSAgICAgICBJUlFGX1NIQVJFRCwgZGV2X25hbWUoJnBkZXYtPmRldiksIG1hc3Rlcik7DQo+
ICAJaWYgKHJldCkNCj4gIAkJcmV0dXJuIGRldl9lcnJfcHJvYmUoJnBkZXYtPmRldiwgcmV0LA0K
PiAtCQkJCSAgICAgImNvdWxkIG5vdCByZXF1ZXN0IGlycTogJWRcbiIsIHJldCk7DQo+ICsJCQkJ
ICAgICAiY291bGQgbm90IHJlcXVlc3QgaXJxXG4iKTsNCj4gIA0KPiAgCXNwaS0+Y2xrID0gZGV2
bV9jbGtfZ2V0KCZwZGV2LT5kZXYsIE5VTEwpOw0KPiAgCWlmIChJU19FUlIoc3BpLT5jbGspKQ0K
PiAgCQlyZXR1cm4gZGV2X2Vycl9wcm9iZSgmcGRldi0+ZGV2LCBQVFJfRVJSKHNwaS0+Y2xrKSwN
Cj4gLQkJCQkgICAgICJjb3VsZCBub3QgZ2V0IGNsazogJWRcbiIsIHJldCk7DQo+ICsJCQkJICAg
ICAiY291bGQgbm90IGdldCBjbGtcbiIpOw0KPiAgDQo+ICAJcmV0ID0gY2xrX3ByZXBhcmVfZW5h
YmxlKHNwaS0+Y2xrKTsNCj4gIAlpZiAocmV0KQ0K
