Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E90565988
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 17:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234796AbiGDPLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 11:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234827AbiGDPLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 11:11:09 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF2410FFE
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 08:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1656947438; x=1688483438;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=6ylrDYKeGR9AhHNvfqkqySkmJ0K4XypnoOT7Jk4JAcE=;
  b=q4+KqkqNnf+HpLT9oYBIVVOFzOicmrxLO/tFMJ/MU7WypiF8gEutVHKN
   gulVlYCmOd6Utf5VtrFOcTbSXIWLHCfESW66/Fk1VKeVHkFW8lBnDbbaH
   1MF5vM1OScvtnYEi13or49/aWIAFzyCD5mieSTbdHjI5ihzeEQrGV0lhX
   sGDg+BHp3a9xqyAGHlWim+Lv47AAiw4xBXBlZtbEFfQrW/ktYS9kNE9Ym
   OOO7R/4hNjBSCeO1INSm3kgefBRwE9m1bBhF0aWEz9AFVIenLcNRuq1H9
   AsDb4B6dV7Yls9VbxbjK7WqJUQ/lJ0djFlqF7ZNPL021HXzDsNuxRs+CC
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="166288200"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Jul 2022 08:10:37 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 4 Jul 2022 08:10:36 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Mon, 4 Jul 2022 08:10:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q8tpRZ6Sf5tOJsGSuoVV96ZcIFp4GHoYxgq/QZiZa+fJRUYGGR+S5NXe9MEKVEhZLZFQVXlkadwJjuo2J1alJwcOPovTRRZd1Rc+TKFKCzSbOrsbjY0m7HD9C26GbmBPxKT2cqz8nFRSBhsiOt8x8Dol5R8tfrT2a72w+5CGXSdD2VWmxCe2m7xZsafkz5FZ2h9jysS3Y8BrmOgQoN0Y+/wtin1nEIbFJau3nvnF6Aqq9XhpNi54G/Y359ACKDlphGBwE2D4H7CC/8isbFG3cyo2L7nmtJC9FiVAUobyB3I/S146G+l6r9uvvGAltK+UDc1Zf+HYYpNiK0oi/NTNRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ylrDYKeGR9AhHNvfqkqySkmJ0K4XypnoOT7Jk4JAcE=;
 b=ZhuP2sgtc9QQElzwfq42fzXnIIUuqqhZSJW/Tfe8YsZPzOLj5diTJoTMvYRZ4twIQEZd739OHBpl2pGiI4/2c9bkkQpwNLntV1BdsjpLq5I2VrTKcmxynyxGFGTIOgrYZf62meSC8i3DkwRolGIT4eN34ifndRI4usT7I61nUpvCXOaxn0Tv091xz6UATIiZZQoSdDWonquoyztTVJHy225dLZoXNKbeHfLXe+x8EbyJqDPfZRhol1TfTvnW6h21ELlMPXg5n/uW7bCAs7F3CMaQgr9HMyd9jB+YC6c/AMqSztqigFMvre12Gdc8dQkGncZ6gpBsbLtoFXOiqMqC3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ylrDYKeGR9AhHNvfqkqySkmJ0K4XypnoOT7Jk4JAcE=;
 b=st0ZYhtdU5OROONkMfFJVf4oekJJhxFu9AxiREQShnCcAq/GoFfdDOFyKKry1pe3nbz6H6Q+oARJKijcdrAZ5Wl47FzL1JmRxNkHV9xf+9VB4YWuTa6GkKio3or9taMOmfLToqwTxWPJRUrHFXWxAQjzQS0XMcKzEYdELjQBzYI=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by BYAPR11MB3528.namprd11.prod.outlook.com (2603:10b6:a03:87::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Mon, 4 Jul
 2022 15:10:30 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa%4]) with mapi id 15.20.5395.020; Mon, 4 Jul 2022
 15:10:30 +0000
From:   <Conor.Dooley@microchip.com>
To:     <sudeep.holla@arm.com>, <linux-kernel@vger.kernel.org>,
        <gregkh@linuxfoundation.org>
CC:     <Valentina.FernandezAlanis@microchip.com>,
        <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
        <wangqing@vivo.com>, <robh+dt@kernel.org>, <rafael@kernel.org>,
        <ionela.voinescu@arm.com>, <pierre.gondois@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v6 00/21] arch_topology: Updates to add socket support and
 fix cluster ids
Thread-Topic: [PATCH v6 00/21] arch_topology: Updates to add socket support
 and fix cluster ids
