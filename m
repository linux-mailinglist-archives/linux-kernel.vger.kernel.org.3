Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6D094C63DE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 08:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233650AbiB1Hg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 02:36:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiB1Hgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 02:36:54 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88F3593AF
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 23:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646033777; x=1677569777;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Ohg6vewj32bg8k1oga+9hlY486tYc81H4nLrfKWEoyo=;
  b=WKQ/BOELUC6tCzErjjSsOphhFMl5Kv7FRHXgHgnNFluAkdQpOfIn/f5I
   V3PSrql5Y0JowZS9Te7eYBH/Rax3qKK0xScJzDibwwQf9P1GF/Ay3Rldz
   xlPbpI5sVs70iR5+dPyU7JHPkfIC6nVg7FMGZ506OtTjZWXY1RFe7JcJ6
   6BMEMe+p589RyATZzN/56FapRLcadaObAMwQP8IJe9mNToiF10ux4bDG3
   KK8p3jVb7CVv3ewtwrevQUHWYkC0OJ7QLTpaSwCaMUk2Iad3ywThYDrXF
   qoWkLeVhDzuwavK5VN0kb33yXmaZyOsgyxp8f7/8zIn7E5nfL9J1pQ6U1
   g==;
X-IronPort-AV: E=Sophos;i="5.90,142,1643698800"; 
   d="scan'208";a="154594640"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Feb 2022 00:36:14 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 28 Feb 2022 00:36:11 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Mon, 28 Feb 2022 00:36:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bw0QeN25ZHjUveHq34KzmNFVumbVezwml+38g6RytEQzJs/8Jl3yVPBenlq3PZhw4kUh+rC1n8/R8S2le0I97vyhQXJALrZo/nPumPp/sOZ6VPKG4dfzY/CVVwUkXG+Jq0Dp7UEG1CHskfspOSkDndpwmSW3iS/L6V2NAgFe/O+XaFGcUdNWR1c0d6oe84G2neKbFd6bKxzrhxtg2vUuF+9oueeYQ/zOiPWGdCQgMMae6D9qJSjQEPCUwHOV381vrbxsjP21gvmLsXyrrZN7sAI7Zi305p8ORTY+Wp3RY7FR6VEqLnw03Y/CdVR5sNSIlUDF32pdxlqbCrYyo7L+OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ohg6vewj32bg8k1oga+9hlY486tYc81H4nLrfKWEoyo=;
 b=REJ71c2AjdGS8jy30xQqQKWpZBPAQhaGtyn0CEYVl0x3FPWThQbae1l7lrFlZUhAvB+Fh8Ke/tRQ+UdMXkExSCgeaNyU3y/kmhUvpsl/nBbovlHrGfqsFmC634wJZ6uVnuu0uMfB2BeuYcIV4+oRLyMOBms0VQHuaj4Ru69mwYkIiH7PL8Iod+KvSetfVOhT5g0jkcufWdsvgzSO044r5jjKbzM2ko6C2pHg5X+hn1Gf0Ay5vxvAdntFE/tuii2HBkFv89/FWXb4rBT9FhWmfo+ew5HYCzkGvSDr6crwdzVj+4yYGPkT99P9DTozcEwX82EfsFO9ptsozlK9f4VbyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ohg6vewj32bg8k1oga+9hlY486tYc81H4nLrfKWEoyo=;
 b=QuNlwEQLO5esUtgzh7kEsOYstMNnFVJNY+Zxh2c4kiYbOH/QeynPUXDKrtHQ+L/qVUj2YAQdQ6XwrHriDYWJx+/pL2y9fFHBFSrVnRF0wFr/B+OPeirBvkFVOCXVlFT0g/uogYLlheTQOX16unkzdC05nECCc8gbauilR4k1qxQ=
