Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC214DD343
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 03:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbiCRCvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 22:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbiCRCvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 22:51:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3D5D71AAA56
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 19:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647571823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TtfpIMh0hjxedFN+Tl6gjaJX+areyDNcJNycJbTZTWE=;
        b=Z7xCSzf97oUHK59B0YZk0oCrZiH2bfs49itWkjBsm2HszzY7En01vA3EATyuMu8MxDhusR
        B5QcvWySXyJ1+riV2Jj2AIFJsuE8k9XFAuhiHs/QiBgtfNvR5XDt+8oUhqoRzWIHJb2KXB
        OH6cWonkeWfpzkArGUdRBVTwCFXPEm0=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-606-LxCYtU_iNqWYcsOnvtM2Yw-1; Thu, 17 Mar 2022 22:50:21 -0400
X-MC-Unique: LxCYtU_iNqWYcsOnvtM2Yw-1
Received: by mail-pj1-f71.google.com with SMTP id iq24-20020a17090afb5800b001c685a314d6so1853180pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 19:50:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TtfpIMh0hjxedFN+Tl6gjaJX+areyDNcJNycJbTZTWE=;
        b=bYbfO8xyD6MjNUdN19J7NMJexPhgMraf5xKykrxRhGG1xYpErSYFbkQJJCrwIczZI2
         h3NzZVU0q3/xM3a2KiXwL7UxISjVjfGhCuzCvancwKPgWi3LEcASIhGJi2oD5IBaJ33m
         PbQFa9mo80aRwWIQQKHYAVso1g2ZW7wPEcf+kX6BAtnxds9R2LR9jHHyk1DQB4j7hqO3
         RZPp+KIMTfM5O0omGtXQkKlj8ZuW1StjdKZ96g3oG5/HoK1/78EQ4m25M1Ai+P94olg7
         SjcVJm9hZUOjjiZRvSFllv77oyuyBKhfF61DSYAbdSrawEeDctdH+jHjXS23Tznw2eMB
         5jaQ==
X-Gm-Message-State: AOAM532CD8Kltn2djJyi4yatEd6QqDMKKwCkjy/MtZFrESj+0xx3223j
        HRCpnDBvEI5bJL8FzZ9y601OGPLqL57NJLmAF4XZLgpiegaqQiYH8z9DXR6lNd+fhaX8XTc+SKo
        9bu6EBivjsqDHkbctD2uU94ph
X-Received: by 2002:a17:90b:33c4:b0:1c6:8598:d4bf with SMTP id lk4-20020a17090b33c400b001c68598d4bfmr6424467pjb.81.1647571820766;
        Thu, 17 Mar 2022 19:50:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzLt3zIH+QYFTliBGLEDR7sfnoegdpTP4CMfMVwJSbXOQs/6+T0WT6xwVyNg/L20iUDcgdmXg==
X-Received: by 2002:a17:90b:33c4:b0:1c6:8598:d4bf with SMTP id lk4-20020a17090b33c400b001c68598d4bfmr6424436pjb.81.1647571820410;
        Thu, 17 Mar 2022 19:50:20 -0700 (PDT)
Received: from localhost ([240e:3a1:2e5:800:f995:6136:f760:a3d0])
        by smtp.gmail.com with ESMTPSA id b13-20020a056a00114d00b004c122b90703sm8097199pfm.27.2022.03.17.19.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 19:50:19 -0700 (PDT)
Date:   Fri, 18 Mar 2022 10:48:03 +0800
From:   Coiby Xu <coxu@redhat.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     Coiby Xu <coiby.xu@gmail.com>, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Dave Young <dyoung@redhat.com>, Will Deacon <will@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH v3 1/3] kexec: clean up
 arch_kexec_kernel_verify_sig
Message-ID: <20220318024803.pkkwgknwur2y75mt@Rk>
References: <20220304020341.85583-1-coiby.xu@gmail.com>
 <20220304020341.85583-2-coiby.xu@gmail.com>
 <YjMtb7u3/sAWG0/7@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YjMtb7u3/sAWG0/7@MiWiFi-R3L-srv>
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 08:45:35PM +0800, Baoquan He wrote:
>On 03/04/22 at 10:03am, Coiby Xu wrote:
>> From: Coiby Xu <coxu@redhat.com>
>>
>> commit 9ec4ecef0af7790551109283ca039a7c52de343c ("kexec_file,x86,
>> powerpc: factor out kexec_file_ops functions" allows implementing
>> the arch-specific implementation of kernel image verification
>> in kexec_file_ops->verify_sig. Currently, there is no arch-specific
>> implementation of arch_kexec_kernel_verify_sig. So clean it up.
>
>This is a nice cleanup, while the log may need to be improved. You
>should run ./scripts/checkpatch.pl on your patch before sending out.
>When we refer to a commit in log, please refer to
>Documentation/process/submitting-patches.rst.

Thanks for the reminder! I've used git pre-commit hook to run 
scripts/checkpatch.pl automatically but obviously this hook doesn't
apply to "git rebase --continue" and currently this no git hook that
for this situation. I'll use the following trick [1] to avoid this
mistake in the future,
  $ git rebase -i HEAD~3 --reschedule-failed-exec --exec "git show | perl ./scripts/checkpatch.pl"

[1] https://stackoverflow.com/a/70568833/1203522


-- 
Best regards,
Coiby

