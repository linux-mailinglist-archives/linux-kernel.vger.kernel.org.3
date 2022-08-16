Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D10C5957A7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 12:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234309AbiHPKKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 06:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234296AbiHPKJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 06:09:32 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30C225C9;
        Tue, 16 Aug 2022 02:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660641804; x=1692177804;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=BH0BcCmdhAl6J0cUOZnXuUoreaNt+wA5HajUqK/sFZM=;
  b=zJQKMFj7Wlp76cCMQx7G/3TXjw++JhN1HA4CWsSTsvpThbNQmNaychWZ
   irW12moAFwA1tKu4gn0Z3qewe1ZCFIB0w9eUahMOYEjI56QmcWDuX5WQS
   SwVL0In9zPLmmYR4ywuZKClmQ1vc/OZ/YRCajJ5R6yGZeyqKYFkrE0cjt
   +GwWBmUT0EwKF42AaOVl1EKMaXh86x+DpSBo/BXFZjGIlNORfYMYF2DbJ
   cGe5/BEx7KcV8RSVJCu7dAlls2PfW2wVNCKQ9zpOQtlAFT8ExLGmvN+La
   rq71NmP3iR1NVC/gtdKkjmdPM1VOqFgH/WuFsnLrIwlScrikqqeR1GF0x
   A==;
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="176408427"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Aug 2022 02:23:22 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 16 Aug 2022 02:23:21 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Tue, 16 Aug 2022 02:23:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RFHldnoeR61Cs8kHxXQdnTPRltpkTq3Dd9yQTs1VD2SSimSupLqDMHf2MEWawI1hVwLtwSPNS8cpBzDHMj4Umqcvu7v+1yaQGg2wxHVTsWfzbYUaMpP0B+HQWVwkJ36RX8kqZJHTbE1VY9Ffk/CGejisJKoUWKRMiqoYTbt2gCEULTBWhDkHyUSEdXwIm81GjexDRCQRPZ/QDNZ8Mpjvll57RWwuWP56STdribNnfo66eY9i8QQP0vHRjjpAw7PgqBDyJGO6514sfUsXRLm8aGD8tMitb15NsWSaN/MS068BHeluKAUZqm9RP0HtnsM6uwOUkxnI7IPEopP1Djn8CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BH0BcCmdhAl6J0cUOZnXuUoreaNt+wA5HajUqK/sFZM=;
 b=Oip8J3M6sqQ2m8kuox+Dx8a6TXRnuhTrwxjBwe275gYFT0HJjZJJY2pF4k6mMVQTClNC4TMhe6TtaExj/8SCKsRfReBPtiVgG7m7hCbDnaIPgnugNqwnJvxJpS52DRHZ+GrTezuBeMfxvNJfTMx9wnfrsX4rdozWQINxGv+lhPO9Ufo1C5zkBD/8tLqQkRDjDbm1YL7cEvIX3wk0VKkRWNcqtxxYKdQewl6uJt3fL1AFYOuD7OgrqpQdCu+khWCvNuX38a/o0/asjVSO8aIzyFfJ21IrL8cbWsACatRHEAqEe85mEz4GaGOHVzpFcnys2cLsg4WXKcQM6e1I03h03g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BH0BcCmdhAl6J0cUOZnXuUoreaNt+wA5HajUqK/sFZM=;
 b=Jp+1I79220Cc5Bi2IuFPd7hRhWEMksefEKN1Ez+SYHV7/To6ttQLExrmWJ/TRuvKtH0cRA/RGCW4SjXC4Fx2+uixhXtrqwPrNxDWCxgfantlq7ZpLdkSvEYDdpUfL5265pCPtOXisDfQJg78gfLRiySa5lyNIJ9CwMIAFKDHftM=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by SJ1PR11MB6082.namprd11.prod.outlook.com (2603:10b6:a03:48b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Tue, 16 Aug
 2022 09:23:16 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%8]) with mapi id 15.20.5525.011; Tue, 16 Aug 2022
 09:23:16 +0000
From:   <Conor.Dooley@microchip.com>
To:     <heiko@sntech.de>, <samuel@sholland.org>, <wens@csie.org>,
        <jernej.skrabec@gmail.com>, <linux-sunxi@lists.linux.dev>,
        <palmer@dabbelt.com>, <paul.walmsley@sifive.com>,
        <aou@eecs.berkeley.edu>, <linux-riscv@lists.infradead.org>
