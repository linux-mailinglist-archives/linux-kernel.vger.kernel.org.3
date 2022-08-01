Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82E35587379
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 23:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234684AbiHAVor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 17:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbiHAVop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 17:44:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2950423170;
        Mon,  1 Aug 2022 14:44:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA0AA60B87;
        Mon,  1 Aug 2022 21:44:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1268EC433D6;
        Mon,  1 Aug 2022 21:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659390283;
        bh=02jtEJTaPGuFXtnwDYuN15TbZ2p6w/X9gRogKJF0Cco=;
        h=From:To:Cc:Subject:Date:From;
        b=VW1mFk8b4YqHlK73U1KcJRUpqPPP1Zlv6B5EhZaMru/0acVGe//YJOMKqUVye/iYH
         32ac6CHyb1yOYS6RX01GxYRnwYz4vMEb7UAMG8eG0XZBpB9ggDf4wImF+c1eknQrKS
         62KLbsrl3Biu/PHdlel3V8pFSLcWLSKXUdeEEYlO6ASg9TiN05ycGvDoYW+S1x5/Ng
         x2wbh//Oe9aL9QXywHv6aeuHdu4bbJMKn8ytOYViYJVL+0tA8eG1mDaJ83rj0RXnm5
         4wCtkb3QVrXOTT+nHhSyBvY0h4Cg3Rsav9fxH7ytco3SPgPe8QkptI81oi9TxKD7AY
         3YEuPblwQeZ5w==
From:   broonie@kernel.org
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the input tree
Date:   Mon,  1 Aug 2022 22:44:34 +0100
Message-Id: <20220801214434.2058469-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
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

Hi all,

After merging the hid tree, today's linux-next build (x86_64 allmodconfig)
failed like this:

/tmp/next/build/drivers/hid/hid-nintendo.c:406:29: error: redefinition of 'JC_RUMBLE_ZERO_AMP_PKT_CNT'
  406 | static const unsigned short JC_RUMBLE_ZERO_AMP_PKT_CNT = 5;
      |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~
/tmp/next/build/drivers/hid/hid-nintendo.c:295:29: note: previous definition of 'JC_RUMBLE_ZERO_AMP_PKT_CNT' was here
  295 | static const unsigned short JC_RUMBLE_ZERO_AMP_PKT_CNT = 5;
      |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~

Caused by commit

  7af32d156ad7 ("Revert "HID: nintendo: Fix unused-const-variable compiler warning"")

interacting with

  92cdfba40155 ("HID: nintendo: fix unused const warning")

I'll apply a fixup for now.
