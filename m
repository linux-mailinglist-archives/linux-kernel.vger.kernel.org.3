Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23467547288
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 09:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbiFKHLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 03:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiFKHLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 03:11:40 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B1E6257;
        Sat, 11 Jun 2022 00:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1654931498; x=1686467498;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=MYS5+urJt7yJCBT0+GAluIAaktmlprpCQN3FNapII8g=;
  b=uk/Nn8R1pWVakTsiU3AIEorCp9jb6/lEY1poAjDMkAx808fA1o8SZ8jQ
   PaOH7Nr6B3JWjWQVBlNkTTgwAvKxunbFwKsRNEPZFQ9a0ZBgQciD2AiPx
   C3Kg0rTDH9ezBiTa9QvcB6pd20Pb82/5+UluWF76EeEGTr0zYTMKQBYEU
   hUi9i18/2WivcHkzSZ+KH7pqu/FwYVVMUkG9JCSY8uegX8pBY0yEfDSBb
   kFXGJWEUX5mRFLInp1gCZVV2NAu6K4O432A4qlmBc5x0MnvRZVoly2UdE
   KI+PoB6GwUFNnquANnIZzUyQz1JaeXoRuh7ALyb2u7HyufUfvWtxieSNy
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,293,1647327600"; 
   d="scan'208";a="99565688"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Jun 2022 00:11:38 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Sat, 11 Jun 2022 00:11:37 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Sat, 11 Jun 2022 00:11:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G5I1jsxUOcJOtXJVgNtuxnhqAHcI7Jn0AwEVPAj8h1LI2T467f37pf9ZDAbRrLyOFgpP535L2f3Vv6wcoftTB9cZFL8TLRvxWk1L8Xn/T9kSeBM7FTeWmm18iJzD2ff78c7X8erWCXuP7bGxx5FYJyuqdMZeKCbJWa97vkLl87I/vq4CXzL3y803g47nzM4Xbi3g+xQTT2wszsmrXryLWCvNE748ho9KHXXIg3rGxNGhiOBrSWaDKsgM6BKE086U80Cp2N2Tzrkc7BboeGENCP3ApV/+x3ePw6/YvIS7IQUaIq1xk+0CQwgsuaSzNE2cp9QNDLrAR4dQs21V8X9u+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MYS5+urJt7yJCBT0+GAluIAaktmlprpCQN3FNapII8g=;
 b=azejRlB2o7qNSuDBPnyse3faybgwt8vpSJ11yO3aMDFkSWmkRAhk2UEvBFqphos9ocbXG3ok4Gw/2WkqcDCYQvp6LfrgzmTU+j0du8iCVVn/bkuYGJkAugdGApXcTrsrzMxj9IwDYurG/LS1c+WVeXBlqEKIf7E7g3sMDnshYyZvcLaowQn8C6jLYoiwwlNS6UfnC9MYAMdjRSbTBs8cdKR2WJqJN8AS+jnuZAly8RzN+/0Yu9y/zousDpw9H2eLKff5icFc8e1n0gerdKiWZtQTs/03AbD9B7CgVRbCbh/KP0uVJthKC9JZYvHMY5f1JLv6jp3Y+i7XpviPfluAWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MYS5+urJt7yJCBT0+GAluIAaktmlprpCQN3FNapII8g=;
 b=mXEIsqlAYcsz2oUAlKaZXOlUy8Z7HpND0Yb+L0P01HQV0yxCiJifshJjG6seDP5r6BaCiGR1oGvND+1BGTCdDuO9ww9kFBOQk8aNJD0xYHir0wefnogUgYj+c8IPdLBfxtFrxAy3Tg8Al4Yg50xTDOOJg6K0PWNMd2bmxNTSVzo=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by BN6PR11MB0003.namprd11.prod.outlook.com (2603:10b6:405:61::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.15; Sat, 11 Jun
 2022 07:11:18 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa%4]) with mapi id 15.20.5332.015; Sat, 11 Jun 2022
 07:11:18 +0000
From:   <Conor.Dooley@microchip.com>
To:     <wupeng58@huawei.com>, <broonie@kernel.org>
CC:     <linux-riscv@lists.infradead.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <Lewis.Hanly@microchip.com>,
        <liwei391@huawei.com>
Subject: Re: [PATCH] spi: micro: fix unreasonable clk_prepare_enable() on
 error in mchp_corespi_probe()
Thread-Topic: [PATCH] spi: micro: fix unreasonable clk_prepare_enable() on
 error in mchp_corespi_probe()
