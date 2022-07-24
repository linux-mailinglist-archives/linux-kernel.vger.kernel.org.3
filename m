Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA0D957F74F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 00:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbiGXWRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 18:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiGXWRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 18:17:49 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95C9DF2A
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 15:17:48 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id gn24so8753292pjb.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 15:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TUqDJbKLgOrxeIK66AdtU2xlhyRBbEM5JPtjgrE7Gvo=;
        b=Qvl4zc2vdY7VOhBEZeh/tajiq3s8kDwrJvuu29nuvlN/UEnct+cTCsAoqBHYj3xgtn
         /Jfx3C/5kj3oXxNRSE7FiqQL3z6ldW71GyU87RBcAqLJ8MDFJUCt1Blu5FmiGVSmgPNO
         i+IOs+qucoURknEKoI/FtEkUrA+HqyuLx6NwuCKT1uJ9m/45i3ccx50742Yqxw5AjJyo
         YNVvBETSNseRPBs9YSWCfhNoG19mAILOWHeyxP1R5LuReIuJH+dRG7NXlrQI6LpYnTR1
         ES7t1GeabwJcMfg0qX+s7os1vRzlo4Q3XHefhkLXAeGt2pn301zMmhINOjW+oYFZjvZD
         qqTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TUqDJbKLgOrxeIK66AdtU2xlhyRBbEM5JPtjgrE7Gvo=;
        b=TYCz9BzWnXpZuKP7Ls7ll3fR9VP+wc6C9Z7hOKAIQQScgVrIZZzfpN/yc9ulgU1OUO
         GGLt2ssOFe0IqPyf1nLaxsiKNzrPH+2Wmv4CauIDoBn8w6YBMYKxsqejKedVuU5gZ0qn
         Uo+WiU/sm5/m5lqnE2SQGOyWsfNwmwGzz6wRSoeTlQUfWBKrN/kQgJfzYNEokCI3PMVe
         qYuUnib2aFKAac5CZrOS1EDxbUy9FMPfp9th0IDpGSwincBrutSsyxprbyZEv/Hc2dmU
         fW7HZt97zTQJtjlhAOPoVuEIVs4e8OIIEIR+1Ii0drs0F2stl5ZkVo1MaxFwmqlkpzr8
         uR5A==
X-Gm-Message-State: AJIora/JTBVe1Glk8ZElHa7ImYA9sKZG4iywgaZE9GM/wqpNXqjbKtlZ
        zgytLkKtGQYPVM0FdZigxtB6BOc1hRvwXg==
X-Google-Smtp-Source: AGRyM1twdRgLTKQNbvpjNi3Gx6v3vLpNlLbQV7INoQFdw1GYzVamdyrmforpu+7k9gtAswRnIP1DOA==
X-Received: by 2002:a17:902:b60d:b0:16b:e832:7295 with SMTP id b13-20020a170902b60d00b0016be8327295mr9335775pls.144.1658701067767;
        Sun, 24 Jul 2022 15:17:47 -0700 (PDT)
Received: from Negi ([68.181.16.133])
        by smtp.gmail.com with ESMTPSA id 186-20020a6214c3000000b00525496442ccsm4024844pfu.216.2022.07.24.15.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jul 2022 15:17:47 -0700 (PDT)
Date:   Sun, 24 Jul 2022 15:17:45 -0700
From:   Soumya Negi <soumya.negi97@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Anton Altaparmakov <anton@tuxera.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-ntfs-dev@lists.sourceforge.net,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ntfs: Ensure $Extend is a directory
Message-ID: <20220724221745.GB2608@Negi>
References: <20220724132107.1163-1-soumya.negi97@gmail.com>
 <Yt1NVQEOC6Ki3eUI@kroah.com>
 <20220724153448.GA2608@Negi>
 <Yt1rQ8Ft5klOOENg@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yt1rQ8Ft5klOOENg@kroah.com>
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

On Sun, Jul 24, 2022 at 05:54:43PM +0200, Greg KH wrote:
> On Sun, Jul 24, 2022 at 08:34:48AM -0700, Soumya Negi wrote:
> > On Sun, Jul 24, 2022 at 03:47:01PM +0200, Greg KH wrote:
> > > On Sun, Jul 24, 2022 at 06:21:07AM -0700, Soumya Negi wrote:
> > > > Fixes Syzbot bug: kernel BUG in ntfs_lookup_inode_by_name
> > > > https://syzkaller.appspot.com/bug?id=32cf53b48c1846ffc25a185a2e92e170d1a95d71
> > > > 
> > > > Check whether $Extend is a directory or not( for NTFS3.0+) while loading
> > > > system files. If it isn't(as in the case of this bug where the mft record for
> > > > $Extend contains a regular file), load_system_files() returns false.
> > > 
> > > Please wrap your changelog text at 72 columns like your editor asked you
> > > to when writing this :)
> > 
> > I will correct the changelog(Don't think I can wrap the bug report
> > link. Checkpatch will still give a warning. Is that okay?).
> 
> Yes, do not wrap links.
> 
> > > > Reported-by: syzbot+30b7f850c6d98ea461d2@syzkaller.appspotmail.com
> > > > Signed-off-by: Soumya Negi <soumya.negi97@gmail.com>
> > > 
> > > What commit caused this problem?  What Fixes: tag should go here?
> > 
> > I don't think this was caused by any specific commit.The $Extend
> > directory check is not present in any previous releases. Syzbot has
> > also not been able to produce a cause bisection for the bug. So no fixes
> > tag(please correct me if I am wrong).
> > 
> > > Should it go to stable kernels?  If so, how far back?
> > 
> > Since the NTFS extension file was new to NTFS 3.0, perhaps the patch 
> > should apply all the way back to the first release with NTFS3.0 support?

> Yes, mark it there.

Thanks. I will send v2 of the patch. Just want to make sure that the
patch will apply to 2.6.11.y before marking it.

-Soumya
