Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA58E547A73
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 16:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233541AbiFLOI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 10:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiFLOI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 10:08:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 007D717598
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 07:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655042905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AQtlxbHgyz420eJBAQW0/L23us2mAj+RyCpPUEqnaas=;
        b=djjYXeB9vgtbLD7FkoRc1TPQ7RJUgcpTVaf0FsxlHCIiG6YYhSRtPblWFOlaboxPviYqwo
        XpCUNGzEphBEKdWChMew0tY5wNTDaMvpXv3QEQpd4HDpExr38mQtGbUlR43BqBkONJn7a7
        QUHICgZMHozoMjIssoGc69JAsbzqVSw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-332-WfEi8IeLOz6ry2i39Gg1sQ-1; Sun, 12 Jun 2022 10:08:24 -0400
X-MC-Unique: WfEi8IeLOz6ry2i39Gg1sQ-1
Received: by mail-wm1-f71.google.com with SMTP id l17-20020a05600c4f1100b0039c860db521so1318661wmq.5
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 07:08:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AQtlxbHgyz420eJBAQW0/L23us2mAj+RyCpPUEqnaas=;
        b=gysMuz/CGp9Bd2vghIEH1rP0CdawP+WV6E71o7qFqBJnnvCTDygwkoptYHhO45R0VB
         e/IVJKpAK9eHgxEog6hVTMArVFvNw2A1pT/p5GPWtpWM2GSn+c0goNyw0CUQhcluM3DP
         bgf+t0VCV1O3d1+Z8lW2L8cGGV3LVabrBXoz8RIk/gyBkNJ2QYq+cXbs3jn4SWSRkW68
         SBrz4DpAO7D2E8iKxg3vpf/xXgLe+Huzec+fzL2/s27WyT+WEHvDz/pMKpwdl4OUvI+a
         8JoQSPZzK0Of+kVxWvVya36g0JbyUtunTloQ09VUQuNNHblax6uUXmVkEStsFSrWhFLt
         hoGw==
X-Gm-Message-State: AOAM532lpNLxNvK8KGu7ONC/SpC0bZPgVvbOvt3uEnMoBdhL994MpDUb
        /ooDVNdK0WAU6/qGDg1kGFa01aEhURCSSDgVugxVqEF4xuJr9oFCV4za1flK/PO8+IIW8f0l5Rd
        C7vK/zYcPobr1dJKjvSHEbOnH
X-Received: by 2002:a05:6000:1250:b0:210:3385:1c8b with SMTP id j16-20020a056000125000b0021033851c8bmr52473056wrx.623.1655042902491;
        Sun, 12 Jun 2022 07:08:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwMz6KD0OkOSLJxJ6RmPWc98Vim730vk4fmrMdIyqJluCbpVqSgDryjXkzru4AQy4NrziuXqg==
X-Received: by 2002:a05:6000:1250:b0:210:3385:1c8b with SMTP id j16-20020a056000125000b0021033851c8bmr52473041wrx.623.1655042902239;
        Sun, 12 Jun 2022 07:08:22 -0700 (PDT)
Received: from redhat.com ([2.55.5.19])
        by smtp.gmail.com with ESMTPSA id u2-20020a056000038200b0020ff3a2a925sm6767599wrf.63.2022.06.12.07.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jun 2022 07:08:21 -0700 (PDT)
Date:   Sun, 12 Jun 2022 10:08:17 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        kernel@axis.com, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Jason Wang <jasowang@redhat.com>, linux-um@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] um: virt-pci: set device ready in probe()
Message-ID: <20220612065324-mutt-send-email-mst@kernel.org>
References: <20220610151203.3492541-1-vincent.whitchurch@axis.com>
 <20220610203029-mutt-send-email-mst@kernel.org>
 <726db8fdf6c7fc271a825badbf1b07a5eebe6d36.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <726db8fdf6c7fc271a825badbf1b07a5eebe6d36.camel@sipsolutions.net>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 12, 2022 at 10:58:20AM +0200, Johannes Berg wrote:
> On Fri, 2022-06-10 at 20:34 -0400, Michael S. Tsirkin wrote:
> > 
> > Also fixes this commit:
> > 
> > commit 68f5d3f3b6543266b29e047cfaf9842333019b4c
> > Author: Johannes Berg <johannes.berg@intel.com>
> > Date:   Fri Mar 5 13:19:58 2021 +0100
> > 
> >     um: add PCI over virtio emulation driver
> 
> Hm, why? It worked before the harden change.

Worked on a specific hypervisor. It was out of spec though.

> > BTW Johannes I think you need to spec this device and get
> > an ID - what's the plan for that? Current hack of punting
> > this to userspace isn't really any good long term.
> 
> Yeah, agree, it dropped off my radar (and the process is a bit
> cumbersome IMHO).

Hmm.

So right the recommended way is:
post patch
open github issue
send an email requesting vote

I guess we can switch request for vote to the github issue
to streamline this a bit - do you think that will help?




> But I'm not quite sure what you mean wrt. "punting to userspace", here
> in the virt-pci code I'm punting to the Kconfig :-)
> 
> Did you just mix that up, or was there some additional userspace thing
> you're thinking of?

Right, I meant "punting it to the user".

> The only userspace thing I can think of it is in virtio_uml where you
> have the ID on the command-line, but that's because it implements the
> virtio device bus over vhost-user which doesn't have ID discoverability
> in the protocol. That could also be fixed I guess, but it's a bit of a
> chicken & egg problem, if you don't have the ID and discovering it were
> not supported, you'd end up with an unusable device unless you specified
> the ID, in which case you don't need to discover it...
> 
> johannes


So, please start by reserving an id.

-- 
MST

