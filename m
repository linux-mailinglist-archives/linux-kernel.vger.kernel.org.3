Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F052466EAE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 01:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350068AbhLCAtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 19:49:18 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:55730 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S238220AbhLCAtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 19:49:17 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 1B2JSriX017248;
        Thu, 2 Dec 2021 16:45:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=am4feINdttY2HvsSmtFYOW9/ifpAWI8+mGYJHWHiXLA=;
 b=MQN8IdoefdJoStdEzwvVOMY+EjBw1GfLiRNB3BbpQOMjes5ieOmT6a6uuCa8uHYH63Sg
 RkSNlZbLXfIUaQis+/89AyYUZdtZua0cMmiRdbkBsHkjnO4zt9BtXsbOhppVOr7fjULi
 KOIyzp3EuUv/PbaAbBHVSJPQ7d0HSHl3yxc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 3cptg6y573-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 02 Dec 2021 16:45:53 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 2 Dec 2021 16:45:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N19AFxLvUwYwA0I0dbFY6h/daLwcBucbPFL2XsLQQQ8gvtZDNWBWEgiXRX0hzq7PUgZ7lHvapFkFWIn0kSapGsYsMcVOmbGhOgPo1V2ypfQPkfDyElMx2EIVkIV7AoFcTPvNjQWSdu//aLBQmOpEmh8+s6pgCi1/+wujXxvIwZtI2muTc0pdIv8MWE8l/XJj4aduW4dG9BvKNo0Tw1YLpxyBW5g4TAFhjhkzphsatzuarS4J+LQeVNRjLF4YevwWesG10fkjNeyq2wktrVP94nAlx/ONnpKaLII4NTvaa+iDJvNPx5E934MTyGQscprLuIZ89orHVlAt/vtxS+KJRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=am4feINdttY2HvsSmtFYOW9/ifpAWI8+mGYJHWHiXLA=;
 b=jY1zLTXNyAxz2cj9voiIWFpOUfdpfqtTCmZw0DoPv0e4IkJpFnyqcNIyK3+0djvwfuTiNqHYNqDCqCor7Uk+IPMaAaJO0KH3sm6S8W2HgPSDA3W9PD82sc/NLMa9tfuDEIPwQNF0QieQljO87MtSTTwJfgwlntEZlivxe7E9mpf9jscWrGaCqdzlfnYf2RGxwJ311TvCnSX/DG8W3iMDnUI4eF8I2+cBEnzDIFZE+cg5Qvb5b2pR6jLUPa3UOp+h0udfIWmsGYebcWoJ/dM4m/8cAXJ0N3S5XIavuXIUQ7BfuftRMpZ7/g7BTg9hRdlvTkmm5aXmj0sL5FDOCTMgGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BY5PR15MB3667.namprd15.prod.outlook.com (2603:10b6:a03:1f9::18)
 by BYAPR15MB3366.namprd15.prod.outlook.com (2603:10b6:a03:10d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Fri, 3 Dec
 2021 00:45:46 +0000
Received: from BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::8d7d:240:3369:11b4]) by BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::8d7d:240:3369:11b4%6]) with mapi id 15.20.4734.024; Fri, 3 Dec 2021
 00:45:46 +0000
From:   Nick Terrell <terrelln@fb.com>
To:     "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
CC:     Michael Forney <forney@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Sedat Dilek" <sedat.dilek@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] kbuild: use perl instead of shell to get file size
Thread-Topic: [PATCH v2 1/2] kbuild: use perl instead of shell to get file
 size
Thread-Index: AQHX4UhEMAJasQNrTUa+7KWlM097GKwf+6WA
Date:   Fri, 3 Dec 2021 00:45:46 +0000
Message-ID: <5AD03AD1-4422-4F91-85DF-086E11A47FA9@fb.com>
References: <20211124153105.155739-1-alex_y_xu.ref@yahoo.ca>
 <20211124153105.155739-1-alex_y_xu@yahoo.ca>
