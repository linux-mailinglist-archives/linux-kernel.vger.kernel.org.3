Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEF6573DF7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 22:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237162AbiGMUo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 16:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237133AbiGMUoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 16:44:14 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24CB22A257;
        Wed, 13 Jul 2022 13:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657745052; x=1689281052;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=67BFlQxIk71xz3ho4t3VAWwB3+RrDgjrKJ592cbJEo4=;
  b=bd8MCaP+m7Pqkp3Lo+9Aucn7tPxJ2MtBgh6UYXDnDuVAKf8+Fb0oo8Q4
   Q4GbgbRKpq9Dm50czLfIWylvsfS1ZrXg+59DlIB+vUL9+Tp1ekj3cJfVG
   Ht8X29ymn6Asv9MW4HKy7fJQzwxImhRY/xalDoL3YnZMZ4GNEba6uuIc/
   47Qi77Of8Az11BYD56nQyr5A4iWBiGGqeXWFt+jIrxyApTnkfj63ERdfB
   HBmQAFpNiNlvMC+8AeIe0mTtRr7YtX50dqXtJ0sAlK+hopKhdmH02QpsP
   3qXKgEI8TT6yTt8QwdqgygGSZuuOuBnFOpNRxc5vWefCas+I0ouDv2p8L
   w==;
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="104351584"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jul 2022 13:44:10 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 13 Jul 2022 13:44:08 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Wed, 13 Jul 2022 13:44:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gM5jd6lKt4IKFv9kgDXv0LUXbkMRNgVME1wOUqfwaJL+UmPdRzx39v4ZJUA7122OdJETBdJf8Ly8Gd3kyv4yxlrKyDP8wQ2HiOa0w5o2f/uiUjaVtsWyII96XBLO+BHY57GonC89zK5eBASfk4AWacxTL6MIDahFq2CAFX9mjY00V5lWhP3fcTL3Ncslq7kU5QRmEY1PixOPl5HOZu9tacdOob2hkg3zcGkJ6GzGJaYl1UXeqFHo0JJJ+Ivt8P0oR5UWzB0JhTACse+PsjOsXEJuqk91cULagjbMtmAYGQwQSR0nkakiMeqU+mXn0+TgxHMCTYBlxnlK+LHW3VJq7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=67BFlQxIk71xz3ho4t3VAWwB3+RrDgjrKJ592cbJEo4=;
 b=EnBegWqu66NbyQYHgKPXBV3JNHSrqT07KbNwKFbYlt2yZTIBaJCcb2bBLm/4e8TH5Bi2BGQVCa+oCgVFiAzpzkmNhtVS1GGGHXOAv50jbMipNZLzIPu46gCqC9MTJHqqgWqBHGI6AZe912mlJvH3hSI/Et/z3SJQK/cTqW77bhjwe0DaozzNfo/x5f/UmBAnJNDqGXPigI1xuHrepoTvh6e/or2SrrAfKWNhdehkOJCa0vqh/n/J4PvZ2AT+galFn6lKs+heX09Zsw08kXv8Aff2vR1/yLoy81TMDLaxl3fEjUg/QUsR9PcHmCr7OyjWUcJONeJi5h/QXbKhwhz70A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=67BFlQxIk71xz3ho4t3VAWwB3+RrDgjrKJ592cbJEo4=;
 b=GQcofysMyjVSAco3OoX206EI1OYwppxtdh03+W9EHrMqI8yAcm5R/TOGoNKkd9pQhuX1pJHSfX2jLYlXWO9XNbXio8ybHm/pQpFP2xbouhGl8YS8nTOyzwfvw8KVhTd4Jzb29idFZhLO1qPl9gfc7O0OPQHtrJRTbZ6u4moGZBo=
