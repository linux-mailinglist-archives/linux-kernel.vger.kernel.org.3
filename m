Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D977E48879F
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 05:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233609AbiAIETP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 23:19:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232702AbiAIETO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 23:19:14 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17EEC06173F;
        Sat,  8 Jan 2022 20:19:13 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id q3so10630291qvc.7;
        Sat, 08 Jan 2022 20:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Pv1VMB3UK5CE8tf/eD+Si73gNpKIJQe0lW8e2LuK7OA=;
        b=KA0XOyBS24UXGIoDjBBsqVRIpGbnE09XxMfnWoU4dzJNawi3xI3EzTkws4qDOYogMU
         6oDcLXGQruLxVP5kd8bL1bH0DCeU3UZN7+dIce9Y7NCNAn0TA9n1+B39xLMRsMRBxXlE
         TGRCX9vq3kv1BaoGGpY2CqreAqpQi9nAZvao2BRMpnszweMiM02uhFS8NCzwrYwEn3uq
         UPp67ge/YouYGFTXegYhk6kXOsL4pK+sJjhrTYqtXu5tKMm7ZCMJeoZcMQcCTYo9d2mz
         yxOyR0J9qAnt4T1iIfnPSm7F+9YN2ul3H4a9gr4QtTirjMkzPDgo4DjT7Hym+3wryLns
         itpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Pv1VMB3UK5CE8tf/eD+Si73gNpKIJQe0lW8e2LuK7OA=;
        b=Ljw6dXQuq3w7NnRJ4qpcMrw8+F4mErfsBPgmwlsVROk/ODlfhb9fWhDgJvqG67hfA2
         j7ZcgLo8+w5hk/mIK/KY8h0nYEZaR74anrHJDoNhZO8t8xIrfcBMJpAFqc3pZPIsd5cE
         /Mw3mMRzyXicjqTBPXYJWUTfgfl7l/pu9aH8CQon18kPUTRgBGbglMzQDRRYvwt2Uqab
         G3n+QujJBpfjDaRfMekJTSbqcNkttzfouBH+pjA2kGFwXTBWDUEzDMqWee9Mc4Givj0R
         HOeQni+OgHcEp5GnbynZ9h58Dkbak0/jrDYfqWMgtCKXEh4fkC73ayI4vrwuE/DgVum4
         pwqQ==
X-Gm-Message-State: AOAM5331332L+ojX2/WiwHWhXXPhlgCcY79haWSLnVAxwQyi4rTzCLyc
        SltmoZIuDofIkSLQu6V2ABX5w9ccJ3c1bg==
X-Google-Smtp-Source: ABdhPJyUHziSgOWO472h30fHVOjV7z4WhGGiABOcemLxocK2U3SiZq6DIbG1uHbE6l4B/NXcwPeFug==
X-Received: by 2002:a05:6214:20e8:: with SMTP id 8mr60396985qvk.67.1641701952989;
        Sat, 08 Jan 2022 20:19:12 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id v12sm2142965qkl.50.2022.01.08.20.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jan 2022 20:19:12 -0800 (PST)
Date:   Sat, 8 Jan 2022 23:19:05 -0500
From:   "Gabriel L. Somlo" <gsomlo@gmail.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        Kamil Rakoczy <krakoczy@antmicro.com>,
        Maciej Dudek <mdudek@internships.antmicro.com>,
        Paul Mackerras <paulus@ozlabs.org>, rdunlap@infradead.org,
        andy.shevchenko@gmail.com
Subject: Re: [PATCH v9 3/3] mmc: Add driver for LiteX's LiteSDCard interface
Message-ID: <YdpiOaJLJN7lOadu@glsvmlin.ini.cmu.edu>
References: <20220108161134.2419279-1-gsomlo@gmail.com>
 <20220109025042.1537-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220109025042.1537-1-hdanton@sina.com>
X-Clacks-Overhead: GNU Terry Pratchett
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 09, 2022 at 10:50:42AM +0800, Hillf Danton wrote:
> On Sat,  8 Jan 2022 11:11:34 -0500 Gabriel Somlo wrote:
> > +
> > +	/* LiteSDCard can support 64-bit DMA addressing */
> > +	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
> > +	if (ret)
> > +		return ret;
> > +
> > +	host->buf_size = mmc->max_req_size * 2;
> > +	host->buffer = dmam_alloc_coherent(dev, host->buf_size,
> > +					   &host->dma, GFP_DMA);
> 
> GFP_DMA can not make much sence given the above comment.

I'll change it to GFP_KERNEL in v10. Thanks for catching that,
--Gabriel
