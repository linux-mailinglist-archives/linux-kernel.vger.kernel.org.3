Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8374E6F31
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 08:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244520AbiCYHzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 03:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiCYHy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 03:54:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5CCDD5BD1D
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 00:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648194803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5n657RBxJ9u00nOhcNkzlNKfY65Y8K8C3fIfane0FAY=;
        b=d05VTF+FjoOI02PvK8/2YgDUen5exbnUCN2meT+af2VHWRH1YkvjPQm1gHoQg9+PM42fBc
        0PY9TBbIi5628LtLWGgovbE4lezQJvs/9EuY6xC8K5lVF4ao8pqPb2+1c0LH4un0Gd6VZw
        oa8YlgWDBXZX1/JEwhCv8w2xQvzc3M4=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-450-2iYE_WNJMfybs1Hj2JOytg-1; Fri, 25 Mar 2022 03:53:22 -0400
X-MC-Unique: 2iYE_WNJMfybs1Hj2JOytg-1
Received: by mail-yb1-f198.google.com with SMTP id e7-20020a258747000000b00633ee0cbca5so5535156ybn.23
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 00:53:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5n657RBxJ9u00nOhcNkzlNKfY65Y8K8C3fIfane0FAY=;
        b=jfv400RKEwiAXec8Viw6JCFrfzRovC7LgSLovaOPWbyHJzqf4DjAoYJJ/wg/NlNBf0
         tf1AWvDSujQ8xYXZmPprSujKymVh0UfJT21I+ICJz5WHHOn9FxgBSth3QDzB8u7lNoEk
         GTrSDtf63jTVcyuAHYTWS5hHbTXbb0rP0yFHqUfgHGWxAT0i983L4FlFGxqP+cthMQPR
         ossyYlg9B765Ao0DCleYLB0Kh0tEME2sHPk2WETdHzyT4QAkOtxDfXAkiO/zC3+5yJ+t
         nRHZWtm5nWkk3pe0JCM/vdiRRxKIAVuxH27mE93ev5ZAO+vyHvtSTVxlv57vXsZ8h/77
         hjFA==
X-Gm-Message-State: AOAM533wYFXOzoUI/c03lWUIPMWfM3AgktwhQc1xkXZVd34efX4JfvM3
        qwHHk6Qumak93yR5hJpkR1oYmby5FdrASoiTblHa29FNqU0K0GqoWcAkXXBmAjL6wmZnJIla3od
        F6RdrvnDagrqKpdlLo5eDQ8jvx+f8hsntr9LLIkMC
X-Received: by 2002:a81:5309:0:b0:2e6:dcfc:8665 with SMTP id h9-20020a815309000000b002e6dcfc8665mr3622391ywb.501.1648194801635;
        Fri, 25 Mar 2022 00:53:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzmokIvXmKspUJ2XeJF0/jBSJruMy179rTqZKTL6cIZ4H6J/1wbUXc0klpacsy7hUtWtbrlErv8Oe9qQqGJRng=
X-Received: by 2002:a81:5309:0:b0:2e6:dcfc:8665 with SMTP id
 h9-20020a815309000000b002e6dcfc8665mr3622382ywb.501.1648194801467; Fri, 25
 Mar 2022 00:53:21 -0700 (PDT)
MIME-Version: 1.0
References: <CACGkMEvF80FuU0uD+RZMOrySQ0K2RZVh7Pmn4UhNtz_Exs3c2w@mail.gmail.com>
 <CACGkMEvLqox3QZxpxeQdrjBnM6zRr_wGfddoN45RUSsZEOe=bQ@mail.gmail.com>
 <20220321123420.3207-1-hdanton@sina.com> <CACGkMEt-PRCsBQ+EJVGeWGikJfLk-0M1dRPMqnp9YC5R4HYAjQ@mail.gmail.com>
 <20220324005345.3623-1-hdanton@sina.com> <20220324060419.3682-1-hdanton@sina.com>
 <20220324021428-mutt-send-email-mst@kernel.org> <20220324120217.3746-1-hdanton@sina.com>
 <DM8PR12MB54004034A8A5DA1D2B6EA8D1AB199@DM8PR12MB5400.namprd12.prod.outlook.com>
 <CACGkMEtVUqJcS1W2p1U9RCjQqQOSREu1J9zjmw37TbPBNqq7tA@mail.gmail.com> <20220325024324-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220325024324-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 25 Mar 2022 15:53:09 +0800
