Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01507562FA1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 11:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235633AbiGAJQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 05:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234233AbiGAJQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 05:16:06 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8B1427FA
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 02:16:02 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26166ZWN001686;
        Fri, 1 Jul 2022 11:15:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : subject
 : from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=selector1;
 bh=o0olzbdVKCsh3B8+C9VTiibErlNPcqW0TEQ2eYNJVkM=;
 b=VieBnb28i9MzHjfrsP+Lsvd8JAWeAhfngLv5IpfO4IhOzDEXX0CaK7zQ9Jd424lCTX2e
 eH2wsnGPThjm4drnQjiGuqSpyDwRYEw/2v4sHbGHGPPTvfo6zjuvAB+d7W/jW9EQFv7H
 8VWQPR43M6YxPG+Yliff7SVNWmkY1A3CcWLl1SGQBmWfbD0Tvvee3m6v2Y+M2FuQBsO/
 KCQYMANpclTHs53mOvvb7ImWGDUcGP32cIQyDhb+m29qGjVW1zlq+LqoapJNfUYBPgMo
 isLdjmK0752DBDUwtyDBF9c7uxfHPDddSyGGBkAUuhPtgqKKGm5ImImYdcDoXv8h6eJN QQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3h1cy9nqbv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Jul 2022 11:15:40 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B330D10002A;
        Fri,  1 Jul 2022 11:15:39 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id AA908215141;
        Fri,  1 Jul 2022 11:15:39 +0200 (CEST)
Received: from [192.168.8.15] (10.75.127.48) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Fri, 1 Jul
 2022 11:15:39 +0200
Message-ID: <65069ee9b3b92d92773fa556c45507158eb9c84f.camel@foss.st.com>
Subject: Re: [PATCH] scripts/gdb: fix 'lx-dmesg' on 32 bits arch
From:   Antonio Borneo <antonio.borneo@foss.st.com>
To:     Petr Mladek <pmladek@suse.com>
CC:     Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Date:   Fri, 1 Jul 2022 11:15:38 +0200
In-Reply-To: <Yr2hcGLDNT0k91aS@alley>
References: <20220617143758.137307-1-antonio.borneo@foss.st.com>
         <Yr2hcGLDNT0k91aS@alley>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 
MIME-Version: 1.0
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-01_05,2022-06-28_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-06-30 at 15:13 +0200, Petr Mladek wrote:
> On Fri 2022-06-17 16:37:58, Antonio Borneo wrote:
> > The type atomic_long_t can have size 4 or 8 bytes, depending on
> > CONFIG_64BIT; it's only content, the field 'counter', is either an
> > int or a s64 value.
> >=20
> > Current code incorrectly uses the fixed size utils.read_u64() to
> > read the field 'counter' inside atomic_long_t.
> >=20
> > On 32 bits architectures reading the last element 'tail_id' of the
> > struct prb_desc_ring:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct prb_desc_ring {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0...
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0atomic_long_t tail_id;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0};
> > causes the utils.read_u64() to access outside the boundary of the
> > struct and the gdb command 'lx-dmesg' exits with error:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Python Exception <class=
 'IndexError'>: index out of range
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Error occurred in Pytho=
n: index out of range
> >=20
> > Use the existing utils.read_ulong() to read 'counter' inside the
> > atomic_long_t.
>=20
> I was about to accept this. But then I wondered if we could somehow
> detect the really used atomic_long_t counter type size.
>=20
> I have updated your patch. It works for me on x86_64.
> Could you please check it on 32-bit system?

Tested on 32 bits Cortex-A7 STM32MP157, it works fine.
Yes, agree on your rework; definitively cleaner.

Thanks,
Antonio

> Here is the patch:
>=20
> From bb5b6a7ad6f4339a1102585c691cb725182c0acf Mon Sep 17 00:00:00
> 2001
> From: Antonio Borneo <antonio.borneo@foss.st.com>
> Date: Fri, 17 Jun 2022 16:37:58 +0200
> Subject: [PATCH] scripts/gdb: fix 'lx-dmesg' on 32 bits arch
>=20
> The type atomic_long_t can have size 4 or 8 bytes, depending on
> CONFIG_64BIT; it's only content, the field 'counter', is either an
> int or a s64 value.
>=20
> Current code incorrectly uses the fixed size utils.read_u64() to
> read the field 'counter' inside atomic_long_t.
>=20
> On 32 bits architectures reading the last element 'tail_id' of the
> struct prb_desc_ring:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct prb_desc_ring {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0...
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0atomic_long_t tail_id;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0};
> causes the utils.read_u64() to access outside the boundary of the
> struct and the gdb command 'lx-dmesg' exits with error:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Python Exception <class '=
IndexError'>: index out of range
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Error occurred in Python:=
 index out of range
