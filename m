Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB66C4D4060
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 05:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239502AbiCJEnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 23:43:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiCJEnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 23:43:20 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A980411AA3A;
        Wed,  9 Mar 2022 20:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646887339; x=1678423339;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=J++3jxiSDrNGPxhKd0+KnW3sx+3X8n/y5GAJdiRSfIA=;
  b=aVkJH5cgyb0BngQmwD9pSxTxFSL+twwBpSGf2zXFyQlaLmnoXx8GhODZ
   5CaSF1JzfcgAhNKMJMak5lTl6Dv5/aoKmasCGHtdQo5LuuiamWi83KNDg
   dqwJjy/rASVPwx4+YsA7YDR/P+AieEHY7ZlGXUoAXXzIQ1SPdxYvkDYxP
   kOY0JD2gHk2mBr4XSPfboFCwItPXa0/8b8PNy1JxBACjrcno1xyy5w20x
   xp6uONOTRekynwT85TnjAU6I9lTtpF6BQZtNAylZI455wsAkl3B+eIIiS
   WNw5KuY2BmgG+Jk1I3vHWMxdEhRL205n1FEA/12QUfbwCvryC46nkMSd3
   w==;
X-IronPort-AV: E=Sophos;i="5.90,169,1643698800"; 
   d="scan'208";a="151512943"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Mar 2022 21:42:17 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 9 Mar 2022 21:42:16 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Wed, 9 Mar 2022 21:42:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bsv9u+WlJmpoMuJwPo180KCWE4FIgPK06F1MJ0vlZHBH0SJYRIIv4YIHyVscZMOKTloaNb/g8wVkh4Mem8Wnfyj774RLB9kOG4JGwUJgcgM8J/fTZcg/Qso/uk4Ar4wRIMsFjYfYO9onb0fYQCDir/u/ejg9jKGywAOE+SnsFdL0QYjgSsFqp9Ut9DJKiWKHonjmRz3g+IeqqMviygwXIt7FU0+qMuVueXuKtLf6OOjqq18ZhfE2mx89Nc3mDgZFeM4axI4Ei6DE552zigA9nejEEHijXUeodRztFd3bAtAro4UN+rwE4dmNw9+nIBpK9rhyW+B5obwJZONjsRdqfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J++3jxiSDrNGPxhKd0+KnW3sx+3X8n/y5GAJdiRSfIA=;
 b=O2n6d8A/ow+FhQD9Da5aTxqlMsHspmIJt+ve/dU9lUOKXEor2t+lwEWUxnAjjEIRYY35wx5HHUpBeevkbZmz/rWEM1DJe+oP+UhTthXpoKxcbvTFNsomBce4aB5xEgjR5kqoQK2irXtYhAz+FI0o3vfdXKvU6H9UFIXEE4aoJzMrkcXge1W6PQa+f4LqgeSuxrq4Z2HswRBk5IrE3aMSY3tV/JCLHLTYN8HC6SVKH2vliceR1ABbLOcmlHLuun1rWdD+xo/rpFW5citqGDtBUVTPuK4SFNpd7UrQW7UZnn3gL6L2Cx6K4EA5ItzrBdUQfJiWASr2WudzF2JO98QoAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J++3jxiSDrNGPxhKd0+KnW3sx+3X8n/y5GAJdiRSfIA=;
 b=q2I+vpScExo9OOFtzlDI78RXBBxvIlPB9ymGiBenMl2JFptgHjfb/hP3vaOsWmsuoi1l1mLjIPbNmmFvj7J2dQk5MW0VnUsK0XzzilhpqZcsICbstXXkOYCaVv3NgmBswObblz2sbGodH5XraRgP1Nuga4gVuFSqRJWU0CE3Aes=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by CY4PR11MB1800.namprd11.prod.outlook.com (2603:10b6:903:120::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.20; Thu, 10 Mar
 2022 04:42:14 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::dc94:3c7c:8ef8:21b9]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::dc94:3c7c:8ef8:21b9%6]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 04:42:14 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <p.yadav@ti.com>
CC:     <michael@walle.cc>, <broonie@kernel.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <Nicolas.Ferre@microchip.com>,
        <zhengxunli@mxic.com.tw>, <jaimeliao@mxic.com.tw>
