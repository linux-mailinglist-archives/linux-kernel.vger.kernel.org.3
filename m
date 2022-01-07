Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72213486E43
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 01:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343733AbiAGAAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 19:00:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343725AbiAGAAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 19:00:51 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88A8C034003
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 16:00:50 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id t204so6002884oie.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 16:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=SFOHTevF+vet+Ja7PNGzxyr0ssy1bVS/Ui+kcI/nwVc=;
        b=vv1GqIWgS3m1GLdkqNvXJKx3fNRmJ3e5+ivI0tRu1Qw/1oY8icHZda5iJMJXVNlKKL
         96s2d/Hxrte+icAIvAE89OAA24bJwKBeavHT/ZvQgNnpgQqF6t9qRZR+iV6Z5VR0EcNH
         LLMyBkW01ko1QO3LxmhWy7wVfgP6y5RZVrlykU8Zf4ExBe82eAKemQ5He9dLeWUC73ue
         Q2Fg04oS/FaItynWVrf/lzGiUlJlcYNsVbldRtQfNrrzdSdL0FNCJkwsuyzycbFM1M2Y
         0ofCYk0expqOAABAcje8DbAYFjVPDWRPz/uiig4MUUtVIQ0nLd79OeuM0oJhT4y+O11A
         vnYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=SFOHTevF+vet+Ja7PNGzxyr0ssy1bVS/Ui+kcI/nwVc=;
        b=D1dM7iUV54RfpObeFVjSy16iUQqKAVKdg2qeSRn2qMxTrkMvLvfig3G/5WU1a4kGBz
         oYjb0vjbzEZrK5lznWY1l1VNDTx3klf+FiTEQCGjMkAbOfFoi0CH+zCWAGQPyz3xgwNP
         toSmZurVc8fz+j6rRU54RPjA72T18+6+NgEWlDLIrGUdbSY4s0CAFaVLdkl6rUdSD0WL
         h3/I2Xfr8eMLPVp6oOUXEbJe7AlKxdZvfHvr/hiZLgpkQHhX9lfy6EVrSdc9jrAo11o5
         44+hhJjjun/v3rZ8AVx1Ps8HauK3rZKhd3IaDrZ8sF4XphqAwVFK0Kkm1B6gUgUGWCpy
         MjVQ==
X-Gm-Message-State: AOAM530n4jcrxuFl+PmbsFRKk6U3vuQi4Hyw+jX6ejRYnXN5hSMvUrKN
        BkJjM6JyGuffeMge2QkAE5i32Q==
X-Google-Smtp-Source: ABdhPJyiJu5zi26ktfu1N7FvEu12lR2PqVy198HG11QxtbgOX0g6+g1K207FKwNMwZ8JOx2+ePYKZg==
X-Received: by 2002:a05:6808:114a:: with SMTP id u10mr8123141oiu.96.1641513649834;
        Thu, 06 Jan 2022 16:00:49 -0800 (PST)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 69sm602507otf.33.2022.01.06.16.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 16:00:49 -0800 (PST)
Date:   Thu, 6 Jan 2022 16:01:39 -0800
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
Message-ID: <YdeC456prDBG7tBA@ripper>
References: <cover.1628617260.git.schowdhu@codeaurora.org>
 <fc69469f26983d373d5ad7dc2dc83df207967eda.1628617260.git.schowdhu@codeaurora.org>
 <YbzvD+FFHuDWzCtZ@yoga>
 <caccb6da-2024-db4e-700c-9b4c13946ca0@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <caccb6da-2024-db4e-700c-9b4c13946ca0@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 05 Jan 23:57 PST 2022, Souradeep Chowdhury wrote:

> 
> On 12/18/2021 1:41 AM, Bjorn Andersson wrote:
> > On Tue 10 Aug 12:54 CDT 2021, Souradeep Chowdhury wrote:
> > 
> > > The DCC is a DMA Engine designed to capture and store data
> > > during system crash or software triggers.The DCC operates
> > Please include a space after '.'
> Ack
> > > based on user inputs via the sysfs interface.The user gives
> > > addresses as inputs and these addresses are stored in the
> > > form of linkedlists.In case of a system crash or a manual
> > I think the user configures the DCC hardware with "a sequence of
> > operations to be performed as DCC is triggered".
> > 
> > Afaict the sequence is stored just as a sequence of operations in SRAM,
> > there's no linked list involved - except in your intermediate
> > implementation.
> 
> The user just enters the addresses as input whereas the sequence of
> operations takes
> 
> place as per configuration code inside the driver. The end result is storage
> of these
> 
> addresses inside the DCC SRAM. The DCC hardware will capture the value at
> these
> 
> addresses on a crash or manual trigger by the user.
> 
> > > software trigger by the user through the sysfs interface,
> > > the dcc captures and stores the values at these addresses.
> > > This patch contains the driver which has all the methods
> > > pertaining to the sysfs interface, auxiliary functions to
> > > support all the four fundamental operations of dcc namely
> > > read, write, first read then write and loop.The probe method
> > "first read then write" is called "read/modify/write"
> Ack
> > > here instantiates all the resources necessary for dcc to
> > > operate mainly the dedicated dcc sram where it stores the
> > > values.The DCC driver can be used for debugging purposes
> > > without going for a reboot since it can perform manual
> > > triggers.
> > > 
> > > Also added the documentation for sysfs entries
> > > and explained the functionalities of each sysfs file that
> > > has been created for dcc.
> > > 
> > > The following is the justification of using sysfs interface
> > > over the other alternatives like ioctls
> > > 
> > > i) As can be seen from the sysfs attribute descriptions,
> > > most of it does basic hardware manipulations like dcc_enable,
> > > dcc_disable, config reset etc. As a result sysfs is preferred
> > > over ioctl as we just need to enter a 0 or 1.
> > > 
> > As I mentioned in our chat, using sysfs allows us to operate the
> > interface using the shell without additional tools.
> > 
> > But I don't think that it's easy to implement enable/disable/reset using
> > sysfs is a strong argument. The difficult part of this ABI is the
> > operations to manipulate the sequence of operations, so that's what you
> > need to have a solid plan for.
> 
> The sysfs interface is being used to get the addresses values entered by the
> user
> 
> and to also go for manual triggers. The sequence of operations are kept as a
> part of
> 
> fixed driver code which is called when the user enters the data.
> 

But does the hardware really just operate on "addresses values entered
by the user". Given the various types of operations: read, write,
read-modify-write and loop I get the feeling that the hardware
"executes" a series of actions.

I'm don't think the proposed sysfs interface best exposes this to the
user and I don't think that "it's easy to implement enable/disable
attributes in sysfs" is reason enough to go with that approach.

> > > ii) Existing similar debug hardwares are there for which drivers
> > > have been written using sysfs interface.One such example is the
> > > coresight-etm-trace driver.
> > Afaict the etm interface has operations to enable and disable, I don't
> > see anything that's similar to the interface for defining the sequence
> > of operations.
> 
> Here I have just drawn analogy with an existing sysfs interface. The 
> argument for
> 
> using sysfs instead of other interfaces can be as folllows
> 
> 1)
> 
> Debugfs interface is used by drivers to expose debugging information additional to
> the function they do. But the sole usage of this driver depends on the configuration
> exported through the attributes and therefore it is an ABI as suggested by Mani.
> 
> 2)
> 
> Debugfs is disabled in production so this will not give the user facility to use DCC.
> 
> 3)
> 
> As you mentioned sysfs can be used with the shell without any additional tools.
> 
> 4)
> 
> Alternatives like NETLINK has also been suggested although in this case by using
> NETLINK we won't be able to exploit most it's features like duplex connection,
> asychrony and bulk data transfers. We are not showing any stats here to the user
> as such and also sysfs is considered to be a bit more reliable.
> 

I'm not sure why netlink would preferred for this; to me sysfs is much
preferred as it allows us to use DCC from scripts etc without having to
bundle additional binaries. If we can't express the configuration
appropriately in a sysfs (debugfs would be the same) interface, I think
an ioctl interface on /dev/dcc would be a reasonable alternative.

