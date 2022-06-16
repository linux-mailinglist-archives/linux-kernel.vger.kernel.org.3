Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96FD454DA8A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 08:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359176AbiFPG0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 02:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359157AbiFPG01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 02:26:27 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB1254F96
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 23:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1655360783; x=1686896783;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Nb89pH8h9wR0WLVhKBI6AK9AMbHSM++P7/ERs4gA90c=;
  b=xB7/wamyH20pzFfWp5NenGruO5TP4OKk642sSOEhsHU8GOmHO5HfRGPg
   RGjZSYgt3SUz5BLXtYsaSEEYker+q7zzwFF4o2+KojfTkHJQIWLywA4Js
   twbAI3BMw6KBnX324rX/YBrVBYbnpPIcRKhl7RcxQxqzSD/1B0UYrtssy
   pdVtMY0g/XtVMuCUknGPUGkUThlxbua6Rh96Ts8vOvrQ+C0dyljbpH0U3
   nSGX581zi/f5eErMfnyyJ/nD8NBEgKHh2AKxiUSY7zcTJ8AyCfj41xRyL
   adBRyk/PAc87XVT56dsqB2yKbA9y64RpyH9h5bm8m8MzmPFy/0EFAxmhh
   A==;
X-IronPort-AV: E=Sophos;i="5.91,304,1647327600"; 
   d="scan'208";a="100274952"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Jun 2022 23:26:22 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 15 Jun 2022 23:26:22 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Wed, 15 Jun 2022 23:26:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B+hHQH7iD06r4LSf9JmZUrtgsMrQri6WavF7Tc8wS8140Tpt0Xtb0GhmZFOx3Sj7QjWTYQEF3nJEsM6+1GEBbTQSG8GireDk3fr/ckS5Tt+3aC62gk6xAOF5vQzGLoQEE6cfD77WTAtqmkiVUHOal7O3b0XqKSzKaQkmwcttz1za9G/nj6poZLyxV1lYMkWvU5qUhnTEJi0unnoWKIWr0LgD70e6FoB3druokxtinWocozdrTa0iaeL46CnpHUYzD2Dvzu3j37/80qYnFB5Eosj2ukuMKSgAIjyq1mRxkDmm7llTC2oXJfvDOfm9bRP2tnzTzdzC61zF9Sa/+y7AAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nb89pH8h9wR0WLVhKBI6AK9AMbHSM++P7/ERs4gA90c=;
 b=Q+avsluDceGaSfTclguzlHgYqDLWFzNwnF63TmBPfkit4VY1cJPOxzIkzRviICeTo+1wMY2+YqGvp+f7aX4JZoww+b5lCpJ4BhyaUcb/YDlviFeuvaEU0B1j6/XrYiKvFGFk+bkzx++kFbEUA8t8eQ0D9rqZwmQ3BiNlPxVFGYeHbnpapnUt7RdCjcaOR96e55JNUBc6rCj+XJiDakYi+ghkbDb8Bs9lLmF7ZqkZqeoIL2PM4EXMmf54GN8N2oXS8jtRag7IeLQGZf+oXivvWsIjs0oSDo8K3SDqrEKuIvF6u6wxc9+fFAqTOtBBvu4A4K0+lhlnx8hJ1K3lWiL14w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nb89pH8h9wR0WLVhKBI6AK9AMbHSM++P7/ERs4gA90c=;
 b=vZwbt/lDD6OfyVHzgTyZb3ZlbqqpGjgDFSWLqKjhj+FCv8mZBnOsnu3RRaciYh4JVfMGbe8Q5xrriAvTB3Lw+aergi1lKYRie+vWLCssAaDIYsn5SwkTQ9x4wZyDZ9lIT6viEa7OHQmmxyrAPA99mfu1bYwDN7PRClmSA+zPVuw=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by MWHPR11MB1678.namprd11.prod.outlook.com (2603:10b6:301:e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.17; Thu, 16 Jun
 2022 06:26:17 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa%4]) with mapi id 15.20.5332.022; Thu, 16 Jun 2022
 06:26:17 +0000
From:   <Conor.Dooley@microchip.com>
To:     <windhl@126.com>, <palmer@dabbelt.com>, <paul.walmsley@sifive.com>,
        <aou@eecs.berkeley.edu>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <lkp@intel.com>
Subject: Re: [PATCH v2] soc: sifive: (sifive_l2_cache) Add missing
 of_node_put()
