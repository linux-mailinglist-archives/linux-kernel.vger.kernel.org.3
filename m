Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0659482EA6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 08:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbiACHLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 02:11:04 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:37604 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiACHLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 02:11:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED91360FAC;
        Mon,  3 Jan 2022 07:11:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 858D8C36AE9;
        Mon,  3 Jan 2022 07:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641193862;
        bh=q8eDAWfjXRNor1L1aCHvFfEIVifNeItO15+I6PlGvug=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NgDlGp4JfKAPDv+nOFWeEzIkp3+ww6NE32NcLY1c0VdXip3QeH/ACJw1AdI3acKmM
         71zkFKF06ssb/rr+hkP2snt459bGUULpT3p2D585uGUox7RiTVG286MXtXc8X5PwD4
         qPG3ANWga6b/zEewBckw7aKQxCxlUv9NSb5kd5v0xJ1H/tcl3wyNYDjuz/fsC8l9w+
         LFZgkmGjQujtFIwbC0QpyhkHmj4cdo77e1+aUF+OtcqDheTdyBlfHr4FL+I2UhGdEI
         /6Zutba1uAjWkYuZaVeJHQ8RRwBjKT3SIqknhTJcEVhE7WMQJ7+AJdw+BPjk18aizd
         5HgZ5xrzno7xA==
Date:   Mon, 3 Jan 2022 12:40:57 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] spi: qcom: geni: set the error code for gpi transfer
Message-ID: <YdKhgRHvJK35bGE+@matsya>
References: <20211117133110.2682631-1-vkoul@kernel.org>
 <20211117133110.2682631-2-vkoul@kernel.org>
 <CAD=FV=U+JD6Bmsfa-e-L--wLrdUVfDF+EKOAe9Pp9pc7G5FkyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=U+JD6Bmsfa-e-L--wLrdUVfDF+EKOAe9Pp9pc7G5FkyQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-11-21, 14:20, Doug Anderson wrote:
> Hi,
> 
> On Wed, Nov 17, 2021 at 5:31 AM Vinod Koul <vkoul@kernel.org> wrote:
> >
> > @@ -346,17 +346,20 @@ spi_gsi_callback_result(void *cb, const struct dmaengine_result *result)
> >  {
> >         struct spi_master *spi = cb;
> >
> > +       spi->cur_msg->status = -EIO;
> >         if (result->result != DMA_TRANS_NOERROR) {
> >                 dev_err(&spi->dev, "DMA txn failed: %d\n", result->result);
> >                 return;
> >         }
> 
> Don't you want to call spi_finalize_current_transfer() in the case of
> a DMA error? Otherwise I think you're still going to wait for a
> timeout? ...and then when you get the timeout then spi_transfer_wait()
> will return -ETIMEDOUT and that will overwrite your -EIO, won't it?

Yes missed that and this reply :(

Fixed now and posting v2

-- 
~Vinod
