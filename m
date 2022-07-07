Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE1356AA3A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 20:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236078AbiGGSHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 14:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235709AbiGGSHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 14:07:01 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D19B29C96;
        Thu,  7 Jul 2022 11:07:00 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id w2so6884284ljj.7;
        Thu, 07 Jul 2022 11:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=axUeb4iTA2BDqCiJ52GW7x1/dRqDKF36sU6lV1vQov8=;
        b=bacSYJkdfp6SsfvlymIFa517D97gOBP2/yQDSG2Qne1s5MVFX0RdN/60nEXeXekEU7
         ctkk8E5Q0ifqItZUInJbLtFgiQNV2asVq+hWE7Fq3lDMEANXdNEEZ+Ulcj9LYk47UYBx
         r2Aoj9z4WyhKK7w17eAZzGT+i3kfik3sBl6KGbI3dXWL7rs+tEVMYY6Q+rckUuvyszNc
         uPBP8GFiOPyg1qIeu/PomqlJ50TtajtKa9X57BUr0TGxUQn9UpXgOhYScEcolU8Lx23F
         umjniPLNejOcyLctCi9bZT4D/cRr59q748SAXYuyOsfgRu/jXyL35VRMkCvPT/Kec8Ah
         7muw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=axUeb4iTA2BDqCiJ52GW7x1/dRqDKF36sU6lV1vQov8=;
        b=cRwSv5tQ4C3iCifEwREtIsKG57i00zS9WhM/7VlquPb2tGJW6snw8tP2l3cyxw9xdk
         WZMqjWWSt355Wlerj41T2GUphFG57TL9GQLlqsZDyOxKBqcpzE5nIfTMpUercrwxHZgh
         n6cGW+rysktNsOif8YagnBWiRBFG3HJt9DKu9qfIEXBwaaJ8ujoN15W6yAX8K+sJaB0J
         KOHMm6/UVhAmBpVTiO8x1MNiiHzBJPam3VYO3iouF66dQXnR93gyELH0Vri9tV03MNRG
         IAYffAHsxMcO+0kbprlpAedBK4odylta6lZaf46SRANZvHBBQlKG2lMnX2vMzFqgNuik
         39fQ==
X-Gm-Message-State: AJIora8y6X47W+31ROglHsw1xWP/xXM4wxTHYRaOpO/DZ14ikTcMKo77
        mxJuiNVxSiJ06KN+as98Fipq32IHhzqDxg==
X-Google-Smtp-Source: AGRyM1tDVEVlintuu3U4hMbxZqiChH3jnRSIbguENbGzdejdqK7acU4AomNi69iEEp8pBQ8jQ/MMlQ==
X-Received: by 2002:a2e:3507:0:b0:25b:2e3c:bb6 with SMTP id z7-20020a2e3507000000b0025b2e3c0bb6mr28350873ljz.393.1657217218450;
        Thu, 07 Jul 2022 11:06:58 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id d7-20020a05651221c700b0047255d2111csm6936759lft.75.2022.07.07.11.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 11:06:55 -0700 (PDT)
Date:   Thu, 7 Jul 2022 21:06:49 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] eeprom: idt_89hpesx: uninitialized data in
 idt_dbgfs_csr_write()
Message-ID: <20220707180649.v73c6jgbk55gyjql@mobilestation>
References: <YsUyqwe9Caxb6k4g@kili>
 <20220706104024.GD2338@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706104024.GD2338@kadam>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan

On Wed, Jul 06, 2022 at 01:40:24PM +0300, Dan Carpenter wrote:
> On Wed, Jul 06, 2022 at 09:58:51AM +0300, Dan Carpenter wrote:
> > The simple_write_to_buffer() here is used to copy a string from the
> > user.  However the function call will succeed if it manages to read
> > just one byte anywhere within the buffer while we need the whole string
> > to be initialized to avoid using uninitialized data.
> > 
> > Fixes: cfad6425382e ("eeprom: Add IDT 89HPESx EEPROM/CSR driver")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> 
> NAK.  The strndup_user() function is too strict.  I will resend this
> using memdup_user() instead.

Thanks for the patch. Ok. I'll wait for v2 to review.

-Sergey

> 
> regards,
> dan carpenter
> 
