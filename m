Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB8FC4C6FC1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 15:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237258AbiB1OoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 09:44:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234528AbiB1OoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 09:44:22 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6BCE275F6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 06:43:42 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id iq13-20020a17090afb4d00b001bc4437df2cso11557970pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 06:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GfploZQCnavoHHMaVgX62AjpvQD4w7GvytKlAGcRxOA=;
        b=IktNeqwTsyLMmTHrTSD6tn7vUkMomQpiiEWbsbZAm2tySUws7cZPxANnsLVhy7LdzU
         thUWbXBoCHMDHQ7mAjcinHp+b538WbKoaeHESEu3wFw0hz5fkBmbPE2OZoDDWm3xtlz9
         bb1neqbbyjpyobdRAX2bhlzXzhgeGir29Bz4aJYsHT4kX/AFb1CRGi+mtXB532Tjn1RC
         QXc0LhEp824Mq0rR8/mqcI7fxfqBI4A50AIaJYtTv4jPeHymiH+5KQJhlfsi9370tm70
         Hd2TGFDXdhtltCHwGz6XYJrSh1p/KmhLhnul75zDC9yg5sXpOQwLiGPvow4lU/1ZfoXR
         SqzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GfploZQCnavoHHMaVgX62AjpvQD4w7GvytKlAGcRxOA=;
        b=vBkpKic4ge/s5Q+GCAx5iWc9/F3rlyceS+TQ6UcOrxpksgXA5HdbzCob9lbqIuiOv0
         B2xwZnIRaphFMPp0/n+xzQEvciSyfiviQ3PtpHuvH5YXV/Wr7UmFV0mLdlzooI9ufyov
         OkBGSGgNHOcY9eBNPfgohS1q/qwT9LI9MY9f0SLCgRVVPuFZUYf/hYYpbxiewPzbS8Ci
         vrWUmxQpkAgallIQvSdGyQ0rBhZNG3RzdHm+GO3fEIyKcAXHJ3yzlOGIqWL1j/PFgcIU
         6U+CsXXTC3fJJ+sSnzvO+b/F5I8aBhw4/NNMRQr/CuwkUHrJEW10D/PzBOflYV0EJSuB
         41qw==
X-Gm-Message-State: AOAM531Q798emrn1PGASHTgmRJIm06h18ziWdNCpYmDE252rz7sRlXCN
        luy/WOHEfVF72k/UfYD3z8Cd
X-Google-Smtp-Source: ABdhPJxrQ24tgEDKvqEmFqdhbVLxNfzHfsiqhvbaWUkYWh9cbBVzlQwUi8txCIAjjyJUV+ixIPAX9Q==
X-Received: by 2002:a17:902:9a41:b0:149:a13f:af62 with SMTP id x1-20020a1709029a4100b00149a13faf62mr20571044plv.147.1646059421928;
        Mon, 28 Feb 2022 06:43:41 -0800 (PST)
Received: from workstation ([117.207.25.37])
        by smtp.gmail.com with ESMTPSA id g4-20020a625204000000b004f1063e3d6csm13148964pfb.125.2022.02.28.06.43.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Feb 2022 06:43:41 -0800 (PST)
Date:   Mon, 28 Feb 2022 20:13:36 +0530
From:   'Manivannan Sadhasivam' <manivannan.sadhasivam@linaro.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     "mhi@lists.linux.dev" <mhi@lists.linux.dev>,
        "quic_hemantk@quicinc.com" <quic_hemantk@quicinc.com>,
        "quic_bbhatt@quicinc.com" <quic_bbhatt@quicinc.com>,
        "quic_jhugo@quicinc.com" <quic_jhugo@quicinc.com>,
        "vinod.koul@linaro.org" <vinod.koul@linaro.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>,
        "quic_vbadigan@quicinc.com" <quic_vbadigan@quicinc.com>,
        "quic_cang@quicinc.com" <quic_cang@quicinc.com>,
        "quic_skananth@quicinc.com" <quic_skananth@quicinc.com>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "elder@linaro.org" <elder@linaro.org>