Received: from PH0PR11MB5925.namprd11.prod.outlook.com (2603:10b6:510:143::10)
 by MW5PR11MB5930.namprd11.prod.outlook.com (2603:10b6:303:1a1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Wed, 13 Jul
 2022 20:44:03 +0000
Received: from PH0PR11MB5925.namprd11.prod.outlook.com
 ([fe80::5c03:1f60:ee1d:3928]) by PH0PR11MB5925.namprd11.prod.outlook.com
 ([fe80::5c03:1f60:ee1d:3928%7]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 20:44:03 +0000
From:   <Lewis.Hanly@microchip.com>
To:     <andy.shevchenko@gmail.com>
CC:     <linux-riscv@lists.infradead.org>, <Conor.Dooley@microchip.com>,
        <brgl@bgdev.pl>, <linux-gpio@vger.kernel.org>,
        <linus.walleij@linaro.org>, <palmer@dabbelt.com>, <maz@kernel.org>,
        <linux-kernel@vger.kernel.org>, <Daire.McNamara@microchip.com>
Subject: Re: [PATCH v2 1/1] gpio: mpfs: add polarfire soc gpio support
Thread-Topic: [PATCH v2 1/1] gpio: mpfs: add polarfire soc gpio support
Thread-Index: AQHYlqemr2KX1URl4Eaxdmj5tFzD4a18MrcAgACSioA=
Date:   Wed, 13 Jul 2022 20:44:03 +0000
Message-ID: <abdf389cfd049f60b951447c047bbd186fa19469.camel@microchip.com>
References: <20220713105910.931983-1-lewis.hanly@microchip.com>
         <20220713105910.931983-2-lewis.hanly@microchip.com>
         <CAHp75VfGTd02jKYsFq94BF_Gqro2trk3iyyALBatS1Bps3HYhw@mail.gmail.com>
In-Reply-To: <CAHp75VfGTd02jKYsFq94BF_Gqro2trk3iyyALBatS1Bps3HYhw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 27bb05d1-b6b6-4b89-03dc-08da65106c1c
x-ms-traffictypediagnostic: MW5PR11MB5930:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Dj4nEYF8OVXZ2Wfk1Y0JaYuLTP6aCekSIkzq+elvIVYjzFi4ES62FlhZWht1vcU+euoahiZMY82XklPHPBhjqSxTk28Ejcb4B9XlAjmgY3TIhLdDcVvraOA2JNhEY/iDMMHC/qdr/KRCz0eESkAJt/4qw3yT3CpGaBsMFO88lO+outBwPzCniWpDzz+ljbP1YnPIpMcwcRZ6XowV7LlYn6/5seG/yqC/Qh8K3C36lj8P5r/0Xx/6glBJ1kXsxGO5TmUUhOKDrrhUMH8bfq6woNJgBYczX7ANFkZ0zDgGxrhZHTlyb/jr6Uk7wd4QNu28ViZ4qXNyNrQPAZECFxoHp3wUbKrrhDktZHN1dVlx3IIAJ8Demvcw1TB1+92fbHS3k0jDoEFtPFnJlOp13fHlgPD0eugDWosmEf+eDAWYpoetB3us1+UkEjyHchm5IGTd2s+FVmGO6S4lLQdlR4F2EzMmLTmNABeuheYFqF0PrVrWeAos1OEyL34kfpjhiepHzDZb0XY+aPLfS3uFdKtjbbFrdJPcJd6iMaD6w8k7BD5O3DkmodsudDXPHSuO2KO2xJaDGHJ52fQU5Vw0iR2m1vj9zfbG/p+Xyo74159BOp9ufs1fX70WT9R7K2v3jV/7LvyIBwpdVoKFnwUsxzy82bX0GJYTeYm/T93Cb/i128cx0gi5WVuuODHFSp/fQCPO5zPaspb0gZzYiliuYkzMODn9Cal0cvnTWcqLNbAqQ7JwpuV9T5Qo0q9kXybF4OAnDLs2Tme9ZqpNIun7JVQ9V30kLKFFacEiasCs9PbsxQzbUKzcJiF/hL1SpvHKfdCZCUY63v9mn72NQSwVdglTQNYm0Am+O7zylIfteDXqcNs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(366004)(396003)(136003)(39860400002)(346002)(6486002)(83380400001)(71200400001)(6506007)(66946007)(38070700005)(76116006)(4326008)(8676002)(6916009)(66556008)(2616005)(122000001)(91956017)(107886003)(66446008)(64756008)(54906003)(478600001)(66476007)(186003)(86362001)(316002)(36756003)(38100700002)(41300700001)(26005)(6512007)(53546011)(2906002)(8936002)(5660300002)(341764005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bnY2ek5tNUxuZ1l3VkF0TkJqRWM4b00wMERlZUV0U2tQRndvOUdkeW1HRkFM?=
 =?utf-8?B?Yk9qOURRUjlQMTZrY2pncytDT1NXUHRMOS83TkxGN2RTbUU1bHFOeEpkWDJJ?=
 =?utf-8?B?SWNxYzFNVDRPWW5ocjFkVmtlR3Nuc3E4Qzg5NjB1L1loanpLV3RzeUZVSWFn?=
 =?utf-8?B?Nm5GZ0J3SDBCQlJLb2JqV2F3ZEIvL3M2cXdXRGpEQSsranBuc21uUUlKQWJF?=
 =?utf-8?B?d1FneDZoa0Ezc2tSbDNyRWxnbmlDa1dYai9McEh0VnJsNEtKd3pTc2ZmZmNR?=
 =?utf-8?B?L3o2V1lkcWVEcERVU3E5USswTHRGSEFjOEZFZW1FS2xGY3dESWlYZWRjV3d4?=
 =?utf-8?B?a2FSbDFYL1dNVm5Ka2NOZGtZZFh5U3pGMmNKZS9ZL040b1FnN0RQQmVDajYw?=
 =?utf-8?B?WDJJZ25Hek5udUt4SW5TR3Q0bk9xM3RBT0Zvc2lxblFZaHczZ09vSUdXQUxk?=
 =?utf-8?B?ajVlbmlxK3pYWmVIdjFEUFBEcWY4bXN3Wk1ZSGR5T0VpSmcyZllVOG9JYXZY?=
 =?utf-8?B?TTdDTGpJNEcxSU8vUjNOSWdWTW9kaFd1dzVVK3pOWjNjTW15bktKSi84b0gy?=
 =?utf-8?B?UkY2TTBBQjJ5Rkx2dU5MNmg3RnNCZ2lxWlZhWXR3blM2aVVBMjVycUxRV0Yy?=
 =?utf-8?B?cjBKdEhITTVSdG9MR1BXSTN4MVN4U3hHNS8veXRlcjVyVytnem4zQW5KbkZD?=
 =?utf-8?B?NHBJMjdUcE5TSWZlZ0xEWXl5QkxQQkhEY2ppRW9mVXJXR3hOVzZaaDBUYTB0?=
 =?utf-8?B?WkhjYVdhaGZJemZDUTB4SkVMVmdmK2dHM09Qa3QwUWNwcHNDQkZTeHV1M25n?=
 =?utf-8?B?ZCt6dUpEQ1VWdkhySENWQU9TMi9CbHJESmJvdDlsalRRNXB3b0J1OUllSW96?=
 =?utf-8?B?RTlrS3RBVnpXR3NxaXgzdFdhOWRIOTBmL2JlTFpVUmI4VDh6dnJqem5ZYjdB?=
 =?utf-8?B?a1UyZjJ2V3dSc0xTL0daTUZwOFRtSUIvQ2pzdWppNVZ0WWxZRGk2a2pFV3Zj?=
 =?utf-8?B?MXBNYnBXc0M5WHFRV0h3Sjd5VEZhUU5vNFZCOExEYnZ2VXZ3d0NPeEU2ZUVY?=
 =?utf-8?B?MjBRT2RQM2xDQUlrOVVsbm9Ia3MwUzZkQkZ2Zm85aEpiSTlSeGFYcW5UWU1G?=
 =?utf-8?B?eks5bnA4Sm95MkU2UTNPcnZFS0NsZS9aQlpDcjNaRVBpcG5pK0JSdDArbTFH?=
 =?utf-8?B?dWVKVlIxY1RjK2VJbnJab1JucUF1SXJXWk1KRWI3U2luRklyVUJjMS9vNVd0?=
 =?utf-8?B?WnVUOGxqdWhVS0JhVDRnVmlEZHlQS1lBeU42eVBUOVczUFhQZzg3UnI2bXFj?=
 =?utf-8?B?RVlzYWNjYndxeXpEMnZSQjZkNyt6L3BqQmUybXczSS9SanVhTU9TTXJQcEZr?=
 =?utf-8?B?Y3hKV3dGMTdZcC9IdjRuNnpvM2IvMkFPZ21Yd1l2V2JnT1g3V2Fsb0NDTnJO?=
 =?utf-8?B?eUgxamFOcDJ6cHNWWFdtV3ptNUZtejdZb2J5bDRodU1zdllFNmU1NzNMOFRx?=
 =?utf-8?B?cEo3bnB4am5wOHRQQjJORzkvWnc5QTVzdFhzYnlvenF4dDY0VEdHUjRvcWJ4?=
 =?utf-8?B?ckdSTHZJVjZiSzl6eHpLcitnejdJRXFuNlFHVy9FdXBkY20vdldjbngzaVpa?=
 =?utf-8?B?OFVOK2VnRzRhcjZtK3MyNTRJMC9KbW5OcTh4TzRiRm9RVkh1dCtPaVc4SkZ1?=
 =?utf-8?B?ZzdrTEUrSHVqaE1oY0FGWml4NXRuNmEvU3B6cU9JWVc0NTdWZXhKYUJnSDBY?=
 =?utf-8?B?eVpTS040bmVORTNUaTBwbTZBUzZMenpNS0R0M3J3ak9KQk5kZ0p0TW9EdDF3?=
 =?utf-8?B?MHNsSWplOVlkbDZXNmtMbEhkVkJVY281dTR3NkdRNE9pT1FXNGZjeDdFc1Ir?=
 =?utf-8?B?UkMwa01TbmhZTXBtajAyUkdXMU1rZmlkS255K0MvVzNWSjBlT3pNNG96MHF2?=
 =?utf-8?B?emlsM2lDZ2lud0g1ZHhISW1lcTAzT3c1dW1OeTZ2SjNkbUlMMXNpRDlkTEVm?=
 =?utf-8?B?RFF6dWp4NE5hY254UWRKdGp1c2FXbzlsMFlkSUhGd01zdjdTR2xoM2kxTjE1?=
 =?utf-8?B?b1FobktKdDhRMHBkZ1pkNFR5bnk5clFab0xXbjJuczMxZTFXZUZWVlV5bW9o?=
 =?utf-8?B?ZTJucmxQSFQvNjBLbm1nM1VIZjZzVEhVbjljb3cyWS8ydXRiOFdWYkZSYlRx?=
 =?utf-8?B?REE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <222DFEB846206F46BBEE222B94B25B4A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27bb05d1-b6b6-4b89-03dc-08da65106c1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2022 20:44:03.3691
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yBvTwQfm/QcJZ99UKKJUN2LIZu6ZSu9WatVebE8/DHs8OGtuvIRpZiLT03soiJ3dMQjxkzZ8z4mK/wHAjuMlEenpNp8jyOj9BdULlymZR68=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5930
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmtzIEFuZHkgZm9yIHRoZSBmZWVkYmFjay4NClBvaW50cyBub3RlZCBhbmQgdXBkYXRlcyB3
aWxsIGJlIGluIG5leHQgcmV2aXNpb24uDQoNCk9uIFdlZCwgMjAyMi0wNy0xMyBhdCAxMzo1OSAr
MDIwMCwgQW5keSBTaGV2Y2hlbmtvIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNs
aWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdQ0KPiBrbm93IHRoZSBjb250
ZW50IGlzIHNhZmUNCj4gDQo+IE9uIFdlZCwgSnVsIDEzLCAyMDIyIGF0IDE6MDAgUE0gPGxld2lz
Lmhhbmx5QG1pY3JvY2hpcC5jb20+IHdyb3RlOg0KPiA+IEZyb206IExld2lzIEhhbmx5IDxsZXdp
cy5oYW5seUBtaWNyb2NoaXAuY29tPg0KPiA+IA0KPiA+IEFkZCBhIGRyaXZlciB0byBzdXBwb3J0
IHRoZSBQb2xhcmZpcmUgU29DIGdwaW8gY29udHJvbGxlci4NCj4gDQo+IEdQSU8NCj4gDQo+IC4u
Lg0KPiANCj4gQmVsb3cgbXkgY29tbWVudHMsIEkgaGF2ZSB0cmllZCBoYXJkIG5vdCB0byBkdXBs
aWNhdGUgd2hhdCBDb25vcg0KPiBhbHJlYWR5IG1lbnRpb25lZC4gU28gY29uc2lkZXIgdGhpcyBh
cyBhZGRpdGlvbmFsIHBhcnQuDQo+IA0KPiAuLi4NCj4gDQo+ID4gK2NvbmZpZyBHUElPX1BPTEFS
RklSRV9TT0MNCj4gPiArICAgICAgIGJvb2wgIk1pY3JvY2hpcCBGUEdBIEdQSU8gc3VwcG9ydCIN
Cj4gDQo+IFdoeSBub3QgdHJpc3RhdGU/DQpPSy4NCj4gDQo+ID4gKyAgICAgICBkZXBlbmRzIG9u
IE9GX0dQSU8NCj4gDQo+IFdoeT8NCj4gDQo+ID4gKyAgICAgICBzZWxlY3QgR1BJT0xJQl9JUlFD
SElQDQo+ID4gKyAgICAgICBzZWxlY3QgSVJRX0RPTUFJTl9ISUVSQVJDSFkNCj4gDQo+IE1vcmUg
bmF0dXJhbGx5IHRoaXMgbGluZSBsb29rcyBpZiBwdXQgYmVmb3JlIEdQSU9MQl9JUlFDSElQIG9u
ZS4NClllcw0KPiANCj4gPiArICAgICAgIHNlbGVjdCBHUElPX0dFTkVSSUMNCj4gPiArICAgICAg
IGhlbHANCj4gPiArICAgICAgICAgU2F5IHllcyBoZXJlIHRvIHN1cHBvcnQgdGhlIEdQSU8gZGV2
aWNlIG9uIE1pY3JvY2hpcA0KPiA+IEZQR0FzLg0KPiANCj4gV2hlbiBhbGxvd2luZyBpdCB0byBi
ZSBhIG1vZHVsZSwgYWRkIGEgdGV4dCB0aGF0IHRlbGxzIGhvdyB0aGUgZHJpdmVyDQo+IHdpbGwg
YmUgY2FsbGVkLg0KTm90IGxvYWRpbmcgYXMgYSBtb2R1bGUuDQo+IA0KPiAuLi4NCj4gDQo+ID4g
Ky8qDQo+ID4gKyAqIE1pY3JvY2hpcCBQb2xhckZpcmUgU29DIChNUEZTKSBHUElPIGNvbnRyb2xs
ZXIgZHJpdmVyDQo+ID4gKyAqDQo+ID4gKyAqIENvcHlyaWdodCAoYykgMjAxOC0yMDIyIE1pY3Jv
Y2hpcCBUZWNobm9sb2d5IEluYy4gYW5kIGl0cw0KPiA+IHN1YnNpZGlhcmllcw0KPiA+ICsgKg0K
PiA+ICsgKiBBdXRob3I6IExld2lzIEhhbmx5IDxsZXdpcy5oYW5seUBtaWNyb2NoaXAuY29tPg0K
PiA+ICsgKg0KPiANCj4gVGhpcyBsaW5lIGlzIG5vdCBuZWVkZWQuDQpPSw0KPiANCj4gPiArICov
DQo+IA0KPiAuLi4NCj4gDQo+ID4gKyNpbmNsdWRlIDxsaW51eC9vZi5oPg0KPiA+ICsjaW5jbHVk
ZSA8bGludXgvb2ZfaXJxLmg+DQo+IA0KPiBXaHk/DQpOb3Qgc3VyZSwgd2lsbCBjaGVjayBhZ2Fp
bi4NCj4gDQo+IEFsc28gZG9uJ3QgZm9yZ2V0IG1vZF9kZXZpY2V0YWJsZS5oLg0KQ2FuJ3Qgc2Vl
IHdoeSBJIG5lZWQgdGhpcyBoZWFkZXIuDQo+IA0KPiAuLi4NCj4gDQo+ID4gKyNkZWZpbmUgTlVN
X0dQSU8gICAgICAgICAgICAgICAgICAgICAgIDMyDQo+ID4gKyNkZWZpbmUgQllURV9CT1VOREFS
WSAgICAgICAgICAgICAgICAgIDB4MDQNCj4gDQo+IFdpdGhvdXQgbmFtZXNwYWNlPw0KPiANCj4g
Li4uDQo+IA0KPiA+ICsgICAgICAgZ3Bpb19jZmcgPSByZWFkbChtcGZzX2dwaW8tPmJhc2UgKyAo
Z3Bpb19pbmRleCAqDQo+ID4gQllURV9CT1VOREFSWSkpOw0KPiA+ICsNCj4gDQo+IFVubmVlZGVk
IGxpbmUuDQo+IA0KPiA+ICsgICAgICAgaWYgKGdwaW9fY2ZnICYgTVBGU19HUElPX0VOX0lOKQ0K
PiA+ICsgICAgICAgICAgICAgICByZXR1cm4gMTsNCj4gPiArDQo+ID4gKyAgICAgICByZXR1cm4g
MDsNCj4gDQo+IERvbid0IHdlIGhhdmUgc3BlY2lmaWMgZGVmaW5pdGlvbnMgZm9yIHRoZSBkaXJl
Y3Rpb25zPw0KTm8gZGVmaW5lcyBpbiBmaWxlLg0KPiANCj4gLi4uDQo+IA0KPiA+ICsgICAgICAg
c3RydWN0IGdwaW9fY2hpcCAqZ2MgPSBpcnFfZGF0YV9nZXRfaXJxX2NoaXBfZGF0YShkYXRhKTsN
Cj4gPiArICAgICAgIGludCBncGlvX2luZGV4ID0gaXJxZF90b19od2lycShkYXRhKTsNCj4gPiAr
ICAgICAgIHUzMiBpbnRlcnJ1cHRfdHlwZTsNCj4gPiArICAgICAgIHN0cnVjdCBtcGZzX2dwaW9f
Y2hpcCAqbXBmc19ncGlvID0gZ3Bpb2NoaXBfZ2V0X2RhdGEoZ2MpOw0KPiANCj4gVGhpcyBsaW5l
IG5hdHVyYWxseSBsb29rcyBiZXR0ZXIgYmVmb3JlIGludGVycnVwdF90eXBlIGRlZmluaXRpb24u
DQo+IFRyeSB0byBrZWVwIHRoZSAibG9uZ2VzdCBsaW5lIGZpcnN0IiBldmVyeXdoZXJlIGluIHRo
ZSBkcml2ZXIuDQpPSw0KPiANCj4gPiArICAgICAgIHUzMiBncGlvX2NmZzsNCj4gPiArICAgICAg
IHVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+IA0KPiAuLi4NCj4gDQo+ID4gKyAgICAgICBzd2l0Y2gg
KHR5cGUpIHsNCj4gPiArICAgICAgIGNhc2UgSVJRX1RZUEVfRURHRV9CT1RIOg0KPiA+ICsgICAg
ICAgICAgICAgICBpbnRlcnJ1cHRfdHlwZSA9IE1QRlNfR1BJT19UWVBFX0lOVF9FREdFX0JPVEg7
DQo+ID4gKyAgICAgICAgICAgICAgIGJyZWFrOw0KPiA+ICsNCj4gDQo+IFVubmVlZGVkIGxpbmUg
aGVyZSBhbmQgZXZlcnl3aGVyZSBpbiB0aGUgc2ltaWxhciBjYXNlcyBpbiB0aGUgZW50aXJlDQo+
IGNvZGUuDQpPSw0KPiANCj4gPiArICAgICAgIGNhc2UgSVJRX1RZUEVfRURHRV9GQUxMSU5HOg0K
PiA+ICsgICAgICAgICAgICAgICBpbnRlcnJ1cHRfdHlwZSA9IE1QRlNfR1BJT19UWVBFX0lOVF9F
REdFX05FRzsNCj4gPiArICAgICAgICAgICAgICAgYnJlYWs7DQo+ID4gKw0KPiA+ICsgICAgICAg
Y2FzZSBJUlFfVFlQRV9FREdFX1JJU0lORzoNCj4gPiArICAgICAgICAgICAgICAgaW50ZXJydXB0
X3R5cGUgPSBNUEZTX0dQSU9fVFlQRV9JTlRfRURHRV9QT1M7DQo+ID4gKyAgICAgICAgICAgICAg
IGJyZWFrOw0KPiA+ICsNCj4gPiArICAgICAgIGNhc2UgSVJRX1RZUEVfTEVWRUxfSElHSDoNCj4g
PiArICAgICAgICAgICAgICAgaW50ZXJydXB0X3R5cGUgPSBNUEZTX0dQSU9fVFlQRV9JTlRfTEVW
RUxfSElHSDsNCj4gPiArICAgICAgICAgICAgICAgYnJlYWs7DQo+ID4gKw0KPiA+ICsgICAgICAg
Y2FzZSBJUlFfVFlQRV9MRVZFTF9MT1c6DQo+ID4gKyAgICAgICAgICAgICAgIGludGVycnVwdF90
eXBlID0gTVBGU19HUElPX1RZUEVfSU5UX0xFVkVMX0xPVzsNCj4gPiArICAgICAgICAgICAgICAg
YnJlYWs7DQo+ID4gKyAgICAgICB9DQo+IA0KPiAuLi4NCj4gDQo+ID4gKyAgICAgICBtcGZzX2dw
aW9fYXNzaWduX2JpdChtcGZzX2dwaW8tPmJhc2UgKyAoZ3Bpb19pbmRleCAqDQo+ID4gQllURV9C
T1VOREFSWSksDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICBNUEZTX0dQSU9fRU5f
SU5ULCAxKTsNCj4gDQo+IFRvbyBtYW55IHBhcmVudGhlc2VzLg0KSSBkbyB0aGluayBpdCBtYWtl
cyByZWFkaW5nIGVhc2llci4NCj4gDQo+IC4uLg0KPiANCj4gPiArICAgICAgIG1wZnNfZ3Bpb19h
c3NpZ25fYml0KG1wZnNfZ3Bpby0+YmFzZSArIChncGlvX2luZGV4ICoNCj4gPiBCWVRFX0JPVU5E
QVJZKSwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgIE1QRlNfR1BJT19FTl9JTlQs
IDApOw0KPiANCj4gRGl0dG8uDQo+IA0KPiAuLi4NCj4gDQo+ID4gK3N0YXRpYyBpbnQgbXBmc19n
cGlvX2lycV9zZXRfYWZmaW5pdHkoc3RydWN0IGlycV9kYXRhICpkYXRhLA0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uc3Qgc3RydWN0IGNwdW1hc2sgKmRlc3Qs
DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBib29sIGZvcmNlKQ0K
PiA+ICt7DQo+ID4gKyAgICAgICBpZiAoZGF0YS0+cGFyZW50X2RhdGEpDQo+ID4gKyAgICAgICAg
ICAgICAgIHJldHVybiBpcnFfY2hpcF9zZXRfYWZmaW5pdHlfcGFyZW50KGRhdGEsIGRlc3QsDQo+
ID4gZm9yY2UpOw0KPiA+ICsNCj4gPiArICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiA+ICt9DQo+
IA0KPiBXaHkgZG8geW91IG5lZWQgdGhpcz8gSXNuJ3QgaXQgdGFrZW4gY2FyZSBvZiBieSB0aGUg
SVJRIGNoaXAgY29yZT8NClllcyBJIGJlbGlldmUgd2UgZG8vc2hvdWxkLCBkYXRhLT5wYXJlbnRf
ZGF0YSBpcyB1c2VkIGluDQppcnFfY2hpcF9zZXRfYWZmaW5pdHlfcGFyZW50KC4uKSB3aXRob3V0
IGNoZWNraW5nIHNvIGhlbmNlIGNoZWNrZWQNCmJlZm9yZSBjYWxsaW5nLg0KPiANCj4gLi4uDQo+
IA0KPiA+ICsgICAgICAgc3RydWN0IGNsayAqY2xrOw0KPiA+ICsgICAgICAgc3RydWN0IGRldmlj
ZSAqZGV2ID0gJnBkZXYtPmRldjsNCj4gPiArICAgICAgIHN0cnVjdCBkZXZpY2Vfbm9kZSAqbm9k
ZSA9IHBkZXYtPmRldi5vZl9ub2RlOw0KPiA+ICsgICAgICAgc3RydWN0IGRldmljZV9ub2RlICpp
cnFfcGFyZW50Ow0KPiANCj4gV2h5IGRvIHlvdSBuZWVkIHRoZXNlPw0KWWVzIHRoZXkgYXJlIG5l
ZWRlZC4gQm90aCBvZiB0aGUgc2FtZSB0eXBlIGJ1dCB1c2VkIGluIGRpZmZlcmVudA0KcGxhY2Vz
LiBJIGRvbid0IHRoaW5rIEkgY2FuIHJldXNlLg0KDQo+IA0KPiA+ICsgICAgICAgc3RydWN0IGdw
aW9faXJxX2NoaXAgKmdpcnE7DQo+ID4gKyAgICAgICBzdHJ1Y3QgaXJxX2RvbWFpbiAqcGFyZW50
Ow0KPiA+ICsgICAgICAgc3RydWN0IG1wZnNfZ3Bpb19jaGlwICptcGZzX2dwaW87DQo+ID4gKyAg
ICAgICBpbnQgaSwgcmV0LCBuZ3BpbzsNCj4gDQo+IC4uLg0KPiANCj4gPiArICAgICAgIGNsayA9
IGRldm1fY2xrX2dldCgmcGRldi0+ZGV2LCBOVUxMKTsNCj4gPiArICAgICAgIGlmIChJU19FUlIo
Y2xrKSkgew0KPiA+ICsgICAgICAgICAgICAgICBkZXZfZXJyKCZwZGV2LT5kZXYsICJkZXZtX2Ns
a19nZXQgZmFpbGVkXG4iKTsNCj4gPiArICAgICAgICAgICAgICAgcmV0dXJuIFBUUl9FUlIoY2xr
KTsNCj4gPiArICAgICAgIH0NCj4gDQo+IHJldHVybiBkZXZfZXJyX3Byb2JlKC4uLik7DQo+IA0K
PiBJdCdzIG5vdCBvbmx5IGNvbnZlbmllbnQsIGJ1dCBoZXJlIGl0IGZpeGVzIGEgYnVnLg0KV2ls
bCB1c2UgcmV0dXJuIGRldl9lcnJfcHJvYmUuDQo+IA0KPiA+ICsgICAgICAgcmV0ID0gY2xrX3By
ZXBhcmVfZW5hYmxlKGNsayk7DQo+ID4gKyAgICAgICBpZiAocmV0KSB7DQo+ID4gKyAgICAgICAg
ICAgICAgIGRldl9lcnIoJnBkZXYtPmRldiwgImZhaWxlZCB0byBlbmFibGUgY2xvY2tcbiIpOw0K
PiA+ICsgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiANCj4gcmV0dXJuIGRldl9lcnJfcHJv
YmUoLi4uKTsNClllcw0KPiANCj4gPiArICAgICAgIH0NCj4gDQo+IE1ha2UgaXQgbWFuYWdlZCBh
cyB3ZWxsIGluIGFkZGl0aW9uIHRvIGdwaW9jaGlwX2FkZF9kYXRhKCksIG90aGVyd2lzZQ0KPiB5
b3Ugd2lsbCBoYXZlIHdyb25nIG9yZGVyaW5nLg0KPiANCj4gLi4uDQo+IA0KPiA+ICsgICAgICAg
bmdwaW8gPSBvZl9pcnFfY291bnQobm9kZSk7DQo+ID4gKyAgICAgICBpZiAobmdwaW8gPiBOVU1f
R1BJTykgew0KPiA+ICsgICAgICAgICAgICAgICBkZXZfZXJyKGRldiwgIlRvbyBtYW55IEdQSU8g
aW50ZXJydXB0cyAobWF4PSVkKVxuIiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBOVU1f
R1BJTyk7DQo+ID4gKyAgICAgICAgICAgICAgIHJldCA9IC1FTlhJTzsNCj4gPiArICAgICAgICAg
ICAgICAgZ290byBjbGVhbnVwX2Nsb2NrOw0KPiANCj4gcmV0dXJuIGRldl9lcnJfcHJvYmUoLi4u
KTsNCkkgbmVlZCB0byBjbGVhbnVwIGNsb2NrIGJlZm9yZSByZXR1cm5pbmcsIHdpbGwgdXNlIGRl
dl9lcnJfcHJvYmUuDQo+IA0KPiA+ICsgICAgICAgfQ0KPiA+ICsNCj4gPiArICAgICAgIGlycV9w
YXJlbnQgPSBvZl9pcnFfZmluZF9wYXJlbnQobm9kZSk7DQo+ID4gKyAgICAgICBpZiAoIWlycV9w
YXJlbnQpIHsNCj4gPiArICAgICAgICAgICAgICAgZGV2X2VycihkZXYsICJubyBJUlEgcGFyZW50
IG5vZGVcbiIpOw0KPiA+ICsgICAgICAgICAgICAgICByZXQgPSAtRU5PREVWOw0KPiA+ICsgICAg
ICAgICAgICAgICBnb3RvIGNsZWFudXBfY2xvY2s7DQo+IA0KPiBEaXR0by4NCj4gDQo+ID4gKyAg
ICAgICB9DQo+ID4gKyAgICAgICBwYXJlbnQgPSBpcnFfZmluZF9ob3N0KGlycV9wYXJlbnQpOw0K
PiA+ICsgICAgICAgaWYgKCFwYXJlbnQpIHsNCj4gPiArICAgICAgICAgICAgICAgZGV2X2Vycihk
ZXYsICJubyBJUlEgcGFyZW50IGRvbWFpblxuIik7DQo+ID4gKyAgICAgICAgICAgICAgIHJldCA9
IC1FTk9ERVY7DQo+ID4gKyAgICAgICAgICAgICAgIGdvdG8gY2xlYW51cF9jbG9jazsNCj4gDQo+
IERpdHRvLg0KPiANCj4gPiArICAgICAgIH0NCj4gDQo+IFdoeSBkbyB5b3UgbmVlZCBhbGwgdGhl
c2U/IFNlZW1zIGEgY29weSduJ3Bhc3RlIGZyb20gZ3Bpby1zaWZpdmUsDQo+IHdoaWNoIGlzIHRo
ZSBvbmx5IEdQSU8gZHJpdmVyIHVzaW5nIHRoaXMgcGF0dGVybi4NClllcyBJIGJlbGlldmUgd2Ug
ZG8gbmVlZCBhbGwgdGhpcyBpbmZvcm1hdGlvbi4gWWVzIGl0IGlzIHNpbWlsaWFyDQppbXBsZW1l
bnRhdGlvbiB0byBzaWZpdmUuIE5vdCB0aGUgb25seSBkcml2ZXIgdXNpbmcgdGhpcyBwYXR0ZXJu
LCBjaGVjaw0KZ3Bpby1peHA0eHh4LmMNCg0KPiANCj4gLi4uDQo+IA0KPiA+ICsgICAgICAgICAg
ICAgICBtcGZzX2dwaW9fYXNzaWduX2JpdChtcGZzX2dwaW8tPmJhc2UgKyAoaSAqDQo+ID4gQllU
RV9CT1VOREFSWSksDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE1Q
RlNfR1BJT19FTl9JTlQsIDApOw0KPiANCj4gVG9vIG1hbnkgcGFyZW50aGVzZXMuDQo+IA0KPiAN
Cj4gPiArICAgICAgIGdpcnEtPmZ3bm9kZSA9IG9mX25vZGVfdG9fZndub2RlKG5vZGUpOw0KPiAN
Cj4gVGhpcyBpcyBhbiBpbnRlcmVzdGluZyB3YXkgb2YNCj4gDQo+ICAgICAuLi4tPmZ3bm9kZSA9
IGRldl9md25vZGUoZGV2KTsNCj4gDQo+IA0KPiAuLi4NCj4gDQo+ID4gKyAgICAgICBkZXZfaW5m
byhkZXYsICJNaWNyb2NoaXAgTVBGUyBHUElPIHJlZ2lzdGVyZWQsIG5ncGlvPSVkXG4iLA0KPiA+
IG5ncGlvKTsNCj4gDQo+IE5vaXNlLg0KTWF5YmUsIGJ1dCB1c2VmdWwgaW5mb3JtYXRpb24gdG8g
a25vdyB0aGUgbmdwaW8uDQo+IA0KPiAuLi4NCj4gDQo+ID4gKyAgICAgICAgICAgICAgIC5vZl9t
YXRjaF90YWJsZSA9IG9mX21hdGNoX3B0cihtcGZzX2dwaW9fbWF0Y2gpLA0KPiANCj4gUGxlYXNl
LCBhdm9pZCB1c2luZyBvZl9tYXRjaF9wdHIoKS4gSXQgYnJpbmdzIG1vcmUgaGFybSB0aGFuDQo+
IHVzZWZ1bG5lc3MuDQpPSw0KPiANCj4gLS0NCj4gV2l0aCBCZXN0IFJlZ2FyZHMsDQo+IEFuZHkg
U2hldmNoZW5rbw0K
