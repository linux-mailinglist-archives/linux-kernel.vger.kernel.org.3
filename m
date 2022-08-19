Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551AD599D5D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 16:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349214AbiHSOOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 10:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348475AbiHSOOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 10:14:44 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E374DF11;
        Fri, 19 Aug 2022 07:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660918483; x=1692454483;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8AvWXFSsd38Y/eP+d2A4MGDMD+2NH5aiZLnnSyXNQgU=;
  b=ODYvF0bVxM5Xbi32zHHfbuEfVRhfbMj5FzszHrIAVBVqtYDDEp0bk66n
   RhIgCgkrDHQjhIplBPR3FzeQGaM/fmSTEfWrfIVGDc1MCCYKVJBQFm120
   yaKdO1+XvXQ+e0rGSTWRp1s3ted29YGaUZHoRlB3tZenRznqIZn86GyLU
   MM3kuo19Tf+W5ghtiGT0oVpllbr97PNQX3CnS0aR66cRx2ZMatc+M6qip
   1cBwNBaxnMBzqSQctcqRDVlwy1T5XfyEaEIDhpASgy429EUFffrqbU3DY
   RmhTBROC/5H1oCHJZgjC5IY52KzPvpnUZNsVMN5IS+nfGaV9ugckTyqX4
   w==;
X-IronPort-AV: E=Sophos;i="5.93,248,1654585200"; 
   d="scan'208";a="170044460"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Aug 2022 07:14:42 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 19 Aug 2022 07:14:42 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Fri, 19 Aug 2022 07:14:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ux06+0rowExR6bd0cIjSVBqsXdF/Iw3IzBGUilUTI7wbNQvvKr8vwy+/UiQ7tw7fdskgByhhsDhoeGe/Jip2+7gFHFxhlQCBD62vG1b2YlR39c8WSXTM2jFH1IaV5zbr1aH+weX7REKE2+qHfxxYGr1AmeuS8MR/hZRI9dQYtkNnrJE58euJUsCnjh9Myp1JW87VFZ5tQGqkc1v4ANiItyC9wxJdnZE4qa9eDNBshiMdJv/rIngW/dn9jeDKBmoGts/HRUS0W1vpngGAhaHAHTChKi/d9g3Au+9pYIDYMMvLQFWZjoiBm3T9D01DDg4mwo5yNd3cmF7gcOrXr+xx8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8AvWXFSsd38Y/eP+d2A4MGDMD+2NH5aiZLnnSyXNQgU=;
 b=MpbF6entJ4dQ7QtkfuPtJW+n2lNv39h0PZ9KhRPufm0p9OiMviHyok7VLgosIm/Qcx9QvgRuE3uyg45VjUDBl4P86jTBXsNBlexmBTn9elPkVDeOFxU4IkPHB6rXVlrGo/VEtEn3clg3LKVTzB4l9L/DH0OjjGWkg7CqNEodv9X+2Ro65P2OTTSgqeQxe2QdG/UC4/HzUhAZgWblo7yf1UgbaxKDdT2YiR87zpt31wRgkBYHk/l+ut03zfPCu8mlvUDoouZEDsgBTbl6LFQbMe6sZo+VbV9UgdlixaBFBMqjxCWQuBnbhsj5X+lKAw/acic34N4xchMf1f7KVuINgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8AvWXFSsd38Y/eP+d2A4MGDMD+2NH5aiZLnnSyXNQgU=;
 b=uQ7u01tC41W97yYCIkvDk7+rsRE4ql8VexLtJwJJs0cZTg2J1QePppIKt0NaQdtMssQOYi9zK4uXPW2Uv/i47bQM/7wh5jTnlJSM8NDOWMLvbMOzcyP+1Hv2xKMhyLlmyc8lfI7aOB8+lXu4IoX3kTq7U9II+gzCto7y8cF+UO4=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by SA1PR11MB5801.namprd11.prod.outlook.com (2603:10b6:806:23d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.18; Fri, 19 Aug
 2022 14:14:36 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%9]) with mapi id 15.20.5546.018; Fri, 19 Aug 2022
 14:14:36 +0000
From:   <Conor.Dooley@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <palmer@dabbelt.com>,
        <Daire.McNamara@microchip.com>
CC:     <paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH 6/6] riscv: dts: microchip: add the mpfs' fabric clock
 control
Thread-Topic: [PATCH 6/6] riscv: dts: microchip: add the mpfs' fabric clock
 control
