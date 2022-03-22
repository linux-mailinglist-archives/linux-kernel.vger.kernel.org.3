Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4134E38D2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 07:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236933AbiCVGY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 02:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236996AbiCVGYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 02:24:25 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8970F2611E
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 23:22:56 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220322062253epoutp030a198b661d92b5198bb0b5f9276f9793~en8LsFIq62613326133epoutp030
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 06:22:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220322062253epoutp030a198b661d92b5198bb0b5f9276f9793~en8LsFIq62613326133epoutp030
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1647930173;
        bh=b2Tm1I1oYfFqGoAEd6xIqKXTAY0QWdrTrH32PHTYG0A=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=HGuu0i2m6FRZWtzeBXN71AQ99WyojF4nEkL15dJmVxkWgCKg603qLKNZiaiOerzjJ
         mzZtpKs5NDn8cudfr3uicZTIX71s/lTwJiNx/Yqws/tDVr+7Ao59j93PQ1ZHdJ8F61
         DtCBr/xhPhQs/R8+JIA0YXxeQPOm+vQjvZNBS/JI=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220322062252epcas5p425e362d31c74f8218a3352c3bfd905d3~en8K8YL1Z1320513205epcas5p4J;
        Tue, 22 Mar 2022 06:22:52 +0000 (GMT)
X-AuditID: b6c32a4a-5b7ff700000030eb-b6-62396b3c0e47
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E1.15.12523.C3B69326; Tue, 22 Mar 2022 15:22:52 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH 1/1 module-next] kallsyms: enhance %pS/s/b printing when
 KALLSYSMS is disabled
Reply-To: maninder1.s@samsung.com
Sender: Maninder Singh <maninder1.s@samsung.com>
From:   Maninder Singh <maninder1.s@samsung.com>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
CC:     "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
        Vaneet Narang <v.narang@samsung.com>,
        "swboyd@chromium.org" <swboyd@chromium.org>,
        "ojeda@kernel.org" <ojeda@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "avimalin@gmail.com" <avimalin@gmail.com>,
        "atomlin@redhat.com" <atomlin@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "void@manifault.com" <void@manifault.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220322062219epcms5p1bc1cc758470ebf175aa4eee20b7837ae@epcms5p1>
Date:   Tue, 22 Mar 2022 11:52:19 +0530
X-CMS-MailID: 20220322062219epcms5p1bc1cc758470ebf175aa4eee20b7837ae
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLKsWRmVeSWpSXmKPExsWy7bCmuq5NtmWSwbwrfBZz1q9hs+htms5k
        cWT+GlaLBwevs1uc6c61uLxrDptFw+zvrBaPZ81js7gx4SmjxYcJ/5ksVs5fzmjx//FXVou3
        d6azWOzreMBksXvjIjaL43eeMlkcOjmX0WL78vVsFo2f7zM6CHvMbrjI4rFz1l12j5Z9t9g9
        Fmwq9Wg58pbVY/MKLY9NqzrZPE7M+M3iMe9koMeZ1duYPC50ZXu833eVzaNvyypGj/VbrrJ4
        fN4kF8AfxWWTkpqTWZZapG+XwJUxccsexoK/ahWvms6zNTD+Vu1i5OSQEDCROHP2L3MXIxeH
        kMBuRomL+zeydTFycPAKCEr83SEMUiMskCKxdtceRhBbSEBR4sKMNYwgJcICBhK/tmqAhNkE
        9CRW7drDAmKLCBhK/O9rZwIZySwwn13i9Jv77BC7eCVmtD9lgbClJbYv38oIYYtK3Fz9lh3G
        fn9sPlRcRKL13llmCFtQ4sHP3VBxGYnVm3tZQBZICHQzSqx/txfKmcEo0fNoGlSHucT6JavA
        pvIK+EpcOvMDrJtFQFWi88pCNogaF4mvV16DxZkFtCWWLXzNDPIZs4CmxPpd+hAlshJTT61j
        gijhk+j9/YQJ5pkd82BsVYmWmxtYYR77/PEj1JMeEk+fn2aDBFygxLL3p9gnMMrPQgTvLCSL
        ZyEsXsDIvIpRMrWgODc9tdi0wCgvtVyvODG3uDQvXS85P3cTIzhFanntYHz44IPeIUYmDsZD
        jBIczEoivIs/mCcJ8aYkVlalFuXHF5XmpBYfYpTmYFES5z2dviFRSCA9sSQ1OzW1ILUIJsvE
        wSnVwCSqtsRg9ZtUh381YRIuc2+/E1r19IRVjXiaTsH2E7wOnyaqLuRY5d++yW+CuP57oZff
        Zh7qmiARar9l85ygnU/WhN18cbU53t/92uVUh+S2XfZM69LtviYfMbimfXaHbJDFkhcZl5+Z
        ha24/zB88xLzpX+WHisNr1BqiM5iTKm9zn31Vfoj7+8fU6Wm7KuzKZJ8JMa4WvucgcIV5Z0C
        zxYVRtWer3lYW9te5h3UFVGzg+fJP6HTKZGaby0L6rkUZYue5GqHNFv7n5WNU3+k5r28YlbO
        F6d4lqXJ336rBrMtF01M2ZvepH9z2aFVR+O7W6Su+DLzpJl+6f+9p9LJ+8jS6B8eK15wmZeY
        TuHtV2Ipzkg01GIuKk4EAKbOIBQABAAA
