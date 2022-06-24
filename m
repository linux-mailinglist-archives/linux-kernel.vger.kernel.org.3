Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99402559288
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 07:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiFXFwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 01:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiFXFwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 01:52:34 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CDA699AF
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 22:52:33 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id l6so1187579plg.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 22:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kS7je0dcRsUISdffSoxUviDsBXhqWD5R3EEaLG3WV4Y=;
        b=q8IkDnvh1Cu3hw8WQYu1Y0x7SAeul3kp00HcnhJ9OSTsHmoxPT4uZMfLUY0bxIMXku
         iT7LFJXWL78mzzuibDp5ul57Dad5Ka2v5ZV2DNYvSOEMsDCn520Wk31ZdpIGGdz9Kir4
         8jBt4D7ZGZg4XF6QqTxAiRh7fPI6N+pq42/3fCKhlRoIl2twJtMFKC6VrUvCwITDur2U
         5kFErN8MO5ZUdc+PO5hb999jXs3VHrPedfXuLAAb3tpdADbsqESXRIt22OmHH/5Y7xtc
         tdQn6hD1jF4GPRsRlIw8bLKu3nNOqU89sFC3Be2oVC1fLCxLj6iQeNHYMOijqYF2zdxY
         knjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kS7je0dcRsUISdffSoxUviDsBXhqWD5R3EEaLG3WV4Y=;
        b=ogTlP0OabvvjIKa1+zK93Gdni3sHxrbcxcK3QstU5YD4obgZEh4PCcY33vixiwTyyV
         cqxqUAbPqXatot5vAjGY/ZWVn65UwEca9erJad0e4lOD8zyqm6DEK1BnHxrlae3c6/HH
         e2fVxyTObKOjYwVLkAF18ZRjBsRKT8DTBg2jFlH02taHfd6AW0amMvKLaJqYpuQ3JHa9
         MEJOrVWWyRNgfj5G1h8zRZ1sjr1pQQwOqQnc+MqT9tXtP+eT9e5Pd8/ZT0pJHsIPxRex
         xggP6Q4j4gAWnhCn39za8stbbLbg6sVBS0Hp6mXAEajj6r7XJAmlsyxeIs8P1Yh3eZUD
         nC+w==
X-Gm-Message-State: AJIora8MZsdlX0V5SBWeNNxI47U6PFWL+sXXXG8dCQ2xh0IyZwKRqDdK
        Gh0OXc00LpHLhuEpqIRJXKs=
X-Google-Smtp-Source: AGRyM1uwB431JlIyYgxTLIL3PTdW9faGO5ffqUvlZQEe8IPe1X/DHig9tf1kdbxdj0AUXA6S96w1NA==
X-Received: by 2002:a17:90b:794:b0:1ec:c760:5736 with SMTP id l20-20020a17090b079400b001ecc7605736mr1954563pjz.241.1656049952989;
        Thu, 23 Jun 2022 22:52:32 -0700 (PDT)
Received: from localhost (c-67-180-87-133.hsd1.ca.comcast.net. [67.180.87.133])
        by smtp.gmail.com with ESMTPSA id s17-20020a170903215100b0016a4ca6516dsm126589ple.278.2022.06.23.22.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 22:52:32 -0700 (PDT)
Date:   Thu, 23 Jun 2022 22:52:14 -0700
From:   Chang Yu <marcus.yu.56@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Greg KH <greg@kroah.com>, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: r8188eu: combine nested if statements into
 one
Message-ID: <YrVRDilTaAIVkpwV@zephyrus-g14.localdomain>
References: <20220623031515.402691-1-marcus.yu.56@gmail.com>
 <20220623051404.410632-1-marcus.yu.56@gmail.com>
 <YrQ2Izg1b399yJou@kroah.com>
 <YrUw3lejTP0UyWmt@zephyrus-g14.localdomain>
 <20220624053930.GU16517@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624053930.GU16517@kadam>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2022 at 08:39:30AM +0300, Dan Carpenter wrote:
> On Thu, Jun 23, 2022 at 08:34:54PM -0700, Chang Yu wrote:
> > > - You did not specify a description of why the patch is needed,
> >
> > I'm not entirely sure how to fix this. I checked the original patch
> > again and the subject and the body looks OK to me. I'm still a newbie so
> > I might have missed a couple of things. It would be greatly appreciated
> > if someone could point out what's missing.
> 
> What's the advantage of combining if statements?  Out of all the if
> statements in the kernel why did you pick that one?  Probably it's
> because the indenting was wrong, no?
> 
> Write the commit message like this:
> 
> [PATCH v3] staging: r8188eu: clean up if statement
> 
> I noticed that the if statement was strange and the code was indented
> too far.  It is cleaner to combine both if statements as well.
> 
> regards,
> dan carpenter

Understood. Thank you for pointing this out to me. I didn't realize the
description was too general. I simply assumed that the reason for
combining if statements is obvious and did not elaborate. I see now this
is not the right assumption to make. I will revise the patch shortly.

Thank you!

Best,
Chang
