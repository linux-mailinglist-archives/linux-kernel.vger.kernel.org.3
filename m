Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 345674E207B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 07:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344539AbiCUGM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 02:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231917AbiCUGM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 02:12:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 822896541F
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 23:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647843061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=odBINnMgIi0tgmQ8mhF4tk+Kj1bfTM5xyu8TMVAPo04=;
        b=EEa2t43UlJJwmSsqsZPJE2aNesaVAZPow2LY+joXafBkOtZ2RLoe8r1yrCbYjOd875o2Pi
        nvSww03Olxmz9HCR1z1Hhw2kk+RcEli2HdINtfzzZcO4iheI9QQ9wQfY6zTw01RiaAI+Hc
        DhOdk+BiRoa3/YpSqtwg0rmaM3s4G2g=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-203-8Rpv0O3JNTWTMYHGWZ1nZQ-1; Mon, 21 Mar 2022 02:10:59 -0400
X-MC-Unique: 8Rpv0O3JNTWTMYHGWZ1nZQ-1
Received: by mail-pj1-f71.google.com with SMTP id om8-20020a17090b3a8800b001c68e7ccd5fso6070245pjb.9
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 23:10:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=odBINnMgIi0tgmQ8mhF4tk+Kj1bfTM5xyu8TMVAPo04=;
        b=klEzQ1HhQwQiRP4XpYJZY1WmVVHMkvmrXQ9wFr0w73dM2gBQdlYuFaS4afpbR31IBG
         i75MAGOYr2KqQlLsB3x+MA23nC6wjkAn3rXywFvHmhiyhymIhB+fdzD5uSNS9yPcSmhg
         TGwiU9LEYFYcowsIhXuv5O6KuiCfWe/6rsMu7IHAEa8nDnwBuLq0BOEBFwyEJ8p9x+QK
         XA00rh81H5EfBVNUHn9NzLvEw7zp/2tCSFU7oGZeE9y+YEHhfyxHezfrm/QEWk3VWDYr
         na8iusebyIX7MU4Na1DGKEWnR54Tgx2qrwy89pV3DucBO/LCNR51dF4rq6kte6Gerz9s
         LdMg==
X-Gm-Message-State: AOAM530GFMc1WHft1ytZ4FGrcMqWFtwNX/n7ZZbTcDVDnh1hn/KLuaoG
        cArGQ/72pnRy+YLqH/FhVBSgD5Q/UFev6idNQN7XutQ3tcfFsCvP321QxoNv91i8ddurf6IJWW0
        khnqk/sJ0FXHQyJEsU4bcPjVw
X-Received: by 2002:a17:903:3014:b0:153:a200:fb5 with SMTP id o20-20020a170903301400b00153a2000fb5mr11234657pla.25.1647843058486;
        Sun, 20 Mar 2022 23:10:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy4nBZxz0/jlFlP6K79zZR1DPic/SPTE+MsIPT9iiUjWK0KlRkg2Czy6k20MK9pMR111MHYeg==
X-Received: by 2002:a17:903:3014:b0:153:a200:fb5 with SMTP id o20-20020a170903301400b00153a2000fb5mr11234637pla.25.1647843058174;
        Sun, 20 Mar 2022 23:10:58 -0700 (PDT)
Received: from xz-m1.local ([191.101.132.87])
        by smtp.gmail.com with ESMTPSA id m123-20020a633f81000000b0038256b22e74sm4753853pga.82.2022.03.20.23.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 23:10:57 -0700 (PDT)
Date:   Mon, 21 Mar 2022 14:10:52 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Ian Abbott <abbotti@mev.co.uk>
Cc:     linux-man@vger.kernel.org,
        Alejandro Colomar <alx.manpages@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-kernel@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>
Subject: Re: [PATCH] ioctl_userfaultfd.2: Corrections for returned .ioctls
 members
Message-ID: <YjgW7L77+Y2fylcR@xz-m1.local>
References: <20220318191343.72812-1-abbotti@mev.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220318191343.72812-1-abbotti@mev.co.uk>
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2022 at 07:13:43PM +0000, Ian Abbott wrote:
> Support for the `UFFDIO_WRITEPROTECT` operation is not indicated in the
> `ioctls` member of `struct uffdio_api`.  It is indicated in the `ioctls`
> member of `struct uffdio_register` along with indications of support for
> the `UFFDIO_COPY`, `UFFDIO_WAKE` and `UFFDIO_ZEROPAGE` operations (and
> also the `UFFDIO_CONTINUE` operation supported since Linux 5.13 but
> that is not documented by this man page yet.)

I thought it should have landed but indeed it's not.  Copying Axel.

> 
> Fixes: f559fa36a678 ("ioctl_userfaultfd.2: Add write-protect mode docs")
> Signed-off-by: Ian Abbott <abbotti@mev.co.uk>

The patch looks correct to me, thanks for fixing it.

Acked-by: Peter Xu <peterx@redhat.com>

> ---
>  man2/ioctl_userfaultfd.2 | 27 ++++++++++++++++++++-------
>  1 file changed, 20 insertions(+), 7 deletions(-)
> 
> diff --git a/man2/ioctl_userfaultfd.2 b/man2/ioctl_userfaultfd.2
> index 504f61d4b..e930af520 100644
> --- a/man2/ioctl_userfaultfd.2
> +++ b/man2/ioctl_userfaultfd.2
> @@ -235,11 +235,6 @@ operation is supported.
>  The
>  .B UFFDIO_UNREGISTER
>  operation is supported.
> -.TP
> -.B 1 << _UFFDIO_WRITEPROTECT
> -The
> -.B UFFDIO_WRITEPROTECT
> -operation is supported.
>  .PP
>  This
>  .BR ioctl (2)
> @@ -333,8 +328,26 @@ If the operation is successful, the kernel modifies the
>  bit-mask field to indicate which
>  .BR ioctl (2)
>  operations are available for the specified range.
> -This returned bit mask is as for
> -.BR UFFDIO_API .
> +This returned bit mask can contain the following bits:
> +.TP
> +.B 1 << _UFFDIO_COPY
> +The
> +.B UFFDIO_COPY
> +operation is supported.
> +.TP
> +.B 1 << _UFFDIO_WAKE
> +The
> +.B UFFDIO_WAKE
> +operation is supported.
> +.TP
> +.B 1 << _UFFDIO_WRITEPROTECT
> +The
> +.B UFFDIO_WRITEPROTECT
> +.TP
> +.B 1 << _UFFDIO_ZEROPAGE
> +The
> +.B UFFDIO_ZEROPAGE
> +operation is supported.
>  .PP
>  This
>  .BR ioctl (2)
> -- 

-- 
Peter Xu

