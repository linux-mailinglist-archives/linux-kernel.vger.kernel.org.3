Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 706025A7D37
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 14:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbiHaMYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 08:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbiHaMYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 08:24:39 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9DED34D6;
        Wed, 31 Aug 2022 05:24:38 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27VCCIUm027159;
        Wed, 31 Aug 2022 08:24:28 -0400
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3j7g67jtjh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 Aug 2022 08:24:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MMGqgqj/pcMY/jE92PcJ88yDPSIlb0T3gSCdXkDs0AKfOFpeHdXPC2Rq3rjvNiZvGYGHpuOqxVn8nNcX+NzzyZpfBt4nc+UUwYdLDE5BGdNE8iGD33uUQs+4s16lCVThARNoXbfYhQq/dmmTjRdJihJls5hR5NxJ+XHM7LBQoDDXfw3U+lY10jCINMSQMlGmtc42vT5aoSOK3wxhTZwcdjVmbz8YRUszWkpaj7UobIcahrckDjimXhDbxaBOTloOI/EY5U+CMlETEgEMH6+6HcCaEWLAXichqDBEsCHiC3vxvlfrQhoq6jIaIPCbRfbnT2kBdyz7rR6Iv9YoQJtt8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WY+1l91fhcosgzTgOdbb+qbHFXwKPgcqrlw9bGrHjAs=;
 b=mUftn5Ag1ih8UMD/Kssuz7qtdIDIVvvEEl63IecQmtQqJFDtYwVKhaI9Ve81EtqCA3TATcVlHVDRFMbEoa1ObPDr8ULK9Jy8TTZCG73f2w4eyfULIbHjfnEyATyXX8wxyCeYwmTeuC7a//SqrbbBfIR+PjbMZvzHgGe2rZ73M15WjCpju5wXr0LxybvIR15kZqRJRGU7YMCf8ZSgA8kUv2ReG1viMEaxjuFiMNehhmoxStXMiZxo8LsGqgw3jz3HGPO+Yffe/8nl77pqXAK/6/Zk3LG2kdEY4H9MC5FMHY3uPn+mXof0JQbvhiuAAqxoVtgU4JJ3hzylTtGZZ9LUaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WY+1l91fhcosgzTgOdbb+qbHFXwKPgcqrlw9bGrHjAs=;
 b=LOqtLB503cAXRWLtp0zTIfhHy1QOCAI8eQm17cwa/FNCU/+iyUuPbNWfZj6xhe/qgQE5XvV7OE/YsggaU2k4C2D3sMEUxNJ08ZqQwbJ/N7GCbiFBFrtvg5PTzEKl869g+nOqSwwWzsjgPFgIpVYUBoOMaXKE9w8Ily4p8ILx3fs=
