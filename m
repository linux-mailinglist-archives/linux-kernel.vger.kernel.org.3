Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 333E5570878
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 18:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbiGKQjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 12:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiGKQjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 12:39:09 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DBF11825
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 09:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657557545; x=1689093545;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=AqFPDjfvu5M8TkAppUoVNMK7mOApJrEOJoh5v5juUo4=;
  b=UR2/6c7SlEBIAJfF7+JSCgFY3G3923blRTJLnPJvXWPXREO6JL5iypyR
   G2GUQkcsNSVOfNAJXr3lLmsGYm8ZQNl6rpgc/bIJMd5gdT4aktwGZtt/3
   rx5npfBGzFnzrPYfySG2OSftDA616GsJvIC6S/9s5wfIOpJ5qBwVH1JFP
   b6hOQMJlpD9B9oa9mVw+G3Vjx6V/+w2y5IM4rT+MlLeQT4OJbb73FhUEa
   ugU6uYosejhftL7MNJL4wfz5aepXTzgTJQpA83zt5kv8SBRJfjBwX6yIg
   kyLSp/6sexn/I236XXFKiunDny8M9LXCqs5LPdHKprwBmWIvBQyM71Ey9
   w==;
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="167313986"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Jul 2022 09:39:03 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 11 Jul 2022 09:39:03 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Mon, 11 Jul 2022 09:39:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l57TAqwcTwcKqhutKIV4kiPLxnjoS0VqKiPtu1B9EA48mSrNEmOQCE4jtboNF4t7rAI651ZqWXMKdE+yXiANMHsRG2SL8tbc68quf1VzXQTnhm/A5sPNVJ9hpM13oNbxOWTSg7AwIeOGeBtw3GQdqbs2sq4dwmNxWwlva0OI5NcXmEPc4J9/mqcZvbiaa45DgWuEwFJ2ZcVMj76ERpCTJ9Lh//QKqiizJfRDZfXO4wL2pAg58D6Gs3IW0I1q44bMxuqfwCoyrx/O8b8k4jH3D+YkjNFyqrOMY9cSEOpyE7WRVdlp46daUZUbqUnwwvzLl+sMWVGDeaIIlB8V98rjiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AqFPDjfvu5M8TkAppUoVNMK7mOApJrEOJoh5v5juUo4=;
 b=clKl9R3fRLDgSoCU6ZQRP4wryPlNEtcM6L1urR1GzMWAKasmPhmynBsiCuDQUZFHpqbj+I7TGa6OzcqDxd8PGcI+SBqBQB7ev70bjRDhDyyWIARBb2fg8FR0VkuJIh/ayELEEld3Yie3NsD6tznLl6AknPcPKqEB/vx8EnvZh2cwjqloPT0h93OSaq9TUdwWHmV6OshF/pTzI51nG60ytKTnwAqJgmjwBwXNxbJHqUlTnlHn/MDxPgOuAXkvNUKrqkCiFzg9U6ZvNI5bSGBNIrSbisoMF6YGf1B7HtDcmAU8j/HG/Na3YFFKy28ZnLoJLJhjtmvyClJUqiNJzRQfRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AqFPDjfvu5M8TkAppUoVNMK7mOApJrEOJoh5v5juUo4=;
 b=OWDwbqU8g3LV5SrrOrwZ5F8GV5IXgoixloeWXRsYFglU04EtzFn9KMMSYCn/FdS/MqaEBUvA3bqTTIx+vRKpop8JPyKZvOHELgLdOQmDHCFSjzf6n5pOyVa9sDDsGYwge4Gc30bYGk30/dE3BFYUd0kKCBBcrPIKDoajsIgs4Ls=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by BN9PR11MB5419.namprd11.prod.outlook.com (2603:10b6:408:100::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15; Mon, 11 Jul
 2022 16:39:02 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::8d4a:1681:398d:9714]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::8d4a:1681:398d:9714%5]) with mapi id 15.20.5417.026; Mon, 11 Jul 2022
 16:39:01 +0000
