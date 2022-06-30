Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62649562600
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 00:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbiF3WWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 18:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiF3WWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 18:22:15 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296ABF15;
        Thu, 30 Jun 2022 15:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1656627734; x=1688163734;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=GLf9wsiXHXzvZ/LI4mOiCy3p2eUrJ4xDNaeHWUxI5lk=;
  b=iW1rJ3a/ycTGEVGukFXVFnaUeapHktD64CPA3z2xjunIzlbnqSK4tC9s
   Uq6moldkElxEn4KvGfFvYeDro0ryltIRU90hEZLvT8J/fddOV4JeJhDBw
   ObNDoTQi1MRFPAqtYGRINhAzxKlsOpaC3eAE6OLoozQTaQpnmZ3T6fT+9
   eYfM8GgWltN/uc89q8TArvVVF0QJe/4da09YC7Ht8qH9PmMborKo2yW1H
   +hrPGWNXR6c3EBBjHby1lK5yK378sBJwx1WHVg/+k4MthifjqdopVSJnt
   D5Ugh7Sbdo2plxaD3KGDRU/JPMbkP+NVIfDmseo35aDiERRCMMj8a5uZI
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,235,1650956400"; 
   d="scan'208";a="102559721"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Jun 2022 15:22:13 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 30 Jun 2022 15:22:11 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Thu, 30 Jun 2022 15:22:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kqjU3kpl+2ingYzOlWtPwT0012xo8vl8qqCLPrlKwXP8E/6ITleeSOSArHbc8EBM5ziSCX2kpXSbpMh+q65ZhyCJM6aI4rdEB8V4rY0tjmMO1G+K6667cLrO8h+3Ac5/kQxrk9Kag77b2+LYBK4Pd8r8qbF4f0jCqJpeA0oZ+wXr9jLvs6J0GOiSM+qUA8U9e2t2IIOgPvjbqJOpkB6md0ZTwJTBwvZJeuQt77f6LzkIbAmyQDolX8YpztHnrfC9Kazby93/DLOfpMSWI+umtXAb4LhH1RYBEuGjUUNpShCRshD+j7bZP1D16xNPFCj7xgoZx/bD9AMBV62fzY13nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GLf9wsiXHXzvZ/LI4mOiCy3p2eUrJ4xDNaeHWUxI5lk=;
 b=b9iqWnoADlF2Gir4/uD7lAwd8H/GhfRXjmD+JU/FGOhbo0KOS5J8uI6sckTtw0j1qM3ywPfdrHNk+CsDfs2LEpIVRr9fZJRah5luGK5RupUshm7sCOk+jr6vQfgt9f21c84y2E/VMMgXlwt/WxFdqTTFtyM/iSIIHwE24HxhztLJQl/mmr8X+kq/nCLM/cQAc33iwhacTfTLcMfOrzB4C5jmu28yNgyTitcHy/1kO8By5KXz+ux4ZXu0mvMZBEwrE20PFy2LJamSHnWrMtwCM1f3C3JNE0C6bbJPaiKohCUmRj53l4LVKusdU2HQ667dkcyN4OGC0Fc9Q+f8rzh/Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GLf9wsiXHXzvZ/LI4mOiCy3p2eUrJ4xDNaeHWUxI5lk=;
 b=FHjvGJ3Js1+wbRt/eBcNdxPzawoWmO0frBGw4vdpE+p5fuN8x6zpy+ROZSGZQPtHWiXRklCqyJInw7wHGWBAKJOT+tlKJz5jujrY3fzbKrjNmgOUU1BmFYXYDn2qZGdPa6HY6R4eSVUH8LzDKGryOJwchIbMTnQcztqrEi2RVs0=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by MWHPR11MB2061.namprd11.prod.outlook.com (2603:10b6:300:28::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Thu, 30 Jun
 2022 22:22:07 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa%4]) with mapi id 15.20.5373.022; Thu, 30 Jun 2022
 22:22:07 +0000
From:   <Conor.Dooley@microchip.com>
To:     <robh@kernel.org>
CC:     <Sergiu.Moga@microchip.com>, <Claudiu.Beznea@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <UNGLinuxDriver@microchip.com>, <linux-spi@vger.kernel.org>,
        <broonie@kernel.org>, <linux-kernel@vger.kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <Nicolas.Ferre@microchip.com>,
        <Kavyasree.Kotagiri@microchip.com>,
        <alexandre.belloni@bootlin.com>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: spi: convert spi_atmel to json-schema
