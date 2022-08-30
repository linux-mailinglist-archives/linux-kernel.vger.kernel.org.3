Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8F515A6B05
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 19:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232133AbiH3Rme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 13:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbiH3RmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 13:42:16 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E106E11BE08;
        Tue, 30 Aug 2022 10:39:16 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id x10so12135765ljq.4;
        Tue, 30 Aug 2022 10:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=1rNoYI6m6L+3BQaVvwHu2oGrkYlGZQ0lZPknoAYyyyg=;
        b=JoAsIEwzMLK+OJs1OCIrvIOdMATZZFdgUhU9w6VcDm/PTsA3AMVfX0VakGsGyZflEY
         sQZlD+da1M83Y1zAqzHFc9rRNLdOvihxfJSV/RyR5OhThUmPRgrAuGw6ruylS/wOq7TE
         TVDp+/ujrG3Phm1AswWbOGAc5bQmmQd3AS5cLlNQF9tZe1HyPXVESVMdYj/NCzUbR9jf
         KkfbeRdlMFa4kHYh5lomrTG8Oz4BYGcjmH5mV7bKFJf9S6AT1cIuaEzhTGbKzFbnRHBO
         cBDgFeBliR1x5IeiEkmFF/VwSo2RzLR6EqyIRwWHc0Sk8CnJMhDKOOHHvhVMNABpR/YA
         NqYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=1rNoYI6m6L+3BQaVvwHu2oGrkYlGZQ0lZPknoAYyyyg=;
        b=YkTwSNiKeGt3VFvejPjuWcqktf6384uJJ70g41Do85WqIcIlOlU0lh/EggV6nJxY/2
         OqMO99jqY7sF5Z7C0pQQC703OfDTBgagEZQ4IbRdpZkb2L5CmoN3WUHR0wYOYoiOuGwA
         afidRtHz+IXToUbFhuvNeF/LbaG1SB5kIZ9a5Y2JXb3s9WhiYWuNey6GfsWk20xEWBFd
         P1EvlsG/IOoioPaVrev+yWsg3M/mv/jVG/awWX5hfhA9DwjNM5vu9yoanY7kOLOB+fuX
         SM/aWHTNWiR6GZ44FTwnDQXeo98dCKE9WE9R+sYVufizNbRuo7fHFAojjZ0A9SA0Wl0i
         C3Fg==
X-Gm-Message-State: ACgBeo0jESHjGYV8mNgZWjLh55H3gPEBbvGwiNagub98gIXVtz+D0jW7
        UsD+ro0rcdS//bE8jEkhqN/GE16QmgzpXygS5FmK3qLf
X-Google-Smtp-Source: AA6agR6GqHyf+dRBzAuQXmYXvgaB5ir74h4JbqpzbDTPOUkhi2/Y/z3Sv6vLMYCisaVvhmJe++xuXI3JwRdvL0UOSa8=
X-Received: by 2002:a2e:a884:0:b0:25d:d8a2:d18c with SMTP id
 m4-20020a2ea884000000b0025dd8a2d18cmr6857400ljq.305.1661881039113; Tue, 30
 Aug 2022 10:37:19 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000016512d05e76bd837@google.com> <CAJhGHyDPN0CWZD8PxFHoB66f6QBNFGx8Lwz9EG-kSB8Q2yriQw@mail.gmail.com>
In-Reply-To: <CAJhGHyDPN0CWZD8PxFHoB66f6QBNFGx8Lwz9EG-kSB8Q2yriQw@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 30 Aug 2022 10:37:07 -0700
Message-ID: <CABBYNZKNHnrgHfu8JN-kw5UqfEGUVWGyOwK_fLqHP5w8kPc2KA@mail.gmail.com>
Subject: Re: [syzbot] upstream test error: WARNING in __queue_work
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     syzbot <syzbot+243b7d89777f90f7613b@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com, Tejun Heo <tj@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lai,

On Tue, Aug 30, 2022 at 7:08 AM Lai Jiangshan <jiangshanlai@gmail.com> wrote:
>
> CC: BLUETOOTH SUBSYSTEM
>
> It seems that hci_cmd_timeout() queues a work to a destroyed workqueue.

Are there any traces or a way to reproduce the problem?

-- 
Luiz Augusto von Dentz
