Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F28593F7D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 23:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346669AbiHOUxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 16:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347244AbiHOUvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 16:51:45 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF44F0A;
        Mon, 15 Aug 2022 12:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660590620; x=1692126620;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=J/JPhVs81qTXNGUrFY4AhNf3YA4cq/stojr2Gfkf/pM=;
  b=gxdl91kC6NA5Nz0PvOTB9hshNGXb8nk4AGE593lSqk/NFLY2Q1WIVhVN
   dgjuxq1ynbDdxJj6acianrq6KgGK1DzY6G0Ggls8fslG0R0tirsZW1M5A
   eS3dafFmevZ0rhP9XGhQ7dWWEEisRabzgQx/a5CMe8F1K3bWG4fndkhwR
   XWHDlwYxeUiO7sd+pjmzwK6XlmY3TcmOqYElPOIc4FhkoopFSZ3o8ojYw
   2z7xfhWGdaO1QK/DPcXgBIUDf5+hKXSY1RcaJxGHdaYBFXcqskETY0frq
   Odnubbsc78KTnC1M0qJFDXXdoJM2ypmL8Bc9O5KJY6ixXkFglkvORBLzF
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,239,1654585200"; 
   d="scan'208";a="172538702"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Aug 2022 12:10:10 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 15 Aug 2022 12:10:09 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Mon, 15 Aug 2022 12:10:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EJTDxCNXdySLpbUw97DJ+4cS0QUxmkjoYpixYD0949riCMwsDKdyDlQK/vcs+tjsOe/xrriMu2LiI/fvwWpP7ge+g8QbW2LUxww89AgHeSPtrbW3jtN2d1Fh5aixXQTKhAviUYy9dZ2bZbpCycKf/XvgL67fxQqhyMgjR+pj8Nnnv+pEzRF/pIZD26KkaVwFSuYGTvuMrThBi+Mj6VTBhCU+JyWJbJVqWYM+sUKgUECvsVxZbVeHHyQ+VALiP/0Tc32bm5aEi5wh5IIT1jIAADt24YkaEmPGk4EBAabxyXAnMd5+FSSvJLFoQLiB6xY6ulZXtF20l8IxocwLZlSfsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J/JPhVs81qTXNGUrFY4AhNf3YA4cq/stojr2Gfkf/pM=;
 b=mt3MLWFR1U03MoxW0RrQHJDlCgXenaoMImX45xEPCQp8emdgI69fcjbJXqZU7Nd5ff6/DWPhVEWOPOFMkDVLSJbdQQ7muKHbbLPcOPGnNfvZkCHiKY1ffRzq4o1PHhphtU521Ktgwz3GO9N3u5rirYI4KOwGo/8Up+9nVGeuGjKE9/62Rg1uIz2S7OPIpLh7VIcaVXItCFYrYHld+lCOsuvOvMbY+s5wwCqAmZ0JuIpL2aCgwAjGX44LIkgjZ+drVKgLrgamU6Nstof3LxVF6IZnSWfT6uqs193VBcAFbfEwzvQW0/NHiqDD8nMut2tU954eohG8i3pcufr674WSgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/JPhVs81qTXNGUrFY4AhNf3YA4cq/stojr2Gfkf/pM=;
 b=g0kjYg0+NsrPrDFMNNfRoPFdpFKj8QC2BW9lyBmIzeWy0jKgmqh3Rsftjw0xRGO8/m07EibJ/FOJCy9IBwIDES/zjjG/qEUHV5AUOKwOp+DKURw1Q27q9G0qA9LRYNQaX8F6O8m6ZnlaOiB+3PA8qkOCTXm9DZC3WMIA0QSfXYg=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by MN2PR11MB4551.namprd11.prod.outlook.com (2603:10b6:208:269::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Mon, 15 Aug
 2022 19:10:04 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%8]) with mapi id 15.20.5525.011; Mon, 15 Aug 2022
 19:10:04 +0000
From:   <Conor.Dooley@microchip.com>
To:     <prabhakar.mahadev-lad.rj@bp.renesas.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <geert+renesas@glider.be>
CC:     <anup@brainfault.org>, <linux-renesas-soc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <prabhakar.csengg@gmail.com>,
        <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v2 4/8] RISC-V: Kconfig.socs: Add Renesas RZ/Five SoC
 kconfig option
