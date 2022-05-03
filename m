Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2915518BC4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 20:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240915AbiECSGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 14:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbiECSGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 14:06:48 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C081D3EA8C
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 11:03:14 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id m25so5063846oih.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 11:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pHp7YwoTf2Vdk24QufCdmU2MrD/gn+v9TqyvkBKPilQ=;
        b=oASUIWSunTEb1LBbrg5c0vQj/FEZjRLhcFe23l2VL/75O7EiwL4bpik2++AxxzDO+G
         XJQbak7untc//EOnU6bTNiKJ0riyrO6bySzh5j2YdwvJQfSAvOPdph+zRxfYKLduUpCP
         j68cNCGiYKXGwdWlqSmnS3TjZ9a6sDsJ4vIaNdDR6UoKXTLZLcub4Nv2wHP4hoMaIgrg
         lX63KTc8AJ7qByKPWfZvmzT65C2h2APShFIUC6zsZEo4SMRWcb45UXB0glEduI+vGu7T
         3GZ07vqfIdb/8zd116T/IZIikZX8kIySOa6xUqYqkb8KTwMvuDYRk/BuFb85TiAbnC6q
         c4UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pHp7YwoTf2Vdk24QufCdmU2MrD/gn+v9TqyvkBKPilQ=;
        b=yMm9lGpOkLP5IpKwnSNLjjWaHrvio6v5KXlv5DnxJM6YMdEPKNQExks9wNBphgSHC5
         csRND7+Y3GLNgE4Q9amXopDg34MPqcqAIXMPlQtIh2DqSXmcYjQNSDQTX+Ybam7Hcd0S
         YXeuMxLwgsnn7FxFAqQpQqUMS6cx086vNtqSmicOI0HJZT2jFkDcA+9ml5OWNaZt8E4Z
         QujhakHQ+X1r+1EkLKEf0BVpmhh+YVA1Smypl2BBl5bjPyZlWVXO2r/E+KMDC0L24kLy
         EB7mHayz56rSiZoaz8ZqObmcznBfwbTAB312xt9fZsm4hzQqbgA494gp7UM6m4OqQxPW
         QOvw==
X-Gm-Message-State: AOAM5335t1ni8hEU6OsJk+rWsiknV12fuih2eAW4s5SPId6qTSHBqRX8
        khCJGYtDyfehk28gw1MqZtSVHA==
X-Google-Smtp-Source: ABdhPJwEBnus5YhDU9Wtk4POgwJH9KNS5mGSyWLeYc0ZszWEV4GQsb9nh1nQKsfM7G4ownHcnanz2g==
X-Received: by 2002:a05:6808:30a9:b0:325:e5a7:1c49 with SMTP id bl41-20020a05680830a900b00325e5a71c49mr2265762oib.153.1651600992543;
        Tue, 03 May 2022 11:03:12 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id g6-20020a056830160600b0060603221266sm4198960otr.54.2022.05.03.11.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 11:03:11 -0700 (PDT)
Date:   Tue, 3 May 2022 13:03:09 -0500
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
Message-ID: <YnFuXYEXxLQkak24@builder.lan>
References: <cover.1646285069.git.quic_schowdhu@quicinc.com>
 <bc8504bdaf24d98762e2dbad7d084ca247380f06.1646285069.git.quic_schowdhu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc8504bdaf24d98762e2dbad7d084ca247380f06.1646285069.git.quic_schowdhu@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 03 Mar 00:27 CST 2022, Souradeep Chowdhury wrote:

> The DCC is a DMA Engine designed to capture and store data
> during system crash or software triggers. The DCC operates
> based on user inputs via the sysfs interface. The user gives
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
> ---
>  Documentation/ABI/testing/debugfs-driver-dcc |  124 +++
>  drivers/soc/qcom/Kconfig                     |    8 +
>  drivers/soc/qcom/Makefile                    |    1 +
>  drivers/soc/qcom/dcc.c                       | 1465 ++++++++++++++++++++++++++
>  4 files changed, 1598 insertions(+)
>  create mode 100644 Documentation/ABI/testing/debugfs-driver-dcc
>  create mode 100644 drivers/soc/qcom/dcc.c
> 
> diff --git a/Documentation/ABI/testing/debugfs-driver-dcc b/Documentation/ABI/testing/debugfs-driver-dcc
> new file mode 100644
> index 0000000..70029ab
> --- /dev/null
> +++ b/Documentation/ABI/testing/debugfs-driver-dcc
> @@ -0,0 +1,124 @@
> +What:          /sys/kernel/debug/dcc/.../trigger
> +Date:          March 2022
> +Contact:       Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> +Description:
> +		This is the debugfs interface for manual software
> +		triggers. The user can simply enter a 1 against
> +		the debugfs file and enable a manual trigger.
> +		Example:
> +		echo  1 > /sys/kernel/debug/dcc/.../trigger
> +
> +What:          /sys/kernel/debug/dcc/.../enable
> +Date:          March 2022
> +Contact:       Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> +Description:
> +		This debugfs interface is used for enabling the
> +		the dcc hardware. On enabling the dcc, all the
> +		addresses entered by the user is written into
> +		dcc sram which is read by the dcc hardware on
> +		manual or crash induced triggers.
> +		Example:
> +		echo  0 > /sys/bus/platform/devices/.../enable
> +		(disable dcc)
> +		echo  1 > /sys/bus/platform/devices/.../enable
> +		(enable dcc)
> +
> +What:          /sys/kernel/debug/dcc/.../config_read