Received: from CO1PR11MB4769.namprd11.prod.outlook.com (2603:10b6:303:91::21)
 by CH0PR11MB5691.namprd11.prod.outlook.com (2603:10b6:610:110::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Mon, 28 Feb
 2022 07:36:09 +0000
Received: from CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::6d66:3f1d:7b05:660b]) by CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::6d66:3f1d:7b05:660b%5]) with mapi id 15.20.5017.026; Mon, 28 Feb 2022
 07:36:09 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <groeck@google.com>, <shraash@google.com>
CC:     <alexandre.belloni@bootlin.com>, <linux-kernel@vger.kernel.org>,
        <Ludovic.Desroches@microchip.com>, <groeck@chromium.org>,
        <lee.jones@linaro.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] mfd: Avoid unused variable 'atmel_flexcom_pm_ops' warning
Thread-Topic: [PATCH] mfd: Avoid unused variable 'atmel_flexcom_pm_ops'
 warning
Thread-Index: AQHYLHXaY1kBBaTP10GrGjF/VEkSzA==
Date:   Mon, 28 Feb 2022 07:36:09 +0000
Message-ID: <e13337ff-508c-ff69-1ba2-70ca2b503b6e@microchip.com>
References: <20220225101520.3188373-1-shraash@google.com>
 <CABXOdTcMj_=XqTnTiUmT8r585W2N2-12ddg4OGDHpwaiTp-Tjw@mail.gmail.com>
