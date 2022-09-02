Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF645AAB7E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 11:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235295AbiIBJel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 05:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbiIBJei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 05:34:38 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A075248CBC
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 02:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662111277; x=1693647277;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=SjUidDsK66jkKYWHzSxTlmudVcXfzE+2mYHlgiaNvac=;
  b=1qNDY3fIfQlqZVxFXzWwCSSk43QEhK7Sb/6oLRIErMFkL4P1YmuSXUOa
   EPcigc+3Gv+Y9ezReaovSAbYuECQV4nDC3HHKILTCpGDtcaXtBfd4Rmqd
   c9zlf2cetQ0zqbtL5dCXFp8k/PgiwcqKFict5gvsPnPPJU8CO2cbinla3
   zP4OWbcfLwxZpbfv0oGbqLr1mpKjaGA2+jqAqGJ/wRYLqz3Tu/L7LJBqS
   lLJaQnHhwgKcHLPfbitsd6jwQkEPiI5LEOCZl7r7LykLx8p7ZOQrXwwQ1
   IHaSjNRnkUrgWk0MzVQcujj99D++wGCIyh71UPOZTFGgcO1c9RI5a2yu+
   A==;
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="178899645"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Sep 2022 02:34:36 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 2 Sep 2022 02:34:36 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Fri, 2 Sep 2022 02:34:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PO1svi+AghabSDZFlMt7hRf+cx+NbUaVtUly431yBdZFcDdGRzDhMLR7DLyqM5ZbQYMjcJYMlUtseMAR0+e0v/4ljEHI2tfEkDgNFGvzri3RETYThRCHzaD1VuyME4TGtYqQl9p2t+BR+N5xBugdI6WaRsEOiOk4TZXBTVnvM14ot70ighFI1vT5Gqf1BzhFanCZHSr+YM+AlJgJbftGeXkfxNVoAsrWyZS8Vuk0WJeOZacU2vZm5f7lhBXZibg8e1WO8wt2EXf0HvBjMx15j8zOoyuUdMfIOB9rMQ5d1KtoC9jawWPOORCOYOO2NVhLIELB7WhgpNc2jS77F0pYfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SjUidDsK66jkKYWHzSxTlmudVcXfzE+2mYHlgiaNvac=;
 b=EIcLk/DOTQtHfZYRz3GXCmANUYLQpKTAQQCSSCkrRjOG+r+xsXvt5f/GLv2iolWc6kwwY6WZe8s9BOyjPZdFH07MQZTTQDgq8oNbOOpJ4DAU81BVGNffvzT6/qhWk8PFXeJxcdLHWbBjTLgb/hAbYoH2F5J+J3fMum1lNVebIL2zNaNjPIIMmd48qOxaPEtSI/SzNCsi1eMrbluE8ZA/+MQXyGINQvXW41liQ+K5For0TTyMHfDY/Y0q4BXeR8FcTe1kLCbciJKnXd9jcylxPvct2N/KTg5q1nqBl9mgSVhx8+aNGlsL9IGBygJdgc68szgpsVSIM4etWUUh3eQGDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SjUidDsK66jkKYWHzSxTlmudVcXfzE+2mYHlgiaNvac=;
 b=bUxIEKOPOslM0R2rXcCPLcs1nWI2zjq8CGoSuQ5Hfe5fEFum2u07URZ/7IlcdxMN07dSNOV1V6CUBgJfKNAPRtDRFBeS9BVi2hqU/DXNrfiPLTyl6Zmyp5nmWiBK7dcXzmy13p7A+s8ihtC/3ReYdJO1oecZis8XZQ+bb0qciLc=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DM5PR1101MB2363.namprd11.prod.outlook.com (2603:10b6:3:a7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Fri, 2 Sep
 2022 09:34:35 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009%3]) with mapi id 15.20.5588.010; Fri, 2 Sep 2022
 09:34:34 +0000
From:   <Conor.Dooley@microchip.com>
To:     <heiko@sntech.de>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>
CC:     <guoren@kernel.org>, <apatel@ventanamicro.com>,
        <atishp@rivosinc.com>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] riscv: drop some idefs from CMO initialization