Subject: Re: [PATCH v4 05/27] bus: mhi: Use bitfield operations for handling
 DWORDs of ring elements
Message-ID: <20220228144336.GB12451@workstation>
References: <20220228124344.77359-1-manivannan.sadhasivam@linaro.org>
 <20220228124344.77359-6-manivannan.sadhasivam@linaro.org>
 <90b1d3954b8c4157a4045db82b562271@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90b1d3954b8c4157a4045db82b562271@AcuMS.aculab.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 02:00:07PM +0000, David Laight wrote:
> From: Manivannan Sadhasivam
> > Sent: 28 February 2022 12:43
> > 
> > Instead of using the hardcoded bits in DWORD definitions, let's use the
> > bitfield operations to make it more clear how the DWORDs are structured.
> 
> That all makes it as clear as mud.

It depends on how you see it ;)

For instance,

#define MHI_TRE_GET_CMD_TYPE(tre) ((MHI_TRE_GET_DWORD(tre, 1) >> 16) & 0xFF)

vs

#define MHI_TRE_GET_CMD_TYPE(tre) (FIELD_GET(GENMASK(23, 16), (MHI_TRE_GET_DWORD(tre, 1))))

The later one makes it more obvious that the "type" field resides between bit 23
and 16. Plus it avoids the extra masking.

> Try reading it!
> 

Well I did before sending the patch.

Thanks,
Mani

