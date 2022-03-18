Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6664DD743
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 10:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234584AbiCRJql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 05:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232891AbiCRJqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 05:46:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ED6962C3DFD
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 02:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647596719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2Sklw5vFJoBHTi2JNfxIgqGkvTxQMGfgRs43b1Vh+LU=;
        b=NY+A8yldC+3G3TtEL5RpcR6rLaHxEeLpElNsf9IOMf9XAJJCWwH6MRTp85e9HFu0YATkLJ
        Zkd/FaDSBppa1b12c0G8AGJT1ofCLrFaD+p30irGO2j3yJuBFxsdIFP77vIGjvsM61WPe2
        xp7QgDqS44Mm9oPKUetdgOxZ8hjt5rc=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-645-DpQrFka7N5Sfpm30Zcf5hg-1; Fri, 18 Mar 2022 05:45:18 -0400
X-MC-Unique: DpQrFka7N5Sfpm30Zcf5hg-1
Received: by mail-pg1-f199.google.com with SMTP id 196-20020a6307cd000000b0038027886594so3138416pgh.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 02:45:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2Sklw5vFJoBHTi2JNfxIgqGkvTxQMGfgRs43b1Vh+LU=;
        b=sZmCFljOfswdN1IsX4IWbB7D+qryXphxKW/uTDZ28rChlNXK2zptACRfEt/1GmvqEH
         7ynPDos66oVxomgPD/z8LJ0UTrnJB5OQVeU6TNXmNq6adpDvJJSF0dZBDiZm/F2JoTh1
         0XFBqhRKnViKo/PLNCYjogsmR4yqJY6cBwEQuUGn8KsTes8TiQeL83+nxMTRT7+wGUxy
         JN2jN2p9H+x7YrZ0d4r9ctSsLI7n/qrWCyEMV+X89qFqEx9gTdbE9uDkoT3AUfOPp34P
         grmAl6tu/bw+o6iOJz+53BnfyZuImNKlsWwANez6aih33aJJ6SSktUavHu90hgzz4cGz
         EjgQ==
X-Gm-Message-State: AOAM532hAAj/vP0/s1cvb+MROsBeX8kPzuHxCsTuDszcr5EPn52QpOEe
        aN9UefQMN9NSCfTWPBhB+TiURkc4RyZkduHZt1TvGfJpVCpdkKH7MUDnnJv5UEYRqF6qGfDfSue
        jIsjyKFqGkegVp1fVMxW81K/T
X-Received: by 2002:a17:90a:d3d3:b0:1bf:2e8d:3175 with SMTP id d19-20020a17090ad3d300b001bf2e8d3175mr10468693pjw.2.1647596716487;
        Fri, 18 Mar 2022 02:45:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJztty7oXoA2AqzOazKbPPcVcNrIQJpdf62DaK3QMw38C5mcbYXwuTbaZ624qRUjJXw2KPOnKg==
X-Received: by 2002:a17:90a:d3d3:b0:1bf:2e8d:3175 with SMTP id d19-20020a17090ad3d300b001bf2e8d3175mr10468669pjw.2.1647596716286;
        Fri, 18 Mar 2022 02:45:16 -0700 (PDT)
Received: from localhost ([240e:3a1:2e5:800:f995:6136:f760:a3d0])
        by smtp.gmail.com with ESMTPSA id c7-20020aa78e07000000b004f6e4d8ccc8sm8813364pfr.163.2022.03.18.02.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 02:45:15 -0700 (PDT)
Date:   Fri, 18 Mar 2022 17:43:20 +0800
From:   Coiby Xu <coxu@redhat.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     Coiby Xu <coiby.xu@gmail.com>, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Dave Young <dyoung@redhat.com>, Will Deacon <will@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH v3 1/3] kexec: clean up
 arch_kexec_kernel_verify_sig
Message-ID: <20220318094320.aoia7yahtmy2hksp@Rk>
References: <20220304020341.85583-1-coiby.xu@gmail.com>
 <20220304020341.85583-2-coiby.xu@gmail.com>
 <YjMtb7u3/sAWG0/7@MiWiFi-R3L-srv>
 <20220318024803.pkkwgknwur2y75mt@Rk>
 <YjP8DTnAZbq646rF@MiWiFi-R3L-srv>
 <20220318071824.yq3idr5eoogvtslb@Rk>
 <YjRIqdAH2nV+DRgW@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YjRIqdAH2nV+DRgW@MiWiFi-R3L-srv>
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2022 at 04:54:01PM +0800, Baoquan He wrote:
[...]
>> Btw, checkpatch.pl seems to requires referring to a specific commit on
>> the same line,
>>
>>     ERROR: Please use git commit description style 'commit <12+ chars of sha1> ("<title line>")' - ie: 'commit 9ec4ecef0af7 ("kexec_file,x86,powerpc: factor out kexec_file_ops functions")'
>>     #6:     commit 9ec4ecef0af7 ("kexec_file,x86, powerpc: factor out
>> kexec_file_ops
>>     functions") allows implementing the arch-specific implementation of kernel
>>     total: 1 errors, 0 warnings, 61 lines checked
>>     NOTE: For some of the reported defects, checkpatch may be able to
>>           mechanically convert to the typical style using --fix or --fix-inplace.
>>     "[PATCH] kexec: clean up arch_kexec_kernel_verify_sig" has style problems, please review.
>>     NOTE: If any of the errors are false positives, please report
>>           them to the maintainer, see CHECKPATCH in MAINTAINERS.
>>
>> Is this a false positive?
>
>No, it's not. Youp probably copied the commit subject and modified it.
>Please copy below two lines into your patch to replace and try again.
>
>commit 9ec4ecef0af7 ("kexec_file,x86,powerpc: factor out kexec_file_ops
>functions")

Yes, you are right. I unintentionally changed the subject. I've sent 
v4 to fix this commit reference issue and other checkpatch.pl warnings.
Thanks!

-- 
Best regards,
Coiby