In-Reply-To: <CABXOdTcMj_=XqTnTiUmT8r585W2N2-12ddg4OGDHpwaiTp-Tjw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f6b87ce0-8f7d-4051-2b50-08d9fa8cfce9
x-ms-traffictypediagnostic: CH0PR11MB5691:EE_
x-microsoft-antispam-prvs: <CH0PR11MB56913B808C48B8B320EFBE4687019@CH0PR11MB5691.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zC6hXfK1/eT74LUaNHnbcMn4v2UFvCkjCcmpahU1wBUfYssYbe8T4sKYdNsQPabHEKmbqSJwNjd2+2etMwkPn69wAlvxmo8uNdKkY8jYViCsZISRIhYPSfn6BRkuQN5Zlaoz7nGE9sY9Evwb8OUxP78ycG03nsAerYP/SAuBH3DL8dHxrbD6Tsq0OLNi9QPiL/rxeyOOFBAUPuygASx9pirA1fsSSAu0fxuIRPvnParEDgiFdLNYWMA8pI6cFHM3hw2cdSWUtsA8zTEV648GH7ao8/7n7ndJgCvQ8zXgxGZatcfjPdngBIknxFchBvWl0zGZBCKHSbngMS7g1sqMqfrwSRCJRv6fca6k0dswG6dbQluraIrM71rJgU0VLbyPIi+LS2WZCtfE2JTcW452I6urO3WQHy3GSXTPJgG/y7N8HQs5AJ7Ow0C7vGUr8e5teKvLMqnb1HyDKwgYNgJuA8Ccq5u+4dQJEAZmO5IfVWrT8hITZDwkYdstW69QIoBV4V+xCwLOXPBY3CxWq1o35nhzS+S8QuGMPvSyoqwWwVzDqGT59gt/pBiwr1V554AUAXjjf7ZU99/F4pjbAD/6nzdECe5yBRGA4PaeC5Y3IHCJ7DlYN196q+W0bvbB81Hyah0i8y0sCzmQfwaRMkyJp2s61ImMUT1CLFHe/NtVpCbxKWCL3gLndF8XvtS4KagI/2X/C8vXg6S7WsmF6MxtW20k6F3yvaPWdB8087K2Y7pAiUqoaGD/zAeQ1zslL9eGjTv1Z5QCK/s1B7H3P9DBtLalH0KB8E9/85eg5T9fxdebsu1H4q7Q86LU0x7D8iKRPE9H+tQyyZKUAEpHxrn72yQE4u+65jV5JI6UM6dXfLA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4769.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(91956017)(8676002)(66946007)(66556008)(66476007)(66446008)(31696002)(8936002)(38070700005)(6486002)(966005)(76116006)(316002)(5660300002)(54906003)(110136005)(64756008)(26005)(122000001)(38100700002)(6506007)(2906002)(6512007)(508600001)(31686004)(71200400001)(36756003)(53546011)(83380400001)(86362001)(2616005)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dlNSUVFIUy84N29ncUo2eTZtUXFSL1YrWEtmQ1R0bVo3dUpTRGxCajdsYWlO?=
 =?utf-8?B?MXBndy9YOXdPSzlKamhpZ2RVUTlpc2JYNVUrTlR5RUg2bTBmTkxaQk81K1VK?=
 =?utf-8?B?bWtZc0ZvbzV2NU4vYjJjN0x4UmNBNnVkNjQ1VHJiTXpzUDM5UVUxeDhhWDlj?=
 =?utf-8?B?WnI0VUhRRWxaYUhaRHIvbDRpL2t1S0dmelpGU3ZFa0NQbVVDK1NyUmdNUzA5?=
 =?utf-8?B?KzdMbUY1UjAzVFRsdk1FRjBSU0Q0T3NNSXNoVjRLc2xSK1gvTjN0cnhwVmZu?=
 =?utf-8?B?SHJ4N2RCZk1QZXMrbTZkMk9TV3Mvc2lteWQ1MVM5U3czSGVkSEtVcXhwamk5?=
 =?utf-8?B?K1RFTGJXVHJyTTV2cGJPL2dnRER2OW1uQTNyeXVsOThQL3FKMTZkajNzUTdW?=
 =?utf-8?B?RnJyK0dJV01Halc0dTExeUpIQjlTb2xZaUJhUWdkdWhDSUZoZjFnOW4wY0FW?=
 =?utf-8?B?TjhVVTVWeXFDSmdFeUxWaDlmQ3M0NE05SnhFbmIzUG5ZeWFoOHlDK2djUnR3?=
 =?utf-8?B?MUptMnovK2JSTktQYXgvaVp4QXVORkllb21DSDZ4TDVmelhzTUNsUnJuVlBK?=
 =?utf-8?B?N0tuTk8ySDhTb0k5MFhPZERkdktIMnd6eDFBRjZ3RkltVU5JdmxLbFlacjB4?=
 =?utf-8?B?MDA3ZjFaTmsrN3J1TWV1OEc1Vk04eHg1d3FGVzh1T1dMK0dYTWR5b1ZwL3Fk?=
 =?utf-8?B?dmVDMnpudW03cW1jYnZsS1hTaWlRQVAzQUpzY3phNjVRVkNraXd4dVJIaHlL?=
 =?utf-8?B?WkVGNEF5bExKb3EyMHRRelA5d2k4QzhLMmFncitBay9rMmVDTGFwU1Y2MXBS?=
 =?utf-8?B?UzhkNjJOUHcyL3hGNXE5RVMrQUE0cDZ0Q2VyZW1NV3ltS3ZRYW9INVBqUzNK?=
 =?utf-8?B?eFFOL0JsZmFLNXFsTlptNU9LWGV1a1FxamdUcUpMalIxdnVBcG11NFFKZFV3?=
 =?utf-8?B?cGRYUXVWMmFGNkZEWEhPNlhDS2FHMFViU3VlUVpFMEIzMzMrOVhta3JyU05O?=
 =?utf-8?B?Sm9GbXI0UkJXTEp0Q21NYld3T2tSTXlGcmttS2duays4RndsLzRqZVNDTGlE?=
 =?utf-8?B?RXovRXRqUnVON2tvOEgyQVEzeUhiWkFibFp5UitNdDNBcGhVWHEwV3hiNjVh?=
 =?utf-8?B?ZDlrL1FPdjNFejJoZXgrbmd2TFRPSlM3Szc0Wnk2TllycXkrZ1h5dDNNZVlk?=
 =?utf-8?B?NW9PYUNWQVdXT01ZK0xrNklsd0hMYWxpWDdIRHRKclZ3R3d5UU5qZkNVNjFz?=
 =?utf-8?B?c0ZVSXlCV21takgxTE1zWjhCN3hpQjcxc3lvVGh0ajV1YWxkdWRHU1l1amFa?=
 =?utf-8?B?M2dLYlhZNlR1NG50b3dzQWhhdFFKbWRXQ2xGdHYrcmZBQ0ZIRXh6T3lDWmUy?=
 =?utf-8?B?TjF6a0NyeHptTGNGeVRmekxqaUdITUJtUC9EWDhrbk01SGdMUHhwL3hVbERl?=
 =?utf-8?B?WWxuZFErNm4xY0JtbXZJbHJSZjR2dThCd0YrVm9TcVYvbGkwRnM2Q0c3UzNu?=
 =?utf-8?B?NmxuWlA5N1plMlRrRFJTckxFM0xHWE0wZVN6UkI2SmIrTzhKbitsaG56UUZr?=
 =?utf-8?B?YTJvbnU2OVU0bXNnTTVYcnRxV0V1UU9hR1oyWDBrVlNRMDdtbytkTGZSN05J?=
 =?utf-8?B?eGVtS0FSWUkxekhYZmhDRzBTQmpGbkRFMk9rbkpwRmp4dXpUOE96NDNRVGFH?=
 =?utf-8?B?elJIMm9EYnJKVU40dHZ5bzNzaUZwOGdDRko2SmYyM1o5eFVKVGhjekVwY01K?=
 =?utf-8?B?UFBWRWdXL3R6RE5kejR2ZWMrdVgvdGVWVVJWeXpRZlZLUW14SVIxSHFQWGw0?=
 =?utf-8?B?akpyMlpGZ0c5RkpWTDhqb1JvSVBNSHgzT28vaFdUUkE5UGhDbGV5dXk5Tzlk?=
 =?utf-8?B?MVRmbUpiVTNHRUpJb0kvZ3JlODFaOUt4bDBtNDh5R0Jjd052bVZQWWlnMGZW?=
 =?utf-8?B?S24wdGRmRTBDNWpiY3VTRm5FVmtYcGxLVzlVaWlEeU1EVjQvNEtlNncycnFH?=
 =?utf-8?B?K0ZZNFlVUkJQSStOL21JdTY3MFcxcVhUWkRCOVFiS2wyby92RUtML3AzNDAr?=
 =?utf-8?B?OGpCcVdzak1PNDJwYm9rTTlYNU9QQ0l0cFNPMWhla0tRVVlLUys4MDRZS25U?=
 =?utf-8?B?cWNkeG85KzB5KzlwTElWWnk1UjdVQkMvSHFRNHh3V1JTNDQ4UDZ2Zy9jeWpL?=
 =?utf-8?B?dDkzcUJCOEFaZnpnbEhRcW5tUHU0TGhRbHoxdStxWlhjbEgydTBlRTJpMGc5?=
 =?utf-8?B?dmNjWGNtc2JELzVVNzZZYmhGVG1RPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E3C5966E5914E740B0C4D73E82DFA184@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4769.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6b87ce0-8f7d-4051-2b50-08d9fa8cfce9
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2022 07:36:09.4035
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dHUFLtrnLUDNyLyoeyx7Y37ztVLzzDxBnBbDcncmyUWiyJq+po4Eh7h85TAPFohCg6NYwDvNlyo/7KodOLKA888y/rPYcOzJeGa0Pt7mIx8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5691
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjUuMDIuMjAyMiAyMTowMCwgR3VlbnRlciBSb2VjayB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBGcmksIEZlYiAyNSwgMjAyMiBhdCAyOjE1
IEFNIEFhc2hpc2ggU2hhcm1hIDxzaHJhYXNoQGdvb2dsZS5jb20+IHdyb3RlOg0KPj4NCj4+IEZp
eCB0aGlzIGtlcm5lbCB0ZXN0IHJvYm90IHdhcm5pbmc6DQo+Pg0KPj4gZHJpdmVycy9tZmQvYXRt
ZWwtZmxleGNvbS5jOjEwODozMjogd2FybmluZzogdW51c2VkDQo+PiB2YXJpYWJsZSAnYXRtZWxf
ZmxleGNvbV9wbV9vcHMnIFstV3VudXNlZC1jb25zdC12YXJpYWJsZV0NCj4+DQo+PiBUaGUgdmFy
aWFibGUgYXRtZWxfZmxleGNvbV9wbV9vcHMgaXMgdW51c2VkIHdoZW4gQ09ORklHX1BNDQo+PiBp
cyBub3Qgc2VsZWN0ZWQsIHNvIG1hcmtpbmcgaXQgYXMgX19tYXliZV91bnNlZC4NCj4+DQo+PiBT
aWduZWQtb2ZmLWJ5OiBBYXNoaXNoIFNoYXJtYSA8c2hyYWFzaEBnb29nbGUuY29tPg0KPiANCj4g
UmV2aWV3ZWQtYnk6IEd1ZW50ZXIgUm9lY2sgPGdyb2Vja0Bnb29nbGUuY29tPg0KDQpUaGVyZSBp
cyBhbHJlYWR5IFsxXSBwb3N0ZWQgYSB3aGlsZSBhZ28uLi4NCg0KWzFdIGh0dHBzOi8vbGttbC5v
cmcvbGttbC8yMDIxLzEyLzcvNDc0DQoNCj4gDQo+PiAtLS0NCj4+ICBkcml2ZXJzL21mZC9hdG1l
bC1mbGV4Y29tLmMgfCAyICstDQo+PiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAx
IGRlbGV0aW9uKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWZkL2F0bWVsLWZsZXhj
b20uYyBiL2RyaXZlcnMvbWZkL2F0bWVsLWZsZXhjb20uYw0KPj4gaW5kZXggNTU5ZWI0ZDM1MmI2
Li4zM2NhYTRmYmE2YWYgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL21mZC9hdG1lbC1mbGV4Y29t
LmMNCj4+ICsrKyBiL2RyaXZlcnMvbWZkL2F0bWVsLWZsZXhjb20uYw0KPj4gQEAgLTEwNSw3ICsx
MDUsNyBAQCBzdGF0aWMgaW50IF9fbWF5YmVfdW51c2VkIGF0bWVsX2ZsZXhjb21fcmVzdW1lX25v
aXJxKHN0cnVjdCBkZXZpY2UgKmRldikNCj4+ICAgICAgICAgcmV0dXJuIDA7DQo+PiAgfQ0KPj4N
Cj4+IC1zdGF0aWMgY29uc3Qgc3RydWN0IGRldl9wbV9vcHMgYXRtZWxfZmxleGNvbV9wbV9vcHMg
PSB7DQo+PiArc3RhdGljIGNvbnN0IHN0cnVjdCBkZXZfcG1fb3BzIF9fbWF5YmVfdW51c2VkIGF0
bWVsX2ZsZXhjb21fcG1fb3BzID0gew0KPj4gICAgICAgICAucmVzdW1lX25vaXJxID0gYXRtZWxf
ZmxleGNvbV9yZXN1bWVfbm9pcnEsDQo+PiAgfTsNCj4+DQo+PiAtLQ0KPj4gMi4zNS4xLjU3NC5n
NWQzMGM3M2JmYi1nb29nDQo+Pg0KPiANCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18NCj4gbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QNCj4gbGlu
dXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+IGh0dHA6Ly9saXN0cy5pbmZyYWRl
YWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbA0KDQo=
