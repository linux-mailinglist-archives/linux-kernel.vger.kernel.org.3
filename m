Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 404334BE5BA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379888AbiBUQH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 11:07:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232866AbiBUQHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 11:07:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5E163D1;
        Mon, 21 Feb 2022 08:07:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CC45DB81257;
        Mon, 21 Feb 2022 16:07:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58556C340E9;
        Mon, 21 Feb 2022 16:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645459646;
        bh=hkQhgL/DyOVPovT36fLffi6gFZoFqkKaa53QcfVmoSU=;
        h=From:To:Cc:Subject:Date:From;
        b=UgPdrP//iiOXo+ATSe3gnCPWxCHRAwfudLoPCRPep4f5m51G6YzTOBw3c2iyQUyGy
         KdBJljkAcp0cODCzLppN2opolWrIVnPUp1zOZ0P2OFQRs9v9osUXfSeEWK6IkSUdJi
         3UOXPCR8qMAGNu+LafkBIRCMp5//G1mtCJmQ6zoJqzpNtg6oRs+hf4m3V9F2vx8FHP
         8kmTko6euqxPgcEa9z9WUI13UEujyS+1bX/b65XNsjwZp89t4AOggOOq1cebPM8/zL
         lPvd+NByVC6h135ka0o8+o00auJijE9dbcMOOA/bppUwcGoqAeOb0cAI1pJhwA5Ocp
         PRAHOHjumR5LQ==
From:   broonie@kernel.org
To:     Luis Chamberlain <mcgrof@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Aaron Tomlin <atomlin@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the modules tree
Date:   Mon, 21 Feb 2022 16:07:21 +0000
Message-Id: <20220221160721.1627006-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
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

Hi all,

After merging the modules tree, today's linux-next build (KCONFIG_NAME)
failed like this:

In file included from /tmp/next/build/include/linux/build_bug.h:5,
                 from /tmp/next/build/include/linux/container_of.h:5,
                 from /tmp/next/build/include/linux/list.h:5,
                 from /tmp/next/build/include/linux/module.h:12,
                 from /tmp/next/build/kernel/module/strict_rwx.c:8:
/tmp/next/build/kernel/module/strict_rwx.c: In function 'frob_rodata':
/tmp/next/build/kernel/module/strict_rwx.c:16:10: error: implicit declaration of function 'PAGE_ALIGNED'; did you mean 'IS_ALIGNED'? [-Werror=implicit-function-declaration]
   16 |  BUG_ON(!PAGE_ALIGNED(layout->base));
      |          ^~~~~~~~~~~~
/tmp/next/build/include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
   78 | # define unlikely(x) __builtin_expect(!!(x), 0)
      |                                          ^
/tmp/next/build/kernel/module/strict_rwx.c:16:2: note: in expansion of macro 'BUG_ON'
   16 |  BUG_ON(!PAGE_ALIGNED(layout->base));
      |  ^~~~~~
cc1: some warnings being treated as errors

Caused by commit

  e5973a14d18 ("module: Move strict rwx support to a separate file")

I have used the -next tree from the 17th.
