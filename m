Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76DF04D3A19
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 20:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237623AbiCITVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 14:21:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235296AbiCITVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 14:21:43 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B19065D1F
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 11:20:43 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id b16so3959678ioz.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 11:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V3qUnbt1P5mTTafoLBkFNxFxh8sf9sREpXzWUvgskYo=;
        b=o9NEYp98ynsmbGtnJMP9V92Qre4ZiQIkf6My+RPa/sf+MX+JoByPY4g1LMIFrXSK0o
         B/3y5rbm4jpZfFpLkNdXGqrgNgPRz7WnRT+QHn3mhK1iGYsI1JJ+GW2sfCrtrJkrqFm1
         bd1uIfn/Hy2oDYbwq1f9NzeoJU+8Xz8n0Ko0cBvfQXrZmfkHbhkzpQihNfi9vhNoahfI
         YWRNFGImR5MMfXBl7XotbbtP5SxpSGuWmBnWRjQ//kl3iq2JG4+q1MwE1iWHGERdf0oB
         qqlQ2AXLVn9wmJXtlQhAY5W9v+TYYHY7IoF3ZPfwAb4Zf+j1MOdKytFNWgGSfxcwKK+B
         IwwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V3qUnbt1P5mTTafoLBkFNxFxh8sf9sREpXzWUvgskYo=;
        b=0JtzJe1ZQgh3ffeZHi4IcEYsFBVM6hDsSF4HVFe8vUwK4Mxc3W9x0e8RZY5oGCbXOR
         GwzUFqwfZIocy7toPlTYS02cRLqGiSwrgAF+5kmhgOXFrsl8h1HEegp6E20k6ev65ret
         /lhn3R6wSn5ZZgHHce5dlPGTwShJTcPjjhREYhyO2zKGkR2aga5Btu3zyvvSa11R6xx4
         VpytHUyWkY4s0IfbDdbIPO+msufGWseKHkFR2msRpN5mbtSIpPKimP5Lv61ZRlU4gKHD
         eMjMdt4C5DnwGrV9H07byW5PP4KjzxWw/54Z40z0/01bIOavRAmx0VwsETZdKiiT/Qd2
         AIAA==
X-Gm-Message-State: AOAM5312cZlO/8AbwrZIZSpAJqeFymjS01n5k1HJD910qxpr+JTiSm9B
        EMbV/G1p6Zp8r8rwvZxMxZpSFD0u2Nmt65Fb
X-Google-Smtp-Source: ABdhPJwWisSsDtytKz9CbRJiULeLBJoTyeuepCwo8RuxHKA2+X3zReviscCzWN31tMjWxOLr87P2jA==
X-Received: by 2002:a05:6638:2586:b0:319:ac56:5f2f with SMTP id s6-20020a056638258600b00319ac565f2fmr852653jat.146.1646853642298;
        Wed, 09 Mar 2022 11:20:42 -0800 (PST)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id g8-20020a056602248800b006409fb2cbccsm1389182ioe.32.2022.03.09.11.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 11:20:41 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     djakov@kernel.org, bjorn.andersson@linaro.org, mka@chromium.org,
        evgreen@chromium.org, cpratapa@codeaurora.org,
        avuyyuru@codeaurora.org, jponduru@codeaurora.org,
        subashab@codeaurora.org, elder@kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/7] net: ipa: use bulk interconnect interfaces
Date:   Wed,  9 Mar 2022 13:20:30 -0600
Message-Id: <20220309192037.667879-1-elder@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IPA code currently enables and disables interconnects by setting
the bandwidth of each to a non-zero value, or to zero.  The
interconnect API now supports enable/disable functions, so we can
use those instead.  In addition, the interconnect API provides bulk
interfaces that allow all interconnects to be operated on at once.

This series converts the IPA driver to use the bulk enable and
disable interfaces.  In the process it uses some existing data
structures rather than defining new ones.

Version 2 contains the same code as version 1; it's just rebased.
Now that commit 1dba41c9d2e2d ("net: ipa: add an interconnect
dependency") is in net-next/master the COMPILE_TEST build error
reported for the original version should be gone.
  https://lore.kernel.org/all/20220204202336.67c95e15@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com/

					-Alex

Alex Elder (7):
  net: ipa: kill struct ipa_interconnect
  net: ipa: use icc_enable() and icc_disable()
  net: ipa: use interconnect bulk enable/disable operations
  net: ipa: use bulk operations to set up interconnects
  net: ipa: use bulk interconnect initialization
  net: ipa: embed interconnect array in the power structure
  net: ipa: use IPA power device pointer

 drivers/net/ipa/ipa_power.c | 178 +++++++++---------------------------
 1 file changed, 42 insertions(+), 136 deletions(-)

-- 
2.32.0

