Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFCF4BF438
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 09:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiBVI7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 03:59:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbiBVI7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 03:59:49 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE9613D903
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 00:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1645520362; x=1677056362;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=WNiXvmV6R5OrlI+QR79gEsViipzyGFC2dAmHRocqMTs=;
  b=Vo6aRviR485mbeKr4LnfgKrjlITjR3cNBNxGza94PGsW1y4t2g3tyyyT
   /Y0nwyzuDUcLSIL7aojhzS/+8Uj+nkV9+zXR0SX1w9al5gLWV9tVDicOt
   hnkOVbLC82qlNE1EVzJlw7MGg8C2sP/jJ1f5kiBuJ2BywLF/nNH4/u6OK
   hSp/KeD3yEdc1I9kVJRMBBqO3ATBt1cdpWxKhOC6JxNMzDhA6wX3F97A+
   s4HG4MkDHYL0zhmBYdVZmJNWx0HDaOslNnUuTUmeB2tsJmC8g7mgKxK5V
   d+wSMlEY1mDAqcejUuQsBR9VrHFSrkC2qA0VSK+XeEFkE2ijGt8eQAvPG
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="153904334"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Feb 2022 01:59:15 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 22 Feb 2022 01:59:15 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Tue, 22 Feb 2022 01:59:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BfKQd64VMgIinX1Ld6EEappifeDv/U4DxY/dLXd3vZ5TegjVAn2UQa0jK0mIj8vvC8SiMF3TziFaU3ROzLauLLNisKL+T67QdfmpFY5ZILZkrevJG+DIVtP/2ECAI2Vw64LDi2LnoStSPXR44L1XqOzQJop+EgQHe/nE5Y0uEfJ8WFqD6KBR2TZs/vwdFRK3jWTmlBCTIik02MczUNqfOwrA+UvGkVXe/MF9dgwQx9vlpPoWcTY7jFCkhbE2Q7mJVWoHBtS8EyPSfGWYQUltdkZXWnAd26hFQQ6ofo84J9EKPUj/QO5IUjUYTfRBC7dJqzw2xpSoHnEv8D4gQqRt6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WNiXvmV6R5OrlI+QR79gEsViipzyGFC2dAmHRocqMTs=;
 b=Amxlbd6amsFTLU1Zulhsfw8yoMbVYD8JV8rgAT5MBR+PuQb5CuTrO5gl0Cnpw+wmZlJr4SE/AIlSmBfEPeOfGi3zdOO4XMHrnnCI3Ja7jSRDpQdKysv+gND26pqDgq/4wwr4y5BSr06xhOOEc4H0m0C3yS9OcQM2APhxxliVvjdWbIAYs9LCM0B0yiEeO4PZm1Qc4+BK+Zx0NDkr91TKWCJxtrrmon/smIzZQx42dGVQb/rV3hHMtzm2X1mhzhE3hXhWczcgnGoEWm1Gnallt/bUUKVpKDvQPSH5g6g5R82ocwUUwtXPQvImFGhOz1KZgsmEUIJbKIk4llo2b9mSLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WNiXvmV6R5OrlI+QR79gEsViipzyGFC2dAmHRocqMTs=;
 b=aW94bR/T5AxgBGchfW3bE/ldCBP8P8IXyLTBh2U/Aw7WyHdlTXENWBL5VVyP/PDL3uX7LeadLFHbjVMxvwDrTIwhbWP6MRu8AUx/iq+QwTm8VHh3tKU7dVxGJgrScJQWQ4JGz2vXvNqGB5HMoH44Oz7Nhf699rMdy3GVQVZWdY4=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SN6PR11MB2992.namprd11.prod.outlook.com (2603:10b6:805:d4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Tue, 22 Feb
 2022 08:59:14 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::49cd:dd25:384:e918]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::49cd:dd25:384:e918%4]) with mapi id 15.20.4995.027; Tue, 22 Feb 2022
 08:59:14 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <p.yadav@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <yaliang.wang@windriver.com>
Subject: Re: [PATCH v4 00/32] mtd: spi-nor: move vendor specific code into
 vendor modules
Thread-Topic: [PATCH v4 00/32] mtd: spi-nor: move vendor specific code into
 vendor modules
