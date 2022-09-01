Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 053895A9C23
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 17:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233055AbiIAPtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 11:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbiIAPtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 11:49:42 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6F08C03F
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 08:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662047379; x=1693583379;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=D2uqCO1R71KFOV8LEIWCDETrnoKt67f6M1o924IRHSs=;
  b=Rl/sTQbKjVPpzYJkFTFeKIP7+YlC3fMzbgL0mV9bRB7h2eyJx1hq1mOj
   X54HpS5j3zPqjyxSqBlVkrkpPVJtC7Fl8TrAnyc7OwdJX6tgCtU/KaGCC
   dAvaNyL6kicEcuPe0QT46mY3hVlmkjT5+EkM7KNoPqBNogvE4lhhsBWAf
   wW2Ni2MqEjC963jMZda/yV7moyLRrORUfuBagAnKpm8RHUGirthnDTz0T
   6Gr1vqZv6ceFqHxeaggvXsbsTF0qpaEh8THhaZJL8FockDnw2D6pPM7Gk
   OsUJ3sU+wZ5eKygYmPro2Sekq3ctRtypPtPd0cfm5nnvvyFu/nTtbXpze
   A==;
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="111777543"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Sep 2022 08:49:38 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 1 Sep 2022 08:49:35 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Thu, 1 Sep 2022 08:49:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a2KYjjKXdaWlyippjeZnyNBJSRJKLmK47m20ag/IEvFe1IbVCy/3A66PiMjeDxKY98ZbJ27evjUcGySBHTV/Vq/BFBmZtZKa5PGnf8/N/0PSHw66RmoCOKt66v5Dn1TkuaRZFO8cHoLLBOhRkxXn1uE8dGTZEBruTizi7z7nuNzPElvXbQJ+8gzodR85rFs90SFTLOZVHAbx1FI7+qKVE79HkAXBW3XO/pxDkMN+fV0DS6YVX3JaKebGi1sBJTAJ2NTaCE7IKH0dMQ9pCoVBj7C4TfXGBLSgFj/U85uULeu0GOOBlKp0bHpY0eKQzTsLkwibGSKZnvWuAHsh2akBmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D2uqCO1R71KFOV8LEIWCDETrnoKt67f6M1o924IRHSs=;
 b=FZ2w/GU8gH5hBW8u5XojNn01aVLArpSaRirfubNyoWJrRjV0FA9h9uuXUZmWGfb0I7qPozqER3OhzHiisZQH72hZof7KmWsTo4eG2enabRlFdBvEMkR0MGNq7wOagEuiJ3w1TRejq2Mv6P7B/jvqm6TllTl38s/i8qSINp+fD7TArhs2NCjnkD51rEHbUF1vNwJYeZdLsrTpBZodgohHZfE6gxy27lrA4bjBs1dInW/PNGIUHrasvo+ltbtwdBCD2qufk7XaE4cGU2wCNUc361qwU6HK/Hb/nukCDkquHEw6sW83J4RB6eq1D3jhvjdoCu4lst0TxodKDYGAeIAI2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D2uqCO1R71KFOV8LEIWCDETrnoKt67f6M1o924IRHSs=;
 b=pqfoD5Ob3p4Pys0vsHIBG+101jJzl+vdiVE/ta1rWJXIYUSUWmWifIHVw50A++DZpVI7SJW6JiTVqboF5E1BEosLYNSR57E6s7IIfLOfMPoTh0/C6Lr2mM4kpY4FvvmqNxRoODlzFSODeSB754awvgWjtyvpjPRvdEb7msqTmmw=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by SJ0PR11MB5117.namprd11.prod.outlook.com (2603:10b6:a03:2d0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Thu, 1 Sep
 2022 15:49:25 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009%3]) with mapi id 15.20.5588.010; Thu, 1 Sep 2022
 15:49:25 +0000
From:   <Conor.Dooley@microchip.com>
To:     <heiko@sntech.de>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <apatel@ventanamicro.com>
CC:     <atishp@atishpatra.org>, <anup@brainfault.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <mchitale@ventanamicro.com>
Subject: Re: [PATCH v2 2/4] RISC-V: Move riscv_init_cbom_blocksize() to
 cacheflush.c
