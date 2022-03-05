Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561924CE245
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 03:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbiCECaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 21:30:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiCEC35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 21:29:57 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6CD54F9C
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 18:29:08 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id s6so5651235qtc.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 18:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=Hbm5TQmw1l7ulFWRyo3PHqo3g4u481T5gjdYr0TUKCE=;
        b=AkMbkY1eAnNbHGBkJymyFX3/nVr8dWYsyjBZHMm57+Uz14pt9E+foHVje2wkScfWZ1
         sFd1/4MrHiCMeA3VZaJ+mNY21yj9hVY62p1c7EHoHpELnHSJ43T+coUtbncZZZjXgrQf
         MnIxg1LeCQ+GBo0Kp9XuFJ3weTzYffVMxSsIT1MNzDni3nQ3gksyWMALlSckh3NF0fZV
         hNcHIg82bWugN0GGk67XeXw7L9zt5I137Wd1cvyWGcPm2JBqbFrwPYto657CNRIDJOR7
         Gr5Uf+kbKwUujOhOjp2/ENpvEe/9EO9Q529LzAEiLATuRwxYdwFZweHPtnq8PQzwvlJP
         ED6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=Hbm5TQmw1l7ulFWRyo3PHqo3g4u481T5gjdYr0TUKCE=;
        b=GKpCDxP91LZQJOKcFDKNUM3JsOecbSuj0bTMEVt66j751omOVrcZSzYr1dnE9ySQJD
         Mgnv9YUmZR4KCaj+dVGG5vRE7UUfDMj1CmBgISiLL6461DA4qLUTk0kVqbfe6pCC5AFC
         wYDrQhXuPYd/IJJUspLiSSMUp6Dy7k8kTZ6X27cyz5Xif4GudJQOmllng/UmmmgRWKrK
         jIRA5dTQpEc8nEeZOphInQfWG1etIbASif7Zx/Ki0K6Sb2J/AQg45eEwjBedV08Avdu4
         EmTkG7rrjioYMPN/86sW22FNhNp3EJhUDcYvBEGday1YvEedFrjesy1hhCfNYozbYc9Q
         fr3A==
X-Gm-Message-State: AOAM532ZeteC7f3v0vy9o9DarG90YtmxY4ApueZJcn7WE1BY0AdkQNH8
        Iudxbr8YOpqZ7vJT5if6Zeqq0+62CJ252w==
X-Google-Smtp-Source: ABdhPJy7j8smbdmCLE5IwuCz3JExPO+cf+fzfc6lOzHcmAlL51rTdMqWIu+iRWD0iKA1Z6TI1+xcMg==
X-Received: by 2002:ac8:5c14:0:b0:2de:2b69:dae7 with SMTP id i20-20020ac85c14000000b002de2b69dae7mr1436589qti.185.1646447347043;
        Fri, 04 Mar 2022 18:29:07 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id v14-20020a05622a014e00b002cf75f5b11esm4508896qtw.64.2022.03.04.18.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 18:29:06 -0800 (PST)
Date:   Fri, 4 Mar 2022 18:28:39 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Liam Howlett <liam.howlett@oracle.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH mmotm] mempolicy: mbind_range() set_policy() after
 vma_merge()
In-Reply-To: <20220305020021.qmwg5dkham4lyz6v@revolver>
Message-ID: <29eac73-4f94-1688-3834-8bd6687a18@google.com>
References: <319e4db9-64ae-4bca-92f0-ade85d342ff@google.com> <20220304184927.vkq6ewn6uqtcesma@revolver> <20220304190531.6giqbnnaka4xhovx@revolver> <6038ebc2-bc88-497d-a3f3-5936726fb023@google.com> <20220305020021.qmwg5dkham4lyz6v@revolver>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Sat, 5 Mar 2022, Liam Howlett wrote:
> * Hugh Dickins <hughd@google.com> [220304 17:48]:
> > On Fri, 4 Mar 2022, Liam Howlett wrote:
> > > * Liam R. Howlett <Liam.Howlett@Oracle.com> [220304 13:49]:
> > > > * Hugh Dickins <hughd@google.com> [220303 23:36]:
> > > 
> > > I just thought of something after my initial email
> > > 
> > > How does the ->set_policy() requirement on tmpfs play out for the
> > > mpol_equal() check earlier in that for loop?
> > 
> > It took me a while to page all this back in (and remind myself of
> > what is case 8) to answer that question!
> > 
> > The answer is that the mpol_equal() check at the top of the loop is on
> > an existing, unmodified vma; so it's right to assume that any necessary
> > set_policy() has already been done.
> > 
> > Whereas the mpol_equal() check being removed in this patch, is being
> > done on a vma which may have just been extended to cover a greater range:
> > so although the relevant set_policy() may have already been done on a part
> > of its range, there is now another part which needs the policy applied.
> 
> Doesn't the policy get checked during vma_merge()?  Specifically the
> mpol_equal(policy, vma_policy(next)) check?

Sorry, I'm reduced to the unhelpful reply of "Yes. So?"

If vma_merge() finds that vma's new_pol allows it to be merged with prev,
that still requires mbind_range() (or its call to vma_replace_policy())
to set_policy() on prev (now assigned to vma), to apply that new_pol to
the extension of prev - vma_merge() would have checked mpol_equal(),
but would not have done the set_policy().

Hugh
