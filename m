Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD80156B63B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 12:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237610AbiGHKCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 06:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237206AbiGHKCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 06:02:16 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95BC83F1F
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 03:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657274535; x=1688810535;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=BB6/BRDiT39RZQ2VFb89lrbmk03msFMFBbrWTK8za0Q=;
  b=0780x99EbUx0sW1UCXWcJQ93v9ar5+Ve0eQhtpMS7UP9czxBtY64TpBV
   zGyr5VL6hlP/uhgXMXHggAdpLQ4bSxmcq1wSoQCP6w/SfcnmC02ljQ5fh
   mgTFPMSz9YF1M4qcJuDDPrtFTbqjYk6xPeo2E6oR3bB0HTekIclL37rfK
   36nhkKDdV6F/WrZjgwtHEOU89BHRho45zo/kCmv7ZKVqMhtzsZY2rC8HJ
   YwR2znCqDPQj308CkJLaTH7cDtotHY6y9zJ/RB3fH+CO5k5XztsIhHUAH
   iEVKUmbX2DpVxbF97lQCuM6aBUXqLH3a9l6dO0585hEYFgpP7UTU8GrtN
   g==;
X-IronPort-AV: E=Sophos;i="5.92,255,1650956400"; 
   d="scan'208";a="171302533"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Jul 2022 03:02:13 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 8 Jul 2022 03:02:12 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Fri, 8 Jul 2022 03:02:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P5RDHpXzb1cceBt2rl9h1mKzmfriXgDBc/q3QbH0rji4SpEJl+28FCxt3PCn2Q/7dPP6khjecwCmPWF+h1P5uANArF0ntaLL7CGadIN4RVGXo+bPaX3jWSl+bLS4sBOoIlJVLuq5vvGl38D+qQmrSzg8zqcL/cLQVZUp1sf6ElhQJ+fkjz2Jv58tYlP4jjBpJddAARuQLhTEjf+HbolGEy3wmSUYPmtHdWj06RU+7m0dhShpZYDSAvsZKO8EkyZhpGmCk6aKht5VVZs7Iz+A1OPqeq+JjBbkSPJF0ZlKaxT0bUOFTqS6oMK/9/bhYdYwe15RcZyXyijIYBn4llh1Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BB6/BRDiT39RZQ2VFb89lrbmk03msFMFBbrWTK8za0Q=;
 b=SlnrXjiFA4Dp64vihsyDmr12Jkc28WcEWPFpvS3pvRFmx8/83COMvya4Y4JpaGE94fk0vF2Za233G/+7SIzfWykr26C4B1w/NErsjaR8z15GDRUtpbvGMhucfcqH927qxWNzFS+Eea/uAHwzhXfkpJg0RkscXd4dV0tjQq+UIbX6Hrs/kGGvwlb0kIqD7CfhZp/Ft84gQCM9euzxdIDmxDc2Omxh8G1HlmDk84DPj1E2ZNVdj8jMlEWTRXryCFeG7KjrMIag+MgPMEL0oe+bLQ/sWjNcjnxe0M/RtZYeUyNGra4a3sVKjls8/cT5Fn3A4c7bh3zKygtQ3u55qiKYeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BB6/BRDiT39RZQ2VFb89lrbmk03msFMFBbrWTK8za0Q=;
 b=qozqL32aQGrVwC2snN0eVcCBxI5c5iE1oKHvRtibdNENT6kVzQmTF7neX+WTotk3LOFxUKrTtcbKJrbEFTeQJqEwP2v2W/drnSVVrXak3vWiN4VJSelVR5WhfF2b68mnD6hrq9b3KRnRHa5zLmp3m0VCN9XLO/DFKYv3Me78cO4=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by CY4PR11MB1398.namprd11.prod.outlook.com (2603:10b6:903:2a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.19; Fri, 8 Jul
 2022 10:02:10 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::8d4a:1681:398d:9714]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::8d4a:1681:398d:9714%5]) with mapi id 15.20.5417.016; Fri, 8 Jul 2022
 10:02:10 +0000