> Please let me your thoughts regarding this.
> 
> > > A closer analog can also be the watchdog
> > > subsystems though it is ioctls based.
> > > 
> > I don't think this adds value to the argument for using a sysfs based
> > interface.
> Ack
> > 
> > > Signed-off-by: Souradeep Chowdhury<schowdhu@codeaurora.org>
> > > ---
> > >   Documentation/ABI/testing/sysfs-driver-dcc |  114 ++
> > >   drivers/soc/qcom/Kconfig                   |    8 +
> > >   drivers/soc/qcom/Makefile                  |    1 +
> > >   drivers/soc/qcom/dcc.c                     | 1549 ++++++++++++++++++++++++++++
> > >   4 files changed, 1672 insertions(+)
> > >   create mode 100644 Documentation/ABI/testing/sysfs-driver-dcc
> > >   create mode 100644 drivers/soc/qcom/dcc.c
> > > 
> > > diff --git a/Documentation/ABI/testing/sysfs-driver-dcc b/Documentation/ABI/testing/sysfs-driver-dcc
[..]
> > > +What:           /sys/bus/platform/devices/.../rd_mod_wr
> > > +Date:           March 2021
> > > +Contact:        Souradeep Chowdhury<schowdhu@codeaurora.org>
> > > +Description:
> > > +		This file is used to read the value of the register
> > > +		and then write the value given as an argument to the
> > > +		register address in config.
> > It's not clear from this description how to use this operation. E.g. is
> > it appended to the same list of operations? When will this operation
> > happen?
> > 
> > Looking at the implementation I believe that "config", "config_write",
> > "loop" and "rd_mod_wr" all appends operations to the same list.
> > 
> > I think it would be much better to configure this with a single file
> > that can either be written to '>' or appended to '>>' and you would feed
> > it a sequence of the operations to be performed.
> > 
> > That said, I'm afraid that might no longer be a sysfs attribute.
> > 
> > Something like:
> >    # echo 'r 0x80000010 0x10' > config
> >    # echo 'w 0x80000000 0xff' >> config
> >    # echo 'rmw 0x80000000 0xf 0xa' >> config
> >    # echo 'l 0x80000010 10' >> config
> > 
> > and:
> >    # cat config
> >    r 0x80000010 0x10
> >    w 0x80000000 0xff
> >    rmw 0x80000000 0xf 0xa
> >    l 0x80000010 10
> > 
> > (Or read/write/modify/loop as keywords...)
> > 
> > 
> > reset could be done by just: echo '' > config
> > 
> > This would make it quite similar to several of the files in the tracing
> > framework.
> 
> Currently this is being implemented as follows
> 
> Step 1
> 
> echo 0x80000000 > /sys/bus/platform/devices/../config
> 
> Step 2
> 
> echo 0xF 0xA > /sys/bus/platform/devices/../rd_mod_wr
> 
> So the particular address is tagged as rd_mod_wr type and therefore
> 
> while the value at the address 0x80000000 is captured, 0xA is also
> 
> written to it's last 4 bits. Will be updating this in the documentation
> 
> along with details for loop and config_write as well.
> 

But can you help me confirm what is actually written in SRAM when you
run these two steps?

> > 
> > > +		The address argument should
> > > +		be given of the form <mask> <value>.For debugging
> > > +		purposes sometimes we need to first read from a register
> > > +		and then set some values to the register.
> > > +		Example:
> > > +		echo 0x80000000 > /sys/bus/platform/devices/.../config
> > > +		(Set the address in config file)
> > > +		echo 0xF 0xA > /sys/bus/platform/devices/.../rd_mod_wr
> > > +		(Provide the mask and the value to write)
> > > +
> > > +What:           /sys/bus/platform/devices/.../ready
> > > +Date:           March 2021
> > > +Contact:        Souradeep Chowdhury<schowdhu@codeaurora.org>
> > > +Description:
> > > +		This file is used to check the status of the dcc
> > > +		hardware if it's ready to take the inputs.
> > When will this read "false"?
> 
> This will give false if the DCC hardware is not in an operational state.
> 
> Will update accordingly.
> 
> > 
> > > +		Example:
> > > +		cat /sys/bus/platform/devices/.../ready
> > > +
> > > +What:		/sys/bus/platform/devices/.../curr_list
> > > +Date:		February 2021
> > > +Contact:	Souradeep Chowdhury<schowdhu@codeaurora.org>
> > > +Description:
> > > +		This attribute is used to enter the linklist to be
> > I think it would be more appropriate to use the verb "select" here and
> > afaict it's a "list" as the "linked" part only relates to your
> > implementation).
> > 
> > But that said, I don't like this ABI. I think it would be cleaner if you
> > had specific attributes for each of the lists. That way it would be
> > clear that you have N lists and they can be configured and enabled
> > independently, and there's no possible race conditions.
> 
> So we do have attributes for independent lists in this case. The user is
> given the option
> 
> to configure multiple lists at one go. For example I can do
> 
> echo 1 > curr_list
> 
> echo 0x18000010 1 > config
> echo 0x18000024 1 > config
> 
> Then followed by
> 
> echo 2 > curr_list
> 
> echo 0x18010038 6 > config
> echo 0x18020010 1 > config
> 
> We will get the output in terms of two separate list of registers values.
> 

