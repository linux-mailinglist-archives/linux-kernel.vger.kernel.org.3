Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D665879B6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 11:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235611AbiHBJNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 05:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232773AbiHBJMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 05:12:47 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4861717E26;
        Tue,  2 Aug 2022 02:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1659431564; x=1690967564;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=i4OgvXsJ1xOlQHJeqtHpXpzo5EgNUEtOcXXls65wTJI=;
  b=BKPIOQ25JBZt6MgUuGuw/MwK20jLhZ57zqiEbZaP40aQuqjTUF057nrd
   jV506pb0lTszHuBfk8//nTtibHIndGZlFx7h2+yswS+pq2riHFxr+AKIX
   5pkYF7ZGnALnJRXlLircykSNmXZHYm3WLFDGrEFDlZpaQItcqWRUJfU3g
   GPAm19CRolP3TW2HTTGtM5C1ZTTeNpJuXOsTGjDUQ7KwPuY9BsPONJSL9
   6MzA1INA0tWOK3V2JZMmdnRqBBIwGMWWaJ8Sg4fZIyXGqZIuYzZYfb9H9
   hGRX4wWRsfePNJYeyHIS72crZY5QjPUyRtIVO/KDV9q8m/80faVxw1YEv
   w==;
X-IronPort-AV: E=Sophos;i="5.93,210,1654585200"; 
   d="scan'208";a="174547075"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Aug 2022 02:12:43 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 2 Aug 2022 02:12:43 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Tue, 2 Aug 2022 02:12:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oaXHa+Dad+PmbtkdXRpts8atSVo8FdoXP9AYOv+MuY6lgDJoecVyskZsA3176cG/c8Y4quu464iizpfEzyQvjySU8YUUCf/AkzuKYR/HLuiHxupUD/yQO+DSfbN6o3DPtZDl5BX6OWUTY0eKS915ll0OpGfjDLomMKb/HnNT9G2a02vsskHFLyHD/E/zTbo+4fqumJDEYPXW+m/4tuQWSuEK5WtHmQvcrLDuCI0sXIT4gIIyX3JMFVQV/AuLs6xxssRbpQi0N9VaLlkBKUW68Dy0I8yD1XUZFai1wjEb7MyXUwV8QV+md4uv+QnzXMzJQlmwrg9/xc1jFeZmXHVblA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i4OgvXsJ1xOlQHJeqtHpXpzo5EgNUEtOcXXls65wTJI=;
 b=UJ9Glpo/rX2atrzwMPnvOQWObMfI5+EYvUEsbl45OAfTz2x+POyo9pKekrGBUlz7iCWOct+NLHQTsGsu5kk6iqojJRb+0a6XB6CzRJID4Ia/LGM+Uhe33yi7Qc4SWxRYFfqoI5S9NIpIvzrXjiMdgxNwlunZnPv7H41Bq3oETAvp/znQDGTVT5t/kKsK5lboLBgZGXtb2baKkbKLrNXvCHV4hdhdAisLxtBlXX5CDlsw5Zdn5a1zluJFWMBFnhUuBUOxrmo9v+OSDverInzmeMUgFcLDie2Rfcw0LF+vg47rJ1Vtkb8832n5wos3wfnzrxEtbSexwuhhzqcXiQgPrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i4OgvXsJ1xOlQHJeqtHpXpzo5EgNUEtOcXXls65wTJI=;
 b=kRXycRT1Qw8/+O+ZWHHZcxy6OE0/L+d2zRdQO31ihKqew9t8ltRiked+j7RUM6BHYvFQb+sCPJebv2FZ6AR6QIDBA1INS1zNyxRKhwfYJsOL1TGoQtxFXPFNcsQbAwAOh2rwXgLdX51Xk214Lw9uZxB/kvp+BJV/p9gtumjh+J8=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by BL0PR11MB3060.namprd11.prod.outlook.com (2603:10b6:208:72::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.12; Tue, 2 Aug
 2022 09:12:41 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%9]) with mapi id 15.20.5482.016; Tue, 2 Aug 2022
 09:12:41 +0000
From:   <Conor.Dooley@microchip.com>
To:     <Nagasuresh.Relli@microchip.com>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <Conor.Dooley@microchip.com>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] spi: dt-binding: add Microchip CoreQSPI compatible
Thread-Topic: [PATCH v2 1/3] spi: dt-binding: add Microchip CoreQSPI
 compatible
