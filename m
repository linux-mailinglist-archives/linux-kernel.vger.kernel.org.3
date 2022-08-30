Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 898695A71FE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 01:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbiH3XtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 19:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbiH3XtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 19:49:08 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 487316A4A7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 16:49:05 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 123so1848596ybv.7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 16:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=EDG/t2GvC+PbgTuA+ZCwL9kIJfW1c1m4VzuzeCRXPzc=;
        b=l58C+bxd1syF5Vlii814qxOCber2DgTuahTIbfDZ1Q9WZ5nKWwRZrl9J+O5xDeUIUd
         2HBpylq7ylKkg6OazuCn6UwzibXRPc1pNV9wopq+vFtslkjGIxFRVNqDIDK0JwepgJ3A
         tGmL/+qEYRQXNHR0mdkLN21V4HRSK6PUAlNGfdFGL67AHyczv9d2CsC41FiNVxKAKYMS
         1p6HUyY7mhz2brhPY98W8DOS51GE6EkSSre/zYTuiEGxdeE8TghVRLPQGibp01aY7GRI
         4q5zBJYTlcesmC79qNIiUWlgdRfyth283XcSOL5MtT5zCU3HAQ0QAggKQcuJsCLiWTJ4
         MELg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=EDG/t2GvC+PbgTuA+ZCwL9kIJfW1c1m4VzuzeCRXPzc=;
        b=FCzu/WW6zI8fHB6RDXFcmyryc8fXIL04FOKEbR1cW/7a4XxaGhA26iI5Eo3Zl2vODO
         CVRqWmW76vSDc4bsQHvjFst5LTS6rJtgtsHCDTiyXnwAOZMr5l/0nk3hK2zEAh5wr9U8
         DcucjSV5CHBLwNFZhnpecHWtfWMkjhHmSumd9PZWPDcyM9thT8wUDLvXU/kiqR4/d8gN
         IV831t9hs/UOHw2MBnXzh54R4bnlNubwPcTktb70knruP7H5jGtebXi+VBIBTnevFzqG
         Frc2Ai9/3GZ15so7KS+TWcUN9X0iojh3n5z+zLZ9SNEJ/RKRv+p7YQNHxHy/2XQ6cR1E
         dJ7w==
X-Gm-Message-State: ACgBeo1GwJhXCmVakGC1Eov3NM+CpyFK6nWLVJzHQVjeOQxaUJtritXj
        35Pw3bt6RI2Z2/zzmnfRpPkpoct7PQ0nzgKUv0Sz8g==
X-Google-Smtp-Source: AA6agR5MARoYdz2lX3WRe2UGUDM12IO8ckjJpDu780mBr/nzLqyzMr66momJBcStP+k/fYorLGQOZbU0lQarWX5x+aI=
X-Received: by 2002:a25:a06:0:b0:695:8d8f:b5c3 with SMTP id
 6-20020a250a06000000b006958d8fb5c3mr13897430ybk.352.1661903344902; Tue, 30
 Aug 2022 16:49:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220830065413.638-1-thunder.leizhen@huawei.com>
 <CAGETcx8hfzAthF_gCMrmnVOgwgFJEPE=bwRuVeXaiB7ywUkWkg@mail.gmail.com>
 <Yw3cs6wb4PvnDN/7@shell.armlinux.org.uk> <b120e94b-4b43-6d8a-a136-41417cb250cc@huawei.com>
 <Yw3hfGV4DYyJ0Gno@shell.armlinux.org.uk> <2452e7b0-d4fd-2e27-a336-bf87b85a8d50@huawei.com>
 <Yw3oR6WhM0O5LQX5@shell.armlinux.org.uk> <CAGETcx_GB-r+H96hWHfoKSZjK9hodqe-+FWh6rve0E09pz0nXA@mail.gmail.com>
In-Reply-To: <CAGETcx_GB-r+H96hWHfoKSZjK9hodqe-+FWh6rve0E09pz0nXA@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 30 Aug 2022 16:48:28 -0700
Message-ID: <CAGETcx-o7=+OR87ag3M5ONGfwG_2w9N=YZb7q7Y8CT9S8uitFg@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: Add sanity check for dev->periphid in amba_probe()
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        patches@armlinux.org.uk, Kefeng Wang <wangkefeng.wang@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>
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

On Tue, Aug 30, 2022 at 10:34 AM Saravana Kannan <saravanak@google.com> wrote:
>
> On Tue, Aug 30, 2022 at 3:36 AM Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
> >
> > On Tue, Aug 30, 2022 at 06:31:14PM +0800, Leizhen (ThunderTown) wrote:
> > > On 2022/8/30 18:07, Russell King (Oracle) wrote:
> > > > For an amba driver, drv->bus will always be pointing at amba_bustype.
> > > > That always has a "match" operation. Therefore, the default of '1'
> > > > above will *never* be used for an AMBA driver.
> > > >
> > > > If drv->bus does not point at amba_bustype, then amba_probe() will
> > > > not be called for "drv".
> > > >
> > > > Therefore, amba_match() must always be called before amba_probe().
> > >
> > > Oh, I was careless. I think it's drv->match. But the processing flow
> > > will continue to go to "dev->bus->probe".
> > >
> > > __driver_attach():
> > >         ret = driver_match_device(drv, dev);
> > >         if (ret == 0) {
> > >                 /* no match */
> > >                 return 0;
> > >         } else if (ret == -EPROBE_DEFER) {               <------no return in this branch
> > >                 dev_dbg(dev, "Device match requests probe deferral\n");
> > >                 dev->can_match = true;
> > >                 driver_deferred_probe_add(dev);
> > >         } else if (ret < 0) {
> > >                 dev_dbg(dev, "Bus failed to match device: %d\n", ret);
> > >                 return ret;
> > >         } /* ret > 0 means positive match */
> > >
> > >         ... ...
> > >         driver_probe_device(drv, dev);
> > >              ......
> > >                   dev->bus->probe
> >
> > And that makes no sense, is an already known issue, and there is a patch
> > to fix it:
> >
> > https://lore.kernel.org/all/20220817184026.3468620-1-isaacmanjarres@google.com/
>
> Russell,
>
> Thanks for discussing this further and pointing out the other fix. I
> assumed Leizhen was talking about an instance of
> device_driver_attach() which allows probe to be called without match.
> Thankfully that function is used only by some specific
> frameworks/buses types. I did a cursory check and I don't see any
> intersection with we amba.
>
> -Saravana
> P.S: I hate that function exists, as it just throws a wrench in the
> whole driver core design and adds corner cases to a lot of generic
> driver core design.

Oops, meant to say device_bind_driver().

So through out my email:
s/device_driver_attach/device_bind_driver/

-Saravana
