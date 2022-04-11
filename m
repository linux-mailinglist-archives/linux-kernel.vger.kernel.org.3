Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D794FB3B4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 08:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244934AbiDKGXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 02:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244928AbiDKGXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 02:23:40 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 588823D1F3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 23:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1649658087; x=1681194087;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=gXhX8rmLvXaW1xEq6RnLMyvcWwb4BBdlwMHLOU5MBAE=;
  b=Ms6N4TnqnA0kXCucKj8DaF4HZXjDlYhHuaoAAy9I6VWmFVtEvnwsYzLw
   eXvFGjnhJrPc/zTyHNy7BjKjghTm3orYb9K149FGBfJcVZu3fZlaZ/GBj
   muYmZg2rBdoj1/ke+4UNZij+Jxer7k7B36ZAvtTNuzpF8mCfJji4ihkT3
   6eZDs4LJK9KxKo6FTMnQcOopmQm3rdr3q0Pg5u31DUkOdkveVKAVL+pGP
   uvFCvsuW/Ke0tkG6vCq+GuYTzoDkk7+z0uRWRU+jwuRMo/gS+2grJ8rj1
   lsFptAEXdc07W0VkO5Cs6xRCsBotkHd2ZFPAUedt8KcbIvdSpHV1HsSug
   w==;
X-IronPort-AV: E=Sophos;i="5.90,251,1643698800"; 
   d="scan'208";a="159607578"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Apr 2022 23:21:26 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Sun, 10 Apr 2022 23:21:25 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Sun, 10 Apr 2022 23:21:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BtZeePD1NSZnAQnCF+Jb6vr7CWzL6Indl4pCjHvVuALrYo36Y4gG/mBxrUXG5yeslqhYxiTu8Tyk7F4r5pi3owNh88yFBOvBNmNJC4ja+w4MGnT9uFdHi6EUmCt1tvf/a/UNw/2NVx2JTT8ZIqzU3AjOvWdSMLiZWeTUffG0UUJAlei8j8kgz7l2rUsnsKcNJu6XuxHxIuadrPXudglTSweza60vUq8gZhtscmfp1tTHuhgEzo9RNw8xAM9gPctpvj7zg91fXT4WWifgBud+1YVVXa5lR3dbdhoHrVRA+yDwlOrrf2dH8+ATaDr7yq90zWjKBpBQ2hTchFai1RB48w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gXhX8rmLvXaW1xEq6RnLMyvcWwb4BBdlwMHLOU5MBAE=;
 b=lKbzZs6QWDDqmB58m4HEjzeH/CBc7PExu7WtNPpZMJPfIuYRZwzeHpGwyDcBDRFbfeqT2W/YUZ9jAUYw7vGSA5Y9aFQV0yEIzP2pknpYYRR4CFXi5OvGYdGJKLLU7ow41jIR6LebsFIeHSU5wDq7b+dWOE5k1R8TCg3F/UHzJ562MP799p35+h5BUauoH1+M0dPmNiXYo3J2sULFj0MLh5TXfolkkZS+DslROktHhId2gQWmtCb10JyEnj66y1zODdcfI7KgTfiRDPsKxiQBi2oeYSeD1CmJx/CvkV+C82EfSf0rtkoV5E0hAdbB3rMBz0uVJGqnwBypgwjWp5Q5bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gXhX8rmLvXaW1xEq6RnLMyvcWwb4BBdlwMHLOU5MBAE=;
 b=cdH9FJgfqAX7nDE6hTLihkNDT1GYDFBCmBHzkiy6b6/ktwKvRGBjr06aigIkFkfFwBos/v+ITOS/osx48imEgshMU8maI+s5ZMqCsfDHnCUgDdTNp5JOuRZTm2Lj29WSandMW4/jF1LJhI9yces13vwsTO/6HdbA/nrJkWfUV+s=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by DM4PR11MB5360.namprd11.prod.outlook.com (2603:10b6:5:397::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 06:21:24 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::39c7:55bc:f22f:ac8a]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::39c7:55bc:f22f:ac8a%5]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 06:21:24 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <regressions@leemhuis.info>, <peda@axentia.se>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>
