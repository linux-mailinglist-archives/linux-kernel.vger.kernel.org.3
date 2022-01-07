Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD5284879FE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 16:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348161AbiAGP4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 10:56:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233290AbiAGP4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 10:56:25 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B279AC06173F
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 07:56:24 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id h5-20020a9d6a45000000b005908066fa64so6138712otn.7
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 07:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=4UEj+Bd+UZxpb6+13xzUnRXx4XQV/BsazNWfQXf6uWk=;
        b=ku0s0jiEX2FuNrLzb7KkrJ0fNQiyqu9gG2XAcdSCTVQRDqubpSiBirr7pOkZDAJKpu
         gMPp3j62vb4sXmdzxkcjDGP502muoCyfs2MmhXXQAtHo7aMah4V4dSQpRqlwWEDCV+PU
         EKRCiEwoc3o1Ce/HL9IYNMrtrVJ+GioS6NOoLsZ5F5Tb+pkbqHLxPw1qvGB62qdDzSPt
         lSrzqaSHzQGjhF5VV+XryUQyg7bziO5jnIdUywrBW67G2yT3WQnND2S5PTftCeYAEPuq
         IGaQUIvd+uTLm+VaqCzJYjM5BUl38Xkb7ptc1Loz6KUAkuUXKKORvWa2ayD96LiYiDY0
         00hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=4UEj+Bd+UZxpb6+13xzUnRXx4XQV/BsazNWfQXf6uWk=;
        b=GFP2VXwF5sdQ1oaet9eeatTj6DssLut0OO/2b2NfZ0GyN/DGjLNObgHSmQ75c8B+mD
         FCHgyd2huFAI5tpwRv8VNA9qNsL6uocd54lIAJ+7yuD6i8mnPwDq92kLU1NDMuSd35+Y
         ASLbj+INmTtRImKtIavZxXHx4WRWgQhefXPlXmiD8yn1I5JdsiPguOgM8AYAD6EOYBTE
         e25F3Ky71DnFkZvWg2CxzIrsqgkZw8KZiGlBwgoPMcYY5SyBgZ94out8um9I6mTxwfpi
         IhQ4EuHtJ53+HZ2/wS5yvpItss+4DZyf4tKHDWD3mLfMeEd/LzcoMKfVCFTKZMlMFjUi
         6nYg==
X-Gm-Message-State: AOAM532P52cCZgAQS6MQKPPfIH5CisYwSnke7b+ASiNzoVGrsYS2Gr/e
        aTLsABDjBXBia5QrKckFpu1sEJ1mVWWchg==
X-Google-Smtp-Source: ABdhPJwc8OsiodbPPNbWQo8njC5EetlB4u3ZsjP5JrJ3F6ECDNzo9ZhA0GEDBI6o1VIZIyV+nFLgIw==
X-Received: by 2002:a9d:6351:: with SMTP id y17mr45702350otk.105.1641570983831;
        Fri, 07 Jan 2022 07:56:23 -0800 (PST)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id f59sm941939otf.9.2022.01.07.07.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 07:56:23 -0800 (PST)
Date:   Fri, 7 Jan 2022 07:57:11 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Cc:     Souradeep Chowdhury <schowdhu@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>, vkoul@kernel.org
Subject: Re: [PATCH V6 2/7] soc: qcom: dcc:Add driver support for Data
 Capture and Compare unit(DCC)
Message-ID: <Ydhi1/SH5ySDLNfI@ripper>
References: <cover.1628617260.git.schowdhu@codeaurora.org>
 <fc69469f26983d373d5ad7dc2dc83df207967eda.1628617260.git.schowdhu@codeaurora.org>
 <YbzvD+FFHuDWzCtZ@yoga>
 <caccb6da-2024-db4e-700c-9b4c13946ca0@quicinc.com>
 <YdeC456prDBG7tBA@ripper>
 <77a2ef02-384d-ce67-ae84-02c385eccd60@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <77a2ef02-384d-ce67-ae84-02c385eccd60@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 07 Jan 07:27 PST 2022, Souradeep Chowdhury wrote:

> 
> On 1/7/2022 5:31 AM, Bjorn Andersson wrote:
> > On Wed 05 Jan 23:57 PST 2022, Souradeep Chowdhury wrote:
> > 
> > > On 12/18/2021 1:41 AM, Bjorn Andersson wrote:
> > > > On Tue 10 Aug 12:54 CDT 2021, Souradeep Chowdhury wrote:
> > > > 
> > > > > The DCC is a DMA Engine designed to capture and store data
> > > > > during system crash or software triggers.The DCC operates
> > > > Please include a space after '.'
> > > Ack
> > > > > based on user inputs via the sysfs interface.The user gives
> > > > > addresses as inputs and these addresses are stored in the
> > > > > form of linkedlists.In case of a system crash or a manual
> > > > I think the user configures the DCC hardware with "a sequence of
> > > > operations to be performed as DCC is triggered".
> > > > 
> > > > Afaict the sequence is stored just as a sequence of operations in SRAM,
> > > > there's no linked list involved - except in your intermediate
> > > > implementation.
> > > The user just enters the addresses as input whereas the sequence of
> > > operations takes
> > > 
> > > place as per configuration code inside the driver. The end result is storage
> > > of these
> > > 
> > > addresses inside the DCC SRAM. The DCC hardware will capture the value at
> > > these
> > > 
> > > addresses on a crash or manual trigger by the user.
> > > 
> > > > > software trigger by the user through the sysfs interface,
> > > > > the dcc captures and stores the values at these addresses.
> > > > > This patch contains the driver which has all the methods
> > > > > pertaining to the sysfs interface, auxiliary functions to
> > > > > support all the four fundamental operations of dcc namely
> > > > > read, write, first read then write and loop.The probe method
> > > > "first read then write" is called "read/modify/write"
> > > Ack
> > > > > here instantiates all the resources necessary for dcc to
> > > > > operate mainly the dedicated dcc sram where it stores the
> > > > > values.The DCC driver can be used for debugging purposes
> > > > > without going for a reboot since it can perform manual
> > > > > triggers.
> > > > > 
> > > > > Also added the documentation for sysfs entries
> > > > > and explained the functionalities of each sysfs file that
> > > > > has been created for dcc.
> > > > > 
> > > > > The following is the justification of using sysfs interface
> > > > > over the other alternatives like ioctls
> > > > > 
> > > > > i) As can be seen from the sysfs attribute descriptions,
> > > > > most of it does basic hardware manipulations like dcc_enable,
> > > > > dcc_disable, config reset etc. As a result sysfs is preferred
> > > > > over ioctl as we just need to enter a 0 or 1.
> > > > > 
> > > > As I mentioned in our chat, using sysfs allows us to operate the
> > > > interface using the shell without additional tools.
> > > > 
> > > > But I don't think that it's easy to implement enable/disable/reset using
> > > > sysfs is a strong argument. The difficult part of this ABI is the
> > > > operations to manipulate the sequence of operations, so that's what you
> > > > need to have a solid plan for.
> > > The sysfs interface is being used to get the addresses values entered by the
> > > user
> > > 
> > > and to also go for manual triggers. The sequence of operations are kept as a
> > > part of
> > > 
> > > fixed driver code which is called when the user enters the data.
> > > 
> > But does the hardware really just operate on "addresses values entered
> > by the user". Given the various types of operations: read, write,
> > read-modify-write and loop I get the feeling that the hardware
> > "executes" a series of actions.
> > 
> > I'm don't think the proposed sysfs interface best exposes this to the
> > user and I don't think that "it's easy to implement enable/disable
> > attributes in sysfs" is reason enough to go with that approach.
> 
> So the sysfs interface here has been introduced keeping in mind how the
> DCC_SRAM needs to be
> 
> programmed for the dcc hardware to work. We are maintaining a list here
> based on the address
> 
> entry. The 4 cases for the type of addresses are as follows-:
> 
> i) READ ADDRESSES
> 
> user enters something like "echo <addr> <len> > config"
> 
> DCC driver stores the <addr> along with the length information in the
> DCC_SRAM.
> 
> ii) WRITE ADDRESSES
> 
> User enters something like "echo <addr> <write_val> 1  > config_write"
> 
> DCC stores the <addr> first in sram followed by <write_val>.
> 
> For the above 2 type of addresses there won't be much difference if we use
> IOCTL.
> 
> However, for the next 2 type of addresses
> 
> iii) LOOP ADDRESSES
> 
> user has to enter something like below
> 
> echo 9 > loop
> echo 0x01741010 1 > config
> echo 0x01741014 1 > config
> echo 1 > loop
> 
> The DCC SRAM will be programmed precisely like the above entries where the
> loop count will be stored first
> 
> followed by loop addresses and then again a "echo 1 > loop " marks the end
> of loop addresses.
> 
> in DCC_SRAM.
> 
> iv) READ_WRITE ADDRESSES
> 
> User has to enter something like below
> 
> echo <addr> > /sys/bus/platform/devices/../config
> 
> echo <mask> <val> > /sys/bus/platform/devices/../rd_mod_wr
> 
> Here first the  <addr> is stored in DCC_SRAM followed by <mask> and then the
> <val>.
> 
> The above representation to the user space is consistent with the dcc
> hardware in terms of
> 
> the way the sequence of values are programmed in the DCC SRAM . Moving to
> IOCTL will
> 
> only change the way the READ_WRITE address is represented although user will
> have to enter
> 
> multiple parameters at once, let me know if we still need to go for the
> same.
> 

