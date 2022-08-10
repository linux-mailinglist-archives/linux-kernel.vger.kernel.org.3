Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54DB958F47B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 00:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233550AbiHJWnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 18:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbiHJWnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 18:43:49 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486A724F15
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 15:43:44 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id l18so12064961qvt.13
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 15:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=C/+XurQkR1pLRbr7ry+/AG2dkK5M/FLPOz8jERG5lt8=;
        b=FHAJ0Pq8IH9FXzT9xjnzCYdjrtYzl35zrotYUFAXvRNOeNhwt7qeLjbwJil5mpFPKE
         TLf+kYQB+5k91WI/hu7/C+bMoCbpmVjnhuXrfM5GYUoC+CXQYKVVHilPe9G4mMtsGmkR
         NE6ohdvNUEaFc5qVeZrImZzus9U+ueZBB77Qc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=C/+XurQkR1pLRbr7ry+/AG2dkK5M/FLPOz8jERG5lt8=;
        b=qMGDZWNiJYHA2dELCLkCFDcflzyfQi/OBDEgp9Cy3QdUB7Gar7uL6vJJoObbPInRb+
         aVv8ePFqL0yQ5LkhcFpBzlQxtAAvSrGFZCcsOjq4mkSX+MMZNySMnzYcfvJm0zHzFOSk
         4k1a6SX03sbo3qFQlkrj4O17FIfKPZgjVJFqAXDscl6/ZAyEJfQF/0L+3JOvBx6jhe1Z
         i8XQRVUEEmwTAV+OmXFjm45i65Iw5wunu0711OheL6WgGPQa9kd9ex0ZyzHPKSMHIAGh
         zChb50/MOh3XJ3jH0maj98EL6MxNeHDJgNEiSf8dX/OZPDXKSAdW3sltLngHFyMqYXje
         IguQ==
X-Gm-Message-State: ACgBeo2I/NRodKQ0g2zK+s901q8B5twXf0GQu6g/oWZjB2hyOtoa0cdg
        8X8NMNdmnr/ANbY4L4S2jgW1yA==
X-Google-Smtp-Source: AA6agR7hmJa6v7HS+7inpOlHaue43hpDCS1tjn+3CuMr8nsiFRIrG6bmCtMIZfMHjuv/W9ACwnmlNw==
X-Received: by 2002:a0c:e244:0:b0:476:a281:f090 with SMTP id x4-20020a0ce244000000b00476a281f090mr26069910qvl.92.1660171422525;
        Wed, 10 Aug 2022 15:43:42 -0700 (PDT)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id w22-20020ac857d6000000b0031f287f58b4sm688234qta.51.2022.08.10.15.43.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Aug 2022 15:43:42 -0700 (PDT)
Message-ID: <db5d315c-2b81-4772-45d1-03b44a16c3e1@ieee.org>
Date:   Wed, 10 Aug 2022 17:43:40 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V8 2/7] soc: qcom: dcc:Add driver support for Data Capture
 and Compare unit(DCC)
Content-Language: en-US
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
References: <cover.1653475467.git.quic_schowdhu@quicinc.com>
 <5fdf3eab909e1df8ad14c33e0f9839ff006f2e7b.1653475467.git.quic_schowdhu@quicinc.com>
From:   Alex Elder <elder@ieee.org>
In-Reply-To: <5fdf3eab909e1df8ad14c33e0f9839ff006f2e7b.1653475467.git.quic_schowdhu@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/25/22 6:13 AM, Souradeep Chowdhury wrote:
> The DCC is a DMA Engine designed to capture and store data
> during system crash or software triggers. The DCC operates
> based on user inputs via the debugfs interface. The user gives
> addresses as inputs and these addresses are stored in the
> dcc sram. In case of a system crash or a manual software
> trigger by the user through the debugfs interface,
> the dcc captures and stores the values at these addresses.
> This patch contains the driver which has all the methods
> pertaining to the debugfs interface, auxiliary functions to
> support all the four fundamental operations of dcc namely
> read, write, read/modify/write and loop. The probe method
> here instantiates all the resources necessary for dcc to
> operate mainly the dedicated dcc sram where it stores the
> values. The DCC driver can be used for debugging purposes
> without going for a reboot since it can perform software
> triggers as well based on user inputs.
> 
> Also added the documentation for debugfs entries and explained
> the functionalities of each debugfs file that has been created
> for dcc.
> 
> The following is the justification of using debugfs interface
> over the other alternatives like sysfs/ioctls
> 
> i) As can be seen from the debugfs attribute descriptions,
> some of the debugfs attribute files here contains multiple
> arguments which needs to be accepted from the user. This goes
> against the design style of sysfs.
> 
> ii) The user input patterns have been made simple and convenient
> in this case with the use of debugfs interface as user doesn't
> need to shuffle between different files to execute one instruction
> as was the case on using other alternatives.
> 
> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>

First of all, I want to apologize for taking so long to review
this.  I reviewed an earlier version and had every intention of
reviewing your later ones.

I have some comments on this version (quite a few, actually).
When you post a new version, please include me in the addressee
list so I'm sure to see it.

> ---
>   Documentation/ABI/testing/debugfs-driver-dcc |   95 ++
>   drivers/soc/qcom/Kconfig                     |    8 +
>   drivers/soc/qcom/Makefile                    |    1 +
>   drivers/soc/qcom/dcc.c                       | 1359 ++++++++++++++++++++++++++
>   4 files changed, 1463 insertions(+)
>   create mode 100644 Documentation/ABI/testing/debugfs-driver-dcc
>   create mode 100644 drivers/soc/qcom/dcc.c
> 
> diff --git a/Documentation/ABI/testing/debugfs-driver-dcc b/Documentation/ABI/testing/debugfs-driver-dcc
> new file mode 100644
> index 0000000..d53fcd1
> --- /dev/null
> +++ b/Documentation/ABI/testing/debugfs-driver-dcc
> @@ -0,0 +1,95 @@
> +What:           /sys/kernel/debug/dcc/.../trigger
> +Date:           March 2022

Before your final version, please update the dates to more closely
match the expected first arrival date upstream.

> +Contact:        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> +Description:
> +		This is the debugfs interface for manual software
> +		triggers. The user can simply enter a 1 against
> +		the debugfs file and enable a manual trigger.
> +		Example:
> +		echo  1 > /sys/kernel/debug/dcc/.../trigger

It's possible this is contrary to a convention used upstream, but...

I think you should document the three high-level debugfs files
("ready", "trigger", and "config_reset") first (and possibly in the
order I list them), *then* list the "config" and "enable" entries
associated with each list.

> +What:           /sys/kernel/debug/dcc/.../[list-number]/enable
> +Date:           March 2022
> +Contact:        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> +Description:
> +		This debugfs interface is used for enabling the
> +		the dcc hardware. Enable file is kept under the
> +		directory list number for which the user wants
> +		to enable it. For example if the user wants to
> +		enable list 1, then he should go for
> +		echo 1 > /sys/kernel/debug/dcc/.../1/enable.
> +		On enabling the dcc, all the addresses entered
> +		by the user for the corresponding list is written
> +		into dcc sram which is read by the dcc hardware
> +		on manual or crash induced triggers.

It seems as though any number of the lists can be enabled at a
time.  Is this correct?  I think you should state this more
explicitly somehow.  And if multiple are enabled, clarify that
they are "executed" in numerical order.

> +		Example:
> +		echo  0 > /sys/kernel/debug/dcc/.../[list-number]/enable
> +		(disable dcc for the corresponding list number)
> +		echo  1 > /sys/kernel/debug/dcc/.../[list-number]/enable
> +		(enable dcc for the corresponding list number)
> +
> +What:           /sys/kernel/debug/dcc/.../[list-number]/config
> +Date:           March 2022
> +Contact:        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> +Description:
> +		This stores the addresses of the registers which
> +		needs to be read in case of a hardware crash or

s/needs to be/should/

> +		manual software triggers. The address entered here

s/address/addresses/

