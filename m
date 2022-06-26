Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE21855B17D
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 13:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234240AbiFZLTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 07:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiFZLTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 07:19:15 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7631A444;
        Sun, 26 Jun 2022 04:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1656242355; x=1687778355;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rBeSBGXiucHbiPqu4eFHRBpgUs06ubTDcQzckql+acI=;
  b=OJ9m6Y1FuCc5Ci2ah8DM2YFUFDBNPmeJ3lKUMMKJ9MWiH9Q/zSL7mZ+9
   FkydWaxrQXw3LyhmuP3v/c8NQ/QujN18MyT49+8tTL96FTgieFvkR+ZZU
   KP2LrSWw65RJUQx4blNwkqiq9pxQRM0FymFxYDMSUEyjQdWwq7e7IVE1U
   l+gSZpnRkkvuS67hP9RPsJiNn782WEbxNV1EO4HVxrJ7fO+Ln8fOCZGvZ
   oXV/J0j5TBP8D3V1z/8BSb0pg0fgoX5/Mj2bYUbY1HVbsLawx/SIOeSE7
   xitAHfkkL8UXFVbblFltoEJM47fW8eeZn3rjiyND67G5+ziZbXflMG7fp
   A==;
X-IronPort-AV: E=Sophos;i="5.92,224,1650956400"; 
   d="scan'208";a="169630774"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Jun 2022 04:19:14 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Sun, 26 Jun 2022 04:19:13 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Sun, 26 Jun 2022 04:19:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MaTd6xo7UvW4tkSaapbzTOlGhG16o1FexSNNJMNTrlYiRqgka8XhGc5vaq/VXKPOFrAojRhnxoEkfHqh37RJIFm8e6sLu2TtDRBgK41+dnsb19QZpB1BkUKDefKRcI9kciMMWeYlOHyMXuz5R9EKZ/PHONeHzCj5ZhoLLao5vijIkhPkbGYK5Nx4tPDDvK2dMxDasKVrzyUzXUaubCFir9mTsOa2IWGMUZ4qSx6G4u+vIgZY6JdQyW8v1ssqMB1IkP6isCYqB4ko/SnDJqxrHFwrBuKQ1s2aT066YtiPsHRHisMRQ3SvLmNOy7kaL+siT3JioZmf0u9oiP+FmByS7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rBeSBGXiucHbiPqu4eFHRBpgUs06ubTDcQzckql+acI=;
 b=OWJ1i/L5hIoaKSIttWT0R41forva0kef+wT/rbIW44IORvlP6vJXwbWcYvhyd9zHVYvmq4Mz+EhLDVHhjT9fUlSDSloqzoHPiaADLHxnlErPMSEfSER9Ps+gcMzZ4DnkY+BqQU8W7He9Ay2THiD2O/33X1ovp9eIoJceehbYicPZxj1EEa53cpHuFNszy+snTcTMGFJBzP16kYElmIoiT+W4EhvpLqb29lV2ad0k2OGrU66mqi8FpTY4MIuvxqqiatp3a88wGn8BeyQH07eQGB50UforIlK/VziEXqauLkGB0dOJcj9ju72yVx5CK7JLyhtNjSgTIYnYAZuPp4pjog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rBeSBGXiucHbiPqu4eFHRBpgUs06ubTDcQzckql+acI=;
 b=Ia+a+geBdYEv4idBZ3Uw+UN30Z5DXSKfOz9B8Z1Jn9KQu5X5c77uwTLB8gQQ1XObU0CurlmzJDG3KvZBYtF8LiVYIJIB58x+Ux3oY/umqykf7GBmIlZwmHe7L3IcVF+0JPcHpw7qK0aBHkyfYZMd7XBA0sgyJgC/mYlIwLABmkQ=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by CY4PR11MB1800.namprd11.prod.outlook.com (2603:10b6:903:120::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Sun, 26 Jun
 2022 11:19:02 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa%4]) with mapi id 15.20.5373.018; Sun, 26 Jun 2022
 11:19:02 +0000
From:   <Conor.Dooley@microchip.com>
To:     <mchehab@kernel.org>, <linux-doc@vger.kernel.org>
CC:     <corbet@lwn.net>, <mchehab+huawei@kernel.org>,
        <lee.jones@linaro.org>, <robh@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 20/20] MAINTAINERS: fix cross references to
 mfd/dlg,da9063.yaml
Thread-Topic: [PATCH v2 20/20] MAINTAINERS: fix cross references to
 mfd/dlg,da9063.yaml
