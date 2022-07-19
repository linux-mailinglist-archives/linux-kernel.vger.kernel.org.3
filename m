Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142765798C4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 13:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbiGSLvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 07:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiGSLvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 07:51:10 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A65D1704A
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 04:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658231468; x=1689767468;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=YoE46OflTzmSOHE1RmIe9Ck3lnRcjtoGPmpd2d/lp1c=;
  b=kjkb7EPq3yqMVFJMqEnJYhd9gcgUz1Hj27VYBEm6LjbK52YcTvHz1RND
   FYSWJpcS7MDpFUXoXxd9oPEkmP1egWoV05Zmoi6ww2pc/2y5g2qCboi3c
   OMWS8d0VUqDJVv3H3Blhe8Ftsj9D1RGqWzKj7x3C1pqd+NFNiUy8YiZHm
   PFF+Ye89VQSCHjvYsXpkBZ5elrGsTH4m2uIz+1hv7pFsHe+TK8OUuif0F
   7dfaDO/AGcXZH118Qe4nHsqEFKCfXB3rqIN+z6cb7lC4yc/BczF0mTF3t
   8s1809lMWo+jBs/tc6hKJH9WNN7QZSmgYBLf+E9WTGLmXWJc2kvt8nF8u
   A==;
X-IronPort-AV: E=Sophos;i="5.92,284,1650956400"; 
   d="scan'208";a="182801206"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Jul 2022 04:51:06 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 19 Jul 2022 04:51:06 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Tue, 19 Jul 2022 04:51:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KmkpUGqU7912uEcg8BbBiHw9oiWzhj/7tLKwe6oPn2eQ9aWiB2j+Q3tgo/p4U9bIaAZJjiEyfvtwgOyyOHuIfNCtww3P+i8eIbmwOdA9xpQjTqqNzQf5h8TXCzSjNSKDqunzgx6rs5VuIMq2Coats6BsOvNjP9+XOYN6Z8M0H+IePWsaYO1Y8q2dSn4AJKBcvNaOlSwwn/qFKru9l7R6cWQ1t9j5ktSsWaFblkQJKsaFbRfFOAk9rAKxC2kw4t+IgTbfnZJIBBkRWNRYfXwhdP3UT857qphJsry+rZHZffFIgS5Q+55ZwIutRkH5AYR3AtA7qYsx9nn5DglC8TXnPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YoE46OflTzmSOHE1RmIe9Ck3lnRcjtoGPmpd2d/lp1c=;
 b=DkuFWuqyDHu3XvowF9kb16Fw9a7iUhWrzt32laST5SG2ukPkd1ZhY6su5A4155ZfNRF9Uib6KHMIY1ovJY0sU4RG21gjSPPGPPXUkXBqsy+k05i19ox7mKkZVOKQFhWufs8eNvvBPC/blbQEHsDXKbZXc8MwNDBl+Nss3wDXkU5A35WVxr5yc94qr7ntOLtCyBUxbZbIx+0xsPtJpiIv4PjoFNbNHVUG+/ZwvtaL79kt4frJnurUXAmVoUn+dKfXPFt9YtL89D36VeY9I2bi7CWf7gX1ePQkzWSSGfdyDSIRrkujhlR2k+CM8vtbRpvvgapzgePohBCqplcYS9OBog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YoE46OflTzmSOHE1RmIe9Ck3lnRcjtoGPmpd2d/lp1c=;
 b=FRtRKSaLFHlXJ/HxI5axX8RqoCA855ijmVG2ZbYN8zvX3Mj/3qrMRIPyr2HGdcinODyYhvDIjk7yF01q0fLwg3Zj5eIhNARNwi6GMX6uoLuuKSWeXovctrBQ+CUsIEo/HicRTGFhC8FEDF71y5J+CKUi5YkNvUDZJMQ5K3+SBAE=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by MWHPR11MB1824.namprd11.prod.outlook.com (2603:10b6:300:110::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Tue, 19 Jul
 2022 11:51:04 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::357a:acc9:829e:bf7b]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::357a:acc9:829e:bf7b%7]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 11:51:04 +0000
