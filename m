Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1586B4C9550
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 21:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237251AbiCAUAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 15:00:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233804AbiCAUAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 15:00:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BB8935AED8
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 11:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646164792;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y7g3J32HdOCpHrq5sy7Cx7BfsIC0Rgx3rlGFcGBO9uo=;
        b=HyKvxyUJ3mUsHjfUWzInJgSp0GwttnevX88LrrccijtgB1w/O4vy5SW7iZPHVSTIQhw+t5
        Twz/OPn/ERG8l3EJQ/ziBg/28KGZl3Oe4t73yQ7DqoUVZ/6U3tkqD+tRcj4nJ4ryyAJWaq
        OIkdzSwfb4Q6D0o/hS2iCMm7KfxR2Ks=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-122-SauVkzB_MGio8XnAqNQsmw-1; Tue, 01 Mar 2022 14:59:51 -0500
X-MC-Unique: SauVkzB_MGio8XnAqNQsmw-1
Received: by mail-wm1-f71.google.com with SMTP id f7-20020a7bcd07000000b003815081b984so905583wmj.7
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 11:59:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Y7g3J32HdOCpHrq5sy7Cx7BfsIC0Rgx3rlGFcGBO9uo=;
        b=4qo9rYkfaBCgluvtv+U7Ak+wvvq4APAnYBJtbe9QNFrmggY5ge2uiRT3zYPWxZiHtV
         rV+5fnXOaE5eMj6QosTvVNIjRzL9uzewoseV/POTbt2DWWdderBLi+4RK10ZyQwC9Kuk
         VcdM3Qf9/dBNHp87wfn4sM6lMKkQPC/QpaIDGq28iPKQgz743vi0hvcrucS4IBqMrlMy
         Kknm6biyItOcWT9DXzAu8IYOkwgKachlnPScFzHjyUFtTdgUrq8HbuuM+vJIqHWBewkg
         O+zkLHKfUWcNwm6Yt0fcpYcABHCgM8tnJjehKcGl3oWKBiF58kO+HqaX21WMO+Biwbol
         EZ6g==
X-Gm-Message-State: AOAM531VqwJ8E5BAHXNo6qf0+bTx5sJAfBKyxkdspu/zxRuM3/3QjBfb
        vg3BeywWvyiXrmrG2w80Qd/xcYYyMSe7OJcnBPu2Hy6Smqk57rbjs9VeRYwbhvZTNEZvKEVlUlr
        XDTU+DokPs/kuOxPKHtTnrnOL
X-Received: by 2002:adf:f206:0:b0:1ef:fdb3:4b2b with SMTP id p6-20020adff206000000b001effdb34b2bmr5375277wro.179.1646164790338;
        Tue, 01 Mar 2022 11:59:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwwBHy8e68EuO2gLdH/vYo6pf08MhYaPs40YbGA2uQjjO579QdOVV3y6M5Gurl4bZOAaXI/0g==
X-Received: by 2002:adf:f206:0:b0:1ef:fdb3:4b2b with SMTP id p6-20020adff206000000b001effdb34b2bmr5375268wro.179.1646164790103;
        Tue, 01 Mar 2022 11:59:50 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.googlemail.com with ESMTPSA id k13-20020a7bc40d000000b00381890032dfsm2783395wmi.1.2022.03.01.11.59.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 11:59:49 -0800 (PST)
Message-ID: <6036649f-bec2-e6e9-b592-f2fcbbd8f08a@redhat.com>
Date:   Tue, 1 Mar 2022 20:59:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [GIT PULL] KVM changes for 5.17-rc7
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>
References: <20220301130815.151511-1-pbonzini@redhat.com>
 <CAHk-=wg1LV8MoSNXQE9kiaFSUHdyMhLpAiQ0JW=JGZKmrORQ4Q@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <CAHk-=wg1LV8MoSNXQE9kiaFSUHdyMhLpAiQ0JW=JGZKmrORQ4Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/22 20:31, Linus Torvalds wrote:
> On Tue, Mar 1, 2022 at 5:08 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>>>
>> The following changes [..] are available in the Git repository at:
>>
>>    https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus
> 
> Nope. Not there.
> 
> When I do a 'git ls-remote' on that thing, the 'for-linus' tag still
> points to your previous pull request from last week.
> 
> Forgot to push?

Indeed, sorry about that.

Paolo

