Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F062E4D3663
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 18:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236867AbiCIRTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 12:19:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237110AbiCIRTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 12:19:14 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90FE2BECC7
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 09:17:32 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id s11so2848812pfu.13
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 09:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WeI6/9C1BCTGBKT+PvqLfTEaKntfc/ed6405/bCzY/w=;
        b=WDfWjEYckw/zTayapSSYfsRn64vQBqxp7Z9KMMkfujfBKUpKOHI8XIHGLayFZN4H2b
         u0u1AgWKPSDhByMnD5ntwL4Zs0Q77Drden/IjHQYanPve8puiSrPE2dDhQNRe3eWpmpZ
         tRmPU7DNz9Taggr1RjPonwqTWgEnaruaVIYSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WeI6/9C1BCTGBKT+PvqLfTEaKntfc/ed6405/bCzY/w=;
        b=4Ke/8Gsnc+HkCF9y2SJ2aRBfmCCsiYKO9QCbo518XGKPEL6q6NCK16tVoU/624aDJO
         tsVxKyOSx9myUZ1l0XrrApgezwqm/He3wgHwBuTbD5VMHCSG1HnEhHrNKaJg7rH82S5O
         Alx6Jtxal3sBvwx8iSu1lNW7+aClOIIO/fWVxHRR32hCcwysVg8K4mZAh9jyFhTExrqz
         LpM3hX7gJ1K2BIY3br7Xgu4LHx9/raXQ84+W7sq/3CAeWEu1nSXkPI3Tz8hOs7XqQtn0
         RUT19pD/z/4Q6uzvIfMSLP106f89N4bASLFa+y6kV0RSf32l9sZ3RYcSH1PeZA41nd5x
         6+WQ==
X-Gm-Message-State: AOAM532meHUb5dotbaO0vrphhtV0/B+sV7pWIRIgfwayO179dotLyp6K
        7AUPTSqU9NWmNVdPZHVcGrTP3A==
X-Google-Smtp-Source: ABdhPJyXk5M0FslPX7mQv4MfQEiZWkG1072olU1PS3FqjAEjICXjju+odpKPfrx+08nAfrdTgndITQ==
X-Received: by 2002:a63:1554:0:b0:363:794c:9e31 with SMTP id 20-20020a631554000000b00363794c9e31mr628489pgv.66.1646846252021;
        Wed, 09 Mar 2022 09:17:32 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t6-20020a63b246000000b0038085c0a9d7sm2818271pgo.49.2022.03.09.09.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 09:17:31 -0800 (PST)
Date:   Wed, 9 Mar 2022 09:17:30 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-hardening@vger.kernel.org,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        PDL-MPT-FUSIONLINUX <MPT-FusionLinux.pdl@broadcom.com>
Subject: Re: [PATCH] scsi: mpt3sas: Convert to flexible arrays
Message-ID: <202203090913.ED0241BEC@keescook>
References: <20220201223948.1455637-1-keescook@chromium.org>
 <164462189850.7606.6908949862618145181.b4-ty@oracle.com>
 <CAK=zhgpQcJkRKVNFHy6mDqV9hOyzFsV_uqOWur8UsNLRZy-VdA@mail.gmail.com>
 <yq1ee3blsqp.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1ee3blsqp.fsf@ca-mkp.ca.oracle.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2022 at 10:20:28PM -0500, Martin K. Petersen wrote:
> 
> Sreekanth,
> 
> > I am observing below kernel panic when I load the driver with this
> > patch changes. After reverting this patch changes then the driver is
> > getting loaded successfully.
> 
> I am puzzled. The driver loads fine for me. I have verified that the
> generated object file is identical before and after Kees' patch.

I've double-checked this again myself; I don't see any binary
difference. Can you share your .config? I was using defconfig with
these added:

SCSI_LOWLEVEL=y
SCSI_MPT3SAS=y

-- 
Kees Cook
