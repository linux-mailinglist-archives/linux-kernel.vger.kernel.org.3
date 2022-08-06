Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5CCD58B33F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 03:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241563AbiHFBnj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 5 Aug 2022 21:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237456AbiHFBni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 21:43:38 -0400
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3CA11471
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 18:43:36 -0700 (PDT)
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay05.hostedemail.com (Postfix) with ESMTP id 8EF7A406F2;
        Sat,  6 Aug 2022 01:43:34 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf13.hostedemail.com (Postfix) with ESMTPA id C544920010;
        Sat,  6 Aug 2022 01:43:32 +0000 (UTC)
Message-ID: <12695fa86c0e3e062077b5e11a66234d9404e4a2.camel@perches.com>
Subject: Re: [GIT PULL] MM updates for 5.20-rc1
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        mm-commits@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Dave Chinner <dchinner@redhat.com>
Date:   Fri, 05 Aug 2022 18:43:32 -0700
In-Reply-To: <20220805170752.d609551360017d60903e5e75@linux-foundation.org>
References: <20220803133541.18b82ec9344ed0e8b975fe5b@linux-foundation.org>
         <CAHk-=wiOSXvk=70tpR9E1tvDmCf8s-81bT+92aE-iKocxdTsyw@mail.gmail.com>
         <Yu2wDNcOYE0RdkA3@P9FQF9L96D.corp.robot.car>
         <20220805170752.d609551360017d60903e5e75@linux-foundation.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Stat-Signature: qyrp8argzkghi98fkgmfsdzcootm5dgb
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: C544920010
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/PQT5mEc4qSatyOMKaUxBPL8ydPsKALW0=
X-HE-Tag: 1659750212-509346
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-08-05 at 17:07 -0700, Andrew Morton wrote:
> On Fri, 5 Aug 2022 17:04:28 -0700 Roman Gushchin <roman.gushchin@linux.dev> wrote:
> 
> > On Fri, Aug 05, 2022 at 04:32:34PM -0700, Linus Torvalds wrote:
> > > On Wed, Aug 3, 2022 at 1:35 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> > > > 
> > > > - memcg debug/visibility work from Roman Gushchin
> > > 
> > > Well, not just memcg.
> > > 
> > > There's that new CONFIG_SHRINKER_DEBUG too.
> > > 
> > > Which looks like yet another "people add Kconfig options incorrectly".
> > > 
> > > We don't make new features "default y" unless there's some truly
> > > pressing reason for it (ie "99.9% of all people will want this" or "we
> > > used to always compile this in, now it's optional").
> > 
> > Hi Linus!
> > 
> > It actually was 'default n' in one of the earlier version of the patchset
> > and has been switched to 'default y' based on the following feedback from
> > Dave Chinner (https://lore.kernel.org/lkml/YmiWK56bOHyrr64u@rh/):
> > 
> >     No. The argument that "if we turn it off there's no overhead" means
> >     one of two things:
> > 
> >     1. nobody turns it on and it never gets tested and so bitrots and is
> >     useless, or
> >     2. distro's all turn it on because some tool they ship or customer
> >     they ship to wants it.
> > 
> >     Either way, hiding it behind a config option is not an acceptible
> >     solution for mering poorly thought out infrastructure.
> > 
> > Personally I think that the feature is not that useful for the majority
> > of users (this is why default was n), but it's not adding much of the
> > overhead, so I had no strong reasons to oppose Dave.
> > Cc'ing him just in case.
> > 
> 
> We should have changelogged these considerations.
> 
> I've asked Joe if checkpatch can get a "default y" detector, to draw
> attention to this in the future.

Perhaps:
---
 scripts/checkpatch.pl | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index bf7c5abeefaad..1abec0cd217e6 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3523,6 +3523,19 @@ sub process {
 			}
 		}
 
+# check new Kconfig entries for default=y
+# Only applies when adding the entry originally and if the entry is not
+# conditional on anything like default y if <foo>
+		if ($realfile =~ /Kconfig/ &&
+		    !$file &&
+		    $line =~ /\+\s*default\s+y\s*$/i) {
+			if (WARN("KCONFIG_DEFAULT_Y",
+				 "Kconfig entries should generally not be default y\n" . $herecurr) &&
+			    $fix) {
+				$fixed[$fixlinenr] =~ s/default(\s+)y/default${1}n/;
+			}
+		}
+
 # check MAINTAINERS entries
 		if ($realfile =~ /^MAINTAINERS$/) {
 # check MAINTAINERS entries for the right form

