Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40B35623FB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 22:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237173AbiF3UOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 16:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236609AbiF3UOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 16:14:03 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16DDF43EE3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 13:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1656620042; x=1688156042;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9oMVQm4fS+av6oDmDFASzGhMnZqUD405Scp47h9X8f8=;
  b=DG+6JC7Iw8MXQpPY2BYnlH4/RnS90W5WPSypbkoXf0hFMDOtM11nIhY1
   t+UwbCM+99QWqiOA0/TlFQaRPmopv8f0IaDy0MGn/acs388+vPJGHLZAP
   oHIVoAhF7ValOTezVz81/y0xm6gkqFktx1bLg86dZB7C0sb3Sa4t+40gx
   R5JnW4rKxRwih8vNQ1tIDRoxq/en0FqYzQRktpP0T/k4RZEHV4llHySuN
   13QAd9hog4yG2IUi2zP4w57rwozNSk5tHgliBec/RkCT4VnBpuvF4J83o
   kem2MDqA05wjGD8BRSWPPLN4NFAsYeiT5AABCXcCY8SzWaf7dTEcjuK/G
   w==;
X-IronPort-AV: E=Sophos;i="5.92,235,1650956400"; 
   d="scan'208";a="170313668"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Jun 2022 13:14:01 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 30 Jun 2022 13:14:00 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Thu, 30 Jun 2022 13:14:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h898lVtx4wOu+nAln2EB2eHRGh93g/en9LqeWexEtKzaLSjVWk2NHzHMacbIMWSUSTGDziHdKnXN3liZvnDSuw9qwZvcJkJYcuuYJVJ8FCqVO5GRb6xpwL8+f7VBcP1wPWnZcsyYMIuCDiQGiIVYNPDp7VnPeuZFDCPTu3YelY7W8lI7mak+OlzhrxqAtyf/UaLWauZs21+F8BdZ72+5AC9uO9vAJbum6PhmIvhuF5j884el52gkkDsREFZm7EjSLClU1+H1Yl5amTQBsIx56iGzaFiuiTtgEANfwW0XIvt9ADyl4CQm0AZL77mVDsus73MBXAy5TbT+jNZ/cE0+Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9oMVQm4fS+av6oDmDFASzGhMnZqUD405Scp47h9X8f8=;
 b=CcmnfO5LDG33ndoZkBPs2g6vMXjgak/2hfjpg80lkzyMcURgNMDJ+d+cvV8boGnUfz9KmKAJ/Gx4ogXz4WbbRTvw9PC22rvdh9s1o/FEwqeKCBEUSgHQl6EVQUun/R8BbZLM9fcmWycR7zAv3nDjx82e2klBdk/lS+fKnCISt3pPELBETbIWMh2WwEGhjCeLON6HVJNRQbv4CPiW02jjr4Y82A4hPc28LPcuLQvwQNWGP/92kN9weWCJtGaQDFdvbJgA8hKko3tNhLQN7/wF2P64pTT00Fk4s+WBhFtFxBJozOQhax7WuA3v5CuExDyT4AclER71cLMnMyLAb8wEgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9oMVQm4fS+av6oDmDFASzGhMnZqUD405Scp47h9X8f8=;
 b=WTiCw49nzkW7LNBSgMg3DBJHcWSdgI6R6rTKbjJky/FwfmrrB16e7kP/HQvUu++P1ZBcZdmCZ0EtVTXspXKZGaYNXUu8qV5ls9k2c1gh3PTQptZlInf0ejjWgWSH0S2fSJ9Lg1OREiUCHjPm9HWocycmBxMXN00VE8LigMr+7/8=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by SJ0PR11MB5895.namprd11.prod.outlook.com (2603:10b6:a03:42b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Thu, 30 Jun
 2022 20:13:55 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa%4]) with mapi id 15.20.5373.022; Thu, 30 Jun 2022
 20:13:55 +0000
