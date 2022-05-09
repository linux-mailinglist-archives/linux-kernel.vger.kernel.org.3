Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8E351F481
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 08:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234739AbiEIGbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 02:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234963AbiEIG3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 02:29:49 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79FE72670;
        Sun,  8 May 2022 23:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1652077555; x=1683613555;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=QgKLkUsrjs7AMyMctjDu+Rf19UWCrzkG/q+mVQu9Zho=;
  b=jzYGPsU+6tWjCVcEVzhWuFwdio2Ftyj1Avtq6o89rh0VKyA3zZU79+B3
   SVPv1Xb8taE0A+ykdpaafNLX4Y5ZctgF7bdP1h3598RXSoIR4PLrYNKHz
   rQQypD4ERm/q/1+4MX3RCM5gqWTO0PvG8hzX0lbY92x1wM3O/nPTzSO6n
   qCWKv/M43uWEcL8IgMlZHEe1TFbDLxqpjJ7k1hFDsbDLJ9apjvkSSialb
   cr+1sTKL1Ybf/KNn2px2ZORp22T/QdYTE2ebyK4aa/OtWBI7vYF04oEY1
   UtSuUHJZgLZ8qww/+3X+0ItQifsgeFs8hnhN1tWFIo0lCJbF8CG4QrZ/f
   A==;
X-IronPort-AV: E=Sophos;i="5.91,210,1647327600"; 
   d="scan'208";a="163194828"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 May 2022 23:25:41 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Sun, 8 May 2022 23:25:42 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Sun, 8 May 2022 23:25:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d42pyzq0qLQXI3V/ZqBrQL44fJFzBKseZ3Q4lUkEj81E9kNBgCdry6oWG/tgAGia1n8W96qTN5/mmxeI+l5ctEt4ezMSS93unxd9ZYAVoBqvS5BbkojD9UJ+Ur5vOHO4qwGm1X9Uu8kE1XU39pqeDJQRaI3yuVbk4K/wgGP5ma3LmQvxvAlxvZqaZguPfl15UnXfY0xwHesLYamlJsAh+jQwGlX9gn/2WhgfIlXHP4PonKa0Cc0nzbsVXHWqPgAxYynd3Tz6hq41itj95bwRSfpIoSjVj+7/mTaTrNwbLcaFEoaGZMdaNJSsknDRQuQLrzdTStRkLIjk3L4cK0BW6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QgKLkUsrjs7AMyMctjDu+Rf19UWCrzkG/q+mVQu9Zho=;
 b=DwhMx+N4BQ3BLn88XKzfb0859DmM3+CsTcloq46QRank4IaDrqfeB0YNwsZoOqhrssQz4I/F3vCiav7cUdBEQQZMToI/H8qnfuJ89707v58Rw0Lu0PAzqRZQNf6nmEMQeZYY9tUlKassBECSGjb2PRXdJarWMlqqfJvyQBkZLvXwNOxZCjlFoJHxQOFFGukGJyxAoAPwK+fCH4gBf0exO2+nQn8DoLzpEcJj/84zcBXu/69cJ821Ur/kxdJRtqruIqoytcAiVk3iTwdT1CJsBaVYId+emFkhGj9bqlSay34H9jo/fJMqExkcipkEhz1jI2K2j8JFfYkgHh84t3r60g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QgKLkUsrjs7AMyMctjDu+Rf19UWCrzkG/q+mVQu9Zho=;
 b=YDhjFqmWIMiBj7+JqJe9L1dUya+dOFZ5iky1KT2Yg/yWLI46oFGyo11tMHWvHM4si8LVaCZ8WtliKRaOZY/vRY1mpzsh8CLcJqCa21vRhuDyqQVyXU0SmUAfaHehmWR21RjSBO6qk90jhTmdehl09hgLWs3tcnS5jBKsAcfZPlY=
Received: from CO1PR11MB4769.namprd11.prod.outlook.com (2603:10b6:303:95::10)
 by DM6PR11MB4121.namprd11.prod.outlook.com (2603:10b6:5:199::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Mon, 9 May
 2022 06:25:40 +0000
Received: from CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::e906:3e8d:4741:c0f0]) by CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::e906:3e8d:4741:c0f0%6]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 06:25:40 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <michael@walle.cc>, <Kavyasree.Kotagiri@microchip.com>,
        <Nicolas.Ferre@microchip.com>
CC:     <arnd@arndb.de>, <olof@lixom.net>, <soc@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski@canonical.com>,
        <alexandre.belloni@bootlin.com>, <Tudor.Ambarus@microchip.com>,
        <Horatiu.Vultur@microchip.com>