Thread-Index: AQHYs8dCZDCkQVxYIEq9YtBMJX9yKK22LDYAgAAHm4CAAAPOAIAABY6AgAAFKACAAAINgA==
Date:   Fri, 19 Aug 2022 14:14:36 +0000
Message-ID: <f8496006-7487-7b7e-1a53-ec38492dfe70@microchip.com>
References: <20220819122259.183600-1-conor.dooley@microchip.com>
 <20220819122259.183600-7-conor.dooley@microchip.com>
 <3df8d4bd-3d38-cecd-6589-ccc1be01b886@linaro.org>
 <3ffba600-bda9-8ffa-a435-9a6f94e072b8@microchip.com>
 <f3d8be5c-737b-8c71-9926-a4036c797769@linaro.org>
 <19ca2ca1-c678-c669-4214-e92416e37191@microchip.com>
 <138af26e-8e36-63a0-d3a0-5af866318839@linaro.org>
In-Reply-To: <138af26e-8e36-63a0-d3a0-5af866318839@linaro.org>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2b43a292-2da5-4528-57f2-08da81ed257b
x-ms-traffictypediagnostic: SA1PR11MB5801:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rdPILaHnJzqb0QBHcjkI9QJMegDo/37dsmBASOXr6a1Ur83nWxT8IG5aWiDq9iPW1qsPQkwzjJXdbvsGkDUZYJvuKnUPa2xS/mhCafR8FABuRE7KH/kSTxeDbJDSMbxF9wnk0c2d/zzo8TwufqpRcWEpmMi1Da4mxzm34w3TUngb+OBIQA7c+w847hWxQGmC0K+Gaqg4qFcfG15tTSd2TH5ku0Km5X/fHH6MwZ14C691sd9Wk+hQ0QpfrhxtTeiqGoypNNhn5SLowyc5qOCa/jOkJl9nuKg7dfCVOgPUCcYvNzSUIFrbJbJXeOE4SFVd8kDv0wSUUFlK+7cMurGO5jqvqAHkVYnL4bvIirLWxmhlrNNH76vqdwBaC3oqq7BuSkhZYCjLSEsMYBKq2EYlJNtYJ0lfVstlh4nxV5+t0E2dZU7uEUDBSW+KjynFCLZhZdcCDFfy0yv8bsXFb6TZYBNvwNys+06TRsqwPQDA5rGETcp4T11mPwQoEP+X1c1x5FI/wtdY6hs3QFP6OmsMWbJfDowW0afE2QszBBLP9uCqXc7SRh4ubWaamoAx/t69ZYTfL9UhaXvzfT/PNiQx5TAhg6pM0QlKHaoEV2gnBSIWEm9EtUlNgMfalFhQ3NJ/Cvyudor+svoQ/1pM2SgJJffE2i2bdwqwQPYCfTF0Bsign32NGH/ABRhWioVMZBPSDQ/dX8ilU/P37L7oWdgTs0vI3BJAUyh1Rpk7vwiy3OFrhVoc1+41uVDLSzB2z1McRSX1OlZbkjoizh4uVb9YKzvvyqYsEVAbsOKS7CAy1rf1+KroMu7FxedZ2PWiIoOBYelYlRE0mpgjv79uYy6yvQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(376002)(396003)(346002)(136003)(366004)(91956017)(316002)(6636002)(41300700001)(54906003)(6486002)(478600001)(110136005)(71200400001)(8676002)(76116006)(66476007)(66556008)(66946007)(64756008)(2906002)(4326008)(66446008)(8936002)(5660300002)(7416002)(122000001)(38100700002)(31686004)(36756003)(86362001)(31696002)(38070700005)(6506007)(2616005)(186003)(26005)(6512007)(53546011)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QTlRV2lCR05tTGlvNnAza0d4N2o3cmNjYUtYRDdseWMzUE8vTk1CUXFTZTZC?=
 =?utf-8?B?TVhKOXZsOWFTU3IzRTYrWWV1eSttWGZjR3g1T0NBSUtKYm1ac1hzaVhWTnVT?=
 =?utf-8?B?Y09Va0dFNDBMYXlKaG1LZmFQREgyeVY1K3JRUEkwSTZZV2tTYmJwSkFROFFE?=
 =?utf-8?B?SjRoV201RkxYUVFFeWEzb04xRHFOaU84d0pQUU9qRXhwSVhTSlN1bG1jT0Z6?=
 =?utf-8?B?Ui9FYTJUMk5jOXlYcWpZY1FvN2ZIK2lxZUVUYzNuVTBxUUxVQ0F2aktQN0VF?=
 =?utf-8?B?SW5Zay91SmtzWGl4Q0dENDNJSHlWNmdqejIrY0lVVXhxUG1DWTRZelZtQmU1?=
 =?utf-8?B?YSswMjhURzVXRmdCTHRsVDJaeXMySDcrMDJ2YnRzQUU1Z2VvVWpSQzh1Mzdv?=
 =?utf-8?B?emk0c0pVaUkxbEU4cHIyNVhxRkZEekFIN3drN3ZoaXNhV2VhMWNaU0pVQmpj?=
 =?utf-8?B?UGFNSmdUQ1BVeTJWTUJHSHJjRUdYMDZXRUpZNHdhMXhkdlJDQ0JiMWJ1V1ph?=
 =?utf-8?B?SU9zbGd4TGNiY0JhK2lOOWFvMGVIaTZNL0ZvRWI0YWgxUWc5aUJ6bGZIZDRY?=
 =?utf-8?B?RTJ1K0lPRFFZN1QzakZGT2lhZmR5b01wUEIxUkpoUVVUNGN3QzZSRGhxVWFm?=
 =?utf-8?B?S3ZYZUc1cTZ0b2NuOVI5bndjMmhGRVRhYU80WlY1VUJRNEE4NjhrU1dQUVpP?=
 =?utf-8?B?SGx6KzZ5R2FFY3cvR2U4K1hrMFBwYWl4UkkvMjNHdmFEU1Y2WkxIbzkzQ0dJ?=
 =?utf-8?B?SWNoelppY1I1NVRKOXpGUTlxQVpYQ00zK1RLNDBaTlZKQ0RvWHNzUWZ3WEdI?=
 =?utf-8?B?dU5uT1BXWW5LTG9FU2lKUU5aWEpvcEZzL09mbm5SanNKbytZNm9Hc21EVkdO?=
 =?utf-8?B?aXByU2wrWnM4c2lFODdZb1hpR0h5MzV2RVZybll5SnVZM1dBSW1DOElFbWRU?=
 =?utf-8?B?QWJGQk9abzZqdXh1M2txYzI4NHQ5YUNLdFNyeEpGWll2N1hDVjhRVFRPWXRE?=
 =?utf-8?B?UHFRY1dZcklHSjh1MnlsRHl1dFdNRWUzNzczVkNPdGhhQi9aV2ZqTERZMmZq?=
 =?utf-8?B?WGdjdkZUUmNPaTdIMDluT3c2MmxzYUZISUJJY1I1Z2QzeGk1VTNtdU1iTklD?=
 =?utf-8?B?UjRkVjVNL0s1a1RqdWNmUjVwY0s0U3lwRU51OWZaYlpLbWVGQUlIRGhCbytz?=
 =?utf-8?B?cUp3akhSQ21vWlZjMGxCN0hPN1RkVHhBb1NzcENPVkZxNlEzdlN0eXIwR1Iy?=
 =?utf-8?B?b2lyOWdudnZhVGk4Z2NSMng4UnVid2JXTWY3cXljZ2tUZG5CS1pvdHRaamJq?=
 =?utf-8?B?d242L0RoQ1hvMTZ3QmtVb09IL3VhVk9TbHBjMmozUWJtYmZsMzk3c3BXSzVr?=
 =?utf-8?B?aFdod3plT20xU0JoV012eU5DanhGeEtPVy9CNEVzaXdUb0FVR2pVWGpiY2tv?=
 =?utf-8?B?UkZUNG5kRzZRNVhFd2c3TG9EcXJKUFhkbEhXK2Y5MUwyZGdPb2sxRHpua0Qx?=
 =?utf-8?B?d0FIblVMNEE4N3h1UFVESEdUYk5EQ0YyZ21JaVh2VEZvWGxvV3Jyc1VNVmEz?=
 =?utf-8?B?aFJDeXBMRStaTUJZV1ZRRjJ0VTR5ejVnbVZSMXo0WFJ1dTFnOWJvUThyMm1X?=
 =?utf-8?B?ZlNOY2d5dVI5aVZNUDl1R3FTZGxuaTdBVFdqckFtaEsrUE0vNldhRFltWDdj?=
 =?utf-8?B?Ym1FcUhEOGtIeUJaaCtVek8xMHVqakkzbU5LQjhacVp2Tmp2cC9tWkp5anh0?=
 =?utf-8?B?Q1hGNW5nTHNjcUxZWHo5cXI5ZU1aS1BBZS9wRUxDUzAyQ1ZsS00xWG15OWVq?=
 =?utf-8?B?V0l4Z1F5RFZkL1NhV1JQZ29tVk93RnJRd3EyY0lYZW5OdnlJQVVEMHZkZStL?=
 =?utf-8?B?K2dxRXczUC9FSFJrUFpPdEFoZWdVM1cyODhCY2czYzdZVzlLV21zcE5FY1pM?=
 =?utf-8?B?clJUalZ5Nk1uN1B5Z1I1YnlLdXBlYVZvYVNZM01SZVIyYUM4TCs1L3d2L05V?=
 =?utf-8?B?SU9SWU54QndUbk5iNUtmdlNkajFVamVqcHNuckV3T251RHc4VmliV3JtQ2Jk?=
 =?utf-8?B?bTB3TGRneTJpUHI2UThkamdNN0FQcnNSajdVZmtDcE5PeDBQemhOeGdyVWFW?=
 =?utf-8?Q?vkXh+YjgB3dgKp3N+/kRrz53q?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D0CF4B6AA7CB1446AE504CD3EF5A08B8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b43a292-2da5-4528-57f2-08da81ed257b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2022 14:14:36.1949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5yR7J/glkJwgHHSOM+d+C93+q3RotKmdO2udB/qIRACW2o5sgDQZTff2RezDxntAcdVcscjIdl2gmSnm3psphFz+1oYR0xHjbrbzbnatEQc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5801
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTkvMDgvMjAyMiAxNTowNiwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiAxOS8wOC8yMDIyIDE2OjQ4LCBD
b25vci5Eb29sZXlAbWljcm9jaGlwLmNvbSB3cm90ZToNCj4+IE9uIDE5LzA4LzIwMjIgMTQ6Mjgs
IEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+Pj4+IE1heWJlIHRoYXQgaXMgbWUgZXhwbG9p
dGluZyB0aGUgInNob3VsZCIsIGJ1dCBJIHdhcyBub3Qgc3VyZSBob3cgdG8NCj4+Pj4gaW5jbHVk
ZSB0aGUgbG9jYXRpb24gaW4gdGhlIGRldmljZXRyZWUuDQo+Pj4NCj4+PiBOZWl0aGVyIG5vZGUg
bmFtZXMgbm9yIGNsb2NrIG5hbWVzIGFyZSBjb25zaWRlcmVkIGFuIEFCSSwgYnV0IHNvbWUNCj4+
PiBwaWVjZXMgbGlrZSB0byByZWx5IG9uIHRoZW0uIE5vdyB5b3UgY3JlYXRlZCBzdWNoIGRlcGVu
ZGVuY3kgc28gaW1hZ2luZQ0KPj4+IHNvbWVvbmUgcHJlcGFyZXMgYSBEVFNJL0RUUyB3aXRoICJj
bG9jay1jb250cm9sbGVyIiBuYW1lcyBmb3IgYWxsIGZvdXINCj4+PiBibG9ja3MuIEhvdyB5b3Ug
ZHJpdmVyIHdvdWxkIGJlaGF2ZT8NCj4+DQo+PiAtRUVYSVNULCByZWdpc3RyYXRpb24gZmFpbHMg
aW4gdGhlIGNvcmUuDQo+Pg0KPj4+IFRoZSBEVFMgd291bGQgYmUgcGVyZmVjdGx5IHZhbGlkIGJ1
dCBkcml2ZXIgd291bGQgbm90IGFjY2VwdCBpdA0KPj4+IChjb25mbGljdGluZyBuYW1lcykgb3Ig
YmVoYXZlIGluY29ycmVjdC4NCj4+Pg0KPj4+IEkgdGhpbmsgd2hhdCB5b3UgbmVlZCBpcyB0aGUg
Y2xvY2stb3V0cHV0LW5hbWVzIHByb3BlcnR5LiBUaGUgY29yZQ0KPj4+IHNjaGVtYSBkdHNjaGVt
YS9zY2hlbWFzL2Nsb2NrL2Nsb2NrLnlhbWwgcmVjb21tZW5kcyB1bmlmaWVkDQo+Pj4gaW50ZXJw
cmV0YXRpb24gb2YgaXQgLSBsaXN0IG9mIG5hbWVzIGZvciBhbGwgdGhlIGNsb2NrcyAtIGJ1dCBh
Y2NlcHRzDQo+Pj4gb3RoZXIgdXNlcywgZS5nLiBhcyBhIHByZWZpeC4NCj4+DQo+PiBTbyBjb3Vs
ZCBJIGRvIGBjbG9jay1vdXRwdXQtbmFtZXMgPSAiY2NjX253IjtgLiBUaGF0IHdvdWxkIHdvcmsg
Zm9yIG1lLA0KPj4gd2l0aCBvbmUgcXVlc3Rpb246DQo+PiBIb3cgd291bGQgSSBlbmZvcmNlIHRo
ZSB1bmlxdWUtbmVzcyBvZiB0aGlzIHByb3BlcnR5LCBzaW5jZSBpdCB3b3VsZCBiZQ0KPj4gYSBw
ZXIgQ0NDL2Nsb2NrLWNvbnRyb2xsZXIgcHJvcGVydHk/IE1heWJlIEkgbWlzc2VkIHNvbWV0aGlu
ZywgYnV0IEkNCj4+IGdhdmUgaXQgYSBzaG90IHdpdGggdHdvIGRpZmZlcmVudCBDQ0Mgbm9kZXMg
aGF2aW5nICJjY2NfbnciICYgZHRic19jaGVjaw0KPj4gZGlkIG5vdCBjb21wbGFpbi4gVXAgdG8g
bWUgdG8gZXhwbGFpbiB0aGUgcmVzdHJpY3Rpb24gaW4gdGhlIGR0LWJpbmRpbmdzDQo+PiBkZXNj
cmlwdGlvbj8NCj4gDQo+IFVuaXF1ZW5lc3MgYW1vbmcgZW50aXJlIERUUz8gSSBkb24ndCB0aGlu
ayB5b3UgY2FuLCBleGNlcHQgb2YgY291cnNlDQo+IG1lbnRpb25pbmcgaXQgaW4gZGVzY3JpcHRp
b24uIFlvdXIgZHJpdmVyIHNob3VsZCBoYW5kbGUgc3VjaCBEVFMgLQ0KPiBtaW5pbWFsbHkgYnkg
Z3JhY2VmdWxseSBmYWlsaW5nIGJ1dCBiZXR0ZXIgYmVoYXZpbmcgaW4gc29tZSBkZWZhdWx0IHdh
eS4NCg0KSXQgZmFpbHMgbm90LXRvby1ncmFjZWZ1bGx5IGF0IHRoZSBtb21lbnQsIGJ1dCB0aGF0
IGNvdWxkIGVhc2lseSBiZQ0KY2hhbmdlZC4gVHJ1bmNhdGVkIGJhc2UgYWRkcmVzcyBJIHN1cHBv
c2Ugd291bGQgYmUgYSBtZWFuaW5nZnVsIHRoaW5nDQp0byBmYWxsIGJhY2sgdG8gYWZ0ZXJ3YXJk
cy4NCg0KPiANCj4+DQo+PiBGV0lXIEkgd291bGQgdGhlbiBoYXZlOg0KPj4gY2NjX3N3OiBjbG9j
ay1jb250cm9sbGVyQDM4NDAwMDAwIHsNCj4+ICAgICAgICBjb21wYXRpYmxlID0gIm1pY3JvY2hp
cCxtcGZzLWNjYyI7DQo+PiAgICAgICAgcmVnID0gPDB4MCAweDM4NDAwMDAwIDB4MCAweDEwMDA+
LCA8MHgwIDB4Mzg4MDAwMDAgMHgwIDB4MTAwMD4sDQo+PiAgICAgICAgICAgICAgPDB4MCAweDM5
NDAwMDAwIDB4MCAweDEwMDA+LCA8MHgwIDB4Mzk4MDAwMDAgMHgwIDB4MTAwMD47DQo+PiAgICAg
ICAgI2Nsb2NrLWNlbGxzID0gPDE+Ow0KPj4gICAgICAgIGNsb2NrLW91dHB1dC1uYW1lcyA9ICJj
Y2Nfc3ciOw0KPj4gICAgICAgIHN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+PiB9Ow0KPj4NCj4+ICYg
aW4gdGhlIGJpbmRpbmc6DQo+PiAgICAgY2xvY2stb3V0cHV0LW5hbWVzOg0KPj4gICAgICAgcGF0
dGVybjogXmNjY19bbnNdW2V3XSQNCj4gDQo+IFllcywgYWx0aG91Z2ggdGhpcyB3b24ndCBlbmZv
cmNlIHVuaXF1ZW5lc3MuDQoNCkkga25vdyA6KCBJJ2xsIHJlc3BpbiBuZXh0IHdlZWsgSSBndWVz
cywgdGhhbmtzIGFnYWluLg0KQ29ub3IuDQoNCg==
