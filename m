Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA1E46B7EE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 10:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234327AbhLGJwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 04:52:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbhLGJwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 04:52:12 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F1AC061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 01:48:42 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id gt5so9909229pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 01:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s+XsYufk+toehN32UwBZjQ4izCH/qBHdagg0OrnH5cI=;
        b=lwXH0O0UyKZjoEkgdxwJK4zQg6g7GMgdOwMjf3t9rs4yq+22ivaNrekd1Hlmc1c0P4
         Hze5ZtuWYCZaPK1blKLKxXs1JPWL4Mf0/9mQC+WgxaZjkzE0GU4n6+LJPaTv+NEop3tF
         v/0OXVUPFIdH7XUR6fsKKUeZVS1OTxgBLkIR4Lcb7C6vMZAz2C0fCYoiAdRHNXMx8hHx
         g4qXvLfxBKmG2ZP+hLvoF2oAyvF5unFR+VFGiFfEt7PMv/IDAW8CSfhkztfOp716g2Kd
         mr2ozhVYmyxzyjSTra5YSCJF9JKTSn/+QV7xVWPF9sSosF+bcXFvnxfXniM9sehB6mpy
         uSdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s+XsYufk+toehN32UwBZjQ4izCH/qBHdagg0OrnH5cI=;
        b=dOytkGkpJtvb0Y5kpSYCTC+DUeQAEZHYyOe7YxcaiTbUhUzjHk8IwsA/lCVpc9IvVe
         Vo5qvGxBPUm/+M0DQG9nCeVBrAP3juiQOdJ2TqaMBY2zh0YoKXP6UxPNNvLKYO7gknPk
         ahdB/IjTDYxXK0/KBCBt2j+fAioThjAHqfUA0TUenjoW815MTP/DG49ck+fzIVm2yCzE
         2jsbb1XrAoJM/D5izheBtb7jZr1fM/7v99lSHm+tjqpz3qJRyGOpuFcpPECZYav3DM7/
         4MOWwjbeJ6YdxNp4ZcsQeC2pL1waU5KuzKeWBwJqmn4rb61fKX2f+9XZZTTn2rJnU/5A
         8CNw==
X-Gm-Message-State: AOAM532XjIvpZOz1cE6PUw/6amDpczZ6DDL5DTk2P9ggXFAHTvbRQpby
        Jv9drhTb3YWHDvRYprglbYtSHg==
X-Google-Smtp-Source: ABdhPJw9r5j3rSn2GjBmh4ZR+lJ2DNzCLFE+e/hOWTQrnjmUHAbdtvirEW84fwqvsZh+xgtbixA7wg==
X-Received: by 2002:a17:90b:fd5:: with SMTP id gd21mr5428409pjb.37.1638870522174;
        Tue, 07 Dec 2021 01:48:42 -0800 (PST)
Received: from dragon (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id mn15sm2057979pjb.35.2021.12.07.01.48.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Dec 2021 01:48:41 -0800 (PST)
Date:   Tue, 7 Dec 2021 17:48:36 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Maulik Shah <quic_mkshah@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] irqchip: Add Qualcomm MPM controller driver
Message-ID: <20211207094835.GO10105@dragon>
References: <20211202122122.23548-1-shawn.guo@linaro.org>
 <20211202122122.23548-4-shawn.guo@linaro.org>
 <87wnkikqve.wl-maz@kernel.org>
 <20211206131530.GN10105@dragon>
 <87wnkh26ar.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wnkh26ar.wl-maz@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 01:48:12PM +0000, Marc Zyngier wrote:
> > > > +static int qcom_mpm_enter_sleep(struct qcom_mpm_priv *priv)
> > > > +{
> > > > +	int i, ret;
> > > > +
> > > > +	for (i = 0; i < priv->reg_stride; i++)
> > > > +		qcom_mpm_write(priv, MPM_REG_STATUS, i, 0);
> > > > +
> > > > +	/* Notify RPM to write vMPM into HW */
> > > 
> > > What do you mean by 'into HW'? We just did that, right? or are these
> > > registers just fake and most of the stuff is in the RPM?
> > 
> > I have a note about this in commit log.
> > 
> > - All the register settings are done by APSS on an internal memory
> >   region called vMPM, and RPM will flush them into hardware after it
> >   receives a mailbox/IPC notification from APSS.
> > 
> > So yes, these registers are fake/virtual in memory, and RPM will
> > actually flush the values into the MPM hardware block.
> 
> Then why are you using MMIO accessors all over the place if this is
> just RAM? Who *owns* this memory? Is it normal DRAM? Or some flops
> exposed by a device? Why isn't the state simply communicated over the
> mailbox instead?

It's a piece of internal memory (SRAM) which can be access by AP and
RPM.  The communication mechanism is defined by SoC/RPM design, and we
can do nothing but following the procedure.

Shawn
