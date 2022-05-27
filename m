Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6252E536842
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 22:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351169AbiE0UwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 16:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237744AbiE0UwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 16:52:15 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88FE557992;
        Fri, 27 May 2022 13:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1653684732; x=1685220732;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Ywr+i3iAR0NkKTLFp6oYy4Vj0znDh+BX5b2w9sP4CXw=;
  b=Ascs+hAo+8Hc2KwKDGfM6gyyscEFYEE9JaYOgai1E+3Z+/Mq/OBGsM21
   t21JbaqZ1Kqo2bWdjWdJvmb3q7exfnXUiqhBfLzT9bTejBiylv/jVdcY4
   wnWc1CitQYz0Gu52NxLGt55MYBKuvOHRW3yUb2PB11nDEJFc9x4wHA3Y5
   UG6pyE+85OGroIOjZ7QsAOJSBlwYC8r9xlU+OSQDbtC9tthj5dBqOiGzU
   HDGyXt9XPxN5d0gOClKoxr5iE4sSNc3XQ63R7fNC6/+p5n9okpdC25e5H
   YHFe5qYjQUagZqU04Oo2z1+aEHKS3SFxkQlB0txpWgxgdgZJLUAgWHYC0
   w==;
X-IronPort-AV: E=Sophos;i="5.91,256,1647327600"; 
   d="scan'208";a="166050480"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 May 2022 13:52:11 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 27 May 2022 13:52:11 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Fri, 27 May 2022 13:52:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XBNmZ/AnuafDzBLIRsF/wZ7bJgdOnI5dU0nRSvJwhJfhQhvj3+JLB/y56uUbU3okatFd085o1GzBOtTw2IK+vQm0WldZH5hHLL43mcxHBncayDDPsf52bw4Ncvo9qfMsFzS6chRafOrE12OQ1RNGAk3qVeDFY4RNjd/10MBsWTsBIGW4vs1e26/eylmU393nMdhkklVF0JdMpE3ek3lEX3AV3BkUSonElEtIF84JuqvV2ug+yPCr6l4azax4z9nXWy5wui74lEeCZE1ZiSHg4zHhjc+VuWPB8bANhuKZU/HN21jrJz4W5UJXRRqEXl7QGsERlGk+ir2OZjVsw3j6uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ywr+i3iAR0NkKTLFp6oYy4Vj0znDh+BX5b2w9sP4CXw=;
 b=ldpn2oGiAZb9Ht/+J8hjdQM0omSRgIEvlCVLmKKx3dBBk+KXrlP6ERGkeKMPlNgPVsca+VxHs9Sj5xZhZ7h4dE0IQCnjfJumV7DsA/O3wXE/zZVyyWxqftgfpESd5FgdDpASVJV+IgfPE10U4AVjKaQMkZ5sDuEyitgMm6XEMA+rd414Am0wIiPYHI8RmLSgfO2iR4PtgG0oUy8oNPHBkUZZ0B3wZFzmA8LdBf6wFXgey5aM6IZJCdO7n3hvq7vn/OgVN4wYAXWH+C88gr6qAmsJtIIYcqXkpRR544JpvV9NKkiZtD+MkB4sW4272o2X+FJ92ZWBxMrfzAqRylaOGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ywr+i3iAR0NkKTLFp6oYy4Vj0znDh+BX5b2w9sP4CXw=;
 b=TVolr0ez9FtCW1iZqAUxoDyOJJsvO2iLcCwCvkPEXZV1qLBVw4ZJLVmjzkd1Dd4Wwk2AwD14LTPmVNtRXxIacBqSY9p5U+1bYKT5KxF8cWv8bwngic8egPgqPsEIjUkEDVyiyvR1ASLOi4J8H1XWFxIZ2lc2k3eL8D+37zU7g8U=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DM6PR11MB3754.namprd11.prod.outlook.com (2603:10b6:5:146::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Fri, 27 May
 2022 20:52:05 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa%6]) with mapi id 15.20.5293.013; Fri, 27 May 2022
 20:52:05 +0000
