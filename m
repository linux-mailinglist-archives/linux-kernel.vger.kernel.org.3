Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C000F5763AF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 16:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbiGOOdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 10:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiGOOdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 10:33:41 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3602510C2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 07:33:40 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id y14-20020a17090a644e00b001ef775f7118so11738132pjm.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 07:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding:content-disposition;
        bh=ETS6R/gPq2RSjpJtoZ0ZInyQq2hDybN3Ayjsi3IlLeQ=;
        b=bt8pTM+aN67HKKD/sVIEtuHlnT/Pt7AtIIZATXfKcX5praNunXoKiIofKwdM8W1AsJ
         DsYuBrx1T/jCu+r7Bo9O7u75BqSWspiTMihYjqILSnEKKKisqRHuOIlPmaiD/kbdlrT4
         ITzlNCKawahSqTB6XAGABwOegu8/O0iX2unSifM68NMmeTJC+GFghqv84dEkQXpOSplo
         keHMuyLOJlpDx+h/TqizPludICSz/Df16R4noXpBgypJbLccOPA5lwlrV0vNdtWejHES
         +ARlMb4puUIMJV6ZiiPoM3K0a8jtB7pjk+FWiiSUMmWDNxuh2yYoZAMhBFFchHS7Wlh5
         tsvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding
         :content-disposition;
        bh=ETS6R/gPq2RSjpJtoZ0ZInyQq2hDybN3Ayjsi3IlLeQ=;
        b=oKMgRT3LrbFH+/W+EXnRdWtjz6CyF7vPcxzlVhbkRMmlNpc7goWPfNNNFxEWTgY90Q
         t6auQ11H/L1DN6Fnbm7lHfBd17WO7mvDLOITb9PDakm/mVdv5hwZpn4chhzU3+vnqejf
         Ao5EDbZfuLEMQ+CaorLk0geHwfSJbZq3uikH1EApWQrzVyooPXD+48hrATILqa0okNjN
         M3IfrK3vtBvBdXYJwVzn6XOXTomxdKykJmFgzASJgTA8cLKU5El48RzP7FoZ6eQb/UMm
         1jwrEd9UrKKLhsSB+EEWu9ZIJ5mHzFIRM9TULbCX1f3B/floFcueApRkujdeqQrqdRnc
         hzIQ==
X-Gm-Message-State: AJIora9QmoNAxP5ZX/VkzsKPAHjri7AvEuykPTDyhR/SrLd3KTdlT2JS
        3hwGLeMXkPsCfVNhqnTvb5I=
X-Google-Smtp-Source: AGRyM1v7KZnjovARbUtknd+OdMFw3XSHwS0vLlBBAaDMu3927zuuWFNgwauB/PQtQy7lvjMrRP0AWA==
X-Received: by 2002:a17:902:cf4b:b0:16c:4634:72 with SMTP id e11-20020a170902cf4b00b0016c46340072mr13722268plg.15.1657895619748;
        Fri, 15 Jul 2022 07:33:39 -0700 (PDT)
Received: from pc ([103.142.140.127])
        by smtp.gmail.com with ESMTPSA id r16-20020a63fc50000000b0041245ccb6b1sm3237116pgk.62.2022.07.15.07.33.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Jul 2022 07:33:39 -0700 (PDT)
Date:   Fri, 15 Jul 2022 22:33:30 +0800
From:   Zackary Liu <zackary.liu.pro@gmail.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     "=?utf-8?Q?mingo=40redhat.com?=" <mingo@redhat.com>,
        "=?utf-8?Q?peterz=40infradead.org?=" <peterz@infradead.org>,
        "=?utf-8?Q?juri.lelli=40redhat.com?=" <juri.lelli@redhat.com>,
        "=?utf-8?Q?dietmar.eggemann=40arm.com?=" <dietmar.eggemann@arm.com>,
        "=?utf-8?Q?rostedt=40goodmis.org?=" <rostedt@goodmis.org>,
        "=?utf-8?Q?bsegall=40google.com?=" <bsegall@google.com>,
        "=?utf-8?Q?mgorman=40suse.de?=" <mgorman@suse.de>,
        "=?utf-8?Q?bristot=40redhat.com?=" <bristot@redhat.com>,
        "=?utf-8?Q?vschneid=40redhat.com?=" <vschneid@redhat.com>,
        "=?utf-8?Q?kuyo.chang=40mediatek.com?=" <kuyo.chang@mediatek.com>,
        "=?utf-8?Q?linux-kernel=40vger.kernel.org?=" 
        <linux-kernel@vger.kernel.org>
Message-ID: <F1E08DFA-40E8-447E-B37A-DEE651E87F80@getmailspring.com>
In-Reply-To: <7CD2EF28-F810-4733-8246-28D9821C180B@getmailspring.com>
References: <7CD2EF28-F810-4733-8246-28D9821C180B@getmailspring.com>
Subject: Re: [PATCH] sched/pelt: simplify load_sum assignment code in
 attach_entity_load_avg()
X-Mailer: Mailspring
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Jun 22 2022, at 11:49 pm, Zackary Liu <zackary.liu.pro@gmail.com> wrote:

> On Jun 22 2022, at 11:20 pm, Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> 
>> On Tue, 21 Jun 2022 at 17:45, Zhaoyu Liu <zackary.liu.pro@gmail.com> wrote:
>>> 
>>> In commit 40f5aa4c5eae ("sched/pelt: Fix attach_entity_load_avg()
>>> corner case"),
>>> these code was committed:
>>>         if (se_weight(se) < se->avg.load_sum)
>>>                 se->avg.load_sum = div_u64(se->avg.load_sum, se_weight(se));
>>>         else
>>>                 se->avg.load_sum = 1;
>>> 
>>> they could be replace with:
>>>         se->avg.load_sum = div_u64(se->avg.load_sum, se_weight(se))
>>> ?: 1;
>>> 
>>> to make the code cleaner.
>> 
>> This quite subjective as I consider current version cleaner than your proposal
> 
> Thanks for your reply, vincent
> 
> Perhaps, this code is more concise, and this form can exist in many
> places in the kernel, and can be searched with 'grep "?: 1;" -nR kernel'
> 
> --
> zackary

I have sent a patch couple days ago but still i don't get the reply,
I am looking forward to your reply,
thank you

--
zackary
