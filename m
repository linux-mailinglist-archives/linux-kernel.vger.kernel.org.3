Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59DB34D6891
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 19:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242878AbiCKSlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 13:41:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234936AbiCKSly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 13:41:54 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90848A186
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 10:40:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=crriZzd8U9g+It4QhcOikAkUpTZTzLYX8iB72aPKlldBo6NzKmCTCxfRSQIZpbw8R8Pjbf4wT44zR4DjCIn/LgfxZ5gMX53l6DIkWh/+XqqUFcLgxVvq+RedbwH/IDoPBOx4l8GH+jKIeI9qv9PFio8xsKXsLetGIiBr0VAa1TV7/gDufMtpERuwxcWXS+1iXjAUOv408li2HIK8dYrj8bpGn+fUxlDG5n7TG8GW42oBrnVEfKgP5kf6iU99Z7VqkIQ+AznQxxD4B32XCE4Dw/C0rxkJPnU6ciRpvDPoCZrmnPKKCwLfpHWTNvejT0kFOZjDqaVu4ot4nE7DNtVnfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V+Yg4gEthFzvVhzItoRl/1s8SsQ+cQ18NtfEAyT9xYc=;
 b=RZtzCbZrjVuFk0KxAEM+k7stS/iQJh7+F6Ju7Pl0qld2epiU3fxXmYmzJJBmMuLJwFxzjaOgJ3oIeyNdG3urJDQC0XTZkadaXAH1AVy+kPVoOrLdNUtZBAUAWfCs4/hX77jNai2EqllqsYE7v/xfSDTA2NNdHPiqqe4gUz0sqvwWAKeYQWidRNAoewf3am4moi/LDNLLQ5f/VjbChQMsBvPn/eHp+AvxC7lbDcWwAgJBhHH72Tbv3fzNXYPi92L9dz5G5yJBjR87T4bALiesPNKxCUx9/KLGw2nK4ed4bDSRrbwj1Wg31hKsbeZjN6Ztqo7ADwgC5O5WOQ2T6Y61FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V+Yg4gEthFzvVhzItoRl/1s8SsQ+cQ18NtfEAyT9xYc=;
 b=pycv2Zx96sR/05uZECuvLzop9wdK0QO0I5FCMeJXt1PEAkBZvAYV3/srbTsX/WD5AmMMcNtYXnuWw0sWPtRbO5pYJRB79iT2pR6EFUJySOgBoCnyBKQhDeHXUzMUI6mv56/SrOaFae1SIp85lzOktY6HHbmYNE2kiP/v/czmA5U=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by BLAPR05MB7265.namprd05.prod.outlook.com (2603:10b6:208:286::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.7; Fri, 11 Mar
 2022 18:40:48 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::6061:706:1081:df8b]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::6061:706:1081:df8b%5]) with mapi id 15.20.5081.007; Fri, 11 Mar 2022
 18:40:48 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v3 0/5] mm/mprotect: avoid unnecessary TLB flushes
Thread-Topic: [PATCH v3 0/5] mm/mprotect: avoid unnecessary TLB flushes
Thread-Index: AQHYM2uKrnc5RsxkI0qTSHUzdQzkKqy3ldQAgALyYIA=
Date:   Fri, 11 Mar 2022 18:40:48 +0000
Message-ID: <FA3620A4-8633-4AAC-B35F-F0040477613F@vmware.com>
References: <20220309041043.302261-1-namit@vmware.com>
 <20220309134046.31a0751523acb9babb55b9de@linux-foundation.org>
