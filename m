Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20FF14C8DAA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 15:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235264AbiCAO04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 09:26:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235256AbiCAO0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 09:26:52 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F909A99D;
        Tue,  1 Mar 2022 06:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646144771; x=1677680771;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=n4vtaAj6xE9MJ82UUcFkIcwFnLsTI1TghnfEZ1HrPDk=;
  b=K560aeZrjL56vfDZIZeCp+fuZMH/xrRQHYqOQDj1nNPbs/e7PYOgQhWs
   SjkMDlCiRAlZKjNE+pHMQextA+N4unMDa6cXkNhb10ViBph8s/f87zjOT
   8S5dsZ+6c3Ive+VRb4II6B4P7yMz0bgQhJbdXgSEZUbd8vpbgi+9Z/hJm
   4ZWivV7h68RNcsqIiKVyjhtshBjbHALx3oMi5xbSdzEOKSvC/8O6h+LqY
   Gb819es2h3B6z/MmGd8qhSq9nRTnV1GGOZeAr6pxsEU+3sOvBnjjQclRc
   cYUnPC0fE7V+cDfL9R6DIYVzZf4cvB9dXkItSvPgIX3cuiIqpQrNEVQSB
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="236648051"
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="236648051"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 06:26:11 -0800
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="709077634"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 06:26:08 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nP3RI-009qvk-1C;
        Tue, 01 Mar 2022 16:25:20 +0200
Date:   Tue, 1 Mar 2022 16:25:19 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>, rafael@kernel.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-acpi@vger.kernel.org, Alexander Graf <graf@amazon.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH 2/3 v6] ACPI: allow longer device IDs
Message-ID: <Yh4sz8tpNxUecRQw@smile.fi.intel.com>
References: <CAHmME9qHnvwrxEue4Pdm_E1qZQGXFuR9orJSKCWj8fH5TSh6fA@mail.gmail.com>
 <20220228183355.9090-1-Jason@zx2c4.com>
 <e9bfc654-5504-29ff-5a5a-b73f24691600@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9bfc654-5504-29ff-5a5a-b73f24691600@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2022 at 11:35:12AM +0100, Hans de Goede wrote:
> On 2/28/22 19:33, Jason A. Donenfeld wrote:

> > Co-authored-by: Jason A. Donenfeld <Jason@zx2c4.com>

Official tag is Co-developed-by

> > [Jason: reworked commit message a bit, went with len=16 approach.]
> > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

-- 
With Best Regards,
Andy Shevchenko