As mentioned last time, I don't like this interface of having 6 files
that the user can write to in order to append items in the currently
selected linked list.

Why can't this be a single "config" which takes a multiline string of
operations? (Bonus point for supporting appending to the list).


This would also serve as a natural place to dump the linked list back to
the user for inspection.

> +Date:          March 2022
> +Contact:       Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> +Description:
> +		This stores the addresses of the registers which
> +		needs to be read in case of a hardware crash or
> +		manual software triggers. The address entered here
> +		are considered under read type instruction.
> +		Example:
> +		echo <1> <2> <3> >/sys/kernel/debug/dcc/../config_read
> +		1->Address to be considered for reading the value.
> +		2->The word count of the addresses, read n words
> +		   starting from address <1>.
> +		3->Can be a 1 or 0 which indicates if it is apb or ahb
> +		bus respectively.
> +
> +What:          /sys/kernel/debug/dcc/.../config_write
> +Date:          March 2022
> +Contact:       Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> +Description:
> +		This file allows user to write a value to the register
> +		address given as argument. The reason for this feature
> +		of dcc is that for accessing certain registers it is
> +		necessary to set some bits of some other register.
> +		Example:
> +		echo <1> <2> <3> > /sys/bus/platform/devices/.../config_write
> +		1->Address to be considered for writing the value.
> +		2->The value that needs to be written at the location.
> +		3->Can be a 1 or 0 which indicates if it is apb or ahb
> +		bus respectively.
> +
> +What:          /sys/kernel/debug/dcc/.../config_reset
> +Date:          March 2022
> +Contact:       Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> +Description:
> +		This file is used to reset the configuration of
> +		a dcc driver to the default configuration. This
> +		means that all the previous addresses stored in
> +		the driver gets removed and user needs to enter
> +		the address values from the start.
> +		Example:
> +		echo  1 > /sys/bus/platform/devices/.../config_reset
> +
> +What:          /sys/kernel/debug/dcc/.../config_loop
> +Date:		March 2022
> +Contact:       Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> +Description:
> +		This file is used to enter the loop type addresses for
> +		dcc. DCC hardware provides feature to loop among multiple
> +		addresses. For debugging purposes register values need to
> +		be captured repeatedly in a loop. On giving the loop count
> +		as n, the value at address will be captured n times in a
> +		loop. At most 8 loop addresses can be configured at once.
> +		Example:
> +		echo <1> <2> <3> > /sys/kernel/debug/dcc/../config_loop
> +		1->The loop count, the number of times the value of the
> +		   addresses will be captured.
> +		2->The address count, total number of addresses to be
> +		   entered in this instruction.
> +		3->The series of addresses to be entered separated by a
> +		   space like <addr1> <addr2>... and so on.
> +
> +What:          /sys/kernel/debug/dcc/.../config_read_write
> +Date:          March 2022
> +Contact:       Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> +Description:
> +		This file is used to read the value of the register
> +		and then write the value given as an argument to the
> +		register address. The address argument should be given
> +		of the form <addr> <mask> <value>.For debugging purposes
> +		sometimes we need to first read from a register and then
> +		set some values to the register.
> +		Example:
> +		echo <1> <2> <3> > /sys/kernel/debug/dcc/.../config_read_write
> +		1->The address which needs to be considered for read then write.
> +		2->The value that needs to be written on the address.
> +		3->The mask of the value to be written.
> +
> +What:		/sys/kernel/debug/dcc/.../ready
> +Date:		March 2022
> +Contact	Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> +Description:
> +		This file is used to check the status of the dcc
> +		hardware if it's ready to take the inputs. A 0
> +		here indicates dcc is in a ready condition.
> +		Example:
> +		cat /sys/kernel/debug/dcc/.../ready
> +
> +What:		/sys/kernel/debug/dcc/.../curr_list

I still don't like the idea of having a single set of files to interface
with all N lists. I think you should discover how many lists you have
and create N directories of files, each on operating on a given list.

> +Date:		March 2022
> +Contact:	Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> +Description:
> +		This attribute is used to enter the linklist to be
> +		used while appending addresses. The range of values
> +		for this is advertised either by a register or is
> +		predefined. Max value for this can be till 8.
> +		Example:
> +		echo 0 > /sys/kernel/debug/dcc/...curr_list
> +

Regards,
Bjorn
