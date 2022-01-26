Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE1D749D1E3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 19:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbiAZSjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 13:39:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31345 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229478AbiAZSjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 13:39:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643222381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b9o6V+tZDb8Yj7qyJiHKfvxGFT9XTISplnHY/OXHxgs=;
        b=V2QVTKjALlnLej2OnsL2xiu1qwzFCxJsT9mZ2lJ9nErBKBI8oZcwBj3bi87e22W+1OPJU6
        BUWVviQZUH4zeBEBgFs4JNqjCEWuD20PW51KQMeIGDaYKcSBCcbITqXXPc/mOp0t7nFezg
        49VgLZJJmDIbp0+qudOSmmTcI5TGrvE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-340-zNZ-CJWmMVWqPb7Xab5qAg-1; Wed, 26 Jan 2022 13:39:40 -0500
X-MC-Unique: zNZ-CJWmMVWqPb7Xab5qAg-1
Received: by mail-wr1-f71.google.com with SMTP id m17-20020adfa3d1000000b001dd66c10c0cso97555wrb.19
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 10:39:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b9o6V+tZDb8Yj7qyJiHKfvxGFT9XTISplnHY/OXHxgs=;
        b=TrWCMnPqtmfbxYxCupdtX2VqvBhRlxATNNGNVIVreCvXgInx1uLuPFBo8rjN2xWixc
         ubCWDnBxpmF/RJeGfg5uVPgEPURhId4E0xeroqdM9R1w1m0gvcd+zd3LKVqyNtusnmcN
         BahCFg+wB74z3WzKVLwqNFDWdPfzTrD1s0AsZjRtHDCqSrcygWXvQaFbUaK0mfo0i8nC
         DVc2Yyo9U5G74ZHP//eHiHgoBJCno5wLwV7PTX8WQ1ro+Bb2Pdt8NoBFMmTKLFTlg/fP
         HfujZtK5rylaRFLurGwasagZGMS7dxO4FnM/On1FfpX6m7/Q81q3HiAr/+BAa6uDyiYG
         pn1Q==
X-Gm-Message-State: AOAM5316BzvVKB4ea0TzRQvwP8C+SjSieJGxO8DV8HOUjHimgF5kxrtI
        kqqFPOIdUTjJ6tKWs7nx35TYwCIiA+Nwru6+uYTVBDgu/coP+KfTeNAlxlo/YjyLVHoL4fvLpIX
        uY8vuEQzeBy2P7Ia7mlMR56O9
X-Received: by 2002:adf:e444:: with SMTP id t4mr23469309wrm.325.1643222379359;
        Wed, 26 Jan 2022 10:39:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyfhiPSDyIK6O2Jg9WJbv10h2Cyepp5IX7xwVzNUp99cfzHpUU5mkcoEnDViPa0ONyKdePCaw==
X-Received: by 2002:adf:e444:: with SMTP id t4mr23469299wrm.325.1643222379187;
        Wed, 26 Jan 2022 10:39:39 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id f6sm47352wrj.26.2022.01.26.10.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 10:39:38 -0800 (PST)
Date:   Wed, 26 Jan 2022 19:39:37 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH v5 2/9] fprobe: Add ftrace based probe APIs
Message-ID: <YfGVab8kNW1AkYXk@krava>
References: <164311269435.1933078.6963769885544050138.stgit@devnote2>
 <164311271777.1933078.9066058105807126444.stgit@devnote2>
 <YfAoMW6i4gqw2Na0@krava>
 <YfA9aC5quQNc89Hc@krava>
 <20220126115022.fda21a3face4e97684f5bab9@kernel.org>
 <20220127005952.42dd07ff5f275e61be638283@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127005952.42dd07ff5f275e61be638283@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 12:59:52AM +0900, Masami Hiramatsu wrote:
> On Wed, 26 Jan 2022 11:50:22 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > > one more question..
> > > 
> > > I'm adding support for user to pass function symbols to bpf fprobe link
> > > and I thought I'd pass symbols array to register_fprobe, but I'd need to
> > > copy the whole array of strings from user space first, which could take
> > > lot of memory considering attachment of 10k+ functions
> > > 
> > > so I'm thinking better way is to resolve symbols already in bpf fprobe
> > > link code and pass just addresses to register_fprobe
> > 
> > That is OK. Fprobe accepts either ::syms or ::addrs.
> > 
> > > 
> > > I assume you want to keep symbol interface, right? could we have some
> > > flag ensuring the conversion code is skipped, so we don't go through
> > > it twice?
> > 
> > Yeah, we still have many unused bits in fprobe::flags. :)
> 
> Instead of that, according to Steve's comment, I would like to introduce
> 3 registration APIs.
> 
> int register_fprobe(struct fprobe *fp, const char *filter, const char *notrace);
> int register_fprobe_ips(struct fprobe *fp, unsigned long *addrs, int num);
> int register_fprobe_syms(struct fprobe *fp, const char **syms, int num);
> 
> The register_fprobe_ips() will not touch the @addrs. You have to set the
> correct ftrace location address in the @addrs.

ok, sounds good

thanks,
jirka

