Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 870F84BF451
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 10:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiBVJD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 04:03:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiBVJDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 04:03:23 -0500
Received: from APC01-HK2-obe.outbound.protection.outlook.com (mail-eopbgr1300115.outbound.protection.outlook.com [40.107.130.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0E413775E
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 01:02:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dpIhM5NQuTbVIkjvxLNyOhkEGrIyQBoyM1LjOb6zgTxSeh9SHnodkYDBgJ58d1PYr33ciyt0JX8zP0RNEK4cd39MbgIVrwxFCtgywPuUEqQN+5gV64Vr0/67OWTf7J4ay4Ppic07qJD377oH/MBzUyZJeTu9n2U9xIDAkE95IZecTYo6mtnrBXvPOfmo1zt39hK//M0x3UekY2yLRJTwuwKLhoAh2mgfP9In7W2WDJ0O9MZ9XfyTig5eV8KjpdrATosIK4DCs67orMMg6MqIQYGSOLIeW4zcTkgY4gTa3jm5hb1EhvN6MbvinS8kdYW5GiLCMudEjoxhhqy85CO1Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I4MtOs73V1b6s/2kUW6/ssWfMS0gjPseyICHmQ6chm4=;
 b=eIIsk8M5+4BRFrhzC/2ugo9tLohdVbnpSg29qjOWu7aEgNx/UIx1Wgdh6BJMo3o176/4yfxx16R5xwaM1SQkgnTNSGNETFWMGCmVzzmqZCqhc+JF5MLnbmJXmhGLO6EkWSurC7xTwosoTspl7uowpRLqqwdPdAQaQlttBRftNK7NifULHNoEXCR5p3PHYXH0npZTD07r4FjjP77ZcWJUfvjDlHUFtf2cxcJtrv5XzSyDbU25Ec9MMmmRKVXeRpqzZPBoER0MJdGmcEYWS7SOWrqtp1yFM7eRl0YnSsxUOKD6DDOYjIyr99wmnAXd8+e5wcDiJz6Nh+0g5k8ENBWOrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantatw.com; dmarc=pass action=none header.from=quantatw.com;
 dkim=pass header.d=quantatw.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quantacorp.onmicrosoft.com; s=selector2-quantacorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I4MtOs73V1b6s/2kUW6/ssWfMS0gjPseyICHmQ6chm4=;
 b=XgJFy/z2DY7oDupfs1VvFWX1jPTLeIbZbwKUVGoyWkrjGWt4KXWl0gzIZBUc0d8xA6lG0pN/Bjgry+Su3UeCVWTUfGMh61lypuN03EoO0VxMeml6jXBZQW5s6O3BRYJ0BHGF+cEZhb2niP+ERXfhO5bGJManVxjgNcRWpdaC9yg=
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com (2603:1096:203:89::17)
 by TY2PR04MB3311.apcprd04.prod.outlook.com (2603:1096:404:94::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.18; Tue, 22 Feb
 2022 09:02:53 +0000
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::ec21:c033:761d:3e03]) by HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::ec21:c033:761d:3e03%4]) with mapi id 15.20.4995.027; Tue, 22 Feb 2022
 09:02:53 +0000
From:   =?utf-8?B?UG90aW4gTGFpICjos7Tmn4/lu7cp?= <Potin.Lai@quantatw.com>
To:     Michael Walle <michael@walle.cc>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Patrick Williams <patrick@stwcx.xyz>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/1] mtd: spi-nor: winbond: Add support for w25q01jv-iq
Thread-Topic: [PATCH v3 1/1] mtd: spi-nor: winbond: Add support for
 w25q01jv-iq
Thread-Index: AQHYJ8l4GjZ+Oacgs0OaQMkECP9r16yfRJkAgAABxQA=
Date:   Tue, 22 Feb 2022 09:02:52 +0000
Message-ID: <e34daf51-b2db-f65e-8a54-5a1ee27b1269@quantatw.com>
References: <20220222085148.21594-1-potin.lai@quantatw.com>
 <3acadcc73688086c5ed204c058f28de7@walle.cc>
