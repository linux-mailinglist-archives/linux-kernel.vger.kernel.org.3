Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AAC8469770
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 14:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244773AbhLFNvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 08:51:20 -0500
Received: from mga02.intel.com ([134.134.136.20]:31137 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244021AbhLFNvU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 08:51:20 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10189"; a="224566255"
X-IronPort-AV: E=Sophos;i="5.87,291,1631602800"; 
   d="scan'208";a="224566255"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 05:47:51 -0800
X-IronPort-AV: E=Sophos;i="5.87,291,1631602800"; 
   d="scan'208";a="542393944"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 05:47:40 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1muEKG-002nTh-2c;
        Mon, 06 Dec 2021 15:46:40 +0200
Date:   Mon, 6 Dec 2021 15:46:39 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_pci: remove redundant assignment to tmp
 after the mask operation
Message-ID: <Ya4UP5ceA8jINvVT@smile.fi.intel.com>
References: <20211205232822.110099-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211205232822.110099-1-colin.i.king@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 05, 2021 at 11:28:22PM +0000, Colin Ian King wrote:
> The variable tmp is being masked with a bitmask and the value is being
> written to port base + 0x3c.  However, the masked value is being written
> back to tmp and tmp is never used after this. The assignmentment is
> redundant, replace the &= operator with just &.

Make sense (maybe you can replace all those 0x00...BIT...00 by BIT()
and GENMASK() later on).

Reviewesd-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/tty/serial/8250/8250_pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
> index 60f8fffdfd77..81aac3c25ead 100644
> --- a/drivers/tty/serial/8250/8250_pci.c
> +++ b/drivers/tty/serial/8250/8250_pci.c
> @@ -1278,7 +1278,7 @@ static int pci_quatech_init(struct pci_dev *dev)
>  			outl(inl(base + 0x38) | 0x00002000, base + 0x38);
>  			tmp = inl(base + 0x3c);
>  			outl(tmp | 0x01000000, base + 0x3c);
> -			outl(tmp &= ~0x01000000, base + 0x3c);
> +			outl(tmp & ~0x01000000, base + 0x3c);
>  		}
>  	}
>  	return 0;
> -- 
> 2.33.1
> 

-- 
With Best Regards,
Andy Shevchenko


