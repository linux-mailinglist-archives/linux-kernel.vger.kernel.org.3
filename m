Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E694AA752
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 08:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379579AbiBEHbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 02:31:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239851AbiBEHbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 02:31:46 -0500
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FF1C061346;
        Fri,  4 Feb 2022 23:31:45 -0800 (PST)
Received: by mail-ua1-x930.google.com with SMTP id e17so14555426uad.9;
        Fri, 04 Feb 2022 23:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WbyfaMqzZXhO0umDixLaEVZrBVE9+22ohPkmZGUA6cg=;
        b=ox1zgBxjwk68T8/e6T05OVzldw84Tk/UPt04CUVsYlVVII3bjGqd3WDzv6StX+ncr5
         c/AbmMRmRL1dM/Y/XyQvKXhonojFhy50NeMeQpkUbuHUruo9kX9sE03vWBX91EP+HfHQ
         CMJ9jxSO9IrYdmm5qaD3MEnHqljcd4Ssu3uWs/WH8Rbt1W1Ere471TXJyPg+9FXv787/
         dVre0snfzwBZQVhs6wVzyc4XOb/LnPqO9w4DAISumu4VfRE7U93gAt/bdre7jh44pqwn
         0d+YcV+76/YnmtUqnDaEflCkOqMgd6OECdnGlQUPTvpMyzI/G9KR9RQUAJ6J+h4t6Zve
         g0aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WbyfaMqzZXhO0umDixLaEVZrBVE9+22ohPkmZGUA6cg=;
        b=Wk43FgZHGBo9b0kFvci70s4RxBNAHTtjK0mCCJ/+Ae1gcdO5oyfubE9+ferY1hsXRt
         n6QUWrWqjts8BIuOrbwMVD/PPHxsxYtL2+dC743UGG0tJAB0nLW7tMinogM27CokgQd+
         hrOj0gACyORXPVlhbtgzG7cCGHoHMJyKuG/+YlJJY9oZRRUcNqHwqoxb/jIJSJ4ToUvB
         zwAx/aa2AjwMaSasPZMQlIOo3uK1bqWfki37W83QgH5mq+GSrd3R5Zxhv7Um/RcJZH2E
         oJg/OKjkrXJJOucOcxq7ey3vyAd8fTQ3pXsz4riwMJGIypgEy5/j+OSjJnomrgd0XRS2
         YZ0A==
X-Gm-Message-State: AOAM530gcX9H7rJjGIBZQY+saqi3ZewaDAf/jdjcEnkwLxacxP7CNXLW
        MITf8ODxcR1BDy19kiA+C3LeDD8r5Pghn1eBQDz4tZWKKU8=
X-Google-Smtp-Source: ABdhPJyyHjkmV21JQdIe0QvNFhVw2HYFIbG7H6USFrmQbTy8rjGuwn0riyfm1/0ggMyobR6SPJMphu5k8OAQhmlIJJw=
X-Received: by 2002:a67:cb84:: with SMTP id h4mr2045413vsl.1.1644046304748;
 Fri, 04 Feb 2022 23:31:44 -0800 (PST)
MIME-Version: 1.0
References: <20220110114930.1406665-1-sergio.paracuellos@gmail.com>
 <YfE5MOkQRoHQV7Wf@kroah.com> <CAMhs-H8s0d=PswQDR86Tq-bQt634Z6rdFYHTE+DFepsthmKAYA@mail.gmail.com>
 <YfE7LNFuf79i3oAQ@kroah.com> <CAMhs-H9c8zF=v2tu5Y1OsFRP6esOi5zrUceqS_OUiJ=MSfCvRQ@mail.gmail.com>
 <20220205025548.AA1BBC004E1@smtp.kernel.org>
In-Reply-To: <20220205025548.AA1BBC004E1@smtp.kernel.org>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Sat, 5 Feb 2022 08:31:33 +0100
Message-ID: <CAMhs-H82J5DC+m0V==tQKKYyqsu30kGLkdUbMRU+nsyLb8sL3Q@mail.gmail.com>
Subject: Re: [PATCH v8 0/4] clk: ralink: make system controller a reset provider
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        John Crispin <john@phrozen.org>, linux-staging@lists.linux.dev,
        NeilBrown <neil@brown.name>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 5, 2022 at 3:55 AM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Sergio Paracuellos (2022-01-26 04:45:31)
> > On Wed, Jan 26, 2022 at 1:14 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Wed, Jan 26, 2022 at 01:08:52PM +0100, Sergio Paracuellos wrote:
> > > > On Wed, Jan 26, 2022 at 1:06 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > On Mon, Jan 10, 2022 at 12:49:26PM +0100, Sergio Paracuellos wrote:
> > > > > > Hi all,
> > > > > >
> > > > > > This patch series add minimal change to provide mt7621 resets properly
> > > > > > defining them in the 'mediatek,mt7621-sysc' node which is the system
> > > > > > controller of the SoC and is already providing clocks to the rest of
> > > > > > the world.
> > > > > >
> > > > > > There is shared architecture code for all ralink platforms in 'reset.c'
> > > > > > file located in 'arch/mips/ralink' but the correct thing to do to align
> > > > > > hardware with software seems to define and add related reset code to the
> > > > > > already mainlined clock driver.
> > > > > >
> > > > > > After this changes, we can get rid of the useless reset controller node
> > > > > > in the device tree and use system controller node instead where the property
> > > > > > '#reset-cells' has been added. Binding documentation for this nodeq has
> > > > > > been updated with the new property accordly.
> > > > > >
> > > > > > This series also provide a bindings include header where all related
> > > > > > reset bits for the MT7621 SoC are defined.
> > > > > >
> > > > > > Also, please take a look to this review [0] to understand better motivation
> > > > > > for this series.
> > > > > >
> > > > > > Regarding the way of merging this:
> > > > > >  - I'd like patches 1 and 4 which are related going through staging tree.
> > > > >
> > > > > Patches 1 and 4 now in the staging tree, thanks.
> > > >
> > > > Stephen wanted all to go through the CLK tree since PATCH 3 and 1 were
> > > > also a dependency... Can we get all of them through the same tree,
> > > > then? I am ok with both CLK or staging trees.
> > >
> > > That's fine with me if they all go through the CLK tree, but there will
> > > be a merge issue that I already fixed up in my tree.  If you want me to
> > > drop them, just let me know.
> >
> > Stephen, what do you prefer? Is it better all going through staging-tree then?
> >
>
> Sure take them through staging tree.
>
> Acked-by: Stephen Boyd <sboyd@kernel.org>

Thanks, Stephen.

Greg, can you please take remaining patches 2 and 3 through your tree, then?

Thanks in advance for your time.

Best regards,
    Sergio Paracuellos
