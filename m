Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C58B48774C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 13:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238481AbiAGMFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 07:05:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238110AbiAGME7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 07:04:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A909C061201
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 04:04:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EDCA060AB3
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 12:04:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FAFFC36AE0;
        Fri,  7 Jan 2022 12:04:54 +0000 (UTC)
Date:   Fri, 7 Jan 2022 13:04:51 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Cyrill Gorcunov <gorcunov@gmail.com>
Cc:     Pintu Agarwal <pintu.ping@gmail.com>,
        Pintu Kumar <quic_pintu@quicinc.com>,
        open list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>, ebiederm@xmission.com,
        sfr@canb.auug.org.au, legion@kernel.org, sashal@kernel.org,
        chris.hyser@oracle.com, ccross@google.com, pcc@google.com,
        dave@stgolabs.net, caoxiaofeng@yulong.com, david@redhat.com
Subject: Re: [PATCH] sysinfo: include availram field in sysinfo struct
Message-ID: <20220107120451.z2eqru2tm5mlhla3@wittgenstein>
References: <1641483250-18839-1-git-send-email-quic_pintu@quicinc.com>
 <YdcUttZWaqYQpR1K@grain>
 <CAOuPNLifYFPU4Gt2+1sOSsYNNLQq7U2aGVaYknrhaMc-CVx8vg@mail.gmail.com>
 <Ydcmk+WaBWKlLkAw@grain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Ydcmk+WaBWKlLkAw@grain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2022 at 08:27:47PM +0300, Cyrill Gorcunov wrote:
> On Thu, Jan 06, 2022 at 10:19:55PM +0530, Pintu Agarwal wrote:
> > > > diff --git a/include/uapi/linux/sysinfo.h b/include/uapi/linux/sysinfo.h
> > > > index 435d5c2..6e77e90 100644
> > > > --- a/include/uapi/linux/sysinfo.h
> > > > +++ b/include/uapi/linux/sysinfo.h
> > > > @@ -12,6 +12,7 @@ struct sysinfo {
> > > >       __kernel_ulong_t freeram;       /* Available memory size */
> > > >       __kernel_ulong_t sharedram;     /* Amount of shared memory */
> > > >       __kernel_ulong_t bufferram;     /* Memory used by buffers */
> > > > +     __kernel_ulong_t availram;      /* Memory available for allocation */
> > > >       __kernel_ulong_t totalswap;     /* Total swap space size */
> > > >       __kernel_ulong_t freeswap;      /* swap space still available */
> > > >       __u16 procs;                    /* Number of current processes */
> > >
> > > Hi! Sorry, but I don't understand -- the sysinfo structure seems to
> > > be part of user API, no? Don't we break it up here?
> > 
> > Yes, the corresponding user space header /usr/include/linux/sysinfo.h
> > also needs to be updated.
> > When we generate the kernel header it will be updated automatically.
> 
> Wait. The userspace may pass old structure here, and in result we
> return incorrect layout which won't match old one, no? Old binary
> code has no clue about this header update.

Yes, that won't work as done.

If we want to do this it needs to be done at the end of the struct right
before the padding field and the newly added field substracted from the
padding. (Not the preferred way to do it these days for new structs.)

A new kernel can then pass in the struct with the newly added field and
an old kernel can just fill the struct in as usual. New kernel will
update the field with the correct value.

But there's a catch depending on the type of value.
The problem with these types of extensions is that you'll often need
indicators to and from the kernel whether the extension is supported.

Consider an extension where 0 is a valid value meaning "this resource is
completely used". Since the kernel and userspace always agree on the
size of the struct the kernel will zero the whole struct. So if in your
newly added field 0 is a valid value you can't differentiate between 0
as a valid value indicating that your resource isn't available and 0 as
the kernel not supporting your extension.

Other APIs solve this and similar problems by having a request mask and
a return mask.  Userspace fills in what values it wants reported in the
request mask and kernel sets the supported flags in the return mask.
This way you can differentiate between the two (see statx).

If the 0 example is not a concern or acceptable for userspace it's
probably fine. But you need to document that having 0 returned can mean
both things.

Or, you select a value different from 0 (-1?) that you can use to
indicate to userspace that the resource is used up so 0 can just mean
"kernel doesn't support this extension".
