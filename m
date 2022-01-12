Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97F2B48BE6A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 06:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350933AbiALFrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 00:47:20 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:57120 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350916AbiALFrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 00:47:19 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id E8D78201337;
        Wed, 12 Jan 2022 05:47:16 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id C11558066A; Wed, 12 Jan 2022 05:56:20 +0100 (CET)
Date:   Wed, 12 Jan 2022 05:56:20 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Cai Huoqing <caihuoqing@baidu.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pcmcia: Guard yenta_dev_{resume,suspend}_noirq() on
 CONFIG_PM_SLEEP
Message-ID: <Yd5fdBudm+vpmpRe@owl.dominikbrodowski.net>
References: <20220111165004.1764190-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220111165004.1764190-1-nathan@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Tue, Jan 11, 2022 at 09:50:04AM -0700 schrieb Nathan Chancellor:
> When building without CONFIG_PM_SLEEP:
> 
> drivers/pcmcia/yenta_socket.c:1322:12: error: ‘yenta_dev_resume_noirq’ defined but not used [-Werror=unused-function]
>  1322 | static int yenta_dev_resume_noirq(struct device *dev)
>       |            ^~~~~~~~~~~~~~~~~~~~~~
> drivers/pcmcia/yenta_socket.c:1303:12: error: ‘yenta_dev_suspend_noirq’ defined but not used [-Werror=unused-function]
>  1303 | static int yenta_dev_suspend_noirq(struct device *dev)
>       |            ^~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> 
> SET_NOIRQ_SYSTEM_SLEEP_PM_OPS evaluates to an empty macro when
> CONFIG_PM_SLEEP is not set. Every callback in yenta_pm_ops depends on
> CONFIG_PM_SLEEP to work properly so just guard this whole block on
> CONFIG_PM_SLEEP, rather than CONFIG_PM, which CONFIG_PM_SLEEP will
> select.
> 
> Fixes: 3daaf2c7aae8 ("pcmcia: Make use of the helper macro SET_NOIRQ_SYSTEM_SLEEP_PM_OPS()")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Thanks! An equivalent patch by Paul E. McKenney was hand-picked by Linus in
the meantime:
	https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=579f3a6d32a9c3d1cf5c2b1bd66817a2db31a968

Thanks again,
	Dominik

> ---
>  drivers/pcmcia/yenta_socket.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pcmcia/yenta_socket.c b/drivers/pcmcia/yenta_socket.c
> index 837877daed62..3966a6ceb1ac 100644
> --- a/drivers/pcmcia/yenta_socket.c
> +++ b/drivers/pcmcia/yenta_socket.c
> @@ -1299,7 +1299,7 @@ static int yenta_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  	return ret;
>  }
>  
> -#ifdef CONFIG_PM
> +#ifdef CONFIG_PM_SLEEP
>  static int yenta_dev_suspend_noirq(struct device *dev)
>  {
>  	struct pci_dev *pdev = to_pci_dev(dev);
> 
> base-commit: fbb3485f1f931102d8ba606f1c28123f5b48afa3
> -- 
> 2.34.1
> 
