Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA01C4A463F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 12:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377219AbiAaLv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 06:51:26 -0500
Received: from mga02.intel.com ([134.134.136.20]:11337 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1377892AbiAaLdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 06:33:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643628823; x=1675164823;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=r2zU0vRwxWHr5Wrk87f5nIJZlDMOAovObT6GySVXQkE=;
  b=L/TEpVI5BkG6uR/p3qgeKg8ejxmzYMwvpxVlyTS3CPlgcNskBJb9g5RM
   CeyRTaqO+/uU2zGXlSDefVjVy8ZP6Sw77156n0TMeIwnA61APEkh+Qt3p
   08Wac65qlPs7FytEIhvg5cyrGg55v+iRG5ThlrHoNhZDaG/SzUP1DBEJr
   6c1IJYs/79eebt09fysZc9rApBqLjv/lhCFUO5uS/HHop9IZJd+w2flVn
   t7zvPDDVOe/MUjfsGpi1Zk5AJGLkY8Ayo/kNQQcNMcRUJbpP+D495EELn
   m79KuzoghM/2AErIOtAixfSNfqOhGRq/RBKqPlym+ru6wUrbH+9e4UCTX
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10243"; a="234832591"
X-IronPort-AV: E=Sophos;i="5.88,330,1635231600"; 
   d="scan'208";a="234832591"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 03:25:30 -0800
X-IronPort-AV: E=Sophos;i="5.88,330,1635231600"; 
   d="scan'208";a="629991075"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 03:25:28 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nEUnJ-00GqaD-2Z;
        Mon, 31 Jan 2022 13:24:25 +0200
Date:   Mon, 31 Jan 2022 13:24:24 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH] surface: surface3-wmi: Simplify resource management
Message-ID: <YffG6JKmGCS1/h08@smile.fi.intel.com>
References: <8b1a6d05036d5d9527241b2345482b369331ce5c.1643531799.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b1a6d05036d5d9527241b2345482b369331ce5c.1643531799.git.christophe.jaillet@wanadoo.fr>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 30, 2022 at 09:36:54AM +0100, Christophe JAILLET wrote:
> 's3_wmi.input' is a managed resource, so there should be no need to free it
> explicitly.
> 
> Moreover, 's3_wmi' is a global variable. 's3_wmi.input' should be NULL
> when this error handling path is executed, because it has not been
> assigned yet.
> 
> All this is puzzling. So simplify it and remove a few lines of code to have
> it be more straightforward.


Seems correct cleanup / fix to me
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Fixes: 3dda3b3798f9 ("platform/x86: Add custom surface3 platform device for controlling LID")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Compile tested only
> ---
>  drivers/platform/surface/surface3-wmi.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/platform/surface/surface3-wmi.c b/drivers/platform/surface/surface3-wmi.c
> index 09ac9cfc40d8..b9a4b2d81f4b 100644
> --- a/drivers/platform/surface/surface3-wmi.c
> +++ b/drivers/platform/surface/surface3-wmi.c
> @@ -190,14 +190,11 @@ static int s3_wmi_create_and_register_input(struct platform_device *pdev)
>  
>  	error = input_register_device(input);
>  	if (error)
> -		goto out_err;
> +		return error;
>  
>  	s3_wmi.input = input;
>  
>  	return 0;
> - out_err:
> -	input_free_device(s3_wmi.input);
> -	return error;
>  }
>  
>  static int __init s3_wmi_probe(struct platform_device *pdev)
> -- 
> 2.32.0
> 

-- 
With Best Regards,
Andy Shevchenko


