Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823A14CFA6A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 11:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239429AbiCGKQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 05:16:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240351AbiCGKA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 05:00:58 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DAF4DF2D;
        Mon,  7 Mar 2022 01:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646646463; x=1678182463;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ykzgbS9sk8UyPff9EfK82V6AnYXzQDPmqj7oXLfO26g=;
  b=OpRZ6Nlc2qdrRp6KOj95z2ld8h8MLhnCpzKEMLFnEsROoWDR1ti3oRek
   Ry8er2C3AM36aALSsGtxwrOyIflP6QFwa5jwS1M6qM8xEYA/l2ge3UIBs
   BrmM6GtbGchdZPshMFogISLCedQXeobvn7GH9s3fomkjsIv9ezk+isc4c
   WxE5NsDZJ4KIVpbCC7A4tunG6HdsTo1yI50ClWddIS8F/PgWu5WSF0e1B
   Cj53tj9M+avCxotheHpMqBKSYkS123sFlybTjNeWwao2BOBtsr/sB82Zh
   0iuLiY1S6c37eZ8HwaEJ3HTLoKfHXQjQ82NhsGvF/M92Fy7qv8hyJtLXL
   g==;
X-IronPort-AV: E=Sophos;i="5.90,161,1643698800"; 
   d="scan'208";a="155928516"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Mar 2022 02:47:41 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 7 Mar 2022 02:47:40 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Mon, 7 Mar 2022 02:47:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HvO9wgRIZRNvzMAZ0KfFxu7kJPLc7SUi/x6QNie9i+Chmntckj7xau7ysGJWPs9AAuWuLiiYZ8vTbI+ANAhtTP0m4JzUx9TF8RcCw5NxoLrRL+ysepkYLobG1kpTktVL/j/cewdXZetCowY5XI369bPZ79E0rcnqdPrM4YSPKZ6XH3PCUdKcgx05HIrNZKA9y9fDmaMbpGxnHf+8bwff3xeQFQm1IgqKKnwEowEWgjkKbpyGz9wWHYyUmDCgNHI/FZKnu+oNQqCXWgtbCsCs7BEzlVEkIt3ZM7baRNP0/XAEAuTpHP0ykRUC/2iBrultTSCcyO9U+PTEGD35U3agMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ykzgbS9sk8UyPff9EfK82V6AnYXzQDPmqj7oXLfO26g=;
 b=a0il5j1teMR/QP97gQn+/sz/PVqZZYv9NcRAnykTx0+EW/22/QRDJAy8pJbzL2GucfDZBHNaC2pGbBsRyNxcIWy4CWkfqZIiEEWNHHyV09WyeqFetlr03xfNHonlcwxkSlyJ3FK4el/uuKc8M+lt5yjzzTeOCeaVKhlAmhhLpULyPt0/nC24iEeB/wBUlQN61ab74bO/57v6R8XdXvPfqbjFXHRB8L6d3A3qVYYM6ZcrOZvipQCSaamM8V6fEwEslw8Li+wFMUxR29pPNn9n6ewNHOn7SHLfswhQhwzJ/1o/7IjefLjvcUAP+dSmMl9uwD5JKq7H7tZWYeJEdm5MIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ykzgbS9sk8UyPff9EfK82V6AnYXzQDPmqj7oXLfO26g=;
 b=B4EVsdHgWsIMx8pLRTgD0MS3Il87L3zFft1+vf2e1uVBm7hnuXFfInxKX2/zriwqVcCB5N9saejKjFZhvbN4M+9vsFbghYBeSyCjuUi5NzUPwu/Vn2CPFJ/i5FPT1f6V+XE9X720tGdnPen6+x24lsA2aomEWipc+Z6y3HCQUa0=
Received: from CO1PR11MB4769.namprd11.prod.outlook.com (2603:10b6:303:91::21)
 by DM4PR11MB5343.namprd11.prod.outlook.com (2603:10b6:5:392::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Mon, 7 Mar
 2022 09:47:34 +0000
Received: from CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::6d66:3f1d:7b05:660b]) by CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::6d66:3f1d:7b05:660b%5]) with mapi id 15.20.5038.026; Mon, 7 Mar 2022
 09:47:34 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Codrin.Ciubotariu@microchip.com>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH] clk: at91: sama7g5: fix parents of PDMCs' GCLK
