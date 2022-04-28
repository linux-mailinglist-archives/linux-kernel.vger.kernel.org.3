Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D26513A55
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 18:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350350AbiD1Qwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 12:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233777AbiD1Qwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 12:52:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B126DB42D3;
        Thu, 28 Apr 2022 09:49:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5B1E9B82EF7;
        Thu, 28 Apr 2022 16:49:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C73CC385A0;
        Thu, 28 Apr 2022 16:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651164569;
        bh=0tomC2DKcOPuXKFy6eaQw+vsGVGrm4Gq16CTFSUFEpA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VWiy/lqTK107yNPXbJuYdP7kbSF7lXtyB/ON0fsJ3nkxp0J91o4cmgygvYzR831oh
         uHy4BlOqYb13KY+QudkguElAsiiVuRgP/FbQnkZjdxOqBkPhhKK5JLEokn9Nv6UplH
         L8FEl1dcRQ5JFd9PHr03AEAtTZbxLyWpPrrNBuwU=
Date:   Thu, 28 Apr 2022 18:49:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Trilok Soni <quic_tsoni@quicinc.com>
Cc:     Sai Prakash Ranjan <quic_saipraka@quicinc.com>, arnd@arndb.de,
        catalin.marinas@arm.com, rostedt@goodmis.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        maz@kernel.org, quic_psodagud@quicinc.com, will@kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCHv12 8/9] serial: qcom_geni_serial: Disable MMIO tracing
 for geni serial
Message-ID: <YmrFlce26p2uvtDZ@kroah.com>
References: <cover.1651139070.git.quic_saipraka@quicinc.com>
 <3fef68a94e4947d58a199709929d30e0e2bf2e44.1651139070.git.quic_saipraka@quicinc.com>
 <Ympxa0ZY0VxZGEjA@kroah.com>
 <e11455d8-78c2-68e8-215e-a4e3587f3e4a@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e11455d8-78c2-68e8-215e-a4e3587f3e4a@quicinc.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 09:31:43AM -0700, Trilok Soni wrote:
> On 4/28/2022 3:50 AM, Greg KH wrote:
> > On Thu, Apr 28, 2022 at 03:25:31PM +0530, Sai Prakash Ranjan wrote:
> > > Disable MMIO tracing for geni serial driver as it is a high
> > > frequency operation for serial driver with many register reads/
> > > writes and not very useful to log all MMIO traces and prevent
> > > excessive logging.
> > > 
> > > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > Signed-off-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
> > > ---
> > >   drivers/tty/serial/qcom_geni_serial.c | 8 +++++++-
> > >   1 file changed, 7 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> > > index 1543a6028856..5b48e6c2bf3c 100644
> > > --- a/drivers/tty/serial/qcom_geni_serial.c
> > > +++ b/drivers/tty/serial/qcom_geni_serial.c
> > > @@ -1,5 +1,11 @@
> > >   // SPDX-License-Identifier: GPL-2.0
> > > -// Copyright (c) 2017-2018, The Linux foundation. All rights reserved.
> > > +/*
> > > + * Copyright (c) 2017-2018, The Linux Foundation. All rights reserved.
> > > + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
> > > + */
> > 
> > I strongly disagree that adding a single line here warrants a copyright
> > update.  If your lawyers will sign off on this change, I am willing to
> > reconsider.
> 
> I am not a lawyer, we can skip adding QuIC copyright here since it is just
> one line change, but at the same time we can't add 2022 year in the existing
> copyright.

That is correct, because you are not making a copyrightable change,
otherwise the single line addition would be ok.

Talk to your lawyers about this :)

> If that is fine, we can skip the copyright year update entirely.

Please do.

thanks,

greg k-h
