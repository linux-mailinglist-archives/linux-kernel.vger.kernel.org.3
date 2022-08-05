Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0484758B024
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 21:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240748AbiHETCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 15:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233431AbiHETCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 15:02:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DCB6C18E29
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 12:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659726135;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GIcmLgWRQIu/jzaYm/Us8pJ8sFlavYikN+PtkX6N63Y=;
        b=IbLTtwuVhIxbtQrquZZWela20ZsB5lvBrPRpWJz8/mY/EXyw+phRTu7YJw4zoKeOqr1+yv
        QqGmmJTkTakq/cvumwMTmUAqfAMpS1Y9Aq2fGDih7Mqr02gT10plTC1pTUO+Bs0AXbjztp
        BeLyBlo+754u1QpsFy++D2WjqJ0RU/s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-qvoksAyINU6K1nsOnUEzxg-1; Fri, 05 Aug 2022 15:02:11 -0400
X-MC-Unique: qvoksAyINU6K1nsOnUEzxg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 50F4385A586;
        Fri,  5 Aug 2022 19:02:11 +0000 (UTC)
Received: from [10.18.17.215] (dhcp-17-215.bos.redhat.com [10.18.17.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DAD99C27D95;
        Fri,  5 Aug 2022 19:02:10 +0000 (UTC)
Message-ID: <2fcf84e6-168b-4ee7-bc9e-5b1c3c9a3d4e@redhat.com>
Date:   Fri, 5 Aug 2022 15:02:10 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5] locking/rwsem: Make handoff bit handling more
 consistent
Content-Language: en-US
To:     Doug Anderson <dianders@chromium.org>,
        Hillf Danton <hdanton@sina.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>, MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20211116012912.723980-1-longman@redhat.com>
 <CAD=FV=URCo5xv3k3jWbxV1uRkUU5k6bcnuB1puZhxayEyVc6-A@mail.gmail.com>
 <20220719104104.1634-1-hdanton@sina.com>
 <CAD=FV=Xng_Mcd-9SaK29XSbsthDWLTR6sz53VEktAQFng6a27A@mail.gmail.com>
 <20220722115510.2101-1-hdanton@sina.com>
 <CAD=FV=XS_AqMveo=a2zN+=b3DxM-yJQapd27Dq8dR+kSb2oL_A@mail.gmail.com>
 <20220723001713.2156-1-hdanton@sina.com>
 <CAD=FV=X7FnrwHSedA=1xJsrfSgQZcqu0YEAKrfoJC6BhDc-gFA@mail.gmail.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <CAD=FV=X7FnrwHSedA=1xJsrfSgQZcqu0YEAKrfoJC6BhDc-gFA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/5/22 13:14, Doug Anderson wrote:
> Hi,
>
> On Fri, Jul 22, 2022 at 5:17 PM Hillf Danton <hdanton@sina.com> wrote:
>> On Fri, 22 Jul 2022 07:02:42 -0700 Doug Anderson wrote:
>>> Thanks! I added this diff to your previous diff and my simple test
>>> still passes and I don't see your WARN_ON triggered.
>> Thanks!
>>> How do we move forward? Are you going to officially submit a patch
>>> with both of your diffs squashed together? Are we waiting for
>>> additional review from someone?
>> Given it is not unusual for us to miss anything important, lets take
>> a RWSEM_WAIT_TIMEOUT nap now or two.
> It appears that another fix has landed in the meantime. Commit
> 6eebd5fb2083 ("locking/rwsem: Allow slowpath writer to ignore handoff
> bit if not set by first waiter").
>
> ...unfortunately with that patch my test cases still hangs. :(

The aim of commit 6eebd5fb2083 ("locking/rwsem: Allow slowpath writer to 
ignore handoff bit if not set by first waiter") is to restore slowpath 
writer behavior to be the same as before commit d257cc8cb8d5 
("locking/rwsem: Make handoff bit handling more consistent").

If the hang still exists, there may be other cause for it. Could you 
share more information about what the test case is doing and any kernel 
splat that you have?

Thanks,
Longman


