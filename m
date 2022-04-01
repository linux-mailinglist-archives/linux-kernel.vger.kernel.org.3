Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 769444EFD24
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 01:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353423AbiDAXkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 19:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351484AbiDAXkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 19:40:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ACC0E5D1BA
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 16:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648856290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=pzVHxoX5/TWOSCvHDrWIJIS9FyjyMwnU9Qnf7hNn4W4=;
        b=a51CKPeJuupeX1G2uk6iCX/5Pat+EWzx+7lzfP3irHmZsNxdF33eyVhE1VJhnJrKAY9Vyp
        oZdWm1hnvy8qtD/KuwosfOJpaLpzeApJI4qe+397fA6hUAoClB3Yf+wnjtM3YQhbtu0MT6
        2oFflB9K0s7857NwmK7Cgs+gX9RDuGE=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-393-KofzvzVVOOusuBWMqdD_Sw-1; Fri, 01 Apr 2022 19:38:09 -0400
X-MC-Unique: KofzvzVVOOusuBWMqdD_Sw-1
Received: by mail-qt1-f197.google.com with SMTP id c11-20020ac87dcb000000b002eba94b13c7so837122qte.4
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 16:38:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pzVHxoX5/TWOSCvHDrWIJIS9FyjyMwnU9Qnf7hNn4W4=;
        b=2sBydVIV/gHxSdLkDx1sIAh9dsBWxeO1UFcvKHrqVhEAEopCbhr/s2waSbhjYwhG7k
         48SmUjuEa3VyrxLrdPMcirjOZPrXw9j4VBEOrAkCxDYFX/0+tXvNu+aFDMv639ydLpVO
         VDKFY4jjjSxy9BHa4tcG/H6DMoOrwkoHcFfvh/MtL4UCfDBcBjXXzaK04PgRKNqcvlSo
         U9QmetowToAgxY/Gv+EJMsXcfhPo/s7UJZkcfJKzu9BiG0zPJr9fZ9wvQvlxcxd6pfbA
         Fim5ZI0BZBuPzyyCUNG+2HGpycH9t8lF5paVxXRKOcC0yId3xWX+D0nFcZjrjLwZJenM
         uXvw==
X-Gm-Message-State: AOAM530HYkGmMgSNi53GaRVrPa0/0QYYT6hhYhDE4QlWrbP6l5mEcoT3
        feM+1iKAqY/VTrmkxiKft23MP1uIiRO9NdW5OOqFO66DoV1VIhSuRL22t7erhJZ/xKohdTgvhId
        9VpmBgdJXPxez4HGup2jG7UO+
X-Received: by 2002:a37:65c5:0:b0:67b:3232:8cc8 with SMTP id z188-20020a3765c5000000b0067b32328cc8mr8108204qkb.170.1648856289298;
        Fri, 01 Apr 2022 16:38:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzbWdGn+H26OktJUd2PLi1j3y1cCH3LU+ahvL7e+ZzRQY1FZAfw60USIHvnPTHEoQ8KuF5wsQ==
X-Received: by 2002:a37:65c5:0:b0:67b:3232:8cc8 with SMTP id z188-20020a3765c5000000b0067b32328cc8mr8108185qkb.170.1648856289078;
        Fri, 01 Apr 2022 16:38:09 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id v18-20020a05622a189200b002e22e09d77fsm2883002qtc.59.2022.04.01.16.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 16:38:08 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     luciano.coelho@intel.com, kvalo@kernel.org, davem@davemloft.net,
        kuba@kernel.org, pabeni@redhat.com, nathan@kernel.org,
        ndesaulniers@google.com, johannes.berg@intel.com,
        mukesh.sisodiya@intel.com, mordechay.goodstein@intel.com,
        matti.gottlieb@intel.com, rotem.saado@intel.com
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] iwlwifi: fw: move memset before early return
Date:   Fri,  1 Apr 2022 19:38:02 -0400
Message-Id: <20220401233802.1710547-1-trix@redhat.com>
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

Clang static analysis reports this representative issue
dbg.c:1455:6: warning: Branch condition evaluates to
a garbage value
  if (!rxf_data.size)
       ^~~~~~~~~~~~~~

This check depends on iwl_ini_get_rxf_data() to clear
rxf_data but the function can return early without
doing the clear.  So move the memset before the early
return.

Fixes: cc9b6012d34b ("iwlwifi: yoyo: use hweight_long instead of bit manipulating")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index abf49022edbe..666de922af61 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -1388,13 +1388,13 @@ static void iwl_ini_get_rxf_data(struct iwl_fw_runtime *fwrt,
 	if (!data)
 		return;
 
+	memset(data, 0, sizeof(*data));
+
 	/* make sure only one bit is set in only one fid */
 	if (WARN_ONCE(hweight_long(fid1) + hweight_long(fid2) != 1,
 		      "fid1=%x, fid2=%x\n", fid1, fid2))
 		return;
 
-	memset(data, 0, sizeof(*data));
-
 	if (fid1) {
 		fifo_idx = ffs(fid1) - 1;
 		if (WARN_ONCE(fifo_idx >= MAX_NUM_LMAC, "fifo_idx=%d\n",
-- 
2.27.0

