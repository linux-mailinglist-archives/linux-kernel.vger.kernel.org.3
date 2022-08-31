Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 794FB5A78AE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 10:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbiHaIPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 04:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbiHaIPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 04:15:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A35154C98;
        Wed, 31 Aug 2022 01:15:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 287C4B81FAF;
        Wed, 31 Aug 2022 08:15:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC272C433D7;
        Wed, 31 Aug 2022 08:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661933735;
        bh=XzKYoBBTvKD4INDkUAwJaCDLrZ3YI9yyAFo/LRbFu+0=;
        h=From:To:Cc:Subject:Date:From;
        b=IcpN9T2d0Omb9UxYeaTup+yeb1aTfGZhetjrck4jBh6o6PBynRwZl+EtBBq0Bj1Hz
         2rXNzTjKJ7SsMFeDAQqRoo3R16OLK5eY3/Yy/QAVgjyNu2crWYqtOSYfVrEa4kyl8V
         MmamuN+kv44V9Dtikff1/u0LJ4LkYOa33YIRLi7LFaaleUynqPSPLCQ0ezVxHOug+q
         ZHwXuG2FEm8H1c62RRuHlDv14Rqy3w5wW+Anc8TuYk9IPFjfXPvsbB1+zrjipwHNbp
         9MvB+bLUHAohzP5091oAF/CTMe+i2DVBd9NlaUuOx15dF/RXlY5/IvEA+NxA7fofQQ
         a6sp3cbJUYn3Q==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oTIsm-0007x8-TW; Wed, 31 Aug 2022 10:15:33 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>,
        Jonathan Woithe <jwoithe@just42.net>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] USB: serial: ch341: fixes for older devices
Date:   Wed, 31 Aug 2022 10:15:23 +0200
Message-Id: <20220831081525.30557-1-johan@kernel.org>
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

Jonathan Woithe reported that there was a regression for some older
ch341 devices in 4.10. Turns out there were two of them.

Jonathan, feel free to reply to this mail with a Tested-by tag. You've
already tested these changes during development even if I've since split
the patch in two. And thanks again for your careful testing while
tracking this down.

Johan


Johan Hovold (2):
  USB: serial: ch341: fix lost character on LCR updates
  USB: serial: ch341: fix disabled rx timer on older devices

 drivers/usb/serial/ch341.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

-- 
2.35.1

