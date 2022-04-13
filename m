Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA664FFBBE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 18:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236952AbiDMQv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 12:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiDMQvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 12:51:55 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185F035A9A;
        Wed, 13 Apr 2022 09:49:32 -0700 (PDT)
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 23DGWW74023194;
        Wed, 13 Apr 2022 16:49:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=R9BTd+OXyzmusJbg4tLYDKlzWU07UGZHePBoPC7GwcY=;
 b=ZO1TexVB+Tl3F/GyTOCeHuRrlAdXxNQfdS9Jz1WZDp4ELQUf8egHOY8ObDNO1rKrQd9k
 BBrZ1kzprB5wXse1UU4V7ANLlQyzUI3L1DOjdRpiNgi86xZSFlU+2yCcbEO819fe9FoY
 c79l89GFo2YDiE+qguuT41PnLKaM04l4uzGmnml9KlyMWN4WuADrRkgljM1f5iHicPLp
 4K2Qgz49SPvHShJGZrKQsT+5+8EOe0n4sJqhCrfBvAxqMHRlXbnAeVc1rwjLgCtVFQll
 NAxD8cxdY26PysBxmpkt7ChPg1Y/i3oLuzbjjaPXYS/zKTklqFGkyy3PUUjPCQB+u/ud KQ== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3fdy72juu3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Apr 2022 16:49:22 +0000
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id C5046800349;
        Wed, 13 Apr 2022 16:49:15 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 13 Apr 2022 04:48:58 -1200
Received: from p1wg14925.americas.hpqcorp.net (10.119.18.114) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 13 Apr 2022 04:48:58 -1200
Received: from p1wg14921.americas.hpqcorp.net (16.230.19.124) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Wed, 13 Apr 2022 04:48:58 -1200
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 13 Apr 2022 04:48:28 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bmXntpgt4tlJ8YUM8sENzeCDuwUDUFQYgmDde4Rl6s7xKUSBJKLMYLkKN0++sCViY2X6cP9nFq+L/rzrI1f9RLSCMht9HhCem0njtA3ZXIuDuUNcTDFcb1ur2qxK06W9L1xMgm9FBOtdX6U4NV6ZQdJs4/rCVWrkYsufYKvzeGW/PT7sjzKke0jYMEgA+rqSIJe4HaQn5M/Sm58/hO/Plo644VLndlUFaxsBHk56K5Q9HqV2eAAhETkgcUgJYcODL+eZTMkZFF4i4+DjGvHTscUo2uV8gYB+JfL0WDSrAK3sdayDTGMFwcbSvSS+Snb9+AKGuzjm1bdfMmebZnYCPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R9BTd+OXyzmusJbg4tLYDKlzWU07UGZHePBoPC7GwcY=;
 b=cqPKWedsh0Lu+5NWLLOOTv0a9eEyZfMw0KbGi26XxbQPh2weVaVzdXka3lPcQd/IG2DMjTk9/2SYV8w9gJR6qsfJV87r73oAO8e9OZ88SxFIM93fFOSYn7cMVdEIUxk0kLYmApIacGSaeAvJZ8ErZs2A1RZk5iskYB22CskF2A7MD0dhVbQxMbszvFRK18fL2klHJZxwWkS4u3VM4iVk9qVCm8SzO8oesXDRyr23OiUeDwilWrAeHXHoE1aNh8NgjozfV6/7fFfakzMYGpc3MC8VFM9NFLVinOtSjw35ZVg4VshzYf/tq+belYzvx8n4X+KIarmnGxUHoNrW3GTLnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:172::21)
 by PH7PR84MB1837.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:153::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.27; Wed, 13 Apr
 2022 16:48:27 +0000
Received: from PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6055:1602:5a0a:1562]) by PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6055:1602:5a0a:1562%6]) with mapi id 15.20.5144.029; Wed, 13 Apr 2022
 16:48:27 +0000
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
Thread-Index: AQHYNLgx692NqDgvU0iOWKp+QCe0Uqy5/HOAgAgo3qCAAAx5AIAAD3gwgAEJmYCAE5R/wIAAGtkAgAAFszCAAZ7G8IAAu8qAgAC9QRCAABI1gIABMDvggAAH/gCABPWK4IAAHiQAgAF6GOCAALVmAIALm5Fg
Date:   Wed, 13 Apr 2022 16:48:27 +0000
Message-ID: <PH0PR84MB171896DE1EFA3B25A74ADED488EC9@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
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
 <PH0PR84MB1718C7447207BF210FBB477788E49@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
 <CAK8P3a3jr-FkyxLff2cK4=X-4AShnKkeYMRKsvUg=2W0bTviiQ@mail.gmail.com>
