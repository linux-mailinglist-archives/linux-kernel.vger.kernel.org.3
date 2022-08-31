Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF965A7A80
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 11:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbiHaJqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 05:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiHaJqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 05:46:32 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F4621277;
        Wed, 31 Aug 2022 02:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661939190; x=1693475190;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=oRfpKi1TU6HrxTlA0Fdh4Pg2Ow7Td8cEjv7+7zPo01w=;
  b=O8g+FZtr4J9VQoGJ/peqOb557PSxgDNrwPjHpQ/zrLcez6hAFJuu954O
   zrADB94ro60ifZS+T5YkMBjBClKVQ4p9lGHNnm0vZnSAwr/eKcjPeNLKe
   TH5+02BXt7GnkgdzrBC/1tpeRY13BEBU9a1mOafDROQ/4cpdbPIO70l/g
   JlJjPvxjFfUhHlxt4K+OdLFWppcqMeW+U0zQVuC8CTGiQJUl++vBMEwB6
   ClJb/2CK4vOMaXEzyalV5t/w+XWOcsMkLBR84Jymoq84LL5GZaXaakZ8F
   qf2hYTmwQQuc0/kkAtY1YwK+25mlxi2TFhsfXsu1an5AhzbfjMJKATYWH
   w==;
X-IronPort-AV: E=Sophos;i="5.93,277,1654585200"; 
   d="scan'208";a="188794214"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Aug 2022 02:46:28 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 31 Aug 2022 02:46:26 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Wed, 31 Aug 2022 02:46:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hgelW2IG/ufRap4y9V/X2d49vm12uxgi4HMPwGyPueGUQeCZG/SjduBPUiUV0aewO6m6C/lyn2hlfVyb7fxZU8F90nt1QpwV4qojPQxD7zKRxgG67vipwmFwmvWt4V22COIeKD8RmHFR4/zNwmF0VvurESC3aYUF6187tH130bnTQi5A1IlXS2xYW+Gfr8MjUq3p9hHM7yEbey89xVH8z4TOhwOajyXiQlQw+j1oWYDeN2Lo8leKnMDK5XxPu1jsoXVgIYn4Cjswe1DZnvMRKqupC3WQeicCO/8WGngWDF9WVcQ8RenYjlbtUAmAdvRFaoOB6Td6R5uleAKIGfaF4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oRfpKi1TU6HrxTlA0Fdh4Pg2Ow7Td8cEjv7+7zPo01w=;
 b=gxiAhprZMJB9NMhJclm6smUY2mV19cSDE1n5d09qkasYBul/cWOKZo3r2y7xtxqLl3yUQNkCVoSp4cesJF7hWh89A5wYoUidBCVejNqQTsXPt3Ws+Vk76X4rntu/ixqfFFkyEdxiSNtXJdbn/9pGLW+WrB5gpobnbXOMhPeCqj+zLRvhwCLRDYTGZGfjWr9bgdsGiudvGv0wP/F12eDrodac7oLdmIqixna+9of9uCh6I4HCrH5UxlOkyBtHHnCeY798EX2rMhEaQS8KSKeoFL2yHnrAHUQWjDVG3+LlCiqWTYtqh9u557qhQE7umhpsTH8xyOdDFxnWFiIZOfp2Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oRfpKi1TU6HrxTlA0Fdh4Pg2Ow7Td8cEjv7+7zPo01w=;
 b=j8Cr3gAkP5X+y0FP9kmnG5T5/bqh7AgYu/7Fs9vuqufSt/bEiZCI/UsX31/a3rSI+4JEN4+L5BOLsP6QlYSo2wm/lBPBnAID+nWZjJlddyw1N8jiiWc2FPlDOwj8Wuq1ofxPrJmI1zgITe0RdCeSKFFdDTOFsWbmPbYIBewq1VU=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by PH0PR11MB5064.namprd11.prod.outlook.com (2603:10b6:510:3b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 31 Aug
 2022 09:46:21 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::a159:97ec:24bc:6610]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::a159:97ec:24bc:6610%10]) with mapi id 15.20.5566.021; Wed, 31 Aug
 2022 09:46:21 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Sergiu.Moga@microchip.com>, <lee@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <radu_nicolae.pirea@upb.ro>, <richard.genoud@gmail.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <admin@hifiphile.com>, <Kavyasree.Kotagiri@microchip.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-serial@vger.kernel.org>
Subject: Re: [PATCH 5/5] tty: serial: atmel: Make the driver aware of the
 existence of GCLK
