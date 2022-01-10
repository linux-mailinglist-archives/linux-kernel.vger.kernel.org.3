Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60788489FE4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 20:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243217AbiAJTJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 14:09:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242355AbiAJTJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 14:09:20 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131D4C061748
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 11:09:20 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id w80so19961766oie.9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 11:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=idN74tibQylFiXutvVDrzwyT0hxfY8VT8xXi4bT3S8Q=;
        b=AxcLtTAanTiUqsMqD/BViiv8NMCDHdJymo3vnBBv/sbOrEjz3/YMNe96CERt12zOCD
         VpqmHUvgdxRqxRxGtzLv5o8X5CvxrSBkauFpFmpMX2oCuNExFHmaVP/gfqtbiflOcv30
         tHlI5hRk/Cmel0Cr7PxBazPCBh41tdGU7lqh96KSDUoTURxESUFEkyc7z+nRD9wrtwJu
         AMHl3iAx3NzRr1qoC56cxtA9gY0+1q4iwwQ6/s+AA9EyUxiylMg+HhHR/XEtGqcsyoQ3
         368yn+E9ASAoVsbiWUdCM/LcInNrIldhvPD6FHhVh7jVBcacW2QL6o1dlBSa4seaP+5T
         NgeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=idN74tibQylFiXutvVDrzwyT0hxfY8VT8xXi4bT3S8Q=;
        b=k7/074U7rZyb2pD9qbnHm/edypTL8DYfdutueJOghIqFX9B4jKFnACLVGA5loq4tz5
         ofH85DUOexgkBIHxDjjwFqQjWnizmda4ZDmF4FKooIWGI66I/FmKrJU/OsmfzDBbaLt0
         FVH3fE3Wj+AmxloU244Hybifcc2wsySMzaAjtO1LXw5oA1+gH4GIYDtsJcYC+NkYxdmC
         s+AZ0huPGwEenH+8JBdJOE/jb9DQAp/AFtCV9IVd4hIqKghwjxoATc4IxkGzzDAmj9WE
         JSH1IvkRcw5wXj3J82J+q7hZwe8BPDgyjOqTIJVZRCI9czyIslvhOvBtggaLuWv55+uR
         pKmA==
X-Gm-Message-State: AOAM5330qPRe2aVwEqyjcalPy0Um5y4q3ptosmILz0MEJtCIKiL5SqjA
        TZ7ONFG7n0PmjlQCq4lUx2qZvA==
X-Google-Smtp-Source: ABdhPJyvKczm5X8Lm4wBPiUcnfxxpBfrfp1f7Bb+mt8WT8A/QQJ1WOgRkJ01srv4AUDzr5lWtIHRMw==
X-Received: by 2002:a54:468b:: with SMTP id k11mr655957oic.105.1641841759427;
        Mon, 10 Jan 2022 11:09:19 -0800 (PST)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 2sm1636619otm.41.2022.01.10.11.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 11:09:18 -0800 (PST)
Date:   Mon, 10 Jan 2022 11:10:03 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sandeep Maheswaram <quic_c_sanm@quicinc.com>
Cc:     Stephen Boyd <swboyd@chromium.org>, Andy Gross <agross@kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_pkondeti@quicinc.com,
        quic_ppratap@quicinc.com
Subject: Re: [PATCH v2] arm64: qcom: sc7280: Move USB2 controller nodes from
 common dtsi to SKU1
Message-ID: <YdyEi2I0XFp6DPh1@ripper>
References: <1638422248-24221-1-git-send-email-quic_c_sanm@quicinc.com>
 <CAE-0n51S7gPnkgL40Lqj-8dgZ-jjfCmNGtnUDgqJ_Kw5dzc_sg@mail.gmail.com>
 <e605c057-a7a4-657a-06ee-f872e13e116e@quicinc.com>
 <135e8171-c210-1f70-e26f-167f8fdfcc74@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <135e8171-c210-1f70-e26f-167f8fdfcc74@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 09 Jan 20:56 PST 2022, Sandeep Maheswaram wrote:

> Hi Bjorn,
> 
> On 12/15/2021 11:18 AM, Sandeep Maheswaram wrote:
> > Hi Bjorn,
> > 
> > On 12/3/2021 4:22 AM, Stephen Boyd wrote:
> > > Quoting Sandeep Maheswaram (2021-12-01 21:17:28)
> > > > Move USB2 controller and phy nodes from common dtsi file as it is
> > > > required only for SKU1 board and change the mode to host mode as
> > > > it will be used in host mode for SKU1.
> > > > 
> > > > Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> > > > ---
> > > Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> > Can you merge this change in qcom tree?
> 
> Is this patch merged in qcom tree ? If not can you please do so.
> 

Sorry, I seem to have missed this in the patch list. Will pick it up for
v5.18.

Thanks,
Bjorn
