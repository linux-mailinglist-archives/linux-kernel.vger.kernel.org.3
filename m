Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 279884D1EF6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 18:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349140AbiCHRZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 12:25:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349160AbiCHRWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 12:22:41 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F5554F8B;
        Tue,  8 Mar 2022 09:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646760034; x=1678296034;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ue7r6f7vH/7B0nKHAlD11EW09kMA/0gqPRR8g30ZNJ8=;
  b=GmHN2TB52QlAG84remm4jyuLKTIBUiVVLkSbmsO9QjWllZULBlkInwmm
   XWG7BHe/oofCo+VZ2mzvDBxtDCaW9ozzXBqAt89O/UEgYat5kjjN8DTM9
   mh98zTAGWKD9xrclKsdAmD4w+baliNQlrDJP/QbDU024iRYDgGVmpdttV
   cok+kqdmRDa25zAaQ9yomqZ+rVaZxkxe+EyS6OAmtOufBF08N/Ru2IGci
   0XmE/NIZT22ARNW/qDZn5UAVWLDQJaqlEXN9rIl8fDKbb10SXBdw5u3P8
   rpIGAIlb4xhN//ZI31ULvANbzO5YjbMmVaVdMPL3SNNO302wbe1WtbJ5O
   A==;
X-IronPort-AV: E=Sophos;i="5.90,165,1643698800"; 
   d="scan'208";a="164968694"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Mar 2022 10:20:31 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 8 Mar 2022 10:20:32 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Tue, 8 Mar 2022 10:20:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TRObmCR3EJZxa11Xh4uJiIQC8DziOpAgwnBmPW2xSvKxHBKq4UfJPf2i8YS+n9b2nLkpEePmQItVtLFFMF794oHTxWSPli96um7Ck2wp60JEQStR+pYUxXc4LCDz3PK2u2vGxbzRNsRx40Tn2ApDDJ9F3Mw4HwMdH2I4nWk0b2LGQoV77eHcETonsbgu5bypHniTgGH306orkwU7tOFErSqZrT0wcpV/Y5cdNekWbUnrdii6do2Mkjon28nHwqw4x28G6wCSieD6Zc6VVMI4sggcyz9mconcqaLj5WRQVLKNaQiKvFKqaanHA9bePTSkAkVEmJYRuNhJvmBoXJMkhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ue7r6f7vH/7B0nKHAlD11EW09kMA/0gqPRR8g30ZNJ8=;
 b=cqMD8UOoMJhhhpySiNmAAR3HL0T/Yv15X1G/NeEIxfp2jt8he6QK/s1Sr9OuifA04Imc72R+XVFb0bZ0/VoXoWizsYTRtjxDN5thzU+4n6v3BrMIuR29zeJkwpRH0IygQZzzj5LffHZvVupvE9ilj9G1m0BSU/smaOQSx6RgZ8g/KxN6/L0mG/rXy3rvo7CnqY+KIwCR/L17bWMCo2My8L6O4goK6mJ4KcwxQb8ejXqmENKRTQ+yVb/ELy1/vl7dom87W62tPVZBID2JekrPMzXiz+LqpH5CRvynLo/pIAfqh2LzurdQGGD8W9qHLuFJu46s02/hZ+leErCdifR9jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ue7r6f7vH/7B0nKHAlD11EW09kMA/0gqPRR8g30ZNJ8=;
 b=Yf8FuUgFS3xvTm/Y/r9Lm+CoDpSQ/mJ6y7o4NbdYvIjDtedopIXF5V7j9313Za+4WkkSCeqD3zbCT/sZob5Up/ooT2hnzq4jK0vBuegQtg1DO/YTMSORHjrKPWnlD/8ToUbH5NiHZYZvLKH+LQj4gYNGMEKibwaGOoXuKSA7dp4=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by PH0PR11MB5612.namprd11.prod.outlook.com (2603:10b6:510:e7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Tue, 8 Mar
 2022 17:20:30 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::dc94:3c7c:8ef8:21b9]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::dc94:3c7c:8ef8:21b9%6]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 17:20:30 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <Sergiu.Moga@microchip.com>, <a.zummo@towertech.it>,
        <alexandre.belloni@bootlin.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski@canonical.com>, <Nicolas.Ferre@microchip.com>,
        <Claudiu.Beznea@microchip.com>