Thread-Topic: [PATCH v2 2/4] RISC-V: Move riscv_init_cbom_blocksize() to
 cacheflush.c
Thread-Index: AQHYvCu6DbOtrKcs1UurOXi7tX3bdK3KtsYAgAAFtIA=
Date:   Thu, 1 Sep 2022 15:49:25 +0000
Message-ID: <f8fc601a-9c2d-6b20-c2f0-78ba5ef81832@microchip.com>
References: <20220830044642.566769-1-apatel@ventanamicro.com>
 <20220830044642.566769-3-apatel@ventanamicro.com> <5909904.6fTUFtlzNn@diego>
In-Reply-To: <5909904.6fTUFtlzNn@diego>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 185f73cf-44c0-4132-093f-08da8c318bd9
x-ms-traffictypediagnostic: SJ0PR11MB5117:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Bj/Sgjr/8NBu3h8HLaFTh91yq/e3rmwxqchj7VaGtH6rwZ5Vw+xZxD2be2W1QyIdAITA7p/5uysuW4VJeUlv2uXFQBRc40WNs0SdJnjhWTQFfUq43a0P40l2ueKOTQ2CKjCrLqizVsfrnjccrg5pQ6M+bhsDztXVZKHq27NyhArXknDJILWFsPx1ieDVtDB7nl7nP8GHlXqwrRPpV4Tdk5kbeLgEZY2+kukGTufbQxUmzC/PYGe4sLvDMZ0nH2JIbSq1fcjRByCRAZpR9z1c4vMfWvUWHZVsofFMdx2lZNadumvnsioAXHDv+WBaVuzkGw/WhAxH08JiP2d2O0SgvR7B7KwkZAc3vTzLkSH/lSNIhJgym4FFpk2u7+P/dX9Y+Poz1WUTWe+FzUfDravuX9AnA9h1yUT6u3R9GpirGOsHuo8lAPTq3kcM980zdGQPX89SdjdvcbQzuG+vK5WtntTdRr3ew2UJTuFnjNWtctn/KY6I3Hex2zM+iihZkZJ0MkGYEb8zQKqCqkbS4swXLvoBXhSJj83rv5mFWHf/xM/OBsMvFn+C+nQ0XSznIMzfWVus8uv9tCUeju7ec5IfIHHZWhHiML90/OQ6cq99tsMlpnZfZtbteX/ALF/QmD5gDoXCQNeClwTCSzGs9UPyqOfgboaXjMzxfIqKLSHHUszL8eAd8uWGMoBkO2Oz4Oqx2qK7YAWsMNdt2CJFdOk8E8d+F4in4IAqUfmWotXCj/uyIoDpJCqr0zBLMUeLsjGxmPdV3S6IrbuwqjFZ0fARDVwQ+5BDPSQ+G9LNN+pCvVI3NxrF2s/wANQBF6cnxKop2LR6qMNxUTX0GV+B00mD1J9jDfqxMZmSSgY57pYbA7RvRDm78+2P4/grq2Kcbd2P2TQZlcqUdovzP7drmsFITQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(346002)(376002)(396003)(39860400002)(366004)(122000001)(54906003)(38070700005)(86362001)(31696002)(316002)(38100700002)(91956017)(8936002)(110136005)(2906002)(8676002)(66556008)(76116006)(66476007)(64756008)(83380400001)(66946007)(186003)(5660300002)(66574015)(2616005)(66446008)(31686004)(6486002)(966005)(71200400001)(4326008)(6512007)(53546011)(6506007)(26005)(41300700001)(36756003)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bW4xTHMxQ1U1KzNyMGxGaXpsKyt6bmgzb1NlUVdYNXNFdjR2b0NJUzlwYVFQ?=
 =?utf-8?B?S0xNREdjRGhqTGJKK0ExOVRtWXdiaWxUcXBacmdIYXNzazhrakZOYWdBTEMr?=
 =?utf-8?B?bGFwOTV1VXZUajR3NTQzbnJJbFVwSHc5a0RsY2M4TDg0MWQ0Y2hNVU4xcXRa?=
 =?utf-8?B?aUxiZ3c2RlN3cENSak9kd0JyOGJ1TFVtVVdSNkQyMGhrKzdrQVVTM252NEEv?=
 =?utf-8?B?N0crYnZ0RG5CQWxlZ2s0U0R3RXdwTTFMMEhpMk84MG9zL1dWSzhXcTdqeG9T?=
 =?utf-8?B?Rm1vd0FyeFROVDlBaXNDZERlOEgwZGFkdE5Zdy9tVm9wdVArelBQR1ZBMmpS?=
 =?utf-8?B?VHVSZTRiS2Y2bURZU0ppRURtSjVTYXJub2VUSVlhZlhFd0tvTUlLSThGTjR2?=
 =?utf-8?B?UU5lU2puYVFEWDZMcG5tZVlTTjRUVlEwUXhVSHdwbGtIMUdkQVh1TVlVaHpm?=
 =?utf-8?B?b0NlRk9HaFVMaE9rQmJXSEFzbWRkZUlOdXlUL0JydkVPL05PejZwQW5odVJl?=
 =?utf-8?B?QVpVTlZsMjN0N1hiS29HdUc5b0orbHpBazVoeTE1VW9kWWxQN2tlV3dRdWVl?=
 =?utf-8?B?czl1ZU0yTjFYbWEwT25QOEhpWFBRa2hMcE5wUmk3eENHck1HcWROK2VXK0N1?=
 =?utf-8?B?WFdMSnVLQmpXYmhzT2QzZzVWWTQzamgwaUQxY2wvKzNlTjduc2VBc0cxNzNF?=
 =?utf-8?B?eGx4WUtkcEdTdC9UZitjQ2RvQlp1SWpPMEVvSGtuN1lYcmlWWjNLcVh6clp2?=
 =?utf-8?B?SjNUOEs4R2EyT0ZRVU5nbE11dkw4VkhmWXBmQ3B3TU1iUjFlemFPZk5xcGky?=
 =?utf-8?B?SW9EcmlUVmFLdnY5S3RQU2V1WkVrb1hBUk9FSWRBMW9WM2ZibWgyYzd4YnVY?=
 =?utf-8?B?ZnBrQklXN2NLcG9ZczFXQzRFbUxYeUdvZHpyMjNyNHRLNEIrUytjemJmUXdL?=
 =?utf-8?B?OWlqQUtHblFxWktnbzJYWnFwTmZhdHU4bHl5VlRxZXN2SkJabDRBUllsNnlW?=
 =?utf-8?B?TjR6d1NURXN0c0dxYkZxak4xb1FwdjRseUNxTUR0SXRmZGJVYzdxUCtXSWZr?=
 =?utf-8?B?WG8vTkhISXlTUkhxQ1M2QldDMEVFcG9vT0R1aGNFVWdrd2p3UlM2aFE3dkto?=
 =?utf-8?B?NW1TaWhYZWZPSXNJWDg0U1QvVElwWWZmUWNJZVFscitoRU5HWnAycFEzZ3g0?=
 =?utf-8?B?dC9PdnNMY1lPNTV5azZoN3BsalFOS0YyMXFwejZkMzkxQWxwNVNIU1FwMkZ1?=
 =?utf-8?B?aGJ4WWhpc2NjWUdNUlhBVWo0WXVPNVcxNkFVblQwY0lKUklRNnp2SXdZL0JL?=
 =?utf-8?B?VHFuOUhIUDJDZ2ZTakpnTnd2VWduSCtZYzVFQ0lIRC9BRlVQbTl3TmY0QlFt?=
 =?utf-8?B?cmFSRjlLOXB6bm00NzRXczRpRjhzUWJCNnVDSVlrQVFrOXFNSUpDVFI4c3NO?=
 =?utf-8?B?d2J3dnVqM3UxaUw2VEcyUUZaMDQ5TDFrTEZaaURYNXQzbllxUkdFejVjOWtk?=
 =?utf-8?B?ckRhYUprOWdaRVNhbHBsZWtHdmZWNDRaNkJvbFE0YWxkNnM1OTVUaFpsUWtL?=
 =?utf-8?B?TlZwT295c1A4MFVmdGxnWTJZeUc1alpUQ0p2cytsNUp5aDhpRUFRZnE5YWI5?=
 =?utf-8?B?TkV6cUs5UWNROFdvWnQzUGdIRFdaRnF2UHdjanJKN3VEcnpFenlUWEV1QnJJ?=
 =?utf-8?B?OEN4UnllVXpLM3dEN1daWlAzNkJKN25YL2FDVm9zMDZrTCt2T2YyaWF1NnhU?=
 =?utf-8?B?WVRXZUFWc05ibFRJUGREbjhGSzBOYXZTYStUMnJlQVVwRkg1a0RVY1lGTmNX?=
 =?utf-8?B?T0lNcXVaVDhOc3ltakExcGZLSDlMTFIwYVRrU2FFYnBjeFVESkdlbW1UV0tM?=
 =?utf-8?B?S090R0tENFR4bVNZcFZnaGlNcDJNLzdqWFJoSi83c3RDaUZTR2RvajhiSktC?=
 =?utf-8?B?c1JwdE1VaEJGN3IrT1g5bElKVXVJZnRlemYvS0hOb2FldVRwcEoyUUVEb04v?=
 =?utf-8?B?V2lPT3p6cXFDTmFpT1dGZVNucjdCc2NSQlVvdEhtYjZKWksyR1lNVHVwZXJL?=
 =?utf-8?B?T2NqMjc1V2txTmdLK2tQL1lRSEFFTmhzeWZzeXZpeWV3YnNjQmYwTXErL2dN?=
 =?utf-8?B?RU5qQm9VallFRm1pYldsNWNOeTZYWWUwaWs4bC9NWUppS2t1Z2k0Q3R0SXJB?=
 =?utf-8?B?REE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9C84977C4105904FB1F5FF03A7FF1648@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 185f73cf-44c0-4132-093f-08da8c318bd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2022 15:49:25.3576
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nJWSLBWnpIW7Gn2v6Hwn3Q0Rsz2JpHYS6hW7O0p+2hLriSkDkaMv/ExPoP7PIZb8E/11QaweMSgWhup6hjCk5PvntcyBTA0gDtyJt8Itb8I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5117
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDEvMDkvMjAyMiAxNjoyOSwgSGVpa28gU3TDvGJuZXIgd3JvdGU6DQo+IEhpLA0KPiANCj4g
QW0gRGllbnN0YWcsIDMwLiBBdWd1c3QgMjAyMiwgMDY6NDY6NDAgQ0VTVCBzY2hyaWViIEFudXAg
UGF0ZWw6DQo+PiBUaGUgcmlzY3ZfY2JvbV9ibG9ja19zaXplIHBhcnNpbmcgZnJvbSBEVCBiZWxv
bmdzIHRvIGNhY2hlZmx1c2guYyB3aGljaA0KPj4gaXMgaG9tZSBmb3IgYWxsIGNhY2hlIG1haW50
ZW5hbmNlIHJlbGF0ZWQgc3R1ZmYgc28gbGV0IHVzIG1vdmUgdGhlDQo+PiByaXNjdl9pbml0X2Ni
b21fYmxvY2tzaXplKCkgYW5kIHJpc2N2X2Nib21fYmxvY2tfc2l6ZSB0byBjYWNoZWZsdXNoLmMu
DQo+Pg0KPj4gQ28tZGV2ZWxvcGVkLWJ5OiBNYXl1cmVzaCBDaGl0YWxlIDxtY2hpdGFsZUB2ZW50
YW5hbWljcm8uY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogTWF5dXJlc2ggQ2hpdGFsZSA8bWNoaXRh
bGVAdmVudGFuYW1pY3JvLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IEFudXAgUGF0ZWwgPGFwYXRl
bEB2ZW50YW5hbWljcm8uY29tPg0KPiANCj4gTWFrZXMgYSBsb3Qgb2Ygc2Vuc2UgdG8ga2VlcCBz
dHVmZiB0b2dldGhlci4NCj4gDQo+IFJldmlld2VkLWJ5OiBIZWlrbyBTdHVlYm5lciA8aGVpa29A
c250ZWNoLmRlPg0KPiBUZXN0ZWQtYnk6IEhlaWtvIFN0dWVibmVyIDxoZWlrb0BzbnRlY2guZGU+
DQo+IA0KPiANCj4gQWxzbywgY2FuIHdlIGhhbmRsZSB0aGlzIGFzIGZpeCBwYXRjaD8NCj4gDQo+
IEkuZS4gQ3VycmVudGx5IHRoZSB0LWhlYWQgY29kZSBzb21ld2hhdCByZWxpZXMgb24gdGhlIGRl
ZmF1bHQgdmFsdWUNCj4gc2V0IHRvIEwxX0NBQ0hFX0JZVEVTLiBUaGUgY2FjaGUtYmxvY2stc2l6
ZSBpcyBzdGF0aWMgdGhlcmUuDQo+IA0KPiBQYWxtZXJzIHVwY29taW5nIHBhdGNoIHJld29ya2lu
ZyB0aGUgcGFyc2luZyBbMF0sIHdpbGwgcmVtb3ZlIHRoYXQgZGVmYXVsdCwNCj4gc28gaGF2aW5n
IHRoZSByaXNjdl9jYm9tX2Jsb2NrX3NpemUgZGVmaW5lZCBpbiB0aGUgY2FjaGVmbHVzaCBoZWFk
ZXINCj4gd2lsbCBhbGxvdyBhbiBlYXN5IGZpeCBieSBzZXR0aW5nIHRoYXQgdmFsdWUgZnJvbSB0
aGUgdC1oZWFkIGVycmF0YSBpbml0DQo+IGZvciB0aG9zZSBjb3Jlcy4NCg0KQFBhbG1lciB3aGF0
IGlzIHRoZSBzdGF0dXMgb2YgdGhhdCBmaXg/DQpTaW5jZSBJIGhhdmUgYSBjbGFuZyB0b29sY2hh
aW4gc2V0IHVwLCBJIGNvdWxkIHNxdWFzaCBteSBmaXh1cC1mb3ItY2xhbmcgaW50bw0KeW91ciBw
YXRjaCBhbmQgcmVzcGluIGl0IGFzIGEgcmVhbCBwYXRjaCBmb3IgQW51cCB0byBiYXNlIG9uPw0K
DQpBbnl3YXksIEkgdG9vIGxpa2UgdGhpcyBjbGVhbnVwOg0KUmV2aWV3ZWQtYnk6IENvbm9yIERv
b2xleSA8Y29ub3IuZG9vbGV5QG1pY3JvY2hpcC5jb20+DQoNCj4gDQo+IA0KPiBIZWlrbw0KPiAN
Cj4gWzBdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyMjA4MTIxNTQwMTAuMTgyODAtMS1w
YWxtZXJAcml2b3NpbmMuY29tDQo+IA0KPj4gLS0tDQo+PiAgYXJjaC9yaXNjdi9pbmNsdWRlL2Fz
bS9jYWNoZWZsdXNoLmggfCAgMiArKw0KPj4gIGFyY2gvcmlzY3YvbW0vY2FjaGVmbHVzaC5jICAg
ICAgICAgIHwgMzkgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4+ICBhcmNoL3Jpc2N2
L21tL2RtYS1ub25jb2hlcmVudC5jICAgICB8IDM4IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0NCj4+ICAzIGZpbGVzIGNoYW5nZWQsIDQxIGluc2VydGlvbnMoKyksIDM4IGRlbGV0aW9ucygt
KQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9hcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL2NhY2hlZmx1c2gu
aCBiL2FyY2gvcmlzY3YvaW5jbHVkZS9hc20vY2FjaGVmbHVzaC5oDQo+PiBpbmRleCBhNjBhY2Fl
Y2ZlZGEuLmRlNTVkNmI4ZGVlYiAxMDA2NDQNCj4+IC0tLSBhL2FyY2gvcmlzY3YvaW5jbHVkZS9h
c20vY2FjaGVmbHVzaC5oDQo+PiArKysgYi9hcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL2NhY2hlZmx1
c2guaA0KPj4gQEAgLTQyLDYgKzQyLDggQEAgdm9pZCBmbHVzaF9pY2FjaGVfbW0oc3RydWN0IG1t
X3N0cnVjdCAqbW0sIGJvb2wgbG9jYWwpOw0KPj4gIA0KPj4gICNlbmRpZiAvKiBDT05GSUdfU01Q
ICovDQo+PiAgDQo+PiArZXh0ZXJuIHVuc2lnbmVkIGludCByaXNjdl9jYm9tX2Jsb2NrX3NpemU7
DQo+PiArDQo+PiAgI2lmZGVmIENPTkZJR19SSVNDVl9JU0FfWklDQk9NDQo+PiAgdm9pZCByaXNj
dl9pbml0X2Nib21fYmxvY2tzaXplKHZvaWQpOw0KPj4gICNlbHNlDQo+PiBkaWZmIC0tZ2l0IGEv
YXJjaC9yaXNjdi9tbS9jYWNoZWZsdXNoLmMgYi9hcmNoL3Jpc2N2L21tL2NhY2hlZmx1c2guYw0K
Pj4gaW5kZXggNmNiN2Q5NmFkOWM3Li4zMzZjNWRlZWE4NzAgMTAwNjQ0DQo+PiAtLS0gYS9hcmNo
L3Jpc2N2L21tL2NhY2hlZmx1c2guYw0KPj4gKysrIGIvYXJjaC9yaXNjdi9tbS9jYWNoZWZsdXNo
LmMNCj4+IEBAIC0zLDYgKzMsOCBAQA0KPj4gICAqIENvcHlyaWdodCAoQykgMjAxNyBTaUZpdmUN
Cj4+ICAgKi8NCj4+ICANCj4+ICsjaW5jbHVkZSA8bGludXgvb2YuaD4NCj4+ICsjaW5jbHVkZSA8
bGludXgvb2ZfZGV2aWNlLmg+DQo+PiAgI2luY2x1ZGUgPGFzbS9jYWNoZWZsdXNoLmg+DQo+PiAg
DQo+PiAgI2lmZGVmIENPTkZJR19TTVANCj4+IEBAIC04NiwzICs4OCw0MCBAQCB2b2lkIGZsdXNo
X2ljYWNoZV9wdGUocHRlX3QgcHRlKQ0KPj4gIAkJZmx1c2hfaWNhY2hlX2FsbCgpOw0KPj4gIH0N
Cj4+ICAjZW5kaWYgLyogQ09ORklHX01NVSAqLw0KPj4gKw0KPj4gK3Vuc2lnbmVkIGludCByaXNj
dl9jYm9tX2Jsb2NrX3NpemUgPSBMMV9DQUNIRV9CWVRFUzsNCj4+ICsNCj4+ICsjaWZkZWYgQ09O
RklHX1JJU0NWX0lTQV9aSUNCT00NCj4+ICt2b2lkIHJpc2N2X2luaXRfY2JvbV9ibG9ja3NpemUo
dm9pZCkNCj4+ICt7DQo+PiArCXN0cnVjdCBkZXZpY2Vfbm9kZSAqbm9kZTsNCj4+ICsJaW50IHJl
dDsNCj4+ICsJdTMyIHZhbDsNCj4+ICsNCj4+ICsJZm9yX2VhY2hfb2ZfY3B1X25vZGUobm9kZSkg
ew0KPj4gKwkJdW5zaWduZWQgbG9uZyBoYXJ0aWQ7DQo+PiArCQlpbnQgY2JvbV9oYXJ0aWQ7DQo+
PiArDQo+PiArCQlyZXQgPSByaXNjdl9vZl9wcm9jZXNzb3JfaGFydGlkKG5vZGUsICZoYXJ0aWQp
Ow0KPj4gKwkJaWYgKHJldCkNCj4+ICsJCQljb250aW51ZTsNCj4+ICsNCj4+ICsJCWlmIChoYXJ0
aWQgPCAwKQ0KPj4gKwkJCWNvbnRpbnVlOw0KPj4gKw0KPj4gKwkJLyogc2V0IGJsb2NrLXNpemUg
Zm9yIGNib20gZXh0ZW5zaW9uIGlmIGF2YWlsYWJsZSAqLw0KPj4gKwkJcmV0ID0gb2ZfcHJvcGVy
dHlfcmVhZF91MzIobm9kZSwgInJpc2N2LGNib20tYmxvY2stc2l6ZSIsICZ2YWwpOw0KPj4gKwkJ
aWYgKHJldCkNCj4+ICsJCQljb250aW51ZTsNCj4+ICsNCj4+ICsJCWlmICghcmlzY3ZfY2JvbV9i
bG9ja19zaXplKSB7DQo+PiArCQkJcmlzY3ZfY2JvbV9ibG9ja19zaXplID0gdmFsOw0KPj4gKwkJ
CWNib21faGFydGlkID0gaGFydGlkOw0KPj4gKwkJfSBlbHNlIHsNCj4+ICsJCQlpZiAocmlzY3Zf
Y2JvbV9ibG9ja19zaXplICE9IHZhbCkNCj4+ICsJCQkJcHJfd2FybigiY2JvbS1ibG9jay1zaXpl
IG1pc21hdGNoZWQgYmV0d2VlbiBoYXJ0cyAlZCBhbmQgJWx1XG4iLA0KPj4gKwkJCQkJY2JvbV9o
YXJ0aWQsIGhhcnRpZCk7DQo+PiArCQl9DQo+PiArCX0NCj4+ICt9DQo+PiArI2VuZGlmDQo+PiBk
aWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9tbS9kbWEtbm9uY29oZXJlbnQuYyBiL2FyY2gvcmlzY3Yv
bW0vZG1hLW5vbmNvaGVyZW50LmMNCj4+IGluZGV4IGNkMjIyNTMwNGM4Mi4uM2Y1MDJhMWE2OGIx
IDEwMDY0NA0KPj4gLS0tIGEvYXJjaC9yaXNjdi9tbS9kbWEtbm9uY29oZXJlbnQuYw0KPj4gKysr
IGIvYXJjaC9yaXNjdi9tbS9kbWEtbm9uY29oZXJlbnQuYw0KPj4gQEAgLTgsMTEgKzgsOCBAQA0K
Pj4gICNpbmNsdWRlIDxsaW51eC9kbWEtZGlyZWN0Lmg+DQo+PiAgI2luY2x1ZGUgPGxpbnV4L2Rt
YS1tYXAtb3BzLmg+DQo+PiAgI2luY2x1ZGUgPGxpbnV4L21tLmg+DQo+PiAtI2luY2x1ZGUgPGxp
bnV4L29mLmg+DQo+PiAtI2luY2x1ZGUgPGxpbnV4L29mX2RldmljZS5oPg0KPj4gICNpbmNsdWRl
IDxhc20vY2FjaGVmbHVzaC5oPg0KPj4gIA0KPj4gLXN0YXRpYyB1bnNpZ25lZCBpbnQgcmlzY3Zf
Y2JvbV9ibG9ja19zaXplID0gTDFfQ0FDSEVfQllURVM7DQo+PiAgc3RhdGljIGJvb2wgbm9uY29o
ZXJlbnRfc3VwcG9ydGVkOw0KPj4gIA0KPj4gIHZvaWQgYXJjaF9zeW5jX2RtYV9mb3JfZGV2aWNl
KHBoeXNfYWRkcl90IHBhZGRyLCBzaXplX3Qgc2l6ZSwNCj4+IEBAIC03NSw0MSArNzIsNiBAQCB2
b2lkIGFyY2hfc2V0dXBfZG1hX29wcyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHU2NCBkbWFfYmFzZSwg
dTY0IHNpemUsDQo+PiAgCWRldi0+ZG1hX2NvaGVyZW50ID0gY29oZXJlbnQ7DQo+PiAgfQ0KPj4g
IA0KPj4gLSNpZmRlZiBDT05GSUdfUklTQ1ZfSVNBX1pJQ0JPTQ0KPj4gLXZvaWQgcmlzY3ZfaW5p
dF9jYm9tX2Jsb2Nrc2l6ZSh2b2lkKQ0KPj4gLXsNCj4+IC0Jc3RydWN0IGRldmljZV9ub2RlICpu
b2RlOw0KPj4gLQlpbnQgcmV0Ow0KPj4gLQl1MzIgdmFsOw0KPj4gLQ0KPj4gLQlmb3JfZWFjaF9v
Zl9jcHVfbm9kZShub2RlKSB7DQo+PiAtCQl1bnNpZ25lZCBsb25nIGhhcnRpZDsNCj4+IC0JCWlu
dCBjYm9tX2hhcnRpZDsNCj4+IC0NCj4+IC0JCXJldCA9IHJpc2N2X29mX3Byb2Nlc3Nvcl9oYXJ0
aWQobm9kZSwgJmhhcnRpZCk7DQo+PiAtCQlpZiAocmV0KQ0KPj4gLQkJCWNvbnRpbnVlOw0KPj4g
LQ0KPj4gLQkJaWYgKGhhcnRpZCA8IDApDQo+PiAtCQkJY29udGludWU7DQo+PiAtDQo+PiAtCQkv
KiBzZXQgYmxvY2stc2l6ZSBmb3IgY2JvbSBleHRlbnNpb24gaWYgYXZhaWxhYmxlICovDQo+PiAt
CQlyZXQgPSBvZl9wcm9wZXJ0eV9yZWFkX3UzMihub2RlLCAicmlzY3YsY2JvbS1ibG9jay1zaXpl
IiwgJnZhbCk7DQo+PiAtCQlpZiAocmV0KQ0KPj4gLQkJCWNvbnRpbnVlOw0KPj4gLQ0KPj4gLQkJ
aWYgKCFyaXNjdl9jYm9tX2Jsb2NrX3NpemUpIHsNCj4+IC0JCQlyaXNjdl9jYm9tX2Jsb2NrX3Np
emUgPSB2YWw7DQo+PiAtCQkJY2JvbV9oYXJ0aWQgPSBoYXJ0aWQ7DQo+PiAtCQl9IGVsc2Ugew0K
Pj4gLQkJCWlmIChyaXNjdl9jYm9tX2Jsb2NrX3NpemUgIT0gdmFsKQ0KPj4gLQkJCQlwcl93YXJu
KCJjYm9tLWJsb2NrLXNpemUgbWlzbWF0Y2hlZCBiZXR3ZWVuIGhhcnRzICVkIGFuZCAlbHVcbiIs
DQo+PiAtCQkJCQljYm9tX2hhcnRpZCwgaGFydGlkKTsNCj4+IC0JCX0NCj4+IC0JfQ0KPj4gLX0N
Cj4+IC0jZW5kaWYNCj4+IC0NCj4+ICB2b2lkIHJpc2N2X25vbmNvaGVyZW50X3N1cHBvcnRlZCh2
b2lkKQ0KPj4gIHsNCj4+ICAJbm9uY29oZXJlbnRfc3VwcG9ydGVkID0gdHJ1ZTsNCj4+DQo+IA0K
PiANCj4gDQo+IA0KPiANCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18NCj4gbGludXgtcmlzY3YgbWFpbGluZyBsaXN0DQo+IGxpbnV4LXJpc2N2QGxpc3Rz
LmluZnJhZGVhZC5vcmcNCj4gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9saW51eC1yaXNjdg0K
