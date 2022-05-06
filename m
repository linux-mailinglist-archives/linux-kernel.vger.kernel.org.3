Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3665F51CF17
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 04:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388368AbiEFCy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 22:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243235AbiEFCy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 22:54:57 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488EA5E14C
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 19:51:15 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id n24so6262029oie.12
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 19:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=13imn2c5ElMh1BnKD5PWdRvOyPrpFEqafcOP6fellxw=;
        b=Vu9pgJSPUjQ5haFITEFUz5w/Q0+jp3wiZln2Va1XsigjpIthpN/p+j4ColCY3cVlln
         6dOxCN3w5o9qUpE93yOEAtw4h+g9T6HnzMMGOkh7TF5eShohzjz7qSvvhMs7W4VXwLoy
         q1losr8mTaXjzkDNXRsnGcO0MuDYmsxk6AvTqtCrV7ReqS4dROVOjjwHNLD3OgnXR96h
         PjYlNhuosMCUIUPFSQZ7tDcJg6iUeDDxrCNmWzGievM1A3io5eC6neSUmSjRuwGfMpy6
         oXikGWDwDc3xnOhAA8DiarpQjlKgoHB5mGWMRgNBe42e7rNKxppIwv+68cogoNgcBk63
         /jLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=13imn2c5ElMh1BnKD5PWdRvOyPrpFEqafcOP6fellxw=;
        b=FU1RenNMf24XAU2P1YUy6cbta2mP3zOxvj/n4N6WBcq8Nv+mCDcGfFKKtEDsJpZOzE
         dz03CB5BrRewQdCD1Ehx2QyZS5JPXJOLtzKSepQWQhTP9MEZ66EKTIERxJ+RHs3KWck5
         r3K6KqRqpgiq996ludNu2hrJXdD0Wx+iuWcYPR3l9m1PGZBsM6L4epAd5v3qZtkJTsoo
         2XPsJFkoFVSJcEUjGzyyG9s7MZRO7uf5G9b2AfeiKBZuq0g4vPsIX27m2+1byUiQCNY4
         OjQg3/9yxTz2Od/FryFCP0HjUjiQS2UsHPFOMe6bOW/MD3xwFghBthGjpZixG5b9gmK9
         kZHQ==
X-Gm-Message-State: AOAM530EdoITvHgzAxzwCtY6usozuC4Xypw2Ao3MThGWQ4u5wbcl5J31
        uJUWv4gYN03fLQ92XpXmKXm8+Q==
X-Google-Smtp-Source: ABdhPJytD5u/8xWOb1qLiOs2oD9QoyyldjFknwKFtGOY7YZuR/yt+RSJ/tDYZ5SIvKRnJBJXCCugRw==
X-Received: by 2002:aca:2807:0:b0:326:14c8:a19b with SMTP id 7-20020aca2807000000b0032614c8a19bmr3909135oix.158.1651805474510;
        Thu, 05 May 2022 19:51:14 -0700 (PDT)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id g28-20020a4ae89c000000b0035eb4e5a6dasm1437281ooe.48.2022.05.05.19.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 19:51:13 -0700 (PDT)
Date:   Thu, 5 May 2022 19:53:48 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Alex Elder <elder@ieee.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@codeaurora.org>, vkoul@kernel.org
Subject: Re: [PATCH V7 2/7] soc: qcom: dcc:Add driver support for Data
 Capture and Compare unit(DCC)
Message-ID: <YnSNvHVrJruVbE53@ripper>
References: <cover.1646285069.git.quic_schowdhu@quicinc.com>
 <bc8504bdaf24d98762e2dbad7d084ca247380f06.1646285069.git.quic_schowdhu@quicinc.com>
 <YnFuXYEXxLQkak24@builder.lan>
 <0997f2bc-e8ce-24cc-da90-0ecd3201350c@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0997f2bc-e8ce-24cc-da90-0ecd3201350c@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 05 May 05:53 PDT 2022, Souradeep Chowdhury wrote:

> 
> On 5/3/2022 11:33 PM, Bjorn Andersson wrote:
> > On Thu 03 Mar 00:27 CST 2022, Souradeep Chowdhury wrote:
> > 
> > > The DCC is a DMA Engine designed to capture and store data
> > > during system crash or software triggers. The DCC operates
> > > based on user inputs via the sysfs interface. The user gives
> > > addresses as inputs and these addresses are stored in the
> > > dcc sram. In case of a system crash or a manual software
> > > trigger by the user through the debugfs interface,
> > > the dcc captures and stores the values at these addresses.
> > > This patch contains the driver which has all the methods
> > > pertaining to the debugfs interface, auxiliary functions to
> > > support all the four fundamental operations of dcc namely
> > > read, write, read/modify/write and loop. The probe method
> > > here instantiates all the resources necessary for dcc to
> > > operate mainly the dedicated dcc sram where it stores the
> > > values. The DCC driver can be used for debugging purposes
> > > without going for a reboot since it can perform software
> > > triggers as well based on user inputs.
> > > 
> > > Also added the documentation for debugfs entries and explained
> > > the functionalities of each debugfs file that has been created
> > > for dcc.
> > > 
> > > The following is the justification of using debugfs interface
> > > over the other alternatives like sysfs/ioctls
> > > 
> > > i) As can be seen from the debugfs attribute descriptions,
> > > some of the debugfs attribute files here contains multiple
> > > arguments which needs to be accepted from the user. This goes
> > > against the design style of sysfs.
> > > 
> > > ii) The user input patterns have been made simple and convenient
> > > in this case with the use of debugfs interface as user doesn't
> > > need to shuffle between different files to execute one instruction
> > > as was the case on using other alternatives.
> > > 
> > > Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> > > ---
> > >   Documentation/ABI/testing/debugfs-driver-dcc |  124 +++
> > >   drivers/soc/qcom/Kconfig                     |    8 +
> > >   drivers/soc/qcom/Makefile                    |    1 +
> > >   drivers/soc/qcom/dcc.c                       | 1465 ++++++++++++++++++++++++++
> > >   4 files changed, 1598 insertions(+)
> > >   create mode 100644 Documentation/ABI/testing/debugfs-driver-dcc
> > >   create mode 100644 drivers/soc/qcom/dcc.c
> > > 
> > > diff --git a/Documentation/ABI/testing/debugfs-driver-dcc b/Documentation/ABI/testing/debugfs-driver-dcc
> > > new file mode 100644
> > > index 0000000..70029ab
> > > --- /dev/null
> > > +++ b/Documentation/ABI/testing/debugfs-driver-dcc
> > > @@ -0,0 +1,124 @@
> > > +What:          /sys/kernel/debug/dcc/.../trigger
> > > +Date:          March 2022
> > > +Contact:       Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> > > +Description:
> > > +		This is the debugfs interface for manual software
> > > +		triggers. The user can simply enter a 1 against
> > > +		the debugfs file and enable a manual trigger.
> > > +		Example:
> > > +		echo  1 > /sys/kernel/debug/dcc/.../trigger
> > > +
> > > +What:          /sys/kernel/debug/dcc/.../enable
> > > +Date:          March 2022
> > > +Contact:       Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> > > +Description:
> > > +		This debugfs interface is used for enabling the
> > > +		the dcc hardware. On enabling the dcc, all the
> > > +		addresses entered by the user is written into
> > > +		dcc sram which is read by the dcc hardware on
> > > +		manual or crash induced triggers.
> > > +		Example:
> > > +		echo  0 > /sys/bus/platform/devices/.../enable
> > > +		(disable dcc)
> > > +		echo  1 > /sys/bus/platform/devices/.../enable
> > > +		(enable dcc)
> > > +
> > > +What:          /sys/kernel/debug/dcc/.../config_read
> > As mentioned last time, I don't like this interface of having 6 files
> > that the user can write to in order to append items in the currently
> > selected linked list.
> > 
> > Why can't this be a single "config" which takes a multiline string of
> > operations? (Bonus point for supporting appending to the list).
> > 
> > 
> > This would also serve as a natural place to dump the linked list back to
> > the user for inspection.
> 
> Following is the justification of having multiple files in debugfs
> 
> 1-> Since there are fundamentally 4 instructions for DCC, Read,Write,Read
> and then Write and Loop,having separate debugfs files for the same makes it
> 
> convenient for the user to use this tool and also to document.This
> also is consistent with the design principles of debugfs as it supports
> logical segregation of Debugfs files based on the user instructions.
> 

