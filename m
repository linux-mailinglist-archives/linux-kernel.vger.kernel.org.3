Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCAC528C98
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 20:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344550AbiEPSJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 14:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236402AbiEPSJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 14:09:13 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908BC3D498
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 11:09:11 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id c12so5648064eds.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 11:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=M1PljccbIAOAE9neWAHKLdafeOscED/K3xPR9tFDwk4=;
        b=PI7Q/iLr9MBJ1zVVAxdTHWye2DT/WcZy78H6wJG7W3W7GKo7sW3vIeF9XIrKQ9/FFy
         TYFhZ2gsRTL5XpZfqSQuwT4PhTWyDgRPtmIHvNY+BoONCJM5B6p29fX01gfCEQKx0Jkl
         Zsfi92aHCMCOePiGwZd0sQpgGOuk165Lvfd3bk+/jSd6WfAWUo7OXEVBlc8vWlKDzS14
         sTI2sYDm0IgECfq4gu+dpwQD6rFUgmPRfIX6MnRfReWMrMIuNyYtoOh9w0Yfi3HLH129
         Ejk14PJhA0y+oRpQx7MjXQezpymW0sd58wcZj4tTmwu7KXgIiOvCpP2EsCc4L2eCt+xr
         QLmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=M1PljccbIAOAE9neWAHKLdafeOscED/K3xPR9tFDwk4=;
        b=zJybxXWtMG1pls+GrTUl+jdiWwnucigs0nkTZu+LlMj+nSD5Fr3DjmLfZKVl+I+hYb
         lF8r2OaeQNxpy+j1Sx/J6KSp1VaXUX/pH6cL9h5yHrA+Obfd+wbgxmJlksxVfkXqGxl/
         qS6xMUcxPDTgDKCtRiGVk/xMQub9xjod0W3nq2cIkavPm193/0R0mVag7RU+Uj/2VQOG
         R/BeaRLst3tlkDdGyupFLfqRoxyOpY9eZmdoWRV9+HQlvTqKxzAHOjFvkz2k1RsBYFpD
         q6qy2RVF6Ilk38Lg013mli2iVovSZEQ7Z0vn99wYVkfv3fVg9lqIsWTiyMfKHQzOGeDd
         1WfA==
X-Gm-Message-State: AOAM531Rm5sq6gUs75D1VRhaqPf5WELqA3BTfeBtH9fZ2IljayjOEQbW
        JumcnoUcfyXyZWM7QwODgPxPoETkOH/1ihH6KH6scw==
X-Google-Smtp-Source: ABdhPJybuxS4qikd73Kz3O+UugJ2dmVo1esTPFbqiEM0/0OxiI9stNtcymabcazgP7bTosofrHkTKIMCqGm0TzVKJDA=
X-Received: by 2002:a05:6402:354d:b0:428:19be:2447 with SMTP id
 f13-20020a056402354d00b0042819be2447mr14561320edd.308.1652724549859; Mon, 16
 May 2022 11:09:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220516171315.2400578-1-tjmercier@google.com> <175c5af3-9224-9c8e-0784-349dad9a2954@amd.com>
In-Reply-To: <175c5af3-9224-9c8e-0784-349dad9a2954@amd.com>
From:   "T.J. Mercier" <tjmercier@google.com>
Date:   Mon, 16 May 2022 11:08:57 -0700
Message-ID: <CABdmKX2GcgCs1xANYPBp8OEtk9qqH7AvCzpdppj9rHXvMqWSAw@mail.gmail.com>
Subject: Re: [PATCH v2] dma-buf: Move sysfs work out of DMA-BUF export path
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Minchan Kim <minchan@google.com>,
        Greg Kroah-Hartman <gregkh@google.com>,
        John Stultz <jstultz@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Hridya Valsaraju <hridya@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel-team@android.com, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, May 16, 2022 at 10:20 AM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 16.05.22 um 19:13 schrieb T.J. Mercier:
> > Recently, we noticed an issue where a process went into direct reclaim
> > while holding the kernfs rw semaphore for sysfs in write (exclusive)
> > mode. This caused processes who were doing DMA-BUF exports and releases
> > to go into uninterruptible sleep since they needed to acquire the same
> > semaphore for the DMA-BUF sysfs entry creation/deletion. In order to av=
oid
> > blocking DMA-BUF export for an indeterminate amount of time while
> > another process is holding the sysfs rw semaphore in exclusive mode,
> > this patch moves the per-buffer sysfs file creation to the default work
> > queue. Note that this can lead to a short-term inaccuracy in the dmabuf
> > sysfs statistics, but this is a tradeoff to prevent the hot path from
> > being blocked. A work_struct is added to dma_buf to achieve this, but a=
s
> > it is unioned with the kobject in the sysfs_entry, dma_buf does not
> > increase in size.
>
> I'm still not very keen of this approach as it strongly feels like we
> are working around shortcoming somewhere else.
>
My read of the thread for the last version is that we're running into
a situation where sysfs is getting used for something it wasn't
originally intended for, but we're also stuck with this sysfs
functionality for dmabufs.