CC:     <linux-rtc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/4] ARM: dts: at91: Add the required `atmel,
 rtt-rtc-time-reg` property
Thread-Topic: [PATCH v4 1/4] ARM: dts: at91: Add the required `atmel,
 rtt-rtc-time-reg` property
Thread-Index: AQHYMxDP8Pg8RfJRBUy6WtxY10T34w==
Date:   Tue, 8 Mar 2022 17:20:30 +0000
Message-ID: <b056b4e4-dc7e-be6b-5013-01c959cad95f@microchip.com>
References: <20220304161159.147784-1-sergiu.moga@microchip.com>
 <20220304161159.147784-2-sergiu.moga@microchip.com>
In-Reply-To: <20220304161159.147784-2-sergiu.moga@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8d7c3fc6-913b-4742-d505-08da0127f23b
x-ms-traffictypediagnostic: PH0PR11MB5612:EE_
x-microsoft-antispam-prvs: <PH0PR11MB56129B91CAA99A2D441AFB65F0099@PH0PR11MB5612.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wvqb/jawHcDjyMuxbWnrFxYUGK4OztWZcGcXUgM26z5KQ7x+TWuQpjAiH7SQcttG4FJ2xRovlsdZe7CSyy0shSbAnmn9NrtoEONiDxPU5LrmwfycYR5K1zwsIdXR9Yk5KW9Dp6tBjTDYw+RCrIOu+ucf/qvxXggYfkuOitdKLMw+f6jVWY3Onp0vp5dvNgHNPfyu0A5nxUJiVRO1VYeQUSxiTF763ze5WlFIOhpaH1tUO6EwRMwIuy/D3UsV6u17nPxdCTyaK4vvTPxr5FUEt2+ZMTf81GTs0fcUEyKAUfA9kLoy6Sn07Rfevhpj3vyTu93x0KRzjYgyorxAteVxCS9Now71R7HemjNSzqpqSMbszipvT++LIZjX8d2BKGfoYRSVCYASu2ToORuH4Qeudezdl+3P8AlXUmGOyjqHz+kQAZeGtaXY/vj9TfSeFuxPCJhfq2yrhuINcYFT8/E9cjFyFJn2euY+U0XzTm4eNIgjduXOVQlBNJNe9C4Btp+NmcGky1R1cORqnTaxV8JNTj5f3+Lad353sd/1OUSbNRSSIn8PV/WPfanB5tM60WUCllILQBqhPU7/jSvFfniFpQKHTjHx/nx4ZZp0bmgncL/Ar2IDgjpr/JhiHXIiCCaAiLT4WMgibcGHpNseI3COXAqeTXTPL3S6bHkUD1OsaS4bUVGPB0NGKp0Zyov6yhu2A+TLRgYmcMI4sYz//h4WSgebcKTAK/zYHiaPTEeUBwTAubwSnHJyqqi7BCzA4ppDgISry4e8tBGp8cAw7eS2yKeuihMuhgzAXI2UroCz8l9z6GtlxXIoR2Q1/npZnO7BGWHspnQfeuR2mON+DEekeDG2bqf+18hyQMLSKyXbym+cBRwTMA4Or4UpTQw6PHJu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(26005)(8936002)(31686004)(53546011)(110136005)(66946007)(66476007)(64756008)(8676002)(66446008)(54906003)(6636002)(5660300002)(186003)(31696002)(36756003)(966005)(6486002)(2616005)(71200400001)(2906002)(122000001)(86362001)(6512007)(6506007)(66556008)(508600001)(76116006)(38070700005)(316002)(38100700002)(91956017)(81973001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TVNLZ3VSRE4xTmRSNE91dHE5ZnR1clJFc0t4angxWDNiaHhteUFQOWdNR21W?=
 =?utf-8?B?VGdKRm5CZ3NXSnhacXgydTR1Q2JvU050OGpQbFpzWTVSV0RMWXVSZDJmckFj?=
 =?utf-8?B?RDlKbEZRK29tY2xPVU41SEo3aDJtTEcrQW9GM1M4UHdSWlBnYWpUa2J3OWs4?=
 =?utf-8?B?em9PNU5oTU1acTNIR0hmSzdEYVZXNHg0TzVTY2p0cnEwM0FpMVVmR2pPVnZv?=
 =?utf-8?B?U3NlVnRoM1p1Z0treUlERjRvaE5qUE5vdDhQNGlUL0pLdTRKUDR4cC9GdlBm?=
 =?utf-8?B?azU1amRrY3VpM3hDUjQ5RHNQYWxNU25JdUpRMXJweXJSV1BHcmtONnJBVWFh?=
 =?utf-8?B?NXk2OFpldU1qbDJDYUVicHY3QXo2ZFQ0djJIejhFSUlRY3QwTlN2a2J0MFNS?=
 =?utf-8?B?Z0tSU0svK1pKZmFXNmlRRnVzSS96R0Nwd1ZScEVDbThMU08xdythRTJwOGVW?=
 =?utf-8?B?RERxQjhaVHpGbUhRNEc2Vk1HbDZLMk8zVXQzOWZZK3dtVDVqMDlQejZFQXFq?=
 =?utf-8?B?dmNZeGxDTEhGZUdoUVlBeWx4WDh3OC85bnNXSzVhVlBMS1lVN3NyZUNiNHJO?=
 =?utf-8?B?SE82OVpadThjcjdUZk5aYkhzWGJHUnA2eGMyYTRrYng2bUtqd24rOG95WGdY?=
 =?utf-8?B?MzBrYzlEZ3RPeEY4SlhKcEcwb2pxa1hQYUlyMkRFNHE1MFZEa2ZnN1NMQXcx?=
 =?utf-8?B?NGJWbHV2SnY2Vk44LzEvcVZ6SUVSZVJaeDRRTW1TeGt0T1pMcXNySFoybm4y?=
 =?utf-8?B?YkUrajRzeXlERGY0bXpTdlZPVjdlZkxZRk5BQ1h1UkdyQUlwNk95cXFEdUh1?=
 =?utf-8?B?dVBUdTAyNytYeWtCZ1hBZWFsVXJGcTdHT3hCUVNRbFMwV3hrOW1SVXY3UTNZ?=
 =?utf-8?B?eTVmR0tLQWk2WHBwWVhYdWNldjlzaHM0UGt4dDFmZ0hjNTFYRHFsVTNJSjg0?=
 =?utf-8?B?bVdVSUdMRmdVSUZOWFN5RjI4ay9qaDFVNkRyYWprYWdRb2RqTnZodFZVWDFJ?=
 =?utf-8?B?M1FKaVdjdkI1THBuUXkrN1J3QzhQbGhhNXJ1bGk5Ui9pZEhCcTJHNWZINWJ0?=
 =?utf-8?B?R0VjdXNmUnUvSHFHRS9HWmFoVi9MYWNKQVlvZEhXeDhjNHBubFdxWGZ1Mk9j?=
 =?utf-8?B?QTFrOTU1Z3I3UldhbXBDQ3hVc0s3bXdZdEtONlliWTRYVDJ2Q09XazZZRFcr?=
 =?utf-8?B?Mm9zd0MvU2RvbnF3OEMyZFRhVC9lSXNwUERXOEhBMTJXWVMvUnA5NElmRUph?=
 =?utf-8?B?RnpMblNVd2JhQk5RQ2MvWUpQOE53ckFVRTBEQkZHT08xS21vQ3RzclN3VkpD?=
 =?utf-8?B?V09WWlRGOWJXZGlacWNaUmVidkhGZmxQNHdnWHdlbFg3MkJPVE1UazRRY0Z2?=
 =?utf-8?B?M3JId2kzOUswOEZqU3FOOTI1M0lPOVBvVWlBZ095MWwxa2RHOEJqV0x3QlZa?=
 =?utf-8?B?TVlhSkhRSUx6T1NiYTVwd21ueVB1Vk1YaHlKZGNaUWtZalhrNUU4LzFoS0dp?=
 =?utf-8?B?SXhsRlRhS21PaStPRlpuT3hjbXhhOTFxMFNhNk9xSXU2bHViTldOWndHd1V4?=
 =?utf-8?B?bEJxbmxSL084UWI5YkVKbGRVK2FDZHE2ajk5dGhDRmV0WEw4MFBnRmxjZUpQ?=
 =?utf-8?B?aVpac3VvcnhnT3lPTUZBNm5qNy93WFYxbUlXaG5ISFgyNjNlRzd0T011RUFK?=
 =?utf-8?B?YkpLMzRVanNWcG5GbzFpZlJ1WHIvd1pxRHJ0WCtRNEVCNTNOYkFyTHp2K3Mz?=
 =?utf-8?B?OXIzUU1wbm9OSnFGWDY0LzBGY2ZNZEVkODF1elNaSDRZcUR5bE1vRjdmL0x1?=
 =?utf-8?B?SEV3M3I4SWZyWDlLQ0M3b1dUeTFrUWhzdnFXUUN6TWkyZUU5djdSZlFaL2Rv?=
 =?utf-8?B?SmdUUTN2bTY5U3NuQ0d3dUllY3g1djNlSmpMRkpjcS9GejYrQklkZ050aGtn?=
 =?utf-8?B?QkppakFFRDB4LzY1U3VmT1BBaG91Q0hpdUVUNm9sMW90c1BTWGgrVndSSVBs?=
 =?utf-8?B?R3VsNEYrYnRIQ1NMd21TSFJhSCtYU0JkM2dLRE9DQ010ejRYRHpXdGtKczV0?=
 =?utf-8?B?QVpseWZ5cjR3RWpnR1BIajJUUlkvOXF2VzdXa1U3b3F3VFEvM1NjK3c4YVJu?=
 =?utf-8?B?QmZUSEJyWlJVT2RGU3FnVVVCRlMyK0JqMHJoUHZYeGxEODFPVThMVXpIU0ov?=
 =?utf-8?B?MDRUYnBrRE5uR21wazJudlRGbERNR1pqQkJlRWhaS0Q4dGdWTm44cHpMeFpF?=
 =?utf-8?B?S3N2eVFQanNadS82RUtLNzF3bHh3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6300BB85265D3F448803B9A496EE7CAD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d7c3fc6-913b-4742-d505-08da0127f23b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2022 17:20:30.4456
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1O3FVZpBujNe1DKviSDEp4lZexJOc5lU9d4tMES1CXTvuj/EMc26tkegDPQks/Y4cUq7au57cWGczTAE7Z5wO9NxDNQ5pSmQyAAeBBqIyuQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5612
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy80LzIyIDE4OjExLCBTZXJnaXUgTW9nYSB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6IERv
IG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUg
Y29udGVudCBpcyBzYWZlDQo+IA0KPiBBZGQgdGhlIHJlcXVpcmVkIGBhdG1lbCxydHQtcnRjLXRp
bWUtcmVnYCBwcm9wZXJ0eSB0byB0aGUgYHJ0dGAgbm9kZXMNCj4gb2YgdGhlIGJvYXJkIGZpbGVz
IHRoYXQgd2VyZSBtaXNzaW5nIGl0Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogU2VyZ2l1IE1vZ2Eg
PHNlcmdpdS5tb2dhQG1pY3JvY2hpcC5jb20+DQoNClJldmlld2VkLWJ5OiBUdWRvciBBbWJhcnVz
IDx0dWRvci5hbWJhcnVzQG1pY3JvY2hpcC5jb20+DQoNCj4gLS0tDQo+ICBhcmNoL2FybS9ib290
L2R0cy9hdDkxc2FtOTI2MWVrLmR0cyB8IDQgKysrKw0KPiAgYXJjaC9hcm0vYm9vdC9kdHMvYXQ5
MXNhbTkyNjNlay5kdHMgfCA0ICsrKysNCj4gIGFyY2gvYXJtL2Jvb3QvZHRzL2F0OTFzYW05cmxl
ay5kdHMgIHwgNCArKysrDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKykNCj4g
DQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9hdDkxc2FtOTI2MWVrLmR0cyBiL2Fy
Y2gvYXJtL2Jvb3QvZHRzL2F0OTFzYW05MjYxZWsuZHRzDQo+IGluZGV4IGJlZWQ4MTk2MDllOC4u
M2MxZjQwYjRhMTNlIDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9hdDkxc2FtOTI2
MWVrLmR0cw0KPiArKysgYi9hcmNoL2FybS9ib290L2R0cy9hdDkxc2FtOTI2MWVrLmR0cw0KPiBA
QCAtMTc4LDYgKzE3OCwxMCBAQCBkYmd1OiBzZXJpYWxAZmZmZmYyMDAgew0KPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHN0YXR1cyA9ICJva2F5IjsNCj4gICAgICAgICAgICAgICAg
ICAgICAgICAgfTsNCj4gDQo+ICsgICAgICAgICAgICAgICAgICAgICAgIHJ0Y0BmZmZmZmQyMCB7
DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYXRtZWwscnR0LXJ0Yy10aW1lLXJl
ZyA9IDwmZ3BiciAweDA+Ow0KPiArICAgICAgICAgICAgICAgICAgICAgICB9Ow0KPiArDQo+ICAg
ICAgICAgICAgICAgICAgICAgICAgIHdhdGNoZG9nQGZmZmZmZDQwIHsNCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBzdGF0dXMgPSAib2theSI7DQo+ICAgICAgICAgICAgICAgICAg
ICAgICAgIH07DQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9hdDkxc2FtOTI2M2Vr
LmR0cyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2F0OTFzYW05MjYzZWsuZHRzDQo+IGluZGV4IDcxZjYw
NTc2NzYxYS4uNGQ5MjJjMTBjMjZjIDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9h
dDkxc2FtOTI2M2VrLmR0cw0KPiArKysgYi9hcmNoL2FybS9ib290L2R0cy9hdDkxc2FtOTI2M2Vr
LmR0cw0KPiBAQCAtMTAyLDYgKzEwMiwxMCBAQCBtdGRfZGF0YWZsYXNoQDAgew0KPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIH07DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIH07
DQo+IA0KPiArICAgICAgICAgICAgICAgICAgICAgICBydGNAZmZmZmZkMjAgew0KPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGF0bWVsLHJ0dC1ydGMtdGltZS1yZWcgPSA8JmdwYnIg
MHgwPjsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgfTsNCj4gKw0KPiAgICAgICAgICAgICAg
ICAgICAgICAgICB3YXRjaGRvZ0BmZmZmZmQ0MCB7DQo+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgc3RhdHVzID0gIm9rYXkiOw0KPiAgICAgICAgICAgICAgICAgICAgICAgICB9Ow0K
PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvYXQ5MXNhbTlybGVrLmR0cyBiL2FyY2gv
YXJtL2Jvb3QvZHRzL2F0OTFzYW05cmxlay5kdHMNCj4gaW5kZXggNjI5ODFiMzljODE1Li5hMjZm
OWY3MGI2YjIgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL2F0OTFzYW05cmxlay5k
dHMNCj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvYXQ5MXNhbTlybGVrLmR0cw0KPiBAQCAtMjEy
LDYgKzIxMiwxMCBAQCB3YXRjaGRvZ0BmZmZmZmQ0MCB7DQo+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgc3RhdHVzID0gIm9rYXkiOw0KPiAgICAgICAgICAgICAgICAgICAgICAgICB9
Ow0KPiANCj4gKyAgICAgICAgICAgICAgICAgICAgICAgcnRjQGZmZmZmZDIwIHsNCj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBhdG1lbCxydHQtcnRjLXRpbWUtcmVnID0gPCZncGJy
IDB4MD47DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIH07DQo+ICsNCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgcnRjQGZmZmZmZTAwIHsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBzdGF0dXMgPSAib2theSI7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIH07DQo+IC0t
DQo+IDIuMjUuMQ0KPiANCj4gDQo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fDQo+IGxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0DQo+IGxpbnV4LWFy
bS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwNCg0K
