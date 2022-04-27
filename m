Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84FA251122C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 09:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358650AbiD0HRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 03:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358616AbiD0HRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 03:17:02 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188E149C90
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 00:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1651043631; x=1682579631;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2R4VjUjnw5PKNM8hBnAzgrGYNVxaeQpOrmJDnS4kuZ0=;
  b=reLbF7gbH9IpX3GDTBHtfmxXMq9GHFDpJws3p0RUA9KmXE1+vv/a0jbx
   3aZnLCThDiYztfbnZpFb5HmVDl5BzDx0lYEmed7Ke5wHe6AbPfcDZ1/CC
   fJoUF7q8v/5phGGoYTt8WoU+DpjEC/t9bIAyz3H2hAKL7RdmgkdsQ29u4
   18FVXAfHBfsAvvelzaWWGLM+d8GsgudVOpJcz/ruBK2xqKQm10zxKiDzB
   D6aHpEbrVshF5SUBWVYwnf6NVgjOlAXwgPzozR4Wl309qOQcJwrzq3ApT
   IlBOPZJdWmJEV+V+xQoupVh5oMB0/SGLr7Waa3jc/9dyLAWZADSebjAYo
   A==;
X-IronPort-AV: E=Sophos;i="5.90,292,1643698800"; 
   d="scan'208";a="171072811"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Apr 2022 00:13:50 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 27 Apr 2022 00:13:49 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Wed, 27 Apr 2022 00:13:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lk/DHCvEe2lSr2ng37wYsA+yW3YEyy0kE1p/RzbD6OvvbDupComm5V8MsPp/o/EjzmYvFKHRXezTBbN5ibGPCcp+vAlpjPVm8XsU/ElNkeX6RdgBR6XzK/MntpI5kNq+agtBQ2rmgdLbfXZDtZ8bcDzQM1AhCQ/E+D/XFfn11qIIGsYVVpMma+MqKAW3rfssTng1hDI7xKTlKAmyJ9oEicZHEc8MoThn6Fq0z/nPLdeC4Y8dKht3kWVf3NpP0k0mjjzYNj1vIGliojmIkHr+6NoI4hxX5zxvBZF8Op9173cAJbAzi2C/o4DEJRzuavwLK1GpDQG2gCQ9jugMHEo3dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2R4VjUjnw5PKNM8hBnAzgrGYNVxaeQpOrmJDnS4kuZ0=;
 b=nfEKFQ4jQD3Nn76yyWPqAMDvt7kR1e43JkEJKr3Kkm4/g80hBBDfCRzocMShlROIptOF9g1Pu7QT8BFO/TFYuseLXndxbL9cpLcOQfmTxt1X6wZc80fGwMaV1lY/FsWhBn/eAse73YSkrvuqj3LsKXzd+TkBmPLnOjiraLwsL2Y+AhFjPBMCewhqFvLa+Ulj260RnMllv+nYqqbXNbJITLo6ZYA1FYwhD9wZv1iN7h5NzCfcx3X8mCDkSsSXKujIC9su9OtCaR0Ab95BAVJARuofRaSpXPPkXlIscvhGy7hOn/jfeFrNUCSTCz7tJzoN148dsM51gtqzrsd1o7cQug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2R4VjUjnw5PKNM8hBnAzgrGYNVxaeQpOrmJDnS4kuZ0=;
 b=kj3BBU9C3Kfjaqae59VY+2rD9ZFC0WJQeFhznIptl7KUfk7WAOyMg94zEeXzpmE4mylL6RQW1MHDVw0YJXpltCQUAJwSykj1/381u00fK5odWqEIOelRDqMTnknDBVJ9AQsj0Ulixus+JittEmbTUnapH2FaU6GOqw+d1GToNOQ=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by CY4PR11MB2056.namprd11.prod.outlook.com (2603:10b6:903:30::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Wed, 27 Apr
 2022 07:13:45 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::2447:4025:79e6:7c08]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::2447:4025:79e6:7c08%5]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 07:13:45 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <p.yadav@ti.com>
CC:     <michael@walle.cc>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Takahiro.Kuwano@infineon.com>
Subject: Re: [PATCH v4 03/11] mtd: spi-nor: core: Use auto-detection only once
Thread-Topic: [PATCH v4 03/11] mtd: spi-nor: core: Use auto-detection only
 once
