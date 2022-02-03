Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 151C74A8260
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 11:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349828AbiBCKex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 05:34:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349745AbiBCKev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 05:34:51 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F94C06173B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 02:34:51 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id i65so1843129pfc.9
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 02:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YUz06pZnKz52lqRpYNAE/X72JjI+Vf6k4/BCrzBH3FU=;
        b=UiyejmSz8yF32Lluhet7PwBZMrAziRCNepEXHIRQlOebPKYaQ8xt4lol4zyxxQHa/Q
         CNWjJSte15D181ytzgj3PLcj5+ELoliMZD89UtGx38yFcahG0MiDDJA1doOLInEAr8ah
         LsRKIOE+IfpQfIHa+RxnrPufXugbm5olIQbixPUcEQX7WZtpSoYxj73GznqwAW+gNCdc
         Dd2IVudc1Nzg56St5hqWcSKMmDMGlEyuZgxCHwqAeA+4sxNcuS+sftySZMFJraqZCuOC
         8ruvRCgfz9JW22ScJNYrirO4KHyEi988ltI9VsZdp6UdpD62mZ9QRBjiHNawA3Gh65Uf
         xQBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YUz06pZnKz52lqRpYNAE/X72JjI+Vf6k4/BCrzBH3FU=;
        b=n7Qz8i927Jo+9fz8rto18D+6/SsZBQtG1xNbxSxmXpEV2560qtcSM+h8YTiDEcjMuz
         Vpi0MSwhp0ZXLJz4sR74GGtfcXX4qWRN72at4eKbBYwMeQo8J7LGNAc0c4zdNL8rsnai
         DWc172bVXFgbAgqVSDro1d9NADgWkp7FxnCJt9Gz7bu/2d51EohwVxXx0EdhnECC0kCs
         ZxQ8qk57rh+gD/+JvxtBF9tgIor8HacYr3hkUAzrypCLXgcAmBNKa3EudR/kLXshQSuX
         zou7RpcgAqa68ec9heTTEZH/BrNfVPHpnRcnHjR5A9+RcgI6oJJ4MN3QK+Sl3cYN0zC6
         G3tw==
X-Gm-Message-State: AOAM532HLbVXu+vs4FiMegPE5vZW0fLHVaKiOZqY0bhifNoSO3dnKVbW
        aM7RJgeRuicOlxrGK80gl2z7
X-Google-Smtp-Source: ABdhPJzrwgJPFeeQitXNGNkm/WAGb5B3nYHnSFQ8Z1cdKI47rjuG824pm5t6p2DPKTjVrvwLezE0Fw==
X-Received: by 2002:a63:5460:: with SMTP id e32mr27756006pgm.330.1643884490874;
        Thu, 03 Feb 2022 02:34:50 -0800 (PST)
Received: from thinkpad ([117.217.179.179])
        by smtp.gmail.com with ESMTPSA id m21sm29694312pfk.26.2022.02.03.02.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 02:34:50 -0800 (PST)
Date:   Thu, 3 Feb 2022 16:04:44 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Alex Elder <elder@ieee.org>
Cc:     mhi@lists.linux.dev, hemantk@codeaurora.org, bbhatt@codeaurora.org,
        quic_jhugo@quicinc.com, vinod.koul@linaro.org,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        skananth@codeaurora.org, vpernami@codeaurora.org,
        vbadigan@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/20] bus: mhi: Make mhi_state_str[] array static const
 and move to common.h
Message-ID: <20220203103444.GB6298@thinkpad>
References: <20211202113553.238011-1-manivannan.sadhasivam@linaro.org>
 <20211202113553.238011-4-manivannan.sadhasivam@linaro.org>
 <0d850b27-5684-2ecf-fc96-3258c0462d3d@ieee.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d850b27-5684-2ecf-fc96-3258c0462d3d@ieee.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2022 at 06:22:59PM -0600, Alex Elder wrote:
