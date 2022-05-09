Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0F851F79D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 11:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237621AbiEII7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 04:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237564AbiEII37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 04:29:59 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F90CDECB;
        Mon,  9 May 2022 01:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1652084763; x=1683620763;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MwOmnGO7wYv2RurCYf9f+rp8z+n8vzMTHNmoOxFCH9E=;
  b=foaqHWjspQIVxHkfZje9D7SDdC0Eovi/KGfHWtNFtV7pvOlvVLaGqzaH
   VpYsmTKhO859QTV34ZHf5jFxB5lUHNmWRDY+womtTWjXnSlmO0QoLwRQ5
   Q1EOyroVF/1KB4hJlkJd2wzl9EulIuOp+o+GztigScy07FBNPRvliLUQE
   N0swR3BmGNXt1ZqI0ef3cQT9wwH3XVmsPNV0HjXHX8DdmAHeUQFhHXSTZ
   7dN1OLGiIUytRESC86x4uwEGUltHltGXqn0VhUcnvYo396DNVAeI/xK32
   AuiYPA31nQ/7XhwyM/ucm2K1aFFtMtMRHv2KJ6xb4So2UtC9UJSeakvaN
   A==;
X-IronPort-AV: E=Sophos;i="5.91,210,1647327600"; 
   d="scan'208";a="163208876"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 May 2022 01:25:59 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 9 May 2022 01:25:59 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Mon, 9 May 2022 01:25:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MSZ32rJyGiIsl9ECQ5Vd3ziMUQ+7Eq1USPr16SezV1HGCRtCmAiqtJpVEpW5RsrUtDdbClkGRmBrE3Sn9gLggkex0cY5Ihdkr7Y9Tprc7//XSuUALLJpGfWr78I9kw4bm68cAapdZeydKTLbqiZpuabzfM8YMlIbIXQR9QGkOvSdJyX422WF8SKOKdLHcFxLU9XzTJr5h7cXad0qiJTlIqyKkUCa7j/KBeI4DIsxJFBUdw0GMqNpoHjWqNaSC8yiECWNhoYc0zVY4znQ3IqL2IiDJ+P9d0Emo+1n7PL1RbbLLT2Wn45aZbFHeZMjCgdSfTjZ8lT8ZM/0e4chcE3EEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MwOmnGO7wYv2RurCYf9f+rp8z+n8vzMTHNmoOxFCH9E=;
 b=LI3S8IKnEZksfIGmqwgTmyX0VBXjBxet2JXZ32uyc3H92tjhgJTnic53q8/8mZns27x5Oca0opIKy7zpM87jqppWd/CVrQ1jXppithw1u7uvuBPa4gyde/hX399XLY+0sW8fz4fkUMYr0QDSmZMopA4odB6sSxdV+kWOnhnRIcMnjoaO6aiHgRIa9AZFJt0/Jhhiy63WmozvLY0LzaKY2gwzaUKA7B/N0tNVouZhgMp0wSEGpfORsb9uslIz74zQeBgs6zi1Ww0LDYuzqZytGMsmVpx4/qsG4+so3SakSj2vQ+7/oTwRXk+LXzTYzwJ68TlHqs2q+CSJMtZ3SlQSzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MwOmnGO7wYv2RurCYf9f+rp8z+n8vzMTHNmoOxFCH9E=;
 b=sgOu/+zXIiYMu9UFVnSWdKQCRrYSWQK0zAb8iuS9irEZvXUK0S+oin9ODaBfe7jMswTvUsry2yxlI0aD27MHs61ltVm/7xuAKi5sJGsq6/gITgb+K2s8pWLebdi/y8SfN4ZYXPBMnzHt5tLRed959YGrIqpvgUlSBbXJh9LmkdQ=
