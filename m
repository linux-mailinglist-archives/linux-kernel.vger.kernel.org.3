Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2294DACDA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 09:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354640AbiCPIv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 04:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235424AbiCPIvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 04:51:55 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF9064BD2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 01:50:41 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id u3so3155613ybh.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 01:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bg/byEWlTWIwifYckEgQwSgSeHn+FEnQHWnGn7POTSs=;
        b=KfoJ64Qqg382BsKMbnA/sTahOKPrspF5pI84AyTYRRs+Defudw6y1KfA+aloBCFx3Q
         aLYxCaA64PlAMKcVvhL0vAi38YRho9oahm15F31M51Kbug6TRYtp/mTueY8xertFLrHY
         IzRWzhVbvhosIv0oaayfcrbYhzmo0VCvURHtNXvdbzWyEuKre4yCsF4FxKe2hFNwDr88
         bMADaAjIKaQ6Ge4zfHuNf4KdgDeSRD5+2P644B+W95jWl5R3OPGkGXqAkfs4KS1KOlX9
         eOE80pZBJpa82+6AG1pJoFktg4wZiEzyxZ1b4D528N3ZaXEc2lU3ZQqj8hVyRgmQVoRj
         JqnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bg/byEWlTWIwifYckEgQwSgSeHn+FEnQHWnGn7POTSs=;
        b=7Up7j+ez3lTWLGhPgtQkopte3VTbhNT68iB+7/2hs9carDlK29r3rB8+0tq7TR6vba
         9aYtywhoQxkKF3aN98jEROiJzxHQe4+ALB/sAjYSQd3i4o31Stq6T6TKxRfgdKRV+qnX
         UzvnAkZvTP/37htVLod0zNfIR3Lh9/jUbVOwNmKcSllyGe38HL/1LeiRpeDDSfPSNkls
         6aLGdmlT4DYZtXTs8W0AfKiumYlype2NSxFj8U6dkiwINRNuC6UF33dH7dmwU2qXXlv5
         2o5CAOQNCMKUE6yqh54KHQmACgHebxDV8smdi+CdF7oQPY5QITt9Vp7G5E987i+clqLU
         9pqw==
X-Gm-Message-State: AOAM53148u7c2FseZ3cpO8uzjvFFXvLgbS8uvOobR18zeccRK0aeCbkR
        zW3FjgfNshq65fp6FNfnQvyt71ByiCzz1siCsy2/cg==
X-Google-Smtp-Source: ABdhPJzQXBkBdb0q5ntMDsNA/5LETFJLW66NOMZ828aO4vfYyl/rSAPR7nDThocO00eKUQ5R8NI3oXwVIOf7j4K6dl0=
X-Received: by 2002:a25:dc4:0:b0:629:2337:f9ea with SMTP id
 187-20020a250dc4000000b006292337f9eamr27008652ybn.6.1647420641261; Wed, 16
 Mar 2022 01:50:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220316031602.377452-1-luofei@unicloud.com>
In-Reply-To: <20220316031602.377452-1-luofei@unicloud.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 16 Mar 2022 16:48:51 +0800
Message-ID: <CAMZfGtVi7zOM7pdj1rv1OY2VyOpKQU45YFjM4KqMEQn=KGHq3w@mail.gmail.com>
Subject: Re: [PATCH v2] hugetlb: Fix comments about avoiding atomic allocation
 of vmemmap pages
To:     luofei <luofei@unicloud.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 11:16 AM luofei <luofei@unicloud.com> wrote:
>
> Since there is no longer an atomic allocation of vmemmap pages,
> but a fixed flag(GFP_KERNEL | __GFP_NORETRY | __GFP_THISNODE) is
> used. The description of atomicity here is some what inappropriate.
>
> And the atomic parameter naming of update_and_free_page() may
> be misleading, add a comment here.
>
> Signed-off-by: luofei <luofei@unicloud.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
