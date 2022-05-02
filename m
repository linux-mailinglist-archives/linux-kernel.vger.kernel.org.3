Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77058516B5E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 09:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358823AbiEBHmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 03:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358360AbiEBHmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 03:42:02 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C610BB87C
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 00:38:34 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id m6so11111555iob.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 00:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GPkNxE2r6P0xG3q/R7zfqzTrygEF3DAcqbdmgZiq2s0=;
        b=sCjuqeXJ9DCpoV1lQZ3M1xkzDHYEbWrrb+jsdTHqJB+kPx7YW+DS0fPHMMusOaTbBf
         UwISChxKC4zWaO+uzfsdTxi9lOWf9OIgLc1PMUTvLrQ9T36aA1+Ey6n3dPew/979MJhs
         KQflJzjLOIEmkUKeRMdbBeUcWVKeqG0DaybXe6oNqhLxvwSMmvEAVs+rcQw9n0OkOqqN
         yUQ7o+/qUit8hGWFJfsmlowJWJIPyt/XqRZFjwidmDTYkt1lw/32UNLfB+gFPBvhn0jT
         yTM/T2R4627TLJ4HSM+J4G63hU/xfkd45M62WWnyGObjL/s5dqrufqvVn/CDY4GGUjSx
         wh3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GPkNxE2r6P0xG3q/R7zfqzTrygEF3DAcqbdmgZiq2s0=;
        b=zWPdMILWpNq/PeZJ0m4FcearwEvj+PqgWy4XIk09zM3hkKxtXHMgunNU7knKAeQVit
         NPdgvry+jB906eeI80iEx/Fqls8qPN3400i8PezooTjFwG2do1hZUI72Gljrf4jjiLsI
         dfEIzXaHq7n8n9Zq4Q//8Ry9m30cnJ+WQ+YZbEt1LGt8ElrbhuS0iUPi/LMgIhZOqyed
         rxM/ZKnOIueGgWLwtRhVhm3/9R4ifanlMY0rXDr6xv/SeYspyH0j0dw/OxL31P3PJAGp
         BWc3+t7L3T62UXsEjbxBCspjPgnfe3HNq79OwcuRw4FUs687vgk4Vu8zlhoX+soLW6pJ
         wTlw==
X-Gm-Message-State: AOAM531fH8t11Le4LhqBpHkHePZcjBsqE8zVNfc2cIWPEjEsD0pCQLYV
        DFLqirl0U5wX3cdZnACC8nhhyw==
X-Google-Smtp-Source: ABdhPJyjhIe2znQiZB9jWAMBJcQm0B6Fv4anyhMrjJ5mNDxihDCEre28mU7PNuGJ+PLTTB3+fTcdGg==
X-Received: by 2002:a05:6638:2494:b0:32b:4c44:aaf1 with SMTP id x20-20020a056638249400b0032b4c44aaf1mr4447202jat.224.1651477113989;
        Mon, 02 May 2022 00:38:33 -0700 (PDT)
Received: from google.com (194.225.68.34.bc.googleusercontent.com. [34.68.225.194])
        by smtp.gmail.com with ESMTPSA id a10-20020a92330a000000b002cde6e352c8sm2507300ilf.18.2022.05.02.00.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 00:38:33 -0700 (PDT)
Date:   Mon, 2 May 2022 07:38:29 +0000
From:   Oliver Upton <oupton@google.com>
To:     Gavin Shan <gshan@redhat.com>
Cc:     kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        eauger@redhat.com, Jonathan.Cameron@huawei.com,
        vkuznets@redhat.com, will@kernel.org, shannon.zhaosl@gmail.com,
        james.morse@arm.com, mark.rutland@arm.com, maz@kernel.org,
        pbonzini@redhat.com, shan.gavin@gmail.com
Subject: Re: [PATCH v6 13/18] KVM: arm64: Support
 SDEI_EVENT_{COMPLETE,COMPLETE_AND_RESUME} hypercall
Message-ID: <Ym+KdY2y2vzMeDOL@google.com>
References: <20220403153911.12332-1-gshan@redhat.com>
 <20220403153911.12332-14-gshan@redhat.com>
 <Ym4tzRL0iMxyumJe@google.com>
 <ba094956-2e58-4913-527a-af79475ee949@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba094956-2e58-4913-527a-af79475ee949@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2022 at 02:19:30PM +0800, Gavin Shan wrote:
> Hi Oliver,
> 
> On 5/1/22 2:50 PM, Oliver Upton wrote:
> > On Sun, Apr 03, 2022 at 11:39:06PM +0800, Gavin Shan wrote:
> > > This supports SDEI_EVENT_{COMPLETE, COMPLETE_AND_RESUME} hypercall.
> > > They are used by guest to notify the completion of event in its
> > > handler. The previously interrupted or preempted context is restored
> > > like below.
> > > 
> > >     * x0 - x17, PC and PState are restored to what values we had in
> > >       the interrupted or preempted context.
> > > 
> > >     * If it's SDEI_EVENT_COMPLETE_AND_RESUME hypercall, IRQ exception
> > >       is injected.
> > 
> > I don't think that's how COMPLETE_AND_RESUME works. The caller specifies an
> > address at which it would like to begin execution within the client
> > exception level.
> > 
> > SDEI spec suggests this behaves like a synchronous exception. DEN 0054C
> > 5.2.2 'Event Resume Context' speaks more about how it is supposed to
> > work.
> > 
> 
> It's actually the linux convention. If the event handler, which was
> specified in previous hypercall to EVENT_REGISTER, returns success,
> the (linux) client calls into COMPLETE_AND_RESUME and the resume
> address is specified with FIQ vector offset. More details can be
> found from arch/arm64/kernel::sdei.c::do_sdei_event().

Right -- but look at what its doing. It returns the address at which it
wants to resume execution.

arch/arm64/kernel.entry.S::__sdei_asm_handler winds up passing this as
an argument to COMPLETE_AND_RESUME. Also, what would happen if we run
something that isn't Linux inside of KVM? This is why I suggested
implementing COMPLETE_AND_RESUME in line with the specification, not
based on what the kernel is presently doing.

--
Thanks,
Oliver
