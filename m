Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDCEC5A443E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 09:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiH2Hyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 03:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiH2Hyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 03:54:50 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5695733C;
        Mon, 29 Aug 2022 00:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661759685; x=1693295685;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=uhfM4FMyio5yjxkYsMjEEFg25zVlMYOjq0nAPNvUpuA=;
  b=EKqFIdi3mmkrlI/3xGqGN8J889YbRJH+3OnabuCefpe28m1gG5L9Rfg9
   nvnrHjjzdx9N1a2G8VMH6xXrXm0tP91iqgD8r1UJxCYLHddBwUwkQEhyn
   23mP/T2l0h9Tf1YN9bXDI5rAIyZVWAsUZbUzavGfjqteZPgZoluCxSN5z
   0fSJzAO5XrAjLp0VaDxgRoeRsSXEMFLNRMFeaVKqFjrs9FCsQu17DUy7S
   1Flf5GjVC/mLTsAhPBXPJEOEXpgZobJ1SsMmOKoiGVR0HfboL8fzhEtW1
   EJl3s5K1HUaokKQA3AQkmmqQTezjGHFAscJuy6v8cHSFDUS+al0DY9sFc
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10453"; a="295613349"
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="295613349"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 00:54:44 -0700
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="672283236"
Received: from kvehmane-mobl1.ger.corp.intel.com ([10.251.220.41])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 00:54:43 -0700
Date:   Mon, 29 Aug 2022 10:54:43 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jiri Slaby <jirislaby@kernel.org>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] serial: Add uart_xmit_advance() + fixes part (of a
 larger patch series)
In-Reply-To: <1a05800e-a3c2-12f3-135e-b81a283d71a2@kernel.org>
Message-ID: <e4a25dfa-a2f9-5165-2f39-1730476c5220@linux.intel.com>
References: <20220825091707.8112-1-ilpo.jarvinen@linux.intel.com> <ac383256-65f2-e4ee-0142-65bdb9dd9dae@kernel.org> <55cf3faf-2616-09c-57c3-35e7b11e55@linux.intel.com> <1a05800e-a3c2-12f3-135e-b81a283d71a2@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-669509969-1661759686=:1928"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-669509969-1661759686=:1928
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 29 Aug 2022, Jiri Slaby wrote:

> On 29. 08. 22, 9:41, Ilpo Järvinen wrote:> Looking into your patches, they
> also seemed to lack that> icount.tx++ thing.
> 
> Perhaps, you only overlooked it?
> 
> +	for (; (for_test) && (!tx_ready || tx_ready(port));
> +			(for_post), port->icount.tx++) {		

Ah, yes, I did (and its placement at the end of a multi-line for() didn't 
help that much either for pick it up :-)).

-- 
 i.

--8323329-669509969-1661759686=:1928--
