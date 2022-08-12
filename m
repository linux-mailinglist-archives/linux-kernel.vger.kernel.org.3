Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0109F59133F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 17:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238651AbiHLPqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 11:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbiHLPql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 11:46:41 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71238A6C0;
        Fri, 12 Aug 2022 08:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660319199; x=1691855199;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=uQAf9NJuw50i2aXJ65FuzSgyrApoeMFBGMQZ3zKeiyY=;
  b=dxkeIxqOLMMsnO5Z89DS0mNgxAfymO98WSmBcXkunsQabvQB5x2iNHgh
   GcaUr+ItgVTQ+fQo4zmd+p/lk2eMSWLweKWrqgAvdE00d4wLzlDpQc8Ys
   SaJqsVxBQvxQXTLlDjVOuYUrZWfDmY31QiLyAfvu3AYYApoKKDZxoMjeV
   acSyWrCecf20TEhLvWqz8CCwNiaTqet36Ipa6QDxAvChgsyNIZ+KXb0a5
   6HEc0Lm+RsK9OlggecpvvvQbQCnFVw5XQenqUjco1MNWW/u9ZunYQjOfo
   +VMtVOzc1dAKBPFkTW6vJ1fYN1Cjtar1CHmFlxQBhGW+NXDZDD/NudaVn
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="169056503"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Aug 2022 08:46:38 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 12 Aug 2022 08:46:23 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Fri, 12 Aug 2022 08:46:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y9y/AJ6t1Z9t5slatCO+0A5B4+Xmyp8AZDB42lIjSWW2kwtjps9+j2274zbf8yiyJ1LflcDiC/6K4suRfpx1wTUyoT8v3i5hJzxlq1gY5plcIuFyynJv0Vnd8qWCnpD9nJbotvlA8+3hxLGa0vczux4VBTTYJLYjuRJY3khC+JtQp1o9OEHlPPmZGPMw41T3Hios11mceItd0OpBwbJDORHT1AKMkWX9msiqXKXwTrcrjvYK405HuOqDOwBc4dhV7VlMLPE4STTBkjy3ci6lVTL4vKGggFxIhtKCh2fIAaMjZLPdtz7n+ntj/+s6N3dTLIPHaBR9svmVWPCiJnkKzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uQAf9NJuw50i2aXJ65FuzSgyrApoeMFBGMQZ3zKeiyY=;
 b=BQ1NHrJfI8BXxW5O8OiCyU4MiJt+xv/zXoteLZNKqI/tQzOyDOn2ben9RSgDXYSZkDwYmJDUe9Bt/1XBV+T85ina2Xhz68H0dtCah6zosmOtkpHWbkTE5xLNQWv5V9a1VbYOXwadHgRwL+IWU0NjAVSEb2gmuJtpwF24Pw9SqQ7zIO9nPtEBR4uYGJZRTVLM1d4bRjxRjy/QHVUlszBXmt79diWBkrUFTHOTv1FrA4GBZPGnuIKgK9RVu0kG23IuKdKw1TPncRN2cR74LsXTN8p6+lqjidJkeytg+E6i9475r1RppnQeF/57+nGUMnX0J0cGfLkbAHOReQ2EIOxurA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uQAf9NJuw50i2aXJ65FuzSgyrApoeMFBGMQZ3zKeiyY=;
 b=WK1kSP8QVmZN/l35N/RBtjuWOJX987ipzyN+95TZ4FXax9iXt0eaEvWseXLjneA96bgtS4u7tCPbQyPDQoP0h7WR+NTlrHWRbeRKCwuTFo8PR/71RmyZNnagMZeKBpnTZy3NFjJUtFPCQg8EJFkxCv4hxCztkmExg5Y+8RlAorw=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by BL0PR11MB3428.namprd11.prod.outlook.com (2603:10b6:208:75::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Fri, 12 Aug
 2022 15:46:20 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%8]) with mapi id 15.20.5525.011; Fri, 12 Aug 2022
 15:46:20 +0000
From:   <Conor.Dooley@microchip.com>
To:     <robh+dt@kernel.org>, <mail@conchuod.ie>
CC:     <ulf.hansson@linaro.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <yamada.masahiro@socionext.com>, <piotrs@cadence.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH] dt-bindings: mmc: cdns: add card-detect-delay property
Thread-Topic: [PATCH] dt-bindings: mmc: cdns: add card-detect-delay property
Thread-Index: AQHYrcFxzXmqZluWDkK6zKWVpeVxJ62rZiyAgAADpYA=
Date:   Fri, 12 Aug 2022 15:46:20 +0000
Message-ID: <46c51365-b4a5-9666-bc3a-24ff833d8fb2@microchip.com>
References: <20220811203151.179258-1-mail@conchuod.ie>
 <CAL_JsqLOGLZD6vrNPqDUqYypkz8xoCPJ4DA4JF-BrG=WHWPurw@mail.gmail.com>
