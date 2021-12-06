Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3AA46A4D4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 19:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347296AbhLFSqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 13:46:42 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:54758 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238859AbhLFSqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 13:46:33 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B6HvtTb003048;
        Mon, 6 Dec 2021 10:43:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=HL6HrgcNBvs0UlPx6XJwaFBGowJMDwcC8IbqbjXQj9U=;
 b=f+qBNNQgCvp2ugsmGHQy7P9WGOu9KqXX+YDrF3JcuEUGPHCPX0+t5p+U+KOLtHmfAoFd
 wsoDe1fNvNbo+C8xL6sQLvTCblHsrCi99HGrKZrfabdmFkariAmLJQv2syktUgDwtbsE
 gsI6/Dnz3TAghHKIqgRZQ2SnsY7PDSKS1ZA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3csjxxtard-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 06 Dec 2021 10:43:03 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 6 Dec 2021 10:42:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JoTprzfVWz2QT2Xg8aVsFMOYU0597vL/rY1hoEM2UqKjdJShnH7/+b2hxHKGwHJADkcOFMC/XautL8RkcnwCuhUAxWhuTTlMHFHyQFerQnMECg4RCex/ZSeFUzu35GHmStfF7ZGYnOxoYQcAzy3BksEOCJv9XV67Jp0UH55tyB1ZyUOvvp/uJRblDtkaKwvAgm9uX7YlEn+tzR5SBnivL9P83k+0/bnx9phUO8Qfl+147PkRzZvdFBfNomEyr9QEl6Ea4SDhOq7UCw/SBHDpveLiNip1d11U05/+2Z+1TISfsnL5W0KQP+OVN87e9c0Y6O+C6JbITdD32cBroT5uKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HL6HrgcNBvs0UlPx6XJwaFBGowJMDwcC8IbqbjXQj9U=;
 b=a/udDzmFcPnvTKd0jOquSAKStafDxbbh7zPc3HrJuKRrFaAcDDiLQi6ZJa023EYvqkDAsAnUeDaDmVKoR217/c3MjkJYTlsRMaE+OmZ22s8q65OqaaqfuciNiVOjCxvOljIuLmt6JhvULQbDoNW14p2ajKraIXlqz0W7UPcgFQ5flRBu1gsWrfEuHgLuSIl/l3OEwr0do1XEczVnajZfs/VqKPLKhj+LjYCFWPmDAe/XXQQeQ05CytC9Uw5Het333FNRVXWYvWeXlYB3S8dk+cQWcu4PxA0T2cbzpgWXc/+PXuC0D+/ZVXbJFD3vzKMttSl8FJ5fg6rQO8H8RAvJ+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BY5PR15MB3667.namprd15.prod.outlook.com (2603:10b6:a03:1f9::18)
 by BY5PR15MB3620.namprd15.prod.outlook.com (2603:10b6:a03:1f8::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16; Mon, 6 Dec
 2021 18:42:58 +0000
Received: from BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::848a:51b3:982e:de87]) by BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::848a:51b3:982e:de87%4]) with mapi id 15.20.4755.022; Mon, 6 Dec 2021
 18:42:57 +0000
From:   Nick Terrell <terrelln@fb.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
CC:     "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>,
        Michael Forney <forney@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] kbuild: pass --stream-size --no-content-size to
 zstd
Thread-Topic: [PATCH v2 2/2] kbuild: pass --stream-size --no-content-size to
 zstd
Thread-Index: AQHX4UhKidKPr3kbgE2o2YP10PuuiKwkkw+AgAFMjIA=
Date:   Mon, 6 Dec 2021 18:42:57 +0000
Message-ID: <F49C6875-FFDD-4314-A202-0C428B525A6A@fb.com>
References: <20211124153105.155739-1-alex_y_xu@yahoo.ca>
 <20211124153105.155739-2-alex_y_xu@yahoo.ca>
 <CAK7LNASO_EmCp2zR_sBq_YNiw83Px8pKhcW78HKv1My7eKB+2w@mail.gmail.com>
