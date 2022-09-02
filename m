Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC535AB501
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 17:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236175AbiIBPX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 11:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235495AbiIBPXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 11:23:39 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE86C27FF5;
        Fri,  2 Sep 2022 07:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662130606; x=1693666606;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=SqK+KES9Kef0oX5qHsG81CZHcrCq/64MccAPPJRXZy8=;
  b=VaY3NGSn+OVbm/gFjQk5fZtdYh2N/IiVzF5+HffmEVfiAU+gWeOzWT/5
   5QgrRdsYXU+s38zOlxOuqhrNSbrRwpYSlexM1pX6osswK2rFtWjeLIzyf
   qyD1D2pad/ka/DIzjB4bCwAt/Tk1q4VEm/FBRFuOrTflFoHAUKQCqzGDW
   Ap9FIpbFDABrS1JQ5Mpciurbtjug2yGXzeltkepBRy/X053N0YxXQb/5e
   lwA3IV16LqEonKtJPLBQpm1ff9XuRX61Fr2xjYgt2lSQeSvgGJYb2k0Z5
   75/NbHFRMyt62yNcUybvmpXKMS7tBj9Z/qXnASiS5UKw6KejUSKFCh2fp
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10458"; a="296002859"
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="296002859"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 07:56:45 -0700
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="674379798"
Received: from vbykovni-mobl.ger.corp.intel.com ([10.252.53.17])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 07:56:41 -0700
Date:   Fri, 2 Sep 2022 17:56:40 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jiri Slaby <jslaby@suse.cz>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        =?ISO-8859-15?Q?Pali_Roh=E1r?= <pali@kernel.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 3/3] tty: serial: use
 DEFINE_UART_PORT_TX_HELPER_LIMITED()
In-Reply-To: <20220901110657.3305-4-jslaby@suse.cz>
Message-ID: <f45fab19-5034-cd9c-4133-ed74e5888193@linux.intel.com>
References: <20220901110657.3305-1-jslaby@suse.cz> <20220901110657.3305-4-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1404598877-1662130606=:1647"
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1404598877-1662130606=:1647
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 1 Sep 2022, Jiri Slaby wrote:

> DEFINE_UART_PORT_TX_HELPER_LIMITED() is a new helper to send characters
> to the device. Use it in these drivers.
> 
> mux.c also needs to define tx_done(). But I'm not sure if the driver
> really wants to wait for all the characters to dismiss from the HW fifo
> at this code point. Hence I marked this as FIXME.

Indeed, it seems odd.

This change looked good to me but I'll give my rev-by only after seeing 
the next version.

-- 
 i.


> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: bcm-kernel-feedback-list@broadcom.com
> Cc: "Pali Rohár" <pali@kernel.org>
> Cc: Kevin Cernekee <cernekee@gmail.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Orson Zhai <orsonzhai@gmail.com>
> Cc: Baolin Wang <baolin.wang7@gmail.com>
> Cc: Chunyan Zhang <zhang.lyra@gmail.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: linux-riscv@lists.infradead.org

--8323329-1404598877-1662130606=:1647--
