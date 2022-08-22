Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077C659C355
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235651AbiHVPr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236919AbiHVPq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:46:59 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4F22AC7E
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:46:41 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MD9hwP019431
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:46:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=8zXpm14EGuqhyqf0p13qAZn19TCZbKqpMNlRU+Ix6hQ=;
 b=DpdQXAjk/WeGHHuU2aUyqfUtXnQNV8zHGHkcvCSfabaxj8bLD35U2jjgxzkVjaFaKV9e
 inwG9G7HdGw6VGOJeCCWBYv5fGlIeZ1sCYvjV8pTBuLVf/zyI6/2IzTpt5BJa9M5Ebh3
 R8bG1LPy0b99mz/Ksdk8vQgehqx3vS0feM0= 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j4aedh51n-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:46:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PY1h/pRUfl75Wnx0iG86xl9N9bjAAWnc5vs2yoY6rGXtCx8PpM06oR/GEHL6YLo9DY5IUL9sqA9lTTh4WBY6RsHk5BPwtJDeGR1NGwonHTwl1AAFoR0U1XxoUEVNacjjBlwhfZrjdeLcj4bJwIDbG62/aVhEJZO3gKXC1sFTcAPbhv9WouVMAQhD5/I70oPwgreQZ3PcMAZae+1gSVi7BNLXsyk9RRQR/KW0TbEXB07lODPqMxK2emAKtCvI6LaHmyw16Oad3q3mCtHf6KDHjVAZRFcOOTeMruhtKbTlj+HVVfSdQSOnzPGCPmJkspRzkpQzIHL/+lCbkta/n/VoKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8zXpm14EGuqhyqf0p13qAZn19TCZbKqpMNlRU+Ix6hQ=;
 b=bJb/FqIyePtfpbH1E3VB9tmp3T1tVnlOLLMzgcq4PYHoDpyGGo3JqOjfZ7tzTLgkt3LIdv8jK/79PN/JASo951v4YOexIqa8QO4vZXDuUOn3tAxLqMQ50Tql7KKGackab8WEvcHB78aK0LOBdEqyazEUBpJPJ+IN+d8x+cz5XkiDZc78yjdaiHdmne465aYmTgTXvgxLju/pejhA+1qiobDzytbqu+ZHecYaw0g+fw/Av7HQZZBoLbXs1rV3VTblzDC8d5ACiGGYiA0sO1G8ZN6FWBGq9V5MI91DW4Xd7HaXBwPiezs+fOuIPydUjgndp+bpF4R8ioKP9730+TYkBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by DM5PR15MB1259.namprd15.prod.outlook.com (2603:10b6:3:b3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Mon, 22 Aug
 2022 15:46:38 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::c488:891f:57b:d5da]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::c488:891f:57b:d5da%7]) with mapi id 15.20.5546.022; Mon, 22 Aug 2022
 15:46:38 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Linux-MM <linux-mm@kvack.org>, lkml <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        X86 ML <x86@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Kernel Team <Kernel-team@fb.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>, Song Liu <song@kernel.org>
