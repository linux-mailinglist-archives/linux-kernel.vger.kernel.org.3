Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5845974BC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 19:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240791AbiHQRGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 13:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240735AbiHQRGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 13:06:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2495C98CAC
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 10:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660755957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GM7xEfwIL/rtVq+hrRvQ1hKtp4szoR86mfFhzUxnc2Q=;
        b=Qk6gFmwcztZi/pyhapHCDwe17a5LB9wwX3MeiW66I9bpAvv47mdA7aw8+RDHLZQS5BDhia
        A0UOWBJyKbAEYL1/yYv2KHyTzrs3IBEslSLNMGGIb+gEUfQWeuTW+PQjZnn84MXKF/DknD
        tFqzPnv4PtNaDFn97PRQMsSXELBkKI8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-518-HmK02LtVMFeV_etqxEXP4g-1; Wed, 17 Aug 2022 13:05:56 -0400
X-MC-Unique: HmK02LtVMFeV_etqxEXP4g-1
Received: by mail-wr1-f72.google.com with SMTP id r8-20020adfbb08000000b00225239ce4deso633603wrg.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 10:05:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=GM7xEfwIL/rtVq+hrRvQ1hKtp4szoR86mfFhzUxnc2Q=;
        b=CC31z4+DVMDL5p1ywuojMEnresavZWFXcBnz0OvN/fGrUdta1oUKTZ7lnCghAnRXAI
         RXHxs+DFpuwV3A955FXf/4tMe/ZdisTvqQpQiJrF0ybc91AxpvOImndqVfgNASnBfMF1
         8KS53X4mZdbVplj0jKd9dSsSOK11S7biTMr73U9f35JVbzdwLA1PevxxAKn5lDoQs+ob
         Coyft0h43icU3Zr3qpTqlXlrS9lWnq0WxLuQCzgq+220gmkWxBUrt1noSbuiq98DjHA6
         Of9xfXc89T8jl0IexAw7iq15KPcpwprpO9C/AZ825lLUX/+vu9/5wYKjCoy6WrDhm3Cv
         YE/w==
X-Gm-Message-State: ACgBeo19R8xDLZrYqGeQTE5ilPiFTXMMLz7WS4gtsfJIgRJ4IAOmNQJw
        flDLGOfiyhYeCUjptTtbgjxLpOHyYeoQrlATQSSbFyu/HNr75ofR6/gk3We12+u8rQP+MS41L0q
        st//MGS4dU+EzYPHqCbo8bl1j
X-Received: by 2002:a05:600c:4f4f:b0:3a5:a530:4fd7 with SMTP id m15-20020a05600c4f4f00b003a5a5304fd7mr2807118wmq.36.1660755955453;
        Wed, 17 Aug 2022 10:05:55 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7W0d2By6SxNehemYA/+2Tlkpn9sxMVpxE7j6tOqnVgLuFdYAz5FyA4g0pMz5pYYDOiSN6AMw==
X-Received: by 2002:a05:600c:4f4f:b0:3a5:a530:4fd7 with SMTP id m15-20020a05600c4f4f00b003a5a5304fd7mr2807106wmq.36.1660755955238;
        Wed, 17 Aug 2022 10:05:55 -0700 (PDT)
Received: from redhat.com ([2.55.43.215])
        by smtp.gmail.com with ESMTPSA id m9-20020a7bce09000000b003a3442f1229sm2645479wmc.29.2022.08.17.10.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 10:05:54 -0700 (PDT)
Date:   Wed, 17 Aug 2022 13:05:49 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Will Deacon <will@kernel.org>
Cc:     stefanha@redhat.com, jasowang@redhat.com,
        torvalds@linux-foundation.org, ascull@google.com, maz@kernel.org,
        keirf@google.com, jiyong@google.com, kernel-team@android.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        crosvm-dev@chromium.org
Subject: Re: IOTLB support for vhost/vsock breaks crosvm on Android
Message-ID: <20220817130510-mutt-send-email-mst@kernel.org>
References: <20220805181105.GA29848@willie-the-truck>
 <20220807042408-mutt-send-email-mst@kernel.org>
 <20220808101850.GA31984@willie-the-truck>
 <20220808083958-mutt-send-email-mst@kernel.org>
 <20220817134821.GA12615@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220817134821.GA12615@willie-the-truck>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 02:48:22PM +0100, Will Deacon wrote:
> On Mon, Aug 08, 2022 at 08:45:48AM -0400, Michael S. Tsirkin wrote:
> > > > Also yes, I think it's a good idea to change crosvm anyway.  While the
> > > > work around I describe might make sense upstream I don't think it's a
> > > > reasonable thing to do in stable kernels.
> > > > I think I'll prepare a patch documenting the legal vhost features
> > > > as a 1st step even though crosvm is rust so it's not importing
> > > > the header directly, right?
> > > 
> > > Documentation is a good idea regardless, so thanks for that. Even though
> > > crosvm has its own bindings for the vhost ioctl()s, the documentation
> > > can be reference or duplicated once it's available in the kernel headers.
> > > 
> > So for crosvm change, I will post the documentation change and
> > you guys can discuss?
> 
> FYI, the crosvm patch is merged here:
> 
> https://github.com/google/crosvm/commit/4e7d00be2e135b0a2d964320ea4276e5d896f426
> 
> Will

Great thanks a lot!
I'm on vacation next week but will work on it afterwards.

-- 
MST

