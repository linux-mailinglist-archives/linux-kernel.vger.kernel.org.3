Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 932A053EA10
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241981AbiFFQp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 12:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbiFFQp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 12:45:56 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2414315A757;
        Mon,  6 Jun 2022 09:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1654533952; x=1686069952;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=XxMqMAx/yMCoK3XgfvEj5ENksFm3ozsBiGtjATepiMw=;
  b=gM/YCSYYPdUYkeAJ55Y9fVV0x8Du+YyDS1EYL2Xf1ohxMw/z5xRnTVFl
   6jIqvzjAoCHt433BlCwPm4mM33zMqGfcOgxpEwzWmkE+TXo2wNrxq1r91
   DUWrh4ailkZub55bEN7Otsq/zhGt0foG6hvUvmxWm9hpLFyf7n/24FhMV
   ISgMkao8JvueVbK4XGJeSGHHNRCq1WbY1rfR5A5hWzZk6BsvzREL55y4/
   wo8/K2AT/tMquNRwkfL+fJjFEZXAd+up1HM4wvbKKRtaoXrSzlSRPo2+P
   NQeHcyTLY1NnMXQqzCu33YAT978C5ZrpzwlzCfdo7mOweGVJfvLMdRXB/
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="167277855"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Jun 2022 09:45:52 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 6 Jun 2022 09:45:52 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Mon, 6 Jun 2022 09:45:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TEkaVmFbAb13/6jFtz6MWOvYleqRaCmRGBb3Nh4nijaq3TGzQVv5aSrxcnhgiaQ+AjRyF/XQFSYT/Q+eBUEDLm6kJiS70K+z8VCA55Z6hxMDPnHJXVOWqxyyjEfeEu1Ex9z7OZK1eQWer5gYosSfB4cTQ8QQ2hsRCY8vRQVvohrW7boxg0E50zgR+e6ZYn48wZb1MFG7DcudW1IKSb/vwPTnU9A0OXU6XJBQ980l9qe0RzIFas2uFzJ40cuPAYIXUOJE/6qm4WDylMeHqjPlLqNyquLw7SZjcnZ5OXno9zr5Jz/yR0lufz9CG9Ri1VkMXH4U1hVp4vCaYYLzzmeKsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XxMqMAx/yMCoK3XgfvEj5ENksFm3ozsBiGtjATepiMw=;
 b=a7qCjCp+39vXDo7PVELLE2EnK/v22liury1G+LYhUVUCtSJQ98tl37lBuJkJwLLc9jLG0hMnMT3zY8p4nsRjJ1fAaPJ2xrZg6isWSW7Q4sz3fPGTFU6XZHJNb4dV+Trla+PBC8FyF2Ckz+sMv9OfATkCe2Ns9p0MQCIaXGtiVGN/SWmD2f/xQkNidVaNM1rfRSQv0tU7q0+7mEKA/R89j2ndE24X1ak7okt+qGVQxXcRWJnKVhzUYUwX/AYEy13M+Zf6P284fg7w2roLKF2HoAos1oSKRnaYp1/sXPapP7vy+WXz/HbmzS0kJKHdaFTHn+9AxZeOuePLry8lhKY/ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XxMqMAx/yMCoK3XgfvEj5ENksFm3ozsBiGtjATepiMw=;
 b=osrYndOOmoW0eMCgG5mLWwvmujHPhlrDXOwFAQ9Jh/h3zQXcn9u0AD7OSLpoXDZtxslvWBB1WD+oOO//XHfq7WacZYyoC0eGbHWhZMEXGItMeaXdvJ92bKZLexJQEvginArc9MUIvETFU5A1lA2CW1pryqdD6stnOyrrxxIVpyI=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by BYAPR11MB3591.namprd11.prod.outlook.com (2603:10b6:a03:b4::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.17; Mon, 6 Jun
 2022 16:45:45 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa%4]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 16:45:45 +0000
From:   <Conor.Dooley@microchip.com>
To:     <kettenis@openbsd.org>, <kernel@esmil.dk>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>
CC:     <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] riscv: dts: startfive: currect number of external
 interrupts
