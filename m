Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1172355A8B0
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 12:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbiFYKSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 06:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbiFYKSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 06:18:50 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502AB3135E;
        Sat, 25 Jun 2022 03:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656152330; x=1687688330;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=gJbqmWGSWc7kbnlUxtaPxL9OQGLKwA2qsDHVxSO8y60=;
  b=BaLy4/+KpDb2uZrMNhOqQ+PdUT/aauLwoXyzGgRRKZAecOnnjLmCNrT/
   ROYjkp4OznPrYrRe/jB+b7hTlEuKerOijA753X9QXUjyawVFFWS7QS0dr
   hnf3VaTlmtw15AmjwRbtdNs5wL8NoBFgVLa8iqpBvmFlAEWTIGx3HjnQX
   RAgf61EUlsZlZb2/p0PerILQaCS1kC9+9WgN0oJg9kZ8QQbHwvWvjUM+2
   /5TGRjtA72OMbyA+Kduxck7TdAbyV+EdUqRi6YMQnTn5pu01T0WYPrpWj
   lDw76ZJXbqryeQHL5BmIK2d46tgUtDuuKE5iDopJlp7MSY0QEG6OAERHy
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10388"; a="345175299"
X-IronPort-AV: E=Sophos;i="5.92,222,1650956400"; 
   d="scan'208";a="345175299"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2022 03:18:48 -0700
X-IronPort-AV: E=Sophos;i="5.92,222,1650956400"; 
   d="scan'208";a="645650027"
Received: from selvaku-mobl.ger.corp.intel.com ([10.252.60.244])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2022 03:18:45 -0700
Date:   Sat, 25 Jun 2022 13:18:43 +0300 (EEST)
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
Subject: Re: [PATCH 8/8] serial: 8250: lpc18xx: Remove redundant sanity check
 for RS485 flags
In-Reply-To: <20220622154659.8710-9-LinoSanfilippo@gmx.de>
Message-ID: <56f9df76-5514-2aa8-54cc-f0589023fe2@linux.intel.com>
References: <20220622154659.8710-1-LinoSanfilippo@gmx.de> <20220622154659.8710-9-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1795890806-1656152328=:1653"
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

--8323329-1795890806-1656152328=:1653
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Wed, 22 Jun 2022, Lino Sanfilippo wrote:

> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> 
> Before the drivers rs485_config() function is called the serial core
> already ensures that only one of both options RTS on send or RTS after send
> is set. So remove the concerning sanity check in the driver function to
> avoid redundancy.
> 
> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-1795890806-1656152328=:1653--
