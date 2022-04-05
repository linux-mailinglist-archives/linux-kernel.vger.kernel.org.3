Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F234F2149
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 06:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbiDECs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 22:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbiDECsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 22:48:11 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B31010EDF4
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 19:30:33 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id r2so13580246iod.9
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 19:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JTzIzbrqZyK9WcizVERi7qlxh5xxIEK+9IqWImCqDAY=;
        b=YcMVYnQMKz2NhQbrK0HjGTOXQmTu+Vk9t1j3Nfgnp7gS4pAl9K8ReC7ZTF3NS0ao62
         +k6BganfzYE1RHEvww+e/oOwq6C1n3EDSdgXuZrPrUp/3uVwkyfn+h+4qiNGraccB4KQ
         nIfDzn7o26dbdKpb851QTXPT7ZhljzDSnSko5y404+cDtwPiIHYDokLbazUURxbzDJYf
         0wCUTDsNI802WAuIUoPq6xTRWniX7nxbPjm5nqHr5UFiVd2OkMiVpH3V//O4UytUclaa
         R0jpdX1UgmZmW10eiTYtRmFvTG/l/HJtjLd+9wWEiVF0naJ4VQ9kG+1P5NjKQrF+efCb
         Vk2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JTzIzbrqZyK9WcizVERi7qlxh5xxIEK+9IqWImCqDAY=;
        b=gtbOLAwHUQka9GLXwnOhswGA8W2ojY0+R8aIf+TgNK8/X4ymstvgGWFjAVTTMGYa6T
         zyb/yxhsCUQhRNgfMv7XMi1s4cGfOmi/GRAyIH6evK3X0rLVGXBAzKQRojZUBps8Xfqy
         FtGioB/zOGUC/n3Z4swmo04YFLddS5oOYS0MstTpYzs9lZ9BGyNGu0pZuev0WNiCbigP
         3D+iRd2V8edeDH1EXZ0Ju8cpRaCH4b0r9bEi69BVhvTzzvwd2LRVMPMQI0Q3gOW0feA8
         h36tASCIyJmU9v4yXnHNMUHOeBgl+VNMo0PNb2dgmWEoPk5fVvfQ7U3HQ3tE4vnYTAf6
         eIPg==
X-Gm-Message-State: AOAM533FHwbtUEkUXA2SndxNvllANUtlAw5HbtXdy+z2KpgM8pUczkCN
        HGO6NEwFA56EA6Mk3XjXt4zSkgmNrSyyBnyvFfbgqA==
X-Google-Smtp-Source: ABdhPJwODLum9ilGhChVng+UBA9UPlj2zbdInzRba3Olr4b4wDij4kupJU4FIgzVrCfK1I45tTbjXWS8CK+5nB/27Fs=
X-Received: by 2002:a02:84c9:0:b0:31a:1cf2:4468 with SMTP id
 f67-20020a0284c9000000b0031a1cf24468mr806877jai.31.1649125832511; Mon, 04 Apr
 2022 19:30:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220331084151.2600229-1-yosryahmed@google.com>
 <CAAPL-u8g2qkhdTQtFtBS3GNYz0WnyahWEXvR4g_OSaKv+7EozA@mail.gmail.com>
 <YkcYq8F6MYlMi+yS@cmpxchg.org> <CAAPL-u-za-TTyyC5uMVev9eQyhxZS7q3pVqaUxCFjqk+Sv9+ig@mail.gmail.com>
 <CALvZod4-fKfv6vbZPZ3nCE=Bue4FUnC+9t27wsznmyd+JKgDbg@mail.gmail.com>
In-Reply-To: <CALvZod4-fKfv6vbZPZ3nCE=Bue4FUnC+9t27wsznmyd+JKgDbg@mail.gmail.com>
From:   Wei Xu <weixugc@google.com>
Date:   Mon, 4 Apr 2022 19:30:21 -0700
Message-ID: <CAAPL-u-7Vnq8tmmRNDOz7Jw1ei_Vw=idJaPzMPoq5=sBrpyrRA@mail.gmail.com>
Subject: Re: [PATCH resend] memcg: introduce per-memcg reclaim interface
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Cgroups <cgroups@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Jonathan Corbet <corbet@lwn.net>, Yu Zhao <yuzhao@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 4, 2022 at 10:08 AM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Fri, Apr 1, 2022 at 1:14 PM Wei Xu <weixugc@google.com> wrote:
> >
> [...]
> >
> > -EAGAIN sounds good, too.  Given that the userspace requests to
> > reclaim a specified number of bytes, I think it is generally better to
> > tell the userspace whether the request has been successfully
> > fulfilled. Ideally, it would be even better to return how many bytes
> > that have been reclaimed, though that is not easy to do through the
> > cgroup interface.
>
> What would be the challenge on returning the number of bytes reclaimed
> through cgroup interface?

write() syscall is used to write the command into memory.reclaim,
which should return either the number of command bytes written or -1
(errno is set to indicate the actual error).  I think we should not
return the number of bytes reclaimed through write().  A new
sys_reclaim() is better in this regard because we can define its
return value, though it would need a cgroup argument, which is not
commonly defined for syscalls.
