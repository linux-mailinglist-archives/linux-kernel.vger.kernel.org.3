Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7CF5794A7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 09:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237023AbiGSH4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 03:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233519AbiGSH4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 03:56:42 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5961E18E18;
        Tue, 19 Jul 2022 00:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658217401; x=1689753401;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=6HR51nglmHE4f5VhblPXPaj7zobwCLe3e9YwL36jXmM=;
  b=DSHvJZBgyXCRuizuf+J5B6eoJf7Z3nyZkNPRFF2U0mMKWvF5NoweByMv
   7Rc+mMkPM6w6uWlCnpCrMTtfhhlE+OQF+eIC8dDhiRl+v6s7TPlR3AW+M
   eNRKvac7Aml0ZIQmY3FN4OBuwvlhJH94lEjBuiwDz9o4qGKnyTA26fLNL
   0kwYRU+qjYXjO+1AIFvay+wbuc7E9ggd5dS9epfWAzjw8cqKufbc/JElc
   +nIA+p+8iG/tWTwkUlg2DunTu0C/Y2GORkLX7+zNpbeM1fyZpwq76gTxU
   58QJHVEutXC9nfpVy4fOdw3g36oV73ocSvcmaKrTDhO7qrkXzkRnPHz5N
   w==;
X-IronPort-AV: E=Sophos;i="5.92,283,1650956400"; 
   d="scan'208";a="165362003"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Jul 2022 00:56:40 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 19 Jul 2022 00:56:40 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Tue, 19 Jul 2022 00:56:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DkS7OFjUevGAJucLGxiB7LBaYFrYRSmSlGQkjaLBBEboitBL1PG2nluCpFJQdDVGKyFpOtbiFSmWyvTo8tQzquyxfSOD1ZgYc8UvSbY+Wpt8PYlLRfNahPKJurtZZ2H/DrTPb8rVTw6PFOAxAA6KH+Uw52iRjOQA9hO4eSZDZ1fAeYYDPqNfnWMJvYWx5idLEwGTyitbHvFQ88o8E5H76QYO7Haii5MSx/fzETlIR48o675UOZNU9L++45ik5qEPSe+xJt9NGFeFJ4QSSTbhB+uvlZR4C3B9yozfb+9n87L90GWmOMVaKiAt4m6v7rQlcFkiKuAoqlFQhP4wJvLSpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6HR51nglmHE4f5VhblPXPaj7zobwCLe3e9YwL36jXmM=;
 b=CHBSHUrc/n+ne6EEzdpk7pBO9JMITtJ5T3myn6dR7wd4G+1fixHZicgT3TOCNwKyJaul0kGCr5T4lqm6pbx6Y4JZoe+aJspzeW/vwR79G4ZwxRaUJ+WXGDBA405iWvtMvqt3B/50iM7lqA17c03yydUL3MATbzc7wZlktnZIIhgI+ohfy//LQbJmyGTdgkAvpDIJlQNmVkFwHHyYQT+mjMBo2uQLt96fDqTEzSAX+K13af7KjCbDRiX85EL1SbQrSBKKa+6ToKOvCxK3qir2HtZ+/etPvNJ5r0cciHicH8fMqq5Mk+yNDbMb4QlXEl/uZbivwu3KlKKCu0GYBs5N5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6HR51nglmHE4f5VhblPXPaj7zobwCLe3e9YwL36jXmM=;
 b=dp5/hTzt6PcLJv1gVgqsT3s4y3pxGKac+3g3HNUfwcCjsuTBkUZy3qU6YMZzVFhi2ghK9qb1vUYRpDr+8QwSU6sWVfJNP5I2A1S4PGgccQQx6IeXN3fT5N+O2azgDnMT6UKR6S6FEacxENGEGxQlkJqOJpaKmZSkRkP71FN6mgE=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by DM5PR1101MB2156.namprd11.prod.outlook.com (2603:10b6:4:51::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.17; Tue, 19 Jul
 2022 07:55:57 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5c8c:c31f:454d:824c]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5c8c:c31f:454d:824c%8]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 07:55:57 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Horatiu.Vultur@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <Nicolas.Ferre@microchip.com>, <UNGLinuxDriver@microchip.com>,
        <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH 2/3] ARM: dts: lan966x: Disable can0 on pcb8291
Thread-Topic: [PATCH 2/3] ARM: dts: lan966x: Disable can0 on pcb8291
Thread-Index: AQHYm0T6HXcYmDgMp0qTebssdIgw7Q==
Date:   Tue, 19 Jul 2022 07:55:56 +0000
Message-ID: <530ef4f3-26ce-5a90-f2f7-d6163124bfec@microchip.com>
References: <20220718212921.1506984-1-horatiu.vultur@microchip.com>
 <20220718212921.1506984-3-horatiu.vultur@microchip.com>
