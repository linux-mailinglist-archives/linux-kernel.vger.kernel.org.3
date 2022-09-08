Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0CB5B1C10
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 14:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbiIHMAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 08:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbiIHMAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 08:00:03 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C4058B75;
        Thu,  8 Sep 2022 05:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662638401; x=1694174401;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=hIySzQLTH2h5e8qu229VEQrAhOaRxBOf+ZmR1c+bqCI=;
  b=AIMqjyhjIrufXhz3OTixG5nYmGgUOsePLZCzIJNwI3yHgEalZxA6GByd
   7iXunKVTftWNI9vyATe6rRXjkb8/u9I7icbIzOyv3Rv+LPxNORSb5Y2/T
   RrnmDbP04Hfxv3cEbIvXVJMKU+lNapLLDvzUcEYDsAZ7AZwvUQdT4iD8B
   eFQgmFlePi4RfNUgE7ti9ROia2welf1eGHC2eGaHHk4iAhF8Cs5BvNDxy
   6fmZC3C9+hnybcCiPuVdj/Ya4oxCAK+PW/4XLo61e+kLs9T2KlIMGdwPb
   uyoWOpK6bSESqPfXN4Ie/3QVZrezcgRKQOeFDkxZv7oM3Nhi+tvL+Ujs0
   A==;
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="112728922"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Sep 2022 05:00:00 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 8 Sep 2022 05:00:00 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Thu, 8 Sep 2022 05:00:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cG5JkBtB3RkTy3uhwrNU+wzH9PyLHWv9OX0VcbyBhB4nQahLAWErUJOTMFkgXAx4ExHqYPlqxSh143mCu1ay6PDs5WgdNA97S7UTvlS/0ICRcnKm5K//TsmwVudQIskEI2nSIJikpjvG+SnZpSj1CxuaWGeTcwfU9UOq+QyRvCVi3YaHb5Xux3sqCNzBcU/bv2JdUPoCT8J/7CfPtP8jkIqLp4HzkUNddWtE8JV0N/M3VZSH8bXTZgEGSqnLIg6BzHr83ycEic+Osr4z+s5eCYBJ/tEQexhQxvTnjY3bzuPp2To11q2S2aqozM4ZwxBSsZsoYLspHiSHxLZbpwozvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hIySzQLTH2h5e8qu229VEQrAhOaRxBOf+ZmR1c+bqCI=;
 b=Td1V5/TEi266hJ9+7kaa7JSG89re5tRBPqpLeR0N+AnW6TJHVoqCBcoTdy/aXPqPWwP4VPpyxcxsb7tCQc85IY1991Ng5C6ogeCvelb6yaw/mwMD13zd4ddCSxsalLD31J0IZ6LriV8HKQPHodWmXxeKVrlpf5eLyarGkcTVp8C9e+gZejleT3fnTGcJfwsPrVdqAXbXatYdD5Z7VaXhAT1QpFZaBG38QI5Mm1RM+hblPYCZ44uiW11DZqRxTy7fPgjXOcvz3/ryDFTw5lVpsconaS0gO3yN43dbg+o9lJOwtuiM5hKyK+pLkHmYdP/4noLnowLEMtWBrtQV8R6Dng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hIySzQLTH2h5e8qu229VEQrAhOaRxBOf+ZmR1c+bqCI=;
 b=FA0n9LwPiz7MFFJ6walQ/Pp3l10VOwXICoTzvCZn39P+B2P/2I4ELB7ZFZ2fFuDdG7d1/T4aCDSBtzldTU/4/fc/pZc7ZNb7KUJCPcfPXHhszRPT9molLHD68VLfkN141AgjXmlRpMVZzFi3b2N1xMjuwkClICNI359cMdOkBp0=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by CY4PR11MB1432.namprd11.prod.outlook.com (2603:10b6:910:5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Thu, 8 Sep
 2022 11:59:54 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009%3]) with mapi id 15.20.5612.014; Thu, 8 Sep 2022
 11:59:53 +0000
