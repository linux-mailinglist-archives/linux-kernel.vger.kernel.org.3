Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539CD54FE35
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 22:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244809AbiFQUTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 16:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239060AbiFQUTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 16:19:04 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4AD5001E;
        Fri, 17 Jun 2022 13:19:00 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id w2so2483785lji.5;
        Fri, 17 Jun 2022 13:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6CFz7/vywGyF9mFNfYc/+8/AiVUzu6xNEnAULo+5cj4=;
        b=VGT133l2psyPg5mTAIDEuZh+UdKd7/Z3XMRnRXFEyqDicC9hU6qUHURjGVWitncFWc
         PS+RD5nCh9rWet+wKtSL1Sckvr4PbNoTZCCM/nHwyu4oUe6Gio5fNH4TeBNTBpglLRmC
         IpLnE/spxqwprW0ANkKg4ZEporbixUPDLPNiFbfjTCv/rkF9oPFhifkw9yqlwfuhy7Kg
         F0LjHmz1WVn0g1zs5Exk7NwH6oDhQBw32xIvNPUdVSzivajvIwUJreqoy85X1HX3bgcx
         zmSnILFwLJ1Wz10B9bsyYfFRi2oegN7I0xjrhGJ+QUHcfL0/OwCk70njMjb4AdTVc5i7
         a93Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6CFz7/vywGyF9mFNfYc/+8/AiVUzu6xNEnAULo+5cj4=;
        b=OC7Mm/BmKcsYh8tttdBhkxgTrUwWt+yxxdsx8Osnjq97jOCpRW9dsJp1vx5y7VVdhp
         9jOoSqEkrqRc0wZ0fXMo86cwK+pX2nRCqfZKPlX0ZqfqOfezMk0tY/9x/TnCWPlxtFfM
         kSGKFn7rqDmSaoMGBACGmXmIMZcEg7rsSuCD0GNQO/z0GrBVv0asmNuTIec/sUXUkfUx
         kvTjj28Qow70PY8M9ryBjVo5oIwlE92uAhVxt3AFQcygi5bXPXo43fLquiMNcrIoxZQB
         JfQq5mF8hld1lIzFa7hAHk9gFZrYdcdBvT4iTeqmKt7L+dYOoRZvgmUZQcHCZXJbNZUa
         RbGA==
X-Gm-Message-State: AJIora/KDXF7FZ+8d2UbEE/gmhfObIjzMG4VVeMRc2nK/TT9Zaxrq2xs
        819j+ULuSlDiNWhosd5XNX4=
X-Google-Smtp-Source: AGRyM1tjqWK/Ga0CmcTpFaI3vTdeTBUf256zFlYlxlZt3o9JxQF/7DgUjvJps7MYr9l7yjHiDaxshg==
X-Received: by 2002:a2e:8897:0:b0:255:95f8:be0a with SMTP id k23-20020a2e8897000000b0025595f8be0amr5735176lji.303.1655497138625;
        Fri, 17 Jun 2022 13:18:58 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id x16-20020a2e7c10000000b00253d84812edsm659117ljc.2.2022.06.17.13.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 13:18:57 -0700 (PDT)
Date:   Fri, 17 Jun 2022 23:18:55 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 08/23] ata: libahci_platform: Sanity check the DT
 child nodes number
Message-ID: <20220617201855.cf64vbhe6wk4hrcu@mobilestation>
References: <20220610081801.11854-1-Sergey.Semin@baikalelectronics.ru>
 <20220610081801.11854-9-Sergey.Semin@baikalelectronics.ru>
 <c388835e-3bc1-a69c-82a7-6036c7adec1b@opensource.wdc.com>
 <20220615205328.chwruabvksdbnaex@mobilestation>
 <6d16fe23-012d-39fb-21e5-39ce50f7b03a@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d16fe23-012d-39fb-21e5-39ce50f7b03a@opensource.wdc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 09:25:48AM +0900, Damien Le Moal wrote:
> On 2022/06/16 5:53, Serge Semin wrote:
> > On Tue, Jun 14, 2022 at 05:23:33PM +0900, Damien Le Moal wrote:
> >> On 6/10/22 17:17, Serge Semin wrote:
> >>> Having greater than AHCI_MAX_PORTS (32) ports detected isn't that critical
> >>> from the further AHCI-platform initialization point of view since
> >>> exceeding the ports upper limit will cause allocating more resources than
> >>> will be used afterwards. But detecting too many child DT-nodes doesn't
> >>> seem right since it's very unlikely to have it on an ordinary platform. In
> >>> accordance with the AHCI specification there can't be more than 32 ports
> >>> implemented at least due to having the CAP.NP field of 5 bits wide and the
> >>> PI register of dword size. Thus if such situation is found the DTB must
> >>> have been corrupted and the data read from it shouldn't be reliable. Let's
> >>> consider that as an erroneous situation and halt further resources
> >>> allocation.
> >>>
> >>> Note it's logically more correct to have the nports set only after the
> >>> initialization value is checked for being sane. So while at it let's make
> >>> sure nports is assigned with a correct value.
> >>>
> >>> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> >>> Reviewed-by: Hannes Reinecke <hare@suse.de>
> >>>
> >>> ---
> >>>
> >>> Changelog v2:
> >>> - Drop the else word from the child_nodes value checking if-else-if
> >>>   statement (@Damien) and convert the after-else part into the ternary
> >>>   operator-based statement.
> >>>
> >>> Changelog v4:
> >>> - Fix some logical mistakes in the patch log. (@Sergei Shtylyov)
> >>> ---
> >>>  drivers/ata/libahci_platform.c | 13 ++++++++++---
> >>>  1 file changed, 10 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
> >>> index 814804582d1d..8aed7b29c7ab 100644
> >>> --- a/drivers/ata/libahci_platform.c
> >>> +++ b/drivers/ata/libahci_platform.c
> >>> @@ -451,15 +451,22 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
> >>>  		}
> >>>  	}
> >>>  
> >>> -	hpriv->nports = child_nodes = of_get_child_count(dev->of_node);
> >>> +	/*
> >>> +	 * Too many sub-nodes most likely means having something wrong with
> >>> +	 * the firmware.
> >>> +	 */
> >>> +	child_nodes = of_get_child_count(dev->of_node);
> >>> +	if (child_nodes > AHCI_MAX_PORTS) {
> >>> +		rc = -EINVAL;
> >>> +		goto err_out;
> >>> +	}
> >>>  
> >>>  	/*
> >>>  	 * If no sub-node was found, we still need to set nports to
> >>>  	 * one in order to be able to use the
> >>>  	 * ahci_platform_[en|dis]able_[phys|regulators] functions.
> >>>  	 */
> >>> -	if (!child_nodes)
> >>> -		hpriv->nports = 1;
> >>> +	hpriv->nports = child_nodes ?: 1;
> >>
> > 
> >> This change is not necessary and makes the code far less easy to read.
> > 
> > elaborate please. What change? What part of this change makes the code
> > less easy to read?
> 

> You changed:
> 
> 	if (!child_nodes)
> 		hpriv->nports = 1;
> 
> to:
> 
> 	hpriv->nports = child_nodes ?: 1;
> 
> That is the same. So the change is not needed in the first place, and worse,
> makes the code way harder to read for no good reason.

No, they aren't the same:
+	if (!child_nodes)
+		hpriv->nports = 1;
and
+	hpriv->nports = child_nodes ?: 1;
aren't equivalent. The equivalent implementation would be:
+	if (child_nodes)
+		hpriv->nports = child_nodes;
+	else
+		hpriv->nports = 1;

As I said in the patchlog, hpriv->nports is updated now only if
of_get_child_count() returns a valid number of the child nodes,
ports, which semantically is more correct. In the previous
implementation it was always set to the number of child nodes
no matter whether that value was correct or not.

Regarding the ternary operator with omitted operand. Well, it's not
that rare beast in the kernel:
$ grep -r "?:" kernel/ drivers/ mm/ fs/ block/ | wc -l
699
But if you insist in it being not that readable, I can replace it with
more bulky if-else statement. Do you?

-Sergey

> 
> > 
> > -Sergey
> > 
> >>
> >>>  
> >>>  	hpriv->phys = devm_kcalloc(dev, hpriv->nports, sizeof(*hpriv->phys), GFP_KERNEL);
> >>>  	if (!hpriv->phys) {
> >>
> >>
> >> -- 
> >> Damien Le Moal
> >> Western Digital Research
> 
> 
> -- 
> Damien Le Moal
> Western Digital Research