In-Reply-To: <20220718212921.1506984-3-horatiu.vultur@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 78b34cdb-719c-4de6-b2a6-08da695c1cf2
x-ms-traffictypediagnostic: DM5PR1101MB2156:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +lBQ49P4WSzm6UP/UzdO3u343GhZDTXULuHJXqyWJ/F2CCI2sh3j5VB7/iyDVq0BOy2h4p4lImXiJvHlQueG3YD8VidROU76McfrVhF71tgSQ6cSbAEs1xY3HpBd4Q8qL0jBcQcnwWoD3VMxIseOC7uQkI/9kncDu1ZCUCNC2+JzzlAdyvRrKS/ZemdWRHyswOuNZzSaB7VBoqp7XLn7hg+3AyE96V5jjuBAtOonISoxDWzEBWOcvsKWnQ+SBMx8jXWW+cz29G0EdzemLcqFpxFhUUrCrXBgb6NuAB2tXjzLl1yuT1zHXzJ79c7bNQVG5UohNvVTdajX/RHyE5DDwnEvAJtNu1rddJYCno4CuYqCCDx63YziywiSc+Cqbm68F1cIU12d3E2mRP8S85vi9SIPTcif0DYS+GAsxyewd3RHOcHBoSnxYB/ovOv8VZEqZ8pRuLKaCrw0OcvO1s3TA4iGs91lUAwdijGdb2n//iIhZiC5owHZ3jGohrGAvmgTXEXi6UsqFgSWHNF815Xwz9Kul91LKZi5TuBrKTZD5Z3nd18Fsi4ASWNrLrci1AWST0qLV96ZuyqC6o5cHIzBXxYyMjLHMK/Ufj83359oMd4/Se3zVU1zVXX3c58j75iIarm9uX2PngSY18X3LHH6MrurQATszfTihB4WBMwZo+lQNHWE7N0j2gNXiaLTx3u1wHhuCMu2b+NrgbEoYmt7V6UxiYg5mcpYfTUimXViHmzYJKnHWWbloYO91VGAbdid+Ht4tcQT7aVzkWOIYpfYVdAA4ua9dDwbTyCtC/AjZf8cPATwGNkaAkZKuwbjophMs3/+Qiu20TH9J2pJkNcFhWeQPxU5YpCJaY4j2PmU13YDS/Ljz1cwemoIGfMT8nm4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(136003)(346002)(366004)(396003)(39860400002)(4326008)(8676002)(76116006)(66946007)(66556008)(8936002)(64756008)(66446008)(66476007)(316002)(38070700005)(54906003)(122000001)(86362001)(110136005)(31686004)(38100700002)(36756003)(2906002)(91956017)(186003)(26005)(6486002)(5660300002)(53546011)(6506007)(41300700001)(71200400001)(478600001)(31696002)(2616005)(6512007)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QTYvSDhXNlBrZ0lueUlNeFdPZC9LVnhOZUdPZEhHL2lFb0JuQjl3NEFZdDdi?=
 =?utf-8?B?NFRsZ2dldCtiQXV1dVh2WDhqVVpwdlZDUU9HYWs0RWw1OFRHQmpVbTJLeWpL?=
 =?utf-8?B?cnAyMXpKNnJNZFFBcU00SlFSNm5FYmlvaGwwSDFuVENZSjdKSitKYk9xTE5P?=
 =?utf-8?B?MFB3ZDNabUNhRzFXOWMrR1U1Rk1wRWR0dUVPbjA2Zkg2SUpISjZTY2ZGSVpK?=
 =?utf-8?B?T1lXSHlHdHp4NW1GOW1jekhVQnRZdHZYRXBuUUg1TTU5VFBlbjlKZkxHaDZ3?=
 =?utf-8?B?blNMeTFrR1BaRUxvdVBEaTIrWkUvTUJySDVhcjM5SmJ5VEhjUUV2cHZieDFh?=
 =?utf-8?B?WDJLV2JYNnZYVGN2Ly9vRnBSaWxKZXpBdTVaVGdvRlkya0dkOVhFbHJXZi9u?=
 =?utf-8?B?RUlvVlVVcGJQVXJGaDQwUm9FSTVHd25pT3V5cWZoTGIxVmpFeDBNTTJYMGxj?=
 =?utf-8?B?cEJUYndXbXhpd1Frbko0K3o5R3g2SmFINmNENWVFSFlMRGF0S1dUKzRKUlU2?=
 =?utf-8?B?Nms1ZWdOUUNyTHlHREFmT2Q2QUtjT2ZOYnVmSUZRUXFESWpIYXh0elNyenFV?=
 =?utf-8?B?dWdHbm9YMWYzUVpxTlArQm4wMlVvT2xqT2hyTDNJbHo5WXlqQkJRb2JWbk5S?=
 =?utf-8?B?bjByM0VlbitMejhwZ2RmUEQzc2IxYWtyRWxCanl0TGpNMW8rSVY3M1NzZlZK?=
 =?utf-8?B?dklBZG9MNjJrQVdQQlhHUUhleEV1UlRFUWpWMklLalFpZVV0Q1NrUVJ4Szla?=
 =?utf-8?B?WGZNWWUxbTFQK2lLeXZ3RWV0cHU0dEt1eEE3enRySm1iaFJlWnIwMnBGaytS?=
 =?utf-8?B?MjJZSm1sb2JYNUk2Qkd3RUg5ZmdmUGd6eXVXZTNSVmliUlpZRDRMV1c5N2xv?=
 =?utf-8?B?YXpwL1FxdmpFTFBjVDIxQ2R5Q2p6QVNGaVA4VXlQdk9ScWRWaEJJZVdjQTUr?=
 =?utf-8?B?U0Qvc01vQ3c0bHl6WjBpR2JOakVCY3FMZU1ZQ0dyNFcrNTZRaHJsTmFnVlFW?=
 =?utf-8?B?aEdIa05Pd09WeGFmZ2UrdGFkNkQraC9pZGxkVlZJSWdUWjhERGcrYkFNWll6?=
 =?utf-8?B?dEdrdlZMRStYOTN5KzVuT3NPY3lYVXdSai9ZVmQveVF4RmoyZ2V5cEFhT0ZD?=
 =?utf-8?B?M2dYZnlQY25EQWRBWlFSWEt2NEQxNnh4VnJFRzFIM0hhQmExTTlPQmNjNy9t?=
 =?utf-8?B?eVg5bXpuak1FcmFIL2paQWh4OFdSaEgxZ0RLa2Z5S08zTnQxYld1M2gvdTdJ?=
 =?utf-8?B?WkRjUm1oTXIxMUJVbExOWk9ySStQVHE1YkNQZmoxN2lya3FSVU1XaGVpODZ0?=
 =?utf-8?B?aVFuZUNjOURWTWlYUzdLeTdlZld0N3FCUHFDSDNyRG1FZEQxS0tPNUsrTS9G?=
 =?utf-8?B?Vm9TMm8vRG9KUGVDdS9acXVESjZhc1BERDRINFdWM3VlaDNST1orUVV3ejk4?=
 =?utf-8?B?ODFXOHF6bFliZllNdE9vbElOS1hUTW1qaFBJcFZhMmpNWFdnTVoyNk05MGVx?=
 =?utf-8?B?TWZENWI4SjlUOGY5dGp2ZE1URDhpWTJJQ1hndGIyRkZVVWp3N1FYN2xWLzQ2?=
 =?utf-8?B?MzF4bEJIa3hVNXpKaXo5YlNCMm5hMzJ6RmV1UnkydkVOZTJCU3NISEtrdStL?=
 =?utf-8?B?cEFwRE8xY1JES25MeU5Wc1ExOHhLUjY2MitwNEYyR043SmloeU40VTR5RWhh?=
 =?utf-8?B?Wk1wQVc2azZiMndIT25HTGpCMU1BK1M1eWxHZllsdlBScWgvMHJsZ054NmVi?=
 =?utf-8?B?czVsdFBheXZWZEdGcXJRRUpPS1ZVTkFjMm1SY2M4MWNrd2FXcDNYc2VDS3Q2?=
 =?utf-8?B?T2thQ2taUGh3aS9kOVBWanlweDVMbFpOekRsYTN0Q2k4N2lsZ2NLRDB2Wlk5?=
 =?utf-8?B?M0FYYmJqU0lORjBsNjZrdnpyckpYd0dNcVEzSlFIbmkxdGRFTGtLY0JBcGwx?=
 =?utf-8?B?V2paTUw1MTFFZWxqWlZ4bGViRkdJbktaOHhQRWxNa05zdG9KWDM0YnpzU0Jr?=
 =?utf-8?B?SU5EU3p4em1aMlE2OTNWTEhKTUcyRGlwL0lkelRRRW03ZzhBdDVVV3p1QUcy?=
 =?utf-8?B?dzVxbEI2bFRaZjlrKzNtcFNBN1o2NUdpa2FjOURBZ2dPRHkzQzNCM2lPYW52?=
 =?utf-8?B?K0NtN3c3ZHVmelBHcHBYNkJZdEhDOHo3dUsreENhUmdtRmY0ZjZWeEJDNDF2?=
 =?utf-8?B?WlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2A9E94F1B38BDE4F96D746E0197ECF1A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78b34cdb-719c-4de6-b2a6-08da695c1cf2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2022 07:55:56.9296
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n8gImP3c5c7BBd0GcvF9EVYZCbzsmtX7XkveCDQe16Bk3V0WqQXmhU+UqwRx2x/iwelc84fDFKJn9Lkzli7NVJLaIkFCXmLmILHWlyBvt8g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2156
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTkuMDcuMjAyMiAwMDoyOSwgSG9yYXRpdSBWdWx0dXIgd3JvdGU6DQo+IE9uIHBjYjgyOTEs
IGNhbjAgYW5kIHRoZSBuZXR3b3JrIGRyaXZlciBzaGFyZSBzb21lIG9mIHRoZSBHUElPcyBzbyBv
bmx5DQo+IDEgZGV2aWNlIGNhbiBiZSBhY3RpdmUuIFRoZXJlZm9yZSBkaXNhYmxlIGNhbjAgYXMg
d2Ugd2FudCB0byBlbmFibGUgdGhlDQo+IG5ldHdvcmsgZHJpdmVyLg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogSG9yYXRpdSBWdWx0dXIgPGhvcmF0aXUudnVsdHVyQG1pY3JvY2hpcC5jb20+DQo+IC0t
LQ0KPiAgYXJjaC9hcm0vYm9vdC9kdHMvbGFuOTY2eC1wY2I4MjkxLmR0cyB8IDEyIC0tLS0tLS0t
LS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL2FyY2gvYXJtL2Jvb3QvZHRzL2xhbjk2NngtcGNiODI5MS5kdHMgYi9hcmNoL2FybS9ib290
L2R0cy9sYW45NjZ4LXBjYjgyOTEuZHRzDQo+IGluZGV4IDAyZmJmNzM3MWE4ZC4uMmNiNTMyYWEz
M2YwIDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9sYW45NjZ4LXBjYjgyOTEuZHRz
DQo+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2xhbjk2NngtcGNiODI5MS5kdHMNCj4gQEAgLTMw
LDE4ICszMCw2IEBAIGZjM19iX3BpbnM6IGZjMy1iLXBpbnMgew0KPiAgCQlwaW5zID0gIkdQSU9f
NTIiLCAiR1BJT181MyI7DQo+ICAJCWZ1bmN0aW9uID0gImZjM19iIjsNCj4gIAl9Ow0KPiAtDQo+
IC0JY2FuMF9iX3BpbnM6ICBjYW4wLWItcGlucyB7DQo+IC0JCS8qIFJYLCBUWCAqLw0KPiAtCQlw
aW5zID0gIkdQSU9fMzUiLCAiR1BJT18zNiI7DQo+IC0JCWZ1bmN0aW9uID0gImNhbjBfYiI7DQo+
IC0JfTsNCj4gLX07DQo+IC0NCj4gLSZjYW4wIHsNCj4gLQlwaW5jdHJsLTAgPSA8JmNhbjBfYl9w
aW5zPjsNCj4gLQlwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0KPiAtCXN0YXR1cyA9ICJva2F5
IjsNCg0KWW91IGNhbiBqdXN0IGRlbGV0ZSB0aGUgc3RhdHVzIGxpbmUgaGVyZSBvciBjaGFuZ2Ug
aXQgdG8gImRpc2FibGVkIiBhbmQNCmxlYXZlIHRoZSByZXN0IGZvciByZWZlcmVuY2UuIEZvciBl
dmFsdWF0aW9uIG9uZSBjb3VsZCBqdXN0IGVuYWJsZSBpdCBoZXJlDQphZnRlcndhcmRzLiBPbiB0
aGUgb3RoZXIgQVQ5MSBzcGVjaWZpYyBib2FyZHMgd2UgYXJlIHVzaW5nIHN0YXR1cyA9DQoiZGlz
YWJsZWQiOyBhbmQgYSBzaG9ydCBjb21tZW50IGFmdGVyIGxpa2UgdGhpczoNCg0KCXN0YXR1cyA9
ICJkaXNhYmxlZCI7IC8qIENvbmZsaWN0IHdpdGggZ21hYzAuICovDQoNCj4gIH07DQo+ICANCj4g
ICZmbHgzIHsNCg0K
