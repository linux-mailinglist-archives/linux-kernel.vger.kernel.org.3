Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB5449AC15
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 06:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241199AbiAYFzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 00:55:49 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:43396 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237105AbiAYFuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 00:50:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8207761620;
        Tue, 25 Jan 2022 05:50:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4AFAC340E0;
        Tue, 25 Jan 2022 05:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643089826;
        bh=Aj6bLEkRn0LO2zgjlLIdWAWhSMDxSvE+zVZyvS547Nc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Itk+4/fDGE4WSSJ/SUeOZ1Y4zTSRY/w3Covpusb64cDqA2JHmCLdIBmg2eLG1LxPW
         YTrBpKXRTLY3glHh1nU+CL2vfZMS7NL+irHJ4/P8ZfvA9B1dtFUIDAZSrDrN5yKvjG
         6T5KfNtf5eqXPCPqBmpxXsaMYHue7xnpFW+Od1rHnbKHePksoNMWFiEYqJdrxTvjuK
         5V7TYU72AIdXRGnUWwPyIOcjimwSiNn8EdALHkgQjg1d+ilb8Ht8bpC+LK2tOCGiQl
         WjqexYgALD3z3K5V/6mn2tCiaE1KgZu9xihzUJoA9jacjpBgwwA6j1Ijlz9oLQxMGq
         EgEKCh6/+ATxg==
Date:   Mon, 24 Jan 2022 21:50:25 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: qcom: sm8350: Correct UFS symbol clocks
Message-ID: <Ye+PoRfVyZndeL5K@sol.localdomain>
References: <20211222162058.3418902-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211222162058.3418902-1-bjorn.andersson@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 08:20:58AM -0800, Bjorn Andersson wrote:
> The introduction of '9a61f813fcc8 ("clk: qcom: regmap-mux: fix parent
> clock lookup")' broke UFS support on SM8350.
> 
> The cause for this is that the symbol clocks have a specified rate in
> the "freq-table-hz" table in the UFS node, which causes the UFS code to
> request a rate change, for which the "bi_tcxo" happens to provide the
> closest rate.  Prior to the change in regmap-mux it was determined
> (incorrectly) that no change was needed and everything worked.
> 
> The rates of 75 and 300MHz matches the documentation for the symbol
> clocks, but we don't represent the parent clocks today. So let's mimic
> the configuration found in other platforms, by omitting the rate for the
> symbol clocks as well to avoid the rate change.
> 
> While at it also fill in the dummy symbol clocks that was dropped from
> the GCC driver as it was upstreamed.
> 
> Fixes: 59c7cf814783 ("arm64: dts: qcom: sm8350: Add UFS nodes")
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

Tested-by: Eric Biggers <ebiggers@google.com>

This was sent out over a month ago.  Can it be applied?  It is annoying having
master as well as v5.16 be broken on SM8350.

- Eric
