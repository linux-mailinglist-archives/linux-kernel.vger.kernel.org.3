Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 297C94D5CB0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 08:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346927AbiCKHug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 02:50:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245098AbiCKHuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 02:50:32 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCBA6E8FF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 23:49:29 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id r12so7052229pla.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 23:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UzP5nyGsG5GcBeZpseFrZjEpwCJXFyPvLwGQvRUfnNo=;
        b=I+MNjb3CDGdWqP0vN8lxP24xDaRT2FsDjXqHEF8anMTchEqnJESHsAJ5VSU3coSSh+
         UZTErUAkeAAjATqg/sexMBi4kvDDB3kcFgReh8VQTfrL0lRESjd2BykhwR3FJOA1yNhO
         wlNDdrP78dFszJNYudc8oOTvgCfj1r6NOtjNYyjbX7DY22XC9+62V6xgbiYbZVYlzq/S
         PxcHJBvwZfy9iWVhodI/6rsEKS+xDy/lsu0v3uGeJHXr9ozgn9FSGdCjRVcrfg2We15x
         w9hxuSnTMiECb92PKg2M9mpJiNpZUtDvBeU+ING2wAgQuFPPRo9QN5Haa4YP1vKpxX/W
         PbFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UzP5nyGsG5GcBeZpseFrZjEpwCJXFyPvLwGQvRUfnNo=;
        b=2BKARYrSXSJ2pMAdfhQX33GeFLt8ybHaYmJ9wAWMZ1clPEeDaS9gABmPjWfH/tq/RI
         s+cx6RODjU/QFcS0+PlAHQAOYJN9Sk2p9suuK4r5OCOV8TmmnDDBqc8KdKCAFo8RrfoZ
         uq8IhtC5iZsM34RxPTtwF6yGpQ6OFtOww+vNDBp5NtTURwMUjpfyJU58zSfgt4hbc8uB
         Az29k+Tf0CcUaRTJDjDekiidNkinPrapjKksy7K41D56E+mydo+AiXQrIQ3cT2i/ydDF
         LuA5wew8SReWkEgd+U+fkRHI1El6S6td5ydNkuZ/6DSUgftbChDspksFcy2bpnQP8hG/
         Adeg==
X-Gm-Message-State: AOAM532YrVcsRYcxGYlQbKmAqJexELpAns4jQSYq6QAfSCgWENNVj2Yu
        CyA9Nsfx3zbWlCObEjW7QBI=
X-Google-Smtp-Source: ABdhPJzsmRHcxa6IQeOpJXmKQsO67zzYMTHhIWp68vwt20iA/12obEHLhxXGb0uvrIXs5xnkDLJreA==
X-Received: by 2002:a17:90b:3ec8:b0:1bf:ddf:92f0 with SMTP id rm8-20020a17090b3ec800b001bf0ddf92f0mr9324478pjb.161.1646984969050;
        Thu, 10 Mar 2022 23:49:29 -0800 (PST)
Received: from localhost ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id mu1-20020a17090b388100b001bf861ef154sm12668948pjb.55.2022.03.10.23.49.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Mar 2022 23:49:28 -0800 (PST)
Date:   Fri, 11 Mar 2022 15:48:16 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        huyue2@coolpad.com, zhangwen@coolpad.com
Subject: Re: [PATCH 1/2] erofs: clean up z_erofs_extent_lookback
Message-ID: <20220311154816.00004d23.zbestahu@gmail.com>
In-Reply-To: <Yir8lBR2gyN1CJ8D@B-P7TQMD6M-0146.local>
References: <20220310182743.102365-1-hsiangkao@linux.alibaba.com>
        <20220311151232.00003619.zbestahu@gmail.com>
        <Yir6HNsdYFdLVwEN@B-P7TQMD6M-0146.local>
        <Yir8lBR2gyN1CJ8D@B-P7TQMD6M-0146.local>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Mar 2022 15:39:00 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> On Fri, Mar 11, 2022 at 03:28:28PM +0800, Gao Xiang wrote:
> > On Fri, Mar 11, 2022 at 03:12:32PM +0800, Yue Hu wrote:  
> > > On Fri, 11 Mar 2022 02:27:42 +0800
> > > Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> > >   
> > > > Avoid the unnecessary tail recursion since it can be converted into
> > > > a loop directly in order to prevent potential stack overflow.
> > > > 
> > > > It's a pretty straightforward conversion.
> > > > 
> > > > Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> > > > ---
> > > >  fs/erofs/zmap.c | 67 ++++++++++++++++++++++++-------------------------
> > > >  1 file changed, 33 insertions(+), 34 deletions(-)
> > > > 
> > > > diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
> > > > index b4059b9c3bac..572f0b8151ba 100644
> > > > --- a/fs/erofs/zmap.c
> > > > +++ b/fs/erofs/zmap.c
> > > > @@ -431,48 +431,47 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
> > > >  				   unsigned int lookback_distance)
> > > >  {
> > > >  	struct erofs_inode *const vi = EROFS_I(m->inode);
> > > > -	struct erofs_map_blocks *const map = m->map;
> > > >  	const unsigned int lclusterbits = vi->z_logical_clusterbits;
> > > > -	unsigned long lcn = m->lcn;
> > > > -	int err;
> > > >  
> > > > -	if (lcn < lookback_distance) {
> > > > -		erofs_err(m->inode->i_sb,
> > > > -			  "bogus lookback distance @ nid %llu", vi->nid);
> > > > -		DBG_BUGON(1);
> > > > -		return -EFSCORRUPTED;
> > > > -	}
> > > > +	while (m->lcn >= lookback_distance) {
> > > > +		unsigned long lcn = m->lcn - lookback_distance;
> > > > +		int err;  
> > > 
> > > may better to declare variable 'lclusterbits' in loop just like 'err' usage?  
> > 
> > I'm fine with either way. Ok, will post the next version later.  
> 
> Oh, I just noticed that you mean `lclusterbits', I think it won't
> change in this function, so I don't tend to move it into the inner
> loop.

Ok, looks good to me.

Reviewed-by: Yue Hu <huyue2@coolpad.com>

> 
> Thanks,
> Gao Xiang
> 
> > 
> > Thanks,
> > Gao Xiang  

