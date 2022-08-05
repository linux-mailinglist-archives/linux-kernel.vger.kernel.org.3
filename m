Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3721E58AEB7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 19:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241083AbiHERPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 13:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237539AbiHERO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 13:14:56 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01AC3193F9
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 10:14:53 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id z20so2276537edb.9
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 10:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=pFJxvp8fwyz1vgCPNQyO0NCG68skXsENlZHLzqZoSXM=;
        b=e0NSP931GtvYRj3rFRfGV5JEM9xx1GFrCS1Fxr4BZcJKwaJniqpgsCKeK7jYrr2wRm
         cocGAKqAmUaNSBWtRzGa1phNNVegR4OqOTxYWSx6JZ4fUrxzydb6j7T3uXqqw0SQJ4Uo
         yBfSAWMcc6cZjmjQGzAKogrwzSj9eqNt0qga0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=pFJxvp8fwyz1vgCPNQyO0NCG68skXsENlZHLzqZoSXM=;
        b=cAkpQ+byu9JR2hVYEJDd8fEptwwKnhdoWZ7v8XpzEC5d2V8k3sNnsSX9nPwEIVZyA/
         CZi6tbz7y1VU6HbNkrKvBgLtA3EIIC3KOxzx8bJv7RCk96ODsORtEY61LzWkkyZ/8HsU
         o4exO5HRy0ZZlYzVL5FdMUtl2QQua5BEzujswjqe+azNtQ0K/PldhwJM6V3Ii+1BG9zj
         Tdur/I/GYAVm8KM6AhYLwxKA4lHEAuDgZ2XuDjsC4y97GokQ6K8gfEcqnEAViCvzUSDw
         UmUAeTd5Mk9aALm25BkHZEQYBjcH84G/4rxSL5Pt6uRPm7YQjnOkW4NNjDGQ1gnXy+k+
         x94w==
X-Gm-Message-State: ACgBeo34aLmgUR9hzM5kwtO+3bFfcuPMIGpR7A+23T8VjfAm+f2kD08n
        BDyMBdtx9cpjd2dBRbVU6H+r/39h+EkjzFfh
X-Google-Smtp-Source: AA6agR7jl8yr5OzKDFB9JnhTb9NmICCJnkyqsZhpXNYTZ4LxMMn6MSzOqA8MFJZRmR9Qj+OVVBgjrQ==
X-Received: by 2002:aa7:d513:0:b0:43d:5c81:4f71 with SMTP id y19-20020aa7d513000000b0043d5c814f71mr3464030edq.308.1659719691368;
        Fri, 05 Aug 2022 10:14:51 -0700 (PDT)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id sd27-20020a170906ce3b00b00722e50dab2csm1776266ejb.109.2022.08.05.10.14.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Aug 2022 10:14:48 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id l4so3892743wrm.13
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 10:14:48 -0700 (PDT)
X-Received: by 2002:a5d:5889:0:b0:21d:bccd:38e3 with SMTP id
 n9-20020a5d5889000000b0021dbccd38e3mr4797328wrf.659.1659719688007; Fri, 05
 Aug 2022 10:14:48 -0700 (PDT)
MIME-Version: 1.0
References: <20211116012912.723980-1-longman@redhat.com> <CAD=FV=URCo5xv3k3jWbxV1uRkUU5k6bcnuB1puZhxayEyVc6-A@mail.gmail.com>
 <20220719104104.1634-1-hdanton@sina.com> <CAD=FV=Xng_Mcd-9SaK29XSbsthDWLTR6sz53VEktAQFng6a27A@mail.gmail.com>
 <20220722115510.2101-1-hdanton@sina.com> <CAD=FV=XS_AqMveo=a2zN+=b3DxM-yJQapd27Dq8dR+kSb2oL_A@mail.gmail.com>
 <20220723001713.2156-1-hdanton@sina.com>
In-Reply-To: <20220723001713.2156-1-hdanton@sina.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 5 Aug 2022 10:14:36 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X7FnrwHSedA=1xJsrfSgQZcqu0YEAKrfoJC6BhDc-gFA@mail.gmail.com>
Message-ID: <CAD=FV=X7FnrwHSedA=1xJsrfSgQZcqu0YEAKrfoJC6BhDc-gFA@mail.gmail.com>
Subject: Re: [PATCH v5] locking/rwsem: Make handoff bit handling more consistent
To:     Hillf Danton <hdanton@sina.com>
Cc:     Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>, MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jul 22, 2022 at 5:17 PM Hillf Danton <hdanton@sina.com> wrote:
>
> On Fri, 22 Jul 2022 07:02:42 -0700 Doug Anderson wrote:
> >
> > Thanks! I added this diff to your previous diff and my simple test
> > still passes and I don't see your WARN_ON triggered.
>
> Thanks!
> >
> > How do we move forward? Are you going to officially submit a patch
> > with both of your diffs squashed together? Are we waiting for
> > additional review from someone?
>
> Given it is not unusual for us to miss anything important, lets take
> a RWSEM_WAIT_TIMEOUT nap now or two.

It appears that another fix has landed in the meantime. Commit
6eebd5fb2083 ("locking/rwsem: Allow slowpath writer to ignore handoff
bit if not set by first waiter").

...unfortunately with that patch my test cases still hangs. :(
