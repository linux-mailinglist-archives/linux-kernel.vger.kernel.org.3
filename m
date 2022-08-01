Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11961587277
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 22:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234247AbiHAUuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 16:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233921AbiHAUuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 16:50:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF52D5FA7;
        Mon,  1 Aug 2022 13:50:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 68D10B81693;
        Mon,  1 Aug 2022 20:50:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1987AC433D6;
        Mon,  1 Aug 2022 20:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659387017;
        bh=GWDH/MBhC6DxM10eEHhv53g9zopJp+n1XzbvYqNJv64=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qgMCGfwMbs4NN5jXIPFLlTw4ZwYnhSJG0xmiuoxmGDBgr23o8iuoNqhk4c5WrKTTA
         A39CGcWflw45LSo5iyWPIcvpymhcs13lKKKpmypj2QxltzlK9HVhvi9SFgHHqxaJOe
         lbCA7IayxKQrUqY4LoZ3k1i+5RSuGnaDlZcpCF4DHY1YqhHO6GolNmdDbO/1uwenoc
         ItI58dACX5ADrbMRKgQQADrZLVFXfupe53s0kYxx0Cg0BbgM87Mph2shO/rNH/Apek
         Ea9+a3m2Zdx8tdW9R2BO5TYVCCJm0COzBiM8mmqzyjonY0MG4m6AaXcq/7wS4m5lzr
         r4u5I0eyxgRlA==
Received: by mail-yb1-f182.google.com with SMTP id p71so2538971yba.9;
        Mon, 01 Aug 2022 13:50:17 -0700 (PDT)
X-Gm-Message-State: ACgBeo3bv5QBTtdRLxsUvn7EyMmhuH21IYe+QK/rTpEYYJCklrI4NqEz
        yvDAwsSF2oJdJhtrOPc/s6airBH0dcK+RZmrj90=
X-Google-Smtp-Source: AA6agR7B6n3bppA2HMcAG6qZsy2SmmbwUqOUZsgCGNONeZWpvlLQcK+GIhNAJZP9GYQGu9RZjET6Vke3Tshg+xpZOAo=
X-Received: by 2002:a25:8b92:0:b0:66d:553a:f309 with SMTP id
 j18-20020a258b92000000b0066d553af309mr12901013ybl.322.1659387016079; Mon, 01
 Aug 2022 13:50:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220727210600.120221-1-logang@deltatee.com> <20220727210600.120221-2-logang@deltatee.com>
 <YuKZmloAcZWY5of8@infradead.org> <CAPhsuW4jtiuNPzC2aK-Jo80X15AWdYi7HQ2n7YWqVP6Uux3hYg@mail.gmail.com>
 <215E9FEF-69F9-44AB-A5B0-FD3C8335E985@deltatee.com> <CAPhsuW4r2nz3Q62Q9CpouHmy2JNwgJZsn=ZHT3q82DE6ddhXtA@mail.gmail.com>
 <YugKGLvbnvSeJfRg@infradead.org>
In-Reply-To: <YugKGLvbnvSeJfRg@infradead.org>
From:   Song Liu <song@kernel.org>
Date:   Mon, 1 Aug 2022 13:50:05 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4Lsj5TxBxbqsWfHid_n3x=H=CwuPaFBJ0KbQ3XkgA3vQ@mail.gmail.com>
Message-ID: <CAPhsuW4Lsj5TxBxbqsWfHid_n3x=H=CwuPaFBJ0KbQ3XkgA3vQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] md/raid5: Refactor raid5_get_active_stripe()
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        open list <linux-kernel@vger.kernel.org>,
        linux-raid <linux-raid@vger.kernel.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 1, 2022 at 10:15 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, Aug 01, 2022 at 09:49:38AM -0700, Song Liu wrote:
> > We are in the merge window right now. So the timing is a little tricky. I will
> > try to send pull requests with this set as-is. Then we can do follow-ups.
>
> I can send the patch.  I don't think it's anywhere near critical enought to
> rush it into the current merge window, though.

Agreed. Let's improve it in 6.0.

Thanks!

Song
