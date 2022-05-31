Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C18538B7B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 08:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244320AbiEaGke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 02:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbiEaGk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 02:40:29 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A0712CDF5
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 23:40:28 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id u3so17241075wrg.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 23:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hWi8+sNMetrYMzLc34VlHt3OhXmn2b5I8FlnJI4POXE=;
        b=UFL9N9JhTYW/Wh36Zwj142mdG1eXYyqsPf0pCsMhKDQtPljFB78+hO04ngET8qF0X9
         wBE4eIGDlQomlKtwgY1OJ95nl9vGvsbherAOFGH4r6VmmAwv+HVQs5JtTVId3i/8nlVn
         uzJqH8fYXZkT4XdCAT1+PZWz4eeumQaG1JwQJYdDVNip8v2nnvbxBDMAMp+ezPITWU07
         2DLYCJSoyLsv7S+D6jM4CrHvzjhy4E0mf6lnuoFwHzvJ2JkT9vQr/kxPItKB1wdSF+HG
         GCsFGYGbgUzDThj+IjDCjYo0gTsUhSppwHgE3rEE1brg69vYSwfmw2NmbJMJ0iyaMyvV
         dIVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hWi8+sNMetrYMzLc34VlHt3OhXmn2b5I8FlnJI4POXE=;
        b=wJdM9DKTp6DDEQ52yVbS/NO1eqO7WzPbCEHP2+Vsdo/RYv26oVr2i5k/rcx26ZrB8H
         XGbp7zh/pdKcskbU0i35mOJK0tB6otY/3d+zHOLh7Mgf18tlfEzRR/sX1jg5RIqjWBB9
         aEcOkvwMI3qLPDk6c06Pg7qH9mWXls36b9wgrydyUqX+JaqyOMNv3J4YNTuIrqpMmw8Q
         l/i9BSPuBBWOZotQaXVyw7501Z8+NeyimIzq0SvKUGgNWuxGFqx3yEcZ7XdrPBR1DTRQ
         5LBfrH3v/NvOoLnY52O/zXl7UPDTIaRXDTZBDgFjGI7fwssWH7FQolTc2srs+NngjKSL
         wqZQ==
X-Gm-Message-State: AOAM532oSWCCzSaGx7JL2LVFgtXJTJcPkQ2ngLamE3owFm0Lo6PnmwO0
        m7yw/Iun+HAgguGD9N9TtCD8hpPQTFFSBSk7
X-Google-Smtp-Source: ABdhPJwMqIF0KI6J8fO9BDzZJ9VYbRVfEIjt23H4x15ky9FdtzN9fcbpJxoV7hzlDtt3RwVHgKaJIQ==
X-Received: by 2002:a5d:47a1:0:b0:20f:ecc4:7f6c with SMTP id 1-20020a5d47a1000000b0020fecc47f6cmr30560217wrb.236.1653979226621;
        Mon, 30 May 2022 23:40:26 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id l6-20020adff486000000b0020c5253d907sm10671844wro.83.2022.05.30.23.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 23:40:26 -0700 (PDT)
Date:   Tue, 31 May 2022 07:40:24 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v3 0/2] Fix some compile warnings in v5.18+
Message-ID: <YpW4WKxKIIgY0l7m@equinox>
References: <20220531013103.2175-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220531013103.2175-1-Larry.Finger@lwfinger.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2022 at 08:31:01PM -0500, Larry Finger wrote:
> Building driver r8188eu in staging with -warray-bounds exposes two places
> where arrays are too small.
> 
> Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
> ---
> v2 - get proper To and Cc
> v3 - Use Dan Carpenter's suggestion for correct patch.
> 
> Larry Finger (2):
>   staging: r8188eu: Fix undersized array in rtw_xmit.c
>   staging: r8188eu: Fix warning of array overflow in ioctl_linux.c
> 
>  drivers/staging/r8188eu/core/rtw_xmit.c      | 17 ++++-------------
>  drivers/staging/r8188eu/os_dep/ioctl_linux.c |  2 +-
>  2 files changed, 5 insertions(+), 14 deletions(-)
> 
> -- 
> 2.36.1
> 

Hi Larry,

Both patches look good to me, however I've already submitted a patch 10
days ago that does exactly what your rtw_xmit.c patch does, in
addition to fixing the changed error handling semantics for the relevant
function (in f94b47c6bde6) which broke the driver.

Regards,
Phil
