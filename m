Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5054B59C112
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 15:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235331AbiHVN4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 09:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbiHVN4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 09:56:38 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77EB639B94;
        Mon, 22 Aug 2022 06:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661176597; x=1692712597;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=52BUwe633d0WftZV/6OJ+b3pJBBe1eRWqOxRZDM/1i0=;
  b=dOqia2LksGk04hJkgo4fEVKB0S9Kk4B/6rjz4Dwbh15nyI9SRz6/vgcK
   hDQ2L8A5RIlkxFLnevKJ0R0TaCl/ClDAZRNCJldzS2xq37Qts9N2oJ+i4
   Y2RzVtDA60GdMsKIx5BGpL9czPZD/lfXuP6T5PM69edopzwaTrxWZ4Tel
   ms7dFlU+TW9KN2pUxkDnmezXwx5BAJd04s8Gxqt0HY8eeL5Ext1qc8JSN
   m4548+9yXVJeyqQHVQWmtp+XUpsdIovUN3H5JusXxDxCPQj8r+S9r+E3o
   XKcfE9xK95hoMFiIwy5d52kJWajiMly/hh3+LZriZaIkEAczZVhtVwPTf
   w==;
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="110122306"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Aug 2022 06:56:36 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 22 Aug 2022 06:56:34 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Mon, 22 Aug 2022 06:56:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k1In2a7O+O571z/8NHYDsmhC8hafVnufSe8BqoFpf4oycjHpzE0gad9E84KRV+92imboTAN/sxL8uNy+75I8wRns9o2tDUFbGcaGC23uPr1AIuzwsz1TA6mZeW/2KRBk03UH0aPiJA/lYqFxqHeLh+jKhsPomVGYyeI+LD0ZspiHmsR62rYSDdeo5ccG7AFYAkW5s3UMbcTirUUjSB9n5IHUbVL0e76TcbC3nFDvQM6XzpwNnXp2zfI/oTdv2n/zWTPU2bP+JKDtcBUCqt/lhs+DN7PfVQ5ofWfSfammWoI0mn7an9Jy6llV5JC61a/za7pKE3yBZ9mSKxkncbXR4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=52BUwe633d0WftZV/6OJ+b3pJBBe1eRWqOxRZDM/1i0=;
 b=N5H6jHV6JrO5M4HxkJ65Aapl7eSyRr/B+F8Q+HMxiAE7Cazj/NemZLTtJzhB3+ozxdbLR59XLnZ2tG3ocfGGdPlQPmZmyXAKy2/e9FYosUsc2ZtYIFFwTj+NkMSnEFhhAMSrXdQaKHXeq5arp85GthPj81ZjGRMdmxT5SVFlt9E9zYIIheXJNDw9HT+8OlzEVE04NMWtKA8FKjqZsp7RwnIBRRPCizFtbrl4YlFmzSUWAEKY5CBk1pQpRRycyMirZlK4YXoKKpNv9G4rj4X10LOWbGUTNw+6cfUtbOEZGF8kgIl1W4iK8CdBOEilMJnAOScwsJzu7FlAa91LzOnpug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=52BUwe633d0WftZV/6OJ+b3pJBBe1eRWqOxRZDM/1i0=;
 b=gTJ0zBDz6vTtbEaUhwjRKEeJbB8MMGL7owbfqsMW4g8rFGAvwzaceJcJV/lg894s6U5EmeUzNvwdVYVQBx7yFtXlIx/3OGWfeZJJaViyYY74TiXlxXniQ3P1T1FmRBx7kLF25w6mPwJKmEbDPnYFFhMQH6X1kwFswa183Th86f8=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by BN6PR1101MB2161.namprd11.prod.outlook.com (2603:10b6:405:52::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Mon, 22 Aug
 2022 13:56:28 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%9]) with mapi id 15.20.5546.022; Mon, 22 Aug 2022
 13:56:27 +0000
