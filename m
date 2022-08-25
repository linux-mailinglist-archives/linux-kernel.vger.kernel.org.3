Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35D1D5A19FE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 22:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243401AbiHYUEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 16:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbiHYUEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 16:04:06 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779DBA3D0F;
        Thu, 25 Aug 2022 13:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661457842; x=1692993842;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Q4Fy6SFPcosSZLl8fwam7RhGla+1wh+CTL2EGEKMxhc=;
  b=SYb8hVT5YC9s4jLkJ5nq1/hoDR7hivQaqqE3erlxkggTmbyw5mPDGrDv
   9BYtepwcfFdOU4xNqvGSlZFUk3qCdYkcD0yP+SYFFXXahbSS2iTAR1yGe
   0NoDd7GWDfVssoDFBshlD0Z+AvaM4kz0SJk4TKp+yxehm+eBq4WH0kgDQ
   jVnxUv99rmBxEjr78aHvkMYNDbbuY0ZUdDIgTWOuv/6o9dQipAKF5IrGS
   WYv1xB1CeyYAI6Oz9Vr7Y3Y10NQ0p737EJWZkuzg7ND419Vzn4Kt/+EYL
   mQSSJAAVJ9oVmoAVXPMbBu7SrRCWMPbSLj4D60H2SVtOhyzwURrE+pylg
   A==;
X-IronPort-AV: E=Sophos;i="5.93,264,1654585200"; 
   d="scan'208";a="188095417"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Aug 2022 13:03:59 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 25 Aug 2022 13:03:59 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Thu, 25 Aug 2022 13:03:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aj1Npt99xqcsiTv07LoNEbTrmvGpIAdeztfq31sEcb7BU8Um37qdFqelyty5J6bgFLkqFkRNWDxHSS7/HOflqOgyM/4BjGRG2AN7LYXQAz3SHGd+kzUwcID5Rvwhm6ExARX2/IXDI3jJVmUVeHdi6bBjyBiHr5tJ3dCwloihs+l8rb6mzQ9McPqAvh2TNR9KC9wgGGhnyds1kR23qnJqn+oAzEdq+DGA6Q58Gty+0Aba/U4gN/Czsrwuz/XXBsVpLY8wQ9+9SOlk0cRpuYmVbfDqNS0ZZ3QNj+GGleUOC6v6da7LPrghVOIafJo1Rvo9H6UaC8pVmzp1pTDtlGhCSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q4Fy6SFPcosSZLl8fwam7RhGla+1wh+CTL2EGEKMxhc=;
 b=HFAferyaEifXo6pi3f+HkkPmZVMNCBCpCzPvEjkIXB6kE3ihspSuTcD//4gtncW2pKUDXPYkyLeYp89jZ7HB6OyLe91tdN4JnrMPXZO10/d0SuibvlUiTvE3rfJ8Hsh+reVWuTBHzfOckke7rXdd7W5/6nycSyyUjAGQziZp7fCDBLvYNlRtzs/SF0CLjnchtTgk+6YaKkDnh+k/YJe13z9QiRgP6CRQlL4QpQee5eArFF4cUVKDH56nzvfM3QxpvsXe9cusPErHy0bfoxoLn5JgE77WW+QxB5hTxY8FgLzX8HIGJcNiWwSkJIwhgn9KYbIlicAvNeKVFFiTV2D41g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q4Fy6SFPcosSZLl8fwam7RhGla+1wh+CTL2EGEKMxhc=;
 b=N1g/xf+wFGf0xN1n3dQb9SjisQYQUq7dtIQ+s9vt9tqjOyyjcDBcg1Yo3I9/FC+7LJjzYGs7vaGj2TT2/EWD9gBV2vKznB4sGnCeMJdraOZn1+J29GtIxgn2+6hRWkYn6Mq6MPEfBuEManEHyEy9kvDE9bHApFFkOcFwgK2aIJA=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by PH8PR11MB7000.namprd11.prod.outlook.com (2603:10b6:510:220::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Thu, 25 Aug
 2022 20:03:54 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%9]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 20:03:54 +0000
