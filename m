Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 571155428E5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 10:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232592AbiFHIFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 04:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233788AbiFHIDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 04:03:46 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DDE23096B;
        Wed,  8 Jun 2022 00:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1654673707; x=1686209707;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=7aRsnFZz4gHBdRbIHKJ+yKsseolLgNjIl1t0vD4RxZs=;
  b=u3HWSA08RaWhgOYkCWYGCHgSO7uWMpGlw9p8UVBC00ap9v5jXm+xxJj+
   Fx/q7PqphmHHPbmxOGO0AtsEb+iGTbtRJF0FEGmfCstnkxLx82p179mqi
   3R/2n3v/GVso9yklWIZehV7G6ytXk9sPm9I3DJpFTh0tnEh0hjsomNdTT
   7/coT2eA47cqbzkxElYFu62SbJH1lsB9Ca5z4cFPXq8n2SXgnyLo6VZST
   0KbPAE3U+LTWDvyRmrxfKe372DpYQrZJ8fgIsqhVmKkjo+U1MNHVE0UTe
   0iqpQIGnrBhB4xNIo92QocA8JzREBdBD5IpJwR/NqtDXgneBd4DPhd8kn
   g==;
X-IronPort-AV: E=Sophos;i="5.91,285,1647327600"; 
   d="scan'208";a="177024968"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Jun 2022 00:35:06 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 8 Jun 2022 00:35:07 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Wed, 8 Jun 2022 00:35:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FQQ6O3lGVsW9Qcc1deRKiqPOcM8BomYky8gXg0MXsUoJvKoekofKMAgn1PrRQKM+ba5gd0xUulFBGSYEE4mnqKRPMEYEhPVFq7lbdxPLMeGIbwivH4kmcZ3f+xBw85tOZSMb/qR2u1K8p6lmBwrww/oG6/0AWIXTnuIKWmyyHD/0lJX2XI8gm9FTJExhfxR8Up6dEEPH6fBJCvPn+j8hZVG/PfQeijoqbfJcZsr1ix0V9/jsuR1RiWgmUAHgA0Lrx8pHI0e7ymI6iJYgA7QkJEAaku1c7b4heNyGd/17hSTW/u4OBRJwbWdNDUsk8n5fgyCucQh0C2jHwhHoSuE+/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7aRsnFZz4gHBdRbIHKJ+yKsseolLgNjIl1t0vD4RxZs=;
 b=S1Cq7DvbLIqkRldunDEeKn2OFc4MAhCLycM7RR6QOlVXp882skNAHGH45FyOznv0sTjr0ALh/JzoEDkK03tKfElBDg7VmCKEKdcUceOpTcYUC8O98GdlRT5h9aIX36LTrCMYjYxOIJ7PvuUIyeKOdAG0c1ni3VtsL8iT3yA+4fz9xTWtST2Tr8zbTJLJBtcdtU4mjd/cYRvqQF/HkyRrsQq0v29P4S2hKXx3rH6Iiv4Cb8f4o/Hk6DAympPnPTqFMzzM/WTJlM826rBEsJKQOcqX/dnsh8o6ftWTLGNx069CADEEnBvFhCdkJ2TMXUCr3tVdfr3KmrYrz0SSHjYpUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7aRsnFZz4gHBdRbIHKJ+yKsseolLgNjIl1t0vD4RxZs=;
 b=RA0Op2VmkDO4Wkg9PfRhth/j60YOyhjqjsZsHGwBKbNojMrjCbbChLnpg9U8143bLHXAmWlP6XZB4a6b3fbHwwYLfQS+Hrl0bwiXGM1O0JsULzT2niU4PEbUqZr8uS4oa5JSHLIo+Yta86PA2ImBa8zp9wlIdMzyfTwwyJkKT44=
Received: from CY4PR11MB1960.namprd11.prod.outlook.com (2603:10b6:903:11d::21)
 by PH0PR11MB4888.namprd11.prod.outlook.com (2603:10b6:510:32::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Wed, 8 Jun
 2022 07:35:02 +0000
Received: from CY4PR11MB1960.namprd11.prod.outlook.com
 ([fe80::457f:8e4d:4bc1:b997]) by CY4PR11MB1960.namprd11.prod.outlook.com
 ([fe80::457f:8e4d:4bc1:b997%12]) with mapi id 15.20.5314.019; Wed, 8 Jun 2022
 07:35:02 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Kavyasree.Kotagiri@microchip.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH v2 3/3] mfd: atmel-flexcom: Add support for lan966x
 flexcom chip-select configuration
