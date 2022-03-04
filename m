Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8BE24CD501
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 14:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbiCDNSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 08:18:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235452AbiCDNSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 08:18:05 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD0C1B50D9;
        Fri,  4 Mar 2022 05:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646399838; x=1677935838;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=anN38S5KIBrw2yguhx4ETOUxSlEU/Dj9IvePHqw6eLw=;
  b=nowRSOewKSDN9DbwYltTVplMazOV8c216ddMXKh9J6wpL6ciAxkL2tlW
   t7pmuSEAcsctu/dR2kg1WkcvXo0cv8crKJAjwyvDMb+WKhTa6RufPbKO3
   vL5MA4Qk3V/uV96MXpLE+e6eSiC6pMcg5lziYjvVXqBZ6M2r7Ih4BfKyA
   y7cr2yzs8vrIcVqEaqmgKlPZUFEsJkU4rjscCxpZ/tQf/Q8oOa6wIknXV
   lXKfbL/3BeMx10Wbl/knwEMmw9/t4Djeee/lk+KPOkFBUbJ4ddA5X1mke
   3yr7Y7OVamyL92G3nfcoPy90iBI6+FYbdsAPdmy/FAM0YvySC5AjLz/zU
   g==;
X-IronPort-AV: E=Sophos;i="5.90,155,1643698800"; 
   d="scan'208";a="148097661"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Mar 2022 06:17:18 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 4 Mar 2022 06:17:16 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Fri, 4 Mar 2022 06:17:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cOy6yveMudCmL5s9y09dYC+/BcU7ekhaqN7AF5bv5hOAA82QMZKRpmj+09hdsV3TsbIU8eZhw96So4SU7l5p3k+bxgOkj2AwkmJVNTh7HezCelhH9covuHbNwX6Chpx2oiKQA87TI3gVt9g4jxtA6RAB7fNYqvvZnVTfc085bEjw8rZQ+PPEq+MF1QMqBwVypuNWdWgYl9t1PhCHR9tW0Fq/BXLLt77ohssEDtkFZ0oDuJCcthvSuXsvYcqM42uGxcxq1L0sbCT0finekPmcmq00PuZ5Fbc0ekBNHsV+d+TLUgSxKQWGxKa78wu8MRph22GfGi6yI9SQuVMem6ctug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=anN38S5KIBrw2yguhx4ETOUxSlEU/Dj9IvePHqw6eLw=;
 b=OwglDGLboUnNDt3NZIOECNib9NIgLq15AWOxCujZ1GbKMtaKcKtBJpALrzMwrLBuG0M2dX22ma8hPUVbzqm3keypjJjOXfB0IfTBgLyERzuaaxB/a23FMl28tKZVXajDvwKr0d3onY2tbHkme1eybvlLM9e4mNv/6u+XDteT4j7MObSu555ruyxCJjCH6kiEiA7g5VvQydqdriPCb8IrWf1h/dXFulVbuvtC/5wlbjZ7okuhO+dqZLFOf4JWKStA1U3HEyzdk2bf1S5v0Vq4mJ4fTKiZPbQ/WMuT15jawitRmJdz93ijzMj0j8Lu7BGtmwZSxcSCbWCg9gGvB4DYlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=anN38S5KIBrw2yguhx4ETOUxSlEU/Dj9IvePHqw6eLw=;
 b=QrfOwShLyKsqVFzseGJOXx7v/aEsOqIS4OPeqqnOpJKerX0oS30JKsDFbxgA9GepU2HfE/4tHCNgt1UIaCfJ5ucDHR8Lb8xVAmHrmMmgp2MFlqh92HzswkecQfJuP/PrcnIf6JTh9vVDimRPixFqDkXPGvZIu4wM/JMNFnzOw3o=
Received: from BYAPR11MB2758.namprd11.prod.outlook.com (2603:10b6:a02:c9::11)
 by BN6PR11MB2004.namprd11.prod.outlook.com (2603:10b6:404:3c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.13; Fri, 4 Mar
 2022 13:17:11 +0000
Received: from BYAPR11MB2758.namprd11.prod.outlook.com
 ([fe80::381d:1e0a:2ec0:38b6]) by BYAPR11MB2758.namprd11.prod.outlook.com
 ([fe80::381d:1e0a:2ec0:38b6%4]) with mapi id 15.20.5038.014; Fri, 4 Mar 2022
 13:17:11 +0000
From:   <Sergiu.Moga@microchip.com>
To:     <krzysztof.kozlowski@canonical.com>, <a.zummo@towertech.it>,
        <alexandre.belloni@bootlin.com>, <robh+dt@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <Claudiu.Beznea@microchip.com>
CC:     <linux-rtc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/5] dt-bindings: rtc: convert at91sam9 bindings to
 json-schema
