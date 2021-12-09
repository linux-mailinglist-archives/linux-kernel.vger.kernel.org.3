Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6833746E712
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 11:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236200AbhLIKzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 05:55:09 -0500
Received: from mail.avm.de ([212.42.244.120]:46782 "EHLO mail.avm.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232844AbhLIKzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 05:55:08 -0500
Received: from mail-notes.avm.de (mail-notes.avm.de [172.16.0.1])
        by mail.avm.de (Postfix) with ESMTP;
        Thu,  9 Dec 2021 11:51:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
        t=1639047093; bh=PfmdlE0WCq1Daz4yKMlJ7WU8epSeXu1J1q9c/d9oOcc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CaVf2i92sF771Cv77R1b8W5Edsd3kZ0u94AL67txHjHmfVdqU+T5uYGeUmeXIkvJM
         OvW9t/eAznkIykqGmXfC5sG0BgxLDAOviqt+q3PZeDVN3JqZ7GS7dQI1Dh3Wys6uwC
         rUvCMxTdA6QWpMf2I40sNaETv4mzoip12e1BjHKQ=
Received: from tkh-linux.avm.de ([172.17.33.53])
          by mail-notes.avm.de (HCL Domino Release 11.0.1FP4)
          with ESMTP id 2021120911513282-7104 ;
          Thu, 9 Dec 2021 11:51:32 +0100 
From:   =?UTF-8?q?Thomas=20K=C3=BChnel?= <thomas.kuehnel@avm.de>
To:     kernel test robot <lkp@intel.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     kbuild-all@lists.01.org, ntfs3@lists.linux.dev,
        linux-kernel@vger.kernel.org, Nicolas Schier <n.schier@avm.de>,
        =?UTF-8?Q?Thomas_K=c3=bchnel?= <thomas.kuehnel@avm.de>
Subject: Re: [PATCH 1/3] fs/ntfs3: fix endian conversion in ni_fname_name
Date:   Thu, 9 Dec 2021 11:50:40 +0100
Message-Id: <d82ff770-a34c-5ae2-024c-07c4c06c868f@avm.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <202112072356.fmLjngs7-lkp@intel.com>
References: <20211207102454.576906-2-thomas.kuehnel@avm.de> <202112072356.fmLjngs7-lkp@intel.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ANIS1/AVM(Release 11.0.1FP4|October 01, 2021) at
 09.12.2021 11:51:32,
        Serialize by Router on ANIS1/AVM(Release 11.0.1FP4|October 01, 2021) at
 09.12.2021 11:51:32,
        Serialize complete at 09.12.2021 11:51:32
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-purgate-ID: 149429::1639047092-0000060F-3B17705D/0/0
X-purgate-type: clean
X-purgate-size: 3962
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=0D
=0D
On 07.12.21 17:00, kernel test robot wrote:=0D
> Hi "Thomas,=0D
> =0D
> Thank you for the patch! Perhaps something to improve:=0D
> =0D
> [auto build test WARNING on 0fcfb00b28c0b7884635dacf38e46d60bf3d4eb1]=0D
> =0D
> url:    https://github.com/0day-ci/linux/commits/Thomas-K-hnel/fs-ntfs3-F=
ixes-for-big-endian-systems/20211207-184206=0D
> base:   0fcfb00b28c0b7884635dacf38e46d60bf3d4eb1=0D
> config: arm64-randconfig-s031-20211207 (https://download.01.org/0day-ci/a=
rchive/20211207/202112072356.fmLjngs7-lkp@intel.com/config)=0D
> compiler: aarch64-linux-gcc (GCC) 11.2.0=0D
> reproduce:=0D
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sb=
in/make.cross -O ~/bin/make.cross=0D
>          chmod +x ~/bin/make.cross=0D
>          # apt-get install sparse=0D
>          # sparse version: v0.6.4-dirty=0D
>          # https://github.com/0day-ci/linux/commit/d2fb837ced1828c5a57fea=
c3690d3cc8a36b2fdc=0D
>          git remote add linux-review https://github.com/0day-ci/linux=0D
>          git fetch --no-tags linux-review Thomas-K-hnel/fs-ntfs3-Fixes-fo=
r-big-endian-systems/20211207-184206=0D
>          git checkout d2fb837ced1828c5a57feac3690d3cc8a36b2fdc=0D
>          # save the config file to linux build tree=0D
>          mkdir build_dir=0D
>          COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-11.2.0 make.cr=
oss C=3D1 CF=3D'-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=3Dbuild_dir ARCH=
=3Darm64 SHELL=3D/bin/bash fs/ntfs3/=0D
> =0D
> If you fix the issue, kindly add following tag as appropriate=0D
> Reported-by: kernel test robot <lkp@intel.com>=0D
> =0D
> =0D
> sparse warnings: (new ones prefixed by >>)=0D
>>> fs/ntfs3/frecord.c:1615:28: sparse: sparse: incorrect type in argument =
1 (different base types) @@     expected restricted __le16 const [usertype]=
 *s1 @@     got unsigned short const * @@=0D
>     fs/ntfs3/frecord.c:1615:28: sparse:     expected restricted __le16 co=
nst [usertype] *s1=0D
>     fs/ntfs3/frecord.c:1615:28: sparse:     got unsigned short const *=0D
> =0D
> vim +1615 fs/ntfs3/frecord.c=0D
> =0D
>    1578	=0D
>    1579	/* ni_fname_name=0D
>    1580	 *=0D
>    1581	 * Return: File name attribute by its value.=0D
>    1582	 */=0D
>    1583	struct ATTR_FILE_NAME *ni_fname_name(struct ntfs_inode *ni,=0D
>    1584					     const struct cpu_str *uni,=0D
=0D
=0D
Changing the type of uni to struct le_str * should fix the warning.=0D
I'll change this in the next version of this patch.=0D
=0D
>    1585					     const struct MFT_REF *home_dir,=0D
>    1586					     struct mft_inode **mi,=0D
>    1587					     struct ATTR_LIST_ENTRY **le)=0D
>    1588	{=0D
>    1589		struct ATTRIB *attr =3D NULL;=0D
>    1590		struct ATTR_FILE_NAME *fname;=0D
>    1591		struct le_str *fns;=0D
>    1592	=0D
>    1593		*le =3D NULL;=0D
>    1594	=0D
>    1595		/* Enumerate all names. */=0D
>    1596	next:=0D
>    1597		attr =3D ni_find_attr(ni, attr, le, ATTR_NAME, NULL, 0, NULL, mi=
);=0D
>    1598		if (!attr)=0D
>    1599			return NULL;=0D
>    1600	=0D
>    1601		fname =3D resident_data_ex(attr, SIZEOF_ATTRIBUTE_FILENAME);=0D
>    1602		if (!fname)=0D
>    1603			goto next;=0D
>    1604	=0D
>    1605		if (home_dir && memcmp(home_dir, &fname->home, sizeof(*home_dir)=
))=0D
>    1606			goto next;=0D
>    1607	=0D
>    1608		if (!uni)=0D
>    1609			goto next;=0D
>    1610	=0D
>    1611		if (uni->len !=3D fname->name_len)=0D
>    1612			goto next;=0D
>    1613	=0D
>    1614		fns =3D (struct le_str *)&fname->name_len;=0D
>> 1615		if (ntfs_cmp_names(uni->name, uni->len, fns->name, fns->len, NULL,=
=0D
>    1616				       false))=0D
>    1617			goto next;=0D
>    1618	=0D
>    1619		return fname;=0D
>    1620	}=0D
>    1621	=0D
> =0D
> ---=0D
> 0-DAY CI Kernel Test Service, Intel Corporation=0D
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org=0D
> =0D