> +		are considered under all the 4 types of dcc
> +		instructions Read type, Write type, Read Modify Write
> +		type and Loop type. The lists need to be configured
> +		sequentially and not in a overlapping manner. As an

I don't know what "sequentially and not in a overlapping manner"
means.  Can you try to clarify?

> +		example user can jump to list x only after list y is
> +		configured and enabled. The format for entering all
> +		types of instructions are explained in examples as
> +		follows.

I have some questions/suggestions about the consistency of your
interface here.  The first is that I think a different order of
arguments might make more sense.

> +		Example:
> +	         i)Read Type Instruction
> +		   echo R <1> <2> <3> >/sys/kernel/debug/dcc/../[list-number]/config
> +		   1->Address to be considered for reading the value.
> +		   2->The word count of the addresses, read n words
> +		      starting from address <1>.

It seems the word count could be optional, with a default value
of 1 if not specified.  But that would mean it should be the last
argument rather than second.

Please be specfic about what the meaning of a "word" is.  Is it
32 bits wide?  64 bits wide?

(The code truncates ensures address actually used to access memory
is a multiple of 16.)

> +		   3->Can be a 1 or 0 which indicates if it is apb or ahb
> +		      bus respectively.

In the code I find that <3> is optional, and if omitted, ahb is used.
Is it unusual to want to use apb?  If not, I suggest this might be a
mandatory argument, and make it be first (to define the context in
which the address argument is meaningful).

I also think it would be clearer if this argument were a string,
"apb" or "ahb" (possibly capitalized?), rather than just a 0 or 1.

> +		ii)Write Type Instruction
> +		   echo W <1> <2> <3> > /sys/kernel/debug/dcc/../[list-number]/config
> +		   1->Address to be considered for writing the value.
> +		   2->The value that needs to be written at the location.
> +		   3->Can be a 1 or 0 which indicates if it is apb or ahb
> +		      but respectively.

Same general comments here as for the read instruction.

> +	       iii)Read Modify Write type instruction
> +		   echo RW <1> <2> <3> > /sys/kernel/debug/dcc/../[list-number]/config
> +		   1->The address which needs to be considered for read then write.
> +		   2->The value that needs to be written on the address.
> +		   3->The mask of the value to be written.

There is no "apb/ahb" option here.  There should be.  Making it be
the required first argument like the rest would be consistent.

I note that the code interprets these numeric values as hexidecimal.

> +		iv)Loop Type Instruction
> +		   echo L <1> <2> <3> > /sys/kernel/debug/dcc/../[list-number]/config
> +		   1->The loop count, the number of times the value of the addresses will be
> +		      captured.
> +		   2->The address count, total number of addresses to be entered in this
> +		      instruction.

There is no "apb/ahb" specifier for these addresses either.
I did not go very far into this bit of code; is this because
the hardware does not support that option?

This is apparently only used for reading a list of (AHB?)
addresses.  There is no write option, and perhaps that isn't
needed in practice, but it could be useful.  Is this also
a hardware limitation?

> +		   3->The series of addresses to be entered separated by a space like <addr1>
> +		      <addr2>... and so on.
> +
> +What:           /sys/kernel/debug/dcc/.../config_reset
> +Date:           March 2022
> +Contact:        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> +Description:
> +		This file is used to reset the configuration of
> +		a dcc driver to the default configuration. This
> +		means that all the previous addresses stored in
> +		the driver gets removed and user needs to enter
> +		the address values from the start.
> +		Example:
> +		echo  1 > /sys/kernel/debug/dcc/../config_reset
> +
> +What:		/sys/kernel/debug/dcc/.../ready
> +Date:		March 2022
> +Contact		Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> +Description:
> +		This file is used to check the status of the dcc
> +		hardware if it's ready to take the inputs. A 0
> +		here indicates dcc is in a ready condition.

I find this interface to be counter-intuitive.

Could you make this be interpreted as a Boolean instead?
It's read-only; and its contents could be "N" or "Y" (which
would make interpretation of the "ready" name very clear).

> +		Example:
> +		cat /sys/kernel/debug/dcc/.../ready
> +
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index 79b568f..5101912 100644
> --- a/drivers/soc/qcom/Kconfig
> +++ b/drivers/soc/qcom/Kconfig
> @@ -69,6 +69,14 @@ config QCOM_LLCC
>   	  SDM845. This provides interfaces to clients that use the LLCC.
>   	  Say yes here to enable LLCC slice driver.
>   
> +config QCOM_DCC
> +	tristate "Qualcomm Technologies, Inc. Data Capture and Compare(DCC) engine driver"
> +	depends on ARCH_QCOM || COMPILE_TEST
> +	help
> +	  This option enables driver for Data Capture and Compare engine. DCC
> +	  driver provides interface to configure DCC block and read back
> +	  captured data from DCC's internal SRAM.
> +
>   config QCOM_KRYO_L2_ACCESSORS
>   	bool
>   	depends on ARCH_QCOM && ARM64 || COMPILE_TEST
> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
> index ad675a6..0aaf82b 100644
> --- a/drivers/soc/qcom/Makefile
> +++ b/drivers/soc/qcom/Makefile
> @@ -4,6 +4,7 @@ obj-$(CONFIG_QCOM_AOSS_QMP) +=	qcom_aoss.o
>   obj-$(CONFIG_QCOM_GENI_SE) +=	qcom-geni-se.o
>   obj-$(CONFIG_QCOM_COMMAND_DB) += cmd-db.o
>   obj-$(CONFIG_QCOM_CPR)		+= cpr.o
> +obj-$(CONFIG_QCOM_DCC) += dcc.o
>   obj-$(CONFIG_QCOM_GSBI)	+=	qcom_gsbi.o
>   obj-$(CONFIG_QCOM_MDT_LOADER)	+= mdt_loader.o
>   obj-$(CONFIG_QCOM_OCMEM)	+= ocmem.o
> diff --git a/drivers/soc/qcom/dcc.c b/drivers/soc/qcom/dcc.c
> new file mode 100644
> index 0000000..8f85bd1
> --- /dev/null
> +++ b/drivers/soc/qcom/dcc.c
> @@ -0,0 +1,1359 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2015-2021, The Linux Foundation. All rights reserved.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/debugfs.h>
> +#include <linux/delay.h>
> +#include <linux/fs.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/miscdevice.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/uaccess.h>
> +
> +#define STATUS_READY_TIMEOUT		5000

#define STATUS_READY_TIMEOUT		5000	/* microseconds */

> +
> +#define DCC_SRAM_NODE "dcc_sram"

It would be nice to know which of the flags/fields below are
associated with which of the DCC registers.  I think most are
for the HW_INFO register.

> +/* DCC registers */
> +#define DCC_HW_INFO			0x04
> +#define DCC_LL_NUM_INFO			0x10

The LL_NUM_INFO register is only used for v2 and v3.

> +#define DCC_STATUS			0x1C

I think you should define these offsets a little differently.
The whole mapping things makes it hard to follow what's really
going on.

> +#define DCC_LL_LOCK(m)			(0x34 + 0x80 * m)
> +#define DCC_LL_CFG(m)			(0x38 + 0x80 * m)
> +#define DCC_LL_BASE(m)			(0x3c + 0x80 * m)
> +#define DCC_FD_BASE(m)			(0x40 + 0x80 * m)

What is "FD"?  (It's the only thing used in these registers
that is not "LL".)

> +#define DCC_LL_TIMEOUT(m)		(0x44 + 0x80 * m)
> +#define DCC_LL_INT_ENABLE(m)		(0x4C + 0x80 * m)
> +#define DCC_LL_INT_STATUS(m)		(0x50 + 0x80 * m)
> +#define DCC_LL_SW_TRIGGER(m)		(0x60 + 0x80 * m)
> +#define DCC_LL_BUS_ACCESS_STATUS(m)	(0x64 + 0x80 * m)

These symbols are done so that v1, v2, and v3 can use the above
offsets.  But in fact, it's rare that the above offsets are the
ones actually used (they're often modified by subtracting the
one or another of the "OFFSET" values below).

