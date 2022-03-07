Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C74C4D02AC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 16:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243732AbiCGPZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 10:25:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236252AbiCGPZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 10:25:53 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB362710F4;
        Mon,  7 Mar 2022 07:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646666697; x=1678202697;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=oYCTPspenhqxC+wLRuF47ilmKZLNvP4yN3OtqOEzMz0=;
  b=PN4kRbkkDMp31HjF48oEHYsaHU/N0P332q779UhC4kgBbnyBIbVRbOBI
   Ij6tgxhnbP/ztZxvJf0WKExSh+0yJJPgGeTf/KXirLwlU14xvyBDRJ2fY
   2vZ/iOJWBwUZ8p4IZjXVoy2Z2+tFAeF+L+sdkCxjp1mf1FuVTF7uLc4yD
   tSaiPNAj5sTUcnxw4r2psX4Ul5iJGBQb7fzpMnppsF4QQooT/n21//pKE
   CBDVHZL3RrJe7QaZMGVEyZjlMod8IgHn6Q04PM+MzimT4enFUpS5cY5/3
   sPVUyBWdngD+04ZTq6iPhFSYq2JOrrAOyytLm6GgsGZp92hrVxq/Byw0Y
   g==;
X-IronPort-AV: E=Sophos;i="5.90,162,1643698800"; 
   d="scan'208";a="88074544"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Mar 2022 08:24:56 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 7 Mar 2022 08:24:56 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Mon, 7 Mar 2022 08:24:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QEJOWuexMRPIGZv/rmEUjGvAAFtIsmED2lKIh3VmmexV5jsaZtcUPJvv4/+QRx1/MiMCO5QOhgr78AFpF08/c45kMoDALHZMAI/UCUi5J3slXyOWkmood1hwKOopno+fJgSxvsuEk+VG5TwOt6FVCFdRoFGUkX4fCvUK5K1NGOjoSPA29RFpakEpVCASgqNMlozwq14saYsyjpVrZVCOTjOq0uRVKbPas9s+8OiaYdr0U35w9TsgWgXn+NqUEDTbkpAGuTXlUUEWyJrMi9ZT3tH0IczSR+2c73I2CwwuGFvNR8Rffpnt+ad7STyDyrBccP+Q8DU/kj11U+Kl/7JReQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oYCTPspenhqxC+wLRuF47ilmKZLNvP4yN3OtqOEzMz0=;
 b=bi1jC97B4Y9ndRYFsYMCOsJlS4NMT4tU21RdFCSponFBG0o0c/bNqmhXXB+WliNT1ean650Z6POZsjunP7ZUpbKyx44zfaTGnvTS2DVCLjm+u2MqKB3qQ//0xtgywK3saqzftMjX5aqxJ0YRowimqai8ENgdv0pz02wKUKSNYwJKoYOcBXmfzMmy/DAL8vXVRIeIqFQ1CKj9616Hp4kgfZdsRBB+jbhCk2xiWSObXVVfuVRIFTa6ejduYpklqhGTJP5S1492kP/PplZSmgyKwhLwo8bMDB152SQCUuG8fgOn2Iy8x6Yd5KTqscxz4J6ZhOQ90UQ+vmi+jUQ7kNwoTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYCTPspenhqxC+wLRuF47ilmKZLNvP4yN3OtqOEzMz0=;
 b=h5xW0WZfRp4xZO0SKkp1H9w5090EiaHY//19oqknz4UhZ6YUkJyONlQ6btWHaVDxd08aqN9UQf3nKUH4SUDHLaZz3GgNSd5aR49Dt4CXg2m0kj5S5BrGUwdrMA+Y4JkTgZAU5CCRvdhZw0LL78NSbOx5qu/A1ncFhN01MGYpgIc=
