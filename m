Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C6F5608E9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 20:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbiF2STk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 14:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbiF2STi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 14:19:38 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 493401835C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 11:19:36 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3EE561480;
        Wed, 29 Jun 2022 11:19:36 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 01E573F5A1;
        Wed, 29 Jun 2022 11:19:34 -0700 (PDT)
Date:   Wed, 29 Jun 2022 19:19:32 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [PATCH 0/2] Add SCMI full message tracing
Message-ID: <YryXp5ieC+dz8CSy@e120937-lin>
References: <20220623145533.2882688-1-cristian.marussi@arm.com>
 <CA+-6iNx_EW_L5Ffn-L+xyg8VVGVPyBonvBFVV6dq69HpTHdqrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+-6iNx_EW_L5Ffn-L+xyg8VVGVPyBonvBFVV6dq69HpTHdqrQ@mail.gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 03:05:57PM -0400, Jim Quinlan wrote:
> On Thu, Jun 23, 2022 at 10:55 AM Cristian Marussi
> <cristian.marussi@arm.com> wrote:
> >
> > Hi,
> >
> > after a few recent troubles handling too strictly out-of-spec replies from
> > SCMI servers deployed in the wild, I though it could have been useful to
> > have a basic way to dump at will the effective full payloads of successfuly
> > transmitted/received SCMI messages.
> >
> > The existing SCMI traces already collect a bunch of information about SCMI
> > message exchanges but they do NOT keep any payload information: this is
> > certainly preferable most of the time since dumping full SCMI messages to
> > the trace buffer involves a full copy of the payload.
> >
> > For this reason I added a new distinct trace_scmi_msg_dump with this series
> > in order to be able to selectively enable at will message dumping only when
> > required.
> >
> > Only successfully transmitted and received (valid) xfers are dumped.
> >
> > At first I was thinking about just dumping raw header and payload, but in
> > order to make the log a bit more human readable (without the need of
> > tooling to parse the log), I added some parsing/interpretation of the
> > header, so that the final result is something like:
> >
> > root@deb-guest:~# echo 1 > /sys/kernel/debug/tracing/events/scmi/scmi_msg_dump/enable
> > root@deb-guest:~# cat /sys/kernel/debug/tracing/trace_pipe
> >
> > (my annotations non on traces =>>)                       proto  type  cmd   seq  status    payload
> >                                                           |      |    |      |     |        |
> >  ++ cmd/reply                                             |      |    |      |     |        |
> >    cat-224     [002] .....   147.755847: scmi_msg_dump: [0x15]:CMND:[0x06]:[0021]:[0]: 0000000000000000
> > <idle>-0       [000] d.h2.   147.758311: scmi_msg_dump: [0x15]:RESP:[0x06]:[0021]:[0]: 25000000000000000000000000000000
> >I'll probably still use a script, but
> as you are keep
> >
> >  ++ cmd/reply/delayed
> >    cat-223     [001] .....   122.384192: scmi_msg_dump: [0x15]:CMND:[0x06]:[0020]:[0]: 0100000001000000
> > <idle>-0       [000] d.h2.   122.405548: scmi_msg_dump: [0x15]:RESP:[0x06]:[0020]:[0]:
> > <idle>-0       [000] d.h2.   122.425839: scmi_msg_dump: [0x15]:DLYD:[0x06]:[0020]:[0]: 01000000a05a320000000000efbeaddefecafeca
> >
> >
> >  ++ enable notif/notif
> > iio_generic_buf-233     [003] .....   522.399690: scmi_msg_dump: [0x15]:CMND:[0x0A]:[0024]:[0]: 0800000003000000
> >          <idle>-0       [000] dNh2.   522.417778: scmi_msg_dump: [0x15]:RESP:[0x0A]:[0024]:[0]: 00000000
> >          <idle>-0       [000] d.h2.   522.500945: scmi_msg_dump: [0x15]:NOTI:[0x01]:[0000]:[0]: 000000000800000008daffffffffffff0040d3a45d46fb1610daffffffffffff0040d3a45d46fb1618daffffffffffff0040d3a45d46fb16
> >
> > Payload is dumped as it comes through byte-by-byte without any endianity
> > conversion to avoid further load on the system.
> >
> > Any thoughs ?
> 
> Hi Christian,
> I haven't tested this but the format looks good to me.  I have a
> couple of minor suggestions
> below.
> 

Hi Jim,

thanks for having a look.

> As all numbers are hex, consider dropping the '0x'.  BTW,  the seq
> value (eg [0020]) is hex but does not have '0x'.
> 

Yes indeed, good point.

> Some TP_printk()s use this  style:
> 
>         scmi_msg_dump: pt=15 t=CMND cmd=06 seq=0021 s=0 pyld=12345678abcdef
> 
> which allows one to easily grep, for example, for all non-zero returns
> 
>         grep 's=[^0]'
> 
> This format is also easy to parse with a script:  strip the preamble,
> split on whitespace, and then split on '=' to get the  [key, value]
> pairs.

In fact having a grep-friendly format is better.

Thanks for your feedback, I'll wait to see if someone else wants to
chime in and repost.

Thanks,
Cristian

