Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32C564D4D3F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 16:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240664AbiCJPPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 10:15:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344397AbiCJPOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 10:14:33 -0500
Received: from smtp.tom.com (smtprz02.163.net [106.3.154.235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E267649F0C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 07:13:30 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by vip-app02.163.net (Postfix) with ESMTP id 3E9E14400AE
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 23:13:29 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tom.com; s=mail;
        t=1646925209; bh=doCJDH1zWUod9q6whn+dh+jk6wzxYxXQrH/FUdQRXcc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2TK1xzC8QEtsTXUKvvNDWk8LAPMiL+SZH9ZCrS2kiSHVJmWA4THmOif7PTv5piFuM
         8N9ooCVqw1JafDRAeWEEe19Mo7FuYroF7rJUxqh7lJ3d1gU2D+hcRM35WqM+AsabZ6
         nadKeQAxpMpaDvsXdzbyyGi5K8j+82g8xf9Fr92c=
Received: from localhost (HELO smtp.tom.com) ([127.0.0.1])
          by localhost (TOM SMTP Server) with SMTP ID 846290663
          for <linux-kernel@vger.kernel.org>;
          Thu, 10 Mar 2022 23:13:29 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at mxtest.tom.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tom.com; s=mail;
        t=1646925209; bh=doCJDH1zWUod9q6whn+dh+jk6wzxYxXQrH/FUdQRXcc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2TK1xzC8QEtsTXUKvvNDWk8LAPMiL+SZH9ZCrS2kiSHVJmWA4THmOif7PTv5piFuM
         8N9ooCVqw1JafDRAeWEEe19Mo7FuYroF7rJUxqh7lJ3d1gU2D+hcRM35WqM+AsabZ6
         nadKeQAxpMpaDvsXdzbyyGi5K8j+82g8xf9Fr92c=
Received: from localhost (unknown [101.93.196.13])
        by antispamvip.163.net (Postfix) with ESMTPA id 9669215414BB;
        Thu, 10 Mar 2022 23:13:26 +0800 (CST)
Date:   Thu, 10 Mar 2022 23:13:25 +0800
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
Message-ID: <20220310231325.00000232@tom.com>
In-Reply-To: <20220310142034.GA1038@lst.de>
References: <20220309053711.2561-1-sunmingbao@tom.com>
        <20220309061541.GB31316@lst.de>
        <20220309175203.00006ee2@tom.com>
        <20220310083811.GA26953@lst.de>
        <20220310190636.00001695@tom.com>
        <20220310142034.GA1038@lst.de>
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

On Thu, 10 Mar 2022 15:20:34 +0100
Christoph Hellwig <hch@lst.de> wrote:

> On Thu, Mar 10, 2022 at 07:06:36PM +0800, Mingbao Sun wrote:
> > I feel it=E2=80=99s not proper to create a sysfs entry for each socket.
> > And for those sockets that do not have the exception of
> > congestion-control, it=E2=80=99s merely a waste of resources.
> >=20
> > Also, since these sockets generate and die dynamically, the info
> > exported via fs may even do not have the opportunity to be seen by
> > the user.
> >=20
> > Anyway, if you insist that the checking and warning here is not proper,
> > I can remove it.  =20
>=20
> Something that can happen during normal operation is per definition no
> something that should be warned about.

Got.
Will remove this checking and warning in the next version.
