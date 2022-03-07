Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 219674D076C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 20:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245009AbiCGTQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 14:16:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245038AbiCGTQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 14:16:39 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279527CDF9
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 11:15:40 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id bn33so21951442ljb.6
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 11:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TwTcsRMn5VZVrmgXZDV1J6sFeJgAdw8S2EoV6iZ5xnc=;
        b=dlpUNu5q4CyzmXtBLA/gOu0GC/00SF7ttDAollAbHZtk5bw2xAtIqb7CwTopnt8lf3
         AbfnSVPq9xulj/tw8AvoPmKfCZDzXeZNEVEEDbHlLhh/I5bp+zk8upvRu1BNSASuquhE
         pUQrRqiHujQApoBOt9qnNksqqhPlFfAR59MXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TwTcsRMn5VZVrmgXZDV1J6sFeJgAdw8S2EoV6iZ5xnc=;
        b=CtsiwRjIj5w6N4+QZxjFAe4Ct58sHt7MhbscnizbDaqncdMABUHJh7/Zk2BGws09MZ
         H/2MG25ylnNf2NAYum3Bm0MI7dXd1LC9Bd0T4CPdEGIBauYQ/M7G/fHubWeHfE7H0/J7
         1LFn0kRF6i+GpfQmeR90wSbXkzeba6cC+acDP3d4Q7NJw1QVzkBYYyWNMWOdoWqf70rl
         0o73zAfmqSppNcr3SS7dYCueS3QNH44ejsgbhTjefmLk+QH+R4Lm9BhyttPKV1Bj+HEe
         q9WAXVPzqm8z2iheQE6JS05WFSm0GzgX4sLhHug5EozWFrfNANgoMFt4vRpx1Hgxzjpw
         h4pg==
X-Gm-Message-State: AOAM531vWGZEIrdjKkussEuW9D0nF0lpaQyQV7DwOFZSL/y0+vm0Je3Z
        0/s3hk4ADmg6awF7xUJZGMiYhWOazAtrjwhdVbA=
X-Google-Smtp-Source: ABdhPJz45EfGv+Kzy28FY0mnsMPFsBLlWPDT862n6r2+qARtdNVHBc+zDsUa1DqugFQN+kTocTqODw==
X-Received: by 2002:a2e:9147:0:b0:246:1379:2cd4 with SMTP id q7-20020a2e9147000000b0024613792cd4mr8555170ljg.418.1646680536986;
        Mon, 07 Mar 2022 11:15:36 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id n13-20020a056512388d00b00443ecf806c5sm3000780lft.104.2022.03.07.11.15.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 11:15:36 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id n19so6914982lfh.8
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 11:15:35 -0800 (PST)
X-Received: by 2002:a05:651c:1213:b0:247:e2d9:cdda with SMTP id
 i19-20020a05651c121300b00247e2d9cddamr5310350lja.443.1646680524503; Mon, 07
 Mar 2022 11:15:24 -0800 (PST)
MIME-Version: 1.0
References: <20220228110822.491923-1-jakobkoschel@gmail.com>
 <20220307150037.GD3293@kadam> <f7ffd78aa68340e1ade6af15fa2f06d8@AcuMS.aculab.com>
In-Reply-To: <f7ffd78aa68340e1ade6af15fa2f06d8@AcuMS.aculab.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 7 Mar 2022 11:15:07 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjnsmmGdh-SZzaPD=e1rKhoBkQAF3JeVhGvpa=Gax--7g@mail.gmail.com>
Message-ID: <CAHk-=wjnsmmGdh-SZzaPD=e1rKhoBkQAF3JeVhGvpa=Gax--7g@mail.gmail.com>
Subject: Re: [PATCH 0/6] Remove usage of list iterator past the loop body
To:     David Laight <David.Laight@aculab.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Jakob Koschel <jakobkoschel@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        linux-arch <linux-arch@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergman <arnd@arndb.de>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 7, 2022 at 7:26 AM David Laight <David.Laight@aculab.com> wrote:
>
> I'd write the following new defines (but I might be using
> the old names here):

See my email at

  https://lore.kernel.org/all/CAHk-=wiacQM76xec=Hr7cLchVZ8Mo9VDHmXRJzJ_EX4sOsApEA@mail.gmail.com/

for what I think is the way forward if we want to do new defines and
clean up the situation.

It's really just an example (and converts two list cases and one
single file that uses them), so it's not in any way complete.

I also has that "-std=gnu11" in the patch so that you can use the
loop-declared variables - but without the other small fixups for some
of the things that exposed.

I'll merge the proper version of the "update C standard version" from
Arnd early in the 5.18 merge window, but for testing that one file
example change I sent out the patch like that.

          Linus
