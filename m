Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59735598458
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 15:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245030AbiHRNjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 09:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245131AbiHRNjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 09:39:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433935A3D7;
        Thu, 18 Aug 2022 06:39:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C5D39B82188;
        Thu, 18 Aug 2022 13:39:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 692C9C433D7;
        Thu, 18 Aug 2022 13:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660829947;
        bh=8OYtYLNr9+M4D0TzZjuyhL9R+YeFezzuOwbR4acU9MI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bh2cJqm3Ox9a+GSvMnaiVt4Vd/2dIfWVyHPu5WLBQrisZcpX9bw2YH/gP0XtshtZU
         UlnNgrT1LHoN4Y9uYzsoUwW8lQNdpaeAOEuUHXxNtgrqj3BefeA/n7Jd7VFAbfahWv
         Jz2MfKShJVxb3ersk8N6x/HVLwACphYrC59m+Ulj5EIJ4XSfr5j/WRYPOIuyzlmdSp
         nE+IBXhRZ0ZhYo4z6aGAKC7kPX2vyn1mOtdKrVNUn5okegYEO7zZBeWJQM0UMn/HPl
         h7MdbZX4Z5xTfPZoxmYVgyw+mxqSPdZZf0Gr9TKpDAoL6hOJIRZCT1ZZm9EeJ4FxBS
         av8XQ+nUfVElQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oOfjl-00AY7E-3A;
        Thu, 18 Aug 2022 15:39:05 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>, corbet@lwn.net
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/13] scripts: kernel-doc: add support for EXPORT_SYMBOL variants
Date:   Thu, 18 Aug 2022 15:38:47 +0200
Message-Id: <9e15cf41b5258ad95a144d87996a3448ae8180e3.1660829433.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1660829433.git.mchehab@kernel.org>
References: <cover.1660829433.git.mchehab@kernel.org>
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

There are now several new EXPORT_SYMBOL variants. Add support for
them.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

See [PATCH 00/13] at: https://lore.kernel.org/all/cover.1660829433.git.mchehab@kernel.org/

 scripts/kernel-doc | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index aea04365bc69..94a062ef1835 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -255,7 +255,7 @@ my $doc_inline_start = '^\s*/\*\*\s*$';
 my $doc_inline_sect = '\s*\*\s*(@\s*[\w][\w\.]*\s*):(.*)';
 my $doc_inline_end = '^\s*\*/\s*$';
 my $doc_inline_oneline = '^\s*/\*\*\s*(@[\w\s]+):\s*(.*)\s*\*/\s*$';
-my $export_symbol = '^\s*EXPORT_SYMBOL(_GPL)?\s*\(\s*(\w+)\s*\)\s*;';
+my $export_symbol = '^\s*(EXPORT_SYMBOL|EXPORT_SYMBOL_GPL|EXPORT_SYMBOL_NS|EXPORT_SYMBOL_NS_GPL|EXPORT_SYMBOL_ACPI_LIB|EXPORT_INDIRECT_CALLABLE)\s*\(\s*(\w+)[,\w\s]*\)\s*;';
 my $function_pointer = qr{([^\(]*\(\*)\s*\)\s*\(([^\)]*)\)};
 my $attribute = qr{__attribute__\s*\(\([a-z0-9,_\*\s\(\)]*\)\)}i;
 
@@ -2419,12 +2419,12 @@ found on PATH.
 =item -export
 
 Only output documentation for the symbols that have been exported using
-EXPORT_SYMBOL() or EXPORT_SYMBOL_GPL() in any input FILE or -export-file FILE.
+EXPORT_SYMBOL() and variants in any input FILE or -export-file FILE.
 
 =item -internal
 
 Only output documentation for the symbols that have NOT been exported using
-EXPORT_SYMBOL() or EXPORT_SYMBOL_GPL() in any input FILE or -export-file FILE.
+EXPORT_SYMBOL() nor variants in any input FILE or -export-file FILE.
 
 =item -function NAME
 
@@ -2452,7 +2452,7 @@ Do not output DOC: sections.
 =item -export-file FILE
 
 Specify an additional FILE in which to look for EXPORT_SYMBOL() and
-EXPORT_SYMBOL_GPL().
+variants.
 
 To be used with -export or -internal.
 
-- 
2.37.1

