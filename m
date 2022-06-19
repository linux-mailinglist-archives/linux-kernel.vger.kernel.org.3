Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E94E4550AA7
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 14:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236415AbiFSMiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 08:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiFSMiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 08:38:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C006477;
        Sun, 19 Jun 2022 05:38:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 618C961038;
        Sun, 19 Jun 2022 12:38:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98ADFC34114;
        Sun, 19 Jun 2022 12:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655642280;
        bh=UOBD3aWs3HXE75mbm1TrKnLQKoWVpswWnOcTLV2NNVA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lXsCtDriOQvPHoYjTkm7jflYt0G7QYg0euE17ssujQoJyia/Sd6MiidhMM1yoTI74
         ymBH7KR9CG1AYfQukUZUn6Q1KMVBb94bohrRZQBx4tzT1jK/HEaO2r3Xra73hDoGVg
         dvqVl3LajdGiiE/rvVAScLOWrdjsDV6b4vg9RLiWuXkrFdZ5DGDmJzUJX1jV2e0tnN
         O7Wywl/5D3VGw4l6+3Yp7zfvQ++NuIGFxaO83gatRkJBFO945WXUp1nfMzgE2WrXKM
         6eXgAVd+odf0eqmEyd/S6jC0hoZBf2mxTuhh+FdQ7AKtsbG88vL3DA+XFm+9HtEfEz
         QWYoEIAmJbbVQ==
Date:   Sun, 19 Jun 2022 13:47:16 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jagath Jog J <jagathjog1996@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/2] iio: accel: bma400: Add support for single and
 double tap events
Message-ID: <20220619134716.64292039@jic23-huawei>
In-Reply-To: <CAM+2EuJAyTL=JcESt8fteSy7q09nSShQKF0AMkiwdJOtHe5uPA@mail.gmail.com>
References: <20220613191706.31239-1-jagathjog1996@gmail.com>
        <20220613191706.31239-3-jagathjog1996@gmail.com>
        <CAHp75VdJ7z+GnEGEe2obd8Df5mJtNGQASf1c7WWXJVQ1Db8U4A@mail.gmail.com>
        <CAM+2EuJAyTL=JcESt8fteSy7q09nSShQKF0AMkiwdJOtHe5uPA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> >
> > ...
> >  
> > >         bool step_event_en;
> > >         bool activity_event_en;
> > >         unsigned int generic_event_en;
> > > +       unsigned int tap_event_en;  
> >
> > Should it be boolean? Or i.o.w. why does it need to be an unsigned int?  
> 
> tap_event_en is used as a bitmask. Bit 2 and 3 of tap_event_en
> are used to tell the state of the single and double tap events.
> For example bit 2 is used to indicate single tap is enabled or not.
> 
> set_mask_bits() and FIELD_GET()  is used to set and retrieve the
> required bit value so I used unsigned int.

Perhaps make that obvious by calling it

tap_event_en_bitmask ?

