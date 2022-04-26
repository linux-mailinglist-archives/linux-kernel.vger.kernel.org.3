Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1372A50F009
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 06:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244173AbiDZEwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 00:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiDZEw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 00:52:29 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA168233F
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 21:49:21 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id z19so7581192edx.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 21:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uCWRsh2XDsci/qyEwcXXHMb3VG+RXIYuPdWO54FN1Ew=;
        b=MfDHh1de0uDvPcakb8maWup+ELUpQnmvwuY8MFwm6JcH4LfWr0HvPRzilhUYxTawSK
         MFEVDXKLPMqISz2NBOZDOhPHvQSwkJKCz/C6j04OEdkreVqH/iyL2WbPfxej4BbS6KLB
         /5QLPUdSEw59W/rPKcYC5F6eiP2WwXS6IEXrcWU5PRVsIbZqgG3nx89aRkJg6dsD4P17
         Dgtq7iZhR60vsZ8xXLrOmZiXNDA8JBX3AVIQHeaILgEkoUZLbTyQynm2pzsIDTIysu//
         HXKcysyj8KCy11EYmcEUOxZ+L0bOuj8urQM+4MD+pyZQnQmLxm63MABLciXDRupAkSKT
         ngxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uCWRsh2XDsci/qyEwcXXHMb3VG+RXIYuPdWO54FN1Ew=;
        b=COW/IZ0Nh9HAiuSX6qqD9evKuJLVH2T5AuUmAOl7aK+sALBOjq8+jDdb7wvDy0ULWW
         3KMpXi+eS9LzZ58pYaSEF19knptZ0uuii7C3OiBAcPLgvpzEOqUDYaKiJq+2XxFqqqTb
         EWXA6hTqwXakXqjWMqnmRtWQKnH/c3MkTe4IrVpjCFaa4S7H1LPi4yxa2RLGATp5TIeB
         tS/Zhp13/wKz30/8gKe3+6s3aKSIh7EZ+N0dKNNEVx6ZnqsAp0gieCr4tJVpFpQ9QJkG
         PTD7x8eVVGo4/PcBHTphsM0NQMl7gcLf/hh3KxYlIUtTqCAeeVoLSXZHMd7xaTSL5Q2C
         0/8Q==
X-Gm-Message-State: AOAM532wPO85+7NJVDzqStIxNWMIqGvDQTtnAI3Fq9tQtcZLiVc/u0JQ
        8i/K8gmM8IskF27zxx9WUqLxy1Q7Y4HE1lqAWfem
X-Google-Smtp-Source: ABdhPJzSLD7RJxu52EUqQOx2yqGJ9zZiXcpNB7jYe2uO9DVwnuUxMD6qJi3a0QKjscDInuD8HjfrxFfJZif2ZYkMRmM=
X-Received: by 2002:a05:6402:4388:b0:423:f7c9:7e04 with SMTP id
 o8-20020a056402438800b00423f7c97e04mr22763883edc.298.1650948560003; Mon, 25
 Apr 2022 21:49:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220425083302.GD21864@xsang-OptiPlex-9020> <YmbvxQVNFESRwxxU@bombadil.infradead.org>
 <20220425144607.2c2588e6b1f00ab8a6f3f6ea@linux-foundation.org>
 <YmcqCVLv3HQ+Kxeq@bombadil.infradead.org> <20220425163434.5f8f47e8c301ea30c2f94a5a@linux-foundation.org>
 <Ymc1Zn8BbQMbjb58@bombadil.infradead.org> <Ymd0GIf3Ieh3DRcg@bombadil.infradead.org>
In-Reply-To: <Ymd0GIf3Ieh3DRcg@bombadil.infradead.org>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Tue, 26 Apr 2022 12:49:49 +0800
Message-ID: <CACycT3vXkS3vbF2vduUg0XgLv-B=LdvyS1sVA0W=9+Se4AaVXA@mail.gmail.com>
Subject: Re: [proc/sysctl] 1dd38979b2: BUG:kernel_NULL_pointer_dereference,address
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Eli Cohen <elic@nvidia.com>, Parav Pandit <parav@nvidia.com>,
        guanjun@linux.alibaba.com,
        kernel test robot <oliver.sang@intel.com>,
        Julius Hemanth Pitti <jpitti@cisco.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>, Ingo Molnar <mingo@elte.hu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com,
        virtualization <virtualization@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 12:25 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Mon, Apr 25, 2022 at 04:57:26PM -0700, Luis Chamberlain wrote:
> > On Mon, Apr 25, 2022 at 04:34:34PM -0700, Andrew Morton wrote:
> > > On Mon, 25 Apr 2022 16:08:57 -0700 Luis Chamberlain <mcgrof@kernel.org> wrote:
> > >
> > > > On Mon, Apr 25, 2022 at 02:46:07PM -0700, Andrew Morton wrote:
> > > > > On Mon, 25 Apr 2022 12:00:21 -0700 Luis Chamberlain <mcgrof@kernel.org> wrote:
> > > > >
> > > > > > Andrew, can we drop this patch for now?
> > > > >
> > > > > I've been sitting on (ie, forgotten about) this patch
> > > > > (https://lore.kernel.org/all/20200709235115.56954-1-jpitti@cisco.com/T/#u)
> > > >
> > > > Jesh, yeah I see.
> > > >
> > > > > for two years.  Evidently waiting for you/Kees/Ingo to provide
> > > > > guidance.  So sure, the need seems very unurgent so I can drop it.
> > > >
> > > > Well Keew as OK with it, but I yeah I can't decipher the issue at this
> > > > point in time.
> > > >
> > > > > However I fail to see how that patch could have caused this crash.  I'm
> > > > > suspecting a bisection error?
> > > > >
> > > > > Maybe something is unwell in drivers/vdpa/vdpa_user/vduse_dev.c.
> > > >
> > > > At a quick glance, yes it could very well by vduse_init() is messy and
> > > > races somehow with init, but if a race does lurk here my instincts tell
> > > > me this can't be the only place.
> > > >
> > > > Not sure if leaving a patch in place more time to see how else things
> > > > can explode is worth it.
> > >
> > > Confused.  Are you thinking that the above-linked patch was somehow
> > > involved in this crash?  If so, but how?  All it does it to permit
> > > unprivileged reads to four ints via proc_dointvec_minmax()?
> >
> > If the priv allows for it access to dereferencing a pointer is allowed.
> > How that race happens though, indeed is beyond the patch's fault.
>
> Even so, I am 99.99% sure this is a driver bug then. And so if enabling
> this patch just enables more driver bugs so be it.
>
> So driver maintainers: please take a look, I tried to check but
> the driver bug is not obvious to me yet.
>

Yes, I think it's a driver bug. I'll send a patch soon.

Thanks,
Yongji
