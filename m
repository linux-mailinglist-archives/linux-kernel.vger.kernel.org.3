Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D2A5535B4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 17:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352471AbiFUPQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 11:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352300AbiFUPQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 11:16:56 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8BE9206;
        Tue, 21 Jun 2022 08:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1655824612; x=1687360612;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=VbcnqyaXO39hZmOsJSTyxPWbG1CqgmirBxiBAjbGIRA=;
  b=q7X/hxLU1DBDZcIN768kDJ/ENnCYwzUhyMAcuExH75ZPxj3AGj3BuNUQ
   MSz8Tj/rgC5uoYodP/3CLY93tjBPDzjJrE5dR57K+GWsRy4yaBsEpu51o
   X07zM7C9+g7kicB5W5Y6qlDo4qo1tQYU3bPgqeeaJI7AgqXNXgeaC4tZj
   4LPbKxnHLlw+5UBN1qgLTL9Hnn2TbcysK1PSVx6nRepRYz3jHimFVIvsx
   EbT05ZosTsCHrLY25ieiot9BFk9dek3xZE1WVoC7ob14ekV19Cg+4XRl2
   nivsk5T44NHLhxfAw0IE4e2Gl4P/7CfxjLyh4tjVMBR+We0eyvo2xYzxU
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; 
   d="scan'208";a="164394590"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Jun 2022 08:16:52 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 21 Jun 2022 08:16:51 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Tue, 21 Jun 2022 08:16:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vf0nbgO7O7XyXetHYs2TKlvBw02jfWrsifV7V0KdMMYG58L5l1RE+Oo6QL5cOIpBXfhqwxyDI5RJF2S5qHjjjj3JMUd6wzZXEWHfuQlG1ADaawatWjAs8bflUYkHxftLTnKP6SsDQ4DsSUwn+M4xp0HL83mbleoHKH6sZZxMryhbNc6HeA+1PvVEKXTk8te+L60l7s5zVxFqAyt8gUO6+VxzTMjz241xtVAGqTZkkUbmv12oAk2FO603vFXro2DVYQGFoc15eO4cu1j1LTNpCXYLDwKPEfFOQvyYjarst8LR4e3/lNi35uVMUX3xJmOenxxssxWri+HMcfgwXWwYTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VbcnqyaXO39hZmOsJSTyxPWbG1CqgmirBxiBAjbGIRA=;
 b=lrO7A7xD12IGn43HIEFE1fvjQl2cYmYpkqpAJgozZ3yr6pPOZ8WbcioLxGgxz21fddCRfminIs66pSQd9IQbASGgViDmOtyiRRTd9oprBVyP/tmRtg5S4CRV/gPLBhxed0ZhI0pMhHingebg9irzlUvSWt4oMFMakkHUxae27IHEeuM8WnQHrsCf1AD4W7aEDnQeazy+F1Dzd9DetDA86SJK7RU7VTQUnsTRCNgmLF/lxr9T4ascBFQB7o4iFCf0FnsiVi6GIIMEJsGiYYwwWV2XtQz87DaV9p2EvU7oA38OivzDdhd+Oh6RUXvAS++DLDIlzVwJjoY/f5DIQwpllg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VbcnqyaXO39hZmOsJSTyxPWbG1CqgmirBxiBAjbGIRA=;
 b=ijnkL2MJibNM2xG55oa/bLLPmzcAXniS20HxQ5OBNNoMTICgNbhwbGZYNGUvWQ0ooK910vnBORKrRZh2lqd9gPdBLfG2ioki8kapJPmuv1PAdNVSdkXsRcfSUzerO+REW5nnXwhxVNUaaACf1/ue7QgVhbqxTkXSy1D2sKyh9hc=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DM5PR11MB1819.namprd11.prod.outlook.com (2603:10b6:3:10a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Tue, 21 Jun
 2022 15:16:50 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa%4]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 15:16:49 +0000
From:   <Conor.Dooley@microchip.com>
To:     <gregkh@linuxfoundation.org>, <Conor.Dooley@microchip.com>
CC:     <b-liu@ti.com>, <Daire.McNamara@microchip.com>,
        <Valentina.FernandezAlanis@microchip.com>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <ben.dooks@codethink.co.uk>,
        <heinrich.schuchardt@canonical.com>, <Nicolas.Ferre@microchip.com>,
        <Cristian.Birsan@microchip.com>
