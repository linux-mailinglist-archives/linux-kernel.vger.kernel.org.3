Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9C35AEFD3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 18:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233751AbiIFQEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 12:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239136AbiIFQDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 12:03:49 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F2289917
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 08:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662477923; x=1694013923;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=50LW0bEaa5JhjrLdAbzifIMU1qp48Hbx5hKFebZx64w=;
  b=vZ8FQWQbzJwF2r6xoMswi9dwKCkb3mVIKgRJlWYrw3ylw9PdjLBUBnN2
   Sg5g5AeRL+ZDnw1xIz3Hg4v0ACE8IURHD+polGTPlFOEyVhqK4UzlRFEl
   f+DniRMTDj4jzQtRTkwuN2dRNgCchNTQiYftEk8S68gQxp9okARiHyss8
   3OLyyXhSw0HDo73TAkdkMGMciRtxU0nxyiHICvDCsAbalu3JAQD37LJt/
   zT9XKXennnE0dyxElYTCl68Mn3IWCccVbmhbuNiVziJLnIF1x1MbJD7tl
   S3RbQ3Wj4tgPxh66D+0z82tLkSVA3tMjaCuauJzMai+2mXOLKD2Sqtkbr
   w==;
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="172608533"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Sep 2022 08:25:22 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 6 Sep 2022 08:25:18 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Tue, 6 Sep 2022 08:25:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q6rmk9nELzGGLbm8taJtAu/oxSZ1rc/BTfzQJP+c0pTUbMA1AZrM8BfwxqahkaLK7UsgwICAHk/UGWaa9c9PHXcFnl2z0IEJmTst731Tf9Px6o2NiZZ0dcBExYLyyhnmm9JvVXlYEa2YBaS2uEFmjnBPlu7RP8JRugUyUmpAsDjtNyYU/DwUuFwYYCfq5szN7m2jp5da2ih52mbEXFWk4rfURutuUaLIAkwGwJ8tSHB5xZ9tG2KCDyWJ4mNDbDLrNE0YOzMyQfpQ5XQc6+3g2q1H4dmvfDQgZxSSINYhIFfs5WJJOQCdEyEmuk3F9v5j8Ql1rMmXrwClX0AWEuZZlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=50LW0bEaa5JhjrLdAbzifIMU1qp48Hbx5hKFebZx64w=;
 b=AjrJVE67POf9MeziPWxgZhoNU0nkrfGlniR/daD/Fug50nifkhon7hrU4k1XYxTV3VF+opjsCPKdv7lJUNZe527WOlj2OBkBI91yPzM9EdCRLMVB1wjIPAOfyjkr71c7YXWGNO1dxWBb9xUDZp1Ss3g463NU4xtN2/Q4Q30MGWh8evJ6nSetKv0VZmPFl9vIaR/yf7OPSdK3EduotsnApv3wNyDfo3Elj6yga2ZdEs3tjauWmweoxNqz2RND1s2INfk+Tnrbximt/sJs9UOa6FcnPEjYdsRXrcqJcJQpPHyZEU5GxykZ52U+3zsJYv17IPR5f3WGKYbyrXVqTxUvQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=50LW0bEaa5JhjrLdAbzifIMU1qp48Hbx5hKFebZx64w=;
 b=LyvW4lb48PelIvEtnVeaypig6AgCvGcJltfpw+kWgc1mC8mu1GevQSQREq74wDJzt0IKsJs8bvoP7RNVtto3E8JficO746GIzzAAFp0yMNfUHcmuDY5l2bT8ShaYNNGLLZFiMeh/u09IQvOgNIhNNxJdu8neVfBhwK9cJgJdwMk=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DM6PR11MB3964.namprd11.prod.outlook.com (2603:10b6:5:19c::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Tue, 6 Sep
 2022 15:25:13 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009%3]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 15:25:13 +0000
From:   <Conor.Dooley@microchip.com>
To:     <ajones@ventanamicro.com>, <tjytimi@163.com>
CC:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <anup@brainfault.org>,
        <alexandre.ghiti@canonical.com>, <guoren@kernel.org>,
        <akpm@linux-foundation.org>, <heiko@sntech.de>,
        <tongtiangen@huawei.com>, <sunnanyong@huawei.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <falcon@tinylab.org>
Subject: Re: [PATCH v1] riscv : support update_mmu_tlb() for riscv
Thread-Topic: [PATCH v1] riscv : support update_mmu_tlb() for riscv
Thread-Index: AQHYwesX+Yh7ruAFaUuHWKE3tuJfd63SeaUAgAAMPIA=
Date:   Tue, 6 Sep 2022 15:25:13 +0000
Message-ID: <53332062-dbff-e93a-c5d4-4293525a16bb@microchip.com>
References: <20220906121921.8355-1-tjytimi@163.com>
 <20220906144126.3enx6y2mhevrc4ur@kamzik>
