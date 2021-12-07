Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C12546BA4E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 12:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235821AbhLGLt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 06:49:56 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:55440 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbhLGLtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 06:49:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D2966CE1A77;
        Tue,  7 Dec 2021 11:46:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B912C341C1;
        Tue,  7 Dec 2021 11:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638877578;
        bh=7TE6fHbl1OyUAdiTw2bdwXFkx6ulhfo0RhKO2CA07Ak=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i5/8kKOlyvhp9bu4v47E3aTiiCsJUrYEQz6bFnGTBdUN3sTKnVta5cspy1k0vtEWJ
         SJLbffXqcnbJI7DnUY9c/wSmyyN2w1CLRQSih+BflwCr2fKZWj3pphN2eaNiIx1rPT
         Iwf+HMBO45WW0XInZm3Hor7O+evwyNNr+1tSVRzuv1QDrzsdiXaUReB/slQJWu/QyT
         IVXwz+JElDxRA4o8lkt7ABzHt0vuIjGRbnDqcpJ4NwhsZX1jKDwbpHLdQwoyg9/5ql
         K9+5DT8scEaw15Ruj6aeK+wAvLYtQpzkZTcfKqGX5SIMNK3hEugj9XR6SFqT8G4YLK
         xUGb4IVmvUMDw==
Date:   Tue, 7 Dec 2021 17:16:14 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Katherine Perez <kaperez@linux.microsoft.com>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] arm64: dts: sm8350: fix tlmm base address
Message-ID: <Ya9JhqZ/Hyj9HdRk@matsya>
References: <20211122190552.74073-1-kaperez@linux.microsoft.com>
 <20211122190552.74073-3-kaperez@linux.microsoft.com>
 <YZxoGp33Seaa2WEG@matsya>
 <Yabo0fGXC1rITmsM@builder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yabo0fGXC1rITmsM@builder.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-11-21, 21:15, Bjorn Andersson wrote:
> On Mon 22 Nov 22:03 CST 2021, Vinod Koul wrote:
> 
> > On 22-11-21, 11:05, Katherine Perez wrote:
> > > TLMM controller base address is incorrect and will hang on some platforms.
> > > Fix by giving the correct address.
> > 
> > Thanks, recheck the spec this looks correct. We should have tlmm reg
> > space here and not tlmm base which also contains xpu region (thus hang)
> > 
> 
> Aren't you reading the patch backwards?

I guess :(

> Afaict downstream the driver carries an offset of 0x100000, which we
> dropped as we upstreamed the driver. As such changing reg to 0x0f000000
> should cause most gpio register accesses to fall outside the actual
> register window.
> 
> Or perhaps I'm missing something here?

I relooked and XPU is at 0xF000000 and Reg at 0xF100000
So this patch should be dropped as such. The size mentioned in
documentation is also correct

Katherine, can you elaborate more on the hang you have observed? Any
specific pins you use which causes this?


-- 
~Vinod
