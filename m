Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E4250206C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 04:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348664AbiDOC0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 22:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242623AbiDOC0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 22:26:39 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18A544742
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 19:24:12 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 45B5A4C145D;
        Fri, 15 Apr 2022 02:24:12 +0000 (UTC)
Received: from pdx1-sub0-mail-a254.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id B174D4C1409;
        Fri, 15 Apr 2022 02:24:11 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1649989451; a=rsa-sha256;
        cv=none;
        b=M2gdGTaR6PLCXm4rA78eDZ+ciSRRdA+fj3ZfqYcJvxCbL0eqx/nnN9+70a8aSpneIrz9B3
        tz4yBkG0t4NsRpK2DWxm8rlhGRZ0siLTRPtOwYb92of1R9dmTQZdacSBu4RB4syVcOJZ3j
        aFA61/G3ZL81K+sMD56gJkSFVNVCJ9kI1X9Uy3gz9xC6RCG+/se8dYrIQnzbQRffr4M/co
        fKJ/Y1NJCKL/9kENFf4RZTy5IoEdUlB6xzcnSU3XcpigSlnOIy1bNEmFcZkQLcfTYZSTNI
        07/8pj2cABiMXjEkk//Ziw3mvmN/5+Odnqa8HQrQ8Ka6JgjOEFoSEM51UjUG4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1649989451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=WDxVmIvVJUZchgfjAUFTOpowtqWYYqLD337oFjpWn9o=;
        b=Xl5FU/afovaphrepAJAjBzNGGY/ek4M1N09n5CjfL1t4YSwEG72FRvOku539NyrP09k9wf
        PKAftQXmJhEPHU7+uxCxM7jcIVNOzqe9OdycdKlNyELEoz/IJA8Qpymy/1JfatxOBvFrX0
        gl8dFdORaSR6EPM134GwpfvuqCwbYKEMoFcmus9rgJrkaxQL9m+d2bmaPCnqMoAb/MPzNz
        s+SwEQ2QVRSw4MyKFVAkFBDOtd21jcrTBypoRXvxH5IrUHBPGHr11wa06J4GPtrzFyh8gK
        lyDSOd91BMSwthDKCkDvCvLxx7KiARyWFsRFHgS4tHPmp2F+31+1adyxV1/9XA==
ARC-Authentication-Results: i=1;
        rspamd-5f678fb567-475d5;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from pdx1-sub0-mail-a254.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.112.55.197 (trex/6.7.1);
        Fri, 15 Apr 2022 02:24:12 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Blushing-Callous: 33acd3540a5772ff_1649989452103_1605119094
X-MC-Loop-Signature: 1649989452102:2625742792
X-MC-Ingress-Time: 1649989452102
Received: from offworld (unknown [104.36.29.107])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a254.dreamhost.com (Postfix) with ESMTPSA id 4KfgBL5vSxz21;
        Thu, 14 Apr 2022 19:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1649989451;
        bh=WDxVmIvVJUZchgfjAUFTOpowtqWYYqLD337oFjpWn9o=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=fa8rDh/h9UJvdUqAdGnWpRBfghjU50ZZRtKc5IGv0g/Mz0twFIGOykZZ0UDV/WMS5
         1DWK1KoNj+p8PoFxeF7J+JgiGJKjOPQR7eF+DZzxWqn6pHEvRAxnFMLj7S4QWT1n+d
         teywyB14NOeHm4unkkG6uVjqNbkQYidzzOzdOOyYMXE7x0TnnVWXpRMTNYMwCnOdzB
         vrVaL9yWG9PV5jiGgTpm3RUJXy4wSZ/lPPs9yWBfGs+Lu0NXjgfBHHl2DyMBIkCQvl
         h7/9cuUPTZTJasX8f7Qjc14GRLFQ/HJ/jE8qeHp1RQkspXm/IgZifZnpEuTZdTnqEr
         YlkKtZlnHvf/g==
Date:   Thu, 14 Apr 2022 19:24:08 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Peng Liu <liupeng256@huawei.com>
Cc:     mike.kravetz@oracle.com, david@redhat.com,
        akpm@linux-foundation.org, yaozhenguo1@gmail.com,
        baolin.wang@linux.alibaba.com, songmuchun@bytedance.com,
        liuyuntao10@huawei.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] hugetlb: Fix return value of __setup handlers
Message-ID: <20220415022408.6e6nqzvycf52n5yh@offworld>
Mail-Followup-To: Peng Liu <liupeng256@huawei.com>, mike.kravetz@oracle.com,
        david@redhat.com, akpm@linux-foundation.org, yaozhenguo1@gmail.com,
        baolin.wang@linux.alibaba.com, songmuchun@bytedance.com,
        liuyuntao10@huawei.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220413032915.251254-1-liupeng256@huawei.com>
 <20220413032915.251254-4-liupeng256@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220413032915.251254-4-liupeng256@huawei.com>
User-Agent: NeoMutt/20201120
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_BL_SPAMCOP_NET,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Apr 2022, Peng Liu wrote:

>When __setup() return '0', using invalid option values causes the
>entire kernel boot option string to be reported as Unknown. Hugetlb
>calls __setup() and will return '0' when set invalid parameter
>string.
>
>The following phenomenon is observed:
> cmdline:
>  hugepagesz=1Y hugepages=1
> dmesg:
>  HugeTLB: unsupported hugepagesz=1Y
>  HugeTLB: hugepages=1 does not follow a valid hugepagesz, ignoring
>  Unknown kernel command line parameters "hugepagesz=1Y hugepages=1"
>
>Since hugetlb will print warning/error information before return for
>invalid parameter string, just use return '1' to avoid print again.
>
>Signed-off-by: Peng Liu <liupeng256@huawei.com>
>Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>Reviewed-by: Muchun Song <songmuchun@bytedance.com>
>Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
