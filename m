Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6E158986F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 09:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239100AbiHDHfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 03:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233711AbiHDHe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 03:34:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DACF28E29;
        Thu,  4 Aug 2022 00:34:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA8A2612D3;
        Thu,  4 Aug 2022 07:34:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2366DC433D6;
        Thu,  4 Aug 2022 07:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659598496;
        bh=MGOY78NG2d2SKFi6yJqShuDYdWhD9bgmij+Ad5jmRpc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ew3XvjJbix0q34wQ9O9nF530Z7d+EgTIibHKMfZvh/weR0mceAWte7sU8eqBYDZDp
         QjGJ7JFtt0sZdqQN+sN5CoC6ajOJ/k+bmFGehy0abody2TVYSSFGoJMxWUvAgJolnN
         wUkwHcOAR1OKWHHXRq3ycpUZEZSkQZqBdKXiM+TDREyOjMutBPzb1jadLKC1jCpUUq
         WA1KrAVljq6PU43C2raO0BTBuRHcw94CZrONuTu2olEnB/hA6ygzXhBWHBitxs7xXB
         xxwBm9fGWVTwfn4otaORvKN87IVgkimyXGuoJyZPKYRRm19zO4i5Yyqh28OjIe6bu8
         D52DqB5Z8j98A==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oJVO0-00035j-4y; Thu, 04 Aug 2022 09:35:16 +0200
Date:   Thu, 4 Aug 2022 09:35:16 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
        quic_ppratap@quicinc.com, quic_vpulyala@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] usb: dwc3: qcom: fix runtime PM wakeup
Message-ID: <Yut2tLqGfu82xcDs@hovoldconsulting.com>
References: <20220802151404.1797-1-johan+linaro@kernel.org>
 <20220802151404.1797-5-johan+linaro@kernel.org>
 <YurviWfzut9sursr@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YurviWfzut9sursr@google.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2022 at 02:58:33PM -0700, Matthias Kaehlcke wrote:
> On Tue, Aug 02, 2022 at 05:14:00PM +0200, Johan Hovold wrote:
> > A device must enable wakeups during runtime suspend regardless of
> > whether it is capable and allowed to wake the system up from system
> > suspend.
> > 
> > Fixes: 2664deb09306 ("usb: dwc3: qcom: Honor wakeup enabled/disabled state")
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> 
> Ah, I wasn't aware that the same wakeup mechanism is used in runtime suspend.
> 
> In how far is runtime PM actually supported/used by this driver? The device is
> set 'active' in _probe(), and there are no other pm_runtime_* calls, except
> in dwc3_qcom_remove() and qcom_dwc3_resume_irq(). How does the device get from
> 'active' into 'suspended'?

It will be runtime suspended when the child (core) device suspends, but
you need to enable runtime PM through sysfs first.

And the controller is resumed in the wakeup-interrupt handler for the
runtime PM case.

It seems to work ok, and it looks like the driver has supported this
since it was first merged.

Johan