From:   <Conor.Dooley@microchip.com>
To:     <sudeep.holla@arm.com>
CC:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <palmer@rivosinc.com>, <aou@eecs.berkeley.edu>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <Daire.McNamara@microchip.com>, <niklas.cassel@wdc.com>,
        <damien.lemoal@opensource.wdc.com>, <geert@linux-m68k.org>,
        <zong.li@sifive.com>, <kernel@esmil.dk>, <hahnjo@hahnjo.de>,
        <guoren@kernel.org>, <anup@brainfault.org>,
        <atishp@atishpatra.org>, <changbin.du@intel.com>,
        <heiko@sntech.de>, <philipp.tomsich@vrull.eu>, <robh@kernel.org>,
        <maz@kernel.org>, <viresh.kumar@linaro.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <Brice.Goglin@inria.fr>
Subject: Re: [RFC 2/4] arch-topology: add a default implementation of
 store_cpu_topology()
Thread-Topic: [RFC 2/4] arch-topology: add a default implementation of
 store_cpu_topology()
Thread-Index: AQHYkk3HIdduEfI8FU+fdqjoS8H9IK10I72AgAADKgCAAAyQAIAAC4eA
Date:   Fri, 8 Jul 2022 10:02:10 +0000
Message-ID: <f48b21a9-e5f0-6aff-c563-f89b37037f00@microchip.com>
References: <20220707220436.4105443-1-mail@conchuod.ie>
 <20220707220436.4105443-3-mail@conchuod.ie>
 <20220708082443.azoqvuj7afrg7ox7@bogus>
 <473e6b17-465b-3d14-b04d-01b187390e66@microchip.com>
 <20220708092100.c6mgmnt7e2k7u634@bogus>
