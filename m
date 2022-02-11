Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED744B2E04
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 20:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353000AbiBKTth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 14:49:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240391AbiBKTtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 14:49:36 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FABB2A1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 11:49:35 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id s1so9996052qtw.9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 11:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=3K4p9cidMn/Tx0W9hJAw8Kq8LAoL7UjCy3S5gzxmolE=;
        b=PvH+JCsjOQGyqhEmnNNNCc22Ki5ciMZNdyKZyQKikNJuYLPiYccjhmd5HhonZv9HNn
         Hd7wGtPTw7piYrgeRxB3mNDdfdFZ6WDzEsmInYQaeljM9qV3EblHxhkfRCeJyQHE0FQw
         C+sXieo5s6TnitSnyNHkVBIRGywkvVs90vNEUQYDT3j5y23fc5a1sufwdegkSemVkLrE
         7uB78csEC0ko/vn+ZE4nXo17Kmq7tE+5cptWq2JC1wReE3gJ6NrXQJSg6Pajdv10jht3
         5Fb8ePXc2gqTHAhJGUQnQg0MBWXEqxsg1mz5nB+SJkFAaY6TqgQLs6L3Xn3eO/7iyRwZ
         mQ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=3K4p9cidMn/Tx0W9hJAw8Kq8LAoL7UjCy3S5gzxmolE=;
        b=L+02tjJIzsX3wTlqBPANBHwRVe6Vhn/9hSD90Ksso8pkUPEdtXE6RRAOkI+6VGYqvi
         ikwdztC0o59+KBe3Ek48A5ydLcHdTMsys5bKmmbhogpn7uPB1h3QyoYqtZW7gAIXAFDX
         iRk2EY96XQ9CSbYQ4qyba3vsin22oAp8NC8q0Smm52jNUyQ0IRK4btT5LH4+DD0/CAGT
         i+9SQBUamlXLYSt4jZvkmvm5ps6tvZF0cRXez7LEtlRvqxiNnrbRUH7jQAJYwwJqvGJ/
         MQaA122TrUBsTHRipj0XbC9CW/QhaToP/FN1jt3jb4O735mWG7zr3TLXqJWakKNldJ/3
         Ufcw==
X-Gm-Message-State: AOAM533CRnJL0JXMiXQKIayLax3A+NRqPb8ziMIbHdRSepmOebsNLzcd
        LOFa3c1wV+437IkUeINRelY=
X-Google-Smtp-Source: ABdhPJziBtRDpl6yACPTwvrPogi70gIB0RmsJdkVTACwFY44039RHw45fPR+zzzKuY/eitDM9E709A==
X-Received: by 2002:a05:622a:15ce:: with SMTP id d14mr2322417qty.330.1644608974275;
        Fri, 11 Feb 2022 11:49:34 -0800 (PST)
Received: from localhost ([12.28.44.171])
        by smtp.gmail.com with ESMTPSA id bj19sm8919070qkb.109.2022.02.11.11.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 11:49:33 -0800 (PST)
Date:   Fri, 11 Feb 2022 11:47:22 -0800
From:   Yury Norov <yury.norov@gmail.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Larry Woodman <lwoodman@redhat.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 46/49] mm/mempolicy: replace nodes_weight with
 nodes_weight_eq
Message-ID: <Yga9SgUk07Fn7Upx@yury-laptop>
References: <20220210224933.379149-1-yury.norov@gmail.com>
 <20220210224933.379149-47-yury.norov@gmail.com>
 <65ab6b3e-82b4-0a4e-bd6e-5869f735a8f7@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <65ab6b3e-82b4-0a4e-bd6e-5869f735a8f7@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 + Larry Woodman <lwoodman@redhat.com>

On Fri, Feb 11, 2022 at 06:44:39PM +0100, Christophe JAILLET wrote:
> Le 10/02/2022 à 23:49, Yury Norov a écrit :
> > do_migrate_pages() calls nodes_weight() to compare the weight
> > of nodemask with a given number. We can do it more efficiently with
> > nodes_weight_eq() because conditional nodes_weight() may stop
> > traversing the nodemask earlier, as soon as condition is (or is not)
> > met.
> > 
> > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> > ---
> >   mm/mempolicy.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > index 7c852793d9e8..56efd00b1b6e 100644
> > --- a/mm/mempolicy.c
> > +++ b/mm/mempolicy.c
> > @@ -1154,7 +1154,7 @@ int do_migrate_pages(struct mm_struct *mm, const nodemask_t *from,
> >   			 *          [0-7] - > [3,4,5] moves only 0,1,2,6,7.
> >   			 */
> > -			if ((nodes_weight(*from) != nodes_weight(*to)) &&
> > +			if (!nodes_weight_eq(*from, nodes_weight(*to)) &&
> >   						(node_isset(s, *to)))
> 
> Hi,
> 
> I've not looked in details, but would it make sense to hoist the
> "(nodes_weight(*from) != nodes_weight(*to))" test out of the
> for_each_node_mask() to compute it only once?
> 
> 'from' and 'to' look unmodified in the loop.

It seems that 'from' and 'to' are untouched in the outer while()
loop as well, so we can compare weights of nodemaps only once at the
beginning.

Larry, can you please comment on that?

Thanks,
Yury