Thread-Topic: [PATCH 5/5] tty: serial: atmel: Make the driver aware of the
 existence of GCLK
Thread-Index: AQHYvR6Ei2ZQH++jXUSygHOJRrCWrA==
Date:   Wed, 31 Aug 2022 09:46:21 +0000
Message-ID: <b29233a6-88f8-42cd-806f-6b3e82cb0b27@microchip.com>
References: <20220817075517.49575-1-sergiu.moga@microchip.com>
 <20220817075517.49575-6-sergiu.moga@microchip.com>
In-Reply-To: <20220817075517.49575-6-sergiu.moga@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ea146a3a-ec91-42a2-7367-08da8b35a933
x-ms-traffictypediagnostic: PH0PR11MB5064:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fp/golRQShV4WfcjFXBQnoye7jsp3Oz94hmt6iPrZj6bVZKgYEXUZItU0kpHFa+ddjm2m2s2AbF2qeV9rZoKC1Lf3iXSwE8LB1shvVQRcxi+K5WH42m9MCcbEvGuKl3XAN7qmUG7wt6Madigq7KXEhEixvixY4UiQUUZXpBzPo5u6GSF7o/NCEI+M3CZ6KA9FXbYmYvZNd503lM1CqtHe2SGSD6O7s7dXqwBFrwA05/VvGfEreogA5IzA5rx44hkGhRo8yWKRjyqYdJb7uY0tE32bH7L8kNPCCw5A2NF9+XuyJ/Y4R7/+C3aj0oZyjkNtlF+tKXSJbr/44aQIGkKd3zS6Btvs4qZtp3joMf3DBUbuEGYnXw+eg/EoJbutaFKQm0jor9yz7tO/Z2iVIiPQsyMRcF6R+UcvQhUMamLFGTMCogVZCipExT+Yne3HLUYzXywVGUKHW20UxIAWkRfLRyoQ4u9IGRvmfWmhEliL3soQcMD/D4Pux/kf6gIqE2Ombo5zfnmmFca2AHIa5ynlC+dvAIT69WoZuPUuR0xurVYq21wZGWA75lCKsWljBi+WWH1DBr+qF0pdVR6DYFzt8PhYAPn6bVeQIbk097/FrnvyMBIP94kJn6lp3AAtGIwf4vHUoxsQUXIPr9kz1ts+PNKlJfTs8cxCV0tSGY6m2URjlZ1V+Jm/S17n5Qut+XdsG486TOh4p6mxESymT9i1tYIc1b6J+Y6Ttrvzvm2aNpUvt0d1ItMymbSPAdtpSRMrT0rhsKJb5uWDxHqiS9xmJqQd+QyMI8CHI08FfoiRCs+RHMuiyGWpc6Rgw5vRjQUt0M5lV/wqyrb8tmR8lv1v0LMv50e/0QsGSvBbj5ThdI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(39860400002)(136003)(376002)(366004)(346002)(31686004)(8676002)(64756008)(110136005)(66476007)(6636002)(66446008)(4326008)(54906003)(91956017)(36756003)(66556008)(316002)(2906002)(2616005)(7416002)(5660300002)(8936002)(76116006)(66946007)(478600001)(71200400001)(6486002)(41300700001)(6506007)(6512007)(53546011)(86362001)(26005)(31696002)(186003)(38070700005)(83380400001)(122000001)(38100700002)(921005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WEcwWmc4MVhiMzQvaldqUTJVUXdtVVNXb2FlZUxYSWNSaklWN0hXeFFPR2JI?=
 =?utf-8?B?NHY5UHRBclVCaHFRZGVubUVZbzg3NUhBa1VrZjBZM2owR1hYZDdqVmlnTVpI?=
 =?utf-8?B?NGZ5cUlpRTNHdUdJR1daMFM3OFJMdWRpVFZvdWZzc0krWGh3b1RENlJGM2ZR?=
 =?utf-8?B?SXUyNks0NVZ5QWwzQWJKT1l4cmtxRjZWUURjdzBoaGhqdzJZYUc1amZwMmNP?=
 =?utf-8?B?cTVzUG03blo1eXVOMWZ3V2tSVkxhMkRVNmtldDlqQlZPYXVYbVN5WVF2dFla?=
 =?utf-8?B?M1F2UUc2K1did1BSV3NvMEY3dFMzWHBPV2laNDRjSEQ4cDV1VUNZUzZvMnlP?=
 =?utf-8?B?MjE0T1E3OU5acVZxeExjbGpnQUNVZjFZNGJzOWx4RkRPWjlZZzZzUzlHR1NW?=
 =?utf-8?B?bE5aN3lvT04vYVhIcnF1elkvYlJTZXFoWFBRSURibnR4RU5sRi9CN1RMTVd2?=
 =?utf-8?B?Nlc5bDJveDBjK0FIWTBibkVoSnhJOUhJVnJKS29VUmV6eXlqWnRla1RWNy80?=
 =?utf-8?B?UVBrSzhLT2YxbFZrd0R2SXk4R3kxbGNtSHArSktIUCtwcm9yajFiYW9xclZE?=
 =?utf-8?B?ekhHdmQ0eExJelEwQjZaazdBcFVwYmtqM04zZlI1UG1iUTdaYjIzNkltcFE2?=
 =?utf-8?B?S0MwUCttZFFaYi92MGlRRGczdnBQbHVwTTRKWGlpNXcyTWpEaHN5aUFDbnZn?=
 =?utf-8?B?K2krZVFCWGt0Yi9vUGkveHNEQ294VzQwVnlxSlhjTHlDOFBDNkRyWFE2bStQ?=
 =?utf-8?B?SWMxTXF1OHF4RGZjMFV2K2swL2s3QlhaeFRFbTNpRUxkVkd3bFRsMmh6UndQ?=
 =?utf-8?B?YnIwdEg3QUE5YmYwNnZHR1dRdk5GbVp6aGR2ZG5jZ2hyY21nOVYxL2J0eUZz?=
 =?utf-8?B?bS9uUzU2dVVtd1dsNHdnWTg5a1dqc3lBRGZCVG9WS21LMXFsNDdWWElnRnph?=
 =?utf-8?B?cGYvNUJXaU4reFNYY1puTlZsaFVOU1dVWFd3YTAvVTMwVkFOQlh5eWFwVEg1?=
 =?utf-8?B?MXlSeDgzYmVQVnJGNERyK1dwRzAzdG9NZTVIbWRNWUo3WVZYVy9ON0dlVmVm?=
 =?utf-8?B?Vkg3MjJmWFdaOTIxMG10YVpobnZmSzdnSmwxV2c3OGdQU3JQVHdOU01NNERG?=
 =?utf-8?B?U3lYVnJkZGVwaFlxRlhUVTB4UjNoQm1pNlNIV2ZHci9JT0dZZHRaOUlHVDh2?=
 =?utf-8?B?YVl4NTdhSzBpM1FYd2NncFZuUThqUStaL0x5Zm95cnZHOFkxcFZKdUxXVkJp?=
 =?utf-8?B?SVRSR3NIM1E3MEhncWM1NTk5dEIxZjB6THZST1NSMGx0SkkzL1k3bFRxT1No?=
 =?utf-8?B?bjU3NWNCOW1zSFc3T0JOZDZaNnVwZXI3Q0xMZzdUSnZXK3B1ZkZWWTdrenRv?=
 =?utf-8?B?TUg4M0gyWWthcXBuZHU1czBGazd5emU0b0wyOWxqZGptSHlIRkkrVm5SNDA0?=
 =?utf-8?B?V2FlTHVrUmU0K1NhZHlnL2ZwVzh5SHdSRlNmUHY5YVBib3YrMnNxamMrQjVR?=
 =?utf-8?B?ak9VSTQ4ZG5tYlRzYktZcVN5bHhlRnRnS2ZtbSswS0dlbnFjb0ZjaFJJOUwz?=
 =?utf-8?B?ZDBZWWZlT25hTWVQY2QxcndLd0lSTklUNWV1TzBmMTlkdFNVOHhRcnZpZXE0?=
 =?utf-8?B?NnZGbmFRSmJoSTlCKzhjK1VUcmxYbllCcytrenY5K3J6S1pHM0RSaFNxckps?=
 =?utf-8?B?ejFSUlRkRS8waU9MZElXemJ6WFZGRzhiQ0c1VHpoYk9xS2VEQXg5N0VOcXdM?=
 =?utf-8?B?bGVCcXFaTXJWVndFVGs1Vm5DVUtkT1Izc1M5RjQ3V3dsUnE1NUFISWhJSnJM?=
 =?utf-8?B?NWkwSEUvdGZJbnRiOUdqeWJSaWZIQUJjQVNVaHk5czAwaVNsTW5vL1N1ZnJu?=
 =?utf-8?B?VUhUVHpIN1Fkd01aSzNrSWh4THVaU1N3ZGJkTFVtdVQwclFTR0o3SmVxeXo5?=
 =?utf-8?B?YXYyaldSL25DSmZzTm0vdnczNkVXSkVXaitTRzVhN2Y3czdHVXJUL2pwaG5V?=
 =?utf-8?B?YTExaExrdE9YL3J6YzIxeDNyUkF1V05mZElVMFFRNzY1Y0d3Ri9Kb2JmMFBy?=
 =?utf-8?B?bWNpYmY2M2VLZUxSNGpwbVRhZmVTcFB0bnp4T3RENFcrNGZkVFNLY25mejJY?=
 =?utf-8?B?WlNmeUJ2NktaYlJETFFTd2p0TmZzblREQ2VhTVQ1V0FaSW9UaXpnM0QzcjVv?=
 =?utf-8?B?VVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4D8F58AD8F3D464183FCE5938625E601@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea146a3a-ec91-42a2-7367-08da8b35a933
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2022 09:46:21.4439
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RaA5hWElrRBI0sfhN2FHgkQ+emm3gbzth0E0I0BpLevIK1CfU23VqZfnwPEeZ9ZubxuN/w5vsSeTj2M+JSYsCg/lT+Bpj1NHrDGfTP/eiys=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5064
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTcuMDguMjAyMiAxMDo1NSwgU2VyZ2l1IE1vZ2Egd3JvdGU6DQo+IFByZXZpb3VzbHksIHRo
ZSBhdG1lbCBzZXJpYWwgZHJpdmVyIGRpZCBub3QgdGFrZSBpbnRvIGFjY291bnQgdGhlDQo+IHBv
c3NpYmlsaXR5IG9mIHVzaW5nIHRoZSBtb3JlIGN1c3RvbWl6YWJsZSBnZW5lcmljIGNsb2NrIGFz
IGl0cw0KPiBiYXVkcmF0ZSBnZW5lcmF0b3IuIFVubGVzcyB0aGVyZSBpcyBhIEZyYWN0aW9uYWwg
UGFydCBhdmFpbGFibGUgdG8NCj4gaW5jcmVhc2UgYWNjdXJhY3ksIHRoZXJlIGlzIGEgaGlnaCBj
aGFuY2UgdGhhdCB3ZSBtYXkgYmUgYWJsZSB0bw0KPiBnZW5lcmF0ZSBhIGJhdWRyYXRlIGNsb3Nl
ciB0byB0aGUgZGVzaXJlZCBvbmUgYnkgdXNpbmcgdGhlIEdDTEsgYXMgdGhlDQo+IGNsb2NrIHNv
dXJjZS4gTm93LCBkZXBlbmRpbmcgb24gdGhlIGVycm9yIHJhdGUgYmV0d2Vlbg0KPiB0aGUgZGVz
aXJlZCBiYXVkcmF0ZSBhbmQgdGhlIGFjdHVhbCBiYXVkcmF0ZSwgdGhlIHNlcmlhbCBkcml2ZXIg
d2lsbA0KPiBmYWxsYmFjayBvbiB0aGUgZ2VuZXJpYyBjbG9jay4gVGhlIGdlbmVyaWMgY2xvY2sg
bXVzdCBiZSBwcm92aWRlZA0KPiBpbiB0aGUgRFQgbm9kZSBvZiB0aGUgc2VyaWFsIHRoYXQgbWF5
IG5lZWQgYSBtb3JlIGZsZXhpYmxlIGNsb2NrIHNvdXJjZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IFNlcmdpdSBNb2dhIDxzZXJnaXUubW9nYUBtaWNyb2NoaXAuY29tPg0KPiAtLS0NCj4gIGRyaXZl
cnMvdHR5L3NlcmlhbC9hdG1lbF9zZXJpYWwuYyB8IDUyICsrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKy0NCj4gIGRyaXZlcnMvdHR5L3NlcmlhbC9hdG1lbF9zZXJpYWwuaCB8ICAxICsNCj4g
IDIgZmlsZXMgY2hhbmdlZCwgNTIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdHR5L3NlcmlhbC9hdG1lbF9zZXJpYWwuYyBiL2RyaXZlcnMv
dHR5L3NlcmlhbC9hdG1lbF9zZXJpYWwuYw0KPiBpbmRleCAzMGJhOWVlZjdiMzkuLjBhMGI0NmVl
MDk1NSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy90dHkvc2VyaWFsL2F0bWVsX3NlcmlhbC5jDQo+
ICsrKyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9hdG1lbF9zZXJpYWwuYw0KPiBAQCAtMTUsNiArMTUs
NyBAQA0KPiAgI2luY2x1ZGUgPGxpbnV4L2luaXQuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9zZXJp
YWwuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9jbGsuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9jbGst
cHJvdmlkZXIuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9jb25zb2xlLmg+DQo+ICAjaW5jbHVkZSA8
bGludXgvc3lzcnEuaD4NCj4gICNpbmNsdWRlIDxsaW51eC90dHlfZmxpcC5oPg0KPiBAQCAtNzcs
NiArNzgsOCBAQCBzdGF0aWMgdm9pZCBhdG1lbF9zdG9wX3J4KHN0cnVjdCB1YXJ0X3BvcnQgKnBv
cnQpOw0KPiAgI2VuZGlmDQo+ICANCj4gICNkZWZpbmUgQVRNRUxfSVNSX1BBU1NfTElNSVQJMjU2
DQo+ICsjZGVmaW5lIEVSUk9SX1JBVEUoZGVzaXJlZF92YWx1ZSwgYWN0dWFsX3ZhbHVlKSBcDQo+
ICsJKChpbnQpKDEwMCAtICgoZGVzaXJlZF92YWx1ZSkgKiAxMDApIC8gKGFjdHVhbF92YWx1ZSkp
KQ0KPiAgDQo+ICBzdHJ1Y3QgYXRtZWxfZG1hX2J1ZmZlciB7DQo+ICAJdW5zaWduZWQgY2hhcgkq
YnVmOw0KPiBAQCAtMTEwLDYgKzExMyw3IEBAIHN0cnVjdCBhdG1lbF91YXJ0X2NoYXIgew0KPiAg
c3RydWN0IGF0bWVsX3VhcnRfcG9ydCB7DQo+ICAJc3RydWN0IHVhcnRfcG9ydAl1YXJ0OwkJLyog
dWFydCAqLw0KPiAgCXN0cnVjdCBjbGsJCSpjbGs7CQkvKiB1YXJ0IGNsb2NrICovDQo+ICsJc3Ry
dWN0IGNsawkJKmdjbGs7CQkvKiB1YXJ0IGdlbmVyaWMgY2xvY2sgKi8NCj4gIAlpbnQJCQltYXlf
d2FrZXVwOwkvKiBjYWNoZWQgdmFsdWUgb2YgZGV2aWNlX21heV93YWtldXAgZm9yIHRpbWVzIHdl
IG5lZWQgdG8gZGlzYWJsZSBpdCAqLw0KPiAgCXUzMgkJCWJhY2t1cF9pbXI7CS8qIElNUiBzYXZl
ZCBkdXJpbmcgc3VzcGVuZCAqLw0KPiAgCWludAkJCWJyZWFrX2FjdGl2ZTsJLyogYnJlYWsgYmVp
bmcgcmVjZWl2ZWQgKi8NCj4gQEAgLTIxMTUsNiArMjExOSw4IEBAIHN0YXRpYyB2b2lkIGF0bWVs
X3NlcmlhbF9wbShzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0LCB1bnNpZ25lZCBpbnQgc3RhdGUsDQo+
ICAJCSAqIFRoaXMgaXMgY2FsbGVkIG9uIHVhcnRfY2xvc2UoKSBvciBhIHN1c3BlbmQgZXZlbnQu
DQo+ICAJCSAqLw0KPiAgCQljbGtfZGlzYWJsZV91bnByZXBhcmUoYXRtZWxfcG9ydC0+Y2xrKTsN
Cj4gKwkJaWYgKGF0bWVsX3BvcnQtPmdjbGsgJiYgX19jbGtfaXNfZW5hYmxlZChhdG1lbF9wb3J0
LT5nY2xrKSkNCg0KTm8gbmVlZCB0byBjaGVjayBmb3IgYXRtZWxfcG9ydC0+Z2NsayAhPSBOVUxM
LiBjbGsgQVBJcyBhcmUgYWxyZWFkeSBkb2luZyB0aGlzLg0KDQo+ICsJCQljbGtfZGlzYWJsZV91
bnByZXBhcmUoYXRtZWxfcG9ydC0+Z2Nsayk7DQo+ICAJCWJyZWFrOw0KPiAgCWRlZmF1bHQ6DQo+
ICAJCWRldl9lcnIocG9ydC0+ZGV2LCAiYXRtZWxfc2VyaWFsOiB1bmtub3duIHBtICVkXG4iLCBz
dGF0ZSk7DQo+IEBAIC0yMTI5LDcgKzIxMzUsOCBAQCBzdGF0aWMgdm9pZCBhdG1lbF9zZXRfdGVy
bWlvcyhzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0LCBzdHJ1Y3Qga3Rlcm1pb3MgKnRlcm1pb3MsDQo+
ICB7DQo+ICAJc3RydWN0IGF0bWVsX3VhcnRfcG9ydCAqYXRtZWxfcG9ydCA9IHRvX2F0bWVsX3Vh
cnRfcG9ydChwb3J0KTsNCj4gIAl1bnNpZ25lZCBsb25nIGZsYWdzOw0KPiAtCXVuc2lnbmVkIGlu
dCBvbGRfbW9kZSwgbW9kZSwgaW1yLCBxdW90LCBiYXVkLCBkaXYsIGNkLCBmcCA9IDA7DQo+ICsJ
dW5zaWduZWQgaW50IG9sZF9tb2RlLCBtb2RlLCBpbXIsIHF1b3QsIGRpdiwgY2QsIGZwID0gMDsN
Cj4gKwl1bnNpZ25lZCBpbnQgYmF1ZCwgYWN0dWFsX2JhdWQsIGdjbGtfcmF0ZTsNCj4gIA0KPiAg
CS8qIHNhdmUgdGhlIGN1cnJlbnQgbW9kZSByZWdpc3RlciAqLw0KPiAgCW1vZGUgPSBvbGRfbW9k
ZSA9IGF0bWVsX3VhcnRfcmVhZGwocG9ydCwgQVRNRUxfVVNfTVIpOw0KPiBAQCAtMjI4OCw2ICsy
Mjk1LDM3IEBAIHN0YXRpYyB2b2lkIGF0bWVsX3NldF90ZXJtaW9zKHN0cnVjdCB1YXJ0X3BvcnQg
KnBvcnQsIHN0cnVjdCBrdGVybWlvcyAqdGVybWlvcywNCj4gIAkJY2QgLz0gODsNCj4gIAkJbW9k
ZSB8PSBBVE1FTF9VU19VU0NMS1NfTUNLX0RJVjg7DQo+ICAJfQ0KPiArDQo+ICsJLyoNCj4gKwkg
KiBJZiB0aGVyZSBpcyBubyBGcmFjdGlvbmFsIFBhcnQsIHRoZXJlIGlzIGEgaGlnaCBjaGFuY2Ug
dGhhdA0KPiArCSAqIHdlIG1heSBiZSBhYmxlIHRvIGdlbmVyYXRlIGEgYmF1ZHJhdGUgY2xvc2Vy
IHRvIHRoZSBkZXNpcmVkIG9uZQ0KPiArCSAqIGlmIHdlIHVzZSB0aGUgR0NMSyBhcyB0aGUgY2xv
Y2sgc291cmNlIGRyaXZpbmcgdGhlIGJhdWRyYXRlDQo+ICsJICogZ2VuZXJhdG9yLg0KPiArCSAq
Lw0KPiArCWlmICghZnAgJiYgYXRtZWxfcG9ydC0+Z2Nsaykgew0KPiArCQlpZiAoX19jbGtfaXNf
ZW5hYmxlZChhdG1lbF9wb3J0LT5nY2xrKSkNCj4gKwkJCWNsa19kaXNhYmxlX3VucHJlcGFyZShh
dG1lbF9wb3J0LT5nY2xrKTsNCg0KWW91IGRpc2FibGVkIGl0IGhlcmUsIHNldCBuZXcgcmF0ZSBi
dXQgcmUtZW5hYmxlIGl0IGNvbmRpdGlvbmFsbHkgYWJvdmUsIGlzDQp0aGlzIGludGVuZGVkPyB0
aGUgYmVsb3cgY29uZGl0aW9uIG1heSBmYWlsLg0KDQo+ICsJCWNsa19zZXRfcmF0ZShhdG1lbF9w
b3J0LT5nY2xrLCAxNiAqIGJhdWQpOw0KPiArCQlnY2xrX3JhdGUgPSBjbGtfZ2V0X3JhdGUoYXRt
ZWxfcG9ydC0+Z2Nsayk7DQoNCllvdSBzaG91bGQgYmUgYWJsZSB0byB1c2UgY2xrX3JvdW5kX3Jh
dGUoKSBoZXJlOg0KCQlnY2xrX3JhdGUgPSBjbGtfcm91bmRfcmF0ZShhdG1lbF9wb3J0LT5nY2xr
LA0KCQkJCQkgICAxNiAqIGJhdWRyYXRlKTsNCg0KV2l0aCB0aGlzIHlvdSBjYW4gcmUtd3JpdGUg
YWxsIHRoaXMgYmxvY2sgc29tZXRoaW5nIGxpa2U6DQoNCgkJZ2Nsa19yYXRlID0gY2xrX3JvdW5k
X3JhdGUoYXRtZWxfcG9ydC0+Z2NsaywNCgkJCQkJICAgMTYgKiBiYXVkcmF0ZSk7DQoJCWFjdHVh
bF9iYXVkID0gZ2Nsa19yYXRlIC8gKDE2ICogY2QpOw0KCQlpZiAoYWJzKEVSUk9SX1JBVEUoYmF1
ZCwgYWN0dWFsX2JhdWQpKSA+DQoJCSAgICBhYmQoRVJST1JfUkFURShiYXVkLCBnY2xrX3JhdGUg
LyAxNikpKSB7DQoJCQltb2RlIHw9IEFUTUVMX1VTX0dDTEs7DQoJCQljZCA9IDE7DQoJCQlpZiAo
X19jbGtfaXNfZW5hYmxlZChhdG1lbF9wb3J0LT5nY2xrKSkNCgkJCQljbGtfZGlzYWJsZV91bnBy
ZXBhcmUoYXRtZWxfcG9ydC0+Z2NsaykNCgkJCWNsa19zZXRfcmF0ZShhdG1lbF9wb3J0LT5nY2xr
LCBnY2xrX3JhdGUpOw0KCQkJY2xrX3ByZXBhcmVfZW5hYmxlKGF0bWVsX3BvcnQtPmdjbGspOw0K
CQl9DQoNCg0KPiArCQlhY3R1YWxfYmF1ZCA9IGNsa19nZXRfcmF0ZShhdG1lbF9wb3J0LT5jbGsp
IC8gKDE2ICogY2QpOw0KPiArCQlpZiAoYWJzKEVSUk9SX1JBVEUoYmF1ZCwgYWN0dWFsX2JhdWQp
KSA+DQo+ICsJCSAgICBhYnMoRVJST1JfUkFURShiYXVkLCBnY2xrX3JhdGUgLyAxNikpKSB7DQo+
ICsJCQltb2RlIHw9IEFUTUVMX1VTX0dDTEs7DQo+ICsNCj4gKwkJCS8qDQo+ICsJCQkgKiBTZXQg
dGhlIENsb2NrIERpdmlzb3IgZm9yIEdDTEsgdG8gMS4NCj4gKwkJCSAqIFNpbmNlIHdlIHdlcmUg
YWJsZSB0byBnZW5lcmF0ZSB0aGUgc21hbGxlc3QNCj4gKwkJCSAqIG11bHRpcGxlIG9mIHRoZSBk
ZXNpcmVkIGJhdWRyYXRlIHRpbWVzIDE2LA0KPiArCQkJICogdGhlbiB3ZSBzdXJlbHkgY2FuIGdl
bmVyYXRlIGEgYmlnZ2VyIG11bHRpcGxlDQo+ICsJCQkgKiB3aXRoIHRoZSBleGFjdCBlcnJvciBy
YXRlIGZvciBhbiBlcXVhbGx5IGluY3JlYXNlZA0KPiArCQkJICogQ0QuIFRodXMgbm8gbmVlZCB0
byB0YWtlIGludG8gYWNjb3VudA0KPiArCQkJICogYSBoaWdoZXIgdmFsdWUgZm9yIENELg0KPiAr
CQkJICovDQo+ICsJCQljZCA9IDE7DQo+ICsJCQljbGtfcHJlcGFyZV9lbmFibGUoYXRtZWxfcG9y
dC0+Z2Nsayk7DQo+ICsJCX0NCj4gKwl9DQo+ICsNCj4gIAlxdW90ID0gY2QgfCBmcCA8PCBBVE1F
TF9VU19GUF9PRkZTRVQ7DQo+ICANCj4gIAlpZiAoIShwb3J0LT5pc283ODE2LmZsYWdzICYgU0VS
X0lTTzc4MTZfRU5BQkxFRCkpDQo+IEBAIC0yODgzLDYgKzI5MjEsMTYgQEAgc3RhdGljIGludCBh
dG1lbF9zZXJpYWxfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gIAlpZiAo
cmV0KQ0KPiAgCQlnb3RvIGVycjsNCj4gIA0KPiArCWF0bWVsX3BvcnQtPmdjbGsgPSBkZXZtX2Ns
a19nZXRfb3B0aW9uYWwoJnBkZXYtPmRldiwgImdjbGsiKTsNCj4gKwlpZiAoYXRtZWxfcG9ydC0+
Z2Nsaykgew0KPiArCQlyZXQgPSBjbGtfcHJlcGFyZV9lbmFibGUoYXRtZWxfcG9ydC0+Z2Nsayk7
DQo+ICsJCWlmIChyZXQpIHsNCj4gKwkJCWF0bWVsX3BvcnQtPmdjbGsgPSBOVUxMOw0KPiArCQkJ
cmV0dXJuIHJldDsNCj4gKwkJfQ0KPiArCQljbGtfZGlzYWJsZV91bnByZXBhcmUoYXRtZWxfcG9y
dC0+Z2Nsayk7DQoNCklzIHRoZXJlIGEgcmVhc29uIHlvdSBlbmFibGUgdGhlbiBkaXNhYmxlIHRo
ZSBjbG9jayBoZXJlPw0KDQo+ICsJfQ0KPiArDQo+ICAJcmV0ID0gYXRtZWxfaW5pdF9wb3J0KGF0
bWVsX3BvcnQsIHBkZXYpOw0KPiAgCWlmIChyZXQpDQo+ICAJCWdvdG8gZXJyX2Nsa19kaXNhYmxl
X3VucHJlcGFyZTsNCj4gQEAgLTI5MjksNiArMjk3Nyw4IEBAIHN0YXRpYyBpbnQgYXRtZWxfc2Vy
aWFsX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAJICogaXMgdXNlZA0K
PiAgCSAqLw0KPiAgCWNsa19kaXNhYmxlX3VucHJlcGFyZShhdG1lbF9wb3J0LT5jbGspOw0KPiAr
CWlmIChhdG1lbF9wb3J0LT5nY2xrICYmIF9fY2xrX2lzX2VuYWJsZWQoYXRtZWxfcG9ydC0+Z2Ns
aykpDQo+ICsJCWNsa19kaXNhYmxlX3VucHJlcGFyZShhdG1lbF9wb3J0LT5nY2xrKTsNCg0KSXMg
dGhpcyBkdWUgdG8gdGhlIGVuYWJsZSBpbiBhdG1lbF9zZXRfdGVybWlvcygpPyBJcyB0aGF0IGNh
bGxlZCBvbiBwcm9iZQ0KcGF0aD8gQWxzbywgdGhlcmUgaXMgbm8gbmVlZCB0byBjaGVjayBmb3Ig
YXRtZWxfcG9ydC0+Z2NsayBhcyBjbGsgQVBJcyBhcmUNCmFscmVhZHkgZG9pbmcgdGhpcy4NCg0K
PiAgDQo+ICAJcmV0dXJuIDA7DQo+ICANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdHR5L3Nlcmlh
bC9hdG1lbF9zZXJpYWwuaCBiL2RyaXZlcnMvdHR5L3NlcmlhbC9hdG1lbF9zZXJpYWwuaA0KPiBp
bmRleCAwZDhhMGY5Y2M1YzMuLmZiNzE4OTcyZjgxYSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy90
dHkvc2VyaWFsL2F0bWVsX3NlcmlhbC5oDQo+ICsrKyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9hdG1l
bF9zZXJpYWwuaA0KPiBAQCAtNjMsNiArNjMsNyBAQA0KPiAgI2RlZmluZQkJQVRNRUxfVVNfUEFS
X01BUksJCSgzIDw8ICA5KQ0KPiAgI2RlZmluZQkJQVRNRUxfVVNfUEFSX05PTkUJCSg0IDw8ICA5
KQ0KPiAgI2RlZmluZQkJQVRNRUxfVVNfUEFSX01VTFRJX0RST1AJCSg2IDw8ICA5KQ0KPiArI2Rl
ZmluZSBBVE1FTF9VU19HQ0xLICAgICAgICAgICAgICAgICAgICAgICAgICBCSVQoMTIpDQoNCkl0
IHNlZW1zIHRoZXJlIGFyZSBzcGFjZXMgaGVyZS4NCg0KPiAgI2RlZmluZQlBVE1FTF9VU19OQlNU
T1AJCUdFTk1BU0soMTMsIDEyKQkvKiBOdW1iZXIgb2YgU3RvcCBCaXRzICovDQo+ICAjZGVmaW5l
CQlBVE1FTF9VU19OQlNUT1BfMQkJKDAgPDwgMTIpDQo+ICAjZGVmaW5lCQlBVE1FTF9VU19OQlNU
T1BfMV81CQkoMSA8PCAxMikNCg0K
