Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A00494DD8EA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 12:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235767AbiCRLad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 07:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbiCRLaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 07:30:30 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45401ED060
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 04:29:10 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id h23so10711304wrb.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 04:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=zhJ3+Tw2rjs90pVrPjzkbml2R5PoxjaT42AVteHA4F4=;
        b=q516VCjdwtCe9ExYg5jxTM6l9XB8qwNeX8y5eNR6+HL73cG8FQ9hb2TPLpBKjb1dT6
         NvGxRCuKvNo8aVN6nJdzSVS2DBx6PxaQkix9oUOtVK/+trc8OuJCTxuwNt1YQoTTiNbA
         uT2HhDY/6bK2Y/gThrm6BrkhZlLNUeLZBzeJzR/+tth8MSlJIHTa8kN+WZiDy7mX2Bio
         UFaha/bDEuBJa80fFnGM7DdD7DuBSAK80LBQx62eEGA5wNCcY9F+zaDPC50s3lpm5Z03
         LGN0oJpO732oUH5xvoxZB2Soz2enqtt8spj171VcViDSTEhijGYFkvk8CgEQO6Bvo5fo
         qHsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zhJ3+Tw2rjs90pVrPjzkbml2R5PoxjaT42AVteHA4F4=;
        b=gQHIYJHuuMel1uZj5ljJUFFYKhKI94tN8n7kATiJ8F302gaaTQR6crtq2eWf+bMHYY
         WRFt2H5kdj2ekJP8efl89+BacNofhiob6Xt/Xdskm0GwbX5f41ew6kEy+O07YIUyK3gx
         C3nZ7PXRG+zsTz3/1p79ejiqpUTpGZ3Zw0gDRCQymAb7QSi2+tYgSP05DAHLJs6XMpOh
         60T0FWdNH7Hsc6GiVpF2x1aEpTIB4Fzm5JWHubu8jAP3aMm0rJ5dHrYl6aZwkVpLKzpj
         mOBx98kSL/ZioXNqIaQBsCBH9fAMZ6JYDpNU/fwpGBEcYiPtj0zZz4FN4/qlHaItu47m
         VbSw==
X-Gm-Message-State: AOAM532D05WzzBSA+JTUtkMBgURt/+kNzuX0gkYWLDpaAsssqatwdZGa
        r7PH6bIU16tBLwzm026T+ZY=
X-Google-Smtp-Source: ABdhPJzGJtYQoLClsmP2uoJXyJY8zHKqktfU1oIzutu5ac588ybaTCFux2Y51erMTm6SGuE7h2sCxQ==
X-Received: by 2002:adf:fb90:0:b0:203:b456:c71e with SMTP id a16-20020adffb90000000b00203b456c71emr7641995wrr.244.1647602949228;
        Fri, 18 Mar 2022 04:29:09 -0700 (PDT)
Received: from [192.168.2.27] (85-70-151-113.rcd.o2.cz. [85.70.151.113])
        by smtp.gmail.com with ESMTPSA id v14-20020a7bcb4e000000b0034492fa24c6sm6423788wmj.34.2022.03.18.04.29.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Mar 2022 04:29:08 -0700 (PDT)
Message-ID: <c857dcf8-024e-ab8a-fd26-295ce2e0ae41@gmail.com>
Date:   Fri, 18 Mar 2022 12:29:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC 0/4] Support kdump with LUKS encryption by reusing LUKS
 master key
Content-Language: en-US
To:     Coiby Xu <coxu@redhat.com>, kexec@lists.infradead.org
Cc:     Thomas Staudt <tstaudt@de.ibm.com>, Kairui Song <ryncsn@gmail.com>,
        dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        linux-kernel@vger.kernel.org
