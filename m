Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 795D447D0E2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 12:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244604AbhLVLTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 06:19:33 -0500
Received: from mga05.intel.com ([192.55.52.43]:12651 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232583AbhLVLTb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 06:19:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640171971; x=1671707971;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=25dCfEp2pAvKUokPJO2DqPPHDmETKVion+KXeY2z9Ss=;
  b=NlzUTYJn/UKKNZNMxtDcTRS6WmTmQvXCgG2xgc0xTnKzy/+ooEbb9Nn6
   2JPvvs2NOyK2z108bd5dr7+IXKqJk+QBADmsJgmATkiwN64Y/AcC5JTSS
   PP6Um2GTlJK9Pt/rmFM90rrukQ7FVueXgeCRXay7XiIfSbdGZ+yaObdyq
   JH+xAZ0FQIihhRR78yecNoWzB9Cj8OevO7gfv0qdzZC9ThBvmG/yHhNb6
   WUeLTOIhj1Lv5CyZ81LnA9GLw9KTpIElK3UugSSo9Xly1fBjJbJogyESo
   AoljR4ockmhfNUYnZie0N48khZGSAcE88YLr4ts+QK+UxkXYiGAKHLRif
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10205"; a="326902926"
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; 
   d="scan'208";a="326902926"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 03:19:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; 
   d="scan'208";a="664244330"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 22 Dec 2021 03:19:28 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 22 Dec 2021 13:19:27 +0200
Date:   Wed, 22 Dec 2021 13:19:27 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] software node: fix wrong node passed to find nargs_prop
Message-ID: <YcMJv3TvqZkrGSMG@kuha.fi.intel.com>
References: <20211220210533.3578678-1-clement.leger@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211220210533.3578678-1-clement.leger@bootlin.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 10:05:33PM +0100, Clément Léger wrote:
> nargs_prop refers to a property located in the reference that is found
> within the nargs property. Use the correct reference node in call to
> property_entry_read_int_array() to retrieve the correct nargs value.
> 
> Fixes: b06184acf751 ("software node: Add software_node_get_reference_args()")
> Signed-off-by: Clément Léger <clement.leger@bootlin.com>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/base/swnode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> index 4debcea4fb12..0a482212c7e8 100644
> --- a/drivers/base/swnode.c
> +++ b/drivers/base/swnode.c
> @@ -529,7 +529,7 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
>  		return -ENOENT;
>  
>  	if (nargs_prop) {
> -		error = property_entry_read_int_array(swnode->node->properties,
> +		error = property_entry_read_int_array(ref->node->properties,
>  						      nargs_prop, sizeof(u32),
>  						      &nargs_prop_val, 1);
>  		if (error)
> -- 
> 2.34.1

-- 
heikki
