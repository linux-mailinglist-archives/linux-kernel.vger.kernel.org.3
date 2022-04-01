Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9434EFCFA
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 01:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353068AbiDAXIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 19:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235255AbiDAXIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 19:08:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 738761A7753
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 16:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648854415;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=jNUDi778AJUhlrN3PBTxwa1i48FL+T4gzIs+ukoa52k=;
        b=RdxQ+ywU6MSkGFZP8jV9gN8YZuF2RrI+0brV2uqgcYOS7zowh2LaSR6ujSFxbk6VpeICV1
        IyG/PfYlBY1RSRXlFinkdX2ZI4il9mvKr49BJ4193iG1goDqWKP0ll7J5YUPMXA6MlCj2t
        FdKsdyzWPwtX6D6/LYPP8eDEBENNwJI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-593-IZA_c2SjOwC6VHT79Cj53A-1; Fri, 01 Apr 2022 19:06:54 -0400
X-MC-Unique: IZA_c2SjOwC6VHT79Cj53A-1
Received: by mail-qk1-f200.google.com with SMTP id d12-20020a379b0c000000b0067d8cda1aaaso2832126qke.8
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 16:06:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jNUDi778AJUhlrN3PBTxwa1i48FL+T4gzIs+ukoa52k=;
        b=4iv/CVP4Q7EZeONmFizTpxHDN2fZ31q8UCl3XmF6/0gPLf1FgRlEgrpBNKZbSnYTGm
         mU7sMXbNqXBXl9iC4ZT+cS1ZclsA0NF/g0BI/hc8BVvaqT/Ufw2/DJRPeb6sX3SZnDdX
         WaMPuaacGRHbuxWeQNcyIiIff5nU2vaBAkV1B8+/S4skNMy5vtiFBQoQ2nqtUiEt4gQE
         dGQu7Qgx0HzJf52tlRW/8CcilL1FZZ4bFcNwwRHdjFcga21uYlJCcG6Ug0T36FFDjB+e
         Tzi8CX1Q4tgSlhMtDSqc6L7Kvli6AJ6Ji0PoCeuhOj93WYj3mrCGjCu/z31thoHIpt1W
         pw5w==
X-Gm-Message-State: AOAM530NTVeWpwU+PInNq6QdNpeyHpupckQ3RaNc4kyUqB8ocfUVk/Pr
        9vLZmSIwDCT0NRAArq773KvWpd6a57eFCG8PKKMvXOIqSu89YpQlZpmaJSd7czIixdvNfHhUMYV
        w/Li+HVFYh+vnaRLGvIyGBuPy
X-Received: by 2002:a0c:fc46:0:b0:440:f78f:f4c4 with SMTP id w6-20020a0cfc46000000b00440f78ff4c4mr40795362qvp.108.1648854413666;
        Fri, 01 Apr 2022 16:06:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/F5Dq6Hq/AtU56gvFP3PTl65Ek+RzTn9Hp1ejEDvmMZTNZW0XxrZQHMh6L/ecLIyTztZc5A==
X-Received: by 2002:a0c:fc46:0:b0:440:f78f:f4c4 with SMTP id w6-20020a0cfc46000000b00440f78ff4c4mr40795338qvp.108.1648854413437;
        Fri, 01 Apr 2022 16:06:53 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id y11-20020ac85f4b000000b002e1e038a8fdsm2712923qta.13.2022.04.01.16.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 16:06:52 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     luciano.coelho@intel.com, kvalo@kernel.org, davem@davemloft.net,
        kuba@kernel.org, pabeni@redhat.com, nathan@kernel.org,
        ndesaulniers@google.com, johannes.berg@intel.com,
        emmanuel.grumbach@intel.com, dan.carpenter@oracle.com
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] iwlwifi: mvm: initialize seq variable
Date:   Fri,  1 Apr 2022 19:06:40 -0400
Message-Id: <20220401230640.3196196-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang static analysis reports this issue
d3.c:567:22: warning: The left operand of '>' is
  a garbage value
  if (seq.tkip.iv32 > cur_rx_iv32)
      ~~~~~~~~~~~~~ ^

seq is never initialized. Call ieee80211_get_key_rx_seq() to
initialize seq.

Fixes: 0419e5e672d6 ("iwlwifi: mvm: d3: separate TKIP data from key iteration")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index a995bba0ba81..9b190b3ce6c1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -563,6 +563,7 @@ static void iwl_mvm_wowlan_get_tkip_data(struct ieee80211_hw *hw,
 		}
 
 		for (i = 0; i < IWL_NUM_RSC; i++) {
+			ieee80211_get_key_rx_seq(key, i, &seq);
 			/* wrapping isn't allowed, AP must rekey */
 			if (seq.tkip.iv32 > cur_rx_iv32)
 				cur_rx_iv32 = seq.tkip.iv32;
-- 
2.27.0

