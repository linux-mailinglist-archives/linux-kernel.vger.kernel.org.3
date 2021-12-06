Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2092B46953C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 12:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242106AbhLFLvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 06:51:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237397AbhLFLvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 06:51:17 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B73CC0613F8
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 03:47:49 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id n8so6890556plf.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 03:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eSkZ4nMizlCpYvq6kX4bxUOExmWLGfHM/8gziDsXAhI=;
        b=SDY3uMwEOpQq9mG6dMqA56ALZO8xsDGJfkMzx4JGUaQ7AxBExlyVpkp8u99q366Hj+
         rQwkdh28+s8eLoOmOIZ68pl5jMrx6eDbzSo6frRC3p1+4wqF6G8gTBlZSNuvnK99L6yh
         yTZfZdvW/TdyUiJdzbRcVsQUUahxNXx6uZJPvIRT7PUavgkLmEh+I2Ofb/yhxP/uNd4t
         jZaOB3TvxA9kP0dGo2tWJijm4CYrINAROgjq6m9Hz9zjLTDrKNSeXzgvsYm+DiFDRujI
         0UxkKRA5FFnznGXgmH1P2d5qzQIJr0zet4BDo2CrG7JJYrQxBffjU3gxSZ96D2j7z4Zz
         RFug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eSkZ4nMizlCpYvq6kX4bxUOExmWLGfHM/8gziDsXAhI=;
        b=ecPqUUaBnbqNCcu2pMxRqwfaw29kq6cARRy2wFqhilsHsAFz42faFUBAujXolLu1AO
         pIsiBX3d5x8qKOEsWPIH44ssXSVwrnWAaCTSrca9HSKNq0GwNyXeP5NgJyjE+fXb4jfT
         wLstt+ZEKeY2XOLVDPA4KYt8yxz9PiXGLLUMeo+Hdjh1n4A3zamRlPj5ePd/8/DxSy3g
         Y+pzQWO82Huz6qbo3Z0JqtBc5gxA7V2ZrOsxg4hO4UNQcLWK+qMRdjo4rH4qAF9mKHR2
         zbsLTeKtwuHx+QIxfS/qmtsMhMDoUZfVXeNA31LH1YnXnwW4KdPw6v4W3PUj1USOYmaW
         Mt/A==
X-Gm-Message-State: AOAM530FuTQbDI+UD2zuuOzCxSZtA+K9O7pALQqcJm8aVMfYPo2mhzpn
        tKKQPA+2xJzb29F/qfPQS+6BGQ==
X-Google-Smtp-Source: ABdhPJxhavqWGKxjUCVfrQBoYUUj+MsBE3Mx3QeZDIj/krHAScb24Z3ioi2SNvg89LZWfgvqpMPLDg==
X-Received: by 2002:a17:902:d2c7:b0:142:f06:e5fa with SMTP id n7-20020a170902d2c700b001420f06e5famr42869844plc.87.1638791268764;
        Mon, 06 Dec 2021 03:47:48 -0800 (PST)
Received: from dragon (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id oj11sm13622116pjb.46.2021.12.06.03.47.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Dec 2021 03:47:48 -0800 (PST)
Date:   Mon, 6 Dec 2021 19:47:42 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Maulik Shah <quic_mkshah@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] Add Qualcomm MPM irqchip driver support
Message-ID: <20211206114742.GM10105@dragon>
References: <20211206092535.4476-1-shawn.guo@linaro.org>
 <87v902kqae.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v902kqae.wl-maz@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 09:59:05AM +0000, Marc Zyngier wrote:
> On Mon, 06 Dec 2021 09:25:33 +0000,
> Shawn Guo <shawn.guo@linaro.org> wrote:
> > 
> > It adds DT binding and driver support for Qualcomm MPM (MSM Power Manager)
> > interrupt controller.
> 
> That's the 4th version in exactly two weeks, and that still has all
> the problems I commented on in v3.

I mistakenly thought you had looked at v3, and v4 was sent out before I
receive your reviewing on v3.  I will slow down the posting.

> 
> I won't review a new version this week.

Sure.  This is not anything urgent.

Shawn