From:   <Conor.Dooley@microchip.com>
To:     <prabhakar.csengg@gmail.com>, <guoren@linux.alibaba.com>
CC:     <atishp@atishpatra.org>, <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        <paul.walmsley@sifive.com>, <biju.das.jz@bp.renesas.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <atishp@rivosinc.com>, <apatel@ventanamicro.com>,
        <geert+renesas@glider.be>, <linux-riscv@lists.infradead.org>,
        <linux-renesas-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 1/2] riscv: vendors: andes: Add support to configure
 the PMA regions
Thread-Topic: [RFC PATCH 1/2] riscv: vendors: andes: Add support to configure
 the PMA regions
Thread-Index: AQHYwdqljaYH7D6050aAz/t+qDALqK3SNfiAgAJOpACAAB1VgIAAlz4AgAA1oACAAAJqAA==
Date:   Thu, 8 Sep 2022 11:59:53 +0000
Message-ID: <e72263ee-10af-1249-5f0d-7e90e8e88441@microchip.com>
References: <20220906102154.32526-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220906102154.32526-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <8ecb62b7-53c4-1c43-65b3-567d8c12e131@microchip.com>
 <CAOnJCUKLpRz4Fbx1XiMnap-ELw2k1c8E9V8bZiSP+x7z9Z5QrA@mail.gmail.com>
 <f362eaeb-6ccd-4392-a346-55fa5ae25e13@microchip.com>
 <OS0PR01MB5922833FDCA60892191B211A86409@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CA+V-a8uttuVd5_UXvNjXU6yG-GpmxG-BuEAm9pWxx13PjZ-h5w@mail.gmail.com>