From:   <Conor.Dooley@microchip.com>
To:     <heinrich.schuchardt@canonical.com>, <Conor.Dooley@microchip.com>
CC:     <sagar.kadam@sifive.com>, <atishp@atishpatra.org>,
        <paul.walmsley@sifive.com>, <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <aou@eecs.berkeley.edu>,
        <Daire.McNamara@microchip.com>, <palmer@dabbelt.com>,
        <robh+dt@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: riscv: sifive-l2: add a PolarFire SoC
 compatible
Thread-Topic: [PATCH 1/2] dt-bindings: riscv: sifive-l2: add a PolarFire SoC
 compatible
Thread-Index: AQHYuK1cgpDU3PrXM02UEZyzROk5r62/8euAgAAFkACAAA7cgIAAA+gA
Date:   Thu, 25 Aug 2022 20:03:54 +0000
Message-ID: <38981c6e-40cc-7468-b1ef-f4b3f341f3fd@microchip.com>
References: <20220825180417.1259360-1-mail@conchuod.ie>
 <20220825180417.1259360-2-mail@conchuod.ie>
 <5f00ab85-d5ac-728d-2157-e70f2a46cc90@canonical.com>
 <2d1da51d-d5a0-bb3c-ba63-831f0efc1b3d@microchip.com>
 <7b635894-5a91-9294-75ab-2fad8f657577@canonical.com>
