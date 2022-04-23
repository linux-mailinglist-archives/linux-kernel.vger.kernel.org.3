Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBDC350CC92
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 19:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236589AbiDWRcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 13:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiDWRcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 13:32:10 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6556B174422
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 10:29:13 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id g9so9892757pgc.10
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 10:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AhQD7vPYfAiEn+1RfQt67d4Dixq2S1YB+w4qj2jR+Q0=;
        b=xWKXKc58HUkxMRuDr/Zf6Aje7ybvTzC671zQtfNEALotesIZAxNUc2OGEA4z3Ra7Of
         lkStFa3Uxdix3cOJZDYBHyrFCMutNH68Gfit3R7u95+uMerV4inCdkX5tYTlb8bQppfP
         GVMOpuVsU+PKBwwRm8845rgsfzOkwkig89/gchUiiMe/tlrxvF59A4OkCGpnAU51r+CT
         SOqoDAkKyGT2546Nu4M586YH6iQFI0TriSPXJ4zKHuLS6E7GYPU0KRqyP+1sSitkfvyE
         /jlefNOpENa3XDJsSmPdNtL9DWk2ne95gAtVj79KvvOsDK8Xv5GoLzI4lnGOadxL3lh/
         XALg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AhQD7vPYfAiEn+1RfQt67d4Dixq2S1YB+w4qj2jR+Q0=;
        b=dSCe+mAf51Lalw6o50Rzdk2o4OaeU5zZZrSysuqEmcZvIhIY0MFP/r8s8lq8coT6qz
         27Yg6TfZvdobElMr1yES/ZiIjR/GHepHJMXDgq3zypCYj7UDjZb9AFqV0H0dbXbtcUn/
         3AqTO48WwVl7zYxwRob7r6mMTrcrQRMo8vC7YkxEyaetewoncgnJNuN2p5g8r0KbA1Fn
         AkC0vp56A6nRo7GZ5fEz2s3rcj72Fsq03CQkfJHtXHOoQDy/GT3J3BdagIJE6jzwz/Ds
         vlUQi9q7CsRbRj42mMtsi8wKFKzV3uuFs9IKf5bjzB98ZHuNDNw8AUEb+nBwNEYAVjAo
         jqKw==
X-Gm-Message-State: AOAM530mJvGlcvZNKfGR5sXr20m6VIWGMJYrNatZvR3Aruc05t89bjEh
        /dM7l2W+M0jT/HfjhB01jLP+aMWI7e6zBoMpXddiHw==
X-Google-Smtp-Source: ABdhPJxHuHMaqsEKztBmTLaKInseY99XjI/+A47OoxmxiEuZUwC9WyROijbh+f6qYfCWMeRmXPrwJ1l3eN2+M0oAWek=
X-Received: by 2002:a65:6e0e:0:b0:399:26d7:a224 with SMTP id
 bd14-20020a656e0e000000b0039926d7a224mr8657810pgb.437.1650734952939; Sat, 23
 Apr 2022 10:29:12 -0700 (PDT)
MIME-Version: 1.0
References: <165055518776.3745911.9346998911322224736.stgit@dwillia2-desk3.amr.corp.intel.com>
 <165055523099.3745911.9091010720291846249.stgit@dwillia2-desk3.amr.corp.intel.com>
 <YmOAXqOIW7DE0nMR@iweiny-desk3>
In-Reply-To: <YmOAXqOIW7DE0nMR@iweiny-desk3>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sat, 23 Apr 2022 10:29:02 -0700
Message-ID: <CAPcyv4gOBypbVV8dCrR6xWGSv0EA0sAVyNNwah1=d-hkuV3A_Q@mail.gmail.com>
Subject: Re: [PATCH v3 8/8] nvdimm: Fix firmware activation deadlock scenarios
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     linux-cxl@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 9:28 PM Ira Weiny <ira.weiny@intel.com> wrote:
>
> On Thu, Apr 21, 2022 at 08:33:51AM -0700, Dan Williams wrote:
> > Lockdep reports the following deadlock scenarios for CXL root device
> > power-management, device_prepare(), operations, and device_shutdown()
> > operations for 'nd_region' devices:
> >
> > ---
> >  Chain exists of:
> >    &nvdimm_region_key --> &nvdimm_bus->reconfig_mutex --> system_transition_mutex
> >
> >   Possible unsafe locking scenario:
> >
> >         CPU0                    CPU1
> >         ----                    ----
> >    lock(system_transition_mutex);
> >                                 lock(&nvdimm_bus->reconfig_mutex);
> >                                 lock(system_transition_mutex);
> >    lock(&nvdimm_region_key);
> >
> > --
> >
> >  Chain exists of:
> >    &cxl_nvdimm_bridge_key --> acpi_scan_lock --> &cxl_root_key
> >
> >   Possible unsafe locking scenario:
> >
> >         CPU0                    CPU1
> >         ----                    ----
> >    lock(&cxl_root_key);
> >                                 lock(acpi_scan_lock);
> >                                 lock(&cxl_root_key);
> >    lock(&cxl_nvdimm_bridge_key);
> >
> > ---
> >
> > These stem from holding nvdimm_bus_lock() over hibernate_quiet_exec()
> > which walks the entire system device topology taking device_lock() along
> > the way. The nvdimm_bus_lock() is protecting against unregistration,
> > multiple simultaneous ops callers, and preventing activate_show() from
> > racing activate_store(). For the first 2, the lock is redundant.
> > Unregistration already flushes all ops users, and sysfs already prevents
> > multiple threads to be active in an ops handler at the same time. For
> > the last userspace should already be waiting for its last
> > activate_store() to complete, and does not need activate_show() to flush
> > the write side, so this lock usage can be deleted in these attributes.
> >
>
> I'm sorry if this is obvious but why can't the locking be removed from
> capability_show() and nvdimm_bus_firmware_visible() as well?

It can, that's a good catch, thanks.
