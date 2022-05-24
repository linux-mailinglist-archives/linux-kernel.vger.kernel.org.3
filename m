Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD0C8532890
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 13:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236139AbiEXLPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 07:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbiEXLPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 07:15:00 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD976B09F
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 04:14:59 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id 10so12133124plj.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 04:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0pUvN6bt+TgNvvMP17UzQ1BaC0HNVTnRNblPGeIqHng=;
        b=Yz7WO4jheZ0Jfrn4FWM334iWi3ys9Sf6t2QZ5mSxa4rd0f66AGxvG+btJQNDnOJlPO
         Kn4u+UFLgjsT6TIKWtNyZTH7mhcmH0RlO6BlWQxdA6H5XYJpHra/27i6fxbJUcgRc14c
         0veUt7us4/l8rglyUyT2EzhQIyZ63j/qW9nAGRrVMOOor5FUZQBKcZpdT1Khhs0HiSzm
         BBn96Av7Q92aA9IrSic0S65oYF5cgFgN8Ar85K/BSXiKWYmSMv0YBQbCoAWUgnfIYPbP
         Mqvf5roGQzR5KiBbWL40MRfBl7zZidA7b1x34swpIv79zW0VS/Qa+wa8dFwKzA2kDEK/
         dbpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0pUvN6bt+TgNvvMP17UzQ1BaC0HNVTnRNblPGeIqHng=;
        b=hemiRcU6hfPsgcrhDvGE68fuF2Al16Rf0nJ2GBYGdseh8TabblF1YtNiip/PhqG5nb
         Pq3uvl8QATyYbKZi2UDZOxtYGAy2Ot2bbaxV71/LVCToA+YstrAnh2bI+vrmEqFWvmwe
         3eHdhCn3Vz8J8AnVLtlZWOslpzFw6K3F05TjnlCf9LmHTiypwsTeZ7VVnKrKVdmn4I1/
         I5ueQpMVhNFsDuAS5q3mha7d2G8L06d6DjnsbvMvPuMWRtN31VFdiA34Ru3A5ks4geSh
         eAjgIzmipPJNnEr2wGBu9DUHGgMedTsuQgPGJPH0S+sWU+yziI7ImEV2KC2VvHKRNYe2
         x2CQ==
X-Gm-Message-State: AOAM5302WVOoduPsBspXeN76lXUyYeFrzoeZm/RlgjEQ6bMJ/HO8CwqD
        9UtgsPezgfSVONH/ZRHs16i9xw==
X-Google-Smtp-Source: ABdhPJyG1LqQx40q0BW5eu2M8YMqPNyyYUzF5PI9k1p8tfTDINSgbwswsrqOtfU0unX9PdHG4AHPbw==
X-Received: by 2002:a17:902:dad1:b0:161:a5b5:c8f4 with SMTP id q17-20020a170902dad100b00161a5b5c8f4mr26368673plx.169.1653390899400;
        Tue, 24 May 2022 04:14:59 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id w15-20020a63b74f000000b003f26c2f583asm6275163pgt.61.2022.05.24.04.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 04:14:58 -0700 (PDT)
Date:   Tue, 24 May 2022 16:44:56 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Schspa Shi <schspa@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v3] cpufreq: fix race on cpufreq online
Message-ID: <20220524111456.hw4qugsvt4bm7reh@vireshk-i7>
References: <20220510035259.5ep52sgahd2a6rie@vireshk-i7>
 <20220510154236.88753-1-schspa@gmail.com>
 <20220511043515.fn2gz6q3kcpdai5p@vireshk-i7>
 <CAMA88TpefB=rnqea2u1zEvNUJNE_kdj4mYito7SGCuMj-o071Q@mail.gmail.com>
 <20220511122114.wccgyur6g3qs6fps@vireshk-i7>
 <CAJZ5v0gN_yDFpvCXRXv8rN-i3TugCi-HKpBKK2z4eWU0Zm1GUg@mail.gmail.com>
 <CAJZ5v0id+7vkqMQEyVRe29oF_dRtzZ0EhoYUn8=yzeENDeABJw@mail.gmail.com>
 <20220512065623.q4aa6y52pst3zpxu@vireshk-i7>
 <CAJZ5v0jeYiZ6esdxnJbOyDztNqOAbjcjxmpca3JTFWRh+cwdBw@mail.gmail.com>
 <20220513042705.nbnd6vccuiu6lb7a@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513042705.nbnd6vccuiu6lb7a@vireshk-i7>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-05-22, 09:57, Viresh Kumar wrote:
> On 12-05-22, 12:49, Rafael J. Wysocki wrote:
> > > > Moreover, I'm not sure why the locking dance in store() is necessary.
> > >
> > > commit fdd320da84c6 ("cpufreq: Lock CPU online/offline in cpufreq_register_driver()")
> > 
> > I get that, but I'm wondering if locking CPU hotplug from store() is
> > needed at all.  I mean, if we are in store(), we are holding an active
> > reference to the policy kobject, so the policy cannot go away until we
> > are done anyway.  Thus it should be sufficient to use the policy rwsem
> > for synchronization.
> 
> I think after the current patchset is applied and we have the inactive
> policy check in store(), we won't required the dance after all.

I was writing a patch for this and then thought maybe look at mails
around this time, when you sent the patch, and found the reason why we
need the locking dance :)

https://lore.kernel.org/lkml/20150729091136.GN7557@n2100.arm.linux.org.uk/

I will add a comment for this now.

-- 
viresh