Thread-Topic: [PATCH v2] soc: sifive: (sifive_l2_cache) Add missing
 of_node_put()
Thread-Index: AQHYgUn8SukD6dFAFUCiRY+y1/CvAA==
Date:   Thu, 16 Jun 2022 06:26:17 +0000
Message-ID: <fe1c23cf-dab4-d926-ffef-7a8a5489a071@microchip.com>
References: <20220616044915.3978097-1-windhl@126.com>
 <28cd6700.3e2d.1816b13f1fa.Coremail.windhl@126.com>
In-Reply-To: <28cd6700.3e2d.1816b13f1fa.Coremail.windhl@126.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3add941a-fec6-4aea-d603-08da4f611ebd
x-ms-traffictypediagnostic: MWHPR11MB1678:EE_
x-microsoft-antispam-prvs: <MWHPR11MB1678CD0D65F24F894D13AD2698AC9@MWHPR11MB1678.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X6ddQ23vmqHrnyaPmQ77slmrkfnN/AkBNer75usAtPSRltquJ4CeRxUbrVjMLdlk4xmD/g9XfduzWWuVpN66tBsjK/2+yRE7RIHShdijWClmNHfJ65/TAEPSkMJ2peIx4IZvuGjmAK4Cqfndz0uV88BeCbTkexDxl0y7TlH3q0wEazOomQHhyXHs0Aqclf2nRsa3XXXUB8PvedFBcG7TpOCQOj4lAbx0dzQCNeZu9ij7h3NtIRet2rFNW3Pt8XQRkln9u65d6+naZAgsahRiX85DfN78DVUWvMpSCwQ24xQOLEM5iInMtAauZHunfSFtewuG1pJkHxfI04PS49qmMme3CSPGrZH/rc27IlWIDY7jRt1Nu4xd/fOSoXCQhES3UnGduJ30emv439dp8pljb9KcTidOu5icHBQCW6Li3s7TyL2ljYjcsytv41o7QKCpsTtdZmHJIMjgmFjylVvpfIJV0T7j0TAzTXvf62ROTy2Ib7vI1UmPfwu3Ib+GVQ91ZH6k4eQeiJjJmoYu7X1NCjd/OG8AshtwGbB2JOdee0uz0o9uJnZvpYqVz4w0Jsfi5EIptEj9k59W8kDXMi5vI7czHD+VRB4n2ZT8FKHBZaIfQtxAc3uynvCU/49OVcrZpuQx0aSeFT1k1E8XEa04R6d68NNnvYbiuIMZ54UYrnUhC6+ufVdJLrbKeuohPR05TzbZFBn4zpJ8rEcX8e61MfdRKrJqSENSTu7104WA78/yAgyrV59Ek0z/NscLG64yS8mosQpbRqqZhvd13bHyBw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(4744005)(5660300002)(2906002)(8936002)(31696002)(122000001)(38070700005)(53546011)(66556008)(6512007)(36756003)(66446008)(8676002)(64756008)(508600001)(71200400001)(6486002)(38100700002)(4326008)(6506007)(66946007)(316002)(76116006)(54906003)(2616005)(110136005)(186003)(91956017)(26005)(66476007)(31686004)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OGpSUmJKQWpvOG9vclNHRXl6bjNocDNxNEYzcnRDazRrMWNwR2hhb04zei95?=
 =?utf-8?B?L2ppTlc3bG5yTGtYWjdwTURkNzFpaVlhckp2ZGVaUk9aZnlpalhPdWg5Y3Yw?=
 =?utf-8?B?RHFlMGVMVTBIcVdjSm9ONnAvd2VHYk1xRk5nVTVyTDM2UHlmUjdhSm8rYXNh?=
 =?utf-8?B?TzkyM1dURGd0MEx4R1JXaW1nUFRrV2IxbDJGb3pqZlFCZ1FsY2pqTHF3Z2pQ?=
 =?utf-8?B?NXRHdHM2RW9lcEQvbDNTWE9WKzRrKy9qWlZNbGowRnhRTlpoZ20zNWJKQzc2?=
 =?utf-8?B?SExYdkp6T3ZDSndQSVpvTThNays4L0VYbnJ1V2h3aTFPUmdNZWFjeEJ0azZi?=
 =?utf-8?B?Z1pXMU1Lc2ZHdGdiN1hFMUptc2hHNWpDSGFkZVhGVVVMNGtNd3ZlenpYSGNn?=
 =?utf-8?B?SHExbS8xNmFtOTg2bjdSSTM0dDhNTDk3aStNWW1KL05xek5OZldWSFNXbWpk?=
 =?utf-8?B?bkE5d09TVXFtOXFkZ21HckU1a2JTZVU1dU1VNEpkcXRhTCtKQWVFUXJPRTdy?=
 =?utf-8?B?NFQ5K0x3VGo1ejIrY3ZRS2ZaaXJBRFQ3L2Y1OXdZU1FXMjN3L0F2cmcvZkcx?=
 =?utf-8?B?VWRuV01NVFI3L1JHM0UvL2ptd3NEbTZMUGVrS1MvVWRMa0k4b2o3MXhKd3pj?=
 =?utf-8?B?M0RKZUNOSzVjRGMrU2xTanFYVWtZdkxYeFFTUWxsdVJxcVZVVU1GUkx3SGVr?=
 =?utf-8?B?ZVdrOFZ6N2ZGeC9QOUZrU2RZaDd1M2c5QjV0L09HRlhaWWRCL1pwRXVhUlE4?=
 =?utf-8?B?T1MyTitHNmQ0eFY0ZmxyN3VmOXBDbXVrZ1lpVzRkeENhclZPQWdJVXBiTTVr?=
 =?utf-8?B?TnVkMUFoVnByRlpGY2tzS3BOL21uNWQrV0xoZDh3R0l6RktZS0k3cGVFM05a?=
 =?utf-8?B?a1BTVkpCRGE5eWM4dzByY1l4M2wyY3RVaVo3SXN3cWIzcmtmN3h3cE5zeUtv?=
 =?utf-8?B?R3lsUURFVXplS21sNEZ5UG5JR3p4bmRqdE16OVFxNXppKzB2aHAra2FkVzNX?=
 =?utf-8?B?TExPZmlCeGZNRVFCc1VXZGRRaFhpamlsOWxFNEFhV0JuUWFycmk0bG1jRmF4?=
 =?utf-8?B?WEJOVDdpdGZFNm9EeERBYXNJS24wckdVRFNYMnFJNy9lTDZCSy9RM1h2VFVX?=
 =?utf-8?B?dldXaHZGRytLZWJnWFFtRys5dGh2NHd3R3lpNU12bTV3bnhvZG9hOTEzK0Zv?=
 =?utf-8?B?TFZNSjRhQU5OQWVMK3pQUGJHZXRLMzVVTUZ6MjZBc0RCK2hjaTJvSEpSNnhp?=
 =?utf-8?B?bVUzci90NncrY2w5dnBpbnl4emxZeE5qMG9BaVhla0lUOHI0UzlWaVp6dDBh?=
 =?utf-8?B?dzZHbWxzNkNMV1hjQ0FxNjlydGZzUG4zMUxicTVvSUtJZnZjWG5RYlBqa1U1?=
 =?utf-8?B?dzFNS0JZS1cva1lhcWdESEV5YnhrOTQ0MG9uM2RSTkFrenpBWFVhbnRoOWFY?=
 =?utf-8?B?ZTFFeW5zZVhXMDgvYlNvSHZiSWpMREY1b3ZDaENodU1KRWZ0NnVLeFhLYVJV?=
 =?utf-8?B?V3FYV0sraU9wbGxnSW96aWdKWkFXWmNpYkNONDREbDREWkJIZVBXYks4cGZU?=
 =?utf-8?B?L1duRHNmemMyMWhSUXZ5ZTFqOFVLVWtyMzM5UEZ6RVFjVVVkUEpqbTI1blFZ?=
 =?utf-8?B?VHcxODBBeHIrQkNoS3FSSTYyOTZWclJkNVZ6dnVkSjRPbndsS1ZjcXVQemdp?=
 =?utf-8?B?N3dWY2JIcDlMZmlFV3l6WlRvSC9COWs3K0UvTGF6STc3ZFAvMVY1RkUxYUc3?=
 =?utf-8?B?elMzdkUyK2Vqek9qNU5McS85aUFBamdaNzVJQWljMDBmWTcxOEdIaXVyeUgw?=
 =?utf-8?B?WDRQeHIyenVoTXNRRllzVXlEaTFSVmtjdy8ranRPb0lHRUNxOEtwdHY3RU9M?=
 =?utf-8?B?RXljbWZEa25EL3p1REpwVWpsOU5SOGRiekpMMmpDdHZRa2NDMFZTV2tCTnF2?=
 =?utf-8?B?STBCTHQ4UHJxRE91NGZLV2lFdFBKSWt1UmZkUTlkenVTMXFJVkNnODlyTExI?=
 =?utf-8?B?N3BqNmE3K3ZNN3VwQlgxUVhOTWlFRHlRZ3dvZUhhb044YWZ6QzcwUXNiS3N2?=
 =?utf-8?B?QjgyUE9BMlNtTmIwT3g4R1dtdlhud1NXcG1kZWJrT0NZZXBEaEtjcUhLMERE?=
 =?utf-8?B?T1VKMUorK3VTQTArOUswWlJvOURMKzluVjczWUdxUnB1UGxuREwvUW51R1pu?=
 =?utf-8?B?SDdIQWRsbW5qTEhnVGt0Y0YvcGNQcXVwRkMvOVdaWXY0Zm1JeUV0NCt1MzZN?=
 =?utf-8?B?YVNZUW9GT0RTaHdkZkNsK0hEekZLOTZBUEdrckJzblc0ZGNUNnZMWmFrS2o3?=
 =?utf-8?B?MFQ5dlVJcVJkL1RKZDJycEJ4L1dXZFBDdDlkMGptWnplblBzV1o3UTFYSHZx?=
 =?utf-8?Q?72ajse3SXNP9N93Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BD83169253777E43B7F349F03ABC37CE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3add941a-fec6-4aea-d603-08da4f611ebd
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2022 06:26:17.2057
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QeKtXYd+7avMx8/Er8v8bXh9Fgnu5CQjP1jHokkDpSXfHEJazpB0ErQxfdYHnjy7SVO2fjNNXYuC1h4Kwi2drOVSYFI5TEhAbS/iBKCebZQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1678
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTYvMDYvMjAyMiAwNjo1NCwgTGlhbmcgSGUgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlMOiBE
byBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cgdGhl
IGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gQXQgMjAyMi0wNi0xNiAxMjo0OToxNSwgIkxpYW5nIEhl
IiA8d2luZGhsQDEyNi5jb20+IHdyb3RlOg0KPj4gSW4gc2lmaXZlX2wyX2luaXQoKSwgb2ZfZmlu
ZF9tYXRjaGluZ19ub2RlKCkgd2lsbCByZXR1cm4gYSBub2RlIHBvaW50ZXINCj4+IHdpdGggcmVm
Y291bnQgaW5jcmVtZW50ZWQuIFdlIHNob3VsZCB1c2Ugb2Zfbm9kZV9wdXQoKSBpbiBlYWNoIGZh
aWwgcGF0aA0KPj4gb3Igd2hlbiBpdCBpcyBub3QgdXNlZCBhbnltb3JlLg0KPj4NCj4+IFJlcG9y
dGVkLWJ5OiBrZXJuZWwgdGVzdCByb2JvdCA8bGtwQGludGVsLmNvbT4NCj4+DQo+PiBTaWduZWQt
b2ZmLWJ5OiBMaWFuZyBIZSA8d2luZGhsQDEyNi5jb20+DQo+PiAtLS0NCj4gDQo+IA0KPiBTb3Jy
eSwgcGxlYXNlIGlnbm9yZSB0aGlzIHZlcnNpb24gYXMgaXQgc3RpbGwgaGFzIGEgYnVnLiAgSSB3
aWxsIGhhdmUgYSBzdHJpY3QgY2hlY2sgYW5kIGNvbXBpbGUgdGhlIGNvZGUgYmVmb3JlIG15IG5l
eHQgY29tbWl0Lg0KDQpXaGlsZSB5b3UncmUgYXQgaXQgLSBkcm9wIHRoZSBSZXBvcnRlZC1ieSB0
b28uDQpZb3Ugb25seSBuZWVkIHRvIGluY2x1ZGUgdGhhdCBpZiBMS1AgZm91bmQgYSBwcm9ibGVt
IHdpdGgNCmEgcGF0Y2ggdGhhdCdzIGJlZW4gYXBwbGllZCBhbHJlYWR5LiBJZiBpdCdzIG9uIHNv
bWV0aGluZw0KaW4gcHJvZ3Jlc3MsIGp1c3QgZml4IHdoYXQgaXQgcG9pbnRlZCBvdXQgJiByZXNl
bmQuDQoNClRoYW5rcywNCkNvbm9yLg0KDQo=
