Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04203550772
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 01:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbiFRXVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 19:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbiFRXVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 19:21:34 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2102FDFE8
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 16:21:34 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 541DB84287;
        Sun, 19 Jun 2022 01:21:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1655594492;
        bh=ECixVEIXYDf/N355Xq804C3+wlcxnnlAleX9d7xrpJ4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZpVxtyUH9SpnmIBt6Sqc+j7sOeAEEdGbJbl3VY1/aohByJsDj695TLvTzlrcoA6Fj
         WsOHLYZjtQpOxYRSZXGzoHauISLD+Csybz+ge0N83MMizHX2nBjXwqghdLVQSkpQmB
         75U3E24Ub0iwt7TdSQrX9zgZfJ+CrZScktiV10V+ANKJiykPh40PIuAIet7C6L46qg
         qHep6DaZgQzobnUtbZnIAZ2b3GW5r37J4+Ui1iKeutMMPylR1LfkcvsUdUfMiRIO8c
         054C9NXUiFgfl68wPlnhBQj84PE+yJKeztC7MTkG3A1trqMF4DwXG40JFi1mH/nhmd
         PukxOAxHV0/KA==
Message-ID: <5b6e5103-8ca8-87d6-27fc-243b4a6d5689@denx.de>
Date:   Sun, 19 Jun 2022 01:02:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 3/3] regmap: Wire up regmap_config provided bulk write in
 missed functions
Content-Language: en-US
To:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <20220616073435.1988219-1-javierm@redhat.com>
 <20220616073435.1988219-4-javierm@redhat.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20220616073435.1988219-4-javierm@redhat.com>
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
> There are some functions that were missed by commit d77e74561368 ("regmap:
> Add bulk read/write callbacks into regmap_config") when support to define
> bulk read/write callbacks in regmap_config was introduced.
> 
> The regmap_bulk_write() and regmap_noinc_write() functions weren't changed
> to use the added map->write instead of the map->bus->write handler.
> 
> Also, the regmap_can_raw_write() was not modified to take map->write into
> account. So will only return true if a bus with a .write callback is set.
> 
> Fixes: d77e74561368 ("regmap: Add bulk read/write callbacks into regmap_config")
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

Reviewed-by: Marek Vasut <marex@denx.de>