References: <20220318103423.286410-1-coxu@redhat.com>
From:   Milan Broz <gmazyland@gmail.com>
In-Reply-To: <20220318103423.286410-1-coxu@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/03/2022 11:34, Coiby Xu wrote:
> With kdump enabled, when kernel crashes, the system could boot into the
> kdump kernel and dump the memory image i.e. /proc/vmcore to a specified
> target. Currently, when dumping vmcore to a LUKS encrypted device, there
> are two problems,
>   - for some machines, the user may don't have a chance enter the password
>     to decrypt the device after kernel crashes and kdump initrd is loaded
>   - LUKS2 by default use the memory-hard Argon2 key derivation function
>     which is quite memory-consuming compared to the limited memory reserved
>     for kdump. Take Fedora example, by default, only 256M is reserved for
>     systems having memory between 4G-64G. With LUKS enabled, ~1300M needs
>     to be reserved for kdump.
>   
> Besides the users (at least for Fedora) usually expect kdump to work out
> of the box i.e. no manual password input is needed. And it doesn't make
> sense to derivate the master key again in kdump kernel which seems to be
> redundant work.
> 
> Based on Milan's feedback [1] on Kairui's ideas to support kdump with
> LUKS encryption, this patch set addresses the above issues by

Hi,

I think you are creating another attack vector here, storing the encryption
key to yet another place... but I already mentioned that in the referenced mail.

Why is it not done through keyring and forcing kdump to retain key there
(under the same keyring key name as dm-crypt used)?
Kernel dm-crypt supports this already; LUKS2 uses keyring by default too.
That's all you need, or not? Why do you need to add another "kdump:" thing?
IOW why kdump cannot copy the key to keyring under the name dm-crypt
has in the mapping table and let dm-crypt activate the device almost without
code changes?

Anyway, please fix the naming before this patchset can be read or reviewed!

LUKS is user-space key management only (on-disk metadata); the kernel has
no idea how the key is derived or what LUKS is - dm-crypt only knows the key
(either through keyring or directly in the mapping table).

Polluting kernel namespace with "luks" names variables is wrong - dm-crypt
is used in many other mappings (plain, bitlocker, veracrypt, ...)
Just use the dm-crypt key, do not reference LUKS at all.

Milan



>   1) first saving the LUKS master key to kexec when opening the encrypted
>      device
>   2) then saving the master key to the reserved memory for kdump when
>      loading kdump kernel image.
> 
> So the LUKS master key never leaves the kernel space and once the key has
> been saved to the reserved memory for kdump, it would be wiped
> immediately. If there is no security concern with this approach or any
> other concern, I will drop the following assumptions made for this RFC
> version in v1,
>   - only x86 is supported
>   - there is only one LUKS device for the system
> 
> to extend the support to other architectures including POWER, ARM and
> s390x and address the case of multiple LUKS devices. Any feedback will be
> appreciated, thanks!
> 
> For a proof of concept, I've patched cryptsetup [2] in a quick-and-dirty
> way to support a new option "--kdump-kernel-master-key"
> and hacked systemd [3]. It works for Fedora 34.
> 
> [1] https://yhbt.net/lore/all/e5abd089-3398-fdb4-7991-0019be434b79@gmail.com/
> [2] https://gitlab.com/coxu/cryptsetup/-/commit/ee54bb15445da0bc3f9155a7227a9799da4dac20
> [3] https://github.com/coiby/systemd/tree/reuse_kdump_master_key
> 
> Coiby Xu (4):
>    kexec, dm-crypt: receive LUKS master key from dm-crypt and pass it to
>      kdump
>    kdump, x86: pass the LUKS master key to kdump kernel using a kernel
>      command line parameter luksmasterkey
>    crash_dump: retrieve LUKS master key in kdump kernel
>    dm-crypt: reuse LUKS master key in kdump kernel
> 
>   arch/x86/include/asm/crash.h      |  1 +
>   arch/x86/kernel/crash.c           | 42 ++++++++++++++++++-
>   arch/x86/kernel/kexec-bzimage64.c |  7 ++++
>   drivers/md/dm-crypt.c             | 26 +++++++++---
>   include/linux/crash_dump.h        |  4 ++
>   include/linux/kexec.h             |  7 ++++
>   kernel/crash_dump.c               | 69 +++++++++++++++++++++++++++++++
>   kernel/kexec_core.c               | 66 +++++++++++++++++++++++++++++
>   8 files changed, 215 insertions(+), 7 deletions(-)
> 