Thread-Topic: [PATCH] clk: at91: sama7g5: fix parents of PDMCs' GCLK
Thread-Index: AQHYMghetY0lSBUbzU6JrhPhrIxlJg==
Date:   Mon, 7 Mar 2022 09:47:34 +0000
Message-ID: <2d6f6552-5ff8-295d-e7e1-d4dc5f767ebd@microchip.com>
References: <20220304182616.1920392-1-codrin.ciubotariu@microchip.com>
In-Reply-To: <20220304182616.1920392-1-codrin.ciubotariu@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4212a09b-c275-466c-f1c4-08da001f8184
x-ms-traffictypediagnostic: DM4PR11MB5343:EE_
x-microsoft-antispam-prvs: <DM4PR11MB53437402FB5915C3146F89B387089@DM4PR11MB5343.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FdGvNitWeyGeGm0I25/13hWIfHEv0Rc+X7ZhuB4YPl7kZeiuiM/7/vWakLniW+P1XBQXQyrg2C/yu4v1L82cTWgJuDb1Zae+yNa94l9ByxMdgLTTrWw1FkLECfYM3Sd0fGfX4TywbmiJPlE3LqovqPETJnQ6r4aKQgq+q1zcN3MkvcX3cH09zF1eWLAcaw4WuAxiESp1GPtNu369bBQLrLQ2zZ/o9xnSEeSqmFGQwFy7RYzdD2JoCNkzlBDG8CMO2CT4ZJ4e0VInDNc3TI7LfxSKMxrTf4Nr9C6RRGuotOldSQsQFwwwKuZVjDzDK6gDP1FTZUbhl6Etg3fZt60+95ym+hRQrcvK6tz6Toio8FBpOjIU2E41l5DBqesojrGlf9GQO6GYYs+VIWABY+UjpdOVs5NSUphvB4zUVCQXOasPhbCN0PuOBfyZIAtQrsEFrdPVRX6FQQVirDZ8yLZlrkYKzEewEw+V5+QHt/hRpSzyluBhjkMlr2ablgw2Gft/Bjwgkx593onXYfgHqfn7qwvsYyd+WDm4wQ1uEVdUUMDTSI5k//9Ct0qMxlHlq3fJMfrUL0lqsNXlsxWgfoSS9YbPKMuMRkbY0UayaGj6UjziRvnfz3GBPicz92zocSjn33A/PrglqnNFlTugPk/XndnUuqcb5otFDGc18Exxd+m+AOgtu4gdFBDALkK9gX1JeiNvBjQLo3SeKAgghILIZghrY3cC4zsCcusk7A3KfsS021gxK9cQ7Os8j9SqDduAaJvlOQMXKaYHZjfbsh7mQw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4769.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(6486002)(2616005)(66946007)(8936002)(36756003)(4326008)(8676002)(5660300002)(508600001)(76116006)(66556008)(91956017)(31696002)(2906002)(66476007)(64756008)(66446008)(83380400001)(86362001)(26005)(71200400001)(31686004)(6512007)(316002)(6506007)(186003)(122000001)(54906003)(38070700005)(110136005)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c0RVNTR2S2RYV01VUFFyT0RhUVlDNFFpaGhwdWY2Q21mdkxOa2F0Rko5Vndm?=
 =?utf-8?B?NU8walM4QUVHa1BHeEJtenBtRm1CTzhpTkNZQUdSK1R2RjBiRDFENmJoT1Fa?=
 =?utf-8?B?WDFOVTVHTTdISytMalJ2VFh0cVRiU1RFMWtFdmIyZzZjNXhoMjNOUkVMUTNJ?=
 =?utf-8?B?VzFLd083L0EzRUN6R3F0TExSanJnbzVpbDNYY3VCTFNWckJuOHJya1FEOFlF?=
 =?utf-8?B?OGd0NExxY1gyMW8zeHFiMUViejc2dkhoZnN4eE5TMWdaZW9YeFc4OGdvSG8r?=
 =?utf-8?B?RTlEcllCTm1zK3ZVdllEU3M4bUJ1eXJiKzcySkRlNmo3NEZ5SFJScFpZUmVa?=
 =?utf-8?B?VkVhQ1ZOcWFkekxNYkZlK2xnUm9HV2VxWm92QjdGQy9WaFNhaDVMN0pCNXdH?=
 =?utf-8?B?U2phZVhGTDJLbmZrN2tpWlZoTTVWNTdVOE9xR0ZpdUVUK09kQ1Q2ckZHR3d4?=
 =?utf-8?B?dmJLMEdTQUZpMXlFQk03R2dxK1k0UTdyS3ZQMlI0ME4zOTdPaTg1MnlrNUpv?=
 =?utf-8?B?aU4vSS9aUkF4TDNGT3VtVGVWdko2YmxqYzBLVmJUYmZEQ1BqR1pQclBkWk52?=
 =?utf-8?B?V24zOVhyVEpJOE9GeitEVzZ0TDM3WkQ3R29vcERFU1pTeWYwYm5EM3ptNzNh?=
 =?utf-8?B?MFpGTG40YWlLZStDb0NPcFFnUXd3emZjTS90b3BOYjJ0YTlFR3ZlWGRxTmd5?=
 =?utf-8?B?NytZdk1meTFnT3FoWkxpUjBCWjRhM0pqa3VLb04rRzhubi9qV3VveDAzeWYw?=
 =?utf-8?B?NW1qTDZmNnQwZmJwdGtWR0RQYklVVi9scE9QK0pkb2N0Wm1ob3FYUk93UERM?=
 =?utf-8?B?dVBEVldDYlNtRmRGajIyM1ozL0YvTUVsNERxVWx0NFJHSVVvclVhSUx2d3hw?=
 =?utf-8?B?aWVFeXZYd0t1NzNlSkxpdm9Ya1hSQUxpWEtRMGVNa0J3dU1vZzN0cXNOR2Rh?=
 =?utf-8?B?NXVkZHRWRWZQbC82eTRaakNQWFkzbnVDdVd2YmZiZWpWQ05ndXROUTdFYkV0?=
 =?utf-8?B?eUtNVnUvMHh0NFR4NWdZbVpWNlN0d0ZUejhhMGhHcUdYcEZLVDIzNDJkd3Bv?=
 =?utf-8?B?aE9ESjhGbUoycWsrOWdidE9GK2trajl4enpJZE1mOEJhRnlMK0NxelBDMXp2?=
 =?utf-8?B?N2lGbUEzQ2hnemJOR0tVVHdEMG1vd0RwMUtnSitYd1lNZTEvZm9ES0hBbnJV?=
 =?utf-8?B?OGFiK0lRZ0FMMW9uc2pmKzFsZ3BNL2pWU0JPLy9HeGkyNjVmZEJsQlNkVjkw?=
 =?utf-8?B?YjM3am1JdWs5ZVo1WEs1cUhQaTU5c3poMzJtVTJtOE0xQXJUVWVlaE04Rnhk?=
 =?utf-8?B?bFplSkt6SmVSZmFyN1JUTnJsNXhEVU5ZdkN2RTdhVDdrZEFxNzg0aDNyUVJS?=
 =?utf-8?B?emZwSWVwSElIbTlOc1haQmxUSDU2VmpGS2lMUWtVTytQSU9nT0FRSURkU2ZD?=
 =?utf-8?B?MmxFdlN6L2xvaG0rNUR5azh1V3ZJOG9hLzZnL3NDR2JnQmxFK3RtTm5FTGxW?=
 =?utf-8?B?elZIQVZWQ3AveUk4bGVnajJzUlRZaUZSdGdUdW1LeXNXMjJuc1FvNUI4ZlJD?=
 =?utf-8?B?cmlRVGhGU3FJVUV4UnJwZmcxbGM2U2FoSnlVVG81Qm5OVHQ5SEcxS2prVHgx?=
 =?utf-8?B?YlhzeVE5Wmw0aXhyVkdOV0hraGhTK09RYkFUd2xXeWRNRmJsc1VheEFnaDhY?=
 =?utf-8?B?N3phNHpUL2hLelBwQ2ZmSFBCY3NFbzRhN3o3akNKdDdHYUxTOHN0MngrNUMz?=
 =?utf-8?B?TDJsWDl0ZmJEUjQxc0JDNDZWRXVsc0tmaGswVnRMSW1yY2R5azhLbEVFUi83?=
 =?utf-8?B?UCs0YXlGN1NXUjBkZlE2YzNPTXo0NDQzZlJpOURMMENpQXROWjBHNk85TTZE?=
 =?utf-8?B?V3lOVlA4WTR5ZjBOZDNGL1RLWnNpVkRVWEdZdkw2SDNYVkN1NUZpb0ZwRUpX?=
 =?utf-8?B?Y0dvakU3Um0vRzhFZHRDY3VRbG1qU08zN1pyU2g1LytwUlFFV2VWWTF4aHMv?=
 =?utf-8?B?NDdlUGlqS1RXYm9DNTZnQ1ducDF6UFRVYzQ2V05KMUlrRW5pM2dKSXpOcWJ3?=
 =?utf-8?B?R25MZDhnL2NsKzdpR1ovQk9ydEpvanNNNUN3SzEwKy9ZVHluMTFwMWZnZGZT?=
 =?utf-8?B?dW8rTmt2QlcyUGJSeVJwTlM0WjZMZnk0ZEg1dStQVElxZTcyMkoxb29OTk02?=
 =?utf-8?B?TVMrb2sxZmdPT3JsQmsrclFKZ0xLNFY1ZUNnNDJFVUJLVnlmLzg4MEQ4SUVj?=
 =?utf-8?B?STNpYkFkb0NIM2w3LytoTDBaa0lBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <543A07ABED5C054E9EA73AAEC08F2BC6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4769.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4212a09b-c275-466c-f1c4-08da001f8184
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2022 09:47:34.2682
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B7zoiD5StSwBh73gk+Bltk9nuhIH8CQQGnV/dWAAvF8JPcQUFGZqkw+x4mcaGwctpEGnnGEDkZfgMeePV7YS8SBL5Gn6ufH9eboGLcRWJLA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5343
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDQuMDMuMjAyMiAyMDoyNiwgQ29kcmluIENpdWJvdGFyaXUgd3JvdGU6DQo+IEF1ZGlvIFBM
TCBjYW4gYmUgdXNlZCBhcyBwYXJlbnQgYnkgdGhlIEdDTEtzIG9mIFBETUNzLg0KPiANCj4gRml4
ZXM6IGNiNzgzYmJiY2Y1NCAoImNsazogYXQ5MTogc2FtYTdnNTogYWRkIGNsb2NrIHN1cHBvcnQg
Zm9yIHNhbWE3ZzUiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBDb2RyaW4gQ2l1Ym90YXJpdSA8Y29kcmlu
LmNpdWJvdGFyaXVAbWljcm9jaGlwLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IENsYXVkaXUgQmV6bmVh
IDxjbGF1ZGl1LmJlem5lYUBtaWNyb2NoaXAuY29tPg0KDQo+IC0tLQ0KPiAgZHJpdmVycy9jbGsv
YXQ5MS9zYW1hN2c1LmMgfCA4ICsrKystLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRp
b25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL2F0
OTEvc2FtYTdnNS5jIGIvZHJpdmVycy9jbGsvYXQ5MS9zYW1hN2c1LmMNCj4gaW5kZXggZTQzNDU4
NjczYWZiLi45YTIxM2JhOWU1OGIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvY2xrL2F0OTEvc2Ft
YTdnNS5jDQo+ICsrKyBiL2RyaXZlcnMvY2xrL2F0OTEvc2FtYTdnNS5jDQo+IEBAIC02OTksMTYg
KzY5OSwxNiBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHsNCj4gIAl7IC5uICA9ICJwZG1jMF9nY2xr
IiwNCj4gIAkgIC5pZCA9IDY4LA0KPiAgCSAgLnIgPSB7IC5tYXggPSA1MDAwMDAwMCAgfSwNCj4g
LQkgIC5wcCA9IHsgInN5c3BsbF9kaXZwbWNjayIsICJiYXVkcGxsX2RpdnBtY2NrIiwgfSwNCj4g
LQkgIC5wcF9tdXhfdGFibGUgPSB7IDUsIDgsIH0sDQo+ICsJICAucHAgPSB7ICJzeXNwbGxfZGl2
cG1jY2siLCAiYXVkaW9wbGxfZGl2cG1jY2siLCB9LA0KPiArCSAgLnBwX211eF90YWJsZSA9IHsg
NSwgOSwgfSwNCj4gIAkgIC5wcF9jb3VudCA9IDIsDQo+ICAJICAucHBfY2hnX2lkID0gSU5UX01J
TiwgfSwNCj4gIA0KPiAgCXsgLm4gID0gInBkbWMxX2djbGsiLA0KPiAgCSAgLmlkID0gNjksDQo+
ICAJICAuciA9IHsgLm1heCA9IDUwMDAwMDAwLCB9LA0KPiAtCSAgLnBwID0geyAic3lzcGxsX2Rp
dnBtY2NrIiwgImJhdWRwbGxfZGl2cG1jY2siLCB9LA0KPiAtCSAgLnBwX211eF90YWJsZSA9IHsg
NSwgOCwgfSwNCj4gKwkgIC5wcCA9IHsgInN5c3BsbF9kaXZwbWNjayIsICJhdWRpb3BsbF9kaXZw
bWNjayIsIH0sDQo+ICsJICAucHBfbXV4X3RhYmxlID0geyA1LCA5LCB9LA0KPiAgCSAgLnBwX2Nv
dW50ID0gMiwNCj4gIAkgIC5wcF9jaGdfaWQgPSBJTlRfTUlOLCB9LA0KPiAgDQoNCg==
