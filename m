Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6748E5B0A41
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 18:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbiIGQjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 12:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiIGQjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 12:39:41 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30939FC9
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 09:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662568778; x=1694104778;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=WTIDlFIiwwTxacwlDSpQ2gzq+EIo9lGUxo0rwNAHQVo=;
  b=mzHkiL/IgWc9xbGSRF5wLBxKiUxhAHdgMyKiLBLV4yEdlEQ0//i3NKlx
   B4J7bAiI0R4I7VBiiKQhr1btriXRcvZmNGOvUS+apLKHFYN6mq9NWrLIl
   wa/0PoyKZ+qd4O01NuLITW73QBvacZ+lBex1y8pvAiaxbmtzVxaa81cpm
   Vg9S6dX7fbihNlN9gQ99ifaoEt52TZiJzClvcSMV2LcztCiYHfLETt27p
   zgWPnT3xRsy5HzFvE6WIaAxvXJj0S7tXPIOIujHhuctF8jMnE49k3Vgrj
   t+0I2iYvZafztJPwQG5hdWkMfrbkZ8dGe7x5fMhghaGYEJhpKdZcrSV8K
   A==;
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="176050034"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Sep 2022 09:39:36 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 7 Sep 2022 09:39:35 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Wed, 7 Sep 2022 09:39:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ETbfI0YTcJ7OzyoCDdpbEq1hCqhOYN0isb/TdnnxwMKl4waC7c9MieEsIClk5HHb8oKDPH9Zinyd45sFlSCL9kHJ9hs0ejIFWkF/a20Vg1iuVDm9r46s8BBZYT96Rzlu6detPC3PpmBf44ICtZUCWAMZJUttvGvIJlHNFQxtMny+qhwSDTN6ZifZTZMKBaQ9r8dOCCVLWjZGwb/hYUGangJD+WY0UA7iTP8D78IyVjxgZQuUuET+KuTqZB4vIOvQemqQb0PGNm/u5A7JuOR6NHQWlIjwDR7bzn1cT/izvtm2TSwe4/UJVkuUo9BY4ns6Cr190JXaTUJfII1tFE4DAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WTIDlFIiwwTxacwlDSpQ2gzq+EIo9lGUxo0rwNAHQVo=;
 b=DrymWN8wQlPpaPuMSanAJ3lNntHmJyrFuFg/kKIa7Fy3ZTbn/cGLnnL8NSsZEO2VYSHFf2RHHountmDSz9Q99cKyK5awyKMogPrhKuVYNwTq230N8F4pWkNksaPp1kH9Xyn7YUZnbVG9JiZ9dyd3Yu8LIJu2gWst+dkVKe5kbvF4rJyqwk4ugfzhdID1dbjsF63YySFd9HA+c2wVKnSbP9mJw/Uf3FjpY7QanUyyhqE3qBg0AOIhHmBi9Ctry5YrS+JmnwAA04qBs+zrw/wCrpKFXc2qRBa5JT9rFj1Ni2J20QnQ+1JIb+2x5mBCBVujSp0zphk7tjJQ1jeew77d4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WTIDlFIiwwTxacwlDSpQ2gzq+EIo9lGUxo0rwNAHQVo=;
 b=YRsNx5g0pJWW91cd7xuS04V21ynDSs0WuIOKJxzFdMJNq5JdcN+ZwxRofECNsveUxPskPZHwk6XfcO/e6G5JRdkiAc1dkDm1eK1rE6Lb6HoSl8OVEz/jHJ/Cpntn3RpxFRrh7VY/5ezNT9RmjaZMe1VVeri66MXzxwrLOIBGr/8=
Received: from SA2PR11MB5163.namprd11.prod.outlook.com (2603:10b6:806:113::20)
 by MWHPR11MB1358.namprd11.prod.outlook.com (2603:10b6:300:23::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Wed, 7 Sep
 2022 16:39:32 +0000
Received: from SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::1169:5ec9:62a8:d220]) by SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::1169:5ec9:62a8:d220%5]) with mapi id 15.20.5588.011; Wed, 7 Sep 2022
 16:39:31 +0000
From:   <Conor.Dooley@microchip.com>
To:     <sudeep.holla@arm.com>, <palmer@dabbelt.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <atishp@atishpatra.org>,
        <Brice.Goglin@inria.fr>, <gregkh@linuxfoundation.org>