Thread-Topic: [PATCH v2 4/5] dt-bindings: rtc: convert at91sam9 bindings to
 json-schema
Thread-Index: AQHYLwjbMZ+XCeubyEmQV/7CBA/HTayttdYAgAGAaIA=
Date:   Fri, 4 Mar 2022 13:17:11 +0000
Message-ID: <a1dcdc47-76a2-ee30-9ba6-8a4b056809af@microchip.com>
References: <20220303140626.38129-1-sergiu.moga@microchip.com>
 <20220303140626.38129-5-sergiu.moga@microchip.com>
 <ad09590a-701f-c798-3da5-c3147bf6778b@canonical.com>
In-Reply-To: <ad09590a-701f-c798-3da5-c3147bf6778b@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 74fac03d-5d12-4850-1c19-08d9fde14ae4
x-ms-traffictypediagnostic: BN6PR11MB2004:EE_
x-microsoft-antispam-prvs: <BN6PR11MB20046083A6EF7F4A6251DB5FE8059@BN6PR11MB2004.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OD36gLzfjDJ38cpb8ZtgDXB7eWgt/5Qe23oW8fpuAfNLkkuLNWplqZKI0TvCXZlR1A2JBWG13soaQbn7niKz4c04LelS0m3J0w1iIZkgcMA7WHt+4MRxHImftOkKhGnCZxXALiySNttcy0dNEDtAIfw+vD5sp39v3P+si7ygK1H/zNVIXn8AmdV//YEUXVdlvWSC2zjdA5x04ZYLHt3wR2khe/MYJDQGiRlz1l9cA9Jh2d4cB994IdT2/4+K1Qc1ODFc9KWTVfVoY9QQGSeU+uY8gVGXPmgCr8h3IZacZKqZQa7alxqQKL23EEVti14WsNfMPDYd0U8hDY7O9qs12qDUqiDXMGGcXjLrUyGZDkxMuD97kC+MT/ioK8quQK427L4mO2ab9hGHYwGygoZH3OOIn97DLlviwDruhZyVRZ4PvhECzDuzJysHE/DrY8XgJxU9ocDsV4pCdgd97YH+V27DMhnKpek2tWrHE+opK6OWDlM+1eL5CbbppU1czgc+bnZfXlUsGLo40RzMiZK3njzBYeLJF45d4HQ44vECgQyu9EU3xEPoWRuoAk7qADFejPKNudWpofEzQL+cpQkv3CE/7sEE0D+8Lsvq7vgni1eJki2FMXryAY+NvZKdsy5mXjfEnMRsab94mbdJEfb3VpOXvM2e/lt8ejv0FexWTK2cGk0ORkWfJHZ2Stqf5fCeBF/ac3jHi+uJ5cgHIWUgB1FUuwsd6a8Dvgun/bBbWVYwS+B6nkAncLWa14X/z5t+T9PdLpYaNaxdm6MXVtTkXN6JMch45qOewzw3AAkIT8uiSTNDGt3r0ZiDx4UHjnyvwaV5ImxxJKcDjmhLHCeIaHMdBsL6Dp6CRj9oXHcLZtHCkrCCCIQF7s9x3MeWZCJe
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2758.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(31696002)(2906002)(5660300002)(38100700002)(2616005)(8936002)(86362001)(83380400001)(36756003)(53546011)(91956017)(122000001)(110136005)(186003)(26005)(6506007)(76116006)(54906003)(38070700005)(316002)(6636002)(66946007)(71200400001)(6512007)(508600001)(966005)(6486002)(31686004)(4326008)(66476007)(64756008)(66556008)(8676002)(66446008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S1MwWjhIY3pXT3l3WWp5MTNxTWJQTldxSk5lTzZBRjR6NUU2V2g5ZGZGTnp5?=
 =?utf-8?B?bnRqblFLWVZ6Q0NGZCtWSmJPQlhpNTFHTnNYV2c0enY2cVJmb3VwOTdQOVkw?=
 =?utf-8?B?RUZyYzFFZko3U2lRQ21RdEhVZW84WkU0UXYyeTRCdnE1ZnRhb1FQSDU3Nndl?=
 =?utf-8?B?TDczSTJnc2JYaFFESks5TUFYUERhQlA5a3hpWUJpWUI1d0phajR4dm1SWnZO?=
 =?utf-8?B?cnAxVW1pRXU2QzFhZ1IwcXpBa1ZjZlJTeTNtcXVFK2xCa3YwV3VTalNUaWtv?=
 =?utf-8?B?dlNkUnNDZGgwNUk1NG9uTEJETmIzbWpvTG1JejRvbUtMdmlOTFZzZzA5RnVs?=
 =?utf-8?B?OTJlS2dhcTRFV016R3E2TlVDc2xIUmEyR3gyMVZQYTZoa3VRSkpVaXZrUGxZ?=
 =?utf-8?B?S3JCMHhobjF4SzhnRkoyQWZGK0Y1aWIrMk9KUzV5blpQR0VLV2M5Zzd2WWhq?=
 =?utf-8?B?RXFTNHZxa1hlYi83ejJFMnE1dWxtU2ZtVUd2VUdmK1I4Wnpzb3RyYk5QbE9X?=
 =?utf-8?B?cHdXb0EwazkxNSsvZFY5M1VTaW5YR0lSSWxYTE81ZTlrTy9UTzM3TmhPL0F1?=
 =?utf-8?B?ancwcGRLekJkVUltR2F3WmNLeThoVzBZVVhNdVRCUXVtclI4SjhkWXpoM01G?=
 =?utf-8?B?V3BUUitmbmNnTzdhWjA3TnNQTFpoZ2MwUlpsZllLanJ5dHNUb0NCOG1HdXhi?=
 =?utf-8?B?bExrWkZGNTIydG1XN01YNW43Mzl0UlBpcFV6cmdNYi85M1lLZXIyQ1lQUm43?=
 =?utf-8?B?YjBEQ1dxbE9vdERkK01xMkFsNTNBNlhWQjZMQlplYVl6QVRjSXRMVWpwbThC?=
 =?utf-8?B?V1FlNEVwbHpKZTc4MDVlb1dRV1dlZnFhYzZubi9nbDM3S1JUckhaU2hQZ0Ns?=
 =?utf-8?B?YkRNZTUrSG1OZGs3SGZBVXRlc3Z2dlhrWkFlcEVJeHJkUmJNZXVqY1FIV1ZI?=
 =?utf-8?B?cXlvMXovUFBPWkdEZW40MjhCK29LZUJXS3BpN3JNNWhCL1E1eCtuRUw5d1J5?=
 =?utf-8?B?KzRmNzg2RVNOZkhXV0RlaEJyc3hVNm5JVUk0ejlVSy8yamdGNlU5SThWUE9j?=
 =?utf-8?B?T3BrdUVnVHE1cEdKVnV2eFhoK1ZkSllFMVE0MVh6ZVBQckdhbHhDb0tvREl3?=
 =?utf-8?B?WW1HcW1XNEcwNFNxZUJTWlBjUUMyL0dISEZyV2VSdGdnRTlvMjZuUzRJdThP?=
 =?utf-8?B?T2hqMWNsOEFNRXpHc0kvSWhlbFRaQW1IZ1VPYVVqUEE2a1phcUpTZmE1cjQv?=
 =?utf-8?B?ZDFXQUJkcGxZQ1ZoQUxWd0FVam1mZ3VYczVCQjVoSnlWbW5rYWg4V3p1bmtL?=
 =?utf-8?B?M08zbGVCSEg4K1VscEVnOTdSa1B6cEdXMzdqa1Z4RVpnazVqVGtSMlZHYkZw?=
 =?utf-8?B?L2FJMTQ4NTN1RW82dDhHUW96ZjZUa1QvNnptSFU2dUhaSjhGaUhrajFKSG5r?=
 =?utf-8?B?TEt4M09HOHg3Z1pza2E0UGhvZ1hzL3l1SkJFTjd5cS9RWnF4YnNmYVo0Tnhh?=
 =?utf-8?B?OEFneW5WRFBwdDRnUmU2MGpxS1MzeGxhNExaTnJTQjJZZ2RnaVlKSlZKZ1hP?=
 =?utf-8?B?MjZxNHNDOG5NcUZlU2lBcHN2MHYrS3FZVnNtMCtyMU9ISnFKNTBCQUtkcHdz?=
 =?utf-8?B?d3ZGMmZNaTVQdkVYTDJsclJpWkVsa3dRY0RZVjVKR3UzK3RETzVGR1Bad2Ro?=
 =?utf-8?B?akNDNmE4QWgyNzJHazJpMWpWaXdFanhIWDNGSU1QV25PbHMxc3VRZUNHbUJJ?=
 =?utf-8?B?TGtlemFmcjh3RXE0MXE4by9JM2FyY2hPTk5pY2FFN1djV2lCcmRLcEVqb2NP?=
 =?utf-8?B?dkt2RUNwazM1RjZ5eWp4SXlIR1crSnFTNUc2cy9nQ2h3NCtxL3ZuaVd1UERy?=
 =?utf-8?B?RzRKVU0zV3NyOWZxSmJNOS9LYmhtSzM4SGoraStvQ3hBYVM4VlhSRU41dUdJ?=
 =?utf-8?B?bnJiUEVkQXR5Q0Y3akYvV3JFdWYvdUNGdmFnSnhtYnFkcERLTWR0bXlaeC83?=
 =?utf-8?B?dnExR0pqSktkTGI2cnIreHE4TEVCYm9MTWZ2OFVPRE5IQnA2a2pHVE5vaFVa?=
 =?utf-8?B?NkhFdlcyQ1M1Rk5tMXpFWTg4cjg1RU5hYm5ZM1FicmxCQ0p0UWI4QkZ6L3o4?=
 =?utf-8?B?V0lEQkxlZGxzcklkZzhZM2pIS3U4OGVTc2xBRzFUaFFrWE1mYXlDV0RXSng3?=
 =?utf-8?B?cWcyNkhvNzdyVGlWdGlSd1doL0ZRZnVRdy8xTDFvaUt1c1ZGRks5Z3poZzFo?=
 =?utf-8?B?QmRLcUgzam9MOWRQNHR6dG93eS9RPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4074AD23395E5A489E0FAAB371EF1D2E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2758.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74fac03d-5d12-4850-1c19-08d9fde14ae4
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2022 13:17:11.4318
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jnY3iKqu8FS2Mgz2H9fI/v3WZDRe5+cIqsJGr1yIXe6nnw9p88aubUlFWVZegNVSq4vkCvWpIy2kKPOOJ4axl7g65IHjFpqPw/nhQMYVD3M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB2004
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDMuMDMuMjAyMiAxNjoyMSwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gT24gMDMv
MDMvMjAyMiAxNTowNiwgU2VyZ2l1IE1vZ2Egd3JvdGU6DQo+PiBDb252ZXJ0IFJUQyBiaW5kaW5n
IGZvciBBdG1lbC9NaWNyb2NoaXAgU29DcyB0byBEZXZpY2UgVHJlZSBTY2hlbWENCj4+IGZvcm1h
dC4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBTZXJnaXUgTW9nYSA8c2VyZ2l1Lm1vZ2FAbWljcm9j
aGlwLmNvbT4NCj4+IC0tLQ0KPj4gICAuLi4vYmluZGluZ3MvcnRjL2F0bWVsLGF0OTFzYW05LXJ0
Yy50eHQgICAgICAgfCAyNSAtLS0tLS0tLQ0KPj4gICAuLi4vYmluZGluZ3MvcnRjL2F0bWVsLGF0
OTFzYW05LXJ0Yy55YW1sICAgICAgfCA2MSArKysrKysrKysrKysrKysrKysrDQo+PiAgIDIgZmls
ZXMgY2hhbmdlZCwgNjEgaW5zZXJ0aW9ucygrKSwgMjUgZGVsZXRpb25zKC0pDQo+PiAgIGRlbGV0
ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcnRjL2F0bWVs
LGF0OTFzYW05LXJ0Yy50eHQNCj4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9ydGMvYXRtZWwsYXQ5MXNhbTktcnRjLnlhbWwNCj4+DQo+PiBk
aWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3J0Yy9hdG1lbCxh
dDkxc2FtOS1ydGMudHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3J0Yy9h
dG1lbCxhdDkxc2FtOS1ydGMudHh0DQo+PiBkZWxldGVkIGZpbGUgbW9kZSAxMDA2NDQNCj4+IGlu
ZGV4IDNmMGUyYTU5NTBlYi4uMDAwMDAwMDAwMDAwDQo+PiAtLS0gYS9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvcnRjL2F0bWVsLGF0OTFzYW05LXJ0Yy50eHQNCj4+ICsrKyAvZGV2
L251bGwNCj4+IEBAIC0xLDI1ICswLDAgQEANCj4+IC1BdG1lbCBBVDkxU0FNOTI2MCBSZWFsIFRp
bWUgVGltZXINCj4+IC0NCj4+IC1SZXF1aXJlZCBwcm9wZXJ0aWVzOg0KPj4gLS0gY29tcGF0aWJs
ZTogc2hvdWxkIGJlIG9uZSBvZiB0aGUgZm9sbG93aW5nOg0KPj4gLSAgICAgLSAiYXRtZWwsYXQ5
MXNhbTkyNjAtcnR0Ig0KPj4gLSAgICAgLSAibWljcm9jaGlwLHNhbTl4NjAtcnR0IiwgImF0bWVs
LGF0OTFzYW05MjYwLXJ0dCINCj4+IC0tIHJlZzogc2hvdWxkIGVuY29kZSB0aGUgbWVtb3J5IHJl
Z2lvbiBvZiB0aGUgUlRUIGNvbnRyb2xsZXINCj4+IC0tIGludGVycnVwdHM6IHJ0dCBhbGFybS9l
dmVudCBpbnRlcnJ1cHQNCj4+IC0tIGNsb2Nrczogc2hvdWxkIGNvbnRhaW4gdGhlIDMyIEtIeiBz
bG93IGNsayB0aGF0IHdpbGwgZHJpdmUgdGhlIFJUVCBibG9jay4NCj4+IC0tIGF0bWVsLHJ0dC1y
dGMtdGltZS1yZWc6IHNob3VsZCBlbmNvZGUgdGhlIEdQQlIgcmVnaXN0ZXIgdXNlZCB0byBzdG9y
ZQ0KPj4gLSAgICAgdGhlIHRpbWUgYmFzZSB3aGVuIHRoZSBSVFQgaXMgdXNlZCBhcyBhbiBSVEMu
DQo+PiAtICAgICBUaGUgZmlyc3QgY2VsbCBzaG91bGQgcG9pbnQgdG8gdGhlIEdQQlIgbm9kZSBh
bmQgdGhlIHNlY29uZCBvbmUNCj4+IC0gICAgIGVuY29kZSB0aGUgb2Zmc2V0IHdpdGhpbiB0aGUg
R1BCUiBibG9jayAob3IgaW4gb3RoZXIgd29yZHMsIHRoZQ0KPj4gLSAgICAgR1BCUiByZWdpc3Rl
ciB1c2VkIHRvIHN0b3JlIHRoZSB0aW1lIGJhc2UpLg0KPj4gLQ0KPj4gLQ0KPj4gLUV4YW1wbGU6
DQo+PiAtDQo+PiAtcnR0QGZmZmZmZDIwIHsNCj4+IC0gICAgIGNvbXBhdGlibGUgPSAiYXRtZWws
YXQ5MXNhbTkyNjAtcnR0IjsNCj4+IC0gICAgIHJlZyA9IDwweGZmZmZmZDIwIDB4MTA+Ow0KPj4g
LSAgICAgaW50ZXJydXB0cyA9IDwxIDQgNz47DQo+PiAtICAgICBjbG9ja3MgPSA8JmNsazMyaz47
DQo+PiAtICAgICBhdG1lbCxydHQtcnRjLXRpbWUtcmVnID0gPCZncGJyIDB4MD47DQo+PiAtfTsN
Cj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcnRjL2F0
bWVsLGF0OTFzYW05LXJ0Yy55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3J0Yy9hdG1lbCxhdDkxc2FtOS1ydGMueWFtbA0KPj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4+
IGluZGV4IDAwMDAwMDAwMDAwMC4uNWE2MzljMGVjMmMwDQo+PiAtLS0gL2Rldi9udWxsDQo+PiAr
KysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcnRjL2F0bWVsLGF0OTFzYW05
LXJ0Yy55YW1sDQo+PiBAQCAtMCwwICsxLDYxIEBADQo+PiArIyBTUERYLUxpY2Vuc2UtSWRlbnRp
ZmllcjogKEdQTC0yLjAtb25seSBPUiBCU0QtMi1DbGF1c2UpDQo+PiArIyBDb3B5cmlnaHQgKEMp
IDIwMjIgTWljcm9jaGlwIFRlY2hub2xvZ3ksIEluYy4gYW5kIGl0cyBzdWJzaWRpYXJpZXMNCj4+
ICslWUFNTCAxLjINCj4+ICstLS0NCj4+ICskaWQ6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hl
bWFzL3J0Yy9hdG1lbCxhdDkxc2FtOS1ydGMueWFtbCMNCj4+ICskc2NoZW1hOiBodHRwOi8vZGV2
aWNldHJlZS5vcmcvbWV0YS1zY2hlbWFzL2NvcmUueWFtbCMNCj4+ICsNCj4+ICt0aXRsZTogQXRt
ZWwgQVQ5MSBSVFQgRGV2aWNlIFRyZWUgQmluZGluZ3MNCj4+ICsNCj4+ICthbGxPZjoNCj4+ICsg
IC0gJHJlZjogInJ0Yy55YW1sIyINCj4+ICsNCj4+ICttYWludGFpbmVyczoNCj4+ICsgIC0gQWxl
eGFuZHJlIEJlbGxvbmkgPGFsZXhhbmRyZS5iZWxsb25pQGJvb3RsaW4uY29tPg0KPj4gKw0KPj4g
K3Byb3BlcnRpZXM6DQo+PiArICBjb21wYXRpYmxlOg0KPj4gKyAgICBvbmVPZjoNCj4+ICsgICAg
ICAtIGl0ZW1zOg0KPj4gKyAgICAgICAgICAtIGNvbnN0OiBhdG1lbCxhdDkxc2FtOTI2MC1ydHQN
Cj4+ICsgICAgICAtIGl0ZW1zOg0KPj4gKyAgICAgICAgICAtIGNvbnN0OiBtaWNyb2NoaXAsc2Ft
OXg2MC1ydHQNCj4+ICsgICAgICAgICAgLSBjb25zdDogYXRtZWwsYXQ5MXNhbTkyNjAtcnR0DQo+
PiArDQo+PiArICByZWc6DQo+PiArICAgIG1heEl0ZW1zOiAxDQo+PiArDQo+PiArICBpbnRlcnJ1
cHRzOg0KPj4gKyAgICBtYXhJdGVtczogMQ0KPj4gKw0KPj4gKyAgY2xvY2tzOg0KPj4gKyAgICBt
YXhJdGVtczogMQ0KPj4gKw0KPj4gKyAgYXRtZWwscnR0LXJ0Yy10aW1lLXJlZzoNCj4+ICsgICAg
JHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvcGhhbmRsZS1hcnJheQ0KPj4g
KyAgICBkZXNjcmlwdGlvbjogfA0KPj4gKyAgICAgIFNob3VsZCBlbmNvZGUgdGhlIEdQQlIgcmVn
aXN0ZXIgdXNlZCB0byBzdG9yZSB0aGUgdGltZSBiYXNlIHdoZW4gdGhlDQo+PiArICAgICAgUlRU
IGlzIHVzZWQgYXMgYW4gUlRDLiBUaGUgZmlyc3QgY2VsbCBzaG91bGQgcG9pbnQgdG8gdGhlIEdQ
QlIgbm9kZQ0KPj4gKyAgICAgIGFuZCB0aGUgc2Vjb25kIG9uZSBlbmNvZGVzIHRoZSBvZmZzZXQg
d2l0aGluIHRoZSBHUEJSIGJsb2NrIChvciBpbg0KPj4gKyAgICAgIG90aGVyIHdvcmRzLCB0aGUg
R1BCUiByZWdpc3RlciB1c2VkIHRvIHN0b3JlIHRoZSB0aW1lIGJhc2UpLg0KPiBJbnN0ZWFkIG9m
IGRlc2NyaWJpbmcgY2VsbHMgaGVyZSwgeW91IG5lZWQgaXRlbXMgd2l0aCBkZXNjcmlwdGlvbi4g
SQ0KPiBnYXZlIHlvdSB0aGUgZXhhbXBsZSBsYXN0IHRpbWUsIHNvIGluc3RlYWQgb2YgaWdub3Jp
bmcgaXQsIHBsZWFzZQ0KPiBpbXBsZW1lbnQgaXQuDQo+DQpOb3RlZC4NCg0KPj4gKw0KPj4gKyAg
c3RhcnQteWVhcjogdHJ1ZQ0KPj4gKw0KPj4gK3JlcXVpcmVkOg0KPj4gKyAgLSBjb21wYXRpYmxl
DQo+PiArICAtIHJlZw0KPj4gKyAgLSBpbnRlcnJ1cHRzDQo+PiArICAtIGNsb2Nrcw0KPj4gKyAg
LSBhdG1lbCxydHQtcnRjLXRpbWUtcmVnDQo+PiArDQo+PiArYWRkaXRpb25hbFByb3BlcnRpZXM6
IGZhbHNlDQo+IFRoaXMgd2lsbCBkaXNhbGxvdyBhbnkgb3RoZXIgcHJvcGVydGllcyBtZW50aW9u
ZWQgaW4gcnRjLnlhbWwsIGUuZy4NCj4gcG9wdWxhciB3YWtldXAtc291cmNlLiBJcyBpdCByZWFs
bHkgaW50ZW5kZWQ/IElmIGNvcmUgc2NoZW1hIGlzDQo+IGV4dGVuZGVkLCB0aGUgZHJpdmVyIHdv
dWxkIG5lZWQgdG8gYmUgdXBkYXRlZCB0byBzdXBwb3J0IG5ldyBmZWF0dXJlcy4NCj4gQW55IHJl
YXNvbiB0byBjaG9vc2Ugc3VjaCBhcHByb2FjaD8gVGhlIG90aGVyIHdheSBpcyB0byByZW1vdmUN
Cj4gc3RhcnQteWVhciBhbmQgaGF2ZSBoZXJlIHVuZXZhbHVhdGVkUHJvcGVydGllcy4NCj4NCkFo
LCBJIHNlZS4gUmVtb3Zpbmcgc3RhcnQteWVhciBhbmQgdXNpbmcgInVuZXZhbHVhdGVkUHJvcGVy
dGllczogZmFsc2UiIA0KaGVyZSBpcyBiZXR0ZXIgaW5kZWVkLg0KDQo+PiArDQo+PiArZXhhbXBs
ZXM6DQo+PiArICAtIHwNCj4+ICsgICAgcnRjQGZmZmZmZDIwIHsNCj4+ICsgICAgICAgIGNvbXBh
dGlibGUgPSAiYXRtZWwsYXQ5MXNhbTkyNjAtcnR0IjsNCj4+ICsgICAgICAgIHJlZyA9IDwweGZm
ZmZmZDIwIDB4MTA+Ow0KPj4gKyAgICAgICAgaW50ZXJydXB0cyA9IDwxIDQgNz47DQo+IEF0IGxl
YXN0IG9uZSBudW1iZXIgYWJvdmUgbG9va3MgbGlrZSBrbm93biBtYWNybywgc28gdXNlIGl0Lg0K
Pg0KTm90ZWQuIFdpbGwgYWRkIGFub3RoZXIgcGF0Y2ggdG8gdGhlIHNlcmllcyBmb3IgdGhpcy4N
Cg0KPj4gKyAgICAgICAgY2xvY2tzID0gPCZjbGszMms+Ow0KPj4gKyAgICAgICAgYXRtZWwscnR0
LXJ0Yy10aW1lLXJlZyA9IDwmZ3BiciAweDA+Ow0KPj4gKyAgICB9Ow0KPg0KPiBCZXN0IHJlZ2Fy
ZHMsDQo+IEtyenlzenRvZg0KDQpUaGFuayB5b3UgZm9yIHRoZSBmZWVkYmFjay4NCg0KU2VyZ2l1
DQoNCg==
