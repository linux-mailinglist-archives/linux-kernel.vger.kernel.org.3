Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEFD54EBE89
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 12:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245283AbiC3KUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 06:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245281AbiC3KUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 06:20:52 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A2FA1B9FF2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 03:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648635546; x=1680171546;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VqIMoe4rh2AjjLMYqjy6/8H3f5VE/vhYCDYIcqeiaJE=;
  b=MKq0B/J6w6hNNedFaYSg4P8+H6+ctb6aG0/k0A1viAX7SXdqVbWauyos
   E7lazEArAsJzbQU/G/dwkHOG8969AjETRuzvf/fkfdODuiP27Jq8Rd8pV
   gmJ6aXooSe53YAcWln2Tvc2yB1SJf3BNCtoL7QjGJFcBXalllyGxYmdwX
   CCPf5wEa17569EcUwm2ZiiwAYScLQ2x74QJAKHILLbFJlAaaFyx7XBsYp
   sqhmfAUGNJ7a6a1JcTAmHcUofp32GX2ArKzVH/UY1DAIQqxa5V5ykqZYt
   aab7/xBh1K5kMf+AARud3kXjiiP35tILnn6xHsKwdHJAZ77t0LAB2jQuq
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="259692265"
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="259692265"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 03:19:06 -0700
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="521838632"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 03:19:02 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 30 Mar 2022 13:18:59 +0300
Date:   Wed, 30 Mar 2022 13:18:59 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Brad Campbell <lists2009@fnarfbargle.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Apple Thunderbolt Display chaining
Message-ID: <YkQuk7E8AbSEiw59@lahna>
References: <acbb3a86-ea15-47ec-90fa-72fbd94921b1@fnarfbargle.com>
 <YkLt+/kJ54fwCYgy@lahna>
 <0249a7da-9237-806b-b267-7911ad40f4a0@fnarfbargle.com>
 <YkMC4XnfIZix6kBn@lahna>
 <b8894440-41b1-edef-dd2d-5bafabc6fb62@fnarfbargle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8894440-41b1-edef-dd2d-5bafabc6fb62@fnarfbargle.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Mar 29, 2022 at 10:06:35PM +0800, Brad Campbell wrote:
> > Indeed, I did not add this to the "discovery" path yet.
> > 
> > I wonder what happens if you change this:
> > 
> > +       tunnel = tb_tunnel_alloc_dp(tb, in, out, available_up, available_down,
> > +                                   first ? 0 : 1);
> > 
> > to this in your tree:
> > 
> > +       tunnel = tb_tunnel_alloc_dp(tb, in, out, available_up, available_down,
> > +                                   first ? 1 : 0);
> > 
> 
> Here's where it gets all "Apple..y". On the iMac this does the job no matter which
> port the chain is plugged into. Boots and displays correctly first time, every time.
> 
> It turns out on the laptop, one port works and the other doesn't. Changing the order
> simply changes which port works. So I assume the EFI sets up the first display using
> the first lane if it's in the first port, and the second if it's in the second.
> 
> That means had I managed to perform the first test in the "other port" consistently,
> it would have worked there also.

Can you try the below patch too? I hard-code the lane based on the
DP adapter number in TBT gen1.

Let's first figure out proper solution to this issue and then look at
the other one.

diff --git a/drivers/thunderbolt/tunnel.c b/drivers/thunderbolt/tunnel.c
index a473cc7d9a8d..97d36a7bb527 100644
--- a/drivers/thunderbolt/tunnel.c
+++ b/drivers/thunderbolt/tunnel.c
@@ -865,6 +865,7 @@ struct tb_tunnel *tb_tunnel_alloc_dp(struct tb *tb, struct tb_port *in,
 	struct tb_tunnel *tunnel;
 	struct tb_path **paths;
 	struct tb_path *path;
+	int link_nr;
 
 	if (WARN_ON(!in->cap_adap || !out->cap_adap))
 		return NULL;
@@ -883,22 +884,32 @@ struct tb_tunnel *tb_tunnel_alloc_dp(struct tb *tb, struct tb_port *in,
 
 	paths = tunnel->paths;
 
+	/*
+	 * Hard code the lane for both DP IN adapters in first
+	 * generation hardware. This should follow what the Apple boot
+	 * firmware does.
+	 */
+	if (in->sw->generation == 1)
+		link_nr = in->port == 11 ? 1 : 0;
+	else
+		link_nr = 0;
+
 	path = tb_path_alloc(tb, in, TB_DP_VIDEO_HOPID, out, TB_DP_VIDEO_HOPID,
-			     1, "Video");
+			     link_nr, "Video");
 	if (!path)
 		goto err_free;
 	tb_dp_init_video_path(path);
 	paths[TB_DP_VIDEO_PATH_OUT] = path;
 
 	path = tb_path_alloc(tb, in, TB_DP_AUX_TX_HOPID, out,
-			     TB_DP_AUX_TX_HOPID, 1, "AUX TX");
+			     TB_DP_AUX_TX_HOPID, link_nr, "AUX TX");
 	if (!path)
 		goto err_free;
 	tb_dp_init_aux_path(path);
 	paths[TB_DP_AUX_PATH_OUT] = path;
 
 	path = tb_path_alloc(tb, out, TB_DP_AUX_RX_HOPID, in,
-			     TB_DP_AUX_RX_HOPID, 1, "AUX RX");
+			     TB_DP_AUX_RX_HOPID, link_nr, "AUX RX");
 	if (!path)
 		goto err_free;
 	tb_dp_init_aux_path(path);
