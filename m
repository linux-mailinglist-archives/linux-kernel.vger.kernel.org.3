Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E87516231
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 08:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239242AbiEAGZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 02:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbiEAGZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 02:25:22 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DFF84F9D1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 23:21:56 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id w5-20020a17090aaf8500b001d74c754128so13828967pjq.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 23:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SKTKYlNwPBswI7KvwVvUGgGSktP9nkI84ndIRwt7nQ0=;
        b=Klg91Olbd9xvNnScoI9Jo7qffnF+b87zdB61YiDV72+oZO1lZnu38azldFFnB409su
         WisdSBkqncsM9LG+UvU6GTYOBjG9KgdMMMwq25PKUB+zgdvBYW2U/N1Gjj/BAQBBdfs2
         76jREBR9IZ4vrpFIo9Vz8EUUuF4iFpJyQSqTg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SKTKYlNwPBswI7KvwVvUGgGSktP9nkI84ndIRwt7nQ0=;
        b=pBZK4ER61WfES86cg8k12LeJgac1zHlRagPbnB96yd9uMiPL6+9F7re1WJaJSKI8pP
         moGjcesy3/B+tnrXn2iI+xiy3K9Ry8wZt/7j5OB3gHJg127MX7H2PNoXcpbbITIr2P4/
         DvaLXPkBbBBwBAjgnTP4FJwv83AR8xzEQtt4yuJ+EEHZaqQPawPSbpM4hO6R92KW9KP/
         rzXL493vSZbbPvHm4v+Jrvl9U8zKDSUVl5Gczr78ES5r9m/mcByj4mV/eFwIHVc7VSzn
         kIRtpTIm1aKmVWELEVD1B/hLVWa3op5SUR+myrG24mMqXDghyUGI2dsb3epsMvI9DkDI
         qogQ==
X-Gm-Message-State: AOAM531/DtruCnLSsTif5bSCrqxS7DpLwCjwkWdDPtZDro+yLju3vKFN
        3J6Zc8Tz/K6YfscFcUHNfbPzZQ==
X-Google-Smtp-Source: ABdhPJz+jfrVtgiEdIHSI8aK+wUVMyDTcGdWEOLCrg/rORW+7ZJJmVsK5AsizYEC9lrxUsWwCp9rcg==
X-Received: by 2002:a17:902:f684:b0:15e:8c4a:c54b with SMTP id l4-20020a170902f68400b0015e8c4ac54bmr6278847plg.21.1651386115938;
        Sat, 30 Apr 2022 23:21:55 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c12-20020a65618c000000b003c14af5061asm9085007pgv.50.2022.04.30.23.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Apr 2022 23:21:55 -0700 (PDT)
Date:   Sat, 30 Apr 2022 23:21:54 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, dm-devel@redhat.com,
        linux-raid@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Song Liu <song@kernel.org>
Subject: Re: [PATCH v2 2/3] LoadPin: Enable loading from trusted dm-verity
 devices
Message-ID: <202204302316.AF04961@keescook>
References: <20220426213110.3572568-1-mka@chromium.org>
 <20220426143059.v2.2.I01c67af41d2f6525c6d023101671d7339a9bc8b5@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426143059.v2.2.I01c67af41d2f6525c6d023101671d7339a9bc8b5@changeid>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 02:31:09PM -0700, Matthias Kaehlcke wrote:
> I'm still doubting what would be the best way to configure
> the list of trusted digests. The approach in v2 of writing
> a path through sysctl is flexible, but it also feels a bit
> odd. I did some experiments with passing a file descriptor
> through sysctl, but it's also odd and has its own issues.
> Passing the list through a kernel parameter seems hacky.
> A Kconfig string would work, but can be have issues when
> the same config is used for different platforms, where
> some may have trusted digests and others not.

I prefer the idea of passing an fd, since that can just use LoadPin
itself to verify the origin of the fd.

I also agree, though, that it's weird as a sysctl. Possible thoughts:

- make it a new ioctl on /dev/mapper/control (seems reasonable given
  that it's specifically about dm devices).
- have LoadPin grow a securityfs node, maybe something like
  /sys/kernel/security/loadpin/dm-verify and do the ioctl there (seems
  reasonable given that it's specifically about LoadPin, but is perhaps
  more overhead to built the securityfs).

-- 
Kees Cook
