Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 809934D4553
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 12:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240753AbiCJLHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 06:07:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233499AbiCJLHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 06:07:43 -0500
Received: from smtp.tom.com (smtprz02.163.net [106.3.154.235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 50BFCB0A6F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 03:06:42 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by vip-app02.163.net (Postfix) with ESMTP id BFC2944013E
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 19:06:40 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tom.com; s=mail;
        t=1646910400; bh=vdMbham87nueBroCLlJ2VhqRb0D2htyLRWWtWLeBjLA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qMuGe/APj0qVsF9h15CXSkaIZPVZT4CLq3hkdgvNwptQuS1P218b8rpV+JC9ilDW+
         k4uYgN9kRUv4rMuTilAajt2YzjomnZh7S1mkVRbUQBHZJD+FPsiU7ByCqEAhE92jl+
         jRXW3SQJyuj9CLtl71H6fAS9SXfVnWDGn56MJ8Ds=
Received: from localhost (HELO smtp.tom.com) ([127.0.0.1])
          by localhost (TOM SMTP Server) with SMTP ID 1205552109
          for <linux-kernel@vger.kernel.org>;
          Thu, 10 Mar 2022 19:06:40 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at mxtest.tom.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tom.com; s=mail;
        t=1646910400; bh=vdMbham87nueBroCLlJ2VhqRb0D2htyLRWWtWLeBjLA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qMuGe/APj0qVsF9h15CXSkaIZPVZT4CLq3hkdgvNwptQuS1P218b8rpV+JC9ilDW+
         k4uYgN9kRUv4rMuTilAajt2YzjomnZh7S1mkVRbUQBHZJD+FPsiU7ByCqEAhE92jl+
         jRXW3SQJyuj9CLtl71H6fAS9SXfVnWDGn56MJ8Ds=
Received: from localhost (unknown [101.93.196.13])
        by antispamvip.163.net (Postfix) with ESMTPA id 3E67B154153A;
        Thu, 10 Mar 2022 19:06:37 +0800 (CST)
Date:   Thu, 10 Mar 2022 19:06:36 +0800
From:   Mingbao Sun <sunmingbao@tom.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        tyler.sun@dell.com, ping.gan@dell.com, yanxiu.cai@dell.com,
        libin.zhang@dell.com, ao.sun@dell.com
Subject: Re: [PATCH v2 1/2] nvmet-tcp: support specifying the
 congestion-control
Message-ID: <20220310190636.00001695@tom.com>
In-Reply-To: <20220310083811.GA26953@lst.de>
References: <20220309053711.2561-1-sunmingbao@tom.com>
        <20220309061541.GB31316@lst.de>
        <20220309175203.00006ee2@tom.com>
        <20220310083811.GA26953@lst.de>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Mar 2022 09:38:11 +0100
Christoph Hellwig <hch@lst.de> wrote:

> On Wed, Mar 09, 2022 at 05:52:03PM +0800, Mingbao Sun wrote:
> > On Wed, 9 Mar 2022 07:15:41 +0100
> > Christoph Hellwig <hch@lst.de> wrote:
> >  =20
> > > On Wed, Mar 09, 2022 at 01:37:11PM +0800, Mingbao Sun wrote: =20
> > > > +		if (port->nport->tcp_congestion) {
> > > > +			icsk_new =3D inet_csk(newsock->sk);
> > > > +			if (icsk_new->icsk_ca_ops !=3D icsk->icsk_ca_ops) {
> > > > +				pr_warn("congestion abnormal: expected %s, actual %s.\n",
> > > > +					icsk->icsk_ca_ops->name,
> > > > +					icsk_new->icsk_ca_ops->name);
> > > > +			}
> > > > +		}   =20
> > >=20
> > > What is the point of having this code? =20
> >=20
> > Well, this could happen in certain circumstances.
> > Take the result from my test as an example:
> >=20
> >     - The congestion of the listening socket of the target was set to
> >       =E2=80=98dctcp=E2=80=99.
> >=20
> >     - But the congestion of the socket of the host side was set to
> >       =E2=80=98cubic=E2=80=99.
> >=20
> >     - Then the congestion of the socket of the new connection at the
> >       target side would automatically be altered to =E2=80=98dctcp-reno=
=E2=80=99.
> >=20
> > In case tcp_congestion was explicitly set for the target, it can be
> > supposed that the user attaches great importance to performance.
> > So we=E2=80=99d better make the users aware that the system is not work=
ing
> > in the way they expect.  =20
>=20
> A warning message really seems very severe for a condition like this.
> Maybe the better interface is a way to figure out which congestion
> control algorithm is in use by reading a sysfs file.

Well, a target could have a great number of TCP sockets.

I feel it=E2=80=99s not proper to create a sysfs entry for each socket.
And for those sockets that do not have the exception of
congestion-control, it=E2=80=99s merely a waste of resources.

Also, since these sockets generate and die dynamically, the info
exported via fs may even do not have the opportunity to be seen by
the user.

Anyway, if you insist that the checking and warning here is not proper,
I can remove it.=20