Received: from BYAPR11MB2758.namprd11.prod.outlook.com (2603:10b6:a02:c9::11)
 by CY4PR11MB1637.namprd11.prod.outlook.com (2603:10b6:910:d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.13; Mon, 7 Mar
 2022 15:24:55 +0000
Received: from BYAPR11MB2758.namprd11.prod.outlook.com
 ([fe80::381d:1e0a:2ec0:38b6]) by BYAPR11MB2758.namprd11.prod.outlook.com
 ([fe80::381d:1e0a:2ec0:38b6%4]) with mapi id 15.20.5038.027; Mon, 7 Mar 2022
 15:24:55 +0000
From:   <Sergiu.Moga@microchip.com>
To:     <krzysztof.kozlowski@canonical.com>,
        <Claudiu.Beznea@microchip.com>, <thierry.reding@gmail.com>,
        <u.kleine-koenig@pengutronix.de>, <lee.jones@linaro.org>,
        <robh+dt@kernel.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: pwm: convert atmel pwm to json-schema
Thread-Topic: [PATCH v2 1/2] dt-bindings: pwm: convert atmel pwm to
 json-schema
Thread-Index: AQHYMjKIs8Jgg1tXXUOG1crBZBIQoqy0AkwAgAAITAA=
Date:   Mon, 7 Mar 2022 15:24:54 +0000
Message-ID: <7f039922-b9ea-d3a4-7e60-e5359840d511@microchip.com>
References: <20220307144652.162706-1-sergiu.moga@microchip.com>
 <20220307144652.162706-2-sergiu.moga@microchip.com>
 <4e137401-4b8c-0abc-0c50-d784d579a991@canonical.com>
In-Reply-To: <4e137401-4b8c-0abc-0c50-d784d579a991@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 21ed940e-8569-4a04-c4f3-08da004ea1f8
x-ms-traffictypediagnostic: CY4PR11MB1637:EE_
x-microsoft-antispam-prvs: <CY4PR11MB1637B9E47C629A9061BC3563E8089@CY4PR11MB1637.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lYLuH4+zHNApuxxocT//m368rRwfDfNfK+Xq/IGXFOltTqQcH+kmtUiNr66HCe1nmyhm9dhGGkT+YvCkJdu03eDyJqA636CKuQF6vx8k6bnyTMFoMawEADH3EiYc77a7yr20fa9Kb0FM+aQgmWgXHdm3DIXrumY+DUXVdSKCmbDJPBEHgfYRibW2lCQeTAbuV0aOhzpEGkSArQ+soedX9UKjS1MCTR+sgF184QwKVh3YdipLHkFfr6mq+228peU6m9qRSa3UksafRmvUvW84qS/Z894JTK4bj+PIJYg7mW6nuU8dw02t0hqS6TKdEoRsFx7/gAxMbhyaUr9fcOS/krXoUzOihEiO4nXiEbEFKJK6sgguVDdJ8jfN2AoIcQ5fkf921Cerfm8pt+ZuTyugfsBUWIBA5Vk4rwgMWFQ1aYsF5DKfDi3d/BkO7gx80f/6/VB0QZ3IZV7XPWLbKTTwu8/D5IAzeMEENnn0nN8LXt5QAAhdm2zQWUl/TnjjJbhalQFePryv033phKAX8puWF3Ykjlrnr9wc/UTSgiJG/WagOmLmjXBT069zpwYq22NAT3W3RtAOnNdFB/Or/IINIdolQKFR74+WpmyZ3/giqAN7duwuV3OS2CmgPOhFJn9/EmWaAN0zdcfXFAAfrQOscDleSUsDu+zS2Cwz8ajuaHpRD26hFA37oZZjc/8tOxF7yCaceV042IuQJuYKqj+M9gGy+wNb3gkkG0cvkkjKEqiBx7zgvHXG+aJvgmAubUwp66ACH5ML5xYks64YDcnxlrqqB5bHGtKtZOX//eBcM+32IIDyWHL+35f4ArioTp/Ihl4JHgpC94ii6EwvRDEEccSS847fpSYIAz3puOW3cS9I6VF3QsSToTO3T0XZTIod
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2758.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(76116006)(6512007)(316002)(66556008)(7416002)(5660300002)(54906003)(66946007)(91956017)(26005)(66476007)(66446008)(508600001)(8676002)(64756008)(4326008)(110136005)(86362001)(122000001)(186003)(31696002)(6486002)(966005)(36756003)(38100700002)(71200400001)(6506007)(53546011)(38070700005)(2906002)(83380400001)(2616005)(31686004)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YjQxSm5oL01aVGh0MXlDZVZReEg5SDlXSUNDRTFUS1UxbFBLUEVRVlNjWU9p?=
 =?utf-8?B?ZUhvdWhxdzgzQnU5M3pTYjM0T3dlTlRXK3B0U0VneXJmVXBXWkpnOUhQLy9W?=
 =?utf-8?B?dDJQTHZhcW51OENLNzJHQThST014eHhqdGhSc0ZBRHNobTk2Y3ZkaHVXY3B3?=
 =?utf-8?B?dTAwR2dGVm9IajE4MHE4bEtQWC95My9MLzF0cWprTHV0bklEUktIRGpZb2Vk?=
 =?utf-8?B?dW9oSkpFWkVmQ1Z4U1ptMGFVZUZ1Ti9XVzNWY2wyTTM3WmV3YTZ4dEkzbmpz?=
 =?utf-8?B?Q3dlUlpGcS9KT1JuUEFuNTVHMWRpRUdseU9tS1h0aUpvLzdibFhBOWtUcXdM?=
 =?utf-8?B?a20ydE9zdzNFZURVR2orNjNyaW10MFgxTzZjREo1OHVVM2w2dTNXZW9adm84?=
 =?utf-8?B?emxkekxuRkRxUEZFNHRLQTQ3bjNzdlYyUk1yeGRaMDYyT0NsSlRwR3FYSmRl?=
 =?utf-8?B?b0hzNmREeW1VM09mbEVFY2xad2hkRjlBMjNYQzdRRVQxWU5tVE0xK05OUXo4?=
 =?utf-8?B?NkhkSWZkNklNNFB1YnNqdHE3K2s2RllXUlB5MHNKSnU3NmNNUDF5b3hCOU1i?=
 =?utf-8?B?eDRGc0cwYWRxNTlGY3I1bS9Bem41cm1mNHlNWmozd2NBbzBQRFVoNCtPRlpV?=
 =?utf-8?B?TkhmaXc2dzB3bzlrbFFzYUpoUFNZdGNZa0pOYng3K1NJNjlCaTU1TXhmUHVx?=
 =?utf-8?B?SVdDQUsvRnoxalYxZDVDcURPaUd3Njk4QWFZdDgwMkIxVkRDa1daVC8xdDBw?=
 =?utf-8?B?WFVWQ3lob204OUliQm1uNWV5WUU2KzVJMjc3V3hwR0F1M1A1dDdqQnZlOUJ6?=
 =?utf-8?B?RFlIMDAyTlRoWkxtZEREOG10cFQ5Sm1DVkVvekU3a2J3cFZBd3M5V3pkUnJZ?=
 =?utf-8?B?Q2p2d2M3aER1YTNZWHJiNHdsRERUWWFERnl6eDNLdGpYejhNaVJYT25QSlAv?=
 =?utf-8?B?YWIycGwvVzhpTlcxSXdYRlJubXpLWGRkdXh3MFB4bFJPWEQxTUt1KzNuV3FN?=
 =?utf-8?B?WC9CR3lIVDJIN3NraWw4R3FvOEl5eWtucTVBU29rajdDTXNqVit0YkNUbmkr?=
 =?utf-8?B?c0hLS25QVWZWWjdEdEhnbGxvQ0hUejA1cXphdktMOWE5bXpSVDUvQWxldWcz?=
 =?utf-8?B?N1k5ZFg5NnU0MHRYbjJiWWZRRnIwem9BbDFEL3pKRnQ5QkxBUE50cTJBS1Zm?=
 =?utf-8?B?emNPSVpXTmlFRjVXWEcvNnBYVElDbjZPQjVlMUFUMGpKajJ1eW1MUit6VWh6?=
 =?utf-8?B?MWZUODJKcHo4VUo0VkcvRkYyQnIxMjFEUTcxWjhZbGRuTUpQK1BNYnJTaVNa?=
 =?utf-8?B?RFdaa1VPT2s5OFZUZW1UMnFXM09oSTdSMjhvcnBTL2c1dlJNWWRRNHA1Q3Zx?=
 =?utf-8?B?V3pBK1E3aTBJem1rbFlkbzNJVkhGSURnYXFPOUZRZXpMdGRVWGFLSFh2dy9h?=
 =?utf-8?B?K1pQOHJSaFlnbmpFMHlLQjgyWGdNTkpvN0g5d05OcEx3dzZPaGkvOG94RUlo?=
 =?utf-8?B?TzQ4NzEraWtLaEtzZnB6ekVwZHRJWXZuNzZRNTRxRDdjK2E1Rlk1QXhucVhP?=
 =?utf-8?B?ZEN5dVJKU29Ha1hCdFQ3WTNUWEo2VG13REM0TTlYdVZESThZcEUyenJVYlBT?=
 =?utf-8?B?WFlPZlZ1OGJIUDFTS3JlRTVJdTdiWVpWNmZrTXRXZG9kQUVXYWMvc2JacGQw?=
 =?utf-8?B?TDFUSnRnRS9YWTdmd1B3UTFiRW9sdTBSS3I3Rk1pOCtRb004Z3VjSjNGM0ps?=
 =?utf-8?B?VWdFQU5ZbFR2RzBLd3VlVmx3MkdVK2NlMFBwbmJWN09hb25aZ3kvaXI0VUtQ?=
 =?utf-8?B?b2lqdUdsY0JoUWt6QjlQcFZzd0pqc2hlV2VoaG0xU2tBQ25zWUVRNlRJcWsz?=
 =?utf-8?B?TW4xdnJkc0xlUDFTbEVTNGx3dlRLWjBZSVhhQm14TEZDQlV5UU5GaEw3Ny9l?=
 =?utf-8?B?T0VYWVk4SmtvOE5QWi9LNGkxVm5sOFlNSGc5VXRpcGlBVjd6UUNEYWl1a3ow?=
 =?utf-8?B?d3ZJVFBaWWNmMnEvNThtSmdkSlFkUjlQYXRwVGR4c2dhNGNsdE5rWnBBTmha?=
 =?utf-8?B?RG1oOTMwcm1CNGQ3ajZnbXhUNlRTdWxtaWVXS3lpcHJWS0RrN3BrQmJGS3Jm?=
 =?utf-8?B?TGxzZ3lNR0NjR2R1MFF2QmhEbk80ZkV3dDE1TXRkejJ1VVhtNDkzSUVENFZh?=
 =?utf-8?B?V2kwN3J5cnFSc3V0RzljNTFjNkZsaUJJVHZkWTQrb2lmUytOVE42YlRnaGxm?=
 =?utf-8?B?dDZ0aDVmb1NwQkxnMVlwUEw2QURnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0C2CD73968C84A408EBC5D108C3B787B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2758.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21ed940e-8569-4a04-c4f3-08da004ea1f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2022 15:24:54.9668
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 48JdjmAtFDtzTHEzRkTXfTEGuNqcOR2nFra26F85hqwgn9OE7hI8c1dUo808MRFeaMNDaPVWXw1WJcKndN9j+yZnTg3ugSYaQGVUZ2zIzhw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1637
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDcuMDMuMjAyMiAxNjo1NSwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gT24gMDcv
MDMvMjAyMiAxNTo0NiwgU2VyZ2l1IE1vZ2Egd3JvdGU6DQo+PiBDb252ZXJ0IFBXTSBiaW5kaW5n
IGZvciBBdG1lbC9NaWNyb2NoaXAgU29DcyB0byBEZXZpY2UgVHJlZSBTY2hlbWENCj4+IGZvcm1h
dC4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBTZXJnaXUgTW9nYSA8c2VyZ2l1Lm1vZ2FAbWljcm9j
aGlwLmNvbT4NCj4+IC0tLQ0KPj4gICAuLi4vYmluZGluZ3MvcHdtL2F0bWVsLGF0OTFzYW0tcHdt
LnlhbWwgICAgICAgfCA0MiArKysrKysrKysrKysrKysrKysrDQo+PiAgIC4uLi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3B3bS9hdG1lbC1wd20udHh0ICAgICB8IDM1IC0tLS0tLS0tLS0tLS0tLS0NCj4+
ICAgMiBmaWxlcyBjaGFuZ2VkLCA0MiBpbnNlcnRpb25zKCspLCAzNSBkZWxldGlvbnMoLSkNCj4+
ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9w
d20vYXRtZWwsYXQ5MXNhbS1wd20ueWFtbA0KPj4gICBkZWxldGUgbW9kZSAxMDA2NDQgRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3B3bS9hdG1lbC1wd20udHh0DQo+Pg0KPj4gZGlm
ZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wd20vYXRtZWwsYXQ5
MXNhbS1wd20ueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wd20vYXRt
ZWwsYXQ5MXNhbS1wd20ueWFtbA0KPj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4+IGluZGV4IDAw
MDAwMDAwMDAwMC4uMmQ1ZGQ1MWE2YTU1DQo+PiAtLS0gL2Rldi9udWxsDQo+PiArKysgYi9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcHdtL2F0bWVsLGF0OTFzYW0tcHdtLnlhbWwN
Cj4+IEBAIC0wLDAgKzEsNDIgQEANCj4+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BM
LTIuMC1vbmx5IE9SIEJTRC0yLUNsYXVzZSkNCj4+ICsjIENvcHlyaWdodCAoQykgMjAyMiBNaWNy
b2NoaXAgVGVjaG5vbG9neSwgSW5jLiBhbmQgaXRzIHN1YnNpZGlhcmllcw0KPj4gKyVZQU1MIDEu
Mg0KPj4gKy0tLQ0KPj4gKyRpZDogaHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvcHdtL2F0
bWVsLGF0OTFzYW0tcHdtLnlhbWwjDQo+PiArJHNjaGVtYTogaHR0cDovL2RldmljZXRyZWUub3Jn
L21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjDQo+PiArDQo+PiArdGl0bGU6IEF0bWVsL01pY3JvY2hp
cCBQV00gY29udHJvbGxlcg0KPj4gKw0KPj4gK2FsbE9mOg0KPj4gKyAgLSAkcmVmOiAicHdtLnlh
bWwjIg0KPiBhbGxPZiBieSBjb252ZW50aW9uIHNob3VsZCBnbyBiZXR3ZWVuIG1haW50YW5lcnMg
YW5kIHByb3BlcnRpZXMuDQo+DQpVbmRlcnN0b29kLg0KDQo+PiArDQo+PiArbWFpbnRhaW5lcnM6
DQo+PiArICAtIENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBtaWNyb2NoaXAuY29tPg0K
Pj4gKw0KPj4gK3Byb3BlcnRpZXM6DQo+PiArICBjb21wYXRpYmxlOg0KPj4gKyAgICBlbnVtOg0K
Pj4gKyAgICAgIC0gYXRtZWwsYXQ5MXNhbTlybC1wd20NCj4+ICsgICAgICAtIGF0bWVsLHNhbWE1
ZDMtcHdtDQo+PiArICAgICAgLSBhdG1lbCxzYW1hNWQyLXB3bQ0KPj4gKyAgICAgIC0gbWljcm9j
aGlwLHNhbTl4NjAtcHdtDQo+PiArDQo+PiArICByZWc6DQo+PiArICAgIG1heEl0ZW1zOiAxDQo+
PiArDQo+PiArICAiI3B3bS1jZWxscyI6DQo+PiArICAgIGNvbnN0OiAzDQo+PiArDQo+PiArcmVx
dWlyZWQ6DQo+PiArICAtIGNvbXBhdGlibGUNCj4+ICsgIC0gcmVnDQo+PiArDQo+PiArYWRkaXRp
b25hbFByb3BlcnRpZXM6IHRydWUNCj4gVGhpcyBoYXMgdG8gYmUgZWl0aGVyIGFkZGl0aW9uYWxQ
cm9wZXJ0aWVzOmZhbHNlIG9yDQo+ICJ1bmV2YWx1YXRlZFByb3BlcnRpZXM6ZmFsc2UiLg0KPg0K
Pg0KSW5kZWVkLCBJIGJlbGlldmUgYHVuZXZhbHVhdGVkUHJvcGVydGllczogZmFsc2VgIHdvdWxk
IGJlIGJldHRlciBoZXJlLiANClRoYW5rIHlvdS4NCg0KPj4gKw0KPj4gK2V4YW1wbGVzOg0KPj4g
KyAgLSB8DQo+PiArICAgICAgICBwd20wOiBwd21AZjgwMzQwMDAgew0KPj4gKyAgICAgICAgICAg
ICAgICBjb21wYXRpYmxlID0gImF0bWVsLGF0OTFzYW05cmwtcHdtIjsNCj4+ICsgICAgICAgICAg
ICAgICAgcmVnID0gPDB4ZjgwMzQwMDAgMHg0MDA+Ow0KPj4gKyAgICAgICAgICAgICAgICAjcHdt
LWNlbGxzID0gPDM+Ow0KPiBBbHNvIHBsZWFzZSBjaGFuZ2UgaW5kZW50YXRpb24gdG8gMiBvciA0
IHNwYWNlcyAobGlrZSB3ZSB1c2UgZm9yIGFsbCBEVFMNCj4gZXhhbXBsZXMpLiBGb3VyIGlzIHBy
ZWZlcnJlZCAob25seSBwZXJzb25hbGx5KS4NCj4NCk5vdGVkLCBJIHdpbGwgY2hhbmdlIHRoZSBp
bmRlbnRhdGlvbiB0byA0IHNwYWNlcy4NCg0KPiBZb3UgYWxzbyBuZWVkIHRvIHVwZGF0ZSB0aGUg
cGF0aCBpbiBNQUlOVEFJTkVSUy4NCj4NCk5vdGVkLg0KDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6
eXN6dG9mDQoNClRoYW5rIHlvdSBmb3IgdGhlIGZlZWRiYWNrLg0KDQpTZXJnaXUNCg0K