From:   <Conor.Dooley@microchip.com>
To:     <sudeep.holla@arm.com>, <Conor.Dooley@microchip.com>
CC:     <linux-kernel@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <atishp@atishpatra.org>, <atishp@rivosinc.com>,
        <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
        <wangqing@vivo.com>, <robh+dt@kernel.org>, <rafael@kernel.org>,
        <ionela.voinescu@arm.com>, <pierre.gondois@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-riscv@lists.infradead.org>, <gshan@redhat.com>,
        <Valentina.FernandezAlanis@microchip.com>
Subject: Re: [PATCH v5 09/19] arch_topology: Use the last level cache
 information from the cacheinfo
Thread-Topic: [PATCH v5 09/19] arch_topology: Use the last level cache
 information from the cacheinfo
Thread-Index: AQHYikaSsliGXUqkU0W62iFZL9A2pK1mrJEAgAAIIICAAAargIAAEAyAgAAEPgCAAAqJAIAAMFoAgAC8ZgCAAGP7gIAAEAqAgAAdSoCAAA0zgIAAAdqA
Date:   Thu, 30 Jun 2022 20:13:55 +0000
Message-ID: <ddb8238a-003e-fe5a-2a11-cb34c324fb33@microchip.com>
References: <3656a067-cc3f-fd5b-e339-5925a856cce1@microchip.com>
 <20220629184217.krzt6l7qadymbj6h@bogus>
 <f1f4a30e-7a84-30e2-197c-4153b3e66b64@microchip.com>
 <20220629195454.vbsjvcadmukiunt7@bogus>
 <03433f57-04ed-44a9-a2f6-5577df94f11e@microchip.com>
 <b2ab0ac1-bfef-5ba0-4ee5-15e604d8aa2e@microchip.com>
 <20220630103958.tcear5oz3orsqwg6@bogus>
 <9d9e80b8-17e2-b1d9-14fa-f1d8d7dfbd9a@microchip.com>
 <20220630173513.dyrrmjbpxzi3e6fe@bogus>
 <3840dbf7-ca18-b7ab-4d7a-92c9305476fa@microchip.com>
 <20220630200717.zlc6z6zcqbsw7euk@bogus>