In-Reply-To: <20211124153105.155739-1-alex_y_xu@yahoo.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: becd6309-5761-4a71-cbfd-08d9b5f63e54
x-ms-traffictypediagnostic: BYAPR15MB3366:
x-microsoft-antispam-prvs: <BYAPR15MB3366EB34E852BE5CB464123EAB6A9@BYAPR15MB3366.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /3aYjwlC0fkd0/+tslfb6lx8narvvPfOBuyQFwllKy8M4bd/nhKjfuOa8t9vUEUGfmWr5VzRDl3edXoENhcwHETl3DS3UfNtlLcj0T8uHBq5ksgoJrHVf/k+P8USnFyIY5gqWh2R8bI23jJgaVC/mzwkNZ4k0VECDHvBgCe/vKk225qYrwl1GB9zf4hI4FE+1CEenue9qAgm6aHN7xGl4Hw2kdJzKCc3M47hKhPgsK/umnNs4B3kDy46/ahLrDeqpLcNI1skVOA92p0d/4y04+0Et9FBmJLzuBIGL5ofig7Dm3FhfPYHfQRg03+jTfgtKyWzN00WlGgi5o7FKZnep9htkWvc/u4szIZ4v7RhD6d4NP04p1yv6riyTlTI19XNDLr5JXEtkXlYrvOd/pFiiOvIgGfX2LBbrpevvjQ+NCKOwm/7io5iJj3Wn1WPwPey6fj2AAa8rmHeNDmiFg6eAcTqcGvx90e7GVl7pLxhEuM3SSZArB8CNvpvwT9h8EEl0DF6YhJN9lHXxtOJZRU8mDCZxdZayZp0KKuceS4vNqeaUqEd3/2p1N+7Md5uQmc2LxC5Eb7Ly59VAGYJJ978PA7Ux0CJQ8UcT3GbdKntYW5wMY3wAzh3bziLmmArfbdaQZdCV/cYOvTNQynfLonZDEVewMmMAZVXUn5xJiGkv18Z3AZxLSS9LVhKL2CEjzv95O84PJNFULt2j/LcgJTkZVOu/XXUdZ/V6LD3oJtJ1b8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3667.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(7416002)(66946007)(91956017)(6916009)(186003)(2616005)(8676002)(36756003)(86362001)(6512007)(5660300002)(33656002)(54906003)(53546011)(66476007)(71200400001)(83380400001)(316002)(66446008)(4326008)(2906002)(64756008)(122000001)(6486002)(6506007)(8936002)(76116006)(38070700005)(66556008)(38100700002)(508600001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8/ge/M1FbraA+SGFAswLbB6+Sw2Az4OUGsNo0I9C+5JtHjtKI9MDaFecoTWC?=
 =?us-ascii?Q?Ja99eWerRsF9O4+UVpqCfnCuqEhRcaDlkyzF4x71bFbwaPyaCA871PJn60Ky?=
 =?us-ascii?Q?psnRImvrd7JdUV+RI2uKDk5O1O2P22sxfPHyqGp5IDqEAxekHysOvHRAqf6t?=
 =?us-ascii?Q?Yc+G5tJusom+gRRezW6PLzmOi1ZapXfRWy6s3Tl1qORKoHPEQjFIC4q1Gg54?=
 =?us-ascii?Q?DV6znVLbK5osbtaBuEn4Wyn9O93ZiduW3bNmntNk4fMxvF5eceVmifKhp73p?=
 =?us-ascii?Q?F7VBeU5DeMla49MMIh7WmfjY+gjiGC9hxNnm3BWPGq62rjcjthUZMzj8yyAV?=
 =?us-ascii?Q?YxDAuWCuZePc900/shjARLBTScD6yMaiuN7MYsSJ34qbh3J701hkYPdopodo?=
 =?us-ascii?Q?TiSPa7QQUbLMFXpJuEHMBYjofRCvui8t+SFVCq54ecKOqBQr5rQ/m7UBjb0Z?=
 =?us-ascii?Q?FeOsY8KhRF/J8GjQ/7aK9g+Lt8v88kmVMlDT6a2uewoPGoTJhTBq1yVTrUAr?=
 =?us-ascii?Q?64UXyYU76Z+dKJfMnl0xozxl7ywxEeeyPLalen5anbVWKJdQ7qaxlC0YsOkU?=
 =?us-ascii?Q?fTipEujaokwgGjwD/Tvy2c6K0RcowijiX8lEv7m/JTuXhg2/vWO4++l2Yvcj?=
 =?us-ascii?Q?fS7ej5vRnP3ry+WtuZ2otFFFP/ivAUIl0LOfWEcVeSWtqQXmMRPCOa2alnat?=
 =?us-ascii?Q?k/ex4hlGM9iLzCXzodyqwL0mSLUs+h8miANTC7ky6DdtQqmmIWf8kVDZ9Z/6?=
 =?us-ascii?Q?gTxxbf34P35tWxpOFTYfPdZUIHuZFsUMHkVE3+PSnwtHyKl7GAuy1IBkvfui?=
 =?us-ascii?Q?AAHlAOo7iWpYSmrGViIkDiUGmh1MHgVog0h0kRLa7y6VbOtO0zUOB3dhruB8?=
 =?us-ascii?Q?NuZTYVea318OujPtTfbXVQa8UokmMtvZndfSmHFIiSwFw/BWsIvEOib6eBVr?=
 =?us-ascii?Q?ZmckniyyO88YfP0pHSCfG8HP5GypANF94dJhZ/BGC21dG5534YkB6ywxyXEA?=
 =?us-ascii?Q?lceAxPpZZB1EtJ7O++FyOmvxZbTkKUNNQ+zhbZ2GURdgR06CXNS+0GYnV4tg?=
 =?us-ascii?Q?rTLvxeeNmSHHIAm0G+hO5/midvVhNboP/R87aThDM+Sp0z65NaeRZKKiQJi5?=
 =?us-ascii?Q?jhnJreIgR6j8GZwHRvX98IDhXazImxYrh1Phmn3kN431GzDD4VWmEtbTyl3S?=
 =?us-ascii?Q?TnwNeASEKqzs88+BizS/aEiNBfr5IraodWeWbdM5E7uYUFbTs4lYDWUAHdnF?=
 =?us-ascii?Q?4TAtj1whqj5Pu0CDqyrB/JCLkjK2iirUbRT2mg/C5Co/oQMuQLzRtTuX7TJO?=
 =?us-ascii?Q?I/rSXBynUyoPHOBntv+aDHcfzreI2t7Y+7HF3s0TC9TaoI9xlAZFZBRozAeo?=
 =?us-ascii?Q?scOVVl6RY3gQSU6V86mlsi0y5j1h5US8i7tx/yvZDNFpKzPlbKqgvbsntFiX?=
 =?us-ascii?Q?DaEpjPe23LgC77LH9CJJdlcom4GuHLqyx4x0CEqS4NE+juX8Trxsf1ePrIGk?=
 =?us-ascii?Q?l8rIe2BbcSmBi/O8B3ZghW2oH/9J5yf5+f3WC2zUsNNxErKWuMNj2B4F7gNE?=
 =?us-ascii?Q?pRcmIlZAu/y3fDWa6Q4pEeavGtJ3qFh9ZaxK1hv/To3lJcYHbCpbngBa6LSC?=
 =?us-ascii?Q?gg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A933AC9D04844C459588F6B0AD4F9470@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3667.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: becd6309-5761-4a71-cbfd-08d9b5f63e54
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2021 00:45:46.1303
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uUk83/Ao9HuFzlnJ8kSipBJqbZAjdRM2cfTbELD5yPzGMSZpq69E3QA/4iv2HC9M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3366
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: 1zZlm07UV4CawWZbwHOMIyrSS6MaaCin
X-Proofpoint-GUID: 1zZlm07UV4CawWZbwHOMIyrSS6MaaCin
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-02_16,2021-12-02_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 phishscore=0 mlxscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=999
 clxscore=1015 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2112030004
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 24, 2021, at 7:31 AM, Alex Xu (Hello71) <alex_y_xu@yahoo.ca> wrote:
> 
> This makes it easier to get the size of multiple files. Perl is already
> a requirement for all builds to do header checks, so this is not an
> additional dependency.
> ---
> arch/arm/boot/deflate_xip_data.sh | 2 +-
> arch/powerpc/boot/wrapper         | 2 +-
> scripts/Makefile.lib              | 9 ++-------
> scripts/file-size.pl              | 8 ++++++++
> scripts/file-size.sh              | 4 ----
> scripts/link-vmlinux.sh           | 4 ++--
> 6 files changed, 14 insertions(+), 15 deletions(-)
> create mode 100755 scripts/file-size.pl
> delete mode 100755 scripts/file-size.sh
> 
> diff --git a/arch/arm/boot/deflate_xip_data.sh b/arch/arm/boot/deflate_xip_data.sh
> index 304495c3c2c5..14cfa2babb93 100755
> --- a/arch/arm/boot/deflate_xip_data.sh
> +++ b/arch/arm/boot/deflate_xip_data.sh
> @@ -43,7 +43,7 @@ data_start=$(($__data_loc - $base_offset))
> data_end=$(($_edata_loc - $base_offset))
> 
> # Make sure data occupies the last part of the file.
> -file_end=$(${CONFIG_SHELL} "${srctree}/scripts/file-size.sh" "$XIPIMAGE")
> +file_end=$(${PERL} "${srctree}/scripts/file-size.pl" "$XIPIMAGE")
> if [ "$file_end" != "$data_end" ]; then
> 	printf "end of xipImage doesn't match with _edata_loc (%#x vs %#x)\n" \
> 	       $(($file_end + $base_offset)) $_edata_loc 1>&2
> diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
> index 9184eda780fd..9f9ee8613432 100755
> --- a/arch/powerpc/boot/wrapper
> +++ b/arch/powerpc/boot/wrapper
> @@ -380,7 +380,7 @@ vmz="$tmpdir/`basename \"$kernel\"`.$ext"
> 
> # Calculate the vmlinux.strip size
> ${CROSS}objcopy $objflags "$kernel" "$vmz.$$"
> -strip_size=$(${CONFIG_SHELL} "${srctree}/scripts/file-size.sh" "$vmz.$$")
> +strip_size=$(${PERL} "${srctree}/scripts/file-size.pl" "$vmz.$$")
> 
> if [ -z "$cacheit" -o ! -f "$vmz$compression" -o "$vmz$compression" -ot "$kernel" ]; then
>     # recompress the image if we need to
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index d1f865b8c0cb..ca901814986a 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -379,13 +379,8 @@ dtc-tmp = $(subst $(comma),_,$(dot-target).dts.tmp)
> 
> # Bzip2 and LZMA do not include size in file... so we have to fake that;
> # append the size as a 32-bit littleendian number as gzip does.
> -size_append = printf $(shell						\
> -dec_size=0;								\
> -for F in $(real-prereqs); do					\
> -	fsize=$$($(CONFIG_SHELL) $(srctree)/scripts/file-size.sh $$F);	\
> -	dec_size=$$(expr $$dec_size + $$fsize);				\
> -done;									\
> -printf "%08x\n" $$dec_size |						\
> +total_size = $(shell $(PERL) $(srctree)/scripts/file-size.pl $(real-prereqs))
> +size_append = printf $(shell printf "%08x\n" $(total_size) |		\
> 	sed 's/\(..\)/\1 /g' | {					\
> 		read ch0 ch1 ch2 ch3;					\
> 		for ch in $$ch3 $$ch2 $$ch1 $$ch0; do			\
> diff --git a/scripts/file-size.pl b/scripts/file-size.pl
> new file mode 100755
> index 000000000000..170bb6d048fa
> --- /dev/null
> +++ b/scripts/file-size.pl
> @@ -0,0 +1,8 @@
> +#!/usr/bin/perl -w
> +# SPDX-License-Identifier: GPL-2.0
> +my $total = 0;
> +foreach (@ARGV) {
> +    @stat = stat $_ or die "$_: $!";
> +    $total += $stat[7];
> +}
> +print "$total\n";
> diff --git a/scripts/file-size.sh b/scripts/file-size.sh
> deleted file mode 100755
> index 7eb7423416b5..000000000000
> --- a/scripts/file-size.sh
> +++ /dev/null
> @@ -1,4 +0,0 @@
> -#!/bin/sh
> -# SPDX-License-Identifier: GPL-2.0
> -set -- $(ls -dn "$1")
> -printf '%s\n' "$5"
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index 5cdd9bc5c385..c3fa38bd18ab 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -384,8 +384,8 @@ if [ -n "${CONFIG_KALLSYMS}" ]; then
> 	kallsyms_step 2
> 
> 	# step 3
> -	size1=$(${CONFIG_SHELL} "${srctree}/scripts/file-size.sh" ${kallsymso_prev})
> -	size2=$(${CONFIG_SHELL} "${srctree}/scripts/file-size.sh" ${kallsymso})
> +	size1=$(${PERL} "${srctree}/scripts/file-size.pl" ${kallsymso_prev})
> +	size2=$(${PERL} "${srctree}/scripts/file-size.pl" ${kallsymso})
> 
> 	if [ $size1 -ne $size2 ] || [ -n "${KALLSYMS_EXTRA_PASS}" ]; then
> 		kallsyms_step 3
> -- 
> 2.34.0
> 

You can add:

Tested-by: Nick Terrell <terrelln@fb.com>
