Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0555A11BE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 15:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242373AbiHYNSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 09:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233371AbiHYNR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 09:17:56 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6518A1F2EC;
        Thu, 25 Aug 2022 06:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661433475; x=1692969475;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5Tkt0emKTD/W/l04ivHhimAciuJqMZHXGJRNb9l5I0c=;
  b=IEsjrnc3Fl8Jszb/HkeD+ZwO+aYy5KPBTpv+Uyasa2xes62OjrnpN+8s
   7EI86Eh1gjuY+nceSgGZ17LyJQyo0kVuOPCNWdnat2s6zOT7Rl9dhYBm9
   zP7pUYXH7/HCva/Mouho/ZcKb1rhjcog1rAuMPxC1h7mMhib6HTpLoYmo
   gFOovrOLO9pyHJiMMMrWIbc8d0v3Cda/c4YmzwOUJboLTDPt4QCz3+iln
   mREDM22mG8ChD4NygIb8ic7TP1OW6PUvzMPeZIP1zY/pAYBNZOZqu7GQT
   qy2Ya5phj2K24Kgx8nq2DoFEDtg5rME86Vbg1E3ytctslWxBZHQG5zzNz
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="294234910"
X-IronPort-AV: E=Sophos;i="5.93,263,1654585200"; 
   d="scan'208";a="294234910"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 06:17:55 -0700
X-IronPort-AV: E=Sophos;i="5.93,263,1654585200"; 
   d="scan'208";a="670974551"
Received: from mblazque-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.44.101])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 06:17:53 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org,
        "Maciej W . Rozycki" <macro@orcam.me.uk>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 0/2] serial: dz: UART_XMIT_SIZE/WAKEUP_CHARS cleanups
Date:   Thu, 25 Aug 2022 16:17:44 +0300
Message-Id: <20220825131746.21257-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2: 

- Make separate patch out of xmit mask change (which, in theory, is
a fix but due to lack of issue reports, likely doesn't occur for real).
- Replace also DZ_WAKEUP_CHARS with the normal WAKEUP_CHARS (matching
to n_tty_poll)

Ilpo Järvinen (2):
  serial: dz: xmit buffer is UART_XMIT_SIZE'd
  serial: dz: Remove custom DZ_WAKEUP_CHARS

 drivers/tty/serial/dz.c | 4 ++--
 drivers/tty/serial/dz.h | 3 ---
 2 files changed, 2 insertions(+), 5 deletions(-)

-- 
2.30.2

