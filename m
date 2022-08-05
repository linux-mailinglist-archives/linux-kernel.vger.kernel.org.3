Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B20058ADCC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 18:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240891AbiHEQBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 12:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241204AbiHEQAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 12:00:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A81CE05
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 09:00:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5A7EBB8298B
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 16:00:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3D44C433D6;
        Fri,  5 Aug 2022 16:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659715240;
        bh=c+fi7AbyqkhrR/hj0aBsLFSOsB+EsXY/7TkE9VQUuCE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r78crHJXcYmMXxBxK6C7Wor3XuPgsemB6ViA7uOl1HIprOO16YX8/4tsNGHnPYWwT
         YlpX5qvqauiIvr4Qr6PbJALKsAK/fgt9iZtJXOy4J38Q4xIYDvsMoXFMoaXOLlGTWT
         7DZA0HQk3WloL8yETNJbgOpLwG8K+c3vtr9kV07Pjk5i6zCk/iFtm94HG8KuTO+vzd
         vRth8MNmVBnbv1+43eVUMm3rU12jpYssHwcxDgjEX4Vu5/fPzaj9xyUGM4s69StnO6
         mcuz9mI9KSAb+MM6iimKABVf4ghzzjRalLXSxT8iOupUIvhZfFVq5hE3edn7gJfX9i
         8pEDwWa+RJEzA==
Date:   Fri, 5 Aug 2022 17:00:35 +0100
From:   Will Deacon <will@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        maz@kernel.org
Subject: Re: [GIT PULL] arm64 updates for 5.20
Message-ID: <20220805160034.GA29654@willie-the-truck>
References: <20220729102205.GA24050@willie-the-truck>
 <CAHk-=wj=CQsmGPzDUZjey3DoMFsiCqn-O6kmCv6ZCW0AoO=kOg@mail.gmail.com>
 <20220802090000.GD26962@willie-the-truck>
 <CAHk-=wgcDUd-vGTTBN8UQJN7OyiDWvJy6udg3O0BFodkut1EkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgcDUd-vGTTBN8UQJN7OyiDWvJy6udg3O0BFodkut1EkQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2022 at 07:55:38AM -0700, Linus Torvalds wrote:
> On Tue, Aug 2, 2022 at 2:00 AM Will Deacon <will@kernel.org> wrote:
> >
> > Seriously though, if you could share any details about exactly how you're
> > running this (e.g. in a VM or native, .config, any extra patches on top)
> > then we could probably mimic it in CI to avoid any last minute surprises
> > with the pull requests.
> 
> So my setup is basically an 2022 M2 Apple Macbook Air, with a Fedora
> spin of Asahi.
> 
> I run it natively, but because not all of the Asahi kernel patches are
> in, currently I end up with two trees (exactly like my main desktop,
> actually): one that is my plain kernel that I run allmodconfig builds
> on, and a separate tree for "local boot testing".
> 
> That "local boot testing" tree is basically the same tree except I
> merge in the Asahi kernel to get the drivers (that aren't upstream yet
> (it's 150+ patches for iommu, HID, GPIO, wireless, power, and dts
> files).
> 
> The asahi side doesn't contain any actual architecture changes
> (outside of the dts files).

Thanks for the details, that sounds like it should be a reasonably
straightforward setup to repro locally at least.

Now to expense one of these fancy toys...

Will