From:   <Conor.Dooley@microchip.com>
To:     <geert@linux-m68k.org>
CC:     <andre.przywara@arm.com>, <devicetree@vger.kernel.org>,
        <aou@eecs.berkeley.edu>, <samuel@sholland.org>,
        <linux-kernel@vger.kernel.org>, <jernej.skrabec@gmail.com>,
        <prabhakar.mahadev-lad.rj@bp.renesas.com>, <wens@csie.org>,
        <robh+dt@kernel.org>, <palmer@dabbelt.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <paul.walmsley@sifive.com>,
        <linux-riscv@lists.infradead.org>, <linux-sunxi@lists.linux.dev>
Subject: Re: [PATCH 06/12] riscv: dts: allwinner: Add the D1 SoC base
 devicetree
Thread-Topic: [PATCH 06/12] riscv: dts: allwinner: Add the D1 SoC base
 devicetree
Thread-Index: AQHYsGUwgMumzpPtekanQb2zMhKHQ62v8GmAgABAKYCAB+IqgIAAATuAgADecICAADeqgIABrtyAgAAHcYCAAAUagIAAF5yA
Date:   Mon, 22 Aug 2022 13:56:27 +0000
Message-ID: <44b6f601-1a11-aacf-5592-5b61550afb9f@microchip.com>
References: <20220815050815.22340-1-samuel@sholland.org>
 <20220815050815.22340-7-samuel@sholland.org>
 <20220815141159.10edeba5@donnerap.cambridge.arm.com>
 <3cd9ed5b-8348-38ac-feb1-9a7da858cebc@microchip.com>
 <932aaefd-e2ca-ef26-bf30-e315fb271ec5@sholland.org>
 <ff9e8bd3-c5f7-6319-060e-250151087a8e@microchip.com>
 <c6cba83ea9eea7fc41a9e78d0e45487b21f0f560.camel@icenowy.me>
 <c7599abd-c4cf-9ddd-1e74-e47dec9366d4@microchip.com>
 <CAMuHMdUHVpj9ikE2NxpBSBtTG8K6v92vGdbw3GLmEYUoVzatvg@mail.gmail.com>
 <538ae41e-664f-2efb-f941-9a063b727b6a@microchip.com>
 <CAMuHMdWWbR+Y=bJ7gdqV3d+ffHE1-hwQf-Owb8FAvZAaScdOgA@mail.gmail.com>
