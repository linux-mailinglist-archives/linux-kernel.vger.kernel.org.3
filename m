Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24DC0473571
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 20:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241506AbhLMT7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 14:59:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236735AbhLMT7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 14:59:49 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C82C061574;
        Mon, 13 Dec 2021 11:59:49 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id d2so14917641qki.12;
        Mon, 13 Dec 2021 11:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:user-agent:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=Qky24JZIeQoHw3ICTTlxOYct+/eWozkLnsHMN8yEZf4=;
        b=ivEG6K43UlnRJVSW/+OrBaa1XEkyyqfkx8XAA64gt4Dy4VRPjGHdDJDqsSz12/kHkK
         azGPzqgNdxhzQdBB9bFiJcxnxqG3f5R0n7HCaGNo9a8VZmIVRJFpnwLIw1c5CMg91cU0
         NfLH/aF3DiwVdVnW9T7V3iB6BBOuhSbGPhdvIez6JTfh0hnE23g1aocIfxhUBlrp5W0w
         ruQN19Lfko+l7/XjN/hbvGooHOoVEcAP3X85hazukilQ6CaBb7jhmsJvdsZIVvOts7UO
         t8A06J11kvwxf1orjJTUPFgHBpqgQP7kUEo3p8mV0Jd2kKuURHxleafgrjeyfrohSOQV
         7gkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:user-agent:in-reply-to
         :references:message-id:mime-version:content-transfer-encoding;
        bh=Qky24JZIeQoHw3ICTTlxOYct+/eWozkLnsHMN8yEZf4=;
        b=jusAEHjXOpy77sfRVkejdIBwpO7wQRm02U/oFBweBiqPvdS6JehT9I0DzbzRk5oy2G
         XLsZER21LauE/KZwQ6Hb0DpL8o/Yk/9FArwlD+wUk2CZ9Wt2gguiCf4vAf8RRYrYC4uX
         nnXN+C9KBtNClMGhCYtm1RKV+ORhCbSvp4/C6e8e1qq+ClOzhqXGlfksIrbXR7sa/D6b
         8HCWIB1GGZZe9WcFGTw7kqG0izKB20jWgdTFPKHx45Pps8r4OZbWBMbh1G4DVMcaC98M
         pHIlrOPstdfHynYg67K8An0km+1rA0xYogHjViPs+dvAkq8A9acXQm9QpT4L+tqdH/1s
         7sjA==
X-Gm-Message-State: AOAM532fXCdBnvhKJes+SG5vjuOKILaDEY6nb8YwOXiNKyY/o3FEG3qo
        2FE3XgmQZk0XQx6cGC9tMfc=
X-Google-Smtp-Source: ABdhPJzXkFVOnvL6om1urqQQwGsRx0vuW8k9svX4LYQHYCkqevEIteL3bkY8PMDyQueWXOJTQnYgVQ==
X-Received: by 2002:a37:644f:: with SMTP id y76mr348341qkb.244.1639425588460;
        Mon, 13 Dec 2021 11:59:48 -0800 (PST)
Received: from [127.0.0.1] ([187.68.231.66])
        by smtp.gmail.com with ESMTPSA id a16sm10343593qta.94.2021.12.13.11.59.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Dec 2021 11:59:47 -0800 (PST)
Date:   Mon, 13 Dec 2021 16:59:41 -0300
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
To:     German Gomez <german.gomez@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v1_2/4=5D_perf_script=3A_Add_=22struct_?= =?US-ASCII?Q?machine=22_parameter_to_process=5Fevent_callback?=
User-Agent: K-9 Mail for Android
In-Reply-To: <73ecfe08-f38b-1308-40b5-a1a778323bf5@arm.com>
References: <20211201123334.679131-1-german.gomez@arm.com> <20211201123334.679131-3-german.gomez@arm.com> <D6A3A8F3-9946-44FE-A70F-42977C6F38A1@linux.vnet.ibm.com> <38fd4992-63ae-4871-ddfd-27d40b5c48d2@arm.com> <YbePfOMaiJjoDb3b@kernel.org> <73ecfe08-f38b-1308-40b5-a1a778323bf5@arm.com>
Message-ID: <729C0734-B346-455A-A95D-A9C170369F72@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On December 13, 2021 3:31:47 PM GMT-03:00, German Gomez <german=2Egomez@ar=
m=2Ecom> wrote:
>
>On 13/12/2021 18:22, Arnaldo Carvalho de Melo wrote:
>> [=2E=2E=2E]
>>
>>> Thanks for the suggestion=2E It looks like we can skip this patch if w=
e
>>> can get the arch value that way=2E
>> So the first one is already upstream, will you post a v2?
>>
>> - Arnaldo
>
>Hi Arnaldo,
>
>I sent a v2 where this patch was removed=2E The upstreamed patch (1/4
>here) remained the same=2E

Thanks, I'll check=2E

- Arnaldo
>
>https://lore=2Ekernel=2Eorg/all/20211207180653=2E1147374-1-german=2Egomez=
@arm=2Ecom/
