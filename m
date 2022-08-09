Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7307658DD24
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 19:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245107AbiHIRZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 13:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245351AbiHIRZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 13:25:47 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924601EADE;
        Tue,  9 Aug 2022 10:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660065946; x=1691601946;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zF8V6wf5V6U8R+OwwTOnNdxfGqJ0/ZGWv+yHQWPgA9Q=;
  b=Q3VncK8Tgj95QLFEZT2n7VA/BrupxcE5rRz3qCEpU1x5h/yUUsJIB6rM
   jd4j1d0d7a8O6GrOFAf/XXr8vY41xPsyUX1/jAjGrerb8RL5GTFuujh4p
   2Q/F9J9da+JxR03fG+nrmlfwa2hrc9WDjo7FdJV3PgooMRvSIpexWTVPr
   VvabijR/I8wOYk8mgQdjcEp2FpN4WpbR6/81OUYhxSgwPlU3oC/WYrum/
   uNdUnaVUBUesSXAoN0GLJxC5DdX1/k8fe3ElvyUpY7Wgh3iTmRJmSw/NN
   z68M/7JlXqMSRB0yhWmDsJ+ld0MvOrQIk3Ryk4QtSPZeBRJDcS3T7DJDd
   g==;
X-IronPort-AV: E=Sophos;i="5.93,225,1654585200"; 
   d="scan'208";a="168518621"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Aug 2022 10:25:44 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 9 Aug 2022 10:25:40 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Tue, 9 Aug 2022 10:25:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f87vayD8Hv+zXT5okwlAqKx60rTcJO3yINva0fPuKlQ8bf5pFDrLneMI7XItPB8sLL4xCNd+u0K1vKLNqFe7qkrPFN8dymvqawoiwd6it6FWGzkee4QJtyFX9tOysTYc5MakbQl/mhE39wZ1IOnXFoROzpDPlH2nZocltD82dEw8000V/RS1f9CZjTtHaju1t01gRtAaV+QCx0XnDanMeHVWy9vLFwd6RuvgoudoqND50z+XtSzgU396s0xH/YA/kYpQbeMh/WWVTsPnVR4vEtinYnmEcXP3IgVRGamZnhcPPTCTWYGBUy7XaVtJluzYAA8yzfrNhnlrCGXRCkfR8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zF8V6wf5V6U8R+OwwTOnNdxfGqJ0/ZGWv+yHQWPgA9Q=;
 b=oMT2ULmBmaUmVgNCDy0BmJ1uRD/eEquAW2DllIfK3pJ56+MTP8suS36N3IJT24VFEOvFQ9N+u1Z/BxYPtSCSJFfjDB4Dma6dtnb6pBGu9tSFmi8s4WnNEQKwlAm6ddmzoHhhhsNo/uuKkQGmw50L63XvvEMsH8bbIHzT9/AoI9xUvq5QoP5Gb47CUlygkQvowBjmtoY+Ue/zdVEtpmEtJ759SWL2KbACFp6t7faC1woJrTEYq7fa86pYYAFTLpgjRRSAUP5UEgwoXGOH4oxz6NNKJT+YpwBV4iY/SOEVBHjBHt1MtBAstt5dmqTHHZ00sGYVJC5ZV+Zz4c1MGc0fFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zF8V6wf5V6U8R+OwwTOnNdxfGqJ0/ZGWv+yHQWPgA9Q=;
 b=ktuGtWGpmFUQxp/pMv+5GlMKmtcYqrfzNc4PHnLD1nle0xGV8plZDxuSA9S4/P2yl+6oQoB27+Q+cXvunGzyAqZpv3c3KxrxIjknRqdA9i+Yx+P0+gnAIMqHfShxF7GbZ6PXQnambFIK7J0FSqrwKiYlI6C5dplgP0+3uZsfP5A=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by MN2PR11MB4288.namprd11.prod.outlook.com (2603:10b6:208:18c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 9 Aug
 2022 17:25:29 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%8]) with mapi id 15.20.5504.020; Tue, 9 Aug 2022
 17:25:28 +0000
From:   <Conor.Dooley@microchip.com>
To:     <robh@kernel.org>
CC:     <jrtc27@jrtc27.com>, <tglx@linutronix.de>, <maz@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>,
        <daniel.lezcano@linaro.org>, <anup@brainfault.org>,
        <guoren@kernel.org>, <sagar.kadam@sifive.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <qemu-riscv@nongnu.org>
