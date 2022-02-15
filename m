Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 914494B64B6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 08:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234932AbiBOHsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 02:48:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233788AbiBOHsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 02:48:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8205E90FD6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 23:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644911299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S8TBMpDANby8RmP/LFmogH2MgUB/cxamBFb1C+IRX38=;
        b=ECuQ6+fOI9cxDx2lbpHPd7IssXXnXTleML4APLvpxkd1NPE2a7g80F7XxuLreRP8/e1Ms1
        i+bIWWd8HExn8woJfVtsKhECpnjD5p4+NDgl70tTMnr2PsOSeUgwPom9a8ULQuLbggmfjf
        Uojw6to24vt1wpGHwWV6vbC0YxQxhHI=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-358-sn8W8v1RPb--Q_myZm7b5w-1; Tue, 15 Feb 2022 02:48:17 -0500
X-MC-Unique: sn8W8v1RPb--Q_myZm7b5w-1
Received: by mail-lf1-f70.google.com with SMTP id z24-20020a056512371800b0043ea4caa07cso5948162lfr.17
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 23:48:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S8TBMpDANby8RmP/LFmogH2MgUB/cxamBFb1C+IRX38=;
        b=Ns3lQDwOO5E+UzOaNhIPZSscLT6OUnIN1E0Ct6csy8NgWLnvmq47ldUXmjFzfL4uOK
         tT63chxyK5XQx9n+lZz3BYyDk1Ezp56fEZiQoyZAjD5p++LDNUm6VJz2naEI0U4kn5RQ
         Q+tNg3fyX+OXFH7MjCRAirUlUsKa7cOgEqdYtFamF0O5tpFcK8w02oqGs1EmaQExVOdS
         hEZioQB6yMfCURFmKP1t/S9J4q4Jn3Gi9RleR9RPirZZ4xZC4zkPSRjzF5GrzXj9G9h6
         9dxUmfj/ZQmWQXO9JAELQSbYS9j9VZFSZav0xazYDBqVX8WubtPr3GYx2r2OfjxFD/AQ
         SUsA==
X-Gm-Message-State: AOAM530JOuvQpHo7PCMqUjyHhMKaCD1dUo7+qM5V5G3G048o9WYVAB9i
        Nm93QMnMyHwORANmKJ2D1sMzKVcK9h+a9jwqTGjahrjujv61VZPINMSkAcFf7wbEpGDHROueL6S
        6D1ZxNHn3vrtpPc9ycRQK3dbsvXCg+m/w2zrw1Y9u
X-Received: by 2002:ac2:4437:: with SMTP id w23mr2253846lfl.481.1644911296355;
        Mon, 14 Feb 2022 23:48:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzrPGSBjibGvDtlM9Z1Jt9MP9dvUIJlBBoHq0xmqexyKC5if7aafgy71D/1u2QPpo0U8LGebpqeueCGo0+ygO8=
X-Received: by 2002:ac2:4437:: with SMTP id w23mr2253833lfl.481.1644911296148;
 Mon, 14 Feb 2022 23:48:16 -0800 (PST)
MIME-Version: 1.0
References: <20220215053430.24650-1-gdawar@xilinx.com>
In-Reply-To: <20220215053430.24650-1-gdawar@xilinx.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 15 Feb 2022 15:48:04 +0800
Message-ID: <CACGkMEs7UEFM=ospckg0-LMw92wj74D_NLPsZy6oSY=dio9V-w@mail.gmail.com>
Subject: Re: [PATCH] Add definition of VIRTIO_F_IN_ORDER feature bit
To:     Gautam Dawar <gautam.dawar@xilinx.com>
Cc:     Martin Petrus Hubertus Habets <martinh@xilinx.com>,
        Harpreet Singh Anand <hanand@xilinx.com>, pabloc@xilinx.com,
        Gautam Dawar <gdawar@xilinx.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 1:34 PM Gautam Dawar <gautam.dawar@xilinx.com> wrote:
>
> This patch adds the definition of VIRTIO_F_IN_ORDER feature bit
> in the relevant header file to make it available in QEMU's
> linux standard header file virtio_config.h, which is updated using
> scripts/update-linux-headers.sh
>
> Signed-off-by: Gautam Dawar <gdawar@xilinx.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  include/uapi/linux/virtio_config.h | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linux/virtio_config.h
> index b5eda06f0d57..f0fb0ae021c0 100644
> --- a/include/uapi/linux/virtio_config.h
> +++ b/include/uapi/linux/virtio_config.h
> @@ -82,6 +82,12 @@
>  /* This feature indicates support for the packed virtqueue layout. */
>  #define VIRTIO_F_RING_PACKED           34
>
> +/*
> + * Inorder feature indicates that all buffers are used by the device
> + * in the same order in which they have been made available.
> + */
> +#define VIRTIO_F_IN_ORDER              35
> +
>  /*
>   * This feature indicates that memory accesses by the driver and the
>   * device are ordered in a way described by the platform.
> --
> 2.30.1
>

