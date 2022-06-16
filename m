Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 290E654EDD1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 01:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379357AbiFPXSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 19:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbiFPXSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 19:18:40 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B787862A2D
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 16:18:39 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id f65so2549960pgc.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 16:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wr4R7D/bGGvnqjr3JwtuscbiwltvBDPKUT/tGbf44lQ=;
        b=Z1Q0XF0r82CHhW1KfZ0J4fUvHudEkVotuFn2aY9vgDNH7WHZ4HB9uxZmLTZpaZUTTh
         bf8SMnYBVvULr8ctAK669ulXlvd+j5XAtLnVi3nefRrAjZLCA6iTk82DSQzu2vtVlnXM
         gCnP2lnjhblxpQozEVUWTi1EUB5X8IJ32HQC4xGnQjdu8GC6eq5+/t4kmZzLlEg76Fi6
         ddvXdsIVaa9ZkU9hbsZXDTu9KyDImKq0Ev+ZVuhWKZXIEBOSTsL02gwGew1fX+i+wpU6
         6X7Vteh9TFu1y2DmHKg/sfFzweH/O8Z6QpIYU8F1N1zCYyYIQf7YlZGew9J7nbxQqkSR
         9epQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wr4R7D/bGGvnqjr3JwtuscbiwltvBDPKUT/tGbf44lQ=;
        b=cy8fQrNA8U7BXMbS49W+mzstXUufTer8Q0Ra0BNtkze8bCSey8Q/7e2/IB3M9QAht1
         Krjig+VJl5EEAE9mhIk1G2s5NIs80oanZSUbieENISqX+Iq3KT2nzQYDdwoGzxFw0K4Z
         XaCuiqYJjxl/5roj+fmRxCtKEhg9igMFZvHQACvppje1bKIbusIn/0SftVvP3qWEgBTo
         i11rMNCft0btDmNF1wdoj7AAyrWnH63mAJ/9otAUX6DD8VUrqtQqLLi8oEgeu9Nj1T8V
         RBxyAeGoeQ9DgTmH3ZJJO2jh2rX4LrnXiVJL4oX6LQeWMui9JJ4pIbSfqZUWuAjJgfj6
         E2Zw==
X-Gm-Message-State: AJIora/I0CdpkVlGr8iKtQo6krFeyh3gWTEnqAKANiFuOyhMIj5lEupa
        dIezk5wlOgyuN6DFYAx+Nhom5vwDOODGqw==
X-Google-Smtp-Source: AGRyM1sOe7J4YTeDoXRcPOlZd7ae8ldvfWFg5Q3akvQj43YSyww3yMhWJ+d/0SoIX3hJLnUUpBKF/w==
X-Received: by 2002:a63:8841:0:b0:3fc:704c:24ff with SMTP id l62-20020a638841000000b003fc704c24ffmr6626714pgd.116.1655421517823;
        Thu, 16 Jun 2022 16:18:37 -0700 (PDT)
Received: from google.com (249.189.233.35.bc.googleusercontent.com. [35.233.189.249])
        by smtp.gmail.com with ESMTPSA id k34-20020a17090a14a500b001e305f5cd22sm1982358pja.47.2022.06.16.16.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 16:18:37 -0700 (PDT)
Date:   Thu, 16 Jun 2022 23:18:33 +0000
From:   William McVicker <willmcvicker@google.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, Tejun Heo <tj@kernel.org>,
        kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] sysfs: fix sysfs_kf_seq_show null pointer dereference
Message-ID: <Yqu6SeqVlumtHVL3@google.com>
References: <20220614172401.3010509-1-willmcvicker@google.com>
 <YqjFPxuPO6SZuvg2@kroah.com>
 <20220615175330.GA26653@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615175330.GA26653@lst.de>
X-Spam-Status: No, score=-15.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/15/2022, Christoph Hellwig wrote:
> On Tue, Jun 14, 2022 at 07:28:31PM +0200, Greg Kroah-Hartman wrote:
> > On Tue, Jun 14, 2022 at 05:24:01PM +0000, Will McVicker wrote:
> > > When the kobj->ktype is null,
> > 
> > How can that happen?  What in-tree code does that?
> 
> Yes, I'd be really curious how we arrived there.  I we ever end in
> this case we're having a major problem, as all the sysfs files
> should go through sysfs_add_file_mode_ns, which already derferences
> kobj->ktype->sysfs_ops directly.  I.e. for this to happen
> kobj->ktype must have been cleared on a live file, or someone
> must have bypassed sysfs_add_file_mode_ns.

Okay, so I was able to figure out that the Android userspace process that
triggers this issue is called rebalance_interrupts. You can find the source
code here [1]. I can reproduce this issue in about 5-10 reboots. As the name
indicates, it rebalances the IRQs. I found that the crash happens when the
program reads the sysfs files: /sys/kernel/irq/<irq>/actions. I haven't looked
into how kobj->ktype becomes null yet. I'll look deeper into that now, but
wanted to update this thread in case this information triggers any hints for
you guys on why this is happening.

Thanks,
Will

[1] https://android.googlesource.com/platform/hardware/google/pixel/+/refs/heads/android12-qpr3-s2-release/rebalance_interrupts