In-Reply-To: <CAL_JsqLOGLZD6vrNPqDUqYypkz8xoCPJ4DA4JF-BrG=WHWPurw@mail.gmail.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aa16e3bb-a2b3-4d50-9d53-08da7c79cd33
x-ms-traffictypediagnostic: BL0PR11MB3428:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TfNvtGfAk3wM8zMSXC6S7xWfeBwTmI9X2MnmYqo6cBYbr4a7KKBWznNGU80Ct0INArSnUkP7djXAcxNinEfVCHCTiJENjOYYz3m1KfiIh+9jpeGZrB5aWYBeRm0IffJa+h0qrncUfw8aTY6SptzYO5pmhRLOXQd/v/XAH784U8hcbpxa3eM66SrL98vmey1ifRJIzbyjfvsKYl93+jt57P4H26hK8vOWwfe2pCnxljsQ0Fvf8VSWRZ4Q1dGHTREfFEwTvxFkCfbsxSayyxkQ6pilzuC7VuMVQS1PgdPZMMOv0k8LzksXLAlTglmYoNUKz+DJX8XqtfIHz7y3RSfaf3deWkkcX+nHY9YZCNTqzI1Hr7c6vy3CNEEvKDeLARZvyS5jiv+DcZaRfIAYlEa2ifrbCYKWo2r6SyPcfR3Me+LabIm4NYdesZuWYbomgMxoNx1OlrJZpKclrBe0vQPruKoTF2mC2XZjcHFTYHudLNDT3cCxq9Vko6gk/fSvD7OtfvLxwrx25EYsIP2lLN6OxNQv+HPF2/ikULbW6UvdKJhtcAZsJ9AvtNDe94viwrx8dudsbRWpMGBqz3OmZXfLf7AIkQIX67eoeDqxEa4KRgNhzr8YDGbFE4o9anFDXoxxXKH0VBnlCGdaXWArK7Kq0DHA/Lh+lyQn0Hd7GeARwgophSyi5d+KnehYoJ55hKUZd7g0EdVpawFoyCWzU5neKnTNDgrrstnn5dXlJUsvOLiG7hQ8EE8CIxbasBhkQLMKXf+swzOAgTI0nVticsjNd+f67qGnXjgqs2ml+Z+mtYiaFEApU6GIxD3yENaxPk6NsPLK0T+2d6MYMMVpG5XKL/ytwfxt5DnVygz/kJQPj4qmTa6aVpFuTGsJ9imrpax0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(136003)(376002)(346002)(39860400002)(66556008)(64756008)(76116006)(66476007)(4326008)(54906003)(5660300002)(316002)(66446008)(31696002)(110136005)(36756003)(8676002)(66946007)(86362001)(91956017)(8936002)(2906002)(7416002)(122000001)(83380400001)(53546011)(6486002)(38100700002)(31686004)(38070700005)(71200400001)(478600001)(41300700001)(6512007)(6506007)(26005)(2616005)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dk5kRGlzS2hYSTBYaHg2dGt0NThpdHRFWEJJVmdyVS9nRDZpTW5lc3YzQ2hw?=
 =?utf-8?B?SWVsNVBIZng5ZTFkMngwNExIallhelJ4ek5xZk0reElYSDJadnh3VWlpTmNU?=
 =?utf-8?B?RTF6amVzSGQ1cmNWdWVsalNvSmpFVGVVdVpsNG9yV1llTDUzb0JwMUg3RHFO?=
 =?utf-8?B?RC9pbGdGT0hRUEY0RlFuMjhSTEpwaTVNcWdIcFVQb3BGTFpyNEZDYXgyTHRh?=
 =?utf-8?B?TDBxV21CTmpzdTNJQU5YNHVaTTZNdEU2VmZVajhqUU5pajAxK0pNeFZRcHVB?=
 =?utf-8?B?WWtnVUYyaG1EdHAyNnFjUjdEeUg3S3FOWXVMcmNVVWpjZGFYQzB4QUpKQ25D?=
 =?utf-8?B?aks4aG0xM0NvRlp4eXNmRDNJK0NOUGpnUjhaUVpEdHZBejh1dVcxczV2QXMz?=
 =?utf-8?B?aFJMWHloQXFoTERic21aL21GT1ROaGUvTFovY1JSTjRjRDNFamxoWUNRRkt1?=
 =?utf-8?B?WUwrc2M0cDBQWVoySEhaWFFxR0xKSHJERUdIQzZxM2RCLzRUOUQyTFR5Q2VK?=
 =?utf-8?B?ak5iQzlkci9lRWg3Z1ZNeXpUN0UvZjAxUk1kRjNjSE1BSEh6TjduTWFZNlBh?=
 =?utf-8?B?SHBsMnhDajBzQ1cvWTE2dk9NbzMrTnl0Q1kwTWNVU2o0Y3o3V0d0VGZiVzlW?=
 =?utf-8?B?U1ljam5OUUY5cTNPbmE4amRwZ2NzbkpQbklXZWsyQlVjRFZSUG9YR1BycjlP?=
 =?utf-8?B?dGZ4RnJUYk9EbXR0Q1pocVUxYVNlWi9YVkExcTlGeEVUVWFtdWp4RkZVNEhr?=
 =?utf-8?B?aDFyNkN2dElTUlIzMmFvbHBZRU1oc2daNjJBOEtOazBpb21oUVRvTG5lQmNM?=
 =?utf-8?B?YVAvaS9IWDNYNGJDWXUvTTVNN1NGRkpjT0xUNTlmVEM1SVByL25OdmdXZjRV?=
 =?utf-8?B?ejRTYUFrSlhqSm9FZS9wSDNBV2U0SnVydWpGMHlQVWhUdDExazNHS3lZTGFR?=
 =?utf-8?B?aGNHSzFBczdjaVhkck1peUFFeWM5LzhSbVA0SnVUUVVzMENpMnhnYU5PbDQ4?=
 =?utf-8?B?Y2Q0SU9XUXE1VEN1MEQ2clRaZ2tLeVdpTDkrRlM5NVhLSkUrTkhpaWVzZlZJ?=
 =?utf-8?B?YWlPWE13Q2FrYnZpU3hUMCtvc1kweHRUMUhtVThjNlpEdTFndnNEZlQwdUJM?=
 =?utf-8?B?ZDM2aXVaMEh2Slhici9JSXBhU2NBbkhIcG4zS1NCdnVjMnlKWjNzMXYwbStY?=
 =?utf-8?B?azNOUEdQQjYyR1UxUTBLYjQwb1JGR1Blc3IxaS9Hc3N2c012Y1daNjdrY1px?=
 =?utf-8?B?UzF4RXhUY2pDOWV4NVB0Q2orM1k3YU9kNWlFVUxubE91T25VT1FLcnJBSkRL?=
 =?utf-8?B?VW1jeGpXRk5jNzY4cUhwK2pEYnVnL3BNbEM0bGUxWko0ZHM2TURsczVHYmU4?=
 =?utf-8?B?c0lOYmhudk4rNnNEVEk5RWFSdzR1L2NOUU9yUWhISi81bmVYcWdaZUthTWlq?=
 =?utf-8?B?MDVVWWJwQUhLVmR2ekRHRTlpRzkrTUs4aUtXY0lxait2ZmdGL1FqQWFhMStQ?=
 =?utf-8?B?T05CQWJJeE94VzV0bTEwSHNrUjQrUHJLekZ3TllHOEVRczkybDJHOVlabElV?=
 =?utf-8?B?aUs0LzF0QXhRTTVickpQQ0VaaEc5ZnYvVXJuLzZZMDlhTisvNTB1OEx6TEpT?=
 =?utf-8?B?eTg3TWg1OVN2Q0ZFS1BEL2UydGpDMUNUSEpHaGwyL2hTT25FVldtZi9aTitW?=
 =?utf-8?B?NElvQWtUTk1NQURyZmswRS9USWZ4VUYvWWIza2p6TXY2VExQSm84Q2dQaUZ1?=
 =?utf-8?B?cFpicE54cnFCNjRQTlAxWXNUNjV4enBlWkpEeGE4OXNCaFZ6ZjVieVB3cVc0?=
 =?utf-8?B?K2NZRi9KM1lUTTZMTzhVdHRia1ljR3hhWDhPR2NvQ0tGK0pmdWNPRzVWTG4v?=
 =?utf-8?B?L2NNanVqOGp1VEVWcEx1QmVxOTNHK2lCd1JxY0pHSGxtaEVLUytid3k1M21O?=
 =?utf-8?B?TDdob0dZWjc4R0R4THA4c0lXSWMzTnZtLzdHZSsrRW5wb0xxcWVTREppVUxQ?=
 =?utf-8?B?QW1mMTN0OVJSSDFPL0R1MWF6KzBySEtFT1VnR3dOaE5OVnRTNis2Zk1tb042?=
 =?utf-8?B?bUZySW5GWFVVTmlpT1Bab2RscnNGRTl5Y2ZHbG5jTStONWZOMWJrWTNjMUJO?=
 =?utf-8?Q?YimjTbUeI6XIVSXMm9XpJ5BK9?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <18633AD899FB4F49BB7224A6212092AD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa16e3bb-a2b3-4d50-9d53-08da7c79cd33
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2022 15:46:20.1476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q+WNgzxKBCTxHqpOdDzhY6rnBx0PoU7Uam01A/SaJoBAN8uME0qCWz/tqMIqlQN3c4jTxR8xp9b8l6WD/FAGkqH4BrNuYo4FZhLY9EGq/QQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB3428
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIvMDgvMjAyMiAxNjozMywgUm9iIEhlcnJpbmcgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlM
OiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cg
dGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gVGh1LCBBdWcgMTEsIDIwMjIgYXQgMjozMiBQ
TSBDb25vciBEb29sZXkgPG1haWxAY29uY2h1b2QuaWU+IHdyb3RlOg0KPj4NCj4+IEZyb206IENv
bm9yIERvb2xleSA8Y29ub3IuZG9vbGV5QG1pY3JvY2hpcC5jb20+DQo+Pg0KPj4gVXBncmFkaW5n
IGR0LXNjaGVtYSB0byB2MjAyMi4wOCBicmluZ3Mgd2l0aCBpdCBiZXR0ZXIgaGFuZGxpbmcgb2YN
Cj4+IHVuZXZhbHVhdGVkUHJvcGVydGllcywgZXhwb3NpbmcgYSBwcmV2aW91c2x5IHVuZGV0ZWN0
ZWQgbWlzc2luZw0KPj4gcHJvcGVydHkgaW4gdGhlIGNhZGVuY2Ugc2RoY2kgZHQtYmluZGluZzoN
Cj4+IGFyY2gvcmlzY3YvYm9vdC9kdHMvbWljcm9jaGlwL21wZnMtaWNpY2xlLWtpdC5kdGI6IG1t
Y0AyMDAwODAwMDogVW5ldmFsdWF0ZWQgcHJvcGVydGllcyBhcmUgbm90IGFsbG93ZWQgKCdjYXJk
LWRldGVjdC1kZWxheScgd2FzIHVuZXhwZWN0ZWQpDQo+PiAgICAgICAgIEZyb20gc2NoZW1hOiBE
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbW1jL2NkbnMsc2RoY2kueWFtbA0KPj4N
Cj4+IFNpZ25lZC1vZmYtYnk6IENvbm9yIERvb2xleSA8Y29ub3IuZG9vbGV5QG1pY3JvY2hpcC5j
b20+DQo+PiAtLS0NCj4+IFNob3VsZCB0aGlzIGhhdmUgYSBmaXhlcyB0YWc/IElmIGFueXRoaW5n
LCBpdCdkIGJlDQo+PiBGaXhlczogODQ3MjNlZWMyNTFkICgiZHQtYmluZGluZ3M6IG1tYzogY2Ru
czogZG9jdW1lbnQgTWljcm9jaGlwIE1QRlMgTU1DL1NESENJIGNvbnRyb2xsZXIiKQ0KPj4gYnV0
IGlkay4NCj4gDQo+IE5vLCB0aGUgY29tbW9uIHByb3BlcnR5ICdjZC1kZWJvdW5jZS1kZWxheS1t
cycgc2hvdWxkIGJlIHVzZWQgaW5zdGVhZC4NCg0KU28gaXQncyBhIGNhc2Ugb2YgIndoYXQncyBp
biB0aGUgZHRzIGlzIHdyb25nIHNvIGl0IG5lZWRzIHRvIGNoYW5nZSI/DQpGb3IgdGhlIGZ1dHVy
ZSwgd2hlcmUgaXMgdGhlIGxpbmUgZHJhd24gYmV0d2VlbiAiZG9uJ3QgYnJlYWsgdGhlIGR0cyIN
CiYgImRvbid0IHVzZSBiYWQgcHJvcGVydGllcyI/IE9ubHkgaWYgdGhlIHByb3BlcnR5IGhhcyBj
b25zdW1lcnM/DQpJIGRvbid0IG1pbmQsIGp1c3Qgd2FudCB0byBnZXQgaXQgcmlnaHQgbmV4dCB0
aW1lIDspDQoNClRoYW5rcywNCkNvbm9yLg0KDQo=
