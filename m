Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6059C52AE73
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 01:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbiEQXKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 19:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbiEQXJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 19:09:55 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8404453B46
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 16:09:53 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id fd25so856264edb.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 16:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=U5Soym7qWXyY7JHHb0K/zVq60rFDdnhUCY/M1J+u0uc=;
        b=i7fXoxo9pNvYtLCkTowvUdMSTNJYQ7r4Lum2lT1cZgVuF8QhKS28qm0bJCXCYqmrnb
         XB2JY71klKWwZ4xav+9wOicKJfIyB22XPd0I+tJcxgoHwd9PaEO+3MBHhCyTo34eNm23
         WYsU6hLjfAGNmX9n6pX8v5EdzZWkyO6BZM/ijGt3/PjraZQhXE6OgMF4aYx28WRJqIKS
         BMF4hJOIeyz1BHUJbAsS51jigCYqk02Lj3SLo0CBsc7urbg2h+CWmmLHT8CS8gCjoicM
         FSKcRkHfMqydJxwuRGlguvCbhcNDodtiZ3v9DwP04wyu4/rOKkEXAapUlBA5fgo/Xw2h
         u00A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=U5Soym7qWXyY7JHHb0K/zVq60rFDdnhUCY/M1J+u0uc=;
        b=h7AZZoUWUYrroiU3CTU9ghfGN1Z+al1MQypdtxlN1SgZ/sc70nO12xFtpFeE0o/c+E
         0uRiy9bvlM04/60gqh4UFr7QF3lM8lEl8YoSSaMirfqiSBMMkoVbw0KlFEA6zxASH2Vv
         eJHgQaOHL5y+C8blM/lFO0n4TBDsYI8ZrK5h4ERbzR4517jpIj1uqaDzsU9TfabiX5N6
         vKNc4UXcE+10QZd63qKFmnm0XHvTEDp2hjdAoKCsiGvJ/uyFM3F1TPZ3MoZVoANWKxwa
         FakE5nb245M6dY2ZKMX9RUK/AoZDLe+zYfmWjw7DCjJhdmH6MDTZdOA8jlYCtqgjZu4W
         ytgg==
X-Gm-Message-State: AOAM530G4RX7eha+8RC63ozHEtl4Zf0hJLFzIGm7wv0c5ZZP7cidz8E1
        ckBnD9cZvS3JIOCDexlRcTNRiAfNKSVGd/do3bEb3A==
X-Google-Smtp-Source: ABdhPJzjqZbkPojkl7ryNYN6yu6MbETJ8A/7eVt36SLKc6SOmVdzHyfFpwbYfCzYQuDl3cDRRaSbXjjEiAq22KdoMjo=
X-Received: by 2002:a05:6402:2788:b0:42a:c7b2:3fb3 with SMTP id
 b8-20020a056402278800b0042ac7b23fb3mr5725320ede.58.1652828991876; Tue, 17 May
 2022 16:09:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220516171315.2400578-1-tjmercier@google.com>
 <175c5af3-9224-9c8e-0784-349dad9a2954@amd.com> <CABdmKX2GcgCs1xANYPBp8OEtk9qqH7AvCzpdppj9rHXvMqWSAw@mail.gmail.com>
 <0875fa95-3a25-a354-1433-201fca81ed3e@amd.com> <CABdmKX1+VYfdzyVYOS5MCsr4ptGTygmuUP9ikyh-vW6DgKk2kg@mail.gmail.com>
 <YoM9BAwybcjG7K/H@kroah.com> <d820893c-fa2e-3bac-88be-f39c06d89c01@amd.com>
