Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3215E54A036
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 22:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244842AbiFMUya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 16:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348470AbiFMUxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 16:53:00 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 65BA7D59
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 13:12:44 -0700 (PDT)
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id AF05120C29A6;
        Mon, 13 Jun 2022 13:12:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AF05120C29A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1655151164;
        bh=HWaF1QNmxsIR85mJlUFoIZu1n8vlMMKl1k718oV97FY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rgkl+iIpE6OKLauIfR74wAB6KRvdMtoESL9vSIufW93thHl16YFEvhVZifRVbiUu0
         okM9FabZGQj+SsIFQ/0x3Z5PzzvEL2NBkyRKzsuqZAM9kUrt+C5Exm+Jm8AiQyQKhp
         0eiBsjty9nTvwQ25AoDx290CPSd7qIp/f1Cp8d50=
Date:   Mon, 13 Jun 2022 15:12:41 -0500
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Christian Schoenebeck <linux_oss@crudebyte.com>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/06] 9p fid refcount: cleanup p9_fid_put calls
Message-ID: <20220613201241.GH7401@sequoia>
References: <20220612085330.1451496-1-asmadeus@codewreck.org>
 <20220612085330.1451496-7-asmadeus@codewreck.org>
 <20220613175509.GE7401@sequoia>
 <YqeVFTkREfWUfPFi@codewreck.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqeVFTkREfWUfPFi@codewreck.org>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-06-14 04:50:45, Dominique Martinet wrote:
> Thanks for the reviews,
> 
> Tyler Hicks wrote on Mon, Jun 13, 2022 at 12:55:09PM -0500:
> > > @@ -189,13 +197,13 @@ static struct p9_fid *v9fs_fid_lookup_with_uid(struct dentry *dentry,
> > >  		else
> > >  			uname = v9ses->uname;
> > >  
> > > -		root_fid = p9_client_attach(v9ses->clnt, NULL, uname, uid,
> > > -					    v9ses->aname);
> > > -		if (IS_ERR(root_fid))
> > > -			return root_fid;
> > > +		fid = p9_client_attach(v9ses->clnt, NULL, uname, uid,
> > 
> > To keep the readability benefits in my "9p: Track the root fid with its
> > own variable during lookups" patch, I think root_fid should be assigned
> > here and then used in the error check and return statement.
> > 
> > > +				       v9ses->aname);
> > > +		if (IS_ERR(fid))
> > > +			return fid;
> > >  
> > > -		p9_fid_get(root_fid);
> > > -		v9fs_fid_add(dentry->d_sb->s_root, root_fid);
> > > +		root_fid = p9_fid_get(fid);
> > > +		v9fs_fid_add(dentry->d_sb->s_root, &fid);
> > 
> > root_fid should be used in the two lines above, too.
> 
> This actually was the only place where we still want to use the root_fid
> after calling v9fs_fid_add; if we keep root_fid above we need to do
> something like
> 
> fid = p9_fid_get(root_fid);
> v9fs_Fid_add(dentry->d_sb->s_root, &root_fid);
> root_fid = fid;
> // fid = NULL; ? not strictly needed as we set it again shortly afterwards
> 
> which I wanted to avoid, but I guess I don't mind strongly either way --
> pick your poison.

Ah, very good point. I missed that subtly.

> I could also just keep v9fs_fid_add as a non-stealing version, but I
> think it's better that way as it strongly signal that we stashed that
> ref away and shouldn't use the fid anymore unless another ref was
> obtained through fid_get like we do here.
> (I was actually tempted to do the same with p9_fid_put, but checking
> other kernel "put"s I didn't see any code that does this so I refrained
> from that churn)

I like the stealing version. Lets go with it and keep this patch as-is.

Please feel free to slap this tag on it:

 Reviewed-by: Tyler Hicks <tyhicks@linux.microsoft.com>


Tyler

> 
> -- 
> Dominique
> 
