Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B0C54B073
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 14:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236926AbiFNMTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 08:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242758AbiFNMRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 08:17:04 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5301A058;
        Tue, 14 Jun 2022 05:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1655209020; x=1686745020;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=gH+fHnfUdFk7cBn1iiWeL9FdTR89BmpsTbFf887In9I=;
  b=fdrkwfwbjMVZLcyIC2rGMdWaw3JGX2RduXzYVmwZpU17YQ95P3eGfz3S
   NAn9maNOhe40NlbxtNDgdOW9Zp8UjbVuKKjGNiSE392c7on9WaC7NWL2Q
   N/QR+HHJhWszpn2RWPaas2uun2kjVFukl28itrn/7/ZphrGNM6cD3nCdq
   YlILNLRMXE+uVrCJdohyaRxseCOCaaHtRmEaAVvM3WjEzBXW15NZChn8C
   HWXMncdjYzd8be5HLj5PjJf/ogtOFxG3Z7I80l/IdsVDLFSRXmvyR7OcF
   kaISsIKqc+hFyKed51oYbYlzUGWaHcoSCkpWdEV5nP6b4vLCR0pR3exiP
   g==;
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="163268273"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Jun 2022 05:16:59 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 14 Jun 2022 05:16:59 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Tue, 14 Jun 2022 05:16:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A2fC76bSUxh/VddrSWr6Mp+PfeHUp262HZYb3PlsXD8022l/vmv/jMk1GbHfRI/VwXnQMtrckqTcmV+Yx6MFXvzZS7b9+hFLZ2yNv0WYBtAAdzuEqppOaRqO/WY/xqmd2rwUqvMJT3LJ7ncEfUw/QinD5hFGHuCzixo5V2UKEvTSFI0Ym6i6Kx7vfjLnMX8vnRfbjFXYbifqRdFAlXNLQnueNclraOHPoDfvUc+CtHBUDeQ1RAIbKs2mzeRbzcpzioZ7Nsn16jOEdRYqv1rI2a8cYHmmIgeESBKcBIqSOcZZV2PoEdhC6Y/Rf9HROZF8h+5OgzJdLu8yvrFINR1bnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gH+fHnfUdFk7cBn1iiWeL9FdTR89BmpsTbFf887In9I=;
 b=Ut0kQI/1BT8vFXFtNVrjR9dNv3hR/82nSUMgRN8P8frQDfFcYf+QKQe074JY9W+0McpjWkweko0vhDioxRpRoSlTYcZaM0is5IfCqxEMKTkEKoj+YeJa3+qwJknN/m2cCcWbmZJ+5buOL3A09PX1L7hcIBU0u8AgSJlhlCGJBZP8cQBE5uEKO6gLPIhe6pxQx2SP9Dr5QVDyXC3h2/6CAOLRAbSkRFm9wQPCWIfKsnahFviWKMWXrRW8wlyIIW8F9h4YJxSwQ4mR/xI7tPHZvszIiJrTAoNtxfOYXZNmsMnswwuUESW/OuCv1qS6pkSXIztKLoJEpanS5oFJ3/VfEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gH+fHnfUdFk7cBn1iiWeL9FdTR89BmpsTbFf887In9I=;
 b=Lpa4H3JlmYj+W00yJI3z5JhRYqSNokCI2LX8cZUlA9Qodj99T4d1vSI4uIQ6wWcS2BDEhOvHly4WOKgWsdgQTvuAEnNXaGGST5nCUwTc2sfzA7trkxNlpSgJV6b0WhCx7ubeldj8v75fpxPqRvvjxpKufo1hQGT1Mr+zboI4rKs=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DM5PR11MB1308.namprd11.prod.outlook.com (2603:10b6:3:e::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.13; Tue, 14 Jun 2022 12:16:48 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa%4]) with mapi id 15.20.5332.022; Tue, 14 Jun 2022
 12:16:48 +0000
From:   <Conor.Dooley@microchip.com>
To:     <u.kleine-koenig@pengutronix.de>
CC:     <lkp@intel.com>, <thierry.reding@gmail.com>,
        <lee.jones@linaro.org>, <kbuild-all@lists.01.org>,
        <Daire.McNamara@microchip.com>, <linux-kernel@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v2 1/2] pwm: add microchip soft ip corePWM driver