Thread-Topic: [PATCH] riscv: dts: startfive: currect number of external
 interrupts
Thread-Index: AQHYecLPKKEbTDzMnE2JoGa00372qq1CljQA
Date:   Mon, 6 Jun 2022 16:45:44 +0000
Message-ID: <6acff7ab-6f97-b17a-ce9a-a526aac81181@microchip.com>
References: <20220606162924.71418-1-kettenis@openbsd.org>
In-Reply-To: <20220606162924.71418-1-kettenis@openbsd.org>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2d347f80-7ae5-4050-143e-08da47dc004a
x-ms-traffictypediagnostic: BYAPR11MB3591:EE_
x-microsoft-antispam-prvs: <BYAPR11MB35917EB212B34D11F531EDB598A29@BYAPR11MB3591.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iszqnAh5DHlLvc6eWHRriha7uKlt658TepA86gZaJXyKSzVCVndQXqwMmmBegHP3i+9f7gP2+BFTLPiBGQSZz8JCPJEXqd1M1/biVUC/kIj62L9GyCPf6/ZP3Bx6kgPH/QusnaR9mErTGmLOrwKdBqINL8r5dW4ZYG5xGmIDfHe/c/3dnsioBraaluUWEvwL5qPY4Awi11mkOuHrq4Y8BI16F4UR6Fzx11W9FLGsH7sC9o52hGAuChvxRxsRdpGU7gA9EWv6IsH45MrXhbb3sW+RMCNJupm1AzZw9IPuZCJ5JOhm37holktRQSlWsV9krSlqSZELqheGlysO6ZdltEeSKMsxBT4DZoi5Gmevj+28xdGmBrkUeIwhi0SBFhpTjN7rRKLlFYXHai9M2eA4MBL26UuWPMhWY/OAw9LhW+7G2LTTmVYHVDVVAURtLntcqKV6eXoqpBWVMc6dnFBNm64nSrp/xJGVxRMBVhHK36FSXiyWuJLeE0jW7YSRr/i3O+KjPHVyNAUQUyP6XHVzsNhgtBE9ES4ezCC3Ce+zxGo0D4WGF1GUIDaJVGzfihrNWm1DiWER1fLY8QyqwqDpLtStayzber1rwAivtcCV/eDLR43lvqO7YkkuDTOKb1GKj9SheBJ9wSJcprKg2cscyje5A2kWxg2yxXDG+CMSYAZQWm4AijfBfYMMnO/LKWmHFKoMiHOZvb+rw/RtOmEH15Ju9vQXBO/wkNHAz5z4t43MWeWQwihLpE6I8+NpywEubtRhrvVQ54/GvQsRs5Ma+PmvOBBWMq3dD2jipCB6RdkUbE03VrAhdbxjRFYEOYhCTAyYiImkv0Py/jTj9YpI+oQEJTNGjnGWL2CVBTYfjVI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(6512007)(38070700005)(6506007)(5660300002)(508600001)(8936002)(53546011)(6486002)(966005)(2906002)(7416002)(83380400001)(122000001)(2616005)(86362001)(31696002)(186003)(66476007)(64756008)(76116006)(66946007)(66556008)(91956017)(66446008)(31686004)(71200400001)(8676002)(4326008)(38100700002)(316002)(110136005)(36756003)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bUhWMUVUV1hEdXJvSkUrMnQ3cTJkcCswTmo3ZXJNb2RJMy9nZlhHemhpUGtD?=
 =?utf-8?B?K3U5b2JvZzMyNDVTOERONXVWK01mTTExWFR5S1UrWmZSa3R6MHNoRmkwaFc2?=
 =?utf-8?B?bUc3K0Y5Yk1zZm03eWh5VS9ndHZ3cHh1akFBeUFsdjlvSU1UWkUyS1BsUms3?=
 =?utf-8?B?RGNrbzlzSFZSTGJROFR5SldhSGRnMTlVWWYvbVp4M1ZQUDRsMHN5SlAvaktG?=
 =?utf-8?B?M3lLMTJLV1dMd3RKR1hFdkFBSWY3akJua1d5MlA0dDhqbzY5Y0JvUGpoOVJ3?=
 =?utf-8?B?MWlLaGIrOUozMUlxQzNtYTVoVDFLb3JMSG9ickRNUlZUaFRROWdCanNaR0JM?=
 =?utf-8?B?NXYwcXk5Z0lYelBYYlAvRXpkS01lUmpFWUtPSU5yREVRN25GYlVsUWtIOGRh?=
 =?utf-8?B?S3hSVVJxSWNjLzBuRUlyNDdGR1NMekVmR0RkMW5aRSt6aWs3eWlMNEdFY1J2?=
 =?utf-8?B?UUtLL0gxYUZnUHhqdm4rZ29FdW9OMWNNTzBoS1dkRVZDV1gxTlZFcWhaUVR5?=
 =?utf-8?B?b1U3NXBWcE5sd0ZTWTNsSFlpMEpqMTRLUHVXaDVhV2E5MnVwZVMydWlGWWZT?=
 =?utf-8?B?MUdIYXExdm11RE1mejUreFM5ZjI5ZDZMd0lUc3EzVTk2WG1rRkRYamt4cWZO?=
 =?utf-8?B?L2M0bHpKWVlVODBpdERKUTNvTGxLbUd4OUgxbXM2bXRadTdEM0Y5SnVSa0tI?=
 =?utf-8?B?Z2JNQk9QdzdsL3MyU091cW85WEU1TWd3ZUlyM09ObEFNcXdCNitUTnhQSlN1?=
 =?utf-8?B?Q1pRN3FpL3Q4aUhkQTRTZnJyZzdlWnNnU0hWUTNuSFRsZ2kvNE9DcWp2RTFa?=
 =?utf-8?B?TmE0RlQ3SUw4NjZ6QzM2WW90WFE2R1lKNDM3MHgvdlQ5V2VhYS9HNGtRSVpj?=
 =?utf-8?B?L2pSY2YrOGtDWG5leXdEYzQyNXozd1JoeENWdDg0TEhsTDFGM2EzN0dVdDgw?=
 =?utf-8?B?Qkw2VDVSSmVFc3hkVTRiOExXVXQxSXU4SWRKYnBzQkwrWnpjRWpzSnB0bHEz?=
 =?utf-8?B?TFQvQVg4a2lEa1RJZWxjck1KNXlQVTZKOWNzVHRLZ21QeEhLY2lMZkxQNzZi?=
 =?utf-8?B?N2JOOWd1Qzc5dGJmTXNUK1dTcnk1NmNMWGdLR0wvd1ZoNEcrT0EwWTJ5bVND?=
 =?utf-8?B?MDJ1T0ltNGpGNTJMM3phNmwrOUdya3cycDdCeFdYQkgwWXZKbTNGcXl5ZVd5?=
 =?utf-8?B?UnN1MWN4RDF3ZGV6eHVOY0t3eTZScDdsOTJQd0VESldubGRsVk1LQjljZmpi?=
 =?utf-8?B?THU5SUZaRmRkMWtaR0tab1BnanNTSWNpK0d3WXNzeEpkV2c2UWd5ekllcE54?=
 =?utf-8?B?QS9CTXJLSVk5NmhvR2lHRHJWTGZZRU1JUVBleDBVUDA3U3BacGJDWUxOWjQz?=
 =?utf-8?B?ZklYLzVKYUtKQmJnS2haUlZ5eldPY3BkQnNvTGhtM1ovUVJlR2pRZEZlRWto?=
 =?utf-8?B?aEpwTHA4THRGMW8zZ29yNW1mS0toY05XZHNwODNzZ2xTZVlaWXVpT2N1R3BK?=
 =?utf-8?B?RkJwTEpCSnZzWmMyUGhIczM0ZW9BWVIxaG5jZ0w3QXFaV2tsZkZGeFhrMVVw?=
 =?utf-8?B?aG1RTGdCOTdneTQ3QWZrOHE0Q1phRjlFTzJEMEtoejlnRlh4bjhqYWJGUm11?=
 =?utf-8?B?U0lBdHBvVHIzQ1oyenBwNkxsMVpXa2VKMWo0dHNpRDd0dlRJbEwrZkQzRlY2?=
 =?utf-8?B?Y0hoNU1tWHViSkhpc0JKc3FGajcwS1lCSk5ReHVlSktWbGExRFhlL0lLUisw?=
 =?utf-8?B?MXdOWDBzZjNqWTJTVmYvQS9ISjUxTlVWaXNzMmRnMDNSYU5XRDIvRkcvemll?=
 =?utf-8?B?QnZzVW1NMlpFckZVaGcyejhUYWZrSm9lcFRid0ZMSEcwMHBPSnVoeWwyQ09r?=
 =?utf-8?B?aFRzSDZDMFRPdkhlQXBKMGZsZUVLQ1l6bkI2d0N4b3haMVZUb2R4UEtsanBG?=
 =?utf-8?B?N2NIc2QvUjVGWTEyUW4xWnlROWZ6K2ZzNFFDUTZBT3d6ZW9WbVVhZVBBSDdi?=
 =?utf-8?B?RzhyQzZoN3FZV3ZPR3NyUk94ay9lOEpXdTc4VWNRNWtFOVNJc3RoRVZYbEYz?=
 =?utf-8?B?dWg2SUJ1Q3krcXI1QWQ2Nitaakt3cW5CSEVwVDNmVUxTcFREbXNXNm94MUdx?=
 =?utf-8?B?bGl1WU8xd2R4UVlwZTJqU2hwcGREMERQeFpuNk1qc1JtOHRjbk0vT3A4RDZK?=
 =?utf-8?B?KzRSRXAvQkhmeHprcVNWdjdtL3MrSE4zQ2J6QU5sTGF2VjU1N0JOYkp6RUNX?=
 =?utf-8?B?Wi95eGM0SnZPSG80Ui9jdTZSeDBsYkZMUFpxWkk0NGFBa3VETUoySHB5S2Ix?=
 =?utf-8?B?YWxjTnEvNi9seVpVYkxnOFVJeEZadnRLTlJWMks0Wk1oMFMrMnFqWFNQT0dx?=
 =?utf-8?Q?wIXsWfHm5m/2wZAc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D4B4B1769061A84C9A4F0B0FB57DDF38@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d347f80-7ae5-4050-143e-08da47dc004a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2022 16:45:44.9109
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +YIZLz1TB9ITdAobh54d1mpDAPNwe0p971wg9/lWousV4yuWCyVxoMC4jGkZnR2cbtdPGhpBlKogj8oDjwPGwDGsbO0FpdSNGf7opyh5SU8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3591
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDYvMDYvMjAyMiAxNzoyOSwgTWFyayBLZXR0ZW5pcyB3cm90ZToNCj4gW1BBVENIXSByaXNj
djogZHRzOiBzdGFydGZpdmU6IGN1cnJlY3QgbnVtYmVyIG9mIGV4dGVybmFsIGludGVycnVwdHMN
Cg0KSnVzdCBhcyBhIG5pdDogcy9zdGFydGZpdmUvc3RhcmZpdmUNCg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IFRoZSBQTElDIGludGVncmF0ZWQgb24gdGhlIFZp
Y19VN19Db3JlIGludGVncmF0ZWQgb24gdGhlIFN0YXJGaXZlDQo+IEpINzEwMCBTb0MgYWN0dWFs
bHkgc3VwcG9ydHMgMTMzIGV4dGVybmFsIGludGVycnVwdHMuICAxMjcgb2YgdGhlc2UNCj4gYXJl
IGV4cG9zZWQgdG8gdGhlIG91dHNpZGUgd29ybGQ7IHRoZSByZW1haW5kZXIgYXJlIHVzZWQgYnkg
b3RoZXINCj4gZGV2aWNlcyB0aGF0IGFyZSBwYXJ0IG9mIHRoZSBjb3JlLWNvbXBsZXggc3VjaCBh
cyB0aGUgTDIgY2FjaGUNCj4gY29udHJvbGxlci4gIEJ1dCBhbGwgMTMzIGludGVycnVwdHMgYXJl
IGV4dGVybmFsIGludGVycnVwdHMgYXMgZmFyDQo+IGFzIHRoZSBQTElDIGlzIGNvbmNlcm5lZC4g
IEZpeGluZyB0aGUgcHJvcGVydHkgdGhhdCBzcGVjaWZpZXMgdGhlDQo+IG51bWJlciBvZiBleHRl
cm5hbCBpbnRlcnJ1cHRzIGFsbG93cyB0aGUgZHJpdmVyIHRvIG1hbmFnZSB0aGVzZQ0KPiBhZGRp
dGlvbmFsIGludGVycnVwdHMsIHdoY2ggaXMgaW1wb3J0YW50IHNpbmNlIHRoZSBpbnRlcnJ1cHRz
IGZvcg0KPiB0aGUgTDIgY2FjaGUgY29udHJvbGxlciBhcmUgZW5hYmxlZCBieSBkZWZhdWx0Lg0K
DQpUaGlzIHNlbnRlbmNlIGlzIGEgbGl0dGxlIGhhcmQgdG8gZm9sbG93LCBtYXliZToNCkZpeCB0
aGUgcHJvcGVydHkgc28gdGhhdCB0aGUgZHJpdmVyIGNhbiBtYW5hZ2UgdGhlc2UgYWRkaXRpb25h
bA0KZXh0ZXJuYWwgaW50ZXJydXB0cywgd2hpY2ggaXMgaW1wb3J0YW50Li4uDQoNCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IE1hcmsgS2V0dGVuaXMgPGtldHRlbmlzQG9wZW5ic2Qub3JnPg0KDQpBbHNv
LCBJIHN1cHBvc2U6DQpGaXhlczogZWM4NTM2MmZiMTIxICgiUklTQy1WOiBBZGQgaW5pdGlhbCBT
dGFyRml2ZSBKSDcxMDAgZGV2aWNlIHRyZWUiKQ0KDQo+IC0tLQ0KPiAgYXJjaC9yaXNjdi9ib290
L2R0cy9zdGFyZml2ZS9qaDcxMDAuZHRzaSB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3Yv
Ym9vdC9kdHMvc3RhcmZpdmUvamg3MTAwLmR0c2kgYi9hcmNoL3Jpc2N2L2Jvb3QvZHRzL3N0YXJm
aXZlL2poNzEwMC5kdHNpDQo+IGluZGV4IDY5ZjIyZjlhYWQ5ZC4uZjQ4ZTIzMmE3MmE3IDEwMDY0
NA0KPiAtLS0gYS9hcmNoL3Jpc2N2L2Jvb3QvZHRzL3N0YXJmaXZlL2poNzEwMC5kdHNpDQo+ICsr
KyBiL2FyY2gvcmlzY3YvYm9vdC9kdHMvc3RhcmZpdmUvamg3MTAwLmR0c2kNCj4gQEAgLTExOCw3
ICsxMTgsNyBAQCBwbGljOiBpbnRlcnJ1cHQtY29udHJvbGxlckBjMDAwMDAwIHsNCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgaW50ZXJydXB0LWNvbnRyb2xsZXI7DQo+ICAgICAgICAgICAgICAg
ICAgICAgICAgICNhZGRyZXNzLWNlbGxzID0gPDA+Ow0KPiAgICAgICAgICAgICAgICAgICAgICAg
ICAjaW50ZXJydXB0LWNlbGxzID0gPDE+Ow0KPiAtICAgICAgICAgICAgICAgICAgICAgICByaXNj
dixuZGV2ID0gPDEyNz47DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIHJpc2N2LG5kZXYgPSA8
MTMzPjsNCj4gICAgICAgICAgICAgICAgIH07DQo+IA0KPiAgICAgICAgICAgICAgICAgY2xrZ2Vu
OiBjbG9jay1jb250cm9sbGVyQDExODAwMDAwIHsNCj4gLS0NCj4gMi4zNi4wDQo+IA0KPiANCj4g
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gbGludXgt
cmlzY3YgbWFpbGluZyBsaXN0DQo+IGxpbnV4LXJpc2N2QGxpc3RzLmluZnJhZGVhZC5vcmcNCj4g
aHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1yaXNjdg0K
DQo=
