Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0EB155412C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 06:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356295AbiFVEES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 00:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356719AbiFVEDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 00:03:55 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A36340F2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 21:03:43 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id f65so14973214pgc.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 21:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=2zmEWVajikVnd99U/C6g0cNTamIQNth9UnTYGIrEl5Y=;
        b=10SFYfcYHZIS+B+WE8kysFAtlGwL+BX08GqhMJgbGaEpRIMOc32S0yL98OEBlMvOBn
         tciD2PmG+xFeQPnXIllM6x/0Obv7dkyYq4viX5Dkeo1mvbGZfqVo8+AAEX/X79dAWLsn
         KuGvBc+zL0dMVJhWG5U0jNsc34Ru11zsxSjAK8jxi/buLYM/fYzEzls05u/yf+IB+Cb9
         XrRgueKj/UFlQewUP75CeOctGuSRs789ynuOjx5FCygPaDt/cie7woUJ9pSLOOWDKnq4
         KdzbLXiy9kD8Y3WYZYJ0LobbDnj+V88IIW8UCoS1r0JQK7Z4GiL5KI4EM5spjouSVDE4
         4zcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2zmEWVajikVnd99U/C6g0cNTamIQNth9UnTYGIrEl5Y=;
        b=mXZPY9JxDBf8tBkmsh+bn59ddNQ4UOj5CGyBbMTPtggwPsp5pEY8xDCM6MyO1fa2kh
         HQGqMjIjkKd1NAinYCo4ZBCrw9YGZyq1UGYth2Q+75nSiGLaSZD2JUVuIQnX8GnvD21f
         lEKyAmrkTbdaq5SX30OTv+EPWd2NsXlb0Y4GXAKWvk91H8nu9u3VMd57iDmtbbKWbCbu
         e28BsC+8zZx/29IqzyXXkuZ++Iy05PAjdGkUIp0jJkNlhV/HN9PYHecbxToLVrMbTmah
         gp+3iTu4XrRjV1YtUz410mJ0L+55R1pfgO61vhs6yyUPieC9K0/XvXDXZT3x0xuc2sDV
         9t/g==
X-Gm-Message-State: AJIora+GRfn+52dc9XMr7KbXdHqvtPCsBWy08/KTVzBemcV5oGXc+BZP
        qY5gIfhjNpMNfXFojWdo7hCZkg==
X-Google-Smtp-Source: AGRyM1t6aaNPDBfq0Un3ANyM8iytTNEO8Cxn/cDxOi0O5ngWluzIABe75JnJVmXcUXT3su3mD5mrpw==
X-Received: by 2002:a05:6a00:2148:b0:4fa:92f2:bae3 with SMTP id o8-20020a056a00214800b004fa92f2bae3mr33749914pfk.69.1655870623235;
        Tue, 21 Jun 2022 21:03:43 -0700 (PDT)
Received: from [10.94.58.189] ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id h3-20020a170902680300b001651562eb16sm11565746plk.124.2022.06.21.21.03.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jun 2022 21:03:43 -0700 (PDT)
Message-ID: <3790fb8b-db91-b528-c574-b188c5d8d2fd@bytedance.com>
Date:   Wed, 22 Jun 2022 12:03:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v4 6/7] sched/fair: skip busy cores in SIS search
Content-Language: en-US
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Josh Don <joshdon@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        linux-kernel@vger.kernel.org
References: <20220619120451.95251-1-wuyun.abel@bytedance.com>
 <20220619120451.95251-7-wuyun.abel@bytedance.com>
 <20220621181442.GA37168@chenyu5-mobl1>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <20220621181442.GA37168@chenyu5-mobl1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/22/22 2:14 AM, Chen Yu Wrote:
> Hi Abel,
> On Sun, Jun 19, 2022 at 08:04:50PM +0800, Abel Wu wrote:
>> Try to improve efficiency of SIS domain search by filtering out busy
>> cores, and as a result the more overloaded the system is, the less
>> cpus will be scanned.
>>
>> The filter is supposed to contain unoccupied cpus of the LLC. And we
>> propagate these cpus to the filter one at a time at core granule.
>> This can help spreading load to different cores given that the search
>> depth is limited. The chosen cpu to be propagated is guaranteed to be
>> unoccupied at that time.
>>
>> When idle cpu exists, the last one is preferred in order not to
>> conflict with periodic load balancing during which the first idle
>> cpu (if any) is chosen to be fed with tasks.
>>
> Maybe the content in cover letter could be copied into this git log for
> future reference?

Definitely. Will fix this in next version.
Thanks.
