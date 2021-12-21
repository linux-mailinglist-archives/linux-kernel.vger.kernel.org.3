Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7990947BB0A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 08:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235174AbhLUHa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 02:30:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbhLUHa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 02:30:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED7AC061574;
        Mon, 20 Dec 2021 23:30:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73B9861425;
        Tue, 21 Dec 2021 07:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C987C36AE7;
        Tue, 21 Dec 2021 07:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640071825;
        bh=CJerA/mN0YyI2tFVe/fzLdV7aBBk5wmHqqJDBcg53KE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r25qSWLbqw89+H4nLz/vRzBcGGuUTagWmFT5Il8sB9UAhKPX1EgaPZfSO1kzOUG2e
         Rng1IJUYuh24Ay1tz4uJGzAq9BZybhaV/mxmaGeJlCYb8YAD/eukVz8N+db0XUYog1
         t4SpNyTlO7GAPpyv+hUtppMNZh9wTR+LuiWx5AYM=
Date:   Tue, 21 Dec 2021 08:30:23 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Yu Tu <yu.tu@amlogic.com>
Cc:     linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH 1/3] tty: serial: meson: modify request_irq and free_irq
Message-ID: <YcGCj2jGpzl+sKcT@kroah.com>
References: <20211221071634.25980-1-yu.tu@amlogic.com>
 <20211221071634.25980-2-yu.tu@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211221071634.25980-2-yu.tu@amlogic.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 03:16:32PM +0800, Yu Tu wrote:
> Change request_irq to devm_request_irq and free_irq to devm_free_irq.
> It's better to change the code this way.

Why?  What did this fix up?  You still are manually requesting and
freeing the irq.  What bug did you fix?

> 
> The IRQF_SHARED interrupt flag was added because an interrupt error was
> detected when the serial port was opened twice in a row on the project.

That is a different change.  Make that a different patch.

thanks,

greg k-h