X-CMS-RootMailID: 20220316043552epcas5p29b0723b7c55a3bcc9b4d858660e45933
References: <CGME20220316043552epcas5p29b0723b7c55a3bcc9b4d858660e45933@epcms5p1>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi=C2=A0Sergey,=0D=0A=C2=A0=0D=0A>=C2=A0>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if=C2=
=A0(add_offset)=C2=A0=7B=0D=0A>=C2=A0>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0base=C2=A0=3D=C2=A0mod->core_layout.=
base;=0D=0A>=C2=A0>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0offset=C2=A0=3D=C2=A0value=C2=A0-=C2=A0(unsigned=C2=A0=
long)base;=0D=0A>=C2=A0>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=7D=0D=0A>=C2=A0=0D=
=0A>=C2=A0What=C2=A0if=C2=A0address=C2=A0is=C2=A0in=C2=A0module=C2=A0init?=
=C2=A0Shouldn't=C2=A0this=C2=A0be=C2=A0something=C2=A0like=0D=0A>=C2=A0=0D=
=0A>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if=C2=A0(within_m=
odule_init(value,=C2=A0mod))=0D=0A>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0offset=C2=A0=
=3D=C2=A0value=C2=A0-=C2=A0(unsigned=C2=A0long)mod->init_layout.base;=0D=0A=
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else=0D=0A>=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0offset=C2=A0=3D=C2=A0value=C2=A0-=C2=A0(unsigned=C2=A0lon=
g)mod->core_layout.base;=0D=0A=C2=A0=0D=0AYes,=C2=A0this=C2=A0can=C2=A0be=
=C2=A0done,=C2=A0but=C2=A0I=C2=A0think=C2=A0then=C2=A0we=C2=A0need=C2=A0to=
=C2=A0handle=C2=A0it=C2=A0with=C2=A0some=C2=A0more=C2=A0info.=0D=0A=C2=A0=
=0D=0AIn=C2=A0module=C2=A0allocation=C2=A0first=C2=A0we=C2=A0load=C2=A0core=
_layout=C2=A0and=C2=A0then=C2=A0init_layout=C2=A0w.r.t=C2=A0address=C2=A0ra=
nge=0D=0Aas=C2=A0below=C2=A0(ARM64):=0D=0A=C2=A0=0D=0Affff800000eb0000=C2=
=A0->=C2=A0core_layout=0D=0Affff800000eb4000=C2=A0->=C2=A0init_layout=0D=0A=
=C2=A0=0D=0A=C2=A0=0D=0ASo=C2=A0if=C2=A0we=C2=A0write=C2=A0only=C2=A0offset=
(w.r.t=C2=A0core_layout),=C2=A0then=C2=A0user=C2=A0can=C2=A0get=C2=A0a=C2=
=A0hint=C2=A0if=C2=A0it=C2=A0going=C2=A0beyond=C2=A0normal=C2=A0text=0D=0At=
hen=C2=A0it=C2=A0means=C2=A0it=C2=A0is=C2=A0init=C2=A0text.=0D=0A=C2=A0=0D=
=0ABut=C2=A0if=C2=A0we=C2=A0take=C2=A0offset=C2=A0from=C2=A0init=C2=A0and=
=C2=A0core=C2=A0separately,=C2=A0and=C2=A0we=C2=A0only=C2=A0print=C2=A0the=
=C2=A0offset=C2=A0(not=C2=A0function=C2=A0name),=0D=0Awe=C2=A0need=C2=A0to=
=C2=A0write=C2=A0alongwith=C2=A0offset=C2=A0that=C2=A0it=C2=A0is=C2=A0init=
=C2=A0or=C2=A0core=C2=A0area.=0D=0AOtherwise=C2=A0user=C2=A0will=C2=A0get=
=C2=A0confused=C2=A0which=C2=A0offset=C2=A0it=C2=A0is,=C2=A0whether=C2=A0to=
=C2=A0check=C2=A0init=C2=A0or=C2=A0core=C2=A0text=C2=A0area.=0D=0A=C2=A0=0D=
=0AAnd=C2=A0also=C2=A0while=C2=A0printing=C2=A0modules,=C2=A0kernel=C2=A0al=
so=C2=A0uses=C2=A0core_layout=C2=A0as=C2=A0base=C2=A0address=C2=A0only:=0D=
=0A=C2=A0=0D=0Astatic=C2=A0int=C2=A0m_show(struct=C2=A0seq_file=C2=A0*m,=C2=
=A0void=C2=A0*p)=0D=0A=7B=0D=0A..=0D=0A=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0/*=C2=A0Used=C2=A0by=C2=A0oprofile=C2=A0and=C2=A0other=C2=A0sim=
ilar=C2=A0tools.=C2=A0*/=0D=0A=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0value=C2=A0=3D=C2=A0m->private=C2=A0?=C2=A0NULL=C2=A0:=C2=A0mod->core_la=
yout.base;=0D=0A=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0seq_printf(=
m,=C2=A0=22=C2=A00x%px=22,=C2=A0value);=0D=0A..=0D=0A=7D=0D=0A=C2=A0=0D=0Aa=
nd=C2=A0also=C2=A0normal=C2=A0%ps=C2=A0prints=C2=A0like=C2=A0below:=0D=0A=
=C2=A0=0D=0Aps=C2=A00xffff800000eb4004=0D=0Aload=C2=A0address=C2=A0of=C2=A0=
module=C2=A0is=C2=A00xffff800000eb0000=0D=0Aso=C2=A0normal=C2=A0offset=C2=
=A0is=C2=A04004=C2=A0for=C2=A0init=C2=A0text=C2=A0section.=0D=0A=C2=A0=0D=
=0Aand=C2=A0same=C2=A0thing=C2=A0is=C2=A0printed=C2=A0with=C2=A0current=C2=
=A0patch:=0D=0ApS=C2=A00xffff800000eb0000+0x4004=C2=A0=5Bcrash=5D=0D=0A=C2=
=A0=0D=0AStill=C2=A0if=C2=A0we=C2=A0need=C2=A0to=C2=A0handle=C2=A0separatel=
y,=C2=A0then=C2=A0please=C2=A0suggest=C2=A0only=C2=A0offset=C2=A0is=C2=A0ok=
=C2=A0or=C2=A0we=C2=A0need=C2=A0to=0D=0Aadd=C2=A0string=C2=A0for=C2=A0init=
=C2=A0or=C2=A0core=C2=A0also=C2=A0like=C2=A0below:=0D=0A=C2=A0=0D=0A=C2=A0=
=C2=A0=C2=A0init_text=C2=A0start=C2=A0+=C2=A0offset=0D=0ApS=C2=A00xffff8000=
00eb4000+0x4=C2=A0=5Bcrash=C2=A0init_text=5D=0D=0A=C2=A0=0D=0AAnd=C2=A0also=
=C2=A0then=C2=A0there=C2=A0will=C2=A0be=C2=A0discrepancy=C2=A0for=C2=A0roda=
ta=C2=A0or=C2=A0other=C2=A0sections,=C2=A0which=C2=A0offset=C2=A0to=C2=A0ta=
ke.=0D=0AIf=C2=A0we=C2=A0are=C2=A0taking=C2=A0it=C2=A0from=C2=A0core_layout=
=C2=A0then=C2=A0init=C2=A0section=C2=A0can=C2=A0also=C2=A0be=C2=A0taken=C2=
=A0with=C2=A0same.=0D=0AAs=C2=A0of=C2=A0now=C2=A0it=C2=A0is=C2=A0unique=C2=
=A0offset=C2=A0calculation=C2=A0for=C2=A0all=C2=A0sections.=0D=0A=C2=A0=0D=
=0AThanks,=0D=0AManinder=C2=A0Singh
