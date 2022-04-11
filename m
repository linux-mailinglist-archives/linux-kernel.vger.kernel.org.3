Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 939DC4FC6A5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 23:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350007AbiDKVXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 17:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350236AbiDKVXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 17:23:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10AB2E9CB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 14:20:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B093616DC
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 21:20:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AEE5C385A3;
        Mon, 11 Apr 2022 21:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649712043;
        bh=VcMY/lkJl6v3hVQXFaFT0pm0LPne9KUAFAaE6uCrta0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gU4CC3bzYJkTVyk5PqY3DOzknRj13nibImxJjft8FbJbyS+aLxlVtUwOON/Po4SJ8
         1Nnj4WqU27WloPkpnT4RsEw7Pg+Rywitynfvqajwo5azIlfgkTvpOaJ3D2G/K135xf
         08Hc9/hizjG+MWuzpeYgtVElI4IIOkrGhttw5/dBjT3iDUxdfFvYxEKZ9gTsC37iuN
         9bF0E3aSAbXTZkwhJt27n2ic8fUT7psT32uuWFV/hkAPLSxtnxAicvNSXH/8pGSJri
         QB0MaD/DOcNZiy4eMJos4MO8DNmO6+zVJvWs+mDADGKXFsjhOo3yKuj2DfWALgFPqs
         C1ToNl9rNCKHA==
Date:   Mon, 11 Apr 2022 14:20:41 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     Yufen Yu <yuyufen@huawei.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH 4/5] f2fs: get rid of stale fault injection
 code
Message-ID: <YlSbqay8y6oaCxR6@google.com>
References: <20220401071909.505086-1-yuyufen@huawei.com>
 <20220401071909.505086-5-yuyufen@huawei.com>
 <0c134e0e-b2d0-0bc0-42fc-cd220ff77e72@kernel.org>
 <25a24259-3ac3-81ab-1c28-f2a4886888b5@huawei.com>
 <778b1f04-a71b-a226-f7a7-4833fc9bf7c2@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <778b1f04-a71b-a226-f7a7-4833fc9bf7c2@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/11, Chao Yu wrote:
> On 2022/4/6 11:01, Yufen Yu via Linux-f2fs-devel wrote:
> > Hi,
> > 
> > On 2022/4/1 16:28, Chao Yu wrote:
> > > On 2022/4/1 15:19, Yufen Yu via Linux-f2fs-devel wrote:
> > > > Nowly, we can use new fault injection framework. Just delete the
> > > > stale fault injection code.
> > > > 
> > > > Signed-off-by: Yufen Yu <yuyufen@huawei.com>
> > > > ---
> > > >   fs/f2fs/checkpoint.c |  2 +-
> > > >   fs/f2fs/f2fs.h       | 51 ++----------------------------------------
> > > >   fs/f2fs/super.c      | 53 --------------------------------------------
> > > >   fs/f2fs/sysfs.c      | 23 -------------------
> > > >   4 files changed, 3 insertions(+), 126 deletions(-)
> > > > 
> > 
> > ...
> > 
> > > >               break;
> > > > @@ -1963,14 +1920,6 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
> > > >       if (F2FS_IO_SIZE_BITS(sbi))
> > > >           seq_printf(seq, ",io_bits=%u",
> > > >                   F2FS_OPTION(sbi).write_io_size_bits);
> > > > -#ifdef CONFIG_F2FS_FAULT_INJECTION
> > > > -    if (test_opt(sbi, FAULT_INJECTION)) {
> > > > -        seq_printf(seq, ",fault_injection=%u",
> > > > -                F2FS_OPTION(sbi).fault_info.inject_rate);
> > > > -        seq_printf(seq, ",fault_type=%u",
> > > > -                F2FS_OPTION(sbi).fault_info.inject_type);
> > > > -    }
> > > > -#endif
> > > 
> > > This will cause regression due to it breaks application usage w/ -o
> > > fault_* mountoption..., I don't think this is the right way.
> > 
> > 
> > Thanks for catching this. I admit it's a problem. But, IMO fault_* mount
> > option are mostly been used in test, not in actual product. So, I think
> > it may just affect some test applications. With the common fault injection
> > framework, it can be more easy and flexible to do fault injection test.
> > Therefore, I want to remove the two mount options directly.
> > 
> > If you really worried about compatibility, how about just reserving the
> > two inject_* options but without doing any thing for them. We actually
> > configure fault injections by debugfs in this patch.
> > 
> > Or do you have more better suggestion?
> 
> Could you please consider to keep original logic of f2fs fault injection
> if user use inject_* options, otherwise following common fault injection
> framework?
> 
> Thoughts?

I think it'd be useful to test roll-forward recovery flow by using those mount
options, since runtime fault injection cannot enable it during mount.

BTW, what is the real benefit to use the fault injection framework?

> 
> Thanks,
> 
> > 
> > Thanks,
> > Yufen
> > 
> > 
> > 
> > 
> > 
> > 
> > 
> > 
> > _______________________________________________
> > Linux-f2fs-devel mailing list
> > Linux-f2fs-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
