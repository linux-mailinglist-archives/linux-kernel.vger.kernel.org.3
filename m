Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B17FE52A00E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 13:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345014AbiEQLI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 07:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344950AbiEQLI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 07:08:27 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D516452;
        Tue, 17 May 2022 04:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652785701; x=1684321701;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XUGgIusaR1c/M+hdwMIEtCQbJlvmDStPf6Do24whbYo=;
  b=g0SGF6+1jLD5ChJNsN/azBflOJ9omaDJW09IIEkJHTpP7NqnBn62X7l3
   um7fK98AdOShq7wLDsVCnm3pZwAAUSeJZU4k0VSDS4xlYmrMIO52gBIzT
   8dGIsblieR2w2rM35Rug+quTv86jIzL2eKHSsXBb7YsAObSFyhgRhIpWx
   jfYsyTDmbcSPi8scXnuBrtnfn6hltkHXuZdL7OhfbGLOhLj/kt8G58w8F
   uiBw/vVIiwlopvQFYfPO+qzn5fDBttMcxvkh7aLdu0orgBx9RFrAxDBJX
   JJqw0SGjdoCPL2NrkXvas1PD3SsqoKIEYzYLvnvsNkKDW/wQERFwSA87A
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="271268777"
X-IronPort-AV: E=Sophos;i="5.91,232,1647327600"; 
   d="scan'208";a="271268777"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 04:08:21 -0700
X-IronPort-AV: E=Sophos;i="5.91,232,1647327600"; 
   d="scan'208";a="568831117"
Received: from mtarral-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.52.88])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 04:08:18 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Srinivas Kandagatla <srinivas.kandagatla@st.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 7/9] serial: st-asc: Sanitize CSIZE and correct PARENB for CS7
Date:   Tue, 17 May 2022 14:07:35 +0300
Message-Id: <20220517110737.37148-8-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220517110737.37148-1-ilpo.jarvinen@linux.intel.com>
References: <20220517110737.37148-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only CS7 and CS8 seem supported but CSIZE is not sanitized from CS5 or
CS6 to CS8. In addition, ASC_CTL_MODE_7BIT_PAR suggests that CS7 has
to have parity, thus add PARENB.

Incorrect CSIZE results in miscalculation of the frame bits in
tty_get_char_size() or in its predecessor where the roughly the same
code is directly within uart_update_timeout().

Cc: Srinivas Kandagatla <srinivas.kandagatla@st.com>
Fixes: c4b058560762 (serial:st-asc: Add ST ASC driver.)
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/st-asc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
index d7fd692286cf..1b0da603ab54 100644
--- a/drivers/tty/serial/st-asc.c
+++ b/drivers/tty/serial/st-asc.c
@@ -535,10 +535,14 @@ static void asc_set_termios(struct uart_port *port, struct ktermios *termios,
 	/* set character length */
 	if ((cflag & CSIZE) == CS7) {
 		ctrl_val |= ASC_CTL_MODE_7BIT_PAR;
+		cflag |= PARENB;
 	} else {
 		ctrl_val |= (cflag & PARENB) ?  ASC_CTL_MODE_8BIT_PAR :
 						ASC_CTL_MODE_8BIT;
+		cflag &= ~CSIZE;
+		cflag |= CS8;
 	}
+	termios->c_cflag = cflag;
 
 	/* set stop bit */
 	ctrl_val |= (cflag & CSTOPB) ? ASC_CTL_STOP_2BIT : ASC_CTL_STOP_1BIT;
-- 
2.30.2

