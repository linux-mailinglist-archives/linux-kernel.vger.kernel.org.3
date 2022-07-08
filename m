Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217DA56BBBA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 16:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238200AbiGHOaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 10:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238180AbiGHOah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 10:30:37 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C5D1BE8F
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 07:30:36 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id q5so864831plr.11
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 07:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lJuDGYGVACdH1f491h6pX5w1REmhIPP41yS6lr1Dp7E=;
        b=l7X9JK7pb1SCB1VOwd0BFNdN2+8Oxck1nFSjIEVc1+lkUufAju0LF+XjooUgXVbd1C
         VSSDHigp5/aBusEWPbDmUjrjN0XNPUG73cnykVNcCfta8mUu08VzfbGidJXFwFrOAbwe
         1xo+PuSM+BN1B6uhhoxdbdts6WV+IKzd4rc4r/ODTvZ0Jnxz54yv3u8Mmg4wH0uHNkIu
         cHvEQQI28V5Jc0cynpsm84n8iEy+7Zm3hwFonzuT0mcS90JfSgTygeMPoEAfxufQ3OCR
         3m3owWlt+k2c3SNp1lxQeAOYr1+UMmh36AKSIB9BgZQEpe0CI3eYoxCI+09faNPjSrL7
         nEeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lJuDGYGVACdH1f491h6pX5w1REmhIPP41yS6lr1Dp7E=;
        b=m4xbAWQnc3kak8gyUL2VR6Tk5jAyEksnVcBYSTZFKn6qY2Bbnz2NgVkCpW3RQcThID
         x3vhp3vAuxozA3SoWzhhelm572H6QUR8dxVNT6kS6fjuyPvwjrGpbeZe1498a6CTws5A
         XfLaDbAo0ssW2WmL4kuxo57n7RAJ0Xby1FgFy4WUQ31mnNtHb18UGwS0PqxMUskO4BD/
         91acPmJ2ev4NoJzc8AHBymEiMMoiic5M+VkImSnE8ffZsBEsKjqjweOQipgs11meRkmx
         kzSsGpOy9qAEiPK3T70XO07sEKX9ynV/goCCUO6GVLtMaJPh1cJHEXRZR0KIZE+RtW/X
         V9nA==
X-Gm-Message-State: AJIora+F8Nya0/YRvnSAmRgv50dV9XQ+z/l35pLWwEDG5aLUUw8hKhBz
        O+Hemi+G4HtJ80ZiHufOXPlVZg==
X-Google-Smtp-Source: AGRyM1vNR8IauYpqGCrmfqqh6G30bhgvA7G6mI/72KbOypY2kcs3GI75Pq0uaYjhQn4XS2vfrXPzbA==
X-Received: by 2002:a17:902:ce8d:b0:16c:2755:4289 with SMTP id f13-20020a170902ce8d00b0016c27554289mr2214433plg.82.1657290635696;
        Fri, 08 Jul 2022 07:30:35 -0700 (PDT)
Received: from google.com (201.59.83.34.bc.googleusercontent.com. [34.83.59.201])
        by smtp.gmail.com with ESMTPSA id y144-20020a626496000000b0052aaf7fe731sm1746830pfb.45.2022.07.08.07.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 07:30:35 -0700 (PDT)
Date:   Fri, 8 Jul 2022 14:30:31 +0000
From:   Carlos Llamas <cmllamas@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Christian Brauner <brauner@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] binder: fix redefinition of seq_file attributes
Message-ID: <Ysg/h9rU1VZeVcZV@google.com>
References: <20220701182041.2134313-1-cmllamas@google.com>
 <YsMRtGg8xQ2Qicr2@kroah.com>
 <YsdOcFxGTGkYvtd4@google.com>
 <YsfIEibU3xVafMVg@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsfIEibU3xVafMVg@kroah.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2022 at 08:00:50AM +0200, Greg Kroah-Hartman wrote:
> On Thu, Jul 07, 2022 at 09:21:52PM +0000, Carlos Llamas wrote:
> > On Mon, Jul 04, 2022 at 06:13:40PM +0200, Greg Kroah-Hartman wrote:
> > > On Fri, Jul 01, 2022 at 06:20:41PM +0000, Carlos Llamas wrote:
> > > > +	binder_for_each_debugfs_entry(db_entry) {
> > > > +		dentry = binderfs_create_file(binder_logs_root_dir,
> > > > +					      db_entry->name,
> > > > +					      db_entry->fops,
> > > > +					      db_entry->data);
> > > > +		if (IS_ERR(dentry)) {
> > > > +			ret = PTR_ERR(dentry);
> > > > +			goto out;
> > > > +		}
> > > 
> > > I know this is a copy of what is there already, but there is never a
> > > need to check the result of a debugfs_create_* call.  Just call it and
> > > move on, never "abort" based on the result of a debugfs call, that's not
> > > a good idea.
> > 
> > This is true, none of these debugfs files seem critical for mounting a
> > binderfs instance. I'm thinking init_binder_logs() should just return
> > void. I'm only a bit hesitant to completely ignore the return code as
> > users specifically ask for these files to be created via mount option
> > "stats". So probably a pr_warn is what is actually needed here.
> 
> That would just be too noisy, just let it go, no one cares :)

ok, convinced. I'll get rid of these checks.

> 
> > > So can you change this here, or want to send a follow-on patch that
> > > removes these checks?
> > 
> > Sure, I'll send a follow-on patch. I'm currently AFK so setting ETA for
> > next week until I can actually test this change.
> > 
> > > 
> > > >  	}
> > > >  
> > > >  	proc_log_dir = binderfs_create_dir(binder_logs_root_dir, "proc");
> > > 
> > > Also there's never a need to save a directory, you can always look it up
> > > when you want to remove it.
> > 
> > It seems this is a convenient way to share this path with binder which
> > otherwise doesn't know where binderfs was mounted. From having a quick
> > look it doesn't seem that we need to share all the details in struct
> > binderfs_info though. Maybe there is a better way to handle all this.
> 
> Why would you need to share this internally with anything, again, it can
> always be looked up if you need it.

I just looked into this and you are right. Binder can just take
sb->s_root and look up the entries as needed. This means we can also
unexport all the binderfs_info bits from the internal header. Great!

Thanks,
--
Carlos Llamas
