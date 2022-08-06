Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC95358B633
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 16:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbiHFOpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 10:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbiHFOpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 10:45:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54ECE020;
        Sat,  6 Aug 2022 07:45:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 604776109A;
        Sat,  6 Aug 2022 14:45:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8B8DC433D6;
        Sat,  6 Aug 2022 14:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659797104;
        bh=jEFWSRkjcPJjtn2ZeKa0q1VbeEaRotlPyr2tjOftR/U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HBhEvfP/RFNqVewgkGusiDopy4wrLQ5mCcD9MCDGHLlu0B+XCFh5lJGW1AToL36DL
         8YncidWabZftcLcAtfHGvVohfZhPkmOZhlcVic2AyhiKBsrAvEQyPpkud5LpPCr1wK
         tfWJ31ShtFJOzzWM5gPLfEefNtUfJZ8pqb2n3LZCMixdlV0amtn4EMUVDuOVxhrLBP
         8JFOoYD3aNc42ObiJG3Pj5C5acBPwH84guQq61bx5n1Gh9GlhdWiWSDJUr+ziRTcDN
         fA9Mj+nnCGo5J7YWePP+kf3w0Sb6o8lsgBqupY/8OPiycxJoaBX42ijXdnpwItFafi
         RDV9F9z47hmkA==
Date:   Sat, 6 Aug 2022 15:55:23 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dmitry Rokosov <DDRokosov@sberdevices.ru>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "stano.jakubek@gmail.com" <stano.jakubek@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "stephan@gerhold.net" <stephan@gerhold.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/3] iio: add MEMSensing MSA311 3-axis accelerometer
 driver
Message-ID: <20220806155523.37c3e587@jic23-huawei>
In-Reply-To: <20220803191621.tzrmndkygfe7nlpx@CAB-WSD-L081021.sigma.sbrf.ru>
References: <20220803131132.19630-1-ddrokosov@sberdevices.ru>
        <20220803131132.19630-3-ddrokosov@sberdevices.ru>
        <CAHp75VcVuC6yVoB1kycCOfqMa=JfCtbe3WYSK5qndtYcJy3vpg@mail.gmail.com>
        <20220803191621.tzrmndkygfe7nlpx@CAB-WSD-L081021.sigma.sbrf.ru>
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


> 
> [...]
> 
> > > +               return dev_err_probe(dev, err, "cannot enable push-pull int\n");  
> > 
> > interrupt  
> 
> It will be more ugly due 80 symbols restriction.

These days we let that stretch a little for cases like these.

> 
> > > +       indio_dev->modes = 0; /* setup buffered mode later */  
> > 
> > Why explicit assignment to 0? Doesn't kzalloc() do it for you?  
> 
> kzalloc() will do it for me, of course. Previously, I initialized modes to
> INDIO_DIRECT_MODE to just provide default value for that. Jonathan
> suggested to replace it with 0. 

I did?  I wonder what I was smoking that day. 
Should be set to INDIO_DIRECT_MODE as you had it previously.

(From what I recall it will work either way but we have in the past had
core code that checked this and may do again in the future so drivers should
still be setting it to specify they provide sysfs interfaces to directly read
the channels).

> I can remove this line at all, no problem.
> I just thought, it's more readable.