From:   <Conor.Dooley@microchip.com>
To:     <sudeep.holla@arm.com>, <gregkh@linuxfoundation.org>
CC:     <mail@conchuod.ie>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <palmer@rivosinc.com>,
        <aou@eecs.berkeley.edu>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <rafael@kernel.org>,
        <Daire.McNamara@microchip.com>, <niklas.cassel@wdc.com>,
        <damien.lemoal@opensource.wdc.com>, <geert@linux-m68k.org>,
        <zong.li@sifive.com>, <kernel@esmil.dk>, <hahnjo@hahnjo.de>,
        <guoren@kernel.org>, <anup@brainfault.org>,
        <atishp@atishpatra.org>, <heiko@sntech.de>,
        <philipp.tomsich@vrull.eu>, <robh@kernel.org>, <maz@kernel.org>,
        <viresh.kumar@linaro.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <Brice.Goglin@inria.fr>
Subject: Re: [PATCH v3 1/2] arm64: topology: move store_cpu_topology() to
 shared code
Thread-Topic: [PATCH v3 1/2] arm64: topology: move store_cpu_topology() to
 shared code
Thread-Index: AQHYk6gfzH8Gm/oezEiLI9n9NQ0uc615P64AgAAELACAAAlugIAAFNqA
Date:   Mon, 11 Jul 2022 16:39:01 +0000
Message-ID: <4090fbfa-648c-5299-d3db-01efd2ebc62b@microchip.com>
References: <20220709152354.2856586-1-mail@conchuod.ie>
 <20220709152354.2856586-2-mail@conchuod.ie>
 <20220711143542.nlq6a5nuh4nouomo@bogus> <Ysw4voXuz+tcSKhf@kroah.com>
 <20220711152423.djfqk6wbhmrshbkr@bogus>
