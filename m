Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D8556204C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 18:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236087AbiF3Q2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 12:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235445AbiF3Q2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 12:28:35 -0400
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE59513F40;
        Thu, 30 Jun 2022 09:28:33 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id q132so34659275ybg.10;
        Thu, 30 Jun 2022 09:28:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U9GjRwiaqVTSHLEe+recFUTQ+XFqFuJ1dVz4o0C8jTQ=;
        b=5t3OOhEqJQcGWAuTgy4MAJFXPNNm1H997s8e+waPkKrdwCs+k0OAnDwaYVKn3nh7Iv
         3IL11yCyr/v8R47oezIZ5sjpwTCIia4uZo/hsYeuVlQefODCRu6wpMfKaGaPDxbwvTcD
         azC+zATLhawMrW4QqgjmkoNcazkqkat8Y/rHvRhkR4IaK4bYmEonjDLhNLSyM4FfuO1E
         MJieManZZnCoMUalPncnMPU2yZFbyW4tcQjqafpMWmDk2HcRHs6I0fW9q2kCxOFDJNU/
         kNsKKJiiymh6cLrW7zOT0lvuMutvrRGXztEzxdRDdNjChl0C9wt2dmbh8hFXd9ywPWQu
         RzJw==
X-Gm-Message-State: AJIora9AUzf4H2haxDOm9LTF1ZqKn5xRmmox91TPH0Fet6tnP78EyJTv
        JClN7lIVxBcN7plspUKuR3YArBKwi1/X1LZ+42Y=
X-Google-Smtp-Source: AGRyM1sw8VfmW7KzVzYiAk2w9q5XP5vN1MhOU9ywlmvW31yRdLL5Dg7L3UWDVjPvKc9263RCG6c1jxTHgyC7Mbj03ag=
X-Received: by 2002:a25:ae26:0:b0:66d:1fdc:263c with SMTP id
 a38-20020a25ae26000000b0066d1fdc263cmr10673355ybj.137.1656606513087; Thu, 30
 Jun 2022 09:28:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220613120755.14306-1-peter.wang@mediatek.com>
 <b55d5691-0b2d-56bb-26ff-dcac56770611@mediatek.com> <CAJZ5v0gTpv2gt_Gm9rUd+8Jmp4=ij2=J20o7qO0sC-hm=w3=_A@mail.gmail.com>
 <12028598.O9o76ZdvQC@kreacher> <90b5f619-2dd6-817b-fe2d-f895be0b5b98@mediatek.com>
 <CAJZ5v0h8xNCV+1YwRA5wob6Vnvz8JFikv3pYMR_mUrXxzfc=tQ@mail.gmail.com> <f6ebfd39-a27a-8b1c-6a61-f9a63236961d@mediatek.com>
