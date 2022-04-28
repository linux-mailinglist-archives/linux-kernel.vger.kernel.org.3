Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50ED3513AC5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 19:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344074AbiD1RZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 13:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343684AbiD1RZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 13:25:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B341D5BD39
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 10:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651166526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5zUbyOsP3xAYJ4at2YNe/KyTjVNVtkCIzWhlQOjPf5A=;
        b=MPlLuheoUQccDAODuh4E7ykCMUSGI+QfQuXz1W4S8UzRva2EapiV2UrUAg9Nbx5syG4Z1o
        87ULHvoewA06xAJUWjgXO7W+Jun2C4OqiZp6f6bGEXCQ2WlQDb4yzGsA9aawVXjiJD7y1U
        /ngdHjGgpceCT5YNZFtzP0z/nOpwDtc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-500-Z9aZ-t-uNSerjpPNlvIeHQ-1; Thu, 28 Apr 2022 13:22:04 -0400
X-MC-Unique: Z9aZ-t-uNSerjpPNlvIeHQ-1
Received: by mail-wm1-f70.google.com with SMTP id m124-20020a1c2682000000b00393fcd2722dso1786163wmm.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 10:22:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5zUbyOsP3xAYJ4at2YNe/KyTjVNVtkCIzWhlQOjPf5A=;
        b=cI4N4cIfMosAomLRiheBvqciDXpSVsAykJnSdExIBvczOurDbqG0kU7xnBbfGWHECk
         N2LV6inxMAqGgt6OopCxuszUpEbM9PGxJWxevxE6yjrJ7+Keuc5nJXU7VvE7X8HbZBcb
         +iaVutlj+ZH1LrMkHrm3ytt38s2kJzg75JTHgLOckg0MMNfnZFl/oy7WrxErrlfzcqGT
         inl6IwQ3yNNhk2d64jjj+62L6uN/3unk0H/Aqxrmj4Jnewa2kX7T162LNhRd0QLc0s6x
         CDaojoiPfDJvbM9aaD+9Sp9qM4i1NoDViC4jj4WOrbTOhht38lVsQG09k8DSntMmgWLE
         gRjg==
X-Gm-Message-State: AOAM5336gwglg4j48AguasnFum55M4a0VAw2OO4wN8qMC39ls80zuaLt
        /Z5/ieUhcEpjqOL0dy44kjoAjEg/XwmAgUY854Ka+8CnLQdAue9qGEVvyKxHCkuPh6RyLrd7I5Q
        pCAJFiW3nnl0W2tv/Fx+yXbyzhGCfJ4WMQGhy5eZE
X-Received: by 2002:a7b:cbc1:0:b0:38e:7c42:fe38 with SMTP id n1-20020a7bcbc1000000b0038e7c42fe38mr42293404wmi.51.1651166523723;
        Thu, 28 Apr 2022 10:22:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy1WHHnyNchm0evBJjli2hIERYWmATR8AuMBS2O4OAvhOhqFZ1txvtVXuGj6QuHPITPFTOhS7Tb7HCQXbPNXho=
X-Received: by 2002:a7b:cbc1:0:b0:38e:7c42:fe38 with SMTP id
 n1-20020a7bcbc1000000b0038e7c42fe38mr42293394wmi.51.1651166523551; Thu, 28
 Apr 2022 10:22:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220426145445.2282274-1-agruenba@redhat.com> <CAHk-=wi7o+fHYBTuCQQdHD112YHQtO21Y3+wxNYypjdo8feKFg@mail.gmail.com>
 <CAHc6FU48681X8aUK+g7UUN7q5b6rkVBzTP7h_zbE4XqZYAiw3g@mail.gmail.com>
 <CAHk-=wjMB1-xCOCBtsSMmQuFV9G+vNyCY1O_LsoqOd=0QS4yYg@mail.gmail.com>
 <CAHc6FU5Bag5W2t79+WzUq=NibtEF+7z6=jyNCkLMMp9Yqvpmqw@mail.gmail.com>
 <CAHk-=whaz-g_nOOoo8RRiWNjnv2R+h6_xk2F1J4TuSRxk1MtLw@mail.gmail.com>
 <CAHc6FU5654k7QBU97g_Ubj8cJEWuA_bXPuXOPpBBYoXVPMJG=g@mail.gmail.com>
 <CAHk-=wgSYSNc5sF2EVxhjbSc+c4LTs90aYaK2wavNd_m2bUkGg@mail.gmail.com>
 <CAHc6FU69E4ke4Xg3zQ2MqjLbfM65D9ZajdY5MRDLN0azZOGmVQ@mail.gmail.com>
 <CAHk-=whQxvMvty8SjiGMh+gM4VmCYvqn6EAwmrDXJaHT2Aa+UA@mail.gmail.com>
 <CAHk-=wicJdoCjPLu7FhaErr6Z3UaW820U2b+F-8P4qwSFUZ0mg@mail.gmail.com>
 <CAHc6FU7GkXLkns5PONLvsSi6HB+rjaNSyFeQFS034tKL-JueMw@mail.gmail.com>
 <CAHk-=wg4ypnZUA5BOHAF1miKvOhW2yQSruuBKNXMDR=dTmp+ww@mail.gmail.com> <CAHk-=wiF8D6Bs2m8y85XpHU__c4XD1yFV9JXx9FuTqoge+-yhg@mail.gmail.com>
In-Reply-To: <CAHk-=wiF8D6Bs2m8y85XpHU__c4XD1yFV9JXx9FuTqoge+-yhg@mail.gmail.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Thu, 28 Apr 2022 19:21:52 +0200
Message-ID: <CAHc6FU5Et7bh7zOQTSqBjmRAdB3Hibk8xwXG_YVs_VRXVh8iFA@mail.gmail.com>
Subject: Re: [GIT PULL] gfs2 fix
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     cluster-devel <cluster-devel@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 7:17 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Thu, Apr 28, 2022 at 10:09 AM Linus Torvalds <torvalds@linux-foundation.org> wrote:
> >
> > I'll look at that copy_page_to_iter_iovec() some more regardless, but
> > doing that "let's double-check it's not somethign else" would be good.
>
> Oh, and as I do that, it strikes me: What platform do you see the problem on?
>
> Because the code for that function is very different if HIGHMEM is
> enabled, so if you see this on x86-32 but not x86-64, for example,
> that is relevant.
>
> I *assume* nobody uses x86-32 any more, but just checking...

This is on x86_64.

Andreas

