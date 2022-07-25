Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C912580440
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 21:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233651AbiGYTHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 15:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiGYTHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 15:07:04 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32722B1DE
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 12:06:59 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d10so11263679pfd.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 12:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eaPHtOOOY8qo+YT1sPvH9CgIJLYkA1nmDllA2/WdJf0=;
        b=HxkUPJM5xvgAdGwMkg7IvUnr9TpuKF6GGD6ZjRmBCJ1k6x9i8aK3L4ZC8O31NupPrQ
         VWA2uxN7IJYnpvCYRfDhtD76iED/HQ3SVC9iVlBHUx2FC6UKEWz9vAUiR7vJ/paMEOlv
         1kybJU3iyfhQqBYaRdjhS/2i3RzLNz1iSRhLFOF4ROPVcEgb6yRtNdECI6to5eLTGlPm
         ds4WgL1zCFDSsjj0SDkZ1I2U4yv7Zs9731knpnviq2s6nv//cpAZxOQCPmOsABbimXzP
         ws59iL9xp2RtwirnabDcW0M6WnWVD9tDkZvZmv6SpgbXanISBbp/mlBfN70Ht9a6Ll3Q
         lJNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eaPHtOOOY8qo+YT1sPvH9CgIJLYkA1nmDllA2/WdJf0=;
        b=0+JE/Q8SBqqGNsPUb8qhwGBCQ/EJt/oJ4ZMJBpH2o/ZXGRahNPD1a3TSASsr2rNPXZ
         jTaikvUmR7LjGlCK9GqfyXJUgOybyKALhpwDQr13tWl45Y7Sc4DyGt88sgtM/DO77/gk
         LhIzQdLhJjnUwQD3K4GJVfm2BvwyEWBt1qG2HmhPNU/kFquWPEoLxfJRgqaIz6BLpv/A
         4Ai+RuaGNMBJl8vErftuL1Dubkz40pNBMNoPW6QP0DI400TkZSCvtTdw/S3/geouYSek
         grSzU1Q1ZW//vOBsBKriNVqZ2CNwX45HoTblVfDjUwJXF28jdJYxKqkg6jMdpy0QiCLW
         Cy7Q==
X-Gm-Message-State: AJIora9JOOt2gRx6pmS/0NQPYukJHmkO42Q1WSD8gKgsl6HJAfLxUeUk
        eerFoeUVybwQ++hVkVAjAaSfblt0yttjTQ==
X-Google-Smtp-Source: AGRyM1utB88Uz5RGY3veqzZ/lkrZkqK64QL4cYJg+aYYpcQV/CjGovcfjcLw0e/uBQKLgfQ+8HfCtg==
X-Received: by 2002:a62:1509:0:b0:528:98a1:1f7e with SMTP id 9-20020a621509000000b0052898a11f7emr14149491pfv.11.1658776018203;
        Mon, 25 Jul 2022 12:06:58 -0700 (PDT)
Received: from Negi ([68.181.16.133])
        by smtp.gmail.com with ESMTPSA id y23-20020a17090a105700b001efd39b7e39sm11428048pjd.37.2022.07.25.12.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 12:06:57 -0700 (PDT)
Date:   Mon, 25 Jul 2022 12:06:56 -0700
From:   Soumya Negi <soumya.negi97@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Anton Altaparmakov <anton@tuxera.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-ntfs-dev@lists.sourceforge.net,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ntfs: Ensure $Extend is a directory
Message-ID: <20220725190656.GA14927@Negi>
References: <20220724132107.1163-1-soumya.negi97@gmail.com>
 <Yt1NVQEOC6Ki3eUI@kroah.com>
 <20220724153448.GA2608@Negi>
 <Yt1rQ8Ft5klOOENg@kroah.com>
 <20220724221745.GB2608@Negi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220724221745.GB2608@Negi>
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

Hi,

On Sun, Jul 24, 2022 at 03:17:45PM -0700, Soumya Negi wrote:
> On Sun, Jul 24, 2022 at 05:54:43PM +0200, Greg KH wrote:
> > On Sun, Jul 24, 2022 at 08:34:48AM -0700, Soumya Negi wrote:
> > > On Sun, Jul 24, 2022 at 03:47:01PM +0200, Greg KH wrote:
> > > > On Sun, Jul 24, 2022 at 06:21:07AM -0700, Soumya Negi wrote:
> > > > > Fixes Syzbot bug: kernel BUG in ntfs_lookup_inode_by_name
> > > > > https://syzkaller.appspot.com/bug?id=32cf53b48c1846ffc25a185a2e92e170d1a95d71
> > > > > 
> > > > > Check whether $Extend is a directory or not( for NTFS3.0+) while loading
> > > > > system files. If it isn't(as in the case of this bug where the mft record for
> > > > > $Extend contains a regular file), load_system_files() returns false.
> > > > 
> > > > Please wrap your changelog text at 72 columns like your editor asked you
> > > > to when writing this :)
> > > 
> > > I will correct the changelog(Don't think I can wrap the bug report
> > > link. Checkpatch will still give a warning. Is that okay?).
> > 
> > Yes, do not wrap links.
> > 
> > > > > Reported-by: syzbot+30b7f850c6d98ea461d2@syzkaller.appspotmail.com
> > > > > Signed-off-by: Soumya Negi <soumya.negi97@gmail.com>
> > > > 
> > > > What commit caused this problem?  What Fixes: tag should go here?
> > > 
> > > I don't think this was caused by any specific commit.The $Extend
> > > directory check is not present in any previous releases. Syzbot has
> > > also not been able to produce a cause bisection for the bug. So no fixes
> > > tag(please correct me if I am wrong).
> > > 
> > > > Should it go to stable kernels?  If so, how far back?
> > > 
> > > Since the NTFS extension file was new to NTFS 3.0, perhaps the patch 
> > > should apply all the way back to the first release with NTFS3.0 support?
> 
> > Yes, mark it there.
> 
> Thanks. I will send v2 of the patch. Just want to make sure that the
> patch will apply to 2.6.11.y before marking it.

2.6.11 is where I think NTFS3.0 support was first present and till where
the patch should go. But I am not able to build 2.6.11 on my system and
test the patch. I tried the patch on 4.14 and it works. Should I mark it
to be backported till 4.14 instead?

With thanks,
Soumya
