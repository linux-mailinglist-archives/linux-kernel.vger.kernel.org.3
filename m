Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9EB55AE8DF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 14:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240357AbiIFMzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 08:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240347AbiIFMy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 08:54:29 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293C56E8A6;
        Tue,  6 Sep 2022 05:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662468852; x=1694004852;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AuhIIJScC02nXHqA0igWrc36n6s/zz9Obhn0kpayqwI=;
  b=GGww8Cn7kVSFV/AzDA+inK0dJsuxvIzXg/i47K+BHSjFVkU9YSojUEZA
   smKuKcWLLgaBhe4PDYG8/w6L55XJumniADATd2Ra2CfRV0X7c7zjVlTcD
   VkkiQed3p/598jsk0x9NnFN9mc7ZL8jKSxVD/v1+grh6FEvikO66MJ4EU
   dKMz+M+WXZNNktZQEDAC3L8j5KJpNrsmh7KaNhq4PMCTwKNIDkMzKPrqa
   Fm9rdGAPiv1CmLhYJWpGMGDJipoOk3KUUjy7WBSxKjJrp7+e/RO6GF3yV
   PpgnjoCXbas7KezbcOYUXvvTsIfbCZBEF+Gwufi2cpomcBcDnpBiHlvnG
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="360532020"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="360532020"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 05:54:11 -0700
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="675677408"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 05:54:09 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oVY5e-0097jn-2u;
        Tue, 06 Sep 2022 15:54:06 +0300
Date:   Tue, 6 Sep 2022 15:54:06 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v1 1/1] Input: icn8505 - Utilize acpi_get_subsystem_id()
Message-ID: <YxdC7i9F1ayR5icS@smile.fi.intel.com>
References: <20220905172001.69244-1-andriy.shevchenko@linux.intel.com>
 <YxZPjsRJXJijZ/K3@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxZPjsRJXJijZ/K3@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2022 at 12:35:42PM -0700, Dmitry Torokhov wrote:
> On Mon, Sep 05, 2022 at 08:20:01PM +0300, Andy Shevchenko wrote:

...

> > +	subsys = acpi_get_subsystem_id(ACPI_HANDLE(dev));
> > +	if (IS_ERR(subsys) && PTR_ERR(subsys) != -ENODATA)
> > +		return PTR_ERR(subsys);
> > +
> > +	if (IS_ERR(subsys) && PTR_ERR(subsys) == -ENODATA)
> > +		subsys = kstrdup_const("unknown", GFP_KERNEL);
> 
> Do we really need kstrdup_const() here? This makes me wonder if we need
> to also have error handling here, and if we going to tip some automated
> tools by not having it. Why can't we simply assign the constant here
> (and continue using kfree_const() below)?

Which makes code inconsistent. But okay, no big deal.

> I think this is the case where PTR_ERR_OR_ZERO() might help avoid
> multiple IS_ERR/PTR_ERR:
> 
> 	subsys = acpi_get_subsystem_id(ACPI_HANDLE(dev));
> 	error = PTR_ERR_OR_ZERO(subsys);
> 	if (error == -ENODATA)
> 		subsys = "unknown";
> 	else if (error)
> 		return error;

Would it matter? The generated code will be the same in both cases, no?

> >  	snprintf(icn8505->firmware_name, sizeof(icn8505->firmware_name),
> >  		 "chipone/icn8505-%s.fw", subsys);
> >  
> > -	kfree(buffer.pointer);
> > +	kfree_const(subsys);
> >  	return 0;

-- 
With Best Regards,
Andy Shevchenko


