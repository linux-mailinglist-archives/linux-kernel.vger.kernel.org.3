Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14EAE4AD43F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 10:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352741AbiBHJBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 04:01:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352732AbiBHJBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 04:01:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 00D6CC03FEC0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 01:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644310900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=teClNrONiYXVnmCwa1h1q0ixCqq3xRiV2+FUHXxwnkg=;
        b=XJr+XUCnlX3t14kvQdmGWTGKPMg/sEMcoLKkpkChaA+qcpIg4EvAtjZlqqayhSIgmwIWjy
        rry18MLDincWHsjXykq1nUjxPSY6C7tTZAQVWlJCRcLMnnirqOL0SgCjEfPEk1b2oopkb4
        cAt/A7sSsjpnE3qZxHww4anMZ26gm5E=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-144-mdkJlDz9Ore6Q7Kp9E1Y6Q-1; Tue, 08 Feb 2022 04:01:36 -0500
X-MC-Unique: mdkJlDz9Ore6Q7Kp9E1Y6Q-1
Received: by mail-wm1-f70.google.com with SMTP id u14-20020a05600c210e00b0037bddd0562eso271513wml.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 01:01:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=teClNrONiYXVnmCwa1h1q0ixCqq3xRiV2+FUHXxwnkg=;
        b=3ObVY7AuNl+zN56J5kjZIl0zSju+uSs3092KbFCZgbdRCsqIgs2x/7MNAfw8B8an79
         CklP08wGi7WRJsu5lF9cxREhaGVPVvskT3E/sw56xMHubeY1J2/IDwYcwnfO6WEB+EhJ
         Nsa+DQYcpq6D1xMbd5PLQ1whopKMLg/vAzuqegmUzaNNsxK85d/gWxdjjsWvGutPKFra
         Eaa2Gz7ckZ3s7ca5nApHRpnmP+2zMmsGxqkLUnDWLdF/yFlekLvh/1DWKh4QTHoWLLnJ
         Lb6W9RnuUSebGe7NSRPWdM5RjdlIzxu4mUk2NxleiK0HoeKDBS3EhneyPGP+w60WT3Re
         Pq9g==
X-Gm-Message-State: AOAM5313++uzD7YTSfMTbMNAy7iKMhKhEhHgC6xmNGvDccVW8lxh5B/E
        8Y/2MOhRfbL/9IG10+9Dj7TK3INoYRtjlge3wgv0Hh8qz6WahDYo1LpiQVi447zSPk0Hg0/3QTM
        VOLD9QV4U4V5awdLu6Oeq9aos
X-Received: by 2002:a05:600c:35c5:: with SMTP id r5mr179779wmq.195.1644310895805;
        Tue, 08 Feb 2022 01:01:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyrVaaJIU8wUcTZyPhODOggfPw3ee0UatWxMSdfB4lHP3hYokLnrCC49IDRTBsBo3R5aJzqjQ==
X-Received: by 2002:a05:600c:35c5:: with SMTP id r5mr179756wmq.195.1644310895582;
        Tue, 08 Feb 2022 01:01:35 -0800 (PST)
Received: from ?IPV6:2003:cb:c712:a800:a1a0:a823:5301:d1af? (p200300cbc712a800a1a0a8235301d1af.dip0.t-ipconnect.de. [2003:cb:c712:a800:a1a0:a823:5301:d1af])
        by smtp.gmail.com with ESMTPSA id e13sm13822419wrq.35.2022.02.08.01.01.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Feb 2022 01:01:34 -0800 (PST)
Message-ID: <dcb5d9c7-ae5c-e0c5-adee-37f5b92281e0@redhat.com>
Date:   Tue, 8 Feb 2022 10:01:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] mm/damon: Add option to monitor only writes
Content-Language: en-US
To:     Pedro Gomes <pedrodemargomes@gmail.com>
Cc:     SeongJae Park <sj@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
References: <20220203131237.298090-1-pedrodemargomes@gmail.com>
 <c4128a09-1dc7-24b3-8ff2-eaf61f3de5e5@redhat.com>
 <CACpbsfapGSbno_n7ZJYJ2E4KkqWdWe_Wz8PuECBa3PZBp2Xnxw@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CACpbsfapGSbno_n7ZJYJ2E4KkqWdWe_Wz8PuECBa3PZBp2Xnxw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.02.22 03:05, Pedro Gomes wrote:
> On Mon, Feb 7, 2022 at 7:32 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> Just like clearrefs, this can race against GUP-fast to detect pinned
>> pages. And just like clearrefs, we're not handling PMDs properly. And
>> just like anything that write-protects random anon pages right now, this
>> does not consider O_DIRECT as is.
>>
>> Fortunately, there are not too many users of clearreefs/softdirty
>> tracking out there (my search a while ago returned no open source
>> users). My assumption is that your feature might see more widespread use.
>>
>> Adding more random write protection until we fixed the COW issues [1]
>> really makes my stomach hurt on a Monday morning.
> 
> I was not aware of these issues.
> 
>> Please, let's defer any more features that rely on write-protecting
>> random anon pages until we have ways in place to not corrupt random user
>> space.
>>
>> That is:
>> 1) Teaching the COW logic to not copy pages that are pinned -- I'm
>> working on that.
>> 2) Converting O_DIRECT to use FOLL_PIN instead of FOLL_GET. John is
>> working on that.
>>
>> So I'm not against this change. I'm against this change at this point in
>> time.
> 
> I agree. I will wait until the COW problems are solved to send this patch.
> 
> 

I'll put you on CC once I have something ready to at least handle pinned
pages (FOLL_PIN) as expected, to not get them accidentally COWed.

-- 
Thanks,

David / dhildenb

