Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10FC593970
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 21:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245328AbiHOTBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 15:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245168AbiHOS4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 14:56:55 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD0532ED0;
        Mon, 15 Aug 2022 11:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660588318; x=1692124318;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=UOsUPgq6jwmABGI0M2DK33vX1rQk1JYKUCu9+BMK43M=;
  b=RXC3u7GP8u/4JAxFBMZG6FJO4uaxJMBrYweX3DtG6EDf3f0Ii97bHKFW
   mBV1VAC+a9dvdFjA4c/Du1dDbBy5dU7SjW9J6JzPJuKGhAl2CgZbgjIJ5
   i6IZ/3E4K9AueEunFRPdTdD9YlNk04WoW5yjStjSZmY1s2hJuVscG38Y0
   z0gkGP7AzDOBdPbnaDte4tH9xH5gjQFcXbK/5UBDQrIDwTpyX+dfa7p9j
   fWybTirhSu3ZXKimUQ7jtkGPq6p1Yr9Ca00TqlpFUegWY5EEJHJt9IsNi
   HV8P8WXy6VSifwYJhLzDSoNM7w4KH3d7vL59RUUAd7tDZdmPnG5/lnI2H
   w==;
X-IronPort-AV: E=Sophos;i="5.93,238,1654585200"; 
   d="scan'208";a="176460071"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Aug 2022 11:31:56 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 15 Aug 2022 11:31:54 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Mon, 15 Aug 2022 11:31:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B7cWJjM5ipFqmYVK0H3jibj5+in2ACKWoRfvKUi3dhSbKzdOZcFnw/Pt+TJI9cu5pSRLE+jBV/T9lbEBofpq7Pro/IMWciaxgbJHlBonCfoHpBujFl2n5m6bpg3kiDOsubfszlEsUzVptotZhmTEwSkRJuQiGZOySXRyxag9s4qaLH++KqmGhMzv9pCs28e9TJTOJzElhaneZWISrIbZIYnaPHAAATvJ0w1jO9DJUt9TzD8+KDJWejK2EkWU5+KKvLWB1pgSITwFjIRwHmQ/OSfy8famXUfpVxv4jR0u9qv2Y/Gs36xmNSw+sc5ucBR/JDUbjwPnoAkkK5TYJuvsFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UOsUPgq6jwmABGI0M2DK33vX1rQk1JYKUCu9+BMK43M=;
 b=izKvjyjlnBXKU6BmaQi2sBPoyGqJUecaDnxmRY5OZPC4zuS+TkC1t5mP0m7Hd5OgPoTNcK9AddpnBTdJK6kTHeTd+xqIlS9lFPnSAschPP5xTZHLouD3eafgpTtbGkdT6ar7U3Gwa3R934Xe2mryFhpPVf/+scCVyZyPzk0haez5PrxEX84+k9LWmW5TIVX4uomTg1XePGOfVfeIAGt8liirNreK9124J6YMzs8Wobxyof1oy8c9xVrcYeUrUVODVkmDGDjZEfLHAvW8atQpwDaZSx2odeygzTHGcOB+7nRoD1ylAQl0wv6CPn//n5E/YblzuNi3OMbCD9iJ45kP9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UOsUPgq6jwmABGI0M2DK33vX1rQk1JYKUCu9+BMK43M=;
 b=ltC57SWOJjRSSec48InY9YxzT8WAlyQJPVuTuRDI3A4aiDj8CuKwDGjV0d1A9YNDg3MQgzywUKNXDcoqVONfW2VwJSVs5kVczNQI8nFh9pk4RxfwD610kVJ6A3goZme9lkWvlQASFKQ5JJ0KF4MpdI6KmqHZzRr9F34tQ1rJfyo=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by MW4PR11MB5912.namprd11.prod.outlook.com (2603:10b6:303:18a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.20; Mon, 15 Aug
 2022 18:31:53 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%8]) with mapi id 15.20.5525.011; Mon, 15 Aug 2022
 18:31:52 +0000
From:   <Conor.Dooley@microchip.com>
To:     <ulf.hansson@linaro.org>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <yamada.masahiro@socionext.com>, <piotrs@cadence.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <Conor.Dooley@microchip.com>
Subject: Re: [PATCH] dt-bindings: mmc: cdns: remove Piotr Sroka as a
 maintainer
Thread-Topic: [PATCH] dt-bindings: mmc: cdns: remove Piotr Sroka as a
 maintainer
