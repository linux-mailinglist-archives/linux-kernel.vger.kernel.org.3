Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE52519622
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 05:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344348AbiEDDwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 23:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236361AbiEDDwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 23:52:32 -0400
X-Greylist: delayed 401 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 03 May 2022 20:48:57 PDT
Received: from pricom.com.au (pricom.com.au [14.202.193.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DCAB1A040
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 20:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed;
        d=pricom.com.au; s=phr1; h=MIME-Version:Content-Type:
        Content-Transfer-Encoding:Date:From:To:Cc:Subject:Reply-To:
        Mail-Reply-To:In-Reply-To:References:Message-ID; bh=YayLtC0WPVN5
        EDnxFhIUN1fXdtM=; b=w0GGaAdSWx8ZsqHm9WqrOumt2kI54A7J/hCtMkyObBuE
        9MpMNFLR+TWLqj8BqFFZJPDQDNTdG+q+VavpA/+4TUuZjwNYapb8rG+Zvz2AVHJp
        Apt01mxAnDXRcGN9dhcpGLM9hJGlUhtDiM58nN8Eu+6yhWqb749ZtrJdAOtM310=
Received: (indimail-mta 1395324 invoked from 127.0.0.1 by host pricom.com.au by uid 555); Wed, 4 May 2022 13:42:14 +1000
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed;
        d=pricom.com.au; s=phr1; x=1652240533; h=MIME-Version:
        Content-Type:Content-Transfer-Encoding:Date:From:To:Cc:Subject:
        Reply-To:Mail-Reply-To:In-Reply-To:References:Message-ID; bh=Yay
        LtC0WPVN5EDnxFhIUN1fXdtM=; b=lYk1cWKr7HM8sQAskUocTkSpmlLOCHw3P5x
        Q3T+WW/IIwfj9L3npxWiqDigGYqPUPw2cmyZGhKMh9D66JdnhPf9mVYcF7k8oBkW
        AGDMxg0DHv4jHDpZjX2hjueS4YCd2YDCfPwy1ZuPw8PCic1WqTtdeWS1CjZJu8LY
        3HYapWaE=
Received: from localhost (HELO pricom.com.au) (phr@::ffff:127.0.0.1)
  by 0 with ESMTPA; Wed, 4 May 2022 13:42:13 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 04 May 2022 13:42:03 +1000
From:   Philip Rhoades <phil@pricom.com.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Alexey Gladkov <legion@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Daniel Walsh <dwalsh@redhat.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Linux Containers <containers@lists.linux.dev>,
        Manfred Spraul <manfred@colorfullife.com>,
        Serge Hallyn <serge@hallyn.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Vasily Averin <vvs@virtuozzo.com>
Subject: Re: [PATCH v1 0/4] ipc: Remove extra1 field abuse to pass ipc
 namespace
Reply-To: phil@pricom.com.au
Mail-Reply-To: phil@pricom.com.au
In-Reply-To: <CAHk-=whi2SzU4XT_FsdTCAuK2qtYmH+-hwi1cbSdG8zu0KXL=g@mail.gmail.com>
References: <CAHk-=wgBB8iPd0W=MQWnQJukMAPAqgsC0QX2wwiSvcct9zu_RA@mail.gmail.com>
 <cover.1650631347.git.legion@kernel.org>
 <CAHk-=whi2SzU4XT_FsdTCAuK2qtYmH+-hwi1cbSdG8zu0KXL=g@mail.gmail.com>
Message-ID: <94d3de676845342fa8abe0c90ee3c98f@pricom.com.au>
X-Sender: phil@pricom.com.au
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

People,


On 2022-04-23 06:44, Linus Torvalds wrote:
> On Fri, Apr 22, 2022 at 5:53 AM Alexey Gladkov <legion@kernel.org> 
> wrote:
>> 
>> Yes, Linus, these changes are not the refactoring you were talking
>> about, but I plan to try to do such a refactoring in the my next
>> patchset.
> 
> Heh. Ok, I'm not saying these patches are pretty, and looking up the
> namespace thing is a bit subtle, but it's certainly prettier than the
> existing odd "create a new ctl_table entry because of field abuse".
> 
> So this certainly looks like an improvement from a quick look.
> 
>               Linus


Thanks for that little glimpse into what happens with kernel development 
- interesting!

Phil.
-- 
Philip Rhoades

PO Box 896
Cowra  NSW  2794
Australia
E-mail:  phil@pricom.com.au
