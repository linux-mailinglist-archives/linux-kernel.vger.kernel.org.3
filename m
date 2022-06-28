Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DEB055D3C5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343722AbiF1Hzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 03:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343681AbiF1Hzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 03:55:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BE9991573B
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 00:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656402946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2J9+fR6giAYvAQr6KvneSIDgHdSrKwsAVjfZobXjNJY=;
        b=cwJNMJaJhTDQYtxIdBF0jT49kjBT9MLAccxQp5rXaMe8oWQkvXOvm38W3voIntOrJgxj8T
        mW8TWYsIlczaEjzWmKrCTB+0oC3BJH/9k40zjHImmNOzCGjS8weBQWGk9iNFgH51j6dLSv
        cfyv5xa58qZIxoNuOhD6vh2qDqqXuEQ=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-14-admeZMkPNaiw2ThK4DaZ9Q-1; Tue, 28 Jun 2022 03:55:41 -0400
X-MC-Unique: admeZMkPNaiw2ThK4DaZ9Q-1
Received: by mail-lf1-f72.google.com with SMTP id f29-20020a19dc5d000000b004811c8d1918so2218126lfj.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 00:55:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2J9+fR6giAYvAQr6KvneSIDgHdSrKwsAVjfZobXjNJY=;
        b=484/YFYIkMr16j1VlEwDZpwvdldWWGr/93/AhNTFUVD5+wxNMJSdO0XCdZQoCv97nO
         V+p7GaXYqLBO0O4goTHvNgNdEjOVecsNkCtKfay2hDuQsd99LoW3juMzsWuKJU8kqlkx
         rohDuCrtexL8NvUNvG8tnn0qex3RVS1bu7fyF8m5QVdRr7H5uP2E4uWWOslPCa9i7vGj
         O1j7irCuXY1XkbNjNwWuoNCh+Tb/X4sM1Vv6VD9eKfhu2q6nHTSfJe0Z7/5fH59v+941
         /A+K2TruceBMvBW/Yx8fqGWoOCJHjTqe9pEjliVWxsGEmUiB3u3lh+fWkZtcxbL8iEEI
         ygIQ==
X-Gm-Message-State: AJIora8oGqi7rmAgt0Rw7ODaeDbAHP1vahT+p3quIhfonx2O6fN0VKuu
        uTxa/v0w4OHFnpq8S46HOE/kpfjcmlfidBUytXHPMveg6q9L1azAPxJtqw0zQ7FaG+tX10031bt
        T+eFxK6n9PyoddlfAaYIsFTXPBEZt3p84O3IRUUJi
X-Received: by 2002:a05:6512:128a:b0:47f:b6df:6177 with SMTP id u10-20020a056512128a00b0047fb6df6177mr11027127lfs.176.1656402939940;
        Tue, 28 Jun 2022 00:55:39 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sOuMD5bahhMgNky8humPco5ZAjUxZJfBwy9JtBBHeOLXjJVdIEBsJC0hrwdKN3Ctf/mLPqcvAazE+dAjtmIIw=
X-Received: by 2002:a05:6512:128a:b0:47f:b6df:6177 with SMTP id
 u10-20020a056512128a00b0047fb6df6177mr11027117lfs.176.1656402939721; Tue, 28
 Jun 2022 00:55:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220621160859.196646-1-sgarzare@redhat.com> <20220621160859.196646-3-sgarzare@redhat.com>
 <CACGkMEsk-O=dVwKoEHRY-nL3XEQktPWiBot2NfOUYNdkoL-s=Q@mail.gmail.com>
 <20220623085830.voi6gixpikz64nm2@sgarzare-redhat> <CACGkMEvH-LFW3dvcaKNSmKyFG_SeBbTrPKtJOCwJHKMdtormJw@mail.gmail.com>
In-Reply-To: <CACGkMEvH-LFW3dvcaKNSmKyFG_SeBbTrPKtJOCwJHKMdtormJw@mail.gmail.com>
From:   Stefano Garzarella <sgarzare@redhat.com>
Date:   Tue, 28 Jun 2022 09:55:27 +0200
Message-ID: <CAGxU2F5uv2gMPp6Mfc_yxytMpbPwPdcfJ=NhazoJQkR3WNjUAQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] vdpa_sim_blk: limit the number of request handled per batch
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 6:01 AM Jason Wang <jasowang@redhat.com> wrote:
>
> On Thu, Jun 23, 2022 at 4:58 PM Stefano Garzarella <sgarzare@redhat.com> =
wrote:
> >
> > On Thu, Jun 23, 2022 at 11:50:22AM +0800, Jason Wang wrote:
> > >On Wed, Jun 22, 2022 at 12:09 AM Stefano Garzarella <sgarzare@redhat.c=
om> wrote:
> > >>
> > >> Limit the number of requests (4 per queue as for vdpa_sim_net) handl=
ed
> > >> in a batch to prevent the worker from using the CPU for too long.
> > >>
> > >> Suggested-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > >> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > >> ---
> > >>  drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 15 ++++++++++++++-
> > >>  1 file changed, 14 insertions(+), 1 deletion(-)
> > >>
> > >> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdp=
a_sim/vdpa_sim_blk.c
> > >> index a83a5c76f620..ac86478845b6 100644
> > >> --- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> > >> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> > >> @@ -197,6 +197,7 @@ static bool vdpasim_blk_handle_req(struct vdpasi=
m *vdpasim,
> > >>  static void vdpasim_blk_work(struct work_struct *work)
> > >>  {
> > >>         struct vdpasim *vdpasim =3D container_of(work, struct vdpasi=
m, work);
> > >> +       bool reschedule =3D false;
> > >>         int i;
> > >>
> > >>         spin_lock(&vdpasim->lock);
> > >> @@ -206,11 +207,15 @@ static void vdpasim_blk_work(struct work_struc=
t *work)
> > >>
> > >>         for (i =3D 0; i < VDPASIM_BLK_VQ_NUM; i++) {
> > >>                 struct vdpasim_virtqueue *vq =3D &vdpasim->vqs[i];
> > >> +               bool vq_work =3D true;
> > >> +               int reqs =3D 0;
> > >>
> > >>                 if (!vq->ready)
> > >>                         continue;
> > >>
> > >> -               while (vdpasim_blk_handle_req(vdpasim, vq)) {
> > >> +               while (vq_work) {
> > >> +                       vq_work =3D vdpasim_blk_handle_req(vdpasim, =
vq);
> > >> +
> > >
> > >Is it better to check and exit the loop early here?
> >
> > Maybe, but I'm not sure.
> >
> > In vdpa_sim_net we call vringh_complete_iotlb() and send notification
> > also in the error path,
>
> Looks not?
>
>                 read =3D vringh_iov_pull_iotlb(&cvq->vring, &cvq->in_iov,=
 &ctrl,
>                                              sizeof(ctrl));
>                 if (read !=3D sizeof(ctrl))
>                         break;
>
> We break the loop.

I was looking at vdpasim_net_work(), but I was confused since it
handles 2 queues.

I'll break the loop as it was before.

Thanks,
Stefano