In-Reply-To: <20220906144126.3enx6y2mhevrc4ur@kamzik>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 047a0c42-661d-438d-c847-08da901bfe89
x-ms-traffictypediagnostic: DM6PR11MB3964:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DSdfJYiThQTbozWnoEou2i1/d+ySx6+ggXrOlRW5aaujtqZ8fxUxGacAUO08NQ0NpYnHRvFSrov3ddoVjPZtOLUAMw0/5Nc2F+3Ak26tbVRrm+/yRrEUQ40QaQsMknarwaTp+RUNTJK6m0W3EMitqJybNzc2UZGSF66qPrEaGptZDrxR/8wfPieyKTUJdtKxiXNOeogajDOjH57wWsK9Te3O9+MtTw/GiP25gzfll66uKW0KXojFpHyAMLXZAG/pAmIA/7joDZPC88wBKz3noe6FYh3oTik/EAsm7cAhOyWBUjVCavDF32BP/fztNnLbJjQb4uk5EEXAhZDLGOOKVL2+GWzd8+Z4nK3LuM4Y7OcuCwG+dA0QXvn1tUH2ekHkrCNeJ+SHoCyCBD6tIFjYUVxZ6OEQOjxwMybh2bJVWUAeKhkwRHU+bNo1MmpAwPSigczIvQK733kazoODtNRC5Pg2oKbPOKnkfdrmHQbYyN0S+5uV5AmklyLvAFJ9AlYjze5L9oZJHCnKQcaclsKx4XehaNIYG9DGZLPkk4bZfTgPyrbAidJJa0AvSi/oVmj78vKR5Tfs7WdDS7Bgx3nHWkPaRhyklhhqGsGkJeZXiKsm+O3n2YQ5E7oFy1XK3rLYwiMbADe8Rec16IDa/F9pTQOC/953D6KXY44bizZfcaneMoYDhUy7XcIdF0svrGGbZxp1Ym/he/PU3QVGOUF7aRp6n1yWqFnInM6rZQJpU4npP15eN6lcmSquhor5JMxLgPun7NDDDConmN+sW/AaS+7mKniXrqibDoL1PdTZKM9ovsqXAXveTnVNuHRuytMo7p1eJfN+R5XBuGAz5YkUAg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(136003)(39860400002)(346002)(376002)(66446008)(86362001)(66946007)(4326008)(8676002)(71200400001)(76116006)(66476007)(64756008)(91956017)(316002)(110136005)(478600001)(66556008)(5660300002)(41300700001)(6506007)(6512007)(31686004)(26005)(53546011)(54906003)(6486002)(38070700005)(31696002)(15650500001)(7416002)(8936002)(2906002)(2616005)(38100700002)(83380400001)(36756003)(186003)(122000001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S0ZxVFZOR1lFVTdJeFg5bzY5SXFUelNORUFkRU5lbTBjM3dBMzI1cmFGcUZs?=
 =?utf-8?B?ak8xTEpySHd4bE1HdW0yNmpTWllCWkp4bE0xUmY5emRPNzV3cWYra3N6c083?=
 =?utf-8?B?ZEVGQVZRdnBwQjVpbFNBU3kwZERrWjVLblQvZWJLNmtXTlR6ZldDajdyVlcx?=
 =?utf-8?B?WUR2dzJZNGJ5TlRKVGZBSXZoeVBPSWtnY3BudUNYdXFkaTdEeGNyZ1hKRVVz?=
 =?utf-8?B?WlhRaWNBNDE0SEpsaDZJWDFjbUF3cERjeDlncElqZ3pDV2o1ZVFBZllvaUl1?=
 =?utf-8?B?NzFzUW02SlpCTit6SHRsNGFwM2Z3dndwcjBNeDJiVmkvT3VoWUJNa3hwZVpX?=
 =?utf-8?B?c1BLQ1lQa2I1N1ZtaGROUFZkWlJGeUtZbk9CNVNEcGIxUkVCQnpEMkx2dHQ2?=
 =?utf-8?B?NkNzMWNLWGl2dUltZ2tYMjZ6ZXU2RzdZY3FqdUxIQjI1ODA1OTVuWUtWL0R0?=
 =?utf-8?B?QWZpRGlBOGhkeTg0Tm1FMEFTbFpoM0wreUJFcjNlMzF4eUJSbHgvcmpJZDls?=
 =?utf-8?B?aWdUWTlVeFZGNi9TUjk5SGdyYkwyZy9jSmZpVUNzd0MreGlZaDFmTGsxbDlI?=
 =?utf-8?B?cTNnMEFWMlBLV2RnT2FmVVdDUnZsd3ZEdklGellQRmdQNW54ZVFkR2Y2MVlo?=
 =?utf-8?B?T3FkUkh2cy9mYVFhc1ZnM0hGOWJqbGJKZGI4QXAwUXF3V2ZnaGo2Nmt2bEVN?=
 =?utf-8?B?ZG9odXBtMGVJSXlsZzlLVHRIM2tDK2prVzNaQ25VMndzZmtqRE1XeWo5MzA0?=
 =?utf-8?B?ZTVCTVFVSExFWjlGQ25UTDMrYTh3UjRCV08zUmhXblFVczI5ZTdhSFdab2Qx?=
 =?utf-8?B?eWUwbXdKL0tjck9SOC9pNTZZVlAyeWtOMnljZDNid0tKZXduOXBrd1c2bFdG?=
 =?utf-8?B?MS9lY2QvMHdjZlcvR2p2ZGJVZlhWM0ZYRndKRG81aVR4NGdzOVdmUXN4c1JI?=
 =?utf-8?B?ZzdCUnMzRHozaTFyYkt4TVZNNEhyQ3VOMStLR0Z2QUNydlFIOXdhRTdvQUpt?=
 =?utf-8?B?NkZuRUcvcXJ4d2FNOG1xczA2WTB3allMRERLZ1oxOFhEV2FzNXc1aU5hZWF6?=
 =?utf-8?B?K3dOc0MvQnBoL2pTTHBGcGkvODdaTU0yZmplL1NYNno5TDJhRXkzWTgvTTl0?=
 =?utf-8?B?aGwwYWp0ODVXWndmL0cxNGtjR25NZUNYSGwxd0phTllrSFM5YkFLY0JuTWlF?=
 =?utf-8?B?NUsvR3paMnpMZ2IwSHg2YWJibnhQZ3JJb3U5S3AwMnpkQ2dhRW5FYUlUbFpF?=
 =?utf-8?B?N1NBQitIREZBRTFNU09tc1FuZjdEVS9nUlhwL2w0ZDFLdURUTGYwUDlZWmpz?=
 =?utf-8?B?SW5lSmtWTUQ0cW9lYndIVEZtWXVZRXJ4NldEeGNPWHpXS3lwV2RoVHhTbGF0?=
 =?utf-8?B?c0V5UGZEL3gzb2wxb2Z3WmVmKzh1aEkyZkdPeFFpb2oxR0lPeGV5dzZWZnJ4?=
 =?utf-8?B?dUJzTitBTnVKdjJ4TlQ1WUVScWVUbkQ3a0xBdWhzK2QxQ1h5RUF4ajQyRE1a?=
 =?utf-8?B?blZwaHd5MWluVWxmYysrUGo2OFY4LzNJV05YcUZzTGtDM3laK3dhSVJMdDIw?=
 =?utf-8?B?ZlBFTEkvQVE5emVueVNHWDMvU0cwUHFQclR3SUxMSWJGUnMyTGd2ZlVORnp0?=
 =?utf-8?B?U1FtU1FueTBuS3o3VHlGUVVXTC9SbnlLYlBXRFVJN1ZBdnZjRmZhcWY1Z3Nk?=
 =?utf-8?B?ZURNY0l3ek8xeStBei80UVJaa2QzVjFPUmtaSUtnRHNMbEdkZzE2WHZoOXdt?=
 =?utf-8?B?MDdNS3hjQlpUaVhmR1ljZWJpVVJJcDhhYjZqdkVYKzNROW4rY2o3TytpSnlP?=
 =?utf-8?B?RjJ1R3Z6T2sxQnFNSnJkZG93WkorNFhvaHlpendlT3U5TlZWaVRCTGJLMU4v?=
 =?utf-8?B?NG1MV2g3Y1hzMVk4YmYweFhieC9NUlI1M0I4TlZMTkdRWm9UTEgxcTg3QkVt?=
 =?utf-8?B?aVNDaWVkWUFHcVZrWUx1Y2VWdVhOZFF2TlQrUlJpZGsrc1JUTTE1ZXA3VytB?=
 =?utf-8?B?Ym05QU1vbFR3Y2RVRnRJbTFFU1hKc054ei91NzRYNWxVVmxsTGZGNkJCU2xp?=
 =?utf-8?B?ZHlmRG1qKzRpV3pYVkNTUU9RdHB6dDkyS1RYVGFIUmQ5RnlqallSSUtybDI4?=
 =?utf-8?Q?F1+37BIeKA1GMiXsNybUmlqv3?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <91951E96F7C1CD4A87CD7F856B105C34@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 047a0c42-661d-438d-c847-08da901bfe89
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 15:25:13.4993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UCXuLmYfnvG8sm/9OPr9RhMBIYfk6B+Xd6/Ioiz39zfBvQ4WXDwBKymSB8zn67dyAaZWGRUoP/6Ha5mB7wSzPXltsHAUkWHgLqPTXNmaCxU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3964
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDYvMDkvMjAyMiAxNTo0MSwgQW5kcmV3IEpvbmVzIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIFR1ZSwgU2VwIDA2LCAyMDIyIGF0IDA4OjE5
OjIxUE0gKzA4MDAsIEppbnl1IFRhbmcgd3JvdGU6DQo+IFtQQVRDSCB2MV0gcmlzY3YgOiBzdXBw
b3J0IHVwZGF0ZV9tbXVfdGxiKCkgZm9yIHJpc2N2DQoNCkFub3RoZXIgbml0IHRvIGZpeCB3aGVu
IHlvdSBzb3J0IG91dCBEcmV3J3MgcmVxdWVzdCBiZWxvdywNCmRyb3AgdGhlIHNwYWNlIGJldHdl
ZW4gcmlzY3YgJiA6IHBsZWFzZS4NClRoYW5rcywNCkNvbm9yLg0KDQo+PiBBZGQgbWFjcm8gZGVm
aW5pdGlvbiB0byBzdXBwb3J0IHVwZGF0YV9tbXVfdGxiKCkgZm9yIHJpc2N2LA0KPj4gdGhpcyBm
dW5jdGlvbiBpcyBmcm9tIGNvbW1pdDo3ZGY2NzY5NzQzNTkgKCJtbS9tZW1vcnkuYzpVcGRhdGUN
Cj4+IGxvY2FsIFRMQiBpZiBQVEUgZW50cnkgZXhpc3RzIikuDQo+Pg0KPj4gU2lnbmVkLW9mZi1i
eTogSmlueXUgVGFuZyA8dGp5dGltaUAxNjMuY29tPg0KPj4gLS0tDQo+PiAgYXJjaC9yaXNjdi9p
bmNsdWRlL2FzbS9wZ3RhYmxlLmggfCAzICsrKw0KPj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2Vy
dGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9wZ3Rh
YmxlLmggYi9hcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL3BndGFibGUuaA0KPj4gaW5kZXggN2VjOTM2
OTEwYTk2Li44NGE3OTFkNTRmOTUgMTAwNjQ0DQo+PiAtLS0gYS9hcmNoL3Jpc2N2L2luY2x1ZGUv
YXNtL3BndGFibGUuaA0KPj4gKysrIGIvYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9wZ3RhYmxlLmgN
Cj4+IEBAIC00MTgsNiArNDE4LDkgQEAgc3RhdGljIGlubGluZSB2b2lkIHVwZGF0ZV9tbXVfY2Fj
aGUoc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEsDQo+PiAgICAgICBsb2NhbF9mbHVzaF90bGJf
cGFnZShhZGRyZXNzKTsNCj4+ICB9DQo+Pg0KPj4gKyNkZWZpbmUgICAgICBfX0hBVkVfQVJDSF9V
UERBVEVfTU1VX1RMQg0KPiAgICAgICAgICAgIF4ganVzdCBhIHNpbmdsZSBzcGFjZSBoZXJlLCBw
bGVhc2UsIGFzIGFsbCB0aGUgb3RoZXINCj4gICAgICAgICAgICAgICdkZWZpbmUgX19IQVZFJ3Mg
aW4gdGhpcyBmaWxlDQo+IA0KPj4gKyNkZWZpbmUgdXBkYXRlX21tdV90bGIgICAgICAgdXBkYXRl
X21tdV9jYWNoZQ0KPj4gKw0KPj4gIHN0YXRpYyBpbmxpbmUgdm9pZCB1cGRhdGVfbW11X2NhY2hl
X3BtZChzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSwNCj4+ICAgICAgICAgICAgICAgdW5zaWdu
ZWQgbG9uZyBhZGRyZXNzLCBwbWRfdCAqcG1kcCkNCj4+ICB7DQo+PiAtLQ0KPj4gMi4zMC4yDQo+
IA0KPiBUaGlzIHNlZW1zIGxpa2UgdGhlIHJpZ2h0IHRoaW5nIHRvIGRvLCBzbw0KPiANCj4gUmV2
aWV3ZWQtYnk6IEFuZHJldyBKb25lcyA8YWpvbmVzQHZlbnRhbmFtaWNyby5jb20+DQo+IA0KPiBJ
J20gY3VyaW91cyBpZiB0aGlzIHBhdGNoIGlzIHRoZSByZXN1bHQgb2YgZGVidWdnaW5nIHNvbWV0
aGluZz8gT3Igd2hhdA0KPiBsZWQgeW91IHRvIHBvc3QgaXQ/DQo+IA0KPiBUaGFua3MsDQo+IGRy
ZXcNCg0K
