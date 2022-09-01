Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0403B5A9A47
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 16:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234750AbiIAO2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 10:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233848AbiIAO2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 10:28:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317B55A2FE
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 07:28:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C8C16B8274D
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 14:28:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7536BC433D7;
        Thu,  1 Sep 2022 14:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662042501;
        bh=FJ/i9iwztXW1zvgpe4pz+WOtcW4fsQckWeWhewdZGa4=;
        h=From:To:Cc:Subject:Date:From;
        b=LGEFpOTJHzEZAX95mnDgS12NUorngkrS2VO0aqA18+y7UKr9E7hlqZWm0mSAlJi3r
         EM1WNFp2ct8M1aSZwm3DHr0vBITSTA3hVdkok4pmmBWq6gaKRghhM4WYfO2qEkoUWU
         qaRwNVVBNFUwYjlx6jrrMj/Ic6j+DOkbTiA6G8p4xpsVwUkgtIdTbRwc0ME4fVF+RS
         fb4M1oKibLKE8DPj+tUIcch3+Jv/u4YNEh/xtV/TAHDXYnk1t38mYQLzS+mdLOOBsJ
         nx5AIdgn3gJAT4dbnWJchY5L7aHl85/xu5WmVfwyO2L02D6U5ilBPs8z4gn+Jmmtv5
         mv+ctvXuFrnUQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oTlB8-0003Zm-39; Thu, 01 Sep 2022 16:28:22 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v2 0/4] irqdomain: Fix mapping-creation race
Date:   Thu,  1 Sep 2022 16:28:12 +0200
Message-Id: <20220901142816.13731-1-johan+linaro@kernel.org>
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

Parallel probing (e.g. due to asynchronous probing) of devices that
share interrupts can currently result in two mappings for the same
hardware interrupt to be created.
    
This series adds a serialising mapping mutex so that looking for an
existing mapping before creating a new one is done atomically.

Included are also some related clean ups that remove a redundant lookup
for existing mappings and make the domain-association locking more fine
grained.

Johan


Changes in v2
 - split out redundant lookup cleanup (1/4)
 - use a per-domain mutex to address mapping race (2/4)
 - move kernel-doc to exported function (2/4)
 - fix association race (3/4, new)
 - use per-domain mutex for associations (4/4, new)


Johan Hovold (4):
  irqdomain: Look for existing mapping only once
  irqdomain: Fix mapping-creation race
  irqdomain: Fix domain-association race
  irqdomain: use per-domain mutex for associations

 include/linux/irqdomain.h |   2 +
 kernel/irq/irqdomain.c    | 104 ++++++++++++++++++++++++--------------
 2 files changed, 69 insertions(+), 37 deletions(-)

-- 
2.35.1

