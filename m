Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3534B5AD1FB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 14:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236673AbiIEMB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 08:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236488AbiIEMBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 08:01:19 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A017DF37;
        Mon,  5 Sep 2022 05:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662379278; x=1693915278;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=P3uulcqRomNSsylDOqx2+EhzC1q1khn51xOOw81mGjo=;
  b=ApWy17vNVkfSu2WKgz2cGD5hr1X2jn7Xg08EkqMzWv/64HFpQ8jE9Nwc
   oM9ptc7OhT2QuUJZB2GLjL+F3P/U0t5+IyOuVe70xc1n32EQ1KZIXHdRv
   /nBrSOHgosZSDUgcIqwRHeWtK/AW5s1EXWM0gzlw/1D/n76uh+m9Tbhc1
   cztBGJwc9mD7FjjiLIErn2wx28gvwtBkrIFaQXwk+87Tk5jBN3gu7ildz
   rgQpp2s9/4rT7WpaLgp4sbIIF5IZ7eN2t+ilh57l5Jd4/mrrEnlFUihcL
   aps8mzDOidpksEkaiLxVNditfGTt9ILVzEM7+GPklMGLQJkLZX4BEVBnE
   A==;
X-IronPort-AV: E=Sophos;i="5.93,291,1654585200"; 
   d="scan'208";a="172412324"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Sep 2022 05:01:17 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 5 Sep 2022 05:01:15 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Mon, 5 Sep 2022 05:01:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bYqK0FyDE/1E2UZs4jltWFlv9Qf4W2MRaXHSB2l/tDVNjyQ18R6SF/DgNVrmaBGF+dEVbV29MPCv9bMOsRwuiAfmQpsrcUP5nSvYPK0yzoTuYKGRQBWKnI9htVum3Vsg+gGOPIAaQfBmrbG6rc0qUZwVONbDoTd+KO+8vsRw9e9YRhEaqwtXcPdx/GJZ9lFCvggxPQ+EJrQSUvLfloqNXf7UuHWGYcoCEopwTFI4hyDcBJQ/ndCL2IApXMYqVLlPimACAzO1p6QkIgswsu8RmTmw+Pf527d4s25Ir/BRpU7HigMiMXjtf4XlsARURS3/Iz4lZcqTSgueQe2IuxP7Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P3uulcqRomNSsylDOqx2+EhzC1q1khn51xOOw81mGjo=;
 b=atAwIMbSz690tEpptw9MITCdmEP/OcNUOmn2EVFSe3qh6/OTDd5mGOQtNNl2M43awX3UdgM7Shj9bcZ4e5lWie4DaoX894k1QWsjrxh+c3+0Fuzpwx0YfAxGsTGbg2N0BDzRppW0l6Bax0kgnm4LuXRf9l9b9DJvReKh75njbLMWGrh8bVbCTtBnR8nOnJbLeE6ggUGJMnwJ5U6n3Oonpk2Ds1JQQdJiOkZLRHeOgbh+MVrHPOWzJSNPsyc6KozoRO4IQ4nWiEgwc0DosssAmwga3fgwv0wzkxVWyK5iimG/rcBlXpAzGsbooGK2kPRcHtNLpFRghRkRQ59qt3Nrcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3uulcqRomNSsylDOqx2+EhzC1q1khn51xOOw81mGjo=;
 b=I9WG0xRXL4Qs5K5y+5mYcq6uI/Pd0e2ttCgpF7UL5vs1O10iNEDDOXYg7ZbLCEZK3dtjz8jqcjFQErUV1x6/zw195QyZ44pvxQhlQfIavFZLHzsM5/9Rlf42FJsG/BH4Ktf6RawBb+6A8EJcPVE3B2JQPpNQEHrVOrobyNufxcA=
Received: from BN8PR11MB3668.namprd11.prod.outlook.com (2603:10b6:408:81::24)
 by CY4PR1101MB2245.namprd11.prod.outlook.com (2603:10b6:910:1f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.16; Mon, 5 Sep
 2022 12:01:13 +0000
Received: from BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::3198:2077:56c7:1780]) by BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::3198:2077:56c7:1780%4]) with mapi id 15.20.5588.014; Mon, 5 Sep 2022
 12:01:13 +0000
