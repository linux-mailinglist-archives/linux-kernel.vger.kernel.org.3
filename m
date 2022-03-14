Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE414D805D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 12:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238719AbiCNLIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 07:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbiCNLIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 07:08:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 56E6447AD1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 04:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647256023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BLRs68CPmtcOOmJUEUtuz0QjAh+LK/7FJhncH6x/EEo=;
        b=Yjdeum6tofEFIr369Ht4TQAXUBeRO14UkhtfK76AHcnywvcBLzxZ6thmqtPltGwKxFL6N7
        uX/kT84qvgstCttDRyHwP/IZiFwAXGX5YPZfzao4s4ybrXjtymDaS+P4UFM5vJbZQrM5aj
        18aMc2Ahbu71zq9C+8sb7m76Afic/t8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-332-JR_P-PzZMmKx5ezHeUmphQ-1; Mon, 14 Mar 2022 07:06:57 -0400
X-MC-Unique: JR_P-PzZMmKx5ezHeUmphQ-1
Received: by mail-wr1-f69.google.com with SMTP id p9-20020adf9589000000b001e333885ac1so4235123wrp.10
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 04:06:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BLRs68CPmtcOOmJUEUtuz0QjAh+LK/7FJhncH6x/EEo=;
        b=flpUd8PiNPftHij1lgYrC5Jug1UCS6E/Lvj5Y2SELiNtXmSnkuuwphv7WKQDWg5Pll
         P5vSnGXzR42X6vDn83GztuKLnE4nv3jA5GEGZO4UV/ZAuOHWl4Io1SO32H3XFLjUZaqA
         o7yWiVL/T0b2eXbHW4Du8z9MQGxjgIlEhl9byp6iWH8tAEzNOC/aXZSbnLqDmibho/rl
         IxJvwTbLjGyr+5Zgb2sgR8m6M0WyRPxzOb3wzUXefdfJJWVYS07ocTkuOYZ1N1FZVF8A
         iUDXxQor4jAvt3WfXgk0Ref1GOmQRsFyS3Dd9lnGPhXWreMIyOOKd6yGKMIp+7Bq+1hZ
         UVgQ==
X-Gm-Message-State: AOAM5318ab19E8WRbFbaO54fYtDa2PtLfBMBIwzac3kwsnyKmJhXsN8k
        m9sQA/dk3YFf3UvVQORTrVrd4RcaF7Jn9RI+FmJTWXgXM2Bljqu8gZSdu/6t88ERo3agtO6rnzm
        msXjhzDnR6lSEkdc3gspYHXq1
X-Received: by 2002:adf:9d88:0:b0:1fd:872a:3a0a with SMTP id p8-20020adf9d88000000b001fd872a3a0amr15620427wre.579.1647256016218;
        Mon, 14 Mar 2022 04:06:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwDX2/Els7mxEyTxNLaQi6KS3CEEUZl7kN4Gi+HlG0m0rhAIBD9QQawS/L0DgWyElEpRqGYyw==
X-Received: by 2002:adf:9d88:0:b0:1fd:872a:3a0a with SMTP id p8-20020adf9d88000000b001fd872a3a0amr15620397wre.579.1647256015917;
        Mon, 14 Mar 2022 04:06:55 -0700 (PDT)
Received: from gator (cst2-173-70.cust.vodafone.cz. [31.30.173.70])
        by smtp.gmail.com with ESMTPSA id t184-20020a1c46c1000000b003814de297fcsm17674129wma.16.2022.03.14.04.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 04:06:55 -0700 (PDT)
Date:   Mon, 14 Mar 2022 12:06:53 +0100
From:   Andrew Jones <drjones@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, Thomas Huth <thuth@redhat.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>,
        Oliver Upton <oupton@google.com>
Subject: Re: [RFC PATCH 000/105] KVM: selftests: Overhaul APIs, purge VCPU_ID
Message-ID: <20220314110653.a46vy5hqegt75wpb@gator>
References: <20220311055056.57265-1-seanjc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2022 at 05:49:11AM +0000, Sean Christopherson wrote:
> First off, hopefully I didn't just spam you with 106 emails.  In theory,
> unless you're subscribed to LKML, you should see only the cover letter
> and everything else should be on lore if you want to pull down the mbox
> (instead of saying "LOL, 105 patches!?!?", or maybe after you say that).
> 
> This is a (very) early RFC for overhauling KVM's selftests APIs.  It's
> compile tested only (maybe), there are no changelogs, etc...
> 
> My end goal with an overhaul is to get to a state where adding new
> features and writing tests is less painful/disgusting (I feel dirty every
> time I copy+paste VCPU_ID).  I opted to directly send only the cover
> letter because most of the individual patches aren't all that interesting,
> there's still 46 patches even if the per-test conversions are omitted, and
> it's the final state that I really care about and want to discuss.
> 
> The overarching theme of my take on where to go with selftests is to stop
> treating tests like second class citizens.  Stop hiding vcpu, kvm_vm, etc...
> There's no sensitive data/constructs, and the encapsulation has led to
> really, really bad and difficult to maintain code.  E.g. Want to call a
> vCPU ioctl()?  Hope you have the VM...

Ack to dropping the privateness of structs.

> 
> The other theme in the rework is to deduplicate code and try to set us
> up for success in the future.  E.g. provide macros/helpers instead of
> spamming CTRL-C => CTRL-V (see the -700 LoC).

Ack to more helper functions. I'm not sure what the best way to document
or provide examples for the API is though. Currently we mostly rely on
test writers to read other tests (I suppose the function headers help a
bit, but, IMO, not much). Maybe we need a heavily commented example.c
that can help test writers get started, along with better API function
descriptions for anything exported from the lib.

> 
> I was hoping to get this into a less shabby state before posting, but I'm
> I'm going to be OOO for the next few weeks and want to get the ball rolling
> instead of waiting another month or so.

Ideas look good to me, but I'll wait for the cleaned up series posted to
the KVM ML to review it. Also, I see at least patch 1/105 is a fix. It'd
be nice to post all fixes separately so they get in sooner than later.

Oh, some of the renaming doesn't look all that important to me, like
prefixing with kvm_ or adding _arch_, but I don't have strong preferences
on the names. Also, for the _arch_ functions it'd be nice to create
common, weak functions which the arch must override. The common function
would just assert. That should help people who want to port to other
architectures determine what they need to implement first. And, for
anything which an arch can optionally adopt a common implementation,
*not* naming the common function with _arch_, but still defining it as
weak, would make sense to me too.

Thanks,
drew

