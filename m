Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0945F4CAD50
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 19:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239189AbiCBSRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 13:17:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237841AbiCBSQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 13:16:58 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52197D76CD
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 10:16:13 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id j2so5195397ybu.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 10:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/VLROJBYuLDdNAp4M2sx7oa2ZYyJWER5sXhuG/3iYEw=;
        b=VA8P2QicdFFuFTVVowlGiyOo2Qo7vLNdJTy2DraYU4P9l869BIPH5uR348JLzL5olw
         3EYlq1i8xbU0evnyZ277YkRf5A9LPXLQx8zpZ0r1HEUu4j+SfnWIbAXKbCd+xmLjmRzE
         /gNwECIKE4xRjAWzn32m4AnH9AgFxfC+RuVohhLNz3EhPccyGsU/aADkmkTb4F/RkFjf
         jrxVwkxK6gg/4Jg7PH04AeWJg4IXrmxxEzR7KFWkCV4juEkbd0LDxpzu7u5hBPshJCPe
         T0gJj8lFrE+t2ZCkmr99EHOEffAdaWtoc3P3BDm8S970FiEv3kw+YSW6gRcydIiBQfx2
         1N8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/VLROJBYuLDdNAp4M2sx7oa2ZYyJWER5sXhuG/3iYEw=;
        b=3ayjVMA1PQoXX8E5PCxGV5pq2h1RSyc09vg86GfltV/UAnljEc3UjQ5q7P77TUhofS
         kUdNouVwzCQvWQ61qAyvrlOIDnAG0DgdjkRGs3HX+GBZqjz6Y6GjpbUKm6KXDL8D4Twf
         kwiovsmd5GehT1/7iclY8GFbhTKpwbT/BZcu1JkY/iC99TnoscxnTYYmYsDLtCTs7UDb
         bLiO+iK/dgSOPfEVHVMnkp72xDOCedov+lRxZ4M1nF/9sythHt62sRLeoSy8fIyxZMBh
         nb8H22Rj8yqMYxBDXsYuUN5RsNqqVlO3U5v1AF9B4tgFlXBEsLxmSiChF7/i4hZ3gZqB
         o/LQ==
X-Gm-Message-State: AOAM530oat9FQY/WzuGhnDCxaWdoSnwQ3YV8sTcdQEd7OjXGH8TZwk1e
        zcoNw8H+PqsN2nnBD2H2aUKilPygET6nLG8roRqojg==
X-Google-Smtp-Source: ABdhPJxfF11g+NiUJhU69r/kUXCaEWmehLJE/e9Ka69kjwLxsa2SFoZq9LkJ5kMyAu58je51UQRqPxMR05DZFQKxCEk=
X-Received: by 2002:a05:6902:2:b0:624:4cb5:fd3b with SMTP id
 l2-20020a056902000200b006244cb5fd3bmr30993410ybh.1.1646244972316; Wed, 02 Mar
 2022 10:16:12 -0800 (PST)
MIME-Version: 1.0
References: <20220302173122.11939-1-vbabka@suse.cz> <20220302173122.11939-2-vbabka@suse.cz>
 <Yh+tmJT0ov8uwC6/@elver.google.com> <4a1c1470-30d0-2a21-0c03-64ffa2fc54c5@suse.cz>
In-Reply-To: <4a1c1470-30d0-2a21-0c03-64ffa2fc54c5@suse.cz>
From:   Marco Elver <elver@google.com>
Date:   Wed, 2 Mar 2022 19:15:32 +0100
Message-ID: <CANpmjNO-HpLE43+jQeBC=YxMHDkaHjKrrBg1sUeCMQKPv3kE_w@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] lib/stackdepot: allow requesting early
 initialization dynamically
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        Oliver Glitta <glittao@gmail.com>,
        Faiyaz Mohammed <faiyazm@codeaurora.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Imran Khan <imran.f.khan@oracle.com>
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

On Wed, 2 Mar 2022 at 19:02, Vlastimil Babka <vbabka@suse.cz> wrote:
[...]
> > Similarly, for stack_depot_want_early_init, where instead you could
> > simply provide stack_depot_want_early_init() as a function, which simply
> > sets a boolean __stack_depot_want_early_init. If !STACKDEPOT, it'll also
> > just be a no-op function.
>
> Yeah, makes sense. I guess I have patch 3/6 wrong now anyway as with
> !STACKDEPOT it should fail linking due to missing stack_depot_want_early_init...

Right. It probably still worked because the compiler likely optimizes
out the dead call, but you never know...

> >> +bool stack_depot_want_early_init = false;
> >> +
> >
> > This can be __initdata, right?
>
> I initially thought so too, but in include/linux/init.h found
>  * Don't forget to initialize data not at file scope, i.e. within a function,
>  * as gcc otherwise puts the data into the bss section and not into the init
>  * section.
> But maybe that's just outdated as everyone seems to init them at file scope.

I think that comment is just about static variables inside functions?
Here it's at file scope, so that caveat shouldn't apply. As an aside,
you could omit '= false' because it'd zero-init by default.

Thanks,
-- Marco
