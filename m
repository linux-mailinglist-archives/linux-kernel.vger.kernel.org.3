Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40C485A7827
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 09:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbiHaHwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 03:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbiHaHwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 03:52:30 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854FC27FFE
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 00:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661932349; x=1693468349;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=brO7aN3iVeCE5lid+c3RcCWlOXlQj7RcsF77Pbi5C4g=;
  b=fTO7+tX1FNoPnB8U5TnLIgoIgUo0V1GAniLnoG/wq6SC42ys/liOITBu
   8yPOID2wEfeMdgSRtGwPZfT7k4CygLrXBNJtYzFGnC2tNLCwDjwPXs6Lq
   swIghA78Tw5l9VwcCoWWlYhgIzFsdluKvBnJJnePlsxHkfDG0/bMizbfF
   dKCEVJ13FvWbetwaYe3rS3ch6MykiepO77MS/2M+HN6ZTr9FisS4gD/Yh
   zaMwlXb/bHks6/MYjsi+Ei7kgo62h2UDF3LVkwshxwYWaTPfzeT6bca1H
   y13QK8PpODLOIs4YfDun6pgcMJYVL/+bxRJy42toy3kFyUKSAxtV9XFw0
   A==;
X-IronPort-AV: E=Sophos;i="5.93,277,1654585200"; 
   d="scan'208";a="188784661"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Aug 2022 00:52:28 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 31 Aug 2022 00:52:28 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Wed, 31 Aug 2022 00:52:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FjmU9ujgkc8Dv2fKKrJagUSPjdPHt9gmca1ow+XaicLvoW5eDbuTvhlO7Y8ZuIopqd3Cj5fg8/jazXJVE3YgG0M4Z/EFtVBskgyCHootsaY1GUHLK0OeX4UbmCirxVdzC7vvYY/PAON6HC8g88ugRd78cYv8w1RVM0mav1qdsoMo8Bw5YDkXNci9wF6uq1By426D6IQpYGGU44QYVzjOIBVCDr2s9+5TdkjsUhM/obYM5eNykTzn5jubBw8pHILA94/2VlNXsz/hngoI37Y6MxITwp952mmJ3FjSR8T41zrHzPPWbFGFRu8elJGqAZ+DNewZEBjiYWWbGhFwHWfpkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=brO7aN3iVeCE5lid+c3RcCWlOXlQj7RcsF77Pbi5C4g=;
 b=j/eydME0rH+d6hoze57gIYYirQvS3eO4zf2iZ8tBXi8T4+tu2Yopa3Z6+QkTC+stJl+i6Uo0JYScxadREPF+3oUXmvnhf7u0DHpKyZ94PfVztVrx9nmtpFlvLZi0CJsHPjT+UgbRw48vwZr1wMpRNSUczBGcLm214NZryalCT1lhVLcoski42GpI1UF4JtkU6/Q3hfxbn/RYuWiEio9n8UdZVBfoBLZpBow0mbcFWiFKIjd5qtHqnh0awXHw2esGShcubq1d5mMbft7HMs8mk1j2HOJI2dbNyHd4ocdosKiB25p5vtAQNdGaiIQdaVtltcAxA7VniYjIp0pi2hlh0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=brO7aN3iVeCE5lid+c3RcCWlOXlQj7RcsF77Pbi5C4g=;
 b=NibLQIn2CnlxZeqv8NhMbFmJGoSQnHpxq2ShWSlyanfpDP/DhJvofmH/ct12EG/usAR15K8fuHOFABjcC0ptNmbEed91gW0r5xSF65YgNr1fPKwcG01l+/g6kBUtx1Xr3eNSWLrSD8felKOZsZ55CJTlz7vOk0a3R+wyajSxGOI=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by BN6PR11MB1649.namprd11.prod.outlook.com (2603:10b6:405:f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 31 Aug
 2022 07:52:23 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009%3]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 07:52:23 +0000
From:   <Conor.Dooley@microchip.com>
To:     <liaochang1@huawei.com>, <chenguokai17@mails.ucas.ac.cn>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <rostedt@goodmis.org>, <mingo@redhat.com>,
        <sfr@canb.auug.org.au>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arch/riscv: kprobes: implement optprobes
