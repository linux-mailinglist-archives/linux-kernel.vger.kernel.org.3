Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3EDF4CABB7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 18:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243945AbiCBR3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 12:29:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239351AbiCBR3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 12:29:40 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785A24D601
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 09:28:08 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-2dbfe58670cso26331747b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 09:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uuao6LtPoxz+SwUeDa6xzf7SfiyP8QP18hPPHG47BUc=;
        b=q3XRXLhSkdzfXMPqmPGrtL5qKLDaaanmRsuY1OlB+gywhyfQ3P0k2Ty/lLBIx9hngr
         bIE3qAL4ikUxI5IPrvBeSteXA23/TUiOhOXlNzpa2gQtUgeyGl8Sv+On2Q2+b/ioPLVK
         y6mGgX6AYdM5qc4LpFsHD+JseMxCAPR3H5Cc4VnjOZ7eV1ADHbYrVBbr9AL8ZR5ElxMn
         onL1EgPo/RmTTVYw9otAeEqlQaXOudGa8wKxOcCtR9oLm0BoPskgY4WBR6I9166lo/cT
         W+PbTD8Xdk6xgUjKZon509MUJZNIphLafkMUrZ8a/ku3GC4bjTQpoQ7Ua0dreHWIDPif
         i76A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uuao6LtPoxz+SwUeDa6xzf7SfiyP8QP18hPPHG47BUc=;
        b=q7SzyoTCNiEKiH4Dv7j9enkZOK+cpRjE0vK8rrygf3b/VkhmIfb7160pojBK8jd8Fr
         lk2p0cpOO/7jr66U35OaoiJI9x8qQU67mYcneNojhtS4t8rWjjp9QR7YvUjdcm5/k4Kd
         0kc5EK9Y3VUDT0wRE81/ELSZ2HwdUkWq7jjgydhKfHAnzBGrOIwKQaPb8PZZbN6OJ/GS
         ZHMa1Z3q3SJ6C0VbYwbKqOD4ekj6r05ej+Fy5nUXqZI7Kto3+0v7Qa8RH+fOAUocUt/o
         zKE9Y0gmxy5Zd17ia8H2udlZq9mqw6NNcS88HOblOSjyqaGOmcwlnQ5V27k9cuveSh0T
         Mr4Q==
X-Gm-Message-State: AOAM530Rm3CniJZzq7fHjk9ONNk3OH926qTZrdRo8fDNMQmQNgPwlOXd
        kcCOpgfRJkHmwwITscYxQPRhQixw+3hfwErFkIi64Q==
X-Google-Smtp-Source: ABdhPJwm2ZWFQ7qE2nk58NylCSEqbiMe0zCq2KvKucwX8DnqEWD9OpvdoQUD/JGXnJ1oLd0rtBKUTnEU1/3Qg3jDPlI=
X-Received: by 2002:a81:49d0:0:b0:2db:dc6d:445d with SMTP id
 w199-20020a8149d0000000b002dbdc6d445dmr9596217ywa.512.1646242087255; Wed, 02
 Mar 2022 09:28:07 -0800 (PST)
MIME-Version: 1.0
References: <20220225180318.20594-1-vbabka@suse.cz> <YhnUcqyeMgCrWZbd@ip-172-31-19-208.ap-northeast-1.compute.internal>
 <f194f876-1c46-f3ae-573e-d3ddd6dcf4cc@suse.cz> <Yh0+Jld+sDy1Hkdb@ip-172-31-19-208.ap-northeast-1.compute.internal>
 <Yh8szz+UxqddwK7j@linux.ibm.com> <024aacf5-ac49-7d04-7293-1e1451ff9029@suse.cz>
 <Yh9jgGOocmU3WsES@linux.ibm.com> <Yh+jJC8JofHx28K+@ip-172-31-19-208.ap-northeast-1.compute.internal>
In-Reply-To: <Yh+jJC8JofHx28K+@ip-172-31-19-208.ap-northeast-1.compute.internal>
From:   Marco Elver <elver@google.com>
Date:   Wed, 2 Mar 2022 18:27:30 +0100
Message-ID: <CANpmjNMMu5-fvmmx4SidWFdbAnsJJhqTd1bfyxJtvJV3d3q_fg@mail.gmail.com>
Subject: Re: [PATCH 0/5] SLUB debugfs improvements based on stackdepot
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Mike Rapoport <rppt@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        Oliver Glitta <glittao@gmail.com>,
        Faiyaz Mohammed <faiyazm@codeaurora.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Mar 2022 at 18:02, Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:
[...]
> So IMO we have two solutions.
>
> First solution is only allowing early init and avoiding late init.
> (setting a global variable that is visible to stack depot would do this)
>
> And second solution is to make caller allocate and manage its own hash
> table. All of this complexity is because we're trying to make stack_table
> global.

I think this would be a mistake, because then we have to continuously
audit all users of stackdepot and make sure that allocation stack
traces don't end up in duplicate hash tables. It's global for a
reason.

> First solution looks ok if we have few users of stack depot.
> But I think we should use second approach if stack depot is growing
> more and more callers?

The problem here really is just that initialization of stackdepot and
slabs can have a cyclic dependency with the changes you're making. I
very much doubt there'll be other cases (beyond the allocator itself
used by stackdepot) which can introduce such a cyclic dependency.

The easiest way to break the cyclic dependency is to initialize
stackdepot earlier, assuming it can be determined it is required (in
this case it can because the command line is parsed before slab
creation). The suggestion with the stack_depot_needed_early variable
(like Mike's suggested code) would solve all that.

I don't understand the concern about multiple contexts. The problem is
just about a cyclic dependency during early init, and I doubt we'll
have more of that.

Thanks,
-- Marco
