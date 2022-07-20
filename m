Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A6157B2F8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 10:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240501AbiGTIa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 04:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240511AbiGTIaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 04:30:24 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E391041982
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 01:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658305819; x=1689841819;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=l+Z9QRgPijYUXuqI53AW0U/LImlLz7Z8zYB97lTTWqQ=;
  b=jAtTSIQHXOVO8iY4VB7lPxMJwiMe1qoKQ9tbDvX12ThLPJsU1Lf7W2kH
   Hge7qM1o+0smLAkSa36MunKwxXE3wMOqR7gMR1holpG/5ljfBR20dku0F
   QbYodxKq5ch4X6S1F0qkSfAe7TdcBo78rvWPmdb7bKCPLeWCuWjxeGZ51
   Yfrnr0a67hU1TEfHi+NpNmzkqxPZePns4lamrCCc/wfatMip3jUNhsFMv
   VuD5APvOAbeJ8B8pslK71V9TyGC6bHaMkNXOWH1NkUEAd0tILcaRkvo+O
   PIf/KOi/uMDQS1Tu5CbYlc2J3eJjLHDqU/bRdx2IrxDDHiyNusYqOJ3+W
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,286,1650956400"; 
   d="scan'208";a="172869709"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Jul 2022 01:30:16 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 20 Jul 2022 01:30:15 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Wed, 20 Jul 2022 01:30:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O0zhat6MxhHPiMrU7EBhLCWmcqLZMXwKexeRnaqHPwz060H5do7NpM99BX+MAU8pliwMYriVmv3+nTrKnm33I7beBZUfL+R1M/+dgGq5VrDxQZ+uGPyFZVyxKHVG50PFKA/pg/mifjbu2Ip9ojBwf3nBmd3u0vX+69wA9swNByhLBDT1tVMjgApZb/k+THthlpb+7XnnmtETxskstMxZ+AJof+nNtluhIfHUCHG4AxSOUjj5hjUPhNu1oE0eQ68yYRwIW06pfF1k1/Wpx8y5l9JzAsvqvw6ElMTLBLWoIsGBKeP8hwwxdGHB3pwx3hVdTyo1SRgxcPyYr34JTpNiwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+Z9QRgPijYUXuqI53AW0U/LImlLz7Z8zYB97lTTWqQ=;
 b=Uu8rFtgoJqVoH8Nv8r7lkYnTippAh5a/JzQ9yeqQcTH2OkAMPl7IXR+q5pLGlq/7BA6Hcoa8fy2yRhltReMbQqJrTbLDV3/yg5q5COW/Ne2k+41ZTae3hut4JPpfKGrXi2K4H9GpbBqzAWtgKO/PZJNcUyKh5hAwDTHf3YFCXvHq438hrSPzYWA+kR6zmNlxB6Wwval8GbExFFQGpLVwc0PCNNKE/kpp5bLHVqfUy3xs/lwZAHofJF/b32Zt4lkwnMvlMYUOuswblasRVbj3i137NhGBdT+rhm4uUVSHNelysgkSF5g1I9F7zT4hW0adjJWQpU6BednRixxhc1qC7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+Z9QRgPijYUXuqI53AW0U/LImlLz7Z8zYB97lTTWqQ=;
 b=fvlcnYS22HIVxEp+Vdg9LP2s8oynfdtHH515dRtU7800kpQzxsCUwt+N/UIViQ5L68+UECBI8IR+2AWLI1pVZKpOhAJoyJ/4+/VWpRW839hJKBTHs6vonQ62ninuD/MstgJ0cT9bWko2BAIojuCQYEZKwprH5up2QP9PRJmROWI=
Received: from CY4PR11MB1960.namprd11.prod.outlook.com (2603:10b6:903:11d::21)
 by MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Wed, 20 Jul
 2022 08:30:10 +0000
Received: from CY4PR11MB1960.namprd11.prod.outlook.com
 ([fe80::80c4:1a95:649d:2ee0]) by CY4PR11MB1960.namprd11.prod.outlook.com
 ([fe80::80c4:1a95:649d:2ee0%10]) with mapi id 15.20.5438.023; Wed, 20 Jul
 2022 08:30:10 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <clement.leger@bootlin.com>, <linux@armlinux.org.uk>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 2/2] ARM: at91: setup outer cache .write_sec() callback if
 needed
