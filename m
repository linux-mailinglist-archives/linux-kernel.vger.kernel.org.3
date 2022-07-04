Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A854B564DC6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 08:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbiGDGjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 02:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiGDGjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 02:39:22 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7D2265F
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 23:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1656916760; x=1688452760;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8brNd+OMdxtsk1tucRkrNWEq6uUhKOEAl3BZnlns+n0=;
  b=hYaYRpJvd1l3j2VmxckwBbcJh52nCfTbJW1/nevS4aswKoV+GPqHYMt/
   FrhAVkdPEU7gF8HFmhnBfLOQq8eKQPw9vta12dHifXmDbpxpWswZJVf4l
   JzN5GoJme4B9cfUjHp0HDtPq18PHydFZPxz3MEJAhMt76O2TeX0j5NwQ+
   Dgijwefz7j83Zeb217+42lnW+z6QuefrHlRTJ5TZllwTEnTLSs3o0FY2F
   7kTTJbR6bRjwGloi+RKiV+u4VCAwQTsw45r+UUFf08wJA8prIHmMfj/JQ
   urEvySgkqCpTSZFRFLkIFeqipAP3tAWGVRpLTyHNLIVcbAF7192clmgRk
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="166225344"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Jul 2022 23:39:19 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Sun, 3 Jul 2022 23:39:17 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Sun, 3 Jul 2022 23:39:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NaYE/vmoNdzQvl+3ERoJJLF5BlLabPifoIK3GUiPN7Cfe9/q9fPzACk+9sV8cqNn30wwTg+tOn17TAZN7/ShcA3kTIJ/Flz8t8tND0rKfhBwNriYR+tPqrXT9Mw2AEu+XYR5rlAbDSg8K9Cfj6QexDOTR3Bx5fDrd+5nV2ZFx/AupJKYBuk8NmgY9r6eaRbYhtv+qw1A0/o28GHGCUNek6E38HmTEaY4KOqZqtn/q5Kn7TJOzjg+Dqe+Mlvv08aFGzLmH0rE8X2hh9dyCSTt2fxO2WK0YYNpJ/c76AvB6RRnNsv9J0qfOYOMD44XinEQbQt/zgToJt9/KNaH8RM1RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8brNd+OMdxtsk1tucRkrNWEq6uUhKOEAl3BZnlns+n0=;
 b=f1TpoOc6K2B8QXXDCqE+bpCB6gkuSRvtbcDRcKELRhAc07igHE5xqAf2omoBwTiQjN2t01/oUS3a3XfpwGHAG3LxrDm1UyrXNSW9gDbta6hJld0xSsIvGKwEA/MMACtpaziZuUvC93vIbqSzESMdVO1DwUQaSukOH4ZsAAZexOsM2Nft23UcZCsBMw+x2llh1Xlol3nsn024fRalvfx/FakKj6OtYBqZBmEnLAVO8WJdp1Wozv8sBao+AANxFPkE7c8PdZv/De78XRejCejxAn3qIRu+nlN0JSNBpvEnElsrEEFBuldCfwUEameVFG1GWSsP0jS82E7Bsip8FkTa5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8brNd+OMdxtsk1tucRkrNWEq6uUhKOEAl3BZnlns+n0=;
 b=vXQ6V1lXOukzL4T4SeEraKPmdPDgdGz8SCD+aDA3zXT2DvP1ux0W4fD68fzaZRJSm2XWBqHFD7g0oms1V/m/NJJ44zTcc5R7t1/is+txmvxTk2wkO9ofrfjH9SPC6RSu1Qq5oBRORmWTOxuHXRxq67AAypYX9hvxFWczvgc1Vr0=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by DM6PR11MB3497.namprd11.prod.outlook.com (2603:10b6:5:6e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.18; Mon, 4 Jul
 2022 06:39:11 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5c8c:c31f:454d:824c]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5c8c:c31f:454d:824c%8]) with mapi id 15.20.5395.020; Mon, 4 Jul 2022
 06:39:11 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <clement.leger@bootlin.com>, <linux@armlinux.org.uk>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 2/2] ARM: at91: setup outer cache .write_sec() callback if
 needed
