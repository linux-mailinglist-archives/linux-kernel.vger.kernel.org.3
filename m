Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F026D545068
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 17:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344308AbiFIPPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 11:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344255AbiFIPPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 11:15:43 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9CBA205F2;
        Thu,  9 Jun 2022 08:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1654787740; x=1686323740;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=OEl95UXO9lXM4gC/b9yko2/hlifgnSDUzB4JeH2R9B8=;
  b=rdiji6Lq5GJs9DNRL/doF21D3omq5b+qW+jLCiolbFK/tpQ1CLAhhbZv
   lTFD6J8HEOGiiyWsi1NBTVtm9OGWBlGf+w/cD+m0UGReuQzCIucZrLPCV
   vItqTjlmg9WjzZeeLNLcGbzEJz8TW+5gLjuu/vAiIO79NcK6DDJiypq8O
   Dw3odE2pecQ1pOQ8totSUrllWGyVswooSeUomBBtgeTOdpSt+OuNIbv5r
   EF0fMJ3x65jMeoJuaCkzkYYQs64IGl17gh+JbcpDLxJZLb0oVXuoGIMWT
   M2etGDD7WQSCXNCxBD5dWymN5nZKe0ZfH4fUYn+1TcMs3fYp50oV9b/8j
   w==;
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="167456599"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Jun 2022 08:15:39 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 9 Jun 2022 08:15:38 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Thu, 9 Jun 2022 08:15:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X0xUZ46Zzwe9YKgJeUvIpaJ1O41+lCzl3abh9ashLh+fbl8C3sUvRSmjNIxJmLpgYYEN8b+KaDrSySUrZpzNe76glaLpYypGdZJ99c9ro/iQL3XjPxt0Cgh95mWR9uLRjmOM24PdnkrCYQaiVMJiTBVFkcXWCTS3muuWGaaq49f/JwKr7024yg9hyjuiUkRXb/Z4uR3CW+hxIFG+xDDssTrs4r8sIn6gHn2UK5Ru7sdLWy9NvNiD89OEORZJ6CqQuKCa7ehAwCQAm6g8C7BxJwuWEFHLLtRA1ZgItkQ4kqdi0zGXcgQxHNq2RVJsUp4n6SIVHvz6ZZuOaVPaTG7TaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OEl95UXO9lXM4gC/b9yko2/hlifgnSDUzB4JeH2R9B8=;
 b=WgQKZttYya4bB3v1klUHSU9ftvQu53V7aY+vlF6/PJDvA8x437id8pAOShjzh4P+PR4Q5lrdaXU7J2JgiJQPr6pdyG6lrMpsmjbhvvK2Dgy74aQ/n+MGxhDZFivpvE4BU+3petnUNc/yQ8hf4xlmo0gl2Y6saCaUrovL1hgsepbKHdiinurRTEz0s2PL/bR6bvSHiCoKAtL8UGt2bBHWCg70KdrSIfvme+sh4G+JBUA+mm2/gmK0ak1GFoLbgIa5NPpRZtCxjnd1JUbLjsUvdy2sQ6ptRGge43x9gDGL1YZ8AsE0nZNeQQf6sbGvT9oBv76DxvT68WCXYxXXZ3Du6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OEl95UXO9lXM4gC/b9yko2/hlifgnSDUzB4JeH2R9B8=;
 b=t7D/bKgnor27Kb7DKHwj+yQ5yQVYONl+ZrJiW1HxhkBl/iTvx/4F9KDHOMCXa0jxe+Xkwprot/NNYnpu+WjaHOOAtadS3uWQMLISgjNjypRz5j2Of3DaUwspNvVVGYtXlaN1Hqb5q7TGAj8E9l+4k+ChVmWW2WwWLAoSS6UPRBM=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by CY4PR11MB1639.namprd11.prod.outlook.com (2603:10b6:910:f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.16; Thu, 9 Jun
 2022 15:15:34 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa%4]) with mapi id 15.20.5314.019; Thu, 9 Jun 2022
 15:15:34 +0000
From:   <Conor.Dooley@microchip.com>
To:     <broonie@kernel.org>, <yang.lee@linux.alibaba.com>
CC:     <Conor.Dooley@microchip.com>, <Lewis.Hanly@microchip.com>,
        <linux-riscv@lists.infradead.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next 1/2] spi: Remove unnecessary print function
 dev_err()