Thread-Index: AQHYiTzLSnWozcVptkSdBTXP9fxA7K1hipoA
Date:   Sun, 26 Jun 2022 11:19:02 +0000
Message-ID: <bc9277c8-1543-efa9-be38-92361c421523@microchip.com>
References: <cover.1656234456.git.mchehab@kernel.org>
 <813bdc2f54663572a976bccdcafae2d463259fa0.1656234456.git.mchehab@kernel.org>
In-Reply-To: <813bdc2f54663572a976bccdcafae2d463259fa0.1656234456.git.mchehab@kernel.org>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f2dbb711-6744-4a12-2864-08da5765ac99
x-ms-traffictypediagnostic: CY4PR11MB1800:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bfQdQjIK/b+VMEl65g7gdAzt/Z2omMIkRn8BZzDtwEDfovriSS7C611WrLP/FqtTHUso/U3E/yRKO4iibiywD514y+NoFsJ0eQwrpWDfsGdOjm9zVjVOhZ+zY3jOProq5xfEmEdiUoD8s02znJkve6/spoEulPKS66edlu4WdakN0ZrUwYSYaGxUaJsUtB5TMtvsUFaxKZTzy76aCYfs+Cgm4VcC6iSoSRKNcroUhhJclsXcHi/4t7zj/qhM8VdiOlNtmrq7fBHG+D1MDOXFLh3gxLNlXeGnaTVCyuJAYoZNmsfyQWnCm3oGCwUZl5nG6deODr4BemxUdVDEQOrYCX63pmTPZQe1OhleOCAE+s/kdfX7nlLdJ4TJaZn+T+ubk0RgMGO+lVAWEPWHKnDikkr+Q9BLKKdoYaT3tMLnHBZG4Tt35fr8XnxkfzuZxZVEdg0RYtxcKd+DKvaWi0/kR1HcYjYQzoLXSmU0GCf+LKWjmgqSrdYpY7yrKygUCtCOZm5IIxeMgCBsyBpTzOKnbGi6AcmKWyLIT4/mQzfHegdhHXcOK5PGU5m35fLaUUJsjnWZmkriWZpeoqUuryIUqnjYVYdJUBziH6mbmMokTquoGt24F83ySiGed6MESYT8BHthcH162ahlvE26IQBd0HbdooCJN5rp5VF2RS+tjl5oFT3fZ08IsEtRk7QlLGO1tkmBbCce7iT4MD99Q7NwY2I6qpLEIDJ79W9mgX+anNK89DQeYqKJx2LvSIyxN8erLGfQSBb37Xu7lAi+lCotwa/rkLG479KYJaLPyHStN2aoH3Q3kGVRCdolBrHgAnZgORqHmAIyjIFjj2Vv8VjOXwRYQGzzFHGhsZQsjc/ORWHuu+5viWQNzHsQJW0DgJqMjcm2mQOYmrHhS08MbgNgxMDg9cOcJTYkx4ABLB8mYUhIRJGKenyXlTVRRpYNQ00K
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39850400004)(396003)(366004)(346002)(376002)(136003)(66446008)(66476007)(8676002)(66946007)(91956017)(76116006)(6486002)(966005)(316002)(478600001)(4326008)(31696002)(2616005)(71200400001)(66556008)(64756008)(54906003)(186003)(122000001)(110136005)(8936002)(2906002)(83380400001)(6506007)(38100700002)(53546011)(5660300002)(6512007)(38070700005)(36756003)(26005)(41300700001)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aVVwa1J1WHhhcm5kZmxJMERUSTg4TUZjNVF3Wkw4QkQyalpHeUgyL3lpNmdw?=
 =?utf-8?B?MjYxZ2tSa09mZy80dWJLcTQzMXdLZjhrbEozRWZ3N1ZUdVArWGU1TWZncS9K?=
 =?utf-8?B?TDV0V242NnhFRmt3OWlySGpUNExRWUh6OVI1ZHQ1RVY5aFd2aUdkdDlQdmVm?=
 =?utf-8?B?bHRGVnJwakRDcjd5eGJpTWRudVA0K09GU0N0VkRUcEtMNlhtcDdWTFhhUm8r?=
 =?utf-8?B?WG0wcGRKNzJrOEtsTXR0ajZzZ3EwMWxJdUtBYXlBN3Uva1BIRjFqYVRHSzIx?=
 =?utf-8?B?TUZWY2hXVDRybG15cFVxY25rU2lrSitFQUVoNjl5UEFkaUtPcXJIano4WFlr?=
 =?utf-8?B?bTRTZFA4Y1JrbVRRNWoycWF2cWNaN2Q0OUdJYU00Wk9wdFYzT2ZKa2hoMW9W?=
 =?utf-8?B?aXBkUkk1RHVCQXBGZHVjOGwzOTBLQ1FLakloNXUyNVNZOEd3eHdiblVIVFVH?=
 =?utf-8?B?ajduc3RaODBuYTJZUnh1NnZXYk5jQi9RL2ZXUE9HelROaHYyNUZNQ3RnMytP?=
 =?utf-8?B?cHVYTmdPVzN0QWlCZUxiSVlUMnpzOWFDclhzNXVsQ2NlUWQyNnBFZU5vd2dD?=
 =?utf-8?B?OG5Ka2s5RmxhUlJvem5kSWI2K3BXZGhxS01vU2taejhyNkVEWG5Pb3NndXN0?=
 =?utf-8?B?REJWTzE4d0Q2dktQcUViQWJNbWxIRzNLVjB1VzJjWExUMGZwV2o1N1FpVXZS?=
 =?utf-8?B?cThXWUxueGtrTXRoalBEUElzWG4zNnRFL1VsNXprMlJDZnlkeGh4UVpjRjdt?=
 =?utf-8?B?Y01SdTJsLzdrdnB3K2ZJSFZoU0Y0cHp5My9FSlArNm1lWkNleVhhOFI3a3Rz?=
 =?utf-8?B?SDdUNGdkc2lKN1BpS3FEOHNNZGtPc3c3MG0rbm9IaVk0YkVuK1FCcTRNTVpI?=
 =?utf-8?B?bk16a1RYWVhlOHlISk5lZjMxOTgveWtoakllaktTcGc4eitpQ0NzbkhHbkx3?=
 =?utf-8?B?c3creW5LU2JQdndJR0l3NUVuTWUyVDYxV044ZlJhTXpHdWZ1dTROeXpaOWpT?=
 =?utf-8?B?ZitSQUJIVmpCZ2lUd21LWmptVTIvbGYwN2duUzF5UGFmdnQxZDhiZTdSb1Zl?=
 =?utf-8?B?TGJVYmM4Tml1RVVid0NmSWoxZFZLZFRSeC9RUjJyMjJEMXJIdlNkSE4rbW9C?=
 =?utf-8?B?U3hFcmJFaHFNUmZPYktCNVRjYUpxVU5EWlJvSEZYRjFkbUx1VHpwZzdBL25Y?=
 =?utf-8?B?YkVXYkp5MmNmanNMbm9vWGw5djZEdTdSRDE3aVpvR3FMVUFaeTZJYXQvVjBD?=
 =?utf-8?B?K3JXUFFTRjlrMjBGNWtmeHFFUFdETWhENWd4Nm1la3cva0RwUXhXbkkvYzNI?=
 =?utf-8?B?NkRGSTZzcy9Sek5DUXArMDl3c3k1SUtMd0UyNDM5aWtzVnRrT2hld3J0bGNj?=
 =?utf-8?B?a1dSMUZCbnBKV0c2QlJoNWU2ckd1QmtrRXZSdmNpZkMycS9qMk1Udlp0S3Jx?=
 =?utf-8?B?VTlkaGZ3RU5SOFVlUHdDeDA5TXpKNjg1bjRnY0VMUHRFOHNMK21QTDZQZ0Ur?=
 =?utf-8?B?N0xmRUh5MVhEYThObi9UUXRLN1RmVllNU0hia0FPTXNERXI1QTVIWWZxTE56?=
 =?utf-8?B?Qk5yMXNvYUpOK1phUEVJVUczODRhWlc2U2RKSGxMbUM3TWdZbWFjbTdreXRJ?=
 =?utf-8?B?TWkrb2VIeks3d1A4UzF3QUdNek8vSzVrMGIxVytXblNLUHZPMnZUYjl2UW1V?=
 =?utf-8?B?bEhpZTZ0TEdnQzFBRkxwR0hxU00xdldrRnF4YkdkNDJkZ1dTSlZIMTluYS9U?=
 =?utf-8?B?ZDEyd3FnMncxT0N2eVQra0NMdndVUTk2WWo1RGhqVjB0aTFtUWJzR1NUR3hk?=
 =?utf-8?B?VW85RTJObHN6aDM0OSs4V0JxLzBCbUw5QUJUaW1LblUwR0ZWdW5HSmtBOVcy?=
 =?utf-8?B?eU9wUU00alFLMjluaUwwVjFTRWhIUmlia3BqSmJLbXVyRDhPbWdETjRSTUxz?=
 =?utf-8?B?d3hiazR1RHIvVCtOLzJYblVWK3ZsR09MaUtYL1VNN21qNmpMaTlwdXcvMGFL?=
 =?utf-8?B?NEtidGVuaUZsRG45WlU2YVNQb1k3RnZqWDdmbVo3YUtPelp2VFk5L2V3dVFa?=
 =?utf-8?B?bDdDeW9wMkNiaU9uZk5tNG1YUzFDd0JKVTRCS3ovVnhDNlhoMUFOTVE3TDhK?=
 =?utf-8?Q?6xuo8X8YUEPgZJIcpGnN3ikqz?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <24E77ADDC3A86E49B8273182344F0AB0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2dbb711-6744-4a12-2864-08da5765ac99
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2022 11:19:02.5065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fMLUxLa07ZQWDZgc3HCsbcgBgMGKuzE4jRBv1oN8WBRZyqTt1jO2l9qgUj/PcXNje2FamndumigD0ulxb+yJ4g9dxkvBUjGOahFtpSJlVHU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1800
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjYvMDYvMjAyMiAxMDoxMSwgTWF1cm8gQ2FydmFsaG8gQ2hlaGFiIHdyb3RlOg0KPiBFWFRF
Uk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNz
IHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IFRoZSBlbnRyeSBmb3Jnb3QgdG8g
YWRkICJkbGcsIiB0byB0aGUgZmlsZSBwYXR0ZXJuLg0KDQpIZXkgTWF1cm8sDQpUaGFua3MgZm9y
IHRoZSBwYXRjaCwgYnV0IHRoaXMgb25lIHNob3VsZCBub3QgYmUgbmVlZGVkLg0KTHVrYXMgaGFz
IGFscmVhZHkgc2VudCBhIGZpeCBmb3IgdGhlIE1BSU5UQUlORVJTIGVudHJ5Lg0KVGhhbmtzLA0K
Q29ub3IuDQoNCj4gDQo+IEZpeGVzOiA0NDE2MTM2NjJkYjcgKCJkdC1iaW5kaW5nczogbWZkOiBD
b252ZXJ0IGRhOTA2MyB0byB5YW1sIikNCj4gU2lnbmVkLW9mZi1ieTogTWF1cm8gQ2FydmFsaG8g
Q2hlaGFiIDxtY2hlaGFiQGtlcm5lbC5vcmc+DQo+IC0tLQ0KPiANCj4gVG8gYXZvaWQgbWFpbGJv
bWJpbmcgb24gYSBsYXJnZSBudW1iZXIgb2YgcGVvcGxlLCBvbmx5IG1haWxpbmcgbGlzdHMgd2Vy
ZSBDL0Mgb24gdGhlIGNvdmVyLg0KPiBTZWUgW1BBVENIIHYyIDAwLzIwXSBhdDogaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvYWxsL2NvdmVyLjE2NTYyMzQ0NTYuZ2l0Lm1jaGVoYWJAa2VybmVsLm9y
Zy8NCj4gDQo+ICAgTUFJTlRBSU5FUlMgfCAyICstDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvTUFJTlRBSU5FUlMg
Yi9NQUlOVEFJTkVSUw0KPiBpbmRleCBjZDNmNDk2NGMxNGEuLjZhY2FlM2EzNDBjYiAxMDA2NDQN
Cj4gLS0tIGEvTUFJTlRBSU5FUlMNCj4gKysrIGIvTUFJTlRBSU5FUlMNCj4gQEAgLTU4ODYsNyAr
NTg4Niw3IEBAIFc6ICAgICAgICBodHRwOi8vd3d3LmRpYWxvZy1zZW1pY29uZHVjdG9yLmNvbS9w
cm9kdWN0cw0KPiAgIEY6ICAgICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaW5w
dXQvZGE5MD8/LW9ua2V5LnR4dA0KPiAgIEY6ICAgICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvaW5wdXQvZGxnLGRhNzI/Py50eHQNCj4gICBGOiAgICAgRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9kYTkwKi50eHQNCj4gLUY6ICAgICBEb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvbWZkL2RhOTAqLnlhbWwNCj4gK0Y6ICAgICBEb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWZkL2RsZyxkYTkwKi55YW1sDQo+ICAgRjogICAgIERv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9yZWd1bGF0b3IvZGxnLGRhOSoueWFtbA0K
PiAgIEY6ICAgICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcmVndWxhdG9yL2Rh
OTIqLnR4dA0KPiAgIEY6ICAgICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcmVn
dWxhdG9yL3NsZzUxMDAwLnR4dA0KPiAtLQ0KPiAyLjM2LjENCj4gDQoNCg==
