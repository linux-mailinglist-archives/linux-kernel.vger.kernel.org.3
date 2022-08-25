Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7514D5A0A33
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 09:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234265AbiHYH1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 03:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238225AbiHYH1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 03:27:09 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D43BF4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 00:27:03 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id v4so17120135pgi.10
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 00:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=DeOoCBmYTbzbWF96BhTxAeOzrBznw/YqVHZq/NamK7c=;
        b=kctbTtHyHjVSHiLzpfNpZkNeUVECwQpwgeNOukjxiT4oiTxjYQKUUeGgGWTsEM26GL
         inkf/8v1m4y0j6kTO+4V8eh5eDXjLXOetrTrIWbjEAtz/URG3nTaYDFp2QkCw05LEp/D
         nYpNbrHq/EyqaYoq3REJe4le8AS+L5sPy9vyCHW1co7zS/1FgJ3LH3Wbbg8ZCtVhiC5w
         e98xW0gA7ZxtFw5R2OhkX1k67CyDPZgNtIWQ7s1m/C9PfocD32YoYXwV8ebWYi6VVwN8
         YCm3v/H88abUYYkMBSJECOUjrPhiRvUshpx1xCF4F+SMWN72MOp5K+8h/2wVFLrPX0zN
         0LKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=DeOoCBmYTbzbWF96BhTxAeOzrBznw/YqVHZq/NamK7c=;
        b=1VPBFHv72MDEXBSapBHwE18zWF6jIIoCjD0Lf1KDznh4OzIPlaqbxIWE/V0fKZ/Dsp
         YsKUH86Ov84i/grzyWq5gbpVET3VJOvdAJ3X93bV7lnkt8dcFCVFHdtVJ1kjFkYriNwv
         tuyaudnvekdtplF0gO/GnvG8EsMWuvAaDroiMSzIkXqQdkPw22pU1MCjAV1XMWfGD651
         VRaJK3oxzOUAmMCwgIWnnzsZl00MGj/ZquCqwaK7vVDHMuHtnpGoEVVwttlCjNq78KFk
         Th+ZErJ5ykP0eymGqU4Diiv3fcJlKIXztnXyKujvkkUE9C5FQpVHWGhG9krXX4+8pPnv
         JY/w==
X-Gm-Message-State: ACgBeo23eceqeeWLd9HtDxvOhfOrXTVCceA4rXzo7QkmOLneVF8YbD0U
        9nOOe97Tsx+m6de6ItjwJ2A=
X-Google-Smtp-Source: AA6agR6MH3KeKxwOkT2brR7yFR2ml8cTVD19uCi8UCGmAoH6KDDMnzxwF4Cqs2OCYj+qSqKlNT39TA==
X-Received: by 2002:a65:4d0e:0:b0:42a:88f7:d723 with SMTP id i14-20020a654d0e000000b0042a88f7d723mr2241789pgt.400.1661412422988;
        Thu, 25 Aug 2022 00:27:02 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id z124-20020a633382000000b0042aca53b4cesm6004732pgz.70.2022.08.25.00.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 00:27:02 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     mpe@ellerman.id.au
Cc:     npiggin@gmail.com, christophe.leroy@csgroup.eu,
        haren@linux.ibm.com, wangborong@cdjrlc.com, nathanl@linux.ibm.com,
        Julia.Lawall@inria.fr, nick.child@ibm.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] powerpc/pseries/vas: Remove the unneeded result variable
Date:   Thu, 25 Aug 2022 07:26:57 +0000
Message-Id: <20220825072657.229168-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Return the value vas_register_coproc_api() directly instead of storing it
in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 arch/powerpc/platforms/pseries/vas.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/vas.c b/arch/powerpc/platforms/pseries/vas.c
index 7e6e6dd2e33e..46ea4e252f97 100644
--- a/arch/powerpc/platforms/pseries/vas.c
+++ b/arch/powerpc/platforms/pseries/vas.c
@@ -501,14 +501,10 @@ static const struct vas_user_win_ops vops_pseries = {
 int vas_register_api_pseries(struct module *mod, enum vas_cop_type cop_type,
 			     const char *name)
 {
-	int rc;
-
 	if (!copypaste_feat)
 		return -ENOTSUPP;
 
-	rc = vas_register_coproc_api(mod, cop_type, name, &vops_pseries);
-
-	return rc;
+	return vas_register_coproc_api(mod, cop_type, name, &vops_pseries);
 }
 EXPORT_SYMBOL_GPL(vas_register_api_pseries);
 
-- 
2.25.1
