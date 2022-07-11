Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 323EA570853
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 18:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbiGKQ2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 12:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbiGKQ2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 12:28:39 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF12CCC
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 09:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657556915; x=1689092915;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FfAp3+wIQufd8UrpOhKp89h8SM0FY3W3Wx02K941Y88=;
  b=bZjEdR9RjWrjH9sITQPXcxBK288tUoWWjFq92kSSaYX9aDVa27iwBB55
   iEt4SPI6ti2TvpZKQumVUOULmq69fy78Q+vEcIk57H/8OQE+nfZ9YxqRE
   qWR9dvKOlcYBaPsV8zaF/LLhp1BtGkrf6FSZF2dVXh3re2IF7piOjEpXo
   vyTCsHGqAYqUcVp/5U96TskwgLBtgZ1gJOftBrPctmiQwHUgcsqdAGsUL
   hSQolWAlqzqNB8HgZv9rAEnWGHg0SOSjVND07tVZHcxrU8zZWMUJvEEyp
   Eamr7nsxHj6aTWsF0pLDf63JubKo58KcLOC0/8edRozxIbYT4mq2dRxT7
   A==;
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="171902731"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Jul 2022 09:28:33 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 11 Jul 2022 09:28:33 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Mon, 11 Jul 2022 09:28:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WSRxeJKlZBvJbCtOW9ns4QmEU+o0Zc7kdI6eysS509evk6uB0o8Y91n8nR7Gu4Miyu8tSMtWCimQamAk0YwIObyuNAJ+APQxsFvLV9abaEMRfWr3T5/VJ4el2/tE0cXgzI1icQYwAaHuvPSDcYil9zgzAgSZJGalKlYRkRO9p/nxSxqpD3p/9WVT+GSEbkuo1A+089GPUSnR87vMOjr+P4w6LjR1Tv6YrYeRN/9mF4hfyOw8SVorxU7M6XtyfNH5JDp/GcrqiRlVjTQ++RMATtNPXuh/uMYL9wXJoh7/hk3IH9DGWCwXB9z/hOf/c4aL/NIpausM1zCxnVIHOtOzGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FfAp3+wIQufd8UrpOhKp89h8SM0FY3W3Wx02K941Y88=;
 b=lQikRK5Vm2Rsc4YoC+ZIcgY49hi/j2M8qfB9SIqN/Xke8vd2y8ViGWfC9jQEGonuwYE6Xq0Fd/imBCWR85RoS7eXW26rS2EmSeBxrwOxovzB2XU/gk2qTlqJDTriz7Q/l41Mj89TAbZTs9MCwjyF3NyHba3t7ArbwFEqGvF6NhAOrXhnFbTszumuvinzoKaU+iPeeq2E2EHfGvW/0/KvhwvYNx5Avuu/GLTtYNoNpt30YbDnyRrLEhndR6D8Mo8Jeeu2k42Hazi0BZRomOOLrqIZtdmgDoMrDBqHTuebMtcBN7ehAKTnOJ8Q+Rz6GiPZNxzcTz/85nY7CGFq+kEr7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FfAp3+wIQufd8UrpOhKp89h8SM0FY3W3Wx02K941Y88=;
 b=Wi/Z8yIfA/Xe9/dU7HCMBfNXGmn1Rd5VOF3zBTsIXZl7AkXNWKz3ZccCzy9i4A8ihply/+FcEQRevAQhZ+9OdaBOd7TLKb+WkZyMLeX+eZbsQ47Jig6qrXCXU30nw5+1SSQuydchxGSd58sy17rHTGCGU+mrXZM8V3dbkhJV+ek=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DM5PR11MB1835.namprd11.prod.outlook.com (2603:10b6:3:114::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Mon, 11 Jul
 2022 16:28:28 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::8d4a:1681:398d:9714]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::8d4a:1681:398d:9714%5]) with mapi id 15.20.5417.026; Mon, 11 Jul 2022
 16:28:28 +0000
From:   <Conor.Dooley@microchip.com>
To:     <sudeep.holla@arm.com>, <mail@conchuod.ie>
CC:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <palmer@rivosinc.com>, <aou@eecs.berkeley.edu>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <Daire.McNamara@microchip.com>, <niklas.cassel@wdc.com>,
        <damien.lemoal@opensource.wdc.com>, <geert@linux-m68k.org>,
        <zong.li@sifive.com>, <kernel@esmil.dk>, <hahnjo@hahnjo.de>,
        <guoren@kernel.org>, <anup@brainfault.org>,
        <atishp@atishpatra.org>, <heiko@sntech.de>,
        <philipp.tomsich@vrull.eu>, <robh@kernel.org>, <maz@kernel.org>,
        <viresh.kumar@linaro.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <Brice.Goglin@inria.fr>
