Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA4E34AEE33
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 10:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239132AbiBIJlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 04:41:00 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:36200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240059AbiBIJhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 04:37:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0CD9CE061E6F
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 01:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644399438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VjsoUEihlP5/+Xekk4XWZ3ddwqyUg9r9chckwalLoEA=;
        b=HKG3dFDu7s5tlVi4RaglX9FblKB5FQGJe2b9wNI+8wNTplSGxgRGSncS8WE/eka83wS0jP
        FSGbLqxJt6KudBm4+538P5cjYYXnCHbVQY4c71v1csA2yBCFJRcW6RB4H41evnZ5APkHOJ
        d6tZhwxVJg7kVE2NvFodktAJzdthEro=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-637-P2FQFn4-Ncajs4mCVrx-rQ-1; Wed, 09 Feb 2022 04:15:47 -0500
X-MC-Unique: P2FQFn4-Ncajs4mCVrx-rQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EA1A718B9F00;
        Wed,  9 Feb 2022 09:15:45 +0000 (UTC)
Received: from localhost (ovpn-12-114.pek2.redhat.com [10.72.12.114])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AFB8D7AB6E;
        Wed,  9 Feb 2022 09:15:44 +0000 (UTC)
Date:   Wed, 9 Feb 2022 17:15:41 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Petr =?utf-8?B?VGVzYcWZw61r?= <ptesarik@suse.cz>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Xuefeng Li <lixuefeng@loongson.cn>, kexec@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] kdump: Add support for crashkernel=auto
Message-ID: <YgOGPbdtQIhPNen7@MiWiFi-R3L-srv>
References: <1643275911-19489-1-git-send-email-yangtiezhu@loongson.cn>
 <d513dea3-7300-9684-73af-0b51f5f0e572@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d513dea3-7300-9684-73af-0b51f5f0e572@suse.cz>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 01/27/22 at 04:53pm, Petr Tesařík wrote:
> Hi Tiezhu Yang,
> 
> I'm afraid the whole concept is broken by design. See below.
> 
> Dne 27. 01. 22 v 10:31 Tiezhu Yang napsal(a):
> > Set the reserved memory automatically for the crash kernel based on
> > architecture.
> > 
> > Most code of this patch come from:
> > https://gitlab.com/redhat/centos-stream/src/kernel/centos-stream-8/-/tree/c8s

This code is from RHEL8/Centos8 which Redhat has been using. It's
working pretty well, except of those big box with dozens of pcie
devices, or exceptional device driver costing very much memory.
See below patchset in i40e NIC case, it eats out 1.5G meory on
ppc64le for a NIC driver init.

[PATCH v1 0/3] Reducing memory usage of i40e for kdump
https://www.spinics.net/lists/kexec/msg26521.html

I agree asking customer to estimate the needed reservation size firstly,
then adding the value to cmdline and reboot is much easier. The thing is
it needs customer to operate. And no matter how much reservation is
needed, it mostly will be satisfied, including the above crazy i40e.
You won't get report about the exception, unless user check that
carefully each time. And you can't cover the hotplugged case.

The thing is which side is in lazy mode. Customer do the
estimation and set, developer is easy. If customer want to be easy,
developer need do more.

https://sigillatum.tesarici.cz/2022-01-27-whats-wrong-with-crashkernel-auto.html

I read Petr's above article, I have some different opinion about part of
them. Crashkernel=auto is not for upstream kernel, or customized kernel,
it is for distros. For distros, the kernel config is fixed in one
release, the kernel code, data is fixed. In rhel8, crashkernel=160M
is a default value, and works on most of cases. The kernel modules are
different, we filter out the unneeded according to user's kdump config.
We only keep the needed user space tools certainly. We have document to
note user that nfs needs more memory, some big end server need more memory.
We try to reserve a little more memory propotional to the total memory.
With these effort, we hope more people can try kdump w/o worrying about
no knowledge.

About the effort trying to get crashkernel=auto into kernel, Philipp
pasted a patch from Oracle. The kernel config way is expected but
rejected by Linus. We gave up too soon. RHEL instead make it in
userspace package. We will see, we may try again if it's not going well.


> And that's the problem, I think. The solution might be good for this
> specific OS, but not for others.
> 
> > [...]
> > diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> > index 256cf6d..32c51e2 100644
> > --- a/kernel/crash_core.c
> > +++ b/kernel/crash_core.c
> > @@ -252,6 +252,26 @@ static int __init __parse_crashkernel(char *cmdline,
> >   	if (suffix)
> >   		return parse_crashkernel_suffix(ck_cmdline, crash_size,
> >   				suffix);
> > +
> > +	if (strncmp(ck_cmdline, "auto", 4) == 0) {
> > +#if defined(CONFIG_X86_64) || defined(CONFIG_S390)
> > +		ck_cmdline = "1G-4G:160M,4G-64G:192M,64G-1T:256M,1T-:512M";
> > +#elif defined(CONFIG_ARM64)
> > +		ck_cmdline = "2G-:448M";
> > +#elif defined(CONFIG_PPC64)
> > +		char *fadump_cmdline;
> > +
> > +		fadump_cmdline = get_last_crashkernel(cmdline, "fadump=", NULL);
> > +		fadump_cmdline = fadump_cmdline ?
> > +				fadump_cmdline + strlen("fadump=") : NULL;
> > +		if (!fadump_cmdline || (strncmp(fadump_cmdline, "off", 3) == 0))
> > +			ck_cmdline = "2G-4G:384M,4G-16G:512M,16G-64G:1G,64G-128G:2G,128G-:4G";
> > +		else
> > +			ck_cmdline = "4G-16G:768M,16G-64G:1G,64G-128G:2G,128G-1T:4G,1T-2T:6G,2T-4T:12G,4T-8T:20G,8T-16T:36G,16T-32T:64G,32T-64T:128G,64T-:180G";
> > +#endif
> > +		pr_info("Using crashkernel=auto, the size chosen is a best effort estimation.\n");
> > +	}
> > +
> 
> How did you even arrive at the above numbers? I've done some research on
> this topic recently (ie. during the last 7 years or so). My x86_64 system
> with 8G RAM running openSUSE Leap 15.3 seems needs 188M for saving to the
> local disk, and 203M to save over the network (using SFTP). My PPC64 LPAR
> with 16G RAM running latest Beta of SLES 15 SP4 needs 587M, i.e. with the
> above numbers it may run out of memory while saving the dump.
> 
> Since this is not the first time, I'm trying to explain things, I've written
> a blog post now:
> 
> https://sigillatum.tesarici.cz/2022-01-27-whats-wrong-with-crashkernel-auto.html
> 
> HTH
> Petr Tesarik
> 

