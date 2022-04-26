Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2833A50FC6B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 14:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349753AbiDZMGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 08:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235227AbiDZMGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 08:06:50 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17713A776F
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 05:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1650974611; x=1682510611;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=uz3cwQUhXnm76J2rfeQLE9M3SjOdhxdDoWlbU8/jmNI=;
  b=kVKVxBuZIBzobt8ZzFQ4rbb/xBSx4wLF606UtZvAeE/qOZZlVrmjjHzP
   DFz4IGVJ0QY+cgsITtpYwIvqKq/t+kgV5Nk9deuQR9D4mVK3uvcxoruKL
   83FZGgwyT1czruob7PyQSW4iKw0a7BdL9WXtPJbq3BOlZ7TJvq/HBZAbw
   yJzdQqsHA8hBiGSlWmwILZ0+N90eezE1V5Sxl1U1lGMYJASNKk0ifFuY5
   sEZ+7eGEQPRUUs2f2vfQE6Xg8e3AWfUl0BLGd+YJWJbaNOy2+VhwGHBVH
   4JxcibjX2Q65TneS44rPfztThCz7wqt1wxLkxgyn5+37KIfbAUU3NMl5H
   A==;
X-IronPort-AV: E=Sophos;i="5.90,290,1643698800"; 
   d="scan'208";a="161341543"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Apr 2022 05:03:29 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 26 Apr 2022 05:03:28 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Tue, 26 Apr 2022 05:03:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JKfi70kgJoEusRfFqVFTZJXswJGsb/3ErP08mDhANYCgRqrIQUFcfjQsYvDJpeNzMZkCDNsTj9kZzTWM9CopJT/Ai7UpPlqdcZ4RXvZPvJt0mkJoJTnc2Je9AgcCOgE3KCuUL0ddh7CnmHj/5zoMQbhUEaH4olrqvQsDb1F1gEb+0IvBr/HxlE4C1vC3DhEsw8q7mXDoLAVcsDSF5hztbADXFq1r39OP74qpD9NrIGendKx0BBvXXPkC019q+5LwtpDSB3cwepsUeS9daQlcFuGPODTu3tyLM/mWJ00q+QLETz150NVtOLIrkn+rCA1TH4rdPW1zDbO3+lH/F+9mNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uz3cwQUhXnm76J2rfeQLE9M3SjOdhxdDoWlbU8/jmNI=;
 b=YKE80wgbkzB8He+73fPaA3yr2FCXyNnq7g3/gn1Ao3wD8mh69hdJEjZMjnIrHTuZElYAV2miwZX4ekJaZ9lfxKKQva1ubmHuw2kRUSO9gJvxPfzn1iVC3cq8ldBxL8EdG/KfqH8J/e0nIaKsg45Y7TWSz1cbIxjfddsBxrG7cTCYgE0i6f71GDuPx3tATXoj+tRo3l4CBWl4naawbgQ9SY5/L+Ob4qvgZdFWdVcqZyqhmPjFukbs+iA0QEYMAt725HcBsgrGgo4sHi1TbV2wo1sZW1sKUZxITkEs1c/dq8E7OMh7v88Cp8PPMaL4wv7DIuCQxgfhgnp/7oF7Cr2hJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uz3cwQUhXnm76J2rfeQLE9M3SjOdhxdDoWlbU8/jmNI=;
 b=TkkJkBUOZccZEJ1GNglFaWputeW0S5QzrLvr7eAazkvZoAD0j/lFWT3+3oB6Oi1ZP2M1DQuNMftrkXfLZo90iNc37fcDziaXzor9gYHw0Tbu1/4FnbR1qXYNaOVdiIxILFdGHbUbk8uDRxnNF4UDN4db6saqEv8FeMYtIah+h+0=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:95::7)
 by MN2PR11MB4647.namprd11.prod.outlook.com (2603:10b6:208:262::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Tue, 26 Apr
 2022 12:03:26 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::fcd4:8f8a:f0e9:8b18]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::fcd4:8f8a:f0e9:8b18%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 12:03:26 +0000