In-Reply-To: <f6ebfd39-a27a-8b1c-6a61-f9a63236961d@mediatek.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 30 Jun 2022 18:28:21 +0200
Message-ID: <CAJZ5v0gChpusk6JuTG+Zhd_qGR1N+s97Avn4ybdp7Ggpv_uRaQ@mail.gmail.com>
Subject: Re: [PATCH v1] PM-runtime: Check supplier_preactivated before release supplier
To:     Peter Wang <peter.wang@mediatek.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 5:19 PM Peter Wang <peter.wang@mediatek.com> wrote:
>
>
> On 6/30/22 10:47 PM, Rafael J. Wysocki wrote:
> > On Thu, Jun 30, 2022 at 4:26 PM Peter Wang <peter.wang@mediatek.com> wrote:
> >>
> >> On 6/30/22 12:01 AM, Rafael J. Wysocki wrote:
> >>> [Add CCs to linix-pm, LKML and Greg]
> >>>
> >>> On Wednesday, June 29, 2022 5:32:00 PM CEST Rafael J. Wysocki wrote:
> >>>> On Wed, Jun 29, 2022 at 4:47 PM Peter Wang <peter.wang@mediatek.com> wrote:
> >>>>> On 6/29/22 9:22 PM, Rafael J. Wysocki wrote:
> >>>>>> On Wed, Jun 29, 2022 at 5:02 AM Peter Wang <peter.wang@mediatek.com> wrote:
> >>>>>>> On 6/28/22 11:54 PM, Rafael J. Wysocki wrote:
> >>>>>>>> On Tue, Jun 28, 2022 at 3:53 AM Peter Wang <peter.wang@mediatek.com> wrote:
> >>>>>>>>> On 6/28/22 3:00 AM, Rafael J. Wysocki wrote:
> >>>>>>>>>> On Mon, Jun 13, 2022 at 2:08 PM <peter.wang@mediatek.com> wrote:
> >>>>>>>>>>> From: Peter Wang <peter.wang@mediatek.com>
> >>>>>>>>>>>
> >>>>>>>>>>> With divice link of DL_FLAG_PM_RUNTIME, if consumer call pm_runtime_get_suppliers
> >>>>>>>>>>> to prevent supplier enter suspend, pm_runtime_release_supplier should
> >>>>>>>>>>> check supplier_preactivated before let supplier enter suspend.
> >>>>>>>>>> Why?
> >>>>>>>>> because supplier_preactivated is true means supplier cannot enter
> >>>>>>>>> suspend, right?
> >>>>>>>> No, it doesn't mean that.
> >>>>>>> Hi Rafael,
> >>>>>>>
> >>>>>>> if supplier_preactivated is true, means someone call
> >>>>>>> pm_runtime_get_suppliers and
> >>>>>>> before pm_runtime_put_suppliers right? This section suppliers should not
> >>>>>>> enter suspend.
> >>>>>> No, this is not how this is expected to work.
> >>>>>>
> >>>>>> First off, the only caller of pm_runtime_get_suppliers() and
> >>>>>> pm_runtime_put_suppliers() is __driver_probe_device().  Really nobody
> >>>>>> else has any business that would require calling them.
> >>>>> Hi Rafael,
> >>>>>
> >>>>> Yes, you are right!
> >>>>> __driver_probe_device the only one use and just because
> >>>>> __driver_probe_device use
> >>>>> pm_runtime_get_suppliers cause problem.
> >>>>>
> >>>>>
> >>>>>> Second, the role of pm_runtime_get_suppliers() is to "preactivate" the
> >>>>>> suppliers before running probe for a consumer device and the role of
> >>>>> the role of pm_runtime_get_suppliers() is to "preactivate" the suppliers,
> >>>>> but suppliers may suspend immediately after preactivate right?
> >>>>> Here is just this case. this is first racing point.
> >>>>> Thread A: pm_runtime_get_suppliers                -> __driver_probe_device
> >>>>> Thread B: pm_runtime_release_supplier
> >>>>> Thread A: Run with supplier not preactivate      -> __driver_probe_device
> >>>>>
> >>>>>> pm_runtime_put_suppliers() is to do the cleanup in case the device is
> >>>>>> left in suspend after probing.
> >>>>>>
> >>>>>> IOW, pm_runtime_get_suppliers() is to ensure that the suppliers will
> >>>>>> be active until the probe callback takes over and the rest depends on
> >>>>>> that callback.
> >>>>> The problem of this racing will finally let consumer is active but
> >>>>> supplier is suspended.
> >>>> So it would be better to send a bug report regarding this.
> >>>>
> >>>>> The link relation is broken.
> >>>>> I know you may curious how it happened? right?
> >>>>> Honestly, I am not sure, but I think the second racing point
> >>>>> is rpm_get_suppliers and pm_runtime_put_suppliers(release rpm_active).
> >>>> I'm not sure what you mean by "the racing point".
> >>>>
> >>>> Yes, these functions can run concurrently.
> >>>>
> >>>>> So, I try to fix the first racing point and the problem is gone.
> >>>>> It is full meet expect, and the pm runtime will work smoothly after
> >>>>> __driver_probe_device done.
> >>>> I'm almost sure that there is at least one scenario that would be
> >>>> broken by this change.
> >>> That said, the code in there may be a bit overdesigned.
> >>>
> >>> Does the patch below help?
> >>>
> >>> ---
> >>>    drivers/base/power/runtime.c |   14 +-------------
> >>>    1 file changed, 1 insertion(+), 13 deletions(-)
> >>>
> >>> Index: linux-pm/drivers/base/power/runtime.c
> >>> ===================================================================
> >>> --- linux-pm.orig/drivers/base/power/runtime.c
> >>> +++ linux-pm/drivers/base/power/runtime.c
> >>> @@ -1768,7 +1768,6 @@ void pm_runtime_get_suppliers(struct dev
> >>>                if (link->flags & DL_FLAG_PM_RUNTIME) {
> >>>                        link->supplier_preactivated = true;
> >>>                        pm_runtime_get_sync(link->supplier);
> >>> -                     refcount_inc(&link->rpm_active);
> >>>                }
> >>>
> >>>        device_links_read_unlock(idx);
> >>> @@ -1788,19 +1787,8 @@ void pm_runtime_put_suppliers(struct dev
> >>>        list_for_each_entry_rcu(link, &dev->links.suppliers, c_node,
> >>>                                device_links_read_lock_held())
> >>>                if (link->supplier_preactivated) {
> >>> -                     bool put;
> >>> -
> >>>                        link->supplier_preactivated = false;
> >>> -
> >>> -                     spin_lock_irq(&dev->power.lock);
> >>> -
> >>> -                     put = pm_runtime_status_suspended(dev) &&
> >>> -                           refcount_dec_not_one(&link->rpm_active);
> >>> -
> >>> -                     spin_unlock_irq(&dev->power.lock);
> >>> -
> >>> -                     if (put)
> >>> -                             pm_runtime_put(link->supplier);
> >>> +                     pm_runtime_put(link->supplier);
> >>>                }
> >>>
> >>>        device_links_read_unlock(idx);
> >>
> >> Hi Rafael,
> >>
> >> I think this patch solve the rpm_active racing problem.
> >> But it still have problem that
> >> pm_runtime_get_suppliers call pm_runtime_get_sync(link->supplier)
> >> and supplier could suspend immediately by other thread who call
> >> pm_runtime_release_supplier.
> > No, it won't, because pm_runtime_release_supplier() won't drop the
> > reference on the supplier taken by pm_runtime_get_suppliers(0 after
> > the patch.
>
> Hi Rafael,
>
> I think pm_runtime_release_supplier will always decrese the reference
> rpm_active count to 1 and check idle will let supplier enter suspend. Am
> I wrong?
>
> Could you explain why this patch won't drop the reference?

What matters is the supplier's PM-runtime usage counter and (with the
patch above applied) pm_runtime_get_suppliers() bumps it up via
pm_runtime_get_sync() and it doesn't bump up the device link's
rpm_active count at the same time.

This is important, because the number of times
pm_runtime_release_supplier() decrements the supplier's usage counter
is the same as the rpm_active count value at the beginning of that
function minus 1.  Now, rpm_active is 1 initially and every time it
gets incremented, the supplier's usage counter is also incremented.
Combined with the observation in the previous paragraph, this means
that after pm_runtime_get_suppliers() the value of the supplier's
PM-runtime usage counter will always be greater than the rpm_active
value minus 1, so pm_runtime_release_supplier() cannot decrement it
down to zero until pm_runtime_put_suppliers() runs.
