Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 868CF4EAC59
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 13:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235863AbiC2Ld0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 07:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235975AbiC2LdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 07:33:18 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3232498AC
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 04:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648553495; x=1680089495;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=utBkeacfGMIfOPSIJj8rHnu8azMNfIstfAKzpmCF0gY=;
  b=X14q5YoUYefYAcragtGHI06ZYdrTw5Atn9q3VY8kOFcZ4xlW5qPYbDWY
   E5fbRAcxEgzk+sotDFQvVY0+TSUNZrUv71WExTJ//g3/KdzSUfpkYuc43
   CCokRH2WMIL840fd0iTX1d2afIZCCgvyewIa6m39x/5SDnDj++n38pZp1
   ykiO3ilXQSQDWkfgcTHJcKGLdSaxl+gpItlrO3jLshDumolpkA97CqY/Z
   yJdKOZlJyWfnxug1h/13ccrt/o8Iz1v5DxJKY3PiN1Gcaq2gF81Os4gMB
   O5ie1wa4nDXQpzNHgvfwLXbfYAzy9rVWzcVCpbAyRFUHy4UJnXg89P+nR
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="241380277"
X-IronPort-AV: E=Sophos;i="5.90,220,1643702400"; 
   d="scan'208";a="241380277"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 04:31:12 -0700
X-IronPort-AV: E=Sophos;i="5.90,220,1643702400"; 
   d="scan'208";a="518874332"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 04:31:10 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 29 Mar 2022 14:31:07 +0300
Date:   Tue, 29 Mar 2022 14:31:07 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Brad Campbell <lists2009@fnarfbargle.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Apple Thunderbolt Display chaining
Message-ID: <YkLt+/kJ54fwCYgy@lahna>
References: <acbb3a86-ea15-47ec-90fa-72fbd94921b1@fnarfbargle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acbb3a86-ea15-47ec-90fa-72fbd94921b1@fnarfbargle.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Mar 29, 2022 at 07:09:36PM +0800, Brad Campbell wrote:
> G'day Mika,
> 
> Back in 2019 you assisted me with an issue on an iMac with a "Light Ridge"
> controller running a pair of Apple 27" Thunderbolt displays. At the time I
> commented they worked when plugged into a port each, however they don't work
> when chained.
> 
> Back then things crashed horribly. Now they don't crash, and the PCI devices
> all work but there is an issue with the display.
> 
> I'm currently testing on vanilla git-head commit
> ae085d7f9365de7da27ab5c0d16b12d51ea7fca9 (Sunday March 27th). A recent
> kernel with all the "for 5.18" patches.
> 
> On both the iMac with the "Light Ridge" controller and a MacBookPro with a
> "Falcon Ridge" controller the result is the same.
> 
> Plugged into a port each, they work perfectly.

Right, this is because both get their own 10Gb/s lane.

> If I chain them, the first one plugged in works and when the second is
> plugged in it's almost like the link is being starved of bandwidth.
> Graphical displays like a desktop, or a terminal break up, tear or exhibit
> almost white noise/snow on both displays. Solid colours with no gradient
> sometimes displays cleanly until something else is displayed and then it
> breaks up.

I think this is related to bandwidth management. When you chain two TBT1
devices you end up having a single 10Gb/s lane used for both DisplayPort
tunnels (this is how Linux does it now). There are no hardware mechanism
to negotiate the bandwidth so the first DP tunnel gets dominated over
the second one.

I'm not entirely sure how macOS handles this. It may be that it uses one
lane for both PCIe and first DP tunnel and the second lane for the
second DP tunnel where as Linux just puts all DP through the second
lane.

The below completely untested hack patch tries to use different lane for
both tunnels. Can you try it out?

diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index cbd0ad85ffb1..6ea4968d3629 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -871,6 +871,7 @@ static void tb_tunnel_dp(struct tb *tb)
 	struct tb_cm *tcm = tb_priv(tb);
 	struct tb_port *port, *in, *out;
 	struct tb_tunnel *tunnel;
+	bool first = true;
 
 	if (!tb_acpi_may_tunnel_dp()) {
 		tb_dbg(tb, "DP tunneling disabled, not creating tunnel\n");
@@ -891,6 +892,7 @@ static void tb_tunnel_dp(struct tb *tb)
 
 		if (tb_port_is_enabled(port)) {
 			tb_port_dbg(port, "in use\n");
+			first = false;
 			continue;
 		}
 
@@ -943,7 +945,8 @@ static void tb_tunnel_dp(struct tb *tb)
 	tb_dbg(tb, "available bandwidth for new DP tunnel %u/%u Mb/s\n",
 	       available_up, available_down);
 
-	tunnel = tb_tunnel_alloc_dp(tb, in, out, available_up, available_down);
+	tunnel = tb_tunnel_alloc_dp(tb, in, out, available_up, available_down,
+				    first ? 0 : 1);
 	if (!tunnel) {
 		tb_port_dbg(out, "could not allocate DP tunnel\n");
 		goto err_reclaim;
diff --git a/drivers/thunderbolt/tunnel.c b/drivers/thunderbolt/tunnel.c
index a473cc7d9a8d..717136d649e2 100644
--- a/drivers/thunderbolt/tunnel.c
+++ b/drivers/thunderbolt/tunnel.c
@@ -860,7 +860,7 @@ struct tb_tunnel *tb_tunnel_discover_dp(struct tb *tb, struct tb_port *in,
  */
 struct tb_tunnel *tb_tunnel_alloc_dp(struct tb *tb, struct tb_port *in,
 				     struct tb_port *out, int max_up,
-				     int max_down)
+				     int max_down, int link_nr)
 {
 	struct tb_tunnel *tunnel;
 	struct tb_path **paths;
@@ -884,21 +884,21 @@ struct tb_tunnel *tb_tunnel_alloc_dp(struct tb *tb, struct tb_port *in,
 	paths = tunnel->paths;
 
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
diff --git a/drivers/thunderbolt/tunnel.h b/drivers/thunderbolt/tunnel.h
index 03e56076b5bc..b5bcbe5763ab 100644
--- a/drivers/thunderbolt/tunnel.h
+++ b/drivers/thunderbolt/tunnel.h
@@ -72,7 +72,7 @@ struct tb_tunnel *tb_tunnel_discover_dp(struct tb *tb, struct tb_port *in,
 					bool alloc_hopid);
 struct tb_tunnel *tb_tunnel_alloc_dp(struct tb *tb, struct tb_port *in,
 				     struct tb_port *out, int max_up,
-				     int max_down);
+				     int max_down, int link_nr);
 struct tb_tunnel *tb_tunnel_alloc_dma(struct tb *tb, struct tb_port *nhi,
 				      struct tb_port *dst, int transmit_path,
 				      int transmit_ring, int receive_path,