In-Reply-To: <CAK7LNASO_EmCp2zR_sBq_YNiw83Px8pKhcW78HKv1My7eKB+2w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 68d0ddbc-654e-4501-8f38-08d9b8e83919
x-ms-traffictypediagnostic: BY5PR15MB3620:EE_
x-microsoft-antispam-prvs: <BY5PR15MB362056A9E92EA0E81A41FF3EAB6D9@BY5PR15MB3620.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FEdd2gvIlEnYhX4mh+IKTD8+95fTAdCKzjEAwZEQvBnE1Yhyu3oc5NC/PV171GR/3yh7Urgu9IjoWY7NWUfDwiatsmB+IjVMsiiGEAbSNpu7kUWqNGYQzcINeGEGDV82GwccEL1+CfOM0IWPQvcNYJerTkotsHlUXGgCG5N4iyEdCgbY9IlTy94I0xeCNmdUwVclbhxJIya6j6mRFWlolzzro5j3eLPKYA11TSQBep1EoQ++UXDrXGU9ZRraNfwLbvTOaKcQ01iHEP3zRnWd6vxtu+iZlttNAVm1xnX8ERKyuvjwxjWlrYQIzIbNYlZ6zy4790fIpG6f6vG4liiag1EGGG8WMwtU+IBn/XUhLkjojVFjjbjddRuT3YNZBjkIL7a0MedijLFHQGjIfN3VFIQiMXAXCT9VwqMXiX1UsZJjh6FbFJXXnkB8e5ptAHhoP3HGJ9C7GN8IZlDRngU8CbbMuTe5WGwdNmDMKOPvlbDiICoAxlpGr8xeOCHPiY2cEMyZIHhpIbjFP5xUSFHdXgkHVPX49BZT1SaKKYJbTC3U/dt1Tw/CidPBCMEZi2zhwlNfulWBoHnA/cGv8pbDaJnIM2s0bt/bD9lBesX5aSD72FfYRA/qFZuRlbDvyaLQaY86nBAd0P3G5D33YK8N2X3h02LHSgwvlvliTDOaJu2JZoWjGGzQ1rWQqDeP0Vv4NfKL5HSeLMbAX+LItmXx8Ncl3a+YIkYV0UoDCQEw9gpAqh2ybtj5L8tQ3UCRNP9zQnXcngVUIMUsohaDAxRuTQlPRTquUdiZAXEp0DJ9xZc8DmV4vpczlYJr0XNUCRWHUwexQyzaWu165eoiS1ZyUA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3667.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(122000001)(966005)(186003)(66556008)(64756008)(66446008)(38100700002)(8936002)(6506007)(6512007)(76116006)(53546011)(6916009)(66946007)(54906003)(33656002)(5660300002)(316002)(26005)(86362001)(66476007)(2616005)(71200400001)(508600001)(4326008)(8676002)(2906002)(6486002)(7416002)(36756003)(38070700005)(83380400001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IbZgJtL+SotSSm4NIigua96IL9+XU/QTw8cAaUspy1FtxtE+CpGEUASpdUb0?=
 =?us-ascii?Q?sJsgH1UpbFxzfzZdlm4XW1oIxj/c8Z/JpdRcRLtjPAKJtkV7fAg6ZUj8v9Pp?=
 =?us-ascii?Q?YyY4r9qo+Wz1tp4QCb9ja3JyzdudebLad1rTv25W02qgEVkBCK2bhDgqCJ3x?=
 =?us-ascii?Q?yVcYEmAmrtlSFwqJk0UkvpN78X49AkMoNqKwlpFLVS0Yqz2uOS0c0moeEMrX?=
 =?us-ascii?Q?AOrJB8JRTPHQAyqy9XlQPku3gdUHA+2C77QjYX+Ic7RrMWpui4e6t4eXbiu1?=
 =?us-ascii?Q?b46I3cEDqJr67WNQWC4k4I/821cblROBJXzNnEeAi3YxGwXIs/cE0tu3KmJP?=
 =?us-ascii?Q?Pj5cK3UUkoVN6PZoBtMDoYec8R/H3eli5NwSbjxiSJeamy96MGr/gzuR4ASb?=
 =?us-ascii?Q?WBLuGoHYCBMdrYbqkRz4Owwr84wfhkr55esMPCRbhCULrZp8O1h5RYGVc+PF?=
 =?us-ascii?Q?+0xpNcLJSl+fn7GeKlZIDw+0N+HJ0mlUgL8Sq5AF+N6pzKwMxHW+agW91Bfz?=
 =?us-ascii?Q?wCibrZBFDDkrus0iPKjNV4KR3tkZxc3glFbOD8WAQmAJ6NEmqEGIF86OSEr6?=
 =?us-ascii?Q?q2StmJ/x0EGT0X3tkf3EjGjd5JLd+1IlgVKpt1pXv6UF1n1nXg/xkzlecYWa?=
 =?us-ascii?Q?DK50P/ScoumYi2KMMIniTFX4CDpVbFebR03BW85E7KgQ+AIbH6Y7F5HFJDj4?=
 =?us-ascii?Q?HVZsz326e5N6IpZqoPF2Mw1/PSwpzraemStgLWY6345a0M0yzL1WpKGGxrq7?=
 =?us-ascii?Q?J/qX8SwsXw5mPHycrI5wf7po9KWl0WlyRYHae9/3Zmy9MXY5fJxxMKb3aGWy?=
 =?us-ascii?Q?bm+hqm0/qu0QgYaYWL9ck2j1mOB43E/lc7XZiqDMbXEZbJylglPOCBTD2Ypl?=
 =?us-ascii?Q?ZbpNZA2RvVKxgmfsjrZXCR/Sy17tJtfTMOE/iEU+PcnUgoy2hhT34jWE6xCJ?=
 =?us-ascii?Q?3opdN/DKMFhDS1FBtu53m/sYJzdjEkeOi06PQz0n95OItnkT4bukAmMZYMIk?=
 =?us-ascii?Q?U+ptBVlk6LMg1WHuZvBVFgOfOCNOWhm89u3i0TnPBpGBcA6hF9yfNlESp3h5?=
 =?us-ascii?Q?UOwtIg30bGwF9OVVMQIB79wbzYB680LzIDullfs7taeIXI4p9F0DbYkybZT7?=
 =?us-ascii?Q?jEqn8pQ4PgdPvncs595GqSqqLfE6U7kw3jHbvvzINt7RovYDyiDfxs4RSxO3?=
 =?us-ascii?Q?Ef02ElELdxAswrShwUP8UUMdSKEUo0Il1S79pMnLE7yWIo37BqBoxMu2vQLQ?=
 =?us-ascii?Q?dvzkF8R5ouZCgkEsdup8y0KZgj7fBmmPUcHXNIT2IYvSZoYZsZVyO1z3IetT?=
 =?us-ascii?Q?RNBeFTauf3UO3zjf/aauJFQfWY2O9/jK/SoqVOdnoeSxVylskvg7RVMvB+5g?=
 =?us-ascii?Q?i4WcxXcXcCkabVrkfS+8TkdBf7sAlI0058sJiU+fPcP8kqtH8WuWgVy7+P9G?=
 =?us-ascii?Q?27GKIOoTv3BwFw2BE80SPQ1WzVc5Fdv+oiL/I8mss3s30ioX9UA+Ps+fmG/t?=
 =?us-ascii?Q?iYB+6rlw11S0v2PZFNb6ZuPUzhHmZdb6aEdknfXqrQHVxEH5m7b14PZu5dRI?=
 =?us-ascii?Q?LlL4r26ZWiIoOhQQt2w=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5C371F601D27E84B9FDB758ACFB85FF1@namprd15.prod.outlook.com>
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3667.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68d0ddbc-654e-4501-8f38-08d9b8e83919
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2021 18:42:57.8442
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nP9SLovl4uuhISZ14JkLYzEoX0DgiOgi4jYDRSJ8sRt5tfNxZHeidbgpyvxMNQ2Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3620
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: nWXTKUejND0PqCs0GWRKTEFOA2VlB3eE
X-Proofpoint-GUID: nWXTKUejND0PqCs0GWRKTEFOA2VlB3eE
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-06_07,2021-12-06_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 clxscore=1015
 priorityscore=1501 mlxscore=0 malwarescore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112060112
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 5, 2021, at 2:52 PM, Masahiro Yamada <masahiroy@kernel.org> wrote:
> 
> On Thu, Nov 25, 2021 at 12:30 AM Alex Xu (Hello71) <alex_y_xu@yahoo.ca> wrote:
>> 
>> Otherwise, it allocates 2 GB of memory at once. Even though the majority
>> of this memory is never touched, the default heuristic overcommit
>> refuses this request if less than 2 GB of RAM+swap is currently
>> available. This results in "zstd: error 11 : Allocation error : not
>> enough memory" and the kernel failing to build.
>> 
>> When the size is specified, zstd will reduce the memory request
>> appropriately. For typical kernel sizes of ~32 MB, the largest mmap
>> request will be reduced to 512 MB, which will succeed on all but the
>> smallest devices.
>> 
>> For inputs around this size, --stream-size --no-content-size may
>> slightly decrease the compressed size, or slightly increase it:
>> https://github.com/facebook/zstd/issues/2848.
>> 
>> Signed-off-by: Alex Xu (Hello71) <alex_y_xu@yahoo.ca>
> 
> 
> 
> 
> The reason why we need this workaround is just because we do
> "cat and compress".  zstd must allocate a huge memory beforehand
> since it cannot predict how long the stream it will receive.
> 
> If zstd is given with a file name, it can fstat it to know its file size
> and allocate the minimal amount of memory.
> 
> 
> This is my test.
> I used 'ulimit' to set the upper limit of the memory the zstd can use.
> 
> 
> [test steps]
> 
>  # Create a 1kB file
>  $ truncate --size=1k dummy
> 
>  # Set the memory size limit to 10MB
>  $ ulimit -S -v 10240
> 
>  # Pass the file as a argument; success
>  $ zstd -19 -o dummy.zst dummy
>  dummy                :  2.15%   (  1024 =>     22 bytes, dummy.zst)
> 
>  # cat and zstd; fail
>  $ cat dummy | zstd -19 > dummy.zst
>  zstd: error 11 : Allocation error : not enough memory
> 
>  # cat and zstd --stream-size; success
>  $ cat dummy | zstd -19 --stream-size=1024 > dummy.zst
> 
> 
> 
> 
> scripts/Makefile.modinst was written in such a way
> that zstd can know the file size by itself.
> 
>      cmd_zstd = $(ZSTD) -T0 --rm -f -q $<
> 
> 
> We cannot rewrite scripts/Makefile.lib in that way because
> arch/x86/boot/compress/Makefile concatenates two files before
> compression. And this is the only use-case of this feature.
> 
> So, I am seriously considering to revert this commit:
> 
> commit d3dd3b5a29bb9582957451531fed461628dfc834
> Author: H. Peter Anvin <hpa@zytor.com>
> Date:   Tue May 5 21:17:15 2009 -0700
> 
>    kbuild: allow compressors (gzip, bzip2, lzma) to take multiple inputs
> 
> 
> 
> 
> With that commit reverted, zstd will take a single input file,
> and we can do "zstd -o <output> <input>".
> 
> 
> So, I will take some time to investigate that approach.

This will definitely work from a zstd perspective. All versions
of zstd will downsize their memory usage to match the file size.

Best,
Nick Terrell

>> ---
>> scripts/Makefile.lib | 12 ++++++++++--
>> 1 file changed, 10 insertions(+), 2 deletions(-)
>> 
>> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
>> index ca901814986a..c98a82ca38e6 100644
>> --- a/scripts/Makefile.lib
>> +++ b/scripts/Makefile.lib
>> @@ -466,12 +466,20 @@ quiet_cmd_xzmisc = XZMISC  $@
>> # single pass, so zstd doesn't need to allocate a window buffer. When streaming
>> # decompression is used, like initramfs decompression, zstd22 should likely not
>> # be used because it would require zstd to allocate a 128 MB buffer.
>> +#
>> +# --stream-size to reduce zstd memory usage (otherwise zstd -22 --ultra
>> +# allocates, but does not use, 2 GB) and potentially improve compression.
>> +#
>> +# --no-content-size to save three bytes which we do not use (we use size_append).
>> +
>> +# zstd --stream-size is only supported since 1.4.4
>> +zstd_stream_size = $(shell $(ZSTD) -1c --stream-size=0 --no-content-size </dev/null >/dev/null 2>&1 && printf '%s' '--stream-size=$(total_size) --no-content-size')
>> 
>> quiet_cmd_zstd = ZSTD    $@
>> -      cmd_zstd = { cat $(real-prereqs) | $(ZSTD) -19; $(size_append); } > $@
>> +      cmd_zstd = { cat $(real-prereqs) | $(ZSTD) $(zstd_stream_size) -19; $(size_append); } > $@
>> 
>> quiet_cmd_zstd22 = ZSTD22  $@
>> -      cmd_zstd22 = { cat $(real-prereqs) | $(ZSTD) -22 --ultra; $(size_append); } > $@
>> +      cmd_zstd22 = { cat $(real-prereqs) | $(ZSTD) $(zstd_stream_size) -22 --ultra; $(size_append); } > $@
>> 
>> # ASM offsets
>> # ---------------------------------------------------------------------------
>> --
>> 2.34.0
>> 
> 
> 
> -- 
> Best Regards
> Masahiro Yamada

