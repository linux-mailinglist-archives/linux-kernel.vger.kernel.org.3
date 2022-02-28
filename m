Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 655D94C62D9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 07:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233173AbiB1GSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 01:18:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232646AbiB1GSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 01:18:20 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF209645A
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 22:17:41 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id iq13-20020a17090afb4d00b001bc4437df2cso10452384pjb.2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 22:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TRKNU+Sk791NM7aPN4r23XFgf1IAjvCxTNE5/21QHZE=;
        b=ysECkDb4OIRdLr9p1QPgJ8IR77lgiptkYIo9SJasOEfZRNt1loFFJEKfxyIVAsAX4Q
         PVGTnPQAas29P5+74Jmv1y26UKHS2LO4Dho1yJldR0CslkMU2etWiiMB3dMYu1XGBuZq
         sWM6mIjpQk6T8ZJHjoNDkcmwIuSIyDsbH5jucufSEfZLXjLitbfHTyYMNSZejqqzVABv
         vao0zWWxhfdlk1v02tkp/jnhOV7jNcbQ+NMh+1nheholM8ywJYzk/ZcbtjApG+6r69At
         bXiiV5xZlEhzXB1gpyGT7oUlbSGJw8MzrUONaGmIR6UstKL28cC0H3Im9PtZXTmle0re
         2kmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TRKNU+Sk791NM7aPN4r23XFgf1IAjvCxTNE5/21QHZE=;
        b=GxCkEcJ+WdoufbiY/7Zu6bH9DaCKqfo8WLho42YB22QpHfQjIdWeW7IBySt2Eqi80F
         NarRX7jwhw3R8QMTkOlTqh6BdgSxhXbOINvjatn2d2QLw5GIqyS+8uVY0S4Jnd3ib26G
         HjfvJQRZ+kkom4bYBPBq2Vscth4ceZmYpdtfSl2tWZoVIztEXKqw3xNdjzdUV5wbSjD6
         YVkAMJ9h/u9B6u3MnX1k5lcNPlTL+fOI16TtnDbKBG0bkfHjPpF0O5DdZKUJ8mAJ93Aa
         VUo+Q+cqD6FFeJOZ68ahXmBW3eu2j1s8x6Oj6BP9kTWDvC+NU7hl7rsMN0wjG4YRMu5j
         0u9g==
X-Gm-Message-State: AOAM531IvvXRh6oFDI64rE6BsLp0e3utyKEpeNdtNLkHIXVxEc4NmQWy
        FeDACeV+UZJXfrn+4XsG7do46A==
X-Google-Smtp-Source: ABdhPJyg0qEC9jJqD0whkF9k8e67BBqsap/s8nbGfTgvvOz1yt/DNbYxzISY9855Ugg6E2AJRKM/3g==
X-Received: by 2002:a17:90b:250f:b0:1bc:e520:91e6 with SMTP id ns15-20020a17090b250f00b001bce52091e6mr15405648pjb.43.1646029060562;
        Sun, 27 Feb 2022 22:17:40 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([148.163.172.147])
        by smtp.gmail.com with ESMTPSA id gw2-20020a17090b0a4200b001bca7935e27sm14749061pjb.0.2022.02.27.22.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 22:17:39 -0800 (PST)
Date:   Mon, 28 Feb 2022 14:17:35 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 RESEND 0/4] coresight: etm: Correct PID tracing for
 non-root namespace
Message-ID: <20220228061735.GA134957@leoy-ThinkPad-X240s>
References: <20220204152403.71775-1-leo.yan@linaro.org>
 <5f56c04f-f132-a200-4acc-7b151f7abce1@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f56c04f-f132-a200-4acc-7b151f7abce1@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2022 at 01:52:27PM +0000, Suzuki Kuruppassery Poulose wrote:

[...]

> > This patch series has been rebased on the mainline kernel and applied
> > cleanly on latest commit dcb85f85fa6f ("gcc-plugins/stackleak: Use
> > noinstr in favor of notrace").
> > 
> > 
> > Leo Yan (4):
> >    coresight: etm4x: Add lock for reading virtual context ID comparator
> >    coresight: etm4x: Don't use virtual contextID for non-root PID
> >      namespace
> >    coresight: etm4x: Don't trace PID for non-root PID namespace
> >    coresight: etm3x: Don't trace PID for non-root PID namespace
> > 
> >   .../coresight/coresight-etm3x-core.c          |  4 +++
> >   .../coresight/coresight-etm4x-core.c          | 10 +++++--
> >   .../coresight/coresight-etm4x-sysfs.c         | 30 +++++++++++++++++++
> >   3 files changed, 42 insertions(+), 2 deletions(-)
> > 
> 
> I have queued the series to coresight/next.

Thanks, Suzuki!
