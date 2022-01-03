Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37846482F9E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 10:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbiACJsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 04:48:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiACJsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 04:48:11 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10752C061761;
        Mon,  3 Jan 2022 01:48:11 -0800 (PST)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 24C341F4107D;
        Mon,  3 Jan 2022 09:48:09 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641203289;
        bh=Y62ksDINKxhxf80D4QARZK4BQpkw1rSP2CDcW5izEi8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EbpPwbQOK6TUXCJqy/xmToY7KqMl7Wcin0DZQ5YaqLrlYjyRJRLnzwTODkTVZt/F5
         DIcqugGWpXaifc220MhCGquhK0wPkL9h7ottYt2apG2MHKgUS2U9Sb2t1qrWHTOh14
         M5DK+0kAvcjdAjHfN+dFdoR+svIiMVPJ+8DjE+FGspf2UJSgTx0FIzXXcvbOudfBAr
         onVSdPwE8EFdmQvQwAafiPajN4/dWVJxFWvZCeqaWFBRBzXcphIRIh6uV+uZ4ob/Dx
         WUBl8ZQ87MSaQ4MBP+i7cQW/gPcxnbtr2U6IkFJbtAByvMz77HW2HpcgcSduoXnIdZ
         dwm6Iu/9uBsHQ==
Date:   Mon, 3 Jan 2022 10:48:05 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Apurva Nandan <a-nandan@ti.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Daniel Palmer <daniel@0x0f.com>,
        Alexander Lobakin <alobakin@pm.me>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <p.yadav@ti.com>
Subject: Re: [PATCH v3 04/17] mtd: spinand: Rename 'op_templates' to
 'data_ops'
Message-ID: <20220103104805.17dd390d@collabora.com>
In-Reply-To: <20220101074250.14443-5-a-nandan@ti.com>
References: <20220101074250.14443-1-a-nandan@ti.com>
        <20220101074250.14443-5-a-nandan@ti.com>
Organization: Collabora
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Jan 2022 13:12:37 +0530
Apurva Nandan <a-nandan@ti.com> wrote:

> Manufacturers have been deviating from the standard SPI operations for
> NAND flashes. There have been variations in non-page read/write
> instructions too. Additionally, operations, including non-page r/w ops,
> vary when flash is in different SPI mode, eg. Octal DTR.
> 
> To avoid live-patching in hot-paths or vendor-specific adjustment,
> it is better to have a set of operation templates and variants for
> non-page read/write operations as well. These would get initialized at
> the probe time or when flash changes modes. These would be called
> 'ctrl_ops'.
> 
> To make code better understandable, create two types of op templates
> which are: data_ops and ctrl_ops. Reason for having two different type
> of templates is the difference in their use cases i.e. it is possible
> to have ops of different protocol for read/write/update simulatneously
> in the data_ops, but all the ops in the ctrl_ops follow same protocol.
> 
> Rename op_templates to data_ops, and the ctrl_ops would be introduced
> in later commits.

Didn't read till the end, but I don't see any overlap between the
control and data operations in the first half of this series, so I'm
wondering if the split is actually necessary.
