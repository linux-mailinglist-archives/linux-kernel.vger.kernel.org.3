Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE6D74974B9
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 19:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239681AbiAWSnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 13:43:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:33763 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240138AbiAWSmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 13:42:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642963326;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cY1U+lDZEduaUwZDUPPFY/UPA4Nbu9quyT81CXEx4PE=;
        b=ViQy58BXzaHacVRa7DcyLLxVfDBz4MwcS1EnyDFE3bCCQbaxsSm+iSv6qYi2TflpOo8d6Q
        on7JZdEzWVEpsRYRIyPZpyExArIrnt3xyVw/TMldzKrPQLwle1NhKvf3aman6SucENxBXI
        GAfe6CD88mVZRtUbysjaW3QKvUzVLIA=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-593-tXa6qcJnPVie-WdLNahUBg-1; Sun, 23 Jan 2022 13:42:03 -0500
X-MC-Unique: tXa6qcJnPVie-WdLNahUBg-1
Received: by mail-qk1-f199.google.com with SMTP id k190-20020a37a1c7000000b0047d8a74b130so890088qke.10
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 10:42:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cY1U+lDZEduaUwZDUPPFY/UPA4Nbu9quyT81CXEx4PE=;
        b=GVmhgGPU2wWeetdqypGx2usGrUwNhf3HS9Mr0XWz15YQL8BYQLp7NURIAf6smbF1YS
         fnSHMD/drSVe7UKLsQaYv0rBNBLvE5XESuFCW8KPlCPW+JEgb7G5kVnTc/GZU3MLZ8Tl
         9ZG9VeoQKEOiyeUXjCm9YPmhTqlKogGa02MCI9fJ9zEmuZ+G8h563jN65e+tpeuPeQIW
         Zcva+9IUghD3OjeBqA9aK0Ff9VZrBeMU0J/xfIZTiM4a5HZ+ye8T54whbouZU7sCD+bF
         vdrXIp9kfgwEIh+pbkrH9wZXOuBUHZT8tb6JYbVPtgZIdLH0L9pnSBe7Ujj4WRHHT3S0
         lh6A==
X-Gm-Message-State: AOAM532dgi3Tp342sq6MZzHJfYDnvyCHtuPKF5pnszpUMkwSFJxB5JGy
        eTxen55G59dGDYPRLLv3tHvQ+yQ5zMox+kkgJgpce7oMp9/3YWwJJl4iNFlUU0TPwlYWKui+Qlh
        26mmWfIvzgFjFR4ruj+kon8GHd3/EFlKwYc5Npxyi
X-Received: by 2002:ac8:7fce:: with SMTP id b14mr9929563qtk.339.1642963323221;
        Sun, 23 Jan 2022 10:42:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzgrnfftQev+/e1bfthcVXrqsS2NkZk7XaembGAyAtcFzDuZvrfItLL05jZqccEw/AGJEmBtbd/PLqLmStx2NU=
X-Received: by 2002:ac8:7fce:: with SMTP id b14mr9929550qtk.339.1642963322945;
 Sun, 23 Jan 2022 10:42:02 -0800 (PST)
MIME-Version: 1.0
References: <202201221028.YKA8kSdm-lkp@intel.com> <CAK-6q+h_hb94J3DSXPk=E44kCxiwZ+BE3kMJe09iShRzMb=vzQ@mail.gmail.com>
 <91901e7b-7d82-116c-aaf2-c74c6a6b999c@infradead.org>
In-Reply-To: <91901e7b-7d82-116c-aaf2-c74c6a6b999c@infradead.org>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Sun, 23 Jan 2022 13:41:52 -0500
Message-ID: <CAK-6q+j2jc3pBmbvQ-DCmxveC-UMV75SFc2nC1zwXKe9wm4YPg@mail.gmail.com>
Subject: Re: fs/dlm/midcomms.c:913:22: sparse: sparse: restricted __le32
 degrades to integer
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, David Teigland <teigland@redhat.com>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-sparse@vger.kernel.org, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On Sat, Jan 22, 2022 at 2:19 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
>
>
> On 1/22/22 10:28, Alexander Aring wrote:
> > Hi,
> >
> > On Fri, Jan 21, 2022 at 9:45 PM kernel test robot <lkp@intel.com> wrote:
> >>
> >> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> >> head:   9b57f458985742bd1c585f4c7f36d04634ce1143
> >> commit: 658bd576f95ed597e519cdadf1c86ac87c17aea5 fs: dlm: move version conversion to compile time
> >> date:   3 months ago
> >> config: x86_64-rhel-8.3-kselftests (https://download.01.org/0day-ci/archive/20220122/202201221028.YKA8kSdm-lkp@intel.com/config)
> >> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> >> reproduce:
> >>         # apt-get install sparse
> >>         # sparse version: v0.6.4-dirty
> >>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=658bd576f95ed597e519cdadf1c86ac87c17aea5
> >>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >>         git fetch --no-tags linus master
> >>         git checkout 658bd576f95ed597e519cdadf1c86ac87c17aea5
> >>         # save the config file to linux build tree
> >>         mkdir build_dir
> >>         make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash
> >>
> >> If you fix the issue, kindly add following tag as appropriate
> >
> > I have it on my list but it isn't easy to make sparse happy here...
> > this is the second time the robot reported this issue. Is there a way
> > to turn the robot off in that case?
> >
> > Maybe some human who reads that knows the answer?
>
> Hi Alex,
>
> In the source file, you can surround the "offending" line(s) with
>
> #ifndef __CHECKER__
>  ...
> #endif
>
> to prevent sparse from checking those lines.
> Sometimes there needs to be an "#else" branch also.
>
> 'git grep __CHECKER__' will show you quite a few other examples.
>

Thanks, I will try that to stop the false positives and endianness
warnings (temporarily).

I see also:

fs/dlm/midcomms.c:213:1: sparse: sparse: symbol
'__srcu_struct_nodes_srcu' was not declared. Should it be static?

For a macro which contains the "static" keyword, it's
"DEFINE_STATIC_SRCU()". Either sparse should be teached to deal with
that or everybody should use "static DEFINE_SRCU()" instead of using
"DEFINE_STATIC_SRCU()".
I would like to see the second way because everybody can see "static"
is being used, that means maybe we should remove
"DEFINE_STATIC_SRCU()"? The alternative by doing nothing would be to
use "#ifndef __CHECKER__".

I cc here rcu@vger.kernel.org and linux-sparse@vger.kernel.org, maybe
this can be discussed?

- Alex