In-Reply-To: <20220309134046.31a0751523acb9babb55b9de@linux-foundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3693.60.0.1.1)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 43d6c1a9-cf6f-4dd1-e5df-08da038ea943
x-ms-traffictypediagnostic: BLAPR05MB7265:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <BLAPR05MB7265CEC589B7765CFA2CE70DD00C9@BLAPR05MB7265.namprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l46fA3HPdfacA16lpamp233XnNGXh+ZDf5eiBjzo1fY3SoWjdpx3DmvcrGPmKuKKA/MM6KWHydEG8RuIb6ULDUhMsl14KfNZz6OK1BW9n8oGTVG6pZZJjXObEhkCT1xudH7KgNKJRnGL7azbBlF6V203injJItfUILARwj+rLATa6znJHNeNPZLUZbi2tg4wyoIYOTImz0qum9v5e7YRoNQV7CUtaFyP24P8Etxz8KbZ8QJEwyPYAWI3bQ8d+t+6nmOCcyLxYbfk81ysenlrvKdo4eij+U6SmIlIJThC7A/NGtCczHc/hHgNiGfzen6D2QnznUXoKQgVoHGkG+xzcHZpvBinGjqEIWis8aHRuy65KK6eBuzGt3CAuFtYiZZYTDmvCdhPHOBrFu+8jsrVEFVZjccaPY/NR6gNYGqMql8EbFIR+evJrJ296pkX3L6V+XorpCvOJr9EQMwvBXbRZcEKeGNSHS67VbFCg9NE+GRz+OnSExzTE9TxXvF8XmK1q9z4dXupmbz4P9ORXhFQcSMzwYTKULoDOX8jnMDg4qcTEFoFKp4fIjuu2WqH1E0w0HHGTyveThsg1OROcC8nTvwFPRjeBlKXHsxTpc5ELYd77TtmQmEhUyzW4+b8j5TXsN2JbYznBAiTgDPf61MOgDDlYpyOIVR3Qo9ZRAhWPkdBKwKvufEt9UhwFmXl6R6torZ9izEMk+FRbNwDOTZxKCuDTyGhVvr/obRf7quXuPfFinSlbFujbFJqYAQrp0NB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38070700005)(6486002)(6916009)(71200400001)(316002)(33656002)(508600001)(8676002)(66946007)(66476007)(64756008)(66556008)(66446008)(122000001)(76116006)(4326008)(54906003)(7416002)(6506007)(4744005)(5660300002)(2616005)(186003)(26005)(53546011)(38100700002)(83380400001)(6512007)(36756003)(86362001)(2906002)(8936002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nxTi5FDR909JwoUguhSJ+i1xxLx2GzsPmo6HTVZ7vUGIwkxfGszzMc+eGpK6?=
 =?us-ascii?Q?f+O/cd1XTfNHFrMmDECdPL7T4hCY4kRmWmgFjeMkdH2So0EbGonFt9OK8J97?=
 =?us-ascii?Q?heSWizpUrSiDYziTPx1OxROrqmQrnekX0XqLDKEhBAfuMBMkpBXEHOjRfmOA?=
 =?us-ascii?Q?QdlQQNXrydE2tzjzCphnASZRs3T9hAqqoPPsB4KT76SmVPe9buC5m9SRAzKn?=
 =?us-ascii?Q?MOEmksdEA+zW28ezwevVuEutbVyR1bXYOWVJZmZqUXva1RnWeyaOG4nFU62Z?=
 =?us-ascii?Q?WJnGgnnQPjTJmQW+MlPMamFodHhkmm7Fm4PgqOrNZKTp+P0N6U6BUV9yCZ6X?=
 =?us-ascii?Q?r005xWWTo6Z5jKdwen20xFmEyE7++QIHd87G49+kC8KU0tdQzOUK0S9YZYhE?=
 =?us-ascii?Q?WkqFvPgnz9Hyr5xwMRY7MxlLF5Q2fKtzA+o0cAHxF6DoDFCtrFwTbR06wHCU?=
 =?us-ascii?Q?dGoz18AA9m30FrBzHY6N3Dtn0sD95xuH4PASafGirv399EwgM275ATFHuEGU?=
 =?us-ascii?Q?JacyNVdrO7GcmEv84mcr23IA3VZWF+SWr6WnXtg0GT/ehFa4Tes7cKznEHDz?=
 =?us-ascii?Q?IHPIqIZMZ3EgAz/uNuvepl0r80s4w7atybcoaEiaOdveOjsnmf8TBlKpXLtC?=
 =?us-ascii?Q?6cprpHptjlE/1N2CAZOSFc7dtTNuwMMR/wmIksaY+ILlLW3tXKBlhiScLga8?=
 =?us-ascii?Q?SRgu/V44zObPUHOmKxUuWoVoY/+QX8nfBNcyPj3FZfDOF1xPod5BikYeJaEv?=
 =?us-ascii?Q?Qyby9RxCfguwAGh/tKeAfu80UFu/OlD9vIRdWgiq6wP9F/rzs7UxUshNSnLm?=
 =?us-ascii?Q?y2IvuPRucn8Gm4mw9KQKE1L/ksD6yS4V4AiYyXOghmZfJP1u19782xJvS+N+?=
 =?us-ascii?Q?zZBS8LykIzd5eveSQ0ppO5hHYSdsN8E3LPeUsGvG6NqEyrYj11MCUa0g1ZhB?=
 =?us-ascii?Q?pz51QJiA127EUxveZJiZP4NSoqHLVWM5kLyp/+MtC5mBuqsmPOWdlFk8nzg5?=
 =?us-ascii?Q?6VeXFTfv8gOpBqErFeFUNpQr0b/x461CVBU3dnObQ8GNyabda1DKfGWtlfiY?=
 =?us-ascii?Q?InCC9Hff+vBh2dsoDja7nZVftZY1zE5a1sMEyGrcyczDu5dy0cgWg+gRAcZB?=
 =?us-ascii?Q?fyfAGpHaF7ShMx+CSlYQ5JvBuzIehOQiSu51UggIdiBG9fmz+583m/hPuXyJ?=
 =?us-ascii?Q?x9tD9Ad24DLtDqfc5XX8hq7DpzzkiegrKNQ5h0440Uvxggntyqll78DjVGhB?=
 =?us-ascii?Q?EJUdsbABbEQCpo5RengMNf+0OnejOeSjclRVHAD6VFDIgoW91Iw9wknX0eMK?=
 =?us-ascii?Q?kDDJpqlDRCg5JmZoa6PDGeho0S4BExNXHrJvPOa0eAw+hqqX+UBLv5tscpTL?=
 =?us-ascii?Q?0SxGI48h3r/06Nwm/iJvrl/ZMFPKZnyxjtQkzc0pBDR3adLK35JJFe6WUqBg?=
 =?us-ascii?Q?YqsPwK7567H3V9TaKqCD5ibfcIc4uLoB?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FB4BFF33ECFCEA4782F86B1275446A95@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43d6c1a9-cf6f-4dd1-e5df-08da038ea943
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2022 18:40:48.5291
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IRHLLKHRoXcDkiDkJbjEWz4phWi0isKHwmERETr/jmDgrXQlNS9p8bhHDvzgjLIjxK0i19nSPZCT+RhLHBunmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR05MB7265
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 9, 2022, at 1:40 PM, Andrew Morton <akpm@linux-foundation.org> wro=
te:
>=20
> On Tue,  8 Mar 2022 20:10:38 -0800 Nadav Amit <nadav.amit@gmail.com> wrot=
e:
>=20
>> This patch-set is intended to remove unnecessary TLB flushes during
>> mprotect() syscalls. Once this patch-set make it through, similar
>> and further optimizations for MADV_COLD and userfaultfd would be
>> possible.
>=20
> Thanks.  I'll save this away for consideration after the -rc1 release.=20
> Which gives others plenty of time for review (hint) (request).
>=20

I see that some patches did not make it through to the mailing list.

I will resend later today.=
