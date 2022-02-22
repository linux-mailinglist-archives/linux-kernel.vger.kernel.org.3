Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC4F4BFE33
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 17:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233941AbiBVQMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 11:12:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbiBVQMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 11:12:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA28164D0D;
        Tue, 22 Feb 2022 08:12:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6508F61671;
        Tue, 22 Feb 2022 16:12:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12384C340E8;
        Tue, 22 Feb 2022 16:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645546342;
        bh=JbZNjB4KGWYd20a2LVQuakEsG+xsLIwMnjoAuJwYCYQ=;
        h=From:To:Cc:Subject:Date:From;
        b=DzdTjKKYVUqytA2bcMONMRNgnEZSCfzE/1M0o7D/JCJ8QlhgnneioFA17heK8aPpm
         EVANyFcNpM2O88sOWjAaG9W4XsV+J7dWZ45WsImR0Z61CkwYBH2u9yJ+NV4Ttyk+z2
         fzcp8YNKjiPRuyhlRLGPo2P3y4/huznTmyg7IyimTkelJ2DpswrYXHUOJCZXbzhXqn
         3/7RAQry00vDRH1XdknLs9QB0q2ENbqxJ4S8nW3ub8RriCI1/PMG8tT4Jy7cgbIJnz
         1FbjL2hPY7sP8lDOcjlxXd9m6uSzGeymu9mrt9iR6mWNuuhQcLrBCHcFWY51bgF0Fu
         PFtf10CV9we5g==
From:   broonie@kernel.org
To:     Kalle Valo <kvalo@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Wireless <linux-wireless@vger.kernel.org>
Cc:     Ilan Peer <ilan.peer@intel.com>,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        Johannes Berg <johannes.berg@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the wireless-next tree with the origin tree
Date:   Tue, 22 Feb 2022 16:12:18 +0000
Message-Id: <20220222161218.4028508-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the wireless-next tree got a conflict in:

  net/mac80211/mlme.c

between commit:

  a72c01a94f1d2 ("mac80211: mlme: check for null after calling kmemdup")

from the origin tree and commit:

  820acc810fb6e ("mac80211: Add EHT capabilities to association/probe request")

from the wireless-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc net/mac80211/mlme.c
index 20b57ddf149c4,197cad4a2768a..0000000000000
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@@ -671,7 -692,49 +692,49 @@@ static void ieee80211_add_he_ie(struct 
  	ieee80211_ie_build_he_6ghz_cap(sdata, skb);
  }
  
+ static void ieee80211_add_eht_ie(struct ieee80211_sub_if_data *sdata,
+ 				 struct sk_buff *skb,
+ 				 struct ieee80211_supported_band *sband)
+ {
+ 	u8 *pos;
+ 	const struct ieee80211_sta_he_cap *he_cap;
+ 	const struct ieee80211_sta_eht_cap *eht_cap;
+ 	struct ieee80211_chanctx_conf *chanctx_conf;
+ 	u8 eht_cap_size;
+ 	bool reg_cap = false;
+ 
+ 	rcu_read_lock();
+ 	chanctx_conf = rcu_dereference(sdata->vif.chanctx_conf);
+ 	if (!WARN_ON_ONCE(!chanctx_conf))
+ 		reg_cap = cfg80211_chandef_usable(sdata->wdev.wiphy,
+ 						  &chanctx_conf->def,
+ 						  IEEE80211_CHAN_NO_HE |
+ 						  IEEE80211_CHAN_NO_EHT);
+ 	rcu_read_unlock();
+ 
+ 	he_cap = ieee80211_get_he_iftype_cap(sband,
+ 					     ieee80211_vif_type_p2p(&sdata->vif));
+ 	eht_cap = ieee80211_get_eht_iftype_cap(sband,
+ 					       ieee80211_vif_type_p2p(&sdata->vif));
+ 
+ 	/*
+ 	 * EHT capabilities element is only added if the HE capabilities element
+ 	 * was added so assume that 'he_cap' is valid and don't check it.
+ 	 */
+ 	if (WARN_ON(!he_cap || !eht_cap || !reg_cap))
+ 		return;
+ 
+ 	eht_cap_size =
+ 		2 + 1 + sizeof(eht_cap->eht_cap_elem) +
+ 		ieee80211_eht_mcs_nss_size(&he_cap->he_cap_elem,
+ 					   &eht_cap->eht_cap_elem) +
+ 		ieee80211_eht_ppe_size(eht_cap->eht_ppe_thres[0],
+ 				       eht_cap->eht_cap_elem.phy_cap_info);
+ 	pos = skb_put(skb, eht_cap_size);
+ 	ieee80211_ie_build_eht_cap(pos, he_cap, eht_cap, pos + eht_cap_size);
+ }
+ 
 -static void ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
 +static int ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
  {
  	struct ieee80211_local *local = sdata->local;
  	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
