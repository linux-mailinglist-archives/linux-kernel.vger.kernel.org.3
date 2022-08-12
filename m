Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D970590C4B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 09:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236992AbiHLHI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 03:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236537AbiHLHIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 03:08:20 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7767CA3D4C;
        Fri, 12 Aug 2022 00:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660288099; x=1691824099;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=n5/GI60uh/hmQy4bDVqSAfWgvfy46+66daflc6L6eoI=;
  b=BvSdMe++n9wMl+auwYxMW82xuYpffWL34tASsUCKJO8/grfvSqh0wNcD
   H5xrzNV1ci6U+M10vh8BdEKanSsq4iontlHAUGlNnQZrrhLXbzMQqIES+
   0iqT3LAnjASDekgRih0PLDxCm+yRGUiRcVkslvleFOeEMxa2S3iEML8Fl
   DxcfwEgkKQ6nqJ1b8GQGv2K0R1xjxGb0NjRApR+ad2uBWC8lnfX3eyoND
   d2v0q7fF5IQV9uxudO5PE7We/J4cc0Ox9WxlkA+e9B990936hbnRxhMxv
   aslLAhnZx4HDVmyGsjVYim23zwZi1UICu37ZRaTr671kgHcfBspiuas2K
   g==;
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="172136879"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Aug 2022 00:08:18 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 12 Aug 2022 00:08:14 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Fri, 12 Aug 2022 00:08:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HwLYtNTOBa/QvXHV/o9GcpAtvQDcLeLRxOVehjVCGTI3DdNILt7pIe6ITuo8vFAZvwje8U08rDhLO+N9A9TpaQw33BOTgTk6vuMs5bIAG/sPBD7oag0fkWdLstGe0qNkt92GA07H//h27a8KMfhEI9xxTnT5NhgCDD3hmw9j3v1EygFmIVyYWYhzzuzYw9uLxaS/yOBCJyGh9mAu0NDe8Y1NV4i7LiD/epjey0ZXtJ/X99huLYRvnthIMVdHoAo8SCOggp1TE92EPs2LhPnySxJraIEFy+Tn5CySN138gN8nDE9sqzT0jjc9/qU2HZRcqx5/Cmtd/c7TxLpn8Z614A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n5/GI60uh/hmQy4bDVqSAfWgvfy46+66daflc6L6eoI=;
 b=nb4oKzrvLzAPkID1KkbFrqNoIQ9AK+aqNUHw/TLKmuYC+CWpzt0mNq0lPpahK8iA96P8vylWJ+mkNzbxgTKgCyryK4Ge06mNNCNCGhVi/W9ey+OeVzCM5ORfU+vOoR3iapGC5bPQ5u5S//A9E3qv1Wb/iRPoPBb2ARklAplrDsHm470TQgus3kxklF2KksLGDX3O8YYlUdpqUicvE1mnnyDSCNYbrWHWcfGvCTAAo2eDg5yxWj9mTkBb2oKpdHlvHw44psMLiAD5CknH+w+q61/8+FsFNOMsU53ytJ40bKdjBgCXW7JtJOzDT1r0FfiRZDJ6QrSYNrKfegc3JFPHCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n5/GI60uh/hmQy4bDVqSAfWgvfy46+66daflc6L6eoI=;
 b=icCyFiFzW9K37/FHZeFO028nReRiW6qWOQGEwxLBERiZj7FjLR2oz1GIpUpZxdvt0RwWqc2Lxla4lQh6VQrxrlml+EletNl3Q++KJLm19UujAQr2oOYp32bLsJTI8Y36HT0E7tFKrnnN/t1VjmmGAmKvXhbdmNFc/YwARPomS9Q=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DM6PR11MB3561.namprd11.prod.outlook.com (2603:10b6:5:136::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Fri, 12 Aug
 2022 07:08:09 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%8]) with mapi id 15.20.5525.011; Fri, 12 Aug 2022
 07:08:09 +0000
