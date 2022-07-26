Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B55C5819FD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 20:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239704AbiGZSvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 14:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiGZSvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 14:51:10 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED14C28739;
        Tue, 26 Jul 2022 11:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658861469; x=1690397469;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=wpRgQ9+rLDdguHwNkIgm4RoRo7gO4eKBV51ysHEiRCA=;
  b=VRRhxBwu2Tn8xiBmSZgmpBUFQUnW61HQaGE4/X91RqBh5hRB1aWYVHMl
   DfNOSo7Wvs2j145YFBRd4ChOdWj3gWO1KBDPA8L5QT8/sDEkj9a2mk33J
   MgpCsp4d3jm71v7/yyCN0YMBq2+L41XwKBQgjfml3rn2VXEhWVOSHkHFi
   hQDRfhdDvi/LZANyMpQr1YDQc2ifT5THHwEpXpuJKK7neNKXvpYIFVR2N
   rRlmOTzNJJAXV47igdm1AoadxUxruMbY4wN8vYJVy05BS7T79SruzC3jj
   vISvdQir4SmsrbZnpTwAHbJ5QEQcJoWw5RxX3GJPKj2Fcwi5CmXsB9oL3
   w==;
X-IronPort-AV: E=Sophos;i="5.93,194,1654585200"; 
   d="scan'208";a="106244615"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Jul 2022 11:51:08 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 26 Jul 2022 11:51:06 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Tue, 26 Jul 2022 11:51:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VQgWHg3rpDTOnsqoB9cLLi9osRy45qahpIbS+H35Z8vnRBxnobGhu/2aVkLTJNQLGcjV7gaoQAkQ7qSykZiDxzExvRcjxMhNyfq6q2yhE4tJobF+6siki3yEyDTzfUcX8J91+rZnOGSH7Moa/oFeXsAxPiMPcACRn9aKL8m6nUbKnOuuWW/LRetr9V+6sKujTHtGZhaepTeQQ1Ym10Zx8CEbOQXa8hLx8ca8HTdYeD95EkuoLkpOF2cZOYzENyUVLYbRaWF0hKk0dzYh+5IH5fTbuGvLuKCOzsy/cZWerlunUW+DyhRDdeNPxkQpA40/bYUcbikV5eF7iz6EmVUw8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wpRgQ9+rLDdguHwNkIgm4RoRo7gO4eKBV51ysHEiRCA=;
 b=VF16Nw7uGmM8Ky9HZfXgIlq/GvAIvZm9JOp7iyXE+4Zxk3NXY1v8yUqrxhES0X7c374gV9SYUA9pCjSiVJwZmdIsLP7lxIkZ6KAKSlSonsO0Ugp3SXCW577uK3rShoKEgTVess/cXf5X3PxIbVJkZWLtK+mr/K1xMucVf3lvXvMbLPgsl/r2sKkSPPBuf6ibjf2IHOTTieUI+ODcXbaLFT/L5pCaMthQOTMubnLyA4iNlZDg7P/7gDoyCM3syXHwGLRG/N7ccTbCG16hbbvln+xkIIa/RL7ADmlBl/lqYj62PhlqaMaUyXTRnslKCVNDwJITQr9ddk6CK9Z23It7Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wpRgQ9+rLDdguHwNkIgm4RoRo7gO4eKBV51ysHEiRCA=;
 b=TE6n5fC7hYn9jc5JEZEjwE25pf2KES9Nsba3J+aAypOR/va3NdVfcYoSASKKSz9wtkXUPCMpCsn5kNZ7Ng6fXA7wUN4x+vvOlXfNMGiB4dQfd979Y2FJyQnP0lzCLDrvvQ+ObPEZ1P7r0+BBevlGdpyoq7VfrSMrxz8baQlEAyo=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by CY4PR1101MB2101.namprd11.prod.outlook.com (2603:10b6:910:24::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Tue, 26 Jul
 2022 18:51:04 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%7]) with mapi id 15.20.5458.025; Tue, 26 Jul 2022
 18:51:04 +0000
From:   <Conor.Dooley@microchip.com>
To:     <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        <geert+renesas@glider.be>, <magnus.damm@gmail.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>
CC:     <anup@brainfault.org>, <linux-renesas-soc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <prabhakar.csengg@gmail.com>,
        <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 0/6] Add support for Renesas RZ/Five SoC
