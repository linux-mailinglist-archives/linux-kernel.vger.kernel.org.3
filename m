Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8194F8FC7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 09:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbiDHHt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 03:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiDHHt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 03:49:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7316865E8
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 00:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649404042;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g9nCNxmKb6VL/bN0CRtBOBvo2QBXMAIr2GAVqDlq1GI=;
        b=Sh6cd9vscKhn0fr0FSPoz7X7Iy4TK41fkpDZ0Jsfi6XZhY9Z+SOclU/qSj0SVZwiYbflsJ
        rAjdmlIiyXfddBDJEfgFSuu2/ZOZtEFyD8ywf7J6RjonrB/ygydwEFNDgGxSqiL+NOjI1G
        vsT87zPYFVHQmegLZmwgvKgndiuCLs4=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-606-9I08KkKXPtSEGKqS4M2WtA-1; Fri, 08 Apr 2022 03:47:21 -0400
X-MC-Unique: 9I08KkKXPtSEGKqS4M2WtA-1
Received: by mail-pj1-f72.google.com with SMTP id v9-20020a17090a7c0900b001cb45f88cdcso505257pjf.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 00:47:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g9nCNxmKb6VL/bN0CRtBOBvo2QBXMAIr2GAVqDlq1GI=;
        b=nJ5lgj9IazA0umQt2OFHCaXB2fK4dnwsTItFB6QSqkoI7MJdBOsNDS00UNUnxFeA2T
         /gkUeoQ2dynJroOmrT3UbbX3R9XwfCPxXJhthY0ifcBXywyumrPEeDNFQBwSrc5A89+2
         OXjmkOmoepDg+UILRNT72dihJVFfBVKW8ouaVJRNc30wfmgcrLVEFKj5r5FRuBjzIZjN
         jTXgGUiS+WsclUP4yeZFA4cEF12lFfb9zJcEKiy+mWThdNGu1aYg4YLJ1aKY7nal2KsS
         tCx0q2cYIcNpTNvIwVn/5Qvce8UYRx58Q4Zg+KWF30A/R6HMROq3HbGCxsAgmeFC6Agn
         eO6Q==
X-Gm-Message-State: AOAM533iq4KqelZHCeHZwchdLFySPyrAuSWGHjO4upU2MAm2Jo1xusUY
        46o9xjTiihDWBHCNXkgkiiIE8XM5w8UqNcKiHJQHCYxQAqjuCJ4YLtKBpdi1hO1dSbbigBUaKVg
        HcjInczTnmvD/wZUXb/htB4Lp
X-Received: by 2002:a17:903:124a:b0:154:c7a4:9375 with SMTP id u10-20020a170903124a00b00154c7a49375mr17953386plh.0.1649404039947;
        Fri, 08 Apr 2022 00:47:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxsJjxqFSErmPWDmi5nwu8F53ijnirAHxNY2giI2+zUq/FPsFy4myWA73fqbdFtNPDdOCtDUw==
X-Received: by 2002:a17:903:124a:b0:154:c7a4:9375 with SMTP id u10-20020a170903124a00b00154c7a49375mr17953360plh.0.1649404039614;
        Fri, 08 Apr 2022 00:47:19 -0700 (PDT)
Received: from localhost ([240e:3a1:31c:360:52fc:c968:cb41:efbc])
        by smtp.gmail.com with ESMTPSA id x38-20020a056a0018a600b004fafd05ac3fsm25584490pfh.37.2022.04.08.00.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 00:47:19 -0700 (PDT)
Date:   Fri, 8 Apr 2022 15:47:04 +0800
From:   Coiby Xu <coxu@redhat.com>
To:     Michal Suchanek <msuchanek@suse.de>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        "Lee, Chun-Yi" <jlee@suse.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Philipp Rudo <prudo@redhat.com>, Baoquan He <bhe@redhat.com>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        James Morse <james.morse@arm.com>,
        Dave Young <dyoung@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Kairui Song <kasong@redhat.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH 0/4] Unifrom keyring support across architectures and
 functions
Message-ID: <20220408074704.wkyyv2qnx66iinzo@Rk>
References: <cover.1644953683.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <cover.1644953683.git.msuchanek@suse.de>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

As mentioned by Baoquan, I have a patch set "[PATCH v5 0/3] use more
system keyrings to verify arm64 kdump kernel image signature" [1]. The
differences between your patch set and mine are as follows, 
  - my patch set only adds support for arm64 while yours also extends to
    s390
  - I made the code for verifying signed kernel image as PE file in x86
    public so arm64 can reuse the code as well which seems to be better
    approach
  - I also cleaned up clean up arch_kexec_kernel_verify_sig

Would you mind if I integrate your first 3 patches with mine as follows
  - for arm64, I'll use my version
  - for s390, I'll use your version

For your last patch which allows to use of platform keyring for
signature verification of kernel module, I'll leave it to yourself. How
do you think about it?


[1] https://lore.kernel.org/all/20220401013118.348084-1-coxu@redhat.com/

On Tue, Feb 15, 2022 at 08:39:37PM +0100, Michal Suchanek wrote:
>While testing KEXEC_SIG on powerpc I noticed discrepancy in support for
>different keyrings across architectures and between KEXEC_SIG and
>MODULE_SIG. Fix this by enabling suport for the missing keyrings.
>
>The latter two patches obviously conflict with the ongoing module code
>cleanup. If they turn out desirable I will add them to the other series
>dealing with KEXEC_SIG.
>
>The arm patches can be merged independently.
>
>Thanks
>
>Michal
>
>Michal Suchanek (4):
>  Fix arm64 kexec forbidding kernels signed with keys in the secondary
>    keyring to boot
>  kexec, KEYS, arm64: Make use of platform keyring for signature
>    verification
>  kexec, KEYS, s390: Make use of built-in and secondary keyring for
>    signature verification
>  module, KEYS: Make use of platform keyring for signature verification
>
> arch/arm64/kernel/kexec_image.c       | 13 +++++++++++--
> arch/s390/kernel/machine_kexec_file.c | 18 +++++++++++++-----
> kernel/module_signing.c               | 14 ++++++++++----
> 3 files changed, 34 insertions(+), 11 deletions(-)
>
>-- 
>2.31.1
>

-- 
Best regards,
Coiby

