Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3232C542A29
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 10:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbiFHI73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 04:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233062AbiFHI6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 04:58:10 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D0C812AB33;
        Wed,  8 Jun 2022 01:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1654676346; x=1686212346;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=uKpSc68QWYjNYJFME8/EhCIeLAen5bSogFj5pbAlg1g=;
  b=VsHT90NN0ZCEaIvpPxqZdoTTSft3plry5xhiI84hdZ3r9yMugdLMvJiq
   6kmxKnhxnDdQ/1wmjtJ8iPcET4c+FYPaLMC0iU71+EIMQ7wRj6M96SHP5
   TuLg3WQlizauf3qSU385N6Xtw9UCrG6Dd1Vv9/KiVkQRKIG36Pr6BtC02
   duKE2dzDZxelUevYeYKcRsh6eC3jNDKBD0L3VoA11uXeyLNqOau1QQhDJ
   vdSzxuj32W8C3UH0hI81DlJCgQO43iF3nIjcY/Rnnh5tgSxXed722nZ27
   vqUNyux6Yo95nF7kMaborsMqTQ+qgOCLjwsgX+uZHqfZ23WojJ88Fsduo
   g==;
X-IronPort-AV: E=Sophos;i="5.91,285,1647327600"; 
   d="scan'208";a="167233512"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Jun 2022 01:18:54 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 8 Jun 2022 01:18:50 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Wed, 8 Jun 2022 01:18:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l5YjmQp8G08y4md++9EUWNOEEWQh256yzmCIBPnU4ocAlNfenSLlfqLyG9BVw06hHtpZUu9U97GdPcejv6hsQNQzw4ZJ0ppw0/Um7apGhu8vw5I/pvjNESexHb7Pv6Eg1vYeUvz6qOctTFxBK+hFEIHweCsrWpugjWB0ITEnSZekUQ6S2T1aDNEkh23kzs2UtGw1VUvR7//B8UUBtKbuVFMGNFYbiWty6S3ZxONO9RlJnBumorBqpjc5aBKO4xAKSf9RXKlEHsjHX02xz7nzPOqkpuGFDfwW+yVd2RiFlBSvDr6w4XVY84R5fFvQU/ernQ+WGrxiJP8CIPtKOe3Baw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uKpSc68QWYjNYJFME8/EhCIeLAen5bSogFj5pbAlg1g=;
 b=oWS/Aphs386PSMVBNGIt1H5ZlYYL2DLd6t4D7arQZ+JvaKtmyAP4FQw4gkafl2uKqN87xXHMJwkRCsYjY470xQ1kjEERvsR/FfSNGcSj2sb9CxCqISqokjWBq/cdt2GSFPdPY/6N8D3RigQk9S5iSMz5Cvdj1TXc58oag2/eAISlur+uHPBjRrw3rmv4UHqaof9PYt3yace08NSMK+WccsG+AxqBYj26dI5czzw8gNL9DoCMcwG7qHCmeT4gqL9kidjBmKWEBpHr+MuKJd2PDLxS4kdTx3UF2hUPmfKhSB2spkqmVa4bpD0kXW6XBc1mYxXNF7+pi7kClVGJ8MhT+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uKpSc68QWYjNYJFME8/EhCIeLAen5bSogFj5pbAlg1g=;
 b=QaaMMIU9SgRI2ncmpLGpY3podCJXLGX0bef1ODa3hLULx6rpXUIjyWNpqt5uGntFStcXeFM4hWEJuYZNrm9mNb0aGDrOilvTQR6px5Tr+QKfQW2urb/4Oo6XcPjuEOULAp8w3irNNSl8NWK97KBPrKoEqqqbzS4ATjATgFDB8YM=
Received: from CY4PR11MB1960.namprd11.prod.outlook.com (2603:10b6:903:11d::21)
 by DM5PR11MB1577.namprd11.prod.outlook.com (2603:10b6:4:a::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.15; Wed, 8 Jun 2022 08:18:45 +0000
Received: from CY4PR11MB1960.namprd11.prod.outlook.com
 ([fe80::457f:8e4d:4bc1:b997]) by CY4PR11MB1960.namprd11.prod.outlook.com
 ([fe80::457f:8e4d:4bc1:b997%12]) with mapi id 15.20.5314.019; Wed, 8 Jun 2022
 08:18:45 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <richard.genoud@gmail.com>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <patrice.chotard@foss.st.com>
CC:     <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] tty: serial: atmel: improve clock management
Thread-Topic: [PATCH 2/3] tty: serial: atmel: improve clock management
Thread-Index: AQHYexBeDSFqgTilw0Gw/vgIf3WueQ==
Date:   Wed, 8 Jun 2022 08:18:45 +0000
Message-ID: <4a189186-9871-09ab-d7e1-9346f7af0bfe@microchip.com>
References: <20220525133733.1051714-1-claudiu.beznea@microchip.com>
 <20220525133733.1051714-3-claudiu.beznea@microchip.com>
 <5dae58ca-487a-cbd8-00f8-9951a425f70e@gmail.com>
