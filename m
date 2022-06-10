Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32A9054610F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 11:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344503AbiFJJIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 05:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348652AbiFJJHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 05:07:20 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7318A27CD41;
        Fri, 10 Jun 2022 02:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1654852002; x=1686388002;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=u6IkkjYaCsSsi6FAbkaLQLkcZUsEqnsAhazR1Ma0748=;
  b=JZqqF8kRHKozn7qzRQqFoliocxzst7eM6Q5TZhOYX9M7ZUECkapxLCYW
   4dCfu1GZQGyhb58p31oTloAEQpdBvVfSlwRM2XE+vianBbpoOlJL0zP09
   8W2JiY39kPBkSECa6qN9Q8pZKm4jzBlTPu4I0+bDA89KNhKTEtN//kz6g
   4v3GGvW7/uX600FKZcVpGHp8JP0WtRNejh5cQPXMEk3Okv2AG//Xolkhc
   SLXgUFBG6/S8OdkOzvrLZO/W96TnQXUrQVRAxPxxxs02rDUaavZuxbwvo
   L+j7vnk7NGsJozca9y/u/tZgC342pKzLzBSM7m++1OhV9Fi3ywrG9/khi
   g==;
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="167567808"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Jun 2022 02:06:39 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 10 Jun 2022 02:06:38 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Fri, 10 Jun 2022 02:06:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mm6kmNa5neKKj1Rqxsj9EDBmUIN1D0I+uVFUiB0EkDwexKWu8kY2jLKFlez5cwEFJCbFc7Ntz2HfVIzOoOaCUGgKTluutLrOlYiSlQxQl/mrKbZWOkKSkgfhJHvIbejVcsBJ9Qy6iPoCXyUMRrUHbaWgFJy9EqM3UjWhMaAgIlmvj3DittpZvL2tWpkRKY1DuMjJRLS9RCR/tq8nEO8e/Pno5GA80Z5ys3Py71qRKz+FO3LOfs9Wacz7QXYcCh4km4b+1lEIbFqMJLIftpu6USgKVa5hXdDm3RCt7B4od/6Cc9U7meWJdRB5ZB0M98DVgnFdRYH9bbN0w0sVX1vS7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u6IkkjYaCsSsi6FAbkaLQLkcZUsEqnsAhazR1Ma0748=;
 b=OiFQc0+Xd9+KZ32oTS4V/nJl4Xm6rhbuP5OWHOOPS4qE5YRYVCkwbbSFCNab+Vloh+tzgNCT72AhnL1pzJkkcPS3cgD4bQoMHDkGjGBywuTlmsC1Cg1yL5rlI8pfTrw8tk0nGMkKsqmoSc1tOzOaEl3sbW//vmBRUoG6Mj4chh/Qr3RcXJ0IuBVFPQuamTOwO7mHTb+JrAmFpBeFU4d9qAdSb+OM3r6c6fgQwOiiRM90wBm5l7j45zNL0z11UrmAPLSRA5++u278uxm43bBvChSqJ1vLkdq1NFm526xzNXdeoBm9dvr7S33BY0gLfHHFjDzbgROIDvkiLeDntUC0CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u6IkkjYaCsSsi6FAbkaLQLkcZUsEqnsAhazR1Ma0748=;
 b=AvBLxeYea/gBEB1jRjB2Ka97FovjRs4jDFNqmcTWEA6K99WO2PRAuB5v/7gxUDTYN1/ZRPdhjZAf+7XGIn4XcFeKU4K4+PL7CUJkeuTLqWDW6zgsUv6EgzCiifXNYD7qJUhszqWyriB0NVAHBkfen/kgTY4gJiUmHX0FgNElxf4=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by BN6PR11MB4179.namprd11.prod.outlook.com (2603:10b6:405:76::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Fri, 10 Jun
 2022 09:06:28 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5cfe:8088:aa93:fce8]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5cfe:8088:aa93:fce8%3]) with mapi id 15.20.5332.014; Fri, 10 Jun 2022
 09:06:28 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Kavyasree.Kotagiri@microchip.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v2 3/3] mfd: atmel-flexcom: Add support for lan966x
 flexcom chip-select configuration
Thread-Topic: [PATCH v2 3/3] mfd: atmel-flexcom: Add support for lan966x
 flexcom chip-select configuration
Thread-Index: AQHYewpD6TYRiClo40O9i0W3EvVFaw==
Date:   Fri, 10 Jun 2022 09:06:28 +0000
Message-ID: <f48463f1-ce64-08e6-0d37-614b76edcdd0@microchip.com>
References: <20220607144740.14937-1-kavyasree.kotagiri@microchip.com>
 <20220607144740.14937-4-kavyasree.kotagiri@microchip.com>
 <9cf14336-16c3-5df5-b235-3f988d8b5151@microchip.com>
 <CO1PR11MB4865879F14D49AF7550C2D1192A49@CO1PR11MB4865.namprd11.prod.outlook.com>
 <c3a17994-72dd-8b64-4ddd-9deb3c793e24@microchip.com>
 <CO1PR11MB486542298A4208581AD8DCBD92A79@CO1PR11MB4865.namprd11.prod.outlook.com>
 <914DED99-7DC0-4014-90D4-4CC54C99CAEC@microchip.com>
