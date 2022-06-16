Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A6C54DA97
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 08:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244181AbiFPG2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 02:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359182AbiFPG2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 02:28:39 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6400A56227
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 23:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1655360915; x=1686896915;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=UEN2wQ2PcCAAHTpigNf3+waHDkNtiMp9/b9iY7PzDrc=;
  b=jKD9nUYIcT7/j0TZovh3D7xVg7ENSKW8N3jTsOfVSh4y8zCwUuJ8i/qM
   Pyd8tA0wp0xLD5gq2ZcsOzjhX+7mcg8oOT12BoIe8eyq95IJBBik25AB/
   3c7W6d1Ok7wvS6o2aSyRTE2VV/YE7pDuOliWipjeGYbjwlgCN+TgHVd6l
   /8dW06eTSqrODCRmt5PPeuZGsCYNzfreTZmUQ37+Ll8GrTX6lU4xzCIpn
   KSj8T1GQcb+822NBjmj8kEw8jTAH72wBQ0VksO9uykamQHcKUbtRJA1wx
   qBIFjq5gQaV5BRLLsUI4LVG3oTztVKTjAXHSEym5+f+19EpWqkJeFaQ0i
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,304,1647327600"; 
   d="scan'208";a="168334642"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Jun 2022 23:28:34 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 15 Jun 2022 23:28:32 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Wed, 15 Jun 2022 23:28:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iy8ItVgqNRL0Dfzt06LOw1FZiyVmWmesKHHpWvPd1nuvSMJJ6If7iRqjmRBll6K/FkyCj2VMB+iUAJX+mE1uxurXQHABkMa8xiQPsyhP0HckuO3FxgXJ3mO1F0Nl/0OAX3B6oBgYjzxtYRfIXYWeoqVTCtdjcJQB/c0D/j9qF7MvlxCMOoXp8Ghz69IcnvsNg9jEtgiBV+27ReorCAhD0osEMPTDQlgWutk9y21jo08hm1yTbTlfoLo9dvPcxV+JQxY/Bkm/MoBsBeGpMd9d4mDpUrQZ/Xex/ua1zUH947phl6U4fznwymcEd3fOzA/CTr58/VJL/62R7LvgZISHyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UEN2wQ2PcCAAHTpigNf3+waHDkNtiMp9/b9iY7PzDrc=;
 b=TjzoAppvSeYy95WcoiiEiKgTldwxF77ei1yOSw+UY2xrglPmJ/mvGLEkvL5EAwWXWnOiUmiWmK6CZVGusCdkMpXoclq8x5pBH1XXcWh9P+/50trMDFG/Ny8lSrRuL4MI8wIAnz09wFwSpnKxRYEGxngb5rbLQr68azU4Ce4rjrgSfFJJaIj5MYvhuSsBz+E/NwERqa0DrJ3IxL9wfC5t5RdnrIiBPePdwQ5uCpQDY0C3AT1XRCyqr9aJtUDYFrFNk8uepvxVGVNxwsMVYpwdT75aLAXP9MV2v8V3wBihdalybJjzlqtyDUdmBSDX8RWGmLqtLn5GlipOfXq5L6vr3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UEN2wQ2PcCAAHTpigNf3+waHDkNtiMp9/b9iY7PzDrc=;
 b=BYtQBdVcTARrVff4hKQ2hqgwqHv0DbkocwRcwLenNSnfTDBX+D3VBygC+SlIkO/60Q8a9X80Vi1HCGHlwFDHunF4ZM9DQL7TTB1q+zn7j1Bguh0FjdzytY9YG+Av/kqvuyeh9LtnykeG8mvY4+9vmpYHEiEk7Ebhnl8NrDOHz38=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by MWHPR11MB1678.namprd11.prod.outlook.com (2603:10b6:301:e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.17; Thu, 16 Jun
 2022 06:28:27 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa%4]) with mapi id 15.20.5332.022; Thu, 16 Jun 2022
 06:28:27 +0000
From:   <Conor.Dooley@microchip.com>
To:     <windhl@126.com>, <palmer@dabbelt.com>, <paul.walmsley@sifive.com>,
        <aou@eecs.berkeley.edu>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <lkp@intel.com>
