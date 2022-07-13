Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56620573007
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 10:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234646AbiGMIEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 04:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235013AbiGMIEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 04:04:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 64293E1903
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 01:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657699473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NOytE1OpwEr9XiR8fNK3GgWZvLZYvbznSGDQ7mcwWyY=;
        b=ZyCzKbGxr3G5ca/GnnTZrOTvODa6JOD7A/KAJpqZskJVjjJt9X7YDGHFs8H5eoxCrUod5T
        HgDCkoMxusiqQFM1u78ZWc7M0S1hy1X5V6oQ//A9n0Ae59PqR2JCDdr603RccxN3Df7kog
        a0QIj+ud5YOebFoHwar38KT6XAKu5CQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-141-qGwnLI4zPXClNZnknNxj3A-1; Wed, 13 Jul 2022 04:04:32 -0400
X-MC-Unique: qGwnLI4zPXClNZnknNxj3A-1
Received: by mail-wr1-f70.google.com with SMTP id o1-20020adfba01000000b0021b90bd28d2so1868808wrg.14
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 01:04:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NOytE1OpwEr9XiR8fNK3GgWZvLZYvbznSGDQ7mcwWyY=;
        b=X2RHhq41j5l3zlZwT4sm9PgVmMj2qvmpXya4Hn74PppTiiGjlmhBkMNWKx8vPYVKyn
         bdhg3ZHkCdWiLu7lnAvFLQvahmA/WOX5Ft6eGZknQeVUaC4lImeIOfJbZ32CWHOnzEGT
         vW5JhkwlDRzAWLKRpAMS3a7e7g+EKVLBhnJ4LmUAuAIHCwg0N0hzv0Jhza7Nat1EJyjO
         +UTL8wIfJnm/QE6Jiv6XgGjggWvtsBIgM1FnHAdE4VjVhSCRfjydy7FC1HPYNavSTPSy
         6VKjX+O3cPE6q6JSBlG6MVFZsTaq2p7SqV90E8Kcb/ZdvrNUgS3gcxwLBwRTJi0w62Bl
         GEjQ==
X-Gm-Message-State: AJIora+CReaS0HrnKJi4maoGciJDqFoLirWrQqTfcKwjGdcPfwl2tyP1
        sQdL+KNfv/9IvAF77mhgSQUG7k40lfYkapD049qehePH2v8frkzYKxsNqIH0o3B5Mku0AKJXGcv
        jbvgxmB6KPp0vg8839OFOaSY=
X-Received: by 2002:a5d:6a09:0:b0:21d:7a73:c48a with SMTP id m9-20020a5d6a09000000b0021d7a73c48amr1905398wru.366.1657699470990;
        Wed, 13 Jul 2022 01:04:30 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vqbSTaA6ud72cVb/lQc2F1Aucex9l4ksWc+z8bOYyYLxbP+MGfqfsA5Iy9lPmmsNnjexlwhw==
X-Received: by 2002:a5d:6a09:0:b0:21d:7a73:c48a with SMTP id m9-20020a5d6a09000000b0021d7a73c48amr1905389wru.366.1657699470793;
        Wed, 13 Jul 2022 01:04:30 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id q13-20020adff94d000000b0020e6ce4dabdsm10156872wrr.103.2022.07.13.01.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 01:04:29 -0700 (PDT)
Date:   Wed, 13 Jul 2022 09:04:29 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] module: Move module's Kconfig items in kernel/module/
Message-ID: <20220713080429.7r2xcpumnynhnyhe@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <fdc6016e2414a26f17a17024d287087627052ea6.1657605146.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fdc6016e2414a26f17a17024d287087627052ea6.1657605146.git.christophe.leroy@csgroup.eu>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2022-07-12 07:52 +0200, Christophe Leroy wrote:
> In init/Kconfig, the part dedicated to modules is quite large.
> 
> Move it into a dedicated Kconfig in kernel/module/
> 
> MODULES_TREE_LOOKUP was outside of the 'if MODULES', but as it is
> only used when MODULES are set, move it in with everything else to
> avoid confusion.
> 
> MODULE_SIG_FORMAT is left in init/Kconfig because this configuration
> item is not used in kernel/modules/ but in kernel/ and can be
> selected independently from CONFIG_MODULES. It is for instance
> selected from security/integrity/ima/Kconfig.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  init/Kconfig          | 293 +-----------------------------------------
>  kernel/module/Kconfig | 293 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 294 insertions(+), 292 deletions(-)
>  create mode 100644 kernel/module/Kconfig

Thanks Christophe!

Reviewed-by: Aaron Tomlin <atomlin@redhat.com>

-- 
Aaron Tomlin

