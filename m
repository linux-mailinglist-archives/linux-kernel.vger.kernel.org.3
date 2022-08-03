Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9C8588C32
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 14:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237733AbiHCMeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 08:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbiHCMef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 08:34:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74AF1CB0A;
        Wed,  3 Aug 2022 05:34:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C91B6141B;
        Wed,  3 Aug 2022 12:34:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDC0DC433D7;
        Wed,  3 Aug 2022 12:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659530073;
        bh=W0cR2uW5KaoycIlCpLkhDVVbdqLtJDV7BQESr5rfoig=;
        h=From:To:Cc:Subject:Date:From;
        b=OhwmuZ+dLjHXc+j26BB4LQc3flVD1q6r2S8Rsa84Yw8gR7kiC/tAqwQJNOWBXUFLy
         051mJHtF9kLg+TJhFH8bRLF+C1DMjKPhyhQ4x6s7kdxD/j+CwCaVciHLHHbQOTnizk
         PYvfqLnU2eNOL7q31l4RcYh9LOH+rKztsRbQeEuXToilfw4u8c7RUwxoC5/zGHG1wL
         w+zn5ajwUM6Jp0GyTEOCwvXjDxy+feBqpFrvc2xRYmwMjwXf2youQzLo7KbQxE9l7o
         Z0pxCDFVs4mb6+2cQOMmeX+skzGbHJg/LPEKVyVttsHev04yLzx5PILK6tGc27JExi
         RyBlmTRNgtM8g==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oJDaN-000289-Ty; Wed, 03 Aug 2022 14:34:52 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Douglas Anderson <dianders@chromium.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 0/2] phy: qcom: drop regulator loads
Date:   Wed,  3 Aug 2022 14:33:30 +0200
Message-Id: <20220803123332.8138-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unless a driver implements an idle mode, there's generally no point in
specifying an active-mode regulator load.

Drop the regulator loads that were recently added to the Qualcomm QMP
combo and edp PHY drivers.

For a background discussion on this matter, see the following thread:

	https://lore.kernel.org/r/YuPps+cvVAMugWmy@sirena.org.uk

Johan


Johan Hovold (2):
  phy: qcom-qmp-combo: drop regulator loads
  phy: qcom-edp: drop regulator loads

 drivers/phy/qualcomm/phy-qcom-edp.c       | 12 -------
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 40 +++++------------------
 2 files changed, 9 insertions(+), 43 deletions(-)

-- 
2.35.1

