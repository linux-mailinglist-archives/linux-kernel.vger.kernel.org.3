Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF8CB59B112
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 02:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236115AbiHUArN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 20 Aug 2022 20:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiHUArL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 20:47:11 -0400
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73792D1C7
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 17:47:10 -0700 (PDT)
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay06.hostedemail.com (Postfix) with ESMTP id 995D8AB694;
        Sun, 21 Aug 2022 00:47:09 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf07.hostedemail.com (Postfix) with ESMTPA id 80F9520032;
        Sun, 21 Aug 2022 00:47:08 +0000 (UTC)
Message-ID: <a3a2f6ddbddec0426c76eac655276982e8d58f74.camel@perches.com>
Subject: Re: [PATCH] checkpatch: add ALLOC_UNNECESSARY_ARRAY test
From:   Joe Perches <joe@perches.com>
To:     Kenneth Lee <klee33@uw.edu>, apw@canonical.com,
        dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com
Cc:     linux-kernel@vger.kernel.org
Date:   Sat, 20 Aug 2022 20:47:07 -0400
In-Reply-To: <20220820214120.497971-1-klee33@uw.edu>
References: <20220820214120.497971-1-klee33@uw.edu>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Stat-Signature: b7fwuxmaywntxkzo73ks53wn4gce15wt
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 80F9520032
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        KHOP_HELO_FCRDNS,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX183zl2MPSSNio9tS8px0JFQ9op52P7Mb40=
X-HE-Tag: 1661042828-551292
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-08-20 at 14:41 -0700, Kenneth Lee wrote:
> Using calloc|malloc_array(1, ...) can be simplified to zalloc|malloc(...)
> and improves semantics. This is because we are only allocating one element
> so there is no need to use the array version of the methods.

I don't know if this is particularly useful.

$ git grep -P '(\b(?:devm_(?:kcalloc|kmalloc_array))|\b(?:kv|k)(?:calloc|malloc_array))\s*\(\s*1\s*,' | wc -l
48

If a realloc or equivalent is used to expand the number of elements,
then using 1 as the initial element count seems appropriate.

Have you checked the existing uses?

If these are just using a kcalloc style as a means to zero memory,
then the direct use of the zero allocation equivalent is appropriate.

> This is my first patch that is not a trivial cleanup, so please let me
> know if I am approaching something wrong. Also unsure if the warning
> name should be something else besides ALLOC_UNNECESSARY_ARRAY

Naming is pretty arbitrary, I'm fine with the name.

> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -7079,6 +7079,19 @@ sub process {
>  			     "$1 uses number as first arg, sizeof is generally wrong\n" . $herecurr);
>  		}
>  
> +# check for use of unnecessary array alloc methods
> +# calloc|malloc_array(1, ...) should be zalloc|malloc(...)
> +		if ($line =~ /(\b(?:devm_(?:kcalloc|kmalloc_array))|\b(?:kv|k)(?:calloc|malloc_array))\s*\(\s*1\s*,/) {
> +			my $newfunc = "kmalloc";
> +			$newfunc = "kvmalloc" if ($1 eq "kvmalloc_array");
> +			$newfunc = "kvzalloc" if ($1 eq "kvcalloc");
> +			$newfunc = "kzalloc" if ($1 eq "kcalloc");
> +			$newfunc = "devm_kzalloc" if ($1 eq "devm_kcalloc");
> +			$newfunc = "devm_kmalloc" if ($1 eq "devm_kmalloc_array");
> +			WARN("ALLOC_UNNECESSARY_ARRAY",
> +			     "$1(1, ...) can be simplified to $newfunc(...)\n" . $herecurr);

This doesn't work with any alloc using dev_<foo> as these functions
all take a struct device * as the first argument.

And perhaps this would be better/more easily extensible with a hash
instead of a list.

Something like:

our %alloc_array = {
	'devm_kcalloc' => 'devm_kzalloc',
	'devm_kmalloc_array' => 'devm_kmalloc',
	'kvmalloc_array' => 'kvmalloc',
	'kvcalloc' => 'kvzalloc',
	'kcalloc' => 'kzalloc',
	'kmalloc_array' => 'kmalloc',
};

#Create a search pattern for all these strings to speed up a loop below
our $alloc_array_search = "";
foreach my $entry (keys %one_alloc_array) {
	$alloc_array_search .= '|' if ($alloc_array_search ne "");
	$alloc_array_search .= $entry;
}
$alloc_array_search = "(?:${one_alloc_array_search})";
...
		if ($line =~ /(\b($alloc_array)\s*\(\s*1\s*,/) {
			WARN("ALLOC_UNNECESSARY_ARRAY",
			     "$1(1, ...) can be simplified to $alloc_array->$1(...)\n" . $herecurr);

Ideally, this would use $stat and check the positional argument.

Maybe something like:

our @alloc_array = (
	[ 'devm_kcalloc', 'devm_kzalloc', 1 ],
	[ 'devm_kmalloc_array', 'devm_kmalloc', 1 ],
	[ 'kvmalloc_array', 'kvmalloc', 0 ],
	[ 'kvcalloc', 'kvzalloc', 0 ],
	[ 'kcalloc', 'kzalloc', 0 ],
	[ 'kmalloc_array', 'kmalloc', 0 ],
);

#Create a search pattern for all these strings to speed up a loop below
our $alloc_array_search = "";
foreach my $entry (keys %one_alloc_array) {
	$alloc_array_search .= '|' if ($alloc_array_search ne "");
	$alloc_array_search .= $entry->[0];
}
$alloc_array_search = "(?:${one_alloc_array_search})";

Look at the use of mode_permission_funcs for an example of
skipping to a particular argument.

