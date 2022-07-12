Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09E425728B4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 23:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233228AbiGLVmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 17:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbiGLVmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 17:42:32 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1485DCE383;
        Tue, 12 Jul 2022 14:42:30 -0700 (PDT)
Received: from [192.168.192.83] (unknown [50.126.114.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id C8C8540022;
        Tue, 12 Jul 2022 21:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1657662149;
        bh=afz1hSl5MyHGGEAzzWGas8HoPsJwmDkiwiQX8WNJLlY=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=F0ppNf9BJUdwHzBHWnoIjm5rRd+UwbVjWtwYS/vQzY6aB/CcGptB+sm+daW88eH2X
         x7x4Q+3diPwOcQRyrcP16O6hWQKXZJfESeGj2npbDugm4KAqoNxW97qnvjzGp3y43d
         8DL69bpT6FUkTExcz1ME0cEHeZUk2Zt7P6B+6vtmsXgHFHk/5BU3w0v6R2Z1EFAbZj
         pkzCBOu282qqxqbq+r23vqgsgxsoHxBY1PoBhIpL3E56vS4dR+2OCOg53DO0iJjQNK
         3I/sbu4NLmgtZS4vcUTQO4YIEGdkEu8bBaGJ+sRd9N4ayX8SCovDcxTAhVxG1Ogkfc
         i6YLbgYHGeP6A==
Message-ID: <92d0f7cb-f565-38ad-37e8-54e04189f558@canonical.com>
Date:   Tue, 12 Jul 2022 14:42:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v37 00/33] LSM: Module stacking for AppArmor
Content-Language: en-US
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     linux-audit@redhat.com, keescook@chromium.org,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
References: <20220628005611.13106-1-casey.ref@schaufler-ca.com>
 <20220628005611.13106-1-casey@schaufler-ca.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <20220628005611.13106-1-casey@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/27/22 17:55, Casey Schaufler wrote:
> This patchset provides the changes required for
> the AppArmor security module to stack safely with any other.
> There are additional changes required for SELinux and Smack
> to coexist. These are primarily in the networking code and
> will be addressed after these changes are upstream.
> 
> v37: Rebase to 5.19-rc3
>       - Audit changes should be complete, all comments have been
>         addressed.
>       - Address indexing an empty array for the case where no
>         built in security modules require data in struct lsmblob.
>       - Fix a few checkpatch complaints.
> v36: Rebase to 5.19-rc1
>       - Yet another rework of the audit changes. Rearranging how the
>         timestamp is managed allows auxiliary records to be generated
>         correctly with a minimum of fuss.
>       - In the end no LSM interface scaffolding remains. Secids have
>         been replaced with lsmblob structures in all cases, including
>         IMA and NetLabel.

<<snip>>

> https://github.com/cschaufler/lsm-stacking.git#stack-5.19-rc3-v37
> 

hey Casey,

I am not finding v37 in your public github tree, the newest I see is v36
and v36-a both based on 5.19-rc1. Can you make sure v37 is pushed?

thanks
john