Subject: Re: [PATCH v4 08/13] ARM: dts: lan966x: add hwmon node
Thread-Topic: [PATCH v4 08/13] ARM: dts: lan966x: add hwmon node
Thread-Index: AQHYY22agPkoEi2hkUuV4I7Y/RWx1w==
Date:   Mon, 9 May 2022 06:25:40 +0000
Message-ID: <353cfac2-64e1-e0e5-2a7a-22eca1b23071@microchip.com>
References: <20220502224127.2604333-1-michael@walle.cc>
 <20220502224127.2604333-9-michael@walle.cc>
In-Reply-To: <20220502224127.2604333-9-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f8bc2480-2ed4-4daf-d161-08da3184bd01
x-ms-traffictypediagnostic: DM6PR11MB4121:EE_
x-microsoft-antispam-prvs: <DM6PR11MB41216C924AFF5133F13FC2E487C69@DM6PR11MB4121.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qHkZS4xtyBjNvFvE25d15h3qyWYCINEFRAzaWbrwJt+36z5E4pYSp814YEpP24VPH738qYxyJtRrZVEQYsXcEOFtHjUfq+JqnCsVycAIeRGvtbZnACSDqMQB47ChU8/G+M6u6rFXQEyeatYGrubS8iLQaIw8NR7ZLCFGQOnMEPRYkzx8OCDCEay0rjVhBHSTCWrZjNguzKUXIINe7jcqoMVxpQA+NJ/nkkhT+wGWkl+kp9vThDhiXwFvuIhpWQNO4UPSajOPwn882Nc+iddD4wlhkgD7uXjcm0wO8oiOkufvRj127t+YKsIun+mC7IuyxNOAYYM0tyomJIXRxAfoGtxT4fRjSKxbNrvGXIBaN0fSsfoaUmJrlIbEAlJ7uXJLY0KiPmakmAsd8EkM7vAy2rYXZE10UyZW/Tszpc2gbqpR3szkORgu3V8yj3HxEyOCAMNnXoQcpEzNKiKTOtFa9ZLw4BDo91JlouJnzDCDqfthmueIlh5j2F1GxGIFfYHdUFepsZFA6T7W9JqoV8rtIEXZyCGFjQZuKn7LxI2rLYhUnZjck9A9Ocu/W8lJXGLRKMLBuDwncC3IieaTjK0H7z4IGP8p7mm8FyI/hWHMqB3gbeU69dyIiSt8ruj9SSt6NY8I4vbU3o2WxqIyzVYhPTsudNX1X2nSmnuuIhAe4UwKZudq1sTKP9L1KAbBd2/M3pRa/Pyvp42eZIGGVYx/O99YOusqRUOhNyzu/UdDeXZJVqORj0sXT3Kr08058OZK5m9dSDP4K8ZYRzEAaavSMw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4769.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(4744005)(7416002)(36756003)(2616005)(107886003)(5660300002)(110136005)(4326008)(6506007)(186003)(53546011)(26005)(31686004)(66446008)(66476007)(6636002)(66946007)(76116006)(8676002)(54906003)(64756008)(2906002)(66556008)(91956017)(38070700005)(71200400001)(122000001)(8936002)(83380400001)(6486002)(38100700002)(31696002)(86362001)(316002)(508600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RVdvWFlUS0o1bHRPbnFHQmtRUlAraEJpZFNhdlZUSjNmWm1CWXBSOVFKQ1Ru?=
 =?utf-8?B?SEpFVHNNMzhqZkhlNmpvbFJHWnZwaFg4UDBncmNUZUlPZUd5UTVvZmtCSWNy?=
 =?utf-8?B?OU9tQkFqd0h5bVAxVXNSMHBxNW5vd3JkSlZCZ1cza1Qrem1FQ3ZxWEoxQVpr?=
 =?utf-8?B?YzMyNXgvb3ZUZHBDZDh5UHJaUXhoeGhsTC9TNFJUVXJZMTZtK1NNZWczQ0I4?=
 =?utf-8?B?T1lyeEk1K3BwUGgxU3VSZUJnakUrT3F6K3U3LzYydG8yc0pmRmIySE9EYkFj?=
 =?utf-8?B?VkdYMkRia0tZRWZFOUxMRTE1Wk9lVXdIVUVhRHBXMnF0RnNQcW5XVk1GMzlZ?=
 =?utf-8?B?UktyUmJMZnFPZXVaQzc5SEpJSzRZcUJTaG53YVNsVjUrNVdFNFkyc2hsKzcy?=
 =?utf-8?B?RmRnSzNuYThwNFV1L2pOY0FmdHBpSks5UHVIYjJjdmlKZXh6dlhHTUJ3cVJy?=
 =?utf-8?B?VndLNkxyRTVZbFdobjFzSEtOKzZQdWIxUXNJZFArTjdWdjVRQ1JXMzZRVVcz?=
 =?utf-8?B?LzYyaHhXOTBpQ1krczl0UlFxQjNYZlBubmQ5b1NGczNRSi9mN01MaXRpSUVW?=
 =?utf-8?B?M1lNUVZ4d0NpbUdjNWRUaXhCNGhOaUgrK0lkMG9oZnNNc0Z1M0NYOUN3WVBr?=
 =?utf-8?B?czNramM2UEI2b1ZVNGxRV0k4L3pOWjdOWFkza01EYjFqZXQyWHl5c1pHcWZl?=
 =?utf-8?B?dlhCRHdoSzZQc1lJNnN2Q0xZd2JETTQvODN3QUZZRFJvbHlrZU96S2tSVjdh?=
 =?utf-8?B?RVk4MEl2dWdFaVNWcTVIaytEZTZTaWVsNDZqMExuU0hqY0I3c2VveWNxNE9F?=
 =?utf-8?B?WncxQ1pTNTJ0VlVFdnlKbnFycFZmTHRtRmVUWDUwWVFsS2JuTFFIQTBtNnNw?=
 =?utf-8?B?ank2a29JYng0cDZDUXNqWURJa0tldDlPT3FhaHkreG1sd2JPaExyci83ZWxT?=
 =?utf-8?B?elNMY0Q2cjhxcjJqUlNNY0hyWmxWR1lmR1pvWDlIaVA5ZmUzMlZ2dERZYWth?=
 =?utf-8?B?WVJBajlWNzdMWk1uYlU4L1ByczFnWDQ5cDNKcUxFUVhMNCt0V0lMSHVOTk9h?=
 =?utf-8?B?cTlGU1AxSkNpWGxyd2RZQW5SN3Y0WVM5Q01Pb05HT2JZUTFYR1FTRUFpN0Zt?=
 =?utf-8?B?Y3FKNWM0VGhqb05Xc1FnZnNkbEFoaXRHRnRDVHYyZjFTN1VZaTByTy9BMzh2?=
 =?utf-8?B?blRTWEpvdzlMUjhZOFN2RXlwRW9ZUXVIUjVTSUs5NFIzbTJKdU1lKzVGdkR3?=
 =?utf-8?B?Y1oxKzFqTXNkbi85WmhOODBqcUZabFJqSEtMOHh2NkRSaUExbTNZNTRNMW1Y?=
 =?utf-8?B?S0dHZGdHSWxRb3pKWlA5NnFhMFpsM0VIVVRaUjNrYmd4Q1dxODVKa2tDeXpq?=
 =?utf-8?B?Zy8vK3V4YTY2WEdnRjFpYTdiSHdoQXVhQUpGb0pNUXF4SEhsTVBxaU5DQ1dn?=
 =?utf-8?B?Rko2Unllclh2Y1Y2T2s4ZFllQjhsZVBnVjQwaTFsV2NnTzJjNzZrQzF1VWdO?=
 =?utf-8?B?aWhoQmovckd5M1pMTjF3cjJSam05T1pzREVGU0VldkRlWlZKaGwrNklXaURj?=
 =?utf-8?B?VEZHY2E1UFowSUFwdXlOR2hHUHd1V1ZTaGxrNmpia0ZDZEhnT3BmT2RpdnRt?=
 =?utf-8?B?YTVqcURpTkdmWk0xMjBUa2VMNG5ka3k2WkQzVElLQVJUd3NMR1RXL1VzYnZ2?=
 =?utf-8?B?SEVqUy9WUlBNWHc5ajlRd2hvWE94aDhFRlkvclcrbWQzK1B6UCtVM1h4dkpI?=
 =?utf-8?B?Z05mSDlzQVFwcVNOa0g5LzFWV3FxSkdvQjZQRlJHV2liaFJsdG1ybHlmaFRq?=
 =?utf-8?B?bmhna2hYZGd6ZzFKTDZza21WQnZLK1VUbjl3QTZtK0ZNREdGSW41blB5RVJh?=
 =?utf-8?B?YWRtUTJ6ZFhWRStqWW9Zd1pMc09TbzZ5VFlocFJiNC9SMllVOWNBcXhKdDFn?=
 =?utf-8?B?Zy9CNnE1RlFwZ3U4QXowWE9XWXczYjZ2SjFleVQrR0Y0ZVRaeXduTXMrSlZz?=
 =?utf-8?B?cXZ5THhNWWpCQ2YxMEhURHl0d1lMYTJiYlNEZTZGQ1RyQ2dISDZVMlhodXlu?=
 =?utf-8?B?L1ByL0F1dVV6RmJ1dDVJc2FPS2trcGc2Y3ZjRFRnUTBtUDV4UkUwUU5aVEpr?=
 =?utf-8?B?V3JDRENzSE8vcUIyeFZPVXQrb1pPTWlkRG52WHlTZGZkT3o1SGVYQ05WOWxK?=
 =?utf-8?B?Sk4rSEF4UmFJNE1ja2JOZ3Y5NFVreUR6dlBSaDhveEo1VXBLdnlJL3dPRlli?=
 =?utf-8?B?RHZEaEVTYUtFb0ljZ3RHK1ZoSEQzeDZ3Tlk2dU1OdE9BUEVJRERmVVlLOUQ4?=
 =?utf-8?B?NFJBTkFFd0ZaZ2hsU0tkR056cElLNjAwQ25icTZTQ0RaVy9ENlp1Q0RvMWtR?=
 =?utf-8?Q?KdvG+ffgIJrmxyCg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E5DF466BC0D30C4C84BBCB5372DC961D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4769.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8bc2480-2ed4-4daf-d161-08da3184bd01
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2022 06:25:40.2179
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mXgCzkPUj6W0m2F8qxr9Z1pca9ueSAS56iL8ZFlkejrGCTWqw7r2CSALecyfwk+ViZ7ap0lgei7soTV81ZfrYjK/Y+XOqz7jHzswJzr6NzQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4121
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDMuMDUuMjAyMiAwMTo0MSwgTWljaGFlbCBXYWxsZSB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBBZGQgdGhlIG1vbml0b3Jpbmcgbm9kZSB3aGlj
aCBjb3ZlcnMgdGhlIHRlbXBlcmF0dXJlIHNlbnNvciBhcyB3ZWxsIGFzDQo+IHRoZSBQV00gY29u
dHJvbGxlciBhbmQgdGhlIEZBTiB0YWNobyBpbnB1dC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1p
Y2hhZWwgV2FsbGUgPG1pY2hhZWxAd2FsbGUuY2M+DQoNClJldmlld2VkLWJ5OiBDbGF1ZGl1IEJl
em5lYSA8Y2xhdWRpdS5iZXpuZWFAbWljcm9jaGlwLmNvbT4NCg0KDQo+IC0tLQ0KPiAgYXJjaC9h
cm0vYm9vdC9kdHMvbGFuOTY2eC5kdHNpIHwgOCArKysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQs
IDggaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL2xh
bjk2NnguZHRzaSBiL2FyY2gvYXJtL2Jvb3QvZHRzL2xhbjk2NnguZHRzaQ0KPiBpbmRleCAzNDJj
OGNlZTJiOWEuLjY0MjkwZmI0MzkyNiAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMv
bGFuOTY2eC5kdHNpDQo+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2xhbjk2NnguZHRzaQ0KPiBA
QCAtNDQ0LDYgKzQ0NCwxNCBAQCBzZ3Bpb19vdXQ6IGdwaW9AMSB7DQo+ICAgICAgICAgICAgICAg
ICAgICAgICAgIH07DQo+ICAgICAgICAgICAgICAgICB9Ow0KPiANCj4gKyAgICAgICAgICAgICAg
IGh3bW9uOiBod21vbkBlMjAxMDE4MCB7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIGNvbXBh
dGlibGUgPSAibWljcm9jaGlwLGxhbjk2NjgtaHdtb24iOw0KPiArICAgICAgICAgICAgICAgICAg
ICAgICByZWcgPSA8MHhlMjAxMDE4MCAweGM+LA0KPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICA8MHhlMjAwNDJhOCAweGM+Ow0KPiArICAgICAgICAgICAgICAgICAgICAgICByZWctbmFt
ZXMgPSAicHZ0IiwgImZhbiI7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIGNsb2NrcyA9IDwm
c3lzX2Nsaz47DQo+ICsgICAgICAgICAgICAgICB9Ow0KPiArDQo+ICAgICAgICAgICAgICAgICBn
aWM6IGludGVycnVwdC1jb250cm9sbGVyQGU4YzExMDAwIHsNCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgY29tcGF0aWJsZSA9ICJhcm0sZ2ljLTQwMCIsICJhcm0sY29ydGV4LWE3LWdpYyI7DQo+
ICAgICAgICAgICAgICAgICAgICAgICAgICNpbnRlcnJ1cHQtY2VsbHMgPSA8Mz47DQo+IC0tDQo+
IDIuMzAuMg0KPiANCg0K
