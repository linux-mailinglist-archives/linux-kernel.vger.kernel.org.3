Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8545D4DD9AF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 13:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236232AbiCRMXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 08:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236157AbiCRMXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 08:23:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0C5422D7AAF
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 05:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647606148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F/7MqHqnA/d3fd2dn1g8Wn6RSOs3VYhwPed/PsU780U=;
        b=gc7ZgRPsFX0MwebsHQPU3B1AcKvGdwFrvGT4hVXKi0rvbPH5zFYuL2JJK/rZF07EDBFBud
        79d2TvbmaoY1GOAQjfo5Rkuvj9+cb3HSSTaieuaQBx9KatCFJFCq4mdIwA0SDOGVX0VYlH
        uLjs4+CCj73bdxfaI6bzp0UcdI3IfYw=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-671-qpMvExxHO6SPRo07ynM2Kw-1; Fri, 18 Mar 2022 08:22:26 -0400
X-MC-Unique: qpMvExxHO6SPRo07ynM2Kw-1
Received: by mail-pl1-f197.google.com with SMTP id n12-20020a1709026a8c00b001538f557d52so3994709plk.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 05:22:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F/7MqHqnA/d3fd2dn1g8Wn6RSOs3VYhwPed/PsU780U=;
        b=jCnaonUVlS8E93VL+RHqQr9R9glNzm7YGGcN4d+fIzxE2dCdSs9KhLluj0K4qPb31N
         jlgtZb4CK/A7KdCfhvDkOLbVUy3dMIFYXOhmm4dkXBuGX3qERKz+B/A54V/P3zwHxzLg
         28tEof78ku5UOde+1Dt7Muji6V+yzk9pE9d1Fpu+Lw0vPHw3kyS85l6GbyoQMy+8SH61
         dj3EgsTzIcTAJO0XXTizFPgB3VlrBmXfLXA8dqolipih4RndES6MzulF50GSLF/b3rAC
         9899aNKfAa2DXjQ9I68d+ZS+67zhxrLt3/JlS12VtGh+QJId0qtR0/94hnegD5nn7ueP
         +FhA==
X-Gm-Message-State: AOAM532xgM5PcnR5l52rJNwTVE4IUC8CIn9PZFqb2DZYrYbeixjC+bGV
        zX9c53O/jkD6FCkBYOn7ht8ZL3urd4P8wqddfj6+QzH0vXoNBR6w/TLBYcvTMT7zvwy4GoZEled
        PpZgDCgnMDvxAhiTjoTKDd2Nq
X-Received: by 2002:a63:ab47:0:b0:375:5d05:9f79 with SMTP id k7-20020a63ab47000000b003755d059f79mr7741652pgp.192.1647606145725;
        Fri, 18 Mar 2022 05:22:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw3eshlaWJ8wd1uKp/z4Oud7qyQICGN8fQBVPH5X047r2w3jQXu3EAWGU+6TaSYzKdGlaizKA==
X-Received: by 2002:a63:ab47:0:b0:375:5d05:9f79 with SMTP id k7-20020a63ab47000000b003755d059f79mr7741630pgp.192.1647606145389;
        Fri, 18 Mar 2022 05:22:25 -0700 (PDT)
Received: from localhost ([2a09:bac0:22::825:2bb2])
        by smtp.gmail.com with ESMTPSA id c14-20020a056a00248e00b004f77e0fbfc0sm9743322pfv.185.2022.03.18.05.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 05:22:24 -0700 (PDT)
Date:   Fri, 18 Mar 2022 20:21:10 +0800
From:   Coiby Xu <coxu@redhat.com>
To:     Milan Broz <gmazyland@gmail.com>
Cc:     kexec@lists.infradead.org, Thomas Staudt <tstaudt@de.ibm.com>,
        Kairui Song <ryncsn@gmail.com>, dm-devel@redhat.com,
        Mike Snitzer <snitzer@redhat.com>, Baoquan He <bhe@redhat.com>,
        Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC 0/4] Support kdump with LUKS encryption by reusing LUKS
 master key
Message-ID: <20220318122110.7qjrnrduwytjle3w@Rk>
References: <20220318103423.286410-1-coxu@redhat.com>
 <c857dcf8-024e-ab8a-fd26-295ce2e0ae41@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <c857dcf8-024e-ab8a-fd26-295ce2e0ae41@gmail.com>
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Milan,

On Fri, Mar 18, 2022 at 12:29:06PM +0100, Milan Broz wrote:
>On 18/03/2022 11:34, Coiby Xu wrote:
>>With kdump enabled, when kernel crashes, the system could boot into the
>>kdump kernel and dump the memory image i.e. /proc/vmcore to a specified
>>target. Currently, when dumping vmcore to a LUKS encrypted device, there
>>are two problems,
>>  - for some machines, the user may don't have a chance enter the password
>>    to decrypt the device after kernel crashes and kdump initrd is loaded
>>  - LUKS2 by default use the memory-hard Argon2 key derivation function
>>    which is quite memory-consuming compared to the limited memory reserved
>>    for kdump. Take Fedora example, by default, only 256M is reserved for
>>    systems having memory between 4G-64G. With LUKS enabled, ~1300M needs
>>    to be reserved for kdump.
>>Besides the users (at least for Fedora) usually expect kdump to work out
>>of the box i.e. no manual password input is needed. And it doesn't make
>>sense to derivate the master key again in kdump kernel which seems to be
>>redundant work.
>>
>>Based on Milan's feedback [1] on Kairui's ideas to support kdump with
>>LUKS encryption, this patch set addresses the above issues by
>
>Hi,
>
>I think you are creating another attack vector here, storing the encryption
>key to yet another place... but I already mentioned that in the referenced mail.

