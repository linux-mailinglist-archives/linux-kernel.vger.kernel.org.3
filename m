Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B275061F1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 04:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344243AbiDSCCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 22:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234716AbiDSCCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 22:02:11 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BC22F382
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 18:59:29 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id s70so5747971qke.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 18:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wCsQtD2NQ+gbeoKp9EzAjHzyK6SBXrAkZNvU9pPrYqA=;
        b=M9TlNCxxcBX0yUHiIVEapcv8P3OPBDK5VOwlHdUva2h3+sMA0gk7fJtp7stFVeb8CY
         HYTNcluvwI0Sgg42bXELRbBOCihfzVIb5lpF8DVz/ljn7GPxht0cJSqtxrlfSHIDr+qK
         mVpxQfqMgMwWpGRBRWzBwHLOCb+qKSrk9it8C0Ai0PGUwlJc1EdrAgnZlhHRz1q8fv9+
         rqzkmxsv26cA7Ha1t4s5ukPeM4hDhXlnW8U8m8pb1KYOJXjj5BnpxsyCXMS86WHXhVPx
         /5lKSn9NdL4M1vNq+YiAoWFCPvEb1mR2rcroAF0mpO+YkQioXAtJ6yXAge0kiLzkYxyI
         CYRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wCsQtD2NQ+gbeoKp9EzAjHzyK6SBXrAkZNvU9pPrYqA=;
        b=l/rt4UkZ+kAbS6fwee9cNl1RDuZB65V+M60DHdzEMoLCr9M6WYStzcZWMHcXOXfmus
         AW5PKac8TyZg+SZ/8zsqRiY+CAw0sDiQffLk0jIMcSkn1TTS+KFgOkWqDVPQubK1FzJ4
         9Xu7axpuN0CO2apReENZpSHARj/SUYQ5F5y9I20fHMiObCU6UtmVuubVAsVUPK3e24BT
         EhD6aIe4y1yKBNWx5er9/8dCnVhe+HDdnkJxYvUWr7h0KuXUuUuVdriedQPziCqmoIUb
         0t8FkPws35vqOjogEIuEhj+YIz+RRVoVshHDA5aD2oYr/NX85NF2P3rsqfLzmN0/f9Cl
         7KLA==
X-Gm-Message-State: AOAM5325nA+F1cqA9Cl8QDVBH8hS5BWlDme8nXcAXSetADJmd66s8hKL
        rlITbqQpYQGngRCtjwiMAg2K7obXOIQUJtkSmPT7Vg==
X-Google-Smtp-Source: ABdhPJymdwkKvk3KkRb/O6pCJ7D6/9Nv7MBaNf+tmHbYqlewiWquB4d2TgeCmsw5i4kp2kBKCwfxtnz9T03ex9VIObA=
X-Received: by 2002:a37:9603:0:b0:67d:da02:19e8 with SMTP id
 y3-20020a379603000000b0067dda0219e8mr8458309qkd.242.1650333568819; Mon, 18
 Apr 2022 18:59:28 -0700 (PDT)
MIME-Version: 1.0
References: <Ylk5o3EC/hyX5UQ0@google.com>
In-Reply-To: <Ylk5o3EC/hyX5UQ0@google.com>
From:   Curtis Malainey <cujomalainey@google.com>
Date:   Mon, 18 Apr 2022 18:59:17 -0700
Message-ID: <CAOReqxhDpmexe_aLHb2-ESjSE2uij2SrPxRCZD3YxZm0JjtwrA@mail.gmail.com>
Subject: Re: [Sound-open-firmware] out-of-bounds access in sound/soc/sof/topology.c
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        ALSA development <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Sound Open Firmware <sound-open-firmware@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Now control data allocations looks as follows
>
>         scontrol->size = struct_size(scontrol->control_data, chanv,
>                                      le32_to_cpu(mc->num_channels));
>         scontrol->control_data = kzalloc(scontrol->size, GFP_KERNEL);
>
> Which is sizeof(sof_ipc_ctrl_data) + mc->num_channels * sizeof(sof_ipc_ctrl_value_chan)
>
> For some reason it uses sizeof(sof_ipc_ctrl_value_chan), which is not
> the largest member of the union.
>

For the record, this could be hitting as far back as 5.4 as I have
been trying to debug an invalid IPC write in JSL.
