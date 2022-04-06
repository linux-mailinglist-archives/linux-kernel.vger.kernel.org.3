Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8DC64F62A0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 17:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235424AbiDFPEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 11:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236187AbiDFPDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 11:03:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748361E817D;
        Wed,  6 Apr 2022 04:50:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7944617FF;
        Wed,  6 Apr 2022 11:48:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98576C385A3;
        Wed,  6 Apr 2022 11:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649245701;
        bh=Eqm4FO9yfmN8qKPSd+0DsUNWznpY+VAjxNHYra7fkmM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Vey/thLylG7lNXXBB4Bh6eXwOZ5KtUaoluhAWSPBTSeyyk0rRS+akzEz+ylI+Q8Vl
         GTG9p6GQ4R2tb3RfdSy+mYBJLH4uWNCudezLEeRTp6NRuv+uIUViUpeBbnGnmcB3+L
         u4+Cd+0UI3meT6bp9DJDa6z2dl4ptypybce3M7fFg4UHWwXG02j2iMuqK0k7MDRC+n
         5lyvMefAPQGLUo5fQjzM11/ftR1elb5rRDYW8/ElqH5VFIr3W0RZX/TT1Q+ER+k7zn
         0K7eh+kvDXJvdeqtiwXmRSVWTVDXifwXO6SrRVYDuWMrHru/86ageWYPKQJJmV6cjX
         lrRsxcg3cDuUQ==
Message-ID: <6306fba71325483a1ea22fa73250c8777ea647d7.camel@kernel.org>
Subject: Re: [PATCH v2] ceph: invalidate pages when doing DIO in encrypted
 inodes
From:   Jeff Layton <jlayton@kernel.org>
To:     =?ISO-8859-1?Q?Lu=EDs?= Henriques <lhenriques@suse.de>,
        Xiubo Li <xiubli@redhat.com>
Cc:     Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 06 Apr 2022 07:48:19 -0400
In-Reply-To: <87zgky8n0o.fsf@brahms.olymp>
References: <20220401133243.1075-1-lhenriques@suse.de>
         <d6407dd1-b6df-4de4-fe37-71b765b2088a@redhat.com>
         <878rsia391.fsf@brahms.olymp>
         <6ba91390-83e8-8702-2729-dc432abd3cc5@redhat.com>
         <87zgky8n0o.fsf@brahms.olymp>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-04-06 at 12:33 +0100, Luís Henriques wrote:
> Xiubo Li <xiubli@redhat.com> writes:
> 
> > On 4/6/22 6:57 PM, Luís Henriques wrote:
> > > Xiubo Li <xiubli@redhat.com> writes:
> > > 
> > > > On 4/1/22 9:32 PM, Luís Henriques wrote:
> > > > > When doing DIO on an encrypted node, we need to invalidate the page cache in
> > > > > the range being written to, otherwise the cache will include invalid data.
> > > > > 
> > > > > Signed-off-by: Luís Henriques <lhenriques@suse.de>
> > > > > ---
> > > > >    fs/ceph/file.c | 11 ++++++++++-
> > > > >    1 file changed, 10 insertions(+), 1 deletion(-)
> > > > > 
> > > > > Changes since v1:
> > > > > - Replaced truncate_inode_pages_range() by invalidate_inode_pages2_range
> > > > > - Call fscache_invalidate with FSCACHE_INVAL_DIO_WRITE if we're doing DIO
> > > > > 
> > > > > Note: I'm not really sure this last change is required, it doesn't really
> > > > > affect generic/647 result, but seems to be the most correct.
> > > > > 
> > > > > diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> > > > > index 5072570c2203..b2743c342305 100644
> > > > > --- a/fs/ceph/file.c
> > > > > +++ b/fs/ceph/file.c
> > > > > @@ -1605,7 +1605,7 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
> > > > >    	if (ret < 0)
> > > > >    		return ret;
> > > > >    -	ceph_fscache_invalidate(inode, false);
> > > > > +	ceph_fscache_invalidate(inode, (iocb->ki_flags & IOCB_DIRECT));
> > > > >    	ret = invalidate_inode_pages2_range(inode->i_mapping,
> > > > >    					    pos >> PAGE_SHIFT,
> > > > >    					    (pos + count - 1) >> PAGE_SHIFT);
> > > > The above has already invalidated the pages, why doesn't it work ?
> > > I suspect the reason is because later on we loop through the number of
> > > pages, call copy_page_from_iter() and then ceph_fscrypt_encrypt_pages().
> > 
> > Checked the 'copy_page_from_iter()', it will do the kmap for the pages but will
> > kunmap them again later. And they shouldn't update the i_mapping if I didn't
> > miss something important.
> > 
> > For 'ceph_fscrypt_encrypt_pages()' it will encrypt/dencrypt the context inplace,
> > IMO if it needs to map the page and it should also unmap it just like in
> > 'copy_page_from_iter()'.
> > 
> > I thought it possibly be when we need to do RMW, it may will update the
> > i_mapping when reading contents, but I checked the code didn't find any 
> > place is doing this. So I am wondering where tha page caches come from ? If that
> > page caches really from reading the contents, then we should discard it instead
> > of flushing it back ?
> > 
> > BTW, what's the problem without this fixing ? xfstest fails ?
> 
> Yes, generic/647 fails if you run it with test_dummy_encryption.  And I've
> also checked that the RMW code was never executed in this test.
> 
> But yeah I have assumed (perhaps wrongly) that the kmap/kunmap could
> change the inode->i_mapping. 
> 

No, kmap/unmap are all about high memory and 32-bit architectures. Those
functions are usually no-ops on 64-bit arches.

> In my debugging this seemed to be the case
> for the O_DIRECT path.  That's why I added this extra call here.
> 

I agree with Xiubo that we really shouldn't need to invalidate multiple
times.

I guess in this test, we have a DIO write racing with an mmap read
Probably what's happening is either that we can't invalidate the page
because it needs to be cleaned, or the mmap read is racing in just after
the invalidate occurs but before writeback.

In any case, it might be interesting to see whether you're getting
-EBUSY back from the new invalidate_inode_pages2 calls with your patch.

-- 
Jeff Layton <jlayton@kernel.org>