Subject: Re: [PATCH 0/3] Fix dt-validate issues on qemu dtbdumps due to
 dt-bindings
Thread-Topic: [PATCH 0/3] Fix dt-validate issues on qemu dtbdumps due to
 dt-bindings
Thread-Index: AQHYqOiQvE59vmIAhkiZ1sZQKraNy62li3AAgAAHfICAAQ/4AIAANVQA
Date:   Tue, 9 Aug 2022 17:25:28 +0000
Message-ID: <6b2cd222-49b3-d004-703d-46111d52d271@microchip.com>
References: <20220805162844.1554247-1-mail@conchuod.ie>
 <YvGBYKZyW0B2/wSr@Jessicas-MacBook-Pro>
 <94fe7e46-6156-1cc5-a4dc-1eee78e99bc4@microchip.com>
 <20220809141436.GA1706120-robh@kernel.org>
In-Reply-To: <20220809141436.GA1706120-robh@kernel.org>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7dd6b43d-d3c0-434f-751a-08da7a2c27ae
x-ms-traffictypediagnostic: MN2PR11MB4288:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2QnBAVLX9YmzbS5IxlyFsH3U/7CrEDDbu+tjSeAp7DF+JPj35Q7zHtiAweADIsnnTwI0nutS56UfEQHh0FzEeRmri/teNJizP5yV97xztdFTJZvPhce0NCTR7TaE2E5y2T6dCsnUVnr5DfKiK7PMwEqHXpjBV2vPJr9X34jDksF3oHdsPnYbhTOlv2/sY5Mt0oZIA7u+cviZZg8ZapayAl1HgfEioCT0V8LRQCVi7aHKj1ltKq0HkA9D7VIxeE2soOwEL9Tl8GJQchjDRbLLTmFpa8Q7LtCNwWlKRMF3/0cgF5DSG375oJ1ymd93PjBpJ/5T5Pq3jglWIf91kN51d7OyM6Z1RF47islXXpxtc6BOqwMJKnbqOLj/HvlmCu1MV5a00z/TTnS16Bj3CLScFoFWIezB2sVPvUHzuzE0imxBx4LqkxMMZgl00Nd6eolAqBz4TvZxDmy2CoJUlQCpCXnsOt6PHu9I+Y7W8Ekt3xFZRfL9naMXkUfdk5wVMMmXeqpCYIs9x+BcZYDrLPiQlvWzMy4P24Ezkk9WSWoWJxOXcPbGJb2+qgkFsqrWjOmf/a8nQv1wAiKRcloLinuqwHY+CKeDFW8GspTSHQu8fr4WE0XFBO5qiZ1Xb9Kb6EaMGeMxiAJZovzxEgiZywSBy3Qwr5dUAm9pkYBV/eXQgGOxZDFnNyr9q5+wLEX2nxlMW04B8jB/4cBpoukGDBejDyHsAi1qwvaFFzXz9VT5hYFDFhPc8dWQclZ5aSdQX9hrrjpyI/wMhTfXBdGM/wI35kXIOA4+TiOdKK050VKQ0+VWqv3/XUa++UJwI8QxuM9fmyROGQi4VxlF9RR4nFY0EP0D067lz/amFcGEIStlJ8heMxzpWM0l1/18uiAr+I/W
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(376002)(346002)(396003)(366004)(5660300002)(7416002)(15650500001)(2906002)(76116006)(66946007)(36756003)(6916009)(71200400001)(478600001)(316002)(6486002)(54906003)(31686004)(8936002)(41300700001)(38070700005)(2616005)(38100700002)(31696002)(6506007)(53546011)(26005)(86362001)(122000001)(6512007)(4326008)(66446008)(64756008)(66476007)(66556008)(8676002)(91956017)(186003)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Wi84SFFDcnlVemtMbHFldHpPZ0w4OWlocXRlRmtVaGFoNkpxUmJrYVF3TlNw?=
 =?utf-8?B?aFdJMWFsZ090bG9KWmgyZjlnZEhwa0tTd2svRnhBTDVoMDhTeXg5aFdTUGw5?=
 =?utf-8?B?SEZiWHk0RTEraFpCRzI1RXhkV3hsUWRhaXlZYmoxd3RZa0FtSDN5RE5hQlhh?=
 =?utf-8?B?S1YrNnExbE5WdGxoMWN0U3JmMyt6ZTdZcGJCZlJULzUvdkoxMDhSUENrZnZx?=
 =?utf-8?B?MjI2L2MzMnBzcU9rN0hwQm1YTzE3M3JCSDBvNkNIUUtrcUdaam9GUm5iUDZX?=
 =?utf-8?B?Y1hYNTF2MTJGakhtVm9lL1V6Q1B1OG1ndjV3a1lmbUFLMEtxMWVUZnBlaTM5?=
 =?utf-8?B?TVMxTmZndTJRcU1SU2Z3cjJzaU9PdURGU3BSTlhlaDkxQVYrREtUTG5sQ0hC?=
 =?utf-8?B?a2hQeGZuWk5mRlZiY1FQdHJUdDRmM3A3b08rdFlIY0U1M1VIMkgrN0plajVy?=
 =?utf-8?B?SlhNNkpqZGRsS3pEbVZzQ29nVjQ3bWVlQkhodlU4WHZJWUUxOVorczc4NG8r?=
 =?utf-8?B?ZnZBMEt5OWJTcE5EeWhRME9JcFJYclZRbVBNZXBjdjZLVUFsdWlQTTdtVW1Y?=
 =?utf-8?B?b1BSYXRHTFdsYjdsc3FlbUJmUVBjMWMyeVRzZ0NoSjhWekwwNWJCV2U1Ylly?=
 =?utf-8?B?QmY2Q1ExUG9DdlZqTWYycHRDVTNSVnlRSUtPT3JVMFdlU2kyOFFRVzJibG84?=
 =?utf-8?B?NlVUNkxldTVlaXNPUWVENkNDMmd1NHU1U2lUL3R5QUtVRFU5Z3Vmd09YZjVN?=
 =?utf-8?B?WFRwd0pBYXJKS1pQTlFDeFJTaUlqY2pkZjVSOXFvZVl6a0ZKNENiaDc2cThk?=
 =?utf-8?B?b0R3RWpTUGlWSjlEUTd0TGhsN2tIeWhRVXo5ZE5LVkZuSzBzL3gwZ204TmZO?=
 =?utf-8?B?T2VGVlZWSWFxcTJSWWpZK05TMW1HMUd2K3BKektheFhaNUtiVkN3UDAxdXBJ?=
 =?utf-8?B?VE1vZHA1Y1p0Z3NIdXJtTjVraTRqbWoxU3p2Q1lrVktUcmtRdW1Vd1g5ak5z?=
 =?utf-8?B?S2FDWWpDTktlNTF0ZFlmTTF4TUo5SDJ0cGwrUk5HUlkzQnJYODlOTlgzeWV6?=
 =?utf-8?B?K2lzRmdjaUtMQmNoRUlwMTVmcDVScFozUkZRTDEzR3k5SXFOSXdUMGErV0hY?=
 =?utf-8?B?cW9PemN5R2ZMOUpsOWZqNlUvREtYL0o4T1I4WUl0ZEVvQ1VLem5SeVp3RDE2?=
 =?utf-8?B?UnQ1R2orTTRZWGRvVCt5SElEZEJFSlFwUk9HQUlVd3hhVk4xMTVxN2w0ZDhN?=
 =?utf-8?B?aElZbEtRRkJRbWdjdFhVdW5wcHhJMy9KQ0lyOVpBSWZHUUVQUG9UY1BncmFl?=
 =?utf-8?B?c2tPbWdEQms0TzE5WkRoN2ZZam5BWHFYSEVrUm9VbTZReWFKZFkxTDVqcUI1?=
 =?utf-8?B?bWpZVWJPeWpDU0srSU1NNzJFdElFbzRpM0xlY2tyK1QyZGwxTlE0UnArMTNL?=
 =?utf-8?B?bjd2cUt2bWJ5MmpRa1d2QWtRSDl2R0hWdHdVRUt1a3diUHJqZXU4NWV1MldU?=
 =?utf-8?B?RkZtYlZIV2JVTSttV28rdVNxa09XNldiaTBxeHFHb2tCcHpuTG5mVW0ra1hM?=
 =?utf-8?B?ZkRSejZDTmpPNmN1cU95K3NqMW4vbDFaSXJCVXpDUGRVLzU4ekdBcC84Mm0w?=
 =?utf-8?B?MnlDYUFqVjlrenpncno0VzcxWC9MUjZ6czdvNy95eFpDdWNIK3F0QzNpRktl?=
 =?utf-8?B?STZ5b0pFektaViszV2JzU2xzRG12YTBHVE11Tjd4SlFNdGVaVTBTTnZFVGRp?=
 =?utf-8?B?UVErVkZtUy9uSzNwdVdXUVIyTWZMeXY3ZGx0ZDVuQVBWYUpSNWR3MXJibmYx?=
 =?utf-8?B?TEt2U3JXRDQ1bjY2ak01Ym1UeC9ISXhqTlVvNlhFRWNzU3FaUmJnZ1ZnaUF0?=
 =?utf-8?B?WlRBaHoyMXR2dGI1ZGxCa1BMSkxCeEYwRWhFdHUydFpSeWxuSktvMlFOOXpL?=
 =?utf-8?B?RWExcHdxbGc5eUNRNnRzOGdwRnZxM1hmTGNMSThnZ1ZhbHE0TmZtcDB5NE8r?=
 =?utf-8?B?bWs5dzhFcVhkSENsUCtrSE1kZlZhc2wyZ1U2UWhaMlVHY1lwem5aSVdsL2dT?=
 =?utf-8?B?MmZuOXkrTjdFRnlEWGJsZmZNck5BUVRNTkhPMzhPYzM4UUpMZzcxUzJGVVBD?=
 =?utf-8?Q?uWE15GCheOPgXhQk4JUcThlke?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9515E47006944B48BE9FD914319CA6DC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dd6b43d-d3c0-434f-751a-08da7a2c27ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2022 17:25:28.9084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +n03obmeCaIudNtipmqnaDPVPHsd0Y6cOl/M0bbNiEEu8M+TxzcbeYLF20RG5CUCfObc9Ay74nLqHU+0fOX6ifUOqIXx+pEDpxStHzaXcFs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4288
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDkvMDgvMjAyMiAxNToxNCwgUm9iIEhlcnJpbmcgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlM
OiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cg
dGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gTW9uLCBBdWcgMDgsIDIwMjIgYXQgMTA6MDE6
MTFQTSArMDAwMCwgQ29ub3IuRG9vbGV5QG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+PiBPbiAwOC8w
OC8yMDIyIDIyOjM0LCBKZXNzaWNhIENsYXJrZSB3cm90ZToNCj4+PiBPbiBGcmksIEF1ZyAwNSwg
MjAyMiBhdCAwNToyODo0MlBNICswMTAwLCBDb25vciBEb29sZXkgd3JvdGU6DQo+Pj4+IEZyb206
IENvbm9yIERvb2xleSA8Y29ub3IuZG9vbGV5QG1pY3JvY2hpcC5jb20+DQo+Pj4+DQo+Pj4+IFRo
ZSBkZXZpY2UgdHJlZXMgcHJvZHVjZWQgYXV0b21hdGljYWxseSBmb3IgdGhlIHZpcnQgYW5kIHNw
aWtlIG1hY2hpbmVzDQo+Pj4+IGZhaWwgZHQtdmFsaWRhdGUgb24gc2V2ZXJhbCBncm91bmRzLiBT
b21lIG9mIHRoZXNlIG5lZWQgdG8gYmUgZml4ZWQgaW4NCj4+Pj4gdGhlIGxpbnV4IGtlcm5lbCdz
IGR0LWJpbmRpbmdzLCBidXQgb3RoZXJzIGFyZSBjYXVzZWQgYnkgYnVncyBpbiBRRU1VLg0KPj4+
Pg0KPj4+PiBQYXRjaGVzIGJlZW4gc2VudCB0aGF0IGZpeCB0aGUgUUVNVSBpc3N1ZXMgWzBdLCBi
dXQgYSBjb3VwbGUgb2YgdGhlbQ0KPj4+PiBuZWVkIHRvIGJlIGZpeGVkIGluIHRoZSBrZXJuZWwn
cyBkdC1iaW5kaW5ncy4gVGhlIGZpcnN0IHBhdGNoZXMgYWRkDQo+Pj4+IGNvbXBhdGlibGVzIGZv
ciAicmlzY3Yse2NsaW50LHBsaWN9MCIgd2hpY2ggYXJlIHByZXNlbnQgaW4gZHJpdmVycyBhbmQN
Cj4+Pj4gdGhlIGF1dG8gZ2VuZXJhdGVkIFFFTVUgZHRicy4NCj4+Pg0KPj4+IElNTyB0aGUgY29y
cmVjdCB0aGluZyBpcyB0byBoYXZlIFFFTVUgdXNlIGEgcWVtdSxwbGljWCByYXRoZXIgdGhhbiB0
bw0KPj4+IHdlYWtlbiB0aGUgcmVxdWlyZW1lbnQgdGhhdCBhIG5vbi1nZW5lcmljIGNvbXBhdGli
bGUgYmUgdXNlZC4gT3RoZXJ3aXNlDQo+Pj4geW91IGVuZCB1cCB3aXRoIFFFTVUgdXNpbmcgc29t
ZXRoaW5nIHRoYXQncyBtYXJrZWQgYXMgZGVwcmVjYXRlZCBhbmQNCj4+PiBlaXRoZXIgdGhlIHdh
cm5pbmcgcmVtYWlucyBhbmQgYW5ub3lzIHBlb3BsZSBzdGlsbCBvciBpdCBiZWNvbWVzIHRvbw0K
Pj4+IHdlYWsgYW5kIHBlb3BsZSBpZ25vcmUgaXQgd2hlbiBjcmVhdGluZyByZWFsIGhhcmR3YXJl
Lg0KPj4NCj4+IEl0J3MgYWxyZWFkeSBpbiBhIGRyaXZlciBzbyBJIGZpZ3VyZSBpdCBzaG91bGQg
YmUgaW4gdGhlIGJpbmRpbmdzIHRvby4NCj4+DQo+PiBJbiBhcm0ncyB2aXJ0LmMgdGhleSB1c2Ug
dGhlIGdlbmVyaWMgZ2ljIGNvbXBhdGlibGUgJiBJIGRvbid0IHNlZSBhbnkNCj4+IGV2aWRlbmNl
IG9mIG90aGVyIGFyY2hzIHVzaW5nICJxZW11LGZvbyIgYmluZGluZ3MuIEkgc3VwcG9zZSB0aGVy
ZSdzDQo+PiBhbHdheXMgdGhlIG9wdGlvbiBvZiBqdXN0IHJlbW92aW5nIHRoZSAicmlzY3YscGxp
YzAiIGZyb20gdGhlIHJpc2N2J3MNCj4+IHZpcnQuYw0KPiANCj4gSSB0aGluayB3ZSdyZSBwcmV0
dHkgbXVjaCBzdHVjayB3aXRoIHdoYXQncyBpbiB1c2UgYWxyZWFkeS4NCj4gDQo+IEknbSBvbiB0
aGUgZmVuY2Ugd2hldGhlciB0byBtYXJrIGl0IGRlcHJlY2F0ZWQgdGhvdWdoIGlmIHRoZXJlIGlz
IG5vDQo+IHBsYW4gdG8gJ2ZpeCcgaXQuIERvZXNuJ3QgcmVhbGx5IG1hdHRlciB1bnRpbCB0aGUg
dG9vbHMgY2FuIHNlbGVjdGl2ZWx5DQo+IHJlbW92ZSBkZXByZWNhdGVkIHByb3BlcnRpZXMgZnJv
bSB2YWxpZGF0aW9uLg0KPiANCg0KSSBndWVzcyBJIGhhZCBjb25zaWRlcmVkICJkZXByZWNhdGVk
IiB0byBtZWFuICJkb24ndCB1c2UgaXQgaW4gbmV3DQpkZXZpY2UgdHJlZXMiIHJhdGhlciB0aGFu
ICJkb24ndCB1c2UgaXQgYXQgYWxsIi4gSSBhbSBub3Qgc3VyZSBob3cgaXQNCmNvdWxkIGJlICJm
aXhlZCIgaWYgaXQgaXMgcG90ZW50aWFsbHkgdXNlZCBieSB3aG8tdGYta25vd3Mtd2hhdC4NCg0K
SSBkbyB0aGluayB0aGF0IGFkZGluZyB0aGUgZGVwcmVjYXRlZCBmbGFnIGFkZHMgaW5mb3JtYXRp
b24gaW4gdGhlDQphYnNlbmNlIG9mIHRvb2xpbmcgdGhhdCByZXNwb25kcyB0byB0aGUgcHJvcGVy
dHkuDQoNClRoYW5rcywNCkNvbm9yLg0KDQo=
