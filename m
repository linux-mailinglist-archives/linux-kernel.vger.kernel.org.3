Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A85A84D94F0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 07:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345304AbiCOG7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 02:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239585AbiCOG7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 02:59:32 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75651DE87;
        Mon, 14 Mar 2022 23:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1647327497; x=1678863497;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8d/amvquNbj35HY2jiQHUM33wcQiUdbojn5Ahjw3qC0=;
  b=jc6zTMVIXKK6jlE9ii9Q6xVPYZGWwhP6bO9KeBV40xmf3DIJovqqinDI
   UFyrj90C3GWUl5N6L1zGJesuoN+9dO2REAPl2wvGIMJvXPEXnqvwm6pYX
   YnjYx8yRxme4hC15nhc2X7OOirY9YoKN7X/cV5BVJQjUI1KblZyNuKSiI
   CZ5Urywz0ebNXnK9wpmvzuyoS4iB4iTKRIR7e0sPOSGlxh/1tzic8RzMk
   Tx6+zY1hFDBUQFqiNEuLYXs2/AVRBWyJS6ztnoD3SVPkKKt3T3I5fC+rG
   IVyOceG+9vR6gttTOWxQwBsRnHDYVmKxDWhc1BhHWScPYc0cgGDC1Yl/W
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,182,1643698800"; 
   d="scan'208";a="88942561"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Mar 2022 23:58:16 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 14 Mar 2022 23:58:16 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Mon, 14 Mar 2022 23:58:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GFBhbhEh5uboLlvUJjogn9MYTjosDE78pAVbin0iT/gswtp7L4NYbCl1GX0ejkHpvyBSWbkfgbHFtGCc5km/DyaqfH2WSjmrNuCfUUUplbkM/0R1Kl5gYv3WnHla1BvmiH6ufof4uSJdq7vLoij1P4EcD9tzVQoWdNGEvJsN84zBbmh9ut0q2T8xp408/7t5ybylTig8IoEVe+LcnTp+mOkjz2+w8KnQt1KiE4oU5Tl2ohuD/BtSrrwkQbqQsKGyrCuDbClL/bkZ0+U8WQdG/ocxeXqeLSfLXD7cqOXOZfWgvYhVALF5V0yUKVcAjlVze8c17G34paQd+Kg+QrRX2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8d/amvquNbj35HY2jiQHUM33wcQiUdbojn5Ahjw3qC0=;
 b=Almri+4HqFFNZhYWKW20ekmlaVdlSpGXno7l8ilPzCTbSzFwHhrQk9P0zx9By4FKHEIc/XondpqFfUiSjxW4VVNEO2TPHd4BFMN7800XUJzBxv53207y7aMGidmkRofp1jT0KxusG+VszgFfYyi0K4OcYyok9Z0Ip1A52I0YkpVupTihBZeeBqwG8BMnjV/kjpH6wdHbbG7cPvruKAs0gDt/9dDqx18Kj4PP2tck9+Ucor2Gyy7GkVZKOzkEu/h4ddrMi3xWqyuzFZgUH9fuz/jl2gnUNgOtCbPJcRLEaPeem9oSrp1xTdh/AjqZXB1prE+MiKcR0hv4RKMD16JB8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8d/amvquNbj35HY2jiQHUM33wcQiUdbojn5Ahjw3qC0=;
 b=mM5yofiWrfpqrJOduSH/8/lD81pq4YU9lCGEDN2bMnNUvFfX/7CW5YWjfyzx3qDvQHRvwmIaQcBjh+jvU1qEsnoaxgMefx+9UPt50tlfc8khZ9fa6jwaWe+YsAhQTlYpHjlb+bpKnYPNMb5pY1/Wxx5hzP0hIyyJUyiyKHPp3Hk=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SJ0PR11MB5600.namprd11.prod.outlook.com (2603:10b6:a03:3ab::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.21; Tue, 15 Mar
 2022 06:58:10 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::dc94:3c7c:8ef8:21b9]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::dc94:3c7c:8ef8:21b9%5]) with mapi id 15.20.5061.028; Tue, 15 Mar 2022
 06:58:10 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <vigneshr@ti.com>, <p.yadav@ti.com>, <michael@walle.cc>,
        <broonie@kernel.org>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <Nicolas.Ferre@microchip.com>,
        <zhengxunli@mxic.com.tw>, <jaimeliao@mxic.com.tw>,
        <andreasilvagni@macronix.com>
