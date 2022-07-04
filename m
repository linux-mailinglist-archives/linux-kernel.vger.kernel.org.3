Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E20F56567D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 15:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234530AbiGDNGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 09:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234610AbiGDNGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 09:06:41 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E16BFD25
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 06:06:34 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id z12so6750070qki.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 06:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=a5TD/6htXeQo+179uY4oIl450HovuI2EhjBmEtecnJY=;
        b=kktvMRcI30wmbkZvJOiXR2y1iTCUrjLtGc89dbvz23Czi/hMHPDY3bS23bYk2gGF7A
         HWJxXs6ywJC5MwLn4t7Dq3Ekk05VuJ0V1ncNcZQqW7mVIUDoctj4I996PkWAmVfplDGY
         9p4ytipzw9dVOmVHen0I2CkBwQBS3Of+Rf6l7yDbtWLQ+4/0peZ4kqxPF63PZb8Peqsk
         wgVXpHYnw68ExcfwbRp8DQoyW1TeXuzB7RWXVIE2CPGhRKvO6dUnu3KxY53Yo/67PH9R
         Tq/KQZzo/NQcHzntVijRdh0pgIE1dvhBsGW7ogtYVAnapVUJYUYemZx2y3AhnP6LnyNK
         TLMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a5TD/6htXeQo+179uY4oIl450HovuI2EhjBmEtecnJY=;
        b=fDJG3YsmLvKy16C/MjHGcCr04zvOxbxdi/yCHCbjLkpNP96aYVaH1YkNXWBmx6lsRx
         HDe2q1IIREmXbGaKcidcA/MZ4gvBazmkBCSShO9Qsa3EaYLilSfxA72T39ZH4awQAlXd
         yPyEiXmm9h18zIEMMRzuucHtZsDNTk30Ue9lk+DCb4976e1iglVl+cy7WIjlMrJMTTO7
         D7nICpERikMBjxK8Z83dJWo6RAagEMoWJDJnGX+CFhf7+79cPErD6fHwsAHEhnnoTTJ2
         FGzBo9phrcIhWOrf+YEImpVstVVaL8RChB40Pl9ytmm5VHC2w3vIZMcqkL6IQtIQCf03
         k9Gw==
X-Gm-Message-State: AJIora9N7FoT9sTi+UencpOmLV25Dc4Q8KEv+iJxw7wPoa03jCsQuQvo
        JizwTEth19OY5i0jh60ZPtUG0sZAtuIKC8s=
X-Google-Smtp-Source: AGRyM1tirL1eMd1wHrMdnOU9GvqHnOm/pOs5+oZ1ihTLoRogwJTDL3MXKdkS22ith2xtGsrpYgXPLQ==
X-Received: by 2002:a05:620a:12c2:b0:6af:474:99b2 with SMTP id e2-20020a05620a12c200b006af047499b2mr19006059qkl.402.1656939993836;
        Mon, 04 Jul 2022 06:06:33 -0700 (PDT)
Received: from localhost (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id j22-20020ac85516000000b0031778b5567asm18506100qtq.63.2022.07.04.06.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 06:06:32 -0700 (PDT)
Date:   Mon, 4 Jul 2022 09:06:31 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Christian Schoenebeck <linux_oss@crudebyte.com>
Cc:     Dominique Martinet <asmadeus@codewreck.org>,
        linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>
Subject: Re: [PATCH 3/3] 9p: Add mempools for RPCs
Message-ID: <20220704130631.eq5txpq62gwvbvts@moria.home.lan>
References: <20220704010945.C230AC341C7@smtp.kernel.org>
 <20220704030557.fm7xecylcq4z4zkr@moria.home.lan>
 <YsJgxoTyYxX1NwyW@codewreck.org>
 <2335194.JbyEHpbE5P@silver>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2335194.JbyEHpbE5P@silver>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 04, 2022 at 01:12:51PM +0200, Christian Schoenebeck wrote:
> On Montag, 4. Juli 2022 05:38:46 CEST Dominique Martinet wrote:
> > +Christian, sorry I just noticed you weren't in Ccs again --
> > the patches are currently there if you want a look:
> > https://evilpiepirate.org/git/bcachefs.git/log/?h=9p_mempool
> 
> I wonder whether it would make sense to update 9p section in MAINTAINERS to 
> better reflect current reality, at least in a way such that contributors would 
> CC me right away?
> 
> Eric, Latchesar, what do you think?
> 
> > > @@ -270,10 +276,8 @@ p9_tag_alloc(struct p9_client *c, int8_t type,
> > > unsigned int max_size)> 
> > >  	if (!req)
> > >  	
> > >  		return ERR_PTR(-ENOMEM);
> > > 
> > > -	if (p9_fcall_init(c, &req->tc, alloc_msize))
> > > -		goto free_req;
> > > -	if (p9_fcall_init(c, &req->rc, alloc_msize))
> > > -		goto free;
> > > +	p9_fcall_init(c, &req->tc, 0, alloc_msize);
> > > +	p9_fcall_init(c, &req->rc, 1, alloc_msize);
> > 
> > mempool allocation never fails, correct?
> > 
> > (don't think this needs a comment, just making sure here)
> > 
> > This all looks good to me, will queue it up in my -next branch after
> > running some tests next weekend and hopefully submit when 5.20 opens
> > with the code making smaller allocs more common.
> 
> Hoo, Dominique, please hold your horses. I currently can't keep up with 
> reviewing and testing all pending 9p patches right now.
> 
> Personally I would hold these patches back for now. They would make sense on 
> current situation on master, because ATM basically all 9p requests simply 
> allocate exactly 'msize' for any 9p request.

Err, why?

These patches are pretty simple, and they fix a bug that's affecting users right
now (and has been for ages)

> However that's exactly what I was going to address with my already posted 
> patches (relevant patches regarding this issue here being 9..12):
> https://lore.kernel.org/all/cover.1640870037.git.linux_oss@crudebyte.com/
> And in the cover letter (section "STILL TODO" ... "3.") I was suggesting to 
> subsequently subdivide kmem_cache_alloc() into e.g. 4 allocation size 
> categories? Because that's what my already posted patches do anyway.

Yeah that sounds like you're just reimplementing kmalloc.
