Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6F7649EDBD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 22:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237446AbiA0Vty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 16:49:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236680AbiA0Vtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 16:49:53 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40968C061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 13:49:53 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id m14so6941852wrg.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 13:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NSTuMQ29P1XBi4TieoHgf4CGHQOXsIVX8Pd9fWuFFW8=;
        b=E3TmpioE/bzIZZ1EgjenYN9MSo8miRK6kIuFS5p2RLKnTU7/lVad8NY4VuDT4Hmww2
         Bt2pqCBP4A6BC/LfEmLYDXPbCj4Vd6kad9keHtVPEESyafxOJzcqHRNUVAUn4+1NwcAz
         PFDJ+YtuaORsWuJXFjgHWFHT/6OHPDd0PhOCzKpD1TB7Fwbb2SiRRkV1C+L1VfbQ6rw0
         e4Eot2kN6dNxEN5in6+v6t1Ev1wy36LkH/E0SeRmOP+08WHLKzC4LQufU0YdaTF1ZODF
         NohAlNtZr5viaiXVC8JvS33Cri5+pYngVAK4jPDsetrA+0Y7F+JRhNOzlDQ2fuVyPeoM
         9bVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=NSTuMQ29P1XBi4TieoHgf4CGHQOXsIVX8Pd9fWuFFW8=;
        b=RLfa6kHUuVuNfNaiKvQ1MWjx9/h934DAZLJXFHtKtFRfrCHPTZut76R1rxBop3nVI2
         MGUeAD5NqrdFnkV0QyrIyp2zPbU7uMJWPgnPAmg34orcAVHUR6OPQTLEuqAHdFV34IZ2
         tmULkzf4h1G9HDxRoeNwKWOh6/8ynI5+IUnHDFzY7o5K/FEQb/FA4RvTbZbN58MUk7Fa
         KGRPFuhXYdF52J5Frkg17f/vI3HJD3hMT7HtcQjrZGCLSeORgOSAC7uASbtutRzGYqYA
         UVUihr98dNJkYCoCl6o8++DEu4CiGu4unRQaHzg/WgsXBY6k9KNA1zQfAGveFwPwL/4R
         w+JQ==
X-Gm-Message-State: AOAM533xyP07z74qkWkQD4T8sq+cK9Y/IrKqPI7pe14Q5jdm5kT1AiIt
        RbfjRLUU+ToICUDdMgRwCas=
X-Google-Smtp-Source: ABdhPJzqZxnxA2rUicW0hZxIPipd/wD5SXm0HQ8yrWe/IO9WtmQKA2wxsMcZHlt6IDiD28DYqmOZrQ==
X-Received: by 2002:adf:fa8f:: with SMTP id h15mr4473355wrr.235.1643320191876;
        Thu, 27 Jan 2022 13:49:51 -0800 (PST)
Received: from eldamar (80-218-24-251.dclient.hispeed.ch. [80.218.24.251])
        by smtp.gmail.com with ESMTPSA id l15sm380398wmh.6.2022.01.27.13.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 13:49:51 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Date:   Thu, 27 Jan 2022 22:49:50 +0100
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     Christian Kujau <lists@nerdbynature.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH] Re: filesystem being remounted supports timestamps until
 2038
Message-ID: <YfMTfiHk30UrCK/y@eldamar.lan>
References: <alpine.DEB.2.21.99999.375.1912201332260.21037@trent.utfs.org>
 <alpine.DEB.2.21.99999.375.1912261445200.21037@trent.utfs.org>
 <CAHk-=wim6VGnxQmjfK_tDg6fbHYKL4EFkmnTjVr9QnRqjDBAeA@mail.gmail.com>
 <alpine.DEB.2.21.99999.375.2001041545350.21037@trent.utfs.org>
 <alpine.DEB.2.22.1.446.2006231719390.3892@trent.utfs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.1.446.2006231719390.3892@trent.utfs.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jun 23, 2020 at 05:26:49PM -0700, Christian Kujau wrote:
> On Sat, 4 Jan 2020, Christian Kujau wrote:
> > On Sun, 29 Dec 2019, Linus Torvalds wrote:
> > > >     When file systems are remounted a couple of times per day (e.g. rw/ro for backup
> > > >     purposes), dmesg gets flooded with these messages. Change pr_warn into pr_debug
> > > >     to make it stop.
> > > 
> > > How about just doing it once per mount?
> > 
> > Yes, once per mount would work, and maybe not print a warning on remounts 
> > at all.
> 
> Is there any chance that this can be revisited perhaps? This is still 
> flooding my dmesg just because I have that (curde?) mechanism in place to 
> remount the backup device after the hourly backup-run to read-only. Sure, 
> I could omit that ("Doc, it hurts when I do that", as Al would comment), 
> but that's really the only repeating message that gets triggered because 
> of this. 1067 messages in ~60 days of uptime :-|
> 
> Does the patch below make any sense, would that work?
> 
> Please reconsider,
> Christian.
> 
> > Commit f8b92ba67c5d ("mount: Add mount warning for impending timestamp 
> > expiry") introduced:
> > 
> >    Mounted %s file system at %s supports timestamps until [...]
> > 
> > in mnt_warn_timestamp_expiry(), but then 0ecee6699064 ("fs/namespace.c: 
> > fix use-after-free of mount in mnt_warn_timestamp_expiry") changed this to
> > 
> >   %s filesystem being %s at %s supports timestamps until [...]
> > 
> > in order to fix a use-after-free.
> > 
> > > Of course, if you actually unmount and completely re-mount a
> > > filesystem, then that would still warn multiple times, but at that
> > > point I think it's reasonable to do.
> > 
> > Yes, of course. Umount/remount cycles should still issue a warning, but 
> > "-o remount" should not, IMHO.
> > 
> > Thanks,
> > Christian.
> 
> commit c9a5338b4930cdf99073042de0717db43d7b75be
> Author: Christian Kujau <lists@nerdbynature.de>
> Date:   Thu Dec 26 17:39:57 2019 -0800
> 
>     Commit f8b92ba67c5d ("mount: Add mount warning for impending timestamp expiry") resp.
>     0ecee6699064 ("fix use-after-free of mount in mnt_warn_timestamp_expiry()") introduced
>     a pr_warn message and the following gets sent to dmesg on every remount:
>     
>      [...] filesystem being remounted at /mnt supports timestamps until 2038 (0x7fffffff)
>     
>     When file systems are remounted a couple of times per day (e.g. rw/ro for backup
>     purposes), dmesg gets flooded with these messages. Change pr_warn into pr_debug
>     to make it stop.
>     
>     Signed-off-by: Christian Kujau <lists@nerdbynature.de>
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index be601d3a8008..afc6a13e7316 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -2478,7 +2478,7 @@ static void mnt_warn_timestamp_expiry(struct path *mountpoint, struct vfsmount *
>  
>  		time64_to_tm(sb->s_time_max, 0, &tm);
>  
> -		pr_warn("%s filesystem being %s at %s supports timestamps until %04ld (0x%llx)\n",
> +		pr_debug("%s filesystem being %s at %s supports timestamps until %04ld (0x%llx)\n",
>  			sb->s_type->name,
>  			is_mounted(mnt) ? "remounted" : "mounted",
>  			mntpath,

This is somehow prompted by a recent update in
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=996876#46 . 

The discussion on the above seems to have stalled, is this still
something worth persuing or should it be further ignored?

Regards,
Salvatore
