Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A18D4486871
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 18:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241800AbiAFR1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 12:27:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241717AbiAFR1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 12:27:51 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806A6C061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 09:27:51 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id x7so6411538lfu.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 09:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xrDSJluLNSKPl34N9XqI8DvYP0WMSapE6tHIi4bD13A=;
        b=jOg3DzTHtER2ZdDdjiiiYFHMeiuaMG5vHy9p1NR4zA8qALOOqvg64FgFVjRGWXkkSi
         aHN4KRuRCLtcVD3pCMrD10XakRwmXDSKgQ7ayaSvJ80mwgnkJUfvDtVKty1mRktWP+p6
         S9+05QA0Kk4tuwmxO172rCnsiY83zzH3Yr9hunsGoaYdSKP9yrJ5ZgBgis+Q7rN98X88
         pXwmMAXfe0yhKcND8OCKjLqA75NHrH5Vaj+3lgbPlIgPIsaTyGFkdloPGA1yEGDbyuxh
         fcoGa95v907JDkpEoaV+u379NprSyqZOOkrU+OM86e2yDRREqG5UFBcv/qyfFYZi2bci
         yAIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xrDSJluLNSKPl34N9XqI8DvYP0WMSapE6tHIi4bD13A=;
        b=PPbnMcNK7qTx2BzjKPh946n4YxNnp7uL7o34fASGE9MYlNYwp9nRKjE+L42fgYFwn6
         jtotcjb5cth/FpqYUF9f4MutjL16ZGTwcbFPIk7YSjjqAU7v7B26L6P4gf0TONmDEKbI
         9dRcZU0oeqhjSTVlbUqsvgIh/+g/9dcZ7GrnHtTWKa8X3Exz5N8kB55biXuor4/imRc2
         17uPOtfeZAGFtAv87LFQfur3ffKjaDLL4QwdrYFRcl6kvdt6FP3UIK3Ch9pnXfdl8SZ0
         2YYzQdAbn+Q7Bjre5GNJYIXeDZS5uczHWDirV4ToIVdVexMGa54GCxAOIpWQ/wgL9rNq
         H7CA==
X-Gm-Message-State: AOAM530AlZFuBLyNoKPUqko1BFeoRGtPqVSpZz9bYrRKQ0bof7av3x4I
        BAsj+3WdMpYB40w/INNNKsI=
X-Google-Smtp-Source: ABdhPJwVYF+CDRmVjHyZAGlOSGAzUJUK4EWKHnkNh0kFyM+8cYtJBMASj3H3tRcDlAeyKSXilBPyeg==
X-Received: by 2002:a05:6512:20c2:: with SMTP id u2mr45413117lfr.376.1641490069772;
        Thu, 06 Jan 2022 09:27:49 -0800 (PST)
Received: from grain.localdomain ([5.18.251.97])
        by smtp.gmail.com with ESMTPSA id d5sm235224lfl.242.2022.01.06.09.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 09:27:48 -0800 (PST)
Received: by grain.localdomain (Postfix, from userid 1000)
        id CC0535A0020; Thu,  6 Jan 2022 20:27:47 +0300 (MSK)
Date:   Thu, 6 Jan 2022 20:27:47 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Pintu Agarwal <pintu.ping@gmail.com>
Cc:     Pintu Kumar <quic_pintu@quicinc.com>,
        open list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>, ebiederm@xmission.com,
        christian.brauner@ubuntu.com, sfr@canb.auug.org.au,
        legion@kernel.org, sashal@kernel.org, chris.hyser@oracle.com,
        ccross@google.com, pcc@google.com, dave@stgolabs.net,
        caoxiaofeng@yulong.com, david@redhat.com
Subject: Re: [PATCH] sysinfo: include availram field in sysinfo struct
Message-ID: <Ydcmk+WaBWKlLkAw@grain>
References: <1641483250-18839-1-git-send-email-quic_pintu@quicinc.com>
 <YdcUttZWaqYQpR1K@grain>
 <CAOuPNLifYFPU4Gt2+1sOSsYNNLQq7U2aGVaYknrhaMc-CVx8vg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOuPNLifYFPU4Gt2+1sOSsYNNLQq7U2aGVaYknrhaMc-CVx8vg@mail.gmail.com>
User-Agent: Mutt/2.0.7 (2021-05-04)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2022 at 10:19:55PM +0530, Pintu Agarwal wrote:
> > > diff --git a/include/uapi/linux/sysinfo.h b/include/uapi/linux/sysinfo.h
> > > index 435d5c2..6e77e90 100644
> > > --- a/include/uapi/linux/sysinfo.h
> > > +++ b/include/uapi/linux/sysinfo.h
> > > @@ -12,6 +12,7 @@ struct sysinfo {
> > >       __kernel_ulong_t freeram;       /* Available memory size */
> > >       __kernel_ulong_t sharedram;     /* Amount of shared memory */
> > >       __kernel_ulong_t bufferram;     /* Memory used by buffers */
> > > +     __kernel_ulong_t availram;      /* Memory available for allocation */
> > >       __kernel_ulong_t totalswap;     /* Total swap space size */
> > >       __kernel_ulong_t freeswap;      /* swap space still available */
> > >       __u16 procs;                    /* Number of current processes */
> >
> > Hi! Sorry, but I don't understand -- the sysinfo structure seems to
> > be part of user API, no? Don't we break it up here?
> 
> Yes, the corresponding user space header /usr/include/linux/sysinfo.h
> also needs to be updated.
> When we generate the kernel header it will be updated automatically.

Wait. The userspace may pass old structure here, and in result we
return incorrect layout which won't match old one, no? Old binary
code has no clue about this header update.