CC:     <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 05/12] riscv: Add the Allwinner SoC family Kconfig option
Thread-Topic: [PATCH 05/12] riscv: Add the Allwinner SoC family Kconfig option
Thread-Index: AQHYsGUenAhsNLm10UuriMAjeDMYs62wLxoAgAESFwCAAAGTAA==
Date:   Tue, 16 Aug 2022 09:23:16 +0000
Message-ID: <53fa815e-b4aa-7dea-a403-c29738af296e@microchip.com>
References: <20220815050815.22340-1-samuel@sholland.org>
 <20220815050815.22340-6-samuel@sholland.org>
 <a70e34b9-7106-ad2a-16e1-5f115e34ff1e@microchip.com>
 <10785313.BaYr0rKQ5T@diego>
In-Reply-To: <10785313.BaYr0rKQ5T@diego>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 54e2e5d3-3c14-4ef1-6788-08da7f68f36f
x-ms-traffictypediagnostic: SJ1PR11MB6082:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8GFZyMfPeA5MeNi/Qjt4pztnjblW5T9FWZsIyRThnD4L/YnXFmEF1vwMacsIy2NiLASp8zU7s9wqaImFYVFDh5jTQNa43tYv6dB5YxBP6AOANmaRRST6faGzpvzjLDIh1Cl2JY7I97xYpQCwCCDtgOd0F46TDAIGP2I/MCPgkBkOQDM4QpDxXoTHc9tYgB5P/fw3SVOPnbd/yAvgwM/fuT8AOQFwKDMROYose9CgxSyM4wWWWICItjRSFc3esW/tpaLjH0MxSDMoPi3nHR+r8mVIMmBtXz8UcVajX288iPUZazrSoz4TpmtAXF5RD/jy7H2gUYXQXLlaPGZhicoJdvoo2KfwBUNrKiwATtZ8j3QoztRJt2wmd0qfQG+6yRaC2wgc72bzew40MomRCsA9Bkx29yqaBJBGPDKs0PiwuAPHGoWmcl55wYT7id3+uz1VfIZm5DxqfhF1pbdPHp55CkkRxthHk+DQLHsBsw8MPTwM6xTwgaS1am5foFd7Y1pLmT+dCxZyWBJIIpASreImI+hdFlAVhloYK2lYGg3WPuPhQrNDRVRMTNV58J1xeghIqWjxQW+D0ezSJBqu4JR1b9KqwWHyWvY2i3EU5Tzv2wtgV2qiS4LDZ2mQkgYjY7qxZGQC7v8TFYoIbcZuwmzIWvpH5jmR49C/t/zJJ/jt3u14IovKACHOyXcrMTjtFtvr5WNZicQwdqD8Oc0BIUte2xAhxzwQI8TgwmLQGzFB7q1wm69mEdiaOrOirT+uXIbBEbiiYbwGcac/Hwztr6O7KBgoerwDGdK5G7z6Ca3tTAaLZ/xQDlPv9vS1QkS3vSaChcGDY6Omt03QWoUyzRzbcE2jD8D5GOf1xlxugZmYNiXb96ms4xeC9wYjjKLTRm016RI9jPz+0TD5A8q5bJTREw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(136003)(39860400002)(376002)(346002)(6506007)(966005)(53546011)(2616005)(478600001)(41300700001)(2906002)(86362001)(5660300002)(31696002)(7416002)(186003)(6512007)(26005)(122000001)(38100700002)(38070700005)(83380400001)(66574015)(8676002)(8936002)(110136005)(66446008)(31686004)(36756003)(54906003)(66946007)(91956017)(66556008)(64756008)(4326008)(66476007)(316002)(71200400001)(76116006)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bXlqa3VBTlJlSkRSV1Z0Z2wyNm1PWHBXVEo1dGNJeUxoVnRPcFNmZi8yOUVY?=
 =?utf-8?B?QU5mNVdLTEduZEVkRy9Lajd6RnpVbVBZdHZLYmdTa3U5czl4Qk8zd2p4amdm?=
 =?utf-8?B?VGtOcndqVzk0d25LaUFpbTh4YnNvelVNZnVrUnllWHNQVHFkV0hITms2bFlz?=
 =?utf-8?B?ZGFvc3p4blFncjh2SUFwMExSeXBNZ3QvclNjYkR5UWtPMXFtNDBIdU45ZmVj?=
 =?utf-8?B?VFR0OWFLMkpINDk5TXFaSGw1QTBscm9UeWpQYkhMVGt1NjFUYzJ4d0hFZ1No?=
 =?utf-8?B?YzNINWRwWnovQTNidm4rR3dMMzNUcTNhcTkyZ21oWktkYUZpL1V6ZmNwdHVz?=
 =?utf-8?B?VkZPV2hldEREeWdqdkp5QlZXa0p1dmY3N1VFSmlKdHpGcGZzZ3MvT1p3SXEw?=
 =?utf-8?B?RmZkbmdqVWovN0VaZ3JkZlVFZXJoVVpqN0hyUTlsa3B1Y0sxNENsdTFQMXVN?=
 =?utf-8?B?SFY5aVFOUHRSTDEzQ3BlZ2FHYS9FTWlMdnI4RDNGTmNCV0tPUThwQkVMckNI?=
 =?utf-8?B?a1huNWJteFZ3QlNUUFU2NlB5dGFRYUJmOWFtM3BjbDF3UTdFU2lPV1AwMHNF?=
 =?utf-8?B?QU5kTUo0SUZaZmdCaWZlSFBrdHFXTi93d2c2K0hXWUMySnYyL2lvYm50MjVw?=
 =?utf-8?B?S2M3blBDQVhVQ3Z0cmVVRHlrYTk2ODBXWGRtU0s0aHBNNXVWV0pFZzNsampT?=
 =?utf-8?B?bC9YVk5KY0ZzSWlLS3M3OGV3cmVIV05wZDZ1dmN6ZzlWQTJzOTNOK0tpVFFM?=
 =?utf-8?B?ZjNmOHNsRUg4cFhhWHg5M2h5N0E0Z3Y4SStPN0JqNmRReGE3SEhjeTdFQjB4?=
 =?utf-8?B?V0pBVkkwVkplRXNKY3ByUFpRL3J3azF5UWpoU3Zzem8yWGdXZ0t1dlorRE1u?=
 =?utf-8?B?S2N2WDM5aFB6THE3cnI2WmJ3ZGF5VENwZ09EZ3M0K2VKV2NBSmpjRlNGTnZU?=
 =?utf-8?B?UTFpbjVTamVETE9nM3NOZm94OU51M3FiOUNZWFdCRHdBUGJHSTBIMGNQMzl2?=
 =?utf-8?B?VDZaa0VpYzNGbW5lZURpK2d1NWMyM01hV0ZmcEtXWWhXNFpIQzFOTksyVW04?=
 =?utf-8?B?cUNFZGlpZEdNalN1MlJFZDRGTmFQMkhDMGpSM0J2UTBNZ0VMZFVYem9RY09V?=
 =?utf-8?B?R2N0K1QrMGJkckdVMnl3cjNnMFhkeFdOcDJDWHY2Z0I2dWZIQUxxSmcranMv?=
 =?utf-8?B?eDIrdm00c2lCTWxld1d5aE5oeWJmblp2Q0lLb2JXQm5ZOTdoek1Ga0FJOGI2?=
 =?utf-8?B?UG16cjVoc2VibjZjdEhyNDZPQWdGb3RXMEZTYmdFWk8zSzVyR2pPd1ByNHBN?=
 =?utf-8?B?bm1LbzcwamplUXdBRXBGQU9HQWMyQjl5WENJbmhibTNCZnlJUDlRZTNtT0xk?=
 =?utf-8?B?MERZclgrd3ViempLQmZvOGZOMUR3WXg5ejdxdmRDNEZEbmk1YllmUjJta21G?=
 =?utf-8?B?SHdLWnhTREt5emNVeFFnY0RpcUNTSjJEOUp0MGtVdVlvckRGQ0g2QUhOQURu?=
 =?utf-8?B?YS92aG92WDcyZStqc3RDL2xnaGlhT2VnSlJTZm4xQ1p0WWsxRWFsMTN5ODhp?=
 =?utf-8?B?L0l5d0NQck9jZkpnQW5NMjRSa0ZRSkN0L3VtVGhxRmxST3lsWUdpUVpKYUpk?=
 =?utf-8?B?Rkk0N2Znb2wvRlRGd0hQRkFlbE1qaFZYeitkUVBvVldyNGd5RjdXUnQ5dE9H?=
 =?utf-8?B?Z3Zrd2NSYi9KVmN0Z0Z2bmd3QkROemxBMWdaRjgwSVdKK0J4czQxR0V3T3Ru?=
 =?utf-8?B?SzFjK2psd2V1Y2EvbTJQd3pjZTR5Sld5RVZOOUFNWEh2bTB2NnorSHRKczVu?=
 =?utf-8?B?MUorL1Q3L0YzY0RjQ2FYNFJiR2JteGd6NmNHeVNDdW80ejRxajJqamZVdHNP?=
 =?utf-8?B?MzdKY3k3MTNEY29Mazl1R3gya1huSExCTUkrWWxRelozM2RiYXcvck5UUVRv?=
 =?utf-8?B?VXpMR2pvYXhxSTJuM1Y0ZkRYc25hZ205aUEvdE4yMVdjQnV1VERQSFhnN2VO?=
 =?utf-8?B?d1dPb1dnQk1zS2N1RG1Bd3NpbTZpSUZzWW1mUnROcVFxVEVrNU9ubHFzMEQy?=
 =?utf-8?B?N2VpbHBYcWd4SUJXT2FORlJlTjZnK3RqSHVDMlFwdnpmTkFLaTM5RFNibkxv?=
 =?utf-8?Q?QOdOP4ctwi4iZokhPcft3nYwl?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <01CDFEE6E52B6D4DBCAA9D0B733ACE74@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54e2e5d3-3c14-4ef1-6788-08da7f68f36f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2022 09:23:16.3681
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: funYJFxsMyxVVZf6qdpWphaM5afwQFNK1nm5FBc+C5qQYIoRfWLqivgEq8Gp+BsJm2xi/sU1sCFZWAZII7D2DYqSeUDOlgdDD4z5TvCV3B0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6082
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTYvMDgvMjAyMiAxMDoxNywgSGVpa28gU3TDvGJuZXIgd3JvdGU6DQo+IEVYVEVSTkFMIEVN
QUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtu
b3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gQW0gTW9udGFnLCAxNS4gQXVndXN0IDIwMjIs
IDE4OjU2OjIzIENFU1Qgc2NocmllYiBDb25vci5Eb29sZXlAbWljcm9jaGlwLmNvbToNCj4+IE9u
IDE1LzA4LzIwMjIgMDY6MDgsIFNhbXVlbCBIb2xsYW5kIHdyb3RlOg0KPj4+IEVYVEVSTkFMIEVN
QUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtu
b3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPj4+DQo+Pj4gQWxsd2lubmVyIG1hbnVmYWN0dXJlcyB0
aGUgc3VueGkgZmFtaWx5IG9mIGFwcGxpY2F0aW9uIHByb2Nlc3NvcnMuIFRoaXMNCj4+PiBpbmNs
dWRlcyB0aGUgInN1bjhpIiBzZXJpZXMgb2YgQVJNdjcgU29DcywgdGhlICJzdW41MGkiIHNlcmll
cyBvZiBBUk12OA0KPj4+IFNvQ3MsIGFuZCBub3cgdGhlICJzdW4yMGkiIHNlcmllcyBvZiA2NC1i
aXQgUklTQy1WIFNvQ3MuDQo+Pj4NCj4+PiBUaGUgZmlyc3QgU29DIGluIHRoZSBzdW4yMGkgc2Vy
aWVzIGlzIEQxLCBjb250YWluaW5nIGEgc2luZ2xlIFQtSEVBRA0KPj4+IEM5MDYgY29yZS4gRDFz
IGlzIGEgbG93LXBpbi1jb3VudCB2YXJpYW50IG9mIEQxIHdpdGggY28tcGFja2FnZWQgRFJBTS4N
Cj4+Pg0KPj4+IE1vc3QgcGVyaXBoZXJhbHMgYXJlIHNoYXJlZCBhY3Jvc3MgdGhlIGVudGlyZSBj
aGlwIGZhbWlseS4gSW4gZmFjdCwgdGhlDQo+Pj4gQVJNdjcgVDExMyBTb0MgaXMgcGluLWNvbXBh
dGlibGUgYW5kIGFsbW9zdCBlbnRpcmVseSByZWdpc3Rlci1jb21wYXRpYmxlDQo+Pj4gd2l0aCB0
aGUgRDFzLg0KPj4+DQo+Pj4gVGhpcyBtZWFucyBtYW55IGV4aXN0aW5nIGRldmljZSBkcml2ZXJz
IGNhbiBiZSByZXVzZWQuIFRvIGZhY2lsaXRhdGUNCj4+PiB0aGlzIHJldXNlLCBuYW1lIHRoZSBz
eW1ib2wgQVJDSF9TVU5YSSwgc2luY2UgdGhhdCBpcyB3aGF0IHRoZSBleGlzdGluZw0KPj4+IGRy
aXZlcnMgaGF2ZSBhcyB0aGVpciBkZXBlbmRlbmN5Lg0KPj4NCj4+IEhleSBTYW11ZWwsDQo+PiBJ
IHRoaW5rIHRoaXMgYW5kIHBhdGNoIDEyLzEyIHdpdGggdGhlIGRlZmNvbmZpZyBjaGFuZ2VzIHNo
b3VsZCBiZQ0KPj4gZGVmZXJyZWQgdW50aWwgcG9zdCBMUEMgKHdoaWNoIHN0aWxsIGxlYXZlcyBw
bGVudHkgb2YgdGltZSBmb3INCj4+IG1ha2luZyB0aGUgNi4xIG1lcmdlIHdpbmRvdykuIFdlIGFs
cmVhZHkgaGF2ZSBsaWtlIDQgZGlmZmVyZW50DQo+PiBhcHByb2FjaGVzIGJldHdlZW4gdGhlIGV4
aXN0aW5nIFNPQ19GT08gc3ltYm9scyAmIHR3byBtb3JlIHdoZW4NCj4+IEQxIHN0dWZmIGFuZCB0
aGUgUmVuZXNhcyBzdHVmZiBpcyBjb25zaWRlcmVkLg0KPiANCj4gT24gdGhlIG90aGVyIGhhbmQs
IEkgZG9uJ3QgcmVhbGx5IHRoaW5rIGl0J3MgdGhhdCBoYXJkIHRvIGNoYW5nZSB0aGluZ3MNCj4g
YWZ0ZXIgdGhlIGZhY3Q/IEkuZS4gQVJDSF9TVU5YSSBpcyBwcmV0dHkgbXVjaCBzZXQgaW4gc3Rv
bmUgYW55d2F5LA0KPiBzbyB0aGVyZSBpc24ndCB2ZXJ5IG11Y2ggdGhhdCBfY291bGRfIGNoYW5n
ZSB3aXRob3V0IGFmZmVjdGluZyBtb3N0DQo+IGRyaXZlciBzdWJzeXN0ZW1zIGluIHRoZSBrZXJu
ZWwuDQo+IA0KPiBTbyBJIGRvbid0IHRoaW5rIHdlJ2QgYWN0dWFsbHkgbmVlZCB0byB3YWl0IHdp
dGggdGhlIEFsbHdpbm5lciBzeW1ib2wuDQoNClRydWUsIGJ1dCBpdCdkIGJlIHRoZSBzYW1lIHJl
bGVhc2UgYW55d2F5IG1vc3QgbGlrZWx5IHNvIEkgZG9uJ3QNCnRoaW5rIHRoYXQgdGhlcmUnZCBy
ZWFsbHkgYmUgYW55IHdhaXRpbmcgaW52b2x2ZWQuIEkgL2xpa2UvIHRoZQ0KaWRlYSBvZiB1c2lu
ZyBBUkNIX0ZPTyByYXRoZXIgdGhhbiBTT0NfRk9PIGFzIGl0J3MgZmFyIG1vcmUNCmNvbnNpc3Rl
bnQgYWNyb3NzIHRoZSBrZXJuZWwgLSBpdCdzIG1vcmUgYSBxdWVzdGlvbiBvZiBub3QgZG9pbmcN
Cm9uZSB0aGluZyBoZXJlIGFuZCBhbm90aGVyIHdpdGggdGhlIFJlbmVzYXMgc3R1ZmYgdG8gbWUu
DQoNCj4gDQo+IA0KPiBIZWlrbw0KPiANCj4+IFBsYW4gaXMgdG8gZGVjaWRlIGF0IExQQyBvbiBv
bmUgYXBwcm9hY2ggZm9yIHdoYXQgdG8gZG8gd2l0aA0KPj4gS2NvbmZpZy5zb2NzICYgdG8gbWUg
aXQgc2VlbXMgbGlrZSBhIGdvb2QgaWRlYSB0byBkbyB3aGF0J3MgYmVpbmcNCj4+IGRvbmUgaGVy
ZSAtIGl0J3MgbGlrZWx5IHRoYXQgZnVydGhlciBhcm0gdmVuZG9ycyB3aWxsIG1vdmUgYW5kDQo+
PiBrZWVwaW5nIHRoZSBjb21tb24gc3ltYm9scyBtYWtlcyBhIGxvdCBvZiBzZW5zZSB0byBtZS4u
Lg0KPj4NCj4+IFRoYW5rcywNCj4+IENvbm9yLg0KPj4NCj4+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6
IFNhbXVlbCBIb2xsYW5kIDxzYW11ZWxAc2hvbGxhbmQub3JnPg0KPj4+IC0tLQ0KPj4+DQo+Pj4g
ICBhcmNoL3Jpc2N2L0tjb25maWcuc29jcyB8IDkgKysrKysrKysrDQo+Pj4gICAxIGZpbGUgY2hh
bmdlZCwgOSBpbnNlcnRpb25zKCspDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9L
Y29uZmlnLnNvY3MgYi9hcmNoL3Jpc2N2L0tjb25maWcuc29jcw0KPj4+IGluZGV4IDY5Nzc0YmIz
NjJkNi4uMWNhYWNiZmFjMWE1IDEwMDY0NA0KPj4+IC0tLSBhL2FyY2gvcmlzY3YvS2NvbmZpZy5z
b2NzDQo+Pj4gKysrIGIvYXJjaC9yaXNjdi9LY29uZmlnLnNvY3MNCj4+PiBAQCAtMSw1ICsxLDE0
IEBADQo+Pj4gICBtZW51ICJTb0Mgc2VsZWN0aW9uIg0KPj4+DQo+Pj4gK2NvbmZpZyBBUkNIX1NV
TlhJDQo+Pj4gKyAgICAgICBib29sICJBbGx3aW5uZXIgc3VuMjBpIFNvQ3MiDQo+Pj4gKyAgICAg
ICBzZWxlY3QgRVJSQVRBX1RIRUFEIGlmIE1NVSAmJiAhWElQX0tFUk5FTA0KPj4+ICsgICAgICAg
c2VsZWN0IFNJRklWRV9QTElDDQo+Pj4gKyAgICAgICBzZWxlY3QgU1VONElfVElNRVINCj4+PiAr
ICAgICAgIGhlbHANCj4+PiArICAgICAgICAgVGhpcyBlbmFibGVzIHN1cHBvcnQgZm9yIEFsbHdp
bm5lciBzdW4yMGkgcGxhdGZvcm0gaGFyZHdhcmUsDQo+Pj4gKyAgICAgICAgIGluY2x1ZGluZyBi
b2FyZHMgYmFzZWQgb24gdGhlIEQxIGFuZCBEMXMgU29Dcy4NCj4+PiArDQo+Pj4gICBjb25maWcg
U09DX01JQ1JPQ0hJUF9QT0xBUkZJUkUNCj4+PiAgICAgICAgICBib29sICJNaWNyb2NoaXAgUG9s
YXJGaXJlIFNvQ3MiDQo+Pj4gICAgICAgICAgc2VsZWN0IE1DSFBfQ0xLX01QRlMNCj4+PiAtLQ0K
Pj4+IDIuMzUuMQ0KPj4+DQo+Pg0KPj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18NCj4+IGxpbnV4LXJpc2N2IG1haWxpbmcgbGlzdA0KPj4gbGludXgtcmlz
Y3ZAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPj4gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFp
bG1hbi9saXN0aW5mby9saW51eC1yaXNjdg0KPj4NCj4gDQo+IA0KPiANCj4gDQoNCg==