Thread-Index: AQHYfTlbuksMJtsQD0KrEAiJXbFfZq1JynCA
Date:   Sat, 11 Jun 2022 07:11:17 +0000
Message-ID: <0c4c572d-0fec-05cd-e738-4206290b40f2@microchip.com>
References: <20220611021117.40494-1-wupeng58@huawei.com>
In-Reply-To: <20220611021117.40494-1-wupeng58@huawei.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c22d3a9e-8529-494e-c985-08da4b799478
x-ms-traffictypediagnostic: BN6PR11MB0003:EE_
x-microsoft-antispam-prvs: <BN6PR11MB00038B3F68C5C7848DCEE7C298A99@BN6PR11MB0003.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kCZAXgdr/DMMeELCQmpE81H2liQ7DtjP3tZHqX6Wv2D3K/mv0FKm0Hi0XHuHtjTAas9HtAf/fbV7lPf+tdqS8Vfdpmpo37uoPtqfz+xzE9XMcm68FRWC0ZiNtjdyICDnyWG0rnhxDD1BV3yMxTbD6s4ce3V5E90VFUK4/cjcgiG1YfAs8sJj3VpwYT/eKpH5CpIFEHxUkmggotNRIpqOc4l0uNOvCy+aC7QDGQl33ByOcrPOffedPLUCb2w9OBdq/etTuENR3iYOy3bJUbQS1qdQTeDDotf2RFbcUanqenZ3zVuRp5O14fyLfeFb/YDDXDNFlF1sDQa6Q8V1jK3szTzbI8T0adZPoNGVATafFcqcqs4PQRKMctxvBPm9DKVHhxdc/E/xiiypGbNcLGKG4NpkV35noc6QkTR4UnSOxT8RekLu5vgPe4CdWUEGfOb4E/btTXYNg4GB5FlcJCbbD7HAQMUb5tbg9UiUTVoPa1GKjPhpxpug1Qym1eKcKpUSkT33BJqswQ8va50UyuJZmOHkIiMf3qGKutZfMNSaDcigN4kj8wfKdax7ygg3uoImm+a20legfjGl/f5m2I3qZOyTTxKxnfGLVUl9gXdx29RgPyhlZEFOoLUzFElBiuArV0t4zkevtaXLFgkA+xe2kTOgIFVHDyCzCZRrxupADE6Didl7GzA0GmwS+XSwwkdrmaCVL2Cl5nKkMhBX+ywucyMaf1+ybhn1FRIHHXQoXN3tWGz4UM64zZ3QNuAJLCibbjnF6ygfx+01LQh7FnkcZw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(71200400001)(66946007)(91956017)(66476007)(8676002)(6506007)(86362001)(53546011)(6512007)(64756008)(2616005)(38070700005)(36756003)(110136005)(76116006)(66556008)(4326008)(66446008)(31696002)(26005)(31686004)(54906003)(508600001)(8936002)(38100700002)(316002)(2906002)(5660300002)(186003)(6486002)(83380400001)(122000001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V25yWmI5L0FKemJOU3A5VW9NZjVvZWl0SzZjQW5kcmhNTDhZYlk4RmV1RDBZ?=
 =?utf-8?B?QndWSDFPSy9HM0EvYXlSNDFzUy9IemZFRmRMdG40bWNVR1lOclcyVHB6VUhM?=
 =?utf-8?B?eTVBa2xQanNNQkRsc3F5OE9HYWNmc3FSam9GVjJsc0d4THlXYzVlR3picFYv?=
 =?utf-8?B?YWtyVldhNHZQQ084TnJDVDRMYmpDa2RxYTQ3ZVlxV3dMb1RQdmJCdW56OVVv?=
 =?utf-8?B?V1k1UlVaNHpBcmhuZU9vTEhodkUySnhUb2xWcityRUpDai9YQS9TYTVPRkZY?=
 =?utf-8?B?a3ZSUFR4RVU1VU1xZlJlcDMzbmFraENpMWpFYVZuY0FqUHhoc05JRzhxU3Fo?=
 =?utf-8?B?M2RkTWZhcURyd00xemRqUW9BREdWMmp4Q3hvZlNvUUp2dllNZk1wMVk5YU5Q?=
 =?utf-8?B?QnA1RzI2U0swTTBnSzRncGNQZVVrNW9aSnFkMG5YdFJUZVFoclNoQnB0QTNk?=
 =?utf-8?B?Y0tuSGZtVmhlUW9Ec1dZc3BZRGVraFpDZkk3Nmh1bUcyVzlaUmZpRzhHYTFh?=
 =?utf-8?B?UmhMOWtYM3IyUUpUaWl5Mjg2RHZKcHY4MENNMUVNK2JuRUUzOEJJRWRqSmNM?=
 =?utf-8?B?QkRzbmt0S2x5N0k0ZnI5dzZZQVVIQ1VGblFvMENWeDk0bGNyN1hJVnNMTk43?=
 =?utf-8?B?MUw4a0hHSUhFS0d1MDd5VVZ1ME4rWWQ3ZUh0VmthcHllcngyTkJlUytEQVdk?=
 =?utf-8?B?K21HMTF1QjIzTzUrdEtnU0lqSXdJY1kvMjVicDVqajFtd3JEUEh3QjNQUE5t?=
 =?utf-8?B?Tzk0eC9QT3hpUytjUG9ET3o0MGt4RzVnT3l4M1J4cTNsZ2hJM21RdWdjbG00?=
 =?utf-8?B?dVc3NGdGUmovZjhETVBZZ3kySUxlNWJLN0l0OFJmemNTUlM1ck5WN2FZcGtj?=
 =?utf-8?B?UnA2UXZ1Z0FVQjNPRjNGVW9ld1BTMjdBL1BTUXh4QUp2TXh1aUZVemVpVWt5?=
 =?utf-8?B?cHdFWmdsUWpsb3VRTE9tcWZoNzdFVEdJQmY4RUhHRksxWDRtdHY0RmhXTU1v?=
 =?utf-8?B?T0JpVWloQ1FjWU1wcU5mOU1Lc0poTm1tTUFNOTk2VUNHYkpWYU8wZnkwT0lq?=
 =?utf-8?B?QVIyZVlNbGxZU0xubWpFd2VaY2ZubmhaL0xZSDMyelRMaFZqcWsrWDhqZWo4?=
 =?utf-8?B?bFNPU2thY3h2V3hEV0VZQ2ErQW15dnV1RzNkb3hIZ2N0K0FLMWw4bHdvd3I3?=
 =?utf-8?B?aUxWb0lEb3l5WGU4d1o5UDFDQlhNQ2ZqR09KelRadklPQkJQNE1qRUZXNlZ3?=
 =?utf-8?B?UVhoaWlGaStwRmxmS0J3cmVzM0ZPSitjLytMeGZhNERUSXJ5Ujd2bnlmOG9p?=
 =?utf-8?B?RjhhWUlRbUlhYjc1bjRnUi9Vc2JFNHRLV2tvL2pRSmJDbm9LK2VINHNxV2ln?=
 =?utf-8?B?d3NUOGhjcXBBWHlSVHZkNDltQUUvcUM5RVpyUWp5TUlWaU1Bc2pXNmEzd1Bv?=
 =?utf-8?B?d3pqVy9JV0Evd0pEUXRaVDBpSWFBNDdoY2duMUtzS3pvV1VQTkxGZXhKaTd5?=
 =?utf-8?B?TkdGcmkzUGtUK3ZwUG5NWlcvMyt1WmRVUlI4WGtBc3liRVZ6Sk1PRGhVcmsv?=
 =?utf-8?B?dThhaVYyTnZiWGxnTkZSN0lHMEZ5cEcrWHJ5T2pJYUxNZUpSQyszUGpBYzBF?=
 =?utf-8?B?WlVRN2grbXViTE12QVBlcXJGRkg5aDlULy9oeEtLK3ZWNnB3Rkg3d1FwaU85?=
 =?utf-8?B?bkY1MW5zazNOYlZLZ0VsYm5RRm0xMEo5dyt0ZE0ybERuNy9lTlMvT3RqQ0E1?=
 =?utf-8?B?anBWaERHRmk0L0h4aDR5UUl0Y0txV2Jqck0xandnbGw1bVF4MTZteldmVUZs?=
 =?utf-8?B?UlFmY01LemlPaVl6M2d5em1qVklzclZ3dlhyWkxjTHRpTCtNTWE4djZPNHNP?=
 =?utf-8?B?cTNWczNuaEpuMDd6MWhwdlgrd3p0ZjJyRDJpSjlvMVZXTW1Mb1ZvcDBBK3Zz?=
 =?utf-8?B?NVpIbi94R1JUUW9WYXFjNW14YytyRGxxUUViYitGSW1yRWJYbEV6dys1VmF0?=
 =?utf-8?B?YXE2NldLcWlWdnNhMHQwZjRkc09iRjU2TTkxTnk0NnZDYU83TmkwSkh0MXV0?=
 =?utf-8?B?Z1VES2lZOUNDZWFiRTRtVzlPL3FuOHl5RGtKWDRWZFpQaEtIRXF3WWpPV3NN?=
 =?utf-8?B?YmI3QTkwUStSaXowcUI2V0RUaWY5QUxLZHM0MndtN21WL2FGY0FmSXpYNFlT?=
 =?utf-8?B?THVlSmxZVVZqR1hWdUdXRDNxNkVodHhTbXVzM2x4cldpQWROczY4WjNrOEwv?=
 =?utf-8?B?YXlIbStrdUlUNDhLcFUwVU44SldzamtLNDNneGRtcG5kNmFJdVlLVGk1M1Fr?=
 =?utf-8?B?T1hFQ1Y1eklZZDdSTXRyWnpWbjhyZWhyQUw4UFdWay9pcnA1akFWNHlvNUNk?=
 =?utf-8?Q?hLnSfsumfi2SBBXY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E6B4A5710695534B9BD937865F2B35F8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c22d3a9e-8529-494e-c985-08da4b799478
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2022 07:11:17.9947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kpm6VVeAVtswCyNobONl3UX6SffPs9E//C9dazh4wYaMXSGRiga/1tQQvBug4SDG+4Xczq7B2IKGiKujlxbM+qwL/sAtxhDoDKBsy6lQ5vM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB0003
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvMDYvMjAyMiAwMzoxMSwgUGVuZyBXdSB3cm90ZToNCj4gc3BpOiBtaWNybzogZml4IHVu
cmVhc29uYWJsZSBjbGtfcHJlcGFyZV9lbmFibGUoKSBvbiBlcnJvciBpbiBtY2hwX2NvcmVzcGlf
cHJvYmUoKQ0KDQogICAgICAgXiBzL21pY3JvL21pY3JvY2hpcC1jb3JlID8NCg0KPiANCj4gRVhU
RVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVz
cyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBGaXggdGhlIHVucmVhc29uYWJs
ZSBjbGtfcHJlcGFyZV9lbmFibGUoKSB3aXRoIGNsa19kaXNhYmxlX3VucHJlcGFyZSgpDQo+IGJl
Zm9yZSByZXR1cm4gZnJvbSBtY2hwX2NvcmVzcGlfcHJvYmUoKSBpbiB0aGUgZXJyb3IgaGFuZGxp
bmcgY2FzZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFBlbmcgV3UgPHd1cGVuZzU4QGh1YXdlaS5j
b20+DQoNCiJ1bnJlYXNvbmFibGUiLCB2ZXJ5IGRpcGxvbWF0aWMgd2F5IG9mIHB1dHRpbmcgaXQh
DQoNCkdvb2Qgc3BvdCwgdGhhbmtzLg0KUmV2aWV3ZWQtYnk6IENvbm9yIERvb2xleSA8Y29ub3Iu
ZG9vbGV5QG1pY3JvY2hpcC5jb20+DQoNCj4gLS0tDQo+ICBkcml2ZXJzL3NwaS9zcGktbWljcm9j
aGlwLWNvcmUuYyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBk
ZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc3BpL3NwaS1taWNyb2NoaXAt
Y29yZS5jIGIvZHJpdmVycy9zcGkvc3BpLW1pY3JvY2hpcC1jb3JlLmMNCj4gaW5kZXggNWIyYWVl
MzBmYTA0Li5iZjY4NDdkOTVmZTMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvc3BpL3NwaS1taWNy
b2NoaXAtY29yZS5jDQo+ICsrKyBiL2RyaXZlcnMvc3BpL3NwaS1taWNyb2NoaXAtY29yZS5jDQo+
IEBAIC01ODAsNyArNTgwLDcgQEAgc3RhdGljIGludCBtY2hwX2NvcmVzcGlfcHJvYmUoc3RydWN0
IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gDQo+ICBlcnJvcl9yZWxlYXNlX2hhcmR3YXJlOg0K
PiAgICAgICAgIG1jaHBfY29yZXNwaV9kaXNhYmxlKHNwaSk7DQo+IC0gICAgICAgY2xrX3ByZXBh
cmVfZW5hYmxlKHNwaS0+Y2xrKTsNCj4gKyAgICAgICBjbGtfZGlzYWJsZV91bnByZXBhcmUoc3Bp
LT5jbGspOw0KPiAgZXJyb3JfcmVsZWFzZV9tYXN0ZXI6DQo+ICAgICAgICAgc3BpX21hc3Rlcl9w
dXQobWFzdGVyKTsNCj4gDQo+IC0tDQo+IDIuMTcuMQ0KPiANCg0K
