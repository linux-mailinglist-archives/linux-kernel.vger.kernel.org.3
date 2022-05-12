Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 148105246AD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 09:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350829AbiELHR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 03:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350803AbiELHRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 03:17:55 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E974A9B1BA;
        Thu, 12 May 2022 00:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1652339872; x=1683875872;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=P5oPGsi/5jlkw4I5FwzlOdHm4gPE7SZR5k5wWCoaNkg=;
  b=HKsskPTH1Xfn0elPUt9LbW3kG3OxMmYb3xH7CWtMdyS0iR1VVJ7WpX+i
   gCnxUcodbBn/yOwOPsjFkTYZPOPaE0UzLLtzyTQG7gGPxc8nl7dzdIuKR
   HH7wMH0Ihpvg+bpvaEIvsFx8gAx3O+5hDyqCReLWqWexDFgmSia00qO5B
   SPUgZHjkpu7yonA/OSZrsuykrSBHXvwpEQxUY+qi8uewArWJ+bOBQXosH
   m/TfYlzpf/l7sMKFdmYl+VgKXvIrM/uLFtd/oIRQQei7ZKJPZF0dsJQ8y
   cOSylz6CDg32F35nTrHrTzeaP/1bymaa3MOTWHQ2WfcKPmd8wjaQHGTCl
   g==;
X-IronPort-AV: E=Sophos;i="5.91,219,1647327600"; 
   d="scan'208";a="163335263"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 May 2022 00:17:51 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 12 May 2022 00:17:50 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Thu, 12 May 2022 00:17:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L/Ss05JTSU4Hp+01zsXmC2p4wd1AFsBbUQASi/6ug/75xanegreQRRUtNth1ImnpchlzenavA4+eniq/G7X/83/pY8Vpxq58MVYqoBjMsubk4I9GH9hWdpFkTzuQgOAW8GIs6KTHd81ilILzOR2g7xAixUF6Ab5BVkA1O8Eg6y5JixdrWLyphsuHde/ezK6gY/3YkrUmkSJLkVti71q4L09RvxWh34sV9rHQrzbNwCmjlzWmU12YCnirEsm/Ynhxk/4yCVxddbC7QCCFISaL3AygaQAIO5gen7ADktu6vSYPwPEdAc/lzZbWafR204XiK4AlOYOBUclF//crnqbWMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P5oPGsi/5jlkw4I5FwzlOdHm4gPE7SZR5k5wWCoaNkg=;
 b=a7J3uv/jUIRFIiT4PH78SkM4gs/nG06Aujl2A1HPr4YORbwhvzUNKn+PmEjSzrFDl/soc6Ux9HiI0FXF9g/eZ3ZY1KgRV/6Sbd5Jeesm4QvcMZhP3jPKpP2jSIJ7VQ8lWv2k71kyumPgqTN2SZbu4PLQsaUi7q4A/hYp+mKo2Ov2RvOi3pE8zPRVlFVo5UhVc3QaQEzvHG/4ZpsFnvkbadPPxXfTLUR3f0UGAlEME3W7EeO55WnH+qY2URfQB99FynNXlwwaiFJ+tYu/qo8jB2wUuvITXP3pL5Zw8PD8yWGx9YypKRVxv/HjVv4wXiw/H8WyLD0o8u3QIO8j35bPLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5oPGsi/5jlkw4I5FwzlOdHm4gPE7SZR5k5wWCoaNkg=;
 b=Wgub9Lu3RN9mDnizeYLt5U6Rs4AwA27Xi56PpWGE4dhBmgFZDLWHUnoXYc0PYdMp5yHR0gOmwu4n7BPKcVG+/PJ4wnHdqH48ZkIzNaRkGobd6QRfZYPTl+mpUZsjHxuQgZUwZqos9lX23COVJpFfjZdw/F/bcNxeNtMZBII4TXc=
Received: from CO1PR11MB4769.namprd11.prod.outlook.com (2603:10b6:303:95::10)
 by BYAPR11MB2646.namprd11.prod.outlook.com (2603:10b6:a02:c6::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Thu, 12 May
 2022 07:17:45 +0000
Received: from CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::e906:3e8d:4741:c0f0]) by CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::e906:3e8d:4741:c0f0%6]) with mapi id 15.20.5250.013; Thu, 12 May 2022
 07:17:45 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>, <srinivas.kandagatla@linaro.org>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: microchip-otpc: document Microchip OTPC