In-Reply-To: <CAK8P3a3jr-FkyxLff2cK4=X-4AShnKkeYMRKsvUg=2W0bTviiQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 18031fc1-869a-4626-c246-08da1d6d6eff
x-ms-traffictypediagnostic: PH7PR84MB1837:EE_
x-microsoft-antispam-prvs: <PH7PR84MB1837CB8F8382414659C38BA288EC9@PH7PR84MB1837.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +seboMIcYjXoeEkTq8XTljAYnlVBiGj7vKSoqjy+J2Xj83prEWf/FOuV1bAcNSxMlOo6zXtZ2K6NVxCoDPpCW0hjX8c6OVv1jDzMNrkck2LwSDTIU3LoNFdQ/lwrndHTlTXqKSXZtJ3/yAEFadqc/0Z8lNrcASA1qm5PASMxakUb1YOeIJYSz1CoR0EsE79QpasAbHB1Jj3wJI3eHbobfzt3Yp/SmhcdY4XPpCIX5VDj0lNs+3bGTwWi67fbe+AhZ/ALPSZ2V0AWZhkvQBOsdsIyz+iZ0DFW3wcQW07kG3G97QpxJ4GfM9F2OumY08ITdQaLrLYrS41aytLh5iJfImtSX5TYSIT01S1ptG6K4GMOIogjIqrYXvRgOvyOH1c3AfuGXqYa/8wBGXe23XsZviYxiasVHHhVaADfgtXdZEgzUoRvJQHyiN1Wc3aU83+VQS17VQEwWge99I+OD1oCEXb3B+kLoD3fBrR4EF1KLt+ON6h1ZqbBQLHrvwLPEEuPy448CYwLc0uylpI+8yxaxeo+5LY6KNZeYOiP4S8B6/PdV9kVlVJhnE6NqVF5v4MllDqnHEHUlgSl0wWsqSqYfmfaUec8Skt0ZpKdbl2TxnZqMYGNxHnzOibr/dXfWq+H2NZGsh6wFTfkEiOLCmiSs8SfdSQWnGrUqpaN8T7KrbbLY/oqPFH7MvspWDOROvFQay4bAwFxCvfy7s5hRAwNpQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(5660300002)(82960400001)(55236004)(6506007)(38070700005)(38100700002)(122000001)(71200400001)(52536014)(8936002)(9686003)(55016003)(33656002)(8676002)(86362001)(2906002)(66476007)(66446008)(4326008)(64756008)(53546011)(66556008)(186003)(26005)(83380400001)(316002)(54906003)(6916009)(66946007)(76116006)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Tm0vdTJJU0s5V0J1Zk5WenhSdFVhbnhMOVJIQ2s5dzBHbWlUTlpWZzRNM3F2?=
 =?utf-8?B?M3lIY3dYZ2ZCNWt4Y29VRHZHY3dzWlpmRkxIbGFQT3FkbXN2SzQ3bUFzUjNS?=
 =?utf-8?B?TklWQ3VibTAwa1gzaVBPdDdFNDJUMDErN09hckdsdm9NbUtuRGl5cFpPZTJo?=
 =?utf-8?B?RGd2Z0ZnS1lnN3JkRU40eFA1UWxhNEpNVDZxa09oeGZBS2xCNHA0TWdmT3RG?=
 =?utf-8?B?K1lTZ0hUaXFYQk5rREdjZmpuVkRYd0FWMVBXdmpCRmcxSWtTczFvdjJKTXVt?=
 =?utf-8?B?dzJyZWNBaXZCRWtGL01zbVl2WW1mYjFGdTVoMkFScERuQm92bkxzTWFxUzZK?=
 =?utf-8?B?OUp1Q21NaU9KczhPSUtBNnhOK29CT2Evd3BYWjVwZUtBa0dIcGx1N29nMkhk?=
 =?utf-8?B?djR6VkM2YmVQSWR4KzQwcXZRZmRIQUZqNlVvTWo0Z0ZFSlM5TlExQ1QrWFhl?=
 =?utf-8?B?TStEUUNDR0p3dE1KU2ZrMUN2ZmcvbVpLMXM3VlhKcDBpOUp0aGl1RVM0M2p2?=
 =?utf-8?B?NktIdng0RkpicFIxaC9wZ1A2TGxHdjlqblJVYWUwZGxvTGdWNGlaVWd4R0Ni?=
 =?utf-8?B?Yk9xQjBMOG9VdzBUVTZnUmlNeCtjWU9KUXEwbk5Rb3FISTRDcGtkc3ZjVzBj?=
 =?utf-8?B?dEV1bnZzbGE1RFRVRXNuNGdZVEwrcjNZdTkycE54TDZWSzRwWi9qK1I2UG5U?=
 =?utf-8?B?WE0zN0hsYXU1ZTcraWNualY0cnZueGZrY21qK3Z1Y2l5SmNqaFl6c0R5aXdi?=
 =?utf-8?B?VDJMa2tMdTRzaWIxTDVZNFNTUTVlY09Qa29IQ25McTZjTldRLzhXV3JBQWJ1?=
 =?utf-8?B?VnZCUldnVTFEbmkwRVJ3anRZMzhOWDlzMWF2Yis0REp1M2VJbGZ4eTlwTnBh?=
 =?utf-8?B?VFRhbWVFcTdpZGVGWXlJa0xkK0pOZzhqaElvRkRKNzV4U05HNzhVSEx5TVVI?=
 =?utf-8?B?aElDNGF3djJiY05kK21EZzUyS0o4em13RGZUMkQ2VEpLSDJ2OWNTazRISWJY?=
 =?utf-8?B?SElnY05WOGV1UGpMNVdHOFlPalJGOXdFalFpb0hyc1EvNW5PNCtVT2ZVQ1BB?=
 =?utf-8?B?TmZPVUc2Qnp2ckoyTDhLdjZvTVdKTGZpOFdtNjFSMzdhaFhBUGpHNTQ2c3J1?=
 =?utf-8?B?a1ZUbzJzbU1qR1hzL29rRUFmWC9obmZIRkJySitHQXc4dGJBekgxQ3NwVFFV?=
 =?utf-8?B?QjNndmFxWllScEFNbWRTVElvZTBXZlh1RHUvNDE2UWlFWjVyRno3RXF0QXhO?=
 =?utf-8?B?RFVLRWIyZlJ6OXRUK3JTNFF5dWlMdUFyamFOVmdUcHlSdTI3OEdCU291S0VE?=
 =?utf-8?B?K2w5Y05STTNZZ1cxQ1NzL0dmbFF5SUh4MWsxdktVNUFBYmp3djFKUDZrbjNQ?=
 =?utf-8?B?YW5aV1haTEFxTmRTRnBRKzZ2VEIwNWI0cENiY0lrTXo1elU4Um1FMlJ4ckR0?=
 =?utf-8?B?dktkN1JzSUZxQlpnMWJKWStzV1UrOWgvdlZXd0V4L2JHcE84aUVjdFlRSXRC?=
 =?utf-8?B?QU04dXo5K2RFdTZLa3hWTEdLSUl5aEZrQkIzaDh4a1FFZ05nMGdaZThKUyty?=
 =?utf-8?B?OWhLMGR0ZHdpakFyMDBuK0JtUi83QUYxK3UxQm1DV3dWcXZBbHYxZUFhUklj?=
 =?utf-8?B?WVJtcHRpMEttS0VmcnpJZ0dvMkw3UVVSVzkzZ1htQ0NpU0hPL255aUNDM2RX?=
 =?utf-8?B?M0JrTjVnbGUxTEJUV0lLdUEzYjdKMk9WeHZROTgxcXlMVVMrUVFRWHFvMmJG?=
 =?utf-8?B?LzExeUVCeVZIZlg0Slo4anlHd3VNVHFaaGZEeVFpNUNBL3k0RmorZ2lKQ2hD?=
 =?utf-8?B?U1R1VTNTaVJ1cmVsdDdtYmdwY0FzRFlyeW0rMTkyQUtYNkRrblZ5VlFpM0VD?=
 =?utf-8?B?SWtFS280WGdxVFYrZDc5QXAreVNKK1RzYVhkZTJxbXdPNUpEbTNPcWIzM0Iz?=
 =?utf-8?B?WXRnOFlqNHhYOVY1UjNVVUJ0Z0NsdkFiMytVbWxQTEd4NFFBZCtETXMwWWdx?=
 =?utf-8?B?ekx2NXBVZHowY3VCRlZVaDVEeFlYMVc4d1VqMDZISUxxelh3NVI1Nk9ObThr?=
 =?utf-8?B?Q1Z3V01Md0NGVGJnS1NFZy9oMUY1TDNPLzEyd21FYXI3cFlTeGhJVW1oVTlX?=
 =?utf-8?B?MnE3QWpGSTVBUUlDTURJWGhMT2RCbEpMU3ZYTXpBN0FWUjZsaVUzbW92aUVB?=
 =?utf-8?B?cThUVTJzS0FjRUN3K3F4TG1UcVpScjN2bCt1bDV0b2FQcVhMQTlmTi9Pdy9t?=
 =?utf-8?B?OS92N2FxWmtLYjEyb3JRWE8wcDM3MWdYVDY2MXJLcDA4TjVWVjAxbHlBVVdy?=
 =?utf-8?B?SzNqU0VuUTF1NkFXeHdlaTdIVjFFdC9SMW5OUllmVnRQWlo2ZlN4UT09?=
