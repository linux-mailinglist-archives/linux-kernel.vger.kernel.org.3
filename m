Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32858539C69
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 07:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345407AbiFAFDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 01:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235212AbiFAFDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 01:03:08 -0400
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01on2053.outbound.protection.outlook.com [40.107.107.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA5458E49;
        Tue, 31 May 2022 22:03:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JvdudqkoVV2qET3pRTQqJZpzSq9957IAvf6knDPpdbPaO3BqvRHxxu98tStEZFTRNVrUxxXbU3dM9nFblHgEQ40MnqLSNkfxSrFIFAikVeQA2A+Y7d40Xbbtv07vwNt4MNa0cZGVXAlygsFdmOeWsjECS1ZhJc8uSj5Cj/CQ+GUZBqfy60jlGfIx3Bb6Mg1r+Vs5GGnNCk63SGZtsoQ+bMc0aUpLrSp9vR4+WB9uqu0edJaq1I8ox6ODYfoRJ1ePiuRZQejHL/2JuMU4Bq09B0Kr3hrkFfxp3TBx7Et2KTe2IhmqAZlcY8hLXzsHC35C22Xsq8ClObBc9UI+z2lCUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=++LPNEXSI6ZtRsj/201/pL+YYuXmwn5wT/IOBF4IjCY=;
 b=PeSiYXJLaGkHfvyFa25kyAHVbW2uIQAEnCE5Ex5HKdCr70qcmQr1CmE8VC7X13czNKcIP9Fk9k0rokXwsLz2tJh0nqnWya7UY4CDqKGq0p0VvUR2EyT35MHLcKC5NOMBsuauRxm1m/15PC7HUp6Hy8s7/Ba/FyBfjaH+hHplNhqUHmcwyf+PQACqZlJAE0QEug21/GgPICrOWroNrkWSInfsVbbD+vuVm5WnqGb1EMCN+mYzVi9riXlSvQOnnv2IZ6NKbNvpAKAzYXHpp2nlR0pAzOxgKkKjecUIngTNrwloIKW65dGaSq1t8WXWsf7PGV9f6qigo6zTzReFnvbJgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sydney.edu.au; dmarc=pass action=none
 header.from=sydney.edu.au; dkim=pass header.d=sydney.edu.au; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sydney.edu.au;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++LPNEXSI6ZtRsj/201/pL+YYuXmwn5wT/IOBF4IjCY=;
 b=GgnHAcVdBekUDSvTwKJLJFeddlSY2LyNd8znQseQHUQ7v7XKUF6ESPl96c1kR3FZNUbgbk+/yTfx78BzpRyR5H1aisFog1Zw/jUB/o1UdKQf43MtZCVzO2QPmIGp9c7Q/O3I5/cy5SJ6f0CmbAl0SGT3Z9cCaOm67tCvTz/qVfu+4S5yDy5h8BhoEyk0gEwxCgAKfzdONZTNJVsBR2b7VkV1fOGIVYa2C1Da5QU/7tJ0MhmmDYlkhYDpLDNE7UzPu/wxk67bxAAZY3H62nZJE5na4hqOxGjXHnyr40z5ZXJ62f2KIqG7GJeqNP4nBp4piL9Uq/1QubJNnfX+QRQaQQ==
Received: from MEYPR01MB6615.ausprd01.prod.outlook.com (2603:10c6:220:12a::14)
 by ME2PR01MB2388.ausprd01.prod.outlook.com (2603:10c6:201:19::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Wed, 1 Jun
 2022 05:03:02 +0000
Received: from MEYPR01MB6615.ausprd01.prod.outlook.com
 ([fe80::55c9:8845:1c73:ada0]) by MEYPR01MB6615.ausprd01.prod.outlook.com
 ([fe80::55c9:8845:1c73:ada0%8]) with mapi id 15.20.5293.019; Wed, 1 Jun 2022
 05:03:02 +0000
From:   Tyson Thomas <tyson.thomas@sydney.edu.au>
To:     "Liang, Kan" <kan.liang@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: Re: [BUG REPORT] perf tools: x86_64: weight column displays odd
 memory latency data
Thread-Topic: [BUG REPORT] perf tools: x86_64: weight column displays odd
 memory latency data
Thread-Index: AQHYbikBqoNARN6xu0+kyVhcP9zLfa0uIQaAgAvnzSA=
Date:   Wed, 1 Jun 2022 05:03:01 +0000
Message-ID: <MEYPR01MB66152548BEC4D0113BBBD7A5DBDF9@MEYPR01MB6615.ausprd01.prod.outlook.com>
References: <SYBPR01MB6620E2316BDF9CE29178CB32DBD59@SYBPR01MB6620.ausprd01.prod.outlook.com>
 <fd28e6fb-cf4c-a065-6138-4c581e871341@linux.intel.com>
In-Reply-To: <fd28e6fb-cf4c-a065-6138-4c581e871341@linux.intel.com>
Accept-Language: en-AU, en-US
Content-Language: en-AU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 603b2f76-867e-4916-16c2-560b5fb3363d
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sydney.edu.au;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9a21656c-c116-4226-752e-08da438c0129
x-ms-traffictypediagnostic: ME2PR01MB2388:EE_
x-microsoft-antispam-prvs: <ME2PR01MB2388D04B89DE9C2AE27A0846DBDF9@ME2PR01MB2388.ausprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: erpCS9fCCrz38vVv82HS9Jmfu8x7qJ2o5Z08yEdj2idWPTTagbqS/aM1pQFvFbOcXW2G8ia4PVHbER/cJ2GCXq4AHBg4NGRyelY4V/eCX6fkkfj13kSd2G808tgm57eR6hLeI9k1YQHZKb5vZs6zMRCh60gBRtkONro2l13IiqYLg3fbiVno1iZ5LDpQmXc4NXb4dxQBmlIGBiXaLyBtqCvXaWdbNyKwARZRl1ZApotbRRAXlwGtn0wVXnhnTBo/o+EnyUj8nz/HMZxtgpu97cEVDQaHk2vduMVCTK1G4gmcAtLgJH/zz4jY2Uu/NsIRrBqbiLsINLynjHNDkADIoi6YOxS8/6CaMvgGNXuCCcyBTPAChK6t3rsChRR0po6YqZS3d8eA9qUz+jKeLp+1O4rLQK7a/NXGKT7fJFfhfOBdMfiYOFr7ZQeMWy6Bx4xzfB0Myj8f5JUpRBGkoCrWpFr9MDiF6aHcQTRy1WirmcpdkHmN4LMOEe9LZb/ohGoyhswG309KQKX0lky2svSE/COyeZ0K/FPQ8bE5U9r00n5Dw1ew9Dnm1Gj/KRlkQ0n2nyuWrZ3mTQtYKmdz+m5FLJG8HS8y/VqFzDLCfs775/S8sDTMcR3OExbMRIxO5/fuAAnnrzGhDPY6LxmuIKdnnM3WLJE+rvu7GG81kiRsQLLsglKZNp8Fy1Y88eXzTMYhnOOh1voEhHj9L/t7l+z/fQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MEYPR01MB6615.ausprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(2906002)(110136005)(26005)(7696005)(6506007)(786003)(9686003)(53546011)(122000001)(83380400001)(55016003)(52536014)(38070700005)(66946007)(38100700002)(5660300002)(86362001)(64756008)(66446008)(66556008)(44832011)(66476007)(76116006)(8676002)(91956017)(508600001)(71200400001)(33656002)(186003)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?9hQ8X93dazgVcEBQ5OymVmZ1TiR5hGahjDsnbSo3BJ9JvFZKmbUqnYMm65?=
 =?iso-8859-1?Q?XLvZGx6C3rcfSzukxxIG9hfnE0e6pSzR6ZXhi/rwwJm/QxUnDnaUahNCDF?=
 =?iso-8859-1?Q?6tWCtfBBlyUXV3EjrIObhhll0asL1eqgFBYDMArTXyeo1VJuupgItKgX1F?=
 =?iso-8859-1?Q?LDN4mnGlkLd629unyxsL/66k7UHi49d1Y9lrTG8hd5z60BLbHkjZLHg3iZ?=
 =?iso-8859-1?Q?tE6a2DPFGbZ0QYViBG4+DiPq9WCWah5KQlSwRDDnlo/R4BKSbz90H6JSqu?=
 =?iso-8859-1?Q?k5UKMqoR4HsREy0QorTk46GfSNveAxLpczu907e+tQhvTkNzcBVCJLAnmH?=
 =?iso-8859-1?Q?9cnNNDF6T9O8j3AxXa62QtvYKFaH08zNNKxiNBmdQ+VLSQXXxzt/92BqAW?=
 =?iso-8859-1?Q?usnPYxfhZpXYbEE5PgOQGYlasQSR/EmSDX1R9rxosDVnWrAhllpR4hOefU?=
 =?iso-8859-1?Q?uMoarf3+/PYHjOp2WJapOWCV0edW+biD9PapqomUT45OemRDgD6EkIgj3S?=
 =?iso-8859-1?Q?DHC9JKCrb0AdWm8uKLckm2N0rpqX8YjM6coi/KVocvZ4sXOuayy3ezSxd7?=
 =?iso-8859-1?Q?ySJaFWuKI6tZsrgngfO571Ynd2o+JxQueTpIfPNiagj+lYiBe3iflcUpGW?=
 =?iso-8859-1?Q?VIATI3Kh/Js0iERTWj6bP/qn4HWJZqCPBTeHJL49Xj95hq6iD8HRMyUJd2?=
 =?iso-8859-1?Q?Lw72CG9elvKfv/R70yCTPtH2SV1MxzphbJcsYq71+Oma2zvxvq51lbBHn2?=
 =?iso-8859-1?Q?9GThhuoxMtG84PgB08cwLysiUBBo4ekJCT6xEmwZEGi6R3z3Ji2urJl5vF?=
 =?iso-8859-1?Q?6AMmOwR2M6MCS9vasd/vx1bpHWGGm5IRnpWTVzqvsxeJAuMN+15IfOcOYS?=
 =?iso-8859-1?Q?06uLrYtf+aZG6stWApVNkBOdblpSrD6jHSqfrve9/6Mq64DLed1evWLYMI?=
 =?iso-8859-1?Q?2dckHJQK+glxMDd6YBFHXavUipUw1SVK1pUX4Vh+M7lTPHoL/lSMCm9cK1?=
 =?iso-8859-1?Q?VdGEi5bBn3nQXtQZIwJLR6QlkrHVaDtvZ3H3MzoJ0CmtT4N0f1ty8LozLM?=
 =?iso-8859-1?Q?irEc232Jx00w9iMcAykWekETiwc7PHczbLNxKRg2eJCOPQjPSUp/FkjRmn?=
 =?iso-8859-1?Q?zKJ18nmhislkZkWgfH49adLGiF/+tD34L2xkpMmlH/1oJrqNkJvhzNo7oD?=
 =?iso-8859-1?Q?Yjqpz893yFoVvS7E3kUKO8uFG66SYXfr2Idbs68xUWvapXolvqig5P9fMQ?=
 =?iso-8859-1?Q?u+fRNa/JtfBJXT2WSspqKfO3AAAENXT/8ObGX+KBMf6gxuQUFQBdtgpD4S?=
 =?iso-8859-1?Q?C73V5UkxKVyLdI4T3t9hTIr7sha9usGk499xv+agAOQKTWBgk2QrFcRjGR?=
 =?iso-8859-1?Q?uWH/Ket+odVUyBtoKj3QMVysmutQrG1gt4azd62x2BFTL+YnT/QGic+3ZW?=
 =?iso-8859-1?Q?QkLsN9siKUMODva7nIArieqjI8vfWzU5xA1lamn+7yXQAEO8d1AhFFPT2B?=
 =?iso-8859-1?Q?6VWhepNjSzZ+Qo7ghw+V30xd/NUBT9/o2321htdydKTx6ZDi5DGgsK7OBI?=
 =?iso-8859-1?Q?VNknvdtAYcM5mLLPE0tm9vT7Lim/46xAn3Ojr00rjk4qWLi3rkKNrVuR5Q?=
 =?iso-8859-1?Q?1CJe6PKbCb2PMJVwqNKceXy59VXiFvDQzZk6y3StjPKgR2/MZ40wQ02WOJ?=
 =?iso-8859-1?Q?Qm2AUA9ZKBwmHDcaUYhCmludmFGeaZqCqu/TLd0wZLngn6oLkpIGZqamKl?=
 =?iso-8859-1?Q?bnpnJGS2UPcZ0L9zKkHqRZ7qH0/lIPrRZLfTwiHtpGNmfFr3b+6b1VSQ0j?=
 =?iso-8859-1?Q?EhcdZkvTmQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sydney.edu.au
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MEYPR01MB6615.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a21656c-c116-4226-752e-08da438c0129
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2022 05:03:01.9854
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 82b3e37e-8171-485d-b10b-38dae7ed14a8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VvKGZZADnQPz6bFAdxo6JL6aIhRTRUayMLlzI/4EVJ+pIVfYln2mOn5Gw9JudJw5R9uvWMVjHuN6pT7Ua9bBiWqpohLfGR+cmd7XZMNUWEs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME2PR01MB2388
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
Thanks for the reply.=0A=
=0A=
The exact command used was: perf mem report=0A=
=0A=
The columns are in order: Overhead, Samples, Local Weight, Memory Access.=
=0A=
The results I sent before are: Overhead, Local Weight and Memory.=0A=
=0A=
So, to update the table from before, each tuple has a sample of 1, so it is=
:=0A=
=0A=
   0.02%,1 ,62515 ,L1 or L1 hit=0A=
   0.02%,1 ,54048 ,L1 or L1 hit=0A=
   0.02%,1 ,52206 ,L1 or L1 hit=0A=
   0.02%,1 ,49831 ,L1 or L1 hit=0A=
   0.02%,1 ,49056 ,Local RAM or RAM hit=0A=
   0.01%,1 ,40666 ,LFB or LFB hit=0A=
   0.01%,1 ,38080 ,L1 or L1 hit=0A=
   0.01%,1 ,36772 ,L1 or L1 hit=0A=
=0A=
So, the weights are absurdly high here. =0A=
=0A=
I'll give a reply on perf report -D shortly.=0A=
=0A=
Regards,=0A=
Tyson=0A=
=0A=
=0A=
=0A=
From: Liang, Kan <kan.liang@linux.intel.com>=0A=
Sent: Wednesday, 25 May 2022 12:58 AM=0A=
To: Tyson Thomas <tyson.thomas@sydney.edu.au>; linux-kernel@vger.kernel.org=
 <linux-kernel@vger.kernel.org>; linux-perf-users@vger.kernel.org <linux-pe=
rf-users@vger.kernel.org>=0A=
Subject: Re: [BUG REPORT] perf tools: x86_64: weight column displays odd me=
mory latency data =0A=
=A0=0A=
=0A=
=0A=
On 5/22/2022 6:14 PM, Tyson Thomas wrote:=0A=
> Hi Kan, Linux-Perf Team=0A=
> =0A=
> I have observed some odd behaviour within perf when using perf-mem. Speci=
fically the reported latency under the weight column appears to be unreason=
ably high.=0A=
> =0A=
> Here is a given sample from a recent test, I find that some of the=A0 lat=
encies are close to an unsigned short and I cannot seem to be understand wh=
y that would be outside of it being an issue with the perf events.=0A=
> =0A=
> This can be replicated using a NAS benchmark, specifically cg.D.=0A=
> =0A=
> I observe the following results in perf mem report (just getting the top =
10 results)=0A=
>=0A=
=0A=
=0A=
Could you please show me the exact perf command used?=0A=
=0A=
With my perf mem report,=0A=
The first column is the Overhead.=0A=
The second column is the number of samples.=0A=
The third column is the weight.=0A=
The fourth is the Memory access.=0A=
=0A=
Seems like the weight is missed?=0A=
=0A=
Could you please check the perf report -D?=0A=
It will dump the weight for each Sample.=0A=
Does it look correct?=0A=
=0A=
Thanks,=0A=
Kan=0A=
=0A=
>=A0 =A00.02% ,62515 ,L1 or L1 hit=0A=
>=A0 =A00.02% ,54048 ,L1 or L1 hit=0A=
>=A0 =A00.02% ,52206 ,L1 or L1 hit=0A=
>=A0 =A00.02% ,49831 ,L1 or L1 hit=0A=
>=A0 =A00.02% ,49056 ,Local RAM or RAM hit=0A=
>=A0 =A00.01% ,40666 ,LFB or LFB hit=0A=
>=A0 =A00.01% ,38080 ,L1 or L1 hit=0A=
>=A0 =A00.01% ,36772 ,L1 or L1 hit=0A=
>=A0 =A00.01% ,36729 ,LFB or LFB hit=0A=
>=A0 =A00.01% ,27101 ,LFB or LFB hit=0A=
> =0A=
> Is it possible for someone to shed some light on this or am I misundersta=
nding how the weight column is used here?=0A=
> This appears to have been an issue on 5.4, 5.10 and 5.15. I am looking in=
to seeing if it is still present in 5.17 and 5.18.=0A=
> =0A=
> I've also tried this on different Intel CPUs such as Intel Xeon 6230, i5-=
1135G7, Intel Xeon 6330=0A=
> =0A=
> Any insight or help would be appreciated,=0A=
> Tyson=0A=
