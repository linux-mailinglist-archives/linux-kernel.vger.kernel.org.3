Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D23C95977CB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 22:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241835AbiHQUUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 16:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237975AbiHQUUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 16:20:11 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D12995E48;
        Wed, 17 Aug 2022 13:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660767610; x=1692303610;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=lE7uBdA28D/WmqDVvpA+UuRber3bfL/xocSGvzqrZhc=;
  b=tC6S4SNnIF3wt93VL5iborh3p+izEYO3RN6BArdnx54MC4KtBSXt0rMc
   RY8V8/uCazbDG7hplwgweZbOtnAwOihySePMvvZz2oKZz4fNUF2A3bKVx
   L27jEyO2tuoEiJx4S18PryozNjDzH2mk6SasoFXxNQwL4QxaWfXnlTbzH
   QeQ/r8FeKsycoTdarOoF9hwJoOQVwp3+c7by05jO015gQiU4CAnMr7IAu
   7mmE6aejuwakjrN9w2EGTSrcpFo/5R3xaVzccdEpLVQjBkxzsnkgVqhQL
   ruqcrH7+gg3FE5ZmVI4uGMuO1MWByo0qMEwNuCpBF8wWEvtbetVPFYFkc
   w==;
X-IronPort-AV: E=Sophos;i="5.93,244,1654585200"; 
   d="scan'208";a="172923280"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Aug 2022 13:20:09 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 17 Aug 2022 13:20:04 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Wed, 17 Aug 2022 13:20:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bbwzAB+5Ij1aVGi3cohu1ah4S1untrq1TEToPcbhN7hGb+QVMns8S/iAeCJ0sxzAs/l2RF5FFLxOQ0G5FBcvAhZ44lIXWyMMj6BuJL/TmmlMxshyjnpbAF5WFWaACX/0AxBlQ55l1/8RsG2XJlzKkVoVNjdtCgbJdo+5hVNPbnyUyXOgzOjITDvko20KeojIiyO8hvXsdt1K2HUzqH/UknaLWCmFxblr6bn+wfNMfdJgYhjVKUHkzJkRnRLFeM2CydJyF2l5hCDHz4UJSUUt0uypbPI9/8SpTFqws8fExa5iYNZh+VvZRrvLguU3U6MNqLS55NtXIftRhOxYVJcUjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lE7uBdA28D/WmqDVvpA+UuRber3bfL/xocSGvzqrZhc=;
 b=FrrUm92dezuGFBAhKtIkZhvPgH3sg2oPm0nh++9xBLKKaxYnPGY4dkysm1aMm22Pas6dGDaDIclQ/+XKTOka9PIqbV4gz3UU7HXyl/Xj9L/hfralX+6HJm8+7sjO3hU/GIsREYhlbcCBMmNRSTPCFIrXb2xh1Ty4t3hFrME6zdky8vvcO0tWO3cztsm6hZrQbloS++sBexM9sEOfhO/GXBXT/eeTPhRnMlndGabqSfHGFNXKSfgAIWdlvUBGD13Rktd+JcVdVEetvXIA7XhNGmWwZ8b1RoBccSObuhT2+d43bAqLRXHBUiM7wXmeDG4bKpVCn1iNN3lfZeNS9kGTlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lE7uBdA28D/WmqDVvpA+UuRber3bfL/xocSGvzqrZhc=;
 b=ts/+kYUfqyJasSB2KPA4EKswdvqRxOlz+0XBprvrLkdsy7IYrXCdMVCJfSrub76wPa/zggD+rkzvCTvkBpDzZ0Xj+A/40dmhNMZg81EnLsblp6AZzp3l2WhmXxd44LQoIIPXwWIfiRkvX2KrnWTpIqPE8NfDQc6hFFFa6unoIJk=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by BN8PR11MB3636.namprd11.prod.outlook.com (2603:10b6:408:8c::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.19; Wed, 17 Aug
 2022 20:19:59 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%8]) with mapi id 15.20.5525.011; Wed, 17 Aug 2022
 20:19:59 +0000
