Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C05C346879B
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 21:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355715AbhLDVBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 16:01:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353461AbhLDVBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 16:01:09 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CBDC061751;
        Sat,  4 Dec 2021 12:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=/nmjvTGo1bzzEFPzaiKG9A6pmVRH1jFX+omS59sPR4g=; b=lInKpEMuRAvhW2pUa0Q4eJVE78
        FJV+JIO6oW+60NZnyZhmQIO3L2uZawlFNtr5ir17/n8tsgPF+/rfsfSaEb5aFdhNQEu6XrYWZiAem
        oAHjUV23Qlu2MD4azH5THadZ47LJTV51H58cDMeBAmCCAlyXoEKIit8muR/8V3/0IKBetOTrmKxDY
        2P5kZyvS8fj8QNX3nTQFd6LT6pIfO+IsiejoSXBvXRyl7shjWAC2EYQLdZSS7xGxUsqYwbzWy1eWc
        Y0KcRJCQaGvU8Z9S/PEGoxB/DWL1IAUcBPM5DkRK132stPwxzObSZZgn/yEy/tV0UzmsOEpdgVYkI
        z0dNkjTQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mtc6E-002FvR-Qm; Sat, 04 Dec 2021 20:57:39 +0000
Message-ID: <e99ad542-14f6-2a06-a83e-c5f4e945303c@infradead.org>
Date:   Sat, 4 Dec 2021 12:57:32 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2 3/3] mmc: Add driver for LiteX's LiteSDCard interface
Content-Language: en-US
To:     Gabriel Somlo <gsomlo@gmail.com>, linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        kgugala@antmicro.com, mholenko@antmicro.com, krakoczy@antmicro.com,
        mdudek@internships.antmicro.com, paulus@ozlabs.org, joel@jms.id.au,
        shorne@gmail.com, geert@linux-m68k.org,
        david.abdurachmanov@sifive.com, florent@enjoy-digital.fr
References: <20211204204121.2367127-1-gsomlo@gmail.com>
 <20211204204121.2367127-4-gsomlo@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20211204204121.2367127-4-gsomlo@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gabriel--

On 12/4/21 12:41, Gabriel Somlo wrote:
> +MODULE_DESCRIPTION("LiteX SDCard driver");
> +MODULE_AUTHOR("Antmicro <www.antmicro.com>");

Admittedly it's not documented, but we would prefer to have some contact info
in MODULE_AUTHOR(), like an email address or a person's name.

<linux/module.h> says:

/*
 * Author(s), use "Name <email>" or just "Name", for multiple
 * authors use multiple MODULE_AUTHOR() statements/lines.
 */
#define MODULE_AUTHOR(_author) MODULE_INFO(author, _author)

> +MODULE_LICENSE("GPL v2");


Also, it's up to the MMC maintainer (Ulf), but the function signature
style that is used in this driver is not the preferred style.

E.g.:

+static int
+litex_set_bus_width(struct litex_mmc_host *host)
+{

should be

+static int litex_set_bus_width(struct litex_mmc_host *host)
+{


thanks.
-- 
~Randy
