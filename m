Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33E304E5189
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 12:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243993AbiCWLqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 07:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbiCWLqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 07:46:33 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06BA037BC2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 04:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648035904; x=1679571904;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=L7fnnj44GzYC3xj3q3dLZgw4zoYW9N6Mb9jq70zoJSU=;
  b=J84Btvov57bcGbrYcS8szLl/d26tHeeoxpJbWg/UO8r3AvYJGaJgSz3N
   32EoYNG8LZikytwqVJoj4WA8mSY4mmGBpXhPCKBWmr1cdWdKxqPWwXm9Z
   nsb6LIKPTUdMetoUULE+xeNVlNfp+wpidBUzzrHCUBnAgp/TDz9XcCjAq
   Ooql9rI2uH8QJ+ClRdC+rWvUmaEvZMrMDRQ/y9hsUzts/mmWqVEbp5XHe
   NL7ahRK00ec1+gauB9unnIbARWuTnJ1SaoZ5fM3pCDZjk3aztAmfOlMQJ
   qcnGOUCXbhC+8o3EDKwLEvNcruCuV3PQzEqdJUAk6hEmcWtDnXzXTbbwI
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10294"; a="318799158"
X-IronPort-AV: E=Sophos;i="5.90,204,1643702400"; 
   d="scan'208";a="318799158"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 04:45:03 -0700
X-IronPort-AV: E=Sophos;i="5.90,204,1643702400"; 
   d="scan'208";a="717366373"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 04:44:58 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 1D833204A8;
        Wed, 23 Mar 2022 13:44:56 +0200 (EET)
Date:   Wed, 23 Mar 2022 13:44:56 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matt Turner <mattst88@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Richard Henderson <rth@twiddle.net>,
        Sean Christopherson <seanjc@google.com>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [GIT PULL] bounds fixes for v5.18-rc1
Message-ID: <YjsIOGpYwN10n60u@paasikivi.fi.intel.com>
References: <202203210843.0E70F58@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202203210843.0E70F58@keescook>
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

On Mon, Mar 21, 2022 at 08:52:31AM -0700, Kees Cook wrote:
>       media: omap3isp: Use struct_group() for memcpy() region

This patch has been applied to linux-media tree about a month ago. It may
have taken a bit more time than usual to get to linux-next though.

Please try to remember to agree with maintainers in advance when merging
patches via non-default routes.

Thanks.

-- 
Kind regards,

Sakari Ailus
