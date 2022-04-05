Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2B544F520B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1849315AbiDFCec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 22:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449381AbiDEWYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 18:24:40 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781DD160449;
        Tue,  5 Apr 2022 14:21:44 -0700 (PDT)
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 235HXkLJ013894;
        Tue, 5 Apr 2022 21:21:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=xxNgLNrcnIIIhIawxPMEtUGdZMqg2niRbL8mrHY2nhI=;
 b=nPMt6uelH+litDAnnhqPDGx8AiEu21GegoHWKH1ar/OUMwhRy7b8xSWh1AdToeKvRio1
 ap5S3BYN4dy3mLSu22MhTkoOj0bYtHXiekI8SZkCGfI681ttuwqstMnrppQ8MoM251wG
 GFBjfhZ9bD2poFaD+m2ZBlfgOhEFCBoYg5/vfJfPd/ug8G8+8EPD1sBKVSDQPQlwQELP
 CptH/a/5k7/BsA/MnL3LXZAvjdBBw5rY5wIZ+wmZIl2DnTLyjQELjq5mK21sZMRKFOso
 bZNNCAw7Amu4MPEr0li5BbsvvzEQCWpfvLz8R1RAUUeU8goVNYC2Tdq2pLXu7XEHaLd/ 6Q== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3f8620b58w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Apr 2022 21:21:27 +0000
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id D0FFF805E57;
        Tue,  5 Apr 2022 21:21:26 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 5 Apr 2022 09:21:26 -1200
Received: from p1wg14925.americas.hpqcorp.net (10.119.18.114) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 5 Apr 2022 09:21:25 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Tue, 5 Apr 2022 09:21:25 -1200
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 5 Apr 2022 09:21:24 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oC5J5K1U+x6qkXuYAfophcHoqy2BYTpUblg92v4Nf/aJiHwKYxCoDw1vDJypoU2W61589zuqu6CcGe06k4ibuociH7r7pROodzfRIoaLR8eWNTW6/VCqnoz2yRHYW0ORd5SJNXccYGXcvbo9HMOS2RPvk/y1C2velx3jysrgoWyYXWVw/dpOJtRz69fA0LyHMQxSKYCI6yiLDNIq/z0sqFXefc5R7XUPY5JvQenrgs5VPDmxV/tFJ5R1QBH6kl+aQNZhuss8GylDv/7pX8OiTYvXJIdd93LndKC4U9HLSRMC36f3HVf4oPNhXpLdqHq0tZdnAxXxK8Zlqwwv51+8wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xxNgLNrcnIIIhIawxPMEtUGdZMqg2niRbL8mrHY2nhI=;
 b=nVDGwzxbQKlIIDGcJnc6LeD6VaaO8Ljoji+x3dzZ2xm0V4mRVN7FiC4SRwyTSBr1ntorgoIlHGozRqXqxpyfJoaU+4DYJ11CG/b5ps0uOo969hI+WT52eRU/Bc9dM2MHt/ZIpbMhht/SRSfmVx1j1HgW6nbKOPF//PE/ylUczwNjiibzz+zwBwEgTNOSDqxu9c4OxaGkACXaHtDRii0No7ovUxC5ncCPFbzl7DStN0cmQQhW0kKdb2DPK9UYf9SH6YWCdtfXADmZzhRzrivuqBSdd6CgZJ4fTOgNPAX0ylrTVG6aZoUiEp4jL8VA7+3IBa1dKVROz7Pe2DCirmTzLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:172::21)
 by SJ0PR84MB1845.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:433::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Tue, 5 Apr
 2022 21:21:23 +0000
Received: from PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::bd27:815e:7c03:d1e4]) by PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::bd27:815e:7c03:d1e4%7]) with mapi id 15.20.5102.022; Tue, 5 Apr 2022
 21:21:23 +0000
From:   "Hawkins, Nick" <nick.hawkins@hpe.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     "Verdun, Jean-Marie" <verdun@hpe.com>,
        Olof Johansson <olof@lixom.net>,
        "soc@kernel.org" <soc@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 09/10] arch: arm: boot: dts: Introduce HPE GXP Device
 tree
Thread-Topic: [PATCH v3 09/10] arch: arm: boot: dts: Introduce HPE GXP Device
 tree
