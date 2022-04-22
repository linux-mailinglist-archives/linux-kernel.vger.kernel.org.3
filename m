Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E34C50BF3F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 20:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234455AbiDVSBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 14:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234598AbiDVR6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 13:58:45 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E331DC0E64
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 10:55:50 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id q3so12470981plg.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 10:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zkV/KkmvPXk9nBt/BfjOyF4XLkm4qQ9lxtBnEnf4+f0=;
        b=hIpdI6m7KYiT+YLhMOXs/GeJmagRHZC7P6KFsC2ZbbMvZ7uIXs9n5/gbdbDPAJO1By
         8nljEr3QV2ZLyyVN6oYfzPIEBmfGC3nYpfLqRMeYB9ZFBmnLs0aS9vA/joaQ34uueM3z
         kKbi7OvoEioSopjHQMfLmIyewYgPgKvBM0tAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zkV/KkmvPXk9nBt/BfjOyF4XLkm4qQ9lxtBnEnf4+f0=;
        b=z7KCT2kdgdXWlTo3g91vgZwKd0LANFHeFodfxhrXKT87XiLCxosOI5EHJShpR3jBWl
         6jkMauEHVGPYd3KwjiqpqKhCiEi83zrUVZFFvvcxfWso6viHrrKrrItdO7RRYnCQB/4s
         ezlakk35zwS8xiTVmPdxawmSvN4vteknLf7LDsP7pkZ9QcC0OZ9ZTc0Pt3aEz1xfKbu7
         FfjIKO+L7ARUrv6zWorkfepvoi8hSnrCIp4L+Lb+CYod79QI6PRdLDjzLOgY3I3TxYf3
         xxeJj7aFdNRcmgPVeDSsVJ4Nzo99Hj3DbNqU5SkeGVWi1vYDANmFPQ6VCRh7D7V+pjpB
         pg9Q==
X-Gm-Message-State: AOAM531xAVG95GqiEwN3KMV4UFak56gTIpivL8MKsu+ey9X/OqGpAo3Y
        nszGiLxu7yVQJ50lSK4Kkw62BQ==
X-Google-Smtp-Source: ABdhPJzioSF24BZDx+BvJ1ATXa2ju3lBpsYKRtrbjIfPcjtPvPgIzsmYuZa9dbnJM8onG7hozWRd4g==
X-Received: by 2002:a17:90a:58f:b0:1ca:7a28:273f with SMTP id i15-20020a17090a058f00b001ca7a28273fmr6698824pji.62.1650650050404;
        Fri, 22 Apr 2022 10:54:10 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c5-20020a62f845000000b0050ceac49c1dsm3194395pfm.125.2022.04.22.10.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 10:54:09 -0700 (PDT)
Date:   Fri, 22 Apr 2022 10:54:09 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] s390: disable -Warray-bounds
Message-ID: <202204221052.85D0C427@keescook>
References: <20220422134308.1613610-1-svens@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422134308.1613610-1-svens@linux.ibm.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 03:43:08PM +0200, Sven Schnelle wrote:
> gcc-12 shows a lot of array bound warnings on s390. This is caused
> by our S390_lowcore macro:
> 
> which uses an hardcoded address of 0. Wrapping that with
> absolute_pointer() works, but gcc no longer knows that a 12 bit
> instruction is sufficient to access lowcore. So it emits instructions
> like 'lghi %r1,0; l %rx,xxx(%r1)' instead of a single load/store
> instruction. As s390 stores variables often read/written in lowcore,
> this is considered problematic. Therefore disable -Warray-bounds on
> s390 for now until there is a better real solution.
> 
> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>

It looks like the source of this problem (the literal-values-treated-as-NULL)
is gcc-12 specific. From the discussions, it sounded like Jacob was
going to fix this "correctly" in gcc-13. It might be a good idea to make
this version-checked? (i.e. only disable on gcc-12)

Either way:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