In-Reply-To: <20220708092100.c6mgmnt7e2k7u634@bogus>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3fadbe04-2634-4993-ca9a-08da60c8ec81
x-ms-traffictypediagnostic: CY4PR11MB1398:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9+AJYgDGowF9j3A0qABEMc4Y3YKZ57U9J2GC4lwXTGsQqEAyByH6aLrp6sYu2Bs7Nx8uCCwqRRl/SToU+M8MeVCb0R5Zg2/I0+kMZSoi134FJjOFJTM0LnG/s8dRPXVbRL0z8+6v3xOeuINcnNzFkQlEpWiKv0opMziz0ZIRwd8hwV0i5wPPJdlr+SzR5S1vZ1kgmCXPTPFjr78r13AYnt4Rx9u6ZKC/yX6mTxoEUPPuxpFPkB7xwODXm+eczfkXi2y2eVoSgX3eBYkeXK8S1oaHWg+V2JNw8CovV/VJVsfUARG43KW2wpR5nKzC6JgtkCHDfVBI+3qz47QikPSOgqV6DlmD74NzHbU5lNNNfY/olxRgrHDgG2LJCLu3cXd6qleRvLnb56K12p9pjqvwl8VoS1WihK2/iNJ16upv+nwdCDOm0lg4gH9Y2wQBPhpySywznYfs/1V9bOJ9ZjahWfCrdDiRDTcf8djGoMMVLhYZrGuAbcFyR6pqNFpZofkm+4fxWug/0QTRMbNKIiVJxGeq3PXW4GQPS7wfGxRkpHcUCFHZP7MTO3BkFJyQl+LTy0Jr5kCGELXLzOxRhMt4nBKNqgPFGFPkhy7fFX25E6pBu69NhSBbw64BTfr9QFugBj4z42LEeOkfZG/6MihWlDBxmc/FE/bEMEVCDTGHIl404k8PrM3tPeVjzZnC+GXVzkcvnJPdkfWodKUBhSh938KeSMx2ntrcgTr2mYs3O4ova3r4Ibd4pYZOMSaYhrfPJEZN4S6hL0GsEQ45zjZteEZmRdntNtlZ6i3tRCsRqbQYd7vr5oUmioPdCJHBk8E7g0yAQMiYNLmyD23doPusl3cU2mzx449ySTcXkWJctd2uXlUJ1+DAANRSMr5BPokQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(136003)(366004)(396003)(39860400002)(376002)(316002)(2616005)(186003)(6512007)(38100700002)(36756003)(54906003)(6486002)(91956017)(6916009)(31686004)(7416002)(83380400001)(71200400001)(38070700005)(4326008)(8676002)(31696002)(86362001)(53546011)(76116006)(64756008)(6506007)(5660300002)(26005)(122000001)(66556008)(478600001)(2906002)(66446008)(41300700001)(8936002)(66476007)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U1pqN1F6MlVMTy9mM0FpNWM2ZzhLMTZtWTBBeXpTeXlvUS9JOUQyZ0QyR0lS?=
 =?utf-8?B?NmFoRzhTdURPSTlUZ2lCQUNWMTZHNXdhQ3FOeGR6S3JuL1hzM3lEOThMR3gx?=
 =?utf-8?B?WWVGdnRDQWJDb1JyMnBiMXhrSWt2SE9mNlIwSCtEL1F4ajBiTFB1UStqb2tN?=
 =?utf-8?B?cFV4dFBhaElKbEQ1NmtTV2s0RkNWby9Fc3JISlFGMVA5Q1FSd1RJOWRUOU8v?=
 =?utf-8?B?S21JTXQzQjdkQ3h1SS81MXlDVzRrbmdmNDB6dzdBOC91M09QUWRsQVU3dnBa?=
 =?utf-8?B?VTNWK0VycHl2S3g2OG8wYUxMWkhncWdUSmpWMGFmVXBVSXA1Nk14WjV6Zmpy?=
 =?utf-8?B?dGlTbTRKS0pJMFpTT1lPZG5QSklWMmt6cHdHTkIzc0UvVE5UNmZBLzloRmZP?=
 =?utf-8?B?RzZydmRpU1FtOGw0QlhCaE1ZWkMxRUZuSlhpOHd1S05Jait6TG5vR2pxN1Nx?=
 =?utf-8?B?NmdHa0Z0VllEd29PU1NMZThpZkNpczh4ZDVZRUl3ZmxaUFNhSWQ4RkxuZGR4?=
 =?utf-8?B?dmlhelJjRm96Y25GL1lVWTlMSnh0a0xkY1hDYitFT0VuVGpOaTY2NGJUTHZP?=
 =?utf-8?B?Yzh6SUtVUFJIQUcxVUQwa1gyd210MzhTTmJRbFk1aXJsYVdKRmFJVXZQYmtm?=
 =?utf-8?B?TSs2eXhDYnlPc28zajF2eUtIaHNHZkVlWGdkeEpTUkh0ZzJRSkg2bG5ac0JG?=
 =?utf-8?B?WTNCd05Bdy9hVHdITUp5cWllOWtjaDBjOUFSamx0anF4eXlOeEtBRndYM3o3?=
 =?utf-8?B?LythV0s5d3ZIdXBSb2JrVkFPSG5SWHJYekNYTmN5a0ZBVUJQaUw3UEh5Ym95?=
 =?utf-8?B?NUcvUXFvSkRIUVQzeFowU09zT215VUhwU1FzN3VnT24wQ0lGRmVlRWdQdEo0?=
 =?utf-8?B?THFlanV5Z25NbnN5dzE1WCtTelhpY2xJeUE5QU1yNzNoZURGVFJETjB6bGh6?=
 =?utf-8?B?RFBTaXRQUFk4WmJOVVcvc000L3ZzUWV2WmFUQTgzKzRac3poVnhzQ2dWQVdB?=
 =?utf-8?B?MlRWeTF2WHFrV1FEWEZWdnZjZUNRU2RhVFR2eWs1cW5ON2doMmVOYlJIOUZU?=
 =?utf-8?B?QmZUMHp6VFdybmo0cERSeG94TFhVVFFIZThNa0pROW5QRFpMajFMRUVGMkFh?=
 =?utf-8?B?NUM5dTdZNEU3RGF2K2MrMTh1LzJHdmZ2UGZYOHl2QWlnN1Z2RTNab2dzcXVG?=
 =?utf-8?B?bGVseHltc0F2OTVLYkVaSHhXUFpYZ24vcGVyTVlSQ1I5bENoMmN6Tm1nQmUw?=
 =?utf-8?B?TXFod3lQSFZHOXB5a1FhcWd4eVlZRis4NGtJd0dvZ0dxZ2pCeSs1cEdkQWtq?=
 =?utf-8?B?K0lEaXh1WWVGdmtSR3lFamJBdGEwVCsxbjNSZ0lad2VRQjVqK3QzdGpkTkVh?=
 =?utf-8?B?cDhRdGtyemUyNFd2eGFyS2N6UGpYN3BjcmNUeXV5Mnp5Mzhrcng5T0dHQzY1?=
 =?utf-8?B?ZUIyejl0cnFJdmE5Ui9MYk5QbzBsSW1mWFBidGhBWDdnTVZ3dFllY1doK3py?=
 =?utf-8?B?b1pzOUZuUU5VNkxxWVhyMC8zeFhGNzlJbjRHRytVbnNjdW4zU0FOSmtxZUNV?=
 =?utf-8?B?cmZiODlqaHpjT0t5b1JZdDBrdm5QbjZSSkN2ZloyODUzM1h1Wm5ZZXNtZ09t?=
 =?utf-8?B?N1hOT3RzZmQweUYvdnhlNkNNU1FqUVhlUG5qbkFFRlpMNmJpV0ZsdVdIczJI?=
 =?utf-8?B?OUtldisrYnBTODFMMGFXVy9oUU9oelF5bFNqTnVUNlllcUlWNGtUVzdWNXlV?=
 =?utf-8?B?UEhBRnpoTlZPY0pXTHBSRTZLeStURVo5THJKRWkxZm5pN0VHQlB2T2w2NWU5?=
 =?utf-8?B?SVVYcXEwZUFuYXY1ZWp3YkFqRWJLVDYxdkNGeWNIRjVocVhzU2lwQTBRVW9Z?=
 =?utf-8?B?c3c4bXk4d0NmdGZLbldTU2FucmV5eGdvTEFEdVZSMTBQdFVZaUVvWkphRFhE?=
 =?utf-8?B?am4vZkRwc1A4K0hjd1h6QTN4ekcyZFZJeTFwOU1oajNVY0N2S01wTW1GNHAx?=
 =?utf-8?B?V0xkVm5YZzBvNkdzSVBNRjEramhZdGxQdGo2eVE1cktRSkRYc3lpcEVCV1BY?=
 =?utf-8?B?NFlrMTFyMURCMVRZTXh2VEt6aDlNWmNDY0IzSE1qeHc1Q1lNaGpaNlBldGhv?=
 =?utf-8?Q?WVTZ7uP/z0QPNq1VpWIa6eVw3?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8582FD00557D4F459559EF8D6E83D9EA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fadbe04-2634-4993-ca9a-08da60c8ec81
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2022 10:02:10.3376
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iSEqvVTEGlHipPdwN0be2S6MU2xGGnLET1fQ7OdF2vj7YpOLkrYWvASxiHv3ZY3RaW3oT1Nhn2hW2uFnZEkpwmBxuH8BtmbzIrXzgqa3RC0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1398
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDgvMDcvMjAyMiAxMDoyMSwgU3VkZWVwIEhvbGxhIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIEZyaSwgSnVsIDA4LCAyMDIyIGF0IDA4OjM1
OjU3QU0gKzAwMDAsIENvbm9yLkRvb2xleUBtaWNyb2NoaXAuY29tIHdyb3RlOg0KPj4gT24gMDgv
MDcvMjAyMiAwOToyNCwgU3VkZWVwIEhvbGxhIHdyb3RlOg0KPj4+IE9uIFRodSwgSnVsIDA3LCAy
MDIyIGF0IDExOjA0OjM1UE0gKzAxMDAsIENvbm9yIERvb2xleSB3cm90ZToNCj4+Pj4gRnJvbTog
Q29ub3IgRG9vbGV5IDxjb25vci5kb29sZXlAbWljcm9jaGlwLmNvbT4NCj4+Pj4NCj4+Pj4gUklT
Qy1WICYgYXJtNjQgYm90aCB1c2UgYW4gYWxtb3N0IGlkZW50aWNhbCBtZXRob2Qgb2YgZmlsbGlu
ZyBpbg0KPj4+PiBkZWZhdWx0IHZhbGVzIGZvciBhcmNoIHRvcG9sb2d5LiBDcmVhdGUgYSB3ZWFr
bHkgZGVmaW5lZCBkZWZhdWx0DQo+Pj4+IGltcGxlbWVudGF0aW9uIHdpdGggdGhlIGludGVudCBv
ZiBtaWdyYXRpbmcgYm90aCBhcmNocyB0byB1c2UgaXQuDQo+Pj4+DQo+Pj4+IFNpZ25lZC1vZmYt
Ynk6IENvbm9yIERvb2xleSA8Y29ub3IuZG9vbGV5QG1pY3JvY2hpcC5jb20+DQo+Pj4+IC0tLQ0K
Pj4+PiAgICBkcml2ZXJzL2Jhc2UvYXJjaF90b3BvbG9neS5jICB8IDE5ICsrKysrKysrKysrKysr
KysrKysNCj4+Pj4gICAgaW5jbHVkZS9saW51eC9hcmNoX3RvcG9sb2d5LmggfCAgMSArDQo+Pj4+
ICAgIDIgZmlsZXMgY2hhbmdlZCwgMjAgaW5zZXJ0aW9ucygrKQ0KPj4+Pg0KPj4+PiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9iYXNlL2FyY2hfdG9wb2xvZ3kuYyBiL2RyaXZlcnMvYmFzZS9hcmNoX3Rv
cG9sb2d5LmMNCj4+Pj4gaW5kZXggNDQxZTE0YWMzM2E0Li4wN2U4NGM2YWM1YzIgMTAwNjQ0DQo+
Pj4+IC0tLSBhL2RyaXZlcnMvYmFzZS9hcmNoX3RvcG9sb2d5LmMNCj4+Pj4gKysrIGIvZHJpdmVy
cy9iYXNlL2FyY2hfdG9wb2xvZ3kuYw0KPj4+PiBAQCAtNzY1LDYgKzc2NSwyNSBAQCB2b2lkIHVw
ZGF0ZV9zaWJsaW5nc19tYXNrcyh1bnNpZ25lZCBpbnQgY3B1aWQpDQo+Pj4+ICAgICB9DQo+Pj4+
ICAgIH0NCj4+Pj4NCj4+Pj4gK3ZvaWQgX193ZWFrIHN0b3JlX2NwdV90b3BvbG9neSh1bnNpZ25l
ZCBpbnQgY3B1aWQpDQo+Pg0KPj4gRG9lcyB1c2luZyBfX3dlYWsgaGVyZSBtYWtlIHNlbnNlIHRv
IHlvdT8NCj4+DQo+IA0KPiBJIGRvbid0IHdhbnQgYW55IHdlYWsgZGVmaW5pdGlvbiBhbmQgYXJj
aCB0byBvdmVycmlkZSBhcyB3ZSBrbm93IG9ubHkNCj4gYXJtNjQgYW5kIFJJU0MtViBhcmUgdGhl
IG9ubHkgdXNlcnMgYW5kIHRoZXkgYXJlIGFsaWduZWQgdG8gaGF2ZSBzYW1lDQo+IGltcGxlbWVu
dGF0aW9uLiBTbyB3ZWFrIGRlZmluaXRpb24gZG9lc24ndCBtYWtlIHNlbnNlIHRvIG1lLg0KDQpS
aWdodC4gSSBoYWQgdXNlZCBfX3dlYWsgYi9jIEkgZGlkbid0IGtub3cgaG93IHRvIHNwbGl0IHRo
ZSBtaWdyYXRpb24NCmludG8gc21hbGxlciBwYXRjaGVzIHBlciBhcmNoIHdpdGhvdXQgYnJlYWtp
bmcgdGhlIGJ1aWxkIGR1ZSB0bw0KbXVsdGlwbGUgZGVmaW5pdGlvbnMgb2Ygc3RvcmVfY3B1X3Rv
cG9sb2d5KCkuDQoNCj4gDQo+Pj4NCj4+PiBJIHByZWZlciB0byBoYXZlIHRoaXMgYXMgZGVmYXVs
dCBpbXBsZW1lbnRhdGlvbi4gU28ganVzdCBnZXQgdGhlIHJpc2Mtdg0KPj4+IG9uZSBwdXNoZWQg
dG8gdXBzdHJlYW0gZmlyc3QoZm9yIHY1LjIwKSBhbmQgZ2V0IGFsbCB0aGUgYmFja3BvcnRzIGlm
IHJlcXVpcmVkLg0KPj4+IE5leHQgY3ljbGUoaS5lLiB2NS4yMSksIHlvdSBjYW4gbW92ZSBib3Ro
IFJJU0MtViBhbmQgYXJtNjQuDQo+Pj4NCj4+DQo+PiBZZWFoLCB0aGF0IHdhcyBteSBpbnRlbnRp
b24uIEkgbWVhbnQgdG8gbGFiZWwgcGF0Y2ggMS80IGFzICJQQVRDSCINCj4+IGFuZCAoMiwzLDQp
LzQgYXMgUkZDIGJ1dCBmb3Jnb3QuIEkgdGFsa2VkIHdpdGggUGFsbWVyIGFib3V0IGRvaW5nDQo+
PiB0aGUgcmlzYy12IGltcGwuIGFuZCB0aGVuIG1pZ3JhdGUgYm90aCBvbiBJUkMgJiBoZSBzZWVt
ZWQgaGFwcHkgd2l0aA0KPj4gaXQuDQo+Pg0KPiANCj4gQWggT0ssIGdvb2QuDQo+IA0KPj4gSWYg
eW91J3JlIG9rYXkgd2l0aCBwYXRjaCAxLzQsIEknbGwgcmVzdWJtaXQgaXQgYXMgYSBzdGFuZGFs
b25lIHYyLg0KPj4NCj4gDQo+IFRoYXQgd291bGQgYmUgZ3JlYXQsIHRoYW5rcy4gWW91IGNhbiBt
b3N0IHRoZSBjb2RlIHRvIG1vdmUgdG8gZ2VuZXJpYyBmcm9tDQo+IGJvdGggYXJtNjQgYW5kIHJp
c2MtdiBvbmNlIHdlIGhhdmUgdGhpcyBpbiB2NS4yMC1yYzENCg0KUmlnaHQsIHRoYXQgc291bmRz
IGxpa2UgYSBwbGFuICh3ZWxsLCBwZW5kaW5nIGdlZXJ0J3MgY29uY2VybnMpLg0KQ291bGQgSSBo
YXZlIHlvdXIgUi1iIG9uIHBhdGNoIDE/IFRoZSBjb21tZW50cyB5b3UgbWFkZSBhYm91dA0KcmVt
b3ZpbmcgdGhlIGR1cGxpY2F0ZSBmdW5jdGlvbiBzaG91bGQgYmUgcmVzb2x2ZWQuDQoNClRoYW5r
cywNCkNvbm9yLg0KDQo=
