Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1954E55FAF5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 10:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbiF2Iro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 04:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbiF2Irm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 04:47:42 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E293E3CA62;
        Wed, 29 Jun 2022 01:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656492461; x=1688028461;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=CoZ4DKPpgtGqYVqyBw6YdCVH1MrmDvlVaHZ2vdLt+Ls=;
  b=kBB8LDa9vDfbWE56LLYDBs1edFzpJ+Xr/+0PKWm6spVqS7s67LL7556m
   ddNCxoIRk8Slk4SHJfb+n9gMF1oY2o1ArJ+37wu/X3HG5kA34OACed0sU
   ksqtkxtNp8TcSotEj5ol7krP74jRRlF6prUqCYTqpHlzpIciQV1fDCNld
   wAc2EpvhKOSzRUEHL46+jGEbi/WoY9coB9oCaloDDgXaAzVLvqnoLQcfp
   TI5ELPkB+FJY3alwZp3zFDHl21WMML8tuGV6/mK3BWmBJNy5McqA+265F
   30fXOgW1LvCYW6xR6FcF6SBLIq6lvqDk2ndNilGX5tZtteIkDldzujQLJ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="283068906"
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="283068906"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 01:47:41 -0700
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="647303570"
Received: from dsummer-mobl.ger.corp.intel.com ([10.252.38.121])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 01:47:38 -0700
Date:   Wed, 29 Jun 2022 11:47:36 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
cc:     "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] serial: 8250_dw: Rework ->serial_out() LCR write
 retry logic
In-Reply-To: <CAHp75Vf36sFqX1SL4Sjz6ZgNXP41Nom0Q1s6Psgv9WMFkKtGtg@mail.gmail.com>
Message-ID: <29b084c-183b-4a84-2376-2c88eff7d5a@linux.intel.com>
References: <20220628134234.53771-1-ilpo.jarvinen@linux.intel.com> <20220628134234.53771-5-ilpo.jarvinen@linux.intel.com> <CAHp75Vf36sFqX1SL4Sjz6ZgNXP41Nom0Q1s6Psgv9WMFkKtGtg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-624552388-1656489970=:1529"
Content-ID: <fca71dde-ba1c-6d91-abf6-ef73894464cb@linux.intel.com>
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-624552388-1656489970=:1529
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <a2a1263b-294-f727-fbc-b319fd9a72fa@linux.intel.com>

On Tue, 28 Jun 2022, Andy Shevchenko wrote:

> On Tue, Jun 28, 2022 at 3:43 PM Ilpo Järvinen
> <ilpo.jarvinen@linux.intel.com> wrote:
> >
> > Currently dw8250_verify_write() (was dw8250_check_lcr()) nullifies the
> > benefit from differentiated ->serial_out() by having big if tree to
> > select correct write type.
> >
> > Rework the logic such that the LCR write can be retried within the
> > relevant ->serial_out() handler:
> >   1. Move retries counter on the caller level and pass as pointer to
> >      dw8250_verify_write()
> >   2. Make dw8250_verify_write() return bool
> >   3. Retry the write on caller level (if needed)
> 
> I'm wondering if it's possible to utilize one of iopoll.h macro here
> instead of copying retries and that not-so-obvious IO poll write.

Eh, are you suggesting I should do write as a side-effect inside one of 
the iopoll.h macros? Because those available seem to only read?

Or should I create another macro there which writes too?


-- 
 i.
--8323329-624552388-1656489970=:1529--
