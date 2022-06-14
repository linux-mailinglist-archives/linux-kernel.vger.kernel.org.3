Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8B054AF74
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 13:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242495AbiFNLrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 07:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241815AbiFNLrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 07:47:10 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4316D47382
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 04:47:09 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id l2-20020a05600c4f0200b0039c55c50482so6097819wmq.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 04:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3BSdbQCfhq3qMpg3tNRIpccBP+VUxkUwhFP4/COR+gA=;
        b=YPmEbj1hQj2q2+SCJW3rwxYPCsipN+NTZB/zsp/IxPNep6Cq5r2+OqE6pgwen6R1cA
         xy/G932h4njkEh3+rI0Gb/zZdTwcGYkoJ+5sRwGQL+XGCNjDcmRAT5uoaFHrt/GuSw9I
         4OzojOZUDvHJhLyxGvb2wiVHUlzw8Pv0PN5uxFlVIjtZ3row5QhaNFvOIG2uJ/D0e8GT
         Vag0PcvzQDkaN8rqVu8GxuAXZCc209RixVdfdMq8pvwHHleZM2QpYTbIW/9/+y1jrFZB
         0khO9IIwnJzjltc6N5MJTo7ktr1Aug58RdPKo5j1Y9O36mbyhnkPt8LxMXrvEMFeohvz
         CbCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3BSdbQCfhq3qMpg3tNRIpccBP+VUxkUwhFP4/COR+gA=;
        b=ZYnLTOcLhXs3sMoClJOQnxdzgWwnjK1EyfsXajnXBXaftdkm1DSI1DXF0V0NaiI8OV
         fccxiNUDjKX8R66bEMe/MW6bRVbSK7G56dlw8RNW7QZ2949ligIZUlFG2LNJiyzp2eF5
         i8QER+DI2J3s6QN3nugGZ+IqNfI8VbO7oA+54JIjAZNhYTDtdOebXSKgwnnIV2pEbggF
         qQGUxOq2pA37l/e8XLb+pCqsPwflw70IBt3Gc7JqS34JIJ7uZo+KCa50EF8GDv0rzVU/
         pIaFip68cBXIbpbE1j8Ix4PaeevdJGbh3NbkZ1AlmVmSxoHxOEK01LjQQcj17BWQ7KN7
         eW0g==
X-Gm-Message-State: AOAM533HfgsBNhCK/OVNlz3UsqA2pLnZk683uCacm0wVXu75HSnLLH4k
        M81cM0gSX3KpS9mJWeBNnpP0lA==
X-Google-Smtp-Source: ABdhPJwmwwcUFoO8Oobw7S1TBe1toT8ja1RjXq6trW9kIsAjSWTGWuLu1KTkfs0c62EbCOfJKsIrgQ==
X-Received: by 2002:a05:600c:4f47:b0:39c:62cc:75da with SMTP id m7-20020a05600c4f4700b0039c62cc75damr3698202wmq.114.1655207227741;
        Tue, 14 Jun 2022 04:47:07 -0700 (PDT)
Received: from google.com (109.36.187.35.bc.googleusercontent.com. [35.187.36.109])
        by smtp.gmail.com with ESMTPSA id m16-20020a05600c3b1000b0039c673952bfsm17156749wms.6.2022.06.14.04.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 04:47:07 -0700 (PDT)
Date:   Tue, 14 Jun 2022 12:47:03 +0100
From:   Vincent Donnefort <vdonnefort@google.com>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        qperret@google.com, tao.zhou@linux.dev, kernel-team@android.com,
        peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org
Subject: Re: [PATCH v10 0/7] feec() energy margin removal
Message-ID: <Yqh1N1lhw+hukHD9@google.com>
References: <20220607123254.565579-1-vdonnefort@google.com>
 <6099583c-c986-e1f3-1eee-33b504286757@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6099583c-c986-e1f3-1eee-33b504286757@arm.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2022 at 01:53:22PM +0100, Lukasz Luba wrote:
> Hi Vincent,
> 
> On 6/7/22 13:32, Vincent Donnefort wrote:
> > Hi,
> > 
> > Here's a new version of the patch-set to get rid of the energy margin in
> > feec(). Many thanks to all for the insightful comments I got.
> > 
> > find_energy_efficient() (feec()) will migrate a task to save energy only if
> > it saves at least 6% of the total energy consumed by the system. This
> > conservative approach is a problem on a system where a lot of small tasks
> > create a huge load on the overall: very few of them will be allowed to
> > migrate to a smaller CPU, wasting a lot of energy. Instead of trying to
> > determine yet another margin, let's try to remove it.
> > 
> > The first elements of this patch-set are various fixes and improvement that
> > stabilizes task_util and ensures energy comparison fairness across all CPUs
> > of the topology. Only once those fixed, we can completely remove the margin
> > and let feec() aggressively place task and save energy.
> > 
> 
> I've run this patch set on pixel6 (android-mainline) and gathered energy
> values from the meter during the PCmark 3.0.
> 
> It looks good, with these patches we have ~10% lower energy usage and
> only ~3% lower score.
> 
> There are no other issues, everything works fine. Feel free to add:
> 
> Tested-by: Lukasz Luba <lukasz.luba@arm.com>
> 
> to the whole patch set.
> 
> Regards,
> Lukasz

Thanks a lot Lukasz!
