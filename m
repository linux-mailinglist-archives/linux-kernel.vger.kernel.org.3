Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02D76550774
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 01:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234075AbiFRXVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 19:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiFRXVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 19:21:34 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DAD7B4B1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 16:21:33 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 7CDA483F22;
        Sun, 19 Jun 2022 01:21:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1655594491;
        bh=dmmCpk6maTBunXVd1RMmiK9EcOL3EPybx4/p7OuPx0k=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=snN9aXggYPoN0HPbL0pnm6GsPpBDHwy88PYo++Q3PhVKDgbxn9k6za3rVdfvD2wY5
         WKSGyOtfVq7tyXYdrrDY/Jz2al/27OBxQm6xzsTPw+fP2hIqimpKZtlUAv45SaMcZX
         7LagEU9m7iIFaVX+QMjIiYeGM9k/9W+e6irnld3rQPxWYNQDgbze9A7f00cj4gbMmr
         3mg5i+ZBBXNUlZkMW5CDTlYakpBnaiqEzSq2ATgJ+S0TsAZYmYiTdQ9ndgYthYlvSI
         Xlj915I9DnlIjWfOURA4DEbSUQBVBzrEmljDBKaRYzTR5KZzy3qKhKpb2ibgKzkWcq
         Pg/07VqF/y/wQ==
Message-ID: <6f3f2995-0352-be7f-d7dd-3ee617bf0576@denx.de>
Date:   Sun, 19 Jun 2022 00:58:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 2/3] regmap: Make regmap_noinc_read() return -ENOTSUPP if
 map->read isn't set
Content-Language: en-US
To:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <20220616073435.1988219-1-javierm@redhat.com>
 <20220616073435.1988219-3-javierm@redhat.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20220616073435.1988219-3-javierm@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.5 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/16/22 09:34, Javier Martinez Canillas wrote:
> Before adding support to define bulk read/write callbacks in regmap_config
> by the commit d77e74561368 ("regmap: Add bulk read/write callbacks into
> regmap_config"), the regmap_noinc_read() function returned an errno early
> a map->bus->read callback wasn't set.
> 
> But that commit dropped the check and now a call to _regmap_raw_read() is
> attempted even when bulk read operations are not supported. That function
> checks for map->read anyways but there's no point to continue if the read
> can't succeed.
> 
> Also is a fragile assumption to make so is better to make it fail earlier.
> 
> Fixes: d77e74561368 ("regmap: Add bulk read/write callbacks into regmap_config")
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

Reviewed-by: Marek Vasut <marex@denx.de>
