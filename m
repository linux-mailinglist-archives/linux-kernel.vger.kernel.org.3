Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498EF4B2E5F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 21:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353190AbiBKUXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 15:23:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239383AbiBKUXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 15:23:49 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF68CEF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 12:23:47 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id m14so17028127wrg.12
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 12:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8izYpAp0ve1Um+PioYMF8NHyi8GfcoeiooycSXLzNlQ=;
        b=I/a5ILnFm19npYvV0MgKSrdQNRMdeM7AsECxiPFtJmArjKyJMMXwRX3yXD6yV/FEMe
         GbttCWd1S2BKgZ3Cot3Bf1rB3bhkyRAairl9L+kUP+36lUVnVA9VAe9JLK8eXr4xMA+d
         cjySH0rYpqG/UCldQPwqHDY0tob8VdzyzaOYD0X5zHeN/FkHpMahugnUadLchbNNXcjQ
         O+NngfZ5EDoFnnSqrr8TYNLgqVX9SqGCqaemmrRcf5JPmoa3AflDohnSoTGV6FPQHhEH
         AqiBvV5iALcj9R8GJ/NzIxU0c0oTImpsdCoaT2uL6T/qTxu7XHBvWZ/hZiu2ZKpcoDFR
         RKsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8izYpAp0ve1Um+PioYMF8NHyi8GfcoeiooycSXLzNlQ=;
        b=JiM5HvSH+kI7eLJVSfjEj+J7lUdVWbdBwALjfF+kGIv4itf6bBEYEws+LYWrirsptq
         DIXjyi5ZLlnfZaNrQ8yjkqGFlPHn1JJzXJu8h8sE0RMQ28QbKMM786S+lrETFden5+N7
         WP9I0Vw740JC0sIntYyeeCXGiY2MIkRGS3gr6zVugXY6yp4RzNE7HLiEoBlvS5JL33EF
         uSBGl1rYAs+PSRaknuxCzC6xWSrqQP9/akBhr4aZfhg5t2lJlAM3H9UNVLxTdGYSVG/V
         bJAPE70IbgIau5YBIvjUfUimR4f7BR8sQTgQk6J4LAYv12xFTYAKYAIcK4/zM4xkrBy6
         ss4A==
X-Gm-Message-State: AOAM530Qi3AUTP/XjCRyBFL30ilQD6pUEDvxKbn5CdjGbZyWBYXV/i3I
        AygVWg7dMTPVUTtIwVJpYlSLn3yL6zB/qbLyiLjykw==
X-Google-Smtp-Source: ABdhPJx66KThSmTSEZR8qZK1Jjh71AOqaHCEfACAY2nq31QRfSld2Jm3y2Y9sAr+4rAIRTfMAFl1q7RC0n5rTroRhNc=
X-Received: by 2002:adf:f18f:: with SMTP id h15mr2667871wro.513.1644611025895;
 Fri, 11 Feb 2022 12:23:45 -0800 (PST)
MIME-Version: 1.0
References: <CAPcxDJ7nriZEJHF6dMPR7tQ+dGuueyRjw1NC+4CbjxiAT_S+ZA@mail.gmail.com>
 <20220208150945.266978-1-juew@google.com> <CAPcxDJ7iHshyZdCp9ngrfFV4j2=HTvXF5naN+E+D_AvcH8n4wg@mail.gmail.com>
 <YgbEeFKdtrY+9d/x@zn.tnic>
In-Reply-To: <YgbEeFKdtrY+9d/x@zn.tnic>
From:   Jue Wang <juew@google.com>
Date:   Fri, 11 Feb 2022 12:23:34 -0800
Message-ID: <CAPcxDJ4Lo7EdEc-Hq3nWJtoee5AfJuVQtgCtQOUFaKbmeNP+sA@mail.gmail.com>
Subject: Re: [PATCH] x86/mce: Add workaround for SKX/CLX/CPX spurious machine checks
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
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

My apologies, I will wait. :-)


Thanks,
-Jue

On Fri, Feb 11, 2022 at 12:18 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Feb 11, 2022 at 12:08:46PM -0800, Jue Wang wrote:
> > Tony and Borislav,
> >
> > Gently ping?
>
> From: Documentation/process/submitting-patches.rst
>
> Don't get discouraged - or impatient
> ------------------------------------
>
> After you have submitted your change, be patient and wait.  Reviewers are
> busy people and may not get to your patch right away.
>
> Once upon a time, patches used to disappear into the void without comment,
> but the development process works more smoothly than that now.  You should
> receive comments within a week or so; if that does not happen, make sure
> that you have sent your patches to the right place.  Wait for a minimum of
> one week before resubmitting or pinging reviewers - possibly longer during
> busy times like merge windows.
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
