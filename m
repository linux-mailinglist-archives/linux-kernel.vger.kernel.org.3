Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B731354FDEF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 21:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242761AbiFQTyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 15:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiFQTyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 15:54:08 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E022E9DA;
        Fri, 17 Jun 2022 12:54:07 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id y32so8415160lfa.6;
        Fri, 17 Jun 2022 12:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=02rUpC1JaF7EaBeJHvEU6ZBWvHsGGlNTq1EAsa26d+U=;
        b=qKuKUQO/dcX5z9teCBIMgIMk3uOFQJLA3kHLgJnf3nxxZ7xzS/DXSwQhi0dsCujAcf
         3BXckUda/elXHotAMIpNINg170iI42nMz4NCxKxIaqXZ5C7V1x3pV2rKW2kIyEXBbQdS
         l46xTw46DtID6yKeA7MEPDIFrok8wY0EntHqq/Sy/eP2oT5dfG8MsjG2vVz0UbF5jq6o
         /XmaSdi3IZnBNmzrEivxuZqSOeMTxakgYM4UL8r+FwVQiAzkP8jH7KO3cYeT/dU9DH2o
         ITCzXEqkEBMx0f1eo5mpo4XCURBWxCA1XCQSxHspUeV7C1G5Rf15NmQe1KvSjmcA7wyV
         G7CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=02rUpC1JaF7EaBeJHvEU6ZBWvHsGGlNTq1EAsa26d+U=;
        b=JlLjKdOPfaO6M0JcRiwhdnToMgWYmGQGlUylxVj0EOV4EqDh2bnRDXVx19AyCAdaEY
         7kZuOCugaA4aaxFI0Ij8LxKW/MFbgtOap71IJAYkT+XVQ8ofFV4o1OCGz9AVDiQorBGS
         26OtwcgfCmgKk4WbJ8V3MXYCOzcqyMQ3jH7lwhrMD7sSG5AhAXjdEQl3MxruZL7ZE0kv
         8En4YPOhkGaJH2D+Ulfb+PakWajwkKO6vapkFJjs5ZCLFtd/i+w2WtW3SFoOvsQoGQW9
         mogFKbB+cf9RJeDV6OGxDhKfpH+Kqcxikh26VqxZZM9tFSHGHDzev+LJv5ZTzHHsxVCE
         AKUQ==
X-Gm-Message-State: AJIora9cvLleZRWlPql3f0QsSmcS+2T7lKwZ0pwa5l2bsEtkELC3POZf
        gjMr3wjQAjSTuF9WkeuwwhE=
X-Google-Smtp-Source: AGRyM1scl8XJBZO2QfldF/lmnmDPuZMn9aZDccuJGjXCRN2CeOWsSuAYogHMxuezZr/3ib1KJwEHmw==
X-Received: by 2002:ac2:4314:0:b0:47e:53ff:7db with SMTP id l20-20020ac24314000000b0047e53ff07dbmr6548634lfh.118.1655495645696;
        Fri, 17 Jun 2022 12:54:05 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id g18-20020ac24d92000000b0047f523ae57csm381524lfe.17.2022.06.17.12.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 12:54:05 -0700 (PDT)
Date:   Fri, 17 Jun 2022 22:54:03 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 07/23] ata: libahci_platform: Convert to using devm
 bulk clocks API
Message-ID: <20220617195403.wbqy5ozm6x7tq3dh@mobilestation>
References: <20220610081801.11854-1-Sergey.Semin@baikalelectronics.ru>
 <20220610081801.11854-8-Sergey.Semin@baikalelectronics.ru>
 <3bf20887-6e2f-41f4-e4ec-5c2278f6cb18@opensource.wdc.com>
 <20220615204509.siz54h4vbgvb3zkm@mobilestation>
 <0dcebae2-5e4e-a0d3-181d-37bb9b40d564@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0dcebae2-5e4e-a0d3-181d-37bb9b40d564@opensource.wdc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 09:23:28AM +0900, Damien Le Moal wrote:
> On 2022/06/16 5:45, Serge Semin wrote:
> [...]
> >>> +		hpriv->clks = devm_kzalloc(dev, sizeof(*hpriv->clks), GFP_KERNEL);
> >>> +		if (!hpriv->clks) {
> >>> +			rc = -ENOMEM;
> >>> +			goto err_out;
> >>> +		}
> >>> +		hpriv->clks->clk = devm_clk_get_optional(dev, NULL);
> > 
> >>> +		if (IS_ERR(hpriv->clks->clk)) {
> >>> +			rc = PTR_ERR(hpriv->clks->clk);
> >>> +			goto err_out;
> >>> +		} else if (hpriv->clks->clk) {
> >>
> >> Nit: the else is not needed here.
> > 
> > Well, it depends on what you see behind it. I see many reasons to keep
> > it and only one tiny reason to drop it. Keeping it will improve the
> > code readability and maintainability like having a more natural
> > execution flow representation, thus clearer read-flow (else part as
> > exception to the if part), less modifications should the goto part is
> > changed/removed, a more exact program flow representation can be used
> > by the compiler for some internal optimizations, it's one line shorter
> > than the case we no 'else' here. On the other hand indeed we can drop
> > it since if the conditional statement is true, the code afterwards
> > won't be executed due to the goto operator. But as I see it dropping
> > the else operator won't improve anything, but vise-versa will worsen
> > the code instead. So if I get to miss something please justify why you
> > want it being dropped, otherwise I would rather preserve it.
> 
> An else after a goto or return is never necessary and in my opinion makes the
> code harder to read. I am not interested in debating this in general anyway. For
> this particular case, the code would be:
> 
> 		hpriv->clks->clk = devm_clk_get_optional(dev, NULL);
> 		if (IS_ERR(hpriv->clks->clk)) {
> 			/* Error path */
> 			rc = PTR_ERR(hpriv->clks->clk);
> 			goto err_out;
> 		}
> 
> 		/* Normal path */
> 		if (hpriv->clks->clk) {
> 			...
> 		}
> 
> Which in my opinion is a lot easier to understand compared to having to parse
> the if/else if and figure out which case in that sequence is normal vs error.
> 

> As noted, this is a nit. If you really insist, keep that else if.

Ok. I'll leave it as is then.

Thanks
-Sergey

> 
> > 
> > -Sergey
> > 
> >>
> >>> +			hpriv->clks->id = __clk_get_name(hpriv->clks->clk);
> >>> +			hpriv->n_clks = 1;
> >>>  		}
> >>> -		hpriv->clks[i] = clk;
> >>>  	}
> >>>  
> >>>  	hpriv->ahci_regulator = devm_regulator_get(dev, "ahci");
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
