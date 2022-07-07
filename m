Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79875569F38
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 12:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232625AbiGGKNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 06:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234920AbiGGKMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 06:12:55 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23364F672
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 03:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657188772; x=1688724772;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=48n/DpD/NaEh2exo/2g8b8dypKb7CiloEadbUUZxK6w=;
  b=HGOff1eZqntMk4FQZy4fSvfLGCLH67+sNoINJkkAUK/DxoYOexxILqdd
   gU1lJAlctjmtghoCT26sbZ+snuL3c4D+ZvwUl7Pf/cPPADtXDIt1KKIaO
   TQrmw0jr8SCgnGZBjoGajDfQZ7u7PIROSPxbN8ZzEywqKmQ7rj67wgL8W
   tol4L2A4mNleAXMpbJ2b457DoWSwEq2OuVnVKucD7dIeGQTTq0JLESMTf
   ZHXBJS/d4RRuWm9+ps1MCSjpnquTRGtiakBCalRKDVq4aQFswoTUXhk41
   zTcVGKgp6G0CMKHWxm/GjKVVQ+MapbRwdIZxrEInC1pznDlh44KcJwKXU
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,252,1650956400"; 
   d="scan'208";a="163727568"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Jul 2022 03:12:51 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 7 Jul 2022 03:12:50 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Thu, 7 Jul 2022 03:12:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IuEPFYTlqFybJgk23jRfWDlzIlyfPF7188AtklZkUWKL2YAZLz7q4mgQaViJdnMh56mH4lEpXMVboyHK3zffW/WcsM6ERwpMLbQDVHHPOERuvoxXOnSOcagx2h2KoGaOkK5Th2tg9ChHSzybQPUM7lQ7+FmIp4hWHefMWUaSingtNR9A27GKUy5K6UwrfPOWQOxOj2sUG/gskEXe8ErNOdnNZtTDF1dJI2kFvK2/lgfaepbSIfiTlmjArG0vMvEe2uNCw1uoP/geItxO5dy4flaSdlkoebyYJaaSNOEZAwTNwwfm1g3ROQ4ObWTM0kSNVwAhOfUCGIGsD2cIFDHggw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=48n/DpD/NaEh2exo/2g8b8dypKb7CiloEadbUUZxK6w=;
 b=oSRJuscKZrCWz+GJ9wWBLeGLZPE+eVJQRmZuayJITjXk4xrWY+iusiOZ/CLxm5ChexISVW0YDvsULZRPoP6YEzbyuEUOFz0SCToZM4bL9FxXJKmuk0llVrxtrkFVo06+W3Y8fTkdPRj0ytEdDNe3V12lGDK2VrLVy80cjEqn+Z8w0TQ7DeFPaNuJLGxHLmKKTTydADC0jxCrfqHnBn3gapWdS/IFqVIN84pGSS7jwIju/yaf3sh4/WaMlwEK+lQujgkpFMCUhmxx8/q9srF4Hzhw9l2WRcKkIletisuHqOpEe/cTWey+dC+kiyydDkBTncjFcxwxZvg4nlqSxz5BXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=48n/DpD/NaEh2exo/2g8b8dypKb7CiloEadbUUZxK6w=;
 b=rW7rulKzicdLoSGkzVngbak/Tt07lSw5I8KWxN3opxzA4Xa/OysEPn8/ZekfUPL2CLfXK2kx0n8PcRe7zwidgjW05P3Ntst8S3IGIUygXQF7XQYf1GASo/180GYEd6yuZMFXtzMJhKwrWn3VcmlfR+6lSBPzzu0p6dfyhAvdnqU=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by BY5PR11MB4152.namprd11.prod.outlook.com (2603:10b6:a03:191::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.18; Thu, 7 Jul
 2022 10:12:48 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::8d4a:1681:398d:9714]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::8d4a:1681:398d:9714%5]) with mapi id 15.20.5417.016; Thu, 7 Jul 2022
 10:12:48 +0000