From:   <Conor.Dooley@microchip.com>
To:     <catalin.marinas@arm.com>
CC:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <palmer@rivosinc.com>, <aou@eecs.berkeley.edu>,
        <sudeep.holla@arm.com>, <will@kernel.org>,
        <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <Daire.McNamara@microchip.com>, <Conor.Dooley@microchip.com>,
        <niklas.cassel@wdc.com>, <damien.lemoal@opensource.wdc.com>,
        <geert@linux-m68k.org>, <zong.li@sifive.com>, <kernel@esmil.dk>,
        <hahnjo@hahnjo.de>, <guoren@kernel.org>, <anup@brainfault.org>,
        <atishp@atishpatra.org>, <heiko@sntech.de>,
        <philipp.tomsich@vrull.eu>, <robh@kernel.org>, <maz@kernel.org>,
        <viresh.kumar@linaro.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <Brice.Goglin@inria.fr>
Subject: Re: [PATCH v4 1/2] arm64: topology: move store_cpu_topology() to
 shared code
Thread-Topic: [PATCH v4 1/2] arm64: topology: move store_cpu_topology() to
 shared code
Thread-Index: AQHYmHP8H8qT+Q5YTkyKfQcjXDX5xK2Fl/AAgAAC4wA=
Date:   Tue, 19 Jul 2022 11:51:04 +0000
Message-ID: <198b0486-29e7-9729-d137-0470e93038fa@microchip.com>
References: <20220715175155.3567243-1-mail@conchuod.ie>
 <20220715175155.3567243-2-mail@conchuod.ie> <YtaYTgFDpGSsG+H0@arm.com>
