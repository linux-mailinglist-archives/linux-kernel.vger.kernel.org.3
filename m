Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B89254E433F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 16:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238716AbiCVPnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 11:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238704AbiCVPnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 11:43:37 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17638BF71
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 08:42:08 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id t1so22159461edc.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 08:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nlDmFglz7whj/r0GBRKFJ24ATNTxPzzUgtpMW7485f4=;
        b=CND1Tv8y6h1wN3nXUQIKzu8LJkbk/862t1GsMuYd+VkdxovrTkb3al98dhDbupbe12
         QXuRoX6v14abx56NU7QF+9NGYzOFXPjIFilEb5iGh5vpslTno0fzKgvJfg5koKbmHz5d
         vYj7LoRwC6XkP+3DLboyZVHpk8OUGbhumdqo9fqMS2jco8PbB4d+WrP5GBaK+jgACVjc
         H3mKuCT2WW6HfHHoK5gzbP10+klCOPRsnAr11BVA7ZEnncpigY41CsoHDPS8S3Dlr0Ns
         iZHZ/WcuewTT+kVQ6KA2kKz4zO/JxPoHq3uYjMYs2gCqp960E+gWubc8R1ajqLYXIZYY
         OQZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nlDmFglz7whj/r0GBRKFJ24ATNTxPzzUgtpMW7485f4=;
        b=vdreATs52rQ11cMJBCFxfO/bBbw48AelLQthFVADKRhJpqHJg5Ytcoj3l4PWelT5i1
         vwlwy6FZw7k6U/AkuQqw6NpTOWUMrA1WUrg1/bfwhaukh5RjcjlHAQtj+5hvqxSlu0RM
         1E1N5PJCnbtkPq+A3uj8DaJnW7Z6fL7MidF23yol+HiEuDE7WDS0FAw9H3BzFwHKv47V
         8w8tAKkyRIa/5aH4J3uI19W3zp4YQu7j8OOU23P/1RQrOJvsqLp6HSwpxiksTQBkZsh2
         8B/ZAWwfLfedZ/YR8DNj9xwjNEdHcNj+wUz/sJJJ9o2UyPvxGpyh4PbZgtiZinrUvATb
         yARA==
X-Gm-Message-State: AOAM532ZYKJ+mW95dYjXRYqpW7waAXRW6RJA0UTvay6V1OObK+XLcdb/
        ikWjhGV1e3ljfA4Fft88fNqVNGqcuoAxe3WkKyDYPQ==
X-Google-Smtp-Source: ABdhPJyfaNCeAne2eFe8CfwRN/f/oVNmY2Y/pOhZZsuRaOYGVMOQUibxtTc32t6sxxUnC/B69PTQ0uqLWnTvQDvhzLc=
X-Received: by 2002:a05:6402:1e96:b0:418:ff57:ada2 with SMTP id
 f22-20020a0564021e9600b00418ff57ada2mr27039663edf.197.1647963727136; Tue, 22
 Mar 2022 08:42:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220309165222.2843651-1-tjmercier@google.com>
 <20220309165222.2843651-2-tjmercier@google.com> <20220321173726.GA9640@blackbody.suse.cz>
In-Reply-To: <20220321173726.GA9640@blackbody.suse.cz>
From:   "T.J. Mercier" <tjmercier@google.com>
Date:   Tue, 22 Mar 2022 08:41:55 -0700
Message-ID: <CABdmKX10jqubJr49JENaHpFnqHV88+Fb7iNZNH4T1Cy7n9y=ag@mail.gmail.com>
Subject: Re: [RFC v3 1/8] gpu: rfc: Proposal for a GPU cgroup controller
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        John Stultz <john.stultz@linaro.org>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>,
        Kalesh Singh <kaleshsingh@google.com>, Kenny.Ho@amd.com,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, cgroups@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Mon, Mar 21, 2022 at 10:37 AM Michal Koutn=C3=BD <mkoutny@suse.com> wrot=
e:
>
> Hello.
>
> On Wed, Mar 09, 2022 at 04:52:11PM +0000, "T.J. Mercier" <tjmercier@googl=
e.com> wrote:
> > +The new cgroup controller would:
> > +
> > +* Allow setting per-cgroup limits on the total size of buffers charged=
 to it.
>
> What is the meaning of the total? (I only have very na=C3=AFve
> understanding of the device buffers.)

So "total" is used twice here in two different contexts.
The first one is the global "GPU" cgroup context. As in any buffer
that any exporter claims is a GPU buffer, regardless of where/how it
is allocated. So this refers to the sum of all gpu buffers of any
type/source. An exporter contributes to this total by registering a
corresponding gpucg_device and making charges against that device when
it exports.
The second one is in a per device context. This allows us to make a
distinction between different types of GPU memory based on who
exported the buffer. A single process can make use of several
different types of dma buffers (for example cached and uncached
versions of the same type of memory), and it would be useful to have
different limits for each. These are distinguished by the device name
string chosen when the gpucg_device is first registered.

>
> Is it like a) there's global pool of memory that is partitioned among
> individual devices or b) each device has its own specific type of memory
> and adding across two devices is adding apples and oranges or c) there
> can be various devices both of a) and b) type?

So I guess the most correct answer to this question is c.


>
> (Apologies not replying to previous versions and possibly missing
> anything.)
>
> Thanks,
> Michal
>
