Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5AC4571293
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 08:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbiGLGyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 02:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232133AbiGLGyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 02:54:37 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39BB21CB19;
        Mon, 11 Jul 2022 23:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657608873; x=1689144873;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=XpxlwgMh8e7ebyqbIb9LLyh9FsvRZdzx4ep5vaIB8OA=;
  b=uQLnuqk9uGhR4VAJTpTEt3qIXwgJ4QyoipGRJXYNgCZ/afDjAf/PUPyU
   KNsFPZToY2+ZhZpLghnbvgG2wMG2bLPgfE3VniKsTRSre27Piwh6u/rZi
   NugA1AB6rQqWp6IWKQ6WlT/gtjCFO1GwflUI986u3PutoJ0eqlHkW+hdE
   J1BcC5U/Igrntxdit7uiMyp0pNfkuFU8vOt4JhoXvyFWYcb0td8WqTmWS
   jHgRqJWqaYAjASOC+tfr/2fopbKw808X2A37zuXuJcwKw6gZSgVvYuipG
   YpgCMI5iv8Cl1RJ/PiRtpOkbH2b9lXbF9FJskV6wsu5gbbmWW6Szgfelg
   w==;
X-IronPort-AV: E=Sophos;i="5.92,265,1650956400"; 
   d="scan'208";a="164312010"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Jul 2022 23:54:32 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 11 Jul 2022 23:54:31 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Mon, 11 Jul 2022 23:54:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JuFtmHqd/dBfO7/h5rSoRMbqgm/4kaYp1uqbwQNz+bn15YuebdEF1yLFj3uG4JP399WsHv8HcSfRTQ3UqKDxX3CnA7cBMx1UTIHn1d13jsGSHSa0FRsUp0kDSfsnLn+/LJeyFWZe/NAlE6TjyjclLajmHVMfOY0//pP2veFBQ/WFyv3SDeqLfCyNe0tHQe48C/KO0ZAWasS0UJseDPZ2n2nO+VZrLOsAb9tM4jw8LbtO5WztWZ9trGNPaPCFTAaKXw8DPaXK3UHp+VA6k80TCCbGXWyNj7sDlMgx1+wCUQdnLwYpXGWkwe7cIxZmY8zc51+xIMzogQI04kIs3HVvrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XpxlwgMh8e7ebyqbIb9LLyh9FsvRZdzx4ep5vaIB8OA=;
 b=Sv/q6cidC5rsFx0KjgY2sIQtI3owjoHxs2/8TXFTYXNd4PQK50ghSVzO1qb6p2zCObj+K7lQPWRHaqEBBra1NY91iMIVfdRHU/aFld9anwJFzgO1zmjLjiZLV/ljLpJm+f60Hvp/mSkP5/bnhr/F42gSBlkpaYqLhr3QCRPagFRDGCxuKADZLiyvjtFStNKZZGb7lbWU7w+5E/LGzUz570gWdGzz3xHdNMtp30P1A6W+X0FCHo5vNQfvQFbFisl9bVPc+iKy/tDEQGA85GljkD2T/P4yz6QTXCX5YMRUpF4MoFtECBQO6R4Orxbu0YtvUFT1twAvX490JffspBVDHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XpxlwgMh8e7ebyqbIb9LLyh9FsvRZdzx4ep5vaIB8OA=;
 b=tPKlLWbqrR5VUS6eAYbZGRdJetpW2deoPM6FgpMmyQ3SQxvqPq1vtQ3p+8n91GLLByVuXl8g5M5ZRsdt9vUFnrMY0lDTiVnE86pDpTf7fKKz4ns+ZeE26+0yngerg+i9wZ3wlc6xydiei3rWkPdNuYnId/qKvzKewT8p8FMQcRI=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by MN0PR11MB6159.namprd11.prod.outlook.com (2603:10b6:208:3c9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Tue, 12 Jul
 2022 06:54:15 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5c8c:c31f:454d:824c]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5c8c:c31f:454d:824c%8]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 06:54:15 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Kavyasree.Kotagiri@microchip.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <UNGLinuxDriver@microchip.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 3/3] mfd: atmel-flexcom: Add support for lan966x
 flexcom chip-select configuration
Thread-Topic: [PATCH v8 3/3] mfd: atmel-flexcom: Add support for lan966x
 flexcom chip-select configuration
