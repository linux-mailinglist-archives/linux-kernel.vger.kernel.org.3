Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B470C52D37D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 15:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238417AbiESNFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 09:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238401AbiESNFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 09:05:15 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34FFA67D2D
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 06:05:13 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id gi33so1345430ejc.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 06:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=G6YuboORwpMKH3kgsyEnDpX5q6QVLrgo6p9d80QaHps=;
        b=YYNlshkULZlPppbaPR9vg+3EosYT54w3fmA/4GYTKYu9YiGQqfWQ7gED6aDJlEqzFs
         Og/0BsuIk9qG4mm9Vo+XjvvQU+gFRVxnL8uCtLTBZ9jRBSV2UqIlDbSG7dcLfEmqUK/Q
         b3fHfRY6zuCp1MZEM3Av1VGeSKj7DqF0v/BT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=G6YuboORwpMKH3kgsyEnDpX5q6QVLrgo6p9d80QaHps=;
        b=KKujMPnoV0U38TScHLBWip8ZJ6gDS6QkQ6zn+2Ws139dW483ffbVN6fe3XI0xmpKoY
         ZM/cVptjzvtdBc2I1DzMidqBWm93N/3C0shx0ifmP07FWuLp0mpn3SS7h0skmprVo8WL
         tDd0ivUknktYolGwFdWhPNAVH+42orl2VIkjMltI9zLBPVbux28N2b8uAyaxF7LtJNRF
         dtftbMMxgTCmIVLb/HeChznmXAX5M4JqWdnBYL6eiP/K1hGnrN9xaeouZe14DeH2gWPJ
         wnJByP3nLurcmSEQsD3oTeNJwvxZHB3MiawwdgrAeLHBBUJAudLKx3+KV+6lfWSQJ9GI
         +bgQ==
X-Gm-Message-State: AOAM531qdq3V37Vw05TJElUzhjjjxsqK+wqhH5ti0SYVxzlbx6zQeQqR
        yN+3/nQhvTvSmz1YuW+K/htEcw==
X-Google-Smtp-Source: ABdhPJzEbbvboVV6lCCTbtSCbKLorkhNmi/F8uRJ5SFn7MGR8V3og7YUFHGx7AMrXTaC53/nWkWm8A==
X-Received: by 2002:a17:906:c113:b0:6f8:faee:2f22 with SMTP id do19-20020a170906c11300b006f8faee2f22mr4145202ejc.447.1652965511208;
        Thu, 19 May 2022 06:05:11 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id c62-20020a509fc4000000b0042aae3f282esm2842868edf.65.2022.05.19.06.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 06:05:10 -0700 (PDT)
Date:   Thu, 19 May 2022 15:05:08 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 04/11] drm/r128: Fix undefined behavior due to shift
 overflowing the constant
Message-ID: <YoZAhPj0IJmE8ss8@phenom.ffwll.local>
Mail-Followup-To: Randy Dunlap <rdunlap@infradead.org>,
        Borislav Petkov <bp@alien8.de>, LKML <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Alex Deucher <alexander.deucher@amd.com>,
        dri-devel@lists.freedesktop.org
References: <20220405151517.29753-1-bp@alien8.de>
 <20220405151517.29753-5-bp@alien8.de>
 <04ff7802-c87a-2ea2-156e-c437446bc072@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <04ff7802-c87a-2ea2-156e-c437446bc072@infradead.org>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 11:46:53AM -0700, Randy Dunlap wrote:
> 
> 
> On 4/5/22 08:15, Borislav Petkov wrote:
> > From: Borislav Petkov <bp@suse.de>
> > 
> > Fix:
> > 
> >   drivers/gpu/drm/r128/r128_cce.c: In function ‘r128_do_init_cce’:
> >   drivers/gpu/drm/r128/r128_cce.c:417:2: error: case label does not reduce to an integer constant
> >     case R128_PM4_64BM_64VCBM_64INDBM:
> >     ^~~~
> >   drivers/gpu/drm/r128/r128_cce.c:418:2: error: case label does not reduce to an integer constant
> >     case R128_PM4_64PIO_64VCPIO_64INDPIO:
> >     ^~~~
> > 
> > See https://lore.kernel.org/r/YkwQ6%2BtIH8GQpuct@zn.tnic for the gory
> > details as to why it triggers with older gccs only.
> > 
> > Signed-off-by: Borislav Petkov <bp@suse.de>
> > Cc: David Airlie <airlied@linux.ie>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: dri-devel@lists.freedesktop.org
> 
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Pushed to drm-misc-next, thanks for patch&review.
-Daniel

> 
> Thanks.
> 
> > ---
> >  drivers/gpu/drm/r128/r128_drv.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/r128/r128_drv.h b/drivers/gpu/drm/r128/r128_drv.h
> > index 2e1bc01aa5c9..970e192b0d51 100644
> > --- a/drivers/gpu/drm/r128/r128_drv.h
> > +++ b/drivers/gpu/drm/r128/r128_drv.h
> > @@ -300,8 +300,8 @@ extern long r128_compat_ioctl(struct file *filp, unsigned int cmd,
> >  #	define R128_PM4_64PIO_128INDBM		(5  << 28)
> >  #	define R128_PM4_64BM_128INDBM		(6  << 28)
> >  #	define R128_PM4_64PIO_64VCBM_64INDBM	(7  << 28)
> > -#	define R128_PM4_64BM_64VCBM_64INDBM	(8  << 28)
> > -#	define R128_PM4_64PIO_64VCPIO_64INDPIO	(15 << 28)
> > +#	define R128_PM4_64BM_64VCBM_64INDBM	(8U  << 28)
> > +#	define R128_PM4_64PIO_64VCPIO_64INDPIO	(15U << 28)
> >  #	define R128_PM4_BUFFER_CNTL_NOUPDATE	(1  << 27)
> >  
> >  #define R128_PM4_BUFFER_WM_CNTL		0x0708
> 
> -- 
> ~Randy

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