Subject: Re: [PATCH v2 0/6] spi-mem: Allow specifying the byte order in DTR
 mode
Thread-Topic: [PATCH v2 0/6] spi-mem: Allow specifying the byte order in DTR
 mode
Thread-Index: AQHYODoHoecUsXbOo0Oqo0422amT1Q==
Date:   Tue, 15 Mar 2022 06:58:09 +0000
Message-ID: <9e0b6bde-838d-b8a4-9fe7-75c4f916fb27@microchip.com>
References: <20220311080147.453483-1-tudor.ambarus@microchip.com>
 <76eb13b6-9263-975f-3196-312259634301@ti.com>
In-Reply-To: <76eb13b6-9263-975f-3196-312259634301@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 176b2402-ae66-4159-b90a-08da06512a74
x-ms-traffictypediagnostic: SJ0PR11MB5600:EE_
x-microsoft-antispam-prvs: <SJ0PR11MB560097C8DD2EFD612A525DE3F0109@SJ0PR11MB5600.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BhVlg/lnrtCFrGupW+4qQDeXCZzSkN2aFQ5hqw5/4mQHElWzqMnD2DradiEJ45q569M9lLd/fPx4IokFXfjCPRzMJO4NgwBwn3kQOnTu3sY1AZJDwEfuKLhUFNMW6vBqEcKwrKcrG2z8pU9qv1tcopBPFG+JU+Ls2+6z1zyG16tMOrHyh609BptSqeXwuv6QqP16Yt+WMYR6Qdf91IMogXCuwExY5GfGAyyXptBQjSLUdOk533CFqwb3oMPmsLG5NrW9EiqfEDGKmRV+0/hIAxgbp909btdSJ+zv0PgL4qaDRJG710vXGAqyI2cznYmZiS2JlxuNNfzBLESE8M+JfjL4xORfvsKT3Ak1/zIG63+wpRtd4ZVGNoBS+C/HxXva0QpAFwgYmoAaPtOIzCEYzur/QWrlCNVdvhIoSNMkIzDx8wnyLFc4h7Oqdx/y5QHVzJArTBPpJdhpzLNqLGrzy7O5vEwt3nClryU4PJnMUnVf/miZixBTR5rNRJKYlx+Svi89c+8ok4g1xTyKr0UXUenofGpDJSIa1F8p5FwREnSkrwJm+nSPvp4nMn3Qhwmg00GboVORaofc+HEglbH8tIW392wlHFK6KSHT934FKotc3j6VAFsx9gcv1aO/6WlWxRdgpMKSQheNneEwQOqe5CP7lwKzcrQeuO4fxQKiuIMbC8qXLUVfSQVCHeqkiBC5R+GCdHG2bdxVCMS42vu1ag1uQWxSmt47K0/Gzw9DBQosIdV306tpURkjgNM74UN2TiqwOihiR9xVrcLhV8gXyg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(91956017)(4326008)(316002)(2906002)(31696002)(86362001)(8676002)(38070700005)(76116006)(66556008)(64756008)(66446008)(6506007)(53546011)(508600001)(66476007)(66946007)(8936002)(2616005)(38100700002)(71200400001)(36756003)(31686004)(6512007)(110136005)(54906003)(122000001)(6486002)(26005)(186003)(7416002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UHJnUng3SE5iY3NJRHVoS05UTEZSdEhQNkF1dTVlblpsZ2tQYlQwQlY3TzNt?=
 =?utf-8?B?Tno1K3VadmttWGcrb2lMWlErNEVsQ1ZHcTMvdFlmSnhjc1ZYa0oxQ0FxOGtv?=
 =?utf-8?B?OVA3YnN5eEZpVTNZV2pIdnNFcnI2K2JrY1FOVU5iVEl1THZDSGFJTjN3T2t5?=
 =?utf-8?B?eWxEbmNhYzArMGNGZFRyRExIdUtIaGtMdUJacHVnYjU2bnZSOWx6c09JZXd0?=
 =?utf-8?B?a3VCcFZVTDVJQytGbExIV1dVc3QvbnYxWjVpMVhKMWp6K0FyUStGbkoySGta?=
 =?utf-8?B?dnFmSHlZZDFWQlU4WURNWW5XbURwZ2xvQ2VaTVlKQTltZFlkMU5ncy9GU2Vx?=
 =?utf-8?B?MDhnVkxJbmVtV2dGelp1SzBQYU9ySmQwN2tlbjE5RE1WQ094NDROSDF6Y0dH?=
 =?utf-8?B?VngrV0lScTRuS2EzSmtsUjFXcHJLNFY2emNpTXhTeEhWTEs2SVo4TmZEZmpQ?=
 =?utf-8?B?Y3czYlNPMkhRQlBZQ25aVGhadUtWU1NWelBzSC9Ic3lxSEppZU9rZGtOMkx3?=
 =?utf-8?B?QUM0cW9zMWNlVUhhTU1RR0tSUUpNRmR1OEJjUHZaTFBWZUtHMENuTXlqRTlR?=
 =?utf-8?B?SEIyTzF0NWQ5VnIvdGs4cFNGNWNlNU1obUJIZVlOWW1DbXMxRHAvekRDQXQ4?=
 =?utf-8?B?SkZvbXBUZmhveWtkaU1CSjdrRk1URE9CdEF3dFRpZ0hDU0J2R09JbjltR1Fa?=
 =?utf-8?B?QmZhdUVGZ0ljQlpaMmp3emt3cU1DZTdkUmM3YjB2a083TERxRVpCdkpyTWwv?=
 =?utf-8?B?YWgvOUo1bW5FVUw0b0xoa0YyV2hCUi9LQ1VDQnliQjVha1QxcmRpU09ManJl?=
 =?utf-8?B?amFhWDV4UmU2NVVSV25kNWxGZWUvUjFZajBXUlB2NG42YjRsSVp3VEhtZDV3?=
 =?utf-8?B?RitpNGFJSC9PeU9jWUhLSkl2a1hmT1FqdXpzVkxqV3AxMlNPZHYrY2tKSit3?=
 =?utf-8?B?ZEdXdTlISkp6c1NOMTEvWER6enhtNERWTnBQOC80Qm5FQXVhd3pJREs2TDRj?=
 =?utf-8?B?dWJJRDR6UjMvdUJrY2xLSllWSDlncitabWUrTkJLVnBXQ3ZFU2lBeFUwMXJZ?=
 =?utf-8?B?dTk3a2ZMWVZNTlVVcXg4SVZQR0tyNnRvN01BZFpkUjZEcXlxNnMyamtjc29w?=
 =?utf-8?B?d0xkaEVob2xzc2hHUjVNRW90eDVUcndsbDI0Tk1CTW9QYVo4UERUOU9qTXJG?=
 =?utf-8?B?b0dEMzdFY1NIZ3NlKzJ1ZTdnc0UvY3V3bGd4TEY1cXFNK2RReHp0b1BZQ0g1?=
 =?utf-8?B?clBjbURaS3ZETUFIUEh3cnlLRE1KeXFOSEhVZzBUVlQ2cjZXYnZQa3g3c05w?=
 =?utf-8?B?SWFTSnA3TmtqaWQrRWJ0WXE1NDB0QzRlNzhFbnRIT0w3L0tHa0VaTnczZlZR?=
 =?utf-8?B?OE9GUytkeEZwcDhNdWpDcXd6dFlCazBab29HZ3NjaEV3M2U3Ulp5WUN6R29q?=
 =?utf-8?B?ckxrUnp2blc1N01zK09kR1Q4V0tVTDQ3SmVMUWJhU1dUQTJ5RnRjVisvZmFh?=
 =?utf-8?B?MUxSN3FlZzlRV3BZcGV2RU5ONEpScDM4cWZRQmRRajhWVmVINWFWVHZodVg5?=
 =?utf-8?B?UVNRNEdTMnhIbEFmaDlDU3NEd00zRGVtaFdwSVJpNGpoYmNiVG9Makh3K25Y?=
 =?utf-8?B?bkQrREx6REtOekF4ZGIvc0JSZzdMaXYrY1BReURxZXNySmVTbFFudXgwMFN2?=
 =?utf-8?B?K3YvYVZLaVNTK0d0RGtaSWgxZ3djWlpUSkMxTk9mUXJ0WEhIMjgvTjZqWVN5?=
 =?utf-8?B?Nkt3VEwya3MzUUVLVTlCZWJWdEFtUk0wVWo1UVJRNlhIV3BVWTVHSWlzWjJQ?=
 =?utf-8?B?UWhtVHdhL3dtSHFWUDl3NEdYRmhwVjk0Z0JDWjNnM1dISFpLZW92VEJwSmVG?=
 =?utf-8?B?R2ZJc2pCYXJjYjdnenp5ZWhRNHJORFArZTNwZ1pLbEUrOXM1UEdVL1ZGQ0lP?=
 =?utf-8?B?YmQ4cFIweWVYczAzMTdBQUtKaDNyZDRvcXZkS1JudW8vRW40N2JoN0xoa3Qr?=
 =?utf-8?B?NTFlTTQyWDVRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C88F1971BA3B7C47A007C2CB95E4AF5F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 176b2402-ae66-4159-b90a-08da06512a74
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2022 06:58:09.9651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YbG+ZAqCQbRiiCwpZ9hLUp0+lVRX2ZZD7GsT9HjQzlVY7OQx90qioOr5pbSbaW+NaAiIlPVLtyrzmNz08I4HgF6DlOjXkC4N8dqGqQgtuI8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5600
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy8xNS8yMiAwODowOCwgVmlnbmVzaCBSYWdoYXZlbmRyYSB3cm90ZToNCj4gRVhURVJOQUwg
RU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Ug
a25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBIaSwNCg0KSGksDQoNCj4gDQo+IE9uIDEx
LzAzLzIyIDE6MzEgcG0sIFR1ZG9yIEFtYmFydXMgd3JvdGU6DQo+PiBUaGVyZSBhcmUgTk9SIGZs
YXNoZXMgKE1hY3Jvbml4KSB0aGF0IHN3YXAgdGhlIGJ5dGVzIG9uIGEgMTYtYml0IGJvdW5kYXJ5
DQo+PiB3aGVuIGNvbmZpZ3VyZWQgaW4gT2N0YWwgRFRSIG1vZGUuIFRoZSBieXRlIG9yZGVyIG9m
IDE2LWJpdCB3b3JkcyBpcw0KPj4gc3dhcHBlZCB3aGVuIHJlYWQgb3Igd3JpdHRlbiBpbiBPY3Rh
bCBEb3VibGUgVHJhbnNmZXIgUmF0ZSAoRFRSKSBtb2RlDQo+PiBjb21wYXJlZCB0byBTaW5nbGUg
VHJhbnNmZXIgUmF0ZSAoU1RSKSBtb2Rlcy4gSWYgb25lIHdyaXRlcyBEMCBEMSBEMiBEMw0KPj4g
Ynl0ZXMgdXNpbmcgMS0xLTEgbW9kZSwgYW5kIHVzZXMgOEQtOEQtOEQgU1BJIG1vZGUgZm9yIHJl
YWRpbmcsIGl0IHdpbGwNCj4+IHJlYWQgYmFjayBEMSBEMCBEMyBEMi4gU3dhcHBpbmcgdGhlIGJ5
dGVzIGlzIGEgYmFkIGRlc2lnbiBkZWNpc2lvbiBiZWNhdXNlDQo+PiBpdCBtYXkgaW50cm9kdWNl
IHNvbWUgZW5kaWFubmVzcyBwcm9ibGVtcy4gSXQgY2FuIGFmZmVjdCB0aGUgYm9vdCBzZXF1ZW5j
ZQ0KPj4gaWYgdGhlIGVudGlyZSBib290IHNlcXVlbmNlIGlzIG5vdCBoYW5kbGVkIGluIGVpdGhl
ciA4RC04RC04RCBtb2RlIG9yIDEtMS0xDQo+PiBtb2RlLiBTbyB3ZSBtdXN0IHN3YXAgdGhlIGJ5
dGVzIGJhY2sgdG8gaGF2ZSB0aGUgc2FtZSBieXRlIG9yZGVyIGFzIGluIFNUUg0KPj4gbW9kZXMu
IEZvcnR1bmF0ZWx5IHRoZXJlIGFyZSBjb250cm9sbGVycyB0aGF0IGNhbiBzd2FwIHRoZSBieXRl
cyBiYWNrIGF0DQo+PiBydW50aW1lLCBhZGRyZXNzaW5nIHRoZSBmbGFzaCdzIGVuZGlhbm5lc3Nl
cyByZXF1aXJlbWVudHMuDQo+PiBJZiB0aGUgY29udHJvbGxlcnMgYXJlIG5vdCBjYXBhYmxlIG9m
IHN3YXBwaW5nIHRoZSBieXRlcywgdGhlIHByb3RvY29sIGlzDQo+PiBkb3duZ3JhZGVkIHZpYSBz
cGlfbm9yX3NwaW1lbV9hZGp1c3RfaHdjYXBzKCkuIFdoZW4gYXZhaWxhYmxlLCB0aGUgc3dhcHBp
bmcNCj4+IG9mIHRoZSBieXRlcyBpcyBhbHdheXMgZG9uZSByZWdhcmRsZXNzIGlmIGl0J3MgYSBk
YXRhIG9yIHJlZ2lzdGVyIGFjY2VzcywNCj4+IHNvIHRoYXQgd2UgY29tcGx5IHdpdGggdGhlIEpF
U0QyMTYgcmVxdWlyZW1lbnRzOiAiQnl0ZSBvcmRlciBvZiAxNi1iaXQNCj4+IHdvcmRzIGlzIHN3
YXBwZWQgd2hlbiByZWFkIGluIDhELThELThEIG1vZGUgY29tcGFyZWQgdG8gMS0xLTEiLg0KPj4N
Cj4gDQo+IFNvcnJ5LCBiaXQgbGF0ZSB0byB0aGUgdGhyZWFkLiBCdXQsIGRyb3BwaW5nIDhELThE
LThEIG1vZGUgc3VwcG9ydCBpcw0KDQpubyB3b3JyaWVzDQoNCj4gcXVpdGUgcmVzdHJpY3RpdmUg
SU1PLg0KPiANCj4gQUZBSUssIFNGRFAgc3RhbmRhcmQgZG9lcyBub3QgZGljdGF0ZSBob3cgZGF0
YSBzaG91bGQgYmUgc3RvcmVkIGluIGZsYXNoDQo+IG9yIGhvdyBTVyBzaG91bGQgaW50ZXJwcmV0
IGFmdGVyIHJlYWRpbmcgZGF0YSBmcm9tIGZsYXNoLiBJdCBtZXJlbHkNCj4gaW5kaWNhdGVzIGVu
ZGlhbi1uZXNzIGNvbXBhcmVkIHRvIDEtMS0xIG1vZGUuDQo+IA0KPiBTbywgaXRzIHVwIHRvIHZh
cmlvdXMgc3lzdGVtIFNXcyBsaWtlIGJvb3Rsb2FkZXIvTGludXggdG8gd29yayBhY2NvcmRpbmcN
Cj4gdG8gcHJlLWFsaWduZWQgbGF5b3V0IGFzIHRoZXJlIGlzIG5vIHJ1bGUgdGhhdCBkYXRhIG5l
ZWRzIHRvIGJlIHN0b3JlZA0KPiBpbiBieXRlIG9yZGVyLg0KPiANCj4gV2UgaGF2ZSB0d28gdHlw
ZXMgb2YgY29udHJvbGxlcnM6DQo+IA0KPiAxLiBTUEkgY29udHJvbGxlcnMgc3VwcG9ydGluZyBz
d2FwcGluZyBlbmRpYW4tbmVzcyBvbiB0aGUgZmx5Og0KPiAtPiBGb3Igc3VjaCBmbGFzaGVzLCBi
ZXR0ZXIgY2hvaWNlIGlzIHRvIGhhdmUgU1dBUCBvcHRpb24gYWx3YXlzDQo+IGVuYWJsZWQuIFNv
IHRoYXQgZGF0YSB3cml0dGVuIGluIDhELThELThEIG1vZGUgY2FuIGJlIHJlYWQgY29ycmVjdGx5
IGluDQo+IDEtMS0xIG1vZGUgYW5kIHZpY2UtdmVyc2EuDQo+ICggSSBhbSBhc3N1bWluZyBTV0FQ
IG9wdGlvbiBvZiBjb250cm9sbGVyIGlzIG9ubHkgZWZmZWN0aXZlIGluIDhELThELThEDQo+IG1v
ZGUgYW5kIGlzIE5PUCBpbiAxLTEtMSBvciBvdGhlciBtb2RlcykNCj4gDQo+IEJ1dCwgaXRzIHBv
c3NpYmxlIHRoYXQgIlJPTSIgb3Igb3RoZXIgbm9uLXVwZ3JhZGFibGUgU1dzIG1heSBjaG9vc2Ug
bm90DQo+IG1ha2UgdG8gdXNlIG9mIHRoaXMgU1dBUCBvcHRpb24gb2YgSFcgdG8ga2VlcCB0aGlu
Z3Mgc2ltcGxlIGluIHdoaWNoDQo+IGNhc2UsIHRoZXkgY2Fubm90IGJvb3QgZnJvbSA4RC04RC04
RCBtb2RlIHdpdGggYWJvdmUgc2V0dGluZy4gU3VjaCBTVw0KPiBkb24ndCBhbHdheXMgaGF2ZSBr
bm93bGVkZ2Ugb2YgZmxhc2ggYW5kIGNhbm5vdCBiZSBmb3JjZWQgdG8gaGF2ZSBhDQo+IGNvbnN0
cmFpbnQgdG8gZW5hYmxlIGJ5dGUgc3dhcCBvbiByZWFkLg0KPiANCj4gU28sIElNTywgaXRzIGJl
c3QgbGVmdCB0byBzeXN0ZW0gaW50ZWdyYXRvcnMgdG8gc3BlY2lmeSB3aGV0aGVyIG9yIG5vdA0K
PiBTV0FQIG9wdGlvbiBuZWVkcyB0byBiZSBlbmFibGVkIChwZXJoYXBzIHZpYSBEVCBhcyBpdHMg
cGVyIGZsYXNoDQo+IHNwZWNpZmljIHByb3BlcnR5PykNCg0Kd2UgY2FuJ3QgdXNlIERUIGZvciBj
b25maWd1cmF0aW9uLCBtYXliZSBhIEtjb25maWcgaW5zdGVhZC4gQXJlIHRoZXJlIGFueQ0Kb3Ro
ZXIgb3B0aW9ucz8NCg0KPiANCj4gMi4gIFNQSSBjb250cm9sbGVycyBkb24ndCBzdXBwb3J0IGVu
ZGlhbi1uZXNzIFNXQVAgb24gdGhlIGZseToNCj4gSXQgaXMgc3RpbGwgcG9zc2libGUgdG8gcmVs
aWFibHkgcmVhZCBhbmQgd3JpdGUgZGF0YSBhcyBsb25nIGFzIGl0cw0KPiB3cml0dGVuIGFuZCBy
ZWFkIGJhY2sgaW4gc2FtZSBtb2RlLg0KPiANCj4gRGUtcmF0aW5nIHNwZWVkcyBiZWNhdXNlIG9m
IGFic2VuY2Ugb2YgdGhpcyBzdXBwb3J0IHdvdWxkIG1lYW4gcmVkdWN0aW9uDQo+IG9mIHNwZWVk
IGJ5ICoqMTYgdGltZXMqKiAobWF5YmUgZXZlbiBoaWdoZXIgYXMgOEQgbW9kZSB0ZW5kcyB0byBz
dXBwb3J0DQo+IGhpZ2hlciBidXMgZnJlcXMpLiBTd2FwcGluZyBieXRlcyBpbiBMaW51eCBiZWZv
cmUgd3JpdGluZyBvciBhZnRlcg0KPiByZWFkaW5nIGlzIG5vdCBhbiBvcHRpb24gZWl0aGVyIGFz
IGl0IG5lZ2F0aXZlbHkgaW1wYWN0cyBwZXJmb3JtYW5jZS4NCj4gDQo+IEFza2luZyBST00vYm9v
dGxvYWRlcnMgdG8gc3dhcCBieXRlcyBiYXNlZCBvbiBTRkRQIGluZGljYXRpb24gaXMNCj4gcmVz
dHJpY3RpdmUgdG9vIGFzIGl0IGludm9sdmVzIGJvb3QgdGltZSBwZW5hbHR5IGFuZCBtb3N0IHN5
c3RlbXMgd2l0aA0KPiBPU1BJIGZsYXNoZXMgYXJlIHVzaW5nIHRoZW0gdG8gYWNoaWV2ZSBzdXBl
ciBmYXN0IGJvb3QgdGltZXMuDQo+IA0KPiBPbmUgbW9yZSBjYXNlIHRvIGNvbnNpZGVyIGlzIGZs
YXNoZXMgdGhhdCBkb250IGhhdmUgU0ZEUCB0YWJsZSB0bw0KPiBpbmRpY2F0ZSBieXRlIG9yZGVy
IGJ1dCBmb2xsb3cgTWFjcm9uaXgncyBjb252ZW50aW9uLiBJbiBzdWNoIGNhc2VzLCBpdHMNCj4g
YmV0dGVyIGZvciBTUEkgTk9SIGxheWVyIHRvIGJlIGFzIGR1bWIgYXMgcG9zc2libGUgYW5kIG5v
dCByZWFsbHkgZG8gYW55DQo+IGJ5dGUgc3dhcHBpbmcsIGxlYXZpbmcgaXQgdXAgdG8gdXNlciBz
cGFjZSB0byBoYW5kbGUvaW50ZXJwcmV0IGRhdGENCj4gYXBwcm9wcmlhdGVseS4NCj4gDQo+IEFs
c28sIE1hY3Jvbml4IGlzIHByb2JhYmx5IGluIHZpb2xhdGlvbiBvZiB4U1BJIHNwZWMgKEpFU0Qy
NTFBIDYuOS41LjINCj4gOEQtOEQtOEQgUHJvZmlsZSAxLjApIHdoZXJlIGRpYWdyYW1zIGNsZWFy
bHkgc2hvdyBkYXRhIG91dHB1dCBzaG91bGQgYmUNCj4gRDAgRDEgRDIgRDMuLi4gU28gUk9NcyBm
b2xsb3dpbmcgeFNQSSBzcGVjICh3aGljaCBpcyB0aGUgb25seSBzcGVjDQo+IHByb3ZpZGluZyBm
bGFzaCBhZ25vc3RpYyB3YXkgb2Ygc3dpdGNoaW5nIHRvIDhEIG1vZGUgYW5kIHJlYWRpbmcgZGF0
YSBpbg0KPiA4RCBtb2RlKSB3b3VsZCBub3QgY2FyZSBhYm91dCBTRkRQIGJpdCBpbmRpY2F0aW5n
IGJ5dGVvcmRlciBhbmQgaXRzIHVwDQo+IHRvIGZsYXNoZXIgcHJvZ3JhbXMgdG8gdGFrZSBjYXJl
IG9mIHRoZSBzYW1lDQoNClRoaXMgaXMgYSBiaXQgaW4gY29udHJhZGljdGlvbiwgYmVjYXVzZSBp
ZiB0aGUgUk9NcyBmb2xsb3cgeFNQSSwgdGh1cyBsaXR0bGUNCmVuZGlhbiBieXRlIG9yZGVyLCB0
aGV5IHNob3VsZCBzd2FwIHRoZSBieXRlcy4NCg0KPiANCj4gSU1PLCBrZXJuZWwgZGV2aWNlIGRy
aXZlcnMgc2hvdWxkIGp1c3QgcHJvdmlkZSBhY2Nlc3MgdG8gdW5kZXJseWluZyBIVw0KPiBhbmQg
bm90IGhhdmUgdG9vIG11Y2ggaW50ZWxsaWdlbmNlIHRvIGludGVycHJldCBkYXRhL3Rha2UgZGVj
aXNpb25zDQo+IA0KPiBTbywgc2ltcGxlciBjb25zdHJhaW50IHRvIHB1dCBpczoNCj4gRmxhc2hl
ciBwcm9ncmFtcyBzaG91bGQgcHJvZ3JhbSBkYXRhIGluIHRoZSBzYW1lIG1vZGUgaW4gd2hpY2gN
Cj4gUk9NL2Jvb3Rsb2Rlci9MaW51eCBpcyBleHBlY3RlZCB0byByZWFkIHRoZSBkYXRhIG9uIHRo
YXQgc3lzdGVtLg0KDQpObywgdGhpcyBjb25zdHJhaW50IGRvZXNuJ3QgY292ZXIgYWxsIHBvc3Np
YmxlIGNhc2VzOiB0YWtlIGEgMS0xLTEgUk9NY29kZSwNCjhELThELThEIGZvciBvdGhlciBib290
bG9hZGVycyBhbmQga2VybmVsLiBZb3UgbmVlZCB0byBkeW5hbWljYWxseSBjaGFuZ2UgbW9kZXMN
CmluIHRoZSBmbGFzaGVyIHByb2dyYW0gaW4gb3JkZXIgdG8gYWRkcmVzcyB0aGlzIHVzZSBjYXNl
LCB3aGljaCBpcyBhIG5vIGdvLg0KIA0KPiANCj4gRm9yIE1hY3Jvbml4IGxpa2UgZmxhc2hlcywg
aWYgb25lIGhhcyBhIFJPTS9ib290bG9hZGVyIHRoYXQgb25seQ0KPiBzdXBwb3J0cyAxLTEtMSBt
b2RlIGFuZCBmbGFzaGluZyBkYXRhIGluIDhELThELThEIG1vZGUgd2l0aCBMaW51eCwgdGhlbg0K
PiBwbGVhc2UgZ2VuZXJhdGUgYSBieXRlLXN3YXBwZWQgaW1hZ2Ugb2ZmbGluZSBhbmQgZmxhc2gg
aXQuIERvbid0IGltcG9zZQ0KDQp3ZSBjYW4ndCBkbyB0aGF0LCBzZWUgdGhlIGV4YW1wbGUgZnJv
bSBhYm92ZS4NCg0KPiBwZW5hbHR5IG9uIHN5c3RlbXMgdGhhdCBkbyBiZXN0IHRvIGhhbmRsZSB0
aGlzIG1lc3N5IHNpdHVhdGlvbi4NCj4gSSBzZWUgdGhpcyBhcyB0aGUgb25seSBvcHRpb24gd2l0
aCBsZWFzdCBwZXJmb3JtYW5jZSBwZW5hbHR5Lg0KPiANCg0KSSB0YWtlIGZyb20gdGhpcyB0aGF0
IHdlIHNob3VsZCBsZXQgdGhlIGJ5dGUgc3dhcCBiZSB1c2VyLWNvbmZpZ3VyYWJsZSwNCnRodXMg
YSBLY29uZmlnLiBXaGljaCBJJ20gbm90IGFnYWluc3QgaXQsIGJ1dCBpdCB3aWxsIGdpdmUgdXNl
cnMNCmhlYWRhY2hlcyB0byBzeW5jIGFsbCB0aGUgc29mdHdhcmUgY29tcG9uZW50cy4gTWFraW5n
IHN1Y2ggYSBkZWNpc2lvbg0KaW1wbGllcyB0aGF0IHVzZXJzIGtub3cgU1BJIE5PUiBpbnRlcm5h
bCBkZXRhaWxzLCB3aGljaCBhbHNvIGlzIGEgYml0DQpzdHJldGNoZWQuIExldCdzIHN5bmMgc28g
dGhhdCB3ZSBtb3ZlIGZvcndhcmQgd2l0aCB0aGlzLiBPcGluaW9ucz8gDQoNCkNoZWVycywNCnRh
DQo=