From:   <Conor.Dooley@microchip.com>
To:     <sboyd@kernel.org>
CC:     <Daire.McNamara@microchip.com>, <geert@linux-m68k.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mturquette@baylibre.com>, <p.zabel@pengutronix.de>
Subject: Re: Reset controller within a clock driver
Thread-Topic: Reset controller within a clock driver
Thread-Index: AQHYcflPoksJXIVaQkOgoJTQWMRNiq0zG0UAgAAYBQA=
Date:   Fri, 27 May 2022 20:52:05 +0000
Message-ID: <38392ca6-5ea6-a2ce-9fac-80356c4c0d37@microchip.com>
References: <31b7293f-662d-4a94-1717-9c76d7f33840@microchip.com>
 <20220527192608.25F47C385A9@smtp.kernel.org>
In-Reply-To: <20220527192608.25F47C385A9@smtp.kernel.org>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a10f8fa5-b87b-4a47-7c50-08da4022c1ee
x-ms-traffictypediagnostic: DM6PR11MB3754:EE_
x-microsoft-antispam-prvs: <DM6PR11MB3754569CCF2DF9A45CB4CDA998D89@DM6PR11MB3754.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qPP20uTp0bZfId7lb0bw3+SMe1eWUZ3DZcJI5BxllLoXMis6u5xYKr9rhlhiH80T2/YA5PAEAfDLqdVhWFgtaWKdpoX5RTGK0rsNDdlgfHPKxTMv7asxrFqq7w0pQ+Bl/a4NTsO/TCLuVqu+h+qUGjrb/v524Qi6zxDY+98IX+GGgbspBQ/DYVjVzjvQeddAcTPaa5NGE5iFDDSrZmTYticuOx10ohoOq8Nh0FYol7+muiMByM4TNkDQ9qAL5KB7KpiAitCAce2AdWEJ+XILBhGGcC9ZPH7/+vgUBJh0Pz4ORf1WWXTRabnUDLvBb8Lu8w51dO/RzurxUr0wqw3BL+YuT7yupaP4fjb2pNiwF7sAJEUfBpyNmcDmQNftNYBXmItfDNrxvS5NRJa9BDCmhjv19cpY2rckyouVHxLlej+mOvL7K80I2Vg/jZBfPR0I7n0S2sX3m1ycT37vHWb7gXzFam5dyjW4NDUdYJkZyeEzGk4hgrrxF4umsaLUiNVNxuZ8twLRu8fUZnwQ2lPeBAS0otl0ecY+OHnBBCzwQtgd+abBOn7lG8IjtpuoTK8Lyl5gsHMjeJvKuVVYrTCWGaT3g5BoTiqBQkJO7UGiQyhwYChaJWvrdEFsmotBg/Q5tEUBrOJRj5ktGR69eFLpvo6h8VGwJ9MFi7apKGMFfXdnNyrckEiumWpUjkIpuBu5gZuwEdtIZN3mu21MFkXSGowwKtilv4QH29z9dWLznU1ZgkKI8qCdqq0hm2k8tfxjI6FuOOFQKeqxPgpnXtwrPA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(122000001)(38100700002)(6486002)(54906003)(36756003)(316002)(6512007)(8676002)(31686004)(26005)(508600001)(53546011)(6506007)(71200400001)(6916009)(66446008)(66476007)(64756008)(66556008)(66946007)(86362001)(83380400001)(186003)(31696002)(2616005)(91956017)(4326008)(76116006)(2906002)(8936002)(38070700005)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Mys3QVo3VjNkb1ZlM0t2emkyN1FDSEdEL3hyR2FoTDkzQVkyckdrVzVhQlVv?=
 =?utf-8?B?a2JJV2JaTmJyVHVCT3RIamxWUFJDeUk1U3Vpbk5KRUs0VmtmSEk4SDlTWHY4?=
 =?utf-8?B?T3B2KzJvenEyUkMrMkd4Rm1ERWtBRm9jY1FRUWluVjRiNEs4d2ZQNFZtVDF3?=
 =?utf-8?B?SXhLR3ZidTJ6QVdybjBZa2xFZXk4K1dFaTdLcTJyckY2em93U3Fpc1lCL3FU?=
 =?utf-8?B?WXJlc1drbTVoTWw3YS9HSWNpenR5Tmw3anBRcjc4T1I4SlJ3ek5YWFNzZW1z?=
 =?utf-8?B?T3dKcy92NmRlZTU3WWdaZVlLNVpTd1JKdW92Y2xlWTdtYUZWcEFQSnZDWFJS?=
 =?utf-8?B?VG1xSHpHSjlZTGRZNmV3RnpIZldzbWVmUVdKZW9iSFFXYWgwaTFYcFREOTlM?=
 =?utf-8?B?MUlXMVV0TTdnL1N0QVhZakpDVnByWWw2RUZaYTFoYUFXTTJYS1NvcWhISms1?=
 =?utf-8?B?M29IZ29Lck5xMXozNnNUN0p0cHYvODhSMHp6OFhFM21GMlBjM3dLYUxSeXlK?=
 =?utf-8?B?cHJOaUNIb0w1NzdZUE9xckFVaHgxWUlNNmZJcGZUWThza1NDcmVjcGd2L21v?=
 =?utf-8?B?d2NxQmZQVG5pb0tvYXRkbFdtaUs2WDNGOUhNUkJSSEJWSytMMCtwYkZxdXk0?=
 =?utf-8?B?ZklGQjNLRCtPZ3o3dmxDOXA4SVhYcW9QM253NzNEQ1R5SDZsR3ZtSThkbGpG?=
 =?utf-8?B?Z3ErRW9WYWZvSGFxZng1VGd5cFF3T0pIZnVYY3hXMEhYSnRKb3VFb3ZLZkVB?=
 =?utf-8?B?RVhwSUFKUEI1bVN0ejJSaFVieFVOb3JnZE5iUktzV0NBRnFmNGdEeDZhK3Z3?=
 =?utf-8?B?MndPY3dyWXlHbG5SSEdINU9MMmR5MmZEQUZEMW54ZFlaNXdYZmdFY3Z5alRk?=
 =?utf-8?B?b3JuRkNtbDk3ZnNEdHB6Skg3cXVvVGpVQ2hZSkxOaEVqUzFkb3BnWmJYdndW?=
 =?utf-8?B?ZFp6Y1RISWREbG5td3FsM3VWMStFYUNKRDhqOUtKSFIxOXRRbTZSeVNaZXQ0?=
 =?utf-8?B?dFpJaHJjR0trbkE0UWFYa211ZzA3RVpnQ2cyL0pndHdab0M0a1dwUTE3RkpY?=
 =?utf-8?B?dVhrMkhaN1FWcndldDlEV1FNMDU1RlQ0SkJaVzdaaXIrMENUVEtiSUtpK05h?=
 =?utf-8?B?c1pCRWd3TU94Z0pET2NTWTBObjlEK09xTCtyM01kNEFBQVRjRTl6UmRDbnhu?=
 =?utf-8?B?QTlRYW1rdjdNUHNBVVJsbTlaUy8xT1lUNUtwaG05elIwMExrZDQwVnBFcll4?=
 =?utf-8?B?bXduV3h6U21PbXVwaTBOa0l3MFRaQUdwUDEzcERKUDlwKzZOOGMyQWNqalU3?=
 =?utf-8?B?RGJWL1NQRnhiMzVjWTFpU25jUWNaWVoxTWs4YjBwWDBYWXpYbnY1UUh1VnAw?=
 =?utf-8?B?REtLZHdPRlJDWm15OVRxNGxzdjBtNzNyblZxdnQrbFdheFRpb05INGVvYk5m?=
 =?utf-8?B?RW5ZR0NHUUhqU0xDVmx4SEJONEJvcXZYbnYxK3FrTzdnWFFKbVlRL0VPMW5E?=
 =?utf-8?B?TStlTnRCMjhCWEFETmVnZG96OEVWaFdBMjY1OU90TnhRaEhUTi9UaG5yOXFv?=
 =?utf-8?B?Zy9GQjRvMmZNVWxMTG5Bcm44b2JDYWJhd0dMcHRMQitBK2FGRGcvd2svWEht?=
 =?utf-8?B?R2tXRGNHd0xVeVNIVjY1OGtFWGgybjFid0kwVm16TjhjZ0lkOTVqOVE1QXZH?=
 =?utf-8?B?a2hxcWFOK0pnaDBNUGE1d1NQUldibzNLSjRBdGhWQ1Q2L0NoRXFZQTNQTDQw?=
 =?utf-8?B?OXJ2ODF3NDFUVUNYWFl5T1J0aHdWSGFqY3ljbDV4NWhUWWdMcjgvaHRpTXVo?=
 =?utf-8?B?aFh1bnhBZFVSdWtSSVZuRTJRV0ozZHE2K1ZhL1ROWHBhUnJacHp2MTYramti?=
 =?utf-8?B?SFlpbjl3aTRvOEpsVktjdGJ3dElvb2NaazQ5NmpaY2Y1REp1Uis4ZjRRV2Mw?=
 =?utf-8?B?aDR0cVZXUDRVb2J0V2NlUVpMM0JaWC81ZnZPN3VoY2NibmJicmZSOXhkOC9Z?=
 =?utf-8?B?aG02M21FaVNBSWpXOFlPc1htODczd2dUVDJIUmY5alBHTXZBQTBTazRMd0VE?=
 =?utf-8?B?azVKdVdsQnY0dHpZRGlXQWI5dVFiNisrMkxyY3kvUzNnRHlLbkx6aTlmNlRQ?=
 =?utf-8?B?T3h2cUl4eUJpWWtHdGVBNG5QUHdUbGcxOEM2OTBmVnFkampHanFGUkNtTllO?=
 =?utf-8?B?RDRuelM4NWlOeXViQkl0bUJ6d2dHSWJlaEU5UGo3Ym9kSWFwcDI5VEY4c0xo?=
 =?utf-8?B?eGlmN1ZuSFlzZm5waEFXYzFzdGlsQWhTcURLOEZVTjkwbkxzczhCMXZyYzBB?=
 =?utf-8?B?clRXTzhrRDdDSFpucWxnTkQ3ZlJCRkVlNUh5WUx2Q24yM2pWTDVNdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <27664AA32D2E5547B2FFDBFA0E790D17@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a10f8fa5-b87b-4a47-7c50-08da4022c1ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2022 20:52:05.2419
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7K8GDT57DmObd9w2KW3VD/0vuGZz/CE1Ps1smzER5+WUHhhW8pynopn8rDfXN0JzZ7wWVBYt193TEzMQi/X8ofN+e9vr/qmzWbzOZae54SM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3754
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjcvMDUvMjAyMiAyMDoyNiwgU3RlcGhlbiBCb3lkIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IFF1b3RpbmcgQ29ub3IuRG9vbGV5QG1pY3JvY2hp
cC5jb20gKDIwMjItMDUtMjcgMTE6NDA6NTkpDQo+PiBIaSBTdGVwaGVuLA0KPj4NCj4+IEFmdGVy
IEkgc2VudCB0aGUgZml4IGZvciB0aGUgYnJva2VuIHJlc2V0cyBpbiBjbGsvbWljcm9jaGlwL2Ns
ay1tcGZzLmMsDQo+PiBbMF0gSSBzdGFydGVkIGxvb2tpbmcgYXQgbWFraW5nIGEgcHJvcGVyIHJl
c2V0IGNvbnRyb2xsZXIgZHJpdmVyIGEgbGENCj4+IGNsay9yZW5lc2FzL3tyZW5lc2FzLWNwZy1t
c3NyLHJ6Z2wybC1jcGd9LmMgd2hlcmUgdGhlIHJlc2V0IGNvbnRyb2xsZXINCj4+IGlzIHBhcnQg
b2YgdGhlIGNsb2NrIGRyaXZlciBmaWxlLg0KPj4NCj4+IEkgZGlkIGl0IHRoYXQgd2F5IGIvYyB0
aGUgcmVzZXQgY29udHJvbGxlciBpcyBqdXN0IGEgc2luZ2xlIHJlZywNCj4+IHN1cnJvdW5kZWQg
YnkgcmVnaXN0ZXJzIHVzZWQgYnkgY2xvY2tzLiBJdCdzIHJvdWdobHkgYSArMTMwLC0xMCBsaW5l
DQo+PiBjaGFuZ2UgdG8gdGhlIGV4aXN0aW5nIGRyaXZlci4gQSAvdmVyeS8gcm91Z2ggdmVyc2lv
biB0aGF0IHdpbGwgbm90DQo+PiBhcHBseSB3aXRob3V0IG90aGVyIGNsZWFudXAgaXMgYXBwZW5k
ZWQgZm9yIGNvbnRleHQuDQo+Pg0KPj4gQmVmb3JlIEkgZ290IGFyb3VuZCB0byB0ZXN0aW5nIHBy
b3Blcmx5IGFuZCBjbGVhbmluZyBpdCB1cCBmb3INCj4+IHN1Ym1pc3Npb24sIEkgc2F3IGEgbWFp
bCB5b3UgaGFkIHNlbnQgYW5kIHdvbmRlcmVkIGlmIEknZCBnb25lIGZvciB0aGUNCj4+IHdyb25n
IGFwcHJvYWNoIFsxXS4NCj4+DQo+PiBTaG91bGQgSSBpbnN0ZWFkIGhhdmUgbXkgY2xvY2sgZHJp
dmVyIGNyZWF0ZSBhIGRldmljZSBmb3IgdGhlIHJlc2V0DQo+PiBjb250cm9sbGVyIHRvIGJpbmQg
dG8sIG9yIGlzIHRoYXQgb3ZlcmtpbGwgZm9yIGEgc2luZ2xlIHJlZ2lzdGVyICYNCj4+IFNlcmdl
J3Mgc2l0dWF0aW9uIGlzIGRpZmZlcmVudCBiL2MgaGUnZCBjcmVhdGVkIGEgZmlsZSBwdXJlbHkg
Zm9yDQo+PiBhIHJlc2V0IGNvbnRyb2xsZXI/DQo+Pg0KPiANCj4gSXQncyByZWFsbHkgdXAgdG8g
eW91LiBJdCBtYXkgYmUgYmV0dGVyIHRvIHVzZSBhdXhpbGlhcnkgYnVzIHRvIHNwbGl0DQo+IHRo
ZSBsb2dpYyBvdXQgdG8gZGlmZmVyZW50IHN1YnN5c3RlbXMuIEkgY2FuIHJldmlldyB0aGUgcmVz
ZXQgY29kZSBidXQNCj4gSSdtIG5vdCB0aGUgcmVzZXQgbWFpbnRhaW5lci4NCg0KQXllLCBDQydl
ZCBoaW0gaW4gY2FzZSBoZSBoYWQgYW4gb3BpbmlvbiB0b28uDQoNCj4gSGlzdG9yaWNhbGx5IHdl
J3ZlIGp1c3QgYWNjZXB0ZWQgdGhhdA0KPiBzb21ldGltZXMgU29DcyBjb21iaW5lIHRoZSBjbGsg
YW5kIHJlc2V0IGNvbnRyb2xzIHRvZ2V0aGVyIGludG8gYSAiY2xvY2sNCj4gYW5kIHJlc2V0IGNv
bnRyb2xsZXIiIGFuZCBzbyB3ZSBoYXZlIHRoZSBkcml2ZXIgcmVnaXN0ZXIgY2xrcyBhbmQNCj4g
cmVzZXRzLiBVc2luZyB0aGUgYnVzIHRvIHNwbGl0IHVwIHRoZSBkZXZpY2Ugd2lsbCBoZWxwIG1v
dmUgdGhlc2UNCj4gcmVnaXN0cmF0aW9uIGNhbGxzIHRvIHRoZSBhcHByb3ByaWF0ZSBzdWJzeXN0
ZW0gc28gdGhhdCB0aGUNCj4gcmV2aWV3ZXIvbWFpbnRhaW5lciBsb2FkIGlzIHNwcmVhZCBhcm91
bmQuDQoNClNHVE0sIEknbGwgZ2l2ZSBpdCBhIGdvLg0KVGhhbmtzLA0KQ29ub3IuDQoNCg0KDQoN
Cg==
