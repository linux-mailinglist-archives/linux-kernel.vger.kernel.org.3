Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7D2D49DD04
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 09:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237970AbiA0Ix4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 03:53:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237964AbiA0Ixy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 03:53:54 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73718C061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 00:53:53 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id q141-20020a1ca793000000b00347b48dfb53so1416339wme.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 00:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tAZkRS0zISR6/ST82zfNsuCXAgYUqMk5bLScTB/6bDI=;
        b=M2+qQzGl5ciYwNaPRKcaH+tVSf8L4kyixxaYiTiyQzYJMRaxrGJqvAzPh9pSoQuSoQ
         2sPOuNUSTE8AfL6G7MPHtlVh347cfSmcbB++PiDLTpnHKr7kime8ZjuWRKd8A3OfWMC0
         jPtCJM4dAF0cwpdA15iMd/Pe2jUEYlqE6FHvAGE9tgTRu8GSe456ZQ5qDLV18U5dbfPA
         Nm7IlhoKo31TQtDRkUgE5G9qohJrBADwaGvi/pW5ixTyxneJIRMADKhcaN+yfOWX6juS
         5DeDNarNO2by+f7sc2Kq4gf0xsf3IWsFHW4baa8L4mDlnLYjbwFztYmJW5MnryEdLrHL
         Il1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tAZkRS0zISR6/ST82zfNsuCXAgYUqMk5bLScTB/6bDI=;
        b=HEqEFS7evj6K0BJdkw/EntOWb/NZXbo3l9pogiCtOX0Jo5PQfeAvUVdfRXj0k7WEB6
         tvJdfdvzhQJwl+4SfPZ7gaank3ArnIBVzOo6vyDBtOzw/wslnllrAhdkfeWcC9xdlAru
         eB/dHYFVDmfNPVRh2jo/gipozK7fAokoZHmaEIB6QGVH89RcvX8DSDkRP578SnLkblpH
         NrLLZFVNmnSehuoIKrKxJTSwgFv1ZMoBe3GbBe/7u/JPy/uIjYbpXEXLP4Bf3ZUC7WzC
         gxV28uzkmho3cYzLCFYlMOx11dWvundb8Z/L+cqbgHBCoaMT/mR9NxvDFy75bBCIqQJ7
         /5Yw==
X-Gm-Message-State: AOAM533U7mMGaZrvhzOv5+xh0pDOk9zirVzJRI9FPHTtkjIsktpZTjH7
        gUIBhgEqNCALWG91m3uNmCLmMHz9zf0vsw==
X-Google-Smtp-Source: ABdhPJwqB7j5wlrJmYrVPNjzOHlRcFxsUl14AAc9JhmKY6CqfGASXfkg+SlMJFARfIS1bO1dLK5Fmg==
X-Received: by 2002:a1c:4d16:: with SMTP id o22mr10716698wmh.84.1643273632082;
        Thu, 27 Jan 2022 00:53:52 -0800 (PST)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id i11sm1847204wry.102.2022.01.27.00.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 00:53:51 -0800 (PST)
Date:   Thu, 27 Jan 2022 08:53:49 +0000
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     gregkh@linuxfoundation.org, dan.carpenter@oracle.com,
        Larry.Finger@lwfinger.net, straube.linux@gmail.com,
        martin@kaiser.cx, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/10] staging: r8188eu: remove DBG_88E calls from
 os_dep/ioctl_linux.c
Message-ID: <YfJdnTKa/gF9TEV5@equinox>
References: <20220124224415.831-1-phil@philpotter.co.uk>
 <20220124224415.831-7-phil@philpotter.co.uk>
 <a681a562-eb41-9dc8-703a-5b235c15a3a1@gmail.com>
 <YfCgQbFxfVZXw9Fg@equinox>
 <b5bbe488-ac43-fd89-7c65-36bfa9c903a6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5bbe488-ac43-fd89-7c65-36bfa9c903a6@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 01:26:08PM +0300, Pavel Skripkin wrote:
> Hi Phillip,
> 
> On 1/26/22 04:13, Phillip Potter wrote:
> 
> [snip]
> 
> }
> > > 
> > > And here you also removes the reads. I guess, some kind of magic pattern is
> > > used
> > > 
> > 
> > So these calls are macro arguments, they would never be executed under
> > normal circumstances anyway, unless the rtw_debug kernel module was
> > passed in as 5 or more - it is 1 by default. The DBG_88E macro would
> > expand during preprocessing phase to (for example):
> > 
> > do {
> > 	if (5 <= GlobalDebugLevel)
> > 		pr_info("R8188EU: " "dbg(0x450) = 0x%x\n", rtw_read32(padapter, 0x450));
> > } while (0)
> > 
> > As this is never executed under normal circumstances anyway, I would say
> > calls like these are therefore safe to remove. Happy to be convinced
> > though :-) Many thanks.
> > 
> 
> I see your point, thanks for explanation.
> 
> Well, in this case, you may left all reads, that are executed during normal
> lifetime of a driver. We know, that there is at least 1 place, where read()
> call removal can break things. Might be there are couple of other places we
> don't know about.
> 
> IMHO the best thing you can do is to leave these reads and leave a comment
> like "hey, please remove me and test". One day useless reads should be
> anyway removed, since ideally rtw_read family must get __must_check
> annotation + normal error handling.
> 

Yeah, not a bad idea - I've tried to remove only those which don't look
like they'd have side effects (such as fwstate checks etc.), but by all
means I can put them back in with the next revision. Thanks.

Regards,
Phil
