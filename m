Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55940537889
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 12:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232972AbiE3JG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 05:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234705AbiE3JE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 05:04:57 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 88F6A79827
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 02:04:55 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 501AD113E;
        Mon, 30 May 2022 02:04:55 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D1A23F73D;
        Mon, 30 May 2022 02:04:54 -0700 (PDT)
Date:   Mon, 30 May 2022 10:04:44 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [kbuild] drivers/firmware/arm_scmi/clock.c:242:40: warning:
 Variable 'msg' is not assigned a value. [unassignedVariable]
Message-ID: <YpSIrIxrqdUn4Lpf@e120937-lin>
References: <202205271608.aIWtyM7b-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202205271608.aIWtyM7b-lkp@intel.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2022 at 11:57:29AM +0300, Dan Carpenter wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master
> head:   7e284070abe53d448517b80493863595af4ab5f0
> commit: 7bc7caafe6b1e5b882255a42bc1bf112fa87b69b firmware: arm_scmi: Use common iterators in the clock protocol
> compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0
> reproduce (cppcheck warning):
>         # apt-get install cppcheck
>         git checkout 7bc7caafe6b1e5b882255a42bc1bf112fa87b69b
>         cppcheck --quiet --enable=style,performance,portability --template=gcc FILE
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 

Hi Dan,

thanks for the report.

> cppcheck possible warnings: (new ones prefixed by >>, may not real problems)
> 
> >> drivers/firmware/arm_scmi/clock.c:242:40: warning: Variable 'msg' is not assigned a value. [unassignedVariable]
>     struct scmi_msg_clock_describe_rates *msg;
>                                           ^
> 
> vim +/msg +242 drivers/firmware/arm_scmi/clock.c
> 
> 7bc7caafe6b1e5 Cristian Marussi 2022-03-30  235  static int
> 7bc7caafe6b1e5 Cristian Marussi 2022-03-30  236  scmi_clock_describe_rates_get(const struct scmi_protocol_handle *ph, u32 clk_id,
> 7bc7caafe6b1e5 Cristian Marussi 2022-03-30  237  			      struct scmi_clock_info *clk)
> 7bc7caafe6b1e5 Cristian Marussi 2022-03-30  238  {
> 7bc7caafe6b1e5 Cristian Marussi 2022-03-30  239  	int ret;
> 5f6c6430e904d2 Sudeep Holla     2017-06-06  240  
> 
> Please delete the blank line.

I'll do.

> 
> 7bc7caafe6b1e5 Cristian Marussi 2022-03-30  241  	void *iter;
> 7bc7caafe6b1e5 Cristian Marussi 2022-03-30 @242  	struct scmi_msg_clock_describe_rates *msg;
> 
> I was so surprised that GCC doesn't warn about this but "msg" is only
> used to calculate the sizeof(*msg).
> 

Probably a leftover from a previous version of the series where msg was
usaed not only for sizeof()....I'll send a fix anyway to silence the
bot.

Thanks,
Cristian

