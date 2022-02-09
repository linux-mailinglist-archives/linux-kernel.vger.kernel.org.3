Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7294AF75A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 17:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237637AbiBIQ6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 11:58:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237617AbiBIQ6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 11:58:02 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA87DC05CB87
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 08:58:04 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id x15so2893916pfr.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 08:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fo6XR7spd9XcEJkq6CJIEEsCXHgqcsp2/wdsL0apsQc=;
        b=s4c5xPmVw4azK2xx5T7guOhuLISLqh50z5xDON+mSKfu/jhvkIl0R90HMG2BZ1bowp
         xPqG7tNmIPznCK+5No4lEha5zjiaDzt4rhCCE1/ea+x+C4nqsCNcnS2zbaHz97Da4+FV
         +bfos6Q2OVZmAqlMaKoNqxFpWkfbvg6mByHlrZR50zxLZZTar1oUVoa1ZeEufllhts8D
         FAGdHg+ot6eAJ4Oj/FgRRMbjaS7M2tBKKt75qCTGcO9z+h41r/rf5kg4nyya7GWAC340
         lfMC2me1mEavFUn3J9o1Yrfd69gEEyDpMqBfP+Gfcw3rwtACCBXlhMXEeEru8J2UKWU7
         guwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fo6XR7spd9XcEJkq6CJIEEsCXHgqcsp2/wdsL0apsQc=;
        b=VGl5opW7XgtA5m8Fzn2R/+iFlcVWNkzIsgd24kV7AcZ/6Tho25T1+If/WEvOluB3/M
         842Rgf7CLE/6WJtEwHEjoRU+w+ERma1NinBVJ/tQtpsbRHAhue8Eh8kg4mAFfiYwW4nn
         thnGN9G9x1F/NiURIQm8T/My5Z04gMKrNkNjdZiuyKLGjIiiQ0R37iiqphqu+wEs96gf
         ENwftSyikcjaG+DP693BT9t/YKR9iCWHx5Ue50uDHf6nwmPZzJu87ODHFAUgZ/YwVYcu
         E1fSgvPv58BntyEbpvK/XMh5IIbMSxzvoaHbR8919K6mxowE22pDhmAlyEd4pAqsdoBE
         kQng==
X-Gm-Message-State: AOAM530swIl+1YqGBVfAXgQ44pbrGxmgU//S2FTqlDykzNVCMlg3zoL1
        6l1qh7zAjtcMN+RuBhtHFtlGnA==
X-Google-Smtp-Source: ABdhPJxOKLuoagmc/nGkJEkumRLEQI44gBYvwGBBkDi48NIEr2p9/tyMBLc3imUVjYl2fRMakDeY+g==
X-Received: by 2002:a63:555b:: with SMTP id f27mr2612331pgm.468.1644425884027;
        Wed, 09 Feb 2022 08:58:04 -0800 (PST)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id f8sm20665506pfv.24.2022.02.09.08.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 08:58:03 -0800 (PST)
Date:   Wed, 9 Feb 2022 09:58:00 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Leo Yan <leo.yan@linaro.org>, Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 RESEND 1/4] coresight: etm4x: Add lock for reading
 virtual context ID comparator
Message-ID: <20220209165800.GA3548585@p14s>
References: <20220204152403.71775-1-leo.yan@linaro.org>
 <20220204152403.71775-2-leo.yan@linaro.org>
 <6b91293a-1149-2c77-04a4-421a45d4e1e0@arm.com>
 <20220209093304.GA334894@leoy-ThinkPad-X240s>
 <5fbadc11-0371-7dec-3189-ef5908fb3122@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5fbadc11-0371-7dec-3189-ef5908fb3122@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey guys,

On Wed, Feb 09, 2022 at 09:42:29AM +0000, Suzuki K Poulose wrote:
> Hi Leo
> 
> On 09/02/2022 09:33, Leo Yan wrote:
> > Hi Suzuki,
> > 
> > On Wed, Feb 09, 2022 at 05:47:24AM +0000, Suzuki Kuruppassery Poulose wrote:
> > > Hi Leo
> > > 
> > > On 04/02/2022 15:24, Leo Yan wrote:
> > > > Updates to the values and the index are protected via the spinlock.
> > > > Ensure we use the same lock to read the value safely.
> > > > 
> > > > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > > > Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> > > > ---
> > > >    drivers/hwtracing/coresight/coresight-etm4x-sysfs.c | 2 ++
> > > >    1 file changed, 2 insertions(+)
> > > > 
> > > > diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> > > > index 10ef2a29006e..2f3b4eef8261 100644
> > > > --- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> > > > +++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> > > > @@ -2111,7 +2111,9 @@ static ssize_t vmid_val_show(struct device *dev,
> > > >    	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
> > > >    	struct etmv4_config *config = &drvdata->config;
> > > > +	spin_lock(&drvdata->spinlock);
> > > >    	val = (unsigned long)config->vmid_val[config->vmid_idx];
> > > > +	spin_unlock(&drvdata->spinlock);
> > > >    	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
> > > >    }
> > > 
> > > 
> > > I have queued this patch.
> > 
> > Thanks!
> > 
> > > For the rest, we would need to wait until the helper lands in the rc.
> 
> Sorry, that was not the exact argument, see below.
> 
> > 
> > The helper function patch has been landed on the mainline kernel,
> > it would be safe to merge the rest patches.
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d7e4f8545b497b3f5687e592f1c355cbaee64c8c
> 
> The coresight queue is based on rc1 and we already created a stable
> tag for TRBE erratas, which was pulled into arm64. So, (correct me
> if I am wrong), AFAIU, we cannot rebase the queue on to rc2 where
> the patch landed. But happy to proceed, if there is a solution.
> 
> Mathieu, what do you think ?

Your assesment above is correct - because the commitIDs have been published and
used in another tree we can't simply rebase to -rc2.  Otherwise we would end up
with the same patches with different commitIDs published in various trees.

To deal with this we would "normally" ask Jakub Kicinski to prepare a pull
request for us to use, after which Leo's patches could be applied.  But in this
case Catalin sent the arm64 part of the TRBE errata patchset to Linus as an -rc
fix.  As such those patches are already in Linus' tree with the same commitIDs
we currently have in the coresight-next tree.  

Therefore you can simply rebase to rc2 (or rc3) and pile up Leo's patches on
top of that. 

Thanks,
Mathieu

