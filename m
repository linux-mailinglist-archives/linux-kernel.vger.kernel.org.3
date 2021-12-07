Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 607D346B222
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 06:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbhLGFU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 00:20:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232346AbhLGFUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 00:20:24 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1A7C061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 21:16:55 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id i12so12325885pfd.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 21:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=7rVpB2obUtQAzy/ztIP86+jcl70yMLbAUkD64M1M/30=;
        b=BOVegIgTDmQbCpRQw/zV0k4oGhCWdbKE4qF2A2ozvwbC4YhQqTcfY4nQXDS9hDe6ae
         cwvPZg33AGOgP/IDpCxVgAsHH0i+r643oDXTybiBrmSPMp1gJDNSWqJD2ybOSiXRuXFD
         GMS9vHkdixiVyc9XJ+iZSFOqz0FeLkeXwVPwQKdyK+nPyjyCRbyG66/EH5hYc47syX9c
         IXbZwPin4q7MBKLwGTRb2KQdnE0+J35pgZGcKMLlRxv3sXHVPb3plzCIEMLyXIQh2Bmw
         dl1INbt9UNMcqv6KBs557x2FGU9uiskpwcYc9oGbjuC5t7couyzdBaP8Uqeyw4TwjBQv
         f/cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=7rVpB2obUtQAzy/ztIP86+jcl70yMLbAUkD64M1M/30=;
        b=KKtZqq03jof4HJm+cuDh+wWwBaId6Sje2fNSWEOI0JszAp+CtDYDY1kCYX/VxL6ORR
         yVq3/5IoPmfwNIehYC1uZjP0VFxnIbSiSGBNuE2w5bXKAuzfxU9ZJZSyEyL88iWV3hux
         o4z1u9IEzy1d6mgmZCqjnjvzTmjN4dbepvdsgaykle0DnyO0B2oqU1tF4693prUtpODq
         UuZYAChfV5E3h9pGDAZgmrN5el9nVbSMgvurpau+cw/gwDjltVWLcdUlTP9CpmMxeBC2
         eaOiChIG/cxRpCUgvF0ygpRKtlRLwnd0pfwynVSaXAics55xeS3xCyQsTVjVaNXkNO+l
         K8FA==
X-Gm-Message-State: AOAM532LXN2hxBCAQwmx3Jdtcngj2dl/VtsXMoFJzHAKXwTuFB7oEGnt
        ydHjkZcrRc2fzz2L1n+8DnE=
X-Google-Smtp-Source: ABdhPJx+gpWR1cKsPRdHy8PHWH4WEek0lo348LJSSLFYC94Bdqvm8W1uF0WZlv/OYOdsjP5xpyRorw==
X-Received: by 2002:a05:6a00:2151:b0:4a2:5c9a:f0a9 with SMTP id o17-20020a056a00215100b004a25c9af0a9mr41931909pfk.39.1638854214595;
        Mon, 06 Dec 2021 21:16:54 -0800 (PST)
Received: from localhost ([1.157.14.188])
        by smtp.gmail.com with ESMTPSA id h186sm13852826pfg.59.2021.12.06.21.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 21:16:53 -0800 (PST)
Date:   Tue, 7 Dec 2021 16:16:50 +1100
From:   Balbir Singh <bsingharora@gmail.com>
To:     yong w <yongw.pur@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, mingo@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, yang.yang29@zte.com.cn,
        wang.yong12@zte.com.cn
Subject: Re: [PATCH v2 linux-next] delayacct: track delays from memory compact
Message-ID: <Ya7uQingLC3fMJlt@balbir-desktop>
References: <1638619795-71451-1-git-send-email-wang.yong12@zte.com.cn>
 <Yax01zjuzmNyyJK/@balbir-desktop>
 <CAOH5QeDhjyjAkS1bUju2cv67KFukUr0ov8uG+z3bM6Oa=iFrMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOH5QeDhjyjAkS1bUju2cv67KFukUr0ov8uG+z3bM6Oa=iFrMA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 05, 2021 at 07:08:02PM +0800, yong w wrote:
> Balbir Singh <bsingharora@gmail.com> 于2021年12月5日周日 16:17写道：
> >
> > On Sat, Dec 04, 2021 at 04:09:55AM -0800, yongw.pur@gmail.com wrote:
> > > From: wangyong <wang.yong12@zte.com.cn>
> > >
> > > Delay accounting does not track the delay of memory compact.
> > > When there is not enough free memory, tasks can spend
> > > a amount of their time waiting for compact.
> > >
> > > To get the impact of tasks in direct memory compact, measure
> > > the delay when allocating memory through memory compact.
> > >
> >
> > Should we call this DIRECT_COMPACT and through documentation
> > or name change imply that this won't work for kcompactd the
> > kernel thread - based on my reading of the patches.
> >
> Using DIRECT_COMPACT is a little redundant，because the
> delayacct stats of delay accounting is specific to tasks, it has
> nothing to do with kcompactd, which is similar to the RECLAIM field.
>

What would we expect when we call delayacct -p <pidof kcompactd>
to be output? Yes, I agree with your comment on the reclaim
field. Don't feel to strongly, but it can be confusing that kcompactd
has spent no time in compact'ing? Not that delayacct is used for
kernel threads, but I am not sure if that use case exists today.

<snip>

Balbir Singh.
