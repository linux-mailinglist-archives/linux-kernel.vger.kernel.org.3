Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 768DB4E3BA7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 10:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232512AbiCVJWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 05:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbiCVJWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 05:22:00 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73CC5C87C
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 02:20:32 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id p184-20020a1c29c1000000b0037f76d8b484so913121wmp.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 02:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=inerobyH2rFNMzQ5I7IpYee5uYmz0cBqg6WUAP6/jiY=;
        b=gikU+l5IY0qXyIN/EqIpO8R4WaZ1bzQX0cxRrXUhrfSYIUL6ua+bVf4FeVQRBq6BSe
         ZVqSVSWazEwyUnnJjTHJOeuzAZD5dRPzngzFSAVhVD7B0YtFpFPp5oYZKvuCpXmUpm3p
         KcpRBLFEZqWMaqk4gBXRiHEsc7X2OE9kbc9tHRzZGABYF8TN4Unb72LLuMHDpwyQqy4c
         ohKqwL1Uivz3aD4URJyt9wG3rRGLsWM9fLZTVoCwi11T934FjHc9bsJjBWCvLNvDI6MZ
         b8zdA7M9gmQB+s6sD0173+vERNv7qDjcHGSjptAwPBRxl4PJLIwgQxGNveW+ULqx/aLm
         rkCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=inerobyH2rFNMzQ5I7IpYee5uYmz0cBqg6WUAP6/jiY=;
        b=h7VYwcGLyZQSuq4TvQawfUzFRKSHVk0ttH1uG6VQFtjJaB0mqFFO6n607onEY/q1wg
         GW6rGwliduBT0YgoVz27mCaClwB2qKq9y2PI9YO0PMGonIR/h048CA8UvcF1gT750DQe
         o7aTyE8ox0S/29l2WDSS2yFMUTzfOsTmobAXeN/Ny4uzW3RMBE3Ox3fLo4LaeR3YPpSZ
         bDFS43bXzRpBOZf1ZTdArQcqDFu//ubUeI1KVmHW8vG+GUbp+OECJynY6iGOJexWH1WK
         TsjLM7GP463Yi7kia2oh+RWIZnFbAeqRTh70LrYT+acNYwthI+8ij2/HcWdoW39S2iyN
         67zQ==
X-Gm-Message-State: AOAM533hX4G/eSFEualOmfEcJh03ugIBGhhhZjEAsKPwmSfRuHgmKMzS
        UjIzQAzKCqCj4URcZ8fav04ijA==
X-Google-Smtp-Source: ABdhPJxBBFns7JlEm2mp867pfKRBBYSWzNKP/wstQXE1+VVmTRItZU9QCaC7am+hekzjoWxBACXaRA==
X-Received: by 2002:a05:6000:1568:b0:203:fd87:e9c2 with SMTP id 8-20020a056000156800b00203fd87e9c2mr12681454wrz.395.1647940831279;
        Tue, 22 Mar 2022 02:20:31 -0700 (PDT)
Received: from google.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id g6-20020a5d5406000000b001f049726044sm15113078wrv.79.2022.03.22.02.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 02:20:30 -0700 (PDT)
Date:   Tue, 22 Mar 2022 09:20:27 +0000
From:   Keir Fraser <keirf@google.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] virtio: pci: Sanity check the bar index in find_shm_cap
Message-ID: <YjmU22PnTLEy58+V@google.com>
References: <20220321154931.859511-1-keirf@google.com>
 <CACGkMEuEh+vsDok6hrp96kgGHkxbmzskFMJOouR3mo3d3VjwdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEuEh+vsDok6hrp96kgGHkxbmzskFMJOouR3mo3d3VjwdQ@mail.gmail.com>
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

On Tue, Mar 22, 2022 at 11:36:23AM +0800, Jason Wang wrote:
> On Mon, Mar 21, 2022 at 11:49 PM Keir Fraser <keirf@google.com> wrote:
> >
> > The bar index is used as an index into the device's resource list
> > and should be checked as within range for a standard bar.
> >
> > Signed-off-by: Keir Fraser <keirf@google.com>
> 
> Patch looks good, do we need a similar check in vp_modern_map_capability()?

Yes it looks like we do. Would you like me to fix that also? If so: separate patch, or
revised version of this patch?

> Thanks
> 
> > ---
> >  drivers/virtio/virtio_pci_modern.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> > index 5455bc041fb6..84bace98dff5 100644
> > --- a/drivers/virtio/virtio_pci_modern.c
> > +++ b/drivers/virtio/virtio_pci_modern.c
> > @@ -293,7 +293,7 @@ static int virtio_pci_find_shm_cap(struct pci_dev *dev, u8 required_id,
> >
> >         for (pos = pci_find_capability(dev, PCI_CAP_ID_VNDR); pos > 0;
> >              pos = pci_find_next_capability(dev, pos, PCI_CAP_ID_VNDR)) {
> > -               u8 type, cap_len, id;
> > +               u8 type, cap_len, id, res_bar;
> >                 u32 tmp32;
> >                 u64 res_offset, res_length;
> >
> > @@ -317,7 +317,12 @@ static int virtio_pci_find_shm_cap(struct pci_dev *dev, u8 required_id,
> >
> >                 /* Type, and ID match, looks good */
> >                 pci_read_config_byte(dev, pos + offsetof(struct virtio_pci_cap,
> > -                                                        bar), bar);
> > +                                                        bar), &res_bar);
> > +               if (res_bar >= PCI_STD_NUM_BARS) {
> > +                       dev_err(&dev->dev, "%s: shm cap with bad bar: %d\n",
> > +                               __func__, res_bar);
> > +                       continue;
> > +               }
> >
> >                 /* Read the lower 32bit of length and offset */
> >                 pci_read_config_dword(dev, pos + offsetof(struct virtio_pci_cap,
> > @@ -337,6 +342,7 @@ static int virtio_pci_find_shm_cap(struct pci_dev *dev, u8 required_id,
> >                                                      length_hi), &tmp32);
> >                 res_length |= ((u64)tmp32) << 32;
> >
> > +               *bar = res_bar;
> >                 *offset = res_offset;
> >                 *len = res_length;
> >
> > --
> > 2.35.1.894.gb6a874cedc-goog
> >
> 