From:   <Conor.Dooley@microchip.com>
To:     <stefan.wahren@i2se.com>, <nsaenzju@redhat.com>,
        <cmirabil@redhat.com>, <miguel.ojeda.sandonis@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <serge@raspberrypi.org>,
        <mbrugger@suse.com>, <linux-rpi-kernel@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <fedora-rpi@googlegroups.com>, <dbauman@redhat.com>,
        <mguma@redhat.com>, <jsavitz@redhat.com>
Subject: Re: [PATCH v9 0/6] Raspberry Pi Sense HAT driver
Thread-Topic: [PATCH v9 0/6] Raspberry Pi Sense HAT driver
Thread-Index: AQHYWWWiIpBjc8I/WkmHxK3QsHObmQ==
Date:   Tue, 26 Apr 2022 12:03:26 +0000
Message-ID: <60c3e7e4-6406-ecaa-e89b-fc2d359d8d31@microchip.com>
References: <20220419205158.28088-1-cmirabil@redhat.com>
 <CANiq72n1gBE+tv3oAF4wjdK2jEJJmU4V=Y1CTZ1PpCEeqLbo9g@mail.gmail.com>
 <CABe3_aE-nQzZazLfxk1OnCNRF0sDqcWi6gieYSf4O4aYS_Ahog@mail.gmail.com>
 <06e0138a526f1fd9fe5b18184163c1ff98f0103b.camel@redhat.com>
 <4719fce9-4235-f1d7-f95e-67e5a47a0968@i2se.com>