Subject: Re: [PATCH 4/4] mtd: spi-nor: core: Introduce SPI_NOR_DTR_BSWAP16
 no_sfdp_flag
Thread-Topic: [PATCH 4/4] mtd: spi-nor: core: Introduce SPI_NOR_DTR_BSWAP16
 no_sfdp_flag
Thread-Index: AQHYNDk1Q1CNxvNli0qdMJB8pb1o6A==
Date:   Thu, 10 Mar 2022 04:42:13 +0000
Message-ID: <8f76e647-49fa-f3e2-6931-26ca960f3879@microchip.com>
References: <20220218145900.1440045-1-tudor.ambarus@microchip.com>
 <20220218145900.1440045-5-tudor.ambarus@microchip.com>
 <20220302123038.fe5bk3akyovihxem@ti.com>
In-Reply-To: <20220302123038.fe5bk3akyovihxem@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9c7fbe2c-2f17-4f21-f6aa-08da02505929
x-ms-traffictypediagnostic: CY4PR11MB1800:EE_
x-microsoft-antispam-prvs: <CY4PR11MB1800D721AC1443643BD5CD27F00B9@CY4PR11MB1800.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8sJS9YBTMRvwdgF0jX2CYseNjwOO7SCn7eOL/Natf4IeW0ptSuCWCj92HSPdn+3jPrEVpCkwdsN7i7hegTweyGHK/ZtEe9+J/Gg0CZpeXPuTdf/GdKiB7t3eubFz7z9p096R5UzjhSJ+reBu3QQPXd4h9MtQ1O8eO1JqUqgUNY1RO/ZFWpic2oBwUAS/MIvsKkceoLUcXgUjEwlqR5s0YgeAi/sBzqzId188G+KtM4hfvB32/WQklVE8bwLRTTiyONA1PYc1vtvdUaUwjN+Fw+r5WKMCwOUP/dDQwFbisQNxtlPklSZA6iz5iH+5i91Jj4xzNGhlZIX1HbEfyBEzQeKXY75/4ZX9wdu5noW/sn0OsDJa86QeBLC9vMlZEtQ0J7e2bawz63hUEZunLInfFVkwE0QdqKMaoau9HDHdKO68AshHWN94oyNTMeN3hsTMJ8zo2CrBhYdu+h8njTCprP001LTpdTY61dt2oOmoPYoTV2PqW8QOPYzNKw6hDL5cBCNm7AZI4rFem1cstNyfg3wwj7qQd20jMr1GjNgYMG6TJj9+yb5QaIqygzqc8d7ud7inQeoZLdysEeJ6m1QG70X1YZisu1++P6jLL8ss3jTFdxsxwPi1EosPq5soBG8xofPnRNinla6rhbFqqbCl6QnTkSZU1ljKQQxB5E633G3onUlvNrMdIu6rAgsvJtqZtcrV4HnAXFOU1p8gpCzqRh1Y2k7uBKZYrzgsx3Put1IPSAA4IEHLCbkWb/Q3XBOtrDKHiBmJ6gTmzAuyFKSnEg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(64756008)(66556008)(66446008)(4326008)(91956017)(66946007)(54906003)(122000001)(53546011)(66476007)(8676002)(76116006)(6506007)(38100700002)(5660300002)(71200400001)(6486002)(508600001)(2906002)(36756003)(8936002)(31686004)(38070700005)(7416002)(4744005)(83380400001)(2616005)(6512007)(186003)(26005)(86362001)(6916009)(31696002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M3g0N3JJYkZOb2ZMZGRPd25EdDlPYWNJdHdYZXRVNkhnYTE1eHF2NnNCY21q?=
 =?utf-8?B?aHVIQmNiOU5tT1RvNHI1ODlsRTlEYndrUGtBRHU5TFBsRllETDdCc3BWQnJG?=
 =?utf-8?B?cDVLd2IxNkdLU0dTcGJ1QmxUa3cwVVFpN2FTZ0hHRmdhRmhkVFZoa1VYQUE4?=
 =?utf-8?B?UU1kNVptTU40eTdRN3hVZlNoTnp4ZVpZd3EyRS9XMWZNU21uKzR2d0NxbktS?=
 =?utf-8?B?SHhLQ3ExVFRvWi8ya01yaFJJQTgvSm5MblhtQUpYbnhKRDNYZ1VXWE0vK0pK?=
 =?utf-8?B?QVYwZkpML2VSWjVGSmd3UElXZ201U0xDKzRValhmQlRKUVRlWkRTM1MzNWs5?=
 =?utf-8?B?cVFQNHRPNXNXRFJOVHBFUkFxVnA0ZU4yaGdzMWNERDRmM3RBbmZiOXZtYVRZ?=
 =?utf-8?B?YVRUdEpHanMyNzI1Y2hOSEdlWkhZU3pNVmcraGNSNk43VWs4ZHFYMUJEMGZm?=
 =?utf-8?B?UktUY3JyT0N0N3FMMit6dHFmOGFEZGRKRlFpZnFHcFllRnBGYTZWVS84Q1VQ?=
 =?utf-8?B?RnA2Z1Fub1NoR3MzU3ZmbURKQVBXNGJqa3dONTBZM0d2NE1NeC9UWjUyOTJy?=
 =?utf-8?B?UXBVNkhtY3V5NzVMdVlIWFlGUHh4Tng0Vm10WVhxM0NoOWRYRGpRUGN5UTk4?=
 =?utf-8?B?U3FPOTE1V0dWRThjWFAwQ25BVnlTOUlWV3l6TWppb3B6bmIwUEJUK1VHSnJ6?=
 =?utf-8?B?RjBObS9QZTZGenVibWVFVWlwTVBGYkd3S1hNSnVmcC80cWZVSjNBRkF1UGxR?=
 =?utf-8?B?MG9iMmZOK0dJREhXdW1seXY5MjdQOTdFM3BBMSsvcjdDMGFlUnBId3ptelVz?=
 =?utf-8?B?TE9sYzdzS3ZQMm9wTmVrMlZablhuNkx0Ykw4Z2tCcVZFRnZsbDkwbHBCb1JU?=
 =?utf-8?B?ck5wamhiNFdLVW1XVVpCZit6NHZtcFozd256MG9RSlJhU2RZa2VsZW0yQ01J?=
 =?utf-8?B?dlhyQTZJU2ZYcDYzRnd6S0FjMTY0b0VuWGNQaUx6bkYrb004YWVkbXpoNTAw?=
 =?utf-8?B?amt0bW9yOW5LSlVKN05INUJLbVE5bm9LUTVmakt4WXE1ekljcmhqcUg2QkZG?=
 =?utf-8?B?TnZKeFRsQ0xORmJMSHRXYWg4ZDREQ1g5ZE5aWUM0Y283ODZSVnkvUDc2Titm?=
 =?utf-8?B?YXZIcW1uV2ZiY002N21OYXJtN2tVYjN5ZFRPUHlZMFZzUkNPRHV0WktIeUZG?=
 =?utf-8?B?QUdVTVkwdzQwaGJ6ZWE2SldIQmFUUUovS0tlVmJ1VVNMaGd5Q3RPNHFJMmxx?=
 =?utf-8?B?TWIwMWxjTkdpWExEMUZ5QkNhS1d1TGE2TVJxekpURmN1Q2pBU0o4dVBvTFVo?=
 =?utf-8?B?enBXNFBlbkd3MmlSREs3UFlpZ2R0WGwxdWtIdHQwcDI2c3hFRGNWVW1wdUNi?=
 =?utf-8?B?R3BLUGJQWFJhdEVxOVZjWTFOWHhFeE1xRE4rZmduQXV0TnF1R05pQXlEZU5L?=
 =?utf-8?B?WmhtZXZLUFJWQVVBYWVaYlovcVYrWEdpYlFHT1JjdzJreDJjV1RxZ3pSSDRm?=
 =?utf-8?B?dEdkU29MR2pDNm5ldE9lSDFtN1RwbEw4V1RtdldXaS9rSnErVi9adm5yV0xN?=
 =?utf-8?B?Z283NjFnMFphMzlCbHFOcW9BblAyUTJSYXJuSk5LcWF5NWhYODhSbk9JVU9S?=
 =?utf-8?B?dUwyS0JuY293UHI2RUdVdU83Z0NqcXNXSnp3QXU3R3ZBTTg2SFFzaFZNMDdO?=
 =?utf-8?B?cmNkazlqdzcrdUNwaDdvRVUyaUpqeEtiODBkVFE3RjZKUUlPdy9aQzZkcy8x?=
 =?utf-8?B?aE56WHJoMUZFenFNdXNDVnY5NW9ZRjFoZy80QS9xNndLeVoxNzlRVnZKY05M?=
 =?utf-8?B?TFZub2RkcG9GaitkT2tFcUhpRjFYVko0U2lPZ3BwY1U2ck92THdkU3N2cE0y?=
 =?utf-8?B?dHBLUUpnajFTQnhPRS9EcitTcCtDWTRHTHM0VXpuK1N5eVQ2L3hrNWxrWjdI?=
 =?utf-8?B?NlVxQzdZQnREZGZ4aWpGc2tOUWZzN1Y1ZXdGUUpSWlhIVU9KdWU0NGNVNHU5?=
 =?utf-8?B?MkdMa1MzNnl2QjRzQ1p2eVV5c0p4ZTRLaExjRDk2NXVpbFdUbkJxN0hWcndi?=
 =?utf-8?B?QTRpdnQ1UU8xTXk2alNsWlJTSWdveXh3cG1ReXRwTjJPL1JtZHJPbTFJbEt4?=
 =?utf-8?B?TjFoN3J5R2NCOXM0ZHlNcG5sc1N2Nm1zVEZwbkRoZjlaVlZoZXh3SFNGOCtM?=
 =?utf-8?B?REJqYW1KZG9UMlYvVXM3MDQ4cGJtTG51QUJtRnVRMlR2dEQxKzdUM1NmSTFi?=
 =?utf-8?B?VyszdVIzWWVXbVVabnRqSWR6RjlnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C262CCE057709746971E5571D402C2B7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c7fbe2c-2f17-4f21-f6aa-08da02505929
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2022 04:42:13.8846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b9Y0hrN3BbVe7AimFb9Za6CMbHgg8Qwe+rCpKbilYAGT6gWz/d46BasZAAUxOKczPBFp4vfaW2B8BzIN1PwAc4ncupufPHPrW6awx2lrk5w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1800
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy8yLzIyIDE0OjMwLCBQcmF0eXVzaCBZYWRhdiB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6
IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0
aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiAxOC8wMi8yMiAwNDo1OVBNLCBUdWRvciBBbWJh
cnVzIHdyb3RlOg0KPj4gSW50cm9kdWNlIFNQSV9OT1JfRFRSX0JTV0FQMTYgZmxhZyBmb3IgZmxh
c2hlcyB0aGF0IGRvbid0IGRlZmluZSB0aGUNCj4+IG1hbmRhdG9yeSBCRlBUIHRhYmxlLiBXaGVu
IHNldCBpdCBpbmRpY2F0ZXMgdGhhdCB0aGUgYnl0ZSBvcmRlciBvZiAxNi1iaXQNCj4+IHdvcmRz
IGlzIHN3YXBwZWQgd2hlbiByZWFkIGluIDhELThELThEIG1vZGUgY29tcGFyZWQgdG8gMS0xLTEg
bW9kZS4NCj4gDQo+IElzIHRoZXJlIGFueSBmbGFzaCB0aGF0IGN1cnJlbnRseSBuZWVkcyB0aGlz
IGZsYWcgYnV0IGRvZXMgbm90IGRlZmluZQ0KPiBCRlBUPyBJZiB0aGVyZSBpcyBubyB1c2VyLCBs
ZXQncyBub3QgYWRkIGl0LiBJdCBjYW4gYWx3YXlzIGJlIGFkZGVkDQo+IGxhdGVyLg0KDQppdCdz
IG5lZWRlZCBieSBteDY2bG0xZzQ1ZywgdGhlIGZsYXNoIHRoYXQgSSdtIGN1cnJlbnRseSB3b3Jr
aW5nIG9uLg0KSXQgZG9lc24ndCBkZWZpbmUgU0ZEUCB0YWJsZXMsIGF0IGxlYXN0IHRoZSBvbmUg
dGhhdCBJIGN1cnJlbnRseSBoYXZlLg0KTGV0IG1lIGFkZCBzdXBwb3J0IGZvciBpdCBpbiB0aGUg
bmV4dCB2ZXJzaW9uLg0K
