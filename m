Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7FF55A8BD
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 12:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbiFYJh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 05:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbiFYJh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 05:37:26 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31EC531DD1;
        Sat, 25 Jun 2022 02:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656149846; x=1687685846;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Hh1JhW7xdfdjw2eO3nh9s4vHirxteX9cPVbLbjkqHqw=;
  b=MxkFY1eCduUu9hXs4ljfssus8mFTpwsbl/m/aHzg11YIX0sD7fd4a1ag
   YPSFbFeywDAYJdWZCWAH1JYkrKMDXSxThopOlmBOGCuid+mer8z2LpL++
   FL9nHsybHVH1sT9CLN9UtJhyeTOIpkammABlTpBPr9mPMkwpUVVT35nkw
   JaUTcfqWUs9Gt6mFC+K5w0LNUSjvrXOtaAubikWWy3Q3sx7h8YhsoRLJB
   UyyexH2c2HxGO/t1MAFDJ23sVDRi2K2HZ+aEz9MmY0soW6mTxdRYUb98J
   agFW9K7t8SrpVguxnzVSm3y8v+DDkNR4spSjsMhRB32qLVbJLLwlwZF+R
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10388"; a="261588135"
X-IronPort-AV: E=Sophos;i="5.92,222,1650956400"; 
   d="scan'208";a="261588135"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2022 02:37:25 -0700
X-IronPort-AV: E=Sophos;i="5.92,222,1650956400"; 
   d="scan'208";a="645640629"
Received: from selvaku-mobl.ger.corp.intel.com ([10.252.60.244])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2022 02:37:22 -0700
Date:   Sat, 25 Jun 2022 12:37:13 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        vz@mleia.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, lukas@wunner.de,
        p.rosenberger@kunbus.com, Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: Re: [PATCH 3/8] serial: core: move sanitizing of RS485 delays into
 own function
In-Reply-To: <20220622154659.8710-4-LinoSanfilippo@gmx.de>
Message-ID: <fc9a10aa-a0e3-4e93-292d-b83d8dd76d36@linux.intel.com>
References: <20220622154659.8710-1-LinoSanfilippo@gmx.de> <20220622154659.8710-4-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1972244649-1656149845=:1653"
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

--8323329-1972244649-1656149845=:1653
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Wed, 22 Jun 2022, Lino Sanfilippo wrote:

> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> 
> Move the sanitizing of RS485 delays out of uart_sanitize_serial_rs485()
> into the new function uart_sanitize_serial_rs485_delays().
> 
> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-1972244649-1656149845=:1653--
