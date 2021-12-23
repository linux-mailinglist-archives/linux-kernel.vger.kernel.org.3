Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5754947E09B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 09:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347262AbhLWIwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 03:52:15 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:51332 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbhLWIwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 03:52:14 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id EEA521F38A;
        Thu, 23 Dec 2021 08:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1640249532; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F8xZGCLBuvqe1LmV9quSgZLFDM2OPqvf9S1YxQAvxWs=;
        b=G6bN2CC1ZCdwXSCKt2hJOUu2xZfPaDfRawX5DfnHNwLXUU4lb7eSTkpCGb/hyRI1Oa6gXn
        HPHjYVg80pY6pMIX1yMgqOd5i6Ipuhl6L1EwR6151KnS/IFhRshX4R7Y9enECQjf/vHDWu
        0y9aBb7apxbkqN2i0/oP0ejEhqQIBXQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1640249532;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F8xZGCLBuvqe1LmV9quSgZLFDM2OPqvf9S1YxQAvxWs=;
        b=TptToG0U0rgqK11tTSs0qvRMjl0oMq89Pv04zZcBVCF4ks/Xvj5R13eizIRVnnC5W7fK9u
        tchkRYPfjXR/9DBw==
Received: from pobox.suse.cz (pobox.suse.cz [10.100.2.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B0089A3B96;
        Thu, 23 Dec 2021 08:52:12 +0000 (UTC)
Date:   Thu, 23 Dec 2021 09:52:12 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Jerome Marchand <jmarchan@redhat.com>
cc:     Steven Rostedt <rostedt@goodmis.org>,
        Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] recordmcount.pl: look for jgnop instruction as well as
 bcrl on s390
In-Reply-To: <20211210093827.1623286-1-jmarchan@redhat.com>
Message-ID: <alpine.LSU.2.21.2112230949520.19849@pobox.suse.cz>
References: <20211210093827.1623286-1-jmarchan@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 10 Dec 2021, Jerome Marchand wrote:

> On s390, recordmcount.pl is looking for "bcrl 0,<xxx>" instructions in
> the objdump -d outpout. However since binutils 2.37, objdump -d
> display "jgnop <xxx>" for the same instruction. Update the
> mcount_regex so that it accepts both.
> 
> Signed-off-by: Jerome Marchand <jmarchan@redhat.com>
> ---
>  scripts/recordmcount.pl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/recordmcount.pl b/scripts/recordmcount.pl
> index 7d631aaa0ae1..52a000b057a5 100755
> --- a/scripts/recordmcount.pl
> +++ b/scripts/recordmcount.pl
> @@ -219,7 +219,7 @@ if ($arch eq "x86_64") {
>  
>  } elsif ($arch eq "s390" && $bits == 64) {
>      if ($cc =~ /-DCC_USING_HOTPATCH/) {
> -	$mcount_regex = "^\\s*([0-9a-fA-F]+):\\s*c0 04 00 00 00 00\\s*brcl\\s*0,[0-9a-f]+ <([^\+]*)>\$";
> +	$mcount_regex = "^\\s*([0-9a-fA-F]+):\\s*c0 04 00 00 00 00\\s*(bcrl\\s*0,|jgnop\\s*)[0-9a-f]+ <([^\+]*)>\$";

there is a typo I did not notice before. Sorry about that *sigh*.

s/bcrl/brcl/ on the whole patch.

Miroslav
