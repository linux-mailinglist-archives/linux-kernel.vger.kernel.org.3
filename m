Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 832D04CFF4F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 13:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242647AbiCGNAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 08:00:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbiCGNAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 08:00:04 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9DD5BD21
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 04:59:09 -0800 (PST)
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 90A7F3F5FA
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 12:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646657941;
        bh=Bt5u+dqRXX5TG4kpL4NYCF0+7EST57EITnb/tm+FvLo=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=fO4tnTqfah9YMraVyAMVwe7Q5vFFWVvz+t8yxJkH8pY01owT9qMTpTzLUMy3eFIYF
         f9z2oSri+vQIeDUYefh3xOo6iyqslbh2fAel3k8gQ23097bqhVaJ3mtm2d4965y5DL
         MJjPEmSbK+fraiVmVsU+uRM9WDGbYCjdyEC9P41Lik9NWidvXDTLelN5a+cyZ0XCak
         7Lq08nBglT2W6FKT/0FUdRkGYXx27+KeCY7ETrT+1SBooltqbkZGLVqB7NT++wx+Dy
         SDK6gC3oNl+CGXNshwVJBw+c2w+Yl4G9ljyP5w7MC2Qh+7nlgjlLcLqEb6ogowgk+y
         6tmZVjzbrHSeQ==
Received: by mail-pg1-f198.google.com with SMTP id 9-20020a630509000000b0037c8607d296so5759569pgf.22
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 04:59:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bt5u+dqRXX5TG4kpL4NYCF0+7EST57EITnb/tm+FvLo=;
        b=RNsu63c8cSBhGZTLNeimR0Q3YEyGxeiHb1JmOxxIJxLMSPTv+YfXh5YbZ2IYW8zQG9
         5z1LGFdEGzK2qPlKv9nBBYmeIH2jy2tSPwHZ/UmbpYkZvyXFSP5SdDpBtzB9YZLLiGa2
         ikYHOgWSK6vXQt1CwiOkLPqGi75fBKesqjSJriHb+xPR0WC0vQmQ2grd3RA+g9tU8o/O
         tBM/mT8a4KnrD+KB5nY1sXc5VSlcCHwecMMok8cn0c8RnchuPQmba4scGBknuZGJ5al3
         t4r2ukzr7967LEWNoNP5NL1LHAs8hx6Ult5WBG4Hlr3cbBx6iogoc/ydF89d8I9uHkKL
         VoJw==
X-Gm-Message-State: AOAM531y3ylszCTn2x4+sTREdvCb2lX2XqHdeZ4pRHNbOVLrPxMr90WP
        Z1D6HgABWopdYGBpQhSKrem1BxScb6a2rEoOqfeLnYL512b5Bcs8zCnuHLJ+2+N7+kPzNHicGl5
        GSjSTqDTl3a6UlFbFvUtgtzJ2qIH1CpCy+4O8PorxkA==
X-Received: by 2002:a05:6a00:a0c:b0:4f6:661e:8dda with SMTP id p12-20020a056a000a0c00b004f6661e8ddamr12438890pfh.66.1646657939792;
        Mon, 07 Mar 2022 04:58:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyy9yA/OTQvBvHKNNW5XGHzthyGWKSUTICmCcAolHezpN95KQGZU/FDyK/zmjLJcdIBCiZggg==
X-Received: by 2002:a05:6a00:a0c:b0:4f6:661e:8dda with SMTP id p12-20020a056a000a0c00b004f6661e8ddamr12438852pfh.66.1646657939280;
        Mon, 07 Mar 2022 04:58:59 -0800 (PST)
Received: from localhost.localdomain (59-115-216-226.dynamic-ip.hinet.net. [59.115.216.226])
        by smtp.gmail.com with ESMTPSA id oj2-20020a17090b4d8200b001bef79ea006sm17545682pjb.29.2022.03.07.04.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 04:58:58 -0800 (PST)
From:   Chris Chiu <chris.chiu@canonical.com>
To:     Jes.Sorensen@gmail.com, kvalo@codeaurora.org, davem@davemloft.net,
        kuba@kernel.org
Cc:     code@reto-schneider.ch, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Chiu <chris.chiu@canonical.com>
Subject: [PATCH 0/2] rtl8xxxu: Fill up more TX information 
Date:   Mon,  7 Mar 2022 20:58:50 +0800
Message-Id: <20220307125852.13606-1-chris.chiu@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The antenna information is missing in rtl8xxxu and txrate is NULL 
in 8188cu and 8192cu. Fill up the missing information for iw
commands.

Chris Chiu (2):
  rtl8xxxu: feed antenna information for cfg80211
  rtl8xxxu: fill up txrate info for gen1 chips

 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 75 +++++++++++++++++++
 1 file changed, 75 insertions(+)

-- 
2.20.1

