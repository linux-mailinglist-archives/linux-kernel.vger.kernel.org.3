Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E13C4D28A5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 07:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiCIGDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 01:03:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiCIGDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 01:03:37 -0500
Received: from smtp.tom.com (smtprz15.163.net [106.3.154.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA2DC0B
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 22:02:36 -0800 (PST)
Received: from my-app01.tom.com (my-app01.tom.com [127.0.0.1])
        by freemail01.tom.com (Postfix) with ESMTP id E70B31E8C29C
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 14:02:34 +0800 (CST)
Received: from my-app01.tom.com (HELO smtp.tom.com) ([127.0.0.1])
          by my-app01 (TOM SMTP Server) with SMTP ID 622032670
          for <linux-kernel@vger.kernel.org>;
          Wed, 09 Mar 2022 14:02:34 +0800 (CST)
Received: from antispam3.tom.com (unknown [172.25.16.54])
        by freemail01.tom.com (Postfix) with ESMTP id D3F461E8C026
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 14:02:34 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tom.com; s=201807;
        t=1646805754; bh=IGp1gaFSRkr0bRuTshmneZHpJzfNKx2kLBUG7hKanOA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OB60kjhuLaWLKZ2x1M+Vm6VJ1sA+EbduMqmZjFuyZZ1scokXzX4pS8olL3s2/iIP1
         DdHREnJMDeWSxyXCjNHMzoA+mzOhAmNlIBwM9jyFkzXOqOtmRdv41b1OviXXcH3fbr
         VrmfoXkJPXEfDIugvTYFSJgsWPekjMancj/JTTMY=
Received: from antispam3.tom.com (antispam3.tom.com [127.0.0.1])
        by antispam3.tom.com (Postfix) with ESMTP id D3BAA9C1C25
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 14:02:34 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at antispam3.tom.com
Received: from antispam3.tom.com ([127.0.0.1])
        by antispam3.tom.com (antispam3.tom.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id XX_7xSpsTlth for <linux-kernel@vger.kernel.org>;
        Wed,  9 Mar 2022 14:02:34 +0800 (CST)
Received: from localhost (unknown [101.93.196.13])
        by antispam3.tom.com (Postfix) with ESMTPA id 80CC59C078A;
        Wed,  9 Mar 2022 14:02:31 +0800 (CST)
Date:   Wed, 9 Mar 2022 14:02:30 +0800
From:   Mingbao Sun <sunmingbao@tom.com>
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     tyler.sun@dell.com, ping.gan@dell.com, yanxiu.cai@dell.com,
        libin.zhang@dell.com, ao.sun@dell.com
Subject: Re: [PATCH v2 1/2] nvmet-tcp: support specifying the
 congestion-control
Message-ID: <20220309140230.00000e5e@tom.com>
In-Reply-To: <20220309053711.2561-1-sunmingbao@tom.com>
References: <20220309053711.2561-1-sunmingbao@tom.com>
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

The patch v1 for target side also inserted some calls to
networking APIs in the generic part (configfs.c) for validating
the congestion-control specified by the user.

Per the comments from Christoph Hellwig on=20
=E2=80=98[PATCH 2/2] nvme-tcp: support specifying the congestion-control=E2=
=80=99
(the patch for the host side), here delete these calls.

Since the tcp_congestion specified by the user could also get
checked later within sock_common_setsockopt in nvmet_tcp_add_port.
So this deletion brings little downside.
