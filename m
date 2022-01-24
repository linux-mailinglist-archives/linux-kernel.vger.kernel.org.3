Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABF5949A9D6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1323728AbiAYD3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 22:29:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1320978AbiAYDPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 22:15:21 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00DB2C09F4AD
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 15:50:27 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id nn16-20020a17090b38d000b001b56b2bce31so792845pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 15:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=f3FP9JgWyYmi4QIyCsuY6OM/tB0o/BLBpsR5IrUz/XM=;
        b=P6PZX545ZUXpKkI678L+NQiT/pwRlfuKiPGT6M4cRgojnr/GAKIC95JwtYam64Y+yQ
         OqW5IvveUzxAgJlsKddsX+F99m3idv4bXSmhIeeibBHb3wbMZO1bBBW6rGD3hJnLdK5G
         6oCEvOKWiZrXTy7CHAcS8jpMhRffv8g8ApHCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f3FP9JgWyYmi4QIyCsuY6OM/tB0o/BLBpsR5IrUz/XM=;
        b=CRrwFnp2epxUEdq10bEIylYpDhu5WT1CaQu9t3gU6xmzPNQFyD7cjinxzuSjgNy66E
         MmZUapUOtVALKfeE9eupuG5lzCHt587CU8+keXLAek2Mc2E/94RrQTVnZcIb4krdjKC1
         wzNlwc6RZnLetoqJ/lcIipwh4WJYdp4Hgjt1xxYN93I4eOxMpVDqWoh8nU4OBjj0qh09
         szgKY+YgCrZ2wOP6W8KBetR3yEDHd5/mzX9YLfoo/Ihy+TtK96VC6S/slsSTfxflB2si
         NrVcwa9OZXrpL+rnUTdER+2knn2zodSTpVDGWna7f7Xv35g/wZ6fDldbe6K8Fx6zZhpq
         n+sA==
X-Gm-Message-State: AOAM533BxMnCXUu+rw67qyfsLgfwcqAhFtIlRq6xnhN28LL6/oVVjdBo
        01LgCKSug7cWCtINjbMZsL+e5A==
X-Google-Smtp-Source: ABdhPJw5Ja4Md0C8UDgYSkfPXK/6ETnwO5Bfv3xwpa/LnQqIw58wO84wDnKDnDx9aiADoUhX44I1Pg==
X-Received: by 2002:a17:902:e84b:b0:14b:4aa7:6198 with SMTP id t11-20020a170902e84b00b0014b4aa76198mr7924549plg.10.1643068226511;
        Mon, 24 Jan 2022 15:50:26 -0800 (PST)
Received: from google.com ([2620:15c:202:201:e56e:5d31:a06d:e6ae])
        by smtp.gmail.com with ESMTPSA id g22sm17650183pfj.99.2022.01.24.15.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 15:50:25 -0800 (PST)
Date:   Mon, 24 Jan 2022 15:50:23 -0800
From:   Brian Norris <briannorris@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Peng Fan <peng.fan@nxp.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: regmap: mmio: lack of runtime_pm support for debugfs
Message-ID: <Ye87P19+JOjPEGTY@google.com>
References: <1587620791-5279-1-git-send-email-peng.fan@nxp.com>
 <20200423104000.GD4808@sirena.org.uk>
 <DB6PR0402MB27600084E4A040609EF620A088D30@DB6PR0402MB2760.eurprd04.prod.outlook.com>
 <20200423112244.GH4808@sirena.org.uk>
 <DB6PR0402MB2760FBCA05C1BADB27F0356488D00@DB6PR0402MB2760.eurprd04.prod.outlook.com>
 <20200424103004.GB5850@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424103004.GB5850@sirena.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[[ Retitling from '[PATCH] regmap: mmio: prepare/unprepare clk only when
   read/write' ]]

Hi,

Sorry to bring up an old thread, but it appears there's an unresolved
problem in here that I'm also hitting:

On Fri, Apr 24, 2020 at 11:30:04AM +0100, Mark Brown wrote:
> On Fri, Apr 24, 2020 at 01:27:29AM +0000, Peng Fan wrote:
> 
> > If we not pass clk to regmap, accessing regmap registers will hang system with
> > Debugfs enabled.
> 
> If you're not using a cache then that'll be a problem, however there is
> a flag runtime_pm in the regmap config which when set should cause the
> device to be runtime PM enabled when it's accessed so if you do your
> clock management in runtime PM it should still get enabled.  I *think*
> that interacts OK with being in an atomic context but I can't say I've
> verified.

The only 'runtime_pm' flag I'm finding for regmap is for regmap_irq_chip
-- there isn't anything useful for other kinds of regmaps (like MMIO).

If this seems like an expected/useful feature, I'll look at adding it to
the generic 'struct regmap_config' / drivers/base/regmap/regmap.c.

This could be tricky in theory given the atomic context requirements,
but in reality, I think it would still be OK: this feature would really
be useful _only_ for otherwise-unregulated contexts, like debugfs
access (where we can sleep). For all non-debugfs accesses, we expect to
already be RPM_ACTIVE, because the driver should already be managing
runtime PM.

Brian