Received: from SJ0PR03MB6778.namprd03.prod.outlook.com (2603:10b6:a03:40d::22)
 by CO1PR03MB5761.namprd03.prod.outlook.com (2603:10b6:303:91::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Wed, 31 Aug
 2022 12:24:26 +0000
Received: from SJ0PR03MB6778.namprd03.prod.outlook.com
 ([fe80::8c2c:7362:2747:3647]) by SJ0PR03MB6778.namprd03.prod.outlook.com
 ([fe80::8c2c:7362:2747:3647%3]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 12:24:26 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: RE: [PATCH v4 02/10] gpio: gpio-adp5588: drop the driver
Thread-Topic: [PATCH v4 02/10] gpio: gpio-adp5588: drop the driver
Thread-Index: AQHYu6lbpVe71mZQfk+rVi0u/x/jC63I8PYAgAAAZwCAAABQMA==
Date:   Wed, 31 Aug 2022 12:24:25 +0000
Message-ID: <SJ0PR03MB6778509D936170A4408B068999789@SJ0PR03MB6778.namprd03.prod.outlook.com>
References: <20220829131553.690063-1-nuno.sa@analog.com>
 <20220829131553.690063-3-nuno.sa@analog.com>
 <CACRpkdZYNhmqGPED0ghcT+y9uCeEVsPzHRxG9GyXt=r2pAPQKg@mail.gmail.com>
 <CACRpkdYL=-mny=tqmMmQVNKpPHVmQheEtVOd1uLKBaTbhjdAbA@mail.gmail.com>
In-Reply-To: <CACRpkdYL=-mny=tqmMmQVNKpPHVmQheEtVOd1uLKBaTbhjdAbA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dFpEZ3lZamczWXpRdE1qa3lOeTB4TVdWa0xUaGlabU10Wm1NM056YzBNakZt?=
 =?utf-8?B?WTJGbFhHRnRaUzEwWlhOMFhHUTRNbUk0TjJNMkxUSTVNamN0TVRGbFpDMDRZ?=
 =?utf-8?B?bVpqTFdaak56YzNOREl4Wm1OaFpXSnZaSGt1ZEhoMElpQnplajBpTVRRMU15?=
 =?utf-8?B?SWdkRDBpTVRNek1EWTBNakl5TmpNMk16STJOVEUzSWlCb1BTSTRVMUZ4WW5o?=
 =?utf-8?B?TE1XbzFjV0ZTT0d4cmRYaGFibEpWTldwSVNVMDlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZGYjBOQlFVSXhVRzh5WVU1TU0xbEJabnAyWjJWQ1VXVnRPRkF2VHl0Q05F?=
 =?utf-8?B?WkNObUozT0VSQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
 =?utf-8?B?QlFVRkVZVUZSUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJSVUZC?=
 =?utf-8?B?VVVGQ1FVRkJRVXB5YWtwSlVVRkJRVUZCUVVGQlFVRkJRVUZCUVVvMFFVRkJR?=
 =?utf-8?B?bWhCUjFGQllWRkNaa0ZJVFVGYVVVSnFRVWhWUVdOblFteEJSamhCWTBGQ2VV?=
 =?utf-8?B?RkhPRUZoWjBKc1FVZE5RV1JCUW5wQlJqaEJXbWRDYUVGSGQwRmpkMEpzUVVZ?=
 =?utf-8?B?NFFWcG5RblpCU0UxQllWRkNNRUZIYTBGa1owSnNRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkZRVUZCUVVGQlFVRkJRV2RCUVVG?=
 =?utf-8?B?QlFVRnVaMEZCUVVkRlFWcEJRbkJCUmpoQlkzZENiRUZIVFVGa1VVSjVRVWRW?=
 =?utf-8?B?UVZoM1FuZEJTRWxCWW5kQ2NVRkhWVUZaZDBJd1FVaE5RVmgzUWpCQlIydEJX?=
 =?utf-8?B?bEZDZVVGRVJVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCVVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVOQlFVRkJRVUZEWlVGQlFVRlpVVUpyUVVkclFWaDNRbnBCUjFWQldY?=
 =?utf-8?B?ZENNVUZJU1VGYVVVSm1RVWhCUVdOblFuWkJSMjlCV2xGQ2FrRklVVUZqZDBK?=
 =?utf-8?B?bVFVaFJRV0ZSUW14QlNFbEJUV2RCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFrRkJRVUZCUVVGQlFVRkpRVUZCUVVGQlFUMDlJaTgrUEM5dFpYUmhQZz09?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: baf4ae43-17b4-47c8-650b-08da8b4bbe64
x-ms-traffictypediagnostic: CO1PR03MB5761:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ogvKRASNUAuivCH2Bqmcc+9rVwDjEA2ggnXzGrxXZkuzXZCsw5bb0H59uIc7dv+e9XuyzYj5ilK2zWdvDlSv2A/ZMScpgm9FhlrWO3/BFU8mEYn4t6nEWOBVykereWnVTfQkCUkCls6JzZHvomOEPphWTD+soWezg/HYAR95+RS8ToE7zSEEABA1xJIvjmSKksy2skzReV2bgO0Zt9PZds/bmusrlQPyoP1eerpwrmo3KSo6xALFR6jw73rcDWcynMXu5g9bRRg/xDEVDjSoPj4KMNafNpcCF7tJaf3kPkEB2+EwhOU0tZo7UC7bw3itNgekAAoeYVNIYDyeAOhsYUBLBPS3619GdTop0ZDyPVPzabT35gT9yorvEN8znkpM0HSGeDrmO3yGjQqgzJ5hx027eql2tr52VX1AU0tvy6gptCmbgPgvepjf0Nbz5x1JwVFIVDE71w5qniA9qHMTBQdWb+7mc8EEZsK8qjlOrEjr4Do2nBT6e6DdgX0hDSW90f5ReMDUZJQTuJYSWxO0hSXk150JdE62EEzRgazaqBG1/w69uCShLwOsJBsdrn0Sa7zbx/oJF2BNJL3vIxuTv0a7xvPfDArA07yakzoDfTX4yeFy0L1WVP2YHT+1wvDPCZkUztWpXtTutzEeDURWdpXmBkJuVHQdoDQCNtDDVU3Gl4JE6tcpnmfPQAULVs1a2ijaMDGH+UjoXgFXX+67P0YVcK5ZxdLXmVaPRdMIFT9h6aOFM4v2IoZFHV4Kw2Ubvm8KY0svvEUVaBYQd63isQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6778.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(136003)(346002)(39860400002)(376002)(54906003)(316002)(6916009)(86362001)(4326008)(66476007)(66556008)(76116006)(8676002)(66946007)(71200400001)(66446008)(64756008)(41300700001)(8936002)(478600001)(5660300002)(52536014)(7416002)(38070700005)(107886003)(122000001)(6506007)(53546011)(2906002)(7696005)(38100700002)(9686003)(83380400001)(55016003)(186003)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dDB5dTluMzdGcy9Sc2NXSm9DaXlEeEhaS3pGRzJHUzFwM0RNbUdXczR3UEo0?=
 =?utf-8?B?UkVQajRCYUs0WlVrWjBQdkxleFlVTHpSbW55cCtTQlBkN3M2TExqalFBSlFN?=
 =?utf-8?B?MWkzTmtZYXNRTENubXM0K25KbExFVEhad3plUmdENTZTd21jZzJoR281bm1n?=
 =?utf-8?B?bkoxZ0JnakZvaTkzVjhPdStBbzJuV2tZN1ZMeWNQOWlsbzdpdGl4R3lxSGN2?=
 =?utf-8?B?VGMwSEkyZ252OTR5d3JScDRneVZ3S0dWRExCS2JpaGFUWEk1bmVSdGNRamZw?=
 =?utf-8?B?Z2MzMnU4cTZzdGxVVUJTU1JuSGkzVWFTVStCcVR1emNFMFNNamEyZFJqYzZG?=
 =?utf-8?B?UzFZS0t6NGI3UEVVUnkxWkJZREpQZXNpWVZzTXFQRFdKN3FKMTZjZHZzekt3?=
 =?utf-8?B?RjN5ekdjd2dYbkRNazNKQ21iZ21YbFNtcERWUmlCZURZUVE3WXI3blB0dEY1?=
 =?utf-8?B?QUpUdS9La3pTRWlSNHRoY2NMbmxQellhclY0UEVrMmNPb29zcStRZEJHUE5m?=
 =?utf-8?B?SnNYczB2MzdWWUJ1bHBYSDM3eEtYMjBYR1R0OEFlSExmV3QxR01vM3o4T1o2?=
 =?utf-8?B?dHdnMHF1YlBpMUxpRE5GUWk2UFJUWWRSUGVxQnU3dnFGWWZobkxTK0d4QTB4?=
 =?utf-8?B?NXJKeHlOTzZyNDEwMkJtZ2dpU2JPZEVtK2wwUXYyNTJGWk5HUVlMY1BvUzk3?=
 =?utf-8?B?YWh1dGtiTi9JWGozV216cmY3RnJxMTdHYnkxNkExNTdwMGllL3YyTlBzRFJ6?=
 =?utf-8?B?bm5SM0hOWGpacGxGd01SZUdZei9odmFqanhSTVJWeEtjRTFrcTA0VTUvSHp0?=
 =?utf-8?B?ampDS3dSVEFrYUJIZG5EQVl0WmticXRvRTdsUlhTRTVudGNyTHZROHQzYjFW?=
 =?utf-8?B?TnBIaE9yejM3c3Bkd0RwR2cySit5L29GcnAvVDJHQkFLRnZIdDdNL01zYTFK?=
 =?utf-8?B?L1hTU1FQNklWaHEzR3B6TkNWTzNuOGpIMW5qQytPSzNBT0dCWGFJZ0JmeXN0?=
 =?utf-8?B?WjhRVzBsUGU0QWx0eUxNc0Vjakl4VVQ3UG1ucXNWK1hncjJOdEpPY1YxaWRE?=
 =?utf-8?B?VkYxL1RhMHFsS3F0U3hZMGs0cE9uVmF6Ly9NT1g3c3pzL29RT0s4aUVRc3Bi?=
 =?utf-8?B?N3NuYWpLdnc5WnJCaURXM1pZWXh6RWZUNWRZM0lpZzVPbFQySlkwdC81TDRG?=
 =?utf-8?B?UlAyYjAxNzdpYUo4Rm1wSElTUnUxbU5oTnBvZU14L0cvbXkvaTJBeHljRkF0?=
 =?utf-8?B?cWlzSDdaN283VFMySlRpN2lHR1hwMXZoY3dpSVlsWkxxQUVzemFlRE1KWGhF?=
 =?utf-8?B?K3BvZGNhWEJJcXk5WlZ4aGYvK1VNdlIzcW9rL0pHUDRuRHp6czMvUmI4Z0dQ?=
 =?utf-8?B?ZXhNVFJlVUo0YmV5cmVCSGF0YXFuWG9keDVldUk2THdzd3BMZ05jT3FJbkJs?=
 =?utf-8?B?cFk5WFh1cy9TQXQvU2h5dlNBM1hwSXYvNDJCU0VaK24zazQ0TlYwa0t2LzVj?=
 =?utf-8?B?elJRMlZZYjRqeHZCTHl6UTBiVHVRNGgvd0VPdXVqTC9lYjlWT01yRmFoa3ow?=
 =?utf-8?B?Nnl6Kzh2NzIrYzBSeXFnM1F5QWZoT1FIY0NYYXlyOHI0eS9GSjhBeGVKSEdo?=
 =?utf-8?B?dXVwc3pzV1NmczArRTNOckxxVWE5TjRmRWxPblBBTVBjOVRwc3RMWExYSGdn?=
 =?utf-8?B?WWZLQW1OQzBlSjU0ZjZlN212eENwTEpEaTUxRStqL0ZSQTFLVCtWcm9iNGp2?=
 =?utf-8?B?VnZ2cll4cnpiRXZHVFU4YStPQnhpTlB0Wk1TMi9oZXdwdGlUVzFRbVE2YlU2?=
 =?utf-8?B?V2JHck9GMkZRK1BySlArL2dwUnN0cWFKc044bkgraHZiVmlRTFBucHpHY3Ru?=
 =?utf-8?B?MThzZUpaUWxWN1hzSFhwZGRwT1lPTVptY0FlNEhLcmljU2F1R3JDbE9WczVR?=
 =?utf-8?B?cmFyMjAvL0poMUNUQ2tEcDVoUXR6OFJyc0JWWGl0eHJ2N0lvK1BDWEhOWGhR?=
 =?utf-8?B?YU5HZDdnZGZtV2NPSGJOZU5BV0hrWlNZbTBpbHErYzRPWlpreXQzZEdPb2xN?=
 =?utf-8?B?RnRmNGxjQ3ErZ0VJQ3JyOThZK1VmS3UzZzJGRnpHTWpMTVVjVGhrQ0kyTVpj?=
 =?utf-8?B?cG12NkNDVzJ5T3dnRHFqVkZWYXYzWUE0bjBUM2oyUDZFbWtSUEdRVGxvb3Fo?=
 =?utf-8?Q?47UHbAd2J42ERmhpleYlXJRHSNGsm6ye3FuNecPcYRbW?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6778.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baf4ae43-17b4-47c8-650b-08da8b4bbe64
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2022 12:24:25.8780
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p4VCwzlNcD4kUJv+alO19SFxo0r7bhwzE6Bh+bV+YPVfphtXVY4lJHpmTZ1Jtc+hBal+a3MdbFT22/viwIyoaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR03MB5761
X-Proofpoint-ORIG-GUID: VoEJ4yQbtRGijwE0sUIjc8jZHoPgzoTn
X-Proofpoint-GUID: VoEJ4yQbtRGijwE0sUIjc8jZHoPgzoTn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-31_07,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 impostorscore=0 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208310062
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGludXMgV2FsbGVpaiA8
bGludXMud2FsbGVpakBsaW5hcm8ub3JnPg0KPiBTZW50OiBXZWRuZXNkYXksIEF1Z3VzdCAzMSwg
MjAyMiAyOjIzIFBNDQo+IFRvOiBTYSwgTnVubyA8TnVuby5TYUBhbmFsb2cuY29tPg0KPiBDYzog
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgQmFydG9zeiBHb2xhc3pld3NraQ0KPiA8YnJn
bEBiZ2Rldi5wbD47IERtaXRyeSBUb3Jva2hvdiA8ZG1pdHJ5LnRvcm9raG92QGdtYWlsLmNvbT47
DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1ncGlvQHZnZXIua2VybmVsLm9y
ZzsgbGludXgtDQo+IGlucHV0QHZnZXIua2VybmVsLm9yZzsgQW5keSBTaGV2Y2hlbmtvDQo+IDxh
bmR5LnNoZXZjaGVua29AZ21haWwuY29tPjsgUm9iIEhlcnJpbmcgPHJvYmgrZHRAa2VybmVsLm9y
Zz47DQo+IEtyenlzenRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJv
Lm9yZz47IEhlbm5lcmljaCwNCj4gTWljaGFlbCA8TWljaGFlbC5IZW5uZXJpY2hAYW5hbG9nLmNv
bT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NCAwMi8xMF0gZ3BpbzogZ3Bpby1hZHA1NTg4OiBk
cm9wIHRoZSBkcml2ZXINCj4gDQo+IFtFeHRlcm5hbF0NCj4gDQo+IE9uIFdlZCwgQXVnIDMxLCAy
MDIyIGF0IDI6MjEgUE0gTGludXMgV2FsbGVpag0KPiA8bGludXMud2FsbGVpakBsaW5hcm8ub3Jn
PiB3cm90ZToNCj4gPiBPbiBNb24sIEF1ZyAyOSwgMjAyMiBhdCAzOjE1IFBNIE51bm8gU8OhIDxu
dW5vLnNhQGFuYWxvZy5jb20+DQo+IHdyb3RlOg0KPiA+DQo+ID4gPiBXaXRoIGNvbW1pdCA3MDQ2
NmJhYWMzZGUNCj4gPiA+ICgiaW5wdXQ6IGtleWJvYXJkOiBhZHA1NTg4LWtleXM6IHN1cHBvcnQg
Z3BpIGtleSBldmVudHMgYXMgJ2dwaW8NCj4ga2V5cyciKSwNCj4gPg0KPiA+IFRoaXMgY29tbWl0
IGlzbid0IGluIHRoZSB1cHN0cmVhbSBrZXJuZWwuDQo+ID4NCj4gPiBBcmUgeW91IHVzaW5nIHNv
bWUgQW5hbG9nIGRldmljZXMgaW50ZXJuYWwgdHJlZT8gVXBzdHJlYW0NCj4gPiB0aG9zZSBjaGFu
Z2VzIGZpcnN0Lg0KPiANCj4gQWhhIEkgc2VlIHRoYXQgaXMgcGF0Y2ggMSwgT0sgdGhlIGhhc2gg
d2lsbCBjaGFuZ2UgYWxsIHRoZSB0aW1lIHNvIHlvdQ0KPiBjYW4ndCBpbmNsdWRlIHRoYXQgd2hl
biBkb2luZyBhIHBhdGNoIHNlcmllcy4gSnVzdCB1c2UgdGhlIHRpdGxlIG9mDQo+IHRoZSBwcmV2
aW91cyBwYXRjaCBpZiB5b3UgbmVlZCB0by4NCj4gDQoNCkFoaCBJIHNlZS4uLiBXaWxsIGRvIHRo
YXQgbmV4dCB0aW1lIEkgaGF2ZSBzb21ldGhpbmcgbGlrZSB0aGlzIDopDQoNCi0gTnVubyBTw6EN
Cg==
