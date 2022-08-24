Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B51C859FFD6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 18:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238291AbiHXQwS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 24 Aug 2022 12:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238359AbiHXQwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 12:52:13 -0400
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA1F193F1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 09:52:12 -0700 (PDT)
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay10.hostedemail.com (Postfix) with ESMTP id C3D66C024E;
        Wed, 24 Aug 2022 16:52:09 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf07.hostedemail.com (Postfix) with ESMTPA id 696E12002C;
        Wed, 24 Aug 2022 16:52:06 +0000 (UTC)
Message-ID: <3c250aa26020b2f336fd575a58d06ba26faf1f14.camel@perches.com>
Subject: Re: [PATCH RFC 2/2] checkpatch: warn on usage of VM_BUG_ON() and
 friends
From:   Joe Perches <joe@perches.com>
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-doc@vger.kernel.org,
        kexec@lists.infradead.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>
Date:   Wed, 24 Aug 2022 12:52:05 -0400
In-Reply-To: <20220824163100.224449-3-david@redhat.com>
References: <20220824163100.224449-1-david@redhat.com>
         <20220824163100.224449-3-david@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Stat-Signature: jucjcx4acoerrt8q895fp6htgrjxts67
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 696E12002C
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/ObFLiNI+vpAgQqKNzyIkOlEeiH6U5Lr8=
X-HE-Tag: 1661359926-188978
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-08-24 at 18:31 +0200, David Hildenbrand wrote:
> checkpatch does not point out that VM_BUG_ON() and friends should be
> avoided, however, Linus notes:
> 
>     VM_BUG_ON() has the exact same semantics as BUG_ON. It is literally
>     no different, the only difference is "we can make the code smaller
>     because these are less important". [1]
> 
> So let's warn on VM_BUG_ON() and friends as well. While at it, make it
> clearer that the kernel really shouldn't be crashed.
> 
> Note that there are some other *_BUG_ON flavors, but they are not all
> bad: for example, KVM_BUG_ON() only triggers a WARN_ON_ONCE and then
> flags KVM as being buggy, so we'll not care about them for now here.
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -4695,12 +4695,12 @@ sub process {
>  			}
>  		}
>  
> -# avoid BUG() or BUG_ON()
> -		if ($line =~ /\b(?:BUG|BUG_ON)\b/) {
> +# do not use BUG(), BUG_ON(), VM_BUG_ON() and friends.
> +		if ($line =~ /\b(?:BUG|BUG_ON|VM_BUG_ON|VM_BUG_ON_[A-Z]+)\b/) {

Perhaps better as something like the below to pick up more variants

		if ($line =~ /\b(?!KVM_|BUILD_)(?:[A-Z_]*_)?BUG(?:_ON)?(?:_[A-Z_]+)?\s*\(/

>  			my $msg_level = \&WARN;
>  			$msg_level = \&CHK if ($file);
>  			&{$msg_level}("AVOID_BUG",
> -				      "Avoid crashing the kernel - try using WARN_ON & recovery code rather than BUG() or BUG_ON()\n" . $herecurr);

and maybe:

				      "Do not crash the kernel unless it is unavoidable - use WARN_ON_ONCE & recovery code (if reasonable) rather than BUG() or variants\n" . $herecurr);