From:   <Kumaravel.Thiagarajan@microchip.com>
To:     <andy.shevchenko@gmail.com>
CC:     <ilpo.jarvinen@linux.intel.com>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>, <u.kleine-koenig@pengutronix.de>,
        <johan@kernel.org>, <wander@redhat.com>,
        <etremblay@distech-controls.com>, <macro@orcam.me.uk>,
        <geert+renesas@glider.be>, <jk@ozlabs.org>,
        <phil.edworthy@renesas.com>, <lukas@wunner.de>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>
Subject: RE: [PATCH v1 tty-next 1/2] 8250: microchip: pci1xxxx: Add driver for
 the quad-uart function in the multi-function endpoint of pci1xxxx device.
Thread-Topic: [PATCH v1 tty-next 1/2] 8250: microchip: pci1xxxx: Add driver
 for the quad-uart function in the multi-function endpoint of pci1xxxx device.
Thread-Index: AQHYvKpRU4W9kTjyqEqLC8EMyu3nVa3Ki2PAgAAMcgCAAWi3gIAAQC8AgASD55A=
Date:   Mon, 5 Sep 2022 12:01:12 +0000
Message-ID: <BN8PR11MB3668B996595A5D36B9F5619FE97F9@BN8PR11MB3668.namprd11.prod.outlook.com>
References: <20220830180054.1998296-1-kumaravel.thiagarajan@microchip.com>
 <20220830180054.1998296-2-kumaravel.thiagarajan@microchip.com>
 <CAHp75VfraADCTmZATWTSsYtC5uk5bc=WDVVm0jtUVO90xdFd9g@mail.gmail.com>
 <BN8PR11MB3668BAC07D493EE02AEAEB14E97B9@BN8PR11MB3668.namprd11.prod.outlook.com>
 <63f48d1-f716-5040-c8d1-486087bd1c5e@linux.intel.com>
 <BN8PR11MB3668FA6A2247710ED7DEF16EE97A9@BN8PR11MB3668.namprd11.prod.outlook.com>
 <CAHp75VfUq-JkfjD1YOj_+ST-eK=aW=8LoHOUW4zqpeA_QUZbyw@mail.gmail.com>
