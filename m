Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0615614FE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 10:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233296AbiF3I02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 04:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233863AbiF3I0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 04:26:05 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113C7656C;
        Thu, 30 Jun 2022 01:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1656577550; x=1688113550;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PEwLPjZpYspPaBQlvbwr8io5fAtK7miWnN+Y/uX72TE=;
  b=zFOk5kxNPAU7q7BhXYlm7j8XoLV/O4iBRUej/P6xYX+5NzBmcZLSsfo0
   5RYIBxF7KrLaB8kZaa2L66I/xLmJaIYScRb72zKQM/5uaHrg5mxTRE6L3
   2wWjqW63KEaLHk3XJeDBLkDcFAHavy4ZYlrIUjga4dXidNn/Yc3AWfkdM
   nevaCWTYXBDehr/J2SCTT+AE4k4YYbm7/y0RuH/LlkTw3aUtnN/yfmsWf
   MvPHG4WxDmPSuC8F4FovRsSXFVE0TM1IhbD0WHEZ+p0lsoO8CfP4uxe+l
   MYNjUvHCeIHMvwGmpWZBrnitSJqTr8Duovq2kDhXRcmkA5i5DB4WtItuu
   w==;
X-IronPort-AV: E=Sophos;i="5.92,233,1650956400"; 
   d="scan'208";a="170494875"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Jun 2022 01:25:50 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 30 Jun 2022 01:25:50 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Thu, 30 Jun 2022 01:25:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q7gvInx3CZo1xv/RPQ4Dc5KnI/5hIUEcR1NFvLiOdQbw7XS75nHfaF10qPZ8gJ4WtUpS+uc4A5neE1fUad8oSu8p4ty6jXZU7gvTigR8wQRxEOLEgqi/RbP2FXsM8k+SpEoxVh9a+WzOhtlAxrdVFIDxboWV9mqVr13CdIIO1swSQVF6JFuAIIX/D7QJTCKaOJ23c2FGTr2BEU1VTOzE7AYycrHXRH2QcJncGYz7/pVm5tzI9NVWX5ezhCRhbnyY6LSwnYtSCkTopKjwLPWxdmDyMKxPNFgZqzOmKPgta89ERo0cuvChC5T+YMPk8JLUrzOlbaYmem9LQEI9hsmVSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PEwLPjZpYspPaBQlvbwr8io5fAtK7miWnN+Y/uX72TE=;
 b=AIsMxAtIQFLQiF+00J/ugGp1kKPDEbY0/H+yEQds8FcFpJWrumDK4FtYZ9S5tpYKQCKcBYxt3zagwdGv7dKbTaYin64OEpFCz3eK0F/TRDbd+JuWd4GP69P1vjdisIFc5zDIPk24UeJej4O+MGNdfyu8Hsuv+xnv5DL9hbLTRhLtNl5JgqpqxCsDbwlU6cpDpHuGSMgSza/c0i0a/zCJ0ZclF6YrUSE7048XsOupZBi6bxlyqTAeJW+ZWT9mUtAbCbuUFocblhirC2L2B6ybTus5mvHV9lNKbmDgediB4xk2qUBcajeDvVjEEsae0/+pzU8/5pXatMgHPoAglDOB/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PEwLPjZpYspPaBQlvbwr8io5fAtK7miWnN+Y/uX72TE=;
 b=f0IOlt0xUE/KqwHvGpJtwXEiCP0SLo+jKrsK90wwtX9vz1jeRMzNK1II18JJhZ2utQqtUddeDp256JoXwEFpVgj8Rn76bZiWKZA2+ZY1CnvC1FIQTJ0z94FJBHW8IO4huNTD03z4uxHjmz84LjccnDuM5Sq/iagiBwiUnLram0A=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by LV2PR11MB5998.namprd11.prod.outlook.com (2603:10b6:408:17e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Thu, 30 Jun
 2022 08:25:45 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5c8c:c31f:454d:824c]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5c8c:c31f:454d:824c%8]) with mapi id 15.20.5395.015; Thu, 30 Jun 2022
 08:25:45 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <paul@crapouillou.net>, <wim@linux-watchdog.org>,
        <linux@roeck-us.net>
