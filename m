Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF9E514A86
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 15:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359801AbiD2Ne3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 09:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236958AbiD2Ne0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 09:34:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 10D9664BEA
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 06:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651239066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uzyEZt8KLy4l4cRkkwrFwA7bR7MOk2JELiNiEXVGvM4=;
        b=RRc8PDhNH+9KPNexv1UT3lYvJBx9ySYsSZ0kLfwrs2ulFNhmni3e0rbePQS3cIY1jXkKgz
        AYxwbW8uXvpjUHt6qxKR5Bk68TN0HBl6t94+J2IUrAC4lw1erD9CjFDcO5+mpQ9PijymcX
        r2Z4/qbCabQ9tiWCf41GaPQPocAWAU4=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-554-VDaV6LWdOd-n9VMCQyt0GA-1; Fri, 29 Apr 2022 09:31:05 -0400
X-MC-Unique: VDaV6LWdOd-n9VMCQyt0GA-1
Received: by mail-io1-f72.google.com with SMTP id g3-20020a056602150300b0065a4403ce00so63070iow.8
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 06:31:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uzyEZt8KLy4l4cRkkwrFwA7bR7MOk2JELiNiEXVGvM4=;
        b=Eare/CX4UxIQwnjOzhBqhr8EGeMpQHvofh0w5uoZHinMDQIBFI1RKjHmfgelCXIS8s
         WwTUacfOUWVHA2P5pkitnUo7Y+1SAH7P3frb0YBSiOk3fCkOQYF7PLXcijcDvYlCcOmx
         2oEgjmnTrzx513+laG5aO/H71S6DDeWEJbowYZ+3LaB69OfhSPOHOPb/DEF9s6lFSTMi
         e5m+ihw0aSUiNesxoy8nIVtxGkl8Le/Fz2fG/fHSjtZc0X+EBsy01LNomibCbiXnV3v1
         sjLxHi1UQx1IY8rs76Bneh6cMVlYCz+8KZJ2tp3gFx9bonlDNNjgHPSjuHYgbe0gfQ7K
         oamQ==
X-Gm-Message-State: AOAM531/ZsbI8A/2PhhWIAmi7YxycJ6XI4RFM8Yw2fp0k4lLO2XiVyMQ
        um+xrs4i5qT1FiIi4r2wKEUUu2soilCdUchYLIap3EL4PUqxCNaJ1ViriZwPYoYdzQMwqBmTqhs
        XEgx43FTAo2myYW7pa2H24k4U
X-Received: by 2002:a92:d4cf:0:b0:2cd:6e3e:9d8c with SMTP id o15-20020a92d4cf000000b002cd6e3e9d8cmr15169594ilm.242.1651239064802;
        Fri, 29 Apr 2022 06:31:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzvWciCsxmSARZwePCUerHSH90PTPv1hf5YAVnT3tc4CZKPr3PYxBPSthRKG02yYlnP3S+chQ==
X-Received: by 2002:a92:d4cf:0:b0:2cd:6e3e:9d8c with SMTP id o15-20020a92d4cf000000b002cd6e3e9d8cmr15169587ilm.242.1651239064574;
        Fri, 29 Apr 2022 06:31:04 -0700 (PDT)
Received: from xz-m1.local (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id d73-20020a6bcd4c000000b006572627ee64sm1026544iog.27.2022.04.29.06.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 06:31:04 -0700 (PDT)
Date:   Fri, 29 Apr 2022 09:31:03 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Hongchen Zhang <zhanghongchen@loongson.cn>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/swapops: make is_pmd_migration_entry more strict
Message-ID: <Ymvol9Ffa5/fh7Jw@xz-m1.local>
References: <1651131333-6386-1-git-send-email-zhanghongchen@loongson.cn>
 <YmrfynZf7bU0Uoys@xz-m1.local>
 <752b59ff-3283-2360-5f16-d75d04c25a8b@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <752b59ff-3283-2360-5f16-d75d04c25a8b@loongson.cn>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 10:23:08AM +0800, Hongchen Zhang wrote:
> Hello Peter,

Hi, Hongchen,

>   (1) the pmd passed to __split_huge_pmd_locked may be a none pmd,so it may
> be wrongly treated as a pmd migration entry.

With !ARCH_ENABLE_THP_MIGRATION is_pmd_migration_entry() returns 0
constantly.

>   (2) we are preparing to support thp migration on MIPS.

Makes sense (to not have Fixes then).  It'll be great if the objective of
the patch will be mentioned in the future.

Thanks for answering!

-- 
Peter Xu

