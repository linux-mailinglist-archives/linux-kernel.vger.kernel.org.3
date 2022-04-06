Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 970C44F6C0D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 23:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbiDFVEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 17:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235596AbiDFVCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 17:02:48 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5BF22B04FE;
        Wed,  6 Apr 2022 12:32:00 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id c190-20020a1c35c7000000b0038e37907b5bso4311967wma.0;
        Wed, 06 Apr 2022 12:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=22nVgDnhtccIupvM0x5/4rqb76OFFE0bU+eSwV0YloA=;
        b=Ws+wv4BvL4RvJ/o1odt3m5zrbyw6jbiG0A5RmYks39xXpBLJgRUf02cPUT51N9ixU5
         0d/NCyZIZVEm6cF4KHn6UC18Nt9jcGdZEa0ct3qDGMs9VbfmZCeDpi1CYwWfE/jIodPh
         LXLlqviem5yjqy12TYQjivKyN2gMfGy5vUo9B8nEAvebKt0cWqB7VvGPQkW8SX0epOsa
         V3QywkM4pT+GJLwGfDb81vl2i2U4qM1iCdLpFS9ORFGElH5sRGGAVXiPOSgTN+Z7i+eo
         5CYfPsSmx/0owLldFNyrWtaapg3mh5kSyKZ+5W+ORknzvErnI2RDkfbib0UnebPQaSge
         D1lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=22nVgDnhtccIupvM0x5/4rqb76OFFE0bU+eSwV0YloA=;
        b=2Lgu9FWJQ47SIfcsSHDU9bKuowlDbkAbkHq1AMYCdRYrslmiYw2gqC18fcsypEvuMc
         vUocXXjQI3poEU9hheFDfrb3t4R8SBdYkNJa/fDwBbJ0zECJMGpJKhTVOCNlkE4d4K84
         RQeWOPjQPdFatRrSZSY7H2kYVoYM1IKL2QU4IPeASCoC6SaQGrC0eKTK3muqepgNFqiY
         fwuPKhs2zqmVOXsfusPk4hI/HdgyhPPVFgWK9+KTwqcNibT/aJJ2vQfhaeA4o8+xR1iH
         WMD7WLn+jIsy7nedb7dZJlIItQeEWQoja8ofNTf7V2oLNKq6vo9Y/4GQItUsvnmEx1XH
         QW9g==
X-Gm-Message-State: AOAM530WDQPSnxanspFloTj1NlAfUSuF/UCyQqUfKGygKKZ1xuxwSTM6
        bK+facOqGcmSQu316IGc9pN7nXiRmxVEcgsQ
X-Google-Smtp-Source: ABdhPJyBmrrAm82HJc+z0cF2XysdMgHMh93ukTTkLTYplkmxiyrYpI6TIwRB+tNxA3Q2T51TxXXELQ==
X-Received: by 2002:a05:600c:358f:b0:38c:c046:cb05 with SMTP id p15-20020a05600c358f00b0038cc046cb05mr8949050wmq.76.1649273519445;
        Wed, 06 Apr 2022 12:31:59 -0700 (PDT)
Received: from [192.168.0.160] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id z5-20020a05600c0a0500b0037bb8df81a2sm6647827wmp.13.2022.04.06.12.31.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 12:31:58 -0700 (PDT)
Message-ID: <5e3946e1-f4bb-e3f8-11e9-be26589972b6@gmail.com>
Date:   Wed, 6 Apr 2022 21:31:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [Bug 215813] syscall(SYS_vfork) causes execve() to return 0.
 (was: vfork(2) behavior not consistent with fork(2))
Content-Language: en-US
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?0JrQvtGA0LXQvdCx0LXRgNCzINCc0LDRgNC6?= 
        <socketpair@gmail.com>, Andrei Vagin <avagin@openvz.org>,
        Dmitry Safonov <dima@arista.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>, Serge Hallyn <serge@hallyn.com>,
        linux-api@vger.kernel.org, bugzilla-daemon@kernel.org
References: <bug-215769-216477@https.bugzilla.kernel.org/>
 <bug-215769-216477-to2O9X1Knw@https.bugzilla.kernel.org/>
 <4fb02f5f-60f9-42af-ddd5-fe5af877231f@gmail.com>
 <20220404080519.pi6izyuop3mmdg2g@wittgenstein>
 <ae2cbf67-aace-bc40-418e-7b41873f814a@gmail.com>
 <20220406084613.3srklyt27qxcmrcx@wittgenstein>
 <f21a06dc-1e2a-87cd-59dc-e8d5245b0a50@gmail.com>
 <87k0c2qagv.fsf@oldenburg.str.redhat.com>
From:   Alejandro Colomar <alx.manpages@gmail.com>
In-Reply-To: <87k0c2qagv.fsf@oldenburg.str.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

On 4/6/22 21:26, Florian Weimer wrote:
> It's not clear if this is valid.  The syscall function in glibc does not
> protect the on-stack return address against overwriting, so it can't be
> used to call SYS_vfork on x86.
> 
> Can you reproduce this with a true inline syscall, or the glibc vfork
> function (which protects the return address)?

If you tell me how I can call a syscall without the libc wrapper or 
syscall(2), sure, I can try :)

If syscall(2) can't be used for certain syscalls, maybe we should 
document that.

Thanks,

Alex