Thread-Index: AQHYpj5equo/E/plck63aWbWH6yUSa2bU7MA
Date:   Tue, 2 Aug 2022 09:12:41 +0000
Message-ID: <c855b6db-361a-23b7-baa8-a8a447baa284@microchip.com>
References: <20220802070518.855951-1-nagasuresh.relli@microchip.com>
 <20220802070518.855951-2-nagasuresh.relli@microchip.com>
In-Reply-To: <20220802070518.855951-2-nagasuresh.relli@microchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4d6d5fa8-1404-4916-8704-08da74672721
x-ms-traffictypediagnostic: BL0PR11MB3060:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yC7/rJiV3hep5DPLzfdIqwxuUliC1rwOqNDoKtCGHoi9IXERXXd25q8n21y040MKKjibIdDdAX066qr5xTmVNA9pgaLfcGu2fEsyYynEPM9aCQMkMMucvR5dvD6D7H3P9yEhUHjn+l243r5hBDbx8vuhzxpZI8hHmpNKzc3D54yx5XCWJh7Hjp815MpDpZAStC9SS+N/FKsZqLSsN/uh3C5Twza5T+lpa4KfxU849ybQm09KXs7N9GKGCdXKlcQRfJ/y4Q8H7VwgzHroLIiMuxuNqqZZunMiHZyMR/5n4BxpyflVn2Gy7daC0GFAXW3VdKve8cTODVvOJ2uLPsS+fe8JBRxkRqD+cm4dozkQJhEZwKfrzAQ1bt0fgNZcPfTP9ipmAJbUAbC4V1IlQYApxP4avB6gHLj4rWtKtqQl38AA2AlQYDVDGvtRtDEt9k7l4OeuFEi9ka/1y0/GrDnsfM0ElRo/yin1Lvk5K5I+n8dpXQjK5nPeJ0dUQDShYYcKwITMc0jgdcPeTAF8Jjwi4llrp16msIHx2V9uo3YHi96lMwNHLQoZX7h8GzJrtP3YxQ4Ktr3Pjd239dYLBvp1KfDRsIKrjnKLItO5lydqiHkcTskJ574D6qgBNGOrzDAtTOKAZslBONVigoSfhZWe54CsNnicO0mS3uzS/L9mMVSsh83yd+MQ7mjlMjhBD/iuJnwmNW+i2T33UuzzRLsazOW6XGyzM1ER4XgocOmEJFxaEQ6qPzJk60/v78B0CB49vExIEr/apbf2cFSe4mKIsbPlxnQWL7rAjiOAn+84SNYUxppLQI8R4RwXRkExVELkSJMnp618gl3YCXLsc+37DvTkYK6VrxUvK+n85HFA10licF31qmOyI6Vitccd6HPSW1YsN3rWl3AeOd0Nf2YKxA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(136003)(366004)(39860400002)(396003)(86362001)(83380400001)(31696002)(26005)(53546011)(31686004)(6506007)(41300700001)(186003)(2906002)(122000001)(38100700002)(6512007)(38070700005)(66946007)(316002)(76116006)(91956017)(110136005)(6486002)(966005)(71200400001)(64756008)(4326008)(8676002)(66476007)(66446008)(54906003)(66556008)(2616005)(8936002)(36756003)(478600001)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Yk5hNkk4VEVxMElDOGZLMDR0Rk51R0NXdTV6NjBTemkxMFR0VkZiOW1YWWls?=
 =?utf-8?B?SDhkaytkSlUvRDhGY244OGNQVUZRYXZJWk9PV3J3clhEekxyRTZrNnU0eGpi?=
 =?utf-8?B?WnlQN056aEJhN0FmZDZkUmw3cEhwSUcwQ1A5U3YrdUFNbUZMQ2MwYXdUZm1S?=
 =?utf-8?B?Y2IxbDlwNnFpTzlnTG91ZVZGbnAyazVvOFVIZ1ppR3R2VklJMyt4UlUveVNY?=
 =?utf-8?B?blZEcVVqdWZrNVdGbUxVQlJvV0twY3RqZXUweFV6cGpYMWJ1T1MrM0hmRGJ1?=
 =?utf-8?B?V1RKRUNZNUI1aEN5THkyTDF0dWtqV2FyVjRRSHZlVldOQ1hFWTBKUFZiZk9y?=
 =?utf-8?B?bHdycWV3MVJJUWlMbG11WW5UNEU3dnFVNG5aK05GY2VpdFhZa28wdWhjQzRY?=
 =?utf-8?B?eEFHbkJPRmRLb1lnOUhkZUpMMkQxU2lxNGExc05MSE5mM2ZseGdndUFmZUpt?=
 =?utf-8?B?T3hWSHhhWEhPYXIyc2xlNkxNSXhlVjNRUFBDMzdZSlF6ZjZLYWs2LzFvT3Va?=
 =?utf-8?B?cHNEaDVNa0hKcTh4bExET3ppaDlMWjIzWXI5K3VuY1VsOGdsSi9tWmtQb0FG?=
 =?utf-8?B?SS9SZlFvL0xyNHBUWjlUNlBKRHVIN0Foc0ZHSjB0citCdFVaY2dxczNuc1E5?=
 =?utf-8?B?VUxyNDFWbzBhSCtJMncrTFpZazhpNi9qajBjc2d1d1hZd1Y5N2VmN1REZTRE?=
 =?utf-8?B?SFFnOXZDNkpFdU9DTzk2aWp0NTV6dWVTRXVKdU55Zjc3WjNHUFI2Q2ZQanZk?=
 =?utf-8?B?QnN5WStsVHRpcjhrSmRHdFNLZW9yUzR3c2RwS1J3UThQYXA3Wjc3MlBFaExZ?=
 =?utf-8?B?VUNWOFloano0WHlaTXMrdml1RklONStuTzAyZnFnbm42UzhRYURmUkc3UnNX?=
 =?utf-8?B?S0t3WG5EaE5DWjBhQzVTYzlJd1JPRS9zQmdJZ2pCekhxZEpUM2JjeGMxaFpk?=
 =?utf-8?B?NVEwemgwSXZVWWhtK0pCZ3FwbDVsNTJXNFBkMVdocUE4VkhNOEVmK2d6U3dv?=
 =?utf-8?B?R1RId3JOdnU2UEo0ZlpVanBOVlg1cFZXelp0WG5ydzFRSDBIcFpPSlhiZ2I3?=
 =?utf-8?B?YmhIV0pRb29GSnBuWWlFcVdFMEVwQUt5NHp2QXJqUDlpZWo3UUI4NzhTaXVk?=
 =?utf-8?B?aW91Nnd6QzROL3ZHSXMzZ0VZYjlKZmxYelY4SEgvamV2S1FZRzdZR0c0dE0w?=
 =?utf-8?B?bXhJdlMraUs5clJ0NkVRaEthdElyLzhwRnB4M21IN2NFWW9Nd0NCZ0lETGs4?=
 =?utf-8?B?bWE4RngxYWdGNWIxUytZa2dtaU9qN3Yrd0lJbC9TNjVNQjZ6cWJlQ3ZOK09n?=
 =?utf-8?B?ZS9OUEtHeHFtVXIvKzB6QzJnOGdURzI0ZjJzdWE4MWFlRW5TV1RGZit0ZTNC?=
 =?utf-8?B?TDdVOS9ZZU9WS3BJNTYyT2dEUlBNc1dobmtQekltOTJjbTZYTTJpdzUvcGdw?=
 =?utf-8?B?MFlWc2I0MUhKS3ZOOUxic29FV3RiZ3ZqUUFzUFc1b1E5VVBzL1RvckZYaVhn?=
 =?utf-8?B?a1BRV2R3enV1TG8yQzBBWWdlNjRydXRUV1cxVTZFY1gwb1JYVEx5dk83OU5C?=
 =?utf-8?B?a2tqTVUrQys1ZnBLZGZpYXZFZkhtcCtxQ1BIUCtuWjIrSEhFNndkNGFyNFBK?=
 =?utf-8?B?SkRRMEhNcnJkTXcrRURXMDZBMFVpUkh0TTRqaE5MMjlNMlVUK0orc2FaRU1y?=
 =?utf-8?B?MHI4ZGxaU1RkalZXUnJ6YXY5Y3oxZUZnRTNNMlZJck0rWFpXaFloRUxySmN6?=
 =?utf-8?B?WFNnTFRtT0Z5RDNxelVJSitGRWhHaG9WQjZUeCtXd1FjcHJoSEZmSWdrRTZv?=
 =?utf-8?B?UU1RSnlQQ045ODZSbFBpWHI2T09td2ZHWFMvcW1VNE9UMnZKR1MzeFVlYWNW?=
 =?utf-8?B?b29tT2h2Z3RmRVo5UXN3QkE5M0VWYnR3cDA5SDNhMGhTUjlHNGcrR1ZEbHpE?=
 =?utf-8?B?WmhkTjh5Qm9Tc2FBU2xLNndzWDZXWjAwUnhkazh2cnJYdld4bWRkQkhSL1lB?=
 =?utf-8?B?ZHpQeTQ2Nlp3RE5mQjJhVHlGRjhjUXlBeTUvMU1VNW9CaHNqQWR4NG4vZGdM?=
 =?utf-8?B?eUJwaUt3TndjS0psZ1NpNEdRNHF1OW81Sm96bUM3UmZjcDZmYTF2dGRHdFhH?=
 =?utf-8?Q?mHUUkzFtzyI//MdAvFL9hsLxE?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <507883769E6DA449B83A44828E358DAB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d6d5fa8-1404-4916-8704-08da74672721
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2022 09:12:41.2684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: byGK2Opv8fQPERHZsbOrbviT2DZcaLE783xoAcF2LJvAYwtNUJ+9if+2HgpkKOeQyot1nuAElpV8T48QMVUyXV2/rZBesN0ItAzwovbStxk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB3060
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDIvMDgvMjAyMiAwODowNSwgTmFnYSBTdXJlc2hrdW1hciBSZWxsaSB3cm90ZToNCj4gQWRk
IGNvbXBhdGlibGUgc3RyaW5nIGZvciBNaWNyb2NoaXAgQ29yZVFTUEkgY29udHJvbGxlci4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IE5hZ2EgU3VyZXNoa3VtYXIgUmVsbGkgPG5hZ2FzdXJlc2gucmVs
bGlAbWljcm9jaGlwLmNvbT4NCj4gLS0tDQo+ICAgLi4uL2RldmljZXRyZWUvYmluZGluZ3Mvc3Bp
L21pY3JvY2hpcCxtcGZzLXNwaS55YW1sICB8IDEyICsrKysrKysrKy0tLQ0KPiAgIDEgZmlsZSBj
aGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9taWNyb2NoaXAsbXBmcy1z
cGkueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkvbWljcm9jaGlw
LG1wZnMtc3BpLnlhbWwNCj4gaW5kZXggNzMyNmMwYTI4ZDE2Li44ZDI1MmViOGM0NjAgMTAwNjQ0
DQo+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkvbWljcm9jaGlw
LG1wZnMtc3BpLnlhbWwNCj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3NwaS9taWNyb2NoaXAsbXBmcy1zcGkueWFtbA0KPiBAQCAtMTQsOSArMTQsMTUgQEAgYWxsT2Y6
DQo+ICAgDQo+ICAgcHJvcGVydGllczoNCj4gICAgIGNvbXBhdGlibGU6DQo+IC0gICAgZW51bToN
Cj4gLSAgICAgIC0gbWljcm9jaGlwLG1wZnMtc3BpDQo+IC0gICAgICAtIG1pY3JvY2hpcCxtcGZz
LXFzcGkNCj4gKyAgICBvbmVPZjoNCj4gKyAgICAgIC0gZGVzY3JpcHRpb246IE1pY3JvY2hpcCdz
IFBvbGFyZmlyZSBTb0MgUVNQSSBjb250cm9sbGVyLg0KDQpBcyBwZXIgS3J6ayBvbiB2MSwgdGhl
IGRlc2NyaXB0aW9ucyBzaG91bGQgYmUgZHJvcHBlZC4NCmh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2xpbnV4LXNwaS82ZDM2YjE5Mi05ZTYzLWVjMTMtNTU4My0yMmI4MWM5OWMxOGJAbGluYXJvLm9y
Zy8NCg0KPiArICAgICAgICBpdGVtczoNCj4gKyAgICAgICAgICAtIGNvbnN0OiBtaWNyb2NoaXAs
bXBmcy1xc3BpDQo+ICsgICAgICAgICAgLSBjb25zdDogbWljcm9jaGlwLGNvcmVxc3BpLXJ0bC12
Mg0KPiArICAgICAgLSBkZXNjcmlwdGlvbjogTWljcm9jaGlwJ3MgZmFicmljIGJhc2VkIFFTUEkg
SVAgY29yZQ0KPiArICAgICAgICBjb25zdDogbWljcm9jaGlwLGNvcmVxc3BpLXJ0bC12Mg0KPiAr
ICAgICAgLSBkZXNjcmlwdGlvbjogTWljcm9jaGlwJ3MgUG9sYXJmaXJlIFNvQyBTUEkgY29udHJv
bGxlci4NCj4gKyAgICAgICAgY29uc3Q6IG1pY3JvY2hpcCxtcGZzLXNwaQ0KPiAgIA0KPiAgICAg
cmVnOg0KPiAgICAgICBtYXhJdGVtczogMQ0K
