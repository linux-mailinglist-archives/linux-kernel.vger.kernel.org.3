Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 037B85A448A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 10:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiH2IGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 04:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiH2IGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 04:06:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9C252838;
        Mon, 29 Aug 2022 01:06:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E8F3EB80D63;
        Mon, 29 Aug 2022 08:06:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B999C43470;
        Mon, 29 Aug 2022 08:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661760404;
        bh=vEVlgcvzHAGVREWl4JAo7TyUTWO2ajtrlaWpFndzrc0=;
        h=From:To:Cc:Subject:Date:From;
        b=S7iMWIDWo1Xza4W8WqTIfQiJg96PtyaAoQVcHlTa2Vf8jrMQssWnueb2urKUULkCA
         kvZoNKbnAEroXKk3hFkwAYeUkW36/RX327Z39MQ+1zKYWG2KEDY2N4m7pLJ2Ag9Awh
         1U/JZG6ao/FYetkUx9/Pv4sBeH8Fu/YCzudUcwLjYCMTkEVb4X3RYaoGH6MFvbYYH8
         D+0pkwF4K9lhrF/Yx6R2hrLbpIy8sUV/A2Xd3vPmeXQpIEGxV7YE4T6j5CNH/iYhOC
         glnZVwVG0tRqdAg+xQn5a5FqnTOfgiR+h8L1FN5nT3wdMaX8YmL3AFr9Kc3WiZWf0U
         Gw6ZKd2rgcELg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oSZnH-0007jS-V2; Mon, 29 Aug 2022 10:06:51 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 0/3] misc: fastrpc: fix memory corruption
Date:   Mon, 29 Aug 2022 10:05:28 +0200
Message-Id: <20220829080531.29681-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
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

The fastrpc driver uses a fixed-sized array to store its sessions but
missing and broken sanity checks could lead to memory beyond the array
being corrupted.

This specifically happens on SC8280XP platforms that use 14 sessions for
the compute DSP.

These are all needed for 6.0.

Johan


Johan Hovold (3):
  misc: fastrpc: fix memory corruption on probe
  misc: fastrpc: fix memory corruption on open
  misc: fastrpc: increase maximum session count

 drivers/misc/fastrpc.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

-- 
2.35.1