> 	David
> 
> > 
> > Suggested-by: Alex Elder <elder@linaro.org>
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/bus/mhi/host/internal.h | 58 +++++++++++++++++++--------------
> >  1 file changed, 33 insertions(+), 25 deletions(-)
> > 
> > diff --git a/drivers/bus/mhi/host/internal.h b/drivers/bus/mhi/host/internal.h
> > index 156bf65b6810..1d1790e83a93 100644
> > --- a/drivers/bus/mhi/host/internal.h
> > +++ b/drivers/bus/mhi/host/internal.h
> > @@ -7,6 +7,7 @@
> >  #ifndef _MHI_INT_H
> >  #define _MHI_INT_H
> > 
> > +#include <linux/bitfield.h>
> >  #include <linux/mhi.h>
> > 
> >  extern struct bus_type mhi_bus_type;
> > @@ -205,58 +206,65 @@ enum mhi_cmd_type {
> >  /* No operation command */
> >  #define MHI_TRE_CMD_NOOP_PTR (0)
> >  #define MHI_TRE_CMD_NOOP_DWORD0 (0)
> > -#define MHI_TRE_CMD_NOOP_DWORD1 (cpu_to_le32(MHI_CMD_NOP << 16))
> > +#define MHI_TRE_CMD_NOOP_DWORD1 (cpu_to_le32(FIELD_PREP(GENMASK(23, 16), MHI_CMD_NOP)))
> > 
> >  /* Channel reset command */
> >  #define MHI_TRE_CMD_RESET_PTR (0)
> >  #define MHI_TRE_CMD_RESET_DWORD0 (0)
> > -#define MHI_TRE_CMD_RESET_DWORD1(chid) (cpu_to_le32((chid << 24) | \
> > -					(MHI_CMD_RESET_CHAN << 16)))
> > +#define MHI_TRE_CMD_RESET_DWORD1(chid) (cpu_to_le32(FIELD_PREP(GENMASK(31, 24), chid)) | \
> > +					FIELD_PREP(GENMASK(23, 16), MHI_CMD_RESET_CHAN))
> > 
> >  /* Channel stop command */
> >  #define MHI_TRE_CMD_STOP_PTR (0)
> >  #define MHI_TRE_CMD_STOP_DWORD0 (0)
> > -#define MHI_TRE_CMD_STOP_DWORD1(chid) (cpu_to_le32((chid << 24) | \
> > -				       (MHI_CMD_STOP_CHAN << 16)))
> > +#define MHI_TRE_CMD_STOP_DWORD1(chid) (cpu_to_le32(FIELD_PREP(GENMASK(31, 24), chid)) | \
> > +					FIELD_PREP(GENMASK(23, 16), MHI_CMD_STOP_CHAN))
> > 
> >  /* Channel start command */
> >  #define MHI_TRE_CMD_START_PTR (0)
> >  #define MHI_TRE_CMD_START_DWORD0 (0)
> > -#define MHI_TRE_CMD_START_DWORD1(chid) (cpu_to_le32((chid << 24) | \
> > -					(MHI_CMD_START_CHAN << 16)))
> > +#define MHI_TRE_CMD_START_DWORD1(chid) (cpu_to_le32(FIELD_PREP(GENMASK(31, 24), chid)) | \
> > +					FIELD_PREP(GENMASK(23, 16), MHI_CMD_START_CHAN))
> > 
> >  #define MHI_TRE_GET_DWORD(tre, word) (le32_to_cpu((tre)->dword[(word)]))
> > -#define MHI_TRE_GET_CMD_CHID(tre) ((MHI_TRE_GET_DWORD(tre, 1) >> 24) & 0xFF)
> > -#define MHI_TRE_GET_CMD_TYPE(tre) ((MHI_TRE_GET_DWORD(tre, 1) >> 16) & 0xFF)
> > +#define MHI_TRE_GET_CMD_CHID(tre) (FIELD_GET(GENMASK(31, 24), (MHI_TRE_GET_DWORD(tre, 1))))
> > +#define MHI_TRE_GET_CMD_TYPE(tre) (FIELD_GET(GENMASK(23, 16), (MHI_TRE_GET_DWORD(tre, 1))))
> > 
> >  /* Event descriptor macros */
> >  #define MHI_TRE_EV_PTR(ptr) (cpu_to_le64(ptr))
> > -#define MHI_TRE_EV_DWORD0(code, len) (cpu_to_le32((code << 24) | len))
> > -#define MHI_TRE_EV_DWORD1(chid, type) (cpu_to_le32((chid << 24) | (type << 16)))
> > +#define MHI_TRE_EV_DWORD0(code, len) (cpu_to_le32(FIELD_PREP(GENMASK(31, 24), code) | \
> > +						FIELD_PREP(GENMASK(15, 0), len)))
> > +#define MHI_TRE_EV_DWORD1(chid, type) (cpu_to_le32(FIELD_PREP(GENMASK(31, 24), chid) | \
> > +						FIELD_PREP(GENMASK(23, 16), type)))
> >  #define MHI_TRE_GET_EV_PTR(tre) (le64_to_cpu((tre)->ptr))
> > -#define MHI_TRE_GET_EV_CODE(tre) ((MHI_TRE_GET_DWORD(tre, 0) >> 24) & 0xFF)
> > -#define MHI_TRE_GET_EV_LEN(tre) (MHI_TRE_GET_DWORD(tre, 0) & 0xFFFF)
> > -#define MHI_TRE_GET_EV_CHID(tre) ((MHI_TRE_GET_DWORD(tre, 1) >> 24) & 0xFF)
> > -#define MHI_TRE_GET_EV_TYPE(tre) ((MHI_TRE_GET_DWORD(tre, 1) >> 16) & 0xFF)
> > -#define MHI_TRE_GET_EV_STATE(tre) ((MHI_TRE_GET_DWORD(tre, 0) >> 24) & 0xFF)
> > -#define MHI_TRE_GET_EV_EXECENV(tre) ((MHI_TRE_GET_DWORD(tre, 0) >> 24) & 0xFF)
> > +#define MHI_TRE_GET_EV_CODE(tre) (FIELD_GET(GENMASK(31, 24), (MHI_TRE_GET_DWORD(tre, 0))))
> > +#define MHI_TRE_GET_EV_LEN(tre) (FIELD_GET(GENMASK(15, 0), (MHI_TRE_GET_DWORD(tre, 0))))
> > +#define MHI_TRE_GET_EV_CHID(tre) (FIELD_GET(GENMASK(31, 24), (MHI_TRE_GET_DWORD(tre, 1))))
> > +#define MHI_TRE_GET_EV_TYPE(tre) (FIELD_GET(GENMASK(23, 16), (MHI_TRE_GET_DWORD(tre, 1))))
> > +#define MHI_TRE_GET_EV_STATE(tre) (FIELD_GET(GENMASK(31, 24), (MHI_TRE_GET_DWORD(tre, 0))))
> > +#define MHI_TRE_GET_EV_EXECENV(tre) (FIELD_GET(GENMASK(31, 24), (MHI_TRE_GET_DWORD(tre, 0))))
> >  #define MHI_TRE_GET_EV_SEQ(tre) MHI_TRE_GET_DWORD(tre, 0)
> >  #define MHI_TRE_GET_EV_TIME(tre) (MHI_TRE_GET_EV_PTR(tre))
> >  #define MHI_TRE_GET_EV_COOKIE(tre) lower_32_bits(MHI_TRE_GET_EV_PTR(tre))
> > -#define MHI_TRE_GET_EV_VEID(tre) ((MHI_TRE_GET_DWORD(tre, 0) >> 16) & 0xFF)
> > -#define MHI_TRE_GET_EV_LINKSPEED(tre) ((MHI_TRE_GET_DWORD(tre, 1) >> 24) & 0xFF)
> > -#define MHI_TRE_GET_EV_LINKWIDTH(tre) (MHI_TRE_GET_DWORD(tre, 0) & 0xFF)
> > +#define MHI_TRE_GET_EV_VEID(tre) (FIELD_GET(GENMASK(23, 16), (MHI_TRE_GET_DWORD(tre, 0))))
> > +#define MHI_TRE_GET_EV_LINKSPEED(tre) (FIELD_GET(GENMASK(31, 24), (MHI_TRE_GET_DWORD(tre, 1))))
> > +#define MHI_TRE_GET_EV_LINKWIDTH(tre) (FIELD_GET(GENMASK(7, 0), (MHI_TRE_GET_DWORD(tre, 0))))
> > 
> >  /* Transfer descriptor macros */
> >  #define MHI_TRE_DATA_PTR(ptr) (cpu_to_le64(ptr))
> > -#define MHI_TRE_DATA_DWORD0(len) (cpu_to_le32(len & MHI_MAX_MTU))
> > -#define MHI_TRE_DATA_DWORD1(bei, ieot, ieob, chain) (cpu_to_le32((2 << 16) | (bei << 10) \
> > -	| (ieot << 9) | (ieob << 8) | chain))
> > +#define MHI_TRE_DATA_DWORD0(len) (cpu_to_le32(FIELD_PREP(GENMASK(15, 0), len)))
> > +#define MHI_TRE_TYPE_TRANSFER 2
> > +#define MHI_TRE_DATA_DWORD1(bei, ieot, ieob, chain) (cpu_to_le32(FIELD_PREP(GENMASK(23, 16), \
> > +							MHI_TRE_TYPE_TRANSFER) | \
> > +							FIELD_PREP(BIT(10), bei) | \
> > +							FIELD_PREP(BIT(9), ieot) | \
> > +							FIELD_PREP(BIT(8), ieob) | \
> > +							FIELD_PREP(BIT(0), chain)))
> > 
> >  /* RSC transfer descriptor macros */
> > -#define MHI_RSCTRE_DATA_PTR(ptr, len) (cpu_to_le64(((u64)len << 48) | ptr))
> > +#define MHI_RSCTRE_DATA_PTR(ptr, len) (cpu_to_le64(FIELD_PREP(GENMASK(64, 48), len) | ptr))
> >  #define MHI_RSCTRE_DATA_DWORD0(cookie) (cpu_to_le32(cookie))
> > -#define MHI_RSCTRE_DATA_DWORD1 (cpu_to_le32(MHI_PKT_TYPE_COALESCING << 16))
> > +#define MHI_RSCTRE_DATA_DWORD1 (cpu_to_le32(FIELD_PREP(GENMASK(23, 16), MHI_PKT_TYPE_COALESCING)
> > 
> >  enum mhi_pkt_type {
> >  	MHI_PKT_TYPE_INVALID = 0x0,
> > --
> > 2.25.1
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 
