Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52625505AB3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 17:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344628AbiDRPQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 11:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345307AbiDRPPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 11:15:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD099BB08B;
        Mon, 18 Apr 2022 07:12:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6964960BC5;
        Mon, 18 Apr 2022 14:12:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 716DBC385A8;
        Mon, 18 Apr 2022 14:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650291174;
        bh=IVDZmECCaRmoAtMDnJhVFNl6perUjNM7sTyxh9m4brg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lKdS9WmOwcflzN1Th5Ni8eFpXF1nMyP4ivl5hdxkwJn7O3SoazMmyTYgc/mLhe1tX
         QPMCy5Ds1XUKjXCFD8iAIQK6lFbPeJv7dYEj7ZCoB5U99ZmARohYUcz+irAbyvU+DM
         pmPcjervlnxx2s3reHgBZrqCyNYRZqRasSguWaT2DqIZggRJA+e/KdCDV5nQUh7v0T
         gqc6hI6R/Jyvnif51h5bhtIZF1WxVHpuDc2OER4x44ZfHXG7MCzY2vGF86ZGJt+Q2p
         zTfwuyOsPYrXbkEuItOmAvutmCiwPkRsCgRAITS8GYVQok2vZmSzPRK86CPnAk1+1v
         8rXvY/gvs5yBA==
Date:   Mon, 18 Apr 2022 19:42:48 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc:     quic_hemantk@quicinc.com, quic_bbhatt@quicinc.com,
        mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] bus: mhi: host: Wait for ready state after reset
Message-ID: <20220418141248.GC161722@thinkpad>
References: <1649875946-32516-1-git-send-email-quic_jhugo@quicinc.com>
 <20220418062645.GI7431@thinkpad>
 <eff55b55-cef0-2931-c8e5-95a9230c9d27@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eff55b55-cef0-2931-c8e5-95a9230c9d27@quicinc.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2022 at 07:53:24AM -0600, Jeffrey Hugo wrote:
> On 4/18/2022 12:26 AM, Manivannan Sadhasivam wrote:
> > On Wed, Apr 13, 2022 at 12:52:26PM -0600, Jeffrey Hugo wrote:
> > > From: Jeffrey Hugo <jhugo@codeaurora.org>
> > > 
> > > After the device has signaled the end of reset by clearing the reset bit,
> > > it will automatically reinit MHI and the internal device structures.  Once
> > > That is done, the device will signal it has entered the ready state.
> > > 
> > > Signaling the ready state involves sending an interrupt (MSI) to the host
> > > which might cause IOMMU faults if it occurs at the wrong time.
> > > 
> > > If the controller is being powered down, and possibly removed, then the
> > > reset flow would only wait for the end of reset.  At which point, the host
> > > and device would start a race.  The host may complete its reset work, and
> > > remove the interrupt handler, which would cause the interrupt to be
> > > disabled in the IOMMU.  If that occurs before the device signals the ready
> > > state, then the IOMMU will fault since it blocked an interrupt.  While
> > > harmless, the fault would appear like a serious issue has occurred so let's
> > > silence it by making sure the device hits the ready state before the host
> > > completes its reset processing.
> > > 
> > > Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
> > > Reviewed-by: Hemant Kumar <hemantk@codeaurora.org>
> > > Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
> > 
> > I was about to apply this patch but wanted to check with you on using the
> > double signed-off by tags. If the patch get's handed over between multiple
> > developers then multiple signed-off by's make sense. But since it is you that
> > handled the earlier patch also, I think one tag is enough with your new domain.
> > 
> > One more thing is, using codeaurora domain will bounce now. So, please use the
> > quicinc domain for Hemant also.
> 
> I'm aware of the bouncing.  Git send-email however is not, and its default
> behavior can be a bit annoying in this edge case.
> 
> I've seen the dual SoB by the same developer elsewhere in the community, but
> if you want things "cleaned up" to the new quic ids, I'll do that.

Double s-o-b's are common but in this case you handled the patch all the way and
you are still employed by the same employer. Only thing that changed is your
domain, so this makes me feel that single s-o-b is enough.

Thanks,
Mani