Thread-Index: AQHYVU/7/NTsfvb/Zk+xiSXQh0nwdg==
Date:   Wed, 27 Apr 2022 07:13:45 +0000
Message-ID: <07b60613-21f2-678b-7551-cfd658ebd408@microchip.com>
References: <20220420103427.47867-1-tudor.ambarus@microchip.com>
 <20220420103427.47867-4-tudor.ambarus@microchip.com>
 <7f570c32-d0be-97ba-0a1b-9aca93cfbbf1@microchip.com>
 <20220421131657.d6hm7rltyxcb24wo@ti.com>
 <6f81d38b-5e4b-eaf7-0466-3c6fe5e84996@microchip.com>
 <20220427052000.xmctvowj4kuc727d@ti.com>
In-Reply-To: <20220427052000.xmctvowj4kuc727d@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a834ab15-37a8-4072-68df-08da281d77a1
x-ms-traffictypediagnostic: CY4PR11MB2056:EE_
x-microsoft-antispam-prvs: <CY4PR11MB2056A57337FDC67A6EE30BBCF0FA9@CY4PR11MB2056.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QVSGK78F1D1Fc6i55XUNaKlck3ey8pHDjl95UBT/YPEJ8ef0JH3L2nVK4u+zINUM3ww15LjIl4gEJ7nK0nkDvW3ksNbUzW1yN77DfGPypeodHz7FrlaLC3+B7O25hwAof1NARauLm74xGa+U1b8xyGWXbWbYx03cMccu97k8zPx2rg2iYxolnwVpgY4w/ApsgwgCggMRtP1j+6CX0shRwWayP6VhNbp7xZNm34qvg2fYx3SxnVfceMuMoD/wn1D3/JJp3wMjENZ5VVlk2HZ4Mc+2oUgExaEUp27s0NML+GyvExxAOqMBPIdJD1FEwvfY6inrdMrFV1QaAQYVeziJOlbX5Y0aR3mWvmQD0DkDyqPQ3W8ThqNa+Mpveh5t3rcpVOlc4cx+0jrE+zI3QWL/Xkl7GrRXRAz4IFkhWmFK9cB/gbhrHm/8oZgHXx73bpSA0ee47ZEUV6otF/Ak/sFvzYfPAlVkCYdPah6a9zP4TqmZGD9DNa+fNaMA8OqOUaB6wXOz1hvuIry2E2ttbzeOXtnfo9KOVMe9pxD6S6mvQwmaYaonkV+JX2E0SiFfQ/rTDoCUTzWQqzmVw+exyGaR18zO7OgxGiENAZD2ZHlwxmX+HKjCEEz72K858ABqSG4ZQwBWVzUcGY8PdnGoAr2HN9KZjiBLEkwE/tofuBp16GrQlCdq8Moqs6SmsCNHT3OiE0xw2jmn+03izDZgaBh8jmeMTYAAqfaGupXOp07W5Rp7rAhDxgXTNTICBZ3PMqETl/zkfhUOepdMvT5ulYGzqQCFDzNFMn6hdpvfj9F8AhSUHbmqv9o4yHZmIb2FdCEGN0mukY/mX2fX3OJGOwjI1L0LIpoSsbVdClcj612cjuDb2jb0pE6Q+KRftWqFG9IVB+aSQt2dG1AVXdGE/k3BoQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(66946007)(5660300002)(6512007)(91956017)(122000001)(8936002)(66446008)(66556008)(4326008)(76116006)(316002)(26005)(38100700002)(86362001)(31696002)(38070700005)(2906002)(508600001)(6486002)(966005)(71200400001)(64756008)(8676002)(66476007)(83380400001)(186003)(53546011)(6506007)(31686004)(36756003)(54906003)(6916009)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z0RYS3FxenhPWjZ2M3E3ekU1cGIwWFd0WXRHbS9wL3pLZThjSXpQZUQvVWoy?=
 =?utf-8?B?QzFMT2MxN0h0VzN4ZEpGVHBMdEJLQ3UzTlpac05aN2xBc0JxTGpLOFF0MnhD?=
 =?utf-8?B?YzNHNzdBQy9YcmpJWHZhakRMQkpubFpZOUhYT1lIYUwrQmNXM3pjSzBKZ1B2?=
 =?utf-8?B?UHkrUjI0QUgyblhCS3VzWEpFeWNIUFZnVVJDVHRGdit3V0dnaG9CeEFDQk5z?=
 =?utf-8?B?TFZUK0x0eGFkRVBHSkt2SjREcjJPRldsQy9ZdVNKa2RaNHNYbGZrbUdldVha?=
 =?utf-8?B?cG1qREwvTjA5TGRJRml5WUx1SU5ZR1lvL0lkZENsZklhalNEanBOaW85UFgv?=
 =?utf-8?B?U1F5VFpYd2UxbHZDTlVuNm9ic0oyVXRxdVF0TXkwUHJpeTVEb0pmQ1E4VnJ3?=
 =?utf-8?B?QUpiVWFmOTBBZW5uMlY3cXdXNndtN3pNbVdCUTY1aUMwZW9MZUNzY3J2TjBu?=
 =?utf-8?B?emtsaW1Ua1I0R2s5RXMvUEo4cmFZaXhSdlB0a25RbUY5WngydFNxbSt2SE9F?=
 =?utf-8?B?UUVzT3doSjJCZ201WENTbGlESG5ORFNjMGJPV0ptVnk2UFdRRlpXQWJqODAr?=
 =?utf-8?B?MDJJRGJMRnYyeTNhSDM3bTVNdFFDdHYxeWxzMUU1bk5WT3pndkpnSUcxQklJ?=
 =?utf-8?B?ajRHRVFyNm1PZnpjSDg2MlhZblBSYnhWNWMvbjdIQlJMdEFvaURtaVlFM291?=
 =?utf-8?B?VjE5WTJ3VWpWc0xZUTdEZkxaMEJReHdBT3ZHcjNxR2NCNHErbkx3OHU1bjZI?=
 =?utf-8?B?ekpEUVkvQVJtRWRaQ3JYamZldFZCVzZ3UzdvVW03dGJvWmxqcjVZaE5hcm1x?=
 =?utf-8?B?V3JrRkd2cnphYnMyNERsK1hzVXAwcWQzV0J0NGtYczBiRDAwM0pZNWpDWXBZ?=
 =?utf-8?B?S2liLzBRMWszcFUrQ2tFSVpTZ2YzaFI5QnEyN1lWdkIreDh6UEJab2o1b0ZI?=
 =?utf-8?B?UEtFYnJNOEhiRUZmamg0SWNURXhUREl6VE9QK3p0YWlneVMwalpKMUpLRU4w?=
 =?utf-8?B?cGJ6UnZUL2w2TjVraVZFaElUT29tUkNFM1JvVGlScXRGS1FTNDQ4LzNUOTVO?=
 =?utf-8?B?WFAvOVl3TzRXMUFCUVEyUWVTQnlxbjN4NjJzTm5NRnc4UVFOeE9hZEsvNHVx?=
 =?utf-8?B?cHpSWXh1Q3dHcFRXS3g1YTNxZnpKR003bFBXM09Md1FIbHdoalZLcmxrQnlw?=
 =?utf-8?B?NE5MQm94VFpRb1RNUDJTVitBRHhJZ1c5SG5aZDAzeDdTRzVucXVLSFFQQjhC?=
 =?utf-8?B?bnZWcHhwWUZoNjVXK3YwUExrd2ZGUVpWM0ducDBLOHpDa0Z4bXloNm9tVkRE?=
 =?utf-8?B?eTRqQUc4KzY2MkI0dmRraUFNZHZRUEI4NFBMUUlNblgydG5YYm4xWUp1WEt5?=
 =?utf-8?B?YTNra201Q2Z3cmNyVFAzb0NSNUdtNUFZQ3BOOGtuSjlrNHRGTVlDb1BLUjRH?=
 =?utf-8?B?ZGwxWktkbSsxRk83b2p1TGd4aWZVTkw3WEFFT3JYZ1NlRFlFdVBoaFBkQWdD?=
 =?utf-8?B?aDdmL3lZeWptNUpJTVk3dkpUM1NXUC8rMDVYNTJNTE0rMnFOS21VcVJ4WkRS?=
 =?utf-8?B?VDRVSkdUcjVaQW9nTCtGK1BqSzNkSTVPNXFuWHdwRWtDWVJsUTlrbE5MTmZa?=
 =?utf-8?B?REpDZkdSRU1PeHpCeFc5QzJGdTAvT24rOWcyWWlibm00Q0pCZHlWZ2NlcUNh?=
 =?utf-8?B?RWsrdVFITG1OdHNiNmRmY3g5MllMOGpxMXQzaTNhcU44NHhoYmNCdHRFVGJT?=
 =?utf-8?B?Z1puVzJqT01WUWxoeGFGa3ZhQjRGUGtLNURucWRLaVI5OGZSSVJVQzZNc0U5?=
 =?utf-8?B?M0FibjR5YkNPYjhlc0h2YmhDdDczOTRJcE9mQW1xdDZEZjR0TC8vWmZKTE1k?=
 =?utf-8?B?WDh2VGM4SzFlcUtrOW9BWEMrVmFocXl3ZUxyOG5XeitjYUVscUVvTUxvTUlt?=
 =?utf-8?B?OXp6WmdoYjkxcndEQ3pOWDRtNmJKVitYekpRTzhPcmttK3pmTEE3Y2ZnWDl0?=
 =?utf-8?B?Y0lNTWxNd0EyWG5sN1Zqb3ZoWFQwZExtMVFvaG5udVRvOXAyOFo0aDdXaWtu?=
 =?utf-8?B?dEg3NFN0ZVdkM2dtME5uMkFwaW5MemRUN3RHMEtJUnFGK05WTmZrZnFtYlI3?=
 =?utf-8?B?VjRjV3JDdTRBbWhRTEVta0hRZmtZS0VLaTdFdWFVZFN3WDl5QUxXTUprMHNP?=
 =?utf-8?B?N2lJZnBvMWtwa3pXc080R2RIaTViaTI3aU11TTlQeW8ycWdXVUdhSEx6NG9P?=
 =?utf-8?B?UzUwNjVIbzhzSlNWYldubkxhSGRtQzhJdkQ2V0dUZkZkVEEvUDFwL2NsRXlZ?=
 =?utf-8?B?c2lHZ2hJSlhCMDRYRmtoYWtPVEorQ200d2FaZVhRV2NMTGNEL05kOUpTNFUy?=
 =?utf-8?Q?xax7JYTcuNENyj7Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1C7C573DAE1E21498243EB6A93DBD93D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a834ab15-37a8-4072-68df-08da281d77a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2022 07:13:45.2263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y+AOqHz/Fr4Wv6WARPTx5OpmxCv4e5uqLFEJabiTbbrR1ElwhCVGHwKtvTnbWe302JkGhMh87Vr6751PB1Al6iQyQ7nLvwrv/2uEbZZj1hs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB2056
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC8yNy8yMiAwODoyMCwgUHJhdHl1c2ggWWFkYXYgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlM
OiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cg
dGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gMjEvMDQvMjIgMDE6NDFQTSwgVHVkb3IuQW1i
YXJ1c0BtaWNyb2NoaXAuY29tIHdyb3RlOg0KPj4gT24gNC8yMS8yMiAxNjoxNiwgUHJhdHl1c2gg
WWFkYXYgd3JvdGU6DQo+Pj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBv
cGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+Pj4N
Cj4+PiBPbiAyMS8wNC8yMiAwNzoxOEFNLCBUdWRvci5BbWJhcnVzQG1pY3JvY2hpcC5jb20gd3Jv
dGU6DQo+Pj4+IEhpLCBQcmF0eXVzaCwNCj4+Pj4NCj4+Pj4gSSBmb3Jnb3QgdG8gcmVtb3ZlIGZl
dyBjaGVja3MsIHdvdWxkIHlvdSBwbGVhc2UgcmVtb3ZlIHRoZW0gd2hlbiBhcHBseWluZz8NCj4+
Pj4gU2VlIGJlbG93Lg0KPj4+Pg0KPj4+PiBPbiA0LzIwLzIyIDEzOjM0LCBUdWRvciBBbWJhcnVz
IHdyb3RlOg0KPj4+Pj4gSW4gY2FzZSBzcGlfbm9yX21hdGNoX25hbWUoKSByZXR1cm5lZCBOVUxM
LCB0aGUgYXV0byBkZXRlY3Rpb24gd2FzDQo+Pj4+PiBpc3N1ZWQgdHdpY2UuIFRoZXJlJ3Mgbm8g
cmVhc29uIHRvIHRyeSB0byBkZXRlY3QgdGhlIHNhbWUgY2hpcCB0d2ljZSwNCj4+Pj4+IGRvIHRo
ZSBhdXRvIGRldGVjdGlvbiBvbmx5IG9uY2UuDQo+Pj4+Pg0KPj4+Pj4gU2lnbmVkLW9mZi1ieTog
VHVkb3IgQW1iYXJ1cyA8dHVkb3IuYW1iYXJ1c0BtaWNyb2NoaXAuY29tPg0KPj4+Pj4gUmV2aWV3
ZWQtYnk6IE1pY2hhZWwgV2FsbGUgPG1pY2hhZWxAd2FsbGUuY2M+DQo+Pj4+PiAtLS0NCj4+Pj4+
ICBkcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuYyB8IDEzICsrKysrKysrLS0tLS0NCj4+Pj4+ICAx
IGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPj4+Pj4NCj4+
Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuYyBiL2RyaXZlcnMvbXRk
L3NwaS1ub3IvY29yZS5jDQo+Pj4+PiBpbmRleCBiOWNjOGJiZjFmNjIuLmI1NWQ5MjJkNDZkZCAx
MDA2NDQNCj4+Pj4+IC0tLSBhL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5jDQo+Pj4+PiArKysg
Yi9kcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuYw0KPj4+Pj4gQEAgLTI4OTYsMTMgKzI4OTYsMTQg
QEAgc3RhdGljIGNvbnN0IHN0cnVjdCBmbGFzaF9pbmZvICpzcGlfbm9yX2dldF9mbGFzaF9pbmZv
KHN0cnVjdCBzcGlfbm9yICpub3IsDQo+Pj4+PiAgew0KPj4+Pj4gICAgIGNvbnN0IHN0cnVjdCBm
bGFzaF9pbmZvICppbmZvID0gTlVMTDsNCj4+Pj4+DQo+Pj4+PiAtICAgaWYgKG5hbWUpDQo+Pj4+
PiArICAgaWYgKG5hbWUpIHsNCj4+Pj4+ICAgICAgICAgICAgIGluZm8gPSBzcGlfbm9yX21hdGNo
X25hbWUobm9yLCBuYW1lKTsNCj4+Pj4+ICsgICAgICAgICAgIGlmIChJU19FUlIoaW5mbykpDQo+
Pj4+PiArICAgICAgICAgICAgICAgICAgIHJldHVybiBpbmZvOw0KPj4+Pg0KPj4+PiBBcyBNaWNo
YWVsIHN1Z2dlc3RlZCBzcGlfbm9yX21hdGNoX25hbWUoKSByZXR1cm5zIE5VTEwgb3IgdmFsaWQg
ZW50cnksIHNvIHRoaXMNCj4+Pj4gY2hlY2sgaXMgbm90IG5lY2Vzc2FyeSwgbGV0J3MgcmVtb3Zl
IHRoZW0uDQo+Pj4+DQo+Pj4+PiArICAgfQ0KPj4+Pj4gICAgIC8qIFRyeSB0byBhdXRvLWRldGVj
dCBpZiBjaGlwIG5hbWUgd2Fzbid0IHNwZWNpZmllZCBvciBub3QgZm91bmQgKi8NCj4+Pj4+ICAg
ICBpZiAoIWluZm8pDQo+Pj4+PiAtICAgICAgICAgICBpbmZvID0gc3BpX25vcl9yZWFkX2lkKG5v
cik7DQo+Pj4+PiAtICAgaWYgKElTX0VSUl9PUl9OVUxMKGluZm8pKQ0KPj4+Pj4gLSAgICAgICAg
ICAgcmV0dXJuIEVSUl9QVFIoLUVOT0VOVCk7DQo+Pj4+PiArICAgICAgICAgICByZXR1cm4gc3Bp
X25vcl9yZWFkX2lkKG5vcik7DQo+Pj4+Pg0KPj4+Pj4gICAgIC8qDQo+Pj4+PiAgICAgICogSWYg
Y2FsbGVyIGhhcyBzcGVjaWZpZWQgbmFtZSBvZiBmbGFzaCBtb2RlbCB0aGF0IGNhbiBub3JtYWxs
eSBiZQ0KPj4+Pj4gQEAgLTI5OTQsNyArMjk5NSw5IEBAIGludCBzcGlfbm9yX3NjYW4oc3RydWN0
IHNwaV9ub3IgKm5vciwgY29uc3QgY2hhciAqbmFtZSwNCj4+Pj4+ICAgICAgICAgICAgIHJldHVy
biAtRU5PTUVNOw0KPj4+Pj4NCj4+Pj4+ICAgICBpbmZvID0gc3BpX25vcl9nZXRfZmxhc2hfaW5m
byhub3IsIG5hbWUpOw0KPj4+Pj4gLSAgIGlmIChJU19FUlIoaW5mbykpDQo+Pj4+PiArICAgaWYg
KCFpbmZvKQ0KPj4+Pj4gKyAgICAgICAgICAgcmV0dXJuIC1FTk9FTlQ7DQo+Pj4+DQo+Pj4+IGFs
c28gYWNjb3JkaW5nIHRvIE1pY2hhZWwsIHRoaXMgY2hhbmdlIGlzIG5vdCBuZWVkZWQgYXMgc3Bp
X25vcl9nZXRfZmxhc2hfaW5mbygpIGNhbid0DQo+Pj4+IHJldHVybiBOVUxMLiBIZXJlIHdlIGNh
biBrZWVwIHRoZSBjb2RlIGFzIGl0IHdhcy4gTGV0IG1lIGtub3cgaWYgeW91IHdhbnQgbWUgdG8g
cmVzcGluLg0KPj4+DQo+Pj4gVEJIIEkgZG9uJ3QgdGhpbmsgYSBOVUxMIGNoZWNrIGhlcmUgaHVy
dHMgbXVjaCBzaW5jZSB0aGUgYmVoYXZpb3VyIG1pZ2h0DQo+Pj4gY2hhbmdlIGxhdGVyLCBhbmQg
ZXJyb3IgcGF0aHMgZG9uJ3QgZ2V0IGV4ZXJjaXNlZCBhcyBvZnRlbi4gQnV0IEkgaGF2ZQ0KPj4N
Cj4+IEkgYWdyZWUsIGJ1dCBhdCB0aGUgc2FtZSB0aW1lIHdlJ3JlIGludHJvZHVjaW5nIGNoZWNr
cyBncmF0dWl0b3VzbHkuIFNpbmNlDQo+PiBNaWNoYWVsIGNhcmVkIGFib3V0IGl0LCBpdCdzIGZp
bmUgdGhhdCB3ZSByZW1vdmVkIGl0LiBJIGRvbid0IGNhcmUgdG9vIG11Y2gNCj4+IGFib3V0IGl0
Lg0KPj4NCj4+PiBtYWRlIGJvdGggY2hhbmdlcyB3aGVuIGFwcGx5aW5nLiBZb3UgY2FuIGRvdWJs
ZS1jaGVjayBhdCBbMF0gaWYgeW91DQo+Pj4gd2FudC4+DQo+Pj4gWzBdIGh0dHBzOi8vZ2l0aHVi
LmNvbS9wcmF0aTAxMDAvbGludXgtMGRheS9jb21taXQvNjdkOTEzNzQ2ODMzZWU1NGJmNGM2NjEw
NDBmM2VmMTM2NTdkZmZkOA0KPj4NCj4+IGxvb2tzIGdvb2QuDQo+Pg0KPj4gYnR3OiBJIHRoaW5r
IHRoaXMgcGF0Y2gNCj4+IGh0dHBzOi8vZ2l0aHViLmNvbS9wcmF0aTAxMDAvbGludXgtMGRheS9j
b21taXQvYjQ1YmJmZjg1ZDQ5NTI5ZjhkYWZmODNjMzQxYTI5MmY2YzY0OTJjYQ0KPj4gbWF5IGlu
dHJvZHVjZSBhIHJlZ3Jlc3Npb24gb24gc29tZSBhdG1lbCBjaGlwcy4gTGV0IG1lIHRyeSBpdCBw
bGVhc2UuDQo+IA0KPiBEaWQgeW91IGdldCBhIGNoYW5jZSB0byB0cnkgdGhpcyBvdXQ/IElmIGl0
IHdvcmtzIGZpbmUsIEkgd291bGQgbGlrZSB0bw0KPiBhcHBseSBpdC4NCg0KSSB0cmllZCBpdCBv
biBhIGF0MjVkZjMyMWEuIFdoZW4gY2FsbGluZyB1bmxvY2ssIGV2ZXJ5dGhpbmcgc2VlbXMgZmlu
ZS4gSG93ZXZlcg0KSSBoYXZlbid0IHRyaWVkIGEgbG9jay91bmxvY2sgY3ljbGUgYXMgbG9jayBp
cyBub3Qgc3VwcG9ydGVkIGFuZCBJIGNvdWxkbid0DQphbGxvY2F0ZSBtb3JlIHRpbWUuIEV2ZW4g
aWYgdGhlcmUgd2lsbCBiZSByZWdyZXNzaW9ucyB3ZSBjYW4gaGFuZGxlIHRoZW0NCmFmdGVyd2Fy
ZHMsIHNvIGxldCdzIGFwcGx5IGl0Lg0KDQpDaGVlcnMsDQp0YQ0K