Thread-Topic: [PATCH 2/2] ARM: at91: setup outer cache .write_sec() callback
 if needed
Thread-Index: AQHYj3DEluxF7kPq7kujGFPzpA3vka2HBvaA
Date:   Wed, 20 Jul 2022 08:30:10 +0000
Message-ID: <26162dc4-3724-2fe4-728e-79390de9de66@microchip.com>
References: <20220606145701.185552-1-clement.leger@bootlin.com>
 <20220606145701.185552-3-clement.leger@bootlin.com>
 <7f89d904-75d8-9dff-2d11-7511867de2d8@microchip.com>
In-Reply-To: <7f89d904-75d8-9dff-2d11-7511867de2d8@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9924588e-df8e-486a-62f3-08da6a2a0f3c
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kl4v2nMQN7Z5eJB9IiQUJfGlhpnm/Kj8UqyWccGddyFyiFGyPGBK8uLZasvrdSSLyxkzDEa13sW1r840+iA1LaFaZkK35F3qivX5ThJSfMig31ZkofIFD9PDBJldFOkzpUcacK2j46sLnI510vsrNcE+l3NPyWu3GPr8Wl+d6fWvefrGWw2U3CA6Pviq0+Che2IkWfy+85CKvWNnBkB/n1ipArJ5kCgVG4yKFuYoFT0KdODKUCOrdcq1Ttggor6LWJbsNcLO7H/jtP95EED1YrOJR9aLdxYmVmsRSnA4AYELmrlNrOd4qLHBFKQm1IOe3FUBpylNyfdaDtgYQuoNF12lNAx5HctnkxyR4r5IKPJnUTX+LqUnWfXyILY5E5yCFzicOe4xuc6YLLYov1kRX38CqvdV9ftB1YbhiRKoLdPu+eq3iuevN/VsrrvknvSyLOD2+0KMMs/q1541/KnMT3QR5M6zjbcTpPeNlFGLh25Ktpsb9+kcYUVE05BZ+L6hcT5qXRJZaTn2pM6bjh7DDlgHgRfT3h3/2h/ZpeKnLT/X9nU+1mziYNzpEcTicVo1gFIrHW/7YyYkh8Xm/vxPsXw0I4is7y89ja36aBIWNbJLumQ7PtVjLwDxl+rDtLjWCZWlV7vsB69l/4gRSDoF7mHmFeoINbpiDCJJe6tQ7JpILZqy4/gcd//CJS3RxecJ3jrcNCplTjqGfjkx6u2wFXeXOYDn+J+xAzm0WNB0M0ITn8Gk4mRwfV1j6lKcD/wJqJX3KL5isS8WkoWd9Kh0b9DQ9Rl6roO2OLQsFLpFJEbnaFQLMHJckHsWT0lj70up9r1ICyKQvLDJ/BO3x/5wwTWEqJsrYM830x8oG+H3m26mwziQEX3HzMcWPj4l3DdspdzKgI0n1rCqOOG6cLOMHw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1960.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(39860400002)(376002)(136003)(346002)(396003)(66476007)(66446008)(5660300002)(8676002)(8936002)(64756008)(91956017)(66946007)(66556008)(76116006)(4326008)(2906002)(110136005)(38100700002)(122000001)(36756003)(31696002)(86362001)(38070700005)(71200400001)(6486002)(478600001)(54906003)(316002)(41300700001)(66574015)(186003)(26005)(53546011)(6506007)(2616005)(6512007)(31686004)(142923001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?STEvNk1qQUk4VzdZakEyR2crUEMzaGVpcXdwRWIwYUU1aUswc0JmV25lSUhG?=
 =?utf-8?B?Mm9RVkE5OXUyT1gva3JDUnVNS0hqdGEvSEh3MHp0WmxyV1NpbUtjMXVlSW5R?=
 =?utf-8?B?bjZTUk02d2QrU0h4Umt5K01LUldNL3hYclRuc1lkOWhUK3JnU1hhdnplUGZm?=
 =?utf-8?B?UStWeUNjYlU2UlUvN0hmZ2lPZlBINEIzdURWaTJMUkZLcTFHakVQZ2t6cHcy?=
 =?utf-8?B?NVltME9qQXVvOE5wdEpEbUcwRXRUVWxJWGdNSFdkQVVlOEU4b3RtTzg3UGZz?=
 =?utf-8?B?STlRS05JZnc5NDU3a0lZMWU4QkZQZGMvcUtoSDJxQ2V2anQ1Wm5aa3hRbGdG?=
 =?utf-8?B?QWw1VFZzVG5UUjNkSlZhZnMxVkQxcTQ0M2RSeXU1Ymg1bzhmeXhiOUhGNUtI?=
 =?utf-8?B?SzMyaFB4TFZZQTJhSm5odlFKWEZLRnMwbzlZVy90elBSNWx0Zm1hcG1LTEVa?=
 =?utf-8?B?ZnBBTURoczk0TGh0RG12aitXTUdPV3M1dy9pZWlhYUVxS1ZLVTVNbEpBZldS?=
 =?utf-8?B?bGpCVkRUMHFBREJ4bEV3dVdwWE1sakRMSXRmcWVzVUFPYS9zdlFNZWVtQ2Vp?=
 =?utf-8?B?SFhDNnVDSnJobmJYQnk3TkdyQVNoTlZUcWVibmxCc3RHT3FhRHQzZ1l0QkdF?=
 =?utf-8?B?cFozNWJHNlBRVm8vWWc2RlhWc2VWdmxjUTN3cUcxbENvdWJkbXlYSTNPSTE2?=
 =?utf-8?B?ckVaUll0bWE5eGhFZDFocjZMNUZrNVZBMndaSVVwbi91V0dEUnpGeExBVEN0?=
 =?utf-8?B?Ykp5Y3AzWjlIWU92aWI4S1JLR1EyYUpUb05GMkhJd25sd2M1ZDdERlBRTVpI?=
 =?utf-8?B?cWdUbTlhYk0vZU1qa09VYllicWxUZ2F4MkNLVmQ0Tmxta1czMlhlakNHT3Ew?=
 =?utf-8?B?OW85cDc4TGJEcVZYZkx5UVRISFZ1Zm0vaG8xZFRWZFZNcHgvSnUzeFNzREZ2?=
 =?utf-8?B?dUtYd2ZPMkFuNE0vUlVwTHVnL0t5aGE4c3dWRDVGQ2pTSGM3WHJuQ0xmUlhz?=
 =?utf-8?B?bnBkZWRwMThwMnFWUGQwSDQ0c3FPZmxGRHRmTmZoamdheDJONXBscERQM1JN?=
 =?utf-8?B?b2pJRHh3ajczY3JzaGx5anJSNGtpdHpzcWRxd1pIcjlVRXJOTlRoUGlhbWhM?=
 =?utf-8?B?b2tsWmxDTyttb25GcCtjRDltSnFDajlFQ3lCc1FNOUNFTU51QVlXWjIvcTJy?=
 =?utf-8?B?c2l6YmxtMVp6SVR3NnI2emsyRnhvOE0zUDJ2bmpzSXNZZDl0N2VxM3orZ0lh?=
 =?utf-8?B?VXpyUWhEcVBsTFhPelF4OEtCWHZTSGNRRTlyTDVYOTZhWjVsd3MxNmdIakN3?=
 =?utf-8?B?WTNlTncvRENDQTZZbUdURUFNaXJ0SUdaZVV5WjB0VFNrS2xhZUgwZHV6eDQv?=
 =?utf-8?B?MGx6WWVlaElTcVJ6NVRpSHJwR3RxRWZwaUZyMFdldE4xT3ZlZmdrV25VZ09E?=
 =?utf-8?B?NytVWW5CdzZqRVNrTTZvQUFPSTVPU01ZY0hmU2doY3hqU2NQMjREUUJXTVlE?=
 =?utf-8?B?emlCVUZwMkVIMmFTTnNiSXlvMytLMk8remNoclJNMW5wWGZjUjVuSStDV3F3?=
 =?utf-8?B?TXpLOUVoVkRoZTkvazFTRTM0RFRHYTFOUndVcHdYSytyZEkzYmNUT0xXaHN4?=
 =?utf-8?B?aTE2UXRRVG1MNzF5NTYvK25YKzlIdjZHZ2RodXM2V3JBQjFKdXdjcitRc2Jp?=
 =?utf-8?B?UE5RNHd0WXV1Z2ZRSmlNSTF1RHhEMFZEWXZKYm1CQ0lucXFpTDROamlCUkd0?=
 =?utf-8?B?WHp5bVpwRDFHZWFLM2tTdjQvczArbWhkQW1RaitSWmpHRGppQTVnYVorY25w?=
 =?utf-8?B?TzRrUTllaUZzajdaSmRKbzFZeHR0bEdXNjYwSlN6YnhlNW1DUFpaOUxHS0Ix?=
 =?utf-8?B?R3ZLN0FCbSszZWhNTUhZQUIxSXFLdGlZRnVlWWtnWlhjcGFLaXZMa0RFY2Jl?=
 =?utf-8?B?cm9vRkJtaStURUtFeGdwd0JNOG5ERitZWndSSXZJcklOcWJRZkYrWDRITFo4?=
 =?utf-8?B?cEtYRVBaU0pSS1hEVXdqeGlqQURiMU1QQ3VSeGtIQXdaN3ZmaVhjamowb1dQ?=
 =?utf-8?B?aDIvU2JZNHdROEpnR3EwZUJoUFZSVEo1U2F5RDlsaGtreG5oVDhEODM0a1Uz?=
 =?utf-8?B?bXdWVWR3WGdMVXZYVTdWVGdlNy93ZHdoVFZxU1U2RmJ3Q3p3ZUNzQUdCR0RJ?=
 =?utf-8?B?YVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F6F2CF96916DBA45A1DCB29454DE5507@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1960.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9924588e-df8e-486a-62f3-08da6a2a0f3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 08:30:10.2507
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SjvZ10NTVE/gH5rcn7jlLssL2gndBa6QQIpl6iJhWUnhPCgEizb3AfTCc4vsq5qnZDEDMt7QKGXxWSisUOCn0raaGVNJDz/GMCUKTNEam4g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1392
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDQuMDcuMjAyMiAwOTozOSwgQ2xhdWRpdSBCZXpuZWEgLSBNMTgwNjMgd3JvdGU6DQo+IE9u
IDA2LjA2LjIwMjIgMTc6NTcsIENsw6ltZW50IEzDqWdlciB3cm90ZToNCj4+IEVYVEVSTkFMIEVN
QUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtu
b3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPj4NCj4+IFdoZW4gcnVubmluZyB1bmRlciBPUC1URUUs
IHRoZSBMMiBjYWNoZSBpcyBjb25maWd1cmVkIGJ5IE9QLVRFRSBhbmQgdGhlDQo+PiBzYW0gcGxh
dGZvcm0gY29kZSBkb2VzIG5vdCBhbGxvdyBhbnkgbW9kaWZpY2F0aW9uIHlldC4gU2V0dXAgYSBk
dW1teQ0KPj4gLndyaXRlX3NlYygpIGNhbGxiYWNrIHRvIGF2b2lkIHRyaWdnZXJpbmcgZXhjZXB0
aW9ucyB3aGVuIExpbnV4IHRyaWVzDQo+PiB0byBtb2RpZnkgdGhlIEwyIGNhY2hlIGNvbmZpZ3Vy
YXRpb24uDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogQ2zDqW1lbnQgTMOpZ2VyIDxjbGVtZW50Lmxl
Z2VyQGJvb3RsaW4uY29tPg0KDQpBcHBsaWVkIGl0IHRvIGF0OTEtc29jIHdpdGggYWRqdXN0bWVu
dHMgZGVzY3JpYmVkIGluIHByZXZpb3VzIHJlcGx5LCB0aGFua3MhDQoNCj4+IC0tLQ0KPj4gIGFy
Y2gvYXJtL21hY2gtYXQ5MS9zYW1hNS5jIHwgMTcgKysrKysrKysrKysrKysrKysNCj4+ICAxIGZp
bGUgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9hcmNoL2Fy
bS9tYWNoLWF0OTEvc2FtYTUuYyBiL2FyY2gvYXJtL21hY2gtYXQ5MS9zYW1hNS5jDQo+PiBpbmRl
eCBkZTVkZDI4YjM5MmUuLmQxYTllOTQwYTc4NSAxMDA2NDQNCj4+IC0tLSBhL2FyY2gvYXJtL21h
Y2gtYXQ5MS9zYW1hNS5jDQo+PiArKysgYi9hcmNoL2FybS9tYWNoLWF0OTEvc2FtYTUuYw0KPj4g
QEAgLTksMTMgKzksMjcgQEANCj4+ICAjaW5jbHVkZSA8bGludXgvb2YuaD4NCj4+ICAjaW5jbHVk
ZSA8bGludXgvb2ZfcGxhdGZvcm0uaD4NCj4+DQo+PiArI2luY2x1ZGUgPGFzbS9oYXJkd2FyZS9j
YWNoZS1sMngwLmg+DQo+PiAgI2luY2x1ZGUgPGFzbS9tYWNoL2FyY2guaD4NCj4+ICAjaW5jbHVk
ZSA8YXNtL21hY2gvbWFwLmg+DQo+PiArI2luY2x1ZGUgPGFzbS9vdXRlcmNhY2hlLmg+DQo+PiAg
I2luY2x1ZGUgPGFzbS9zeXN0ZW1fbWlzYy5oPg0KPj4NCj4+ICAjaW5jbHVkZSAiZ2VuZXJpYy5o
Ig0KPj4gICNpbmNsdWRlICJzYW1fc2VjdXJlLmgiDQo+Pg0KPj4gK3N0YXRpYyB2b2lkIHNhbWE1
X2wyYzMxMF93cml0ZV9zZWModW5zaWduZWQgbG9uZyB2YWwsIHVuc2lnbmVkIHJlZykNCj4+ICt7
DQo+PiArICAgICAgIC8qIE9QLVRFRSBjb25maWd1cmVzIHRoZSBMMiBjYWNoZSBhbmQgZG9lcyBu
b3QgYWxsb3cgbW9kaWZ5aW5nIGl0IHlldCAqLw0KPj4gK30NCj4+ICsNCj4+ICtzdGF0aWMgdm9p
ZCBfX2luaXQgc2FtYTVfc2VjdXJlX2NhY2hlX2luaXQodm9pZCkNCj4+ICt7DQo+PiArICAgICAg
IHNhbV9zZWN1cmVfaW5pdCgpOw0KPiANCj4gV2l0aCB0aGlzLCBjb3VsZCB0aGUgc2FtX3NlY3Vy
ZV9pbml0KCkgaW4gc2FtYTVkMl9pbml0KCkgKG5vdCBsaXN0ZWQgaW4NCj4gdGhpcyBkaWZmKSBi
ZSByZW1vdmVkPw0KPiANCj4+ICsgICAgICAgaWYgKHNhbV9saW51eF9pc19pbl9ub3JtYWxfd29y
bGQoKSkNCj4+ICsgICAgICAgICAgICAgICBvdXRlcl9jYWNoZS53cml0ZV9zZWMgPSBzYW1hNV9s
MmMzMTBfd3JpdGVfc2VjOw0KPj4gK30NCj4+ICsNCj4+ICBzdGF0aWMgdm9pZCBfX2luaXQgc2Ft
YTVfZHRfZGV2aWNlX2luaXQodm9pZCkNCj4+ICB7DQo+PiAgICAgICAgIG9mX3BsYXRmb3JtX2Rl
ZmF1bHRfcG9wdWxhdGUoTlVMTCwgTlVMTCwgTlVMTCk7DQo+PiBAQCAtMzAsNiArNDQsNyBAQCBz
dGF0aWMgY29uc3QgY2hhciAqY29uc3Qgc2FtYTVfZHRfYm9hcmRfY29tcGF0W10gX19pbml0Y29u
c3QgPSB7DQo+PiAgRFRfTUFDSElORV9TVEFSVChzYW1hNV9kdCwgIkF0bWVsIFNBTUE1IikNCj4+
ICAgICAgICAgLyogTWFpbnRhaW5lcjogQXRtZWwgKi8NCj4+ICAgICAgICAgLmluaXRfbWFjaGlu
ZSAgID0gc2FtYTVfZHRfZGV2aWNlX2luaXQsDQo+PiArICAgICAgIC5pbml0X2Vhcmx5ICAgICA9
IHNhbWE1X3NlY3VyZV9jYWNoZV9pbml0LA0KPiANCj4gVGhpcyBpcyBmb3IgdGhlIGdlbmVyaWMg
ImF0bWVsLHNhbWE1IiB3aGljaCBjYW4gYXBwbHkgYWxzbyB0byBzYW1hNWQzIG9yDQo+IHNhbWE1
ZDQuIEkga25vdyB0aGlzIGlzIGhhcm1sZXNzIGZvciBmdW5jdGlvbmFsaXR5IChleGNlcHQgbWF5
YmUgd2hlbiBvcHRlZQ0KPiBpcyBpbiBEVCkgYnV0IGRvIHdlIHdhbnQgaXQgaGVyZT8NCj4gDQo+
PiAgICAgICAgIC5kdF9jb21wYXQgICAgICA9IHNhbWE1X2R0X2JvYXJkX2NvbXBhdCwNCj4+ICBN
QUNISU5FX0VORA0KPj4NCj4+IEBAIC00MSw2ICs1Niw3IEBAIHN0YXRpYyBjb25zdCBjaGFyICpj
b25zdCBzYW1hNV9hbHRfZHRfYm9hcmRfY29tcGF0W10gX19pbml0Y29uc3QgPSB7DQo+PiAgRFRf
TUFDSElORV9TVEFSVChzYW1hNV9hbHRfZHQsICJBdG1lbCBTQU1BNSIpDQo+PiAgICAgICAgIC8q
IE1haW50YWluZXI6IEF0bWVsICovDQo+PiAgICAgICAgIC5pbml0X21hY2hpbmUgICA9IHNhbWE1
X2R0X2RldmljZV9pbml0LA0KPj4gKyAgICAgICAuaW5pdF9lYXJseSAgICAgPSBzYW1hNV9zZWN1
cmVfY2FjaGVfaW5pdCwNCj4gDQo+IFNhbWUgaGVyZSBleGNlcHQgaXQgYXBwbGllcyB0byBzYW1h
NWQ0IG9ubHkuDQo+IA0KPj4gICAgICAgICAuZHRfY29tcGF0ICAgICAgPSBzYW1hNV9hbHRfZHRf
Ym9hcmRfY29tcGF0LA0KPj4gICAgICAgICAubDJjX2F1eF9tYXNrICAgPSB+MFVMLA0KPj4gIE1B
Q0hJTkVfRU5EDQo+PiBAQCAtNjAsNiArNzYsNyBAQCBzdGF0aWMgY29uc3QgY2hhciAqY29uc3Qg
c2FtYTVkMl9jb21wYXRbXSBfX2luaXRjb25zdCA9IHsNCj4+ICBEVF9NQUNISU5FX1NUQVJUKHNh
bWE1ZDIsICJBdG1lbCBTQU1BNSIpDQo+PiAgICAgICAgIC8qIE1haW50YWluZXI6IEF0bWVsICov
DQo+PiAgICAgICAgIC5pbml0X21hY2hpbmUgICA9IHNhbWE1ZDJfaW5pdCwNCj4+ICsgICAgICAg
LmluaXRfZWFybHkgICAgID0gc2FtYTVfc2VjdXJlX2NhY2hlX2luaXQsDQo+PiAgICAgICAgIC5k
dF9jb21wYXQgICAgICA9IHNhbWE1ZDJfY29tcGF0LA0KPj4gICAgICAgICAubDJjX2F1eF9tYXNr
ICAgPSB+MFVMLA0KPj4gIE1BQ0hJTkVfRU5EDQo+PiAtLQ0KPj4gMi4zNi4xDQo+Pg0KPiANCg0K
