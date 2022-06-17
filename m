Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D97C54EFAB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 05:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379591AbiFQChb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 16 Jun 2022 22:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233449AbiFQCh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 22:37:29 -0400
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B0948321
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 19:37:28 -0700 (PDT)
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay08.hostedemail.com (Postfix) with ESMTP id 8994F2083B;
        Fri, 17 Jun 2022 02:37:27 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf17.hostedemail.com (Postfix) with ESMTPA id 79F3018;
        Fri, 17 Jun 2022 02:37:26 +0000 (UTC)
Message-ID: <3c56ffea031f0b0d05fd856e10a2c1f6f72291e0.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS: Fix parsing usbhid from
 scripts/get_maintainer.pl
From:   Joe Perches <joe@perches.com>
To:     Mario Limonciello <mario.limonciello@amd.com>,
        benjamin.tissoires@redhat.com, jikos@kernel.org,
        open list <linux-kernel@vger.kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>
Date:   Thu, 16 Jun 2022 19:37:25 -0700
In-Reply-To: <20220616183322.14861-1-mario.limonciello@amd.com>
References: <20220616183322.14861-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Stat-Signature: bu7y1cst8jeb57k16mtsnsaqp8m83oww
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 79F3018
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18Wz3YKWQfTh10xK77o5cLjDg6MM18mTm8=
X-HE-Tag: 1655433446-548260
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-06-16 at 13:33 -0500, Mario Limonciello wrote:
> Recently trying to send a patch, I found that `./scripts/get_maintainer.pl`
> didn't want to parse the usbhid section because of too long of a line
> leading to a missing parenthesis.  To fix this, change () to [] so it can
> parse even the long line.

It'd almost certainly better to change get_maintainer as there are many
possible entries like this.

Perhaps:
---
 scripts/get_maintainer.pl | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index ab123b498fd9b..2a8ee64cd7208 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -1256,6 +1256,9 @@ sub get_subsystem_name {
 	$subsystem = substr($subsystem, 0, $output_section_maxlen - 3);
 	$subsystem =~ s/\s*$//;
 	$subsystem = $subsystem . "...";
+	my $openparens  = () = $subsystem =~ /\(/g;
+	my $closeparens = () = $subsystem =~ /\)/g;
+	$subsystem .= ')' x ($openparens - $closeparens) if ($openparens > $closeparens);
     }
     return $subsystem;
 }

