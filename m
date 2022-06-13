Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E81549FB4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 22:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345941AbiFMUpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 16:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351422AbiFMUoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 16:44:06 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154EADEB6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 12:51:08 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 47C0FC009; Mon, 13 Jun 2022 21:51:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1655149867; bh=UEvKISJURFgyGo3z5EU/K/Ie2JUi/EPJT4jZw0U6fw8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RceXwHRGU7mqLO5rOsg7z085gkBFou3uzTxjZfPWhq0xDjwKssqvNp89OR90eUn7V
         HX9lENgU62yupn1S9FeQRbWZdIHuTofXJAUWyF8AxIiQ1O4fVIg3NMs3TxhqX1VCkW
         rRselTe5r0wl0cgMXHNvizTFcVjNlI6iO9i5dft8d/hCv+BvVzTj3WfnxNguZRyg3H
         S3pllg24g4HcTbzS9ZgB1JGroeXYutAO4oMTvW6WlTR//Vhc1eNpmqlqffeXV2Qa2F
         cc9d/jhqInRKiHT7a1sXYjYMKEnXuImEtAIfzRr4Wtft+IXmZ8eAPtu287JNr+IgOw
         vMJrx+D0bRW1A==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 97D3EC009;
        Mon, 13 Jun 2022 21:51:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1655149866; bh=UEvKISJURFgyGo3z5EU/K/Ie2JUi/EPJT4jZw0U6fw8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sk0XCve553x6PF2rViDkpNAIAyr7AA8IvuCw6ijYTB1QOjfqK7/iYhH+nFjU3x1A3
         MVm9LmcLyaKJs5JQOnkbTBbHQNUOcP/aB/4O0r37Ce72bsEtEiHkx/s8kUk8GgPevm
         uOSYm8N27rnBzpH+XMSPYn1VNZ61KKUKWNPazusRgFFd84/uEl+qmuoP+XDVEAe4DU
         uy4rrqCdSecetimU8CpHVtW4Op+gsfE2ntoculz1V4QsCysyuhuRDE2XSZaalAZGqF
         +CW2FJpCtgi169KQqCr2CaII3pglXwORvZBLDdlmvuggqbX+0wy8OqGvj5UEC0xYeN
         Cp7DlgCEk2R/A==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id cc73f8c0;
        Mon, 13 Jun 2022 19:51:01 +0000 (UTC)
Date:   Tue, 14 Jun 2022 04:50:45 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Tyler Hicks <tyhicks@linux.microsoft.com>
Cc:     Christian Schoenebeck <linux_oss@crudebyte.com>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/06] 9p fid refcount: cleanup p9_fid_put calls
Message-ID: <YqeVFTkREfWUfPFi@codewreck.org>
References: <20220612085330.1451496-1-asmadeus@codewreck.org>
 <20220612085330.1451496-7-asmadeus@codewreck.org>
 <20220613175509.GE7401@sequoia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220613175509.GE7401@sequoia>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the reviews,

Tyler Hicks wrote on Mon, Jun 13, 2022 at 12:55:09PM -0500:
> > @@ -189,13 +197,13 @@ static struct p9_fid *v9fs_fid_lookup_with_uid(struct dentry *dentry,
> >  		else
> >  			uname = v9ses->uname;
> >  
> > -		root_fid = p9_client_attach(v9ses->clnt, NULL, uname, uid,
> > -					    v9ses->aname);
> > -		if (IS_ERR(root_fid))
> > -			return root_fid;
> > +		fid = p9_client_attach(v9ses->clnt, NULL, uname, uid,
> 
> To keep the readability benefits in my "9p: Track the root fid with its
> own variable during lookups" patch, I think root_fid should be assigned
> here and then used in the error check and return statement.
> 
> > +				       v9ses->aname);
> > +		if (IS_ERR(fid))
> > +			return fid;
> >  
> > -		p9_fid_get(root_fid);
> > -		v9fs_fid_add(dentry->d_sb->s_root, root_fid);
> > +		root_fid = p9_fid_get(fid);
> > +		v9fs_fid_add(dentry->d_sb->s_root, &fid);
> 
> root_fid should be used in the two lines above, too.

This actually was the only place where we still want to use the root_fid
after calling v9fs_fid_add; if we keep root_fid above we need to do
something like

fid = p9_fid_get(root_fid);
v9fs_Fid_add(dentry->d_sb->s_root, &root_fid);
root_fid = fid;
// fid = NULL; ? not strictly needed as we set it again shortly afterwards

which I wanted to avoid, but I guess I don't mind strongly either way --
pick your poison.
I could also just keep v9fs_fid_add as a non-stealing version, but I
think it's better that way as it strongly signal that we stashed that
ref away and shouldn't use the fid anymore unless another ref was
obtained through fid_get like we do here.
(I was actually tempted to do the same with p9_fid_put, but checking
other kernel "put"s I didn't see any code that does this so I refrained
from that churn)

-- 
Dominique
