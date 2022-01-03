Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28788482FF1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 11:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbiACKgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 05:36:47 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46088 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbiACKgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 05:36:46 -0500
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 0A5631F41F71;
        Mon,  3 Jan 2022 10:36:45 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641206205;
        bh=7vrzXz0wxw0kDWHD24+zdSJOw16tOJ0SRxitDlg9cUg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ko2VXqiqKs95AVrJCp3fe/PjDKZ4DFCIhDPPvpr/VsQa/0IGKmIkJBFDxzbo0w08i
         JMi+qLAREwLOraWbJZ7+3sNf/w2xYkhrn2WU04kQVVNOLUZ53Bsu7ABpXDL6lTAsm0
         DRD4gq+L1ZnmbPtZs2sd3mFsk4vZ2MP/5gq4O8AGcC191GPOTy1OS99ZwxTfbvwLP8
         2IAMx6s5TL14qB/DTwp1Z9G8FAlysqRchVAWztazBgsKp80Xqi8KtZ8S59pp9oW34x
         9aWSBrojeqfKrj+ppFogioY4W2Hf6p0ZFY1P1+QjoL2ojVmi8WG4JwYIFfOYcnaR10
         6F3fF67nawYZg==
Date:   Mon, 3 Jan 2022 11:36:41 +0100
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
Subject: Re: [PATCH v3 05/17] mtd: spinand: Define ctrl_ops for non-page
 read/write op templates
Message-ID: <20220103113641.03160d95@collabora.com>
In-Reply-To: <20220103110107.45594e78@collabora.com>
References: <20220101074250.14443-1-a-nandan@ti.com>
        <20220101074250.14443-6-a-nandan@ti.com>
        <20220103110107.45594e78@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jan 2022 11:01:07 +0100
Boris Brezillon <boris.brezillon@collabora.com> wrote:


> struct spinand_device {
> 	...
> 	enum spinand_protocol protocol;
> 	const struct spinand_op_templates *op_templates[SPINAND_NUM_PROTOCOLS];

My bad, it should be:

	struct spinand_op_templates op_templates[SPINAND_NUM_PROTOCOLS];

since those templates get populated dynamically at probe time based on
what the flash and the controller support.

> 	...
> };
> 
