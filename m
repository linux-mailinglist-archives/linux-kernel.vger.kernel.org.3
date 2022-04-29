Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5A55142CC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 09:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354884AbiD2HFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 03:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242210AbiD2HFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 03:05:53 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D93B3693
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 00:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1651215754; x=1682751754;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2HpLf809g8IE5FdF67YE9KFcG8GYhgisY1AmYFirft8=;
  b=ASAJpR+JzWKUhD0mDAad4z2kdWT+erIA7DD7BfX3leLI7Rvi+mcrGt0t
   /PRFl1XkMKcp/xz+SC2j2AA7iMucUyHRcVdBuRnGd+QGvM5moxv9bvcR1
   A3PQ+Q2W8StKCXqcgeq/O31SGxV3L4fnh9AMI3sALvbx3jL6zYt3UC+FP
   dUnN5jrKE3NJJVVw+xWzZm4DKN3D2kH89i62Tgwm+GDaV+aVtJhyEQk3H
   TLdm4EIkAyjkGjzDMTvb21ij7A7+lZHPUtbWqXyJ0c/IlzW9VFFhg3nGB
   dQnwvi/f8/1Wtiq9ENqLfo1BxvfXwrWsOtt2X1mE1chWHgDx6TeJVtcXH
   g==;
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="162178905"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Apr 2022 00:02:33 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 29 Apr 2022 00:02:33 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Fri, 29 Apr 2022 00:02:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TiP6/FzfsA72j6vsvDUvxh3393JAGzHgku6pRSC4eHn3b9oEL3N3LB5hufRb/nKZQdHl0+ER7Aso9b+yKD6UQoUv2Lj058IOylKTxIATVV6nIF2uqM21dvZ132eIBECdSuE9aGKh3LY4buKCD3SEmMWXzQZWMML92OC0rPwVAfAvJL5pN1VhMfoqGzQXtQ4fn9XnakV7y1Szt5bVD0TpIIMeaF6YOA/JbIjVFH0j93NRjK4zmrddV/EgPSTXAytd99wVJiKRcy8oSfjbmQQ33LPsU5QUzwIiTiYhBkoBWU0gl08jAftVNzZiQKoFBHTaClGAGdTTlsYJUjngIxbBAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2HpLf809g8IE5FdF67YE9KFcG8GYhgisY1AmYFirft8=;
 b=m55Rh0OQolkJuCv4uqNwfHzzjLmCcqEO383POd46J5eWydzymEKYwcvJ629CtDa+mg2JhQovARbqbvQbFzTkAC5rc8r1awRI6Ur7dVXK/MGEoW9HC6/NYnN3l1Xgl0AuVaHZURsR0+Ysapme0J+VmiivVP1x3sjYSg/4rMgVBU9FUUFsnWePb6QItw51Zgs4wdxtDKN+WDuQnWwOMQvdVkmdUIpsKOc3BDbArWuTBWaZBx2VnMzeVJtve9wvzgsvA56i+TPzhzgAaDtd/Eqh8FRDZAZjPQnGe6aZh8ofqRc4yskFJOQMHFb93nOpc9rJlhebFKDpnsI57D4GStYRgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2HpLf809g8IE5FdF67YE9KFcG8GYhgisY1AmYFirft8=;
 b=G52AkNNOY/DBKD5A/+q1DCgcKt64FSniwrfZvdOvkXoXW4PAD1eU0/EgtgpOaA02ROYQ+rXaGpkSYqAiaEvbwAzRcWasXXvyRMG8VrjcTTN0//zhex6uZ2X/FJ5WZU5rK1VT2dyLcCney9SL6mVWQ4kvsNcI/0M+daY7Eh4wFHI=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by BYAPR11MB3414.namprd11.prod.outlook.com (2603:10b6:a03:85::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 29 Apr
 2022 07:02:28 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::2447:4025:79e6:7c08]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::2447:4025:79e6:7c08%5]) with mapi id 15.20.5186.021; Fri, 29 Apr 2022
 07:02:28 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <cgel.zte@gmail.com>, <richard@nod.at>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <chi.minghao@zte.com.cn>, <zealci@zte.com.cn>
