Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601034B1B5F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 02:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346937AbiBKBik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 20:38:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346823AbiBKBii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 20:38:38 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6103F5F48;
        Thu, 10 Feb 2022 17:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=/H0mXogSDBRNM8xFMQFWmspwhRVgixmG5IwQdYTlpo8=; b=qw6DtEwAe/CTbTCCLoU/PIOPQ+
        hMtUPRYYNilS0bLobgEg6ctk8ApcMJ55MVy3jslHVH5WNHCneqrhCLvkTfuwiCVuh5nKLg3kiAczw
        LHQBGyH73seLwqFhYu7CbDecAlkYO/v/NG1x8U71qtsEvjoR89IIh9JkYOz476fYZPOa6pm1rMM0L
        54vAdZ8U9dxeM87fxV17mbfCiL9y1MswAQoyosPD63ulL560l3Kv9WQ6+LOWVJL77TQph5yZb0drs
        kiTgSku1OaagqUW2E77cprfTdPMIlo6O+caV2gDBlBQ73n9jkaFO8zL+t919G+1aQtHOYCGU/eqQR
        zIfQ4fvA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nIKtC-005Qvl-7K; Fri, 11 Feb 2022 01:38:25 +0000
Date:   Thu, 10 Feb 2022 17:38:22 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Tong Zhang <ztong0001@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Domenico Andreoli <domenico.andreoli@linux.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: boottime warning from todays linux-next
Message-ID: <YgW+DopXpFNZTj4k@bombadil.infradead.org>
References: <20220210184340.7eba108a@canb.auug.org.au>
 <20220210193302.686fa61a@canb.auug.org.au>
 <20220210214125.2b248790@canb.auug.org.au>
 <20220210222953.6e078d20@canb.auug.org.au>
 <YgWdbYfWgHP2jBmI@bombadil.infradead.org>
 <20220211123336.54eff9de@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220211123336.54eff9de@canb.auug.org.au>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2022 at 12:33:36PM +1100, Stephen Rothwell wrote:
> Hi Luis,
>=20
> On Thu, 10 Feb 2022 15:19:09 -0800 Luis Chamberlain <mcgrof@kernel.org> w=
rote:
> >=20
> > FWIW Linus merged a more newer version of the regression fix, and only
> > until today did we get that version on linux-next.
> >=20
> > > So it seems that the parent of "fs/binfmt_misc" is a permanently empty
> > > directory - the is_empty_dir() check in insert_header() succeeds. =20
> >=20
> > I am not seeing this issue on x86_64 KVM guest with:
> >=20
> > CONFIG_BINFMT_MISC=3Dm
> > or
> > CONFIG_BINFMT_MISC=3Dy
> >=20
> > I think the issue might be that linux-next has Andrew's earlier
> > version of the fix merged, and Linus now has the new version. So
> > linux-next has these extra things below. But I can't understand
> > why this is seen on ppc and not on x86_64.
> >=20
> > diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> > index 241cfc6bc36f..788b9a34d5ab 100644
> > --- a/kernel/sysctl.c
> > +++ b/kernel/sysctl.c
> > @@ -2735,17 +2735,6 @@ static struct ctl_table vm_table[] =3D {
> >  	{ }
> >  };
> > =20
> > -static struct ctl_table fs_table[] =3D {
> > -#if defined(CONFIG_BINFMT_MISC) || defined(CONFIG_BINFMT_MISC_MODULE)
> > -	{
> > -		.procname	=3D "binfmt_misc",
> > -		.mode		=3D 0555,
> > -		.child		=3D sysctl_mount_point,
> > -	},
> > -#endif
> > -	{ }
> > -};
> > -
> >  static struct ctl_table debug_table[] =3D {
> >  #ifdef CONFIG_SYSCTL_EXCEPTION_TRACE
> >  	{
> > @@ -2765,7 +2754,6 @@ static struct ctl_table dev_table[] =3D {
> > =20
> >  DECLARE_SYSCTL_BASE(kernel, kern_table);
> >  DECLARE_SYSCTL_BASE(vm, vm_table);
> > -DECLARE_SYSCTL_BASE(fs, fs_table);
> >  DECLARE_SYSCTL_BASE(debug, debug_table);
> >  DECLARE_SYSCTL_BASE(dev, dev_table);
> > =20
> > @@ -2773,7 +2761,6 @@ int __init sysctl_init_bases(void)
> >  {
> >  	register_sysctl_base(kernel);
> >  	register_sysctl_base(vm);
> > -	register_sysctl_base(fs);
> >  	register_sysctl_base(debug);
> >  	register_sysctl_base(dev);
> > =20
>=20
> Thanks for noticing that.  I have removed the old version from my copy
> of mmotm today.

And ... does that fix your boot?

  Luis
