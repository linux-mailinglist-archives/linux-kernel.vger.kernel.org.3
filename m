Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7C4D51BA54
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 10:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239094AbiEEIbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 04:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348503AbiEEIat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 04:30:49 -0400
X-Greylist: delayed 722 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 05 May 2022 01:26:38 PDT
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.133.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D055F47542
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 01:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651739197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D4khpquWbWDinwLydzdoBq7iTp7d5c7LdROC1DapmkY=;
        b=F7ANKeZhYTFCn9vuCPs77UnGMV15X8TkF2PTCP9iY+y6FwAMHdVbeT5mNfeJ6Io3QWZDhK
        YAA12uqWFCio7HlVHdfdAIy3FpZEnQQUC72x4x1EDLuxsdNCpE+DI+jFDu6UMx7NyZUqCE
        84jYpU1gKwcBc9SSP3X6z4Q1tHtljiA=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-478-_bHDs07cNI6MaAzHxBQHJA-1; Thu, 05 May 2022 04:26:36 -0400
X-MC-Unique: _bHDs07cNI6MaAzHxBQHJA-1
Received: by mail-lj1-f197.google.com with SMTP id l26-20020a2e99da000000b0024f02d881cdso1166635ljj.6
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 01:26:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D4khpquWbWDinwLydzdoBq7iTp7d5c7LdROC1DapmkY=;
        b=2dxeIdzqWC4EIDNnsxDP21TAHv81D4ZAcJkFLQKpmcac7ui6JWKVaAqCuwBeiSZgQU
         hhnVwCTKRcUPNPIROMrC4nUYlxiv/BHgWBpbNM24R1AfKPRdytCmC8xo1r+zndQbXlLs
         LtNJW+kOWulNhzhQDiHNFPK68W2Y1HRuf31a9HelLp10q/JcleaPm/0KtMk08AH4IDRi
         Cg5CA5JwGTONxgn9Vwgy0J4VJKdkDNgTvZM4UZUv8UNnJZfauwASjLZP8NxLm26ELa3X
         hqx5urx2T1dUkECyTOQKOtnaT49MzZwAEDijF5KR/ksxxaGM+2FMNKV+1jKl+MCKN4ec
         mdCw==
X-Gm-Message-State: AOAM530sfn0Zc10NJduHJQqY0fz5HFq4I0L9EvMpybrc3+N1pzJUQ5J/
        2BsbFBYFDN5GtnyExbS3Wdpty8dyGggC8NxP6n3dzO+aLcArI7IWD77heYwYVseSDjPQx5pu6CP
        13vME3ZTz+ja1cuChc/lKiS7ymQjluPFilsP48jFY
X-Received: by 2002:a05:651c:89:b0:250:87c9:d4e6 with SMTP id 9-20020a05651c008900b0025087c9d4e6mr3555621ljq.315.1651739195209;
        Thu, 05 May 2022 01:26:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy7HKKTnzyyxPinHgFaLyss8uhrt+DE2y5rFIlDdSpVp6DDy/oL0ZdnSp0p5EW5xDRCrqgMH0ZIGECCwSKK7Qc=
X-Received: by 2002:a05:651c:89:b0:250:87c9:d4e6 with SMTP id
 9-20020a05651c008900b0025087c9d4e6mr3555612ljq.315.1651739195003; Thu, 05 May
 2022 01:26:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220428151242.213824-1-sgarzare@redhat.com> <CACGkMEv=0VWh_NxhvM+6_TRHEx0f2RGRWbR1n5RhKfq0a7xJUw@mail.gmail.com>
 <20220429071449.pycbkk2dvvxmtvay@sgarzare-redhat>
In-Reply-To: <20220429071449.pycbkk2dvvxmtvay@sgarzare-redhat>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 5 May 2022 16:26:24 +0800
Message-ID: <CACGkMEtRwRb_jUdCcdrx77=O4bnRGssQ5z_81KJi1hEKdbMcCQ@mail.gmail.com>
Subject: Re: [PATCH] vdpa_sim_blk: add support for VIRTIO_BLK_T_FLUSH
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 3:14 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> On Fri, Apr 29, 2022 at 10:46:40AM +0800, Jason Wang wrote:
> >On Thu, Apr 28, 2022 at 11:13 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
> >>
> >> The simulator behaves like a ramdisk, so we don't have to do
> >> anything when a VIRTIO_BLK_T_FLUSH request is received, but it
> >> could be useful to test driver behavior.
> >>
> >> Let's expose the VIRTIO_BLK_F_FLUSH feature to inform the driver
> >> that we support the flush command.
> >>
> >> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> >> ---
> >>  drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 12 ++++++++++++
> >>  1 file changed, 12 insertions(+)
> >>
> >> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> >> index 42d401d43911..a6dd1233797c 100644
> >> --- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> >> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> >> @@ -25,6 +25,7 @@
> >>  #define DRV_LICENSE  "GPL v2"
> >>
> >>  #define VDPASIM_BLK_FEATURES   (VDPASIM_FEATURES | \
> >> +                                (1ULL << VIRTIO_BLK_F_FLUSH)    | \
> >>                                  (1ULL << VIRTIO_BLK_F_SIZE_MAX) | \
> >>                                  (1ULL << VIRTIO_BLK_F_SEG_MAX)  | \
> >>                                  (1ULL << VIRTIO_BLK_F_BLK_SIZE) | \
> >> @@ -166,6 +167,17 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
> >>                 pushed += bytes;
> >>                 break;
> >>
> >> +       case VIRTIO_BLK_T_FLUSH:
> >> +               if (sector != 0) {
> >> +                       dev_err(&vdpasim->vdpa.dev,
> >> +                               "A driver MUST set sector to 0 for a VIRTIO_BLK_T_FLUSH request - sector: 0x%llx\n",
> >> +                               sector);
> >
> >If this is something that could be triggered by userspace/guest, then
> >we should avoid this.
>
> It can only be triggered by an erratic driver.

Right, so guest can try to DOS the host via this.

>
> I was using the simulator to test a virtio-blk driver that I'm writing
> in userspace and I forgot to set `sector` to zero, so I thought it would
> be useful.
>
> Do you mean to remove the error message?

Some like dev_warn_once() might be better here.

Thanks

>
> Thanks,
> Stefano
>

