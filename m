Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 573B1487E3C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 22:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbiAGV0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 16:26:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbiAGV0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 16:26:15 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0D5C061747
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 13:26:15 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id c6so18279451ybk.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 13:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XdO46iwq1tC1PiG2BhQ2UNEb6Gb2VExfKjJyu5wm2Ws=;
        b=C8Vcv2Ezv3cekid5UOpypBsAlYRjaCbi5ai8FHrtp7e8RCF0MId0EWzg669laqOqDH
         PIPHBsTf5dpX1BNDoldlq5xZUizSl0GTb8t+ZGsXo9YTj/Gd0CK1hQJ0XdmV3jPOURK0
         daWYhW/FBEwCvGEExHS2p68SmrQ6MgwByYA0hb5+tql+mp9Y+78uTkrBimFO1+0KGFOK
         Yul1TofKEJKRAYleR5+Ut59sF62HoC/2X+blpKZ2kLH756qUBnra0ChItDiE9+XTwacO
         JU6QMFK9aY5VNi+nR1ch7DEQ+FSbDvp5Y9c1jaUbNEZmhx2ugRVkd3GKs15JzLLFc9vv
         OWGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XdO46iwq1tC1PiG2BhQ2UNEb6Gb2VExfKjJyu5wm2Ws=;
        b=hno2oLBAFRbwe4kZFejxY5tbQ7YJ3XHcxmCa4QCOjdSKJRURfEy44Jj91MZ8X/ccmJ
         JJxnNLG7nwUb0XfH8ghy7QRtd6XlJI9H8uDBbo4N0YvXryL7NLJyWVK1CCxD4JSMqKXr
         61CCreCaFvcYeX/AmW23vG3VJ/hZkD/Uc0euvpUAjSDWQNXlk3cndPNwLuEYk5CKtmtL
         c8kj33H2d08Vt6KsPdluMIMYxsWTiFuMSe9GUHJw4gTNfxaVc/Ok6pUM78kQbqMO7Zj6
         lwEUSqXR+2AwAY34zTSlCyDmYq75e1ICH/j7Dc+qx8JqIHnaKBLf3Jm2M1U9vSk4pVdk
         alzQ==
X-Gm-Message-State: AOAM531TZUChszHIIYBleMQ6NWhQ5WcVSlKgu/bav81Hcdj7znvU58j5
        EOl01zKoePnRZY9VeRIXS4N13ICjm/U19ikGBHjdjQ==
X-Google-Smtp-Source: ABdhPJz9JQoQMjz23R4lhU1eQlYWtDJpGhd6nfJRmRAgKuDUlIfQQROD6hWnMr4w45Fb1LKkCw3QYJplXPyPyEgfKl4=
X-Received: by 2002:a25:b315:: with SMTP id l21mr65037465ybj.207.1641590774480;
 Fri, 07 Jan 2022 13:26:14 -0800 (PST)
MIME-Version: 1.0
References: <20220104235148.21320-1-hridya@google.com> <49b29081-42df-ffcd-8fea-bd819499ff1b@amd.com>
 <CA+wgaPMWT0s0KNo_wM7jU+bH626OAVtn77f7_WX=E1wyU8aBzg@mail.gmail.com>
 <3a29914d-0c7b-1f10-49cb-dbc1cc6e52b0@amd.com> <CA+wgaPOmRTAuXiSRRmj-s=3d2W6ny=EMFtroOShYKrp0u+xF+g@mail.gmail.com>
In-Reply-To: <CA+wgaPOmRTAuXiSRRmj-s=3d2W6ny=EMFtroOShYKrp0u+xF+g@mail.gmail.com>
From:   Hridya Valsaraju <hridya@google.com>
Date:   Fri, 7 Jan 2022 13:25:38 -0800
Message-ID: <CA+wgaPO81R+NckRt0nzZazxs9fqSC_V_wyChU=kcMqJ01WxXNw@mail.gmail.com>
Subject: Re: [PATCH] dma-buf: Move sysfs work out of DMA-BUF export/release path
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Sumit Semwal <sumit.semwal@linaro.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        john.stultz@linaro.org, surenb@google.com, kaleshsingh@google.com,
        tjmercier@google.com, keescook@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 7, 2022 at 10:17 AM Hridya Valsaraju <hridya@google.com> wrote:
>
> On Fri, Jan 7, 2022 at 2:22 AM Christian K=C3=B6nig <christian.koenig@amd=
.com> wrote:
> >
> > Am 06.01.22 um 20:04 schrieb Hridya Valsaraju:
> > > On Thu, Jan 6, 2022 at 12:59 AM Christian K=C3=B6nig
> > > <christian.koenig@amd.com> wrote:
> > >> Am 05.01.22 um 00:51 schrieb Hridya Valsaraju:
> > >>> Recently, we noticed an issue where a process went into direct recl=
aim
> > >>> while holding the kernfs rw semaphore for sysfs in write(exclusive)
> > >>> mode. This caused processes who were doing DMA-BUF exports and rele=
ases
> > >>> to go into uninterruptible sleep since they needed to acquire the s=
ame
> > >>> semaphore for the DMA-BUF sysfs entry creation/deletion. In order t=
o avoid
> > >>> blocking DMA-BUF export/release for an indeterminate amount of time
> > >>> while another process is holding the sysfs rw semaphore in exclusiv=
e
> > >>> mode, this patch moves the per-buffer sysfs file creation/deleteion=
 to
> > >>> a kthread.
> > >> Well I absolutely don't think that this is justified.
> > >>
> > >> You adding tons of complexity here just to avoid the overhead of
> > >> creating the sysfs files while exporting DMA-bufs which is an operat=
ion
> > >> which should be done exactly once in the lifecycle for the most comm=
on
> > >> use case.
> > >>
> > >> Please explain further why that should be necessary.
> > > Hi Christian,
> > >
> > > We noticed that the issue sometimes causes the exporting process to g=
o
> > > to the uninterrupted sleep state for tens of milliseconds which
> > > unfortunately leads to user-perceptible UI jank. This is the reason
> > > why we are trying to move the sysfs entry creation and deletion out o=
f
> > > the DMA-BUF export/release path. I will update the commit message to
> > > include the same in the next revision.
> >
> > That is still not a justification for this change. The question is why
> > do you need that in the first place?
> >
> > Exporting a DMA-buf should be something would should be very rarely,
> > e.g. only at the start of an application.
>
> Hi Christian,
>
> Yes, that is correct. Noticeable jank caused by the issue is not
> present at all times and happens on UI transitions(for example during
> app launches and exits) when there are several DMA-BUFs being exported
> and released. This is especially true in the case of the camera app
> since it exports and releases a relatively larger number of DMA-BUFs
> during launch and exit respectively.
>
> Regards,
> Hridya
>
> >
> > So this strongly looks like you are trying to optimize for an use case
> > where we should probably rethink what userspace is doing here instead.

Hello Christian,

If you don't mind, could you please elaborate on the above statement?
Thanks in advance for the guidance!

Regards,
Hridya

