Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF6054662A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 14:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346859AbiFJMCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 08:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233652AbiFJMCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 08:02:18 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C6D3E0E7;
        Fri, 10 Jun 2022 05:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654862537; x=1686398537;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CF4rL1niuSX8BlxbQ2DWT+o2UndchjX+l6DFPinEiIM=;
  b=FFbuVGK1iQEhJaI0Up6X3jhd/YVi5dE6A5UfPi1/FVPA3JIjH/sIt9vz
   zjUbKv+o5zPRX0u+8+5D/6g0XldiEmAWu68MLWtTiQbO2Qyey2jnWmbno
   tf62KkTosq6PduBtToaGxm9zvG7P3VzTTBg2+fmBtXJ/8wuN/YRkmar0T
   mO9KNEyZEHzOwbYTUEAwLMf8YkwMUoMYniB0t9bu4Ah8KB3n9VCgiOtCl
   dpc9I94uF3JX8A6/r3/JcvYe52atBL3+X0tJ4rHmqHFgzpWG+GJDB6B14
   EcqADrNHiHmn8yVoOUUJ4T2ct/F9p2Z+Sy46XIxJA4LwRQagoS51fcgPm
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="257441262"
X-IronPort-AV: E=Sophos;i="5.91,290,1647327600"; 
   d="scan'208";a="257441262"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 05:02:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,290,1647327600"; 
   d="scan'208";a="724937990"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 10 Jun 2022 05:02:13 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 10 Jun 2022 15:02:13 +0300
Date:   Fri, 10 Jun 2022 15:02:13 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Xin Ji <xji@analogixsemi.com>, Guenter Roeck <linux@roeck-us.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        bliang@analogixsemi.com, qwen@analogixsemi.com,
        jli@analogixsemi.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v9 1/3] usb: typec: tcpci: move tcpci.h to
 include/linux/usb/
Message-ID: <YqMyxQGzPSs/HwVi@kuha.fi.intel.com>
References: <20220309023404.1221453-1-xji@analogixsemi.com>
 <YqMaUroS87rjnCny@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqMaUroS87rjnCny@kroah.com>
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 12:17:54PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Mar 09, 2022 at 10:34:01AM +0800, Xin Ji wrote:
> > USB PD controllers which consisting of a microcontroller (acting as the TCPM)
> > and a port controller (TCPC) - may require that the driver for the PD
> > controller accesses directly also the on-chip port controller in some cases.
> > 
> > Move tcpci.h to include/linux/usb/ is convenience access TCPC registers.
> > 
> > Signed-off-by: Xin Ji <xji@analogixsemi.com>
> > 
> > ---
> > V8 -> V9: Add more commit message
> > V7 -> V8: Fix Guanter's comment, remove unnecessary explain
> > 
> > Signed-off-by: Xin Ji <xji@analogixsemi.com>
> > ---
> >  drivers/usb/typec/tcpm/tcpci.c                        | 3 +--
> >  drivers/usb/typec/tcpm/tcpci_maxim.c                  | 3 +--
> >  drivers/usb/typec/tcpm/tcpci_mt6360.c                 | 3 +--
> >  drivers/usb/typec/tcpm/tcpci_rt1711h.c                | 2 +-
> >  {drivers/usb/typec/tcpm => include/linux/usb}/tcpci.h | 1 +
> >  5 files changed, 5 insertions(+), 7 deletions(-)
> >  rename {drivers/usb/typec/tcpm => include/linux/usb}/tcpci.h (99%)
> 
> I need an ack by the typec maintainers/developers before I can take this
> (hint...)

I'm sorry for the delayed response.

Xin, you need to rebase this. It does not apply cleanly anymore.

thanks,

-- 
heikki