So say the user of DCC wants to read a register 10 times, they know that
the DCC operates on lists of operations, so they want to tell the
computer "read X, loop 10 times".

But the API is "write to loop file", "write to read file" and "write to
loop file".

You're achieving the same thing, but the user and the driver thinks in
terms of lists of operations and inbetween is a API which provides
"logical segregation" of the different parts of that list.

> 2-> We are maintaining a common linkedlist inside the driver and it can be
> viewed by the user through the "config_read" debugfs file. Will be adding
> this to the documentation as well.
> 

So I use a mix of config_* files to build the lists, and then
config_read is used to look at the list?

So some config_* files will when written append to the list, some
config_* files will perform some action (e.g. reset) and reading some
config_* files will return something useful.

> Let me know your thoughts regarding the above.
> 

I am not convinced that having multiple files provides a nice user
interface. But I certain that the use of the word "config" in various
different ways is wrong.

There are files in the interface which purpose is to append items to the
linked list, name them append_*. Reading the appended items on the list
should not be overloaded on one of the "append" files.


So perhaps:

append_read
append_write
append_rmw
append_loop
config (to dump the current config)
enable
ready
reset
trigger


But then looking at the append_* functions again and the examples below.
You could easily have a single append which takes read, write, rmw and
loop as a first keyword - and build a crude parser based on sscanf to
decode the strings.

Then all append_* becomes "append", which is a single file for adding to
the list and "config" is a single point to read the current list.
Perhaps you could name this file just "config", reading will dump the
list, writing will append to the list.

Here you would have a cleaner interface.


But as you write your own fops you could differentiate between write
and append, so you could make this slightly cleaner by manifesting the
"append" part by allowing the user to do:

  echo read 1, 2, 3 > config
  echo read 4, 5, 6 >> config

Which clearly shows that the first writes to the config and second
appends to the current config. With this interface reset would become:

  echo > config

You can still require that only single operation is written to or
appended to the list per write - to allow you to continue to rely on the
crude sscanf based parser.

With this your interface is reduced to:

config
enable
ready
trigger

