Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC1A25A4389
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 09:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiH2HJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 03:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiH2HJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 03:09:32 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4ACF4D25B;
        Mon, 29 Aug 2022 00:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661756971; x=1693292971;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=baQTIOLDQEoqRnoLj/vI0QftoJ6RTiQ+sRuCKDr2yh8=;
  b=DOxvuE8fBFmAKEWaFQyVQ+Hia82a0kJVjqcDBWfsMfYagQvIgOufnrDY
   8iayJkIboMiFC1cxhdnOeZkyDDHNlUGEhQ7EDIJ4fEfqHh/bRzziDgw8P
   Cz88ohVthVjTvsDM8V6w1qL7cyoVmZLhMbY+ArTkeYM8QgX/YmS/rlbkc
   Ceb/Xw2ppaDirXsy5NZ68gS0crwIIr3BlqNJlgdvBd8G/l8odj8b+hbcq
   f7mkGd3To7EWUEj98pkVQQZvoXpF6lDYh1/Ti1eTTJZF7fwc38Ujjh26w
   xPHJ0qBouIO6yF5mQzte96B3GppSWv62fBQXe6WWGAjwF0n0/0tCqEZIz
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10453"; a="277841578"
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="277841578"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 00:09:30 -0700
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="672268649"
Received: from kvehmane-mobl1.ger.corp.intel.com ([10.251.220.41])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 00:09:28 -0700
Date:   Mon, 29 Aug 2022 10:09:25 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Li Zhong <floridsleeves@gmail.com>
cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v2] drivers/tty/serial: check the return value of
 uart_port_check()
In-Reply-To: <CAMEuxRqBEMdva3qEphvuYkFLpRjp=xg7vpqQT1oqb2AgkkG2+w@mail.gmail.com>
Message-ID: <2033d06d-10a4-5a57-d650-7541c39990ee@linux.intel.com>
References: <20220826083612.1699194-1-floridsleeves@gmail.com> <CAHp75VcdqL4wYnhEi8LrxqJktA2uDzP3a6-08suJRghX=1UZsg@mail.gmail.com> <CAMEuxRqBEMdva3qEphvuYkFLpRjp=xg7vpqQT1oqb2AgkkG2+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Aug 2022, Li Zhong wrote:

> On Fri, Aug 26, 2022 at 9:01 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> > On Fri, Aug 26, 2022 at 11:38 AM Li Zhong <floridsleeves@gmail.com> wrote:
> > >
> > > uart_port_check() will return NULL pointer when state->uart_port is
> > > NULL. Check the return value before dereference it to avoid
> > > null-pointer-dereference error.
> >
> > Have you taken the locking into consideration?
> > If no, please do, if yes, expand your commit message to explain why
> > the current locking scheme doesn't prevent an error from happening.
> >
> 
> The locking is taken into consideration but these three checks do not need to
> unlock in error-handling because unlock() will be called in the callers. Will
> add the comment in v2 patch.

I think he meant you should indicate why the current locking doesn't cover 
the case you're fixing, not whether this function should call unlock() or 
not.

-- 
 i.