> On 12/2/21 5:35 AM, Manivannan Sadhasivam wrote:
> > mhi_state_str[] array could be used by MHI endpoint stack also. So let's
> > make the array as "static const" and move it inside the "common.h" header
> > so that the endpoint stack could also make use of it. Otherwise, the
> > structure definition should be present in both host and endpoint stack and
> > that'll result in duplication.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> This result in common source code (which is good), but it will be
> duplicated in everything that includes this file.
> 
> Do you have no common code, available to both the endpoint and host?
> You could (in drivers/bus/mhi/common.c, for example).
> 
> If you don't, I have a different suggestion, below.  It does
> basically the same thing you're doing here, but I much prefer
> duplicating an inline function than a data structure.
> 
> > ---
> >   drivers/bus/mhi/common.h    | 13 ++++++++++++-
> >   drivers/bus/mhi/host/init.c | 12 ------------
> >   2 files changed, 12 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/bus/mhi/common.h b/drivers/bus/mhi/common.h
> > index 0f4f3b9f3027..2ea438205617 100644
> > --- a/drivers/bus/mhi/common.h
> > +++ b/drivers/bus/mhi/common.h
> > @@ -174,7 +174,18 @@ struct mhi_cmd_ctxt {
> >   	__u64 wp __packed __aligned(4);
> >   };
> > -extern const char * const mhi_state_str[MHI_STATE_MAX];
> > +static const char * const mhi_state_str[MHI_STATE_MAX] = {
> > +	[MHI_STATE_RESET] = "RESET",
> > +	[MHI_STATE_READY] = "READY",
> > +	[MHI_STATE_M0] = "M0",
> > +	[MHI_STATE_M1] = "M1",
> > +	[MHI_STATE_M2] = "M2",
> > +	[MHI_STATE_M3] = "M3",
> > +	[MHI_STATE_M3_FAST] = "M3 FAST",
> > +	[MHI_STATE_BHI] = "BHI",
> > +	[MHI_STATE_SYS_ERR] = "SYS ERROR",
> > +};
> > +
> >   #define TO_MHI_STATE_STR(state) ((state >= MHI_STATE_MAX || \
> >   				  !mhi_state_str[state]) ? \
> >   				"INVALID_STATE" : mhi_state_str[state])
> 
> You could easily and safely define this as an inline function instead.
> 

Sounds good!

> #define MHI_STATE_CASE(x)	case MHI_STATE_ ## x: return #x
> static inline const char *mhi_state_string(enum mhi_state state)
> {
> 	switch(state) {
> 	MHI_STATE_CASE(RESET);
> 	MHI_STATE_CASE(READY);
> 	MHI_STATE_CASE(M0);
> 	MHI_STATE_CASE(M1);
> 	MHI_STATE_CASE(M2);
> 	MHI_STATE_CASE(M3_FAST);
> 	MHI_STATE_CASE(BHI);
> 	MHI_STATE_CASE(SYS_ERR);
> 	default: return "(unrecognized MHI state)";
> 	}
> }
> #undef MHI_STATE_CASE

I've used the below one:

static inline const char * const mhi_state_str(enum mhi_state state)
{
        switch(state) {
        case MHI_STATE_RESET:
                return "RESET";
        case MHI_STATE_READY:
                return "READY";
        case MHI_STATE_M0:
                return "M0";
        case MHI_STATE_M1:
                return "M1";
        case MHI_STATE_M2:
                return"M2";
        case MHI_STATE_M3:
                return"M3";
        case MHI_STATE_M3_FAST:
                return"M3 FAST";
        case MHI_STATE_BHI:
                return"BHI";
        case MHI_STATE_SYS_ERR:
                return "SYS ERROR";
        default:
                return "Unknown state";
        }
};

Thanks,
Mani

> 
> 					-Alex
> 
> > diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
> > index 5aaca6d0f52b..fa904e7468d8 100644
> > --- a/drivers/bus/mhi/host/init.c
> > +++ b/drivers/bus/mhi/host/init.c
> > @@ -44,18 +44,6 @@ const char * const dev_state_tran_str[DEV_ST_TRANSITION_MAX] = {
> >   	[DEV_ST_TRANSITION_DISABLE] = "DISABLE",
> >   };
> > -const char * const mhi_state_str[MHI_STATE_MAX] = {
> > -	[MHI_STATE_RESET] = "RESET",
> > -	[MHI_STATE_READY] = "READY",
> > -	[MHI_STATE_M0] = "M0",
> > -	[MHI_STATE_M1] = "M1",
> > -	[MHI_STATE_M2] = "M2",
> > -	[MHI_STATE_M3] = "M3",
> > -	[MHI_STATE_M3_FAST] = "M3 FAST",
> > -	[MHI_STATE_BHI] = "BHI",
> > -	[MHI_STATE_SYS_ERR] = "SYS ERROR",
> > -};
> > -
> >   const char * const mhi_ch_state_type_str[MHI_CH_STATE_TYPE_MAX] = {
> >   	[MHI_CH_STATE_TYPE_RESET] = "RESET",
> >   	[MHI_CH_STATE_TYPE_STOP] = "STOP",
> > 
> 