In-Reply-To: <CA+V-a8uttuVd5_UXvNjXU6yG-GpmxG-BuEAm9pWxx13PjZ-h5w@mail.gmail.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5154:EE_|CY4PR11MB1432:EE_
x-ms-office365-filtering-correlation-id: 09955d58-393c-4b8c-ab9e-08da9191a454
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ru3jl8Q9fnmiiThlyc7YU82+PCgBZu0SfA3sudqo27OoVWLgafE2Zvwr9Q4ORFP4dMURGexgp9WL0SH5GiH2TLJv2NbBWyN2VxVHbzC62ECQIGqNZ+0YqFItCnRMFcDNSeoeKPg1teaViZCbcmdBLS/p8VO7tut0UhD0h9qZfCAuKnOs56iiGAE+jRC3O87bAzwH6ymlVj3pfarLeD+aeSKJbcAc0lQmTCwrn/myzUyhXT3ZaWNj5i5uf0l49jgztDpiUcPvU3yLCFHBWEJQzCiOTLrQvVMGNGrxVmX5h7ZaS1gIbtOjBYxg64RrfyUUpdbpVO+5aXmWGzilotkSjfmxmsKbGcDbr4yLmFZVCNxj36akN6PloFuJ3kEdgonGvRuzQBLMhIy8gGps9WjENXAbRhtdW+E/6Txh8RqNPK9eIc/rHe6cFXLHwlr692KnBPbWJH1hPsQ+l60deWDc4RZ+LGd/XWNq8rMi1We1rpP/y6lVtthgMR+QrJIUxr4J/JCiJrwx1ImlCUU915rnX7O487d+oKy+J0ACF2qFUimKIqYM1A1qX4miHizrsCp49ruwtMOpC4M0A4uGna9Z/i21DwYjdl/u9b0T+mXgOMB4BNBO8jg5DfueSpK2xMGeDyrPgfmKl/xPieX8aZQwTooRgMRWwP/990E5T+020J0TgI00QaR6v6fjlOS1niaZ6bVNyx/A8E4SG0BmnHrnGFVayu5aq2xC0uj68qcApbCDTd8+XLnX6AJ+cEbQx+FQbmZNp+nHZmJdoV/TLLp0HlhxKQ8HBloo11CmGEjY9EDLWqKn2q0Hz2Q4gF3Zz2FdwP9BJN8gIfCfX0I7KdIPyErFO0HPCjpepl56p3Vq5WA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(366004)(346002)(396003)(376002)(2616005)(186003)(38100700002)(122000001)(83380400001)(5660300002)(8936002)(7416002)(91956017)(64756008)(8676002)(4326008)(66446008)(66476007)(66556008)(76116006)(66946007)(2906002)(71200400001)(41300700001)(478600001)(6506007)(26005)(6512007)(53546011)(110136005)(54906003)(316002)(6486002)(966005)(36756003)(86362001)(31696002)(31686004)(38070700005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ektCbUszVGRHQ0dzZHc4akptdU9XWkdMT0EwOWNtTzFSTlJORXBQRzhEQ2tR?=
 =?utf-8?B?TXhHN2tvUjExR0Fkc3BxUG8yK3RmVng2ZGtYRkkrK1l0Q0JQRDJnZEV6a25w?=
 =?utf-8?B?V0lMb2paT2FVUUk2N0NNQWg5VXJRU2VGUU9RaHhpMEwzTlZUaGFuZnMxN0Ey?=
 =?utf-8?B?K09Qb3FHWEUzdmxrdHVXeGNWUnRZK3B2czQzVXd4NFJlSVlQNVFCbFVUb0Vi?=
 =?utf-8?B?UjlQNTlob2pUR0xKbnVub0drYUVSSkRnUUk0WVByRVR4V0RGNXl3YjhXOFJ5?=
 =?utf-8?B?REkybVVzcXdWK1dHMkNIMUh3Z2Rhb0srZnFrbDkxTXRZVW1qblA3bXdrUUJi?=
 =?utf-8?B?SEtETXE0YkNnRUdXSE5ySjRRUDFWOGFBRGd0U1pvNmJ1YWxkbGNZdlU2RlpV?=
 =?utf-8?B?aDJOY3BvOFFnZEtsTUp3YTYxMHkzZzF0UmFXM2FOcFpSZllzVGo1ZzVVeDR6?=
 =?utf-8?B?Z1d1bXdiVTNrZGFWSjdpSFRpWXhSZkxiSGM2NEFWUDV1VHNtUTZTak52bFE2?=
 =?utf-8?B?dnlpczVocHFwbktHR1l2N0JaejZmR3hsUkkvY0puWDJXNWtxWW1idTRQOUdO?=
 =?utf-8?B?YXRFRlMveHBFSlRDNTRvYVVzcEpUREJBbGhjQ0ptSHJTVDF1SGlUVzJTek5T?=
 =?utf-8?B?T0RXVEprSlpEUHNNaytTdU05SGY4Sk5oT3dGMW1QTUJVRHZ3ZE5CRHdpR3B5?=
 =?utf-8?B?VUh1NmlzSUVET3lmdGcrMW50aGRpSkdEYWxxR3FaWWdVQU4vTWdrOHNPMy9q?=
 =?utf-8?B?bW9BNk5uL05Odkgyd1JXRW8zWXVVMGNmUnhqVlV0SDJMMFUwd25yVlR1eFBI?=
 =?utf-8?B?WHA1NnNoRGxjelVUck5rWFY0bzR5aE8rbmR6RTVpc1VBVFg3dTcyOGF3Nlkw?=
 =?utf-8?B?dVJTRFI1c3FzbjdzdzlQVFVTdTE4YXBnYTlWNmZEcFpMVDM3dVV1QVZON3N5?=
 =?utf-8?B?eUlFbHFtL2dPamJYckU3RjJseHdjVnpuY1JqeWJ2emxmNDNJWXh0Z1hpQU9O?=
 =?utf-8?B?SjcwOGlyTFFDWHVyS1JBQnRSRzBrMHNRNkJDZjZGYUt2WXNERzd4eXZKQ0o3?=
 =?utf-8?B?a1NrWDdzQkNJZzFnMzNYc3ZycENDT0xOeGV2aHhxY0UwZjdubGJxaTJ2NzBB?=
 =?utf-8?B?QnlGUGdma25Pbm9tVWdJQldVc2FpVEFUaVV5ZGdOdkZ1VGVKbHBmVHgyc3BL?=
 =?utf-8?B?QjJXbCt1RHdlTThyY0NNTUZuT2wvbDFvUVAyYmQrRVN3UHUwQTA2SGg2VmYy?=
 =?utf-8?B?WWpOUTVWVnB3WDZCZGl4MkJJSEJ1MmczOEhIWjAwcHdjZ0xuKy92UDNXRUgw?=
 =?utf-8?B?WWw4TExZYXR2SWJaKzNvWm5yekQzclVpTWI2YzJCNSs0dHUyY1JoSG9rM3B5?=
 =?utf-8?B?MjcydVBZUW5ZYW5IVXJZZ3pya0NESkxJY2NRUzIwb0J3TVAvRjlqVDlKSjdH?=
 =?utf-8?B?WHVjWnNZRHRhNkVUSC9QUVQ1bVl0UDBvK25ucmhaeWtJZlhLaHlpZTJLbWZK?=
 =?utf-8?B?UkpSMjVTbnRDRUpjOTcxMGtDeFkrWXRaMnM1aGtuVXhzWDRiR054b0c4K3Az?=
 =?utf-8?B?UnJmVFp2UDFOZjFRcE9nNThtZklkUTVrUVBWdFFMK2V1UEk5VGYrNksyb1Ry?=
 =?utf-8?B?WWZSNStaNlFNRy9ROGxFbUp3ckdtK0p5Y2VERGtQMEFuMHMvSmliOVNZU0w3?=
 =?utf-8?B?bWIraU84ejNpTDFCRzVlWksyTWV5aTJ4MmRSR1g0YzdheVNDQ0FRWWV0UEZw?=
 =?utf-8?B?UUpSeG1LUkpScnkydXpxakUxbGJ0U2lXWGFsNEdpcTVyOUNIZ2ZObnNoQVM2?=
 =?utf-8?B?RHNHSTVvZklINUFiSWJMdUFsWGRvQ3VUWEpJamw5bWh5VVZSK2hxZzE5NXhD?=
 =?utf-8?B?cFhXYkZJeGJ0OXFZd1lRbzl1OVo2ZWRyd1dJeFhiakpEY0lmT2NJVFRkNkVT?=
 =?utf-8?B?UytLYlhZUXlVbURHN0IyajEwR0VhYm9jYk1YTnhGSmR5dzVqZEc2OXd0N3FM?=
 =?utf-8?B?SVRHLzUvUnNRMUlvZUNmQ2doMGt0N25GdmFVNkYwVGp6cEoyclVRbEpiQlpv?=
 =?utf-8?B?bERXYkJxWE1PQURvQmE1My9zMkNGNWFMUjlyMlBFaGVGVkJQY256cjVBTGU4?=
 =?utf-8?Q?IvWD8zgUCsHXLrm6tDQ9gC7RY?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1ACD80E24EAEA24D8C91AD54D0E8B204@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09955d58-393c-4b8c-ab9e-08da9191a454
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 11:59:53.9018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5Jy7crSwgI+aekrDrXe7yjyTt//pl1/QQ0K/l5ca9tAkBpPdzbF3Nd/1Od5grrJoR9r8+F0kLnVuI6/I14F0cP91i/VrEe7cn8ATjMgcN18=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1432
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDgvMDkvMjAyMiAxMjo1MCwgTGFkLCBQcmFiaGFrYXIgd3JvdGU6DQo+IEVYVEVSTkFMIEVN
QUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtu
b3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gSGkgR3VvLA0KPiANCj4+PiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPj4+IEZyb206IENvbm9yLkRvb2xleUBtaWNyb2NoaXAuY29tIDxD
b25vci5Eb29sZXlAbWljcm9jaGlwLmNvbT4NCj4+PiBTZW50OiAwOCBTZXB0ZW1iZXIgMjAyMiAw
MDozOA0KPj4+IFRvOiBhdGlzaHBAYXRpc2hwYXRyYS5vcmcNCj4+PiBDYzogUHJhYmhha2FyIE1h
aGFkZXYgTGFkIDxwcmFiaGFrYXIubWFoYWRldi1sYWQucmpAYnAucmVuZXNhcy5jb20+Ow0KPj4+
IHBhdWwud2FsbXNsZXlAc2lmaXZlLmNvbTsgcGFsbWVyQGRhYmJlbHQuY29tOyBhb3VAZWVjcy5i
ZXJrZWxleS5lZHU7DQo+Pj4gYXRpc2hwQHJpdm9zaW5jLmNvbTsgYXBhdGVsQHZlbnRhbmFtaWNy
by5jb207IGdlZXJ0K3JlbmVzYXNAZ2xpZGVyLmJlOw0KPj4+IGxpbnV4LXJpc2N2QGxpc3RzLmlu
ZnJhZGVhZC5vcmc7IGxpbnV4LXJlbmVzYXMtc29jQHZnZXIua2VybmVsLm9yZzsNCj4+PiBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBwcmFiaGFrYXIuY3NlbmdnQGdtYWlsLmNvbTsgQmlq
dSBEYXMNCj4+PiA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+Pj4gU3ViamVjdDogUmU6
IFtSRkMgUEFUQ0ggMS8yXSByaXNjdjogdmVuZG9yczogYW5kZXM6IEFkZCBzdXBwb3J0IHRvDQo+
Pj4gY29uZmlndXJlIHRoZSBQTUEgcmVnaW9ucw0KPj4+DQo+Pj4gT24gMDcvMDkvMjAyMiAyMjo1
MiwgQXRpc2ggUGF0cmEgd3JvdGU6DQo+Pj4+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sg
bGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cNCj4+Pj4gdGhlIGNvbnRl
bnQgaXMgc2FmZQ0KPj4+Pg0KPj4+Pg0KPj4+PiBPbiBUdWUsIFNlcCA2LCAyMDIyIGF0IDM6NDAg
QU0gPENvbm9yLkRvb2xleUBtaWNyb2NoaXAuY29tDQo+Pj4+IDxtYWlsdG86Q29ub3IuRG9vbGV5
QG1pY3JvY2hpcC5jb20+PiB3cm90ZToNCj4+Pj4NCj4+Pj4gT24gMDYvMDkvMjAyMiAxMToyMSwg
TGFkIFByYWJoYWthciB3cm90ZToNCj4+Pj4NCj4+Pj4+IGRpZmYgLS1naXQgYS9hcmNoL3Jpc2N2
L2luY2x1ZGUvYXNtL3NiaS5oDQo+Pj4+PiBiL2FyY2gvcmlzY3YvaW5jbHVkZS9hc20vc2JpLmgg
aW5kZXggMmEwZWY3Mzg2OTVlLi4xMGE3Yzg1NWQxMjUNCj4+Pj4+IDEwMDY0NCAtLS0gYS9hcmNo
L3Jpc2N2L2luY2x1ZGUvYXNtL3NiaS5oICsrKw0KPj4+Pj4gYi9hcmNoL3Jpc2N2L2luY2x1ZGUv
YXNtL3NiaS5oIEBAIC0zNyw2ICszNyw3IEBAIGVudW0gc2JpX2V4dF9pZCB7DQo+Pj4+Pg0KPj4+
Pj4gLyogVmVuZG9yIGV4dGVuc2lvbnMgbXVzdCBsaWUgd2l0aGluIHRoaXMgcmFuZ2UgKi8NCj4+
Pj4+IFNCSV9FWFRfVkVORE9SX1NUQVJUID0gMHgwOTAwMDAwMCwgKyAgICAgICBTQklfRVhUX0FO
REVTID0NCj4+Pj4+IDB4MDkwMDAzMUUsIFNCSV9FWFRfVkVORE9SX0VORCA9IDB4MDlGRkZGRkYs
IH07DQo+Pj4+DQo+IEkgYW0gaW50ZXJlc3RlZCB0byBrbm93IHdoYXQgaXMgdGhlIHN0YXR1cyBv
ZiB5b3VyIHBhdGNoIHNlcmllcyBbMF0uDQo+IA0KPiBbMF0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvbGttbC8yMDIxMDYwNjE0Mzg0OC5HQTU5ODNAbHN0LmRlL1QvI203ZjRjNGNkZmI5MmQ2Yzg2
NzJiYmZhYmViZGE3MjljZTQ3MDBlMTc3DQoNCkhlaCwgdGFrZSBhIGxvb2sgYXQ6DQpnaXQgZ3Jl
cCAiRVJSQVRBX1RIRUFEKiINCg0KVGhpcyBpcyBhbGwgY2FuLW9mLXdvcm1zIHRlcnJpdG9yeSB0
aGF0IHdlIGFyZSBoZWFkaW5nIHRvIGhlcmUsIGFzDQp0aGUgWmljYm8qIGV4dGVuc2lvbnMgaXMg
d2hhdCBpcyBtZWFudCB0byBiZSBkb2luZyB0aGVzZSBzb3J0cyBvZg0KdGhpbmdzLi4NCg0KDQo=
