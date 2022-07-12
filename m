Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8271F5727BA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 22:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233793AbiGLUvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 16:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbiGLUvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 16:51:02 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFBFD252B6;
        Tue, 12 Jul 2022 13:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657659061; x=1689195061;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=XjzPKMP4nNJx0734SHImK8LI1jnpqj92sctUQOLjd/o=;
  b=Kxk72dAdTjaayUBnSkmWLA2y8i4OBvITah3Bqgxvs9VMetlSC7XL9l+q
   jiXRihtw2HmUq6MoBcK45AwquPyZEP2xMWgDJ2kDV+YZVFnTlo1jHtlD1
   20fGnsIhHgpCVdBS5PJ+cwo/43zycPZwkPB6VFKcMYQcGrBEg8QP2e1ga
   GsvQRlsSl2AaggkkVD5j+n2ij51Yv+kjae2cc0Nawrp80XA/zuVugdXgs
   0G7hGJmdDB9boMWUVu/HvuPCuRFWo7jCSEmMTefoeMEVHmsOyM+c8aFqy
   ItwMsNtQ+tDaSc9Db56BJnDx/usWjXQiylpQ0iX2iIzVnE0rww3Wt552A
   A==;
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="164438243"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Jul 2022 13:51:00 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 12 Jul 2022 13:50:56 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Tue, 12 Jul 2022 13:50:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TwhXDcKebulitclM0P3oDaWJoLvbKPXXkiEfR0uU7maWObGFq1jgkUyH8bdARiIa2Psc18Qe5DQQgYAsz4hkLOJkQsew7f4w6+Hzku7ZCspgElWaEzreUh5fS+DPc592Gog4UbVlIn6zrRGXm7P9rUHFDEAuPoNXCjRJv4g5RGuJsXsA2StWKzbvtpVuYvfAB2J4AdaRpAgKTCJzVfcq4IT2OXVX5mCXT6Md3rHfyrxzGsCzhro7pt5mnOdgWnChgNvnWje6h7BFjxitvw8ZU0f4h9j0xYSVnU8aYIcT8gyjPdrv2lWzIIHVRVOITHiyffwyyGjw9L5t00vy8GDzDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XjzPKMP4nNJx0734SHImK8LI1jnpqj92sctUQOLjd/o=;
 b=SHNMR22FHcKd4mmPQKQ8fzbkoEYPpTrHKl5FALdoYLiYd0tJO1ZL3pnbdF9NUZqCCGfhNkLg97p8UO5l/tNssuZfVYYnVBoHHHdr0Mo1SnPvQR1phwas/bN0GlO06mLwhDjr8GwpYjHcUOKqDtGElmEGXScpnkosa2d/MliRkivFcZZIuOaNuTSToc92hYeqFA0DKNeCzuxwoOJt18x8Kja7aa9sWp99gCMFJGYgUzJEeoBrKfFDt+KDiWehY4A1brc6FjSFNUkr/WJuYu8xfMUE7ZtokgDfZco3a3J8RjbBmE9/gcfQdss0VLEcAh5OE3/B2t9NcT/fRxLk929GcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XjzPKMP4nNJx0734SHImK8LI1jnpqj92sctUQOLjd/o=;
 b=Rd3Cg1352G5iIZVqS1n+vFSVXY3SvOrYcfwxTC8PSgM1qHF2mXATT7DsHreuHfCHaXCZK1gxxRgARkwmZvhr3Hdt8off9r4+yYlvyhg5JRIgbIdJPGsBpMjEGtwA5Ro5PcpM/6hxNygfXFEGgBxUgE50oIPAn1fW/J9Nwj9d4xk=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DM4PR11MB6382.namprd11.prod.outlook.com (2603:10b6:8:be::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Tue, 12 Jul
 2022 20:50:54 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::8d4a:1681:398d:9714]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::8d4a:1681:398d:9714%5]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 20:50:54 +0000