Thread-Topic: [PATCH 2/4] riscv: drop some idefs from CMO initialization
Thread-Index: AQHYvlI8JmMmetiEwU67UJJvfvrvQ63L4bOA
Date:   Fri, 2 Sep 2022 09:34:34 +0000
Message-ID: <88b6ecea-31e7-0439-b25d-6a48f43a19e3@microchip.com>
References: <20220901222744.2210215-1-heiko@sntech.de>
 <20220901222744.2210215-2-heiko@sntech.de>
In-Reply-To: <20220901222744.2210215-2-heiko@sntech.de>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 06868077-0a23-4d31-6be9-08da8cc658e6
x-ms-traffictypediagnostic: DM5PR1101MB2363:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dUxgzNTdcbrZKjd+G+p81eQsiG6L05Xkl6TrK5CN6IUkGP/dhnS3guxhmvHTNZIogdezn03k+MJITk7G4BwdnEonTWB8sYvC1cxHn7Sp1pBWcT+1/oG7OFnCcnLZSU1zzENUI1tNUKfSYkGZ8O/7fVmb3n7nsgh50hLa9EUBovFmZXNZFtoFP5zaRoKqvXTxB192KyCE88h+K4VpjdUO64gd7Iue7IE39VFwBpB1YqtKMnKlfTKddVKYjRvwB/NVwUyhau2i0CRYM4zY2DfpKGg8gsB6Dgyg1qpoSLoy8b8sVRt5AG39Zhnrnu8SW9HSZgg67oQ4LlhCUm6gj00rZZSKlcn/vwD2ZN/3VXwZ0ZJNfImy5Bk9GTaZL4jloYK9sSxuTv0Dfb884LphtKR5e6Sgqjhl0whphCg3buzf2TVyFQKvijIow6jTzLaQRNrZJzR/BBWdwIB67nJ/uDsyRne03+U1wtZct9zMXC1EUotZJ+b5Tc4WewYKanx8aV85C0Srj0KpCnFwGW4eO3EStO+iPXJpzVNUwQpkwInZblVeWIAqqEVnj9V9iCrWziUNZNS98SjBuMRpnyM3FVGDN482tcEZ0w8lBy4f5aMDvpQ0JJgoraGSiZ36l8cKdnZDGUrUh5k5Sj+FD4dP8GeSXot5XWjVwAycR7Nu3PVevKPlAKT09TgRlP70bqk9sxRkMoXNwgcB29/FcaFryBH1iSbGTYItPj8APyzZVNw6B+JYY1ZefloHAns3oc9hsyboIAKJrwMEkBC1HyWwDcdStkfEdXAAPlkgIIZ3lN4GA24sOc9wA9sz6VZlz0gGHpuzufhhc/fKxc2i1SaZn1G9mw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(376002)(136003)(346002)(39860400002)(31696002)(38070700005)(83380400001)(122000001)(38100700002)(91956017)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(8676002)(4326008)(110136005)(54906003)(316002)(2906002)(8936002)(5660300002)(53546011)(6512007)(26005)(6506007)(186003)(2616005)(71200400001)(6486002)(41300700001)(478600001)(86362001)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OUVyQnRaV1ArSjZpWTBIUVNwRzZZZ2J3dnlDMFc4M2lCdHZpSTBmQWQxOVJx?=
 =?utf-8?B?U3lsNklIWmxBbTBLc0NLL1R2ZHdtRGRES2JCVHp3OHNVaitrVDlvQm00NWtt?=
 =?utf-8?B?TkRDRTFGNWsyeXk5YTNCczZTVE9MdXgyNEdBMTE4aWpQTWpMQXI0Yzgyd2ZN?=
 =?utf-8?B?akZCdDh3cDRYLzZQdXVncjNIamEySkQxdVNLUUNPbDM5dnVLbmdQRy91VHpN?=
 =?utf-8?B?TW9NSU8xUEZoRmJHTHMvSlpPUnVTZWhhWlVpaHVJWXBZNElQckN1cG5PQlh3?=
 =?utf-8?B?YW0yYmdSaVFtTnZkVU9sL0xXNWZ0bXFoNGJvcnpYVnMvVldmRHpZUjlEWU0v?=
 =?utf-8?B?ZmZtK1lLNVNlbFRHd0p4NkN2UWRxZlEyK2FTYXFoRmNmWUo4RVVzcWhKUGNs?=
 =?utf-8?B?N0R5ZDR4MVhKSUdPWndKbHZUU3lidUZySWJLYm1iNUpYNFk3RzVDL3lHMFJn?=
 =?utf-8?B?SkhYMGFTOC9zNFBLUy8vVXhYcE1sRjZ2elZCNzhCaVYvVzhLdS9lbUJ3SU0x?=
 =?utf-8?B?SkM3bHZ4ZUtQb0VsK3R4ck5GUXdmdjlQUXV4NlZkL3BBYjB4eU9CUWl3cWZ2?=
 =?utf-8?B?TnZLWnErWnZ6OVJHS0Rub0gyZ3VLeTJiOHRGbTN6OE1tVU15a05sbiszd3gx?=
 =?utf-8?B?dC9zS0xLM0pmZDFPdVV0SEJsU01xQXUrU0lpdG1zWTUxWEdUeXpIVTgySXor?=
 =?utf-8?B?YTlMeVZpNW93bWFUcXN2VG00Qm1yUWFiMDRrSkpYbmVoNUUwZ0NiQUtuU0dy?=
 =?utf-8?B?SnVQYzVQQ0E0RkhQNHBaYU5IOXRSd2RaZ3pxM0RoQVVPdnN3L2xWSURiSzBO?=
 =?utf-8?B?QmQxa3BuODREanpnQjBNMnV4Y01qZnBBaXJ1Z1ovQ3p6STRUdFhPQzJ2TURB?=
 =?utf-8?B?Yklxdi9aV3E5dWtyTVFKaGJIUXdqUitBaWhwRHVjMmFCRUZqYTU4SzdxVGhZ?=
 =?utf-8?B?VTlSSW53YU9CT0ZWWFJPL3MxcDc5T3d0eFVyb2pnNVpJL1NwU2dUaTU2VFoz?=
 =?utf-8?B?WGFIazdyZmp3ZVAwOHhudVRGVFJ3TnRDZXJGWDE1TUpwUTBCS1I4YVdkdnZC?=
 =?utf-8?B?VmdaNXI5ZkRvWHhxOVhvbmUvajFJcmdrSUtBTnMvdmJkUjRGK3JFOW9hRE5v?=
 =?utf-8?B?USt2RFdPeDkrbW5HOHdDTVphTDJkQitGVys1cFVseWtic2MydmYwVEZ3S0F0?=
 =?utf-8?B?Tzcwc2lUblplQlBscnFia0RQdGVPTGN0Z1JrOFRuUG1DYkdocVBGOWw0dzho?=
 =?utf-8?B?NTFFWHI3OVlwdUdnRi9OTkg4V3hZcFN2WEFLL1pDR2p5TVM0dVlqdnpsekdp?=
 =?utf-8?B?QnpNT0FiZFZneFBqb0s2cjc1QVNsWU9XZWptdG9hdURQMUkwYUtERHRkY3Qr?=
 =?utf-8?B?aXhwTk9ybjdjY0Zob3g0VnZQY3lTcFNQcUZaemxMclN0YnFIVDNmdGtHdGxC?=
 =?utf-8?B?a0l4OEF2cHdhZno3N2poaGlnNkZrVFFEK0ZWc09IT1Awd2ZIUitZYndwc1E0?=
 =?utf-8?B?RVhUMkNHTzcvMXg0NGFrZWk1R3MxN1oyZUF3OFp4NTNhUmJodGVwMWVISkZs?=
 =?utf-8?B?MWE2b2pEVTFkOFlONXBpUzZXbTZvNXBQdkhpdUZOQ3ljYWg4ZGRCb1IrVUpZ?=
 =?utf-8?B?QlhwV3lubXdaeWhUTGhoZk40MTN4SGZ5T3B6NXFuK0RGeWhsVzRHSjBNZ0VT?=
 =?utf-8?B?SkdxV0dmNEFuSk45QXc4SWFLRmYrZGdlcnZ6Z3R2OWM0R2RZdS9MaXJWdlh6?=
 =?utf-8?B?L2c3b0l6UVozQUFmcjVRemlibHd2ZG5Dd2lhNFJZRzhSZnVXRnBwNVlYQ0pp?=
 =?utf-8?B?ZENsYnBkNzhBQStWZEx0VkExY1RLc0hNK1Q3RUo1SHlGWUtHNkxvc0RiT2dw?=
 =?utf-8?B?eGs0OTEzeE5ScHUvVHQ0TnEwdWU0NUZrbmwwSCtxK0k3QmNSb0dhODBhMzU0?=
 =?utf-8?B?dDdmMGxsRXg1M3BQV2ZnaDBxNC94bzh0QjQ0UXZ3VlZzRnk5KytGSzlkZE5X?=
 =?utf-8?B?RzV5ek9VQWhXZFNoU1JhelR0MDFoUEp4bmJxSGx6ZitqNXNXQ2ZRZkhIQ0Ny?=
 =?utf-8?B?SmpPb0k4T0tiQTlkT01Ub240SEJhVXJlWC84YURuNUNNOThSRHJ5djZPUE51?=
 =?utf-8?Q?FYDPB69obb86Z0Lq3qQ2Gtv3d?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A4CFCC9906B6CA4396681A66243F00C0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06868077-0a23-4d31-6be9-08da8cc658e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2022 09:34:34.8942
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wlO3+U9p+5J+7sPMAZNiz3aVRVghPTO5prf9B2vHs0aXpLJCK+Yn9awiiOvMZ9RA+CA8pvvXXb1n1VbEK9YvLSPf73+iclHc52uwVqA49jo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2363
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDEvMDkvMjAyMiAyMzoyNywgSGVpa28gU3R1ZWJuZXIgd3JvdGU6DQo+IEVYVEVSTkFMIEVN
QUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtu
b3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gV3JhcHBpbmcgdGhpbmdzIGluICNpZmRlZnMg
bWFrZXMgdGhlIGNvZGUgaGFyZGVyIHRvIHJlYWQNCj4gd2hpbGUgd2UgYWxzbyBoYXZlIElTX0VO
QUJMRUQoKSBtYWNyb3MgdG8gZG8gdGhpcyBpbiByZWd1bGFyIGNvZGUNCj4gYW5kIHRoZSBleHRl
bnNpb24gZGV0ZWN0aW9uIGlzIG5vdCBfdGhhdF8gcnVudGltZSBjcml0aWNhbC4NCj4gDQo+IFNv
IGRlZmluZSBhIHN0dWIgZm9yIHJpc2N2X25vbmNvaGVyZW50X3N1cHBvcnRlZCgpIGluIHRoZQ0K
PiBub24tQ09ORklHX1JJU0NWX0RNQV9OT05DT0hFUkVOVCBjYXNlIGFuZCBtb3ZlIHRoZSBjb2Rl
IHRvDQo+IHVzIElTX0VOQUJMRUQuDQo+IA0KPiBTdWdnZXN0ZWQtYnk6IENvbm9yIERvb2xleSA8
Y29ub3IuZG9vbGV5QG1pY3JvY2hpcC5jb20+DQoNClRvIG15ICJzZW5zaXRpdmUiIGV5ZXMsIHRo
aXMgbG9va3MgYSBsb3QgbmljZXIhDQoNClJldmlld2VkLWJ5OiBDb25vciBEb29sZXkgPGNvbm9y
LmRvb2xleUBtaWNyb2NoaXAuY29tPg0KDQo+IFNpZ25lZC1vZmYtYnk6IEhlaWtvIFN0dWVibmVy
IDxoZWlrb0BzbnRlY2guZGU+DQo+IC0tLQ0KPiAgIGFyY2gvcmlzY3YvZXJyYXRhL3RoZWFkL2Vy
cmF0YS5jICAgIHwgIDcgKysrLS0tLQ0KPiAgIGFyY2gvcmlzY3YvaW5jbHVkZS9hc20vY2FjaGVm
bHVzaC5oIHwgIDIgKysNCj4gICBhcmNoL3Jpc2N2L2tlcm5lbC9jcHVmZWF0dXJlLmMgICAgICB8
IDIyICsrKysrKysrKy0tLS0tLS0tLS0tLS0NCj4gICAzIGZpbGVzIGNoYW5nZWQsIDE0IGluc2Vy
dGlvbnMoKyksIDE3IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3Yv
ZXJyYXRhL3RoZWFkL2VycmF0YS5jIGIvYXJjaC9yaXNjdi9lcnJhdGEvdGhlYWQvZXJyYXRhLmMN
Cj4gaW5kZXggMjAyYzgzZjY3N2IyLi5iZmZhNzExYWFmNjQgMTAwNjQ0DQo+IC0tLSBhL2FyY2gv
cmlzY3YvZXJyYXRhL3RoZWFkL2VycmF0YS5jDQo+ICsrKyBiL2FyY2gvcmlzY3YvZXJyYXRhL3Ro
ZWFkL2VycmF0YS5jDQo+IEBAIC0zMCw3ICszMCw5IEBAIHN0YXRpYyBib29sIGVycmF0YV9wcm9i
ZV9wYm10KHVuc2lnbmVkIGludCBzdGFnZSwNCj4gICBzdGF0aWMgYm9vbCBlcnJhdGFfcHJvYmVf
Y21vKHVuc2lnbmVkIGludCBzdGFnZSwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
dW5zaWduZWQgbG9uZyBhcmNoX2lkLCB1bnNpZ25lZCBsb25nIGltcGlkKQ0KPiAgIHsNCj4gLSNp
ZmRlZiBDT05GSUdfRVJSQVRBX1RIRUFEX0NNTw0KPiArICAgICAgIGlmICghSVNfRU5BQkxFRChD
T05GSUdfRVJSQVRBX1RIRUFEX0NNTykpDQo+ICsgICAgICAgICAgICAgICByZXR1cm4gZmFsc2U7
DQo+ICsNCj4gICAgICAgICAgaWYgKGFyY2hfaWQgIT0gMCB8fCBpbXBpZCAhPSAwKQ0KPiAgICAg
ICAgICAgICAgICAgIHJldHVybiBmYWxzZTsNCj4gDQo+IEBAIC0zOSw5ICs0MSw2IEBAIHN0YXRp
YyBib29sIGVycmF0YV9wcm9iZV9jbW8odW5zaWduZWQgaW50IHN0YWdlLA0KPiANCj4gICAgICAg
ICAgcmlzY3Zfbm9uY29oZXJlbnRfc3VwcG9ydGVkKCk7DQo+ICAgICAgICAgIHJldHVybiB0cnVl
Ow0KPiAtI2Vsc2UNCj4gLSAgICAgICByZXR1cm4gZmFsc2U7DQo+IC0jZW5kaWYNCj4gICB9DQo+
IA0KPiAgIHN0YXRpYyB1MzIgdGhlYWRfZXJyYXRhX3Byb2JlKHVuc2lnbmVkIGludCBzdGFnZSwN
Cj4gZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3YvaW5jbHVkZS9hc20vY2FjaGVmbHVzaC5oIGIvYXJj
aC9yaXNjdi9pbmNsdWRlL2FzbS9jYWNoZWZsdXNoLmgNCj4gaW5kZXggYTYwYWNhZWNmZWRhLi40
MzYzZDBiZWIzOGEgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvcmlzY3YvaW5jbHVkZS9hc20vY2FjaGVm
bHVzaC5oDQo+ICsrKyBiL2FyY2gvcmlzY3YvaW5jbHVkZS9hc20vY2FjaGVmbHVzaC5oDQo+IEBA
IC01MCw2ICs1MCw4IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCByaXNjdl9pbml0X2Nib21fYmxvY2tz
aXplKHZvaWQpIHsgfQ0KPiANCj4gICAjaWZkZWYgQ09ORklHX1JJU0NWX0RNQV9OT05DT0hFUkVO
VA0KPiAgIHZvaWQgcmlzY3Zfbm9uY29oZXJlbnRfc3VwcG9ydGVkKHZvaWQpOw0KPiArI2Vsc2UN
Cj4gK3N0YXRpYyBpbmxpbmUgdm9pZCByaXNjdl9ub25jb2hlcmVudF9zdXBwb3J0ZWQodm9pZCkg
e30NCj4gICAjZW5kaWYNCj4gDQo+ICAgLyoNCj4gZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3Yva2Vy
bmVsL2NwdWZlYXR1cmUuYyBiL2FyY2gvcmlzY3Yva2VybmVsL2NwdWZlYXR1cmUuYw0KPiBpbmRl
eCA3NjRlYTIyMDE2MWYuLjcyOWY3YTIxODA5MyAxMDA2NDQNCj4gLS0tIGEvYXJjaC9yaXNjdi9r
ZXJuZWwvY3B1ZmVhdHVyZS5jDQo+ICsrKyBiL2FyY2gvcmlzY3Yva2VybmVsL2NwdWZlYXR1cmUu
Yw0KPiBAQCAtMjY0LDIxICsyNjQsMTcgQEAgc3RhdGljIGJvb2wgX19pbml0X29yX21vZHVsZSBj
cHVmZWF0dXJlX3Byb2JlX3N2cGJtdCh1bnNpZ25lZCBpbnQgc3RhZ2UpDQo+IA0KPiAgIHN0YXRp
YyBib29sIF9faW5pdF9vcl9tb2R1bGUgY3B1ZmVhdHVyZV9wcm9iZV96aWNib20odW5zaWduZWQg
aW50IHN0YWdlKQ0KPiAgIHsNCj4gLSNpZmRlZiBDT05GSUdfUklTQ1ZfSVNBX1pJQ0JPTQ0KPiAt
ICAgICAgIHN3aXRjaCAoc3RhZ2UpIHsNCj4gLSAgICAgICBjYXNlIFJJU0NWX0FMVEVSTkFUSVZF
U19FQVJMWV9CT09UOg0KPiArICAgICAgIGlmICghSVNfRU5BQkxFRChDT05GSUdfUklTQ1ZfSVNB
X1pJQ0JPTSkpDQo+ICsgICAgICAgICAgICAgICByZXR1cm4gZmFsc2U7DQo+ICsNCj4gKyAgICAg
ICBpZiAoc3RhZ2UgPT0gUklTQ1ZfQUxURVJOQVRJVkVTX0VBUkxZX0JPT1QpDQo+ICsgICAgICAg
ICAgICAgICByZXR1cm4gZmFsc2U7DQo+ICsNCj4gKyAgICAgICBpZiAoIXJpc2N2X2lzYV9leHRl
bnNpb25fYXZhaWxhYmxlKE5VTEwsIFpJQ0JPTSkpDQo+ICAgICAgICAgICAgICAgICAgcmV0dXJu
IGZhbHNlOw0KPiAtICAgICAgIGRlZmF1bHQ6DQo+IC0gICAgICAgICAgICAgICBpZiAocmlzY3Zf
aXNhX2V4dGVuc2lvbl9hdmFpbGFibGUoTlVMTCwgWklDQk9NKSkgew0KPiAtICAgICAgICAgICAg
ICAgICAgICAgICByaXNjdl9ub25jb2hlcmVudF9zdXBwb3J0ZWQoKTsNCj4gLSAgICAgICAgICAg
ICAgICAgICAgICAgcmV0dXJuIHRydWU7DQo+IC0gICAgICAgICAgICAgICB9IGVsc2Ugew0KPiAt
ICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gZmFsc2U7DQo+IC0gICAgICAgICAgICAgICB9
DQo+IC0gICAgICAgfQ0KPiAtI2VuZGlmDQo+IA0KPiAtICAgICAgIHJldHVybiBmYWxzZTsNCj4g
KyAgICAgICByaXNjdl9ub25jb2hlcmVudF9zdXBwb3J0ZWQoKTsNCj4gKyAgICAgICByZXR1cm4g
dHJ1ZTsNCj4gICB9DQo+IA0KPiAgIC8qDQo+IC0tDQo+IDIuMzUuMQ0KPiANCg0K