From:   <Conor.Dooley@microchip.com>
To:     <sfr@canb.auug.org.au>, <linux-next@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Tree for Aug 12
Thread-Topic: linux-next: Tree for Aug 12
Thread-Index: AQHYrfGFdpGJQxbbyUS8KG8qXMKeHq2q2JeA
Date:   Fri, 12 Aug 2022 07:08:09 +0000
Message-ID: <6c2133bc-dda4-3913-f03d-10722c2220fa@microchip.com>
References: <20220812121512.2164b5b1@canb.auug.org.au>
In-Reply-To: <20220812121512.2164b5b1@canb.auug.org.au>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 614d0277-901e-42d3-7a28-08da7c31699d
x-ms-traffictypediagnostic: DM6PR11MB3561:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lKvpZ8ufYrvkkOX2zei/PulAAl16Rsd4O79ns7gEnnmM+JV8+qcGrN0EL8nXpcfUq/mf5LlFBDYu8tSP0GIO9dyl5iCkBO4AJTTMurLSr9fvUilpt6z1Nf2KGS9pCLYH3rdy1YhJUegTc4IlBnJA43/skXlGmtvsc6aiXOjY7Fto17FyTHPEEBF26A12iG/MxLZIoO3VIb9u+RHcdszCnVIojPdMRxF1PbZhKGLfAHdCl1i53T1Fn9CUB2aIHMskJxdxBtfrjiQVwhvl5Mhk85P1YoL5O/jwrqFYeJ7P3KioosTNO2d0nlC19COrjyTVfyNsyr1RqCceSEN4sJ6Drv+LUh3FEERPe/wBjYUPbHfBbZTNWB+xZy3GSxDMXvgjEv1wC+hgLUFW62LAN63uuTbAPOYGWGNbH6JtFO5cXfR3b5pFUWfsclcV4B2MpzY1OmdBZuGN2SlXfiSCWoXMPry8xBkfKtwGKdIp8Pl+T6ICF9usLOU0kqV449QlY5uw3S8fppbiuHJSfoIbCkBWdELPaWdUCnQaW3/kF0Ja8tn+pD3zj07EK6ZMdlQ4ICJe+nK80qHLY+1nl+/5sFLUIpMxlZMQvG+kevfXs5xeHypiYopuzSJQI4xpwlrU1j8u2CRBGx3UxHnW+duiqxRdpN04N0tUZiVt6iqCI76tXP+EjkBiFxKSR8CjJr93UDpKKu/NlH7YGIooywdO2FA5aD7ArkqutqSGaCchOF83rULS0CilpFvnx4UOw6qfCd8AVKxpqr65DyC9qBHiLL3fTY6dTYTCFhujdpyfaqLgxDINwFQysvRPRlTablYTAAeJLSmaHtIqjB9T3XwNuXNcrJcfHB4HRuyQLPGIEglALtiEH1opbVqPMLgl8zbpAQ64RQrGy2vO9m0nKGreZByR1w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(346002)(366004)(136003)(376002)(41300700001)(53546011)(316002)(6506007)(4326008)(71200400001)(38070700005)(26005)(76116006)(91956017)(66946007)(122000001)(66556008)(66476007)(8676002)(64756008)(2906002)(66446008)(38100700002)(31686004)(8936002)(478600001)(86362001)(186003)(5660300002)(31696002)(110136005)(2616005)(6512007)(4744005)(36756003)(6486002)(966005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dVRINVlCRGVXSm9rYUhndkRjRVFZdjIydmdJV1Z5TEJ4ZFhrRzBaVVgwRjU3?=
 =?utf-8?B?RUY0eFNPbFNIbkFSTzlFQjJ4aWt6ZXJ6aHRSbit3MjB4QzM3alZ5RzhlVU5n?=
 =?utf-8?B?ZDVrZ0VobHBUWElOcW51YWl6eU45NE9sRU5aVllqNzc5NXBmY05naTdSZmtl?=
 =?utf-8?B?THBrbm5qUGxCK0xSaEw3VDNtcXZQY0dNRXBNM0ZSWS9HVmZYQWE2VEhGQm9u?=
 =?utf-8?B?cDZuS2I0NVNQZFZ0bGYwQktKSGI3c1FlMUdnc3hJVmR1RXpFN2hhc2xGUFRT?=
 =?utf-8?B?UkN5UDJZZTVpV2Q3YnBhL3FmZ2IrbDVGNkx4SW9tVEh0cms3ekFmSHFXbi91?=
 =?utf-8?B?d0VhYndNRlJVcGpiZE9aSGZzZlNTNFJwSHJSeDR2eG1OTmNWc3AwZlNPeVIv?=
 =?utf-8?B?RVltUkJBY2tRTit6UWNuR1Y4S0FpbVNpNU45a3RVRUxmQ21qWEx6YzZoK2dB?=
 =?utf-8?B?ODF2TVpubDM5aVcxTkdnamRMbVRNUWZvYjk5aStBbkhWcENPMmkxM3hBa3pU?=
 =?utf-8?B?NVN6UG9JUzdialBxOGg1VG1YRTZxVldOR090dis2bk1aSWZ5MzdRYzE4bHdk?=
 =?utf-8?B?QTUvTXNrQjRtYXRyVFJJM2xaSDVzOW5Pa01wZVFCTkJETVgwMWNZTVZiaktl?=
 =?utf-8?B?a1Jqam1NSmJsOGI4ZGd4UmE0NmsrMnpEN2FjN2VFOEV3bllVc2pmRHo3ZDlu?=
 =?utf-8?B?cDFJZGJqN080clVQZHNwbHN4YmdCMzBSSmsyVnR1T0pMVnlTeHB4eitZUUZC?=
 =?utf-8?B?S3BaMUw2QW00Sm5pdjdZbDZIeVMzaldIQTFQVVZtdUxIMlJMdWhadjZpb3dw?=
 =?utf-8?B?Y0FiWlVOVlhRWGxGRDlScnFpSU9jZS9xd0VlK09jMW1nOFZScWdsUjlVdlVp?=
 =?utf-8?B?RlRLK0N5SG1OclhMWG0zeG5IVjVSbUt5VXRzaHZpWlk4RDJvTWpyakg4S0FS?=
 =?utf-8?B?K1RiYVY5dGRwaThJTnFUTytLQ3RNNllqeUJ4aWQrdGFhTm1nQUJFVnllbmJZ?=
 =?utf-8?B?MmwyN2V5Mlc2MjlwWFYvZitudnBPYjR3QVVkWmV4YnVYUjZRZnllTTJoRFI2?=
 =?utf-8?B?QmRDRjBCNEtYR2p4TGU4ZmVIT0t0S29leUVpUWJRNlpGK0pwQktDNmR1YmJF?=
 =?utf-8?B?UGZFOGYzQlNzVkx4ZVl0MUk4dE5XZW5NTkdvWXUxKzZPVW5raHlnMmpRQWxa?=
 =?utf-8?B?VEZlQm1vZFh3Z2NySGt3RXpCSEVPdkl5VjNweGo0dVh1YU5Ydlc2a0tZTTZh?=
 =?utf-8?B?V3JFQTc3ODNwZnZYRjU5Qzl2cjlvUlRtNUV0RlJlWmIvS0lldUlFSVNHWGNY?=
 =?utf-8?B?R3ZoMTVqbUNNenhsdktWaDF2MHlLZUJNcGVheHRiVXJycjFvMHdvb3BUNHNp?=
 =?utf-8?B?UUZiZTdoUFZ1YVR4NTBnS0d0NmxWMHlBTG13Ulc1Vmg1b1VQOWlpajVFZWVV?=
 =?utf-8?B?aEhmZ3hGN1FCSVFZRStHUDRXdTNpdkg3cWh2b2F4QW9WV2NkTWZEUm1BZytn?=
 =?utf-8?B?cDlrVlZySmNiWndTN0Irbm9MYTNHQVpEcEUwNmg5WjlhaWthbTB5QjU2eUJr?=
 =?utf-8?B?T3VOZ1NiUTA2OWdGSi9kZjlwZG5IV3NDMWVSQy9WZ2hOWEdkSVFCQXRKbXNY?=
 =?utf-8?B?aDhpdlRTZzVMRjlnWGU5SGtZWmUvZThXajFBSUlYM1NJZGFhbnZFOW9OME9p?=
 =?utf-8?B?Y1laTWt0QmMyemE5WjAxdEo2ZitVVkk5Um1LckdpZUg1RkFrdDlMaSsvSlFH?=
 =?utf-8?B?UHdRdy90TDJ4RTdXem10aTdNbjJocWZhNFBjaENheE51TDZYTjFLRzdTLzB0?=
 =?utf-8?B?QlhhUml2M01qYndNZmZkUUsydWhScGN1ZnhmSnh6Z0U0TDdhL1c4clprU3Vv?=
 =?utf-8?B?Zm5pK05MR05PR1ZKWmYzMWNJTkdaVjdEbFdJR0NRMUJlUzFjTFAvZEJJWkdR?=
 =?utf-8?B?MFlTbHpaNmhLd3JndnRNbHlQTlZwc25hcloyM29URzFvQmRhTUt3eEZhR0N5?=
 =?utf-8?B?bTFPeUVQM1VDOXBLT01MUktJcmZPMWtpak9aOWozUTNDVlJCMG12aUc3NFRE?=
 =?utf-8?B?M2V5L3VMSXNZdEIzOVVKejlVNXVuTmwvM1RVVlRiSXdlWDNTWDlMeHdTRXZB?=
 =?utf-8?Q?hqzOURf27WOY0YoWP8KBFJas7?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <147381A658FF5D4D9238DA420804763B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 614d0277-901e-42d3-7a28-08da7c31699d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2022 07:08:09.3360
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7ugUa2YdZr/J4/IcUk2EwlRud+E6TXP+ycmZa+9FpYcY3MH1ZGtzOl0UiK5IIY92Gx8Ke3dNw8o13JXyg20J9g71V7Vk0hSmuh5LsjyKY+k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3561
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIvMDgvMjAyMiAwMzoxNSwgU3RlcGhlbiBSb3Rod2VsbCB3cm90ZToNCj4gRVhURVJOQUwg
RU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Ug
a25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IGxpbnV4LW5leHQ6IFRyZWUgZm9yIEF1ZyAxMg0K
DQpGV0lXLCBDPTEgYnVpbGRzIHdpdGggc3BhcnNlIGZvciBSSVNDLVYgYXJlIGJyb2tlbiB0b2Rh
eToNCg0KICAgIENIRUNLICAgLi4vc2NyaXB0cy9tb2QvZW1wdHkuYw0KaW52YWxpZCBhcmd1bWVu
dCB0byAnLW1hcmNoJzogJ196aWhpbnRwYXVzZScNCg0KbWFrZVsyXTogKioqIFsuLi9zY3JpcHRz
L01ha2VmaWxlLmJ1aWxkOjI1MDogc2NyaXB0cy9tb2QvZW1wdHkub10gRXJyb3IgMQ0KbWFrZVsy
XTogKioqIERlbGV0aW5nIGZpbGUgJ3NjcmlwdHMvbW9kL2VtcHR5Lm8nDQptYWtlWzJdOiAqKiog
V2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4uLg0KbWFrZVsxXTogKioqIFsvbW50L2F1dG9t
YXRpb24vY29ycC93b3Jrc3BhY2UvdXgtdGVzdF91cHN0cmVhbS1uZXh0LWRldmVsb3AtY2RAMi9s
aW51eC9NYWtlZmlsZToxMjg3OiBwcmVwYXJlMF0gRXJyb3IgMg0KbWFrZVsxXTogTGVhdmluZyBk
aXJlY3RvcnkgJy9tbnQvYXV0b21hdGlvbi9jb3JwL3dvcmtzcGFjZS91eC10ZXN0X3Vwc3RyZWFt
LW5leHQtZGV2ZWxvcC1jZEAyL2xpbnV4L2J1aWxkZGlyJw0KbWFrZTogKioqIFtNYWtlZmlsZToy
MzE6IF9fc3ViLW1ha2VdIEVycm9yIDINCg0KUmVwb3J0ZWQgaGVyZToNCmh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL2xpbnV4LXJpc2N2LzZkNjc4ZTVjLWRkMTYtYWE1NC1kMjQ0LTBjZDA5NzE3NDc2
ZkBtaWNyb2NoaXAuY29tL1QvI3QNCg0KRmlndXJlIHJlcGx5aW5nIGhlcmUgdG8gbm90ZSBpdCBo
YXMgbW9yZSB2aXNpYmlsaXR5Lg0KDQpUaGFua3MsDQpDb25vci4NCg==
