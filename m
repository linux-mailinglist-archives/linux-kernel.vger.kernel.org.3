Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F71059EC9A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 21:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbiHWTmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 15:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbiHWTmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 15:42:37 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8498F6E2D1;
        Tue, 23 Aug 2022 11:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661280127; x=1692816127;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ZMUscWhUFtY8EiY9yZANEed/8bxwhi10rC/286Rsjic=;
  b=qFrlQC/DJ6JRWLVj0cbg+AJQTtdKV4JoPCjF9SFlqMSA3N5Nn60mbVRt
   kt1Iyel2WCqY44DK9G5XJ5As515ymM8Kh2kDJJYnV1OkhfzeZYmvbSlzs
   f5v5CVJGz5XS9UZPQsXdIt8pX2AzbRfrcNxsE0yYBNlTs14pOLIVS4wD2
   yX4dQOhsVWj4dPEos5jXbqg1hRStGhea2xXRVbp4741ghQ9UndyfUtlCo
   tIEiEwV0pSrj38d/2hi9E/wOC7WGIuMW5zef5Jy3cd/xZ2g55fPnCrWbA
   ArcEKDuVjT7C1EQws5v4n4X5Kzfa+srcpnLVRozUSsK4tjdhxNI8mg9dr
   A==;
X-IronPort-AV: E=Sophos;i="5.93,258,1654585200"; 
   d="scan'208";a="110366210"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Aug 2022 11:42:06 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 23 Aug 2022 11:42:03 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Tue, 23 Aug 2022 11:42:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B1YFJIYVAvwWazZKat/PIeBgvrSvriZl1Hp9dXJHi52NOFpykzpfLqIPfi7LEoGAfk1ZudhqGfKicWyYXEiNpmr8hCwKlLLWvOkYPzCnQsjsfaCptQvFC6CzkfP8MWBVv2PzbhmIHTMEwTvmvm7dWEt2oiJ93SHznENijapsLtJoFHe9zKxtXw+wW3DVzu5FDrjY5WUZpkbZp7JRnVBsm6oHSBp+lyacxPukHrXdtxYUvZUnWM9QW/2LBZz3as48ZpMOfGxcmhjnQXcGji/hwhtT7hzjgb5c10qc+/cGsULU9kD76YtGXbuh/wA/gEeSwPxFSVTmqjn6RHBlpMJgSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZMUscWhUFtY8EiY9yZANEed/8bxwhi10rC/286Rsjic=;
 b=CM+oveSpCi59b58fFyd7kvC0PX9Ep6AYmFTk4Y+vxq2HAjNDFnCU2xOJzH4weOHQAPNwg2YeyLFPYc030WhoUcDADSpl2vd7nx+V8EkZ3jl1EDGJ50MkdIT8YdTHTgkOi4DOlaxy/xUJRvoN4b01h65GDCsECZry1/x94oi5wLlGSX/H6/H87WfXGL4HM6igyFNjymh2cGqsCEPwj+WV7S0QdtfzdI3W/GJ+uoQZpuYGEUHkzuYxU21JRUuitfWPnsIX4zmP6DD3Ec3yVXcdJZYCz8lNRVWHSoQQPB5QIBp/VGZ8r+vSW097IKo1W7sYeud+IPQTCgiRwuXEnCn7Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZMUscWhUFtY8EiY9yZANEed/8bxwhi10rC/286Rsjic=;
 b=FL5/WwXwfNQCvzy3OhTz96KF0+RjsoHRvFdh+qSRX3CMjiD86Zmg52vw1j0cu7U5piSYzSDtUvfFWyqxAp22cOBWTcM5f9yFT6T2pEARYO6EVguoE/6lEPpoePzJtnjDBHQbhqPeyYEOIGfNeqRoaT47Cl7hhzHWpSW+DEndYYA=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by MN2PR11MB4317.namprd11.prod.outlook.com (2603:10b6:208:179::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Tue, 23 Aug
 2022 18:41:58 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%9]) with mapi id 15.20.5546.022; Tue, 23 Aug 2022
 18:41:58 +0000
