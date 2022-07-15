Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA65575F6C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 12:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbiGOKda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 06:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiGOKd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 06:33:26 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033FD83F1D
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 03:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657881200; x=1689417200;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=VXKpDS542CqJOJy/Gb88xarmtuzDn0bX6Mpn6ssk/zU=;
  b=WtmMZ9PeDCPTxs8k6iMu0TsGh+/pfCuVtCC+2oaGwGEww2kDq+gi8LkL
   DcAck0ES+Ai9UtSROhGOK53VwMro68ufSwDLuK+NBnLklilpD6EJh5iKA
   kHO/eGyuyf59Wz9aaUvRHoMmmmsbFRymv4+cR7XEyPbyuRcdPE74m52RM
   DZI8zsTe3hWcr2e9w392cQHMHDnyZQDYbTz15G6WcWdo/SdtyN8ssJ0WK
   PABndZbUMiED02jlE/DxQTm+897dwMWtANAld9dovXlkfAZALy1s8wzik
   U0V10vPIJQhbkFkh4SJjIShgfq8C6BDn+Ft3aq0cDyCZvDXg5A+OTCjww
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,273,1650956400"; 
   d="scan'208";a="167983728"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Jul 2022 03:33:20 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 15 Jul 2022 03:33:20 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Fri, 15 Jul 2022 03:33:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QrsL+U36y950ax6H/Zitsf1H7jyNXO+C9smCxpQ+Zd0iEMjf19x9KlsBODDO/YxBX+ISbSb535jb8pozQ5fdxZK0/cMDVmEf1SYDliO1XH62qbW8Si9rlnfxoBEWPB65BUp3l9dm2CYSlrFFU6N9FEt6i5a/+Ih73QiNoqumcXXRWNw4A5lFzFtiwu0k46OZLDLytbQjASbKUKHhebKmjE/fwa4jXjtryIX/hd/6FUojUU52RW6DpahPZCxotQQNtUXHqfv8QucLQvFeF5dQoJTjhnu7tx3yrPhBK4RYG1V1WtJCF+MKFaqzAp84LZHmrJs/OByUPD0JhtOJ7hMpZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VXKpDS542CqJOJy/Gb88xarmtuzDn0bX6Mpn6ssk/zU=;
 b=CjHVZeS4cyrmSgUoLQarkbotrRwSeXrGBSLqIo/uFiATye8BaV+g1L+9lbiakfvxxoV62ppoUJdewkJr+yF0OpEysDxZiHFxnAwgTV+3AlQGleQGgLpLuIq4X099HCc79wYXyO9/8myVj0uhtXl9tfC8mP5hBeVwYDXTNrAt0RRHzq+sqt+sLlKcdaNL3D+1KeMP2uhdjYaqokzet20Vn6C6WfqpAdG9Fm4jBcwC9B3SUfBS4Pb/ohEYBRSLYg3h56wFQUPg7jIpagwPwnDJ+ppCJ8VAmWLGpf2T47o2Ofwa/9fsR8jkysEOMxGZ8nP90JEzfz5FwEDvz0pwz62mnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VXKpDS542CqJOJy/Gb88xarmtuzDn0bX6Mpn6ssk/zU=;
 b=dZQvxHusPsSAYt+WAMXTY88JLyleSMsRqQT599ukJ+uYDOIqzvbYk+nVrkVXIG0ZOG5PQyBHUYBNXNkR+QGme9KrWMchvzumDT97aERT+ZRLRFM6640Qbc48MesJLtf4Hbia8jMkKahtAkO7OSHvfYGF+hQ85nj62j4iNu3f/qs=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DM5PR11MB1625.namprd11.prod.outlook.com (2603:10b6:4:b::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.13; Fri, 15 Jul 2022 10:33:17 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::357a:acc9:829e:bf7b]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::357a:acc9:829e:bf7b%7]) with mapi id 15.20.5438.014; Fri, 15 Jul 2022
 10:33:17 +0000
