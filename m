Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1BD0547C69
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 23:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235996AbiFLVU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 17:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231941AbiFLVUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 17:20:20 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0FA82DE;
        Sun, 12 Jun 2022 14:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1655068817; x=1686604817;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=byRV1Sff0czwt3GqDLOnHrbOSohXKnVontZcAnwoQtU=;
  b=gNZh0sqraSn8EzisYp3fcoBthrhK6SS436xYy6qNaAiBhmSYYsJy+zJx
   RX7rxz5rXOPzneLWzX8I5Jau4OE4ZFuUlfV5gwWq5R+DAdOKGN7hZl5pf
   VauSgh2ugiyFimdW8rDJzriLzk/rZz+AxU26kZTaa//L6a0h+Esx2RORT
   BegNjVkzosMlKArwQMH+E6/b/7YX/xFLikz5VRWvy65RcVN+rMfJxDW1q
   qw0SHpduwAl0Av8lJYdrlrVPt+Qz5cmuVXaY5utBpKkiEZHp8dga98jzL
   7Woq0Xu/QtaTToej9J19n8wzoGbaDwOe/vo1gH0ewnE8tDJtR7U6cD2lm
   w==;
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="99668013"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Jun 2022 14:20:16 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Sun, 12 Jun 2022 14:20:15 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Sun, 12 Jun 2022 14:20:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=czl2nZY7OwTVBrCWAnkfUQxMlcIU6BJA8PYKBUe4Ngkr0TWCozonp6EOWkMhVgZ21sYIauE7zsNtItF4JCoTc6pcip/2p7GSN4BqphdNcU8pGLqLHdVadMxkgid+C68O/p7adGAkdaSwDHJP26ySjElsR4E8xFjDTopAU4cPlufNfOTkeVMkJWeE9//3B6OnpfGeHdZibhTvfl6qz8VXx9p6B7aPaiDji3xRRko6YMylrlR/wrKVdhu6ZnlaWaf85gfG8DPdD2zrAiWuybZm4CIA7YJV4PO9Br7PtT1ahzbYDiVd7XAU8a9vIYijS/RjBdg4pR+9kWLeOtk9V4g0Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=byRV1Sff0czwt3GqDLOnHrbOSohXKnVontZcAnwoQtU=;
 b=eIQgvQwNoWC4vfIQSCEKKrtlgndNDm2cfm1tRYtCoz/T1me5acV+LCRPj8gMJAsvP4b0WnKznRUxlknkrzK6Dm+IFJrewlgj/UAbQrH366av3IL6v7QwkswXuII9XHQORWzUfKjYMLEyu6srogIPomtf1m6cIbBVIByiAJZJmNsoMW6Cy8OI/pgSDtJd33kCT1zD0Foni7gZ5/CejIvOWy5PsRAU5RF7b+cCLyNaPHpvBNUjThljuUD30qiOqsSEg5Z9r0xqnmThgVGL/3mc7hR63pvCC+JZe88PvG6tKiAIYmIqoabOlhnf4iIYI7B8TqvetZSca7VTKgCylIyhxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=byRV1Sff0czwt3GqDLOnHrbOSohXKnVontZcAnwoQtU=;
 b=Us2HYAxeuJlrDmGNrdBW5rSqllcCZpmqsV2F4JnaTOsm2GRWG0Z7NIzMuHnaqJBie29BQSbzbU5WIF4Ry3na3MZOw/tgqGet/4P+ujZu6Cmq6Mhq5e5PoYmqE5z45CHPYb34YyxslS8n1gwjLaTiU5+JHV6urBdc467is65Fcxs=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by BN7PR11MB2627.namprd11.prod.outlook.com (2603:10b6:406:ae::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Sun, 12 Jun
 2022 21:20:10 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa%4]) with mapi id 15.20.5332.020; Sun, 12 Jun 2022
 21:20:10 +0000
From:   <Conor.Dooley@microchip.com>
To:     <u.kleine-koenig@pengutronix.de>, <Conor.Dooley@microchip.com>
CC:     <thierry.reding@gmail.com>, <lee.jones@linaro.org>,
        <Daire.McNamara@microchip.com>, <linux-kernel@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH 1/2] pwm: add microchip soft ip corePWM driver
