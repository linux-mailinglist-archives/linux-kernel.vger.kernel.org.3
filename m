Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4ECD4E26E9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 13:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347582AbiCUMwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 08:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238874AbiCUMwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 08:52:05 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CCA5AF1CA
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 05:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1647867039; x=1679403039;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=B6PF2u2HqHOdzVh1twFf79rmrgUTHwApCvCzwabgZ+o=;
  b=rqcbxv2ccVuSqlpJCBljzomk9jyrbeX2O+gbv9D5c1YvRrrF+scoscoL
   J2e9zO9w1FSIVi1p/rBUbQp6VVj9A9zQ82AavI9lV0ZP/FfWFstWldcDk
   Qx8b/ddNt2rgsruTU/stkrF6KEK640MQ8/AHBZ9JaaI9XPmk3H4U0jYib
   WLQaqIZ/STgNslJv/dEAdInvRDTHT6FJwBj+pjUnInQalUVE5/NAbweH4
   slVfr4ObFvQmSi4rbZZHQWlmRFIpTNTIOhzkwnqJD6NcLCOBGRKiEvgMp
   yuE980HCcwcd4aJwcRpj3BhPvJr1XdUV7NoPt+u5mB+hY7oOJOUbYe8k0
   w==;
X-IronPort-AV: E=Sophos;i="5.90,198,1643698800"; 
   d="scan'208";a="89593520"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Mar 2022 05:50:38 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 21 Mar 2022 05:50:37 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Mon, 21 Mar 2022 05:50:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fTjy/lYS9XWCxPDnTvNp+BTpBe1YQ8dA2ejTx/pXO2mgXf6rly8kiiL9bH8eXLQLy8aiRuc8YDRf3r2c8nSHYK6bnKGttctqWt0hgd7WqDJGE0Ikp1n5JOBuSqngj5Y9rNHgdLhMlEPUJUaVPJJKh/QUYn895g920XKQ5hrJLwhgNE5sLxLitxSlZGdKKNj4wqhpQemBIVoCtv1jQCTeFwt+Ap1fItCvjLBz2st60e3ZVMsQXsDcAeQkU1/RKFj1BiQuxO6lxJyTHMavKOGo/hfwe2+R4+yJYzF41FH69QcIBm3085XoMKjS6xUIdKfp/yZU2xrqHk9Fpth6p26OEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B6PF2u2HqHOdzVh1twFf79rmrgUTHwApCvCzwabgZ+o=;
 b=JXQZrgrb2V29uNlOgF6vc5NuZiVB+8zf9N0O0JB6O8FgMRwmin6V+Sp7ucqmaLSth6h5yVd2pVnVnWq+S8j5Ce6Zb0scq4MSxouGb4vPn/ZyuRwatOeXmqpzoqKTAEKnFb72MyjscuVC3gLLro9VzUGEq9nGXAgUgSyCfXKDrgnDjj3UHaZhHdudqoOyImyVoAGjah8mWgeVBJ51i7663yJskDEIPqQbr+ZjxRZaG8tk8hD2rGIPKjaI9GbKxUeK4l/WvNOERMGNGEzhjOtB8CMm26IzlgFFLzvuD5RFA0kAzdm4mxHtcT0M0ntHF8mzD/ODNxxCpCcHbqY+IISUZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B6PF2u2HqHOdzVh1twFf79rmrgUTHwApCvCzwabgZ+o=;
 b=RybwWzJq5y8Fzid0luimJUiAZGH7epcxfg5F5bZXYh1NUjf+A/lQpe2yr/s+GquNw8ciLWrD/+qwhX9ZYr531RhI/3zJW2+q1R8F/Pkz2fxGTYOu+o8N1CS5B1ZbeIpmloJObw7Tamv35YDaTogOIzRjYzt/9lFeXIMiK3kvYDA=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by BN6PR11MB1825.namprd11.prod.outlook.com (2603:10b6:404:104::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18; Mon, 21 Mar
 2022 12:50:35 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::b828:b4ef:5cb:e551]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::b828:b4ef:5cb:e551%4]) with mapi id 15.20.5081.023; Mon, 21 Mar 2022
 12:50:35 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <p.yadav@ti.com>