From:   <Conor.Dooley@microchip.com>
To:     <yangyingliang@huawei.com>
CC:     <Daire.McNamara@microchip.com>, <broonie@kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH -next 2/2] spi: microchip-core: switch to use
 devm_spi_alloc_master()
Thread-Topic: [PATCH -next 2/2] spi: microchip-core: switch to use
 devm_spi_alloc_master()
Thread-Index: AQHYlfWKEaKO0rADDkGuzfTu66tTVK16xHiAgABxw4A=
Date:   Tue, 12 Jul 2022 20:50:54 +0000
Message-ID: <687d4652-c231-bfa5-f76f-ac826ab1fe98@microchip.com>
References: <20220712135357.918997-1-yangyingliang@huawei.com>
 <20220712135357.918997-2-yangyingliang@huawei.com>
 <87581e76-ceb7-9efa-d6dd-5ad4fe66111a@microchip.com>
In-Reply-To: <87581e76-ceb7-9efa-d6dd-5ad4fe66111a@microchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 15dc67eb-bac3-47f8-b013-08da64483692
x-ms-traffictypediagnostic: DM4PR11MB6382:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vsrK/BYwUi2SyJVG5Xf+svk6QsYyTtKmnIloid8FNH+0tmm3vQXU80+Xurbu+IMyvHRy49nqPhZZFQbZeiJ3ndAI0t7qVXJz6HOTV9JqV/3dOi6V6TwW5wxj0pPxNAqVnzrZ80LguurR5oB9xZuC3Csmjk7mU+7ti/y+PCqePMXxPusUx5BU6rsT3pAJg1M988qu9ykCxli1c6i6dd4qySY4kv3ZEQ7pNTYaCkBcFHHAReExZ2+Y9gdNhLgxQFpLGjtjZvKu3apLRo38dT5gaIdFKWQw3Bpx5zTAsKN/A/Tw7Ar6cJs7KLKLiSJmA+HjmJNqP3K8VbS9N3wzGd9i7CgPpzcWTA+Ypm651dHd9S0dvvwW7aemePMMZOnN/UlYo9asEJFRjWe1M6YQBT5h//lyFootuZ04d6w5FWyrS5l3IlXw5qgoSf7iWDexsXLQFTcXdVQQHCN6nNBd2Z42c8QBHGjI96iauONH7cehf9NvpStPzi44h4hBNZ/94X28krjUPH9lCGw1fmE+1q9ROQOUGSamzNTubHB1A7cDcqXhA/NeTaF8G9whiqyz3RVj8Zx7UFzatEBhbx8VNBnujhppXNXODSyCWnoR2F8PnDGVYJLEo4HJhX07iRsslUKdZ4nGPaYu2uXh+55QZUKMGRB8USym7QrHn/3q1MZIbZzLNSLhvdXQ+dEQtNSG8HNB7py7Ak6J2g7Nw3WOcXobx6T2j4pZABLsORIYfqLRD8cj75P4zOlwptRutCeZnhDF/BSx2/Ui5K8YaDO5l8qtLC75YxQGo9caRq5eNQRLihiSQxIHYI5/XAVY7e9AUcpkrPTSm9SKh7hlBvq3KeMZDZiUxo8OMpv/DRL6Jbo7SLiBHWPXz/16ThyCw7OxewjuxuUlWyFSl2MT+sjs9tvdr0vruh7kmAJr7TYg1utp8YM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(136003)(396003)(39860400002)(366004)(83380400001)(38070700005)(76116006)(71200400001)(6916009)(186003)(66556008)(31686004)(8676002)(54906003)(36756003)(66946007)(66446008)(4326008)(66476007)(122000001)(316002)(64756008)(91956017)(41300700001)(38100700002)(2906002)(6486002)(966005)(6506007)(86362001)(478600001)(26005)(53546011)(2616005)(5660300002)(8936002)(6512007)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cnNoclBDT3RTYmtOcFpaVStRUFpUdHRWb0oxUUZUOFdMdjRHN0dHakMra0Ra?=
 =?utf-8?B?Q1A4Z3AwbmpKQlYza3lQMVpwMjBPR1FzWlA3TXlSWmhtYkJYMktYK3M2NE1x?=
 =?utf-8?B?WDQvOUtrMjhtTG1ZcjN5eDBkYVBTR1QxZjFPNnEwT3ZFL1VyVk9mclhvR0Uz?=
 =?utf-8?B?SXpxem1vcHhOakZUYWtDU01kZ0JXOGd5Y285RDVaM1R1WlJwbFo4Nk1KNndK?=
 =?utf-8?B?WEVoVXc3SmwvcXR6Ujl3RTlESFV6SHdITmY3bFFhbk9oSkRnUlh2ZHY5ODJv?=
 =?utf-8?B?UmJFSFJqeHQ2VEI4alBFQUhLaFcvM2FVdTRjQ0xFdWw4eXh0Zjdha3BaYUNG?=
 =?utf-8?B?TStJODBFV2twU3hBSXpWNjI0RFVnU3haNkErWitCL2Vzc3F1VEtHajlCbFRh?=
 =?utf-8?B?bXErNUoxSzNwMGtBNUxQbTVveGlsUHpOVUVvb2QxWi9CdVpBVGF4ZStlQm4r?=
 =?utf-8?B?MUk5Qkc0VS8rY1pVVkVqVDZqT0NvZ0R3amtsYkE2cGtnWjJ0YlNPdk4xYkMw?=
 =?utf-8?B?Wi9INUxpTFhEaUl3UHBES1FZWjlnSENPSTdxdDc1bWF2dDJzeElKbXo2WklR?=
 =?utf-8?B?ZUZVWUw2cGMxbzdwSk5nSWFDRko1QzZ5R01JaWVDOEx0ekd4d2RPRHRHYlZ4?=
 =?utf-8?B?Wkx1K3VBeFV5dmRFYnV0VDlSRFQyT0NHTitpQ1lzaGtDUDMvUHJ2eEozSlFo?=
 =?utf-8?B?SlZySjl6SXZJbHNvSERkN1hCcmZhWjlqTU9NN0xVa0UwcmpCbnN2NGRtMjFC?=
 =?utf-8?B?VkZJTUJzcUEyODFDcTdmekN0Z0NZbUlCUXFTS3F0ajdjck9RL2xpUEVibzZN?=
 =?utf-8?B?bFFRSXVHd0ZJTTVPZmZpeXhXSUlPT3BnZU9GUFV4NnJramFMT05LZGRRRmhX?=
 =?utf-8?B?cVVPWVJQZ3pJSDhkTlJCSEdZaWMxcEh4dnlFME0xY2lXYmdwMmxiZjFEWUZr?=
 =?utf-8?B?eWhGV1pFeitveXE0amRTSm5ncU9ZM0piQXhPazZtYlY2Z3VHUnV3TE5VRHBv?=
 =?utf-8?B?cEN5SFd5TGFEcWlmSUZSSkZxV2pzWlU2UHlCckN5d3hFSWhudFR3Kzkza0VR?=
 =?utf-8?B?VFJjTWpmZW5HRWtVWFJlaDlKalNNdjNqQkR2aTZtRFA0UHJZa1Nnd3IrRzlS?=
 =?utf-8?B?c3VxQWNXWGRCeXg3MHJiYjRpWFg4OUlSNGJKckNvSjhGYjhUaEhJenIrMW9I?=
 =?utf-8?B?WG4xMFlKN2JMZ252ZnpsZXJyS1RTTEkzdHFuZDcydFhOd0c1MWd3aXdvK2Fy?=
 =?utf-8?B?dGFuZHoyd0xFbTR1eFYzSzdKc1ZqazhwWlZoSUxUcEp3VU1rWTNmdzRwS2pz?=
 =?utf-8?B?QXJpU1BaMy81bHNKZ3FDcmJrYW9Uem1rZG5lUERRZzYzb3JUdHRZZUs5U3Fm?=
 =?utf-8?B?M3ZtdkZ6STdPekZXcWd0Qk92Z2FwSmFtMDRNVDRhc0NhL0FDOEY2bUNCQzFH?=
 =?utf-8?B?SlVEVnZjRERjeXF0YkJYREZxL21JQ2xOY3pnUVRicXR5TmZGQjNQUU5SeWho?=
 =?utf-8?B?MnJxRjRvaVRTbjFYb3o5dlBtOUU2bkFwdWJFMkRlMXRuc081dVNMNDRKc0hS?=
 =?utf-8?B?OVh1U0g4dXo3STJGa1RTa0N3OXg0QjRUSk1raG5JN0tlenVUNnhGWDVHd3Vi?=
 =?utf-8?B?ODU4KzJWcFJHb0ZYczQxcGFwd2ZoVEx5eHc0R0FkeVV5aXNxWVpSeEFST1JJ?=
 =?utf-8?B?SVkrSmIwQmtiTmVwTGx3R2xkRjdBSSt6dS8rWDA1Z0xRSEV4REQ4TUdBckkx?=
 =?utf-8?B?Q0Qrek9JaDN0WlBIdzJ5b08wYXlvUDNLaFl0L3Zua3BxaC9VeC8rQnkxa28w?=
 =?utf-8?B?T1E2UWVuYjB6SXhpRnBDdURXV2tjMTRZMVlQckliVWlaYVhyK2FYMDZUTXZZ?=
 =?utf-8?B?RDU2MmQvaWlESEI0Z0pLMXV2TklrN3dnMysyQTE1VGpXQW1XdVNUWk9QQnRL?=
 =?utf-8?B?RENJU0NtZy9Kd3pTQml3MFBQTHM4eHNsY2ozd3VDYmVsSTNUMGhGSG1Ra3U5?=
 =?utf-8?B?empWdk5JMDdveUdlZmo1ZGFibGdzQ3NadzJXbi9qR0g0ZlBVMDh2ejZsT1Zz?=
 =?utf-8?B?bm5BSlJ1enZHQ0pxUTNac3ZwZU9qNVlDbms5NnBHbkl0djMzdDJpUjBEaXVy?=
 =?utf-8?B?UHpRM2RQZm9aRkVEQ2x1aGFsSXdZZGkwaVNwc01TMDNXZG1LT05rKzN3WXNC?=
 =?utf-8?B?OVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <61877F942F49BB4BA42CA22D65E53F5A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15dc67eb-bac3-47f8-b013-08da64483692
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2022 20:50:54.1883
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 54xId2S3lbcjZgPcBP5szodgLR/lpzwWrGloi1VRlvLHoGmFDCb3wVRT25KVCUs3RBCdEjKwPNl85zgeaV5SNHDUuPCBmn8GEBNve/19dlo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6382
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIvMDcvMjAyMiAxNTowMywgQ29ub3IuRG9vbGV5QG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+
IE9uIDEyLzA3LzIwMjIgMTQ6NTMsIFlhbmcgWWluZ2xpYW5nIHdyb3RlOg0KPj4gW1NvbWUgcGVv
cGxlIHdobyByZWNlaXZlZCB0aGlzIG1lc3NhZ2UgZG9uJ3Qgb2Z0ZW4gZ2V0IGVtYWlsIGZyb20g
eWFuZ3lpbmdsaWFuZ0BodWF3ZWkuY29tLiBMZWFybiB3aHkgdGhpcyBpcyBpbXBvcnRhbnQgYXQg
aHR0cHM6Ly9ha2EubXMvTGVhcm5BYm91dFNlbmRlcklkZW50aWZpY2F0aW9uIF0NCj4+DQo+PiBF
WFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5s
ZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4+DQo+PiBTd2l0Y2ggdG8gdXNlIGRl
dm1fc3BpX2FsbG9jX21hc3RlcigpIHRvIHNpbXBpZnkgZXJyb3IgcGF0aC4NCj4gDQo+IEhleSBZ
YW5nLA0KPiBUaGFua3MgZm9yIHRyeWluZyB0byBmaXggbXkgbWlzdGFrZXMhDQo+IA0KPiBGb3Jn
aXZlIG15IGlubm9jZW5jZSBoZXJlLCBidXQgd2h5IGlzIGl0IG9rYXkgdG8gcmVtb3ZlIHRoZQ0K
PiBzcGlfbWFzdGVyX3B1dCgpIGluIHJlbW92ZSgpIGJ1dCBub3QgdGhlIG9uZSBpbiB0aGUgZXJy
b3IgcGF0aCBvZg0KPiB0aGUgcHJvYmUgZnVuY3Rpb24/DQo+IA0KPiBJZiB0aGUgZGV2bV9hZGRf
YWN0aW9uX29yX3Jlc2V0KCkgaW4gZGV2bV9zcGlfcmVnaXN0ZXJfY29udHJvbGxlcigpDQo+IGZh
aWxzIHdvbid0IHRoZSBzYW1lIHRoaW5nIGFwcGx5IHRvIHRoZSBwcm9iZSBlcnJvciBwYXRoPw0K
PiANCj4gSU9XLCBJIHRoaW5rIHRoaXMgcGF0Y2ggbmVlZHMgYSBmaXhlcyB0YWcgdG9vIGIvYyBp
dCBhbHNvIGZpeGVzIGENCj4gcmVmY291bnQgdW5kZXJmbG93LiBQbGVhc2UgY29ycmVjdCBtZSBp
ZiBJIGFtIG1pc3VuZGVyc3RhbmRpbmcuDQoNCkFoaCwgSSBqdXN0IHNhdyB5b3VyIHJldmVydCBv
ZiA1OWViYmU0MGZiNTEgKCJzcGk6IHNpbXBsaWZ5DQpkZXZtX3NwaSByZWdpc3Rlcl9jb250cm9s
bGVyIikuIFdpdGggdGhhdCwgdGhpcyBtYWtlcyBhIGxvdCBtb3JlDQpzZW5zZS4NCg0KPiANCj4g
T25lIG90aGVyIGNvbW1lbnQgYmVsb3cuDQoNClRoaXMgY29tbWVudCBzdGlsbCBhcHBsaWVzIGZv
ciB0aGlzIHBhdGNoLiBkZXZfZXJyX3Byb2JlIHdvdWxkIGJlDQpuaWNlLg0KDQpUaGFua3MsDQpD
b25vci4NCg0KPiANCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBZYW5nIFlpbmdsaWFuZyA8eWFuZ3lp
bmdsaWFuZ0BodWF3ZWkuY29tPg0KPj4gLS0tDQo+PiAgIGRyaXZlcnMvc3BpL3NwaS1taWNyb2No
aXAtY29yZS5jIHwgMjAgKysrKysrKy0tLS0tLS0tLS0tLS0NCj4+ICAgMSBmaWxlIGNoYW5nZWQs
IDcgaW5zZXJ0aW9ucygrKSwgMTMgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvc3BpL3NwaS1taWNyb2NoaXAtY29yZS5jIGIvZHJpdmVycy9zcGkvc3BpLW1pY3JvY2hp
cC1jb3JlLmMNCj4+IGluZGV4IGMyNjc2NzM0MzE3Ni4uMWEyNGU0N2Y4MzA1IDEwMDY0NA0KPj4g
LS0tIGEvZHJpdmVycy9zcGkvc3BpLW1pY3JvY2hpcC1jb3JlLmMNCj4+ICsrKyBiL2RyaXZlcnMv
c3BpL3NwaS1taWNyb2NoaXAtY29yZS5jDQo+PiBAQCAtNTEzLDcgKzUxMyw3IEBAIHN0YXRpYyBp
bnQgbWNocF9jb3Jlc3BpX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+PiAg
ICAgICAgICB1MzIgbnVtX2NzOw0KPj4gICAgICAgICAgaW50IHJldCA9IDA7DQo+Pg0KPj4gLSAg
ICAgICBtYXN0ZXIgPSBzcGlfYWxsb2NfbWFzdGVyKCZwZGV2LT5kZXYsIHNpemVvZigqc3BpKSk7
DQo+PiArICAgICAgIG1hc3RlciA9IGRldm1fc3BpX2FsbG9jX21hc3RlcigmcGRldi0+ZGV2LCBz
aXplb2YoKnNwaSkpOw0KPj4gICAgICAgICAgaWYgKCFtYXN0ZXIpDQo+PiAgICAgICAgICAgICAg
ICAgIHJldHVybiBkZXZfZXJyX3Byb2JlKCZwZGV2LT5kZXYsIC1FTk9NRU0sDQo+PiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJ1bmFibGUgdG8gYWxsb2NhdGUgbWFzdGVy
IGZvciBTUEkgY29udHJvbGxlclxuIik7DQo+PiBAQCAtNTM1LDM2ICs1MzUsMzIgQEAgc3RhdGlj
IGludCBtY2hwX2NvcmVzcGlfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4+
ICAgICAgICAgIHNwaSA9IHNwaV9tYXN0ZXJfZ2V0X2RldmRhdGEobWFzdGVyKTsNCj4+DQo+PiAg
ICAgICAgICBzcGktPnJlZ3MgPSBkZXZtX3BsYXRmb3JtX2dldF9hbmRfaW9yZW1hcF9yZXNvdXJj
ZShwZGV2LCAwLCAmcmVzKTsNCj4+IC0gICAgICAgaWYgKElTX0VSUihzcGktPnJlZ3MpKSB7DQo+
PiAtICAgICAgICAgICAgICAgcmV0ID0gUFRSX0VSUihzcGktPnJlZ3MpOw0KPj4gLSAgICAgICAg
ICAgICAgIGdvdG8gZXJyb3JfcmVsZWFzZV9tYXN0ZXI7DQo+PiAtICAgICAgIH0NCj4+ICsgICAg
ICAgaWYgKElTX0VSUihzcGktPnJlZ3MpKQ0KPj4gKyAgICAgICAgICAgICAgIHJldHVybiBQVFJf
RVJSKHNwaS0+cmVncyk7DQo+Pg0KPj4gICAgICAgICAgc3BpLT5pcnEgPSBwbGF0Zm9ybV9nZXRf
aXJxKHBkZXYsIDApOw0KPj4gICAgICAgICAgaWYgKHNwaS0+aXJxIDw9IDApIHsNCj4+ICAgICAg
ICAgICAgICAgICAgZGV2X2VycigmcGRldi0+ZGV2LCAiaW52YWxpZCBJUlEgJWQgZm9yIFNQSSBj
b250cm9sbGVyXG4iLCBzcGktPmlycSk7DQo+PiAtICAgICAgICAgICAgICAgcmV0ID0gLUVOWElP
Ow0KPj4gLSAgICAgICAgICAgICAgIGdvdG8gZXJyb3JfcmVsZWFzZV9tYXN0ZXI7DQo+PiArICAg
ICAgICAgICAgICAgcmV0dXJuIC1FTlhJTzsNCj4gDQo+IEFsc28gdGhlc2UgY2FuIG5vdyBiZWNv
bWUgZGV2X2Vycl9wcm9iZSBmb3IgZnVydGhlciBzaW1wbGlmaWNhdGlvbj8NCj4gVGhhbmtzLA0K
PiBDb25vci4NCj4gDQo+PiAgICAgICAgICB9DQo+Pg0KPj4gICAgICAgICAgcmV0ID0gZGV2bV9y
ZXF1ZXN0X2lycSgmcGRldi0+ZGV2LCBzcGktPmlycSwgbWNocF9jb3Jlc3BpX2ludGVycnVwdCwN
Cj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgSVJRRl9TSEFSRUQsIGRldl9uYW1l
KCZwZGV2LT5kZXYpLCBtYXN0ZXIpOw0KPj4gICAgICAgICAgaWYgKHJldCkgew0KPj4gICAgICAg
ICAgICAgICAgICBkZXZfZXJyKCZwZGV2LT5kZXYsICJjb3VsZCBub3QgcmVxdWVzdCBpcnE6ICVk
XG4iLCByZXQpOw0KPj4gLSAgICAgICAgICAgICAgIGdvdG8gZXJyb3JfcmVsZWFzZV9tYXN0ZXI7
DQo+PiArICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4+ICAgICAgICAgIH0NCj4+DQo+PiAg
ICAgICAgICBzcGktPmNsayA9IGRldm1fY2xrX2dldCgmcGRldi0+ZGV2LCBOVUxMKTsNCj4+ICAg
ICAgICAgIGlmIChJU19FUlIoc3BpLT5jbGspKSB7DQo+PiAtICAgICAgICAgICAgICAgcmV0ID0g
UFRSX0VSUihzcGktPmNsayk7DQo+PiAgICAgICAgICAgICAgICAgIGRldl9lcnIoJnBkZXYtPmRl
diwgImNvdWxkIG5vdCBnZXQgY2xrOiAlZFxuIiwgcmV0KTsNCj4+IC0gICAgICAgICAgICAgICBn
b3RvIGVycm9yX3JlbGVhc2VfbWFzdGVyOw0KPj4gKyAgICAgICAgICAgICAgIHJldHVybiBQVFJf
RVJSKHNwaS0+Y2xrKTsNCj4+ICAgICAgICAgIH0NCj4+DQo+PiAgICAgICAgICByZXQgPSBjbGtf
cHJlcGFyZV9lbmFibGUoc3BpLT5jbGspOw0KPj4gICAgICAgICAgaWYgKHJldCkgew0KPj4gICAg
ICAgICAgICAgICAgICBkZXZfZXJyKCZwZGV2LT5kZXYsICJmYWlsZWQgdG8gZW5hYmxlIGNsb2Nr
XG4iKTsNCj4+IC0gICAgICAgICAgICAgICBnb3RvIGVycm9yX3JlbGVhc2VfbWFzdGVyOw0KPj4g
KyAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+PiAgICAgICAgICB9DQo+Pg0KPj4gICAgICAg
ICAgbWNocF9jb3Jlc3BpX2luaXQobWFzdGVyLCBzcGkpOw0KPj4gQEAgLTU4Myw4ICs1NzksNiBA
QCBzdGF0aWMgaW50IG1jaHBfY29yZXNwaV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpw
ZGV2KQ0KPj4gICBlcnJvcl9yZWxlYXNlX2hhcmR3YXJlOg0KPj4gICAgICAgICAgbWNocF9jb3Jl
c3BpX2Rpc2FibGUoc3BpKTsNCj4+ICAgICAgICAgIGNsa19kaXNhYmxlX3VucHJlcGFyZShzcGkt
PmNsayk7DQo+PiAtZXJyb3JfcmVsZWFzZV9tYXN0ZXI6DQo+PiAtICAgICAgIHNwaV9tYXN0ZXJf
cHV0KG1hc3Rlcik7DQo+Pg0KPj4gICAgICAgICAgcmV0dXJuIHJldDsNCj4+ICAgfQ0KPj4gLS0N
Cj4+IDIuMjUuMQ0KPj4NCj4gDQo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fDQo+IGxpbnV4LXJpc2N2IG1haWxpbmcgbGlzdA0KPiBsaW51eC1yaXNjdkBs
aXN0cy5pbmZyYWRlYWQub3JnDQo+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4v
bGlzdGluZm8vbGludXgtcmlzY3YNCg0K
