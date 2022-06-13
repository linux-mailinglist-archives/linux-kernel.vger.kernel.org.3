Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCCC5549996
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 19:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237910AbiFMROY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 13:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239071AbiFMRNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 13:13:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D68F10657E
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 05:21:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E7A061132
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 12:21:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4E6CC34114;
        Mon, 13 Jun 2022 12:21:06 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="OudDLBOf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1655122865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eCguPfhBjRDX4UmTJq9ti6SGKm9MJcaBx3aO1wE0zJI=;
        b=OudDLBOf2DDzDoHX8qr0r/1jVrOBp7yu9hoOynhMQTo2tkxBCXZBNgDqkwj4i0X3sh+9P3
        8/0BdxEpddr3D+A5nFlzj2vLe9aPL3Et+qUsFC2JeXJOLx8HV/ByqrZfP72zi8296ynVhj
        36OeAc2QA26zTXoW8E30cs/6HEdJMN0=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 748efec9 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 13 Jun 2022 12:21:04 +0000 (UTC)
Date:   Mon, 13 Jun 2022 14:20:59 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     "R, Monish Kumar" <monish.kumar.r@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        "alan.adamson@oracle.com" <alan.adamson@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Yi Zhang <yi.zhang@redhat.com>,
        Keith Busch <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
        "Rao, Abhijeet" <abhijeet.rao@intel.com>
Subject: Re: 2 second nvme initialization delay regression in 5.18 [Was: Re:
 [bug report]nvme0: Admin Cmd(0x6), I/O Error (sct 0x0 / sc 0x2) MORE DNR
 observed during blktests]
Message-ID: <Yqcrq2ewmqhflAYw@zx2c4.com>
References: <CAHj4cs_iC+FE8ZAXXZPeia1V3ZX7zRbeASdOP_8c7DLiFozNfA@mail.gmail.com>
 <Ykyf5Zuz1W8yHhNY@zx2c4.com>
 <CAHmME9pwz4q0m-pSUy7ReWu4nNzxySNcYZrqyDZiTuGxHN=1NQ@mail.gmail.com>
 <CAHmME9o-orF52HzkT80054e3Op5fLOcTHb-KHpvvU7H3FpAJ7A@mail.gmail.com>
 <SA2PR11MB5115DCE45778910C96813CA1C3A79@SA2PR11MB5115.namprd11.prod.outlook.com>
 <YqG/pybFg0P5yQ9a@zx2c4.com>
 <20220610061449.GD24331@lst.de>
 <YqMMo2Dv9SZRtR7B@zx2c4.com>
 <SA2PR11MB5115C9D7AE1DF332B29625B0C3AB9@SA2PR11MB5115.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SA2PR11MB5115C9D7AE1DF332B29625B0C3AB9@SA2PR11MB5115.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 06:36:44AM +0000, R, Monish Kumar wrote:
> mn        : Samsung Portable SSD X5
> fr        : 1P3QEXE7

Isn't the latest firmware for the QEXE7 line 2B2QEXE7?

Jason