From:   <Conor.Dooley@microchip.com>
To:     <sudeep.holla@arm.com>, <atishp@atishpatra.org>
CC:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <palmer@rivosinc.com>, <aou@eecs.berkeley.edu>,
        <Daire.McNamara@microchip.com>, <Conor.Dooley@microchip.com>,
        <niklas.cassel@wdc.com>, <damien.lemoal@opensource.wdc.com>,
        <geert@linux-m68k.org>, <zong.li@sifive.com>, <kernel@esmil.dk>,
        <hahnjo@hahnjo.de>, <guoren@kernel.org>, <anup@brainfault.org>,
        <changbin.du@intel.com>, <heiko@sntech.de>,
        <philipp.tomsich@vrull.eu>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Brice.Goglin@inria.fr>
Subject: Re: [PATCH] riscv: arch-topology: fix default topology reporting
Thread-Topic: [PATCH] riscv: arch-topology: fix default topology reporting
Thread-Index: AQHYkWi/AAEA7OGPIkSptAwercRHiK1x3oOAgADL8ACAAAb3AA==
Date:   Thu, 7 Jul 2022 10:12:48 +0000
Message-ID: <ff76019d-5f4f-4548-6605-34487d30c7cb@microchip.com>
References: <20220706184558.2557301-1-mail@conchuod.ie>
 <CAOnJCUL-RCkXi=1GSEipYmf1qMxkOASr_H65kGU+5c=AqJBZKA@mail.gmail.com>
 <20220707094756.rftfann3rcixdfp4@bogus>
