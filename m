Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E96C50F141
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 08:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243434AbiDZGos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 02:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245725AbiDZGoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 02:44:11 -0400
Received: from relay.hostedemail.com (relay.hostedemail.com [64.99.140.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B96FD36
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 23:41:02 -0700 (PDT)
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay06.hostedemail.com (Postfix) with ESMTP id C09AD25504;
        Tue, 26 Apr 2022 06:41:00 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf20.hostedemail.com (Postfix) with ESMTPA id 6032820028;
        Tue, 26 Apr 2022 06:40:54 +0000 (UTC)
Message-ID: <2e34830b5339697020ea6b2f511bdb4a8f95c6ea.camel@perches.com>
Subject: Re: [PATCH][next] checkpatch: add new alloc functions to alloc with
 multiplies check
From:   Joe Perches <joe@perches.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Date:   Mon, 25 Apr 2022 23:40:53 -0700
In-Reply-To: <20220426062043.GA19970@embeddedor>
References: <20220426062043.GA19970@embeddedor>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 6032820028
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Stat-Signature: kfr6w59f8t7cy7oj6o6jfjeazbyqrsqh
X-Rspamd-Server: rspamout05
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+aTwzhO9CWER5MnzGmDaMttym0w1A7h08=
X-HE-Tag: 1650955254-7895
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-04-26 at 01:20 -0500, Gustavo A. R. Silva wrote:
> kvmalloc() and kvzalloc() functions have now 2-factor multiplication
> argument forms kvmalloc_array() and kvcalloc(), correspondingly.

OK, thanks

> 
> Add alloc-with-multiplies checks for these new functions.
> 
> Link: https://github.com/KSPP/linux/issues/187
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  scripts/checkpatch.pl | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 577e02998701..503e8abbb2c1 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -7033,14 +7033,16 @@ sub process {
>  			    "Prefer $3(sizeof(*$1)...) over $3($4...)\n" . $herecurr);
>  		}
>  
> -# check for k[mz]alloc with multiplies that could be kmalloc_array/kcalloc
> +# check for (kv|k)[mz]alloc with multiplies that could be kmalloc_array/kvmalloc_array/kvcalloc/kcalloc
>  		if ($perl_version_ok &&
>  		    defined $stat &&
> -		    $stat =~ /^\+\s*($Lval)\s*\=\s*(?:$balanced_parens)?\s*(k[mz]alloc)\s*\(\s*($FuncArg)\s*\*\s*($FuncArg)\s*,/) {
> +		    $stat =~ /^\+\s*($Lval)\s*\=\s*(?:$balanced_parens)?\s*((?:kv|k)[mz]alloc)\s*\(\s*($FuncArg)\s*\*\s*($FuncArg)\s*,/) {
>  			my $oldfunc = $3;
>  			my $a1 = $4;
>  			my $a2 = $10;
>  			my $newfunc = "kmalloc_array";
> +			$newfunc = "kvmalloc_array" if ($oldfunc eq "kvmalloc");
> +			$newfunc = "kvcalloc" if ($oldfunc eq "kvzalloc");
>  			$newfunc = "kcalloc" if ($oldfunc eq "kzalloc");
>  			my $r1 = $a1;
>  			my $r2 = $a2;
> @@ -7057,7 +7059,7 @@ sub process {
>  					 "Prefer $newfunc over $oldfunc with multiply\n" . $herectx) &&
>  				    $cnt == 1 &&
>  				    $fix) {
> -					$fixed[$fixlinenr] =~ s/\b($Lval)\s*\=\s*(?:$balanced_parens)?\s*(k[mz]alloc)\s*\(\s*($FuncArg)\s*\*\s*($FuncArg)/$1 . ' = ' . "$newfunc(" . trim($r1) . ', ' . trim($r2)/e;
> +					$fixed[$fixlinenr] =~ s/\b($Lval)\s*\=\s*(?:$balanced_parens)?\s*((?:kv|k)[mz]alloc)\s*\(\s*($FuncArg)\s*\*\s*($FuncArg)/$1 . ' = ' . "$newfunc(" . trim($r1) . ', ' . trim($r2)/e;
>  				}
>  			}
>  		}