CC:     <du@axentia.se>, <Patrice.Vilchez@microchip.com>,
        <Cristian.Birsan@microchip.com>, <Ludovic.Desroches@microchip.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <gregkh@linuxfoundation.org>, <saravanak@google.com>
Subject: Re: Regression: memory corruption on Atmel SAMA5D31
Thread-Topic: Regression: memory corruption on Atmel SAMA5D31
Thread-Index: AQHYL7i/by/02n1wA0qavxdAEojSfw==
Date:   Mon, 11 Apr 2022 06:21:24 +0000
Message-ID: <4a1e8827-1ff0-4034-d96e-f561508df432@microchip.com>
References: <13c6c9a2-6db5-c3bf-349b-4c127ad3496a@axentia.se>
 <f91c6f22-67a4-076d-d86d-6be1d14bc18a@axentia.se>
 <7edb467a-c8b4-fe29-9947-f71c655caa9f@axentia.se>
 <8484ce66-639c-03f5-c5db-3574ea26690c@microchip.com>
 <075a196f-79c2-0d58-15f9-ad5e33e2306b@axentia.se>
 <3beb80ad-d6f8-8c6a-e17d-e40a644bba07@microchip.com>
 <e47c155a-f25d-11b3-3339-b2bf71b886ce@microchip.com>
 <9e24034e-f586-a721-9031-179601a69abb@axentia.se>
 <7214ea3d-1445-c0fb-2620-cdc3d6167bcc@axentia.se>
 <b5c57978-212f-55c4-2f0b-b38a8f157ca3@microchip.com>
 <a024180a-493c-af20-0910-da30dd5fe364@axentia.se>
 <6d9561a4-39e4-3dbe-5fe2-c6f88ee2a4c6@axentia.se>
 <ed24a281-1790-8e24-5f5a-25b66527044b@microchip.com>
 <d563c7ba-6431-2639-9f2a-2e2c6788e625@axentia.se>
 <e5a715c5-ad9f-6fd4-071e-084ab950603e@microchip.com>
 <220ddbef-5592-47b7-5150-4291f9532c6d@axentia.se>
 <6ad73fa2-0ebb-1e96-a45a-b70faca623dd@axentia.se>
 <0879d887-6558-bb9f-a1b9-9220be984380@leemhuis.info>
