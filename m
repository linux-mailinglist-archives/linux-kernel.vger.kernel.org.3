Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C738D561591
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 11:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233760AbiF3JAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 05:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiF3JAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 05:00:48 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4968862FD;
        Thu, 30 Jun 2022 02:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656579647; x=1688115647;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=TXcK+3q53pj9pgGV4Quq35o1WwaCOTY/3PPRcUv/fvU=;
  b=gYdU5GOq/HlNmbt5ex43HxqhnEQYgYUqJNH23If6pMVjmb3Pdpnn3ZBs
   4rB4LhIBCIzzcD1ucomiKUlDmPCf20fTmAGieGgln4Bj4AeV9PIGPWdIo
   Cn73PyVvhSk2IcykbSA6FP1aI1+uBjG/lyjKj1bC755j1sB7laVBxkd3e
   dCGeitMzS1sr3QwtHEuXr/BmLbTJk1tYwvuFSWpfvq+nA++Ue4OAl6l7Q
   NF+nCpKqFiOhRM+PopDFoPaCEJb6rc583QxJrryjVvRxLj6Bi2k83lpEl
   ITeN0hlXatOXntPZx63CzxB2HRYd3fFA6ccs12qYzvpG8M09WU8OG/zNi
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="283391536"
X-IronPort-AV: E=Sophos;i="5.92,233,1650956400"; 
   d="scan'208";a="283391536"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 02:00:46 -0700
X-IronPort-AV: E=Sophos;i="5.92,233,1650956400"; 
   d="scan'208";a="917971818"
Received: from emontau-mobl2.ger.corp.intel.com ([10.249.42.178])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 02:00:43 -0700
Date:   Thu, 30 Jun 2022 12:00:42 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Paul Cercueil <paul@crapouillou.net>
cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v1 1/1] serial: 8250_dw: Drop PM ifdeffery
In-Reply-To: <J98AER.7ZO6O9DK05IM1@crapouillou.net>
Message-ID: <e1cfe399-2b4c-790-f648-3ce13736b1eb@linux.intel.com>
References: <20220628214511.37373-1-andriy.shevchenko@linux.intel.com> <4ae74f48-c51c-cb74-548d-46ff9a9a7a7b@linux.intel.com> <J98AER.7ZO6O9DK05IM1@crapouillou.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2069501113-1656579645=:1605"
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

--8323329-2069501113-1656579645=:1605
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Thu, 30 Jun 2022, Paul Cercueil wrote:

> Hi Ilpo,
> 
> Le jeu., juin 30 2022 at 10:41:40 +0300, Ilpo Järvinen
> <ilpo.jarvinen@linux.intel.com> a écrit :
> > On Wed, 29 Jun 2022, Andy Shevchenko wrote:
> > 
> > >  Drop CONFIG_PM and CONFIG_PM_SLEEP ifdeffery while converting
> > > dw8250_pm_ops
> > >  to use new PM macros.
> > > 
> > >  Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> > Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > 
> > Not directily related to the patch itself but do you have any idea why
> > 1a3c7bb08826 ("PM: core: Add new *_PM_OPS macros, deprecate old ones")
> > didn't wrap RUNTIME_PM_OPS() pointers with pm_ptr()? I'm asking this
> > because in SET_RUNTIME_PM_OPS() the callbacks are only created with
> > #ifdef CONFIG_PM so I'd have expected RUNTIME_PM_OPS() to maintain that
> > behavior but it didn't? Was it just an oversight that should be fixed?
> 
> The RUNTIME_PM_OPS() does not wrap pointers with pm_ptr(), because the pointer
> to the dev_pm_ops should only ever be used wrapped with pm_ptr() or
> pm_sleep_ptr().
> 
> Which is not done here.

Ok, thanks a lot for the explanation. It's really appreciated.

-- 
 i.

> Andy:
> The deference of dw8250_pm_ops should be pm_ptr(&dw8250_pm_ops). If you only
> had system suspend/resume functions, you'd use pm_sleep_ptr() there.


--8323329-2069501113-1656579645=:1605--