Thread-Topic: [PATCH 0/6] Add support for Renesas RZ/Five SoC
Thread-Index: AQHYoRqG83gA4jjS40aTsU0H7ubG462Q/xqA
Date:   Tue, 26 Jul 2022 18:51:03 +0000
Message-ID: <e05b7ef1-64ae-4c12-7664-c70c7a35f76d@microchip.com>
References: <20220726180623.1668-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220726180623.1668-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5724dbe5-e7d1-42b5-9a31-08da6f37caa4
x-ms-traffictypediagnostic: CY4PR1101MB2101:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JwrgP1ghO3pQ4s3dsUiHjkPw68sGmB7YabPRFEK6wu3Hmo8Gm+oUhtumGPM7bOTvXKqeFD/gEArhkLdbLnR4X5QVZ2JsGmpmeMSMPVArOTz6WlyPm8AwKOEhPSi3Lli9ZOGRO6+IjmkKkV0Rm8nkRrsgY09tM1APK5nnKUQofweskjEgeXPV92OjsEPxa+BLVogsmhwObr1y33h6xJGKR65xNtmi8wky9/2oC8N0YG4IEFPLkmraPwWG4p9zE52twsbtdLWI3rO2rWVyMsciTV40QXTyG3mrXNvqDmwvmmSFxkBK907uL37/SbtlBaNWBLTVjNWvNidFArMQH8CN7A7HZCAEA/g1SgEIW/3+dqwUceJr1tQngYNCdRZr22/k90ytDQBFbVO1TkLHZHI5buAPDuUY7yea8H4wtkEO1CyDJo6WqJqRgQDOJG3rgygUSNiQgzSXQIsqXKwvs6fV4iun8ReDhNSYseBrFGmuYI1EmKi70FOe0uQgetLMzxqiA5iroPkEu+wX9wUUW3QlaVeGfiIsIPG5dPtKHcoQvwhYd0YX8DHDzJ+Ku4rvxYn3NC/likZl4W5298Zmm4T6E3s+Lecxzi3FjKQzY4lAM5PLgz6E8SKUbQh/OZA+1r8k2HYhu1//G2OlC66AusuMkboxJXew1FjDNnrIaToLUOJjgnK1UVgvwLkT7j4llTxeGYzpG0goq9O3eEGAHw7/Ns388sGzEBJNEYASogEcPo49eFOZxk02l+RYZ8UOFlHRf+eYULHz94I6gAwO9s6omJ7u8YTcUFB8HC/tLAMeJlRgNmDA6TBI+u0MyyY/5ykGopeAMWuq6DDIMVLItVGgnS4AywJ0GzHvJkqG2uYZ2ppTJT1NZQnvoQGBsceEYV8V6I2DnX8SDVZHHtHmsBomvX7G0GSCKU7de8PJYwA+BQE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(366004)(396003)(376002)(39860400002)(136003)(76116006)(66946007)(91956017)(66446008)(66556008)(66476007)(8676002)(64756008)(54906003)(316002)(2906002)(31696002)(86362001)(5660300002)(7416002)(110136005)(36756003)(4326008)(8936002)(31686004)(186003)(38100700002)(2616005)(122000001)(38070700005)(71200400001)(6512007)(26005)(966005)(6506007)(53546011)(6486002)(478600001)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VkxUQTEvNlV2SWpkTEhnM2hoZGlEMkNXcnFjOG1mUGhLR2FkUWkrb24yZFFk?=
 =?utf-8?B?dW1BQ0dsbHJOVnFXK3cvNlphZGJYcEtTS3ZYSVlsQlhBbmt0Mm9TeHp6ZG5V?=
 =?utf-8?B?UnRpTExoUFBtWUJrZGxCQ0V2T2cvVHpOSURSUmR1czRYYzA3dGxFWkhXZHAx?=
 =?utf-8?B?Q0VFcXRFNTY2bi9FTHVxN2E2cGJHZ01XVkNHMFNnTklKWGRORTJrZkIwcGZw?=
 =?utf-8?B?ZGxwcS9qbS9PYlFBMmNIYVlrbFVUWlM1ZEhJcGxGQnk5QXo4TDJJaXNCMUlX?=
 =?utf-8?B?aWlSS29kbVNsS1FvUFVPQ0JTRmsybWJEYkh0V2psd3ZOSmUwckJxYXAvK3Jy?=
 =?utf-8?B?RUNtbUtYcFQraStPbHlSaGxmb2NnbWY2d1NMWWFpenYyQXlmYzl1VDI0cHV2?=
 =?utf-8?B?ZDJ1Tm8wenpWaTA1aEV4SHRjUExnVnZkNStFeXZkUG5rZTJFcHZicFVUOS9x?=
 =?utf-8?B?K1FsekxzaktCVGRaa0x4R0NOQ3UxSFNJRlNkQ0E0dUNXeExqWkVzclVLTlkv?=
 =?utf-8?B?ak5MN2VnQVZLTE00Z1BFWUlYMTVMUEc0YWdxcWRsN1FqVzJIMGFpNXJJT2k4?=
 =?utf-8?B?L2E1V1dVNHhtNmRjL2VGenEwdkhJR1pQU0MreDRRTitxc3pwTmV1Q3NibnQ5?=
 =?utf-8?B?eWVTRHI1WGhvWDc1bm1Scld1NXNXeStaYzFxRFhzUUJhUkJOdnZWcjZVaFpw?=
 =?utf-8?B?UjFzT2d4L2Q0dGk5cXhVSXIyY1Q3WkUvbFR2VFV0ZllmYlBYVlJiR0pjSUJQ?=
 =?utf-8?B?dXFnUFhZVFVmSEJpSFJ0RUcrYk8yNStYeXM1TUg2K3UzRCtxeVJNV1J3SVBz?=
 =?utf-8?B?SWtoWURuZ1lrS05YNWg4dHo4MzNDR1pnOXRUd0dqZ3FKcXpoeXdNMy9NM0Ra?=
 =?utf-8?B?K1lqd080cGpKTDZ2eVJrbFA5QjZEaXExWk45OGlVRnFyUWcvdFJKamZWNHFV?=
 =?utf-8?B?SnFJL1NwQnR0V1U3M2JUanBpdnBjT0ZzMWJxNE5XcktQQytDd25YeDk0Vy9S?=
 =?utf-8?B?ZWNYMmp0RDdCTDBWa0pGY2YzYjNvTkxZYXFBZjZVdWplMGx4YXdiQ2ZCZG10?=
 =?utf-8?B?UUhSaE94MCtmcjdNNnRWZ1ZxdWRPWGU2T1BkMmdxZlZuVnNMWDgvMHhiY0xQ?=
 =?utf-8?B?azlLM0Z0MFNMeGxjVlMreVdGeTQ5aWNaY21uejlpRXNhanlVZlFCVGp0OFlQ?=
 =?utf-8?B?aHF5UnhXNnBRMWJkNE9pWjhHUWcvL04vUDljcTBnb1VaUVVKZS9wS280WXhi?=
 =?utf-8?B?Y29yeHRmTXlMNVkyKzRqYlVhcEdiWXFrZWI4aXBlaVcwcVpEa0dMUW1pMENh?=
 =?utf-8?B?ckM4anJFYW5tWUdBOFBmRUMzTTBpRHJEa3dRcHNNNzFVUzVYUkJqUGh3dUQ5?=
 =?utf-8?B?Rm9EeUMvMGQyZW9qTU12TlpmalNNNWhnSHNrbU9nK2JmTU0vTm9TcTB1NWUr?=
 =?utf-8?B?MkRWT1BkSmdmckppSTdaUnJDRXpuaDdQdjhpT0hzNVphczhjRTRweDJpcm1p?=
 =?utf-8?B?akJ1OG04bUFFb2EvNmVWSk5WVWxZTlZqRDdncEwxNDI3ZG91SzEyVEtpKzR6?=
 =?utf-8?B?SHFIejZ3VUNrZ09GSUhnczU3ckVhakFzYk14Q3dqUjVyRlZTVk5ua0pwbS85?=
 =?utf-8?B?cFdsb2czQTJJNUU0N1p4STlHRGx5dXhNU255RHhoQjB3VllvOHhId3haeEdp?=
 =?utf-8?B?anhHM2V0alNTTHZPemg2S1FGRWhRSkxIWVFiUWxiblNsTS9sRDRiaDlHa2tQ?=
 =?utf-8?B?MjJLZXJXSDJmSFlFZlVnNi9MS0hCSjlQaWc0ZDZ5NTNSZGx1eTJSdjZRRzJa?=
 =?utf-8?B?ZkplZ2pCQXRBZGtXUUZENWdiRlNTZ3NtRnN1d3BzeEc2cDlwRXgxdWsxQUF1?=
 =?utf-8?B?QzNNSUJ0VVptWjhobEZIOWxTMVFHaTZ4ZUpVMmNxb2NjODhuamtVLzEyc2U1?=
 =?utf-8?B?bExsMEU4UGRXME5uZjNEdkNSY2FzTmJLaHpIYUFxRFFMUmxGb0FLTVZzQ1RH?=
 =?utf-8?B?cXpFblRhOG9kaHVNcHZ1WU1Nc0s5eXVNRk1QUDVkak1selZJT1ZMTGVyLzg5?=
 =?utf-8?B?TUxYSTVDQzZBa1MxQ0YzYURUSEtBbDZNbTBFWHRic1ROMnNUbG9Lek9va2ox?=
 =?utf-8?B?ckZNVG8rcjNyVmNGS2dtY3lwS1FocDRlK2RBSEQ5dEEyd0duUTY4TGNjRUI0?=
 =?utf-8?B?L1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A5F1C2635344C34AAA38149B870774DB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5724dbe5-e7d1-42b5-9a31-08da6f37caa4
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2022 18:51:03.9391
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z8wwlsUluKarFucxdH+POTEhS9JbwOlUhmjAuo3VUeGTogHv0zcyT4C+2j14bMAxgY7Dr+UEI6nfZrBdp5x4FOHfj0ZDxhp59ohi5mq8DcQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2101
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjYvMDcvMjAyMiAxOTowNiwgTGFkIFByYWJoYWthciB3cm90ZToNCj4gVXNlZnVsIGxpbmtz
Og0KPiAtLS0tLS0tLS0tLS0tDQo+IFswXSBodHRwczovL3d3dy5yZW5lc2FzLmNvbS91cy9lbi9w
cm9kdWN0cy9taWNyb2NvbnRyb2xsZXJzLW1pY3JvcHJvY2Vzc29ycy8NCj4gcnotbXB1cy9yemZp
dmUtcmlzYy12LWdlbmVyYWwtcHVycG9zZS1taWNyb3Byb2Nlc3NvcnMtcmlzYy12LWNwdS1jb3Jl
LQ0KPiBhbmRlcy1heDQ1bXAtc2luZ2xlLTEwLWdoei0yY2gtZ2lnYWJpdC1ldGhlcm5ldA0KPiAN
Cj4gWzFdIGh0dHA6Ly93d3cuYW5kZXN0ZWNoLmNvbS9lbi9wcm9kdWN0cy1zb2x1dGlvbnMvYW5k
ZXNjb3JlLXByb2Nlc3NvcnMvDQo+IHJpc2N2LWF4NDVtcC8NCj4gDQo+IFBhdGNoIHNlcmllcyBk
ZXBlbmRzIG9uOg0KPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiBbMF0gaHR0cHM6Ly9wYXRj
aHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LXJlbmVzYXMtc29jL2NvdmVyLw0KPiAyMDIy
MDcyMjE0MTUwNi4yMDE3MS0xLXByYWJoYWthci5tYWhhZGV2LWxhZC5yakBicC5yZW5lc2FzLmNv
bS8NCj4gDQo+IFsxXSBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgt
cmVuZXNhcy1zb2MvDQo+IGNvdmVyLzIwMjIwNjMwMTAwMjQxLjM1MjMzLTEtc2FtdWVsQHNob2xs
YW5kLm9yZy8NCj4gDQo+IFsyXSBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3Qv
bGludXgtcmVuZXNhcy1zb2MvcGF0Y2gvDQo+IDIwMjIwNzI2MTc0NTI1LjYyMC0xLXByYWJoYWth
ci5tYWhhZGV2LWxhZC5yakBicC5yZW5lc2FzLmNvbS8NCj4gDQo+IFszXSBodHRwczovL3BhdGNo
d29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtcmVuZXNhcy1zb2MvcGF0Y2gvDQo+IDIwMjIw
NzI2MTc0OTI5Ljk1MC0xLXByYWJoYWthci5tYWhhZGV2LWxhZC5yakBicC5yZW5lc2FzLmNvbS8N
Cj4gDQo+IFs0XSBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtcmVu
ZXNhcy1zb2MvcGF0Y2gvDQo+IDIwMjIwNzI2MTc1MzE1LjExNDctMS1wcmFiaGFrYXIubWFoYWRl
di1sYWQucmpAYnAucmVuZXNhcy5jb20vDQoNCkZZSSwgeW91ciBtYWlsIGNsaWVudCBvciB3L2Ug
d3JhcHBlZCB0aGVzZSBsaW5rcyBhbmQgbm9uZSBvZg0KdGhlbSB3b3JrIHByb3Blcmx5IDooDQoN
Cg0K