Thread-Index: AQHYrcLB0F+Md/FvaUahwSAOWxWQTq2wThoAgAAA9AA=
Date:   Mon, 15 Aug 2022 18:31:52 +0000
Message-ID: <53978e97-9b81-1042-9514-075947077525@microchip.com>
References: <20220811204024.182453-1-mail@conchuod.ie>
 <CAPDyKFrefLiR=QtuRuCdXgo1Y=vuwF6ok=kVK0hYgzVtaGHrSQ@mail.gmail.com>
In-Reply-To: <CAPDyKFrefLiR=QtuRuCdXgo1Y=vuwF6ok=kVK0hYgzVtaGHrSQ@mail.gmail.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d283bef8-3c57-4929-5f5f-08da7eec6cb0
x-ms-traffictypediagnostic: MW4PR11MB5912:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IXN/MJ/RY+wr1/LBdP/mKjw1Abnj3hRk2QidVmMzdl1jNUhc4XteexsJ+imhChdry2Vl5ctTlL1ujkN5OIeIMc4nlR+vnRoQo6KmsluAjl3AcBvMb9AYwUEGjuKqCgCh7gDNMt77B5C3AjfQcJGJMfugb+taoU4yY4fzArQASjstOR8A9ATNy1KBUx10UEx9iSbJ2kgdYFubwqleKclj/IKSgbdQhUeKT/YpIalkGJUJQ4UpmU2oFCTASemSsWHQLXERT/gzRbpZX9DHbchnTxatpExWcWMxjeaPkU0BXarfmWQ8KF5Ue29yqW1eOjTgC+Ec4vtjiesdlZbEcbj5loMGVoBTG4FHbFlN2cbZLCt/j3IiO3K9oAR3zYj0SWwYPRe5xYngdh8676G/mOOoJBmau2oSmUjz2bSok0TnFpTLXg3mo2UAe348Au27QPUgm5x2mjXtHhjGmvWg1U8oVpMen9ui21bRSZbrXR8pRS3NsmK/rPzoOUUeTmAnyP0EQa4V+01m/xI9MyUNNnPLnzO3CdLKeRFIJg4YobVY8ZCvOD/szkpucH/QS9nilEsWI/nBL2efFHIY555XTBClEUxkhpx/CDh9z2w3PrNE8zm6WzNJA/LIfPoprF8fCiODy720hZ+Svlvs8QNvoOuHOqDsQQF5JHtEEZo4R7cZlqzYxjEkstRNLvCVynTIPD4QZyi8Q3lGyrulpTg7GR1IVFlaQ0AKA9+pe9/2VeU7EpQ5eOxpXqAfrlF8lMNVv+7j0ZN2QAahhZPbGdgC13PYamOj813PxiQVqZ1FPtyo/Kc0zgDW2akgr0s4/bNmkbQfQkvO3FPfCmHFLCUBWllszK0WHpJWrU1PPgyYG4cc7doVAfhiuB01dmHw7zx88VJ5U5HtOyP+MlIonXlTBQM3hw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(346002)(376002)(366004)(39860400002)(86362001)(6506007)(71200400001)(122000001)(66446008)(66946007)(64756008)(31696002)(66556008)(5660300002)(76116006)(478600001)(54906003)(8936002)(8676002)(6486002)(66476007)(38100700002)(6916009)(4326008)(26005)(186003)(107886003)(83380400001)(36756003)(2616005)(91956017)(38070700005)(31686004)(41300700001)(53546011)(6512007)(966005)(2906002)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dWlRbTNwQWlDR0x4K1VOOFVNVFcwc2w4N1pPNnhYcnNxMHRwVTdxdHpCSHVR?=
 =?utf-8?B?WmI5OEtCcFh6c0pSNmZ6M212RHUwSDA1bjNMamhxSjBhbXF0ZjdWYmNCOElG?=
 =?utf-8?B?RzVXLzlpc1c0R0hFRTBSb2pHelNVZlk4THZjQVVrS2wxVGVEdU4xMUFhUTBM?=
 =?utf-8?B?VmREOVdycEEzRC92enVGZVlSYlpGK0NTVkxoWlNhbnkvaW5aSVZZeVlHZ2V1?=
 =?utf-8?B?SXpWVXRSZENPTGFFeDlPVERDRlhocmc3ZDF4MlJrSVl5bG1tL3lUSVlVU2pV?=
 =?utf-8?B?TFJhem9rSGhyMk52cU5pdG9oMjBBYVRhcnVnOUp5TXZvWHhod3Y3MC9JZnp3?=
 =?utf-8?B?ODVuTENiTm4zRjQzUTh6Q2liREJmMHlKcW1HaTkwa2dmL3AwelNsRXdOMzNZ?=
 =?utf-8?B?OGo2anAwcEJQVkVJQ3M1RmJQY1EyV3VSV3NvVUEzWjBPbGhONkszaUMzcDBJ?=
 =?utf-8?B?SVU1R05Jck9nQzJ3VkZrV3FQUjY4dUhGcUJHaUQwaHBJZ1loVFcwV1FQTmZ3?=
 =?utf-8?B?eEVneEc0aGZDMS9RSlFKc1Nvd2pDUUVqK21iT0M3WlJERjJ1b25Vcm9lZytY?=
 =?utf-8?B?YUx6UVR5bjMvcmNZaUlvSlVRR1NyY3JBZ2RpUHBFbmxoaHRaeEV0Ynd4eVNj?=
 =?utf-8?B?bnJ5MjhlbFJNSW1BZlRkZTNOdmdQMFpLbjVDZ1pNRHcxV1AzdDlCd1lZUFRl?=
 =?utf-8?B?Rm0xeC90b090am5kOEtTa1d3c1BZUG5HMDNYend5V1UwWC9pbEJ5d1pvZVlE?=
 =?utf-8?B?R005QjAyZVo5OVBNR1ZuZzJWd0tjWmZuTDYyT2xNUElPS1lqb0VobGZQSW5n?=
 =?utf-8?B?TGtlZHpaMjRpQTQ2ZGhmS2QyZ0NaVnJ1bWJQeFZsM01QZWRNQVRpZitHck5v?=
 =?utf-8?B?M2dZUE9HY3B0amJ4YWUrbGx0cE1td1FLSkhjbGpIQ2xiTEl1bUZMd3RsbUph?=
 =?utf-8?B?eG94RGplVkU4SVNXZ0huekh5Z0hLbmRJNisxdXZoeUltREZHODc4blVIOHhT?=
 =?utf-8?B?bFUvMDllZmQwRjU3WnJ2L1ExdE9OM3pQeTNGVkV1NkRGRXFEV0YzSnlJc2Mw?=
 =?utf-8?B?VGlWaThFYktYYkk3b1pONXFsQjRqdE9ZNWExQUM1c0d5UkNVN3JrcHVqNnlX?=
 =?utf-8?B?YktRcnRkY25FRjQ1NUwvdC9RY2ExcUJqZ1hyZ0trSWVPNDRQVDRqRkJaQ2Vv?=
 =?utf-8?B?bEg2THFnU3BpQVFta1ppak1ialhNK3d0SXZ1ZnNqZG16YS95anNlN096SzJi?=
 =?utf-8?B?ZG92a0ZMT0ozZ0c5UUFWaHhBdmFqRndZZHNRVDhhRU8wSXNycHB4UTJxalJh?=
 =?utf-8?B?OXZGUEFuRmhMN0VzRXpsRUEvMy96L0pYQ0NlblA3Nm9vSXZQRG9OQ3VkZUdS?=
 =?utf-8?B?REhpZzN0WVY0R2E1SmZnTWtWcWxDNjgxM285djcvbG1aWkFXWThGZlFNbCs0?=
 =?utf-8?B?L2pmZGxDL2hxM29hN3J2SzZySGJvV04vUmMzNGpFdmg1d0M1WkFKQTUwYy93?=
 =?utf-8?B?R0tibTlBanV1SEZTQXBkd2ZrK3lDTTVEOGlIK0ZBSDRFZ24zdDg5WFVvUys4?=
 =?utf-8?B?QkVZMHc1SnA1M0JyOHB0ZGlnS3dCVEw4T0FyRHZlTEE0VHpBdDZMVFFXYjd6?=
 =?utf-8?B?c2FDNi9aZ0tTOFU5TUd0dmUrak5iLzZSNTJKOFhlR05uTGlrZDV3a0lyL1hR?=
 =?utf-8?B?bUdXV3V2M0RhMXoxNWM5STI3K21tQjU2QjFsU05uTXNIb2o1YlJlRzNrc2RL?=
 =?utf-8?B?cldLTjE0YTZobDVnRkhYNVo5dkh3ZGdWWnQ1REZiSkZ3YnVUa1NVQ3Axb1Fa?=
 =?utf-8?B?c0dBWW1OVGduOU5aRDRoSDNvd0orRzhZRzl1WUg0OTE2SG1qVmp2VS9RZTFO?=
 =?utf-8?B?SHY1WmJpOEVWdmJkOTB5RVV1QUFXZG5aQ3phYnlXUnJXdjliUE9QMXdjMkFw?=
 =?utf-8?B?UHJObmFLTk9EOEFGT1YvQUJpelZwdHhsbTlKTWY2VnE0TFJUUDhJY1ArSncz?=
 =?utf-8?B?RDJDemxNUFcrMm9HTXFyMFNNMTVyZFU5NENkQUM1ZDJFdDI4TVVvV3dLNkxm?=
 =?utf-8?B?eS9uYXFlODcrejdNalZ2RkZxNHFZaG5WbitlWExWeUZKNnBwMkQzU2dXZEdN?=
 =?utf-8?Q?+IZI00K9XTD4qt3SKpjbwiBVN?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EBDA23897F2F5643BCB5AE5FA57DF9E2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d283bef8-3c57-4929-5f5f-08da7eec6cb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2022 18:31:52.7069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8OUdl3Zqv78vOl1CAsmSiMrWXUztuSeNgzLIBC9nbtYB8JGtg2vfL5xipR3rIOLdupgW7PKDBEbfzc53PGvcgnpXuXfoiAoDs21/Qfjy+SE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5912
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDE1LzA4LzIwMjIgMTk6MjgsIFVsZiBIYW5zc29uIHdyb3RlOg0KPiBPbiBUaHUsIDEx
IEF1ZyAyMDIyIGF0IDIyOjQxLCBDb25vciBEb29sZXkgPG1haWxAY29uY2h1b2QuaWU+IHdyb3Rl
Og0KPj4NCj4+IEZyb206IENvbm9yIERvb2xleSA8Y29ub3IuZG9vbGV5QG1pY3JvY2hpcC5jb20+
DQo+Pg0KPj4gTWFpbHMgdG8gUGlvdHIgYm91bmNlIHdpdGggYSA6NTUwIDUuMS4xIFVzZXIgVW5r
bm93biBhbmQgdGhlIGxhc3QNCj4+IG1lbnRpb24gb2YgaGltIG9uIGxvcmUgaXMgdGhlIG9ycGhh
bmluZyBvZiBDYWRlbmNlIE5GQyBkcml2ZXJzLg0KPj4gUmVtb3ZlIGhpbSBmcm9tIHRoZSBiaW5k
aW5nIHRvby4NCj4+DQo+PiBMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMDA1
MTAxMjI0MzAuMTkxMDUtMS1taXF1ZWwucmF5bmFsQGJvb3RsaW4uY29tLw0KPiANCj4gVGhpcyBs
aW5rIGRvZXNuJ3Qgd29yaywgc28gSSBkZWNpZGVkIHRvIHNpbXBseSBkcm9wIGl0Lg0KDQpXZWly
ZCwgSSBjaGVja2VkIG5vdyBhbmQgaXQgZG9lcyBmb3IgbWUhDQpFaXRoZXIgd2F5LCB0aGFua3Mu
DQoNCj4gDQo+PiBTaWduZWQtb2ZmLWJ5OiBDb25vciBEb29sZXkgPGNvbm9yLmRvb2xleUBtaWNy
b2NoaXAuY29tPg0KPiANCj4gQXBwbGllZCBmb3IgbmV4dCwgdGhhbmtzIQ0KPiANCj4gS2luZCBy
ZWdhcmRzDQo+IFVmZmUNCj4gDQo+IA0KPj4gLS0tDQo+PiAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL21tYy9jZG5zLHNkaGNpLnlhbWwgfCAxIC0NCj4+ICAxIGZpbGUgY2hhbmdl
ZCwgMSBkZWxldGlvbigtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvbW1jL2NkbnMsc2RoY2kueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9tbWMvY2RucyxzZGhjaS55YW1sDQo+PiBpbmRleCA5OWY4OWViMTkzNTYu
LjcxMjRlNzc2MTdjOSAxMDA2NDQNCj4+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9tbWMvY2RucyxzZGhjaS55YW1sDQo+PiArKysgYi9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvbW1jL2NkbnMsc2RoY2kueWFtbA0KPj4gQEAgLTgsNyArOCw2IEBAIHRp
dGxlOiBDYWRlbmNlIFNEL1NESU8vZU1NQyBIb3N0IENvbnRyb2xsZXIgKFNENEhDKQ0KPj4NCj4+
ICBtYWludGFpbmVyczoNCj4+ICAgIC0gTWFzYWhpcm8gWWFtYWRhIDx5YW1hZGEubWFzYWhpcm9A
c29jaW9uZXh0LmNvbT4NCj4+IC0gIC0gUGlvdHIgU3Jva2EgPHBpb3Ryc0BjYWRlbmNlLmNvbT4N
Cj4+DQo+PiAgYWxsT2Y6DQo+PiAgICAtICRyZWY6IG1tYy1jb250cm9sbGVyLnlhbWwNCj4+IC0t
DQo+PiAyLjM3LjENCj4+DQo=