So if I understand correctly, my concern is that if I would like to
perform something like (in pseudo code):

readl(X)
write(1, Y)
readl(Z) 5 times

then I will do this as:

echo X > config
echo Y 1 > config_write
echo 5 > loop
echo Z > config
echo 1 > loop

And the DCC driver will then write this to SRAM as something like:

read X
write Y, 1
loop 5
read Z
loop


In other words, my mind and the DCC has the same representation of this
sequence of operations, but I have to shuffle the information into 4
different sysfs attributes to get there.

The design guideline for sysfs is that each attribute should hold one
value per attribute, but in your model the attributes are tangled and
writing things to them depends on what has been written in that or other
attributes previously.

I simply don't think that's a good ABI.

[..]
> > > > > +		The address argument should
> > > > > +		be given of the form <mask> <value>.For debugging
> > > > > +		purposes sometimes we need to first read from a register
> > > > > +		and then set some values to the register.
> > > > > +		Example:
> > > > > +		echo 0x80000000 > /sys/bus/platform/devices/.../config
> > > > > +		(Set the address in config file)
> > > > > +		echo 0xF 0xA > /sys/bus/platform/devices/.../rd_mod_wr
> > > > > +		(Provide the mask and the value to write)
> > > > > +
> > > > > +What:           /sys/bus/platform/devices/.../ready
> > > > > +Date:           March 2021
> > > > > +Contact:        Souradeep Chowdhury<schowdhu@codeaurora.org>
> > > > > +Description:
> > > > > +		This file is used to check the status of the dcc
> > > > > +		hardware if it's ready to take the inputs.
> > > > When will this read "false"?
> > > This will give false if the DCC hardware is not in an operational state.
> > > 
> > > Will update accordingly.
> > > 
> > > > > +		Example:
> > > > > +		cat /sys/bus/platform/devices/.../ready
> > > > > +
> > > > > +What:		/sys/bus/platform/devices/.../curr_list
> > > > > +Date:		February 2021
> > > > > +Contact:	Souradeep Chowdhury<schowdhu@codeaurora.org>
> > > > > +Description:
> > > > > +		This attribute is used to enter the linklist to be
> > > > I think it would be more appropriate to use the verb "select" here and
> > > > afaict it's a "list" as the "linked" part only relates to your
> > > > implementation).
> > > > 
> > > > But that said, I don't like this ABI. I think it would be cleaner if you
> > > > had specific attributes for each of the lists. That way it would be
> > > > clear that you have N lists and they can be configured and enabled
> > > > independently, and there's no possible race conditions.
> > > So we do have attributes for independent lists in this case. The user is
> > > given the option
> > > 
> > > to configure multiple lists at one go. For example I can do
> > > 
> > > echo 1 > curr_list
> > > 
> > > echo 0x18000010 1 > config
> > > echo 0x18000024 1 > config
> > > 
> > > Then followed by
> > > 
> > > echo 2 > curr_list
> > > 
> > > echo 0x18010038 6 > config
> > > echo 0x18020010 1 > config
> > > 
> > > We will get the output in terms of two separate list of registers values.
> > > 
> > I understand that this will define two lists of operations and that we
> > will get 2 and 7 registers dumped, respectively. Perhaps unlikely, but
> > what happens if you try to do these two operations concurrently?
> > 
> > 
> > What I'm suggesting here is that if you have N contexts, you should have
> > N interfaces to modify each one independently - simply because that's
> > generally a very good thing.
> 
> Not sure if there will ever be a concurrency issue in this case.
> This is just about programming the DCC SRAM from the user entries
> sequentially.

