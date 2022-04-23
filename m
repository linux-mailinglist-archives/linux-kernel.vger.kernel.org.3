Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95C7B50C983
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 13:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235175AbiDWLPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 07:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbiDWLPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 07:15:13 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B825DCD
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 04:12:17 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id d22so588783wrc.13
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 04:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TgZGUu18sUqEflQul3HE3gNa2RZslmJlgEQ5Ca0qxHY=;
        b=KcB+MOY49fDh/5nux1j5g8rrEM50z9MvbAN+3IC3EgSfKjxURcU/mGCXUlgCOhabfX
         /O9fqhn/IU/PJqkXEilmpVL/pXkgQlenCURj7omI8a3Q5ObjQIXd2eWpN9+auRhECuSd
         U6R/yZt42MCvVQ/bpACSVKUA/Oh06wCBOZNB8N0DnOsdfrLPbO10HT97mE76WklF+sBu
         z5XVVLLgQatbZ8Z6ZV6GPeAhUHzUSp/E2TH7T6UonfmB9+Bne5tVVfcJccN6yJTqUsnZ
         Z+v77TB0Cac+/7v0jLt3NcIechtHuIIXeKY8ojUc9ccQnxNUj+WZ670XedY9SCRSfSne
         crdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TgZGUu18sUqEflQul3HE3gNa2RZslmJlgEQ5Ca0qxHY=;
        b=68uTUctuCdzjc7f73f3yg5xqGkjeLxp1xHtnk/pNnq+Vhz8HvxwO1zmcnjsY/6wy1u
         Avq05B8tRY+Y4H2QSOUMblsfrUBHpP8lqZC7uvsBhDFluJgLJIDYzW1FkgGdAvHPQAA+
         ifcSVY5xHArrjjaFe7TXNMaa/deSBcbShOBqo1XH+7iCLG4cPYZW2Pmo7kI8LkkwufXn
         wsZSMYD6W+upRv8B8J3moQ69PPwTPj4XGLSu/4soVOYg/yPYzsx2rJuyJqdncIZUcYgp
         bkXlsg0KWVoXnI4mYbsAnbfeCwDBDxgU32SvcSjSBqUfUO3+olc1mGkMJidKdurmFHJX
         JXrQ==
X-Gm-Message-State: AOAM533cnxwzWY0jk+53P4RK53a8zFx2QMCLipQnto41WgIcfc6bUinQ
        naWC8V4vW2DEBl5gNfUHiE58G94COswHNeb9EFQ=
X-Google-Smtp-Source: ABdhPJzahX171NJVwwA+X6fyv0ItQfTGJyitYu26N1FlvSpyKbYMNwxffenQSkD8cQ+cwZpvNvx50g==
X-Received: by 2002:adf:c547:0:b0:207:9abc:cfa1 with SMTP id s7-20020adfc547000000b002079abccfa1mr6980350wrf.390.1650712335468;
        Sat, 23 Apr 2022 04:12:15 -0700 (PDT)
Received: from google.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id f6-20020a05600c4e8600b00393e31ac628sm1673486wmq.7.2022.04.23.04.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 04:12:14 -0700 (PDT)
Date:   Sat, 23 Apr 2022 11:12:13 +0000
From:   Sebastian Ene <sebastianene@google.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        qperret@google.com, will@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH  v2 0/2] Detect stalls on guest vCPUS
Message-ID: <YmPfDabN6i+yRxgR@google.com>
References: <20220422141949.3456505-1-sebastianene@google.com>
 <YmOh5I7ZK08LlM6D@kroah.com>
 <YmPAoFjfGoBHbPjC@google.com>
 <877d7gcf9j.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877d7gcf9j.wl-maz@kernel.org>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 23, 2022 at 10:36:56AM +0100, Marc Zyngier wrote:
> On Sat, 23 Apr 2022 10:02:24 +0100,
> Sebastian Ene <sebastianene@google.com> wrote:
> > 
> > On Sat, Apr 23, 2022 at 08:51:16AM +0200, Greg Kroah-Hartman wrote:
> > > On Fri, Apr 22, 2022 at 02:19:48PM +0000, Sebastian Ene wrote:
> > > > This adds a mechanism to detect stalls on the guest vCPUS by creating a
> > > > per CPU hrtimer which periodically 'pets' the host backend driver.
> > > > 
> > > > This device driver acts as a soft lockup detector by relying on the host
> > > > backend driver to measure the elapesed time between subsequent 'pet' events.
> > > > If the elapsed time doesn't match an expected value, the backend driver
> > > > decides that the guest vCPU is locked and resets the guest. The host
> > > > backend driver takes into account the time that the guest is not
> > > > running. The communication with the backend driver is done through MMIO
> > > > and the register layout of the virtual watchdog is described as part of
> > > > the backend driver changes.
> > > > 
> > > > The host backend driver is implemented as part of:
> > > > https://chromium-review.googlesource.com/c/chromiumos/platform/crosvm/+/3548817
> > > > 
> > > > Changelog v2:
> > > >  - move the driver to misc as this does not cope with watchdog core
> > > >    subsystem
> > 
> > Hello Greg,
> > 
> > > 
> > > Wait, why does it not cope with it?  That's not documented anywhere in
> > > your patch that adds the driver.  In fact, most of the text here needs
> > > to be in the changelog for the driver submission, not thrown away in the
> > > 00/XX email that will never end up in the kernel tree.
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > 
> > From the previous feedback that I received on this patch it seems that
> > watchdog core is not intended to be used for this type of driver. This
> > watchdog device tracks the elapsed time on a per-cpu basis,
> > since KVM schedules vCPUs independently. Watchdog core is not intended
> > to detect CPU stalls and the drivers don't have a notion of CPU.

Hello Marc,

> 
> I must say that I don't really get the objection against the watchdog
> approach. OK, there is no userspace aspect to this.  But we already
> use watchdogs for more than just userspace (reboot is one of the major
> use cases).
> 
> There already are per-CPU watchdog in the tree: see how the
> fsl-ls208xa platform has one SP805 per CPU (8 of them in total). As
> far as I can tell, there was no objection to this. So what is special
> about this one?

I think the difference is in the fact that this driver expects hrtimers
which are CPU binded to execute the periodic watchdog 'pet'. We would
require a strong thread affinity setting if we rely on userspace to
do this 'pet' operation.

Thanks,
Sebastian

> 
> Thanks,
> 
> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.