In-Reply-To: <4719fce9-4235-f1d7-f95e-67e5a47a0968@i2se.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a729f82f-8123-449d-e5a2-08da277cc520
x-ms-traffictypediagnostic: MN2PR11MB4647:EE_
x-microsoft-antispam-prvs: <MN2PR11MB4647B66EA85DC014E64E6D6698FB9@MN2PR11MB4647.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PI6P96D11k8NtqzYjxcjtGHki4Xim7UTWG+NqBprZUbdGG2i2Hlw0b413atzho9QTTfDbkpeGHfFBbQJAFNMHsmGIuL2C+XL2G1MssydX9DG0bBzE4Xri0/iVVb7XQcr3WzDH72wBrIqhMPHS2xYDZZ689iotSf/NRrUeEv35DOmzRq6uwZuJMwS+fKdsqEENKD+q0UC9LDdZZ/NLwN14RRkz3HVuNSfsm2zEq9YFM8PU6RjEbHMGz+FPWITB1Ra8rC7UNAatb0tTO+9XXiHE3muEtcfIi0uSZLdJRisPEnkPhRRSxJMZbG+sPgnfLtb9rdPSqmlERZO2760BdX9HEObYOwN18usmEZcW6cqYLEUQdwWyFfy5KQ+heyckF8Z9rrd6xZSXjV/EataxvWOABCwuRfHymmtVI7rsKeX+CyBj7Clf+6/LFJinI3J+/9sQWgFuAyOW1pAl9gDZUozv40YBO/MyPl44txCpuglTWnKxnVsTSb0BaZzYME3hnueinYSHrjnWx4mX3Ev26Xwff0Jf51FPH9kE9pXjRRy8FwEw4ybmODKobO836LdsFRP59uCx0pxBnT8eThQDzld0yN6Yy1ZJ+SdomKROt2ceWfrQExcQW0OSH8fBAq2y6bIjTEQdLEeS5LRAjiieoSlv/q0pflEhljWDFNpUfLl3ZATfayJtOiF8rn142iAtflq1JCS6AhTgfA7cShILDDl8kfPBqySO5GYQneaK9MR8C17pskieTOEcdmR83PgZvmDziuTO17Je2N+FXwuL6Ud8CsfSxF0LHlm0PjJY5fpqZQJNBduFsJpdPFhOJVPFoGwCNrfbeMJ9mGO2LAEIKuZfa9myRn9n3VloE9FFP/RGQ0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(5660300002)(8936002)(7416002)(36756003)(83380400001)(26005)(8676002)(4326008)(66476007)(64756008)(31696002)(66446008)(53546011)(2906002)(186003)(31686004)(86362001)(508600001)(2616005)(38070700005)(38100700002)(966005)(6486002)(316002)(66556008)(76116006)(91956017)(66946007)(122000001)(6512007)(110136005)(71200400001)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RkRrMTQ4U0pvK0UwYlFqdkk0MjJMYlF6TUVzNUJwQXJQeEtuRlowZ0owR3dC?=
 =?utf-8?B?U2dYdG12Sy9mdjJFOCtzSUxPTVJBeWdSdklOV1dScU43ZDhLZTlGb3JoOVhr?=
 =?utf-8?B?TTBIdS9YalZsMnhyVzF4c2Z6NWRtMFplc1JkK3dTa0lnMXBuT0xabXAxN2xR?=
 =?utf-8?B?M0ZvaGh5bGs5ZWU0R3NIM1I5SW9URS9VLzV4ZVRaVUFDZGtReHRIMnJoVzZU?=
 =?utf-8?B?WWEwVmtDMG5rc25SQk1UTklDeTE3STBnK2kwMktmM1gva1VNSWRDMHZTNHdP?=
 =?utf-8?B?MHM0TGxWRjY0dFVYMU56KzR6c21hTk9LSkVlOUh1U0QyZTdIRS9FNGphdXdo?=
 =?utf-8?B?V3dLNk9QUlg5dVdscC9tWWJ6MkJsaWVIcjM4VmxRcmNEdEhMc2V5VzM5dUV5?=
 =?utf-8?B?TUd4dHBqZEpHVE9paDVhc3BmTTZkaGdETkVYUnI5MmtZME1QNjV2eDFvVk9i?=
 =?utf-8?B?R1JENVpEVzUzU0NMK2x2dGMxdEl3ZzZyNThKRzZXTlNiS0VVSEN4U3NIWFZk?=
 =?utf-8?B?dldBT0VIZU5panBXNjFuRHNBV2ZKazgzeXBHQU43RHdCUHBiblVGT0h2UWdv?=
 =?utf-8?B?bWlmb0xIdTZVTkg1WG5wOVN2S0R5OHpkVWg4WTl1ZzkzWXUxU040Q0drU2Fn?=
 =?utf-8?B?TlVZb1B6NzNsOU5zZXpGSlBYUDhadXpabmM3d053SFJCVy9TNVpoelFVWk1D?=
 =?utf-8?B?M2lVb0JQa0wxVHBpcU1MRE16dy9qRjhnNzlkNVBIWWZ2Y2hXUnB4K2crRlR0?=
 =?utf-8?B?VlNSUGUySVh2RGFoNXJWdXllOGxRYnBFbE9yUzd4TlljRFpVUnFJcTB6NEtl?=
 =?utf-8?B?U004dE9NdS9haDB0QlhZZXNiei9JUE1DOTFHZldZUFFXcjB2RjVxdDhaMExv?=
 =?utf-8?B?SnlBa2tXQW5KZ2VpUlR6dDFiSUlrT1JkUkdrN1RTc2gxa1E4aE8yVHQwOHBJ?=
 =?utf-8?B?K25Dbm94dkRyMnFIK3cyVGFSM2tnbkJVak9RaTRHVk1FVHRBMFZMMndBalU3?=
 =?utf-8?B?cUI3TUdaZDMvZ1k3T29wRThJdzBSbFROcDZQQllQVlA4OG8rZ0RXUEFiMW1v?=
 =?utf-8?B?V1hjNEkwOVIrN1J2WkhaMldmWnA3NmMyaWdSRCtqUnBiSDFlZjJabWJ4V3VP?=
 =?utf-8?B?WXorN1hnYldRVjQ1ejFmLzdIRFJDSE94L09Fa2tsMDE2Qk01QmJPWU9rYTQ1?=
 =?utf-8?B?SHFYbDRLazJpVDQ4UW5PaUdPRERYOFlrandXQXpLYUZlVHJzcEEwNXdGdUpI?=
 =?utf-8?B?eEVBdXNrejBNd0RUcUx2SS9tRCt0NFUvMnlKTmpLZnUzV2w3K1U4OCtSVmVa?=
 =?utf-8?B?UzVrSjU0V1AzdDNJaWlmaHlzZkZlUW5YY1lCV1dlbm92eHdvREFXalRNTkNJ?=
 =?utf-8?B?OHJiY2lrK3c2YVNlNnVQaGFyQ3lla0lnZmI5R3M3RllaZWcvWWZabEdPekQv?=
 =?utf-8?B?QURqbkVjQkRKam9yK1RMTndVWWhZbFAvalFJZDdpajVWRkJWT2ZxRzRsRUkw?=
 =?utf-8?B?UkVqQXZyT3VsTFA1ZXNJQktFZzR0SkdFcldoSEk2THNjWEtuc2s0aDJaTjJn?=
 =?utf-8?B?VndYWVlzUWM2QzRQQkFSZmFvaEUwVnUydjYrTlRWaUJlLzZ6UTY4czVkRDU2?=
 =?utf-8?B?eTYwVHEwaHpWMEFsTlhKUVlWMDVNWVBmbnpTT1lpNHNKR3FHeUFQRFBRY09J?=
 =?utf-8?B?amtHaTZzRlUyTHlpQXdEamZxQnNrUzZBZ2xqdlZqQ0xGTVNyUy9lcUEyRjB3?=
 =?utf-8?B?ZTdqRGFhVGg3dms2S25tWmNCWXd3ZFIrK2xlaXlaWTk1cjUwanVOSWZrZURo?=
 =?utf-8?B?cVhkMEdSS3lkUjBjYldjajhzVzY2TVlqd1J4UHArR0RBVW5Nay9pQnJ0dmV3?=
 =?utf-8?B?aXRsVUc1UDdKQlZGa09zK3hRTStJdDFxcStsTEd6dy9QUDJsWVhaMGxHb210?=
 =?utf-8?B?Sk1pejlPSk9XdXNnWlNWa2tlTjRUQ1QzRWJsemVXSDNMYlUrOTJtNTNZUUxk?=
 =?utf-8?B?dzVOM0xicXdJbGUxaU0wRkJjSEw4YnprWTllREJHRnErN3U4S2ExZFo2TDhv?=
 =?utf-8?B?U2hmejlpN2tDaE9OWlYyYkF2UkN1b28rVm5oZzlVY3J1TFZaeHgvZ2RoS3BF?=
 =?utf-8?B?UlM4NWFHK3pwNlJBNWQzdEZ4ZllhcGFhNWpsamlQcGRrQnhEZk1vMlRqWENn?=
 =?utf-8?B?bGZYSy9IZlRhNnhELzh1cHo1MHRuMC9mckk5cGZqVmo2NHpkb1U2NDYrV2Rv?=
 =?utf-8?B?dzJBQzhyNm5yT1NBQmxmU1FFRWR0clJLcmFiWFVxbFpDWFU1dFFZQkFCTXU5?=
 =?utf-8?B?ZkxhbXgzT3ZZcFdpM005cFVleVE1UkhtWml2eVg4UnowQXk1WHZ5QT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0778AE6564A033439BB8375CC49CCB8C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a729f82f-8123-449d-e5a2-08da277cc520
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 12:03:26.2417
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0NEELSlhWpL7wjol5pjcYX/c7DETg3VUV/kJMg/g1dNo6Rh14Qn+A5RnMTZ2cwiH/El/hLOtlHuBrUFrEjENYdqj+Mfdhu4viVePj5ErRLc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4647
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjYvMDQvMjAyMiAxMjo0OCwgU3RlZmFuIFdhaHJlbiB3cm90ZToNCj4gQW0gMjYuMDQuMjIg
dW0gMTI6MTggc2NocmllYiBOaWNvbGFzIFNhZW56IEp1bGllbm5lOg0KPj4gSGkgQ2hhcmxlcywg
TWlndWVsLA0KPj4NCj4+IE9uIE1vbiwgMjAyMi0wNC0yNSBhdCAxOTozNCAtMDQwMCwgQ2hhcmxl
cyBNaXJhYmlsZSB3cm90ZToNCj4+PiBIaSBNaWd1ZWzigJQNCj4+Pg0KPj4+IFRoYW5rcyBmb3Ig
eW91ciBoZWxwIGluIHJldmlld2luZyB0aGlzIHBhdGNoLiBJIHRoaW5rIGFsbCBvZiB0aGUgZmVl
ZGJhY2sgaXMgY2xlYXJlZCB1cC4NCj4+Pg0KPj4+IEkgYW0gbm90IHN1cmUgd2hpY2ggdHJlZSB0
aGlzIHNob3VsZCBnbyBpbnRvLCBidXQgbWF5YmUgdGhlIFJhc3BiZXJyeSBQaSB0cmVlIG1haW50
YWluZWQNCj4+PiBieSBOaWNvbGFzIFNhZW56IEp1bGllbm5lIChnaXQ6Ly9naXQua2VybmVsLm9y
Zy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvbnNhZW56L2xpbnV4LQ0KPj4+IHJwaS5naXQpPyBX
aGF0IGRvIHlvdSB0aGluaz8gVGhhbmtzIQ0KPj4gU2luY2UgdGhlcmUgaXMgbm8gY29kZSBkZXBl
bmRlbmN5IGJldHdlZW4gdGhlIGRpZmZlcmVudCBkcml2ZXJzL3BhdGNoZXMgSQ0KPj4gc3VnZ2Vz
dCBmb3IgZWFjaCBwYXRjaCB0byBnbyB0aHJvdWdoIGl0cyByZXNwZWN0aXZlIG1haW50YWluZXIg
dHJlZS4gQWxzbywgaWYNCj4+IHdlIHdlcmUgdG8gbW92ZSB0aGUgd2hvbGUgc2VyaWVzIHRocm91
Z2ggYXMgc2luZ2xlIHRyZWUsIGl0J3MgaW1wb3J0YW50IHRvIGhhdmUNCj4+IEFDS3MgZnJvbSBh
bGwgdGhlIHN1YnN5c3RlbSBtYWludGFpbmVycy4NCj4gWWVzLCB3ZSBzdGlsbCBuZWVkIGEgQWNr
IG9mIFJvYiBmb3IgdGhlIGRldmljZSB0cmVlIGJpbmRpbmdzLiBQbGVhc2UgZ2l2ZSBoaW0gdGhl
IGNvbW1vbiAyIHdlZWtzIGZvciBhIHJldmlldy4NCg0KWW91IGhhdmUgb25lIGZyb20gS3J6eXN6
dG9mIG9uIHRoZSBiaW5kaW5ncywgdGhhdCBzaG91bGQgYmUgc3VmZmljaWVudD8NCg0KaHR0cHM6
Ly9kb2NzLmtlcm5lbC5vcmcvcHJvY2Vzcy9tYWludGFpbmVycy5odG1sI29wZW4tZmlybXdhcmUt
YW5kLWZsYXR0ZW5lZC1kZXZpY2UtdHJlZS1iaW5kaW5ncw0KDQo+Pg0KPj4gSSdsbCBkbyBhIGxh
c3QgcmV2aWV3IGR1cmluZyB0aGUgd2Vlay4NCj4+DQo+PiBSZWdhcmRzLA0KPj4NCg==
