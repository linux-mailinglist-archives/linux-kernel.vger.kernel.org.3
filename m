Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 357E64DE50A
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 02:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241743AbiCSBqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 21:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiCSBqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 21:46:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A56282DE78F
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 18:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647654325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ieSlFoCeto0AVAtI6K8jKTyxvQGGjjQJE1a9Rco3C2E=;
        b=hxc+gfE8xP2NhRESCeD7lfxGV0+KPnFs9/ffu6DB7H2YngvmwABSq14tcJHeF5PyuBOwhX
        Gdm3lGNwrKP3FnXSzdS6y3v+F3tQW7J0lw94N2UK4UGV4ZivnZlFyFUQ1zAlhZRRbDBPuo
        TBVByoYjoMikAbkNXgc8rFixrYsx0sI=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-168-OWImw656N1ivL0daZLvi2g-1; Fri, 18 Mar 2022 21:45:23 -0400
X-MC-Unique: OWImw656N1ivL0daZLvi2g-1
Received: by mail-pj1-f71.google.com with SMTP id o12-20020a17090a420c00b001c65aec76c0so5256520pjg.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 18:45:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ieSlFoCeto0AVAtI6K8jKTyxvQGGjjQJE1a9Rco3C2E=;
        b=6868MXd6nTFmNK3nxX5d7/RI9f1H+F9XCcOoUDWCXYb0fcxrF4xbsyrDFjlXxySHoT
         YB01XhmBOed/S1rbqALrc9s1wiHHaBkMeFeUdM6bD+yRySLb8gCTWAsvX4atb9Vr/IJE
         BbfrlUAbuYcPn68l/ry9xto/7KTm0KxHMaQsoUMpt/3d9y91foCZUa4jtH+AaZIDogRJ
         +XRjo7zQQTLsyvLlEeSem8Ljo3Azf3ufCDFrjMfB25haB5d5Y11xTpJnlIxh2ie3ck8p
         P5wetjTO4OpbSOpUkAjIVogvl2My0wYIv477V5A9BxiL1D9zueCojiQmcHB4IBKTrXpu
         6t0g==
X-Gm-Message-State: AOAM533fWSQfExhMzOxnMbkoEGwGQaByeIx9iJKGlz5rBhD1gEM2mR6Q
        DTkn0xJKe5m7oFPf1PGZiIUkxa2PaTSxcLyhlwAkUAPr3loO+I7Kodc5ZyulJAg4dRWLVhWzf0H
        /ZkuE1kNlt0IhnqkXvw+veKnl
X-Received: by 2002:a17:902:f60f:b0:151:4f66:55b4 with SMTP id n15-20020a170902f60f00b001514f6655b4mr2309251plg.127.1647654322695;
        Fri, 18 Mar 2022 18:45:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz6kv1/v7LKf9RNEE8Smtok7Dg/0kGtE36CEGe6Q1XOCvrObPFLCmAnA8TsLXh6chusfsFb9A==
X-Received: by 2002:a17:902:f60f:b0:151:4f66:55b4 with SMTP id n15-20020a170902f60f00b001514f6655b4mr2309227plg.127.1647654322331;
        Fri, 18 Mar 2022 18:45:22 -0700 (PDT)
Received: from localhost ([240e:3a1:2e5:800:f995:6136:f760:a3d0])
        by smtp.gmail.com with ESMTPSA id u5-20020a056a00158500b004f745148736sm11647956pfk.179.2022.03.18.18.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 18:45:21 -0700 (PDT)
Date:   Sat, 19 Mar 2022 09:41:23 +0800
From:   Coiby Xu <coxu@redhat.com>
To:     Milan Broz <gmazyland@gmail.com>
Cc:     kexec@lists.infradead.org, Thomas Staudt <tstaudt@de.ibm.com>,
        Kairui Song <ryncsn@gmail.com>, dm-devel@redhat.com,
        Mike Snitzer <snitzer@redhat.com>, Baoquan He <bhe@redhat.com>,
        Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC 0/4] Support kdump with LUKS encryption by reusing LUKS
 master key
