Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39FE5487AD6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 17:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348391AbiAGQ62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 11:58:28 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:42218 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240182AbiAGQ60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 11:58:26 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CD55A212C9;
        Fri,  7 Jan 2022 16:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1641574704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H8FQTxCSaXobv79wKMviWdxMIyZK3K1KzS8f/6eUeio=;
        b=Vj7Pn1v9b6e2yk3AO2G3XAA6rYAbLOJ1TtblVWH0NW18+yh5L4oafKVVCpbNmuEH+KaABF
        89jEE4DtBwthjOsXBSQ+y/JA1dLCARXSW29swHQxGyj9x/++TcF+mWu4BM9fN7zwTZkpfg
        bha1DVjmRMGw3kc4ZxOqwzyj33acxWE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1641574704;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H8FQTxCSaXobv79wKMviWdxMIyZK3K1KzS8f/6eUeio=;
        b=eHP7GlMOpEhfkAKy7wMaJH0n0Stew7ZEGmsS2l1i1rHiGX54sBR/6qZuGRMSjevRWVAlTG
        ZXQuxaHReWWa6KAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8CC9713D21;
        Fri,  7 Jan 2022 16:58:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mfKfITBx2GECOwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 07 Jan 2022 16:58:24 +0000
Message-ID: <91d662f1-baf6-1114-f237-a66ebc164009@suse.cz>
Date:   Fri, 7 Jan 2022 17:58:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] sysinfo: include availram field in sysinfo struct
Content-Language: en-US
To:     Pintu Agarwal <pintu.ping@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Cyrill Gorcunov <gorcunov@gmail.com>,
        Pintu Kumar <quic_pintu@quicinc.com>,
        open list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>, ebiederm@xmission.com,
        sfr@canb.auug.org.au, legion@kernel.org, sashal@kernel.org,
        chris.hyser@oracle.com, ccross@google.com, pcc@google.com,
        dave@stgolabs.net, caoxiaofeng@yulong.com, david@redhat.com,
        Linux API <linux-api@vger.kernel.org>
References: <1641483250-18839-1-git-send-email-quic_pintu@quicinc.com>
 <YdcUttZWaqYQpR1K@grain>
 <CAOuPNLifYFPU4Gt2+1sOSsYNNLQq7U2aGVaYknrhaMc-CVx8vg@mail.gmail.com>
 <Ydcmk+WaBWKlLkAw@grain> <20220107120451.z2eqru2tm5mlhla3@wittgenstein>
 <CAOuPNLiJZu_HJQ+Hf5BJOgmT+v7DT96VLkiXrfx0MJQrkD3rSw@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CAOuPNLiJZu_HJQ+Hf5BJOgmT+v7DT96VLkiXrfx0MJQrkD3rSw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC linux-api

