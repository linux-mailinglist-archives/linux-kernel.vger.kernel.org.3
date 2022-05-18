Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6872B52B12C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 06:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiEREQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 00:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiEREQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 00:16:41 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB35118E24
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 21:16:39 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id j6so979147pfe.13
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 21:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=a1/wuoT5db0kZRpIcSlyOn+OdTYXUqFFSk5R5NCmBHw=;
        b=MyF+2wckfA0xYav8+EWfGdnkUM0DYtS4Y2y9V/ytqWLSrqhylsXZ2s8Mq/FwmlhHTq
         lxy7FfrbV8Ab+3HwWgL2PI6Y6FSeSSbOvBijJNxilLM156T5cCkLfa2mR/pUiLxy48Xx
         x8WGMoK7dbEGOcP9xeFijVk+gWVRAX8xXilDHmGp0kXMQPvqoI3nl3uya0+Vmck8dpFQ
         9wDqW4/ODwpDMX2TfgDg94LOwZrur7HoIiSsRbBbTyr1DyAvksOdQu/GjL0B0k2a32VY
         xfFSvTFSZGm5qBDg+NsrxsizvAE8eD7RzwAAMBBM3nF1lb4JZz62ffvjJ/QE8dMb6mBk
         NYAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a1/wuoT5db0kZRpIcSlyOn+OdTYXUqFFSk5R5NCmBHw=;
        b=BQi/BUamru9boF6HGqMvsu5uf1ak5WnmarP+dmnmYiB9iZVypSZT4UngLpFORS0jfl
         Xv0h64bfVjSTKs9JyDqSWZt1RuQMcHjfy/IHSyA3DCFFlTodcGA38BGpVFIZQ47YU/r7
         9gM3vEmbQwj5vFbmmVNv4v2ynLbymp973Bt1YlPxuIO32WYnsRbB8ZB95S1ul1HKEE4O
         GjlKS2DoQW786SWCW2CGemSFWZVXk6DSeHFEGyr8zL1XZepYhKjV2894QIQf10Oy+Ffu
         bkncVDWViO2CHF2A1PlpVk1zDQplj/dmGgCr2bY6ZIh6ZOqiABDTPxjd+kBrijVUHEd4
         NLXw==
X-Gm-Message-State: AOAM533+XIWCMZwGhIiYEFcUMzaShKi+WjfB+qWUItXYYW6MHRrDtJve
        GKDu+o9pjh2ipNSpx/5G4cu7DA==
X-Google-Smtp-Source: ABdhPJxIV/XkPSMp7Do5pkXR6Jtk0s9fhWG2Gr5Uks+e1PYfpOasm2UKlDlq1CpPFhRZ9d2o6C/HGQ==
X-Received: by 2002:a05:6a00:170d:b0:512:ebab:3b25 with SMTP id h13-20020a056a00170d00b00512ebab3b25mr22777489pfc.32.1652847399126;
        Tue, 17 May 2022 21:16:39 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([137.184.121.66])
        by smtp.gmail.com with ESMTPSA id p123-20020a622981000000b0051811c2aa89sm568212pfp.196.2022.05.17.21.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 21:16:38 -0700 (PDT)
Date:   Wed, 18 May 2022 12:16:30 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ali Saidi <alisaidi@amazon.com>, Joe Mario <jmario@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, german.gomez@arm.com,
        benh@kernel.crashing.org, Nick.Forrington@arm.com,
        alexander.shishkin@linux.intel.com, andrew.kilroy@arm.com,
        james.clark@arm.com, john.garry@huawei.com,
        Jiri Olsa <jolsa@kernel.org>, kjain@linux.ibm.com,
        lihuafei1@huawei.com, mark.rutland@arm.com,
        mathieu.poirier@linaro.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, will@kernel.org
Subject: Re: [PATCH v8 0/4] perf: arm-spe: Decode SPE source and use for perf
 c2c
Message-ID: <20220518041630.GD402837@leoy-ThinkPad-X240s>
References: <20220517020326.18580-1-alisaidi@amazon.com>
 <YoQRg1r7HuwiO3bZ@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoQRg1r7HuwiO3bZ@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

On Tue, May 17, 2022 at 06:20:03PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, May 17, 2022 at 02:03:21AM +0000, Ali Saidi escreveu:
> > When synthesizing data from SPE, augment the type with source information
> > for Arm Neoverse cores so we can detect situtions like cache line
> > contention and transfers on Arm platforms. 
> > 
> > This changes enables future changes to c2c on a system with SPE where lines that
> > are shared among multiple cores show up in perf c2c output. 
> > 
> > Changes is v9:
> >  * Change reporting of remote socket data which should make Leo's upcomping
> >    patch set for c2c make sense on multi-socket platforms  
> 
> Hey,
> 
> 	Joe Mario, who is one of 'perf c2c' authors asked me about some
> git tree he could clone from for both building the kernel and
> tools/perf/ so that he could do tests, can you please provide that?

I have uploaded the latest patches for enabling 'perf c2c' on Arm SPE
on the repo:

https://git.linaro.org/people/leo.yan/linux-spe.git branch: perf_c2c_arm_spe_peer_v3

Below are the quick notes for build the kernel with enabling Arm SPE:

  $ git clone -b perf_c2c_arm_spe_peer_v3 https://git.linaro.org/people/leo.yan/linux-spe.git

  Or

  $ git clone -b perf_c2c_arm_spe_peer_v3 ssh://git@git.linaro.org/people/leo.yan/linux-spe.git

  $ cd linux-spe

  # Build kernel
  $ make defconfig
  $ ./scripts/config -e CONFIG_PID_IN_CONTEXTIDR
  $ ./scripts/config -e CONFIG_ARM_SPE_PMU
  $ make Image

  # Build perf
  $ cd tools/perf
  $ make VF=1 DEBUG=1

When boot the kernel, please add option "kpti=off" in kernel command
line, you might need to update grub menu for this.

Please feel free let us know if anything is not clear for you.

Thank you,
Leo
