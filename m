Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC875640EB
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 17:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbiGBPKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 11:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbiGBPKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 11:10:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9F207BC86
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 08:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656774626;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Cqp43LfXGvDDWLcjAcU0nNREspk+kElXMNXTMGJ8P1E=;
        b=F4lMUD5Wdfss+DZQLPqBh8Q7SInh8hHg2JCKe+XwVxakh6iQaOC7umpSMWP8BYoybLLOBN
        6Cv2bewxGzYJdXKMyyy0NuuzeZQVHdUuw5l2HRPKRQ/LFamv+hRdSig6kf3Nsfqu7o2EDp
        dxy+4lxjO51ssVql53afbRd4m/E3kpg=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-298-HrD-DT20O-qg_5PNpOvw5w-1; Sat, 02 Jul 2022 11:10:25 -0400
X-MC-Unique: HrD-DT20O-qg_5PNpOvw5w-1
Received: by mail-qt1-f197.google.com with SMTP id ck12-20020a05622a230c00b00304ee787b02so1756095qtb.11
        for <linux-kernel@vger.kernel.org>; Sat, 02 Jul 2022 08:10:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Cqp43LfXGvDDWLcjAcU0nNREspk+kElXMNXTMGJ8P1E=;
        b=X0S45cLH1iCeKDYOXhhRR7z5KEm/sZAdoxtzsItntB2kvdqPzQehIJxNJZ/FNZTo2W
         67tpdliNnpNKeTIKrgIFe1pjDf30JOBpnFf6Bg/A/+8e8/4aPS496pa6H6rLDf8G9+07
         e3/ev467Vwu5TpcIX3FyG1GkcQPUub6oqXwm25bbMw0HbbSkoXFVuvBUyGXF4qVGEOKl
         2K44fOaYIJkZNPhVE9/bj803ywfaEKLBPuCDJ3XpLLsdT/OvKNljLYgNKzeTMI+gI1v5
         AaEhD3DhjNslZsPiZkRcBmyS6wUz4qkG47fz3pQzmC7Pkxpp9RU9fl08Qu/qvKFo54i9
         +uOA==
X-Gm-Message-State: AJIora9kHYywNICrv8961D0/U0WLbUEP2RIvHeMxyysBuEt3qvyIY9nW
        cnvL+Mc2RbDtZdu1m1GulPOK5giW4OnNeSoT5kVSR2xxYC2g7tmgqf1fWyqDItoz0VscasFhFql
        BDp9rmk0tkWyXgMtsNuIrYMWk
X-Received: by 2002:ac8:5816:0:b0:31d:4178:5fd0 with SMTP id g22-20020ac85816000000b0031d41785fd0mr1632049qtg.253.1656774624767;
        Sat, 02 Jul 2022 08:10:24 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vl3/Ai5Vps6cqyXNHSW43QW8v5SfQxKSachr4YHT8JFyALP6kBEa7qly/qiC2VBYhdMdg8Gg==
X-Received: by 2002:ac8:5816:0:b0:31d:4178:5fd0 with SMTP id g22-20020ac85816000000b0031d41785fd0mr1632016qtg.253.1656774624536;
        Sat, 02 Jul 2022 08:10:24 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id hh10-20020a05622a618a00b003154e7466casm16292230qtb.51.2022.07.02.08.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jul 2022 08:10:23 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     gregory.greenman@intel.com, kvalo@kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        nathan@kernel.org, ndesaulniers@google.com,
        luciano.coelho@intel.com, ayala.barazani@intel.com,
        miriam.rachel.korenblit@intel.com, johannes.berg@intel.com,
        matt.chen@intel.com
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] iwlwifi: mvm: return an error if setting tbl_rev fails
Date:   Sat,  2 Jul 2022 11:10:20 -0400
Message-Id: <20220702151020.2524220-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang static analysis reports
drivers/net/wireless/intel/iwlwifi/fw/acpi.c:1048:17: warning: Assigned value is garbage or undefined [core.uninitialized.Assign]
        fwrt->ppag_ver = tbl_rev;
                       ^ ~~~~~~~
tbl_rev is optionaly set by a series of calls to iwl_acpi_get_wifi_pkg()
and then jumping to the read_table when a call is successful.  The
error case when all the call fails is not handled.  On all failed,
the code flow falls through to the read_table label.  Add an error
handler for the all fail case.

Fixes: e8e10a37c51c ("iwlwifi: acpi: move ppag code from mvm to fw/acpi")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index e6d64152c81a..1ef1e26c3206 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -1044,6 +1044,9 @@ int iwl_acpi_get_ppag_table(struct iwl_fw_runtime *fwrt)
 		goto read_table;
 	}
 
+	ret = -EINVAL;
+	goto out_free;
+
 read_table:
 	fwrt->ppag_ver = tbl_rev;
 	flags = &wifi_pkg->package.elements[1];
-- 
2.27.0