Thread-Index: AQHYNLgx692NqDgvU0iOWKp+QCe0Uqy5/HOAgAgo3qCAAAx5AIAAD3gwgAEJmYCAE5R/wIAAGtkAgAAFszCAAZ7G8IAAu8qAgAC9QRCAABI1gIABMDvggAAH/gCABPWK4IAAHiQAgAF6GOA=
Date:   Tue, 5 Apr 2022 21:21:23 +0000
Message-ID: <PH0PR84MB1718C7447207BF210FBB477788E49@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220310195229.109477-1-nick.hawkins@hpe.com>
 <20220310195229.109477-9-nick.hawkins@hpe.com>
 <eb66cc83-2da9-8e19-db69-633e34fef946@canonical.com>
 <PH0PR84MB1718C31DB71AA2A67FEC5F6E88119@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
 <b1cc2566-cd78-7cb4-f8a5-d6fc8065fe6e@canonical.com>
 <PH0PR84MB1718292B1C11F4FE83326A5388119@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
 <fb4def96-4b20-604f-d15d-fef87eb2232d@canonical.com>
 <PH0PR84MB1718A2CFBFC90C9C0CAA5515881E9@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
 <CAK8P3a0fCE_NM=z68d1m9BTfuKixh1pKLw3gn+Sr7SxKb6UJAg@mail.gmail.com>
 <PH0PR84MB17181C316E55073EBC28C386881E9@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
 <PH0PR84MB17185ADBA824F9CC9EB3E022881F9@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
 <CAK8P3a1080yz9jggOrwz2iQ1sAB2Xe2Emh22uCuqRok60BQSiA@mail.gmail.com>
 <PH0PR84MB17186189F5025374AA39584D88E19@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
 <CAK8P3a2b+ESAAkc=_2hqx0kOxwYVS6mNjMGBKhhipaSj_5jV9g@mail.gmail.com>
 <PH0PR84MB17182115D57EF6032782659C88E09@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
 <CAK8P3a1Cc+2oY9djdp11PuOW+TBQ0zf+p8QaDY3aerk1QqaG-g@mail.gmail.com>
 <PH0PR84MB1718925AA3C8FA998C486D7C88E59@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
 <CAK8P3a3RSST6yvv8Oy13RFd6eZ6cS5yX9TOuK6wxXKUO-qdQ=Q@mail.gmail.com>
