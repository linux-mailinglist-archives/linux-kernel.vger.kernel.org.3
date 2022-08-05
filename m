Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9348058AA99
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 14:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240724AbiHEMNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 08:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240698AbiHEMNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 08:13:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60091D0DE;
        Fri,  5 Aug 2022 05:13:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 979D6B828AD;
        Fri,  5 Aug 2022 12:13:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CE06C433D7;
        Fri,  5 Aug 2022 12:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659701585;
        bh=t9CH9WRFKEssnrpvuoTtroxI/JC7U60bvI5ioCNeR1s=;
        h=From:To:Cc:Subject:Date:From;
        b=iPH8zI3cxO/wWZ7cN1O9nlzhMQAUjQjZs9NnniiCPXQKfTk/YRdKt3Yjii9I9PTmi
         4/6PF/Wg1TpXiprdMKnopgS4eSxAMH5W080act5UbhVq8jTcccJXb2EeH7qY+hqUFh
         ohjX9t3fZPyvoxkVOCrNuQ8DEaCk2tiFN2r9UOltYZxS0q+lMGUoy/CxbqKJkZfqGQ
         B6frpqTx98htQJRtDt+tCboW7X57FpaexRFERqqKk6KLvZeA0qbJC1wNWSx1loQ9IR
         1YbCExg6IsWSH3SjLUmbiNwtBdhg2e0etY50sOMjAZpDqNVlbwq2Kvf9Ptmq8uTB2I
         pplhPBUHIFSuw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oJwCn-0002hG-F1; Fri, 05 Aug 2022 14:13:29 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 0/2] clk: gcc-sc8280xp: fix broken suspend
Date:   Fri,  5 Aug 2022 14:12:48 +0200
Message-Id: <20220805121250.10347-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Qualcomm PCIe driver currently does not implement suspend at all so
we need to mark the GDSCs as always-on to prevent genpd from disabling
them.

Similarly, the Qualcomm dwc3 USB suspend implementation is also
incomplete and the controller doesn't currently survive a suspend cycle
unless the GDSC is kept on. Note that this has nothing to with whether
wakeup is enabled or not (cf. [1]).

With these two workarounds, we have somewhat functional suspend on the
SC8280XP reference design and Lenovo Thinkpad X13s until the missing
driver support is in place (even USB remote wakeup works with [2]
applied).

Johan

[1] https://lore.kernel.org/all/20220804151001.23612-3-johan+linaro@kernel.org/
[2] https://lore.kernel.org/all/20220804151001.23612-1-johan+linaro@kernel.org/


Johan Hovold (2):
  clk: gcc-sc8280xp: keep PCIe power-domains always-on
  clk: gcc-sc8280xp: keep USB power-domains always-on

 drivers/clk/qcom/gcc-sc8280xp.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

-- 
2.35.1

