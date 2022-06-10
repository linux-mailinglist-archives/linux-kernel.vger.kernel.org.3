Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42BB95466AB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 14:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241996AbiFJMac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 08:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236902AbiFJMa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 08:30:29 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992ABEF05B;
        Fri, 10 Jun 2022 05:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1654864225; x=1686400225;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=svmW5U0Z9he2HzIeK/J2Y/ziJeZ++fzfGueyuSPD3ko=;
  b=txAwYJYvzV704XGrGiBOzd8ePhksmq8VisxM+g0z+kelmXXCtCeQqUWq
   Z6CAffrmZMb+0SPqwTz/MF5xzpAxzI8phwDupKl5heQUfPB5f9CKsQ6OA
   MGAlF2bMbUAo9g0ucmJzreY59U4LwYLw6JVDjTBSM9MEvXnsR17EUG8ds
   J5oYBdlIfino93gqYKoQ4SjljfBR9FAJijR/DsWFcTk/1wiV3GNXJr1Fu
   6sdPupB9SbgkDWV02R3dgqD3yIS5OG14gOLTCqEJ4HnxWpaNZUdsSMSop
   YvRPkLRM+ASjz8Og+7NNyCtYsNobBCNZI4VQf9JXAcueYXQck+SLaEfcy
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,290,1647327600"; 
   d="scan'208";a="167906512"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Jun 2022 05:30:24 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 10 Jun 2022 05:30:24 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Fri, 10 Jun 2022 05:30:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lT+9pG6bVAULNjkzDPLWTyBE+sRnsycQNbKutJ6uihVS/ti+wtZa6GHsrM+0Sjo7dxl3erur4oyVaRrj7RW7KOi+mX6lCCAYmGoZDBKy9Yhuo9eRJVtyKjxgjbdwKqNxoWZoOzX2InzCL7MQ2DtdEH6QuP8x1CArRjGb4SIq0H6kMqkw7ngfG7fv4f8tb/PpS8nYDo2CmSwgrZsO8BmNfln0ZYPk2hiHGtztRphqaUbdvNuyc7kjZJKUopedNMFTYGZJ2SCpQKMi5WBcH8fD4QHODQZDr/fO11ecdLnNHOGiNK+KCc3wib7ulvE+3+68NbijJpDo4X/NyExnVhakmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=svmW5U0Z9he2HzIeK/J2Y/ziJeZ++fzfGueyuSPD3ko=;
 b=aq/GHPZdSxoK/CZSs/oSfmaiTOtgwu+BxuxOzqLDs/AD6oL/G80KHZrqey3whEZ1iLpuugpXYfrMN80DcJWRpO5TZ1D/4jogpRqImpl66xVSn8aCnM6gqhWS4YAMd2BGNTD+sD1pgBXEG1MBtz9z9iSG33kfBAeO9127K8iUJygloZ0YMjhlPAAqpDVSItX6BflBWdvELX3E/prL+J+h12U/Kv+cqu/MONq1Qt1sgmimY6Oi+0c4Lyb7OByEx7z4Tyd3eqlilzaabCbXMYEWmG+AlGzJzAsIpEl+zhrQ6m4LKEAN7qSbp6mdFYk4U2eKVCzTHfHtDMuvWIYy0gEHRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=svmW5U0Z9he2HzIeK/J2Y/ziJeZ++fzfGueyuSPD3ko=;
 b=aieAZuCvymjIUCahJk8q7CN/SAjFlgcO6QAMou6HzVp0FprOOwkDsa7XDsyMF/zu41SCsA2CzA3uIY9dbLgFudbnvzmpJe5SaIbw00/mGo/irJ/gYUyTLOw2/BfIvCy5sVasRqXD+t2tJvrHUsJrOpXsF3jcZo7s3S5eLMilMVg=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by MW3PR11MB4697.namprd11.prod.outlook.com (2603:10b6:303:2c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Fri, 10 Jun
 2022 12:30:19 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5cfe:8088:aa93:fce8]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5cfe:8088:aa93:fce8%3]) with mapi id 15.20.5332.014; Fri, 10 Jun 2022
 12:30:19 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>, <arnd@arndb.de>,
        <olof@lixom.net>, <arm@kernel.org>, <soc@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <peda@axentia.se>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 44/48] ARM: dts: at91: align gpio-key node names with
 dtschema
