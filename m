Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D5157F5D2
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 17:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbiGXPe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 11:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234290AbiGXPev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 11:34:51 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10271C64
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 08:34:51 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id 17so8402597pfy.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 08:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kY/tRvPtpIY39uMgQW5s0cR39F3MzIZzHkDYQEsZMPg=;
        b=ItTMBXUyjPv6HcOb3SYDf5/MdnfdCLXCYcMlD9hAyif1aWdHgQjNUSm+Vg4gae5f3c
         cY8kskWDxUEL/YN8gSs5LIY/H8cGdDAAIdOP9s0U39Fd48Rair8NyuNRb4PouFFpvjnr
         VDdRCQX+3vka+zCu+4I1T+2vozHPT9DSfE7q3G36O0SIotO8t+UfCBCO9uGWu3vSzbRQ
         MPgw16lV9rZ8McW/iCTiPdjI20SULULhSzC1G803i7GZRf91b5Woy1uXXBksmRmRi8HR
         OAwTyuxdSFWsUAdpH52jaWQkeFEoG77491XrCmRSomFN39Jr9ui8BeyReuZrRB9PvNOv
         KVlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kY/tRvPtpIY39uMgQW5s0cR39F3MzIZzHkDYQEsZMPg=;
        b=AaINpaPeYqm/w4zwtXTP1q0QbUvCGDav76oNbKtA/lHpAhjIiLsoFZmk+bd9B97dzN
         BBymqROO/NNh1Q3VNwoW2aOhxExlqWhtJHMpWk0ZHrjX1fnn9fDL6W221u77/Jnzug65
         fBKBycj1D93BPdHJGy5lR4t7YM/CFuxGalbeLwF8qeoWzD9PiRrP7/l9vRLhl1JsFlWG
         Ncz/LTYCG8wQVh0xBWfzdJKydQS3FIjk91o9GwzzbC4vkt7CCzR2pCURqtrtYlYuMecZ
         XDY6Vh1sx2YUKB6SO/P14xwDxlianmkwlc+Gr9o20dwVYHhiRA56JAm0CRZnos+W2Tfb
         8Vaw==
X-Gm-Message-State: AJIora9oZoLbU6Or1FynWu+6fidtd8vy/WFSIH0Wgm9oamckMjZrXoek
        6zPRD0qCia88EXll9zlGaPCatQdGU5wkJw==
X-Google-Smtp-Source: AGRyM1s4ibEGj/bxy9JCMRRgG/GYPr2SfsvmWkpxHkjhlxg2LeO+U+TDrVxC101EX/JGLNpP4zPi1w==
X-Received: by 2002:a65:49c5:0:b0:412:6e3e:bd91 with SMTP id t5-20020a6549c5000000b004126e3ebd91mr7658428pgs.221.1658676890045;
        Sun, 24 Jul 2022 08:34:50 -0700 (PDT)
Received: from Negi ([68.181.16.133])
        by smtp.gmail.com with ESMTPSA id n7-20020a654507000000b0041ab83d39d4sm2794995pgq.0.2022.07.24.08.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jul 2022 08:34:49 -0700 (PDT)
Date:   Sun, 24 Jul 2022 08:34:48 -0700
From:   Soumya Negi <soumya.negi97@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Anton Altaparmakov <anton@tuxera.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-ntfs-dev@lists.sourceforge.net,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ntfs: Ensure $Extend is a directory
Message-ID: <20220724153448.GA2608@Negi>
References: <20220724132107.1163-1-soumya.negi97@gmail.com>
 <Yt1NVQEOC6Ki3eUI@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yt1NVQEOC6Ki3eUI@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 24, 2022 at 03:47:01PM +0200, Greg KH wrote:
> On Sun, Jul 24, 2022 at 06:21:07AM -0700, Soumya Negi wrote:
> > Fixes Syzbot bug: kernel BUG in ntfs_lookup_inode_by_name
> > https://syzkaller.appspot.com/bug?id=32cf53b48c1846ffc25a185a2e92e170d1a95d71
> > 
> > Check whether $Extend is a directory or not( for NTFS3.0+) while loading
> > system files. If it isn't(as in the case of this bug where the mft record for
> > $Extend contains a regular file), load_system_files() returns false.
> 
> Please wrap your changelog text at 72 columns like your editor asked you
> to when writing this :)

I will correct the changelog(Don't think I can wrap the bug report
link. Checkpatch will still give a warning. Is that okay?).
 
> > Reported-by: syzbot+30b7f850c6d98ea461d2@syzkaller.appspotmail.com
> > Signed-off-by: Soumya Negi <soumya.negi97@gmail.com>
> 
> What commit caused this problem?  What Fixes: tag should go here?

I don't think this was caused by any specific commit.The $Extend
directory check is not present in any previous releases. Syzbot has
also not been able to produce a cause bisection for the bug. So no fixes
tag(please correct me if I am wrong).

> Should it go to stable kernels?  If so, how far back?

Since the NTFS extension file was new to NTFS 3.0, perhaps the patch 
should apply all the way back to the first release with NTFS3.0 support?
I checked the stable tree history and 2.6.11 is the oldest release I could find.

> > ---
> >  fs/ntfs/super.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
> > index 5ae8de09b271..18e2902531f9 100644
> > --- a/fs/ntfs/super.c
> > +++ b/fs/ntfs/super.c
> > @@ -2092,10 +2092,15 @@ static bool load_system_files(ntfs_volume *vol)
> >  	// TODO: Initialize security.
> >  	/* Get the extended system files' directory inode. */
> >  	vol->extend_ino = ntfs_iget(sb, FILE_Extend);
> > -	if (IS_ERR(vol->extend_ino) || is_bad_inode(vol->extend_ino)) {
> > +	if (IS_ERR(vol->extend_ino) || is_bad_inode(vol->extend_ino) ||
> > +	    !S_ISDIR(vol->extend_ino->i_mode)) {
> > +		static const char *es1 = "$Extend is not a directory";
> > +		static const char *es2 = "Failed to load $Extend";
> > +		const char *es = !S_ISDIR(vol->extend_ino->i_mode) ? es1 : es2;
> > +
> >  		if (!IS_ERR(vol->extend_ino))
> >  			iput(vol->extend_ino);
> > -		ntfs_error(sb, "Failed to load $Extend.");
> > +		ntfs_error(sb, "%s.", es);
> 
> Are you allowing the system log to be spammed by an untrusted user with
> this change?

The error message is written to the system log while trying to mount 
the file system(which will fail if the error occurs). I don't understand
how an untrusted user will be involved.

> thanks,
> 
> greg k-h

Thanks,
Soumya
