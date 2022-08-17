Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F57C5970F7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 16:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240159AbiHQOZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 10:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240156AbiHQOZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 10:25:39 -0400
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1594861DBE
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 07:25:38 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id k17so6765723wmr.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 07:25:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=R+mRpIZ7Zgu21uwMA0nvMtTfDGIisuZ8eNPyxKRxmQE=;
        b=ZdNkKadhuNVx5KC4HvyViA9VgA3bjeNTo8VTSSX6mW5/bvsQytmqfQtcHGGyBggp9Z
         2Iulkt4pbmNfg3ShTEZvIkVkh1Kz7lBWljrxe2iR6Csm0eVYFweJ7sQXKRDL7wBfPu0A
         T5Y5lCm+cAW4GMlGjTvQZOKS9Dgg8/EQvE9X/SQXlDeAoazoGY7mL9LcrBSvX/SC0Ju2
         i7lF3p3FSIB2Tkgk+78NGmlmymlvdAba3NOPLf1KPTpquIZg5QNLpiSqaV0ensaAwA1e
         Ks3kEGsVELXUTYLlzkyVNg8UqUBT2HRWgfHYviyvxuI8qkqQEqPFVUERM2PHmUOqMRTU
         igOQ==
X-Gm-Message-State: ACgBeo0hd2TUW58KwNMsINA7MYTwgD5XdrbcdX0h7K02l+Tcv206l9Xe
        nDYYhF6dm6AD1b3EQ3TA0AU=
X-Google-Smtp-Source: AA6agR5icZEtlkcXFsc6tMcsi67HXqUlEdQRuDlo+geBQqnwvBpJndjqm2NQJr58kaf3KQFquFDANw==
X-Received: by 2002:a05:600c:3502:b0:3a6:edc:39f8 with SMTP id h2-20020a05600c350200b003a60edc39f8mr2392754wmq.200.1660746336588;
        Wed, 17 Aug 2022 07:25:36 -0700 (PDT)
Received: from [10.100.102.14] (85-250-24-41.bb.netvision.net.il. [85.250.24.41])
        by smtp.gmail.com with ESMTPSA id l20-20020adfa394000000b002250c35826dsm7449729wrb.104.2022.08.17.07.25.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 07:25:35 -0700 (PDT)
Message-ID: <7c5c3e39-650e-c0ae-c9ce-8b23c8c15493@grimberg.me>
Date:   Wed, 17 Aug 2022 17:25:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH] nvmet-tcp: Don't kmap() pages which can't come from
 HIGHMEM
Content-Language: en-US
To:     Keith Busch <kbusch@kernel.org>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>
References: <20220816091808.23236-1-fmdefrancesco@gmail.com>
 <YvvpJbOT9iv6rnm2@kbusch-mbp.dhcp.thefacebook.com>
 <c11e62ae-3439-e3e3-adba-d7f5f951791c@grimberg.me>
 <Yvz4zquwplVKwwXK@kbusch-mbp.dhcp.thefacebook.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <Yvz4zquwplVKwwXK@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>> You should also remove the cmd's 'nr_mapped' field while you're at it,
>>> otherwise you'll hit the WARN in nvmet_tcp_free_cmd_buffers().
>>
>> Not remove nr_mapped because we use it to know the iovec entries, but
>> we can just remove the WARN statement.
> 
> It's only used locally within nvmet_tcp_map_pdu_iovec() after this change, so
> no need to carry it in struct nvmet_tcp_cmd anymore.

You are right, we can kill it.