In-Reply-To: <CAHp75VfUq-JkfjD1YOj_+ST-eK=aW=8LoHOUW4zqpeA_QUZbyw@mail.gmail.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 881948ce-f508-46af-4c7d-08da8f36543e
x-ms-traffictypediagnostic: CY4PR1101MB2245:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Cef1R3N5xLBODOElbSBjoZWp+e7byYX65iiClzh7EjoEIdzw2w29ATSSdebn66f5M/oQidJ8dtm8udB8OqoeDB3itFsutREp9Z732avuIsEcQVHKkur2bR/1khBNXFzk5bfasXdktQK06SFQj0/c4Nqxm3dBGe2oDNdcxCJvvsp0YtWZuw5HNXjRnVfcYv5G9hiw/NGxYRF1ftbsQlj/YUJhvIysUDCYVltKlisrNpzU8RXk+uJfXBxUNZrylW5HXZeK4lnJHpC0iI0/n3lrsaXCncoJCTm/vemV9TrqW+GpIWKiBPj/7NzyzlIXNXxmsMSQ+ziJqinkml9Qg/zb3/2PRtvO/Z91zp5wzYwkL1luB5V4piLv7mtAQsNT9TANuKU9nwqeDPinjDYJgJzhr444BslsCPW3RcvXbpzYIDZ/0HWcQ2Awqt+9QZun7yPYhN1oQf5ZpeH45KpdW+Mb9o7TCDEg+r0m988ndKFR2UBicFSmkFsPOFetblzSde2KybrXQk6ff8Yx6Hjhuj0sReLyaeBv5ul4euU9IO8UQ3uv+TTLiJPXIAwPDoD9WZlREbV5J2jL9JMh4xDwcwLOCrQCYpEWw7Vq2uSV5vvYtnE1PiwpcJGHKEq44RJ2Rg9Mk8mJaeBT/70GrG1Q9h2HBD2NMpINOKyVWrpjcX2qYGm1UAasboWlBjsuInQH8hbw1H7uEC8KDpmc3cZvsqsgSzTAxOch0l4l/fQ0OWv1lcnwVZFTD6IROa/EOyZgZTklCZgNdcVgyRrxdB62ihwiRhhKXGZcoMVIaVEbUf9hhF5XZCSWBknwoG5GLMIPvJo54ejpPjscFDpHEYQ30ZxyBT15znk95tKiKleqs3AOa+Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR11MB3668.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(376002)(396003)(346002)(39860400002)(366004)(33656002)(2906002)(40140700001)(7696005)(6506007)(26005)(107886003)(9686003)(53546011)(66446008)(66946007)(4326008)(8676002)(66556008)(64756008)(66476007)(76116006)(7416002)(52536014)(8936002)(55016003)(5660300002)(86362001)(38100700002)(41300700001)(54906003)(6916009)(71200400001)(83380400001)(38070700005)(478600001)(316002)(66574015)(186003)(122000001)(32563001)(473944003)(414714003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aGdNdVpUV2NWTlg3bGxOdjFiR3JDVjBNWEY3NUFtdkhaWk5kUFRNR0gxWFpP?=
 =?utf-8?B?elR2QkNQd1NPcS9kMnVETDd1RldjeWVjazFISlFpK1FCVnU1NG5tZ0R1ZkVi?=
 =?utf-8?B?bUZOc1ordW9iN05VRUtiS3JrdlgrM0gwdzN2Vm1WN25sNE1wRGFGV0dMcGVn?=
 =?utf-8?B?NXBiRDNBUnRnWEtkdExmTHE2QndlZjNlbVhvUDZnampnNXREOGI3QmpGMGgw?=
 =?utf-8?B?OWFSajAvdG9DYmZQcHZabFNZZFZXT0ViL054T2hMRWRzS2JMUmhWeHdZdkFu?=
 =?utf-8?B?c1hma0JpTGFicWZ3emVPSUpISm83Nm1VRnFLSmlmSmFnOExhTzUrZUdoTDNV?=
 =?utf-8?B?V0lta3R3bTg3NzNrZkhoK2NvN3dZNldwcHpIcFJFeWpaeWFXRHFyNmdIdlVo?=
 =?utf-8?B?Z3JyL3diODh2MG1wenFQSTVodk54bjFRSGdpNDBDYk1wS3lPN3d2Wm8zbUpO?=
 =?utf-8?B?NGxOazY0aEIydjd6ckdkSndzR1lOL0Erc2hGSnBqeTNhNTMrUlNoN1g4NWRE?=
 =?utf-8?B?aUc3c2g0RTdBbzNHUTh4VXlxL2w2OWU5dXF2TjQwK3RpdWNvYlNITGl6ajl0?=
 =?utf-8?B?endPSThOTkdQZXc1N2YrT1g2K05wcWwyTFlkUWJWQnpESXMyN1JxN2Fia2xT?=
 =?utf-8?B?ZmZhTWZtZGNVb0MzSXNtalJyZ3ZyWEhXbVA0ZjUxUm5jekxlMGJ5REE4enp3?=
 =?utf-8?B?aXFnZEIxMUQyVUJuVFlCNTZ1cDJLQVo5QUlZdkZNL1NLTWc4MjJOVGdqTzF3?=
 =?utf-8?B?aGdXUVZjdDVhaU9qYUVwZnczV0ZCdFNLWGExQ1YzbWZzTGN1ZVVEVk4xY3Jq?=
 =?utf-8?B?UG1vS3ZlZDlDcFJXbDlDNzgrbllaNTFNRi96L1RudjcwdnlPdFhzc0UvVC9u?=
 =?utf-8?B?UnZUNE9ZNzJxNWtKYVYwSE9OWmVJdkcrUnQxVjM3UHhWWEc2b0RqRkZyNmIw?=
 =?utf-8?B?Rnlrb2czeHRqbU1SYitxanhwM1dDUjA2WGlyUUtsVytwUUlEWmlTTGFoMk5F?=
 =?utf-8?B?UDlNWlBqazRjN25mR3NleWhOcnU4ZnRXbnFUTmxMajNtakFIc3FubjdSRVB5?=
 =?utf-8?B?cWk4V0JBb015VXFWSGJMMzF4RmRHc2IrdEZkeisxZDFqUjNCNW9aWUx2dEEx?=
 =?utf-8?B?bHMrbU1pbEE5N05jTUM4NlRXRzczTU9USFFBK05IcCtDRlN6OWRadmlCVkI0?=
 =?utf-8?B?MURIY2xJN3k2R2QvcjhQeG5HdktZOWlJQ25kU2MydkwvWkFqWk5rV0Y2VHpK?=
 =?utf-8?B?TjMyN1gyenc4eEtJbmJFZHN3OUNkRzlnT1NxdWRyeHI0bTlVTE5EeTNKKzFO?=
 =?utf-8?B?TEVheVhsZGdtZmVEYW1TRUZCQnk2Sk9aYmNkTjFPWEFIdUkyZmRaYjFMalZo?=
 =?utf-8?B?QnVLaFBGaVJYYWIwWXN0NGR0QjNqc3ZYN2hjb2VmQ0d3U25veXpGR2JIay9L?=
 =?utf-8?B?d2NNZWl1bGMwNzRZbi9IL2dJR21xdXB0UXpZenVpNnNPdC9IYTlxUE9YY2h5?=
 =?utf-8?B?cjJkTXVHb01zTUc1T2thTmNqamJkWFpXbmUvVTFzck5rUzRYL1Q1VzArL1Nr?=
 =?utf-8?B?aWtBMVFSZy9kSm5XMUNySWNpOWs5bEFHQlJMTUh1NGlpQ1pKakRPZjRZVjFD?=
 =?utf-8?B?UFd0aEx2UlNDd0hRWmNWbDMzSFppTnVlUDIxczY3SER5VldBSUNtNy9OdDc2?=
 =?utf-8?B?eWV3R0RWNWgrZjBCQm55ZmhPWnVTMFZIWEZXTTRMNVcraDNjUTdkQkNQY09r?=
 =?utf-8?B?ck4wRmRkS0V5SkNlSzF1NG54dlRZK0NrWGhyK2ZoSk5ETitFR1QvVTlqUHpm?=
 =?utf-8?B?MHdRbjdMOEFpemNuZ2gyMHBMUWNmRDVjTGFYR1VUdGpoWk0zbngzSlZnTWE5?=
 =?utf-8?B?TDRuK1JGTXhBV2xUR0tVdU83RFJ3S3FFd3lLOG1PNFA3NTNKTzQrTUdoSTM4?=
 =?utf-8?B?OHlXL2xFeFFYWDdpejBiWVpEVTFTenRsTUF4VE5mZEtnTmE0elR6eVhOVmFM?=
 =?utf-8?B?ZFFvdXRmN0huSXcxZ1ZXL0RJcnlJSDROZ0dFMGpVRjgzcHdhYWpZTnIvWWYr?=
 =?utf-8?B?Si80Q29yUTlBcXJiZFhBNW5UeU1DcE9YaFVoUCtHMGhlcFJYdVFQejhIRlNS?=
 =?utf-8?B?V1NxL1JqYUdPZXBjeUV1QytOYXBjZkhaekhGcXpqNnZ2NVZvckNpaDFtWEJQ?=
 =?utf-8?Q?hgSQ0Cg4I54fQ7AJar50k4k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR11MB3668.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 881948ce-f508-46af-4c7d-08da8f36543e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2022 12:01:13.0096
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FT74BUOZ5a6kQYIKAxwfVns1MgjFeKgDRwXZ0F5VGsgvG3leTTVVnVxn4/w9IjXBtI+I5DvffFEdHt2fwAh0P4Ckk5GdT6sR4j/Gd2CwmgRLKMwP8/IQpTy9Jg17IXWS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2245
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbmR5IFNoZXZjaGVua28gPGFu
ZHkuc2hldmNoZW5rb0BnbWFpbC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgU2VwdGVtYmVyIDIsIDIw
MjIgODozMyBQTQ0KPiBUbzogS3VtYXJhdmVsIFRoaWFnYXJhamFuIC0gSTIxNDE3IDxLdW1hcmF2
ZWwuVGhpYWdhcmFqYW5AbWljcm9jaGlwLmNvbT4NCj4gQ2M6IElscG8gSsOkcnZpbmVuIDxpbHBv
LmphcnZpbmVuQGxpbnV4LmludGVsLmNvbT47IEdyZWcgS3JvYWgtSGFydG1hbg0KPiA8Z3JlZ2to
QGxpbnV4Zm91bmRhdGlvbi5vcmc+OyBKaXJpIFNsYWJ5IDxqaXJpc2xhYnlAa2VybmVsLm9yZz47
IFV3ZQ0KPiBLbGVpbmUtS8O2bmlnIDx1LmtsZWluZS1rb2VuaWdAcGVuZ3V0cm9uaXguZGU+OyBK
b2hhbiBIb3ZvbGQNCj4gPGpvaGFuQGtlcm5lbC5vcmc+OyBXYW5kZXIgTGFpcnNvbiBDb3N0YSA8
d2FuZGVyQHJlZGhhdC5jb20+OyBFcmljDQo+IFRyZW1ibGF5IDxldHJlbWJsYXlAZGlzdGVjaC1j
b250cm9scy5jb20+OyBNYWNpZWogVy4gUm96eWNraQ0KPiA8bWFjcm9Ab3JjYW0ubWUudWs+OyBH
ZWVydCBVeXR0ZXJob2V2ZW4gPGdlZXJ0K3JlbmVzYXNAZ2xpZGVyLmJlPjsNCj4gSmVyZW15IEtl
cnIgPGprQG96bGFicy5vcmc+OyBQaGlsIEVkd29ydGh5IDxwaGlsLmVkd29ydGh5QHJlbmVzYXMu
Y29tPjsNCj4gTHVrYXMgV3VubmVyIDxsdWthc0B3dW5uZXIuZGU+OyBMaW51eCBLZXJuZWwgTWFp
bGluZyBMaXN0IDxsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZz47IG9wZW4gbGlzdDpT
RVJJQUwgRFJJVkVSUyA8bGludXgtDQo+IHNlcmlhbEB2Z2VyLmtlcm5lbC5vcmc+OyBVTkdMaW51
eERyaXZlcg0KPiA8VU5HTGludXhEcml2ZXJAbWljcm9jaGlwLmNvbT4NCj4gU3ViamVjdDogUmU6
IFtQQVRDSCB2MSB0dHktbmV4dCAxLzJdIDgyNTA6IG1pY3JvY2hpcDogcGNpMXh4eHg6IEFkZCBk
cml2ZXIgZm9yDQo+IHRoZSBxdWFkLXVhcnQgZnVuY3Rpb24gaW4gdGhlIG11bHRpLWZ1bmN0aW9u
IGVuZHBvaW50IG9mIHBjaTF4eHh4IGRldmljZS4NCj4gIA0KPiBPbiBGcmksIFNlcCAyLCAyMDIy
IGF0IDI6NTcgUE0gPEt1bWFyYXZlbC5UaGlhZ2FyYWphbkBtaWNyb2NoaXAuY29tPg0KPiB3cm90
ZToNCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBJbHBvIErD
pHJ2aW5lbiA8aWxwby5qYXJ2aW5lbkBsaW51eC5pbnRlbC5jb20+DQo+ID4gPiBTZW50OiBUaHVy
c2RheSwgU2VwdGVtYmVyIDEsIDIwMjIgNzoxMiBQTSBPbiBUaHUsIDEgU2VwIDIwMjIsDQo+ID4g
PiBLdW1hcmF2ZWwuVGhpYWdhcmFqYW5AbWljcm9jaGlwLmNvbSB3cm90ZToNCj4gDQo+IC4uLg0K
PiANCj4gPiA+ID4gPiA+ICsgICAgICAgY29uc3QgdW5zaWduZWQgaW50IHN0YW5kYXJkX2JhdWRf
bGlzdFtdID0gezUwLCA3NSwNCj4gPiA+ID4gPiA+ICsgMTEwLCAxMzQsIDE1MCwNCj4gPiA+IDMw
MCwNCj4gPiA+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIDYwMCwgMTIwMCwgMTgwMCwgMjAwMCwgMjQwMCwgMzYwMCwNCj4gPiA+ID4gPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDQ4MDAsIDcyMDAs
IDk2MDAsIDE5MjAwLCAzODQwMCwgNTc2MDAsDQo+ID4gPiA+ID4gPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAxMTUyMDAsIDEyNTAwMCwgMTM2NDAwLCAx
NTAwMDAsIDE2NjcwMCwNCj4gPiA+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIDE4NzUwMCwgMjE0MzAwLCAyNTAwMDAsIDMwMDAwMCwgMzc1MDAw
LA0KPiA+ID4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgNTAwMDAwLA0KPiA+ID4gPiA+ID4gKyA3NTAwMDAsIDEwMDAwMDAsIDE1MDAwMDB9Ow0K
PiA+ID4gPiA+DQo+ID4gPiA+ID4gV2h5PyENCj4gPiA+ID4NCj4gPiA+ID4gVGhlIHN0YW5kYXJk
IGJhdWQgcmF0ZXMgYXJlIGhhbmRsZWQgd2l0aGluDQo+ID4gPiA+IHNlcmlhbDgyNTBfZG9fc2V0
X3Rlcm1pb3Mgd2hpY2ggaXMgaW52b2tlZCBmcm9tIHdpdGhpbg0KPiBtY2hwX3BjaTF4eHh4X3Nl
dF90ZXJtaW9zIGluIGZpcnN0IHBsYWNlLg0KPiA+ID4gPiBIZW5jZSBpZiBpdCBtYXRjaGVzIHdp
dGggYW55IG9mIHRoZSBzdGFuZGFyZCBiYXVkcmF0ZXMsIGl0IGNhbg0KPiA+ID4gPiByZXR1cm4g
aW1tZWRpYXRlbHkuDQo+ID4gPg0KPiA+ID4gQ2FyZSB0byBleHBsYWluIHdoeSB0aGUgYmF1ZHJh
dGVzIGluIHlvdXIgdGFibGUgZG9uJ3QgbWF0Y2ggdGhvc2UgaW4NCj4gPiA+IHR0eV9iYXVkcmF0
ZS5jPyAuLi5JdCBtYWtlcyBubyBzZW5zZSB0byBtZSB0aGF0IHlvdSBjYWxsIHRoZXNlDQo+ID4g
PiAic3RhbmRhcmQgYmF1ZCByYXRlcyIuDQo+ID4gVGhlIGJhdWRyYXRlcyBpbiBteSB0YWJsZSBh
cmUgZnJvbSBvdXIgbGVnYWN5IFVBUlQgSVAgYW5kIHRoZXNlDQo+ID4gYmF1ZHJhdGVzIGNhbiBi
ZSBnZW5lcmF0ZWQgYnkgdGhlIGhhcmR3YXJlIGJ5IHVwZGF0aW5nIFVBUlRfRExMICYNCj4gPiBV
QVJUX0RMTSBhbG9uZSBhcyBkb25lIGJ5IHRoZSBzZXJpYWw4MjUwX2RvX3NldF90ZXJtaW9zLg0K
PiA+IEkgbm90aWNlZCB0aGF0IHNvbWUgb2YgdGhlIGJhdWQgcmF0ZXMgaW4gdHR5X2JhdWRyYXRl
LmMgYXJlbm90IGxpc3RlZA0KPiA+IGluIHRoaXMgdGFibGUgYnV0IHdpbGwgc3RpbGwgYmUgaGFu
ZGxlZCBieSB0aGUgbWNocF9wY2kxeHh4eF9zZXRfdGVybWlvcy4NCj4gPiBJIGNhbiByZW5hbWUg
c3RhbmRhcmRfYmF1ZF9saXN0IHRvIHNpbXBseSBiYXVkX2xpc3QuIFBsZWFzZSBsZXQgbWUga25v
dy4NCj4gDQo+IE5vLCB0aGUgcG9pbnQgaXMgYXZvaWQgcmVwZWF0aW5nIHdoYXQgc3RhbmRhcmQg
QVBJcyBhbHJlYWR5IGRvLiBKdXN0IG1ha2UNCj4gc3VyZSB5b3UgY2FsbCBpdCBwcm9wZXJseSBh
bmQgcHJvdmlkZSBfZ2V0L19zZXRfZGl2aXNvcigpIGNhbGxiYWNrcy4gTm90ZSwgeW91cg0KPiBk
cml2ZXIgY2FuIGNvcGUgd2l0aCBCT1RIRVIgYW5kIHRoZXJlIGFsbCBub24tc3RhbmRhcmQgYmF1
ZCByYXRlcyBnby4NCkkgd2lsbCByZXZpZXcgbXkgZHJpdmVyIGFnYWluIGFuZCBnZXQgYmFjayB0
byB5b3UgaWYgcmVxdWlyZWQuDQoNClRoYW5rIFlvdS4NCg0KUmVnYXJkcywNCkt1bWFyYXZlbA0K
