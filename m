Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D689D50B7F3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 15:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234091AbiDVNNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 09:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234015AbiDVNND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 09:13:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E51315719;
        Fri, 22 Apr 2022 06:10:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 14C89B82D3E;
        Fri, 22 Apr 2022 13:10:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B670DC385AC;
        Fri, 22 Apr 2022 13:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650633007;
        bh=LM+ulpEJgK2xI+UCRDS56xFSor9mKw6oWKs25hHyY6M=;
        h=From:To:Cc:Subject:Date:From;
        b=dGoqZ5wxRl6HJjKW9xiE5i9Ez1cYXQO+T5oIWqaVbvQzKzaoCBiKaXXdgF+g9Y1Te
         76LJoZgtHFmDHppGOo6e7BqIGk8Oc6KgRiW8fLJGq24jWs2VglxcR8//sU47n/+O14
         ZQdBg6NERarFIPlnnnesjT4LYaJvKJ71Elo53eLkm3ey6eVfkJ71mAX2uxIof0kI7V
         W1aJoNl8ehTm4Im8uDgkgDd93/kiyYIuihBlnC6QguiSDTzi1rdrbAsYJf3JRGMslH
         PM3h130+I01u1mS9GzLP6a+bopX5ZDjwGSmxAJXnR9I2VQp3WqjpAPYnprmLh/wrQZ
         JIzczET10KzOw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1nht2v-0000XK-VI; Fri, 22 Apr 2022 15:10:02 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 0/2] phy: qcom-qmp: fix leaks on probe errors
Date:   Fri, 22 Apr 2022 15:09:39 +0200
Message-Id: <20220422130941.2044-1-johan+linaro@kernel.org>
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

Here are two more fixes addressing resource leaks on probe errors (e.g.
probe deferral).

Johan


Johan Hovold (2):
  phy: qcom-qmp: fix struct clk leak on probe errors
  phy: qcom-qmp: fix reset-controller leak on probe errors

 drivers/phy/qualcomm/phy-qcom-qmp.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

-- 
2.35.1

