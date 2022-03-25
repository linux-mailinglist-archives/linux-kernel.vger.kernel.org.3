Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 916634E74C4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 15:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359276AbiCYOGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 10:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347601AbiCYOGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 10:06:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BFC5D8F48;
        Fri, 25 Mar 2022 07:05:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD05461B1C;
        Fri, 25 Mar 2022 14:05:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38E3AC340F1;
        Fri, 25 Mar 2022 14:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648217118;
        bh=pta3b2i458q4DOeFSWpPG82xTqU/eugW9Qk2+QMRASE=;
        h=From:To:Cc:Subject:Date:From;
        b=ekOFR67PakEopy/yHzEcEG+xRkdoyZGGm+lpSLTpZDmTOhA95V16uKBqlNvkRCABM
         lero2MrA6tEwo8AIm+0yJ+QPQFh9KdBhK+5GUQ4+gUNvrw4aHEmFJSFmAYFhKWF0Yz
         sPj1ixL/QbwdD7bch47OqNsLANqGEMXzmbOks6ngCzmF3FvEZAwOJ6dUtdbALSrV33
         S+KXWJ9hZrKnJg5lDayOKc0LutO2ZDLCrqwS5fdFKGkAeutCBqkNXM1Icj7W7bYJqV
         hzTroxjJUJDfPGR8k25ZCgir9j8c+YxTqBufVfj3IZ4jbPcuYNYELfkhRca5rWUmq/
         HJN8YEDvHotWw==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nXkZ1-00Axyq-Le; Fri, 25 Mar 2022 15:05:15 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH v2 0/4] Better handle dependencies on Sphinx extensions
Date:   Fri, 25 Mar 2022 15:05:10 +0100
Message-Id: <cover.1648216561.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sphinx has its own way to identify the need of rebuilding the documentation.
It means that extensions need to use an internal API in order to notify about
the need to consider other files.

The kerneldoc.py extension already does that, maintainers_include.py doesn't
need (as it uses an API that internally does that), and kfigure.py does it on a
different way.  So, those are already safe.

However, other extensions don't notify nor implement their own checks,
so, when a file that was parsed by them is changed, the corresponding 
documentation won't be rebuilt.

This series add support for it for ABI, features and kernel-include.

Mauro Carvalho Chehab (4):
  scripts/get_feat.pl: allow output the parsed file names
  docs: kernel_abi.py: add sphinx build dependencies
  docs: kernel_feat.py: add build dependencies
  docs: kernel_include.py: add sphinx build dependencies

 Documentation/sphinx/kernel_abi.py     |  4 ++++
 Documentation/sphinx/kernel_feat.py    | 20 ++++++++++++++++++--
 Documentation/sphinx/kernel_include.py |  3 +++
 scripts/get_feat.pl                    | 11 +++++++++++
 4 files changed, 36 insertions(+), 2 deletions(-)

-- 
2.35.1