From:   <Conor.Dooley@microchip.com>
To:     <ajones@ventanamicro.com>
CC:     <tglx@linutronix.de>, <maz@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>,
        <daniel.lezcano@linaro.org>, <anup@brainfault.org>,
        <Conor.Dooley@microchip.com>, <guoren@kernel.org>,
        <sagar.kadam@sifive.com>, <jrtc27@jrtc27.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <qemu-riscv@nongnu.org>,
        <robh@kernel.org>
Subject: Re: [PATCH 3/4] dt-bindings: riscv: add new riscv,isa strings for
 emulators
Thread-Topic: [PATCH 3/4] dt-bindings: riscv: add new riscv,isa strings for
 emulators
Thread-Index: AQHYsnTTdia1UOQsMkWjS13OKscf+q2zh5EAgAAA94A=
Date:   Wed, 17 Aug 2022 20:19:59 +0000
Message-ID: <0486fc52-2794-5c17-5086-049722765449@microchip.com>
References: <20220817200531.988850-1-mail@conchuod.ie>
 <20220817200531.988850-4-mail@conchuod.ie>
 <20220817201632.orjcqwu6bihgnnqd@kamzik>
In-Reply-To: <20220817201632.orjcqwu6bihgnnqd@kamzik>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 06c1de4a-12a6-461c-859b-08da808ddc0d
x-ms-traffictypediagnostic: BN8PR11MB3636:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WxjRxMAS928FfW26uZFOgP9DwvTUB5cj8RGKms7Oz2e1gfJftI+E1YNaXJ5jLcuCddMr1HtEHG8vT5hUrW709gaxoL64gUQln7kxtB6rFvBNLOsoO01kMJZH2wAuxjGIkVA5w+HM4pxOBYdE+SgBRfAGLih/rr6B9Wxk/1liDV+/ahgfYHKUmOHLMSpsZEf71gSxMYtwtk0WHPdv+KKZWQhSALn67FBcRUtRb81vbVqvhKAg8lLKwXPt3qdTDCMXoqLRY7rgiJsgKOOOI01sau2rLlj///c7WoXbHS8iAbm4JTgpXnvFqfn8nFgkdXzv7HVvLSxyog2q4Tm50LW9ecPFh/nIUX7+UMYFIxq2TvD70n8SqziSxh7zMtfGBtR2kdPZ1LIW7yv/tH6ACejE9aMwijGLaK5c4R+AyeB933tNPGRYNfC5SUVjDUzuao+V8JSdpg0ZAwfsBmkWbZMTgQvZ5NCI5AB0atzAST+ADaQ0yzRabL++DtC6uLcZz8qDZaDGi+F/i9oWKst0kAQlN+l2+mkLoNZ47D4EIMjHIK+bPkHegECGYcIAY1yjex0Cmhyu/6bnj5g/SYebbOYh8VpwpCbq6RCGZ+cxdnzZgAl9jrXFoFHZtdBAd1Rm4fyWPD2ja5DgU9l5Rt8uTcR48X7RTremmm9y5fA/6brxoVLhmvCWFUB2P7Pd+xmQPBt6Vi5Is1pumb6M+w3Js6fD+ritU5wu/GpS9RVxeIwOnE2QjqzO3elySJaKI7jmJ37t+0JyCaCw1YK06p5lRnNFhYOUlsvKuwVZRH4wdchjGEQR8FvMZOuPMwMwu3e2BbGzkCN/3ujX1t9IqTsuXgPPog==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(136003)(39860400002)(366004)(396003)(376002)(6512007)(6506007)(86362001)(26005)(2616005)(31696002)(38100700002)(53546011)(38070700005)(186003)(122000001)(83380400001)(71200400001)(7416002)(5660300002)(4744005)(478600001)(36756003)(91956017)(66946007)(6486002)(8936002)(76116006)(8676002)(4326008)(66446008)(66476007)(66556008)(31686004)(64756008)(2906002)(41300700001)(54906003)(6916009)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OHAxS0pRblBtQmsvYXU1UmpUek9ubnhQNk54MW5RSGZDOGEvclNlb00vcVRk?=
 =?utf-8?B?RGY5ajNSTSs3TDF5Y2lsWlBhREtQMXRUODc1TmhIWlRZVnJNSDN6NjFMU0Uw?=
 =?utf-8?B?OHRGd3JUNDN5bkl5OW1Oa0xVMllqRi9iYXhEVGVhKzZXcDZoeG9uVGxEV1ZP?=
 =?utf-8?B?VVB5dmtTbllJaGFaa2VtQ0poQm9wVzhLNkNWelJpMlErSmVWQ3lBK2xVN25x?=
 =?utf-8?B?Vkt5aE1aUi8rN0tjMjlrdWg3RTkvWk95eDVXVlhiS1VZL1dWcmM2bEtpOU5L?=
 =?utf-8?B?ZTdwZ1g4N2xVYWZHY0VqVXFzUkd6ZjVmZzNPR2VWUklnanNnQXI4ZWFaT1FV?=
 =?utf-8?B?enMzVTk1N0V3b01sSW5TckxBUS9DSHZNSlVrV3N5V25sT1dsQnMvUzF3b0Fo?=
 =?utf-8?B?ejBVVm1LTWFCeXBXcWhsMTk5dXkvODB3MkVNdFNSRnVlWnNSQVp4U2o1ODNG?=
 =?utf-8?B?SDhla3ZTczFGMWhESUNFNlNNc21DdFo2cGw3VXF3M1lMQ3BnS25vQWE3dlhu?=
 =?utf-8?B?Wm9tdHoxbm04a25rVlBYRkEvNWJ2bW8wcEkxSVdTbkpkYXRITmNacjhJeUFR?=
 =?utf-8?B?MTFlRXRkOW5MNUtvaFd0WGVsek1tOWpEbGJBNFBOc3ozSDFHaWNhMk5wSEhX?=
 =?utf-8?B?Qk9kSUlNOHBXWXpyZ1E4dkFMZnZrTUNQc0REWFRPWEE1d0VScitWR09ZVFNT?=
 =?utf-8?B?Slhpb0l1MFF4LytMaGlpVnlvSnFmV0krSEJVb0dNci9qOWFUWU1sRmFVbVdx?=
 =?utf-8?B?Slp5ZXo4UlZzd1hnWFQ0cVNBWHVuVHhXZXhXckdMRGo1U2hOZkc4WTlZSGVP?=
 =?utf-8?B?OU02U2I1em1xS2MrV2JSd0R3THgwbmNxdU56M2tsMEZFSnVvbjJRWlBCU0JE?=
 =?utf-8?B?NU5GQ1RoSzh5dGlpMjhHcktZS1doVEJYZ3VyYXJlUGwrNVIrN2FFbllrQlpr?=
 =?utf-8?B?ZGNQcWJBdTExQSs0eVpydUI2ajlQeFp4TTB0clJXRFNPU2pDQW8xRXVoK2tu?=
 =?utf-8?B?RmwyUEIzbmljZ1BXRlUwUkRWRngwL1JtWlVHbUNjdmtWa1BkUi8zWVVDTmhQ?=
 =?utf-8?B?clNSZTVWckFpTTlTVHpjSTAwUUlaNmU4K3A1ZkkyaDcyelpYSFo0aGpzYjdv?=
 =?utf-8?B?SzlxaE8vbVIyTGliV1lMVitFa0RlUE4vWStzeWc2cWFVcjg2emoyUHBzbXJL?=
 =?utf-8?B?RjRHQ0F0UXYwOGt1VXcrZC9qSTN0R3N6U05xZXd1cWc3aXlxbTFvU2dxK2ky?=
 =?utf-8?B?R2NLdUFTTXVvQlhINk15b1NTSGgyVUFZb2YxaDVvemZ3OFl2dHRTNkRIOXY0?=
 =?utf-8?B?OStFQ1lBdmFDVXp5dHFUcGl6S2VLdDdXM2RIV3hQNEFITmN3VHpmY1hENnRL?=
 =?utf-8?B?cTR3MHJzam9DQzJkZERIWDNqVnY2T1RsWU5QSDV4bFA0cVA0SlB5andkT0l0?=
 =?utf-8?B?c0F2M0c3eisxU090SFIrYWNSWjN6OFBydXlTaktwSUt1amFRSkV6Z1F4QTg3?=
 =?utf-8?B?VUV6VXUzQklGbWorYllDL1dHbHRPR2xLZ0RGbmhKc0FXbTBSOXlYQ2psd1Ja?=
 =?utf-8?B?dVUzejMvWVhjYUtabUlyNHByTTFzb2RzcDZuSU9NU2VEdnp2WWdKY2UyOVVh?=
 =?utf-8?B?Zy9zTmRLdlJjNEdkbTlLMExuRWhLNkxwTytKTGdXNld0ZEpJY1dSZFE4K09U?=
 =?utf-8?B?Rlo5NHQvZFpuRmV5b2pDa212L2RNOU5wbjhTOU55eTFzRDhKYW14QStIeTUx?=
 =?utf-8?B?OW9aZHNhOXVEY2h2REJYZW9HeDNZTGdSc05IWHcrS0czaUJFZHVGZVdBczc2?=
 =?utf-8?B?YzE2NElrY3I4cmhPb0NXdW1JbHdZTDJLM3lHUks0T1ZBT1BqMVpXYzhySXpX?=
 =?utf-8?B?YkU5QTZXb3lsWXJscEpGc0UzZXhCMHN2ZkdxL3lWQmtiMVVQSFpNTUx3TW40?=
 =?utf-8?B?QlFIRnR5TGxRT2lkRlNTeGRUakZOOG13YjNWMTJPSGFqMWpzK3ZVa2NTVjRW?=
 =?utf-8?B?NDNGQTkvdm1wdytLTm15dm04UkFMT3hkQ2thdHhKdHlqR2hFMVpqdVlLSURu?=
 =?utf-8?B?M3VNdlNLOG5HQlY5THhpUllmWWQrZUQrQVVpaWtFTVNLL0Z0ZlVFR1N4SG5Y?=
 =?utf-8?Q?Bbm9Ptqnwhgug1joP6lFC3Zvl?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F9423939F508B3438B028CDFF5601D43@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06c1de4a-12a6-461c-859b-08da808ddc0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2022 20:19:59.6807
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N7fm5MifzzmWLuw4zBuZnsiFJrdXuXaHgL2OsBpeb+1fH7ddwsU5NIg9w8ZDJ8p9pSfBUSF+wm050BL0cyZ0J49pMtZI0ZAVpFdLBYTZ6Pw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR11MB3636
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTcvMDgvMjAyMiAyMToxNiwgQW5kcmV3IEpvbmVzIHdyb3RlOg0KPiBPbiBXZWQsIEF1ZyAx
NywgMjAyMiBhdCAwOTowNToyMlBNICswMTAwLCBDb25vciBEb29sZXkgd3JvdGU6DQo+PiBGcm9t
OiBDb25vciBEb29sZXkgPGNvbm9yLmRvb2xleUBtaWNyb2NoaXAuY29tPg0KPj4NCj4gDQo+IEkn
ZCBzYXkgImxvb2tzIGdvb2QgdG8gbWUiLCBidXQgaXQncyBhIHJlZ2V4LCBzbyAiZ29vZCIgaXMg
YSBzdHJvbmcgd29yZC4NCj4gSW5zdGVhZCwgaGVyZSdzIGEgW3NvbWV3aGF0IHRlbnRhdGl2ZV0N
Cj4gDQo+IFJldmlld2VkLWJ5OiBBbmRyZXcgSm9uZXMgPGFqb25lc0B2ZW50YW5hbWljcm8uY29t
Pg0KDQpIZXkgQW5kcmV3LCB1bmZvcnR1bmF0ZWx5IEkgbWVzc2VkIHVwIG1haWxpbmcgdGhpcyBw
YXRjaHNldA0KKEkgZm9yZ290IHRvIGRlbGV0ZSBhZnRlciBydW5uaW5nIGZvcm1hdC1wYXRjaCB3
aXRob3V0IC12MikNCldvdWxkIHlvdSBtaW5kIHJlc3BvbmRpbmcgdG8gd2hhdCBJIGhhdmUgbGFi
ZWxlZCBhcyB2Mz8NClRoZSBjb250ZW50IGlzIHRoZSBzYW1lLCBJIGp1c3QgbWVzc2VkIHVwIHNl
bmRpbmchDQoNClRoYW5rcyBmb3IgcmV2aWV3aW5nLiBJIGFncmVlIHdpdGggImdvb2QiIGJlaW5n
IGEgc3Ryb25nIHdvcmQNCmhlcmUsDQpDb25vci4NCg==