In-Reply-To: <914DED99-7DC0-4014-90D4-4CC54C99CAEC@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ebd93d2c-e980-40c7-6d0d-08da4ac080c7
x-ms-traffictypediagnostic: BN6PR11MB4179:EE_
x-microsoft-antispam-prvs: <BN6PR11MB4179E018D49173FC4D39EA1687A69@BN6PR11MB4179.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J79/7/jDb/a0VpKgn74u/gYzdGim+3yb1Mgj2wm6NSRy/3unrD8QAuWVIJQzRdhncY1DFtZrpJsixIxBx5DWTzcKqXvZh2o+C+NC8NwZwhB+YfIWtSZ3TFON82DTuI9V98SX047KuHb765Dj9o5vMyKp2TB0PfTiNLBFP1pl+v6XapRIpKzXrE/6etkmAvEh6Q75fjfvEA4T1+rJNqPjHFon1xB0Vf//pjIo3FkIKbhOsqYnVoetk1RGVALXTZ1lSvlvdRgZ5hzOkueaki2kq2nIsPyEKY0KKQipfmSIQxsovj4zFYnh6255cnZyf9xIMs8b414D0T6nnENV/NH7ckUUZZU/mu9xGXr0KF+QHC/aAIscAKRbnfoMGL2aEkIBoE3ZTRaInwPy0N0TbFOKaVoNvphXC6HVqm0m/tJWafrRpy8/gT/7rqTk8onGtryPq/SOfTZ7PW/2Od/w7VPeoyYDllonuFhkwyFg/imNiJZFGjnR9jtDTpdTmAHIhuyGCVsv6pPKOQKh8hd3MrKrz0UOqVceLi+dfE2zq6F4KEjDmEmIlZXo1DHMGPaGiv/3Ldh6fs2MqTG62d1nADDQAYhAHatjySgSydNg/pZtXC8ktVFot5r4Bz84xtw3/WNaiTXzsF/l43gG+eG6pQrCrKgj7mBlmfjVpdbEzgu5+VFk4IKMCLraEDElPZFvyuQnCr6jPT3wspsTc3wFmiDMKCknEaYqAXQBBny6DNJoxz1AQ7svv9eMKhGopy+/K5T8r6IdOeRfV7sRdOWfZZCh6iXqY85Yvj9SMmsHO2lcFW5r6m1gFhxDtlHFqbqp/3Kcj5MNaDE+LTGMHbXCUuHcdLe1C6ntJo89ua9EAShZy+Rk+0CwAsBp3TiZiGd5bZ1arRah8gPWkZAxfppkDmD/ig==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(45080400002)(5660300002)(26005)(6512007)(8936002)(6862004)(53546011)(86362001)(31696002)(6506007)(6486002)(966005)(2906002)(122000001)(508600001)(37006003)(54906003)(38100700002)(71200400001)(2616005)(186003)(38070700005)(83380400001)(4326008)(36756003)(66476007)(66446008)(316002)(66556008)(91956017)(66946007)(8676002)(64756008)(31686004)(76116006)(6636002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VGVsd3JmRFUvZTMrRE5sSlRpcFYxaEdzU2VnKzVLMlBSUjE5UTY0bzE4Z3lp?=
 =?utf-8?B?QWVZejNZbGRzM29HUm1qRWtZdmRzclVQanpURkltdm9WNTVwQjdVMU9xckR5?=
 =?utf-8?B?M0RaSkQrZVZjdGNhWWlMSGFrTm4yeDgvbEJqcVg3eWozS29Pa0prWW1qdGZ0?=
 =?utf-8?B?ZmNtRnRWL2k0ZFZENG9IdGpCNGpDVjkxeEo1TDZ0b0xsTGdjNFJjVElBblY0?=
 =?utf-8?B?TUxkcUhyampCR0sxQ0UxTEtuS0dRSkpDSHRmemdUQVNQYXdmcm1TcHNKUjlQ?=
 =?utf-8?B?UWliZ05uVnJNV2RzcjE2VE0rTk9aVFRLY1VWTU94dTF1NDMyNG1nSlFtQ0tu?=
 =?utf-8?B?azVyL3lrZ3czc0svYS9zUVlGV2g5RG5FQmM4amFCNHp2dGpGUjRHSm9hQlFs?=
 =?utf-8?B?dXRrc0xKZFhoMno2cmNEUGZDUkVJVGFoVE1JOStaeGVqWlNzV2V6S25wWit4?=
 =?utf-8?B?WFgwc1FQM2lVOGNvZjRuWThSYWlQbWtpKzU5UWw1bVMwWU5jYlZraUJhUDRC?=
 =?utf-8?B?L1pDazNZSDFIYnJhckZjWS8vc05hMmowb1ZiMFJ1T0Jpd0daOXR2SjJhSzZh?=
 =?utf-8?B?aklhekJudGN4cTE2bXMxV0lTVU4rUkJkdm5PQUw0VSttZGFwV1RpUjJyZk4r?=
 =?utf-8?B?T015MnFjZk05NzVlTTdmbURWNEhGWDBiNDhaWEthVWVSaS9Pc1BDaDByaW5i?=
 =?utf-8?B?c0hON0s5VDJ3UVBVNTZPbnJWSEU5YUdhNDB4aVM2R2ZaNlBtdnI1K1VEanQw?=
 =?utf-8?B?bVk2eFJEcVVIa2JwWlBHaXc1cFpDMmtxTHZxRlRJQU5saUVPR21kTWwvQWtF?=
 =?utf-8?B?U2Y1UnhBWFFNb0xTalRZWmhQYWxaYUNDZkx1WFN3YlY5a1podEtieEdsY0FU?=
 =?utf-8?B?aktXUk1ZbUcrbjdXQXdRUG5GRS9QZUtKNEtxSmZVSWw0QWloZDV2TW5EMFIw?=
 =?utf-8?B?Z29JWWR3QmFUb3ppVG5VM2RTS1JxRCtsdXBKZjdpaXRKK2RibXFLSjVyRDA4?=
 =?utf-8?B?SHhDSzc4SDQwb1UyUDN3TG0zQlZHTmJQWG12UDhUNDdlODdLNHBKQ0lGRlZR?=
 =?utf-8?B?eGdDdmJ6QnV6WTJwUmxWaS9lL0NlTTdQK3gyMysveGNRZlRlMmtsMDlrMVRL?=
 =?utf-8?B?dFcwcFlwVktpc2srWHUyQzdNMForL0NNRTJYZWgvVEtKM0J4Z01XSVk1U09n?=
 =?utf-8?B?N3hCZllqaUZXZkIzSVFGWVZJMjJLaDAzaHplZDZUVGQyaUczbWluMmN4VDBR?=
 =?utf-8?B?VnRka2VjQmN4aDhhcFpGYnB2c0g0ajdZSXZ2L2EvWjRIcWVJTm5yMlE0M2Fi?=
 =?utf-8?B?UjI5enROM1NzMW5qWCtOd01FclRDZy9PNE1NTG1jUzV1RklLU21pR0U1SW9I?=
 =?utf-8?B?bUFrU29sZ0N6NDF2Z2Yzck1xTEVIYkxUaHlRK1BtVzEvUHlsZkhIdWt6VGEx?=
 =?utf-8?B?RUNlZ25oS0paWjIrcFgvQXdSRHc3K21lc3hMcFRnUHk4U2ZnWnRjdDZFVGNR?=
 =?utf-8?B?dkJnZndQdHlBWGViaVgrMnZwYmo1a21BZXJJU2dUU3hqcVFuQW8wbGRzSVhk?=
 =?utf-8?B?bXAzbmgwN0dRenk5M2JjSzJVVmJSajFtcUU0STFXVHpNR2FsbUt0VWtkL2VY?=
 =?utf-8?B?VEFaM3VuYVUxYUE0blMzT0kzdEFHTmJQWUd3ZC9yMUtIT1c3TlBsb0lwb1RU?=
 =?utf-8?B?ZjFSekZBekRxZUhrYXZwYXdNdzRmaWR1U2ZJN3RTQ1R5eTJlemRYOHM4SEJP?=
 =?utf-8?B?WUdPVEhEcmJTODZrcXNMTlUxeXNqUXB1c0x1cUZvU3FIYXlrbzIyNnpRM2RH?=
 =?utf-8?B?L0JDWU9zbmdYWUNIbGNneFliMEdHZmYreHVxdE44RDNNVGZPbmpMVThlckNF?=
 =?utf-8?B?N3FaQkZOekZ5QXl6NmJnb0NNcVhicEJVcmhFMGZtQWhZUXZ3QlV5cEQxVmRQ?=
 =?utf-8?B?V3RXNXF5WFZSekx4OGNreDhHUy9GZUMvY1lJWjZha1ZkU1huT1VCNUErWldN?=
 =?utf-8?B?Q3VXcGM3STI3OVhnNVkvWWtVY2t0OHBrT1lRTDJoa3dLd2dtcmI4b2oyYUFE?=
 =?utf-8?B?MzMrT3dMMEE5MHJ5RmNGd3Nwa2t1NWNBWlJIdEVLeWl5ZEY1SkFLUW9YUFVS?=
 =?utf-8?B?YmdydnJkaEhEc2NzRkpQTVJBWW9YcjgwVVNSZjdVZkNHMU9PVEI5T0E4cHpP?=
 =?utf-8?B?dXluVTRRa3BhcFVwOXN3RVNyMGduMGk1UjUwYlA1T0xHVkVSaUgrUHZLODk2?=
 =?utf-8?B?Qk90MyttdWpaS1RxQjdmUjZsQU9pWGNLWlMrSDdhMnlTUkNuVHZ2S0RIcGpO?=
 =?utf-8?B?SmkzRW1aT0FnVzY3VVd1c3NaaGZkM2E4OXp4NUlaVTdmMHc1Z0JqNUNtZFhW?=
 =?utf-8?Q?H80OypBD1vGctNo0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5185416B1D966B4B8AF7CBB027207AA6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebd93d2c-e980-40c7-6d0d-08da4ac080c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2022 09:06:28.0919
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sAyvcUY78YuxH6n6s6ZVVaigHppk+OfQ4PQdBalQSCsrTPOGkDenAq5EEE62UvndhbN23q5w9nMVzoaXDTevKa8WtCPj1FO8/hVQy9deWoQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB4179
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDkuMDYuMjAyMiAxNjozNCwgS2F2eWFzcmVlIEtvdGFnaXJpIC0gSTMwOTc4IHdyb3RlOg0K
PiANCj4+Pj4+PiBMQU45NjZ4IFNvQyBoYXZlIDUgZmxleGNvbXMuIEVhY2ggZmxleGNvbSBoYXMg
MiBjaGlwLXNlbGVjdHMuDQo+Pj4+Pj4gRm9yIGVhY2ggY2hpcCBzZWxlY3Qgb2YgZWFjaCBmbGV4
Y29tIHRoZXJlIGlzIGEgY29uZmlndXJhdGlvbg0KPj4+Pj4+IHJlZ2lzdGVyIEZMRVhDT01fU0hB
UkVEWzAtNF06U1NfTUFTS1swLTFdLiBUaGUgd2lkdGggb2YNCj4+Pj4+PiBjb25maWd1cmF0aW9u
IHJlZ2lzdGVyIGlzIDIxIGJlY2F1c2UgdGhlcmUgYXJlIDIxIHNoYXJlZCBwaW5zDQo+Pj4+Pj4g
b24gZWFjaCBvZiB3aGljaCB0aGUgY2hpcCBzZWxlY3QgY2FuIGJlIG1hcHBlZC4gRWFjaCBiaXQg
b2YgdGhlDQo+Pj4+Pj4gcmVnaXN0ZXIgcmVwcmVzZW50cyBhIGRpZmZlcmVudCBGTEVYQ09NX1NI
QVJFRCBwaW4uDQo+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogS2F2eWFzcmVlIEtvdGFnaXJpIDxrYXZ5
YXNyZWUua290YWdpcmlAbWljcm9jaGlwLmNvbT4NCj4+Pj4+PiAtLS0NCj4+Pj4+PiB2MSAtPiB2
MjoNCj4+Pj4+PiAtIHVzZSBHRU5NQVNLIGZvciBtYXNrLCBtYWNyb3MgZm9yIG1heGltdW0gYWxs
b3dlZCB2YWx1ZXMuDQo+Pj4+Pj4gLSB1c2UgdTMyIHZhbHVlcyBmb3IgZmxleGNvbSBjaGlwc2Vs
ZWN0cyBpbnN0ZWFkIG9mIHN0cmluZ3MuDQo+Pj4+Pj4gLSBkaXNhYmxlIGNsb2NrIGluIGNhc2Ug
b2YgZXJyb3JzLg0KPj4+Pj4+IGRyaXZlcnMvbWZkL2F0bWVsLWZsZXhjb20uYyB8IDkzDQo+Pj4+
PiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystDQo+Pj4+Pj4gMSBmaWxlIGNo
YW5nZWQsIDkyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4+Pj4+PiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9tZmQvYXRtZWwtZmxleGNvbS5jIGIvZHJpdmVycy9tZmQvYXRtZWwtZmxleGNv
bS5jDQo+Pj4+Pj4gaW5kZXggMzNjYWE0ZmJhNmFmLi5hYzcwMGE4NWI0NmYgMTAwNjQ0DQo+Pj4+
Pj4gLS0tIGEvZHJpdmVycy9tZmQvYXRtZWwtZmxleGNvbS5jDQo+Pj4+Pj4gKysrIGIvZHJpdmVy
cy9tZmQvYXRtZWwtZmxleGNvbS5jDQo+Pj4+Pj4gQEAgLTI4LDE1ICsyOCw2OCBAQA0KPj4+Pj4+
ICNkZWZpbmUgRkxFWF9NUl9PUE1PREUob3Btb2RlKSAgICAoKChvcG1vZGUpIDw8DQo+Pj4+PiBG
TEVYX01SX09QTU9ERV9PRkZTRVQpICYgICAgXA0KPj4+Pj4+ICAgICAgICAgICAgICAgIEZMRVhf
TVJfT1BNT0RFX01BU0spDQo+Pj4+Pj4gKy8qIExBTjk2NnggZmxleGNvbSBzaGFyZWQgcmVnaXN0
ZXIgb2Zmc2V0cyAqLw0KPj4+Pj4+ICsjZGVmaW5lIEZMRVhfU0hSRF9TU19NQVNLXzAgICAgMHgw
DQo+Pj4+Pj4gKyNkZWZpbmUgRkxFWF9TSFJEX1NTX01BU0tfMSAgICAweDQNCj4+Pj4+PiArI2Rl
ZmluZSBGTEVYX1NIUkRfUElOX01BWCAgICAyMA0KPj4+Pj4+ICsjZGVmaW5lIEZMRVhfQ1NfTUFY
ICAgICAgICAxDQo+Pj4+Pj4gKyNkZWZpbmUgRkxFWF9TSFJEX01BU0sgICAgICAgIEdFTk1BU0so
MjAsIDApDQo+Pj4+Pj4gKw0KPj4+Pj4+ICtzdHJ1Y3QgYXRtZWxfZmxleF9jYXBzIHsNCj4+Pj4+
PiArICAgIGJvb2wgaGFzX2ZseF9jczsNCj4+Pj4+PiArfTsNCj4+Pj4+PiArDQo+Pj4+Pj4gc3Ry
dWN0IGF0bWVsX2ZsZXhjb20gew0KPj4+Pj4+ICAgdm9pZCBfX2lvbWVtICpiYXNlOw0KPj4+Pj4+
ICsgICAgdm9pZCBfX2lvbWVtICpmbGV4Y29tX3NoYXJlZF9iYXNlOw0KPj4+Pj4+ICAgdTMyIG9w
bW9kZTsNCj4+Pj4+PiAgIHN0cnVjdCBjbGsgKmNsazsNCj4+Pj4+PiB9Ow0KPj4+Pj4+ICtzdGF0
aWMgaW50IGF0bWVsX2ZsZXhjb21fbGFuOTY2eF9jc19jb25maWcoc3RydWN0IHBsYXRmb3JtX2Rl
dmljZQ0KPj4+ICpwZGV2KQ0KPj4+Pj4+ICt7DQo+Pj4+Pj4gKyAgICBzdHJ1Y3QgYXRtZWxfZmxl
eGNvbSAqZGRhdGEgPSBkZXZfZ2V0X2RydmRhdGEoJnBkZXYtPmRldik7DQo+Pj4+Pj4gKyAgICBz
dHJ1Y3QgZGV2aWNlX25vZGUgKm5wID0gcGRldi0+ZGV2Lm9mX25vZGU7DQo+Pj4+Pj4gKyAgICB1
MzIgZmx4X3NocmRfcGluc1syXSwgZmx4X2NzWzJdLCB2YWw7DQo+Pj4+Pj4gKyAgICBpbnQgZXJy
LCBpLCBjb3VudDsNCj4+Pj4+PiArDQo+Pj4+Pj4gKyAgICBjb3VudCA9IG9mX3Byb3BlcnR5X2Nv
dW50X3UzMl9lbGVtcyhucCwgIm1pY3JvY2hpcCxmbHgtc2hyZC0NCj4+Pj4+IHBpbnMiKTsNCj4+
Pj4+PiArICAgIGlmIChjb3VudCA8PSAwIHx8IGNvdW50ID4gMikgew0KPj4+Pj4+ICsgICAgICAg
IGRldl9lcnIoJnBkZXYtPmRldiwgIkludmFsaWQgJXMgcHJvcGVydHkgKCVkKVxuIiwgImZseC1z
aHJkLQ0KPj4+Pj4gcGlucyIsDQo+Pj4+Pj4gKyAgICAgICAgICAgICAgICBjb3VudCk7DQo+Pj4+
Pj4gKyAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+Pj4+Pj4gKyAgICB9DQo+Pj4+Pj4gKw0KPj4+
Pj4+ICsgICAgZXJyID0gb2ZfcHJvcGVydHlfcmVhZF91MzJfYXJyYXkobnAsICJtaWNyb2NoaXAs
Zmx4LXNocmQtcGlucyIsDQo+Pj4+PiBmbHhfc2hyZF9waW5zLCBjb3VudCk7DQo+Pj4+Pj4gKyAg
ICBpZiAoZXJyKQ0KPj4+Pj4+ICsgICAgICAgIHJldHVybiBlcnI7DQo+Pj4+Pj4gKw0KPj4+Pj4+
ICsgICAgZXJyID0gb2ZfcHJvcGVydHlfcmVhZF91MzJfYXJyYXkobnAsICJtaWNyb2NoaXAsZmx4
LWNzIiwgZmx4X2NzLA0KPj4+Pj4gY291bnQpOw0KPj4+Pj4+ICsgICAgaWYgKGVycikNCj4+Pj4+
PiArICAgICAgICByZXR1cm4gZXJyOw0KPj4+Pj4+ICsNCj4+Pj4+PiArICAgIGZvciAoaSA9IDA7
IGkgPCBjb3VudDsgaSsrKSB7DQo+Pj4+Pj4gKyAgICAgICAgaWYgKGZseF9zaHJkX3BpbnNbaV0g
PiBGTEVYX1NIUkRfUElOX01BWCkNCj4+Pj4+PiArICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7
DQo+Pj4+Pj4gKw0KPj4+Pj4+ICsgICAgICAgIGlmIChmbHhfY3NbaV0gPiBGTEVYX0NTX01BWCkN
Cj4+Pj4+PiArICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+Pj4+Pj4gKw0KPj4+Pj4+ICsg
ICAgICAgIHZhbCA9IH4oMSA8PCBmbHhfc2hyZF9waW5zW2ldKSAmIEZMRVhfU0hSRF9NQVNLOw0K
Pj4+Pj4+ICsNCj4+Pj4+PiArICAgICAgICBpZiAoZmx4X2NzW2ldID09IDApDQo+Pj4+Pj4gKyAg
ICAgICAgICAgIHdyaXRlbCh2YWwsIGRkYXRhLT5mbGV4Y29tX3NoYXJlZF9iYXNlICsNCj4+Pj4+
IEZMRVhfU0hSRF9TU19NQVNLXzApOw0KPj4+Pj4+ICsgICAgICAgIGVsc2UNCj4+Pj4+PiArICAg
ICAgICAgICAgd3JpdGVsKHZhbCwgZGRhdGEtPmZsZXhjb21fc2hhcmVkX2Jhc2UgKw0KPj4+Pj4g
RkxFWF9TSFJEX1NTX01BU0tfMSk7DQo+Pj4+PiBUaGVyZSBpcyBzdGlsbCBhbiBvcGVuIHF1ZXN0
aW9uIG9uIHRoaXMgdG9waWMgZnJvbSBwcmV2aW91cyB2ZXJzaW9uLg0KPj4+PiBodHRwczovL2xv
cmUua2VybmVsLm9yZy9saW51eC1hcm0tDQo+Pj4ga2VybmVsL1BIMFBSMTFNQjQ4NzI0REUwOUE1
MEQ2N0YxRUE5RkJFMDkyRDg5QFBIMFBSMTFNQjQ4NzIubg0KPj4+IGFtcHJkMTEucHJvZC5vdXRs
b29rLmNvbS8NCj4+PiAicHJldmlvdXMgdmVyc2lvbiIgbWVhbnQgZm9yIG1lIHRoaXMgdGhlIG9u
ZSBhdCBbMV0uLi4gQW5vdGhlciBwb2ludCB0aGF0DQo+Pj4gdGhlIHZlcnNpb25pbmcgb2YgdGhp
cyBzZXJpZXMgaXMgYmFkLg0KPj4+IFRoZSBxdWVzdGlvbiB3YXMgdGhlIGZvbGxvd2luZzoNCj4+
PiAiSSBtYXkgbWlzcyBzb21ldGhpbmcgYnV0IEkgZG9uJ3Qgc2VlIGhlcmUgdGhlIGFwcHJvYWNo
IHlvdSBpbnRyb2R1Y2VkIGluDQo+Pj4gWzFdOg0KPj4+ICsgICAgICAgICAgICBlcnIgPSBtdXhf
Y29udHJvbF9zZWxlY3QoZmx4X211eCwgYXJncy5hcmdzWzBdKTsNCj4+PiArICAgICAgICAgICAg
aWYgKCFlcnIpIHsNCj4+PiArICAgICAgICAgICAgICAgIG11eF9jb250cm9sX2Rlc2VsZWN0KGZs
eF9tdXgpOw0KPj4+ICINCj4+PiBBcyBJIGhhZCBpbiBtaW5kIHRoYXQgeW91IHNhaWQgeW91IG5l
ZWQgbXV4X2NvbnRyb2xfZGVzZWxlY3QoKSBiZWNhdXNlDQo+Pj4geW91cg0KPj4+IHNlcmlhbCBy
ZW1haW4gYmxvY2tlZCBvdGhlcndpc2UgKGJ1dCBJIGRvbid0IGZpbmQgdGhhdCBpbiB0aGUgY29t
bWVudHMgb2YNCj4+PiBbMV0pLiBBbmQgSSBkb24ndCBzZWUgc29tZXRoaW5nIHNpbWlsYXIgdG8g
bXV4X2NvbnRyb2xfZGVzZWxlY3QoKSBiZWluZw0KPj4+IGNhbGxlZCBpbiB0aGlzIHBhdGNoLg0K
Pj4+IFsxXQ0KPj4+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWFybS1rZXJuZWwvNWY5
ZmNjMzMtY2MwZi1jNDA0LWNmN2YtDQo+Pj4gY2I3M2Y2MDE1NGZmQG1pY3JvY2hpcC5jb20vDQo+
Pj4+IEFzIHBhcnQgb2YgY29tbWVudHMgZnJvbSBQZXRlciBSb3NpbiAtIEluc3RlYWQgb2YgdXNp
bmcgbXV4IGRyaXZlciwgVGhpcw0KPj4+IHBhdGNoIGlzIGludHJvZHVjaW5nDQo+Pj4+IG5ldyBk
dC1wcm9wZXJ0aWVzIGluIGF0bWVsLWZsZXhvbSBkcml2ZXIgaXRsc2VsZiB0byBjb25maWd1cmUg
RmxleGNvbQ0KPj4+IHNoYXJlZCByZWdpc3RlcnMuDQo+Pj4+IEJhc2VkIG9uIHRoZSBjaGlwLXNl
bGVjdCgwIG9yIDEpIHRvIGJlIG1hcHBlZCB0byBmbGV4Y29tIHNoYXJlZCBwaW4sIHdyaXRlDQo+
Pj4gdG8gdGhlDQo+Pj4+IHJlc3BlY3RpdmUgcmVnaXN0ZXIuDQo+Pj4+IElmIHlvdSBzdGlsbCBo
YXZlIGFueSBxdWVzdGlvbnMsIHBsZWFzZSBjb21tZW50Lg0KPj4gaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvbGludXgtYXJtLWtlcm5lbC9QSDBQUjExTUI0ODcyNERFMDlBNTBENjdGMUVBOUZCRTA5
MkQ4OUBQSDBQUjExTUI0ODcyLm5hbXByZDExLnByb2Qub3V0bG9vay5jb20vDQo+PiBUbyBhdm9p
ZCBjb25mdXNpb24sIEkgc3RvcHBlZCBjb250aW51aW5nIHdpdGggYWJvdmUgcGF0Y2ggdmVyc2lv
bmluZyhtdXggZHJpdmVyIGFwcHJvYWNoKS4NCj4+IEkgc3RhcnRlZCBuZXcgcGF0Y2ggc2VyaWVz
IGluIHdoaWNoIEkgYW0gY29uZmlndXJpbmcgRkxFWENPTV9TSEFSRURbMC00XTpTU19NQVNLWzAt
MV0NCj4+IHJlZ2lzdGVycyBpbiBhdG1lbC1mbGV4Y29tLmMgZHJpdmVyIHVzaW5nIG5ldyBEVC1w
cm9wZXJ0aWVzLCBtdXggZHJpdmVyIGFwcHJvYWNoIGlzIG5vIG1vcmUgZm9sbG93ZWQNCj4+IGFz
IHN1Z2dlc3RlZCBieSBQZXRlciBSb3NpbjoNCj4+ICINCj4+PiBJZiB5b3UgYXJlIGNvbnRlbnQg
d2l0aCBqdXN0IHByb2dyYW1taW5nIGEgZml4ZWQgc2V0IG9mIHZhbHVlcyB0bw0KPj4+IGEgY291
cGxlIG9mIHJlZ2lzdGVycyBkZXBlbmRpbmcgb24gaG93IHRoZSBib2FyZCBpcyB3aXJlZCwgc29t
ZQ0KPj4+IGV4dHJhIERUIHByb3BlcnR5IG9uIHNvbWUgbm9kZSByZWxhdGVkIHRvIHRoZSBmbGV4
Y29tIHNlZW1zIGxpa2UNCj4+PiBhIGJldHRlciBmaXQgdGhhbiBhIG11eCBkcml2ZXIuDQo+PiBC
YXNlZCBvbiB5b3VyIGlucHV0cywgSSBwbGFubmVkIHRvIHNlbmQgYSBuZXcgcGF0Y2ggd2l0aCBu
ZXcgRFQgcHJvcGVydGllcw0KPj4gaW50cm9kdWNlZCBpbiBhdG1lbC1mbGV4Y29tLmMgZHJpdmVy
IHJhdGhlciB0aGFuIG11eCBkcml2ZXIuDQo+Pg0KPj4gVGhhbmtzLA0KPj4gS2F2eWENCj4+ICIN
Cj4+DQo+PiBUaGFua3MsDQo+PiBLYXZ5YQ0KPiANCj4gSGkgQ2xhdWRpdSwNCj4gDQo+IFBsZWFz
ZSBsZXQgbWUga25vdyBpZiB5b3Ugc3RpbGwgaGF2ZSBhbnkgY29tbWVudHMuIElmIG5vdCwgSSB3
aWxsIHNlbmQgbXkgdjMgd2l0aCBjbGtfZGlzYWJsZV91bnByZXBhcmUgbW92ZWQgdG8gZ290byBh
bmQgc29tZSBtaW5vciBmaXhlcyhpcnEgZmxhZ3MpIGluIGR0LWJpbmRpbmdzLg0KDQpJIGdvdCBp
dCBub3cgYWZ0ZXIgdGhlIHRhbGsgd2UgaGFkIG9uIGludGVybmFsIGNoYXQuIFBsZWFzZSBnbyB3
aXRoIHYzLg0KDQpUaGFuayB5b3UsDQpDbGF1ZGl1IEJlem5lYQ0KDQo+IA0KPj4+Pj4+ICsgICAg
fQ0KPj4+Pj4+ICsNCj4+Pj4+PiArICAgIHJldHVybiAwOw0KPj4+Pj4+ICt9DQo+Pj4+Pj4gKw0K
Pj4+Pj4+IHN0YXRpYyBpbnQgYXRtZWxfZmxleGNvbV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2
aWNlICpwZGV2KQ0KPj4+Pj4+IHsNCj4+Pj4+PiAgIHN0cnVjdCBkZXZpY2Vfbm9kZSAqbnAgPSBw
ZGV2LT5kZXYub2Zfbm9kZTsNCj4+Pj4+PiArICAgIGNvbnN0IHN0cnVjdCBhdG1lbF9mbGV4X2Nh
cHMgKmNhcHM7DQo+Pj4+Pj4gICBzdHJ1Y3QgcmVzb3VyY2UgKnJlczsNCj4+Pj4+PiAgIHN0cnVj
dCBhdG1lbF9mbGV4Y29tICpkZGF0YTsNCj4+Pj4+PiAgIGludCBlcnI7DQo+Pj4+Pj4gQEAgLTc2
LDEzICsxMjksNTEgQEAgc3RhdGljIGludCBhdG1lbF9mbGV4Y29tX3Byb2JlKHN0cnVjdA0KPj4+
Pj4gcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPj4+Pj4+ICAgICovDQo+Pj4+Pj4gICB3cml0ZWwo
RkxFWF9NUl9PUE1PREUoZGRhdGEtPm9wbW9kZSksIGRkYXRhLT5iYXNlICsNCj4+Pj4+IEZMRVhf
TVIpOw0KPj4+Pj4+ICsgICAgY2FwcyA9IG9mX2RldmljZV9nZXRfbWF0Y2hfZGF0YSgmcGRldi0+
ZGV2KTsNCj4+Pj4+PiArICAgIGlmICghY2Fwcykgew0KPj4+Pj4+ICsgICAgICAgIGRldl9lcnIo
JnBkZXYtPmRldiwgIkNvdWxkIG5vdCByZXRyaWV2ZSBmbGV4Y29tIGNhcHNcbiIpOw0KPj4+Pj4+
ICsgICAgICAgIGNsa19kaXNhYmxlX3VucHJlcGFyZShkZGF0YS0+Y2xrKTsNCj4+Pj4+IENvdWxk
IHlvdSBrZWVwIGEgY29tbW9uIHBhdGggdG8gZGlzYWJsZSB0aGUgY2xvY2s/IEEgZ290byBsYWJl
bA0KPj4+IHNvbWV0aGluZw0KPj4+Pj4gbGlrZSB0aGlzOg0KPj4+Pj4gICAgICAgcmV0ID0gLUVJ
TlZBTDsNCj4+Pj4+ICAgICAgIGdvdCBjbGtfZGlzYWJsZV91bnByZXBhcmU7DQo+Pj4+Pj4gKyAg
ICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+Pj4+Pj4gKyAgICB9DQo+Pj4+Pj4gKw0KPj4+Pj4+ICsg
ICAgaWYgKGNhcHMtPmhhc19mbHhfY3MpIHsNCj4+Pj4+PiArICAgICAgICBkZGF0YS0+ZmxleGNv
bV9zaGFyZWRfYmFzZSA9DQo+Pj4+PiBkZXZtX3BsYXRmb3JtX2dldF9hbmRfaW9yZW1hcF9yZXNv
dXJjZShwZGV2LCAxLCBOVUxMKTsNCj4+Pj4+PiArICAgICAgICBpZiAoSVNfRVJSKGRkYXRhLT5m
bGV4Y29tX3NoYXJlZF9iYXNlKSkgew0KPj4+Pj4+ICsgICAgICAgICAgICBjbGtfZGlzYWJsZV91
bnByZXBhcmUoZGRhdGEtPmNsayk7DQo+Pj4+Pj4gKyAgICAgICAgICAgIHJldHVybiBkZXZfZXJy
X3Byb2JlKCZwZGV2LT5kZXYsDQo+Pj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgUFRSX0VSUihk
ZGF0YS0NCj4+Pj4+PiBmbGV4Y29tX3NoYXJlZF9iYXNlKSwNCj4+Pj4+PiArICAgICAgICAgICAg
ICAgICAgICAiZmFpbGVkIHRvIGdldCBmbGV4Y29tIHNoYXJlZCBiYXNlDQo+Pj4+PiBhZGRyZXNz
XG4iKTsNCj4+Pj4+ICAgICAgICAgICByZXQgPSBkZXZfZXJyX3Byb2JlKC4uLik7DQo+Pj4+PiAg
ICAgICAgICAgZ290byBjbGtfZGlzYWJsZV91bnByZXBhcmU7DQo+Pj4+Pj4gKyAgICAgICAgfQ0K
Pj4+Pj4+ICsNCj4+Pj4+PiArICAgICAgICBlcnIgPSBhdG1lbF9mbGV4Y29tX2xhbjk2NnhfY3Nf
Y29uZmlnKHBkZXYpOw0KPj4+Pj4+ICsgICAgICAgIGlmIChlcnIpIHsNCj4+Pj4+PiArICAgICAg
ICAgICAgY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGRkYXRhLT5jbGspOw0KPj4+Pj4+ICsgICAgICAg
ICAgICByZXR1cm4gZXJyOw0KPj4+Pj4gICAgICAgICAgIGdvdG8gY2xrX2Rpc2FibGVfdW5wcmVw
YXJlOw0KPj4+Pj4+ICsgICAgICAgIH0NCj4+Pj4+PiArICAgIH0NCj4+Pj4+PiArDQo+Pj4+PiBj
bGtfdW5wcmVwYXJlOg0KPj4+Pj4+ICAgY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGRkYXRhLT5jbGsp
Ow0KPj4+Pj4gICBpZiAocmV0KQ0KPj4+Pj4gICAgICAgcmV0dXJuIHJldDsNCj4+Pj4+PiAgIHJl
dHVybiBkZXZtX29mX3BsYXRmb3JtX3BvcHVsYXRlKCZwZGV2LT5kZXYpOw0KPj4+Pj4+IH0NCj4+
Pj4+PiArc3RhdGljIGNvbnN0IHN0cnVjdCBhdG1lbF9mbGV4X2NhcHMgYXRtZWxfZmxleGNvbV9j
YXBzID0ge307DQo+Pj4+Pj4gKw0KPj4+Pj4+ICtzdGF0aWMgY29uc3Qgc3RydWN0IGF0bWVsX2Zs
ZXhfY2FwcyBsYW45NjZ4X2ZsZXhjb21fY2FwcyA9IHsNCj4+Pj4+PiArICAgIC5oYXNfZmx4X2Nz
ID0gdHJ1ZSwNCj4+Pj4+PiArfTsNCj4+Pj4+PiArDQo+Pj4+Pj4gc3RhdGljIGNvbnN0IHN0cnVj
dCBvZl9kZXZpY2VfaWQgYXRtZWxfZmxleGNvbV9vZl9tYXRjaFtdID0gew0KPj4+Pj4+IC0gICAg
eyAuY29tcGF0aWJsZSA9ICJhdG1lbCxzYW1hNWQyLWZsZXhjb20iIH0sDQo+Pj4+Pj4gKyAgICB7
DQo+Pj4+Pj4gKyAgICAgICAgLmNvbXBhdGlibGUgPSAiYXRtZWwsc2FtYTVkMi1mbGV4Y29tIiwN
Cj4+Pj4+PiArICAgICAgICAuZGF0YSA9ICZhdG1lbF9mbGV4Y29tX2NhcHMsDQo+Pj4+Pj4gKyAg
ICB9LA0KPj4+Pj4+ICsNCj4+Pj4+PiArICAgIHsNCj4+Pj4+PiArICAgICAgICAuY29tcGF0aWJs
ZSA9ICJtaWNyb2NoaXAsbGFuOTY2eC1mbGV4Y29tIiwNCj4+Pj4+PiArICAgICAgICAuZGF0YSA9
ICZsYW45NjZ4X2ZsZXhjb21fY2FwcywNCj4+Pj4+PiArICAgIH0sDQo+Pj4+Pj4gKw0KPj4+Pj4+
ICAgeyAvKiBzZW50aW5lbCAqLyB9DQo+Pj4+Pj4gfTsNCj4+Pj4+PiBNT0RVTEVfREVWSUNFX1RB
QkxFKG9mLCBhdG1lbF9mbGV4Y29tX29mX21hdGNoKTsNCg0K