Subject: Re: [GIT PULL] Fix RISC-V's arch-topology reporting
Thread-Topic: [GIT PULL] Fix RISC-V's arch-topology reporting
Thread-Index: AQHYsPRyXnHNGxm8rkSgpyoSWfWKT63UTuQA
Date:   Wed, 7 Sep 2022 16:39:31 +0000
Message-ID: <afa3b7a8-3615-36bb-4850-b7966028f74c@microchip.com>
References: <4849490e-b362-c13a-c2e4-82acc3268a3f@microchip.com>
In-Reply-To: <4849490e-b362-c13a-c2e4-82acc3268a3f@microchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b61d5ab6-0806-4806-97de-08da90ef8a4a
x-ms-traffictypediagnostic: MWHPR11MB1358:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iOSrhsKFvVluK7fJK5omMN1HMaG2BW0jYCIvHbLMK+Fd9vyHmT+U+ZpHixxeRXuOM7fZypYHo+7FhekUtz2psLU+G2wBAkuBq1AyEm7p+jK/faGfPEEwyUaJMi5abtvIhtF6O2poi/8oTY2sBSPrwLNcwx0KDUgu8+HgOWdBu+GTLK1oCzgjgC0R2F8DkfKSv0u4bYxT69qGG7dRPE/5L2x9J6X/gtOx8xI9zEqO6K0HVJLER6tZGif2p7KvqrfSf894N7a6m6Xm4AD2yfOOEgCeMRlU6lP4TpR8kPHatWccMf+FXhu7odCvepFJ9CoUMMI8ojURP2wcPUzJgvOa03sZ7YGSuPk7lLJUzgRAt5E60s/d1JOmyo5DHt+0u2u7Ruxy1mfHFfUj3tdxivTM8SGrxmto3ls+dJ7GXFMaJov9x7hglnP5UpVRwDRv5YMP31lnks6IZYjlQUfopwYJwpU1JNVEhoFUr+MQq1+ZBJYIh9hLAebWHPOmJtEg4jpoT8QWI6dEVlaVa5gnZ8YU98Ck1y/VUF91ENDH2m1bUGU/R37RMATEJOegMHh0ZwQWy91nS+lJpupJ7gMHpCFF3PL/iZigA7OXtvBg3SiCAPkW1Hq5hZWqJLuD0XpH1wfrxH7ejMuhcg87pJvvEeB15De42+vor+uaHug7vfAKDxyb2lfOPHOkqlKb3IYYTzXnfJx5WIP0TkBpywqEAskd3nkWbRFxtV+NhKIFlWL4hwaXTWInYdVL8yC++Xs+aB21Ckt9iBs2384nHXNSzwEgj0perDi4ExtnHqZVSvEs0FwVaMAChbdSzcpVLHRO6iF/VETqZHC9pSLFpKwJ1x8pI8w271zJvX7S4FE5qXnZOSzARSDTdyqEgWyy2NBubGreKv9s12p3a3i/uXtPYOCZSg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5163.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(376002)(366004)(39860400002)(346002)(136003)(8936002)(36756003)(316002)(5660300002)(31686004)(6512007)(41300700001)(54906003)(478600001)(53546011)(86362001)(110136005)(26005)(6486002)(71200400001)(966005)(7416002)(6506007)(83380400001)(38070700005)(91956017)(186003)(66556008)(8676002)(2906002)(66946007)(66446008)(4326008)(38100700002)(2616005)(66476007)(64756008)(31696002)(76116006)(122000001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aDJZY3pMMXJhT2VPYjJtQXZacVk1RHJzTERDa1kyUnR2a2oybmdjZ2J6aTVW?=
 =?utf-8?B?QUpyeTkvajhFUnlJRkpVejZDTUwzQWdVMzJBazF2WUM3VmJ6Vmd6UEV1aWtR?=
 =?utf-8?B?dUVLem9wazJIeDR4eEZpcFVGTHVFTjdKd3VCWlozcWgvOUlIZHkwQWdXZHY1?=
 =?utf-8?B?UEdjZTFhNUFqQU5Ya29ZRTlFbEsxYlBrd2htTGNxSjJadmxhSGZLTVZ2ZENT?=
 =?utf-8?B?TmZ6czNsZEh5MytGb0RIcHZPWnBwYVgyU1o3bXVVYzIyVUJQd2VURlNPUTV5?=
 =?utf-8?B?NDdvemhlOVZhcmFlQ2hPckdsa2NMcmlFOFFNYXdKN25GdU13UkNDdjQ2MmRZ?=
 =?utf-8?B?VXdYc2E0UG9MUVd3TFZJMjVCalVocWRvdmZPcUo3eWhVWE90MkNJVHplalI3?=
 =?utf-8?B?TWFYQ09CU3VNZk9HZWNXMC96RGlUMUJENjY5N2lkNndnQ3ZPeTlWeWNRWTRi?=
 =?utf-8?B?Y3YzZ2lvUkhSK3dqRExUZmRXSVhHZmJ5aHB5bnovQmVFUiszOGF5SkUwcHhy?=
 =?utf-8?B?QmUvdGh3SXp5bmJwMnliMWlvN3doZGtVTy91Ym1qZkNmYWR3UXloeHFRTEpD?=
 =?utf-8?B?TDZ2TVdjZVhENW9WaEJaZnNZQmxkbVIwUDNHZ0xPdEM3aGdZZTlxV2hodDN2?=
 =?utf-8?B?NXIwQUxoaEwyR29ZRlBpUzNLWWpLajR4WjllWk5YSnlDbmh0UmJ5SXpNQllK?=
 =?utf-8?B?MEZ0UlZaOThxWTZMZWs2bjZtSXROZ0JVdFBHZVNTUkhONjR1bDlLTXVUbjFo?=
 =?utf-8?B?ZjlYdGVEb3I3bDhvcHo3VmdjNTF4RE1YSmNHbmpkRmI1bTVuekFrZmpCS2ZW?=
 =?utf-8?B?MXlKVjBLNFlBV3hKZERETm1BbURxR2wxckJMOFNsMGhYMWdOSWlIVCtSM3dY?=
 =?utf-8?B?YVNHUFI1bVFvckdLejZyNnFxN1V0R0tFWEh1aDRlekJiRVI2YnlJK3c1YVZ4?=
 =?utf-8?B?Yms3dmMwMGFuMWRnMnYxTGt5K2xKRGlqMnJ6R0YxdnhUUU53enhFZEs4bDhO?=
 =?utf-8?B?ZzVVYzNTMm5URGJyYlYyQmMxdFhGY2JGQWxtZ2NGRnAzTFpNVitlWEgzeE9o?=
 =?utf-8?B?OUpDWStScUdON0dGV3NlL1pJV0g2UXlWcFBnV0R0aWhHYWUwUjJKdHlud2F6?=
 =?utf-8?B?aXErUGlJclZ3TG56YnNjcmFXcENBd2ZBclN6LzRKcCtkZ2x5Y2VNSXhheFYz?=
 =?utf-8?B?b25HamFTNy9WWXZKa0tVZ2J5czR2bGVtQVdBT1ZUZnN4UHNvalhtZ1NCT3dD?=
 =?utf-8?B?VERwei8xbEQ1aEtZZGFmZWI5RzM4eExhdEtzNmw1eG9hMFVDZzdIZVAyVlgr?=
 =?utf-8?B?dTZLRmMrUW54UXBHVjR4aDB1TU1sRHk3cjJKOXNCNGJITEJraTl0aldBWWYx?=
 =?utf-8?B?ZkRvdkVzeXBpVUh3Nys1d3MxcXJBekNrRjMwQnJYSklEckhKMzB2aTRRZHZu?=
 =?utf-8?B?OHdNYWVVYkQ5dnZMTDlEUmdrVXVuUTUxN2s3M1hZMDdKSmY3LzFNdGF5dW5D?=
 =?utf-8?B?NTJScUpqd0xRczMrTElTS2o1d3pmRFVBajgyL0x2c0pjbTRSWFc2TUpqRnUv?=
 =?utf-8?B?eWVkK09PREVyMjB6NzlJRGpnWVFLbDRQcGQ2QStCeWozYmVKcktqZmNvbm00?=
 =?utf-8?B?dWlXb012S0NXbjVvYjVwT0ZlL2xGYlhscGFsczNwUVprQlJBU2JORHRDTnZq?=
 =?utf-8?B?TDdXZnoybzZNbmdTbWdobEc5dTBQcFhSeHdaWkZmc25jT09Lci9ONk85UHBn?=
 =?utf-8?B?a2RrOHRJU2ttMnArREVoZFljVmlNQjJwMHNMdXhhWC82VVJ2QWV3WCttNVY2?=
 =?utf-8?B?UDFabzNqZm9PbzhLWDBVaVlUVHk0RENTaXJleFlveXZqRXNWRUJpVlJDMElt?=
 =?utf-8?B?WU9ybkxmRitZdFR0cS9lWlNSQk5QWEdCSElXZ0JrRVhQNGZjV3pETkMzbWNu?=
 =?utf-8?B?K1JlK2xnUFdlREJqQnZLK0Mwc3ltQzJVYitBWHhkdVRCTmUxN2pHbXVDVDZx?=
 =?utf-8?B?aitXVzZreU5FMVRqMHB5bU1jd0QzWndyVnFRUnVxaytxNDlZOSs1RW5Pa0Rm?=
 =?utf-8?B?WHp0YmVTY0l5MmNsdGdPMHJ4Y3JRNjVXS0l0SEdjdHJ5OTdxZUd1M1NOQjlU?=
 =?utf-8?Q?ucBh9SHEVEVcF2keNSHPKHt/+?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F51010EB3846364AA221E98AB9FD7440@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5163.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b61d5ab6-0806-4806-97de-08da90ef8a4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2022 16:39:31.7606
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sFj++72pMhPiPbB+IQauPXGvjVlouLpFQNpOGYqnfQQn36RPekPtSLNHyBMvJajJ1ASu/fixLxDnlHj0j2hoYi7jQ5+U6Yk9jmU/iK5/gC8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1358
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTUvMDgvMjAyMiAyMzoxNCwgQ29ub3IgRG9vbGV5IHdyb3RlOg0KPiBIZXkgV2lsbC9QYWxt
ZXIvU3VkZWVwLA0KPiANCj4gQ2F0YWxpbiBzdWdnZXN0ZWQgWzBdIGRyb3BwaW5nIHRoZSBDQzog
c3RhYmxlIGZvciB0aGUgYXJtNjQgcGF0Y2ggYW5kDQo+IGluc3RlYWQgbWFraW5nIGl0IGEgc3Bl
Y2lmaWMgcHJlcmVxIG9mIHRoZSBSSVNDLVYgcGF0Y2ggJiBtYWtpbmcgYSBQUiwNCj4gc28gaGVy
ZSB3ZSBhcmUuLiBJIHdhcyBzdGlsbCB1cCB3aGVuIC1yYzEgY2FtZSBvdXQgc28gcHVzaGVkIGl0
IGxhc3QNCj4gbmlnaHQgdG8gZ2V0IHRoZSB0ZXN0IGNvdmVyYWdlLCBidXQgTEtQIHNlZW1zIHRv
IG5vdCBoYXZlIHJlcG9ydGVkIGENCj4gYnVpbGQgc3VjY2VzcyBzaW5jZSBlYXJseSBvbiB0aGUg
MTN0aCBzbyBub3QgaG9sZGluZyBteSBob3JzZXMhIEkgYnVpbHQNCj4gaXQgYWdhaW4gZm9yIGJv
dGggQVJNcyBhbmQgUklTQy1WIG15c2VsZi4NCj4gDQo+IEkgdGFnZ2VkIGl0IHRvbmlnaHQsIHNv
IGl0J3Mgb24gY29ub3IvbGludXguZ2l0IGFzIHJpc2N2LXRvcG8tb24tNi4wLXJjMQ0KPiB3aXRo
IHRoZSBwcmVyZXEgc3BlY2lmaWVkLg0KPiANCj4gTm90IHN1cmUgaWYgeW91IHdhbnQgdG8gbWVy
Z2UgdGhpcyB0b28gU3VkZWVwIG9yIGlmIHRoYXQncyB1cCB0byBHcmVnPw0KDQpXaGF0J3MgdGhl
IHN0b3J5IHdpdGggdGhpcyBmcm9tIGFuIGFybTY0ICYgdG9wb2xvZ3kgUG9WPw0KUGFsbWVyIG1l
cmdlZCB0aGlzIGludG8gcmlzY3YvZm9yLW5leHQgYSBjb3VwbGUgd2Vla3MgYWdvLCBzbyBqdXN0
DQp3b25kZXJpbmcgd2hhdCB0aGUgY3JhaWMgaXMgb24gdGhlIG90aGVyIGZyb250cy4NCg0KVGhh
bmtzLA0KQ29ub3IuDQoNCj4gDQo+IFRoYW5rcywNCj4gQ29ub3IuDQo+IA0KPiAwIC0gaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtcmlzY3YvWXRhYzdHMXpscTZXVzRqdEBhcm0uY29tLw0K
PiANCj4gVGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCA1NjgwMzViMDFjZmIxMDdh
ZjhkMmU0YmQyZmI5YWVhMjJjZjViODY4Og0KPiANCj4gICBMaW51eCA2LjAtcmMxICgyMDIyLTA4
LTE0IDE1OjUwOjE4IC0wNzAwKQ0KPiANCj4gYXJlIGF2YWlsYWJsZSBpbiB0aGUgR2l0IHJlcG9z
aXRvcnkgYXQ6DQo+IA0KPiAgIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9r
ZXJuZWwvZ2l0L2Nvbm9yL2xpbnV4LmdpdC8gdGFncy9yaXNjdi10b3BvLW9uLTYuMC1yYzENCj4g
DQo+IGZvciB5b3UgdG8gZmV0Y2ggY2hhbmdlcyB1cCB0byBmYmQ5MjgwOTk5N2EzOTFmMjgwNzVm
MWM4YjVlZTMxNGMyMjU1NTdjOg0KPiANCj4gICByaXNjdjogdG9wb2xvZ3k6IGZpeCBkZWZhdWx0
IHRvcG9sb2d5IHJlcG9ydGluZyAoMjAyMi0wOC0xNSAyMjowNzozNCArMDEwMCkNCj4gDQo+IC0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0NCj4gRml4IFJJU0MtVidzIHRvcG9sb2d5IHJlcG9ydGluZw0KPiANCj4gVGhlIGdvYWwg
aGVyZSBpcyB0aGUgZml4IHRoZSBpbmNvcnJlY3RseSByZXBvcnRlZCBhcmNoIHRvcG9sb2d5IG9u
DQo+IFJJU0MtViB3aGljaCBzZWVtcyB0byBoYXZlIGJlZW4gYnJva2VuIHNpbmNlIGl0IHdhcyBh
ZGRlZC4NCj4gY3B1LCBwYWNrYWdlIGFuZCB0aHJlYWQgSURzIGFyZSBhbGwgY3VycmVudGx5IHJl
cG9ydGVkIGFzIC0xLCBzbyB0b29scw0KPiBsaWtlIGxzdG9wbyB0aGluayBzeXN0ZW1zIGhhdmUg
bXVsdGlwbGUgdGhyZWFkcyBvbiB0aGUgc2FtZSBjb3JlIHdoZW4NCj4gdGhpcyBpcyBub3QgdHJ1
ZToNCj4gaHR0cHM6Ly9naXRodWIuY29tL29wZW4tbXBpL2h3bG9jL2lzc3Vlcy81MzYNCj4gDQo+
IGFybTY0J3MgdG9wb2xvZ3kgY29kZSBiYXNpY2FsbHkgYXBwbGllcyB0byBSSVNDLVYgdG9vLCBz
byBpdCBoYXMgYmVlbg0KPiBtYWRlIGdlbmVyaWMgYWxvbmcgd2l0aCB0aGUgcmVtb3ZhbCBvZiBN
UElEUiByZWxhdGVkIGNvZGUsIHdoaWNoDQo+IGFwcGVhcnMgdG8gYmUgcmVkdWRhbnQgY29kZSBz
aW5jZSAnMzEwMmJjMGU2YWM3ICgiYXJtNjQ6IHRvcG9sb2d5OiBTdG9wDQo+IHVzaW5nIE1QSURS
IGZvciB0b3BvbG9neSBpbmZvcm1hdGlvbiIpJyByZXBsYWNlZCB0aGUgY29kZSB0aGF0IGFjdHVh
bGx5DQo+IGludGVyYWN0ZWQgd2l0aCBNUElEUiB3aXRoIGRlZmF1bHQgdmFsdWVzLg0KPiANCj4g
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLQ0KPiBDb25vciBEb29sZXkgKDIpOg0KPiAgICAgICBhcm02NDogdG9wb2xvZ3k6IG1v
dmUgc3RvcmVfY3B1X3RvcG9sb2d5KCkgdG8gc2hhcmVkIGNvZGUNCj4gICAgICAgcmlzY3Y6IHRv
cG9sb2d5OiBmaXggZGVmYXVsdCB0b3BvbG9neSByZXBvcnRpbmcNCj4gDQo+ICBhcmNoL2FybTY0
L2tlcm5lbC90b3BvbG9neS5jIHwgNDAgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLQ0KPiAgYXJjaC9yaXNjdi9LY29uZmlnICAgICAgICAgICB8ICAyICstDQo+ICBhcmNo
L3Jpc2N2L2tlcm5lbC9zbXBib290LmMgIHwgIDMgKystDQo+ICBkcml2ZXJzL2Jhc2UvYXJjaF90
b3BvbG9neS5jIHwgMTkgKysrKysrKysrKysrKysrKysrKw0KPiAgNCBmaWxlcyBjaGFuZ2VkLCAy
MiBpbnNlcnRpb25zKCspLCA0MiBkZWxldGlvbnMoLSkNCg0K