Subject: Re: [PATCH v3 2/2] riscv: topology: fix default topology reporting
Thread-Topic: [PATCH v3 2/2] riscv: topology: fix default topology reporting
Thread-Index: AQHYk6ghuF5wfEpeb027mcRBe0bMV615RmGAgAAYzYA=
Date:   Mon, 11 Jul 2022 16:28:28 +0000
Message-ID: <6f96ad4b-6901-d5fd-9d55-2da9bdc925c3@microchip.com>
References: <20220709152354.2856586-1-mail@conchuod.ie>
 <20220709152354.2856586-3-mail@conchuod.ie>
 <20220711145941.q5rdrtavstjkp3km@bogus>
In-Reply-To: <20220711145941.q5rdrtavstjkp3km@bogus>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2e603186-6b84-4e5f-e6e5-08da635a62e8
x-ms-traffictypediagnostic: DM5PR11MB1835:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8+E+j9aNpmYnvLQdf+T5EG9JwDUyUJG/VHDicl+5yQbHpdeu2vh+aG3DF0FqfzP4oP7iS9YiY/Z0UGgZPRFr8paPG34MECg//OLcyKLzZGhXbYsQcRqlxR7s9ewS7gvz2KmPZ57T/C2BII3hroxvmaCUbMx6/J1pkeOFMgEmXRX4JSZKsMcMPAQXitvmmEErZ4qa+4ubFXSlzk5BYaA4oezNKtJ1PG1pM1E5x5Mzt77GCaxUjheKt3+1MiJKW3f270yzcRR0nkP6cGf9niXswIjlVHN1IIoLE6uRonZowDoCnuKu4Ax5+bHasmIvx180PGySc1BBeoga332DLm1XY9oUoc8TuUq1Tcgj9QEBHhYvroeNuRvi/QafJFEdMTDC+pQ+lFuW8nJEbP9fWnQ3JDj0qmZdURePYbtNtLy4f2UxNUgeAQhghW6zvGU6fzKkGE58ssqx54rNqKGR3/KcbaxfTTSi0TK1AwE9UgiiSkdgUugCWm4ADBiShvnLE4rD6sCHqrWHUm6Zubx786KfeCQXMeG4UdiejF9UMmw/KHzPipu5kKGEMyrm3f6ZwKpCQm7YuZGaSlpzUDqceXmP6gYA39/P5fglaGtALknh4Op7rAUdJ6dr/mC18SGUIyXr9XyRuajsu8KuK1r7kz5/HwYj7btY0kpjDUX0QWPonMHK5EE/2rH4qs0Mf+PENATkvw7gKnM0FSdpsREEGPlAy+fcWpFfCR4JJ78dAKJQvcYz8C2C60o9FC2JNyXT+8LzsuLa6CuKmRZDC62vLfnt3iXwORKYDVf//bHQrpvolALCZ01faAQkSPVTJMmCWK8oVQY/TJb68v/S5bbWpcQXZ6GZkcRHr/JCLGwCBlXftVD2Eofhgqj2QcmjQTtg3fRzESDc8DuiMM1BumQ7ZuyOPAf84Y9OghB81BDJq/ccun8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(376002)(39860400002)(346002)(366004)(396003)(110136005)(478600001)(91956017)(966005)(6486002)(31696002)(86362001)(38070700005)(122000001)(38100700002)(71200400001)(31686004)(6506007)(36756003)(26005)(54906003)(316002)(66446008)(76116006)(64756008)(66476007)(4326008)(8676002)(66946007)(2616005)(66556008)(186003)(6512007)(41300700001)(2906002)(7416002)(5660300002)(8936002)(83380400001)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q056WDlCYklyMWhYZHFkOGErWDNmVW51c2d1d2VkZHNJZ0p1NTdYdGxxVkh4?=
 =?utf-8?B?NkxuallXbEI0WWtEZFg1bXlGVDNKZTBrQ2lZMXcrK0E4b1Zlazdmd3E3cWl2?=
 =?utf-8?B?LzdXM2dBNFVLQWh0NllwS2Z5NGpiVnp1djVCVWY5Mnc4NWVQZklLK01ZbDZk?=
 =?utf-8?B?OUdBSTJLTE1kRndZUTZHc3J1QXhUVTlFNGNKR1RES1haUHZ2ZTVnZ0tPWVJ5?=
 =?utf-8?B?UjhGbUNZMVVlZ0RTblFXZSs0dXl4Tk1XMjZ4QVpKN1dwNkZUcFNCVkdxa2RM?=
 =?utf-8?B?cVlLZk1HbHd5eGhjc2E4dHd4ck52KzNkeEdQQmR1N2hlVWExZHRPYS8ybERB?=
 =?utf-8?B?WHdSY2tabVJQUXZzSE5kM0RPallRcmJ5WktjdTFrUzlIWEd0WldzWnUvOG9M?=
 =?utf-8?B?WjhtUldJazUxeUZyU1R3UzdMZCtzczdrclMzLzRiN0d6cEtuYXF1aGp2VTJM?=
 =?utf-8?B?SXVrTVRLQ3Z3ZDc2T2xKa09BZ2V4VFRiVElWRzlWdkRSYXJVREthK2FiSzZ6?=
 =?utf-8?B?dEQ2c0RuQ0xPei9PTUVvV1RpSTkwd1dBSlZaeElZVTdnR0laTEk2MnlyQ0F1?=
 =?utf-8?B?R1ZSR1ZMeHNoVEVXU2xhZWZOSjhFcExDRWdaVjZ2eDNRTUZ0d0JKK2dBdGxi?=
 =?utf-8?B?MzdaSlRmVGxqVUtSVjJLOS9oSmE3MEQvcmZBSmNSS3hjaW1kUGRiNFhMOWxs?=
 =?utf-8?B?K2pEVHhOZHhTWE5mZjA3T0NDZSsySGp5RFRzbTRsbnNUbC81WmYrS1VtUlh6?=
 =?utf-8?B?T1Mxd0tkS3FyRFBrVTZ2ODdQekVRa0NYbVBXcTFnZGs5b3JHOEw5OHAzcnlz?=
 =?utf-8?B?cUE4WnhyNE5admZvTFFOYnN6QWI3bTY5K1R4WjYwUnBWSStBU2ZjNUhlSEp2?=
 =?utf-8?B?YVBHWG1YSUhTaXBqd3Z1b1NXU0xzUEFkMytyV2FNOFovOXhJUjl4NG1Ed3oz?=
 =?utf-8?B?VE5SZytJbzNQWmxoWTQ4OHRBdlNTUDd0cFdHaXdXV3NjTXB5UHMxSVBHZVVr?=
 =?utf-8?B?aWplTWZpVW9iaGlNancwbDZzNklCcVZ1YlQwYU5aUVQyZUFxSHNxeUQxdGJB?=
 =?utf-8?B?d0lYSy9IdWdqcEZENThIMk1IYTlOOVRLMlMrWm9FaUhwejZ6ZGZGOFN3Nnhv?=
 =?utf-8?B?YTlFdUJwa2ZubDQ5d2d4YTlQSzJSd2MzbzRZNDBla0ZUbEs1Nk1MQUpqOVpX?=
 =?utf-8?B?ZFh1MnZxN3dPOEZOZzdicG9PNVB1eFpWTU5RMVd1ZFlLKzI4eTEvaHJHZmo1?=
 =?utf-8?B?RWFXVmZNS1I4dkwzSVpuT1dpZ2Z2Uk03N2UxQ1pianl1QjRxcW0yZWQ3ZmxL?=
 =?utf-8?B?OXkxTkNVWi8yNGhiSnBxVmo1TTNMbUNnOURyb0FxdEVkNjhYZHdCTWpOTGFF?=
 =?utf-8?B?dE10MHpqMlZUSE5IZForZ0FjR1RGUFFaczFtSXFyZ1hiV1R0RGhJaklsbGYy?=
 =?utf-8?B?enF2bTUyWndXc2VEbFZyT0U5TG5TUVFsWHpJYVlmektPR0JyMFVYcEgzQVJs?=
 =?utf-8?B?a2tQVzU0RmtKYXJIM2dBdlZjMk02Yk5vdkh1YWVxaUU3QWVpWWFTYm16WVAr?=
 =?utf-8?B?cHNtRWJMbVJYTXd6ck1Td2kwZHpJd0ZoL2UxaGdhNndaYmNnd1hqbEdIZnUw?=
 =?utf-8?B?Sm9JVENLU3d3YWxCZ011YWRFSjJsaG8yQjlTeFZxeHhKMjNzeDNCRDZrWGxo?=
 =?utf-8?B?T2tkMXdRdVE4THB3ckkvaC8yUWtSamZBNVE1QnFZZ3I3MzJQZU5ZTFNiTVJN?=
 =?utf-8?B?V0YzZkNLVlRNZ05RcHJXY3psK3F1TVU1cGdZWGFrZFVrRjNoN0J6UW5Db1lj?=
 =?utf-8?B?Sm5VU1RqRHJGd013bmR2VzRFZ21UQkxQWUQ0OWE5WmM2cStsZDNJSVlXNXZM?=
 =?utf-8?B?aG1ET21kMk1WcnljTkhTZklybkRTNUdUblFRYXc3Z3RCdE8vN0crdmN0dFFr?=
 =?utf-8?B?Q2RqSGoxR2V2QnQzaXlWaHM4STJEN1lBbjlRVlF6K0thdVlRWXVaZWN4N0tP?=
 =?utf-8?B?RVRXQVZMNXFTMjdiZmZIdXVBaWkySldsR0RjOHB3cERLWVZUTURBWVpnbzVq?=
 =?utf-8?B?Sm5Md0N4QnpPTDk2TFRjOEUyUldhSDdLbGJsdFJnKzhsT1JIN1ZmNGlLRDEz?=
 =?utf-8?B?YkFiellyUjdzOFhIY2ZUMTFCam0wZFRocjUxRTJOVHlycUhwbEp5TUZEVEYx?=
 =?utf-8?B?NGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9BAB6995A3057040B6691EA7C2894CBA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e603186-6b84-4e5f-e6e5-08da635a62e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2022 16:28:28.3514
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tqkOT1h0UbMJpWTrHCAYgoz9JSOXAhyQzU1tWrC2tK1S0H/lYp0hp5YmfXEch6jgv1sIKOUiOmSnV2tuhwOZQoZOcqjR2ptZ3GtEBcWYiJM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1835
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvMDcvMjAyMiAxNTo1OSwgU3VkZWVwIEhvbGxhIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIFNhdCwgSnVsIDA5LCAyMDIyIGF0IDA0OjIz
OjU1UE0gKzAxMDAsIENvbm9yIERvb2xleSB3cm90ZToNCj4+IEZyb206IENvbm9yIERvb2xleSA8
Y29ub3IuZG9vbGV5QG1pY3JvY2hpcC5jb20+DQo+Pg0KPj4gUklTQy1WIGhhcyBubyBzYW5lIGRl
ZmF1bHRzIHRvIGZhbGwgYmFjayBvbiB3aGVyZSB0aGVyZSBpcyBubyBjcHUtbWFwDQo+PiBpbiB0
aGUgZGV2aWNldHJlZS4NCj4+IFdpdGhvdXQgc2FuZSBkZWZhdWx0cywgdGhlIHBhY2thZ2UsIGNv
cmUgYW5kIHRocmVhZCBJRHMgYXJlIGFsbCBzZXQgdG8NCj4+IC0xLiBUaGlzIGNhdXNlcyB1c2Vy
LXZpc2libGUgaW5hY2N1cmFjaWVzIGZvciB0b29scyBsaWtlIGh3bG9jL2xzdG9wbw0KPj4gd2hp
Y2ggcmVseSBvbiB0aGUgc3lzZnMgY3B1IHRvcG9sb2d5IGZpbGVzIHRvIGRldGVjdCBhIHN5c3Rl
bSdzDQo+PiB0b3BvbG9neS4NCj4+DQo+PiBPbiBhIFBvbGFyRmlyZSBTb0MsIHdoaWNoIHNob3Vs
ZCBoYXZlIDQgaGFydHMgd2l0aCBhIHRocmVhZCBlYWNoLA0KPj4gbHN0b3BvIGN1cnJlbnRseSBy
ZXBvcnRzOg0KPj4NCj4+IE1hY2hpbmUgKDc5M01CIHRvdGFsKQ0KPj4gICBQYWNrYWdlIEwjMA0K
Pj4gICAgIE5VTUFOb2RlIEwjMCAoUCMwIDc5M01CKQ0KPj4gICAgIENvcmUgTCMwDQo+PiAgICAg
ICBMMWQgTCMwICgzMktCKSArIEwxaSBMIzAgKDMyS0IpICsgUFUgTCMwIChQIzApDQo+PiAgICAg
ICBMMWQgTCMxICgzMktCKSArIEwxaSBMIzEgKDMyS0IpICsgUFUgTCMxIChQIzEpDQo+PiAgICAg
ICBMMWQgTCMyICgzMktCKSArIEwxaSBMIzIgKDMyS0IpICsgUFUgTCMyIChQIzIpDQo+PiAgICAg
ICBMMWQgTCMzICgzMktCKSArIEwxaSBMIzMgKDMyS0IpICsgUFUgTCMzIChQIzMpDQo+Pg0KPj4g
QWRkaW5nIGNhbGxzIHRvIHN0b3JlX2NwdV90b3BvbG9neSgpIGluIHtib290LHNtcH0gaGFydCBi
cmluZ3VwIGNvZGUNCj4+IHJlc3VsdHMgaW4gdGhlIGNvcnJlY3QgdG9wb2xneSBiZWluZyByZXBv
cnRlZDoNCj4+DQo+PiBNYWNoaW5lICg3OTNNQiB0b3RhbCkNCj4+ICAgUGFja2FnZSBMIzANCj4+
ICAgICBOVU1BTm9kZSBMIzAgKFAjMCA3OTNNQikNCj4+ICAgICBMMWQgTCMwICgzMktCKSArIEwx
aSBMIzAgKDMyS0IpICsgQ29yZSBMIzAgKyBQVSBMIzAgKFAjMCkNCj4+ICAgICBMMWQgTCMxICgz
MktCKSArIEwxaSBMIzEgKDMyS0IpICsgQ29yZSBMIzEgKyBQVSBMIzEgKFAjMSkNCj4+ICAgICBM
MWQgTCMyICgzMktCKSArIEwxaSBMIzIgKDMyS0IpICsgQ29yZSBMIzIgKyBQVSBMIzIgKFAjMikN
Cj4+ICAgICBMMWQgTCMzICgzMktCKSArIEwxaSBMIzMgKDMyS0IpICsgQ29yZSBMIzMgKyBQVSBM
IzMgKFAjMykNCj4+DQo+PiBDQzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPj4gRml4ZXM6IDAz
ZjExZjAzZGJmZSAoIlJJU0MtVjogUGFyc2UgY3B1IHRvcG9sb2d5IGR1cmluZyBib290LiIpDQo+
PiBSZXBvcnRlZC1ieTogQnJpY2UgR29nbGluIDxCcmljZS5Hb2dsaW5AaW5yaWEuZnI+DQo+PiBM
aW5rOiBodHRwczovL2dpdGh1Yi5jb20vb3Blbi1tcGkvaHdsb2MvaXNzdWVzLzUzNg0KPj4gU2ln
bmVkLW9mZi1ieTogQ29ub3IgRG9vbGV5IDxjb25vci5kb29sZXlAbWljcm9jaGlwLmNvbT4NCj4+
IC0tLQ0KPj4gLS0tDQo+PiAgYXJjaC9yaXNjdi9LY29uZmlnICAgICAgICAgIHwgMiArLQ0KPj4g
IGFyY2gvcmlzY3Yva2VybmVsL3NtcGJvb3QuYyB8IDQgKysrLQ0KPj4gIDIgZmlsZXMgY2hhbmdl
ZCwgNCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9h
cmNoL3Jpc2N2L0tjb25maWcgYi9hcmNoL3Jpc2N2L0tjb25maWcNCj4+IGluZGV4IDJhZjA3MDFi
NzUxOC4uNGI2YzJmZGJiNTdjIDEwMDY0NA0KPj4gLS0tIGEvYXJjaC9yaXNjdi9LY29uZmlnDQo+
PiArKysgYi9hcmNoL3Jpc2N2L0tjb25maWcNCj4+IEBAIC01Miw3ICs1Miw3IEBAIGNvbmZpZyBS
SVNDVg0KPj4gICAgICAgc2VsZWN0IENPTU1PTl9DTEsNCj4+ICAgICAgIHNlbGVjdCBDUFVfUE0g
aWYgQ1BVX0lETEUNCj4+ICAgICAgIHNlbGVjdCBFREFDX1NVUFBPUlQNCj4+IC0gICAgIHNlbGVj
dCBHRU5FUklDX0FSQ0hfVE9QT0xPR1kgaWYgU01QDQo+PiArICAgICBzZWxlY3QgR0VORVJJQ19B
UkNIX1RPUE9MT0dZDQo+IA0KPiBJIGFtIG5vdCBzdXJlIG9mICFTTVAgYXMgQVJNNjQgaXMgZGVm
YXVsdCBTTVAgb25seS4gSSBoYXZlIG5ldmVyIHJldmlld2VkDQo+IHRoZSBhcmNoIHRvcG9sb2d5
IGNvZGUgd2l0aCAhU01QIGNvbnNpZGVyZWQuIEkgd2lsbCBsZWF2ZSB0aGF0IHBhcnQgdG8NCj4g
UklTQy1WIGRldmVsb3BlcnMuDQo+IA0KDQpJIGNoZWNrZWQgaXQgb24gYSBEMSB3aGljaCBpcyAh
U01QIC0gbm8gdHJvdWJsZSBib290aW5nIGFuZA0KdGhlIHRvcG9sb2d5IHJlcG9ydGluZyBzZWVt
ZWQgZmluZS4NCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3cywNCkNvbm9yLg0K