Thread-Index: AQHYj48tVAbdjlL6mUiIMD866kQSr61uUUaA
Date:   Mon, 4 Jul 2022 15:10:30 +0000
Message-ID: <6a647b6b-c913-b9d7-a23e-b17a8034c5c8@microchip.com>
References: <20220704101605.1318280-1-sudeep.holla@arm.com>
In-Reply-To: <20220704101605.1318280-1-sudeep.holla@arm.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 49b8f98a-9a8b-43a8-819d-08da5dcf55b9
x-ms-traffictypediagnostic: BYAPR11MB3528:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?utf-8?B?c0xGWGdIWkxDSGxjVThBaWIwclNRZEQxWnJmcmhrNzkvdWpkSndkZ0pCZFlt?=
 =?utf-8?B?YXZjQVNNYnN4ZHdhdmhSRGw5dEYvOWZFWEd4cXE2bloydDJTdkgvQ2M2Yy9h?=
 =?utf-8?B?aVF0TDJYMmViTDJ3ZFNsRFE2UDRyZUxtZTI2eW9JakRUMUkvYVdMZlhFZEhx?=
 =?utf-8?B?R29EU1JVanZHb0RCTCsySUJIVmRqNWxIMkY0MzU1VzEyMXFhT0JEK1hLUlFh?=
 =?utf-8?B?aEhjRjJJemtlblVqOW5ZS2FDbitHM0hJRmliaDlwM3JsUUV2UUxNUTh1aGU4?=
 =?utf-8?B?WU1HU041WXl3UWxIWFpLV2lTbFhINU9Ec0VUYUFidDBvc1lReHdPRnZDUzk3?=
 =?utf-8?B?NTg3eTR0RERJSnFRSkVoQXlIRVBSekhTOVVWWW1TM0R0QkIrcXdjRFRnN2hr?=
 =?utf-8?B?TUtMSzZMUmNKZ2hjd2l0dGE5djZ1VkNvTFQxNnV1cUhPYStOejhBSVJCYXJQ?=
 =?utf-8?B?cGVMWTUyc0hJcEhvOUFjSi8zbUJDelJEVkdwN1R2SDRpV1YvL2NzVXB1YjRE?=
 =?utf-8?B?c042a0QrN3BVZ2k1UG1hSmY3T3orNjY4aEFOd29rbXFXU1hoMTFmOHFTMExM?=
 =?utf-8?B?RGFuU1FBMTVoODh2aUtYeXFCTm82RzVKelJTc2c2TXZCM1RFMmhNd0xQaDEw?=
 =?utf-8?B?bGRNdDNPVm1XZzVKMlFxMHFjU2s4ZUhBZlNTNzByZTdoaCtSSkNLK1lhSTNL?=
 =?utf-8?B?Z0JIZFpMemNXTnJsWHhrVXZPcFlZWTBvekFzV3BiQnhEdkJnMWNJb2tqQ0Qw?=
 =?utf-8?B?Q1Jwc2Y1TDVRZ2dkNXNhbUFaMndVK053NjRENGZRcEVXbUppdkZEcGpJdFE5?=
 =?utf-8?B?QUdIOENQMUFwRjJvMU95b0k5Z1c2NmJiTm4yTFVnSkVEYnlZTzBOaWpjSWR5?=
 =?utf-8?B?V1diWEJVdWZ1anpjNUkyZHdNRXNvcVkrQ2ZDK3Z0eUdqSWhNR3pCVFhVQWJJ?=
 =?utf-8?B?cnd2WmdGcDdmb2lCWCtnWDdMbklJd0xtM3FlYTZxNUMyL0tsRWsyVE52eHRX?=
 =?utf-8?B?ZG4xU3pJOFlHeStYNDZnOEhFNmkrKzQ0TU9RWEhCZDJCSDQvaDFEc3NzVU9L?=
 =?utf-8?B?c0FXVFM1Y3hQbU5nQnhlZjhZM3VVdEJJaUZubjNVSlBBTUk0OGZxNm9obXhI?=
 =?utf-8?B?c2E2U3l0N05TeHB2eXF1RUhlM3hMQm9Kd2EvQjQwNm5ScW0vYlVOZ09OditI?=
 =?utf-8?B?NDcwbk5CWkY0NFhKQzF2OFdHdGtQc2plUG94K2RrcFczdUc4ZDhaUzJVNzVq?=
 =?utf-8?B?c0lWM3dzbXI5U3hGa3Z5QzJPenZ5WEFLdnA4VzRHeE9LN0hEQT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(376002)(396003)(136003)(366004)(346002)(66446008)(66946007)(5660300002)(64756008)(15650500001)(66476007)(66556008)(7416002)(8936002)(2906002)(86362001)(36756003)(31696002)(186003)(122000001)(38100700002)(76116006)(38070700005)(71200400001)(6486002)(41300700001)(478600001)(91956017)(316002)(54906003)(53546011)(110136005)(83380400001)(2616005)(8676002)(31686004)(26005)(6512007)(966005)(6506007)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MTkzNGRqUVNHZHowTzl1U1U5dXA4MkpRWExaTGN2QzJqUDVSNytYQ1hsajJM?=
 =?utf-8?B?NGtLd2h6WjZkMkJKRWpOa2hVaUU5czk3Q0htbFh5Vjk4dlhwRENpcUpwcTBm?=
 =?utf-8?B?bGlJeCtDWUxCYmdVUzkyTHk5Y2QrOURMLy9KWHZqeW9rT3ZKUXdncGI4K2o1?=
 =?utf-8?B?V0pHVHczM1MxUEtYL09xZXhTVFkrUUpzOXdOS0lRYm1kWW5hRjY1MlFhSXFx?=
 =?utf-8?B?MGprTTcycTlKcVNVcFJjdFRaQXF2VDg1bnBBczRKSDBGRFRTZE9FN1FTRnJy?=
 =?utf-8?B?aTRBelNJN1hwSkMxbzI5cUtpRlJOdC9TcGlnTTJyQndHZDVUSGNWdk15RU1L?=
 =?utf-8?B?TXZIZVl6dFNvTkZRa3hOVWVDL2F6RnUycGtycWV4SnkyYjd1WDBjL0dLbzJn?=
 =?utf-8?B?dEVWWkJEcFlZQ1pHV3c1QWFRSEt6NUZvdWVoN3hDclNoRVRQQ245MnZRdFNr?=
 =?utf-8?B?Vlp4eXVBTnlPYnVKdm1sNTd0T2hZemtHYksycnZPOWorTlQ5SlhSRCsvYkVR?=
 =?utf-8?B?OWNsTUF6SGhDSVUvWnhGazZUNVBsV21zL3RPalRuc1JqaStSRW9DWXVuV25h?=
 =?utf-8?B?SDI1S0tLQk9zN2pJN2FXazQrVFRDZ3EvTDBYRHp5OEwrbXY0RnJEdlY4cDZU?=
 =?utf-8?B?V1ZmY0U2alYwWWxEL0hYaEpsdXc2UzRwYzFYYnVHOUFWL2N4MGprWjZnVzFq?=
 =?utf-8?B?Wjg1L2NYQ0RyYUpqMUlrWnRlNkRLMklsZ2VsczdaY2ZaLzhqVkVJWSsxQ3JQ?=
 =?utf-8?B?QUpSSTVkaytYNm1wbTdCZitTcGwraVJVS08zd0Y4dTF4UG5mazFZQWJwSk40?=
 =?utf-8?B?clRld2IxanJtRXBHREFvanVuNWNTd0xEdmxvdmZCRHVudUhTdm1VYXBXMzI0?=
 =?utf-8?B?VnlQRTZsVVpRT3hWMDVyZWpiUk5KT1ovTXhzWDRzRXpDeUk2NlpKZnk5ZTJt?=
 =?utf-8?B?VVpoK3hsVDIxMm1CVVRLTE5hK1BoR0Ixd0hiZjhnc0U0V0hOSDVzZ3doSmc5?=
 =?utf-8?B?d0tBRW9aMkRDTy9JOHVEVlZ6ZEwzK0tZN1dwTVZ4Q3FXb1dLZnNXb1lmb01w?=
 =?utf-8?B?bDVTck9tOGJSLzFCK0w5Sk8zQk5UaEdiOEVHdTF0YXdJOTN5UVVFYW0rWjdk?=
 =?utf-8?B?Uk5pVzQwc1YrQmlYcTNmWGtROHNoeElhNm13S0VZdEU4dFAvZ1o5NDdjQUNR?=
 =?utf-8?B?cGNMSEVJbEtQZW4yRXVTd05VWkVkZThqTHUwblp0MGhxNXJRRlN0VDgrUkph?=
 =?utf-8?B?cllqN2FJdkdFSGVoMDdSNnVIait3QmZBSnAzZEJyMktSM3FjRGNyaXBiNVJp?=
 =?utf-8?B?QmJKNVZjYytiZXpHbXl2elJTZjJJRG5JSTRFY3ZhQ2tkckM5MnVFUzFFUjFZ?=
 =?utf-8?B?YWtsbkZnZTRPSWZURnFjMTkvOFU5N0laTllHTWZybGs0NTF1UERVOHpyVWJ1?=
 =?utf-8?B?cU9jbzd3L2tsdG5lSmZtZ2M5UUhXYmlsMW1iT1JzOHlDM1dZTmlwRXMwVjl5?=
 =?utf-8?B?UnFIOGVoZVpvRnhsMzA0QVloelVhK3RtMEd6NTg1NllnaEROTlZaOWNhRDZK?=
 =?utf-8?B?NXdtODhOTjdaQWtMU1VHUndtZlAzL3dqVDJ3RjRIS3ErdE5aL3BHN3dDZHJ5?=
 =?utf-8?B?MjRaUy9GVVlxOUhzemJ4ck9RTE1CZGM0b21GdTRRTk9zbVVlTEYvdmpKT3Rs?=
 =?utf-8?B?VTJBTDY0ZkdLM1F5UUtXU1gxakY3VXd3RGdNRWJvOFY3Yzh1N0xTSWNNcmE2?=
 =?utf-8?B?MlVtUWZkdFNTVWhwK1JBcmZGempIQ2o2NHl2Wm5aVEQ3bzF2WlNvOTJKQ0Ix?=
 =?utf-8?B?Ni8xUW8wZ3Iremkxenc2R0pkV2g3R1pVU2dZZjNmN3hTY1BWSVdzcnpIbzZO?=
 =?utf-8?B?TXhOc1BZSitCVldydXMzTHZXUGJLSytYbGpyZXZuTzhsZm16Ymtzajh3SWUx?=
 =?utf-8?B?UW9kbWNBSjJOc2ozcmJNNTBGRG1SM1FMamVZNXhveWZwUXgrTVZjajlXYkFp?=
 =?utf-8?B?WElGSzVjNldKL1FxUjcvOGdtRGJJR0JSODZhL3ZKWWpwVDRUdDJWV1lsMWVu?=
 =?utf-8?B?cVl1K2t3U0grRHM3bmhNQ2lZSDkwbTRnSEd3a0hnNTJWTExhM29jYk1iVnJ0?=
 =?utf-8?Q?vGPTmMBJpAgaKmNqnsqPxp2ew?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C37C2530732E4B4AA8D583D390C35246@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49b8f98a-9a8b-43a8-819d-08da5dcf55b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2022 15:10:30.3711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z5NEOyxYkKHDlRiifngNHCo6VnYd/LMy5w2eI0sfV/bDbbo6gtOg/dGQOFxKisOOobKIF+RwVf1AZ6hy9lpO7uHHjcdFBCic1oqIr+uSFyA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3528
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDQvMDcvMjAyMiAxMToxNSwgU3VkZWVwIEhvbGxhIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IEhpIEdyZWcsDQo+IA0KPiBMZXQgbWUga25vdyBp
ZiB5b3UgcHJlZmVyIHRvIHB1bGwgdGhlIHBhdGNoZXMgZGlyZWN0bHkgb3IgcHJlZmVyIHB1bGwN
Cj4gcmVxdWVzdC4gSXQgaGFzIGJlZW4gaW4gLW5leHQgZm9yIGEgd2hpbGUgbm93Lg0KPiANCj4g
SGkgQWxsLA0KPiANCj4gVGhpcyB2ZXJzaW9uIHVwZGF0ZXMgY2FjaGVpbmZvIHRvIHBvcHVsYXRl
IGFuZCB1c2UgdGhlIGluZm9ybWF0aW9uIGZyb20NCj4gdGhlcmUgZm9yIGFsbCB0aGUgY2FjaGUg
dG9wb2xvZ3kuDQo+IA0KPiBUaGlzIHNlcmllcyBpbnRlbmRzIHRvIGZpeCBzb21lIGRpc2NyZXBh
bmNpZXMgd2UgaGF2ZSBpbiB0aGUgQ1BVIHRvcG9sb2d5DQo+IHBhcnNpbmcgZnJvbSB0aGUgZGV2
aWNlIHRyZWUgL2NwdS1tYXAgbm9kZS4gQWxzbyB0aGlzIGRpdmVyZ2VzIGZyb20gdGhlDQo+IGJl
aGF2aW91ciBvbiBhIEFDUEkgZW5hYmxlZCBwbGF0Zm9ybS4gVGhlIGV4cGVjdGF0aW9uIGlzIHRo
YXQgYm90aCBEVA0KPiBhbmQgQUNQSSBlbmFibGVkIHN5c3RlbXMgbXVzdCBwcmVzZW50IGNvbnNp
c3RlbnQgdmlldyBvZiB0aGUgQ1BVIHRvcG9sb2d5Lg0KPiANCj4gQ3VycmVudGx5IHdlIGFzc2ln
biBnZW5lcmF0ZWQgY2x1c3RlciBjb3VudCBhcyB0aGUgcGh5c2ljYWwgcGFja2FnZSBpZGVudGlm
aWVyDQo+IGZvciBlYWNoIENQVSB3aGljaCBpcyB3cm9uZy4gVGhlIGRldmljZSB0cmVlIGJpbmRp
bmdzIGZvciBDUFUgdG9wb2xvZ3kgc3VwcG9ydHMNCj4gc29ja2V0cyB0byBpbmZlciB0aGUgc29j
a2V0IG9yIHBoeXNpY2FsIHBhY2thZ2UgaWRlbnRpZmllciBmb3IgYSBnaXZlbiBDUFUuDQo+IEFs
c28gd2UgZG9uJ3QgY2hlY2sgaWYgYWxsIHRoZSBjb3Jlcy90aHJlYWRzIGJlbG9uZyB0byB0aGUg
c2FtZSBjbHVzdGVyIGJlZm9yZQ0KPiB1cGRhdGluZyB0aGVpciBzaWJsaW5nIG1hc2tzIHdoaWNo
IGlzIGZpbmUgYXMgd2UgZG9uJ3Qgc2V0IHRoZSBjbHVzdGVyIGlkIHlldC4NCj4gDQo+IFRoZXNl
IGNoYW5nZXMgYWxzbyBhc3NpZ25zIHRoZSBjbHVzdGVyIGlkZW50aWZpZXIgYXMgcGFyc2VkIGZy
b20gdGhlIGRldmljZSB0cmVlDQo+IGNsdXN0ZXIgbm9kZXMgd2l0aGluIC9jcHUtbWFwIHdpdGhv
dXQgc3VwcG9ydCBmb3IgbmVzdGluZyBvZiB0aGUgY2x1c3RlcnMuDQo+IEZpbmFsbHksIGl0IGFs
c28gYWRkIHN1cHBvcnQgZm9yIHNvY2tldCBub2RlcyBpbiAvY3B1LW1hcC4gV2l0aCB0aGlzIHRo
ZQ0KPiBwYXJzaW5nIG9mIGV4YWN0IHNhbWUgaW5mb3JtYXRpb24gZnJvbSBBQ1BJIFBQVFQgYW5k
IC9jcHUtbWFwIERUIG5vZGUNCj4gYWxpZ25zIHdlbGwuDQo+IA0KPiBUaGUgb25seSBleGNlcHRp
b24gaXMgdGhhdCB0aGUgbGFzdCBsZXZlbCBjYWNoZSBpZCBpbmZvcm1hdGlvbiBjYW4gYmUNCj4g
aW5mZXJyZWQgZnJvbSB0aGUgc2FtZSBBQ1BJIFBQVFQgd2hpbGUgd2UgbmVlZCB0byBwYXJzZSBD
UFUgY2FjaGUgbm9kZXMNCj4gaW4gdGhlIGRldmljZSB0cmVlLg0KDQpGb3IgRFQgKyBSSVNDLVYg
b24gUG9sYXJGaXJlIFNvQyBhbmQgU2lGaXZlIGZ1NTQwDQpUZXN0ZWQtYnk6IENvbm9yIERvb2xl
eSA8Y29ub3IuZG9vbGV5QG1pY3JvY2hpcC5jb20+DQoNCkFuZWNkb3RhbGx5LCB2NSB3YXMgdGVz
dGVkIG9uIHRoZSAhU01QIEQxIHdoaWNoIHdvcmtlZCBmaW5lIHdoZW4NCkNPTkZJR19TTVAgd2Fz
IGVuYWJsZWQuDQoNClRoYW5rcywNCkNvbm9yLg0KDQo+IA0KPiANCj4gdjVbNV0tPnY2Og0KPiAg
ICAgICAgIC0gSGFuZGxlZCBvdXQgb2YgbWVtb3J5IGNhc2UgaW4gZWFybHkgZGV0ZWN0ZWQgY29y
cmVjdGx5IGFmdGVyDQo+ICAgICAgICAgICBDb25vciByZXBvcnRlZCBib290IGZhaWx1cmVzIG9u
IHNvbWUgUklTQy1WIHBsYXRmb3JtLiBBbHNvDQo+ICAgICAgICAgICBhZGRlZCBhIGxvZyB0byBz
aG93IHVwIGZhaWx1cmUgb2YgZWFybHkgY2FjaGVpbmZvIGRldGVjdGlvbi4NCj4gICAgICAgICAt
IEFkZGVkICJSZW1vdmUgdGhlIHVudXNlZCBmaW5kX2FjcGlfY3B1X2NhY2hlX3RvcG9sb2d5KCki
IHdoaWNoDQo+ICAgICAgICAgICB3YXMgbWlzc2VkIGVhcmxpZXIgYW5kIHBvc3RlZCBzZXBhcmF0
ZWx5DQo+ICAgICAgICAgLSBBZGRlZCBhbGwgdGhlIGFkZGl0aW9uYWwgdGFncyByZWNpZXZlZA0K
PiANCj4gdjRbNF0tPnY1WzVdOg0KPiAgICAgICAgIC0gQWRkZWQgYWxsIHRoZSB0YWdzIHJlY2ll
dmVkIHNvIGZhci4gUmFmYWVsIGhhcyBhY2tlZCBvbmx5IGNoYW5nZQ0KPiAgICAgICAgICAgaW4g
QUNQSSBhbmQgQ2F0YWxpbiBoYXMgYWNrZWQgb25seSBjaGFuZ2UgaW4gYXJtNjQuDQo+ICAgICAg
ICAgLSBBZGRyZXNzZWQgYWxsIHRoZSB0eXBvcyBwb2ludGVkIGJ5IElvbmVsYSBhbmQgZHJvcHBl
ZCB0aGUgcGF0Y2gNCj4gICAgICAgICAgIHJlbW92aW5nIHRoZSBjaGVja3MgZm9yIGludmFsaWQg
cGFja2FnZSBpZCBhcyBkaXNjdXNzZWQgYW5kIHVwZGF0ZQ0KPiAgICAgICAgICAgZGVwdGggaW4g
bmVzdGVkIGNsdXN0ZXIgd2FybmluZyBjaGVjay4NCj4gDQo+IHYzWzNdLT52NFs0XToNCj4gICAg
ICAgICAtIFVwZGF0ZWQgQUNQSSBQUFRUIGZ3X3Rva2VuIHRvIHVzZSB0YWJsZSBvZmZzZXQgaW5z
dGVhZCBvZiB2aXJ0dWFsDQo+ICAgICAgICAgICBhZGRyZXNzIGFzIGl0IGNvdWxkIGdldCBjaGFu
Z2VkIGZvciBldmVyeXRpbWUgaXQgaXMgbWFwcGVkIGJlZm9yZQ0KPiAgICAgICAgICAgdGhlIGds
b2JhbCBhY3BpX3Blcm1hbmVudF9tbWFwIGlzIHNldA0KPiAgICAgICAgIC0gQWRkZWQgd2Fybmlu
ZyBmb3IgdGhlIHRvcG9sb2d5IHdpdGggbmVzdGVkIGNsdXN0ZXJzDQo+ICAgICAgICAgLSBBZGRl
ZCB1cGRhdGUgdG8gY3B1X2NsdXN0ZXJncm91cF9tYXNrIHNvIHRoYXQgaW50cm9kdWN0aW9uIG9m
DQo+ICAgICAgICAgICBjb3JyZWN0IGNsdXN0ZXJfaWQgZG9lc24ndCBicmVhayBleGlzdGluZyBw
bGF0Zm9ybXMgYnkgbGltaXRpbmcNCj4gICAgICAgICAgIHRoZSBzcGFuIG9mIGNsdXN0ZXJncm91
cF9tYXNrKGJ5IElvbmVsYSkNCj4gDQo+IHYyWzJdLT52M1szXToNCj4gICAgICAgICAtIERyb3Bw
ZWQgc3VwcG9ydCB0byBnZXQgdGhlIGRldmljZSBub2RlIGZvciB0aGUgQ1BVJ3MgTExDDQo+ICAg
ICAgICAgLSBVcGRhdGVkIGNhY2hlaW5mbyB0byBzdXBwb3J0IGNhbGxpbmcgb2YgZGV0ZWN0X2Nh
Y2hlX2F0dHJpYnV0ZXMNCj4gICAgICAgICAgIGVhcmx5IGluIHNtcF9wcmVwYXJlX2NwdXMgc3Rh
Z2UNCj4gICAgICAgICAtIEFkZGVkIHN1cHBvcnQgdG8gY2hlY2sgaWYgTExDIGlzIHZhbGlkIGFu
ZCBzaGFyZWQgaW4gdGhlIGNhY2hlaW5mbw0KPiAgICAgICAgIC0gVXNlZCB0aGUgc2FtZSBpbiBh
cmNoX3RvcG9sb2d5DQo+IA0KPiB2MVsxXS0+djJbMl06DQo+ICAgICAgICAgLSBVcGRhdGVkIElE
IHZhbGlkaXR5IGNoZWNrIGluY2x1ZGUgYWxsIG5vbi1uZWdhdGl2ZSB2YWx1ZQ0KPiAgICAgICAg
IC0gQWRkZWQgc3VwcG9ydCB0byBnZXQgdGhlIGRldmljZSBub2RlIGZvciB0aGUgQ1BVJ3MgbGFz
dCBsZXZlbCBjYWNoZQ0KPiAgICAgICAgIC0gQWRkZWQgc3VwcG9ydCB0byBidWlsZCBsbGNfc2li
bGluZyBvbiBEVCBwbGF0Zm9ybXMNCj4gDQo+IFsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9s
a21sLzIwMjIwNTEzMDk1NTU5LjEwMzQ2MzMtMS1zdWRlZXAuaG9sbGFAYXJtLmNvbQ0KPiBbMl0g
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIyMDUxODA5MzMyNS4yMDcwMzM2LTEtc3Vk
ZWVwLmhvbGxhQGFybS5jb20NCj4gWzNdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAy
MjA1MjUwODE0MTYuMzMwNjA0My0xLXN1ZGVlcC5ob2xsYUBhcm0uY29tDQo+IFs0XSBodHRwczov
L2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjIwNjIxMTkyMDM0LjMzMzI1NDYtMS1zdWRlZXAuaG9s
bGFAYXJtLmNvbQ0KPiBbNV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIyMDYyNzE2
NTA0Ny4zMzY2NjktMS1zdWRlZXAuaG9sbGFAYXJtLmNvbQ0KPiANCj4gSW9uZWxhIFZvaW5lc2N1
ICgxKToNCj4gICBhcmNoX3RvcG9sb2d5OiBMaW1pdCBzcGFuIG9mIGNwdV9jbHVzdGVyZ3JvdXBf
bWFzaygpDQo+IA0KPiBTdWRlZXAgSG9sbGEgKDIwKToNCj4gICBBQ1BJOiBQUFRUOiBVc2UgdGFi
bGUgb2Zmc2V0IGFzIGZ3X3Rva2VuIGluc3RlYWQgb2YgdmlydHVhbCBhZGRyZXNzDQo+ICAgY2Fj
aGVpbmZvOiBVc2Ugb2ZfY3B1X2RldmljZV9ub2RlX2dldCBpbnN0ZWFkIGNwdV9kZXYtPm9mX25v
ZGUNCj4gICBjYWNoZWluZm86IEFkZCBoZWxwZXIgdG8gYWNjZXNzIGFueSBjYWNoZSBpbmRleCBm
b3IgYSBnaXZlbiBDUFUNCj4gICBjYWNoZWluZm86IE1vdmUgY2FjaGVfbGVhdmVzX2FyZV9zaGFy
ZWQgb3V0IG9mIENPTkZJR19PRg0KPiAgIGNhY2hlaW5mbzogQWRkIHN1cHBvcnQgdG8gY2hlY2sg
aWYgbGFzdCBsZXZlbCBjYWNoZShMTEMpIGlzIHZhbGlkIG9yIHNoYXJlZA0KPiAgIGNhY2hlaW5m
bzogQWxsb3cgZWFybHkgZGV0ZWN0aW9uIGFuZCBwb3B1bGF0aW9uIG9mIGNhY2hlIGF0dHJpYnV0
ZXMNCj4gICBjYWNoZWluZm86IFVzZSBjYWNoZSBpZGVudGlmaWVycyB0byBjaGVjayBpZiB0aGUg
Y2FjaGVzIGFyZSBzaGFyZWQgaWYgYXZhaWxhYmxlDQo+ICAgY2FjaGVpbmZvOiBBbGlnbiBjaGVj
a3MgaW4gY2FjaGVfc2hhcmVkX2NwdV9tYXBfe3NldHVwLHJlbW92ZX0gZm9yIHJlYWRhYmlsaXR5
DQo+ICAgYXJjaF90b3BvbG9neTogQWRkIHN1cHBvcnQgdG8gcGFyc2UgYW5kIGRldGVjdCBjYWNo
ZSBhdHRyaWJ1dGVzDQo+ICAgYXJjaF90b3BvbG9neTogVXNlIHRoZSBsYXN0IGxldmVsIGNhY2hl
IGluZm9ybWF0aW9uIGZyb20gdGhlIGNhY2hlaW5mbw0KPiAgIGFybTY0OiB0b3BvbG9neTogUmVt
b3ZlIHJlZHVuZGFudCBzZXR0aW5nIG9mIGxsY19pZCBpbiBDUFUgdG9wb2xvZ3kNCj4gICBhcmNo
X3RvcG9sb2d5OiBEcm9wIExMQyBpZGVudGlmaWVyIHN0YXNoIGZyb20gdGhlIENQVSB0b3BvbG9n
eQ0KPiAgIGFyY2hfdG9wb2xvZ3k6IFNldCB0aHJlYWQgc2libGluZyBjcHVtYXNrIG9ubHkgd2l0
aGluIHRoZSBjbHVzdGVyDQo+ICAgYXJjaF90b3BvbG9neTogQ2hlY2sgZm9yIG5vbi1uZWdhdGl2
ZSB2YWx1ZSByYXRoZXIgdGhhbiAtMSBmb3IgSURzIHZhbGlkaXR5DQo+ICAgYXJjaF90b3BvbG9n
eTogQXZvaWQgcGFyc2luZyB0aHJvdWdoIGFsbCB0aGUgQ1BVcyBvbmNlIGEgb3V0bGllciBDUFUg
aXMgZm91bmQNCj4gICBhcmNoX3RvcG9sb2d5OiBEb24ndCBzZXQgY2x1c3RlciBpZGVudGlmaWVy
IGFzIHBoeXNpY2FsIHBhY2thZ2UgaWRlbnRpZmllcg0KPiAgIGFyY2hfdG9wb2xvZ3k6IFNldCBj
bHVzdGVyIGlkZW50aWZpZXIgaW4gZWFjaCBjb3JlL3RocmVhZCBmcm9tIC9jcHUtbWFwDQo+ICAg
YXJjaF90b3BvbG9neTogQWRkIHN1cHBvcnQgZm9yIHBhcnNpbmcgc29ja2V0cyBpbiAvY3B1LW1h
cA0KPiAgIGFyY2hfdG9wb2xvZ3k6IFdhcm4gdGhhdCB0b3BvbG9neSBmb3IgbmVzdGVkIGNsdXN0
ZXJzIGlzIG5vdCBzdXBwb3J0ZWQNCj4gICBBQ1BJOiBSZW1vdmUgdGhlIHVudXNlZCBmaW5kX2Fj
cGlfY3B1X2NhY2hlX3RvcG9sb2d5KCkNCj4gDQo+ICBhcmNoL2FybTY0L2tlcm5lbC90b3BvbG9n
eS5jICB8ICAxNCAtLS0tDQo+ICBkcml2ZXJzL2FjcGkvcHB0dC5jICAgICAgICAgICB8ICA0MCAr
LS0tLS0tLS0tDQo+ICBkcml2ZXJzL2Jhc2UvYXJjaF90b3BvbG9neS5jICB8IDEwMiArKysrKysr
KysrKysrKysrKystLS0tLS0NCj4gIGRyaXZlcnMvYmFzZS9jYWNoZWluZm8uYyAgICAgIHwgMTQz
ICsrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0NCj4gIGluY2x1ZGUvbGludXgvYWNw
aS5oICAgICAgICAgIHwgICA1IC0tDQo+ICBpbmNsdWRlL2xpbnV4L2FyY2hfdG9wb2xvZ3kuaCB8
ICAgMSAtDQo+ICBpbmNsdWRlL2xpbnV4L2NhY2hlaW5mby5oICAgICB8ICAgMyArDQo+ICA3IGZp
bGVzIGNoYW5nZWQsIDE3NSBpbnNlcnRpb25zKCspLCAxMzMgZGVsZXRpb25zKC0pDQo+IA0KPiAt
LQ0KPiAyLjM3LjANCj4gDQoNCg==
