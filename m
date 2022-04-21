Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D652A50AB7A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 00:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442446AbiDUW2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 18:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbiDUW2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 18:28:32 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5BF4A3DD
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 15:25:41 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id z99so8269816ede.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 15:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=flU6CYbGj5HHjHL/rSfoESS0j19ra3SqkJwdnrfGTCE=;
        b=mhiuMoEGCpN3Zgcfbu33ndnnHh5jgqOCiSxHecLhuWCXZWzmGwn3io2Yb0J9sVXrRu
         dVuKXpiZLkRNq27Wi97ysToJPLJVCkO2UJj8e9pi1U9+geswfxbQk0PInen+gN1nC/q3
         EQH+J+W2EB/3oJQcLHvhzMasWXWbYKCN+xFkYzvLtnIDfwvghacyiAv73I5tHw5J4Xyl
         kOW8QFEmHY7Y4t2gLJj+WtM3k8FiNHmvtFww+x6GTaRfj9df1KxCR5rFPJeAEUPRYRWa
         +jbksUqiyU0D5YlCrSSFOKo0uGF9q5mGT13/q67LBrF3I7WvpFCT+oN/ugxSWLTg5R1w
         OJ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=flU6CYbGj5HHjHL/rSfoESS0j19ra3SqkJwdnrfGTCE=;
        b=Y4DdoyWrEQn1MBoVhnAkbeIKLQxgn8zSldanx/vS+ebbBzroFrUhYuQx0VTHHh0tl6
         SPVmfK79VLHDAnTI2fDYKe+VWxy0uHtomr0aXGDq0M94ivMs10cjdr5IpRLnWiA6MZNl
         8j9btJ3UQEMmBxWNDmgOIGy4pmSt01WCJhMsvMG9TDAjbD+QiMmCB1EPic1B8k8Fxt/v
         occnZcQwMgHNh7u49bA2RYKGVloUejyRhzgl2IrNuKVej7/BoIkVgW8ViUBn+gx8bF9T
         yO+SSLQvHWWXfdMRbI+3tw43u/8frisnSvBCrDUiuLDejlBg/m+73KTWMNHnjMRCRwG6
         Pt5A==
X-Gm-Message-State: AOAM531QNgGffcTSzVtjj1K8NAIseB/KRGBoTQyuA+8Ngz95VLwJFzI3
        jiIf5Q6XvimIqco1Kvhj8gYWhidjoUh5/TH4k5XhJg==
X-Google-Smtp-Source: ABdhPJwFjKL7IPakp+6xAgghiOAlOuHjAgg1o426hhEXf8oiL7SRnTS4Ua2knhN3kp/AQcYwc0V9Gv/jkgiNr64uQxU=
X-Received: by 2002:a05:6402:4488:b0:425:9335:bbcb with SMTP id
 er8-20020a056402448800b004259335bbcbmr1799092edb.197.1650579939899; Thu, 21
 Apr 2022 15:25:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220420235228.2767816-1-tjmercier@google.com>
 <20220420235228.2767816-2-tjmercier@google.com> <YmG/4Q0Cz0yUMbu+@slm.duckdns.org>
In-Reply-To: <YmG/4Q0Cz0yUMbu+@slm.duckdns.org>
From:   "T.J. Mercier" <tjmercier@google.com>
Date:   Thu, 21 Apr 2022 15:25:28 -0700
Message-ID: <CABdmKX2+72bh2tsdg5iFDTQnFyER1Vs9aX0p3TE7RaM4D5_uCA@mail.gmail.com>
Subject: Re: [RFC v5 1/6] gpu: rfc: Proposal for a GPU cgroup controller
To:     Tejun Heo <tj@kernel.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Hridya Valsaraju <hridya@google.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        John Stultz <jstultz@google.com>,
        Todd Kjos <tkjos@android.com>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Kalesh Singh <kaleshsingh@google.com>, Kenny.Ho@amd.com,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        kernel-team@android.com, dri-devel@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 1:34 PM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Wed, Apr 20, 2022 at 11:52:19PM +0000, T.J. Mercier wrote:
> > From: Hridya Valsaraju <hridya@google.com>
> >
> > This patch adds a proposal for a new GPU cgroup controller for
> > accounting/limiting GPU and GPU-related memory allocations.
> > The proposed controller is based on the DRM cgroup controller[1] and
> > follows the design of the RDMA cgroup controller.
> >
> > The new cgroup controller would:
> > * Allow setting per-device limits on the total size of buffers
> >   allocated by device within a cgroup.
> > * Expose a per-device/allocator breakdown of the buffers charged to a
> >   cgroup.
> >
> > The prototype in the following patches is only for memory accounting
> > using the GPU cgroup controller and does not implement limit setting.
> >
> > [1]: https://lore.kernel.org/amd-gfx/20210126214626.16260-1-brian.welty@intel.com/
> >
> > Signed-off-by: Hridya Valsaraju <hridya@google.com>
> > Signed-off-by: T.J. Mercier <tjmercier@google.com>
>
> Looks straight-forward enough from cgroup side. Are gpu folks generally
> happy? David, Daniel, Kenny, what are your thoughts?
>
> >  Documentation/gpu/rfc/gpu-cgroup.rst | 190 +++++++++++++++++++++++++++
>
> Can you fold the important part into cgroup-v2.rst and maybe make the rest
> code comments if necessary?
>
Sure thing, thanks.

> Thanks.
>
> --
> tejun
