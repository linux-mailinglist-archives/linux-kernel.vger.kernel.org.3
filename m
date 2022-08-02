Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86FCE588425
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 00:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236308AbiHBWVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 18:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236103AbiHBWVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 18:21:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C243A54AFB;
        Tue,  2 Aug 2022 15:21:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6CAF8B81F38;
        Tue,  2 Aug 2022 22:21:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E991FC433D7;
        Tue,  2 Aug 2022 22:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659478904;
        bh=1Thmzq2FIq7UdGk1o9SYaFeBkkHviUbeNkxmDJQHbBE=;
        h=From:To:Cc:Subject:Date:From;
        b=P88USH9kIpJ9lJyKOsObJ+49VDC9v2M1VAZV/48lcmWwh0TYxgUkN4gl0CQ7kqkbh
         GtTwy26H8qFC+kIg+QkgR1PqvOnrnn0ySys/fg4NmVUG/06EvgdfHpqpx3p96S7iIr
         vzw778xA/XF9kRkwb/mvNa9m1eg2Wvvn+EiYuqpU4AZTwsDd90ZAw3jXHS0rKcHcz4
         1ni3VmaM94PRQUtYrq3uCYRweXaAMEMvTntpHSp1FpLHTVrVOefRYQBTiL/91Y8xdf
         hhgU6vAS1JnacGdXx25bq9yqPB/52LflSFRyBb8uRDb5Npf+dJf2w9cWRwKyZs7p8b
         hDgCkW/bOdkZw==
From:   broonie@kernel.org
To:     Linus Walleij <linus.walleij@linaro.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        linux-gpio@vger.kernel.org
Subject: linux-next: build failure after merge of the pinctrl tree
Date:   Tue,  2 Aug 2022 23:21:37 +0100
Message-Id: <20220802222137.2435761-1-broonie@kernel.org>
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

After merging the pinctrl-samsung tree, today's linux-next build
(x86 allmodconfig) failed like this:

/tmp/next/build/drivers/pinctrl/pinctrl-amd.c: In function 'amd_gpio_dbg_show':
/tmp/next/build/drivers/pinctrl/pinctrl-amd.c:219:8: error: unused variable 'output_enable' [-Werror=unused-variable]
  219 |  char *output_enable;
      |        ^~~~~~~~~~~~~
cc1: all warnings being treated as errors

Caused by commit

  e8129a076a509c ("pinctrl: amd: Use unicode for debugfs output")

I have reverted that commit for today.
