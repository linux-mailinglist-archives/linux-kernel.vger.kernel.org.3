Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB815223E7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 20:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348858AbiEJS0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 14:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348849AbiEJSZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 14:25:57 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1856F5373E
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 11:25:54 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id e24so24981727wrc.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 11:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yHb/t4sJWtaUrfKkQwH3/sfbd07PYe3PiYuK/lpKKSM=;
        b=XF0oB5IuvA6vJGEyZOrGfxGamHtbVLL4rlc9UC4pYza1Scg0lYG1lQjzP2+uF4mYKg
         k5SqANXoXiMKqwfOjo/kCTJ1wE2u5Oh0t5b3zwwBN12RRjqZg2eGmMtC3vO29ME5jttc
         u8/DTuiEBDHhQ3IT3Tvh+OgaSJhVvk4AxYOiHIHpE+HqpB/QvLCevvw26Hs3WYNOUuT8
         UOHVIWJy37iQItWWuiSHZ2v0tMF5ao8PrVU9FwmB+Edemgi4WxwESF85LNNfolrVn0C0
         BS5Fyo4ODK6JUclQ/DNpWR7V60B/ysAFObHrRLJmgpUAivLmKv3mmULFcV+xH5hnIiyS
         zx2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yHb/t4sJWtaUrfKkQwH3/sfbd07PYe3PiYuK/lpKKSM=;
        b=vh8TN5hXqFM1kUi//qqXfhbV7CYMBm/fsKpR+ZrbUuA/sFG+EykUtyaD1T/Lq47yaM
         TJrP7Ku1Y40HWajUQOTmocg3+2Y8NibOKz3camy0NvoEVjjxybyduf/PvbqBfZ46/x6W
         sIwi80Z7s3dLdi1eBGbKEpDL68BEceDoHXSnkSdfk2b/K9iOGOHhyUVotvJJm0bjj8uS
         w+3pYCZ4WzwHms4ov46tiwdCoLvdLvcYs0musMcAjviCCiRUFIFL32MeElJOqmUZJDbH
         wYi36FHh/PnG7RCmCVb5HAbem+xmp8bNXdkc9qEcP9Dvfdy9ucmPVcsmfPQzeCK0WlJF
         RXXQ==
X-Gm-Message-State: AOAM533KVk97r7jbaamleshdykamotBlvDZxEbZMjd+7EDRjYjjQj1pX
        a+QBJH96BcTVOakSOqkCC1tNCfdcn108y+HSAU8Ayg==
X-Google-Smtp-Source: ABdhPJwgIj7vziuYge7EQKcTCuMZUyByhn/rKEmnyQnFeLeWkydhYLQUs4H82FaqklGewSSKA0AQYRbJD/88/K0apEs=
X-Received: by 2002:a5d:564c:0:b0:20a:d53c:70e3 with SMTP id
 j12-20020a5d564c000000b0020ad53c70e3mr20132500wrw.0.1652207152934; Tue, 10
 May 2022 11:25:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220510001807.4132027-1-yosryahmed@google.com> <20220510001807.4132027-8-yosryahmed@google.com>
In-Reply-To: <20220510001807.4132027-8-yosryahmed@google.com>
From:   Hao Luo <haoluo@google.com>
Date:   Tue, 10 May 2022 11:25:42 -0700
Message-ID: <CA+khW7hbHEEv9JsSCRj5ko=rA2ZorimkpyCCKD=7usv+fTfMNg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 7/9] cgroup: Add cgroup_put() in
 !CONFIG_CGROUPS case
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Michal Hocko <mhocko@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        David Rientjes <rientjes@google.com>,
        Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Mon, May 9, 2022 at 5:18 PM Yosry Ahmed <yosryahmed@google.com> wrote:
>
> From: Hao Luo <haoluo@google.com>
>
> There is already a cgroup_get_from_id() in the !CONFIG_CGROUPS case,
> let's have a matching cgroup_put() in !CONFIG_CGROUPS too.
>
> Signed-off-by: Hao Luo <haoluo@google.com>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> ---
>  include/linux/cgroup.h | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
> index 5408c74d5c44..4f1d8febb9fd 100644
> --- a/include/linux/cgroup.h
> +++ b/include/linux/cgroup.h
[...]
> +
> +static inline struct cgroup *cgroup_put(void)
> +{}

Sorry Yosry, the return type and parameter type are mixed up. I will
fix it and send you an updated version.