CC:     <michael@walle.cc>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Nicolas.Ferre@microchip.com>
Subject: Re: [PATCH v2 3/8] mtd: spi-nor: core: Use auto-detection only once
Thread-Topic: [PATCH v2 3/8] mtd: spi-nor: core: Use auto-detection only once
Thread-Index: AQHYPSJCjdRe3O4j50eK+DtOO+umKw==
Date:   Mon, 21 Mar 2022 12:50:35 +0000
Message-ID: <b4e8c044-f16a-a72d-6047-c42cdcc253f1@microchip.com>
References: <20220228111712.111737-1-tudor.ambarus@microchip.com>
 <20220228111712.111737-4-tudor.ambarus@microchip.com>
 <20220321121455.bpql7x4ebhq7s36l@ti.com>
In-Reply-To: <20220321121455.bpql7x4ebhq7s36l@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bcbd0179-d5e5-45b5-6c1e-08da0b3964b1
x-ms-traffictypediagnostic: BN6PR11MB1825:EE_
x-microsoft-antispam-prvs: <BN6PR11MB182550A1E5CFDDF57CD50899F0169@BN6PR11MB1825.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EU8/I2k3CDhgp8oJxqvgD7dzOIQ5Id91H0wLjsRr40F0I52m3n3xrihjr0T9O42n1epvO5KFDJ5vOQrY1aP7WlSQAxYAMf9AlwfLmBkN9UGY8h7+jBnSz8/cNf+YkdS2LwK2+JkW+mxKONHZlRxzx9RQPOQrCX30z+A+pd6XRS5ATjRifU4cSdWA2vtwHDtN+jJbbv4CYRunp5j2njQtLCaOFJO3AnBeUaSmwr84tTTwXwJaDNykz0GAVgASnDM8E501wJvFVaaXPsTPl0+aZzT02IxkZpavnbp0hBOKQgJUyM5XWHDcJU1/BtECjCFYgDfPnw+e0Amnb/P6iYvaAYxUZfW9oXIhJSRePGS4qdpEnc8zpsuUJEoJ76FaJJgB8rrnhUWTi8AMvTk0nnWoZn1vbyx473qJ2xzuSP4/uIOtM6OjddQsM3W/jz230e9DLPo61vDNaMZZEKf7rqGfs3/j9oj3SjZRJXVfRUM6krLOEoREs6A8cgLOUdCfo4m0u4xck3QyheuADQRiuIGQEJWhpbnWwmUrdGWddHOWWwn5QPpWJWYCG1knTn4zxCCKxgt3vzNTqOqemt4kSUlvcFsAWycFXTHySBI0Tp6xgZLgi24C1Hib+aecHNUTvGrNu+ZpEDBZvZuwTIzbKw3YIi+RgNoYjvS1T6Ay92rmVc8qiTfCWMYsYU/DHVb0hoG+AFtaEfkmyMBi7Xh4pepJrz1rFqm55PT2n95nci36LCMpzJEzswpcL792uD20/W0OisHouYx1Eeh9W+luzNhAPQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(54906003)(31696002)(91956017)(76116006)(8936002)(6486002)(53546011)(86362001)(66446008)(5660300002)(66556008)(66946007)(4326008)(8676002)(66476007)(64756008)(107886003)(38100700002)(2616005)(508600001)(6512007)(6916009)(38070700005)(2906002)(6506007)(122000001)(36756003)(83380400001)(31686004)(186003)(26005)(316002)(71200400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q0VBUk5MdDBVeWNjQ0tLL3hxK1R5Q2lSM0RXWFM5ejdEWisrKzJEQzRzVVFU?=
 =?utf-8?B?RlZUNUxOUWxlZHBFMHk4V3QzYkNveklhcnZnQUdhUlBycUpuOUJ1Nmk2b2Jt?=
 =?utf-8?B?WDZCRW55bnExV3llazlac054bmhnSnZDa3NoT1g2OGpuOFlvUEM2SUJSUzhR?=
 =?utf-8?B?dE1ua2ZMbW4yeE9oTTlJeFYvcml0ZGxQWUhVTjNoRnBuSDY0Z0wzWkVnRHQz?=
 =?utf-8?B?QjNjS3BwWHJnTTNsZld3VDNOWHNuT1RZMTU0U1duOTA2QWwzT2J4QWduYkRt?=
 =?utf-8?B?RUtObFZFMU9Jb2UxajRSMzBTY2NrR055dkRWV2JjYTNGa1lndkZFTkR0U3VW?=
 =?utf-8?B?RTZ0ZzJ1cjFxdXByWDlzY285WFJQZDByOHJ1U1FkWkc2MjZ0TnpHNUFxMllP?=
 =?utf-8?B?a1N4WTlvWkxrdGE4SnhqOHRGQlppOTdsdHhCWFpoQThRdFBJV0U3NzU5WWY5?=
 =?utf-8?B?TmFsd2xzUWpZVWlKaUFyL29rUVhyaFdXWnBiRE9CVWtYcGVZdkdNTCtHeVJ6?=
 =?utf-8?B?eWptNUNUTnVhK0lrRmNycnpBL29PZDIrOHMxa2xuaVpGLzJrRFlZd3kwTDU2?=
 =?utf-8?B?cDJFMHVuWTFJTVI5eDJqQ0t1TzlQTE9UK2VsaEszUUVnS2syQ1BvWFdmTDB6?=
 =?utf-8?B?dDZ0enF1alh1WWRFRWMvZFRhYTRjcmFxZEdtQXBwVWZDNVJ6NkZvdlhjTHd1?=
 =?utf-8?B?b2NyMWZXS20zNURwS0JYeitXN3FJQ1FJS0k0N25xYnBiVXd3WDZLTEZnVmZV?=
 =?utf-8?B?cXRLWVFDMEpzSG5hMWwzRDFXemFRSzBQU2JDcW0vMlMzb1o2T1dmVXlDNjVJ?=
 =?utf-8?B?dkppOVVWNUVsRkxlaVBWZFJicTIxK3BkNlFGd1djRG9HbmxHQ2lldFkyYTIy?=
 =?utf-8?B?eTF1d3g3aXZmRDBrcENFWDVnNmZiRysrVEtwSFpEaEFpNEY4M2tsb1c1YSto?=
 =?utf-8?B?M2VKYnhISENUTDlQZFZNbE43bVUzNG4ybmRoTXJMRXRDUWhNUXJCY2d2K09N?=
 =?utf-8?B?aXNzaU5EamYvVm13NVR2YnJpb0FHOVcvcldDMW1lMVBCN2lQZzNnejdQcVMy?=
 =?utf-8?B?Q05CTk96bFNIVkJmWHRmcjNZcGdWWS9BV2NlcFo1WXZmYnBsL0VPMkQzeHg1?=
 =?utf-8?B?VlJ3R3g1b1JrOWR3MzMzL3RmZmE0RVFlMDJFL3NuWUUxQnBJMG1zZUU1UzRU?=
 =?utf-8?B?VUNxTHU1Ym8vdFk2ZkY0d3BxaDQrV042NUQ5MkswSHZnTndsVG1ncjhLV3VV?=
 =?utf-8?B?VW1CV3RWRm51NFVEMk5ZK2lpWkllT0ExeXhPR2RZaW4ycUJtcW5oZm9PSmNH?=
 =?utf-8?B?Z2xXK3o2eVJ1RHBrc25sTUJrRkdESVE5dlpYQktabExVbTIzYzVLeWJNL0JM?=
 =?utf-8?B?bC9KZmVGd1VxTXhMU2FFN1VOVmowZE8vWkhDNDVwSm1yaGF2QThCSlZaMitk?=
 =?utf-8?B?b3dYNnpCSVR0Rm9EeDVDS0pma2pHV21xOFRWTnRSOUJkdGJMeGNzWXRYSUYv?=
 =?utf-8?B?Tmd3ZUxBVmtJNExGbTlHSXpKMEp5UWpmcDA1Ymk1NDlDMUJwQXJGUTFHeUh1?=
 =?utf-8?B?SHJ1djJYVFNQeEdTak5vaXkyM1c5MjI3Y21TKzFaL3BVbkthT0s1dEVOeGxV?=
 =?utf-8?B?RUZaWWdsRHl1VTFEaHFudW16SGN0Q08xUm0wV3VSa2xUb09uSkF6VXVscTl1?=
 =?utf-8?B?ZzJJTHMzUlQwVSswbFZaMFZNckMrS0lHaExKdVZWVnpMRWcvV09qN2RzaWZa?=
 =?utf-8?B?WVVpTTdVUkwvWk1tYWRFRmhkNHFGYUpVOFNMWXoxZGt5blp4NmVsSjNIeXRC?=
 =?utf-8?B?YktCeWRKZzdUQ2JLZG14Qmt4VHVOelRLQXRlL1N6SUZGL3JicVc2T241bTRV?=
 =?utf-8?B?c3BUdkV4aWdlU1lTYTd1dVNFc0padGZpZzZXK2xxdmJOVUVrajVrcTJiZ0tM?=
 =?utf-8?B?UTZyNlV3a0dQck1DT2t2N0tMOS9EVkhiSmZvMXJuZ0NieTdyN200WTNzWGgz?=
 =?utf-8?B?VUIyaVI4Z2xRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E47C30E17B41C440BA47C58815FE3170@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcbd0179-d5e5-45b5-6c1e-08da0b3964b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2022 12:50:35.5799
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1gj8PDuxX2rtmai0dM1T/FQjtFTyMldLcJxL+8PdEPF6utEfKDbNQYtr9Gri0RDkaAEsMzT4SijcVbvk/xSHpulAitEx9dkjFTHlu+efonY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1825
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy8yMS8yMiAxNDoxNCwgUHJhdHl1c2ggWWFkYXYgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlM
OiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cg
dGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gMjgvMDIvMjIgMDE6MTdQTSwgVHVkb3IgQW1i
YXJ1cyB3cm90ZToNCj4+IEluIGNhc2Ugc3BpX25vcl9tYXRjaF9uYW1lKCkgcmV0dXJuZWQgTlVM
TCwgdGhlIGF1dG8gZGV0ZWN0aW9uIHdhcw0KPj4gaXNzdWVkIHR3aWNlLiBUaGVyZSdzIG5vIHJl
YXNvbiB0byB0cnkgdG8gZGV0ZWN0IHRoZSBzYW1lIGNoaXAgdHdpY2UsDQo+PiBkbyB0aGUgYXV0
byBkZXRlY3Rpb24gb25seSBvbmNlLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFR1ZG9yIEFtYmFy
dXMgPHR1ZG9yLmFtYmFydXNAbWljcm9jaGlwLmNvbT4NCj4+IC0tLQ0KPj4gIGRyaXZlcnMvbXRk
L3NwaS1ub3IvY29yZS5jIHwgMTAgKysrKysrLS0tLQ0KPj4gIDEgZmlsZSBjaGFuZ2VkLCA2IGlu
c2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
bXRkL3NwaS1ub3IvY29yZS5jIGIvZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmMNCj4+IGluZGV4
IGY4N2NiN2QzZGFhYi4uYjFkNmZhNjU0MTdkIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9tdGQv
c3BpLW5vci9jb3JlLmMNCj4+ICsrKyBiL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5jDQo+PiBA
QCAtMjg5NCwxMyArMjg5NCwxNSBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGZsYXNoX2luZm8gKnNw
aV9ub3JfbWF0Y2hfbmFtZShzdHJ1Y3Qgc3BpX25vciAqbm9yLA0KPj4gIHN0YXRpYyBjb25zdCBz
dHJ1Y3QgZmxhc2hfaW5mbyAqc3BpX25vcl9nZXRfZmxhc2hfaW5mbyhzdHJ1Y3Qgc3BpX25vciAq
bm9yLA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBjb25zdCBjaGFyICpuYW1lKQ0KPj4gIHsNCj4+IC0gICAgIGNvbnN0IHN0cnVjdCBmbGFz
aF9pbmZvICppbmZvID0gTlVMTDsNCj4+ICsgICAgIGNvbnN0IHN0cnVjdCBmbGFzaF9pbmZvICpp
bmZvID0gTlVMTCwgKmRldGVjdGVkX2luZm8gPSBOVUxMOw0KPj4NCj4+ICAgICAgIGlmIChuYW1l
KQ0KPj4gICAgICAgICAgICAgICBpbmZvID0gc3BpX25vcl9tYXRjaF9uYW1lKG5vciwgbmFtZSk7
DQo+PiAgICAgICAvKiBUcnkgdG8gYXV0by1kZXRlY3QgaWYgY2hpcCBuYW1lIHdhc24ndCBzcGVj
aWZpZWQgb3Igbm90IGZvdW5kICovDQo+PiAtICAgICBpZiAoIWluZm8pDQo+PiAtICAgICAgICAg
ICAgIGluZm8gPSBzcGlfbm9yX3JlYWRfaWQobm9yKTsNCj4+ICsgICAgIGlmICghaW5mbykgew0K
Pj4gKyAgICAgICAgICAgICBkZXRlY3RlZF9pbmZvID0gc3BpX25vcl9yZWFkX2lkKG5vcik7DQo+
PiArICAgICAgICAgICAgIGluZm8gPSBkZXRlY3RlZF9pbmZvOw0KPj4gKyAgICAgfQ0KPj4gICAg
ICAgaWYgKElTX0VSUl9PUl9OVUxMKGluZm8pKQ0KPj4gICAgICAgICAgICAgICByZXR1cm4gRVJS
X1BUUigtRU5PRU5UKTsNCj4+DQo+PiBAQCAtMjkwOCw3ICsyOTEwLDcgQEAgc3RhdGljIGNvbnN0
IHN0cnVjdCBmbGFzaF9pbmZvICpzcGlfbm9yX2dldF9mbGFzaF9pbmZvKHN0cnVjdCBzcGlfbm9y
ICpub3IsDQo+PiAgICAgICAgKiBJZiBjYWxsZXIgaGFzIHNwZWNpZmllZCBuYW1lIG9mIGZsYXNo
IG1vZGVsIHRoYXQgY2FuIG5vcm1hbGx5IGJlDQo+PiAgICAgICAgKiBkZXRlY3RlZCB1c2luZyBK
RURFQywgbGV0J3MgdmVyaWZ5IGl0Lg0KPj4gICAgICAgICovDQo+PiAtICAgICBpZiAobmFtZSAm
JiBpbmZvLT5pZF9sZW4pIHsNCj4+ICsgICAgIGlmIChuYW1lICYmICFkZXRlY3RlZF9pbmZvICYm
IGluZm8tPmlkX2xlbikgew0KPj4gICAgICAgICAgICAgICBjb25zdCBzdHJ1Y3QgZmxhc2hfaW5m
byAqamluZm87DQo+Pg0KPj4gICAgICAgICAgICAgICBqaW5mbyA9IHNwaV9ub3JfcmVhZF9pZChu
b3IpOw0KPiANCj4gSSB0aGluayB0aGUgZmxvdyBjYW4gYmUgYSBsaXR0bGUgYml0IGJldHRlci4g
SG93IGFib3V0Og0KPiANCj4gICAgICAgICBpZiAobmFtZSkNCj4gICAgICAgICAgICAgICAgIGlu
Zm8gPSBzcGlfbm9yX21hdGNoX25hbWUoKTsNCj4gDQo+ICAgICAgICAgaWYgKCFpbmZvKSB7DQo+
ICAgICAgICAgICAgICAgICBpbmZvID0gc3BpX25vcl9yZWFkX2lkKCk7DQo+ICAgICAgICAgICAg
ICAgICBpZiAoSVNfRVJSX09SX05VTEwoaW5mbykpDQo+ICAgICAgICAgICAgICAgICAgICAgICAg
IHJldHVybiBFUlJfUFRSKC1FTk9FTlQpOw0KPiANCj4gICAgICAgICAgICAgICAgIHJldHVybiBp
bmZvOw0KPiAgICAgICAgIH0NCg0KSGVyZSB3ZSBtaXNzIHRoZSBJU19FUlIgY2hlY2sgaW4gY2Fz
ZSBpbmZvIGlzIHJldHJpZXZlZCB3aXRoIHNwaV9ub3JfbWF0Y2hfbmFtZSgpLg0KRG8geW91IGV4
cGVjdCBzcGlfbm9yX21hdGNoX25hbWUoKSB0byBldmVyIHJldHVybiBhbiBlcnJvcj8gQXMgaXQg
aXMgbm93IGl0IGRvZXNuJ3QuDQpJJ20gZmluZSBlaXRoZXIgd2F5LiBJbiBjYXNlIHlvdSB3YW50
IG1lIHRvIGZvbGxvdyB5b3VyIHN1Z2dlc3Rpb24sIGdpdmUgbWUgYSBzaWduDQphbmQgSSdsbCBt
YWtlIGEgZGVkaWNhdGVkIHBhdGNoIHRvIG1vdmUgdGhlIElTX0VSUl9PUl9OVUxMIGNoZWNrLiBX
aWxsIGFkZCB5b3VyDQpTdWdnZXN0ZWQtYnkgdGFnLg0KDQpDaGVlcnMsDQp0YQ0K