Thread-Index: AQHYlbwzPLN6FLUaSUKv5N3EtcLhjA==
Date:   Tue, 12 Jul 2022 06:54:15 +0000
Message-ID: <8da1cc68-d94a-bccb-9b63-68b634139549@microchip.com>
References: <20220708115619.254073-1-kavyasree.kotagiri@microchip.com>
 <20220708115619.254073-4-kavyasree.kotagiri@microchip.com>
In-Reply-To: <20220708115619.254073-4-kavyasree.kotagiri@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 538d8e57-50c2-4289-a98f-08da63d3559f
x-ms-traffictypediagnostic: MN0PR11MB6159:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UoSIpzJldBsCzOtjQvnomfpnBI5ZFcdpNiKFr1+XOxmQfaT+qvqxWRaA8NiDOiBPmAHg6rabvkFaB0wMrhkca6o6HfNEmULTmjCEcVWpGqsFEJMW6b1K8X81IN8/HoE9yufBG2z8S3/44oyR0gOTKAV+gEoMQUCfDPPRAoK3/Ruu2CahGxssYXz0a426GQ5bdBt0432qFDtRVANUo7R25lKjMcUaf4a/Mu3i04Bx9CJANlHuBKK6Z8ZvADOa6NpalNh7V22X8qhB8uMkypd89w9+n7xNg7VEGVIADq7hoDXxdFdw48nHuq2bX6FAczc6ukhYYjbAnMSkG37Vtrm4OxjNKoxsFEBpnCS9Km9QSMJ+ZjM04KHhP36LG0pAgu4+k9Zcsp/MBAJJxpHUVxzaprQlCIiLF21LuDqkLgzUrkW3h4JUvHupygobRXdr2ulK+7UnLbDKIgeE/DqFQCdlH61q5sBsUunScZ1DpZsSxjRYHpXccoV1ET8p+1qGDmysA31YwH1kpxwcYPDntoLTK0MdiZo/IoSRAQ/guSN1kIly7cH2qqh8184qoRPwQNlYKtIJpZU6zReJRVSbQ/OGSTvU3J1cF1MVXpVIRshqyY5BXdODDvGF0QlTmgUcn5lEcwIeFZqGXZfRDgYZ/lczJisGsdM/nQze0KqAMJHZLfQj2HOU25xFqisfUU/rsTNfe2crP3Ne3NMxmR7CMNsEdfikzm1QGc1s7rd9qxhEWsKJMURlVsanunk+t5capxMjou2sHA0wKw1DD5tk7SRS77eAtTAH/ZvrzXkAHMXlSbhoxwG5OyRneMJxU2W55u9DlDHX0sZ64EIpKEFCB6PpQZbPsFeEPaa23kx2TbeMZkmsKigt3iOU8uB/yfkOCy+5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(346002)(136003)(376002)(39860400002)(41300700001)(71200400001)(5660300002)(6512007)(2906002)(31696002)(6486002)(8936002)(38070700005)(86362001)(2616005)(478600001)(6506007)(54906003)(53546011)(76116006)(26005)(122000001)(83380400001)(316002)(38100700002)(186003)(66476007)(66946007)(36756003)(91956017)(8676002)(4326008)(6636002)(66446008)(110136005)(64756008)(66556008)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OW1zMllnYTFINnVvbGVQa1FsL2FiMngrdWpXNXU1Z1RlbzI0YlNhNTdPTG14?=
 =?utf-8?B?MjdMYzBVMjVvVmt2RGZQRzR0Y1c2MlUrRlB3aGlaUVdPQVFPQjllRVJBQUV6?=
 =?utf-8?B?NldpL3FpbjFmdFQ2VDlhWCtheGM3TjFaZDBIeU9vSWtWV1drOTJFRi9KQXZ6?=
 =?utf-8?B?UGdUNG9IWDFNOWsxK2RISEtjNWVDeU9jVXo0N0o2QUlhdXVoejRwR0dZMzEz?=
 =?utf-8?B?bU4wK24rNDFhMUc0TnQ5V0I1RTAvRWhSY2YzeFl4SHJreHFSUExlblJodzJh?=
 =?utf-8?B?RllCS2xrOHZPNUFNLytETVA4UWlRK0xRbjFKSVh5U0lSUy9DamQyOFhuNlBD?=
 =?utf-8?B?eW8xVklNdHZzdmFPMXluV3pMMGtPN2k2YjM3OXUxSkZFVXNoenRKTDdVV2Zt?=
 =?utf-8?B?ek53dktQYS9VZnI0TjhUdytiZHpqaVRFT1A4R21PaVEzT2twdXRkZHVuYjZN?=
 =?utf-8?B?Q0VxanNQNnJ4a001d1FMUXhDZUEzcWFsSk1vZERxNFR3aFIwTUVkMmE5bFN0?=
 =?utf-8?B?anN6TXYzb2RGdUNFL2U5cHNqVmkwRTMrY2dJL2d4dzJkQ2Mxa0Q4ZlRiNG91?=
 =?utf-8?B?MkdnajVKYmhyS0kyaVRxNFQzUUxFeFBmZUFEaVRYTXZkVWFGWStLcEI4Yjlt?=
 =?utf-8?B?aEZrRjJJZGx0RjN5Z3FpTHBsbG1Yb3FyVC9menFFb1BpNzY4M1JiTk9Wc0d4?=
 =?utf-8?B?MGIwSlBUdTRJS0EyOEpPSnhDcmRXT1d1NHJPVGsxbXdSdkNSUVZGalNEeVJG?=
 =?utf-8?B?ZzhLRklmZ0ROeDNXQWE5SjJMMEwwMGU1TkFIajk1QUE0d29ESll2NHp4VzhS?=
 =?utf-8?B?RjVua3Z0aWZWY0JWZ3ZaWk1IQkFIczl0azc4V0k3MllmQnIxbG5DaW5OdHAw?=
 =?utf-8?B?ajFRUURsVndvQ1RXck13RVg3dS94M05HSmRYZnJFWHhJMVJXTGxsOEpoRkR3?=
 =?utf-8?B?Ynd5VWNselFnVmMxUDZEVkNSVGhzdllDNGxwYkRTaEZMQzF2ZTAwRHRRdXFJ?=
 =?utf-8?B?UG1hU3VHVllUQnRTMGY4Y1FKWDUrVURaRjA1Uk9DcEl6NU5xYnRqWmszRnpM?=
 =?utf-8?B?T09ZOHVDVHdKcmFRbWlndmNnQUI5bU5jOW5Vb0NMLzE4dUsvdWJpTGtUSFFq?=
 =?utf-8?B?NlZ1azdJMkl0a2pscDEzRGd4V21nSVZYWHVrOXFUNEQxL3gxVWlxVXRuVE4r?=
 =?utf-8?B?dXlabUtYblk2cWc5d00ya2FkeUZpZllqU2lLcGFoU3gyYVBLRzBpUFdBTDJU?=
 =?utf-8?B?aDg5ZS9CaWRQbjZGbGdhYjBHaEMxWjl3ek12NUZWSzN6YU90RGtQanorZFR5?=
 =?utf-8?B?OUJKaUhhYTFUTVNGVE5RUzFmVHhYOFZNNjFOcFhoTDdFbW5yMU5RQm4zVVlz?=
 =?utf-8?B?Qi81cDJmUEZFb2dEVXhjb1plVGh6TlphQ2VDZ1pVNkdQcGNLSEV4N2Z2d0Zj?=
 =?utf-8?B?d0FDelQxcnhrOEtGOFhpa3crUkx6V3k4UkJvZmk3REdqbmYzR0xoaVhuMmk4?=
 =?utf-8?B?ck9aNFlZZkFxeGx5SjJ2SzNWN1UyOWEyQjQ1YkhxdndTNVA3dnl3dk1YbklU?=
 =?utf-8?B?RTNsSjBGdjF0eXQ0c1hqZ2l0T1pVQ1hLL3dodndOL093eU5CcnRPYkd3ZmZV?=
 =?utf-8?B?Y1BNaTkyZFAyZmlwRWwxcjNhSGp4clRLQ2xkVit1UlVIVWtkelA0OXRlcG1N?=
 =?utf-8?B?WEFWZTR3eDhPZXpKSFg1bCtIMldSZkkrOXRNM2NkQzVCa0NlUkxuMUFSWWZn?=
 =?utf-8?B?MXltM25IaytEb2xIaHI3QUpUck1sN0R6QUE2VHpaMnRtY3pRektZR2tFN2xH?=
 =?utf-8?B?T1k5RXY3MFFOaXFVNHR0R25iVWF3TzRscktMZk5MZHFxRWNhOGFpbTVGK2Q3?=
 =?utf-8?B?UHF4dmplU0ZYdHB6UzFmczdXV3FySTdydm5vanI2dXliKzMvbkpheEd2VXE4?=
 =?utf-8?B?N2FDdEFJbHRuL21wYk9HeHBjZlQzMlVQZGR2UkVKUFpGditLUk5TYkFJekNP?=
 =?utf-8?B?WFA0VUx2MEh1UWpzd1VaWkptT09DY3hRN3hjalhGTGVyNkk1Tzc5VEFJeTVr?=
 =?utf-8?B?Y2ZvUjVSSVdrY3YzQWdDNXBzcmp1elZnU2ZiNkNwZU9JQ29tQnVrQUc5YkF3?=
 =?utf-8?B?dHc4VytOV2M5VTBxSEptRHlGUEhxeTdhT0hZK0I4MnIzb1ZHZ3ZpMWJiOElu?=
 =?utf-8?B?UUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3FF286C896AD2847A3AD6410E474DE2E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 538d8e57-50c2-4289-a98f-08da63d3559f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2022 06:54:15.1497
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L4QbwN/iqo/8krr1O7P3WgY1dhipyULhUpsr55aFFedrH9bGCGlllmEg86Qz0EWFdj0vo1ZSMAjo3zmiZ2CQW46FSybs0dzlt+OTqP+PIv8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6159
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDguMDcuMjAyMiAxNDo1NiwgS2F2eWFzcmVlIEtvdGFnaXJpIHdyb3RlOg0KPiBMQU45NjZ4
IFNvQyBoYXZlIDUgZmxleGNvbXMuIEVhY2ggZmxleGNvbSBoYXMgMiBjaGlwLXNlbGVjdHMNCj4g
d2hpY2ggYXJlIG9wdGlvbmFsIEkvTyBsaW5lcy4gRm9yIGVhY2ggY2hpcCBzZWxlY3Qgb2YgZWFj
aA0KPiBmbGV4Y29tIHRoZXJlIGlzIGEgY29uZmlndXJhdGlvbiByZWdpc3RlciBGTEVYQ09NX1NI
QVJFRFswLTRdOlNTX01BU0tbMC0xXS4NCj4gVGhlIHdpZHRoIG9mIGNvbmZpZ3VyYXRpb24gcmVn
aXN0ZXIgaXMgMjEgYmVjYXVzZSB0aGVyZSBhcmUNCj4gMjEgc2hhcmVkIHBpbnMgb24gZWFjaCBv
ZiB3aGljaCB0aGUgY2hpcCBzZWxlY3QgY2FuIGJlIG1hcHBlZC4NCj4gRWFjaCBiaXQgb2YgdGhl
IHJlZ2lzdGVyIHJlcHJlc2VudHMgYSBkaWZmZXJlbnQgRkxFWENPTV9TSEFSRUQgcGluLg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogS2F2eWFzcmVlIEtvdGFnaXJpIDxrYXZ5YXNyZWUua290YWdpcmlA
bWljcm9jaGlwLmNvbT4NCg0KSSByZW1lbWJlciBJIHBvc3RlZCBteSByYiB0YWcgb24gYSBwcmV2
aW91cyB2ZXJzaW9uLi4uIEFueXdheToNCg0KUmV2aWV3ZWQtYnk6IENsYXVkaXUgQmV6bmVhIDxj
bGF1ZGl1LmJlem5lYUBtaWNyb2NoaXAuY29tPg0KDQoNCj4gLS0tDQo+IHY3IC0+IHY4Og0KPiAg
LSBDaGFuZ2VkIGNvbXBhdGlibGUgc3RyaW5nIHRvIG1pY3JvY2hpcCxsYW45NjY4LWZsZXhjb20u
DQo+IA0KPiB2NiAtPiB2NzoNCj4gIC0gTm8gY2hhbmdlcy4NCj4gDQo+IHY1IC0+IHY2Og0KPiAg
LSBObyBjaGFuZ2VzLg0KPiANCj4gdjQgLT4gdjU6DQo+ICAtIE5vIGNoYW5nZXMuDQo+IA0KPiB2
MyAtPiB2NDoNCj4gIC0gQWRkIGNvbmRpdGlvbiBmb3IgYSBmbGV4Y29tIHdoZXRoZXIgdG8gY29u
ZmlndXJlIGNoaXAtc2VsZWN0IGxpbmVzDQo+ICAgIG9yIG5vdCwgYmFzZWQgb24gIm1pY3JvY2hp
cCxmbHgtc2hyZC1waW5zIiBwcm9wZXJ0eSBleGlzdGVuY2UgYmVjYXVzZQ0KPiAgICBjaGlwLXNl
bGVjdCBsaW5lcyBhcmUgb3B0aW9uYWwuDQo+IA0KPiB2MiAtPiB2MzoNCj4gIC0gdXNlZCBnb3Rv
IGxhYmVsIGZvciBjbGtfZGlzYWJsZSBpbiBlcnJvciBjYXNlcy4NCj4gDQo+IHYxIC0+IHYyOg0K
PiAgLSB1c2UgR0VOTUFTSyBmb3IgbWFzaywgbWFjcm9zIGZvciBtYXhpbXVtIGFsbG93ZWQgdmFs
dWVzLg0KPiAgLSB1c2UgdTMyIHZhbHVlcyBmb3IgZmxleGNvbSBjaGlwc2VsZWN0cyBpbnN0ZWFk
IG9mIHN0cmluZ3MuDQo+ICAtIGRpc2FibGUgY2xvY2sgaW4gY2FzZSBvZiBlcnJvcnMuDQo+IA0K
PiAgZHJpdmVycy9tZmQvYXRtZWwtZmxleGNvbS5jIHwgOTQgKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDkzIGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21mZC9hdG1lbC1mbGV4Y29t
LmMgYi9kcml2ZXJzL21mZC9hdG1lbC1mbGV4Y29tLmMNCj4gaW5kZXggMzNjYWE0ZmJhNmFmLi45
MmVhMTVkNWZkNzIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbWZkL2F0bWVsLWZsZXhjb20uYw0K
PiArKysgYi9kcml2ZXJzL21mZC9hdG1lbC1mbGV4Y29tLmMNCj4gQEAgLTI4LDE1ICsyOCw2OCBA
QA0KPiAgI2RlZmluZSBGTEVYX01SX09QTU9ERShvcG1vZGUpCSgoKG9wbW9kZSkgPDwgRkxFWF9N
Ul9PUE1PREVfT0ZGU0VUKSAmCVwNCj4gIAkJCQkgRkxFWF9NUl9PUE1PREVfTUFTSykNCj4gIA0K
PiArLyogTEFOOTY2eCBmbGV4Y29tIHNoYXJlZCByZWdpc3RlciBvZmZzZXRzICovDQo+ICsjZGVm
aW5lIEZMRVhfU0hSRF9TU19NQVNLXzAJMHgwDQo+ICsjZGVmaW5lIEZMRVhfU0hSRF9TU19NQVNL
XzEJMHg0DQo+ICsjZGVmaW5lIEZMRVhfU0hSRF9QSU5fTUFYCTIwDQo+ICsjZGVmaW5lIEZMRVhf
Q1NfTUFYCQkxDQo+ICsjZGVmaW5lIEZMRVhfU0hSRF9NQVNLCQlHRU5NQVNLKDIwLCAwKQ0KPiAr
DQo+ICtzdHJ1Y3QgYXRtZWxfZmxleF9jYXBzIHsNCj4gKwlib29sIGhhc19mbHhfY3M7DQo+ICt9
Ow0KPiArDQo+ICBzdHJ1Y3QgYXRtZWxfZmxleGNvbSB7DQo+ICAJdm9pZCBfX2lvbWVtICpiYXNl
Ow0KPiArCXZvaWQgX19pb21lbSAqZmxleGNvbV9zaGFyZWRfYmFzZTsNCj4gIAl1MzIgb3Btb2Rl
Ow0KPiAgCXN0cnVjdCBjbGsgKmNsazsNCj4gIH07DQo+ICANCj4gK3N0YXRpYyBpbnQgYXRtZWxf
ZmxleGNvbV9sYW45NjZ4X2NzX2NvbmZpZyhzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0K
PiArew0KPiArCXN0cnVjdCBhdG1lbF9mbGV4Y29tICpkZGF0YSA9IGRldl9nZXRfZHJ2ZGF0YSgm
cGRldi0+ZGV2KTsNCj4gKwlzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wID0gcGRldi0+ZGV2Lm9mX25v
ZGU7DQo+ICsJdTMyIGZseF9zaHJkX3BpbnNbMl0sIGZseF9jc1syXSwgdmFsOw0KPiArCWludCBl
cnIsIGksIGNvdW50Ow0KPiArDQo+ICsJY291bnQgPSBvZl9wcm9wZXJ0eV9jb3VudF91MzJfZWxl
bXMobnAsICJtaWNyb2NoaXAsZmx4LXNocmQtcGlucyIpOw0KPiArCWlmIChjb3VudCA8PSAwIHx8
IGNvdW50ID4gMikgew0KPiArCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJJbnZhbGlkICVzIHByb3Bl
cnR5ICglZClcbiIsICJmbHgtc2hyZC1waW5zIiwNCj4gKwkJCQljb3VudCk7DQo+ICsJCXJldHVy
biAtRUlOVkFMOw0KPiArCX0NCj4gKw0KPiArCWVyciA9IG9mX3Byb3BlcnR5X3JlYWRfdTMyX2Fy
cmF5KG5wLCAibWljcm9jaGlwLGZseC1zaHJkLXBpbnMiLCBmbHhfc2hyZF9waW5zLCBjb3VudCk7
DQo+ICsJaWYgKGVycikNCj4gKwkJcmV0dXJuIGVycjsNCj4gKw0KPiArCWVyciA9IG9mX3Byb3Bl
cnR5X3JlYWRfdTMyX2FycmF5KG5wLCAibWljcm9jaGlwLGZseC1jcyIsIGZseF9jcywgY291bnQp
Ow0KPiArCWlmIChlcnIpDQo+ICsJCXJldHVybiBlcnI7DQo+ICsNCj4gKwlmb3IgKGkgPSAwOyBp
IDwgY291bnQ7IGkrKykgew0KPiArCQlpZiAoZmx4X3NocmRfcGluc1tpXSA+IEZMRVhfU0hSRF9Q
SU5fTUFYKQ0KPiArCQkJcmV0dXJuIC1FSU5WQUw7DQo+ICsNCj4gKwkJaWYgKGZseF9jc1tpXSA+
IEZMRVhfQ1NfTUFYKQ0KPiArCQkJcmV0dXJuIC1FSU5WQUw7DQo+ICsNCj4gKwkJdmFsID0gfigx
IDw8IGZseF9zaHJkX3BpbnNbaV0pICYgRkxFWF9TSFJEX01BU0s7DQo+ICsNCj4gKwkJaWYgKGZs
eF9jc1tpXSA9PSAwKQ0KPiArCQkJd3JpdGVsKHZhbCwgZGRhdGEtPmZsZXhjb21fc2hhcmVkX2Jh
c2UgKyBGTEVYX1NIUkRfU1NfTUFTS18wKTsNCj4gKwkJZWxzZQ0KPiArCQkJd3JpdGVsKHZhbCwg
ZGRhdGEtPmZsZXhjb21fc2hhcmVkX2Jhc2UgKyBGTEVYX1NIUkRfU1NfTUFTS18xKTsNCj4gKwl9
DQo+ICsNCj4gKwlyZXR1cm4gMDsNCj4gK30NCj4gKw0KPiAgc3RhdGljIGludCBhdG1lbF9mbGV4
Y29tX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICB7DQo+ICAJc3RydWN0
IGRldmljZV9ub2RlICpucCA9IHBkZXYtPmRldi5vZl9ub2RlOw0KPiArCWNvbnN0IHN0cnVjdCBh
dG1lbF9mbGV4X2NhcHMgKmNhcHM7DQo+ICAJc3RydWN0IHJlc291cmNlICpyZXM7DQo+ICAJc3Ry
dWN0IGF0bWVsX2ZsZXhjb20gKmRkYXRhOw0KPiAgCWludCBlcnI7DQo+IEBAIC03NiwxMyArMTI5
LDUyIEBAIHN0YXRpYyBpbnQgYXRtZWxfZmxleGNvbV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2
aWNlICpwZGV2KQ0KPiAgCSAqLw0KPiAgCXdyaXRlbChGTEVYX01SX09QTU9ERShkZGF0YS0+b3Bt
b2RlKSwgZGRhdGEtPmJhc2UgKyBGTEVYX01SKTsNCj4gIA0KPiArCWNhcHMgPSBvZl9kZXZpY2Vf
Z2V0X21hdGNoX2RhdGEoJnBkZXYtPmRldik7DQo+ICsJaWYgKCFjYXBzKSB7DQo+ICsJCWRldl9l
cnIoJnBkZXYtPmRldiwgIkNvdWxkIG5vdCByZXRyaWV2ZSBmbGV4Y29tIGNhcHNcbiIpOw0KPiAr
CQllcnIgPSAtRUlOVkFMOw0KPiArCQlnb3RvIGNsa19kaXNhYmxlOw0KPiArCX0NCj4gKw0KPiAr
CWlmIChjYXBzLT5oYXNfZmx4X2NzICYmIG9mX3Byb3BlcnR5X3JlYWRfYm9vbChucCwgIm1pY3Jv
Y2hpcCxmbHgtc2hyZC1waW5zIikpIHsNCj4gKwkJZGRhdGEtPmZsZXhjb21fc2hhcmVkX2Jhc2Ug
PSBkZXZtX3BsYXRmb3JtX2dldF9hbmRfaW9yZW1hcF9yZXNvdXJjZShwZGV2LCAxLCBOVUxMKTsN
Cj4gKwkJaWYgKElTX0VSUihkZGF0YS0+ZmxleGNvbV9zaGFyZWRfYmFzZSkpIHsNCj4gKwkJCWVy
ciA9IGRldl9lcnJfcHJvYmUoJnBkZXYtPmRldiwNCj4gKwkJCQkJUFRSX0VSUihkZGF0YS0+Zmxl
eGNvbV9zaGFyZWRfYmFzZSksDQo+ICsJCQkJCSJmYWlsZWQgdG8gZ2V0IGZsZXhjb20gc2hhcmVk
IGJhc2UgYWRkcmVzc1xuIik7DQo+ICsJCQlnb3RvIGNsa19kaXNhYmxlOw0KPiArCQl9DQo+ICsN
Cj4gKwkJZXJyID0gYXRtZWxfZmxleGNvbV9sYW45NjZ4X2NzX2NvbmZpZyhwZGV2KTsNCj4gKwkJ
aWYgKGVycikNCj4gKwkJCWdvdG8gY2xrX2Rpc2FibGU7DQo+ICsJfQ0KPiArDQo+ICtjbGtfZGlz
YWJsZToNCj4gIAljbGtfZGlzYWJsZV91bnByZXBhcmUoZGRhdGEtPmNsayk7DQo+ICsJaWYgKGVy
cikNCj4gKwkJcmV0dXJuIGVycjsNCj4gIA0KPiAgCXJldHVybiBkZXZtX29mX3BsYXRmb3JtX3Bv
cHVsYXRlKCZwZGV2LT5kZXYpOw0KPiAgfQ0KPiAgDQo+ICtzdGF0aWMgY29uc3Qgc3RydWN0IGF0
bWVsX2ZsZXhfY2FwcyBhdG1lbF9mbGV4Y29tX2NhcHMgPSB7fTsNCj4gKw0KPiArc3RhdGljIGNv
bnN0IHN0cnVjdCBhdG1lbF9mbGV4X2NhcHMgbGFuOTY2eF9mbGV4Y29tX2NhcHMgPSB7DQo+ICsJ
Lmhhc19mbHhfY3MgPSB0cnVlLA0KPiArfTsNCj4gKw0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBv
Zl9kZXZpY2VfaWQgYXRtZWxfZmxleGNvbV9vZl9tYXRjaFtdID0gew0KPiAtCXsgLmNvbXBhdGli
bGUgPSAiYXRtZWwsc2FtYTVkMi1mbGV4Y29tIiB9LA0KPiArCXsNCj4gKwkJLmNvbXBhdGlibGUg
PSAiYXRtZWwsc2FtYTVkMi1mbGV4Y29tIiwNCj4gKwkJLmRhdGEgPSAmYXRtZWxfZmxleGNvbV9j
YXBzLA0KPiArCX0sDQo+ICsNCj4gKwl7DQo+ICsJCS5jb21wYXRpYmxlID0gIm1pY3JvY2hpcCxs
YW45NjY4LWZsZXhjb20iLA0KPiArCQkuZGF0YSA9ICZsYW45NjZ4X2ZsZXhjb21fY2FwcywNCj4g
Kwl9LA0KPiArDQo+ICAJeyAvKiBzZW50aW5lbCAqLyB9DQo+ICB9Ow0KPiAgTU9EVUxFX0RFVklD
RV9UQUJMRShvZiwgYXRtZWxfZmxleGNvbV9vZl9tYXRjaCk7DQoNCg==
