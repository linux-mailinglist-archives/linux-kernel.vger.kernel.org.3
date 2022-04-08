Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7F2E4F97DE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 16:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236797AbiDHOUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 10:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbiDHOTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 10:19:54 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8BF1B84D9;
        Fri,  8 Apr 2022 07:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649427470; x=1680963470;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=nR19yTP/j92Eufx9RhmueAKoutE5mSKeE4sBlnP8y1g=;
  b=F75JH8dDpNr60ONrRU2QPq2MXxK2AHhV5y6MB3G6ZuoVEKhhMDMqccA+
   xZTbeU9GxqP6YxL8DxPffedNXiU0sOB5k5OcC9abZerH6I5r7nnyyfRjX
   L21bV4rPVpMRWANPm0nRpk4Jh8imV+NzsH80Pih0gb1NtQ3EYmoU/er4H
   DUrig/azyALH1NuVQyscnWJQWi6rYv/RtwEf+9Ykjg9tHitYSdB9u65dg
   XOP5VbsqXJnKJwTd9CA6VQzf/AzfixHr/RaunpAA8MLjiHk918ogreOvj
   bwQ6w+rTZnIwIR8wZ+gaSp2Tj6tT4AdXN8D35BcHiOYOJc1A2ZGmAq1MG
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="243734622"
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="243734622"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 07:17:49 -0700
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="571501341"
Received: from aecajiao-mobl.amr.corp.intel.com ([10.252.48.54])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 07:17:47 -0700
Date:   Fri, 8 Apr 2022 17:17:45 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc:     linux-serial <linux-serial@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Gilles Buloz <gilles.buloz@kontron.com>,
        Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v2 2/3] tty: Add lookahead param to receive_buf
In-Reply-To: <YlAvUL2rMreUZwdF@smile.fi.intel.com>
Message-ID: <7148dd63-3450-46e8-4cc0-8f4d607d882@linux.intel.com>
References: <20220408113954.9749-1-ilpo.jarvinen@linux.intel.com> <20220408113954.9749-3-ilpo.jarvinen@linux.intel.com> <YlAjfAab+Oh3HcCR@smile.fi.intel.com> <42fc2746-6a7c-9b44-87a5-32f219c1231@linux.intel.com> <YlAvUL2rMreUZwdF@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-810036969-1649425381=:1643"
Content-ID: <e3275aad-c166-d433-aeb2-96e32dccb4f@linux.intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-810036969-1649425381=:1643
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <9d5a9cfd-6275-80fb-36ae-e45e616f2ca@linux.intel.com>

On Fri, 8 Apr 2022, Andy Shevchenko wrote:

> On Fri, Apr 08, 2022 at 03:34:27PM +0300, Ilpo Järvinen wrote:
> > On Fri, 8 Apr 2022, Andy Shevchenko wrote:
> > > On Fri, Apr 08, 2022 at 02:39:53PM +0300, Ilpo Järvinen wrote:
> 
> > What I'd like to do here is to take advantage of the function that was 
> > added:
> > 
> > 		if (!n_tty_receive_char_flow_ctrl(tty, c) &&
> > 		    tty->flow.stopped && !tty->flow.tco_stopped && I_IXANY(tty) &&
> >         	    c != INTR_CHAR(tty) && c != QUIT_CHAR(tty) &&
> > 	            c != SUSP_CHAR(tty))) {
> > 			start_tty(tty);
> > 			process_echoes(tty);
> > 		}
> > ...but it will change STOP_CHAR vs START_CHAR precedence for the case 
> > where they're the same characters. I don't know if it matters.
> 
> No idea of impact of such change.

What I could do, is to create a separate change out of this outlined 
change alone so it would be possible to bisect to the very change, if it 
would cause a regression for somebody.

It doesn't feel very useful to have START_CHAR and STOP_CHAR match but 
who knows what is out there. I tested it briefly with stty and I know it 
"works" on the normal receive path (doesn't stop) but usefulness of such
a config seems rather doubtful.

One interesting difference is that here in the closing path, stop has 
higher precedence and on the normal path, start takes preference. I don't 
know if that's intentional or not.


-- 
 i.
--8323329-810036969-1649425381=:1643--