Thread-Topic: [PATCH v2 1/2] pwm: add microchip soft ip corePWM driver
Thread-Index: AQHYfxeRlKP8nH9DZkyscP+LOLkrSK1Os++AgAAB+oCAABwjAIAAAJQA
Date:   Tue, 14 Jun 2022 12:16:48 +0000
Message-ID: <d0214a9b-a810-963a-3a37-a222f59b5551@microchip.com>
References: <20220613111759.1550578-2-conor.dooley@microchip.com>
 <202206141813.qgogbMAN-lkp@intel.com>
 <63334bed-17ba-fed5-9463-9fd52fd57351@microchip.com>
 <20220614121312.hfotzvx76i4fda6e@pengutronix.de>
In-Reply-To: <20220614121312.hfotzvx76i4fda6e@pengutronix.de>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c4f8dde3-ff9c-46ba-450f-08da4dffc18f
x-ms-traffictypediagnostic: DM5PR11MB1308:EE_
x-microsoft-antispam-prvs: <DM5PR11MB1308B80527341DCC07A18B8098AA9@DM5PR11MB1308.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xaaz/ZH99MpwI9ORMScvMZkedmqMaRpM1PYgys/uaDCao6ecy7e1P1NYliAoRz9M2FBSO/ReZ4wcJP/ppKSWSWtD70sJHgOtNXjTRX7/TimGXTvlnM1RmgGTKESCgZR/DoetHvlxgg0rYYN3oiEGmY6XtDxzf0GWIKDx6iXWQccDrDFNSMcjelbHF1mTFlnFbdSgoW3rNPJWOBWzPbdoLAaiofAgz9sn1/gGz6RttodTV+vOnasnAwG2EizOUsKKe4s6m0T4VklpohgeUKxMz/aBju3IvX3tcsEilD0Q/bqGmUTfDx8hhAxibDoIlIVqDTX7g82Ms667NyfN3xyLMBnsrCUNk3CvDvKTefbaG/1pMXXRTfpSYMUSdORcL0dCsmmHZUJSK8zPHwuiXyPVW9XRxIQbHwioTsOWZfWblmpFZ5F9X8JBvHifAEqgTOLhMfoktJdEf9k2/l0YzseDTEFVgHEeZtRuqa+z4a08bm94CEecI09iu2FgzC/PSo1X5TA4CMJlQP3NVYH7WXdKrcX5uFiR9YRYqAEEIpA7OD7SMFF8QPCAr8K1aGfHARG2xfZRCz6BL1I7bwsF3TSkqhdRzndgKdx5eBVZ5v0KhKWwL4GmO0qgKDEGmgmeJP42anl9EARIvxiHLFxxHH6Mx4Myb5QHnWi9xfrn9fM4KIKftMEU9Vx12qsDDvBQRoIv7FKjoH/lv6dIytX/BCEIYYUUJ3z5TgURlaRYXjNc1NPD37BdurWD602QrxXA66iDX6gBqrQU3YD+wjZOJ3JScg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(66946007)(66476007)(66556008)(31686004)(76116006)(6506007)(53546011)(86362001)(8936002)(6916009)(54906003)(36756003)(66574015)(71200400001)(4326008)(508600001)(64756008)(91956017)(66446008)(8676002)(186003)(38070700005)(316002)(122000001)(4744005)(5660300002)(2906002)(6512007)(31696002)(26005)(6486002)(38100700002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WmNPeFhqU0VnWFR4TFd6RmIrVERJdjVFM1BaQkVKQ0kxRGF6K0lmM3NBQ3JH?=
 =?utf-8?B?ZGRoQTVXMEI3SkhaejFzLzRlL2RHRmNleGlVZXFJN3d1cjhIaGxDSUpseHpU?=
 =?utf-8?B?aXd1WWpPWW5wVCtBYzBVSWZ3VFdVYW80UGo3SjVzWFFuTDEvNjFLQ1VHVEFY?=
 =?utf-8?B?TnhqRng2ZEtuMWs3K2ZrU3U2dEFzQU94YXZWZ1pzcUhRdVZpQlhBd2lzZlZx?=
 =?utf-8?B?ckpSZExCUkFjbkZtMmsxdERnSVRzdVk5SkdMaFplN1dqeTFpVHNCbWx1c0Zp?=
 =?utf-8?B?dDRJZ2Z6VklHVjViQjhSSzRHNkYrZGcrOXVzZ09HQXFPdzJXeXMxblBKbVYv?=
 =?utf-8?B?dksvbUF3TnRaTHBGQ2Q4M29TeFR6NE1JbjNRSXVVVGQvOWxac1h6K084b01u?=
 =?utf-8?B?L0Fxd2dyTDBlOHFJUlNVQ0VWMmpaUW5pZTR4RnpSSG04bnVjRjlGOURJN3Rn?=
 =?utf-8?B?VXhVMk4wRGt5YkRiN3U0b0hjMWpOSTV2dFJsOThscGk1eTIyd2tESGp6QzIx?=
 =?utf-8?B?MmpHZTRtU2RheG5PekJWMUlmMVJLVTF2aC8yMW9BTDhlUW0yVExnd1hHeXdt?=
 =?utf-8?B?QnZnQlQ3UllPa0hROGo0NmhJRlY2eGhuZUtxSkNoQWlxZTh2MTROOCtldDR1?=
 =?utf-8?B?Y2dDMDhTS1JRaEVvNE94bXFML2NocXp5dHkzUGljZDNNTWpYallKdFk2MFIr?=
 =?utf-8?B?VEdsTU9UWXI2elQwU0liL1Q0am1HeWt0aXlOM09PMGNyYWdGS3NJa0lMbzJh?=
 =?utf-8?B?TjdrelRpb3RZTFFuWDBlejRpMy9MOUxuaDArSURNQjF6ZXdFdWV4SXpFVUli?=
 =?utf-8?B?L21RUmVKT3hsY2dRWSs0Zno1c3AvK2FJeDZubkVoZ0lSM0FhRUpaRWFlZTIr?=
 =?utf-8?B?eWptQzNtcFZwdHFra01oYjYxeGUrUUdZK2hlRVAweXJTNXRyMms4N0o1MXZn?=
 =?utf-8?B?U0pBb2k1K3Z3bkJqdmxDYTdldmVnWmMwMm5oNkRucE9rYy8rQ0x1aWo2Zytq?=
 =?utf-8?B?MkJpNkQ5bXZqMGtWWkRIcUl4TVo4ZCtHU2J1TGRGRWFYanNCOUxzS0pNNlJ3?=
 =?utf-8?B?eER0VTdtcFk0NXpUcUs1Q2toOTZuMWd0UnBTNmtyMzVlYVpsbXVxbnJwYW1P?=
 =?utf-8?B?Q3JDeVlsbmhHZFFZOHBqVU5PdE5DRmp0UG0vT21HK0N0V0ZQdjF5VmZUbkRX?=
 =?utf-8?B?TUN6dVQ0aHluS0d4ZUJTSngvOTdGSVpiK2N2WDBOa2JDUTgveFRmUktxV0ds?=
 =?utf-8?B?SkpkNURqYi9iVHArUEo0NThyRklBbjVyQTlzK2NNaTVmWkxhRytkcmczUG9G?=
 =?utf-8?B?WjRUVUV2aUhpWTlUSmNsd1NJVHY2Rk52TGVjeFFJdVRud2hhelBnaDZnUWNy?=
 =?utf-8?B?UnBXV29TYzdaRVJBZ2tpTE1XVEJJZGZuVkt5UkVhN3hjMUxxMDVsb2tHT2lH?=
 =?utf-8?B?UEJwZThxbVNiZmljTU1saU1PalovcXUyRlhzaVVIbjJ6VEpCVHY0OTQ5RzdO?=
 =?utf-8?B?V3NpMUhCM2lCZXE4RU94Wld3elliSm1Fb05wQ3lkZXFRYU0wWW5hbk5CQzJk?=
 =?utf-8?B?REVjcmZtVC9qWThHanNyeUhLY1JlZk8xeXBCRE5LMy93OVZ1ekQ3VDFCU080?=
 =?utf-8?B?MU5tVUYwcmNPRjYyRTlRSExVUjJtZS9kQ1FqZVFkeWNJVUxvSG9Oay9JV2w4?=
 =?utf-8?B?WDc3clFhOUxxcDdTcFhjY0lITGI1OU9QNitPMThIMUhUZ2RqZjk2Tk5pYmtD?=
 =?utf-8?B?S0YzSXV0em1saFBTYVVRazR1bUJQRDBybFVoQ0k5aUZMYXlqTksyYTJFUlZn?=
 =?utf-8?B?Zmx6NmN3UWxNK0ZwQU1IWlhqOG9oRnJ2Y1VmcFB0WTdmSmZpb3I3KzYwekhJ?=
 =?utf-8?B?VC9KbVI1NW4yWExwN01RbDY3Q0RBN0ljZThFN2ZPTzZZaWZKa1ozT0NscERa?=
 =?utf-8?B?Si9KYWFIK1U0MlVGV09yemVKVmg5azJmRS9GSXF0RXpxQ05wUVJzYXlHcjNO?=
 =?utf-8?B?UVZTWFFyaTFkM0Z1VTZTR1RtMTVuZHBRUmthbU1veUE1UjVuRk93YittdUJZ?=
 =?utf-8?B?VzVOM1laZFNYTHc0R1ZtR1lYYWZXZStCVjNvenhjWE54YTl5aG5nVmJKNzZa?=
 =?utf-8?B?OTViSGRLRE9pb0ZLZE91T25IekVEMFN2Vng0ajJpeWJOdnBoQUZRcm9jYlEz?=
 =?utf-8?B?UzFBdnh2cHAxUCtTVG1xT3R2eWplNW9WcTVjUUdsckdIbmpVQnNrTUVoR2M3?=
 =?utf-8?B?VVRxYW1VNURvczFWb2EvZ2VnMk9IY0VQUDBGWG9RTnJKeGdoZE5MUmtaSDFV?=
 =?utf-8?B?ZkRiOHkvTWJqdFZTWG14NllWc1R1MENhWkQ5eGwydVk5TXRFTFgrQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <22A21BB08C1A0143A5BCEC45F52B7F2D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4f8dde3-ff9c-46ba-450f-08da4dffc18f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2022 12:16:48.5581
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6yf+k+bXarmRisuzBd5++ta0iLgKbSLKaB+dSpny6LqpEci0ZP4eL6fwl1nN4AShPb7T3XLyRtWJUhKj1jknF4JjWqlIRALigCJykihRdAA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1308
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTQvMDYvMjAyMiAxMzoxMywgVXdlIEtsZWluZS1Lw7ZuaWcgd3JvdGU6DQo+IE9uIFR1ZSwg
SnVuIDE0LCAyMDIyIGF0IDEwOjM0OjAwQU0gKzAwMDAsIENvbm9yLkRvb2xleUBtaWNyb2NoaXAu
Y29tIHdyb3RlOg0KPj4+ICAgICAgeHRlbnNhLWxpbnV4LWxkOiBkcml2ZXJzL3B3bS9wd20tbWlj
cm9jaGlwLWNvcmUubzogaW4gZnVuY3Rpb24gYG1jaHBfY29yZV9wd21fZW5hYmxlLmlzcmEuMCc6
DQo+Pj4+PiBwd20tbWljcm9jaGlwLWNvcmUuYzooLnRleHQrMHgzODApOiB1bmRlZmluZWQgcmVm
ZXJlbmNlIHRvIGBfX3VkaXZkaTMnDQo+Pj4gICAgICB4dGVuc2EtbGludXgtbGQ6IGRyaXZlcnMv
cHdtL3B3bS1taWNyb2NoaXAtY29yZS5vOiBpbiBmdW5jdGlvbiBgbWNocF9jb3JlX3B3bV9hcHBs
eSc6DQo+Pj4gICAgICBwd20tbWljcm9jaGlwLWNvcmUuYzooLnRleHQrMHg1ODYpOiB1bmRlZmlu
ZWQgcmVmZXJlbmNlIHRvIGBfX3VkaXZkaTMnDQo+Pg0KPj4gSSBhc3N1bWUgdGhpcyBpcyBtZSB1
c2luZyBmdW5jdGlvbnMgdGhhdCBhcmUgb25seSBkZWZpbmVkIGZvciA2NCBiaXQuLi4NCj4gDQo+
IFRoaXMgaXMgdXN1YWxseSBhIGRpdmlzaW9uIHdpdGggdmFyaWFibGVzID4gaW50Lg0KDQpBeWUs
IHdoaWNoIEkgbm93IGhhdmUgLSBoZW5jZSB0aGUgZGl2NjRfdTY0KCkuDQpUaGFua3MsIEknbGwg
Z28gZGlnZ2luZyBmb3IgYSBmaXggOikNCkNvbm9yLg0KDQo=