> +#define DCC_MAP_LEVEL1			0x18
> +#define DCC_MAP_LEVEL2			0x34
> +#define DCC_MAP_LEVEL3			0x4C
> +
> +#define DCC_MAP_OFFSET1			0x10
> +#define DCC_MAP_OFFSET2			0x18
> +#define DCC_MAP_OFFSET3			0x1C
> +#define DCC_MAP_OFFSET4			0x8

What I recommend instead is to do this:

     #define DCC_HW_INFO		0x04
     #define DCC_LL_NUM_INFO	0x10
     #define DCC_STATUS(vers)	((vers) == 1 ? 0x0c : 0x1c)

After those three registers there is a block of 9 registers
for each of the "linked lists" supported by the hardware.
The offset of each of these is different, depending on version.

I think it would be simpler to do something like this:

     #define DCC_LL_OFFSET(vers) \
		(vers) == 1 ? 0x1c : (vers) == 2 ? 0x2c : 0x34)
     #define DCC_LL_LOCK	0x00
     #define DCC_LL_CFG	0x04

And then define something like:

     static inline u32
     dcc_ll_readl(struct dcc_drvdata *drvdata, u32 ll, u32 off)

     {

         u32 offset = DCC_LL_OFFSET(drvdata->mem_map_vers) + off;

         return readl(drvdata->base + ll * 0x80 + offset);
     }

The result of my suggestion is the same, but I think it's a
little more obvious what you're doing.

> +#define DCC_FIX_LOOP_OFFSET		16

The above is a default value used if a bit 6 in the HW_INFO register
is set.

> +#define DCC_VER_INFO_BIT		9

But this is a bit position in the HW_INFO register.  Please either
define these flags and fields in registers using a mask, rather
than doing a mix of bit positions and masks.  What I mean is, this
should be defined (and used) as:

     #define DCC_VER_INFO_MASK		BIT(9)

You could easily improve readability here with a few one-line
descriptions of what these symbols (or groups of them) represent.

And the grouping to me doesn't make a lot of sense.  (I'll leave
it at that; maybe I'll comment more in your next version.)

> +#define DCC_READ			0
> +#define DCC_WRITE			1
> +#define DCC_LOOP			2
> +#define DCC_READ_WRITE			3
> +
> +#define MAX_DCC_OFFSET			GENMASK(9, 2)
> +#define MAX_DCC_LEN			GENMASK(6, 0)
> +#define MAX_LOOP_CNT			GENMASK(7, 0)
> +#define MAX_LOOP_ADDR			10
> +
> +#define DCC_ADDR_DESCRIPTOR		0x00
> +#define DCC_ADDR_LIMIT			27
> +#define DCC_ADDR_OFF_RANGE		8
> +#define DCC_ADDR_RANGE			GENMASK(31, 4)
> +#define DCC_LOOP_DESCRIPTOR		BIT(30)
> +#define DCC_RD_MOD_WR_DESCRIPTOR	BIT(31)
> +#define DCC_LINK_DESCRIPTOR		GENMASK(31, 30)
> +#define DCC_STATUS_MASK			GENMASK(1, 0)
> +#define DCC_LOCK_MASK                   BIT(0)
> +#define DCC_LOOP_OFFSET_MASK		BIT(6)
> +#define DCC_TRIGGER_MASK		BIT(9)
> +
> +#define DCC_READ_IND			0x00
> +#define DCC_WRITE_IND			(BIT(28))
> +
> +#define DCC_AHB_IND			0x00
> +#define DCC_APB_IND			BIT(29)
> +
> +#define DCC_MAX_LINK_LIST		8
> +#define DCC_INVALID_LINK_LIST		GENMASK(7, 0)
> +
> +#define DCC_VER_MASK1			GENMASK(6, 0)
> +#define DCC_VER_MASK2			GENMASK(5, 0)
> +
> +#define DCC_RD_MOD_WR_ADDR              0xC105E
> +
> +/*DCC debugfs directory*/
> +static struct dentry	*dcc_dbg;
> +
> +enum dcc_descriptor_type {
> +	DCC_ADDR_TYPE,

Maybe DCC_READ_TYPE instead of DCC_ADDR_TYPE?  I realize it differs
in that it takes a count of consecutive addresses to read.

> +	DCC_LOOP_TYPE,
> +	DCC_READ_WRITE_TYPE,
> +	DCC_WRITE_TYPE
> +};
> +
> +struct dcc_config_entry {
> +	u32				base;
> +	u32				offset;
> +	u32				len;
> +	u32				index;

What is the purpose of recording the index in each config entry?

> +	u32				loop_cnt;
> +	u32				write_val;
> +	u32				mask;
> +	bool				apb_bus;
> +	enum dcc_descriptor_type	desc_type;
> +	struct list_head		list;
> +};
> +
> +/**
> + * struct dcc_drvdata - configuration information related to a dcc device
> + * @base:	      Base Address of the dcc device
> + * @dev:	      The device attached to the driver data
> + * @mutex:	      Lock to protect access and manipulation of dcc_drvdata
> + * @ram_base:         Base address for the SRAM dedicated for the dcc device
> + * @ram_offset:       Offset to the SRAM dedicated for dcc device
> + * @mem_map_ver:      Memory map version of DCC hardware
> + * @ram_cfg:          Used for address limit calculation for dcc
> + * @ram_start:        Starting address of DCC SRAM
> + * @sram_dev:	      Micellaneous device equivalent of dcc SRAM
> + * @sram_class:	      Class equivalent of the DCC SRAM device

You no longer use the sram_class field, so get rid of it.

> + * @cfg_head:	      Points to the head of the linked list of addresses
> + * @dbg_dir:          The dcc debugfs directory under which all the debugfs files are placed
> + * @nr_config:        Stores the number of addresses currently configured for a linkedlist

What is the purpose of recording the number of elements on each
linked list?

> + * @nr_link_list:     Total number of linkedlists supported by the DCC configuration
> + * @curr_list:        The index of the current linklist with which the driver is working

I am almost certain there is no need for you to maintain the notion of a
"current list" in this structure.  Your new layout, defining a directory
for each list, should make the list being operated upon implicit in all
cases.

> + * @loopoff:          Loop offset bits range for the addresses
> + * @enable:           This contains an array of linkedlist enable flags
> + * @interrupt_disable:Flag to enable/disable interrupts

You no longer use the interrupt_disable field, so get rid of it.

> + */
> +struct dcc_drvdata {
> +	void __iomem		*base;
> +	struct device		*dev;
> +	struct mutex		mutex;
> +	void __iomem		*ram_base;
> +	size_t			ram_size;
> +	size_t			ram_offset;
> +	int			mem_map_ver;
> +	phys_addr_t		ram_cfg;
> +	phys_addr_t		ram_start;
> +	struct miscdevice	sram_dev;
> +	struct class		*sram_class;
> +	struct list_head	*cfg_head;
> +	struct dentry		*dbg_dir;
> +	size_t			*nr_config;
> +	size_t			nr_link_list;
> +	u8			curr_list;
> +	u8			loopoff;
> +	bool                    *enable;
> +	bool                    interrupt_disable;
> +};
> +
> +struct dcc_cfg_attr {
> +	u32	addr;
> +	u32	prev_addr;
> +	u32	prev_off;
> +	u32	link;
> +	u32	sram_offset;
> +};
> +
> +struct dcc_cfg_loop_attr {
> +	u32	loop;
> +	u32	loop_cnt;
> +	u32	loop_len;
> +	u32	loop_off;
> +	bool    loop_start;
> +};
> +
> +static size_t dcc_offset_conv(struct dcc_drvdata *drvdata, size_t off)
> +{
> +	/* If the memory map version is 1, adjust the offset based on
> +	 * the dcc version mask. If the memory map version is 2
> +	 * adjust the offset if the dcc version mask is greater than
> +	 * map level 2.For other conditions, just return the offset.
> +	 */
> +	if (drvdata->mem_map_ver == 1) {
> +		if (FIELD_GET(DCC_VER_MASK1, off) >= DCC_MAP_LEVEL3)
> +			return off - DCC_MAP_OFFSET3;
> +		if (FIELD_GET(DCC_VER_MASK1, off) >= DCC_MAP_LEVEL2)
> +			return off - DCC_MAP_OFFSET2;
> +		else if (FIELD_GET(DCC_VER_MASK1, off) >= DCC_MAP_LEVEL1)
> +			return off - DCC_MAP_OFFSET1;
> +	} else if (drvdata->mem_map_ver == 2) {
> +		if (FIELD_GET(DCC_VER_MASK1, off) >= DCC_MAP_LEVEL2)
> +			return off - DCC_MAP_OFFSET4;
> +	}
> +
> +	return off;
> +}
> +
> +static inline void dcc_writel(struct dcc_drvdata *drvdata,
> +					u32 val, u32 off)
> +{
> +	writel((val), drvdata->base + dcc_offset_conv(drvdata, off));
> +}
> +
> +static inline u32 dcc_readl(struct dcc_drvdata *drvdata, u32 off)
> +{
> +	return readl(drvdata->base + dcc_offset_conv(drvdata, off));
> +}