>=20
> Query the really used atomic_long_t counter type size.
>=20
> Fixes: e60768311af8 ("scripts/gdb: update for lockless printk
> ringbuffer")
> Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
> [pmladek@suse.com: Query the really used atomic_long_t counter type
> size]
> Link:
> https://lore.kernel.org/r/20220617143758.137307-1-antonio.borneo@foss.st.=
com
> ---
> =C2=A0scripts/gdb/linux/dmesg.py |=C2=A0 9 +++------
> =C2=A0scripts/gdb/linux/utils.py | 14 ++++++++++++--
> =C2=A02 files changed, 15 insertions(+), 8 deletions(-)
>=20
> diff --git a/scripts/gdb/linux/dmesg.py b/scripts/gdb/linux/dmesg.py
> index d5983cf3db7d..c771831eb077 100644
> --- a/scripts/gdb/linux/dmesg.py
> +++ b/scripts/gdb/linux/dmesg.py
> @@ -22,7 +22,6 @@ prb_desc_type =3D utils.CachedType("struct prb_desc")
> =C2=A0prb_desc_ring_type =3D utils.CachedType("struct prb_desc_ring")
> =C2=A0prb_data_ring_type =3D utils.CachedType("struct prb_data_ring")
> =C2=A0printk_ringbuffer_type =3D utils.CachedType("struct
> printk_ringbuffer")
> -atomic_long_type =3D utils.CachedType("atomic_long_t")
> =C2=A0
> =C2=A0class LxDmesg(gdb.Command):
> =C2=A0=C2=A0=C2=A0=C2=A0 """Print Linux kernel log buffer."""
> @@ -68,8 +67,6 @@ class LxDmesg(gdb.Command):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 off =3D prb_data_ring_ty=
pe.get_type()['data'].bitpos // 8
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 text_data_addr =3D utils=
.read_ulong(text_data_ring, off)
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 counter_off =3D atomic_long_t=
ype.get_type()['counter'].bitpos
> // 8
> -
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sv_off =3D prb_desc_type=
.get_type()['state_var'].bitpos // 8
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 off =3D prb_desc_type.ge=
t_type()['text_blk_lpos'].bitpos // 8
> @@ -89,9 +86,9 @@ class LxDmesg(gdb.Command):
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # read in tail and head =
descriptor ids
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 off =3D prb_desc_ring_ty=
pe.get_type()['tail_id'].bitpos // 8
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tail_id =3D utils.read_u64(de=
sc_ring, off + counter_off)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tail_id =3D utils.read_atomic=
_long(desc_ring, off)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 off =3D prb_desc_ring_ty=
pe.get_type()['head_id'].bitpos // 8
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 head_id =3D utils.read_u64(de=
sc_ring, off + counter_off)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 head_id =3D utils.read_atomic=
_long(desc_ring, off)
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 did =3D tail_id
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while True:
> @@ -102,7 +99,7 @@ class LxDmesg(gdb.Command):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
desc =3D utils.read_memoryview(inf, desc_addr + desc_off,
> desc_sz).tobytes()
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
# skip non-committed record
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 state=
 =3D 3 & (utils.read_u64(desc, sv_off + counter_off)
> >> desc_flags_shift)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 state=
 =3D 3 & (utils.read_atomic_long(desc, sv_off) >>
> desc_flags_shift)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
if state !=3D desc_committed and state !=3D desc_finalized:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 if did =3D=3D head_id:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break
> diff --git a/scripts/gdb/linux/utils.py b/scripts/gdb/linux/utils.py
> index ff7c1799d588..1553f68716cc 100644
> --- a/scripts/gdb/linux/utils.py
> +++ b/scripts/gdb/linux/utils.py
> @@ -35,13 +35,12 @@ class CachedType:
> =C2=A0
> =C2=A0
> =C2=A0long_type =3D CachedType("long")
> -
> +atomic_long_type =3D CachedType("atomic_long_t")
> =C2=A0
> =C2=A0def get_long_type():
> =C2=A0=C2=A0=C2=A0=C2=A0 global long_type
> =C2=A0=C2=A0=C2=A0=C2=A0 return long_type.get_type()
> =C2=A0
> -
> =C2=A0def offset_of(typeobj, field):
> =C2=A0=C2=A0=C2=A0=C2=A0 element =3D gdb.Value(0).cast(typeobj)
> =C2=A0=C2=A0=C2=A0=C2=A0 return int(str(element[field].address).split()[0=
], 16)
> @@ -129,6 +128,17 @@ def read_ulong(buffer, offset):
> =C2=A0=C2=A0=C2=A0=C2=A0 else:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return read_u32(buffer, =
offset)
> =C2=A0
> +atomic_long_counter_offset =3D
> atomic_long_type.get_type()['counter'].bitpos
> +atomic_long_counter_sizeof =3D
> atomic_long_type.get_type()['counter'].type.sizeof
> +
> +def read_atomic_long(buffer, offset):
> +=C2=A0=C2=A0=C2=A0 global atomic_long_counter_offset
> +=C2=A0=C2=A0=C2=A0 global atomic_long_counter_sizeof
> +
> +=C2=A0=C2=A0=C2=A0 if atomic_long_counter_sizeof =3D=3D 8:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return read_u64(buffer, offse=
t + atomic_long_counter_offset)
> +=C2=A0=C2=A0=C2=A0 else:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return read_u32(buffer, offse=
t + atomic_long_counter_offset)
> =C2=A0
> =C2=A0target_arch =3D None
> =C2=A0