Subject: Re: [PATCH v2] soc: sifive: (sifive_l2_cache) Add missing
 of_node_put()
Thread-Topic: [PATCH v2] soc: sifive: (sifive_l2_cache) Add missing
 of_node_put()
Thread-Index: AQHYgTyU734TRAppZ0+mlMW5BVjq3a1RkayA
Date:   Thu, 16 Jun 2022 06:28:27 +0000
Message-ID: <7a4a3fed-333c-a7f4-070f-2e7e2b798810@microchip.com>
References: <20220616044915.3978097-1-windhl@126.com>
In-Reply-To: <20220616044915.3978097-1-windhl@126.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0e520b33-f578-4542-b80f-08da4f616c67
x-ms-traffictypediagnostic: MWHPR11MB1678:EE_
x-microsoft-antispam-prvs: <MWHPR11MB1678EE08ADF54A1113BA82AC98AC9@MWHPR11MB1678.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kMXFw35OTs6XgmgDvlTrrlH1RsgbiTHWFR1R8mTSp6I8JgaEcnrLielwh0KrvkuvGHk57bwVBfqVSxA3bcbutIGoV4wIE3rqwBRuqBi5yBYj+4t2dXe+DVzFkPX0mmlNY3d4uVXIlribo8ROh87txthHuJo9KD+ql2h7U4Cw2zn+RrK/ltzWtV0w0QV7tEMNwICEbNhtqzcJ5EaZRPXC1mBtS9JLraW7hFtaVDe1IVpf3xlHA0mIQM8LOuwbEQTnLilx+7oCAtKiUTvJA2jfErg1z+3Dqkzr6aU3SalkXWcoVBW+ncVM30RUqO7Ggou4Ns5PBUG1+CY4YqTCN+ro3rI67sn7r1Hsia6wF348+dixQvyEqWEG/FGC193KSdYXcVq1RFRk9rDaoYMngaUCIdWHKOnxDtt66hFzVOeyYFbXFbw9lVoiMbhUk10R4749hNSRex75HZzptSHuOJrVWOdtemARG67F6Inmp94rsQjWthwos2q3CgaxmCrJJPhIfNsFakC/m1Asp2o+UlvNdA9WzAeYP/wcwY/PvL2GQb1LdtoFr2nw3refqWAoANJagqdJmGawaN+wej+O1PWEKKwZxu1/teoUw4lYu/THupCNFprqFoNNR7QsItn13VG6/NBPkwJL8JomByRmYchZc8pOQbeMXHa1115tHQRyo2AFZ7u00s6pGsQYAqipnDUfGJAirq1yLg/NSozVKm8u8zcyp+XIuBXXjy8OC55vhExDk00Mc3W0fNGYGvPIHfVQILTTUd/tx2m9ucml2u/swx/8apQAqq61Fq0CUx90q1KwtSIvMteLMfn85VvPVnpG4kyA/ojEw+p5XTnvXsFotoE1BszIx1L6Dd+TGFHK9D8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(5660300002)(2906002)(8936002)(31696002)(83380400001)(122000001)(38070700005)(53546011)(66556008)(6512007)(36756003)(66446008)(8676002)(64756008)(508600001)(71200400001)(6486002)(38100700002)(4326008)(6506007)(66946007)(316002)(76116006)(54906003)(2616005)(110136005)(186003)(91956017)(966005)(26005)(66476007)(31686004)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UkJicU5RYW00aGtQbWs3VjIzWUhxeER6V1hoSkJpMHA4M1BIdzk2c2t5b2Zt?=
 =?utf-8?B?OEdJbVc4eFQrZXdWaVdSVko4RUpQa3RzNWlwSnJGM0h3RHZwQklleHFZN1F3?=
 =?utf-8?B?R01XMGdqWDlwT0R1d095N1o5c2xVY0FtbGZpNU1sWWpQbWNlc0dhUmlFcXpJ?=
 =?utf-8?B?ekZoQ2dzRHdlLzJpYW1TUTMyM2ZJaXR4ZjhmU2U1bk5SMjF6MkgrUHVKakxZ?=
 =?utf-8?B?L01IbXlRcllESVF3Q3M0eHBxeno0UUNmZ1M1TVBiWFlGVkZjbjErRzRRWnR1?=
 =?utf-8?B?WkY5MExVeVRacW9Jbit6ak9SMWhETFVsY25EK0dZTFJpci9xUVR6YjdqZjdm?=
 =?utf-8?B?NHVudzFEa3JSanRwelAxWU5YZDd0eGo2VUdFSldEdnNPQVpZbnRZcWNacTZu?=
 =?utf-8?B?NmxOQ3hmVnlURi9qaTFPMDNkSEhyNHRNUDNOWUtibTF3Yms2K2ZSM1EzMkg3?=
 =?utf-8?B?UEpSTC9HSEZYM1dnbE1KWXRJcVZPTjlRZ0RNNllxUllXSjlRNHFXd1pkR1B2?=
 =?utf-8?B?THB1cXZCNDlSUUU5WG9CaVh5c3Z6OUsvMSs4aTdvZ2ljd3V4LzFnRUJsWEwy?=
 =?utf-8?B?ME9GUWs0emtBS2FralI5dGlVbytyWEI5VDJ2QUJzUk1NVjdPUFVTd0ZqNlEy?=
 =?utf-8?B?RXJEek4rNU4wL2xQRHdaV2VLRW9UNGdGNWVOaWZ1ald1Ni9KVGltcFJwNTlK?=
 =?utf-8?B?eExvdEVmdHFneDl5dExDQjRTVlcyaWQvQUFSMlF0YW9LdDhLN1NZMWQzMWR1?=
 =?utf-8?B?QlFickQ3SWM0YVRJZmtjQzhOWE9LdmgyUFJzYnZaVk42NXVVaW5TbUxhKzR6?=
 =?utf-8?B?c1VzR1o2a2FOb0VDcTV1SXd4SElhSGtQRy9jZEYrVFJ5TGRobW50K3B1MFVr?=
 =?utf-8?B?bnZ4ZWxiWjhaTUxNOGVqTm1MWUE4MnVjTTRqeXpmSW41eWRlMXZJQ0tNZ0NN?=
 =?utf-8?B?RzZ1d2d1UUtJY09QVkxtMVBNYVZmaEtGQ0J5N010ekI4eUx1cnRNRitRYnd2?=
 =?utf-8?B?ZUR0eU9NeW1nQmM4SzBZOEtQclAraEo3MXlsVkphMllOK0JLTUVpaXA0T0ty?=
 =?utf-8?B?Q1EzQVZDNFVobzF3RE5uU21LcmE1ZWd6ZVk0WU5tNmpOT09FY3dHaFd6OXBq?=
 =?utf-8?B?YmgvVmNKbmlyaEw1Q1kyUmQ5MTVMd250YnFod2RYRkExREY1UU40SlBmbUVr?=
 =?utf-8?B?U0NGdGV1dXFqdFZYdDFmTXBEVkF3QjN3L3lTaElHWHJyM0U5TjA1ZVhHZk03?=
 =?utf-8?B?c3lmS1I4enhJbk8rNm5nRG1UYlN4SGtyL2xvZVAvUVloUW9xVWpIMzJkK1lH?=
 =?utf-8?B?Q0MyZFhhTm5Sc2ZDUDcwNG0xd3FGYU9oOUlvUnVGTnhrK28yUStMalpjM09W?=
 =?utf-8?B?Sjh0eTV0ZzBZODUyZFFqYkM3cXAxQnJ3anNCRnQ4MnNpejlhdWo4SXZLbjBO?=
 =?utf-8?B?Z0kzaGJvZnNtQmRHZFZFUmVQMXRkZ3k3NEpxM05yZmpkcHVYcW9Eb1VYejgv?=
 =?utf-8?B?REFFRnpOWFFuSGJHTkx5RGZ6UDlCWjA5SCtVdGdlVGlKekxIR09kNVhmdlhP?=
 =?utf-8?B?cXBpd0RVYUJEWnN6Z2FWTElXOVFTRWlaLzlwcG1zWmFJUEZPeG16a0ZGd3FV?=
 =?utf-8?B?WWxvOEhJcHlpcmhJOWl3d0prM3BucDkzTjQwKzBBbmt6T09uNk9VaGpSMHd4?=
 =?utf-8?B?N1dsbEc1VVkyWHVsdDJPK0lIUVdkb3VTMmVkUDgxVVFudCt5Tlk0YlB6elBN?=
 =?utf-8?B?WVpEZGxWdEhjNzlIT2VrQ01iYk9iandxVjE3bVJuaEhadlkxWjhzMGxxUHcv?=
 =?utf-8?B?VlVrbEQvbytTUFNPY2ZVK2ExdEREc1VVcTFZYVpBN3FOSEpnNHY2QkxNYUlC?=
 =?utf-8?B?d0wyVUp2RUgweDV5eTNzRGFXMVdPeHZsekVVdTA3aWNWSEZYL3QzbXQvekZv?=
 =?utf-8?B?cGJmanFlQ2w2NEdQVjNXODhYdXlzemNGTkxtYUVwUTF0Y0NENzdsMEFaQmdV?=
 =?utf-8?B?MDFnSTNyS2pKYlFaMVY2TkxNQ2N5YXJWekFtRXRnaTJ5WTdUUis5K1U1djIw?=
 =?utf-8?B?U2paRDJheDkxTHlLdi9mWDl3WmNDSEZwaVFNZmR6MWRpaHJHQmpZczJCM0px?=
 =?utf-8?B?Ri9UNXR0RDYvWXhYaXZqcFFqYWRnTjVTWlQ5eDNRcjNGKzd0ZVFhNWVWUXBt?=
 =?utf-8?B?UFkzQ0g5TmM0RGpqRDR0bUVQL25vak1IUCtyRFRabEZmd0I5U3dsMVd1SXVs?=
 =?utf-8?B?UHpOSklLS3RINUdjL0tVQlhzTU1wVnc1V1F2SEhFUFlLanhnR2lFbGVDVy9s?=
 =?utf-8?B?ajM1ZWlkdnhWbnF6c3FvNmRFVnpjT09WT3g5TFJqalZqVGJVR2RwOXJKZUh5?=
 =?utf-8?Q?v2CTb4kXa1Bwsk98=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C14DDEC23B06584DADD70C47D8984BB5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e520b33-f578-4542-b80f-08da4f616c67
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2022 06:28:27.5036
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t/Xi4J57ai0DYf7LwiHcbcEkvmRE4CyDjwMAZps0fm63Qqt4muuuEFytus0FLsW7YHyDWzlchC3lzHLjtfuKQZA7gwRdIclzBBmlHm9kCXY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1678
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTYvMDYvMjAyMiAwNTo0OSwgTGlhbmcgSGUgd3JvdGU6DQo+IFtQQVRDSCB2Ml0gc29jOiBz
aWZpdmU6IChzaWZpdmVfbDJfY2FjaGUpIEFkZCBtaXNzaW5nIG9mX25vZGVfcHV0KCkNCg0KSSBm
aWd1cmUgeW91IHN1Ym1pdHRlZCBhIHBhdGNoIGFnYWluc3QgaHdtb24gJiBHdWVudGVyIGFza2Vk
IGZvcg0KeW91IHRvIGNoYW5nZSB0aGUgc3ViamVjdCBsaW5lPyBUaGlzIGlzIHRoZSBod21vbiBz
dHlsZSAmIHRoZQ0KYnJhY2tldHMgYXJlbid0IG5lZWRlZCBpbiAobW9zdCkgb3RoZXIgc3Vic3lz
dGVtcy4NCg0KVGhhbmtzLA0KQ29ub3IuDQoNCj4gW1lvdSBkb24ndCBvZnRlbiBnZXQgZW1haWwg
ZnJvbSB3aW5kaGxAMTI2LmNvbS4gTGVhcm4gd2h5IHRoaXMgaXMgaW1wb3J0YW50IGF0IGh0dHBz
Oi8vYWthLm1zL0xlYXJuQWJvdXRTZW5kZXJJZGVudGlmaWNhdGlvbiBdDQo+IA0KPiBFWFRFUk5B
TCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlv
dSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IEluIHNpZml2ZV9sMl9pbml0KCksIG9m
X2ZpbmRfbWF0Y2hpbmdfbm9kZSgpIHdpbGwgcmV0dXJuIGEgbm9kZSBwb2ludGVyDQo+IHdpdGgg
cmVmY291bnQgaW5jcmVtZW50ZWQuIFdlIHNob3VsZCB1c2Ugb2Zfbm9kZV9wdXQoKSBpbiBlYWNo
IGZhaWwgcGF0aA0KPiBvciB3aGVuIGl0IGlzIG5vdCB1c2VkIGFueW1vcmUuDQo+IA0KPiBSZXBv
cnRlZC1ieToga2VybmVsIHRlc3Qgcm9ib3QgPGxrcEBpbnRlbC5jb20+DQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBMaWFuZyBIZSA8d2luZGhsQDEyNi5jb20+DQo+IC0tLQ0KPiAgIGNoYW5nZWxvZzoN
Cj4gDQo+ICAgdjI6ICgxKSBmaXggYnVnLCBpbnRyb2R1Y2VkIGJ5IHYxIHBhdGNoLCByZXBvcmV0
ZWQgYnkga2VybmVsLXRlc3Qtcm9ib3QNCj4gICB2MTogZml4IG1pc3NpbmcgYnVnDQo+IA0KPiAg
IHBzOiBCZWNhdXNlIG9mIG1hbnkgbG9jYWwgY29tbWl0LCB3aGVuIHVzaW5nIC0tYmFzZSBmb3Ig
Zm9ybWF0LXBhdGNoLA0KPiAgICAgICB0aGVyZSBhcmUgdG9vIG1hbnkgcHJlcmVxdWVzdC1wYXRj
aC1pZC4gSSB3b25kZXIgaWYgaXQgd2lsbCBsZWFkIHRvIG90aGVyDQo+ICAgICAgIHByb2JsZW1z
LiBTbyBub3csIEkgc2VuZCB0aGlzIGNvbW1pdCBzdGlsbCB3aXRob3V0IC0tYmFzZS4NCj4gDQo+
ICAgZHJpdmVycy9zb2Mvc2lmaXZlL3NpZml2ZV9sMl9jYWNoZS5jIHwgMjQgKysrKysrKysrKysr
KysrKystLS0tLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKyksIDcgZGVs
ZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zb2Mvc2lmaXZlL3NpZml2ZV9s
Ml9jYWNoZS5jIGIvZHJpdmVycy9zb2Mvc2lmaXZlL3NpZml2ZV9sMl9jYWNoZS5jDQo+IGluZGV4
IDU5NjQwYTFkMGIyOC4uZTBlM2Q4YjY0YzI1IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3NvYy9z
aWZpdmUvc2lmaXZlX2wyX2NhY2hlLmMNCj4gKysrIGIvZHJpdmVycy9zb2Mvc2lmaXZlL3NpZml2
ZV9sMl9jYWNoZS5jDQo+IEBAIC0yMDIsMTcgKzIwMiwyMiBAQCBzdGF0aWMgaW50IF9faW5pdCBz
aWZpdmVfbDJfaW5pdCh2b2lkKQ0KPiAgICAgICAgICBpZiAoIW5wKQ0KPiAgICAgICAgICAgICAg
ICAgIHJldHVybiAtRU5PREVWOw0KPiANCj4gLSAgICAgICBpZiAob2ZfYWRkcmVzc190b19yZXNv
dXJjZShucCwgMCwgJnJlcykpDQo+IC0gICAgICAgICAgICAgICByZXR1cm4gLUVOT0RFVjsNCj4g
KyAgICAgICBpZiAob2ZfYWRkcmVzc190b19yZXNvdXJjZShucCwgMCwgJnJlcykpIHsNCj4gKyAg
ICAgICAgICAgICAgIHJldCA9IC1FTk9ERVY7DQo+ICsgICAgICAgICAgICAgICBnb3RvIG91dF9w
dXQ7DQo+ICsgICAgICAgfQ0KPiANCj4gICAgICAgICAgbDJfYmFzZSA9IGlvcmVtYXAocmVzLnN0
YXJ0LCByZXNvdXJjZV9zaXplKCZyZXMpKTsNCj4gLSAgICAgICBpZiAoIWwyX2Jhc2UpDQo+IC0g
ICAgICAgICAgICAgICByZXR1cm4gLUVOT01FTTsNCj4gKyAgICAgICBpZiAoIWwyX2Jhc2UpIHsN
Cj4gKyAgICAgICAgICAgICAgIHJldCA9IC1FTk9NRU07DQo+ICsgICAgICAgICAgICAgICBnb3Rv
IG91dF9wdXQ7DQo+ICsgICAgICAgfQ0KPiANCj4gICAgICAgICAgaW50cl9udW0gPSBvZl9wcm9w
ZXJ0eV9jb3VudF91MzJfZWxlbXMobnAsICJpbnRlcnJ1cHRzIik7DQo+ICAgICAgICAgIGlmICgh
aW50cl9udW0pIHsNCj4gICAgICAgICAgICAgICAgICBwcl9lcnIoIkwyQ0FDSEU6IG5vIGludGVy
cnVwdHMgcHJvcGVydHlcbiIpOw0KPiAtICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9ERVY7DQo+
ICsgICAgICAgICAgICAgICByZXQgPSAtRU5PREVWOw0KPiArICAgICAgICAgICAgICAgZ290byBv
dXRfcHV0Ow0KPiAgICAgICAgICB9DQo+IA0KPiAgICAgICAgICBmb3IgKGkgPSAwOyBpIDwgaW50
cl9udW07IGkrKykgew0KPiBAQCAtMjIwLDcgKzIyNSw4IEBAIHN0YXRpYyBpbnQgX19pbml0IHNp
Zml2ZV9sMl9pbml0KHZvaWQpDQo+ICAgICAgICAgICAgICAgICAgcmMgPSByZXF1ZXN0X2lycShn
X2lycVtpXSwgbDJfaW50X2hhbmRsZXIsIDAsICJsMl9lY2MiLCBOVUxMKTsNCj4gICAgICAgICAg
ICAgICAgICBpZiAocmMpIHsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgIHByX2VycigiTDJD
QUNIRTogQ291bGQgbm90IHJlcXVlc3QgSVJRICVkXG4iLCBnX2lycVtpXSk7DQo+IC0gICAgICAg
ICAgICAgICAgICAgICAgIHJldHVybiByYzsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0
ID0gcmM7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIGdvdG8gb3V0X3B1dDsNCj4gICAgICAg
ICAgICAgICAgICB9DQo+ICAgICAgICAgIH0NCj4gDQo+IEBAIC0yMzIsNiArMjM4LDEwIEBAIHN0
YXRpYyBpbnQgX19pbml0IHNpZml2ZV9sMl9pbml0KHZvaWQpDQo+ICAgI2lmZGVmIENPTkZJR19E
RUJVR19GUw0KPiAgICAgICAgICBzZXR1cF9zaWZpdmVfZGVidWcoKTsNCj4gICAjZW5kaWYNCj4g
LSAgICAgICByZXR1cm4gMDsNCj4gKyAgICAgICByZXQgPSAwOw0KPiArDQo+ICtvdXRfcHV0Og0K
PiArICAgICAgIG9mX25vZGVfcHV0KG5wKTsNCj4gKyAgICAgICByZXR1cm4gcmV0Ow0KPiAgIH0N
Cj4gICBkZXZpY2VfaW5pdGNhbGwoc2lmaXZlX2wyX2luaXQpOw0KPiAtLQ0KPiAyLjI1LjENCj4g
DQo+IA0KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0K
PiBsaW51eC1yaXNjdiBtYWlsaW5nIGxpc3QNCj4gbGludXgtcmlzY3ZAbGlzdHMuaW5mcmFkZWFk
Lm9yZw0KPiBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4
LXJpc2N2DQoNCg==
