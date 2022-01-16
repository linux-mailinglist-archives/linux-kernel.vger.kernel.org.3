Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01B2848FDE1
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 17:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233824AbiAPQbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 11:31:08 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.50]:33759 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbiAPQbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 11:31:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1642350648;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=wd5B5q6uhmXCkTltl4oPLre+b0CAXOOsrH3DYJLPWOk=;
    b=QAyRW1JmAAA/yFoj8X3QlSMfV7J/1fZy54Yx3ak5/iNi9bBnRjTZ0qdv2HRCVFrQeH
    4I9sz6VMbpxUQOhW874t2uU7b+e+pkg9hOpqKlo8sy+eGHj5CMVFdSQrAUEgNkj4ko1a
    +//H9KPf6J9h/viwiQOokXiVltBL/RziMlcqLcyRLAIDnTGiOFY5mqGVGmhdK+R0DkTz
    UbLMgs+VUrIn5piPwwXZXhDJ7ggj2l/dUCJ/ZReyuW2PRPpX2rdRpICmDN9XGTLvUGxJ
    4lyglW81xWiXjBh7BIzt/MjXtU7CupYK6pceuw04NaqNn/qWpawq+FnenPnkDAgKJT5Q
    T5Vw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u267FZF9PwpcNKLVrK8+86Y="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 47.37.6 AUTH)
    with ESMTPSA id h68d06y0GGUk8zU
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sun, 16 Jan 2022 17:30:46 +0100 (CET)
Date:   Sun, 16 Jan 2022 17:30:39 +0100
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 09/15] rpmsg: smd: Drop unnecessary condition for channel
 creation
Message-ID: <YeRILypv8ajssNae@gerhold.net>
References: <20220112194118.178026-1-luca@z3ntu.xyz>
 <20220112194118.178026-10-luca@z3ntu.xyz>
 <Yd9KebiZUjTuHtIM@gerhold.net>
 <12385151.O9o76ZdvQC@g550jk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <12385151.O9o76ZdvQC@g550jk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 16, 2022 at 05:08:29PM +0100, Luca Weiss wrote:
> On Mittwoch, 12. Jänner 2022 22:39:53 CET Stephan Gerhold wrote:
> > On Wed, Jan 12, 2022 at 08:40:58PM +0100, Luca Weiss wrote:
> > > From: Vladimir Lypak <vladimir.lypak@gmail.com>
> > > 
> > > RPM Firmware on variety of newer SoCs such as MSM8917 (also likely
> > > MSM8937, MSM8940, MSM8952), MSM8953 and on some MSM8916 devices) doesn't
> > > initiate opening of the SMD channel if it was previously opened by
> > > bootloader. This doesn't allow probing of smd-rpm driver on such devices
> > > because there is a check that requires RPM this behaviour.
> > > 
> > > Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
> > > Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> > > Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> > 
> > This is effectively a "Revert "Revert "rpmsg: smd: Create device for all
> > channels""":
> > 
> > https://lore.kernel.org/linux-arm-msm/20171212235857.10432-3-bjorn.andersson
> > @linaro.org/
> > https://lore.kernel.org/linux-arm-msm/20180315181244.8859-1-bjorn.andersson
> > @linaro.org/
> > 
> > Won't this cause the same regression reported by Srinivas again?
> > 
> 
> Do you have any suggestion on another way to solve this? Without this commit 
> the regulators just won't probe at all, I haven't looked very deep into it 
> though given this patch solves it.
> 
> I guess worst case it'll become a devicetree property to enable this quirk?
> 

My spontaneous suggestion would be to skip the check only for the
"rpm_requests" channel, e.g. something like

	if (remote_state != SMD_CHANNEL_OPENING &&
	    remote_state != SMD_CHANNEL_OPENED &&
	    strcmp(channel->name, "rpm_requests")
		continue;

This will avoid changing the behavior for anything but the RPM channel.
I don't think anything else is affected by the same problem (since the
bootloader or earlier firmware should not make use of any other channel).
Also, we definitely *always* want to open the channel to the RPM because
otherwise almost everything breaks.

Many solutions are possible though so at the end it is mostly up to
Bjorn to decide I think. :)

Thanks,
Stephan
