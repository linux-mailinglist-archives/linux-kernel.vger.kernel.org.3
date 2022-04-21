Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA5E250A623
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 18:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbiDUQug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 12:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232298AbiDUQue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 12:50:34 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6926F4927B
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 09:47:44 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id q12so5100651pgj.13
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 09:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZZTjvHZCe7fz2iM0dCm7xDiOZP2+Yg+RhUYKbP1pg4E=;
        b=CN4DkTx+fy+8Q+qy9vSRiJeXfx+O2qRG1oRmJqlsu9zGzoTUSbB0RQwJgysQQqyZ8R
         jYV5N7pXW/POmjVp+1UKc15BsxS2W8WgJ5mY98vzyjoZXFnc9h1nF6ThDP9+PlN0Q0yG
         HXpRJUuHslXrFgfwaRyZgsmYGc5wB7rDf5s+GhiJCM30snDRKdTyaX86fGqbGWheBhNz
         ngwW8J1NQ02VFoPhzXsf/V+z1N2k3YLZadRrEQG7dP238XPw3Gx3hrLSbkEqme1wuK8L
         pre2Zgbw0qsExNK0aTLJS3CK9pO15JoTrevab+jhSbfmvwRgdavWMq2wmwzySsJV1v8O
         wWbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ZZTjvHZCe7fz2iM0dCm7xDiOZP2+Yg+RhUYKbP1pg4E=;
        b=o4lvxIVFu4I+UDiQ+1wPZG3cSmk1m7UlVZkfLqiH0FAatq3/tzPhwfxmaN2MD+sZpY
         T5ilEQVONF/hIdYhe6CGVtwgmi34lJhF30uPViu+wmCInZxgxMOZq1opofwZuOxum56G
         z4QqQ/9U0/MPyQzG80z1xgWyzEB0Ded433nf1SAkjqa5tHlcLNRXV1/vPiHMWvnNSOde
         6oMZ4JJVp0GT34XiWDQJU5AtFD1STOTQ/82/iCKJZXmILQn9qGKwsx6w8/SqfnFXO9bN
         P6faz9KQ8RUipT/te8CAWmdRJ+VsFcDPKDmL2VNQwZ60Tlo+0U5GDIoXYBUBTKIvLVFn
         t3Zw==
X-Gm-Message-State: AOAM530/eF+drbviSXTUNX6NhWylEfi46smWlFuIBEFVPQn2SW6Bri9L
        Q3TyhL4BPdAcig3Cqo7/eHkr83dOM1ASMQ==
X-Google-Smtp-Source: ABdhPJywmqzKE3HIUf0XcpsoUvzsg5+8lr42t3hrKnqAmpk/nqk27W39Vkq+BeuIkB/O68hotdh71g==
X-Received: by 2002:a05:6a00:1988:b0:4fa:c15d:190d with SMTP id d8-20020a056a00198800b004fac15d190dmr533212pfl.44.1650559663644;
        Thu, 21 Apr 2022 09:47:43 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:2c86])
        by smtp.gmail.com with ESMTPSA id d20-20020a056a00199400b005060849909esm28105085pfl.176.2022.04.21.09.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 09:47:42 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 21 Apr 2022 06:47:41 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Jirka Hladky <jhladky@redhat.com>
Cc:     Minchan Kim <minchan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        regressions@lists.linux.dev,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Justin Forbes <jforbes@fedoraproject.org>
Subject: Re: PANIC: "Oops: 0000 [#1] PREEMPT SMP PTI" starting from 5.17 on
 dual socket Intel Xeon Gold servers
Message-ID: <YmGKrd1BR9HSEy6q@slm.duckdns.org>
References: <536eca11-b4b9-c1a8-6e6b-fcd0c339a3ec@leemhuis.info>
 <CAE4VaGBZk2NL6Tn2fGxmGMR-n8KFNqgPOktY_sQ1vjViLDNhhg@mail.gmail.com>
 <CAE4VaGB4=aCd8iDb4EduR+-5QTSgVWd5sxrnBA4e3g9dPrnuBg@mail.gmail.com>
 <YkTxox8ZQIDtojfU@google.com>
 <CAFxkdAq6r2WnwML-pPfdZiajaYZCEcUU3GrXW=+wsA7CxGnJdQ@mail.gmail.com>
 <CAE4VaGBchOMWeHQ8GKiGFv_aCaNGLEvSdLWXZTpE+qC=0bgM3A@mail.gmail.com>
 <YkY6W1NS+1RTw0VB@google.com>
 <CAE4VaGDAMZqjwumyvbityzEiK30=5a5vuDMjaS+UHM39R-oPRw@mail.gmail.com>
 <YkstxbC3OfzYnSRw@google.com>
 <CAE4VaGAQZcQzN8D+iwcBnP5vY=Ctmbh+oTikvONHir6JjTgpsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE4VaGAQZcQzN8D+iwcBnP5vY=Ctmbh+oTikvONHir6JjTgpsw@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry about late reply.

On Wed, Apr 20, 2022 at 10:02:20AM +0200, Jirka Hladky wrote:
> > Based on your report, kernel was crashed due to kn_mondata was NULL
> >
> >   rdt_kill_sb
> >     rmdir_all_sub
> >       ..
> >       kernfs_remove(kn_mondata);
> >         struct kernfs_root *root = kernfs_root(kn); <-- crashed
> >
> >
> > Before the my patch[1], it worked like this.
> >
> >   rdt_kill_sb
> >     rmdir_all_sub
> >       ..
> >       kernfs_remove(kn_mondata);
> >         down_write(&kernfs_rwsem);
> >           if (!kn)
> >             return;
> >         up_write(&kernfs_rwsem);
> >
> > IOW, before, kernfs_remove worked with NULL argument via just bailing
> > but with the my patch[1], it doesn't work any longer.
> >
> > It makes me have questions for kernfs maintainers:
> >
> > Should kernfs_remove API support NULL parameter? If so, can we support
> > it atomically without old global kernfs_rwsem?
> >
> > [1] 393c3714081a, kernfs: switch global kernfs_rwsem lock to per-fs lock

Yes, I mean, kernfs_remove() used to support NULL arg, so it should do the
same after the locking change too. Can you send a patch?

Thanks.

-- 
tejun