Message-ID: <CACGkMEvie2Zx9OnwOydguCiLMw71vKB1HmqX0uD9LuWPAakRRw@mail.gmail.com>
Subject: Re: [PATCH 1/2] vdpa: mlx5: prevent cvq work from hogging CPU
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Eli Cohen <elic@nvidia.com>, Hillf Danton <hdanton@sina.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2022 at 2:45 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Fri, Mar 25, 2022 at 11:22:25AM +0800, Jason Wang wrote:
> > On Thu, Mar 24, 2022 at 8:24 PM Eli Cohen <elic@nvidia.com> wrote:
> > >
> > >
> > >
> > > > -----Original Message-----
> > > > From: Hillf Danton <hdanton@sina.com>
> > > > Sent: Thursday, March 24, 2022 2:02 PM
> > > > To: Jason Wang <jasowang@redhat.com>
> > > > Cc: Eli Cohen <elic@nvidia.com>; Michael S. Tsirkin <mst@redhat.com>; virtualization <virtualization@lists.linux-foundation.org>; linux-
> > > > kernel <linux-kernel@vger.kernel.org>
> > > > Subject: Re: [PATCH 1/2] vdpa: mlx5: prevent cvq work from hogging CPU
> > > >
> > > > On Thu, 24 Mar 2022 16:20:34 +0800 Jason Wang wrote:
> > > > > On Thu, Mar 24, 2022 at 2:17 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > On Thu, Mar 24, 2022 at 02:04:19PM +0800, Hillf Danton wrote:
> > > > > > > On Thu, 24 Mar 2022 10:34:09 +0800 Jason Wang wrote:
> > > > > > > > On Thu, Mar 24, 2022 at 8:54 AM Hillf Danton <hdanton@sina.com> wrote:
> > > > > > > > >
> > > > > > > > > On Tue, 22 Mar 2022 09:59:14 +0800 Jason Wang wrote:
> > > > > > > > > >
> > > > > > > > > > Yes, there will be no "infinite" loop, but since the loop is triggered
> > > > > > > > > > by userspace. It looks to me it will delay the flush/drain of the
> > > > > > > > > > workqueue forever which is still suboptimal.
> > > > > > > > >
> > > > > > > > > Usually it is barely possible to shoot two birds using a stone.
> > > > > > > > >
> > > > > > > > > Given the "forever", I am inclined to not running faster, hehe, though
> > > > > > > > > another cobble is to add another line in the loop checking if mvdev is
> > > > > > > > > unregistered, and for example make mvdev->cvq unready before destroying
> > > > > > > > > workqueue.
> > > > > > > > >
> > > > > > > > > static void mlx5_vdpa_dev_del(struct vdpa_mgmt_dev *v_mdev, struct vdpa_device *dev)
> > > > > > > > > {
> > > > > > > > >         struct mlx5_vdpa_mgmtdev *mgtdev = container_of(v_mdev, struct mlx5_vdpa_mgmtdev, mgtdev);
> > > > > > > > >         struct mlx5_vdpa_dev *mvdev = to_mvdev(dev);
> > > > > > > > >         struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> > > > > > > > >
> > > > > > > > >         mlx5_notifier_unregister(mvdev->mdev, &ndev->nb);
> > > > > > > > >         destroy_workqueue(mvdev->wq);
> > > > > > > > >         _vdpa_unregister_device(dev);
> > > > > > > > >         mgtdev->ndev = NULL;
> > > > > > > > > }
> > > > > > > > >
> > > > > > > >
> > > > > > > > Yes, so we had
> > > > > > > >
> > > > > > > > 1) using a quota for re-requeue
> > > > > > > > 2) using something like
> > > > > > > >
> > > > > > > > while (READ_ONCE(cvq->ready)) {
> > > > > > > >         ...
> > > > > > > >         cond_resched();
> > > > > > > > }
> > > > > > > >
> > > > > > > > There should not be too much difference except we need to use
> > > > > > > > cancel_work_sync() instead of flush_work for 1).
> > > > > > > >
> > > > > > > > I would keep the code as is but if you stick I can change.
> > > > > > >
> > > > > > > No Sir I would not - I am simply not a fan of work requeue.
> > > > > > >
> > > > > > > Hillf
> > > > > >
> > > > > > I think I agree - requeue adds latency spikes under heavy load -
> > > > > > unfortunately, not measured by netperf but still important
> > > > > > for latency sensitive workloads. Checking a flag is cheaper.
> > > > >
> > > > > Just spot another possible issue.
> > > > >
> > > > > The workqueue will be used by another work to update the carrier
> > > > > (event_handler()). Using cond_resched() may still have unfair issue
> > > > > which blocks the carrier update for infinite time,
> > > >
> > > > Then would you please specify the reason why mvdev->wq is single
> > > > threaded?
> >
> > I didn't see a reason why it needs to be a single threaded (ordered).
> >
> > > Given requeue, the serialization of the two works is not
> > > > strong. Otherwise unbound WQ that can process works in parallel is
> > > > a cure to the unfairness above.
> >
> > Yes, and we probably don't want a per device workqueue but a per
> > module one. Or simply use the system_wq one.
> >
> > > >
> > >
> > > I think the proposed patch can still be used with quota equal to one.
> > > That would guarantee fairness.
> > > This is not performance critical and a single workqueue should be enough.
> >
> > Yes, but both Hillf and Michael don't like requeuing. So my plan is
> >
> > 1) send patch 2 first since it's a hard requirement for the next RHEL release
> > 2) a series to fix this hogging issue by
> > 2.1) switch to use a per module workqueue
> > 2.2) READ_ONCE(cvq->ready) + cond_resched()
> >
> > Thanks
>
> Actually if we don't care about speed here then requeing with quota of 1
> is fine, in that we don't have a quota at all, we just always requeue
> instead of a loop.
>
> It's the mix of requeue and a loop that I consider confusing.

Ok, Hillf, does this make sense for you? We want the issue to be fixed
soon, it's near to our product release.

Thanks

>
>
> > >
> > > > Thanks
> > > > Hillf
> > >
>