> > Fixes: bdb8d06dfefd ("dmabuf: Add the capability to expose DMA-BUF stat=
s in sysfs")
> > Originally-by: Hridya Valsaraju <hridya@google.com>
> > Signed-off-by: T.J. Mercier <tjmercier@google.com>
> >
> > ---
> > See the originally submitted patch by Hridya Valsaraju here:
> > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flkm=
l.org%2Flkml%2F2022%2F1%2F4%2F1066&amp;data=3D05%7C01%7Cchristian.koenig%40=
amd.com%7C5575fa6126d74ca4315408da375f618d%7C3dd8961fe4884e608e11a82d994e18=
3d%7C0%7C0%7C637883180063393649%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDA=
iLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=
=3D1PcZaUfsLhQZOW29yGUDxazzcyNoBrN2NjeN1Yb40hk%3D&amp;reserved=3D0
> >
> > v2 changes:
> > - Defer only sysfs creation instead of creation and teardown per
> > Christian K=C3=B6nig
> >
> > - Use a work queue instead of a kthread for deferred work per
> > Christian K=C3=B6nig
> > ---
> >   drivers/dma-buf/dma-buf-sysfs-stats.c | 56 ++++++++++++++++++++------=
-
> >   include/linux/dma-buf.h               | 14 ++++++-
> >   2 files changed, 54 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/dma-buf/dma-buf-sysfs-stats.c b/drivers/dma-buf/dm=
a-buf-sysfs-stats.c
> > index 2bba0babcb62..67b0a298291c 100644
> > --- a/drivers/dma-buf/dma-buf-sysfs-stats.c
> > +++ b/drivers/dma-buf/dma-buf-sysfs-stats.c
> > @@ -11,6 +11,7 @@
> >   #include <linux/printk.h>
> >   #include <linux/slab.h>
> >   #include <linux/sysfs.h>
> > +#include <linux/workqueue.h>
> >
> >   #include "dma-buf-sysfs-stats.h"
> >
> > @@ -168,10 +169,46 @@ void dma_buf_uninit_sysfs_statistics(void)
> >       kset_unregister(dma_buf_stats_kset);
> >   }
> >
> > +static void sysfs_add_workfn(struct work_struct *work)
> > +{
> > +     struct dma_buf_sysfs_entry *sysfs_entry =3D
> > +             container_of(work, struct dma_buf_sysfs_entry, sysfs_add_=
work);
> > +     struct dma_buf *dmabuf =3D sysfs_entry->dmabuf;
> > +
> > +     /*
> > +      * A dmabuf is ref-counted via its file member. If this handler h=
olds the only
> > +      * reference to the dmabuf, there is no need for sysfs kobject cr=
eation. This is an
> > +      * optimization and a race; when the reference count drops to 1 i=
mmediately after
> > +      * this check it is not harmful as the sysfs entry will still get=
 cleaned up in
> > +      * dma_buf_stats_teardown, which won't get called until the final=
 dmabuf reference
> > +      * is released, and that can't happen until the end of this funct=
ion.
> > +      */
> > +     if (file_count(dmabuf->file) > 1) {
>
> Please completely drop that. I see absolutely no justification for this
> additional complexity.
>
This case gets hit around 5% of the time in my testing so the else is
not a completely unused branch. It's only 3 extra lines of actual
code. I'd prefer to keep it, but I'll remove it to reduce complexity.
This means doing work that we know is useless some of the time, and
adding contention for a global kernfs lock which this patch is aimed
at avoiding (on the hot path), but at least that work is on a worker
thread with this patch.

> > +             /*
> > +              * kobject_init_and_add expects kobject to be zero-filled=
, but we have populated it
> > +              * (the sysfs_add_work union member) to trigger this work=
 function.
> > +              */
> > +             memset(&dmabuf->sysfs_entry->kobj, 0, sizeof(dmabuf->sysf=
s_entry->kobj));
> > +             dmabuf->sysfs_entry->kobj.kset =3D dma_buf_per_buffer_sta=
ts_kset;
> > +             if (kobject_init_and_add(&dmabuf->sysfs_entry->kobj, &dma=
_buf_ktype, NULL,
> > +                                             "%lu", file_inode(dmabuf-=
>file)->i_ino)) {
> > +                     kobject_put(&dmabuf->sysfs_entry->kobj);
> > +                     dmabuf->sysfs_entry =3D NULL;
> > +             }
> > +     } else {
> > +             /*
> > +              * Free the sysfs_entry and reset the pointer so dma_buf_=
stats_teardown doesn't
> > +              * attempt to operate on it.
> > +              */
> > +             kfree(dmabuf->sysfs_entry);
> > +             dmabuf->sysfs_entry =3D NULL;
> > +     }
> > +     dma_buf_put(dmabuf);
> > +}
> > +
> >   int dma_buf_stats_setup(struct dma_buf *dmabuf)
> >   {
> >       struct dma_buf_sysfs_entry *sysfs_entry;
> > -     int ret;
> >
> >       if (!dmabuf || !dmabuf->file)
> >               return -EINVAL;
> > @@ -181,25 +218,16 @@ int dma_buf_stats_setup(struct dma_buf *dmabuf)
> >               return -EINVAL;
> >       }
> >
> > -     sysfs_entry =3D kzalloc(sizeof(struct dma_buf_sysfs_entry), GFP_K=
ERNEL);
> > +     sysfs_entry =3D kmalloc(sizeof(struct dma_buf_sysfs_entry), GFP_K=
ERNEL);
> >       if (!sysfs_entry)
> >               return -ENOMEM;
> >
> > -     sysfs_entry->kobj.kset =3D dma_buf_per_buffer_stats_kset;
> >       sysfs_entry->dmabuf =3D dmabuf;
> > -
> >       dmabuf->sysfs_entry =3D sysfs_entry;
> >
> > -     /* create the directory for buffer stats */
> > -     ret =3D kobject_init_and_add(&sysfs_entry->kobj, &dma_buf_ktype, =
NULL,
> > -                                "%lu", file_inode(dmabuf->file)->i_ino=
);
> > -     if (ret)
> > -             goto err_sysfs_dmabuf;
> > +     INIT_WORK(&dmabuf->sysfs_entry->sysfs_add_work, sysfs_add_workfn)=
;
> > +     get_dma_buf(dmabuf); /* This reference will be dropped in sysfs_a=
dd_workfn. */
> > +     schedule_work(&dmabuf->sysfs_entry->sysfs_add_work);
> >
> >       return 0;
> > -
> > -err_sysfs_dmabuf:
> > -     kobject_put(&sysfs_entry->kobj);
> > -     dmabuf->sysfs_entry =3D NULL;
> > -     return ret;
> >   }
> > diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> > index 2097760e8e95..0200caa3c515 100644
> > --- a/include/linux/dma-buf.h
> > +++ b/include/linux/dma-buf.h
> > @@ -22,6 +22,7 @@
> >   #include <linux/fs.h>
> >   #include <linux/dma-fence.h>
> >   #include <linux/wait.h>
> > +#include <linux/workqueue.h>
> >
> >   struct device;
> >   struct dma_buf;
> > @@ -365,7 +366,7 @@ struct dma_buf {
> >        */
> >       const char *name;
> >
>
> > -     /** @name_lock: Spinlock to protect name acces for read access. *=
/
> > +     /** @name_lock: Spinlock to protect name access for read access. =
*/
> >       spinlock_t name_lock;
> >
> >       /**
> > @@ -441,6 +442,7 @@ struct dma_buf {
> >
> >               __poll_t active;
> >       } cb_in, cb_out;
> > +
>
> Those changes are unrelated.
>
I included it here because I thought it was bad form to submit a
typo-only patch. Will remove.




> Regards,
> Christian.
>
> >   #ifdef CONFIG_DMABUF_SYSFS_STATS
> >       /**
> >        * @sysfs_entry:
> > @@ -449,7 +451,15 @@ struct dma_buf {
> >        * `DMA-BUF statistics`_ for the uapi this enables.
> >        */
> >       struct dma_buf_sysfs_entry {
> > -             struct kobject kobj;
> > +             union {
> > +                     struct kobject kobj;
> > +
> > +                     /** @sysfs_add_work:
> > +                      *
> > +                      * For deferred sysfs kobject creation using a wo=
rkqueue.
> > +                      */
> > +                     struct work_struct sysfs_add_work;
> > +             };
> >               struct dma_buf *dmabuf;
> >       } *sysfs_entry;
> >   #endif
>
