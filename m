Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 631DA578905
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 19:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234517AbiGRR5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 13:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234213AbiGRR5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 13:57:46 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269E62E6BB
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 10:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658167062; x=1689703062;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=y/8l/bz5Iz4FtUSX5tUa7HYGZ39Af4QahKR3DbNV8ps=;
  b=ebnA6PBa267zwwS2/mpWpcN+uohSEtEFT5bgaY9iXT5d2M2pxBEky8Sl
   ow7ejGrubJAOugpEWy929xGlwoQie0TIOFRjuqDSktyXmbWnMcpgpvyVE
   eM0wqxMLsZCPn0eg6eVnuaDCb0dkUXneHp0+5743aZWSFmkgw23sKTnoT
   SYVjqtgy/CnJevYkmAfGuM89ZJ/qQYIUVdRXAqGZeJSp2Bzou+rIdp4JJ
   oWTXM0YY6znvmHunVLhB4gK3pyTJ6scSLHeGtkyfQOQGJzGmbSbwkmSgz
   XS1IHYkZ2coha7Ubm3z+6hr5WyPjtSge92BjpegqzKnYK33G7fdeJApWz
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="104989725"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Jul 2022 10:57:41 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 18 Jul 2022 10:57:39 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Mon, 18 Jul 2022 10:57:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RgImFNO4QHU/bGuis/iq7eJytKN9BZde5hiLDKkFGzuGSsNDr4sIRjMB+kFzAg7jj4XUiy7xtPCHza+fI8CRESwWjOr8bH9ZuurqajPnRxUQzq4tRnj28MXDYKS5QQ1nd9Dv+82PcNi7hL7Vu1EijWBV6BaIYC3kvItzuxLElYI/jkTjiFWVRRqnz6rncWp1UI2v+xGpuKhZwXVcl87298+hnFnJUFOyzQ/9WDkDl3mYvpH3S6Kc+t2b9ORt+cZsKjhV8TdYX31wKdLtCZ2MRBKkj73cXBfGen7QV9vEyc/ZTiTTPdBUwlh7q0L0KHNKuJHi05vU4T0iUtf/EUjP2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y/8l/bz5Iz4FtUSX5tUa7HYGZ39Af4QahKR3DbNV8ps=;
 b=ZLPkkSD42+v61FYQb7rtDqXzlcE7ZCCNh6iRkxuAK+Y5C7/PA/BQwwpc41XaEa9y8B004evCcN5gdOmDG70vJ/FIsUK059fIGmAswclun7ZwVDCCwEO+3SufiT2DQs1K9XCKiOE3vTpQuJmsIN5sEhjiC9dAgRdlaiSMmpEr0s8ttBkrXRnXIUHaFDnWQBhhbSnDtuqVQQ4Ek0wpMx1htHGWK8//5KwL0XojogfKFD7bol4x4rVVNcZa6VLGFlOfmaBxc7qqs2QNV64rPevi1fZNRk/oRaRXufkkuWQcLswRms+OuTc4GaMYvAcaYKTxY3H5MOUnaNFumQ4mp0OELw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y/8l/bz5Iz4FtUSX5tUa7HYGZ39Af4QahKR3DbNV8ps=;
 b=ulbSk0ufAxe/ppnUxbCPUW5Tul40R8uxKGQ5qr85pmLEjEYwb6ugEJ+OrcKAZmcQK133D0lWAQktxLlT77wc3nt0jO/3gubOsSGLq3MMxys93/R7E/9puvCg7uXHz52J0IWXRtevXKPFZbBuFdWeUhg4nUGUVADz6w209pouUa8=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by MN2PR11MB4368.namprd11.prod.outlook.com (2603:10b6:208:17b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Mon, 18 Jul
 2022 17:57:33 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::357a:acc9:829e:bf7b]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::357a:acc9:829e:bf7b%7]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 17:57:33 +0000
From:   <Conor.Dooley@microchip.com>
To:     <linux@roeck-us.net>, <sudeep.holla@arm.com>
CC:     <linux-kernel@vger.kernel.org>, <Conor.Dooley@microchip.com>,
        <gregkh@linuxfoundation.org>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <ionela.voinescu@arm.com>,
        <pierre.gondois@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH -next] arch_topology: Fix cache attributes detection in
 the CPU hotplug path
Thread-Topic: [PATCH -next] arch_topology: Fix cache attributes detection in
 the CPU hotplug path