Thread-Topic: [PATCH 2/2] ARM: at91: setup outer cache .write_sec() callback
 if needed
Thread-Index: AQHYj3DEluxF7kPq7kujGFPzpA3vkQ==
Date:   Mon, 4 Jul 2022 06:39:11 +0000
Message-ID: <7f89d904-75d8-9dff-2d11-7511867de2d8@microchip.com>
References: <20220606145701.185552-1-clement.leger@bootlin.com>
 <20220606145701.185552-3-clement.leger@bootlin.com>
In-Reply-To: <20220606145701.185552-3-clement.leger@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d48ee7a0-1951-4d51-4687-08da5d87e785
x-ms-traffictypediagnostic: DM6PR11MB3497:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aFyHuA4HZDjt6i0l2MOxuFOY7SVKUt4Ux24Q1NsxUwAb+8NNlH0bULtmfhV2cu70BAFR+VZG2mZH4+d7/Q+QCLeYMoK/GzOMQabH5x7keYt0HQtoDoqHCp9K2Y+D9oGP7oCd0rPPQX0HIEi2x5fU3jIbS0BLyL3xYu53siIPbyEwoowBBvHp3ziHQEKGzyrXXQMqXtlH23dsES8lpK5vhX1Pyypc0ITDnEVWqlUihN9Re362OPpAxX0z1VUy97+jrs7q1vNtvEszvuKzrOUDdUJRG+jmtDvkjpezhWug3ztAx7MK+wqUAEpds6AixlRzrsHxeH1/l5rAycU+Xy3NRmcFW4vzx72oFeMPPeslzP9dXoOiZQaWBgPuhXFNWVyCPJmDTZb0ohdzKHfvoJ8LsA3kuAlk/vJtBRZJO/uMcG1oEs6Sk2J8xKoxy/Ix3iTNMi8ivxg5ilAo9zLpvrsc9yjF8BUckZsNp0hls15EVPbD5mFor03LN2LDd5pbPT2HmhHU4ayj1sdmU75AzrEN8hNkjMblyHv8Ydmka6qcnmzh45xLrQFEhwxyHWZGL/M+nYEu+J3gI3C/3bbCzs3WYyHlbKn2cvJECkrbh4p/449DL0lCQuvLN2fc92XtTww/2FjGkv431HW3n0anu7ZHYh9VQlpzhM0wCVOdPiqIaKIJ14uNAfyotfj5WUREVkfIOF266SWlFN8/KWDb4Qj0wijvLZNgfzLp77i/LPOik6weDPcP6oJ5nf4mkLJ+JmL4RaFVebveuObwws2aDqHCWux31nBXL7aw5uRqf4ot4WIfkSi+fbTyRdjM3DYklgpctU3NGIxVicvDMZdy2NWYAW20sUGujzAUaTF/m+jHrIpZ66D9KU7v925oc8Wy26UO9N6Xn59XqMQ4QVt3Dvd2IA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(39860400002)(346002)(376002)(396003)(5660300002)(4326008)(76116006)(8936002)(31686004)(26005)(31696002)(53546011)(6506007)(91956017)(8676002)(66946007)(66556008)(66476007)(66446008)(64756008)(36756003)(2906002)(2616005)(66574015)(186003)(38100700002)(54906003)(110136005)(478600001)(6512007)(86362001)(38070700005)(41300700001)(316002)(6486002)(122000001)(71200400001)(142923001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MTNtb0RWOG5qaURaRmZucldZSVdBeEs3OGVKRlBuWXpScTM1Y0dZa25vanNY?=
 =?utf-8?B?Z20rZG1CM2xXbkZnTVk0aGNzc05pR0lLaWlBV3pjcUR0ZGhqOHRKUEVOYkRv?=
 =?utf-8?B?VkdJelRoMVV4aXpJRkgzR2RwMkpINVM4VlhWVFJMR2d3M3JVbnpNVzlwS3pq?=
 =?utf-8?B?ZHdCKzBXdzZNT2tPTEhjUUlMNDI3elQ5czZuU2pxRFo1dVNydmxlaEJBV1or?=
 =?utf-8?B?T2x4OFNFbERWVkZFWng4elI5c1FlbG0yb3dTSm1GZ3dEZm9BcS92dGpDMW9v?=
 =?utf-8?B?R0ZxbDcydG5HV3pJR3VhajdySmxYZy9ZZXlSZWlhQ1F1Y1dSMlIrZGJlSTll?=
 =?utf-8?B?KzRLZEVQdlUrL0JYSDlFMFNwN3dISTJwUVFwQ01rUG1ZQTFyRzl5UjFiTjQr?=
 =?utf-8?B?OEo1RHJpVTZqOFlPYVhXdHpTV0hsc3krekxSeUc4Z0x1MTM3OVpNZmc1emhD?=
 =?utf-8?B?dnUyaHBqQ0c0NzNoQ20vUEdsZ0RUakZiK043VlROSFhncjNoZ3hHQkxsQStC?=
 =?utf-8?B?SEF4ZHo5VzNlaTJZbjNCSWswdUxhVXdMZm5jMzBKYkJRNkVURXoyK1lOZnor?=
 =?utf-8?B?WWtKV1NxVk5MNWxOTVVBT1Vad01TN2Y3U290TnZWVzJ6SGhiY1lwcHNIenF4?=
 =?utf-8?B?YTdOVktGV3NUQi83VXk0U0NHaW1Eb0JVdUEwVHJvclNqbis0bklvd1VUcC90?=
 =?utf-8?B?dDZmWUJ6WnZZTm9SR1pBb0ZmMWVOaEpVdGhKVlBrYVlweEJmTmQwZjZDNWNj?=
 =?utf-8?B?anllMTFtY25RZ2FaVmlLUWRMbGh6eUlqVS9KaG9XT25ZWkFCaU4rc0o0QXJp?=
 =?utf-8?B?cHVPZTdjNWVDa1RxU0owWkRRSTdSVzM1ay9abkt2dGp5RHExOHJjR0J1MUJ0?=
 =?utf-8?B?Y3VnSFNZUHdYYjhqTC9TVkh5ZnpQRU5OcWZqeXdjQUpUNWpDYlpyUFhtZDhq?=
 =?utf-8?B?SkRjVFJBbTZBYnY0blBudEZQRVU0TXNwcWFzWTlZZkNHa0loVlNCOUlSNk9z?=
 =?utf-8?B?M29iQmlRSmUxOXpuODVWaGZsdWdjdXVnRklER3hxTGU1eHZzZXcyMjRXY1lK?=
 =?utf-8?B?TDlGZUdlRHdlRFhIaXVMTmJodXorR3YxdytCYkl6Y0t0OW1hNFE5Rk4yY053?=
 =?utf-8?B?RXo3V0VVL045bG5YMWpvbU1RRit2Uk0yUEk5VzQ4M01YSDM0dE50MXBmUmRH?=
 =?utf-8?B?MHJwamhxVFpYdUhObFpNOTYzckF1dzdLZWZadDk5dTl1Wjg3R3ptcS9pNWJB?=
 =?utf-8?B?S1MyQXN2ZTlzdHVUOGJRRkxVWXNjWGExRmNTV3k2Sjlnb3A1ZkNTSW5SQmZY?=
 =?utf-8?B?SjBqcTJzMmlNVTRGME9VR3djdXlNaXlXQlpMYWtJMlpOaWNBSmszZ004SEdO?=
 =?utf-8?B?TG5oaVF1YUFNTmZmclQ0STlYSE1FakJYOGJCcmtDRUgrOVpsckNURGpRRUFt?=
 =?utf-8?B?eFVLWVRxb25rc1pHRUJya2RILzZMbThJbGtDcTVWNEhUUDRzSkV0b0dESVJy?=
 =?utf-8?B?cnRGcVdZVmxUTHFkZjA4MHVkQlVyUDRzelB3ZkxxN1pSMkZRVGZXTUw2ejJW?=
 =?utf-8?B?MDR2SStCMmY2QUFiSzd6RUdVQ1NRWVB0RXdaN2djSHp6K3FndldOaVlDbkpP?=
 =?utf-8?B?VDVFanVVay91NXVIbk5Yc3BQMCtUdG9wRXlCU1FGaWVKbFdPK25wQVVJd0tk?=
 =?utf-8?B?Qi9JVE14ckdlRnFFcC8ySzM2NkFRdW05OENaYzJ0YXFzNmhyZmVNZ3BtWU5L?=
 =?utf-8?B?V24ydlJFc20zMXo1VXhzbHFETkdUbENPSnRySWhDanBrZk9Vd3pOWTBPM2FN?=
 =?utf-8?B?WXVXQ2pnOGNGNDkyYmN6c2ljeCtwZ3NmRktqd1RDRWd5SkYzV3JjdWNqWmpV?=
 =?utf-8?B?WjAxdjVva0sxQUUwS0U5L1BTRFdKTW5ac3NXZEd0OE9HWWp2ZkQ0cHpnUi9q?=
 =?utf-8?B?a1NjWWtTMlg5bWNzTHhvVFAvWkZUTWJJd2VHMzFwNmlUQUxpVDRybWQwdXBL?=
 =?utf-8?B?dDFPc0p6NTYyVE5hbm5zS0xRaHNxOXBBc0xmWlV1VEt1ZDEyZll6eEE4VmZK?=
 =?utf-8?B?YU1JTzFJeEpPWGIwVUo5bjJaYzA1b2JoWkh5NWJrMXB4ZVRDZDZKOHIwTU5Y?=
 =?utf-8?B?NmJrMHhoaENoV25QbE1tcCtYZDNSNHhJa05heDNQeE8wd0pnb2pPRFd3aFVO?=
 =?utf-8?B?emc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <82BF5D3E271C104694E88E4F1610E70D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d48ee7a0-1951-4d51-4687-08da5d87e785
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2022 06:39:11.2429
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aK4MhbRYb4NMQeAT9q8tjET5l9RhAK8ECsbS80ZSdlNXhgsyvoaSRjt7EpQkbrrPDvLBNHrrWISlDN+of+7CRrrt50byH1zvoeUqBac9mxw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3497
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDYuMDYuMjAyMiAxNzo1NywgQ2zDqW1lbnQgTMOpZ2VyIHdyb3RlOg0KPiBFWFRFUk5BTCBF
TUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBr
bm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IFdoZW4gcnVubmluZyB1bmRlciBPUC1URUUs
IHRoZSBMMiBjYWNoZSBpcyBjb25maWd1cmVkIGJ5IE9QLVRFRSBhbmQgdGhlDQo+IHNhbSBwbGF0
Zm9ybSBjb2RlIGRvZXMgbm90IGFsbG93IGFueSBtb2RpZmljYXRpb24geWV0LiBTZXR1cCBhIGR1
bW15DQo+IC53cml0ZV9zZWMoKSBjYWxsYmFjayB0byBhdm9pZCB0cmlnZ2VyaW5nIGV4Y2VwdGlv
bnMgd2hlbiBMaW51eCB0cmllcw0KPiB0byBtb2RpZnkgdGhlIEwyIGNhY2hlIGNvbmZpZ3VyYXRp
b24uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDbMOpbWVudCBMw6lnZXIgPGNsZW1lbnQubGVnZXJA
Ym9vdGxpbi5jb20+DQo+IC0tLQ0KPiAgYXJjaC9hcm0vbWFjaC1hdDkxL3NhbWE1LmMgfCAxNyAr
KysrKysrKysrKysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKykNCj4g
DQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9tYWNoLWF0OTEvc2FtYTUuYyBiL2FyY2gvYXJtL21h
Y2gtYXQ5MS9zYW1hNS5jDQo+IGluZGV4IGRlNWRkMjhiMzkyZS4uZDFhOWU5NDBhNzg1IDEwMDY0
NA0KPiAtLS0gYS9hcmNoL2FybS9tYWNoLWF0OTEvc2FtYTUuYw0KPiArKysgYi9hcmNoL2FybS9t
YWNoLWF0OTEvc2FtYTUuYw0KPiBAQCAtOSwxMyArOSwyNyBAQA0KPiAgI2luY2x1ZGUgPGxpbnV4
L29mLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvb2ZfcGxhdGZvcm0uaD4NCj4gDQo+ICsjaW5jbHVk
ZSA8YXNtL2hhcmR3YXJlL2NhY2hlLWwyeDAuaD4NCj4gICNpbmNsdWRlIDxhc20vbWFjaC9hcmNo
Lmg+DQo+ICAjaW5jbHVkZSA8YXNtL21hY2gvbWFwLmg+DQo+ICsjaW5jbHVkZSA8YXNtL291dGVy
Y2FjaGUuaD4NCj4gICNpbmNsdWRlIDxhc20vc3lzdGVtX21pc2MuaD4NCj4gDQo+ICAjaW5jbHVk
ZSAiZ2VuZXJpYy5oIg0KPiAgI2luY2x1ZGUgInNhbV9zZWN1cmUuaCINCj4gDQo+ICtzdGF0aWMg
dm9pZCBzYW1hNV9sMmMzMTBfd3JpdGVfc2VjKHVuc2lnbmVkIGxvbmcgdmFsLCB1bnNpZ25lZCBy
ZWcpDQo+ICt7DQo+ICsgICAgICAgLyogT1AtVEVFIGNvbmZpZ3VyZXMgdGhlIEwyIGNhY2hlIGFu
ZCBkb2VzIG5vdCBhbGxvdyBtb2RpZnlpbmcgaXQgeWV0ICovDQo+ICt9DQo+ICsNCj4gK3N0YXRp
YyB2b2lkIF9faW5pdCBzYW1hNV9zZWN1cmVfY2FjaGVfaW5pdCh2b2lkKQ0KPiArew0KPiArICAg
ICAgIHNhbV9zZWN1cmVfaW5pdCgpOw0KDQpXaXRoIHRoaXMsIGNvdWxkIHRoZSBzYW1fc2VjdXJl
X2luaXQoKSBpbiBzYW1hNWQyX2luaXQoKSAobm90IGxpc3RlZCBpbg0KdGhpcyBkaWZmKSBiZSBy
ZW1vdmVkPw0KDQo+ICsgICAgICAgaWYgKHNhbV9saW51eF9pc19pbl9ub3JtYWxfd29ybGQoKSkN
Cj4gKyAgICAgICAgICAgICAgIG91dGVyX2NhY2hlLndyaXRlX3NlYyA9IHNhbWE1X2wyYzMxMF93
cml0ZV9zZWM7DQo+ICt9DQo+ICsNCj4gIHN0YXRpYyB2b2lkIF9faW5pdCBzYW1hNV9kdF9kZXZp
Y2VfaW5pdCh2b2lkKQ0KPiAgew0KPiAgICAgICAgIG9mX3BsYXRmb3JtX2RlZmF1bHRfcG9wdWxh
dGUoTlVMTCwgTlVMTCwgTlVMTCk7DQo+IEBAIC0zMCw2ICs0NCw3IEBAIHN0YXRpYyBjb25zdCBj
aGFyICpjb25zdCBzYW1hNV9kdF9ib2FyZF9jb21wYXRbXSBfX2luaXRjb25zdCA9IHsNCj4gIERU
X01BQ0hJTkVfU1RBUlQoc2FtYTVfZHQsICJBdG1lbCBTQU1BNSIpDQo+ICAgICAgICAgLyogTWFp
bnRhaW5lcjogQXRtZWwgKi8NCj4gICAgICAgICAuaW5pdF9tYWNoaW5lICAgPSBzYW1hNV9kdF9k
ZXZpY2VfaW5pdCwNCj4gKyAgICAgICAuaW5pdF9lYXJseSAgICAgPSBzYW1hNV9zZWN1cmVfY2Fj
aGVfaW5pdCwNCg0KVGhpcyBpcyBmb3IgdGhlIGdlbmVyaWMgImF0bWVsLHNhbWE1IiB3aGljaCBj
YW4gYXBwbHkgYWxzbyB0byBzYW1hNWQzIG9yDQpzYW1hNWQ0LiBJIGtub3cgdGhpcyBpcyBoYXJt
bGVzcyBmb3IgZnVuY3Rpb25hbGl0eSAoZXhjZXB0IG1heWJlIHdoZW4gb3B0ZWUNCmlzIGluIERU
KSBidXQgZG8gd2Ugd2FudCBpdCBoZXJlPw0KDQo+ICAgICAgICAgLmR0X2NvbXBhdCAgICAgID0g
c2FtYTVfZHRfYm9hcmRfY29tcGF0LA0KPiAgTUFDSElORV9FTkQNCj4gDQo+IEBAIC00MSw2ICs1
Niw3IEBAIHN0YXRpYyBjb25zdCBjaGFyICpjb25zdCBzYW1hNV9hbHRfZHRfYm9hcmRfY29tcGF0
W10gX19pbml0Y29uc3QgPSB7DQo+ICBEVF9NQUNISU5FX1NUQVJUKHNhbWE1X2FsdF9kdCwgIkF0
bWVsIFNBTUE1IikNCj4gICAgICAgICAvKiBNYWludGFpbmVyOiBBdG1lbCAqLw0KPiAgICAgICAg
IC5pbml0X21hY2hpbmUgICA9IHNhbWE1X2R0X2RldmljZV9pbml0LA0KPiArICAgICAgIC5pbml0
X2Vhcmx5ICAgICA9IHNhbWE1X3NlY3VyZV9jYWNoZV9pbml0LA0KDQpTYW1lIGhlcmUgZXhjZXB0
IGl0IGFwcGxpZXMgdG8gc2FtYTVkNCBvbmx5Lg0KDQo+ICAgICAgICAgLmR0X2NvbXBhdCAgICAg
ID0gc2FtYTVfYWx0X2R0X2JvYXJkX2NvbXBhdCwNCj4gICAgICAgICAubDJjX2F1eF9tYXNrICAg
PSB+MFVMLA0KPiAgTUFDSElORV9FTkQNCj4gQEAgLTYwLDYgKzc2LDcgQEAgc3RhdGljIGNvbnN0
IGNoYXIgKmNvbnN0IHNhbWE1ZDJfY29tcGF0W10gX19pbml0Y29uc3QgPSB7DQo+ICBEVF9NQUNI
SU5FX1NUQVJUKHNhbWE1ZDIsICJBdG1lbCBTQU1BNSIpDQo+ICAgICAgICAgLyogTWFpbnRhaW5l
cjogQXRtZWwgKi8NCj4gICAgICAgICAuaW5pdF9tYWNoaW5lICAgPSBzYW1hNWQyX2luaXQsDQo+
ICsgICAgICAgLmluaXRfZWFybHkgICAgID0gc2FtYTVfc2VjdXJlX2NhY2hlX2luaXQsDQo+ICAg
ICAgICAgLmR0X2NvbXBhdCAgICAgID0gc2FtYTVkMl9jb21wYXQsDQo+ICAgICAgICAgLmwyY19h
dXhfbWFzayAgID0gfjBVTCwNCj4gIE1BQ0hJTkVfRU5EDQo+IC0tDQo+IDIuMzYuMQ0KPiANCg0K
