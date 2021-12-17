Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5DFA478860
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 11:07:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234674AbhLQKHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 05:07:19 -0500
Received: from mx1.tq-group.com ([93.104.207.81]:61301 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231968AbhLQKHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 05:07:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1639735638; x=1671271638;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X9d6MhpG2tpfvobV17CFhDsN/rl8WE4mQEBS0rQkbno=;
  b=PXyDpOgYvILft8FEqgGGmx7BD4mIxis5hlproCzC1FjoYBVOiF1U/KKP
   UrZH20bBAVJKdfmNmwT/1L60Yr9sAnl02Newj+VfUHlNePmJqDu6ZlpeU
   7EIEkbl/sXHQkvOMCeuae+zlOGN66ibrQg8BtaujYNFGFnNczCPw0TO4D
   0VL9yql3dEn1Xw7x4FYvOxvQNES87tGm/O5va1Zp59/yANjCrIX3HGGYl
   xdzHR72oFqH0GWH+BT2aNojgg+cOTRngGlPxi3I/2IJMXF4hUtiDXjduz
   hohsSL/vxZXHsd7ATm+J7IvZbv756Kc5zQJHsfoSiVKE+BeZELmtqv5YV
   w==;
X-IronPort-AV: E=Sophos;i="5.88,213,1635199200"; 
   d="scan'208";a="21118277"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 17 Dec 2021 11:07:17 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 17 Dec 2021 11:07:17 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 17 Dec 2021 11:07:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1639735637; x=1671271637;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X9d6MhpG2tpfvobV17CFhDsN/rl8WE4mQEBS0rQkbno=;
  b=QiC9TfkWZAim4vugM71HNiLynMVtBpWbgxrgbSZK4ptWOcIT+xzBUkC1
   Bl52lrkFfwYjbEJOfbeMYL7qmKSfHE7pQ6bS82MMcHy9hZlzu4chBfB7Y
   qpeZJo2U1iOrA3yFZQ00bTcuRzMYnVNebTvtV/aMFL4+DW2g4fepjLcDL
   S5p70ywiKfzi7cRNPrtiZD4egtv7XssUTjKW5tMdaea/+8A5OkKnuLXeM
   c4pMbAWEuB0Hu4GylJQLhsKb+G34I7rvX08YLTcDn+qlhBeoa8458udAM
   7Qpq8p6JNKYzSBsxM/BBxXW8hV6HImC7kaozqLN0i1/YqGChKLehhQj5y
   g==;
X-IronPort-AV: E=Sophos;i="5.88,213,1635199200"; 
   d="scan'208";a="21118276"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 17 Dec 2021 11:07:17 +0100
Received: from schifferm-ubuntu (SCHIFFERM-M2.tq-net.de [10.121.201.15])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 5C9C0280065;
        Fri, 17 Dec 2021 11:07:17 +0100 (CET)
Message-ID: <fd52c394b8c5f727b04166ca29e893baa940e2a5.camel@ew.tq-group.com>
Subject: Re: [PATCH v2 1/2] mtd: spi-nor: micron-st: make
 mt25ql02g/mt25qu02g match more specific, add 4B opcodes
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Fri, 17 Dec 2021 11:07:15 +0100
In-Reply-To: <20211216185254.pt3quvb4wkzou6wh@ti.com>
References: <a69181ccf225424a8bd11349aad0df7face9715e.1633607826.git.matthias.schiffer@ew.tq-group.com>
         <20211216185254.pt3quvb4wkzou6wh@ti.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-12-17 at 00:22 +0530, Pratyush Yadav wrote:
> Hi Matthias,
> 
> On 07/10/21 02:08PM, Matthias Schiffer wrote:
> > Change the mt25ql02g/mt25qu02g entries to include
> > SPI_NOR_4B_OPCODES. In
> > addition, the SPI_NOR_DUAL_READ flag is added to mt25ql02g; this
> > seems
> > to have been an accidental omission, as mt25ql02g and mt25qu02g
> > should
> > support the same features.
> 
> The way flags are specified are changed a bit. See [0]. Please re-
> roll 
> your patch to use the new flag types. If this flash supports SFDP
> you 
> should ideally just need to set the sfdp flag to true and the core 
> should take care of the rest. Test reports with the new changes would
> be 
> much appreciated :-)

Will do. Is there an easy way to check which features the kernel
detected from the SFDP with the new code?


> 
> > In addition, the entries are made more specific by matching on the
> > mt25q
> > extended ID, like it is already done for the smaller n25q
> > derivatives.
> > It is unclear whether n25q derivatives with 2Gbit exist that do not
> > support 4B opcodes (like it is the case for sizes up to 512MBit),
> > so we
> > do not have a match for such variants anymore (as we wouldn't even
> > know
> > how to name such hypothetical models).
> 
> Sounds good to me.
> 
> > The changes were tested with a mt25qu01g, which should support the
> > same
> > features as the mt25ql02g/mt25qu02g.
> > 
> > Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com
> > >
> > ---
> > 
> 
> [0] 
> https://patchwork.ozlabs.org/project/linux-mtd/list/?series=275622&state=%2A&archive=both
> 

