Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDECD505DE7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 20:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347347AbiDRSOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 14:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiDRSOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 14:14:03 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A56E25289
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 11:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650305484; x=1681841484;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4FtieXzTSKHMKDV88WzqEoh+kHjDQfwJ0Yydw1piwHk=;
  b=X1eskVLyDY6NiXcM38yERkGHT9mxXtBX8sLPWxq4WcePUr+AibLfQCJq
   jUr8nIYpBkp0FgKDVzIBO4g0IJ1TuRuQ+Xq6UttuiWoh5H1611FixgWuU
   0lxLgZIN2Cr5FXBYbVSNAsT5VMkAHPP/smN99K9RbGxH3aZalw/l7sjaf
   cHRngC86Os4SVahRQEtuZhEvrXJ6P6yZXbgGk4a6O2G7T9uLRtcMzUOAU
   JZ9BhcbK9Jt4/f0pbT9AQymIKAzNLZrYDYSCnIN+7VazymVmfOdhKwrgV
   N4903fA6qqeGCIGBGrT0q2WCuaKGCbeiQ17/TlIWo1Wj7h82AQLxpErTf
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="350030822"
X-IronPort-AV: E=Sophos;i="5.90,270,1643702400"; 
   d="scan'208";a="350030822"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 11:11:23 -0700
X-IronPort-AV: E=Sophos;i="5.90,270,1643702400"; 
   d="scan'208";a="646948978"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 11:11:22 -0700
Date:   Mon, 18 Apr 2022 11:14:56 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        jean-philippe <jean-philippe@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        iommu <iommu@lists.linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Message-ID: <20220418111456.2f1a1285@jacob-builder>
In-Reply-To: <tencent_8EC09A26D25C1A263AE207952230B789D409@qq.com>
References: <tencent_9920B633D50E9B80D3A41A723BCE06972309@qq.com>
        <f439dde5-0eaa-52e4-9cf7-2ed1f62ea07f@intel.com>
        <tencent_F73C11A7DBAC6AF24D3369DF0DCA1D7E8308@qq.com>
        <a139dbad-2f42-913b-677c-ef35f1eebfed@intel.com>
        <tencent_B683AC1146DB6A6ABB4D73697C0D6A1D7608@qq.com>
        <YlWBkyGeb2ZOGLKl@fyu1.sc.intel.com>
        <tencent_A9458C6CEBAADD361DA765356477B00E920A@qq.com>
        <tencent_8B6D7835F62688B4CD069C0EFC41B308B407@qq.com>
        <YllADL6uMoLllzQo@fyu1.sc.intel.com>
        <99bcb9f5-4776-9c40-a776-cdecfa9e1010@foxmail.com>
        <YllN/OmjpYdT1tO9@otcwcpicx3.sc.intel.com>
        <tencent_CD35B6A6FBB48186B38EF641F088BAED1407@qq.com>
        <20220415140002.7c12b0d2@jacob-builder>
        <tencent_8EC09A26D25C1A263AE207952230B789D409@qq.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi zhangfei.gao@foxmail.com,

On Sat, 16 Apr 2022 09:43:07 +0800, "zhangfei.gao@foxmail.com"
<zhangfei.gao@foxmail.com> wrote:

> On 2022/4/16 =E4=B8=8A=E5=8D=885:00, Jacob Pan wrote:
> > Hi zhangfei.gao@foxmail.com,
> >
> > On Fri, 15 Apr 2022 19:52:03 +0800, "zhangfei.gao@foxmail.com"
> > <zhangfei.gao@foxmail.com> wrote:
> > =20
> >>>>> A PASID might be still used even though it is freed on mm exit.
> >>>>>
> >>>>> process A:
> >>>>> 	sva_bind();
> >>>>> 	ioasid_alloc() =3D N; // Get PASID N for the mm
> >>>>> 	fork(): // spawn process B
> >>>>> 	exit();
> >>>>> 	ioasid_free(N);
> >>>>>
> >>>>> process B:
> >>>>> 	device uses PASID N -> failure
> >>>>> 	sva_unbind();
> >>>>>
> >>>>> Dave Hansen suggests to take a refcount on the mm whenever binding
> >>>>> the PASID to a device and drop the refcount on unbinding. The mm
> >>>>> won't be dropped if the PASID is still bound to it.
> >>>>>
> >>>>> Fixes: 701fac40384f ("iommu/sva: Assign a PASID to mm on PASID
> >>>>> allocation and free it on mm exit")
> >>>>> =20
> > Is process A's mm intended to be used by process B? Or you really should
> > use PASID N on process B's mm? If the latter, it may work for a while
> > until B changes mapping.
> >
> > It seems you are just extending the life of a defunct mm? =20
>=20
>  From nginx code, the master process init resources, then fork daemon=20
> process to take over,
> then master process exit by itself.
>=20
> src/core/nginx.c
> main
> ngx_ssl_init(log);=C2=A0=C2=A0=C2=A0 -> openssl engine -> bind_fn -> sva_=
bind()
> ngx_daemon(cycle->log)
>=20
> src/os/unix/ngx_daemon.c
> ngx_daemon(ngx_log_t *log)
> {
>  =C2=A0=C2=A0=C2=A0=C2=A0 int=C2=A0 fd;
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0 switch (fork()) {
>  =C2=A0=C2=A0=C2=A0=C2=A0 case -1:
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ngx_log_error(NGX_LOG_E=
MERG, log, ngx_errno, "fork() failed");
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NGX_ERROR;
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0 case 0:
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // the fork daemon process
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>=20
Does this child process call sva_bind() again to get another PASID? Or it
will keep using the parent's PASID for DMA?

>  =C2=A0=C2=A0=C2=A0=C2=A0 default:
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // master process directly exit, an=
d release mm as well as ioasid
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit(0);
>  =C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // only daemon process
>=20
> Thanks
>=20
> >
> > Thanks,
> >
> > Jacob =20
>=20


Thanks,

Jacob
