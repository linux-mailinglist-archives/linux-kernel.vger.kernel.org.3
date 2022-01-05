Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1A8485103
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 11:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239408AbiAEKTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 05:19:02 -0500
Received: from mga18.intel.com ([134.134.136.126]:16737 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239423AbiAEKSt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 05:18:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641377929; x=1672913929;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=g3OyRQxCGW9lrYMkgi1UX3MPbU1n/zzvLD8bMKrMEiY=;
  b=eEsUrPt9oXaXog0qjW6MyEiBLqnx2B8NSiu6neb4fnuU29+zpBuxSRwX
   XApH3dgHj/vZBYIWK2L3oRzPTBo3CQgWCpDsdo7tOYq1eZws3Q1Utvqv+
   7D43HAACIAcJz1Qw+bojrjP3gFoA41ibSyK7Eb459FcXSJSumd6tMLZU5
   fwGLcvSLYGjYN/p6HpNnwQ9OGIeSKGXrYsPOGUSWtvL0sPqG22iXHL/mY
   PJiQVzfTqZKWrMiKPRjiDHoSitClSTQMejYbr3JDnC1YEx+uuFyXZkw9f
   a4WuQEBsCtp2YsVyWRVTctxLzYEz83L5wO6yFUPZeOXF7AYqBl/UuUTFH
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="229230659"
X-IronPort-AV: E=Sophos;i="5.88,263,1635231600"; 
   d="scan'208";a="229230659"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 02:18:47 -0800
X-IronPort-AV: E=Sophos;i="5.88,263,1635231600"; 
   d="scan'208";a="512891156"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 02:18:44 -0800
Received: by lahna (sSMTP sendmail emulation); Wed, 05 Jan 2022 12:17:38 +0200
Date:   Wed, 5 Jan 2022 12:17:38 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     andreas.noever@gmail.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thunderbolt: Check for null pointer after calling
 kmemdup in icm_handle_event
Message-ID: <YdVwQvoadUC22CVb@lahna>
References: <20220105082634.2410596-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105082634.2410596-1-jiasheng@iscas.ac.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jan 05, 2022 at 04:26:34PM +0800, Jiasheng Jiang wrote:
> As the possible failure of the allocation, kmemdup() may return NULL
> pointer.
> Like alloc_switch(), it might be better to check it.
> Therefore, icm_handle_event() should also check the return value of
> kmemdup().
> If fails, just free 'n' and directly return is enough, same as the way
> to handle the failure of kmalloc().
> 
> Fixes: f67cf491175a ("thunderbolt: Add support for Internal Connection Manager (ICM)")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>

Thanks for the patch but I realized that this has been fixed already:

https://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt.git/commit/?h=next&id=3cc1c6de458e0e58c413c3c35802ca96e55bbdbe