In-Reply-To: <CAK8P3a3RSST6yvv8Oy13RFd6eZ6cS5yX9TOuK6wxXKUO-qdQ=Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f634e048-fa1f-4d31-ef0f-08da174a3ca0
x-ms-traffictypediagnostic: SJ0PR84MB1845:EE_
x-microsoft-antispam-prvs: <SJ0PR84MB184535D51AA8B23FD1690CEC88E49@SJ0PR84MB1845.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aJEt7+eYUVygfkoVwyb57d+Oayt9leHk12OCdMJY5r4CD44tgcIJLr7w/kguanQuhEUeDaLhyh/RQ2yr3fkrPxE+gEAgzmxzLagPPO8yqh/6DTPfDgM0Qr4QLVxnRGuwk0kexXIHosyoYwhmHYcgvEntG3Oy/8t9t9ByFnjQpRp4YB0pOayNvcXa1JUQeaTtuvt2/y0MNRl6mfV8EKhYk8e71zfY6wnhNqiBt6BwCumzTuC6/q6EPTEKkoilLpqmMjbdyFtW8CZFiZY8qwaAB/KMrgRoecafkQc7Xxv0PWZgOvu84bo3gHgf2/t/7iPaEEEZZRZdEcYqZSgnsEELHyeaHKSkzONKPNG1eIRvwhFASoiS66eBjzfTiOFX7XpvlyV1rmhTUB4ly3N1czphTJ8Vaotxxe7CWdVGN2emBMm/Z2kHCVZ/KvsWYENMHl0anbdj6AdbS4M7VBhSqhztgewiD3W+i8Z8R7DeZqNga7vt53Nl/j5/IVJyq0c+FLPJtmNmjkOHgI6jDrBA6vt2bQkgXcHKnULCtYMxLKSAkbgwBv5WmEGed/w5Oo1frbsBEb2U7SXbE3b3V8s3SmR9UyvYJlIlpanXRmvUSwOf6xC5naKn2K8WhfA0KiUjJxLFxFaOxfGyY/cCMPEFLJCGVI+8MON6mBUtFXfZFNSLxRXzP17JO9jOoD3ARs+7mpZLCBB8dJX0DV4YXhfwa+hFaQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(55236004)(66446008)(66476007)(8936002)(64756008)(2906002)(38070700005)(8676002)(38100700002)(66556008)(66946007)(76116006)(53546011)(55016003)(4326008)(33656002)(122000001)(508600001)(6506007)(5660300002)(7696005)(82960400001)(52536014)(9686003)(26005)(6916009)(54906003)(186003)(83380400001)(71200400001)(86362001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QVFDdU1vcFowWW56Vk9yTFVnUThBd3NMQStSUWp1THNHc1RZSGk4dnVwV0ZG?=
 =?utf-8?B?RFNzN0JvWE1oUTI5Z3JTZlhhVW0vc3hFSnkrc0piMDNmRWlKYXZJTFpINytB?=
 =?utf-8?B?cTlJdHMxcWdOVnd5WVRNL01ZNG5LUjY1UmlqM3FRMWxNVzVKWjgybGhhYjhD?=
 =?utf-8?B?TzdDVFJSTzllRFcwOUMzeFRpMWRUZi93SkRpS05uMDB6MmpjaDRnSW95b0t3?=
 =?utf-8?B?b2tML2xDSDdkczVoZ0Jpc0doUmI5U3lkYVd6WmZOSHlVeWV4Q0pzd0lhMUhQ?=
 =?utf-8?B?WXE0K0VnRXo1d1pNRjNpN01HdWFxOWZISFlYRWlZNW93b0FuZFdUai9rS1Z2?=
 =?utf-8?B?ajJzdTNYeXpXNmp1Z2FJS1FXd1crTCtSYXkvcDdZK1FyeHk0bThsSE5VWitm?=
 =?utf-8?B?UGhFbjh5RFlOemVSY0lYK21aWmhzQWV3SUdrNUxuUW5LeVo4TTNKdkI1NHRQ?=
 =?utf-8?B?KzJROVA0T3VldmcydWI5UlJtenpmdWpQMU92NVdtQWtGWWlDUU5lUU5HSDd4?=
 =?utf-8?B?T1l6aDFUck4yQVJpcTBJaFdydlFNdzl0UlA2Zy9qNXNWbUVpYWlKTDF4b3VM?=
 =?utf-8?B?azYzeHhaeDdEZG1WMVNFNk42WHoxTFlHWGJWaHZObFF3Mk1lYUJjUkpLS1hv?=
 =?utf-8?B?bGUyQjBub2lzMFNqQkJHcmVLT1pTck8rbXlCc2pvVk5udTcrOHJTM2duNkRz?=
 =?utf-8?B?NFRCaFVsZTA0R3U3UkxNSWlUeUF6UFViMHNNSnk2MXJHRm03Q05qTjlYaVlq?=
 =?utf-8?B?WjNyNjl2ZlNzRW5iUjBHeVRGL1NYQ24wRC9tamRDcXpVdHlnKzljZGcvSFdP?=
 =?utf-8?B?MVpjejE1LzhWdmFKSTVhZFlXV0xxbGtFV1VSN3drblVFVmJjK1RsTnA2L2Mz?=
 =?utf-8?B?RWI2U2g0ZG43dlg1dTdmU1BTL3F0UEpZWC9Pc3VCNjVaa1ZEMUROOW9uWUVK?=
 =?utf-8?B?YWFqRnBkM2l4NFlyaXVReG0wN2VrVVJuWFBZZkFKMW1VeHF5WXVFQTNoa1I1?=
 =?utf-8?B?dzRIK2hMUUR6RmZqR3lxdm1DR1FpaG94dXdVbFpDVi81am1NelFNa3p4VkV1?=
 =?utf-8?B?TlA5bG02TXpXdmdBY1VHYUU5N1JCTmNNZVd6ZDVvNkk0MEdITEhwSWJWNXhS?=
 =?utf-8?B?eFRNTEVxR2FzTGgwRHlrMlJIcWJlR2tiQ3diY2NEMmVQVnNWaFRFWFpqR0py?=
 =?utf-8?B?TFNkbjhoczNYSDA4anpDVUxvUUxPUjc4ZGUzclhXaWFGa3I0Yk1sd2tZTG9G?=
 =?utf-8?B?TE91dGFkdTRtTlNVdm9QYk5tYmY5VW1zSENuRkZMQ04xQjluYmYyL2FKdGhG?=
 =?utf-8?B?cFZQS2lwWmxMeGh3V0lDZXk1aXFkZHVvR0IySlI5UTllKzBqeEFLSTYvV3Zl?=
 =?utf-8?B?OVNJY25YSWtFVFMyeXlRMUlUNU9mTmFsZ2pzNU81WForUkp3dWFIVUxRZFhy?=
 =?utf-8?B?NGo3VWE1UzlwWWh3R2hTdStkd0dBNnZKRFluaE91RjJrSTMvTEdGVFlQRXBk?=
 =?utf-8?B?endBa2V0NGZqalJUbDg1ZDdWc3IxQ1JrTzN0MSszcHlwZSt1cEpTaWJWVkU4?=
 =?utf-8?B?aFNVejgvUVlOa3dONEdwRTRSWjBEWHJjRjZHY2dnUDVzQytrUWR2QVN3bE14?=
 =?utf-8?B?VEZaS292MzlFQmdwelhxVXM2aGRHOVR0RzZPUmQ4SWtuSUdLYklhUUJXa055?=
 =?utf-8?B?amMrWW9kekRadUhQNmpnSTBmNmlSckpza1RGYmtwcC9PSkV1bHNLYXdRak1U?=
 =?utf-8?B?b016VXlJTm5PM3gxbW8rUnh4SFhIZm9kalhxSUNJTzJIQXJDRE9qTkp2MCt6?=
 =?utf-8?B?RVlKZ2taa24zYzVIZmcxZHhKdUl1Sjd6WDNDeDI4ZGt1cWxjWmdDaXVhWUdw?=
 =?utf-8?B?dGJwZGhNem44S2V1SThnT1FhQUxCRUk3Yk95NUR6bG5rQTlQU2lwRWRYb256?=
 =?utf-8?B?OVd4dFpJTVJ0aWQvbWZOaGRMUThzU083N3BFaXFjbHF3VTVuMmthOGxQanc1?=
 =?utf-8?B?VWh0dXhEdlpGZ1IzTXJ3ejlzeW1lcllSMjhaWDdOTE13b01qc3QrQVJKcElY?=
 =?utf-8?B?K04vS3NaZWxFQmQrekpmcGU2R1RBTG9yOVoxMUN5andzR3BzN1BFc2lCNUM1?=
 =?utf-8?B?MWFrK1I3RXF5dTUycFhwMURRZmJGWlVFb0ttZWVYblcybDUwSmxxOTRMZnRY?=
 =?utf-8?B?VHZTWll0LzYwdVBUK0RPcVFqZ2Nnd1RWc0RwekpJbWxQWDZKMXRUclpWQzdP?=
 =?utf-8?B?VDU2UXBlVUZkTUFnc1dWbGh4Zk11OWJjZXBva0dxdC9DT3JuMU1pQ1ZlTzQy?=
 =?utf-8?B?MnpoekNTWnRtMGJpQjlhbWVEdU1vcXhVNmVPWGhMVHRYWEpobCsyUT09?=
Content-Type: text/plain; charset="utf-8"
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f634e048-fa1f-4d31-ef0f-08da174a3ca0
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2022 21:21:23.6514
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vUFx0UYqE0uzWsUyZ2wFfkclTD6SxUDlBiw/AurE3l9RtTtjCRBWeuUpla9Juj1i+0kP+pcW60Nez78/+E3zsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR84MB1845
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: _vFmKIhRGt0PGzSI2HQHwAf2nawYXYPZ
X-Proofpoint-ORIG-GUID: _vFmKIhRGt0PGzSI2HQHwAf2nawYXYPZ
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-05_07,2022-04-05_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 clxscore=1015
 impostorscore=0 mlxscore=0 adultscore=0 suspectscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204050118
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBBcm5kIEJlcmdtYW5uIFttYWls
dG86YXJuZEBhcm5kYi5kZV0gDQpTZW50OiBNb25kYXksIEFwcmlsIDQsIDIwMjIgNTowMiBQTQ0K
VG86IEhhd2tpbnMsIE5pY2sgPG5pY2suaGF3a2luc0BocGUuY29tPj4NCkNjOiBBcm5kIEJlcmdt
YW5uIDxhcm5kQGFybmRiLmRlPj47IFZlcmR1biwgSmVhbi1NYXJpZSA8dmVyZHVuQGhwZS5jb20+
PjsgT2xvZiBKb2hhbnNzb24gPG9sb2ZAbGl4b20ubmV0Pj47IHNvY0BrZXJuZWwub3JnOyBSb2Ig
SGVycmluZyA8cm9iaCtkdEBrZXJuZWwub3JnPj47IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5m
cmFkZWFkLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmcNClN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMDkvMTBdIGFyY2g6IGFybTogYm9v
dDogZHRzOiBJbnRyb2R1Y2UgSFBFIEdYUCBEZXZpY2UgdHJlZQ0KDQpPbiBNb24sIEFwciA0LCAy
MDIyIGF0IDEwOjIyIFBNIEhhd2tpbnMsIE5pY2sgPG5pY2suaGF3a2luc0BocGUuY29tPj4gd3Jv
dGU6DQo+Pj4+IEkgd291bGQgcHV0IGl0IGludG8gZHJpdmVycy9jbG9ja3NvdXJjZS8sIEkgZG9u
J3QgdGhpbmsgZHJpdmVycy9tdGQgd291bGQgYmUgYW55IGJldHRlciwgYnV0IHRoZXJlIGlzIGEg
Y2hhbmNlIHRoYXQgdGhlIGNsb2Nrc291cmNlIG1haW50YWluZXJzIGRvbid0IHdhbnQgdG8gaGF2
ZSB0aGUgd2F0Y2hkb2cgY29kZSBpbiB0aGVpciB0cmVlLg0KPj4NCj4+IFdoaWxlIHRyeWluZyB0
byBkaXNjb3ZlciBob3cgdG8gY3JlYXRpbmcgdHdvIGRldmljZXMgaW4gb25lIGRyaXZlciBJIHJh
biBhY3Jvc3MgYW4gaW50ZXJlc3RpbmcgLmR0c2kgYW5kIEkgd2FzIHdvbmRlcmluZyBpZiB0aGlz
IHdvdWxkIGJlIGEgdmFsaWQgYXBwcm9hY2ggZm9yIG15IHNpdHVhdGlvbiBhcyB3ZWxsLiBUaGUg
cGVydGluZW50IGZpbGVzIGFyZToNCj4+IDEpIGRyaXZlcnMvY2xvY2tzb3VyY2UvdGltZXItZGln
aWNvbG9yLmMNCj4+IDIpIGFyY2gvYXJtL2Jvb3QvZHRzL2N4OTI3NTUuZHRzaQ0KPj4gMykgZHJp
dmVycy93YXRjaGRvZy9kaWdpY29sb3Jfd2R0LmMNCj4+DQo+PiBIZXJlIHRoZXkgYXJlIGp1c3Qg
c2hhcmluZyB0aGUgc2FtZSByZWdpc3RlciBhcmVhOg0KPj4NCj4+IHRpbWVyQGYwMDAwZmMwIHsN
Cj4+ICAgICAgICAgY29tcGF0aWJsZSA9ICJjbnh0LGN4OTI3NTUtdGltZXIiOw0KPj4gICAgICAg
ICByZWcgPSA8MHhmMDAwMGZjMCAweDQwPj47DQo+PiAgICAgICAgIGludGVycnVwdHMgPSA8MTk+
PiwgPDMxPj4sIDwzND4+LCA8MzU+PiwgPDUyPj4sIDw1Mz4+LCA8NTQ+PiwgPDU1Pj47DQo+PiAg
ICAgICAgIGNsb2NrcyA9IDwmbWFpbl9jbGs+PjsNCj4+IH07DQo+Pg0KPj4gcnRjQGYwMDAwYzMw
IHsNCj4+ICAgICAgICAgY29tcGF0aWJsZSA9ICJjbnh0LGN4OTI3NTUtcnRjIjsNCj4+ICAgICAg
ICAgcmVnID0gPDB4ZjAwMDBjMzAgMHgxOD4+Ow0KPj4gICAgICAgICBpbnRlcnJ1cHRzID0gPDI1
Pj47DQo+PiB9Ow0KPj4NCj4+IHdhdGNoZG9nQGYwMDAwZmMwIHsNCj4+ICAgICAgICAgY29tcGF0
aWJsZSA9ICJjbnh0LGN4OTI3NTUtd2R0IjsNCj4+ICAgICAgICAgcmVnID0gPDB4ZjAwMDBmYzAg
MHg4Pj47DQo+PiAgICAgICAgIGNsb2NrcyA9IDwmbWFpbl9jbGs+PjsNCj4+ICAgICAgICAgdGlt
ZW91dC1zZWMgPSA8MTU+PjsNCj4+IH07DQoNCj4gUmlnaHQsIGl0IGlzIHBvc3NpYmxlIHRvIG1h
a2UgdGhpcyB3b3JrLCBidXQgaXQncyBub3QgcmVjb21tZW5kZWQsIGFuZCB5b3UgaGF2ZSB0byB3
b3JrIGFyb3VuZCB0aGUgc2FuaXR5IGNoZWNrcyBpbiB0aGUgY29kZSB0aGF0IHRyeSB0byBrZWVw
IHlvdSBmcm9tIGRvaW5nIGl0IHdyb25nLCBhcyB3ZWxsIGFzIGFueSB0b29saW5nIHRoYXQgdHJp
ZXMgdG8gY2hlY2sgZm9yIHRoZXNlIGluIHRoZSBEVC4NCg0KSSBmb3VuZCBhbiBleGFtcGxlIGlu
IHRoZSBrZXJuZWwgd2hlcmUgdGhlIHRpbWVyIGNyZWF0ZXMgYSBjaGlsZCB3YXRjaGRvZyBkZXZp
Y2UgYW5kIHBhc3NlcyBpdCB0aGUgYmFzZSBhZGRyZXNzIHdoZW4gY3JlYXRpbmcgaXQuIEkgdXNl
ZCB0aGlzIHRvIG1vZGVsIHRoZSBneHAtdGltZXIgYW5kIGd4cC13ZHQuIFRoZSBmb2xsb3dpbmcg
ZmlsZXMgd2VyZSB3aGF0IEkgaGF2ZSByZWZlcmVuY2VkOg0KZHJpdmVycy93YXRjaGRvZy9peHA0
eHhfd2R0LmMNCmRyaXZlcnMvY2xvY2tzb3VyY2UvdGltZXItaXhwNHh4LmMNCg0KVGhpcyBzZWVt
cyB2ZXJ5IHNpbWlsYXIgdG8gd2hhdCB5b3Ugc3VnZ2VzdGVkIHByZXZpb3VzbHkgZXhjZXB0IEkg
ZG8gbm90IHNlZSBhIHByaXZhdGUgaW50ZXJmYWNlIGluIHRoZXJlIGJldHdlZW4gdGhlIHBhcmVu
dCBhbmQgdGhlIGNoaWxkIGRldmljZS4gSXMgaXQgbWFuZGF0b3J5IHRvIGhhdmUgdGhlIHByaXZh
dGUgaW50ZXJmYWNlIGJldHdlZW4gdGhlIHR3bz8gSWYgaXQgaXMsIHdoYXQgd291bGQgeW91IHJl
Y29tbWVuZCB0aGF0IGludGVyZmFjZSBiZT8gU28gZmFyIHdpdGhvdXQgdGhlIHByaXZhdGUgaW50
ZXJmYWNlIEkgYW0gbm90IHNlZWluZyBhbnkgaXNzdWVzIGFjY2Vzc2luZyB0aGUgcmVnaXN0ZXJz
Lg0KDQpUaGFua3MsDQoNCi1OaWNrDQoNCg==
