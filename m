Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 694C04F1BD3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381782AbiDDVYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380555AbiDDUZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 16:25:34 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5782A4;
        Mon,  4 Apr 2022 13:23:35 -0700 (PDT)
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 234GpxqD012325;
        Mon, 4 Apr 2022 20:23:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=G4jCHjzqkVtUvEGPpNPyHXBfIxUOH7ifIPvB8iPJqMI=;
 b=NsWnnptKR+ZwLqcr6WmKyNyQntuYORsx+bt9vUHGSwtwZsKVe2B/QGjRTjtSYRIXz7iS
 1oDE7BzVGl/dXkwSv7g7vNZNVc1Wga4MtpntVBK9VemWExibVS/DYi+PZu6K5ZQW7zgt
 Rw9fV63L9e3su4zcFR4CYtGmnsSM2sF1cT1kW2HT7LWGzJCkNM2Et9eRw00scJHK3ooS
 /fK0fh3WtduHgeweSbyz+lx8C49jEREDy1pBJF5gs7Vl//k7eL2u+triWMuLlfOAkw1+
 BfhRVNfwyrNCrRLtyS1mEsTYFNls0ZY+Q/SQBw4SANx0QjDDuKposSAZxwnPuBag+wte Qg== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3f7td0yvnn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Apr 2022 20:23:21 +0000
