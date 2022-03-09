Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B144D3023
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 14:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbiCINnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 08:43:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233262AbiCINnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 08:43:06 -0500
Received: from smtp.tom.com (smtprz01.163.net [106.3.154.234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6DB1D17B0F9
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 05:42:07 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by vip-app02.163.net (Postfix) with ESMTP id D3E594400D7
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 21:42:05 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tom.com; s=mail;
        t=1646833325; bh=vRJReDG4bqq0lBu9NwhCT/7EchP5ZD/U7FLT0SyLwVA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KpwJH7dGlAycxRWWHXOuQ9wRqFA1OVxwvx7f6etOnKEIhc7PKy2yKuDHqcluIvNYn
         sfbQRoL4DlRXuzsqLxCWEjzmcaDl1jPSo8gP1BgWV1pI/lcknMtDEZGiS1GG4J8oR8
         rH2pf/gkVXUQFPuztiONWiErD+na0+wmNXOkGGc0=
Received: from localhost (HELO smtp.tom.com) ([127.0.0.1])
          by localhost (TOM SMTP Server) with SMTP ID 1651088751
          for <linux-kernel@vger.kernel.org>;
          Wed, 09 Mar 2022 21:42:05 +0800 (CST)
Received: from antispamvip.163.net (unknown [172.25.16.71])
        by vip-app02.163.net (Postfix) with ESMTP id CF55844010B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 21:42:05 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tom.com; s=mail;
        t=1646833325; bh=vRJReDG4bqq0lBu9NwhCT/7EchP5ZD/U7FLT0SyLwVA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KpwJH7dGlAycxRWWHXOuQ9wRqFA1OVxwvx7f6etOnKEIhc7PKy2yKuDHqcluIvNYn
         sfbQRoL4DlRXuzsqLxCWEjzmcaDl1jPSo8gP1BgWV1pI/lcknMtDEZGiS1GG4J8oR8
         rH2pf/gkVXUQFPuztiONWiErD+na0+wmNXOkGGc0=
Received: from antispamvip.163.net (antispamvip.163.net [127.0.0.1])
        by antispamvip.163.net (Postfix) with ESMTP id 9AA33154155E
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 21:42:05 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at mxtest.tom.com
Received: from antispamvip.163.net ([127.0.0.1])
        by antispamvip.163.net (antispamvip.163.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9X7XD4yHqCpD for <linux-kernel@vger.kernel.org>;
        Wed,  9 Mar 2022 21:42:03 +0800 (CST)
Received: from localhost (unknown [223.104.211.98])
        by antispamvip.163.net (Postfix) with ESMTPA id E129815414D2;
        Wed,  9 Mar 2022 21:42:00 +0800 (CST)
Date:   Wed, 9 Mar 2022 21:41:59 +0800
From:   Mingbao Sun <sunmingbao@tom.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        tyler.sun@dell.com, ping.gan@dell.com, yanxiu.cai@dell.com,
        libin.zhang@dell.com, ao.sun@dell.com
Subject: Re: [PATCH v2 2/2] nvme-tcp: support specifying the
 congestion-control
Message-ID: <20220309212852.00007828@tom.com>
In-Reply-To: <20220309153136.000048e1@tom.com>
References: <20220308151606.2563-1-sunmingbao@tom.com>
        <20220309061442.GA31316@lst.de>
        <20220309153136.000048e1@tom.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Mar 2022 15:32:33 +0800
Mingbao Sun <sunmingbao@tom.com> wrote:

> > > @@ -1447,6 +1449,21 @@ static int nvme_tcp_alloc_queue(struct nvme_ct=
rl *nctrl,
> > >  	if (nctrl->opts->tos >=3D 0)
> > >  		ip_sock_set_tos(queue->sock->sk, nctrl->opts->tos);
> > > =20
> > > +	if (nctrl->opts->mask & NVMF_OPT_TCP_CONGESTION) {
> > > +		strncpy(ca_name, nctrl->opts->tcp_congestion,
> > > +			TCP_CA_NAME_MAX-1);
> > > +		optval =3D KERNEL_SOCKPTR(ca_name);
> > > +		ret =3D sock_common_setsockopt(queue->sock, IPPROTO_TCP,
> > > +					     TCP_CONGESTION, optval,
> > > +					     strlen(ca_name));   =20
> >=20
> > This needs to use kernel_setsockopt.  I also can see absolutely no
> > need for the optval local variable, and I also don't really see why
> > we need ca_name either - if we need to limit the length and terminate
> > it (but why?) that can be done during option parsing. =20

Regards to the replacement of 'sock_common_setsockopt'.

Per the story of the deletion of 'kernel_setsockopt',=20
users of this API should switch to small functions that
implement setting a sockopt directly.

So I tried with 'tcp_set_congestion_control'.
But then I found this symbol is not exported yet.
Then I applied =E2=80=98EXPORT_SYMBOL_GPL(tcp_set_congestion_control);=E2=
=80=99
in my local source, and it works well in the testing.

Then what should I do with this?