In-Reply-To: <CAMuHMdWWbR+Y=bJ7gdqV3d+ffHE1-hwQf-Owb8FAvZAaScdOgA@mail.gmail.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 894100f2-f31d-43ff-d5b4-08da84461be8
x-ms-traffictypediagnostic: BN6PR1101MB2161:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m4M2hhhM1Muaot5Ji/UyZZzyHVhurMBz8yIg4WOvhbA4K1XWPly3bxdpGsFigffHOzwDthEDvZtLuo+FfBZKWnmp2gm4cNzO/vm25bgmU9Vc+TmT3NTpdV88exysPxO2B6wS0xLMK5bi8XnX/nJogKAUlqZcQBpiVDwVjrnyaWXpk4je9RaN5kxw+Z2ZgA88v/1LFAQEYG372svkMk+STFMiIT1XUQBzFbG35Rev5Ak7sHj+9ZdO+hPcttVoMGYAqzcG+UkoL7pxBSJWEbexsSoWhkL0NKR+3uvw5mgcfQ28Y7LwvlaeHZNybiGgmPWXc9rsCF2em/HvRm6MjwNpyTnxIMr+GnyXq3+0EBvsEOLh4j9x/7RRdNOdO19qF0qIES3DXP3bJ7jDOgc9IK+26+ufj+BMcJNxl+QBpTOjabs8NgDFX5L5Y35VPEC/p7oOPq8bPDMao2EMAOfEKVmBD2mvEyD3nscPtC8wwhz2m83ekZgCIH20O7voRZZQfuVqOzkRavomKbkPEWwLGfKaZhoPuiLL3YwBPNs7X/2l5ZTa/0pl7OBGW8GNvaosgAcxH6LOfuWGg5XZoQ+6D1QyDnGdoRPszD+97RY9NmXW2fqDkXnB9AuHbQwYfufeNNe+plWusdqqiFzxPCvJWqrpzk9RC4kZCid6TgmSyAtqK0Gawq3oHw3VEoJHeudXs3oCqhvVaJEHcIg1m6Sbtz+17rtiQcO7pH7AzJeSke6sPQZqwKb/1GjYhk1nAHsB2y0ww+kYkfrMsjewXNsBfHdNAHZbc9WlLvfccLyESPSwh1b+UzLvL3zbXtu8brYlwtVBI7eDyXnOpQ5dRUF5jDGzbg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(366004)(376002)(346002)(39860400002)(53546011)(26005)(31696002)(86362001)(7416002)(2906002)(6506007)(6512007)(8936002)(5660300002)(31686004)(6486002)(38070700005)(478600001)(71200400001)(41300700001)(38100700002)(36756003)(122000001)(83380400001)(186003)(2616005)(66446008)(66476007)(66556008)(66946007)(64756008)(54906003)(316002)(6916009)(8676002)(4326008)(76116006)(91956017)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OUVmNndTOVpNdGpMdlpCQzExRXVFSFA1bVlsTnZoZmJPY0FSZ01HbWkxSGE5?=
 =?utf-8?B?U0tOd2NpcmFCOXNvNW5QK3o0QVFqRnMrQmZ2eE9QRG5mSG5INzhXWmdaazEy?=
 =?utf-8?B?N1I1dVFXcm5mN3NrMjVaTXJkbUZZZkpEdjdZYitkNm51RmZrd3JkMXZDM3NU?=
 =?utf-8?B?aTNEWG5KZXRqTGwrZktQcFJhSUM5SUk1ejgzVlZHZktHOFc3c0dnMS9pV0xS?=
 =?utf-8?B?MDdMQ2VKOHdOVW9jMkM3N1dKcm8wTVFXWTVVaDNwanJaazFydldxaXgxNW1M?=
 =?utf-8?B?a014TmxMK0tOWkVDby9FSFZadE1ZTWNkV3BITjhnR2w4bnNybmJLMnd1TzRZ?=
 =?utf-8?B?M0NObHFha3d1TWVDTWJvTnZlQlZqS3NXRTRWRzYxTis1Y2hEYXJLU0lxSjRi?=
 =?utf-8?B?N04vR1JzTys2NUlTZ0VIcVNoM3h1RERlSEN0bU5GTHpDcEN3VU5NT3JxU3hV?=
 =?utf-8?B?aWxOVjExNHdnbU9uNk42VG1pSGxJcFRUM2ZhT1NBRFZuZmV0MlQzQ3JZMWth?=
 =?utf-8?B?SDR3WEE0NEhncGZ1cW5QUXdUSWlRNllscDZMdGtNNmF6TnIrMmFPWHArUm5K?=
 =?utf-8?B?MmoyanlaNTBVVXo3TE04L2RTVTNobkJnalF2S1JLWkdKZ2tyM0xzRXFnUm1L?=
 =?utf-8?B?bk1WTWtEOTVSOWxiT3ByUDl6Z3dqRnVUVkMrLytHa1Y4WW1OWlRWcXlnckZZ?=
 =?utf-8?B?cVhjbjBwWTJ5eXlhNUJpWGxUQzljajEvNXRqYnY2MnVzMDJrUmMvcUNYemN3?=
 =?utf-8?B?ampGOUkxc2xKRitxbHlrckJuc2R0MWdoV2dCRTRuSkN3OFg3bVZCU1dwdXRa?=
 =?utf-8?B?am1GK0FjTHZWL1ZkaXRPc0FrU1cvcHhLVmFJZUJUV3A3RWJFY1RLZEZGVnB4?=
 =?utf-8?B?WXZ2NS9HTEN2V3JjV2dOR0xmeGRSNndWYzlQeXJnb3NFcHN4WWFlZWVTSDdS?=
 =?utf-8?B?WFp4KzJ6bksyb3VtZld4dkxoWlEyZG42R01BSHMrbWZZZ2VYY2dWWmZHVWlH?=
 =?utf-8?B?NUx1ekRQeFY3WHdhWWVkNU5iZHpCVXluT0hVa2UxWVJtelBtNDFmMWdxelpK?=
 =?utf-8?B?Tk8wWEcxOHREZE5NVFl2VzNFcVhXQktZRmZmOGF1akd0amlYcU92blpuK0lv?=
 =?utf-8?B?NEIvWXE4N01JUzNleVJIa2J5LzYxaDRhSktraS9GdGF5a0V5QmczR1Z2SW9q?=
 =?utf-8?B?WGdTVUwyUENTcis1TUlUL2xZY1JrRlpRVU4xMDZGdnFhNWZGUDdOVmp6K25Y?=
 =?utf-8?B?LzNGVGxYWUxTNkJrZFJNRHpBbTRTSWhqcDJHejMwWXpQK3FFUlFlUUdIVDRX?=
 =?utf-8?B?czFPTFdyN2VDY3E1SnVFZW9YeEswMDNMMnNyMlBJdXZDdUxsSFNaZVRmVFhY?=
 =?utf-8?B?UGtZNTJyRnZnall0em5EeWdzRDdXQ2J1NWNqTGxhNXVVcUs1cGNMTUtLMFho?=
 =?utf-8?B?Q1pTMUd1YXBwaTFzYU9HTitOWVAyMzVEM2k2UEY4ZXhISTVlNU1DUGtBZlJv?=
 =?utf-8?B?dW91VGk5YlB6ZC8rMXRpUlM0V3B5NVh5SC9KZzRSUGV0UDJjaUk4dVFrVFBM?=
 =?utf-8?B?NGRhV0cwd3hWNFd6bVZtbTFNd1dITXMzTmo1NmFzVGFob0J4VjNtR3FQTUJs?=
 =?utf-8?B?cm1ZK3lWRlB6MnRZSjdSNGpvYWMvQmVzbUJQQ1Vxd05kRXEwb2ozb0FkcGVy?=
 =?utf-8?B?ZEIzOXlrNi9lYWpES2FiYnNwYklIc2NqS042NTR2N3FOWTJWY0x2dnNTVjNJ?=
 =?utf-8?B?Wjc0cnYvdkh4UWg1TTFVN21KbS9jUHNRVUhBcEFKdHMyR0hJSjBwSDB6bkVO?=
 =?utf-8?B?ZlNCUlJ6S3ByeUNlSnRkSXNkWmJFTDdTSHVIUFRkallSeUgwTCtoRHdUdW9U?=
 =?utf-8?B?YVlaeXZVNW91SlRUZ3RGL0M0WXAvUDF0aGFiUFRxckpIV2QvVmVlMks4OXB4?=
 =?utf-8?B?czBWc29UbUsvUFNONFRaRXEwa2NiTkRITVAvNmxvcFhTTllNMENyNlRKUjN2?=
 =?utf-8?B?UkNhUlNpcXZlRTc4ZHJ6SzlVZWRDbkxPdWlGRUVwVnkrQk5XemRJQVlCSkpV?=
 =?utf-8?B?ZWRsTjhUdUR3VjIwZEtnNEdoaHlEdlZUKytkdFlQVEhUbGR1OG9zaytxaldo?=
 =?utf-8?Q?NjWEI5uTL62KisYfbL8yGGtH1?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ACC5C76D63ABE94695C1633F92F678C4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 894100f2-f31d-43ff-d5b4-08da84461be8
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 13:56:27.6542
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3bnNEJpITJx7AzuHoU10i0Ga3Ouh/9Cn/28BvwZoehLl9xxA9K5lh0QP6V9SM5ynTXKsjAXAGyjm2rOywEkYK3P8O8pHho2X/cMsJiIKGgM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2161
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjIvMDgvMjAyMiAxMzozMSwgR2VlcnQgVXl0dGVyaG9ldmVuIHdyb3RlOg0KPiBFWFRFUk5B
TCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlv
dSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQoNCg0KPj4gRG8geW91IHRoaW5rIHRoaXMg
aXMgd29ydGggZG9pbmc/IE9yIGFyZSB5b3UganVzdCBwcm92aWRpbmcgYW4NCj4+IGV4YW1wbGUg
b2Ygd2hhdCBjb3VsZCBiZSBkb25lPw0KPiANCj4gSnVzdCBzb21lIGJyYWluc3Rvcm1pbmcuLi4N
Cj4gDQo+PiBXaGVyZSB3b3VsZCB5b3UgZW52aXNhZ2UgcHV0dGluZyB0aGVzZSBtYWNyb3M/IEkg
Zm9yZ2V0IHRoZSBvcmRlcg0KPj4gb2YgdGhlIENQUCBvcGVyYXRpb25zIHRoYXQgYXJlIGRvbmUs
IGNhbiB0aGV5IGJlIHB1dCBpbiB0aGUgZHRzPw0KPiANCj4gVGhlIFNPQ19QRVJJUEhFUkFMX0lS
USgpIG1hY3JvIHNob3VsZCBiZSBkZWZpbmVkIGluIHRoZQ0KPiBBUk0tYmFzZWQgU29DLmR0c2kg
ZmlsZSBhbmQgdGhlIFJJU0MtVi1iYXNlZCBTb0MuZHRzaSBmaWxlLg0KDQpSaWdodCwgb25lIGxl
dmVsIHVwIGJ1dCB+dGhlIHNhbWUgcmVzdWx0Lg0KDQoNCj4+PiBOaWNlISBCdXQgaXQncyBnb25u
YSBiZSBhIHZlcnkgbGFyZ2UgaW50ZXJydXB0LW1hcC4NCj4+DQo+PiBJIHF1aXRlIGxpa2UgdGhl
IGlkZWEgb2Ygbm90IGR1cGxpY2F0aW5nIGZpbGVzIGFjcm9zcyB0aGUgYXJjaHMNCj4+IGlmIGl0
IGNhbiBiZSBoZWxwZWQsIGJ1dCBub3QgYXQgdGhlIGV4cGVuc2Ugb2YgbWFraW5nIHRoZW0gaGFy
ZCB0bw0KPj4gdW5kZXJzdGFuZCAmIEkgZmVlbCBsaWtlIHVuZm9ydHVuYXRlbHkgdGhlIGxhcmdl
IGludGVycnVwdCBtYXAgaXMNCj4+IGluIHRoYXQgdGVycml0b3J5Lg0KPiANCj4gSSBmZWVsIHRo
ZSBzYW1lLg0KPiBFdmVuIGxpc3RpbmcgYm90aCBpbnRlcnJ1cHQgbnVtYmVycyBpbiBTT0NfUEVS
SVBIRVJBTF9JUlEobmEsIG5yKQ0KPiBpcyBhIHJpc2sgZm9yIG1ha2luZyBtaXN0YWtlcy4NCj4g
DQo+IFNvIHBlcnNvbmFsbHksIEknbSBpbiBmYXZvciBvZiB0ZWFjaGluZyBkdGMgYXJpdGhtZXRp
Yywgc28gd2UgY2FuDQo+IGhhbmRsZSB0aGUgb2Zmc2V0IGluIFNPQ19QRVJJUEhFUkFMX0lSUSgp
Lg0KDQpZdXAsIGluIHRoZSBzYW1lIGJvYXQgaGVyZS4gbWF5YiBJJ2xsIGdldCBib3JlZCBlbm91
Z2ggdG8gYml0ZS4uDQoNCg==
