Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A143F472D1B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 14:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237365AbhLMNWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 08:22:48 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.165]:27828 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231809AbhLMNWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 08:22:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1639401582;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=oXVz7j6O/sdvqTEmJzhaOnnNzeCFuCaYipshwhsdL/Q=;
    b=BCQNJer+iBZnxYMyTRXMMbQrkgmxAC1RqtoT3/g9wCPqC+c7cHTtDqAclvXOZUwGgP
    qcvxWtN5OE7qeBtN8fSMnwIdw6EjF/FJfYrJo723/1aD4HO4Us9AktnXT5W1/jAjsSL3
    IbIpIHOUob281s5DXg93H22UTpHO23kbfyfyFoL6n525Ogkte1GW9f8QovS4XZOMPmju
    7HuzzUpLuJKS8sG3Re0JFP5uOzUl8QYv4Hj2gBYac74oYuuhYUube0GWFhYRXaCQhDh4
    LJqJL4qU3rtDONERW3/jc20za0b3eEDUI959TJoRcv9iHBrfQq6X5oQEula8O3Ozr+Kj
    aIPg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u267FZF9PwpcNKLVrKw5+aY="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 47.35.3 SBL|AUTH)
    with ESMTPSA id j080d2xBDDJgK7d
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 13 Dec 2021 14:19:42 +0100 (CET)
Date:   Mon, 13 Dec 2021 14:19:38 +0100
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     robh+dt@kernel.org, gregkh@linuxfoundation.org,
        devicetree@vger.kernel.org, ekangupt@qti.qualcomm.com,
        jeyr@codeaurora.org, bkumar@qti.qualcomm.com,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 5/8] dt-bindings: misc: add property to support
 non-secure DSP
Message-ID: <YbdIas4QE1z7alAc@gerhold.net>
References: <20211209120626.26373-1-srinivas.kandagatla@linaro.org>
 <20211209120626.26373-6-srinivas.kandagatla@linaro.org>
 <YbcnEp5+4y5qXC60@gerhold.net>
 <ac2e9f8f-ea52-5676-baaa-9439e8b35d8f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac2e9f8f-ea52-5676-baaa-9439e8b35d8f@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 12:35:40PM +0000, Srinivas Kandagatla wrote:
> On 13/12/2021 10:57, Stephan Gerhold wrote:
> > On Thu, Dec 09, 2021 at 12:06:23PM +0000, Srinivas Kandagatla wrote:
> > > From: Jeya R <jeyr@codeaurora.org>
> > > 
> > > Add property to set DSP domain as non-secure.
> > > 
> > > ADSP/MDSP/SDSP are by default secured, where as CDSP can be either be
> > > secured/unsecured.
> > 
> > Wouldn't it be easier to avoid the negation and add a "qcom,secure-domain"
> > property instead? Given PATCH 8/8 ("arm64: dts: qcom: add non-secure
> > domain property to fastrpc nodes") it looks like you are intentionally
> > breaking DT compatibility here, but this patch does not justify why this
> > is necessary.
> 
> By default all ADSP/MDSP/SDSP are secured, so this property is only required
> for something that is not default. Only case that is configurable is the
> CDSP case where in by adding this flag we should be able to load an unsigned
> process to dsp using unsecured node.
> 
> Having said that, TBH When we first added the fastrpc patchset we did not
> take care of this security feature properly :-)
> 
> From security point of view, its better to keep the default as secured
> rather than unsecured in DT too.
> 
> With this DTS patch older dts should continue to work.
> 

Is this a "default" on newer platforms only? Why do the existing
platforms not use the "secure" setup then? Or is this perhaps firmware
version/configuration specific?

Basically I'm confused because you say that the "default" is the secured
setup, but DT patch (8/8) suggests that non-secure is the default on
pretty much all currently supported platforms (msm8916, sdm845, sm8150,
sm8250, sm8350). :)

Thanks,
Stephan