Received: from p1wg14924.americas.hpqcorp.net (unknown [10.119.18.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 9782480038B;
        Mon,  4 Apr 2022 20:23:20 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 4 Apr 2022 08:22:44 -1200
Received: from p1wg14925.americas.hpqcorp.net (10.119.18.114) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 4 Apr 2022 08:22:44 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Mon, 4 Apr 2022 08:22:44 -1200
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 4 Apr 2022 08:22:44 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UFLs+L5MsqRAtUxWtHZA5pQFcGZHMb5yIirIMyormaaqPtdiwLGdVfGOaZ5vlAh71axPYRI/P2CIn14VTTKf0upyg4nzSAqFIcF4QS3ZfscoEbsxYYdyZxsn/KvXVvu5gHUnq+MSAsbilvqWrZfcEmdKjblByzpzqJXGH5++CJ55U678ZYDSkncEGY5emgc6M+gL+s2RH3gS6v1+OJA0gL4CHDqI1rvl6dj5Lnp45G7Xn7P0ON/NfyTnEtaNW2F/B2RuJeNPxqa+KV61gaGTtO9c4FY1qKfErLr7bvEMJAAWbDjai3+yrYvCOG9qSPNBeaPKlB56+ElrKbZcDwUhMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G4jCHjzqkVtUvEGPpNPyHXBfIxUOH7ifIPvB8iPJqMI=;
 b=eAU+whRMXcYS9Vdw4Vm71V32LRzNkzDz6YWRginmLYizM4g3KqFGx+V7Hm9GZTefLFPrXzTqQp4M0Mrkx+FzXjDKQvVcCuJRpXy9BwOpbr3dhPBcx6SFmoMbs9itGvIzcuHgdkdXKBu8fVc5aDyycBbCIvkMVcgaX7aZeTaeBGSE2p1RN6RDLEJgrOlLlXiyjoiEAtvwKMIqirWusFi2dD+MMkX/DT/74Qdt7WqsI/tENudZ1rZp8T5GbkGDttFcqC+C7VUtY0gOPZTwHIvG7m0SLaDWL5HQJ3/rw9Wt+2RT2tUlGiCS0NXbgrHnjs90h8XXWB6Ku6MGpP/T93J3bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:172::21)
 by SJ0PR84MB1920.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:436::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 20:22:43 +0000
Received: from PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::bd27:815e:7c03:d1e4]) by PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::bd27:815e:7c03:d1e4%7]) with mapi id 15.20.5102.022; Mon, 4 Apr 2022
 20:22:43 +0000
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
Thread-Index: AQHYNLgx692NqDgvU0iOWKp+QCe0Uqy5/HOAgAgo3qCAAAx5AIAAD3gwgAEJmYCAE5R/wIAAGtkAgAAFszCAAZ7G8IAAu8qAgAC9QRCAABI1gIABMDvggAAH/gCABPWK4A==
Date:   Mon, 4 Apr 2022 20:22:43 +0000
Message-ID: <PH0PR84MB1718925AA3C8FA998C486D7C88E59@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
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
In-Reply-To: <CAK8P3a1Cc+2oY9djdp11PuOW+TBQ0zf+p8QaDY3aerk1QqaG-g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5c77d864-5dc5-4058-1f76-08da1678dfcd
x-ms-traffictypediagnostic: SJ0PR84MB1920:EE_
x-microsoft-antispam-prvs: <SJ0PR84MB1920B08CEED9976D87745CCD88E59@SJ0PR84MB1920.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7hBX+w08Cmx8tvRZm1Zs5FZUhdqF0p5LQG0GEepdZ5KV82qxslugswlcRejO28H18nG/++mjM80EFBgsWASD33scxzrBD+p1NsOo446yvhbEhKQB+GXqIt/lQoYOc2AaA1aH5E0hHI2VLEbbXxxJ4d6EQk5i7lhGPGwIQEu5+kjFtq2yn4TlPHNLp8KPMkiQ+LrvQc1PQB+w8i7CdZwCWk6RidT7si4tsT2K16W12pKMp5wBl7l325CmtQ5Of5FcdqFiX27CDIS2GHNiIuOivJMBTBCo6DnWOTM7Jyq/be5y8MFWlsq6PuD1zqRGo4izzaKgQKndXViRdsDWImnxvmyF8ENGdjlqTvrw4QObJi8rPIp3MkJJNNPvALt1B4P+U2kIJlMC0fs6ISBqO/Cmg8VD9SFTH569sBRsufGwXVT3RPu739BLhQHuUVcYg5frd5YWouzm1TG9KubRxg5kWABVB+dOASvPHEaK2gURzlP5HsIKg5oLK2LuaW5LVv2PoBGOIN2uFmjx7FjEI90bUqPXV9p6hQF7tKWcidgmMCGYYC65GoGR0gV3P+1l0BQMUToMkO6sOESCFeXb6+A04l9v6SQcz3Taqo0EdXfVFufF+30FRMz4Otta8EU0/aB7FsJq8Lp1btq2Fnmgg/RcYm1HuR9jZz/MpVzfbaV75DUc+qR86M9x+BJEBhtD/7zAbr5fJhPvsjv6ACJ96yH2vQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(508600001)(2906002)(33656002)(53546011)(86362001)(9686003)(6506007)(7696005)(38100700002)(55016003)(82960400001)(122000001)(5660300002)(52536014)(76116006)(186003)(26005)(83380400001)(38070700005)(71200400001)(316002)(66446008)(64756008)(66556008)(6916009)(8676002)(66946007)(66476007)(54906003)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K2xvOHgzSVZnZFIzYm5pLzRPY3FQZTBJU1JmWkYwRDNLL0RxNEg2SmhLQ3NQ?=
 =?utf-8?B?VmdXRzdwZE1taG8xdVhBS25jM1gycU9LN0FzM0IvVTRWRUdwTkwwRUJYd25x?=
 =?utf-8?B?NGRmOW1ZTDdyOXV3TGxqWW9NYVRvS2RidUYzQlVscXlqTFZKWXovM1JmZGJw?=
 =?utf-8?B?c1dpL2tpelJPemNCcXdtVEFHbXVYdXNBZlZObFdqVlJKaGxmUWFMdUwvbCtO?=
 =?utf-8?B?TUxUUDhvTkJmNUFGNHUzanYzc1gzRzFZYkNUdzVXemZ4eGUyOG1LSTJjamN6?=
 =?utf-8?B?UVQxZENJTmlxN0lINWZicUFEK2wzMVVYS3JIdnN0b293VktBR2JlbWN3b0Nj?=
 =?utf-8?B?T0Z1aW1uclplUVNGRmdsRWdJNnljSXBONHVVTktCeUVMcXp3S3lOWHRMM1Bv?=
 =?utf-8?B?eXFIVmxXVkNjY3ZoM3N3U3ZlK2pjWDBMaExBdmg2WHRaRWI5SXM0VFVuQWxD?=
 =?utf-8?B?aUUrMnpkanliQ0p6S0szNi9VdVNxUlEvMVhtTGxZazZacU5jQ1QwZDkycG83?=
 =?utf-8?B?SmxSNlF0OG9weWdkMTB5WENpbHJDLzh1bWt4ZnpQY3VTbm9WenBhV1FNUmFu?=
 =?utf-8?B?YkRxcUgyaUdzY1BTaHlaYmE2bFNDYjlrSGd6V2h5YU0yUVFyQWV3dnlvMU5O?=
 =?utf-8?B?MWVLZmw0NEZwZVNqOEg0U2dQOFQzU1BoYXdqZHQ0T3NvRmpvWmt1dzBsL1ZJ?=
 =?utf-8?B?SDV1ekE0bTlWWUwwRmVaQnNlV2wvcXRmck8xUnE3QnNVQ1dlb1NqcGdrbHl2?=
 =?utf-8?B?Vk9hajR1YVU0T0dBdzdrTTNNcWtEVnVnMWoxeEZORkVwOEJ4SUZ6SzVGTmkv?=
 =?utf-8?B?YTRiS2l5WE5pVm5Jd01zcVRNN3k3b0tycnpDVDV4bHF1Z2JaUGhGcDhFUFYv?=
 =?utf-8?B?YlVLWFN4SXZ6ZEwyVzcrTWovQ2pZYmxaaUQxZHE3SUY4NGVhd201VHV6MjNZ?=
 =?utf-8?B?U29VeTFnRjB4MWYvdmxNbnJEendGTDg5Y1JGK0FjTXdFakJGVVhRWXlHS3Fx?=
 =?utf-8?B?cnFPVWIyWHd5QUkreXBRczlVbDhrSFdLNzFTQTFrdC9kcWwwcGZBcFN0S29M?=
 =?utf-8?B?Y1Y3MG9lK1gwOThRUi8yU01WdWViaEJyKytSMllYUTJwNlltUFZsbVdDdjJ1?=
 =?utf-8?B?M3RUVzM3eE12RXp5aHYwUFhOWENmekdENVdUb0Q4RWhnSkxUWHNDNXhINmY1?=
 =?utf-8?B?ckcrUzRISlo0QmpwQTk0eE1uT05FT2RxRHNhRm5ja1J2NFVXTm1tVHd1YmZ5?=
 =?utf-8?B?bkltMFhtYm1FdXFZM1I5QWxIZXhxNG5sVVRRaDJUYTdLSHRDdFE1MGVxYTg3?=
 =?utf-8?B?L2t1amNVN1BiUXBZUmhBRENqeGMyVWNTeURGUzVCUkFKbjhGeTVuWENycVcr?=
 =?utf-8?B?NWRRTkJOa0N0MGJXV1lKUkc3QjJHQ0paQWpKY0RnSnR2UTBSTWVGcUg1blla?=
 =?utf-8?B?L1BlNXA2dDY4TWJaWUFPT05zdTlGcUNJOWJLVUdjWGFKa2pjc21aWW1vMU5Z?=
 =?utf-8?B?c0JScmtoaXN2eU9nUWprVkdqK2JCMmU4eitEMytkd0czVWoreEhSWWp6WHFk?=
 =?utf-8?B?dXd0R1VVNnkwdEs1R1NUbDJ1TFNTSFU4VTJrSm55aithcjc0YU9GWDQ5UGls?=
 =?utf-8?B?V24xOTV2dm1MUVQ3MTRoVzd5WkY2WGFuRDhrdnQ3Y3hHTDI0ZWpkcGkzR0Yy?=
 =?utf-8?B?SnJJNUdWVUxhK3JTR2c4aWpKdWg3QjBCdVpldzZpOE5SMG1Fd0lHOGNrM0VS?=
 =?utf-8?B?Nnk2d3oxY3oxQWpWUHlUTDdDdEpGeHoxS2ptT2R3dC9tV3k3aUFwUm5hQmhx?=
 =?utf-8?B?TDBpQ3BUSnNlV3BiTlNMOHJjeXJCWHcvZnBoVHB5Y1hnU1JCcUlGYUU2eXFi?=
 =?utf-8?B?Mzg1ZTRyS0RKNjB4THNLM1JxcWRXR3hHelBZZG0xSVFPNVNiZE40Zk8ybUlq?=
 =?utf-8?B?SFZYSkVudnhjVkpZUU1zQU96ZUtNdXg1K1EyN1p2SUd2dnNPbHc0RlR5SWNV?=
 =?utf-8?B?cFdsV1d6RVBMWHF5V0FPVUlqTmZnazhMeEJQRVN3dUhjZDNYZWNaRmZJQ09U?=
 =?utf-8?B?NXYxN3lvei9HRnRiZW5lSEFSQld2T1JWVFRFMzdBMzRudlI2R2k5d0JMKzVY?=
 =?utf-8?B?bERLNVA4ZmFBbE9YT0tqR0dSUm5hQzBFS2FQRGJlUklNTklxVDNiZXR5dVVF?=
 =?utf-8?B?Z254aWhqVlhaUEM0RmpUbm9EdmFyUHhoYTA4c2kvcm95RmFacGlBbGJkTWpw?=
 =?utf-8?B?MGw0RjFMSkpvODAyUHBhSEY3bVF2Q2JtVmQ5WFl4R3h6M0lBajAwcTRmL0ZG?=
 =?utf-8?Q?zeNlfewLyLpT+agXZr?=