> >
> > If we would want to go down this route you would need to change all the
> > drivers implementing the DMA-buf export functionality to avoid
> > uninterruptible sleep as well and that is certainly something I would N=
AK.
> >
> > Regards,
> > Christian.
> >
> > >
> > > Thanks,
> > > Hridya
> > >
> > >
> > >> Regards,
> > >> Christian.
> > >>
> > >>> Fixes: bdb8d06dfefd ("dmabuf: Add the capability to expose DMA-BUF =
stats in sysfs")
> > >>> Signed-off-by: Hridya Valsaraju <hridya@google.com>
> > >>> ---
> > >>>    drivers/dma-buf/dma-buf-sysfs-stats.c | 343 ++++++++++++++++++++=
++++--
> > >>>    include/linux/dma-buf.h               |  46 ++++
> > >>>    2 files changed, 366 insertions(+), 23 deletions(-)
> > >>>
> > >>> diff --git a/drivers/dma-buf/dma-buf-sysfs-stats.c b/drivers/dma-bu=
f/dma-buf-sysfs-stats.c
> > >>> index 053baadcada9..3251fdf2f05f 100644
> > >>> --- a/drivers/dma-buf/dma-buf-sysfs-stats.c
> > >>> +++ b/drivers/dma-buf/dma-buf-sysfs-stats.c
> > >>> @@ -7,13 +7,39 @@
> > >>>
> > >>>    #include <linux/dma-buf.h>
> > >>>    #include <linux/dma-resv.h>
> > >>> +#include <linux/freezer.h>
> > >>>    #include <linux/kobject.h>
> > >>> +#include <linux/kthread.h>
> > >>> +#include <linux/list.h>
> > >>>    #include <linux/printk.h>
> > >>> +#include <linux/sched/signal.h>
> > >>>    #include <linux/slab.h>
> > >>>    #include <linux/sysfs.h>
> > >>>
> > >>>    #include "dma-buf-sysfs-stats.h"
> > >>>
> > >>> +struct dmabuf_kobj_work {
> > >>> +     struct list_head list;
> > >>> +     struct dma_buf_sysfs_entry *sysfs_entry;
> > >>> +     struct dma_buf_sysfs_entry_metadata *sysfs_metadata;
> > >>> +     unsigned long uid;
> > >>> +};
> > >>> +
> > >>> +/* Both kobject setup and teardown work gets queued on the list. *=
/
> > >>> +static LIST_HEAD(dmabuf_kobj_work_list);
> > >>> +
> > >>> +/* dmabuf_kobj_list_lock protects dmabuf_kobj_work_list. */
> > >>> +static DEFINE_SPINLOCK(dmabuf_kobj_list_lock);
> > >>> +
> > >>> +/*
> > >>> + * dmabuf_sysfs_show_lock prevents a race between a DMA-BUF sysfs =
file being
> > >>> + * read and the DMA-BUF being freed by protecting sysfs_entry->dma=
buf.
> > >>> + */
> > >>> +static DEFINE_SPINLOCK(dmabuf_sysfs_show_lock);
> > >>> +
> > >>> +static struct task_struct *dmabuf_kobject_task;
> > >>> +static wait_queue_head_t dmabuf_kobject_waitqueue;
> > >>> +
> > >>>    #define to_dma_buf_entry_from_kobj(x) container_of(x, struct dma=
_buf_sysfs_entry, kobj)
> > >>>
> > >>>    /**
> > >>> @@ -64,15 +90,26 @@ static ssize_t dma_buf_stats_attribute_show(str=
uct kobject *kobj,
> > >>>        struct dma_buf_stats_attribute *attribute;
> > >>>        struct dma_buf_sysfs_entry *sysfs_entry;
> > >>>        struct dma_buf *dmabuf;
> > >>> +     int ret;
> > >>>
> > >>>        attribute =3D to_dma_buf_stats_attr(attr);
> > >>>        sysfs_entry =3D to_dma_buf_entry_from_kobj(kobj);
> > >>> +
> > >>> +     /*
> > >>> +      * acquire dmabuf_sysfs_show_lock to prevent a race with the =
DMA-BUF
> > >>> +      * being freed while sysfs_entry->dmabuf is being accessed.
> > >>> +      */
> > >>> +     spin_lock(&dmabuf_sysfs_show_lock);
> > >>>        dmabuf =3D sysfs_entry->dmabuf;
> > >>>
> > >>> -     if (!dmabuf || !attribute->show)
> > >>> +     if (!dmabuf || !attribute->show) {
> > >>> +             spin_unlock(&dmabuf_sysfs_show_lock);
> > >>>                return -EIO;
> > >>> +     }
> > >>>
> > >>> -     return attribute->show(dmabuf, attribute, buf);
> > >>> +     ret =3D attribute->show(dmabuf, attribute, buf);
> > >>> +     spin_unlock(&dmabuf_sysfs_show_lock);
> > >>> +     return ret;
> > >>>    }
> > >>>
> > >>>    static const struct sysfs_ops dma_buf_stats_sysfs_ops =3D {
> > >>> @@ -118,33 +155,275 @@ static struct kobj_type dma_buf_ktype =3D {
> > >>>        .default_groups =3D dma_buf_stats_default_groups,
> > >>>    };
> > >>>
> > >>> -void dma_buf_stats_teardown(struct dma_buf *dmabuf)
> > >>> +/* Statistics files do not need to send uevents. */
> > >>> +static int dmabuf_sysfs_uevent_filter(struct kset *kset, struct ko=
bject *kobj)
> > >>>    {
> > >>> -     struct dma_buf_sysfs_entry *sysfs_entry;
> > >>> +     return 0;
> > >>> +}
> > >>>
> > >>> -     sysfs_entry =3D dmabuf->sysfs_entry;
> > >>> -     if (!sysfs_entry)
> > >>> -             return;
> > >>> +static const struct kset_uevent_ops dmabuf_sysfs_no_uevent_ops =3D=
 {
> > >>> +     .filter =3D dmabuf_sysfs_uevent_filter,
> > >>> +};
> > >>> +
> > >>> +/* setup of sysfs entries done asynchronously in the worker thread=
. */
> > >>> +static void dma_buf_sysfs_stats_setup_work(struct dmabuf_kobj_work=
 *kobject_work)
> > >>> +{
> > >>> +     struct dma_buf_sysfs_entry *sysfs_entry =3D kobject_work->sys=
fs_entry;
> > >>> +     struct dma_buf_sysfs_entry_metadata *sysfs_metadata =3D
> > >>> +                     kobject_work->sysfs_metadata;
> > >>> +     bool free_metadata =3D false;
> > >>> +
> > >>> +     int ret =3D kobject_init_and_add(&sysfs_entry->kobj, &dma_buf=
_ktype, NULL,
> > >>> +                                    "%lu", kobject_work->uid);
> > >>> +     if (ret) {
> > >>> +             kobject_put(&sysfs_entry->kobj);
> > >>> +
> > >>> +             spin_lock(&sysfs_metadata->sysfs_entry_lock);
> > >>> +             if (sysfs_metadata->status =3D=3D SYSFS_ENTRY_INIT_AB=
ORTED) {
> > >>> +                     /*
> > >>> +                      * SYSFS_ENTRY_INIT_ABORTED means that the DM=
A-BUF has already
> > >>> +                      * been freed. At this point, its safe to fre=
e the memory for
> > >>> +                      * the sysfs_metadata;
> > >>> +                      */
> > >>> +                     free_metadata =3D true;
> > >>> +             } else {
> > >>> +                     /*
> > >>> +                      * The DMA-BUF has not yet been freed, set th=
e status to
> > >>> +                      * sysfs_entry_error so that when the DMA-BUF=
 gets
> > >>> +                      * freed, we know there is no need to teardow=
n the sysfs
> > >>> +                      * entry.
> > >>> +                      */
> > >>> +                     sysfs_metadata->status =3D SYSFS_ENTRY_ERROR;
> > >>> +             }
> > >>> +             goto unlock;
> > >>> +     }
> > >>> +
> > >>> +     /*
> > >>> +      * If the DMA-BUF has not yet been released, status would sti=
ll be
> > >>> +      * SYSFS_ENTRY_INIT_IN_PROGRESS. We set the status as initial=
ized.
> > >>> +      */
> > >>> +     spin_lock(&sysfs_metadata->sysfs_entry_lock);
> > >>> +     if (sysfs_metadata->status =3D=3D SYSFS_ENTRY_INIT_IN_PROGRES=
S) {
> > >>> +             sysfs_metadata->status =3D SYSFS_ENTRY_INITIALIZED;
> > >>> +             goto unlock;
> > >>> +     }
> > >>>
> > >>> +     /*
> > >>> +      * At this point the status is SYSFS_ENTRY_INIT_ABORTED which=
 means
> > >>> +      * that the DMA-BUF has already been freed. Hence, we cleanup=
 the
> > >>> +      * sysfs_entry and its metadata since neither of them are nee=
ded
> > >>> +      * anymore.
> > >>> +      */
> > >>> +     free_metadata =3D true;
> > >>>        kobject_del(&sysfs_entry->kobj);
> > >>>        kobject_put(&sysfs_entry->kobj);
> > >>> +
> > >>> +unlock:
> > >>> +     spin_unlock(&sysfs_metadata->sysfs_entry_lock);
> > >>> +     if (free_metadata) {
> > >>> +             kfree(kobject_work->sysfs_metadata);
> > >>> +             kobject_work->sysfs_metadata =3D NULL;
> > >>> +     }
> > >>>    }
> > >>>
> > >>> +/* teardown of sysfs entries done asynchronously in the worker thr=
ead. */
> > >>> +static void dma_buf_sysfs_stats_teardown_work(struct dmabuf_kobj_w=
ork *kobject_work)
> > >>> +{
> > >>> +     struct dma_buf_sysfs_entry *sysfs_entry =3D kobject_work->sys=
fs_entry;
> > >>>
> > >>> -/* Statistics files do not need to send uevents. */
> > >>> -static int dmabuf_sysfs_uevent_filter(struct kset *kset, struct ko=
bject *kobj)
> > >>> +     kobject_del(&sysfs_entry->kobj);
> > >>> +     kobject_put(&sysfs_entry->kobj);
> > >>> +
> > >>> +     kfree(kobject_work->sysfs_metadata);
> > >>> +     kobject_work->sysfs_metadata =3D NULL;
> > >>> +}
> > >>> +
> > >>> +/* do setup or teardown of sysfs entries as required */
> > >>> +static void do_kobject_work(struct dmabuf_kobj_work *kobject_work)
> > >>>    {
> > >>> +     struct dma_buf_sysfs_entry_metadata *sysfs_metadata;
> > >>> +     bool setup_needed =3D false;
> > >>> +     bool teardown_needed =3D false;
> > >>> +
> > >>> +     sysfs_metadata =3D kobject_work->sysfs_metadata;
> > >>> +     spin_lock(&sysfs_metadata->sysfs_entry_lock);
> > >>> +     if (sysfs_metadata->status =3D=3D SYSFS_ENTRY_UNINITIALIZED) =
{
> > >>> +             setup_needed =3D true;
> > >>> +             sysfs_metadata->status =3D SYSFS_ENTRY_INIT_IN_PROGRE=
SS;
> > >>> +     } else if (sysfs_metadata->status =3D=3D SYSFS_ENTRY_INITIALI=
ZED) {
> > >>> +             teardown_needed =3D true;
> > >>> +     }
> > >>> +
> > >>> +     /*
> > >>> +      * It is ok to release the sysfs_entry_lock here.
> > >>> +      *
> > >>> +      * If setup_needed is true, we check the status again after t=
he kobject
> > >>> +      * initialization to see if it has been set to SYSFS_ENTRY_IN=
IT_ABORTED
> > >>> +      * and if so teardown the kobject.
> > >>> +      *
> > >>> +      * If teardown_needed is true, there are no more changes expe=
cted to the
> > >>> +      * status.
> > >>> +      *
> > >>> +      * If neither setup_needed nor teardown needed are true, it
> > >>> +      * means the DMA-BUF was freed before we got around to settin=
g up the
> > >>> +      * sysfs entry and hence we just need to release the metadata=
 and
> > >>> +      * return.
> > >>> +      */
> > >>> +     spin_unlock(&kobject_work->sysfs_metadata->sysfs_entry_lock);
> > >>> +
> > >>> +     if (setup_needed)
> > >>> +             dma_buf_sysfs_stats_setup_work(kobject_work);
> > >>> +     else if (teardown_needed)
> > >>> +             dma_buf_sysfs_stats_teardown_work(kobject_work);
> > >>> +     else
> > >>> +             kfree(kobject_work->sysfs_metadata);
> > >>> +
> > >>> +     kfree(kobject_work);
> > >>> +}
> > >>> +
> > >>> +static struct dmabuf_kobj_work *get_next_kobj_work(void)
> > >>> +{
> > >>> +     struct dmabuf_kobj_work *kobject_work;
> > >>> +
> > >>> +     spin_lock(&dmabuf_kobj_list_lock);
> > >>> +     kobject_work =3D list_first_entry_or_null(&dmabuf_kobj_work_l=
ist,
> > >>> +                                             struct dmabuf_kobj_wo=
rk, list);
> > >>> +     if (kobject_work)
> > >>> +             list_del(&kobject_work->list);
> > >>> +     spin_unlock(&dmabuf_kobj_list_lock);
> > >>> +     return kobject_work;
> > >>> +}
> > >>> +
> > >>> +static int kobject_work_thread(void *data)
> > >>> +{
> > >>> +     struct dmabuf_kobj_work *kobject_work;
> > >>> +
> > >>> +     while (1) {
> > >>> +             wait_event_freezable(dmabuf_kobject_waitqueue,
> > >>> +                                  (kobject_work =3D get_next_kobj_=
work()));
> > >>> +             do_kobject_work(kobject_work);
> > >>> +     }
> > >>> +
> > >>>        return 0;
> > >>>    }
> > >>>
> > >>> -static const struct kset_uevent_ops dmabuf_sysfs_no_uevent_ops =3D=
 {
> > >>> -     .filter =3D dmabuf_sysfs_uevent_filter,
> > >>> -};
> > >>> +static int kobject_worklist_init(void)
> > >>> +{
> > >>> +     init_waitqueue_head(&dmabuf_kobject_waitqueue);
> > >>> +     dmabuf_kobject_task =3D kthread_run(kobject_work_thread, NULL=
,
> > >>> +                                       "%s", "dmabuf-kobject-worke=
r");
> > >>> +     if (IS_ERR(dmabuf_kobject_task)) {
> > >>> +             pr_err("Creating thread for deferred sysfs entry crea=
tion/deletion failed\n");
> > >>> +             return PTR_ERR(dmabuf_kobject_task);
> > >>> +     }
> > >>> +     sched_set_normal(dmabuf_kobject_task, MAX_NICE);
> > >>> +
> > >>> +     return 0;
> > >>> +}
> > >>> +
> > >>> +static void deferred_kobject_create(struct dmabuf_kobj_work *kobje=
ct_work)
> > >>> +{
> > >>> +     INIT_LIST_HEAD(&kobject_work->list);
> > >>> +
> > >>> +     spin_lock(&dmabuf_kobj_list_lock);
> > >>> +
> > >>> +     list_add_tail(&kobject_work->list, &dmabuf_kobj_work_list);
> > >>> +
> > >>> +     spin_unlock(&dmabuf_kobj_list_lock);
> > >>> +
> > >>> +     wake_up(&dmabuf_kobject_waitqueue);
> > >>> +}
> > >>> +
> > >>> +
> > >>> +void dma_buf_stats_teardown(struct dma_buf *dmabuf)
> > >>> +{
> > >>> +     struct dma_buf_sysfs_entry *sysfs_entry;
> > >>> +     struct dma_buf_sysfs_entry_metadata *sysfs_metadata;
> > >>> +     struct dmabuf_kobj_work *kobj_work;
> > >>> +
> > >>> +     sysfs_entry =3D dmabuf->sysfs_entry;
> > >>> +     if (!sysfs_entry)
> > >>> +             return;
> > >>> +
> > >>> +     sysfs_metadata =3D dmabuf->sysfs_entry_metadata;
> > >>> +     if (!sysfs_metadata)
> > >>> +             return;
> > >>> +
> > >>> +     spin_lock(&sysfs_metadata->sysfs_entry_lock);
> > >>> +
> > >>> +     if (sysfs_metadata->status =3D=3D SYSFS_ENTRY_UNINITIALIZED |=
|
> > >>> +         sysfs_metadata->status =3D=3D SYSFS_ENTRY_INIT_IN_PROGRES=
S) {
> > >>> +             /*
> > >>> +              * The sysfs entry for this buffer has not yet been i=
nitialized,
> > >>> +              * we set the status to SYSFS_ENTRY_INIT_ABORTED to a=
bort the
> > >>> +              * initialization.
> > >>> +              */
> > >>> +             sysfs_metadata->status =3D SYSFS_ENTRY_INIT_ABORTED;
> > >>> +             spin_unlock(&sysfs_metadata->sysfs_entry_lock);
> > >>> +
> > >>> +             /*
> > >>> +              * In case kobject initialization completes right as =
we release
> > >>> +              * the sysfs_entry_lock, disable show() for the sysfs=
 entry by
> > >>> +              * setting sysfs_entry->dmabuf to NULL to prevent a r=
ace.
> > >>> +              */
> > >>> +             spin_lock(&dmabuf_sysfs_show_lock);
> > >>> +             sysfs_entry->dmabuf =3D NULL;
> > >>> +             spin_unlock(&dmabuf_sysfs_show_lock);
> > >>> +
> > >>> +             return;
> > >>> +     }
> > >>> +
> > >>> +     if (sysfs_metadata->status =3D=3D SYSFS_ENTRY_INITIALIZED) {
> > >>> +             /*
> > >>> +              * queue teardown work only if sysfs_entry is fully i=
nititalized.
> > >>> +              * It is ok to release the sysfs_entry_lock here sinc=
e the
> > >>> +              * status can no longer change.
> > >>> +              */
> > >>> +             spin_unlock(&sysfs_metadata->sysfs_entry_lock);
> > >>> +
> > >>> +             /*
> > >>> +              * Meanwhile disable show() for the sysfs entry to av=
oid a race
> > >>> +              * between teardown and show().
> > >>> +              */
> > >>> +             spin_lock(&dmabuf_sysfs_show_lock);
> > >>> +             sysfs_entry->dmabuf =3D NULL;
> > >>> +             spin_unlock(&dmabuf_sysfs_show_lock);
> > >>> +
> > >>> +             kobj_work =3D kzalloc(sizeof(struct dmabuf_kobj_work)=
, GFP_KERNEL);
> > >>> +             if (!kobj_work) {
> > >>> +                     /* do the teardown immediately. */
> > >>> +                     kobject_del(&sysfs_entry->kobj);
> > >>> +                     kobject_put(&sysfs_entry->kobj);
> > >>> +                     kfree(sysfs_metadata);
> > >>> +             } else {
> > >>> +                     /* queue teardown work. */
> > >>> +                     kobj_work->sysfs_entry =3D dmabuf->sysfs_entr=
y;
> > >>> +                     kobj_work->sysfs_metadata =3D dmabuf->sysfs_e=
ntry_metadata;
> > >>> +                     deferred_kobject_create(kobj_work);
> > >>> +             }
> > >>> +
> > >>> +             return;
> > >>> +     }
> > >>> +
> > >>> +     /*
> > >>> +      * status is SYSFS_ENTRY_INIT_ERROR so we only need to free t=
he
> > >>> +      * metadata.
> > >>> +      */
> > >>> +     spin_unlock(&sysfs_metadata->sysfs_entry_lock);
> > >>> +     kfree(dmabuf->sysfs_entry_metadata);
> > >>> +     dmabuf->sysfs_entry_metadata =3D NULL;
> > >>> +}
> > >>>
> > >>>    static struct kset *dma_buf_stats_kset;
> > >>>    static struct kset *dma_buf_per_buffer_stats_kset;
> > >>>    int dma_buf_init_sysfs_statistics(void)
> > >>>    {
> > >>> +     int ret;
> > >>> +
> > >>> +     ret =3D kobject_worklist_init();
> > >>> +     if (ret)
> > >>> +             return ret;
> > >>> +
> > >>>        dma_buf_stats_kset =3D kset_create_and_add("dmabuf",
> > >>>                                                 &dmabuf_sysfs_no_ue=
vent_ops,
> > >>>                                                 kernel_kobj);
> > >>> @@ -171,7 +450,8 @@ void dma_buf_uninit_sysfs_statistics(void)
> > >>>    int dma_buf_stats_setup(struct dma_buf *dmabuf)
> > >>>    {
> > >>>        struct dma_buf_sysfs_entry *sysfs_entry;
> > >>> -     int ret;
> > >>> +     struct dma_buf_sysfs_entry_metadata *sysfs_metadata;
> > >>> +     struct dmabuf_kobj_work *kobj_work;
> > >>>
> > >>>        if (!dmabuf || !dmabuf->file)
> > >>>                return -EINVAL;
> > >>> @@ -188,18 +468,35 @@ int dma_buf_stats_setup(struct dma_buf *dmabu=
f)
> > >>>        sysfs_entry->kobj.kset =3D dma_buf_per_buffer_stats_kset;
> > >>>        sysfs_entry->dmabuf =3D dmabuf;
> > >>>
> > >>> +     sysfs_metadata =3D kzalloc(sizeof(struct dma_buf_sysfs_entry_=
metadata),
> > >>> +                              GFP_KERNEL);
> > >>> +     if (!sysfs_metadata) {
> > >>> +             kfree(sysfs_entry);
> > >>> +             return -ENOMEM;
> > >>> +     }
> > >>> +
> > >>>        dmabuf->sysfs_entry =3D sysfs_entry;
> > >>>
> > >>> -     /* create the directory for buffer stats */
> > >>> -     ret =3D kobject_init_and_add(&sysfs_entry->kobj, &dma_buf_kty=
pe, NULL,
> > >>> -                                "%lu", file_inode(dmabuf->file)->i=
_ino);
> > >>> -     if (ret)
> > >>> -             goto err_sysfs_dmabuf;
> > >>> +     sysfs_metadata->status =3D SYSFS_ENTRY_UNINITIALIZED;
> > >>> +     spin_lock_init(&sysfs_metadata->sysfs_entry_lock);
> > >>>
> > >>> -     return 0;
> > >>> +     dmabuf->sysfs_entry_metadata =3D sysfs_metadata;
> > >>>
> > >>> -err_sysfs_dmabuf:
> > >>> -     kobject_put(&sysfs_entry->kobj);
> > >>> -     dmabuf->sysfs_entry =3D NULL;
> > >>> -     return ret;
> > >>> +     kobj_work =3D kzalloc(sizeof(struct dmabuf_kobj_work), GFP_KE=
RNEL);
> > >>> +     if (!kobj_work) {
> > >>> +             kfree(sysfs_entry);
> > >>> +             kfree(sysfs_metadata);
> > >>> +             return -ENOMEM;
> > >>> +     }
> > >>> +
> > >>> +     kobj_work->sysfs_entry =3D dmabuf->sysfs_entry;
> > >>> +     kobj_work->sysfs_metadata =3D dmabuf->sysfs_entry_metadata;
> > >>> +     /*
> > >>> +      * stash the inode number in struct dmabuf_kobj_work since se=
tup
> > >>> +      * might race with DMA-BUF teardown.
> > >>> +      */
> > >>> +     kobj_work->uid =3D file_inode(dmabuf->file)->i_ino;
> > >>> +
> > >>> +     deferred_kobject_create(kobj_work);
> > >>> +     return 0;
> > >>>    }
> > >>> diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> > >>> index 7ab50076e7a6..0597690023a0 100644
> > >>> --- a/include/linux/dma-buf.h
> > >>> +++ b/include/linux/dma-buf.h
> > >>> @@ -287,6 +287,50 @@ struct dma_buf_ops {
> > >>>        void (*vunmap)(struct dma_buf *dmabuf, struct dma_buf_map *m=
ap);
> > >>>    };
> > >>>
> > >>> +#ifdef CONFIG_DMABUF_SYSFS_STATS
> > >>> +enum sysfs_entry_status {
> > >>> +     SYSFS_ENTRY_UNINITIALIZED,
> > >>> +     SYSFS_ENTRY_INIT_IN_PROGRESS,
> > >>> +     SYSFS_ENTRY_ERROR,
> > >>> +     SYSFS_ENTRY_INIT_ABORTED,
> > >>> +     SYSFS_ENTRY_INITIALIZED,
> > >>> +};
> > >>> +
> > >>> +/*
> > >>> + * struct dma_buf_sysfs_entry_metadata - Holds the current status =
for the
> > >>> + * DMA-BUF sysfs entry.
> > >>> + *
> > >>> + * @status: holds the current status for the DMA-BUF sysfs entry. =
The status of
> > >>> + * the sysfs entry has the following path.
> > >>> + *
> > >>> + *                   SYSFS_ENTRY_UNINITIALIZED
> > >>> + *            __________________|____________________
> > >>> + *           |                                       |
> > >>> + *     SYSFS_ENTRY_INIT_IN_PROGRESS      SYSFS_ENTRY_INIT_ABORTED =
(DMA-BUF
> > >>> + *           |                                                    =
 gets freed
> > >>> + *           |                                                    =
 before
> > >>> + *           |                                                    =
 init)
> > >>> + *   ________|_____________________________________
> > >>> + *   |                         |                   |
> > >>> + * SYSFS_ENTRY_INITIALIZED     |       SYSFS_ENTRY_INIT_ABORTED
> > >>> + *                             |               (DMA-BUF gets freed=
 during kobject
> > >>> + *                             |               init)
> > >>> + *                             |
> > >>> + *                             |
> > >>> + *                 SYSFS_ENTRY_ERROR
> > >>> + *                 (error during kobject init)
> > >>> + *
> > >>> + * @sysfs_entry_lock: protects access to @status.
> > >>> + */
> > >>> +struct dma_buf_sysfs_entry_metadata {
> > >>> +     enum sysfs_entry_status status;
> > >>> +     /*
> > >>> +      * Protects sysfs_entry_metadata->status
> > >>> +      */
> > >>> +     spinlock_t sysfs_entry_lock;
> > >>> +};
> > >>> +#endif
> > >>> +
> > >>>    /**
> > >>>     * struct dma_buf - shared buffer object
> > >>>     *
> > >>> @@ -452,6 +496,8 @@ struct dma_buf {
> > >>>                struct kobject kobj;
> > >>>                struct dma_buf *dmabuf;
> > >>>        } *sysfs_entry;
> > >>> +
> > >>> +     struct dma_buf_sysfs_entry_metadata *sysfs_entry_metadata;
> > >>>    #endif
> > >>>    };
> > >>>
> >
