Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9AE3551610
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 12:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240959AbiFTKkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 06:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240321AbiFTKj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 06:39:58 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7771403F;
        Mon, 20 Jun 2022 03:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655721597; x=1687257597;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=LeRkSVDTT0Yb76jEsTjO7SM/+tjqpDRALlVCJn6AsZE=;
  b=hlWiyWIijUeKbsV1iMXUWXvcN9YykSsTY/qm/ufJKU5ByYHjLRVwO1Qb
   IsZhIh5xOpW9yOhM5Is6bp7gCVAQQbcS3BnU9iuzjQFzUN699hzWiyB50
   eypIhhH1EoR/0mbWwVr6KMJlTv1FYmuc7AmNbKe7tX9hUDqvBUS7QTt1b
   oIW6WFmFCTdGzGMKKG55XjXkEt0PgLQ85mHnsNRfHMbK1FtAq02FpLe7V
   k1JWNlJrmFP+L+o0R5SmufE+Tpkju94wyHDDs5SzoeTc0wXSGjWTNQtEy
   hFKviBZyHdY+n58kW1eJITefCVTuM2ghY/IlmE067unjshJjS1LCahXzA
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="279911587"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="279911587"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 03:39:57 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="643056879"
Received: from lspinell-mobl1.ger.corp.intel.com ([10.251.215.169])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 03:39:54 -0700
Date:   Mon, 20 Jun 2022 13:39:52 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial <linux-serial@vger.kernel.org>
cc:     Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        =?ISO-8859-15?Q?Andreas_F=E4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-unisoc@lists.infradead.org
Subject: Re: [PATCH 5/6] cleanup: Use UART_XMIT_SIZE
In-Reply-To: <20220620103408.37454-6-ilpo.jarvinen@linux.intel.com>
Message-ID: <aa117e1a-7ec-149b-2337-db4ead968aa@linux.intel.com>
References: <20220620103408.37454-1-ilpo.jarvinen@linux.intel.com> <20220620103408.37454-6-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1889180693-1655721597=:2433"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

--8323329-1889180693-1655721597=:2433
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 20 Jun 2022, Ilpo Järvinen wrote:

> Both UART_XMIT_SIZE and SERIAL_XMIT_SIZE are defined. Make them all
> UART_XMIT_SIZE.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Grr, it seems that my internal naming to organize patches managed to leak 
into that summary on subject line. It should have been serial: obviously 
and I only noticed while git send-email was sending the bits out. :-(

-- 
 i.

--8323329-1889180693-1655721597=:2433--
