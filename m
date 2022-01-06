Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 121FC4867D4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 17:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241393AbiAFQnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 11:43:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241308AbiAFQnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 11:43:14 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9988CC061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 08:43:14 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id q14so2811085qtx.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 08:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=TaEyjWjeeVNEZiyi0aXBF8Ng1rh3Xpkky+gxZ1pTsQk=;
        b=VgKbNNRkcx+IO8F49oKQcMxswpBeySQuW5eP6S/FG74l5xPer0Nh8lvnufL8HLlMXA
         5x8gBkMJIsRe95U7V/3GSn9ResTVzC9xl+UUlxdAjlPIX7f/zI+MXpcaNnAK9hlXYut8
         Re3jWflUijWkEgQcXAhfg8DpVdmJl8mF1Xu41XomCLPIoR3gzvAyeqb5WTWvLwsDaJ63
         Yps64iAn/rGtX7r/CV/T0kQddGqAoKn3URKH4z+PWuRGQwoLX62xdIJ4tO5NLZ09nFQI
         EhURt5vU9tAUzLivfCB5MwuzOChYoNPebFSqFWfO5LmMeOtSIZ2T1M1yXyBTVXlsMECp
         1g/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TaEyjWjeeVNEZiyi0aXBF8Ng1rh3Xpkky+gxZ1pTsQk=;
        b=jE+lyH2FelxEZIklRgFxjcxz/dXjCBfU8hLmJ2bofz/vDeCuulXEfwLTvJA3/y2RhN
         8R8vQZ8pCTV3SH+bZgpWEfxx0GueyrAYqcd3z+qCfUsIb/sT3ILBmVVSGb0RtG3N3K4D
         QLLpzDj8xaurrOpHC2I1+UU0IUaGRBvocwtjbXunJv6Ny7VSR4Yy757AnKkCfKv2ejG2
         84MeNHJigQuvPLYoI/dGU9F/tFzFYj14KKrvg8zUCWnN6tbzTFDdUMurE86G1cb6xwzs
         4aF9xzD2DdZNeT7ykvukZLi4vJSClGKPeOJRLpPHUTacaZ1x/avZ4w1jzvfCqSuUsKAa
         4xNA==
X-Gm-Message-State: AOAM532OYXN7rPlvAXg4LWQ6zVX+2l47KFnGaJ1+rJBes6KIenRFzSqr
        L4XZcg0HpolYB+uL7sXI7eFcvA==
X-Google-Smtp-Source: ABdhPJxgCcxHQohWjMB2xtFgDdEu23xYR6aQkV/m5wl91kJj6lGffxvrNVVYvD2N8SNoGiW1Q5yeyQ==
X-Received: by 2002:a05:622a:1902:: with SMTP id w2mr54169444qtc.498.1641487393653;
        Thu, 06 Jan 2022 08:43:13 -0800 (PST)
Received: from [192.168.0.111] (d-65-175-178-104.nh.cpe.atlanticbb.net. [65.175.178.104])
        by smtp.gmail.com with ESMTPSA id k23sm1740254qtm.49.2022.01.06.08.43.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jan 2022 08:43:13 -0800 (PST)
Message-ID: <699b3962-1b9e-ab76-8dd4-13311fb2c0c9@google.com>
Date:   Thu, 6 Jan 2022 11:43:12 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.3.2
Subject: Re: [PATCH v2 3/3] prlimit: do not grab the tasklist_lock
Content-Language: en-US
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        William Cohen <wcohen@redhat.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Chris Hyser <chris.hyser@oracle.com>,
        Peter Collingbourne <pcc@google.com>,
        Xiaofeng Cao <caoxiaofeng@yulong.com>,
        David Hildenbrand <david@redhat.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20220105212828.197013-1-brho@google.com>
 <20220105212828.197013-4-brho@google.com>
 <874k6h7s8o.fsf@email.froward.int.ebiederm.org>
From:   Barret Rhoden <brho@google.com>
In-Reply-To: <874k6h7s8o.fsf@email.froward.int.ebiederm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/5/22 17:05, Eric W. Biederman wrote:
> 
> I think the simple solution is just:
> 	update_rlimit_cpu(tsk->group_leader)
> 
> As the group leader is guaranteed to be the last thread of the thread
> group to be processed in release_task, and thus the last thread with a
> sighand.  Nothing needs to be done if it does not have a sighand.

Ah, good to know.  I didn't know the group_leader stuck around as a 
zombie.  That makes life easier.  I'll make the change and repost the 
patches.

Thanks,

Barret
