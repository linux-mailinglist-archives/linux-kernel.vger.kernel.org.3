Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC4584DE71B
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 09:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242533AbiCSIns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 04:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234507AbiCSInp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 04:43:45 -0400
Received: from relay.hostedemail.com (relay.hostedemail.com [64.99.140.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CC312927E
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 01:42:23 -0700 (PDT)
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay11.hostedemail.com (Postfix) with ESMTP id 9286680A7C;
        Sat, 19 Mar 2022 08:42:22 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf01.hostedemail.com (Postfix) with ESMTPA id B038260009;
        Sat, 19 Mar 2022 08:42:21 +0000 (UTC)
Message-ID: <b42be7ee3ed3a2356b7c5ddad545e12d5e7a0ee7.camel@perches.com>
Subject: Re: Checking for space before ending comment tag
From:   Joe Perches <joe@perches.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Andy Whitcroft <apw@canonical.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Date:   Sat, 19 Mar 2022 01:42:20 -0700
In-Reply-To: <fb2ab099-aefa-6a84-5c62-f0c87eca2725@molgen.mpg.de>
References: <fb2ab099-aefa-6a84-5c62-f0c87eca2725@molgen.mpg.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Stat-Signature: j97rebi3ghoxp3y3qjhjtey9w5kp8t7z
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: B038260009
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+Dz7FRbg9/5vBbGDColFQ7Qimlm6C5GrU=
X-HE-Tag: 1647679341-92383
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-03-19 at 08:35 +0100, Paul Menzel wrote:
> Dear Andy, dear Joe,
> 
> The attached patch misses a space before the closing comment tag `*/`:
> 
>      /* Check for FEC status*/
> 
>      $ git describe origin/master
>      v5.17-rc8-61-g34e047aa16c0
>      $ scripts/checkpatch.pl 
> /dev/shm/0001-drm-amd-display-FEC-check-in-timing-validation.patch
>      total: 0 errors, 0 warnings, 10 lines checked
> 
>      /dev/shm/0001-drm-amd-display-FEC-check-in-timing-validation.patch 
> has no obvious style problems and is ready for submission.
> 
> Should/could checkpatch.pl warn about that?

It _could_, but there are a large number of existing uses in the kernel.

$ git grep -P '\w\*\/\s*$' -- '*.[ch]' | wc -l
15841

Even when you exclude the uses that start with /*\w

$ git grep -P '\w\*\/\s*$' -- '*.[ch]' | grep -v -P '/\*\w' | wc -l
7239

btw: that doesn't count the thousands of lines like

/*----*/

Anyway, I prefer not to add tests for things that have that many uses.

cheers, Joe

Anyway, maybe a test could be something like:
---
 scripts/checkpatch.pl | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 577e029987011..65800e6964d1e 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3868,6 +3868,14 @@ sub process {
 			}
 		}
 
+# Single line comment style
+		if ($line =~ /^\+.*$;\s*$/ &&
+		    $rawline =~ /\/\* / &&
+		    $rawline =~ /\w\*\/\s*$/) {
+			WARN("COMMENT_STYLE",
+			     "Single line comments should use a space before the comment termination\n" . $herecurr);
+		}
+
 # Block comment styles
 # Networking with an initial /*
 		if ($realfile =~ m@^(drivers/net/|net/)@ &&