In-Reply-To: <20220711152423.djfqk6wbhmrshbkr@bogus>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f3ace61e-e3bd-42e0-7af2-08da635bdc75
x-ms-traffictypediagnostic: BN9PR11MB5419:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LyEJf4TFb66FWXQ6xB44CrLOaxUJg4s7ShPKUuGTY6BnaQL6qUXn+o28L9cOW6gr3JNIgeyY05YK/g8Ov//CLX/xNn0+PqIS7wvLosHnf2dEIJLn+/ruVj1mGuBKsTfsHGKL7FCB1A79S4G+C74arftqJSjHvVjLmXrFAkGj415rG04+Sf+O9zFjWuricMlmP3oUz0zbmOOe+kE58dS+Afvm0ndylUSTNTQu1xlyToFrmFUwCQ5aEnuvJCEpUeX73ZxqW/bzoIMvAs2EGTG3mNsnSLKiCduB1mRKgUNmye8xtlbtN7plWF+i0zmMOsJNt3/OjTyGxQXHGGNI6U0WVbX+26xWLUZoknfdShtLhBAQxurGp5/vE2kfo71A2l+ugfzOBqXkyCyd0x9JFitjPSaKqo6Tr70U7OY6HYkM8q7GONzXybRXwoFwpw03pOXisM9xzip8OEHdURKnEcwdZzzVXD1Nvwd+wVsFVXwNbL+G6KrEvpLO0A6woXZRonTtIUKtbAj8HZb0wii7BxLC4YgrqnEbp3Gb5o5UJZxFrsHbzZuVcnyVRh6zzl3BqnSqYulO7it9erHxwnNmypaEsv4SUo6lxsEnt0lQo8ZY+Smhl6jEIdO2+/ck/MSQ1hXnyS3BO7Crp9Un87gDnXSWfhICXhD4w6a1QajRZxLmHKm08fH3A9eoQscIBFRa3H1/xeHGwdHqmbcgudJis8PU7FwkDgd1x60ONre0bFgSOnRpsgBKbx0e8Lnu4pz7fLuyJGAZ2In/oCRfnLl4DhZgbatuP2iCOJficpJSA0wI0GyJKPZwfit7XdhTOlboTM+0gJNoPdgsIFfQHRHVDhWVVbBsc5o4hqIUawgsd8qruZf8tCPpLl2tPtxXGP2uoKWN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(39860400002)(136003)(366004)(396003)(478600001)(31686004)(6486002)(71200400001)(64756008)(41300700001)(4326008)(8676002)(66446008)(36756003)(5660300002)(7416002)(316002)(110136005)(54906003)(8936002)(76116006)(66556008)(66946007)(66476007)(91956017)(53546011)(2616005)(26005)(186003)(6512007)(122000001)(38070700005)(38100700002)(6506007)(2906002)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NUQzKytCR2dMT1lYMHNYc3FkejkyYVQxQ214WE1TdjU0dGNxQjJIQ3FtdEFC?=
 =?utf-8?B?TFpMcWZBS0pMazFkbE0xOGlWMVJYdHBkRGR0R0hnK0lxSVU1dWYvOW4rNzBF?=
 =?utf-8?B?RUFqNE9Cam0zM1VTV1BpY1NVTVI2VWpxWG1VcjFwY3ltYk9RS1lUUTREL2lm?=
 =?utf-8?B?blZTRzVackNxcHN5dUhzbHlBWitqcUlseS9hbEVtY1RZNnNpSU5xbm1YZkFF?=
 =?utf-8?B?YjFKZDU5T2dXVkFTMGlmN29ZYmFhL1phdjhSUksyaGFwY3NPL21pcW1zejhO?=
 =?utf-8?B?VlFzWVdiMUUxWVVlbmhxSDg4UVN5Q09XM1hTYlJBUlp3V2pBNmFIYldpeUJn?=
 =?utf-8?B?blVLTndoMjRScndQQlh3Yjg3Rmh2UzNtckk3VkVWWWRRWm14bk9KdDdON0ZJ?=
 =?utf-8?B?d1BlWUpOK2RITmZZd3liZUhUcEhLR2lVSUZUWXM2ZjRjaHgxU3FmOUFyYVBP?=
 =?utf-8?B?UzZpUXdGZHl3R21kMEN4ZGFobEl3Zk9yVUpwaFVTRmxYbUlHaDlwQTJwbDVt?=
 =?utf-8?B?ZmFwTW84SjFVOVlEdklzeHdQc1JhYnYyQVJlNHpNMU5IMmZhc3RaM255RnlQ?=
 =?utf-8?B?b2k3bmY1LzNRUXZMc3A5alR0UXMyY0VycWtOSHd6QXljVTBkdlJRWCtISEll?=
 =?utf-8?B?cEptL250MzBvMkM5TlBPOVpocndSY0FHMjIrRVVwTVJvTEFpcTJuTWg1YXRp?=
 =?utf-8?B?a3RSOWxUbFc4ZGdjNmxTREkweFJUUi9NS1ZxUlloY2l2bHc3cXd5RDBydzhw?=
 =?utf-8?B?bklXbDdrY0RRSXpYTVVWd1pCMW1EanZYWkhpeUk1T1VwZ1g4VE5rbHlhT3Jy?=
 =?utf-8?B?L0xwVlJMY2c1bU5ITEF0Nkc2aSs0OVJVQkc3Z3FoSCtlaGJlc0V2NDZUSzc1?=
 =?utf-8?B?cVUwVldiMEt2R0Z2QTltVGdFSUYraVphNmdZWXlvdHA5ZSs0T29pTHB5WDFZ?=
 =?utf-8?B?THZRc2ZjVVBQdHpZTnBCRWR6dUJqTkhhQnc1ZDFMUzhGa0tOd2FDUHNYYzZj?=
 =?utf-8?B?TFBTM2VWaU53ZGF3aUVZZDA0S0VCZUlodkI5Vkg0MC9BUE5KT2xRYmY0a2FK?=
 =?utf-8?B?L1d4d0thaEpkdExVbXRXcUwrZFpVNFVIMkg2MlBtRFpBRnh4b0k4QktNSm5V?=
 =?utf-8?B?N2NtZnhPbG5UaXF6ZCtuZjI2Z1ZYdVlLR1JtR3R3b0ZKK2ovRWVaa1FjbVhh?=
 =?utf-8?B?anhUdEp5LzVBUnh0Zk1pRE1qQUNxR1kxRUIyMnltWTQ2TDg0N1NTMG53YmtF?=
 =?utf-8?B?UTRycTcvZkpQVlMxL0M2akZJY0dTb2dpNFQrR3Jkb1ZpajBmMUlWTEVraGxi?=
 =?utf-8?B?ZUVvQUpuS041Rk9QUzV4OTV4VXNZb0RQdEViaThCcXpzR2toZVpnSm1uTkhw?=
 =?utf-8?B?QllvR0g2ekx4RnkvZklCQzcvalpVUUZScGZ4SHhnMTNxalpTcmdoblhvcTR2?=
 =?utf-8?B?MENtL3E3clhOTExDZjZGaXRQWFNZczNmMUlpNWRQb0U1S25yRjJNMW50YmR0?=
 =?utf-8?B?U1BqZGdXSndXV3RyNVc1QTRTZE5QMEZIS2hGb0lwTTNsMkUxL3EwaFNld3RX?=
 =?utf-8?B?Mmkvck9EeXp4V2tQa05uaWZQVmp5T09WUlYvYTZnNXpJZHA5ZE0xN2Zkb21h?=
 =?utf-8?B?Z0NuR2hSNWJJMnRXMXhVY1RLZVZnZ3ptb0RteGdkNTdlK1pNeGhVbDRhRndU?=
 =?utf-8?B?MXU3Sk9kdnp5WFNRdmx5TkE3YkRIZUJkMS9LdXNkazFxMnA0RzkySDhQeU1q?=
 =?utf-8?B?VkpNdDB0ZGk0YnMrMnNlUS9GdHhJQXhOT0Z2dkplOWdCWFFYamNmS0VZRHRO?=
 =?utf-8?B?WXFyRnNxcThPaHVoaFZTcWtJUmZURElXSVZZWTBDc1l5MDRXVzBtUGFQVUo1?=
 =?utf-8?B?QUVtdWNTMUwvUWFrYy9XUCtYdWNuYk5kNFpFcGxEVmluUXFVUjlPTmpGelNh?=
 =?utf-8?B?VmtKdTdtTW5nNVpNbHc2UHdYOHNWRkdWSkJhZytZT3IwaUxkSnZXQUZRSlQx?=
 =?utf-8?B?TCt4MSt5aGl0Vk54bE0zdEFnZTVhY3RXR3JGaVpiSStUalB4NXB4MmwxTjhW?=
 =?utf-8?B?SDlycVIvYkd4clpEeEs3bkhlL201UlFiQUU0STgvd3ZST0wwYjBTNFRKVnBS?=
 =?utf-8?B?eDRVbGpQbkVzTGovb1ltMmJldGdYTThXNTFucDFDdHpZTVYxYzBWWTZReG1l?=
 =?utf-8?B?bFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C60D8DD620AF874890256C4F2D9FBDE9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3ace61e-e3bd-42e0-7af2-08da635bdc75
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2022 16:39:01.7738
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OTUAhDN2kW/192nL04bAxvFwagggS/jpYnSNc7O+0tiuBDRsKn9biYaEw4zy6aWf+oxh/48g/0CUIYhckdx6sFScrb2Sr21Z/tdGULvHlS4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5419
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvMDcvMjAyMiAxNjoyNCwgU3VkZWVwIEhvbGxhIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIE1vbiwgSnVsIDExLCAyMDIyIGF0IDA0OjUw
OjM4UE0gKzAyMDAsIEdyZWcgS3JvYWgtSGFydG1hbiB3cm90ZToNCj4+IE9uIE1vbiwgSnVsIDEx
LCAyMDIyIGF0IDAzOjM1OjQyUE0gKzAxMDAsIFN1ZGVlcCBIb2xsYSB3cm90ZToNCj4+PiBPbiBT
YXQsIEp1bCAwOSwgMjAyMiBhdCAwNDoyMzo1NFBNICswMTAwLCBDb25vciBEb29sZXkgd3JvdGU6
DQo+Pj4+IEZyb206IENvbm9yIERvb2xleSA8Y29ub3IuZG9vbGV5QG1pY3JvY2hpcC5jb20+DQo+
Pj4+DQo+Pj4+IGFybTY0J3MgbWV0aG9kIG9mIGRlZmluaW5nIGEgZGVmYXVsdCBjcHUgdG9wb2xv
Z3kgcmVxdWlyZXMgb25seSBtaW5pbWFsDQo+Pj4+IGNoYW5nZXMgdG8gYXBwbHkgdG8gUklTQy1W
IGFsc28uIFRoZSBjdXJyZW50IGFybTY0IGltcGxlbWVudGF0aW9uIGV4aXRzDQo+Pj4+IGVhcmx5
IGluIGEgdW5pcHJvY2Vzc29yIGNvbmZpZ3VyYXRpb24gYnkgcmVhZGluZyBNUElEUiAmIGNsYWlt
aW5nIHRoYXQNCj4+Pj4gdW5pcHJvY2Vzc29yIGNhbiByZWx5IG9uIHRoZSBkZWZhdWx0IHZhbHVl
cy4NCj4+Pj4NCj4+Pj4gVGhpcyBpcyBhcHBlYXJzIHRvIGJlIGEgaGFuZ292ZXIgZnJvbSBwcmlv
ciB0byAnMzEwMmJjMGU2YWM3ICgiYXJtNjQ6DQo+Pj4+IHRvcG9sb2d5OiBTdG9wIHVzaW5nIE1Q
SURSIGZvciB0b3BvbG9neSBpbmZvcm1hdGlvbiIpJywgYmVjYXVzZSB0aGUNCj4+Pj4gY3VycmVu
dCBjb2RlIGp1c3QgYXNzaWducyBkZWZhdWx0IHZhbHVlcyBmb3IgbXVsdGlwcm9jZXNzb3Igc3lz
dGVtcy4NCj4+Pj4NCj4+Pj4gV2l0aCB0aGUgTVBJRFIgcmVmZXJlbmNlcyByZW1vdmVkLCBzdG9y
ZV9jcHVfdG9wb2xneSgpIGNhbiBiZSBtb3ZlZCB0bw0KPj4+PiB0aGUgY29tbW9uIGFyY2hfdG9w
b2xvZ3kgY29kZS4NCj4+Pj4NCj4+Pg0KPj4+IExvb2tzIGdvb2QuIEZXSVcsDQo+Pj4NCj4+PiBS
ZXZpZXdlZC1ieTogU3VkZWVwIEhvbGxhIDxzdWRlZXAuaG9sbGFAYXJtLmNvbT4NCj4+Pg0KPj4+
PiBDQzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPj4+DQo+Pj4gSG93ZXZlciwgd2hpbGUgSSB1
bmRlcnN0YW5kIHRoZSByZWFzb24gd2h5IHRoaXMgaXMgbmVlZGVkIGluIHN0YWJsZSB0cmVlcw0K
Pj4+IGZvciBSSVNDLVYsIEkgYW0gbm90IHN1cmUgaWYgd2Ugd2FudCB0aGlzIGZvciBzdGFibGUg
dHJlZSBhdC1sZWFzdCBvbiBhcm02NC4NCj4+PiBJIGxlYXZlIHRoYXQgcGFydCB0byBHcmVnIGFu
ZCBXaWxsLg0KPj4NCj4+IFdoeSB3b3VsZCBpdCBiZSBnb29kIGZvciBvbmUgYXJjaCBidXQgYmFk
IGZvciBhbm90aGVyPw0KPiANCj4gTm90IHJlYWxseSBiYWQgYXMgc3VjaC4gSnVzdCBuZWVkcyB0
ZXN0aW5nIGFuZCBtdXN0IG5vdCBjaGFuZ2UgbXVjaCBpZGVhbGx5LA0KPiBidXQgaXQgcmVhbGx5
IGRlcGVuZHMgb24gd2hpY2ggc3RhYmxlIHRyZWVzIHdlIHdpbGwgdGFyZ2V0IGFuZCB3aGF0IGlz
IHRoZQ0KPiBvcmlnaW5hbCBzdGF0ZSB0aGVyZS4gQXMgbWVudGlvbmVkIGluIHRoZSBjb21taXQs
IHRoaXMgY2hhbmdlZCBhIGJpdCBhcm91bmQNCj4gdjUuOC85IG9uIGFybTY0IGFuZCBub3Qgc3Vy
ZSB3aGF0IGtlcm5lbHMgUklTQy1WIG5lZWRzIHRoaXMuIFRoZXJlIGNvdWxkDQo+IGJlIHNvbWUg
c3VycHJpc2VzIG9uIHNvbWUgQW5kcmlvZCBwbGF0Zm9ybXMgYnV0IHRoYXQgaXMgc29tZXRoaW5n
IHdlIGNhbg0KPiBsb29rIGF0IHdoZW4gaWYgYW5kIHdoZW4gdGhlcmUgYXJlIGNvbXBsYWludHMu
DQo+IA0KPiBJIGFtIGluIGdlbmVyYWwgbm90IHN1cmUgd2hhdCBpcyB0aGUgLXN0YWJsZSB0cmVl
IHJ1bGVzIGlzIHN1Y2ggc2l0dWF0aW9uIGFuZA0KPiBoZW5jZSBtYWRlIHRoZSBub2lzZSBzbyB0
aGF0IHdlIGFyZSBhd2FyZSB0aGF0IHdlIG1heSBuZWVkIG1vcmUgd29yayB0aGFuIGp1c3QNCj4g
YmFja3BvcnRpbmcgdGhpcyBwYXRjaC4gQWxzbyB0aGlzIGlzIGp1c3QgbXkgb3Bpbmlvbi4gSWYg
d2UgZGVjaWRlIHRvIGJhY2twb3J0DQo+IGVzcC4gdG8ga2VybmVscyBvbGRlciB0aGFuIHRoZSBv
bmUgY29udGFpbmluZyAzMTAyYmMwZTZhYzcsIHRoZW4gYXJtNjQgbWF5IG5lZWQNCj4gbW9yZSBj
aGFuZ2VzIG9yIHByb2JhYmx5IHdlIGNhbiBwdWxsIHRoYXQgY29tbWl0IGlmIHRoYXQgbWFrZXMg
aXQgZWFzaWVyLiBCYXNlZA0KPiBvbiB3aGF0IGlzIGRlY2lkZWQgYW5kIHdoYXQgYXJlIHRoZSB0
YXJnZXRlZCAtc3RhYmxlIHRyZWVzLCB3ZSBjYW4gZGlnIGRlZXBlci4NCg0KVGhlcmUncyBhbHdh
eXMgdGhlIG9wdGlvbiBvZiwgZm9yIHRoZSBvbGRlciBrZXJuZWxzLCBub3QgbWlncmF0aW5nIGFy
bTY0IGF0IGFsbA0KYW5kIGp1c3Qgd3JhcCBzdG9yZV9jcHVfdG9wbyB3aXRoICJpZiBSSVNDViIg
cmF0aGVyIHRoYW4gImlmIFJJU0NWIHx8IEFSTTY0Ii4NCg0K
