Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 268CC56AD61
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 23:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236758AbiGGVV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 17:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236555AbiGGVV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 17:21:58 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C037313A8
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 14:21:57 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id r1so14736482plo.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 14:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=faIizSofs0zx69Ae3gA1YkV/PIqimk2KZUpeipzLxMY=;
        b=s1cICUZz48iKQ6u/A6EwoCZanKEYcBE1yy/4rZseIqYyzTq7a/a+70ATZ+1ELNYid4
         XsLNUJjlGpTdVVOxsHPDyw/DSmowfI76pbpMmmHh+IAzMjT+ihu15DNGM4ehioxAciHh
         c8ud0aU5XulUNn4IfNE714fxyWnFFTlcjZ6CTag4/Z5FfAPp7pt9GaAix6f5I/1KsNBK
         UqXYht+k553xW4KoeLJX3lkh2OSkM5fesn7QuN+340qAcRKwrSqvxHbMBqg/WIhjjRX4
         d6IrvvTbLhWaDOd86CEoiSBkQbN+dYdHnBgMjfjvMDF3y1qpCn+ZeIcEULGfqEyzl+MJ
         M7MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=faIizSofs0zx69Ae3gA1YkV/PIqimk2KZUpeipzLxMY=;
        b=edd8nV8afIEQFE8Oh5W0SdD1bmaORviMV+IQNxTZ3oHUZZ3XYQ2VpszhNvYdo84A1Y
         EbNu8kxKzsvSeFbAQxh9mpTnvMqaeiY908NNOseBw0k6j6mS8abMamwrsu3BWJpEoFwV
         Vd9UmXkLr8581RB/QNleEOcXQVIrzzxtZa5NJpKAfj0FVvvz9Ji5W5GksXwAbNrmStig
         sWh1YlwfPIHSfyOcQzFKMTgOm+/4PBo0xKilnaLy6aR3GZIM3+kwR5RTB9lCdaOoXwsU
         ZwzaqDifoggLVwDwYV6kg3mLWSa2fC+yzTjI1MRxYyyI7Wk8vo81rAmrmO2VHv37KMkx
         8NyA==
X-Gm-Message-State: AJIora/BXgQb5dHAUPvATl1qdBNvi94rHrAo6xgvp2mkRRqx80JxVROS
        YIufzy8KMvYRoGFXDXW8KRBUpw==
X-Google-Smtp-Source: AGRyM1vyiwNsHI0IbTNAJsLAB0nAB57lsmwO5bt52/vavViucROF0VncHlr1NXzSPgKD4L7XtPsnlg==
X-Received: by 2002:a17:902:cf06:b0:16b:cc33:5bce with SMTP id i6-20020a170902cf0600b0016bcc335bcemr32777144plg.152.1657228916527;
        Thu, 07 Jul 2022 14:21:56 -0700 (PDT)
Received: from google.com (201.59.83.34.bc.googleusercontent.com. [34.83.59.201])
        by smtp.gmail.com with ESMTPSA id m12-20020a170902768c00b0016a17da4ad4sm28183964pll.39.2022.07.07.14.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 14:21:56 -0700 (PDT)
Date:   Thu, 7 Jul 2022 21:21:52 +0000
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
Message-ID: <YsdOcFxGTGkYvtd4@google.com>
References: <20220701182041.2134313-1-cmllamas@google.com>
 <YsMRtGg8xQ2Qicr2@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsMRtGg8xQ2Qicr2@kroah.com>
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

On Mon, Jul 04, 2022 at 06:13:40PM +0200, Greg Kroah-Hartman wrote:
> On Fri, Jul 01, 2022 at 06:20:41PM +0000, Carlos Llamas wrote:
> > +	binder_for_each_debugfs_entry(db_entry) {
> > +		dentry = binderfs_create_file(binder_logs_root_dir,
> > +					      db_entry->name,
> > +					      db_entry->fops,
> > +					      db_entry->data);
> > +		if (IS_ERR(dentry)) {
> > +			ret = PTR_ERR(dentry);
> > +			goto out;
> > +		}
> 
> I know this is a copy of what is there already, but there is never a
> need to check the result of a debugfs_create_* call.  Just call it and
> move on, never "abort" based on the result of a debugfs call, that's not
> a good idea.

This is true, none of these debugfs files seem critical for mounting a
binderfs instance. I'm thinking init_binder_logs() should just return
void. I'm only a bit hesitant to completely ignore the return code as
users specifically ask for these files to be created via mount option
"stats". So probably a pr_warn is what is actually needed here.

> 
> So can you change this here, or want to send a follow-on patch that
> removes these checks?

Sure, I'll send a follow-on patch. I'm currently AFK so setting ETA for
next week until I can actually test this change.

> 
> >  	}
> >  
> >  	proc_log_dir = binderfs_create_dir(binder_logs_root_dir, "proc");
> 
> Also there's never a need to save a directory, you can always look it up
> when you want to remove it.

It seems this is a convenient way to share this path with binder which
otherwise doesn't know where binderfs was mounted. From having a quick
look it doesn't seem that we need to share all the details in struct
binderfs_info though. Maybe there is a better way to handle all this.

Christian, since this is binderfs area WDYT?

--
Carlos Llamas