In-Reply-To: <YtaYTgFDpGSsG+H0@arm.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ba29e9dd-2a4d-4345-43f5-08da697cf5cb
x-ms-traffictypediagnostic: MWHPR11MB1824:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eHe/QgxpXFiyqT5wCqjlhFWXVE2B0tj71hpVn1/bvVef2CS5Tr+oM9d4CT0HIKz/MQ0hBdfgRwGo4fH78wRnvh+j0+RGRBhLJ1y+TghlwkYGBCfabVQkfUYo6i+tpbKi6Zn+PacrSnwuncxGfP9nSlauzMizuBSZtZIpEKn2rDx8x7eFsal99ZuQeR7HkA8PZRqIPnUvXVpeQ52S+vKiEf+hFCVFJEprtNmxXLMxXJgfglTKAnLXQ/sZ09iorScnd+o5ngchCqz59i0Yh9ppF7gBCouvVi5ZzapG0GP420RFZM6C/fUfzxPSSnQXdKkgi+ZVUl0R8lEGeXjgaTuVN7GCUPWXtatxX1fRhy/IJoa6eOqqVepVuTdILgVczX0vGli6AoSlk1cDrqDEhbUT6WFuy0+CZavsTVC5Odgwfg/JvToAjzxhDgElBg/rEzkgvQ6zhhoZLHyZ/Upi3XASbQz7ehSS6IaUqzTnxD837HXIuQYaHl2/BtRpl5ZHc57np8MYgj/FMdoiDe3a2uh85vwEVNwAJ+dcX/SyqTw8QQ6DGq8D6lqa4HodCHa4LOpWxkZy+B93xJNP+w4D/0IwzaLWlEgtZTYOLSAYEkB/xFtvu4ma4x33LJFmSmZdagIHGmnYOb0UxBSsDxJrD+U6EIiFKW8dVKlrbx5eNfTrRIJ4t6qRfi8dgCPikUicsXS/qU37cG1pSScYTpV6YQvxnf3Hv2k+tCo4KNnmN0RzFEiodmVV/2sww/B9iwVg7rQ6Im0vURbcev/MJ/GLBS+3xdUQbkJsij+XofPwQxAPrJ7Y6flxlNf+KfXHE+8ChmotIwfPQRPPHhNPWdvpDfC2sWaiTyfrDkNmjBfxwotjfjNOj0rkkOIaB5LKVlyIxx5Q
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(396003)(376002)(366004)(136003)(53546011)(6506007)(54906003)(36756003)(91956017)(6512007)(31686004)(4326008)(26005)(66946007)(6916009)(76116006)(41300700001)(71200400001)(316002)(8676002)(6486002)(478600001)(83380400001)(86362001)(31696002)(186003)(8936002)(2616005)(64756008)(66556008)(66476007)(66446008)(38070700005)(5660300002)(2906002)(7416002)(122000001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dkExdW44Q1hUZXMyTm9oU0xXVGFmRGhOak9jQ0l2Rk8wUTgwUEZFanNZS3hC?=
 =?utf-8?B?YmxQbG1LdTBRZWxjLzZsWmIvaGQyVlhJNWhQWlY5MGVpdDVBTDdHWEhxSnFr?=
 =?utf-8?B?NEl5TE1ZaTJYTXlMMlpTbEVZaEpiS0RDcFlUWi9GaWpTUVZpT0xHZXhWdHpo?=
 =?utf-8?B?M0NrVEgxUWNPeFh1T3EwdzdTQXlQVWtZNElhVGQzYVg5TmVJbUVtdUhqa0dN?=
 =?utf-8?B?NWNrYXBmQnpXVk9vekxpbzhBQktISEFYOU9xeUtuTm1FVjllUU5iUlpDaUdr?=
 =?utf-8?B?akhkY1VaWXlMbXZRODN6WlVTYXlOMzJFdThGNFhVOVc3Q3BldG5TTlBwTTVC?=
 =?utf-8?B?eUo2L3UyQmsvOFZaV1JYckJ1cWtFalk0UVlIN05rOVVpWno5SlFsNkx2THpI?=
 =?utf-8?B?QXB4c1UzWG1jWlU0bmJvTnp4Q1BGcTY1ZXova2xMTTVmUGVFaXdkRkhDTXlj?=
 =?utf-8?B?OUdkTHBOQys5WWVIVHdVN1JSRUkyb3htelFZbkg0MFZhTlBrZ2lEKzhLc0hj?=
 =?utf-8?B?dGh0T0hoczR3ZXYwNE9PRUhtUGk5RCtXMFBlT0czWjBxWkh6aWdxTnJCVXJy?=
 =?utf-8?B?RVlrT1FDWG5pUmtwNVc0UEdpZHBZZ2NWQkpHR2wxcTE0TEZuS0ttSjAwMWJy?=
 =?utf-8?B?MXBNQndlblE1eTdJZ3hzbU1LSmFUeFI3TGU5MzdtcXBjTDNiOG02VUVxRUJG?=
 =?utf-8?B?WGRSZlc0MFBRMDRsdSt6dm5tblE1bm50cnozbFEvVmJiV29YZk5qY0FHWXJv?=
 =?utf-8?B?aGdhbXJHaGtuZFhPUXFzWjFhdU5RVXZsMTdjeU11WHZJZkRIakxaWDRUeDhL?=
 =?utf-8?B?VHhxV0o0TGpUV1NNQitCcG1YN3F0R0xQRWU2eFZJQVNZUUNRYWhVQ3VleWFP?=
 =?utf-8?B?QWN2V3NiWjlob1Fab1hmVUxqMC9UZGowUlMrQXplMGJzM25zYWVlM3J3RFdl?=
 =?utf-8?B?N0hmaUhRdVlPYzFycFZET2ZCbGZVMFpmYlByZURVdVYvaGN1TmpGWFUyS1NG?=
 =?utf-8?B?MVpIbFJCbjNNRVBhS016UEJKSlJkWS9ndUxSVnJGUko3cG9HUmFjbGFOc2My?=
 =?utf-8?B?MlZVK2kzbHczQXVmbmxDUEc1RTZDMnhBbDR2VS9qNVRNR3FzZ2pjbUZneHR2?=
 =?utf-8?B?dE5pdVdtNVN4cVVYYXRDcmRDalF4U0NEUWNoR2JISnZsalhRNElDZU51ZW1h?=
 =?utf-8?B?WWYvdnFDMEtieEZFeDhKSkM0dmh1RllyRVl1UElKbk9RRDRMNjc2enA0cm5Z?=
 =?utf-8?B?WjM1VjRVYngvbnBSR1NMSkdTQjFTanVrSzg0TTNOVTRYQm1tcGNQdklQQWxL?=
 =?utf-8?B?YzIrQ0twZ1F6ajFiZVZMNktacGZSYlYrMnlmbWYwN3ZXcklmMnBCSlNJSVE4?=
 =?utf-8?B?Qmh5UUdyaXlRSWg1RCs3aVFUNXIvWWtVSkpZSVRuYnlORCt6V0NLMFNZTS9a?=
 =?utf-8?B?MFJsTVVXOUlWVlpXTDN1UDRwTHlabGVmeXN5MnNZSm80aVRFOVFOb3VJc2VQ?=
 =?utf-8?B?WExVd3o5MERvcXZqeUppdExGODFtWllmR0t2ZEdDYStlV0x4anBVOUpEdkN3?=
 =?utf-8?B?ejN4eFJDTVE0MXRaMldBUGJZZTVOQzhnSUFIM1hwaE9oV3RGTzBJeTd4bXRL?=
 =?utf-8?B?SlJibVhTR0c1VGExVlkvdTJGNytqSUZTWm1kUFR6M21yVUpFZ0lWNFZ1Unh0?=
 =?utf-8?B?V3JuOW03N1o1b1JaVklKTnBIZzNKcnFFT2hZRVczYzhQbEp1Q24xSStEWXAy?=
 =?utf-8?B?ZlVZSFA0ck9aT2tYYW0wSW9yZUovUjZEMHFRQlh4Y3gxOGZrZXVXOXpXQUh5?=
 =?utf-8?B?VzluVEJPd1dtdmRNWW92TjhHTWFYUlpqT29FaDgyVTdsaGhqMk1qaW5oTTF0?=
 =?utf-8?B?ZVROaUFyWVlzVjJZV3lXVzR2NzB4d0JWTHpnWHB1NEpXTGhzcVp4ZkhIM29j?=
 =?utf-8?B?UjFHaXV4WGlpQ1NvcDlodTluWW9qc2hDako1RCsxRy92WmlnVy9jZ2Zkcm4x?=
 =?utf-8?B?YjNocERvUjdnWk5MUzB6QkFZSGYyQktXekdqVElaODFXRTgzL2NHZW5hUm9h?=
 =?utf-8?B?WnZraThzTzcwam42TGhlQkNaUEJHTWhjYnBuM3BXNDFqNWV3U21abVFuRmVr?=
 =?utf-8?Q?UmFn8IcapB4pwRNMS9SdqmxbC?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2EAEF99E86AB744D824BEFAFCB4732A4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba29e9dd-2a4d-4345-43f5-08da697cf5cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2022 11:51:04.6790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YVx1h3s713OWHjCkuzkH8X240GHYzJKCGWifemXUZPpQdnjVZ5TccyDRtIS5U3//pDiTFGw3gNSn5GABVWIeiz2a8Ehf7HWbko5nMToj/ek=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1824
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTkvMDcvMjAyMiAxMjo0MSwgQ2F0YWxpbiBNYXJpbmFzIHdyb3RlOg0KPiBPbiBGcmksIEp1
bCAxNSwgMjAyMiBhdCAwNjo1MTo1NVBNICswMTAwLCBDb25vciBEb29sZXkgd3JvdGU6DQo+PiBG
cm9tOiBDb25vciBEb29sZXkgPGNvbm9yLmRvb2xleUBtaWNyb2NoaXAuY29tPg0KPj4NCj4+IGFy
bTY0J3MgbWV0aG9kIG9mIGRlZmluaW5nIGEgZGVmYXVsdCBjcHUgdG9wb2xvZ3kgcmVxdWlyZXMg
b25seSBtaW5pbWFsDQo+PiBjaGFuZ2VzIHRvIGFwcGx5IHRvIFJJU0MtViBhbHNvLiBUaGUgY3Vy
cmVudCBhcm02NCBpbXBsZW1lbnRhdGlvbiBleGl0cw0KPj4gZWFybHkgaW4gYSB1bmlwcm9jZXNz
b3IgY29uZmlndXJhdGlvbiBieSByZWFkaW5nIE1QSURSICYgY2xhaW1pbmcgdGhhdA0KPj4gdW5p
cHJvY2Vzc29yIGNhbiByZWx5IG9uIHRoZSBkZWZhdWx0IHZhbHVlcy4NCj4+DQo+PiBUaGlzIGlz
IGFwcGVhcnMgdG8gYmUgYSBoYW5nb3ZlciBmcm9tIHByaW9yIHRvICczMTAyYmMwZTZhYzcgKCJh
cm02NDoNCj4+IHRvcG9sb2d5OiBTdG9wIHVzaW5nIE1QSURSIGZvciB0b3BvbG9neSBpbmZvcm1h
dGlvbiIpJywgYmVjYXVzZSB0aGUNCj4+IGN1cnJlbnQgY29kZSBqdXN0IGFzc2lnbnMgZGVmYXVs
dCB2YWx1ZXMgZm9yIG11bHRpcHJvY2Vzc29yIHN5c3RlbXMuDQo+Pg0KPj4gV2l0aCB0aGUgTVBJ
RFIgcmVmZXJlbmNlcyByZW1vdmVkLCBzdG9yZV9jcHVfdG9wb2xneSgpIGNhbiBiZSBtb3ZlZCB0
bw0KPj4gdGhlIGNvbW1vbiBhcmNoX3RvcG9sb2d5IGNvZGUuDQo+Pg0KPj4gQ0M6IHN0YWJsZUB2
Z2VyLmtlcm5lbC5vcmcNCj4gDQo+IEknZCBxdWFudGlmeSBob3cgZmFyIGJhY2sgeW91IHdhbnQg
dGhpcyB0byBnby4gSUlVQyBiYXNlZCBvbiB0aGUgRml4ZXMNCj4gdGFnIGluIHRoZSBvdGhlciBw
YXRjaCwgaXQgc2hvdWxkIHN0b3AgYXQgNS40LiBJZiB5b3Ugc2VuZCBhIHB1bGwNCj4gcmVxdWVz
dCBpbnN0ZWFkIGFuZCBoYXZlIGEgZml4ZWQgY29tbWl0IGlkLCB5b3UgY291bGQgYWRkIGl0IGFz
IGENCj4gcHJlcmVxdWlzaXRlIG9uIHRoZSBmb2xsb3dpbmcgcGF0Y2ggd2l0aG91dCBhIGNjIHN0
YWJsZSBoZXJlLg0KDQpJIGd1ZXNzIGEgUFIgbWlnaHQgYmUgdGhlIGVhc2llc3Qgd2F5IGZvciBp
dCBhbnl3YXksIHNvIHRoYXQgYm90aA0KeW91cnNlbGYgYW5kIFBhbG1lciBjb3VsZCBtZXJnZSBp
dD8NCg0KPiANCj4gRWl0aGVyIHdheToNCj4gDQo+IEFja2VkLWJ5OiBDYXRhbGluIE1hcmluYXMg
PGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29tPg0KDQpUaGFua3MuDQo=
