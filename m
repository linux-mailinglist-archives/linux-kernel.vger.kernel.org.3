Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4AD358B9AA
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 07:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbiHGFRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 01:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiHGFRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 01:17:42 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96D5E0DF
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 22:17:41 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id b4so6126974pji.4
        for <linux-kernel@vger.kernel.org>; Sat, 06 Aug 2022 22:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/M40Lir0c3unLFM3oH2uK5N2/5ZEFQr2Skfy+gX1t/U=;
        b=KPa5EHbxec7dPBJyLKuuOBy2dcOFjef0WqKoi6IaYpXsd7sdYVQ6Wr9sI6F+9kSaRc
         Mq74iqKc93IhmZzCuW7QcPyGnJLqENWiLTgrDPLKfE4aLXkYylagFwdJ9AumUPXM2ucD
         4tcsb5gX/Svz16b7fYggGScSQqGitFbJ6PiewhJ18aAnVchzwWQvdppBPLivoJtqg+NB
         SlCI6nvSjkT3kAPGr3CPJiTe5e77vkm59LRpt2FdKKpbJQyvbiLG2+sFBBaHZQU5gtd2
         /+f2Eu43Aye+MqiSpHFEk7SgwwGAfqUbMvJNZvJFNs/N34EWaditc3RWGNF2Pu08qMHU
         lJCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/M40Lir0c3unLFM3oH2uK5N2/5ZEFQr2Skfy+gX1t/U=;
        b=4g9sRMoJOP1DnFGYbdLtXzuO0M/562/3iGgP4m9Ne5nZna0VFkVR/zMp+c5WZflIUT
         PXJLFikq+39rtzLUMxCcekJX2M90MvtDbQW7rFv6UZ2BwXNRfdC4/HyDSTawFQ6Pc3Vj
         2kiq56N9FYDnHDJ57bTYrryvLqXPOLVHVoVEeMW7G7t2bvbcOVTLy594lmHx2I7Neo/f
         LLcy6QouBEqhluQxKy9lI5GZMMbxZ2qUWZMbeUVC2AyX6xk5/vSZux7wgQhd9J6l+H0p
         X2YPwzxLI/x8N/VUoI7OwyC4xKgkp8JbYZPXY5s2iQYNowB5CxLw1mt7Uk1doONaKc5D
         Bvng==
X-Gm-Message-State: ACgBeo1Rqon+q11sQBbnongvvcn8cXbOXkmIO/7qkT0+EbY1i7r1UmnC
        9ec2erWJ2bpreSFteAyDCEzxig==
X-Google-Smtp-Source: AA6agR6NsU64wnmBKtMCQ71dQuf9D7EHh46eTrnAKTS/AgPHAL00p3DQabpZDAS1UBQG1dlBfMfwvw==
X-Received: by 2002:a17:90b:394:b0:1f5:90a1:acf0 with SMTP id ga20-20020a17090b039400b001f590a1acf0mr9593429pjb.40.1659849461339;
        Sat, 06 Aug 2022 22:17:41 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (173.242.120.104.16clouds.com. [173.242.120.104])
        by smtp.gmail.com with ESMTPSA id s18-20020a170902c65200b0016d738d5dbbsm5860632pls.97.2022.08.06.22.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 22:17:40 -0700 (PDT)
Date:   Sun, 7 Aug 2022 13:17:37 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     carsten.haitzler@foss.arm.com
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Subject: Re: [PATCH v5 10/14] perf test: Add thread loop test shell scripts
Message-ID: <20220807051737.GH34254@leoy-ThinkPad-X240s>
References: <20220728145256.2985298-1-carsten.haitzler@foss.arm.com>
 <20220728145256.2985298-11-carsten.haitzler@foss.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220728145256.2985298-11-carsten.haitzler@foss.arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 03:52:52PM +0100, carsten.haitzler@foss.arm.com wrote:
> From: "Carsten Haitzler (Rasterman)" <raster@rasterman.com>
> 
> Add a script to drive the thread loop test that gathers data so
> it passes a minimum bar (in this case do we get any perf context data
> for every thread).
> 
> Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>

Reviewed-by: Leo Yan <leo.yan@linaro.org>