From:   <Conor.Dooley@microchip.com>
To:     <jassisinghbrar@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <Daire.McNamara@microchip.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH 0/3] MPFS mailbox fixes
Thread-Topic: [PATCH 0/3] MPFS mailbox fixes
Thread-Index: AQHYqMq0ifIJ8TBe/0m/7e784yGH1a287naA
Date:   Tue, 23 Aug 2022 18:41:57 +0000
Message-ID: <814208de-e3e4-852b-766d-14889a6c3c91@microchip.com>
References: <20220805125618.733628-1-conor.dooley@microchip.com>
In-Reply-To: <20220805125618.733628-1-conor.dooley@microchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c22a283a-13af-46e8-0a2f-08da853728ca
x-ms-traffictypediagnostic: MN2PR11MB4317:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CidohxWZHFvA+EU7+vVAzgPqamgf9WjiypdRaxlW24LsTbFbzKON1X1XPWlEh45nVGXMq15RIEgaHSHFtInP8y+NyhlAZO8+prD8fa6vxN9/lypFfHSjJb3cO4+qh/+XcaMFSJdleiA0/tHHt8yZHpnu/4CE/A6sMzAAWnpvIMdjK/JV0yKA7RKwaJrSJHFgBDOqSD38roI79AtjhJQR80849edsNohrLnjkUqehOTgHNWvrW613ZDgQ1iNC0RIkvfkHygaWzBz7thS7BLDwL9AiiLIrua8rm7godF4K7MFQXI3UkYtkQ8oE0GEasSoFNfBeeJzTTfbVs42oqHUVJJrezKjytCIkzgxF1EPGKXj9dfkGrry+RNTWM0fX80eUtpOEdln0sVgRzhp4Kud+YczxtQQN3bSinRifFSYRAuqFnj+GhlLAbzQEIB9a4zXkKXg+jpnCuFRCX8y1AOu0Xk8I5kWNYxzL5l8L74hOzK4EEFfpNq+ye/r+aLDzmI17tUW6pobpc9JWoihQMRZSenhDPEguxSVrIMgIPzbhlea1021/nAq49Di6nhXcMcExh3iKYFtKJt9d2CI/Hi8YWBHoNZnlZtoTx8h1pFjkOfXSCApyx1+wUo8GoltmP0B2GF45gec0AmMy64lTYPB1OIIC7V7d7zrMng5mpWXjlDEaVOBxKeOS9ekvLSryslshwBOPCQP/jJEr1IaHkIfQxsNWZvgKWZXzBwZdsmbXaRwvabC5X+H7heZhFHXsIDl8emmB7FWFeXK8BzrSX2lD6vdIjuTE7A4b4miBM0VR8gv1WmbVJPGKb0MB9NBArNfpAd36WfWHLUb+nAzR3Rbj7A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(376002)(346002)(136003)(366004)(39860400002)(478600001)(31686004)(6512007)(71200400001)(53546011)(41300700001)(6506007)(38070700005)(38100700002)(186003)(110136005)(26005)(2616005)(6486002)(66556008)(64756008)(66446008)(66476007)(76116006)(66946007)(4326008)(31696002)(8676002)(91956017)(2906002)(54906003)(83380400001)(122000001)(8936002)(316002)(15650500001)(5660300002)(86362001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bHh2YkdITjIybi8wUWF0b2ZRVlRMT3FaV215Y1M3dXVrTEdERUNpOXRvSkJx?=
 =?utf-8?B?THZGRTJJQjM0NnVwMW9Fd3dzM0tuNVdMNC9SdzhUTTlidXFmUDBCaUF0N0g3?=
 =?utf-8?B?R0NBcnNicEhmUHJ1aHVpYVhkQ1ltOHNHejB4Y015aDQ3QUNyK0JteXBqYW9O?=
 =?utf-8?B?QUFWT1BZMmVtdTg3bVlqbXNlWjVJL0prK0pvQ1RQaG9MYWRadzZLSWFhdWNq?=
 =?utf-8?B?Z3U3ckpNL2VSMnpkZFlXSW80M1hPKzRpYTNUVmFpRGtVTnJNTjE2SGpqYU83?=
 =?utf-8?B?WlVFeTRScjg4M2ZXOGM1VlVod0FDdU1VMmRXZTBGWlErWkx2cHRGRlV2Ymtx?=
 =?utf-8?B?ZkVhd3lydGFUQS9vRWhBdE9XS2lWRi9hM1VYVm9DRkR0VTNiQVRtWDRseDh0?=
 =?utf-8?B?KzAySjcxT3I0bjBVT2FlQU5ZV2lLNnk0akJmVEQwTEx4QTYwSmRIVmx0Wk1x?=
 =?utf-8?B?bTA2TnJ1NlFCYTZvTVFVYmFhRWRHSGFhZWtkZ1lzZVd0dkVBTFFSRFJzTWRj?=
 =?utf-8?B?YnB0OTdyYUNSRHlEWUplc2FEZ1ExT1Jqc0s0T0VYbG9UOWNET2pMMTZqYURO?=
 =?utf-8?B?VHU1Tndqb1lINEgxcjhBU2U5UUpkOFlRMVJySEhtZWZzQytyaFZ6QWpPdGxv?=
 =?utf-8?B?Y29NMkZ0L3p6ckNXRDBGcjNjcUtOU2FTK0lqTG52NkpRdDZicndRdlRYVDE2?=
 =?utf-8?B?T1JXSFB3NEFjekpYRjB3dkJUQ2dXd0JBNDJrRS9HQUY1L1pDZG1HNEQyQ3Jr?=
 =?utf-8?B?TlVzOVM0Sm5oeVN4UUNLUWdNREpMaWNuRHUyUVRZVy81RjZ6SjVlMjgyRldu?=
 =?utf-8?B?UlFMZVYzNkdoQ3RzbWlOSTR4ZEtDdzBVWGVPMERXOTkvcVNnYk81R2ZWMDZs?=
 =?utf-8?B?MWs1OGxmOHNwT1FldUpneEIzSTc4NGlOaU1QVmErcXFBVzBiYndIbVlYdnha?=
 =?utf-8?B?Q1lkL3MxR29rTUpRRHBKYlRpTkhMaVRTdFJxa0tGcGNuZkRhK2tXYWk5T0Q2?=
 =?utf-8?B?Nit2WEQyaU03MkVQQ2tTa1JOTnlvc0tDVkgrSWJTY0FDOXFOL1YrWDhBRThv?=
 =?utf-8?B?NnI4WkRoTlY4S0pobU1sbE1MR3QzQTNmaE00eXVYaFdBRy91YjIyNVZNSFYy?=
 =?utf-8?B?M3NoZkx0b0tWRG80RkRwbGtuU042ekRRRXIveGkvaUdkTnpQZjVPN0lEUFpo?=
 =?utf-8?B?UU55NGtZcEN1Y3JOcXd5ZDdCNlkrbGFFMHhqNlBZb2FUUVY4UFlYamhYbWwv?=
 =?utf-8?B?K3F3dDRsUDQwWDN6SEhyMlFhd1owdXJpaVFQMDA5eWZ6cUhMbkUwSTk5aEk5?=
 =?utf-8?B?a1IrWEE1S3JsQWZMVUxhQ3AxZm1uWUFsQXFIUE5iZkxyRFNsWlpKU0ZGdVZr?=
 =?utf-8?B?L3dYMnJtams4WWtDc2dUQldCTzQ3bHl0R0duQXlTenpKUUU0N0FIODY4WEtT?=
 =?utf-8?B?OU9vVk5EQlh5ZGFTK2ZrTmpPUTJsTFh1UElZVmVzK2haa3U2ZzR0VGlhT282?=
 =?utf-8?B?b2x5RGE2TEo3YnlkQWljd1BESGRKRU1ZQjZmZlZ4VTFFV1lJZXB5VldTVGQ0?=
 =?utf-8?B?UThmbnBVN3Aycjd2OE1TWDhJVWlBRHFhb2hlZ21jbWplaStoK1RJNkNCcmNJ?=
 =?utf-8?B?SHhzS3dkNTVKekdNM0U1SFowc3RHc3lBamc1UlNadXljV3J4YUZvY0xEQmJX?=
 =?utf-8?B?SEtmZHNCaXVsTmNrL1gwaTA4akkrazdwN2ZSRi81TFMwVUxDQWpJeitnMnRm?=
 =?utf-8?B?dXNRZjBrZlNlSjR5UDBGR2U5Y1ZONzFRVWlaekp4OVNOVXVjUkZWajhUZmJD?=
 =?utf-8?B?YzBCVDBCTmhSSmEzVkNYM2xkTmNrdlNDQXhjVmdvOWhWWGdBZ0RmZWNVT0U3?=
 =?utf-8?B?MllPaU5PRUJodHRaaWRUSmZTSVlaWC9mWnV0Z0ZGejdzZDBSVUM5dlkzcWtS?=
 =?utf-8?B?WDVLUkR3Q2pRU1d3OUg3NEZNYlF5bzdXRVAvNm45eTNOTTc2c0xpNnVYY0dm?=
 =?utf-8?B?ZXNrcUhqckZvaWdubFJzNmxRU0MxWXBuT1QrK2dWRTlLQ0dtQndVOTZneEtJ?=
 =?utf-8?B?eTlQVyswL3FpU1dOT3VqcEEyR21OdG5kcDNvZldiaHc2YkpmSUFCM3JCMW5x?=
 =?utf-8?B?Y2ZRK2hXOVNlbGRaaE1vSWxTekt5cHlnbzFsOEw3Rk5IeFZCTlA1TjhyS0pq?=
 =?utf-8?B?K0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8F0943BE356895478B147A18CF0A5F15@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c22a283a-13af-46e8-0a2f-08da853728ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2022 18:41:57.9902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P8uNwgGXFMw8K/aF4nFoY/q6yCNxcW5QiaQ+WBPwp4Auz7d9IpcjtYriqfnsYiaoNSgGiH1Rx0l2CbaN0rwBHxDil+8tGqbfcQmySyz/vPA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4317
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDUvMDgvMjAyMiAxMzo1NiwgQ29ub3IgRG9vbGV5IHdyb3RlOg0KPiBIZXkgYWxsLA0KPiAN
Cj4gSSBzcG90dGVkIGEgY291cGxlIG9mIGJ1Z3MgaW4gbXkgbWFpbGJveCBkcml2ZXIgd2hpbGUg
ZGV2ZWxvcGluZyBzb21lDQo+IG5ldyBmZWF0dXJlcy4gTm9uZSBvZiB0aGUgZmVhdHVyZXMgdGhl
c2UgYnVncyByZWxhdGUgdG8gd2VyZSBpbiB1c2Ugc28NCj4gdGhleSd2ZSBnb25lIHVubm90aWNl
ZCB1bnRpbCBub3cuIFRoZSBiaW5kaW5nIHNjcmV3dXAgaXMgdW5mb3J0dW5hdGUNCj4gYW5kIEkg
ZG9uJ3QgcmVhbGx5IGtub3cgaG93IEkgbWlzcmVhZCB0aGUgcmVnaXN0ZXIgbWFwIHNvIGJhZGx5
Lg0KPiANCj4gSmFzc2k6DQo+IE5vdCBzdXJlIGlmIHlvdSBwcmVmZXIgZGV2ZWxvcGVycyB0byBh
ZGQgYSBDQzogc3RhYmxlIG9yIG5vdCB0byBwYXRjaGVzDQo+IHNvIEkgaGF2ZSBsZWZ0IHRoZW0g
b3V0LCBidXQgSSB3b3VsZCBsaWtlIHRvIHNlZSB0aGVtIGJhY2twb3J0ZWQuDQoNCkhleSBKYXNz
aSwNCkhhdmUgeW91IGp1c3Qgbm90IGhhZCBhIGNoYW5jZSB0byBsb29rIGF0IHRoaXMgeWV0LCBv
ciBhcmUgeW91IHdhaXRpbmcNCmZvciBtZSB0byByZXNlbmQgd2l0aCB0aGUgZXh0cmEgZml4ZXMg
dGFnIGFwcGxpZWQ/DQpUaGFua3MsDQpDb25vci4NCg0KPiANCj4gVGhhbmtzLA0KPiBDb25vci4N
Cj4gDQo+IENvbm9yIERvb2xleSAoMyk6DQo+ICAgZHQtYmluZGluZ3M6IG1haWxib3g6IGZpeCB0
aGUgbXBmcycgcmVnIHByb3BlcnR5DQo+ICAgbWFpbGJveDogbXBmczogZml4IGhhbmRsaW5nIG9m
IHRoZSByZWcgcHJvcGVydHkNCj4gICBtYWlsYm94OiBtcGZzOiBhY2NvdW50IGZvciBtYm94IG9m
ZnNldHMgd2hpbGUgc2VuZGluZw0KPiANCj4gIC4uLi9tYWlsYm94L21pY3JvY2hpcCxtcGZzLW1h
aWxib3gueWFtbCAgICAgICB8IDE1ICsrKysrKysrLS0tDQo+ICBkcml2ZXJzL21haWxib3gvbWFp
bGJveC1tcGZzLmMgICAgICAgICAgICAgICAgfCAyNSArKysrKysrKysrKy0tLS0tLS0tDQo+ICAy
IGZpbGVzIGNoYW5nZWQsIDI1IGluc2VydGlvbnMoKyksIDE1IGRlbGV0aW9ucygtKQ0KPiANCg0K
