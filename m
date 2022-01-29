Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54AC94A2D79
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 10:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236650AbiA2JuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 04:50:10 -0500
Received: from phobos.denx.de ([85.214.62.61]:40010 "EHLO phobos.denx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234124AbiA2JuK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 04:50:10 -0500
Received: from crub (p508b6e90.dip0.t-ipconnect.de [80.139.110.144])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: agust@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id BD2D78210D;
        Sat, 29 Jan 2022 10:50:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1643449808;
        bh=wcVkdXf9yFZ5R/QSWp9DJkR9pJYiKAivTu+9LpeeBSQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ytd+bRoJLgNjHWWwFhyqm9CGOLMwNRGwOafo7NDZc5AmzDdttsgAIFY3xkIjrB4Ng
         2yFd7qr/HACHUWiU85gEFaTcYLue/uJf2SV/tqzNXaY59l8Is4x8uFCwyL23LzEYTr
         8UO1Tgtyr2jAe5yU3qYG1lQhQh4uV9POl+8TdBC7clfpgLomdxDW58mjttmtnYyWiy
         MnlZ/R0j6MZQw7MonX8QU2Vu0C9nSv0TQC973aDjuYXi/axZYReZoirZRwi19FKmwl
         d40aUvl1doehfxjKifA4qIX/wzhhnuTIREplC/9kniI3LRdEAcFEtbqG51ljS9K2rv
         lDosRuD3nOpIQ==
Date:   Sat, 29 Jan 2022 10:50:07 +0100
From:   Anatolij Gustschin <agust@denx.de>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Grant Likely <grant.likely@secretlab.ca>,
        John Bonesio <bones@secretlab.ca>,
        linuxppc-dev@lists.ozlabs.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: platforms: 52xx: Fix a resource leak in an
 error handling path
Message-ID: <20220129105007.6dfdea45@crub>
In-Reply-To: <dec1496d46ccd5311d0f6e9f9ca4238be11bf6a6.1643440531.git.christophe.jaillet@wanadoo.fr>
References: <dec1496d46ccd5311d0f6e9f9ca4238be11bf6a6.1643440531.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.5 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Jan 2022 08:16:04 +0100
Christophe JAILLET christophe.jaillet@wanadoo.fr wrote:

>The error handling path of mpc52xx_lpbfifo_probe() and a request_irq() is
>not balanced by a corresponding free_irq().
>
>Add the missing call, as already done in the remove function.
>
>Fixes: 3c9059d79f5e ("powerpc/5200: add LocalPlus bus FIFO device driver")
>Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>---
>Another strange thing is that the remove function has:
>	/* Release the bestcomm transmit task */
>	free_irq(bcom_get_task_irq(lpbfifo.bcom_tx_task), &lpbfifo);
>but I've not been able to find a corresponding request_irq().

This driver does not request the tx task irq itself, but a fifo
client driver can request/free tx interrupts for submitted
fifo write tasks, like mpc5200 fec and pata drivers do, so
it is okay.

>Is it dead code? Is there something missing in the probe?

No.

--
Anatolij