Subject: Re: [RFC 0/5] vmalloc_exec for modules and BPF programs
Thread-Topic: [RFC 0/5] vmalloc_exec for modules and BPF programs
Thread-Index: AQHYs1RC3fzFDgbD7kKge/abI0eC0q27FhIA
Date:   Mon, 22 Aug 2022 15:46:38 +0000
Message-ID: <4D089469-B32B-4347-A811-B1E5EE011307@fb.com>
References: <20220818224218.2399791-1-song@kernel.org>
In-Reply-To: <20220818224218.2399791-1-song@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0dcc4a15-4067-4e03-fb32-08da84558068
x-ms-traffictypediagnostic: DM5PR15MB1259:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bjTUo5EPLag/dEXCjxJM0RZu+IUmiceaFpIjL22fGO/0mjK9q8ibPrNpRwqZR6jdKZnOYbbR6UDh+BrHJWC/1p3MUQged+mnzuaijhqxivgQUCunzRez9N7CSf0CWKlrh2XvgWour9p0gPR4B9RX8Kimv6O9Qd92DStTusTanBOtYlLgjlQ7jiCdUHbayZSC9P7GDFXGdvLhGj30emYV1rBp5H/0CPBVF0N/32Bh253+4aQiqwlaFnOmFqbKnCtaFQPgCbe0nmZBkpUR700+bcybCS5gsXvWeUZqbLZ4dAh4c/OMJoG3nkBYOHBdOWTGylEsg3XeefG93gaIgfz4/6gvYtTO9PIsHgAIYKip1SdkFvsAMuC9thOQ+ldtVpDVJhkFyiiR9Gq5IcI9F4bcrHi4nPt7Cq4SeZZy7Oshin5UuC3Da90aNUngnVlB6dLLIEWzDmULglbTVo+OLjUv66Oxci8WcG3Nl+E5RKWMwLsgJuRdl32JL9iGKBjpwH8aeEoXOk/JezzvDsm1JSngaUaSUQkTACl02KUElXDP8aLpgbJD7r8dgeA1EG5TFyGXkJTPeVJXhfJgsBntUXU740IjvThbhdZLBkjncJoSUNbg+Cbyus5sHpMbdnMWmhDui/Anf9KQLbmZhc9GUqzIqVUWOzy4mn2XmQ+/k/9vtvWzsrXHktYpHYkWf0JbQkolUOW6NTTEfyrkkLtkDyv+jMM3TFaEy2GUkEWFelCNaet/PxlrE1ln+frSHSa58jWdzUYdWw9J4QwAbNclESaguYx7yx/+Yv9lFhQO/8O2Kdpom6iLOdOeUZ+P/OOZTPssuvr3hIicF9ZiOyoeU7eQTtuW8Mx5TW369dAR36LfFngAJw+ZcWdP+wgoggRVS0JV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(39860400002)(346002)(366004)(376002)(83380400001)(38070700005)(122000001)(66476007)(38100700002)(76116006)(71200400001)(66946007)(91956017)(316002)(33656002)(478600001)(66446008)(4326008)(6486002)(8676002)(966005)(64756008)(54906003)(6916009)(86362001)(186003)(6512007)(2616005)(7416002)(8936002)(41300700001)(36756003)(66556008)(2906002)(53546011)(6506007)(5660300002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ODxdT3K7qbn3wTEaSIwDQEzWRiER8x/2U7xQbpK+wM0W+Orf9OjpaRQJw0j8?=
 =?us-ascii?Q?2fEvvZ+urM0kBYbIA48BnOfgjvUWK/GNKVreumAUdZrJgtTz12qb4HWwIFZZ?=
 =?us-ascii?Q?SU3Bt/2s1pzK0kpuHgP323303VTQP2pMuxNcojzs4UB2tazL3zzELOcMNBia?=
 =?us-ascii?Q?N6z+ffqLdTHNE2AOM8oqTf299niLTbHUWB/nCSZLfBQ3OSW1cI0FbDX0M76m?=
 =?us-ascii?Q?Lkfcu5AbH1+Oo8PUlvcIWCdCak9ROs6yyuuwunCYxFgn3nz8/DtNn5QzHMnf?=
 =?us-ascii?Q?YeouvNmDJKN7tKL6XeBzuKBxqjnfaAwvi3kgBpLN52L1GFJf3Xb/krQjlJSN?=
 =?us-ascii?Q?xIH1D/mGnCOiQRXgFRkqBbdd8wmhYRbez2D4/MzZDnKJW9DQ/9ypM84h26Rn?=
 =?us-ascii?Q?H/7HqONs7Lz6/7iePO71BIvhnw6Ny/goMvqylq/4hR3Y+hvWq4sXST3dcrA0?=
 =?us-ascii?Q?uA6Lh+gnJa9G5eNCKSYCNUyhubudyQPUkTyVA/I/sWVegHxNQKh2L3fa209x?=
 =?us-ascii?Q?3xjnGKzl0NyL5EtSyBPPwHQYZi/QPulKRnTczp5FWGZygUT7Dii7UpyOh4NY?=
 =?us-ascii?Q?VS1eU2T4wJMfOxK9KerT8pMiFVH8i7jvT27axXjsdw1UkgKbfs60HGYFyOpF?=
 =?us-ascii?Q?HRRS8wKJ2jf6rn7nxF5b3UfcGEj4cx/Sts7uWskM3l2y2Eur8neE75fNL198?=
 =?us-ascii?Q?0w4gFhWyJ+7TcW1Au7h1HKGuZIhPJ01QPFESGk2Q31FYyaE2GGlZuXH0cgyG?=
 =?us-ascii?Q?tWEOoibDO82f1DfxmVbQqFeI6DZqi3HV19j5Rr3/ubrQ41acBTHFznat0zYR?=
 =?us-ascii?Q?I7wr1QtOipOl7fD1aEBRkPqaWmaHGR2VJwP13/jF9p7g0tliHk38fgdfu8mI?=
 =?us-ascii?Q?1UJP3IrUqNQ7XLoOzJoOnB0HQDJgWjJh8oti23s80rZIIQNs51PyMVhUdEpy?=
 =?us-ascii?Q?OLp0ezAFx5DchFFHNWwq4m5nsdxS+jmkxbuc4sr8X525ZUt5XtC+MsAIKXyH?=
 =?us-ascii?Q?VLXwvioQRSo/BvrpASPsNPl7ZBk0tbQIxWJr47XgxHPc00YMcfpNho+ij9mt?=
 =?us-ascii?Q?i6nc+/2MYXce3p9DwIoM6qAxX9M0H9fu/A/8zTX2YeqvSoeWR79XgGyQfO5E?=
 =?us-ascii?Q?D4jmXrU8xJ1bszHFKmNC60RUhEkLl6CdlhH960TswX16fxCEBLTnm16+gzTi?=
 =?us-ascii?Q?8tuaK84wr4BhNiY8L6VMPlAr7pHgKolhAFnMi0+NKGlhEbZIXcSIqPFbosie?=
 =?us-ascii?Q?5sCPfHSmug7ro7WKCUiAGDs9BQlwf1M8CwRIMz0U8JedUO964mj1gvCPjFdT?=
 =?us-ascii?Q?qCsZ/S9Z38oEX/3n0xAvtxdyhcECuIaoRefCnXKEsAJah+BY0M4AZ6HWyFTG?=
 =?us-ascii?Q?vKFH/NFhjj0/w6s1Shnh7KlLFPeIo/Ygtj40zMOu1nerG1OixPu7AwkT20tB?=
 =?us-ascii?Q?jZp72NJbrgvriTpL/B7ya5rZOies8Q6YZaWHW+WsY4SOrPVUIkBWRLjLMLnm?=
 =?us-ascii?Q?KJzuPyWWLWAX00vibCLC08//Zpkxv0AH1s0kg5JuGY1sM261qJQbS2qwFeQv?=
 =?us-ascii?Q?yMYX2IEdL7XyW9CunHijCAfwpw9S7h1u6WVwWoZ6vrcUXWopAIc5cyjYGOhv?=
 =?us-ascii?Q?1S1oF4Z8XWS0ASIdmlUY/L0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F3564A5263DA564ABCE8202E8CE8D969@namprd15.prod.outlook.com>
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dcc4a15-4067-4e03-fb32-08da84558068
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 15:46:38.7483
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IhQvozpsnASbrvOAcYbnF3x2k0AK3Qtlur+f6Bi/E/n/jGg4G7mtoA5kz4pqlso3yBjKLeGxwruZWhf9+jHGzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1259
X-Proofpoint-GUID: uIdR9u-t11T-S7MZQaELPIwCedXMeWWg
X-Proofpoint-ORIG-GUID: uIdR9u-t11T-S7MZQaELPIwCedXMeWWg
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_10,2022-08-22_02,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 18, 2022, at 3:42 PM, Song Liu <song@kernel.org> wrote:
> 
> This set is a prototype that allows dynamic kernel text (modules, bpf
> programs, various trampolines, etc.) to share huge pages. The idea is
> similar to Peter's suggestion in [1]. Please refer to each patch for
> more detais.
> 
> The ultimate goal is to only host kernel text in 2MB pages (for x86_64).
> 
> Please share your comments on this.
> 
> Thanks!
> 
> [1] https://lore.kernel.org/bpf/Ys6cWUMHO8XwyYgr@hirez.programming.kicks-ass.net/

Hi Peter, 

Could you please share your feedback on this? 

Thanks,
Song

PS: I guess vger dropped my patch again. :( The set is also available at

https://git.kernel.org/pub/scm/linux/kernel/git/song/linux.git 

branch vmalloc_exec. 

> 
> Song Liu (5):
>  vmalloc: introduce vmalloc_exec and vfree_exec
>  bpf: use vmalloc_exec
>  modules, x86: use vmalloc_exec for module core
>  vmalloc_exec: share a huge page with kernel text
>  vmalloc: vfree_exec: free unused vm_struct
> 
> arch/x86/Kconfig              |   1 +
> arch/x86/kernel/alternative.c |  30 ++++-
> arch/x86/kernel/module.c      |   1 +
> arch/x86/mm/init_64.c         |   3 +-
> include/linux/vmalloc.h       |  16 +--
> kernel/bpf/core.c             | 155 ++------------------------
> kernel/module/main.c          |  23 ++--
> kernel/module/strict_rwx.c    |   3 -
> kernel/trace/ftrace.c         |   3 +-
> mm/nommu.c                    |   7 ++
> mm/vmalloc.c                  | 200 +++++++++++++++++++++++++++++-----
> 11 files changed, 239 insertions(+), 203 deletions(-)
> 
> --
> 2.30.2