Thread-Topic: [PATCH 1/2] pwm: add microchip soft ip corePWM driver
Thread-Index: AQHYektGYgm47OSlDkC85GlCBXsO8q1EX/aAgAENHACAADLcAIAGJF8AgACKmQCAAADmgA==
Date:   Sun, 12 Jun 2022 21:20:10 +0000
Message-ID: <1605b2e0-19af-44f2-20a3-467a895f534f@microchip.com>
References: <20220607084551.2735922-1-conor.dooley@microchip.com>
 <20220607084551.2735922-2-conor.dooley@microchip.com>
 <20220607200755.tgsrwe4ten5inw27@pengutronix.de>
 <eefc366e-1d32-7565-0d6d-243b8addc381@microchip.com>
 <20220608151308.ym6ls3ku6ukhtly6@pengutronix.de>
 <149da575-7ff9-9897-ce13-37c0f061b63e@microchip.com>
 <20220612211656.eoqutfa36ngu734a@pengutronix.de>
In-Reply-To: <20220612211656.eoqutfa36ngu734a@pengutronix.de>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 75fd2e0b-b5f5-4c7d-0278-08da4cb954de
x-ms-traffictypediagnostic: BN7PR11MB2627:EE_
x-microsoft-antispam-prvs: <BN7PR11MB26272ABD67102D6B2205E11198A89@BN7PR11MB2627.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FcIsHFiAhpsq6qWvnxER0TSCsbKbi4ydafA5qfy3+Un2EEP6OUSErEtzKKzkpn7/DYyMvzCm9NqWEdgjN4v8QYB7rbwvZkB8UWVSPoT7Y8pTMLfoL3r+wsKiDsK5fQJuhGUTa8AtDuqQSzYlrszTRjz9hjAEJZhpXM4P20cDVgK728R4f9VSqHApBCw5Cm51r9zRpAf6bqVSMcRjMlHp1J6sctHcyQT92CXxY7xsvjMKMqB5Yn1fylabES2NR+qzDArE6RkSes7EK4t2L+dtnphDdREm7k8/85Jd1j/RnJiwB9CYz+FbPLHriGHRQqF2knqf9jOFjkU4ff2z38p58yqeorXN1emjrvBFVjp8csIg1Qpr/q5D3ASq0MREsa/3DGr1npTRiSc0DTUOJx1LbpstsurrXOFjbliw3896xRCvgYiqM78FIHk9MlFaTggVpUIevW2oqG8gpKjiVgvfbiJ32aRrMalrNPApHAZTPMc2M0Ete9LFBQeQ7/Ss8li+kv3Vr3qJb5TgXFB0as2j4odgaxg0JBvsnPHFRPzbpR71o2Y0hl+7f4vBxCkklkBF2ansJZ/EKFeoIT8jqtp+4upKOXryNuM09UcYmoEPEZB6HuOLRg8qKKWPte1J8P8U+/Hwf3kzDFctFJIL4HBmARpRfhBl+rnYeN/ei1qEDWEfPM67NjmRVcg9gzxm9s68zi4HFT9VeMHtK6u5Hqa9DmDySzroUB9qceK1YIqE9/Hlq+6AB/KbIV4GvdECvnvczCOa8x8L0WaCjJLnbKMCPA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(6486002)(316002)(508600001)(66946007)(53546011)(26005)(76116006)(91956017)(110136005)(54906003)(71200400001)(6512007)(66446008)(5660300002)(31686004)(86362001)(36756003)(31696002)(8936002)(2616005)(2906002)(66556008)(66476007)(64756008)(8676002)(4326008)(186003)(83380400001)(38100700002)(6506007)(122000001)(38070700005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dlAvTEdaeDluM2xaeW15VzJQL2hPa1JyWGVuV1hrK3B6Tk5qVEVhWldpTlpJ?=
 =?utf-8?B?aG5Zc1E4UXgxWGF4aEluOTRJdnhaS2p6RzUrSk16SE83d0lGaW5zQjVUMGdx?=
 =?utf-8?B?emppYit1cnJNT05mcUg3cVU0WFNxTy9pNFRwSTZpYW1rS1kxc1B4ODNib1hV?=
 =?utf-8?B?bnZhcWRvbGZXSDlQTHlpR3EvWlpoaWpabmhjOHJpQkt0RDk1TEM0ejMrb2M0?=
 =?utf-8?B?QjUyOGFQOCt0d3gxYjJtd1VLWXB0dDhJU0RWb29icktaaDVic0tIamdlN3J4?=
 =?utf-8?B?b0YwdkFURGloc2RpOEl0NUFObnFiUTZxby9KR1AyUnp5aHZRS0VUTGFpMVps?=
 =?utf-8?B?aTNHcDJLY1ZKb2JyQjF0MC9YRC92VXAyYW1vYkdJcFZHM3V1WFp2ZzBJVmJ4?=
 =?utf-8?B?MjVKQ2tLcFA1cytUV2hJS2JrNUVxdGsrQUUrS2M5TTlMMFV1Tzd1V0RHczBH?=
 =?utf-8?B?WWVBU0NLNCtnWkl0MEc0SkozcWl3RHNQSEtEdlVtWitySmxZUzZLaWEyZlZO?=
 =?utf-8?B?NEQydzBiSjBZZFZLNlZqMkhUSEVpUk1ZWFp4andhVFpiaGNML29mTi9LZ0sx?=
 =?utf-8?B?M2RaSmlUc0FBbk1XSmpaZVNJbisrNW1aOEhOR2JVd01TaUdROGxob0V1ZHRi?=
 =?utf-8?B?aUpZYnI3R09CN3Bab1M4aFdFUm5xd3FMZmY3TzhxbnpqM0RmbkFSNmJqOWFo?=
 =?utf-8?B?YWxZSE1teVlKelZSSFZTbVpMVlhsSGxGVGpoemVCNjI2dHBIdTl3bFBOMnRp?=
 =?utf-8?B?elhxaGpuUTIrMTlCMWc0YU4zZ1Rwa2pTOTBFWEJzY1dqRWhqeVlsUm1BUENr?=
 =?utf-8?B?cUxyeGxnQTN5ZWUwNEZydm90QTdKWUxHWjVWQi94OU1SRjZTdm94R0xOdUVO?=
 =?utf-8?B?TTVzMDN5c0kvTG5XZjZETDBCSllyUFduOFUvWVE1dDMrRG02NG1jVkQvWGx1?=
 =?utf-8?B?RERCcm82NDZYTk1PZEp0U1JTd0s1cktWZURMcjhqKzM5UFpiMXhQNmR2L1VG?=
 =?utf-8?B?bVUyMzB2ZXFwV3UyUG82VkJVblRvdGsyMExoT0pETjdFSVdMeXlvZHNVUEdU?=
 =?utf-8?B?NTYydWpaR1lZTEg3YlFuOWVqZXVBQWtNQUVRbzdvRWFFOGZwbmE1NW11Yzg2?=
 =?utf-8?B?RTg2dXdiTWNiM21lemxpL0pVd1pmRWNIQkpMSjlCaWNrM2FtdU9xTXBVSjl6?=
 =?utf-8?B?cmoyelJ3QTl1S01Ba05sbU1FUzVYM1poTFpVblVXMXJDemRhYU1BbmtDUXhr?=
 =?utf-8?B?OTJKUVJTaUtYVWw2WDZKdmhvc3NoY2FTSGhHWEZTVURsRVhodTNBV3k3NlJW?=
 =?utf-8?B?MFR3R1lMTFU1M0hBOHV6WGtxYThmT05NRDVBQWxEMHZYQzNXZW1ZUzhYVjAv?=
 =?utf-8?B?UVZnSXA2aFpZWTF4dzIrWWZwaTRERDZrTUNpR1ZDNzZVZ0xlejJEdFRJSDV3?=
 =?utf-8?B?YlpQUjM4dUlLblRsQnV4dlpBdkVCeGZtd3BKckpmdDdvdUt5MmFrV3ZJYVB6?=
 =?utf-8?B?Smp2QXlLQzByNUFYT3QvdU1MYXE0YUFMRW55K3MwNFZ4aGRWbEhPSHJKcm93?=
 =?utf-8?B?QTk1SHVUd1BkYjNtWm9ZUkZ4dVNYSys0c3NSRGo4b2lMQjBxdmYvZkszNHNB?=
 =?utf-8?B?bmY3KzB4Z3BacFFTR1RmQlp4MmNKQjlETG5kSndNRWN0QnMzVkE1NTk4ZW5X?=
 =?utf-8?B?RXRUbXh5RFJnRHhBZE43dS82UUtBZWl1Y1BYamtPVGp5UVR3SmNVL2dGRTZa?=
 =?utf-8?B?VG5BeVB1RXI5Uyt5M3BRYWR1T1J5Skc2WVFza0VReG9nQ0dPVFN5MldUZTRM?=
 =?utf-8?B?ZDNjei85NzhnT0JpUGJERHd4UkhhejFPbHNmd1ZKNEhDSXg3VDBCVEpJa1hV?=
 =?utf-8?B?bWpMNUhqUmNLVUgrcGY5NWZVVCtzZGRYaTRWY1lBd1lJS0RjZ09oUHZhQkZo?=
 =?utf-8?B?QUlaaC9rRnQ5QW1xdDhSNWZNQVk5QTcrRDk0REhjbzkxcVRKYlNtcVlCUVVC?=
 =?utf-8?B?SmR0eldZQ2tmYzFEVm9NWjRyZmhEbWVVSjY5MzU0SVBrNVIrNGdxdlhJOHVI?=
 =?utf-8?B?YXFhWGFNOEVLRGtJTnE3ME1jSDhJVUJESC9YMC9UMlBsNWloc1ZBb0trN2Vs?=
 =?utf-8?B?bEcwYTdZNmxYVEJiV2UzeHlIWUE5bGlndndwRE1iWWpHa2tnazZlbjFuMi9W?=
 =?utf-8?B?S09JTFl0b0MweTlleXo1WSsxUmFkRG42ZjFTbUlOUmFnclRmQTh3TmRpZTFK?=
 =?utf-8?B?emw4OXRZL25VYVNCK3lrRC9pQ1MxQWhmNzZjQml2UTREb3Z2YnJmV3gycVkw?=
 =?utf-8?B?d3JaWU5vVThUTm1YdnBIMm5uaUpiWXdxSXJwR0ZoLzlISmY5alloMUx1b1Ry?=
 =?utf-8?Q?EDyb3vxqrOBZRFBg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7FA709CCBB804D40833F40306678F71E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75fd2e0b-b5f5-4c7d-0278-08da4cb954de
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2022 21:20:10.2686
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZXZPNTBjL7yr1Aq1DHd4AVytHkpsGFc41UDXmKSh8Kp6yGi/k1hSew5BxZNT5GwTFMEE0LrrGhE/LN20m4wetDBFLuog8UrkzxvT2U0+dp4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2627
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDEyLzA2LzIwMjIgMjI6MTYsIFV3ZSBLbGVpbmUtS8O2bmlnIHdyb3RlOg0KPiBPbiBT
dW4sIEp1biAxMiwgMjAyMiBhdCAwMTowMDo1M1BNICswMDAwLCBDb25vci5Eb29sZXlAbWljcm9j
aGlwLmNvbSB3cm90ZToNCj4+IEhleSBVd2UsIG9uZSBsYXN0IG9uZSBmb3IgeWEuLg0KPj4NCj4+
IE9uIDA4LzA2LzIwMjIgMTY6MTMsIFV3ZSBLbGVpbmUtS8O2bmlnIHdyb3RlOg0KPj4+IEhlbGxv
IENvbm9yLA0KPj4+DQo+Pj4gT24gV2VkLCBKdW4gMDgsIDIwMjIgYXQgMTI6MTI6MzdQTSArMDAw
MCwgQ29ub3IuRG9vbGV5QG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+Pj4+IE9uIDA3LzA2LzIwMjIg
MjE6MDcsIFV3ZSBLbGVpbmUtS8O2bmlnIHdyb3RlOg0KPj4+Pj4gT24gVHVlLCBKdW4gMDcsIDIw
MjIgYXQgMDk6NDU6NTFBTSArMDEwMCwgQ29ub3IgRG9vbGV5IHdyb3RlOg0KPj4+Pj4+IEFkZCBh
IGRyaXZlciB0aGF0IHN1cHBvcnRzIHRoZSBNaWNyb2NoaXAgRlBHQSAic29mdCIgUFdNIElQIGNv
cmUuDQo+Pj4+Pj4NCj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBDb25vciBEb29sZXkgPGNvbm9yLmRv
b2xleUBtaWNyb2NoaXAuY29tPg0KPj4+Pj4+IC0tLQ0KPj4gLS0tODwtLS0NCj4+Pj4+PiArc3Ry
dWN0IG1jaHBfY29yZV9wd21fcmVnaXN0ZXJzIHsNCj4+Pj4+PiArCXU4IHBvc2VkZ2U7DQo+Pj4+
Pj4gKwl1OCBuZWdlZGdlOw0KPj4+Pj4+ICsJdTggcGVyaW9kX3N0ZXBzOw0KPj4+Pj4+ICsJdTgg
cHJlc2NhbGU7DQo+Pj4+Pg0KPj4+Pj4gdGhlc2UgYXJlIHRoZSBmb3VyIHJlZ2lzdGVycyBmb3Ig
ZWFjaCBjaGFubmVsLCByaWdodD8gQ2FuIHlvdSBhZGQgYQ0KPj4+Pj4gc2hvcnQgb3ZlcnZpZXcg
aG93IHRoZXNlIHJlZ2lzdGVycyBkZWZpbmUgdGhlIHJlc3VsdGluZyBvdXRwdXQgd2F2ZS4NCj4+
Pj4NCj4+Pj4gRWhoLCBvbmx5IHRoZSBlZGdlcyBhcmUgcGVyIGNoYW5uZWwuIERvZXMgdGhhdCBj
aGFuZ2UgYW55dGhpbmcgYWJvdXQNCj4+Pj4geW91ciBmZWVkYmFjaz8NCj4+Pj4gSSdsbCBhZGQg
YW4gZXhwbGFuYXRpb24gZm9yIGVhY2gsIHN1cmUuDQo+Pj4NCj4+PiBTbyB0aGUgY2hhbm5lbHMg
c2hhcmUgdGhlIHNhbWUgcGVyaW9kPyBJZiBzbyB5b3UnbGwgaGF2ZSB0byBrZWVwIHRyYWNrDQo+
Pj4gb2Ygd2hpY2ggUFdNIGNoYW5uZWxzIGFyZSBlbmFibGVkIGFuZCBvbmx5IGNoYW5nZSB0aGUg
cGVyaW9kIGlmIG5vIG90aGVyDQo+Pj4gcnVubmluZyBjaGFubmVsIGlzIGFmZmVjdGVkLg0KPj4N
Cj4+IFdoZW4gSSBhbSBjYXBwaW5nIHRoZSBwZXJpb2QgKG9yIG5vdCBhbGxvd2luZyBpdCB0byBi
ZSBjaGFuZ2VkIGluIHRoaXMgY2FzZQ0KPj4gaGVyZSkgc2hvdWxkIEkgY29ycmVjdCB0aGUgZHV0
eSBjeWNsZSBzbyB0aGF0IHRoZSB0aGUgcmF0aW8gaXMgcHJlc2VydmVkPw0KPiANCj4gTm8sIHRo
ZSB0aGluZyB0byBkbyBpczogUGljayB0aGUgYmlnZ2VzdCBwb3NzaWJsZSBwZXJpb2Qgbm90IGJp
Z2dlcg0KPiB0aGFuIHRoZSByZXF1ZXN0ZWQgcGVyaW9kLiBGb3IgdGhhdCBwZXJpb2QgcGljayB0
aGUgYmlnZ2VzdCBwb3NzaWJsZQ0KPiBkdXR5X2N5Y2xlIG5vdCBiaWdnZXIgdGhhbiB0aGUgcmVx
dWVzdGVkIGR1dHlfY3ljbGUuDQo+IA0KPiBUaGUgZm9jdXMgaGVyZSBpcyB0byBkbyBzb21ldGhp
bmcgc29tZXdoYXQgc2Vuc2libGUgYW5kIHNpbXBsZS4NCg0KQ29vbCwgdGhhbmtzIQ0KQ29ub3Iu
DQo=