On 1/7/22 14:44, Pintu Agarwal wrote:
> On Fri, 7 Jan 2022 at 17:35, Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
>>
>> On Thu, Jan 06, 2022 at 08:27:47PM +0300, Cyrill Gorcunov wrote:
>> > On Thu, Jan 06, 2022 at 10:19:55PM +0530, Pintu Agarwal wrote:
>> > > > > diff --git a/include/uapi/linux/sysinfo.h b/include/uapi/linux/sysinfo.h
>> > > > > index 435d5c2..6e77e90 100644
>> > > > > --- a/include/uapi/linux/sysinfo.h
>> > > > > +++ b/include/uapi/linux/sysinfo.h
>> > > > > @@ -12,6 +12,7 @@ struct sysinfo {
>> > > > >       __kernel_ulong_t freeram;       /* Available memory size */
>> > > > >       __kernel_ulong_t sharedram;     /* Amount of shared memory */
>> > > > >       __kernel_ulong_t bufferram;     /* Memory used by buffers */
>> > > > > +     __kernel_ulong_t availram;      /* Memory available for allocation */
>> > > > >       __kernel_ulong_t totalswap;     /* Total swap space size */
>> > > > >       __kernel_ulong_t freeswap;      /* swap space still available */
>> > > > >       __u16 procs;                    /* Number of current processes */
>> > > >
>> > > > Hi! Sorry, but I don't understand -- the sysinfo structure seems to
>> > > > be part of user API, no? Don't we break it up here?
>> > >
>> > > Yes, the corresponding user space header /usr/include/linux/sysinfo.h
>> > > also needs to be updated.
>> > > When we generate the kernel header it will be updated automatically.
>> >
>> > Wait. The userspace may pass old structure here, and in result we
>> > return incorrect layout which won't match old one, no? Old binary
>> > code has no clue about this header update.
>>
>> Yes, that won't work as done.
>>
>> If we want to do this it needs to be done at the end of the struct right
>> before the padding field and the newly added field substracted from the
>> padding. (Not the preferred way to do it these days for new structs.)
>>
>> A new kernel can then pass in the struct with the newly added field and
>> an old kernel can just fill the struct in as usual. New kernel will
>> update the field with the correct value.
>>
>> But there's a catch depending on the type of value.
>> The problem with these types of extensions is that you'll often need
>> indicators to and from the kernel whether the extension is supported.
>>
>> Consider an extension where 0 is a valid value meaning "this resource is
>> completely used". Since the kernel and userspace always agree on the
>> size of the struct the kernel will zero the whole struct. So if in your
>> newly added field 0 is a valid value you can't differentiate between 0
>> as a valid value indicating that your resource isn't available and 0 as
>> the kernel not supporting your extension.
>>
>> Other APIs solve this and similar problems by having a request mask and
>> a return mask.  Userspace fills in what values it wants reported in the
>> request mask and kernel sets the supported flags in the return mask.
>> This way you can differentiate between the two (see statx).
>>
>> If the 0 example is not a concern or acceptable for userspace it's
>> probably fine. But you need to document that having 0 returned can mean
>> both things.
>>
>> Or, you select a value different from 0 (-1?) that you can use to
>> indicate to userspace that the resource is used up so 0 can just mean
>> "kernel doesn't support this extension".
> 
> Thanks all for your inputs.
> As Eric suggested in other thread (pasting here for reference):
> {
>> Before the padding and you should reduce the size of the padding by the
>> size of your new field.
> 
>>> Also, I could not understand what this is for ?
>>> Do we need to update this since sture is changed ?
> 
>> In general padding like that is so new fields can be added.  The
>> comment about libc5 makes me a wonder a bit, but I expect libc5 just
>> added the padding in it's copy of the structure that it exported to
>> userspace many many years ago so that new fields could be added.
> 
>> Eric
> }
> 
> I made the changes like below and this seems to work even with older user space.
> I mean earlier, when I ran "free" command it was giving "stack
> smashing..." error,
> but now the "free" command (which comes as part of busybox) works fine
> even without recompiling with the updated header.
> 
> These are the header changes for quick look:
> {{{
> diff --git a/include/uapi/linux/sysinfo.h b/include/uapi/linux/sysinfo.h
> index 6e77e90..fe84c6a 100644
> --- a/include/uapi/linux/sysinfo.h
> +++ b/include/uapi/linux/sysinfo.h
> @@ -12,7 +12,6 @@ struct sysinfo {
>         __kernel_ulong_t freeram;       /* Available memory size */
>         __kernel_ulong_t sharedram;     /* Amount of shared memory */
>         __kernel_ulong_t bufferram;     /* Memory used by buffers */
> -       __kernel_ulong_t availram;      /* Memory available for allocation */
>         __kernel_ulong_t totalswap;     /* Total swap space size */
>         __kernel_ulong_t freeswap;      /* swap space still available */
>         __u16 procs;                    /* Number of current processes */
> @@ -20,7 +19,8 @@ struct sysinfo {
>         __kernel_ulong_t totalhigh;     /* Total high memory size */
>         __kernel_ulong_t freehigh;      /* Available high memory size */
>         __u32 mem_unit;                 /* Memory unit size in bytes */
> -       char _f[20-2*sizeof(__kernel_ulong_t)-sizeof(__u32)];   /*
> Padding: libc5 uses this.. */
> +       __kernel_ulong_t availram;      /* Memory available for allocation */
> +       char _f[20-3*sizeof(__kernel_ulong_t)-sizeof(__u32)];   /*
> Padding: libc5 uses this.. */
>  };
> }}}
> 
> If this is fine, I will push the new patch set.

Please CC linux-api@vger.kernel.org on the new posting.

> Thanks,
> Pintu
> 