In-Reply-To: <20220630200717.zlc6z6zcqbsw7euk@bogus>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0dc8fa1a-09f2-4a9b-5b97-08da5ad50f57
x-ms-traffictypediagnostic: SJ0PR11MB5895:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rjE/WxOyEH6rLOL1USiiDQ9XfcSfCchAX5RWzC+f0dg/LkdvDBOnbODGK/D172lPweb6Wz6gfgsWcoPxsbNm0TIPFlq1VanYLiyahwK/jLFoB3oAy3Ol7SNlNPInhM+66FpCG3RpgZGq0bra3eq9cEWILnuC4fO9NGU6sWSk/JeiEEx3ewTohbAYDha97ANV75P7kzfaBt15GmqZrkN1Ek36LSmh/i/5ARwPVDTK0MnYQDZvTfXFDODugxr91+HyHy8MpBS0IBA2Cx1N/HSHvJ/OrrzlfXwSzK2rw6I5zP++J7ZNE+YonstKqszdyh8AEOeM0CotNNrLQ8boRNnpQy7nTlZ5wHV3I8fG8X+iY6V2IrzvYPUAN9U7ohivWZ/fjUseA/qF8l3YkpomfrpxhS5LjUhWnYFDWB1H/K1hOwKW4SaVDxKwHuQ6Gtd1Z7I/lyo+KMNkWUJFWtM1cxU1uq46H6hKfPCTtaP4Dtp57nTRfR9m0sgRSOEfNTNyEKkZ2BmM1MdArBq6iTWN15QFMJs2W/pwc9rbQ79WMw0jq+s1YZgg0z2Jh17lbKBAZ6DyPwuL+dfcLYzdX7W/T1dbqwyc7DTAxg2eCJ32JjrGZaG/WkVjazwNGlxlm061rcgof7vhLeL2886HQqzSLXtHvWePrvRiOvUVw5yj4eVKmCqu+aZ6/vZbgGdTBVgU1dhW+ZjpSNFL2sSI+FI4DyXz5tAXgxIsh8MOuTeX8MTAcjuUsXF2BeumDh6snPuDxAKpwGO8r4IZKUUA28h5Sn473RmSLFuAnKt/to0on2jQxc1KIPsiFYv2f8aLOCyMqnIez5Xn56AEE9Wmn/x7kETpHM6qCsSm3rsCGBwt3PzXDZ0bTd/62w19DkVGzxKgdqhsQbgMeKSkKKoTTAAuoWf9tN4VMawnQ0kIvIMBEfv2G4o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(366004)(396003)(136003)(346002)(376002)(8676002)(66446008)(4326008)(966005)(66556008)(76116006)(2906002)(66476007)(64756008)(66946007)(91956017)(8936002)(7416002)(5660300002)(6486002)(38070700005)(122000001)(478600001)(71200400001)(54906003)(2616005)(186003)(31686004)(316002)(107886003)(38100700002)(66574015)(36756003)(26005)(6512007)(86362001)(31696002)(53546011)(6506007)(83380400001)(110136005)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OE1zSXRHOFV0OUVUSXRNM1ljQ2dNVFcyeit4U05ZOFBVYlRkU1gxKzlNazJr?=
 =?utf-8?B?SFJIM05qaE54MFRiOTgxeVFUd3BsTjE1aTR0c29XODFiVXBBRnNiemZUT0dj?=
 =?utf-8?B?UFNna2F6UzhsUE14Y29wQnR0WkV2eXRSMDUvVHYrRG96d05pQlhaU2cyWGxG?=
 =?utf-8?B?Rm03ajJGYmUrYzVxWTM0YjF4ZzJCL1lFNXNXSzVlS3IwN2U0cWpwcEpncFpB?=
 =?utf-8?B?dnZwTk5oTWprL0U1alBJRWNWcmRBSFNNYU5KNVVHVE9LWTdKT3VPaTlQbVpE?=
 =?utf-8?B?ci9XeTBVV0Q3U1I2am9UenlEaDRxakw0VUExQ2dxVU80ekFoQ2h2eFVNTENx?=
 =?utf-8?B?U2dzenhpRGhRdUJhNis5YVJjbWVocGZ5RklhK2ROMUdORkg4NTBUekNwRWcz?=
 =?utf-8?B?WGMrQ2hCNEVLVkt6REJVRHVnM2QydEp4eVZpQ2grcTFZeUVLWHMwSE5yUjk2?=
 =?utf-8?B?S2NjTG5ncmE3U0R3c2pXbVZCYWdRckpLb0FPc24wY3JlbFRldHdrVndOL2VB?=
 =?utf-8?B?Z1BwQjgrTUpsTEc5Q2JxTXJPWEN6NG85RmJHNTRjZlhqT203NjRpdmU3NytJ?=
 =?utf-8?B?WisyRVJmbnRsaUN6Mnc3UlFIUGJTaktTYlBFc0IvcEljVWdPYTZLTkoxK3BS?=
 =?utf-8?B?ZWk3dVYvdXJIQXNrSVQ2TnRPa2xITlNTOGhkcDJKTFhWVE80K1dtbnpYWFJ3?=
 =?utf-8?B?TjR3UWQ0a3dHZFR6UEtLaXMvOFpRdThLd0pQZ1NITnpXNVhHUUZVWmdXeVB6?=
 =?utf-8?B?VlE4VUl4TGcwbzNJdWVEUWR6ZUFKcXBEUjhzMG1sT25KWCtXb1Izekt0TndG?=
 =?utf-8?B?S0tCVzQycnp3ektoZnRGMjhaOU1pbzlBc1F6WTN2WXMvOHdsNCtJcWtYMFVl?=
 =?utf-8?B?aHBuM0NLeVkyM0R5RGRmTnF4Uk05QmRqSVJpNmJSS3l3dXE0Qll5ZnZTdUxO?=
 =?utf-8?B?bG0za3A2UHBEN3o4Tytod0ZlTWFvSUdjbUNFbytPOTBUa3F3a3V0QXlRMXQ4?=
 =?utf-8?B?RUZVazlUVUVPb3FsMXhUaVdQRjRrSHpBR09XbytFeXNuakZyNnpHcERCdlNy?=
 =?utf-8?B?eGY5Nnh0dHYva1F5eU1EUzUvQWkyRTR2RFNTdTdBeWJXL05WYnNWdVlGVjZi?=
 =?utf-8?B?L2hBYjU2ZTVUZjFGTEhFMjRoNXJLa1VOWVIvZFYxazFaTTlleEtIUUFyWUNy?=
 =?utf-8?B?dTF6QndBeEVwbU42bFNtTDIxUmI3Y0NlZDBzYTZoWmdJQmgyeVkyaUpwcGFM?=
 =?utf-8?B?WFArbnVHSWhoMXR2K1dLaEZRazNrL3dsZXRkYVNTTFBBcUtmQThQdEk4aG1N?=
 =?utf-8?B?YU5ESC9uMGlGSFdZeFZUQWZUKzBEMkpLaTlHNFRNb3djMmlFZjlLeUFId3Bz?=
 =?utf-8?B?OTNWM2xsaHVnSTdRR0pFbk9UOGVGelVzNzRmSGZ5eUp3bm5ZdS8rTU9ncFlj?=
 =?utf-8?B?b2pSTk8xSEx2Y2tCSDFXM1h3SW9BenQ0TzFkUXdqaFNoRUZwRERJRG1vMFBZ?=
 =?utf-8?B?ZXIyLzJaWVNHdStudURESkwvVkpjby92K2tGY3lXbGRxbFFoWlZLcS9Ya3lN?=
 =?utf-8?B?aHBXWkhpZmczUkJQdm45dEVySmlTcmlkTzJURExyOXFjVWF6UEovYnF5SWRq?=
 =?utf-8?B?Mitxb28rQ2NSc1RKK3MyL3labWd3SzlBSVI3ODVzbjRrZklPNzEvWkFTYjM2?=
 =?utf-8?B?czMydnZ0Z1Y5SDFTM0EwT3phYjlIOC81UHUwc1RGczNwakM0SXdqMzdXS2ta?=
 =?utf-8?B?Q1RFZW5xZlN4NllEWFdXdHMyak1zOGptL01CVCtZazFYZURsdUU4M29SMzVY?=
 =?utf-8?B?UkhRY2g2WERJRUNmRFFRZ1lSVXVMRFNoSzYycGJLd2NzUHd5RDIvby9icXRq?=
 =?utf-8?B?VHVIL2RvSVBpbGlZT2lwZENpcE8zU0VYaHZ0RHE2aU8xeVdxeDB4SGZrY09X?=
 =?utf-8?B?ZXNnWWJSdkw0d2c4NnJnVWFmSFVJQ0VKR0xwaTdBeHM3QjVBYkI1QkwrQ25J?=
 =?utf-8?B?V3FEQ2cxVzdDK2RnWGx5dDBVVW5YYlhDa3NKc3ZSZXdCTnhaeDFZU0I1NEh1?=
 =?utf-8?B?QXhhb202U25tYjdJM2JVRDVrVlNqa3ZXcUIxL0pzdklRZFBPc3Nqb2U5VjA5?=
 =?utf-8?B?WkJlV083MEJ5V1gzelJGZUFVM1kwMFdNczBwak5YUnRhVVZGaTJsaEdDdHRJ?=
 =?utf-8?B?N0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4194F1C1A3FF0349A3FDF2A7D221A9F0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dc8fa1a-09f2-4a9b-5b97-08da5ad50f57
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2022 20:13:55.7638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vheoykh3NLQn5rcF6OKaiw+j+Yf/2otg38G75rMIwnL4v6Ko7j3ulDMxQptNmQN2StvXkjIBIut644AwLg4t1Os2Rht24LjEkbW1t8ap2vg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5895
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDMwLzA2LzIwMjIgMjE6MDcsIFN1ZGVlcCBIb2xsYSB3cm90ZToNCj4gT24gVGh1LCBK
dW4gMzAsIDIwMjIgYXQgMDc6MjA6MDRQTSArMDAwMCwgQ29ub3IuRG9vbGV5QG1pY3JvY2hpcC5j
b20gd3JvdGU6DQo+Pg0KPj4NCj4+IE9uIDMwLzA2LzIwMjIgMTg6MzUsIFN1ZGVlcCBIb2xsYSB3
cm90ZToNCj4+PiBPbiBUaHUsIEp1biAzMCwgMjAyMiBhdCAwNDozNzo1MFBNICswMDAwLCBDb25v
ci5Eb29sZXlAbWljcm9jaGlwLmNvbSB3cm90ZToNCj4+Pj4gT24gMzAvMDYvMjAyMiAxMTozOSwg
U3VkZWVwIEhvbGxhIHdyb3RlOg0KPj4+Pj4NCj4+Pj4+IEkgY2FuJ3QgdGhpbmsgb2YgYW55IHJl
YXNvbiBmb3IgdGhhdCB0byBoYXBwZW4gdW5sZXNzIGRldGVjdF9jYWNoZV9hdHRyaWJ1dGVzDQo+
Pj4+PiBpcyBmYWlsaW5nIGZyb20gaW5pdF9jcHVfdG9wb2xvZ3kgYW5kIHdlIGFyZSBpZ25vcmlu
ZyB0aGF0Lg0KPj4+Pj4NCj4+Pj4+IEFyZSBhbGwgUklTQy1WIHBsYXRmb3JtcyBmYWlsaW5nIG9u
IC1uZXh0IG9yIGlzIGl0IGp1c3QgdGhpcyBwbGF0Zm9ybSA/DQo+Pj4+DQo+Pj4+IEkgZG9uJ3Qg
a25vdy4gSSBvbmx5IGhhdmUgU29DcyB3aXRoIHRoaXMgY29yZSBjb21wbGV4ICYgb25lIHRoYXQg
ZG9lcyBub3QNCj4+Pj4gd29yayB3aXRoIHVwc3RyZWFtLiBJIGNhbiB0cnkgbXkgb3RoZXIgYm9h
cmQgd2l0aCB0aGlzIFNvQyAtIGJ1dCBJIGFtIG9uDQo+Pj4+IGxlYXZlIGF0IHRoZSBtb21lbnQg
dy8gYSBjb21wdXRlciBvciBpbnRlcm5ldCBkdXJpbmcgdGhlIGRheSBzbyBpdCBtYXkgYmUNCj4+
Pj4gYSBmZXcgZGF5cyBiZWZvcmUgSSBjYW4gdHJ5IGl0Lg0KPj4+Pg0KPj4+DQo+Pj4gU3VyZSwg
bm8gd29ycmllcy4NCj4+Pg0KPj4+PiBIb3dldmVyLCBOaWtsYXMgQ2Fzc2VsIGhhcyB0cmllZCB0
byB1c2UgdGhlIENhbmFhbiBLMjEwIG9uIG5leHQtMjAyMjA2MzANCj4+Pj4gYnV0IGhhZCBpc3N1
ZXMgd2l0aCBSQ1Ugc3RhbGxpbmc6DQo+Pj4+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4
LXJpc2N2L1lyM1BLUjBVajFiRTVZNk9AeDEtY2FyYm9uL1QvI201MjAxNjk5NmZjZjVmYTA1MDEw
NjZkNzMzNTJlZDhlODA2ODAzZTA2DQo+Pj4+IE5vdCBnb2luZyB0byBjbGFpbSBhbnkgcmVsYXRp
b24sIGJ1dCB0aGF0J3MgbWludXMgMSB0byB0aGUgcGxhdGZvcm1zIHRoYXQNCj4+Pj4gY2FuIGJl
IHVzZWQgdG8gdGVzdCB0aGlzIG9uIHVwc3RyZWFtIFJJU0MtVi4NCj4+Pj4NCj4+Pg0KPj4+IEFo
IE9LLCB3aWxsIGNoZWNrIGFuZCBhc2sgZnVsbCBsb2dzIHRvIHNlZSBpZiB0aGVyZSBpcyBhbnkg
cmVsYXRpb24uDQo+Pj4NCj4+Pj4+IFdlIG1heSBoYXZlIHRvIHRyeSB3aXRoIHNvbWUgbG9ncyBp
biBkZXRlY3RfY2FjaGVfYXR0cmlidXRlcywNCj4+Pj4+IGxhc3RfbGV2ZWxfY2FjaGVfaXNfdmFs
aWQgYW5kIGxhc3RfbGV2ZWxfY2FjaGVfaXNfc2hhcmVkIHRvIGNoZWNrIHdoZXJlIGl0DQo+Pj4+
PiBpcyBnb2luZyB3cm9uZy4NCj4+Pj4+DQo+Pj4+PiBJdCBtdXN0IGJlIGNyYXNoaW5nIGluIHNt
cF9jYWxsaW4tPnVwZGF0ZV9zaWJsaW5nc19tYXNrcy0+bGFzdF9sZXZlbF9jYWNoZV9pc19zaGFy
ZWQNCj4+DQo+Pg0KPj4gU28sIGxvb2tzIGxpa2UgdGhlcmUncyBhIHByb2JsZW0gaW4gY2FjaGVf
bGVhdmVzX2FyZV9zaGFyZWQoKSB3aGljaCBpcyBoaXQNCj4+IGJ5IHRoZSBhYm92ZSBwYXRoLiBC
b3RoIG9mIHRoZSBpZiBjbGF1c2VzIGFyZSBmYWxzZSwgYW5kIHRoZSBmdW5jdGlvbiBmYWxscw0K
Pj4gdGhyb3VnaCB0byByZXR1cm4gc2liX2xlYWYtPmZ3X3Rva2VuID09IHRoaXNfbGVhZi0+Zndf
dG9rZW47DQo+IA0KPiBCb3RoIGlmKCkgZmFpbGluZyBpcyBleHBlY3RlZCBhbmQgdGhhdCBzdGF0
ZW1lbnQNCj4gCXJldHVybiBzaWJfbGVhZi0+ZndfdG9rZW4gPT0gdGhpc19sZWFmLT5md190b2tl
bjsNCj4gZXhlY3V0aW9uIGlzIGNvcnJlY3QuDQo+IA0KPj4gQm90aCBzaWJfbGVhZiAmIHRoaXNf
bGVhZiBzZWVtIHRvIGJlIG51bGwuDQo+Pg0KPiANCj4gQnV0IHRoaXMgaXMgd3JvbmcgYXMgbGFz
dF9sZXZlbF9jYWNoZV9pc19zaGFyZWQgY2hlY2tzIGZvcg0KPiBsYXN0X2xldmVsX2NhY2hlX2lz
X3ZhbGlkIHdoaWNoIG11c3QgcmV0dXJuIGZhbHNlIGlmIHRoZSBmd190b2tlbiA9IE5VTEwNCj4g
U28gd2UgbXVzdCBub3QgaGl0IHRoZSBhYm92ZSByZXR1cm4gc3RhdGVtZW50IHdpdGggTlVMTCBm
d190b2tlbi4NCj4gDQo+PiBzdGF0aWMgaW5saW5lIGJvb2wgY2FjaGVfbGVhdmVzX2FyZV9zaGFy
ZWQoc3RydWN0IGNhY2hlaW5mbyAqdGhpc19sZWFmLA0KPj4gCQkJCQkgICBzdHJ1Y3QgY2FjaGVp
bmZvICpzaWJfbGVhZikNCj4+IHsNCj4+IAkvKg0KPj4gCSAqIEZvciBub24gRFQvQUNQSSBzeXN0
ZW1zLCBhc3N1bWUgdW5pcXVlIGxldmVsIDEgY2FjaGVzLA0KPj4gCSAqIHN5c3RlbS13aWRlIHNo
YXJlZCBjYWNoZXMgZm9yIGFsbCBvdGhlciBsZXZlbHMuIFRoaXMgd2lsbCBiZSB1c2VkDQo+PiAJ
ICogb25seSBpZiBhcmNoIHNwZWNpZmljIGNvZGUgaGFzIG5vdCBwb3B1bGF0ZWQgc2hhcmVkX2Nw
dV9tYXANCj4+IAkgKi8NCj4+IAlpZiAoIShJU19FTkFCTEVEKENPTkZJR19PRikgfHwgSVNfRU5B
QkxFRChDT05GSUdfQUNQSSkpKQ0KPj4gCQlyZXR1cm4gISh0aGlzX2xlYWYtPmxldmVsID09IDEp
Ow0KPj4NCj4+IAlpZiAoKHNpYl9sZWFmLT5hdHRyaWJ1dGVzICYgQ0FDSEVfSUQpICYmDQo+PiAJ
ICAgICh0aGlzX2xlYWYtPmF0dHJpYnV0ZXMgJiBDQUNIRV9JRCkpDQo+PiAJCXJldHVybiBzaWJf
bGVhZi0+aWQgPT0gdGhpc19sZWFmLT5pZDsNCj4+DQo+PiAJcmV0dXJuIHNpYl9sZWFmLT5md190
b2tlbiA9PSB0aGlzX2xlYWYtPmZ3X3Rva2VuOw0KPj4gfQ0KPj4NCj4+IEFueSBpZGVhcyB3aGF0
IHRvIGxvb2sgYXQgbmV4dD8NCj4gDQo+IEkgd29uZGVyIGhvdyBkaWQgd2Ugbm90IGdldCBsYXN0
X2xldmVsX2NhY2hlX2lzX3ZhbGlkIGFzIGZhbHNlIGlmIHRoZQ0KPiBmd19ub2RlIGlzIE5VTEwu
IEJ1dCBpdCBzaG91bGQgbm90IGJlIE5VTEwgYXQgdGhlIGZpcnN0IHBsYWNlLg0KPiANCg0KSSBk
aWRuJ3QgaGF2ZSB0aGUgdGltZSB0byBnbyBkaWdnaW5nIGludG8gdGhpbmdzLCBidXQgdGhlIGZv
bGxvd2luZw0KbWFjcm8gbG9va2VkIG9kZDoNCiNkZWZpbmUgcGVyX2NwdV9jYWNoZWluZm9faWR4
KGNwdSwgaWR4KQkJXA0KCQkJCShwZXJfY3B1X2NhY2hlaW5mbyhjcHUpICsgKGlkeCkpDQpNYXli
ZSBpdCBpcyBqdXN0IGJhZGx5IG5hbWVkLCBidXQgaXMgdGhpcyBnZXR0aW5nIHRoZSBwZXJfY3B1
X2NhY2hlaW5mbw0KYW5kIHRoZW4gaW5jcmVtZW50aW5nIGludGVudGlvbmFsbHksIG9yIGlzIGl0
IG1lYW50IHRvIGdldCB0aGUNCnBlcl9jcHVfY2FjaGVpbmZvIG9mIGNwdSArIGlkeD8NCg==