Subject: Re: [PATCH v2 0/2] Add support for PolarFire SoC's musb controller
Thread-Topic: [PATCH v2 0/2] Add support for PolarFire SoC's musb controller
Thread-Index: AQHYfxuMNjzv9qrP8E6NLA6/7ruhLa1Z+lWAgAALTQA=
Date:   Tue, 21 Jun 2022 15:16:49 +0000
Message-ID: <6c9001fa-5315-c9f4-b7b9-05248635750d@microchip.com>
References: <20220613114642.1615292-1-conor.dooley@microchip.com>
 <YrHXZYe4e4vlCHh3@kroah.com>
In-Reply-To: <YrHXZYe4e4vlCHh3@kroah.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 07e3f16d-977c-48a3-bd56-08da5399102b
x-ms-traffictypediagnostic: DM5PR11MB1819:EE_
x-microsoft-antispam-prvs: <DM5PR11MB1819326634A85ED49899964F98B39@DM5PR11MB1819.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ut82L6pCQlVGJdLN++vt9TEyjfkDZJqrSvuYJF+B5FhePyJSo8VGusbWOApQ/xFsnCxRz3HnTEMKMAQu5dokBad3QL3bjdXY6CcyhUhOe3ErE4HLX0cj2oyetFQF+nALrzU5K8nHOW8So/sZvRzpZS1lVwEYiE0lXKBJN2JauL7SpdTyp/0EKU9g4b4pkAEBV9+uboJa1LR5PfvyDV1kqV29Vk0eCs0IM7W3MCngqVuiSc32NcQnXP042pjsG1GDBBp58DV9EC8gAPOGqUBR+2Kqc4XbZAle7HyL3Y5zyQ+AAuP/tjVNZbMFz7qkedodZkRgpuEYnq4fLnGpzGedaYXFms8eDYF/NAjdQ/ze/qI72tJoK8hHKOHfMDYc3aUHHPyexTLAlqMKXZOLpsdWNpWRYaxlH0qivtPE9GCSvaCkA/A33dU/LpQAhVYtlI5OhRj+PTt/3liozza97w0sKYN3jGzCssh8pEWQ4NNGJrocOOvIb3+JI7oaGcaZs9tMt0y7HGAMvO3xRfb15aI+ALB53YhyP4Tp6UnI0Fa6If5OY5lkRtljz7FBz8hhAdsccakZ1dGvGiXQ9clxesfWz89S62iSZAlcaP/YX5K61O+IXe9P5IKLZxHKkD68lSFO5tOZ7VIvYosvrk45JNV62nRX9qkEhqmy06uVeRkVd1e8IvWx/C37ini44I5XucC0uJkZF9ZqAfk1JhsbWd2q4bjOddXfb+vRbDdMaummwu2lAGhpuaD0QyL0tSogy8GgGKYLzKaGt0+I5d21sxsdyOxB8kR3CMHVJ5n0FYN879pZK6qgzKxG1yhrmI595oHAX1TmJomhEObvZx7Lo39Q8l6KDaHOLWwFb8iYsKeP33U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(39860400002)(346002)(376002)(366004)(5660300002)(38070700005)(4326008)(8676002)(66556008)(66476007)(86362001)(66946007)(54906003)(8936002)(31686004)(36756003)(6486002)(478600001)(64756008)(76116006)(2906002)(316002)(71200400001)(66446008)(110136005)(91956017)(6506007)(6512007)(53546011)(26005)(31696002)(107886003)(2616005)(38100700002)(122000001)(83380400001)(84970400001)(186003)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VXp6NDdaQnJJWXlqQWg2QXhuY0VXWlVveVJrREJPeDNwM3ZoTHdwdnRGc2hJ?=
 =?utf-8?B?bWlhTk5wTFBsdkFKTStKdER6OU1xV0wreHdXUHhnVWN6Uy9rNk8wZmJ5c2Rt?=
 =?utf-8?B?R3lwQnlpbkZDUldyektiQjVrVEtPVEdDYjI5SWxHVXVZVnUwQkh3ODBZWERk?=
 =?utf-8?B?U0ZOSVZNWGNBOE5xQ1JudFJFSURRTzBPSE5xNzFQQ0syTFRWMDdIaWg3VzZt?=
 =?utf-8?B?bnArUURXV2c3dnNDeGNDdTZpZmxORjl3V3l2U3MyWFJ2cHQ5ajhSd0VKTmZy?=
 =?utf-8?B?THVsai95NGp4cVRmYkluQVF1NmVYQkY5QTI4bVZtNnFNaTJtaU5TN09rM25U?=
 =?utf-8?B?ci90bnFCVkhOd3QxdXNTcGoyRVNxSWFvT0Z6Qlc1VGJmYy82YkYzOHdBcUd3?=
 =?utf-8?B?MDd4enl0L2lwdk9wSmlTRy9NczI5L2xXcjd2SkxsQjIwSHhvK1RQQS9URXBY?=
 =?utf-8?B?eVVsNzJ1K1U3SEJQMHBMcUZOT2dhMVBxR1JHR2Zta2FvWkd0OEtxYXowOU96?=
 =?utf-8?B?Q1ZwWFhyR09hZERXTkhXZVgrZTI1YnVVelZjOWcvem1qTDJZNStpRFlUU3Zq?=
 =?utf-8?B?NTJESVc3R010Z0lEYUE1NzFTcSsyZVpsNjM2VTAvOTFIcTlIbnVsZS8wUHV0?=
 =?utf-8?B?YzZnQ2pWWGlqbmhJdzBTVGordjB4dE1Sd3BGc1hicjFRa1diNEdoZ3FPU251?=
 =?utf-8?B?M29LT3d5cUpLR0xLcG5vaTZobmZzL0hvaXI4NGE0S0xNbmwvMUdkU2ZCTURt?=
 =?utf-8?B?NXRHbkNoWjkrYzF3ZFpYQXpBM1hjVE9jTlRiWWdJRmYvOW5Tc1lQY2JWTjZB?=
 =?utf-8?B?MGFoZk9LLzZhU2JxR1M0SzhOUTJnM084ZEM2Rm02K0tmNndlL0tSd09zMDdW?=
 =?utf-8?B?K0FaN3BxTXZlVFFNY2NydEMyY0hPUFRGV2lXSEtUTVRFSHllKzNLTW5Ic2pD?=
 =?utf-8?B?aWk1UlMvVkd0Q2MyMFlPV2VtOGF1dnpVRVpFc20zMkMxUXBlRFZ0aDFoRXVu?=
 =?utf-8?B?Z0Rkc0hLZ1NYcVhNQlpxMkI3Y2xLaXdIS1NuSTExbXFzcUNvNThMQmd5NVdZ?=
 =?utf-8?B?VVJOVSs0czR3azA1a1JRd0N0Vy9TVVQ3eWIvRnpNanhoZldSTGZ6SHVyeElX?=
 =?utf-8?B?emVpZDVUdFQ5S0hLT0xuVW5GeXM0b0pucTBxVFlGdzdyc3VYTHE4SkNmaXRQ?=
 =?utf-8?B?eUhhWEQwaWsxVVB6eTcyMHhoZDFVdFhYWGpUSHQzSWJScSt0bEVLZUI1RVpK?=
 =?utf-8?B?RGYxV09aQjBpZStOUnpjeThVdnVEOWFEME12M2dOeEVGUy9oeUpIdzJqU25y?=
 =?utf-8?B?V1lqdE9wZEtGQ0JrdWNwOWRTV0lrYkhmdmt3SGtMKzQ0NU5pdFdCZ0lwajhs?=
 =?utf-8?B?WUs1bWkvZkFiMkg4UTB4UUNXeWZKM2lobWJ5SEoyVE1yR2dvTXQyNUVhTzBo?=
 =?utf-8?B?eG50ZCswOENOTU5KWFJ3WHBpQ0FWbDhVTXcxS0lsZnNEZmQxNmQzSHFXWURS?=
 =?utf-8?B?bCtqZW1oUjZUVDdUWTR1SDFqdjNqdk1pVENoeDMvUVl4WjZsbEJ2c0F0MW5x?=
 =?utf-8?B?WFM2U3FnK1JnZjRSVVM4T3pUQTZhd2lGUmo2bXlKdXN4YU93SlNpUlV2VkFr?=
 =?utf-8?B?NHM5aDYwMFFFVXpPUUhsUUxuWjY1aitzRnprcHdvcDlHdlJVdllWbFVpQTBt?=
 =?utf-8?B?S3pHMHZ1WlJFQkFsL3NIOU5wdldwQy92aEZOcC84OWM3bkJNc2s5QmtXSmxF?=
 =?utf-8?B?N1VUR1liUXlYeWtoMS9MOVdtSXI3ZU1McnBFaW4ya1AxRmJ4OUZjMTZrMmNT?=
 =?utf-8?B?SXZDLzY4NHErTkJ3NWY4bGtiZXFvQ0pjNkFwamNQdjRrMkJjT295cWh5VTJJ?=
 =?utf-8?B?bVB4OXdieUlNNlBER0c2V0hmOTJnV25nSTZSNU1TbTlMYy9SeVRsRWNqbktn?=
 =?utf-8?B?VHpvdStqeUJWeW9EWTQ3bW5xVlRWdUlSYnNTd1BWd1M3Zy9uK1dxWHNLcmhD?=
 =?utf-8?B?SnhVQmF1anllcy9LOUdwSGE2SG4xYWxKbG1oeVYzNzVjTWxUQzREWjNSZzRu?=
 =?utf-8?B?ekNLWXpzN2VyQkwwWDJ4VDRad2J3a3NRaER1TEdNdGp4SzJiNEVEdHdUQ1Ey?=
 =?utf-8?B?cXVTR2NlYm1JbVNGZm9VRGlvWlJOUGRuL1p4WTd2bkk4NldUZ3BQTWNDakcv?=
 =?utf-8?B?NiszSGtMMHBqOUNOcFhGeW1rV2pHMklzRmVDR3o0VkZaMXEyOXUyUXFqaFVn?=
 =?utf-8?B?QlhxNHNlS2I3OUJqRVVKaDJIMEQzSVpTaG5jUzhDckw2cnFJcTlIV2xFaFRO?=
 =?utf-8?B?dzVNTSs5NkNVZ2dWWlBQdnJpY045amlXWlVjSko1T3BOSThBRExqVkJQcHVs?=
 =?utf-8?Q?QuOASvDenHkzKqnM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BA07E6A2686255479CAD33D91D6023BC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07e3f16d-977c-48a3-bd56-08da5399102b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 15:16:49.2125
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8CacKwwdo2byDlMUf/4OKZ3Wxn5qqMvl+0HzcjAmI1jMo4Uq0EWIxZMPOqTVKTaADe2xiRukz3txKbbKeNgdf7v/o7zSsfhy7RhQSoSsG2c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1819
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDIxLzA2LzIwMjIgMTU6MzYsIEdyZWcgS3JvYWgtSGFydG1hbiB3cm90ZToNCj4gT24g
TW9uLCBKdW4gMTMsIDIwMjIgYXQgMTI6NDY6NDFQTSArMDEwMCwgQ29ub3IgRG9vbGV5IHdyb3Rl
Og0KPj4gSGV5IEJpbiwgR3JlZywNCj4+IFNob3J0IHNlcmllcyBoZXJlIGFkZGluZyBzdXBwb3J0
IGZvciBVU0Igb24gTWljcm9jaGlwIFBvbGFyRmlyZSBTb0MgRlBHQXMuDQo+PiBUaGUga2NvbmZp
ZyBkZXBlbmRlbmN5IGZvciBJTlZFTlRSQV9ETUEgaGFzIGJlY29tZSBhIGJpdCBvZiBhIG1vdXRo
ZnVsLA0KPj4gaXMgdGhlcmUgYSBiZXR0ZXIgd2F5IG9mIGRlYWxpbmcgd2l0aCB0aGF0Pw0KPj4g
VGhhbmtzLA0KPj4gQ29ub3IuDQo+Pg0KPj4gQ2hhbmdlcyBzaW5jZSB2MToNCj4+IC0gRHJvcCB1
bm5lZWRlZCByZXNvdXJjZSBjb3B5aW5nIGFzIHBlciBSb2IncyBjaGFuZ2VzIHRvIHRoZSBvdGhl
ciBkcml2ZXJzDQo+PiAtIERyb3AgdGhlIGR0cyBwYXRjaA0KPj4NCj4+IENvbm9yIERvb2xleSAo
Mik6DQo+PiAgIHVzYjogbXVzYjogQWRkIHN1cHBvcnQgZm9yIFBvbGFyRmlyZSBTb0MncyBtdXNi
IGNvbnRyb2xsZXINCj4+ICAgTUFJTlRBSU5FUlM6IGFkZCBtdXNiIHRvIFBvbGFyRmlyZSBTb0Mg
ZW50cnkNCj4+DQo+PiAgTUFJTlRBSU5FUlMgICAgICAgICAgICAgICB8ICAgMSArDQo+PiAgZHJp
dmVycy91c2IvbXVzYi9LY29uZmlnICB8ICAxMyArLQ0KPj4gIGRyaXZlcnMvdXNiL211c2IvTWFr
ZWZpbGUgfCAgIDEgKw0KPj4gIGRyaXZlcnMvdXNiL211c2IvbXBmcy5jICAgfCAyNjUgKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4+ICA0IGZpbGVzIGNoYW5nZWQsIDI3
OSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRy
aXZlcnMvdXNiL211c2IvbXBmcy5jDQo+Pg0KPj4NCj4+IGJhc2UtY29tbWl0OiBmMjkwNmFhODYz
MzgxYWZiMDAxNWE5ZWI3ZmVmYWQ4ODVkNGU1YTU2DQo+PiAtLSANCj4+IDIuMzYuMQ0KPj4NCj4g
DQo+IEFueSBjaGFuY2UgeW91IGNhbiBnZXQgeW91ciBjb21wYW55IHRvIGZpeCB1cCB0aGVpciBl
bWFpbCBzZXR0aW5nczoNCj4gDQo+IEdyYWJiaW5nIHRocmVhZCBmcm9tIGxvcmUua2VybmVsLm9y
Zy9hbGwvMjAyMjA2MTMxMTQ2NDIuMTYxNTI5Mi0xLWNvbm9yLmRvb2xleSU0MG1pY3JvY2hpcC5j
b20vdC5tYm94Lmd6DQo+IEFuYWx5emluZyA0IG1lc3NhZ2VzIGluIHRoZSB0aHJlYWQNCj4gQ2hl
Y2tpbmcgYXR0ZXN0YXRpb24gb24gYWxsIG1lc3NhZ2VzLCBtYXkgdGFrZSBhIG1vbWVudC4uLg0K
PiAtLS0NCj4gICDinJcgW1BBVENIIHYyIDEvMl0gdXNiOiBtdXNiOiBBZGQgc3VwcG9ydCBmb3Ig
UG9sYXJGaXJlIFNvQydzIG11c2IgY29udHJvbGxlcg0KPiAgIOKclyBbUEFUQ0ggdjIgMi8yXSBN
QUlOVEFJTkVSUzogYWRkIG11c2IgdG8gUG9sYXJGaXJlIFNvQyBlbnRyeQ0KPiAgIC0tLQ0KPiAg
IOKclyBCQURTSUc6IERLSU0vbWljcm9jaGlwLmNvbQ0KPiAtLS0NCj4gVG90YWwgcGF0Y2hlczog
Mg0KPiANCj4gSWYgSSBkaWRuJ3Qga25vdyBiZXR0ZXIsIEkgd291bGQgdGhpbmsgeW91IHdlcmUg
c3Bvb2ZpbmcgdGhlIGFkZHJlc3MuLi4NCg0KR3JlYXQsIHRoYW5rcy4gSSB3YXMgaG9uZXN0bHkg
aG9waW5nIHlvdSB3b3VsZCBtYWtlIHRoaXMgY29tcGxhaW50Lg0KSSBicm91Z2h0IGl0IHVwIHdp
dGggb3VyIElUIGJlZm9yZSAmIG5vdGhpbmcgaGFzIGhhcHBlbmVkIHlldC4NCkF0IGxlYXN0IG5v
dyBJIGhhdmUgdGhlIGRpcmVjdCBjb21wbGFpbnQgdG8gZm9yd2FyZCA6KQ0KDQpJIGNhbiByZXNl
bmQgZnJvbSBhbiBhY2NvdW50IHRoYXQgZG9lcyBwYXNzIERLSU0gaWYgeW91IGxpa2UuLi4NCg0K
VGhhbmtzLA0KQ29ub3IuDQoNCj4gDQo+IHRoYW5rcywNCj4gDQo+IGdyZWcgay1oDQo=