In-Reply-To: <3acadcc73688086c5ed204c058f28de7@walle.cc>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quantatw.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 455263c1-db9b-4f23-7ee4-08d9f5e21c07
x-ms-traffictypediagnostic: TY2PR04MB3311:EE_
x-microsoft-antispam-prvs: <TY2PR04MB3311C894DC1D1E9FB10953228E3B9@TY2PR04MB3311.apcprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BrIuuHji684rvH1Dyu8KcgSOF6rz6ovHcIEOtaQYFWd22xeF8s93hYSxdkztzQzTLxvH3ft6Oqd95nJOeuZUBF/pc6xe0UqsaeVZtMc7GhJdxuKFsWg/Mr1GMY+mEdijvvZDjx4LAztdeUE1OHlqpC/zH6jKNALd+kD9zuaj3KnC8NHqIzAjpiOkTkTMjf2hTjLk1R6V8cvY32xhxJ7gGz3kPo4hVhdchJJY+wH/bs+sw+vfGc80g4Cbofbdc8rDucXmyVkR70fCH7piExpK4GHIiu029StaXkSSoLH9cfeN9KVLq5dq+sLBmyuMY9PV0QLl2/Jf7+5gXZ0ab4XDj5aLcgzEeV6Y7G0OzFg1iC4pCCyDz/3jNZY6+w/ABya+DmJIuFMt2tOkqUVH59KoHYEebbh5dPmLSblcmPenA22Q1FYDwS93tkTzKjvsaJnrEl/nB+G0ZaRq0AYe3kjUTSENVXm4dmLXigtWJ7ORK2yEFSXxYdbmYQF6Y0jRBXoS7qckh9b01e5wTjOOhYWXHTI2M9AV6NpgwK3DE4pmkJ/7nky/3aym8hRNptGkHz5Bjq3wiR7/6L9jYE9D/q+3xnMOTUDbIsyxFwsTMhK8hqq9Nvy6YIE+qtckxYUP9wS/QDweSB5Ahjv+u54oxmRqQscuWBJR3cOpYR9EYGAc1JpA5DKaOhBFhacVK57toZHsGVgYi2s5RlVEhDlv+ZUo8ppzPz1RClJBj4pF/Q2LhKcqTTIs3FHaAqblHLk3BWeglEklXeXEV4K1veh6mdAiWlvbK/wox4d8a2yxPdAalC4uh0b7ugikn9o7m1RxWbcAu6zcHec6srXB1dgdmD57emqLe2C7J9uF/zK6lXfdDrgRM/NwI/Ll9RBFODWrBMsvRTUkj+5K05z8EeCNPC4/0w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR04MB3282.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38070700005)(4326008)(45080400002)(76116006)(8676002)(66446008)(64756008)(66556008)(26005)(66476007)(66946007)(2616005)(6486002)(966005)(508600001)(122000001)(186003)(6512007)(71200400001)(38100700002)(86362001)(31696002)(316002)(2906002)(6916009)(6506007)(8936002)(31686004)(36756003)(5660300002)(85182001)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SnRuam5VRjJDUlBZR1d0b1diNGo3S1Y2YjJTRU52Zlp1YkwxZ1JNUmpmaHFE?=
 =?utf-8?B?Vmc3UFlqR09Za0VieTVOTHpDb2R4ZVJ3NmlxcHhtaWRUY0UwdDN3elRLZTRQ?=
 =?utf-8?B?WU1kSFZLTXB0RHh2WXBZU0Zud1F0Z1RpTU45KzBxVUVLMU9ZQUFDUFhoazdE?=
 =?utf-8?B?M2R2NVhBWTlCTStLZXpyd3lkUVlLTG1VRGF3WVU2aDhnVFpjUFFzTElMUGx1?=
 =?utf-8?B?c01uT1BaM1FjNE04L0hzVWppQjdvd3pNSWZNN2hlY2JHUWhiV1cvMXJzdE1B?=
 =?utf-8?B?a2czK3doYTg1R1grV3BRRVBrYzNmVUR6dGhQb0VNTTV1WGw5eDZpbU5iWk01?=
 =?utf-8?B?VTlHbXJzV3FiS25LUGxhSVZIT0RXZ2haMzFrNklJbElOSkJvTTZIMVNsTHB1?=
 =?utf-8?B?TEhBUmpnRjNHeGl4KzNsaStId2ZteTRYcm41WXY3d0grcGt3ZXZKNDNXaUdB?=
 =?utf-8?B?R1JReGF2alh5cHVOcngyd1pDS3Y0VWltUkxtMGdTUUhVR1EvT3EzalNqUnlr?=
 =?utf-8?B?ZDVjdVpFU0JCMWtJWEpmOGFoMitUV2p5OEZ5VWM3ajcwQXp5NkxYeHlxT2h5?=
 =?utf-8?B?MUFTVXFzdVF5b0VEZDB3S2VVYzU1RWxFdzVpZDhPY0NMSmdwYUpHQ2RBVHFv?=
 =?utf-8?B?aFRMMExQMjF4eEVjVjR0Vk9FeU5PVGpCV3BEU0RETXFxL05Zei9YUTYwdmJ6?=
 =?utf-8?B?cVozcVBZR2QxcElqemhtRmhjdXczaVBEUkl5ZzR1aTNUejhRcG4rd2YzMWx5?=
 =?utf-8?B?TzRlY3ZVVVU2dk1hT0daUzdVQ245TkJGd2hBc0pVSWVlZGJ0VTZQV1hoY0Fl?=
 =?utf-8?B?UG9RUWJLYWZKQ05tejVNcDAvMm1WcERxa2crU3VydW83L2dNZFp3NXRuQTNX?=
 =?utf-8?B?WEM3cy9mc2dtb29iT1ZQMFQrNTVsL2JWZjdjUHlnbTJVWmNjNkFuYzU1dXVR?=
 =?utf-8?B?aWhvRmtXZ29NdEExN3YvenNqWm1aYWlYRDZRVGROb0VmYnQ4eUxmK0VVbUZC?=
 =?utf-8?B?SEJRRmkrQzdFcGMvZjR3RnIwMlk0bWs1V3Y0OUQwbkMwZnpzMmpmNkxwZ1Ey?=
 =?utf-8?B?b3l0UUxadGxpeC80YlloR094dzdmTThVK2wvZjlWQ2c2TVV0OGVuRHVqZjhC?=
 =?utf-8?B?VUtIYmxJekpMdnVNNVV5WUJ0enNpUjF3aFpGY0RGZEw3ek5UMkpiQ2JGY1VI?=
 =?utf-8?B?S2lDdmtnbTJ4M0luY1MyNDc3OXJtMFhzRUlPd20zK3VmSmxOVVBnbWNveTJ1?=
 =?utf-8?B?RUhTQ3ErRHZlazltaDFuaU5mdkdkbmZ1YTRBUDdMYTF5TnBHekRSNXN4SVhF?=
 =?utf-8?B?YmJrQWRmWG5iSGFXdlJuYSt5cEJMYmhoRko2V2VTSHhsREdwQVNoVnNvbVA1?=
 =?utf-8?B?TURZNWpFbi80VWRWeUtwWmNMbjd5c1pvNFdjSkpkQlgwaWFQcWdVeTFrRlNi?=
 =?utf-8?B?MStBdm1FcTV5MFoxeDV4YVJRQzBFWGl0eW5lVTJyT1BCY3dDRlpRbVhHaVFl?=
 =?utf-8?B?OXRrVHRtWTkxdHpVNUZiM25YbEpoYkFOcFBOWXQrSzZ2MkVjOElNeEtoOU1q?=
 =?utf-8?B?Z1NVQUF1aHBzRnFHUjFPUHV3YXQ3b3VQVjRGV1FzeUwvRVZ5ajhKYzR2RHE1?=
 =?utf-8?B?ZitNOXYxVGwxOHNweUtlYWdSMjVOQ0o5VTgvWVlHMmhXVzhwdUF4d0w2U3V0?=
 =?utf-8?B?dnZRZkdLU2czUTUyU3YxY3ByYXdVcWs5ZkRDTHcvTXVvZ0R6M1JPdC9jaDRF?=
 =?utf-8?B?dlAyVURka05zejdFMjdPazFnR0lPOUxva2I0LzZuV0U0WG5tdG12TnNMZTNm?=
 =?utf-8?B?YXFjV1EzbHpiYmtldlBuSXNXSjliRmJUL3hKTDV6WWZNWmtoTkRwMVlyVXFh?=
 =?utf-8?B?NWxmYUQxRnExL2JaKzBPbmhNT0JXcUtqZEV6ZmV2SklwMGk2bTNXcVVBWTcx?=
 =?utf-8?B?dWVpK2dxSTUxZ1ZrTHc3bkZxY0NyY0dJWHErMlAxb1lpeFZLdVl4Qml6ejVz?=
 =?utf-8?B?ejZOQTcremUwQlJYNnR1RlNRQnZ2enczem5QQU85NFhrTXdtY093ZTNTdU1y?=
 =?utf-8?B?RDlYalNWc1B6S1llNTZma0RUY3dqL0k0ajl5Y0VobVYwNmZXczNjTDdQcWcx?=
 =?utf-8?B?NTBtL21vTW54bnZaTnJBVThFUjFlQ3FhajBGWjhMQ2dIUHVVNkRGZTEwNThr?=
 =?utf-8?B?T3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F37EF306165B5E48A26774ABFD2B07A1@apcprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quantatw.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR04MB3282.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 455263c1-db9b-4f23-7ee4-08d9f5e21c07
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2022 09:02:53.0053
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 179b0327-07fc-4973-ac73-8de7313561b2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qhl4N7C1GMmje+eVeEw8WFXUTyBAYk3s0vO/d8wIt2c1Iv2qRwvDfzMQkycfWvJLGKYfB9r5Qgg08s7OvHfX3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR04MB3311
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TWljaGFlbCBXYWxsZSDmlrwgMjAyMi8yLzIyIOS4i+WNiCAwNDo1NiDlr6vpgZM6DQo+IEFtIDIw
MjItMDItMjIgMDk6NTEsIHNjaHJpZWIgUG90aW4gTGFpOg0KPj4gQWRkIHN1cHBvcnQgZm9yIHdp
bmJvbmQgdzI1cTAxanYtaXEgY2hpcA0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFBvdGluIExhaSA8
cG90aW4ubGFpQHF1YW50YXR3LmNvbT4NCj4+DQo+PiAtLS0NCj4+DQo+PiB2MjogaHR0cHM6Ly9h
cGMwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJG
bG9yZS5rZXJuZWwub3JnJTJGYWxsJTJGMjAyMjAyMjIwNjQyMjcuMTY3MjQtMS1wb3Rpbi5sYWkl
NDBxdWFudGF0dy5jb20lMkYmYW1wO2RhdGE9MDQlN0MwMSU3Q3BvdGluLmxhaSU0MHF1YW50YXR3
LmNvbSU3Qzc4MzZkYTliNTBhYjRkMDdjNWNkMDhkOWY1ZTEzZDA2JTdDMTc5YjAzMjcwN2ZjNDk3
M2FjNzM4ZGU3MzEzNTYxYjIlN0MxJTdDMCU3QzYzNzgxMTE3MDA0NDgxNjM0NCU3Q1Vua25vd24l
N0NUV0ZwYkdac2IzZDhleUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJ
NklrMWhhV3dpTENKWFZDSTZNbjAlM0QlN0MzMDAwJmFtcDtzZGF0YT1PbUI1JTJCOGR2SHRTa2oy
TEsyaGNBbUslMkJpa3owYkxSODNKM3F4V2xFSkNjSSUzRCZhbXA7cmVzZXJ2ZWQ9MA0KPj4gdjE6
IGh0dHBzOi8vYXBjMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRw
cyUzQSUyRiUyRmxvcmUua2VybmVsLm9yZyUyRmFsbCUyRjIwMjExMjI0MTA0NTIyLjI0NjE1LTEt
cG90aW4ubGFpJTQwcXVhbnRhdHcuY29tJTJGJmFtcDtkYXRhPTA0JTdDMDElN0Nwb3Rpbi5sYWkl
NDBxdWFudGF0dy5jb20lN0M3ODM2ZGE5YjUwYWI0ZDA3YzVjZDA4ZDlmNWUxM2QwNiU3QzE3OWIw
MzI3MDdmYzQ5NzNhYzczOGRlNzMxMzU2MWIyJTdDMSU3QzAlN0M2Mzc4MTExNzAwNDQ4MTYzNDQl
N0NVbmtub3duJTdDVFdGcGJHWnNiM2Q4ZXlKV0lqb2lNQzR3TGpBd01EQWlMQ0pRSWpvaVYybHVN
eklpTENKQlRpSTZJazFoYVd3aUxDSlhWQ0k2TW4wJTNEJTdDMzAwMCZhbXA7c2RhdGE9Q0tjN1Bs
NiUyQnglMkZTUCUyQkFOM3E3MyUyQkRaR2FMVGs2S0VPRm5JeFFuOElwZWlZJTNEJmFtcDtyZXNl
cnZlZD0wDQo+Pg0KPj4gQ2hhbmdlcyB2MiAtLT4gdjM6DQo+PiAtIG1vdmUgc3BpLW5vciBmbGFz
aCBpbmZvcm1hdGlvbiB0byBjb21tZW50IGFyZWENCj4+IHJvb3RAYmxldGNobGV5On4jIGNhdA0K
Pj4gL3N5cy9kZXZpY2VzL3BsYXRmb3JtL2FoYi8xZTYyMDAwMC5zcGkvc3BpX21hc3Rlci9zcGkw
L3NwaTAuMC9zcGktbm9yL2plZGVjX2lkDQo+PiBlZjQwMjENCj4+IHJvb3RAYmxldGNobGV5On4j
IGNhdA0KPj4gL3N5cy9kZXZpY2VzL3BsYXRmb3JtL2FoYi8xZTYyMDAwMC5zcGkvc3BpX21hc3Rl
ci9zcGkwL3NwaTAuMC9zcGktbm9yL21hbnVmYWN0dXJlcg0KPj4gd2luYm9uZA0KPj4gcm9vdEBi
bGV0Y2hsZXk6fiMgY2F0DQo+PiAvc3lzL2RldmljZXMvcGxhdGZvcm0vYWhiLzFlNjIwMDAwLnNw
aS9zcGlfbWFzdGVyL3NwaTAvc3BpMC4wL3NwaS1ub3IvcGFydG5hbWUNCj4+IHcyNXEwMWp2LWlx
DQo+PiByb290QGJsZXRjaGxleTp+IyBtZDVzdW0NCj4+IC9zeXMvZGV2aWNlcy9wbGF0Zm9ybS9h
aGIvMWU2MjAwMDAuc3BpL3NwaV9tYXN0ZXIvc3BpMC9zcGkwLjAvc3BpLW5vci9zZmRwDQo+PiBh
N2I5ZGJmNzZlOTlhMzNkYjk5ZTU1N2I2Njc2NTg4YQ0KPj4gL3N5cy9kZXZpY2VzL3BsYXRmb3Jt
L2FoYi8xZTYyMDAwMC5zcGkvc3BpX21hc3Rlci9zcGkwL3NwaTAuMC9zcGktbm9yL3NmZHANCj4+
IHJvb3RAYmxldGNobGV5On4jIGhleGR1bXAgLUMNCj4+IC9zeXMvZGV2aWNlcy9wbGF0Zm9ybS9h
aGIvMWU2MjAwMDAuc3BpL3NwaV9tYXN0ZXIvc3BpMC9zcGkwLjAvc3BpLW5vci9zZmRwDQo+PiAw
MDAwMDAwMCA1MyA0NiA0NCA1MCAwNiAwMSAwMSBmZiAwMCAwNiAwMSAxMCA4MCAwMCAwMCBmZiB8
U0ZEUC4uLi4uLi4uLi4uLnwNCj4+IDAwMDAwMDEwIDg0IDAwIDAxIDAyIGQwIDAwIDAwIGZmIDAz
IDAwIDAxIDAyIGYwIDAwIDAwIGZmIHwuLi4uLi4uLi4uLi4uLi4ufA0KPj4gMDAwMDAwMjAgZmYg
ZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgfC4uLi4uLi4uLi4u
Li4uLi58DQo+PiAqDQo+PiAwMDAwMDA4MCBlNSAyMCBmYiBmZiBmZiBmZiBmZiAzZiA0NCBlYiAw
OCA2YiAwOCAzYiA0MiBiYiB8LiAuLi4uLj9ELi5rLjtCLnwNCj4+IDAwMDAwMDkwIGZlIGZmIGZm
IGZmIGZmIGZmIDAwIDAwIGZmIGZmIDQwIGViIDBjIDIwIDBmIDUyIHwuLi4uLi4uLi4uQC4uIC5S
fA0KPj4gMDAwMDAwYTAgMTAgZDggMDAgMDAgMzYgMDIgYTYgMDAgODIgZWEgMTQgZTIgZTkgNjMg
NzYgMzMgfC4uLi42Li4uLi4uLi5jdjN8DQo+PiAwMDAwMDBiMCA3YSA3NSA3YSA3NSBmNyBhMiBk
NSA1YyAxOSBmNyA0ZCBmZiBlOSA3MCBmOSBhNSB8enV6dS4uLlwuLk0uLnAuLnwNCj4+IDAwMDAw
MGMwIGZmIGZmIGZmIGZmIGZmIGZmIGZmIGZmIGZmIGZmIGZmIGZmIGZmIGZmIGZmIGZmIHwuLi4u
Li4uLi4uLi4uLi4ufA0KPj4gMDAwMDAwZDAgZmYgMGEgZjAgZmYgMjEgZmYgZGMgZmYgfC4uLi4h
Li4ufA0KPj4gMDAwMDAwZDgNCj4+DQo+PiBDaGFuZ2VzIHYxIC0tPiB2MjoNCj4+IC0gcmV3b3Jr
IHBhdGNoIHRvIHdvcmsgd2l0aCBuZXcgZmxhZ3MNCj4+DQo+PiAtLS0NCj4+IMKgZHJpdmVycy9t
dGQvc3BpLW5vci93aW5ib25kLmMgfCAyICsrDQo+PiDCoDEgZmlsZSBjaGFuZ2VkLCAyIGluc2Vy
dGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQvc3BpLW5vci93aW5ib25k
LmMgYi9kcml2ZXJzL210ZC9zcGktbm9yL3dpbmJvbmQuYw0KPj4gaW5kZXggNTlkNTNiNGMzOWM4
Li40YzA4ODI1MGZlOTYgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL210ZC9zcGktbm9yL3dpbmJv
bmQuYw0KPj4gKysrIGIvZHJpdmVycy9tdGQvc3BpLW5vci93aW5ib25kLmMNCj4+IEBAIC0xMzEs
NiArMTMxLDggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBmbGFzaF9pbmZvIHdpbmJvbmRfcGFydHNb
XSA9IHsNCj4+IMKgwqDCoMKgIHsgIncyNXE1MTJqdnEiLCBJTkZPKDB4ZWY0MDIwLCAwLCA2NCAq
IDEwMjQsIDEwMjQpDQo+PiDCoMKgwqDCoMKgwqDCoMKgIE5PX1NGRFBfRkxBR1MoU0VDVF80SyB8
IFNQSV9OT1JfRFVBTF9SRUFEIHwNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBTUElfTk9SX1FVQURfUkVBRCkgfSwNCj4+ICvCoMKgwqAgeyAidzI1cTAxanYtaXEiLCBJ
TkZPKDB4ZWY0MDIxLCAwLCA2NCAqIDEwMjQsIDIwNDgpDQo+PiArwqDCoMKgwqDCoMKgwqAgUEFS
U0VfU0ZEUCB9LA0KPg0KPiBZb3UndmUgc2VlbWVkIHRvIG1pc3MgbXkgY29tbWVudCBpbiB2MiBo
ZXJlLiBuYW1lIHNob3VsZCBiZSB3MjVxMDFqdnEuDQo+DQo+IFdpdGggdGhhdCB5b3UgY2FuIGFs
cmVhZHkgYWRkOg0KPiBSZXZpZXdlZC1ieTogTWljaGFlbCBXYWxsZSA8bWljaGFlbEB3YWxsZS5j
Yz4NCj4NCj4gLW1pY2hhZWwNCg0KU29ycnkgZm9yIHRoZSBtaXNzaW5nLCB3aWxsIGZpeCBpdC4N
Cg0KUG90aW4NCg0K
