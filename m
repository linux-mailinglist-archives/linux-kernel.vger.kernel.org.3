Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3354FBB3A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 13:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344213AbiDKLuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 07:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244255AbiDKLt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 07:49:57 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A4045AE4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 04:47:43 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id n11so2165463qvl.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 04:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=clUQcx1FzZV9/CrN/0nkK9UIJB8E1uPK+JxCdawkISQ=;
        b=kNwzIcC1Tu/DEZHkYHyGdcusOmnfjVckBMYeTBJInUZNKkQIp7gU+TDBFqPHaQDF8C
         ish4dQ1qK/mzhm7R/SzHz8s69Kh9c8NELUPppb3lHDg7OZQJBf1mOZ0WtmtPVxwSJMr5
         Wp7/jGKL8vEBh1loLIAUaAkW3JzzKCGEh5aXtrojCCqUxeB+P/MVC2w2bZ25+olfOK05
         h+IwHZCmGP9St3KHgy8FQEGZUcNyGs4QFlrETm28cGL1TsEqOqtgDvKf3841oU6QgutU
         z7YRmqLG2+khtrBDCpa7g+wHDTZHUCCmAcMDKY6qxNM93WZZ8Jrb6eloV09OHCbi1HB8
         0faw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=clUQcx1FzZV9/CrN/0nkK9UIJB8E1uPK+JxCdawkISQ=;
        b=klMaSn2cI8zRlxnlyUi3TEj4lxc6OvT4HokDIu4k9BU0Tovt0ZYHkYLHFFF7VTiaJ7
         cqOem/rptslfseQU9PPCBWXClROcAqh7uz70uBSeSjlbSlGDJQEqvB3s8fZjqJqxUiHF
         OngLUYvBevbVucQ//iKqf7xwZyqwmp/Lkh/GB/Rxco7Ev0XprEaIOtk7rJBKl8zUrpKx
         gdBR3gyfpzvKd5QKYop5LgFSohj11ufGIEOa+DQI3AFFiWG2k2N3hEOYvOMcIZHT6AU0
         Q6JLm2NncFvEjQBU625BeTgTwZcYU707Me77K2Fm7cqWjiJHjiqwM88lcNZzRRtpeXbD
         YR5g==
X-Gm-Message-State: AOAM531RGGLU402q9hu39oQ09aDBxZZ5LtbvQNDLKkhO7zA9lTPYLYqS
        8aU42ekuEqQlukwVInaOkvW74A==
X-Google-Smtp-Source: ABdhPJzkPU36RFVeX7u392AQJtCEsuNKiU4SzQV4oRld7cZwX2WbCGqmgaLTwpJDlwMCRDZTuq87aA==
X-Received: by 2002:ad4:4eaf:0:b0:441:7ff6:f639 with SMTP id ed15-20020ad44eaf000000b004417ff6f639mr26561264qvb.73.1649677662733;
        Mon, 11 Apr 2022 04:47:42 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id 3-20020ac85903000000b002ee83037459sm2089230qty.42.2022.04.11.04.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 04:47:41 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1ndsWD-00Gixt-AP; Mon, 11 Apr 2022 08:47:41 -0300
Date:   Mon, 11 Apr 2022 08:47:41 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Lino Sanfilippo <LinoSanfilippo@gmx.de>, peterhuewe@gmx.de,
        jarkko@kernel.org, =robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        stefanb@linux.ibm.com, p.rosenberger@kunbus.com
Subject: Re: [PATCH 1/5] tpm: add functions to set and unset the tpm chips
 reset state
Message-ID: <20220411114741.GA64706@ziepe.ca>
References: <20220407111849.5676-1-LinoSanfilippo@gmx.de>
 <20220407111849.5676-2-LinoSanfilippo@gmx.de>
 <20220407142526.GW64706@ziepe.ca>
 <20220410171123.GA24453@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220410171123.GA24453@wunner.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 10, 2022 at 07:11:23PM +0200, Lukas Wunner wrote:
> On Thu, Apr 07, 2022 at 11:25:26AM -0300, Jason Gunthorpe wrote:
> > On Thu, Apr 07, 2022 at 01:18:45PM +0200, Lino Sanfilippo wrote:
> > > Currently it is not possible to set the tpm chips reset state from within
> > > the driver. This is problematic if the chip is still in reset after the
> > > system comes up. This may e.g. happen if the reset line is pulled into
> > > reset state by a pin configuration in the device tree.
> > 
> > This kind of system is badly misdesigned.
> > 
> > TPM PCRs fundementally cannot work if the TPM reset line is under
> > software control.
> 
> Not every system which incorporates a TPM wants to use or is even capable
> of measuring software state of any kind or perform secure boot.
> 
> Those systems may merely want to use the TPM to store key material.

Then maybe the TPM driver should make it clear somehow that the PCRs
don't work in these systems.

It is really dangerous to add capabilities like this that should
never, ever be used in sanely designed systems.

Jason