In-Reply-To: <7b635894-5a91-9294-75ab-2fad8f657577@canonical.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 947df884-a287-4757-ee07-08da86d4f013
x-ms-traffictypediagnostic: PH8PR11MB7000:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +kwlDnEFOK2++ZKI1POoenLOpivPN2qxkjFmLLZx9A6EFPX3pOsRL36IrejyOQWLzOHAZZ2C+I0a6Yv5L0TrWh/EfLlBhDY0VfFMjR7hHYGN+aAp4sS+uW7fwzzrM/dPlVqxMVb+ZSUhGG0Gx3T7fbn/pU4ph5NmJ2lm5S9JxAPamOAV7WYOj2Bdn38CE8QbdI3m1387qFz9j951vmE/5aBQPxGwd6Iv5LIPqn07z7seuwuyXdFwQtRs255YpQ0jQv+znCRlL4yg36N7gWL8UuEmaKSfOnAAW4f6f5fyDsluQWQAiVYI3Fj+AUNvXLg9IjcB9+p+kk7+IpPWDW+kvAJJwc0hhy/HOTk7Wgl8pysvc3TtHe/eA/IOrYdr08RzTgGDONDFD47KS2m+cFtUpMPoWFkMftwG9KnCvvFZWgPx5gxs1ChGF/WabBAonxhjKA3mwyieXqO8yT2laTmnXC7Y+y5GMTBNGhUhGWAjFMMW9QrXC0BFUu66jUKPWFhyP4v33H7m7Y3zX16ICgTiKec9gQGtwAa2hODnb3ZRMjbYuVB9Tt6ySui/GFUajYbm9C6brmJa0ratquYLR5LIWzLxwUlZLYiZzJimjhrdhYwpVl1ULIeR2I+OBHeAf9o70bcCD/UVzOZe3zfBz8vXAbwIQ9HHobJ9SdQs74VNz9eQ/aV+MTgSwuS6OhU56yj5msGEAW3S+tqFuiOnlCMmvhpPEINPsd5QKBIYpPget1GqkvBCbw/c+i9cJdXgVgqO4nh7stk0nHDWEtPt9h9bJJ79ukRiFOg4/75nDfl8ij8QuNDmKB+kzSaB7UcKtu0UwD8ODFSv2FboPwghU3tLCg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(376002)(366004)(346002)(136003)(396003)(71200400001)(186003)(316002)(2616005)(26005)(6512007)(36756003)(31686004)(53546011)(83380400001)(6506007)(2906002)(38100700002)(86362001)(110136005)(31696002)(7416002)(8936002)(41300700001)(76116006)(4326008)(8676002)(91956017)(5660300002)(6486002)(478600001)(54906003)(122000001)(38070700005)(64756008)(66476007)(66446008)(66556008)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M0U3VDgzdk1LNlI0aFJIQ0hhMHczSFlzY3paVmhtNURSVm5pU3JZMkdlcHl2?=
 =?utf-8?B?NEl6Y0Q5VnhmTG5hUkVZUHdHMDJaeEt6clNyTjVmL0paMVhKNnZQQU9QK2xT?=
 =?utf-8?B?eXBmTjhxMG5vbTJwSTNrVkIzakkrMllhRVg4b3ZBblVZRmxjem54YlB6Z3Q3?=
 =?utf-8?B?MzFHaXNqQmVUZWNiZXVHVTJiRHBYbFBHaHI4TFZIYWNDcmdHeXpMZWYwSXRB?=
 =?utf-8?B?OTdtV0QvRVhudFBUdGxSbWZwbEVBVFB6TXBBQm1wb0d3UU56TXEvNFQrbzY1?=
 =?utf-8?B?Qzh5SjB0Zm1sL1NEcG0xR2JTcXp0WkJxd09MejAxTTc4RnJ6SVFXK29QZXhY?=
 =?utf-8?B?OUdIV3F1bGZtYWVPT204QXBjL2NkSHl1TGd2M1FhT0dBa3RSRHhZL0NVeUZr?=
 =?utf-8?B?OU00MXhMdlZzSzZESk12bXFkd2FvMmpXYjBOZFpMNEhsZ0R1WTgzT2hKSG43?=
 =?utf-8?B?NVBUcS9ubWlwdEhxRDgzQ1BHSlFEUEN2OXZjTUlwdjM4ZXFmNW5PMUJybEdY?=
 =?utf-8?B?eGtKMkN5NktTOXRYTkl3WWI5cHZEYVBLcDR0QmFScUlYaWMvQ1JvTUVmV2Nx?=
 =?utf-8?B?Wk5PZW1FTDVva0g0Nk5ic3RHdkxheXM2ZXBwVFl0aWdCRCtDRjFDM3VwU2Ry?=
 =?utf-8?B?Zmc4MzJqMjZuZThkYVJ2QnNQQ3J3VGMrNXltU2o5RGlqVVNFbm56TXQ2OCt3?=
 =?utf-8?B?MURQYlNqM3BhSEdDUzQzZHB4TzlHWW1FUkVKS3UzOTJhK2tzZHRacHpvRHVo?=
 =?utf-8?B?UVQ2ejZQK0dkVWZHM0hYb2NJSXU5MGIybjdZbnoxTkNkSjJ4Nm9kOENsRng0?=
 =?utf-8?B?bkNsWU5uelljWEtObVNIdStLeXdkZUJuZ0RXTVJKKzhUUlRjeGtHNUpKSkNv?=
 =?utf-8?B?Vm9UMWpUeUdOYWYvdEFDMU1BYXBDQ0dJMmI0Y3FDKzFERVVtaU5UTnZqVEZt?=
 =?utf-8?B?N0FRNmRmNnZnSHY2UDdHeU5UV2tOYmR3cFpuMVhEK3hEQUw4SmxOVmhSQUE4?=
 =?utf-8?B?dGJNakxOMCtzcTF6NE5YUmpSTVhqZ2kzU1ZpVXJHTlJESDZWRGFBTE96WHdY?=
 =?utf-8?B?aDVUMWNhNzhnV3VPeUhNUEx5NGZha3AyaGRsbVJuQmczWDRqZnprZkw1UnhQ?=
 =?utf-8?B?YjZTWWFJdE5JQjFCRkkwVVJEYlF5RVZtbmcyU3NwRC9VWHNHSnQwVU9tdWd0?=
 =?utf-8?B?blVZc1BNQUVEOEVaUTZ2Tk9VYW5NZGtqYjdlMUpTZDFHM2R0endTT0ltS2Nv?=
 =?utf-8?B?ZjV5Q3N3cXdIam12bGRHZFQzMVFHOWFKb2oydGR2L3RXVVYxNkVYa3p1UUlu?=
 =?utf-8?B?bzZ1UHE1eXNYTk9rVDYwd25JWG1nbEpXcTk4MVluK1l2NmdDQld4bDJrbHJP?=
 =?utf-8?B?eVFBd0MrbEVKNlVyYThIL0FwWFVrcVk2d2Z4TlpLcDNRV3FpQXNGZkFKWHdh?=
 =?utf-8?B?d1hXTUc2VmZCZWEwZVEyM1hpakkvUDhVc1R6TzhCYXNBWWEvK09qU0tML3Ez?=
 =?utf-8?B?dU03NGJNZjlrNjJvK3M0TkEwVTgwMlR4Y1pJY2Z3bDV0TGM4RkFtb3hTV2hZ?=
 =?utf-8?B?aXhyNiswRFl1ZTNGdlQzTHJPbks1cHUwMTNETU1HdFZSd3A4TmFkWFc5dEpI?=
 =?utf-8?B?dDNiMmU5ZlM4RzFzb3pub2t5RmdWSGZrMEZYTFgwNlVPbzhCcTZvSk1BR0g1?=
 =?utf-8?B?bjdPcnJoRmpocFp3dGVIWlJIeEdGOUlZeTl0dWlOb0xTcElKUVN6Sys0d1BG?=
 =?utf-8?B?WFZZQm5IMityTTN3VWpjUktReGRLSWtHZUtEUFVkNmhVRnlGZU5uRDlKNkwy?=
 =?utf-8?B?TjAyWmJRMEl6dEdtNStLaWVUT2hxcU91RnA1Y2p4b2JjRitybkVpMkZkOTZj?=
 =?utf-8?B?NVR5RER6MU9ZTGw4QnNwWFNNUHdBOEF3dEpaYzhzQUJPMGp6eGtKdVZRM29s?=
 =?utf-8?B?UVc4RjYxOFA5VlVONW85Ykx3ODUwYloyWklhKzJIWHFadTZUWjBzUnZyeUtZ?=
 =?utf-8?B?bzVXcSt5NStESVBCM1FtMlRzcWdwREhTeXAwNEF3dXU1a3lYdWhPWUZjQnhB?=
 =?utf-8?B?eTd0NFRFTjdtUHV1WTcxZUFVUTNZNWZaNEJVYS9UQmxJVS92NWhJRFV5QkFp?=
 =?utf-8?Q?u9sSXajPY45uF6xaxIhzoaVnz?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3080349511042449B34D69480EF5DB25@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 947df884-a287-4757-ee07-08da86d4f013
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2022 20:03:54.4904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BMhCDzJkALagqsuZYrgEi3YMIALqqRcFSp9+WfgxDa7V0iHAPWpFdj6sU1QaSmrZRv1R+5Ltar66vNVP5Q8P+9e1sTo1FX/4QKoQJ3j50PA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7000
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjUvMDgvMjAyMiAyMDo0OSwgSGVpbnJpY2ggU2NodWNoYXJkdCB3cm90ZToNCj4gT24gOC8y
NS8yMiAyMDo1NiwgQ29ub3IuRG9vbGV5QG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+PiBPbiAyNS8w
OC8yMDIyIDE5OjM2LCBIZWlucmljaCBTY2h1Y2hhcmR0IHdyb3RlOg0KPj4+IE9uIDgvMjUvMjIg
MjA6MDQsIENvbm9yIERvb2xleSB3cm90ZToNCj4+Pj4gRnJvbTogQ29ub3IgRG9vbGV5IDxjb25v
ci5kb29sZXlAbWljcm9jaGlwLmNvbT4NCg0KPj4+PiArYWxsT2Y6DQo+Pj4+ICvCoCAtICRyZWY6
IC9zY2hlbWFzL2NhY2hlLWNvbnRyb2xsZXIueWFtbCMNCj4+Pj4gwqDCoCAtdGhlbjoNCj4+Pj4g
LcKgIHByb3BlcnRpZXM6DQo+Pj4+IC3CoMKgwqAgaW50ZXJydXB0czoNCj4+Pj4gLcKgwqDCoMKg
wqAgZGVzY3JpcHRpb246IHwNCj4+Pj4gLcKgwqDCoMKgwqDCoMKgIE11c3QgY29udGFpbiBlbnRy
aWVzIGZvciBEaXJFcnJvciwgRGF0YUVycm9yIGFuZCBEYXRhRmFpbCBzaWduYWxzLg0KPj4+PiAt
wqDCoMKgwqDCoCBtYXhJdGVtczogMw0KPj4+PiAtwqDCoMKgIGNhY2hlLXNldHM6DQo+Pj4+IC3C
oMKgwqDCoMKgIGNvbnN0OiAxMDI0DQo+Pj4+IC0NCj4+Pj4gLWVsc2U6DQo+Pj4+IC3CoCBwcm9w
ZXJ0aWVzOg0KPj4+PiAtwqDCoMKgIGludGVycnVwdHM6DQo+Pj4+IC3CoMKgwqDCoMKgIGRlc2Ny
aXB0aW9uOiB8DQo+Pj4+IC3CoMKgwqDCoMKgwqDCoCBNdXN0IGNvbnRhaW4gZW50cmllcyBmb3Ig
RGlyRXJyb3IsIERhdGFFcnJvciwgRGF0YUZhaWwsIERpckZhaWwgc2lnbmFscy4NCj4+Pj4gLcKg
wqDCoMKgwqAgbWluSXRlbXM6IDQNCj4+Pj4gLcKgwqDCoCBjYWNoZS1zZXRzOg0KPj4+PiAtwqDC
oMKgwqDCoCBjb25zdDogMjA0OA0KPj4+PiArwqAgLSBpZjoNCj4+Pj4gK8KgwqDCoMKgwqAgcHJv
cGVydGllczoNCj4+Pj4gK8KgwqDCoMKgwqDCoMKgIGNvbXBhdGlibGU6DQo+Pj4+ICvCoMKgwqDC
oMKgwqDCoMKgwqAgY29udGFpbnM6DQo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVudW06
DQo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAtIHNpZml2ZSxmdTc0MC1jMDAwLWNj
YWNoZQ0KPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLSBtaWNyb2NoaXAsbXBmcy1j
Y2FjaGUNCj4+Pj4gKw0KPj4+PiArwqDCoMKgIHRoZW46DQo+Pj4+ICvCoMKgwqDCoMKgIHByb3Bl
cnRpZXM6DQo+Pj4+ICvCoMKgwqDCoMKgwqDCoCBpbnRlcnJ1cHRzOg0KPj4+PiArwqDCoMKgwqDC
oMKgwqDCoMKgIGRlc2NyaXB0aW9uOiB8DQo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIE11
c3QgY29udGFpbiBlbnRyaWVzIGZvciBEaXJFcnJvciwgRGF0YUVycm9yLCBEYXRhRmFpbCwgRGly
RmFpbCBzaWduYWxzLg0KPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgIG1pbkl0ZW1zOiA0DQo+IA0K
PiBBYm92ZSB5b3UgaW5kaWNhdGVkIHRoYXQgeW91IHdhbnQgc3RyaWN0IGxpbWl0cyBmb3IgdGhl
IGludGVycnVwdCBjb3VudC4NCj4gWW91IGV4cGVjdCBleGFjdGx5IDQgaXRlbXMgaGVyZS4gSGF2
aW5nIDUgZW50cmllcyB3b3VsZCBub3QgYmUgY29ycmVjdC4NCj4gUGxlYXNlLCBhZGQgJ21heEl0
ZW1zOiA0Jy4NCg0KT3V0c2lkZSBvZiB0aGlzIGRpZmYsIGJlY2F1c2Ugb2YgaG93IHRoZSBwYXJ0
aWN1bGFyIGJpbmRpbmcgd2FzDQpzdHJ1Y3R1cmVkLCB0aGVyZSBpczoNCiAgaW50ZXJydXB0czoN
CiAgICBtaW5JdGVtczogMw0KICAgIGl0ZW1zOg0KICAgICAgLSBkZXNjcmlwdGlvbjogRGlyRXJy
b3IgaW50ZXJydXB0DQogICAgICAtIGRlc2NyaXB0aW9uOiBEYXRhRXJyb3IgaW50ZXJydXB0DQog
ICAgICAtIGRlc2NyaXB0aW9uOiBEYXRhRmFpbCBpbnRlcnJ1cHQNCiAgICAgIC0gZGVzY3JpcHRp
b246IERpckZhaWwgaW50ZXJydXB0DQoNCkFGQUlVLCAibWF4SXRlbXM6IDQiIGlzIHJlZHVuZGFu
dCBiZWNhdXNlIGFsbCBwb3NzaWJsZSBpdGVtcyBhcmUgbGlzdGVkLg0KDQo+IA0KPj4+PiArDQo+
Pj4+ICvCoMKgwqAgZWxzZToNCj4+Pj4gK8KgwqDCoMKgwqAgcHJvcGVydGllczoNCj4+Pj4gK8Kg
wqDCoMKgwqDCoMKgIGludGVycnVwdHM6DQo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqAgZGVzY3Jp
cHRpb246IHwNCj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgTXVzdCBjb250YWluIGVudHJp
ZXMgZm9yIERpckVycm9yLCBEYXRhRXJyb3IgYW5kIERhdGFGYWlsIHNpZ25hbHMuDQo+Pj4+ICvC
oMKgwqDCoMKgwqDCoMKgwqAgbWF4SXRlbXM6IDMNCj4gDQo+IFRoZSBpdGVtIGNvdW50IHNob3Vs
ZCBiZSBleGFjdGx5IDMuIEhhdmluZyAyIGVudHJpZXMgd291bGQgbm90IGJlIGNvcnJlY3QuDQo+
IFBsZWFzZSwgYWRkICdtaW5JdGVtczogMycuDQoNCkFnYWluLCB0aGlzIGlzIHNldCBieSB0aGUg
c2VjdGlvbiBJIHBhc3RlZCBhYm92ZSAtIGFsdGhvdWdoIHRoaXMgdGltZQ0KZXhwbGljaXRseS4N
Cg0KSG9wZSB0aGF0IGV4cGxhaW5zIHRoaW5ncywgbm90IHRoZSBlYXNpZXN0IGJpbmRpbmcgdG8g
dW5kZXJzdGFuZCBmcm9tDQphIGRpZmYgYWxvbmUuIFBvc3NpYmx5IEkgc2hvdWxkIGhhdmUgcGFz
c2VkIGEgIi1VIiBhcmd1bWVudCB3aGlsZQ0KY3JlYXRpbmcgdGhlIHBhdGNoZXMgdG8gZ2V0IGFu
IGVhc2llci10by1mb2xsb3cgZGlmZi4NCg0KVGhhbmtzIGZvciB5b3VyIChwcm9tcHQpIHJldmll
d3MsDQpDb25vci4NCg0KPj4+PiArDQo+Pj4+ICvCoCAtIGlmOg0KPj4+PiArwqDCoMKgwqDCoCBw
cm9wZXJ0aWVzOg0KPj4+PiArwqDCoMKgwqDCoMKgwqAgY29tcGF0aWJsZToNCj4+Pj4gK8KgwqDC
oMKgwqDCoMKgwqDCoCBjb250YWluczoNCj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29u
c3Q6IHNpZml2ZSxmdTc0MC1jMDAwLWNjYWNoZQ0KPj4+PiArDQo+Pj4+ICvCoMKgwqAgdGhlbjoN
Cj4+Pj4gK8KgwqDCoMKgwqAgcHJvcGVydGllczoNCj4+Pj4gK8KgwqDCoMKgwqDCoMKgIGNhY2hl
LXNldHM6DQo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqAgY29uc3Q6IDIwNDgNCj4+Pj4gKw0KPj4+
PiArwqDCoMKgIGVsc2U6DQo+Pj4+ICvCoMKgwqDCoMKgIHByb3BlcnRpZXM6DQo+Pj4+ICvCoMKg
wqDCoMKgwqDCoCBjYWNoZS1zZXRzOg0KPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgIGNvbnN0OiAx
MDI0DQo+Pj4+IMKgwqAgwqAgYWRkaXRpb25hbFByb3BlcnRpZXM6IGZhbHNlDQo+Pj4+IMKgwqAg
DQo=