Subject: Re: [PATCH] UBIFS: simplify the return expression of run_gc()
Thread-Topic: [PATCH] UBIFS: simplify the return expression of run_gc()
Thread-Index: AQHYW5cWZmJH0kYqVEGxvvS5h1q2WQ==
Date:   Fri, 29 Apr 2022 07:02:28 +0000
Message-ID: <0de6c8c0-a936-7845-b4ce-51355661e736@microchip.com>
References: <20220429054556.3851784-1-chi.minghao@zte.com.cn>
In-Reply-To: <20220429054556.3851784-1-chi.minghao@zte.com.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 05dcecd5-5233-4d67-ea3c-08da29ae38dd
x-ms-traffictypediagnostic: BYAPR11MB3414:EE_
x-microsoft-antispam-prvs: <BYAPR11MB34144692B2ECA3DDB1FB4ABBF0FC9@BYAPR11MB3414.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /l/hJiB5IUWsfsVX3J8ODi/kqf0dKuvZtasGJ0/IV/zm7mktcy47Gf1IvWS2E1kSG1gnGqigeCOsW/cYfqkBnZXPMQdEpXAoDn1bxpTIuZkvKOmdQiqjTioXPUQRElkqNN8QDPGeTrqp6WfwVEdbd/4AnUFFRkOlEgCrugf1/0p5sJ7e/Ev+JVHVmM4at5KdfaEqid9RUXpo88cLNAELDX3lOEApMASDXFw+OEM/NKWOoswp/4Ma24mfQZZfmFPD7uqDlBxIR7iGz4gb0kGjaUP3cbjYd24NCNvuicqz1W3EuK4Fr9KqbmxyM94aVowtUJ8ryMqb4ZDsFCpqSgaPOWQ/IHKAfMdW9sEcL3fTgOpgLkLoYwcsfMpXt9+1f3nxRhECbVz+QwSuIoz85OJ/Z+TLF0vd6B3TXHzLMK/NmkPeCt16Vo1AoiZpWI47oAiff1FwjOGpWm+BohJb5Dh3pbgWq+3PHD2Wf8mSPBBdA6ysGthYD3SSzH69beWCTyOmNtHVzZKySzu6mcBPxCzSSuFC+SgX20+xv1kW4kLC5ej3nO1O8NuJ5dgN69hMMO1eLk5SLagx37GTrABWtXQ5kEVkUMIGo9BrwzkhuEmd3VVjb6RECdEh+W8a/iiGwHYkUmaUdk3auu4uoewIsySzs1ynX4YgllDsKx7PZfDdJ51eKSaV8Oue4CR78pKSy76AXqMmHHBXhiWJ2yeB0GHh37da3znY9OjJseNTz7iEuUCnbvAurv7Qgb27931XQPDmtfYNi3aKBqukSfDFU9MtmlVcRK3334z+BhlWwFF4XXaYYW8Km68WSz8J6BU88YiBUCMCDWpGuCjaCxETppy+MGmm+KxmzkFt4sIhM6duCWA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(53546011)(91956017)(31696002)(6486002)(110136005)(66476007)(66556008)(66946007)(966005)(38100700002)(31686004)(36756003)(316002)(54906003)(71200400001)(38070700005)(508600001)(6512007)(6506007)(122000001)(8936002)(8676002)(86362001)(83380400001)(5660300002)(4326008)(66446008)(64756008)(76116006)(186003)(26005)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eERoSlRqcEN4OC9lbk1iTTZDYStCRlVhekRIOUhmci9rOFZPSUszTFVQS2dH?=
 =?utf-8?B?OTVhNlJnbXBWeFZPUFBXdndTUWs5ZmRzQnpnaWNKL2tPOUhZRUdqc2hDY3pj?=
 =?utf-8?B?YUZJaFYrcFMvU2hrY2swTEF1MGhkcU1JMzF4QWJzRTJXRlFDak5zVGkvL1lx?=
 =?utf-8?B?WGxFMDl0cVYyMVpDS0pVd2JRaFNmUllLVmdoUWxnaldnQlNLeTc1aGFDOG16?=
 =?utf-8?B?TWNvVHNnZlBHUk85bEVIZTFleDNRZ25HOXg2ZlVYSkJncnpWQnBRTjhsY0tH?=
 =?utf-8?B?Qmp2TmhFTDVvbzcvV0lnM2xtazlJOE92ZzFlMXJGYWxoRlJIN0xxVjVOOUkz?=
 =?utf-8?B?b2dnMUU0QnY4MHNNTkt3RnE4MnB4dkpId3N2eFdDcElpU1dZMGxYSWx5cVJZ?=
 =?utf-8?B?RHE1MzNZVmdQMmlZQnlodjh5anhaWXNodjRCZU91ejdURVBxTnBPUlpIeGx0?=
 =?utf-8?B?NFRPZnZqQVkrWFU0WFlJVytRNWJmMWR5Y1NJM2x2cVFtUUY4bCtSRkpOSmd3?=
 =?utf-8?B?SFl0R2d5ZlBXUnJyazhickYzYlVMMWZuK1ZSSjdZcm02V05RQkFHaUxIdmJN?=
 =?utf-8?B?VlREd3hvV09mbytHR0c2amIrUWwvODJ5UU9LODdGN0ljS1IweE9ueU12amYr?=
 =?utf-8?B?Vi9QRzhRL0gzZE9HTStvQTBBSGxpMnVEUlI5cFRQUmRIQkI0Ulc5eEdIbVhr?=
 =?utf-8?B?T3phcDlGaG1UbWluL2NrcTVBaC9oWGJnTDlDODQrQ2JvUVU4REFDenZtcnc3?=
 =?utf-8?B?bW1XcXFIeXFaQ2ZBc0dyQkVINzdraVBGNjJPSEdNOUNYdXpiYmJBMiszTmoy?=
 =?utf-8?B?bi9vWDNnVSsxdk03a2REcmZtQ1QwTnFYQ053bHd2WGhFNHVDVVIzdVlBbk9j?=
 =?utf-8?B?UTRjRHZ6c1RwMTFJQk94YUVNNnhzUi9uTmtYdWN0eVBPL0lFbFo0Sndscm9y?=
 =?utf-8?B?T3ZGSjZuMXVMTmw4YTY1RGp2cDJUOWM3Y2FpTk5BdUttV2ZlRUYwSjc1eGxn?=
 =?utf-8?B?MHJGM2dzMFI0VGJUQ0doak9pUGlOSEFINTB4SWhoVEpwZGFObVBIWDZnbk5G?=
 =?utf-8?B?a3NuWmdTSUxNOUZTVzZyalRGQzhINlFmSm1vZzNwVU9tVGlpVG9uRXZtR1FC?=
 =?utf-8?B?Ui9zWlVyNFJLWlp2NngwMVoyaCttYk0wcHgxNEo3V0V3ZEQ5Q1dwcTR3dkNF?=
 =?utf-8?B?eHIrQ1FjRVZNYWhPeHBzTWZFQmJUWmp1QWJGUDdHM2drdUxRR2hOTmp1YTlz?=
 =?utf-8?B?T3lhK255TEpjeWg5RFM4OTBTV09Td1NaMGU3ajl0cjEyd1BqMXFRSmtKM3pK?=
 =?utf-8?B?S2QzNGJtTzU1T0JSU01pT0RBS281cDdxME9GcTJ4Y0JpNlhISHNjSVlickF5?=
 =?utf-8?B?TUprd1dXNWhYREVoL1B0YUpaWDNDM1B4cXlJTlh4ZFN2TnNQc0RwTUYwT2Ri?=
 =?utf-8?B?WkM5a09OazBLWjJIMWZGaUkvVmtDTWFYYmIxclo1eXBmUnlPc0NXRktpZzlN?=
 =?utf-8?B?OVVvRE1ST2ZuQUtzVUNRYWRvdzVlQW5xbm14VWVJN1lncWh5TC9IMDc0cm45?=
 =?utf-8?B?MThqaVQyQzRYNlZHWUlQTTNVT0pnbkxGaTJpS0JIUHIveXJQVWpYRk5BN1E3?=
 =?utf-8?B?Y21sRVRicXJLYmRkQUs5NTdBQmg2VC92TGZaeUZ0a1hCd3JnYU9LdGdyV1dJ?=
 =?utf-8?B?eFRjTHFDem03Mlh0STZpMnhXdjBhdGgwdkhrNEZaUlJ4MUpsRlFQZCtvWTdV?=
 =?utf-8?B?TGZnSU5pNXNpbDFWcUxlK2xYa0dUY2NkaDVVeDR3QksxbW1UdUtBb3JkK040?=
 =?utf-8?B?eFBrZ0FkT2FuWVh0UEFqQ0src0JnQU9ndk1MY0NRSExueDArSCsrZFBXL0No?=
 =?utf-8?B?MU5FOUFqY3JMbzlHVDUrbHhncDRHVEFaTlkwUmprcStDcGxxd0JqZGVWdEQ4?=
 =?utf-8?B?VFpaWXRWb3c2d2lEdTJnNWFRdWc1YlJKcE9qL200ZkF5UmxYYi9Pd0h2TExv?=
 =?utf-8?B?TjV1aktmTkJ1djZ0bkQ2Mi9jQVZtazZxcFJvSEJWRE9iRmNCTU1Ra3BEemsw?=
 =?utf-8?B?V1QxQUFRblREekZXdnJSdTU3U3N3amF4dFVVMmVWQ2RINXdielN4cjc2aUlV?=
 =?utf-8?B?R2lSTUhyRVJ4TVg4bVQxTC9JUll2OXl1TXg0ZUI2cmlBQXRWTUhnN3hpZjl6?=
 =?utf-8?B?blVxRTcybzR5ZngzUGZrOEsxY2hxbXZGd3E5cUU1TDQ0Y2tkSWhKZ2hsZlVX?=
 =?utf-8?B?dGtLWDhEbVB6MVBrZzdWNkI3MWo2V0YydW1ZVi92bkIxcDdpeHpjNE1DTGE1?=
 =?utf-8?B?OHRxaUhBZHE2Y0VkWElpMW1sdjlMOUM0aEEvcjZVU0dvZG5lTnl1L29SdTJx?=
 =?utf-8?Q?RIUAabjXzpS4Jpzs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A3A42502DEE8C647B6FA6F74B4D8A8E5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05dcecd5-5233-4d67-ea3c-08da29ae38dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2022 07:02:28.1306
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3BqBciWLe6oxr/cInRnfhQs/IgLc0U6DK/1rc1BRs83DLQ2QPvk+Ez/hh3R38prUmu6bh6yepedIWiSoBhXw9S3gNxVDqK15x75UWywecJQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3414
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC8yOS8yMiAwODo0NSwgY2dlbC56dGVAZ21haWwuY29tIHdyb3RlOg0KPiBFWFRFUk5BTCBF
TUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBr
bm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IEZyb206IE1pbmdoYW8gQ2hpIDxjaGkubWlu
Z2hhb0B6dGUuY29tLmNuPg0KPiANCj4gU2ltcGxpZnkgdGhlIHJldHVybiBleHByZXNzaW9uLg0K
PiANCj4gUmVwb3J0ZWQtYnk6IFplYWwgUm9ib3QgPHplYWxjaUB6dGUuY29tLmNuPg0KPiBTaWdu
ZWQtb2ZmLWJ5OiBNaW5naGFvIENoaSA8Y2hpLm1pbmdoYW9AenRlLmNvbS5jbj4NClJldmlld2Vk
LWJ5OiBUdWRvciBBbWJhcnVzIDx0dWRvci5hbWJhcnVzQG1pY3JvY2hpcC5jb20+DQoNCj4gLS0t
DQo+ICBmcy91Ymlmcy9idWRnZXQuYyB8IDcgKystLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIg
aW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9mcy91Ymlm
cy9idWRnZXQuYyBiL2ZzL3ViaWZzL2J1ZGdldC5jDQo+IGluZGV4IGMwYjg0ZTk2MGIyMC4uZThi
OWI3NTZmMGFjIDEwMDY0NA0KPiAtLS0gYS9mcy91Ymlmcy9idWRnZXQuYw0KPiArKysgYi9mcy91
Ymlmcy9idWRnZXQuYw0KPiBAQCAtNjUsNyArNjUsNyBAQCBzdGF0aWMgdm9pZCBzaHJpbmtfbGlh
YmlsaXR5KHN0cnVjdCB1Ymlmc19pbmZvICpjLCBpbnQgbnJfdG9fd3JpdGUpDQo+ICAgKi8NCj4g
IHN0YXRpYyBpbnQgcnVuX2djKHN0cnVjdCB1Ymlmc19pbmZvICpjKQ0KPiAgew0KPiAtICAgICAg
IGludCBlcnIsIGxudW07DQo+ICsgICAgICAgaW50IGxudW07DQo+IA0KPiAgICAgICAgIC8qIE1h
a2Ugc29tZSBmcmVlIHNwYWNlIGJ5IGdhcmJhZ2UtY29sbGVjdGluZyBkaXJ0eSBzcGFjZSAqLw0K
PiAgICAgICAgIGRvd25fcmVhZCgmYy0+Y29tbWl0X3NlbSk7DQo+IEBAIC03NiwxMCArNzYsNyBA
QCBzdGF0aWMgaW50IHJ1bl9nYyhzdHJ1Y3QgdWJpZnNfaW5mbyAqYykNCj4gDQo+ICAgICAgICAg
LyogR0MgZnJlZWQgb25lIExFQiwgcmV0dXJuIGl0IHRvIGxwcm9wcyAqLw0KPiAgICAgICAgIGRi
Z19idWRnKCJHQyBmcmVlZCBMRUIgJWQiLCBsbnVtKTsNCj4gLSAgICAgICBlcnIgPSB1Ymlmc19y
ZXR1cm5fbGViKGMsIGxudW0pOw0KPiAtICAgICAgIGlmIChlcnIpDQo+IC0gICAgICAgICAgICAg
ICByZXR1cm4gZXJyOw0KPiAtICAgICAgIHJldHVybiAwOw0KPiArICAgICAgIHJldHVybiB1Ymlm
c19yZXR1cm5fbGViKGMsIGxudW0pOw0KPiAgfQ0KPiANCj4gIC8qKg0KPiAtLQ0KPiAyLjI1LjEN
Cj4gDQo+IA0KPiANCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fDQo+IExpbnV4IE1URCBkaXNjdXNzaW9uIG1haWxpbmcgbGlzdA0KPiBodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW10ZC8NCg0K