Received: from PH0PR11MB4872.namprd11.prod.outlook.com (2603:10b6:510:32::18)
 by SJ1PR11MB6106.namprd11.prod.outlook.com (2603:10b6:a03:48b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Mon, 9 May
 2022 08:25:57 +0000
Received: from PH0PR11MB4872.namprd11.prod.outlook.com
 ([fe80::c4ee:6a61:ec4d:84e5]) by PH0PR11MB4872.namprd11.prod.outlook.com
 ([fe80::c4ee:6a61:ec4d:84e5%9]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 08:25:57 +0000
From:   <Kavyasree.Kotagiri@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Claudiu.Beznea@microchip.com>,
        <peda@axentia.se>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <lee.jones@linaro.org>,
        <linux@armlinux.org.uk>, <Manohar.Puri@microchip.com>,
        <UNGLinuxDriver@microchip.com>
Subject: RE: [PATCH 4/4] mux: lan966: Add support for flexcom mux controller
Thread-Topic: [PATCH 4/4] mux: lan966: Add support for flexcom mux controller
Thread-Index: AQHYXtx/Avzn4MraKkGCe5HYCnXqBa0NGZGAgAkixtA=
Date:   Mon, 9 May 2022 08:25:56 +0000
Message-ID: <PH0PR11MB4872AB5822FFA5C231C2EF5892C69@PH0PR11MB4872.namprd11.prod.outlook.com>
References: <20220503105528.12824-1-kavyasree.kotagiri@microchip.com>
 <20220503105528.12824-5-kavyasree.kotagiri@microchip.com>
 <e00ff3b2-d5d1-706d-49cc-e70fe2cc9cab@linaro.org>
In-Reply-To: <e00ff3b2-d5d1-706d-49cc-e70fe2cc9cab@linaro.org>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3b57941e-9b0f-4b6f-1df8-08da31958a88
x-ms-traffictypediagnostic: SJ1PR11MB6106:EE_
x-microsoft-antispam-prvs: <SJ1PR11MB610612C64432D1CD965A08BA92C69@SJ1PR11MB6106.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BJBCH7r+p1NZM4gHBo1adpYxVqCsT9Q3loMPb5PKoBHNKPh/2Cp3X9W54QNtAK6xKgNWYl5Yd0e2oIH6kYS+YuFZ13SEB+ez3i7ZuQzYxMstT5DhhhRFTq8U9RCASz1VWpb/0qS8hdAVMntlvD1/Q5WuegFEWIaJkYA1fxUKHAOg7zZ3Rd/FdDYhqUIiugbIXYYF0MFmgqVkq+mHuL7k2s/tDndfkGAY6GBLxyaUfs264bpkQRCWBd+8ewGvFSmay4CyrE6AnbE6W84WB9sxlxv2zHijPOgA8sLu8/oDaZngPt+JdlABJK7J5r3eOvZ4QGXnntdL5REMPARW9vdouKHGqQavj6ZO8o/4DmKk5Bdk4CVFsqmVLA5BVeembKLdBJfGq4fWONSE4hV70+exx2nQxpyv44mCSJzFhxtoLl0ufTQVXZFpLDxUtGycww+uWuB76UUn+I7X6/1I1QsoiwtAoELQxuW0OJ5KJdrhjSsL9E3Uwkz7gwgPIKmIRxY2OIOtzA5GFJ3vqafhWQd2a8uNILUAX8dn9ACh88PR95+NsOJkyii7qRCXLWAXVFMKMZxnScKuUkspiCuAuEKhCuvjfYQ+y/3T1fyZ88blI3wFGq1r8Xw6g58Si0nSORkq4oSXOifW9xUERM0GlR4VuQPUJCq+2HV2rqvgH8wc+Qez7j9X/Sv3qBDE+NFpRQkaYhFHj/uEXad0IpSdVF6aFA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4872.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(66556008)(8676002)(66476007)(76116006)(64756008)(4326008)(66446008)(83380400001)(86362001)(110136005)(55016003)(54906003)(316002)(122000001)(38100700002)(508600001)(38070700005)(2906002)(186003)(71200400001)(7696005)(5660300002)(6506007)(107886003)(8936002)(26005)(9686003)(33656002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RWV1L1pZRjdQMmMvTlBJSjNhdHNPNk5tZmMxK3FTeThZZlVaY3BnczdieHFr?=
 =?utf-8?B?UzJHSGcrZDBJYVQ1VzRQa2FXZ1hBeHZqTm5qeU9PbGhCeTYzZzBzS2ZUSkZx?=
 =?utf-8?B?ZmxwOUQxVHpoNDMwbXFhMThGdnlrUmJOUVUzNW13cm5kWUFxc3lVaDQ0eGM1?=
 =?utf-8?B?TEhGLy9uaHJjUktYbG12ZXMvUjFNK0YxaDlSMjJXKzcvdlpwQjg1VDFVbWln?=
 =?utf-8?B?S29XRzVkS1BYRHhYbXpXU2RFUnZTcUJpVTV1cEl6U2NVYTIrVjQ4YVlwbVZt?=
 =?utf-8?B?UncwdDRBVGR2d1JKUXV6TVFXUldyMDlyL1NRN3pBenpNZDkwUjNQR0x2Tmh5?=
 =?utf-8?B?NTBXVmJKTElZNXR3VUJ6SUhYK2R4RS9LUzV2VitwZERkMmpubWt0RWRnNXJX?=
 =?utf-8?B?UENySlpIdTkzVjUvTm4wV3NqNUpSdG95V1hqNVg1QzhhMkFBYmhQTmdSQU1G?=
 =?utf-8?B?d3NWdnFPZ1RjVmQyNEdVRzJDQW9wajJzUVNSMWRBa3lLR3hKZlE2RTQwQXNF?=
 =?utf-8?B?S1pjTTBJVXhVcnRhcGRSY2JIZUszeGZkQVU1MmlLMUFsMEFPTXpVR3ExVGg2?=
 =?utf-8?B?V2dlUi9jS2NieE54V2RQem10WHRzZ1RZOHpWVFBubHR2Sm5yQ1p5TzlnOXNO?=
 =?utf-8?B?TlkyeFVHTnhNbkdEVmNvNkVHbmVIQU51ampNazNMYTVOMVV2dTNubmNtbU1j?=
 =?utf-8?B?WVdWUVZDcjIwVFBKVjFoWk9IV2xrSTVIbkR4OXJlbk03ZDJ5Zm1hQ0JnYTVp?=
 =?utf-8?B?bU4zTU1NaTRPNVZaQjVpZUxmckwveERNVlV4L1BiaWdUWnZUUmxXTEpBVk1H?=
 =?utf-8?B?ZWhMVnIwYTUwZ253cVZGNlZRZGdnSERsKzJDZUdjRjhoeDdFTHJKU2ZCaUZy?=
 =?utf-8?B?OGVBNmZzcnlmOXZ4SkNpRUFwazJTNzc2ZW0vZVAyQkNUejlmSVRuZWhXY29I?=
 =?utf-8?B?M283K2sxdThpQW40MU9YS0lTaFF6WHppcTJYcC85SnJRbGdxTGtXTFFpZXZR?=
 =?utf-8?B?N29DblhSekdnRHZsbk1mWFpPaklrZVFmMFI3MFZldzBveUpRQ3VvcWVtdXg5?=
 =?utf-8?B?NE5NQ3grTFlBN3NmY2dSb1RpNnVxNExEWGN0YnlWYXZLQy9OT0ZZWWx6eXpL?=
 =?utf-8?B?KytUM0ZIbWdKM0I4L3A1TUtYY2x4RUdJbHFnRVh2Z1JrRlIxSy9VS05SanU5?=
 =?utf-8?B?ZTRYTUtlcUFNR3BNUEUzYWZ4WnRzNjBuSWdmbENMNFBKOUtLaDkrSjRUSHd6?=
 =?utf-8?B?dTlOR2NYQWU3ZjZaazlKQWVpYUZtdXlHRFpqRkREMUFaaDNXWkgvYzdUV3k4?=
 =?utf-8?B?anZOT2NrS1haUDZMNmU0Sm5NMnR0dldIVThpQUorYlBFaHEyd1dwNjE0UzF4?=
 =?utf-8?B?ZXlqNDcwenV6UVRlei9STDl0WkJCcTdhUnFqczhrakpYTDgra2NSTE1NMTBN?=
 =?utf-8?B?WFpkZnhhblQvMGpSd1phcFIwbzJSQmZqT1REZDFzQ2RxdU9ZY2ZSUVRIYmRM?=
 =?utf-8?B?aWwvdkdxR0M2aVlVOWhNL2tmQncvTG9jTUFKMy9OL1BUTW80SHRCeGRNdysr?=
 =?utf-8?B?VVFLRDg0NmFxTllJNnQwOHJtOWRiS3k3b0ptb3dESk5XcXpiWmhhbnFPdGVz?=
 =?utf-8?B?SkN3WERuZmdBaFU2UlJyMnFsdFk4dCs0TVFBSENhcmo5SGFOdXR1cFE0QzZu?=
 =?utf-8?B?Y1JRN3pwRlM5NzNiUkJjL2VIRlNOdHVCWEJoQVVXd2xabUNrQjZGaUFpalVo?=
 =?utf-8?B?WmM1SWxNMVR1QmFXbGZuUitKRzNnSUUxVWMwUkhRaWtWNDNlNjQ0SnZLODNm?=
 =?utf-8?B?ZHFEc0RUeTlzVkpkMDh1WjdlMkdsNENuSldmcXFjSWczSU14blZDbGE0cTB1?=
 =?utf-8?B?b2JHTE1lNnB0bTJYRS82WjNjWUJXN3dZaEd5UzRoWGR4b0wvRFJPYmNiNmdP?=
 =?utf-8?B?ZURHS1dHYXUwNU9PSi8zMWNzQlJibE02bmpySEI1TjRlL2c1RlRIamlMR3Vw?=
 =?utf-8?B?M1lRVnpOdmhNNEE4MWg3b3hPWU9HWm8rZ05hM01rbDBKQncvSUhuUWpOaDVX?=
 =?utf-8?B?U1dTYm9xWThJTzNGZmhDSXdyMy9TUDg5QmxKZVpuckpqNDNLWTBYNjVZWVRm?=
 =?utf-8?B?M0s4Ylh2c0Y0UVN6dTFsenVrMTladDlLWElTNWc5RHUvTmlPRmFlUFg5bnV2?=
 =?utf-8?B?UHVjdUphM0NKa1I3SWtiOTlKRm5JYVFCdDhqM3lCemtEVWlMdEpSSVYyUm5E?=
 =?utf-8?B?WElBanBRUFp0TTI2UGlaSFkvdU04S1c4L05YeFdsUjE5Q094ZktCSHFwV3VG?=
 =?utf-8?B?Rkg5Z2NaWWYzNkU5aDhBVjZ1enNxT2w1a00vOTBOSE8vRXIvUzl4RkY2WEJN?=
 =?utf-8?Q?CPdcvfDoN2Fwpjcs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4872.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b57941e-9b0f-4b6f-1df8-08da31958a88
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2022 08:25:56.9785
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PxXAsn4lN8QQUlk3E11qT4HD8HC0lf8y44McQXW2BTy+U7SyN2UDlt8BPCLJkQm8E6mdD9PBzm+jMAkVhhv71h1NgIMUpWmhwDJ27qN/TLakJvSgWQFGfPl81a0Njj5Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6106
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+ICsjaW5jbHVkZSA8bGludXgvZXJyLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9tb2R1bGUu
aD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L29mX3BsYXRmb3JtLmg+DQo+ID4gKyNpbmNsdWRlIDxs
aW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L3Byb3BlcnR5Lmg+
DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9tdXgvZHJpdmVyLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51
eC9pby5oPg0KPiA+ICsNCj4gPiArI2RlZmluZSBGTEVYX1NIUkRfTUFTSyAgICAgICAgICAgICAg
IDB4MUZGRkZGDQo+ID4gKyNkZWZpbmUgTEFOOTY2X01BWF9DUyAgICAgICAgICAgICAgICAyMQ0K
PiA+ICsNCj4gPiArc3RhdGljIHZvaWQgX19pb21lbSAqZmx4X3NoYXJlZF9iYXNlOw0KPiANCj4g
V2h5IGRvIHlvdSBoYXZlIGZpbGUtc2NvcGUgc2hhcmVkIHZhcmlhYmxlPyBDYW5ub3QgaXQgYmUg
cGFzc2VkIHZpYQ0KPiBwcml2YXRlIGRhdGE/DQo+IA0KSSB3YW50IGZseF9zaGFyZWRfYmFzZSB0
byBiZSBnbG9iYWwgdmFyaWFibGUgYW5kIHVzZSBzdHJ1Y3QgbXV4X2xhbjk2NnggdG8gcmVwcmVz
ZW50IG9ubHkgDQoibXV4LW9mZnNldC1waW4iIHBhcmFtZXRlcnMuDQoNCj4gPiArc3RydWN0IG11
eF9sYW45NjZ4IHsNCj4gPiArICAgICB1MzIgb2Zmc2V0Ow0KPiA+ICsgICAgIHUzMiBzc19waW47
DQo+ID4gK307DQo+ID4gKw0KPiA+ICtzdGF0aWMgaW50IG11eF9sYW45NjZ4X3NldChzdHJ1Y3Qg
bXV4X2NvbnRyb2wgKm11eCwgaW50IHN0YXRlKQ0KPiA+ICt7DQo+ID4gKyAgICAgc3RydWN0IG11
eF9sYW45NjZ4ICptdXhfbGFuOTY2eCA9IG11eF9jaGlwX3ByaXYobXV4LT5jaGlwKTsNCj4gPiAr
ICAgICB1MzIgdmFsOw0KPiA+ICsNCj4gPiArICAgICB2YWwgPSB+KDEgPDwgbXV4X2xhbjk2Nnhb
c3RhdGVdLnNzX3BpbikgJiBGTEVYX1NIUkRfTUFTSzsNCj4gPiArICAgICB3cml0ZWwodmFsLCBm
bHhfc2hhcmVkX2Jhc2UgKyBtdXhfbGFuOTY2eFtzdGF0ZV0ub2Zmc2V0KTsNCj4gPiArDQo+ID4g
KyAgICAgcmV0dXJuIDA7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3Qg
bXV4X2NvbnRyb2xfb3BzIG11eF9sYW45NjZ4X29wcyA9IHsNCj4gPiArICAgICAuc2V0ID0gbXV4
X2xhbjk2Nnhfc2V0LA0KPiA+ICt9Ow0KPiA+ICsNCj4gPiArc3RhdGljIGNvbnN0IHN0cnVjdCBv
Zl9kZXZpY2VfaWQgbXV4X2xhbjk2NnhfZHRfaWRzW10gPSB7DQo+ID4gKyAgICAgeyAuY29tcGF0
aWJsZSA9ICJtaWNyb2NoaXAsbGFuOTY2LWZseC1tdXgiLCB9LA0KPiA+ICsgICAgIHsgLyogc2Vu
dGluZWwgKi8gfQ0KPiA+ICt9Ow0KPiA+ICtNT0RVTEVfREVWSUNFX1RBQkxFKG9mLCBtdXhfbGFu
OTY2eF9kdF9pZHMpOw0KPiA+ICsNCj4gPiArc3RhdGljIGludCBtdXhfbGFuOTY2eF9wcm9iZShz
dHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ICt7DQo+ID4gKyAgICAgc3RydWN0IGRl
dmljZV9ub2RlICpucCA9IHBkZXYtPmRldi5vZl9ub2RlOw0KPiA+ICsgICAgIHN0cnVjdCBkZXZp
Y2UgKmRldiA9ICZwZGV2LT5kZXY7DQo+ID4gKyAgICAgc3RydWN0IG11eF9sYW45NjZ4ICptdXhf
bGFuOTY2eDsNCj4gPiArICAgICBzdHJ1Y3QgbXV4X2NoaXAgKm11eF9jaGlwOw0KPiA+ICsgICAg
IGludCByZXQsIG51bV9maWVsZHMsIGk7DQo+ID4gKw0KPiA+ICsgICAgIHJldCA9IG9mX3Byb3Bl
cnR5X2NvdW50X3UzMl9lbGVtcyhucCwgIm11eC1vZmZzZXQtcGluIik7DQo+ID4gKyAgICAgaWYg
KHJldCA9PSAwIHx8IHJldCAlIDIpDQo+ID4gKyAgICAgICAgICAgICByZXQgPSAtRUlOVkFMOw0K
PiA+ICsgICAgIGlmIChyZXQgPCAwKQ0KPiA+ICsgICAgICAgICAgICAgcmV0dXJuIGRldl9lcnJf
cHJvYmUoZGV2LCByZXQsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAi
bXV4LW9mZnNldC1waW4gcHJvcGVydHkgbWlzc2luZyBvciBpbnZhbGlkIik7DQo+ID4gKyAgICAg
bnVtX2ZpZWxkcyA9IHJldCAvIDI7DQo+ID4gKw0KPiA+ICsgICAgIG11eF9jaGlwID0gZGV2bV9t
dXhfY2hpcF9hbGxvYyhkZXYsIG51bV9maWVsZHMsDQo+IHNpemVvZigqbXV4X2xhbjk2NngpKTsN
Cj4gPiArICAgICBpZiAoSVNfRVJSKG11eF9jaGlwKSkNCj4gPiArICAgICAgICAgICAgIHJldHVy
biBkZXZfZXJyX3Byb2JlKGRldiwgUFRSX0VSUihtdXhfY2hpcCksDQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAiZmFpbGVkIHRvIGFsbG9jYXRlIG11eF9jaGlwc1xuIik7
DQo+ID4gKw0KPiA+ICsgICAgIG11eF9sYW45NjZ4ID0gbXV4X2NoaXBfcHJpdihtdXhfY2hpcCk7
DQo+ID4gKw0KPiA+ICsgICAgIGZseF9zaGFyZWRfYmFzZSA9IGRldm1fcGxhdGZvcm1fZ2V0X2Fu
ZF9pb3JlbWFwX3Jlc291cmNlKHBkZXYsDQo+IDAsIE5VTEwpOw0KPiA+ICsgICAgIGlmIChJU19F
UlIoZmx4X3NoYXJlZF9iYXNlKSkNCj4gPiArICAgICAgICAgICAgIHJldHVybiBkZXZfZXJyX3By
b2JlKGRldiwgUFRSX0VSUihmbHhfc2hhcmVkX2Jhc2UpLA0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgImZhaWxlZCB0byBnZXQgZmxleGNvbSBzaGFyZWQgYmFzZSBhZGRy
ZXNzXG4iKTsNCj4gPiArDQo+ID4gKyAgICAgZm9yIChpID0gMDsgaSA8IG51bV9maWVsZHM7IGkr
Kykgew0KPiA+ICsgICAgICAgICAgICAgc3RydWN0IG11eF9jb250cm9sICptdXggPSAmbXV4X2No
aXAtPm11eFtpXTsNCj4gPiArICAgICAgICAgICAgIHUzMiBvZmZzZXQsIHNoYXJlZF9waW47DQo+
ID4gKw0KPiA+ICsgICAgICAgICAgICAgcmV0ID0gb2ZfcHJvcGVydHlfcmVhZF91MzJfaW5kZXgo
bnAsICJtdXgtb2Zmc2V0LXBpbiIsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAyICogaSwgJm9mZnNldCk7DQo+ID4gKyAgICAgICAgICAgICBpZiAo
cmV0ID09IDApDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIHJldCA9IG9mX3Byb3BlcnR5X3Jl
YWRfdTMyX2luZGV4KG5wLCAibXV4LW9mZnNldC1waW4iLA0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAyICogaSArIDEsDQo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZzaGFy
ZWRfcGluKTsNCj4gPiArICAgICAgICAgICAgIGlmIChyZXQgPCAwKQ0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgICByZXR1cm4gZGV2X2Vycl9wcm9iZShkZXYsIHJldCwNCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgImZhaWxlZCB0byByZWFkIG11eC1vZmZz
ZXQtcGluIHByb3BlcnR5OiAlZCIsIGkpOw0KPiA+ICsNCj4gPiArICAgICAgICAgICAgIGlmIChz
aGFyZWRfcGluID49IExBTjk2Nl9NQVhfQ1MpDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIHJl
dHVybiAtRUlOVkFMOw0KPiA+ICsNCj4gPiArICAgICAgICAgICAgIG11eF9sYW45NjZ4W2ldLm9m
ZnNldCA9IG9mZnNldDsNCj4gPiArICAgICAgICAgICAgIG11eF9sYW45NjZ4W2ldLnNzX3BpbiA9
IHNoYXJlZF9waW47DQo+ID4gKw0KPiA+ICsgICAgICAgICAgICAgbXV4LT5zdGF0ZXMgPSBMQU45
NjZfTUFYX0NTOw0KPiA+ICsgICAgIH0NCj4gPiArDQo+ID4gKyAgICAgbXV4X2NoaXAtPm9wcyA9
ICZtdXhfbGFuOTY2eF9vcHM7DQo+ID4gKw0KPiA+ICsgICAgIHJldCA9IGRldm1fbXV4X2NoaXBf
cmVnaXN0ZXIoZGV2LCBtdXhfY2hpcCk7DQo+ID4gKyAgICAgaWYgKHJldCA8IDApDQo+ID4gKyAg
ICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiA+ICsNCj4gPiArICAgICByZXR1cm4gMDsNCj4gPiAr
fQ0KPiA+ICsNCj4gPiArc3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9kcml2ZXIgbXV4X2xhbjk2Nnhf
ZHJpdmVyID0gew0KPiA+ICsgICAgIC5kcml2ZXIgPSB7DQo+ID4gKyAgICAgICAgICAgICAubmFt
ZSA9ICJsYW45NjYtbXV4IiwNCj4gPiArICAgICAgICAgICAgIC5vZl9tYXRjaF90YWJsZSA9IG9m
X21hdGNoX3B0cihtdXhfbGFuOTY2eF9kdF9pZHMpLA0KPiANCj4gb2ZfbWF0Y2hfcHRyIGNvbWVz
IHdpdGggbWF5YmVfdW51c2VkIG9uIGRhdGEgc3RydWN0dXJlLiBBcmUgeW91IHN1cmUgaXQNCj4g
ZG9lcyBub3QgaGF2ZSBXPTEgd2FybmluZ3MgZHVyaW5nIGNvbXBpbGUgdGVzdHM/IEp1c3QgZHJv
cCB0aGUNCj4gb2ZfbWF0Y2hfcHRyLg0KPiANCk5vLCAgSSBoYXZlbid0IG5vdGljZWQgYW55IHdh
cm5pbmcuIE90aGVyIG11eCBkcml2ZXJzIGFsc28gZm9sbG93IHRoZSBzYW1lLg0KDQo+ID4gKyAg
ICAgfSwNCj4gPiArICAgICAucHJvYmUgPSBtdXhfbGFuOTY2eF9wcm9iZSwNCj4gPiArfTsNCj4g
PiArDQo+ID4gK21vZHVsZV9wbGF0Zm9ybV9kcml2ZXIobXV4X2xhbjk2NnhfZHJpdmVyKTsNCj4g
DQo+IE1pc3NpbmcgTU9EVUxFKCkgc3R1ZmYuDQpPay4gSSB3aWxsIGFkZCBpdCBpbiBuZXh0IHZl
cnNpb24gb2YgcGF0Y2ggc2VyaWVzLg0KDQo+IA0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5
c3p0b2YNCg==
