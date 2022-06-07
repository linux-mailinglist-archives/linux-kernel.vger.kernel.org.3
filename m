Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBCCA5423FC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444895AbiFHBIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 21:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447979AbiFGXHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 19:07:50 -0400
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01on2066.outbound.protection.outlook.com [40.107.108.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EAB3379429;
        Tue,  7 Jun 2022 13:39:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hfpLtLZFc3k8BsR51Xq7KNLMdwpF9ET6SHJpHJLCtivF0OeRF89O3+6e723axgWP9N5OPr6sf7335viqUfG7vCuQqekaVyAV1awnSuJJ5v0lvWHXnP47blurZsfVN5teU5VOpdyk8JfWTwHhPqDx2SDVprvuTIU0c8bGO2FL8Um5iNzniuMpYOpoo4b2k1bwPGRjxi6dn7a3urxZTS6RGz4v57rq/NhYcGEjSsR+xtJ+u8bcQ0/+fkqe1mGIGPNPT3TMSAGZ/8x2BHn6fPwfKZN0+BA2xACN+esA7Oee3UYu7EjNgcNnOPHFJqIlICgUjUXqMEgnRCLykM4CNn3cfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DMfkZ6BGgq0hyCVCA4wy7XESSKBKYvPz4h4PDr85Uos=;
 b=KFv1JfXR62Fj57lXTxpngQH+pAJzRhyQH7Zckw0XejSYRaManfy3x1lZJpnocIYHJQpQt7XSo4icqFMJEmb57+hzbpqvm0bip22dThkQB5IbElSnOObYeywvQU6lwic4pgMpyW1pfffnm/MKjFubOwhhzQtcOmFZuiHKYHP4yEBtpi141o4WlOT+ctvMyKLw8+1UwGqIVNW6gRTxXCquV9AX5pBFgnJGk0INkyUUE8dNqewBaN8H4lonSefAtO6ZCkd1Slz/l5cn6sRsHDC9/aoKd0QaQmagY83Tlceo+ZVFH9yn0ODTqL0NUXoFG+OASc16+kEoGzfUg/WArkNN3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sydney.edu.au; dmarc=pass action=none
 header.from=sydney.edu.au; dkim=pass header.d=sydney.edu.au; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sydney.edu.au;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DMfkZ6BGgq0hyCVCA4wy7XESSKBKYvPz4h4PDr85Uos=;
 b=KSn69tpF/b9pDEkUYEOpAJ041FpWhLMLTafIyr7zGxoo2sj7sAiCsnEvEYxyBg+j8zwztS3HJFrEJAUkaAI7tc0d/Li5TWXYZEEaXgaE2oAyo65g5Q0x6i5BwwiCJSgCWQEMkDdA4xq61T5syrd8SKoSN/1wDAMdOVBX0rsMpZmSkNM+KqGTMCdwsujR5Lk6tfv2f3XZOHIMH4YX6vF8B+gaTtlglHrCpFtciEQ6f1IuEPShyF+KdUd6K4hCxj9RX85R1eYZydWDS+dZOJZhY1MFfE02WOo2v2MaKjlnrqOPlBW3TTElfuBSkSmNW6Y2IkXU0CLC3z+gsMIAPeoghg==
Received: from SYBPR01MB6620.ausprd01.prod.outlook.com (2603:10c6:10:12b::7)
 by SYCPR01MB5213.ausprd01.prod.outlook.com (2603:10c6:10:85::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Tue, 7 Jun
 2022 20:39:50 +0000
Received: from SYBPR01MB6620.ausprd01.prod.outlook.com
 ([fe80::e088:6b38:e939:42bd]) by SYBPR01MB6620.ausprd01.prod.outlook.com
 ([fe80::e088:6b38:e939:42bd%5]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 20:39:50 +0000
From:   Tyson Thomas <tyson.thomas@sydney.edu.au>
To:     "Liang, Kan" <kan.liang@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: Re: [BUG REPORT] perf tools: x86_64: weight column displays odd
 memory latency data
Thread-Topic: [BUG REPORT] perf tools: x86_64: weight column displays odd
 memory latency data
Thread-Index: AQHYbikBqoNARN6xu0+kyVhcP9zLfa0uIQaAgAvnzSCAA8BEgIAGtC0D
Date:   Tue, 7 Jun 2022 20:39:50 +0000
Message-ID: <SYBPR01MB6620C59A47802DCAA6C68CF1DBA59@SYBPR01MB6620.ausprd01.prod.outlook.com>
References: <SYBPR01MB6620E2316BDF9CE29178CB32DBD59@SYBPR01MB6620.ausprd01.prod.outlook.com>
 <fd28e6fb-cf4c-a065-6138-4c581e871341@linux.intel.com>
 <MEYPR01MB66152548BEC4D0113BBBD7A5DBDF9@MEYPR01MB6615.ausprd01.prod.outlook.com>
 <02135ffb-c19c-6c8c-4900-a16a1c40a746@linux.intel.com>
In-Reply-To: <02135ffb-c19c-6c8c-4900-a16a1c40a746@linux.intel.com>
Accept-Language: en-AU, en-US
Content-Language: en-AU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 649324d8-61f7-e614-9996-d8125e255894
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sydney.edu.au;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 108ffa5e-e7d1-4cd4-88a2-08da48c5de69
x-ms-traffictypediagnostic: SYCPR01MB5213:EE_
x-microsoft-antispam-prvs: <SYCPR01MB5213BBE722B6548CFBE9333EDBA59@SYCPR01MB5213.ausprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w7CJXFw58ucMQ/o3vDVYd0VFnpSIN02168tQvieDLNx0DnYQTE10JbpWXa5gFSBo3ORUE56K0c1cNuPlJqPSANi0Ho3MMnrs3A7FJmEHYZLAmxxbKwtafWjWE1fzg3Q+t7mQ9yvDB6Wv/OyATgk5VuGa6lmfQ0nHVnow0nqxbzjDcWT8t9mDp9jSwwXkq1QJHiPV9TAYVBHi8Ik+wXjHKnG0Oz1GHVEFA3oroFsnQVVGO17IfK99fiHZ2L4p7drv4TjMKerlQDkoKddvPVtMh7nwqJM9C/SqG3isEvIpBUnMi/9xyemYnaa1fPf3Nz1DrtmY1V02rfvYzfQnPeQCB/Jz6vPGKkOz0itqdieCUm+/SLoqyzYL/dWWu5RTJRYzpGZ0XgqDvbCbV8M1uPnEr/nGPFliqpb2LrC85JaxJL0xJfoQrMEOnHs0zHDLkK3yZGf8TYlAAFk7B9v9zm1ADXW4vZTWsVrOOiYqYDjoobDdQodgbCzn0z37PP2iiz6mrBV63OyfkxEuxtAogyYLFcJQ7NEbyhBvU+x0zc9y/sOUXeMgwQHEokmRiXrSWi1fNnHMXHIN8OUKAiEaG06mRNTJAEhdtAz2iQsSpFf3kLjXbFXbBhdIphMW/3cz89i4JwyGgLt0+4qiCXfMX/OyDzIELQNtmuaDZ3CFYLCrXjwBAnoCNwHv5fUXS1PTEjbS3NGDYlCtxly7XMfUnRKdtA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SYBPR01MB6620.ausprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66446008)(316002)(6506007)(508600001)(38100700002)(5660300002)(122000001)(71200400001)(55016003)(9686003)(186003)(38070700005)(26005)(86362001)(52536014)(110136005)(8936002)(8676002)(44832011)(83380400001)(2906002)(76116006)(66556008)(66946007)(7696005)(786003)(53546011)(33656002)(66476007)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?e+sx00m+2ZuUa1cwZFFzItJJxK95mDLn7qfrbJPtAiAlkKX1z90GFGGrXI?=
 =?iso-8859-1?Q?H/y0YFiyPlFfomLp7exlmx7SUocy6GMZIOdHNu0HiDLXyvigbaUnWbo5qC?=
 =?iso-8859-1?Q?4sdRFvB5j4tYFKjV1BiV5d2hoDiMH61wucsaS0xv0fLpjpvmxhJbz+UlnE?=
 =?iso-8859-1?Q?RAwTPI9TxSrVvHxYS20IYjUarPejWSgt+cd4lOGQQfz53FJWDkHo6iA0tX?=
 =?iso-8859-1?Q?LZzkk+rXULPTvm3P52EAfXVGVDWlhzT0WN8PWReNIXj4l7kDd+AW9cZb2L?=
 =?iso-8859-1?Q?fQG1Aa0qUIEGnBTdl4J7M/G6u++peRGM0SUUY4124EAkpn7zg2la9UgMyd?=
 =?iso-8859-1?Q?qkYsUeVhLQN2JynwUZoaWXTCSndj/V2+/GF6YRe3KsQ40FBg03MiqFdA9J?=
 =?iso-8859-1?Q?jlke+ijhvIqWARln8q24S8RQ22aIbouyORI3dNFA62O9kfaCmnLbqUEAWa?=
 =?iso-8859-1?Q?Nc4oEqmKk74lXPyStUAUaoNFAnGLfFTEcAo1aMXAsFc7Ct/6gk/KaQMRhz?=
 =?iso-8859-1?Q?El/jl+40ZF9o8k4Oqm6Uq7zJrQ0KyL8ubOiEOnpExbrWV5uLchkF6PKqA4?=
 =?iso-8859-1?Q?k9215pe2T4aVWS8nkFhlAYi9u9Uhu9Xxf/rqGtjoLe+cTONbPMvvQuHg4L?=
 =?iso-8859-1?Q?e5LdujyR0FE7HEO2hIqW/uphJ7ud5PvApHNAGYezvGS7rw0mswsHHkjH9I?=
 =?iso-8859-1?Q?VkAqZOYqKqrnpMV3Q0cz5Nmk0ZlPcoR+/9QXY1/okI8IM/gw+b8S4yo2t/?=
 =?iso-8859-1?Q?9wc8OSnJMuoLRQEuowl0wQepURjYgAJDr8N0qi0/q/3c6zBVzUs93Rswi4?=
 =?iso-8859-1?Q?aCZ2P12WBScmlDu+wU/HvszpBKKTsoYsbhrk5OKZgur5T0sqpRwzS1cclD?=
 =?iso-8859-1?Q?jFmh/d/LFDod3zKky7Z8xinY79OwwlpQ8M7RKVF8odN+AEkY4/E0yCKTU4?=
 =?iso-8859-1?Q?eMpsaTOgWBHB6XL7SxrE6SL5CmMBde97xIkNi63lC0qE4a5bxcXSMei4iD?=
 =?iso-8859-1?Q?qObrAejLIVPTonYm9K0B4DFiz4zzHloCbo1AgfKGpEJCNtciE2yH1pQ78q?=
 =?iso-8859-1?Q?tMY52a0TAKOMQFW2pBRo8BPk5J6RmZW7j9nLM5y5B3eXF2Ak+matHd8r3a?=
 =?iso-8859-1?Q?8PDNIwzhf0bFuzVrcDyY8HgokubJF70ZMk4aJRzcqW4roPD6l7fuZLk68l?=
 =?iso-8859-1?Q?2KYXrEzJPsTwTkQ9Cc4uUB27L6Pajs/1YAphe/Pg/NI9s30+4vY291lWhp?=
 =?iso-8859-1?Q?d+EJeTLK99ru4lVju6c3fIIv7q+pOmvQqrHvkx0a9JkyyYGIgMAEYc0SHa?=
 =?iso-8859-1?Q?lxshwyUPTGYBPQsUiI07DuAUemwNs/fg5VXTsZ3h0nAU9yvAMjIQPvmu2x?=
 =?iso-8859-1?Q?Gpld28ZpKWHkO1DdeLvwGqLr4hK/ZIcV/z2aMqwuHrIsPc1lUxeVAzKFPO?=
 =?iso-8859-1?Q?k1AzIDXkd+Gi0/rTMGiWuNfQpsu1pqEdyn+02O/douOGWKYHx1gutVD4ox?=
 =?iso-8859-1?Q?78KqXCSzJKjQ+ZufCjXe4bKz8XmYF9cjFmCfKVqS40SnAj8ZJEEeY7vT+B?=
 =?iso-8859-1?Q?hKIVGjLOCruwFkFCJ3MoskMDveybig0Sn8lltB3Vl16y1/t4t16dvj2tae?=
 =?iso-8859-1?Q?MWlg72pbVkDLNjU70UN9gRUGzvCHYx3KR3l12H3nXyDQopNp4HWLAcuvxa?=
 =?iso-8859-1?Q?rOZ3sBFiwbkI1HXx/BB4gffqSxvlwq29J2R/LkueOJk0rEQHOsIWH6yyZF?=
 =?iso-8859-1?Q?HqI/az3CbibtAC2eRmGEaeDnYN6cPMmj7lnePupikKliWI1/iZZbT+xVpX?=
 =?iso-8859-1?Q?MPPmWM7bfQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sydney.edu.au
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB6620.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 108ffa5e-e7d1-4cd4-88a2-08da48c5de69
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2022 20:39:50.3093
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 82b3e37e-8171-485d-b10b-38dae7ed14a8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pKqxyId9vrZjmBXjkDYpXUi50XDaxh0FLiJZKAUo1ktA749+iifwuejxoVii1MjuLv9JfRjQQLt6wNuMbGub7JKcQV6Sy+V2wdtG0S/nNOU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYCPR01MB5213
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kan,=0A=
=0A=
Thanks for the reply and sharing your output.=0A=
=0A=
However, I have a couple of questions since the output is not what I have e=
xpected and appears odd.=0A=
=0A=
* Are you using the OpenMP version? I ask because I don't observe any openM=
P symbols in your output=0A=
* Does your computer have enough ram for cg.D? (Your output does not includ=
e the iteration results and the perf file is smaller than expected)=0A=
I observe a similar issue with cg.C.x (cg.C memory requirements are around =
8GB)=0A=
=0A=
=0A=
Regards,=0A=
Tyson=0A=
=0A=
From: Liang, Kan <kan.liang@linux.intel.com>=0A=
Sent: Saturday, 4 June 2022 12:03 AM=0A=
To: Tyson Thomas <tyson.thomas@sydney.edu.au>; linux-kernel@vger.kernel.org=
 <linux-kernel@vger.kernel.org>; linux-perf-users@vger.kernel.org <linux-pe=
rf-users@vger.kernel.org>=0A=
Subject: Re: [BUG REPORT] perf tools: x86_64: weight column displays odd me=
mory latency data =0A=
=A0=0A=
=0A=
=0A=
On 6/1/2022 1:03 AM, Tyson Thomas wrote:=0A=
> Hi Kan,=0A=
> =0A=
> Thanks for the reply.=0A=
> =0A=
> The exact command used was: perf mem report=0A=
> =0A=
> The columns are in order: Overhead, Samples, Local Weight, Memory Access.=
=0A=
> The results I sent before are: Overhead, Local Weight and Memory.=0A=
> =0A=
> So, to update the table from before, each tuple has a sample of 1, so it =
is:=0A=
> =0A=
>=A0=A0=A0=A0 0.02%,1 ,62515 ,L1 or L1 hit=0A=
>=A0=A0=A0=A0 0.02%,1 ,54048 ,L1 or L1 hit=0A=
>=A0=A0=A0=A0 0.02%,1 ,52206 ,L1 or L1 hit=0A=
>=A0=A0=A0=A0 0.02%,1 ,49831 ,L1 or L1 hit=0A=
>=A0=A0=A0=A0 0.02%,1 ,49056 ,Local RAM or RAM hit=0A=
>=A0=A0=A0=A0 0.01%,1 ,40666 ,LFB or LFB hit=0A=
>=A0=A0=A0=A0 0.01%,1 ,38080 ,L1 or L1 hit=0A=
>=A0=A0=A0=A0 0.01%,1 ,36772 ,L1 or L1 hit=0A=
> =0A=
> So, the weights are absurdly high here.=0A=
> =0A=
> I'll give a reply on perf report -D shortly.=0A=
> =0A=
> Regards,=0A=
> Tyson=0A=
> =0A=
> =0A=
> =0A=
> From: Liang, Kan <kan.liang@linux.intel.com>=0A=
> Sent: Wednesday, 25 May 2022 12:58 AM=0A=
> To: Tyson Thomas <tyson.thomas@sydney.edu.au>; linux-kernel@vger.kernel.o=
rg <linux-kernel@vger.kernel.org>; linux-perf-users@vger.kernel.org <linux-=
perf-users@vger.kernel.org>=0A=
> Subject: Re: [BUG REPORT] perf tools: x86_64: weight column displays odd =
memory latency data=0A=
>=A0=A0 =0A=
> =0A=
> =0A=
> On 5/22/2022 6:14 PM, Tyson Thomas wrote:=0A=
>> Hi Kan, Linux-Perf Team=0A=
>>=0A=
>> I have observed some odd behaviour within perf when using perf-mem. Spec=
ifically the reported latency under the weight column appears to be unreaso=
nably high.=0A=
>>=0A=
>> Here is a given sample from a recent test, I find that some of the=A0 la=
tencies are close to an unsigned short and I cannot seem to be understand w=
hy that would be outside of it being an issue with the perf events.=0A=
>>=0A=
>> This can be replicated using a NAS benchmark, specifically cg.D.=0A=
=0A=
=0A=
I tried the cg.D benchmark on my machine, but I cannot reproduce the =0A=
issue. The weight looks reasonable.=0A=
=0A=
$ perf mem record ./bin/cg.D.x=0A=
=0A=
=0A=
=A0 NAS Parallel Benchmarks (NPB3.4-OMP) - CG Benchmark=0A=
=0A=
=A0 Size:=A0=A0=A0=A0 1500000=0A=
=A0 Iterations:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 10=
0=0A=
=A0 Number of available threads:=A0=A0=A0=A0 4=0A=
=0A=
^C[ perf record: Woken up 118 times to write data ]=0A=
[ perf record: Captured and wrote 30.108 MB perf.data (438307 samples) ]=0A=
=0A=
$ perf mem report --stdio=0A=
# To display the perf.data header info, please use =0A=
--header/--header-only options.=0A=
#=0A=
#=0A=
# Total Lost Samples: 0=0A=
#=0A=
# Samples: 209K of event 'cpu/mem-loads,ldlat=3D30/Pu'=0A=
# Total weight : 56835744=0A=
# Sort order=A0=A0 : =0A=
local_weight,mem,sym,dso,symbol_daddr,dso_daddr,snoop,tlb,locked,blocked,lo=
cal_ins_lat,p_stage_cyc=0A=
#=0A=
# Overhead=A0=A0=A0=A0=A0=A0 Samples=A0 Local Weight=A0 Memory access=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Symbol =0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 Shared Object=A0=A0=A0=A0=A0=A0=A0=A0 Data Symbol >=0A=
# ........=A0 ............=A0 ............=A0 ........................ =0A=
................................=A0 ....................=A0 ............>=
=0A=
#=0A=
=A0=A0=A0=A0=A0 0.01%=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 66=A0 53=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 L1 or L1 hit=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 [=
.] =0A=
randlc_=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 c=
g.D.x=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 [.] 0x00007f>=0A=
=A0=A0=A0=A0=A0 0.01%=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 53=A0 58=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 L1 or L1 hit=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 [=
.] =0A=
randlc_=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 c=
g.D.x=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 [.] 0x00007f>=0A=
=A0=A0=A0=A0=A0 0.01%=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 59=A0 52=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 L1 or L1 hit=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 [=
.] =0A=
randlc_=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 c=
g.D.x=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 [.] 0x00007f>=0A=
=A0=A0=A0=A0=A0 0.00%=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 53=A0 53=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 L1 or L1 hit=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 [=
.] =0A=
randlc_=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 c=
g.D.x=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 [.] 0x00007f>=0A=
=A0=A0=A0=A0=A0 0.00%=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 43=A0 65=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 L1 or L1 hit=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 [=
.] =0A=
randlc_=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 c=
g.D.x=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 [.] 0x00007f>=0A=
=A0=A0=A0=A0=A0 0.00%=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 50=A0 55=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 L1 or L1 hit=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 [=
.] =0A=
randlc_=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 c=
g.D.x=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 [.] 0x00007f>=0A=
=A0=A0=A0=A0=A0 0.00%=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 51=A0 50=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 L1 or L1 hit=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 [=
.] =0A=
randlc_=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 c=
g.D.x=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 [.] 0x00007f>=0A=
=A0=A0=A0=A0=A0 0.00%=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 46=A0 55=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 L1 or L1 hit=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 [=
.] =0A=
randlc_=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 c=
g.D.x=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 [.] 0x00007f>=0A=
=A0=A0=A0=A0=A0 0.00%=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 49=A0 51=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 L1 or L1 hit=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 [=
.] =0A=
randlc_=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 c=
g.D.x=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 [.] 0x00007f>=0A=
=A0=A0=A0=A0=A0 0.00%=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1=A0 2496=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 LFB or LFB hit=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 [.] =
=0A=
sparse_=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 c=
g.D.x=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 [.] 0x00007f>=0A=
=A0=A0=A0=A0=A0 0.00%=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 48=A0 52=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 L1 or L1 hit=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 [=
.] =0A=
randlc_=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 c=
g.D.x=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 [.] 0x00007f>=0A=
=A0=A0=A0=A0=A0 0.00%=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1=A0 2441=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 Local RAM or RAM hit=A0=A0=A0=A0=A0 [.] =0A=
sparse_=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 c=
g.D.x=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 [.] 0x00007f>=0A=
=A0=A0=A0=A0=A0 0.00%=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1=A0 2420=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 LFB or LFB hit=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 [.] =
=0A=
sparse_=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 c=
g.D.x=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 [.] 0x00007f>=0A=
=A0=A0=A0=A0=A0 0.00%=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1=A0 2415=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 LFB or LFB hit=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 [.] =
=0A=
sparse_=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 c=
g.D.x=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 [.] 0x00007f>=0A=
=A0=A0=A0=A0=A0 0.00%=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1=A0 2403=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 LFB or LFB hit=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 [.] =
=0A=
sparse_=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 c=
g.D.x=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 [.] 0x00007f>=0A=
=A0=A0=A0=A0=A0 0.00%=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1=A0 2399=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 LFB or LFB hit=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 [.] =
=0A=
sparse_=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 c=
g.D.x=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 [.] 0x00007f>=0A=
=A0=A0=A0=A0=A0 0.00%=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1=A0 2390=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 LFB or LFB hit=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 [.] =
=0A=
sparse_=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 c=
g.D.x=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 [.] 0x00007f>=0A=
=A0=A0=A0=A0=A0 0.00%=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1=A0 2385=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 LFB or LFB hit=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 [.] =
=0A=
sparse_=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 c=
g.D.x=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 [.] 0x00007f>=0A=
=A0=A0=A0=A0=A0 0.00%=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1=A0 2385=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 LFB or LFB hit=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 [.] =
=0A=
sparse_=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 c=
g.D.x=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 [.] 0x00007f>=0A=
=A0=A0=A0=A0=A0 0.00%=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1=A0 2378=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 LFB or LFB hit=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 [.] =
=0A=
sparse_=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 c=
g.D.x=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 [.] 0x00007f>=0A=
=A0=A0=A0=A0=A0 0.00%=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1=A0 2358=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 LFB or LFB hit=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 [.] =
=0A=
sparse_=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 c=
g.D.x=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 [.] 0x00007f>=0A=
=0A=
Thanks,=0A=
Kan=0A=
=0A=
>>=0A=
>> I observe the following results in perf mem report (just getting the top=
 10 results)=0A=
>>=0A=
> =0A=
> =0A=
> Could you please show me the exact perf command used?=0A=
> =0A=
> With my perf mem report,=0A=
> The first column is the Overhead.=0A=
> The second column is the number of samples.=0A=
> The third column is the weight.=0A=
> The fourth is the Memory access.=0A=
> =0A=
> Seems like the weight is missed?=0A=
> =0A=
> Could you please check the perf report -D?=0A=
> It will dump the weight for each Sample.=0A=
> Does it look correct?=0A=
> =0A=
> Thanks,=0A=
> Kan=0A=
> =0A=
>>=A0 =A0 =A00.02% ,62515 ,L1 or L1 hit=0A=
>>=A0 =A0 =A00.02% ,54048 ,L1 or L1 hit=0A=
>>=A0 =A0 =A00.02% ,52206 ,L1 or L1 hit=0A=
>>=A0 =A0 =A00.02% ,49831 ,L1 or L1 hit=0A=
>>=A0 =A0 =A00.02% ,49056 ,Local RAM or RAM hit=0A=
>>=A0 =A0 =A00.01% ,40666 ,LFB or LFB hit=0A=
>>=A0 =A0 =A00.01% ,38080 ,L1 or L1 hit=0A=
>>=A0 =A0 =A00.01% ,36772 ,L1 or L1 hit=0A=
>>=A0 =A0 =A00.01% ,36729 ,LFB or LFB hit=0A=
>>=A0 =A0 =A00.01% ,27101 ,LFB or LFB hit=0A=
>>=0A=
>> Is it possible for someone to shed some light on this or am I misunderst=
anding how the weight column is used here?=0A=
>> This appears to have been an issue on 5.4, 5.10 and 5.15. I am looking i=
nto seeing if it is still present in 5.17 and 5.18.=0A=
>>=0A=
>> I've also tried this on different Intel CPUs such as Intel Xeon 6230, i5=
-1135G7, Intel Xeon 6330=0A=
>>=0A=
>> Any insight or help would be appreciated,=0A=
>> Tyson=0A=