Thread-Topic: [PATCH] arch/riscv: kprobes: implement optprobes
Thread-Index: AQHYvO/eaHU6+YdQhkeJ6FHUUeiIQa3Im1yAgAAHRICAAAChAA==
Date:   Wed, 31 Aug 2022 07:52:23 +0000
Message-ID: <8c79280f-ef55-ba38-e1a2-5fd1dbff0114@microchip.com>
References: <20220831041014.1295054-1-chenguokai17@mails.ucas.ac.cn>
 <882e9efc-7222-c3af-e37b-f339789e94c0@microchip.com>
 <2ab8be67-fad5-7bef-6140-43312870d845@huawei.com>
In-Reply-To: <2ab8be67-fad5-7bef-6140-43312870d845@huawei.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 094956c8-14a8-42c2-29e0-08da8b25bda1
x-ms-traffictypediagnostic: BN6PR11MB1649:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6XOsnDwoeCi+PsrZIsoQ0RK6biDa2cfuS3TqLYNPJP4QjSNroQehbAn5Q4UqJUy/K3O7Jnloxq0FDxPCtaPatADPfxqiIQYJdeP4O8AQJ+0mbQ60yvWNNZ2TutC13MdnAM44KcuBjVvmkzZDGvBECO99OtpWEYR95zezux7F+X569PUw3zufAitj+k5pT0vno2RtPYqOGaAYKTjnDwU5TISpANp++9yVlQpuAhcvHpBc2ZM0Pb/AHmUHffl2BcSY9Xg9R3vF61tbcFhaCY44i0rqstn6sE4NOLW+nsaIav8vtKwvQRjqi6vdFHBOYUCi4SDoprDOfkt01LtxtcJcq0Gx1BspskTtLwdEG6F2WWWTS+Cr3jMRUaBa1fsIZ++11HV1bVYxMG4wbiHiUdSy3YSibY9QH7wxqJM3+HFchP4N7gfFu6jng5qHvgMBe2keHkRbKlyPOILfeZpz+tFJ9Lu0BX+SvrIuJ+97dAtdZdj0E9LFuR+5HCYyfUn9xCAisfMYhTmc7bWIPBbFzhTrfqdBgRHtagZb6tGUe+lYg/LMbmUhhp0ct2MIRVBUDFBNA5nX30AvB/DFBVMsS4KL7Nme/rHrM/INXRB8QPa/EIvEamrEoq+s69LxlNiRu5EvZWSQOrS1OM15NAViU3hwV8YeLnHOBzLLESeCiOQPSozxzDkkjo1nwPSk92POnIC/YQ+whGRcfHFr+4Y71CDq62S7U0Bs64oYlgEr+Si8FCGB2wLN+3uKTangYaKeodiyvmx+OoNwCnXzFKlyjzZFTqx3ENl9/m178NKEc/PWqrgPTQnYrb+psOSbUJ+Hx+BrJ6kkdkWOEV7crQeyGjGKuA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(376002)(346002)(366004)(39860400002)(53546011)(5660300002)(83380400001)(31686004)(6506007)(41300700001)(966005)(36756003)(8936002)(478600001)(71200400001)(6486002)(122000001)(66946007)(8676002)(66556008)(76116006)(66476007)(64756008)(66446008)(91956017)(86362001)(31696002)(4326008)(2906002)(38100700002)(7416002)(54906003)(26005)(110136005)(38070700005)(6512007)(186003)(2616005)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eEwzSzF3SkM2SWNkYUo5dFlnc0xzeWVKdW1vVmRINVRwdFg3cHNacUx3U2hR?=
 =?utf-8?B?dEp1SG9TZWRLU1BUaFVxZWJqUkFEV0tBa3JhV2REemo5cHN5dlJUcFFYZDhX?=
 =?utf-8?B?RHYrVXF4QlRJekd6cHBKVmN0M1BESnBoZTN3VlZsdHhSa2FFVDdYMThuTjE0?=
 =?utf-8?B?RjFmNkdIYlZud3U5SUlSVnY0Yy90ZmdNdUpGVlFkd1VOaFB5VGdtdU5Vd1Y4?=
 =?utf-8?B?OGJ6WmRiNnN3TUR1VU1GdDQvVGZrWUFTS3RpMEFWWGliUkRnRVdjWXZOR202?=
 =?utf-8?B?Q0tNaSs5TGhyUnFKR1VDanVGVGl4NEhXNXUvWG8rR1FHM1Juc081ZjlBWVlD?=
 =?utf-8?B?ejZja2VkbFFQRk1PNzAvTncyRk9uYkdiSGlGN1lkYW1XU2F1a093NGdFMVgw?=
 =?utf-8?B?dHZzVnA0L2dZZmQzRld6RmlJMk1WNGhQWDBPVGhKdXByR3Z5YkJrUmlOT2Jp?=
 =?utf-8?B?V2t6NkFUSEMxa01MUWs5cVdkWjhFdEJzVUZtZENLUitaa2JhOXl1TjQvMmFn?=
 =?utf-8?B?czlnai8yQWNkdFhzZytmcVpjUmRTOEFKK2kweGZpNnU4RzRxaStLcGtUOUtK?=
 =?utf-8?B?OTRYSng0elRZd0JkUlVIa25WTzkyeklFaThKVVIrUzg3YmJCOHpPeU1QQjND?=
 =?utf-8?B?MjdhZTlNOGx4cVlDTEJzYUwxYkpQUlIrZHAyVEg1ekc0RXp2cUJ6aU9oMjdS?=
 =?utf-8?B?YjhEa3B1ZHJ3ZmVkV0lhRkYwL055YWZmdE1FY2R4dzVIRjdzaXUrZGZmZE9j?=
 =?utf-8?B?UVZTNWlRVm5TN0tFQzhSTEFXdFZ2NzFSZThodUUyL2NnY0prcmtMN0dvWUU5?=
 =?utf-8?B?QXBabDhzUGtMS2JYdWtQRng1S09kQUYxUGVKUGJWby9za2Nidk1Fd09WYXMy?=
 =?utf-8?B?Q2N3NDhmYitPZXQwTUhGK3Zyb2xtMVd6TE5KUEJUOXJ3R0NtdVluWHhvRitw?=
 =?utf-8?B?VGYvTmxSMk5yVjd1UmpWem9TaTVTRkVFVEJhUGxTY0FGOU9xUHdpa0VYMjlv?=
 =?utf-8?B?ZlpWbXRDL2FqMlpuc3BzeCsrYkZab2tGM2JwYy9nS256OHExMmxyTHVQRmpQ?=
 =?utf-8?B?aXVBZUVqMWM1R2UxcVVFd3hrTzJuRjlZVURPMnBqUVJ3dk11bFJSVC9MQmhz?=
 =?utf-8?B?N3VybkJDSloyY0FxZk1GekI3RExnQS82L2JXU3VvVUtiT0QxY3JYZyt5RVRh?=
 =?utf-8?B?UFdmRnpwL2lDbEw0UXRHTldHQlJJRFcwSlMwOEJ0dGUzMS9DcG5LamdzRzdC?=
 =?utf-8?B?Uy9namVaVlJjVkt1dlhhUnkyYlBPazJ6RnNSbVFRNU51OFNuZWdBTlNrUWJL?=
 =?utf-8?B?ek1JMWNpUlRONnJpZll3MWJnbEYrb2R0cjY2RkZTc203V0t4SVN5NzNaR1Vx?=
 =?utf-8?B?SzIwbzd3MUdUNXlDRlRkWFQ2SGFDbG0rV2J6cXRuNUh2TmF5R2NhMzM5Tnkv?=
 =?utf-8?B?aXFjZHhTb2tCb0d4czVWMDBROVF2eWdzZUcyaVZkdnEwcWRSWlpHNkwxQlF4?=
 =?utf-8?B?K01xRmdSVTZmVEdTWStuR1RkbGxXU2lKRlk3dzNoK1A2QVlKQTROaTdIdG1k?=
 =?utf-8?B?UWVsWURybmR4ZzhPK0IzOFYyeE53RHE0cHpVTVNrOGpDY1dzUWN1dHJRLzZr?=
 =?utf-8?B?aFU3MWRBOUx3QWMvVGc5eDNYck4xWmlRMkdEMVBOOGI0ekFjdmxDWjhwNFIw?=
 =?utf-8?B?VER0UmpMSEJvMGJvMkNFM0lla25hNDVGMjlvdndUSjlYblg4eEU4bW9BQ2tt?=
 =?utf-8?B?dFg4cTVZbFdtdVpZRXpPOWRnL0NLNUt3eVFkWnVqeFhDZTd0SDErcEV6djFn?=
 =?utf-8?B?T3ZtTnlFVndYdVp2ei8vaXVmL2V2bHliNkJjYU5ZcWZ5VEt6T2lSL0FwYzZ4?=
 =?utf-8?B?S0Y4MFpDMStNWG5adnhYSlQ1UVFsZGx4elA3WXpMSW9VbVZabWNiUy9NVnJm?=
 =?utf-8?B?bWtYZnVyZEZwSlBYTG9Za3g1VEZFNjQ4ZGVRQWdXK3YxankyVWhLankzeUdJ?=
 =?utf-8?B?UXNjbmxjWWYyTk9kY0VrTUROcElTUm5yN1RBWW1NTTFaRDIzZXRjRTNXbG5T?=
 =?utf-8?B?L2ZaMHhKeVBqQVlNTEF3S0FIM3JuNEhKVi9sRENTVWw2b0hSc0RhUW45NTRK?=
 =?utf-8?Q?3ru+4DTbpVM06A3+ab6E1e292?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <58A2D4F08A558D428BF382033048FACA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 094956c8-14a8-42c2-29e0-08da8b25bda1
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2022 07:52:23.7540
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BdXN2qN6VqLkZqeN+xCdiohV2TkwGYGjCt26w+FKajAQ5dQqHO9JMxiob5b8qDFwTOl3pNQ+96W+8nGBz1R6J9aIMquDxv8Nx0VAtM9XVNI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1649
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMzEvMDgvMjAyMiAwODo0OSwgbGlhb2NoYW5nIChBKSB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiDlnKggMjAyMi84LzMxIDE1OjI0LCBDb25vci5E
b29sZXlAbWljcm9jaGlwLmNvbSDlhpnpgZM6DQo+PiBIZXkgQ2hlbiwNCj4+DQo+PiBGWUkgdGhl
cmUgaXMgYSBidWlsZCB3YXJuaW5nIHdpdGggdGhpcyBwYXRjaDoNCj4+IGFyY2gvcmlzY3Yva2Vy
bmVsL3Byb2Jlcy9vcHQuYzozNDoyNzogd2FybmluZzogbm8gcHJldmlvdXMgcHJvdG90eXBlIGZv
ciAnY2FuX2twcm9iZV9kaXJlY3RfZXhlYycgWy1XbWlzc2luZy1wcm90b3R5cGVzXQ0KPj4gICAg
ICAzNCB8IGVudW0gcHJvYmVfaW5zbiBfX2twcm9iZXMgY2FuX2twcm9iZV9kaXJlY3RfZXhlYyhr
cHJvYmVfb3Bjb2RlX3QgKmFkZHIpDQo+Pg0KPj4gQWxzbywgaWYgeW91IHJ1biBzY3JpcHRzL2No
ZWNrcGF0Y2gucGwgLS1zdHJpY3QsIGl0IHdpbGwgaGF2ZSBhDQo+PiBmZXcgY29tcGxhaW50cyBh
Ym91dCBjb2RlIHN0eWxlIGZvciB5b3UgdG9vLiBPdGhlciB0aGFuIHRoYXQsIEkNCj4+IGhhdmUg
YSBmZXcgY29tbWVudHMgZm9yIHlvdSBiZWxvdzoNCj4+DQo+PiBPbiAzMS8wOC8yMDIyIDA1OjEw
LCBDaGVuIEd1b2thaSB3cm90ZToNCj4+PiBbWW91IGRvbid0IG9mdGVuIGdldCBlbWFpbCBmcm9t
IGNoZW5ndW9rYWkxN0BtYWlscy51Y2FzLmFjLmNuLiBMZWFybiB3aHkgdGhpcyBpcyBpbXBvcnRh
bnQgYXQgaHR0cHM6Ly9ha2EubXMvTGVhcm5BYm91dFNlbmRlcklkZW50aWZpY2F0aW9uIF0NCj4+
Pg0KPj4+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2ht
ZW50cyB1bmxlc3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPj4+DQo+Pj4gVGhpcyBw
YXRjaCBhZGRzIGp1bXAgb3B0aW1pemF0aW9uIHN1cHBvcnQgZm9yIFJJU0MtVi4NCj4+DQo+PiBz
L1RoaXMgcGF0Y2ggYWRkcy9BZGQNCj4+DQo+Pj4NCj4+PiBUaGlzIHBhdGNoIHJlcGxhY2VzIGVi
cmVhayBpbnN0cnVjdGlvbnMgdXNlZCBieSBub3JtYWwga3Byb2JlcyB3aXRoIGFuDQo+Pg0KPj4g
cy9UaGlzIHBhdGNoIHJlcGxhY2VzL1JlcGxhY2UNCj4+DQo+Pj4gYXVpcGMramFsciBpbnN0cnVj
dGlvbiBwYWlyLCBhdCB0aGUgYWltIG9mIHN1cHByZXNzaW5nIHRoZSBwcm9iZS1oaXQNCj4+PiBv
dmVyaGVhZC4NCj4+Pg0KPj4+IEFsbCBrbm93biBvcHRwcm9iZS1jYXBhYmxlIFJJU0MgYXJjaGl0
ZWN0dXJlcyBoYXZlIGJlZW4gdXNpbmcgYSBzaW5nbGUNCj4+PiBqdW1wIG9yIGJyYW5jaCBpbnN0
cnVjdGlvbnMgd2hpbGUgdGhpcyBwYXRjaCBjaG9vc2VzIG5vdC4gUklTQy1WIGhhcyBhDQo+Pj4g
cXVpdGUgbGltaXRlZCBqdW1wIHJhbmdlICg0S0Igb3IgMk1CKSBmb3IgYm90aCBpdHMgYnJhbmNo
IGFuZCBqdW1wDQo+Pj4gaW5zdHJ1Y3Rpb25zLCB3aGljaCBwcmV2ZW50IG9wdGltaXphdGlvbnMg
ZnJvbSBzdXBwb3J0aW5nIHByb2JlcyB0aGF0DQo+Pj4gc3ByZWFkIGFsbCBvdmVyIHRoZSBrZXJu
ZWwuDQo+Pj4NCj4+PiBBdWlwYy1qYWxyIGluc3RydWN0aW9uIHBhaXIgaXMgaW50cm9kdWNlZCB3
aXRoIGEgbXVjaCB3aWRlciBqdW1wIHJhbmdlDQo+Pj4gKDRHQiksIHdoZXJlIGF1aXBjIGxvYWRz
IHRoZSB1cHBlciAxMiBiaXRzIHRvIGEgZnJlZSByZWdpc3RlciBhbmQgamFscg0KPj4+IGFwcGVu
ZHMgdGhlIGxvd2VyIDIwIGJpdHMgdG8gZm9ybSBhIDMyIGJpdCBpbW1lZGlhdGUuIE5vdGUgdGhh
dCByZXR1cm5pbmcNCj4+PiBmcm9tIHByb2JlIGhhbmRsZXIgcmVxdWlyZXMgYW5vdGhlciBmcmVl
IHJlZ2lzdGVyLiBBcyBrcHJvYmVzIGNhbiBhcHBlYXINCj4+PiBhbG1vc3QgYW55d2hlcmUgaW5z
aWRlIHRoZSBrZXJuZWwsIHRoZSBmcmVlIHJlZ2lzdGVyIHNob3VsZCBiZSBmb3VuZCBpbiBhDQo+
Pj4gZ2VuZXJpYyB3YXksIG5vdCBkZXBlbmRpbmcgb24gY2FsbGluZyBjb252ZW5zaW9uIG9yIGFu
eSBvdGhlciByZWd1bGF0aW9ucy4NCj4+DQo+PiBjb252ZW50aW9uDQo+Pg0KPj4+DQo+Pj4gVGhl
IGFsZ29yaXRobSBmb3IgZmluZGluZyB0aGUgZnJlZSByZWdpc3RlciBpcyBpbnNwaXJlZCBieSB0
aGUgcmVnaXRlcg0KPj4NCj4+IHJlZ2lzdGVyDQo+Pg0KPj4+IHJlbmFtaW5nIGluIG1vZGVybiBw
cm9jZXNzb3JzLiBGcm9tIHRoZSBwZXJzcGVjdGl2ZSBvZiByZWdpc3RlciByZW5hbWluZywgYQ0K
Pj4+IHJlZ2lzdGVyIGNvdWxkIGJlIHJlcHJlc2VudGVkIGFzIHR3byBkaWZmZXJlbnQgcmVnaXN0
ZXJzIGlmIHR3byBuZWlnaGJvdXINCj4+PiBpbnN0cnVjdGlvbnMgYm90aCB3cml0ZSB0byBpdCBi
dXQgbm8gb25lIGV2ZXIgcmVhZHMuIEV4dGVuZGluZyB0aGlzIGZhY3QsDQo+Pj4gYSByZWdpc3Rl
ciBpcyBjb25zaWRlcmVkIHRvIGJlIGZyZWUgaWYgdGhlcmUgaXMgbm8gcmVhZCBiZWZvcmUgaXRz
IG5leHQNCj4+PiB3cml0ZSBpbiB0aGUgZXhlY3V0aW9uIGZsb3cuIFdlIGFyZSBmcmVlIHRvIGNo
YW5nZSBpdHMgdmFsdWUgd2l0aG91dA0KPj4+IGludGVyZmVyaW5nIG5vcm1hbCBleGVjdXRpb24u
DQo+Pj4NCj4+PiBTdGF0aWMgYW5hbHlzaXMgc2hvd3MgdGhhdCA1MSUgaW5zdHJ1Y3Rpb25zIG9m
IHRoZSBrZXJuZWwgKGRlZmF1bHQgY29uZmlnKQ0KPj4+IGlzIGNhcGFibGUgb2YgYmVpbmcgcmVw
bGFjZWQgaS5lLiB0d28gZnJlZSByZWdpc3RlcnMgY2FuIGJlIGZvdW5kIGF0IGJvdGgNCj4+PiB0
aGUgc3RhcnQgYW5kIGVuZCBvZiByZXBsYWNlZCBpbnN0cnVjdGlvbiBwYWlycyB3aGlsZSB0aGUg
cmVwbGFjZWQNCj4+PiBpbnN0cnVjdGlvbnMgY2FuIGJlIGRpcmVjdGx5IGV4ZWN1dGVkLg0KPj4+
DQo+Pj4gU2lnbmVkLW9mZi1ieTogQ2hlbiBHdW9rYWkgPGNoZW5ndW9rYWkxN0BtYWlscy51Y2Fz
LmFjLmNuPg0KPj4+IFNpZ25lZC1vZmYtYnk6IExpYW8gQ2hhbmcgPGxpYW9jaGFuZzFAaHVhd2Vp
LmNvbT4NCj4+DQo+PiBXaGF0IGRvZXMgTGlhbyBoYXZlIHRvIGRvIHdpdGggdGhpcyBwYXRjaD8N
Cj4gSSBqdXN0IHByb3ZpZGUgc29tZSBzdWdnZXN0aW9uIHRvIENoZW4gR3Vva2FpIGR1cmluZyBk
ZXZlbG9wbWVudCA7KQ0KPiBwbGVhc2UgcmVtb3ZlIG15IGluZm8gZnJvbSBTaWduZWQtb2ZmLWJ5
IHRhZy4NCg0KRG9lcyB0aGF0IG1lYW4gdGhhdCB0aGUgImNvcHlyaWdodCAyMDIyIEh1YXdlaSIg
aXMgYWxzbyBub3QgYWNjdXJhdGU/DQogIA0KDQoNCg==
