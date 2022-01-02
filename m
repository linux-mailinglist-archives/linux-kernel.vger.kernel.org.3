Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33C07482952
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 06:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbiABF20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 00:28:26 -0500
Received: from relay025.a.hostedemail.com ([64.99.140.25]:56417 "EHLO
        relay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229487AbiABF2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 00:28:24 -0500
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay10.hostedemail.com (Postfix) with ESMTP id C62B45B1;
        Sun,  2 Jan 2022 05:28:23 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf13.hostedemail.com (Postfix) with ESMTPA id D8D4420016;
        Sun,  2 Jan 2022 05:28:17 +0000 (UTC)
Message-ID: <47076e1ad7f3f276842fcdcca85de0e4337c96f5.camel@perches.com>
Subject: Re: [PATCH] get_maintainer: don't remind about no git repo when
 --nogit is used
From:   Joe Perches <joe@perches.com>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>
Date:   Sat, 01 Jan 2022 21:28:17 -0800
In-Reply-To: <20220102031424.3328-1-rdunlap@infradead.org>
References: <20220102031424.3328-1-rdunlap@infradead.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Stat-Signature: eh5s8gd7i3oswigud16sptri56b7nqct
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: D8D4420016
X-Spam-Status: No, score=-3.69
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/Ig+E0x9gt0prxf3DbI44fmAKmiOPphtw=
X-HE-Tag: 1641101297-847113
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-01-01 at 19:14 -0800, Randy Dunlap wrote:
> When --nogit is used with scripts/get_maintainer.pl, the script
> spews 4 lines of unnecessary information (noise). Do not print those
> lines when --nogit is specified.

Seems sensible, thanks.

> 
> This change removes the printing of these 4 lines:
> 
>   ./scripts/get_maintainer.pl: No supported VCS found.  Add --nogit to options?
>   Using a git repository produces better results.
>   Try Linus Torvalds' latest git repository using:
>   git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Joe Perches <joe@perches.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
>  scripts/get_maintainer.pl |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-next-20211224.orig/scripts/get_maintainer.pl
> +++ linux-next-20211224/scripts/get_maintainer.pl
> @@ -1718,7 +1718,7 @@ sub vcs_exists {
>      %VCS_cmds = %VCS_cmds_hg;
>      return 2 if eval $VCS_cmds{"available"};
>      %VCS_cmds = ();
> -    if (!$printed_novcs) {
> +    if (!$printed_novcs && $email_git) {
>  	warn("$P: No supported VCS found.  Add --nogit to options?\n");
>  	warn("Using a git repository produces better results.\n");
>  	warn("Try Linus Torvalds' latest git repository using:\n");