Thread-Topic: [PATCH v2 3/3] mfd: atmel-flexcom: Add support for lan966x
 flexcom chip-select configuration
Thread-Index: AQHYewpD6TYRiClo40O9i0W3EvVFaw==
Date:   Wed, 8 Jun 2022 07:35:02 +0000
Message-ID: <9cf14336-16c3-5df5-b235-3f988d8b5151@microchip.com>
References: <20220607144740.14937-1-kavyasree.kotagiri@microchip.com>
 <20220607144740.14937-4-kavyasree.kotagiri@microchip.com>
In-Reply-To: <20220607144740.14937-4-kavyasree.kotagiri@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7d700c8b-be15-42d9-d44e-08da49216635
x-ms-traffictypediagnostic: PH0PR11MB4888:EE_
x-microsoft-antispam-prvs: <PH0PR11MB488818EE4B17064EBB9B125C87A49@PH0PR11MB4888.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zCZd4ZHkf35ZO8l2jB02CvBx3R8lwwmdRUXDsSlmDuUxO4yDVOeLU9qFyJnekg5uY+0VnTDO0+DyxZkIUtl+cXmyHeyPj5H2zB+TbeSmpz55KL2al3w4NGuRrBnP3YIG0l6Ts5FYmo+yf4NV5IH+4/SQvpUoAQUtU3LK/HnuVmChq9A6vV5qi4KGcbcW8A9XIKYL+qLAPW4kI/G5wYudcEnUHXnsXvFIHQCTU/8iTLwie2kOoACTuMactpuJy+t1Jvthqpf3/Bh1VDmd8KHfIoqNJEFnopTxP2HDrlKhV47acnfAD/KQEIgQ1V/deQJxjk4YrLsioRVCryufE3O3t1ekBeJXRdv3RiOtlaaWpA/LDhqVEhUt6uL2Hcxh7yQezyO/j7wJCmdmSjx80G8OA+JztRdIlm9tIB0YiLoGIjwHEFcDz6BIRgWQKwp5iS5cbNuT2GnhaqKrFOHlI36Cop8hUdLA/u4Pr1UgYFXNONKgjxWZY3NxgpacZkfb1sMVC//LSubIwtINyBAO6ePiGWHvvKiA77O/CkHac8VQjYpqTWsgUaGGrSWa0TmAAhYLon6egWKzxApuHkw7ntKs2S/g8ORCguiLHS3U+Odwh2ZAna5dzExgn0CsOJN9rhZn1VDDPGFZ7QHD1YOsOLS6zzLVsWBZy/RanPJ1GNgbBd4SnO5VxuG3mxrwDS21rnsCYXsQ/bM9VCo1tfC3q1aZ5fcDfoxx+4LMsWY+sxCpZV/O1ILLKzVMmukISGXFlgzqM7AuigCm1+AcewnGzlBtyA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1960.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(2906002)(122000001)(186003)(6486002)(83380400001)(6506007)(2616005)(107886003)(31696002)(86362001)(53546011)(38100700002)(5660300002)(508600001)(8936002)(6512007)(316002)(91956017)(71200400001)(8676002)(4326008)(66556008)(64756008)(31686004)(76116006)(66446008)(36756003)(66476007)(66946007)(38070700005)(110136005)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q0k2eWFvUVhkRHlvZXpIcE00VldLNHlFQmdEa3F3Uk9uMkMvSnhTWWJoK1d3?=
 =?utf-8?B?TGpHdEg1QVRmTU5ITXNkeDZyQ3F6N251eitLdkQybExtSi9YUkNvajZmSzlR?=
 =?utf-8?B?MVFLekpVdWl6d09Ka3VzVkJuZEtubUsvZEhzM3o0cFJDUkVrSXZzOWlMeXRP?=
 =?utf-8?B?VXhUM3gzNm5BTlVBVmwvSGExVUxjZUJqWG9nUDEzQ2FXYmtPMVlWZ2NiMytw?=
 =?utf-8?B?YjhaODE4Mjh0TWlxOS8rVTBpSTNCTjBidDRHaGtmOHkrR0tnV3ZhVlVVMlV0?=
 =?utf-8?B?cnI5dC9hREVBdkdLeC9RdlhtWkMyWFlVYkdUM2lMZ3FjMVVyRXFqdGJaUlov?=
 =?utf-8?B?Nmp3NTdIRFpoNnpSdzRSOFY2d1dSN2VxTmoxSVpaZG01bXY2MlAyWVROdWsv?=
 =?utf-8?B?NUpGN1RvTTdRajNEVCtYdFVUaEhTcVlHWWU1STZCb3J2NldYSGtVZ3Z1ekFD?=
 =?utf-8?B?VHVDUTYyMmVwdmxRSVM1eWxGNC96Yjh6RGlYQXBvbUMveFlUVmhZbHFhakhT?=
 =?utf-8?B?QVRndkNuZThtZTMwendTU3BVRkNPOEhvR3pheXdCczkrbzZESTRnV3gwUDlq?=
 =?utf-8?B?TENRRW9VT2FZVm5tT3cwU0szek1Ta2tXcWhLSERMYTBLRUtESDYrMlNIT1Z4?=
 =?utf-8?B?RGZ2NURrRll3UFhCdTJ2Sm83ZVl0Qk0zN09Yb2UyV0NpdE16elVzaHAvclhu?=
 =?utf-8?B?VVQrMTVvUmk0dzYzTy9aNllZYTZydVVkZnhxeFprZitXeFl5cUNqSjBjNGJm?=
 =?utf-8?B?TTRtSitrYnpLL1NRUmJxRTY1ZGlvTG9wazY5Y1M3dmtsb05POGZDQ3hQeUs5?=
 =?utf-8?B?dVpnc1VJUGhvb1RTWXhId2VmdlhHNWVVbWY2Uk1RL2h2c1Q2bkUrMnd2dk1W?=
 =?utf-8?B?alZlVUhPb1d3NG0rUmtpU2VDRDloVDgwN2pBSGFrajZpMkc0WHArM3o2OTdo?=
 =?utf-8?B?ajZSaTVXUDN4dk9mSXhyQ3p4c2JkL1lLYjRISWpVQzIzOHo3eFdMK0p3VktB?=
 =?utf-8?B?ZVNkLzAyV3FENUdzaHVXYnMvMk4xUHZWRFhsbitjcWhmdW1vZjJrWGhydFVT?=
 =?utf-8?B?RFlTcFkyRHVXZnZLbURQYjMrTlU2N09ETWNYOGpyYmE4dGFvMDNHbFl4SEJy?=
 =?utf-8?B?SVQxVHNPNlFMN2VJNnNsR2ZIUEVIUVlXYUJvMm5jcmZpSDlWM0k1VHNPVUxT?=
 =?utf-8?B?bUMyWVZMSTJ5b0xHNk54WFdqaUhLUG5IQWdqQkVvZUcvNGtVcjgyM1JzbVBl?=
 =?utf-8?B?NGxCcXZDZ2o1cHZLdXNNcXkwZlRkR1N4TGU1VWpJSnZuODB1cndGZ1pyMDVD?=
 =?utf-8?B?K05kRVNEcHRLVzB4N0RFczlDR3VPVXpnNlJFQ2VaM1dTSSt0VW01SFArNEVi?=
 =?utf-8?B?bDdRRWdwR25XZ0R0ZEJ4VktLcmRGQXJnWC9tb09LbGQ2bFMzRE5qUllWZEFF?=
 =?utf-8?B?bm9LdFQ5YjZabE8ycXJ4elB0cXVsb3Q3VFlJZEtUQjdjREc4aWl0RWpYalZr?=
 =?utf-8?B?ZUZvZnJOODZGTU95ei9TZEtQTWl1YzBNVkNFOUYxVFp0MzlDMHVVZS9Gd2Jm?=
 =?utf-8?B?RkZUWnQ1K0VwdXNkaUFvaUNSNUN1ZGhsTjVheWpyUnI3UGhQc2pNWkdydDhM?=
 =?utf-8?B?SVpUMzdyV1RsakQxSk4zYmxxai9ZVUFXQ1lCcElkeEY1UVdVNDNCcDB6aExZ?=
 =?utf-8?B?VEdVeGF3elJMTmNPVmF6bzZjYnRzbjhuS2dNOXU4YVhTZG9OMjBxSlpTNEhO?=
 =?utf-8?B?UThIZXV3OUZDZklXMWRCR2JXMmQ4L1FuSFE3VEVuVTcxNHpsOGFwNkMrWE9C?=
 =?utf-8?B?K3dvS3o5WXllajM3UkVHc1BWQ0NZS0w2QmExNmVMTVgvOGNMWjdEQXdBcyta?=
 =?utf-8?B?blRnYk9weEpDSUFiNnlVZkhsTjcxaGZ3ZGdzTkRTQkFkY3piWlBTRnZvLy90?=
 =?utf-8?B?T01mV1MxSHc5Ti8xNUNVS0FtdjVnSGZwM3AyUGtUVjJGVURRbyt2aFc0SEVt?=
 =?utf-8?B?OEVCWkhwUE1Ga3hpVTNsKzE0RXd2SE5PSlJWVUQ0ZU9zKysrVUp0Wi96UG9L?=
 =?utf-8?B?c3R5cHRPZ3ZlcWk1RHRqbEUyODJlVitoeFRZQ1V6YzBBYkRxZUtKU3RSL29w?=
 =?utf-8?B?YVMvclFSM0xEVUsxT1JGN0h3cXBKdFRLaHMvS1NRblByNUdSNGI0K2g0aE80?=
 =?utf-8?B?eTUrSGdXd1FVYmIzR0ZmUXJIT1ZpeUYzTm1PTWUrWTUrUmJlTU9uRm9YcEZN?=
 =?utf-8?B?bERESjM2SlFKb09YL2VjTHFtMmtQNEUyN0dEOXUzMmNrWG15Zm82SExpSTl6?=
 =?utf-8?B?NGlZNVZ4cFhLV0NZOUF0c0ZPcWhLeHc5SXJGcExLVjR4Qzk2SERZZVJZVk51?=
 =?utf-8?Q?2GNm7BGtTcS+z/LI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <368C568F6619814B923EF3DA91248801@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1960.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d700c8b-be15-42d9-d44e-08da49216635
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2022 07:35:02.3273
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WGJ6ppg+mgpfst0fY4bBPDzKK1vdAU5mvAPtF4ONyTxsEzM+M4QvBgECjOvcmSN2vB1ZDhsi7R/fDMfhxe2pIt5K5MxDveyl0cI8ynw3q7c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4888
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDcuMDYuMjAyMiAxNzo0NywgS2F2eWFzcmVlIEtvdGFnaXJpIHdyb3RlOg0KPiBMQU45NjZ4
IFNvQyBoYXZlIDUgZmxleGNvbXMuIEVhY2ggZmxleGNvbSBoYXMgMiBjaGlwLXNlbGVjdHMuDQo+
IEZvciBlYWNoIGNoaXAgc2VsZWN0IG9mIGVhY2ggZmxleGNvbSB0aGVyZSBpcyBhIGNvbmZpZ3Vy
YXRpb24NCj4gcmVnaXN0ZXIgRkxFWENPTV9TSEFSRURbMC00XTpTU19NQVNLWzAtMV0uIFRoZSB3
aWR0aCBvZg0KPiBjb25maWd1cmF0aW9uIHJlZ2lzdGVyIGlzIDIxIGJlY2F1c2UgdGhlcmUgYXJl
IDIxIHNoYXJlZCBwaW5zDQo+IG9uIGVhY2ggb2Ygd2hpY2ggdGhlIGNoaXAgc2VsZWN0IGNhbiBi
ZSBtYXBwZWQuIEVhY2ggYml0IG9mIHRoZQ0KPiByZWdpc3RlciByZXByZXNlbnRzIGEgZGlmZmVy
ZW50IEZMRVhDT01fU0hBUkVEIHBpbi4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEthdnlhc3JlZSBL
b3RhZ2lyaSA8a2F2eWFzcmVlLmtvdGFnaXJpQG1pY3JvY2hpcC5jb20+DQo+IC0tLQ0KPiB2MSAt
PiB2MjoNCj4gIC0gdXNlIEdFTk1BU0sgZm9yIG1hc2ssIG1hY3JvcyBmb3IgbWF4aW11bSBhbGxv
d2VkIHZhbHVlcy4NCj4gIC0gdXNlIHUzMiB2YWx1ZXMgZm9yIGZsZXhjb20gY2hpcHNlbGVjdHMg
aW5zdGVhZCBvZiBzdHJpbmdzLg0KPiAgLSBkaXNhYmxlIGNsb2NrIGluIGNhc2Ugb2YgZXJyb3Jz
Lg0KPiANCj4gIGRyaXZlcnMvbWZkL2F0bWVsLWZsZXhjb20uYyB8IDkzICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA5MiBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tZmQvYXRtZWwt
ZmxleGNvbS5jIGIvZHJpdmVycy9tZmQvYXRtZWwtZmxleGNvbS5jDQo+IGluZGV4IDMzY2FhNGZi
YTZhZi4uYWM3MDBhODViNDZmIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL21mZC9hdG1lbC1mbGV4
Y29tLmMNCj4gKysrIGIvZHJpdmVycy9tZmQvYXRtZWwtZmxleGNvbS5jDQo+IEBAIC0yOCwxNSAr
MjgsNjggQEANCj4gICNkZWZpbmUgRkxFWF9NUl9PUE1PREUob3Btb2RlKQkoKChvcG1vZGUpIDw8
IEZMRVhfTVJfT1BNT0RFX09GRlNFVCkgJglcDQo+ICAJCQkJIEZMRVhfTVJfT1BNT0RFX01BU0sp
DQo+ICANCj4gKy8qIExBTjk2NnggZmxleGNvbSBzaGFyZWQgcmVnaXN0ZXIgb2Zmc2V0cyAqLw0K
PiArI2RlZmluZSBGTEVYX1NIUkRfU1NfTUFTS18wCTB4MA0KPiArI2RlZmluZSBGTEVYX1NIUkRf
U1NfTUFTS18xCTB4NA0KPiArI2RlZmluZSBGTEVYX1NIUkRfUElOX01BWAkyMA0KPiArI2RlZmlu
ZSBGTEVYX0NTX01BWAkJMQ0KPiArI2RlZmluZSBGTEVYX1NIUkRfTUFTSwkJR0VOTUFTSygyMCwg
MCkNCj4gKw0KPiArc3RydWN0IGF0bWVsX2ZsZXhfY2FwcyB7DQo+ICsJYm9vbCBoYXNfZmx4X2Nz
Ow0KPiArfTsNCj4gKw0KPiAgc3RydWN0IGF0bWVsX2ZsZXhjb20gew0KPiAgCXZvaWQgX19pb21l
bSAqYmFzZTsNCj4gKwl2b2lkIF9faW9tZW0gKmZsZXhjb21fc2hhcmVkX2Jhc2U7DQo+ICAJdTMy
IG9wbW9kZTsNCj4gIAlzdHJ1Y3QgY2xrICpjbGs7DQo+ICB9Ow0KPiAgDQo+ICtzdGF0aWMgaW50
IGF0bWVsX2ZsZXhjb21fbGFuOTY2eF9jc19jb25maWcoc3RydWN0IHBsYXRmb3JtX2RldmljZSAq
cGRldikNCj4gK3sNCj4gKwlzdHJ1Y3QgYXRtZWxfZmxleGNvbSAqZGRhdGEgPSBkZXZfZ2V0X2Ry
dmRhdGEoJnBkZXYtPmRldik7DQo+ICsJc3RydWN0IGRldmljZV9ub2RlICpucCA9IHBkZXYtPmRl
di5vZl9ub2RlOw0KPiArCXUzMiBmbHhfc2hyZF9waW5zWzJdLCBmbHhfY3NbMl0sIHZhbDsNCj4g
KwlpbnQgZXJyLCBpLCBjb3VudDsNCj4gKw0KPiArCWNvdW50ID0gb2ZfcHJvcGVydHlfY291bnRf
dTMyX2VsZW1zKG5wLCAibWljcm9jaGlwLGZseC1zaHJkLXBpbnMiKTsNCj4gKwlpZiAoY291bnQg
PD0gMCB8fCBjb3VudCA+IDIpIHsNCj4gKwkJZGV2X2VycigmcGRldi0+ZGV2LCAiSW52YWxpZCAl
cyBwcm9wZXJ0eSAoJWQpXG4iLCAiZmx4LXNocmQtcGlucyIsDQo+ICsJCQkJY291bnQpOw0KPiAr
CQlyZXR1cm4gLUVJTlZBTDsNCj4gKwl9DQo+ICsNCj4gKwllcnIgPSBvZl9wcm9wZXJ0eV9yZWFk
X3UzMl9hcnJheShucCwgIm1pY3JvY2hpcCxmbHgtc2hyZC1waW5zIiwgZmx4X3NocmRfcGlucywg
Y291bnQpOw0KPiArCWlmIChlcnIpDQo+ICsJCXJldHVybiBlcnI7DQo+ICsNCj4gKwllcnIgPSBv
Zl9wcm9wZXJ0eV9yZWFkX3UzMl9hcnJheShucCwgIm1pY3JvY2hpcCxmbHgtY3MiLCBmbHhfY3Ms
IGNvdW50KTsNCj4gKwlpZiAoZXJyKQ0KPiArCQlyZXR1cm4gZXJyOw0KPiArDQo+ICsJZm9yIChp
ID0gMDsgaSA8IGNvdW50OyBpKyspIHsNCj4gKwkJaWYgKGZseF9zaHJkX3BpbnNbaV0gPiBGTEVY
X1NIUkRfUElOX01BWCkNCj4gKwkJCXJldHVybiAtRUlOVkFMOw0KPiArDQo+ICsJCWlmIChmbHhf
Y3NbaV0gPiBGTEVYX0NTX01BWCkNCj4gKwkJCXJldHVybiAtRUlOVkFMOw0KPiArDQo+ICsJCXZh
bCA9IH4oMSA8PCBmbHhfc2hyZF9waW5zW2ldKSAmIEZMRVhfU0hSRF9NQVNLOw0KPiArDQo+ICsJ
CWlmIChmbHhfY3NbaV0gPT0gMCkNCj4gKwkJCXdyaXRlbCh2YWwsIGRkYXRhLT5mbGV4Y29tX3No
YXJlZF9iYXNlICsgRkxFWF9TSFJEX1NTX01BU0tfMCk7DQo+ICsJCWVsc2UNCj4gKwkJCXdyaXRl
bCh2YWwsIGRkYXRhLT5mbGV4Y29tX3NoYXJlZF9iYXNlICsgRkxFWF9TSFJEX1NTX01BU0tfMSk7
DQoNClRoZXJlIGlzIHN0aWxsIGFuIG9wZW4gcXVlc3Rpb24gb24gdGhpcyB0b3BpYyBmcm9tIHBy
ZXZpb3VzIHZlcnNpb24uDQoNCj4gKwl9DQo+ICsNCj4gKwlyZXR1cm4gMDsNCj4gK30NCj4gKw0K
PiAgc3RhdGljIGludCBhdG1lbF9mbGV4Y29tX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2Ug
KnBkZXYpDQo+ICB7DQo+ICAJc3RydWN0IGRldmljZV9ub2RlICpucCA9IHBkZXYtPmRldi5vZl9u
b2RlOw0KPiArCWNvbnN0IHN0cnVjdCBhdG1lbF9mbGV4X2NhcHMgKmNhcHM7DQo+ICAJc3RydWN0
IHJlc291cmNlICpyZXM7DQo+ICAJc3RydWN0IGF0bWVsX2ZsZXhjb20gKmRkYXRhOw0KPiAgCWlu
dCBlcnI7DQo+IEBAIC03NiwxMyArMTI5LDUxIEBAIHN0YXRpYyBpbnQgYXRtZWxfZmxleGNvbV9w
cm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgCSAqLw0KPiAgCXdyaXRlbChG
TEVYX01SX09QTU9ERShkZGF0YS0+b3Btb2RlKSwgZGRhdGEtPmJhc2UgKyBGTEVYX01SKTsNCj4g
IA0KPiArCWNhcHMgPSBvZl9kZXZpY2VfZ2V0X21hdGNoX2RhdGEoJnBkZXYtPmRldik7DQo+ICsJ
aWYgKCFjYXBzKSB7DQo+ICsJCWRldl9lcnIoJnBkZXYtPmRldiwgIkNvdWxkIG5vdCByZXRyaWV2
ZSBmbGV4Y29tIGNhcHNcbiIpOw0KPiArCQljbGtfZGlzYWJsZV91bnByZXBhcmUoZGRhdGEtPmNs
ayk7DQoNCkNvdWxkIHlvdSBrZWVwIGEgY29tbW9uIHBhdGggdG8gZGlzYWJsZSB0aGUgY2xvY2s/
IEEgZ290byBsYWJlbCBzb21ldGhpbmcNCmxpa2UgdGhpczoNCgkJcmV0ID0gLUVJTlZBTDsNCgkJ
Z290IGNsa19kaXNhYmxlX3VucHJlcGFyZTsNCg0KPiArCQlyZXR1cm4gLUVJTlZBTDsNCj4gKwl9
DQo+ICsNCj4gKwlpZiAoY2Fwcy0+aGFzX2ZseF9jcykgew0KPiArCQlkZGF0YS0+ZmxleGNvbV9z
aGFyZWRfYmFzZSA9IGRldm1fcGxhdGZvcm1fZ2V0X2FuZF9pb3JlbWFwX3Jlc291cmNlKHBkZXYs
IDEsIE5VTEwpOw0KPiArCQlpZiAoSVNfRVJSKGRkYXRhLT5mbGV4Y29tX3NoYXJlZF9iYXNlKSkg
ew0KPiArCQkJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGRkYXRhLT5jbGspOw0KPiArCQkJcmV0dXJu
IGRldl9lcnJfcHJvYmUoJnBkZXYtPmRldiwNCj4gKwkJCQkJUFRSX0VSUihkZGF0YS0+ZmxleGNv
bV9zaGFyZWRfYmFzZSksDQo+ICsJCQkJCSJmYWlsZWQgdG8gZ2V0IGZsZXhjb20gc2hhcmVkIGJh
c2UgYWRkcmVzc1xuIik7DQoJCQlyZXQgPSBkZXZfZXJyX3Byb2JlKC4uLik7DQoJCQlnb3RvIGNs
a19kaXNhYmxlX3VucHJlcGFyZTsNCj4gKwkJfQ0KPiArDQo+ICsJCWVyciA9IGF0bWVsX2ZsZXhj
b21fbGFuOTY2eF9jc19jb25maWcocGRldik7DQo+ICsJCWlmIChlcnIpIHsNCj4gKwkJCWNsa19k
aXNhYmxlX3VucHJlcGFyZShkZGF0YS0+Y2xrKTsNCj4gKwkJCXJldHVybiBlcnI7DQoJCQlnb3Rv
IGNsa19kaXNhYmxlX3VucHJlcGFyZTsNCj4gKwkJfQ0KPiArCX0NCj4gKw0KDQpjbGtfdW5wcmVw
YXJlOg0KPiAgCWNsa19kaXNhYmxlX3VucHJlcGFyZShkZGF0YS0+Y2xrKTsNCglpZiAocmV0KQ0K
CQlyZXR1cm4gcmV0Ow0KPiAgDQo+ICAJcmV0dXJuIGRldm1fb2ZfcGxhdGZvcm1fcG9wdWxhdGUo
JnBkZXYtPmRldik7DQo+ICB9DQo+ICANCj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgYXRtZWxfZmxl
eF9jYXBzIGF0bWVsX2ZsZXhjb21fY2FwcyA9IHt9Ow0KPiArDQo+ICtzdGF0aWMgY29uc3Qgc3Ry
dWN0IGF0bWVsX2ZsZXhfY2FwcyBsYW45NjZ4X2ZsZXhjb21fY2FwcyA9IHsNCj4gKwkuaGFzX2Zs
eF9jcyA9IHRydWUsDQo+ICt9Ow0KPiArDQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2Rldmlj
ZV9pZCBhdG1lbF9mbGV4Y29tX29mX21hdGNoW10gPSB7DQo+IC0JeyAuY29tcGF0aWJsZSA9ICJh
dG1lbCxzYW1hNWQyLWZsZXhjb20iIH0sDQo+ICsJew0KPiArCQkuY29tcGF0aWJsZSA9ICJhdG1l
bCxzYW1hNWQyLWZsZXhjb20iLA0KPiArCQkuZGF0YSA9ICZhdG1lbF9mbGV4Y29tX2NhcHMsDQo+
ICsJfSwNCj4gKw0KPiArCXsNCj4gKwkJLmNvbXBhdGlibGUgPSAibWljcm9jaGlwLGxhbjk2Nngt
ZmxleGNvbSIsDQo+ICsJCS5kYXRhID0gJmxhbjk2NnhfZmxleGNvbV9jYXBzLA0KPiArCX0sDQo+
ICsNCj4gIAl7IC8qIHNlbnRpbmVsICovIH0NCj4gIH07DQo+ICBNT0RVTEVfREVWSUNFX1RBQkxF
KG9mLCBhdG1lbF9mbGV4Y29tX29mX21hdGNoKTsNCg0K