Thread-Index: AQHYJ8p3vLgo0aRp4k6ReJ+SNq1PMQ==
Date:   Tue, 22 Feb 2022 08:59:14 +0000
Message-ID: <d45daacc-8372-9b2d-019e-5d383db4fa57@microchip.com>
References: <20220221120809.1531502-1-michael@walle.cc>
In-Reply-To: <20220221120809.1531502-1-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ff23a078-6eb2-452c-1c5f-08d9f5e1998a
x-ms-traffictypediagnostic: SN6PR11MB2992:EE_
x-microsoft-antispam-prvs: <SN6PR11MB2992EBEAEEF34E55EFED47AFF03B9@SN6PR11MB2992.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DtPQ2lGswbZN834NBAx5Qyr5N4wHYSlPEj8dOi+wr0YblL/FsdRu1flgSxM5QLSSDeq6x60B0VMh9tDS/P16AqCt+9A4NVrwrS0uZZUb8DVqNVzwrb52u6Y8pCzp9WY1YEiUP0FwKacpmYtYBS5E50AkUJPI7bfhhe04Szyps2nbHRQl461tvT7Kng+276qRKRhYoELsEl3qZTVXe7BjThfEZSgIhw1AvxDTIg/AdI0DcUFBJG/7SzRTkdMigeFRLRVWuVN2R4U5n3Dpy3eiwxREDoi+HgGzxB09SFw1QkAEar/sSJYR4H5HzBdpKhBW0/H8SSa9KekiW1WRmhTvuqbUxEgTGY8Fzi6SoOUWsd/Ieo/MR5oNc3L2BaPPA4AXYcjkHBgzqaZgtwu/OLkbj0wKOwwkjDstEvaU3DrpSUfWuwYm3XDXlIw1jsaXtNNViFVJSeOp12i3TlzxfqQyCwDTGcY0ZLiRYdgE3Qgunc3VjPTLydQ1hcj8FkYMt4S2OL9U8/O001Bjlm6csVXI75VISrw7sceLV/uMs2At0gtX8yPGeIqu2HltknLIAH7FrgjboDcMTNndOaVO5oZxmbzew7sOd/5jcWx5jux/jdFEZJ80nS4FAKGT4YJa1xyWipkekE42l40Js+VjE6866+8u1EoZLJzfvu9kcob12dujdcGC8NqDlhp17lz+h3qZ+e7CkqTPIxPMkNAFatBry+6sngcwe77818I1qRAC8b9tg6kJIBuyYhmKf51kS/hYnIhVb2lxOGpvPD2s5hm9TQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38070700005)(4326008)(76116006)(122000001)(66476007)(66556008)(64756008)(66446008)(91956017)(186003)(8676002)(2616005)(6486002)(66946007)(316002)(26005)(508600001)(6512007)(38100700002)(71200400001)(86362001)(31696002)(2906002)(5660300002)(558084003)(8936002)(31686004)(36756003)(110136005)(6506007)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dm9NSmFsZ3dlbUhReFEwZ0lMWm56Z2xyNnV6Z0EwVzM0NWJoMUlYTW1iMmNl?=
 =?utf-8?B?UEhXcU5XbW5yTXJyWU9BanJvSW1KYm1QeVhMVVhiSjhnSEMyV3NWcm94S0hr?=
 =?utf-8?B?U2hrb21TR2c2QXdZUFA5RVBYMEdrTk1oTDlCcWlVZDQwZ01QV0paV0Z0QWgw?=
 =?utf-8?B?dTJMam1FcitxUGdOL3FhYmFCdHN0WXh3OThqQkx1bnJyVEZCYVFQUWRNQjRa?=
 =?utf-8?B?Z0lzSEY1VisveDNRcEhnMEZmcHA0TkNJZlRwb0Z0OE5vY3VJU2lhY01jd0po?=
 =?utf-8?B?SkNMMG1pY3ZTTWtZSDU1SnNvcnd6QUZpQm9NV0VneDE0Tys0V2p5SVJmUmZ3?=
 =?utf-8?B?UGI2czRuTVlUWGMyTTRxN25RR2tNTUZlOUl3TWlGQXB4RmdEWmVQaTNXcENa?=
 =?utf-8?B?SXh4T1QvMDM0dlVDQU16WSt5TDlQK0RUYThNblNEZWdlQXVzNTJGTm4yUHFy?=
 =?utf-8?B?Y3VQaEFqanRtTTV1S3RNOUFFaHA3YnJteFhuSXB1WkRFR3g2Tk9VMlVhdjFp?=
 =?utf-8?B?MkJDWDIxMkJ4N1p4eC9hTlZWYmkraVY5VGRjZ2M3VUxFSFlTSk1YcEMzVTdQ?=
 =?utf-8?B?ekpDRlNXbVdpdEs3Z1VPczFsZEFjMGpsaVVzbjBTTFNWd2MycjAyR1RQU1dP?=
 =?utf-8?B?NkRKZ3VLVzI2dVVSenZ4ZlFhQlJmZkloRk1VSkhnK0UycFF5YUFzd0RqU0dC?=
 =?utf-8?B?TDhlR3Q2RENqWVdiNzdQZVdsb3pDbWYxVHBsbUt1NXltVTRrM0Zrang4Smlj?=
 =?utf-8?B?emhQM0ZHUThuWXMzdkl2U0lRUVZnKzR1MWdHZDAwZXhhWG5iNVN1aVRTNkxu?=
 =?utf-8?B?L3ZveDc3MkdrekxBUFdpenAvU0lMQ1JZQVJYSlVCeTJRazlZRXRXUER3ZkFK?=
 =?utf-8?B?eno4Y082TEdseHB3dm5NY2ZUNXIvR1YwUlNMYVh2Ym1jQUZsK3hMb0RsSDBF?=
 =?utf-8?B?UXNQMTdwelNBeFY5bFFLSXQ2WDV2MDZvc1lFL1YxNFZuUVZoY1c1ZkJ3Vjh1?=
 =?utf-8?B?c0JLVnpZRWtWWk45SDdMK0ZNdTJsTXFkVGpTam91TWhtTFFyelV6ZFd0YVZD?=
 =?utf-8?B?MUxTY1hQRHdTVUlmOFpmZTVWU2pqWGxKUUhZTmRvZDFyMUF3Nmw3R3VDV0pO?=
 =?utf-8?B?ZFBhWlRXd0hQTURWNVN1eko5SENzRHc0RCt2ZjI4aktmckxydFErdXBMS3hx?=
 =?utf-8?B?emRJQ1A3aThhbnlhK1VUZXBvd1NHQ1p5SzZTT2tUYUJEZHJSY3BlRndzU3dz?=
 =?utf-8?B?cEVjL3pXUHcrU2NDbXNxbVJFT2dEeStDRWM1SExqQzVzVVZTbUxiWDJWZUlO?=
 =?utf-8?B?VW9Ebkd6N09TbU4yeEZoTHRwcFZ0SHBKdnlxU0hLRHFscEtTVFZjaHNlNHor?=
 =?utf-8?B?b0JNTVN3QzVTNlM3K1h6eG5tSUpaK3BuWFQyQnJ0U0JqVllKTGFEV2xiZ3pS?=
 =?utf-8?B?bFVkTXUrYXNycjQ3Ti84YXAwSVkxamppbm5GOHg5eTFLb2FMbkh0TlBFaFgw?=
 =?utf-8?B?TnhpNDVidEhMSGNWQSs5c3VURXAwK1FKVGtrYjBTRGhYS2JRb2MrQWRqRzlG?=
 =?utf-8?B?U2FMTmdrYlV0aStwVHlkRDJaU0lXdXFTbzJLL2hhcEQ0ckdkeW4yaUpnRGNS?=
 =?utf-8?B?Q2xyQXc0dFh0cmxRYUZ0dlc3aTdEV2pFZ2V1RUZOU3c1MnRpbFA0Nm5zRDhI?=
 =?utf-8?B?NENtYjE0RGFsSXpVNUVsczk1WTR6K2lQcDlZeGNmcTVnZGJabS9tVkVqUm5o?=
 =?utf-8?B?QXp3aEtQMjY0cG5VZmtnOUlCRWRKOVh5NU5NSSs1bzNSMHBZS1ZtejJOcW9z?=
 =?utf-8?B?Z0grcmV2R0dIR3p6cGdGMFJhNE1QVkhibk1ZY1dLT0w4Z09rVjBHSTNLWVd5?=
 =?utf-8?B?WlJwb0hDV1lSMEs4TmJZZzE4NE5EQVJ2bVZIYWE2RllYdHo1bC9xZ2MzSTd4?=
 =?utf-8?B?NGg3Wm94KzFVOUFOTVl1aVF1TExjb3NHYjZ0MTlFb3JXNndINGdWQXFIR3dH?=
 =?utf-8?B?eDQ3RzFxZ1ZiUU1adkJaaUQySm5EcUIvbXpraUpEYW9vckY0UGJJMjdLbmFO?=
 =?utf-8?B?N0UyRlMwRTQ1YnZEaHpESDRDS1FoV0tHZDZBaVBUQWtBNG1OTmh1aWNxazZY?=
 =?utf-8?B?dUJHTVNUakdIN2YrYkJWU2FaY2JPT3BTN0ZCbERtanpuMXhpMC9OUFV4UnVz?=
 =?utf-8?B?cUZJTHU2RmdCMXVOQnFhc1hLT1EwYWM1UlQyUm1oU0ZsSWVObThkakNaU045?=
 =?utf-8?B?cEhRUXFTWDJPWmJ1bzdwWHFBZWdRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8FB44DF75D33194A9A4E36FAEDBB3150@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff23a078-6eb2-452c-1c5f-08d9f5e1998a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2022 08:59:14.1579
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h98nwBgENa3kineqt4sRBzpqd9GgcY9RZJnOlutdOY2IP/XgDgJGgYqLrhZ8+Oh1eaPScoIfxQQ8+EmmbAxHjdgpVQnmm316xiC/AbrEF/0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2992
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SSB3b3VsZCBsaWtlIHNvbWUgdGVzdGVkLWJ5IHRhZ3MgaWYgcG9zc2libGUuIEF0IGxlYXN0IHdp
dGggYSBtaWNyb24gYW5kIGEgc3BhbnNpb24gZmxhc2guDQpJIHRoaW5rIEkgaGF2ZSBhIG1pY3Jv
biBhbmQgYSBzcGFuc2lvbiBzb21ld2hlcmUsIEknbGwgdHJ5IHRvIGRvIGEgc2hvcnQgdGVzdCB0
b28uDQoNCkNoZWVycywNCnRhDQo=