Thread-Topic: [PATCH v2 44/48] ARM: dts: at91: align gpio-key node names with
 dtschema
Thread-Index: AQHYfJlzLzmpENQpa0qlfZV/GJNK/A==
Date:   Fri, 10 Jun 2022 12:30:19 +0000
Message-ID: <d482af99-fca1-1e3b-ab51-c7f5864b6428@microchip.com>
References: <20220609113721.379932-1-krzysztof.kozlowski@linaro.org>
 <20220609114047.380793-5-krzysztof.kozlowski@linaro.org>
 <42e8f573-cfc2-dfa4-1740-b0a29521628e@microchip.com>
 <537986d4-376e-d787-1581-cf0b0d525daa@linaro.org>
In-Reply-To: <537986d4-376e-d787-1581-cf0b0d525daa@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 97cbd04f-7f29-400a-df98-08da4adcfafa
x-ms-traffictypediagnostic: MW3PR11MB4697:EE_
x-microsoft-antispam-prvs: <MW3PR11MB46974D7A57694DE0141C5FB487A69@MW3PR11MB4697.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y/0KXdACLqWz55PWhLlSvtqkCResrMYIU/HWOl91rl3GfF8juJjLDbwCIs8iEbTsMsH1B1qhM2emnvRvucsQQADHXX7LNMMdTekkNNttxR/MnYMqBIatmamLUnkEiRPf2pkF7TtoywxDb4lKSJMVCT8gXpN7mRO77EOZiqkgoygR5wlTqF/43QARiEgzkkE1e9MtA1ezum5E9gcjELQB+P6tZhK3Dp750mQmZBZcGg23E8H1qFun13fHHARCq23xIFEaxY4vOKN/NUU4AYXSkobVBqXClqOWJVFqsaF4Bid0nIH0P5jo3Dc1NNmWyTwdRR3Jna9q/crnXBDF5hsAufaLoR5QTe5GaJkiurnT+6+WYXBSRnQov0+oylVMbz2ZvkouBsvnotcgA90PaUttnDRAovlHjDesetOFriI+1QQcUFhSR5jkXaMReO6YQjpJVf8RgQPrw45E8AZ8/kVCSF1EIGbbti1k/zUXQMIRSLJXg0ucKdS4UVcrkjQe7cQIVQDTkp8JOaYxq5E915EuzzVmU4YLCDMeDAcfC6goU7t8LScsX90mrzSCd+0R95S/qPGtnZwLZkWhy+FexaF2Nmh5x0x8xhuH8/SqY0XT/PgTpigZNjOV9CiIuMf6Bca35HWlfp0vU/5/D7u0sWCGssSZrEBDTthhyGiSJVWYhSz24w9VWkzU+ROyMusFzjAO2pXEmNCrESeDwlLo3SlHBEHV/u4j8tpZZEwCXD5x8LfDwnsO/xht0wqUlXpANE6dfOKPUv5YuGmNMLT674/c0aagjMssThWaT6jk5oORYuU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(7416002)(6506007)(26005)(6512007)(31696002)(53546011)(86362001)(5660300002)(508600001)(2906002)(6486002)(2616005)(186003)(71200400001)(66476007)(66946007)(38100700002)(76116006)(38070700005)(110136005)(66556008)(36756003)(91956017)(31686004)(316002)(8936002)(921005)(122000001)(8676002)(64756008)(66446008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qk40YW11NXpIT3ZqRDRaQ3c5OWZhUHhjOUxhTnA3YkRKa0QyTHhDR1RsdFlo?=
 =?utf-8?B?bm1oQ1A3b1F1RTRhR256R3ZWS3QrRkZnbGphRnRJY2Y2VFBvVlRieDhneXdS?=
 =?utf-8?B?dFdSdm1Wc3ZjekU0UGV0Y1RQV2pEQWdiN3piWXdGdUZQbmdRODZ0UDFyNEpy?=
 =?utf-8?B?ZUc4Zy9uRFhrT0M2bmp4Z2J6SnFHMFBva1NxbDllRlpnMHNvbTVqdkRpWDV0?=
 =?utf-8?B?QjlnMmJsSWtOVjluSWJCR1BQZmk2NGJCN2VKV0lPTGFqZjA0RDVWcTM0WEtX?=
 =?utf-8?B?bTZsTk5kUzh4U2VLR1I4U3VvTWg1d0RDazdVRUh0UlRxbzNRWjZOSVRWWm1V?=
 =?utf-8?B?MjV2VnFGMzJ5c3NwWDJ2Q055VmdkQXlKNUZLVEcxVmJQUVFoZ1JRc0swY2x2?=
 =?utf-8?B?VWtWYlhJV01hdDkzZWNIaXhFK24ySTRvcnMycjJuQXRKWXc1STEzYTRld2Q3?=
 =?utf-8?B?SklyaWpRL0syTU5oUzA2enNGSEhXRitxZXoxUEZWSlM3OGNxMU43Rld5T3p6?=
 =?utf-8?B?d3A0Vi9NUFZQclM2TDZ6OGFIekhHNGRuT24wT1NnSmxwOVN5VmMwVU1FeWlS?=
 =?utf-8?B?Q3FCVThmTXV1angra1lEUjJTdkk2Zy9KclRjVlRVMUI3K0JRcEdPaUdVRTdG?=
 =?utf-8?B?eFgybDAyRGhwUXc0QjI1SkZOTDdiWEVLYTdaKzdDNHpaeHcxRTIxMkQ0K2l1?=
 =?utf-8?B?SjNJS1NJZnhHY1NRYnFnNThUdFVtN3U4MStxWHpJaDhxa3h1RHgrZkVkbmJw?=
 =?utf-8?B?OTN4bU9LczhKTzdOSmd4S3h5cXBkUTNYWm14ZE15QmIxNytHS3AwUEN0VXgr?=
 =?utf-8?B?YWF2SkVINDZMNXRHOWhoNUJGL1BDN1ZadkN5Myt3bjFBaFF2ZDdodnFQbVBq?=
 =?utf-8?B?a0s5V3RLNVdIWkZuODN4bVhydlhSRkwxM3NhbVJnTStRUXlINUV4cm16OEhi?=
 =?utf-8?B?dks3OUQ4a3M0a21FVUFmeXpKV2FDc1lzeEtaQ3NkVnQzUDBRbkVmZmxKUVRi?=
 =?utf-8?B?TzF4TzFqcU1CQWg0UENUTmJaaGJ4VTJSKzNvNnpLS3JGL29jdUo4VU1UZFVt?=
 =?utf-8?B?dWluMUQwMVQ0QjRYM3hPbE9MWEREbDJEcnQxUlZJaUE0eXJDREJuaEtmWlQ2?=
 =?utf-8?B?Rk5kcUNtVSt6b1lBU1RjYUYybHhmQzJHM2RBTDc0bDVyamQySjFadG14NG9n?=
 =?utf-8?B?dER1SVpBZ0YyaTNodzZoZXFnKzhqamd2c0Q4akVjeDQ4M1JhUnVjcHZYS0J0?=
 =?utf-8?B?NlBLMmlFcktQNWtLNVA0blBRUmprc0ZvdW1qOW4ydVdMa25UV3dRTjQybTRs?=
 =?utf-8?B?UmtEZllJWERGa0VoYlN4ZzlabnZOTTluYUVLVUtrZ0Z4YUlvbHVPQkRGbjZ2?=
 =?utf-8?B?bjk1R3hIaG02U3RmcGh0UDNYZGExYTlQTlpuWWZhckJrTmdUaUVjU3gwbGlK?=
 =?utf-8?B?L2gySXQrVDVoQnl5cTdMOGlXVFE0akJYRzR5T0hlZ3RBOGNoZSsrMmRSTll1?=
 =?utf-8?B?VzZEbCtFdDFCS1lNNUVwOGwveVNsaUIyTkhZcnhwaGpLc2xiVkdIbURFYVBK?=
 =?utf-8?B?KzJmcFNKT2h2d2NrTXVVa3JvSjdQVFhYR041SjBnS0gwbnZKOGZVWW1LbCt6?=
 =?utf-8?B?Qk1vdzgvdkgyR0ZBZ0w5ZUpiQU9ZVFh0R3RMSzNkajlEV1RTNXNuOEJTT3F2?=
 =?utf-8?B?cUVKSGkra2lqaGcxUEdMMHdTL2dtUW1vQU9kYk5zUEZoVmR0M1VobXV2aXIw?=
 =?utf-8?B?YXhXTFpEUGFZWS9PeVpZZDFvVllheWtzWHZUaUUyL2FiUklISVF1M2ROeFhj?=
 =?utf-8?B?aG83dkkyUmZMUnZCazdlWm04UkYxTHhmc2FQczdGOHhUc25WdnhNaXRCK0VZ?=
 =?utf-8?B?MkZLVXdhR2UyeHZyY051dE5rUDF0R3ovRWsrL0J3bjJHQlUyVXljYUJXeklB?=
 =?utf-8?B?V0JWU09hazNVUmxCVy9wTTQzL3hOV2VLMWJTd2lEVzBYeEplTW52anlWajR4?=
 =?utf-8?B?V0VCSndHQ3hnL0E0TE9LbmxObG1wWFhKTnVXa2M2RGdSL2dqU0pSRlNDbUZ6?=
 =?utf-8?B?a0hjN2YrTkE2UzhWdFdwRGxkTlVLeWo3NDJTejI1VTd1Z1Y2TDhNS1NqSnl4?=
 =?utf-8?B?MzJOWlArS1pmeFh2QmVGODl6K3YwTnVLZDhHNWJZLzZwOXlYWWhSWGUzUUpY?=
 =?utf-8?B?dWkzb29CNFR0Yk9PYis3bFJoTlJmeHpmTTREbDdwRG5OOWc1R2JHam5rVGxr?=
 =?utf-8?B?Sm1waFI1RllBWloxQ1NmQzBzbGFObHhTamZjUHoyYmt0d0x4VURKR29rdVQv?=
 =?utf-8?B?T2I1Mm05VS91NmRTNFZPMVR1WVJ0MzNmNkhIYTVMMWRlOW44QUFlRE9TWWJ2?=
 =?utf-8?Q?VjxQ7zErSvBVC0eQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <48BDD764058EB9458810DDEE090A846D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97cbd04f-7f29-400a-df98-08da4adcfafa
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2022 12:30:19.0196
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /0x7cZKFqdDz4KXEotMFqn5bQx/9R657GwrbALGW+FQho7DPYKPzSytakqApWFq7KBXhkBxAqn/TFHWiIWsLH53dgifC/wZ46xNpNjjbaqU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4697
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAuMDYuMjAyMiAxMzowNSwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiAxMC8wNi8yMDIyIDA5OjEyLCBD
bGF1ZGl1LkJlem5lYUBtaWNyb2NoaXAuY29tIHdyb3RlOg0KPiANCj4+PiAgICAgICAgICAgICAg
ICAgY29tcGF0aWJsZSA9ICJncGlvLWtleXMiOw0KPj4+ICAgICAgICAgICAgICAgICBwaW5jdHJs
LW5hbWVzID0gImRlZmF1bHQiOw0KPj4+ICAgICAgICAgICAgICAgICBwaW5jdHJsLTAgPSA8JnBp
bmN0cmxfa2V5X2dwaW9fZGVmYXVsdD47DQo+Pj4gICAgICAgICAgICAgICAgIHN0YXR1cyA9ICJv
a2F5IjsNCj4+Pg0KPj4+IC0gICAgICAgICAgICAgICBzdzEgew0KPj4+ICsgICAgICAgICAgICAg
ICBzd2l0Y2gtMSB7DQo+Pg0KPj4gVGhpcyBpcyBhY3V0YWxseSBhIGJ1dHRvbiBsYWJlbGVkIG9u
IGJvYXJkIGFzIFNXMS4gSXQgaGFzIGJlZW4gd3JvbmdseQ0KPj4gY2FycmllZCBvdmVyIGZyb20g
b2xkZXIgRFRTZXMuIE1heWJlIGl0IHdvdWxkIHdvcnRoIHRvIGhhdmUgaXQgbm93IGhlcmUgYXMN
Cj4+IGJ1dHRvbiBpbnN0ZWFkIG9mIHN3aXRjaC4NCj4gDQo+IFN1cmUsIEknbGwgbmFtZSBpdCAi
YnV0dG9uLTEiLiBDb3VsZCBiZSBhbHNvICJidXR0b24tc3cxIiBpZiBvdSBwcmVmZXIuDQoNCmJ1
dHRvbi0xIHNob3VsZCBiZSBlbm91Z2guDQoNCj4gDQo+Pg0KPj4+ICAgICAgICAgICAgICAgICAg
ICAgICAgIGxhYmVsID0gIlNXMSI7DQo+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgZ3Bpb3Mg
PSA8JnBpb0QgMTggR1BJT19BQ1RJVkVfTE9XPjsNCj4+PiAgICAgICAgICAgICAgICAgICAgICAg
ICBsaW51eCxjb2RlPTxLRVlfUFJPRzE+Ow0KPj4+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290
L2R0cy9hdDkxLXNhbWE1ZDI3X3NvbTFfZWsuZHRzIGIvYXJjaC9hcm0vYm9vdC9kdHMvYXQ5MS1z
YW1hNWQyN19zb20xX2VrLmR0cw0KPj4+IGluZGV4IDA4ZjBkNGI5OTVmZi4uOTZjOTI5MDAwN2E4
IDEwMDY0NA0KPj4+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL2F0OTEtc2FtYTVkMjdfc29tMV9l
ay5kdHMNCj4+PiArKysgYi9hcmNoL2FybS9ib290L2R0cy9hdDkxLXNhbWE1ZDI3X3NvbTFfZWsu
ZHRzDQo+Pj4gQEAgLTQ3OCwxMyArNDc4LDEzIEBAIGNhbjE6IGNhbkBmYzA1MDAwMCB7DQo+Pj4g
ICAgICAgICAgICAgICAgIH07DQo+Pj4gICAgICAgICB9Ow0KPj4+DQo+Pj4gLSAgICAgICBncGlv
X2tleXMgew0KPj4+ICsgICAgICAgZ3Bpby1rZXlzIHsNCj4+PiAgICAgICAgICAgICAgICAgY29t
cGF0aWJsZSA9ICJncGlvLWtleXMiOw0KPj4+DQo+Pj4gICAgICAgICAgICAgICAgIHBpbmN0cmwt
bmFtZXMgPSAiZGVmYXVsdCI7DQo+Pj4gICAgICAgICAgICAgICAgIHBpbmN0cmwtMCA9IDwmcGlu
Y3RybF9rZXlfZ3Bpb19kZWZhdWx0PjsNCj4+Pg0KPj4+IC0gICAgICAgICAgICAgICBwYjQgew0K
Pj4+ICsgICAgICAgICAgICAgICBidXR0b24gew0KPj4+ICAgICAgICAgICAgICAgICAgICAgICAg
IGxhYmVsID0gIlVTRVIiOw0KPj4+ICAgICAgICAgICAgICAgICAgICAgICAgIGdwaW9zID0gPCZw
aW9BIFBJTl9QQTI5IEdQSU9fQUNUSVZFX0xPVz47DQo+Pj4gICAgICAgICAgICAgICAgICAgICAg
ICAgbGludXgsY29kZSA9IDxLRVlfUFJPRzE+Ow0KPj4+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9i
b290L2R0cy9hdDkxLXNhbWE1ZDI3X3dsc29tMV9lay5kdHMgYi9hcmNoL2FybS9ib290L2R0cy9h
dDkxLXNhbWE1ZDI3X3dsc29tMV9lay5kdHMNCj4+PiBpbmRleCA1ZTg3NTVmMjI3ODQuLmQ1NjUy
Yzk3NDc0OCAxMDA2NDQNCj4+PiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9hdDkxLXNhbWE1ZDI3
X3dsc29tMV9lay5kdHMNCj4+PiArKysgYi9hcmNoL2FybS9ib290L2R0cy9hdDkxLXNhbWE1ZDI3
X3dsc29tMV9lay5kdHMNCj4+PiBAQCAtMjYsMTQgKzI2LDE0IEBAIGNob3NlbiB7DQo+Pj4gICAg
ICAgICAgICAgICAgIHN0ZG91dC1wYXRoID0gInNlcmlhbDA6MTE1MjAwbjgiOw0KPj4+ICAgICAg
ICAgfTsNCj4+Pg0KPj4+IC0gICAgICAgZ3Bpb19rZXlzIHsNCj4+PiArICAgICAgIGdwaW8ta2V5
cyB7DQo+Pj4gICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAiZ3Bpby1rZXlzIjsNCj4+Pg0K
Pj4+ICAgICAgICAgICAgICAgICBwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0KPj4+ICAgICAg
ICAgICAgICAgICBwaW5jdHJsLTAgPSA8JnBpbmN0cmxfa2V5X2dwaW9fZGVmYXVsdD47DQo+Pj4g
ICAgICAgICAgICAgICAgIHN0YXR1cyA9ICJva2F5IjsNCj4+Pg0KPj4+IC0gICAgICAgICAgICAg
ICBzdzQgew0KPj4+ICsgICAgICAgICAgICAgICBzd2l0Y2gtNCB7DQo+Pg0KPj4gU2FtZSBoZXJl
LCB0aGlzIGlzIGEgYnV0dG9uIG5vdCBhIHN3aXRjaC4NCj4gDQo+IFN1cmUsIHRoZW4gYnV0dG9u
LTEgb3IgYnV0dG9uLXN3NA0KDQpJIHdvdWxkIHNheSBidXR0b24tMS4NCg0KVGhhbmsgeW91LA0K
Q2xhdWRpdSBCZXpuZWENCg0KPiANCj4+DQo+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgbGFi
ZWwgPSAiVVNFUiBCVVRUT04iOw0KPj4+ICAgICAgICAgICAgICAgICAgICAgICAgIGdwaW9zID0g
PCZwaW9BIFBJTl9QQjIgR1BJT19BQ1RJVkVfTE9XPjsNCj4+PiAgICAgICAgICAgICAgICAgICAg
ICAgICBsaW51eCxjb2RlID0gPEtFWV9QUk9HMT47DQo+Pj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJt
L2Jvb3QvZHRzL2F0OTEtc2FtYTVkMl9pY3AuZHRzIGIvYXJjaC9hcm0vYm9vdC9kdHMvYXQ5MS1z
YW1hNWQyX2ljcC5kdHMNCj4+PiBpbmRleCA4MDZlYjFkOTExZDcuLmQ3YjU5ZTE2YTA4MSAxMDA2
NDQNCj4+PiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9hdDkxLXNhbWE1ZDJfaWNwLmR0cw0KPj4+
ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2F0OTEtc2FtYTVkMl9pY3AuZHRzDQo+Pj4gQEAgLTQy
LDE0ICs0MiwxNCBAQCBtYWluX3h0YWwgew0KPj4+ICAgICAgICAgICAgICAgICB9Ow0KPj4+ICAg
ICAgICAgfTsNCj4+Pg0KPj4+IC0gICAgICAgZ3Bpb19rZXlzIHsNCj4+PiArICAgICAgIGdwaW8t
a2V5cyB7DQo+Pj4gICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAiZ3Bpby1rZXlzIjsNCj4+
Pg0KPj4+ICAgICAgICAgICAgICAgICBwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0KPj4+ICAg
ICAgICAgICAgICAgICBwaW5jdHJsLTAgPSA8JnBpbmN0cmxfa2V5X2dwaW9fZGVmYXVsdD47DQo+
Pj4gICAgICAgICAgICAgICAgIHN0YXR1cyA9ICJva2F5IjsNCj4+Pg0KPj4+IC0gICAgICAgICAg
ICAgICBzdzQgew0KPj4+ICsgICAgICAgICAgICAgICBzd2l0Y2gtNCB7DQo+Pg0KPj4gU2FtZSBo
ZXJlLCBidXR0b24gbm90IHN3aXRjaC4NCj4+DQo+PiBPdGhlciB0aGFuIHRoaXMsIGxvb2tzIGdv
b2QgdG8gbWUuDQo+IA0KPiBUaGFua3MgZm9yIGNoZWNraW5nDQo+IA0KPiANCj4gQmVzdCByZWdh
cmRzLA0KPiBLcnp5c3p0b2YNCg0K
