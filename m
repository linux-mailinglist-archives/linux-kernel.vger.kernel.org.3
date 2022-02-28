Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4CD94C708B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 16:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237524AbiB1P2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 10:28:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237520AbiB1P1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 10:27:54 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D5687811AD;
        Mon, 28 Feb 2022 07:27:15 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F133ED1;
        Mon, 28 Feb 2022 07:27:15 -0800 (PST)
Received: from [10.57.39.47] (unknown [10.57.39.47])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 00FD03F73D;
        Mon, 28 Feb 2022 07:27:13 -0800 (PST)
Message-ID: <1763f668-2582-c05e-7ac8-d635bc84ef82@arm.com>
Date:   Mon, 28 Feb 2022 15:27:08 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 1/3] dt-bindings: spi: Update clocks property for ARM
 pl022
Content-Language: en-GB
To:     Mark Brown <broonie@kernel.org>
Cc:     Kuldeep Singh <singh.kuldeep87k@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
References: <20220228124345.99474-1-singh.kuldeep87k@gmail.com>
 <20220228124345.99474-2-singh.kuldeep87k@gmail.com>
 <6e14bdd4-5924-dd58-41ef-5bdb5561913b@arm.com>
 <YhzmHgV3L+3nmt+Y@sirena.org.uk>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <YhzmHgV3L+3nmt+Y@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-02-28 15:11, Mark Brown wrote:
> On Mon, Feb 28, 2022 at 02:26:12PM +0000, Robin Murphy wrote:
> 
>> Who says that minItems is missing? Looking at the PL022 TRM[1] it seems
>> clear that SSPCLK is pretty fundamental to useful operation. If that DT ever
>> worked, it must be that the same clock is wired to both inputs, and the fact
>> that that's how the neighbouring PL011 is described is strongly suggestive.
> 
> Well, it could also be that the clock is wired to some other clock which
> is always on (which I guess is why the driver allows this in the first
> place, there's a lot of sloppy code around stuff like that in the tree).

I wouldn't say the driver "allows" it, so much as it just blindly grabs 
the first clock assuming it's SSPCLK per the binding, and thus it will 
happen to work out if the underlying physical clock is the same as, or 
equivalent to, the APB PCLK. Otherwise, it's already into some degree of 
not working properly, by virtue of reading the wrong clock rate.

Robin.
