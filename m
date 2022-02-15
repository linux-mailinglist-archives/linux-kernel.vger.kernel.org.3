Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 948474B6C7F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 13:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237981AbiBOMoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 07:44:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237944AbiBOMoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 07:44:00 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADC7193E8;
        Tue, 15 Feb 2022 04:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644929005; x=1676465005;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yvmj8JjhwTJn4uYxWDD3+eNoUbMnV/p5cwCro3/3IKs=;
  b=QZcMMbLaaQOIVl++D8aCBNz3vrmhuX1a/UypNp5yXlxu4p2z50IA1rBA
   zmYtolLP8L88TdtmwoC90Zsqo9m5BDhmdYuKytwj1HarSxLJcXjCfjMVc
   IUc40H4vnMODEzmZqLeYSjoHwKXnXQw4QlgR7SCs6ev+IFL7YpxGWuk7T
   tfBsVhqLaFWDdORTmLhFRMs+4ova+GYln0JVeX+y/M+DO8j9tPYEy5TOa
   +I4FRT1fkVvSfz22+VSP5AvlvqqqJx0CgLWkyONGjeVK9+6cBcX0qm7JY
   lyKH+HyEdGAICIoo0OqcOmoq4k1i+enNYPr3AvGRILANhMBgUHGTq1s8W
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="230306049"
X-IronPort-AV: E=Sophos;i="5.88,370,1635231600"; 
   d="scan'208";a="230306049"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 04:43:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,370,1635231600"; 
   d="scan'208";a="681015719"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 15 Feb 2022 04:43:18 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 15 Feb 2022 14:43:17 +0200
Date:   Tue, 15 Feb 2022 14:43:17 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Xin Ji <xji@analogixsemi.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        bliang@analogixsemi.com, qwen@analogixsemi.com,
        jli@analogixsemi.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v5 2/2] usb: typec: anx7411: Add Analogix PD ANX7411
 support
Message-ID: <Yguf5bwRkqolW0+/@kuha.fi.intel.com>
References: <20220208091621.3680427-1-xji@analogixsemi.com>
 <20220208091621.3680427-2-xji@analogixsemi.com>
 <YgPCLopskwyQ6F4K@kuha.fi.intel.com>
 <20220215054300.GA3752727@anxtwsw-Precision-3640-Tower>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220215054300.GA3752727@anxtwsw-Precision-3640-Tower>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 01:43:00PM +0800, Xin Ji wrote:
> On Wed, Feb 09, 2022 at 03:31:26PM +0200, Heikki Krogerus wrote:
> > On Tue, Feb 08, 2022 at 05:16:21PM +0800, Xin Ji wrote:
> > > Add driver for analogix ANX7411 USB Type-C DRP port controller.
> > 
> > We already have the driver drivers/usb/typec/tcpm/tcpci.c for port
> > controllers.
> > 
> > If you need a glue layer - if there is something specific that you
> > need to do with ANX7411 that is not completely TCPC compliant - use
> > drivers/usb/typec/tcpm/tcpci_*.c as examples.
> Hi heikki, ANX7411 PD controller has 2 applications, the one has embeded
> internal firmware, the other is not have. The currently upstream patch
> is for the first way, driver mustn't use TCPCI framework(embeded firmware
> will control all the TCPCI register). The second way(erased internaly
> firmware) can work under TCPCI framework.

Ah, so it has a microcontroller. Fair enough. I'll take another
look at your patch.

thanks,

-- 
heikki
