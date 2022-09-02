Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7F75AB78B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 19:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237107AbiIBR2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 13:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237089AbiIBR2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 13:28:36 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FDFBD75AE
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 10:28:32 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id y29so2601619pfq.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 10:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=KFNnGC2cvtFaF/K+nfKIMIDR7T43wT0YbieooabzRXA=;
        b=MfnMsa7bwax5l49IFWWcAfdzO1d8+cY5Y5/oeEQmJqfTTp2eQf2A0lBcBIny66F8y3
         Cv6+NtmjY/NZkWIFYp6GQ0Ze3G3OZi4dr1TnkfsIgTjUST0tR/usVW0+/vXztWhl+GBR
         uPH044oR/rxlVme+HuDxOV/+SuKwgQjIg6bl7pcFG0zgpa4VhupKqR/dOZMp+ln6AV6J
         enhppVTQpmRSLmjrOyN6aK2VUZ5J3DcljcBiRQBjvdGVy7KvoL0IiruZl652Fb24Qj2a
         nX+s/9w/D6klvsG4VYHdv2Z4Mb0pSem+OUkprrw403wU4YgN9V8BSF/nRs9gfF0qHQxe
         h6cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=KFNnGC2cvtFaF/K+nfKIMIDR7T43wT0YbieooabzRXA=;
        b=pc7kHyQNjmvxLNG+282eHLRxx1Zglb4qV9C0w/dJxavO2jHyhtjh+c5YiCK3XgYSKG
         cQ3bOmON6/rM2Q0y75yFTRE5OYd/tRC4dC+f4vqlOiEfBoM1ZLjvoTfQw944THUPbrwi
         5OEsP19y8h6qRc8IBqb6sNMbWkqU/+bis9qakGZwoZ2iadAb4J7UFNyhTJxcJJErx4YW
         LfAgTWzGXTtl6qOgCaxI/o9XlF7lsHeN/BD5u6Q+CLmGrMrRXrEgTo3XP/6a/D/ciK9/
         Ef186HVbdFprgoDSOwY6yRhfUm4cZb+U0Z5DaHCOOfGa6Z3ksqjeswBHGHLPapCuB2Gh
         TnIA==
X-Gm-Message-State: ACgBeo2icZVFOiDUIRpU+8IjeZa6LsCvDX87dCjAXuoz3BmeXXxtJD6M
        D2H8AZby9P+xqYYwKmGeZDc=
X-Google-Smtp-Source: AA6agR6OA2dcieafkQySDHOEQBPo58v6Kj0Ob5AkV8IcH1H4nimMGGXC6SA80zrLh4WpqcKrJNFUJQ==
X-Received: by 2002:a63:1725:0:b0:42b:4300:358 with SMTP id x37-20020a631725000000b0042b43000358mr31857828pgl.536.1662139711752;
        Fri, 02 Sep 2022 10:28:31 -0700 (PDT)
Received: from gmail.com ([2601:600:8500:5f14:d627:c51e:516e:a105])
        by smtp.gmail.com with ESMTPSA id z188-20020a6233c5000000b00536aa488062sm2062877pfz.163.2022.09.02.10.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 10:28:31 -0700 (PDT)
Date:   Fri, 2 Sep 2022 10:28:29 -0700
From:   Andrei Vagin <avagin@gmail.com>
To:     Alexey Izbyshev <izbyshev@ispras.ru>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Florian Weimer <fweimer@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: Potentially undesirable interactions between vfork() and time
 namespaces
Message-ID: <YxI9PbdWsCmJe1Pz@gmail.com>
References: <YxAq2jYvGG8QOypu@gmail.com>
 <87czcfhsme.fsf@email.froward.int.ebiederm.org>
 <bdff6cf478fc29c80997a623a57dae5f@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <bdff6cf478fc29c80997a623a57dae5f@ispras.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 08:01:57PM +0300, Alexey Izbyshev wrote:
> On 2022-09-01 21:11, Eric W. Biederman wrote:

<snip>

> >  static int check_setns_flags(unsigned long flags)
> >  {
> >  	if (!flags || (flags & ~(CLONE_NEWNS | CLONE_NEWUTS | CLONE_NEWIPC |
> > 
> > 
> > 
> > To keep things from being too confusing it probably makes sense to
> > rename the nsproxy variable from time_ns_for_children to
> > time_ns_for_new_mm.  Likewise timens_on_fork can be renamed
> > timens_on_new_mm.
> > 
> Do you imply renaming "/proc/[pid]/ns/time_for_children" as well, or will it
> be preserved for compatibility?

I don't think this is possible. It is used by a few tools already.

