Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 774B0563A7E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 22:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbiGAUIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 16:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiGAUIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 16:08:37 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B8A4F666
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 13:08:35 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id g16-20020a17090a7d1000b001ea9f820449so7445937pjl.5
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 13:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=PSFngJKHrho0FhjB6XnRsy4TL/BbcPjIjM6hLwlPgJM=;
        b=KJN2es13TaWWapgFPPSZUr0HDQneLNPJI+FpW3g3pKbHwyoLr5ukOqQ6PfvGZyYsU6
         YVE0xVKLE5FZWNKxeqTTW+m7OM/XFUX1SlvFAOjo0BJ8/aHXDgD48rsY8qDd2KLt88Db
         ff7QI/rSlge0DvRdZBvMUsEeZ8SfK0/0omobRfhDo7MsVfXGQ4x5kDHFAE5hag/K4G/G
         PrQjSWop/84u7Wap/121fKfSYZCcbZ5NdvrlGhCvdqfjRSJmJzIu2frxoQU9qoIoWOYX
         H8eoFH4xEkWhBA7aOf5/hVkTmA+sZ86c5LnrhhRjqUta5cLGNt2r9DsFTDCsAKiyk02a
         u0/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=PSFngJKHrho0FhjB6XnRsy4TL/BbcPjIjM6hLwlPgJM=;
        b=KA6duqQp8YW6i9SrDO9oa44CNGSLHlD+utVXsMP+r+GTMelCjLoy+OneFfNHtUovWp
         hxzPTRAt0gtS3tusPb1ky8us+KL+wcD0jij+Sba2M9k4eKHXpdendhkJhhHw8xFfJ4rU
         XUhwCy9YGu67prbI9x12h8qWoPkPEh0GDAwZ3QJdceT7DThMNAo8ken+x2OsLf0Quu6k
         A995EV69naRdB5wlSUIlBF9ho/oWClntTKz6QQrBODWYenJodiArop8IhZ+Na27GkZYX
         GlyM6JCAJT1TE8ReCBOHsjpn4QQObvXy9u38gF7BQ0/bJTJwADO/g3YXx2dWJJcQk+xr
         6xOg==
X-Gm-Message-State: AJIora9/raKshUVlF92Q0VIbkvSi1YQ32PNAe2ITlVKuaTB4FVWVCr1g
        2d/XT1JBrkP7D7NX2fdiyxo/pQ==
X-Google-Smtp-Source: AGRyM1vAh19dm+1k/OOm9aJo8kezXqibtQ121c9P50XCzJwgPwvviajf4WtwsUzOazG5i+60HoPygA==
X-Received: by 2002:a17:90a:d3d7:b0:1ef:ebe:d613 with SMTP id d23-20020a17090ad3d700b001ef0ebed613mr18287246pjw.240.1656706115012;
        Fri, 01 Jul 2022 13:08:35 -0700 (PDT)
Received: from bsegall-glaptop.localhost (c-67-188-112-16.hsd1.ca.comcast.net. [67.188.112.16])
        by smtp.gmail.com with ESMTPSA id m17-20020a170902db1100b0016a275623c1sm8463737plx.219.2022.07.01.13.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 13:08:33 -0700 (PDT)
From:   Benjamin Segall <bsegall@google.com>
To:     Zhang Qiao <zhangqiao22@huawei.com>
Cc:     Tejun Heo <tj@kernel.org>, <mingo@redhat.com>,
        <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
        <cgroups@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        <vschneid@redhat.com>, <dietmar.eggemann@arm.com>,
        <bristot@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
        <mgorman@suse.de>
Subject: Re: [Question] The system may be stuck if there is a cpu cgroup
 cpu.cfs_quato_us is very low
References: <5987be34-b527-4ff5-a17d-5f6f0dc94d6d@huawei.com>
        <YrlrBmF3oOfS3+fq@mtj.duckdns.org>
        <f0f55f89-14db-de29-c182-32539f8d4e4d@huawei.com>
Date:   Fri, 01 Jul 2022 13:08:21 -0700
In-Reply-To: <f0f55f89-14db-de29-c182-32539f8d4e4d@huawei.com> (Zhang Qiao's
        message of "Fri, 1 Jul 2022 15:34:41 +0800")
Message-ID: <xm26czeoioju.fsf@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zhang Qiao <zhangqiao22@huawei.com> writes:

> Hi, tejun
>
> Thanks for your reply.
>
> =E5=9C=A8 2022/6/27 16:32, Tejun Heo =E5=86=99=E9=81=93:
>> Hello,
>>=20
>> On Mon, Jun 27, 2022 at 02:50:25PM +0800, Zhang Qiao wrote:
>>> Becuase the task cgroup's cpu.cfs_quota_us is very small and
>>> test_fork's load is very heavy, the test_fork may be throttled long
>>> time, therefore, the cgroup_threadgroup_rw_sem read lock is held for
>>> a long time, other processes will get stuck waiting for the lock:
>>=20
>> Yeah, this is a known problem and can happen with other locks too. The
>> solution prolly is only throttling while in or when about to return to
>> userspace. There is one really important and wide-spread assumption in
>> the kernel:
>>=20
>>   If things get blocked on some shared resource, whatever is holding
>>   the resource ends up using more of the system to exit the critical
>>   section faster and thus unblocks others ASAP. IOW, things running in
>>   kernel are work-conserving.
>>=20
>> The cpu bw controller gives the userspace a rather easy way to break
>> this assumption and thus is rather fundamentally broken. This is
>> basically the same problem we had with the old cgroup freezer
>> implementation which trapped threads in random locations in the
>> kernel.
>>=20
>
> so, if we want to completely slove this problem, is the best way to
> change the cfs bw controller throttle mechanism? for example, throttle
> tasks in a safe location.

Yes, fixing (kernel) priority inversion due to CFS_BANDWIDTH requires a
serious reworking of how it works, because it would need to dequeue
tasks individually rather than doing the entire cfs_rq at a time (and
would require some effort to avoid pinging every throttling task to get
it into the kernel).