Content-Type: text/plain; charset="utf-8"
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c77d864-5dc5-4058-1f76-08da1678dfcd
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 20:22:43.1589
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /+BMze4c2ME7HWQIrSZiyZ4+u2uKg1QXef4rQGOQwwRgcLQj3BYs4bT6uCgQ0/I7WuL+Ap1Jo20V+2CCB23G1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR84MB1920
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: rueF1rQDpHIxA3J0Y1kFNoGq090GjoCi
X-Proofpoint-ORIG-GUID: rueF1rQDpHIxA3J0Y1kFNoGq090GjoCi
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-04_09,2022-03-31_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 mlxscore=0 clxscore=1015 mlxlogscore=999 impostorscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204040116
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
dG86YXJuZEBhcm5kYi5kZV0gDQpTZW50OiBGcmlkYXksIEFwcmlsIDEsIDIwMjIgMTE6MzAgQU0N
ClRvOiBIYXdraW5zLCBOaWNrIDxuaWNrLmhhd2tpbnNAaHBlLmNvbT4NCkNjOiBBcm5kIEJlcmdt
YW5uIDxhcm5kQGFybmRiLmRlPjsgVmVyZHVuLCBKZWFuLU1hcmllIDx2ZXJkdW5AaHBlLmNvbT47
IE9sb2YgSm9oYW5zc29uIDxvbG9mQGxpeG9tLm5ldD47IHNvY0BrZXJuZWwub3JnOyBSb2IgSGVy
cmluZyA8cm9iaCtkdEBrZXJuZWwub3JnPjsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRl
YWQub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZw0KU3ViamVjdDogUmU6IFtQQVRDSCB2MyAwOS8xMF0gYXJjaDogYXJtOiBib290OiBk
dHM6IEludHJvZHVjZSBIUEUgR1hQIERldmljZSB0cmVlDQoNCk9uIEZyaSwgQXByIDEsIDIwMjIg
YXQgNjowNSBQTSBIYXdraW5zLCBOaWNrIDxuaWNrLmhhd2tpbnNAaHBlLmNvbT4gd3JvdGU6DQo+
ID4gPiBJIGRvbid0IHRoaW5rIHlvdSBjYW4gZG8gdGhpcywgaWYgeW91IGFyZSB1c2luZyB0aGUg
c3lzY29uIHJlZ21hcCwgeW91IGdvIHRocm91Z2ggdGhlIHJlZ21hcCBpbmRpcmVjdGlvbiByYXRo
ZXIgdGhhbiBhY2Nlc3NpbmcgdGhlIG1taW8gcmVnaXN0ZXIgYnkgdmlydHVhbCBhZGRyZXNzLCBh
bmQgdGhpcyBtYXkgcmVzdWx0IGluIHNvbWUgZXh0cmEgY29kZSBpbiB5b3VyIGRyaXZlciwgYW5k
IGEgbGl0dGxlIHJ1bnRpbWUgb3ZlcmhlYWQuDQo+ID4NCj4gPiA+IElmIHlvdSBwcmVmZXIgdG8g
YXZvaWQgdGhhdCwgeW91IGNhbiBnbyBiYWNrIHRvIGhhdmluZyB0aGUgdGltZXIgbm9kZSBhcyB0
aGUgcGFyZW50LCBidXQgd2l0aG91dCBiZWluZyBhIHN5c2Nvbi4gSW4gdGhpcyBjYXNlLCB0aGUg
d2F0Y2hkb2cgd291bGQgYmUgaGFuZGxlZCBpbiBvbmUgb2YgdGhlc2Ugd2F5czoNCj4gPg0KPiA+
ID4gYSkgYSBjaGlsZCBkZXZpY2UgZ2V0cyBjcmVhdGVkIGZyb20gdGhlIGNsb2Nrc291cmNlIGRy
aXZlciBhbmQgYm91bmQgDQo+ID4gPiB0byB0aGUNCj4gPiAgICAgd2F0Y2hkb2cgZHJpdmVyLCB3
aGljaCB0aGVuIHVzZXMgYSBwcml2YXRlIGludGVyZmFjZSBiZXR3ZWVuIHRoZSBjbG9ja3NvdXJj
ZQ0KPiA+ICAgICBhbmQgdGhlIHdhdGNoZG9nIHRvIGFjY2VzcyB0aGUgcmVnaXN0ZXJzDQo+ID4N
Cj4gPiA+IGIpIHRoZSBjbG9ja3NvdXJjZSBkcml2ZXIgaXRzZWxmIHJlZ2lzdGVycyBhcyBhIHdh
dGNoZG9nIGRyaXZlciwgDQo+ID4gPiB3aXRob3V0DQo+ID4gICAgIGhhdmluZyBhIHNlcGFyYXRl
IGRyaXZlciBtb2R1bGUNCj4gPg0KPiA+ID4gT25lIHRoaW5nIHRvIGNvbnNpZGVyIGlzIHdoZXRo
ZXIgdGhlIHJlZ2lzdGVyIHJhbmdlIGhlcmUgY29udGFpbnMgYW55IHJlZ2lzdGVycyB0aGF0IG1h
eSBiZSB1c2VkIGluIGFub3RoZXIgZHJpdmVyLCBlLmcuIGEgc2Vjb25kIHRpbWVyLCBhIFBXTSwg
b3IgYSBjbGsgY29udHJvbGxlci4gSWYgbm90LCB5b3UgYXJlIGZhaXJseSBmcmVlIHRvIHBpY2sg
YW55IG9mIHRoZXNlIGFwcHJvYWNoZXMuDQo+ID4NCj4gPiBJIHdpbGwgdHJ5IHRvIHVzZSB0aGUg
YikgYXBwcm9hY2ggZXZlcnl0aGluZyBpbiB0aGF0IHJhbmdlIGlzIHRpbWVyIG9yIHdhdGNoZG9n
IHJlbGF0ZWQuIFRoZXJlIGlzIGEgc2Vjb25kIHRpbWVyIGhvd2V2ZXIgdGhlcmUgYXJlIG5vIHBs
YW5zIG9uIHVzaW5nIHRoYXQuIFNob3VsZCB0aGUgY29tYmluZWQgY29kZSBzdGlsbCBsaXZlIGlu
c2lkZSB0aGUgZHJpdmVyL3RpbWVyIGRpcmVjdG9yeSBvciBzaG91bGQgaXQgYmUgbW92ZWQgdG8g
bWZkPw0KDQo+ID4gSSB3b3VsZCBwdXQgaXQgaW50byBkcml2ZXJzL2Nsb2Nrc291cmNlLywgSSBk
b24ndCB0aGluayBkcml2ZXJzL210ZCB3b3VsZCBiZSBhbnkgYmV0dGVyLCBidXQgdGhlcmUgaXMg
YSBjaGFuY2UgdGhhdCB0aGUgY2xvY2tzb3VyY2UgbWFpbnRhaW5lcnMgZG9uJ3Qgd2FudCB0byBo
YXZlIHRoZSB3YXRjaGRvZyBjb2RlIGluIHRoZWlyIHRyZWUuDQoNCldoaWxlIHRyeWluZyB0byBk
aXNjb3ZlciBob3cgdG8gY3JlYXRpbmcgdHdvIGRldmljZXMgaW4gb25lIGRyaXZlciBJIHJhbiBh
Y3Jvc3MgYW4gaW50ZXJlc3RpbmcgLmR0c2kgYW5kIEkgd2FzIHdvbmRlcmluZyBpZiB0aGlzIHdv
dWxkIGJlIGEgdmFsaWQgYXBwcm9hY2ggZm9yIG15IHNpdHVhdGlvbiBhcyB3ZWxsLiBUaGUgcGVy
dGluZW50IGZpbGVzIGFyZToNCjEpIGRyaXZlcnMvY2xvY2tzb3VyY2UvdGltZXItZGlnaWNvbG9y
LmMNCjIpIGFyY2gvYXJtL2Jvb3QvZHRzL2N4OTI3NTUuZHRzaQ0KMykgZHJpdmVycy93YXRjaGRv
Zy9kaWdpY29sb3Jfd2R0LmMNCg0KSGVyZSB0aGV5IGFyZSBqdXN0IHNoYXJpbmcgdGhlIHNhbWUg
cmVnaXN0ZXIgYXJlYToNCg0KdGltZXJAZjAwMDBmYzAgew0KCWNvbXBhdGlibGUgPSAiY254dCxj
eDkyNzU1LXRpbWVyIjsNCglyZWcgPSA8MHhmMDAwMGZjMCAweDQwPjsNCglpbnRlcnJ1cHRzID0g
PDE5PiwgPDMxPiwgPDM0PiwgPDM1PiwgPDUyPiwgPDUzPiwgPDU0PiwgPDU1PjsNCgljbG9ja3Mg
PSA8Jm1haW5fY2xrPjsNCn07DQoNCnJ0Y0BmMDAwMGMzMCB7DQoJY29tcGF0aWJsZSA9ICJjbnh0
LGN4OTI3NTUtcnRjIjsNCglyZWcgPSA8MHhmMDAwMGMzMCAweDE4PjsNCglpbnRlcnJ1cHRzID0g
PDI1PjsNCn07DQoNCndhdGNoZG9nQGYwMDAwZmMwIHsNCgljb21wYXRpYmxlID0gImNueHQsY3g5
Mjc1NS13ZHQiOw0KCXJlZyA9IDwweGYwMDAwZmMwIDB4OD47DQoJY2xvY2tzID0gPCZtYWluX2Ns
az47DQoJdGltZW91dC1zZWMgPSA8MTU+Ow0KfTsNCg0KVGhhbmtzLA0KDQotTmljayBIYXdraW5z
DQo=
