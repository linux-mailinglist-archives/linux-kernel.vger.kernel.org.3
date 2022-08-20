Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6688159AEA9
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 16:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346196AbiHTOUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 10:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345296AbiHTOUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 10:20:03 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808F18284F
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 07:19:58 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-11cb3c811d9so6488436fac.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 07:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=uYTyRK/ggppk1qfefOckjXKBF0O296J6JFH4Dt5eYko=;
        b=3ALe+YZ3NolhHC10gPVij5hIQS/axK6YJX07lmNRawIaEvsi/iw5Z2JoFnAhoi1JAU
         dA2ODGBqWYvFY0NO7TzhLi/A/K+nNxZmGcOejI5GUKxvGE49SJqNSGj8gSpu7LKRrCz+
         Lu5dMcEfVvY7NfMUyK7CcFauqqYS/Fa2Vrr7NbPmkpVLzCn8Ca/9t+YKuL4YFIl7xw+W
         CKf2H0HKbvG5qIxYE9kKwGNzvZlyBSVRMvmjDjDfAM6UyjueJgihZJEHo4W+bg9SdLld
         kbIrqqcPUyAHtmiEguCYTG1kv+5uidjvG0/v5DcvYfSrbL67FP3WUORnqzXKWSzFsCw5
         Of8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=uYTyRK/ggppk1qfefOckjXKBF0O296J6JFH4Dt5eYko=;
        b=JsygAEMx1IeQhQuuKMEZpqu80w77xKjzPbDty4ookZ2xbkgbhh4sWDidn1JXM5gJUx
         y5iRzw3sZrjOxMJsMnhj9FgjGX/Cjp3muwxGKWyEig7C7XhCLgoKBueZWQ3msfLHATao
         HoCFP52Cea+pjx5t31+6PqzTPPUKVQ5DcLXYVqXgfm1J6JK71ZOVXxkiSlpaCrV1FlSi
         wZpaIhQDNDw+Qg5afdUdk0ZCre1So/Ec6L53vHayNn3+iFHjsoXJr7Eb/kdmswVIHGDx
         6XFdPI3GI3DSQm6wNbZAb7ii/29jDElOyXPvI57Fwzj1NtKR07n/A2prs9SkssHh9gX6
         9RXA==
X-Gm-Message-State: ACgBeo2Kvtvr/HP4mGW2G1bVkNryEi8UDIt+QZ+jP6LZPIliTfTbu/W4
        4McluYzBB1tbp/h0g/9meBswEKLR6fI5ebe4Q2Yu
X-Google-Smtp-Source: AA6agR52QLPdtjhcKDNfssg95nnqcfijs4du1dcPBXuvnNBCw1vrwolb2DOlfqQoAki939g4m2/nBPAoDkWsSmniqMs=
X-Received: by 2002:a05:6870:a78d:b0:11c:437b:ec70 with SMTP id
 x13-20020a056870a78d00b0011c437bec70mr6285289oao.136.1661005197815; Sat, 20
 Aug 2022 07:19:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220820082606.953886-1-floridsleeves@gmail.com>
In-Reply-To: <20220820082606.953886-1-floridsleeves@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sat, 20 Aug 2022 10:19:47 -0400
Message-ID: <CAHC9VhSXMO7FxKAonxowYBCPjPfhhvuAErju8oU8qPgx62tiVw@mail.gmail.com>
Subject: Re: [PATCH v1] selinux/ss/services.c: check the return value of
 audit_log_start() in security_sid_mls_copy()
To:     lily <floridsleeves@gmail.com>
Cc:     selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        cgzones@googlemail.com, michalorzel.eng@gmail.com,
        xiujianfeng@huawei.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 20, 2022 at 4:26 AM lily <floridsleeves@gmail.com> wrote:
>
> The function audit_log_start() can fail, so its return value should be
> checked against NULL.
>
> Signed-off-by: Li Zhong <floridsleeves@gmail.com>
> ---
>  security/selinux/ss/services.c | 3 +++
>  1 file changed, 3 insertions(+)

audit_log_start() can safely return NULL as the audit_log_*()
functions are designed to handle a NULL audit_buffer.  This is an
expected behavior and not a bug.

-- 
paul-moore.com
