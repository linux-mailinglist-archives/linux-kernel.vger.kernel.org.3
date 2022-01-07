Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD22487A18
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 17:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348174AbiAGQC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 11:02:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348161AbiAGQC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 11:02:56 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E57C06173F
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 08:02:56 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id w19-20020a056830061300b0058f1dd48932so7013043oti.11
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 08:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=gZBW2/flvQ2NdF5hDsI0zPW9aTZhIeh2D6Bq7nrP3As=;
        b=t08/8rcjKEFS01FodQemSpCn4DXs8X6KDsqLbHOXRYocZAG5dRP3vSozIqcqwAJ6ln
         j7v7u6nK6GtuXuyjmmhX19oBbd78BcPSoo36kl+WewDuLLAoJevAaGQm3mLtAT7jM1Pv
         ltyevByddtOjxA9FYv3/BYCsiwLJfJ2TCudT+OYKesPCKDYf5/Z1INqItITbmBTlPuYe
         C1GswOAB3RhqGLaWhRwIk84xMw+BRKp21J8p8yxw9IXBb/H9k1+FVUvwZSXad9GjowMX
         2+rtkidJeUHLcG7k+a5WaS31O8+1QNWsgrGXBRQJN2fyP+PqElmLYk+5xCdj2IGOWXum
         Uf1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=gZBW2/flvQ2NdF5hDsI0zPW9aTZhIeh2D6Bq7nrP3As=;
        b=pHJU8Emi9GKo+odqo87iGn2DFrNtvCVBiET5K3ooh9DpIf86vkeLY+sx10JVAfvtpG
         CWXoncBxFJQF13sDCecrxQgnbPJJV7BP7ym7pUThJUI+KJtMrzr5N6K6xhSWGAjjU78g
         CPj+YZggLiO8HaP100UeLftnlLaP0g/4ZEFtpBEhIbz/uUxjcChxD4yjoB3n+ofRP4Xi
         Hs3hiv9HksuJTy8XBavr1wM3MJrWwrX6Yb7fugye4gV40cVLyE4463mJ3gepj9uzWjkj
         bECvvXiRXdLiDvb9R2voBg0bmLtppjxvLZxJ6oeczwnT7L1p4ia5O2+PsMQS9szERq90
         pjRQ==
X-Gm-Message-State: AOAM531tlH90DxgxXvjTIXIQ7YCss7N0xp97qH56tj6vXlf1IyF6bUHw
        mdQjwvhbL26X3q6Y3gHAqVcojts3EGJd1g==
X-Google-Smtp-Source: ABdhPJyhZaR12yPuk9JnVjyI0IUjv7LheeaRzWkyB3MBGk08AygTkO6lC5AHtMWGNJHphihyEzIE9A==
X-Received: by 2002:a9d:7409:: with SMTP id n9mr1275023otk.80.1641571374360;
        Fri, 07 Jan 2022 08:02:54 -0800 (PST)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id a2sm908176oon.37.2022.01.07.08.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 08:02:53 -0800 (PST)
Date:   Fri, 7 Jan 2022 08:03:41 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Cc:     Thara Gopinath <thara.gopinath@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>, vkoul@kernel.org
Subject: Re: [PATCH V6 0/7] Add driver support for Data Capture and Compare
 Engine(DCC) for SM8150,SC7280,SC7180,SDM845
Message-ID: <YdhkXRxUQGRRZEsx@ripper>
References: <cover.1628617260.git.schowdhu@codeaurora.org>
 <396edd95-4f38-6830-99da-11e73d62a0cf@linaro.org>
 <705c280b-bced-476d-8e21-1a5afbf3d2f3@quicinc.com>
 <YdeDtlmPRQx3FU9i@ripper>
 <84d36c7f-d75e-61f9-7670-c651cc50d083@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <84d36c7f-d75e-61f9-7670-c651cc50d083@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 07 Jan 07:43 PST 2022, Souradeep Chowdhury wrote:

> 
> On 1/7/2022 5:35 AM, Bjorn Andersson wrote:
> > On Thu 06 Jan 07:20 PST 2022, Souradeep Chowdhury wrote:
> > 
> > > On 12/16/2021 9:18 PM, Thara Gopinath wrote:
> > > > 
> > > > On 8/10/21 1:54 PM, Souradeep Chowdhury wrote:
> > > > > DCC(Data Capture and Compare) is a DMA engine designed for debugging
> > > > > purposes.In case of a system
> > > > > crash or manual software triggers by the user the DCC hardware
> > > > > stores the value at the register
> > > > > addresses which can be used for debugging purposes.The DCC driver
> > > > > provides the user with sysfs
> > > > > interface to configure the register addresses.The options that the
> > > > > DCC hardware provides include
> > > > > reading from registers,writing to registers,first reading and then
> > > > > writing to registers and looping
> > > > > through the values of the same register.
> > > > > 
> > > > > In certain cases a register write needs to be executed for accessing
> > > > > the rest of the registers,
> > > > > also the user might want to record the changing values of a register
> > > > > with time for which he has the
> > > > > option to use the loop feature.
> > > > Hello Souradeep,
> > > > 
> > > > First of all, I think this is very a useful feature to have. I have some
> > > > generic design related queries/comments on driver and the interface
> > > > exposed to the user space. Also, I do not understand the h/w well here,
> > > > so feel free to correct me if I am wrong.
> > > > 
> > > > 1. Linked list looks like a very internal feature to the h/w. It really
> > > > is not an info that user should be aware of. I tried reading the code a
> > > > bit. IUC, every time a s/w trigger is issued the configs in all the
> > > > enabled linked lists are executed. The final ram dump that you get from
> > > > /dev/dcc_sram is a dump of contents from all the enabled list? Is this
> > > > understanding correct ? And we are talking of at-most 4 linked list?
> > > > If yes, I think it might be better to have a folder per linked list with
> > > > config, config_write etc. Also if possible it will be better to dump the
> > > > results to a file in the specific folder instead of reading from
> > > > /dev/dcc_sram.
> > > > If no, there is no real need for user to know the linked list, right?
> > > > Choosing of linked list can be done by kernel driver in this case with
> > > > no input needed from user.
> > > > 
> > > > 2. Now to the sysfs interface itself, I know lot of thought has gone
> > > > into sysfs vs debugfs considerations. But, have you considered using
> > > > netlink interface instead of sysfs. Netlink interface is used for
> > > > asynchronous communication between kernel and user space. In case of
> > > > DCC, the communication appears to be asynchronous, where in user asks
> > > > the kernel to capture some info and kernel can indicate back to user
> > > > when the info is captured. Also the entire mess surrounding echoing addr
> > > > / value / offset repeatedly into a sysfs entry can be avoided using
> > > > netlink interface.
> > > > 
> > > Hello Thara,
> > > 
> > > Thanks for your review comments. Following are some points from my end
> > > 
> > > 
> > > 1) Each linked list represent a particular block of memory in DCC_SRAM which
> > > is preserved for that particular list. That is why offset calculation is
> > > done on the driver based on the linked list chosen by the user.
> > > 
> > >      This choice needs to be made by the user since the number for the linked
> > > list chosen is specific to the registers used to debug a particular
> > > component.  Also we are giving the user flexibility to configure multiple
> > > 
> > >      linked lists at one go so that even if we don't have a separate folder
> > > for it , the dumps are collected as a separate list of registers. Also there
> > > are certain curr_list values which may be supported by the dcc
> > > 
> > >      hardware but may not be accessible to the user and so the choice cannot
> > > be made arbitrarily from the driver.
> > > 
> > But in the end, as you write out the SRAM content, is there really any
> > linked lists? Afaict it's just a sequence of operations/commands. The
> > linked list part seems to be your data structure of choice to keep track
> > of these operations in the driver before flushing them out.
> 
> That is correct, the linked list defined in the driver is for storing the
> addresses sequentially in DCC_SRAM and is just an internal
> data structure of the driver. However, there is also a "list" from DCC
> hardware perspective. The following driver code shows how
> a list is initiated with the beginning and end sram offset so that DCC
> hardware can treat it as a separate list of addresses and dump
> the values separately.
> 

Makes sense. But I think you should use "list" (or "sequence") and not
"linked list" in the API/documentation then.

>               /* 1. Take ownership of the list */
>                 dcc_writel(drvdata, BIT(0), DCC_LL_LOCK(list));
> 
>                 /* 2. Program linked-list in the SRAM */
>                 ram_cfg_base = drvdata->ram_cfg;
>                 ret = __dcc_ll_cfg(drvdata, list);
>                 if (ret) {
>                         dcc_writel(drvdata, 0, DCC_LL_LOCK(list));
>                         goto err;
>                 }
> 
>                 /* 3. program DCC_RAM_CFG reg */
>                 dcc_writel(drvdata, ram_cfg_base +
>                         drvdata->ram_offset/4, DCC_LL_BASE(list));
>                 dcc_writel(drvdata, drvdata->ram_start +
>                         drvdata->ram_offset/4, DCC_FD_BASE(list));
>                 dcc_writel(drvdata, 0xFFF, DCC_LL_TIMEOUT(list));
> 
>                 /* 4. Clears interrupt status register */
>                 dcc_writel(drvdata, 0, DCC_LL_INT_ENABLE(list));
>                 dcc_writel(drvdata, (BIT(0) | BIT(1) | BIT(2)),
>                                         DCC_LL_INT_STATUS(list));
> 
>                 drvdata->enable[list] = true;
> 
> So when user enters multiple lists, the DCC hardware will process it as
> separate group of register values.
> 

But as the DCC supports reading, writing, looping and rmw I don't think
it's correct to say that a list is a "group of register values". It's a
"sequence (or list) of operations".

Regards,
Bjorn

> > 
> > Regards,
> > Bjorn
> > 
> > > 2) From opensource, I can see that Netlink has been used in most of the
> > > cases where we need to notify stats to the user by taking the advantage of
> > > asynchronous communication. In this case, that requirement is not
> > > 
> > >      there since it is mostly one way communication from user to kernel. Also
> > > since this is used for debugging purposes perhaps sysfs adds more
> > > reliability than Netlink. In case of Netlink we have the additional
> > > 
> > >       overhead of dealing with socket calls. Let me know otherwise.
> > > 
> > > 
> > > Thanks,
> > > 
> > > Souradeep
> > > 
> > > 
> > > 
> > > 
> > > 
