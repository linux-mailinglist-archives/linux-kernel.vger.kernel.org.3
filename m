Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37838554359
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 09:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350355AbiFVGhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 02:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbiFVGhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 02:37:13 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 36F84344D1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 23:37:12 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 112A113D5;
        Tue, 21 Jun 2022 23:37:12 -0700 (PDT)
Received: from bogus (unknown [10.57.36.82])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 867C13F66F;
        Tue, 21 Jun 2022 23:37:10 -0700 (PDT)
Date:   Wed, 22 Jun 2022 07:35:58 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Balint Dobszay <balint.dobszay@arm.com>
Subject: Re: [PATCH] tee: Add Arm FF-A TEE driver
Message-ID: <20220622063558.ckehnri5ipiftxka@bogus>
References: <20220408134144.1532704-1-sudeep.holla@arm.com>
 <CAFA6WYNbwqNqK89ZCWWpAT5HCR59A+J873_5Odyjyb9qu00nsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYNbwqNqK89ZCWWpAT5HCR59A+J873_5Odyjyb9qu00nsg@mail.gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Sorry for the responding to the thread so late. I thought I will try to
trigger the discussion such a user interface requires to get merged.

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

Yes, and I was told there are quite a few interested parties. I was expecting
them to get involved in the discussion if you would like to see such a
interface get merged any sooner. While it is interesting, I am afraid it is
not getting required attention and review by few if not all interested
parties.

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

This is one of the reason I want more people to get involved in the discussion
and review of the interface. All we have using this interface is some simple
demo quality applications. We would like to see people migrating to FF-A and
currently using some custom interface(basically in absence of OPTEE) to
communicate with the secure world.

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

Balint had some concerns, but I may have swayed him towards this. But I have
asked him to present his reasoning so that everything gets discussed. I just
don't want to give people a chance to hear those reasons.

I am sure I had few other points to make, but I have forgotten them as it was
at-least couple of months back that me and Balint had a chat on this and I
completely forgot to follow up on this. Balint, feel free to add you views
on this. I will add things as they pop up in my mind later.

--
Regards,
Sudeep
