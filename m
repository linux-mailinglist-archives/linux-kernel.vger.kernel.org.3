Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAF953F804
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 10:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238106AbiFGIS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 04:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238094AbiFGISY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 04:18:24 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6F325E9B;
        Tue,  7 Jun 2022 01:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1654589902; x=1686125902;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=IPRNK8VLD+UQXaufvfThvHxCtUMZENJb1QFmKm2N1Js=;
  b=B9EOx4mmCj9WLQoqMDTB4/krz53ej4tjf159UdCIGKzobzzWP5MluqKw
   /G/wJ3AH7yhXfX4ndi2AOMN/9sukehCZ4UTuXm8sSkFAssXqY2sfA8VD8
   tf/yXuFnVSt1dKv13zukGCx9av+ItPtuj0v6PZDrJpu7EFx/BLBe5sH8D
   Wwetaf63hOpL5YXmDFa7oz4Ll/WmiiM9OmAxcGWuefD8xOEvF66yhxXY+
   y1xqT0ivWji0NWkkN1H+xTPzjLPCU26VQqJPQQ35UfhKe5Fz7Q/ifbn/Q
   Gwf7ysJ1x7/IVUWMik6xVEuNpn0tXbcyFJD38FfhjJnip3xZ/0q+PybKL
   g==;
X-IronPort-AV: E=Sophos;i="5.91,283,1647327600"; 
   d="scan'208";a="167378408"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Jun 2022 01:18:21 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 7 Jun 2022 01:18:21 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Tue, 7 Jun 2022 01:18:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gtlXuy/v94aa619sxrxA7P63WLETRqp77o4ToFeYC5zPyxx5+5+hJIYAjfILjANFXrT7MSQ4xviBKWThASw3dK1e95u/YlV1GNqx3BGyS2uiF+31F9XTciiP2eiKQ0xJ1XkPYBXsx9j5ZDo3SU1oMIXV4yLhMitDOt9lwzKdHLRbFRg8TnCYQCsVhMR5nlgyGMtK8Qe3Xa6sXLA0rqQZePnjRP08heduAPhuYBbArhpIemqfwmrRHVgrQnAOzP3VzlgWYcQzceNOJjlx4B6hC23cN95CeMIru6oI5wz+4xpksR5Gp9psJmvT8Zki0sykknFZqvxBxoSkdjP1IRGLeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IPRNK8VLD+UQXaufvfThvHxCtUMZENJb1QFmKm2N1Js=;
 b=lTH0HkOquREHQ1q0lEKiJFwh/mwo6a1QfP2kqzM43Ol0Fv1aQTSDkKJimctlQfS9Am+oZRPtTKcYnxL8sWrf/2nX/i4ah1xob5LQpFrQMkgzMVX0dX1KEeD8VuO0LfbucpL5ppwqbK8kKc0Vqe++X/qa2+teBAOjEIS6WiLIg27BFS7Ni9lNTisZP31YD3GFWV2A7e7+TPPRm+U9J4/QgmXke+tNQ2dm7O9w/xZwPdTg3xNq6OxHhoCUHIik0iEjYRIdkPXgb1A8Ecqc2x2vR7Fhcgva9CqzYuTItpIlnou7mtA2Iqslzv5CbdxdK4+MX8tBC9oUwPsqw034SQVebA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IPRNK8VLD+UQXaufvfThvHxCtUMZENJb1QFmKm2N1Js=;
 b=Iy3k2sOFmIKwYdIGIXCjWUdortolfbcKwydVOCSvBIwj2/oJNELTufW22Cbt99IiR4mTC7SX/qclxQbQw6IV342LP2AVbmEcPzgyewe9AkQCDZDDg6EmNMOBhdWPOZBOhHbLW8IacC2yM4Ea1G9D9f8M4d63Wni8oTp9Op1Pv/o=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by BN6PR1101MB2194.namprd11.prod.outlook.com (2603:10b6:405:55::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.15; Tue, 7 Jun
 2022 08:18:19 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::8dbc:9dd0:ba2:e99]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::8dbc:9dd0:ba2:e99%10]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 08:18:19 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <lukas.bulwahn@gmail.com>, <srinivas.kandagatla@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: rectify file pattern in MICROCHIP OTPC
 DRIVER
Thread-Topic: [PATCH] MAINTAINERS: rectify file pattern in MICROCHIP OTPC
 DRIVER