I understand that this will define two lists of operations and that we
will get 2 and 7 registers dumped, respectively. Perhaps unlikely, but
what happens if you try to do these two operations concurrently?


What I'm suggesting here is that if you have N contexts, you should have
N interfaces to modify each one independently - simply because that's
generally a very good thing.

> > 
> > > +		used while appending addresses.The range of values
> > > +		for this can be from 0 to 3.This feature is given in
> > > +		order to use certain linkedlist for certain debugging
> > > +		purposes.
> > > +		Example:
> > > +		echo 0 > /sys/bus/platform/devices/10a2000.dcc/curr_list
> > > +
[..]
> > > diff --git a/drivers/soc/qcom/dcc.c b/drivers/soc/qcom/dcc.c
[..]
> > > +static int dcc_valid_list(struct dcc_drvdata *drvdata, int curr_list)
> > > +{
> > > +	u32 lock_reg;
> > > +
> > > +	if (list_empty(&drvdata->cfg_head[curr_list]))
> > > +		return -EINVAL;
> > > +
> > > +	if (drvdata->enable[curr_list]) {
> > > +		dev_err(drvdata->dev, "List %d is already enabled\n",
> > > +				curr_list);
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	lock_reg = dcc_readl(drvdata, DCC_LL_LOCK(curr_list));
> > Under what circumstances would this differ from
> > drvdata->enable[curr_list}?
> 
> So locking the list is done on the register as soon as the user enters the
> curr_list entry whereas
> 
> the list is marked as enabled only on successfully programming the SRAM
> contents. So a list can
> 
> be locked and not marked enabled in certain cases. The first is used so that
> the user doesn't
> 
> mistakenly enter the same curr_list twice whereas the later is used to mark
> that the list has been
> 
> successfully configured.
> 

So this will mark the list as "actively in use, but disabled"? Why is
this kept in the hardware? When is this not the same as the list of
operations for that list being non-empty?

> > 
> > > +	if (lock_reg & 0x1) {
> > > +		dev_err(drvdata->dev, "List %d is already locked\n",
> > > +				curr_list);
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	dev_err(drvdata->dev, "DCC list passed %d\n", curr_list);
> > This is noise, please drop it.
> Ack
> > 
> > > +	return 0;
> > > +}
> > > +
> > > +static bool is_dcc_enabled(struct dcc_drvdata *drvdata)
> > > +{
> > > +	bool dcc_enable = false;
> > > +	int list;
> > > +
> > > +	for (list = 0; list < DCC_MAX_LINK_LIST; list++) {
> > > +		if (drvdata->enable[list]) {
> > 			return true;
> > 
> > > +			dcc_enable = true;
> > > +			break;
> > > +		}
> > > +	}
> > > +
> > 	return false;
> > 
> > > +	return dcc_enable;
> > > +}
> > > +
> > > +static int dcc_enable(struct dcc_drvdata *drvdata)
> > > +{
> > > +	int ret = 0;
> > > +	int list;
> > > +	u32 ram_cfg_base;
> > > +
> > > +	mutex_lock(&drvdata->mutex);
> > > +
> > > +	if (!is_dcc_enabled(drvdata)) {
> > > +		memset_io(drvdata->ram_base,
> > > +			0xDE, drvdata->ram_size);
> > No need to wrap this line, and please use lowercase hex digits.
> Ack
> > 
> > > +	}
> > > +
> > > +	for (list = 0; list < drvdata->nr_link_list; list++) {
> > > +
> > Please drop the empty line.
> Ack
> > 
> > > +		if (dcc_valid_list(drvdata, list))
> > > +			continue;
> > > +
> > > +		/* 1. Take ownership of the list */
> > > +		dcc_writel(drvdata, BIT(0), DCC_LL_LOCK(list));
> > Can we have a define for BIT(0)? Is it really about ownership or just
> > that we "enable" it?
> > 
> > If ownership, who's the other contenders for the ownership?
> 
> This is done to mark that the user has already entered the curr_list and
> therefore
> 
> cannot enter it again.
> 

What does "entered" mean here? Do you mean that the list of operations
that the driver kept track of has been flushed out to SRAM and we're not
not allowed to modify it?

What does this actually mean? Why is this done in the hardware and not
simply with a bool in the driver?

> > 
> > > +
> > > +		/* 2. Program linked-list in the SRAM */
> > > +		ram_cfg_base = drvdata->ram_cfg;
> > > +		ret = __dcc_ll_cfg(drvdata, list);
> > > +		if (ret) {
> > > +			dcc_writel(drvdata, 0, DCC_LL_LOCK(list));
> > > +			goto err;
> > > +		}
> > > +
> > > +		/* 3. program DCC_RAM_CFG reg */
> > > +		dcc_writel(drvdata, ram_cfg_base +
> > > +			drvdata->ram_offset/4, DCC_LL_BASE(list));
> > > +		dcc_writel(drvdata, drvdata->ram_start +
> > > +			drvdata->ram_offset/4, DCC_FD_BASE(list));
> > > +		dcc_writel(drvdata, 0xFFF, DCC_LL_TIMEOUT(list));
> > > +
> > > +		/* 4. Clears interrupt status register */
> > > +		dcc_writel(drvdata, 0, DCC_LL_INT_ENABLE(list));
> > > +		dcc_writel(drvdata, (BIT(0) | BIT(1) | BIT(2)),
> > > +					DCC_LL_INT_STATUS(list));
> > > +
> > > +		drvdata->enable[list] = true;
> > > +
> > > +		/* 5. Configure trigger */
> > > +		dcc_writel(drvdata, BIT(9), DCC_LL_CFG(list));
> > > +	}
> > > +
> > > +err:
> > > +	mutex_unlock(&drvdata->mutex);
> > > +	return ret;
> > > +}
> > > +
> > > +static void dcc_disable(struct dcc_drvdata *drvdata)
> > > +{
> > > +	int curr_list;
> > > +
> > > +	mutex_lock(&drvdata->mutex);
> > > +
> > > +	for (curr_list = 0; curr_list < drvdata->nr_link_list; curr_list++) {
> > > +		if (!drvdata->enable[curr_list])
> > > +			continue;
> > > +		dcc_writel(drvdata, 0, DCC_LL_CFG(curr_list));
> > > +		dcc_writel(drvdata, 0, DCC_LL_BASE(curr_list));
> > > +		dcc_writel(drvdata, 0, DCC_FD_BASE(curr_list));
> > > +		dcc_writel(drvdata, 0, DCC_LL_LOCK(curr_list));
> > > +		drvdata->enable[curr_list] = false;
> > > +	}
> > > +	memset_io(drvdata->ram_base, 0, drvdata->ram_size);
> > Is there any reason why DCC is filled with 0xde during initialization
> > but 0 when disabled?
> 
> Yes this poison value is required to distinguish between bus hang on
> register accesses
> 
> and a zero value for the registers. In case of the former dcc returns zero
> value on registers
> 
> which causes ambiguity.
> 

That explains why you poison ram_base with 0xde during dcc_enable(). But
why do you overwrite it with 0s in dcc_disable()?

You should be able to either just leave it as it will be poisoned again
next time dcc_enable() is called, or if you want to ensure things are
cleared you should be able to poison it with the same poison - to
distinguish it from a bunch of read 0s?

Regards,
Bjorn