CC:     <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 5/8] watchdog: sama5d4_wdt: Remove #ifdef guards for PM
 related functions
Thread-Topic: [PATCH 5/8] watchdog: sama5d4_wdt: Remove #ifdef guards for PM
 related functions
Thread-Index: AQHYjFr+tBnNCEvqU0SEKBltuKHVJw==
Date:   Thu, 30 Jun 2022 08:25:44 +0000
Message-ID: <8b264c68-fd88-2231-7704-7c711b77e048@microchip.com>
References: <20220628193449.160585-1-paul@crapouillou.net>
 <20220628193449.160585-6-paul@crapouillou.net>
In-Reply-To: <20220628193449.160585-6-paul@crapouillou.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ab5b6382-cc5c-44d0-9d15-08da5a7220cf
x-ms-traffictypediagnostic: LV2PR11MB5998:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1y1oDLbLMGzrnIGlO/CBlMjlskR4tEVvWZlhYzbD5U1DH/Jljre0aFsE07gKrdAr9pylTW9Eomd0TbuYberANeVAZWWzU4Czk73iUNRgY2cjVGi3LfeiHdZTxadHOBTmJ8k3ChjvK09HGuo1I8LsM5Cw6tjOTOK9fm6+gjlwzUKaU5x/guR6MmIAe8INg4jXfWqQ95jZVjTNCjsUfmbAf5eNhzdpsBx1t9y+HtNunyjZBCE/tsboY9VZxshteZ9UePn5xMKzfhAn/ItCoFObX+qa6rld/u3jvYuHYbfggMgI4J7XrxIwQT/uDEobbLCoUHz5vHd8VzykQBfpqdInjBP4tT2qPdvAV3DACs3xbX+H7GQuozkEStT3cwdWaKCh+AIOLZTosC4xcZiEkY5rputulJmLAkRGO84K6EpA9aum5Txq5N1ijIyZH5fdgUo9a7YEALHYxNbugon97BNMNXtaGbSG7d2tnsslbbRlLb9RRDWn+Zgq8LsNEaQhuJeVh2bDYg6NI8VWWStU8QDANfBhJNBB0vgFadOlIvUkX8haG0c/2Sf4xYimZnyE+JiMQz0JHPS6FXuhECqmvD/yiia5QpFp+mVnVn5Fj0l4OmvPxN++wpqRe8tzXy11KfvtdlvKVfsnXVTxuXyCd5lIV+FFl/p/v6cotezfIycIyMdNpHX/JOSf1q2KHOr6txV6BHhkqA7lYsBL9zLr0FWwqRuV6zFt3UVzIlONQu/OqQPyBIXbnF0YEmJWlo+0IDIpUGBTqoz1ZmkLQgXW9asvacoGziSGXE+Fim8xEz1E8kGytiHsh23oyO4nmxFphyRThS1HGk6snwRqEOudIHmHJEyzRrsfr5WQQ7C7+zbGguVuhvxyYxlkCmuowN9H44jS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(346002)(376002)(366004)(136003)(396003)(66556008)(8676002)(6486002)(71200400001)(31696002)(4326008)(66946007)(38070700005)(64756008)(66446008)(41300700001)(53546011)(26005)(86362001)(478600001)(6506007)(91956017)(76116006)(6512007)(66476007)(83380400001)(8936002)(36756003)(122000001)(2906002)(38100700002)(110136005)(2616005)(54906003)(316002)(31686004)(5660300002)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N2hDZTVhZ0V5UjZ3UVB6WFVuQnZnVXl5RUZRK3U5QWhnZnlpYjlEclcvRnVy?=
 =?utf-8?B?bnNNMnFmUFBydUpoR2IxMW9TbE01SWtlK3NjdVBhanlJU2FPRmZDWm9QVnd6?=
 =?utf-8?B?UlptWXpUaGs0V3N3cXcyZFdRT0JqZllmWXlNalM0K3JnNXRGR2tjWW1NTTFs?=
 =?utf-8?B?azVBQnc4bUgyT3ZQdTdPL2d6K3oxSGoxZnJoWGxQdXJXQmt5SEtSYmVFR3RW?=
 =?utf-8?B?VW1aS2pwRGxWd1o3Z0Z6TzVLMG9mMDlEYXlabWN3RXU1eHlOa2c3NEthUWdN?=
 =?utf-8?B?eTNWY0JEWlN5dlFJVHQrdUc0d1JZMGRYeEJCOFZBTmhVQk9nSVYyOGhjT1kr?=
 =?utf-8?B?cUFTOUhwbkZLTWtPeDZtZ3R0Q0trVlVGbm1iUXdxRHU1eEdYcG12RDZ0cWhZ?=
 =?utf-8?B?T1pOU3ZPZzdVK3k5NzRmK0N5cE5IUEZta3lwelUwRFJ0MytCcGQ1bGcyZ0Q4?=
 =?utf-8?B?dyt5dWlOVjFpMm9FRkxpZGNQOFRCMDQvNDREdUdTeWhxNVpjeHR2TDAra29P?=
 =?utf-8?B?ZmZBS1lTV1lwUmh2cUtZUTllZS9Ed0l6ZEl1UU4yUzhWUm9KTzNtdWdKTmwy?=
 =?utf-8?B?eU5wTEhtWVU3c2lKUXNBeENnb3p0MFhZcnc3S05DV1NjUE9UVXgxZktKdE5G?=
 =?utf-8?B?Q0ZDckVKWTAvSitsWWVxT2tWcExFdDRxYXNTTjF0SUNWeFFWT2RJL0ZLZU1O?=
 =?utf-8?B?TUx3a1d3Z3lKWmg3V2ZrVVFkdFdpMEwwMm0vMkdka0p2RGJUbzhTQzdBZEJ3?=
 =?utf-8?B?WHlRZ2VMVDVzWGxRUFlzK2Q2cnNweEpLU0JXWFdyTEN1cnVvdDkrbUhDL2VO?=
 =?utf-8?B?cGZsRDNhQnNxR1NseS9rZytKVStqL2tQcm1mRm1PRnB6RFpVaktzU0s0TG1p?=
 =?utf-8?B?UUlYSXB4eW0xRkExVXpYK0poWFV4UEc4S2FKa1ZsMGwwOGdtT2ZZSTMrZ3RT?=
 =?utf-8?B?anJ5RW5CZitYZkc0NW01TXpHMmpxd2FQMnVtZVNSVUlhdHFkSGxSWGg1dzNN?=
 =?utf-8?B?OWdIczhLbUhSS1R4c1RsWmpJaWxneUFUZnVGK1dVVHVHZzdMeFo1MURydURm?=
 =?utf-8?B?eldURDF5SVN0MFczVm1pQVJVdVVqd1VraW1BdGtkZ1ZnMUVmeXJaenJVNWFL?=
 =?utf-8?B?YkxHc2ZqTjRkV2RlNG9Md25YanVacXRGN0ZWZzJmcU5uMzJvOWEyZDNicjdI?=
 =?utf-8?B?U091SkxzYmRTcG1KM2hHQUdLN3JEeUtHTEJVdnZPQmlWdmxaRGFrVGZYRWdo?=
 =?utf-8?B?Ymd5ZVNhNEc3TVBGMFRaclNEa1FIZno1ZWpXK1RjYm9TdDYzNHFzeUF6Y1Nl?=
 =?utf-8?B?c0pLSHdjUHRNeVdtMDFXcmNCNlZkSTlwQmFmaHEwZS9TRDV3Mk1idUVoQ0xs?=
 =?utf-8?B?UTlxMVY0Sy9veTNRMG9VejZYMlZwRDErMVVBcTJjb3lVcWFadXlwNlgxdkpp?=
 =?utf-8?B?a2hRa20rbEo5WkRpK3UvL0VOckNrYXdRUTVDeFl6SEtrL3JzZTA5cTNQRGZk?=
 =?utf-8?B?MlIwMGlwZk80cUFiMGEzNkM4WnBEVHhnN2V2WUpLdnRoc1NKMjVQeEYyMzZq?=
 =?utf-8?B?YmNWTGRaOG01RHY3dmdPY0R0OVhEdkZUMmJ6OGtSU2FTNUxkNmFMRU5xalVE?=
 =?utf-8?B?R2dUclV4aXBhUnowUEpWVnlJSjhKRDUvQXdWbk43REpOM1RSNnRTY3BTY2pQ?=
 =?utf-8?B?QzMwemRkcGk0Zk1Uc2xib3A4NURmL1dhVCtucmxnOHphQlkydG1QNHpzMWl1?=
 =?utf-8?B?YnNNRUxoRUpRenVWNlB1clo1N1VBOGRlSWh4U0xsTjdDelYvOCsvTk1ZNWl0?=
 =?utf-8?B?c1dNdkkxK3JRb0ZLeGpycTN3L3Z6OEVMQjAzTDRnWWM2UUh2TnUxcXhSMlJK?=
 =?utf-8?B?eEJRd1h2elVPL0tleUZrL3dKSWIxbmxFUXJWcGxTSWw1Si9nWExXaGlSaHRP?=
 =?utf-8?B?R0tyemVmbjI4VXJGL25HQS96bExkTEdXNlIvQkowVExNcGNUWVZIUnFBQzZ2?=
 =?utf-8?B?aHU4V05YMWx4bCt1WDFLNFY2SzJzZStIY0prNnlrY2FVa3p1QmtDMGUxWWpG?=
 =?utf-8?B?eUwvdjgrSHhKZEloa0NjVWRCdVhYd2Jsdk5EZ05xeEtxY25ESVF4U0tYMUpM?=
 =?utf-8?B?c2RnWDBuYTdxTkhFdmxENVo1Tm1lNll1SjI2L2dFQllIY2ZERnV0cWl5U1dM?=
 =?utf-8?B?Ymc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D110A8C205E54242A36B6CA14D3DFA1C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab5b6382-cc5c-44d0-9d15-08da5a7220cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2022 08:25:44.9438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nw5XHgWtKDGPjlRYOUnAWWbx8XyCRnRUTQB4SWF/iQT5irbc7TZsD3bG68xVdKEgRubZvx9Jt7LuiBp8hrExNkUFbZ89XS0UsujutyoUEdk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB5998
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjguMDYuMjAyMiAyMjozNCwgUGF1bCBDZXJjdWVpbCB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBVc2UgdGhlIG5ldyBMQVRFX1NZU1RFTV9TTEVF
UF9QTV9PUFMoKSBhbmQgcG1fc2xlZXBfcHRyKCkgbWFjcm9zIHRvDQo+IGhhbmRsZSB0aGUgLnN1
c3BlbmQvLnJlc3VtZSBjYWxsYmFja3MuDQo+IA0KPiBUaGVzZSBtYWNyb3MgYWxsb3cgdGhlIHN1
c3BlbmQgYW5kIHJlc3VtZSBmdW5jdGlvbnMgdG8gYmUgYXV0b21hdGljYWxseQ0KPiBkcm9wcGVk
IGJ5IHRoZSBjb21waWxlciB3aGVuIENPTkZJR19TVVNQRU5EIGlzIGRpc2FibGVkLCB3aXRob3V0
IGhhdmluZw0KPiB0byB1c2UgI2lmZGVmIGd1YXJkcy4gTm90IHVzaW5nICNpZmRlZiBndWFyZHMg
bWVhbnMgdGhhdCB0aGUgY29kZSBpcw0KPiBhbHdheXMgY29tcGlsZWQgaW5kZXBlbmRlbnRseSBv
ZiBhbnkgS2NvbmZpZyBvcHRpb24sIGFuZCB0aGFua3MgdG8gdGhhdA0KPiBidWdzIGFuZCByZWdy
ZXNzaW9ucyBhcmUgZWFzaWVyIHRvIGNhdGNoLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUGF1bCBD
ZXJjdWVpbCA8cGF1bEBjcmFwb3VpbGxvdS5uZXQ+DQo+IENjOiBOaWNvbGFzIEZlcnJlIDxuaWNv
bGFzLmZlcnJlQG1pY3JvY2hpcC5jb20+DQo+IENjOiBBbGV4YW5kcmUgQmVsbG9uaSA8YWxleGFu
ZHJlLmJlbGxvbmlAYm9vdGxpbi5jb20+DQo+IENjOiBDbGF1ZGl1IEJlem5lYSA8Y2xhdWRpdS5i
ZXpuZWFAbWljcm9jaGlwLmNvbT4NCj4gQ2M6IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZw0KDQpSZXZpZXdlZC1ieTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1p
Y3JvY2hpcC5jb20+DQoNCj4gLS0tDQo+ICBkcml2ZXJzL3dhdGNoZG9nL3NhbWE1ZDRfd2R0LmMg
fCA4ICsrKy0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCA1IGRlbGV0
aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvd2F0Y2hkb2cvc2FtYTVkNF93ZHQu
YyBiL2RyaXZlcnMvd2F0Y2hkb2cvc2FtYTVkNF93ZHQuYw0KPiBpbmRleCBlYzIwYWQ0ZTUzNGYu
LmFlZWU5MzRjYTUxYiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy93YXRjaGRvZy9zYW1hNWQ0X3dk
dC5jDQo+ICsrKyBiL2RyaXZlcnMvd2F0Y2hkb2cvc2FtYTVkNF93ZHQuYw0KPiBAQCAtMzM5LDcg
KzMzOSw2IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIHNhbWE1ZDRfd2R0X29m
X21hdGNoW10gPSB7DQo+ICB9Ow0KPiAgTU9EVUxFX0RFVklDRV9UQUJMRShvZiwgc2FtYTVkNF93
ZHRfb2ZfbWF0Y2gpOw0KPiANCj4gLSNpZmRlZiBDT05GSUdfUE1fU0xFRVANCj4gIHN0YXRpYyBp
bnQgc2FtYTVkNF93ZHRfc3VzcGVuZF9sYXRlKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gIHsNCj4g
ICAgICAgICBzdHJ1Y3Qgc2FtYTVkNF93ZHQgKndkdCA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0K
PiBAQCAtMzY2LDE4ICszNjUsMTcgQEAgc3RhdGljIGludCBzYW1hNWQ0X3dkdF9yZXN1bWVfZWFy
bHkoc3RydWN0IGRldmljZSAqZGV2KQ0KPiANCj4gICAgICAgICByZXR1cm4gMDsNCj4gIH0NCj4g
LSNlbmRpZg0KPiANCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZGV2X3BtX29wcyBzYW1hNWQ0X3dk
dF9wbV9vcHMgPSB7DQo+IC0gICAgICAgU0VUX0xBVEVfU1lTVEVNX1NMRUVQX1BNX09QUyhzYW1h
NWQ0X3dkdF9zdXNwZW5kX2xhdGUsDQo+IC0gICAgICAgICAgICAgICAgICAgICAgIHNhbWE1ZDRf
d2R0X3Jlc3VtZV9lYXJseSkNCj4gKyAgICAgICBMQVRFX1NZU1RFTV9TTEVFUF9QTV9PUFMoc2Ft
YTVkNF93ZHRfc3VzcGVuZF9sYXRlLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBzYW1hNWQ0X3dkdF9yZXN1bWVfZWFybHkpDQo+ICB9Ow0KPiANCj4gIHN0YXRpYyBzdHJ1Y3Qg
cGxhdGZvcm1fZHJpdmVyIHNhbWE1ZDRfd2R0X2RyaXZlciA9IHsNCj4gICAgICAgICAucHJvYmUg
ICAgICAgICAgPSBzYW1hNWQ0X3dkdF9wcm9iZSwNCj4gICAgICAgICAuZHJpdmVyICAgICAgICAg
PSB7DQo+ICAgICAgICAgICAgICAgICAubmFtZSAgID0gInNhbWE1ZDRfd2R0IiwNCj4gLSAgICAg
ICAgICAgICAgIC5wbSAgICAgPSAmc2FtYTVkNF93ZHRfcG1fb3BzLA0KPiArICAgICAgICAgICAg
ICAgLnBtICAgICA9IHBtX3NsZWVwX3B0cigmc2FtYTVkNF93ZHRfcG1fb3BzKSwNCj4gICAgICAg
ICAgICAgICAgIC5vZl9tYXRjaF90YWJsZSA9IHNhbWE1ZDRfd2R0X29mX21hdGNoLA0KPiAgICAg
ICAgIH0NCj4gIH07DQo+IC0tDQo+IDIuMzUuMQ0KPiANCg0K
