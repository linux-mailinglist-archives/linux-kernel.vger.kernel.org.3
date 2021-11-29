Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B103F461B28
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 16:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345700AbhK2Plb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 10:41:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235425AbhK2Pja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 10:39:30 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355D1C09B193
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 05:45:07 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id v23so12758832pjr.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 05:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sbb/9fehBWvX3LT+tQgbuNuWGJNXYvoUCePPH+TJoOQ=;
        b=TxiX+KVIfm47/Pj7eHuAIJGjEsdmKxXBkbvsTICx/DOR2kVuv1B+WIu4ugf1Vu2FpI
         HKE9dfd8cWG8F2xrfLMqZ1isdn1M56BqQ14EADJGBDllNSL/lvmWO4+EB1lNR0mLOVtv
         g19OcTSYo08hAlfL9CJ6zwvnCA3HveSSsjW1D2VPGcSibLvLVFGqvm10wTrXFALFZWL9
         JVzH42nksSobevZ/SsSPv06Y1YOaYd2lO/tyjO8YUbHJqn6xx31sKwhalGbHQaOxjlfs
         nItbCsYSlwPFCvB4NnfWDvM5f3dIwogL/wwQQ75Zfvw1Ns2aQdtAWsz+qZ2SDCZNoseA
         MbFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sbb/9fehBWvX3LT+tQgbuNuWGJNXYvoUCePPH+TJoOQ=;
        b=Lx23LGYwtjtyK1+tvHk8OXgoouMPRf5uz5QJIhPmn3vpV8BE5oibrNidVhkEmzayDC
         pzpFr/rOBPMEE1WdkFM1UnRTHG4qqlw6z+cHiJdMZ6PX85bd2G1xYcj/QoXofH14/AYd
         SJJCgmOmJJV7Y3QLunKC7WN3nAmTGY2LuzlJPe9wvlJiUhOiz9vg29Chy0RVekjUToBw
         vYzwqDEy4A3KkbJm7MxPWOw5D6ffFNVy6aXkTLoCo4rz9EiDxtLyw2lA8vuheuDNhtvY
         VME+nKvQRgMP36P49DEtWQplFDVXZGYDi+g8M3a068FM8xwOi5oGzATrmww40otG7lFE
         t03Q==
X-Gm-Message-State: AOAM530Oyr3JQzgIOta/wIA+7JyBKUjCY58tLkIJUbSo0CL83gLSP/JE
        L1mAJ0Q/vo3arzhKI6MW+urFGQ==
X-Google-Smtp-Source: ABdhPJxsOMze01WCoKC8q7SnOnFsDRrPT7zEvnjWvXMrMWe59BA6PRiDZHK+0fqRASSJxF9pPRCOWg==
X-Received: by 2002:a17:903:2306:b0:141:e52e:457d with SMTP id d6-20020a170903230600b00141e52e457dmr60228238plh.3.1638193506754;
        Mon, 29 Nov 2021 05:45:06 -0800 (PST)
Received: from dragon (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id u38sm20034034pfg.0.2021.11.29.05.45.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Nov 2021 05:45:06 -0800 (PST)
Date:   Mon, 29 Nov 2021 21:45:00 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Maulik Shah <quic_mkshah@quicinc.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] irqchip: Add Qualcomm MPM controller driver
Message-ID: <20211129134459.GC10105@dragon>
References: <20211126093529.31661-1-shawn.guo@linaro.org>
 <20211126093529.31661-3-shawn.guo@linaro.org>
 <56a5820e-9cd7-aa49-7ce8-9547f355986e@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56a5820e-9cd7-aa49-7ce8-9547f355986e@quicinc.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2021 at 12:53:39PM +0530, Maulik Shah wrote:
> Hi Shawn,

Hi Maulik,

Thanks for the comment!

> 
> On 11/26/2021 3:05 PM, Shawn Guo wrote:
> > +static int __maybe_unused qcom_mpm_suspend_late(struct device *dev)
> 
> why maybe unused?
> 
> > +{
> > +	struct qcom_mpm_priv *priv = dev_get_drvdata(dev);
> > +	int i, ret;
> > +
> > +	for (i = 0; i < priv->reg_stride; i++)
> > +		qcom_mpm_write(priv, MPM_REG_STATUS, i, 0);
> > +
> > +	/* Notify RPM to write vMPM into HW */
> > +	ret = mbox_send_message(priv->mbox_chan, NULL);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	return 0;
> > +}
> > +
> > +static int __maybe_unused qcom_mpm_resume_early(struct device *dev)
> > +{
> > +	/* Nothing to do for now */
> > +	return 0;
> > +}
> > +
> > +static const struct dev_pm_ops qcom_mpm_pm_ops = {
> > +	SET_LATE_SYSTEM_SLEEP_PM_OPS(qcom_mpm_suspend_late,
> > +				     qcom_mpm_resume_early)
> > +};
> 
> This is not limited to suspend, you will need to notify RPM during deepest
> cpu idle state entry as well, since MPM may be monitoring interrupts in that
> case too.

Yeah, I was trying to test this MPM driver with cpuidle, but failed to
see the SoC get into vlow/vmin state from cpuidle.  Do you have any
suggestion how I should test it properly?

> This may be handled for both suspend/CPUidle using cpu pm notifications
> where in last cpu entering deepest idle may notify RPM (something similar to
> what rpmh-rsc.c does)

Thanks for the pointer!  I will take a look.

Shawn