Thread-Topic: [PATCH -next 1/2] spi: Remove unnecessary print function
 dev_err()
Thread-Index: AQHYe8WVNiWPpIexUEGr0iJrG8jUkq1G50OAgABIuIA=
Date:   Thu, 9 Jun 2022 15:15:34 +0000
Message-ID: <c5575cbe-e0a4-fae6-65e1-6bb4b3b6f5d4@microchip.com>
References: <20220609055533.95866-1-yang.lee@linux.alibaba.com>
 <20220609055533.95866-2-yang.lee@linux.alibaba.com>
 <YqHRlaqy/UD0vDKU@sirena.org.uk>
In-Reply-To: <YqHRlaqy/UD0vDKU@sirena.org.uk>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bd0edc50-48fe-4724-c4ac-08da4a2ae66e
x-ms-traffictypediagnostic: CY4PR11MB1639:EE_
x-microsoft-antispam-prvs: <CY4PR11MB163979D5BF5B43B7C6172CFF98A79@CY4PR11MB1639.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t6YnU47nZDQuOgjygJrraHd/BUkbmlBAzBEpYGqevBfYLE28Uazhg1HjjKW76nEQNHij4OGO7nd2tVB1hXBHIsRyQC7Hp9AudHb33lySK8oEZ8dXGXi1hhrbU+I8z0WC489ux1SJnQcZFQcnphx+ZXPXI7yvaB4lirAVlcdWVtx0ch16h2IaRwvsE7URXosO6xodMBHQ6gku7e46v8SfQ60DOWBMGiUhnV/ProeOidmucE+5FpSHeKFz/XK32ZeZm77AMnJ7Bm0GD1F52URlz3fr5LsqG1ellON85Mj8skr7z7LpooWslIXX/5ImJ0rFICw5XIl6V+GXLdU8eIWVnERNN14jdboUNtVuB5Xd6/MUEQ0E2eB4M4hpPPLUSIRSM15l0Y1Z/2gosOct3Oo1yBsKSSGL8O5hfchq3rn9y/BdhOYNHh6z5fS6xMbKfGa2Bxdq3GBeWGXz7MaZVgHLkw3I0ox40iy65vSyvEAFGEhY/ZcFgip14HwI+xb9FNlZu3ptTwmaVUQsTVQBROwsLbW9oRIGS/R9EKd0am0wE/82UzV1Kt1KsphWn14bYcR1I9t4G5ejhez2Meoqxs3yLjEZX6HRsggILL8QvJIjc2LqKHhvWcxCW/ZrzqCHc0ahnlsYkaBHVzdKynMhhz+/Qmxk4OBYLRvg9e+3mjPOvvwUQNIKqavkR0VRLHgIWoOeAxr4sLAyYVcOZwEpfdJXncTPB3dT0CNP1isEKzVLEbVvxskwrAfWEum5rMqxFaZmCH6mktkYa3git6D8Hv+q/A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(110136005)(91956017)(54906003)(64756008)(76116006)(66556008)(66446008)(26005)(38100700002)(86362001)(122000001)(38070700005)(2906002)(8936002)(508600001)(31686004)(5660300002)(6486002)(316002)(4744005)(66476007)(186003)(71200400001)(36756003)(66946007)(4326008)(31696002)(53546011)(6506007)(2616005)(6512007)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z1lLVVd2WUlMZldPejkwZW82SlVVRWptUVByMW9zSldBRTRiUGd3NlVOVDNz?=
 =?utf-8?B?SEFOU2lnRFM3R3huYTRTSGtsSDlJWXJ3VlFWdktDaTFKdE45WVFZYmRnb0dr?=
 =?utf-8?B?SEpseDc0YUZYaDMvQ3dVeTJKVktIVmVWTTNGWC9NREJ6dnVESlpPSGRWUi9I?=
 =?utf-8?B?Z2xmT2hka2dZclFwZVR3eXlqNGZBT3JFNTBjSzNsMzJCS3cxbW1aUERZOVlW?=
 =?utf-8?B?eWlCMW9ieDhZZzBXYWJIVXF5Q0c5cTRFWlVxd1hCeWxRTXkrRlpHam5id2Uy?=
 =?utf-8?B?U1dYV2ZkVVFvT2NvMHVJMFBNV2dqRExUTmFUQTQyWVJJS00zVlRuTnI5QllO?=
 =?utf-8?B?N055OGxJaFF1UEpUSjBEb0JRd05oQlpzbUJLbCt1R3RERCt5VnlZM1N2Y1VP?=
 =?utf-8?B?KzB2QkhiTUhIMElCUEhFNmgvcmswU09tZmNYRExONVJmZGtBeGJ4QmtUVElw?=
 =?utf-8?B?Uk81YThiMmNkNzFBU202N3I3aXZXSXppdm9teWFvUmNDWTA0a2I1Z0dYSVlG?=
 =?utf-8?B?NlFlTzNveG82Ynp4U3dMdTNHLzZQTHhOU2UrQnJEQmFVaXRMNVdjZmcvMEd3?=
 =?utf-8?B?aHVCVGFRbnhlVmIzbGFoVGpBNVJYR1dmNnFqU1hQcnRieldaSUxkdUp2RURy?=
 =?utf-8?B?TjFkem91R0NHMGpoa0prbGt4RGM4elhGNmZIVXVJZG9RTGxkdERTVkpXQ2NC?=
 =?utf-8?B?Z2JZckd4YUhhQUZ1WWpjb0Z2K1VuMy9DQWRYV2prcUx1dndEaHZSenZCci81?=
 =?utf-8?B?dUNySm4xbDdISzJnMUk3eGxjTkdRM01URUlyRVRqWjZQcXVpMkM2Y042dXZr?=
 =?utf-8?B?MTgvaDhhcm9PMGJBaVgwY1VLUGxtWUFSaXNySVA2Y3c0Q2xPTHJyOHJZcFd1?=
 =?utf-8?B?eDhFQVRkUE5ERjF6dFBEUDNieVJQM3FlNGJvWDRqK29LWThSS2RoalhMRjU3?=
 =?utf-8?B?U0VXbDg3NDJWRjJFN1FCeHp4aEdINEhqUUFqZUlPVnRjYS9MTzZxaFM0S3JG?=
 =?utf-8?B?YnhicnVRMmZjZ09aaW83YWxzL0hnZ1JCK21NTjMxNG0yNVM5Wk5jYnA3aHo2?=
 =?utf-8?B?RUZJZUoxelZQdnJOYzhSK2w0UTVuMFNQNGtOYzhsaVJuU0N4OExITzdlUUFM?=
 =?utf-8?B?aXlzNG5sa3daTXJOSGZGRzU4cUZVd3lpQXl1SEt1RlU4ZjExVGF5UWt6R0lD?=
 =?utf-8?B?Mk5yQThRK3JzNFBqZXljR1VPMnBBajI4QlZJamIxL3p4c1YrVXhWQmRvTjNS?=
 =?utf-8?B?VTY4SW1zcTI5elMvU3ptWCtuUVFGbzdKWDMxbnl5YTJ4YzVtVlBlSk9vTzdZ?=
 =?utf-8?B?ZXo1YWR0R01WUVpiQUc2WU1OamJyVlgzUUVaTFFidVBDcDAxWmd5L0luVjhr?=
 =?utf-8?B?aThIQ25BTGZ1YkhwMk5rRGRBcXdMcFBGeFFjeEtwUC9MLzJDUjZmUnVnbmdv?=
 =?utf-8?B?Yy8zaW1hYUtRLzUzUndjV2xVMDhIRmQ3aDhZb1Nwd0lVWVZXeUpQTU0rMlhS?=
 =?utf-8?B?VzZzUlVJY3BKaGFuemp6Um1iMUY3WmFINDIvcVpVU2xUR05LYzB5dlBGZWgx?=
 =?utf-8?B?Sk9RRHdTbXVjaGc3VnhnemwrZ0EwYUQzbTUybC9XWlBtN3RxMU9GMjNzOVRs?=
 =?utf-8?B?L1FSWElFN1NoVXdCcXhOQm9kQWdHTnpIM2RsaG9xSlM3WC9OTGFSWGVqeE9a?=
 =?utf-8?B?WUVQdUx1bmh4Z1JhWFZCZXNLVllNWHJnTnhQVXJvLzFBT2R5RXI4Q2g1MjZS?=
 =?utf-8?B?b2JVTEFDckJFNmcrcCtDQVA5eHkwb1R6MlZsRktobW1XNEhyVmxkaUttNWRX?=
 =?utf-8?B?eSsvSlhEcUtBS1JvZ3FzWEJob0d4bGdWNUN0MkJvWlJrNUtKaS8vTU93YUVD?=
 =?utf-8?B?a3g1TFVid255VXlRUVJLVXpYRmp3MU84QnhDK29SSVBxaExMUkZsNHdXYk5V?=
 =?utf-8?B?OXg1YkhpTE44am5lRkFSb1VQakpBWk5IUVlsLzcxcUdRL2paZVNqTlVqZEdW?=
 =?utf-8?B?YU1Ga0kvTi9GOTVzNGRHOFR2VTFJeHUyS1YzYlUxL2p5a1F4QlpQam80Ynow?=
 =?utf-8?B?UDlHbWFNQy9mOVZWMHZYbitHaGJHTEk3WG1GdnhBYUNuSUtFYTBrbHh2TEUw?=
 =?utf-8?B?ZnVVQ1dTZEFnKzQ1ZVM4VEVBODFmTWlVcXVPWHRpc01sNkZ4NEVneTRUWUpj?=
 =?utf-8?B?ZC9rTEcvK2xLWXlxaGpMYklBMitaY0g4dnpJajJpQkRmUit5TEszUU1QZXhw?=
 =?utf-8?B?cXVpWkdRajVTeWhGcmJYVUxjeVozcWpGNEdLNkRhWkpUeWRSNHI0aUZ0L0NF?=
 =?utf-8?B?bjM3Tm1Ed1U0ZzlqNytxWTlZWC8zazhNYXRnY1pCODhuRGtvWnNnc1V3Ky8v?=
 =?utf-8?Q?ZrgkqgslDpELRGK8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0DF98BAA4207FF4E809FDC2C7D826A8F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd0edc50-48fe-4724-c4ac-08da4a2ae66e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2022 15:15:34.1134
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yFbLfWYRa6QJuiLjCzklbFARuiBNvqnEtd/82ycTQB+/oJqrXykzMdt43vjvJ0pVcdkPuKIlAIFZuAFSis3KwvyFBrvgPUFZGu5cW4/WKe4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1639
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDkvMDYvMjAyMiAxMTo1NSwgTWFyayBCcm93biB3cm90ZToNCj4gT24gVGh1LCBKdW4gMDks
IDIwMjIgYXQgMDE6NTU6MzNQTSArMDgwMCwgWWFuZyBMaSB3cm90ZToNCj4+IFRoZSBmdW5jdGlv
biBwbGF0Zm9ybV9nZXRfaXJxKCkgbmV2ZXIgcmV0dXJucyAwLCBhbmQgdGhlIHByaW50IGZ1bmN0
aW9uDQo+PiBkZXZfZXJyKCkgaXMgcmVkdW5kYW50IGJlY2F1c2UgcGxhdGZvcm1fZ2V0X2lycSgp
IGFscmVhZHkgcHJpbnRzIGFuIGVycm9yLg0KPiANCj4gQXJlIHlvdSBzdXJlIGl0IG5ldmVyIHJl
dHVybnMgMD8gIE5vdGUgdGhhdCAwIGlzIGEgdmFsaWQgSVJRIG51bWJlciBvbg0KPiBzb21lIGFy
Y2hpdGVjdHVyZXMuDQoNCklmIGFueXRoaW5nLCBJIHRoaW5rIEkgbmVlZCB0byBnbyBpbiB0aGUg
b3RoZXIgZGlyZWN0aW9uIGFuZCBtYWtlIHN1cmUNCnRoYXQgaW4gbXkgaTJjIGFuZCBwd20gZHJp
dmVycyBJIGFsc28gY2hlY2sgZm9yIHplcm8gLSBpdCdzIGFuIEZQR0ENCmFmdGVyIGFsbC4NCg0K
VGhhbmtzLA0KQ29ub3IuDQo=