From:   <Conor.Dooley@microchip.com>
To:     <sudeep.holla@arm.com>, <linux-kernel@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <Conor.Dooley@microchip.com>
CC:     <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
        <ionela.voinescu@arm.com>, <pierre.gondois@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH -next v2 1/2] cacheinfo: Use atomic allocation for percpu
 cache attributes
Thread-Topic: [PATCH -next v2 1/2] cacheinfo: Use atomic allocation for percpu
 cache attributes
Thread-Index: AQHYmDVjHKZFl0MGukuqHSdNWJS2ga1/PDyA
Date:   Fri, 15 Jul 2022 10:33:17 +0000
Message-ID: <388a12c8-7c8c-0a43-9b28-bbea880eea10@microchip.com>
References: <20220715102609.2160689-1-sudeep.holla@arm.com>
In-Reply-To: <20220715102609.2160689-1-sudeep.holla@arm.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 21be56b0-8254-4d24-8dac-08da664d6e41
x-ms-traffictypediagnostic: DM5PR11MB1625:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LbCCZZ6P3O07xTFjD/XyVqlBDMhZdXnVq2A8PEPZTDejCfgj96ePCS2QaI3GPycs5PRva3ShTIsQuX8jMIdUhFrkGTCAgsQf7EEnLB9/B6i+78XJ1jxPM5xq727zBpJZiPpwqHEa+VEE5S2A8yxIhP5T2M7JD4pSaXKsB1e6zMQKd9rdulG+GYb+GZ5dd5toCdJ9B2nvm4qdDt5p6A3PuLbDqiCSjO8gN26MVcy5i/D7M302MA6DnIC0pTWSP/UR13zZtKV1MHSOFYlN8LWLvTbQME0DixokIM2Ay2j5N7BqNtQU8IBDGbL3f64DCkyqPlnxnGYMYPwi9dJJlsuV1KyzBdDY7muBijm1dH4a/2sCVZ46f0AQUv+CwjhdK/Mr613n7MhRN8giOLTu+zaVMl/j3wTXdmU1SJ3ZhJvnCoksN34d90zerXb+nfZiMirUTagOy4e8gXRPWGELmyZI1G6cUypigdIs2ybT2M3o9vGE3Dgri0iSEplmQV0vBoey9es1EGw+LLGKlLGiY7O+O4eT/x9YkTXV/kGuKnpgMcvT9k5iCfEfQ1XG8ux0SkpuVEP4heYwqlWeRM6iPCqJKO9F7GMia/CYDbKxluJtfPsQbRPz4WFLXV2Ra7c0TnMyQGRnWB57hISz4Cio92Mp08jhpgtozoyQWV6PvA3CCtUY6OR717LjFn1dupqmUUHISJbWDcYZcHb1w4g089Sj4DcttNy1ycl2GRjLR60TH8e9cTEcq4HfNeidJHs7lThbqVZumxSLtpEFYxBLxYKiTm/HQeZFGpooOgXukjaewBbWWhFs2YE/2tQPKltfGV4LGE+GoOatnwiYVRxeWUgC5L8q2oLEXkqv+/hM9a8n95t+2GRPtOek8xE4xvKle9UD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(376002)(136003)(396003)(366004)(346002)(38100700002)(38070700005)(2906002)(86362001)(122000001)(54906003)(31696002)(8936002)(53546011)(91956017)(66556008)(478600001)(316002)(26005)(41300700001)(5660300002)(6486002)(6512007)(66946007)(66446008)(2616005)(186003)(8676002)(64756008)(31686004)(4326008)(36756003)(66476007)(71200400001)(83380400001)(76116006)(6506007)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dVNZMTFuMEhMb3JTUW9nUXBPNmh1cWw5eUNXMzgwT2h6Qm9LcTJrQlBjTG1j?=
 =?utf-8?B?SWc1M1ZsNGNVeVhiWWt5SVNjbW9aZXV4aXlDTlFPdi9SUVpzK3JpNDNTaVFK?=
 =?utf-8?B?cENyemRXbFQ3SlovR2ZHd1RpZU5ZUFF5U3l3bTkxdkNscG5kSWVZV0llc1d0?=
 =?utf-8?B?VXZJbE44dko1ZjFNOXNHMGZzL1R6cUppTUxteURITmZrUVFjVlJJWGFlNTRD?=
 =?utf-8?B?WXdBQTh1d0dsbTJTVmNHY0dsM09pOEdjYnBOVXJycmtCZlQxVGpJbDdrSDl4?=
 =?utf-8?B?NzNQTGlyQldJYkQ2WGpuMEFLUkNwRm5oZEpnQzQ0d3BvcVRmS0ZNeCtRSUV5?=
 =?utf-8?B?TFpqcUdUWExrRlhndFVhb0NIcUVtVCtIb2lGNXozZnhnSjcyQksyeHlwUHJ5?=
 =?utf-8?B?aEEzYlhrR2tidmVmSWg5b1k3MVROUndscEZDZE0zdittQ21RYTgvczF3T29a?=
 =?utf-8?B?TzFIbWhNeE5lZW9TY25BWm1lMXdCVGFZalIwaGV1cVhnb1RTNVpmOUZwOTR1?=
 =?utf-8?B?a0FFRFVPTnd5SE5ScjZhV1hEMGNTeDdpcGQwTkowTkZJaXIrOTFsR2V3anBx?=
 =?utf-8?B?cUVsV3dHbS85RVNJUEJsK05rdG5DeWVnbXhFcnZLUk1MZ0xMQm9uTm5seHkw?=
 =?utf-8?B?T3lSaTNsRVoxbmd2UEhlNVVMSlN4M3dJMldlUVVIOUZYUWFrZVEraGxCZU10?=
 =?utf-8?B?RUhXNlRqdFpGNXlnTjcyaTRZa0syRy90dzJBQnBrRStrdi9uL0t0My94dDF5?=
 =?utf-8?B?WUIwMUdKOGNvYlU1NjZGakR1RHNocmE1YktrekdZM3RPdVJlN0p0ekJKT1hm?=
 =?utf-8?B?QjFhS0dkVVl4OURuT25MRnlUKzRrZEpXNXpCSWZWeitiNXBHMDFta0FQRUov?=
 =?utf-8?B?THdQYUphOVhaU1FrMnF1WndwNnpBNWV5bmllbERDNEtJbmtjRmVPYWUxbThv?=
 =?utf-8?B?TTM1V2RvZ2pXcnV0VkNHSVZjRHVnQW9GYUVnYS9SSVNRUXRYa3dVTy8rKzZM?=
 =?utf-8?B?NTNKYVlaN0lFejZTVXRSbEx0MFJUNmVOTWl4MTZiTFp6NWs1Nll5b0NiZkNi?=
 =?utf-8?B?S2JpU0I4SjEwSTN4QUNEV2dQaW9JM0t5NG9JUVF2cGJoajhjMitQRWhXQzY0?=
 =?utf-8?B?azlkL3ppbWxBVXNyTVpubFA0K1Zmalc4a3lVeklVa0k2TmVzdEkzYVJPRytz?=
 =?utf-8?B?M2tENzF5Tmx6cXZ2ZTZaa0VVdDBobVNkY2orRmJCMkVOTklkL0JrTlRwa2FZ?=
 =?utf-8?B?M0ovSW44MytpcDRQcnJURytkL04vWHFOOGN3QXRHR3NKZmNyOGRIM0VJaC9k?=
 =?utf-8?B?MFowTmVIUFNVQVZ5VzVJZWk5bEVld0RlYjAybUpKTEhOdWZKL1FNcENTaEdt?=
 =?utf-8?B?S2JDRzR5V2NIV0RIMlB4b2RmZjFvQUdrWTlqb0FDY0doY0F3dU9xYW4wZWk4?=
 =?utf-8?B?d1JUVHQvaVVZNm9yZHBoanZpOHlhTk9lTHlWelJlOUJ0OTFJWjRMZE5HTmhP?=
 =?utf-8?B?bUdXd24vcDU1NXg1azVTWlpDNDM1WWhHTWdBOEl5OXBrYStpWUNYTXcwVUxB?=
 =?utf-8?B?ZTdUN0NQNno5TWdpYXIzT0RKejMvKzVqYmdReHUvdjYzV1AwMlQxczNDZUdK?=
 =?utf-8?B?N29DRjdoVEZsc2YySzFKQ29hbUlHcXVDMnlvRkdUOWVuMStqQkc1ckNZd3Yw?=
 =?utf-8?B?TllUZjloTjJMK1pkdHdMalpBbDBXdE5QN20zVTFNMDBPWXlVbUgxZHpGSEhx?=
 =?utf-8?B?TmtUaTJYZ3hnSzJneE5VYnkyeTIwTHluVWxxckhrMXJ5ei9JdEF4R2Juc1E5?=
 =?utf-8?B?YVI0bkxaMGpPU2hLQk0wTzRIYUFLVnlqTzlWUnAzdVhDbTBrMXFReEMrRHJl?=
 =?utf-8?B?aHZlWGFIMVV1cG9OQ054M2tTNjByTm1yeFJ2OGpMSmx2SzdkR2RYbWpQeXRX?=
 =?utf-8?B?c0U0WUZFZmp6QkorOXUyUnFNNmNkcERUNUFUS2dPc0t5VnNwMmZJOWNlMDB4?=
 =?utf-8?B?WHdnRSs0MWVueS91YWhiQUxOU2dUaVFWQzhzdnVQOEdmWDl5ZG5RZzNaT1ly?=
 =?utf-8?B?VUgxZWJSYnRDbldTWVJPMnYwQlIrYlN0OHZ0UCtGbnUzODh0eHNZZjRuS2Mw?=
 =?utf-8?Q?3Z+7ZlyEJux7VjNKZNzWrZboP?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <54EDD9651F36274E9F6921F6E633EDCE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21be56b0-8254-4d24-8dac-08da664d6e41
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2022 10:33:17.4339
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H5lpwj5xnGdWsKHKhkGji6AbT3hSCbHT2IMyJR1tq371wnVFVfw3lyHIEs+jtsZZ5RSoViUVNxRd5jN1gpCBzHqGRz8ACGGLbDLY34p/RJ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1625
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTUvMDcvMjAyMiAxMToyNiwgU3VkZWVwIEhvbGxhIHdyb3RlOg0KPiBPbiBjb3VwbGUgb2Yg
YXJjaGl0ZWN0dXJlcyBsaWtlIFJJU0MtViBhbmQgQVJNNjQsIHdlIG5lZWQgdG8gZGV0ZWN0DQo+
IGNhY2hlIGF0dHJpYnVlcyBxdWl0ZSBlYXJseSBkdXJpbmcgdGhlIGJvb3Qgd2hlbiB0aGUgc2Vj
b25kYXJ5IENQVXMNCj4gc3RhcnQuIFNvIHdlIHdpbGwgY2FsbCBkZXRlY3RfY2FjaGVfYXR0cmli
dXRlcyBpbiB0aGUgYXRvbWljIGNvbnRleHQNCj4gYW5kIHNpbmNlIHVzZSBvZiBub3JtYWwgYWxs
b2NhdGlvbiBjYW4gc2xlZXAsIHdlIHdpbGwgZW5kIHVwIGdldHRpbmcNCj4gInNsZWVwaW5nIGlu
IHRoZSBhdG9taWMgY29udGV4dCIgYnVnIHNwbGF0Lg0KPiANCj4gSW4gb3JkZXIgYXZvaWQgdGhh
dCwgbW92ZSB0aGUgYWxsb2NhdGlvbiB0byB1c2UgYXRvbWljIHZlcnNpb24gaW4NCj4gcHJlcGFy
YXRpb24gdG8gbW92ZSB0aGUgYWN0dWFsIGRldGVjdGlvbiBvZiBjYWNoZSBhdHRyaWJ1dGVzIGlu
IHRoZQ0KPiBDUFUgaG90cGx1ZyBwYXRoIHdoaWNoIGlzIGF0b21pYy4NCj4gDQo+IENjOiBJb25l
bGEgVm9pbmVzY3UgPGlvbmVsYS52b2luZXNjdUBhcm0uY29tPg0KPiBUZXN0ZWQtYnk6IENvbm9y
IERvb2xleSA8Y29ub3IuZG9vbGV5QG1pY3JvY2hpcC5jb20+DQoNClNpbmNlIHRoaXMgd2FzIGEg
Y29udmVyc2lvbiBmcm9tIGNvbW1lbnRzIG9uIHRoZSBvdGhlciBzZXJpZXM6DQpBY2tlZC1ieTog
Q29ub3IgRG9vbGV5IDxjb25vci5kb29sZXlAbWljcm9jaGlwLmNvbT4NCg0KPiBTaWduZWQtb2Zm
LWJ5OiBTdWRlZXAgSG9sbGEgPHN1ZGVlcC5ob2xsYUBhcm0uY29tPg0KPiAtLS0NCj4gICBkcml2
ZXJzL2Jhc2UvY2FjaGVpbmZvLmMgfCAyICstDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBIaSBHcmVnLA0KPiANCj4gQ2FuIHlvdSBhcHBs
eSB0aGVzZSBjb3VwbGUgb2YgcGF0Y2hlcyBkaXJlY3RseSBpZiBhbmQgd2hlbiB5b3UgYXJlIGhh
cHB5DQo+IHdpdGggdGhlbSA/DQo+IA0KPiBSZWdhcmRzLA0KPiBTdWRlZXANCj4gDQo+IHYxLT52
MjogVGhpcyB3YXMgYWRkZWQgaW4gdjINCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Jhc2Uv
Y2FjaGVpbmZvLmMgYi9kcml2ZXJzL2Jhc2UvY2FjaGVpbmZvLmMNCj4gaW5kZXggNjVkNTY2ZmYy
NGM0Li40YjVjZDA4YzVhNjUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvYmFzZS9jYWNoZWluZm8u
Yw0KPiArKysgYi9kcml2ZXJzL2Jhc2UvY2FjaGVpbmZvLmMNCj4gQEAgLTM1Niw3ICszNTYsNyBA
QCBpbnQgZGV0ZWN0X2NhY2hlX2F0dHJpYnV0ZXModW5zaWduZWQgaW50IGNwdSkNCj4gICAJCXJl
dHVybiAtRU5PRU5UOw0KPiANCj4gICAJcGVyX2NwdV9jYWNoZWluZm8oY3B1KSA9IGtjYWxsb2Mo
Y2FjaGVfbGVhdmVzKGNwdSksDQo+IC0JCQkJCSBzaXplb2Yoc3RydWN0IGNhY2hlaW5mbyksIEdG
UF9LRVJORUwpOw0KPiArCQkJCQkgc2l6ZW9mKHN0cnVjdCBjYWNoZWluZm8pLCBHRlBfQVRPTUlD
KTsNCj4gICAJaWYgKHBlcl9jcHVfY2FjaGVpbmZvKGNwdSkgPT0gTlVMTCkgew0KPiAgIAkJY2Fj
aGVfbGVhdmVzKGNwdSkgPSAwOw0KPiAgIAkJcmV0dXJuIC1FTk9NRU07DQo+IC0tDQo+IDIuMzcu
MQ0KPiANCg==
