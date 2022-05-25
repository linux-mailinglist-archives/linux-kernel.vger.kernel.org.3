Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8EE753406C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 17:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245141AbiEYPeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 11:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241234AbiEYPeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 11:34:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9131A3B4
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 08:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qb8bT/iov+W6YOvS5tl4KZX1WoWgh8Y3ggvwoxeIVb0=; b=RzHu89cEVNOuSEMwARyWtVfShP
        6yOFqvKpw83FypwupyueZWF9fJPkJTn4VgVG2v4PpSe4kzu4EC7+8sJKtjPWlWPs8nB2zLkavA83Z
        fHVAxdf8DE/koRfibiOj4ChCxsTpBOVExu09+qVmO+hyeGE8IOmU/+bh2jcp/SuRCS3xVlBlqaM+H
        AQwckFXx982BzpWJ3pAj/WvaQyWFqJyne8UA52csX1Aubc1HX3kzbKfYY4KURB1H7n91831PpLr3K
        8q+JP8obf2dcX+qtxiov4RQTYIPox6azn7Ec1Uh+5oZIC0q36I6iX3dLBY5hQII5Kr/ZTsiPFai7P
        +oGiUS/A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ntt1c-000TTV-5X; Wed, 25 May 2022 15:34:16 +0000
Date:   Wed, 25 May 2022 16:34:16 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Joe Perches <joe@perches.com>
Cc:     David Howells <dhowells@redhat.com>,
        Andy Whitcroft <apw@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: Re: checkpatch mistake on XA_STATE?
Message-ID: <Yo5MeLcwMg5VZmmJ@casper.infradead.org>
References: <1962595.1653473587@warthog.procyon.org.uk>
 <7a4641e036e4821b76eb4ed5b82a4f24b3029f05.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a4641e036e4821b76eb4ed5b82a4f24b3029f05.camel@perches.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 08:03:16AM -0700, Joe Perches wrote:
> On Wed, 2022-05-25 at 11:13 +0100, David Howells wrote:
> > I see the following:
> > 
> > 	WARNING: Missing a blank line after declarations
> > 	#1921: FILE: fs/cifs/smb2ops.c:4684:
> > 	+       struct folio *folio;
> > 	+       XA_STATE(xas, buffer, 0);
> > 
> > but XA_STATE() technically *is* a declaration.
> > 
> > Should checkpatch treat it as such?
> 
> Probably.
> ---
>  scripts/checkpatch.pl | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 503e8abbb2c1e..2cf28014132f6 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -1042,7 +1042,8 @@ our $FuncArg = qr{$Typecast{0,1}($LvalOrFunc|$Constant|$String)};
>  our $declaration_macros = qr{(?x:
>  	(?:$Storage\s+)?(?:[A-Z_][A-Z0-9]*_){0,2}(?:DEFINE|DECLARE)(?:_[A-Z0-9]+){1,6}\s*\(|
>  	(?:$Storage\s+)?[HLP]?LIST_HEAD\s*\(|
> -	(?:SKCIPHER_REQUEST|SHASH_DESC|AHASH_REQUEST)_ON_STACK\s*\(
> +	(?:SKCIPHER_REQUEST|SHASH_DESC|AHASH_REQUEST)_ON_STACK\s*\(|
> +	(?:$Storage\s+)?(?:XA_ARRAY|XA_ARRAY_ORDER)\s*\(

XA_STATE, not XA_ARRAY.