Thread-Topic: [PATCH 1/2] dt-bindings: microchip-otpc: document Microchip OTPC
Thread-Index: AQHYZdBf287PvcEoQUmQslcb1o7LPQ==
Date:   Thu, 12 May 2022 07:17:45 +0000
Message-ID: <c840c598-0413-5f40-0807-e3c314531f0a@microchip.com>
References: <20220510094457.4070764-1-claudiu.beznea@microchip.com>
 <20220510094457.4070764-2-claudiu.beznea@microchip.com>
 <75ce6291-77c7-c932-e8bb-a8bbae02431d@linaro.org>
In-Reply-To: <75ce6291-77c7-c932-e8bb-a8bbae02431d@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cf2ac32a-216a-4dcb-e744-08da33e782f9
x-ms-traffictypediagnostic: BYAPR11MB2646:EE_
x-microsoft-antispam-prvs: <BYAPR11MB2646D290E53E9503825F239587CB9@BYAPR11MB2646.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tYQ86qEoDhtnW5uGv5+Djd2/2VvQltgkbUEFCKBrkWcfA66dVSutNx4kjv1v4bWs7LET5xO6S54OLdD0I3p8/NpjKS45LkCFtTZsn3ct01eJADSNZcH3yxCwJuuJHV3l0CcMrqKYdNLRVhlL+l1n2IW7v6JLvYcH3d6GEf630fk6oZlpjTZaq+8kwSrUYA+cb+FkFORJNi8GhMbm7xja+iyq6gk5bEA928k0G4DK63ty3DH8cotEoIPYyuq2dL/o6a8GaIxAXz2Wy4IM1TKYRbCBYMbsHDAkFpBmv6nirlpUJjhpAWAtxRLrPNvpXpafR/HML19QBwivLVP7UPxPC1omL3pyz13hMw8aFJKMUTMzBKehu7gU+mc/oQYg3Fa569B9ToWCObbrhfRc07zTR7he8aOO77Yjb+4Dl+2u7To8B2bP5o5HPB+EmlHKr4kHRK6Csx7DLApxpHPp2SEDUq+UnvkoQWL8URInRvoGaLxk00vi+dS0j1Wa9nLgf6r2B9JcQr2ka8x3iDCcvvBEfBduyNyuafce25TAM8MxifVBukFKlxibgeDnZpxJkXXEBE4QlcKd/D+oP5KkxRIEw62l4bBUS/KXrvv8Xat64V3PSJ6iVkWfk2cmOk4WPHCwrdFfEV6P1MdjyEAX/i9xC4NofCEXnr1VqzKTyMvyu9045REiezDXzY5Gras/j8iE8xu9fJx104/Sf4Y9HhnwUPF1ZU6qlw8u8ryPxP+mU9CNcx9x/yV2JBlQVnWGCoUbbqmMUEuj4E6VddR5MXgPppA0sw7CmkhpeBgo0RXUpx2Hsi1dUDtIOCp6UidtvqUwuZu7wNqPE5a+3+End3/yF/DcY7yVIz/0sggX4m6dn9Bd5aif222kJy7yy+mheaaDlv5YfeprYtj5dnK1UuJi8A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4769.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(91956017)(76116006)(64756008)(508600001)(26005)(71200400001)(66946007)(2906002)(8676002)(4326008)(6486002)(966005)(31696002)(31686004)(36756003)(86362001)(110136005)(6506007)(53546011)(6512007)(54906003)(316002)(38070700005)(122000001)(186003)(2616005)(66446008)(38100700002)(83380400001)(8936002)(5660300002)(66476007)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?LzMrUTErTzdxbUo0YmJoZHY0UW5jSXVLQ2NPNnpRNWNTUDBBZzR3eXdsdmpE?=
 =?utf-8?B?Y1VQYW5FNjU3ODkwdWJQRUJQQ0VZbjdqOW1vcnEvYVJRYVZ0Q0kvL0Nma25Z?=
 =?utf-8?B?K1pZN3dyem1XZGErdlo1eGJxUEhsalpvakxZN1czSmxGNjNDODRFL0t2K1pT?=
 =?utf-8?B?MGROQzhFRjJSa0tWbnVsY1c5RVdacnAvK0MwaHJnZlZTMGlGSGcvaVdrVDZU?=
 =?utf-8?B?WDYrRjAxNGlqZ3pGMVNVZVFEWDF4QXQvN252cXJBSnA3V3lsb1c0Q2x0ZXRh?=
 =?utf-8?B?bFU4OVJkeFc4b2JrZmQ5Y0V5UTRldDlPSmk4NDNKTElMTFZUY2ExNUlac0h3?=
 =?utf-8?B?ZjdScEt6MDhIdmd4V0dURUdlNVJpOFF2V1ROREhSWlBEditqZzdnUHdEc1lt?=
 =?utf-8?B?R2Zud2FkMDRCK0tYUkExNjlCZk5SZTk5RnlFZ3Y2dDBmZHJ1RXA4ME9IMmRP?=
 =?utf-8?B?NkpHanJ0MjRrdEFLbmd1aWtDWmhUcFpvSGpWOThiNThJcHgwNjhmOWZHU0hv?=
 =?utf-8?B?UGoxVXYvbUp2Z1o4UnlwVFp0TkhFYU9uN2kzQ0hMMXFlbklPbjYzQjZRam1Q?=
 =?utf-8?B?bTRrUWZ3WmdJT1dPV2tpNHBlT05JU2Zna215VytoS1d1ejB5aEdVUU5ubDdl?=
 =?utf-8?B?OXduYjFVY2ttbVBCR1BNOUJrcDJNVlRwQy9aaWF4Y1U4ME0vRm5RanFlSzNM?=
 =?utf-8?B?Ym1BbFZTUEtyQ21CQjdWaVJCMlEwaFZxL3lvWCtXeHZ0c0hNY3VPVDhGdXVF?=
 =?utf-8?B?Y3hMdVZVZDQ3U0o2WVMwbjVFYnFTMi9pZWlBTXpnS1BuUytNcTNxYTdvWUdQ?=
 =?utf-8?B?YjNsN09vNkhvQmpaQllnZFplYkhOb0hLR1BldTFReHZjbHBhdXpCMEdMZy91?=
 =?utf-8?B?OTlpMnJ1VHg1S0toV0ZuVTMrUEJWN3NqcnhTRGFKQUgyM3lPREVBbVREVVNN?=
 =?utf-8?B?WitnSWVVZnNZSmNidVhFYlJhTW12OExRSndpcWQ1V1FtU0s3eUhuL0tpUDR2?=
 =?utf-8?B?ckp0dGxPU3BYNlllQkxyN2JHNnJ6QTNkUnUrTENKZWhkUDVaTzVEdUx0TzBI?=
 =?utf-8?B?Z0ROa3IycEdPTHNNNzlXK2NNVCthSFRMQk0yeGVrclV1dnc1ZGlUWTBrc1lk?=
 =?utf-8?B?RnE1c2Z4dnRLbnJqUGsyMEpHbTdvOXJpN1krbUMzam1jVDd6MHpoQjMzR3Q0?=
 =?utf-8?B?N1VLdkZxWFduSllDN0wybEpZQXIydklZRDhHTzNnWlo2WnRRVlpEYm5vU3pI?=
 =?utf-8?B?YWUxODZFSlo4OHV4OHlRSzN5TTAya2dMZmt4azBHUXdndnNnVnp2b2dmVTFX?=
 =?utf-8?B?WUNuRkl4QTNoTnpRbHBNeDczMmtBYk1Qek1ONDBzUDVxbkdRZ3dqVElJaHNP?=
 =?utf-8?B?aEp2K0luZVN4a3lqM2I0WGEzMnNvNUZGS2l4QjQvM0psRS94UkZEK3lSclpo?=
 =?utf-8?B?S0hhc1FZRm50Q3V4dWh4Z0NMUXNySnJvSGhmZ0ZwKzZSby9VYUplYVpzRE5j?=
 =?utf-8?B?aHBRdkhPYitoZGZ5V1JwRVNnaUdpZXc5Wk94V1d0Myt6R3ZMMUozUXd4akpO?=
 =?utf-8?B?R25jdkJSYjFrNEF5NzNlS3pZdDFpK3RMYm1TMjZYUW41aFVYMFhVYlo3ejJF?=
 =?utf-8?B?OFh1WkRQbjhqdHp3OHR0YS9lZVZWdURWQmo5SVZJUGlveDlOU0x5OW5pT2FN?=
 =?utf-8?B?TWRNWndtQUVFdFhySXVETWhzOXQwV2pDcHMyVUt1d2ZJZTA3cEhJWWt1OVhs?=
 =?utf-8?B?aUZFcjQwWUk1c25ZbjBaTStJQ3JVajA1ZzFyMEpOQmc4dXNKeGpZQnp1eWhn?=
 =?utf-8?B?UXF5dDhaUTFFaGNFVmp6RDd0dThmUzR6QzJqU283S2ZwTHZ1dld3U2IzS0Mz?=
 =?utf-8?B?U3V6VlZNbTZPNGxYWTB5amJXRVdKQTNiT3ZXNGQ0a1dYMFZoclRHb0tOWXpa?=
 =?utf-8?B?NHZsZC9wMGlhTFRmUm5ZZFhIR256MTkxYVE2QjQ0NUFTUG4va0tPRVRXRndk?=
 =?utf-8?B?c016ZGxGV21ybFNXODNpTHNRK0FENnZxM3dFR0l1N0NEekNmYzJ1angwRkpE?=
 =?utf-8?B?dVJ2UFBBdUV1VVlSUmo1YWp5RkRudjdJV29HdU1TU3VCQ0xvNU8zTHJia045?=
 =?utf-8?B?aHcydG5YQXlURDNrQ1MxMWt6SGZjdXhwN29IZVY2UEd4eFI4blYzZmJLSzAz?=
 =?utf-8?B?ZXl0K0kyejU0VysvaHBFQnR4ekdxQ1pNWEJQNytzNkNNRm5pdUo2eFNoM0pC?=
 =?utf-8?B?cW96bEYvcEwreVliQUwzQms1dUdJbk9VdXFjVkxKTXduMW1keFB6VUlnRkpy?=
 =?utf-8?B?N3UvSFp2WERsZVNoQ0d1cVRZU0VFbzBSendEWlduaytCMjB1SmJsa1o5L0hR?=
 =?utf-8?Q?PEY6kxH68hTwKeEo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D4F2BCBDF0651348BF99C91D224A8F67@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4769.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf2ac32a-216a-4dcb-e744-08da33e782f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2022 07:17:45.3910
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s06Hoe/WktGpm00z1CbZ0C4/e3PGnE8ZRVUqfTBS4aah5JdGnDwWLSP3HEfR+myHwHO0XQ6wK3oBsklVgnYF0qdyp297JVHJOmcf1yjs8B0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2646
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEuMDUuMjAyMiAxODoyNywgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiAxMC8wNS8yMDIyIDExOjQ0LCBD
bGF1ZGl1IEJlem5lYSB3cm90ZToNCj4+IERvY3VtZW50IE1pY3JvY2hpcCBPVFAgY29udHJvbGxl
ci4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDbGF1ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWFA
bWljcm9jaGlwLmNvbT4NCj4+IC0tLQ0KPj4gIC4uLi9iaW5kaW5ncy9udm1lbS9taWNyb2NoaXAt
b3RwYy55YW1sICAgICAgICB8IDU1ICsrKysrKysrKysrKysrKysrKysNCj4+ICBpbmNsdWRlL2R0
LWJpbmRpbmdzL252bWVtL21pY3JvY2hpcCxvdHBjLmggICAgfCAxOCArKysrKysNCj4+ICAyIGZp
bGVzIGNoYW5nZWQsIDczIGluc2VydGlvbnMoKykNCj4+ICBjcmVhdGUgbW9kZSAxMDA2NDQgRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL252bWVtL21pY3JvY2hpcC1vdHBjLnlhbWwN
Cj4+ICBjcmVhdGUgbW9kZSAwNDAwMDAgaW5jbHVkZS9kdC1iaW5kaW5ncy9udm1lbQ0KPj4gIGNy
ZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2R0LWJpbmRpbmdzL252bWVtL21pY3JvY2hpcCxvdHBj
LmgNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L252bWVtL21pY3JvY2hpcC1vdHBjLnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvbnZtZW0vbWljcm9jaGlwLW90cGMueWFtbA0KPj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQN
Cj4+IGluZGV4IDAwMDAwMDAwMDAwMC4uYThkZjdmZWU1YzJiDQo+PiAtLS0gL2Rldi9udWxsDQo+
PiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbnZtZW0vbWljcm9jaGlw
LW90cGMueWFtbA0KPiANCj4gdmVuZG9yLGRldmljZS55YW1sDQo+IGRldmljZSBzaG91bGQgbm90
IGJlIGEgd2lsZGNhcmQgYnV0IGZpcnN0IGNvbXBhdGlibGUsIHNvDQo+IG1pY3JvY2hpcCxzYW1h
N2c1LW90cGMueWFtbA0KDQpPSw0KDQo+IA0KPiANCj4+IEBAIC0wLDAgKzEsNTUgQEANCj4+ICsj
IFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMCBPUiBCU0QtMi1DbGF1c2UpDQo+PiAr
JVlBTUwgMS4yDQo+PiArLS0tDQo+PiArJGlkOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1h
cy9udm1lbS9taWNyb2NoaXAtb3RwYy55YW1sIw0KPj4gKyRzY2hlbWE6IGh0dHA6Ly9kZXZpY2V0
cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29yZS55YW1sIw0KPj4gKw0KPj4gK3RpdGxlOiBNaWNyb2No
aXAgU0FNQTdHNSBPVFAgQ29udHJvbGxlciAoT1RQQykgZGV2aWNlIHRyZWUgYmluZGluZ3MNCj4g
DQo+IHMvZGV2aWNlIHRyZWUgYmluZGluZ3MvLw0KDQpPSw0KDQo+IA0KPj4gKw0KPj4gK21haW50
YWluZXJzOg0KPj4gKyAgLSBDbGF1ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAbWljcm9jaGlw
LmNvbT4NCj4+ICsNCj4+ICtkZXNjcmlwdGlvbjogfA0KPj4gKyAgVGhpcyBiaW5kaW5nIHJlcHJl
c2VudHMgdGhlIE9UUCBjb250cm9sbGVyIGZvdW5kIG9uIFNBTUE3RzUgU29DLg0KPiANCj4gRW50
aXJlIGRlc2NyaXB0aW9uIGlzIGR1cGxpY2F0aW5nIHRpdGxlLiBQbGVhc2UgZGVzY3JpYmUgdGhl
IGhhcmR3YXJlIG9yDQo+IHNraXAgaXQuDQoNCk9LDQoNCj4gDQo+IE9UT0gsIHlvdSBzaG91bGQg
bWVudGlvbiB0aGUgaGVhZGVyLCBmb3IgZXhhbXBsZSBpbiBkZXNjcmlwdGlvbi4NCj4gDQo+PiAr
DQo+PiArYWxsT2Y6DQo+PiArICAtICRyZWY6ICJudm1lbS55YW1sIyINCj4+ICsNCj4+ICtwcm9w
ZXJ0aWVzOg0KPj4gKyAgY29tcGF0aWJsZToNCj4+ICsgICAgaXRlbXM6DQo+PiArICAgICAgLSBj
b25zdDogbWljcm9jaGlwLHNhbWE3ZzUtb3RwYw0KPj4gKyAgICAgIC0gY29uc3Q6IHN5c2Nvbg0K
Pj4gKw0KPj4gKyAgcmVnOg0KPj4gKyAgICBtYXhJdGVtczogMQ0KPj4gKw0KPj4gKyAgIiNhZGRy
ZXNzLWNlbGxzIjoNCj4+ICsgICAgY29uc3Q6IDENCj4+ICsNCj4+ICsgICIjc2l6ZS1jZWxscyI6
DQo+PiArICAgIGNvbnN0OiAxDQo+IA0KPiBUaGVzZSBjb21lIGZyb20gbnZtZW0ueWFtbC4NCg0K
T0sNCg0KPiANCj4+ICsNCj4+ICtyZXF1aXJlZDoNCj4+ICsgIC0gY29tcGF0aWJsZQ0KPj4gKyAg
LSByZWcNCj4+ICsNCj4+ICt1bmV2YWx1YXRlZFByb3BlcnRpZXM6IGZhbHNlDQo+PiArDQo+PiAr
ZXhhbXBsZXM6DQo+PiArICAtIHwNCj4+ICsgICAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2Nsb2Nr
L2F0OTEuaD4NCj4gDQo+IEhvdyB0aGUgY2xvY2sgaXMgdXNlZCBoZXJlPw0KDQpUaGlzIGlzIGdh
cmJhZ2UuIEkgZm9yZ290IGl0IGhlcmUuDQoNCj4gDQo+PiArICAgICNpbmNsdWRlIDxkdC1iaW5k
aW5ncy9udm1lbS9taWNyb2NoaXAsb3RwYy5oPg0KPj4gKw0KPj4gKyAgICBvdHBjOiBlZnVzZUBl
OGMwMDAwMCB7DQo+PiArICAgICAgICBjb21wYXRpYmxlID0gIm1pY3JvY2hpcCxzYW1hN2c1LW90
cGMiLCAic3lzY29uIjsNCj4+ICsgICAgICAgIHJlZyA9IDwweGU4YzAwMDAwIDB4ZWM+Ow0KPj4g
KyAgICAgICAgI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+PiArICAgICAgICAjc2l6ZS1jZWxscyA9
IDwxPjsNCj4+ICsNCj4+ICsgICAgICAgIHRlbXBlcmF0dXJlX2NhbGliOiBjYWxpYkAxIHsNCj4+
ICsgICAgICAgICAgICByZWcgPSA8T1RQX1BLVCgxKSBPVFBfUEtUX1NBTUE3RzVfVEVNUF9DQUxJ
Ql9MRU4+Ow0KPj4gKyAgICAgICAgfTsNCj4+ICsgICAgfTsNCj4+ICsNCj4+ICsuLi4NCj4+IGRp
ZmYgLS1naXQgYS9pbmNsdWRlL2R0LWJpbmRpbmdzL252bWVtL21pY3JvY2hpcCxvdHBjLmggYi9p
bmNsdWRlL2R0LWJpbmRpbmdzL252bWVtL21pY3JvY2hpcCxvdHBjLmgNCj4+IG5ldyBmaWxlIG1v
ZGUgMTAwNjQ0DQo+PiBpbmRleCAwMDAwMDAwMDAwMDAuLjQ0YjZlZDNiOGYxOA0KPj4gLS0tIC9k
ZXYvbnVsbA0KPj4gKysrIGIvaW5jbHVkZS9kdC1iaW5kaW5ncy9udm1lbS9taWNyb2NoaXAsb3Rw
Yy5oDQo+PiBAQCAtMCwwICsxLDE4IEBADQo+PiArLyogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6
IEdQTC0yLjAgKi8NCj4gDQo+IFNhbWUgbGljZW5zZSBhcyBiaW5kaW5ncy4NCg0KT0sNCg0KPiAN
Cj4+ICsNCj4+ICsjaWZuZGVmIF9EVF9CSU5ESU5HU19OVk1FTV9NSUNST0NISVBfT1RQQ19IDQo+
PiArI2RlZmluZSBfRFRfQklORElOR1NfTlZNRU1fTUlDUk9DSElQX09UUENfSA0KPj4gKw0KPj4g
Ky8qDQo+PiArICogTmVlZCB0byBoYXZlIGl0IGFzIGEgbXVsdGlwbGUgb2YgNCBhcyBOVk1FTSBt
ZW1vcnkgaXMgcmVnaXN0ZXJlZCB3aXRoDQo+PiArICogc3RyaWRlID0gNC4NCj4+ICsgKi8NCj4+
ICsjZGVmaW5lIE9UUF9QS1QoaWQpICAgICAgICAgICAgICAgICAgKChpZCkgKiA0KQ0KPiANCj4g
RG8gSSBnZXQgaXQgY29ycmVjdGx5IC0gdGhlIG9mZnNldCBvciByZWdpc3RlciBhZGRyZXNzIGlz
IG5vdyBwYXJ0IG9mIGENCj4gYmluZGluZz8gWW91IHdyaXRlIGhlcmUgImlkIiwgaG93ZXZlciB5
b3UgdXNlIGl0IGFzIHBhcnQgb2YgInJlZyIsIHNvDQo+IGl0J3MgY29uZnVzaW5nLg0KDQpJIGFn
cmVlIHRoYXQgcmVnIHNob3VsZCBkZXNjcmliZSB0aGUgb2Zmc2V0IGluIE9UUCBtZW1vcnkgYW5k
IGl0cyB0aGUNCmxlbmd0aCBmb3IgYSBjZWxsLg0KDQpIb3dldmVyIHRoaXMgT1RQIG1lbW9yeSBp
cyBvcmdhbml6ZWQgaW50byBwYWNrZXRzICh0aGlzIGlzIGhvdyBoYXJkd2FyZSBpcw0KZGVzaWdu
ZWQpLCB0aGUgMXN0IG9uZSBiZWluZyB0aGUgYm9vdCBjb25maWd1cmF0aW9uIHBhY2tldCwgdGhl
IDJuZCBvbmUNCmJlaW5nIHRlbXBlcmF0dXJlIGNhbGlicmF0aW9uIGRhdGEuIEF0IHRoZSBtb21l
bnQgTWljcm9jaGlwIHByb3ZpZGVzIG9ubHkNCnRoZXNlIDIgcGFja2V0cyBpbiBPVFAgbWVtb3J5
LiBCb290IGNvbmZpZ3VyYXRpb24gcGFja2V0IG1heSB2YXJ5IGluIGxlbmd0aA0KdGh1cyBpdCBt
YXkgY2hhbmdlIHRoZSBvZmZzZXQgdGhlIHRlbXBlcmF0dXJlIGNhbGlicmF0aW9uIHBhY2tldCBy
ZXNpZGVzDQp0by4gSWYgdGhpcyBoYXBwZW4gYW5kIHdlIHVzZSBvZmZzZXQgYmFzZWQgYWRkcmVz
c2luZyBpbiBkZXZpY2UgdHJlZXMgdGhlbg0KdGhlIHNvbHV0aW9uIHdpbGwgbm90IHdvcmsgYWxs
IHRoZSB0aW1lLg0KDQpPVFAgaGFyZHdhcmUgaXMgZGVzaWduZWQgdG8gd29yayB3aXRoIHBhY2tl
dHMuIEZvciBhIHBhY2tldCBiZWluZyBpbiBtZW1vcnkNCmF0IG9mZnNldCAweDBFIGFzIGZvbGxv
d3M6DQoNCm9mZnNldCAgT1RQIE1lbW9yeSBsYXlvdXQNCg0KICAgICAgICAgLiAgICAgICAgICAg
Lg0KICAgICAgICAgLiAgICAuLi4gICAgLg0KICAgICAgICAgLiAgICAgICAgICAgLg0KMHgwRSAg
ICAgKy0tLS0tLS0tLS0tKwk8LS0tIHBhY2tldCBYDQogICAgICAgICB8IGhlYWRlciAgWCB8DQow
eDEyICAgICArLS0tLS0tLS0tLS0rDQogICAgICAgICB8IHBheWxvYWQgWCB8DQoweDE2ICAgICB8
ICAgICAgICAgICB8DQogICAgICAgICB8ICAgICAgICAgICB8DQoweDFBICAgICB8ICAgICAgICAg
ICB8DQogICAgICAgICArLS0tLS0tLS0tLS0rDQogICAgICAgICAuICAgICAgICAgICAuDQogICAg
ICAgICAuICAgIC4uLiAgICAuDQogICAgICAgICAuICAgICAgICAgICAuDQoNCnJlcXVlc3Rpbmcg
ZnJvbSBzb2Z0d2FyZSBkYXRhIGF0IGFkZHJlc3MgMHgxNiAodGhyb3VnaCBPVFAgY29udHJvbA0K
cmVnaXN0ZXJzKSB3aWxsIHJldHVybiB0aGUgd2hvbGUgcGFja2V0IHN0YXJ0aW5nIGF0IG9mZnNl
dCAweDBFLiBTYW1lDQp0aGluZ3MgaGFwcGVucyB3aGVuIHJlcXVlc3RpbmcgZGF0YSBhdCBvZmZz
ZXQgMHgwRSwgMHgxMiwgMHgxQS4NCg0KVGh1cywgYXMgdW5kZXJseWluZyBoYXJkd2FyZSByZXR1
cm5zIHRvIHNvZnR3YXJlIGNodW5rcyBvZiA0IGJ5dGVzIHRob3VnaA0KZGF0YSByZWdpc3RlcnMg
dGhlIGRyaXZlciBoYXMgYmVlbiByZWdpc3RlcmVkIHdpdGggc3RyaWRlID0gNC4gVGhlDQpPVFBf
UEtUKCkgbWFjcm8gZXhwZWN0cyBwYWNrZXQgaWRlbnRpZmllciAoc3RhcnRpbmcgZnJvbSAwKSwg
bXVsdGlwbGllcyBpdA0KYnkgNCB0byBiZSBhYmxlIHRvIHBhc3MgdGhlIE5WTUVNIHN1YnN5c3Rl
bSBhY2NvcmRpbmdseSwgdGhlbiB0aGUgZHJpdmVyDQp3aGljaCBtYW5hZ2VzIGEgbGlzdCBvZiB0
aGUgYXZhaWxhYmxlIHBhY2tldHMgZGl2aWRlcyB0aGlzIHZhbHVlIGJ5IDQgYW5kDQpnZXRzIHRo
ZSBwYWNrZXQgSUQgYW5kIHRoZSBwcm9wZXIgb2Zmc2V0IGluIG1lbW9yeSBmb3IgdGhlIHJlcXVl
c3RlZCBwYWNrZXQgSUQuDQoNClRoZSBpbnRlbnRpb24gd2FzIHRvIGhhdmUgdGhlIE9UUF9QS1Qo
KSBtYWNybyBoZXJlIHRvIGJlIHVzZWQgaW4gZGV2aWNlDQp0cmVlcyBmb3Igc2ltcGxlciB3YXkg
b2YgZGVzY3JpYmluZyBkaWZmZXJlbnQgY2VsbHMgaW4gdGhpcyBPVFAgbWVtb3J5Lg0KQWxzbywg
dXNpbmcgT1RQX1BLVCgpIGFic3RyYWN0aW9uIGxvb2tlZCB0byBtZSBjbG9zZXIgdG8gdGhlIHJl
YWxpdHkNCihhbHRob3VnaCB0aGUgY29tcHV0ZWQgdmFsdWUgaXMgbm90IHJlZmxlY3RpbmcgdGhp
cywgaXQgaXMgb25seSBhbg0KYWJzdHJhY3Rpb24gdG8gYmUgYWJsZSB0byBwYXNzIHRoZSBOVk1F
TSBzdWJzeXN0ZW0pLg0KDQpXb3VsZCB5b3UgcHJlZmVyIHRvIGhhdmUgcmF3IHZhbHVlcyBpbnN0
ZWFkIG9mIHVzaW5nIHRoaXMgbWFjcm8/DQoNCkFkYXB0aW5nIHRoZSBzdWJzeXN0ZW0gZm9yIHRo
aXMga2luZCBvZiBkZXZpY2VzIGlzIGFsc28gYW4gb3B0aW9uIGlmDQpTcmluaXZhcyB0aGlua3Mg
bGlrZSB0aGlzLg0KDQo+IA0KPj4gKw0KPj4gKy8qDQo+PiArICogVGVtcGVyYXR1cmUgY2FsaWJy
YXRpb24gcGFja2V0IGxlbmd0aCBmb3IgU0FNQTdHNTogMSB3b3JkcyBoZWFkZXIsDQo+PiArICog
MTggd29yZHMgcGF5bG9hZC4NCj4+ICsgKi8NCj4+ICsjZGVmaW5lIE9UUF9QS1RfU0FNQTdHNV9U
RU1QX0NBTElCX0xFTiAgICAgICAoMTkgKiA0KQ0KPiANCj4gTGVuZ3RoIG9mIHNvbWUgbWVtb3J5
IHJlZ2lvbiBhbHNvIGRvZXMgbm90IGxvb2sgbGlrZSBqb2IgZm9yIGJpbmRpbmdzLg0KDQpJIGFk
ZGVkIGl0IGhlcmUgdG8gYmUgYWJsZSB0byBoYXZlIHRoZSBzYW1lIG1hY3JvIGluIERUIGFuZCBj
b25zdW1lcg0KZHJpdmVycyB0YWtpbmcgYXMgZXhhbXBsZSBpaW8gZHJpdmVycyB0aGF0IHVzZXMg
dGhpcyBhcHByb2FjaCB0byBkZXNjcmliZQ0KSUlPIGNoYW5uZWwgaWRlbnRpZmllcnMuIEkgY2Fu
IHJlbW92ZSBpdCBhbmQgdXNlIG5lY2Vzc2FyeSBtYWNyb3MgaW4gdGhlDQpjb25zdW1lciBkcml2
ZXJzLCBpZiBpdCdzIGJldHRlciB0aGlzIHdheS4NCg0KVGhhbmsgeW91IGZvciB5b3VyIHJldmll
dywNCkNsYXVkaXUgQmV6bmVhDQoNCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQoN
Cg==
