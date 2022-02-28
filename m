Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D23A4C7065
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 16:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237493AbiB1PPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 10:15:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234565AbiB1PPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 10:15:45 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F0181183
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 07:15:05 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id u3so21156505ybh.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 07:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/DGYCHAP536Nvul99EDTG6hckPiPqs15TjdAiXjOtBM=;
        b=tVv4ipPxKA03xgTq4Dk1zw4CZCbm4XSeZKExWKEF2kL+Ubm0tK0Ln/uN0xG/ZAf+32
         SPCvUnyR0gqw+AsgGfTCnYYbi/VGmxyF5OiG6Nre9MBzbGP/LvxPZN9hky45/QD19wDg
         fZmdRtMjQCHCs6rV3Zoj08xvLSGbHvJQOGy2SGADfTfofnGtiRoXny68fLcXENZdG5T4
         H24IaYQPHJ4hyNlZnJnFwwfLO3kXKa2ebKHx7S8txcPIDu4vQfYiQnQwanJm+1vnnsHP
         SfMVdvqF46ReLi28NzQz3Qq4bGX9cCQ99Do+2SdcijBor1wiIfq+f//kjPqZ5BXLBwyI
         HCPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/DGYCHAP536Nvul99EDTG6hckPiPqs15TjdAiXjOtBM=;
        b=00wPKuOCH7XTi0/kHrSOrpMaeRYGH49ZGGY+zW70WfFK6cPQr6n1q2Xlknlo0jinNM
         835I0+waosGf9mu/2Gr6GvW24h0v+t4Rj4tll1QSK1tYUEjpG8IvwnDda/wAZEy1GEOL
         ZctBcSpogyGVWTB0HgsOVTzw9lSJu88zoBXUArSdjqzRYVpBTSstos0JiVRiQiOzHJeT
         ucTcuoJ8jVKRaF9oernGhpKjo3Qnlx8oJQ9YsBquEzjXZi4dqBcOzRl9yvW+ZpD60dOP
         P1VOgHtLUuBJz88jR8t0+LOuGEPhVHx7cQZr8PcFSkqKOO0uWYttyc8x37+AAsWyGqEF
         EwFg==
X-Gm-Message-State: AOAM532GgN+A7YlBdJAHsxUUKFmagOy/tIeCBTTddubOwf5r+8j7KQl4
        1IAPdLfSfP3u6SRwy/LlVpEQDd6Sw+3A6eIfxxCGAA==
X-Google-Smtp-Source: ABdhPJxlij0ufjiN92AH1OyL8pyemHJU/TWzZLp6QiY6vkNQ+FWGQvbI5YCIn5OheXrUj61MFz1apjjwLuJHsGh+4O4=
X-Received: by 2002:a25:d2cd:0:b0:61d:6a33:8129 with SMTP id
 j196-20020a25d2cd000000b0061d6a338129mr19241308ybg.246.1646061303068; Mon, 28
 Feb 2022 07:15:03 -0800 (PST)
MIME-Version: 1.0
References: <20220228071022.26143-1-songmuchun@bytedance.com>
 <20220228071022.26143-4-songmuchun@bytedance.com> <YhzfN574YUta3qay@bombadil.infradead.org>
In-Reply-To: <YhzfN574YUta3qay@bombadil.infradead.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 28 Feb 2022 23:14:27 +0800
Message-ID: <CAMZfGtXvLj+DQj=YoN6CcVfHZA-ceB24t8waMZs7KEbOoh0jUA@mail.gmail.com>
Subject: Re: [PATCH 3/3] mm: hugetlb: add hugetlb_free_vmemmap sysctl
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 10:42 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Mon, Feb 28, 2022 at 03:10:22PM +0800, Muchun Song wrote:
> > We must add "hugetlb_free_vmemmap=on" to boot cmdline and reboot the
> > server to enable the feature of freeing vmemmap pages of HugeTLB
> > pages. Rebooting usually taske a long time. Add a sysctl to enable
> > the feature at runtime and do not need to reboot.
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  Documentation/admin-guide/sysctl/vm.rst | 13 +++++++++++++
> >  include/linux/hugetlb.h                 |  5 +++++
> >  include/linux/memory_hotplug.h          |  1 +
> >  kernel/sysctl.c                         | 11 +++++++++++
>
> kernel/sysctl.c is a hot mess with tons of knobs from all over the
> place. And so we've been moving these to their own place. For instance
> all the filesystem knobs are now properly in fs/. So Adding new ones
> to the file is undesirable. If this is going to be added, please add
> it somewhere in mm / hugetlb code.
>

I also have realized this when reading another patch [1]. I will
move this into its hugetlb related code.  Anyway, thanks for
your suggestion.

[1] https://lore.kernel.org/linux-fsdevel/20220220060626.15885-1-tangmeng@uniontech.com/
