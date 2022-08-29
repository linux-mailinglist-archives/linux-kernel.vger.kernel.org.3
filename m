Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF3ED5A4630
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 11:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiH2Jga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 05:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiH2Jg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 05:36:27 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07025C97B
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 02:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661765786; x=1693301786;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=grH/4J/cN7Mpd+sfgzlCpokTKZ4Un8uHFmFcQI849BE=;
  b=GrYEtnOP5B9IYtCPL/TcugvC44k/Ko245AhCx1jFQpcC7rBaWbKjfb0F
   aOTw8bOvkUjIq56mk0JPHh1tPZ78YvqMkA5VRpBqXzZ7brHSt/smL/ANu
   KdV3QO86BVhGFpKu7H72hNmKQ7U9/vuKhaBgY+yuw5J6Hi7ZXXCP+1mOv
   cNFUPiLVaCelrwqIrAh0k67pillp3e02GbqkEwmuL0W4x743VisEhhSTx
   U0mUoYJ/m613taGp2tkMHjBDzXEtr+Pyx+FVCkqWdRwXdxPKByFWw4d9Y
   2WdVxQwKZ8QVu4iGFQYmFt7nNVUNFZQpSz4n8S5+wuD0iAzRFpOUNq4jO
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10453"; a="294863184"
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="294863184"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 02:36:26 -0700
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="672313597"
Received: from kvehmane-mobl1.ger.corp.intel.com ([10.251.220.41])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 02:36:24 -0700
Date:   Mon, 29 Aug 2022 12:36:24 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: 6.0 tty regression, NULL pointer deref in flush_to_ldisc
In-Reply-To: <4b4bba5d-d291-d9fa-8382-cdc197b7ed35@redhat.com>
Message-ID: <e8d67c78-751e-2c44-edff-e7e441c3302d@linux.intel.com>
References: <4b4bba5d-d291-d9fa-8382-cdc197b7ed35@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Aug 2022, Hans de Goede wrote:

> Hi All,
> 
> This weekend I noticed that on various Bay Trail based systems which have
> their bluetooth HCI connected over an uart (using hci_uart driver /
> using the drivers/tty/serial bus) there is a NULL pointer deref in
> flush_to_ldisc, see below for the full backtrace.
> 
> I *suspect* that this is caused by commit 6bb6fa6908eb
> ("tty: Implement lookahead to process XON/XOFF timely").
> 
> I can cleanly revert this by reverting the following commits:
> 
> ab24a01b2765 ("tty: Add closing marker into comment in tty_ldisc.h")
> 65534736d9a5 ("tty: Use flow-control char function on closing path")
> 6bb6fa6908eb ("tty: Implement lookahead to process XON/XOFF timely")
> 
> ATM I don't have one of the affected systems handy. I will give
> a 6.0-rc3 kernel with these 3 commits reverted a try tonight (CEST)
> and I'll let you know the results.
> 
> Note I can NOT confirm yet that these reverts fix things, so please
> don't revert anything yet. I just wanted to give people a headsup
> about this issue.
> 
> Also maybe we can fix the new lookahead code instead of reverting.
> I would be happy to add a patch adding some debugging prints the
> systems run fine after the backtrace as long as I don't suspend them
> so gathering logs is easy.

I guess this will help:

https://lore.kernel.org/linux-kernel/20220818115026.2237893-1-vincent.whitchurch@axis.com/

-- 
 i.