Content-Type: text/plain; charset="utf-8"
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 18031fc1-869a-4626-c246-08da1d6d6eff
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2022 16:48:27.5680
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9dq+2yB6isK5NR24EDd6THDx+/ea1rGbkcpluWYzIBvuIhrAXKDR88BKA7QYcSDp1rFsHABP/NTearzDnsmy/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR84MB1837
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: z-4bdIIKvnoL6ZotbWlsy_qXSwGlHrdi
X-Proofpoint-ORIG-GUID: z-4bdIIKvnoL6ZotbWlsy_qXSwGlHrdi
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-13_03,2022-04-13_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 adultscore=0 priorityscore=1501 mlxlogscore=854
 clxscore=1015 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2202240000 definitions=main-2204130086
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
dG86YXJuZEBhcm5kYi5kZV0gDQpTZW50OiBXZWRuZXNkYXksIEFwcmlsIDYsIDIwMjIgMjoyNSBB
TQ0KVG86IEhhd2tpbnMsIE5pY2sgPG5pY2suaGF3a2luc0BocGUuY29tPg0KQ2M6IEFybmQgQmVy
Z21hbm4gPGFybmRAYXJuZGIuZGU+OyBWZXJkdW4sIEplYW4tTWFyaWUgPHZlcmR1bkBocGUuY29t
PjsgT2xvZiBKb2hhbnNzb24gPG9sb2ZAbGl4b20ubmV0Pjsgc29jQGtlcm5lbC5vcmc7IFJvYiBI
ZXJyaW5nIDxyb2JoK2R0QGtlcm5lbC5vcmc+OyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJh
ZGVhZC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnDQpTdWJqZWN0OiBSZTogW1BBVENIIHYzIDA5LzEwXSBhcmNoOiBhcm06IGJvb3Q6
IGR0czogSW50cm9kdWNlIEhQRSBHWFAgRGV2aWNlIHRyZWUNCg0KPiBJIHdvdWxkIGNvdW50IHBh
c3NpbmcgYSByZWdpc3RlciBhZGRyZXNzIHRvIHRoZSBjaGlsZCBkZXZpY2UgYXMgYSBwcml2YXRl
IGludGVyZmFjZS4NCj4gSXQncyBhIG1pbmltYWxpc3RpYyBvbmUsIGJ1dCB0aGF0IGlzIG5vdCBh
IGJhZCB0aGluZyBoZXJlLg0KDQpUaGFuayB5b3UuIE5vdyB0aGF0IHRoZSBwYXJlbnQvY2hpbGQg
aXNzdWUgd2l0aCB0aW1lci93YXRjaGRvZyBpcyByZXNvbHZlZCBJIGFtIG5vdyBoYXZpbmcgYW4g
aXNzdWUgdHJ5aW5nIHRvIGFjY2VzcyAiaW9wY2xrIiBmcm9tICJneHAtdGltZXIiLiBJIGhhdmUg
dHJpZWQgdXNlIG9mIG9mX2Nsa19nZXRfYnlfbmFtZSBhbmQgb2ZfY2xrX2dldCB3aGljaCBib3Ro
IGZhaWwgdG8gZmluZCB0aGUgY2xvY2suDQpJcyBpdCBiZWNhdXNlIGNsb2NrcyBpcyBvdXRzaWRl
IG9mIHRoZSBheGkgLT4gYWhiIGhpZXJhcmNoeT8NCg0KICAgICAgICBjbG9ja3Mgew0KICAgICAg
ICAgICAgICAgIHBsbDogcGxsIHsNCiAgICAgICAgICAgICAgICAgICAgICAgIGNvbXBhdGlibGUg
PSAiZml4ZWQtY2xvY2siOw0KICAgICAgICAgICAgICAgICAgICAgICAgI2Nsb2NrLWNlbGxzID0g
PDA+Ow0KICAgICAgICAgICAgICAgICAgICAgICAgY2xvY2stZnJlcXVlbmN5ID0gPDE2MDAwMDAw
MDA+Ow0KICAgICAgICAgICAgICAgIH07DQoNCiAgICAgICAgICAgICAgICBpb3BjbGs6IGlvcGNs
ayB7DQogICAgICAgICAgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gImZpeGVkLWZhY3Rvci1j
bG9jayI7DQogICAgICAgICAgICAgICAgICAgICAgICAjY2xvY2stY2VsbHMgPSA8MD47DQogICAg
ICAgICAgICAgICAgICAgICAgICBjbG9jay1kaXYgPSA8ND47DQogICAgICAgICAgICAgICAgICAg
ICAgICBjbG9jay1tdWx0ID0gPDQ+Ow0KICAgICAgICAgICAgICAgICAgICAgICAgY2xvY2tzID0g
PCZwbGw+Ow0KICAgICAgICAgICAgICAgIH07DQogICAgICAgIH07DQoNCiAgICAgICAgYXhpIHsN
CiAgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gInNpbXBsZS1idXMiOw0KICAgICAgICAgICAg
ICAgICNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KICAgICAgICAgICAgICAgICNzaXplLWNlbGxzID0g
PDE+Ow0KICAgICAgICAgICAgICAgIHJhbmdlczsNCiAgICAgICAgICAgICAgICBkbWEtcmFuZ2Vz
Ow0KDQogICAgICAgICAgICAgICAgYWhiQGMwMDAwMDAwIHsNCiAgICAgICAgICAgICAgICAgICAg
ICAgIGNvbXBhdGlibGUgPSAic2ltcGxlLWJ1cyI7DQogICAgICAgICAgICAgICAgICAgICAgICAj
YWRkcmVzcy1jZWxscyA9IDwxPjsNCiAgICAgICAgICAgICAgICAgICAgICAgICNzaXplLWNlbGxz
ID0gPDE+Ow0KICAgICAgICAgICAgICAgICAgICAgICAgcmFuZ2VzID0gPDB4MCAweGMwMDAwMDAw
IDB4MzAwMDAwMDA+Ow0KDQogICAgICAgICAgICAgICAgICAgICAgICAuLi4NCg0KICAgICAgICAg
ICAgICAgICAgICAgICAgc3Q6IHRpbWVyQDgwIHsNCiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgY29tcGF0aWJsZSA9ICJocGUsZ3hwLXRpbWVyIiwic2ltcGxlLW1mZCI7DQogICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHJlZyA9IDwweDgwIDB4MTY+Ow0KICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBpbnRlcnJ1cHRzID0gPDA+Ow0KICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBpbnRlcnJ1cHQtcGFyZW50ID0gPCZ2aWMwPjsNCiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgY2xvY2tzID0gPCZpb3BjbGs+Ow0KICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBjbG9jay1uYW1lcyA9ICJpb3BjbGsiOw0KDQogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHdhdGNoZG9nIHsNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBjb21wYXRpYmxlID0gImhwZSxneHAtd2R0IjsNCiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgfTsNCiAgICAgICAgICAgICAgICAgICAgICAgIH07DQogICAgICAgICAg
ICAgICAgfTsNCiAgICAgICAgfTsNCg0KVGhhbmtzLA0KDQotTmljayBIYXdraW5zDQo=