In-Reply-To: <0879d887-6558-bb9f-a1b9-9220be984380@leemhuis.info>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 170de5a9-7109-4c8e-3763-08da1b8380d2
x-ms-traffictypediagnostic: DM4PR11MB5360:EE_
x-microsoft-antispam-prvs: <DM4PR11MB53602F05E5059FC0566048E5F0EA9@DM4PR11MB5360.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VclgqNHIZzR9yiVL2pKwkXKX4q5MTKisODdA/daCptniWtRVk7wauSqUqd9obI9AXCtSsq3nB7YPxyRnIqS2ylAGZ07KhT48kaSqzUdDktfsPlyY4EM08TCk2rQ4ES1K2+s7GkYIztqSlOazlXqU2XcV5YZsHv3OvroCpiR+oWxoP1yj0L6qnhKE3ChRNj0+dJ+du5IjAlq0rAxFSwf15xyp52GQz/vzTQyX3AZNSaOQ7bgLDBTl7JRnesrteQVxq/Plwog9IFjLgre0SImXeBZnXdkCSxtM6zrMAmS+Ch04hSGpirICcCgak9yb6T72ABg9R8gQwA33om+6umaP2HmnafQZrPxh9rXRkIEzocK2GKTGu52k1JXzvDpgtI3wsqXSEFcftPv+CmdoTRA7nbUnfuODAmtYoe23f/OjAD0BTp1KP24XhnFnivFEtrSORNq68QBO4d9o1OtdhiJ1O/7tP9ZG5CKGDVcQZUf1PtthTWWFLZOgxo7PryB0Eukwj8gYm2vYVgJWNNUwjcUgYdXgaT6mT5w5F8q4j0/gfvKLXcFfgkiyGF30sM6EKTSwTpeyhcb9u19yxCeKCb6X7+RiEMP3DnZU2iD6Svjsm5u3MAKsV3EhRfGOmuF96ErDx8DWeYVZUBswEFdujYYsOPxPU+uNT+WnZ/9VENy+u7ny8KpMsFOrNcm2+rpwYFLcsZO5wMFvRmzlUtFVZpQPxAFu5VAWy8dr3dtSBwDC0kUwoTAQxck5AyA2E1IgkqzTJgtd4IqiltApbuNYxNRTNywu8NG/gFKiGWaOzy6XI1EYFteI3C8eEBWih9D2RNXBk3rp+j5kvTy42B+mFKqSP7s3rATWJ87+X1ZbjtpAAKg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(91956017)(316002)(66476007)(66556008)(66946007)(966005)(6486002)(8936002)(76116006)(66446008)(71200400001)(5660300002)(110136005)(54906003)(53546011)(8676002)(4326008)(64756008)(6512007)(6506007)(31686004)(2616005)(186003)(26005)(508600001)(83380400001)(36756003)(31696002)(38070700005)(86362001)(2906002)(38100700002)(122000001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UmJYS29XcTRsSTNjVWY5Ujd5c0NPSzJNOTVnQUx4a3BlYndEUjRVYmUzUlVO?=
 =?utf-8?B?Q2lIdXVzZmxyOTFORHloeWJObjI4UkZwWG9XREhsK0NHcVZBVDBsb2t5UHJW?=
 =?utf-8?B?eWIwbFFkUHZOSmxEZEJxYWRSaWVkQUpsLzBIelN0NEVsaXNhV1BLM1k3MmFD?=
 =?utf-8?B?Tzc5L255WHdDN2NVdVJESVpWZ0taZG1vNUJpeExISXo4WVJkL1EvcVIwTTZ5?=
 =?utf-8?B?aXdqb0I2d0V1VTJRTlpZcW9vWFpOcUsyVkZSbUNMK2w2UWwrNlVhUGtzOG1l?=
 =?utf-8?B?eWZNMDJEL0QwTCtVUFdIQWgxeUVFYmJDNVVVNitidVIySHk2UzR3Ty9udFI2?=
 =?utf-8?B?elovajcrUjZLeVdKQTE1QWIwVHQzK2VweXlKajcrQy9FOEV5SHFaZ2U4ZlpJ?=
 =?utf-8?B?T0lROENYcWpYUjdIbDVIdTIwSUcwOG5vZ2dMeXFnUEFBeEREUHV6ZmVHMTkw?=
 =?utf-8?B?RDVyMEVhUURvRFVOdzRBVU45RjMvU3NVaWl5V1p6NElMN0NrbFI0cCtqWVdH?=
 =?utf-8?B?ZzNRRTB1NGdRdFFaVEw4SkdtM3AzQjQwVnNsbkwvTFNDSVZUdHdBZWsyNWFq?=
 =?utf-8?B?M2dXOVYwVHlUbjUzY3FnSEp1aURoQXpZb1NCR1NvYmZIYVRyZjhBcTB6RWZr?=
 =?utf-8?B?T242ZTJ1MmpzZnRCRG1JMXlibzBoSkZvamZuVXdQN1FjNGpMeUlSSml5empu?=
 =?utf-8?B?V0c3UndhY1VHMzY4UHZJdXhTQ0RDQVk4d1V0dVNLWmJseG9MNjQzVitjUGlB?=
 =?utf-8?B?YldIWHBnVkdPTnNDeTNyZEtTckxvVDR4SGZER1FtU09scWw4VElRdy92Zlc4?=
 =?utf-8?B?TkxNbDVvYlkycWhQblRkL3MrbHg0UlVNRTllblZBUnZhdU14YzlPUUZlRzNX?=
 =?utf-8?B?Y0xWU0xBVmdPVW1aN3lqVVZjZUNBbEk4WXVHeWlOK2kvckxYc2FkYzhYRHBk?=
 =?utf-8?B?am0yZlI5NGRiT1BQYk1sTGZkZjZBc0NicUs2bTFhcDUyWERlTGdqS1lXa0FR?=
 =?utf-8?B?cklkTnl5bGxGSlhZU0lxWE91V1QyL0V2Z1lsaWRpRHVoMDZlTFVmOEw4eTdQ?=
 =?utf-8?B?Wk5kS0J6MHpWdFNrSS9zVnlWOVNLODY3K0xzRW9IREg5N0lNbGNBRzM2d0tZ?=
 =?utf-8?B?dHJOdWdESFJyVkNvZjRubFN6eXZnbTJSMW5IQVJHa3BxdERTQWFBODVMeHpy?=
 =?utf-8?B?Wk1BbkszK3JqNUVPT0VnTGQzMFhtNTZiQVU4MDJJQzB3Q09wYkNYa2lKdy9R?=
 =?utf-8?B?d0VQZ05SYlVRMVk5OVkzbjFyTUx2RXlLNms5cFpqcm5xaDl2NkREUFRUcFhz?=
 =?utf-8?B?TzZIUUthak90clRzcThVTWNXSWpOcVBWKzlHVTRLMWNmeHBMWlRFTFBWYXB5?=
 =?utf-8?B?U2xUNXlMdjM3R3FBcXBEVytBMWZXVGNVVU52V2RIQzBQSFNza3FhOVFOYmtw?=
 =?utf-8?B?Mm9MMDZsNjJkUVdGUDhyOS9uMXRIN1dQRGpLUmU3Vkplc3pIZysyUnRCYUhJ?=
 =?utf-8?B?cXZ1alRxT0xRSDZEanZ2ak5URDJWK1FTQURjbHNTZ2IxRzkxNkc2bG5jVkFk?=
 =?utf-8?B?d1ZncG0xZFZsTzd4SU1GTzVzeHMzNHBQbkJoZmtudGRkcE02QmdNV2xDbDBX?=
 =?utf-8?B?UCswdXhYVVQxekVQRjFrSGxoYlU0bTlvbW52UWUwdEpZQ0xlYWZOWnFpaDZY?=
 =?utf-8?B?UE4rcUUwZFpKV0NtOUswSzFaaWEwK21vbmI5ek5sRkI3ei9nRTVBM0tWaHBN?=
 =?utf-8?B?dXRvQzhXc0JmVXpxT2dwNkxLSEpIUXNZRmdPam41RktHQUx5RVp2eWc1dXZm?=
 =?utf-8?B?SEdTV3p2SndXSmVYTlAwbWoxTURVdnlZUzUzZmQ2Yk1KRGpTaWdCb05FWmpS?=
 =?utf-8?B?NzJ5cUNLY0RvU2QwZjR1T3BDbDNsYVp4ajZvbEZ4MjZyaFlMc0lqVUpCbEt6?=
 =?utf-8?B?VlhBRTBCYU1DcWdrUFIvNk5RQm9BdDRqZG4vbWRkVU5SdDFBZTJndHlKaFVx?=
 =?utf-8?B?TkdMejlBUnhHbGpZTDRDZkxtYm9tTklWcnZoekZlaVBpeUU0U1JnVFUwZjFS?=
 =?utf-8?B?TEQvVFoxc0Q4K2JpeHA0UmI4MG9jaDVxaHViU1c1Q3dmWjFpc3RvQlpnbEFm?=
 =?utf-8?B?TlR2NFFNRXloamFpZzk2cU4xV2o3cjE4YzEybGFDWlJYbGh1SnJrRGJRWFRp?=
 =?utf-8?B?bkw0QytlSjFiVG51UWE0cTQ0Z1BTZ0pscXJJb0crMXB3aVZCK25hUG5wRk5l?=
 =?utf-8?B?Q09IaVNJbjg4c0MvUzJSYWowai9XMFpvNWl0S0lQcjJJMUNTa0svQWJaR0lP?=
 =?utf-8?B?V3l2cXIycDgvNDY2VlQ2UW51ZmhQN1pSNFlwdENQZ2tZcUFVQkpxVGFVUjVT?=
 =?utf-8?Q?p97ldrkhRw8xrUDU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C6509DB13EFEE94294C25B29C1A31899@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 170de5a9-7109-4c8e-3763-08da1b8380d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2022 06:21:24.0553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pmpDQnONDwWf7ehTYoWQIGl6tg67zM9J0Jmy01BbaqpAUD1BV3gXGp/iV2BE/aqev8TDp0u6jcDBrwXiDSTSHZU3fgAdHnqZIJyHjjCpSPE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5360
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiA0LzkvMjIgMTY6MDIsIFRob3JzdGVuIExlZW1odWlzIHdyb3RlOg0KPiBFWFRFUk5BTCBF
TUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBr
bm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IEhpLCB0aGlzIGlzIHlvdXIgTGludXgga2Vy
bmVsIHJlZ3Jlc3Npb24gdHJhY2tlci4gVG9wLXBvc3RpbmcgZm9yIG9uY2UsDQo+IHRvIG1ha2Ug
dGhpcyBlYXNpbHkgYWNjZXNzaWJsZSB0byBldmVyeW9uZS4NCj4gDQo+IENhbiBzb21lYm9keSBw
bGVhc2UgcHJvdmlkZSBhIHN0YXR1cyB1cGRhdGUgd2hhdCB0aGUgb3V0Y29tZSBvZiB0aGlzDQo+
IHRocmVhZD8gSXQgc3RhcnRlZCBhcyBhIHJlZ3Jlc3Npb24gcmVwb3J0LCB0aGF0J3Mgd2h5IEkn
bSB0cmFja2luZyBpdCAtLQ0KDQpIaSwgVGhvcnN0ZW4sDQoNClRoZXJlIGFyZSBzb21lIGNvbmN1
cnJlbmN5IGJ1Z3MgaW4gdGhlIGF0LWhkbWFjIChETUEpIGRyaXZlciwgSSdtIGhhbmRsaW5nIHRo
ZW0NCmFuZCB3aWxsIGNvbWUgd2l0aCBhIHJlc29sdXRpb24uIERpc2FibGluZyB0aGUgRE1BIHNo
b3dlZCB0aGUgYnVnIGlzIG5vIG1vcmUNCnJlcHJvZHVjaWJsZS4NCg0KPiBidXQgc2VlbXMgbm90
aGluZyBoYXBwZW5lZCBmb3IgYSB3aGlsZS4gV2FzIGl0IGZpeGVkPyBEaWQgaXQgZmFsbA0KPiB0
aHJvdWdoIHRoZSBjcmFja3M/IE9yIGRpZCBpdCB0dXJuIG91dCB0aGF0IHRoaXMgaXMgbm90IGEg
cmVncmVzc2lvbj8gSWYNCg0KTm90IHlldCBzdXJlIGlmIGl0J3MgYSByZWdyZXNzaW9uIG9yIG5v
dCwgYXMgdGhlIGJ1Z3MgYXJlIHRoZXJlIHNpbmNlIHRoZQ0KYmVnaW5uaW5nLiBNYXliZSB0aGV5
IGFyZSBqdXN0IGhhcmRlciB0byByZXByb2R1Y2UuDQoNCj4gdGhlIGxhdHRlcjogcGxlYXNlIGZl
ZWwgZnJlZSB0byBpbmNsdWRlIGEgcGFyYWdyYXBoIGxpa2UgIiNyZWd6Ym90DQo+IGludmFsaWQ6
IGEgZmV3IHdvcmRzIHdoeSB0aGlzIGlzIGludmFsaWQgaW4gdGhlIGxlbmd0aHMgb2YgYSBtYWls
IHN1YmplY3QiDQo+IA0KDQpXaWxsIGNvbWUgd2l0aCBhIGZvbGxvdyB1cCBhZnRlciBJIGZpeCB0
aGUgRE1BIGJ1Z3MuDQoNCkNoZWVycywNCnRhDQo+IENpYW8sIFRob3JzdGVuDQo+IA0KPiAjcmVn
emJvdCBwb2tlDQo+IA0KPiBPbiAxMC4wMy4yMiAxMTo0MCwgUGV0ZXIgUm9zaW4gd3JvdGU6DQo+
PiBPbiAyMDIyLTAzLTEwIDEwOjU4LCBQZXRlciBSb3NpbiB3cm90ZToNCj4+PiBbYnJpbmdpbmcg
dGhpcyB0aHJlYWRsZXQgYmFjayB0byB0aGUgbGlzdHMsIGhvcGUgdGhhdCdzIG9rXQ0KPj4+DQo+
Pj4gT24gMjAyMi0wMy0xMCAwOToyNywgTmljb2xhcyBGZXJyZSB3cm90ZToNCj4+Pj4gIEZyb20g
dGhhdCBhcnRpY2xlOg0KPj4+PiBodHRwczovL2x3bi5uZXQvQXJ0aWNsZXMvODg1OTQxLw0KPj4+
Pg0KPj4+PiBJIHJlYWQ6DQo+Pj4+DQo+Pj4+ICJLb3NjaGVsIGluY2x1ZGVkIGEgcGF0Y2ggZml4
aW5nIGEgYnVnIGluIHRoZSBVU0Igc3Vic3lzdGVtIHdoZXJlIHRoZQ0KPj4+PiBpdGVyYXRvciBw
YXNzZWQgdG8gdGhpcyBtYWNybyB3YXMgdXNlZCBhZnRlciB0aGUgZXhpdCBmcm9tIHRoZSBtYWNy
bywNCj4+Pj4gd2hpY2ggaXMgYSBkYW5nZXJvdXMgdGhpbmcgdG8gZG8uIERlcGVuZGluZyBvbiB3
aGF0IGhhcHBlbnMgd2l0aGluIHRoZQ0KPj4+PiBsaXN0LCB0aGUgY29udGVudHMgb2YgdGhhdCBp
dGVyYXRvciBjb3VsZCBiZSBzb21ldGhpbmcgc3VycHJpc2luZywgZXZlbg0KPj4+PiBpbiB0aGUg
YWJzZW5jZSBvZiBzcGVjdWxhdGl2ZSBleGVjdXRpb24uIEtvc2NoZWwgZml4ZWQgdGhlIHByb2Js
ZW0gYnkNCj4+Pj4gcmV3b3JraW5nIHRoZSBjb2RlIGluIHF1ZXN0aW9uIHRvIHN0b3AgdXNpbmcg
dGhlIGl0ZXJhdG9yIGFmdGVyIHRoZSBsb29wLiAiDQo+Pj4+DQo+Pj4+IFVTQiBzdWJzeXN0ZW0s
ICJzdHJ1Y3QgbGlzdF9oZWFkICpuZXh0LCAqcHJldjsiLi4uIFNvbWUga2V5d29yZHMgcHJlc2Vu
dA0KPj4+PiB0aGVyZS4uLiB3b3J0aCBhIHRyeT8NCj4+Pj4NCj4+Pj4gUmVnYXJkcywNCj4+Pj4g
ICAgTmljb2xhcw0KPj4+DQo+Pj4gZ3JfdWRjLmMgaXMgbm90IGJ1aWx0IHdpdGggdGhlIGNvbmZp
ZyB0aGF0IGlzIGluIHVzZSwgd2hpY2ggaXMgc2FkIGJlY2F1c2UNCj4+PiBpdCBsb29rZWQgbGlr
ZSBhIGdvb2QgY2FuZGlkYXRlLg0KPj4NCj4+IGF0OTFfdXNiYV91ZGMuYywgd2hpY2ggaXMgaW5j
bHVkZWQsIGhhcyB0aGUgc2FtZSBwYXR0ZXJuLiBCdXQgYWxhcywgZG9pbmcNCj4+IHRoZSBlcXVp
dmFsZW50IHBhdGNoIHRoZXJlIGRvZXMgbm90IGZpeCB0aGluZ3MgZWl0aGVyLiBJLmUuICh3aGl0
ZXNwYWNlDQo+PiBkYW1hZ2VkKQ0KPj4NCj4+IC0tLSBhL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMv
YXRtZWxfdXNiYV91ZGMuYw0KPj4gKysrIGIvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9hdG1lbF91
c2JhX3VkYy5jDQo+PiBAQCAtODYzLDYgKzg2Myw3IEBAIHN0YXRpYyBpbnQgdXNiYV9lcF9kZXF1
ZXVlKHN0cnVjdCB1c2JfZXAgKl9lcCwgc3RydWN0IHVzYl9yZXF1ZXN0ICpfcmVxKQ0KPj4gICAg
ICAgICBzdHJ1Y3QgdXNiYV9yZXF1ZXN0ICpyZXE7DQo+PiAgICAgICAgIHVuc2lnbmVkIGxvbmcg
ZmxhZ3M7DQo+PiAgICAgICAgIHUzMiBzdGF0dXM7DQo+PiArICAgICAgIGJvb2wgZm91bmQgPSBm
YWxzZTsNCj4+DQo+PiAgICAgICAgIERCRyhEQkdfR0FER0VUIHwgREJHX1FVRVVFLCAiZXBfZGVx
dWV1ZTogJXMsIHJlcSAlcFxuIiwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgIGVwLT5lcC5u
YW1lLCBfcmVxKTsNCj4+IEBAIC04NzAsMTEgKzg3MSwxMyBAQCBzdGF0aWMgaW50IHVzYmFfZXBf
ZGVxdWV1ZShzdHJ1Y3QgdXNiX2VwICpfZXAsIHN0cnVjdCB1c2JfcmVxdWVzdCAqX3JlcSkNCj4+
ICAgICAgICAgc3Bpbl9sb2NrX2lycXNhdmUoJnVkYy0+bG9jaywgZmxhZ3MpOw0KPj4NCj4+ICAg
ICAgICAgbGlzdF9mb3JfZWFjaF9lbnRyeShyZXEsICZlcC0+cXVldWUsIHF1ZXVlKSB7DQo+PiAt
ICAgICAgICAgICAgICAgaWYgKCZyZXEtPnJlcSA9PSBfcmVxKQ0KPj4gKyAgICAgICAgICAgICAg
IGlmICgmcmVxLT5yZXEgPT0gX3JlcSkgew0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgZm91
bmQgPSB0cnVlOw0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7DQo+PiArICAgICAg
ICAgICAgICAgfQ0KPj4gICAgICAgICB9DQo+Pg0KPj4gLSAgICAgICBpZiAoJnJlcS0+cmVxICE9
IF9yZXEpIHsNCj4+ICsgICAgICAgaWYgKCFmb3VuZCkgew0KPj4gICAgICAgICAgICAgICAgIHNw
aW5fdW5sb2NrX2lycXJlc3RvcmUoJnVkYy0+bG9jaywgZmxhZ3MpOw0KPj4gICAgICAgICAgICAg
ICAgIHJldHVybiAtRUlOVkFMOw0KPj4gICAgICAgICB9DQo+Pg0KPj4gVGhlIHRlc3Qgc3RhcnRl
ZCBvdXQgd2l0aCAzIGdvb2QgaGFzaGVzIHRob3VnaCwgc28gSSBnb3QgbXkgaG9wZXMgdXAuIEJ1
dA0KPj4gbm8sIGl0J3MgYWJvdXQgdGhlIHNhbWUgZmFpbHVyZSByYXRlIGFzIHVzdWFsLiBJIGhh
dmUgdGhlIGZlZWxpbmcgdGhhdCBJDQo+PiB3aWxsIG5ldmVyIGFnYWluIHRydXN0IGEgc2luZ2xl
IHNoYTI1NnN1bS4uLg0KPj4NCj4+IENoZWVycywNCj4+IFBldGVyDQo+IA0KDQo=