So you've decided that two such sequences must not happen at the same
time. (I know it's unlikely, but there's nothing preventing me from
running the two snippets of echos concurrently and the outcome will be
unexpected)

> The curr_list number is nothing but some register writes
> done in the dcc so that the dcc_hardware knows the beginning and end
> of a particular list and can dump the captured data according. Even if
> an user chooses multiple curr_list entries, it will be programmed
> sequentially in DCC_SRAM.
> 

So there's no separation between the lists in the hardware?

Looking at the driver I get a sense that we have N lists that can be
configured independently and will be run "independently" upon a trigger.

If this isn't the case, what's the purpose of the multiple lists?

> > 
> > > > > +		used while appending addresses.The range of values
> > > > > +		for this can be from 0 to 3.This feature is given in
> > > > > +		order to use certain linkedlist for certain debugging
> > > > > +		purposes.
> > > > > +		Example:
> > > > > +		echo 0 > /sys/bus/platform/devices/10a2000.dcc/curr_list
> > > > > +
> > [..]
> > > > > diff --git a/drivers/soc/qcom/dcc.c b/drivers/soc/qcom/dcc.c
> > [..]
> > > > > +static int dcc_valid_list(struct dcc_drvdata *drvdata, int curr_list)
> > > > > +{
> > > > > +	u32 lock_reg;
> > > > > +
> > > > > +	if (list_empty(&drvdata->cfg_head[curr_list]))
> > > > > +		return -EINVAL;
> > > > > +
> > > > > +	if (drvdata->enable[curr_list]) {
> > > > > +		dev_err(drvdata->dev, "List %d is already enabled\n",
> > > > > +				curr_list);
> > > > > +		return -EINVAL;
> > > > > +	}
> > > > > +
> > > > > +	lock_reg = dcc_readl(drvdata, DCC_LL_LOCK(curr_list));
> > > > Under what circumstances would this differ from
> > > > drvdata->enable[curr_list}?
> > > So locking the list is done on the register as soon as the user enters the
> > > curr_list entry whereas
> > > 
> > > the list is marked as enabled only on successfully programming the SRAM
> > > contents. So a list can
> > > 
> > > be locked and not marked enabled in certain cases. The first is used so that
> > > the user doesn't
> > > 
> > > mistakenly enter the same curr_list twice whereas the later is used to mark
> > > that the list has been
> > > 
> > > successfully configured.
> > > 
> > So this will mark the list as "actively in use, but disabled"? Why is
> > this kept in the hardware? When is this not the same as the list of
> > operations for that list being non-empty?
> 
> So this is in accordance with the dcc hardware configuration
> requirement. We have to lock the list first and after that proceed
> with the subsequent writes.

But what does this mean? What happens when I lock a list?

Afacit we have a "lock" bit and an "enable" bit. So in what circumstance
does the hardware care about a list being locked? Wouldn't it be
sufficient to just have the enable bit?

> As per the driver code below
> 
>                /* 1. Take ownership of the list */
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
> In case of any errors we again unlock the list before exiting.
> 

So it needs to be locked while SRAM contains a valid sequence of
operations?

Or does it need to be locked while we write to SRAM? If so, why is that?

Regards,
Bjorn