Thanks for the quick response! I thought the take-home message of the
referenced is we shouldn't leave the master key in the user space. Sorry 
I seem to still misunderstand what's mentioned in the referenced mail. But
take AES as an example, my reasoning is as follows:
   the expanded key has already been stored in "struct crypto_aes_ctx".
   If a hacker can somehow access the master key stored in the memory
   reserved exclusively for kdump, it means he/she can also access the
   expanded key stored in struct crypto_aes_ctx. So  not creating
   another attack vector?

>
>Why is it not done through keyring and forcing kdump to retain key there
>(under the same keyring key name as dm-crypt used)?
>Kernel dm-crypt supports this already; LUKS2 uses keyring by default too.
>That's all you need, or not? Why do you need to add another "kdump:" thing?
>IOW why kdump cannot copy the key to keyring under the name dm-crypt
>has in the mapping table and let dm-crypt activate the device almost without
>code changes?

Sorry, I haven't explained how kdump works. Once the 1st kernel crashes and
the system boots into the kdump kernel, the kdump kernel only have direct
access to the memory exclusively reserved for it i.e. the kdump kernel
loses the direct access to the keyring constructed in the 1st kernel. In
theory, the kdump kernel could do some "hacking" to find out the key
stored in the memory directly managed by the 1st kernel but I imagine
this would be difficult task (imagine I present the memory dump of my
computer to you and ask you to rebuild all the relevant kernel data
structures and find the key). Besides, it's not reliable to read the
memory directly managed by the first kernel for example the memory could
be corrupt. So we have to pass the master key from the 1st kernel to the kdump
kernel.

Btw, if we store the key in the kernel keyring, doesn't it mean storing the
"encryption key to another place" and thus creating "another attach vector"?

>
>Anyway, please fix the naming before this patchset can be read or reviewed!
>
>LUKS is user-space key management only (on-disk metadata); the kernel has
>no idea how the key is derived or what LUKS is - dm-crypt only knows the key
>(either through keyring or directly in the mapping table).
>
>Polluting kernel namespace with "luks" names variables is wrong - dm-crypt
>is used in many other mappings (plain, bitlocker, veracrypt, ...)
>Just use the dm-crypt key, do not reference LUKS at all.

Thanks for pointing out my mistake of misusing the word LUKS! I'll fix this
error once we settle down what's the correct approach to reuse master
key for the kdump kernel.

>
>Milan
>
>
>
>>  1) first saving the LUKS master key to kexec when opening the encrypted
>>     device
>>  2) then saving the master key to the reserved memory for kdump when
>>     loading kdump kernel image.
>>
>>So the LUKS master key never leaves the kernel space and once the key has
>>been saved to the reserved memory for kdump, it would be wiped
>>immediately. If there is no security concern with this approach or any
>>other concern, I will drop the following assumptions made for this RFC
>>version in v1,
>>  - only x86 is supported
>>  - there is only one LUKS device for the system
>>
>>to extend the support to other architectures including POWER, ARM and
>>s390x and address the case of multiple LUKS devices. Any feedback will be
>>appreciated, thanks!
>>
>>For a proof of concept, I've patched cryptsetup [2] in a quick-and-dirty
>>way to support a new option "--kdump-kernel-master-key"
>>and hacked systemd [3]. It works for Fedora 34.
>>
>>[1] https://yhbt.net/lore/all/e5abd089-3398-fdb4-7991-0019be434b79@gmail.com/
>>[2] https://gitlab.com/coxu/cryptsetup/-/commit/ee54bb15445da0bc3f9155a7227a9799da4dac20
>>[3] https://github.com/coiby/systemd/tree/reuse_kdump_master_key
>>
>>Coiby Xu (4):
>>   kexec, dm-crypt: receive LUKS master key from dm-crypt and pass it to
>>     kdump
>>   kdump, x86: pass the LUKS master key to kdump kernel using a kernel
>>     command line parameter luksmasterkey
>>   crash_dump: retrieve LUKS master key in kdump kernel
>>   dm-crypt: reuse LUKS master key in kdump kernel
>>
>>  arch/x86/include/asm/crash.h      |  1 +
>>  arch/x86/kernel/crash.c           | 42 ++++++++++++++++++-
>>  arch/x86/kernel/kexec-bzimage64.c |  7 ++++
>>  drivers/md/dm-crypt.c             | 26 +++++++++---
>>  include/linux/crash_dump.h        |  4 ++
>>  include/linux/kexec.h             |  7 ++++
>>  kernel/crash_dump.c               | 69 +++++++++++++++++++++++++++++++
>>  kernel/kexec_core.c               | 66 +++++++++++++++++++++++++++++
>>  8 files changed, 215 insertions(+), 7 deletions(-)
>>
>

-- 
Best regards,
Coiby