Thread-Index: AQHYlr1LjktvAhTwm0O5ibr9nGIi2q2EbdiAgAAEYgA=
Date:   Mon, 18 Jul 2022 17:57:33 +0000
Message-ID: <0744c97a-bb4e-0985-7f86-f98965b5d3c1@microchip.com>
References: <20220713133344.1201247-1-sudeep.holla@arm.com>
 <20220718174151.GA462603@roeck-us.net>
In-Reply-To: <20220718174151.GA462603@roeck-us.net>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6b366c22-c61a-43f6-c6ec-08da68e6fd98
x-ms-traffictypediagnostic: MN2PR11MB4368:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MC9Xt0Cu5N7wEip9WvE8GRGpzAJAyKHuJr94KFw7VQlMpqtqP+93OYKHzdyiOBvYalrVpWI45pcdkIw7+4piHVpN6ni9bS+u4GvRpQvp2lJIxmLCBKNa/lT2aRd3pyuMMRyKXCM9HQPjxGzzHR6Ceuwguw8i4fNQeA+/JW56Wy4+gkAo5d5bHbEY+qQgQk55xMnHW9ZfGItxeqJZmY4Sl1NRqJJPvGz43MZx6xwdIGlXYTx4bcDM4OQyiR8VQr01hPB6azfFd3Jw0jdXt+m9/+HnUaltN0E0vJnWjS9Lu+gl4I38V/2BGKkOYwx9Q1cslPjdYmCjnevR2XgK8U4vvjfMtnJ7F9IU1nxFV/qGPxboIxfe/lKMnNXJPXF4a7nTHi1CFIzF0RaBGSho8FV9WL1SkRFf1shaalrmSXDneTbvVzd9IF0FLmnXs6QkjUQUa2VpTyzv4PdOoJ4Djxr/g3+gXmrhnI/akT56tgNfmgr1ZLyndXs/Ggig0sIcevOKSyX4U0MDQqKDeuSUuFCgNrX7deA6EyGhGWGjwOCPNonZkq2AVFreF8HF0P+ouqBJQ22cNy/ZHKr53hqGkT81yISwRkeRcuiLRtPAS95Fig1SqIVS8FFRn//S9wchtSNx7ZG51hzAbqqW3j70IkkNxMPzQDIpa42u77TuPRLKbkhc9gKoKSp5tnHoNIbUdyYLLessBh21OT7S7zv9MWiML/FCxECLjHLTyppQK+xppqjzvQQ9jYx/x774v8pwFPzH6tWCwqA32oqalTNvsq9RHdo8GlS/WT92nPFDOOEKAuhS0RWc3UL/F/CwHh4CCVYibBR9+sxWAimUAHf9pi+3NqU4tA2QLCmWRC8YIu1ncsk+KrkxqQ4nMQ6jCjTHf5ic
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(396003)(346002)(376002)(39860400002)(122000001)(316002)(91956017)(76116006)(66946007)(38070700005)(66556008)(31686004)(38100700002)(36756003)(54906003)(71200400001)(4326008)(8676002)(64756008)(66476007)(110136005)(66446008)(26005)(2906002)(41300700001)(186003)(6512007)(83380400001)(2616005)(8936002)(7416002)(5660300002)(6486002)(31696002)(86362001)(53546011)(6506007)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Vk9QVTRJWW85dGVEYXVUb3UyME1uTXo4andXdHVVVnVVMUp4WFNqVzVuOFpW?=
 =?utf-8?B?U3l0b2xrMjBpWnZiR0pheTN2cmI1Ni9EWkQvSXJKUkxuWkJ5UVRrM1J5WmVN?=
 =?utf-8?B?NFRUVnFoT2pYeDM3R29nSmt4UWlyRFRyRUJIL2dBL3dCYUNiRG9aeHJRZVhG?=
 =?utf-8?B?TzRpdFF1MUo1OFdodTVXNWExMzdvbWxFR3gzaHVHNnhLSWZIQmtVRHNiTUxq?=
 =?utf-8?B?ZnYxcG4reGhodWlycGpieXdiVVNyRGNFWUtpMGQwVlVDUlpjNjRKNEVDNi9V?=
 =?utf-8?B?eVY5Y2hQTC9LNEtKdm5qRlZoa1I1cTYwd2cxellDWHZDVllheGRqckl0N1lT?=
 =?utf-8?B?RVFEK1VEbWNXRVFITU9HaUlyWUgyT3JNVTBVZWNEcndmcDkrQzJUTHg5YXhq?=
 =?utf-8?B?ZHdWU2x2UStpT1lnVkJMOGpYbXJPQzY0cFhBUTBkR2M1L1ZQakxweEVzeDdL?=
 =?utf-8?B?eXR2cEhUWkxLU0hsTThVZWxIVHlUajBueEhLQmFMMHRXVDBUWlRBRHBDVzZz?=
 =?utf-8?B?NlZQemdub3hvUDBRS3A1eE1BNE5pVWVTb3N2enlHYlg4TXJ2RkMzR1IzNG05?=
 =?utf-8?B?ckMrK1pBM0NwaXQzUHUvUXBMcWxQVnBNcUMrOXk0YVpDK3Zieit1c1MxTmxI?=
 =?utf-8?B?NFFGRk51dzlyeWFNdVVMZFBiTU9PK05ScEdDM3pxTG1RTGtzcHJkUG5ZWXVL?=
 =?utf-8?B?aGpKL3loSHlDZ1lGczB1RGRZSzZlNTJ5RHR0UzY2dDg2QTFsaGdaT2svRUdF?=
 =?utf-8?B?dFExVVdORFBwT1hQTk1BemZpczZDQ3NxT01CSVh0Y0tHSFZqSmp5dThXaisz?=
 =?utf-8?B?SlRLK2lsRVo1VjVZQTg2RTk4Y3grYWtqQWsyMmxUejRaZk1Fd3hlR2FvaXE2?=
 =?utf-8?B?RDhLOTZoakk1WEJKdmtlYUxjaVR0eURyY0w0UjZ0TjNtZkZPNlp1N1llUGJS?=
 =?utf-8?B?TllHUFdXUE1ublZvNXA0Skg4bXozdkpnbDV4aHFza3dMY3drUHlSWjNhRE1R?=
 =?utf-8?B?cFdPd1RUWWcvemExMkRVdnF6QUVPTEdXSXI1Y01kbCsrSEpNcU9nVFRWMm5S?=
 =?utf-8?B?cGxuOWgrSnB5UW1ZZG5PLzNaS2ZVTUpNRDN2NHJYVzE4aHlRN09uK0NpeXR3?=
 =?utf-8?B?dGpMazVHbXY2ajZ2TDlZanN2djFLRWNwOTM0UVZVTkdETVdSM25GV2VLWVZ3?=
 =?utf-8?B?clkvaGVuMWdPUG1JaDk5ZU1SOVB3dDB5NTNsVjZKQWZGd01XSVR3alJ3bnhy?=
 =?utf-8?B?enF5dERuc0FXOXZNanFzR3puY0drUC9BTnVoVzBBeUlJanRDSDk5SGxpcjgv?=
 =?utf-8?B?RG1MV2dQRmVCMjB6Q3NwdEFJZWRkT1I0S1BvUHQ2TUhZbzNmci9qMEhXb1pZ?=
 =?utf-8?B?SEZ1MlY3UGVPTHRQd2ZSZU5GVkVhS2xCaGxvQVgxaTY4K3gyUlNCb3FFMHFK?=
 =?utf-8?B?YlYwYWlvS0UzM2lyZWJsS3BaUU5ydlZreXVWRmRjNkZvS1dRZlFtRDRncmJE?=
 =?utf-8?B?cCtWNW5KeTV5YS81TU1WczRULzViejZBTEhkbmc4WWYyREJ3Q1l1WGoxTCtQ?=
 =?utf-8?B?RkozUDhjZnpnOGxYbUhDOG54ZlJCVFVlQUFZL0JRamlUOC81b203VERCdnR5?=
 =?utf-8?B?Y1JYalg0c0NsSCtwUE42Tjh0Wjh6WjJsSUl4UFBIbFhpdVYvOS91Qkh5VGJT?=
 =?utf-8?B?UzZsUm9VSFhmc3BSVjZ4cTJweTVJM1NXVFI5YitLd3UyTkl5Vmc4Q2UrV2pm?=
 =?utf-8?B?ZjhCejlDQjJNRVhwN1BMZHBMcjZRQUJKYUw3ZXk3eHJWbjBqa1RXeGNuTEpZ?=
 =?utf-8?B?cFNocHNwcExvb1NNWWpCOTFiQTFzeVJ1ams4S2pqVEtmempuVXpJZnFkOERa?=
 =?utf-8?B?S2NJampqbkZzVU1nRDMvbGdCVVhWSWVCU09DQWtsQVNoam95NDlPVFhodFli?=
 =?utf-8?B?Q01KWHlMdlB4aDRNQmIxKzZ3QlZSbEpwYk5SVU8za0VrMkhTN1J1UjZubU82?=
 =?utf-8?B?ZGhiRGYxUStPelpTbnk2NklNNWlkWjBTMXBVVHplM0daaEp6M2p1dXlnbVRs?=
 =?utf-8?B?THJYNE1TTWRhR3pJYkhpVk1EN1VFTUs3L3JZeERUZEhSWWdwNGJOTDVuZnBp?=
 =?utf-8?Q?uWHSyQw7pmlYQHYGfFzy8ojVR?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D7DAC3101C868A4F98FC71B9DFB49D46@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b366c22-c61a-43f6-c6ec-08da68e6fd98
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2022 17:57:33.2292
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RsfSntLuxeSd7vi0UpRKoXynJIZ6clO8ksMTD7TnowKQPvfP1Onlv/6XANPwhs3w9SI5yCFfmGfvR1bhSAaYRhqpQv/T9cRPjX7yzxKML1c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4368
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTgvMDcvMjAyMiAxODo0MSwgR3VlbnRlciBSb2VjayB3cm90ZToNCj4gT24gV2VkLCBKdWwg
MTMsIDIwMjIgYXQgMDI6MzM6NDRQTSArMDEwMCwgU3VkZWVwIEhvbGxhIHdyb3RlOg0KPj4gaW5p
dF9jcHVfdG9wb2xvZ3koKSBpcyBjYWxsZWQgb25seSBvbmNlIGF0IHRoZSBib290IGFuZCBhbGwg
dGhlIGNhY2hlDQo+PiBhdHRyaWJ1dGVzIGFyZSBkZXRlY3RlZCBlYXJseSBmb3IgYWxsIHRoZSBw
b3NzaWJsZSBDUFVzLiBIb3dldmVyIHdoZW4NCj4+IHRoZSBDUFVzIGFyZSBob3RwbHVnZ2VkIG91
dCwgdGhlIGNhY2hlaW5mbyBnZXRzIHJlbW92ZWQuIFdoaWxlIHRoZQ0KPj4gYXR0cmlidXRlcyBh
cmUgYWRkZWQgYmFjayB3aGVuIHRoZSBDUFVzIGFyZSBob3RwbHVnZ2VkIGJhY2sgaW4gYXMgcGFy
dA0KPj4gb2YgQ1BVIGhvdHBsdWcgc3RhdGUgbWFjaGluZSwgaXQgZW5kcyB1cCBjYWxsZWQgcXVp
dGUgbGF0ZSBhZnRlciB0aGUNCj4+IHVwZGF0ZV9zaWJsaW5nc19tYXNrcygpIGFyZSBjYWxsZWQg
aW4gdGhlIHNlY29uZGFyeV9zdGFydF9rZXJuZWwoKQ0KPj4gcmVzdWx0aW5nIGluIHdyb25nIGxs
Y19zaWJsaW5nX21hc2tzLg0KPj4NCj4+IE1vdmUgdGhlIGNhbGwgdG8gZGV0ZWN0X2NhY2hlX2F0
dHJpYnV0ZXMoKSBpbnNpZGUgdXBkYXRlX3NpYmxpbmdzX21hc2tzKCkNCj4+IHRvIGVuc3VyZSB0
aGUgY2FjaGVpbmZvIGlzIHVwZGF0ZWQgYmVmb3JlIHRoZSBMTEMgc2libGluZyBtYXNrcyBhcmUN
Cj4+IHVwZGF0ZWQuIFRoaXMgd2lsbCBmaXggdGhlIGluY29ycmVjdCBMTEMgc2libGluZyBtYXNr
cyBnZW5lcmF0ZWQgd2hlbg0KPj4gdGhlIENQVXMgYXJlIGhvdHBsdWdnZWQgb3V0IGFuZCBob3Rw
bHVnZ2VkIGJhY2sgaW4gYWdhaW4uDQo+Pg0KPj4gUmVwb3J0ZWQtYnk6IElvbmVsYSBWb2luZXNj
dSA8aW9uZWxhLnZvaW5lc2N1QGFybS5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBTdWRlZXAgSG9s
bGEgPHN1ZGVlcC5ob2xsYUBhcm0uY29tPg0KPj4gLS0tDQo+PiAgZHJpdmVycy9iYXNlL2FyY2hf
dG9wb2xvZ3kuYyB8IDE2ICsrKysrKy0tLS0tLS0tLS0NCj4+ICAxIGZpbGUgY2hhbmdlZCwgNiBp
bnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkNCj4+DQo+PiBIaSBDb25vciwNCj4+DQo+PiBJ
b25lbGEgcmVwb3J0ZWQgYW4gaXNzdWUgd2l0aCB0aGUgQ1BVIGhvdHBsdWcgYW5kIGFzIGEgZml4
IEkgbmVlZCB0bw0KPj4gbW92ZSB0aGUgY2FsbCB0byBkZXRlY3RfY2FjaGVfYXR0cmlidXRlcygp
IHdoaWNoIEkgaGFkIHRob3VnaHQgdG8ga2VlcA0KPj4gaXQgdGhlcmUgZnJvbSBmaXJzdCBidXQg
Zm9yIG5vIHJlYXNvbiBoYWQgbW92ZWQgaXQgdG8gaW5pdF9jcHVfdG9wb2xvZ3koKS4NCj4+DQo+
PiBXb25kZXIgaWYgdGhpcyBmaXhlcyB0aGUgLUVOT01FTSBvbiBSSVNDLVYgYXMgdGhpcyBvbmUg
aXMgY2FsbGVkIG9uIHRoZQ0KPj4gY3B1IGluIHRoZSBzZWNvbmRhcnkgQ1BVcyBpbml0IHBhdGgg
d2hpbGUgaW5pdF9jcHVfdG9wb2xvZ3kgZXhlY3V0ZWQNCj4+IGRldGVjdF9jYWNoZV9hdHRyaWJ1
dGVzKCkgZm9yIGFsbCBwb3NzaWJsZSBDUFVzIG11Y2ggZWFybGllci4gSSB0aGluaw0KPj4gdGhp
cyBtaWdodCBoZWxwIGFzIHRoZSBwZXJjcHUgbWVtb3J5IG1pZ2h0IGJlIGluaXRpYWxpc2VkIGlu
IHRoaXMgY2FzZS4NCj4+DQo+PiBBbnl3YXlzIGdpdmUgdGhpcyBhIHRyeSwgYWxzbyB0ZXN0IHRo
ZSBDUFUgaG90cGx1ZyBhbmQgY2hlY2sgaWYgbm90aGluZw0KPj4gaXMgYnJva2VuIG9uIFJJU0Mt
Vi4gV2Ugbm90aWNlZCB0aGlzIGJ1ZyBvbmx5IG9uIG9uZSBwbGF0Zm9ybSB3aGlsZQ0KPj4NCj4g
DQo+IGFybTY0LCB3aXRoIG5leHQtMjAyMjA3MTg6DQo+IA0KPiAuLi4NCj4gWyAgICAwLjgyMzQw
NV0gRGV0ZWN0ZWQgUElQVCBJLWNhY2hlIG9uIENQVTENCj4gWyAgICAwLjgyNDQ1Nl0gQlVHOiBz
bGVlcGluZyBmdW5jdGlvbiBjYWxsZWQgZnJvbSBpbnZhbGlkIGNvbnRleHQgYXQga2VybmVsL2xv
Y2tpbmcvc2VtYXBob3JlLmM6MTY0DQo+IFsgICAgMC44MjQ1NTBdIGluX2F0b21pYygpOiAxLCBp
cnFzX2Rpc2FibGVkKCk6IDEyOCwgbm9uX2Jsb2NrOiAwLCBwaWQ6IDAsIG5hbWU6IHN3YXBwZXIv
MQ0KPiBbICAgIDAuODI0NjAwXSBwcmVlbXB0X2NvdW50OiAxLCBleHBlY3RlZDogMA0KPiBbICAg
IDAuODI0NjMzXSBSQ1UgbmVzdCBkZXB0aDogMCwgZXhwZWN0ZWQ6IDANCj4gWyAgICAwLjgyNDg5
OV0gbm8gbG9ja3MgaGVsZCBieSBzd2FwcGVyLzEvMC4NCj4gWyAgICAwLjgyNTAzNV0gaXJxIGV2
ZW50IHN0YW1wOiAwDQo+IFsgICAgMC44MjUwNzJdIGhhcmRpcnFzIGxhc3QgIGVuYWJsZWQgYXQg
KDApOiBbPDAwMDAwMDAwMDAwMDAwMDA+XSAweDANCj4gWyAgICAwLjgyNjAxN10gaGFyZGlycXMg
bGFzdCBkaXNhYmxlZCBhdCAoMCk6IFs8ZmZmZjgwMDAwODE1ODg3MD5dIGNvcHlfcHJvY2Vzcysw
eDVlMC8weDE4ZTQNCj4gWyAgICAwLjgyNjEyM10gc29mdGlycXMgbGFzdCAgZW5hYmxlZCBhdCAo
MCk6IFs8ZmZmZjgwMDAwODE1ODg3MD5dIGNvcHlfcHJvY2VzcysweDVlMC8weDE4ZTQNCj4gWyAg
ICAwLjgyNjE5MV0gc29mdGlycXMgbGFzdCBkaXNhYmxlZCBhdCAoMCk6IFs8MDAwMDAwMDAwMDAw
MDAwMD5dIDB4MA0KPiBbICAgIDAuODI2NzY0XSBDUFU6IDEgUElEOiAwIENvbW06IHN3YXBwZXIv
MSBOb3QgdGFpbnRlZCA1LjE5LjAtcmM3LW5leHQtMjAyMjA3MTggIzENCj4gWyAgICAwLjgyNzM5
N10gQ2FsbCB0cmFjZToNCj4gWyAgICAwLjgyNzQ1Nl0gIGR1bXBfYmFja3RyYWNlLnBhcnQuMCsw
eGQ0LzB4ZTANCj4gWyAgICAwLjgyNzU3NF0gIHNob3dfc3RhY2srMHgxOC8weDUwDQo+IFsgICAg
MC44Mjc2MjVdICBkdW1wX3N0YWNrX2x2bCsweDljLzB4ZDgNCj4gWyAgICAwLjgyNzY3OF0gIGR1
bXBfc3RhY2srMHgxOC8weDM0DQo+IFsgICAgMC44Mjc3MjJdICBfX21pZ2h0X3Jlc2NoZWQrMHgx
NzgvMHgyMjANCj4gWyAgICAwLjgyNzc3OF0gIF9fbWlnaHRfc2xlZXArMHg0OC8weDgwDQo+IFsg
ICAgMC44Mjc4MzNdICBkb3duX3RpbWVvdXQrMHgyYy8weGEwDQo+IFsgICAgMC44Mjc4OTZdICBh
Y3BpX29zX3dhaXRfc2VtYXBob3JlKzB4NjgvMHg5Yw0KPiBbICAgIDAuODI3OTUyXSAgYWNwaV91
dF9hY3F1aXJlX211dGV4KzB4NGMvMHhiOA0KPiBbICAgIDAuODI4MDA4XSAgYWNwaV9nZXRfdGFi
bGUrMHgzOC8weGJjDQo+IFsgICAgMC44MjgwNTldICBhY3BpX2ZpbmRfbGFzdF9jYWNoZV9sZXZl
bCsweDQ0LzB4MTMwDQo+IFsgICAgMC44MjgxMTJdICBpbml0X2NhY2hlX2xldmVsKzB4YjgvMHhj
Yw0KPiBbICAgIDAuODI4MTY1XSAgZGV0ZWN0X2NhY2hlX2F0dHJpYnV0ZXMrMHgyNDAvMHg1ODAN
Cj4gWyAgICAwLjgyODIxN10gIHVwZGF0ZV9zaWJsaW5nc19tYXNrcysweDI4LzB4MjcwDQo+IFsg
ICAgMC44MjgyNzBdICBzdG9yZV9jcHVfdG9wb2xvZ3krMHg2NC8weDc0DQo+IFsgICAgMC44Mjgz
MjZdICBzZWNvbmRhcnlfc3RhcnRfa2VybmVsKzB4ZDAvMHgxNTANCj4gWyAgICAwLjgyODM4Nl0g
IF9fc2Vjb25kYXJ5X3N3aXRjaGVkKzB4YjAvMHhiNA0KPiANCj4gSSBrbm93IHRoZSBwcm9ibGVt
IGhhcyBhbHJlYWR5IGJlZW4gcmVwb3J0ZWQsIGJ1dCBJIHRoaW5rIHRoZSBiYWNrdHJhY2UNCj4g
YWJvdmUgaXMgc2xpZ2h0bHkgZGlmZmVyZW50Lg0KDQpBeWUsIEkgZ290IGEgZGlmZmVyZW50IEJU
IG9uIFJJU0MtViArIERUIC0gYnV0IHRoYXQgc2hvdWxkIGJlIGZpeGVkIGluDQpuZXh0LTIwMjIw
NzE4LiBUaGlzIGlzIGEgZGlmZmVyZW50IHByb2JsZW0gdW5mb3J0dW5hdGVseS4NCg0KVGhhbmtz
LA0KQ29ub3IuDQo=
