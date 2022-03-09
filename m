Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7054D2C8A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 10:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbiCIJxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 04:53:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbiCIJxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 04:53:07 -0500
Received: from smtp.tom.com (smtprz15.163.net [106.3.154.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF12E16EAB4
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 01:52:08 -0800 (PST)
Received: from my-app02.tom.com (my-app02.tom.com [127.0.0.1])
        by freemail02.tom.com (Postfix) with ESMTP id C2D2DB00D50
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 17:52:06 +0800 (CST)
Received: from my-app02.tom.com (HELO smtp.tom.com) ([127.0.0.1])
          by my-app02 (TOM SMTP Server) with SMTP ID -127490289
          for <linux-kernel@vger.kernel.org>;
          Wed, 09 Mar 2022 17:52:06 +0800 (CST)
Received: from antispam1.tom.com (unknown [172.25.16.55])
        by freemail02.tom.com (Postfix) with ESMTP id B00F5B00D47
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 17:52:06 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tom.com; s=201807;
        t=1646819526; bh=dkS+wrRstCkqxCRo76GBz0Ojn6oVfokb7hed3lNt3e0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=S3L3WfeV/FRG+zsY3stPQEDdErJZOXbj7ue4SQqJ24zoRqWk5zn8/owKvq0fFYEvg
         auzIrpzsFqf04jDfSMu+genADr5lYWac72Kxe4SaYGgoUBjyQ3g+atHybe6txpeDj+
         3wnx0Pi4u16WOTfUzcRs9WTQm6TXcU79SfatTDog=
Received: from antispam1.tom.com (antispam1.tom.com [127.0.0.1])
        by antispam1.tom.com (Postfix) with ESMTP id 9AA3ED415BB
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 17:52:06 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at antispam1.tom.com
Received: from antispam1.tom.com ([127.0.0.1])
        by antispam1.tom.com (antispam1.tom.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VnCohanoUZHW for <linux-kernel@vger.kernel.org>;
        Wed,  9 Mar 2022 17:52:04 +0800 (CST)
Received: from localhost (unknown [101.93.196.13])
        by antispam1.tom.com (Postfix) with ESMTPA id 954CCD4155F;
        Wed,  9 Mar 2022 17:52:03 +0800 (CST)
Date:   Wed, 9 Mar 2022 17:52:03 +0800
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
Message-ID: <20220309175203.00006ee2@tom.com>
In-Reply-To: <20220309061541.GB31316@lst.de>
References: <20220309053711.2561-1-sunmingbao@tom.com>
        <20220309061541.GB31316@lst.de>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Mar 2022 07:15:41 +0100
Christoph Hellwig <hch@lst.de> wrote:

> On Wed, Mar 09, 2022 at 01:37:11PM +0800, Mingbao Sun wrote:
> > +		if (port->nport->tcp_congestion) {
> > +			icsk_new =3D inet_csk(newsock->sk);
> > +			if (icsk_new->icsk_ca_ops !=3D icsk->icsk_ca_ops) {
> > +				pr_warn("congestion abnormal: expected %s, actual %s.\n",
> > +					icsk->icsk_ca_ops->name,
> > +					icsk_new->icsk_ca_ops->name);
> > +			}
> > +		} =20
>=20
> What is the point of having this code?

Well, this could happen in certain circumstances.
Take the result from my test as an example:

    - The congestion of the listening socket of the target was set to
      =E2=80=98dctcp=E2=80=99.

    - But the congestion of the socket of the host side was set to
      =E2=80=98cubic=E2=80=99.

    - Then the congestion of the socket of the new connection at the
      target side would automatically be altered to =E2=80=98dctcp-reno=E2=
=80=99.

In case tcp_congestion was explicitly set for the target, it can be
supposed that the user attaches great importance to performance.
So we=E2=80=99d better make the users aware that the system is not working
in the way they expect.=20

Thus the checking and warning was added here.

>=20
> > +	if (nport->tcp_congestion) {
> > +		strncpy(ca_name, nport->tcp_congestion, TCP_CA_NAME_MAX-1);
> > +		optval =3D KERNEL_SOCKPTR(ca_name);
> > +		ret =3D sock_common_setsockopt(port->sock, IPPROTO_TCP,
> > +					     TCP_CONGESTION, optval,
> > +					     strlen(ca_name));
> > +		if (ret) {
> > +			pr_err("failed to set port socket's congestion to %s: %d\n",
> > +			       ca_name, ret);
> > +			goto err_sock;
> > +		}
> > +	} =20
>=20
> Same comment as for the host side.

This will be handled as the host side in the next version.