> > > +Date:          March 2022
> > > +Contact:       Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> > > +Description:
> > > +		This stores the addresses of the registers which
> > > +		needs to be read in case of a hardware crash or
> > > +		manual software triggers. The address entered here
> > > +		are considered under read type instruction.
> > > +		Example:
> > > +		echo <1> <2> <3> >/sys/kernel/debug/dcc/../config_read
> > > +		1->Address to be considered for reading the value.
> > > +		2->The word count of the addresses, read n words
> > > +		   starting from address <1>.
> > > +		3->Can be a 1 or 0 which indicates if it is apb or ahb
> > > +		bus respectively.
> > > +
> > > +What:          /sys/kernel/debug/dcc/.../config_write
> > > +Date:          March 2022
> > > +Contact:       Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> > > +Description:
> > > +		This file allows user to write a value to the register
> > > +		address given as argument. The reason for this feature
> > > +		of dcc is that for accessing certain registers it is
> > > +		necessary to set some bits of some other register.
> > > +		Example:
> > > +		echo <1> <2> <3> > /sys/bus/platform/devices/.../config_write
> > > +		1->Address to be considered for writing the value.
> > > +		2->The value that needs to be written at the location.
> > > +		3->Can be a 1 or 0 which indicates if it is apb or ahb
> > > +		bus respectively.
> > > +
> > > +What:          /sys/kernel/debug/dcc/.../config_reset
> > > +Date:          March 2022
> > > +Contact:       Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> > > +Description:
> > > +		This file is used to reset the configuration of
> > > +		a dcc driver to the default configuration. This
> > > +		means that all the previous addresses stored in
> > > +		the driver gets removed and user needs to enter
> > > +		the address values from the start.
> > > +		Example:
> > > +		echo  1 > /sys/bus/platform/devices/.../config_reset
> > > +
> > > +What:          /sys/kernel/debug/dcc/.../config_loop
> > > +Date:		March 2022
> > > +Contact:       Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> > > +Description:
> > > +		This file is used to enter the loop type addresses for
> > > +		dcc. DCC hardware provides feature to loop among multiple
> > > +		addresses. For debugging purposes register values need to
> > > +		be captured repeatedly in a loop. On giving the loop count
> > > +		as n, the value at address will be captured n times in a
> > > +		loop. At most 8 loop addresses can be configured at once.
> > > +		Example:
> > > +		echo <1> <2> <3> > /sys/kernel/debug/dcc/../config_loop
> > > +		1->The loop count, the number of times the value of the
> > > +		   addresses will be captured.
> > > +		2->The address count, total number of addresses to be
> > > +		   entered in this instruction.
> > > +		3->The series of addresses to be entered separated by a
> > > +		   space like <addr1> <addr2>... and so on.
> > > +
> > > +What:          /sys/kernel/debug/dcc/.../config_read_write
> > > +Date:          March 2022
> > > +Contact:       Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> > > +Description:
> > > +		This file is used to read the value of the register
> > > +		and then write the value given as an argument to the
> > > +		register address. The address argument should be given
> > > +		of the form <addr> <mask> <value>.For debugging purposes
> > > +		sometimes we need to first read from a register and then
> > > +		set some values to the register.
> > > +		Example:
> > > +		echo <1> <2> <3> > /sys/kernel/debug/dcc/.../config_read_write
> > > +		1->The address which needs to be considered for read then write.
> > > +		2->The value that needs to be written on the address.
> > > +		3->The mask of the value to be written.
> > > +
> > > +What:		/sys/kernel/debug/dcc/.../ready
> > > +Date:		March 2022
> > > +Contact	Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> > > +Description:
> > > +		This file is used to check the status of the dcc
> > > +		hardware if it's ready to take the inputs. A 0
> > > +		here indicates dcc is in a ready condition.
> > > +		Example:
> > > +		cat /sys/kernel/debug/dcc/.../ready
> > > +
> > > +What:		/sys/kernel/debug/dcc/.../curr_list
> > I still don't like the idea of having a single set of files to interface
> > with all N lists. I think you should discover how many lists you have
> > and create N directories of files, each on operating on a given list.
> 
> As explained before there cannot be different files based on lists as
> the number of lists to be used varies across platforms where DCC is
> used.

Isn't this dcc->nr_link_list?

> Also we are giving the user the flexibility to configure
> multiple lists at one go whereas the dumps are collected in the form
> of separate lists that are configured by the user.
> 

I'm not sure I follow what you're trying to say here.

If we determine that nr_link_list is 2, you create a directory named 0
and one named 1, fill them with the interface files to operate on list 0
and list 1 respectively. Then you still allow the user to configure and
enable the 2 available lists?

The difference is that it's clear how many lists you have and it's clear
when you poke at 0/config_read that you're referring to the first list
and poking 0/enable will mean the same list - there's no curr_list to
mux between them in the interface.

Regards,
Bjorn

> > 
> > > +Date:		March 2022
> > > +Contact:	Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> > > +Description:
> > > +		This attribute is used to enter the linklist to be
> > > +		used while appending addresses. The range of values
> > > +		for this is advertised either by a register or is
> > > +		predefined. Max value for this can be till 8.
> > > +		Example:
> > > +		echo 0 > /sys/kernel/debug/dcc/...curr_list
> > > +
> > Regards,
> > Bjorn
