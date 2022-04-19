Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A168550622C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 04:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344987AbiDSCgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 22:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235850AbiDSCgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 22:36:38 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFF4CD6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 19:33:57 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id h5so22292694pgc.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 19:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=j9cziDR8TTkRRjQK85vGUcJr91F0j+7nYT1sRtOWrYo=;
        b=lRy2Rw0ouK1ZNqUKDuvy71QtiCjcxxosNCLk+/x5xISfQsazZY8DdeA6EvpOqH8jCt
         owSdGVwU6RLJphr6tcOaSitTaJWQcTa3XQvYSY9EDlIXHdcaC/NJmgHvL/ribWQB/o2Q
         kWmLB7auKAHcCx8Lqs1Vyljv+hPuWddx3mdww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j9cziDR8TTkRRjQK85vGUcJr91F0j+7nYT1sRtOWrYo=;
        b=oKcF9lVMGoRqI0Mo5/PKhj/RASPn0hctOFYH1oOjiumn5E0mgLCWWrCA9J2nvQXABR
         RQimmmhJKIb0iPj41Yi+ksi7oLPHGTdg+DZGPVmGzotBATWqxexAetOyJO+zHHU79VNn
         E1VKMy71B/S6fol3OqPctBL4mcv03oxWu5ckyL412mgESM9lCI+WFTFCvmG8I8z0hevf
         d69su9Pe2CO4LrBreBOK1Yuox8U6m3mPLeFuvGX39wNTULQg6PnWHDupTmCkhiAQwy1q
         C/rtu5Xd8x9mpgX50NplZMs6wPSv6Kfjsws9i6XTCXDUGyzvn86WkuzJLtWpIWGw1dBw
         lRjQ==
X-Gm-Message-State: AOAM530uejLyeQn3rD/r7bzSVAwlc/Mi8sD02hRJuEKWNjd/V2UfTW/Y
        hw7sIZEB3ubTDWCAsAfS002Lpg==
X-Google-Smtp-Source: ABdhPJxbQz3Vu6hsTbGBYxojsApKIqv4MmFTFy5f9XEVo+IQP8mxZsJhUUcVYLGxcRcQXCRGbyuF/A==
X-Received: by 2002:a63:f341:0:b0:39d:3ce2:fc8d with SMTP id t1-20020a63f341000000b0039d3ce2fc8dmr12314343pgj.441.1650335637120;
        Mon, 18 Apr 2022 19:33:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y131-20020a626489000000b00505a8f36965sm13955880pfb.184.2022.04.18.19.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 19:33:56 -0700 (PDT)
Date:   Mon, 18 Apr 2022 19:33:55 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, Song Liu <song@kernel.org>,
        linux-security-module@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>, dm-devel@redhat.com
Subject: Re: [PATCH 0/3] LoadPin: Enable loading from trusted dm-verity
 devices
Message-ID: <202204181931.A618DFF2C@keescook>
References: <20220418211559.3832724-1-mka@chromium.org>
 <202204181512.DA0C0C6EBD@keescook>
 <Yl3pj72hM/Bo+Kf5@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yl3pj72hM/Bo+Kf5@google.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2022 at 03:43:27PM -0700, Matthias Kaehlcke wrote:
> Hi Kees,
> 
> On Mon, Apr 18, 2022 at 03:14:14PM -0700, Kees Cook wrote:
> > [oops, resending to actual CC list]
> > 
> > On Mon, Apr 18, 2022 at 02:15:56PM -0700, Matthias Kaehlcke wrote:
> > > This series extends LoadPin to allow loading of kernel files
> > > from trusted dm-verity devices. It adds the concept of
> > > trusted verity devices to LoadPin. Userspace can use the
> > > new systl file 'loadpin/trusted_verity_root_digests' to
> > > provide LoadPin with a list of root digests from dm-verity
> > > devices that LoadPin should consider as trusted. When a
> > > kernel file is read LoadPin first checks (as usual) whether
> > > the file is located on the pinned root, if so the file can
> > > be loaded. Otherwise, if the verity extension is enabled,
> > > LoadPin determines whether the file is located on a verity
> > > backed device and whether the root digest of that device
> > > is in the list of trusted digests. The file can be loaded
> > > if the verity device has a trusted root digest.
> > > 
> > > The list of trusted root digests can only be written once
> > > (typically at boot time), to limit the possiblity of
> > > attackers setting up rogue verity devices and marking them
> > > as trusted.
> 
> 
> > Thanks for working all this out! Where does the list of trusted
> > roothashes come from? I assume some chain of trust exists. Is the list
> > maybe already stored on the rootfs?
> 
> Yes, at least the content of the list comes from the rootfs. The
> userspace part is still TBD (also pending on the evolution of this
> patchset), having the list pre-formatted in a single file on the
> rootfs should be fine.

Ah-ha, that's perfect.

> > It'd be nice if there was some way to pass the trust chain to LoadPin
> > more directly.
> 
> I imagine you envision LoadPin reading the file itself, instead of
> just processing the content. That should be doable. One option would
> be to pass the path of the file with the hashes through the sysctl
> file and use kernel_read_file_from_path() to read it if the path is
> in the pinned root (or maybe even in any trusted file system ;-)

It could be a boot param or a Kconfig too. But yeah, having LoadPin able
to use itself to validate the file path would be much nicer.

-- 
Kees Cook
