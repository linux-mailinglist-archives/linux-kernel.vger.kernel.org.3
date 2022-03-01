Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC79D4C82D8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 06:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbiCAFIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 00:08:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiCAFIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 00:08:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7EF5B3BBDB
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 21:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646111275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vlgiMOTcMFuWjlU/kYz9NUh93Lw07HNBV3j58qzJq4U=;
        b=c49YtD1CMm/pXKgNg2G7SN5lx5I+xG9ggWA2EpXO7BKAexOVUO17CBrZIDwMoYLdc26sAG
        Z0yth7rmWQI60+IDnTp3Z5trUQEaPq7mj5UGagaVFyAFKs+y24qRsktiqYP8RUw8tmE8u8
        8t5LDpomlS53BCntXuws6E6/OsMhBlo=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-605-paEGeJ7aM8CnEvTTa4vy_Q-1; Tue, 01 Mar 2022 00:07:52 -0500
X-MC-Unique: paEGeJ7aM8CnEvTTa4vy_Q-1
Received: by mail-pf1-f197.google.com with SMTP id x27-20020aa79a5b000000b004f3f7c2981eso4339601pfj.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 21:07:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vlgiMOTcMFuWjlU/kYz9NUh93Lw07HNBV3j58qzJq4U=;
        b=Su3RIvFKs8atjUUYA6Cuo3wrdQEuZjpcp4jpADl0BAegta4ALnKr6FD0MrkR6zXI3l
         iqZKi1TIJVKrZ7lsmiooZzkbrIsgqwatM6sN0F6ezKfyMN4dfZ/gcXNFtrTJrDE9/I4n
         kWSSNjIQh7zOBCAfmZYv2NvnyyAP6ycGo3BViX6O2PTCfjsCOEGmi290OhqVwoICeZXn
         T/SveaBIY1755Mp7RQRe4OqfjKRfG3L4e2HPxKUnJqCJR1roPb7d1cptS86rRJdr9Flw
         ndsk9X3HhMkXG0OED/8NGB8pGZg/pAmxdG4qY8c8GfLHPei4jDnqkfTJKMgNkw36Cip0
         OORA==
X-Gm-Message-State: AOAM533irStDwhnXWNhGKs9IhWg2yC6rEqlEQk0U+e9Bsnfesmh99okE
        lubi8RLFfQUge/p97CrbYhR7mg59G1qQozXSy6o2EGcOy9FO+CKT55ctq6jsy0FrARJEliNsVfP
        ZN4rJGhWQ8aFkmOQIKjQ8zhZv
X-Received: by 2002:a17:90a:fa95:b0:1bc:509f:c668 with SMTP id cu21-20020a17090afa9500b001bc509fc668mr20178132pjb.189.1646111271502;
        Mon, 28 Feb 2022 21:07:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwpWy4HUgxZrmcVNuxA49DZr6RGtDz1nFMnVlTkwtXe5piwCyDrG+ElImiz3DW22yqWJyL/vA==
X-Received: by 2002:a17:90a:fa95:b0:1bc:509f:c668 with SMTP id cu21-20020a17090afa9500b001bc509fc668mr20178109pjb.189.1646111271251;
        Mon, 28 Feb 2022 21:07:51 -0800 (PST)
Received: from xz-m1.local ([94.177.118.144])
        by smtp.gmail.com with ESMTPSA id a16-20020a056a000c9000b004f0f8babedfsm15379890pfv.29.2022.02.28.21.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 21:07:50 -0800 (PST)
Date:   Tue, 1 Mar 2022 13:07:42 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Yun Zhou <yun.zhou@windriver.com>
Cc:     akpm@linux-foundation.org, corbet@lwn.net,
        tiberiu.georgescu@nutanix.com, florian.schmidt@nutanix.com,
        ivan.teterevkov@nutanix.com, sj@kernel.org, shy828301@gmail.com,
        david@redhat.com, axelrasmussen@google.com, linmiaohe@huawei.com,
        aarcange@redhat.com, ccross@google.com, apopple@nvidia.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [v2][PATCH] proc: fix documentation and description of pagemap
Message-ID: <Yh2qHgA+689dq+5i@xz-m1.local>
References: <20220301044538.3042713-1-yun.zhou@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220301044538.3042713-1-yun.zhou@windriver.com>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2022 at 12:45:38PM +0800, Yun Zhou wrote:
> Since bit 57 was exported for uffd-wp write-protected(commit fb8e37f35a2f),
> fixing it can reduce some unnecessary confusion.
> 
> Signed-off-by: Yun Zhou <yun.zhou@windriver.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks,

-- 
Peter Xu

