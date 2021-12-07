Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 499CF46C6AC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 22:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241883AbhLGV2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 16:28:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237303AbhLGV23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 16:28:29 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D741C061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 13:24:58 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id g19so579505pfb.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 13:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jRVyeuIh1LxtzkYS1LgM983Dmj/tho/LqeLDaBBAdCA=;
        b=nw4tUIWMBU0ZfijX4DiaPNSybi8bfq/h9jjeCpKcbJrXFHvVOS2UCW888tnIagK3sg
         SFx2tv++JgamqZ4ibhYbypQM1twAP0V7h7M/r4Zd/KKyViljM24qpqdnIIpugdDF1AtO
         6/EFnXi22NJAveaezAG2XAEdSxQ//7ZTtAEWWXCSwvD1yto0JLpXLVnrXcXdB8HLb8xV
         5ArWiklp0+9NBEBBYsio380JHngx8EQ9tYta+lwXRX4wyOjPW+d7TXWS0aKxe4h7AHFM
         qQMRwJgM3NhtWPg3NH+N2iE7c0Al2c536OxU2UtszIZNlkpXqhO9dDcS9BBxgzCrI88U
         tazw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jRVyeuIh1LxtzkYS1LgM983Dmj/tho/LqeLDaBBAdCA=;
        b=P+HCKhmphBVDpN+pfJ8YuX+oE+LfomIx3OJTdbZmJMTDOHmDNPPTysR+TikP2Yb2oZ
         wMbangMMWgFTpdYIWI4+Gq/VBQkrIQojOTYhwz476Ulj9W6At/YBh9zTcj6hbjXBOBuG
         SzqpV1RXsa8pZavDjWBBxlw/XJVVYkHrXIjnvr8lLFZwNI77+tZuDMDbuIERx95ajdE3
         EbVrJRRfCiEbTtLFgX2/Q4wuJRvOm0fF/Vp6Bx+j/pJSWlOA9XeRBDn3SASLeK+ssA3d
         P92yKy8QkoLOPb0vrE6bCoLKiiPBbnA2az7LD+phnbJfTLez4Iw0EosPHHx6EmGRtfqi
         qI9Q==
X-Gm-Message-State: AOAM530WCn/i9DwzRjpNoRFbiwzbaIcxDBZY68LRe2kCKw3ZMcR828tm
        ElkDzo3Q90b7FCEHnzuTYJM1ARNfWCBu5w==
X-Google-Smtp-Source: ABdhPJz5yHjRT7WEtoUHsulRAwpB6pdUSVvXWyPfKXTGjX4l1AAn8R6DCGg8B/YWQwEZZmfh0QQc5A==
X-Received: by 2002:a62:7e4c:0:b0:4a2:678e:8793 with SMTP id z73-20020a627e4c000000b004a2678e8793mr1577406pfc.75.1638912297949;
        Tue, 07 Dec 2021 13:24:57 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id n31sm621096pfv.181.2021.12.07.13.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 13:24:57 -0800 (PST)
Date:   Tue, 7 Dec 2021 21:24:54 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Peter Gonda <pgonda@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Marc Orr <marcorr@google.com>
Subject: Re: [PATCH] selftests: sev_migrate_tests: Fix sev_ioctl()
Message-ID: <Ya/RJiTOQjJ+fj73@google.com>
References: <20211207201034.1392660-1-pgonda@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207201034.1392660-1-pgonda@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021, Peter Gonda wrote:
> TEST_ASSERT in SEV ioctl was allowing errors because it checked return
> value was good OR the FW error code was OK. This TEST_ASSERT should
> require both (aka. AND) values are OK. Removes the LAUNCH_START from the
> mirror VM because this call correctly fails because mirror VMs cannot
> call this command.

This probably should be two separate patches.  First remove the bogus LAUNCH_START
call, then fix the assert.
 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Sean Christopherson <seanjc@google.com>
> Cc: Marc Orr <marcorr@google.com>
> Signed-off-by: Peter Gonda <pgonda@google.com>
> ---
>  tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c b/tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c
> index 29b18d565cf4..8e1b1e737cb1 100644
> --- a/tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c
> +++ b/tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c
> @@ -31,7 +31,7 @@ static void sev_ioctl(int vm_fd, int cmd_id, void *data)
>  	int ret;
>  
>  	ret = ioctl(vm_fd, KVM_MEMORY_ENCRYPT_OP, &cmd);
> -	TEST_ASSERT((ret == 0 || cmd.error == SEV_RET_SUCCESS),
> +	TEST_ASSERT(ret == 0 && cmd.error == SEV_RET_SUCCESS,
>  		    "%d failed: return code: %d, errno: %d, fw error: %d",
>  		    cmd_id, ret, errno, cmd.error);

Hmm, reading cmd.error could also consume uninitialized data, e.g. if the ioctl()
fails before getting into the PSP command, the error message will dump garbage.

And theoretically this could get a false negative if the test stack happens to have
'0' for cmd.error and KVM neglects to fill cmd.error when the ioctl() succeeds.

So in additional to fixing the assert itself, I vote we also do:

diff --git a/tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c b/tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c
index 29b18d565cf4..50132e165a8d 100644
--- a/tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c
+++ b/tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c
@@ -26,6 +26,7 @@ static void sev_ioctl(int vm_fd, int cmd_id, void *data)
        struct kvm_sev_cmd cmd = {
                .id = cmd_id,
                .data = (uint64_t)data,
+               .error = -1u,
                .sev_fd = open_sev_dev_path_or_exit(),
        };
        int ret;
