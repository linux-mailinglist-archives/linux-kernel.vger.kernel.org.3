Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 212C75100D8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 16:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351694AbiDZOtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 10:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349614AbiDZOs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 10:48:57 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5217613CE9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 07:45:49 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1DDD323A;
        Tue, 26 Apr 2022 07:45:49 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 395A03F73B;
        Tue, 26 Apr 2022 07:45:48 -0700 (PDT)
Date:   Tue, 26 Apr 2022 15:45:45 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Balint Dobszay <balint.dobszay@arm.com>
Subject: Re: [PATCH] tee: Add Arm FF-A TEE driver
Message-ID: <20220426144545.6qkn6iwayuwpvi7g@bogus>
References: <20220408134144.1532704-1-sudeep.holla@arm.com>
 <CAFA6WYNbwqNqK89ZCWWpAT5HCR59A+J873_5Odyjyb9qu00nsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYNbwqNqK89ZCWWpAT5HCR59A+J873_5Odyjyb9qu00nsg@mail.gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 12:29:26PM +0530, Sumit Garg wrote:
> Hi Sudeep,
>
> On Fri, 8 Apr 2022 at 19:11, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > The Arm FF-A provides mechanism for Linux kernel and modules to
> > communicate with the secure partitions. This is useful for some
> > Trusted-OS driver that are kernel resident or modules.
> >
> > We would also like to avoid adding kernel drivers to communicate with
> > each and every service provided by these secure partitions. In order to
> > achieve the same with FF-A, it would be better to provide user-space
> > interface to access the FF-A functionalities. TEE subsystem seems to be
> > the best suited to meet those requirements without having to create a
> > new solution custom to FF-A alone.
>
> Yeah, this interface sounds interesting.
>

Good to hear that.

> >
> > All FF-A partitions that user-space access can be associated with this
> > new FF-A TEE driver and represented by a single TEE device. Though the
> > various secure services are generally distributed across multiple secure
> > partitions, all of these can be made accessible through this single FF-A
> > TEE device.
> >
> > The minimal functionality needed by the user space application is
> > implemented, namely:
> >  - Query all partition IDs for a specific FF-A UUID
> >  - Sending synchronous message to a partition
> >  - Share/unshare buffer with the partition
> >
>
> Are there any corresponding user-space applications/libraries
> available to get hands-on with this interface?
>

Not sure if the changes to make use of this new interface is publicly
available yet as these APIs are subject to change. I will see if something
can be shared, but this is the project[2] I am using to test with relevant
changes to use these TEE APIs.

> > Cc: Jens Wiklander <jens.wiklander@linaro.org>
> > Cc: Sumit Garg <sumit.garg@linaro.org>
> > Co-developed-by: Balint Dobszay <balint.dobszay@arm.com>
> > Signed-off-by: Balint Dobszay <balint.dobszay@arm.com>
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> >  drivers/tee/Kconfig                       |   1 +
> >  drivers/tee/Makefile                      |   1 +
> >  drivers/tee/arm_ffa_tee/Kconfig           |  15 +
> >  drivers/tee/arm_ffa_tee/Makefile          |   6 +
> >  drivers/tee/arm_ffa_tee/core.c            | 460 ++++++++++++++++++++++
> >  drivers/tee/arm_ffa_tee/ffa_tee_private.h |  39 ++
> >  drivers/tee/arm_ffa_tee/shm_pool.c        |  94 +++++
> >  drivers/tee/arm_ffa_tee/ts_msg.c          | 133 +++++++
> >  drivers/tee/arm_ffa_tee/ts_msg.h          |  75 ++++
> >  include/uapi/linux/arm_ffa_tee.h          | 116 ++++++
> >  include/uapi/linux/tee.h                  |   1 +
> >  11 files changed, 941 insertions(+)
> >  create mode 100644 drivers/tee/arm_ffa_tee/Kconfig
> >  create mode 100644 drivers/tee/arm_ffa_tee/Makefile
> >  create mode 100644 drivers/tee/arm_ffa_tee/core.c
> >  create mode 100644 drivers/tee/arm_ffa_tee/ffa_tee_private.h
> >  create mode 100644 drivers/tee/arm_ffa_tee/shm_pool.c
> >  create mode 100644 drivers/tee/arm_ffa_tee/ts_msg.c
> >  create mode 100644 drivers/tee/arm_ffa_tee/ts_msg.h
> >  create mode 100644 include/uapi/linux/arm_ffa_tee.h
> >
> > Hi All,
> >
> > This is the initial version of FF-A TEE driver to get the feedback on the
> > overall design/approach.
> >
> > Few TODOs I plan to do before we finalise:
> > 1. Need to decouple the driver from few Trusted Service protocols currently
> >    implemented. I have WIP, but couldn't get all the tests working(yet to
> >    figure out whether the issue is in driver or tests themselves). Just
> >    posting it as is to get initial feedback on other areas.
>
> Yes I would be in favor of this.
>

I am too, but Balint had some concerns which I need to discuss with him yet.

> >
> > 2. Based on the way FF-A spec changes/discussions, does it make sense to
> >    make search based on UUID + partitionID instead of just partitionID or
> >    leave that for userspace.
>
> IIUC, the UUID is the one identifying the trusted service. So what
> purpose does partionID solves for user-space program?
>

Sorry for not giving complete picture here. In the context of FF-A and secure
partitions, there were discussions to allow single partition implementing
multiple services/protocols(each associated with UUID) and on a system with
multiple SPs, 2 different SPs can be implementing same protocol/service.
Sorry if I am missing something here or if that is impossible, this is just
my understanding and hence I was check if UUID + something(vm_id as per FF-A
spec) need to be used to identify which partition and service we would want to
talk to.

> >
> > 3. While I definitely want to move the protocol specifics from the driver
> >    (as mentioned in (1)), do we even try to remove adding UUID of each service
> >    we would like to use this driver.
>
> Yes, we shouldn't hardcode any UUIDs for trusted services within the
> driver (it isn't scalable) but rather during open sessions we should
> search if a particular UUID is available on FF-A bus to communicate
> with?
>

Yes it is not scalable and I am aware of that. I haven't explored the
options to get rid of them yet. Thanks for the suggestion.

> >    I haven't thought through that yet,
> >    but the idea I have is to just have a blocked UUID list which can
> >    contain UUID for OPTEE and other in-kernel users.
> >    That may need changes in FF-A bus match but something to consider ?
> >
>
> Currently in the case of OP-TEE we depend on an open session login
> method where the particular trusted application decides whether a
> particular login method is allowed or not, refer here [1] for more
> details. I guess similar access control checks can be implemented by a
> particular trusted service during an open session. This will allow us
> to not maintain any allowed or blocked list.
>

Thanks for the details, I will explore and see how we can use something
similar. I will ping you if I get stuck or need more info or need more
discussion on that.

--
Regards,
Sudeep

[2] https://git.trustedfirmware.org/TS/trusted-services.git