Unlike dcc_writel() and dcc_readl(), this auto-increments the offset.
I realize this is used for different memory, but I feel like it would
be clearer if you indicated this in the name.  So for example, call
this dcc_sram_write_auto() or something.  (I'm not sure that name is
an improvement, however.)

> +static void dcc_sram_writel(struct dcc_drvdata *drvdata,
> +					u32 val, u32 *off)
> +{
> +	writel(val, drvdata->ram_base + *off);
> +
> +	*off += 4;
> +}
> +
> +static int dcc_read_and_clear(struct dcc_drvdata *drvdata)
> +{
> +	int i;
> +	u32 bus_status;
> +	u32 ll_cfg;
> +	u32 tmp_ll_cfg;
> +
> +	for (i = 0; i < drvdata->nr_link_list; i++) {
> +		if (!drvdata->enable[i])
> +			continue;
> +
> +		bus_status = dcc_readl(drvdata, DCC_LL_BUS_ACCESS_STATUS(i));
> +		if (bus_status) {

Consider:

		if (!bus_status)
			continue;

		dev_err(drvdata->dev, ...

> +			dev_err(drvdata->dev,
> +				"Read access error for list %d err: 0x%x.\n",
> +					i, bus_status);
> +
> +			ll_cfg = dcc_readl(drvdata, DCC_LL_CFG(i));
> +			tmp_ll_cfg = ll_cfg & ~DCC_TRIGGER_MASK;
> +			dcc_writel(drvdata, tmp_ll_cfg, DCC_LL_CFG(i));
> +			dcc_writel(drvdata, DCC_STATUS_MASK,
> +				DCC_LL_BUS_ACCESS_STATUS(i));
> +			dcc_writel(drvdata, ll_cfg, DCC_LL_CFG(i));
> +			return -ENODATA;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int dcc_sw_trigger(struct dcc_drvdata *drvdata)
> +{
> +	int ret;
> +	int i;
> +	u32 ll_cfg;
> +	u32 tmp_ll_cfg;
> +	u32 val;
> +
> +	mutex_lock(&drvdata->mutex);
> +
> +	for (i = 0; i < drvdata->nr_link_list; i++) {
> +		if (!drvdata->enable[i])
> +			continue;
> +		ll_cfg = dcc_readl(drvdata, DCC_LL_CFG(i));
> +		tmp_ll_cfg = ll_cfg & ~DCC_TRIGGER_MASK;
> +		dcc_writel(drvdata, tmp_ll_cfg, DCC_LL_CFG(i));
> +		dcc_writel(drvdata, 1, DCC_LL_SW_TRIGGER(i));
> +		dcc_writel(drvdata, ll_cfg, DCC_LL_CFG(i));
> +	}


Maybe simplify this with a local variable for the address:

     addr = drvdata->base + dcc_offset_conv(drvdata, DCC_STATUS);
     if (readl_poll_timeout(addr, val, !FIELD_GET(DCC_STATUS_MASK, val),
			   1, STATUS_READY_TIMEOUT)) {
	...
     }


> +	if (readl_poll_timeout((drvdata->base + dcc_offset_conv(drvdata, DCC_STATUS)),
> +	    val, (FIELD_GET(DCC_STATUS_MASK, val) == 0), 1, STATUS_READY_TIMEOUT)) {
> +		dev_err(drvdata->dev,
> +			"DCC is busy after receiving sw tigger.\n");
> +		ret = -EBUSY;
> +		goto err;
> +	}
> +
> +	ret = dcc_read_and_clear(drvdata);

The following label is also used for the normal/successful path.  Maybe
you could rename it "out_unlock" or something.  (You do the same thing
in a few other places as well.)

> +err:
> +	mutex_unlock(&drvdata->mutex);
> +	return ret;
> +}
> +

. . .


> +static int dcc_valid_list(struct dcc_drvdata *drvdata, int curr_list)
> +{
> +	u32 lock_reg;
> +
> +	if (list_empty(&drvdata->cfg_head[curr_list]))
> +		return -EINVAL;
> +
> +	if (drvdata->enable[curr_list]) {
> +		dev_err(drvdata->dev, "List %d is already enabled\n",
> +				curr_list);
> +		return -EINVAL;
> +	}
> +
> +	lock_reg = dcc_readl(drvdata, DCC_LL_LOCK(curr_list));
> +	if (lock_reg & 0x1) {

s/0x1/DCC_LOCK_MASK/

> +		dev_err(drvdata->dev, "List %d is already locked\n",
> +				curr_list);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static bool is_dcc_enabled(struct dcc_drvdata *drvdata)
> +{
> +	bool dcc_enable = false;
> +	int list;
> +

If you kept a top-level count of the number of lists that
have been enabled, any non-zero count means one or more
of the lists is enabled.

> +	for (list = 0; list < DCC_MAX_LINK_LIST; list++) {
> +		if (drvdata->enable[list]) {
> +			dcc_enable = true;
> +			break;
> +		}
> +	}
> +
> +	return dcc_enable;
> +}

Pass curr_list as an argument to this function.

> +static int dcc_enable(struct dcc_drvdata *drvdata)
> +{
> +	int ret;
> +	int list = drvdata->curr_list;

I don't think there's any need to maintain curr_list in the
drvdata structure.  Use "curr_list" to represent the current
list number (passed in as argument) rather than "list", for
consistency.

> +	u32 ram_cfg_base;
> +
> +	mutex_lock(&drvdata->mutex);
> +
> +	if (!is_dcc_enabled(drvdata)) {

Why are you filling memory with 0xde?  In two other places (one
of which is commented out) you zero it instead.

> +		memset_io(drvdata->ram_base,
> +			0xde, drvdata->ram_size);
> +	}

Check whether the list is valid, before you write bytes to the SRAM.

> +	ret = dcc_valid_list(drvdata, list);

BUG:  You are holding the mutex here.  Use "goto out_unlock;"

> +	if (ret)
> +		return ret;
> +
> +	/* 1. Take ownership of the list */
> +	dcc_writel(drvdata, DCC_LOCK_MASK, DCC_LL_LOCK(list));
> +
> +	/* 2. Program linked-list in the SRAM */
> +	ram_cfg_base = drvdata->ram_cfg;
> +	ret = __dcc_emit_config(drvdata, list);
> +	if (ret) {
> +		dcc_writel(drvdata, 0, DCC_LL_LOCK(list));
> +		goto err;
> +	}
> +
> +	/* 3. program DCC_RAM_CFG reg */

s/pro/Pro/

> +	dcc_writel(drvdata, ram_cfg_base +
> +			drvdata->ram_offset/4, DCC_LL_BASE(list));
> +	dcc_writel(drvdata, drvdata->ram_start +
> +			drvdata->ram_offset/4, DCC_FD_BASE(list));
> +	dcc_writel(drvdata, 0xFFF, DCC_LL_TIMEOUT(list));
> +
> +	/* 4. Clears interrupt status register */
> +	dcc_writel(drvdata, 0, DCC_LL_INT_ENABLE(list));
> +	dcc_writel(drvdata, (BIT(0) | BIT(1) | BIT(2)),
> +					DCC_LL_INT_STATUS(list));
> +
> +	drvdata->enable[list] = true;
> +
> +	/* 5. Configure trigger */
> +	dcc_writel(drvdata, DCC_TRIGGER_MASK, DCC_LL_CFG(list));
> +
> +err:

I'd rename the label "out_unlock".

> +	mutex_unlock(&drvdata->mutex);
> +	return ret;
> +}

Pass the curr_list value as an argument to this function.

> +static void dcc_disable(struct dcc_drvdata *drvdata)
> +{
> +	int curr_list = drvdata->curr_list;
> +
> +	mutex_lock(&drvdata->mutex);
> +
> +
> +	if (!drvdata->enable[curr_list])
> +		return;

BUG:  You are holding the mutex here.

> +	dcc_writel(drvdata, 0, DCC_LL_CFG(curr_list));
> +	dcc_writel(drvdata, 0, DCC_LL_BASE(curr_list));
> +	dcc_writel(drvdata, 0, DCC_FD_BASE(curr_list));
> +	dcc_writel(drvdata, 0, DCC_LL_LOCK(curr_list));
> +	drvdata->enable[curr_list] = false;
> +	mutex_unlock(&drvdata->mutex);
> +}

Move the definition of trigger_write() and trigger_fops up higher
in the source file, before _dcc_emit_read_write(), or perhaps
lower, below enable_fops.

> +static ssize_t trigger_write(struct file *filp,
> +			     const char __user *user_buf, size_t count,
> +			     loff_t *ppos)
> +{
> +	int ret = 0;
> +	unsigned int val;
> +	struct dcc_drvdata *drvdata = filp->private_data;
> +
> +	ret = kstrtouint_from_user(user_buf, count, 0, &val);
> +	if (ret < 0)
> +		return ret;

Does it really matter what is written?  Shouldn't any number of
bytes of any value be sufficient to cause the trigger?

> +	if (val != 1)
> +		return -EINVAL;
> +
> +	ret = dcc_sw_trigger(drvdata);
> +	if (!ret)
> +		ret = count;
> +
> +	return ret;
> +}
> +
> +static const struct file_operations trigger_fops = {
> +	.write = trigger_write,
> +	.open = simple_open,
> +	.llseek = generic_file_llseek,
> +};
> +
> +static ssize_t enable_read(struct file *filp, char __user *userbuf,
> +				size_t count, loff_t *ppos)
> +{
> +	int ret;
> +	bool dcc_enable = false;

No need to initialize dcc_enable.

> +	char buf[20];
> +	struct dcc_drvdata *drvdata = filp->private_data;
> +
> +	mutex_lock(&drvdata->mutex);
> +	if (drvdata->curr_list >= drvdata->nr_link_list) {
> +		dev_err(drvdata->dev, "Select link list to program using curr_list\n");
> +		ret = -EINVAL;
> +		goto err;
> +	}
> +
> +	dcc_enable = is_dcc_enabled(drvdata);
> +
> +	ret = scnprintf(buf, PAGE_SIZE, "%u\n",

BUG:  The size of the buffer is 20 bytes.  Pass sizeof(buf), not
PAGE_SIZE.

Can you make this contain a Boolean value instead?  I.e., it's
a string containing "Y" or "N"?  A 2 byte buffer is sufficient
for that.

> +				(unsigned int)dcc_enable);
> +err:
> +	mutex_unlock(&drvdata->mutex);
> +	if (ret > 0)
> +		return simple_read_from_buffer(userbuf, count, ppos, buf, ret);
> +	else
> +		return ret;
> +}
> +
> +static ssize_t enable_write(struct file *filp, const char __user *userbuf,
> +				size_t count, loff_t *ppos)
> +{
> +	int ret = 0, curr_list;
> +	unsigned int val;
> +	struct dcc_drvdata *drvdata = filp->private_data;

You repeat the next two lines pretty often, and it's doing something
meaningful.  I suggest you encapsulate it in a function:

     static u32 dcc_filp_curr_list(struct file *filp)
     {
         struct dentry *dentry = file_dentry(filp);
         int curr_list;

         kstrtoint(dentry->d_parent->d_name.name, 0, &curr_list);

	return curr_list;
     }

> +	ret = kstrtoint(file_dentry(filp)->d_parent->d_name.name, 0, &curr_list);
> +	drvdata->curr_list = curr_list;

Just pass curr_list to dcc_enable() and dcc_disable().  Don't bother
writing it into the drvdata structure.

> +
> +	ret = kstrtouint_from_user(userbuf, count, 0, &val);
> +	if (ret < 0)
> +		return ret;

You could use kstrtobool_from_user() instead.

> +
> +	if (val)
> +		ret = dcc_enable(drvdata);
> +	else
> +		dcc_disable(drvdata);
> +
> +	if (!ret)
> +		ret = count;
> +
> +	return ret;
> +}
> +
> +static const struct file_operations enable_fops = {
> +	.read = enable_read,
> +	.write = enable_write,
> +	.open = simple_open,
> +	.llseek = generic_file_llseek,
> +};
> +

Pass the curr_list value as an argument to this function.

> +static int dcc_config_add(struct dcc_drvdata *drvdata, unsigned int addr,
> +				unsigned int len, int apb_bus)
> +{
> +	int ret = 0;
> +	struct dcc_config_entry *entry, *pentry;
> +	unsigned int base, offset;
> +
> +	mutex_lock(&drvdata->mutex);

I think you can assume the passed-in curr_list value is valid.

> +	if (drvdata->curr_list >= drvdata->nr_link_list) {
> +		dev_err(drvdata->dev, "Select link list to program using curr_list\n");
> +		ret = -EINVAL;
> +		goto err;
> +	}
> +
> +	if (!len || len > (drvdata->ram_size / DCC_ADDR_OFF_RANGE)) {

No need for parentheses surrounding the division above.  What exactly
does DCC_ADDR_OFF_RANGE (= 8) represent?  Is the length expressed in
terms of 8-byte units?  (Is that a "word" size?)

> +		dev_err(drvdata->dev, "DCC: Invalid length\n");
> +		ret = -EINVAL;
> +		goto err;
> +	}
> +
> +	base = addr & DCC_ADDR_RANGE;

The above operation is only valid because DCC_ADDR_RANGE is intended
to be a mask.  Somehow the name doesn't convey that to me.

> +	if (!list_empty(&drvdata->cfg_head[drvdata->curr_list])) {
> +		pentry = list_last_entry(&drvdata->cfg_head[drvdata->curr_list],
> +			struct dcc_config_entry, list);
> +
> +		if (pentry->desc_type == DCC_ADDR_TYPE &&
> +				addr >= (pentry->base + pentry->offset) &&
> +				addr <= (pentry->base +
> +					pentry->offset + MAX_DCC_OFFSET)) {
> +
> +			/* Re-use base address from last entry */
> +			base = pentry->base;
> +
> +			if ((pentry->len * 4 + pentry->base + pentry->offset)
> +					== addr) {
> +				len += pentry->len;
> +
> +				if (len > MAX_DCC_LEN)
> +					pentry->len = MAX_DCC_LEN;
> +				else
> +					pentry->len = len;
> +
> +				addr = pentry->base + pentry->offset +
> +					pentry->len * 4;
> +				len -= pentry->len;
> +			}
> +		}
> +	}
> +
> +	offset = addr - base;
> +
> +	while (len) {
> +		entry = devm_kzalloc(drvdata->dev, sizeof(*entry), GFP_KERNEL);
> +		if (!entry) {
> +			ret = -ENOMEM;
> +			goto err;
> +		}
> +
> +		entry->base = base;
> +		entry->offset = offset;
> +		entry->len = min_t(u32, len, MAX_DCC_LEN);
> +		entry->index = drvdata->nr_config[drvdata->curr_list]++;
> +		entry->desc_type = DCC_ADDR_TYPE;
> +		entry->apb_bus = apb_bus;
> +		INIT_LIST_HEAD(&entry->list);
> +		list_add_tail(&entry->list,
> +			&drvdata->cfg_head[drvdata->curr_list]);
> +
> +		len -= entry->len;
> +		offset += MAX_DCC_LEN * 4;
> +	}
> +
> +err:
> +	mutex_unlock(&drvdata->mutex);
> +	return ret;
> +}

. . .

> +static void dcc_config_reset(struct dcc_drvdata *drvdata)
> +{
> +	struct dcc_config_entry *entry, *temp;
> +	int curr_list;
> +
> +	mutex_lock(&drvdata->mutex);
> +
> +	for (curr_list = 0; curr_list < drvdata->nr_link_list; curr_list++) {
> +		list_for_each_entry_safe(entry, temp,
> +			&drvdata->cfg_head[curr_list], list) {
> +			list_del(&entry->list);
> +			devm_kfree(drvdata->dev, entry);
> +			drvdata->nr_config[curr_list]--;
> +		}
> +	}

You need to either include the next line, or not.  Don't comment
it out, and not with "//".  I think you should include it (but
explain why it's writing zeroes here and 0xde elsewhere).

> +	//memset_io(drvdata->ram_base, 0, drvdata->ram_size);
> +	drvdata->ram_start = 0;
> +	drvdata->ram_cfg = 0;
> +	mutex_unlock(&drvdata->mutex);
> +}
> +

. . .

> +static ssize_t ready_read(struct file *filp, char __user *userbuf,
> +			size_t count, loff_t *ppos)
> +{
> +	int ret;
> +	char buf[20];
> +	struct dcc_drvdata *drvdata = filp->private_data;
> +
> +	mutex_lock(&drvdata->mutex);
> +
> +	if (drvdata->curr_list >= drvdata->nr_link_list) {
> +		dev_err(drvdata->dev, "Select link list to program using curr_list\n");
> +		ret = -EINVAL;
> +		goto err;
> +	}
> +
> +	if (!drvdata->enable[drvdata->curr_list]) {
> +		ret = -EINVAL;
> +		goto err;
> +	}
> +
> +	ret = scnprintf(buf, PAGE_SIZE, "%u\n",

BUG.  Use sizeof(buf) instead of PAGE_SIZE.

Also, how about making this file Boolean too?  Just have it
output "Y" or "N".

> +			(unsigned int)FIELD_GET(BIT(1), dcc_readl(drvdata, DCC_STATUS)));
> +err:
> +	mutex_unlock(&drvdata->mutex);
> +
> +	if (ret > 0)
> +		return simple_read_from_buffer(userbuf, count, ppos, buf, ret);
> +	else
> +		return ret;
> +}
> +
> +static const struct file_operations ready_fops = {
> +	.read = ready_read,
> +	.open = simple_open,
> +	.llseek = generic_file_llseek,
> +};
> +
> +static int dcc_add_loop(struct dcc_drvdata *drvdata, unsigned long loop_cnt)
> +{
> +	struct dcc_config_entry *entry;
> +
> +	entry = devm_kzalloc(drvdata->dev, sizeof(*entry), GFP_KERNEL);
> +	if (!entry)
> +		return -ENOMEM;
> +
> +	entry->loop_cnt = min_t(u32, loop_cnt, MAX_LOOP_CNT);
> +	entry->index = drvdata->nr_config[drvdata->curr_list]++;
> +	entry->desc_type = DCC_LOOP_TYPE;
> +	INIT_LIST_HEAD(&entry->list);

No need to call INIT_LIST_HEAD() before list_add*() functions.
(Here and elsewhere.)

> +	list_add_tail(&entry->list, &drvdata->cfg_head[drvdata->curr_list]);
> +
> +	return 0;
> +}
> +
> +static ssize_t dcc_config_add_loop(struct dcc_drvdata *drvdata, char *buf)
> +{
> +	int ret, cnt = 2, i = 0;
> +	char *token, *input;
> +	char delim[2] = " ";
> +	unsigned int val[MAX_LOOP_ADDR];

What is the purpose of using an input pointer rather than just the
passed-in buf pointer?

> +	input = buf;
> +
> +	token = strsep(&input, delim);

	while ((token = strsep(&input, delim))) {

> +	while (token != NULL) {
> +		ret = kstrtoint(token, 0, &val[i++]);

Nothing prevents you from overrunning your val[] buffer.

> +		if (ret)
> +			return ret;
> +
> +		token = strsep(&input, delim);
> +	}
> +
> +	ret = dcc_add_loop(drvdata, val[0]);
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i < val[1]; i++)
> +		dcc_config_add(drvdata, val[cnt++], 1, 0);
> +
> +	ret = dcc_add_loop(drvdata, 1);
> +
> +	return ret;
> +}


Pass curr_list in as an argument here.

> +static int dcc_rd_mod_wr_add(struct dcc_drvdata *drvdata, unsigned int mask,
> +				unsigned int val)
> +{
> +	int ret = 0;
> +	struct dcc_config_entry *entry;
> +
> +	mutex_lock(&drvdata->mutex);

And I think you can assume the passed-in curr_list value is valid.

> +	if (drvdata->curr_list >= drvdata->nr_link_list) {
> +		dev_err(drvdata->dev, "Select link list to program using curr_list\n");
> +		ret = -EINVAL;
> +		goto err;
> +	}
> +
> +	if (list_empty(&drvdata->cfg_head[drvdata->curr_list])) {
> +		dev_err(drvdata->dev, "DCC: No read address programmed\n");
> +		ret = -EPERM;
> +		goto err;
> +	}
> +
> +	entry = devm_kzalloc(drvdata->dev, sizeof(*entry), GFP_KERNEL);
> +	if (!entry) {
> +		ret = -ENOMEM;
> +		goto err;
> +	}
> +
> +	entry->desc_type = DCC_READ_WRITE_TYPE;
> +	entry->mask = mask;
> +	entry->write_val = val;
> +	entry->index = drvdata->nr_config[drvdata->curr_list]++;
> +	INIT_LIST_HEAD(&entry->list);
> +	list_add_tail(&entry->list, &drvdata->cfg_head[drvdata->curr_list]);
> +err:
> +	mutex_unlock(&drvdata->mutex);
> +	return ret;
> +}
> +
> +static ssize_t dcc_config_add_read_write(struct dcc_drvdata *drvdata, char *buf)
> +{
> +	int ret;
> +	int nval;
> +	unsigned int addr, mask, val;
> +
> +	nval = sscanf(buf, "%x %x %x", &addr, &mask, &val);

You use sscanf() here and kstrtoint() elsewhere.  The latter is better,
and allows the base to be 0 (meaning numeric values can be provided in
any base, using normal conventions).

> +	if (nval <= 1 || nval > 3)
> +		return -EINVAL;
> +
> +	ret = dcc_config_add(drvdata, addr, 1, 0);
> +	if (ret)
> +		return ret;
> +
> +	ret = dcc_rd_mod_wr_add(drvdata, mask, val);
> +	return ret;
> +
> +}
> +
> +static int dcc_add_write(struct dcc_drvdata *drvdata, unsigned int addr,
> +				unsigned int write_val, int apb_bus)
> +{
> +	struct dcc_config_entry *entry;
> +
> +	entry = devm_kzalloc(drvdata->dev, sizeof(*entry), GFP_KERNEL);
> +	if (!entry)
> +		return -ENOMEM;
> +
> +	entry->desc_type = DCC_WRITE_TYPE;
> +	entry->base = addr & GENMASK(31, 4);

s/GENMASK(31, 4)/DCC_ADDR_RANGE/

> +	entry->offset = addr - entry->base;
> +	entry->write_val = write_val;

Is there a maximum index value?  I really don't see what the
benefit is of tracking the index in the entry, and the number
of configs in the drvdata structure.

> +	entry->index = drvdata->nr_config[drvdata->curr_list]++;
> +	entry->len = 1;
> +	entry->apb_bus = apb_bus;
> +	INIT_LIST_HEAD(&entry->list);
> +	list_add_tail(&entry->list, &drvdata->cfg_head[drvdata->curr_list]);
> +
> +	return 0;
> +}
> +
> +static ssize_t dcc_config_add_write(struct dcc_drvdata *drvdata, char *buf)
> +{
> +	int ret;
> +	int nval;
> +	unsigned int addr, write_val;
> +	int apb_bus = 0;
> +
> +	nval = sscanf(buf, "%x %x %d", &addr, &write_val, &apb_bus);

Try to use kstrtoint() instead of sscanf().

Suggested elsewhere:  I think the ahb/apb should be specified with a
string "apb" or "ahb" rather than 0 or 1.

> +
> +	if (nval <= 1 || nval > 3)
> +		return -EINVAL;
> +
> +	if (nval == 3 && apb_bus != 0)
> +		apb_bus = 1;
> +
> +	ret = dcc_add_write(drvdata, addr, write_val, apb_bus);
> +
> +	return ret;
> +}
> +
> +static ssize_t config_read(struct file *filp, char __user *userbuf,
> +				size_t count, loff_t *ppos)
> +{
> +	struct dcc_drvdata *drvdata = filp->private_data;
> +	struct dcc_config_entry *entry;
> +	char local_buf[64], buf[100] = "\0";
> +	int len = 0, tot_len = 0, ret = 0, curr_list;
> +
> +	mutex_lock(&drvdata->mutex);
> +	ret = kstrtoint(file_dentry(filp)->d_parent->d_name.name, 0, &curr_list);
> +	if (ret)
> +		return ret;

BUG:  You are holding the mutex here.

> +
> +	drvdata->curr_list = curr_list;
> +

If you want to print an index, you could just maintain that
locally.  Initialize it to 0, and increment it each time
through the loop.  No need to store it in the entry.

> +	list_for_each_entry(entry,
> +	&drvdata->cfg_head[drvdata->curr_list], list) {
> +		switch (entry->desc_type) {
> +		case DCC_READ_WRITE_TYPE:
> +			len = snprintf(local_buf, 64,

How about, rather than formatting the output the way you do here, you
have the format match exactly what would have been provided as input
(assuming hexidecimal numbers though).   So for example, a READ_WRITE
would be:

     RW 0x<addr> 0x<mask> 0x<val>


> +					"Index: 0x%x, mask: 0x%x, val: 0x%x\n",
> +					entry->index, entry->mask, entry->write_val);
> +			break;
> +		case DCC_LOOP_TYPE:
> +			len = snprintf(local_buf, 64, "Index: 0x%x, Loop: %d\n",
> +					entry->index, entry->loop_cnt);
> +			break;
> +		case DCC_WRITE_TYPE:
> +			len = snprintf(local_buf, 64,
> +					"Write Index: 0x%x, Base: 0x%x, Offset: 0x%x, len: 0x%x APB: %d\n",
> +					entry->index, entry->base, entry->offset, entry->len,
> +					entry->apb_bus);
> +			break;
> +		case DCC_ADDR_TYPE:
> +			len = snprintf(local_buf, 64,
> +					"Read Index: 0x%x, Base: 0x%x, Offset: 0x%x, len: 0x%x APB: %d\n",
> +					entry->index, entry->base, entry->offset,
> +					entry->len, entry->apb_bus);
> +		}
> +		tot_len += len;
> +		strlcat(buf, local_buf, PAGE_SIZE);

No, the buffer is 64 bytes, not PAGE_SIZE.

And I'm not really sure why you can't just format it all directly
into the same buffer, rather than writing to local_buf and then
concatenating that onto the end of buf.

> +	}
> +	mutex_unlock(&drvdata->mutex);
> +	return simple_read_from_buffer(userbuf, count, ppos, buf, tot_len);
> +}
> +
> +static ssize_t config_write(struct file *filp,
> +				const char __user *user_buf, size_t count,
> +				loff_t *ppos)
> +{
> +	int ret, curr_list;
> +	char *token, *input, buf[50];
> +	char *delim = " ";
> +	struct dcc_drvdata *drvdata = filp->private_data;
> +
> +	ret = kstrtoint(file_dentry(filp)->d_parent->d_name.name, 0, &curr_list);
> +	if (ret)
> +		return ret;
> +	drvdata->curr_list = curr_list;


Copy from user before determining your cur_list value.  (User
input is out of your control and should be checked first.)

> +	ret = copy_from_user(buf, user_buf, count);
> +	if (ret)
> +		return -EFAULT;
> +
> +	input = buf;

No need to use a separate "input" variable here.

> +	if (input[count - 1] == '\n')
> +		input[count - 1] = '\0';
> +
> +	token = strsep(&input, delim);
> +
> +	if (!strcmp("R", token))
> +		ret = dcc_config_add_read(drvdata, input);
> +	else if (!strcmp("W", token))
> +		ret = dcc_config_add_write(drvdata, input);
> +	else if (!strcmp("RW", token))
> +		ret = dcc_config_add_read_write(drvdata, input);
> +	else if (!strcmp("L", token))
> +		ret = dcc_config_add_loop(drvdata, input);
> +	else
> +		return -EINVAL;

Maybe print a message about what's wrong (invalid operator) here
before returning?

> +
> +	if (ret)
> +		return ret;
> +
> +	return count;
> +}
> +
> +static const struct file_operations config_fops = {
> +	.read = config_read,
> +	.write = config_write,
> +	.open = simple_open,
> +	.llseek = generic_file_llseek,
> +};
> +
> +void dcc_delete_debug_dir(struct dcc_drvdata *dcc)
> +{
> +	 debugfs_remove_recursive(dcc->dbg_dir);

You aren't removing dcc_dbg.  I *think* that's the only thing
that needs to be removed; dcc->dbg_dir won't get created if
that's NULL.  (But to be honest I'm not entirely sure about
that logic.)

> +};
> +
> +void dcc_create_debug_dir(struct dcc_drvdata *dcc)
> +{
> +	int i;
> +	char list_num[10];
> +	struct dentry *list;
> +	struct device *dev = dcc->dev;
> +
> +	if (debugfs_initialized()) {
> +		dcc_dbg = debugfs_create_dir(KBUILD_MODNAME, NULL);

Why is dcc_dbg a global?  Why even use it?  I guess I don't
really undertand the purpose of this block of code.

> +		if (!dcc_dbg) {
> +			pr_err("can't create debugfs dir\n");
> +			return;
> +		}
> +	}
> +
> +	dcc->dbg_dir = debugfs_create_dir(dev_name(dev), dcc_dbg);
> +	if (!dcc->dbg_dir)
> +		return;
> +	for (i = 0; i <= dcc->nr_link_list; i++) {
> +		sprintf(list_num, "%d", i);
> +		list = debugfs_create_dir(list_num, dcc->dbg_dir);
> +		debugfs_create_file("enable", 0400, list, dcc, &enable_fops);

The 0400 permission is wrong.  This file is read/write (0600).

> +		debugfs_create_file("config", 0400, list, dcc, &config_fops);

The 0400 permission is wrong.  This file is read/write (0600).

> +	}
> +
> +	debugfs_create_file("trigger", 0400, dcc->dbg_dir, dcc, &trigger_fops);

The 0400 permission is wrong.  This file is write-only (0200).

> +	debugfs_create_file("ready", 0400, dcc->dbg_dir, dcc, &ready_fops);
> +	debugfs_create_file("config_reset", 0400, dcc->dbg_dir,
> +						dcc, &config_reset_fops);

The 0400 permission is wrong.  This file is write-only (0200).

> +
> +}
> +
> +static ssize_t dcc_sram_read(struct file *file, char __user *data,
> +						size_t len, loff_t *ppos)
> +{
> +	unsigned char *buf;
> +	struct dcc_drvdata *drvdata = container_of(file->private_data,
> +		struct dcc_drvdata,
> +		sram_dev);
> +
> +	/* EOF check */
> +	if (drvdata->ram_size <= *ppos)
> +		return 0;
> +
> +	if ((*ppos + len) > drvdata->ram_size)
> +		len = (drvdata->ram_size - *ppos);

No need for parentheses above.

> +	buf = kzalloc(len, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	memcpy_fromio(buf, drvdata->ram_base + *ppos, len);
> +
> +	if (copy_to_user(data, buf, len)) {
> +		kfree(buf);
> +		return -EFAULT;
> +	}
> +
> +	*ppos += len;
> +
> +	kfree(buf);
> +
> +	return len;
> +}
> +
> +static const struct file_operations dcc_sram_fops = {
> +	.owner		= THIS_MODULE,
> +	.read		= dcc_sram_read,
> +	.llseek		= no_llseek,
> +};
> +
> +static int dcc_sram_dev_init(struct dcc_drvdata *drvdata)
> +{
> +	int ret;
> +
> +	drvdata->sram_dev.minor = MISC_DYNAMIC_MINOR;
> +	drvdata->sram_dev.name = DCC_SRAM_NODE;
> +	drvdata->sram_dev.fops = &dcc_sram_fops;
> +
> +	ret = misc_register(&drvdata->sram_dev);

Is it really necessary for the SRAM area to be represented as a
misc special device file?  Couldn't you simply create another
debugfs file that presents the same information when read?

What is the purpose of representing this as a distinct device?

> +	return ret;
> +}
> +
> +static void dcc_sram_dev_exit(struct dcc_drvdata *drvdata)
> +{
> +	misc_deregister(&drvdata->sram_dev);
> +}
> +
> +static int dcc_probe(struct platform_device *pdev)
> +{
> +	u32 val;
> +	int ret = 0, i, enable_size, nr_config_size, cfg_head_size;
> +	struct device *dev = &pdev->dev;
> +	struct dcc_drvdata *dcc;
> +	struct resource *res;
> +
> +	dcc = devm_kzalloc(dev, sizeof(*dcc), GFP_KERNEL);
> +	if (!dcc)
> +		return -ENOMEM;
> +
> +	dcc->dev = &pdev->dev;
> +	platform_set_drvdata(pdev, dcc);
> +
> +	dcc->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(dcc->base))
> +		return PTR_ERR(dcc->base);
> +

I'm not entirely sure, but I think the SRAM memory might more
appropriately be mapped with memremap() rather than ioremap().
Then you can just access that are with normal memory operations
(rather than readl/writel).  You might need to be careful about
byte order though.

> +	dcc->ram_base = devm_platform_get_and_ioremap_resource(pdev, 1, &res);
> +	if (IS_ERR(dcc->ram_base))
> +		return PTR_ERR(dcc->ram_base);
> +
> +	dcc->ram_size = resource_size(res);
> +
> +	dcc->ram_offset = (size_t) of_device_get_match_data(&pdev->dev);
> +
> +	val = dcc_readl(dcc, DCC_HW_INFO);

At first I didn't understand this, but now I think I do.  I'll
explain what I see:

If DCC_VER_INFO_BIT in the HW_INFO register s set, we have
version 3 hardware.

Otherwise, if we've got version 2, all of the lower 6 bits
will be set in the DCC_HW_INFO register.

For version 2 or 3, the number of linked lists is defined
in the DCC_LL_NUM_INFO register.

Otherwise we must be using version 1, in which case the
number of linked lists is fixed at 8.


> +	if (FIELD_GET(BIT(DCC_VER_INFO_BIT), val)) {
> +		dcc->mem_map_ver = 3;
> +		dcc->nr_link_list = dcc_readl(dcc, DCC_LL_NUM_INFO);
> +		if (dcc->nr_link_list == 0)
> +			return	-EINVAL;
> +	} else if ((val & DCC_VER_MASK2) == DCC_VER_MASK2) {
> +		dcc->mem_map_ver = 2;
> +		dcc->nr_link_list = dcc_readl(dcc, DCC_LL_NUM_INFO);
> +		if (dcc->nr_link_list == 0)
> +			return	-EINVAL;
> +	} else {
> +		dcc->mem_map_ver = 1;
> +		dcc->nr_link_list = DCC_MAX_LINK_LIST;
> +	}
> +
> +	if ((val & DCC_LOOP_OFFSET_MASK) == DCC_LOOP_OFFSET_MASK)

This a single bit.  You can just use:

	if (val & DCC_LOOP_OFFSET_MASK)

> +		dcc->loopoff = DCC_FIX_LOOP_OFFSET;
> +	else
> +		dcc->loopoff = get_bitmask_order((dcc->ram_size +
> +				dcc->ram_offset) / 4 - 1);

This get_bitmask_order() call to determine the offset of a
register seems overly clever.  I think it warrants a little
explanation why it's determined by the size of SRAM.

> +
> +	mutex_init(&dcc->mutex);
> +	/* Allocate space for all entries at once */
> +	enable_size = dcc->nr_link_list * sizeof(bool);
> +	nr_config_size = dcc->nr_link_list * sizeof(size_t);
> +	cfg_head_size = dcc->nr_link_list * sizeof(struct list_head);

No need for local variables for all these sizes.  Just do:

     size = dcc->nr_link_list * sizeof(*enable);
     size += dcc->nr_link_list * sizeof(*nr_config);
     size += dcc->nr_link_list * sizeof(*cfg_head);

Or maybe:
     size = sizeof(*enable) + sizeof(*nr_config) + sizeof(*cfg_head);
     dcc->enable = devm_kzalloc(dev, dcc->nr_link_list * size, GFP_KERNEL);

> +
> +	dcc->enable = devm_kzalloc(dev, enable_size + nr_config_size + cfg_head_size, GFP_KERNEL);
> +	if (!dcc->enable)
> +		return -ENOMEM;
> +
> +	dcc->nr_config  = (size_t *)(dcc->enable + dcc->nr_link_list);
> +	dcc->cfg_head = (struct list_head *)(dcc->nr_config + dcc->nr_link_list);
> +
> +	for (i = 0; i < dcc->nr_link_list; i++)
> +		INIT_LIST_HEAD(&dcc->cfg_head[i]);
> +
> +	dcc->curr_list = DCC_INVALID_LINK_LIST;
> +
> +	ret = dcc_sram_dev_init(dcc);
> +	if (ret) {
> +		dev_err(dcc->dev, "DCC: sram node not registered.\n");
> +		return ret;
> +	}
> +
> +	dcc_create_debug_dir(dcc);

If dcc_create_debug_dir() has any problem creating the directory
hierarchy, is there any point in continuing?  Isn't this whole
driver useless without the debugfs files?

If that's the case, I suggest dcc_create_debug_dir() should
return an error code so you can just clean things up if that
happens.

> +
> +	return 0;
> +}
> +
> +static int dcc_remove(struct platform_device *pdev)
> +{
> +	struct dcc_drvdata *drvdata = platform_get_drvdata(pdev);
> +
> +	dcc_sram_dev_exit(drvdata);
> +
> +	dcc_delete_debug_dir(drvdata);
> +
> +	dcc_config_reset(drvdata);

I think you're maybe doing these in the wrong order.  The debug
directory hierarchy was the last created, so it should be the
first removed.  And I think you want to do the dcc_config_reset()
before deregistering the device (though it might not matter).

What about unmapping the mapped memory regions?

					-Alex

> +
> +	return 0;
> +}
> +
> +static const struct of_device_id dcc_match_table[] = {
> +	{ .compatible = "qcom,sm8150-dcc", .data = (void *)0x5000 },
> +	{ .compatible = "qcom,sc7280-dcc", .data = (void *)0x12000 },
> +	{ .compatible = "qcom,sc7180-dcc", .data = (void *)0x6000 },
> +	{ .compatible = "qcom,sdm845-dcc", .data = (void *)0x6000 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, dcc_match_table);
> +
> +static struct platform_driver dcc_driver = {
> +	.probe = dcc_probe,
> +	.remove	= dcc_remove,
> +	.driver	= {
> +		.name = "qcom-dcc",
> +		.of_match_table	= dcc_match_table,
> +	},
> +};
> +
> +module_platform_driver(dcc_driver);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("Qualcomm Technologies Inc. DCC driver");
> +

