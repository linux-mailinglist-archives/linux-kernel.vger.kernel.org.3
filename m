Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 926BF53FEE6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 14:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243834AbiFGMgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 08:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243821AbiFGMgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 08:36:05 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A01C509D;
        Tue,  7 Jun 2022 05:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654605365; x=1686141365;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=LKum10K4tBKordUqJVSe2dQMizH1jkij74BmVhgNhM0=;
  b=klm4PHmKuSNJKi67IymNsGqZE2bp2tX3a7Ph5yMtDvy7S7X7Q0xcT3+G
   TdN1qKweIfM3X23r0wCymU9duTXHXYw48+QTUd3Jy9BvZCkje3Arm3rqx
   daDv8ba1Hl80tV1Nc8+osCUa4Cvq6wQfBiYKlRhuE1mKmrYyqn+h2TS1T
   zRHTG72Ntn3uJcCCorbJ0RrjeUlR/gOIML0NDsMG2cr+ObkgqABOFghuQ
   NpxKCb4wzzy/jODXJGxPMRccnkaC+T/ggIXtDqQ0X0A/R/34pkNMiY70t
   L3cARvTeRmaQhesluyC1YNES3+5/NycGpDI5VopV+/O4UACNvu3lWPg/j
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="275494800"
X-IronPort-AV: E=Sophos;i="5.91,283,1647327600"; 
   d="scan'208";a="275494800"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 05:36:04 -0700
X-IronPort-AV: E=Sophos;i="5.91,283,1647327600"; 
   d="scan'208";a="636107823"
Received: from akmessan-mobl1.amr.corp.intel.com ([10.251.214.146])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 05:36:03 -0700
Date:   Tue, 7 Jun 2022 15:36:01 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jiri Slaby <jslaby@suse.cz>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 02/36] tty/vt: consolemap: rename and document struct
 uni_pagedir
In-Reply-To: <20220607104946.18710-2-jslaby@suse.cz>
Message-ID: <46cbc044-5157-65d8-65f0-2ecbee908150@linux.intel.com>
References: <20220607104946.18710-1-jslaby@suse.cz> <20220607104946.18710-2-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Jun 2022, Jiri Slaby wrote:

> struct uni_pagedir contains 32 unicode page directories, so the name of
> the structure is a bit misleading. Rename the structure to uni_pagedict,
> so it looks like this:
> struct uni_pagedict
>   -> 32 page dirs
>      -> 32 rows
>        -> 64 glyphs
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> ---

The rename looks incomplete:

>  drivers/tty/vt/consolemap.c    | 47 ++++++++++++++++++++--------------
>  drivers/video/console/vgacon.c |  4 +--
>  include/linux/console_struct.h |  6 ++---
>  3 files changed, 33 insertions(+), 24 deletions(-)

vs

$ git grep -l vc_uni_pagedir
drivers/tty/vt/consolemap.c
drivers/tty/vt/vt.c
drivers/usb/misc/sisusbvga/sisusb_con.c
drivers/video/console/vgacon.c
drivers/video/fbdev/core/fbcon.c
include/linux/console_struct.h
$

???


-- 
 i.