In-Reply-To: <5dae58ca-487a-cbd8-00f8-9951a425f70e@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 34c94ffd-cc06-41ac-3cde-08da492781c1
x-ms-traffictypediagnostic: DM5PR11MB1577:EE_
x-microsoft-antispam-prvs: <DM5PR11MB15771F89739AD68F27EFFFB487A49@DM5PR11MB1577.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qd1nxEpYgj8cTlzGSQcvrwJ/3m0g4bZIck0UhrnQHE1iT+io3droV6kxsV5KsSUHO3MYDNGW4YjeaR81mF9r/47H642aWbz9f9F2mTWf+Entnn7nQh6S4dY3zADzOdWQUbEkBkjsVz5s5xr8fuYdCAa5Fl3coY13zuTx1hGTbJD5UJxzIJgxeUx1g0qpXiUsHxeYMwCacFnUhZoFJh5BWaZ8nXmZmw9fblvB1SyNDlvbhh7mZRXXGRShx3ZwMcX4Wewc/DJAb52IwyXFX4FxootKV8huJ7QIrzF9VH3ziCO4Ud/+bUCE6iuTfx41XI63j8+xlhq0b/9lPawXeeWql162b+IC595yfhUneLd52kZ4Ub/qMWh/PLLenn73xFjq21dN8nDorDnUbS4UilMVUTfAOXybtZWw9L7lOVDTZ/K/1/TZ8QRNBlaa5+M2zLyC5CReGkDd9eMHk9Daprey1ZBTv0IlJsgQlnavM2BwGmpXeIC1l08O7XyEPr/dTLKuN+bizMestZZF6cTtVvJ7U7oQVKH7cQypNe6nlJfG9EZI/sMikbpftdIdrUYtEag0OF+AfrrbRG7Z7BoZDrNUrFNiT2c8r3hizyoixfzEryLR5Ho0wvgyB6+aDxHqDvUUNrLc+iZ8VRXM/PLFJV0u4GsZkUYf3JkQM5/Pg9t3Dwx8iq5B2s4EXK1ngd7cGhrwBYVbWNod55wMhKzqX0kuzWT8Ev3BCrmlwJdRKtBQToBv0uJOoOt0vSxjTO+vBQzrMwc07JS+nKuefBFGknH1hA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1960.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(110136005)(71200400001)(186003)(2906002)(2616005)(6512007)(6506007)(26005)(53546011)(36756003)(31696002)(122000001)(86362001)(66574015)(6486002)(38070700005)(54906003)(316002)(38100700002)(5660300002)(91956017)(8936002)(83380400001)(66476007)(66446008)(76116006)(8676002)(64756008)(66556008)(508600001)(4326008)(66946007)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dFAzM3prRTRWUVlGTW5GWm9iNUlvWTNheUQ4MUJDK3grRUxXQ2lCTk5MYTlK?=
 =?utf-8?B?Q01qamsySGd2UFNHZ1NzWnNlVTVVdVp1ZWdwazJvWHBVK0thUjdsWGZYQXN5?=
 =?utf-8?B?RzZtUDFWS2xwZEUrd2QyK3dMODNmSm9NRVJBaDQybVVsbHVic1JUV3pnKzIx?=
 =?utf-8?B?TmhqSldvaTVpTlB5eFFiOEdFWGd0dmtnKy9iVlp6QVJiSmNFWEU2Z0ErOC80?=
 =?utf-8?B?TEJDanVja3ZQTEczWE9mT0NYZ0hldTFjd2E2TWNLSDN0MFJvWkxvR3RabWVj?=
 =?utf-8?B?NXVsK2tXS3hoaFcvRUdLL1Z3bnM4UVNGOVYzNmRRL0svaG9hMUxWWVFYQ05o?=
 =?utf-8?B?SEFyOGt1M1B4ZHZFQ1EwYkdEOHRhTjMvLzl2SWVBcE1nSTBTMG5ESmlOcHI3?=
 =?utf-8?B?OUtSbVowbnlhK1hLV1E1b2ZSeHNOVnkxcCtSMmJRcWJQcFBvT2JNWDltenh1?=
 =?utf-8?B?VnRQamdLd2REcm44RitQQ2ZpeU1SRDh4YmNFYWErL0k1ZXpyQlBsUUVXcnBh?=
 =?utf-8?B?a1RzVk12dXZuVnR1MnRFN2RsNGdyODU4ekhmTDVKZDY5STExdTh5Q2ROYTR1?=
 =?utf-8?B?Ykx6ZWtxdGVvOXhKN2xFaEZuWEJGRm1WREQwK0ZXRElEa2RqZWozRXpWMndG?=
 =?utf-8?B?QWVlVG5ObmFSU0w2YlJwNm1pNXJWdW5ES253djFzMnc2TFpKVmlVSkc3MjI3?=
 =?utf-8?B?Wk9idWRUQnlJUmR4QzZyVDBaem9kSGdZSFFMdVNKbG5WOGoveDQ2Z1E4blNp?=
 =?utf-8?B?bUxqdmdMSEVuWHNkYlJyb0pLSHFDRDA1YWMyK200SmxOcjlzaVdCTUYvMzFk?=
 =?utf-8?B?VndnWEpHZnBSOVdlWW5NTHR5YXdTdkZibTlSbnY4T3l2ckZvcUIwUVdVNjdq?=
 =?utf-8?B?anJkR2VibnZDZk5ZK1g1ck5yN0NZWHNNTzFyd3VYc2FXQ2tFUlVFRUtQOXF4?=
 =?utf-8?B?WEJ4dEpoOUMrSUdJRlZYZk1oU1V3bmRmc1BnZXdLSzVOanZ1UlY5d2hzcmo4?=
 =?utf-8?B?eFplK3FPZkZiWHVFU3l4Ym9Qb3A2NnZKZnVjVG1qZ0dZcGkrc2dueUxyajVu?=
 =?utf-8?B?YStFUVc3U1dOWnVUWWEwc1ZlcnNUQlhpaHN0QTErcmc4WFEyUTJsSExFNDdZ?=
 =?utf-8?B?b3I5WmZMZGVCY1VCbmZaL3NVeDh3MDRPNFpsY2VZLzZoa2ZUUTltU052YzNl?=
 =?utf-8?B?bHpRZG9pc2I5MU5mYjlJTUhseXVpWldOZHgvVnBNRG5YNVp4anU2TGkxSTRx?=
 =?utf-8?B?Skc4bWs3a2N4TWR5UUthbjNEc0k1Y0tLL1B3MWtZNjJsc3NLdjZTV1NkanFX?=
 =?utf-8?B?MUtFSGxkNkN6eWhoa3FEbzUxcWxOcUYxbDFFaWRHOUpmazlZZFZqNWE1clZL?=
 =?utf-8?B?NGZMeGFzZW5ScjhFVllQdGVYY3llODZzK096UnpqNW5XcStCOTFEUk5PdkxT?=
 =?utf-8?B?ZTlTN1h0NkwxbFhjOGs5WVhGMGp2bnpObVZJUlNyMW9IUEVZRXFwY2tibWtB?=
 =?utf-8?B?U2UwbGRiYlFWMWc1aWJ6RVROREZMa3hNZmtTMXdOL29lbjYvVFNsU24ycGF5?=
 =?utf-8?B?Zm82dUN1VjVzcTVKOENWVGtwUEFXTUgvTmRvKzFZRzVJdmJJWityOFBjeFIx?=
 =?utf-8?B?Qm9ZR09YSWxXWDRtRHBJM3g2WHJ5WW8yV2VFMTlhajBjalpUTGFMS1QwOExY?=
 =?utf-8?B?Y0g0bTlXSUhmcS91VW9rb3JvN0Uxa2l1WTF3YkpnWTdtRzkwWmJRTEYvVmZ4?=
 =?utf-8?B?RWJ1cXB1T3BpY1pRQzZDdS9hMGdmMGNPZ2JOdis4Y1BTeVNzUEFIQVZaUnJl?=
 =?utf-8?B?R2VLelJVQjVkS2JwRlc0Rk9IV0dEUVo3b1BnOHBCUW1XTXNDR2FIL1NvM2U0?=
 =?utf-8?B?N3dFNTRXVCtsRjEwNU9yUzIrSG9aZ3NwWjFSMGlhckFYSHp6V0RGK042UU9l?=
 =?utf-8?B?b0VyYjNLYW1FbDlsVUt0eFFIV3RtcVAwUEdORFRyN2I0VE56bVhkSU52UmZW?=
 =?utf-8?B?ejZxS3pBdGIrNW9rYmJoOXFubGZZbTVXT3BJcUpNbVg1S0lLZHg4WEt4eEI3?=
 =?utf-8?B?VmRpcEt0bW5oT1grdHpGbCt6akRVZlBYTVYvZ01CWEZYemFvVnVRVStkc05I?=
 =?utf-8?B?djRTTmZGMjNEYmcwWkVLdFBHZnhTMlNJYkNsSGRWS3ppUFkrUXVQa0pvM2Yy?=
 =?utf-8?B?V2c3YlV1M1JUbEduZzVjREVuSnE1Q2RKQ01xZHFUUzhyaHUxc3FWWllVNmM5?=
 =?utf-8?B?N3R6QnJzUGlLdmR4cXlma0h2UVlIb0FrV0xQL0JSRVpTck1CQXF3OGgzYmlQ?=
 =?utf-8?B?dFJiMDRGM1FjRlN5U1NwVndpekI3bURPSnZRRS9iMHRPb2FvMmNEYjZSZ1hE?=
 =?utf-8?Q?iu/C8Ve+N00xbzFY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FBE7C963947A384C85FC10B168284C02@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1960.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34c94ffd-cc06-41ac-3cde-08da492781c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2022 08:18:45.5511
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3UqXAqrDRzjBNhwxBE9ifR/J5A79FvZLQIStiy5t3Oeavx8oHlPpBFBPxxCwuaToXFb8pMu6JNLdUwbYAaL0LXwvkE6PPYLJBNKMwVaL0hw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1577
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCk9uIDAyLjA2LjIwMjIgMTI6MjksIFJpY2hhcmQgR2Vub3VkIHdyb3RlOg0KPiANCj4g
SGksDQo+IA0KPiBMZSAyNS8wNS8yMDIyIMOgIDE1OjM3LCBDbGF1ZGl1IEJlem5lYSBhIMOpY3Jp
dCA6DQo+PiBhdG1lbF9wb3J0LT5jbGsgd2FzIHJlcXVlc3RlZCBpbiBhdG1lbF9pbml0X3BvcnQo
KSAod2hpY2ggaXMgY2FsbGVkIG9ubHkNCj4+IG9uIHByb2JlIHBhdGgpIG9ubHkgaWYgYXRtZWxf
cG9ydC0+Y2xrIHdhcyBOVUxMLiBCdXQgYXRtZWxfcG9ydC0+Y2xrIGlzDQo+PiBOVUxMIG9uIHBy
b2JpbmcgcGF0aC4gVGh1cyBkb24ndCBjaGVjayB0aGlzLiBBbG9uZyB3aXRoIHRoaXMgdGhlIGNs
b2NrIGlzDQo+PiBub3cgcmVxdWVzdGVkIHdpdGggZGV2bV9jbGtfZ2V0KCkgYW5kIHRoZSBjbG9j
ayByZXF1ZXN0IGhhcyBiZWVuIG1vdmVkIGluDQo+PiBhdG1lbF9zZXJpYWxfcHJvYmUoKSBmdW5j
dGlvbiB0byBhdm9pZCBkaXNhYmxpbmcvcmUtZW5hYmxpbmcgaXQgb24gcHJvYmUNCj4+IHBhdGgg
Zm9yIG11bHRpcGxlIHRpbWVzLiBBbGwgdGhlIGNoZWNrcyBvZiBhdG1lbF9wb3J0LT5jbGsgd2Vy
ZSByZW1vdmVkDQo+PiBhbG9uZyB3aXRoIGNsa19wdXQoKSBhbmQgYXRtZWxfcG9ydC0+Y2xrID0g
TlVMTC4gTm93LCBvbiBwcm9iaW5nIHRpbWUgdGhlDQo+PiBjbG9jayBpcyBlbmFibGVkIGF0IHRo
ZSBiZWdpbm5pbmcgYW5kIGRpc2FibGVkIGF0IHRoZSBlbmQgb2YgcHJvYmUuIEFzDQo+PiBhdG1l
bF9jb25zb2xlX3NldHVwKCkgaXMgY2FsbGVkIGluIHRoZSBtaWRkbGUgb2YgcHJvYmUgYW5kIGNs
b2NrIGlzDQo+PiBhbHJlYWR5IGVuYWJsZWQgYXQgdGhhdCB0aW1lIHRoZSBjbGtfcHJlcGFyZV9l
bmFibGUoKSBpbg0KPj4gYXRtZWxfY29uc29sZV9zZXR1cCgpIGhhcyBhbHNvIGJlZW4gcmVtb3Zl
ZC4NCj4gQ291bGQgeW91IHNwbGl0IHRoaXMgcGF0Y2ggaW50byBzbWFsbGVyIHN0ZXBzID8NCj4g
SSB0aGluayBpdCB3aWxsIGJlIGVhc2llciB0byByZWFkIGFuZCByZXZpZXcuDQoNCkkga2VwdCBp
dCBhcyBhIHNpbmdsZSBwYXRjaCBhcyBpdCBpcyBhbGwgcmVsYXRlZCB0byBjbG9jayBtYW5hZ2Vt
ZW50Lg0KDQpIYXZpbmcgdGhlIGNsb2NrIGVuYWJsZWQgb25seSBhdCB0aGUgYmVnaW5uaW5nIG9m
IHByb2JlIGFuZCBkaXNhYmxlZCBhdCB0aGUNCmVuZCBvZiBwcm9iZSBsZWFkIHRvIHJlbW92aW5n
IHRoZSBjb2RlIGluIGF0bWVsX2luaXRfcG9ydCgpLCBhbHNvIHJlbW92aW5nDQp0aGUgY29kZSB1
bmRlciBDT05GSUdfU0VSSUFMX0FUTUVMX0NPTlNPTEUgaW4gcHJvYmUuIFNhbWUgZm9yIHRoZSBy
ZXN0IG9mDQp0aGUgcmVtb3ZlZCBjb2RlLg0KDQpXaXRoIHRoaXMsIHdvdWxkIHlvdSBzdGlsbCB3
YW50IHRvIHNwbGl0IGl0IGluIG11bHRpcGxlIHBhdGNoZXM/DQoNClRoYW5rIHlvdSwNCkNsYXVk
aXUgQmV6bmVhDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUu
YmV6bmVhQG1pY3JvY2hpcC5jb20+DQo+PiAtLS0NCj4+IMKgIGRyaXZlcnMvdHR5L3NlcmlhbC9h
dG1lbF9zZXJpYWwuYyB8IDY1ICsrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4+IMKg
IDEgZmlsZSBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspLCA1MCBkZWxldGlvbnMoLSkNCj4+DQo+
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy90dHkvc2VyaWFsL2F0bWVsX3NlcmlhbC5jDQo+PiBiL2Ry
aXZlcnMvdHR5L3NlcmlhbC9hdG1lbF9zZXJpYWwuYw0KPj4gaW5kZXggNWM3OTNhMjNkYzU0Li4y
OTU1YjEwMTIwMTQgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL3R0eS9zZXJpYWwvYXRtZWxfc2Vy
aWFsLmMNCj4+ICsrKyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9hdG1lbF9zZXJpYWwuYw0KPj4gQEAg
LTI1MDEsMjQgKzI1MDEsNyBAQCBzdGF0aWMgaW50IGF0bWVsX2luaXRfcG9ydChzdHJ1Y3QgYXRt
ZWxfdWFydF9wb3J0DQo+PiAqYXRtZWxfcG9ydCwNCj4+IMKgwqDCoMKgwqAgaWYgKHJldCkNCj4+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiByZXQ7DQo+Pg0KPj4gLcKgwqDCoMKg
IC8qIGZvciBjb25zb2xlLCB0aGUgY2xvY2sgY291bGQgYWxyZWFkeSBiZSBjb25maWd1cmVkICov
DQo+PiAtwqDCoMKgwqAgaWYgKCFhdG1lbF9wb3J0LT5jbGspIHsNCj4+IC3CoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgYXRtZWxfcG9ydC0+Y2xrID0gY2xrX2dldCgmbXBkZXYtPmRldiwgInVzYXJ0
Iik7DQo+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChJU19FUlIoYXRtZWxfcG9ydC0+
Y2xrKSkgew0KPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0
ID0gUFRSX0VSUihhdG1lbF9wb3J0LT5jbGspOw0KPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgYXRtZWxfcG9ydC0+Y2xrID0gTlVMTDsNCj4+IC3CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiByZXQ7DQo+PiAtwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIH0NCj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0ID0gY2xr
X3ByZXBhcmVfZW5hYmxlKGF0bWVsX3BvcnQtPmNsayk7DQo+PiAtwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGlmIChyZXQpIHsNCj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGNsa19wdXQoYXRtZWxfcG9ydC0+Y2xrKTsNCj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGF0bWVsX3BvcnQtPmNsayA9IE5VTEw7DQo+PiAtwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gcmV0Ow0KPj4gLcKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB9DQo+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHBvcnQt
PnVhcnRjbGsgPSBjbGtfZ2V0X3JhdGUoYXRtZWxfcG9ydC0+Y2xrKTsNCj4+IC3CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGF0bWVsX3BvcnQtPmNsayk7DQo+
PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8qIG9ubHkgZW5hYmxlIGNsb2NrIHdoZW4gVVNB
UlQgaXMgaW4gdXNlICovDQo+PiAtwqDCoMKgwqAgfQ0KPj4gK8KgwqDCoMKgIHBvcnQtPnVhcnRj
bGsgPSBjbGtfZ2V0X3JhdGUoYXRtZWxfcG9ydC0+Y2xrKTsNCj4+DQo+PiDCoMKgwqDCoMKgIC8q
DQo+PiDCoMKgwqDCoMKgwqAgKiBVc2UgVFhFTVBUWSBmb3IgaW50ZXJydXB0IHdoZW4gcnM0ODUg
b3IgSVNPNzgxNiBlbHNlIFRYUkRZIG9yDQo+PiBAQCAtMjY0MCwxMCArMjYyMyw2IEBAIHN0YXRp
YyBpbnQgX19pbml0IGF0bWVsX2NvbnNvbGVfc2V0dXAoc3RydWN0DQo+PiBjb25zb2xlICpjbywg
Y2hhciAqb3B0aW9ucykNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAtRU5P
REVWOw0KPj4gwqDCoMKgwqDCoCB9DQo+Pg0KPj4gLcKgwqDCoMKgIHJldCA9IGNsa19wcmVwYXJl
X2VuYWJsZShhdG1lbF9wb3J0c1tjby0+aW5kZXhdLmNsayk7DQo+PiAtwqDCoMKgwqAgaWYgKHJl
dCkNCj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHJldDsNCj4+IC0NCj4gTm93
LCAiaW50IHJldDsiIGlzIHVudXNlZCwgeW91IGNhbiByZW1vdmUgaXQuDQo+IA0KPj4gwqDCoMKg
wqDCoCBhdG1lbF91YXJ0X3dyaXRlbChwb3J0LCBBVE1FTF9VU19JRFIsIC0xKTsNCj4+IMKgwqDC
oMKgwqAgYXRtZWxfdWFydF93cml0ZWwocG9ydCwgQVRNRUxfVVNfQ1IsIEFUTUVMX1VTX1JTVFNU
QSB8DQo+PiBBVE1FTF9VU19SU1RSWCk7DQo+PiDCoMKgwqDCoMKgIGF0bWVsX3VhcnRfd3JpdGVs
KHBvcnQsIEFUTUVMX1VTX0NSLCBBVE1FTF9VU19UWEVOIHwgQVRNRUxfVVNfUlhFTik7DQo+PiBA
QCAtMjg4OSwxNCArMjg2OCwyMyBAQCBzdGF0aWMgaW50IGF0bWVsX3NlcmlhbF9wcm9iZShzdHJ1
Y3QNCj4+IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4+IMKgwqDCoMKgwqAgYXRvbWljX3NldCgm
YXRtZWxfcG9ydC0+dGFza2xldF9zaHV0ZG93biwgMCk7DQo+PiDCoMKgwqDCoMKgIHNwaW5fbG9j
a19pbml0KCZhdG1lbF9wb3J0LT5sb2NrX3N1c3BlbmRlZCk7DQo+Pg0KPj4gK8KgwqDCoMKgIGF0
bWVsX3BvcnQtPmNsayA9IGRldm1fY2xrX2dldCgmcGRldi0+ZGV2LCAidXNhcnQiKTsNCj4+ICvC
oMKgwqDCoCBpZiAoSVNfRVJSKGF0bWVsX3BvcnQtPmNsaykpIHsNCj4+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgcmV0ID0gUFRSX0VSUihhdG1lbF9wb3J0LT5jbGspOw0KPj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBnb3RvIGVycjsNCj4+ICvCoMKgwqDCoCB9DQo+PiArwqDCoMKgwqAg
cmV0ID0gY2xrX3ByZXBhcmVfZW5hYmxlKGF0bWVsX3BvcnQtPmNsayk7DQo+PiArwqDCoMKgwqAg
aWYgKHJldCkNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBlcnI7DQo+PiArDQo+
PiDCoMKgwqDCoMKgIHJldCA9IGF0bWVsX2luaXRfcG9ydChhdG1lbF9wb3J0LCBwZGV2KTsNCj4+
IMKgwqDCoMKgwqAgaWYgKHJldCkNCj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBl
cnJfY2xlYXJfYml0Ow0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIGVycl9jbGtf
ZGlzYWJsZV91bnByZXBhcmU7DQo+Pg0KPj4gwqDCoMKgwqDCoCBhdG1lbF9wb3J0LT5ncGlvcyA9
IG1jdHJsX2dwaW9faW5pdCgmYXRtZWxfcG9ydC0+dWFydCwgMCk7DQo+PiDCoMKgwqDCoMKgIGlm
IChJU19FUlIoYXRtZWxfcG9ydC0+Z3Bpb3MpKSB7DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCByZXQgPSBQVFJfRVJSKGF0bWVsX3BvcnQtPmdwaW9zKTsNCj4+IC3CoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgZ290byBlcnJfY2xlYXJfYml0Ow0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBnb3RvIGVycl9jbGtfZGlzYWJsZV91bnByZXBhcmU7DQo+PiDCoMKgwqDCoMKgIH0NCj4+
DQo+PiDCoMKgwqDCoMKgIGlmICghYXRtZWxfdXNlX3BkY19yeCgmYXRtZWxfcG9ydC0+dWFydCkp
IHsNCj4+IEBAIC0yOTA1LDcgKzI4OTMsNyBAQCBzdGF0aWMgaW50IGF0bWVsX3NlcmlhbF9wcm9i
ZShzdHJ1Y3QNCj4+IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNpemVv
ZihzdHJ1Y3QgYXRtZWxfdWFydF9jaGFyKSwNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEdGUF9LRVJORUwpOw0K
Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKCFkYXRhKQ0KPj4gLcKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBlcnJfYWxsb2NfcmluZzsNCj4+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gZXJyX2Nsa19kaXNh
YmxlX3VucHJlcGFyZTsNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGF0bWVsX3BvcnQt
PnJ4X3JpbmcuYnVmID0gZGF0YTsNCj4+IMKgwqDCoMKgwqAgfQ0KPj4NCj4+IEBAIC0yOTE1LDI2
ICsyOTAzLDkgQEAgc3RhdGljIGludCBhdG1lbF9zZXJpYWxfcHJvYmUoc3RydWN0DQo+PiBwbGF0
Zm9ybV9kZXZpY2UgKnBkZXYpDQo+PiDCoMKgwqDCoMKgIGlmIChyZXQpDQo+PiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBnb3RvIGVycl9hZGRfcG9ydDsNCj4+DQo+PiAtI2lmZGVmIENPTkZJ
R19TRVJJQUxfQVRNRUxfQ09OU09MRQ0KPj4gLcKgwqDCoMKgIGlmICh1YXJ0X2NvbnNvbGUoJmF0
bWVsX3BvcnQtPnVhcnQpDQo+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCAmJiBBVE1FTF9DT05TT0xFX0RFVklDRS0+ZmxhZ3MgJiBDT05fRU5BQkxFRCkgew0KPj4g
LcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKg0KPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgICogVGhlIHNlcmlhbCBjb3JlIGVuYWJsZWQgdGhlIGNsb2NrIGZvciB1cywgc28gdW5kbw0K
Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogdGhlIGNsa19wcmVwYXJlX2VuYWJsZSgp
IGluIGF0bWVsX2NvbnNvbGVfc2V0dXAoKQ0KPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
ICovDQo+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNsa19kaXNhYmxlX3VucHJlcGFyZShh
dG1lbF9wb3J0LT5jbGspOw0KPj4gLcKgwqDCoMKgIH0NCj4+IC0jZW5kaWYNCj4+IC0NCj4+IMKg
wqDCoMKgwqAgZGV2aWNlX2luaXRfd2FrZXVwKCZwZGV2LT5kZXYsIDEpOw0KPj4gwqDCoMKgwqDC
oCBwbGF0Zm9ybV9zZXRfZHJ2ZGF0YShwZGV2LCBhdG1lbF9wb3J0KTsNCj4+DQo+PiAtwqDCoMKg
wqAgLyoNCj4+IC3CoMKgwqDCoMKgICogVGhlIHBlcmlwaGVyYWwgY2xvY2sgaGFzIGJlZW4gZGlz
YWJsZWQgYnkgYXRtZWxfaW5pdF9wb3J0KCk6DQo+PiAtwqDCoMKgwqDCoCAqIGVuYWJsZSBpdCBi
ZWZvcmUgYWNjZXNzaW5nIEkvTyByZWdpc3RlcnMNCj4+IC3CoMKgwqDCoMKgICovDQo+PiAtwqDC
oMKgwqAgY2xrX3ByZXBhcmVfZW5hYmxlKGF0bWVsX3BvcnQtPmNsayk7DQo+PiAtDQo+PiDCoMKg
wqDCoMKgIGlmIChyczQ4NV9lbmFibGVkKSB7DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBhdG1lbF91YXJ0X3dyaXRlbCgmYXRtZWxfcG9ydC0+dWFydCwgQVRNRUxfVVNfTVIsDQo+PiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBBVE1FTF9VU19VU01PREVfTk9STUFMKTsNCj4+IEBAIC0yOTU4LDEyICsyOTI5LDggQEAg
c3RhdGljIGludCBhdG1lbF9zZXJpYWxfcHJvYmUoc3RydWN0DQo+PiBwbGF0Zm9ybV9kZXZpY2Ug
KnBkZXYpDQo+PiDCoCBlcnJfYWRkX3BvcnQ6DQo+PiDCoMKgwqDCoMKgIGtmcmVlKGF0bWVsX3Bv
cnQtPnJ4X3JpbmcuYnVmKTsNCj4+IMKgwqDCoMKgwqAgYXRtZWxfcG9ydC0+cnhfcmluZy5idWYg
PSBOVUxMOw0KPj4gLWVycl9hbGxvY19yaW5nOg0KPj4gLcKgwqDCoMKgIGlmICghdWFydF9jb25z
b2xlKCZhdG1lbF9wb3J0LT51YXJ0KSkgew0KPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBj
bGtfcHV0KGF0bWVsX3BvcnQtPmNsayk7DQo+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGF0
bWVsX3BvcnQtPmNsayA9IE5VTEw7DQo+PiAtwqDCoMKgwqAgfQ0KPj4gLWVycl9jbGVhcl9iaXQ6
DQo+PiArZXJyX2Nsa19kaXNhYmxlX3VucHJlcGFyZToNCj4+ICvCoMKgwqDCoCBjbGtfZGlzYWJs
ZV91bnByZXBhcmUoYXRtZWxfcG9ydC0+Y2xrKTsNCj4+IMKgwqDCoMKgwqAgY2xlYXJfYml0KGF0
bWVsX3BvcnQtPnVhcnQubGluZSwgYXRtZWxfcG9ydHNfaW5fdXNlKTsNCj4+IMKgIGVycjoNCj4+
IMKgwqDCoMKgwqAgcmV0dXJuIHJldDsNCj4+IEBAIC0yOTk3LDggKzI5NjQsNiBAQCBzdGF0aWMg
aW50IGF0bWVsX3NlcmlhbF9yZW1vdmUoc3RydWN0DQo+PiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYp
DQo+Pg0KPj4gwqDCoMKgwqDCoCBjbGVhcl9iaXQocG9ydC0+bGluZSwgYXRtZWxfcG9ydHNfaW5f
dXNlKTsNCj4+DQo+PiAtwqDCoMKgwqAgY2xrX3B1dChhdG1lbF9wb3J0LT5jbGspOw0KPj4gLcKg
wqDCoMKgIGF0bWVsX3BvcnQtPmNsayA9IE5VTEw7DQo+PiDCoMKgwqDCoMKgIHBkZXYtPmRldi5v
Zl9ub2RlID0gTlVMTDsNCj4+DQo+PiDCoMKgwqDCoMKgIHJldHVybiByZXQ7DQo+IFRoYW5rcyAh
DQo+IA0KPiBSZWdhcmRzLA0KPiBSaWNoYXJkDQoNCg==