Thread-Topic: [PATCH] dt-bindings: spi: convert spi_atmel to json-schema
Thread-Index: AQHYjAnpJ9RPijNCmEOYEPo+O29OJq1odCoAgAATawA=
Date:   Thu, 30 Jun 2022 22:22:07 +0000
Message-ID: <95d66046-067d-84a2-387a-64bc0c0bfa18@microchip.com>
References: <20220629125804.137099-1-sergiu.moga@microchip.com>
 <1656542219.625404.1042476.nullmailer@robh.at.kernel.org>
 <8191d9e3-88e9-c8fb-2544-d25d3a93d0a8@microchip.com>
 <20220630211236.GA3303869-robh@kernel.org>
In-Reply-To: <20220630211236.GA3303869-robh@kernel.org>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1e250b73-b806-4bd5-de64-08da5ae6f7b6
x-ms-traffictypediagnostic: MWHPR11MB2061:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yQzjs/HnkEWr14RvDPqlv33wwvI3ulAEDdYdA1e0KkXD3AhwKIpCbdUU+af9P8XRyym4WeUv/1Qz8pAf1pXgy/KdZZvUOgX9R6dT8e10ZYLuz+lfred0Sneo2sZCLfnXvHEWbYOwkqSZhPCN9QV1Ew7kfwxnFJBQcq/uUlo2/gK8WU7r7uofKXLMlF3APy1Y+GNc2n1RScGY0OFBbIKgkAIeyzn+r1cLU06x1Gf2QLoaYJIZo0QcBPIpVlPvUfqOQH3Oq/U/s2zGyTKJCw+mgp19DmCJ2OU5V9sJOEOhH//+/UM9wpimhjWYe775GyXWZ/SWQxJ1IR6fRF9bheap9YFzKOz/Q1vG7xmPBIeLLY+FhWvbefL/6Ay3G4Sr/o2FY8l4zB6Z+Qnfbvl3BlUc4/AdmWmTgcG3gVUtM8Snr56brvEVxh4Lxn0gMIqxm1VCzWYWjB91XkX+yLuBus7QYkQJUuvRMyCv4jg09maOpbElGifoq3MgZ33EOhg+3D2PwS8ydIFlOkAXQXZixzxon4mgf0G5IVmesHcoaTpc0Y6ZcWiNm14Khp0a81b4qd0q1tXL4Fj2T8upntbrOqxZisggUTwuGcSjP2/Vns9pljrzp4qPc5jqCYtR1YKNyixa31fSkN0rmTUqbxASE8X/I572RNSE/H8gBTZujFZsJu3zdNMnjyesNE0xvizxcGboyr3HS6VdTm1MGZW2fcTBPuOPa5uKU7MnCGKFPUOG/zlVxOkGnfFS7sXwNCDB6SeMZnwUhUCXdk1X5iMwDqcQQcnYUAel8l4PuqKbUKwy7ESea+Bh8Y6uzT+NzrqaDhIfVaVFwxFdOWpBKzbPNIUGC0kQ+l6yBa4MliUEz9yKDkolt3hJrcNbbPD/OF09dixx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(376002)(366004)(136003)(346002)(86362001)(26005)(316002)(53546011)(6916009)(38070700005)(8936002)(83380400001)(478600001)(54906003)(41300700001)(8676002)(6512007)(2616005)(91956017)(66946007)(64756008)(186003)(38100700002)(66476007)(31686004)(36756003)(6486002)(2906002)(66446008)(76116006)(4326008)(71200400001)(66556008)(6506007)(122000001)(5660300002)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NjJpazEvQ05TV29jWGFiSm1CbnNld0lNMVU3ekExc0owcXRNTFpYVUpBZTNV?=
 =?utf-8?B?Umx2d1VXRDNkbWRMQ0h6dlBkVElONk5kdUg2TzBndHhrT2dFQW93Y04yNkxH?=
 =?utf-8?B?MTZOOU9pZjl2ZU9tY3dkcnZHNmw1aEdYY0N2NUNEVVFRb09FTmF1VGtBUzV3?=
 =?utf-8?B?VFkvTDRHbHllOHFzWURzRWkybFlJakhsRlJlZmxqT0w2ZjJvTzliNUE0NTRH?=
 =?utf-8?B?Y2wweGNNYUNuYXo5S2NCYkZIMGJCSEh5bGpJRjQyRVVGZ1o1N3ZZdmRIMmVF?=
 =?utf-8?B?R0hFVWxKc1ZIQ3hmak5ZamVqRUpRZ1FoOG1nNTB3eVNVNWgvOVJlZnljVm5l?=
 =?utf-8?B?NTJsaUtrTzhSY0xmcm8yNlFGeDNhTjl1R2ZVU2JUZVROZVVBWVY1VEhIT3JE?=
 =?utf-8?B?MzNidUsydXBoRWU0SzBLL0NYT2RLVWJDTVFBVnROVnIrSGNaeGQ3MnZIUllm?=
 =?utf-8?B?RTlEc0FObHFKUHEvNkhsU2cyZlRJWHpCSUlaV2o4bU5yallvVXhzallkckRr?=
 =?utf-8?B?ZGcrdUFxOHFEQ256K1NiOVJKajR2VmlveDN4VEIxMEdCK0dPdTdxTU84UVhx?=
 =?utf-8?B?VWo5b3BSR1JpOFlOUGR2SGpURDNwamRwNERFYkRWUyt5RHJ1Wm5LV2pIT3Zu?=
 =?utf-8?B?dU91Qmc4N1pyOGxtN2lEZW01WnQ0ODR1RHRwd09xSGJ6UFBRZzNzdTkxZXNB?=
 =?utf-8?B?R1dsUG5xQmV2ZEJ3YlpyK3Rhckx5UytrVHE3aHN0QzFzRE93cnBFMWx0OGlJ?=
 =?utf-8?B?c2dHVVoybVZadldUSzBZYmUrU2hDQ29NU1kxM2xqdTFzUitrU3hpekpOdHM5?=
 =?utf-8?B?ZWRGcVpORXhwMlZSdGRuRS9zMTFlZldFNXl4UkdpZE15cUFDc3NtUVdlVkx6?=
 =?utf-8?B?TjRqUEZFOU9vS1NIUk5xYVRHUWFpMU9nTjhnV2N5TmQ0S0dlMUJQZmROb0FG?=
 =?utf-8?B?V1dRRVE4dlVlSUNFM0hRSGlad0N3TS9GU3hKR25leTN0d2lhZTdROVIybks4?=
 =?utf-8?B?NDhzVGMrbGp5TUw5Z1VPNzlnSWppdTJURXliUnBKL2diR1pSNEpDVmVYODJG?=
 =?utf-8?B?SVFhaXVINllUN2lxZUFta3hVbDNsc2F1K2RVTUxNZHBtYXJuWHNvU2VqNkhF?=
 =?utf-8?B?VFpaT3JjazZTcFA2dnpnSXFWS3orTEVITW1aQk9BZ0pVRFpNaXJFVzAxajI3?=
 =?utf-8?B?c0tsaGZNR1V4ank1R0JEbUxnZlVPRnBEdjF3K0FoK0ZTSlB2T3JYTmRINGxu?=
 =?utf-8?B?MG84NGpoT2ViQjFsSngrRmc0cUdrZ1lueFpRS2QyVWdWY3BDRWtUSVhEZ2R0?=
 =?utf-8?B?ZjNlMTNkeHdpK0syTS9xV28vRXF3bnYwcS8ra1lmckdPakI2SzhpVjNKY1lp?=
 =?utf-8?B?RU5acGNLajNmQSt2NUhMaGhSMzRDOSsvTVBsWTdyWGY0aHkrUWFmS09mY0V4?=
 =?utf-8?B?TDkvZU91emc5SDhJQS9DRlRETXJxNDN5eEpRemdoZ2hxRXBzMDVXaTVtVmtW?=
 =?utf-8?B?cWUvR2RQQWdDRDdqR3UzRjNacDA3Z2lVTEhjMmhVRE5HL00vaXVEblVpRURr?=
 =?utf-8?B?R0RrVDRiN3RvQ1RTcjBHbW5OR3ZYejRKS2s3VVp0ajQ0ZkdGdEdjMUwyby9U?=
 =?utf-8?B?cW1lYUhVQmtxWVJDTlQrRnlIeHdabGEzWjJOeFNTSjIxMXVMMnJzQ2RGVjFG?=
 =?utf-8?B?ZDJMU0hDY2t2QkV2d0g0UU5rMWZUa3ZpNWE3aGJRRkd4cUxhQXVqT2NTNHFp?=
 =?utf-8?B?Uy93STRJYnZ1NXZwbFJGcWtlZlNXTlZtTnZMdXg0SkFKYmtPYnVMYjZWTWRN?=
 =?utf-8?B?SlE3VnkrcUQwWTJqb2lBa1o5SzFzd3k4QUIzcnZhNlBxQnd6NEh1TUJxR3Qw?=
 =?utf-8?B?dUtWaXNETmVYbjY1RGMvbkJxanZ0UThNczlpN3VJMmU1NjlkaWhZTDFrRFpI?=
 =?utf-8?B?b2dwU1pZS0RaeC9ROWx5SkhOK0NOK0t0NWUzRVM1aWFKc2diRy8zWmZ5T0tU?=
 =?utf-8?B?Y1p6eHBtekJYWGJuYzlxeVRxK2hvQTVYVFFvZ1BaRHdyN1d1MmZielRWVkNW?=
 =?utf-8?B?WE1hVDBNNlJLSDdaWEtSZ3FyYm4zZ0lpdzZJd2tiajd4MUh1enErUVVNZ1pK?=
 =?utf-8?B?MzRyakdkVjhRM01YZFltQmtrTWpUWjJIWWpZNGdkdXB4SWxPSXlxOGYwWW1Y?=
 =?utf-8?B?Tmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <53A8B922585E854F98436F8DD02B07CD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e250b73-b806-4bd5-de64-08da5ae6f7b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2022 22:22:07.1125
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +cITYMpSZ4M9TlEyJtNDI3FraJgZRk+TfiTE7BqbGWdn72GMXSTm9xM+MKMU27S7ZoMAoO+KZVCHItCZvESNhtZ9vZPF9TH54GSvSFo7Q8I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB2061
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMzAvMDYvMjAyMiAyMjoxMiwgUm9iIEhlcnJpbmcgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlM
OiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cg
dGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gV2VkLCBKdW4gMjksIDIwMjIgYXQgMTA6NDU6
MjBQTSArMDAwMCwgQ29ub3IuRG9vbGV5QG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+PiBPbiAyOS8w
Ni8yMDIyIDIzOjM2LCBSb2IgSGVycmluZyB3cm90ZToNCj4+PiBPbiBXZWQsIDI5IEp1biAyMDIy
IDE1OjU4OjA0ICswMzAwLCBTZXJnaXUgTW9nYSB3cm90ZToNCj4+Pj4gQ29udmVydCBTUEkgYmlu
ZGluZyBmb3IgQXRtZWwvTWljcm9jaGlwIFNvQ3MgdG8gRGV2aWNlIFRyZWUgU2NoZW1hDQo+Pj4+
IGZvcm1hdC4NCj4+Pj4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogU2VyZ2l1IE1vZ2EgPHNlcmdpdS5t
b2dhQG1pY3JvY2hpcC5jb20+DQo+Pj4+IC0tLQ0KPj4+PiAgLi4uL2RldmljZXRyZWUvYmluZGlu
Z3Mvc3BpL2F0bWVsLHNwaS55YW1sICAgIHwgODIgKysrKysrKysrKysrKysrKysrKw0KPj4+PiAg
Li4uL2RldmljZXRyZWUvYmluZGluZ3Mvc3BpL3NwaV9hdG1lbC50eHQgICAgIHwgMzYgLS0tLS0t
LS0NCj4+Pj4gIDIgZmlsZXMgY2hhbmdlZCwgODIgaW5zZXJ0aW9ucygrKSwgMzYgZGVsZXRpb25z
KC0pDQo+Pj4+ICBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL3NwaS9hdG1lbCxzcGkueWFtbA0KPj4+PiAgZGVsZXRlIG1vZGUgMTAwNjQ0IERvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkvc3BpX2F0bWVsLnR4dA0KPj4+Pg0KPj4+
DQo+Pj4gTXkgYm90IGZvdW5kIGVycm9ycyBydW5uaW5nICdtYWtlIERUX0NIRUNLRVJfRkxBR1M9
LW0gZHRfYmluZGluZ19jaGVjaycNCj4+PiBvbiB5b3VyIHBhdGNoIChEVF9DSEVDS0VSX0ZMQUdT
IGlzIG5ldyBpbiB2NS4xMyk6DQo+Pj4NCj4+PiB5YW1sbGludCB3YXJuaW5ncy9lcnJvcnM6DQo+
Pj4NCj4+PiBkdHNjaGVtYS9kdGMgd2FybmluZ3MvZXJyb3JzOg0KPj4+IERvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkvYXRtZWwsc3BpLmV4YW1wbGUuZHRiOjA6MDogL2V4YW1w
bGUtMC9zcGlAZmZmY2MwMDAvbW1jQDA6IGZhaWxlZCB0byBtYXRjaCBhbnkgc2NoZW1hIHdpdGgg
Y29tcGF0aWJsZTogWydtbWMtc3BpLXNsb3QnXQ0KPj4NCj4+IE15IGNvbnZlcnNpb24gb2YgdGhp
cyBzaG91bGQgYmUgaW4gLW5leHQgcmlnaHQ/DQo+IA0KPiBJIGRvbid0IGtub3csIHlvdSB0ZWxs
IG1lLg0KDQpXZWxsLCBJIHdhcyBob3BpbmcgU2VyZ2l1IGtuZXcsIGJlZW4vYW0gYXdheSBzbyBo
YXJkIHRvIGtlZXAgdHJhY2shDQoNCj4gDQo+PiBJcyB0aGlzIGp1c3QgYW4gaW5jb3JyZWN0IGJh
c2UgZm9yIHRoZSBib3QsIG9yIGFtIEkgbWlzc2luZw0KPj4gc29tZXRoaW5nPw0KPiANCj4gVGhl
IGJvdCBydW5zIG9uIHJjMS4NCj4gDQo+IFJvYg0KDQo=