In-Reply-To: <20220707094756.rftfann3rcixdfp4@bogus>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c2932318-5039-4bce-dfb4-08da60013e44
x-ms-traffictypediagnostic: BY5PR11MB4152:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JvO+VbafO04Ic9mqsPoENXeTS1yo+4W17eHcidYBpRTG4VHhp/7pmWnSHz/4Y1UbOcf0n5TqRVKRAK182wcejXM7a58hTl2KJ9P544Vof3jC718h3VoF1dcHWhTPvGR38TF/P79US3B0s2vjJItHgRRr50Pe25J+HiBSmInKigiqPtcr8t1sIxvDaAFRXR1k3zVxBWWIS2Kn2btZZD+dbp1+21nwN9RBEQAwCyZ/BMyvbUxVDfTJmVkHqcD1SUUIx0XH06YoIi4xvQ/9AtJocHGX06vbnYCPU0stNOHlXN0Xzj/RHm6798RebmCDWZpn+8C8S0BOAVxHKxgAKqp8nGAxUubPWRbpRP9DfC2WrYy5s7RWEeLcLxwWxBDF6HL33nHY2vYgElLqv6Oel/RdB7bCiMARPLZvwsvX22CHaScZJH3aMp1PtafOXfx6jxIMvl+Rd9VRa82FF5M+a+FfCInaoiGv59wPDzf9+Bj7JZOt/cukQJ24nUPmHHEgQ4z2prn+m7JjQIMg8HJcKezmQGaOWCZNmQbHvLq6UD/24/G09+3Krxv7KAdWYHQdpm24zIKREpxlk5COCdEJRenAxhceidJpNrT6UANBARtitwrJwc2xkAF+muVybCpCvBEDfHWNA8uW8GSVh8Nf+nxgMhEHBGDH6+JY2RJGGSbXuzO6bNUHOuLCXebzqdTAoP3CLHRGFTmxHZgLu66bSrdekzHIGtK77ePni0axi0+CCvhp52tvgBUgsSB3SwdicWXpAPxtacyU5b49aU3OtqEbYhPK4xArDdX77yK8u+XRdit9DNQMotqm9yUnxwpYdfTQnJVoN4kEQPgbL4rx138HlhHTTH3Eish6cJJxRMdUkiDjd61gT0mZpBPwfRfxwoKO0ox0DdGm1njNV5XXJBZ5zw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(366004)(136003)(39860400002)(376002)(396003)(66946007)(66556008)(4326008)(122000001)(66446008)(76116006)(2906002)(31696002)(86362001)(91956017)(8676002)(8936002)(36756003)(31686004)(38100700002)(66476007)(64756008)(53546011)(5660300002)(83380400001)(41300700001)(7416002)(6512007)(316002)(6506007)(2616005)(186003)(6486002)(38070700005)(110136005)(54906003)(71200400001)(966005)(478600001)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SVEzMStSeVFzYVNlVnk1RmNmZ0ltUm9qcXZzeFVBS3liSmpON2E2SWxmRmFP?=
 =?utf-8?B?ejN5MFA0bi9TYVgzcFVwZWM3R2FYR1RZMmVDczZweS9manRvTnlEYUZEcDds?=
 =?utf-8?B?TjF4V05kOWJITHRDVXhIMXlid05OSHZLbjNrUmppaWxXZUFCS09aSjVRZS95?=
 =?utf-8?B?VmZjOHVxaXFyMmdoUDdCOUVUTzhza0lGdXhPNFNBTkFaRGpOa293L0orRFhF?=
 =?utf-8?B?RmZXeDFGanp2OFlzeW9rUEZGRjN2TDlvQ0duV21zWkJscFR1eWc5end6MWl1?=
 =?utf-8?B?SkNMKzRWbDhReE1pTzQ2cnJoeXFJc0g0TzU5TlNTWmlqc0kxaVd1ZjU1aG5t?=
 =?utf-8?B?dmRuRW1mQlBTbVlkWFJ3QUQ3MWlTQTdYMWtiMEtiK3JqdXh6SzlSdU9MNUJP?=
 =?utf-8?B?K2hWNGdTdjQ5QWZiWUlHZURhaGwzZTlwQllBa0RhNWZBa1ZZcEtCdmFiTGN0?=
 =?utf-8?B?Y2t1eCtjZWkrOENHT0t5SkUrVSs3azd1M2ovZUZUaDZaQkZXbWhJR0p5RGdX?=
 =?utf-8?B?dWVYd0tTME1qVldOSjQyS1ZJOS9aQ2Y0RHk0WXNBY1FCVkFqU3RIalcxbm5y?=
 =?utf-8?B?VHFqYWVXZklNV1pPM3lRSVlqTXNKNUVJaE9pZU93RCtUZ0FhRXZxV3dzR0Jw?=
 =?utf-8?B?SU9VdEo0VEdHeHRubEVrZVFGVzdGU3JjRktHaVd6NVIyekVwalduOWUzelJp?=
 =?utf-8?B?cjlXMDRXSnlISmZLMURwMkxGN1doendMZW96bXhNWSt5MndFK3Nnc0I1TytK?=
 =?utf-8?B?ZWV4cm5vdStUejVwdTJtUEpJT214SHRxYjNUbWJQcVNoWGdQalYxbmZpLzZM?=
 =?utf-8?B?LzJrYzVLY09rMG1FQkM2L0xuN0d2U2k4bEU2SlRTVlVEWjl5Q1V2SEN5M0pD?=
 =?utf-8?B?S2VVN3Y3SGgzUmxaWms4bFBvTDNxVlhKck0xK0RJNkdZMUFJeklMVzloakZM?=
 =?utf-8?B?dis0SVdBb3JNemRVanlZUUZMM2ZJVG1ZQ21MSVZjanJLUVdSR2hIdWVxYy96?=
 =?utf-8?B?TFZJTjVHeXNxTU12TUtHVVRyR3Jjc01jQ3pJOUFoU01USFdlYnNrQ2ZmWnJM?=
 =?utf-8?B?Z1VJMlVoTjQyOThKRjlwZzBMbWtLZkM4UEp4QUFVS283YUdYcGhmdlN4OHpj?=
 =?utf-8?B?eHRmblp5OWtSQk9xdjNvOXFlUzJiMmlXblFLOWFkbmUrYjQwRlVQemRkOWhw?=
 =?utf-8?B?NXdSejUrcm5uZFFWTnFiSmp6Z2FJSFVVZlVWcDV1OENyMVpGQXNQYVhManFD?=
 =?utf-8?B?QTUyN2VKOXlEdEhLSTQ1TTdaTGNRMWUzYm9QdVFESGU2NEEwL2x0TzJTdzBB?=
 =?utf-8?B?aVdkckVVRmhJaTU1VCs2S2Z6UStWeHpwaTFIeityenJiTnRNOE5lTk8zRjhz?=
 =?utf-8?B?MkVob0VzSWprM3FjL0lDSGxFWVNPQUJsNndVeENUT2ErS0w5L0d1RmRWYmNl?=
 =?utf-8?B?bnZkcG5NK3hzNmVDQnpYNW1HdFBFMU96Y2NERWxta3VlMGRsWHUzeHZnODl2?=
 =?utf-8?B?OVBTc3hnRGpZZFFmSVpvRWNWTmFLbVE2Tkx6aFlYOUpGMzJ5RUUyNXdSNUNO?=
 =?utf-8?B?QmIxRlZwbUMrQm5RNTlOMVN1SHlkSnlpZWI5VXJqeFFDZENRVHgxV2tqVnZ4?=
 =?utf-8?B?cVJORjFMQ3pORTVnTVYwTDFGSGVIMlNERnQ4NXc3ZG13ZGJlQlFBTEk0VUlT?=
 =?utf-8?B?akhLYkd5UVNYZXdQcjNHU0Q3blVCL0Z1RnhaUkdRRnJ5U3h6OUNhQ2FaY1Rm?=
 =?utf-8?B?OUExQlYxL1pSUTRENlJUNDBEZGE0T2FNbDFtZEtjQ1NWbXNRYjUreWtHWXlG?=
 =?utf-8?B?U1N5elN1SlU3eHVGbEU2NWhXaDljTFF0bUhJbi9NOXJxOWU5dHdOZkVYTzUw?=
 =?utf-8?B?UmtPRlhKWjlpTEsxRFJZQi9LU1Y4cHZ2eE54MldYWFVaY0RiRVM3aUI0ME03?=
 =?utf-8?B?WGEvbHRtd3NaRWc5RlZ6TndFaFkwNGJyTmRnUGtkZitFODFpbjhDUXhyMXUz?=
 =?utf-8?B?cHhRS2d6Q2xxMFNBYmt1NHg1c0dGZ01NaEpqajdIU2JEU1FTZzZIYmt2ZFlI?=
 =?utf-8?B?N3QrcS90d2hnZG5VRXZ5Mks4dnpSZVFKd3BFVnVTdUQ5b095ekx1UDdrUTFM?=
 =?utf-8?Q?9aCjJRc1hLMQN97UH1jX4d4IX?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E7584089B33BB049AA476E27FD48325E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2932318-5039-4bce-dfb4-08da60013e44
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2022 10:12:48.1968
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JadcPiCDXkicbUDRqyhp7Iy6Mziemd+lnYBgRH+JECGPleLBoMfcJFtoxNY3iq6/AUOYcEt4dpy8Bvv92tAjO9xIH/sc9s4QKwYAagbkH0c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4152
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDcvMDcvMjAyMiAxMDo0NywgU3VkZWVwIEhvbGxhIHdyb3RlOg0KPiBPbiBXZWQsIEp1bCAw
NiwgMjAyMiBhdCAwMjozODowMVBNIC0wNzAwLCBBdGlzaCBQYXRyYSB3cm90ZToNCj4+IE9uIFdl
ZCwgSnVsIDYsIDIwMjIgYXQgMTE6NDYgQU0gQ29ub3IgRG9vbGV5IDxtYWlsQGNvbmNodW9kLmll
PiB3cm90ZToNCj4+Pg0KPj4+IEZyb206IENvbm9yIERvb2xleSA8Y29ub3IuZG9vbGV5QG1pY3Jv
Y2hpcC5jb20+DQo+Pj4NCj4+PiBSSVNDLVYgaGFzIG5vIHNhbmUgZGVmYXVsdHMgdG8gZmFsbCBi
YWNrIG9uIHdoZXJlIHRoZXJlIGlzIG5vIGNwdS1tYXANCj4+PiBpbiB0aGUgZGV2aWNldHJlZS4N
Cj4+PiBXaXRob3V0IHNhbmUgZGVmYXVsdHMsIHRoZSBwYWNrYWdlLCBjb3JlIGFuZCB0aHJlYWQg
SURzIGFyZSBhbGwgc2V0IHRvDQo+Pj4gLTEuIFRoaXMgY2F1c2VzIHVzZXItdmlzaWJsZSBpbmFj
Y3VyYWNpZXMgZm9yIHRvb2xzIGxpa2UgaHdsb2MvbHN0b3BvDQo+Pj4gd2hpY2ggcmVseSBvbiB0
aGUgc3lzZnMgY3B1IHRvcG9sb2d5IGZpbGVzIHRvIGRldGVjdCBhIHN5c3RlbSdzDQo+Pj4gdG9w
b2xvZ3kuDQo+Pj4NCj4+PiBBZGQgc2FuZSBkZWZhdWx0cyBpbiB+dGhlIGV4YWN0IHNhbWUgd2F5
IGFzIEFSTTY0Lg0KPj4+DQo+Pj4gQ0M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4+PiBGaXhl
czogMDNmMTFmMDNkYmZlICgiUklTQy1WOiBQYXJzZSBjcHUgdG9wb2xvZ3kgZHVyaW5nIGJvb3Qu
IikNCj4+PiBSZXBvcnRlZC1ieTogQnJpY2UgR29nbGluIDxCcmljZS5Hb2dsaW5AaW5yaWEuZnI+
DQo+Pj4gTGluazogaHR0cHM6Ly9naXRodWIuY29tL29wZW4tbXBpL2h3bG9jL2lzc3Vlcy81MzYN
Cj4+PiBTaWduZWQtb2ZmLWJ5OiBDb25vciBEb29sZXkgPGNvbm9yLmRvb2xleUBtaWNyb2NoaXAu
Y29tPg0KPj4+IC0tLQ0KPj4+DQo+Pj4gU3VkZWVwIHN1Z2dlc3RlZCB0aGF0IHRoaXMgYmUgYmFj
a3BvcnRlZCByYXRoZXIgdGhhbiB0aGUgY2hhbmdlcyB0bw0KPj4+IHRoZSBkZXZpY2V0cmVlcyBh
ZGRpbmcgY3B1LW1hcCBzaW5jZSB0aGF0IHByb3BlcnR5IGlzIG9wdGlvbmFsLg0KPj4+IFRoYXQg
cGF0Y2hzZXQgaXMgc3RpbGwgdmFsaWQgaW4gaXQncyBvd24gcmlnaHQuDQo+Pj4NCj4+PiAgIGFy
Y2gvcmlzY3YvaW5jbHVkZS9hc20vdG9wb2xvZ3kuaCB8IDEzICsrKysrKysrKysrKysNCj4+PiAg
IGFyY2gvcmlzY3Yva2VybmVsL01ha2VmaWxlICAgICAgICB8ICAxICsNCj4+PiAgIGFyY2gvcmlz
Y3Yva2VybmVsL3NtcGJvb3QuYyAgICAgICB8ICA0ICsrKysNCj4+PiAgIGFyY2gvcmlzY3Yva2Vy
bmVsL3RvcG9sb2d5LmMgICAgICB8IDMyICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysN
Cj4+PiAgIDQgZmlsZXMgY2hhbmdlZCwgNTAgaW5zZXJ0aW9ucygrKQ0KPj4+ICAgY3JlYXRlIG1v
ZGUgMTAwNjQ0IGFyY2gvcmlzY3YvaW5jbHVkZS9hc20vdG9wb2xvZ3kuaA0KPj4+ICAgY3JlYXRl
IG1vZGUgMTAwNjQ0IGFyY2gvcmlzY3Yva2VybmVsL3RvcG9sb2d5LmMNCj4+Pg0KPj4+IGRpZmYg
LS1naXQgYS9hcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL3RvcG9sb2d5LmggYi9hcmNoL3Jpc2N2L2lu
Y2x1ZGUvYXNtL3RvcG9sb2d5LmgNCj4+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPj4+IGluZGV4
IDAwMDAwMDAwMDAwMC4uMzZiYzZlY2RhODk4DQo+Pj4gLS0tIC9kZXYvbnVsbA0KPj4+ICsrKyBi
L2FyY2gvcmlzY3YvaW5jbHVkZS9hc20vdG9wb2xvZ3kuaA0KPj4+IEBAIC0wLDAgKzEsMTMgQEAN
Cj4+PiArLyogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb25seSAqLw0KPj4+ICsv
Kg0KPj4+ICsgKiBDb3B5cmlnaHQgKGMpIDIwMjIgTWljcm9jaGlwIFRlY2hub2xvZ3kgSW5jLiBh
bmQgaXRzIHN1YnNpZGlhcmllcw0KPj4+ICsgKi8NCj4+PiArDQo+Pj4gKyNpZm5kZWYgX0FTTV9S
SVNDVl9UT1BPTE9HWV9IDQo+Pj4gKyNkZWZpbmUgX0FTTV9SSVNDVl9UT1BPTE9HWV9IDQo+Pj4g
Kw0KPj4+ICsjaW5jbHVkZSA8YXNtLWdlbmVyaWMvdG9wb2xvZ3kuaD4NCj4+PiArDQo+Pj4gK3Zv
aWQgc3RvcmVfY3B1X3RvcG9sb2d5KHVuc2lnbmVkIGludCBjcHVpZCk7DQo+Pj4gKw0KPj4+ICsj
ZW5kaWYgLyogX0FTTV9SSVNDVl9UT1BPTE9HWV9IICovDQo+Pj4gZGlmZiAtLWdpdCBhL2FyY2gv
cmlzY3Yva2VybmVsL01ha2VmaWxlIGIvYXJjaC9yaXNjdi9rZXJuZWwvTWFrZWZpbGUNCj4+PiBp
bmRleCBjNzFkNjU5MWQ1MzkuLjk1MTg4ODJiYTZmOSAxMDA2NDQNCj4+PiAtLS0gYS9hcmNoL3Jp
c2N2L2tlcm5lbC9NYWtlZmlsZQ0KPj4+ICsrKyBiL2FyY2gvcmlzY3Yva2VybmVsL01ha2VmaWxl
DQo+Pj4gQEAgLTUwLDYgKzUwLDcgQEAgb2JqLXkgKz0gcmlzY3Zfa3N5bXMubw0KPj4+ICAgb2Jq
LXkgICs9IHN0YWNrdHJhY2Uubw0KPj4+ICAgb2JqLXkgICs9IGNhY2hlaW5mby5vDQo+Pj4gICBv
YmoteSAgKz0gcGF0Y2gubw0KPj4+ICtvYmoteSAgKz0gdG9wb2xvZ3kubw0KPj4+ICAgb2JqLXkg
ICs9IHByb2Jlcy8NCj4+PiAgIG9iai0kKENPTkZJR19NTVUpICs9IHZkc28ubyB2ZHNvLw0KPj4+
DQo+Pj4gZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3Yva2VybmVsL3NtcGJvb3QuYyBiL2FyY2gvcmlz
Y3Yva2VybmVsL3NtcGJvb3QuYw0KPj4+IGluZGV4IGYxZTQ5NDhhNGI1Mi4uZDU1MWM3ZjQ1MmQ0
IDEwMDY0NA0KPj4+IC0tLSBhL2FyY2gvcmlzY3Yva2VybmVsL3NtcGJvb3QuYw0KPj4+ICsrKyBi
L2FyY2gvcmlzY3Yva2VybmVsL3NtcGJvb3QuYw0KPj4+IEBAIC0zMiw2ICszMiw3IEBADQo+Pj4g
ICAjaW5jbHVkZSA8YXNtL3NlY3Rpb25zLmg+DQo+Pj4gICAjaW5jbHVkZSA8YXNtL3NiaS5oPg0K
Pj4+ICAgI2luY2x1ZGUgPGFzbS9zbXAuaD4NCj4+PiArI2luY2x1ZGUgPGFzbS90b3BvbG9neS5o
Pg0KPj4+DQo+Pj4gICAjaW5jbHVkZSAiaGVhZC5oIg0KPj4+DQo+Pj4gQEAgLTQwLDYgKzQxLDgg
QEAgc3RhdGljIERFQ0xBUkVfQ09NUExFVElPTihjcHVfcnVubmluZyk7DQo+Pj4gICB2b2lkIF9f
aW5pdCBzbXBfcHJlcGFyZV9ib290X2NwdSh2b2lkKQ0KPj4+ICAgew0KPj4+ICAgICAgICAgIGlu
aXRfY3B1X3RvcG9sb2d5KCk7DQo+Pj4gKw0KPj4+ICsgICAgICAgc3RvcmVfY3B1X3RvcG9sb2d5
KHNtcF9wcm9jZXNzb3JfaWQoKSk7DQo+Pj4gICB9DQo+Pj4NCj4+PiAgIHZvaWQgX19pbml0IHNt
cF9wcmVwYXJlX2NwdXModW5zaWduZWQgaW50IG1heF9jcHVzKQ0KPj4+IEBAIC0xNjEsNiArMTY0
LDcgQEAgYXNtbGlua2FnZSBfX3Zpc2libGUgdm9pZCBzbXBfY2FsbGluKHZvaWQpDQo+Pj4gICAg
ICAgICAgbW1ncmFiKG1tKTsNCj4+PiAgICAgICAgICBjdXJyZW50LT5hY3RpdmVfbW0gPSBtbTsN
Cj4+Pg0KPj4+ICsgICAgICAgc3RvcmVfY3B1X3RvcG9sb2d5KGN1cnJfY3B1aWQpOw0KPj4+ICAg
ICAgICAgIG5vdGlmeV9jcHVfc3RhcnRpbmcoY3Vycl9jcHVpZCk7DQo+Pj4gICAgICAgICAgbnVt
YV9hZGRfY3B1KGN1cnJfY3B1aWQpOw0KPj4+ICAgICAgICAgIHVwZGF0ZV9zaWJsaW5nc19tYXNr
cyhjdXJyX2NwdWlkKTsNCj4+PiBkaWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9rZXJuZWwvdG9wb2xv
Z3kuYyBiL2FyY2gvcmlzY3Yva2VybmVsL3RvcG9sb2d5LmMNCj4+PiBuZXcgZmlsZSBtb2RlIDEw
MDY0NA0KPj4+IGluZGV4IDAwMDAwMDAwMDAwMC4uZGI3Mjg2MmJkNWI1DQo+Pj4gLS0tIC9kZXYv
bnVsbA0KPj4+ICsrKyBiL2FyY2gvcmlzY3Yva2VybmVsL3RvcG9sb2d5LmMNCj4+PiBAQCAtMCww
ICsxLDMyIEBADQo+Pj4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9ubHkN
Cj4+PiArLyoNCj4+PiArICogQ29weXJpZ2h0IChjKSAyMDIyIE1pY3JvY2hpcCBUZWNobm9sb2d5
IEluYy4gYW5kIGl0cyBzdWJzaWRpYXJpZXMNCj4+PiArICoNCj4+PiArICogQmFzZWQgb24gdGhl
IGFybTY0IHZlcnNpb24sIHdoaWNoIHdhcyBpbiB0dXJuIGJhc2VkIG9uIGFybTMyLCB3aGljaCB3
YXMNCj4+PiArICogdWx0aW1hdGVseSBiYXNlZCBvbiBzaCdzLg0KPj4+ICsgKiBUaGUgYXJtNjQg
dmVyc2lvbiB3YXMgbGlzdGVkIGFzOg0KPj4+ICsgKiBDb3B5cmlnaHQgKEMpIDIwMTEsMjAxMywy
MDE0IExpbmFybyBMaW1pdGVkLg0KPj4+ICsgKi8NCj4+PiArDQo+Pj4gKyNpbmNsdWRlIDxsaW51
eC9hcmNoX3RvcG9sb2d5Lmg+DQo+Pj4gKyNpbmNsdWRlIDxsaW51eC90b3BvbG9neS5oPg0KPj4+
ICsjaW5jbHVkZSA8YXNtL3RvcG9sb2d5Lmg+DQo+Pj4gKw0KPj4+ICt2b2lkIHN0b3JlX2NwdV90
b3BvbG9neSh1bnNpZ25lZCBpbnQgY3B1aWQpDQo+Pj4gK3sNCj4+PiArICAgICAgIHN0cnVjdCBj
cHVfdG9wb2xvZ3kgKmNwdWlkX3RvcG8gPSAmY3B1X3RvcG9sb2d5W2NwdWlkXTsNCj4+PiArDQo+
Pj4gKyAgICAgICBpZiAoY3B1aWRfdG9wby0+cGFja2FnZV9pZCAhPSAtMSkNCj4+PiArICAgICAg
ICAgICAgICAgZ290byB0b3BvbG9neV9wb3B1bGF0ZWQ7DQo+Pj4gKw0KPj4+ICsgICAgICAgY3B1
aWRfdG9wby0+dGhyZWFkX2lkID0gLTE7DQo+Pj4gKyAgICAgICBjcHVpZF90b3BvLT5jb3JlX2lk
ID0gY3B1aWQ7DQo+Pj4gKyAgICAgICBjcHVpZF90b3BvLT5wYWNrYWdlX2lkID0gY3B1X3RvX25v
ZGUoY3B1aWQpOw0KPj4+ICsNCj4+PiArICAgICAgIHByX2RlYnVnKCJDUFUldTogcGFja2FnZSAl
ZCBjb3JlICVkIHRocmVhZCAlZFxuIiwNCj4+PiArICAgICAgICAgICAgICAgIGNwdWlkLCBjcHVp
ZF90b3BvLT5wYWNrYWdlX2lkLCBjcHVpZF90b3BvLT5jb3JlX2lkLA0KPj4+ICsgICAgICAgICAg
ICAgICAgY3B1aWRfdG9wby0+dGhyZWFkX2lkKTsNCj4+PiArDQo+Pj4gK3RvcG9sb2d5X3BvcHVs
YXRlZDoNCj4+PiArICAgICAgIHVwZGF0ZV9zaWJsaW5nc19tYXNrcyhjcHVpZCk7DQo+Pj4gK30N
Cj4+Pg0KPj4NCj4+IFRoaXMgZnVuY3Rpb24gaXMgcHJldHR5IG11Y2ggdGhlIHNhbWUgYXMgdGhl
IGFybTY0IG9uZSBleGNlcHQgdGhlDQo+PiBVUC9tcGlkciBjaGVjay4NCj4+IENhbiB3ZSBtb3Zl
IHRoaXMgdG8gdGhlIGNvbW1vbiBjb2RlIGFzIHdlbGwgPw0KPj4NCj4gDQo+IFdoaWxlIEkgY29t
cGxldGVseSBhZ3JlZSB3aXRoIHRoZSBpZGVhLCBub3Qgc3VyZSBpZiB0aGF0IG1ha2VzIGJhY2tw
b3J0cw0KPiAoaWYgcmVxdWlyZWQpIGFueSBkaWZmaWN1bHQuIElmIHNvLCBJIHdvdWxkIHJhdGhl
ciBrZWVwIHRoaXMgd2F5IGZvciBhDQo+IHJlbGVhc2UgYW5kIHRoZW4gbW92ZSBib3RoIHRvIHRo
ZSBjb21tb24gcGxhY2UgaW4gYXJjaF90b3BvbG9neS4NCg0KWWVhaCwgdGhhdCBzZWVtcyBsaWtl
IGEgZ29vZCBpZGVhLiBJJ2xsIGxldCB0aGlzIHBhdGNoIGp1c3QgdG91Y2gNClJJU0MtViBmb3Ig
dGhlIHNha2Ugb2YgYmFja3BvcnRpbmcgJiBjcmVhdGUgYSBzZWNvbmQgcGF0Y2ggdG8gbW92ZQ0K
dG8gYSBjb21tb24gaW1wbGVtZW50YXRpb24uDQoNClNpbmNlIEkndmUgbm90IG1vZGlmaWVkIGFu
eSByZWFsIGFyY2ggY29kZSBiZWZvcmUsIEknZCByYXRoZXIgbWFrZQ0KdGhhdCBhIHNlcGFyYXRl
IHBhdGNoL3NlcmllcyB0b28gZm9yIHRoZSBzYWtlIG9mIGdldHRpbmcgdGhpcw0KcGF0Y2ggYXBw
bGllZCBhcyBhIHY1LjE5LXJjKGxhdGUpIGZpeC4NCg==
