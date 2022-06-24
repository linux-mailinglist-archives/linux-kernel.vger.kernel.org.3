Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4300558F16
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 05:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiFXDay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 23:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbiFXDas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 23:30:48 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C2451E4B
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 20:30:47 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id m14so984852plg.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 20:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=e9j3ytzEFZdgs9pD00F5uMmUOICZVul5nelc96kxzOE=;
        b=V8QH6bcQSaB1wI4zt9W+joGhoSL9D14kaIndS2oCQDv1JFMHuyB/HFhnLbXu2nM0Kh
         C+qKsIed+RXY8Jq3WBcGLU1TuU6ICjFjc77KcZD8OjgvsbEckD/v2REMsuspSgNV59Dv
         weO09i6G31i/LgkkTX0D4en15QY2POIBgOSISPxk5DjSbvb0DGpfPMVAKl/KoRRKjmv3
         ULfj+GkjHp9KjIjypCJolaq3s6mPgW7Y0zoK/e8EvPxoeS1Sv75r5bbzYc1oK4eSICJ+
         vWZzJO8kOCM3WkaxEJUfblj7D5nMGNlT3A3m+b0czAJke1devYNkGdpc/SzD5/b6Olt0
         fkoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e9j3ytzEFZdgs9pD00F5uMmUOICZVul5nelc96kxzOE=;
        b=eUtnOm6OfoHSy6cwLYvocrz/8sjpVcCHDbVl5aHkZU+ow5jH0lDBfq7di9Qg6viZms
         IUL6cbOQHLT2EzR/rCkzeyyRfHrmoRL9vJHbjp+9huToNPw4EV7zgMi+qi4xbaZIFMWR
         3fa2aEqZ5BtlyE0b5bljA0ZQPIqqvZIO4qkC3AZ9N+qDprgQxzhx5uJEIjChuO2hl0eH
         yXp6Zr9MOGLKkqRy2Kddh3Kj8mZD9sCnqJUpJQEXQJpYd8nV2w7xPexPOYhIJwrtfzcU
         PBIjweh1HFOqqltB0FRbTRV7JzvOCNeLfHGd6lGUsLPztk7LDUdW5Bzbj8B/myLshUNJ
         ZKJg==
X-Gm-Message-State: AJIora+w6KI8LwpcM1wKiWF+oUtaEUrShwS6yFSkvCmF15dsFhAXtbts
        nYrq9HDNJJXc0ObMY8/gzIU9JCgizcDG+g==
X-Google-Smtp-Source: AGRyM1tgrOTNFUC2591jNk+wk5DSFaCUCQEYkk5RDxnX6oNB8da3t81P1mGggF1g+qf9M7rvM1hSDg==
X-Received: by 2002:a17:902:db11:b0:16a:567f:12aa with SMTP id m17-20020a170902db1100b0016a567f12aamr7169946plx.172.1656041446820;
        Thu, 23 Jun 2022 20:30:46 -0700 (PDT)
Received: from localhost (c-67-180-87-133.hsd1.ca.comcast.net. [67.180.87.133])
        by smtp.gmail.com with ESMTPSA id h15-20020a170902680f00b00161e50e2245sm550462plk.178.2022.06.23.20.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 20:30:46 -0700 (PDT)
Date:   Thu, 23 Jun 2022 20:30:30 -0700
From:   Chang Yu <marcus.yu.56@gmail.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     'Philipp Hortmann' <philipp.g.hortmann@gmail.com>,
        "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: r8188eu: combine nested if statements into one
Message-ID: <YrUv1sPuny1M1Orh@zephyrus-g14.localdomain>
References: <20220623031515.402691-1-marcus.yu.56@gmail.com>
 <d50c16c1-0bc2-fdc4-16ab-0c27df824ffb@gmail.com>
 <06893216a5a04d7e84dfe3e132d333f6@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06893216a5a04d7e84dfe3e132d333f6@AcuMS.aculab.com>
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,EXCUSE_4,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 12:05:40PM +0000, David Laight wrote:
> ...
> > Seems to work. But the rules which operation is done first && or == are
> > not too easy.
> 
> They are the way around you want them to be.
> == generates a truth value.
> && and || compare truth values,
> 
> The only 'wrong' operator priorities are & and |.
> The short-circuiting && and || weren't in the very early
> versions of C - the bitwise & and | were used.
> When K&R added && and || they left the priorities of & an | alone.
> I they they've later said they should have bitten the bullet
> and changed the priorities and all the existing C code
> 
> > I would prefer to have:
> > 
> > if (padapter && (pfree_recv_queue == free_recv_queue))
> > 
> > So it is very easy to read what is evaluated first.
> 
> That just starts adding too many () and makes more complex
> conditionals hard to read.
> 
> 	David
> 
> > 
> > But this is just my opinion and does not have to be right.
> > 
> > Thanks for your patch.
> > 
> > Bye Philipp
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)

In my humble opinion it just boils down to personal preference in this
case. The kernel coding style guidlines don't seem to have a definitive
gold standard regarding this. I will leave the patch as-is for now, but
if anybody feels strongly that the () needs to be removed please feel
free to let me know and I'll make the change.
