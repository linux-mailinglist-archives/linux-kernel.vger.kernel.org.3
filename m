Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED63B53D4D2
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 04:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350183AbiFDCOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 22:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350169AbiFDCOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 22:14:14 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39AF83879C
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 19:14:13 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id d129so8513770pgc.9
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 19:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QKSwNl1s1PNMPv2o17fCBwCOfZ/wJPcz4fC4GfkO//M=;
        b=LwpHb6EogZAUeEHmLpAyQsHCvIMSqGstPXK2fxUtcjy49608IuzpqiqnZ+2CCDBK2g
         VcAaD1U2WSEwiUSKveQNeAP0GrNHjhkXN+WYDF6EgU7dazsqQ8+2lD1hAYjLK6NK1Kc3
         sVIvNwDrtP11PXGJ74NZuWz1MHHZSGxYOyqSQfTkwi1HA403FKrL7ZT5elzwSomGtX4n
         d0kZwwVyduqoadAQOV4t9KNkxN5lsRaU0QHnVKQOTTnW7AjGugbI5SDTWq5FKF6vO2G7
         cqVNJMTsdpzqKHo7yfDQyb0Bg1JpeGfPMxhwCo0uR6uQSVd4kGO2CvcbEwQo9JCB/Ds/
         2SUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QKSwNl1s1PNMPv2o17fCBwCOfZ/wJPcz4fC4GfkO//M=;
        b=zzoFALv9oSDbbUs9dosuPle/nUPAmuNIUlUpC7Ykylox+6gOGWyOJ/QuGzXiwjv7EP
         1L2uItvDECbMm+lUdr/3sij+td/gMoVV/sdFsqChG9/Gz0MIq7Q3271xaalD6FrnVs6Q
         rPK7L3Tvbm5i2hDC8row9JscY200ybBCDF4lJfRvL9knZyRNrSE/6sv0nVclKQZWF0/E
         QwmSlPHiEjgf6C4rOXHmAHmn6BA10Kz4JcpsM+9DnSkuE7kMJ6s99gTxmoqZzGUgudKk
         O5ucu+qWp68UWudFT8Z7EcoZO75s5m88fLdn5q0ZypyrwaGsOTChMy/IbgZMMuY0OLiq
         Jh7w==
X-Gm-Message-State: AOAM530VQxb/U8rkdQQABRbDf1MKWG03OkRA5QBbVldlKQdyZR59Oa9k
        +CFfHez4rUELjVhSMUPAjhg6+A==
X-Google-Smtp-Source: ABdhPJw8KKJ53/8OLhg0/oXKY/Gm4EZNGjwkuaEsyDkijoHlIBTgJ+iqeF+N2Bbq+GCo0yfK6W7xmw==
X-Received: by 2002:aa7:848a:0:b0:510:44da:223d with SMTP id u10-20020aa7848a000000b0051044da223dmr79900760pfn.66.1654308852612;
        Fri, 03 Jun 2022 19:14:12 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (ec2-54-67-95-58.us-west-1.compute.amazonaws.com. [54.67.95.58])
        by smtp.gmail.com with ESMTPSA id g2-20020a170902d5c200b0015e8d4eb2cdsm1756639plh.279.2022.06.03.19.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 19:14:12 -0700 (PDT)
Date:   Sat, 4 Jun 2022 10:14:04 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, broonie@kernel.org,
        acme@kernel.org, german.gomez@arm.com, mathieu.poirier@linaro.org,
        john.garry@huawei.com, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <mark.rutland@arm.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 0/2] perf: arm64: Kernel support for Dwarf unwinding
 through SVE functions
Message-ID: <20220604021404.GC53464@leoy-ThinkPad-X240s>
References: <20220517100743.3020667-1-james.clark@arm.com>
 <20220604020721.GB53464@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220604020721.GB53464@leoy-ThinkPad-X240s>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 04, 2022 at 10:07:21AM +0800, Leo Yan wrote:
> On Tue, May 17, 2022 at 11:07:41AM +0100, James Clark wrote:
> > Changes since v1:
> > 
> >   * Add Mark's review tag
> >   * Clarify in docs that it's the SVE register length
> >   * Split patchset into kernel side and Perf tool changes
> > 
> > When SVE registers are pushed onto the stack the VG register is required to
> > unwind because the stack offsets would vary by the SVE register width at the
> > time when the sample was taken.
> > 
> > These first two patches add support for sampling the VG register to the kernel
> > and the docs. There is another patchset to add support to userspace perf.
> 
> Hi Catalin, Will,
> 
> Since James is on vacation, just want to ping if you could pick up
> this two patches?  Mark.B has given review tags for this patch set.

Sorry, or the kernel patch should be via arm tree and the document patch
via Jonathan's tree?

> I did this is because there has another patch set in perf tool to
> enable SVE registsers [1], which is dependent on this patch set's
> merging.
> 
> Thanks,
> Leo
> 
> [1] https://lore.kernel.org/lkml/20220525154114.718321-1-james.clark@arm.com/