Thread-Index: AQHYekcl11mRgfpD4kKOoAltNOk5/w==
Date:   Tue, 7 Jun 2022 08:18:19 +0000
Message-ID: <d4c963e4-6fb9-0035-9421-2a52c066360c@microchip.com>
References: <20220607064220.9296-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20220607064220.9296-1-lukas.bulwahn@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 08c7f23b-876c-4a9a-3460-08da485e479e
x-ms-traffictypediagnostic: BN6PR1101MB2194:EE_
x-microsoft-antispam-prvs: <BN6PR1101MB21944F25E85B7A1A74422AA087A59@BN6PR1101MB2194.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cSlukZBiyd0YoyptY6/pWEPAG9YhNlH1D+H0oEzo6SrpEgyHq4Ol86xGFvJ/yBdK7KZ/A0jIdxvzA0Q9QwdeZdD+KY3XfCAyYyywujjYixaBiSDmPtSJvWUWqNrsFU6t8I+ZVGZCfeGv/voP2EKxXsok8C2es8/GsXNECu4SFH/xgVG9PHfC0jBVN4iJzkt7Fh8OQb9X05W0K/vmzAaIOO/URxvxsX4Dns8nHfPLrca/0p/8fkBmiLF1Edwdp/eWt24lKgXbI9ruJVOgao0jNU/U6XhHLV4Kqs/nlJuTleoE62UU89uxVXA2vntKmjcmuJ4oGNC8VlrbGUD31llGAhUvMYd1gqm1C0DB85xv/SvrzYgKofr63CTLwW13Z6mBGFdbafsRgQ0M5j9ACapg61A2iPPJrsRXEK2kfxbD/EQZKcVJa464XGqhAdQckHrSbahVvRc+mcAiR/W3Xlxz4V8qRgZN+tgzYvC5f5kBMsyyYs31YbCjxPaw2BOqZepbMsUvPtSeMnTpEPPOPtLDx2p2Lx1iJRqMOt+RGlmKSbROBSZrmArDyiUBXr0OKOpMCuE8hZUZ63IW9gj462gMzrdaqPDY1qS39IF6mGq956tyu1IFjyAGX8pVEO5ag318JWm7ZulAypcIMb1J3BfmEnn1cPDJbmqL79S3RMRx26X56BXbor3Cj8oouRi7z84SURHeXRhhfbv+VMnhh+j0XCu59vfi+X3j5j80ktoq/YXGapHa3Cx7G5qPjWO5ommaWJIObifF5LbR2mDNPhhtLQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(83380400001)(66946007)(186003)(38100700002)(508600001)(31686004)(8936002)(31696002)(71200400001)(86362001)(110136005)(6512007)(6506007)(91956017)(26005)(122000001)(53546011)(36756003)(66446008)(38070700005)(64756008)(5660300002)(6486002)(2906002)(2616005)(76116006)(8676002)(54906003)(4326008)(66476007)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SjJ6dEUwVFc3WGpHRnN3RU1ib2xPdGpqZmxtSldOdHgwaG8xWUJabzA0Vkkv?=
 =?utf-8?B?YXM0OE05K0R5cGd1MEp1MnRYdDRveVhBK3A1VFJmK1JiL3pZVTBWYUtGOWF1?=
 =?utf-8?B?V092V1lmWmp2V2hvM0ZwcUQvcGwzZU53Nm16SDRuQkhnSE0xellZNkM4MkJi?=
 =?utf-8?B?NnNqazlRY3E2NFBuUzNwT1hPV3FOcktzaXRrNlQvSndYZUxIQW9nb1NqcUlu?=
 =?utf-8?B?OVRBaGtXZ1dDZXMzNGRqcXY3SGhheGJ3a1drRFBLZmZGQ3IrdXJBb3hFVm5P?=
 =?utf-8?B?UXNFV3N4UmF3Y3lJYklJcDZTbkFIMFFiNFZOZHNPMVhlMUU5RzVhRWgyck96?=
 =?utf-8?B?eEVuMGdPQ0dYTFJiUlB5Q0p3ZHlRZEVkZ3NlZGlveHpiQUo0SHlDbGl6RXlM?=
 =?utf-8?B?NjVOWXdxcjFFTnRmNWRQMVB4NGE3M1BYZnBTczRKMjR2OGt3VXpNTzZKcGdx?=
 =?utf-8?B?dDlob20xUysya1dISDNXRjZGVldibXppUDUrTUtiM3FrYTk3Ti96OXg5NW9v?=
 =?utf-8?B?SlJIUUdoaXd0OE1BWXNLR0lYMXlKalZ0OXNVWFhrQWVoSXZzVnBIVUtCZWpU?=
 =?utf-8?B?MVRKQlJvWnEyOFJKeEhsTWZ1VCtLM1B5MktuMHZXZ2dDd0dMMUpYZzc2c3Z0?=
 =?utf-8?B?djkwU1l5ZzcrWVN6dnVhaDllV0puMHV2bjFTWHhUR2JMckNMMUMzd1dJdm5x?=
 =?utf-8?B?TVBLMXNqalpicjRhL2ltcUVHUitjc2lka1NBV3VZQWFBc0I1TWpVd3ZxUmJ5?=
 =?utf-8?B?WHl2S0Z5SGFYaVdNd2x0bWtsU1BWdnNPcDErb244MHRZUkcrWXNzUjRhc0VR?=
 =?utf-8?B?THAwa0R1WTlUQy9DTlVPSGtqelJrWC9xM25oSEdxdjdpZlNoMXZmeUU4Z0pH?=
 =?utf-8?B?eGJnN2Rha2dHR1dlQndFY3Z2dDg3QUJnRGhvdTJCeUZaWlNPN3c2NmFoN1lh?=
 =?utf-8?B?RVJpN0R6SHVFODAvQkM5VkpBUlBCcnBkRXc4eWdjbk1FcWwzTnE1MVY2M3BD?=
 =?utf-8?B?V3ZXd09LL3VOK0V4L09US1IxelVMM2tHc1BmM21NRERENkNOUy9ydWNtSG9Y?=
 =?utf-8?B?T3g2SGIvWVQyeXZLQTFhajg0MXJTS0dsTkM2N210RHArWUh4c0haMVhPeUNO?=
 =?utf-8?B?TGhvMlp5Lzl4WkRkYlFiZVhRMS95d0VxcEFaZ3F3cnVRMHhMMVV0N3V5Y3p2?=
 =?utf-8?B?WStjQUJaUGhjY3RGL3lsMUhkN3EyV0JTY3I3QVVqR2hTWjhzalBVYy9DZXdw?=
 =?utf-8?B?WWE5UHZMY3FaM3BvYm4wVjluMDRjQ0dhclMwSVFWZkRqZzFoSkNVWG84NFV6?=
 =?utf-8?B?UWxDSnhNMS9yeHRMVW1IMVpPbDZDTlBxeHRWZ2VJekVFS2VsZnNtcFZxTjZK?=
 =?utf-8?B?T2V3V2JnVVA4Sk9GeVZDV04yZ09tUStWSFA5ZUdZKzBOQVd0WXBSNUpUSWht?=
 =?utf-8?B?ZTM3TnRDOFJMckQvalA5ZU9TaWZUckJHMHFzL1laVkNJNHZMNm1XZHlLcFZM?=
 =?utf-8?B?dElwMExnSEkzd2k3L1lJT2VsYzhFMEZQVDFsYmFyaVo2RWhoSlF4OXFZSnk1?=
 =?utf-8?B?ZmROUEtmNzJQQTR6TG5PaFdLUlNWZ1ZLQzU4L1VzOFI0L2VmekRpSWJxb1Ju?=
 =?utf-8?B?R2JEcVd5eGkvS29vdVpKc0Z0bW1ISU5vUGI4ZzZYTU1zVjlMdDdwRTVzRVJX?=
 =?utf-8?B?a08veWpSTTlIdG1TRnlUWkd6bU1SOE45VVhkVklNWGd5djBQdlFQSitGTXZV?=
 =?utf-8?B?OFJjeFRMdXZOcG5mQldENS9HVDR2QjFDMEtsNm56NmpKSDFXZ2hMWU1ESnlL?=
 =?utf-8?B?T1ZmSEk4WEN2aThDUUdHeEpVODN1SUlyR2N4R2RFaCtxeWVVWGtuQkRiRXVn?=
 =?utf-8?B?cmt1YTJVR3B0QVBoaTFIYzJkVWkrdkUvZnphTGt6bjhvdUc3NGpNeG1RWVR1?=
 =?utf-8?B?aEt1Y205SlpBMlp4UkhQdUx0dEhZcENQYU9abndvOGxSZU9aelRHL0ZOSWhw?=
 =?utf-8?B?WDlObXMzaWIrcUZJZTlBcWF0ajN2R3ZCRkRnNEFnSEh3cm9TRlJ6MFhOVlBT?=
 =?utf-8?B?QWRwU1l1RGlwL3dlQTVpVDZ3Z2RzWnFOS3lha2p5MjZvT2ozVzhLcmpZeldx?=
 =?utf-8?B?c2xxMjkyVUdHQ0UvK090ZUhOYzJOOEliMGJ0bU5mQ09VYVRmaFlPMXBrc1g4?=
 =?utf-8?B?TWJwWXI5N0hzUEkxdmhQWDJQRDljNGRXcFhkZFh3SkRnVzVwd2E5dmtZRjBT?=
 =?utf-8?B?M2VEek85bVpxMVpmMEVxbjFSeHhMQ1A5Y3pnRDB3NjdYN3RNQlBTOFBFUUpZ?=
 =?utf-8?B?SFZUdS80WWRQQWUrTCtwZTFSVzNNSS8xVGhzSjgva2Vwc2VkejgzWThDV0Jr?=
 =?utf-8?Q?RXnm7TciM1v6KF3k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <56F269CCEA19054CB99F79DEF906BF86@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08c7f23b-876c-4a9a-3460-08da485e479e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2022 08:18:19.1710
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vAXuwGlTUj95FuS/oKnk7Rmzrf9fmRPPBy2Y8bCJoYWppgdWSiGKxdMH1SL/0Pd54KcYHwcnyAd1SEuFNvnZbvj862jsB+dpGDDVawKhBBI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2194
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDcuMDYuMjAyMiAwOTo0MiwgTHVrYXMgQnVsd2FobiB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBDb21taXQgNmIyOTE2MTBkZDU3ICgibnZtZW06
IG1pY3JvY2hpcC1vdHBjOiBhZGQgc3VwcG9ydCIpIGFkZHMgdGhlDQo+IE1pY3JvY2hpcCBvdHBj
IGRyaXZlciBhbmQgYSBjb3JyZXNwb25kaW5nIE1BSU5UQUlORVJTIHNlY3Rpb24sIGJ1dCBzbGlw
cw0KPiBpbiBhIHNsaWdodGx5IHdyb25nIGZpbGUgcGF0dGVybi4NCj4gDQo+IEhlbmNlLCAuL3Nj
cmlwdHMvZ2V0X21haW50YWluZXIucGwgLS1zZWxmLXRlc3Q9cGF0dGVybnMgY29tcGxhaW5zIGFi
b3V0IGENCj4gYnJva2VuIHJlZmVyZW5jZS4NCj4gDQo+IFJlY3RpZnkgdGhpcyBmaWxlIHBhdHRl
cm4gaW4gTUlDUk9DSElQIE9UUEMgRFJJVkVSLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTHVrYXMg
QnVsd2FobiA8bHVrYXMuYnVsd2FobkBnbWFpbC5jb20+DQo+IC0tLQ0KPiBDbGF1ZGl1LCBwbGVh
c2UgYWNrLg0KDQpBY2tlZC1ieTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3Jv
Y2hpcC5jb20+DQoNClRoYW5rIHlvdSwgTHVrYXMhDQoNCg0KPiANCj4gU3Jpbml2YXMsIHBsZWFz
ZSBwaWNrIHRoaXMgbWlub3Igbm9uLXVyZ2VudCBwYXRjaCBpbiB5b3VyIC1uZXh0IHRyZWUgb24N
Cj4gdG9wIG9mIHRoZSBjb21taXQgYWJvdmUuIFRoYW5rcy4NCj4gDQo+ICBNQUlOVEFJTkVSUyB8
IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL01BSU5UQUlORVJTIGIvTUFJTlRBSU5FUlMNCj4gaW5kZXggNTcy
ZjUwNzM5ZmIyLi4yODgzOTM1NjRhYmMgMTAwNjQ0DQo+IC0tLSBhL01BSU5UQUlORVJTDQo+ICsr
KyBiL01BSU5UQUlORVJTDQo+IEBAIC0xMzExOSw3ICsxMzExOSw3IEBAIEw6ICAgICAgbGludXgt
YXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnIChtb2RlcmF0ZWQgZm9yIG5vbi1zdWJzY3Jp
YmVycykNCj4gIFM6ICAgICBTdXBwb3J0ZWQNCj4gIEY6ICAgICBEb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvbnZtZW0vbWljcm9jaGlwLHNhbWE3ZzUtb3RwYy55YW1sDQo+ICBGOiAg
ICAgZHJpdmVycy9udm1lbS9taWNyb2NoaXAtb3RwYy5jDQo+IC1GOiAgICAgZHQtYmluZGluZ3Mv
bnZtZW0vbWljcm9jaGlwLHNhbWE3ZzUtb3RwYy5oDQo+ICtGOiAgICAgaW5jbHVkZS9kdC1iaW5k
aW5ncy9udm1lbS9taWNyb2NoaXAsc2FtYTdnNS1vdHBjLmgNCj4gDQo+ICBNSUNST0NISVAgUFdN
IERSSVZFUg0KPiAgTTogICAgIENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBtaWNyb2No
aXAuY29tPg0KPiAtLQ0KPiAyLjE3LjENCj4gDQoNCg==