Thread-Topic: [PATCH v2 4/8] RISC-V: Kconfig.socs: Add Renesas RZ/Five SoC
 kconfig option
Thread-Index: AQHYsLoPyzdSi5rmak2RSuYw1tRBkK2wU8sA
Date:   Mon, 15 Aug 2022 19:10:04 +0000
Message-ID: <d9d0deef-92e1-05b4-a195-d2ca03801129@microchip.com>
References: <20220815151451.23293-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220815151451.23293-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220815151451.23293-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8dd55728-02c7-4ed7-50e1-08da7ef1c2c1
x-ms-traffictypediagnostic: MN2PR11MB4551:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tHj2dh2cc4VIruK3KJPO8jvwjz9TF5XtydGsyv+Ur/5AuVkN8lqzrD+JmCZwUFusZ1Su5C1SWa/0VnPIRpibfPx6O2q8XLV9r7BNCXCOQysnUca48n870wSdRAqyLNrJMyYqirwS/IlZAuC9KAqGzV5oL1WVsDDkXaGkMWIkmhuK6aSscSUMBskwjT8DPus5KmGCOOFH4YCJCGLPx2i+U/9sD77P3ePO0tilVBBneAyHJ6HJ00+NPQGrasIaZg9Oh53kSiPK8eoKj5fupINoLUs/KFLuBriGOelu8jgpEBQMjyS++OWM5Z0g8hAjXvNvyk0xdas0wHntaGAyYaZatM6ZqNzeKuHm4NyAA4ufS5ocyRaGw/PRb8hp4IdkEvq3VnGHaypfg03CIZqsaP2MGZPa0Wtxqtpr73Sd+4wALoK9A5jUxuvKPe16kGgOBvLkIn1ZAr1bVJj+ZEof2rqakXqluNpgF7wrV5ouuXhuSZmX3ZCoeWlJqkRJWMleKZU8lrsRMCY/RUarmd/4bbS55URQ3VbURG/IU6O4f++3ld9BitgEs5DYYHWDTPpI3Nk+qprE1QVymEgPYYPLmXMKFXglIUGOizMv8ykz2J9UrYVcL7XMd+4QxVCa2ahJ5p296BOH8PY1rBrVJIR2PRG4G2LG8Z2kRek8qF0pCMvJ2HeEJxVpajs9g2verGtX+jROiZ18gTyWl7xyFBrBd5GKJBGPR36Tc8VFVT3z0JDqt033uV9yXtFUv6aiOh4SFUjxZwqTGYiQsFmWgMD++Y61QcjXtok5zjkhPCqmUQ77pc7X+UcldPBXuK1ZCH1d4h+LWiXf6KNlMLIj3W0g82nH3EJAPTd2vY+RLPFoa2CB2uSUwI2hLHu3QC9gnYwoKWve
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(346002)(396003)(366004)(39860400002)(376002)(186003)(110136005)(54906003)(31696002)(86362001)(83380400001)(38100700002)(8676002)(6486002)(36756003)(66556008)(66476007)(66446008)(64756008)(4326008)(91956017)(76116006)(31686004)(71200400001)(66946007)(316002)(5660300002)(8936002)(38070700005)(6506007)(6512007)(2906002)(2616005)(53546011)(122000001)(26005)(41300700001)(7416002)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SDFVQXlWYkUvclhDMkVVcmFaZXA4Sy95RG1Vc1MxZzlLVEZxNW4xaDJOSC9s?=
 =?utf-8?B?V1hYSW85RytiTVEzRDBkY1k1STNiN2VYNEJpQXpBYkpQVU5VcGtBYVd4VXdZ?=
 =?utf-8?B?RjgwdW5SLzFmYUU4TDUvVGdYSmtVU21HamY2dnRQYmlFSmE1cW5DeHdhOTFN?=
 =?utf-8?B?aHh5UHdNVksyLzZtNEtyU2tLM0NobUVZc2J4dGN0ODhoVG1nbTZDOSs4MGxE?=
 =?utf-8?B?cnFKWmdKQmNUSzZGOEc5bkVSeFA0Uzh0THRkK2VXeXFEWmFEOUtmc2d0bzFZ?=
 =?utf-8?B?Yjk2enBxUjMwazhaL2hvNlB0RmNrUmRta3czMUFLM3FaZTlVV0IrbzJuV1Jk?=
 =?utf-8?B?ZG9OY2hnVitCYjNLTlZuN0I1dmlaVHM0Z0NWd3Q2a3RCOTNvZWdsS05qYlJU?=
 =?utf-8?B?RjFoZEtMWkZlVW1zT09RQVVvTGxQZnFkN05Za3EzWmZjaXA5SlVsNjVtQlNs?=
 =?utf-8?B?RFNHK0p6cWJwK0xWVE9ybkhmS0Y4bVFxNjZvaEJQcEgyODZONDhkeTdHdUJw?=
 =?utf-8?B?aUNpMXJ3eTlhclZzbGZTR2tvR0VkU2UvY1hRdy9mVlpUYjJlVGVraGY4R243?=
 =?utf-8?B?VkFYQ3E0QUtjNmNrYTQrQVMwUVNwZTMzZ09ma2hDZ3FRQVN2VGpHb3VLeWVs?=
 =?utf-8?B?MU9WZTV2ejZlTWk2bno1ZHE2eDg2WjM1dmIzcmUvaXpUbXVuNUNhU3JLa2d5?=
 =?utf-8?B?Z3lsbXFJODZtZE9ZN1M1VG1WbjFabW16RVZXaXNWSnVKMDVDbm9UYnJxR1VS?=
 =?utf-8?B?UGRWa3ZVajdmSFJqeldHeUlIWTF4K2MrWUFPVEhrNmdERFdva1NmckxOcC90?=
 =?utf-8?B?QndPeitnOUtvdmNMZVZQMGFUZ2tVeC9EbHlSbW9WMnV5bEJWQ01zQUYvVERk?=
 =?utf-8?B?eDcvditSWmtVS0g2c2NmVlk5M3QvWnJNR0RoZkFWUkpJY1h0QXpVUlhVZ0h2?=
 =?utf-8?B?OVNJZlRBZmZIUWRxRUYydTNkVEFmRjkyUHd4aS9DSU05c2RGT1E1cHp3RXNP?=
 =?utf-8?B?N3JFdTlZRnk2czhwelpSY0MwZXVNbmh0SlRMamw5ZmFqSDZzdzhWVmVQWTA2?=
 =?utf-8?B?MmsyRUlYWEV5aEJ2bld0b2ZQL01EMzhRYittWXpUTndLS0pIT0Z1SnhhMnF4?=
 =?utf-8?B?dXdnUTlQNU9rNjFQODE2RGJnc0hSTVBjUlJ6TmF3YlM4VUdNTU9ZMnVtWGJ1?=
 =?utf-8?B?NUtoazMzcE1yaGlsU1VXNThXcnNjSHloS3pESGJ0S2YvSHR3TXhNemFjc2VY?=
 =?utf-8?B?K0NhSnBqY0ZCUEdlNnEydEFmZGN4cjRXMzI2YW5PZ2piTCtyZkl0TGdQSHZV?=
 =?utf-8?B?TVM2VlEzVTZJS3c0ZitmZkkyVzJFSTVCN0JxS3lhM1I4SkRqYUdMa3N2VDE1?=
 =?utf-8?B?WTdzVHozZEY2WnExVW1jc0p4MGJVZjZrbjgySTRiWEZkTlhhditpUnVHZXR6?=
 =?utf-8?B?YmQvaElmelA5Y1ZzQ2VPeE9WMnQ2K0JKTXpsdkdMS3ByUVJOaFZNSHV5V3ZJ?=
 =?utf-8?B?YmNNOFMyLy82eXY1dDNydHFGaE10QXlGdG5XaDJyMFNLVGdQUmF6Znd3NkVH?=
 =?utf-8?B?VHZDaGVHUCtPaXVHUEphNG1oTDhYYzJhNzBsSmRnei9SSW9nRnBzb21OU3VF?=
 =?utf-8?B?dGdtTk5Ua3RpRVdnbitwclRrY29LbjR1Y09ObUhWbkVzUUI4VFdidUJDNk9R?=
 =?utf-8?B?Um9sQlJRU0d2dFhmeWwzaFJ0Q253cExNQ0lpeXdTLzZQRHdDbTV0Wkd0MmtP?=
 =?utf-8?B?S3gwWUxnSFg1VnVwd2lqcDA0WHJCQWZOZWxHbU9mR3JhcjlYa04zTGJvRCs2?=
 =?utf-8?B?eC9TdlBkZ1NTWEtqTStDT0VlR1ZZak9HRFFYZnFSZHRQbVduUThPbGpWVnNB?=
 =?utf-8?B?QUdRSFBiRHl4dW9tRUJEQzdHSHJpa0M3MGVoOVJ5dWJuOU1ma2oxT2NQdHhl?=
 =?utf-8?B?K2prM1gzeWFOeGZmbVh5YnN2VytMZHdzbUM5bm9Seit6TXAxQUwxYmFKcDdZ?=
 =?utf-8?B?Wks5QVQzYk0xUkNHekJmeEpTWms4TWxqc2MxS3Jma3dnWHA5NUhXSUxTT3FS?=
 =?utf-8?B?ZTNhYXNMMUZwejg1cEpUdWJhemRCNTI5Yk9mYkx5STAwTkZZQzRsQ3Fsc2dt?=
 =?utf-8?Q?N0agmvPEHbjzr+OceXZN73BPJ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3A80B40DF22834419DF80944A001C584@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dd55728-02c7-4ed7-50e1-08da7ef1c2c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2022 19:10:04.5857
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8zr2sH/OrUTeObsPu731CY1xU17GJoPUMLlVyis/akm3rkZsyl5BPy3vubG5QIylUlvFtZogoNs/IW4ldplDD0+IRkq44sPpjsOa3hXPzss=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4551
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTUvMDgvMjAyMiAxNjoxNCwgTGFkIFByYWJoYWthciB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBJbnRyb2R1Y2UgU09DX1JFTkVTQVNfUlpGSVZF
IGNvbmZpZyBvcHRpb24gdG8gZW5hYmxlIFJlbmVzYXMgUlovRml2ZQ0KPiAoUjlBMDdHMDQzKSBT
b0MsIGFsb25nIHNpZGUgYWxzbyBhZGQgQVJDSF9SRU5FU0FTIGNvbmZpZyBvcHRpb24gYXMgbW9z
dA0KPiBvZiB0aGUgUmVuZXNhcyBkcml2ZXJzIGRlcGVuZCBvbiB0aGlzIGNvbmZpZyBvcHRpb24u
DQoNCkhleSBMYWQsDQoNCkkgdGhpbmsgSSBzYWlkIHNvbWV0aGluZyBzaW1pbGFyIG9uIHYxLCBi
dXQgSSBzYWlkIGl0IGFnYWluDQp0byBTYW11ZWwgdG9kYXkgc28gSSBtYXkgYXMgd2VsbCByZXBv
c3QgaGVyZSB0b286DQoiSSB0aGluayB0aGlzIGFuZCBwYXRjaCAxMi8xMiB3aXRoIHRoZSBkZWZj
b25maWcgY2hhbmdlcyBzaG91bGQgYmUNCmRlZmVycmVkIHVudGlsIHBvc3QgTFBDICh3aGljaCBz
dGlsbCBsZWF2ZXMgcGxlbnR5IG9mIHRpbWUgZm9yDQptYWtpbmcgdGhlIDYuMSBtZXJnZSB3aW5k
b3cpLiBXZSBhbHJlYWR5IGhhdmUgbGlrZSA0IGRpZmZlcmVudA0KYXBwcm9hY2hlcyBiZXR3ZWVu
IHRoZSBleGlzdGluZyBTT0NfRk9PIHN5bWJvbHMgJiB0d28gbW9yZSB3aGVuDQpEMSBzdHVmZiBh
bmQgdGhlIFJlbmVzYXMgc3R1ZmYgaXMgY29uc2lkZXJlZC4NCg0KUGxhbiBpcyB0byBkZWNpZGUg
YXQgTFBDIG9uIG9uZSBhcHByb2FjaCBmb3Igd2hhdCB0byBkbyB3aXRoDQpLY29uZmlnLnNvY3Mg
JiB0byBtZSBpdCBzZWVtcyBsaWtlIGEgZ29vZCBpZGVhIHRvIGRvIHdoYXQncyBiZWluZw0KZG9u
ZSBoZXJlIC0gaXQncyBsaWtlbHkgdGhhdCBmdXJ0aGVyIGFybSB2ZW5kb3JzIHdpbGwgbW92ZSBh
bmQNCmtlZXBpbmcgdGhlIGNvbW1vbiBzeW1ib2xzIG1ha2VzIGEgbG90IG9mIHNlbnNlIHRvIG1l
Li4uIg0KDQpBbHNvLCBmb3IgdGhlIHNha2Ugb2YgbXkgT0NEIGNvdWxkIHlvdSBwaWNrIGVpdGhl
ciByaXNjdiBvcg0KUklTQy1WIGFuZCB1c2UgaXQgZm9yIHRoZSB3aG9sZSBzZXJpZXM/IFBlZGFu
dGljIEkgZ3Vlc3MsIGJ1dA0KL3NocnVnDQoNClRoYW5rcywNCkNvbm9yLg0KDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBMYWQgUHJhYmhha2FyIDxwcmFiaGFrYXIubWFoYWRldi1sYWQucmpAYnAucmVu
ZXNhcy5jb20+DQo+IC0tLQ0KPiB2MS0+djINCj4gKiBObyBDaGFuZ2UNCj4gLS0tDQo+ICBhcmNo
L3Jpc2N2L0tjb25maWcuc29jcyB8IDE0ICsrKysrKysrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdl
ZCwgMTQgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3YvS2NvbmZp
Zy5zb2NzIGIvYXJjaC9yaXNjdi9LY29uZmlnLnNvY3MNCj4gaW5kZXggNjk3NzRiYjM2MmQ2Li45
MWI3ZjM4Yjc3YTggMTAwNjQ0DQo+IC0tLSBhL2FyY2gvcmlzY3YvS2NvbmZpZy5zb2NzDQo+ICsr
KyBiL2FyY2gvcmlzY3YvS2NvbmZpZy5zb2NzDQo+IEBAIC04MCw0ICs4MCwxOCBAQCBjb25maWcg
U09DX0NBTkFBTl9LMjEwX0RUQl9TT1VSQ0UNCj4gDQo+ICBlbmRpZiAjIFNPQ19DQU5BQU4NCj4g
DQo+ICtjb25maWcgQVJDSF9SRU5FU0FTDQo+ICsgICAgICAgYm9vbA0KPiArICAgICAgIHNlbGVj
dCBHUElPTElCDQo+ICsgICAgICAgc2VsZWN0IFBJTkNUUkwNCj4gKyAgICAgICBzZWxlY3QgU09D
X0JVUw0KPiArDQo+ICtjb25maWcgU09DX1JFTkVTQVNfUlpGSVZFDQo+ICsgICAgICAgYm9vbCAi
UmVuZXNhcyBSWi9GaXZlIFNvQyINCj4gKyAgICAgICBzZWxlY3QgQVJDSF9SOUEwN0cwNDMNCj4g
KyAgICAgICBzZWxlY3QgQVJDSF9SRU5FU0FTDQo+ICsgICAgICAgc2VsZWN0IFJFU0VUX0NPTlRS
T0xMRVINCj4gKyAgICAgICBoZWxwDQo+ICsgICAgICAgICBUaGlzIGVuYWJsZXMgc3VwcG9ydCBm
b3IgUmVuZXNhcyBSWi9GaXZlIFNvQy4NCj4gKw0KPiAgZW5kbWVudSAjICJTb0Mgc2VsZWN0aW9u
Ig0KPiAtLQ0KPiAyLjI1LjENCj4gDQoNCg==
