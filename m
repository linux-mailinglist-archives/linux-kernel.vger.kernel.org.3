Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 863D14E8072
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 11:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbiCZK3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 06:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232524AbiCZK3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 06:29:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F7F2F008;
        Sat, 26 Mar 2022 03:27:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3EB6A60B84;
        Sat, 26 Mar 2022 10:27:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83BAAC340F3;
        Sat, 26 Mar 2022 10:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648290447;
        bh=gkLuPChh/62HzYG8JNKGaCyt+9mhI4s5dURFTooh/lk=;
        h=From:To:Cc:Subject:Date:From;
        b=RTiVsOW4NGyhKP6jdrcOqAswGCTi0l8FGIBZTPOcnAxcbuLtX0iG/u/dHqPEsmMCg
         7w4V0q2kA4zwCT43jwVzBqko0U9mxVQKKBAvmbSjlKSoz9MFNiBnR6h1Q2tT4ew9tQ
         aPYkbyQsaU6SZUoUKv9ErCRdVeGclQq0/3euHhy7f7EzFY7LynjAYPmutDsNM2Vw48
         i9WM2yu4+a0/ST3P64NZOGuhrypwTkZWcD5Kr0L4A2rKSCFPGw1AcUefpR+SJwglHz
         K1qoiXb3BNsvCfc3plLl8PVEmroHrbZqFnCvZU+Pf1qQ2QFCRH8VCIDR75V+qMh3qf
         02bzbtbeFYBzQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nY3dl-00Co0R-0e; Sat, 26 Mar 2022 11:27:25 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH v3 0/6] Better handle dependencies on Sphinx extensions
Date:   Sat, 26 Mar 2022 11:27:18 +0100
Message-Id: <cover.1648290305.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

---

v3:
  - Changed the meta-tag used when --enable-lineno and --enable-fname
    are used at the scripts that generate ReST output.

Mauro Carvalho Chehab (6):
  scripts/get_feat.pl: allow output the parsed file names
  docs: kernel_feat.py: add build dependencies
  docs: kernel_abi.py: add sphinx build dependencies
  docs: kernel_include.py: add sphinx build dependencies
  scripts/get_abi: change the file/line number meta info
  scripts/kernel-doc: change the line number meta info

 Documentation/sphinx/kernel_abi.py     |  6 +++++-
 Documentation/sphinx/kernel_feat.py    | 20 ++++++++++++++++++--
 Documentation/sphinx/kernel_include.py |  3 +++
 Documentation/sphinx/kerneldoc.py      |  2 +-
 scripts/get_abi.pl                     |  4 ++--
 scripts/get_feat.pl                    | 11 +++++++++++
 scripts/kernel-doc                     |  4 ++--
 7 files changed, 42 insertions(+), 8 deletions(-)

-- 
2.35.1