Message-ID: <20220319014123.v26w2snihbuyd4fz@Rk>
References: <20220318103423.286410-1-coxu@redhat.com>
 <c857dcf8-024e-ab8a-fd26-295ce2e0ae41@gmail.com>
 <20220318122110.7qjrnrduwytjle3w@Rk>
 <a5b9e66c-235b-51dd-234c-b543dbacc464@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <a5b9e66c-235b-51dd-234c-b543dbacc464@gmail.com>
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2022 at 02:53:37PM +0100, Milan Broz wrote:
>On 18/03/2022 13:21, Coiby Xu wrote:
>...
>>>Why is it not done through keyring and forcing kdump to retain key there
>>>(under the same keyring key name as dm-crypt used)?
>>>Kernel dm-crypt supports this already; LUKS2 uses keyring by default too.
>>>That's all you need, or not? Why do you need to add another "kdump:" thing?
>>>IOW why kdump cannot copy the key to keyring under the name dm-crypt
>>>has in the mapping table and let dm-crypt activate the device almost without
>>>code changes?
>>
>>Sorry, I haven't explained how kdump works. Once the 1st kernel crashes and
>>the system boots into the kdump kernel, the kdump kernel only have direct
>>access to the memory exclusively reserved for it i.e. the kdump kernel
>>loses the direct access to the keyring constructed in the 1st kernel. In
>>theory, the kdump kernel could do some "hacking" to find out the key
>>stored in the memory directly managed by the 1st kernel but I imagine
>>this would be difficult task (imagine I present the memory dump of my
>>computer to you and ask you to rebuild all the relevant kernel data
>>structures and find the key). Besides, it's not reliable to read the
>>memory directly managed by the first kernel for example the memory could
>>be corrupt. So we have to pass the master key from the 1st kernel to the kdump
>>kernel.
>
>OK, then why you cannot store it to the (2nd) kdump kernel keyring?
>(From the kdump area copy, then you do not need to patch anything else
>in dm-crypt than that one line storing the key to the kdump area.)

cryptsetup stores the master key in the thread keyring
(KEY_SPEC_THREAD_KEYRING). I couldn't come up with a easy way to store
the key to the (2nd) kdump kernel keyring. For example, one problem is
how can I know in adance the thread ID of cryptsetup? I imagine
drivers/md/dm-crypt.c needs to support a new type of message in
crypt_message so cryptsetup can tell dm-crypt to store the master key
in the thread keyring as a preparation for opening the device. So one
line change of code isn't sufficient. What's more important is I don't see 
any benefit by doing so I regards storing the key to the kdump kernel
keyring first as an unnecessary step.

>
>A clear approach would be to store the key in the 2nd kernel kdump keyring
>and allow userspace to read it.
>Then cryptsetup can just validate the key (LUKS key digest does not use Argon)
>and activates it without asking for a passphrase.

Thanks for bringing my attention to validating the key! Currently I
simply skip key validation in cryptsetup when implementing the
"--kdump-master-key" option because it requires pass the master key to
the user space. I have a side question, if somehow the master key is
changed and the wrong key is used to get the expanded key, will it lead
to a devastating effect say corrupting the user data on the disk?

>Perhaps this will need some new cryptsetup option (or API call), but I think
>it can be done.
>
>Or, you can actually simulate it with
>  cryptsetup open ... --master-key-file <file>
>where this keyfile contains directly the volume key, not a passphrase.
>The key digest is verified in this case only; no costly PBKDF is needed.
>
>If you have a way to retrieve the kdump stored key to kdump userspace, this
>is perhaps a much simpler solution.
>
>All this is against all countermeasures to not expose encryption key
>directly - but if kdump is debugging environment, just saying...

I respect and appreciate all the efforts done by you and other community
members to increase security margin so the last thing I want to do is to
reverse the security measures. Besides, I believe some users choose to
dump vmcore to an encrypted disk exactly out of security concern. The
only thing this patch set does about master key is to store it in the
memory exclusively reserved for kdump. To be precise, storing the master
key in the memory exclusively reserved for kdump may be different from
what you mean by "exposing encryption key directly". This reserved memory
won't be used by the 1st kernel (which means if we reserve 1GB more for
the kdump kernel, the 1st kernel would have 1GB less kernel to use. And I
would expect strong objection from the user due to a loss of 1GB memory).
Only kexec knows how to store the master key in this exclusively reserved
memory area and but kexec itself doesn't know to retrieve the master key in
the 1st kernel. So the situation is similar to how expanded key is stored.
struct crypto_aes_ctx has the expanded key, but there is no API to retrieve
it. If you still think this line of reasoning doesn't convince you, how
about encrypting the master key before storing the key to the kdump memory?
kexec could calculate the SHA256 digest of loaded kdump kernel and initrd.
We can use this SHA256 digest to get an encryption key and then encrypt
the master key.

>
>Milan
>

-- 
Best regards,
Coiby