In-Reply-To: <d820893c-fa2e-3bac-88be-f39c06d89c01@amd.com>
From:   "T.J. Mercier" <tjmercier@google.com>
Date:   Tue, 17 May 2022 16:09:40 -0700
Message-ID: <CABdmKX2m1b1kdACKM19S+u9uR5RTy1UGMRgd+3QA_oAyCpeggg@mail.gmail.com>
Subject: Re: [PATCH v2] dma-buf: Move sysfs work out of DMA-BUF export path
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Minchan Kim <minchan@google.com>,
        Greg Kroah-Hartman <gregkh@google.com>,
        John Stultz <jstultz@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Hridya Valsaraju <hridya@google.com>, kernel-team@android.com,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 11:59 PM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 17.05.22 um 08:13 schrieb Greg Kroah-Hartman:
> > On Mon, May 16, 2022 at 05:08:05PM -0700, T.J. Mercier wrote:
> >> [SNIP]
> >>>>>> Fixes: bdb8d06dfefd ("dmabuf: Add the capability to expose DMA-BUF=
 stats in sysfs")
> >>>>>> Originally-by: Hridya Valsaraju <hridya@google.com>
> >>>>>> Signed-off-by: T.J. Mercier <tjmercier@google.com>
> >>>>>>
> >>>>>> ---
> >>>>>> See the originally submitted patch by Hridya Valsaraju here:
> >>>>>> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%=
2Flkml.org%2Flkml%2F2022%2F1%2F4%2F1066&amp;data=3D05%7C01%7Cchristian.koen=
ig%40amd.com%7C61d7d3acbe5f47c7d0e608da37cc5ed7%7C3dd8961fe4884e608e11a82d9=
94e183d%7C0%7C0%7C637883648212878440%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLj=
AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sd=
ata=3DHdSHA2vbBkBgdKxPXIp57EHW49yoMjgmigkVOKeTasI%3D&amp;reserved=3D0
> >>>>>>
> >>>>>> v2 changes:
> >>>>>> - Defer only sysfs creation instead of creation and teardown per
> >>>>>> Christian K=C3=B6nig
> >>>>>>
> >>>>>> - Use a work queue instead of a kthread for deferred work per
> >>>>>> Christian K=C3=B6nig
> >>>>>> ---
> >>>>>>     drivers/dma-buf/dma-buf-sysfs-stats.c | 56 +++++++++++++++++++=
+-------
> >>>>>>     include/linux/dma-buf.h               | 14 ++++++-
> >>>>>>     2 files changed, 54 insertions(+), 16 deletions(-)
> >>>>>>
> >>>>>> diff --git a/drivers/dma-buf/dma-buf-sysfs-stats.c b/drivers/dma-b=
uf/dma-buf-sysfs-stats.c
> >>>>>> index 2bba0babcb62..67b0a298291c 100644
> >>>>>> --- a/drivers/dma-buf/dma-buf-sysfs-stats.c
> >>>>>> +++ b/drivers/dma-buf/dma-buf-sysfs-stats.c
> >>>>>> @@ -11,6 +11,7 @@
> >>>>>>     #include <linux/printk.h>
> >>>>>>     #include <linux/slab.h>
> >>>>>>     #include <linux/sysfs.h>
> >>>>>> +#include <linux/workqueue.h>
> >>>>>>
> >>>>>>     #include "dma-buf-sysfs-stats.h"
> >>>>>>
> >>>>>> @@ -168,10 +169,46 @@ void dma_buf_uninit_sysfs_statistics(void)
> >>>>>>         kset_unregister(dma_buf_stats_kset);
> >>>>>>     }
> >>>>>>
> >>>>>> +static void sysfs_add_workfn(struct work_struct *work)
> >>>>>> +{
> >>>>>> +     struct dma_buf_sysfs_entry *sysfs_entry =3D
> >>>>>> +             container_of(work, struct dma_buf_sysfs_entry, sysfs=
_add_work);
> >>>>>> +     struct dma_buf *dmabuf =3D sysfs_entry->dmabuf;
> >>>>>> +
> >>>>>> +     /*
> >>>>>> +      * A dmabuf is ref-counted via its file member. If this hand=
ler holds the only
> >>>>>> +      * reference to the dmabuf, there is no need for sysfs kobje=
ct creation. This is an
> >>>>>> +      * optimization and a race; when the reference count drops t=
o 1 immediately after
> >>>>>> +      * this check it is not harmful as the sysfs entry will stil=
l get cleaned up in
> >>>>>> +      * dma_buf_stats_teardown, which won't get called until the =
final dmabuf reference
> >>>>>> +      * is released, and that can't happen until the end of this =
function.
> >>>>>> +      */
> >>>>>> +     if (file_count(dmabuf->file) > 1) {
> >>>>> Please completely drop that. I see absolutely no justification for =
this
> >>>>> additional complexity.
> >>>>>
> >>>> This case gets hit around 5% of the time in my testing so the else i=
s
> >>>> not a completely unused branch.
> >>> Well I can only repeat myself: This means that your userspace is
> >>> severely broken!
> >>>
> >>> DMA-buf are meant to be long living objects
> >> This patch addresses export *latency* regardless of how long-lived the
> >> object is. Even a single, long-lived export will benefit from this
> >> change if it would otherwise be blocked on adding an object to sysfs.
> >> I think attempting to improve this latency still has merit.
> > Fixing the latency is nice, but as it's just pushing the needed work of=
f
> > to another code path, it will take longer overall for the sysfs stuff t=
o
> > be ready for userspace to see.
> >
> > Perhaps we need to step back and understand what this code is supposed
> > to be doing.  As I recall, it was created because some systems do not
> > allow debugfs anymore, and they wanted the debugging information that
> > the dmabuf code was exposing to debugfs on a "normal" system.  Moving
> > that logic to sysfs made sense, but now I am wondering why we didn't se=
e
> > these issues in the debugfs code previously?
>
> Well, I think that some key information is that adding the sysfs support
> was justified with the argument that this is not only used for debugging.
>
> If it would be used only for debugging then debugfs would the right
> choice for this. If debugfs is then not available in your environment
> then you should *not* ask the kernel to work around that. Instead we
> should discuss why you want to disable some debugging access, but not
> all of that.
>
> So for now let's assume that this is also used for accounting, e.g. when
> userspace wants to know how many DMA-bufs of which size are flying
> around to make decisions like which process to put into background or
> which to swap out based on that information.
>
Yes, the accounting of buffers at runtime on production devices is
part of the use case:
https://lore.kernel.org/all/CA+wgaPPtoz_JSAwsVVpFGLrcrO8-tAGD+gdrsWmBA3jpid=
igzQ@mail.gmail.com/

> > Perhaps we should go just one step further and make a misc device node
> > for dmabug debugging information to be in and just have userspace
> > poll/read on the device node and we spit the info that used to be in
> > debugfs out through that?  That way this only affects systems when they
> > want to read the information and not normal code paths?  Yeah that's a
> > hack, but this whole thing feels overly complex now.
>
> Yeah, totally agree on the complexity note. I'm just absolutely not keen
> to add hack over hack over hack to make something work which from my
> point of view has some serious issues with it's design.
>
Why is this patch a hack? We found a problem with the initial design
which nobody saw when it was originally created, and now we're trying
to address it within the constraints that exist. Is there some other
solution to the problem of exports getting blocked that you would
suggest here?

> For example trying to do accounting based on DMA-bufs is extremely
> questionable to begin with. See a modern game for example can have
> between 10k and 100k of different buffers, reserving one file descriptor
> for each of those objects is absolutely not going to work.
>
> So my request is to please describe your full use case and not just why
> you think this patch is justified.
>
The use case was described in the commit message when the feature was
initially added (after discussion about it on the list) including
links to code that uses the feature:
https://lore.kernel.org/all/20210603214758.2955251-1-hridya@google.com/


> Regards,
> Christian.
>
> >
> > thanks,
> >
> > greg k-h
>
